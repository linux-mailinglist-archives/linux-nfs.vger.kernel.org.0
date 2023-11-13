Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AAEA7E9DE6
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Nov 2023 14:54:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbjKMNyz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 13 Nov 2023 08:54:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbjKMNyz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 13 Nov 2023 08:54:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4DD7D63
        for <linux-nfs@vger.kernel.org>; Mon, 13 Nov 2023 05:54:51 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 673DCC433C8
        for <linux-nfs@vger.kernel.org>; Mon, 13 Nov 2023 13:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699883691;
        bh=2oMBSpFCjKjwTWeCXSc7C4oUiorj/m+8tGUMft7GFvU=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=ERDHZRnrON1dzG4de5CmbW7rx3wUDwmdhLNcOs+JYZru3Tu/i00Tyk9J6gSwmb1ja
         UHRhQuucNtG8gMJPcBgj8UpRGnkFcHNQDc3eqZi2Cmyv4FICDKu1wI7XA5NQKc37ds
         u1njdJle6k/u4JIep8z1L599PSm/nz04+ovGlMpmyExj1QTHZJ2cWo4dAclBZ/mTLx
         pxLv0WIu681L2Ir0fbbBvkdCQ+OWlLJihHTGX8yeuaP+lBHUSQFT8Ak7R7zpPTIZT8
         NeoKH6iRYrCNjbrUHEms2aExAsIGk7SZzxeVn4BKovxOuP+2BA7x4DxSFPE3y/k6O2
         q/VQd8XxFMXqQ==
Subject: [PATCH v1 3/3] SUNRPC: Remove RQ_SPLICE_OK
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 13 Nov 2023 08:54:50 -0500
Message-ID: <169988369035.6844.15385959879891103636.stgit@bazille.1015granger.net>
In-Reply-To: <169988319025.6844.14300255016413760826.stgit@bazille.1015granger.net>
References: <169988319025.6844.14300255016413760826.stgit@bazille.1015granger.net>
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
index 18734e70c5dd..64323bbbc940 100644
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


