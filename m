Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B40AC10014F
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Nov 2019 10:31:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbfKRJbu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 18 Nov 2019 04:31:50 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42404 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbfKRJbt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 18 Nov 2019 04:31:49 -0500
Received: by mail-lj1-f194.google.com with SMTP id n5so18053131ljc.9
        for <linux-nfs@vger.kernel.org>; Mon, 18 Nov 2019 01:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qtVNjCJ2b2J38yE3FVXV5wfEh0ad5fvaxxACdd4VIyE=;
        b=AfntBur5UQsVXxwMQ8HHL/eQx0BGhZP+HxyAREGUtvq3nSTQ4Y7bGOzy4qaCCBUz3W
         QRpkVhLE/GiwFzEPFYcSLvWNYdbI7VE6dMPf5V64jqdeDkx0algWylNw7LpChZ467z22
         bJW78kePYqrJqsANUAwqD062GrYN1osFV3QNbbp3Kh7gIdQPHJFUC1L4YDKqT94tS4dI
         0YNCXe6xMXY+EslmMjFOO64J7uULi9i9AwqWEaDph6QSMaLc5GJWohtZUXK509SImM4Y
         pATE30x1kIYyQPD3pS86PSJJI31Ag2zu6BltmzkLgJp8zNVSrHf96k2cYWO2eGliSI8c
         dVMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qtVNjCJ2b2J38yE3FVXV5wfEh0ad5fvaxxACdd4VIyE=;
        b=fCIVxpvDeGNeIjWQdxg9nwMV3CtugrWiCQ3IFmOyTQx/xOcJ2No5CGv7IbjxkQy2WW
         Al7jXQCJSgTnngDvP8YgIO2btR6izer6H5M0Ts0/ayXwWY6+bfRHZWMPAx17p0FcGsra
         5/whYf97oEPykoQPem8CtZnsyjkRXD3TO/bgSIU5I6TWKfJBTU6tPadQZ5GqZViylbmf
         lXoimvlnl+RX+hrxc1HZzY6k8tRWAUEuG7UIXW0YUOnuoaM/1uN8kWvmyr1dgPjW0XQ3
         rBP7GteJ8xcrrW9FPPWLkJZeo6GXKnRN/RlNPJHaTegTiSGf/4eXtV/wC2rTF5l4+z16
         XtMA==
X-Gm-Message-State: APjAAAULdhOj/JCVa+WiSIcHo1+HAivyyADsqqp8LuoYmw+BlOLz6/R9
        VgY1IdvifDCA5ZrKE0CuVflc0QflWQ==
X-Google-Smtp-Source: APXvYqzk58XojiEmPUe3GrKgyMXWXByO8HF+7EXHEIC7pCmTUDiVL9jH3GmSMm0qpQVPxOQHBkftFQ==
X-Received: by 2002:a2e:9b4b:: with SMTP id o11mr20655637ljj.252.1574069506699;
        Mon, 18 Nov 2019 01:31:46 -0800 (PST)
Received: from localhost.localdomain (ti0389q160-4901.bb.online.no. [88.95.63.95])
        by smtp.gmail.com with ESMTPSA id w11sm9521631lji.45.2019.11.18.01.31.45
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 01:31:45 -0800 (PST)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/2] NFSv4.x: Handle bad/dead sessions correctly in nfs41_sequence_process()
Date:   Mon, 18 Nov 2019 10:29:34 +0100
Message-Id: <20191118092935.4283-1-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If the server returns a bad or dead session error, the we don't want
to update the session slot number, but just immediately schedule
recovery and allow it to proceed.

We can/should then remove handling in other places

Fixes: 3453d5708b33 ("NFSv4.1: Avoid false retries when RPC calls are interrupted")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4proc.c | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 970172dcdba1..d1a7facfa926 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -521,9 +521,7 @@ static int nfs4_do_handle_exception(struct nfs_server *server,
 		case -NFS4ERR_DEADSESSION:
 		case -NFS4ERR_SEQ_FALSE_RETRY:
 		case -NFS4ERR_SEQ_MISORDERED:
-			dprintk("%s ERROR: %d Reset session\n", __func__,
-				errorcode);
-			nfs4_schedule_session_recovery(clp->cl_session, errorcode);
+			/* Handled in nfs41_sequence_process() */
 			goto wait_on_recovery;
 #endif /* defined(CONFIG_NFS_V4_1) */
 		case -NFS4ERR_FILE_OPEN:
@@ -782,6 +780,7 @@ static int nfs41_sequence_process(struct rpc_task *task,
 	struct nfs4_session *session;
 	struct nfs4_slot *slot = res->sr_slot;
 	struct nfs_client *clp;
+	int status;
 	int ret = 1;
 
 	if (slot == NULL)
@@ -793,8 +792,13 @@ static int nfs41_sequence_process(struct rpc_task *task,
 	session = slot->table->session;
 
 	trace_nfs4_sequence_done(session, res);
+
+	status = res->sr_status;
+	if (task->tk_status == -NFS4ERR_DEADSESSION)
+		status = -NFS4ERR_DEADSESSION;
+
 	/* Check the SEQUENCE operation status */
-	switch (res->sr_status) {
+	switch (status) {
 	case 0:
 		/* Mark this sequence number as having been acked */
 		nfs4_slot_sequence_acked(slot, slot->seq_nr);
@@ -866,6 +870,10 @@ static int nfs41_sequence_process(struct rpc_task *task,
 		 */
 		slot->seq_nr = slot->seq_nr_highest_sent;
 		goto out_retry;
+	case -NFS4ERR_BADSESSION:
+	case -NFS4ERR_DEADSESSION:
+	case -NFS4ERR_CONN_NOT_BOUND_TO_SESSION:
+		goto session_recover;
 	default:
 		/* Just update the slot sequence no. */
 		slot->seq_done = 1;
@@ -876,8 +884,10 @@ static int nfs41_sequence_process(struct rpc_task *task,
 out_noaction:
 	return ret;
 session_recover:
-	nfs4_schedule_session_recovery(session, res->sr_status);
-	goto retry_nowait;
+	nfs4_schedule_session_recovery(session, status);
+	dprintk("%s ERROR: %d Reset session\n", __func__, status);
+	nfs41_sequence_free_slot(res);
+	goto out;
 retry_new_seq:
 	++slot->seq_nr;
 retry_nowait:
@@ -2188,7 +2198,6 @@ static int nfs4_handle_delegation_recall_error(struct nfs_server *server, struct
 		case -NFS4ERR_BAD_HIGH_SLOT:
 		case -NFS4ERR_CONN_NOT_BOUND_TO_SESSION:
 		case -NFS4ERR_DEADSESSION:
-			nfs4_schedule_session_recovery(server->nfs_client->cl_session, err);
 			return -EAGAIN;
 		case -NFS4ERR_STALE_CLIENTID:
 		case -NFS4ERR_STALE_STATEID:
@@ -7824,6 +7833,15 @@ nfs41_same_server_scope(struct nfs41_server_scope *a,
 static void
 nfs4_bind_one_conn_to_session_done(struct rpc_task *task, void *calldata)
 {
+	struct nfs41_bind_conn_to_session_args *args = task->tk_msg.rpc_argp;
+	struct nfs_client *clp = args->client;
+
+	switch (task->tk_status) {
+	case -NFS4ERR_BADSESSION:
+	case -NFS4ERR_DEADSESSION:
+		nfs4_schedule_session_recovery(clp->cl_session,
+				task->tk_status);
+	}
 }
 
 static const struct rpc_call_ops nfs4_bind_one_conn_to_session_ops = {
@@ -8871,8 +8889,6 @@ static int nfs41_reclaim_complete_handle_errors(struct rpc_task *task, struct nf
 	case -NFS4ERR_BADSESSION:
 	case -NFS4ERR_DEADSESSION:
 	case -NFS4ERR_CONN_NOT_BOUND_TO_SESSION:
-		nfs4_schedule_session_recovery(clp->cl_session,
-				task->tk_status);
 		break;
 	default:
 		nfs4_schedule_lease_recovery(clp);
-- 
2.23.0

