Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C72631750ED
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Mar 2020 00:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbgCAXZQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 1 Mar 2020 18:25:16 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:43717 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbgCAXZP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 1 Mar 2020 18:25:15 -0500
Received: by mail-yw1-f66.google.com with SMTP id u78so4672586ywf.10
        for <linux-nfs@vger.kernel.org>; Sun, 01 Mar 2020 15:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M8qHIALFHS4iOjubUfvsPbpUxxXoz9pieckInQwWYAE=;
        b=QE0WmNou4KnCXTxVLUPn9MNuDB4tijkKa2lvz+Tq6z5bHlR0/TcHGaI5/fl9Ep/ovW
         eKIfltMH7zjsp+NxsZfdwv0VbZxPUuOA5X030QXF6DCQaWHpYVEe0ooKPBKlf9HieN+0
         fa4dAoELTdZL8y+CgSVYJz0BBkhIk9QmFGE+w02nf6F/wsWAj3qpyXxsXMOAk47qQrJE
         wwPiinkQsNPZpRKdhux2nGMQKm+F/d0/v1MnCcw+5GPjVQ2ZRxx6AKrMDaVhxGTg9w9q
         1NQONnvylr9zbfEzIY67P9PmqC/WitlXTSz31sjO4mLIZEpEBcN0xgXI5s2CbDYhrnWT
         OGfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M8qHIALFHS4iOjubUfvsPbpUxxXoz9pieckInQwWYAE=;
        b=e/gSlWq10jagLfhbFXcW4t77kQstGXEcDife5Ykt0EVaxCoammvrX87gs6fF81JBsf
         qrLLGoSIGec9Xl/VY/WmLRhRucZk0N+jFdnho5g9Md0xlwH7R5UZDbetl9Fn/8bPnRcv
         uG6T9VRPGvZ0sQzt/mVGUJqH6e3rO3x1MDSsgT5qbXDETJ7Tdtszl/vgIcl+c0GCRhHz
         SpcQC6Qt25Q1OlgS7ZXY0JMSEgW8J5AIw6SHWkOJHz8LffcOGHYWy7wk4fZ00wYpj6D8
         NcQRPv0VtthbwV7rNilLAc1xRphBv4EdvLyhPPtXBD+Iv0lF5W3gj9FNFj7qbTmrcnkq
         a15Q==
X-Gm-Message-State: APjAAAV6jfbrPvyQU8XlmYIBot5pPeSWtefSB9/MiSbmjz3E7ktHIrC5
        qKbwMDe6AxXauUokNm3zMg==
X-Google-Smtp-Source: APXvYqxYJ+KvmGuy1EzzRlirRT0IHnLcWD6oMVw4NXXJz7OCwnraRIL0yR7xnU9VDx7gOWAn1aG/uQ==
X-Received: by 2002:a81:5303:: with SMTP id h3mr14594643ywb.267.1583105114827;
        Sun, 01 Mar 2020 15:25:14 -0800 (PST)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id u4sm7167301ywu.26.2020.03.01.15.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2020 15:25:14 -0800 (PST)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/8] nfsd: Don't add locks to closed or closing open stateids
Date:   Sun,  1 Mar 2020 18:21:38 -0500
Message-Id: <20200301232145.1465430-2-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200301232145.1465430-1-trond.myklebust@hammerspace.com>
References: <20200301232145.1465430-1-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

In NFSv4, the lock stateids are tied to the lockowner, and the open stateid,
so that the action of closing the file also results in either an automatic
loss of the locks, or an error of the form NFS4ERR_LOCKS_HELD.

In practice this means we must not add new locks to the open stateid
after the close process has been invoked. In fact doing so, can result
in the following panic:

 kernel BUG at lib/list_debug.c:51!
 invalid opcode: 0000 [#1] SMP NOPTI
 CPU: 2 PID: 1085 Comm: nfsd Not tainted 5.6.0-rc3+ #2
 Hardware name: VMware, Inc. VMware7,1/440BX Desktop Reference Platform, BIOS VMW71.00V.14410784.B64.1908150010 08/15/2019
 RIP: 0010:__list_del_entry_valid.cold+0x31/0x55
 Code: 1a 3d 9b e8 74 10 c2 ff 0f 0b 48 c7 c7 f0 1a 3d 9b e8 66 10 c2 ff 0f 0b 48 89 f2 48 89 fe 48 c7 c7 b0 1a 3d 9b e8 52 10 c2 ff <0f> 0b 48 89 fe 4c 89 c2 48 c7 c7 78 1a 3d 9b e8 3e 10 c2 ff 0f 0b
 RSP: 0018:ffffb296c1d47d90 EFLAGS: 00010246
 RAX: 0000000000000054 RBX: ffff8ba032456ec8 RCX: 0000000000000000
 RDX: 0000000000000000 RSI: ffff8ba039e99cc8 RDI: ffff8ba039e99cc8
 RBP: ffff8ba032456e60 R08: 0000000000000781 R09: 0000000000000003
 R10: 0000000000000000 R11: 0000000000000001 R12: ffff8ba009a4abe0
 R13: ffff8ba032456e8c R14: 0000000000000000 R15: ffff8ba00adb01d8
 FS:  0000000000000000(0000) GS:ffff8ba039e80000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 00007fb213f0b008 CR3: 00000001347de006 CR4: 00000000003606e0
 Call Trace:
  release_lock_stateid+0x2b/0x80 [nfsd]
  nfsd4_free_stateid+0x1e9/0x210 [nfsd]
  nfsd4_proc_compound+0x414/0x700 [nfsd]
  ? nfs4svc_decode_compoundargs+0x407/0x4c0 [nfsd]
  nfsd_dispatch+0xc1/0x200 [nfsd]
  svc_process_common+0x476/0x6f0 [sunrpc]
  ? svc_sock_secure_port+0x12/0x30 [sunrpc]
  ? svc_recv+0x313/0x9c0 [sunrpc]
  ? nfsd_svc+0x2d0/0x2d0 [nfsd]
  svc_process+0xd4/0x110 [sunrpc]
  nfsd+0xe3/0x140 [nfsd]
  kthread+0xf9/0x130
  ? nfsd_destroy+0x50/0x50 [nfsd]
  ? kthread_park+0x90/0x90
  ret_from_fork+0x1f/0x40

The fix is to ensure that lock creation tests for whether or not the
open stateid is unhashed, and to fail if that is the case.

Fixes: 659aefb68eca ("nfsd: Ensure we don't recognise lock stateids after freeing them")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfsd/nfs4state.c | 73 ++++++++++++++++++++++++++-------------------
 1 file changed, 43 insertions(+), 30 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 65cfe9ab47be..1ba4514be18d 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -494,6 +494,8 @@ find_any_file(struct nfs4_file *f)
 {
 	struct nfsd_file *ret;
 
+	if (!f)
+		return NULL;
 	spin_lock(&f->fi_lock);
 	ret = __nfs4_get_fd(f, O_RDWR);
 	if (!ret) {
@@ -1309,6 +1311,12 @@ static void nfs4_put_stateowner(struct nfs4_stateowner *sop)
 	nfs4_free_stateowner(sop);
 }
 
+static bool
+nfs4_ol_stateid_unhashed(const struct nfs4_ol_stateid *stp)
+{
+	return list_empty(&stp->st_perfile);
+}
+
 static bool unhash_ol_stateid(struct nfs4_ol_stateid *stp)
 {
 	struct nfs4_file *fp = stp->st_stid.sc_file;
@@ -1379,9 +1387,11 @@ static bool unhash_lock_stateid(struct nfs4_ol_stateid *stp)
 {
 	lockdep_assert_held(&stp->st_stid.sc_client->cl_lock);
 
+	if (!unhash_ol_stateid(stp))
+		return false;
 	list_del_init(&stp->st_locks);
 	nfs4_unhash_stid(&stp->st_stid);
-	return unhash_ol_stateid(stp);
+	return true;
 }
 
 static void release_lock_stateid(struct nfs4_ol_stateid *stp)
@@ -1446,13 +1456,12 @@ static void release_open_stateid_locks(struct nfs4_ol_stateid *open_stp,
 static bool unhash_open_stateid(struct nfs4_ol_stateid *stp,
 				struct list_head *reaplist)
 {
-	bool unhashed;
-
 	lockdep_assert_held(&stp->st_stid.sc_client->cl_lock);
 
-	unhashed = unhash_ol_stateid(stp);
+	if (!unhash_ol_stateid(stp))
+		return false;
 	release_open_stateid_locks(stp, reaplist);
-	return unhashed;
+	return true;
 }
 
 static void release_open_stateid(struct nfs4_ol_stateid *stp)
@@ -6393,21 +6402,21 @@ alloc_init_lock_stateowner(unsigned int strhashval, struct nfs4_client *clp,
 }
 
 static struct nfs4_ol_stateid *
-find_lock_stateid(struct nfs4_lockowner *lo, struct nfs4_file *fp)
+find_lock_stateid(const struct nfs4_lockowner *lo,
+		  const struct nfs4_ol_stateid *ost)
 {
 	struct nfs4_ol_stateid *lst;
-	struct nfs4_client *clp = lo->lo_owner.so_client;
 
-	lockdep_assert_held(&clp->cl_lock);
+	lockdep_assert_held(&ost->st_stid.sc_client->cl_lock);
 
-	list_for_each_entry(lst, &lo->lo_owner.so_stateids, st_perstateowner) {
-		if (lst->st_stid.sc_type != NFS4_LOCK_STID)
-			continue;
-		if (lst->st_stid.sc_file == fp) {
-			refcount_inc(&lst->st_stid.sc_count);
-			return lst;
+	/* If ost is not hashed, ost->st_locks will not be valid */
+	if (!nfs4_ol_stateid_unhashed(ost))
+		list_for_each_entry(lst, &ost->st_locks, st_locks) {
+			if (lst->st_stateowner == &lo->lo_owner) {
+				refcount_inc(&lst->st_stid.sc_count);
+				return lst;
+			}
 		}
-	}
 	return NULL;
 }
 
@@ -6423,11 +6432,11 @@ init_lock_stateid(struct nfs4_ol_stateid *stp, struct nfs4_lockowner *lo,
 	mutex_lock_nested(&stp->st_mutex, OPEN_STATEID_MUTEX);
 retry:
 	spin_lock(&clp->cl_lock);
-	spin_lock(&fp->fi_lock);
-	retstp = find_lock_stateid(lo, fp);
+	if (nfs4_ol_stateid_unhashed(open_stp))
+		goto out_close;
+	retstp = find_lock_stateid(lo, open_stp);
 	if (retstp)
-		goto out_unlock;
-
+		goto out_found;
 	refcount_inc(&stp->st_stid.sc_count);
 	stp->st_stid.sc_type = NFS4_LOCK_STID;
 	stp->st_stateowner = nfs4_get_stateowner(&lo->lo_owner);
@@ -6436,22 +6445,26 @@ init_lock_stateid(struct nfs4_ol_stateid *stp, struct nfs4_lockowner *lo,
 	stp->st_access_bmap = 0;
 	stp->st_deny_bmap = open_stp->st_deny_bmap;
 	stp->st_openstp = open_stp;
+	spin_lock(&fp->fi_lock);
 	list_add(&stp->st_locks, &open_stp->st_locks);
 	list_add(&stp->st_perstateowner, &lo->lo_owner.so_stateids);
 	list_add(&stp->st_perfile, &fp->fi_stateids);
-out_unlock:
 	spin_unlock(&fp->fi_lock);
 	spin_unlock(&clp->cl_lock);
-	if (retstp) {
-		if (nfsd4_lock_ol_stateid(retstp) != nfs_ok) {
-			nfs4_put_stid(&retstp->st_stid);
-			goto retry;
-		}
-		/* To keep mutex tracking happy */
-		mutex_unlock(&stp->st_mutex);
-		stp = retstp;
-	}
 	return stp;
+out_found:
+	spin_unlock(&clp->cl_lock);
+	if (nfsd4_lock_ol_stateid(retstp) != nfs_ok) {
+		nfs4_put_stid(&retstp->st_stid);
+		goto retry;
+	}
+	/* To keep mutex tracking happy */
+	mutex_unlock(&stp->st_mutex);
+	return retstp;
+out_close:
+	spin_unlock(&clp->cl_lock);
+	mutex_unlock(&stp->st_mutex);
+	return NULL;
 }
 
 static struct nfs4_ol_stateid *
@@ -6466,7 +6479,7 @@ find_or_create_lock_stateid(struct nfs4_lockowner *lo, struct nfs4_file *fi,
 
 	*new = false;
 	spin_lock(&clp->cl_lock);
-	lst = find_lock_stateid(lo, fi);
+	lst = find_lock_stateid(lo, ost);
 	spin_unlock(&clp->cl_lock);
 	if (lst != NULL) {
 		if (nfsd4_lock_ol_stateid(lst) == nfs_ok)
-- 
2.24.1

