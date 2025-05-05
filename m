Return-Path: <linux-nfs+bounces-11445-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6FBBAA9FE7
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 00:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 175D21A83195
	for <lists+linux-nfs@lfdr.de>; Mon,  5 May 2025 22:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D401628BA8B;
	Mon,  5 May 2025 22:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YcLhhG18"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D5628BA87;
	Mon,  5 May 2025 22:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483367; cv=none; b=ob8AsaTqK8dFbsJkPq0U3ToyUedVH2bVT58+8AIh2Kzs/2Hb/rmIK+k5wlxRvBf0OQcKMAG6+zegctwxH4bdIFqV/gUASZbrL5CcqFq6Do82Ykd2dqrcF4DCnRPeUzaBWudg0gHwxoVlQyHUNZE1mXf1Y3NJeeiE3XqmKYVMJQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483367; c=relaxed/simple;
	bh=PBkd5UAF4fpHlVDFl7acQeaNqx5iLlriyEMSKeO3gT0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E70Ytes1KyjaOOZdvwRVGr+1+0j96bY6jWjopaqaJOQgHw5v8NrYteWn7Aoeb2I8ztAOJ6zkwE/p13VwNUM/O5GqsPJe51rAfSHwwpYK1BhwOQnm9+cTbFBj17LwXtdz7dM4lhai7SG3ZUcasGdB3vUNfSHVcnSf1NnPmKxlbsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YcLhhG18; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4115CC4CEE4;
	Mon,  5 May 2025 22:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483367;
	bh=PBkd5UAF4fpHlVDFl7acQeaNqx5iLlriyEMSKeO3gT0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YcLhhG18IJ3aAs1Xpz4oFjXnejDJNKSrywqHG04kojKcRWjwc/OBeudkzA39Jkpsr
	 yuiqPlC5xjk4QAhMT4MAr0pn7lG5YKx0UJ4qyqOc4hZ1Bl4CU9FzaEoKxuK7rjLwEe
	 tDW0pKU5jRupJj6eySbIRHcZDIj2NJWvu6zpeCm4LsHTf343UoPQuWhPEvV3ls5iOA
	 +2jnJNbwyFy/1H06fU3qFu4kmYsWs6Ayy+SII5smWBekX7+I95IZZwIgtqQPoOJg0J
	 VE/xSa3bk7v7Mb3W10a3jQUxEOK+0bNMoS1tVhJ2/wtB2/M6Qz1449G93gSlSW+V5f
	 9ELzQBijVxc5w==
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
Subject: [PATCH AUTOSEL 6.14 057/642] pNFS/flexfiles: Report ENETDOWN as a connection error
Date: Mon,  5 May 2025 18:04:33 -0400
Message-Id: <20250505221419.2672473-57-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
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
index 98b45b636be33..646cda8e2e75b 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -1264,6 +1264,7 @@ static void ff_layout_io_track_ds_error(struct pnfs_layout_segment *lseg,
 		case -ECONNRESET:
 		case -EHOSTDOWN:
 		case -EHOSTUNREACH:
+		case -ENETDOWN:
 		case -ENETUNREACH:
 		case -EADDRINUSE:
 		case -ENOBUFS:
-- 
2.39.5


