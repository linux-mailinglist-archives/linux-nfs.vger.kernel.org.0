Return-Path: <linux-nfs+bounces-8458-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EFB59E9939
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Dec 2024 15:44:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29B8A28233D
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Dec 2024 14:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E111B043D;
	Mon,  9 Dec 2024 14:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tyyLC46z"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553D0288CC
	for <linux-nfs@vger.kernel.org>; Mon,  9 Dec 2024 14:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733755496; cv=none; b=adZPOL39jHtCyBxmm8o43I4hxU7aBg00E36gLR+/aSzwypPsbu0abeRoL6E4n1px6h9OkoJ2WIqhqVr+n0gfT+Tj1UWaGj4NbrqqqqiAFcCFT6ymEISspcJlAmeST1bA+EQr+yiY115g+4ApqliN3pIOBvjiJzlM9m4EH4NRqgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733755496; c=relaxed/simple;
	bh=qSHon1Uh5gGIQFZsSfJmkL/y5YjDSuYQz04D+CuSWqk=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=Kiumf6x9BIDlFXqA7vj43z+RhoSDDlQbjWoISE8ybjucayBcXjmSPUNeapBhjHZud/jI/itUFof7nsjf7Ajtp16KjNh+FPQVwsbOzuUa2PYW/vIZ7ppLaSCi+971w1/R+Wo76Ici93890EkC/tXEIHr4aDiUN/xPdQLTtF/+RrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tyyLC46z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E03CDC4CEDD;
	Mon,  9 Dec 2024 14:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733755495;
	bh=qSHon1Uh5gGIQFZsSfJmkL/y5YjDSuYQz04D+CuSWqk=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=tyyLC46zL4e2Z14++Jw8tFDdQ1eeoy0CXhgv26aCBmB53GEC0si4ndx4BIiIvFxgg
	 q/j/PgEHv2qJGsM837VJPT5IJV//6z2DEdG3ibXyLdB7WM7njDhjfrmdYciHzw68vg
	 WXBCmFJ2ONgNeq8o5krmstS4cxD82w8QLK8uWzMC7lp4YH2UsZfAUAav9Aus9Ki8h+
	 /V9FmcME1zZYs5D3U/rAb7UJnFWYw40Q1YXRi95cqJak9D6AXm/IfUP0MTP+hKrtgY
	 4UT267bKfu/TPnkqhe9pfw+QJ1mpgRBc3p2VOB7IyGRzPIOC7CgJY0nCYzMypFuGoi
	 ZqPKnHEEYT8AQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 75E4E380A95E;
	Mon,  9 Dec 2024 14:45:12 +0000 (UTC)
From: Chuck Lever via Bugspray Bot <bugbot@kernel.org>
Date: Mon, 09 Dec 2024 14:45:09 +0000
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: anna@kernel.org, trondmy@kernel.org, jlayton@kernel.org, 
 linux-nfs@vger.kernel.org, cel@kernel.org
Message-ID: <20241209-b219580c1-1d3560de8c9a@bugzilla.kernel.org>
In-Reply-To: <20241209-b219580c0-d09195e1d9e8@bugzilla.kernel.org>
References: <20241209-b219580c0-d09195e1d9e8@bugzilla.kernel.org>
Subject: Re: kernel BUG at fs/nfsd/nfs4recover.c:534 Oops: invalid opcode:
 0000
X-Bugzilla-Product: File System
X-Bugzilla-Component: NFSD
X-Mailer: bugspray 0.1-dev

Chuck Lever writes via Kernel.org Bugzilla:

The Debian folks have been seeing this issue since at least 6.11.9, so it was introduced well before 6.12.2. Start by bisecting the Linus branch (not stable) to see which commit introduced this issue.

View: https://bugzilla.kernel.org/show_bug.cgi?id=219580#c1
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)


