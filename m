Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C353526AB6
	for <lists+linux-nfs@lfdr.de>; Fri, 13 May 2022 21:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383909AbiEMTpc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 May 2022 15:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383912AbiEMTpa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 May 2022 15:45:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4583781486
        for <linux-nfs@vger.kernel.org>; Fri, 13 May 2022 12:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652471127;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=DjEjP6C6JYx5V+r9rnRvLJrTWLyj2L7izsldTy4Vq7Y=;
        b=RIGO71KYjbQDqOVlIURVTsXwQhvu/kQaDY0r7bI9eniiBYsZBczjlpKhzzf7RjA5A4QSIi
        vy8ylfxgVn2q34dQwJAFssMulE+W+/mjjTTboLJG6HUrpx6OFr1Jg1SVjL59b9KdfYljP1
        KsYFoHhXfCObdvpCEV/dh8FTRLi3Cas=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-49-8qh-ZFgXPt2qKlk2G4g_Sg-1; Fri, 13 May 2022 15:45:24 -0400
X-MC-Unique: 8qh-ZFgXPt2qKlk2G4g_Sg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A80F680B712;
        Fri, 13 May 2022 19:45:23 +0000 (UTC)
Received: from bcodding.csb (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 95BD6111F3B6;
        Fri, 13 May 2022 19:45:23 +0000 (UTC)
Received: by bcodding.csb (Postfix, from userid 24008)
        id 4266A10C30F0; Fri, 13 May 2022 15:45:23 -0400 (EDT)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     trond.myklebust@hammerspace.com, anna@kernel.org
Cc:     linux-nfs@vger.kernel.org, smayhew@redhat.com
Subject: [PATCH] NFSv4: Fix free of uninitialized nfs4_label on referral lookup.
Date:   Fri, 13 May 2022 15:45:23 -0400
Message-Id: <bb098b69e0d8f36dad5634657ba1f3e1ce852427.1652471056.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Send along the already-allocated fattr along with nfs4_fs_locations, and
drop the memcpy of fattr.  We end up growing two more allocations, but this
fixes up a crash as:

PID: 790    TASK: ffff88811b43c000  CPU: 0   COMMAND: "ls"
 #0 [ffffc90000857920] panic at ffffffff81b9bfde
 #1 [ffffc900008579c0] do_trap at ffffffff81023a9b
 #2 [ffffc90000857a10] do_error_trap at ffffffff81023b78
 #3 [ffffc90000857a58] exc_stack_segment at ffffffff81be1f45
 #4 [ffffc90000857a80] asm_exc_stack_segment at ffffffff81c009de
 #5 [ffffc90000857b08] nfs_lookup at ffffffffa0302322 [nfs]
 #6 [ffffc90000857b70] __lookup_slow at ffffffff813a4a5f
 #7 [ffffc90000857c60] walk_component at ffffffff813a86c4
 #8 [ffffc90000857cb8] path_lookupat at ffffffff813a9553
 #9 [ffffc90000857cf0] filename_lookup at ffffffff813ab86b

Suggested-by: Trond Myklebust <trondmy@hammerspace.com>
Fixes: 9558a007dbc3 ("NFS: Remove the label from the nfs4_lookup_res struct")
Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 fs/nfs/nfs4namespace.c  |  4 ++++
 fs/nfs/nfs4proc.c       | 15 +++++++--------
 fs/nfs/nfs4state.c      |  8 +++++++-
 fs/nfs/nfs4xdr.c        |  4 ++--
 include/linux/nfs_xdr.h |  2 +-
 5 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/fs/nfs/nfs4namespace.c b/fs/nfs/nfs4namespace.c
index 3680c8da510c..de5f5db6c416 100644
--- a/fs/nfs/nfs4namespace.c
+++ b/fs/nfs/nfs4namespace.c
@@ -417,6 +417,9 @@ static int nfs_do_refmount(struct fs_context *fc, struct rpc_clnt *client)
 	fs_locations = kmalloc(sizeof(struct nfs4_fs_locations), GFP_KERNEL);
 	if (!fs_locations)
 		goto out_free;
+	fs_locations->fattr = nfs_alloc_fattr();
+	if (!fs_locations->fattr)
+		goto out_free;
 
 	/* Get locations */
 	dentry = ctx->clone_data.dentry;
@@ -436,6 +439,7 @@ static int nfs_do_refmount(struct fs_context *fc, struct rpc_clnt *client)
 
 	err = nfs_follow_referral(fc, fs_locations);
 out_free_2:
+	kfree(fs_locations->fattr);
 	kfree(fs_locations);
 out_free:
 	__free_page(page);
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index a79f66432bd3..0600f85b6016 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -4243,6 +4243,8 @@ static int nfs4_get_referral(struct rpc_clnt *client, struct inode *dir,
 	if (locations == NULL)
 		goto out;
 
+	locations->fattr = fattr;
+
 	status = nfs4_proc_fs_locations(client, dir, name, locations, page);
 	if (status != 0)
 		goto out;
@@ -4252,17 +4254,14 @@ static int nfs4_get_referral(struct rpc_clnt *client, struct inode *dir,
 	 * referral.  Cause us to drop into the exception handler, which
 	 * will kick off migration recovery.
 	 */
-	if (nfs_fsid_equal(&NFS_SERVER(dir)->fsid, &locations->fattr.fsid)) {
+	if (nfs_fsid_equal(&NFS_SERVER(dir)->fsid, &fattr->fsid)) {
 		dprintk("%s: server did not return a different fsid for"
 			" a referral at %s\n", __func__, name->name);
 		status = -NFS4ERR_MOVED;
 		goto out;
 	}
 	/* Fixup attributes for the nfs_lookup() call to nfs_fhget() */
-	nfs_fixup_referral_attributes(&locations->fattr);
-
-	/* replace the lookup nfs_fattr with the locations nfs_fattr */
-	memcpy(fattr, &locations->fattr, sizeof(struct nfs_fattr));
+	nfs_fixup_referral_attributes(fattr);
 	memset(fhandle, 0, sizeof(struct nfs_fh));
 out:
 	if (page)
@@ -7902,7 +7901,7 @@ static int _nfs4_proc_fs_locations(struct rpc_clnt *client, struct inode *dir,
 	else
 		bitmask[1] &= ~FATTR4_WORD1_MOUNTED_ON_FILEID;
 
-	nfs_fattr_init(&fs_locations->fattr);
+	nfs_fattr_init(fs_locations->fattr);
 	fs_locations->server = server;
 	fs_locations->nlocations = 0;
 	status = nfs4_call_sync(client, server, &msg, &args.seq_args, &res.seq_res, 0);
@@ -7967,7 +7966,7 @@ static int _nfs40_proc_get_locations(struct nfs_server *server,
 	unsigned long now = jiffies;
 	int status;
 
-	nfs_fattr_init(&locations->fattr);
+	nfs_fattr_init(locations->fattr);
 	locations->server = server;
 	locations->nlocations = 0;
 
@@ -8032,7 +8031,7 @@ static int _nfs41_proc_get_locations(struct nfs_server *server,
 	};
 	int status;
 
-	nfs_fattr_init(&locations->fattr);
+	nfs_fattr_init(locations->fattr);
 	locations->server = server;
 	locations->nlocations = 0;
 
diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index 9e1c987c81e7..067b0f1938f5 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -2106,6 +2106,11 @@ static int nfs4_try_migration(struct nfs_server *server, const struct cred *cred
 		dprintk("<-- %s: no memory\n", __func__);
 		goto out;
 	}
+	locations->fattr = nfs_alloc_fattr();
+	if (locations->fattr == NULL) {
+		dprintk("<-- %s: no memory\n", __func__);
+		goto out;
+	}
 
 	inode = d_inode(server->super->s_root);
 	result = nfs4_proc_get_locations(server, NFS_FH(inode), locations,
@@ -2120,7 +2125,7 @@ static int nfs4_try_migration(struct nfs_server *server, const struct cred *cred
 	if (!locations->nlocations)
 		goto out;
 
-	if (!(locations->fattr.valid & NFS_ATTR_FATTR_V4_LOCATIONS)) {
+	if (!(locations->fattr->valid & NFS_ATTR_FATTR_V4_LOCATIONS)) {
 		dprintk("<-- %s: No fs_locations data, migration skipped\n",
 			__func__);
 		goto out;
@@ -2145,6 +2150,7 @@ static int nfs4_try_migration(struct nfs_server *server, const struct cred *cred
 out:
 	if (page != NULL)
 		__free_page(page);
+	kfree(locations->fattr);
 	kfree(locations);
 	if (result) {
 		pr_err("NFS: migration recovery failed (server %s)\n",
diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index 86a5f6516928..5d822594336d 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -7051,7 +7051,7 @@ static int nfs4_xdr_dec_fs_locations(struct rpc_rqst *req,
 	if (res->migration) {
 		xdr_enter_page(xdr, PAGE_SIZE);
 		status = decode_getfattr_generic(xdr,
-					&res->fs_locations->fattr,
+					res->fs_locations->fattr,
 					 NULL, res->fs_locations,
 					 res->fs_locations->server);
 		if (status)
@@ -7064,7 +7064,7 @@ static int nfs4_xdr_dec_fs_locations(struct rpc_rqst *req,
 			goto out;
 		xdr_enter_page(xdr, PAGE_SIZE);
 		status = decode_getfattr_generic(xdr,
-					&res->fs_locations->fattr,
+					res->fs_locations->fattr,
 					 NULL, res->fs_locations,
 					 res->fs_locations->server);
 	}
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index 2863e5a69c6a..20e97329fe46 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -1212,7 +1212,7 @@ struct nfs4_fs_location {
 
 #define NFS4_FS_LOCATIONS_MAXENTRIES 10
 struct nfs4_fs_locations {
-	struct nfs_fattr fattr;
+	struct nfs_fattr *fattr;
 	const struct nfs_server *server;
 	struct nfs4_pathname fs_path;
 	int nlocations;
-- 
2.31.1

