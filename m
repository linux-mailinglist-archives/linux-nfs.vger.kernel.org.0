Return-Path: <linux-nfs+bounces-1702-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B8684623B
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Feb 2024 22:02:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0F891C2496F
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Feb 2024 21:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5AC3D0A4;
	Thu,  1 Feb 2024 21:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xv3T8b6S"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027CE3CF74;
	Thu,  1 Feb 2024 21:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706821348; cv=none; b=Bn0bgAv03U0B820dCePasLzZkXsffA1dIS89KQJKHOfoI81A2Op2IWof1/r7rMMtibKrpIkSWLy3LtCBcZMkIHOgwaw4PB4cc7Mon9VWUsNOJ4wqB8HhLK8X5hg0aaoWggBGMujtbsIK+IIDjq6JiQaRGNIgnjFwEkUdUqepkuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706821348; c=relaxed/simple;
	bh=RNWuVGmrwX9vitH6nNacCn2ArVFUm2im1kauENZPoe4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=N8tSaqIeFjGIRskrsIZ23pmAD769KVuADJQ3k3KuuKXB+5VqqMZ546lHFBrmImg7qWIP9C+ECCKOPVoZTNC5ZBJ8a1b7PH8heZRkg9YWK0Gt9HKLo36jIObOJROm9jvEKTuR0djfVStoKQtCHLtZqd2npf5eW0mxwNU0xRJn8SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xv3T8b6S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CFF6CC43394;
	Thu,  1 Feb 2024 21:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706821347;
	bh=RNWuVGmrwX9vitH6nNacCn2ArVFUm2im1kauENZPoe4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Xv3T8b6SKSG0u6U7KE1vuSCK2Lp4drbSizNiSsDzzzzseZcOEaS+m+7b8cVu19Zox
	 Ot3Eaik0eBdp7GXvYXpknO/FTcdUh5YEAR3E3XRX5sahYeIMYyw+l42oCG2Vk2pKEJ
	 vD5jXcNEDKI6uFZ1l0gYciKFgQ30ngM4fPY1I6pwNfsnP68Z1vlv0SoRSgvvQcwCP4
	 dylr0/dg1lnTgBrJ/InQEHBr0dsjx8jpxB3cT99kJVU2MzF4fZHRPeNRtfYcu6XjnR
	 ++sryqwY0RXy5S4fXgRJJ7K4zcAZ8gjRILgOGt6DE8sIusWNQZXOfvt19CzO2FIE/+
	 bEsMoJQh7k4/g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BD19EC0C40E;
	Thu,  1 Feb 2024 21:02:27 +0000 (UTC)
Subject: Re: [GIT PULL] another fix for v6.8-rc
From: pr-tracker-bot@kernel.org
In-Reply-To: <8F4AC301-0EAF-4767-9AD1-A21A37917650@oracle.com>
References: <8F4AC301-0EAF-4767-9AD1-A21A37917650@oracle.com>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <8F4AC301-0EAF-4767-9AD1-A21A37917650@oracle.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.8-2
X-PR-Tracked-Commit-Id: ccbca118ef1a71d5faa012b9bb1ecd784e9e2b42
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cfdf0c09a68b6026c0b214b484f1dab60b8b78ba
Message-Id: <170682134776.25707.8114079513103134224.pr-tracker-bot@kernel.org>
Date: Thu, 01 Feb 2024 21:02:27 +0000
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux NFS Mailing List <linux-nfs@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jeff Layton <jlayton@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 1 Feb 2024 14:15:22 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.8-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cfdf0c09a68b6026c0b214b484f1dab60b8b78ba

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

