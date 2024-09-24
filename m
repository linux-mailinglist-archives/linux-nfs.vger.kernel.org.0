Return-Path: <linux-nfs+bounces-6632-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E00B984E1A
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Sep 2024 00:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB6231F2412D
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Sep 2024 22:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2FC17ADF0;
	Tue, 24 Sep 2024 22:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uFbYVJ57"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68C2176FDB
	for <linux-nfs@vger.kernel.org>; Tue, 24 Sep 2024 22:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727218203; cv=none; b=BU1YwAg1Vi8bWE2LqWjE/7xMa7r6zg7UZ6kjGc5HjO8xPdxzcW1pJVzJivu0DOAUG/IMzF0wtQjd1noEGz07W/SLQfT1le1NngSUwuYjnlxciuaMagpw+9Qizlwb0OHkggmus184q9E/GrZbnqL4Lntu9RReanDujuJ+mBdNIZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727218203; c=relaxed/simple;
	bh=gPINcSmxCOpHC1an4gr6titRxpWIzp8R3Me1DTGN4eI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=FIeHmJ4VPhLYaG0tsJ8j6I1NpGUmqAuQQNBs/fhQq0hqjZiIj1v0LOMelYJgcainoJwkiuf30OjARiDj4w1FI6889hNc4E/bESCsElZ+07jJJnn44KgEwPDwkecK8JjthXvoAszZek702Njp8xoItInx0It1ZsppUrmdA3FHwdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uFbYVJ57; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABBAFC4CECD;
	Tue, 24 Sep 2024 22:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727218203;
	bh=gPINcSmxCOpHC1an4gr6titRxpWIzp8R3Me1DTGN4eI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=uFbYVJ57cnQSnbpqUNSqVjpE0FGnzF1+947k/VRPG9ci0YhezF/T6o1FQN17Y0tkn
	 bCscQxaJzkcHigTSXfAD+osPZDKsGqMjYgbd7NhiO+ZaNE+lv2+MIdzcg/XafQCtfi
	 ezrRRjTWbWBT6db5Rz/bAMSZ+UJN5b1wV5SyJix9HugBiYPrhdCnFh4GypVu+gP6tt
	 44HnSTfOO8Izpf2MNGXG28qeJ6BIkWMrfu0zzEXW025ftxqZnpRnzGwILg+p0Ik2W+
	 R7CxGd5BnnKgIy7bO/d0wGGAJAKk7P28Kwl/ooj63twUOes7uDKk3HP7m91j8t5Ox1
	 4AW/vqu7AFmuA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5BB5C3806657;
	Tue, 24 Sep 2024 22:50:07 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull NFS CLient Updates for Linux 6.12
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240924211755.186104-1-anna@kernel.org>
References: <20240924211755.186104-1-anna@kernel.org>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240924211755.186104-1-anna@kernel.org>
X-PR-Tracked-Remote: git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-6.12-1
X-PR-Tracked-Commit-Id: 68898131d2df70d1a9ad5c2f93f0f54dd6d5c336
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 684a64bf32b6e488004e0ad7f0d7e922798f65b6
Message-Id: <172721820608.30034.9119270023636971373.pr-tracker-bot@kernel.org>
Date: Tue, 24 Sep 2024 22:50:06 +0000
To: Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, torvalds@linux-foundation.org, anna@kernel.org
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 24 Sep 2024 17:17:55 -0400:

> git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-6.12-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/684a64bf32b6e488004e0ad7f0d7e922798f65b6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

