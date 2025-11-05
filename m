Return-Path: <linux-nfs+bounces-16083-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 03689C37792
	for <lists+linux-nfs@lfdr.de>; Wed, 05 Nov 2025 20:28:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E61BD4E03CF
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Nov 2025 19:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E3930F81F;
	Wed,  5 Nov 2025 19:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZpKuGXUT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A50429B783
	for <linux-nfs@vger.kernel.org>; Wed,  5 Nov 2025 19:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762370890; cv=none; b=Nmu3wjJgGd/T7PNL14xbTnY+jzTPAN1qfK8UBcrW/J3Ii3IF8XlJzfoIoeZO6+pSA4DIOk01Dzudk5IP3eYIpiA7GHIXF547s8WuYPB/Sx25znnvSJWroQFDfT0mFxIYi2Kt+NjJ3FE9OwDyTRDzBBYsMAU6RWNRUSV8fihmKFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762370890; c=relaxed/simple;
	bh=MBTE+uhm64VGQtP5bLhpDJDESEOTduI2kC0ChnExKtU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JZAo+Rxd2kjx53GrPzyASDUKFUhJlzDP1sTdqJQe7QN0kP0j91BZX4WNGyvLzh/NeaRQZe/bKhHNm8kbWHJgGKF2BSRS96V8bLpeQu7T96jziJe3MLdP/Erpx0c7QVg856x0yMh9eDqkx4iZcKapaYonyhDZJ3B9eY6V+KaUybs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZpKuGXUT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F69DC19424;
	Wed,  5 Nov 2025 19:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762370889;
	bh=MBTE+uhm64VGQtP5bLhpDJDESEOTduI2kC0ChnExKtU=;
	h=From:To:Cc:Subject:Date:From;
	b=ZpKuGXUTEekr8q0bftdIydo4cbkKx0RKB5HInuvLjaUWOiywi1xhx5krEA+J6ircF
	 oJCY7krqNWAwJ4rBePv/X6LeP54oUECy+AUO63uDknNcDjD7SzgHUTeJZIcUP6IFMH
	 N7ATBmIAm+XbCZg9g55xm5c0YyFJuO/1nxkeWNxiH7CHPaukOU0fXgi1BcLaD11Mul
	 sCg4TQph4oGn0x15OBiKP5kEcwM8haDkbS6JJlva+4ZJ/iLcbiyuygcQBfeNicEKA5
	 P66dTzG0eoSVL/ZvBvqmTPV55VlCo//UBgxqSKqYVzl/EjHvdz5hhYO2GwRzs5RQpS
	 3Vd4WqGpclZFw==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v10 0/5] NFSD: Implement NFSD_IO_DIRECT for NFS WRITE
Date: Wed,  5 Nov 2025 14:28:01 -0500
Message-ID: <20251105192806.77093-1-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Following on https://lore.kernel.org/linux-nfs/aPAci7O_XK1ljaum@kernel.org/
this series includes the patches needed to make NFSD Direct WRITE
operational.

As requested by several reviewers, I've combined all the review
patches into a single patch. I've removed R-b's for the resulting
patches.

The series compiles and passes static analysis checks but still
needs functional and performance testing.


Changes since v9:
* Unaligned segments no longer use IOCB_DONTCACHE
* Squashed all review patches into Mike's initial patch
* Squashed Mike's documentation update into the final patch

Changes since v8:
* Drop "NFSD: Handle both offset and memory alignment for direct I/O"
* Include the Sep 3 version of the Documentation update

Changes since v7:
* Rebase the series on Mike's original v3 patch
* Address more review comments
* Optimize the "when can NFSD use IOCB_DIRECT" logic
* Revert the "always promote to FILE_SYNC" logic

Changes since v6:
* Patches to address review comments have been split out
* Refactored the iter initialization code

Changes since v5:
* Add a patch to make FILE_SYNC WRITEs persist timestamps
* Address some of Christoph's review comments
* The svcrdma patch has been dropped until we actually need it

Changes since v4:
* Split out refactoring nfsd_buffered_write() into a separate patch
* Expand patch description of 1/4
* Don't set IOCB_SYNC flag

Changes since v3:
* Address checkpatch.pl nits in 2/3
* Add an untested patch to mark ingress RDMA Read chunks

Chuck Lever (2):
  NFSD: Make FILE_SYNC WRITEs comply with spec
  NFSD: Enable return of an updated stable_how to NFS clients

Mike Snitzer (2):
  NFSD: Implement NFSD_IO_DIRECT for NFS WRITE
  NFSD: add Documentation/filesystems/nfs/nfsd-io-modes.rst

Olga Kornievskaia (1):
  NFSD: don't start nfsd if sv_permsocks is empty

 .../filesystems/nfs/nfsd-io-modes.rst         | 150 ++++++++++++++
 fs/nfsd/debugfs.c                             |   1 +
 fs/nfsd/nfs3proc.c                            |   2 +-
 fs/nfsd/nfs4proc.c                            |   2 +-
 fs/nfsd/nfsproc.c                             |   3 +-
 fs/nfsd/nfssvc.c                              |  28 +--
 fs/nfsd/trace.h                               |   1 +
 fs/nfsd/vfs.c                                 | 195 +++++++++++++++++-
 fs/nfsd/vfs.h                                 |   6 +-
 fs/nfsd/xdr3.h                                |   2 +-
 10 files changed, 350 insertions(+), 40 deletions(-)
 create mode 100644 Documentation/filesystems/nfs/nfsd-io-modes.rst

-- 
2.51.0


