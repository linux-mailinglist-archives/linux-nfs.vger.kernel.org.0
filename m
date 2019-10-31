Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 192E2EB9CA
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Oct 2019 23:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbfJaWnF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 31 Oct 2019 18:43:05 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:45118 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfJaWnE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 31 Oct 2019 18:43:04 -0400
Received: by mail-yw1-f68.google.com with SMTP id x65so2773868ywf.12
        for <linux-nfs@vger.kernel.org>; Thu, 31 Oct 2019 15:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=6bmFBvm80lqZFmkuf5C7SAwGSogwl2AA+I9jrrqwyOQ=;
        b=CJFmrogXSo7UNNQVMEG8eZnUofcmRqRcdUcZFZucHaYzOsWQfleMRCka5SaWLg34Uw
         TgzlMD9fqmQP7JB6i6F/jiR/ZWUFMPPESG1BaRWxpkalISogtS+NQMveQs3r+ibq+crE
         FM7/Gi0TMyeKNte0di6vvJ8SIPSBeJ5pWEBMuvN0DWPx0GEp7jF/buJ96FpZ9hmH5jW/
         l6i6cV/is1OuCi+gqUyXqBphAikxd7DB02IZ3IGIkXcIM8DRc9nCb7s7dLs1ARnZsr4o
         XrcP5mOrJy51L5UiicHCwvdfXp6tkRHpKsS1s5GcSN+x+07fi0EdPF/sFbN4PYbvoCFv
         szlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6bmFBvm80lqZFmkuf5C7SAwGSogwl2AA+I9jrrqwyOQ=;
        b=CB8ot7JN4pYnwkJAKbr7uHDNEe/G+U+AFkSs/Vmcem3qrjA3jSBwUkJPqc3o+d9OlK
         eP8UdXEcMeVruQRTck9hR/Hff3KioM5fc6gRWz5fVIx8Bw2vYVp6o+1lErMR1iO0u2bq
         DVvYFfhnxe96U/Wr1De4mx8dJTBtWsK0xKLFdoHozeB5ZHbWoUa/BT3870Hay/EE2don
         KlJUAb9U8fUq7GbICM75akmKJGk8Ay7qT8AKVmb0ZEkFjzRQpSf8GAjjoEOPd0y6/T1O
         sQPSQ0HPRuAtwTY59f1fzA6UxJH1sATb3LzSY8FWgkLRus0f7ltqe3HVwd7BI9ptkgH2
         joaw==
X-Gm-Message-State: APjAAAVPXOspo+hA4gGkQo/AIuREYUZbXkN/TuR7RL1j3kOrUgeef40D
        W4k4y51HO1uA9ZuauIOCpAzQj5U=
X-Google-Smtp-Source: APXvYqw4wd8lGqGL8LCaJEUqE+8zPuuyUYfIdRNLMdaCJmy/Gmrh3/Mxpg0pUa9XvZ2uqTjH6e1dXg==
X-Received: by 2002:a81:7a56:: with SMTP id v83mr4433932ywc.226.1572561783462;
        Thu, 31 Oct 2019 15:43:03 -0700 (PDT)
Received: from localhost.localdomain ([50.105.87.1])
        by smtp.gmail.com with ESMTPSA id d192sm1720287ywb.3.2019.10.31.15.43.02
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 15:43:02 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 01/20] NFSv4: Don't allow a cached open with a revoked delegation
Date:   Thu, 31 Oct 2019 18:40:32 -0400
Message-Id: <20191031224051.8923-2-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191031224051.8923-1-trond.myklebust@hammerspace.com>
References: <20191031224051.8923-1-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If the delegation is marked as being revoked, we must not use it
for cached opens.

Fixes: 869f9dfa4d6d ("NFSv4: Fix races between nfs_remove_bad_delegation() and delegation return")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/delegation.c | 10 ++++++++++
 fs/nfs/delegation.h |  1 +
 fs/nfs/nfs4proc.c   |  7 ++-----
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index 071b90a45933..ccdfb5f98f35 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -53,6 +53,16 @@ nfs4_is_valid_delegation(const struct nfs_delegation *delegation,
 	return false;
 }
 
+struct nfs_delegation *nfs4_get_valid_delegation(const struct inode *inode)
+{
+	struct nfs_delegation *delegation;
+
+	delegation = rcu_dereference(NFS_I(inode)->delegation);
+	if (nfs4_is_valid_delegation(delegation, 0))
+		return delegation;
+	return NULL;
+}
+
 static int
 nfs4_do_check_delegation(struct inode *inode, fmode_t flags, bool mark)
 {
diff --git a/fs/nfs/delegation.h b/fs/nfs/delegation.h
index 9eb87ae4c982..8b14d441e699 100644
--- a/fs/nfs/delegation.h
+++ b/fs/nfs/delegation.h
@@ -68,6 +68,7 @@ int nfs4_lock_delegation_recall(struct file_lock *fl, struct nfs4_state *state,
 bool nfs4_copy_delegation_stateid(struct inode *inode, fmode_t flags, nfs4_stateid *dst, const struct cred **cred);
 bool nfs4_refresh_delegation_stateid(nfs4_stateid *dst, struct inode *inode);
 
+struct nfs_delegation *nfs4_get_valid_delegation(const struct inode *inode);
 void nfs_mark_delegation_referenced(struct nfs_delegation *delegation);
 int nfs4_have_delegation(struct inode *inode, fmode_t flags);
 int nfs4_check_delegation(struct inode *inode, fmode_t flags);
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index ab8ca20fd579..caacf5e7f5e1 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -1440,8 +1440,6 @@ static int can_open_delegated(struct nfs_delegation *delegation, fmode_t fmode,
 		return 0;
 	if ((delegation->type & fmode) != fmode)
 		return 0;
-	if (test_bit(NFS_DELEGATION_RETURNING, &delegation->flags))
-		return 0;
 	switch (claim) {
 	case NFS4_OPEN_CLAIM_NULL:
 	case NFS4_OPEN_CLAIM_FH:
@@ -1810,7 +1808,6 @@ static void nfs4_return_incompatible_delegation(struct inode *inode, fmode_t fmo
 static struct nfs4_state *nfs4_try_open_cached(struct nfs4_opendata *opendata)
 {
 	struct nfs4_state *state = opendata->state;
-	struct nfs_inode *nfsi = NFS_I(state->inode);
 	struct nfs_delegation *delegation;
 	int open_mode = opendata->o_arg.open_flags;
 	fmode_t fmode = opendata->o_arg.fmode;
@@ -1827,7 +1824,7 @@ static struct nfs4_state *nfs4_try_open_cached(struct nfs4_opendata *opendata)
 		}
 		spin_unlock(&state->owner->so_lock);
 		rcu_read_lock();
-		delegation = rcu_dereference(nfsi->delegation);
+		delegation = nfs4_get_valid_delegation(state->inode);
 		if (!can_open_delegated(delegation, fmode, claim)) {
 			rcu_read_unlock();
 			break;
@@ -2371,7 +2368,7 @@ static void nfs4_open_prepare(struct rpc_task *task, void *calldata)
 					data->o_arg.open_flags, claim))
 			goto out_no_action;
 		rcu_read_lock();
-		delegation = rcu_dereference(NFS_I(data->state->inode)->delegation);
+		delegation = nfs4_get_valid_delegation(data->state->inode);
 		if (can_open_delegated(delegation, data->o_arg.fmode, claim))
 			goto unlock_no_action;
 		rcu_read_unlock();
-- 
2.23.0

