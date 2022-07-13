Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4B2573F64
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Jul 2022 00:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbiGMWG7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 13 Jul 2022 18:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231764AbiGMWG7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 13 Jul 2022 18:06:59 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0768645074
        for <linux-nfs@vger.kernel.org>; Wed, 13 Jul 2022 15:06:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 5B846CE2408
        for <linux-nfs@vger.kernel.org>; Wed, 13 Jul 2022 22:06:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FCDCC34114
        for <linux-nfs@vger.kernel.org>; Wed, 13 Jul 2022 22:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657750014;
        bh=PnimvCTSEPy/VPzM7wzX/lk/TOZalXltCmOybNrRi3E=;
        h=From:To:Subject:Date:From;
        b=ZmwPTO/+8llNlda6Oq4IshD2L1gGrGIpXDxuwYIgVhkR14uSbUv9Pnz5dsaIdwj4z
         rkQiQymSNYGlFKLL+qujMQL+rz/3x8tO83Fqv/+QLkkMd0jzdHL926lwpTAbDsc3DR
         xTDH0CRuZT2rZc/XUE/lSZ7Oh8KckbIOsjLcDP119uEkYcSmGxzuCG0F1xjtB/LSaR
         WvzsrUOQw5c+walEatwNn22tV+6BM7MxWvpZ5htZny1LGG0EX1M7xAt9QuteZsEIjr
         eKkDME4NTuefaFJz3KOrx2MW+U5n4WAJveveNthTfsA5eSp00AyXQbj248l7MpUAae
         iGEF5rq2VuQpg==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH] NFSv4: Fix races in the legacy idmapper upcall
Date:   Wed, 13 Jul 2022 18:00:07 -0400
Message-Id: <20220713220007.1027142-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.36.1
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

From: Trond Myklebust <trond.myklebust@hammerspace.com>

nfs_idmap_instantiate() will cause the process that is waiting in
request_key_with_auxdata() to wake up and exit. If there is a second
process waiting for the idmap->idmap_mutex, then it may wake up and
start a new call to request_key_with_auxdata(). If the call to
idmap_pipe_downcall() from the first process has not yet finished
calling nfs_idmap_complete_pipe_upcall_locked(), then we may end up
triggering the WARN_ON_ONCE() in nfs_idmap_prepare_pipe_upcall().

The fix is to ensure that we clear idmap->idmap_upcall_data before
calling nfs_idmap_instantiate().

Fixes: e9ab41b620e4 ("NFSv4: Clean up the legacy idmapper upcall")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4idmap.c | 46 ++++++++++++++++++++++++----------------------
 1 file changed, 24 insertions(+), 22 deletions(-)

diff --git a/fs/nfs/nfs4idmap.c b/fs/nfs/nfs4idmap.c
index f331866dd418..ec6afd3c4bca 100644
--- a/fs/nfs/nfs4idmap.c
+++ b/fs/nfs/nfs4idmap.c
@@ -561,22 +561,20 @@ nfs_idmap_prepare_pipe_upcall(struct idmap *idmap,
 	return true;
 }
 
-static void
-nfs_idmap_complete_pipe_upcall_locked(struct idmap *idmap, int ret)
+static void nfs_idmap_complete_pipe_upcall(struct idmap_legacy_upcalldata *data,
+					   int ret)
 {
-	struct key *authkey = idmap->idmap_upcall_data->authkey;
-
-	kfree(idmap->idmap_upcall_data);
-	idmap->idmap_upcall_data = NULL;
-	complete_request_key(authkey, ret);
-	key_put(authkey);
+	complete_request_key(data->authkey, ret);
+	key_put(data->authkey);
+	kfree(data);
 }
 
-static void
-nfs_idmap_abort_pipe_upcall(struct idmap *idmap, int ret)
+static void nfs_idmap_abort_pipe_upcall(struct idmap *idmap,
+					struct idmap_legacy_upcalldata *data,
+					int ret)
 {
-	if (idmap->idmap_upcall_data != NULL)
-		nfs_idmap_complete_pipe_upcall_locked(idmap, ret);
+	if (cmpxchg(&idmap->idmap_upcall_data, data, NULL) == data)
+		nfs_idmap_complete_pipe_upcall(data, ret);
 }
 
 static int nfs_idmap_legacy_upcall(struct key *authkey, void *aux)
@@ -613,7 +611,7 @@ static int nfs_idmap_legacy_upcall(struct key *authkey, void *aux)
 
 	ret = rpc_queue_upcall(idmap->idmap_pipe, msg);
 	if (ret < 0)
-		nfs_idmap_abort_pipe_upcall(idmap, ret);
+		nfs_idmap_abort_pipe_upcall(idmap, data, ret);
 
 	return ret;
 out2:
@@ -669,6 +667,7 @@ idmap_pipe_downcall(struct file *filp, const char __user *src, size_t mlen)
 	struct request_key_auth *rka;
 	struct rpc_inode *rpci = RPC_I(file_inode(filp));
 	struct idmap *idmap = (struct idmap *)rpci->private;
+	struct idmap_legacy_upcalldata *data;
 	struct key *authkey;
 	struct idmap_msg im;
 	size_t namelen_in;
@@ -678,10 +677,11 @@ idmap_pipe_downcall(struct file *filp, const char __user *src, size_t mlen)
 	 * will have been woken up and someone else may now have used
 	 * idmap_key_cons - so after this point we may no longer touch it.
 	 */
-	if (idmap->idmap_upcall_data == NULL)
+	data = xchg(&idmap->idmap_upcall_data, NULL);
+	if (data == NULL)
 		goto out_noupcall;
 
-	authkey = idmap->idmap_upcall_data->authkey;
+	authkey = data->authkey;
 	rka = get_request_key_auth(authkey);
 
 	if (mlen != sizeof(im)) {
@@ -703,18 +703,17 @@ idmap_pipe_downcall(struct file *filp, const char __user *src, size_t mlen)
 	if (namelen_in == 0 || namelen_in == IDMAP_NAMESZ) {
 		ret = -EINVAL;
 		goto out;
-}
+	}
 
-	ret = nfs_idmap_read_and_verify_message(&im,
-			&idmap->idmap_upcall_data->idmap_msg,
-			rka->target_key, authkey);
+	ret = nfs_idmap_read_and_verify_message(&im, &data->idmap_msg,
+						rka->target_key, authkey);
 	if (ret >= 0) {
 		key_set_timeout(rka->target_key, nfs_idmap_cache_timeout);
 		ret = mlen;
 	}
 
 out:
-	nfs_idmap_complete_pipe_upcall_locked(idmap, ret);
+	nfs_idmap_complete_pipe_upcall(data, ret);
 out_noupcall:
 	return ret;
 }
@@ -728,7 +727,7 @@ idmap_pipe_destroy_msg(struct rpc_pipe_msg *msg)
 	struct idmap *idmap = data->idmap;
 
 	if (msg->errno)
-		nfs_idmap_abort_pipe_upcall(idmap, msg->errno);
+		nfs_idmap_abort_pipe_upcall(idmap, data, msg->errno);
 }
 
 static void
@@ -736,8 +735,11 @@ idmap_release_pipe(struct inode *inode)
 {
 	struct rpc_inode *rpci = RPC_I(inode);
 	struct idmap *idmap = (struct idmap *)rpci->private;
+	struct idmap_legacy_upcalldata *data;
 
-	nfs_idmap_abort_pipe_upcall(idmap, -EPIPE);
+	data = xchg(&idmap->idmap_upcall_data, NULL);
+	if (data)
+		nfs_idmap_complete_pipe_upcall(data, -EPIPE);
 }
 
 int nfs_map_name_to_uid(const struct nfs_server *server, const char *name, size_t namelen, kuid_t *uid)
-- 
2.36.1

