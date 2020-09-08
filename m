Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDDD9261543
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Sep 2020 18:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731951AbgIHQrK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Sep 2020 12:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731957AbgIHQ0T (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Sep 2020 12:26:19 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446DAC06179E
        for <linux-nfs@vger.kernel.org>; Tue,  8 Sep 2020 09:26:05 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id d18so17678351iop.13
        for <linux-nfs@vger.kernel.org>; Tue, 08 Sep 2020 09:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n/2fiuBOtKrY5YnAqes3SdT/3HFoEVtpaKzKG372BbY=;
        b=dh72JQuRNA/fcn4CQ1VLre56pTxeUVlb0dZGK0prahVv0QKkAjPGmRu9I90MadFShP
         wQIia9HHM3oP3djg3IgviRNIpML0EV3kRvAJfcdlfrfPS73KcopCwuHfTo34LQ7RaFv6
         F2MqrpWIPNdJUTYLeQp37lrEaGCqndj25LWQI3V9a8M+lE/rocxXiXYSQQc55cqJO0oA
         8x8vc8Z7gLKwEU9FF6zyheERlo9tlf3AFhs9/AHItBs+cMOqV6U16lZmYr2C7AJEVv57
         4/9Tt/tMEod6rhvbDNCzn9Ix+nVsY5l5w33QBse1PQ0gIfDhhS7WpRu+cY2iVJrUyIIx
         ZH6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=n/2fiuBOtKrY5YnAqes3SdT/3HFoEVtpaKzKG372BbY=;
        b=HHc66eKFJOFbe16GbLPtzEEIsPwW4Z0xo+bQZb/M/qDwcn+nUi+HPJ0AChOZ4r7+fU
         eT/QIQlrxr/Z9bIDFNCyRHYkuGTZGgjrGtSgTn7QfmZM6yi+R6teDFz65uaLIUUzhoki
         BrFsiE0Chnx+9eK034DFaYU3JBtwWFQN0JPEekFw+c2o8h3V9d/yphsU7wuWJKSvsojK
         m7XiehnQZq84X8Mvoz9jgzBb/kuvNOFfX8LycTonguidTUz3PqZ/p4NWK/QZLKr8eUgF
         6r0U95JIlSnnyeMNdjBZl7JoguwrkAuyPAMNG/JtMc7RUG/q1NDHAZHkfCI68FfWJbCu
         7z4A==
X-Gm-Message-State: AOAM531bWlEzvonYeSzGTYv093e3oZ3Y3BzqHqxXAOtK/IGPpDOWsDne
        WaiUY6RgnDKnKoUzLcWn6/8=
X-Google-Smtp-Source: ABdhPJzmhBVuogiQ/FXzSfjC4JKWZr5Szi/98D7+VXvoZ0xOQOV7LcAKVNPTiirGQ7VnNAnCJNpDCQ==
X-Received: by 2002:a5d:8b4a:: with SMTP id c10mr21926653iot.143.1599582364551;
        Tue, 08 Sep 2020 09:26:04 -0700 (PDT)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id v7sm10269657ilg.83.2020.09.08.09.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 09:26:03 -0700 (PDT)
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     bfields@redhat.com, chuck.lever@oracle.com,
        linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v5 3/5] NFSD: Add READ_PLUS hole segment encoding
Date:   Tue,  8 Sep 2020 12:25:57 -0400
Message-Id: <20200908162559.509113-4-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908162559.509113-1-Anna.Schumaker@Netapp.com>
References: <20200908162559.509113-1-Anna.Schumaker@Netapp.com>
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
 fs/nfsd/nfs4xdr.c | 40 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 26d12e3edf33..45159bd9e9a4 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -4608,10 +4608,14 @@ nfsd4_encode_read_plus_data(struct nfsd4_compoundres *resp,
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
@@ -4635,6 +4639,27 @@ nfsd4_encode_read_plus_data(struct nfsd4_compoundres *resp,
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
@@ -4645,6 +4670,7 @@ nfsd4_encode_read_plus(struct nfsd4_compoundres *resp, __be32 nfserr,
 	int starting_len = xdr->buf->len;
 	int segments = 0;
 	__be32 *p, tmp;
+	loff_t pos;
 	u32 eof;
 
 	if (nfserr)
@@ -4663,11 +4689,23 @@ nfsd4_encode_read_plus(struct nfsd4_compoundres *resp, __be32 nfserr,
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

