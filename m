Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28CC159B96
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Jun 2019 14:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbfF1MhD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 28 Jun 2019 08:37:03 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:60477 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726578AbfF1MhD (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 28 Jun 2019 08:37:03 -0400
Received: from theinternet.molgen.mpg.de (theinternet.molgen.mpg.de [141.14.31.7])
        by mx.molgen.mpg.de (Postfix) with ESMTP id 5BB3B2066958F;
        Fri, 28 Jun 2019 14:37:01 +0200 (CEST)
From:   Donald Buczek <buczek@molgen.mpg.de>
To:     linux-nfs@vger.kernel.org, trond.myklebust@hammerspace.com,
        anna.schumaker@netapp.com
Cc:     Donald Buczek <buczek@molgen.mpg.de>
Subject: [PATCH 3/4 RESEND] nfs4: Move nfs4_setup_state_renewal
Date:   Fri, 28 Jun 2019 14:36:39 +0200
Message-Id: <20190628123640.8715-4-buczek@molgen.mpg.de>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190628123640.8715-1-buczek@molgen.mpg.de>
References: <20190628123640.8715-1-buczek@molgen.mpg.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The function nfs4_setup_state_renewal is to be used by
nfs4_init_clientid. Move it further to the top of the source file to
include it regardles of CONFIG_NFS_V4_1 and to save a forward
declaration. No code changed.

Signed-off-by: Donald Buczek <buczek@molgen.mpg.de>
---
 fs/nfs/nfs4state.c | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index 778ebfb00d13..c2df257f426f 100644
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

