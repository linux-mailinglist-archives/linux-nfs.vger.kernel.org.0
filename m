Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEB8B806E5
	for <lists+linux-nfs@lfdr.de>; Sat,  3 Aug 2019 17:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbfHCPAj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 3 Aug 2019 11:00:39 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:44331 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727844AbfHCPAi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 3 Aug 2019 11:00:38 -0400
Received: by mail-io1-f66.google.com with SMTP id s7so158534403iob.11
        for <linux-nfs@vger.kernel.org>; Sat, 03 Aug 2019 08:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=LlF62m+Gv0rAWCHTfnQLpoe7ZScHzX+jX7oHGPOV2KU=;
        b=Pne7OWAaTix6S/cswb0pc4AfskzeP+4UfO9f4+FE1NPgtB3JJAhystlgIxlZ8vx3ZC
         gHwzXOZNwQ5+zJQz6D5F7ok8jROJgRC992DsEDq07IoWagvUM3vvJy7Rm6d3wIWPV/WQ
         NQ01wPbXUrdoxlRP+7PaGB25LHJtbswsCzyJT8PfLlnw7cKnIP9RoywRUuNR/mTwCh/k
         ghdEIoudSu2Z/JseDoa201vZd8ZE89RoQYcRk/y3t+bYdyWNKhP8/qtmRdHbFIx4KGfm
         K3XI1QbZFqcCv33199Itta9r39wUpDDAGEeDt3Cxn27xLobwBOSSWlJ3czI8LuZIZiWK
         oeAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LlF62m+Gv0rAWCHTfnQLpoe7ZScHzX+jX7oHGPOV2KU=;
        b=q4JGtTUHWGBLbxbNS8NugnRbWM4HU172F+5j8Lw7y92k2a/2svzWh3xarYc8xso72D
         0aBNU4fz3QfpGXv1m+CQgE6I6s+4v+OGnWL6ScVNP0sLNfy9X8mjAScpb+j/lERHfwla
         xT9QIfpI33z09yxOpjlqchwLVFIzhbSnWXm3OQIx/PzFnvVfRLXrEZ/FLNPfcMF247ct
         GIoYCYYsUv3AgqFQBWFcx/xV2WWNmNH9Naj7kanSW8sYc3ELnGD9w6bTI0JEvfNGpFC2
         BXkfUZHBUpYR+D0mFHw0DfcwbYa2scd3px4JxfQlyetGxBpVODq8QG4+5Lh2KyvmUhRH
         830w==
X-Gm-Message-State: APjAAAVa4/c6FJasAk29ntNl4VzEmKa950wmeYjYznW8EfpOanLd7Bwu
        7j6HEdYwo3sOdhEGDyuKEI8YV58=
X-Google-Smtp-Source: APXvYqyawBjdduvTF9ENO1rKeeWc7zSeBubAw4Vh1TSG5RSs3qG+jpA1lw2CEXxHtW6lfY0lLsJBdw==
X-Received: by 2002:a6b:e608:: with SMTP id g8mr7838559ioh.88.1564844437317;
        Sat, 03 Aug 2019 08:00:37 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id f20sm60820416ioh.17.2019.08.03.08.00.36
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 03 Aug 2019 08:00:36 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 6/8] NFSv4.1: Fix open stateid recovery
Date:   Sat,  3 Aug 2019 10:58:24 -0400
Message-Id: <20190803145826.15504-6-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190803145826.15504-5-trond.myklebust@hammerspace.com>
References: <20190803145826.15504-1-trond.myklebust@hammerspace.com>
 <20190803145826.15504-2-trond.myklebust@hammerspace.com>
 <20190803145826.15504-3-trond.myklebust@hammerspace.com>
 <20190803145826.15504-4-trond.myklebust@hammerspace.com>
 <20190803145826.15504-5-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The logic for checking in nfs41_check_open_stateid() whether the state
is supported by a delegation is inverted. In addition, it makes more
sense to perform that check before we check for expired locks.

Fixes: 8a64c4ef106d1 ("NFSv4.1: Even if the stateid is OK,...")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4proc.c | 65 +++++++++++++++++++++++++++--------------------
 1 file changed, 38 insertions(+), 27 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 21e3c159bc69..c9e14ce0b7b2 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -1683,6 +1683,14 @@ static void nfs_state_set_open_stateid(struct nfs4_state *state,
 	write_sequnlock(&state->seqlock);
 }
 
+static void nfs_state_clear_open_state_flags(struct nfs4_state *state)
+{
+	clear_bit(NFS_O_RDWR_STATE, &state->flags);
+	clear_bit(NFS_O_WRONLY_STATE, &state->flags);
+	clear_bit(NFS_O_RDONLY_STATE, &state->flags);
+	clear_bit(NFS_OPEN_STATE, &state->flags);
+}
+
 static void nfs_state_set_delegation(struct nfs4_state *state,
 		const nfs4_stateid *deleg_stateid,
 		fmode_t fmode)
@@ -2074,13 +2082,7 @@ static int nfs4_open_recover(struct nfs4_opendata *opendata, struct nfs4_state *
 {
 	int ret;
 
-	/* Don't trigger recovery in nfs_test_and_clear_all_open_stateid */
-	clear_bit(NFS_O_RDWR_STATE, &state->flags);
-	clear_bit(NFS_O_WRONLY_STATE, &state->flags);
-	clear_bit(NFS_O_RDONLY_STATE, &state->flags);
 	/* memory barrier prior to reading state->n_* */
-	clear_bit(NFS_DELEGATED_STATE, &state->flags);
-	clear_bit(NFS_OPEN_STATE, &state->flags);
 	smp_rmb();
 	ret = nfs4_open_recover_helper(opendata, FMODE_READ|FMODE_WRITE);
 	if (ret != 0)
@@ -2156,6 +2158,8 @@ static int nfs4_open_reclaim(struct nfs4_state_owner *sp, struct nfs4_state *sta
 	ctx = nfs4_state_find_open_context(state);
 	if (IS_ERR(ctx))
 		return -EAGAIN;
+	clear_bit(NFS_DELEGATED_STATE, &state->flags);
+	nfs_state_clear_open_state_flags(state);
 	ret = nfs4_do_open_reclaim(ctx, state);
 	put_nfs_open_context(ctx);
 	return ret;
@@ -2697,6 +2701,7 @@ static int nfs40_open_expired(struct nfs4_state_owner *sp, struct nfs4_state *st
 {
 	/* NFSv4.0 doesn't allow for delegation recovery on open expire */
 	nfs40_clear_delegation_stateid(state);
+	nfs_state_clear_open_state_flags(state);
 	return nfs4_open_expired(sp, state);
 }
 
@@ -2739,13 +2744,13 @@ static int nfs41_test_and_free_expired_stateid(struct nfs_server *server,
 	return -NFS4ERR_EXPIRED;
 }
 
-static void nfs41_check_delegation_stateid(struct nfs4_state *state)
+static int nfs41_check_delegation_stateid(struct nfs4_state *state)
 {
 	struct nfs_server *server = NFS_SERVER(state->inode);
 	nfs4_stateid stateid;
 	struct nfs_delegation *delegation;
 	const struct cred *cred = NULL;
-	int status;
+	int status, ret = NFS_OK;
 
 	/* Get the delegation credential for use by test/free_stateid */
 	rcu_read_lock();
@@ -2753,20 +2758,15 @@ static void nfs41_check_delegation_stateid(struct nfs4_state *state)
 	if (delegation == NULL) {
 		rcu_read_unlock();
 		nfs_state_clear_delegation(state);
-		return;
+		return NFS_OK;
 	}
 
 	nfs4_stateid_copy(&stateid, &delegation->stateid);
-	if (test_bit(NFS_DELEGATION_REVOKED, &delegation->flags)) {
-		rcu_read_unlock();
-		nfs_state_clear_delegation(state);
-		return;
-	}
 
 	if (!test_and_clear_bit(NFS_DELEGATION_TEST_EXPIRED,
 				&delegation->flags)) {
 		rcu_read_unlock();
-		return;
+		return NFS_OK;
 	}
 
 	if (delegation->cred)
@@ -2776,8 +2776,24 @@ static void nfs41_check_delegation_stateid(struct nfs4_state *state)
 	trace_nfs4_test_delegation_stateid(state, NULL, status);
 	if (status == -NFS4ERR_EXPIRED || status == -NFS4ERR_BAD_STATEID)
 		nfs_finish_clear_delegation_stateid(state, &stateid);
+	else
+		ret = status;
 
 	put_cred(cred);
+	return ret;
+}
+
+static void nfs41_delegation_recover_stateid(struct nfs4_state *state)
+{
+	nfs4_stateid tmp;
+
+	if (test_bit(NFS_DELEGATED_STATE, &state->flags) &&
+	    nfs4_copy_delegation_stateid(state->inode, state->state,
+				&tmp, NULL) &&
+	    nfs4_stateid_match_other(&state->stateid, &tmp))
+		nfs_state_set_delegation(state, &tmp, state->state);
+	else
+		nfs_state_clear_delegation(state);
 }
 
 /**
@@ -2847,21 +2863,12 @@ static int nfs41_check_open_stateid(struct nfs4_state *state)
 	const struct cred *cred = state->owner->so_cred;
 	int status;
 
-	if (test_bit(NFS_OPEN_STATE, &state->flags) == 0) {
-		if (test_bit(NFS_DELEGATED_STATE, &state->flags) == 0)  {
-			if (nfs4_have_delegation(state->inode, state->state))
-				return NFS_OK;
-			return -NFS4ERR_OPENMODE;
-		}
+	if (test_bit(NFS_OPEN_STATE, &state->flags) == 0)
 		return -NFS4ERR_BAD_STATEID;
-	}
 	status = nfs41_test_and_free_expired_stateid(server, stateid, cred);
 	trace_nfs4_test_open_stateid(state, NULL, status);
 	if (status == -NFS4ERR_EXPIRED || status == -NFS4ERR_BAD_STATEID) {
-		clear_bit(NFS_O_RDONLY_STATE, &state->flags);
-		clear_bit(NFS_O_WRONLY_STATE, &state->flags);
-		clear_bit(NFS_O_RDWR_STATE, &state->flags);
-		clear_bit(NFS_OPEN_STATE, &state->flags);
+		nfs_state_clear_open_state_flags(state);
 		stateid->type = NFS4_INVALID_STATEID_TYPE;
 		return status;
 	}
@@ -2874,7 +2881,11 @@ static int nfs41_open_expired(struct nfs4_state_owner *sp, struct nfs4_state *st
 {
 	int status;
 
-	nfs41_check_delegation_stateid(state);
+	status = nfs41_check_delegation_stateid(state);
+	if (status != NFS_OK)
+		return status;
+	nfs41_delegation_recover_stateid(state);
+
 	status = nfs41_check_expired_locks(state);
 	if (status != NFS_OK)
 		return status;
-- 
2.21.0

