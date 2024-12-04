Return-Path: <linux-nfs+bounces-8344-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED91F9E3F46
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Dec 2024 17:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35AD0B3656B
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Dec 2024 15:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB9B1FF7B8;
	Wed,  4 Dec 2024 15:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qXqQ9QMa"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5782920C019
	for <linux-nfs@vger.kernel.org>; Wed,  4 Dec 2024 15:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733326193; cv=none; b=UzgLUE17Z/Bnd8uLCgO4CsCE45W02O4B6fzjQkLMBbAgb0K8GFEQ86n653g2dGqthpfunEv/E1eYzdvyFRjULOJU+01XMMpT35N9IHOdX7U/Q+JVP+ajJOXvYC1WqilVH9sSgKJKJ5GLy8GOwXAKU4lPfTJw6ZVsDzBD2IOd8UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733326193; c=relaxed/simple;
	bh=GuiOteU53qG+lVs+3nHwubKLY/WVHkkSO1WqVpgaaao=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=bs4AoDOI2zFotR9IMt4sA7u4QXLXKnkUsKeB4oPO/EjAfl8DiBHrjteOkOnb7QZWJyg/bf35GPBQU5xII9V6uEJbVISg8bZtaJCiCjUfEe3OYTgThgl8IB9/mv5fUfa5xtq1kR0xjAR8jBoYzIHcaLM1OJyM2y7KCkJ6E/SLzZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qXqQ9QMa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3284BC4CECD;
	Wed,  4 Dec 2024 15:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733326193;
	bh=GuiOteU53qG+lVs+3nHwubKLY/WVHkkSO1WqVpgaaao=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=qXqQ9QMaKLEtY0g0w73aBY21UUTlhLVtAhyLhnX1A3bzudNbWKN7u1BT39FqTPjwQ
	 vJ+qQZFPBgBrlp6MpeeYTeW5oLL5AtJPjvzzkHD/lZIUjXzICk0xaePaGOqVsqQsZP
	 tX2UTWCQJUbxFNSJxbRhbulBwmrRDoB//yLMCk33f3SMkv/NDFr1oG3mf5FdxfWfzw
	 k+JvzeGw4rjk/zu4W7JFHNknGtk+T4XG8Ku/UOy2I5WaqURSWRW6+y5/If74jWUzMc
	 o29d60xPeX1YuhFRIghXJOiqyiPo9Bs7yZ7XjzrEsaeQgJxp5tJ3kCFl+c569v8rUs
	 JzM71/uwfsKDw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B6C673806658;
	Wed,  4 Dec 2024 15:30:08 +0000 (UTC)
From: Chuck Lever via Bugspray Bot <bugbot@kernel.org>
Date: Wed, 04 Dec 2024 15:30:07 +0000
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: trondmy@kernel.org, linux-nfs@vger.kernel.org, cel@kernel.org, 
 anna@kernel.org, jlayton@kernel.org
Message-ID: <20241204-b219550c3-c55f880f3db4@bugzilla.kernel.org>
In-Reply-To: <20241203-b219550c0-abf5589a5df5@bugzilla.kernel.org>
References: <20241203-b219550c0-abf5589a5df5@bugzilla.kernel.org>
Subject: Re: deploying both NFS client and server on the same machine
 trigger hungtask
X-Bugzilla-Product: File System
X-Bugzilla-Component: NFSD
X-Mailer: bugspray 0.1-dev

Chuck Lever writes via Kernel.org Bugzilla:

I think we had better be clear here.

Running an NFS client and server on the same system is fine, and "supported". It's also OK for an NFS client and server running on the same physical host but in separate guests (or one on the host and one in a guest).

What is problematic (ie, deadlock-prone) is when that client mounts the NFS server running on the same kernel. This includes container configurations, since containers share the same kernel and memory resources.

I assume that the deadlock reported in this bug occurs when a Linux NFS client mounts the NFS server running in the same kernel.

View: https://bugzilla.kernel.org/show_bug.cgi?id=219550#c3
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)


