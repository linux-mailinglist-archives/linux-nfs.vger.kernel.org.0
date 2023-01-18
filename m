Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7116724FE
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Jan 2023 18:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbjARRcV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 18 Jan 2023 12:32:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbjARRcF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 18 Jan 2023 12:32:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F41C6599B4
        for <linux-nfs@vger.kernel.org>; Wed, 18 Jan 2023 09:31:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9058061937
        for <linux-nfs@vger.kernel.org>; Wed, 18 Jan 2023 17:31:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3208C433EF;
        Wed, 18 Jan 2023 17:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674063102;
        bh=yPiywXRNcT7TdD6zbyP1NHsB6cTGRS/CnB5JB7qsoNc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V450X0ZJnBo7e1VJ/RxtybNto8orTLn3YQAjqBAWelR/nNFpf/gW66TDLFchrdS7n
         7IMnIDXrQCGags/N4ZtsV3U+bVshxmFin7wYh4tv83/aRGPOwTyFrNy1jpOKdGQHKw
         Evji3x83/JyCi7j8Q88ZORcq4NfQBxpLdUkkBB+Ift88T2Y0o/W61vj9KGxc1YaVmP
         YasEVn0Q1u8SIxWuY0HVWFHRVRvQKBI5Ezoiqg8iWixRqU+1LXDC/4cSBC9uIhUzUu
         1qhDUNwX6HC8zmp9rGNgcQtIZSoxYYNBBarOYwGwT5vQCNPzCCniAylWqOX5qrv0LB
         lSW/16Oi3mz5A==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/6] nfsd: eliminate find_deleg_file_locked
Date:   Wed, 18 Jan 2023 12:31:35 -0500
Message-Id: <20230118173139.71846-3-jlayton@kernel.org>
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

We really don't need an accessor function here.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4state.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 4dd0e8dbcbfa..57f24e3e46a0 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -686,15 +686,6 @@ static struct nfsd_file *find_any_file_locked(struct nfs4_file *f)
 	return NULL;
 }
 
-static struct nfsd_file *find_deleg_file_locked(struct nfs4_file *f)
-{
-	lockdep_assert_held(&f->fi_lock);
-
-	if (f->fi_deleg_file)
-		return f->fi_deleg_file;
-	return NULL;
-}
-
 static atomic_long_t num_delegations;
 unsigned long max_delegations;
 
@@ -2703,7 +2694,7 @@ static int nfs4_show_deleg(struct seq_file *s, struct nfs4_stid *st)
 	ds = delegstateid(st);
 	nf = st->sc_file;
 	spin_lock(&nf->fi_lock);
-	file = find_deleg_file_locked(nf);
+	file = nf->fi_deleg_file;
 	if (!file)
 		goto out;
 
-- 
2.39.0

