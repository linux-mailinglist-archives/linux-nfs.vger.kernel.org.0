Return-Path: <linux-nfs+bounces-3697-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 287899055A1
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Jun 2024 16:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 481B01C2089B
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Jun 2024 14:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50DB617F36D;
	Wed, 12 Jun 2024 14:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="vlgLCFKJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HdgP3Wnb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from wfhigh7-smtp.messagingengine.com (wfhigh7-smtp.messagingengine.com [64.147.123.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBCA17E8F6;
	Wed, 12 Jun 2024 14:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718203620; cv=none; b=hDHOGDUIkwralhqyV7J9xNQbLXCHJg2sWUJyL3DAwLQ8kc1+O7SCKO2Est5/Gkr7PlSVOpaiTl7PIriAIegTPpVE6TrDFnqK/jhzC/v9TcdHRkBZiIYkCogMUleHXOjC7aNjPOWjWXmX2GpLpjpTZrA0PoDnXsQOYJWRGLeJGsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718203620; c=relaxed/simple;
	bh=nArazFaFR21wY+KcYy+uuQII0TM/lXIvkAhW/C65GCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t3anUUs8+FX4HcxxdPNlR7CCh8x3H63sGlRRxL2FQOWjWGx/T5AXqGuqg9cK0ks+k1PAbAbkgW0xe1U/ci4U1EMp+Gr7/VF1jT9T0jzxlbv7r+8MqwCrBXosI3m34qII0iCyign11UFS2Qv2xOWLWLEQatsKHIG4kmi8dwUxxy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=vlgLCFKJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HdgP3Wnb; arc=none smtp.client-ip=64.147.123.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.west.internal (Postfix) with ESMTP id 2837E18000C6;
	Wed, 12 Jun 2024 10:46:57 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 12 Jun 2024 10:46:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718203616; x=1718290016; bh=EiGiFI0OeI
	fncTCYtyNqrwlgguq4p7gDXwhBcuV+SEo=; b=vlgLCFKJ0ZKlctGOrQPy6AuOvO
	Cj4IrlqA/Dad/a3mGrPidHWhAbVfqDr55fWfFW1inBA8BcvYaAQ56ydmprsie4wL
	TXEkIcxDrg8pxUBuaXgy15Ra7p7uCSwQilRqN7+QXc18v5fFzNtvUaD3e4Utfkfz
	acCQnvkKkRzfmxdgoHvUTctvFJhCsfw2PIzGnJrj22co4K0syHvqFbO6C1Ao6dIl
	YUCfL3ngrV7Y4LbLgL8v1Affgei34fkQszE8ymQrJEKhJOq3X1f0GyGmF/3TRNv7
	nDHiu2umSikMGYJ3sS0wx3PllClTFzQS1DDwhzPqZiZu2gnAmP3t0atBYkIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718203616; x=1718290016; bh=EiGiFI0OeIfncTCYtyNqrwlgguq4
	p7gDXwhBcuV+SEo=; b=HdgP3WnbEpfxfq5LS44lYSNF7+rjvUCS8FFn0F5HSCLx
	eQQga0apeNmUWUoReeSk/6IW1+yQTjFOsW28GENKRZCiun0lmWps5IVbzkG+VR6C
	RHT1fbrOlszSg4cR49C75jWAequL8btpC3vX4lm4nThcxZ7wk62Wcy19QA/fAJbU
	4h3BKOoMySO3R454GNpHJ44N4I1BWTIZHao/C+/Ds32zYP5Zlma6kUz4lm5Lsq11
	f9mcaZckadqIoiK6FMtTKykBFDa+FdZDf96sCeY9+ojQPU8CHwJVFN9kIii4NyJR
	AFl3QFxAyNd4eJvwZd4vckI45Okfjc23Gbf7lA+GLw==
X-ME-Sender: <xms:4LRpZoz8IBtBXvauwjZuk_pj8Te1Og1yaN6GBEpJ-eJxtAAL3uKT9Q>
    <xme:4LRpZsRr97ANUF_jzgtpQqqTqLINfm3NXKYKCLQftcF2VsuTw0sIOdvUP119MAbO7
    Bgwc0GTeSG6FQ>
X-ME-Received: <xmr:4LRpZqVSO-zqmZJhotTZ829zNrnOhqO9f-PycYeVZ5antObNssBLxIpK3TThX5WdjqR5SeuaW1eK2IBc3xnHBslobx3-B5wFtBkO3w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedugedgjeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttd
    ertddttddvnecuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhm
    qeenucggtffrrghtthgvrhhnpeehgedvvedvleejuefgtdduudfhkeeltdeihfevjeekje
    euhfdtueefhffgheekteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:4LRpZmjagWyifeMHhYGzcW11Z389O0bs5MFbCLBwmsVsW--Q_un5Nw>
    <xmx:4LRpZqAyp6H2fNTx1CDssOB4UmL7uxxSBaiIHbvTgmYqLyW3z0FE8Q>
    <xmx:4LRpZnLqEvjRbbxmajKV2gqbMyw8Z9j1APHJBD2rsZSagO7LWq2wRw>
    <xmx:4LRpZhDQZQ648UBuQOCJiDXi9YwPqDa6RVKugBOhpVx-41doTszQRw>
    <xmx:4LRpZu6sv9pjO53e7RBege7Zwuz2MJkDyTaesZWg8_ijSLypknxlZooF>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Jun 2024 10:46:56 -0400 (EDT)
Date: Wed, 12 Jun 2024 16:46:54 +0200
From: Greg KH <greg@kroah.com>
To: cel@kernel.org
Cc: stable@vger.kernel.org, linux-nfs@vger.kernel.org,
	NeilBrown <neilb@suse.de>, Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH 5.15] sunrpc: exclude from freezer when waiting for
 requests:
Message-ID: <2024061245-climate-sedation-d03f@gregkh>
References: <20240607131048.8795-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607131048.8795-1-cel@kernel.org>

On Fri, Jun 07, 2024 at 09:10:48AM -0400, cel@kernel.org wrote:
> From: NeilBrown <neilb@suse.de>
> 
> Prior to v6.1, the freezer will only wake a kernel thread from an
> uninterruptible sleep.  Since we changed svc_get_next_xprt() to use and
> IDLE sleep the freezer cannot wake it.  We need to tell the freezer to
> ignore it instead.
> 
> To make this work with only upstream commits, 5.15.y would need
> commit f5d39b020809 ("freezer,sched: Rewrite core freezer logic")
> which allows non-interruptible sleeps to be woken by the freezer.
> 
> Fixes: 9b8a8e5e8129 ("nfsd: don't allow nfsd threads to be signalled.")
> Tested-by: Jon Hunter <jonathanh@nvidia.com>
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/nfs/callback.c     | 2 +-
>  fs/nfsd/nfs4proc.c    | 3 ++-
>  net/sunrpc/svc_xprt.c | 4 ++--
>  3 files changed, 5 insertions(+), 4 deletions(-)

Sorry for the delay, now queued up.

greg k-h

