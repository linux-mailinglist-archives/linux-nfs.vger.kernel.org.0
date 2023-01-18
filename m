Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2011672503
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Jan 2023 18:32:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjARRcZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 18 Jan 2023 12:32:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbjARRcG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 18 Jan 2023 12:32:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA14B4A1CA
        for <linux-nfs@vger.kernel.org>; Wed, 18 Jan 2023 09:31:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D2506193C
        for <linux-nfs@vger.kernel.org>; Wed, 18 Jan 2023 17:31:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56DD4C433F0;
        Wed, 18 Jan 2023 17:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674063103;
        bh=qXd7UofDAndibDp5dcB6hRuW3pUs9PniI5D9/6geaVc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gdBFDZaO7yW/4uXTgWXUO0usuu/vK3cD6mY6xwHac+O8qki9wvmuGAPbcu/6ChQvh
         sPLpmud9SdYrTY3K5pfOUlo+a3umYgG87o/+5VqMEju/yzwckOU1P6DoBa+pQ2H2ZH
         H2HwdCbuTNN+Qi1QKdqOoonaXUo6B2NS93F6w0d6c5pkJpg3oSf857E1SBvG8JqdtZ
         vgFgmMTOA9ZF6ApXSD4Nv1QvasrySe4xytofpd1b6u/pVSWfdtapvCj/yrCGCLQQIl
         0jx53nwrSYTcQueOeoArgktnY7+XMuvOxQy6+hkuEe6hTdSDU4htpLd2OQfzftDrD6
         RBW7hbf4OgmTA==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 5/6] nfsd: add some kerneldoc comments for stateid preprocessing functions
Date:   Wed, 18 Jan 2023 12:31:38 -0500
Message-Id: <20230118173139.71846-6-jlayton@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230118173139.71846-1-jlayton@kernel.org>
References: <20230118173139.71846-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4state.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 57f24e3e46a0..06a95f25c522 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6539,8 +6539,19 @@ void nfs4_put_cpntf_state(struct nfsd_net *nn, struct nfs4_cpntf_state *cps)
 	spin_unlock(&nn->s2s_cp_lock);
 }
 
-/*
- * Checks for stateid operations
+/**
+ * nfs4_preprocess_stateid_op - find and prep stateid for an operation
+ * @rqstp: incoming request from client
+ * @cstate: current compound state
+ * @fhp: filehandle associated with requested stateid
+ * @stateid: stateid (provided by client)
+ * @flags: flags describing type of operation to be done
+ * @nfp: optional nfsd_file return pointer (may be NULL)
+ * @cstid: optional returned nfs4_stid pointer (may be NULL)
+ *
+ * Given info from the client, look up a nfs4_stid for the operation. On
+ * success, it returns a reference to the nfs4_stid and/or the nfsd_file
+ * associated with it.
  */
 __be32
 nfs4_preprocess_stateid_op(struct svc_rqst *rqstp,
@@ -6729,8 +6740,18 @@ static __be32 nfs4_seqid_op_checks(struct nfsd4_compound_state *cstate, stateid_
 	return status;
 }
 
-/* 
- * Checks for sequence id mutating operations. 
+/**
+ * nfs4_preprocess_seqid_op - find and prep an ol_stateid for a seqid-morphing op
+ * @cstate: compund state
+ * @seqid: seqid (provided by client)
+ * @stateid: stateid (provided by client)
+ * @typemask: mask of allowable types for this operation
+ * @stpp: return pointer for the stateid found
+ * @nn: net namespace for request
+ *
+ * Given a stateid+seqid from a client, look up an nfs4_ol_stateid and
+ * return it in @stpp. On a nfs_ok return, the returned stateid will
+ * have its st_mutex locked.
  */
 static __be32
 nfs4_preprocess_seqid_op(struct nfsd4_compound_state *cstate, u32 seqid,
-- 
2.39.0

