Return-Path: <linux-nfs+bounces-17963-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 92950D2856A
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Jan 2026 21:13:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E75B6300C9B6
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Jan 2026 20:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2335322C7F;
	Thu, 15 Jan 2026 20:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cehKwC0p"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA30322C6D;
	Thu, 15 Jan 2026 20:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768507998; cv=none; b=I4y+fNz13s7EnItEzuiD4oakoVaL5z2hPp+/UQ8IrVeW93GA1D3RZgV9doxE75M92+hriEfmfc06li/lO30cnS6t8Wmj32PwJD7Vu7yCU8AQR3QmdxiKpEFp7VOEEVInho8+l38FMCy8RgeJAf0tyDLRRHb7sENOeKkQf5TS0s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768507998; c=relaxed/simple;
	bh=e1uvAnfBm/yrOtEzgPlP4nzRNl4zaNYmEe+92sFqNkA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=P2if3/rrxBYnBqOUrWXLbNl8JWn4awC8F7gfJc2e+3j6Kpc/IRk1EB+e6EpqPJdTH1EQI+OwCyoCd8Zij/ZdC9gzwqGrP+cuBfcQS8ZkdUwGwXA3AH82vg8qNWb07DLUjb+ToFGbe/CHdc2soLErYoW4C0yJ9xykzEx7IYIzeAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cehKwC0p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6891AC116D0;
	Thu, 15 Jan 2026 20:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768507998;
	bh=e1uvAnfBm/yrOtEzgPlP4nzRNl4zaNYmEe+92sFqNkA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=cehKwC0pD0xeL+6DIgip0YrpCkLPKH5ObI7VFwaVW9VGLiac1IpSbg47FhXli64ZT
	 NdaoR8bwsLw6jQAIQXtHPYXGdNgq6rQv9ungScLNWguXnI+1uI3PLg1mgPDnvtWOMs
	 zYKkavSFWb49Yt1U8EskX8gtpFzdHJ+laCH27pyZOympXpUNxOMtlXM+eCrhe5mmnb
	 vJ1PNk/1cCtIExwZwoBxPGwFM0d4Rf1FYPRCgRI3ms2mk8xc5VwDpsx9xNbKQMGELm
	 O1I/kFV6UKoiLfz6nFYEB/izfBW8uEY5XN4mvBNK49BrCXLMIBpqB+ClavR6c+O82G
	 W352KR4o82FCg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B5985380A97F;
	Thu, 15 Jan 2026 20:09:51 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull NFS client bugfixes for Linux 6.19
From: pr-tracker-bot@kernel.org
In-Reply-To: <57c6f8f6464f7ba0c0455875d4c53a0f9bf01a2c.camel@kernel.org>
References: <57c6f8f6464f7ba0c0455875d4c53a0f9bf01a2c.camel@kernel.org>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <57c6f8f6464f7ba0c0455875d4c53a0f9bf01a2c.camel@kernel.org>
X-PR-Tracked-Remote: git://git.linux-nfs.org/projects/trondmy/linux-nfs.git tags/nfs-for-6.19-2
X-PR-Tracked-Commit-Id: d5811e6297f3fd9020ac31f51fc317dfdb260cb0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 603c05a1639f60e0c52c5fdd25cf5e0b44b9bd8e
Message-Id: <176850779043.4151234.1246446531315121765.pr-tracker-bot@kernel.org>
Date: Thu, 15 Jan 2026 20:09:50 +0000
To: Trond Myklebust <trondmy@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 15 Jan 2026 14:46:24 -0500:

> git://git.linux-nfs.org/projects/trondmy/linux-nfs.git tags/nfs-for-6.19-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/603c05a1639f60e0c52c5fdd25cf5e0b44b9bd8e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

