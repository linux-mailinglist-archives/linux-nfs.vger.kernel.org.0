Return-Path: <linux-nfs+bounces-9550-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB24FA1AB28
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Jan 2025 21:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE25E16BEEB
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Jan 2025 20:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291B91BEF7C;
	Thu, 23 Jan 2025 20:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gZy9wGNO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046F51BDAB5
	for <linux-nfs@vger.kernel.org>; Thu, 23 Jan 2025 20:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737663884; cv=none; b=e+A+EJRkuFI5EjgFHC4BcCC4ALmN/LBdShiamStl1Dco5UYioHtmRhbigazNXvlZOo7kSbtv70wCot7PDNTVG03dQXd3z6Xg1ufTOPwnRKHALlYlz75p0pWLQxpq0eUl2ULIRjHAhEIRy+CDiZIq75/jqw1gi0vFvtnC2g4emEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737663884; c=relaxed/simple;
	bh=H8bnm2oduBa6IKB9nusE7KBDsuX8wZcvNU9SQgkY3mw=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=U9f9QhgTt3ZK2aVSJLfao6GnyldfYgspdxl5NNClQc+48m4kn6saYckTXx54vkIyx1MrD6l9br115zUsKckA7a+87j8s8jlchppHBjGGr0xusEHyYwVGTUiQ0C54ewQDhvVaNI/KjY4Nxm6Uap8QAhpFLHC1EqMH7Qc0fj86YR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gZy9wGNO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F8BAC4CED3;
	Thu, 23 Jan 2025 20:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737663883;
	bh=H8bnm2oduBa6IKB9nusE7KBDsuX8wZcvNU9SQgkY3mw=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=gZy9wGNO2kRKloWyvNMP4gGegKiO3Cai3ZCYuNuVW2g68YwfLkXjBEDMS7UnElZxK
	 K4riaAdG2l4pv/N/ZnWkyEVaSlG0vTECJpHIOY2qkUNVVRkZjzH/8zI9cGVwukZDnA
	 yUIFSoxDEQb5dpGEBTUrgT1/yHHqhDW+iPyBQ6IyXum3kwMWDuu2vluRFX5LFSKslC
	 MHbt2BT74brZLcun4Jp9AMtoDM3tVi8tIky+H05VOvqBt4wrIfxlZrgfVXSjrzudnG
	 CDLbvd2AoKOLIXR9cVAFxUY4FAYgcLozGSjbUF3EnX/7l03cNY2GntY+d7SPRx3ylJ
	 lrm/SoleYFOxg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3CE48380AA79;
	Thu, 23 Jan 2025 20:25:09 +0000 (UTC)
From: Baptiste PELLEGRIN via Bugspray Bot <bugbot@kernel.org>
Date: Thu, 23 Jan 2025 20:25:24 +0000
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: trondmy@kernel.org, baptiste.pellegrin@ac-grenoble.fr, anna@kernel.org, 
 cel@kernel.org, chuck.lever@oracle.com, herzog@phys.ethz.ch, 
 harald.dunkel@aixigo.com, jlayton@kernel.org, carnil@debian.org, 
 tom@talpey.com, linux-nfs@vger.kernel.org, 
 benoit.gschwind@minesparis.psl.eu
Message-ID: <20250123-b219710c20-c1ea7afe5a91@bugzilla.kernel.org>
In-Reply-To: <20250120-b219710c0-da932078cddb@bugzilla.kernel.org>
References: <20250120-b219710c0-da932078cddb@bugzilla.kernel.org>
Subject: Re: NFSD threads hang when destroying a session or client ID
X-Bugzilla-Product: File System
X-Bugzilla-Component: NFSD
X-Mailer: bugspray 0.1-dev

Baptiste PELLEGRIN added an attachment on Kernel.org Bugzilla:

Created attachment 307533
Recorded trace 20250123

This time I have got a complete trace.

- trace-cmd with all flags enabled :

trace-cmd record -e nfsd:nfsd_cb_\* -e sunrpc:svc_xprt_detach -e sunrpc:xprt_reserve -p function -l nfsd4_destroy_session

- Syslog with all kernel messages and a task dump just after the crash.

Hope this help.

File: record_nfsdc_20250123.tar.gz (application/gzip)
Size: 2.02 MiB
Link: https://bugzilla.kernel.org/attachment.cgi?id=307533
---
Recorded trace 20250123

You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)


