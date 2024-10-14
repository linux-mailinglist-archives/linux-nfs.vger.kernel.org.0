Return-Path: <linux-nfs+bounces-7128-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF8BD99BEF8
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Oct 2024 06:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B1BC1C215B9
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Oct 2024 04:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354871B86F7;
	Mon, 14 Oct 2024 03:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X5ci9VT8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0527514B94C;
	Mon, 14 Oct 2024 03:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728878393; cv=none; b=TEb6Xed5NYZIJJS3CKSidHY4pPIycl9tNbjbh3ztQ8ycwiwY3BmaxRL00IuZw6bmS6ZQ3WFW8FF99/aRSkW7JAx7UHUsBd/ggXm1UYLbcM8nRO+0qqeRZCnmaumZY40Yg3vX2XOYdiJZVoi8dZk75HWUwpzCcccJn+ZAAgKg4mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728878393; c=relaxed/simple;
	bh=Kv08AcQYawT4zeVOx48O02koGjgfjaQZDebQkt+tZ5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ROagnGAKRk8X+IPzwbIsdwhZf2cWCJxICwUobDuTv+pr2vxwXC/Mdm8IV/SNZh8zpodZfkmO5Af6Dgqpd57o/HKutejDWfPcx0GcLJT4ltn/bRwy2QNAKAHikcPjjteBsF22MuPJ/UJgM4NaczaGemep7NNHHgybXBIxuRkt/+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X5ci9VT8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0DF3C4CECF;
	Mon, 14 Oct 2024 03:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728878392;
	bh=Kv08AcQYawT4zeVOx48O02koGjgfjaQZDebQkt+tZ5A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X5ci9VT8C/J3cz6itmHAJx9VXShIM9nq+CdrBv7ugk1NrIWaBIO77oeTm7EOH+VnE
	 /Mx+UsUV/E/EnCeZVwnR4AhZd/SskaJRx4VVAUPwR1KJX9Fgy8y94M0dDBGphS6mpo
	 fvwYb7cFU3Cju//XJPPwqdWNenn6ZYGyORSCeWxpjq7eZXA791SqK5fXlP3sXEvXvc
	 PEg1jqDX2oEYAJVX1ypxLX8JCYa73vq7D90kNoI416PPS2Y8vkF7BUtLlq80dd411n
	 PZlE+s6BaoXtdSWOqe5K+5gKfhX6Rg393ZNm6TWB0DjzRa1ruzhHac9IS/rOOkZeFm
	 sBOhzGuqlOVLQ==
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
Subject: [PATCH AUTOSEL 5.10 2/3] NFS: remove revoked delegation from server's delegation list
Date: Sun, 13 Oct 2024 23:59:42 -0400
Message-ID: <20241014035948.2261641-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241014035948.2261641-1-sashal@kernel.org>
References: <20241014035948.2261641-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.226
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
index 1eb6c7a142ff0..2354b7d41b468 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -963,6 +963,11 @@ void nfs_delegation_mark_returned(struct inode *inode,
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


