Return-Path: <linux-nfs+bounces-17688-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9361FD0AAB3
	for <lists+linux-nfs@lfdr.de>; Fri, 09 Jan 2026 15:39:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0ECE6301D68A
	for <lists+linux-nfs@lfdr.de>; Fri,  9 Jan 2026 14:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4166E35CBDF;
	Fri,  9 Jan 2026 14:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZYPghKvu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E75F320A24;
	Fri,  9 Jan 2026 14:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767969589; cv=none; b=tdt8n8RZtVTJ7wYxY8aDF/VGAYUVJlW07FtaT7S1KFSCAn7H1ApT+gO2b894SrgYBfJiw5c73k3qTTEhU62MK4DCU/jIOOfwi9gJ5+zy3VJWtK24zYDJiwdOsSibXFZYWxtsLu32tH6xt2n+5Nrr9XipBSwcbah1f0RcNAyrx8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767969589; c=relaxed/simple;
	bh=lJy0/muq9IgSUqyMor6I7HDIsKq3tf3N75EdYor3cmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UyodJx9nh7ajxyhLe7t5BkztixIz0PJjPLW6V8dJ3TAIFHSpBpP5bR7r5W+vBNV7lP8wdiU4zhZ0x4Ygxg5DYeVgNRG3RO3ngTUZqCi63xqF6bWQLB6b59oP/ZAnumwJTBNYLJ1UiBUSi4dCISf/pKhOaSO8VnOXf1wnBMw3jYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZYPghKvu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CB9AC4CEF1;
	Fri,  9 Jan 2026 14:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767969588;
	bh=lJy0/muq9IgSUqyMor6I7HDIsKq3tf3N75EdYor3cmo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZYPghKvurwEUTI/TUeh9HrIr2fy2ju0AdywWgLK0ngHBTAyieNj5fvMi19sspih2f
	 PKc0i3YJHPdtlbN8SS6D00ftNeoKtjrhQmn9iFb/SW5lYmqmtJfUng4Q8gPRnLookq
	 1mjIODPoi9cYviO0W9h9tRtrP1dH1anPB7eRjmPxtdLjjenqLYZZvzvVuTEx+7Bfws
	 4bxxqH1VsUcfJ6Um6npnLDRVNfnv3qZvv/3Cd2C7cfvpbZlR80Nuvqzy5Vu6G/9H2o
	 eJh5f6t4tptnsowyrKob/DWN4CWBZlAHIy+ZPdyKuq/loYQlphWOpzlUH2XFKpmiNf
	 GVOIjtCy9hwrw==
From: Chuck Lever <cel@kernel.org>
To: <stable@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	<linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 6.6.y v3 0/4] NFSD: NFSv4 file creation neglects setting ACL
Date: Fri,  9 Jan 2026 09:39:42 -0500
Message-ID: <20260109143946.4173043-1-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <2025122941-civic-revered-b250@gregkh>
References: <2025122941-civic-revered-b250@gregkh>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

I received an automated report that patch "NFSD: NFSv4 file creation
neglects setting ACL" failed to apply to the 6.6-stable tree. This
series is my attempt to address that failure.

- First, applied several pre-requisite patches
- LLM agent review for possible regressions reported no issues
- CI testing reported no regressions

Changes since v2:
- Add a Signed-off-by to 1/4
- Address a build warning introduced in 1/4
- Fix the In-Reply-To header

Changes since v1:
- Replace 1/4 with the upstreamed version of that commit


Chuck Lever (1):
  NFSD: NFSv4 file creation neglects setting ACL

Jeff Layton (1):
  nfsd: convert to new timestamp accessors

Stephen Smalley (1):
  nfsd: set security label during create operations

Trond Myklebust (1):
  nfsd: Fix NFSv3 atomicity bugs in nfsd_setattr()

 fs/nfsd/blocklayout.c |  3 ++-
 fs/nfsd/nfs3proc.c    | 10 ++++++----
 fs/nfsd/nfs3xdr.c     |  5 +----
 fs/nfsd/nfs4proc.c    | 11 +++++------
 fs/nfsd/nfs4state.c   |  2 +-
 fs/nfsd/nfsctl.c      |  2 +-
 fs/nfsd/nfsproc.c     |  6 +++---
 fs/nfsd/vfs.c         | 22 ++++++++++++++--------
 fs/nfsd/vfs.h         | 11 ++++++++++-
 fs/nfsd/xdr3.h        |  2 +-
 10 files changed, 44 insertions(+), 30 deletions(-)

-- 
2.52.0


