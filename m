Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8355B246E93
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Aug 2020 19:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389352AbgHQRdg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 17 Aug 2020 13:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389102AbgHQQxd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 17 Aug 2020 12:53:33 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C3CC061347
        for <linux-nfs@vger.kernel.org>; Mon, 17 Aug 2020 09:53:15 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id v6so18208180iow.11
        for <linux-nfs@vger.kernel.org>; Mon, 17 Aug 2020 09:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OVQTTMCLpOrm/KIIbHgKLRkACNrFNu799Qop2hNiKpI=;
        b=sTd4EBdidXOkMHwfQDwH8F+JCgT75ECRvideQDg7pdY6jGviJLPkjZBPIVC0I/hdXQ
         3PMbPsacPGzkdV3dDqesPzDhWScR2XxjoiZaInpPZERqGuZ/QWPcOoljjp+HJtX5MDDm
         635qTnQ2aQMr5DhmAGOE4yvdEWMhxrFlQc1Ox2xE+mYRYhrafF4lyLNIpSfq1RLTcpph
         ZpHKixRoXRhplJDOwoIfgMDOZ5q+Vmjn6whZvT1Mbz3SbDRqsAGPbxT3v5JZO1nulnCL
         vAC8aAKf8cxL7CThHSYyg9BJZBNisv1bMrr9am+F+aSZZ7zONutFwvo33x2Rmf99RRQa
         eT8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=OVQTTMCLpOrm/KIIbHgKLRkACNrFNu799Qop2hNiKpI=;
        b=o5BpFZ+VaN9iKdGWJ+pgi1NZvcAI24QJJwjxZF2U3kbTTuzd6Kz5cTYjIFB5rfTDhu
         W5Wj/uQtPRd+4+N60PUOAOcGFM6oBXpk1NQ0sTjaKQTQzdtWDngm+5TU24qYLklKv8Ta
         uIc0IE8d83rz18QTUV8nYWS8sAbUKSgmBSU3chveiOAb3ke+I4UxvfLFF2vE79z3QoNr
         2w61p1oW2xoLqAybNbphfeKZeHwn3qcNIF/D/qRf9M8CGZc09LXE080D8vLmzh9vct6t
         VlAVGm7JCNEk149t7EM/gnEHhvlywfKFLGHMUIbqstkbwaeKlecVQQu5SQ+hxXRCBUYl
         XznQ==
X-Gm-Message-State: AOAM531EoUZ1hXRnuIi5IdIRqUCNVL0679UIJpnmo+NGkcP24bQWfUuL
        05CoGPd+ix/V1z1UmQdIHTY=
X-Google-Smtp-Source: ABdhPJzhjAQqSY5QsInLkrP2aUDuoIk247aHTWHqYYiLCqRPs6iB73kKxIVKldMd4eeTBuLwf1cnLA==
X-Received: by 2002:a6b:b888:: with SMTP id i130mr13058609iof.182.1597683195078;
        Mon, 17 Aug 2020 09:53:15 -0700 (PDT)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id s3sm9410039iol.49.2020.08.17.09.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 09:53:14 -0700 (PDT)
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     bfields@redhat.com, chuck.lever@oracle.com,
        linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v4 3/5] NFSD: Add READ_PLUS hole segment encoding
Date:   Mon, 17 Aug 2020 12:53:08 -0400
Message-Id: <20200817165310.354092-4-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817165310.354092-1-Anna.Schumaker@Netapp.com>
References: <20200817165310.354092-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

However, we still only reply to the READ_PLUS call with a single segment
at this time.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 fs/nfsd/nfs4proc.c |  2 +-
 fs/nfsd/nfs4xdr.c  | 40 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 9630d33211f2..36305b846f5a 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2528,7 +2528,7 @@ static inline u32 nfsd4_read_plus_rsize(struct svc_rqst *rqstp, struct nfsd4_op
 	u32 maxcount = svc_max_payload(rqstp);
 	u32 rlen = min(op->u.read.rd_length, maxcount);
 	/* enough extra xdr space for encoding either a hole or data segment. */
-	u32 segments = 1 + 2 + 2;
+	u32 segments = 2 * (1 + 2 + 2);
 
 	return (op_encode_hdr_size + 2 + segments + XDR_QUADLEN(rlen)) * sizeof(__be32);
 }
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 9af92f538000..2fa39217c256 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -4378,10 +4378,14 @@ nfsd4_encode_read_plus_data(struct nfsd4_compoundres *resp,
 	struct xdr_stream *xdr = &resp->xdr;
 	struct file *file = read->rd_nf->nf_file;
 	int starting_len = xdr->buf->len;
+	loff_t hole_pos = vfs_llseek(file, read->rd_offset, SEEK_HOLE);
 	__be32 nfserr;
 	__be32 *p, tmp;
 	__be64 tmp64;
 
+	if (hole_pos > read->rd_offset)
+		maxcount = min_t(unsigned long, maxcount, hole_pos - read->rd_offset);
+
 	/* Content type, offset, byte count */
 	p = xdr_reserve_space(xdr, 4 + 8 + 4);
 	if (!p)
@@ -4405,6 +4409,27 @@ nfsd4_encode_read_plus_data(struct nfsd4_compoundres *resp,
 	return nfs_ok;
 }
 
+static __be32
+nfsd4_encode_read_plus_hole(struct nfsd4_compoundres *resp,
+			    struct nfsd4_read *read,
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
+	*p++ = htonl(NFS4_CONTENT_HOLE);
+	 p   = xdr_encode_hyper(p, read->rd_offset);
+	 p   = xdr_encode_hyper(p, maxcount);
+
+	*eof = (read->rd_offset + maxcount) >= i_size_read(file_inode(file));
+	return nfs_ok;
+}
+
 static __be32
 nfsd4_encode_read_plus(struct nfsd4_compoundres *resp, __be32 nfserr,
 		       struct nfsd4_read *read)
@@ -4415,6 +4440,7 @@ nfsd4_encode_read_plus(struct nfsd4_compoundres *resp, __be32 nfserr,
 	int starting_len = xdr->buf->len;
 	int segments = 0;
 	__be32 *p, tmp;
+	loff_t pos;
 	u32 eof;
 
 	if (nfserr)
@@ -4433,11 +4459,23 @@ nfsd4_encode_read_plus(struct nfsd4_compoundres *resp, __be32 nfserr,
 	maxcount = min_t(unsigned long, maxcount, read->rd_length);
 
 	eof = read->rd_offset >= i_size_read(file_inode(file));
-	if (!eof) {
+	if (eof)
+		goto out;
+
+	pos = vfs_llseek(file, read->rd_offset, SEEK_DATA);
+	if (pos == -ENXIO)
+		pos = i_size_read(file_inode(file));
+
+	if (pos > read->rd_offset) {
+		maxcount = pos - read->rd_offset;
+		nfserr = nfsd4_encode_read_plus_hole(resp, read, maxcount, &eof);
+		segments++;
+	} else {
 		nfserr = nfsd4_encode_read_plus_data(resp, read, maxcount, &eof);
 		segments++;
 	}
 
+out:
 	if (nfserr)
 		xdr_truncate_encode(xdr, starting_len);
 	else {
-- 
2.28.0

