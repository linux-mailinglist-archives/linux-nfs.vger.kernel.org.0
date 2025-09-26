Return-Path: <linux-nfs+bounces-14738-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3BBBA44B0
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Sep 2025 16:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 644333A28E1
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Sep 2025 14:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE1FF1E25EB;
	Fri, 26 Sep 2025 14:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OBAt+53w"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C0A19E992
	for <linux-nfs@vger.kernel.org>; Fri, 26 Sep 2025 14:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758898313; cv=none; b=e1RqQzvu7Xxss/USzlVXHKT5eNQmD8mw1r3nT8PFI78OHqY/eH4/pGauJUMTxxK3FjVQy0QgcpmGj7K3SVX8bMDe5/FhCrSwluhizm7i7s7tyaiRJxGDyDnMMQErbNEFGtz/NH0xjTyOsbM+UcrJq5nrZwncEqV2VpvnLBs+b/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758898313; c=relaxed/simple;
	bh=kSENoX7a2YxxPMg1a9fn23SWD66H5TCmrPluuJoB2qM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QAx52TC1WfTC8UaEwohXo3i8RQ7u8REUBxdxkTlgoJeVkmraPHSB7NFXl05NqpvJUDFIlWl4E5LPUfiX999tgRd/WnKv2RIVmgM+YYgZnr8POVgMenuOwm+irfi9Ryo/MtYG6GyGcNGSiA+s4NpJxCqvPcAln1S4xjafltOdkGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OBAt+53w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3582C4CEF7;
	Fri, 26 Sep 2025 14:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758898313;
	bh=kSENoX7a2YxxPMg1a9fn23SWD66H5TCmrPluuJoB2qM=;
	h=From:To:Cc:Subject:Date:From;
	b=OBAt+53wA9x3CKWNCI4ebT23m94KX/qo60X48ZFjWZNAKx2it4pQUfiazvHXfh0vk
	 ICP2+0J1J/ys0ZfGXmZz6Guxfpcee+XrZOLK0QpIJU3cZ0gwQPqHY1gMGzNgOLV+MB
	 xlCGOaXuEoIo1hcxcJVHxVQ8fj/Rm6zlltYTQ3NB3MZCWFcjsyZMdcxZ+xo9FA/x/z
	 NAkbPmCBLDq3ZBLnr5au0UApMvafq5RAkm2pGiUrj7pmIGjzLXoXuEDAkqqXcEYkMX
	 Ud3AoeTj1+XpBAjUXcLXSd7cyInxZcoXlj3hLe8+JRdfjgdEVAOGrXZS0JZ3WHAUJS
	 7R79rBkp/jjvQ==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v4 0/4] NFSD direct I/O read
Date: Fri, 26 Sep 2025 10:51:47 -0400
Message-ID: <20250926145151.59941-1-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

The goal is to get the experimental read-side direct I/O
implementation merged sooner. We are still thinking through the
implications of mixing direct and buffered I/O when handling an
NFS WRITE that does not meet the dio alignment requirements.

Changes since v3:
* Move xdr_reserve_space_vec() call to preserve the page_len value
* Note that "add STATX_DIOALIGN and STATX_DIO_READ_ALIGN ..."
  remains exactly the same as it was in the v3 series

Changes since v2:
* "Add array bounds-checking..." has been applied to nfsd-testing
* Add a page_len check before committing to use direct I/O

Changes since v1:
* Harden the loop that constructs the I/O bvec
* Address review comments

Changes from Mike's v9:
* The LOC introduced by the feature has been reduced considerably.
* A new trace point in nfsd_file_getattr reports each file's dio
  alignment parameters when it is opened.
* The direct I/O path has been taken out-of-line so that it may
  continue to be modified and optimized without perturbing the more
  commonly-used I/O paths.
* When an exported file system does not implement direct I/O, more
  commonly-used modes are employed instead to avoid returning
  EOPNOTSUPP unexpectedly.
* When NFSD_IO_DIRECT is selected, NFS READs of all sizes use direct
  I/O to provide better experimental data about small I/O workloads.

Chuck Lever (2):
  NFSD: Relocate the xdr_reserve_space_vec() call site
  NFSD: Implement NFSD_IO_DIRECT for NFS READ

Mike Snitzer (2):
  NFSD: filecache: add STATX_DIOALIGN and STATX_DIO_READ_ALIGN support
  NFSD: pass nfsd_file to nfsd_iter_read()

 fs/nfsd/debugfs.c       |  2 +
 fs/nfsd/filecache.c     | 34 ++++++++++++++++
 fs/nfsd/filecache.h     |  4 ++
 fs/nfsd/nfs4xdr.c       | 28 +++++++++----
 fs/nfsd/nfsd.h          |  1 +
 fs/nfsd/nfsfh.c         |  4 ++
 fs/nfsd/trace.h         | 28 +++++++++++++
 fs/nfsd/vfs.c           | 89 +++++++++++++++++++++++++++++++++++++++--
 fs/nfsd/vfs.h           |  2 +-
 include/trace/misc/fs.h | 22 ++++++++++
 10 files changed, 202 insertions(+), 12 deletions(-)

-- 
2.51.0


