Return-Path: <linux-nfs+bounces-10260-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA48EA3F7AD
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Feb 2025 15:50:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC5DB7A6AD9
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Feb 2025 14:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3F81BD9E3;
	Fri, 21 Feb 2025 14:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M8GYiPdw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189C27080D
	for <linux-nfs@vger.kernel.org>; Fri, 21 Feb 2025 14:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740149377; cv=none; b=Fn9Xom00ZoTL3H9kcyvBi+35SBwN5r97v+H2rLyTctfeK2vfeAqAQrehIus/h/ZqHqsW9zLAWb1224AG3PYDpX/sfdExi9mhNdfQPeXCQGHibBGxRePVenwD4gYbYUfjmfwUJ7B2l55n0nx7ribr0JkuMJT4bTnimyyxUJlXqk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740149377; c=relaxed/simple;
	bh=MGwZ9gBZ4KkZX7u0wW1sZxVaPrqqEwvC4/Pdc6IuJIo=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=JpO+uh6SZVc5YD0nfat8ZlXap3VZgdm8jNmVlksnttZNywAeNmDNz7K1mlyYI76FLJo291RMHnwYQRhiSgfByArgjtk8oG97DJCil5q7wHhM+3oUn35hG39XH3zgApwdC/Pifs22KvcBxt2mSa23E5pggfi/U7eLaRfrm2vuANY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M8GYiPdw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D118C4CED6;
	Fri, 21 Feb 2025 14:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740149376;
	bh=MGwZ9gBZ4KkZX7u0wW1sZxVaPrqqEwvC4/Pdc6IuJIo=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=M8GYiPdwGmwMZuG7ub7wRjw/eHIdFqyomAQsthOrSUaOXK/7BflkUGW6u+s6ufkaT
	 jgrguZ/HqK802XaNXcxGYmGi5zcpKxaEfo2ahsOJvIQPGKv4v483FemMtiaitkyLva
	 T2K9pB34jKb5V397IS8xGbP2Bqn3Np6xHHirsnKuCnk2tlSeDykY8TfJNqLrF7qAeG
	 BAOSHrDLpCZ73K55AKzmZFF69jxy1IYqydgqrWvHbVsm/xer9WTwvgw5c4NDvJNknX
	 SSBYdftggmCy6zxQQI2iQarrZyEnp529Mr1b1WaRPQSiUvRjujT319oCMzr6MhTySg
	 lgXXU2hWmZxTQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7939D380CEEE;
	Fri, 21 Feb 2025 14:50:08 +0000 (UTC)
From: Jeff Layton via Bugspray Bot <bugbot@kernel.org>
Date: Fri, 21 Feb 2025 14:50:38 +0000
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: anna@kernel.org, chuck.lever@oracle.com, linux-nfs@vger.kernel.org, 
 benoit.gschwind@minesparis.psl.eu, carnil@debian.org, tom@talpey.com, 
 harald.dunkel@aixigo.com, cel@kernel.org, baptiste.pellegrin@ac-grenoble.fr, 
 jlayton@kernel.org, herzog@phys.ethz.ch, trondmy@kernel.org
Message-ID: <20250221-b219710c34-2b8d1ec78c79@bugzilla.kernel.org>
In-Reply-To: <PR3PR01MB69723701495481CCA7D55F0585C72@PR3PR01MB6972.eurprd01.prod.exchangelabs.com>
References: <PR3PR01MB69723701495481CCA7D55F0585C72@PR3PR01MB6972.eurprd01.prod.exchangelabs.com>
Subject: Re: NFSD threads hang when destroying a session or client ID
X-Bugzilla-Product: File System
X-Bugzilla-Component: NFSD
X-Mailer: bugspray 0.1-dev

Jeff Layton writes via Kernel.org Bugzilla:

(In reply to Bugspray Bot from comment #30)
> 
> So I see the backport of 961b4b5e86bf NFSD: Reset cb_seq_status after
> NFS4ERR_DELAY landed in the just released 6.1.129 stable version.
> 
> Do we consider this to be sufficient to have stabilized the situation
> about this issue? (I do  realize much other work has dne as well which
> partially has flown down to stable series already).
> 

That seems to have the two patches that I would consider most likely to fix the hangs reported here:

036ac2778f7b28885814c6fbc07e156ad1624d03
961b4b5e86bf56a2e4b567f81682defa5cba957e

View: https://bugzilla.kernel.org/show_bug.cgi?id=219710#c34
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)


