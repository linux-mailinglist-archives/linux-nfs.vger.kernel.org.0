Return-Path: <linux-nfs+bounces-15584-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23BF5C06BF9
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Oct 2025 16:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3DF33ABE7C
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Oct 2025 14:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB71319615;
	Fri, 24 Oct 2025 14:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cCayal0q"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B74C1E0083
	for <linux-nfs@vger.kernel.org>; Fri, 24 Oct 2025 14:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761316990; cv=none; b=mB5dyg+B6CEdXlh6Iu7A+M6NFaRn68hmAYzj0k20NsyVKr3hJ8SOUaPjrGP2tDBOJgMMqd+x90UTD9KHAyO9OHNsPlmYsstQ18ICVAqMjpsj+ywdV1cDIG1rIpEXsRLmnanLCF+BLk8VHad7ZxSnF0M0s65Gnnnkh63Be597HPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761316990; c=relaxed/simple;
	bh=4PCrh4E2nyax8paCAUJBnkVAXD2JgmvKlmSmEFx2WYo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eIYtd69KF/VLmjOiZUtv0E0lLkzMkMVXC9pNAEzcSxKffUauCuptVG90+q0hj/QedvkQWMcdKrvmxtwjR2MpfD6vMeuGFF1r1/+o9+440TAczHRj/WaheQRQxu4I3sHRIGXs83VaJUEe/9PHZMzfGeQCdD37VCNuUDKuLZMgRy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cCayal0q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 695B0C4CEF1;
	Fri, 24 Oct 2025 14:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761316989;
	bh=4PCrh4E2nyax8paCAUJBnkVAXD2JgmvKlmSmEFx2WYo=;
	h=From:To:Cc:Subject:Date:From;
	b=cCayal0qqZmiJt5olD/7QP21+h6e6gsANEbAlJVQH/Fpdm9CtOcqyJdKd/Tl32aaR
	 pNHQqGzPvC1jLWLkoRTJVR0s7JBWyP4RgOj7jFC8sT8xwhwHE/Vdy/Ezp35Jah7grK
	 N8f4ueUurOd7MXIAoxqNibXqGu9vch3tdqqmVC2i2XVoiRDyUR7lP1W5KPj/gbVybH
	 Tm8RPq+B7Q4C0eFWxexX27W6O2X/PpXT3fjkzf5G7smu95KsNTqzJ9KksQXZm4expM
	 4DQcaBkPpyG2Tda1p4OagrBdo6ZGvF3WgZqT5MoyTnixEnXFZaiMFaD3kwL1KGwXxp
	 QX1Z+UGcAbj/w==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v7 00/14] NFSD: Implement NFSD_IO_DIRECT for NFS WRITE
Date: Fri, 24 Oct 2025 10:42:52 -0400
Message-ID: <20251024144306.35652-1-cel@kernel.org>
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
work.

Since the review comments have resulted in many changes, I've split
out these modifications into individual patches so that everyone can
easily follow my work. They can then be rejected, modified again,
squashed, or retained as separate patches, as we see fit.

I'm thinking that an additional simplification could be done if fall
back was handled completely inline: just never set the "use_dio"
boolean on any of the request's buffer segments.

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

Chuck Lever (12):
  NFSD: Make FILE_SYNC WRITEs comply with spec
  NFSD: Enable return of an updated stable_how to NFS clients
  NFSD: @stable for direct writes is always NFS_FILE_SYNC
  NFSD: Always set IOCB_SYNC in direct write path
  NFSD: Remove specific error handling
  NFSD: Remove alignment size checking
  NFSD: Remove the len_mask check
  NFSD: Clean up synopsis of nfsd_iov_iter_aligned_bvec()
  NFSD: Clean up struct nfsd_write_dio
  NFSD: Introduce struct nfsd_write_dio_seg
  NFSD: Clean up direct write fall back error flow
  NFSD: Initialize separate ki_flags

Mike Snitzer (2):
  NFSD: Refactor nfsd_vfs_write()
  NFSD: Implement NFSD_IO_DIRECT for NFS WRITE

 fs/nfsd/debugfs.c  |   1 +
 fs/nfsd/nfs3proc.c |   2 +-
 fs/nfsd/nfs4proc.c |   2 +-
 fs/nfsd/nfsproc.c  |   3 +-
 fs/nfsd/trace.h    |   1 +
 fs/nfsd/vfs.c      | 213 ++++++++++++++++++++++++++++++++++++++++++---
 fs/nfsd/vfs.h      |   6 +-
 fs/nfsd/xdr3.h     |   2 +-
 8 files changed, 212 insertions(+), 18 deletions(-)

-- 
2.51.0


