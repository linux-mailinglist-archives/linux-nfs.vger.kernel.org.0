Return-Path: <linux-nfs+bounces-19158-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GAtwISUcnWmPMwQAu9opvQ
	(envelope-from <linux-nfs+bounces-19158-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Feb 2026 04:33:57 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 007C318168E
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Feb 2026 04:33:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CDF313039EE3
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Feb 2026 03:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495771E8823;
	Tue, 24 Feb 2026 03:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="giBN8ySj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF51016A395
	for <linux-nfs@vger.kernel.org>; Tue, 24 Feb 2026 03:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771904019; cv=pass; b=F7zINsg0TGMO+NSl4iAgy5x+rc6qTvE1LWY8AFI6Ttdgfcj0jeYK6k3W5usHGUramANK4jB3J7OiByzz55Lqn50QNPRSvnhDdS1F8siLXj7qvwk+b7s6mf/VWcgSvnQU6QFgm6cAxlP1sVUiL6QMyehn2OWzrgR4XJRO1IL5OQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771904019; c=relaxed/simple;
	bh=iJ1Xbe4wgQdzpLHpWKAWzR1x8I4Idd27NmjrfIEaqGc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PQoBM8NChMqIeBNi5vNLZsJvSHlcC7esrd193yym5me/8TphbQktU5hDhj1t5AQxV3eAXC5QjvDCcokNdGhoOc4rmNWvsYDQ/zKNAhYSRJaB4CeYRwa+D3t1Y02rtoJASRdEy5CIQeK7rX/zcR3v4WOvD44p6PFLg1bSozF2FmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=giBN8ySj; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-65c0d2f5fe1so8626622a12.3
        for <linux-nfs@vger.kernel.org>; Mon, 23 Feb 2026 19:33:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771904016; cv=none;
        d=google.com; s=arc-20240605;
        b=Z1AdQTcXfmfS8d5cTfwIVzbSFVTLa1NZfJ7/XUILEfGK2DfEP4GSQZD0OHpymWW8AJ
         FrtVKv54XS/7acJyUBp0sCMZ1myeQVP0AafNSYvF+F9Ybk/p01orUs84LchmYQlPeHqJ
         iQsOpZoCztwdO/D98XPXoRV+VEJqvAzeqfWbJjZsfz8YYHnjTC9wkiwCDMZCKttx3e6+
         bEQdSeufm6byW1elpf+YkKITqOiWNiO6cQZL9AbgueTQR1il39y7MyR+Y30GkkdaM1lA
         FApq124ZyldvXOuuEIGkz8/dcAxj7ZDO+pXGvUcl0S7452mJTmsS2CPgTbEjUqTIntip
         LPCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iJ1Xbe4wgQdzpLHpWKAWzR1x8I4Idd27NmjrfIEaqGc=;
        fh=2bcEaM41b7WpZgu+iYPupgNPmlP1iCPd29Ti8x/Xvog=;
        b=Xxcu3C6qaRFdUQbWr1o4NB67n71JlZqAhn46Wm5ZwA5rd6Emcl863DIToA/0qT2lK1
         kqXsRM267jE/Ax2KdWNGPlaIde8r9ViGKRFZcuOT2oNHN3BzloVxXVmZNm+rGjzWdIGW
         wj2vQRHj31pCgHDDq0gRQTS2fxnUCFRGm2D2YTiRiCWPaV6yJyne39L5BXvha7ZJKN6J
         WH3V/SN/39YqWsrWQW39rxYgWCOcWgoAjC9ibT4un4mM2ITj7i8RaZRusN8j+7QJr01M
         QYDV24WJ4vjDoT7TBMpPC7t4GDuDbZ/d20tpcuRxxKN/RlbRCrQ8aWQvwRY75i53Ic/5
         YJJA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771904016; x=1772508816; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iJ1Xbe4wgQdzpLHpWKAWzR1x8I4Idd27NmjrfIEaqGc=;
        b=giBN8ySjwkQQFYIxsnKRdoyCTfBNoEmuVC+UR61SEZV2Dr0JiOQQaXXoQxnHTjJrAo
         6Td3VAgsHPyrc6C+E8Tfkq08KJMGUUHtmuVra9n0rtYQbjkS6yduLGmw0jgEk+/qeJtY
         LIThk3lOtuVh44R767g00pfD+/Mtzu2xT+l32Jl+hDbCX4w0DlOouC4ol+mccvMlX1ug
         iG1FIdogRF/iXPiFUAR1bVpiJ1n+oF6qIgALTknAZaJcLQpM4EZ0K0I0RJ58JxeFlgM4
         NP4FzJtqrkoozSS4hh4PvHSezeRvbAHKzwL4kxryPXecmLLqG3F5TPLk5L9PYtJ0TF5D
         67hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771904016; x=1772508816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iJ1Xbe4wgQdzpLHpWKAWzR1x8I4Idd27NmjrfIEaqGc=;
        b=LhizwpkMW1bdpbLO2ZzwLVBoHg54OISSGpit/PBfC8DTcuguEUYr88MzhwsRA2j+DK
         eFxa8zTyoubM6d4eSNRWHX5AH1QGnIVPsK5d6SraIO2Pt20NztWC05hyoPs81llBGOgR
         cfrf6WffYpOJCaYHZxW/BD30nisD3FggKu05QHOGTysZjnrM18xbPWerUGiLwWjEEvO+
         q1oaJRGd8Gynl9kkYaBI8NeYOI+pu6xDRdisNTtWuyAg6FGjxcUTudJ9VEqkTtSj0Kl+
         YfsTBSEX/sfijNQjwr2n1xo6n3szCaFFxsAGSyPvO3XczUhC9vvOYzCag9U+tkBoKWYb
         3sIw==
X-Forwarded-Encrypted: i=1; AJvYcCXtQxccf+c9UAGw3D8fLHe/dgH9FJ14VVdojSaTS+H0vYG8rZcRIhmO0gi7KScruZybI1MQvatR6sQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk9lNZbB0DuxSdqEqD4aVDfPrqDxAkn1BFm1a++rFT+Dqxpp3L
	ZH25CGnzaGlIzRam8OqXsMaQaL8QiUDg9OaZZLXdpIT84GzBV6P7SDYPheMfOXh/Ru8A+9jaACu
	xhnVx4AZhZqsOlCxokHcZGnk6eHVnZkA=
X-Gm-Gg: ATEYQzyuyd5ekMGevMqNXZWru8NMk0zgwL98iMsFhs4hDpEMc3L1QeW/okLWmWDPlys
	zkk8LsTfh/S8xSMAB39TBggwqm8DTrnmMbGGrs7UNMB2FrrCTSiUof5Cn8o930TI8K3zQOH7hxI
	ozhN4UhmvtVD1X3jbLiSultvR3chNotKPA35DMJQqlWvZsrLlE3GyRujkeEpHZU/3pavDhWFujV
	7LwqbvXGhOcYpykYZVvAunHdDZlPv9q0hvbmkdv4AwIoJmqiQ3FgnZK2Qgo4hXq4JrH+mWpQsmi
	ywzElQ==
X-Received: by 2002:a05:6402:4410:b0:65c:5a7b:bd99 with SMTP id
 4fb4d7f45d1cf-65ea4f0cf7cmr5793513a12.31.1771904016311; Mon, 23 Feb 2026
 19:33:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANT5p=orpQdzqxjNronnnKUo5HFGjuVwkwpjiGHQRmwh8es0Pw@mail.gmail.com>
 <2026-02-17-grimy-washed-domes-aluminum-0HKtw9@cyphar.com>
In-Reply-To: <2026-02-17-grimy-washed-domes-aluminum-0HKtw9@cyphar.com>
From: Shyam Prasad N <nspmangalore@gmail.com>
Date: Tue, 24 Feb 2026 09:03:21 +0530
X-Gm-Features: AaiRm51P7OHLrFnboWksjbRX-NAP89jcZmSdGRNEJR_eFtlS1Z-LxcXzLTEF0t4
Message-ID: <CANT5p=qNA=uYY5YHvE8MfEtM6dXMXn343F=GC5M5-0FX-OVPNA@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Support to split superblocks during remount
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, CIFS <linux-cifs@vger.kernel.org>, 
	linux-nfs@vger.kernel.org, David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19158-lists,linux-nfs=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nspmangalore@gmail.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,cyphar.com:url,cyphar.com:email]
X-Rspamd-Queue-Id: 007C318168E
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 8:30=E2=80=AFAM Aleksa Sarai <cyphar@cyphar.com> wr=
ote:
>
> On 2026-02-17, Shyam Prasad N <nspmangalore@gmail.com> wrote:
> > Filesystems today use sget/sget_fc at the time of mount to share
> > superblocks when possible to reuse resources. Often the reuse of
> > superblocks is a function of the mount options supplied. At the time
> > of umount, VFS handles the cleaning up of the superblock and only
> > notifies the filesystem when the last of those references is dropped.
> >
> > Some mount options could change during remount, and remount is
> > associated with a mount point and not the superblock it uses. Ideally,
> > during remount, the mount API needs to provide the filesystem an
> > option to call sget to get a new superblock (that can also be shared)
> > and do a put_super on the old superblock.
> >
> > I do realize that there are challenges here about how to transparently
> > failover resources (files, inodes, dentries etc) to the new
> > superblock. I would still like to understand if this is an idea worth
> > pursuing?
>
> I gave a talk at LPC 2025 about making the mount API more amenable to
> reporting these kinds of confusing behaviours with regards to mount
> options[1].
>
> It seems to me that doing this kind of splitting is far less preferable
> than providing a more robust mechanism to tell userspace about what
> exact mount flags were ignored (or were already applied). This has some
> other issues (as Christian explains during the discussion segment) but
> it seems like a more workable solution to me and is closer to what
> userspace would want.
>
> [1]: https://www.youtube.com/watch?v=3DNX5IzF6JXp0
>
> --
> Aleksa Sarai
> https://www.cyphar.com/

Thanks for sharing this. Will go over the details shared to understand
more about what you said.

--=20
Regards,
Shyam

