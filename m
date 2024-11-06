Return-Path: <linux-nfs+bounces-7735-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F23C9BF9D4
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Nov 2024 00:16:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25A0B283F9F
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Nov 2024 23:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C824E201110;
	Wed,  6 Nov 2024 23:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PBOrzAxf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43211D7E37
	for <linux-nfs@vger.kernel.org>; Wed,  6 Nov 2024 23:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730934955; cv=none; b=NNo0jlQyYdAiGvt0XP06acNNOHx06ghLnJdG3irzi3YmL2slQoy5Daq+bqKDmkeQpZ2CtbpleSi75Op8ydEEiqiqbsm5R2lLFejpYwqzrSPIT0AaX41r22gurxN/nyA2Rzrs2ReNYTaFXn2Ilh13Md2jplWANfpiy9zJ+PX/0n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730934955; c=relaxed/simple;
	bh=udlBX4RRP+4VJH7PjIwTHxwp54Q5YfI0f7U1YWCOefI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=a4u6jbg+SevN5eBPSwcLAfxj7A0i1nAnVFrTXwIYYcasO3JKCzFnrePQ+Dx1E6bL4St3IexTyz+CCdzHuwKsIb+lbkMWsORaKPXKVyUiowxuHmFaC/DNmLAqyfop967aPim0MsMAAS0yFWJQk+PqQl8YkHsdqvirp7C82L7Lhv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PBOrzAxf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DB91C4CEC6;
	Wed,  6 Nov 2024 23:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730934955;
	bh=udlBX4RRP+4VJH7PjIwTHxwp54Q5YfI0f7U1YWCOefI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=PBOrzAxfqQQDKihsU67R7Ms/YdNX5A0IXEKr2xAAUVVbnRyHB1/41GDGJsjJv1nrr
	 zS/g0IACxnGvMnRqc017gO2nKlT/LL5FR4WjDWUBVZeP/jxEyYIf2yUEUT87k8FNj1
	 tCiYHql/ejMUrlyh5CLl42ZTL72Ws4F0d10/1mD0Ez7QjJ/MRrErEaxXuaJuHidzkB
	 BG21pWzXNn7fuOBLNzmjFII9kd8vFv1cCqhS4Gd/0Lt/J2VO7rTKm/PzRWTyO16BpR
	 QtHrLi1nVoWMSPlXo4Cl9bny66Efu4wd5QzAqfYP/CDXtGzL4fRwAcp/OEXpcV02Ko
	 JaG+qJnSdgPSg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE25E3809A80;
	Wed,  6 Nov 2024 23:16:05 +0000 (UTC)
Subject: Re: [GIT PULL] More NFS Client Bugfixes for Linux 6.12-rc
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241106204451.195522-1-anna@kernel.org>
References: <20241106204451.195522-1-anna@kernel.org>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241106204451.195522-1-anna@kernel.org>
X-PR-Tracked-Remote: git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-6.12-3
X-PR-Tracked-Commit-Id: 867da60d463bb2a3e28c9235c487e56e96cffa00
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ff7afaeca1a15fbeaa2c4795ee806c0667bd77b2
Message-Id: <173093496422.1450316.13406546081370293847.pr-tracker-bot@kernel.org>
Date: Wed, 06 Nov 2024 23:16:04 +0000
To: Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, torvalds@linux-foundation.org, anna@kernel.org
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

The pull request you sent on Wed,  6 Nov 2024 15:44:51 -0500:

> git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-6.12-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ff7afaeca1a15fbeaa2c4795ee806c0667bd77b2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

