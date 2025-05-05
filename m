Return-Path: <linux-nfs+bounces-11456-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D65AAAE9A
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 05:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF4DA188D824
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 02:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A912E61E1;
	Mon,  5 May 2025 23:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PJLXJ6qE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7770F3731B4;
	Mon,  5 May 2025 22:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485860; cv=none; b=nX5zMO3eOPo0ul+eObx5IZ5p1AAxe475ZrAzxD+adEf+Eb/V4hluk4sxz++dmtJ1od1BWwUG1i0m3eKdO5zc4s70WefPkEJBAk7W05RR/LMgpIlUq2GedvJ2AU3DSf03RGMuCWow7quDuMRvi+A2YiR2obIjYplvtpeduaW+8ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485860; c=relaxed/simple;
	bh=KVx3Vbb5tTNmNEc5elKnfUxyIYnd24kESt5VdJg04jE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q2sJz46opF5nAJJMp3hrl7D+HxKELGNaLElmaKFru+il1XWU4vTv0mUFClsByeubMuAzEKmiZmg5ec2odwhxwGsrOk/m77sw/jpMwJElwFMKPY+VgXSclmrpzZ4xxuCn1G+YMtpCyVqEiJnf8ICHdgjjr31LNJQ9btBFSwPh8yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PJLXJ6qE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16E15C4CEE4;
	Mon,  5 May 2025 22:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485859;
	bh=KVx3Vbb5tTNmNEc5elKnfUxyIYnd24kESt5VdJg04jE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PJLXJ6qEguunkFypcDi/ydJ8OR+LCtBLfgKtev8Lg7Hvf2YmApVQ8EHM6/LgjfVdp
	 uI3Fuwpn6+f0/Vj+DY4gJ/IsroZe3yx6pu20LZTKb4JEy7rUjkUCF0hqPiSKZvmSq2
	 KuDfIj7wHPTqiMdTG4lesf2dddjEQfdJ2sagAD9MFpfaQ+EXmWGpno6x9FWJ4m9vTL
	 ZHygfUZHEi1+svgqLVBUjNutNXkTdpxJ0Fb5wxAOqomhAeDXttQsJ2aqp/jCh8ahw3
	 KptGJUWyQPshOxdh1tT3qHXHBLjchhXxDFgkNLbTNZ58Sde2PRywBT7kXqfSMvXGaW
	 SSfNnK/YB2Hlg==
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
Subject: [PATCH AUTOSEL 6.6 033/294] pNFS/flexfiles: Report ENETDOWN as a connection error
Date: Mon,  5 May 2025 18:52:13 -0400
Message-Id: <20250505225634.2688578-33-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
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
index 2b3c5eea1f134..0bc537de1b295 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -1255,6 +1255,7 @@ static void ff_layout_io_track_ds_error(struct pnfs_layout_segment *lseg,
 		case -ECONNRESET:
 		case -EHOSTDOWN:
 		case -EHOSTUNREACH:
+		case -ENETDOWN:
 		case -ENETUNREACH:
 		case -EADDRINUSE:
 		case -ENOBUFS:
-- 
2.39.5


