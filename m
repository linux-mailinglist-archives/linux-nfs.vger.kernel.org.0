Return-Path: <linux-nfs+bounces-5292-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6895194DE6A
	for <lists+linux-nfs@lfdr.de>; Sat, 10 Aug 2024 22:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25A8C282C22
	for <lists+linux-nfs@lfdr.de>; Sat, 10 Aug 2024 20:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A0113D285;
	Sat, 10 Aug 2024 20:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mc6Y+Wzw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB45125BA;
	Sat, 10 Aug 2024 20:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723320075; cv=none; b=OfM1jCGom+0D856N+J5DWHFeCc5TneVXaAGo8xEO0KnhKl3oAGFoE6cEc9uKLnP5ktKWanMm1DLFMFbu2sUqYvt5vwmB85vxHAuNX8//oAAxwG4CBUZQgqn8PPc9Uf9CQhOWNRVURTYDjrv31fqyk15qgJmepZ3+xt6GSSI6Aqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723320075; c=relaxed/simple;
	bh=kCi82IEykmoS2kJlHjh4Vkv1DCUr1hA6BJtSBlMVkUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nLHCNj/xKvdS9wppN0vWWd0eN6gfFJ9ZzIcFtsjhkJlPhTldvNFLAlXGoA6lzGXmlVO7lixs5Sq/FyVQ5LM0eJp6SIY9+bZXRU5l//8BrdUe3rAJJ8kF1A6AY1QRBx0zwyUpaQm8vQTDKeZ8MrNY6dqgz7JYXVt1eE2jvFpng94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mc6Y+Wzw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C1F1C4AF0C;
	Sat, 10 Aug 2024 20:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723320075;
	bh=kCi82IEykmoS2kJlHjh4Vkv1DCUr1hA6BJtSBlMVkUg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mc6Y+WzwmV9Dw5XFaieC2ZiEwdhSFNaRRJfdVVpLPVbmhzFdfVlkWTYxTx3kkgwg5
	 Xq0meeqLI1TFMMlpkyWb8IIMjpcStSG+JRsD81H9bJ3zdiG6Dv9b921AJLbDEnEEQO
	 JZlcr182wzPluyXsuKdPnpj7oY0sPMA92SWNgYq8cPx2xE00mfmqKAXjrb9FOGpmDl
	 a4zOVmRSeU56WdBfXdz9MH+aoQGkgY1IBbysAhW6uRWw7MnpLWRx4DUqScdp5UeUP0
	 tM3ZCqEBIR3HDfofBs+jn9cI3qOlLiduqIUI3nQjAorFTuZO9S05O+lMGbGS9DHBaO
	 pEgWn8dZbNBAA==
From: cel@kernel.org
To: <stable@vger.kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	pvorel@suse.cz,
	sherry.yang@oracle.com,
	calum.mackay@oracle.com,
	kernel-team@fb.com,
	ltp@lists.linux.it,
	Josef Bacik <josef@toxicpanda.com>,
	Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 6.1.y 12/18] sunrpc: remove ->pg_stats from svc_program
Date: Sat, 10 Aug 2024 16:00:03 -0400
Message-ID: <20240810200009.9882-13-cel@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240810200009.9882-1-cel@kernel.org>
References: <20240810200009.9882-1-cel@kernel.org>
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
[ cel: adjusted to apply to v6.1.y ]
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfssvc.c           | 1 -
 include/linux/sunrpc/svc.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 34d5906b844b..5ddb1f36f82e 100644
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
index 3290b805f749..912da376ef9b 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -422,7 +422,6 @@ struct svc_program {
 	const struct svc_version **pg_vers;	/* version array */
 	char *			pg_name;	/* service name */
 	char *			pg_class;	/* class name: services sharing authentication */
-	struct svc_stat *	pg_stats;	/* rpc statistics */
 	int			(*pg_authenticate)(struct svc_rqst *);
 	__be32			(*pg_init_request)(struct svc_rqst *,
 						   const struct svc_program *,
-- 
2.45.1


