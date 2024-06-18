Return-Path: <linux-nfs+bounces-4025-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF0090DD3B
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jun 2024 22:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C3A0B21DBE
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jun 2024 20:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 114DF1741DB;
	Tue, 18 Jun 2024 20:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wcw+Czqu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12D21741CB
	for <linux-nfs@vger.kernel.org>; Tue, 18 Jun 2024 20:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718742013; cv=none; b=ZThTye+goPsvg/okpONNQIgL9MZliiDIDs5UMw+Wb0UXgR9NaR/zeO0kHQ+XCNtoU9uEVoqt23bcuc3PZzNWBCfwxtt+R750Q/oU9e8tXBoFwAcJLZ+n58AfUepu5vE1ywZSuNa2SlXgQB0VXE+Yuj38AxrQkgj55ZEN0osTGGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718742013; c=relaxed/simple;
	bh=FCw8d7u3yE/Yb082AyvJ4nrRXY5ztvkcW1gDSsH/7bI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W2+zyOKk5SV9a4DtrqUfXIkedo6TYgRs9N5owurJ9DivXkEXTa/NqolAILLgolo9I8UswvVRn+1qVgOTQ74M6+jZ6Q9EId+lrs+RXUIgfu2ZDJQprvxX+4mNSccsaetNjj3ILEiqIZ7QN3oHczixwLJnmM/r95vA3iQFvjMM+jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wcw+Czqu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3107BC3277B;
	Tue, 18 Jun 2024 20:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718742012;
	bh=FCw8d7u3yE/Yb082AyvJ4nrRXY5ztvkcW1gDSsH/7bI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wcw+CzqulLja6BP2K1g8DMLYKyLKlMBcnMUoipjE5wHi/CwMDdsRa1V76i3GkBdRh
	 aZr0qxwAJpKMyrPVSwgpsOt8ey4WAYwF/LdsW7ci0iH6ivbExSGYctLlUTpznn5pRC
	 gG1p+K2i6dGxlpjwCqAQpofdmtlr3xupzrCktMZCWKYYXpL0DyHEV7YnxB32XHjY+P
	 1TesS4tejfKI6Aex5yu/D4TSdOp6V8UDEk2TytgRG6QyZpWzHfee1apNM89MsqP/XY
	 Y/FiyXRlMLQRJANGizgxUyxB+O5iBo8KvZobn5qpSfUYhbZ5Ykvu3b4olPjaO0wxWN
	 sIR8Y1YSfGPFw==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	snitzer@hammerspace.com
Subject: [PATCH v5 17/19] nfsd/localio: use SRCU to dereference nn->nfsd_serv in nfsd_open_local_fh
Date: Tue, 18 Jun 2024 16:19:47 -0400
Message-ID: <20240618201949.81977-18-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240618201949.81977-1-snitzer@kernel.org>
References: <20240618201949.81977-1-snitzer@kernel.org>
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


