Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 743587ECAEE
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Nov 2023 20:02:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbjKOTCV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 15 Nov 2023 14:02:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbjKOTCU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 15 Nov 2023 14:02:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7428C19E
        for <linux-nfs@vger.kernel.org>; Wed, 15 Nov 2023 11:02:16 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C573BC433C7
        for <linux-nfs@vger.kernel.org>; Wed, 15 Nov 2023 19:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700074936;
        bh=St3CybL7wd/LaFAt8FmnsE4d4EpjuxX938p2qLC2Xu0=;
        h=From:To:Subject:Date:From;
        b=YrXfpiAIhi+ub3dl9K7bxIGP/W7vhq+NfJCARV76aaJ0tU/lH1Ggqggoz+8tGHj6H
         6j+Hnl40SJ+8U6GcOoRYs8T/9Li7IAyyQhGHS9H++JU9Ct+z3Awb9XIRmhYAfjMOQ3
         VCTqirFIg+32HhkefSPc7vW4wFcEpM1fSkmfLFD9+xOUqe3RXxeZNr9MksmqpiPzOp
         GWg92WhygaS0wyiq5pDjmXCngeh4wetnpZ6OvXSKR+8/dD1h3lq2MVxDopsEAj85GJ
         HRJrgPFcVsdxEVioHY1JwEEjtuQqOSpft+XKNbLI5W1etsPwcexRPY4Dxsg7j1S/ol
         axErQO7wYEkZg==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/3] NFSv4: Track the number of referring calls in struct cb_process_state
Date:   Wed, 15 Nov 2023 13:55:27 -0500
Message-ID: <20231115185529.303842-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

When the server gives us a set of referring calls, to tell us that the
NFSv4.1 callback needs to be ordered with respect to those calls, then
we may want to make that information available to the operations. In
certain cases, it may allow them to optimise their behaviour due to the
extra knowledge.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/callback.h      |  5 +++--
 fs/nfs/callback_proc.c | 11 ++++++++---
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/callback.h b/fs/nfs/callback.h
index ccd4f245cae2..cc1b6620a0c2 100644
--- a/fs/nfs/callback.h
+++ b/fs/nfs/callback.h
@@ -40,11 +40,12 @@ enum nfs4_callback_opnum {
 
 struct nfs4_slot;
 struct cb_process_state {
-	__be32			drc_status;
 	struct nfs_client	*clp;
 	struct nfs4_slot	*slot;
-	u32			minorversion;
 	struct net		*net;
+	u32			minorversion;
+	__be32			drc_status;
+	unsigned int		referring_calls;
 };
 
 struct cb_compound_hdr_arg {
diff --git a/fs/nfs/callback_proc.c b/fs/nfs/callback_proc.c
index 6bed1394d748..ebecd1f6409e 100644
--- a/fs/nfs/callback_proc.c
+++ b/fs/nfs/callback_proc.c
@@ -450,6 +450,7 @@ static int referring_call_exists(struct nfs_client *clp,
 	__acquires(lock)
 {
 	int status = 0;
+	int found = 0;
 	int i, j;
 	struct nfs4_session *session;
 	struct nfs4_slot_table *tbl;
@@ -478,11 +479,12 @@ static int referring_call_exists(struct nfs_client *clp,
 			spin_lock(lock);
 			if (status)
 				goto out;
+			found++;
 		}
 	}
 
 out:
-	return status;
+	return status < 0 ? status : found;
 }
 
 __be32 nfs4_callback_sequence(void *argp, void *resp,
@@ -493,6 +495,7 @@ __be32 nfs4_callback_sequence(void *argp, void *resp,
 	struct nfs4_slot_table *tbl;
 	struct nfs4_slot *slot;
 	struct nfs_client *clp;
+	int ret;
 	int i;
 	__be32 status = htonl(NFS4ERR_BADSESSION);
 
@@ -552,11 +555,13 @@ __be32 nfs4_callback_sequence(void *argp, void *resp,
 	 * related callback was received before the response to the original
 	 * call.
 	 */
-	if (referring_call_exists(clp, args->csa_nrclists, args->csa_rclists,
-				&tbl->slot_tbl_lock) < 0) {
+	ret = referring_call_exists(clp, args->csa_nrclists, args->csa_rclists,
+				    &tbl->slot_tbl_lock);
+	if (ret < 0) {
 		status = htonl(NFS4ERR_DELAY);
 		goto out_unlock;
 	}
+	cps->referring_calls = ret;
 
 	/*
 	 * RFC5661 20.9.3
-- 
2.41.0

