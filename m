Return-Path: <linux-nfs+bounces-7359-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD7B9AB094
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Oct 2024 16:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB17A1F23222
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Oct 2024 14:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FEDF1A01B9;
	Tue, 22 Oct 2024 14:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ajx9ZfNn"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C0D19F10A
	for <linux-nfs@vger.kernel.org>; Tue, 22 Oct 2024 14:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729606501; cv=none; b=fYSU40wN92p4LmM8C+qDC4rMmq8tmgOJs8ukf14dxeigrvys7lmzHcZQZ6F1Poi5FxG9lV69oFWlVKHFWFlqtnc+6d5muJk+WYTWwMsFTr7a9Ia39toWLCs58h7J03h9sv07xJT+4L5bxwJE3aJhd/MnOipGBwTrCk5nvR0Y0Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729606501; c=relaxed/simple;
	bh=ZGshJGRz00i6fZ9jhtCmLMHgk9olTClSGKEpqvYodYU=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=VY1cUPBdSKztxWQxUw0vZmfLO1p2IuvXMJa1b5uJY1SeOFgeuvw3e4C0QIw2RylWWQMn4goXIrmB2hLaqan9Ki7RRfh6c8b/EUM8uXxXku4PaTaJhX53WMVvSolncRbMawrauIGbbphjHY/7kuj2XD+3Snt0+HORwlHIFt5qs/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ajx9ZfNn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2CB6C4CEE4;
	Tue, 22 Oct 2024 14:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729606500;
	bh=ZGshJGRz00i6fZ9jhtCmLMHgk9olTClSGKEpqvYodYU=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=Ajx9ZfNnzlR+pzP2MdB3gY5HCeE6++vMuRB5+hDKnX1CECk1MROzPg3P8qa3FDQPu
	 gwirdB3u2FBhNE43G1ieQb5iwQ4IHsHAjmKELHPU21FtvNevvSb04TkziBNZ/LPR90
	 uihoAvVC2kbe+TnOvBEHj6M3PpujXzX2t0ZXFvGCM8FYWcnZeTRkVRCtC8o75Z9xFx
	 eWKpowC97+EQUbG3ynJagBHpgGeGDBNP3vgMLFUgbDEViKcAkTSfmy8E8JJF8/GdPs
	 TdK9RJUdgDkDNSfUnNO9fOElN2W9eJzzLab3lvMlbKRe89O6OKoXklugDpL5dkxW2Y
	 OMmgEnp5ralkg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 025423822D22;
	Tue, 22 Oct 2024 14:15:07 +0000 (UTC)
From: Mike Snitzer via Bugspray Bot <bugbot@kernel.org>
Date: Tue, 22 Oct 2024 14:15:09 +0000
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: cel@kernel.org, linux-nfs@vger.kernel.org, anna@kernel.org, 
 trondmy@kernel.org, jlayton@kernel.org
Message-ID: <20241022-b219370c6-d93cfd00e8a0@bugzilla.kernel.org>
In-Reply-To: <20241022-b219370c5-c7de7745e4a0@bugzilla.kernel.org>
References: <20241022-b219370c5-c7de7745e4a0@bugzilla.kernel.org>
Subject: Re: link error while compiling localio.c
X-Bugzilla-Product: File System
X-Bugzilla-Component: NFSD
X-Mailer: bugspray 0.1-dev

Mike Snitzer writes via Kernel.org Bugzilla:

(In reply to Mike Snitzer from comment #5)
> This was fixed via v6.12-rc3 commit 009b15b57485 ("nfs_common: fix
> Kconfig for NFS_COMMON_LOCALIO_SUPPORT")
> 
> In the provided kernel config:
> 
> CONFIG_NFS_FS=m
> CONFIG_NFSD_V4=y
> CONFIG_NFS_COMMON=y
> CONFIG_NFS_COMMON_LOCALIO_SUPPORT=m
> CONFIG_NFS_LOCALIO=y
> 
> My Kconfig fix will result in CONFIG_NFS_LOCALIO=m so that the symbols
> are available to the nfs.ko kernel module.

Sorry, to be clear, the fix results in:

CONFIG_NFS_FS=m
CONFIG_NFSD=y
CONFIG_NFSD_V4=y
CONFIG_NFS_COMMON=y
CONFIG_NFS_COMMON_LOCALIO_SUPPORT=y
CONFIG_NFS_LOCALIO=y

View: https://bugzilla.kernel.org/show_bug.cgi?id=219370#c6
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)


