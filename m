Return-Path: <linux-nfs+bounces-15125-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 312FABCD5D1
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Oct 2025 15:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 38F344E13DB
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Oct 2025 13:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1792F287271;
	Fri, 10 Oct 2025 13:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VTrAp+fy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66DF2F1FFE
	for <linux-nfs@vger.kernel.org>; Fri, 10 Oct 2025 13:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760104588; cv=none; b=eU3yNpyRvAQ4+pvu9DE6b9Cs7rTNLHblqLVe+Jq7TDCA1QC9ZFEGbdRJdWwLkMaqrlsa2m3b5Xr8bcgottacp9kz2cKT/MplxJ1dE6tHSZSO8JQfNQFoW5T06P60WC05Zf0PPv/ThBejDo8lrOZ+2iRvCJ3NRlJv1kt7yweq1gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760104588; c=relaxed/simple;
	bh=yf0uls24bF+iV40FJEcTng1Nl/SxdrfGDbRWjxd/Mqo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vzgzv1rBkh318eQsPtvxAeykUruWJ2xk1pJNQlsxjpAhIghCrPRJ4BSuGcEUyYuJdJE07BIUGpCWhRJuvrjPt4nTiyrJaZW2HQgzsa3aZV4HUFs0yz7hKO2juHiDZvb7gZcoKiZHJq34moIFwAKUE7p+yPC/zM0rKR6fXpQay3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VTrAp+fy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 708F2C4CEF1;
	Fri, 10 Oct 2025 13:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760104587;
	bh=yf0uls24bF+iV40FJEcTng1Nl/SxdrfGDbRWjxd/Mqo=;
	h=From:To:Cc:Subject:Date:From;
	b=VTrAp+fyUqg1np5yySXifU5YtUxItJKnw9RKIjzT7tcRPSlesi7jDB3B/jW8JbXDk
	 pHXxFdzS9doqmVw0Nlo/k5ubNbcWhs6NeNtNeh8H3TvlaS2Gmyym0UcdEDolIl+BjN
	 HSmc6m8ehL0yIVDvD/ipz0BfizpEeQLsiDLvhJhIBPpmbmai3V/B1zgqnYLJmcoXKa
	 Qjpe/+3hMeUpE+z47/pCGKEX63wBtlT29+sOtIND740ccdco3GNYpg+QjVXqXM4TvI
	 owEahc0YRaJJqyanXih+0pLooDhVseGNjWDiQNQflycPrwy5rTfh4mkVKzg5K8xUzV
	 vo+P7jd0QF5OQ==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v3 0/5] Fix unwanted memory overwrites
Date: Fri, 10 Oct 2025 09:56:18 -0400
Message-ID: <20251010135623.1723-1-cel@kernel.org>
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

Changes since v2:
* Never cache a COMPOUND if SEQUENCE fails
* Enable caching of solo SEQUENCE operations again
* Reserve enough slot replay cache space to cache solo SEQUENCE

Changes since v1:
* Reordered patches
* Disable caching of solo SEQUENCE operations
* Additional clean up

Chuck Lever (5):
  NFSD: Skip close replay processing if XDR encoding fails
  NFSD: Fix the "is this a solo SEQUENCE" predicate
  nfsd: Never cache a COMPOUND when the SEQUENCE operation fails
  NFSD: Increase minimum size of slot replay cache
  NFSD: Move nfsd4_cache_this()

 fs/nfsd/nfs4state.c | 45 +++++++++++++++++++++++++++++++++++++++------
 fs/nfsd/nfs4xdr.c   |  3 +--
 fs/nfsd/xdr4.h      | 21 ---------------------
 3 files changed, 40 insertions(+), 29 deletions(-)

-- 
2.51.0


