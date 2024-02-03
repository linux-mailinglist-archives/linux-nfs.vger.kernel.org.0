Return-Path: <linux-nfs+bounces-1728-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 988EE847FF9
	for <lists+linux-nfs@lfdr.de>; Sat,  3 Feb 2024 04:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBDC41C2146C
	for <lists+linux-nfs@lfdr.de>; Sat,  3 Feb 2024 03:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D3C8F9D7;
	Sat,  3 Feb 2024 03:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lsf7oSon"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D1BF9C1
	for <linux-nfs@vger.kernel.org>; Sat,  3 Feb 2024 03:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706932523; cv=none; b=urD7BhOCBT7UO8f7nbhwXSlkYJ4ORAe1M6zqo/f9nUIbrkY/Ot9wzX+zCOKTVJViAZi+6mTXb9Gw23Okgu2zoyTf9a9AsNlFvp8HkT1Dj/GmZ8Y1QCLLd+YOMUgWBMx/FffVlhLanBjLb03SMggjFA9MmbuOS3ac3kvd+ROWK4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706932523; c=relaxed/simple;
	bh=N37r0P5jq5wuWqS38GZI63qy9sP4FdT1LVwfgcoruXM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u2CNbazmv40X05nl/8ERRCl/AdtrVvKns0efl70UXIDh/2SizAZrmXJTVsxisv2EPdEHEhzZplFohXg4P5+0TPa7q3PQNtnsTF2v/zOBMsSyK7E9S86TEX86/NBLFs5oIH+GD2GMMvRTq+TOIjAqgyxUEfJ2KfF0F30qAb3ULFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lsf7oSon; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F8D1C433C7;
	Sat,  3 Feb 2024 03:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706932522;
	bh=N37r0P5jq5wuWqS38GZI63qy9sP4FdT1LVwfgcoruXM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=lsf7oSon5ylMbQfKn3X7DCCENga4oWQtW8Y+xBykkcLPqG5bZ7wZ8teiHGFU00lt3
	 wDOC1cwubb1qfMPGwzIgqRtOCo/36RC+ExPsIVVZqJ2ggl3aMkwMFvSZ5vFxhrGaiU
	 HVtiLwcMwl7vz5q8fToYT51RGXqYuLQ6q7s8CCxNbDlqB+dVIsXvA4L+1FGs0cEXmQ
	 pHuqSFSg7iURPnrRxarZVTzpZqa2bJ3QKYLbgnhB6WE0r4GFrSWCZbl+2GXkNJld3e
	 jYZg7gWLei06fR+bL/v2r67QaD2zDLb6ZlcF/OMqAmZXlCd+v0QH8uZKPnbtCBLAU+
	 WsyfbjGyYyMig==
Subject: [PATCH v2 1/4] nfsd4: add refcount for nfsd4_blocked_lock
From: Chuck Lever <cel@kernel.org>
To: neilb@suse.de
Cc: linux-nfs@vger.kernel.org
Date: Fri, 02 Feb 2024 22:55:21 -0500
Message-ID: 
 <170693252122.20619.1273924816561450840.stgit@klimt.1015granger.net>
In-Reply-To: 
 <170693220850.20619.2532987152854323295.stgit@klimt.1015granger.net>
References: 
 <170693220850.20619.2532987152854323295.stgit@klimt.1015granger.net>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Vasily Averin <vvs@virtuozzo.com>

[ Upstream commit 47446d74f1707049067fee038507cdffda805631 ]

nbl allocated in nfsd4_lock can be released by a several ways:
directly in nfsd4_lock(), via nfs4_laundromat(), via another nfs
command RELEASE_LOCKOWNER or via nfsd4_callback.
This structure should be refcounted to be used and released correctly
in all these cases.

Refcount is initialized to 1 during allocation and is incremented
when nbl is added into nbl_list/nbl_lru lists.

Usually nbl is linked into both lists together, so only one refcount
is used for both lists.

However nfsd4_lock() should keep in mind that nbl can be present
in one of lists only. This can happen if nbl was handled already
by nfs4_laundromat/nfsd4_callback/etc.

Refcount is decremented if vfs_lock_file() returns FILE_LOCK_DEFERRED,
because nbl can be handled already by nfs4_laundromat/nfsd4_callback/etc.

Refcount is not changed in find_blocked_lock() because of it reuses counter
released after removing nbl from lists.

Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4state.c |   25 ++++++++++++++++++++++---
 fs/nfsd/state.h     |    1 +
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 9b660491f393..74442ed47a66 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -246,6 +246,7 @@ find_blocked_lock(struct nfs4_lockowner *lo, struct knfsd_fh *fh,
 	list_for_each_entry(cur, &lo->lo_blocked, nbl_list) {
 		if (fh_match(fh, &cur->nbl_fh)) {
 			list_del_init(&cur->nbl_list);
+			WARN_ON(list_empty(&cur->nbl_lru));
 			list_del_init(&cur->nbl_lru);
 			found = cur;
 			break;
@@ -271,6 +272,7 @@ find_or_allocate_block(struct nfs4_lockowner *lo, struct knfsd_fh *fh,
 			INIT_LIST_HEAD(&nbl->nbl_lru);
 			fh_copy_shallow(&nbl->nbl_fh, fh);
 			locks_init_lock(&nbl->nbl_lock);
+			kref_init(&nbl->nbl_kref);
 			nfsd4_init_cb(&nbl->nbl_cb, lo->lo_owner.so_client,
 					&nfsd4_cb_notify_lock_ops,
 					NFSPROC4_CLNT_CB_NOTIFY_LOCK);
@@ -279,12 +281,21 @@ find_or_allocate_block(struct nfs4_lockowner *lo, struct knfsd_fh *fh,
 	return nbl;
 }
 
+static void
+free_nbl(struct kref *kref)
+{
+	struct nfsd4_blocked_lock *nbl;
+
+	nbl = container_of(kref, struct nfsd4_blocked_lock, nbl_kref);
+	kfree(nbl);
+}
+
 static void
 free_blocked_lock(struct nfsd4_blocked_lock *nbl)
 {
 	locks_delete_block(&nbl->nbl_lock);
 	locks_release_private(&nbl->nbl_lock);
-	kfree(nbl);
+	kref_put(&nbl->nbl_kref, free_nbl);
 }
 
 static void
@@ -302,6 +313,7 @@ remove_blocked_locks(struct nfs4_lockowner *lo)
 					struct nfsd4_blocked_lock,
 					nbl_list);
 		list_del_init(&nbl->nbl_list);
+		WARN_ON(list_empty(&nbl->nbl_lru));
 		list_move(&nbl->nbl_lru, &reaplist);
 	}
 	spin_unlock(&nn->blocked_locks_lock);
@@ -7007,6 +7019,7 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		spin_lock(&nn->blocked_locks_lock);
 		list_add_tail(&nbl->nbl_list, &lock_sop->lo_blocked);
 		list_add_tail(&nbl->nbl_lru, &nn->blocked_locks_lru);
+		kref_get(&nbl->nbl_kref);
 		spin_unlock(&nn->blocked_locks_lock);
 	}
 
@@ -7019,6 +7032,7 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 			nn->somebody_reclaimed = true;
 		break;
 	case FILE_LOCK_DEFERRED:
+		kref_put(&nbl->nbl_kref, free_nbl);
 		nbl = NULL;
 		fallthrough;
 	case -EAGAIN:		/* conflock holds conflicting lock */
@@ -7039,8 +7053,13 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		/* dequeue it if we queued it before */
 		if (fl_flags & FL_SLEEP) {
 			spin_lock(&nn->blocked_locks_lock);
-			list_del_init(&nbl->nbl_list);
-			list_del_init(&nbl->nbl_lru);
+			if (!list_empty(&nbl->nbl_list) &&
+			    !list_empty(&nbl->nbl_lru)) {
+				list_del_init(&nbl->nbl_list);
+				list_del_init(&nbl->nbl_lru);
+				kref_put(&nbl->nbl_kref, free_nbl);
+			}
+			/* nbl can use one of lists to be linked to reaplist */
 			spin_unlock(&nn->blocked_locks_lock);
 		}
 		free_blocked_lock(nbl);
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index e73bdbb1634a..ab61dc102300 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -629,6 +629,7 @@ struct nfsd4_blocked_lock {
 	struct file_lock	nbl_lock;
 	struct knfsd_fh		nbl_fh;
 	struct nfsd4_callback	nbl_cb;
+	struct kref		nbl_kref;
 };
 
 struct nfsd4_compound_state;



