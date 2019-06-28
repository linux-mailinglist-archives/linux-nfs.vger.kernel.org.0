Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A84BC59B94
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Jun 2019 14:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbfF1MhC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 28 Jun 2019 08:37:02 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:41663 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726687AbfF1MhC (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 28 Jun 2019 08:37:02 -0400
Received: from theinternet.molgen.mpg.de (theinternet.molgen.mpg.de [141.14.31.7])
        by mx.molgen.mpg.de (Postfix) with ESMTP id C148320669589;
        Fri, 28 Jun 2019 14:37:00 +0200 (CEST)
From:   Donald Buczek <buczek@molgen.mpg.de>
To:     linux-nfs@vger.kernel.org, trond.myklebust@hammerspace.com,
        anna.schumaker@netapp.com
Cc:     Donald Buczek <buczek@molgen.mpg.de>
Subject: [PATCH 2/4 RESEND] nfs4: Rename nfs41_setup_state_renewal
Date:   Fri, 28 Jun 2019 14:36:38 +0200
Message-Id: <20190628123640.8715-3-buczek@molgen.mpg.de>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190628123640.8715-1-buczek@molgen.mpg.de>
References: <20190628123640.8715-1-buczek@molgen.mpg.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The function nfs41_setup_state_renewal is useful to the nfs 4.0 client
as well, so rename the function to nfs4_setup_state_renewal.

Signed-off-by: Donald Buczek <buczek@molgen.mpg.de>
---
 fs/nfs/nfs4state.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index e2e3c4f04d3e..778ebfb00d13 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -286,7 +286,7 @@ static int nfs4_begin_drain_session(struct nfs_client *clp)
 
 #if defined(CONFIG_NFS_V4_1)
 
-static int nfs41_setup_state_renewal(struct nfs_client *clp)
+static int nfs4_setup_state_renewal(struct nfs_client *clp)
 {
 	int status;
 	struct nfs_fsinfo fsinfo;
@@ -313,7 +313,7 @@ static void nfs41_finish_session_reset(struct nfs_client *clp)
 	clear_bit(NFS4CLNT_SESSION_RESET, &clp->cl_state);
 	/* create_session negotiated new slot table */
 	clear_bit(NFS4CLNT_BIND_CONN_TO_SESSION, &clp->cl_state);
-	nfs41_setup_state_renewal(clp);
+	nfs4_setup_state_renewal(clp);
 }
 
 int nfs41_init_clientid(struct nfs_client *clp, const struct cred *cred)
-- 
2.22.0

