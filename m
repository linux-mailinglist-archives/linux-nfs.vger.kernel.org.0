Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4E595751C7
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Jul 2022 17:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240135AbiGNP2Z (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 14 Jul 2022 11:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239872AbiGNP2Y (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 14 Jul 2022 11:28:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F61491D1
        for <linux-nfs@vger.kernel.org>; Thu, 14 Jul 2022 08:28:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C66B61F32
        for <linux-nfs@vger.kernel.org>; Thu, 14 Jul 2022 15:28:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80E07C341C8;
        Thu, 14 Jul 2022 15:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657812502;
        bh=4dH+Z8EaITtBuQui+zpdms7bIDirkY3nsFZuy8eBYPI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MQFpgih/YnaSVdMdHNY1sdqhWQfs3EOYverkFlmX+DEHVXnRG/2hDmL8XfU5IP/Ve
         rAbyMcaY30VFcBszL0ce2WBpfofUzCsFNFisOtELzxThxHZEZziJkhAlXkAKlbF5NH
         qM8SxQzylpmCvAywCIajVLWE+HPXuUd2lPN/3sUlr1HdKUM5gVqryE5fWM51XJLALF
         NbAff0P4MSFBd1feVR2EJClb6tJfSD7Qasie8Htt+ykMocrXvPrq6Ft7946py4C4/S
         SHSy69LO50Lb0X5DvDSViiGXPR+Q9oHMrOCVflbL/5G/uYP2EfSttKKQt296QMXCLz
         G0M8BkprwOfyw==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     neilb@suse.de, linux-nfs@vger.kernel.org
Subject: [RFC PATCH 2/3] nfsd: rework arguments to nfs4_set_delegation
Date:   Thu, 14 Jul 2022 11:28:18 -0400
Message-Id: <20220714152819.128276-3-jlayton@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220714152819.128276-1-jlayton@kernel.org>
References: <20220714152819.128276-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

We'll need the nfs4_open to vet the filename. Change nfs4_set_delegation
to take the same arguments are nfs4_open_delegation.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4state.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 4f81c0bbd27b..347794028c98 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -5260,10 +5260,12 @@ static int nfsd4_check_conflicting_opens(struct nfs4_client *clp,
 }
 
 static struct nfs4_delegation *
-nfs4_set_delegation(struct nfs4_client *clp,
-		    struct nfs4_file *fp, struct nfs4_clnt_odstate *odstate)
+nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp)
 {
 	int status = 0;
+	struct nfs4_client *clp = stp->st_stid.sc_client;
+	struct nfs4_file *fp = stp->st_stid.sc_file;
+	struct nfs4_clnt_odstate *odstate = stp->st_clnt_odstate;
 	struct nfs4_delegation *dp;
 	struct nfsd_file *nf;
 	struct file_lock *fl;
@@ -5405,7 +5407,7 @@ nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp)
 		default:
 			goto out_no_deleg;
 	}
-	dp = nfs4_set_delegation(clp, stp->st_stid.sc_file, stp->st_clnt_odstate);
+	dp = nfs4_set_delegation(open, stp);
 	if (IS_ERR(dp))
 		goto out_no_deleg;
 
-- 
2.36.1

