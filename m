Return-Path: <linux-nfs+bounces-3259-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B759F8C6608
	for <lists+linux-nfs@lfdr.de>; Wed, 15 May 2024 13:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09F50B209A9
	for <lists+linux-nfs@lfdr.de>; Wed, 15 May 2024 11:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5376FE16;
	Wed, 15 May 2024 11:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=in04.sg header.i=@in04.sg header.b="I2duCUSO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fqR56VZI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB6B6F073
	for <linux-nfs@vger.kernel.org>; Wed, 15 May 2024 11:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715774299; cv=none; b=Cfw6jv0qTd+xEcXvIoAL2GALMFy4Z9pBBO2IngEridUZAdc/QDBP1BEib0wj4fc2Qdu4RzNMhXAScTWzYDftKRyyV6obeeUZurs7Xg9dKLvV7g66gWX+mzxvzK+B17Ezl4o3HGUqmcRAUHJfa1A4cn/IDmWeA/+jIS+emUO0GHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715774299; c=relaxed/simple;
	bh=ETUFw5mIXGLFGd/uZLG+yQsUHb80Vkt/aoH/pm+X418=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=sGx/BNcUTr70TakEc0ViddGaKM3tWn+6kR7ncqEvHnN6i4h3xAP/aaVWt3AYyjHLp7X4AtVesl2T8wk0/D6wA1iSpXeQSZvBqIQW+QudD8omvzOjSmmxbkzMhCP0NXORaMT91spuvSHpq/1GZXD/OQY85QJ2bso7uGuJcQ7Joew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=in04.sg; spf=pass smtp.mailfrom=in04.sg; dkim=pass (2048-bit key) header.d=in04.sg header.i=@in04.sg header.b=I2duCUSO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fqR56VZI; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=in04.sg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=in04.sg
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id EAF611140198;
	Wed, 15 May 2024 07:58:16 -0400 (EDT)
Received: from imap47 ([10.202.2.97])
  by compute6.internal (MEProxy); Wed, 15 May 2024 07:58:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=in04.sg; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1715774296;
	 x=1715860696; bh=ETUFw5mIXGLFGd/uZLG+yQsUHb80Vkt/aoH/pm+X418=; b=
	I2duCUSOTPp0tKY5DyumMC+qIjmfhk8qrOz5ecwGukc6hvIgpcvCCrXl6Nfj11uu
	1ilxRizmKPIxzhJuToE+XtqFOdxAUiiO3SQxf+aFwykj+Ugl2AN0xzXW6ETbz7HU
	fQ4N/yPofz1fnpUe600V5jLbD7wrSQkkLlRR4w97/qiPMhz6Vam7fYAXRD3IlFoz
	DAztfzd2zcyoW1SGeNc6YzpLFCtCsZUSYPYCvAeagFaLv8tlaa9thtUL7U3QNRfS
	snFazjILew6RHTe4XHvGNwycdYQ9WNdFrpR0awKcNU4TTKa0YcXuHatErvp0mxrZ
	3JD5JL58bAnVFUdKzbFFhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1715774296; x=
	1715860696; bh=ETUFw5mIXGLFGd/uZLG+yQsUHb80Vkt/aoH/pm+X418=; b=f
	qR56VZIs3vZzkNvBqK8ApC4czJtJDrbvlMYP/0/2d6dnMxtGSiSz6KTSfTrHKsax
	tBnOPxMvcMfYrI4WDqpxUip47hPNWIomHWLS/L8OXzhViTZ561AiQP9UjkG0IU8S
	cxn9dPV2sVYcsFHD0mRa4rW8/RTAadVzrf8Xcd+wgdQ4+V7gO0j3rCDv80BtMMME
	olPRxAPobGvKv5NpnFAGEwvugLjF7PJfMmiwYx2eK/lsaHwp8tQZDlTS7dt/0fKX
	iZwiGtFDeUvfJ/kNrTlHNfpYORLbEVSYGwcISbNgZZkUadSLV/MrVTsheIUap3Lq
	c2s9DAdOMLMMGDHGbxcEw==
X-ME-Sender: <xms:WKNEZnH7ewYF84XO6vAhfNP3DJ8_JPm7ebQ3KyoSvSD6tNo61pGYBw>
    <xme:WKNEZkWx0zgq-AXhNWzb130uhrgoPKqOKO7axFrJb0N9ZB5GbH16Lg1ZfawjcDT-y
    ok9_RXcqTIfmtFx31Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdegkedggedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfv
    vggvucfjrghoucghvghifdcuoegrnhhgvghlshhlsehinhdtgedrshhgqeenucggtffrrg
    htthgvrhhnpeffiedtuddvtddvieekvefhkeehudevtdetvdffgfeivdefudeijeefheei
    geetleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grnhhgvghlshhlsehinhdtgedrshhg
X-ME-Proxy: <xmx:WKNEZpLQYpwfBPSsVRd3uydlljuaXlmZC12pQFmyUhqJORtrECuYGQ>
    <xmx:WKNEZlFm8YT6cgtg_2kdWDVSHkZl7WuvEAxMhzpvUqoKegHG5qHmVQ>
    <xmx:WKNEZtUapUm1FAAI65gI--i0xMKe2yzEBarWxP-jN9MxZiInN4K6mQ>
    <xmx:WKNEZgNnqqR1pbIW6lpy87pPHxPQcV57ifQwHFUKA2WmY3mb8FeOUw>
    <xmx:WKNEZjz7UqCIuSA7QI-CA2rEb0tn4GZyc7Pcz-EEtiOxc5m_fTYOP6VX>
Feedback-ID: i8ba9497a:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 7A6C8A60078; Wed, 15 May 2024 07:58:16 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-455-g0aad06e44-fm-20240509.001-g0aad06e4
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <21fcfc6e-4d34-43bc-8bdb-63a5cd0e0c9c@app.fastmail.com>
In-Reply-To: <77344fe208d76fa98ba24d79f2246e34ae20b543.camel@kernel.org>
References: 
 <CAAih9mhU-UKGvSKBsCqRmkN6zvsD_ThofU94tCOECVJ2G9iW=w@mail.gmail.com>
 <9b3e6161f290246eb8003767b2b34596a10f5d71.camel@kernel.org>
 <CAAih9miBhTWZVt2N_39tzzOfJfjyUKeq30tD2OOQZdQhRSFhSw@mail.gmail.com>
 <cd4e8b16a8c154e6bda38021eef2c0d56badb43c.camel@kernel.org>
 <71b3ff942fdf6f070f6cd59f29e04081d3f94c38.camel@kernel.org>
 <CAAih9mhcOq2XqL0Q0sgkrpfJudpL9knV8yq+Uk1s2mJRRxau8Q@mail.gmail.com>
 <6c16c58a9e6de330eab68aadd4714954df41dd1c.camel@kernel.org>
 <fe258f94cf0d4f4731d4affbb78777706692bd20.camel@hammerspace.com>
 <77344fe208d76fa98ba24d79f2246e34ae20b543.camel@kernel.org>
Date: Wed, 15 May 2024 19:59:22 +0800
From: "Tee Hao Wei" <angelsl@in04.sg>
To: "Jeff Layton" <jlayton@kernel.org>,
 "Trond Myklebust" <trondmy@hammerspace.com>, cperl@janestreet.com
Cc: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
 "willy@infradead.org" <willy@infradead.org>
Subject: Re: Too many ENOSPC errors
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, 13 Jun 2023, at 04:20, Jeff Layton wrote:
> The point here would be to bring NFS more into line with how other
> filesystems behave. As Chris pointed out, other filesystems don't repo=
rt
> an error on a new write() just because there was an earlier, unseen
> writeback error on the same inode.
>
> I think we can achieve this by carving out another flag bit from the
> errseq_t counter.=C2=A0I'm building and testing a patch now, and I'll =
post it
> once I'm convinced it's sane.

Just wondering if anything has happened regarding this issue. I saw
"[RFC PATCH] errseq_t: split the ERRSEQ_SEEN flag into two" on the list
but that didn't seem to get any attention.=20

The current behaviour is really quite surprising because if you have the
following sequence:

1. quota hit or remote disk runs out of space
2. write() returns 0
3. close() [1]
4. space freed
5. write() returns ENOSPC

and then read the file, you'll see the contents from the write in (5)
and *not* the write in (2), even though the write in (5) is the one that
returned an error.

[1]: this returns ENOSPC too, but it seems like we're assuming applicati=
ons
don't check the result of close()

--=20
Hao Wei

