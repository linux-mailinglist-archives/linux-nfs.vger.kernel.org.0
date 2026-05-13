Return-Path: <linux-nfs+bounces-21582-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SP2BMxLWA2ol/AEAu9opvQ
	(envelope-from <linux-nfs+bounces-21582-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 13 May 2026 03:38:26 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7778B52BFF0
	for <lists+linux-nfs@lfdr.de>; Wed, 13 May 2026 03:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 24DE0304D8C8
	for <lists+linux-nfs@lfdr.de>; Wed, 13 May 2026 01:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5058336A03A;
	Wed, 13 May 2026 01:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G8Vb2eAm"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B60A37BE6F
	for <linux-nfs@vger.kernel.org>; Wed, 13 May 2026 01:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778636191; cv=none; b=UFPYeFwZfUCyUlTpe1tY9oGZVq0j11d/NsN4Y3FaJlF2RTgw4HunD2MYjVch2UDmqXHT4ZfhCiQCrKwPwobCA3KB0hTpgvkdkXY3zc0FW4/1UlW51bSepu+yJKWveD6qY8x6/VNs4uJr0H1CTu3f/S5uk849D6dYYxBUH/fThW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778636191; c=relaxed/simple;
	bh=e9Cq+VE3o72uVsj8UtWcea+tYMjBm4KhVtl7pZzyld8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=QTGrYxXXVKWL9N6IWEw0PNcLAumirsixmUqzDQ7yicu9kdPIDo6J65edLYDCkWxXnoqgwwladrKV6viLpJCZ8E08yAfxz1zEG5q7G+HvvMf2x92xPefKP+3zFrtjDiVoEVwtnnuvSoFWsB/cmZmEU0Dl0XhVXvmgdFiPw5uek7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G8Vb2eAm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0207FC4AF0B;
	Wed, 13 May 2026 01:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778636191;
	bh=e9Cq+VE3o72uVsj8UtWcea+tYMjBm4KhVtl7pZzyld8=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=G8Vb2eAmqS4w/iu9GiQesU0WTJ/y8oEOd3sWZrLMNceuS4AlrJlMyl72hlFiIX0FC
	 TQWiAF+ubGgsDrHAIAVt21wQqjQyiSVXvFXJ222VZmC5RxlAe0Qem9MjYQs33WM4DW
	 KnVptGIzQqg/if4Osv2S8RktlN9UfNOmBs3ENMC/IJi/oXNac6lYrzdNRjNuI5nbwd
	 waJewOrMHKMtQ8gai4CvYUzrNHCYCK6GGyd0aIjC1DTmG0zYa3hE+Rns8jeJCv+gFr
	 U5oJ7cVuoCAvMbdqm3F3VJVWNqbJz/uwTcWuvAy79wfdCqJFjzo993EWGXd0zjpNK0
	 7EY/Dau83wFsg==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 30A1FF4006A;
	Tue, 12 May 2026 21:36:30 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Tue, 12 May 2026 21:36:30 -0400
X-ME-Sender: <xms:ntUDat5qwa_DELBInmPH8N0TnfJyvl1R3nTz22fLKFII13fD0-T9rA>
    <xme:ntUDalvIlH_5r-XRDQMF83yRClOXzQ1q4ZrhS8TBw5Nf8Ns77J7ueth0znIIInxBU
    G4K1RCiDxXP9YBBLhJ7cBcU8LOo-zDqZLvOk2p74_qs-aNp9Risovo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvdeffeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpeeghefghfegkeeihffftedvleetteetgfdtgfetffduhfeugfdtkeetueduffekkeen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhkohdrihhsnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhuhgtkhhlvghvvghrodhmvghs
    mhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieefgeelleelheelqdefvdelkeegge
    dvfedqtggvlheppehkvghrnhgvlhdrohhrghesfhgrshhtmhgrihhlrdgtohhmpdhnsggp
    rhgtphhtthhopedufedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhgvihhlse
    gsrhhofihnrdhnrghmvgdprhgtphhtthhopegthhgvnhhgiihhihhhrghoudeshhhurgif
    vghirdgtohhmpdhrtghpthhtoheplhhilhhinhhgfhgvnhhgfeeshhhurgifvghirdgtoh
    hmpdhrtghpthhtohephigrnhhgvghrkhhunheshhhurgifvghirdgtohhmpdhrtghpthht
    ohephihirdiihhgrnhhgsehhuhgrfigvihdrtghomhdprhgtphhtthhopeihrghnghgvrh
    hkuhhnsehhuhgrfigvihgtlhhouhgurdgtohhmpdhrtghpthhtohepjhhlrgihthhonhes
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhhishgrnhhjuhhmsehlihhnuhigrdhisg
    hmrdgtohhmpdhrtghpthhtohepuggrihdrnhhgohesohhrrggtlhgvrdgtohhm
X-ME-Proxy: <xmx:ntUDauLDPKI9ACoiOYh-rYWlRPPvbx41Mz-Jvc6t0AGd96cNft0pcw>
    <xmx:ntUDajpWIragAKuTKS60JpYjl7w1cHwIVJKb_ecgDQfxSZr9MxhT9A>
    <xmx:ntUDahXGVM2jiBlKJkOeA8iLXBn5oQk2NvHxGjg4_jkS5uCArEB9Uw>
    <xmx:ntUDao2C4i84FSJyXC8lzir3-Al21r0X4jeTmIAAR_vVtnpH8PlyHw>
    <xmx:ntUDaoSLOLVjlvWeLW-2UmYxlhnZ0uY6d7d47sgOjjPerRLvGLcyFg6l>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 07F0F780070; Tue, 12 May 2026 21:36:30 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 12 May 2026 21:36:08 -0400
From: "Chuck Lever" <cel@kernel.org>
To: yangerkun <yangerkun@huawei.com>, "Chuck Lever" <chuck.lever@oracle.com>,
 "Misbah Anjum N" <misanjum@linux.ibm.com>,
 "Jeff Layton" <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, yi.zhang@huawei.com,
 "Zhihao Cheng" <chengzhihao1@huawei.com>,
 "Li Lingfeng" <lilingfeng3@huawei.com>, yangerkun@huaweicloud.com
Message-Id: <55ec615a-3b80-4608-ac52-1c0215b789a7@app.fastmail.com>
In-Reply-To: <cd07fc25-8c9d-42af-9bd8-36d1565a80ca@huawei.com>
References: <20260512023322.2828939-1-yangerkun@huawei.com>
 <0ce8ae76-da17-4b25-b1f8-6fa955654a57@app.fastmail.com>
 <cd07fc25-8c9d-42af-9bd8-36d1565a80ca@huawei.com>
Subject: Re: [PATCH] Revert "NFSD: Defer sub-object cleanup in export put callbacks"
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 7778B52BFF0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21582-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,app.fastmail.com:mid];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action



On Tue, May 12, 2026, at 9:27 PM, yangerkun wrote:
> =E5=9C=A8 2026/5/12 21:48, Chuck Lever =E5=86=99=E9=81=93:
>>=20
>> On Mon, May 11, 2026, at 10:33 PM, Yang Erkun wrote:

>>> diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
>>> index 665153f1720e..0baa58d1dbfc 100644
>>> --- a/fs/nfsd/export.c
>>> +++ b/fs/nfsd/export.c
>>> @@ -36,30 +36,19 @@
>>>    * second map contains a reference to the entry in the first map.
>>>    */
>>>
>>> -static struct workqueue_struct *nfsd_export_wq;
>>> -
>>=20
>> Hi Erkun -
>>=20
>> This patch doesn't apply to the nfsd-testing branch. What's more,
>> the patch series already in flight removes nfsd_export_wq:
>
> Hi Chuck,
>
> Apologies, I initially submitted a patch based on the mainline, but I
> will update it to be based on nfsd-testing later.
>
>> https://lore.kernel.org/linux-nfs/98268bb4-2e97-4728-96a6-37b2a4a3ae5=
d@app.fastmail.com/T/#t
>>=20
>> That patch series replaces the nfsd_export_wq with a WQ that
>> is managed in sunrpc.ko. Is that incorrect?
>
> I'm not sure if I understood you correctly. Do you mean that since this
> patchset has already removed nfsd_export_wq, I need to adapt more based
> on this patchset? Or are you saying that replacing nfsd_export_wq with=
 a
> workqueue in sunrpc.ko might not be sufficient because they are two
> completely different modules? If you prefer, I can adapt the patch bas=
ed
> on this patchset.

It appears to me our fixes conflict with each other. I=E2=80=99m trying =
to figure
out which to apply, or if both need to be applied, which order? We do ne=
ed
to consider ease of backporting, and your single patch would be easier to
fit onto LTS kernels.

But my series continues to use a WQ to defer resource release for all the
cache-related files in /proc/fs/nfsd. Is that the wrong solution?


--=20
Chuck Lever

