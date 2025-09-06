Return-Path: <linux-nfs+bounces-14096-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D6DAB474E1
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Sep 2025 18:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05AB85849BF
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Sep 2025 16:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847C52550A4;
	Sat,  6 Sep 2025 16:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KIFJcBol"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60292254B1B
	for <linux-nfs@vger.kernel.org>; Sat,  6 Sep 2025 16:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757176939; cv=none; b=FugxnyeoH/uBJO5fhvr/YO0SZHMDZBBuh6Nosq42Wq6xuVPvb39TpyEz9SwKTcWh0nLK97pc1DPPpYi9yIbhURsp/Yyzm+sxvJ8WZSs50J3RovqSlsD9GjbA0vSHLcaCQJM9GS4jNg4KCaYsSv+NfYonjWSGrpCZLp2FuAospwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757176939; c=relaxed/simple;
	bh=rx6M1bEt+vRGahb815Cf/HAsMo6cqVxkt/I8Omotjbc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=er/ktuPKSfqIhIsO1mkq5+9hQ8XeI2cZF0cuduNP59fNv39Ss66tzniycfyctCK+XiG3ilKpFYidUlUkKkuHeQcgQ/QD3MsKq6yDR/0tBUSrTLoV5gBxJK/MkVvHCBlslDA8pKXxsbAoHiXe3nsCz7cYbxoA6e0s8RA8hILZzW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KIFJcBol; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AED57C4CEE7
	for <linux-nfs@vger.kernel.org>; Sat,  6 Sep 2025 16:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757176938;
	bh=rx6M1bEt+vRGahb815Cf/HAsMo6cqVxkt/I8Omotjbc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=KIFJcBolFxq2KfklqchWGiYsfA1zYOZJJd0C3TXtn40ejNrSCcro6Duq3f/1b3tBk
	 JE9h8hBOYa9Www647BM1YrLUN2hnkX1BGL6Em8Ec4S+kwdMuzhkLcgB39X8OOs72QF
	 A91u/fwO4qA96B8X4k5q0z3PbjFfUYndQpOdAEaM7KmjfowpjHNZiIRUqAm9zTKi7S
	 drbvUoe0ySahc2Xkfskc5DDzUrBPj5mfpA3TnGLeKSEfbPvV2v18+IWhOXk91K0hmR
	 lPxzB3KDM8FzOnQByyK2QjmZCsmWz6fXrD6Cef0OMi0/MXGqKA2iYdRrCRiM1sMxzb
	 RcCK23jPMu4fg==
From: Trond Myklebust <trondmy@kernel.org>
To: linux-nfs@vger.kernel.org
Subject: [PATCH v2 0/8] Assortment of I/O fixes for the NFS client
Date: Sat,  6 Sep 2025 12:42:08 -0400
Message-ID: <cover.1757176392.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1757100278.git.trond.myklebust@hammerspace.com>
References: <cover.1757100278.git.trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

The following patch series addresses a series of issues that affect the
NFS client's I/O path. The first patch is needed to fix a corner case
when using mmap() to map the tail end of the file into memory, and then
later extending the file length (see recent xfstests generic/363).
The second set is used to ensure correct ordering of O_DIRECT operations
with truncate + fallocate.
Finally, there are fixes to ensure folio invalidation is correct w.r.t.
the VFS documentation, and a cleanup of the code that decides when a
folio can be marked as up to date.

v2:
 - Fix an off by one issue in nfs_write_begin()
 - Address eof page pollution on copy offload and clone range (Thanks, Olga!)
 - Address O_DIRECT ordering w.r.t. copy offload and clone range

Trond Myklebust (8):
  NFS: Protect against 'eof page pollution'
  NFSv4.2: Protect copy offload and clone against 'eof page pollution'
  NFS: Serialise O_DIRECT i/o and truncate()
  NFSv4.2: Serialise O_DIRECT i/o and fallocate()
  NFSv4.2: Serialise O_DIRECT i/o and clone range
  NFSv4.2: Serialise O_DIRECT i/o and copy range
  NFS: nfs_invalidate_folio() must observe the offset and size arguments
  NFS: Fix the marking of the folio as up to date

 fs/nfs/file.c      | 40 +++++++++++++++++++++++++++++++---
 fs/nfs/inode.c     | 13 +++++++++---
 fs/nfs/internal.h  | 12 +++++++++++
 fs/nfs/io.c        | 13 ++----------
 fs/nfs/nfs42proc.c | 35 ++++++++++++++++++++++--------
 fs/nfs/nfs4file.c  |  2 ++
 fs/nfs/nfstrace.h  |  1 +
 fs/nfs/write.c     | 53 ++++++----------------------------------------
 8 files changed, 96 insertions(+), 73 deletions(-)

-- 
2.51.0


