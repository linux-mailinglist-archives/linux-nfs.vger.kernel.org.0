Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B29E2853A6
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Aug 2019 21:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389293AbfHGTgP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 7 Aug 2019 15:36:15 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40871 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389273AbfHGTgP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 7 Aug 2019 15:36:15 -0400
Received: by mail-ot1-f65.google.com with SMTP id l15so51735512oth.7
        for <linux-nfs@vger.kernel.org>; Wed, 07 Aug 2019 12:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BLwUconpSd4fc18pxrnnaYROcXN/y55tc48Wt07pbi0=;
        b=OiWByV4IjttMmDEE9xddygJUq9kO0m2DSiVIH790w8+kD2xx4n8qaRNgev9oZaiL+x
         LNtkcVJZxKCQn6dxlhaBAgnCpf++ZRLAG8oF3Smxd0VT+AMVE+jud4ymidQPwCYShmMW
         6MO2MKX/wPQsphEy5Ys3qCDYWEkOMqyWi1L6UuHz3XJuytDhu04ruLnYKJREk9OTHPdI
         1CUcvXf+RKStwwpbTr+2zZqEiVZ/2IadGGuFoDZX+bPQvo6T/i48Izxyv3zByVAVKI9o
         Fdue9UpKyKpfZ00TdhN3VP7GWxnjwocrygU1htzM9gn6ySPw7FmHc1e4o3q1UYsfJzE1
         Ve6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BLwUconpSd4fc18pxrnnaYROcXN/y55tc48Wt07pbi0=;
        b=RzSocth3R3y56+gkawxnLPUgpkuRZRNRDaDI0C4tGhkuoUPIb7DQuHVqTRrBvi3IbB
         V4tF2iGY8aXEysRUXdKTfndPfQUK4AsunlFTyRK+Ol63Ekb2s9E0CMH6DQp/kAWnZ2xN
         SBmMxHXKiaeY6/5Bp1EDesf8OQO2q4GHWbCPUu8GmmXTMYGLSwUrdTRDNkILGJDQzsCo
         qGbjqDLjXmYLzrH3SqePDiHyjY4VE/h8csqXL9qd2pfOoaTslPZp7zn9kIkt3zRGzlXL
         3iSLNyxF/BlAmndeRR55KVRkAyQg8mssMuVVMUkeOJqgUQtsmk2HTF+KqS+3RMe7nbWN
         50VQ==
X-Gm-Message-State: APjAAAVSVr4lorw4QwUW3yQcriMqwR8rSJMcYdQDHBfrVof2sn1luFxR
        Gj3eMnhbq4Hg0K6kQoXwTVqgQ+A=
X-Google-Smtp-Source: APXvYqxmTzy3YuPQkWeaE0CmmZxOKP80fQR7laoVc4UNiUFkLCelogxS6U6Gt7GHHvKP+oZQlFqZGw==
X-Received: by 2002:a05:6638:cf:: with SMTP id w15mr12146868jao.136.1565206573252;
        Wed, 07 Aug 2019 12:36:13 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id l26sm5361365ioj.24.2019.08.07.12.36.12
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 07 Aug 2019 12:36:12 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH] NFSv4: Ensure state recovery handles ETIMEDOUT correctly
Date:   Wed,  7 Aug 2019 15:34:04 -0400
Message-Id: <20190807193404.123590-1-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Ensure that the state recovery code handles ETIMEDOUT correctly,
and also that we set RPC_TASK_TIMEOUT when recovering open state.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4proc.c  | 2 ++
 fs/nfs/nfs4state.c | 7 +++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 12b2b65ad8a8..1406858bae6c 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -2179,6 +2179,7 @@ static int nfs4_handle_delegation_recall_error(struct nfs_server *server, struct
 		case -ENOENT:
 		case -EAGAIN:
 		case -ESTALE:
+		case -ETIMEDOUT:
 			break;
 		case -NFS4ERR_BADSESSION:
 		case -NFS4ERR_BADSLOT:
@@ -2499,6 +2500,7 @@ static int nfs4_run_open_task(struct nfs4_opendata *data,
 	if (!ctx) {
 		nfs4_init_sequence(&o_arg->seq_args, &o_res->seq_res, 1, 1);
 		data->is_recover = true;
+		task_setup_data.flags |= RPC_TASK_TIMEOUT;
 	} else {
 		nfs4_init_sequence(&o_arg->seq_args, &o_res->seq_res, 1, 0);
 		pnfs_lgopen_prepare(data, ctx);
diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index a4e866b2b43b..cad4e064b328 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -1529,6 +1529,7 @@ static int nfs4_reclaim_locks(struct nfs4_state *state, const struct nfs4_state_
 		switch (status) {
 		case 0:
 			break;
+		case -ETIMEDOUT:
 		case -ESTALE:
 		case -NFS4ERR_ADMIN_REVOKED:
 		case -NFS4ERR_STALE_STATEID:
@@ -1682,11 +1683,13 @@ static int nfs4_reclaim_open_state(struct nfs4_state_owner *sp, const struct nfs
 		case -NFS4ERR_EXPIRED:
 		case -NFS4ERR_NO_GRACE:
 			nfs4_state_mark_reclaim_nograce(sp->so_server->nfs_client, state);
+			/* Fall through */
 		case -NFS4ERR_STALE_CLIENTID:
 		case -NFS4ERR_BADSESSION:
 		case -NFS4ERR_BADSLOT:
 		case -NFS4ERR_BAD_HIGH_SLOT:
 		case -NFS4ERR_CONN_NOT_BOUND_TO_SESSION:
+		case -ETIMEDOUT:
 			goto out_err;
 		}
 		nfs4_put_open_state(state);
@@ -1971,7 +1974,6 @@ static int nfs4_handle_reclaim_lease_error(struct nfs_client *clp, int status)
 		return -EPERM;
 	case -EACCES:
 	case -NFS4ERR_DELAY:
-	case -ETIMEDOUT:
 	case -EAGAIN:
 		ssleep(1);
 		break;
@@ -2600,7 +2602,7 @@ static void nfs4_state_manager(struct nfs_client *clp)
 		}
 
 		/* Now recover expired state... */
-		if (test_and_clear_bit(NFS4CLNT_RECLAIM_NOGRACE, &clp->cl_state)) {
+		if (test_bit(NFS4CLNT_RECLAIM_NOGRACE, &clp->cl_state)) {
 			section = "reclaim nograce";
 			status = nfs4_do_reclaim(clp,
 				clp->cl_mvops->nograce_recovery_ops);
@@ -2608,6 +2610,7 @@ static void nfs4_state_manager(struct nfs_client *clp)
 				continue;
 			if (status < 0)
 				goto out_error;
+			clear_bit(NFS4CLNT_RECLAIM_NOGRACE, &clp->cl_state);
 		}
 
 		nfs4_end_drain_session(clp);
-- 
2.21.0

