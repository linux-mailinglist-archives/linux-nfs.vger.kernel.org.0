Return-Path: <linux-nfs+bounces-18960-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id F5p+G0yllGnTGAIAu9opvQ
	(envelope-from <linux-nfs+bounces-18960-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Feb 2026 18:28:44 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E3B14E993
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Feb 2026 18:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 70470301627F
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Feb 2026 17:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4292126C17;
	Tue, 17 Feb 2026 17:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EOPsKze7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8839936EA9C
	for <linux-nfs@vger.kernel.org>; Tue, 17 Feb 2026 17:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771349321; cv=pass; b=tc1YJCDg73/IscyKVSSj1AVHQq3OqWTHWeSTxHXmp1bKmnWDGsjoyTVn4B7lkmrSa1+iqK79QZ3J7zZy6k7zBPAwE/zTRsABBJ4sxgnua4bpLQQk/hGjWZGoKPPPKeSvh8ovfhkNTxCxmdIcN432nZBNSF2t4rtgD4wmoXGa+Is=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771349321; c=relaxed/simple;
	bh=P2irtnBFLiL4JYCfo1k5W4sPeUJoEEcGJRi89IOhnS4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HYF2wTVh3t0ttr9xqp2VxGHB8vLcPX2JMcMbWF16bElwEEeM3HHsbOQH2SJmEHX2llVt03XbmMHZnKzNBHH3hxa0RuynDucWrwr0qEu/4x22ZOUyNXn7TL6ein3w8uIvrVzdDwRanWaQmZRgjr7WEesc0+tFyIym+gDm2W5V6sY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EOPsKze7; arc=pass smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-5673fd077b4so1978060e0c.0
        for <linux-nfs@vger.kernel.org>; Tue, 17 Feb 2026 09:28:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771349319; cv=none;
        d=google.com; s=arc-20240605;
        b=Nmhm5SrEuGu1BBP/YDeVaqPXeSUlju4B0KQ7U87RRaxRRImdQGSzv3ezj+njMI61Kz
         HvY7gGWx+zdIwxMnjFlftNVqkY31zd0+vDyWlo4+/p8sxIN9K/vWY5DwMWxaM/c5NVli
         2oOii++8WjxbE3lJrsQ87HQVXpQKUho1p5TYAErRVe/ptQj4VWUJdFnu7Tgn4r1f5O8S
         PGAI4eKDzn9kprxkKD03pur7P6dt88J/c8iWOyOx4QE/iLse68chEFI+BZGgg7clQyNX
         E3McXRoWovMUVdVV2bqKcUy3IB43ofy4tkh0HrfdWVHrAcjGJO7UWsSqbxhQIXE6YzuS
         QH3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=y1/0i5LwTTeLSjrN/WmRILs65aDQDF4d5uLmTIRIiIc=;
        fh=ooTA2TE4R1IKxvD4oT47en5JKZh0z0/wxEuK3qRjggs=;
        b=kqME0/fK8YUhrYJeUk0V5E5h5zqokxWc+Cm7A2+aLu8fzbp1BfK/v0bhbYQbfRwFak
         oskwmB+NtclsOc7IFJUibAUZ04i3gphkzs8X8KnGn9Q3y1HuKUHPQ6qy+n/xDuwSZbcq
         gtMVWkNU4/6WggBLB867ZrdpQCTncuC4ZHD/26Q8KOuWliYrpEASS9vvwDAODAhviQVT
         r6eb/Uz+5VczMQgtmhwbN2n0h9sqIN2VuY2HujBMTd+K1JcA4C7QzmpJuCr3zG4a2zat
         kbDtnBn+cMVEWL4USfXyhDW28cSiNiQ3bnHge1Mc6BMJokByQ6Xg9rLfuI5N8R+5XoZx
         HeUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771349319; x=1771954119; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y1/0i5LwTTeLSjrN/WmRILs65aDQDF4d5uLmTIRIiIc=;
        b=EOPsKze7YnYK549Zsf0xwpf6goqGtD5zgbDaeeSZR+M56YAjvduMH9glvboRJgB61z
         90v7IVlpIoqu/PESfhSrwwisPhWSLHB/vg/ZbKZW5WtG2VVCUdnwCwjZtL+iAX514ike
         ireX6tbKsjI8o3/UuEIK/8Lp4OnPgwKupSaaSVU4pGqaQUTWDoQqy03x+acKkD95e4Om
         HXER70dkUQhI6+49sY+bSHQYACAw42BD0jOvcwBC7P1MEDJ0dAjqxNm/BSziOuG6NBlb
         j6Y1RiQDz2+WUlCInNZ+LPJC4lz5XeIEVrJLu8oxRM3geHkdjwF9X+WKekMywPhFICQn
         h2ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771349319; x=1771954119;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y1/0i5LwTTeLSjrN/WmRILs65aDQDF4d5uLmTIRIiIc=;
        b=I0NoKKuJbiHvaWs4arC0F/nI8Y+ZetqMnivohjfN5gDIiXdVUqxWWAMPpatJNQKG/U
         Ols5ibchRmfeLntGkkFKUVu8q+LX5xgJwbbbKD0iUUhQqAJn6RZyyEwiaRh15dbDr5AF
         BVOMWSgFcOc8VrDLiRwcz8ZvWaROd5IX1q/Bt870Qx3LXKUeLQchHtMBE85sSalmEJ3l
         FHNvFhCx5QqdMuFGmwF2bLg0797Vz7oD5cVUpJOGoF+w26sBu4Wd0dtsknbPoo+oeWie
         9YcsyGrufIbpkA9jEwU949ZFncycZptC5l59PjopAymuP87RmcgKbs7r+IhZrAFFHM+i
         NRYg==
X-Forwarded-Encrypted: i=1; AJvYcCXh6Pt9kM6NPS9c0p0W7L0DgDw40+bd+6S3A8FEVkM6IZAA0qFPqk3rULI/Hct5BPzMv1p0u7tBxpc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoNtc3SHLixMZ42tImM3+AgyGUNQc4ZStCHsed7ToAr329uHA9
	EQmdyi01wF/0DiKkkpiv/OoRm/7I5ePFfHGP0TTXHln4yXhP2rhYq1n2iQzK/7CHpoVTgr0ROke
	dKV0LtKujpZArnoumpCSfx5teinCLeWo=
X-Gm-Gg: AZuq6aKDSJRYx2zLHDdrOikLw2OfbuaI24AL9CESeFnvcgWREC5PYzDfz1LvxcX3i8K
	gjOIChpkZkFsvd/7ynTGNWjxkYpqhtMwh/yYUp4lA8xJeY3zT3DdcT9pJgm4R54MRIEhMRdEpMI
	4NhOHWsP9itLgryMxKZsMes7MGQ6tzIs+HEsjvDqgIfKPICqoTRs4jgfjy2TW18BAX8KoZWcFO+
	yauuVRkENbeV6n4x+iGNi5VLSMazmew8FIjyaTIYZ4M5u0+aOOvKPaNiI2xApHlcitxW1PmGMHB
	E/jQea0Ykn9UO6df
X-Received: by 2002:a05:6102:c8f:b0:5f5:4d9c:de4c with SMTP id
 ada2fe7eead31-5fe16c003camr4631312137.3.1771349319506; Tue, 17 Feb 2026
 09:28:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260216174950.455244-1-seanwascoding@gmail.com>
 <20260216174950.455244-3-seanwascoding@gmail.com> <f71cdfa7-25f8-487d-b727-39ae962401a4@lunn.ch>
In-Reply-To: <f71cdfa7-25f8-487d-b727-39ae962401a4@lunn.ch>
From: Sean Chang <seanwascoding@gmail.com>
Date: Wed, 18 Feb 2026 01:28:28 +0800
X-Gm-Features: AaiRm51KC7GN5Nv3xktbA0iIhez-RTH-PxLrpczQXSdcrQEcbb1UDvHXkYyG9ew
Message-ID: <CAAb=EJWNSvTHuUX862vLmA2s1uKO0vy_x9OSZ6VXqY9X-+JNsg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] net: macb: fix format-truncation warning
To: Andrew Lunn <andrew@lunn.ch>
Cc: nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev, 
	trond.myklebust@hammerspace.com, anna@kernel.org, netdev@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18960-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanwascoding@gmail.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: C8E3B14E993
X-Rspamd-Action: no action

On Tue, Feb 17, 2026 at 2:35=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
> > diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/eth=
ernet/cadence/macb_main.c
> > index 43cd013bb70e..26f9ccadd9f6 100644
> > --- a/drivers/net/ethernet/cadence/macb_main.c
> > +++ b/drivers/net/ethernet/cadence/macb_main.c
> > @@ -3159,8 +3159,8 @@ static void gem_get_ethtool_strings(struct net_de=
vice *dev, u32 sset, u8 *p)
> >
> >               for (q =3D 0, queue =3D bp->queues; q < bp->num_queues; +=
+q, ++queue) {
> >                       for (i =3D 0; i < QUEUE_STATS_LEN; i++, p +=3D ET=
H_GSTRING_LEN) {
> > -                             snprintf(stat_string, ETH_GSTRING_LEN, "q=
%d_%s",
> > -                                             q, queue_statistics[i].st=
at_string);
> > +                             snprintf(stat_string, ETH_GSTRING_LEN, "q=
%u_%.19s",
> > +                                      q, queue_statistics[i].stat_stri=
ng);
>
> These strings are special, in that they are fixed length, 32 bytes
> long, and not \0 terminated. There are some helpers at the end of
> linux/ethtool.h for dealing with these strings. You might want to use
> them.
>

Yes, I've switched to ethtool_sprintf() from linux/ethtool.h and
removed the manual
snprintf() and memcpy() calls. After testing, it behaves exactly as expecte=
d,
so I will send out [PATCH V3] shortly.

> I also wounder, why is just one architecture complaining about this?

Regarding the architecture-specific nature of the warning: I have verified =
that
this warning is not triggered on x86_64, even with W=3D1. It appears to
be specific
to the RISC-V toolchain's diagnostic analysis.

Regardless, converting to ethtool_sprintf() is the correct approach
which does not throw
any warning on the both platforms.

Best regards,
Sean

