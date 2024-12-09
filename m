Return-Path: <linux-nfs+bounces-8469-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C6D9E9C1B
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Dec 2024 17:50:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE6751888279
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Dec 2024 16:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068D614F9F3;
	Mon,  9 Dec 2024 16:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uP0HrCOw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E7714D6EF
	for <linux-nfs@vger.kernel.org>; Mon,  9 Dec 2024 16:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733762991; cv=none; b=C3lWOsv+/BMj1tHXmMzzDe+4/R0w4pRUz/Jeh0gipgSngLh+LEbw1vhg9LVQCLnyYTepmmIjChQC/SvQCx6N18gPDtgmIpk5zCWcRc+xuzAKm2LM4g/ZcEvQPvb2DOzSO9cFZUvrdkwuEuy8xG2OZ41nK01676wL1Xsl6Oc7lzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733762991; c=relaxed/simple;
	bh=tia7YTCG2v8GM/catXc1QkqS1oua46pivlgCgTNFjVw=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=cr9NGf8nYnUwlO69iS/FJcDieqDpvLl6OMqlGJ2adeHGOYRtOkcimq5dv0rJC2fB+O0sFXwxPoh6CF2Cx1NKC5s0AMZvORfg+f5FoaS7p0P87hhZNfdctrJSxOLBeQzmE6zlVdJGSxrFhoLdUP8EoieSMAsvYpQ88uLLvw7n+ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uP0HrCOw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 605CBC4CEDE;
	Mon,  9 Dec 2024 16:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733762991;
	bh=tia7YTCG2v8GM/catXc1QkqS1oua46pivlgCgTNFjVw=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=uP0HrCOwbAnnPJRh5Rofun27Lz9qvo6hArHJi1rzpd3hcOKI3n7P69njTj44Eou/w
	 ypd40WDhfM3koDcjfOf/dNVFFrxBJQdx4CN2cpM64DaFmDibWj5DCy0IhJmjGIau11
	 n18bip+9aRzxFsQlQE2ImQ0Kijb3q53TRfSEaVrtwIWsIUZzE9b7R554Hft96Ba/+x
	 SlB3LcviIlWsVjRVFhj1ErLz4tpvJOkRsoIcR3COpRH6KHgpnAsI1hNM/ZHedKyLiD
	 kqcRVWL+WXbcXdktdpbEZ84jB/IPzqp4+9HilzRESctfgN4YkAcGM9dWPQMGL3yTcw
	 xg58RnUaAwMWA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F2206380A95E;
	Mon,  9 Dec 2024 16:50:07 +0000 (UTC)
From: Jur van der Burg via Bugspray Bot <bugbot@kernel.org>
Date: Mon, 09 Dec 2024 16:50:05 +0000
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
Message-ID: <20241209-b219580c2-2def6494caed@bugzilla.kernel.org>
In-Reply-To: <20241209-b219580c0-d09195e1d9e8@bugzilla.kernel.org>
References: <20241209-b219580c0-d09195e1d9e8@bugzilla.kernel.org>
Subject: Re: kernel BUG at fs/nfsd/nfs4recover.c:534 Oops: invalid opcode:
 0000
X-Bugzilla-Product: File System
X-Bugzilla-Component: NFSD
X-Mailer: bugspray 0.1-dev

Jur van der Burg writes via Kernel.org Bugzilla:

I tried kernel 6.10.1 and that one is ok. In the mean time I upgraded nfs-utils from 2.5.1 to 2.8.1 which seems to fix the issue. Sorry for the noise, case closed.

View: https://bugzilla.kernel.org/show_bug.cgi?id=219580#c2
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)


