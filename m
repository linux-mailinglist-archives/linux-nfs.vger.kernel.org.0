Return-Path: <linux-nfs+bounces-8518-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E099EC15F
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Dec 2024 02:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 003D9164CF3
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Dec 2024 01:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41154964F;
	Wed, 11 Dec 2024 01:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UD0suVe+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C011D2770B
	for <linux-nfs@vger.kernel.org>; Wed, 11 Dec 2024 01:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733879691; cv=none; b=FzTz/yvH3MR8TsB+Yma/Oxxy84GGI4MbhAV/wMrmGlCC+aLSJSH0bGSf6GXHd5AtAkqD3v2bzKHV/VA4JiCzuHiiQl+z4rb0Z4t8xTOttqOSdW9D4lyPAcxYCeOamR0D4RYC0EoBQi0no29MWORQVlC+f7qTx72aJ3kcV3n0E/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733879691; c=relaxed/simple;
	bh=cx/n6bUf2NyFtGvIGT5kO3d1u1MUr2z1iMyroCaSYdA=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=X7KLwjGK081YZjFbIWdg4RTGyXbkVt6Ydx0oWHf1HNaaUnYMvkYvlS7R9UKGfx5icwvrFgxQ8vypRi8NkRw7nQSch4dHzYa1ZMivXN1VvOE4fMvpFqNfmUs9zqDal3wY78Y6XcgCZ+M/k4XtOYs4dObx8Qw01AdMN4qXIWaE5Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UD0suVe+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47247C4CED6;
	Wed, 11 Dec 2024 01:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733879691;
	bh=cx/n6bUf2NyFtGvIGT5kO3d1u1MUr2z1iMyroCaSYdA=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=UD0suVe+whUkYbZBUTTIQW+y+5c6Q4vb069Z+ARMkfYZsJKnjGnAyCC7zENVKKia6
	 npNOm9iPx8DcJhWWM8gCHZx4ET7Zn3VxJAnTFLPwWoGKu/HTyNQDIqcvwSLek0DgiQ
	 tUIRSg2Lq+1btkhHTg36LBae3hyDZwpOgIQVUL+B0Zh2nsBcvWXdphAhtlPWp7DSZc
	 111zjjHhuBauUeCv2sSJvocO8GbbJxhB5ZClYeI6If3SkrjQ2UuaByuiuD4hcO3Iie
	 E9jKY0TuN9/lzobJmHYAcobbW/5cr/it6g8jsLn4VuPeRAYki/F3+XI4L21C8hlSVm
	 rSBYC50BxXs9Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 37C3E380A954;
	Wed, 11 Dec 2024 01:15:08 +0000 (UTC)
From: Chen Chen via Bugspray Bot <bugbot@kernel.org>
Date: Wed, 11 Dec 2024 01:15:16 +0000
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: cel@kernel.org, anna@kernel.org, jlayton@kernel.org, trondmy@kernel.org, 
 linux-nfs@vger.kernel.org
Message-ID: <20241211-b219535c12-b0546dbad396@bugzilla.kernel.org>
In-Reply-To: <20241127-b219535c0-4d5445e74947@bugzilla.kernel.org>
References: <20241127-b219535c0-4d5445e74947@bugzilla.kernel.org>
Subject: Re: Possible memory leak on nfsd
X-Bugzilla-Product: File System
X-Bugzilla-Component: NFSD
X-Mailer: bugspray 0.1-dev

Chen Chen writes via Kernel.org Bugzilla:

Hi Mr. Lever,

> You mentioned RHEL, and RHEL 9 in particular, several times here.

Because I want to indicate that, except the kernel, every other toolchains were using latest version from RHEL9.

The ELRepo Project (https://elrepo.org/) is a group of guys grabbing the latest kernel source and package it into RPMs for easy installation on latest EL-like releases (like RHEL, Oracle Linux, Rocky, Alma etc.)

> By upstream, I mean the "master" branch in this repo

OK. I've just installed the latest stable (aka 6.12.4) and see if it might help.

View: https://bugzilla.kernel.org/show_bug.cgi?id=219535#c12
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)


