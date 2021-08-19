Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9A9D3F193A
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Aug 2021 14:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235449AbhHSMaC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 19 Aug 2021 08:30:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:47224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231179AbhHSMaB (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 19 Aug 2021 08:30:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8F7E561100
        for <linux-nfs@vger.kernel.org>; Thu, 19 Aug 2021 12:29:25 +0000 (UTC)
Subject: [PATCH v1] SUNRPC: Ensure backchannel transports are marked connected
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Thu, 19 Aug 2021 08:29:24 -0400
Message-ID: <162937592206.2298.13447589794033256951.stgit@klimt.1015granger.net>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

With NFSv4.1+ on RDMA, backchannel recovery appears not to work.

xprt_setup_xxx_bc() is invoked by the client's first CREATE_SESSION
operation, and it always marks the rpc_clnt's transport as
connected.

On a subsequent CREATE_SESSION, if rpc_create() is called and
xpt_bc_xprt is populated, it might not be connected (for instance,
if a backchannel fault has occurred). Ensure that code path returns
a connected xprt also.

Reported-by: Timo Rothenpieler <timo@rothenpieler.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/clnt.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 8b4de70e8ead..570480a649a3 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -535,6 +535,7 @@ struct rpc_clnt *rpc_create(struct rpc_create_args *args)
 		xprt = args->bc_xprt->xpt_bc_xprt;
 		if (xprt) {
 			xprt_get(xprt);
+			xprt_set_connected(xprt);
 			return rpc_create_xprt(args, xprt);
 		}
 	}


