Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA1AC31CED6
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Feb 2021 18:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbhBPRSL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 16 Feb 2021 12:18:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:60958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229784AbhBPRSH (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 16 Feb 2021 12:18:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9ADC064E00;
        Tue, 16 Feb 2021 17:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613495847;
        bh=JwtEat1/rew0SpIlCXKhFFFjKykjPHoA1e/Vn8m0zck=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QjQXQ8dUbJ49ZbkRWhZlhGryQwkrHbvTk3bbPUpOohIDQDL+E1+Z8z0oRZglQOMQ8
         zWT1zH6mRwL9Z2UVUirTBu464jHoHDx3KYnPkh70yiv1gandOxRi7KzKgHa+0vdMXM
         JnmZ/KoTCQxt2fMlm0Rh5pBAuFBWIajYdJFoIVJ593cLbz4H9xXlt7IpJDwYP1nPUR
         +lMY8+sv6sR7xH4QG5fsakN+bRor+0Fk6YcH3vti1QdXbwy5ut5hSZB1ClVigyuTg9
         ULcJYf1Ph8mmNfAmWD3SvqAk0lSpdiV+krrAxS5IiO/ZlmyqNxuVlxoxw9wyUVihyK
         zuhlgOjlWXGHQ==
From:   trondmy@kernel.org
To:     "J. Bruce Fields" <bfields@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/2] SUNRPC: Remove redundant socket flags from svc_tcp_sendmsg()
Date:   Tue, 16 Feb 2021 12:17:23 -0500
Message-Id: <20210216171723.342274-2-trondmy@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210216171723.342274-1-trondmy@kernel.org>
References: <20210216171723.342274-1-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Now that the caller controls the TCP_CORK socket option, it is redundant
to set MSG_MORE and MSG_SENDPAGE_NOTLAST in the calls to
kernel_sendpage().

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 net/sunrpc/svcsock.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index 231f510a4830..8c19732e425d 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -1088,12 +1088,11 @@ static int svc_tcp_sendmsg(struct socket *sock, struct msghdr *msg,
 		.iov_base	= &marker,
 		.iov_len	= sizeof(marker),
 	};
-	int flags, ret;
+	int ret;
 
 	*sentp = 0;
 	xdr_alloc_bvec(xdr, GFP_KERNEL);
 
-	msg->msg_flags = MSG_MORE;
 	ret = kernel_sendmsg(sock, msg, &rm, 1, rm.iov_len);
 	if (ret < 0)
 		return ret;
@@ -1101,8 +1100,7 @@ static int svc_tcp_sendmsg(struct socket *sock, struct msghdr *msg,
 	if (ret != rm.iov_len)
 		return -EAGAIN;
 
-	flags = head->iov_len < xdr->len ? MSG_MORE | MSG_SENDPAGE_NOTLAST : 0;
-	ret = svc_tcp_send_kvec(sock, head, flags);
+	ret = svc_tcp_send_kvec(sock, head, 0);
 	if (ret < 0)
 		return ret;
 	*sentp += ret;
@@ -1116,15 +1114,11 @@ static int svc_tcp_sendmsg(struct socket *sock, struct msghdr *msg,
 		bvec = xdr->bvec + (xdr->page_base >> PAGE_SHIFT);
 		offset = offset_in_page(xdr->page_base);
 		remaining = xdr->page_len;
-		flags = MSG_MORE | MSG_SENDPAGE_NOTLAST;
 		while (remaining > 0) {
-			if (remaining <= PAGE_SIZE && tail->iov_len == 0)
-				flags = 0;
-
 			len = min(remaining, bvec->bv_len - offset);
 			ret = kernel_sendpage(sock, bvec->bv_page,
 					      bvec->bv_offset + offset,
-					      len, flags);
+					      len, 0);
 			if (ret < 0)
 				return ret;
 			*sentp += ret;
-- 
2.29.2

