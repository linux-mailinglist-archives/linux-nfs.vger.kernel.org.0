Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0A682801F
	for <lists+linux-nfs@lfdr.de>; Thu, 23 May 2019 16:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730782AbfEWOqM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 23 May 2019 10:46:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58620 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730709AbfEWOqM (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 23 May 2019 10:46:12 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E8AE2307DA31;
        Thu, 23 May 2019 14:46:11 +0000 (UTC)
Received: from bcodding.csb (ovpn-66-2.rdu2.redhat.com [10.10.66.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AAE75620DF;
        Thu, 23 May 2019 14:46:11 +0000 (UTC)
Received: by bcodding.csb (Postfix, from userid 24008)
        id DF76E109C3D1; Thu, 23 May 2019 10:45:48 -0400 (EDT)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     "J . Bruce Fields" <bfields@redhat.com>, jlayton@kernel.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 4/5] lockd: Show pid of lockd for remote locks
Date:   Thu, 23 May 2019 10:45:47 -0400
Message-Id: <4c4c5bd7ea0d55835129fb12b06f8b9ad8f15b72.1558622651.git.bcodding@redhat.com>
In-Reply-To: <cover.1558622651.git.bcodding@redhat.com>
References: <cover.1558622651.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Thu, 23 May 2019 14:46:11 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Use the pid of lockd instead of the remote lock's svid for the fl_pid for
local POSIX locks.  This allows proper enumeration of which local process
owns which lock.  The svid is meaningless to local lock readers.

Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 fs/lockd/svc4proc.c | 1 +
 fs/lockd/svclock.c  | 4 ++--
 fs/lockd/svcproc.c  | 1 +
 fs/lockd/xdr.c      | 2 --
 fs/lockd/xdr4.c     | 2 --
 5 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index 90d328d61933..54c11b0863d1 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -46,6 +46,7 @@ nlm4svc_retrieve_args(struct svc_rqst *rqstp, struct nlm_args *argp,
 
 		/* Set up the missing parts of the file_lock structure */
 		lock->fl.fl_file  = file->f_file;
+		lock->fl.fl_pid = current->tgid;
 		lock->fl.fl_lmops = &nlmsvc_lock_operations;
 		nlmsvc_locks_init_private(&lock->fl, host, (pid_t)lock->svid);
 		if (!lock->fl.fl_owner) {
diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
index 637c50687fd7..5f9f19b81754 100644
--- a/fs/lockd/svclock.c
+++ b/fs/lockd/svclock.c
@@ -432,7 +432,7 @@ static int nlmsvc_setgrantargs(struct nlm_rqst *call, struct nlm_lock *lock)
 
 	/* set default data area */
 	call->a_args.lock.oh.data = call->a_owner;
-	call->a_args.lock.svid = lock->fl.fl_pid;
+	call->a_args.lock.svid = ((struct nlm_lockowner *)lock->fl.fl_owner)->pid;
 
 	if (lock->oh.len > NLMCLNT_OHSIZE) {
 		void *data = kmalloc(lock->oh.len, GFP_KERNEL);
@@ -634,7 +634,7 @@ nlmsvc_testlock(struct svc_rqst *rqstp, struct nlm_file *file,
 	conflock->caller = "somehost";	/* FIXME */
 	conflock->len = strlen(conflock->caller);
 	conflock->oh.len = 0;		/* don't return OH info */
-	conflock->svid = lock->fl.fl_pid;
+	conflock->svid = ((struct nlm_lockowner *)lock->fl.fl_owner)->pid;
 	conflock->fl.fl_type = lock->fl.fl_type;
 	conflock->fl.fl_start = lock->fl.fl_start;
 	conflock->fl.fl_end = lock->fl.fl_end;
diff --git a/fs/lockd/svcproc.c b/fs/lockd/svcproc.c
index 665b7adad3c4..a24e6d942f89 100644
--- a/fs/lockd/svcproc.c
+++ b/fs/lockd/svcproc.c
@@ -76,6 +76,7 @@ nlmsvc_retrieve_args(struct svc_rqst *rqstp, struct nlm_args *argp,
 
 		/* Set up the missing parts of the file_lock structure */
 		lock->fl.fl_file  = file->f_file;
+		lock->fl.fl_pid = current->tgid;
 		lock->fl.fl_lmops = &nlmsvc_lock_operations;
 		nlmsvc_locks_init_private(&lock->fl, host, (pid_t)lock->svid);
 		if (!lock->fl.fl_owner) {
diff --git a/fs/lockd/xdr.c b/fs/lockd/xdr.c
index ec717ae41ee3..982629f7b120 100644
--- a/fs/lockd/xdr.c
+++ b/fs/lockd/xdr.c
@@ -126,7 +126,6 @@ nlm_decode_lock(__be32 *p, struct nlm_lock *lock)
 	lock->svid  = ntohl(*p++);
 
 	locks_init_lock(fl);
-	fl->fl_pid   = (pid_t)lock->svid;
 	fl->fl_flags = FL_POSIX;
 	fl->fl_type  = F_RDLCK;		/* as good as anything else */
 	start = ntohl(*p++);
@@ -268,7 +267,6 @@ nlmsvc_decode_shareargs(struct svc_rqst *rqstp, __be32 *p)
 	memset(lock, 0, sizeof(*lock));
 	locks_init_lock(&lock->fl);
 	lock->svid = ~(u32) 0;
-	lock->fl.fl_pid = (pid_t)lock->svid;
 
 	if (!(p = nlm_decode_cookie(p, &argp->cookie))
 	 || !(p = xdr_decode_string_inplace(p, &lock->caller,
diff --git a/fs/lockd/xdr4.c b/fs/lockd/xdr4.c
index 45741adfe041..5fa9f48a9dba 100644
--- a/fs/lockd/xdr4.c
+++ b/fs/lockd/xdr4.c
@@ -118,7 +118,6 @@ nlm4_decode_lock(__be32 *p, struct nlm_lock *lock)
 	lock->svid  = ntohl(*p++);
 
 	locks_init_lock(fl);
-	fl->fl_pid   = (pid_t)lock->svid;
 	fl->fl_flags = FL_POSIX;
 	fl->fl_type  = F_RDLCK;		/* as good as anything else */
 	p = xdr_decode_hyper(p, &start);
@@ -265,7 +264,6 @@ nlm4svc_decode_shareargs(struct svc_rqst *rqstp, __be32 *p)
 	memset(lock, 0, sizeof(*lock));
 	locks_init_lock(&lock->fl);
 	lock->svid = ~(u32) 0;
-	lock->fl.fl_pid = (pid_t)lock->svid;
 
 	if (!(p = nlm4_decode_cookie(p, &argp->cookie))
 	 || !(p = xdr_decode_string_inplace(p, &lock->caller,
-- 
2.20.1

