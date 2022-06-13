Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC88549AB2
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jun 2022 19:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbiFMR4C (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 13 Jun 2022 13:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239750AbiFMRyp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 13 Jun 2022 13:54:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AE3992DD9
        for <linux-nfs@vger.kernel.org>; Mon, 13 Jun 2022 06:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655127610;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=6qhy4E8DRGh0mW5qQ6vXjS66jet/9Dj6BAup48rZTn4=;
        b=F4zUDDxJqnEu15PegbK/hLKVMrjlXwX5cNtC6ti83uaddr44QEpITcTPLiQLQE++HAKWd/
        jf7XUIneaVxXK+sJ7WTVyYImXzhT1D763ze+ObMny5ycaHJKWNHl62Qg0fe3tWDfSLV698
        Y8xQcFSR7Kd7YBdkhlOSom7hwZt94/0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-606-k2me43KINyimTpTzcUZYtw-1; Mon, 13 Jun 2022 09:40:07 -0400
X-MC-Unique: k2me43KINyimTpTzcUZYtw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5763A380670E;
        Mon, 13 Jun 2022 13:40:07 +0000 (UTC)
Received: from bcodding.csb (ovpn-0-23.rdu2.redhat.com [10.22.0.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 390762026D2D;
        Mon, 13 Jun 2022 13:40:07 +0000 (UTC)
Received: by bcodding.csb (Postfix, from userid 24008)
        id 93F8710C30E0; Mon, 13 Jun 2022 09:40:06 -0400 (EDT)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     chuck.lever@oracle.com, trond.myklebust@hammerspace.com,
        anna@kernel.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] NLM: Defend against file_lock changes after vfs_test_lock()
Date:   Mon, 13 Jun 2022 09:40:06 -0400
Message-Id: <9688295e35c07d3b3d6c71970b6996348c2d8f1e.1654798464.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Instead of trusting that struct file_lock returns completely unchanged
after vfs_test_lock() when there's no conflicting lock, stash away our
nlm_lockowner reference so we can properly release it for all cases.

This defends against another file_lock implementation overwriting fl_owner
when the return type is F_UNLCK.

Reported-by: Roberto Bergantinos Corpas <rbergant@redhat.com>
Tested-by: Roberto Bergantinos Corpas <rbergant@redhat.com>
Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 fs/lockd/svc4proc.c         |  4 +++-
 fs/lockd/svclock.c          | 10 +---------
 fs/lockd/svcproc.c          |  5 ++++-
 include/linux/lockd/lockd.h |  1 +
 4 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index 176b468a61c7..4f247ab8be61 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -87,6 +87,7 @@ __nlm4svc_proc_test(struct svc_rqst *rqstp, struct nlm_res *resp)
 	struct nlm_args *argp = rqstp->rq_argp;
 	struct nlm_host	*host;
 	struct nlm_file	*file;
+	struct nlm_lockowner *test_owner;
 	__be32 rc = rpc_success;
 
 	dprintk("lockd: TEST4        called\n");
@@ -96,6 +97,7 @@ __nlm4svc_proc_test(struct svc_rqst *rqstp, struct nlm_res *resp)
 	if ((resp->status = nlm4svc_retrieve_args(rqstp, argp, &host, &file)))
 		return resp->status == nlm_drop_reply ? rpc_drop_reply :rpc_success;
 
+	test_owner = argp->lock.fl.fl_owner;
 	/* Now check for conflicting locks */
 	resp->status = nlmsvc_testlock(rqstp, file, host, &argp->lock, &resp->lock, &resp->cookie);
 	if (resp->status == nlm_drop_reply)
@@ -103,7 +105,7 @@ __nlm4svc_proc_test(struct svc_rqst *rqstp, struct nlm_res *resp)
 	else
 		dprintk("lockd: TEST4        status %d\n", ntohl(resp->status));
 
-	nlmsvc_release_lockowner(&argp->lock);
+	nlmsvc_put_lockowner(test_owner);
 	nlmsvc_release_host(host);
 	nlm_release_file(file);
 	return rc;
diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
index cb3658ab9b7a..9c1aa75441e1 100644
--- a/fs/lockd/svclock.c
+++ b/fs/lockd/svclock.c
@@ -340,7 +340,7 @@ nlmsvc_get_lockowner(struct nlm_lockowner *lockowner)
 	return lockowner;
 }
 
-static void nlmsvc_put_lockowner(struct nlm_lockowner *lockowner)
+void nlmsvc_put_lockowner(struct nlm_lockowner *lockowner)
 {
 	if (!refcount_dec_and_lock(&lockowner->count, &lockowner->host->h_lock))
 		return;
@@ -590,7 +590,6 @@ nlmsvc_testlock(struct svc_rqst *rqstp, struct nlm_file *file,
 	int			error;
 	int			mode;
 	__be32			ret;
-	struct nlm_lockowner	*test_owner;
 
 	dprintk("lockd: nlmsvc_testlock(%s/%ld, ty=%d, %Ld-%Ld)\n",
 				nlmsvc_file_inode(file)->i_sb->s_id,
@@ -604,9 +603,6 @@ nlmsvc_testlock(struct svc_rqst *rqstp, struct nlm_file *file,
 		goto out;
 	}
 
-	/* If there's a conflicting lock, remember to clean up the test lock */
-	test_owner = (struct nlm_lockowner *)lock->fl.fl_owner;
-
 	mode = lock_to_openmode(&lock->fl);
 	error = vfs_test_lock(file->f_file[mode], &lock->fl);
 	if (error) {
@@ -635,10 +631,6 @@ nlmsvc_testlock(struct svc_rqst *rqstp, struct nlm_file *file,
 	conflock->fl.fl_end = lock->fl.fl_end;
 	locks_release_private(&lock->fl);
 
-	/* Clean up the test lock */
-	lock->fl.fl_owner = NULL;
-	nlmsvc_put_lockowner(test_owner);
-
 	ret = nlm_lck_denied;
 out:
 	return ret;
diff --git a/fs/lockd/svcproc.c b/fs/lockd/svcproc.c
index 4dc1b40a489a..b09ca35b527c 100644
--- a/fs/lockd/svcproc.c
+++ b/fs/lockd/svcproc.c
@@ -116,6 +116,7 @@ __nlmsvc_proc_test(struct svc_rqst *rqstp, struct nlm_res *resp)
 	struct nlm_args *argp = rqstp->rq_argp;
 	struct nlm_host	*host;
 	struct nlm_file	*file;
+	struct nlm_lockowner *test_owner;
 	__be32 rc = rpc_success;
 
 	dprintk("lockd: TEST          called\n");
@@ -125,6 +126,8 @@ __nlmsvc_proc_test(struct svc_rqst *rqstp, struct nlm_res *resp)
 	if ((resp->status = nlmsvc_retrieve_args(rqstp, argp, &host, &file)))
 		return resp->status == nlm_drop_reply ? rpc_drop_reply :rpc_success;
 
+	test_owner = argp->lock.fl.fl_owner;
+
 	/* Now check for conflicting locks */
 	resp->status = cast_status(nlmsvc_testlock(rqstp, file, host, &argp->lock, &resp->lock, &resp->cookie));
 	if (resp->status == nlm_drop_reply)
@@ -133,7 +136,7 @@ __nlmsvc_proc_test(struct svc_rqst *rqstp, struct nlm_res *resp)
 		dprintk("lockd: TEST          status %d vers %d\n",
 			ntohl(resp->status), rqstp->rq_vers);
 
-	nlmsvc_release_lockowner(&argp->lock);
+	nlmsvc_put_lockowner(test_owner);
 	nlmsvc_release_host(host);
 	nlm_release_file(file);
 	return rc;
diff --git a/include/linux/lockd/lockd.h b/include/linux/lockd/lockd.h
index fcef192e5e45..70ce419e2709 100644
--- a/include/linux/lockd/lockd.h
+++ b/include/linux/lockd/lockd.h
@@ -292,6 +292,7 @@ void		  nlmsvc_locks_init_private(struct file_lock *, struct nlm_host *, pid_t);
 __be32		  nlm_lookup_file(struct svc_rqst *, struct nlm_file **,
 					struct nlm_lock *);
 void		  nlm_release_file(struct nlm_file *);
+void		  nlmsvc_put_lockowner(struct nlm_lockowner *);
 void		  nlmsvc_release_lockowner(struct nlm_lock *);
 void		  nlmsvc_mark_resources(struct net *);
 void		  nlmsvc_free_host_resources(struct nlm_host *);
-- 
2.31.1

