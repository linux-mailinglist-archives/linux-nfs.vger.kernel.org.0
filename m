Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45EB566169D
	for <lists+linux-nfs@lfdr.de>; Sun,  8 Jan 2023 17:29:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234911AbjAHQ3h (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 8 Jan 2023 11:29:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236122AbjAHQ3c (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 8 Jan 2023 11:29:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07570E0B3
        for <linux-nfs@vger.kernel.org>; Sun,  8 Jan 2023 08:29:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A6DB2B801C1
        for <linux-nfs@vger.kernel.org>; Sun,  8 Jan 2023 16:29:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40FC9C433F0
        for <linux-nfs@vger.kernel.org>; Sun,  8 Jan 2023 16:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673195367;
        bh=EJf06XE3BIgFkfJUevBRppykrXg0S9c6ZdtJsFsdXys=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=VQCJiNZZpHG0TYx2KeppbOqgms5rmmFB/qTQfvjADCo8jvXpRDPMaAJPFJM1Jk93V
         449ubQ4utZdhVUZ33sOcRa3PvDLqFp3nVWyzah0y/lq8idWkVn4WDyGsEjhxARkmPv
         T0swapudpKG341Kr0iH/oKPVS/3DRYXqiHHj+K2PkzWb60bjmueJJty4VdJjvW5OcG
         RkVyHxI56ac2rDnhyBg9N5DPU2opOc9wCif57/QZaEs7QirsrHG1SxO6IRnPES4Ten
         Mt1RtqqeigZ4pCi3ldaoxbFMDYqldjvlx/AjLRMQO4TLWZBkDpLCzp2tal7BmNSu4z
         F1X64rpNsU3tQ==
Subject: [PATCH v1 10/27] SUNRPC: Check rq_auth_stat when preparing to wrap a
 response
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Date:   Sun, 08 Jan 2023 11:29:26 -0500
Message-ID: <167319536633.7490.17297229100823594696.stgit@bazille.1015granger.net>
In-Reply-To: <167319499150.7490.2294168831574653380.stgit@bazille.1015granger.net>
References: <167319499150.7490.2294168831574653380.stgit@bazille.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

Commit 5b304bc5bfcc ("[PATCH] knfsd: svcrpc: gss: fix failure on
SVC_DENIED in integrity case") added a check to prevent wrapping an
RPC response if reply_stat == MSG_DENIED, assuming that the only way
to get to svcauth_gss_release() with that reply_stat value was if
the reject_stat was AUTH_ERROR (reject_stat == MISMATCH is handled
earlier in svc_process_common()).

The code there is somewhat confusing. For one thing, rpc_success is
an accept_stat value, not a reply_stat value. The correct reply_stat
value to look for is RPC_MSG_DENIED. It happens to be the same value
as rpc_success, so it all works out, but it's not terribly readable.

Since commit 438623a06bac ("SUNRPC: Add svc_rqst::rq_auth_stat"),
the actual auth_stat value is stored in the svc_rqst, so that value
is now available to svcauth_gss_prepare_to_wrap() to make its
decision to wrap, based on direct information about the
authentication status of the RPC caller.

No behavior change is intended, this simply replaces some old code
with something that should be more self-documenting.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/auth_gss/svcauth_gss.c |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svcauth_gss.c
index 6c49750c0f7a..71a147b0f90b 100644
--- a/net/sunrpc/auth_gss/svcauth_gss.c
+++ b/net/sunrpc/auth_gss/svcauth_gss.c
@@ -1732,17 +1732,19 @@ svcauth_gss_accept(struct svc_rqst *rqstp)
 }
 
 static __be32 *
-svcauth_gss_prepare_to_wrap(struct xdr_buf *resbuf, struct gss_svc_data *gsd)
+svcauth_gss_prepare_to_wrap(struct svc_rqst *rqstp, struct gss_svc_data *gsd)
 {
+	struct xdr_buf *resbuf = &rqstp->rq_res;
 	__be32 *p;
 	u32 verf_len;
 
 	p = gsd->verf_start;
 	gsd->verf_start = NULL;
 
-	/* If the reply stat is nonzero, don't wrap: */
-	if (*(p-1) != rpc_success)
+	/* AUTH_ERROR replies are not wrapped. */
+	if (rqstp->rq_auth_stat != rpc_auth_ok)
 		return NULL;
+
 	/* Skip the verifier: */
 	p += 1;
 	verf_len = ntohl(*p++);
@@ -1786,7 +1788,7 @@ static int svcauth_gss_wrap_integ(struct svc_rqst *rqstp)
 	u32 offset, len, maj_stat;
 	__be32 *p;
 
-	p = svcauth_gss_prepare_to_wrap(buf, gsd);
+	p = svcauth_gss_prepare_to_wrap(rqstp, gsd);
 	if (p == NULL)
 		goto out;
 
@@ -1846,7 +1848,7 @@ static int svcauth_gss_wrap_priv(struct svc_rqst *rqstp)
 	u32 offset, pad, maj_stat;
 	__be32 *p, *lenp;
 
-	p = svcauth_gss_prepare_to_wrap(buf, gsd);
+	p = svcauth_gss_prepare_to_wrap(rqstp, gsd);
 	if (p == NULL)
 		return 0;
 


