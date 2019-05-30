Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 486272E9CC
	for <lists+linux-nfs@lfdr.de>; Thu, 30 May 2019 02:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbfE3AoB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 29 May 2019 20:44:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:46576 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726527AbfE3AoB (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 29 May 2019 20:44:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 90A99AC2C;
        Thu, 30 May 2019 00:44:00 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Olga Kornievskaia <aglo@umich.edu>,
        Chuck Lever <chuck.lever@oracle.com>,
        Schumaker Anna <Anna.Schumaker@netapp.com>,
        Trond Myklebust <trondmy@hammerspace.com>
Date:   Thu, 30 May 2019 10:41:28 +1000
Subject: [PATCH 9/9] NFS: Allow multiple connections to a NFSv2 or NFSv3
 server
Cc:     linux-nfs@vger.kernel.org
Message-ID: <155917688890.3988.6853021482514542804.stgit@noble.brown>
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

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: NeilBrown <neilb@suse.com>
---
 fs/nfs/client.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 9005643b0db4..c99bab2a6cb0 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -664,6 +664,7 @@ static int nfs_init_server(struct nfs_server *server,
 		.net = data->net,
 		.timeparms = &timeparms,
 		.cred = server->cred,
+		.nconnect = data->nfs_server.nconnect,
 	};
 	struct nfs_client *clp;
 	int error;


