Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7378477731F
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Aug 2023 10:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234269AbjHJIkA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 10 Aug 2023 04:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232080AbjHJIj7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 10 Aug 2023 04:39:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C281BFA
        for <linux-nfs@vger.kernel.org>; Thu, 10 Aug 2023 01:39:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B11D76539D
        for <linux-nfs@vger.kernel.org>; Thu, 10 Aug 2023 08:39:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76F32C433C7;
        Thu, 10 Aug 2023 08:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691656798;
        bh=HET57c06WS3w0o2y7B+/vB7XDtL3fHevnrilCKjHhtg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t5LeamyE3O8Xe03tWVFGvQ2AcgWJGMTeio/KnsUmmDnNJSW6cuGWa5P5JRTjPkVG9
         nY+P0bSj+JVL7F5+APfIwhY6Vt3zdJdytBwpoxkGCCG6oMeuq3C4iAzrsetnqpb85E
         YILrVq4F99D7agGIOmd1PkKSpBqGD5iwrqPsTrfE9AC83mvYKDwDJOz4VuHix/4pus
         xglN4CyVLrbuvbzx+2bhPDaS1wyyUyU6bqUa0Igvjbhi3qODBt/srEozijXEeVH8n4
         uuLXtxKdXsDTRfwrdMD6BflfC5cPQFMu58F5Nb5WTmPED4Ll6MzSsQeRmx2tiDfgBJ
         bQG6Ixafh0mbg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     lorenzo.bianconi@redhat.com, chuck.lever@oracle.com,
        jlayton@kernel.org, neilb@suse.de
Subject: [PATCH v6 2/3] NFSD: introduce nfsd_stats_open utility routine
Date:   Thu, 10 Aug 2023 10:39:20 +0200
Message-ID: <64d34b7cd26097df0a6abc0fc24bff54775d724d.1691656474.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1691656474.git.lorenzo@kernel.org>
References: <cover.1691656474.git.lorenzo@kernel.org>
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
duplication between pool_stats_operations and the upcoming
nfsd_rpc_status_operations.
Rename nfsd_pool_stats_release in nfsd_stats_release.

Reviewed-by: NeilBrown <neilb@suse.de>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 fs/nfsd/nfsctl.c |  2 +-
 fs/nfsd/nfsd.h   |  2 +-
 fs/nfsd/nfssvc.c | 23 +++++++++++++++++------
 3 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 35d2e2cde1eb..dad88bff3b9e 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -178,7 +178,7 @@ static const struct file_operations pool_stats_operations = {
 	.open		= nfsd_pool_stats_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
-	.release	= nfsd_pool_stats_release,
+	.release	= nfsd_stats_release,
 };
 
 DEFINE_SHOW_ATTRIBUTE(nfsd_reply_cache_stats);
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 11c14faa6c67..55b9d85ed71b 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -93,7 +93,7 @@ int		nfsd_nrpools(struct net *);
 int		nfsd_get_nrthreads(int n, int *, struct net *);
 int		nfsd_set_nrthreads(int n, int *, struct net *);
 int		nfsd_pool_stats_open(struct inode *, struct file *);
-int		nfsd_pool_stats_release(struct inode *, struct file *);
+int		nfsd_stats_release(struct inode *, struct file *);
 void		nfsd_shutdown_threads(struct net *net);
 
 static inline void nfsd_put(struct net *net)
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 1582af33e204..460219030ce1 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -1064,23 +1064,34 @@ bool nfssvc_encode_voidres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
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
+}
+
+int nfsd_pool_stats_open(struct inode *inode, struct file *file)
+{
+	struct nfsd_net *nn = net_generic(inode->i_sb->s_fs_info, nfsd_net_id);
+	int ret = nfsd_stats_open(inode);
+
+	if (ret)
+		return ret;
+
+	return svc_pool_stats_open(nn->nfsd_serv, file);
 }
 
-int nfsd_pool_stats_release(struct inode *inode, struct file *file)
+int nfsd_stats_release(struct inode *inode, struct file *file)
 {
 	int ret = seq_release(inode, file);
 	struct net *net = inode->i_sb->s_fs_info;
-- 
2.41.0

