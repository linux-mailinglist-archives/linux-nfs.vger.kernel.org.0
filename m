Return-Path: <linux-nfs+bounces-4105-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D7290F7A9
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 22:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2E18B20E29
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 20:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A06F15887D;
	Wed, 19 Jun 2024 20:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CikX84vP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3461015AD9B
	for <linux-nfs@vger.kernel.org>; Wed, 19 Jun 2024 20:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718829656; cv=none; b=IKnd7VV2GE9E/tDGmQoeJ1zCUI7XMJmf4kvbxEKDI+Z7xv+YoqAqgTKytDQQTr/NgT0YobLU4ZHf9g0p+8zPymNKeyL1hMum+kdmb5cb31NzGOJPZSk69YK6CRtgWvjDREBe49NjB5HyIjewrVDQHQNb0Vx3fXRIQqALqdrrAok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718829656; c=relaxed/simple;
	bh=lxzbMhKYRZATNw8ywVTSkIIWcVijjsHid8KubD5cxN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QsX9a1vadm7WhV8wviyRjUelMSYGIiyHKSdzS/aLhWKeG0ehkFlhzpF7zDNAiWbMrJATY9QuCSUPA8hqC9SDviwdHAwOGJ41If11C9DWW5Sjmt9WxpagGSPvifpx6RcEMAfM7bt0M634kaYQzLJrgUOuWWfn1YhlIqKgNqsSW5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CikX84vP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C0ADC2BBFC;
	Wed, 19 Jun 2024 20:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718829655;
	bh=lxzbMhKYRZATNw8ywVTSkIIWcVijjsHid8KubD5cxN8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CikX84vPu4gDHPKuDRLp1uaH9/OUjR8DGDAWPQmsf+JKq4KmUlWluYH9gwt/yosnS
	 vkKvNXU3ogIWp2mdFzdE0t4klLMtT14pS7lj+DTZNAXMNwNmIwjpdWPbo7kwpYwEKe
	 WSvC38UUKsD8DXVukf+dGInRxlfkBH1raSn/XcR5j4k8tavo8O4xXVMygPVdePqD9v
	 cPfy2c3cjpSRtaBIV7SBcAtLlS4UXh26HG0cW2YXxlo7kzicAsCT46Eq5LDA1Okpg0
	 kVsTem1DAMiNQrVXF3bw6WR+tC40Qo4QzZTOKoP4oNuyJAK7ssFUHo/OPAhX0YZDxW
	 vv47nGOlcDX4Q==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	snitzer@hammerspace.com
Subject: [PATCH v6 16/18] nfsd/localio: use SRCU to dereference nn->nfsd_serv in nfsd_open_local_fh
Date: Wed, 19 Jun 2024 16:40:30 -0400
Message-ID: <20240619204032.93740-17-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240619204032.93740-1-snitzer@kernel.org>
References: <20240619204032.93740-1-snitzer@kernel.org>
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
index 4d4ff622133c..e6d18c9ab09a 100644
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


