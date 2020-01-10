Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F22D1379C9
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Jan 2020 23:35:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727488AbgAJWfr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 10 Jan 2020 17:35:47 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:37918 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727387AbgAJWfq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 10 Jan 2020 17:35:46 -0500
Received: by mail-yb1-f196.google.com with SMTP id c13so1374799ybq.5
        for <linux-nfs@vger.kernel.org>; Fri, 10 Jan 2020 14:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=al9AW7PiGeGwKTiknMMI9dpHunApjGN++EYzlNVZUeo=;
        b=ENlQHWr5oGDrIu3dG1XpZeKDB+CSEjb/PljFnWqbCFHYNdYyD55nNschtI+6Edztu4
         XdcmruT+o0AU4fT+o9sBomlFdNFfL1xMZDaGVkuLJsySxQ4I43HB1SswNsiorWPL5tsa
         EzwFWgsZCKWAdjDkR40wf18sz3ES0Gk9irGAhnWuyQroWjXbkSBwZbvjk8piKOoCWDuE
         z6hDaVBy6RZmjdC0cmwLdSFWH7jFvin8v1HlvWwQqBxaS3s4q8ysLlaeUNUoMSKZEwp4
         hUzO6pQIcD31zDxUUcjManG4o5VHDRAXcX5yXXIaXiGAmfLQTngw3hQBXWNgibtFMDhd
         14rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=al9AW7PiGeGwKTiknMMI9dpHunApjGN++EYzlNVZUeo=;
        b=ixkLq/iBNeL/BlghmsBeFco+uc0LY0+wQvEdy9nLWa06raBQ8brS6tmkHN1Oo8lPil
         2+D9qwA013mJ+D52aKoQxVcM7+fyp+WEavGE66qCE/JN6S/RHIToh8HIsW7SCi2sKojt
         RcrceMllOlAruql4xR6P7WY0wRDjc4jzM7vbu6eNNOdezO3FA8B3ts9dTB4foBmTgaE+
         vgDbhOZImcF/eS0aVpYhnsGa9eZcSegxNcDbG/P2rH9eGXJhxcJ7DVaM1KqREPchVpMr
         DSKHZ3sL8AwNNv7cATLvM2lCnxYSRu5tVTZt9haSFWa6//plOZ3Cg7xpH6CcSskUUcHu
         kgqA==
X-Gm-Message-State: APjAAAUajzZdmNyCGKVbr8c7HN7pPH9sK2ohxXkZzKfH9nNBHBMydJCe
        R1LOprH4P7TBB1C7wcmltHs=
X-Google-Smtp-Source: APXvYqzSKRZRIKQMbdQFn6woC4zwMMsWdE7h4uQaXcNJ5fiW7SHtZZBsNbwQCePX4xX/pJUmMfm5cw==
X-Received: by 2002:a25:d4d6:: with SMTP id m205mr645326ybf.285.1578695745266;
        Fri, 10 Jan 2020 14:35:45 -0800 (PST)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id h23sm1607735ywc.105.2020.01.10.14.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 14:35:44 -0800 (PST)
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     bfields@redhat.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH 4/4] NFSD: Encode a full READ_PLUS reply
Date:   Fri, 10 Jan 2020 17:35:38 -0500
Message-Id: <20200110223538.528560-5-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200110223538.528560-1-Anna.Schumaker@Netapp.com>
References: <20200110223538.528560-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

Reply to the client with multiple hole and data segments. This might
have performance issues due to the number of calls to vfs_llseek(),
depending on the underlying filesystem used on the server.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 fs/nfsd/nfs4xdr.c | 41 +++++++++++++++++++++++++++++------------
 1 file changed, 29 insertions(+), 12 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 552972b35547..c63846729d0b 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -4270,14 +4270,18 @@ nfsd4_encode_offload_status(struct nfsd4_compoundres *resp, __be32 nfserr,
 
 static __be32
 nfsd4_encode_read_plus_data(struct nfsd4_compoundres *resp,
-			    struct nfsd4_read *read,
-			    unsigned long maxcount,  u32 *eof)
+			    struct nfsd4_read *read, u32 *eof)
 {
 	struct xdr_stream *xdr = &resp->xdr;
 	struct file *file = read->rd_nf->nf_file;
+	unsigned long maxcount = read->rd_length;
+	loff_t hole_pos = vfs_llseek(file, read->rd_offset, SEEK_HOLE);
 	__be32 nfserr;
 	__be32 *p;
 
+	if (hole_pos > read->rd_offset)
+		maxcount = min_t(unsigned long, maxcount, hole_pos - read->rd_offset);
+
 	/* Content type, offset, byte count */
 	p = xdr_reserve_space(xdr, 4 + 8 + 4);
 	if (!p)
@@ -4289,6 +4293,7 @@ nfsd4_encode_read_plus_data(struct nfsd4_compoundres *resp,
 		nfserr = nfsd4_encode_splice_read(resp, read, file, &maxcount, eof);
 	else
 		nfserr = nfsd4_encode_readv(resp, read, file, &maxcount, eof);
+	clear_bit(RQ_SPLICE_OK, &resp->rqstp->rq_flags);
 
 	if (nfserr)
 		return nfserr;
@@ -4303,18 +4308,24 @@ nfsd4_encode_read_plus_data(struct nfsd4_compoundres *resp,
 }
 
 static __be32
-nfsd4_encode_read_plus_hole(struct nfsd4_compoundres *resp, struct nfsd4_read *read,
-			    unsigned long maxcount, u32 *eof)
+nfsd4_encode_read_plus_hole(struct nfsd4_compoundres *resp,
+			    struct nfsd4_read *read, u32 *eof, loff_t data_pos)
 {
 	struct file *file = read->rd_nf->nf_file;
+	unsigned long maxcount = read->rd_length;
 	__be32 *p;
 
+	if (data_pos == 0)
+		data_pos = vfs_llseek(file, read->rd_offset, SEEK_DATA);
+	if (data_pos == -ENXIO)
+		data_pos = i_size_read(file_inode(file));
+
 	/* Content type, offset, byte count */
 	p = xdr_reserve_space(&resp->xdr, 4 + 8 + 8);
 	if (!p)
 		return nfserr_resource;
 
-	maxcount = min_t(unsigned long, maxcount, read->rd_length);
+	maxcount = min_t(unsigned long, maxcount, data_pos - read->rd_offset);
 
 	*p++ = cpu_to_be32(NFS4_CONTENT_HOLE);
 	 p   = xdr_encode_hyper(p, read->rd_offset);
@@ -4338,6 +4349,7 @@ nfsd4_encode_read_plus(struct nfsd4_compoundres *resp, __be32 nfserr,
 	int starting_len = xdr->buf->len;
 	unsigned int segments = 0;
 	loff_t data_pos;
+	bool is_data;
 	__be32 *p;
 
 	if (nfserr)
@@ -4361,21 +4373,26 @@ nfsd4_encode_read_plus(struct nfsd4_compoundres *resp, __be32 nfserr,
 	maxcount = min_t(unsigned long, maxcount,
 			 (xdr->buf->buflen - xdr->buf->len));
 	maxcount = min_t(unsigned long, maxcount, read->rd_length);
+	read->rd_length = maxcount;
 
 	data_pos = vfs_llseek(file, read->rd_offset, SEEK_DATA);
 	if (data_pos == -ENXIO)
 		data_pos = i_size_read(file_inode(file));
 	else if (data_pos < 0)
 		data_pos = read->rd_offset;
+	is_data = (data_pos == read->rd_offset);
+	eof = read->rd_offset > i_size_read(file_inode(file));
 
-	if (data_pos > read->rd_offset) {
-		nfserr = nfsd4_encode_read_plus_hole(resp, read,
-						     data_pos - read->rd_offset, &eof);
-		segments++;
-	}
+	while (read->rd_length > 0 && !eof) {
+		if (is_data)
+			nfserr = nfsd4_encode_read_plus_data(resp, read, &eof);
+		else
+			nfserr = nfsd4_encode_read_plus_hole(resp, read, &eof, data_pos);
 
-	if (!nfserr && !eof && read->rd_length > 0) {
-		nfserr = nfsd4_encode_read_plus_data(resp, read, maxcount, &eof);
+		if (nfserr)
+			break;
+		is_data = !is_data;
+		data_pos = 0;
 		segments++;
 	}
 
-- 
2.24.1

