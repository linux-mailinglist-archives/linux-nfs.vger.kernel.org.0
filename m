Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E59791379C8
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Jan 2020 23:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbgAJWfp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 10 Jan 2020 17:35:45 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:33375 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727387AbgAJWfp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 10 Jan 2020 17:35:45 -0500
Received: by mail-yw1-f68.google.com with SMTP id 192so1332250ywy.0
        for <linux-nfs@vger.kernel.org>; Fri, 10 Jan 2020 14:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xsfb9xbGJqHF0vJh/iXTq267VS4JgDlr9nlfdAvU1UQ=;
        b=n8UaaSa7QkR69IfxxXsb4sy8HgKiL9Qon5KYnph3QfUgrN2dMNlEqkANaB/IbeqILd
         sXBWGtAGcLGXc0bDMo7e7SUv57aWLyP7TRm5sIlSBeLLyTMHwwfQCsviGfqo5KeveFjc
         gWrTky/xttbI8YeO+bP2Y4XcKk6Yw5/0tLuae+sEVfLKYHwQ9xY7PmIecHp0FwGzmBMh
         gj/bIWhCahuE/hM9Dz1ZckJPrZJ3/P6x2i90NoRidrE3IyiDecE6pyLIu8Z69gpO5GtH
         rr0Z2Kb3WLJtgk4gjD+TLtvbsy2Z5m1euDZUZlX61GffBbcFRAnkDcu+W1ILLzZmQqLM
         ljcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Xsfb9xbGJqHF0vJh/iXTq267VS4JgDlr9nlfdAvU1UQ=;
        b=b4oW7stLKDf5hG1V4qozJjAPAI1fsDzWgF8MuDS7LZdqG7B4hJULdSK9kEa+EF1DSk
         bCEMQdlYsT+jdDvd/+PNCtId1E04LCiAhuJ26K8pCLmq+gEIm9+ep98mPHIm12Bjm/lQ
         bLJcF4/fog0K1AJNqb1GMmkVwxPN+ODEGqySr4IyoYwuq1Ix0nMkiBwB2t702v0kscxz
         ZTySS8PGt+jun7aeZJ909sDAwK6JU5sdFBymVRJnrGo+LFAZC1MYwOBV293wtcIbB+y3
         wd0/wujvXFrG3y2yl06yMOS+Ch9hUU3ytLjASVu4r+JGAZlmlLdCpkgPIx+iZ9mFYI0w
         LPTw==
X-Gm-Message-State: APjAAAV1Lfg6X4rqpL14d+7FFFxA21XJhYvNrUbjwzri6qMjCfa3Lw8f
        n1sYUlVRh+PN2BcZg76D9/s=
X-Google-Smtp-Source: APXvYqwrdoSEU2PtDAfYZ9ssqyadL/M2Q+FgmYpiXAiw58hP/jP6fEdChTJqqJ0OfnahIJqLhcgjoA==
X-Received: by 2002:a0d:ffc2:: with SMTP id p185mr4714977ywf.256.1578695744090;
        Fri, 10 Jan 2020 14:35:44 -0800 (PST)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id h23sm1607735ywc.105.2020.01.10.14.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 14:35:43 -0800 (PST)
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     bfields@redhat.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH 3/4] NFSD: Add READ_PLUS hole segment encoding
Date:   Fri, 10 Jan 2020 17:35:37 -0500
Message-Id: <20200110223538.528560-4-Anna.Schumaker@Netapp.com>
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

However, we only encode the hole if it is at the beginning of the range
and treat everything else as data to keep things simple.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 fs/nfsd/nfs4proc.c |  2 +-
 fs/nfsd/nfs4xdr.c  | 47 ++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 3c11ca9bd5d7..fc8c821eda8b 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2184,7 +2184,7 @@ static inline u32 nfsd4_read_plus_rsize(struct svc_rqst *rqstp, struct nfsd4_op
 	u32 maxcount = svc_max_payload(rqstp);
 	u32 rlen = min(op->u.read.rd_length, maxcount);
 	/* enough extra xdr space for encoding either a hole or data segment. */
-	u32 segments = 1 + 2 + 2;
+	u32 segments = 2 * (1 + 2 + 2);
 
 	return (op_encode_hdr_size + 2 + segments + XDR_QUADLEN(rlen)) * sizeof(__be32);
 }
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 014e05365c17..552972b35547 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -4302,6 +4302,31 @@ nfsd4_encode_read_plus_data(struct nfsd4_compoundres *resp,
 	return nfserr;
 }
 
+static __be32
+nfsd4_encode_read_plus_hole(struct nfsd4_compoundres *resp, struct nfsd4_read *read,
+			    unsigned long maxcount, u32 *eof)
+{
+	struct file *file = read->rd_nf->nf_file;
+	__be32 *p;
+
+	/* Content type, offset, byte count */
+	p = xdr_reserve_space(&resp->xdr, 4 + 8 + 8);
+	if (!p)
+		return nfserr_resource;
+
+	maxcount = min_t(unsigned long, maxcount, read->rd_length);
+
+	*p++ = cpu_to_be32(NFS4_CONTENT_HOLE);
+	 p   = xdr_encode_hyper(p, read->rd_offset);
+	 p   = xdr_encode_hyper(p, maxcount);
+
+	*eof = (read->rd_offset + maxcount) >= i_size_read(file_inode(file));
+
+	read->rd_offset += maxcount;
+	read->rd_length  = (maxcount > 0) ? read->rd_length - maxcount : 0;
+	return nfs_ok;
+}
+
 static __be32
 nfsd4_encode_read_plus(struct nfsd4_compoundres *resp, __be32 nfserr,
 		       struct nfsd4_read *read)
@@ -4311,6 +4336,8 @@ nfsd4_encode_read_plus(struct nfsd4_compoundres *resp, __be32 nfserr,
 	struct xdr_stream *xdr = &resp->xdr;
 	struct file *file;
 	int starting_len = xdr->buf->len;
+	unsigned int segments = 0;
+	loff_t data_pos;
 	__be32 *p;
 
 	if (nfserr)
@@ -4335,12 +4362,28 @@ nfsd4_encode_read_plus(struct nfsd4_compoundres *resp, __be32 nfserr,
 			 (xdr->buf->buflen - xdr->buf->len));
 	maxcount = min_t(unsigned long, maxcount, read->rd_length);
 
-	nfserr = nfsd4_encode_read_plus_data(resp, read, maxcount, &eof);
+	data_pos = vfs_llseek(file, read->rd_offset, SEEK_DATA);
+	if (data_pos == -ENXIO)
+		data_pos = i_size_read(file_inode(file));
+	else if (data_pos < 0)
+		data_pos = read->rd_offset;
+
+	if (data_pos > read->rd_offset) {
+		nfserr = nfsd4_encode_read_plus_hole(resp, read,
+						     data_pos - read->rd_offset, &eof);
+		segments++;
+	}
+
+	if (!nfserr && !eof && read->rd_length > 0) {
+		nfserr = nfsd4_encode_read_plus_data(resp, read, maxcount, &eof);
+		segments++;
+	}
+
 	if (nfserr)
 		xdr_truncate_encode(xdr, starting_len);
 	else {
 		*p++ = htonl(eof);
-		*p++ = htonl(1);
+		*p++ = htonl(segments);
 	}
 
 	return nfserr;
-- 
2.24.1

