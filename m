Return-Path: <linux-nfs+bounces-21629-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UPu7AoRfBmoMjQIAu9opvQ
	(envelope-from <linux-nfs+bounces-21629-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 15 May 2026 01:49:24 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 630A8547D61
	for <lists+linux-nfs@lfdr.de>; Fri, 15 May 2026 01:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 66A033025920
	for <lists+linux-nfs@lfdr.de>; Thu, 14 May 2026 23:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE5A349CED;
	Thu, 14 May 2026 23:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kmxH2jlV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4B1D531
	for <linux-nfs@vger.kernel.org>; Thu, 14 May 2026 23:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778802560; cv=pass; b=a4GyZ4cJxeizo0OZrpdpYRDjHmxwp+LyXNRNzZFP/Ew00AKd74ub6oeipYPaRP4P5cjVcaVkYqRCxhMwiaP0B8llVqvjejr7+p7jpO2dntIBnH8I/FI5+YvNoG/kh/go+euBsydydCNZfrrmX59zpk3NCXLSdha+5JVB9gt8bUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778802560; c=relaxed/simple;
	bh=e0/D9XHaR1vhk09Td5qsifMjfEHAmA+IRC+aHxZmv8I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qNxpXxBUMrXqeMCvjF8K3l8d6m/T9upjvRnVXMmMhxV559qs+pxVBIL/1OpBmocZZIm98BGCmTzDtVy5futPUiPVQBLoqN8HIgab522W9/Mwyk4X1sVXERcc4VoUf/k1z1QguMuWjvN37HdxAqnj4EGGhrTlBx9htXNa23bGulw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kmxH2jlV; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6815add87f0so3793534a12.3
        for <linux-nfs@vger.kernel.org>; Thu, 14 May 2026 16:49:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778802557; cv=none;
        d=google.com; s=arc-20240605;
        b=WLrJ+m5zhxHHEdTIyFtuEVdx2yX+Khp7xgeG//iNGThxX9p45CDNCJZn7zNQkM3yl4
         g+fWVuholWce2b+7RzexWjYeF0qwAtj228n+ok1VjQwvpEnWjhDxE3/AUjkVe4kEJQfY
         BMIiiIo4N/Re5cdX9amCTjkmpYxPgRrRfoHrz3xSz165eS+hkxxdo1ImRt+shK89yw6C
         XHKEht0cFb1MKy0FGahFt+cyAqU+LUAQP/12YgFSYvCFiyncDL8bKTDy0rKlcTl34GeC
         FDi5+0/HSn8xR7BEsobD3/85IZkMmto9vVC/6PfusQGkJTVVPg3uS3Ba0dZVrgCX0f1m
         9Kkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8nGnQo4mnG0TW3OQLi9ywMiogChpIK4AtGv3ig87cxo=;
        fh=iQLWJSAzkdE8z4/OfiugcK7BClbYLsXXzhWnN6eRP8s=;
        b=K2k/+I8W8/oZ/IG0sLrmWWJmoOJoM1Ajztu6pVJ7bluH1jRzC4X6J4Qp6WUHLEKcEC
         7LWtYpb54sqHLP99NscYYUlstlOZyYymW8i+agVynT6k3bJHD6rhvVDmNAH7eVYhMroL
         rYTBrXiTbT/PQShX1AQHlpOYOyY9A8OjcGBPrJcQxkG3SWRFtbilhvBmxz4ATESPQZdY
         U4/wkyZm/AkCSErL/34omQSeKfc0tNEq7engyN0ROrHw5LQ+UMUL7DcRjzy+JxpikliX
         vRzojJgnVMBpkmT8r2ZUF7AG0ypE0zNkuVqkGseUONVgBGyQqs7MbXb9zmBXXlH8i72h
         KDlw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778802557; x=1779407357; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8nGnQo4mnG0TW3OQLi9ywMiogChpIK4AtGv3ig87cxo=;
        b=kmxH2jlVoW5OrrN3wKFFVLe9hl4XY+LfIpIgyM/+amgL17iu70FTqSKHx/+k0M/X09
         drXcKFka9+ibUfAIqB9yYAgVu3ZRmIgcR5gP7CDfuafJs9zDPtcfGiOZ7m8vTgdtbjHs
         YB2vIM5jWMLBSfCoQ+SD9Iv5UNb7eruGRBf4EiONQUT46UnUEDlcKy3QfQIkfszF4B4p
         rEhjnEEX3mGBVxyu1VSIB+BT7qP5D+36IE6lx64DtW15NdYCb2/sdj9Uj3bBifIiq5JK
         3yZDQjApBzsc8pC2OTHvkayjtNytzMYb6/I9LwZDXGtwfu8nui3/g2ReDtsVzy3ZN2FQ
         S58g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778802557; x=1779407357;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8nGnQo4mnG0TW3OQLi9ywMiogChpIK4AtGv3ig87cxo=;
        b=f9j/kQ/OhZ00BFWBicghDnILnOPhxSVlqos03qNQEPvZHJDTSXkk7wLbUsclM2Kdn/
         ipB1kIcL3aDPslNW/cPSf3IT3FYFZmjTbLR/Xlv1AZ1AJYaKcPfYBg/M4nOo8DYoAG7i
         vszGlmZHg+O1y8+pE1rcqPMjQsL6vBp790xxMRCAAvQ3fAzGk4K3C9RbOjPVfOJLZVQp
         EfD78AwtWZTVLYqSbyyxXe6E44HrtIgV0ncK9zTznGxXvA/0SC/HWCKqdOkvkZkr1IRF
         C7pQA4gGiExQR5nklZKC5wB0feP6iY6A3irii8ydxEa40pTymxNh8y48c9IaDDGbM3Wn
         Lq9Q==
X-Gm-Message-State: AOJu0Yz8fgTz35S8XtNOKB4Ks7TytkC4fD9sk2uO7RXertSiuAg1obOP
	LvQFGTIEorVgwj80yufbmfMxmpkmu3C3W2C/2xnf+PcwqqM0RptCL/lq/mfIvazrDe99edHPwR2
	SBIbZTteLwuvzerHJmfPGYUFN1nMOscgs
X-Gm-Gg: Acq92OFwydnrwS3c3lxK8q4PlRlLS2eUmizdZKwXqY4LxM0URsrMTLfQpUnqPd93dfy
	Uh1v3IKPINHdsA5BEM5hWQtiwDG5dtcB0i5+WPUht9bcgVMEtGUGrpNuvgXpHfNsYg5RpCjpsyc
	8lWhng/FY7FrsfUXxtlciWwD2pz4RKKkbsME/9XwLb1R9lLCuariKd8RSp7VtBr8pMpXhUomkmA
	rxbGotq0Z/hOqcYCfyKvYEU5HlVkhEFcaeL2rfeQzJCDXyKLYenH0c9ixrQYcZ900/SKnzIlBxX
	NvS1UE7YhPRToJ8pyphXmTyuXCmR8x1hJ0NI8po=
X-Received: by 2002:a05:6402:5415:b0:67e:fea7:68a with SMTP id
 4fb4d7f45d1cf-683bcd9e9e0mr642195a12.10.1778802556790; Thu, 14 May 2026
 16:49:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALXu0UdOR8mVr=8pwNP95FnOsOk1w1A2=DcayKk3YnDfS+PzUA@mail.gmail.com>
 <5acaa8e7-0691-4cbd-b501-c26831a7be81@app.fastmail.com> <CAM5tNy7GG0awNYYJWv0968e5CMoUstr0GcrNwuNKP4x3Yrp3JQ@mail.gmail.com>
 <CALXu0UckL3YYXVLz5Qn0shoZ+TU8uOxRy2FCpL5mAhLniinJyg@mail.gmail.com>
 <CAM5tNy76P-1Q2EhJ4zXUtc=EwRYgke8ZqJEYvM=sRyY77rxHLA@mail.gmail.com>
 <CALXu0Ucq2Wwyuu3BUzv0i6_2UNBPDRVzXVgH4O056PoZOzEgRA@mail.gmail.com>
 <CAM5tNy7Crx-MHAO1DKwdWJdwLQX=kWrPFPke1-uLbZ4DYPnTcg@mail.gmail.com> <CAM5tNy4zgRBFAmwWCApAYvTHuhVtnkQRdhG1xpjekUnhdtsA2Q@mail.gmail.com>
In-Reply-To: <CAM5tNy4zgRBFAmwWCApAYvTHuhVtnkQRdhG1xpjekUnhdtsA2Q@mail.gmail.com>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Thu, 14 May 2026 16:49:04 -0700
X-Gm-Features: AVHnY4J5kJnXNp3ydyWe3ZseQ5-3ghwosk0XMro8nDC2grhJhbF12G_fB2XX6Do
Message-ID: <CAM5tNy6ZbrCw46fS0mKdHpQDbk6axusk_pfoSQ8+-6vj7FiLaQ@mail.gmail.com>
Subject: Re: Increase FreeBSD NFSv4 nfsd buffer size? Re: Increase default
 NFSv4 server size "max_block_size" to 4MB
To: Cedric Blancher <cedric.blancher@gmail.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>, freebsd-hackers@freebsd.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 630A8547D61
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21629-lists,linux-nfs=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rickmacklem@gmail.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Action: no action

On Thu, May 14, 2026 at 3:39=E2=80=AFPM Rick Macklem <rick.macklem@gmail.co=
m> wrote:
>
> On Wed, May 13, 2026 at 4:38=E2=80=AFPM Rick Macklem <rick.macklem@gmail.=
com> wrote:
> >
> > On Wed, May 13, 2026 at 1:37=E2=80=AFAM Cedric Blancher
> > <cedric.blancher@gmail.com> wrote:
> > >
> > > On Wed, 13 May 2026 at 01:02, Rick Macklem <rick.macklem@gmail.com> w=
rote:
> > > >
> > > > On Tue, May 12, 2026 at 6:18=E2=80=AFAM Cedric Blancher
> > > > <cedric.blancher@gmail.com> wrote:
> > > > >
> > > > > On Tue, 17 Mar 2026 at 00:35, Rick Macklem <rick.macklem@gmail.co=
m> wrote:
> > > > > >
> > > > > > On Mon, Mar 16, 2026 at 5:41=E2=80=AFAM Chuck Lever <cel@kernel=
.org> wrote:
> > > > > > >
> > > > > > >
> > > > > > > On Mon, Mar 16, 2026, at 3:51 AM, Cedric Blancher wrote:
> > > > > > > > As debated a while ago, can the default NFSv4 server size f=
or
> > > > > > > > "max_block_size" be increased to 4MB, please?
> > > > > > >
> > > > > > > There is an administrative setting to raise this limit for
> > > > > > > recent versions of the kernel. Can you report your experience
> > > > > > > when you raise the limit? Hiccups, performance issues, etc? I
> > > > > > > would kind of like this exercise to be data-driven.
> > > > > > >
> > > > > > > What is still unknown to me is which NFS client implementatio=
ns
> > > > > > > can support 4MB or 8MB. Without client support, an increase i=
n
> > > > > > > the default in NFSD doesn't mean anything. Rick, Anna, Roland=
?
> > > > > > Although it has not seen much testing, it is possible to do a >=
 1Mbyte NFSv4
> > > > > > mount in FreeBSD.
> > > > > > For a 2Mbyte mount, (the only size > 1Mbyte I've tried) the set=
tings would be..
> > > > > > In /boot/loader.conf
> > > > > > kern.maxphys=3D2097152
> > > > > > vfs.maxbcachebuf=3D2097152
> > > > > >
> > > > > > and in /etc/sysctl.conf
> > > > > > kern.ipc.maxsockbuf=3D9455616
> > > > > >
> > > > > > Then a mount will use 2Mbytes if the server supports it.
> > > > >
> > > > > How can I verify that the FreeBSD NFSv4 nfsd now uses 2M for NFS =
buffers?
> > > > The default is 128K. (You can see what it is via "sysctl vfs.nfsd.s=
rvmaxio".)
> > > >
> > > > With "main",
> > >
> > > Which FreeBSD version is "main" exactly, i.e. which 16.0 snapshot
> > > date? Is this supported for 15.0?
> The commit just hit "main" as b92b9da33006. So any snapshot after
> to-day should have it. (It will be MFC'd to stable/15 in 2 weeks and will
> be in 15.2.)
>
> To enable it, put this line in /etc/rc.conf:
> nfs_server_maxio=3D4194304
> and this line in /etc/sysctl.conf:
> kern.ipc.maxsockbuf=3D18892800 (or larger)
Oh, and I should also point out that, for the low end hardware I have,
I have never seen a performance improvement for a maxio setting
above 256Kbytes.  The story may be different for faster hardware,
but I wouldn't just assume that bumping it up will get you better
performance. (There is, of course, also a difference between getting
better performance for a single client vs fair distribution of server
resources across many clients.)

rick

>
> rick
>
> > >
> > > > you can increase that up to 4M by putting
> > > > nfs_server_maxio=3DN (where N can be up to 4194304 for "main" and 1=
048576 for 15)
> > >
> > > What line do I have to put into /etc/sysctl.conf and /etc/rc.conf?
> > Oops, my bad. It isn't committed yet. I forgot that I have to convince =
the
> > FreeBSD collective to increase UIO_MAXIOV or convince the ZFS folk
> > to not check for that limit in ZFS.
> >
> > I will email when it gets into "main".
> >
> > It can currently be set to 1Mbyte via
> > nfs_server_maxio=3D1048576
> > in /etc/rc.conf and
> > kern.ipc.maxsockbuf=3D5242880  (the exact minimum setting is printed
> >                                                     out if you boot
> > without this set large
> >                                                      enough in
> > /etc/sysctl.conf.)
> >                                                    --> it must be at
> > least a little more than
> >                                                         4 *
> > nfs_server_maxio so that 4 reads
> >                                                         or writes fit
> > in the socket's buffers.
> >
> > rick
> >
> > >
> > > > - adding an entry in /etc/sysctl.conf for a larger value for kern.i=
pc.maxsockbuf
> > > >   (It will tell you the recommended minimum setting if you boot aft=
er
> > > >    putting nfs_server_maxio=3DN in /etc/rc.conf.)
> > >
> > > How can I verify that the settings work, on the NFS server side?
> > Look in a wireshark packet trace for maxread and maxwrite in a
> > GETATTR reply.
> >
> > > Can
> > > we programmatically probe which values are supported?
> > The sysctl is vfs.nfsd.srvmaxio and, when you try and set this
> > to too large a value, it will fail with EINVAL.
> > (You can do this from C via the sysctl(3) library call. See "man 3 sysc=
tl".)
> >
> > rick
> >
> > >
> > > Ced
> > > --
> > > Cedric Blancher <cedric.blancher@gmail.com>
> > > [https://plus.google.com/u/0/+CedricBlancher/]
> > > Institute Pasteur
> > >

