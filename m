Return-Path: <linux-nfs+bounces-6242-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CEC496DE5A
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Sep 2024 17:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF814B29D96
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Sep 2024 15:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469021990DB;
	Thu,  5 Sep 2024 15:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dAmm0Lzd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2171B19FA76;
	Thu,  5 Sep 2024 15:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725550290; cv=none; b=LfJOp/VLHLCdcDv0PzD0LVKqnvZgdBGaGPRsOQrSOygKCw6sgvvhb8SAQHkNBMlYnr/RvK+MrCxSszerTBHjPNJpm52fO7toioN+ldxmTjKlwp6giSB9RLinAcQsMR6i4q/cPDbbXshS1MMFFxRGmtWP2LfswlzKCVYEQIWwDwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725550290; c=relaxed/simple;
	bh=a/0cf93CheEFQCG2YVZkuZCl21bQ8cgptSzClXZ7paQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jHgv661r+GZDlWtgEUJeDoVn4fku2VmDdB3u4zP6cbrds8/69ometChAtbBXT613wgtU8dIY+5ly24TarXpyfgEyEBqcGlPvD2zO8UdkBEOjev+6sq4dRYBA63gkuawCDupsyC5drQjT6hcpwgtxxzTsF1f/PTRXr5ZHYrYHCYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dAmm0Lzd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 411B9C4CECB;
	Thu,  5 Sep 2024 15:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725550290;
	bh=a/0cf93CheEFQCG2YVZkuZCl21bQ8cgptSzClXZ7paQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dAmm0LzdTWFqxsdKX8BWeHynmxdhUBk/0G5gDE7zh8r//tvwOIORE78WZjjxZPwBA
	 WCvgSX+StV6S4cm1OfSFvRgcQsZ5BR4ufmsZshg/JloZrjg8nSuFHs9fd10DjRUrIe
	 7OKMp5fgGYNNwp9QQ5SbslMcR2BDU9skTfs9Q0ioc1bq4m44RJo7h8lR1oUaiDzJ7J
	 r9baCnLz7FWtZ+zfBIGdaftTy+yTlQkB/RNzRin6pbN56h0tb3ckH5D9CPjcuBkAYp
	 0LWIFW8RRieqTyv4gA1uyh2HXRZbOC0NGZLzH/WrLTidpZesmcS9/3xxwhBM7wkMyH
	 BKgmQoR1ReYxw==
From: cel@kernel.org
To: <stable@vger.kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	Petr Vorel <pvorel@suse.cz>,
	sherry.yang@oracle.com,
	calum.mackay@oracle.com,
	kernel-team@fb.com,
	Josef Bacik <josef@toxicpanda.com>,
	Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 5.10.y 13/19] sunrpc: remove ->pg_stats from svc_program
Date: Thu,  5 Sep 2024 11:30:55 -0400
Message-ID: <20240905153101.59927-14-cel@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240905153101.59927-1-cel@kernel.org>
References: <20240905153101.59927-1-cel@kernel.org>
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
[ cel: adjusted to apply to v5.10.y ]
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfssvc.c           | 1 -
 include/linux/sunrpc/svc.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index dde1824bc6de..a5f33089c7d9 100644
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
index 5753faa8d483..dea002ad99fc 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -410,7 +410,6 @@ struct svc_program {
 	const struct svc_version **pg_vers;	/* version array */
 	char *			pg_name;	/* service name */
 	char *			pg_class;	/* class name: services sharing authentication */
-	struct svc_stat *	pg_stats;	/* rpc statistics */
 	int			(*pg_authenticate)(struct svc_rqst *);
 	__be32			(*pg_init_request)(struct svc_rqst *,
 						   const struct svc_program *,
-- 
2.45.1


