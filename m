Return-Path: <linux-nfs+bounces-11464-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D1DAAAD58
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 04:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C44259873CC
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 02:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B0F3DFA8C;
	Mon,  5 May 2025 23:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jy8UX4lC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A0D2853F2;
	Mon,  5 May 2025 23:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487131; cv=none; b=XxyomzdWzXvVioZgCTXZxRz1sbgjWDf/01/9YCI0YzGWtROTY6rxmj6aDiDtRNqVZJogpJteIp3JQJW+ssxQqeohSNx6i9RF8Hc7saPgaKSffZRaLOnB//3gNzXl243BjV7Ycqsi894kxhPxVL4iWYXZEdZoSjgtKpv58Un+g4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487131; c=relaxed/simple;
	bh=rdQ9U5XK7avcHGvtcqUxY4GUkjVaxrFsSZwkzWf4N9I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TTt64Ra7pYWay4ixZsZKpfSA9/3Y8pIUp5siaF5dVxWwXpB3ELvPvJ528FHr1XwnZFq5ZpkYgcRynvObl0DxSKYXjyKBFq4SK+nX3pJSFnYSES2uIh50CtmkPYnXs+y/FORRjED0Fan1EOjNVae0rQrnjmo7jhge/z0fOWbDlBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jy8UX4lC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 737B6C4CEEE;
	Mon,  5 May 2025 23:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487130;
	bh=rdQ9U5XK7avcHGvtcqUxY4GUkjVaxrFsSZwkzWf4N9I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jy8UX4lCsBMdk8C2/1ZWMvc7e1bZhhTJJTD++bXh8ZbMtOalTr/kNGEVAfYEpwPhy
	 EQL37CquCOvqQINgL3X8Rj8Se6vrGomdSH7rlsuDKe4we0Y0gIaquAPiehpmDmsYxq
	 mteLQgmQC29SY85GuRZsZN3HgVNkMtmvuEa2EJYASqz6fKC+Ur+VVLvMcTjWJQonYS
	 N0gyNvdCszWpngndn3CkTBuaDpSGOOd9x2I8jwqym+jPtjFn+TGllS6l1lcbGDjyZj
	 4y3DWtCUBWemL3swXvaRSp8D89qNmHw/VTqw5R/+/PbHJaTMBYvXNxPmTgX5CdElQb
	 3bZo1rFcLxZeg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	trondmy@kernel.org,
	anna@kernel.org,
	snitzer@kernel.org,
	neilb@suse.de,
	kolga@netapp.com,
	linux-nfs@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 014/114] pNFS/flexfiles: Report ENETDOWN as a connection error
Date: Mon,  5 May 2025 19:16:37 -0400
Message-Id: <20250505231817.2697367-14-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231817.2697367-1-sashal@kernel.org>
References: <20250505231817.2697367-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.237
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

[ Upstream commit aa42add73ce9b9e3714723d385c254b75814e335 ]

If the client should see an ENETDOWN when trying to connect to the data
server, it might still be able to talk to the metadata server through
another NIC. If so, report the error.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Tested-by: Jeff Layton <jlayton@kernel.org>
Acked-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/flexfilelayout/flexfilelayout.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index 1af0b8ad83f2d..ce9c2d1f54ae0 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -1260,6 +1260,7 @@ static void ff_layout_io_track_ds_error(struct pnfs_layout_segment *lseg,
 		case -ECONNRESET:
 		case -EHOSTDOWN:
 		case -EHOSTUNREACH:
+		case -ENETDOWN:
 		case -ENETUNREACH:
 		case -EADDRINUSE:
 		case -ENOBUFS:
-- 
2.39.5


