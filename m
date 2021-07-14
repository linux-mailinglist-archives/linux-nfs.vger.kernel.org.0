Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01E193C87FC
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Jul 2021 17:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239674AbhGNPxQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 14 Jul 2021 11:53:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:41136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239625AbhGNPxQ (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 14 Jul 2021 11:53:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 546F9613BE
        for <linux-nfs@vger.kernel.org>; Wed, 14 Jul 2021 15:50:24 +0000 (UTC)
Subject: [PATCH RFC 2/4] NFS: Unset RPC_TASK_NO_RETRANS_TIMEOUT for
 session/clientid destruction
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Wed, 14 Jul 2021 11:50:23 -0400
Message-ID: <162627782362.1294.9395366920293772038.stgit@manet.1015granger.net>
In-Reply-To: <162627611661.1294.9189768423517916152.stgit@manet.1015granger.net>
References: <162627611661.1294.9189768423517916152.stgit@manet.1015granger.net>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

In some rare failure modes, the server is actually reading the
transport, but then just dropping the requests on the floor.
TCP_USER_TIMEOUT cannot detect that case.

Prevent such a stuck server from pinning client resources
indefinitely by ensuring that session and client ID clean-up can
time out even if the connection is still operational.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfs/nfs4client.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index 28431acd1230..c5032f784ac0 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -281,6 +281,7 @@ static void nfs4_destroy_callback(struct nfs_client *clp)
 
 static void nfs4_shutdown_client(struct nfs_client *clp)
 {
+	clp->cl_rpcclient->cl_noretranstimeo = 0;
 	if (__test_and_clear_bit(NFS_CS_RENEWD, &clp->cl_res_state))
 		nfs4_kill_renewd(clp);
 	clp->cl_mvops->shutdown_client(clp);


