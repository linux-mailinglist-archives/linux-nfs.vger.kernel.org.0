Return-Path: <linux-nfs+bounces-10767-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CEC1A6CBDC
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Mar 2025 19:40:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 089883A82CF
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Mar 2025 18:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2922E3384;
	Sat, 22 Mar 2025 18:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qzwLTwUo"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F4D3A8C1
	for <linux-nfs@vger.kernel.org>; Sat, 22 Mar 2025 18:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742668777; cv=none; b=n4rO4ZriVT60eSTZIKpmM/nMuWnG1s1O7j1hRrjiHTDKoUjy4sb4jftm83R2TrWQBFy+bjsrWguN5yooSSvRiHjdGC77ydGyEGpr5N0h/yY6m8gtF7JSMl6HS//4EzherApp4Zo82R8wbImgGMTbWsjPnnCCzBWtws7k45gpMyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742668777; c=relaxed/simple;
	bh=L/+fLPUiz2CTfkYf8ymJqyEUUSLKSx+KG+1b8P2IP2c=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:Subject; b=hIaOy0VpbJpEnEZOJZK5nwfqG01IjmqeAjzr/4RkDHIJQu66N6/gWZp7fjz5LtDYq6scN2+9GzGqn2KxGz/xmbQuh0xOit1CsByWtf/dh5LEAVjBzDH4964aRJIpyhjhK+uEiJTD39A62/Ml7gQ7NEXIYgDt3iN3SmwBH9vEdbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qzwLTwUo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22187C4CEDD;
	Sat, 22 Mar 2025 18:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742668777;
	bh=L/+fLPUiz2CTfkYf8ymJqyEUUSLKSx+KG+1b8P2IP2c=;
	h=From:Date:To:Subject:From;
	b=qzwLTwUoHYq7iuNXLgpLnEpU9nvvm1B/m9xyN7yurIRiB0NPvc9E1t41TVjyVhVDM
	 Ev9jKnhmFnMVKHWh8klsGiNYIwxx29Ynsllj0Nd5CYYlhCUk8j88pZ8P5Uavqjuu4+
	 TD0pwoIaefVagBAS0NoA0+UHMjqnioivBdqJJ/kYTOsWntX4I661IRMa5Fq1ZwhG6S
	 7/r3rqPrqKfbNMMA0QVTuo9XhdoQLIGjfpvdvXpNHAAQNiPysOIrt1FTJsp4Dm2RYd
	 H1FAWOvCFPuualsoJdtcot5aTHucs5VgU3P2Ah5IHwnw8qLXKto3t7X/XrFM/Q0q3O
	 RjlqvqUVOI6tA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3BA2D380665A;
	Sat, 22 Mar 2025 18:40:14 +0000 (UTC)
From: therealgraysky via Bugspray Bot <bugbot@kernel.org>
Date: Sat, 22 Mar 2025 18:40:10 +0000
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: trondmy@kernel.org, anna@kernel.org, jlayton@kernel.org, cel@kernel.org, 
 linux-nfs@vger.kernel.org
Message-ID: <20250322-b219911c0-bbbed350da5c@bugzilla.kernel.org>
Subject: kernel panic when starting nfsd on OpenWrt snapshot with kernel
 6.12.19
X-Bugzilla-Product: File System
X-Bugzilla-Component: NFSD
X-Mailer: bugspray 0.1-dev

therealgraysky added an attachment on Kernel.org Bugzilla:

Created attachment 307885
dmesg output from intel machine

I am seeing a kernel panic when I start nfsd on OpenWrt running kernel 6.12.19. Using the 6.6.83 kernel is rock solid. I confirmed this on two Mini PCs, both x86/64. The first is an Intel-N150 based machine and the second is an AMD 8845H-based machine.

The attachment is the output logged to dmesg upon starting nfsd and triggering the panic. This is from the Intel-based machine but a similar output is generated on the AMD one.

File: dmesg.txt (text/plain)
Size: 6.28 KiB
Link: https://bugzilla.kernel.org/attachment.cgi?id=307885
---
dmesg output from intel machine

You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)


