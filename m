Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4B7246E97
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Aug 2020 19:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389322AbgHQRdf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 17 Aug 2020 13:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389108AbgHQQxg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 17 Aug 2020 12:53:36 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22345C061349
        for <linux-nfs@vger.kernel.org>; Mon, 17 Aug 2020 09:53:22 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id j9so15079349ilc.11
        for <linux-nfs@vger.kernel.org>; Mon, 17 Aug 2020 09:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rI/zjidG9W1rkPFtshPIGzTMbEANYwyl1HV+pg9qhjc=;
        b=chWB8ODOzHTLg1sKy0y9+i7IPC2vBhcTo/WY5rqTUHvaMPTESlinF5GMYAWdTeO6gP
         AILmkf+/fLxJvWWzAGLNXQ8wnU/BNmax/tVmp2RVE0LoWNli/FxDY+QvyEy5RldOxD1M
         2HuF2ms5FTUQHG+GAWLyk0KqxMLlnYG/zifxpPZfXKBmRc3u62mbwdxeFR6S2n7Fb/Hg
         i7iXnZwixee5YIM4ATwskIW4aXdk0uVi2KIMz+lI5i9z8EM3/57hYgV19bNBBv0KtpPu
         0zv4sC50Ohe9gA/hAtUrd3Lp2paFx3pEU4fcN4GJNFAfcOTMQszgzkwOzn7NGFxEeu3U
         tLuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=rI/zjidG9W1rkPFtshPIGzTMbEANYwyl1HV+pg9qhjc=;
        b=lrvvxGpyjSpkTYyWwWrFbucPuNMG/sndTbNjjuQSybjDO3FEdjC/0aReulow1TVwrC
         3W1JXKO553+Dc3PX9fstmmkRaAr3Q4/sTLwM1WtvyZUMah959gAzyx45U4iOwkZehGOn
         Lc+oNq4zhvpiDwMWRmJH8+4SjEcpYeFxrR/E5x2iOPMuA9oNzE9weKZEW/eET7RtQxi8
         0tcuQKvqRbSVgrcObmx8d92nrkIeNKQv9R2o69w33RxH5i6hS1VsDxlPyn8kdLDXcEVS
         icT792M3CZWXDDBoZyptNaiQW611QdImVgUUc8JZ3pE19fHlj+DiA3kSPuSe/qhLNzXr
         Ejiw==
X-Gm-Message-State: AOAM531Z/TmXtD5nj9MfWxgLdgs/DIXH5yV7sg+mo0rf+DK5Kn1+EDYa
        PciBBdrCIkLa7LOYvViZUHI=
X-Google-Smtp-Source: ABdhPJyX5zk6woUqJZdBmyRbEVQRc2IdRdLVvESoIvcG35IwRJdtPYEDn5832x5L4Nwar+2HuYvf5w==
X-Received: by 2002:a92:9a94:: with SMTP id c20mr2504555ill.37.1597683197013;
        Mon, 17 Aug 2020 09:53:17 -0700 (PDT)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id s3sm9410039iol.49.2020.08.17.09.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 09:53:16 -0700 (PDT)
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     bfields@redhat.com, chuck.lever@oracle.com,
        linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v4 5/5] NFSD: Encode a full READ_PLUS reply
Date:   Mon, 17 Aug 2020 12:53:10 -0400
Message-Id: <20200817165310.354092-6-Anna.Schumaker@Netapp.com>
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

Reply to the client with multiple hole and data segments. I use the
result of the first vfs_llseek() call for encoding as an optimization so
we don't have to immediately repeat the call.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 fs/nfsd/nfs4xdr.c | 33 ++++++++++++++-------------------
 1 file changed, 14 insertions(+), 19 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 3f4860103b25..fb71e52accee 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -4373,16 +4373,18 @@ nfsd4_encode_offload_status(struct nfsd4_compoundres *resp, __be32 nfserr,
 static __be32
 nfsd4_encode_read_plus_data(struct nfsd4_compoundres *resp,
 			    struct nfsd4_read *read,
-			    unsigned long *maxcount, u32 *eof)
+			    unsigned long *maxcount, u32 *eof,
+			    loff_t *pos)
 {
 	struct xdr_stream *xdr = &resp->xdr;
 	struct file *file = read->rd_nf->nf_file;
 	int starting_len = xdr->buf->len;
-	loff_t hole_pos = vfs_llseek(file, read->rd_offset, SEEK_HOLE);
+	loff_t hole_pos;
 	__be32 nfserr;
 	__be32 *p, tmp;
 	__be64 tmp64;
 
+	hole_pos = pos ? *pos : vfs_llseek(file, read->rd_offset, SEEK_HOLE);
 	if (hole_pos > read->rd_offset)
 		*maxcount = min_t(unsigned long, *maxcount, hole_pos - read->rd_offset);
 
@@ -4449,6 +4451,7 @@ nfsd4_encode_read_plus(struct nfsd4_compoundres *resp, __be32 nfserr,
 	int starting_len = xdr->buf->len;
 	int segments = 0;
 	__be32 *p, tmp;
+	bool is_data;
 	loff_t pos;
 	u32 eof;
 
@@ -4472,29 +4475,21 @@ nfsd4_encode_read_plus(struct nfsd4_compoundres *resp, __be32 nfserr,
 	if (eof)
 		goto out;
 
-	pos = vfs_llseek(file, read->rd_offset, SEEK_DATA);
-	if (pos == -ENXIO)
-		pos = i_size_read(file_inode(file));
-	else if (pos < 0)
-		pos = read->rd_offset;
+	pos = vfs_llseek(file, read->rd_offset, SEEK_HOLE);
+	is_data = pos > read->rd_offset;
 
-	if (pos == read->rd_offset) {
+	while (count > 0 && !eof) {
 		maxcount = count;
-		nfserr = nfsd4_encode_read_plus_data(resp, read, &maxcount, &eof);
-		if (nfserr)
-			goto out;
-		count -= maxcount;
-		read->rd_offset += maxcount;
-		segments++;
-	}
-
-	if (count > 0 && !eof) {
-		maxcount = count;
-		nfserr = nfsd4_encode_read_plus_hole(resp, read, &maxcount, &eof);
+		if (is_data)
+			nfserr = nfsd4_encode_read_plus_data(resp, read, &maxcount, &eof,
+						segments == 0 ? &pos : NULL);
+		else
+			nfserr = nfsd4_encode_read_plus_hole(resp, read, &maxcount, &eof);
 		if (nfserr)
 			goto out;
 		count -= maxcount;
 		read->rd_offset += maxcount;
+		is_data = !is_data;
 		segments++;
 	}
 
-- 
2.28.0

