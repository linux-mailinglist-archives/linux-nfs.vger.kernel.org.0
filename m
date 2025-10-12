Return-Path: <linux-nfs+bounces-15156-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AD122BD083E
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Oct 2025 19:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5A3153472CC
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Oct 2025 17:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7512EC0A6;
	Sun, 12 Oct 2025 17:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UgxMZ696"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA122594BD
	for <linux-nfs@vger.kernel.org>; Sun, 12 Oct 2025 17:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760288870; cv=none; b=cbUG5CWCp8DvtPEbhhCUmCj8hr4FKQaklsitz7QpyShWBEfH9aGb1KxcvwfFJRKAJ9+9La+K23t2qveA/jJ0DfF+VyUfBMNTEFyNKcWcnxyyfDi1Vv2qvh8tszAQrez1e3FqJ6YL6TALDFo+GhXvtNvYZw1BbcnBLMnQtEIFEfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760288870; c=relaxed/simple;
	bh=At0ioV4CdPBpbxn2KTERTh4BzMbefs2N94X91048P7U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o15OSW5uEiYdO1e/X2v4Pbmm2D9WDGsJjE6ajx35bpzKcqCmA1NNBZNwgRGfdLwmTX1+41ju6Qk6+ISQ5078pXY+3Gd/+523ng0V0JAoV3iGoXkymtZe3J4qBuau8HowdJFbl2KA+gjafAJfqiKMpPJMmTVtT4U8En3DFHCe6/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UgxMZ696; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D417AC4CEE7;
	Sun, 12 Oct 2025 17:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760288869;
	bh=At0ioV4CdPBpbxn2KTERTh4BzMbefs2N94X91048P7U=;
	h=From:To:Cc:Subject:Date:From;
	b=UgxMZ696Z6Mz09mLybc6oOO3fN3QgkioNeup4lQMdoGd7Vc1lG3DkFOV0Fq99EVvz
	 zM92Cz9jCj74rh0nNPaibfdpEoNuAE+bksJK9IbF+ntPv7Ehjd3INEiSXhbFeC48YV
	 SjwKP4ViRHVUoDsudGqb27Rq+nLKj4rdp7VfNnB26EbUiYX5v86prfnmfAQbV4qjpB
	 nbCd2zuIpSQ1Eky1zJWlgy0QadpCRZYO+0gCKaoU768747ISbsKLE5tMoufX79y7uZ
	 asovCWa2I/tuGp0dPeVer/JSVXlObBQkA7LJub4yhO6FF5Ky5T0xenI5At6fS8bkPL
	 6WEIsXf4PjGbw==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v4 0/4] Fix unwanted memory overwrites
Date: Sun, 12 Oct 2025 13:07:42 -0400
Message-ID: <20251012170746.9381-1-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

<rtm@csail.mit.edu> reported some memory overwrites that can be
triggered by NFS client input. I was able to observe overwrites
by enabling KASAN and running his reproducer [1].

NFSD caches COMPOUNDs containing only a single SEQUENCE operation
whether the client requests it to or not, in order to work around a
quirk in the NFSv4.1 protocol. However, the predicate that
identifies solo SEQUENCE operations was incorrect.

Changes since v3:
* Neil observes that in this code path, SEQUENCE always the first op
* Expanding the size of the replay cache buffer is unnecessary
* Reordered and simplified the remaining patches
* Haven't yet addressed imbalanced maxresponsesize values

Changes since v2:
* Never cache a COMPOUND if SEQUENCE fails
* Enable caching of solo SEQUENCE operations again
* Reserve enough slot replay cache space to cache solo SEQUENCE

Changes since v1:
* Reordered patches
* Disable caching of solo SEQUENCE operations
* Additional clean up

Chuck Lever (4):
  NFSD: Skip close replay processing if XDR encoding fails
  NFSD: Never cache a COMPOUND when the SEQUENCE operation fails
  NFSD: Fix the "is this a solo SEQUENCE" predicate
  NFSD: Move nfsd4_cache_this()

 fs/nfsd/nfs4state.c | 37 ++++++++++++++++++++++++++++++++++++-
 fs/nfsd/nfs4xdr.c   |  3 +--
 fs/nfsd/xdr4.h      | 21 ---------------------
 3 files changed, 37 insertions(+), 24 deletions(-)

-- 
2.51.0


