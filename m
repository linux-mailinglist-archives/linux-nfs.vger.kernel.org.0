Return-Path: <linux-nfs+bounces-9631-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D11A1CD47
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Jan 2025 18:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9819A165F9A
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Jan 2025 17:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E157413B29B;
	Sun, 26 Jan 2025 17:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aDmWk0al"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDB01362
	for <linux-nfs@vger.kernel.org>; Sun, 26 Jan 2025 17:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737911081; cv=none; b=SW36RhqeURUvjbSuThbSYRzLLO8Mi255SPjwsUKoJJUAsqJcBCs7MC04tWHqznDB89cFhA2drWAxQDH9c/g6vbQH8vqj5h0ipCmN/sy6ifvgLtDnu9+EUR570RIw+MPWF2kzxSpgdvToDHse2mj4ScLrBahP5Gpzji4IhJIV5mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737911081; c=relaxed/simple;
	bh=NnXN7kxum1d/w5jHhffh9PFVVwW42EXzIcasZlfsYMQ=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=leZBpJwFxUqlR5ZxrOBN3/RQ2ySS4+ZgJydO/I57/TNDUlbaOrVXW2GsfFDGNDhuKjWjYJnRF/AqR8oavYzMYacrmPkN6zAf6WqaiSCXLEYPFSTZQE8KgLX7Mze34F/qVduedBaxno3Db6xNaWAbdc9DyGQvMc5ZvuqROrePFlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aDmWk0al; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18B19C4CED3;
	Sun, 26 Jan 2025 17:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737911081;
	bh=NnXN7kxum1d/w5jHhffh9PFVVwW42EXzIcasZlfsYMQ=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=aDmWk0al1Itux4Ua0wcd+Y59SJuRthjGgFcebh2E/RDvs6we5aBcib87tniWiDXRG
	 Dr8m81o9FNgQdcZBbmtD05e9hIw/s9/qGbIb09jcONykv6O63K1nSztIVm+rSYDpCm
	 zxQ/RAfuIAwWXhzbeCruN+PeFkqFxmtc6f5zLuwuqFhConxKW5B5EvywpUNsPxTtvP
	 NiMcE9fDvn4yJlIOdWsWBgdLleNodS0FZ/zgGjquJ7zFZf1uRthW98re2+IcQu5VfJ
	 qgrSuv+P75bhjuulJss6KoRGlXbda808O7wnXnYU2JbdhhJiNZpIeq0UKC45/ptRDu
	 P+ZRBQAgTqPiw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 776FD380AA79;
	Sun, 26 Jan 2025 17:05:07 +0000 (UTC)
From: Chuck Lever via Bugspray Bot <bugbot@kernel.org>
Date: Sun, 26 Jan 2025 17:05:26 +0000
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: tom@talpey.com, linux-nfs@vger.kernel.org, herzog@phys.ethz.ch, 
 carnil@debian.org, benoit.gschwind@minesparis.psl.eu, 
 baptiste.pellegrin@ac-grenoble.fr, trondmy@kernel.org, 
 harald.dunkel@aixigo.com, cel@kernel.org, jlayton@kernel.org, 
 anna@kernel.org, chuck.lever@oracle.com
Message-ID: <20250126-b219710c23-80b5c2b649e5@bugzilla.kernel.org>
In-Reply-To: <20250126-b219710c22-172df050e851@bugzilla.kernel.org>
References: <20250126-b219710c22-172df050e851@bugzilla.kernel.org>
Subject: Re: NFSD threads hang when destroying a session or client ID
X-Bugzilla-Product: File System
X-Bugzilla-Component: NFSD
X-Mailer: bugspray 0.1-dev

Chuck Lever writes via Kernel.org Bugzilla:

(In reply to Baptiste PELLEGRIN from comment #22)
> I patched the current Debian stable kernels :
> 
> Debian Linux 6.1.0-29-amd64 (= 6.1.123-1) Based on Linux 6.1.120
> Debian Linux 6.1.0-30-amd64 (= 6.1.124-1) Based on Linux 6.1.124
> 
> with there two commits :
> 
> 8626664c87ee NFSD: Replace dprintks in nfsd4_cb_sequence_done()
> 961b4b5e86bf NFSD: Reset cb_seq_status after NFS4ERR_DELAY
> 
> Now my two NFS servers are running these patched kernel. I need to wait one
> week to see If the crash still occur.

It's probable that a hang might still occur, but the symptoms might be closer to the hangs that happen on v6.12. If so, I count that as step forward: one less bug.


> Chuck, does this patch may remove the "unrecognized reply" messages from my
> syslog ?

It doesn't.


> I see you have improved the backchannel session logging. Did I need to
> change my trace-record command ?

The trace-cmd command line I provided above uses a glob expression that should also enable the trace points added in 8626664c87ee ("NFSD: Replace dprintks in nfsd4_cb_sequence_done()").

View: https://bugzilla.kernel.org/show_bug.cgi?id=219710#c23
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)


