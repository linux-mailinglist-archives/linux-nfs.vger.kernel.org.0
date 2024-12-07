Return-Path: <linux-nfs+bounces-8412-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1E89E806B
	for <lists+linux-nfs@lfdr.de>; Sat,  7 Dec 2024 16:29:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D878618841A5
	for <lists+linux-nfs@lfdr.de>; Sat,  7 Dec 2024 15:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6B5322E;
	Sat,  7 Dec 2024 15:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tFXl0eeV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7638622C6C5
	for <linux-nfs@vger.kernel.org>; Sat,  7 Dec 2024 15:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733585393; cv=none; b=qZmzfdzwc1goWx+/RpBXyrneR7/k6JCvxQymf32t0KyKp78dVASF8srWg1+dRuyYQ1iN/nYR6wXURV97sgVLdNxRcccYoLTyTLH4KjpfRPB/vvzOD1iZ8v5IlU+YPJRZVyviPyl8H5nSjeAbB7EtypYM4WDqYjf4iEQDJF7NszI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733585393; c=relaxed/simple;
	bh=e5m+S/u0VubEFlXEdJlDEtIA8ltjS1cKih9aO6T/SEo=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=tIDEw24mlX0aYlqchaP9fCjZJ2ZyWmS1KCao6vmw5tnvng3sClpJ+HvxhXfltGwnA692ypT7V86wvDhGpvolnq7INPDfnQirKE498PWZJuW1Ssx4BZfRCsgo5ajjzgU/h+izkO9InlY0VHsPwuCB6NHvxzU8+658WReJ+EOJbOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tFXl0eeV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18F8CC4CECD;
	Sat,  7 Dec 2024 15:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733585393;
	bh=e5m+S/u0VubEFlXEdJlDEtIA8ltjS1cKih9aO6T/SEo=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=tFXl0eeVUD6hNDEUslxxgiaKeIDqdxFpin3qPczwd2jmcNRVrkPYxu0EELT66SNDP
	 WMkPdHwHxfaqPzWnX0GjtIO7Ax2WjYigGY4F2pQeA7phiU9heTVv52ZZIvcQFy7J1X
	 br1E00fH0er6qxFuXQvDHz0eTbTia6CUp0gqM6Y15i60nAMRDLWqdCRL0WQvKK6vn3
	 ESOYxuL3V6KaN6uwkd/Fi+LjonKyZbxAHSz/gX0lzcrREHPMiWn+bu9CYgtSQQfmnF
	 e8IVdgn9Mi/5XvZvD52QmsGAqs8YLbWLKiEockUlfgqpYz7gOz5beXTzmTLP0WlD0L
	 Y8WYDe+bTBulA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3D52F380A95D;
	Sat,  7 Dec 2024 15:30:09 +0000 (UTC)
From: Chuck Lever via Bugspray Bot <bugbot@kernel.org>
Date: Sat, 07 Dec 2024 15:30:13 +0000
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: anna@kernel.org, jlayton@kernel.org, linux-nfs@vger.kernel.org, 
 cel@kernel.org, trondmy@kernel.org
Message-ID: <20241207-b219535c9-7a3a244f531c@bugzilla.kernel.org>
In-Reply-To: <20241127-b219535c0-4d5445e74947@bugzilla.kernel.org>
References: <20241127-b219535c0-4d5445e74947@bugzilla.kernel.org>
Subject: Re: Possible memory leak on nfsd
X-Bugzilla-Product: File System
X-Bugzilla-Component: NFSD
X-Mailer: bugspray 0.1-dev

Chuck Lever writes via Kernel.org Bugzilla:

Hi Chen -

After some review, these all appear to be Red Hat Enterprise kernels. Such kernels are extensively patched and maintained exclusively by Red Hat engineers. I kindly request that you report this issue to Red Hat first and have them troubleshoot it.

If they find there is a needed upstream fix, do feel free to re-open this bug.

[I am a fan of the old ConnectX-3 cards, btw]

View: https://bugzilla.kernel.org/show_bug.cgi?id=219535#c9
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)


