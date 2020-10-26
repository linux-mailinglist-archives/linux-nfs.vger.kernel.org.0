Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E109E299615
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Oct 2020 19:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1780843AbgJZSzc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 26 Oct 2020 14:55:32 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36046 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404083AbgJZSzb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 26 Oct 2020 14:55:31 -0400
Received: by mail-qk1-f196.google.com with SMTP id r7so9408095qkf.3;
        Mon, 26 Oct 2020 11:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=anT1sLFW8H6h/m1zuKewPaTkoaFSjz3HZ6lIFFJwDfc=;
        b=adpT11GwF3BLVPG/LE4t7wyVIVN/tpja386EHA3uAZgCUle7oSFuKWI2aM9Z8Zwqqw
         rRkYPuncvVKGlJMJKC86LIpQQLwGrhGB7h3vO1Zh88zC/oR2v7aQhta2QZOuzXNQu/jp
         ivQ5GEwlBSlSSk3WQbnw43vjOnJ6mO/5A616Gn1s/4+odl06SWDedvpr7Xb0S3F80p7k
         GS2loazU9VDIVLWoVVu6+xNSHduji92G2iHuwAUuJwrd7Bo3JBS76T4lACtCEBys+EOl
         4KrPAEpe2JLx/bZ1xioS0+/XKzTkFM5YVB60/EbEW7RP39z36kQmcNVv7V/Kawzat2S9
         s8aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=anT1sLFW8H6h/m1zuKewPaTkoaFSjz3HZ6lIFFJwDfc=;
        b=Kl0jlO8PhN2gXPLV6zHDJylnrp8ZOIZEb3a4/96MqT0jUQ6LSjXRJ8QxwoNJykNgcd
         b5LuaN8jpVsgOHcRkyFIZ1RU37+E7ufs4TKf8vry0nR7PSBd7iWerfdNzFBiSfvrLKW6
         +xjTMccPGk+U1g8ayTZtmaStc63fPKJEjWiYw9gKM8DGPpFPQV298OHd2BsRsgAaizVs
         kE2i3W1Z98okRI2ydyyGOv4RwdzgnBvPU1SrfWYAldUl27Dy6UJMr66vSH2zrMw+ybHF
         S/3lArtTNu5YVM95xwouC/kVAIQ0IH3zifn6FcryMD9RtomBBKdDk7uMEyK9j6cQmHwl
         S+5w==
X-Gm-Message-State: AOAM531owiLVheGH7bydITstQG6LOS6Hp7EjEE0VeL/HY9QWnQAEdnm5
        V1CnXI13xBJrw6W8wsizSva48mtFgGY=
X-Google-Smtp-Source: ABdhPJyfjvNg9jHLBZEnKT3YK9KJGHpr1CzSWYtonHE3WUvywosmX1xrlrLnct1+2fIshSFRbnAwfg==
X-Received: by 2002:a37:c49:: with SMTP id 70mr16000744qkm.345.1603738530020;
        Mon, 26 Oct 2020 11:55:30 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id s3sm7105274qkj.27.2020.10.26.11.55.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Oct 2020 11:55:29 -0700 (PDT)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 09QItSHR013667;
        Mon, 26 Oct 2020 18:55:28 GMT
Subject: [PATCH 18/20] svcrdma: Rename info::ri_chunklen
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 26 Oct 2020 14:55:28 -0400
Message-ID: <160373852838.1886.14180778700427228388.stgit@klimt.1015granger.net>
In-Reply-To: <160373843299.1886.12604782813896379719.stgit@klimt.1015granger.net>
References: <160373843299.1886.12604782813896379719.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I'm about to change the purpose of ri_chunklen: Instead of tracking
the number of bytes in one Read chunk, it will track the total
number of bytes in the Read list. Rename it for clarity.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_rw.c |   31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index 0de95207eaf1..104b1d5a2203 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -262,7 +262,7 @@ struct svc_rdma_read_info {
 	unsigned int			ri_position;
 	unsigned int			ri_pageno;
 	unsigned int			ri_pageoff;
-	unsigned int			ri_chunklen;
+	unsigned int			ri_totalbytes;
 
 	struct svc_rdma_chunk_ctxt	ri_cc;
 };
@@ -724,7 +724,6 @@ static int svc_rdma_build_read_chunk(struct svc_rqst *rqstp,
 	int ret;
 
 	ret = -EINVAL;
-	info->ri_chunklen = 0;
 	while (*p++ != xdr_zero && be32_to_cpup(p++) == info->ri_position) {
 		u32 handle, length;
 		u64 offset;
@@ -735,7 +734,7 @@ static int svc_rdma_build_read_chunk(struct svc_rqst *rqstp,
 		if (ret < 0)
 			break;
 
-		info->ri_chunklen += length;
+		info->ri_totalbytes += length;
 	}
 	return ret;
 }
@@ -752,6 +751,8 @@ static int svc_rdma_build_normal_read_chunk(struct svc_rqst *rqstp,
 					    __be32 *p)
 {
 	struct svc_rdma_recv_ctxt *head = info->ri_readctxt;
+	struct xdr_buf *buf = &head->rc_arg;
+	unsigned int length;
 	int ret;
 
 	ret = svc_rdma_build_read_chunk(rqstp, info, p);
@@ -780,11 +781,10 @@ static int svc_rdma_build_normal_read_chunk(struct svc_rqst *rqstp,
 	 * Currently these chunks always start at page offset 0,
 	 * thus the rounded-up length never crosses a page boundary.
 	 */
-	info->ri_chunklen = XDR_QUADLEN(info->ri_chunklen) << 2;
-
-	head->rc_arg.page_len = info->ri_chunklen;
-	head->rc_arg.len += info->ri_chunklen;
-	head->rc_arg.buflen += info->ri_chunklen;
+	length = XDR_QUADLEN(info->ri_totalbytes) << 2;
+	buf->page_len = length;
+	buf->len += length;
+	buf->buflen += length;
 
 out:
 	return ret;
@@ -806,22 +806,20 @@ static int svc_rdma_build_pz_read_chunk(struct svc_rqst *rqstp,
 					__be32 *p)
 {
 	struct svc_rdma_recv_ctxt *head = info->ri_readctxt;
+	struct xdr_buf *buf = &head->rc_arg;
 	int ret;
 
 	ret = svc_rdma_build_read_chunk(rqstp, info, p);
 	if (ret < 0)
 		goto out;
 
-	head->rc_arg.len += info->ri_chunklen;
-	head->rc_arg.buflen += info->ri_chunklen;
+	buf->len += info->ri_totalbytes;
+	buf->buflen += info->ri_totalbytes;
 
 	head->rc_hdr_count = 1;
-	head->rc_arg.head[0].iov_base = page_address(head->rc_pages[0]);
-	head->rc_arg.head[0].iov_len = min_t(size_t, PAGE_SIZE,
-					     info->ri_chunklen);
-
-	head->rc_arg.page_len = info->ri_chunklen -
-				head->rc_arg.head[0].iov_len;
+	buf->head[0].iov_base = page_address(head->rc_pages[0]);
+	buf->head[0].iov_len = min_t(size_t, PAGE_SIZE, info->ri_totalbytes);
+	buf->page_len = info->ri_totalbytes - buf->head[0].iov_len;
 
 out:
 	return ret;
@@ -890,6 +888,7 @@ int svc_rdma_recv_read_chunk(struct svcxprt_rdma *rdma, struct svc_rqst *rqstp,
 	info->ri_readctxt = head;
 	info->ri_pageno = 0;
 	info->ri_pageoff = 0;
+	info->ri_totalbytes = 0;
 
 	info->ri_position = be32_to_cpup(p + 1);
 	if (info->ri_position)


