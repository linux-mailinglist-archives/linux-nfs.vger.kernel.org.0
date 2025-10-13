Return-Path: <linux-nfs+bounces-15169-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF017BD1638
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Oct 2025 06:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E56CC1890EBD
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Oct 2025 04:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2832727E0;
	Mon, 13 Oct 2025 04:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="lwejfeKH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iIrFfdyh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D2D221739
	for <linux-nfs@vger.kernel.org>; Mon, 13 Oct 2025 04:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760330621; cv=none; b=UXAF36LftyPGdnLi0Ala+GV6+9C5fq+XOGLBreATRPQSzM4asEtxiOzV3Iog+/WfKEg7nhCIVSFumx5S4L8TIb4bAaGeTF/je8KIQR8jUl9nxE6Qgqo0H7J2VoiWIJC1lzk5HMUyuXAN/XaIN1DQ+t3Kx9B6zqUtBkONLVf4Pj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760330621; c=relaxed/simple;
	bh=ykUlMNh3bh8fYWZl34rlpF4UVu8DUMRwA+gZmQsYkxU=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=d1DIPSib+cNlqOZ/BoOb9byWWRCoHFem4iAKJCLTtwJaBONHuYMw8rCua6cuq5NiO1vlCMqQjfv+1ZaH5yyXd7Fpld1SrQuOYVlo5e5wPNOH7KHZGgOxftx5s2RviD4UaqUT8YX4yeLo3N5CQG6bV7UDcE86kTCLA7RWOQVORlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=lwejfeKH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iIrFfdyh; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AC1957A0059;
	Mon, 13 Oct 2025 00:43:38 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 13 Oct 2025 00:43:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1760330618; x=1760417018; bh=Ri4rRhCdhng2Ujw+yyiO/nAD6ndlZ/RfP5y
	ahHKASy0=; b=lwejfeKHUG0pCQ+e8HxIXsw2i52xQovSMKZFM2tPxace+yoScLw
	elNdk7THNaW2qsQILCcMv7JEF7rgZr1Gafqdfu5fcik0qjuq2skCuBPo8OmzmHAZ
	aUxjPOsnykSOdzPoIi/459wUfLaz2KS2ubMKBar0emxY8+DcYcdIShTeTRfwvw/8
	Ahb7wl+FwQBAG48XTD7DenMX8/LuvrnXymjRRqPX/z21Eho5G1JIAkCC8BRfLCVv
	Ur/xuKF0q2hP796zWsO1TGlmlSLeAS2JraZG8zxPp5GJTcma3v3B5ZF2BCyBgw0o
	BsBfY94BOI+BbEwuTEteJIdeb9TwuXyHOSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760330618; x=
	1760417018; bh=Ri4rRhCdhng2Ujw+yyiO/nAD6ndlZ/RfP5yahHKASy0=; b=i
	IrFfdyhFQCfN08ZCJtANWIeOyBeif0Ju8ZRaPVNsabGmJrJPk0F6mFHZ7MpPQDPV
	wgF0XdtZ3j+7mPZaNDOimBorFeqtl08xSVcx9R8goF+qAFdsP9VXY/lJAxVTh716
	uuNODC0r/D/6lu9/J8edGQE1ncC7wQzMxp3OBIbClrTpHCPs8xmjicQF5zbtJQ28
	jzwjTGbq9mAVhgh9AhEqOXGkuDS7hYEtNeQNiUrlBkQol7xAxdx57wfp8gfOkj1Q
	M/64zlBTdcxp/iOOvmx3QHdr+7IS53/7orRBPza0ZtH5PavAbKKKhFxt15hN8H/Q
	XKT6JgMY3jSOBEvRqNW2g==
X-ME-Sender: <xms:eoPsaLoLQGPpKr9e_OXK08F1FXIKnel9Faj890poNTLhzUzzvN3Kww>
    <xme:eoPsaH4eFOdbHIxRinYv7jg1yfK-eKwLtRDOqocCE3DaUM7dJTykUBeL1jR_nGdIU
    _jkxBEXoC1mhFfbK6sR6tqIbv4PelWXS4pXKtMwnu32smrFdw>
X-ME-Received: <xmr:eoPsaKcLYsLDK2MeYs4F4R3pqq_Jt73nkwKzd9wU1RHueDiXbgw9mq2Y_t_iMLns8G42vGGoK7msY6VIxh_rZ50eZoUeE7VUMEmORgkK0wIy>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduudeijedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtjeertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epudetfefhudevhedvfeeufedvffekveekgfdtfefggfekheejgefhteeihffggfelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehtohhmsehtrghlphgvhidrtghomhdprhgtphhtthhopehokhhorhhn
    ihgvvhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepuggrihdrnhhgohesohhrrggtlh
    gvrdgtohhmpdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhesohhrrggtlhgvrdgtohhm
    pdhrtghpthhtohepjhhlrgihthhonheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptg
    gvlheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:eoPsaE5u2vjeaNhmahaNFy_dfZmMvgB5Tl9MSGMyZMzD8GxNZOPFfg>
    <xmx:eoPsaJvft8_YNY6SJ3miV8Xmx3Mnhs4Ri_R-jkm_SCltL0MZ8Dt9Fw>
    <xmx:eoPsaMjWYIPTZpcDMNghUJ3-DBw5HnY5pNL9L264z2Gou4tveRazlw>
    <xmx:eoPsaMp-bdXGceYj6FVVnsTnddG-COozvcdxWazNt4f6jJ5f3Ik22A>
    <xmx:eoPsaLlNS91SpX6q6u2MqM7-6TyEz0LRYBjy_2PJZpTqA0UbetU1EN8L>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Oct 2025 00:43:35 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Chuck Lever" <cel@kernel.org>
Cc: "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <dai.ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org,
 "Chuck Lever" <chuck.lever@oracle.com>
Subject: Re: [PATCH v4 3/4] NFSD: Fix the "is this a solo SEQUENCE" predicate
In-reply-to: <20251012170746.9381-4-cel@kernel.org>
References: <20251012170746.9381-1-cel@kernel.org>,
 <20251012170746.9381-4-cel@kernel.org>
Date: Mon, 13 Oct 2025 15:43:33 +1100
Message-id: <176033061350.1793333.14824740301723157290@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Mon, 13 Oct 2025, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> The logic in nfsd4_is_solo_sequence() is incorrect: it checks the
> current operation index, not the total count of operations in the
> COMPOUND. If the SEQUENCE operation, which is always operation 1,
> fails in a multi-operation compound, resp->opcnt is always 1. Thus
> when a SEQUENCE operation fails, nfsd4_is_solo_sequence() always
> returns true.
> 
> Note that, because nfsd4_is_solo_sequence() is called only by
> nfsd4_store_cache_entry(), it is assured that the first operation
> in the COMPOUND being checked is a SEQUENCE op. Thus the opnum
> check is redundant.

It is also assured that the SEQUENCE op didn't fail, so the distinction
between resp->opcnt and args->opcnt is moot.

I don't think nfsd4_is_solo_sequence() serves any useful purpose.
The only case were the result has any effect, the effect is to set
NFSD4_SLOT_CACHED, and to set sl_datalen to zero.

I would prefer that the code didn't pretend that solo sequence requests
were cached - they aren't.  They are simply performed again when needed.
But that can be for another day.

I don't think this patch achieves anything useful, but I don't object to
it.

NeilBrowjn



> 
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/xdr4.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
> index ee0570cbdd9e..d4548a16a36e 100644
> --- a/fs/nfsd/xdr4.h
> +++ b/fs/nfsd/xdr4.h
> @@ -926,7 +926,8 @@ struct nfsd4_compoundres {
>  static inline bool nfsd4_is_solo_sequence(struct nfsd4_compoundres *resp)
>  {
>  	struct nfsd4_compoundargs *args = resp->rqstp->rq_argp;
> -	return resp->opcnt == 1 && args->ops[0].opnum == OP_SEQUENCE;
> +
> +	return args->opcnt == 1;
>  }
>  
>  /*
> -- 
> 2.51.0
> 
> 


