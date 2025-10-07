Return-Path: <linux-nfs+bounces-15023-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84AE4BC2077
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Oct 2025 18:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76C9D19A2F25
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Oct 2025 16:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02A32E7177;
	Tue,  7 Oct 2025 16:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RNqzh8Ax"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9852E6CD8
	for <linux-nfs@vger.kernel.org>; Tue,  7 Oct 2025 16:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759853057; cv=none; b=ESw8+3BYUKYvhY+r+/6bFoM9IAdzCWqbC2P1pUsfEUKMfYD+73Y1Wt2GXkbmDFbtsMluC2oR5XrkvyJjm/n0JeQwQuixNW3aqd6/a+GyTPKdljUuUGpuoe8SC8eWZKipK0rpIPsyAIRNguedHb5iJj96tWWUaz5ykG8cfbt/tBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759853057; c=relaxed/simple;
	bh=RAbjW6v0WlmSkJrpboq+pin8USUbznaHPSbDQ/bwBDE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k4E49VUbPo8H3jxj5u0v/BNBSeS3d581DCXuAnq/XZz5gzeV8bULJ0yY2BPM8RAudBAS4qfQfk1C33wxbSYG/uogNH62vEP5bessezckNe3f8IO4pdzrDYByQV3UMi8KdpwDR6N3CeJx01wbjqr6LQ6d7acxm43gacAAb2ecnlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RNqzh8Ax; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65C70C4CEF1;
	Tue,  7 Oct 2025 16:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759853057;
	bh=RAbjW6v0WlmSkJrpboq+pin8USUbznaHPSbDQ/bwBDE=;
	h=From:To:Cc:Subject:Date:From;
	b=RNqzh8AxHxK/RqP6YqWVy2OZg7CJ5ixsMF26nXUxpxa2ECU5/j62XkY3I/gd1cZrq
	 76y36X38jobEpe4qbM5eadEVhgTN2+MZ5N3WVYtYKfkTWOVt6k171vqKZwXF8KGcuQ
	 6iWlv1wu4cq5O/HaUAWrqTg5nIt0x/Yb3baPPRNB7+1t//aTq2yZL81I2pmwLYSltX
	 lOCZT1IGNmAsUk2SC+n1DSMWe+/ySAnOGCAfjs52TOvf/ZKf0+CPtSl6aHl+7AiBoL
	 R02UPlaaNSj1x6eV0B7uEBifbU9Krrwy3Gg+Nl2iG1mXh8Ap4iHG+v6lUmJ9LmzDFH
	 UyQFfJa3CIOjQ==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 0/4] Fix unwanted memory overwrites
Date: Tue,  7 Oct 2025 12:04:09 -0400
Message-ID: <20251007160413.4953-1-cel@kernel.org>
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
deficiency in the NFSv4.1 protocol. However, the predicate that
identifies solo SEQUENCE operations was incorrect.

Changes since v1:
* Reordered patches
* Disable caching of solo SEQUENCE operations
* Additional clean up

Chuck Lever (4):
  NFSD: Skip close replay processing if XDR encoding fails
  NFSD: Fix the "is this a solo SEQUENCE" predicate
  NFSD: Do not cache solo SEQUENCE operations
  NFSD: Move nfsd4_cache_this()

 fs/nfsd/nfs4state.c | 23 +++++++++++++++++++++++
 fs/nfsd/nfs4xdr.c   |  3 +--
 fs/nfsd/xdr4.h      | 21 ---------------------
 3 files changed, 24 insertions(+), 23 deletions(-)

-- 
2.51.0


