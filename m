Return-Path: <linux-nfs+bounces-5801-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09FAA960ACA
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Aug 2024 14:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D1691C21F4E
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Aug 2024 12:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B9219D067;
	Tue, 27 Aug 2024 12:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="VGykOBse";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TmtCtkId"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7FA199EAC;
	Tue, 27 Aug 2024 12:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724762788; cv=none; b=busHVnhq6C4qM/c2lcBSQq2CcMQERAAzDYQYLdRODPEkzUshWcF4oIFNIzYEOw2fJVzKxrhLZNXqIlR0O0jdUKwaQnsV2VKQ+tZxfcS/ItOH6blnwi4PaJiNINeKEQs290AYDHCRqwvrVpqDU3ff87UncROkn48uFuvkhUcv1EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724762788; c=relaxed/simple;
	bh=gzbXBsQTHRF2WbahLDwk/MXb+B86YP3FzDV1nh0kZEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FivdxErgIj2Le4QMBdOrQQu2WCjbXAllmMmMMFYKgASPD1p8fPcufZUg7gUqbyZ4Q+bUERGFjc1qvlUuMtYKFD0hInTDtmeyAOioDtyzDQkSyq6rzQJy+28AlS7RnvQfDRij4eU344cOUASgDQfED+CqKeKDW4YIEjre50KN1sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=VGykOBse; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TmtCtkId; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-04.internal (phl-compute-04.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id F11741151A7F;
	Tue, 27 Aug 2024 08:46:25 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 27 Aug 2024 08:46:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724762785; x=1724849185; bh=1lZIvyeQuh
	AKo2IwTN4mlf9dailMWjqRXUpqW5KskEU=; b=VGykOBseA+Cgow2L4nt1UApo87
	1xP74eyDEe3JfSpj9GWTfMQIunQ1DKX02I/CGXdVgPmBuXWb2JVStTRBjwfg86Mw
	ULXYZcQhtJ1vVh0Bc9Bfgu1jAcoyLZ2LyCkSOh6cP3WSHI+nSbu1X3y8IkwT8g5W
	WCZC38MsO5MyY+rfoFS1OYAXIJiXGLKX2wU3cPFRx4nwfzvf7GFANmEgTwQEmAZi
	a5Db4Ej4pJm2h9tjknjoQckmKOeZyKQCR9TV9wCk6aameODoFI3cnyYY/5/Cprpi
	mc19zaDzDBcW0eEGEyEEb6U7m/YE8gW2DEGRvHh8/nF/WxJMYKqtgXjco6fQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724762785; x=1724849185; bh=1lZIvyeQuhAKo2IwTN4mlf9dailM
	WjqRXUpqW5KskEU=; b=TmtCtkId/iYXyynYDnSUCEGaLfzghS5+q6QDs7zxZVd8
	M9B6DV3pxQEqX0hbG/wb6A7pUPijwiYFb1XGUoxXRmYngfapsF0rqZ+Vni5GORIn
	u0Na03fq5w1x0UvY1iPO4IOgBDGT80PZ5HrnFDooc3bjT/ghFbmJ/MYy3oKmJXZw
	ioSAm9i5islMrK3dK8MPkCmQ0eUnuB7XIfxSVHTaFhrvIwfDJx6Ztr17ZPAM9mGq
	yNeA48n2Ulc1fCrZtWeIoOO9pJJY8K3q54BZFvU6/u2VGb3uYCcBAF6QNFPQ0cO/
	5LQ40sJta5F0gC2ZdN1LHLQ9g2WD3G0XrH7b9jzXmA==
X-ME-Sender: <xms:ocrNZl8tJKAOHbfRb4uJ0dUxWefYIfs2qBETpIDAQ2DOcBLnpDJPNA>
    <xme:ocrNZpvHtC1ZGBfHehrG5y4Vn8o_WDLlM-H5E29Gs6e3skTyTzW0SeUPsEC16LwgC
    Ll-7qHC6O0rdw>
X-ME-Received: <xmr:ocrNZjCXkkWSSeycwhF3flnM4v2zLexEhSm7INPMM2ILUDzlNmJf_hwSdfn2ix8byup3IejaLWWgn4QQgLHUMdUI1bUFej79NPHRBg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeftddgheeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrf
    grthhtvghrnhepheegvdevvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefh
    gfehkeetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epghhrvghgsehkrhhorghhrdgtohhmpdhnsggprhgtphhtthhopeduvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheptggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epshhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhu
    gidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhlihhngh
    hfvghnghefsehhuhgrfigvihdrtghomhdprhgtphhtthhopehnvghilhgssehsuhhsvgdr
    uggvpdhrtghpthhtohepjhhlrgihthhonheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:ocrNZpfrYpjtiLSJlU9UjXNe9vbDC-0-T79d5wsgWgDUBQkUpHilkw>
    <xmx:ocrNZqO9Px_h1PEgEIdCjTaJ1z1jcNfS3zwG2U_ZAPGzqFRahgvEQA>
    <xmx:ocrNZrnMrj_pZ4GDt7Oo5SVEpaVt8v5b4K0AxGh7FdtAfeXOc-t5EA>
    <xmx:ocrNZkvyhMSMFXBQTDi6p5hHHwfaAPvPd9DV_sh8Wos4vGQ4HgdYGw>
    <xmx:ocrNZmkbToDzu1SKIShy2B6Rb2g8qcf_5g246u0mZ84jVQg9ErC1lZTi>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Aug 2024 08:46:24 -0400 (EDT)
Date: Tue, 27 Aug 2024 14:46:23 +0200
From: Greg KH <greg@kroah.com>
To: cel@kernel.org
Cc: stable@vger.kernel.org, linux-nfs@vger.kernel.org,
	lilingfeng3@huawei.com, NeilBrown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH 6.6.y] NFSD: simplify error paths in nfsd_svc()
Message-ID: <2024082712-haiku-take-ef45@gregkh>
References: <20240824162137.2157-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240824162137.2157-1-cel@kernel.org>

On Sat, Aug 24, 2024 at 12:21:37PM -0400, cel@kernel.org wrote:
> From: NeilBrown <neilb@suse.de>
> 
> [ Upstream commit bf32075256e9dd9c6b736859e2c5813981339908 ]
> 
> The error paths in nfsd_svc() are needlessly complex and can result in a
> final call to svc_put() without nfsd_last_thread() being called.  This
> results in the listening sockets not being closed properly.
> 
> The per-netns setup provided by nfsd_startup_new() and removed by
> nfsd_shutdown_net() is needed precisely when there are running threads.
> So we don't need nfsd_up_before.  We don't need to know if it *was* up.
> We only need to know if any threads are left.  If none are, then we must
> call nfsd_shutdown_net().  But we don't need to do that explicitly as
> nfsd_last_thread() does that for us.
> 
> So simply call nfsd_last_thread() before the last svc_put() if there are
> no running threads.  That will always do the right thing.
> 
> Also discard:
>  pr_info("nfsd: last server has exited, flushing export cache\n");
> It may not be true if an attempt to start the first server failed, and
> it isn't particularly helpful and it simply reports normal behaviour.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/nfssvc.c | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
> 
> Reported-by: Li Lingfeng <lilingfeng3@huawei.com>
> Suggested-by: Li Lingfeng <lilingfeng3@huawei.com>
> Tested-by: Li Lingfeng <lilingfeng3@huawei.com>

Odd placement of these :)

Now queued up.

greg k-h

