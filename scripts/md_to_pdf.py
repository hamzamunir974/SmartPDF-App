#!/usr/bin/env python3
"""Convert Markdown to PDF using reportlab"""

import sys
from markdown2 import markdown
from reportlab.lib.pagesizes import letter, A4
from reportlab.lib.styles import getSampleStyleSheet, ParagraphStyle
from reportlab.lib.units import inch
from reportlab.platypus import SimpleDocTemplate, Paragraph, Spacer, PageBreak, Table, TableStyle
from reportlab.lib import colors
import re

def md_to_pdf(md_file, pdf_file):
    """Convert markdown file to PDF"""
    
    # Read markdown file
    with open(md_file, 'r', encoding='utf-8') as f:
        md_content = f.read()
    
    # Create PDF document
    doc = SimpleDocTemplate(pdf_file, pagesize=letter)
    story = []
    
    # Define styles
    styles = getSampleStyleSheet()
    title_style = ParagraphStyle(
        'CustomTitle',
        parent=styles['Heading1'],
        fontSize=24,
        textColor=colors.HexColor('#1f3a93'),
        spaceAfter=30,
        alignment=1  # Center
    )
    
    heading1_style = ParagraphStyle(
        'Heading1Custom',
        parent=styles['Heading1'],
        fontSize=16,
        textColor=colors.HexColor('#1f3a93'),
        spaceAfter=12,
        spaceBefore=12
    )
    
    heading2_style = ParagraphStyle(
        'Heading2Custom',
        parent=styles['Heading2'],
        fontSize=13,
        textColor=colors.HexColor('#333333'),
        spaceAfter=10,
        spaceBefore=10
    )
    
    body_style = ParagraphStyle(
        'BodyCustom',
        parent=styles['BodyText'],
        fontSize=10,
        leading=14,
        spaceAfter=8
    )
    
    # Split content by lines
    lines = md_content.split('\n')
    
    for line in lines:
        line_stripped = line.strip()
        
        # Skip empty lines (add spacing instead)
        if not line_stripped:
            story.append(Spacer(1, 0.2*inch))
            continue
        
        # Title (# heading)
        if line_stripped.startswith('# '):
            title = line_stripped.lstrip('# ').strip()
            story.append(Paragraph(title, title_style))
            story.append(Spacer(1, 0.2*inch))
        
        # Heading 1 (## heading)
        elif line_stripped.startswith('## '):
            heading = line_stripped.lstrip('# ').strip()
            story.append(Paragraph(heading, heading1_style))
            story.append(Spacer(1, 0.1*inch))
        
        # Heading 2 (### heading)
        elif line_stripped.startswith('### '):
            heading = line_stripped.lstrip('# ').strip()
            story.append(Paragraph(heading, heading2_style))
            story.append(Spacer(1, 0.1*inch))
        
        # Page break (---)
        elif line_stripped in ['---', '***', '___']:
            story.append(PageBreak())
        
        # Regular paragraph
        else:
            # Escape special HTML characters
            line_stripped = line_stripped.replace('&', '&amp;').replace('<', '&lt;').replace('>', '&gt;')
            story.append(Paragraph(line_stripped, body_style))
    
    # Build PDF
    try:
        doc.build(story)
        print(f"✅ PDF created successfully: {pdf_file}")
    except Exception as e:
        print(f"❌ Error creating PDF: {e}")

if __name__ == '__main__':
    if len(sys.argv) < 2:
        print("Usage: python md_to_pdf.py <input.md> [output.pdf]")
        sys.exit(1)
    
    md_file = sys.argv[1]
    pdf_file = sys.argv[2] if len(sys.argv) > 2 else md_file.replace('.md', '.pdf')
    
    md_to_pdf(md_file, pdf_file)
