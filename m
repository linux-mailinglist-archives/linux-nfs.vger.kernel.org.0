Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7125443FF0
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Nov 2021 11:24:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231975AbhKCK10 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 3 Nov 2021 06:27:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38946 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231278AbhKCK1Y (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 3 Nov 2021 06:27:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635935087;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=P+ZN9d+kbNs/6O8sify2AGpKijUnl3IekSXvON1YhpI=;
        b=VfIFwA2U3nBSyUjCbbqdG7aPcyV9wwQBTHnX23jQnNl5DHw2+X+W1++oM2uBzK53H0i2/Q
        xSSh+cVwQQ5YPcvWFp8glAwCY4OSX36LbQ/poAQ/dw6NEauF99cpr4vQ18RolaEQWU+rNc
        28D3c76CKpBBH5RpnwLzgtkzoeHEO68=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-nnv7ljGkOIqq0yqtA4voFg-1; Wed, 03 Nov 2021 06:24:44 -0400
X-MC-Unique: nnv7ljGkOIqq0yqtA4voFg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 533D18042E1;
        Wed,  3 Nov 2021 10:24:41 +0000 (UTC)
Received: from aion.usersys.redhat.com (unknown [10.22.9.39])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 181CE60BF1;
        Wed,  3 Nov 2021 10:24:40 +0000 (UTC)
Received: by aion.usersys.redhat.com (Postfix, from userid 1000)
        id 1E3F91A0024; Wed,  3 Nov 2021 06:24:40 -0400 (EDT)
From:   Scott Mayhew <smayhew@redhat.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2] nfs4: take a reference on the nfs_client when running FREE_STATEID
Date:   Wed,  3 Nov 2021 06:24:40 -0400
Message-Id: <20211103102440.2878337-1-smayhew@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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
 fs/nfs/nfs4proc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index e1214bb6b7ee..90f944174c5c 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -10157,6 +10157,10 @@ static void nfs41_free_stateid_done(struct rpc_task *task, void *calldata)
 
 static void nfs41_free_stateid_release(void *calldata)
 {
+	struct nfs_free_stateid_data *data = calldata;
+	struct nfs_client *clp = data->server->nfs_client;
+
+	nfs_put_client(clp);
 	kfree(calldata);
 }
 
@@ -10193,6 +10197,10 @@ static int nfs41_free_stateid(struct nfs_server *server,
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

