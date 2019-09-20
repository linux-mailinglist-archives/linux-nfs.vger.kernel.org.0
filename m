Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB91AB8EFB
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Sep 2019 13:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438184AbfITL0N (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Sep 2019 07:26:13 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:46661 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438186AbfITL0N (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Sep 2019 07:26:13 -0400
Received: by mail-io1-f65.google.com with SMTP id c6so2125995ioo.13
        for <linux-nfs@vger.kernel.org>; Fri, 20 Sep 2019 04:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=isIuY52YMigDpv+ec/V/dH0sTr/uAIcEnxiREMN/WIA=;
        b=DyyhfbaKOiziy+dizHrQ3Nb1WW7GnJqmmJ0BIv2HBLaXTQZGNDkRfQxcfom1/TaQqa
         /5X667auj5jDIRn+RFCtDAeM8QaMyXoDo1M5pcV8SPNzOhuntRTUj8nf9zJeUQ11scau
         JB+Wlu+bEDpHT7ryLZX5/MUMszUy9S+E3z/jGXX/BfHf2o3QbyCAr4Nup/4ZM/aj1eRc
         iKLxizx6vaEQOgilW5XcBupm6cJ6kOsbYPSyqZ5Ph+HNM9g8n+92RScY5j+vlt+ulrIk
         UXCZ/joyK8mGWbea4RCyMCjqwxg6P30Eyt8G883gLWin9i3UnCVhUWrDvk5Uyai9E1fV
         IGUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=isIuY52YMigDpv+ec/V/dH0sTr/uAIcEnxiREMN/WIA=;
        b=rQbVFecGTgmNpiQDUE6k/YnSMS73NUDqzdBS7CpCPJY7ri9XXMbpQYQDNrsS8DyAT3
         MH+SKQn7YsRwOl8IEv8FijR4HUjLN2rQk3xBT5tKQ2ck3wa6ZUOnSoYwkwdiNTmv79hf
         75SFpatU88vLrRYRykmcKNTEM81Lr0mlBI8ZRUdsq9Lh4ohYsmqogkLZG/weQ1RaiFrx
         v5VACQO72Tj2m32ti/Np2biGQpkBDDzV19X0SRuzu8BUDtuOkH9D9jHkKVcXK6GOjNka
         GdbsjW9DRmc1z+WMQMX8c7d8jN3hUMyQtLls26V6OAPyRj6uhAXw2/QXrIxaCdNUOuiY
         a7Gg==
X-Gm-Message-State: APjAAAWBTMZhkefnQdrQWuHHKNeVUQw98WykMZQ+5jmc2eok6AMkil2W
        RU6jxp9dFg7kwYGVLvdFuw==
X-Google-Smtp-Source: APXvYqwRNNiDMtPbAIgkJoTDmNYOHY/mSzMCkxWPLmi2biky0uImXb9meuaox3AB49pWgZo7k04XSg==
X-Received: by 2002:a6b:9308:: with SMTP id v8mr1170362iod.221.1568978771937;
        Fri, 20 Sep 2019 04:26:11 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id q74sm1308736iod.72.2019.09.20.04.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2019 04:26:11 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     Olga Kornievskaia <aglo@umich.edu>, linux-nfs@vger.kernel.org
Subject: [PATCH v3 9/9] NFSv4: Handle NFS4ERR_OLD_STATEID in LOCKU
Date:   Fri, 20 Sep 2019 07:23:48 -0400
Message-Id: <20190920112348.69496-10-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190920112348.69496-9-trond.myklebust@hammerspace.com>
References: <20190920112348.69496-1-trond.myklebust@hammerspace.com>
 <20190920112348.69496-2-trond.myklebust@hammerspace.com>
 <20190920112348.69496-3-trond.myklebust@hammerspace.com>
 <20190920112348.69496-4-trond.myklebust@hammerspace.com>
 <20190920112348.69496-5-trond.myklebust@hammerspace.com>
 <20190920112348.69496-6-trond.myklebust@hammerspace.com>
 <20190920112348.69496-7-trond.myklebust@hammerspace.com>
 <20190920112348.69496-8-trond.myklebust@hammerspace.com>
 <20190920112348.69496-9-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If a LOCKU request receives a NFS4ERR_OLD_STATEID, then bump the
seqid before resending. Ensure we only bump the seqid by 1.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4proc.c | 53 ++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 48 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index c14af2c1c6b6..415480b7e43e 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -6411,6 +6411,42 @@ static int nfs4_proc_getlk(struct nfs4_state *state, int cmd, struct file_lock *
 	return err;
 }
 
+/*
+ * Update the seqid of a lock stateid after receiving
+ * NFS4ERR_OLD_STATEID
+ */
+static bool nfs4_refresh_lock_old_stateid(nfs4_stateid *dst,
+		struct nfs4_lock_state *lsp)
+{
+	struct nfs4_state *state = lsp->ls_state;
+	bool ret = false;
+
+	spin_lock(&state->state_lock);
+	if (!nfs4_stateid_match_other(dst, &lsp->ls_stateid))
+		goto out;
+	if (!nfs4_stateid_is_newer(&lsp->ls_stateid, dst))
+		nfs4_stateid_seqid_inc(dst);
+	else
+		dst->seqid = lsp->ls_stateid.seqid;
+	ret = true;
+out:
+	spin_unlock(&state->state_lock);
+	return ret;
+}
+
+static bool nfs4_sync_lock_stateid(nfs4_stateid *dst,
+		struct nfs4_lock_state *lsp)
+{
+	struct nfs4_state *state = lsp->ls_state;
+	bool ret;
+
+	spin_lock(&state->state_lock);
+	ret = !nfs4_stateid_match_other(dst, &lsp->ls_stateid);
+	nfs4_stateid_copy(dst, &lsp->ls_stateid);
+	spin_unlock(&state->state_lock);
+	return ret;
+}
+
 struct nfs4_unlockdata {
 	struct nfs_locku_args arg;
 	struct nfs_locku_res res;
@@ -6428,7 +6464,8 @@ static struct nfs4_unlockdata *nfs4_alloc_unlockdata(struct file_lock *fl,
 		struct nfs_seqid *seqid)
 {
 	struct nfs4_unlockdata *p;
-	struct inode *inode = lsp->ls_state->inode;
+	struct nfs4_state *state = lsp->ls_state;
+	struct inode *inode = state->inode;
 
 	p = kzalloc(sizeof(*p), GFP_NOFS);
 	if (p == NULL)
@@ -6444,6 +6481,9 @@ static struct nfs4_unlockdata *nfs4_alloc_unlockdata(struct file_lock *fl,
 	locks_init_lock(&p->fl);
 	locks_copy_lock(&p->fl, fl);
 	p->server = NFS_SERVER(inode);
+	spin_lock(&state->state_lock);
+	nfs4_stateid_copy(&p->arg.stateid, &lsp->ls_stateid);
+	spin_unlock(&state->state_lock);
 	return p;
 }
 
@@ -6482,10 +6522,14 @@ static void nfs4_locku_done(struct rpc_task *task, void *data)
 					task->tk_msg.rpc_cred);
 			/* Fall through */
 		case -NFS4ERR_BAD_STATEID:
-		case -NFS4ERR_OLD_STATEID:
 		case -NFS4ERR_STALE_STATEID:
-			if (!nfs4_stateid_match(&calldata->arg.stateid,
-						&calldata->lsp->ls_stateid))
+			if (nfs4_sync_lock_stateid(&calldata->arg.stateid,
+						calldata->lsp))
+				rpc_restart_call_prepare(task);
+			break;
+		case -NFS4ERR_OLD_STATEID:
+			if (nfs4_refresh_lock_old_stateid(&calldata->arg.stateid,
+						calldata->lsp))
 				rpc_restart_call_prepare(task);
 			break;
 		default:
@@ -6508,7 +6552,6 @@ static void nfs4_locku_prepare(struct rpc_task *task, void *data)
 
 	if (nfs_wait_on_sequence(calldata->arg.seqid, task) != 0)
 		goto out_wait;
-	nfs4_stateid_copy(&calldata->arg.stateid, &calldata->lsp->ls_stateid);
 	if (test_bit(NFS_LOCK_INITIALIZED, &calldata->lsp->ls_flags) == 0) {
 		/* Note: exit _without_ running nfs4_locku_done */
 		goto out_no_action;
-- 
2.21.0

