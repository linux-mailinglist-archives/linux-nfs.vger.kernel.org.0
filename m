Return-Path: <linux-nfs+bounces-9411-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B398A173A2
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Jan 2025 21:34:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 294B01885CC8
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Jan 2025 20:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52AC41F03F4;
	Mon, 20 Jan 2025 20:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bJ+1cCkI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D14D1F03F1
	for <linux-nfs@vger.kernel.org>; Mon, 20 Jan 2025 20:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737405284; cv=none; b=CSJhijbkzI/h1w+APGTeEoGfPniU4jvG8roYdYfarTlUwoeUGuNEIWWHzolRZBXZ3lY8Wkzi79QkkcVWHSp0l9EDtAPANxuxnRoGmljhpZwcJHybsz5s3uy2wA9Fbx7YVM7Y4Oi4+N4umEOGaTmY6ERgFYziabYFJLrMZOcBgl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737405284; c=relaxed/simple;
	bh=nR9DMuDJTWDbj7OMPPtjbQt74IRTytDeSgM0zolh4Bs=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=iTbVTgk0UM6kvx80WLrhPno9bi32DpX7uA5IiERLmL25mj9SKQanhKhhvpu/ElIA1BbJrnMhfelmLvvxasLomN9gGFCQE8uDMFwv21zUobDPhhvzkGGR3HtGND7QllM8M8+2Oc1ronzoG78nSlYv5pcOcQeKZ2s1a2UcIakJFkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bJ+1cCkI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98867C4CEE0;
	Mon, 20 Jan 2025 20:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737405283;
	bh=nR9DMuDJTWDbj7OMPPtjbQt74IRTytDeSgM0zolh4Bs=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=bJ+1cCkI0GllAWny8BXAriYbia5kU1IsNaF8gVR2DuGFJaHUYPMsZ/Y+2/vNPlIWO
	 skC6AWS5uSOE4Av94HQgJmRmB3W7ZhMOBG1iaM+kc7LBfpxGU18tUvMMtQGY+CiBdR
	 YqunrN+Vso5oNxaHBIexnVJaAZyIkHiVb7Ea8HOjaN3nP4ehXfL547xlgJZ7LzFt6B
	 BsG9EXYSjYTC1esTeXz6h8W4rFNiHAp25oFRcrHBvZ0UYlYYTPPZxaYOz21B2K60+r
	 lSXoNiQH9tJ3AU83myt7y2oMzFD06RSQgQZyPjV6SViNbIy/dMBbrFXTxHIIbEfNo0
	 Xqiwdoem34fuw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B43E8380AA62;
	Mon, 20 Jan 2025 20:35:08 +0000 (UTC)
From: Baptiste PELLEGRIN via Bugspray Bot <bugbot@kernel.org>
Date: Mon, 20 Jan 2025 20:35:08 +0000
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: linux-nfs@vger.kernel.org, benoit.gschwind@minesparis.psl.eu, 
 jlayton@kernel.org, carnil@debian.org, baptiste.pellegrin@ac-grenoble.fr, 
 herzog@phys.ethz.ch, anna@kernel.org, cel@kernel.org, 
 harald.dunkel@aixigo.com, trondmy@kernel.org, chuck.lever@oracle.com
Message-ID: <20250120-b219710c5-280ffab13560@bugzilla.kernel.org>
In-Reply-To: <20250120-b219710c0-da932078cddb@bugzilla.kernel.org>
References: <20250120-b219710c0-da932078cddb@bugzilla.kernel.org>
Subject: Re: NFSD threads hang when destroying a session or client ID
X-Bugzilla-Product: File System
X-Bugzilla-Component: NFSD
X-Mailer: bugspray 0.1-dev

Baptiste PELLEGRIN added an attachment on Kernel.org Bugzilla:

Created attachment 307511
Recorded trace 20250120 (syslog + trace-cmd)

Sorry no rpcdebug logs. I will try to record next crash.

File: record_nfsdc_20250120.tar.gz (application/gzip)
Size: 2.93 MiB
Link: https://bugzilla.kernel.org/attachment.cgi?id=307511
---
Recorded trace 20250120 (syslog + trace-cmd)

You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)


