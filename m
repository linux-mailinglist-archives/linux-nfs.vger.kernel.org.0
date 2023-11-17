Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E625A7EFB3C
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Nov 2023 23:14:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233844AbjKQWOv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Nov 2023 17:14:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232628AbjKQWOv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Nov 2023 17:14:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31BCD4E
        for <linux-nfs@vger.kernel.org>; Fri, 17 Nov 2023 14:14:47 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7132FC433C8
        for <linux-nfs@vger.kernel.org>; Fri, 17 Nov 2023 22:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700259287;
        bh=9oe8uXCu9s6YhWdGkxYpeJvuS+hFH9+8s2vul0ErwoA=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=s5t9kyKSsmEd4H1xyGDWQr3AgUWILwL0dCHjHjZl964c5lkv18eD9yb9rODC8LqiE
         1OL7eLxUuMeYKz5ojU3HVXPBp2R0Ie5+V/Jdd0rkJksJMy3eJqi8sFSynFix5ymt3L
         1y/Y3zhoDZWX+NbBRGjqzW9T9qpmsNDNCwV5PLhKIFoeZZVAY1ARAepNNNcgLnpBsT
         zCgDp91oTUgomodPNgJXCWLCEdxv1EgD35e0udxAYUWbAEVmo2WpRywBanRZbBf4aB
         0wQhcrC8sZfTGKLrOOyzJFEkc/WhbxjCmZ5T2i/G8JvRr6rKfR/Zz4HJ4aFsc4GXG5
         4ehTaExiPkhXQ==
Subject: [PATCH v2 4/4] SUNRPC: Remove RQ_SPLICE_OK
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 17 Nov 2023 17:14:46 -0500
Message-ID: <170025928643.4577.11219746525309912238.stgit@bazille.1015granger.net>
In-Reply-To: <170025895725.4577.18051288602708688381.stgit@bazille.1015granger.net>
References: <170025895725.4577.18051288602708688381.stgit@bazille.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

This flag is no longer used.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc.h        |    2 --
 include/trace/events/sunrpc.h     |    1 -
 net/sunrpc/auth_gss/svcauth_gss.c |   10 ----------
 net/sunrpc/svc.c                  |    2 --
 4 files changed, 15 deletions(-)

diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index b10f987509cc..544fcfe07479 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -260,8 +260,6 @@ enum {
 	RQ_LOCAL,		/* local request */
 	RQ_USEDEFERRAL,		/* use deferral */
 	RQ_DROPME,		/* drop current reply */
-	RQ_SPLICE_OK,		/* turned off in gss privacy to prevent
-				 * encrypting page cache pages */
 	RQ_VICTIM,		/* Have agreed to shut down */
 	RQ_DATA,		/* request has data */
 };
diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index 337c90787fb1..cdd3a45e6003 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -1675,7 +1675,6 @@ DEFINE_SVCXDRBUF_EVENT(sendto);
 	svc_rqst_flag(LOCAL)						\
 	svc_rqst_flag(USEDEFERRAL)					\
 	svc_rqst_flag(DROPME)						\
-	svc_rqst_flag(SPLICE_OK)					\
 	svc_rqst_flag(VICTIM)						\
 	svc_rqst_flag_end(DATA)
 
diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svcauth_gss.c
index 104d9a320142..24de94184700 100644
--- a/net/sunrpc/auth_gss/svcauth_gss.c
+++ b/net/sunrpc/auth_gss/svcauth_gss.c
@@ -866,14 +866,6 @@ svcauth_gss_unwrap_integ(struct svc_rqst *rqstp, u32 seq, struct gss_ctx *ctx)
 	struct xdr_buf databody_integ;
 	struct xdr_netobj checksum;
 
-	/* NFS READ normally uses splice to send data in-place. However
-	 * the data in cache can change after the reply's MIC is computed
-	 * but before the RPC reply is sent. To prevent the client from
-	 * rejecting the server-computed MIC in this somewhat rare case,
-	 * do not use splice with the GSS integrity service.
-	 */
-	clear_bit(RQ_SPLICE_OK, &rqstp->rq_flags);
-
 	/* Did we already verify the signature on the original pass through? */
 	if (rqstp->rq_deferred)
 		return 0;
@@ -948,8 +940,6 @@ svcauth_gss_unwrap_priv(struct svc_rqst *rqstp, u32 seq, struct gss_ctx *ctx)
 	struct xdr_buf *buf = xdr->buf;
 	unsigned int saved_len;
 
-	clear_bit(RQ_SPLICE_OK, &rqstp->rq_flags);
-
 	if (xdr_stream_decode_u32(xdr, &len) < 0)
 		goto unwrap_failed;
 	if (rqstp->rq_deferred) {
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 3f2ea7a0496f..fa4e23fa0e09 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1305,8 +1305,6 @@ svc_process_common(struct svc_rqst *rqstp)
 	int			rc;
 	__be32			*p;
 
-	/* Will be turned off by GSS integrity and privacy services */
-	set_bit(RQ_SPLICE_OK, &rqstp->rq_flags);
 	/* Will be turned off only when NFSv4 Sessions are used */
 	set_bit(RQ_USEDEFERRAL, &rqstp->rq_flags);
 	clear_bit(RQ_DROPME, &rqstp->rq_flags);


