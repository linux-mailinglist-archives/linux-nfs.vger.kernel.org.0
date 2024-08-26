Return-Path: <linux-nfs+bounces-5764-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C12095F48A
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Aug 2024 17:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8280D2828DC
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Aug 2024 15:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D3F188CA5;
	Mon, 26 Aug 2024 15:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r42Ffu0b"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B021E892;
	Mon, 26 Aug 2024 15:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724684827; cv=none; b=j3go1xyy2eFbYNtiEQ89QzJ1tUvysg/34g90CYMxcOQ4WW8rVRuNdDjhZBjr8RfKXElpA3l2lQE4UJPW9zog4fDqPc8n3tMxCrkSJ0wX26Ejqd3rJC8+3GonT990kO50kv291etEy/vzBpVLLDUo8OWdjmh/I+3B7voxrGAhcZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724684827; c=relaxed/simple;
	bh=giQLn8XgtaRM8j1D7YOH7/DnDOhVBKs1A2jJUnUKvew=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iD+8fIBmUOcYUax4KTOB7jQEKtx2L3hGOE6OqlpHT3Ad2GlXg4vSu+0rQaC49D6s3mNoMPdybrmyWszoLZMP4NaKxP6AcSCbLRsYclI+llS+5lrTUJVlxLhSUhh2pe58m+LobUdkw5l6Ptj3COkuYp8OmZcua9WCZWyeHH6AbTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r42Ffu0b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F6EBC4FF08;
	Mon, 26 Aug 2024 15:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724684826;
	bh=giQLn8XgtaRM8j1D7YOH7/DnDOhVBKs1A2jJUnUKvew=;
	h=From:To:Cc:Subject:Date:From;
	b=r42Ffu0bHAZwYfYtKymfcGHsrNhUZmReQuDEEQ8iAv+SXuVblo2qk6fDCdPOfw3wH
	 maLQv+u7Gcr9hnfiij0agpML52m6KvjVtgQsyAUjtIsnBojQKJcXWjiqJxzbtgG5O+
	 ZcUt724FS2rdczTA5iRNHxyS4rvfrEKM+YjgDFSYxtzX9mfRwe+GfsjyBY3Zzzvg0D
	 2F/RNFYVhbDLEKygRa2al4Qi7UmgliHDRZ0aHE/gJo36GIDikuucto1Vuoux9X/PdO
	 dFzMmMVPOPRSSfHSVbK+oPPnXUokBBr4nO4R+JTTbaIPqm0ud6g3EBPQbyO+GoPLyp
	 pK290Tu1J2zAQ==
From: cel@kernel.org
To: <stable@vger.kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	lilingfeng3@huawei.com,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 6.1.y 0/7] NFSD updates for LTS 6.1.y
Date: Mon, 26 Aug 2024 11:06:56 -0400
Message-ID: <20240826150703.13987-1-cel@kernel.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Address an NFSD crasher that was noted here:

https://lore.kernel.org/linux-nfs/65ee9c0d-e89e-b3e5-f542-103a0ee4745c@huaweicloud.com/

To apply the fix cleanly, backport a few NFSD patches into v6.1.y
that have been in the other LTS kernels for a while.

Reported-by: Li LingFeng <lilingfeng3@huawei.com>
Suggested-by: Li LingFeng <lilingfeng3@huawei.com>
Tested-by: Li LingFeng <lilingfeng3@huawei.com>

Jeff Layton (1):
  nfsd: drop the nfsd_put helper

NeilBrown (5):
  nfsd: Simplify code around svc_exit_thread() call in nfsd()
  nfsd: separate nfsd_last_thread() from nfsd_put()
  NFSD: simplify error paths in nfsd_svc()
  nfsd: call nfsd_last_thread() before final nfsd_put()
  nfsd: don't call locks_release_private() twice concurrently

Trond Myklebust (1):
  nfsd: Fix a regression in nfsd_setattr()

 fs/nfsd/nfs4proc.c         |  4 ++
 fs/nfsd/nfs4state.c        |  2 +-
 fs/nfsd/nfsctl.c           | 32 ++++++++------
 fs/nfsd/nfsd.h             |  3 +-
 fs/nfsd/nfssvc.c           | 85 ++++++++++----------------------------
 fs/nfsd/vfs.c              |  6 ++-
 include/linux/sunrpc/svc.h | 13 ------
 7 files changed, 51 insertions(+), 94 deletions(-)

-- 
2.45.1


