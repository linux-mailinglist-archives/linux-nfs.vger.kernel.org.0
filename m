Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE1F278D834
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Aug 2023 20:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjH3S3S (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 30 Aug 2023 14:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244374AbjH3NGF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 30 Aug 2023 09:06:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF478193
        for <linux-nfs@vger.kernel.org>; Wed, 30 Aug 2023 06:06:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 70E8D60EEA
        for <linux-nfs@vger.kernel.org>; Wed, 30 Aug 2023 13:06:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83663C433C7;
        Wed, 30 Aug 2023 13:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693400761;
        bh=ta/ho+6RL6DjLVonP3LJG0ZtiP54AHXfa2qUFvLlwms=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dnpYMZWsYDRJ+mcCAJXWZsl+yMhl/WBrJqH8L0PNxtTuU9GhhXt4xPTUGsaK+23Nf
         7Kfiltqi5OsOmNJplbg28qBJ/e1xV8t1IxIUKAGEaqbk5bc/kj0CMk1TpW2QISg2+Z
         kPDzWD4IWh3iKmHK+dYXQn9STGyBcaoromJNMvHMsVN5oxzWrgYyJLIrbjQ0s6GxmB
         kL3CFG9FiWhnkAsbUsm3tnqML4xhGooqe2ciBou2dj4sUMH+htMZyUkDvPcb6f4tnE
         nYTuTZhvQYx/ynC/sg20Y/EHqdSPm1LpcJrdjTU7Ylcm5nBhQtbtFwKJHGCmXsxc21
         hk2mGBia1pFsQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     lorenzo.bianconi@redhat.com, chuck.lever@oracle.com,
        jlayton@kernel.org, neilb@suse.de
Subject: [PATCH v7 1/3] SUNRPC: export nfsd4_op_name utility routine
Date:   Wed, 30 Aug 2023 15:05:44 +0200
Message-ID: <a5eefdeedec2b8da34596a9f84a4bfe495591c7f.1693400242.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1693400242.git.lorenzo@kernel.org>
References: <cover.1693400242.git.lorenzo@kernel.org>
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

This is a preliminary patch to introduce nfsd_rpc_status netlink info
in order to dump pending RPC requests debugging information.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 fs/nfsd/nfs4proc.c | 4 +---
 fs/nfsd/nfsd.h     | 6 ++++++
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 5ca748309c26..074bac13c383 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2485,8 +2485,6 @@ static inline void nfsd4_increment_op_stats(u32 opnum)
 
 static const struct nfsd4_operation nfsd4_ops[];
 
-static const char *nfsd4_op_name(unsigned opnum);
-
 /*
  * Enforce NFSv4.1 COMPOUND ordering rules:
  *
@@ -3616,7 +3614,7 @@ void warn_on_nonidempotent_op(struct nfsd4_op *op)
 	}
 }
 
-static const char *nfsd4_op_name(unsigned opnum)
+const char *nfsd4_op_name(unsigned int opnum)
 {
 	if (opnum < ARRAY_SIZE(nfsd4_ops))
 		return nfsd4_ops[opnum].op_name;
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 11c14faa6c67..e95c3322eb9b 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -511,12 +511,18 @@ extern void nfsd4_ssc_init_umount_work(struct nfsd_net *nn);
 
 extern void nfsd4_init_leases_net(struct nfsd_net *nn);
 
+const char *nfsd4_op_name(unsigned int opnum);
 #else /* CONFIG_NFSD_V4 */
 static inline int nfsd4_is_junction(struct dentry *dentry)
 {
 	return 0;
 }
 
+static inline const char *nfsd4_op_name(unsigned int opnum)
+{
+	return "unknown_operation";
+}
+
 static inline void nfsd4_init_leases_net(struct nfsd_net *nn) { };
 
 #define register_cld_notifier() 0
-- 
2.41.0

