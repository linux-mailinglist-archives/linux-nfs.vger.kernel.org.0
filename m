Return-Path: <linux-nfs+bounces-14125-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01BE4B491B1
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Sep 2025 16:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DA721BC1197
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Sep 2025 14:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78AB430DD02;
	Mon,  8 Sep 2025 14:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jFrDgYfW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A5A30DED7
	for <linux-nfs@vger.kernel.org>; Mon,  8 Sep 2025 14:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757342174; cv=none; b=S7V33IjSR2NbGQwpW49shL62p2GzpeebVZE9PLRXsTC0LXYlAadEaDXX7wKTD8kWYe0CrFKv7SwCXdLjUBR3yZ66X17/lyxQpXvTuimpv5r9CgmNWcbDmXSTf/fAWhS7hyFruG6/AjY2icVS2IGIV5o4lyYkFgzLRR9q0oqKaqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757342174; c=relaxed/simple;
	bh=4d6yUTMk0y05FR7G62HkZVzAcEQ/8D8MFfR7pCHOEvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b2fngPH9D6752ylDBP9Tzd47fxY9vQO7FVuaC6b0Pa7ecjPh96oFScGT+Y3t9dNU350md+37BYP9VEtkI8uw0wei7q+HJs9FdPbQUgHuHJKh10QVN0RPtPo/r6xdG/WAME1xXVTNpcVnyH/AiVRKXWitl2YjdI8ecLQvuebE3iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jFrDgYfW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57A8AC4CEF9;
	Mon,  8 Sep 2025 14:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757342173;
	bh=4d6yUTMk0y05FR7G62HkZVzAcEQ/8D8MFfR7pCHOEvQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jFrDgYfWeOoWT7k3n3Ot/LGO0qLaA1SBVWGmj3pWcgJEEU3Aa99tE984UTgH9enRq
	 WbUXGO80xlcPX/504Uw13tT8FWhoCBWp0CxnzFIH52ptFBC6NOSM01Nul+0GxTYZjO
	 zaSPM+xT25Sm7ot2qnq3Ck4+RRpEBRwJK4xqk0h7kiHwOoesx5RTx6Q+7Oz5o+Dmps
	 p52lYICX5vVXM6yZN6/yDXXhEq1aKTOETgOp/cPkPGZMrpp1ozREI3jvI5h69JMH9Z
	 ehSCDA04h8kvQKn+sFTtM7t97YNl/sGI66hOyfUIFVfG0ORuYf4teEl8EjQy4vR0dJ
	 NEuUNCtkVNTZg==
From: Chuck Lever <cel@kernel.org>
To: Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neilb@ownmail.net>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH 0/2] cleanups in nfs4reovery.c
Date: Mon,  8 Sep 2025 10:36:05 -0400
Message-ID: <175734214899.12169.11966338580256563041.b4-ty@oracle.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250908014348.329348-1-neilb@ownmail.net>
References: <20250908014348.329348-1-neilb@ownmail.net>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Mon, 08 Sep 2025 11:38:31 +1000, NeilBrown wrote:
> This first of these patchs is part of my work to change how directory
> locking is managed.  That will involve moving the lock as close as possible
> to the operation being locked, and using some standard interfaces
> which combine the lock and the lookup.  Then changing the mechanics of
> taking a lock.
> 
> nfsd4_list_rec_dir() currenty locks a direct and performs a lookup
> in a different function to where the lock and lookup results are needed,
> and does it even when those are not needed at all.  So the first
> patch moves the lock and lookup to where it is needed.
> 
> [...]

Applied to nfsd-testing, thanks!

[1/2] nfsd: move name lookup out of nfsd4_list_rec_dir()
      commit: 80803596e1719e88e81401e67e06245cd1133a20
[2/2] nfsd: change nfs4_client_to_reclaim() to allocate data
      commit: 1a65d347afe90f3ed49e23b7421821a3729f8bfe

--
Chuck Lever


