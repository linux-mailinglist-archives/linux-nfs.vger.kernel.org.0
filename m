Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80696696E04
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Feb 2023 20:40:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjBNTj6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 Feb 2023 14:39:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232201AbjBNTj6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 Feb 2023 14:39:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1645D2BEF2
        for <linux-nfs@vger.kernel.org>; Tue, 14 Feb 2023 11:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676403554;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=LwG82JIAB6lnnNQYdrwj6ITkAKxBLBUjZn2ENbqC5FU=;
        b=R7TqGCyTDMZjcrQP1y87NMK/xMRi31/hQ2UYsZNftnB7xKweSPnH2LxClKkcmIgYho20Af
        AQDROztTkSU52wjWDk/yyQoRYD5UcVOg3ZYBJVscv6TpYkuYc0NMuu6VA5jri4tJ7F1y+u
        TcOjHk96jYZ0pWr3BMnkYDAPDv4Ap0Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-114-hgkmWqfTOhyzpnr7Xk9KhA-1; Tue, 14 Feb 2023 14:39:12 -0500
X-MC-Unique: hgkmWqfTOhyzpnr7Xk9KhA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4519980006E;
        Tue, 14 Feb 2023 19:39:12 +0000 (UTC)
Received: from bcodding.csb (unknown [10.22.50.5])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 14DEBC15BA0;
        Tue, 14 Feb 2023 19:39:12 +0000 (UTC)
Received: by bcodding.csb (Postfix, from userid 24008)
        id A7FCB10C30F0; Tue, 14 Feb 2023 14:39:11 -0500 (EST)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] NFSv4: Ensure we revalidate data after OPEN expired
Date:   Tue, 14 Feb 2023 14:39:11 -0500
Message-Id: <7e97897a29878a56236ef8e15bce7a295d5e8a41.1676403514.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

We've observed that if the NFS client experiences a network partition and
the server revokes the client's state, the client may not revalidate cached
data for an open file during recovery.  If the file is extended by a second
client during this network partition, the first client will correctly
update the file's size and attributes during recovery, but another
extending write will discard the second client's data.

In the case where another client opened the file during the network
partition and the server revoked the first client's state, the recovery can
forego optimizations and instead attempt to avoid corruption.

It's a little tricky to solve this in a per-file way during recovery
without plumbing arguments or introducing new flags.  This patch side-steps
the per-file complexity by simply checking if the client is within a
NOGRACE recovery window, and if so, invalidates data during the open
recovery.

Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 fs/nfs/nfs4proc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 40d749f29ed3..b9e1e817a723 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -2604,7 +2604,9 @@ static int nfs4_run_open_task(struct nfs4_opendata *data,
 
 static int _nfs4_recover_proc_open(struct nfs4_opendata *data)
 {
+	struct inode *inode = d_inode(data->dentry);
 	struct inode *dir = d_inode(data->dir);
+	struct nfs_openargs *o_arg = &data->o_arg;
 	struct nfs_openres *o_res = &data->o_res;
 	int status;
 
@@ -2614,6 +2616,12 @@ static int _nfs4_recover_proc_open(struct nfs4_opendata *data)
 
 	nfs_fattr_map_and_free_names(NFS_SERVER(dir), &data->f_attr);
 
+	if (test_bit(NFS4CLNT_RECLAIM_NOGRACE, &o_arg->server->nfs_client->cl_state)) {
+		spin_lock(&inode->i_lock);
+		nfs_set_cache_invalid(inode, NFS_INO_INVALID_DATA);
+		spin_unlock(&inode->i_lock);
+	}
+
 	if (o_res->rflags & NFS4_OPEN_RESULT_CONFIRM)
 		status = _nfs4_proc_open_confirm(data);
 
-- 
2.31.1

