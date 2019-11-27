Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFA4A10ACBF
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Nov 2019 10:42:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbfK0Jm3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 27 Nov 2019 04:42:29 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51848 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbfK0Jm2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 27 Nov 2019 04:42:28 -0500
Received: by mail-wm1-f66.google.com with SMTP id g206so6321435wme.1
        for <linux-nfs@vger.kernel.org>; Wed, 27 Nov 2019 01:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zadara-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:from:to:references:in-reply-to:subject:date:mime-version
         :content-transfer-encoding:importance;
        bh=CQdJukpeHVuPuPHGNYOujxDEM/tEahMqhCnk5fyu3ec=;
        b=WN6j4XtpvQVMN1JX27hfw6Gq08cRDQ1WnOQHaZRgW3SmJDTADBruG2JIJaOYOS95t3
         3mOzd6I/Uw9imeFDkBKmgTcHUvazX89SE4D/FhrxZjgzd/KmK2T48R6N+MiY1L3qjEJl
         fJrlUt9lonIvA9lgEkBq7V6NDk5DrpxxKcOnfLZzw9p7CnzcwhWX1dNls+Uqbx+cnIdN
         ofO/ZSkm8f8olLUolGqEjnF3qa3Tq4Qhl7qwo35Bbab3TydaSAEfGifw+eqYb9vmh3CO
         P7dNE9Q3HdLRUqgo0VE2zPizvYDwqitph7xMCMi0YmCMmkVUiRHJoy4edy7SLrcI91Vx
         ziFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:to:references:in-reply-to
         :subject:date:mime-version:content-transfer-encoding:importance;
        bh=CQdJukpeHVuPuPHGNYOujxDEM/tEahMqhCnk5fyu3ec=;
        b=BF1AOk0Xbl5itGpvsvY92dLeNLpCXbKLMbDwgAN/kqNvvEst0BqPyq0b6oJ/j6U2Bu
         K/FV4ptxwu2Q4YwgWDPdeBD1M+SVsLJyWWQrwSg4ftHt6TY8XfFZuNB8+2Q53j8SJ+Sf
         QuXMcuUxnbpIg8Wjge8y+eGhBZvq/GHTW1Shub6XqhOC1W1iAKzd7I1hIldHIe81dFlx
         2mIfxnds4eCXlRm5h2AYEAZW5T+ArcXu98ADmZnvXAAXeVljBbW1dJ7VyIbmOsQpAXe6
         WI2MdG1U6oDTTu0X/vPU2AaATUWazhff12pD0k9lUx0wuTNBWxAeYHAAi9CAoF2OF1cw
         b30g==
X-Gm-Message-State: APjAAAX2qbKRr3gr4pSymE3zPdMFH3QzBmF5prRYt89ZbH5bwZFGrZDn
        QtGENhD+n+JZ4BZs/okrTqJPaA==
X-Google-Smtp-Source: APXvYqziqSCo8KPtWvE9Lrij8NbSWVI7CQCZ4EEB1YwYSVcaRGqzJEU6/kCUhsn7RR7wxuh8EoPOiQ==
X-Received: by 2002:a1c:7d01:: with SMTP id y1mr3240101wmc.157.1574847744739;
        Wed, 27 Nov 2019 01:42:24 -0800 (PST)
Received: from alyakaslap ([82.166.81.77])
        by smtp.gmail.com with ESMTPSA id j67sm6403745wmb.43.2019.11.27.01.42.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Nov 2019 01:42:23 -0800 (PST)
Message-ID: <80F534BB99AC42BBA65EDB2D66BE61C1@alyakaslap>
From:   "Alex Lyakas" <alex@zadara.com>
To:     <bfields@fieldses.org>, <linux-nfs@vger.kernel.org>
References: <1568142147-21974-1-git-send-email-alex@zadara.com>
In-Reply-To: <1568142147-21974-1-git-send-email-alex@zadara.com>
Subject: Re: [PATCH v2] nfsd: provide a procfs entry to release stateids of a particular local filesystem
Date:   Wed, 27 Nov 2019 11:42:20 +0200
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="iso-8859-1";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
Importance: Normal
X-Mailer: Microsoft Windows Live Mail 16.4.3528.331
X-MimeOLE: Produced By Microsoft MimeOLE V16.4.3528.331
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Bruce,

Do you have any comments on the v2 patch?

Thanks,
Alex.


-----Original Message----- 
From: Alex Lyakas
Sent: Tuesday, September 10, 2019 10:02 PM
To: bfields@fieldses.org ; linux-nfs@vger.kernel.org
Cc: shyam@zadara.com ; alex@zadara.com
Subject: [PATCH v2] nfsd: provide a procfs entry to release stateids of a 
particular local filesystem

This patch addresses the following issue:
- Create two local file systems FS1 and FS2 on the server machine S.
- Export both FS1 and FS2 through nfsd to the same nfs client,
  running on client machine C.
- On C, mount both exported file systems and start writing files
  to both of them.
- After few minutes, on server machine S, un-export FS1 only.
- Do not unmount FS1 on the client machine C prior to un-exporting.
- Also, FS2 remains exported to C.
- Now we want to unmount FS1 on the server machine S, but we fail,
  because there are still open files on FS1 held by nfsd.

Debugging this issue showed the following root cause:
there is a nfs4_client entry for the client C.
This entry has two nfs4_openowners, for FS1 and FS2,
although FS1 was un-exported. Looking at the stateids of both openowners,
we see that they have stateids of kind NFS4_OPEN_STID,
and each stateid is holding a nfs4_file. The reason we cannot unmount FS1,
is because we still have an openowner for FS1,
holding open-stateids, which hold open files on FS1.

The laundromat doesn't help in this case,
because it can only decide per-nfs4_client that it should be purged.
But in this case, since FS2 is still exported to C,
there is no reason to purge the nfs4_client.

This situation remains until we un-export FS2 as well.
Then the whole nfs4_client is purged, and all the files get closed,
and we can unmount both FS1 and FS2.

This patch allows user-space to tell nfsd to release stateids
of a particular local filesystem. After that, it is possible
to unmount the local filesystem.

This patch is based on kernel 4.14.99, which we currently use.

Signed-off-by: Alex Lyakas <alex@zadara.com>
---
fs/nfsd/nfs4state.c | 145 
+++++++++++++++++++++++++++++++++++++++++++++++++++-
fs/nfsd/nfsctl.c    |   1 +
fs/nfsd/state.h     |   2 +
3 files changed, 147 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 3cf0b2e..6bd593d5 100755
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6481,13 +6481,13 @@ struct nfs4_client_reclaim *
  return nfs_ok;
}

-#ifdef CONFIG_NFSD_FAULT_INJECTION
static inline void
put_client(struct nfs4_client *clp)
{
  atomic_dec(&clp->cl_refcount);
}

+#ifdef CONFIG_NFSD_FAULT_INJECTION
static struct nfs4_client *
nfsd_find_client(struct sockaddr_storage *addr, size_t addr_size)
{
@@ -6811,6 +6811,7 @@ static u64 nfsd_foreach_client_lock(struct nfs4_client 
*clp, u64 max,

  return count;
}
+#endif /* CONFIG_NFSD_FAULT_INJECTION */

static void
nfsd_reap_openowners(struct list_head *reaplist)
@@ -6826,6 +6827,7 @@ static u64 nfsd_foreach_client_lock(struct nfs4_client 
*clp, u64 max,
  }
}

+#ifdef CONFIG_NFSD_FAULT_INJECTION
u64
nfsd_inject_forget_client_openowners(struct sockaddr_storage *addr,
       size_t addr_size)
@@ -7071,6 +7073,147 @@ static u64 nfsd_find_all_delegations(struct 
nfs4_client *clp, u64 max,
}
#endif /* CONFIG_NFSD_FAULT_INJECTION */

+
+/*
+ * For a particular nfs4_client attempts to release the stateids
+ * that have open files on the specified superblock.
+ */
+static void
+nfs4_release_client_stateids(struct super_block *sb,
+ struct nfs4_client *clp, const char *cl_addr,
+ struct list_head *oo_reaplist,
+ unsigned int *n_openowners)
+{
+ struct nfs4_openowner *oo = NULL, *oo_next = NULL;
+
+ spin_lock(&clp->cl_lock);
+ list_for_each_entry_safe(oo, oo_next, &clp->cl_openowners,
+ oo_perclient) {
+ struct nfs4_ol_stateid *stp = NULL;
+ bool found_my_sb = false, found_other_sb = false;
+ struct super_block *other_sb = NULL;
+
+ pr_debug(" Openowner %p %.*s\n", oo, oo->oo_owner.so_owner.len,
+      oo->oo_owner.so_owner.data);
+ pr_debug(" oo_close_lru=%s oo_last_closed_stid=%p refcnt=%d 
so_is_open_owner=%u\n",
+      list_empty(&oo->oo_close_lru) ? "N" : "Y",
+      oo->oo_last_closed_stid,
+      atomic_read(&oo->oo_owner.so_count),
+      oo->oo_owner.so_is_open_owner);
+
+ list_for_each_entry(stp, &oo->oo_owner.so_stateids,
+ st_perstateowner) {
+ struct nfs4_file *fp = NULL;
+ struct file *filp = NULL;
+ struct super_block *f_sb = NULL;
+
+ if (stp->st_stid.sc_file == NULL)
+ continue;
+
+ fp = stp->st_stid.sc_file;
+ filp = find_any_file(fp);
+ if (filp != NULL)
+ f_sb = file_inode(filp)->i_sb;
+ pr_debug("   filp=%p sb=%p my_sb=%p\n", filp, f_sb, sb);
+ if (f_sb == sb) {
+ found_my_sb = true;
+ } else {
+ found_other_sb = true;
+ other_sb = f_sb;
+ }
+ if (filp != NULL)
+ fput(filp);
+ }
+
+ /* openowner does not have files from needed fs, skip it */
+ if (!found_my_sb)
+ continue;
+
+ /*
+ * we do not expect same openowhner having open files
+ * from more than one fs. but if it happens, we cannot
+ * release this openowner.
+ */
+ if (found_other_sb) {
+ pr_warn(" client=%p/%s openowner %p %.*s has files from sb=%p but also 
from sb=%p, skipping it!\n",
+     clp, cl_addr, oo, oo->oo_owner.so_owner.len,
+     oo->oo_owner.so_owner.data, sb, other_sb);
+ continue;
+ }
+
+ /*
+ * Each OPEN stateid holds a refcnt on the openowner
+ * (and LOCK stateid holds a refcnt on the lockowner).
+ * This refcnt is dropped when nfs4_free_ol_stateid is called,
+ * which calls nfs4_put_stateowner. The last refcnt drop
+ * unhashes and frees the openowner. As a result,
+ * after we free the last stateid, the openowner will
+ * be also be freed. But we still need the openowner to be
+ * around, because we need to call
+ * release_last_closed_stateid(), which is what
+ * release_openowner() does.
+ * So we need to grab an extra refcnt for the openowner here.
+ */
+ nfs4_get_stateowner(&oo->oo_owner);
+
+ /*
+ * see: nfsd_collect_client_openowners(),
+ * nfsd_foreach_client_openowner()
+ */
+ unhash_openowner_locked(oo);
+ /*
+ * By incrementing cl_refcount under "nn->client_lock" we,
+ * hopefully, protect that client from being killed via
+ * mark_client_expired_locked().
+ * We increment cl_refcount once per each openowner.
+ */
+ atomic_inc(&clp->cl_refcount);
+ list_add(&oo->oo_perclient, oo_reaplist);
+ ++(*n_openowners);
+ }
+ spin_unlock(&clp->cl_lock);
+}
+
+/*
+ * Attempts to release the stateids that have open files
+ * on the specified superblock.
+ */
+void
+nfs4_release_stateids(struct super_block *sb)
+{
+ struct nfsd_net *nn = net_generic(current->nsproxy->net_ns,
+ nfsd_net_id);
+ struct nfs4_client *clp = NULL;
+ LIST_HEAD(openowner_reaplist);
+ unsigned int n_openowners = 0;
+
+ if (!nfsd_netns_ready(nn))
+ return;
+
+ pr_info("=== Release stateids for sb=%p ===\n", sb);
+
+ spin_lock(&nn->client_lock);
+ list_for_each_entry(clp, &nn->client_lru, cl_lru) {
+ char cl_addr[INET6_ADDRSTRLEN] = {'\0'};
+
+ rpc_ntop((struct sockaddr *)&clp->cl_addr,
+      cl_addr, sizeof(cl_addr));
+ pr_debug("Checking client=%p/%s cl_clientid=%u:%u refcnt=%d\n",
+      clp, cl_addr, clp->cl_clientid.cl_boot,
+      clp->cl_clientid.cl_id,
+      atomic_read(&clp->cl_refcount));
+
+ nfs4_release_client_stateids(sb, clp, cl_addr,
+ &openowner_reaplist, &n_openowners);
+ }
+ spin_unlock(&nn->client_lock);
+
+ pr_info("Collected %u openowners for removal (sb=%p)\n",
+     n_openowners, sb);
+
+ nfsd_reap_openowners(&openowner_reaplist);
+}
+
/*
  * Since the lifetime of a delegation isn't limited to that of an open, a
  * client may quite reasonably hang on to a delegation as long as it has
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 4824363..5514184 100755
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -322,6 +322,7 @@ static ssize_t write_unlock_fs(struct file *file, char 
*buf, size_t size)
  * 3.  Is that directory the root of an exported file system?
  */
  error = nlmsvc_unlock_all_by_sb(path.dentry->d_sb);
+ nfs4_release_stateids(path.dentry->d_sb);

  path_put(&path);
  return error;
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 86aa92d..acee094 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -632,6 +632,8 @@ extern struct nfs4_client_reclaim 
*nfs4_client_to_reclaim(const char *name,
  struct nfsd_net *nn);
extern bool nfs4_has_reclaimed_state(const char *name, struct nfsd_net *nn);

+extern void nfs4_release_stateids(struct super_block *sb);
+
struct nfs4_file *find_file(struct knfsd_fh *fh);
void put_nfs4_file(struct nfs4_file *fi);
static inline void get_nfs4_file(struct nfs4_file *fi)
-- 
1.9.1

