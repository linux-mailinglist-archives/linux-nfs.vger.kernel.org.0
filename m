Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE3A759B95
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Jun 2019 14:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbfF1MhD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 28 Jun 2019 08:37:03 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:36345 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726696AbfF1MhD (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 28 Jun 2019 08:37:03 -0400
Received: from theinternet.molgen.mpg.de (theinternet.molgen.mpg.de [141.14.31.7])
        by mx.molgen.mpg.de (Postfix) with ESMTP id DCA1020669590;
        Fri, 28 Jun 2019 14:37:01 +0200 (CEST)
From:   Donald Buczek <buczek@molgen.mpg.de>
To:     linux-nfs@vger.kernel.org, trond.myklebust@hammerspace.com,
        anna.schumaker@netapp.com
Cc:     Donald Buczek <buczek@molgen.mpg.de>
Subject: [PATCH 4/4 RESEND] nfs4.0: Refetch lease_time after clientid update
Date:   Fri, 28 Jun 2019 14:36:40 +0200
Message-Id: <20190628123640.8715-5-buczek@molgen.mpg.de>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190628123640.8715-1-buczek@molgen.mpg.de>
References: <20190628123640.8715-1-buczek@molgen.mpg.de>
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

Let nfs4_init_clientid, which is used for 4.0 clients, call
nfs4_setup_state_renewal as well.

Signed-off-by: Donald Buczek <buczek@molgen.mpg.de>
---
 fs/nfs/nfs4state.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index c2df257f426f..f32b02c2bc73 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -135,7 +135,7 @@ int nfs4_init_clientid(struct nfs_client *clp, const struct cred *cred)
 	if (status != 0)
 		goto out;
 	clear_bit(NFS4CLNT_LEASE_CONFIRM, &clp->cl_state);
-	nfs4_schedule_state_renewal(clp);
+	nfs4_setup_state_renewal(clp);
 out:
 	return status;
 }
-- 
2.22.0

