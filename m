Return-Path: <linux-nfs+bounces-21627-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mFfOCihPBmoaigIAu9opvQ
	(envelope-from <linux-nfs+bounces-21627-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 15 May 2026 00:39:36 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D4F547890
	for <lists+linux-nfs@lfdr.de>; Fri, 15 May 2026 00:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2D098300C7E7
	for <lists+linux-nfs@lfdr.de>; Thu, 14 May 2026 22:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509A53CEB99;
	Thu, 14 May 2026 22:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V/ct1/Wo"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68223B6BEB
	for <linux-nfs@vger.kernel.org>; Thu, 14 May 2026 22:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778798371; cv=pass; b=nhGWiWtErg+B8g3EM8uTDR4xRWAfWfHLWz7yCW64C93+Q4Gh8tEs+5c3Myw9nv/PewdbFIpWlat91193fe6e74KWmtj3UEZr31fOZdX3+BDftJjMA1ppL8/EwVDVqeyovlHBNftHJyZv9teT9fOHxwpcuDW4mFsgehJmPJs2QK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778798371; c=relaxed/simple;
	bh=u8KULefGGJBGxIWPXw43Tf1MAoEWLDtYnrs/4UlVbDc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UaJHLhVzHo5s3aXvqWoEbTult0CmLxjWxWjoR3SZ5PY6Rm7g9/uC1/r6EY0hLimG0qq82BHSkH1W9Y9Pm62AK8bJXXcot/6hqphn86mSXYVWHO81mU1254FTjzPx3OiN+M4np84mqkBxHQTQkG/p0qeuPIpx2jP5zrlsxrWYVMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V/ct1/Wo; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-67b6da5a618so12461659a12.2
        for <linux-nfs@vger.kernel.org>; Thu, 14 May 2026 15:39:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778798368; cv=none;
        d=google.com; s=arc-20240605;
        b=OFb9cLN9M3ZAF/iG380vvHGEmAscndjWaRBEkUnwh0Sqqi+TDBdq/1b1+9Dm4ilqpY
         5p1lJdOgGK82CdPFbsQqjD/05XqPgM5Kq2g8FipJkAzUTKUA6bNFftAIfADpLekdKYWT
         yRyPb4X7idNdmeiN0cw8eDXKFcAqLvqxtd7FxPB6UBWslGD6q0i9j27DtoY74D/VaBv8
         X82ZzRGiNrepzeJ8YUd4OjuHBUkNAfJbtTm4oWqBHk+DwRZW2AA21sYIoYbGPhyqdzoJ
         UY7s0WoLpOMgaGdaq9ifPFu0KdbiKCKN0I0juKuRH2Wc3ekgB4AqWP95O4vHeLX1/Pst
         j+EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oDN8hsjfehGTS5hx1EWbDpPxT7qDUuieSoUB8GGgD6U=;
        fh=iQLWJSAzkdE8z4/OfiugcK7BClbYLsXXzhWnN6eRP8s=;
        b=QfmkQGDt7zd2IvSxQFJ+KIKQJ/RKdG0Lt+9gPeVR8StGrPgAGBJIQ+RWaCDx82S0/t
         gpw9LdFzfNqZYP5pZqS9+kqgizbNaZqmG+HXv1lbYMug83SlLKbvNRpehkToFPqSUB/g
         j2sOXeluUxP98bgjk9a039Wud4biTwVf5csOaCAJo6nvjVsbQad6txv48eDJ3qPtcLXl
         cJxs1faK4VHy+74oelLmp2joX16WFBKc3cMiNT9hzBS3czT223MOo3g5vyJGvBKG4zv/
         Kokqac85lQ8kk9zm4m4WuykPbAGBvdIJMHmoEccSS2f7oWW7CN016EWPiihv3i4mpRqC
         qXBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778798368; x=1779403168; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oDN8hsjfehGTS5hx1EWbDpPxT7qDUuieSoUB8GGgD6U=;
        b=V/ct1/WoIaKDvOiN02UNise0QX4UrmPxTwXlqlmU/masIbGcha7IIOYKn0ZDek4ou6
         AgHVfZVFCz0iUM/uW/nD7FW0gT6WwjhX7NZgRqFeNrRT24FjNdS/AAeq5sykAX6xLh7l
         qAv6kDjkEfOV8ADmZMZhazgxEBCw+1GeOmt6BjqLpQHqp5Wb8m5B93hpMQNZ8McpM6dC
         mLfFjvcaLCuTmMq64+qT4SJMkKXmxac6uJ8Da3f+IQuNUBFYUuboxqJu83TgorEyrPTS
         IArS2ns+ukidTKgil9yBQLR/H783T6GR8LX9ekt+XA42/OY2e1qZKarBwiyNF4KWv0GR
         G+Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778798368; x=1779403168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oDN8hsjfehGTS5hx1EWbDpPxT7qDUuieSoUB8GGgD6U=;
        b=DtvMawc0TsBML8zvjyCtw8Koidx/m+7ppMM4cjp5SGQmjMKwUCGgQ3MFkS8c/I89zv
         2DOK63ktcH5H6SclYx7gKLa2M0zWCXOQpM2y4FJ+oQB1WtnUwGh9/I+bMLDaINsywaTg
         5IvwtvdGmy2VrzbGnrhgCbzSxK4ZvLBiZR2znrgDTmCyP0SMT5MM17heCMBe6atHOjzL
         egm4rLii3quvh4IHUGKH9vnbj88VZfUqiCbrLs+/NUPR+o/StiN+NJ8T2hvrBPSmxFUQ
         KOHxHZHz22JVgdNQsFl1mjmSj/DdzwjVgj8MurdNIxo4gsAvM2Wols3ItHu+3R9KnzE4
         uNSQ==
X-Gm-Message-State: AOJu0YxcSmgEIh8iaNHpUEBDhDTCeCcLFhst/EmqtZD0jXsRq3iG/3Da
	7y9rRMx6egSSNrSTUFn7Ixg4+4A3cszHLgrvJrtNPurssxubnzkUJ6SN+e95ASM/+/je8QGHEUo
	Wt9FL0RkY1ctn5oZAeDR6y5j7X11MOg==
X-Gm-Gg: Acq92OG7bo/k7CjZXf6xPvwh6gTFjMJqNLWBPqxhbdBKz1eosnIn9AV/2gJVaY7RTUo
	wkkSqS0V7th56c47J3QVjL9dc/rbbKZPZor4sEAFtS7wLXWROd+ey4+bmaUhGZZEgeBIQXSDzHv
	LafrPw4dWjXcYKCkvkSNHEiK9Om2bqnisPKSbyQZZvUD4VfOr9k1b5+wGITBI21URcwleBh1SIE
	yub6CFvXSq06Bphhnl7lwoa5W2L17zWjPjTp1Zg6GXxQDRdTFnUrzdUWSvYIlmteVof/Z8kZ+Lh
	zUQ1IzvU4Km2EPFU6o9/x8wWIVIh/4BQr+hzOhY=
X-Received: by 2002:a05:6402:24ce:b0:67d:a63a:deb2 with SMTP id
 4fb4d7f45d1cf-683bc1b7583mr483281a12.5.1778798367892; Thu, 14 May 2026
 15:39:27 -0700 (PDT)
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
 <CALXu0Ucq2Wwyuu3BUzv0i6_2UNBPDRVzXVgH4O056PoZOzEgRA@mail.gmail.com> <CAM5tNy7Crx-MHAO1DKwdWJdwLQX=kWrPFPke1-uLbZ4DYPnTcg@mail.gmail.com>
In-Reply-To: <CAM5tNy7Crx-MHAO1DKwdWJdwLQX=kWrPFPke1-uLbZ4DYPnTcg@mail.gmail.com>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Thu, 14 May 2026 15:39:15 -0700
X-Gm-Features: AVHnY4I23KuWb1F1M0z31hdOIYODKAmkxW40o0HP5-peF0rtMUO7EPsUDF9g_W0
Message-ID: <CAM5tNy4zgRBFAmwWCApAYvTHuhVtnkQRdhG1xpjekUnhdtsA2Q@mail.gmail.com>
Subject: Re: Increase FreeBSD NFSv4 nfsd buffer size? Re: Increase default
 NFSv4 server size "max_block_size" to 4MB
To: Cedric Blancher <cedric.blancher@gmail.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>, freebsd-hackers@freebsd.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 20D4F547890
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21627-lists,linux-nfs=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Action: no action

On Wed, May 13, 2026 at 4:38=E2=80=AFPM Rick Macklem <rick.macklem@gmail.co=
m> wrote:
>
> On Wed, May 13, 2026 at 1:37=E2=80=AFAM Cedric Blancher
> <cedric.blancher@gmail.com> wrote:
> >
> > On Wed, 13 May 2026 at 01:02, Rick Macklem <rick.macklem@gmail.com> wro=
te:
> > >
> > > On Tue, May 12, 2026 at 6:18=E2=80=AFAM Cedric Blancher
> > > <cedric.blancher@gmail.com> wrote:
> > > >
> > > > On Tue, 17 Mar 2026 at 00:35, Rick Macklem <rick.macklem@gmail.com>=
 wrote:
> > > > >
> > > > > On Mon, Mar 16, 2026 at 5:41=E2=80=AFAM Chuck Lever <cel@kernel.o=
rg> wrote:
> > > > > >
> > > > > >
> > > > > > On Mon, Mar 16, 2026, at 3:51 AM, Cedric Blancher wrote:
> > > > > > > As debated a while ago, can the default NFSv4 server size for
> > > > > > > "max_block_size" be increased to 4MB, please?
> > > > > >
> > > > > > There is an administrative setting to raise this limit for
> > > > > > recent versions of the kernel. Can you report your experience
> > > > > > when you raise the limit? Hiccups, performance issues, etc? I
> > > > > > would kind of like this exercise to be data-driven.
> > > > > >
> > > > > > What is still unknown to me is which NFS client implementations
> > > > > > can support 4MB or 8MB. Without client support, an increase in
> > > > > > the default in NFSD doesn't mean anything. Rick, Anna, Roland?
> > > > > Although it has not seen much testing, it is possible to do a > 1=
Mbyte NFSv4
> > > > > mount in FreeBSD.
> > > > > For a 2Mbyte mount, (the only size > 1Mbyte I've tried) the setti=
ngs would be..
> > > > > In /boot/loader.conf
> > > > > kern.maxphys=3D2097152
> > > > > vfs.maxbcachebuf=3D2097152
> > > > >
> > > > > and in /etc/sysctl.conf
> > > > > kern.ipc.maxsockbuf=3D9455616
> > > > >
> > > > > Then a mount will use 2Mbytes if the server supports it.
> > > >
> > > > How can I verify that the FreeBSD NFSv4 nfsd now uses 2M for NFS bu=
ffers?
> > > The default is 128K. (You can see what it is via "sysctl vfs.nfsd.srv=
maxio".)
> > >
> > > With "main",
> >
> > Which FreeBSD version is "main" exactly, i.e. which 16.0 snapshot
> > date? Is this supported for 15.0?
The commit just hit "main" as b92b9da33006. So any snapshot after
to-day should have it. (It will be MFC'd to stable/15 in 2 weeks and will
be in 15.2.)

To enable it, put this line in /etc/rc.conf:
nfs_server_maxio=3D4194304
and this line in /etc/sysctl.conf:
kern.ipc.maxsockbuf=3D18892800 (or larger)

rick

> >
> > > you can increase that up to 4M by putting
> > > nfs_server_maxio=3DN (where N can be up to 4194304 for "main" and 104=
8576 for 15)
> >
> > What line do I have to put into /etc/sysctl.conf and /etc/rc.conf?
> Oops, my bad. It isn't committed yet. I forgot that I have to convince th=
e
> FreeBSD collective to increase UIO_MAXIOV or convince the ZFS folk
> to not check for that limit in ZFS.
>
> I will email when it gets into "main".
>
> It can currently be set to 1Mbyte via
> nfs_server_maxio=3D1048576
> in /etc/rc.conf and
> kern.ipc.maxsockbuf=3D5242880  (the exact minimum setting is printed
>                                                     out if you boot
> without this set large
>                                                      enough in
> /etc/sysctl.conf.)
>                                                    --> it must be at
> least a little more than
>                                                         4 *
> nfs_server_maxio so that 4 reads
>                                                         or writes fit
> in the socket's buffers.
>
> rick
>
> >
> > > - adding an entry in /etc/sysctl.conf for a larger value for kern.ipc=
.maxsockbuf
> > >   (It will tell you the recommended minimum setting if you boot after
> > >    putting nfs_server_maxio=3DN in /etc/rc.conf.)
> >
> > How can I verify that the settings work, on the NFS server side?
> Look in a wireshark packet trace for maxread and maxwrite in a
> GETATTR reply.
>
> > Can
> > we programmatically probe which values are supported?
> The sysctl is vfs.nfsd.srvmaxio and, when you try and set this
> to too large a value, it will fail with EINVAL.
> (You can do this from C via the sysctl(3) library call. See "man 3 sysctl=
".)
>
> rick
>
> >
> > Ced
> > --
> > Cedric Blancher <cedric.blancher@gmail.com>
> > [https://plus.google.com/u/0/+CedricBlancher/]
> > Institute Pasteur
> >

