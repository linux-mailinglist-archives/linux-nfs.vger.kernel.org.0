Return-Path: <linux-nfs+bounces-14083-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA205B463BA
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Sep 2025 21:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9207D1B214A6
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Sep 2025 19:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C4E278157;
	Fri,  5 Sep 2025 19:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yr/zlNlk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E95A272E51
	for <linux-nfs@vger.kernel.org>; Fri,  5 Sep 2025 19:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757100923; cv=none; b=t3Lq2jaHyR1fshUFSVHsqKQA5hBAcbVhKn5axQx/ePIbF1o+KLTqcb+h3pX641IMKlp/rudrTI6kV/InPRZjwpZ6+DxCDt/cMDLaZknQFwX86dhSnLglVbQQfuklDr5siMihnucypsaXWj/5AiLNZVXiU2sL3p4JHO3x+/S+mjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757100923; c=relaxed/simple;
	bh=eOC9wubcKMlgaIcGWnuDGeLJVQGnWkkV2EGuKEhmutI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=iO3hq6inDQUPPd5XT8KbMVHtH3TEliIve50nJK+IboKmOHqwgZo6hivvJqA1DtQU13Q7EFBV38f547HnO2UlauI3DgBzMw0PgyxiL7jehwT6r67JF2on8OeoUUPTrb19lGnUVo5mx56iv667PajMJ9F1F/JgQKqVFyPobXDVto8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yr/zlNlk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22945C4CEF1
	for <linux-nfs@vger.kernel.org>; Fri,  5 Sep 2025 19:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757100922;
	bh=eOC9wubcKMlgaIcGWnuDGeLJVQGnWkkV2EGuKEhmutI=;
	h=From:To:Subject:Date:From;
	b=Yr/zlNlknk2L4RfDu3Qaq12zRJxactmutyZ5GmgpVKEoP+USaGZCCJL57MoUvuA9+
	 QC0ndti/LdN1rrRFl3B3CA7pfJWkTOlvIvrj5Ti7b/lx+o0EEdWn+2N89SLTfZQ98v
	 2GUp+ilxkPpLiIKEiNNwWx1/38zc9DopqDbcL1p47HY9XZVdNasLGYAHYM0M98XrHX
	 BKfY0EAzFEH+rswR9ImlhvGgnQOSXcpgQvxr+AJrICfzlKgE258Z44bjr18kPlNAe4
	 ipCYeQrKF99H5KGwERUY0ALNsf0WMP8MBvOv3aXUYF82zXzowOtgqzoPln/jg0MPax
	 7htoJSFKl5cNw==
From: Trond Myklebust <trondmy@kernel.org>
To: linux-nfs@vger.kernel.org
Subject: [PATCH 0/5] Assortment of I/O fixes for the NFS client
Date: Fri,  5 Sep 2025 15:35:15 -0400
Message-ID: <cover.1757100278.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.51.0
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

Trond Myklebust (5):
  NFS: Protect against 'eof page pollution'
  NFS: Serialise O_DIRECT i/o and truncate()
  NFSv4.2: Serialise O_DIRECT i/o and fallocate()
  NFS: nfs_invalidate_folio() must observe the offset and size arguments
  NFS: Fix the marking of the folio as up to date

 fs/nfs/file.c      | 40 +++++++++++++++++++++++++++++++---
 fs/nfs/inode.c     | 13 +++++++++---
 fs/nfs/internal.h  | 12 +++++++++++
 fs/nfs/io.c        | 13 ++----------
 fs/nfs/nfs42proc.c | 15 ++++++++++---
 fs/nfs/nfstrace.h  |  1 +
 fs/nfs/write.c     | 53 ++++++----------------------------------------
 7 files changed, 80 insertions(+), 67 deletions(-)

-- 
2.51.0


