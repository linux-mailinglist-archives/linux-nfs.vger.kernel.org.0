Return-Path: <linux-nfs+bounces-6998-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84345998012
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Oct 2024 10:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 376831F25E99
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Oct 2024 08:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72170206E8F;
	Thu, 10 Oct 2024 08:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ieZ6Dh71"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC81206E8E
	for <linux-nfs@vger.kernel.org>; Thu, 10 Oct 2024 08:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728547505; cv=none; b=bWYax68CdjoMdmOiTGxd7ZYezwyEgf2ZRSYtJjIfDhWtXDPaV3qBy3o+6KQl3qv1BJVwzGzo2tXbC/wf22Z+3+OwDTX+JjNJSujWBkU8CU8ak/wfFz7TKoxYJsFlIp30WTu42OIkv2W2GXhtPl/DZIyhFzRSfvW74wr5Y2PWUEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728547505; c=relaxed/simple;
	bh=eGGSNrSJvB2kKqUI/mfoqw+E9NsU4OLGohu2ddKkMAk=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=OIN+O7VoF4uGbNzEpNVx6T9RCoPZxcAJECKjK4hceDe2gYapkWW4EzCh7hVvXgTbI8tQS7lGaJMAgydZp/bzMuNwkxnevrwu5wdxCYbm+REWtjnCpL9+uD+LPjPR9ms0VzL8reO6pPUtggXQw/14B4B5rWr2NOfZFx5Z6Ei6onM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ieZ6Dh71; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C235BC4CEC5;
	Thu, 10 Oct 2024 08:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728547504;
	bh=eGGSNrSJvB2kKqUI/mfoqw+E9NsU4OLGohu2ddKkMAk=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=ieZ6Dh71R2OT+nzbIyXprS/Hr5NU5f8LUD9kX612oYUXpx+7tgqYsdlA39LUPELw+
	 I/1CBfuJD4RHS+MfkZf6lrTaxqtb8Bc48LU2zjOM1bpeTQJRBfypDUMqvuK36qRBid
	 Cfxwkaz1hJ8832DfU7B0J4joy9zUaBYML+W4G/pVFdwNananuamcIm3+ofrVCEv6jz
	 iVrui/o/Yj07arlIklPmtFax9QqlaF2V323g0+L7QA5qV8VZek0K7gxkK31vVzvuhn
	 nBfMSVVO01QJxT2mTvnyyFgLlHCRA1X+fZeAcSLGQw3LHcg2Bb9j260pMgdHHUdPWv
	 +AupRZao+6Gkg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 39F483803263;
	Thu, 10 Oct 2024 08:05:10 +0000 (UTC)
From: Janpieter Sollie via Bugspray Bot <bugbot@kernel.org>
Date: Thu, 10 Oct 2024 08:05:07 +0000
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: trondmy@kernel.org, anna@kernel.org, cel@kernel.org, jlayton@kernel.org, 
 linux-nfs@vger.kernel.org
Message-ID: <20241010-b219370c2-74262de4ca7c@bugzilla.kernel.org>
In-Reply-To: <20241010-b219370c0-bd6df2a482ac@bugzilla.kernel.org>
References: <20241010-b219370c0-bd6df2a482ac@bugzilla.kernel.org>
Subject: Re: link error while compiling localio.c
X-Bugzilla-Product: File System
X-Bugzilla-Component: NFSD
X-Mailer: bugspray 0.1-dev

Janpieter Sollie writes via Kernel.org Bugzilla:

based on the bisected commit id, I turned off nfs localio option in kernel .config for 6.12-rc2, now it compiles.  Guess that's not surprising

View: https://bugzilla.kernel.org/show_bug.cgi?id=219370#c2
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)


