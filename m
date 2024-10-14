Return-Path: <linux-nfs+bounces-7124-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1850499BE91
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Oct 2024 06:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF29DB226B1
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Oct 2024 04:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45DE15697A;
	Mon, 14 Oct 2024 03:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xry5cscb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2B715689A;
	Mon, 14 Oct 2024 03:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728878285; cv=none; b=q3b4FUtNZxslBkyUMi+4eZjbVrfO4IpOhchntZsyF8LZsRM8FINvjhwOgc2rZkVfjsEifyS9DygR9x26hlyU1pz167mQaLKxp+O/uffQDRmezQKx54obPa6pvVWro75Q0jY2YxaEzfu8ileY5AK01dRA2BGVRzbGYi5Mble9YT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728878285; c=relaxed/simple;
	bh=Oh8++S/Or6Y7qB0AgdmomXqyxttMef1PmZOGxJ2SyQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KeFT9zO8DFTJsjkC8OcWXUQj+Jajgz42FazHJBLyU88diZW3Ya3zS+LX9pYmmlM9LNsuXDAK370Rdok8g/8C83D/LCURj99F+IJbrxdQBMurL3fwNiWyB0I0Rkovw5Sc+rVafP3KU4NmdMKu0lNKnM+dzcdcWcQuAWozaH2medI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xry5cscb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C840C4CECE;
	Mon, 14 Oct 2024 03:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728878285;
	bh=Oh8++S/Or6Y7qB0AgdmomXqyxttMef1PmZOGxJ2SyQ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xry5cscbvbfnsR+YjiRiIjqdF4/tfhmP2YDFjad/zT7T1NrtcM6chhU6/WvrAuhir
	 sSBFR95HSxme1V0loidHRqQgTqdV7XOdq6TyyEvjC1HEbvAqRhdlJBTPJ8i80MnzL+
	 YbtbBlYEGQ+JVdnVarVBSUi8VkPzRg20M4izAUY76HpL8gK3WHMspyT8Z4hzb1yosW
	 8f7l4uU9GMorcJkg/+Pm0BSxvTexKNLx/BtL8oz5LFNqk0L1B0kF08+4utwrvwhyf5
	 zPQV8rLDg537aIayR3vyUDsXxjFF0EyynS9cZ60+hkJfHWDVvxEQ9Kp8nJp/5z3AV5
	 azjJBjB2zyd+g==
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
Subject: [PATCH AUTOSEL 6.11 19/20] NFS: remove revoked delegation from server's delegation list
Date: Sun, 13 Oct 2024 23:57:21 -0400
Message-ID: <20241014035731.2246632-19-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241014035731.2246632-1-sashal@kernel.org>
References: <20241014035731.2246632-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.3
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
index 20cb2008f9e46..035ba52742a50 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -1001,6 +1001,11 @@ void nfs_delegation_mark_returned(struct inode *inode,
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


