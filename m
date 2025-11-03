Return-Path: <linux-nfs+bounces-15976-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4D8C2E44C
	for <lists+linux-nfs@lfdr.de>; Mon, 03 Nov 2025 23:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1A6A3AD59C
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Nov 2025 22:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290F41A9F82;
	Mon,  3 Nov 2025 22:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="RC/HpZZe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mJtCmgTa"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556F01DED63
	for <linux-nfs@vger.kernel.org>; Mon,  3 Nov 2025 22:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762209033; cv=none; b=VlJQ+rGoGo0Sd/k0Fcnsy2EWvpaLAv7y8tFtimXCoXQ6IdU3d5H7bH+g6AJaU9TkaYrwA1OkIOmkoBchO2EfYAvTz9wQVaW/SYXUvjXB+Tlm2bg/7wI3xVCI2Cs02OQBN9E53fUMP6zDzrhwIEwnrwkKaPU3P9WN251JhrpF69A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762209033; c=relaxed/simple;
	bh=wbfqQm7eIyfISpmUIuhBZHdMP3Fo4u6NhtPkIi88onc=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=BwRx97XnXi3A2hRc8+43kfRzK5p5NfPxH5qiHqGYrH9SIFbkacjhQqCmqMDmSpZ8Az0Epb21HO5FwHXE4qYSRMfLSdrvIrYgRYGErvn7pn3jba2PeNNEI7+VO8PJw2tdrVv9JKXMKFNhHLB7/N2s/ksMcTXs4BB0+rkwjiTjk2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=RC/HpZZe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mJtCmgTa; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5A519140028A;
	Mon,  3 Nov 2025 17:30:30 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Mon, 03 Nov 2025 17:30:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1762209030; x=1762295430; bh=KCi3wDAb5pz9WNo7CDfwVfGCvUNLy0eTn++
	AmeYLUZY=; b=RC/HpZZeDOyHBpRdfXCISPySiqJKYvgtvu2Y5+HCkoCA1gCKY+S
	/03HkOaxw2GwE9S8CuuW8FZhXQcnbdFyEq71Q6spa7/B76GUWG14InoqZrgzxmeL
	QSuaIHe8oPRGam6lprVVHl4f+Yn7UmTPVNLKrlh6j2Gp75VXkzbMYC41ze0YxhRv
	QJRsPesLcm1xs1360WUoRKtezObY4lY1hVSSTebPTFKNYCY/cD9XSG4YGEBafSqc
	Nr+bZrq40eko0d2MAsaq65UoVZFjwkDjRYB0AzVPoz6oUErCkTx97D9eGU+7CNNz
	irlAE6lrw57UzTVKxwoNFZNvQETNIB/kenQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762209030; x=
	1762295430; bh=KCi3wDAb5pz9WNo7CDfwVfGCvUNLy0eTn++AmeYLUZY=; b=m
	JtCmgTaSfbTUmQPdDFIS4eIqGleukS6tNxrgbKUj/1Ajgy035TzKXvIOZACMdsBF
	JGVaO5euoR1AGM1Oo+EJP4UyvPM6a0lasqKQafb3Vlqe/hxeyWgTbD6C9JDnywY3
	7tZn5WEufMsEfvmFom7HjWESsWVTYxShypasfsIZSeYtyiIc39n//GPd42xySrJg
	YnZeh9EHWBSbPOyGV8cOyPm1zKbtVOrbdJ7TVxsglu1XDEyKICc/dJ93lP02blWb
	N9QhyMrxPmpBCvydKc/McOZleR2W2ItcwDD3Z3YJFnD3NNr868fg35RgD7+/kwgM
	4XeOIyG7cIu14P25SqEJA==
X-ME-Sender: <xms:BS0JaWNOdjuprKwifLtKK5v7JS6xC8GWZH5r2bAFKEVv3QMHoi-vNg>
    <xme:BS0JaUBNeUcxUtC7TS1WiAwffkkM1L2aSyCcNheguBhb0AyNLEZ9vLqNWqmij-816
    ErWjllrbzncHdUFbs3tfhf8CBHFCvs7oAmTLQanQozM1x0F>
X-ME-Received: <xmr:BS0JaTcimrQ87-osMo8vqu6jkFKVxlNzazc1YQYIcrdOqVZ2GQRTGXGj_Bjsm9riHYKAK20bvFcN-edNZp0WRKO83XBvbtIvHOVwl79xC_Ja>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeelfeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epleejtdefgeeukeeiteduveehudevfeffvedutefgteduhfegvdfgtdeigeeuudejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehtohhmsehtrghlphgvhidrtghomhdprhgtphhtthhopehokhhorhhn
    ihgvvhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepuggrihdrnhhgohesohhrrggtlh
    gvrdgtohhmpdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhesohhrrggtlhgvrdgtohhm
    pdhrtghpthhtohephhgthheslhhsthdruggvpdhrtghpthhtohepjhhlrgihthhonheskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtoheptggvlheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:BS0JaTMZ-xEgSLakU0UYwYLFxh1DmRWjV0kWiSWkmkKpGkVtSeKNBg>
    <xmx:BS0JaTIb0N1m_tMHbPR0Ozw3AMOO8j4esrXTGgVhwZp-g23bOAQWGA>
    <xmx:BS0JaTJ-2rhet0sU6VKFHrv85TzC-GoR-HS-lHU7cyLk8QAWPNzKWw>
    <xmx:BS0Jad73QzcANZJp7zW_z3XJKuXoi9uGTr26zdlk8bCMd8Ja7rBcfA>
    <xmx:Bi0Jab8Z5m9j4j9bumtN5o56e2SfSUp12k2APENdgLsMrFihs4yIbkT2>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Nov 2025 17:30:27 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
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
 "Chuck Lever" <chuck.lever@oracle.com>, "Christoph Hellwig" <hch@lst.de>
Subject: Re: [PATCH v9 05/12] NFSD: Remove alignment size checking
In-reply-to: <20251103165351.10261-6-cel@kernel.org>
References: <20251103165351.10261-1-cel@kernel.org>,
 <20251103165351.10261-6-cel@kernel.org>
Date: Tue, 04 Nov 2025 09:30:25 +1100
Message-id: <176220902556.1793333.10293656800242618512@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Tue, 04 Nov 2025, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>=20
> Noted that the NFS client's LOCALIO code still retains this check.

It might be good to capture here *why* the check is removed.
Is it because alignments never exceed PAGE_SIZE, or because the code is
quite capable of handling larger alignments
(I haven't been following the conversation closely..)

NeilBrown


>=20
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/vfs.c | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 30094d8f489e..80bc105eb0b6 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1269,8 +1269,6 @@ nfsd_is_write_dio_possible(loff_t offset, unsigned lo=
ng len,
> =20
>  	if (unlikely(!nf->nf_dio_mem_align || !dio_blocksize))
>  		return false;
> -	if (unlikely(dio_blocksize > PAGE_SIZE))
> -		return false;
>  	if (unlikely(len < dio_blocksize))
>  		return false;
> =20
> --=20
> 2.51.0
>=20
>=20


