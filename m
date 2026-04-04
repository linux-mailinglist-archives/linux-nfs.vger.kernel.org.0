Return-Path: <linux-nfs+bounces-20656-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oL1xEoUr0Wm2GAcAu9opvQ
	(envelope-from <linux-nfs+bounces-20656-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 04 Apr 2026 17:17:25 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BABD539B8D8
	for <lists+linux-nfs@lfdr.de>; Sat, 04 Apr 2026 17:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A0ADE300A7DA
	for <lists+linux-nfs@lfdr.de>; Sat,  4 Apr 2026 15:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C27828BAB9;
	Sat,  4 Apr 2026 15:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s77Y1FzX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7959D2459CF
	for <linux-nfs@vger.kernel.org>; Sat,  4 Apr 2026 15:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775315842; cv=pass; b=kRKPev3Q33u4TzbWdDp0hddFb6VxSzk2/2/lfLNx+GHN/gfRxX7ev4nHwlIKljZPsjjYiUqCCeqsd2TjlcSsNG6/sKtHyIsej+Io2DvzHktBcuBpjqLxUNsSyvlr0Zzu1CxWe/dxocaXfp3r/5baOqoWawMLvjrBLG8gOiED9UQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775315842; c=relaxed/simple;
	bh=iJkUBTHI8W8Yq4GfHOouMA+FFui5r396sp7Kzj9EaR0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eEjjubUby0kM2f2+bNzlP8hxIr7eYg/faLf3WQJBkUSNVXAlsXjg0o/Dxa+zw1NqxloSP0WvMakz1Tae8q1DDkO8n0K1TXOetmK049UwIwejXCzZ9NYq0ouRKgwESmeQ0oQgs+Jj8QSclCSWDqYVKz6e6ecrh5Tl7LiiBI4inLQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s77Y1FzX; arc=pass smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-60591ade110so1795627137.1
        for <linux-nfs@vger.kernel.org>; Sat, 04 Apr 2026 08:17:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775315839; cv=none;
        d=google.com; s=arc-20240605;
        b=d5DI1qNwuyiNrcMc96m7Vsu07sBzKjFzHjleSBI6Pa2GZCixxlZ/tYHxNMT3GbrPZV
         TFzKHTzmg64We0yuJiFHenW+qvaxFS3uY5qgOU1adewbzLkBB/l5sYmF6qIf9yiuPZoU
         H9n0VIWjWP0guk4G6yFQwugTJksVX42kR28a9MuVdqYn6zHQalRSHMmAOI4vat8rtc5M
         Lcs92/pOZYfuaQV+7vphMzfql1uX+lbp5dIaL5IZxvUzIPa4JLM+Pow1igc3jCU5fJsP
         fUv829XH6X+I41Y9mfsQ1tD0EkN3Abf/xYl1jpHpeoa4eDhOsZbFmoEj9/emBD2w5xSP
         W0kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=n1MY/rgzPW8aC/hTJxOzosMzWp+WcyNGjBARHB4s6mE=;
        fh=MKNhqDXMzujkSijNGOEGIBVk03wgYwrA377d6wpuyQw=;
        b=YCrlOxMVeSkQFgTgOJBhVQM3ntgybBs4uWekfchyBGf4YXJGTZZoxGqzLO0vl48lXF
         UQql2ikQFkbp4sD4D6oSMQLfImmz/8caBQy1hIqY9VlHgzafb/PCsdBolqAPXq/QGUOU
         w+TFwe/BEEv5I7vDFDKRiZKRu9MN84vw7CW0Jw1dCSYxHBNmpxEVppDj6LRe9Q9w+ud1
         q5Qln2pJGJkYHWsTenQjGA3WW9Iuu8kczxdvv+NkdKBy00/JhgwtK32p2YCMqtNupLBL
         teUB85PBj7hOxQvQypaDhwKiuLGUb+ljGkIjuFFJhc/p/24A4yaIpfSGF2oy09crSzCy
         M9Ug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775315839; x=1775920639; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n1MY/rgzPW8aC/hTJxOzosMzWp+WcyNGjBARHB4s6mE=;
        b=s77Y1FzXFarjgMt/1UF7yVWyGwofP1rrRJZ793/XKhISR6nPYvGAzxESq2L/Q8kK74
         NFoEm5E6kfl4AivMnU/c+5VoDIjEbUVLnJvG75KOY2Ik0pKi4lT57u7z8zVH8oyZUP3H
         okq0yfKsa+kX7zT8e3oFWM6jv0QAWdEfmni/hRZJ5Ws1zslDKPoYEsqUKHI1Z5mZ5wPd
         g0m/5M+VHUg0oeftYfabAqfxbrAO0D3gQPtS1sM4OJMMcWNtD2Z9TwrFf4Fea4TkN5OQ
         Ayife0wHbUDV1iFOf7Ja0EY8S5U9DqzKM/ZzVboKjrNZMOWTv7dUw9Gc+U9JIOVAolkr
         e3rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775315839; x=1775920639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n1MY/rgzPW8aC/hTJxOzosMzWp+WcyNGjBARHB4s6mE=;
        b=C0RuPq4xlja/kioMU5VGWiuOzSsDrXkWxNn89nEr0uYXPPJdF8wtpM8rftsdkFOlHN
         kUSUog696z1IfBN57tLNtQd65AC02wqhv0dwT8V4o6c/BD/Kz/4VV2zdiGza2EgvFNeL
         JceHSPIpUGIcIewamJQakFh7X6GAh2PtImZFkzHE0T1jihw6qnL9nbFxD0cySzpnJgFD
         vAlOU4wexfol5OEGaaa3J3OmkIppHnpuG6hOase6kJx+/1xhLZAHTCIf2OXtEm9Tn+ef
         gvh5d/8noCM576SWkX7kqSD7LecMbCuW5TglRxuneAeAT0PNifcxpowFComrlb9wAwE1
         dVIQ==
X-Forwarded-Encrypted: i=1; AJvYcCU63HHh4jSRHcQAQeiwEUB4dbAcwTEx+iAwKFiBsiheXK9hOwffR5IhfW7Mc5BlYbXBhlhOGDV3ONY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlBa2+0BYphRhAbwuv3PDXBTEq5+slFifY3O04nZeSysM0veEO
	AfxpEq3IcXZ7eXDz9+obe/ABAuA1WUgoAdhX4godSuMyTbdQquUIEXF+1gHLV27MCcpHgUgr6Nr
	W+S81n4rS/qBbnvsXABu/41y0CH5Q62w=
X-Gm-Gg: AeBDietHoHDvuzxAEWzcKjQnLn4wpS3tuYBXOHnVVAOXGm/H9oWOrNq8aZ8kA775xm9
	CuzDxFZLmc14LMpS5ANNNu/BFVPhPnpbAeG7GKyhkop5z8KdYDIkCdKQEdWpHHDZ6B8cgazkp4Z
	CvG9NsQdPUL6nBfC9YOarjZZjLZNRjsNThApT0DIXm4wxaqbM8hCOklTgi8vYgqNbPBLKf/epgR
	EA3gE93BSvRAD9r0KT3CNlnq7KXGAnaC2WaGFJQX2JYhPIKHQYzoxt2krSPBHWAb5hyXmCpvxTy
	ls7qn/FYHdl6UYRbe62t/pYrQJDKQoD85VjEBod4dxI=
X-Received: by 2002:a05:6102:6046:b0:601:f85b:efeb with SMTP id
 ada2fe7eead31-605a4dced8bmr2528576137.9.1775315839238; Sat, 04 Apr 2026
 08:17:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260328172314.45807-1-dorjoychy111@gmail.com>
 <20260328172314.45807-2-dorjoychy111@gmail.com> <e526fbdb450a593b575355c1c9ae21f286427275.camel@kernel.org>
 <CAFfO_h75dF2s83VNtUaNuRmto1NVVcxo7kN6eAtNtN3ME8mPiQ@mail.gmail.com> <4385168f2147efb8131d5fe4209e88d2d15a60bf.camel@kernel.org>
In-Reply-To: <4385168f2147efb8131d5fe4209e88d2d15a60bf.camel@kernel.org>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Sat, 4 Apr 2026 21:17:08 +0600
X-Gm-Features: AQROBzCQF2-YPXzLWBuj6trmnUQAKh_7YQnhBAKjxSQrB6QucZDOdQgFzGpIDh4
Message-ID: <CAFfO_h4dhsXji=+FjO9EikX0_oUUDkWe8tC1F7u4WqhNAjRB=g@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] openat2: new OPENAT2_REGULAR flag support
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, ceph-devel@vger.kernel.org, gfs2@lists.linux.dev, 
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, v9fs@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	jack@suse.cz, chuck.lever@oracle.com, alex.aring@gmail.com, arnd@arndb.de, 
	adilger@dilger.ca, mjguzik@gmail.com, smfrench@gmail.com, 
	richard.henderson@linaro.org, mattst88@gmail.com, linmag7@gmail.com, 
	tsbogend@alpha.franken.de, James.Bottomley@hansenpartnership.com, 
	deller@gmx.de, davem@davemloft.net, andreas@gaisler.com, idryomov@gmail.com, 
	amarkuze@redhat.com, slava@dubeyko.com, agruenba@redhat.com, 
	trondmy@kernel.org, anna@kernel.org, sfrench@samba.org, pc@manguebit.org, 
	ronniesahlberg@gmail.com, sprasad@microsoft.com, tom@talpey.com, 
	bharathsm@microsoft.com, shuah@kernel.org, miklos@szeredi.hu, 
	hansg@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20656-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[42];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,gmail.com,arndb.de,dilger.ca,linaro.org,alpha.franken.de,hansenpartnership.com,gmx.de,davemloft.net,gaisler.com,redhat.com,dubeyko.com,samba.org,manguebit.org,microsoft.com,talpey.com,szeredi.hu];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.988];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dorjoychy111@gmail.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: BABD539B8D8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 2, 2026 at 1:02=E2=80=AFAM Jeff Layton <jlayton@kernel.org> wro=
te:
>
> On Mon, 2026-03-30 at 21:07 +0600, Dorjoy Chowdhury wrote:
> > On Mon, Mar 30, 2026 at 5:49=E2=80=AFPM Jeff Layton <jlayton@kernel.org=
> wrote:
> > >
> > > On Sat, 2026-03-28 at 23:22 +0600, Dorjoy Chowdhury wrote:
> > > > This flag indicates the path should be opened if it's a regular fil=
e.
> > > > This is useful to write secure programs that want to avoid being
> > > > tricked into opening device nodes with special semantics while thin=
king
> > > > they operate on regular files. This is a requested feature from the
> > > > uapi-group[1].
> > > >
> > > > A corresponding error code EFTYPE has been introduced. For example,=
 if
> > > > openat2 is called on path /dev/null with OPENAT2_REGULAR in the fla=
g
> > > > param, it will return -EFTYPE. EFTYPE is already used in BSD system=
s
> > > > like FreeBSD, macOS.
> > > >
> > > > When used in combination with O_CREAT, either the regular file is
> > > > created, or if the path already exists, it is opened if it's a regu=
lar
> > > > file. Otherwise, -EFTYPE is returned.
> > > >
> > > > When OPENAT2_REGULAR is combined with O_DIRECTORY, -EINVAL is retur=
ned
> > > > as it doesn't make sense to open a path that is both a directory an=
d a
> > > > regular file.
> > > >
> > > > [1]: https://uapi-group.org/kernel-features/#ability-to-only-open-r=
egular-files
> > > >
> > > > Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
> > > > ---
> > > >  arch/alpha/include/uapi/asm/errno.h        |  2 ++
> > > >  arch/alpha/include/uapi/asm/fcntl.h        |  1 +
> > > >  arch/mips/include/uapi/asm/errno.h         |  2 ++
> > > >  arch/parisc/include/uapi/asm/errno.h       |  2 ++
> > > >  arch/parisc/include/uapi/asm/fcntl.h       |  1 +
> > > >  arch/sparc/include/uapi/asm/errno.h        |  2 ++
> > > >  arch/sparc/include/uapi/asm/fcntl.h        |  1 +
> > > >  fs/ceph/file.c                             |  4 ++++
> > > >  fs/fcntl.c                                 |  4 ++--
> > > >  fs/gfs2/inode.c                            |  6 ++++++
> > > >  fs/namei.c                                 |  4 ++++
> > > >  fs/nfs/dir.c                               |  4 ++++
> > > >  fs/open.c                                  |  8 +++++---
> > > >  fs/smb/client/dir.c                        | 14 +++++++++++++-
> > > >  include/linux/fcntl.h                      |  2 ++
> > > >  include/uapi/asm-generic/errno.h           |  2 ++
> > > >  include/uapi/asm-generic/fcntl.h           |  4 ++++
> > > >  tools/arch/alpha/include/uapi/asm/errno.h  |  2 ++
> > > >  tools/arch/mips/include/uapi/asm/errno.h   |  2 ++
> > > >  tools/arch/parisc/include/uapi/asm/errno.h |  2 ++
> > > >  tools/arch/sparc/include/uapi/asm/errno.h  |  2 ++
> > > >  tools/include/uapi/asm-generic/errno.h     |  2 ++
> > > >  22 files changed, 67 insertions(+), 6 deletions(-)
> > > >
> > > > diff --git a/arch/alpha/include/uapi/asm/errno.h b/arch/alpha/inclu=
de/uapi/asm/errno.h
> > > > index 6791f6508632..1a99f38813c7 100644
> > > > --- a/arch/alpha/include/uapi/asm/errno.h
> > > > +++ b/arch/alpha/include/uapi/asm/errno.h
> > > > @@ -127,4 +127,6 @@
> > > >
> > > >  #define EHWPOISON    139     /* Memory page has hardware error */
> > > >
> > > > +#define EFTYPE               140     /* Wrong file type for the in=
tended operation */
> > > > +
> > > >  #endif
> > > > diff --git a/arch/alpha/include/uapi/asm/fcntl.h b/arch/alpha/inclu=
de/uapi/asm/fcntl.h
> > > > index 50bdc8e8a271..fe488bf7c18e 100644
> > > > --- a/arch/alpha/include/uapi/asm/fcntl.h
> > > > +++ b/arch/alpha/include/uapi/asm/fcntl.h
> > > > @@ -34,6 +34,7 @@
> > > >
> > > >  #define O_PATH               040000000
> > > >  #define __O_TMPFILE  0100000000
> > > > +#define OPENAT2_REGULAR      0200000000
> > > >
> > > >  #define F_GETLK              7
> > > >  #define F_SETLK              8
> > > > diff --git a/arch/mips/include/uapi/asm/errno.h b/arch/mips/include=
/uapi/asm/errno.h
> > > > index c01ed91b1ef4..1835a50b69ce 100644
> > > > --- a/arch/mips/include/uapi/asm/errno.h
> > > > +++ b/arch/mips/include/uapi/asm/errno.h
> > > > @@ -126,6 +126,8 @@
> > > >
> > > >  #define EHWPOISON    168     /* Memory page has hardware error */
> > > >
> > > > +#define EFTYPE               169     /* Wrong file type for the in=
tended operation */
> > > > +
> > > >  #define EDQUOT               1133    /* Quota exceeded */
> > > >
> > > >
> > > > diff --git a/arch/parisc/include/uapi/asm/errno.h b/arch/parisc/inc=
lude/uapi/asm/errno.h
> > > > index 8cbc07c1903e..93194fbb0a80 100644
> > > > --- a/arch/parisc/include/uapi/asm/errno.h
> > > > +++ b/arch/parisc/include/uapi/asm/errno.h
> > > > @@ -124,4 +124,6 @@
> > > >
> > > >  #define EHWPOISON    257     /* Memory page has hardware error */
> > > >
> > > > +#define EFTYPE               258     /* Wrong file type for the in=
tended operation */
> > > > +
> > > >  #endif
> > > > diff --git a/arch/parisc/include/uapi/asm/fcntl.h b/arch/parisc/inc=
lude/uapi/asm/fcntl.h
> > > > index 03dee816cb13..d46812f2f0f4 100644
> > > > --- a/arch/parisc/include/uapi/asm/fcntl.h
> > > > +++ b/arch/parisc/include/uapi/asm/fcntl.h
> > > > @@ -19,6 +19,7 @@
> > > >
> > > >  #define O_PATH               020000000
> > > >  #define __O_TMPFILE  040000000
> > > > +#define OPENAT2_REGULAR      0100000000
> > > >
> > > >  #define F_GETLK64    8
> > > >  #define F_SETLK64    9
> > > > diff --git a/arch/sparc/include/uapi/asm/errno.h b/arch/sparc/inclu=
de/uapi/asm/errno.h
> > > > index 4a41e7835fd5..71940ec9130b 100644
> > > > --- a/arch/sparc/include/uapi/asm/errno.h
> > > > +++ b/arch/sparc/include/uapi/asm/errno.h
> > > > @@ -117,4 +117,6 @@
> > > >
> > > >  #define EHWPOISON    135     /* Memory page has hardware error */
> > > >
> > > > +#define EFTYPE               136     /* Wrong file type for the in=
tended operation */
> > > > +
> > > >  #endif
> > > > diff --git a/arch/sparc/include/uapi/asm/fcntl.h b/arch/sparc/inclu=
de/uapi/asm/fcntl.h
> > > > index 67dae75e5274..bb6e9fa94bc9 100644
> > > > --- a/arch/sparc/include/uapi/asm/fcntl.h
> > > > +++ b/arch/sparc/include/uapi/asm/fcntl.h
> > > > @@ -37,6 +37,7 @@
> > > >
> > > >  #define O_PATH               0x1000000
> > > >  #define __O_TMPFILE  0x2000000
> > > > +#define OPENAT2_REGULAR      0x4000000
> > > >
> > > >  #define F_GETOWN     5       /*  for sockets. */
> > > >  #define F_SETOWN     6       /*  for sockets. */
> > > > diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> > > > index 66bbf6d517a9..6d8d4c7765e6 100644
> > > > --- a/fs/ceph/file.c
> > > > +++ b/fs/ceph/file.c
> > > > @@ -977,6 +977,10 @@ int ceph_atomic_open(struct inode *dir, struct=
 dentry *dentry,
> > > >                       ceph_init_inode_acls(newino, &as_ctx);
> > > >                       file->f_mode |=3D FMODE_CREATED;
> > > >               }
> > > > +             if ((flags & OPENAT2_REGULAR) && !d_is_reg(dentry)) {
> > > > +                     err =3D -EFTYPE;
> > > > +                     goto out_req;
> > > > +             }
> > >
> > > ^^^
> > > This doesn't look quite right. Here's a larger chunk of the code:
> > >
> > > -------------------------8<--------------------------
> > >         if (d_in_lookup(dentry)) {
> > >                 dn =3D ceph_finish_lookup(req, dentry, err);
> > >                 if (IS_ERR(dn))
> > >                         err =3D PTR_ERR(dn);
> > >         } else {
> > >                 /* we were given a hashed negative dentry */
> > >                 dn =3D NULL;
> > >         }
> > >         if (err)
> > >                 goto out_req;
> > >         if (dn || d_really_is_negative(dentry) || d_is_symlink(dentry=
)) {
> > >                 /* make vfs retry on splice, ENOENT, or symlink */
> > >                 doutc(cl, "finish_no_open on dn %p\n", dn);
> > >                 err =3D finish_no_open(file, dn);
> > >         } else {
> > >                 if (IS_ENCRYPTED(dir) &&
> > >                     !fscrypt_has_permitted_context(dir, d_inode(dentr=
y))) {
> > >                         pr_warn_client(cl,
> > >                                 "Inconsistent encryption context (par=
ent %llx:%llx child %llx:%llx)\n",
> > >                                 ceph_vinop(dir), ceph_vinop(d_inode(d=
entry)));
> > >                         goto out_req;
> > >                 }
> > >
> > >                 doutc(cl, "finish_open on dn %p\n", dn);
> > >                 if (req->r_op =3D=3D CEPH_MDS_OP_CREATE && req->r_rep=
ly_info.has_create_ino) {
> > >                         struct inode *newino =3D d_inode(dentry);
> > >
> > >                         cache_file_layout(dir, newino);
> > >                         ceph_init_inode_acls(newino, &as_ctx);
> > >                         file->f_mode |=3D FMODE_CREATED;
> > >                 }
> > >                 err =3D finish_open(file, dentry, ceph_open);
> > >         }
> > > -------------------------8<--------------------------
> > >
> > > It looks like this won't handle it correctly if the pathwalk terminat=
es
> > > on a symlink (re: d_is_symlink() case). You should either set up a te=
st
> > > ceph cluster on your own, or reach out to the ceph community and ask
> > > them to test this.
> > >
> >
> > Thanks for reviewing. The d_is_symlink() case seems to be calling
> > finish_no_open so shouldn't this be okay?
> >
>
> My mistake -- you're correct. I keep forgetting that finish_no_open()
> will handle this case regardless of what else happens.
>
> > > >               err =3D finish_open(file, dentry, ceph_open);
> > > >       }
> > > >  out_req:
> > > > diff --git a/fs/fcntl.c b/fs/fcntl.c
> > > > index beab8080badf..240bb511557a 100644
> > > > --- a/fs/fcntl.c
> > > > +++ b/fs/fcntl.c
> > > > @@ -1169,9 +1169,9 @@ static int __init fcntl_init(void)
> > > >        * Exceptions: O_NONBLOCK is a two bit define on parisc; O_ND=
ELAY
> > > >        * is defined as O_NONBLOCK on some platforms and not on othe=
rs.
> > > >        */
> > > > -     BUILD_BUG_ON(20 - 1 /* for O_RDONLY being 0 */ !=3D
> > > > +     BUILD_BUG_ON(21 - 1 /* for O_RDONLY being 0 */ !=3D
> > > >               HWEIGHT32(
> > > > -                     (VALID_OPEN_FLAGS & ~(O_NONBLOCK | O_NDELAY))=
 |
> > > > +                     (VALID_OPENAT2_FLAGS & ~(O_NONBLOCK | O_NDELA=
Y)) |
> > > >                       __FMODE_EXEC));
> > > >
> > > >       fasync_cache =3D kmem_cache_create("fasync_cache",
> > > > diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
> > > > index 8344040ecaf7..4604e2e8a9cc 100644
> > > > --- a/fs/gfs2/inode.c
> > > > +++ b/fs/gfs2/inode.c
> > > > @@ -738,6 +738,12 @@ static int gfs2_create_inode(struct inode *dir=
, struct dentry *dentry,
> > > >       inode =3D gfs2_dir_search(dir, &dentry->d_name, !S_ISREG(mode=
) || excl);
> > > >       error =3D PTR_ERR(inode);
> > > >       if (!IS_ERR(inode)) {
> > > > +             if (file && (file->f_flags & OPENAT2_REGULAR) && !S_I=
SREG(inode->i_mode)) {
> > >
> > > Isn't OPENAT2_REGULAR getting masked off in ->f_flags now?
> > >
> > Yes, I thought the masking off was happening after this codepath got
> > executed. Maybe it's better anyway to pass another flags param to this
> > function and forward the flags from the gfs2_atomic_open function and
> > in other call sites pass 0 ? What do you think?
> >
>
> Also my mistake. That happens in do_dentry_open() which happens in
> finish_open(), so you should be OK here.
>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>

Thanks for patiently reviewing this! I am planning on sending patches
for man-pages and looking into some xfs-tests for this. But I am not
sure if this patch series will get more reviews from others or if it
will be picked up in the vfs branch?

Regards,
Dorjoy

