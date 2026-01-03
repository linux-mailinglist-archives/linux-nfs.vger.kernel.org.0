Return-Path: <linux-nfs+bounces-17416-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F84CF050F
	for <lists+linux-nfs@lfdr.de>; Sat, 03 Jan 2026 20:39:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C0260300A364
	for <lists+linux-nfs@lfdr.de>; Sat,  3 Jan 2026 19:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F59423F42D;
	Sat,  3 Jan 2026 19:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RcoZjHy7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41DB1F4613;
	Sat,  3 Jan 2026 19:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767469151; cv=none; b=WhfpGx0C/1CbaGbdIAokAL6P13rhqFWnNM8EbmmgyrAN2jO2xDz4QOtJmxMRSiGvUvETCgrDnQ01Hf0JdX8rl6sRio2K6W8sBx1Km4dEsYGxLBN4KI3OJkGUvtZVyrPjvr3QrbMhcnwYT5/hsli8N2mwD3dxna08DOgBI08CWrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767469151; c=relaxed/simple;
	bh=xcffhuTpnXAK+nat1ZqFZ3PRCDPg6SoMveYDJvIECvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QGTMkTHRMN6qqearvL8CGxL8A4yvxz3UwMRsAUEUH+HC4kfqACtaeuNnMJqKf0gg8jdkk8fQLYp/wht39bZNdLFLMi4pw2MHlZ7KdmuR77kcO3DYUa2LxtZzfOkN1PD11X3ERij19AltVxD005zGykRCdV+HXO+vQgSSvTcNYGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RcoZjHy7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4808C113D0;
	Sat,  3 Jan 2026 19:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767469150;
	bh=xcffhuTpnXAK+nat1ZqFZ3PRCDPg6SoMveYDJvIECvs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RcoZjHy7uAoNlyz/Hc2KmEh5JvYp1bzoZBWlKDldM4jFh3jSzWmrykN6Oq9/JO/la
	 QFtBgGkOIKwz7lwdv4/0i/0HeCVvnzaLBn7Qu7bq3KmEn+qX/mf7FIcFiATB8JpGqc
	 g1+WVS6E6pgk8gfw1yk6u8lqZ1TO3Ej5jz1yaTkx3XbeL6lLGh1Cyp7p8xp17Ziybd
	 8W8iNLaNxIr/RW6zg0j7FLFazI+UTesLMnaMIDNiO3u4NnjrS3b//+2mgSnQj5TtPX
	 kcbfWVTx5A4Wde1vuzRpKSrwE/34hQZKE0lW0CWxU3EqQ/rr9CdagRfSl7nHtjpwsS
	 JQKnfu6cN19BA==
From: Chuck Lever <cel@kernel.org>
To: <stable@vger.kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 6.6.y 0/4] NFSD: NFSv4 file creation neglects setting ACL
Date: Sat,  3 Jan 2026 14:38:50 -0500
Message-ID: <20260103193854.2954342-1-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: 2025122941-civic-revered-b250@gregkh
References: 
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

Chuck Lever (4):
  nfsd: convert to new timestamp accessors
  nfsd: Fix NFSv3 atomicity bugs in nfsd_setattr()
  nfsd: set security label during create operations
  NFSD: NFSv4 file creation neglects setting ACL

 fs/nfsd/nfs3proc.c  | 10 ++++++----
 fs/nfsd/nfs3xdr.c   |  5 +----
 fs/nfsd/nfs4proc.c  | 11 +++++------
 fs/nfsd/nfs4state.c |  2 +-
 fs/nfsd/nfsctl.c    |  2 +-
 fs/nfsd/nfsproc.c   |  6 +++---
 fs/nfsd/vfs.c       | 22 ++++++++++++++--------
 fs/nfsd/vfs.h       | 11 ++++++++++-
 fs/nfsd/xdr3.h      |  2 +-
 9 files changed, 42 insertions(+), 29 deletions(-)

-- 
2.52.0


