Return-Path: <linux-nfs+bounces-1698-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E263846099
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Feb 2024 20:06:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFE7A1C22BDD
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Feb 2024 19:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73D884FD3;
	Thu,  1 Feb 2024 19:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MDAgIvnu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD17F85295;
	Thu,  1 Feb 2024 19:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706814396; cv=none; b=lRL9u3AFavAMt9BSeJWzGrg44GtdPhhLv+s1OpmIoZ5Zukugemq6kyxtdbaZLS874rdrAjrtJa6fXLfDQBwddTRvhluMTclaSsH7GbbFPpK+ACOXLs9NhV7YxniFunc8yNHR9auEZqbcBRGjjF5OmCGzWQKI5Mct+BfKgslTNg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706814396; c=relaxed/simple;
	bh=wnc9bmosc7RUlgmTf3N5MnGMp05RMGlKXfMbTLj0MxE=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=ORIh3ioJ7y2J8+LxIbLunzwLkScTZcH5iT1JjxuiRg1wvWvCUzbFx0HyvT9kqtJuDWsnKK3GqjpYxWOwI0ojuRZFsoyLgaTOC6nqTPjTvuT1GdPY7qIKzM9eqXrkV4q49a7TX0XVEcIrmJ6QVNgwkQsOcpf0zreQswfBV6IGrSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MDAgIvnu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FB4CC433C7;
	Thu,  1 Feb 2024 19:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706814396;
	bh=wnc9bmosc7RUlgmTf3N5MnGMp05RMGlKXfMbTLj0MxE=;
	h=Subject:From:To:Cc:Date:From;
	b=MDAgIvnubXUu66pIxxA0Gzi94BUMDq+B5OfvmVl7ER/RrWdJSDPE6VfPMGOx5szYZ
	 axcARczbbJaEKC3rUky+PSOFIPvTrXVCxZavBdtBaXPvj4XPuJlESl1Ag77oUMU9U0
	 e1zwLEPlyiCJpwRHyzexjJAPO5oDKvUVpibdBCWoiHhca23BOuyHpPdn2B+S25qgLc
	 HGoGU+PSgDxpb4XG4elEUVgrh5f3bmuRzez0oT5Lsy+BVkmSEDemBaXq/MoKBXzEnP
	 O+v6EOJiHe1RvM4VUvmwkFeqj0Od2WKcawbRY+u7/56i6wzZd/hyM0LQP1mdxmjmJ8
	 ZlstaW4V7Vtbg==
Subject: [PATCH 0/3] Fix RELEASE_LOCKOWNER
From: Chuck Lever <cel@kernel.org>
To: stable@vger.kernel.org
Cc: linux-nfs@vger.kernel.org
Date: Thu, 01 Feb 2024 14:06:35 -0500
Message-ID: 
 <170681433624.15250.5881267576986350500.stgit@klimt.1015granger.net>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Passes pynfs, fstests, and the git regression suite. Please apply
these to origin/linux-5.4.y.

---

Chuck Lever (2):
      NFSD: Modernize nfsd4_release_lockowner()
      NFSD: Add documenting comment for nfsd4_release_lockowner()

NeilBrown (1):
      nfsd: fix RELEASE_LOCKOWNER


 fs/nfsd/nfs4state.c | 65 +++++++++++++++++++++++++--------------------
 1 file changed, 36 insertions(+), 29 deletions(-)

--
Chuck Lever


