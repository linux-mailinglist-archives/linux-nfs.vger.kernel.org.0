Return-Path: <linux-nfs+bounces-9429-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C445EA181B6
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Jan 2025 17:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6E917A4129
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Jan 2025 16:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018D3186E46;
	Tue, 21 Jan 2025 16:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M9VMxFWZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CFF1C36
	for <linux-nfs@vger.kernel.org>; Tue, 21 Jan 2025 16:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737475783; cv=none; b=A6zam0xCX1GC9RK+r/dmIQYv3JEjZka99MPpT/JrffelT4rnJvuWJG44XYFIfaMChGnIasvueklDTUOyVkaxJharGevoZUWJsKKXwF592wNwO8cd/6YqEDPRrSj7WDZqLu973VS4+0+CBvbfQ1ylnVltoq7AsMgLw9Czcm0Ak3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737475783; c=relaxed/simple;
	bh=mJUpUba6HEc91Bmn601iMxFzT8RhlqRvafcA/f3TpBc=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=S0dwksXWAzd3RkYmDq0O6pDy2feOj676ljU2ytT1byVJMSwJ5iXD0y9RobLJ7Ii2E30LdxT90MtzLaEZHcuRRHGBvg31wfOJ3ogTtx1wt/qU0ZPRiFkMBdlIKG4nCy2R3OoQdwqbT+L6AZh/wJ9RM2RnDKK8VqavLuim2HPbsvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M9VMxFWZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 463B3C4CEDF;
	Tue, 21 Jan 2025 16:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737475783;
	bh=mJUpUba6HEc91Bmn601iMxFzT8RhlqRvafcA/f3TpBc=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=M9VMxFWZkRDWGMH8TZeyfZE06cP0l9Dzx8D7wNEAuVgdSm+lvv6b4lfQ2g6Pt8lke
	 e6Dbc0WAwOWgHptHMBgHncD84ButmIclgoFtw1rmiWj3DczGUItXuHTPUgJzz+8bnJ
	 g4qzSITjvZ+OnN5PGyFzm0OcT/WbddnWX7jBzT6VAwr02nlgBQ59HtIF4zsKkhTbzu
	 LdP4UBWPxy+ANcq0eZ1QYlRIF/qT8hGIM5Rob9pokmkqzbkcD4e7rtWjGncRCm/vTM
	 EznZ6ta5vvtX9UAs0hrBtDmpdF6HsL4aaw4Abjx2iKuaBK295muczlMgW7qMT6lt88
	 x07ls9sLHW58g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7B05D380AA75;
	Tue, 21 Jan 2025 16:10:08 +0000 (UTC)
From: Chuck Lever via Bugspray Bot <bugbot@kernel.org>
Date: Tue, 21 Jan 2025 16:10:11 +0000
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: harald.dunkel@aixigo.com, anna@kernel.org, jlayton@kernel.org, 
 benoit.gschwind@minesparis.psl.eu, chuck.lever@oracle.com, 
 trondmy@kernel.org, cel@kernel.org, herzog@phys.ethz.ch, 
 baptiste.pellegrin@ac-grenoble.fr, carnil@debian.org, 
 linux-nfs@vger.kernel.org
Message-ID: <20250121-b219710c7-773af1987926@bugzilla.kernel.org>
In-Reply-To: <20250120-b219710c0-da932078cddb@bugzilla.kernel.org>
References: <20250120-b219710c0-da932078cddb@bugzilla.kernel.org>
Subject: Re: NFSD threads hang when destroying a session or client ID
X-Bugzilla-Product: File System
X-Bugzilla-Component: NFSD
X-Mailer: bugspray 0.1-dev

Chuck Lever writes via Kernel.org Bugzilla:

The trace captures I've reviewed suggest that a callback session is in use, so I would say the NFS minor version is 1 or higher. Perhaps it's not the RPC_SIGNALLED test above that is the problem, but the one later in nfsd4_cb_sequence_done().

View: https://bugzilla.kernel.org/show_bug.cgi?id=219710#c7
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)


