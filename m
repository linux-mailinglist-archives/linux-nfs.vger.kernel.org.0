Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A24A774D7B
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Aug 2023 23:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbjHHV6O (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Aug 2023 17:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231559AbjHHV6F (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Aug 2023 17:58:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A320AFAEF3
        for <linux-nfs@vger.kernel.org>; Tue,  8 Aug 2023 09:40:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9441B62436
        for <linux-nfs@vger.kernel.org>; Tue,  8 Aug 2023 08:22:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 704EEC433C7;
        Tue,  8 Aug 2023 08:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691482920;
        bh=u4Iv7m3wbA6teKV4zQtZKUsleKxV917J51JwCepSy1E=;
        h=From:To:Cc:Subject:Date:From;
        b=L1+92ler0zTFElLgXSuKyPy3zmRIw82IH76lMR3h/+sR6vCaQLNR5WH0fpllZ+Grf
         14hAxO+6tvq3FtNTlWK8cmJycTZmO93A3uHAWasA6Vl1LvX4uQRAFd04+sk0t6JggC
         1dcdHVAiEOrujB2Z4MGL+TfRZulzb1TzKLDCg/JXXwLBTEGHdzXtgMH0Z9L9UsQfme
         Ygp22qAEG69q43hc2tZ1P60Xk56IunDUfZrKtwGN8+AuEz84OG+Z92xFUwgYFPRGwM
         /DJycovDHC5/hciEDiMU+4sT2s6uWJJutiYOEW3OG4njsTxZTCLAOvff0Qhs+DBv6c
         N7Wwf4+P+I68A==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     lorenzo.bianconi@redhat.com, chuck.lever@oracle.com,
        jlayton@kernel.org, neilb@suse.de
Subject: [PATCH] NFSD: add version field to nfsd_rpc_status_show handler
Date:   Tue,  8 Aug 2023 10:21:32 +0200
Message-ID: <6431d0ea2295a1e128f83cd76a419dee161e4c44.1691482815.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Introduce version field to nfsd_rpc_status handler in order to help
the user to maintain backward compatibility.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 fs/nfsd/nfssvc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 33ad91dd3a2d..6d5feeeb09a7 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -1117,6 +1117,9 @@ int nfsd_stats_release(struct inode *inode, struct file *file)
 	return ret;
 }
 
+/* Increment NFSD_RPC_STATUS_VERSION adding new info to the handler */
+#define NFSD_RPC_STATUS_VERSION		1
+
 static int nfsd_rpc_status_show(struct seq_file *m, void *v)
 {
 	struct inode *inode = file_inode(m->file);
@@ -1125,6 +1128,8 @@ static int nfsd_rpc_status_show(struct seq_file *m, void *v)
 
 	rcu_read_lock();
 
+	seq_printf(m, "# version %u\n", NFSD_RPC_STATUS_VERSION);
+
 	for (i = 0; i < nn->nfsd_serv->sv_nrpools; i++) {
 		struct svc_rqst *rqstp;
 
-- 
2.41.0

