Return-Path: <linux-nfs+bounces-9719-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D98A20C2B
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Jan 2025 15:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D70E87A34D4
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Jan 2025 14:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CEA71A76DE;
	Tue, 28 Jan 2025 14:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UhbCln/P"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB72219F11B
	for <linux-nfs@vger.kernel.org>; Tue, 28 Jan 2025 14:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738075211; cv=none; b=FVZI4nkZKHMT13iH2x2WAhn+e+NUxkyZPH1tiQZ1P1O37TRaPLXPBWeUNwRfbHceXxYt8nH5vhGBZN8vWnfjaeYdfjZju1pd9T68hUhEr5EcStRZtaT+79X+47sAAwTt0wkqSZJ63DwEUKt+DWW4LXo34sTiuCZcWUfJLp+CXqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738075211; c=relaxed/simple;
	bh=cAuO+AB0ikubn5Di/lWhsFRvX0BanH0Ra5NkEU2txk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nWndPaF8x9MubxCTQX7KPKRsLx6fyAZwyO1KeJ7Dl4rIn+Lw2zkJhOoHzMhLI9NpYWL9THJFi//VfzX8NgdAig5wMHAK7jA/ZkijE//+Qi7Mrm2dd4B7Vdx9OW8xntBfZbc/lSnS3H+OQItAmjqTUakZzVYIm8DvLis4zXHae1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UhbCln/P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF8ADC4CED3;
	Tue, 28 Jan 2025 14:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738075210;
	bh=cAuO+AB0ikubn5Di/lWhsFRvX0BanH0Ra5NkEU2txk0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UhbCln/PvPP8yrWEdlcusPq1nd7a5aTy6ZwtwVif3dffQhkZorJIpHgu+WsQokprZ
	 Vo8TYduv5YNX40x+qwItasGbxkXo2VXaXFEVeKNAIdfB6CrklZcBrzeTYQqpJEbnlP
	 UNqhkoXy7fBXyEHoD8ybZTLS1rVP0eFgahTBVGeBVkV+ncoI22NriHbwrYDrK4u4Cn
	 GQ3KaqKM+2qUlV4PZdHn/Gv8Cl5N0+yUWo4kjBN7Bt0YYtmK24zBRWXgOGImYbEiZ3
	 9udelJGrCmZ6PekMkqzV/V29U2/FejmPxORKL2okAWzA5j55+hYD0OLJfw2gklHhT/
	 2SXC/KKW8v2tg==
From: cel@kernel.org
To: Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neilb@suse.de>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH nfsd-next] nfsd: fix uninitialised slot info when a request is retried
Date: Tue, 28 Jan 2025 09:40:05 -0500
Message-ID: <173807510144.36903.13632933490009953475.b4-ty@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <173801910367.22054.5749156945763150749@noble.neil.brown.name>
References: <173801910367.22054.5749156945763150749@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Tue, 28 Jan 2025 10:05:03 +1100, NeilBrown wrote:
> A recent patch moved the assignment of seq->maxslots from before the
> test for a resent request (which ends with a goto) to after, resulting
> in it not being run in that case.  This results in the server returning
> bogus "high slot id" and "target high slot id" values.
> 
> The assignments to ->maxslots and ->target_maxslots need to be *after*
> the out: label so that the correct values are returned in replies to
> requests that are served from cache.
> 
> [...]

Applied to nfsd-testing, thanks!

Because I sent the NFSD 6.14 PR yesterday, this fix will be queued
up for 6.14-rc once it has completed a round of testing.

[1/1] nfsd: fix uninitialised slot info when a request is retried
      commit: 78843acb930e16c6f8aa4abd3b82b997c03018c7

--
Chuck Lever

