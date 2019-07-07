Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D411B6164D
	for <lists+linux-nfs@lfdr.de>; Sun,  7 Jul 2019 21:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbfGGT0b (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 7 Jul 2019 15:26:31 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:48403 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727321AbfGGT0a (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sun, 7 Jul 2019 15:26:30 -0400
Received: from theinternet.molgen.mpg.de (theinternet.molgen.mpg.de [141.14.31.7])
        by mx.molgen.mpg.de (Postfix) with ESMTP id 2362920669598;
        Sun,  7 Jul 2019 21:26:28 +0200 (CEST)
From:   Donald Buczek <buczek@molgen.mpg.de>
To:     linux-nfs@vger.kernel.org, trond.myklebust@hammerspace.com,
        anna.schumaker@netapp.com
Cc:     Donald Buczek <buczek@molgen.mpg.de>
Subject: [PATCH V2 4/4] nfs4.0: Refetch lease_time after clientid update
Date:   Sun,  7 Jul 2019 21:26:10 +0200
Message-Id: <20190707192610.14335-5-buczek@molgen.mpg.de>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190707192610.14335-1-buczek@molgen.mpg.de>
References: <20190707192610.14335-1-buczek@molgen.mpg.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

RFC 7530 requires us to refetch the lease time attribute once a new
clientID is established. This is already implemented for the
nfs4.1(+) clients by nfs41_init_clientid, which calls
nfs41_finish_session_reset, which calls nfs4_setup_state_renewal.

To make nfs4_setup_state_renewal available for nfs4.0, move it
further to the top of the source file to include it regardles of
CONFIG_NFS_V4_1 and to save a forward declaration.

Call nfs4_setup_state_renewal from nfs4_init_clientid.

Signed-off-by: Donald Buczek <buczek@molgen.mpg.de>
---
 fs/nfs/nfs4state.c | 44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index 778ebfb00d13..f32b02c2bc73 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -87,6 +87,27 @@ const nfs4_stateid current_stateid = {
 
 static DEFINE_MUTEX(nfs_clid_init_mutex);
 
+static int nfs4_setup_state_renewal(struct nfs_client *clp)
+{
+	int status;
+	struct nfs_fsinfo fsinfo;
+	unsigned long now;
+
+	if (!test_bit(NFS_CS_CHECK_LEASE_TIME, &clp->cl_res_state)) {
+		nfs4_schedule_state_renewal(clp);
+		return 0;
+	}
+
+	now = jiffies;
+	status = nfs4_proc_get_lease_time(clp, &fsinfo);
+	if (status == 0) {
+		nfs4_set_lease_period(clp, fsinfo.lease_time * HZ, now);
+		nfs4_schedule_state_renewal(clp);
+	}
+
+	return status;
+}
+
 int nfs4_init_clientid(struct nfs_client *clp, const struct cred *cred)
 {
 	struct nfs4_setclientid_res clid = {
@@ -114,7 +135,7 @@ int nfs4_init_clientid(struct nfs_client *clp, const struct cred *cred)
 	if (status != 0)
 		goto out;
 	clear_bit(NFS4CLNT_LEASE_CONFIRM, &clp->cl_state);
-	nfs4_schedule_state_renewal(clp);
+	nfs4_setup_state_renewal(clp);
 out:
 	return status;
 }
@@ -286,27 +307,6 @@ static int nfs4_begin_drain_session(struct nfs_client *clp)
 
 #if defined(CONFIG_NFS_V4_1)
 
-static int nfs4_setup_state_renewal(struct nfs_client *clp)
-{
-	int status;
-	struct nfs_fsinfo fsinfo;
-	unsigned long now;
-
-	if (!test_bit(NFS_CS_CHECK_LEASE_TIME, &clp->cl_res_state)) {
-		nfs4_schedule_state_renewal(clp);
-		return 0;
-	}
-
-	now = jiffies;
-	status = nfs4_proc_get_lease_time(clp, &fsinfo);
-	if (status == 0) {
-		nfs4_set_lease_period(clp, fsinfo.lease_time * HZ, now);
-		nfs4_schedule_state_renewal(clp);
-	}
-
-	return status;
-}
-
 static void nfs41_finish_session_reset(struct nfs_client *clp)
 {
 	clear_bit(NFS4CLNT_LEASE_CONFIRM, &clp->cl_state);
-- 
2.22.0

