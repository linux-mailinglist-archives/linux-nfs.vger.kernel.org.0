Return-Path: <linux-nfs+bounces-5633-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B8E95D4B4
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Aug 2024 19:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0A5D284F8F
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Aug 2024 17:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59A318BBB9;
	Fri, 23 Aug 2024 17:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pt0c5m3J"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FB11885B9
	for <linux-nfs@vger.kernel.org>; Fri, 23 Aug 2024 17:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724435447; cv=none; b=l83rQB6FtEZXWHonUN/vkofXc+0918uzSSfAWTP2VqljLWFFsb2UmGm80NGiHN6QN4k6EKbkeK6oO8CyqLFkPPfhT0Xl3Ph0bAbCCA+LoYCte8QtRRDR3/o9zvd7QQ8n2PM8+5A1sbsBTa88aoXRwXoz/+5j3pH9rYlBhXfPhp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724435447; c=relaxed/simple;
	bh=ZwjwY9KuYh4njuHB155ygLCBPl+4/Ve8DzNnVjagOvo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DCcPo/M/N1zF+HbkIKkeihJKJTaCgo1CkWAj2uIh76vps+EsHFQz2E9QKJj3HiSeq9XW6zJnqjJxF0YcXL4ZJhol6KuCf+Cf8sWjB8LJ97GVU7BWjN+EqsvxSvZ5LkU8mdGyf3Fcg1hkg2wNSdqOZpiBOOh4i2WsPIVz2vB7Iq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pt0c5m3J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADC6FC32786;
	Fri, 23 Aug 2024 17:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724435446;
	bh=ZwjwY9KuYh4njuHB155ygLCBPl+4/Ve8DzNnVjagOvo=;
	h=From:To:Cc:Subject:Date:From;
	b=Pt0c5m3Jei1nFY1GqokN2uLVm4PdO1/mToW9VJyawdQApKk7M6hf28A9bLMF6m13x
	 tZfKQBoNTWSle1GQDUhVmYd3bLcrfEiQ4pbAmi6ObJ9j76PnatZeEELUpBLZIEQU+U
	 D3E2zlQZwlELQKFjCnsv9b86vq4QExb7CYQfB/kTWlzo5E330r+iuQtLAu9vlo94lb
	 ceUiwmHxnwW9YBIW61xNq7dAkQvF1JscpZebOLxVDOZ46Ds0FUPQYGfZQq4nkyXf0Q
	 F8Zq7zN7Cx5Y+nscVgWiVnE8t1WP796rziddViRTgBR6TkyIqzIiHfZ4a19EMlvcme
	 M6vhTu6idtlAg==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	torvalds@linux-foundation.org
Cc: anna@kernel.org
Subject: [GIT PULL] Please pull NFS Client bugfixes for 6.11-rc
Date: Fri, 23 Aug 2024 13:50:44 -0400
Message-ID: <20240823175044.38868-1-anna@kernel.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

The following changes since commit 47ac09b91befbb6a235ab620c32af719f8208399:

  Linux 6.11-rc4 (2024-08-18 13:17:27 -0700)

are available in the Git repository at:

  git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-6.11-2

for you to fetch changes up to f92214e4c312f6ea9d78650cc6291d200f17abb6:

  NFS: Avoid unnecessary rescanning of the per-server delegation list (2024-08-22 17:01:10 -0400)

----------------------------------------------------------------
NFS Client Bugfixes for Linux 6.11-rc

Bugfixes:
* Fix rpcrdma refcounting in xa_alloc
* Fix rpcrdma usage of XA_FLAGS_ALLOC
* Fix requesting FATTR4_WORD2_OPEN_ARGUMENTS
* Fix attribute bitmap decoder to handle a 3rd word
* Add reschedule points when returning delegations to avoid soft lockups
* Fix clearing layout segments in layoutreturn
* Avoid unnecessary rescanning of the per-server delegation list

Thanks,
Anna

----------------------------------------------------------------
Chuck Lever (3):
      rpcrdma: Device kref is over-incremented on error from xa_alloc
      rpcrdma: Use XA_FLAGS_ALLOC instead of XA_FLAGS_ALLOC1
      rpcrdma: Trace connection registration and unregistration

Jeff Layton (2):
      nfs: fix the fetch of FATTR4_OPEN_ARGUMENTS
      nfs: fix bitmap decoder to handle a 3rd word

Trond Myklebust (3):
      NFSv4: Add missing rescheduling points in nfs_client_return_marked_delegations
      NFSv4: Fix clearing of layout segments in layoutreturn
      NFS: Avoid unnecessary rescanning of the per-server delegation list

 fs/nfs/callback_xdr.c           |  6 ++++--
 fs/nfs/delegation.c             | 15 +++++----------
 fs/nfs/nfs4proc.c               | 12 ++++++++----
 fs/nfs/pnfs.c                   |  5 ++---
 fs/nfs/super.c                  |  2 ++
 include/trace/events/rpcrdma.h  | 36 ++++++++++++++++++++++++++++++++++++
 net/sunrpc/xprtrdma/ib_client.c |  6 ++++--
 7 files changed, 61 insertions(+), 21 deletions(-)

