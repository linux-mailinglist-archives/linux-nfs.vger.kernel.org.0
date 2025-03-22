Return-Path: <linux-nfs+bounces-10768-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B1DA6CBE8
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Mar 2025 19:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54B517A6544
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Mar 2025 18:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACFBA1FBE8B;
	Sat, 22 Mar 2025 18:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N5WNIbc4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881E31C84B6
	for <linux-nfs@vger.kernel.org>; Sat, 22 Mar 2025 18:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742669672; cv=none; b=Ak9uigj2pGPzH/SFeoNhNjAHqXgWj6BQPzStOQN3hcVpzMfUQ32jO/OHQnPTX1kEG2dvscwfK5kMEZkTqWHhqPnLI41yayZJXfxfYN9D/tIcCBcRAP1ghnur81lR4q3SPoHNnuxsyy3jrrRUoCzymfl4CDLExf7brMC1UnlU/Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742669672; c=relaxed/simple;
	bh=FmQi668bNJQ+e9UnpT1ZImTmeD0lwKYxkuTtQnYmH8g=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=HC1jJTYyKVzgSW0VYnBwQ+gCfBBpGBeM/LrfwkJW4DUUNDtLxtFy2lKFwsjkMSpWpiEWc31foVBEoBKVNPSpvLV9NY6+xZlm08YrdH4Ijwnqz8LRcHOGFmARNR7+86xszABlCZU58Gelm3ENcJk6GHyPkuWzmu5YmVKFPbkaZgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N5WNIbc4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D97D1C4CEDD;
	Sat, 22 Mar 2025 18:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742669671;
	bh=FmQi668bNJQ+e9UnpT1ZImTmeD0lwKYxkuTtQnYmH8g=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=N5WNIbc4gvwfgqj0EV9unTs7B+o5nplTp+VmRjsM4awWn6ZWVqtoT7Nq484Gh5lNv
	 Ix10daEM9fmK+BP4fhHFB949iPHTXovKc7yHTB6zr4wpOZ3ZpwRyY4jlPFePWMYurB
	 lef+ODwcm+psuNYuW6F7q2cUFgSCL6+/B6KzHzUCAjxTdCuQLnmOob8iTmcvlQfGon
	 9SLYPsgsHebKlqi8OiNMBKDiRVDLF1ge3/U1an2578wDQBvobJ4sIxJ2jgMWB3l1Xs
	 hkiKUyxPSNsMi/EpFH6LJhuv/88xezA59dEzjX9UmaIw2AIGvl/mIBFbDZbMWafz+G
	 E2vDQwnXz4uYw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 00DDF380665A;
	Sat, 22 Mar 2025 18:55:08 +0000 (UTC)
From: therealgraysky via Bugspray Bot <bugbot@kernel.org>
Date: Sat, 22 Mar 2025 18:55:05 +0000
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: cel@kernel.org, anna@kernel.org, trondmy@kernel.org, 
 linux-nfs@vger.kernel.org, jlayton@kernel.org
Message-ID: <20250322-b219911c1-348fac92b04e@bugzilla.kernel.org>
In-Reply-To: <20250322-b219911c0-bbbed350da5c@bugzilla.kernel.org>
References: <20250322-b219911c0-bbbed350da5c@bugzilla.kernel.org>
Subject: Re: kernel panic when starting nfsd on OpenWrt snapshot with
 kernel 6.12.19
X-Bugzilla-Product: File System
X-Bugzilla-Component: NFSD
X-Mailer: bugspray 0.1-dev

therealgraysky writes via Kernel.org Bugzilla:

Please consider adding the following to the 6.12-stable queue:

de71d4e211ed ("nfsd: fix legacy client tracking initialization")

When I apply this to my build of 6.12.19, I no longer experience the bug/nfsd appears fully functional.

Reference: https://lore.kernel.org/linux-nfs/75ec06ad-7472-4e83-a20e-28543ec2909d@oracle.com/T/#t

View: https://bugzilla.kernel.org/show_bug.cgi?id=219911#c1
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)


