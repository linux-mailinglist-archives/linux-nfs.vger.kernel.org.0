Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D71431F4A0F
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jun 2020 01:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbgFIXXC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 9 Jun 2020 19:23:02 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38214 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgFIXXB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 9 Jun 2020 19:23:01 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1jina5-0005EV-L6; Tue, 09 Jun 2020 23:22:57 +0000
From:   Colin King <colin.king@canonical.com>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] NFS: remove redundant pointer clnt
Date:   Wed, 10 Jun 2020 00:22:57 +0100
Message-Id: <20200609232257.1118354-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.27.0.rc0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The pointer clnt is being initialized with a value that is never
read and so this is assignment redundant and can be removed. The
pointer can removed because it is being used as a temporary
variable and it is clearer to make the direct assignment and remove
it completely.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/nfs/nfs4proc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index e32717fd1169..7a56e2ab473b 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -9518,7 +9518,6 @@ _nfs41_proc_secinfo_no_name(struct nfs_server *server, struct nfs_fh *fhandle,
 		.rpc_argp = &args,
 		.rpc_resp = &res,
 	};
-	struct rpc_clnt *clnt = server->client;
 	struct nfs4_call_sync_data data = {
 		.seq_server = server,
 		.seq_args = &args.seq_args,
@@ -9535,8 +9534,7 @@ _nfs41_proc_secinfo_no_name(struct nfs_server *server, struct nfs_fh *fhandle,
 	int status;
 
 	if (use_integrity) {
-		clnt = server->nfs_client->cl_rpcclient;
-		task_setup.rpc_client = clnt;
+		task_setup.rpc_client = server->nfs_client->cl_rpcclient;
 
 		cred = nfs4_get_clid_cred(server->nfs_client);
 		msg.rpc_cred = cred;
-- 
2.27.0.rc0

