Return-Path: <linux-nfs+bounces-21596-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MFMpCGc4BGoqFgIAu9opvQ
	(envelope-from <linux-nfs+bounces-21596-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 13 May 2026 10:37:59 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 96AE452FC0D
	for <lists+linux-nfs@lfdr.de>; Wed, 13 May 2026 10:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 11A09301BA50
	for <lists+linux-nfs@lfdr.de>; Wed, 13 May 2026 08:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3303D7A03;
	Wed, 13 May 2026 08:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GcBT9uWp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289583D891A
	for <linux-nfs@vger.kernel.org>; Wed, 13 May 2026 08:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778661465; cv=pass; b=cPSt2Wl1GywWmzE+y2PYUJR70QMZxFzGljZsfqrxKnE8Yg14u+GIH/LLeiUmDjGSla1DrFSHc6GGs6ZOQFAQ/FJ7yK9/uS6at2IBiaw6ThnUzSzrsuq9kmO3JHuKV3q0lXnoIdPJYw27uSGcJ79P2KJMlA0hhdV1iJ8b+Pm/7Qs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778661465; c=relaxed/simple;
	bh=UjOpSeCkN+TZbnpsMx6wOFOlOEFzAmg7WFpm5qCKOjI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=pCbQyT/Hv8p80d+K1bi93IHkW01P2puVHd7C8FQI+uIzFFoyXT4TpmslxSmuHBGesBTi7050G2kZa4jG92SEud9Qp+8dI24/PXYLg6Duu1aXQywcJyAiPIDN4Ce4o604e7zmXoZAogGZTiD+QllJbmFAdf/6t0NA8svGGQqSn48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GcBT9uWp; arc=pass smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-479d85152c9so2660792b6e.2
        for <linux-nfs@vger.kernel.org>; Wed, 13 May 2026 01:37:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778661463; cv=none;
        d=google.com; s=arc-20240605;
        b=NRsjRgUMjrn3URjPLPt5xRSWuQSv9lZFGeZfydBiOhvpNUdTLruLEzVtfzFjnQbCLZ
         +TtgsyyWepVcMic9f8oBhPLnV5tqlqH4bbGHnJExo3dNE9K5uVo5MG6pc5ppIxVCoUJ0
         h6Luf0dk1jhANIhMIQ2mTx7NAH5kROmSD/eHb5Of3+0ZFxsTqsFhWfXcMcO0n+8k4Idv
         PkI85JgUoEttYlrXfE0tMp0QI51l4eaahMYS5yzWX3kGsdbVUq7rBx8RQYZY5NbtP7e/
         GN3SXKHS6CIJSD3wY2RiuZk4+L/O3LllLvYRtQiXdfV6lVZCwZMkcvT6TGfHLaIZiroM
         D+KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OKhrwZHK9DF846CvL3zfi5UzL+2mj9XJezQNBtW5rx8=;
        fh=PxOnSsCCZ3eM4n/KpzZOGZ4+fSbn6z8WUacJcE88K/8=;
        b=Uec59CHMxLczhm4xSxGBTPi9fAxmFsEVW6Ml9rSHZ5wgLYFnSOUkYswzV8Mfyy0D7H
         ES7eIbILAATpwqsqXKrucYOEyJ32oVfHuwBnVktogT6tDogAsHeyVgpLfWgekT+4KyYK
         dV4tOLeGFTBp8DO55EBfrVIKwY3JO+4tMpo1+w4A+zp6wmmxkZ54CCjGywMPu1VnyyYj
         q1FKAaN/OQIdLlMqd5QvTrx/+EESHqrX81lM7+PxG92m24B0ZBXs2RgAd9qGeJ2U+YMf
         3l1le4HlBuWU3KBI9XVGdrQyrPuMbYbKeBujCzsXauHCy2fOvj7wT7pTerRfqKO2742p
         3t+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778661463; x=1779266263; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OKhrwZHK9DF846CvL3zfi5UzL+2mj9XJezQNBtW5rx8=;
        b=GcBT9uWpbQFxJ/XtV253MAglKFhvWeKcVCuhx7Y0psCLJwsGUq254OIJLopdQdMXNU
         Tnbup+aVbfxBCucP/SXa1HCQbsLP1RNz4A6CKWVekXcodJ20H6lhJdf7ramrIhiNHyy4
         3fTGeRP1/dnAB23T4GH7AsvIFZMotZLgFBQF9pITkm7CDHQAEPgPiNvClAMMj9lzTUhr
         kXgU3RtDjJSnjkk8ukA9crq8J7ew0+De0S0/TL5R6Twxb1YF3gppSgZnzvVk2CY97XpJ
         knFM1IHJSSyjkwqZTkvaUTbJxYMktdzmNC3mjZB+kEbqFdY647esodwRNXHXOzDzlVtM
         XbuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778661463; x=1779266263;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OKhrwZHK9DF846CvL3zfi5UzL+2mj9XJezQNBtW5rx8=;
        b=JI9R5kFMkC8lxakF47SzVclqKaRdt7mYyiP2Y69go6OhN/P6ngkZ/F3sDOjX2KTMEV
         zTrLVRQKJV0+Gn6DTK3ccFRPT5Svjxm6sJfWokP1y6Xx2nvZTCOA14MIAaiFiLs7HUvd
         1nrjuQPD+WNDa51v9hjJYJXLI8LxLHPrDnnOuIvlFEvg86i0LFbGUfw+dp7J37N8JGri
         Q9l/cKF0GpOFXuCBhJL1R2dyHqFj7yEwp2ebfdyyIHYNde1gGQZ6WTNA8mljvqtzSc3t
         8N2kCArmMAW2D+WHNyaf4HhC5CCl/01NgZ9+3HiJ7jGo76yNVW6uUiQzCIqRhsAE0FRe
         //mg==
X-Gm-Message-State: AOJu0YxQLY4U+ZaLVmLVh8jDRTQN1hhTIz4RULrHBlabnFa3TCN8IO1a
	Mnp81q6Y0Dicn3H8g8OjulpVX4UN72JHk4rYvVdwaQMOSWdxw8P4HVyb/dAqG7VS2xj8trNBuW/
	76u4JZtq86uaVlbK7yVS+UZrdigKhfYnCYA==
X-Gm-Gg: Acq92OG3fY7TCM7K/ds2pEnQ/2vJwI4kNnH+m72JlX/WUvorUAGhpCH6bpNomqUfa2I
	D05eaTkbYhleUXZgmg2nKt/3wH4/U5rijjDryfe6Zw0rlaDl1C1VY+Z7LVz5dws6gVcCf63AUGO
	JmwGQqVckBq1rYkTsy/IC0wtKO/HGBNnUbKGwny3xJMDO1u8irdTMQfVkMfsFqYyLJL1kmanA27
	eQfSfHh5Ij8kW48h3eGziKxOF+sWsyEVi5HhFJB0x/jTApqM8x+fsfIenfSvO58wdUdXMyatrVI
	d7nCiwY=
X-Received: by 2002:a05:6808:6508:b0:467:2509:c20a with SMTP id
 5614622812f47-482b2d31c7bmr1419358b6e.47.1778661462863; Wed, 13 May 2026
 01:37:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALXu0UdOR8mVr=8pwNP95FnOsOk1w1A2=DcayKk3YnDfS+PzUA@mail.gmail.com>
 <5acaa8e7-0691-4cbd-b501-c26831a7be81@app.fastmail.com> <CAM5tNy7GG0awNYYJWv0968e5CMoUstr0GcrNwuNKP4x3Yrp3JQ@mail.gmail.com>
 <CALXu0UckL3YYXVLz5Qn0shoZ+TU8uOxRy2FCpL5mAhLniinJyg@mail.gmail.com> <CAM5tNy76P-1Q2EhJ4zXUtc=EwRYgke8ZqJEYvM=sRyY77rxHLA@mail.gmail.com>
In-Reply-To: <CAM5tNy76P-1Q2EhJ4zXUtc=EwRYgke8ZqJEYvM=sRyY77rxHLA@mail.gmail.com>
From: Cedric Blancher <cedric.blancher@gmail.com>
Date: Wed, 13 May 2026 10:37:06 +0200
X-Gm-Features: AVHnY4IFUUwKDHeayHhYlT0IL7M3yhISRK1SFLaMDIyfS3wB7d2b14DcHzrHDFY
Message-ID: <CALXu0Ucq2Wwyuu3BUzv0i6_2UNBPDRVzXVgH4O056PoZOzEgRA@mail.gmail.com>
Subject: Re: Increase FreeBSD NFSv4 nfsd buffer size? Re: Increase default
 NFSv4 server size "max_block_size" to 4MB
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>, freebsd-hackers@freebsd.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 96AE452FC0D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21596-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cedricblancher@gmail.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Action: no action

On Wed, 13 May 2026 at 01:02, Rick Macklem <rick.macklem@gmail.com> wrote:
>
> On Tue, May 12, 2026 at 6:18=E2=80=AFAM Cedric Blancher
> <cedric.blancher@gmail.com> wrote:
> >
> > On Tue, 17 Mar 2026 at 00:35, Rick Macklem <rick.macklem@gmail.com> wro=
te:
> > >
> > > On Mon, Mar 16, 2026 at 5:41=E2=80=AFAM Chuck Lever <cel@kernel.org> =
wrote:
> > > >
> > > >
> > > > On Mon, Mar 16, 2026, at 3:51 AM, Cedric Blancher wrote:
> > > > > As debated a while ago, can the default NFSv4 server size for
> > > > > "max_block_size" be increased to 4MB, please?
> > > >
> > > > There is an administrative setting to raise this limit for
> > > > recent versions of the kernel. Can you report your experience
> > > > when you raise the limit? Hiccups, performance issues, etc? I
> > > > would kind of like this exercise to be data-driven.
> > > >
> > > > What is still unknown to me is which NFS client implementations
> > > > can support 4MB or 8MB. Without client support, an increase in
> > > > the default in NFSD doesn't mean anything. Rick, Anna, Roland?
> > > Although it has not seen much testing, it is possible to do a > 1Mbyt=
e NFSv4
> > > mount in FreeBSD.
> > > For a 2Mbyte mount, (the only size > 1Mbyte I've tried) the settings =
would be..
> > > In /boot/loader.conf
> > > kern.maxphys=3D2097152
> > > vfs.maxbcachebuf=3D2097152
> > >
> > > and in /etc/sysctl.conf
> > > kern.ipc.maxsockbuf=3D9455616
> > >
> > > Then a mount will use 2Mbytes if the server supports it.
> >
> > How can I verify that the FreeBSD NFSv4 nfsd now uses 2M for NFS buffer=
s?
> The default is 128K. (You can see what it is via "sysctl vfs.nfsd.srvmaxi=
o".)
>
> With "main",

Which FreeBSD version is "main" exactly, i.e. which 16.0 snapshot
date? Is this supported for 15.0?

> you can increase that up to 4M by putting
> nfs_server_maxio=3DN (where N can be up to 4194304 for "main" and 1048576=
 for 15)

What line do I have to put into /etc/sysctl.conf and /etc/rc.conf?

> - adding an entry in /etc/sysctl.conf for a larger value for kern.ipc.max=
sockbuf
>   (It will tell you the recommended minimum setting if you boot after
>    putting nfs_server_maxio=3DN in /etc/rc.conf.)

How can I verify that the settings work, on the NFS server side? Can
we programmatically probe which values are supported?

Ced
--=20
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur

