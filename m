Return-Path: <linux-nfs+bounces-15150-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C466BCFDF3
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Oct 2025 01:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 408D9347F04
	for <lists+linux-nfs@lfdr.de>; Sat, 11 Oct 2025 23:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA031D5ABA;
	Sat, 11 Oct 2025 23:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="cZPv5ltc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xqj4BxKJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD8D41A8F;
	Sat, 11 Oct 2025 23:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760226926; cv=none; b=egRerkGvvucnHtB0PAmf1siiGXt2O7KItJsr6fMQW45A2YeWCGlh1A0VdCGRADMhGliM3o1r/AWr2FahMekuAyUKONURDdgHPGwvdPVmCDYpnG3Fiig8kLBV5uGnYyntsPtXFGXe0Bky/7CPthDJQHj+XorQ+DaMvGYUyTLvwtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760226926; c=relaxed/simple;
	bh=V/2Xx326HMa2PTQwJA8IjPpo3xaH9n2wt03hVqQJeAs=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=ho0zG6k+FwTGfgbdWFYLCHuHPaRGNJ1csU87QCmbmr3TH5Pu8GNFVXW9pctvIV1c1Qy/mIlAQvb2ZUPYUKbmkMGNPd78jAa9yvqo/dOktu6tJRqFyOYeOBCjaPUirnEhmMi1u2kmSWE5kHiyaVWGbrpN8BCfOTuBwaKVLfaxy50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=cZPv5ltc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xqj4BxKJ; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id EDD251D00169;
	Sat, 11 Oct 2025 19:55:22 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Sat, 11 Oct 2025 19:55:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1760226922; x=1760313322; bh=V/2Xx326HMa2PTQwJA8IjPpo3xaH9n2wt03
	hVqQJeAs=; b=cZPv5ltcZfaM6YrbWHbq3BT6E1GZEZ2JdJo6ZFTrE94sDs1NiIW
	ydTw+21UagyhLxcSzjKt9XavLzvIrSX2hmWc2YPDcZyaAcoYr6BV4xgGhS2pQhu+
	3twzubWyYGAPnxzHzGq/uJ1Jg/uzLfw2aqPyyNb5k2RzQ20fa+otcXNrwszQL3et
	QzBux8Ck7IM3MivzpajFJdvT0ee0OSw/fV+mJDMQ6eNP5NhRCIJCwv/1Sgv5Wo80
	roLUESabL4UqA7bgUSiEy19BRoYGjPsdR9G5+pErUfll76oapyUK6wRe8kSQniB9
	mDcMPh7CJOOOz+U13XkLpwvlpN7mE6458ww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760226922; x=
	1760313322; bh=V/2Xx326HMa2PTQwJA8IjPpo3xaH9n2wt03hVqQJeAs=; b=x
	qj4BxKJlpY7CDrB4759BmpfCqS3bPSEkZlB8G/qBLw6GVZm/6XHXLeZTgqYIsMwo
	zMh92/6RSESkz2EL+yUi1CuOXu6YJzzuvd7RJQInhi6utEvKJWixoAZQQsWUC17K
	2FnI8Q5OJQr2c9eEyqhaKdqb7cJoE9Dm+CqT7t3W26u5sKqk2vApAgEfEhAEEzdB
	H2elNqyaayJirgjAJzL/2SzPcPvjFHvldy+hOUd2eMqy+6BIqmowxCP4hNz4GaVw
	B6h/5R06HCgE7hRslW4u6jVlryRewNUHIsLvXe8CJo4torgKOqXYXMk7xPR2m31M
	82ndJY3pj+MCPEVwnXTnw==
X-ME-Sender: <xms:au7qaL0cN7m_4-L-hBaFaJ2ZKFrlaBfOHbGHbgYpASCNgBAk6bubtg>
    <xme:au7qaPC_EdJGbJ34OgjX5YY2P5Z8X8il0Bbj6R41WOHfChSpfLfK8ZH9kmNoBrs1m
    pG6dCFKRUT3ZhrwaubgUBahUC49N6e_2uLmx-g1YzgpcpSpBXg>
X-ME-Received: <xmr:au7qaAKJwPY3BZkgeKoGBEhzMoi6QYtUamAKr3TZU-rcJUdoVetSb3rSGb4YDDi4wejSrBfV-1hAYCX8mrhti5-0qWBfUGLBXSBQo--KAqbw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduudefvdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpegtgfgghffvvefujghffffkrhesthhqre
    dttddtjeenucfhrhhomheppfgvihhluehrohifnhcuoehnvghilhgssehofihnmhgrihhl
    rdhnvghtqeenucggtffrrghtthgvrhhnpeeljedtfeegueekieetudevheduveefffevud
    etgfetudfhgedvgfdtieeguedujeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehnvghilhgssehofihnmhgrihhlrdhnvghtpdhnsggprhgtph
    htthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigqdhnfhhs
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvg
    hlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhomhesthgrlhhpvgih
    rdgtohhmpdhrtghpthhtohepohhkohhrnhhivghvsehrvgguhhgrthdrtghomhdprhgtph
    htthhopegthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdprhgtphhtthhopegu
    rghirdhnghhosehorhgrtghlvgdrtghomhdprhgtphhtthhopehjlhgrhihtohhnsehkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehshiiikhgrlhhlvghrsehgohhoghhlvghgrhho
    uhhpshdrtghomhdprhgtphhtthhopehkmhdrkhhimhduhedtfeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:au7qaAnYiyZKrzCXB1El8NknSgV-ri2nbygfPMCTGDw0IRMz0Y_OJg>
    <xmx:au7qaBYO9swBN8AZJV1vinOBgnjrgYUzqNxki9fcy87_8uTxolDPtQ>
    <xmx:au7qaE-qf91iSkimOtmzqwnXypR8Rf8f7IZvvNNZn355ONEGGJoCaQ>
    <xmx:au7qaIa22PhPA2800GPClvI0NzUCMIbkgrmgLP2Hc8K4uIb7mwS2jQ>
    <xmx:au7qaBn_NhNop60wc5tdI24ifB-KUpfRplca47N4BNtqS_3M1nbZMHoT>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 11 Oct 2025 19:55:19 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: =?utf-8?b?6rmA6rCV66+8?= <km.kim1503@gmail.com>
Cc: chuck.lever@oracle.com, jlayton@kernel.org, okorniev@redhat.com,
 Dai.Ngo@oracle.com, tom@talpey.com, linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, syzkaller@googlegroups.com
Subject: Re: [BUG] After unloading the nfsd module, a use-after-free occurred
 due to Objects remaining on __kmem_cache_shutdown().
In-reply-to:
 <CAGfirffSOjQtJ=FhZ1bhmqDMtdm2UAgvo9TdJNY5hU4KJXQ+pw@mail.gmail.com>
References:
 <CAGfirffSOjQtJ=FhZ1bhmqDMtdm2UAgvo9TdJNY5hU4KJXQ+pw@mail.gmail.com>
Date: Sun, 12 Oct 2025 10:55:15 +1100
Message-id: <176022691571.1793333.714819698603408503@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Sun, 12 Oct 2025, =EA=B9=80=EA=B0=95=EB=AF=BC wrote:
> Dear Linux kernel developers and maintainers,
>=20
> Hello,
> This bug was discovered through syzkaller.

I don't think this is a bug.
Passing O_TRUNC to delete_module(), or passing -f to rmmod is documented
a "dangerous" and "extremely dangerous" respectively.

If you do something that is dangerous, you should expect bad things to
happen.

Presumably the nfsd exit_module function is failing because something is
still in use - as it is allowed to do - and the module is being removed
anyway.

i.e. the "bug" report is invalid.

NeilBrown

>=20
> Kernel driver involved: nfsd
>=20
> Version detected by syzkaller:
> - Commit version: cd5a0afbdf8033dc83786315d63f8b325bdba2fd
>=20
> Details
> If the test driver is forcibly unloaded, objects remain in memory,
> which can later lead to issues such as use-after-free.
> Additionally, This issue can be easily reproduced with the following comman=
d.
> $ sudo rmmod -f nfsd
> Note: Since the nfsd service is running internally with open ports and
> mounted shares, it may affect this issue. Therefore, the boot log is
> attached as a file.
>=20
> Please let me know if any further information is required.
>=20
> Best Regards,
> GangMin Kim.
>=20


