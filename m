Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E31AF77431B
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Aug 2023 19:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbjHHR5Y (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Aug 2023 13:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231955AbjHHR4q (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Aug 2023 13:56:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E655BF57B
        for <linux-nfs@vger.kernel.org>; Tue,  8 Aug 2023 09:25:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 473716242B
        for <linux-nfs@vger.kernel.org>; Tue,  8 Aug 2023 08:06:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A666C433C9;
        Tue,  8 Aug 2023 08:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691481964;
        bh=5C1rdLiZdhVA4aP2P+71/kqdkjGP4Exq3LXacDjyppY=;
        h=From:To:Cc:Subject:Date:From;
        b=u9lErawBTeYTj0UhWWMEvyvUfwVs+1jFZ5GNlWlhp4o1rH9U2AwKNxXKmeeYoSlnj
         rx53wXw9lkGXvp5i7OHjKOVC+SwoGIhdCPnLYSoP1jDCn+DL0ivBvb7tTXx6AsdBuY
         sTu0lPe+K1kTV+4rAcJ1R3wXy5pPmc2XD5fqWUL7LW57x7b4SyFE51SHGZkRwHjG1v
         7JpzKLkbnNGMmtIHj0jgdV/w4FHyUElR/3FSnXm2khIY/bDnlOj20VRz88lX8U7S93
         ol+/CzMKYb0TgTchioYm4wE0OvRB8YeuC8ph8KHDJRbO+TLeMb2esRHpxmkKMK0Rfo
         dYp4SWHzYsFUQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     lorenzo.bianconi@redhat.com, chuck.lever@oracle.com,
        jlayton@kernel.org, neilb@suse.de
Subject: [PATCH] NFSD: reduce code duplication between pool_stats_operations and nfsd_rpc_status_operations
Date:   Tue,  8 Aug 2023 10:05:45 +0200
Message-ID: <426191138f5801148a6f7df470ccb59d219452d6.1691481752.git.lorenzo@kernel.org>
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

Introduce nfsd_stats_open utility routine in order to reduce code
duplication between pool_stats_operations and
nfsd_rpc_status_operations.
Rename nfsd_pool_stats_release in nfsd_stats_release.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 fs/nfsd/nfsctl.c |  4 ++--
 fs/nfsd/nfsd.h   |  2 +-
 fs/nfsd/nfssvc.c | 35 ++++++++++++++++++++---------------
 3 files changed, 23 insertions(+), 18 deletions(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 6bf168b6a410..83eb5c6d894e 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -179,7 +179,7 @@ static const struct file_operations pool_stats_operations = {
 	.open		= nfsd_pool_stats_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
-	.release	= nfsd_pool_stats_release,
+	.release	= nfsd_stats_release,
 };
 
 DEFINE_SHOW_ATTRIBUTE(nfsd_reply_cache_stats);
@@ -200,7 +200,7 @@ static const struct file_operations nfsd_rpc_status_operations = {
 	.open		= nfsd_rpc_status_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
-	.release	= nfsd_pool_stats_release,
+	.release	= nfsd_stats_release,
 };
 
 /*
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 38c390fb2cf9..3e8a47b93fd4 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -93,7 +93,7 @@ int		nfsd_nrpools(struct net *);
 int		nfsd_get_nrthreads(int n, int *, struct net *);
 int		nfsd_set_nrthreads(int n, int *, struct net *);
 int		nfsd_pool_stats_open(struct inode *, struct file *);
-int		nfsd_pool_stats_release(struct inode *, struct file *);
+int		nfsd_stats_release(struct inode *, struct file *);
 int		nfsd_rpc_status_open(struct inode *inode, struct file *file);
 void		nfsd_shutdown_threads(struct net *net);
 
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 51a6f7a8d3f7..33ad91dd3a2d 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -1079,23 +1079,34 @@ bool nfssvc_encode_voidres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 	return true;
 }
 
-int nfsd_pool_stats_open(struct inode *inode, struct file *file)
+static int nfsd_stats_open(struct inode *inode)
 {
-	int ret;
 	struct nfsd_net *nn = net_generic(inode->i_sb->s_fs_info, nfsd_net_id);
 
 	mutex_lock(&nfsd_mutex);
-	if (nn->nfsd_serv == NULL) {
+	if (!nn->nfsd_serv) {
 		mutex_unlock(&nfsd_mutex);
 		return -ENODEV;
 	}
+
 	svc_get(nn->nfsd_serv);
-	ret = svc_pool_stats_open(nn->nfsd_serv, file);
 	mutex_unlock(&nfsd_mutex);
-	return ret;
+
+	return 0;
 }
 
-int nfsd_pool_stats_release(struct inode *inode, struct file *file)
+int nfsd_pool_stats_open(struct inode *inode, struct file *file)
+{
+	struct nfsd_net *nn = net_generic(inode->i_sb->s_fs_info, nfsd_net_id);
+	int ret = nfsd_stats_open(inode);
+
+	if (ret)
+		return ret;
+
+	return svc_pool_stats_open(nn->nfsd_serv, file);
+}
+
+int nfsd_stats_release(struct inode *inode, struct file *file)
 {
 	int ret = seq_release(inode, file);
 	struct net *net = inode->i_sb->s_fs_info;
@@ -1217,16 +1228,10 @@ static int nfsd_rpc_status_show(struct seq_file *m, void *v)
  */
 int nfsd_rpc_status_open(struct inode *inode, struct file *file)
 {
-	struct nfsd_net *nn = net_generic(inode->i_sb->s_fs_info, nfsd_net_id);
+	int ret = nfsd_stats_open(inode);
 
-	mutex_lock(&nfsd_mutex);
-	if (!nn->nfsd_serv) {
-		mutex_unlock(&nfsd_mutex);
-		return -ENODEV;
-	}
-
-	svc_get(nn->nfsd_serv);
-	mutex_unlock(&nfsd_mutex);
+	if (ret)
+		return ret;
 
 	return single_open(file, nfsd_rpc_status_show, inode->i_private);
 }
-- 
2.41.0

