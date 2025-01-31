Return-Path: <linux-nfs+bounces-9813-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1319A243B6
	for <lists+linux-nfs@lfdr.de>; Fri, 31 Jan 2025 21:14:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65282167874
	for <lists+linux-nfs@lfdr.de>; Fri, 31 Jan 2025 20:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A191CB9F0;
	Fri, 31 Jan 2025 20:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mdvBAFk1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F451155C88
	for <linux-nfs@vger.kernel.org>; Fri, 31 Jan 2025 20:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738354481; cv=none; b=CuOKo9MsWsvFA8QjxWvRNhFkV3yRJ2jO82vYo3TRmffT888NUfuePlo1M5whcygJlzR+rs3xo0xbkTBv7iQ6fZYKJ3qdKkX6Qmrdq7tr3bhnj9dnQtTi03he4lc5x53P3CGMwqLmNICIIdY5Nx4UsXec5qsxkb/uKaVW1dyqShw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738354481; c=relaxed/simple;
	bh=BG2rI2Rn1wQ+sNGg4S4wu39aKMzQJOfXdEro2Kmokzk=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=GOx627ob8Qd0UyWRGLGvLRVp0e2t2WDtJ+ajxq1Ime1e4t8kRjgBuyfo7biAWB3AwK++HXJc6U4g1MnZBMtMsldLc+MlsM/YSimRioIdzlt2GHNijP7myB+q8ZgY8eDdr+NLItZLlcUy4oiDcRinM5TJA4UjXmscsL5BXYCPYcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mdvBAFk1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FDE7C4CED1;
	Fri, 31 Jan 2025 20:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738354480;
	bh=BG2rI2Rn1wQ+sNGg4S4wu39aKMzQJOfXdEro2Kmokzk=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=mdvBAFk1K3udoIJ0KIe+mStODCjMaEIFNIN0Mq2LKeszbWzQRLZdVyGTjDYFA4ptL
	 EGd1U0fdi18hyc3ZcqtGkOsH85uIvs8dvzU2P0EdP29PevqV5JkxhOAMcKrZQCZWvo
	 BgIUAzMrLRDwc5ko3HjsZ4geZSbeGvDPIdguWtoCULpdgR6703kzUetJJLnATqzV7M
	 MzpeyF8542CIbVFllYJG4F5ik7WREOq4SwqDX36VJ9unmZktdDVO9KMY9u9oUmevv9
	 Hoqq4EoDhjUB0Gcsc7ABxHubnNRezU9nzAICyuh1h1hvkf4TVh25TBvQNsTgIiYl98
	 XgB3i43K/u1sQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 38A36380AA7D;
	Fri, 31 Jan 2025 20:15:08 +0000 (UTC)
From: Rin Cat via Bugspray Bot <bugbot@kernel.org>
Date: Fri, 31 Jan 2025 20:15:07 +0000
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: linux-nfs@vger.kernel.org, jlayton@kernel.org, anna@kernel.org, 
 trondmy@kernel.org, cel@kernel.org
Message-ID: <20250131-b217973c3-c25737af37f7@bugzilla.kernel.org>
In-Reply-To: <20250131-b217973c0-a2ac608a1bf9@bugzilla.kernel.org>
References: <20250131-b217973c0-a2ac608a1bf9@bugzilla.kernel.org>
Subject: Re: CFI failure at nfsd4_encode_operation+0xa2/0x210 [nfsd]
X-Bugzilla-Product: File System
X-Bugzilla-Component: NFSD
X-Mailer: bugspray 0.1-dev

Rin Cat writes via Kernel.org Bugzilla:

I no longer had this issue when I moved to LTS 6.6 kernel from LTS 6.1, so I am not sure where it was fixed.

And for Jeff, CFI (Control Flow Integrity) is LLVM/clang supported runtime type check.
If a pointer or function argument is different or incompatible with the declared type, a kernel warning or panic will be triggered depending on the configuration.

https://clang.llvm.org/docs/ControlFlowIntegrity.html

A CFI failure most likely means some runtime bugs.

View: https://bugzilla.kernel.org/show_bug.cgi?id=217973#c3
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)


