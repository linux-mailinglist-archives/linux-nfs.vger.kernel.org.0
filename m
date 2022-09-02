Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C363F5AB89F
	for <lists+linux-nfs@lfdr.de>; Fri,  2 Sep 2022 20:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbiIBSym (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 2 Sep 2022 14:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbiIBSyg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 2 Sep 2022 14:54:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B55B81EECE
        for <linux-nfs@vger.kernel.org>; Fri,  2 Sep 2022 11:54:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3F051B82D06
        for <linux-nfs@vger.kernel.org>; Fri,  2 Sep 2022 18:54:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D53C2C433C1
        for <linux-nfs@vger.kernel.org>; Fri,  2 Sep 2022 18:54:30 +0000 (UTC)
Subject: [PATCH v1] NFSD: Increase NFSD_MAX_OPS_PER_COMPOUND
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 02 Sep 2022 14:54:29 -0400
Message-ID: <166214486962.101939.2252490595444681944.stgit@bazille.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

When attempting an NFSv4 mount, a Solaris NFSv4 client builds a
single large COMPOUND that chains a series of LOOKUPs to get to the
pseudo filesystem root directory that is to be mounted. The Linux
NFS server's current maximum of 16 operations per NFSv4 COMPOUND is
not large enough to ensure that this works for paths that are more
than a few components deep.

Since NFSD_MAX_OPS_PER_COMPOUND is mostly a sanity check, and most
NFSv4 COMPOUNDS are between 3 and 6 operations (thus they do not
trigger any re-allocation of the operation array on the server),
increasing this maximum should result in little to no impact.

The ops array can get large now, so allocate it via vmalloc() to
help ensure memory fragmentation won't cause an allocation failure.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=216383
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |    5 ++---
 fs/nfsd/state.h   |    2 +-
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 1e9690a061ec..a04b9b29678f 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2369,10 +2369,9 @@ nfsd4_decode_compound(struct nfsd4_compoundargs *argp)
 		return true;
 
 	if (argp->opcnt > ARRAY_SIZE(argp->iops)) {
-		argp->ops = kzalloc(argp->opcnt * sizeof(*argp->ops), GFP_KERNEL);
+		argp->ops = vcalloc(argp->opcnt, sizeof(*argp->ops));
 		if (!argp->ops) {
 			argp->ops = argp->iops;
-			dprintk("nfsd: couldn't allocate room for COMPOUND\n");
 			return false;
 		}
 	}
@@ -5394,7 +5393,7 @@ void nfsd4_release_compoundargs(struct svc_rqst *rqstp)
 	struct nfsd4_compoundargs *args = rqstp->rq_argp;
 
 	if (args->ops != args->iops) {
-		kfree(args->ops);
+		vfree(args->ops);
 		args->ops = args->iops;
 	}
 	while (args->to_free) {
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index ae596dbf8667..5d28beb290fe 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -175,7 +175,7 @@ static inline struct nfs4_delegation *delegstateid(struct nfs4_stid *s)
 /* Maximum number of slots per session. 160 is useful for long haul TCP */
 #define NFSD_MAX_SLOTS_PER_SESSION     160
 /* Maximum number of operations per session compound */
-#define NFSD_MAX_OPS_PER_COMPOUND	16
+#define NFSD_MAX_OPS_PER_COMPOUND	50
 /* Maximum  session per slot cache size */
 #define NFSD_SLOT_CACHE_SIZE		2048
 /* Maximum number of NFSD_SLOT_CACHE_SIZE slots per session */


