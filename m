Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 286A27261D9
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Jun 2023 15:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235026AbjFGN7D (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 7 Jun 2023 09:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240248AbjFGN7C (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 7 Jun 2023 09:59:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B10B1BD9
        for <linux-nfs@vger.kernel.org>; Wed,  7 Jun 2023 06:59:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 27A3A637D9
        for <linux-nfs@vger.kernel.org>; Wed,  7 Jun 2023 13:59:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 259B0C433D2;
        Wed,  7 Jun 2023 13:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686146340;
        bh=LMHuRd5WPLT8qIpWgE1SH25bjVB8IUFgTNdqEunPsTo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=VqYUgFrqvJQjJWEgxxG4JOMQweqIuIPI0bgbao4iTn5SlqO27X8AJ41nOdFGAUHIU
         ewqSi28RL6XN7Ngw11hiJH6/iZYgkU0rKrZ2hwIJGT1bR8Y5biyRqs+DZgO96AutQp
         WGr/eR4fwo2pI202rrbJFyGcf6s2/4SNKVDUjY5m0Aezqks+g9ZUZPuJNaYkC/0SaD
         uNas7bZUJbvC/ttAkO9QnmEq/Oo9SxBauv2JLCkxLxRqliDgUX98rMUH7cY98I1iIR
         JQ/5IoNs7lC2k8amxJAN+5AYsINn5+kWSX8iUl2gXr+4ug7CsxaIdziQMGT9XXNofl
         2MwLN6GvUfYHg==
Subject: [PATCH v4 6/9] SUNRPC: Capture CMSG metadata on client-side receive
From:   Chuck Lever <cel@kernel.org>
To:     anna.schumaker@netapp.com, trondmy@hammerspace.com
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        kernel-tls-handshake@lists.linux.dev
Date:   Wed, 07 Jun 2023 09:58:49 -0400
Message-ID: <168614631895.2082.7594259929276216556.stgit@oracle-102.nfsv4bat.org>
In-Reply-To: <168614594328.2082.13408337606138447754.stgit@oracle-102.nfsv4bat.org>
References: <168614594328.2082.13408337606138447754.stgit@oracle-102.nfsv4bat.org>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

kTLS sockets use CMSG to report decryption errors and the need
for session re-keying.

For RPC-with-TLS, an "application data" message contains a ULP
payload, and that is passed along to the RPC client. An "alert"
message triggers connection reset. Everything else is discarded.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
---
 net/sunrpc/xprtsock.c |   49 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 47 insertions(+), 2 deletions(-)

diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index 37f608c2c0a0..6f2fc863b47e 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -47,6 +47,8 @@
 #include <net/checksum.h>
 #include <net/udp.h>
 #include <net/tcp.h>
+#include <net/tls.h>
+
 #include <linux/bvec.h>
 #include <linux/highmem.h>
 #include <linux/uio.h>
@@ -342,13 +344,56 @@ xs_alloc_sparse_pages(struct xdr_buf *buf, size_t want, gfp_t gfp)
 	return want;
 }
 
+static int
+xs_sock_process_cmsg(struct socket *sock, struct msghdr *msg,
+		     struct cmsghdr *cmsg, int ret)
+{
+	if (cmsg->cmsg_level == SOL_TLS &&
+	    cmsg->cmsg_type == TLS_GET_RECORD_TYPE) {
+		u8 content_type = *((u8 *)CMSG_DATA(cmsg));
+
+		switch (content_type) {
+		case TLS_RECORD_TYPE_DATA:
+			/* TLS sets EOR at the end of each application data
+			 * record, even though there might be more frames
+			 * waiting to be decrypted.
+			 */
+			msg->msg_flags &= ~MSG_EOR;
+			break;
+		case TLS_RECORD_TYPE_ALERT:
+			ret = -ENOTCONN;
+			break;
+		default:
+			ret = -EAGAIN;
+		}
+	}
+	return ret;
+}
+
+static int
+xs_sock_recv_cmsg(struct socket *sock, struct msghdr *msg, int flags)
+{
+	union {
+		struct cmsghdr	cmsg;
+		u8		buf[CMSG_SPACE(sizeof(u8))];
+	} u;
+	int ret;
+
+	msg->msg_control = &u;
+	msg->msg_controllen = sizeof(u);
+	ret = sock_recvmsg(sock, msg, flags);
+	if (msg->msg_controllen != sizeof(u))
+		ret = xs_sock_process_cmsg(sock, msg, &u.cmsg, ret);
+	return ret;
+}
+
 static ssize_t
 xs_sock_recvmsg(struct socket *sock, struct msghdr *msg, int flags, size_t seek)
 {
 	ssize_t ret;
 	if (seek != 0)
 		iov_iter_advance(&msg->msg_iter, seek);
-	ret = sock_recvmsg(sock, msg, flags);
+	ret = xs_sock_recv_cmsg(sock, msg, flags);
 	return ret > 0 ? ret + seek : ret;
 }
 
@@ -374,7 +419,7 @@ xs_read_discard(struct socket *sock, struct msghdr *msg, int flags,
 		size_t count)
 {
 	iov_iter_discard(&msg->msg_iter, ITER_DEST, count);
-	return sock_recvmsg(sock, msg, flags);
+	return xs_sock_recv_cmsg(sock, msg, flags);
 }
 
 #if ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE


