Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33A393E4BE7
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Aug 2021 20:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234930AbhHISMT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Aug 2021 14:12:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:52852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231357AbhHISMS (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 9 Aug 2021 14:12:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D650E60F6F
        for <linux-nfs@vger.kernel.org>; Mon,  9 Aug 2021 18:11:57 +0000 (UTC)
Subject: [PATCH] SUNRPC: Add RPC_AUTH_TLS protocol numbers
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 09 Aug 2021 14:11:57 -0400
Message-ID: <162853266949.4997.17269324922537839389.stgit@klimt.1015granger.net>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Shared by client and server. See:

https://www.iana.org/assignments/rpc-authentication-numbers/rpc-authentication-numbers.xhtml

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/msg_prot.h |    1 +
 include/linux/sunrpc/xdr.h      |    1 +
 2 files changed, 2 insertions(+)

Adding this now means I can introduce support for RPC-with-TLS on
either the client or server in any order.

diff --git a/include/linux/sunrpc/msg_prot.h b/include/linux/sunrpc/msg_prot.h
index 938c2bf29db8..02117ed0fa2e 100644
--- a/include/linux/sunrpc/msg_prot.h
+++ b/include/linux/sunrpc/msg_prot.h
@@ -20,6 +20,7 @@ enum rpc_auth_flavors {
 	RPC_AUTH_DES   = 3,
 	RPC_AUTH_KRB   = 4,
 	RPC_AUTH_GSS   = 6,
+	RPC_AUTH_TLS   = 7,
 	RPC_AUTH_MAXFLAVOR = 8,
 	/* pseudoflavors: */
 	RPC_AUTH_GSS_KRB5  = 390003,
diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
index a965cbc136ad..b519609af1d0 100644
--- a/include/linux/sunrpc/xdr.h
+++ b/include/linux/sunrpc/xdr.h
@@ -95,6 +95,7 @@ xdr_buf_init(struct xdr_buf *buf, void *start, size_t len)
 #define	rpc_auth_unix	cpu_to_be32(RPC_AUTH_UNIX)
 #define	rpc_auth_short	cpu_to_be32(RPC_AUTH_SHORT)
 #define	rpc_auth_gss	cpu_to_be32(RPC_AUTH_GSS)
+#define	rpc_auth_tls	cpu_to_be32(RPC_AUTH_TLS)
 
 #define	rpc_call	cpu_to_be32(RPC_CALL)
 #define	rpc_reply	cpu_to_be32(RPC_REPLY)


