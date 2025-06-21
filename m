Return-Path: <linux-nfs+bounces-12608-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42BDEAE29C3
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Jun 2025 17:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCF3D172A2A
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Jun 2025 15:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91D120C02D;
	Sat, 21 Jun 2025 15:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iThjldCZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8CB1798F;
	Sat, 21 Jun 2025 15:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750518841; cv=none; b=IqQp6ub1qoBxNQER9/QFYvALMoIq3ebgNqsnOynkxoZWz6yLCwX5oBxg17M8I5eTZn+aAgofNuj+5Fe5NKmro07MoZjfK0iGPKEOqroXL6OoVIB+8ERv2km+Gin3DL9yHdq2+Wt6i9F4AK9xV6SVQTPNcLDZr5kDID4X4MM7olM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750518841; c=relaxed/simple;
	bh=i5wqI008MJuV9pDmuCckzYYxukm/wwBTLtaZLeZMBeM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lAN75IQJr9wv1KCVJiXY8fkTKzMNSeu+iQchUIF1nXl1mp4t+ZJrkhyjeKZFTdQyHt2zmx5QonZhDX/fMHx1VzqL/NQnr7js0w+C8gjztfQH3yUGIob4ld9/3jkwlfJDdeDEyRRYl7/GdSe6N4hidMupzjOMO86LAhaNe09cuXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iThjldCZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9004C4CEE7;
	Sat, 21 Jun 2025 15:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750518841;
	bh=i5wqI008MJuV9pDmuCckzYYxukm/wwBTLtaZLeZMBeM=;
	h=From:To:Cc:Subject:Date:From;
	b=iThjldCZ47F9p7nsl2IaAGrgkxYPVSXZCLIurQ26Kn87kNh4lqRINUzilFh9IqhVh
	 dX1yAlP6iKyHtIiZ7HeMDKA2KE+NFBsJoD2DjOeWqytf5i7Y5QlrVYgS2VfWGldoyG
	 d1W5UnoBh93oLzNVXcMG70MBDuvItJN4v0htbiyuNvXcuFAMp0EiqI21i5OMhyTF4H
	 sCBOJjl2GhTR6ev+/6g8TSXyeNu9nkEzedMyttmwyYS/dbcekq92fYOw3OYLSQErtc
	 WotFnCE/svv0noVKVPTYBm+Gsjarb0qPIBFLB/wAW46Snw+pYxLAfFQ7k8Wdb915aR
	 Y6t5GUA42lQwQ==
From: Chuck Lever <cel@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: <linux-nfs@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	Jeff Layton <jlayton@kernel.org>
Subject: [GIT PULL] First round of NFSD fixes for v6.16
Date: Sat, 21 Jun 2025 11:13:59 -0400
Message-ID: <20250621151359.499129-1-cel@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 425364dc49f050b6008b43408aa96d42105a9c1d:

  xdrgen: Fix code generated for counted arrays (2025-05-16 10:58:48 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.16-1

for you to fetch changes up to 94d10a4dba0bc482f2b01e39f06d5513d0f75742:

  sunrpc: handle SVC_GARBAGE during svc auth processing as auth error (2025-06-19 09:35:45 -0400)

----------------------------------------------------------------
nfsd-6.16 fixes:

- Two fixes for commits in the nfsd-6.16 merge
- One fix for the recently-added NFSD netlink facility
- One fix for a remote SunRPC crasher

----------------------------------------------------------------
Benjamin Coddington (1):
      SUNRPC: Cleanup/fix initial rq_pages allocation

Chuck Lever (1):
      NFSD: Avoid corruption of a referring call list

Jeff Layton (2):
      nfsd: use threads array as-is in netlink interface
      sunrpc: handle SVC_GARBAGE during svc auth processing as auth error

 fs/nfsd/nfs4callback.c |  1 +
 fs/nfsd/nfsctl.c       |  5 ++---
 net/sunrpc/svc.c       | 17 +++--------------
 3 files changed, 6 insertions(+), 17 deletions(-)

