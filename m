Return-Path: <linux-nfs+bounces-7126-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E2D99BED8
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Oct 2024 06:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90AE6B20D92
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Oct 2024 04:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065971AB503;
	Mon, 14 Oct 2024 03:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Afvq1lRJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D132F1AAE39;
	Mon, 14 Oct 2024 03:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728878361; cv=none; b=QseFYoyey/j1Vpn8/C0k+IDPXAplnG+1u41yR6jKBvzegUmASMdzU0bS99zw5ylFyksSqN7AXXaWH9uvdY4osrQtuXz7zPIWmmvIPqjwaszjTSYQPKcXo9Nz1kkeal0B+B4EiomNb0yL4VxOTuPeNuSbWSMRw+D+ADB1pPmhnYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728878361; c=relaxed/simple;
	bh=wVwRs0M2xO0l0PXaRRxAREb3NgjeX+7sz70e/59BTgg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tDRuvXgpO+xJ5rJNb4D6TTHNJ1naB59v4DnrSkEf6JMbC6/+08sbLQIb7V4ci2pUH8F5Ec+louK+mVIevdj28iMnAC52X7ao5FkvB2fuffInWPkTwwmOja5PSPYhRhM1i2D0Eklt99HZNUDd/UtJ40zy9UNRJpmGEnRrOWZbEQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Afvq1lRJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52AFDC4CECE;
	Mon, 14 Oct 2024 03:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728878361;
	bh=wVwRs0M2xO0l0PXaRRxAREb3NgjeX+7sz70e/59BTgg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Afvq1lRJ+VNNDYcB/v1mvt2z68aAEYfQvwfp309zsqRxZKNpCxpARw6LxFr5QHNFt
	 buQ84YVhjDhH2W6f+s+jvRBj38t2VmeWGuwzqUtQVt4QeoiRo7ki97RfHZl2FIMBzj
	 ICb4lpLETflGYTFPh40yy2Ze0Kg3iuFW5K/pppMVZdEx8UZDylvBafjyaPtD509i11
	 3qBaS3okXXXNGRN+rmNcQP/xL73Wnwj+IAVyHaU5TdjG4mcT13uT3lwaeSrBBGwJGw
	 xyWSk/YMzTYR39S9X692q9OVtUb5R69DY8ou2/WMM1iet6s8spUgOe9uBz6a/Fuqsy
	 zQI872SAes+oQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dai Ngo <dai.ngo@oracle.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna.schumaker@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	trondmy@kernel.org,
	anna@kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 09/10] NFS: remove revoked delegation from server's delegation list
Date: Sun, 13 Oct 2024 23:58:44 -0400
Message-ID: <20241014035848.2247549-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241014035848.2247549-1-sashal@kernel.org>
References: <20241014035848.2247549-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.112
Content-Transfer-Encoding: 8bit

From: Dai Ngo <dai.ngo@oracle.com>

[ Upstream commit 7ef60108069b7e3cc66432304e1dd197d5c0a9b5 ]

After the delegation is returned to the NFS server remove it
from the server's delegations list to reduce the time it takes
to scan this list.

Network trace captured while running the below script shows the
time taken to service the CB_RECALL increases gradually due to
the overhead of traversing the delegation list in
nfs_delegation_find_inode_server.

The NFS server in this test is a Solaris server which issues
CB_RECALL when receiving the all-zero stateid in the SETATTR.

mount=/mnt/data
for i in $(seq 1 20)
do
   echo $i
   mkdir $mount/testtarfile$i
   time  tar -C $mount/testtarfile$i -xf 5000_files.tar
done

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
Reviewed-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/delegation.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index 2ba4d221bf9d5..39c697e100b1b 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -981,6 +981,11 @@ void nfs_delegation_mark_returned(struct inode *inode,
 	}
 
 	nfs_mark_delegation_revoked(delegation);
+	clear_bit(NFS_DELEGATION_RETURNING, &delegation->flags);
+	spin_unlock(&delegation->lock);
+	if (nfs_detach_delegation(NFS_I(inode), delegation, NFS_SERVER(inode)))
+		nfs_put_delegation(delegation);
+	goto out_rcu_unlock;
 
 out_clear_returning:
 	clear_bit(NFS_DELEGATION_RETURNING, &delegation->flags);
-- 
2.43.0


