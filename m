Return-Path: <linux-nfs+bounces-21609-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6M25IWoLBWo1RwIAu9opvQ
	(envelope-from <linux-nfs+bounces-21609-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 14 May 2026 01:38:18 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0753353C124
	for <lists+linux-nfs@lfdr.de>; Thu, 14 May 2026 01:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ED8A0300DA60
	for <lists+linux-nfs@lfdr.de>; Wed, 13 May 2026 23:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7A1388E75;
	Wed, 13 May 2026 23:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ofY4IAsq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A104A221275
	for <linux-nfs@vger.kernel.org>; Wed, 13 May 2026 23:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778715496; cv=pass; b=NUUjBaHe9KF0Aet6M9Jp7TRuBEDheVx6fi2DRcmAaaKiHt4+X4QjF+Q5KEcq8NvDRdMg0N3ZzYisq8YAsloD4e42HiDiEWI7ct9jm7wq5UI71fB6Bd3p/yCQK2UGhga/2En6EYF0KIX3EBJqwXzMjGFJxgOLaie3by3ED7n4/gY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778715496; c=relaxed/simple;
	bh=9/P+aq/MdbsAyr2u3m6t2u+YkrEeZj7CLgxi3w2bWJI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kuaBCiwjur+ZjWqx8U/Dqd9iuAMiX7s81YB8izLXx3+N+cirt0aIAyseyaSAATaOZ94PVOIck7FHfaYjBcv3CbAYdlGr3UtcQQfVcI3QkPEDtuFV0yVCQHmigMu80fIvrEK1Is82LNStDX4s8ZI+d/9QM4WQmnvXL0u2qcfSoDA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ofY4IAsq; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b9d9971d059so1078551666b.2
        for <linux-nfs@vger.kernel.org>; Wed, 13 May 2026 16:38:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778715493; cv=none;
        d=google.com; s=arc-20240605;
        b=RWE0vnfVpQmIlFka4fBzm2zh6PYL2AoIjF9eFvy0VBBWpi/+RVsKogdWGc8qcD+xos
         tW919B4QKLjM6veCGM93amysyf7XxLKLPhq9v3v/1NvDv/Ravsmq8191blZEYN9QmEBq
         7kXuJi3HcVvAA6kf9ndwGNWe0nsWxbtc26lwus+B5cWSEE2mppOoaZM8ghUtapdsX3QF
         iv7/GfMz5APEn/WWZSZwN8mK/21t3NxtRhhTCUHveDtxrToncDXo136B/RPuoTzp3NCz
         CtiSQRfOsZiJzIjhdqfCkBibhq9rCxgv4tTfZ5+hxvLPKPUfNF0+QqTgNf7wkcLlPbay
         ABBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OT8ZgXHH3FVBBB3wStEBFyXQ+jOsVGSY94ekFs6wiaI=;
        fh=iQLWJSAzkdE8z4/OfiugcK7BClbYLsXXzhWnN6eRP8s=;
        b=IdghmN6kCKfjihQhMb4yoBS3eLzRkKGyoWDmHfUocQqQqyo3U1KJKfdWReRHhuxgb/
         mdrHKMBSb5RZfqEo0g49HFggM4c4P6uW9jYKWOkBzWdnu2BZki1ZWq80AZjKpyQfX/Ad
         gL4UIZce2ax0i3WS4s+LxaGqWnS96TnUBZK58GNMhm0hiiI0RCfYio1mDPkTQBfyc1w/
         7lZ/K+/SWzCWmxDXb7H/9kFvCpsPNyFEnPGZ1MoztTbIYlEqseECP2LheMRTu0g2Ii1v
         kwvPlxVnTq5XVWbcgv8IfqY0SuVYMcQbnCd7xK8b7Auu5Tqneys4Dq+pa9sgK/Eayqjm
         mkXw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778715493; x=1779320293; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OT8ZgXHH3FVBBB3wStEBFyXQ+jOsVGSY94ekFs6wiaI=;
        b=ofY4IAsqk0DLQuZvJWtxJGarKuvh/ImjP9gj5LvZrSqQnfS10RLmKG6fAkAtqWFoAE
         iMvTkOvLGGWG//0/wwiOdhNZDU3FQHt6ObdEljLKOH3tCQ/NpaZlqLrEaDlO2WARYXKh
         1staxZJqJcfEyziHsgg6tQrtRlTPL4s4ddsSgvbWblY8zlbTaJIvBu8ySzmUnu9x9kaa
         GCo35wl/ouQRhWXgbWkDo4BDfzXzGa+ZT4EG3Hmf5eX7eNE3AVtK3pfCdn+BSqVEw4UF
         jXA3gOOWLQZYOrT21GMN3DTRSg1+eUWwtJiRgiKR/7dqJ8pDl+Zu/9pDmGcRIEDHqzeZ
         NtvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778715493; x=1779320293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OT8ZgXHH3FVBBB3wStEBFyXQ+jOsVGSY94ekFs6wiaI=;
        b=nFbC85uqYKnZwlWhwsGKVldbkKU8vszC9qifXRjxuJNgc3D7LxYkqkuIbBgnnsAnZX
         u4VpDqncRtpWS0pnuK4304JnybDFXDhqNz62qf3wMRwVzuPodOX88M+jA7WEavn2LNxs
         kzAGg+cwrTuhx7Qq+00bZDxuGESr5iQIDd5hqH4JgFar6BcG0bsNE9nhGM0UuNoxYZG/
         2YS2fl/kbDqfZ5N/KbIXhwPJ+ByQenOq1AytttP2s1uAJ5CDYk7i6dKAi1ApKMjX3u5H
         aiuUIRpZiMQiOTTxBEj+uGpsO3N18aEqwFkeuzfIK2Ecm0xdMquHEfuSEhOWMoz/AT7w
         l6pg==
X-Gm-Message-State: AOJu0YwHh7kOo+58bTuDbGZPBqOWtC+TqMpFxdF0msTbarTpks7wMVDH
	sX8EYl9d9zNnrJ4oSx01KROuiy0xbFwilAst6UxhusFTATMkDqcXzWs9Whu2I+LVLjvtPnBHE9b
	P3oD96WYx8eLmOjqfAUH/s2kYcNKaLJ5s
X-Gm-Gg: Acq92OEDS8e1vG9fCh2pA10FbLLAeWTeOsjgXigzFgor6d8syTHvLrQUyyUGYgEd+lw
	tS2eEdA4W6FUKh2LQdBSKzvNYVmt6rpnnH01tfqVPDaeWIdT9HuTIcTIbh7GzDjB/RFLETDLw65
	jjDqLFWSLEu5+RQc3mzABI+ftXZR0UnfRa1MlDyjKZdcgbL8Py7OfYbnq6b11wdDJvR8GotJgQM
	G9CIKK2aQuY7TikUu3gW0pY1nmxTFegpMx4eqry3nWYSTWvyTozpHwooxnbAWwLBq79sWOu2+pe
	CtjjFB+xA6/5BKonajvi6CFqEDck4pEU86WI8QU=
X-Received: by 2002:a17:907:7205:b0:bba:3cf3:2ba6 with SMTP id
 a640c23a62f3a-bd3e24fbee6mr342112966b.29.1778715492886; Wed, 13 May 2026
 16:38:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALXu0UdOR8mVr=8pwNP95FnOsOk1w1A2=DcayKk3YnDfS+PzUA@mail.gmail.com>
 <5acaa8e7-0691-4cbd-b501-c26831a7be81@app.fastmail.com> <CAM5tNy7GG0awNYYJWv0968e5CMoUstr0GcrNwuNKP4x3Yrp3JQ@mail.gmail.com>
 <CALXu0UckL3YYXVLz5Qn0shoZ+TU8uOxRy2FCpL5mAhLniinJyg@mail.gmail.com>
 <CAM5tNy76P-1Q2EhJ4zXUtc=EwRYgke8ZqJEYvM=sRyY77rxHLA@mail.gmail.com> <CALXu0Ucq2Wwyuu3BUzv0i6_2UNBPDRVzXVgH4O056PoZOzEgRA@mail.gmail.com>
In-Reply-To: <CALXu0Ucq2Wwyuu3BUzv0i6_2UNBPDRVzXVgH4O056PoZOzEgRA@mail.gmail.com>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Wed, 13 May 2026 16:38:00 -0700
X-Gm-Features: AVHnY4ICzL2lejQveTgk-S-6RXn8iFWCW2URjBhbGMjIN2-LdllAGAy-ZyqoXeg
Message-ID: <CAM5tNy7Crx-MHAO1DKwdWJdwLQX=kWrPFPke1-uLbZ4DYPnTcg@mail.gmail.com>
Subject: Re: Increase FreeBSD NFSv4 nfsd buffer size? Re: Increase default
 NFSv4 server size "max_block_size" to 4MB
To: Cedric Blancher <cedric.blancher@gmail.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>, freebsd-hackers@freebsd.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 0753353C124
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21609-lists,linux-nfs=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Action: no action

On Wed, May 13, 2026 at 1:37=E2=80=AFAM Cedric Blancher
<cedric.blancher@gmail.com> wrote:
>
> On Wed, 13 May 2026 at 01:02, Rick Macklem <rick.macklem@gmail.com> wrote=
:
> >
> > On Tue, May 12, 2026 at 6:18=E2=80=AFAM Cedric Blancher
> > <cedric.blancher@gmail.com> wrote:
> > >
> > > On Tue, 17 Mar 2026 at 00:35, Rick Macklem <rick.macklem@gmail.com> w=
rote:
> > > >
> > > > On Mon, Mar 16, 2026 at 5:41=E2=80=AFAM Chuck Lever <cel@kernel.org=
> wrote:
> > > > >
> > > > >
> > > > > On Mon, Mar 16, 2026, at 3:51 AM, Cedric Blancher wrote:
> > > > > > As debated a while ago, can the default NFSv4 server size for
> > > > > > "max_block_size" be increased to 4MB, please?
> > > > >
> > > > > There is an administrative setting to raise this limit for
> > > > > recent versions of the kernel. Can you report your experience
> > > > > when you raise the limit? Hiccups, performance issues, etc? I
> > > > > would kind of like this exercise to be data-driven.
> > > > >
> > > > > What is still unknown to me is which NFS client implementations
> > > > > can support 4MB or 8MB. Without client support, an increase in
> > > > > the default in NFSD doesn't mean anything. Rick, Anna, Roland?
> > > > Although it has not seen much testing, it is possible to do a > 1Mb=
yte NFSv4
> > > > mount in FreeBSD.
> > > > For a 2Mbyte mount, (the only size > 1Mbyte I've tried) the setting=
s would be..
> > > > In /boot/loader.conf
> > > > kern.maxphys=3D2097152
> > > > vfs.maxbcachebuf=3D2097152
> > > >
> > > > and in /etc/sysctl.conf
> > > > kern.ipc.maxsockbuf=3D9455616
> > > >
> > > > Then a mount will use 2Mbytes if the server supports it.
> > >
> > > How can I verify that the FreeBSD NFSv4 nfsd now uses 2M for NFS buff=
ers?
> > The default is 128K. (You can see what it is via "sysctl vfs.nfsd.srvma=
xio".)
> >
> > With "main",
>
> Which FreeBSD version is "main" exactly, i.e. which 16.0 snapshot
> date? Is this supported for 15.0?
>
> > you can increase that up to 4M by putting
> > nfs_server_maxio=3DN (where N can be up to 4194304 for "main" and 10485=
76 for 15)
>
> What line do I have to put into /etc/sysctl.conf and /etc/rc.conf?
Oops, my bad. It isn't committed yet. I forgot that I have to convince the
FreeBSD collective to increase UIO_MAXIOV or convince the ZFS folk
to not check for that limit in ZFS.

I will email when it gets into "main".

It can currently be set to 1Mbyte via
nfs_server_maxio=3D1048576
in /etc/rc.conf and
kern.ipc.maxsockbuf=3D5242880  (the exact minimum setting is printed
                                                    out if you boot
without this set large
                                                     enough in
/etc/sysctl.conf.)
                                                   --> it must be at
least a little more than
                                                        4 *
nfs_server_maxio so that 4 reads
                                                        or writes fit
in the socket's buffers.

rick

>
> > - adding an entry in /etc/sysctl.conf for a larger value for kern.ipc.m=
axsockbuf
> >   (It will tell you the recommended minimum setting if you boot after
> >    putting nfs_server_maxio=3DN in /etc/rc.conf.)
>
> How can I verify that the settings work, on the NFS server side?
Look in a wireshark packet trace for maxread and maxwrite in a
GETATTR reply.

> Can
> we programmatically probe which values are supported?
The sysctl is vfs.nfsd.srvmaxio and, when you try and set this
to too large a value, it will fail with EINVAL.
(You can do this from C via the sysctl(3) library call. See "man 3 sysctl".=
)

rick

>
> Ced
> --
> Cedric Blancher <cedric.blancher@gmail.com>
> [https://plus.google.com/u/0/+CedricBlancher/]
> Institute Pasteur
>

