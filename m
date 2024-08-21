Return-Path: <linux-nfs+bounces-5514-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A595495A0A7
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Aug 2024 16:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6392F287732
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Aug 2024 14:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51CFB1B2EC9;
	Wed, 21 Aug 2024 14:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NqtLfrd2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6741B2EC8;
	Wed, 21 Aug 2024 14:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724252209; cv=none; b=K8vZFWUUHOrZVr/kfVoCRxQqxam8In/eV3EfaQw/VF0Xu0ZjZyLsDRlmZr10xSrgFUYKOwSpJPPpCab8Ae4mLl2RySfJDwA8HRp+xyHGKTefHGTnmec/2EruCPWD/I8JTtDBWSKIQVn4wnd5gr9xMX1dd8Y47xPnW0ScfRZN86M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724252209; c=relaxed/simple;
	bh=yCznjqq+MJmj5zm8CN6rZgNRFsI5NdBXJfIMezKrz7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mX3IYNl3Iz4dF1pjB8thbm8iW7gJZI1VsEGNoIUMAcLyvZY6FR3OOPP2hWUOHpWf77n7KytQbYnn5LRQiW/SzQaTqJ16s64fL2XjAns9iLA+2yGKrMHdl9PcIY2PZ1fLT+NHS3/NmAFUM6O0nBYXG7a+ZcuJOcqZvC0N1C7vh5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NqtLfrd2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CDFEC32781;
	Wed, 21 Aug 2024 14:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724252209;
	bh=yCznjqq+MJmj5zm8CN6rZgNRFsI5NdBXJfIMezKrz7s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NqtLfrd2EqgvxE5FPWqi0MlaE31UldVm/pW6vR4ZaTg7bB8RRW8D0mjRQKSpJYZUG
	 fa8YZ88iSqkkmAXCFwh2HuERsFId0biAhtN1L8A4zRKLK1HpbP1fFZG/w1X9TfIocn
	 xc1QeXzP1oQHtqp0u9h8Jk4bjftEOu78u95DTTLkL/cb8+epPBcNJF1beP27dZc0HZ
	 MyuS6rdRB93VynFoDmhX8/JRE1tun+GmL5b+Jub/GsOR84vyN419OLvaeqlRN3IFa5
	 SyMRcigQf1d32rYQ5FF0BVPFx3dqwG1fsSjUZO47ma0jheFK/uGJ83D2SRWRTbJ0fL
	 d0iG7zOrVTMTw==
From: cel@kernel.org
To: <stable@vger.kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	pvorel@suse.cz,
	sherry.yang@oracle.com,
	calum.mackay@oracle.com,
	kernel-team@fb.com,
	Josef Bacik <josef@toxicpanda.com>,
	Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 5.15.y 12/18] sunrpc: remove ->pg_stats from svc_program
Date: Wed, 21 Aug 2024 10:55:42 -0400
Message-ID: <20240821145548.25700-13-cel@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240821145548.25700-1-cel@kernel.org>
References: <20240821145548.25700-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

[ Upstream commit 3f6ef182f144dcc9a4d942f97b6a8ed969f13c95 ]

Now that this isn't used anywhere, remove it.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
[ cel: adjusted to apply to v5.15.y ]
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfssvc.c           | 1 -
 include/linux/sunrpc/svc.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index f5d6924905bf..74d21d2c5396 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -136,7 +136,6 @@ struct svc_program		nfsd_program = {
 	.pg_vers		= nfsd_version,		/* version table */
 	.pg_name		= "nfsd",		/* program name */
 	.pg_class		= "nfsd",		/* authentication class */
-	.pg_stats		= &nfsd_svcstats,	/* version table */
 	.pg_authenticate	= &svc_set_client,	/* export authentication */
 	.pg_init_request	= nfsd_init_request,
 	.pg_rpcbind_set		= nfsd_rpcbind_set,
diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index ff8235e6acc3..57e0d9b7553b 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -409,7 +409,6 @@ struct svc_program {
 	const struct svc_version **pg_vers;	/* version array */
 	char *			pg_name;	/* service name */
 	char *			pg_class;	/* class name: services sharing authentication */
-	struct svc_stat *	pg_stats;	/* rpc statistics */
 	int			(*pg_authenticate)(struct svc_rqst *);
 	__be32			(*pg_init_request)(struct svc_rqst *,
 						   const struct svc_program *,
-- 
2.45.2


