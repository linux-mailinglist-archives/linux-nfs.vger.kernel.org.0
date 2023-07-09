Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E24F274C7F8
	for <lists+linux-nfs@lfdr.de>; Sun,  9 Jul 2023 22:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjGIUFJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 9 Jul 2023 16:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjGIUFI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 9 Jul 2023 16:05:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F47FE
        for <linux-nfs@vger.kernel.org>; Sun,  9 Jul 2023 13:05:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3101860691
        for <linux-nfs@vger.kernel.org>; Sun,  9 Jul 2023 20:05:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DF29C433C7;
        Sun,  9 Jul 2023 20:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688933106;
        bh=aAHnJnucxrZOZRQ/gTjDMNguv+ZJw0XWnbv6SMqZelY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=LDwrQ9E+H08hXQKLIebjxIp/KTj0EGAdAewBh6kfkq7mYtvRXwhYVl03lHlqMB1sT
         oJ7WciTbfCEx7019ifx8bLsm/ScRFofma92Nl3kbV8uc28UhZ6hZSpLSkZMnGPHOrd
         Sev9AcNtR3HX8a8n+1kqmr8+bhvIR9VCQyXm5ZZ6aQeYO6ndTYQy4BQvClKTm5KsMm
         OdvABBz/eJSrZVvAidoMDu22AjCa4uF2199SbdacwRahaYD1nJ9rLKpgIFZCfwjqvx
         sL2qWUiGjUCv6POHtynx953lL8nMOzpovcMafJNXR5efISMsJl45pyFuZogZbJ3trg
         aKhvI+cnABzsg==
Subject: [PATCH RFC 2/4] SUNRPC: Convert svc_udp_sendto() to use the
 per-socket bio_vec array
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>, dhowells@redhat.com
Date:   Sun, 09 Jul 2023 16:05:05 -0400
Message-ID: <168893310550.1949.17162895369192976101.stgit@manet.1015granger.net>
In-Reply-To: <168893265677.1949.1632048925203798962.stgit@manet.1015granger.net>
References: <168893265677.1949.1632048925203798962.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

Commit da1661b93bf4 ("SUNRPC: Teach server to use xprt_sock_sendmsg
for socket sends") modified svc_udp_sendto() to use xprt_sock_sendmsg()
because we originally believed xprt_sock_sendmsg() would be needed
for TLS support. That does not actually appear to be the case.

In addition, the linkage between the client and server send code has
been a bit of a maintenance headache because of the distinct ways
that the client and server handle memory allocation.

Going forward, eventually the XDR layer will deal with its buffers
in the form of bio_vec arrays, so convert this function accordingly.
Once the use of bio_vecs is ubiquitous, the xdr_buf-to-bio_vec array
code can be hoisted into a path that is common for all transports.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/svcsock.c |   22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index d3c5f1a07979..ae7143f68343 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -729,7 +729,7 @@ static int svc_udp_sendto(struct svc_rqst *rqstp)
 		.msg_control	= cmh,
 		.msg_controllen	= sizeof(buffer),
 	};
-	unsigned int sent;
+	unsigned int count;
 	int err;
 
 	svc_udp_release_ctxt(xprt, rqstp->rq_xprt_ctxt);
@@ -742,22 +742,22 @@ static int svc_udp_sendto(struct svc_rqst *rqstp)
 	if (svc_xprt_is_dead(xprt))
 		goto out_notconn;
 
-	err = xdr_alloc_bvec(xdr, GFP_KERNEL);
-	if (err < 0)
-		goto out_unlock;
+	count = svc_sock_xdr_to_bvecs(svsk->sk_send_bvec, xdr);
 
-	err = xprt_sock_sendmsg(svsk->sk_sock, &msg, xdr, 0, 0, &sent);
+	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, svsk->sk_send_bvec,
+		      count, 0);
+	err = sock_sendmsg(svsk->sk_sock, &msg);
 	if (err == -ECONNREFUSED) {
 		/* ICMP error on earlier request. */
-		err = xprt_sock_sendmsg(svsk->sk_sock, &msg, xdr, 0, 0, &sent);
+		iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, svsk->sk_send_bvec,
+			      count, 0);
+		err = sock_sendmsg(svsk->sk_sock, &msg);
 	}
-	xdr_free_bvec(xdr);
+
 	trace_svcsock_udp_send(xprt, err);
-out_unlock:
+
 	mutex_unlock(&xprt->xpt_mutex);
-	if (err < 0)
-		return err;
-	return sent;
+	return err;
 
 out_notconn:
 	mutex_unlock(&xprt->xpt_mutex);


