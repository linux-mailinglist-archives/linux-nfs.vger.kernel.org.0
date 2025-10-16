Return-Path: <linux-nfs+bounces-15309-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 52AD6BE55B8
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Oct 2025 22:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E54F74E4D50
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Oct 2025 20:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5019F261B65;
	Thu, 16 Oct 2025 20:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CSB2odci"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EF31A9F93
	for <linux-nfs@vger.kernel.org>; Thu, 16 Oct 2025 20:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760645993; cv=none; b=gz9cn3hXO9Wx7MBOjlpIofbAJy6ZDD/xjhLxgAXaYzHpSEqqridBIT1fWulOIhCezaIkBoCQmAGPyUZxlGziBO2s0zQhoblnRtK3m3ybOoBxAcbnCItZXvo8+iWAf429QaiJ/J6Z0B9ooZbUE8j6YqS17k0W9pMNYv3n7rd3ZKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760645993; c=relaxed/simple;
	bh=Z3iyNrYbhzb9hFJanwhOMu/EtVrKnsj4KculgtjehTE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LtpwNjXkBpDAm+dHgdLCalOy4Bqc5D/nV/4UcidVKzAUfEoT9qCmMRzBKO/hMs0xDzo5upq5Q1ySq9eYwAFCHcQz1vdfWTe1wyCeXaD170TPr/h/FwK+YUNVa3Wx1/Sy+TxCIn/VZeOMGcE3x+YV3sPI0fp0pW/GIRDuzfjQMAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CSB2odci; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-78125ed4052so1575865b3a.0
        for <linux-nfs@vger.kernel.org>; Thu, 16 Oct 2025 13:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760645991; x=1761250791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+av0HPtEwSTsOCuSUQdK1ftanNeIM9GRj5WV9WejZ/s=;
        b=CSB2odcidoLLIq9XgNL8vL7kBCaGukr6QsXzG8ywOaeTLrLgDkqRZtcoSQjoXzRBd4
         5h5D43DXwHVV4fbJPbHqvKptYEik84jgsddbkt0albmIcxAyL+TChXDwiQGwdZ8UgvMW
         m+mBO3yFmjQTIZBt48xmaVbSin4F34gkS1aRbOpTQ4lMO1FI0sRGfhFQj8QTj9ccyzy9
         95TN1fB/mfKFXwwHtgev/jnaxQ5eaZHz1H4vJ2kQ32stlPM+HmhGWc2IURuD8nc6ySXQ
         WM4xf0/fDFyTjUVld7bb80Jjyh+dO8+Dmj9CsUw6X99OhZp2EV8lMNyw0XC2y3aEK4GN
         oOfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760645991; x=1761250791;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+av0HPtEwSTsOCuSUQdK1ftanNeIM9GRj5WV9WejZ/s=;
        b=LPuDScqKTnOfhtllN0Xtno2gyJPnVUecgIUX93AaPxl0iajGNwtIHFE9nJG2PNSww3
         3puB+/bnWpWoVSYqOF7l+hRGfNmvNEFKCVI5OmGu4/bSmQtrdZn68STImBLTdLdRdPKg
         d6xMn2dqtxNnZsTE3siUAQCWDnEwGbO6P9pau9L/mas+delVA0vPnQhPt3WWPmktBy9v
         eYnxKU+P1nkDxvPWA4q8DO4Wh9vy2aLFxfM3PGr+5V/S+jelrhKoh/6nEK3GNoOuXByx
         WO9uZ5VOyQurNNYsRCRjC2stGKa/9I3UcIAAqPYOay6v9F8tl75CszrfXnr7kkgrfTZE
         7kqw==
X-Forwarded-Encrypted: i=1; AJvYcCX8HZTNmyehlJ+7bo+ZCX+dsDOQENSsbOysivZbDxmndzuDlhCc0E4nhXnh3uHdkQnCnuEDLQoxr3E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1uQOgqw8GMYhsn1VNAbMI8r3Oec1gPEQmXKkc5Keb3H8qypvQ
	pEbL+87/FvJqLkw9v45Ix5++JUR56UdczjqJRLZlyY4wFL44ORfOM2cM
X-Gm-Gg: ASbGncut2anqTL3hMSiCBFeGQpIlIQp5p3nL1MZIUK5YLWNGogNIJQJ5tL+580wDdxY
	Q5oRjVZSFBFiry3Q5f8OwcbqzA1selVV+nf8AHJP01BQDxv2pvMxGKlB6KxUQDqTrQwsGmRNu0T
	eH9EERY+ejE/Qaf2/weDZxBSZZ/ODY2s8KBC8v618cZCGY1YojDWZNdrFG6LorzZL2uvrbLBsiT
	Vl3PUL7ytmztaVYkp+MUW3kB8eX0id/QNS3lh7/nt8NrNhQKalVOHeRmhAotwp/1gxYJTWEa9uh
	JgqLkrkuT8+5Rr5KEVjQmQgPIpbgt8c7NOW5Df1xwENooGF8Lbn6vgGoVsAiJ2RtluPwPuwP+YZ
	uJfwauCr4UGAVuwHTvSTQ0P6btfLgX8PVhR7ZhC+CFDMxqFxopOHfpQYdY3dHhlJ1MEaSn3+14b
	xIu94Lgs99YgqX59fb91vcO+KVUOIYth4gT/wcfF0kmQTOaIcZTs3ac803ctLKgIEmx57KNcIZ
X-Google-Smtp-Source: AGHT+IG+sxkvw4J66EyUWy7hkA9Gt8yHCCBQKvQGF3IO+F1MDMkkuQKd8HWWzZx0fFVzrv7/MgTNLw==
X-Received: by 2002:a05:6a20:7344:b0:262:4378:9df2 with SMTP id adf61e73a8af0-334a86384femr1667733637.44.1760645990579;
        Thu, 16 Oct 2025 13:19:50 -0700 (PDT)
Received: from linux-dev.dhcp4.washington.edu ([205.175.106.178])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a198c57513sm7326767b3a.23.2025.10.16.13.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 13:19:50 -0700 (PDT)
From: Aditya Gollamudi <adigollamudi@gmail.com>
To: trondmy@kernel.org
Cc: adigollamudi@gmail.com,
	anna@kernel.org,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fs/nfs: Resolve style errors in fs/nfs/nfs4proc.c
Date: Thu, 16 Oct 2025 12:50:13 -0700
Message-Id: <20251016195013.25929-1-adigollamudi@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Adi Gollamudi <adigollamudi@gmail.com>

add spaces before opening parentheses "(", fix indentation of switch cases, remove trailing
whitespaces, make "else if" start on the same line as closing "if" brace and fix spacing around "=".10 errors remain in fs/nfs/nfs4proc.c

Signed-off-by: Adi Gollamudi <adigollamudi@gmail.com>
---
 fs/nfs/nfs4proc.c | 277 +++++++++++++++++++++++-----------------------
 1 file changed, 137 insertions(+), 140 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index f58098417142..35df95407059 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -518,7 +518,7 @@ static int nfs4_do_handle_exception(struct nfs_server *server,
 	if (stateid == NULL && state != NULL)
 		stateid = nfs4_recoverable_stateid(&state->stateid);

-	switch(errorcode) {
+	switch (errorcode) {
 		case 0:
 			return 0;
 		case -NFS4ERR_BADHANDLE:
@@ -1566,7 +1566,7 @@ static void nfs4_opendata_put(struct nfs4_opendata *p)
 static bool nfs4_mode_match_open_stateid(struct nfs4_state *state,
 		fmode_t fmode)
 {
-	switch(fmode & (FMODE_READ|FMODE_WRITE)) {
+	switch (fmode & (FMODE_READ|FMODE_WRITE)) {
 	case FMODE_READ|FMODE_WRITE:
 		return state->n_rdwr != 0;
 	case FMODE_WRITE:
@@ -2247,7 +2247,7 @@ static int nfs4_open_recover_helper(struct nfs4_opendata *opendata,
 	nfs4_init_opendata_res(opendata);
 	ret = _nfs4_recover_proc_open(opendata);
 	if (ret != 0)
-		return ret;
+		return ret;
 	newstate = nfs4_opendata_to_nfs4_state(opendata);
 	if (IS_ERR(newstate))
 		return PTR_ERR(newstate);
@@ -2304,7 +2304,7 @@ static int _nfs4_do_open_reclaim(struct nfs_open_context *ctx, struct nfs4_state
 	rcu_read_lock();
 	delegation = rcu_dereference(NFS_I(state->inode)->delegation);
 	if (delegation != NULL && test_bit(NFS_DELEGATION_NEED_RECLAIM, &delegation->flags) != 0) {
-		switch(delegation->type) {
+		switch (delegation->type) {
 		case FMODE_READ:
 			delegation_type = NFS4_OPEN_DELEGATE_READ;
 			if (test_bit(NFS_DELEGATION_DELEGTIME, &delegation->flags))
@@ -2359,54 +2359,54 @@ static int nfs4_open_reclaim(struct nfs4_state_owner *sp, struct nfs4_state *sta
 static int nfs4_handle_delegation_recall_error(struct nfs_server *server, struct nfs4_state *state, const nfs4_stateid *stateid, struct file_lock *fl, int err)
 {
 	switch (err) {
-		default:
-			printk(KERN_ERR "NFS: %s: unhandled error "
-					"%d.\n", __func__, err);
-			fallthrough;
-		case 0:
-		case -ENOENT:
-		case -EAGAIN:
-		case -ESTALE:
-		case -ETIMEDOUT:
-			break;
-		case -NFS4ERR_BADSESSION:
-		case -NFS4ERR_BADSLOT:
-		case -NFS4ERR_BAD_HIGH_SLOT:
-		case -NFS4ERR_CONN_NOT_BOUND_TO_SESSION:
-		case -NFS4ERR_DEADSESSION:
-			return -EAGAIN;
-		case -NFS4ERR_STALE_CLIENTID:
-		case -NFS4ERR_STALE_STATEID:
-			/* Don't recall a delegation if it was lost */
-			nfs4_schedule_lease_recovery(server->nfs_client);
-			return -EAGAIN;
-		case -NFS4ERR_MOVED:
-			nfs4_schedule_migration_recovery(server);
-			return -EAGAIN;
-		case -NFS4ERR_LEASE_MOVED:
-			nfs4_schedule_lease_moved_recovery(server->nfs_client);
-			return -EAGAIN;
-		case -NFS4ERR_DELEG_REVOKED:
-		case -NFS4ERR_ADMIN_REVOKED:
-		case -NFS4ERR_EXPIRED:
-		case -NFS4ERR_BAD_STATEID:
-		case -NFS4ERR_OPENMODE:
-			nfs_inode_find_state_and_recover(state->inode,
-					stateid);
-			nfs4_schedule_stateid_recovery(server, state);
-			return -EAGAIN;
-		case -NFS4ERR_DELAY:
-		case -NFS4ERR_GRACE:
-			ssleep(1);
-			return -EAGAIN;
-		case -ENOMEM:
-		case -NFS4ERR_DENIED:
-			if (fl) {
-				struct nfs4_lock_state *lsp = fl->fl_u.nfs4_fl.owner;
-				if (lsp)
-					set_bit(NFS_LOCK_LOST, &lsp->ls_flags);
-			}
-			return 0;
+	default:
+		printk(KERN_ERR "NFS: %s: unhandled error "
+				"%d.\n", __func__, err);
+		fallthrough;
+	case 0:
+	case -ENOENT:
+	case -EAGAIN:
+	case -ESTALE:
+	case -ETIMEDOUT:
+		break;
+	case -NFS4ERR_BADSESSION:
+	case -NFS4ERR_BADSLOT:
+	case -NFS4ERR_BAD_HIGH_SLOT:
+	case -NFS4ERR_CONN_NOT_BOUND_TO_SESSION:
+	case -NFS4ERR_DEADSESSION:
+		return -EAGAIN;
+	case -NFS4ERR_STALE_CLIENTID:
+	case -NFS4ERR_STALE_STATEID:
+		/* Don't recall a delegation if it was lost */
+		nfs4_schedule_lease_recovery(server->nfs_client);
+		return -EAGAIN;
+	case -NFS4ERR_MOVED:
+		nfs4_schedule_migration_recovery(server);
+		return -EAGAIN;
+	case -NFS4ERR_LEASE_MOVED:
+		nfs4_schedule_lease_moved_recovery(server->nfs_client);
+		return -EAGAIN;
+	case -NFS4ERR_DELEG_REVOKED:
+	case -NFS4ERR_ADMIN_REVOKED:
+	case -NFS4ERR_EXPIRED:
+	case -NFS4ERR_BAD_STATEID:
+	case -NFS4ERR_OPENMODE:
+		nfs_inode_find_state_and_recover(state->inode,
+				stateid);
+		nfs4_schedule_stateid_recovery(server, state);
+		return -EAGAIN;
+	case -NFS4ERR_DELAY:
+	case -NFS4ERR_GRACE:
+		ssleep(1);
+		return -EAGAIN;
+	case -ENOMEM:
+	case -NFS4ERR_DENIED:
+		if (fl) {
+			struct nfs4_lock_state *lsp = fl->fl_u.nfs4_fl.owner;
+			if (lsp)
+				set_bit(NFS_LOCK_LOST, &lsp->ls_flags);
+		}
+		return 0;
 	}
 	return err;
 }
@@ -2810,7 +2810,7 @@ static int _nfs4_proc_open(struct nfs4_opendata *data,
 	}
 	if ((o_res->rflags & NFS4_OPEN_RESULT_LOCKTYPE_POSIX) == 0)
 		server->caps &= ~NFS_CAP_POSIX_LOCK;
-	if(o_res->rflags & NFS4_OPEN_RESULT_CONFIRM) {
+	if (o_res->rflags & NFS4_OPEN_RESULT_CONFIRM) {
 		status = _nfs4_proc_open_confirm(data);
 		if (status != 0)
 			return status;
@@ -3186,7 +3186,7 @@ static int _nfs4_open_and_get_state(struct nfs4_opendata *opendata,
 		}
 	}

-	switch(opendata->o_arg.claim) {
+	switch (opendata->o_arg.claim) {
 	default:
 		break;
 	case NFS4_OPEN_CLAIM_NULL:
@@ -3679,40 +3679,40 @@ static void nfs4_close_done(struct rpc_task *task, void *data)
 	 * the state_owner. we keep this around to process errors
 	 */
 	switch (task->tk_status) {
-		case 0:
-			res_stateid = &calldata->res.stateid;
-			renew_lease(server, calldata->timestamp);
-			break;
-		case -NFS4ERR_ACCESS:
-			if (calldata->arg.bitmask != NULL) {
-				calldata->arg.bitmask = NULL;
-				calldata->res.fattr = NULL;
-				goto out_restart;
+	case 0:
+		res_stateid = &calldata->res.stateid;
+		renew_lease(server, calldata->timestamp);
+		break;
+	case -NFS4ERR_ACCESS:
+		if (calldata->arg.bitmask != NULL) {
+			calldata->arg.bitmask = NULL;
+			calldata->res.fattr = NULL;
+			goto out_restart;

-			}
+		}
+		break;
+	case -NFS4ERR_OLD_STATEID:
+		/* Did we race with OPEN? */
+		if (nfs4_refresh_open_old_stateid(&calldata->arg.stateid,
+					state))
+			goto out_restart;
+		goto out_release;
+	case -NFS4ERR_ADMIN_REVOKED:
+	case -NFS4ERR_STALE_STATEID:
+	case -NFS4ERR_EXPIRED:
+		nfs4_free_revoked_stateid(server,
+				&calldata->arg.stateid,
+				task->tk_msg.rpc_cred);
+		fallthrough;
+	case -NFS4ERR_BAD_STATEID:
+		if (calldata->arg.fmode == 0)
 			break;
-		case -NFS4ERR_OLD_STATEID:
-			/* Did we race with OPEN? */
-			if (nfs4_refresh_open_old_stateid(&calldata->arg.stateid,
-						state))
-				goto out_restart;
-			goto out_release;
-		case -NFS4ERR_ADMIN_REVOKED:
-		case -NFS4ERR_STALE_STATEID:
-		case -NFS4ERR_EXPIRED:
-			nfs4_free_revoked_stateid(server,
-					&calldata->arg.stateid,
-					task->tk_msg.rpc_cred);
-			fallthrough;
-		case -NFS4ERR_BAD_STATEID:
-			if (calldata->arg.fmode == 0)
-				break;
-			fallthrough;
-		default:
-			task->tk_status = nfs4_async_handle_exception(task,
-					server, task->tk_status, &exception);
-			if (exception.retry)
-				goto out_restart;
+		fallthrough;
+	default:
+		task->tk_status = nfs4_async_handle_exception(task,
+				server, task->tk_status, &exception);
+		if (exception.retry)
+			goto out_restart;
 	}
 	nfs_clear_open_stateid(state, &calldata->arg.stateid,
 			res_stateid, calldata->arg.fmode);
@@ -3823,13 +3823,13 @@ static const struct rpc_call_ops nfs4_close_ops = {
 	.rpc_release = nfs4_free_closedata,
 };

-/*
- * It is possible for data to be read/written from a mem-mapped file
+/*
+ * It is possible for data to be read/written from a mem-mapped file
  * after the sys_close call (which hits the vfs layer as a flush).
- * This means that we can't safely call nfsv4 close on a file until
+ * This means that we can't safely call nfsv4 close on a file until
  * the inode is cleared. This in turn means that we are not good
- * NFSv4 citizens - we do not indicate to the server to update the file's
- * share state even when we are done with one of the three share
+ * NFSv4 citizens - we do not indicate to the server to update the file's
+ * share state even when we are done with one of the three share
  * stateid's in the inode.
  *
  * NOTE: Caller must be holding the sp->so_owner semaphore!
@@ -4506,7 +4506,7 @@ int nfs4_proc_getattr(struct nfs_server *server, struct nfs_fh *fhandle,
 	return err;
 }

-/*
+/*
  * The file is not closed if it is opened due to the a request to change
  * the size of the file. The open call will not be needed once the
  * VFS layer lookup-intents are implemented.
@@ -4538,7 +4538,6 @@ nfs4_proc_setattr(struct dentry *dentry, struct nfs_fattr *fattr,
 		pnfs_commit_and_return_layout(inode);

 	nfs_fattr_init(fattr);
-
 	/* Deal with open(O_TRUNC) */
 	if (sattr->ia_valid & ATTR_OPEN)
 		sattr->ia_valid &= ~(ATTR_MTIME|ATTR_CTIME);
@@ -5219,7 +5218,6 @@ static int _nfs4_proc_symlink(struct inode *dir, struct dentry *dentry,
 	data->arg.u.symlink.pages = &page;
 	data->arg.u.symlink.len = len;
 	data->arg.label = label;
-
 	status = nfs4_do_create(dir, dentry, data);

 	nfs4_free_createdata(data);
@@ -5373,8 +5371,7 @@ static int _nfs4_proc_mknod(struct inode *dir, struct dentry *dentry,
 		data->arg.ftype = NF4BLK;
 		data->arg.u.device.specdata1 = MAJOR(rdev);
 		data->arg.u.device.specdata2 = MINOR(rdev);
-	}
-	else if (S_ISCHR(mode)) {
+	} else if (S_ISCHR(mode)) {
 		data->arg.ftype = NF4CHR;
 		data->arg.u.device.specdata1 = MAJOR(rdev);
 		data->arg.u.device.specdata2 = MINOR(rdev);
@@ -6033,7 +6030,7 @@ int nfs4_buf_to_pages_noslab(const void *buf, size_t buflen,
 	return rc;

 unwind:
-	for(; rc > 0; rc--)
+	for (; rc > 0; rc--)
 		__free_page(spages[rc-1]);
 	return -ENOMEM;
 }
@@ -6759,7 +6756,7 @@ static void nfs4_delegreturn_done(struct rpc_task *task, void *calldata)
 		goto out_restart;

 	if (data->args.sattr_args && task->tk_status != 0) {
-		switch(data->res.sattr_ret) {
+		switch (data->res.sattr_ret) {
 		case 0:
 			data->args.sattr_args = NULL;
 			data->res.sattr_res = false;
@@ -6980,10 +6977,10 @@ int nfs4_proc_delegreturn(struct inode *inode, const struct cred *cred,
 					     delegation, issync);
 		trace_nfs4_delegreturn(inode, stateid, err);
 		switch (err) {
-			case -NFS4ERR_STALE_STATEID:
-			case -NFS4ERR_EXPIRED:
-			case 0:
-				return 0;
+		case -NFS4ERR_STALE_STATEID:
+		case -NFS4ERR_EXPIRED:
+		case 0:
+			return 0;
 		}
 		err = nfs4_handle_exception(server, err, &exception);
 	} while (exception.retry);
@@ -7020,11 +7017,11 @@ static int _nfs4_proc_getlk(struct nfs4_state *state, int cmd, struct file_lock
 	arg.lock_owner.s_dev = server->s_dev;
 	status = nfs4_call_sync(server->client, server, &msg, &arg.seq_args, &res.seq_res, 1);
 	switch (status) {
-		case 0:
-			request->c.flc_type = F_UNLCK;
-			break;
-		case -NFS4ERR_DENIED:
-			status = 0;
+	case 0:
+		request->c.flc_type = F_UNLCK;
+		break;
+	case -NFS4ERR_DENIED:
+		status = 0;
 	}
 	request->fl_ops->fl_release_private(request);
 	request->fl_ops = NULL;
@@ -7152,36 +7149,36 @@ static void nfs4_locku_done(struct rpc_task *task, void *data)
 	if (!nfs4_sequence_done(task, &calldata->res.seq_res))
 		return;
 	switch (task->tk_status) {
-		case 0:
-			renew_lease(calldata->server, calldata->timestamp);
-			locks_lock_inode_wait(calldata->lsp->ls_state->inode, &calldata->fl);
-			if (nfs4_update_lock_stateid(calldata->lsp,
-					&calldata->res.stateid))
-				break;
-			fallthrough;
-		case -NFS4ERR_ADMIN_REVOKED:
-		case -NFS4ERR_EXPIRED:
-			nfs4_free_revoked_stateid(calldata->server,
-					&calldata->arg.stateid,
-					task->tk_msg.rpc_cred);
-			fallthrough;
-		case -NFS4ERR_BAD_STATEID:
-		case -NFS4ERR_STALE_STATEID:
-			if (nfs4_sync_lock_stateid(&calldata->arg.stateid,
-						calldata->lsp))
-				rpc_restart_call_prepare(task);
-			break;
-		case -NFS4ERR_OLD_STATEID:
-			if (nfs4_refresh_lock_old_stateid(&calldata->arg.stateid,
-						calldata->lsp))
-				rpc_restart_call_prepare(task);
+	case 0:
+		renew_lease(calldata->server, calldata->timestamp);
+		locks_lock_inode_wait(calldata->lsp->ls_state->inode, &calldata->fl);
+		if (nfs4_update_lock_stateid(calldata->lsp,
+				&calldata->res.stateid))
 			break;
-		default:
-			task->tk_status = nfs4_async_handle_exception(task,
-					calldata->server, task->tk_status,
-					&exception);
-			if (exception.retry)
-				rpc_restart_call_prepare(task);
+		fallthrough;
+	case -NFS4ERR_ADMIN_REVOKED:
+	case -NFS4ERR_EXPIRED:
+		nfs4_free_revoked_stateid(calldata->server,
+				&calldata->arg.stateid,
+				task->tk_msg.rpc_cred);
+		fallthrough;
+	case -NFS4ERR_BAD_STATEID:
+	case -NFS4ERR_STALE_STATEID:
+		if (nfs4_sync_lock_stateid(&calldata->arg.stateid,
+					calldata->lsp))
+			rpc_restart_call_prepare(task);
+		break;
+	case -NFS4ERR_OLD_STATEID:
+		if (nfs4_refresh_lock_old_stateid(&calldata->arg.stateid,
+					calldata->lsp))
+			rpc_restart_call_prepare(task);
+		break;
+	default:
+		task->tk_status = nfs4_async_handle_exception(task,
+				calldata->server, task->tk_status,
+				&exception);
+		if (exception.retry)
+			rpc_restart_call_prepare(task);
 	}
 	nfs_release_seqid(calldata->arg.seqid);
 }
@@ -7684,7 +7681,7 @@ nfs4_retry_setlk_simple(struct nfs4_state *state, int cmd,
 	int		status = -ERESTARTSYS;
 	unsigned long	timeout = NFS4_LOCK_MINTIMEOUT;

-	while(!signalled()) {
+	while (!signalled()) {
 		status = nfs4_proc_setlk(state, cmd, request);
 		if ((status != -EAGAIN) || IS_SETLK(cmd))
 			break;
@@ -9619,7 +9616,7 @@ static void nfs41_sequence_release(void *data)

 static int nfs41_sequence_handle_errors(struct rpc_task *task, struct nfs_client *clp)
 {
-	switch(task->tk_status) {
+	switch (task->tk_status) {
 	case -NFS4ERR_DELAY:
 		rpc_delay(task, NFS4_POLL_RETRY_MAX);
 		return -EAGAIN;
@@ -9767,7 +9764,7 @@ static void nfs4_reclaim_complete_prepare(struct rpc_task *task, void *data)

 static int nfs41_reclaim_complete_handle_errors(struct rpc_task *task, struct nfs_client *clp)
 {
-	switch(task->tk_status) {
+	switch (task->tk_status) {
 	case 0:
 		wake_up_all(&clp->cl_lock_waitq);
 		fallthrough;
@@ -10536,7 +10533,7 @@ static void nfs4_handle_delay_or_session_error(struct nfs_server *server,
 		int err, struct nfs4_exception *exception)
 {
 	exception->retry = 0;
-	switch(err) {
+	switch (err) {
 	case -NFS4ERR_DELAY:
 	case -NFS4ERR_RETRY_UNCACHED_REP:
 		nfs4_handle_exception(server, err, exception);
--
2.34.1


