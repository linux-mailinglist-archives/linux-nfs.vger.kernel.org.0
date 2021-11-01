Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFA9F442165
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Nov 2021 21:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbhKAUJJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 1 Nov 2021 16:09:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37162 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231841AbhKAUJE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 1 Nov 2021 16:09:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635797189;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qJI1fle+vwsCYk5yYYXlG4Eitv0/an8jcCkqX4HLF6w=;
        b=Ihu7mm07cbhK94NNDnq/zsjeHag55gGRrmo8VAh25WlJU9gqn5kYbIJ9TZRVbVsHuagHXc
        ByhCKakdqaevveqzC5+mZUDcKy7l2OEzaBhNqjks0bKpnLP3uY6de1zOc05eFn5ih+AAJF
        6khO7IB8A9m9wJDp0M6jTyVggYSaz1g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-vp53YDTOO2KgwUNB9Z1wog-1; Mon, 01 Nov 2021 16:06:26 -0400
X-MC-Unique: vp53YDTOO2KgwUNB9Z1wog-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B6B3180668B;
        Mon,  1 Nov 2021 20:06:25 +0000 (UTC)
Received: from aion.usersys.redhat.com (unknown [10.22.9.39])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C6D5A5D9D3;
        Mon,  1 Nov 2021 20:06:24 +0000 (UTC)
Received: by aion.usersys.redhat.com (Postfix, from userid 1000)
        id 8814B1A0023; Mon,  1 Nov 2021 16:06:23 -0400 (EDT)
From:   Scott Mayhew <smayhew@redhat.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] nfs4: take a reference on the nfs_client when running FREE_STATEID
Date:   Mon,  1 Nov 2021 16:06:23 -0400
Message-Id: <20211101200623.2635785-2-smayhew@redhat.com>
In-Reply-To: <20211101200623.2635785-1-smayhew@redhat.com>
References: <20211101200623.2635785-1-smayhew@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

During umount, the session slot tables are freed.  If there are
outstanding FREE_STATEID tasks, a use-after-free and slab corruption can
occur when rpc_exit_task calls rpc_call_done -> nfs41_sequence_done ->
nfs4_sequence_process/nfs41_sequence_free_slot.

Prevent that from happening by taking a reference on the nfs_client in
nfs41_free_stateid and putting it in nfs41_free_stateid_release.

Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 fs/nfs/nfs4proc.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index e1214bb6b7ee..76e6786b797e 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -10145,18 +10145,24 @@ static void nfs41_free_stateid_prepare(struct rpc_task *task, void *calldata)
 static void nfs41_free_stateid_done(struct rpc_task *task, void *calldata)
 {
 	struct nfs_free_stateid_data *data = calldata;
+	struct nfs_client *clp = data->server->nfs_client;
 
 	nfs41_sequence_done(task, &data->res.seq_res);
 
 	switch (task->tk_status) {
 	case -NFS4ERR_DELAY:
 		if (nfs4_async_handle_error(task, data->server, NULL, NULL) == -EAGAIN)
-			rpc_restart_call_prepare(task);
+			if (refcount_read(&clp->cl_count) > 1)
+				rpc_restart_call_prepare(task);
 	}
 }
 
 static void nfs41_free_stateid_release(void *calldata)
 {
+	struct nfs_free_stateid_data *data = calldata;
+	struct nfs_client *clp = data->server->nfs_client;
+
+	nfs_put_client(clp);
 	kfree(calldata);
 }
 
@@ -10193,6 +10199,10 @@ static int nfs41_free_stateid(struct nfs_server *server,
 	};
 	struct nfs_free_stateid_data *data;
 	struct rpc_task *task;
+	struct nfs_client *clp = server->nfs_client;
+
+	if (!refcount_inc_not_zero(&clp->cl_count))
+		return -EIO;
 
 	nfs4_state_protect(server->nfs_client, NFS_SP4_MACH_CRED_STATEID,
 		&task_setup.rpc_client, &msg);
-- 
2.31.1

