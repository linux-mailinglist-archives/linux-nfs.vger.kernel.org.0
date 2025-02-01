Return-Path: <linux-nfs+bounces-9816-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E041AA245F0
	for <lists+linux-nfs@lfdr.de>; Sat,  1 Feb 2025 01:34:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3703F7A33A0
	for <lists+linux-nfs@lfdr.de>; Sat,  1 Feb 2025 00:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8EFBA45;
	Sat,  1 Feb 2025 00:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EBwP6iix"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB6D625
	for <linux-nfs@vger.kernel.org>; Sat,  1 Feb 2025 00:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738370091; cv=none; b=umLzRMe0MUJSCkEajDYmXC/b4mUc1hl5IyopEAln9SbXHqtx048UlOsEBhPMw06ODwqpA2SYN7JDNxYbsCinv74AU1X70SoOdJYi6/uC+B5QtLUQ3sI0uPrxmiPnTwTbuCGyQRCiyTjPdL1VLpSv5cNUF5S8Kz8PLYXtRcg8gvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738370091; c=relaxed/simple;
	bh=v6bsj6Ftco54rPmSNc/Cj6BuIBt2oqM3rb2lpsZ3Vas=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fZ6uGccKdRcFu7P1JS/KtDzw20SU9yxePnuID5sdumg/PJEZFL0w5evnSiEgqzCKnlaubji7IVICWlRuvEqc6U9zt0Ia8y582e/aj5iiGoXAYGCwhmj1zIFzgf/sqD2/dZvenskQ0tk8zmKEPGU07jdZLkzDqWvBb4joZUhUBZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EBwP6iix; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECCE9C4CEE1;
	Sat,  1 Feb 2025 00:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738370090;
	bh=v6bsj6Ftco54rPmSNc/Cj6BuIBt2oqM3rb2lpsZ3Vas=;
	h=From:To:Cc:Subject:Date:From;
	b=EBwP6iixcfGSdg55KGYnMFWi9fWk8CGFzj6EsGVuc5BUbECCa9okPpn4YFaKKE6l5
	 UFPE/ZHpCQ9zQqIV7dsVTevavp9bg1eG2/mVHQF2ptcJP3TfBQRbueTZ+P+lPixUSr
	 PoYgPv9jUUU87QNZpBfaMBPTZ4NqI7DZSbl6fancR2bcSJng4x0KusOVQfRb5NH0a2
	 CzDj/v5UukE1Z5YGeOMp5aVxbOOYTNHzv0meLvuAlb9MsFSyZuvVJzs6EEHVTEksj5
	 JKZG7xzH3yHCqLkdcAA5pi1LteYxU6oTF9ePTb3uNcj2nyxm4sjuic/vNsgU0j/5DU
	 OyLfl+Io+6iZw==
From: cel@kernel.org
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v4 0/7] Client-side OFFLOAD_STATUS implementation
Date: Fri, 31 Jan 2025 19:34:40 -0500
Message-ID: <20250201003447.54614-1-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

SCSI implementation experience has shown that an interrupt-only
COPY offload implementation is not reliable. There are too many
common scenarios where the client can miss the completion interrupt
(in our case, this is an NFSv4.2 CB_OFFLOAD callback).

Therefore, a polling mechanism is needed. The NFSv4.2 protocol
provides one in the form of the its OFFLOAD_STATUS operation. Linux
NFSD implements OFFLOAD_STATUS already. This series adds a Linux NFS
client implementation of the OFFLOAD_STATUS operation that can query
the state of a background COPY on the server.

These patches are also available here:

https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/log/?h=fix-async-copy

Changes since v3:
- Change to fixed lease_time/2 timeout before posting OFFLOAD_STATUS
- Check if CB_OFFLOAD arrived if OFFLOAD_STATUS returned BAD_STATEID
- Added Olga's R-b and T-b tags

Chuck Lever (7):
  NFS: CB_OFFLOAD can return NFS4ERR_DELAY
  NFS: Fix typo in OFFLOAD_CANCEL comment
  NFS: Rename struct nfs4_offloadcancel_data
  NFS: Implement NFSv4.2's OFFLOAD_STATUS XDR
  NFS: Implement NFSv4.2's OFFLOAD_STATUS operation
  NFS: Use NFSv4.2's OFFLOAD_STATUS operation
  NFS: Refactor trace_nfs4_offload_cancel

 fs/nfs/callback_proc.c    |   2 +-
 fs/nfs/nfs42proc.c        | 195 ++++++++++++++++++++++++++++++++++----
 fs/nfs/nfs42xdr.c         |  88 ++++++++++++++++-
 fs/nfs/nfs4proc.c         |   3 +-
 fs/nfs/nfs4trace.h        |  11 ++-
 fs/nfs/nfs4xdr.c          |   1 +
 include/linux/nfs4.h      |   1 +
 include/linux/nfs_fs_sb.h |   1 +
 include/linux/nfs_xdr.h   |   5 +-
 9 files changed, 282 insertions(+), 25 deletions(-)

-- 
2.47.0


