Return-Path: <linux-nfs+bounces-7125-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB8099BEBA
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Oct 2024 06:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37CC1B224DF
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Oct 2024 04:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935E419E967;
	Mon, 14 Oct 2024 03:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vFPAJu9T"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663F4143890;
	Mon, 14 Oct 2024 03:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728878323; cv=none; b=Kqtn7V3cEU4kbB8jU+znF2ARRNwfEvMZUxR+wCe4pd3sf8PwfC4oldB/RZj0KLdhA0ltuACEkntb0+tCc6weLfpsAS647mIdXyKGkIB0Ha89iSxsaUxuLPyPN692/LCOmRnkYCgdJluSXN2t4YAkMrv3yYAK4TaRiFYqp5VDOTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728878323; c=relaxed/simple;
	bh=GTIZLnhCAwa0uen67LKYd2A4t/JQxtS+scz5APAVlEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KkvSVHPPv9l3YIZdSllaZlugUZs+YIbxboWbn77IV474LIaVX6/ZIT55HzNWsZUcQkEPaGsSxpUp0wa8V7fUvDzVcCFVCfjwwQ0nxNB7agdZVzdmnp2EfqxFnHhqjOfim6FerY2P1WiVNftI9J6PX60F3yEJryDIm90HPkTwwns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vFPAJu9T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D2AFC4CED1;
	Mon, 14 Oct 2024 03:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728878323;
	bh=GTIZLnhCAwa0uen67LKYd2A4t/JQxtS+scz5APAVlEk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vFPAJu9TjnCArdIGg6h8RxYtk7IFeNMULbB+oEgDoxPezhLY1UcQmAlAtMghfFKQl
	 fkI2RXAmtEx6zFnbotunHd+WugsyG/XtitjnOxxGmEMr4Msu+/wqwSJddmXXskwwDH
	 4XUjKC1tSapDjViA2MHUMAs3NdZ/I7qP/Raf8Sq+NSuhN9v401qK3gjOE2iz5XaixR
	 P+U7kXvAYmfATUVcjZTsWOjvh0C7uFjrSbZo3Zfl/LHJhJGDfPWcEp2jiUckdEnV1N
	 HfcBe9NTcPRk4v6a4Vrecs4+2pQ6dYMKJf5P6KOL2BjHrea5nXtGBKwB4NLU58Qexx
	 2JhgD/B9rXwjg==
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
Subject: [PATCH AUTOSEL 6.6 16/17] NFS: remove revoked delegation from server's delegation list
Date: Sun, 13 Oct 2024 23:58:06 -0400
Message-ID: <20241014035815.2247153-16-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241014035815.2247153-1-sashal@kernel.org>
References: <20241014035815.2247153-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.56
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
index a2034511b6314..4bf2526a3a189 100644
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


