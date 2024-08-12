Return-Path: <linux-nfs+bounces-5317-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5496B94EF1B
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Aug 2024 16:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97AD9B227C3
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Aug 2024 14:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2054D433DD;
	Mon, 12 Aug 2024 14:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="d9q1Uvf6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hBKrlmcK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67E817C226;
	Mon, 12 Aug 2024 14:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723471365; cv=none; b=kf8HQS+wCyJDWMcGLeB6geOHoPn/HmeJ7ml6xtq7oLgTdenVvpFK6VqifB6GI/Hyawewt2i7hg3U9mo9O2PlQ0GCL9ehi5QPbGPvaq0jGDrwXS0lIFFCbKqI1Jp1nb1akEj5kuM2HxugFZ/5BQNVzX8noQ+7iZDy/RUjhWBqF8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723471365; c=relaxed/simple;
	bh=WhFbvUjRQovAHb6gX543PiiB6lFuUR/l7JrePdfQorY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lqTxO2dKWakw8J59zH0jxZjB5PsWbRFgEMjR4CqdHD4Cp76Duk6CUdEqH9orEN6pe5yUZNEj7rYh1uQkXw2Wsam3MV0/lYoytsmBwfF20j6jFRdCgsArWBnCX5S9SiuGuFHgXirkChhDGAPP2yT1uMyV42PoxjQIBU1PUH87g3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=d9q1Uvf6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hBKrlmcK; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-02.internal (phl-compute-02.nyi.internal [10.202.2.42])
	by mailfout.nyi.internal (Postfix) with ESMTP id E7BE1138D6F6;
	Mon, 12 Aug 2024 10:02:41 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 12 Aug 2024 10:02:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1723471361;
	 x=1723557761; bh=9lY9JDS7kGr4Oa679bFMiFw2WgTYDNc/F/B4G4Uormc=; b=
	d9q1Uvf6+OjRUU23Yw4LLTquf8nPj3n19IMunxwQussv73RFDOMG9vI2aoV5Mt4P
	EVkXVeqSnxEXd9o0G+iKmnUE5MxkV40o022GIRNtHtrgvmQLf9NOLbU26ggbM1jV
	HO4zv+CsEStaccugHj+auj+P+a7Lz8D+JX6m47/qm8jX02Tc73BXjKDsRZmzS7pg
	4JdRcPrSNDffPJ0eVRqsOEepZIja1PPfHbQ68wlprM2De/Vhktjle8qHqticB1G/
	ye+WRbXd+bVp6ScxUpeYFLXXh+YVS5dcEGoL9o1upUwb7jQjeyz8WJBVelPJ215j
	QVqgxaMQdNdkfxhPq0dhEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1723471361; x=
	1723557761; bh=9lY9JDS7kGr4Oa679bFMiFw2WgTYDNc/F/B4G4Uormc=; b=h
	BKrlmcKLs5emDkxVdZOrtM6ramG9Tr7e0e3YBzP9ziJg3LTfnm4dPmHr+vqwfdFF
	theksbOUoTr7lDoOaHJT+TZNsCv/iZh5qgg533v/jIHYPdH+XxIa2Uu1DEvbCi0M
	T9XpKLEECsWv+gLNzScjNoMkas070P9qqBJzQkxQEi/ntXfF3iGwiCDAFlEttYTx
	/ISNkkABw1AQKsFUSA1H0xYc0HEm9aH2C0K8hwtYd8owQQjg/I1OxwhW2t52Rszm
	5AJWJ1dejkxo3qVhZ1gG2RDuwVUfvg3EvUNVCScXWZXgEutGpQPw0Pm8mjO3zwZH
	NBPAtljuaGmiPLII1pfwg==
X-ME-Sender: <xms:ARa6ZvkSC_WlmjhP3EjUL4YzjRxRLx59BhpB3cUdLzV6SWI4WR6f9A>
    <xme:ARa6Zi3mRPztZZR3Tv2QyY2MFjHsH1b3_XCDzJkkRW8J0SWOKu-QNp_ufzynNqCdQ
    AIE3UIUrcejQA>
X-ME-Received: <xmr:ARa6ZlrH_n7wnCNCuR0l_NJKMQMLf06bE8Gx22CrRT_R85Q2d7QRf9C-HYKpi9o0O05UW5bdn3AM98Vdf7tD_p57pr20QPTI_Jgbrw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddttddgjeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtf
    frrghtthgvrhhnpeelkeehjeejieehjedvteehjeevkedugeeuiefgfedufefgfffhfeet
    ueeikedufeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
    pdhnsggprhgtphhtthhopedvtddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptg
    hhuhgtkhdrlhgvvhgvrhesohhrrggtlhgvrdgtohhmpdhrtghpthhtohepshgrshhhrghl
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtvghlsehkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehsthgrsghlvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepph
    hvohhrvghlsehsuhhsvgdrtgiipdhrtghpthhtohepshhhvghrrhihrdihrghnghesohhr
    rggtlhgvrdgtohhmpdhrtghpthhtoheptggrlhhumhdrmhgrtghkrgihsehorhgrtghlvg
    drtghomhdprhgtphhtthhopehkvghrnhgvlhdqthgvrghmsehfsgdrtghomh
X-ME-Proxy: <xmx:ARa6ZnkpcRFeY6dxaoazyBjJ-EI9nIpPTvinRORYP9u7dxtR5Jcg3w>
    <xmx:ARa6Zt0iQX5W9p_XnM8LeZbsSSGcFQZCwIe-2i6VA4aiuxyQRnu8Dw>
    <xmx:ARa6ZmsCsZFKkJxh8JD7Lv2rPJayxop72BJdqoac3_QoMDpSDCE4MA>
    <xmx:ARa6ZhW7y4eRVhkys2FtsJKQsOP0hy6568UluJiu0hgN4haWM-eTzw>
    <xmx:ARa6ZvXAkuWOaAieq5EgXlF62yyQ1dEDFxAdm3n-pGXaapdyiGm4Hco6>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Aug 2024 10:02:40 -0400 (EDT)
Date: Mon, 12 Aug 2024 16:02:39 +0200
From: Greg KH <greg@kroah.com>
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Sasha Levin <sashal@kernel.org>, Chuck Lever <cel@kernel.org>,
	linux-stable <stable@vger.kernel.org>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
	Petr Vorel <pvorel@suse.cz>, Sherry Yang <sherry.yang@oracle.com>,
	Calum Mackay <calum.mackay@oracle.com>,
	"kernel-team@fb.com" <kernel-team@fb.com>,
	"ltp@lists.linux.it" <ltp@lists.linux.it>
Subject: Re: [PATCH 6.1.y 00/18] Backport "make svc_stat per-net instead of
 global"
Message-ID: <2024081214-sizzle-repave-65f5@gregkh>
References: <20240810200009.9882-1-cel@kernel.org>
 <ZrnzLoZ8Tj9GhRSO@sashalap>
 <A0BF8EAF-A16D-4200-8362-E833BA23159D@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <A0BF8EAF-A16D-4200-8362-E833BA23159D@oracle.com>

On Mon, Aug 12, 2024 at 01:52:18PM +0000, Chuck Lever III wrote:
> 
> 
> > On Aug 12, 2024, at 7:34 AM, Sasha Levin <sashal@kernel.org> wrote:
> > 
> > On Sat, Aug 10, 2024 at 03:59:51PM -0400, cel@kernel.org wrote:
> >> From: Chuck Lever <chuck.lever@oracle.com>
> >> 
> >> Following up on
> >> 
> >> https://lore.kernel.org/linux-nfs/d4b235df-4ee5-4824-9d48-e3b3c1f1f4d1@oracle.com/
> >> 
> >> Here is a backport series targeting origin/linux-6.1.y that closes
> >> the information leak described in the above thread.
> >> 
> >> I started with v6.1.y because that is the most recent LTS kernel
> >> and thus the closest to upstream. I plan to look at 5.15 and 5.10
> >> LTS too if this series is applied to v6.1.y.
> > 
> > 6.6 would be the most recent LTS, and we would need to have this series
> > on top of 6.6 first before we can backport it to older trees :)
> 
> Fair enough -- I was told this work was already in 6.6.y, which
> is why I started with v6.1. I'll take care of it.

Only the first few commits are in 6.6.y already, and those don't make
much sense to take into 6.1.y now as they don't do anything on their
own.

thanks,

greg k-h

