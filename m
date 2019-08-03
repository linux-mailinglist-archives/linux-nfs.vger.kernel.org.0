Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 295CB806E1
	for <lists+linux-nfs@lfdr.de>; Sat,  3 Aug 2019 17:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbfHCPAg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 3 Aug 2019 11:00:36 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:36125 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727535AbfHCPAf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 3 Aug 2019 11:00:35 -0400
Received: by mail-io1-f66.google.com with SMTP id o9so55101081iom.3
        for <linux-nfs@vger.kernel.org>; Sat, 03 Aug 2019 08:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=4/7a3f+prLAMWa+GJyh21FglLHfc4906imLer/C8sQI=;
        b=L6AtQBOaWTeSGGaZDpD6Sil6ypc0+BeSa1p+k3xxlwppIVa+L4E0cOobz8zCNvvvce
         8ITheNqLwboJjDGbO3KrZ5Qf/E9PIMmo/hIzLeNFBHjtOed1GI3gYOAOQpIeVkayZ3iC
         MTCqAqGKA3MLvS+sO7iMPYDTkgsKqmSqPedA4RjKvlxLakHlorqhPd/FcpBpA8DrRQyk
         Ep9phSa42rwAaSVcavHIpwcrQXDEeL6ZIROJQZPoZy7KaVUHXtJkV+lXqSoJzJ8rYoOD
         /4JdbEOfVvRWv68sX/Zb+ee70o7Bhawrdv6NSMmkBdH/EveMz43/D9f1EcHeDepYMNZl
         KGSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4/7a3f+prLAMWa+GJyh21FglLHfc4906imLer/C8sQI=;
        b=Jk9qEc1TKcSKLaVocKfT/0eIvdB+ZgIcVdNme9WZ0qw5nYTZddt8IbBsyNVp2w6EB3
         Ussd65EIG0URCIfVJQUHnNNsY+sHqbst64SmJ1QODFQ6mwN/RCFh3RXh9/M4hkiCGTwC
         /lcMSdS0e0HdnqmxvBFy0/Ev5NFQpWcQE7soEmllS6sWKuNOBxdisMxAVD6GrGAtZl62
         rCI7/uOfVt4ZacDn2+H+3Rd0if7H1hTXpMfiSxuruf2UXbvY3B4rDmNnswB57E3sE65g
         kaWPKwSpnZBmFa132HymvqAcH0kV+jVSi5bucqol/GhZevkvDnJtxYht5Dnk0MEIT0Ef
         NzhQ==
X-Gm-Message-State: APjAAAUF+YrefQZkPlJQ3B1eXOX0Upe3zbt4WVKD+OP5l2vMp5nkkqCu
        dvasOIwoHpfJncZUyfHRQjaySyo=
X-Google-Smtp-Source: APXvYqwmFjsZM/lcGNOSLBCk9xh7wqrENCfKgS2oV1PmCpTLX3AjT1TH924Jz0I0FooUQ4mo/bz5ZA==
X-Received: by 2002:a02:5a02:: with SMTP id v2mr15231216jaa.124.1564844434553;
        Sat, 03 Aug 2019 08:00:34 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id f20sm60820416ioh.17.2019.08.03.08.00.33
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 03 Aug 2019 08:00:34 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/8] NFSv4: Fix delegation state recovery
Date:   Sat,  3 Aug 2019 10:58:20 -0400
Message-Id: <20190803145826.15504-2-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190803145826.15504-1-trond.myklebust@hammerspace.com>
References: <20190803145826.15504-1-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Once we clear the NFS_DELEGATED_STATE flag, we're telling
nfs_delegation_claim_opens() that we're done recovering all open state
for that stateid, so we really need to ensure that we test for all
open modes that are currently cached and recover them before exiting
nfs4_open_delegation_recall().

Fixes: 24311f884189d ("NFSv4: Recovery of recalled read delegations...")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Cc: stable@vger.kernel.org # v4.3+
---
 fs/nfs/delegation.c |  2 +-
 fs/nfs/delegation.h |  2 +-
 fs/nfs/nfs4proc.c   | 25 ++++++++++++-------------
 3 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index 0ff3facf81da..0af854cce8ff 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -153,7 +153,7 @@ static int nfs_delegation_claim_opens(struct inode *inode,
 		/* Block nfs4_proc_unlck */
 		mutex_lock(&sp->so_delegreturn_mutex);
 		seq = raw_seqcount_begin(&sp->so_reclaim_seqcount);
-		err = nfs4_open_delegation_recall(ctx, state, stateid, type);
+		err = nfs4_open_delegation_recall(ctx, state, stateid);
 		if (!err)
 			err = nfs_delegation_claim_locks(state, stateid);
 		if (!err && read_seqcount_retry(&sp->so_reclaim_seqcount, seq))
diff --git a/fs/nfs/delegation.h b/fs/nfs/delegation.h
index 5799777df5ec..9eb87ae4c982 100644
--- a/fs/nfs/delegation.h
+++ b/fs/nfs/delegation.h
@@ -63,7 +63,7 @@ void nfs_reap_expired_delegations(struct nfs_client *clp);
 
 /* NFSv4 delegation-related procedures */
 int nfs4_proc_delegreturn(struct inode *inode, const struct cred *cred, const nfs4_stateid *stateid, int issync);
-int nfs4_open_delegation_recall(struct nfs_open_context *ctx, struct nfs4_state *state, const nfs4_stateid *stateid, fmode_t type);
+int nfs4_open_delegation_recall(struct nfs_open_context *ctx, struct nfs4_state *state, const nfs4_stateid *stateid);
 int nfs4_lock_delegation_recall(struct file_lock *fl, struct nfs4_state *state, const nfs4_stateid *stateid);
 bool nfs4_copy_delegation_stateid(struct inode *inode, fmode_t flags, nfs4_stateid *dst, const struct cred **cred);
 bool nfs4_refresh_delegation_stateid(nfs4_stateid *dst, struct inode *inode);
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index a6d73609b163..21e3c159bc69 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -2177,12 +2177,10 @@ static int nfs4_handle_delegation_recall_error(struct nfs_server *server, struct
 		case -NFS4ERR_BAD_HIGH_SLOT:
 		case -NFS4ERR_CONN_NOT_BOUND_TO_SESSION:
 		case -NFS4ERR_DEADSESSION:
-			set_bit(NFS_DELEGATED_STATE, &state->flags);
 			nfs4_schedule_session_recovery(server->nfs_client->cl_session, err);
 			return -EAGAIN;
 		case -NFS4ERR_STALE_CLIENTID:
 		case -NFS4ERR_STALE_STATEID:
-			set_bit(NFS_DELEGATED_STATE, &state->flags);
 			/* Don't recall a delegation if it was lost */
 			nfs4_schedule_lease_recovery(server->nfs_client);
 			return -EAGAIN;
@@ -2203,7 +2201,6 @@ static int nfs4_handle_delegation_recall_error(struct nfs_server *server, struct
 			return -EAGAIN;
 		case -NFS4ERR_DELAY:
 		case -NFS4ERR_GRACE:
-			set_bit(NFS_DELEGATED_STATE, &state->flags);
 			ssleep(1);
 			return -EAGAIN;
 		case -ENOMEM:
@@ -2219,8 +2216,7 @@ static int nfs4_handle_delegation_recall_error(struct nfs_server *server, struct
 }
 
 int nfs4_open_delegation_recall(struct nfs_open_context *ctx,
-		struct nfs4_state *state, const nfs4_stateid *stateid,
-		fmode_t type)
+		struct nfs4_state *state, const nfs4_stateid *stateid)
 {
 	struct nfs_server *server = NFS_SERVER(state->inode);
 	struct nfs4_opendata *opendata;
@@ -2231,20 +2227,23 @@ int nfs4_open_delegation_recall(struct nfs_open_context *ctx,
 	if (IS_ERR(opendata))
 		return PTR_ERR(opendata);
 	nfs4_stateid_copy(&opendata->o_arg.u.delegation, stateid);
-	nfs_state_clear_delegation(state);
-	switch (type & (FMODE_READ|FMODE_WRITE)) {
-	case FMODE_READ|FMODE_WRITE:
-	case FMODE_WRITE:
+	if (!test_bit(NFS_O_RDWR_STATE, &state->flags)) {
 		err = nfs4_open_recover_helper(opendata, FMODE_READ|FMODE_WRITE);
 		if (err)
-			break;
+			goto out;
+	}
+	if (!test_bit(NFS_O_WRONLY_STATE, &state->flags)) {
 		err = nfs4_open_recover_helper(opendata, FMODE_WRITE);
 		if (err)
-			break;
-		/* Fall through */
-	case FMODE_READ:
+			goto out;
+	}
+	if (!test_bit(NFS_O_RDONLY_STATE, &state->flags)) {
 		err = nfs4_open_recover_helper(opendata, FMODE_READ);
+		if (err)
+			goto out;
 	}
+	nfs_state_clear_delegation(state);
+out:
 	nfs4_opendata_put(opendata);
 	return nfs4_handle_delegation_recall_error(server, state, stateid, NULL, err);
 }
-- 
2.21.0

