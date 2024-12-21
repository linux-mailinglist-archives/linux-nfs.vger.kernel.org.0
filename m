Return-Path: <linux-nfs+bounces-8703-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3B39FA1C6
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Dec 2024 18:37:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FF1D7A2540
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Dec 2024 17:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73838165F01;
	Sat, 21 Dec 2024 17:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SwWhsOWL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A97E33C9;
	Sat, 21 Dec 2024 17:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734802659; cv=none; b=hf6KKVJnLwnj+3HTtxU5aVCvCC7Y3eeMI9cgix7b8cr1G8togreZ30yGEmr1S+wnoTos10mi5zkvy2CsgoFaHhARNNyHN8Yfx32n0iB5kSRy4WsxFUPNGEe/lgSl7tx3o9ZILqFM94IBJKFdSnu9nhtQKNHil8m9PUg53gGrOfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734802659; c=relaxed/simple;
	bh=C0KaWRcuDUDiWT7CYhinkUVwSJKBDrLkRBIzno7YGIU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=KrV65WDE7bvZU5R+qA/IaPD2WJSev1UnVRz0wnJFmJdv4VzoqgykbvWeeKJUPUmAekYgyeKOL/f92UsDtRAFeG4s9hdgSajVroSYfgL5OhlwPmCAmfzK792cH/yLeXu1fjKFHK1Q6b+8sWz4xrA28toOuBTFvMYl5S9YbPV9npg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SwWhsOWL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26D10C4CECE;
	Sat, 21 Dec 2024 17:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734802659;
	bh=C0KaWRcuDUDiWT7CYhinkUVwSJKBDrLkRBIzno7YGIU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=SwWhsOWLNXk6MdoPqPIBDsfOE2rRMusQa68Wkr0tCn4AD9nlOoiyzvxGudpqNjjss
	 L1q//zutiyXTRhC+LbhANs+pNkTmIR9NRqgqUM+WYiAffyU4EWTbqQuzvBzsPbAYuB
	 kgJsnuOLYeu46Bj2ClBvEM1ghXDdGz9x00UR+lsjK2jDJ+9UwwUeCkg7xURGYApUsy
	 Jdkrnio3M2WxP+Hy2xNIBMsgcVS65jGHEaAau3lnjNCoeWK1O2pALkQhiYKRJNussI
	 LGyNDbZ1bnIpW/LbN2Uffsnpxn+31/iQGeyrSCMJDm4Uy4konJ1SfzF5LUcgn6cXks
	 XCK6k1hWt0SQg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E673806656;
	Sat, 21 Dec 2024 17:37:58 +0000 (UTC)
Subject: Re: [GIT  PULL] Please put NFS client bugfixes for 6.13
From: pr-tracker-bot@kernel.org
In-Reply-To: <10d898a194fa59e8f79ba08b24237c01a3f58a80.camel@hammerspace.com>
References: <10d898a194fa59e8f79ba08b24237c01a3f58a80.camel@hammerspace.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <10d898a194fa59e8f79ba08b24237c01a3f58a80.camel@hammerspace.com>
X-PR-Tracked-Remote: git://git.linux-nfs.org/projects/trondmy/linux-nfs.git tags/nfs-for-6.13-2
X-PR-Tracked-Commit-Id: bedb4e6088a886f587d2ea44e0c198c8ce2182c9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4a5da3f5d35000bd8e5dd78732679a1e00fae719
Message-Id: <173480267697.3197313.8079159642080290063.pr-tracker-bot@kernel.org>
Date: Sat, 21 Dec 2024 17:37:56 +0000
To: Trond Myklebust <trondmy@hammerspace.com>
Cc: "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>, "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 20 Dec 2024 22:14:04 +0000:

> git://git.linux-nfs.org/projects/trondmy/linux-nfs.git tags/nfs-for-6.13-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4a5da3f5d35000bd8e5dd78732679a1e00fae719

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

