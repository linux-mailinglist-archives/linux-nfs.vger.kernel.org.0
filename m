Return-Path: <linux-nfs+bounces-17660-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A44ED05C97
	for <lists+linux-nfs@lfdr.de>; Thu, 08 Jan 2026 20:19:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5CB663003F74
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Jan 2026 19:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C5320E6E2;
	Thu,  8 Jan 2026 19:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fBKex1JT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5409C50094A;
	Thu,  8 Jan 2026 19:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767899406; cv=none; b=qvyumefNtPzAQ8NNZWC40c5WVSXj6SghTroIiVyUEDdf+Ay+QWXv7eeDUKlY2Yk74N0oDN0mQ/QKbfC4OGHGGPgzDs19sWwq/kxNS++T6K/DV9EgWeKOvyMRWHUNHxXPFhiqO5WydsEKcf/5N8J6pSRaX1AF1zLiYEdU9o8t++E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767899406; c=relaxed/simple;
	bh=b38lD8LfPD6nstdVsKEkIhMRzhFb0NEoGI++fFr8Z2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q12MpkYh41pL37O+QMHRXet+sXe0NdvsYFfY7lfxl6uXL3JTObi74GwlT3F0SshzCiFjUNigiWExSoo8YsgRVzoEuEm98ysJPbU39U7ltQnhYVIId2tkzbKrKptmYpZB2qcPUs4bgye1cH+86s6ebvXFBcWQVJP1XDPPOjCcsQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fBKex1JT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64D2CC116C6;
	Thu,  8 Jan 2026 19:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767899405;
	bh=b38lD8LfPD6nstdVsKEkIhMRzhFb0NEoGI++fFr8Z2k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fBKex1JTTmKaZ4Fog4Qo2tTxzhUIEUECVFMmCMdU1/l46dUq2IXTt3TOCyk1jmOhB
	 lh7HsnEeP47T/0wyrHL8pUMLYB7izcH6HQLNHxmYFvIjUqrhTyOM1z2NrjuOH0H0Ip
	 CYNx75zqcxtleI03a7NmoaQxpacbBFqVbl7pfwVZSbOmXCiyNz6bkd7nfoctTvdwxL
	 5WzIsaQpWy0+Sev/yDCAKEjYsVvussDCg7G9n6OCmvirjrWwWm9mY9txsGkD7QhAWT
	 VeF0FEhaUbMb5qN4SdFHHshuh8Q8GyBjazVlctI6/KDjlXzVT5SjOcyiHSP+ODocUa
	 cYYFSnMF2E+4A==
From: Chuck Lever <cel@kernel.org>
To: <stable@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	<linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 6.6.y v2 0/4] NFSD: NFSv4 file creation neglects setting ACL
Date: Thu,  8 Jan 2026 14:09:58 -0500
Message-ID: <20260108191002.4071603-1-cel@kernel.org>
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

 fs/nfsd/blocklayout.c |  4 +++-
 fs/nfsd/nfs3proc.c    | 10 ++++++----
 fs/nfsd/nfs3xdr.c     |  5 +----
 fs/nfsd/nfs4proc.c    | 11 +++++------
 fs/nfsd/nfs4state.c   |  2 +-
 fs/nfsd/nfsctl.c      |  2 +-
 fs/nfsd/nfsproc.c     |  6 +++---
 fs/nfsd/vfs.c         | 22 ++++++++++++++--------
 fs/nfsd/vfs.h         | 11 ++++++++++-
 fs/nfsd/xdr3.h        |  2 +-
 10 files changed, 45 insertions(+), 30 deletions(-)

-- 
2.52.0


