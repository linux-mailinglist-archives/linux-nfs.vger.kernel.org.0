Return-Path: <linux-nfs+bounces-17053-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C0567CB895F
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Dec 2025 11:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A770430202FF
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Dec 2025 10:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69BE7315D24;
	Fri, 12 Dec 2025 10:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IOrrPWCI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40011314D0A;
	Fri, 12 Dec 2025 10:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765534335; cv=none; b=c4C40v60SIkcROwwNxvHpoEivBwNoC8AhHI1ER5yM3/xDPYK5B+sCtxPjWuUng2+RhbhnXk8Wz9OvCKrwEIlcSiINDcCcwBIHMhFmJf572NViY63BOCn/S1tFsnn8BGMZ/0DBXVsvsOEpUGtdljMnho3wbx6fcv3ZwVR0UhrX8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765534335; c=relaxed/simple;
	bh=KA47seWtZI7rGpkIonXa1kmdB5Q6F/ACB5MBafVu9b0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=PTeS1r18P8+tDuSpKbgADAfUEoXvTSDOhOuelIp72uqeTeg0ZNXTulkV8f70XqSEoWcpYHAiMNWT6fljuZd4QMZ3hPRqhSTE0IcPg2umPXqbqnzQustDzmE+cP/SjSErGk0sog5giOCItqFTRcFmssYjFYhCcyDF6fAU+gt+iNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IOrrPWCI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22986C4CEF1;
	Fri, 12 Dec 2025 10:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765534335;
	bh=KA47seWtZI7rGpkIonXa1kmdB5Q6F/ACB5MBafVu9b0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=IOrrPWCIgOfHmD1SaeoP+60G0KraxDlvueQsIr2h/+IYibFbwZRpsGuqVqJj3e3cY
	 pbWyyN+vyMkUo38aS7QtTa2mX2AGwcOQ48ReRJTZjM7ywYfp+gd/DobDTf+H/fJPax
	 SHohOEwQ/8SRiXTkuL16yBvWkbK7Cea9s/CxK6lTULWNUZII27JYAFdeTDCARu3F74
	 /boht75HmRumHcIECZqxK8WIPxlh3H1dvhyep70qxjokxFyj+AfbIsQ1hfOfvz4QUG
	 zYx8tqnqL3+3e1Gmcl99UfNzcG547itn5ksfkBT26iwlVSnwA9/Dq04L+7/VPvPA4q
	 eNRzc3ux90OLw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B59AB3809A90;
	Fri, 12 Dec 2025 10:09:09 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull NFS client updates for Linux 6.19
From: pr-tracker-bot@kernel.org
In-Reply-To: <36d449e22bf28df97c7717ab4dfb30f100f159a4.camel@kernel.org>
References: <36d449e22bf28df97c7717ab4dfb30f100f159a4.camel@kernel.org>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <36d449e22bf28df97c7717ab4dfb30f100f159a4.camel@kernel.org>
X-PR-Tracked-Remote: git://git.linux-nfs.org/projects/trondmy/linux-nfs.git tags/nfs-for-6.19-1
X-PR-Tracked-Commit-Id: bd3b04b46c7a9940989ff4b29376e899e93d3a4a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6bb34aff1ebdd4ee8ea1721068f74d476d707f01
Message-Id: <176553414834.2108206.5544741374608047303.pr-tracker-bot@kernel.org>
Date: Fri, 12 Dec 2025 10:09:08 +0000
To: Trond Myklebust <trondmy@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 11 Dec 2025 09:07:42 -0500:

> git://git.linux-nfs.org/projects/trondmy/linux-nfs.git tags/nfs-for-6.19-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6bb34aff1ebdd4ee8ea1721068f74d476d707f01

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

