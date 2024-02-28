Return-Path: <linux-nfs+bounces-2116-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D47E786BA21
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Feb 2024 22:41:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F57A28795B
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Feb 2024 21:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37F770023;
	Wed, 28 Feb 2024 21:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WQX/eVmu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE4A53E2D
	for <linux-nfs@vger.kernel.org>; Wed, 28 Feb 2024 21:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709156510; cv=none; b=fsH7XGSCL3Mq0hfmmemZuKtFDyydGD4b8GHLXv33zsij1ai9pVHy+zm003kK0pF4R4A9exWoVQuNJXJEcAgAU1CLMK8q2OWxu0u69wWPbRCAlmlSQXaNNH2wJI62dUanVmW0bhLOIK/DmGf5t4P/iyipy7Pp6c5Gs3JhSOYka0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709156510; c=relaxed/simple;
	bh=ZxpvFg7HMptsju2aZrlCwuTRIS1z8f2IlOPsnvowJo8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=rXeXu6cxLlHEgz1dLH5GxfeaYf/6OsC8gbR8vfsRKGDclE2/na37iTzYCsE817lwn+nTIK9ZHbhjT2yOwukMC+PlSSQKRDB9VnbNtgdT0fn+jwKF9brpWFUTSwS/SzhvswDAYLyrROufLP9VrcmgX/lWaWDX4t964aulFbMJp/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WQX/eVmu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 217E7C433C7
	for <linux-nfs@vger.kernel.org>; Wed, 28 Feb 2024 21:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709156510;
	bh=ZxpvFg7HMptsju2aZrlCwuTRIS1z8f2IlOPsnvowJo8=;
	h=From:To:Subject:Date:From;
	b=WQX/eVmuAkSzhN1OufWcuvZ+sjz2hXIZe5Zmai1lsbXiLCth8qnq5Q4dRkjHK4m/P
	 5xaRr2qIZXwEQyl01BNKJmxwWAxz9RPEYAKMfOXtt7WWHUR3cZIU3OWS1ph7zHoKu1
	 6inv0Wlt4Igu5tqHkB71vYmVX3WKL0j32+aKTMR1ikRWfFMFjLiBFrf0+sdGwXiiO2
	 NFKyvsa9xo6jI+lzmHAUPHqoy4bobOOBVil1cstpH/iJrz/4ltqpcMm2y8uqSUvE1J
	 1pqDvUYCpPc4DaSnmjy9c/BwVtXlr5s5uD3D4XfZk5xFJ2tkyzfPr3IYDai7115pIY
	 KjltYEi9noxwQ==
From: trondmy@kernel.org
To: linux-nfs@vger.kernel.org
Subject: [PATCH] NFS: enable nconnect for RDMA
Date: Wed, 28 Feb 2024 16:35:23 -0500
Message-ID: <20240228213523.35819-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

It appears that in certain cases, RDMA capable transports can benefit
from the ability to establish multiple connections to increase their
throughput. This patch therefore enables the use of the "nconnect" mount
option for those use cases.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs3client.c | 1 +
 fs/nfs/nfs4client.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/fs/nfs/nfs3client.c b/fs/nfs/nfs3client.c
index 674c012868b1..b0c8a39c2bbd 100644
--- a/fs/nfs/nfs3client.c
+++ b/fs/nfs/nfs3client.c
@@ -111,6 +111,7 @@ struct nfs_client *nfs3_set_ds_client(struct nfs_server *mds_srv,
 	cl_init.hostname = buf;
 
 	switch (ds_proto) {
+	case XPRT_TRANSPORT_RDMA:
 	case XPRT_TRANSPORT_TCP:
 	case XPRT_TRANSPORT_TCP_TLS:
 		if (mds_clp->cl_nconnect > 1)
diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index 11e3a285594c..84573df5cf5a 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -924,6 +924,7 @@ static int nfs4_set_client(struct nfs_server *server,
 	else
 		cl_init.max_connect = max_connect;
 	switch (proto) {
+	case XPRT_TRANSPORT_RDMA:
 	case XPRT_TRANSPORT_TCP:
 	case XPRT_TRANSPORT_TCP_TLS:
 		cl_init.nconnect = nconnect;
@@ -1000,6 +1001,7 @@ struct nfs_client *nfs4_set_ds_client(struct nfs_server *mds_srv,
 	cl_init.hostname = buf;
 
 	switch (ds_proto) {
+	case XPRT_TRANSPORT_RDMA:
 	case XPRT_TRANSPORT_TCP:
 	case XPRT_TRANSPORT_TCP_TLS:
 		if (mds_clp->cl_nconnect > 1) {
-- 
2.44.0


