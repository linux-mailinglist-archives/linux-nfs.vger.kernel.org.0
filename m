Return-Path: <linux-nfs+bounces-6769-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B11398C6D8
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Oct 2024 22:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 398641F24EBB
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Oct 2024 20:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22EF82B9A5;
	Tue,  1 Oct 2024 20:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="niRl2Rqv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F190829A1
	for <linux-nfs@vger.kernel.org>; Tue,  1 Oct 2024 20:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727814837; cv=none; b=orLh/2xFCqGSevPpjNyxuhGDRgO/G5nBoOpyTNFp0mkOQeYMTFFE6RyICDA0WtjD041YW+v4k5OuoZ3t39qBPT2T05JLRuLpTNUOKCER/zDRGowTLkih19Imk1XZ3rydnqLhlCqx4QhCwc0VnIa8j3TECa1UbihO+nwL9nLcQc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727814837; c=relaxed/simple;
	bh=JiS271nMFVTx+D5ttBODGpmtgiX1vOQ+WNwMnZwrGPw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q3PvwZ4BzFrUrCiShacZjxnjIis10NzXxdHYdMm7mjlB6wU4ahZFheajpxAzEN8QuPSbA5imyhcyRT2a+hbkfAF7uCUFndKGYH6IEYxH7Vpd7bQ7Y1eDJCCUMTMt7+hbyGya55YL6fatvWpQaFgJyeu+HQzLPTcych8TXTeEUx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=niRl2Rqv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A7F2C4CEC6;
	Tue,  1 Oct 2024 20:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727814836;
	bh=JiS271nMFVTx+D5ttBODGpmtgiX1vOQ+WNwMnZwrGPw=;
	h=From:To:Cc:Subject:Date:From;
	b=niRl2RqvRTI8F8olLJUKuSQY061KGVI9BBz953REqEVND60ka9JmTAmNKzK/I9ad/
	 YUmLl6qt27QCuOFdhF4Sgst6bdWIecVGd0m3v92aTZIi1gilPedU9xNL249TVhLzlx
	 HsEjOcZwLGNRjXOt8yJKAEUFvWpcoanAlKARClyYpHY/MbRO5PGhPBToPBI2p8cdAA
	 R5TEZ5mso6Y4Vac08s4hife/AqjkOGYUgHhQqelr2/5qZ7aVgnb+3QdhcNmf55QDq9
	 ifCHmfdRSIIN0Hr4yCDUd7o9i0WBRe49RMHWenzhuN+my3WgurpNuiSLs6xml56Hkh
	 l8BtDbfDmk76A==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	trond.myklebust@hammerspace.com
Cc: anna@kernel.org
Subject: [PATCH 0/5] NFS: Clean up NFS version module loading
Date: Tue,  1 Oct 2024 16:33:39 -0400
Message-ID: <20241001203344.327044-1-anna@kernel.org>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anna Schumaker <anna.schumaker@oracle.com>

I noticed that I initally coded this to use a linked list instead of
an array. This adds a lot of extra "search the list" work that we don't
need to do since we'll always know the (integer) NFS version number that
we are looking for.

While I'm here, I cleaned up the locking to use a reader-write lock
matching how the VFS does things. I also renamed get_nfs_version() to
find_nfs_version(), and implemented a new get_nfs_version() that
abstracts out taking the module reference and acts as the opposite of
put_nfs_version()

Anna


Anna Schumaker (5):
  NFS: Clean up locking the nfs_versions list
  NFS: Convert the NFS module list into an array
  NFS: Rename get_nfs_version() -> find_nfs_version()
  NFS: Clean up find_nfs_version()
  NFS: Implement get_nfs_version()

 fs/nfs/client.c     | 64 ++++++++++++++++++++++++---------------------
 fs/nfs/fs_context.c |  6 ++---
 fs/nfs/namespace.c  |  2 +-
 fs/nfs/nfs.h        |  4 +--
 4 files changed, 40 insertions(+), 36 deletions(-)

2.46.2


