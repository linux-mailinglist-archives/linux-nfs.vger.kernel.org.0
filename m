Return-Path: <linux-nfs+bounces-4249-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A3B9140FC
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Jun 2024 06:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1B6E1C20473
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Jun 2024 04:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8776FB1;
	Mon, 24 Jun 2024 04:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="rx5Bb+vk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from submarine.notk.org (62-210-214-84.rev.poneytelecom.eu [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270AD10E3;
	Mon, 24 Jun 2024 04:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719202509; cv=none; b=KzDx/vZsa1h+ibaMskJ1i4fcIomFiNaPg31tkNV8CUYqeFjpWKa1kLoFS4pX4WK+TjYg1Tye1XX7oX3gxMkxzMEORfym3McAL0FJPtD8FY/GOxIWWrnyO5EU13NQr3yaJSaVAd/ZK6bY1fga8bvHIVIr+R/H6tHrD20zTHcQBOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719202509; c=relaxed/simple;
	bh=OO3eVPJfqR8uQ/tF25yIJliDMLzEPmC2ri7ao1o4Qrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dSypV+XBk5gFhhJ3keM3izzo1PCHel1LQmnqRzyxGWJ7/B56QqNbpuCZAHPx3WFHN6KcplH0CWetkMiE+HHGhXY+9A14r9Y2cf+2aj1FL3Q4bvPvVPKP5+kkEWd4seQmVSm2LzSt5rPjKKjLVFEkmWq8k2vZMqu+cl9DF9DjzyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=rx5Bb+vk; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id D2AF414C1E3;
	Mon, 24 Jun 2024 06:14:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1719202500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R9iHpqE/JMKLqnOR6i69QRli3F9llvJfQqqDJaK7brw=;
	b=rx5Bb+vk96T9QyUEX9+AQznze5tTLoRMTm8wMUDn+D6TpHQBtUwU+nhVsM6tUefO9oLPEZ
	o6FLRNtEe+mqdnCssju6rc/JqKoG6GLO2uMdHZy7lftXrGIeNcmAU/a3QsxQgeBu6EGM5I
	132lQjLzNuAlmMxdkmO4N64PUy07zuviqidutpvw0a5gUQwWzO1wbsii+3ZtyCRu7LvWoc
	fJoXz0dtZ/nkBq6awWKFZuSFAA94iOWeCtuOUWTxshTZzmF7uqGvUNh2Zox06i5Krfjw0Q
	iEnaM5WT2Jll9jrJkaNA1HW53aSLgVnlGWKZhNqfRFJeMPaKxa1F/Hpnl82Tcw==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 35e5ef12;
	Mon, 24 Jun 2024 04:14:52 +0000 (UTC)
Date: Mon, 24 Jun 2024 13:14:37 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	NeilBrown <neilb@suse.de>, Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>, Jeff Layton <jlayton@kernel.org>,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH 5.10 762/770] nfsd: separate nfsd_last_thread() from
 nfsd_put()
Message-ID: <ZnjyrccU0LXAFrZe@codewreck.org>
References: <20240618123407.280171066@linuxfoundation.org>
 <20240618123436.685336265@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240618123436.685336265@linuxfoundation.org>

Hi Greg,

(+Jeff & linux-nfs in Ccs)

Greg Kroah-Hartman wrote on Tue, Jun 18, 2024 at 02:40:15PM +0200:
> [ Upstream commit 9f28a971ee9fdf1bf8ce8c88b103f483be610277 ]

Playing with dyad in the 'vulns' repo, I noticed this commit got
reverted in the 6.1 tree by pure chance as I just happened to test it on
a related commit and wondered why the 6.1 kernel was listed twice:
b2c545c39877 ("Revert "nfsd: separate nfsd_last_thread() from nfsd_put()"")
db5f2f4db8b7 ("Revert "nfsd: call nfsd_last_thread() before final nfsd_put()"")

See this thread for the discussion that caused that revert:
https://lore.kernel.org/all/e341cb408b5663d8c91b8fa57b41bb984be43448.camel@kernel.org/


What made me look is that they got in 5.10/15 (without revert):

5.10 tree (since v5.10.220)
838a602db75d ("nfsd: call nfsd_last_thread() before final nfsd_put()")
d31cd25f5501 ("nfsd: separate nfsd_last_thread() from nfsd_put()")

5.15 tree (since v5.15.154)
c52fee7a1f98 ("nfsd: call nfsd_last_thread() before final nfsd_put()")
56e5eeff6cfa ("nfsd: separate nfsd_last_thread() from nfsd_put()")


I considered trying to revert them as well, but it looks like they've
been fixed by this commit (upstream id):
64e6304169f1 ("nfsd: drop the nfsd_put helper")
which wasn't in 6.1, so perhaps that's all there is to it and I'm
worried too much?

Jeff, you're the one who suggested reverting the two back then, sorry to
dump it on you but do you remember the kind of problems you ran into?
Is there any chance it would have gone unoticed in the 5.15 tree for
2.5 months? (5.15.154 was April 2024)

(Bonus question: if that is really all there is, would that make sense
/ should we take the commits back in 6.1 with that extra fix?)


Thanks,
-- 
Dominique Martinet | Asmadeus

