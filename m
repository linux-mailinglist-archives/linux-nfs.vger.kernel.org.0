Return-Path: <linux-nfs+bounces-3818-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1955D9082A1
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Jun 2024 05:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E488B22C34
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Jun 2024 03:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC921474C0;
	Fri, 14 Jun 2024 03:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GvUrPnwZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386FD1474A3
	for <linux-nfs@vger.kernel.org>; Fri, 14 Jun 2024 03:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718336692; cv=none; b=AwOlCuKon4CrmN6H5CASw+9UGtlXOswqemrJsKj1a80Gvpek7RuPZWt8zrmLriXU4e7b6iW4mD1rnDMxxFFlD1QNIeG+0xZBm/gvXs+8M39OpwyTvnPTvOSDYDaqW3E0swAhb0VLnL60ANwW1PpkpRUPIqVr2+554IHVvQ/Pmng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718336692; c=relaxed/simple;
	bh=FCw8d7u3yE/Yb082AyvJ4nrRXY5ztvkcW1gDSsH/7bI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i3JyC3IMX6Y2nkiOAX7RkTJrHjxpzoT+9a7bDbC05qHQbbUlNgNm4lRYqyS4PFFpJOO/GGyTTWNiO4yXjwWvTBxhDVtLfyI7GJXGdkMK5C8LEZY2pTCdcVXFye+7pBG9p8rSfyhIUexzhROXaV7EvZplRIGakYw9t/JNSkyK9hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GvUrPnwZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9BF1C2BBFC;
	Fri, 14 Jun 2024 03:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718336692;
	bh=FCw8d7u3yE/Yb082AyvJ4nrRXY5ztvkcW1gDSsH/7bI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GvUrPnwZHGyld0Vv90wsNlDv6smoEeXRZ/GxfbJzZ14L9puHoRAScb61GCuBwMmbc
	 fTtDsfhCdxugCts6RIOa1a/SgAG21YLu49DxEesATZtwzMATXgPkxeKoyiqERFPtSj
	 ZGyeseb2pZqnO1NDLa5DxOXGGPulmG+POm7DDLJRjif/tA3jfUe/nWSU9zLfA0+SFm
	 ckvp2nN/ZXm0prkc1J3hAoFmS8SFvgoAg1bqR83WSc+GXffcngBU1nWC04u3vcIDIx
	 OuHc0MXHFU5hOieB0Vx275bR9lBBihwEYnMaPBaGUWylOVVjgE8HxCNCEoPU+lZCkV
	 p3iF9EfKj76ww==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	snitzer@hammerspace.com
Subject: [PATCH v3 18/18] nfsd/localio: use nfsd_serv_get/put in nfsd_open_local_fh
Date: Thu, 13 Jun 2024 23:44:26 -0400
Message-ID: <20240614034426.31043-19-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240614034426.31043-1-snitzer@kernel.org>
References: <20240614034426.31043-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use nfsd_serv_get to SRCU deference nn->nfsd_serv and pass the
resulting svc_serv to nfsd_local_fakerqst_create, open the file handle
and then drop the reference using nfsd_serv_put at the end of
nfsd_open_local_fh.

Verified to fix an easy to hit crash that would occur if an nfsd
instance running in a container, with a localio client mounted, is
shutdown. Upon restart of the container and associated nfsd the client
would go on to crash due to NULL pointer dereference that occuured due
to the nfs client's localio attempting to nfsd_open_local_fh(), using
nn->nfsd_serv, without having a proper reference on nn->nfsd_serv.

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfsd/localio.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
index cdf8e115b33e..d1d9fbaab82e 100644
--- a/fs/nfsd/localio.c
+++ b/fs/nfsd/localio.c
@@ -193,6 +193,7 @@ int nfsd_open_local_fh(struct net *net,
 	struct nfsd_file *nf;
 	int status = 0;
 	int mayflags = NFSD_MAY_LOCALIO;
+	int srcu_idx;
 	struct svc_serv *serv;
 	__be32 beres;
 
@@ -207,7 +208,7 @@ int nfsd_open_local_fh(struct net *net,
 	}
 	nn = net_generic(net, nfsd_net_id);
 
-	serv = READ_ONCE(nn->nfsd_serv);
+	serv = nfsd_serv_get(nn, &srcu_idx);
 	if (unlikely(!serv)) {
 		dprintk("%s: localio denied. Server not running\n", __func__);
 		status = -ENXIO;
@@ -247,6 +248,7 @@ int nfsd_open_local_fh(struct net *net,
 out_revertcred:
 	revert_creds(save_cred);
 out_net:
+	nfsd_serv_put(nn, srcu_idx);
 	put_net(net);
 	return status;
 }
-- 
2.44.0


