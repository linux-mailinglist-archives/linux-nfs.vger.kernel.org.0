Return-Path: <linux-nfs+bounces-4276-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC56B9153C8
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Jun 2024 18:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96D091F24C3E
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Jun 2024 16:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C25613C3DD;
	Mon, 24 Jun 2024 16:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MEi0IoKx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC95C19DF65
	for <linux-nfs@vger.kernel.org>; Mon, 24 Jun 2024 16:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719246488; cv=none; b=czcsRP3Fo4YdecG9zqsFZD1fFN5D2TMgoa7rHeg4FszNZrhdVuj7J6j6qFqNXYxgLltF7oc9ikt7AqtS7HGw3d0ExWZ+ETe7qE31cLZ7+TEnBedrgFH3CbTT8JcaRQ6ISCm2PLRsQGCcaJeo1iYE45CLQEvt0OW+t9vweJsx0B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719246488; c=relaxed/simple;
	bh=tuIJUU+UKRHC/fDd2tlDYJc70zfPxdAygdj0ZUkU1Xc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BA6mfXSMZ4nKh7ibB4A48LZy70zS0qbpK1R3mW+Gxq9OGDGNt0lkJmSmyzEifgpxEYmXxBNXwGlTYjuDDjN3QewzlEVF+GkEFdjqIuMFEEE9bEYNPdrAHbhUHRODoPalYCsNijCV4MlEHkYfxemiRdaTV6SDvYvbCfvT0TMbtQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MEi0IoKx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AD79C2BBFC;
	Mon, 24 Jun 2024 16:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719246487;
	bh=tuIJUU+UKRHC/fDd2tlDYJc70zfPxdAygdj0ZUkU1Xc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MEi0IoKxH9YgyxYP7UPX77pQVJU/rNDxumgw/L95YmA+DW2AQn8VijxWpB0WeaQmK
	 jakU1eoyzKJwlo7Z6kKfDMSLqbYA/mMWtUdZHSjXrjTfPBCr8LysSzFq6cECXfchgX
	 /txAjDXRx/HssDO2reLFhP2EBJubslkjhOr6I8dL6BkuH+mcyofu0TLLKG1dDatoce
	 1AD5cgZY95XH8ibka1sIvJ4OLQwCKTAhkWek32xn1vi5l29V91qfOH420raKBamCZt
	 niEeklVR48acRRxLjlnwKaU5rMR44B6cibWQWtzQcDEsmQ8Yyekn4l0w8DLXQ0kd9K
	 abin4fFRRErSg==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	snitzer@hammerspace.com
Subject: [PATCH v7 18/20] nfsd/localio: use SRCU to dereference nn->nfsd_serv in nfsd_open_local_fh
Date: Mon, 24 Jun 2024 12:27:39 -0400
Message-ID: <20240624162741.68216-19-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240624162741.68216-1-snitzer@kernel.org>
References: <20240624162741.68216-1-snitzer@kernel.org>
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
index aaa5293eb352..4c54905dca14 100644
--- a/fs/nfsd/localio.c
+++ b/fs/nfsd/localio.c
@@ -191,6 +191,7 @@ int nfsd_open_local_fh(struct net *net,
 	struct nfsd_file *nf;
 	int status = 0;
 	int mayflags = NFSD_MAY_LOCALIO;
+	int srcu_idx;
 	struct svc_serv *serv;
 	__be32 beres;
 
@@ -205,7 +206,7 @@ int nfsd_open_local_fh(struct net *net,
 	}
 	nn = net_generic(net, nfsd_net_id);
 
-	serv = READ_ONCE(nn->nfsd_serv);
+	serv = nfsd_serv_get(nn, &srcu_idx);
 	if (unlikely(!serv)) {
 		dprintk("%s: localio denied. Server not running\n", __func__);
 		status = -ENXIO;
@@ -245,6 +246,7 @@ int nfsd_open_local_fh(struct net *net,
 out_revertcred:
 	revert_creds(save_cred);
 out_net:
+	nfsd_serv_put(nn, srcu_idx);
 	put_net(net);
 	return status;
 }
-- 
2.44.0


