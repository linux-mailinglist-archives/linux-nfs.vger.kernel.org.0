Return-Path: <linux-nfs+bounces-16164-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C394C3FB14
	for <lists+linux-nfs@lfdr.de>; Fri, 07 Nov 2025 12:17:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5CCAE4EE403
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Nov 2025 11:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1F1320CC2;
	Fri,  7 Nov 2025 11:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="CIxH4+JH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ghCBnvDO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833641F5821;
	Fri,  7 Nov 2025 11:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762514259; cv=none; b=i5gJwBuTS72sdWBhfJwpHwfYkFpPJ3QXI6SdaxxM+nsWQd+0pbrSfheJnTj0YIPMGTDxrNo0HOv+2i6IwSFBYfiTF6iXkm/clow1Uom8kGbyhSjugtR/4G1HwkYatmC4WCh4tr09w11ndAX290aAQSG37WwJyfqSOyIFi4Z9DsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762514259; c=relaxed/simple;
	bh=Y9pUCfcFi4AsEJHJltTCRril7hFnOkYG0tyEo8NBeFg=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=tfCunUB9VUgJ6YTiLHtqWqyvhj/PsxKg7OIjKdAWX51jgsCrlHf7aNijX/Zx+dfafCYhXGD63fIde5dwS3CuMAeiPbROEWxGHUqcgzny/ElILwlQujHHj4nFN1KAW4i7JEbopaiYQvk/oEx53dzZBROrPqhjUfFMWuPe2C+nIH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=CIxH4+JH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ghCBnvDO; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 4F60B1D00149;
	Fri,  7 Nov 2025 06:17:35 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 07 Nov 2025 06:17:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1762514255; x=1762600655; bh=BBzJnnctCnq4Fcyhvxggl9CB8DYe4i8BJNv
	opXA2dBs=; b=CIxH4+JHa2AOTOyFspUql3H/vqlFrzbrSO/NjyqXPiC2sdj8AVB
	maNeRVlSZAcLLc/VsqivXSGEcf94YBo1Newtl90xemViH4OYbYXJU7vyft23yjkS
	KSjj4I9tbY7Tpxcpbb4gxrQik45Tm42kRyWos+sQ34GMWHdwpQ5xuzHYWGynvuoF
	Iq2CZw8PKEaFhP/IHfWXxqPjyQQQdaFRSilliOepB1/F+gSTsTUEIsDc9SsTXyfO
	4hkVVlj4918R3u0tyDXj0y0GvpRA9duTM8jWsgNkNT6ktlVhVaWb8fZie9nIZkRd
	+CEP12CdDW/XreIeBlEk/Y/+1Mi5WW86KMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762514255; x=
	1762600655; bh=BBzJnnctCnq4Fcyhvxggl9CB8DYe4i8BJNvopXA2dBs=; b=g
	hCBnvDOJ4EuRX5QTbG9wrnoQXEoGLPEWjdom+5QjeYOXzhQ/Z8WvcaU6tlFtoJm+
	7jjbgYTroGPrqngoFE147RZsbhrtRJF3yPWlnTsODstodSzyLYX2Oelu3hjKjvia
	QuEMDAoZIZL32HyzbPHLbpOklMzkwoSeXkTLFS5RL9wYkpjz1Df+YfIhVJTRSIfU
	bj450jcs/BpLb4WJz1eLDO/pbTzrZVKrN8XazAne5YGNjcQu5dvJjU4XSIrnOJxF
	cYwcrh2IPkjre2WpuUdM07pfqLTa4Cffrd8/U9SHW/Apcthqnfmcpf9/Fv/ngfh1
	E6e9YZC0QZhAcRYMC11ZA==
X-ME-Sender: <xms:TtUNaYs0uvLVFFCyvD_8DfaSdGHQ-37Sf9L55YaURw3jXyY2deyViA>
    <xme:TtUNaRc_WX-_83TnheJz7KtwST_KrnfE9Qk89OiznRBWE3SKx_1YZ5RrxqTyOpOqq
    g6RuSzxs3swrh8tLBmJWHZivhNGreWbdAJkSYEVRrmJUGfODQ>
X-ME-Received: <xmr:TtUNaV_XpQVM1AH9oe-T2sDfB_qirhgiaxNgtGjaAeJfewzRrmM5F2_Ly6RtpX-vck8ayhwAbYqEgb-AKoCCQqXiBjfekVLVispmOjkwvDGb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeelhedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtjeertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epgeehfeevheehteetudehjeduiefhueehieevvdejkeeufeevkeelieffffduhfevnecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehnvghilhgssehofihnmhgrihhlrdhnvghtpdhnsggp
    rhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsthgrsghlvg
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhnfhhssehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghkphhmsehlihhnuhigqdhf
    ohhunhgurghtihhonhdrohhrghdprhgtphhtthhopegtvghlsehkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehsphgvvggutghrrggtkhgvrheshhhothhmrghilhdrtghomhdprhgt
    phhtthhopegurghvihgurdhlrghighhhthdrlhhinhhugiesghhmrghilhdrtghomhdprh
    gtphhtthhopegurghvihgurdhlrghighhhthesrggtuhhlrggsrdgtohhm
X-ME-Proxy: <xmx:TtUNacTtY4f33CCyCn7XaQghQ8b0lqIHX9-ooYPf8lRWqp4KxxROZw>
    <xmx:TtUNaWop-ByXFOldZ-xsyF5cp7mdV5n-KujEEwrMGwVOv4HthesJ_w>
    <xmx:TtUNaZmTI3IkTimhuisxgGiLwx3y-4IWqCg0zBCbzASnqihUygUzjA>
    <xmx:TtUNafd9TdB4ll859qYjl6MA9tvEmbDVTV89LfuBik2ycadxRkLZUg>
    <xmx:T9UNaRmvNsoXUjsACfHe8Ip7M8Xg3XEdNZC716U44UxJOZgDT5iuATIz>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Nov 2025 06:17:32 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "David Laight" <david.laight.linux@gmail.com>
Cc: "Chuck Lever" <cel@kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "David Laight" <David.Laight@ACULAB.COM>,
 "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>,
 "Linux List Kernel Mailing" <linux-kernel@vger.kernel.org>,
 speedcracker@hotmail.com
Subject: Re: Compile Error fs/nfsd/nfs4state.o - clamp() low limit slotsize
 greater than high limit total_avail/scale_factor
In-reply-to: <20251106192210.1b6a3ca0@pumpkin>
References: <bbba88825d7b2b06031c1b085d76787a2502d70e.camel@kernel.org>,
 <37bc1037-37d8-4168-afc9-da8e2d1dd26b@kernel.org>,
 <20251106192210.1b6a3ca0@pumpkin>
Date: Fri, 07 Nov 2025 22:17:20 +1100
Message-id: <176251424056.634289.13464296772500147856@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Fri, 07 Nov 2025, David Laight wrote:
> On Thu, 6 Nov 2025 09:33:28 -0500
> Chuck Lever <cel@kernel.org> wrote:
> 
> > FYI
> > 
> > https://bugzilla.kernel.org/show_bug.cgi?id=220745
> 
> Ugg - that code is horrid.
> It seems to have got deleted since, but it is:
> 
> 	u32 slotsize = slot_bytes(ca);
> 	u32 num = ca->maxreqs;
> 	unsigned long avail, total_avail;
> 	unsigned int scale_factor;
> 
> 	spin_lock(&nfsd_drc_lock);
> 	if (nfsd_drc_max_mem > nfsd_drc_mem_used)
> 		total_avail = nfsd_drc_max_mem - nfsd_drc_mem_used;
> 	else
> 		/* We have handed out more space than we chose in
> 		 * set_max_drc() to allow.  That isn't really a
> 		 * problem as long as that doesn't make us think we
> 		 * have lots more due to integer overflow.
> 		 */
> 		total_avail = 0;
> 	avail = min((unsigned long)NFSD_MAX_MEM_PER_SESSION, total_avail);
> 	/*
> 	 * Never use more than a fraction of the remaining memory,
> 	 * unless it's the only way to give this client a slot.
> 	 * The chosen fraction is either 1/8 or 1/number of threads,
> 	 * whichever is smaller.  This ensures there are adequate
> 	 * slots to support multiple clients per thread.
> 	 * Give the client one slot even if that would require
> 	 * over-allocation--it is better than failure.
> 	 */
> 	scale_factor = max_t(unsigned int, 8, nn->nfsd_serv->sv_nrthreads);
> 
> 	avail = clamp_t(unsigned long, avail, slotsize,
> 			total_avail/scale_factor);
> 	num = min_t(int, num, avail / slotsize);
> 	num = max_t(int, num, 1);
> 
> Lets rework it a bit...
> 	if (nfsd_drc_max_mem > nfsd_drc_mem_used) {
> 		total_avail = nfsd_drc_max_mem - nfsd_drc_mem_used;
> 		avail = min(NFSD_MAX_MEM_PER_SESSION, total_avail);
> 		avail = clamp(avail, n + sizeof(xxx), total_avail/8)
> 	} else {
> 		total_avail = 0;
> 		avail = 0;
> 		avail = clamp(0, n + sizeof(xxx), 0);
> 	}
> 
> Neither of those clamp() are sane at all - should be clamp(val, lo, hi)
> with 'lo <= hi' otherwise the result is dependant on the order of the
> comparisons.
> The compiler sees the second one and rightly bleats.

In fact only gcc-9 bleats.

gcc-7 gcc-10 gcc-13 gcc-15
all seem to think it is fine.

NeilBrown

