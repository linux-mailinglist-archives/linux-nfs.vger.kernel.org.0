Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 619DC5832F4
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Jul 2022 21:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235743AbiG0THh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 27 Jul 2022 15:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232259AbiG0THP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 27 Jul 2022 15:07:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D27C34
        for <linux-nfs@vger.kernel.org>; Wed, 27 Jul 2022 11:40:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 35EDF619D7
        for <linux-nfs@vger.kernel.org>; Wed, 27 Jul 2022 18:40:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BCD2C433C1
        for <linux-nfs@vger.kernel.org>; Wed, 27 Jul 2022 18:40:48 +0000 (UTC)
Subject: [PATCH v2 08/13] NFSD: Refactor nfsd4_cleanup_inter_ssc() (1/2)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Wed, 27 Jul 2022 14:40:47 -0400
Message-ID: <165894724747.11193.12492747446677624014.stgit@manet.1015granger.net>
In-Reply-To: <165894669884.11193.6386905165076468843.stgit@manet.1015granger.net>
References: <165894669884.11193.6386905165076468843.stgit@manet.1015granger.net>
User-Agent: StGit/1.5.dev2+g9ce680a5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The @src parameter is sometimes a pointer to a struct nfsd_file and
sometimes a pointer to struct file hiding in a phony struct
nfsd_file. Refactor nfsd4_cleanup_inter_ssc() so the @src parameter
is always an explicit struct file.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4proc.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 0d0834f728e0..b6e1fb8006cd 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1554,7 +1554,7 @@ nfsd4_setup_inter_ssc(struct svc_rqst *rqstp,
 }
 
 static void
-nfsd4_cleanup_inter_ssc(struct vfsmount *ss_mnt, struct nfsd_file *src,
+nfsd4_cleanup_inter_ssc(struct vfsmount *ss_mnt, struct file *filp,
 			struct nfsd_file *dst)
 {
 	bool found = false;
@@ -1563,9 +1563,9 @@ nfsd4_cleanup_inter_ssc(struct vfsmount *ss_mnt, struct nfsd_file *src,
 	struct nfsd4_ssc_umount_item *ni = NULL;
 	struct nfsd_net *nn = net_generic(dst->nf_net, nfsd_net_id);
 
-	nfs42_ssc_close(src->nf_file);
+	nfs42_ssc_close(filp);
 	nfsd_file_put(dst);
-	fput(src->nf_file);
+	fput(filp);
 
 	if (!nn) {
 		mntput(ss_mnt);
@@ -1608,7 +1608,7 @@ nfsd4_setup_inter_ssc(struct svc_rqst *rqstp,
 }
 
 static void
-nfsd4_cleanup_inter_ssc(struct vfsmount *ss_mnt, struct nfsd_file *src,
+nfsd4_cleanup_inter_ssc(struct vfsmount *ss_mnt, struct file *filp,
 			struct nfsd_file *dst)
 {
 }
@@ -1726,7 +1726,7 @@ static __be32 nfsd4_do_copy(struct nfsd4_copy *copy, bool sync)
 	}
 
 	if (nfsd4_ssc_is_inter(copy))
-		nfsd4_cleanup_inter_ssc(copy->ss_mnt, copy->nf_src,
+		nfsd4_cleanup_inter_ssc(copy->ss_mnt, copy->nf_src->nf_file,
 					copy->nf_dst);
 	else
 		nfsd4_cleanup_intra_ssc(copy->nf_src, copy->nf_dst);


