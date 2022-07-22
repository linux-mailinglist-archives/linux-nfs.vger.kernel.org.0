Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 907E957E835
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Jul 2022 22:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236565AbiGVUTi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 22 Jul 2022 16:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236531AbiGVUTi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 22 Jul 2022 16:19:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA427F50A
        for <linux-nfs@vger.kernel.org>; Fri, 22 Jul 2022 13:19:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3BD14B82A1E
        for <linux-nfs@vger.kernel.org>; Fri, 22 Jul 2022 20:19:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D600AC341C6
        for <linux-nfs@vger.kernel.org>; Fri, 22 Jul 2022 20:19:34 +0000 (UTC)
Subject: [PATCH v1 06/11] NFSD: Refactor nfsd4_cleanup_inter_ssc() (1/2)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 22 Jul 2022 16:19:33 -0400
Message-ID: <165852117386.11403.1714921881094753525.stgit@manet.1015granger.net>
In-Reply-To: <165852076926.11403.44005570813790008.stgit@manet.1015granger.net>
References: <165852076926.11403.44005570813790008.stgit@manet.1015granger.net>
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
index e459384b8bee..bbefa2225f22 100644
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


