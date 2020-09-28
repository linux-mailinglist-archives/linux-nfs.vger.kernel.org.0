Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA4E727B2BA
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Sep 2020 19:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgI1RJJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 28 Sep 2020 13:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbgI1RJJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 28 Sep 2020 13:09:09 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A26C5C061755
        for <linux-nfs@vger.kernel.org>; Mon, 28 Sep 2020 10:09:07 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id q63so1650241qkf.3
        for <linux-nfs@vger.kernel.org>; Mon, 28 Sep 2020 10:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+9jJVsZyBQ11nCOGZ3qB51ygjP1WPaVDIKbFw6llPxQ=;
        b=TC0Nr+vZyKrFrK2I1qOgDEh+nE3KXG3F9kDTMRWtc4dTYlMNOMtXth1CMJ8Avyfutu
         C/T5l4Xe3NL47CB3ZAGk9GcRpgg+HCfRoVvgZapMIHOSXmiyQ1s9qiksAZwCRYRXc1fp
         UBu9MUEkGuWX7n+7ihWjovWk++FuzJ3JFhpCyltbVlUgyFpc5f5YdsgMZ5RwR3QHrTps
         MWZrk8RpavjEAIe7BWjSttDg15EOghyHeOJUq5UyMvcMwc2Duz4GtIXBIWgWSBbBH6f5
         NX7FVRx5uHrqBSFnjDzjRanVlUGnpfX5LoH7sqeqgPlJ5HRZBjW+ZO917edVWXLR9DR/
         4Wzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=+9jJVsZyBQ11nCOGZ3qB51ygjP1WPaVDIKbFw6llPxQ=;
        b=FwW6VxeajpTHleGCe/RmzbxqN3YAsWAFXsynSo42VOU9Z/zWV/soF+hIYEdKGOdT1m
         CFKLd7Rl/3gmx94Bl+ovg0QMcp769YeGjEUT1ed7Rme3u4g9Qm0j8rLv7PVatD6ID+aL
         aa0ONa2m7F2dfrXoHyxfBRtFEv85X/GKq2Iz+ncQWW8ed2YX//9QlZ38H+Xqb1v2OBJG
         pN9Nl4hWgsPzkHLBadw6sPvo+fsUvMbf/trzdb2zW8c6WkbcBTnkIv2NUXZeItvxZD55
         VS3h5/+BzVVWfDl+7hm3mBJuRhaWJrbRX9jNXvT17Iu45Q7H/zXgMNyakGnZYC/fjTFd
         OEyQ==
X-Gm-Message-State: AOAM530EVAad3np/QtssRDT3lExTPcAfBokNgAdd1L32HnKsmMjkD/Yl
        5lI58H7NareTe6nimVkRyFo=
X-Google-Smtp-Source: ABdhPJzaLTpjFWudTEnDcIZ8wqGWnZQ0O+1qzeT8XB/P57q3szrzdUxfGlLCS8FPXid44FvlGrBhHA==
X-Received: by 2002:a05:620a:6d9:: with SMTP id 25mr403406qky.269.1601312946812;
        Mon, 28 Sep 2020 10:09:06 -0700 (PDT)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id k20sm2011631qtb.34.2020.09.28.10.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 10:09:06 -0700 (PDT)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     bfields@redhat.com, chuck.lever@oracle.com,
        linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v6 3/5] NFSD: Add READ_PLUS hole segment encoding
Date:   Mon, 28 Sep 2020 13:08:59 -0400
Message-Id: <20200928170901.707554-4-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200928170901.707554-1-Anna.Schumaker@Netapp.com>
References: <20200928170901.707554-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

However, we still only reply to the READ_PLUS call with a single segment
at this time.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 fs/nfsd/nfs4xdr.c | 39 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 477a7d8bb9a4..e633e1290c78 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -4608,10 +4608,13 @@ nfsd4_encode_read_plus_data(struct nfsd4_compoundres *resp,
 	struct xdr_stream *xdr = &resp->xdr;
 	struct file *file = read->rd_nf->nf_file;
 	int starting_len = xdr->buf->len;
+	loff_t hole_pos = vfs_llseek(file, read->rd_offset, SEEK_HOLE);
 	__be32 nfserr;
 	__be32 *p, tmp;
 	__be64 tmp64;
 
+	if (hole_pos > read->rd_offset)
+		maxcount = min_t(unsigned long, maxcount, hole_pos - read->rd_offset);
 	maxcount = min_t(unsigned long, maxcount, (xdr->buf->buflen - xdr->buf->len));
 
 	/* Content type, offset, byte count */
@@ -4637,6 +4640,27 @@ nfsd4_encode_read_plus_data(struct nfsd4_compoundres *resp,
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
@@ -4647,6 +4671,7 @@ nfsd4_encode_read_plus(struct nfsd4_compoundres *resp, __be32 nfserr,
 	int starting_len = xdr->buf->len;
 	int segments = 0;
 	__be32 *p, tmp;
+	loff_t pos;
 	u32 eof;
 
 	if (nfserr)
@@ -4665,11 +4690,23 @@ nfsd4_encode_read_plus(struct nfsd4_compoundres *resp, __be32 nfserr,
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

