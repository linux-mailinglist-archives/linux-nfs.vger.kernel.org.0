Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C47FC2E9CB
	for <lists+linux-nfs@lfdr.de>; Thu, 30 May 2019 02:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbfE3Anz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 29 May 2019 20:43:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:46562 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726527AbfE3Anz (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 29 May 2019 20:43:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2D744AC4F;
        Thu, 30 May 2019 00:43:54 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Olga Kornievskaia <aglo@umich.edu>,
        Chuck Lever <chuck.lever@oracle.com>,
        Schumaker Anna <Anna.Schumaker@netapp.com>,
        Trond Myklebust <trondmy@hammerspace.com>
Date:   Thu, 30 May 2019 10:41:28 +1000
Subject: [PATCH 8/9] pNFS: Allow multiple connections to the DS
Cc:     linux-nfs@vger.kernel.org
Message-ID: <155917688885.3988.14415976491019492843.stgit@noble.brown>
In-Reply-To: <155917564898.3988.6096672032831115016.stgit@noble.brown>
References: <155917564898.3988.6096672032831115016.stgit@noble.brown>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@primarydata.com>

If the user specifies -onconnect=<number> mount option, then set up
<number> connections to the pNFS data server as well. The connections
will all go to the same IP address.

Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: NeilBrown <neilb@suse.com>
---
 fs/nfs/nfs3client.c |    1 +
 fs/nfs/nfs4client.c |    3 +++
 2 files changed, 4 insertions(+)

diff --git a/fs/nfs/nfs3client.c b/fs/nfs/nfs3client.c
index fb0c425b5d45..c6987077ad15 100644
--- a/fs/nfs/nfs3client.c
+++ b/fs/nfs/nfs3client.c
@@ -93,6 +93,7 @@ struct nfs_client *nfs3_set_ds_client(struct nfs_server *mds_srv,
 		.net = mds_clp->cl_net,
 		.timeparms = &ds_timeout,
 		.cred = mds_srv->cred,
+		.nconnect = mds_clp->cl_nconnect,
 	};
 	struct nfs_client *clp;
 	char buf[INET6_ADDRSTRLEN + 1];
diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index 401a76290e55..0b15ee54b13c 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -943,6 +943,9 @@ struct nfs_client *nfs4_set_ds_client(struct nfs_server *mds_srv,
 		return ERR_PTR(-EINVAL);
 	cl_init.hostname = buf;
 
+	if (mds_clp->cl_nconnect > 1)
+		cl_init.nconnect = mds_clp->cl_nconnect;
+
 	if (mds_srv->flags & NFS_MOUNT_NORESVPORT)
 		__set_bit(NFS_CS_NORESVPORT, &cl_init.init_flags);
 


