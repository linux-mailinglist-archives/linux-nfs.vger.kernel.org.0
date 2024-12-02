Return-Path: <linux-nfs+bounces-8316-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ACC39E1193
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Dec 2024 04:05:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C41BA282A8B
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Dec 2024 03:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7D418EB0;
	Tue,  3 Dec 2024 03:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nrubsig.org header.i=@nrubsig.org header.b="THdmGlhp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from tiger.tulip.relay.mailchannels.net (tiger.tulip.relay.mailchannels.net [23.83.218.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF113A59
	for <linux-nfs@vger.kernel.org>; Tue,  3 Dec 2024 03:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.248
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733195130; cv=pass; b=eZy7LbpLgCa9g7xjnoGOtG042ntIysHkPn4iyJ2PrEIJXziuw6+sS7pX178/2zBNXkz5Th8m9viEYrCV19BIh1ykTDUVujLV8PfeyTTZ2BlolKVqXI0LKFJCc4Ufqm4VxOx2jv3Lt66FFn36lMhSHW345t/esv75B4vRlDXf5v8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733195130; c=relaxed/simple;
	bh=or/AC+pCexVyNo5BV+53xJsrqpGBgNmvZwyu4TmAxqo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=k4LVaM8851ytSAlpDr6pMpIH8B1KSZ/A3tflCTuMRMOAfFVpHfaJ1w+QS4jnad4/vfq0Jg27v45Zw7mUotKtfjcG8EcRDkEeWez2sMEBnGi8rqF4QWuKgsg6Dyg6WG4TjxTnFCUrCp/te6E+0FhTK8JxZ9CNC2cVZyCCDQYYGAM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nrubsig.org; spf=pass smtp.mailfrom=nrubsig.org; dkim=pass (2048-bit key) header.d=nrubsig.org header.i=@nrubsig.org header.b=THdmGlhp; arc=pass smtp.client-ip=23.83.218.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nrubsig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nrubsig.org
X-Sender-Id: dreamhost|x-authsender|gisburn@nrubsig.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id C76598417E6
	for <linux-nfs@vger.kernel.org>; Mon,  2 Dec 2024 21:25:47 +0000 (UTC)
Received: from pdx1-sub0-mail-a294.dreamhost.com (trex-8.trex.outbound.svc.cluster.local [100.97.1.190])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 5800E844397
	for <linux-nfs@vger.kernel.org>; Mon,  2 Dec 2024 21:25:47 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1733174747; a=rsa-sha256;
	cv=none;
	b=hGiW8QmFm7I7ZQjQKFGaPUdMWEv8daKJKyLfQ1kOG52Qma9z6uvMJxerTLEXuJKFcWgpjq
	G9xYESV5woCTaSJjDuhSlzvn5sWSat8CtyXGs4ZRDuLfGnMLa22QrKeptwnhGUwbpDkEba
	d8j6OaIiXIVmHxaf+9c8hjcThTXPyOm+fsiXvq1K1Ihs7cgAe4+qOVpYXIdkbSmdvBQq+S
	3Odetygm3rx5agysMrIL2kfP2sAdrxEEmTra17vXFKKzKr68LNKo2Z5wJTx5ZEgWRsAGfM
	8pj61mXwz8gXF1QuP0CDtsINXlSGAM/QzklxCE7HwOIaMRxh7uhLtV1x4Q15/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1733174747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=JbYRRdgaCbMYUt+5bIigWWQ7PGq48OyVkRKKrmbnerI=;
	b=65UbWTw8jtF8eQNRZgwu1KMmWiy9cRiPkfqK507swM66kP0GwE0Pb6ITsB9VMXs9TDSurl
	WP64STp+mlmVvBBExxFBrjaOLmFlUZENU3jMiv/Y17urQM4D9q1HxrYNvlXDwKKTWcUBrC
	w1gVzuKG4eJlucZeyPWOvKjkwQVNqz4XVGKCNGHhPIG9MnCqkPD0u3gcFLxlgZNbLLPwT0
	KL++80638DWrYKe4CELuxy1ih10H865HoUrlH5j4iymIec8FLMxGi+8xtOxs8CiuxK2BIo
	q94nsKT8uv3ioHINeB2qtSrGf62f1QTmysxMW9bEiuF4VIPDpPzRJejAqchQyw==
ARC-Authentication-Results: i=1;
	rspamd-5d9d86ff64-v2xgh;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=roland.mainz@nrubsig.org
X-Sender-Id: dreamhost|x-authsender|gisburn@nrubsig.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|gisburn@nrubsig.org
X-MailChannels-Auth-Id: dreamhost
X-Power-Vacuous: 4f63235414061e93_1733174747561_3163139885
X-MC-Loop-Signature: 1733174747561:740651694
X-MC-Ingress-Time: 1733174747561
Received: from pdx1-sub0-mail-a294.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.97.1.190 (trex/7.0.2);
	Mon, 02 Dec 2024 21:25:47 +0000
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: gisburn@nrubsig.org)
	by pdx1-sub0-mail-a294.dreamhost.com (Postfix) with ESMTPSA id 4Y2Gzb1g2fz31
	for <linux-nfs@vger.kernel.org>; Mon,  2 Dec 2024 13:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nrubsig.org;
	s=dreamhost; t=1733174747;
	bh=JbYRRdgaCbMYUt+5bIigWWQ7PGq48OyVkRKKrmbnerI=;
	h=From:Date:Subject:To:Content-Type:Content-Transfer-Encoding;
	b=THdmGlhpyH/325swjVh6M/GrujVsTTSSIRanLx7Fi8AYnIHfUaskYjD04/wG9nzQK
	 RJthKLdsDdJU0nNBWRlAoUrx6WV0z+bXy4VJCp8F9gEyBnRRSZzxL+CIXsA4qiwGqy
	 mB1fG5XwhWw3xRaHssSftspQCckpDaHoqjrUCBMd5QrYdrZjGG/QNDMIprTXcRlzL/
	 8uUv/uhEsHoU3KQCwiT3bfGiNkNCi1xmelA/+EOqN1oRaGOWlDF2kMDSC4ajffuxjF
	 8aXBxdHKxYvq8m+a1v2nkdCSfLoyWoiMhITDAegIumPyRaQpZEWGBgADHotjoG+1ls
	 HjRrefoKjHcrQ==
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-434ab938e37so30913435e9.0
        for <linux-nfs@vger.kernel.org>; Mon, 02 Dec 2024 13:25:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWpTjOzqjWa6jGW7IcpkPhRtPtIBIvRgmvuvFoEwGhtS2eTJiSpssXI/xKQp9vmQMOfJXqcZJc7VX4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFmop9l36SzE0to6GzSCYZjWhodE27M4ek3gXqiI8Pms1bo5UA
	xSR+liMOMG0OQtlrvIobC+kfGkPs1fkn04D9FQmWltF+rqYjhIropGR1qHI/2rAIY736yiP/go3
	7ZdaxoePYBaQtewUxRzeJp3dLEPA=
X-Google-Smtp-Source: AGHT+IElyh6j2fqNhG0MVO2XcJSZcedguxcHI0RX4CUyb/4XsnGpLgp0cEY0YFavQmXwn4mOdp/foV62ir1wUiyNcRI=
X-Received: by 2002:a05:6000:2ac:b0:385:dd10:215d with SMTP id
 ffacd0b85a97d-385dd1022fbmr15305680f8f.44.1733174746220; Mon, 02 Dec 2024
 13:25:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <328fdce3-a66b-4254-a178-389caf75a685@redhat.com> <20241202203046.1436990-1-smayhew@redhat.com>
In-Reply-To: <20241202203046.1436990-1-smayhew@redhat.com>
From: Roland Mainz <roland.mainz@nrubsig.org>
Date: Mon, 2 Dec 2024 22:25:20 +0100
X-Gmail-Original-Message-ID: <CAKAoaQksM=bhcekmY24Lv2o_4nfNkkLi=T+aq+dhFeH_1m-xTw@mail.gmail.com>
Message-ID: <CAKAoaQksM=bhcekmY24Lv2o_4nfNkkLi=T+aq+dhFeH_1m-xTw@mail.gmail.com>
Subject: Re: [nfs-utils PATCH] exports: Fix referrals when --enable-junction=no
To: Scott Mayhew <smayhew@redhat.com>, linux-nfs@vger.kernel.org, steved@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 2, 2024 at 9:30=E2=80=AFPM Scott Mayhew <smayhew@redhat.com> wr=
ote:
> Commit 15dc0bea ("exportd: Moved cache upcalls routines into
> libexport.a") caused write_fsloc() to be elided when junction support is
> disabled.  Get rid of the bogus #ifdef HAVE_JUNCTION_SUPPORT blocks so
> that referrals work again (the only #ifdef HAVE_JUNCTION_SUPPORT should
> be around actual junction code).
>
> Fixes: 15dc0bea ("exportd: Moved cache upcalls routines into libexport.a"=
)
> Signed-off-by: Scott Mayhew <smayhew@redhat.com>
[snip]

Reviewed-by: Roland Mainz <roland.mainz@nrubsig.org>

----

Bye,
Roland
--=20
  __ .  . __
 (o.\ \/ /.o) roland.mainz@nrubsig.org
  \__\/\/__/  MPEG specialist, C&&JAVA&&Sun&&Unix programmer
  /O /=3D=3D\ O\  TEL +49 641 3992797
 (;O/ \/ \O;)

