Return-Path: <linux-nfs+bounces-20536-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uOPDGM2VymkR+QUAu9opvQ
	(envelope-from <linux-nfs+bounces-20536-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Mar 2026 17:25:01 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1977935DC4C
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Mar 2026 17:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 33827301D959
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Mar 2026 15:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 052CF336EDA;
	Mon, 30 Mar 2026 15:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UDVvAeY8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978B13385AA
	for <linux-nfs@vger.kernel.org>; Mon, 30 Mar 2026 15:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774883260; cv=pass; b=AOpRIofdt8+d4QZqv3dGwhOgxc5HBHEFI/2ySOg11g3kS59v/yB00g3rn1ZeaQvGrysOt9KxQR8KGCDPqm6oqsZckj8uFaoTO82fC7muYuWopujtUbwHir+Y3qBJvzIX07tpgAR+eRDxFlbqHXSOsZGIdc9cS2nCeMgcJbRY5OU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774883260; c=relaxed/simple;
	bh=/x13DKtZaVDG7yiVUGXh9eKmBd78HM6nIK9Tv56z6jQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p1WwhGdsFHqE+3lKjjFqVMKkKvFc55ja7J0PnWsZX+ucpDeeM2HmirnC4hkefCNEoKZbylA8Fi8STWcw/MfYKMkQDTefPhJvQtrwxU6urJcNsESmoQKrlqVRP7Q75mNht9JJcZuTA9V6iy3mulFi41/w8oQ/2TD7dkO/UBVvnqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UDVvAeY8; arc=pass smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-94ab69af6c8so3645778241.0
        for <linux-nfs@vger.kernel.org>; Mon, 30 Mar 2026 08:07:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774883257; cv=none;
        d=google.com; s=arc-20240605;
        b=SY8wPmVtUzmNVl3MOys3DNgTE27L6NApV/f4l4bY6a2FyuWYWs1+afIt5gBydYizfH
         tPwtdXbJDS/QhmZz7535FV1a6wf8Hb05HhxMCmd+6+aTm/CnLn1n38ScqoQdQPMSMgDH
         uaPgf4H6NIs7HicM8+7k/fUes9/ui5mebFoETyT1LGLVAqMlZNchWgysNp9ey0PFuCE1
         ZEkl+gWh3s972p7ZXMDtnl/X57U+dx/ESVYeAXt3ggo8Db4Gi1sQzalCBO4Ca3tZB5SS
         HnOrdHF/R8hl/WmKUmdCdR+cEMVr8tahaLLcZDQK5gi8/6GkeGso0j7gIfPwjIfZpTt6
         UIFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=i27yBCASimAbh8aqvQTLYNbe/ak/AL7sQPeMVmtc+JI=;
        fh=GYHCi2LsinNX1lIWbFvVXqAe8p2WexXKPKvM7SKeiZg=;
        b=aNVNCZnDv4710aLvDUOEELxbb/TdvNQNRDPKYdD5JY3GH2sKjquSKfwkAz2eezQL5I
         QrJ82nn25PswvJj6oYlJCpD1lFhIIl7jqcrzNBIr27fm/KvL0RCHyJaa3rgEsU/+eCGC
         ZFN5aDdpgZZlkrt2rpnw5/GTuzYxIZRhCSXiS3xGG7cxNlyGKd8pZmdPL9nURYpDQJmc
         rEmxYuYMNu8EZ6I/b882VMU4G+OcRuee/cspm5OgqhzpOxbF6qt5qEwGk3qJ1bVodz3y
         GTlldak+sA/An4YuUl9tstLfTtY1w2MniIfhjc8GWYtrq928MwfHvMCWUxntY0Yedd+X
         o4Ww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774883257; x=1775488057; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i27yBCASimAbh8aqvQTLYNbe/ak/AL7sQPeMVmtc+JI=;
        b=UDVvAeY8m5wlbQOXPTgFfY11Cx7Haf5wzVUmS9lx2Eq6W3kP+ITkzBB9ePKeOWRF71
         msdtytfI1S9rJ2obJVxx1TjFFj0AJkNDgnSxBqhC1+RHEaywuaEhQPQmYJDGeRUoTc7K
         i2Pr07RnKRDwbY8Sk5aLQfmAKPtwMeY+90ZIq8YRRH1MkuhbEfjjJ2Kpp9okh7mInPpP
         CuyUPk9vskQajhxEPcHWLREXJyMf4O52s9Nnkc1mgAr94HBZu65LLXDRv6G/VNFYiCnW
         i13tFwiTAbVtn8NcPYwW1+NftkS64fkgc/zCH4YMAZ1kr6EjzEwb+TQP7crgO0uR+iug
         HLsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774883257; x=1775488057;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i27yBCASimAbh8aqvQTLYNbe/ak/AL7sQPeMVmtc+JI=;
        b=CtdzRe3L013sGSypDVCIe8cu85ZqkafS3bQnXSFJhFxsbQKj7myguVzO+ccxfMBKKo
         onlvYNjuTFB4NExz8teQa0f0jEEbGKAbXhu9Hwi2VjsIa8Bz6Z3rUAf2vxvvGiXkaRj5
         01c61BZc3BzR3VcG79+aUpcc6oJDPeQXM+TQ8T/Qytyy4OGygygqJrJ1KQWn/o3bXXzK
         b8g2Opp0G3KtOZvlZrefRZMTtinPm6+4KjhLutYTBwkcDPSYiQoOjWsloT8Qi3qJs6P0
         SrIYlSaOha40NqzZrmanOr9klvUJ8c/8GoUD8uxtDzL20uiCThmIY09i+L/EZ5wuS6VS
         1hDw==
X-Forwarded-Encrypted: i=1; AJvYcCWqu6NhM7cTAjuPRzPlh4+NCFVErwdf8BnnOGPMxO/zANLmjB6srjVTXbX486vu24mX31mJw0YWvk0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUsoktLjaT/dlXBcXhEx6E8ro47mmKk3Y/EPdf/6yI6/jhh2Jp
	SmHX4n2q5XJ/AWAMioxwHBvLXjH38CSLXy2GsUaGnuzdr5HO2LP+Mw+zsuLCP8BlA0wShVgZ+Dm
	LfAcON5AFjtMf44sA7jsjkMB7cDR+5po=
X-Gm-Gg: ATEYQzxLOnWVb1czA0YSFokejqf6KdsIyoHWXd+X7/0gkCrXSwk11wgeFEoLVD6/KdM
	q+DuqQnFVpiUmrcn20/W1m3r4yKLfcLmrIWLD7D7Ep45UMfMrO8yBUtcpKWi9i+SD0dV6XKB19t
	JeZSWnNzxojPkeuPrEDY/vsTYgOmCYGWCUhSn1Ip+SFewBgePqtlF2UmNF/1JyaUxNlLg0Aa25m
	qgNQA6yCIT0gWde/iD7NkFGFOlms5+Ck94XGOjXcbTAB9MN2QV9xY+U9wIdvXGmUc5QEsDJmC02
	DI10esWPDs5XQT/El1/ptSo+gd5ZA5CUu4mN3QNHaC0=
X-Received: by 2002:a05:6102:84d1:b0:602:6ccd:7772 with SMTP id
 ada2fe7eead31-604fbdd4504mr3414117137.2.1774883257420; Mon, 30 Mar 2026
 08:07:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260328172314.45807-1-dorjoychy111@gmail.com>
 <20260328172314.45807-2-dorjoychy111@gmail.com> <e526fbdb450a593b575355c1c9ae21f286427275.camel@kernel.org>
In-Reply-To: <e526fbdb450a593b575355c1c9ae21f286427275.camel@kernel.org>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Mon, 30 Mar 2026 21:07:25 +0600
X-Gm-Features: AQROBzBiNZNQJDXYIA1g_QAQfKVpqrabu4vh65YgUWDTzh1Q_gvpOzHijv8ZYqQ
Message-ID: <CAFfO_h75dF2s83VNtUaNuRmto1NVVcxo7kN6eAtNtN3ME8mPiQ@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20536-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[42];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,gmail.com,arndb.de,dilger.ca,linaro.org,alpha.franken.de,hansenpartnership.com,gmx.de,davemloft.net,gaisler.com,redhat.com,dubeyko.com,samba.org,manguebit.org,microsoft.com,talpey.com,szeredi.hu];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dorjoychy111@gmail.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,uapi-group.org:url,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 1977935DC4C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 30, 2026 at 5:49=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> On Sat, 2026-03-28 at 23:22 +0600, Dorjoy Chowdhury wrote:
> > This flag indicates the path should be opened if it's a regular file.
> > This is useful to write secure programs that want to avoid being
> > tricked into opening device nodes with special semantics while thinking
> > they operate on regular files. This is a requested feature from the
> > uapi-group[1].
> >
> > A corresponding error code EFTYPE has been introduced. For example, if
> > openat2 is called on path /dev/null with OPENAT2_REGULAR in the flag
> > param, it will return -EFTYPE. EFTYPE is already used in BSD systems
> > like FreeBSD, macOS.
> >
> > When used in combination with O_CREAT, either the regular file is
> > created, or if the path already exists, it is opened if it's a regular
> > file. Otherwise, -EFTYPE is returned.
> >
> > When OPENAT2_REGULAR is combined with O_DIRECTORY, -EINVAL is returned
> > as it doesn't make sense to open a path that is both a directory and a
> > regular file.
> >
> > [1]: https://uapi-group.org/kernel-features/#ability-to-only-open-regul=
ar-files
> >
> > Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
> > ---
> >  arch/alpha/include/uapi/asm/errno.h        |  2 ++
> >  arch/alpha/include/uapi/asm/fcntl.h        |  1 +
> >  arch/mips/include/uapi/asm/errno.h         |  2 ++
> >  arch/parisc/include/uapi/asm/errno.h       |  2 ++
> >  arch/parisc/include/uapi/asm/fcntl.h       |  1 +
> >  arch/sparc/include/uapi/asm/errno.h        |  2 ++
> >  arch/sparc/include/uapi/asm/fcntl.h        |  1 +
> >  fs/ceph/file.c                             |  4 ++++
> >  fs/fcntl.c                                 |  4 ++--
> >  fs/gfs2/inode.c                            |  6 ++++++
> >  fs/namei.c                                 |  4 ++++
> >  fs/nfs/dir.c                               |  4 ++++
> >  fs/open.c                                  |  8 +++++---
> >  fs/smb/client/dir.c                        | 14 +++++++++++++-
> >  include/linux/fcntl.h                      |  2 ++
> >  include/uapi/asm-generic/errno.h           |  2 ++
> >  include/uapi/asm-generic/fcntl.h           |  4 ++++
> >  tools/arch/alpha/include/uapi/asm/errno.h  |  2 ++
> >  tools/arch/mips/include/uapi/asm/errno.h   |  2 ++
> >  tools/arch/parisc/include/uapi/asm/errno.h |  2 ++
> >  tools/arch/sparc/include/uapi/asm/errno.h  |  2 ++
> >  tools/include/uapi/asm-generic/errno.h     |  2 ++
> >  22 files changed, 67 insertions(+), 6 deletions(-)
> >
> > diff --git a/arch/alpha/include/uapi/asm/errno.h b/arch/alpha/include/u=
api/asm/errno.h
> > index 6791f6508632..1a99f38813c7 100644
> > --- a/arch/alpha/include/uapi/asm/errno.h
> > +++ b/arch/alpha/include/uapi/asm/errno.h
> > @@ -127,4 +127,6 @@
> >
> >  #define EHWPOISON    139     /* Memory page has hardware error */
> >
> > +#define EFTYPE               140     /* Wrong file type for the intend=
ed operation */
> > +
> >  #endif
> > diff --git a/arch/alpha/include/uapi/asm/fcntl.h b/arch/alpha/include/u=
api/asm/fcntl.h
> > index 50bdc8e8a271..fe488bf7c18e 100644
> > --- a/arch/alpha/include/uapi/asm/fcntl.h
> > +++ b/arch/alpha/include/uapi/asm/fcntl.h
> > @@ -34,6 +34,7 @@
> >
> >  #define O_PATH               040000000
> >  #define __O_TMPFILE  0100000000
> > +#define OPENAT2_REGULAR      0200000000
> >
> >  #define F_GETLK              7
> >  #define F_SETLK              8
> > diff --git a/arch/mips/include/uapi/asm/errno.h b/arch/mips/include/uap=
i/asm/errno.h
> > index c01ed91b1ef4..1835a50b69ce 100644
> > --- a/arch/mips/include/uapi/asm/errno.h
> > +++ b/arch/mips/include/uapi/asm/errno.h
> > @@ -126,6 +126,8 @@
> >
> >  #define EHWPOISON    168     /* Memory page has hardware error */
> >
> > +#define EFTYPE               169     /* Wrong file type for the intend=
ed operation */
> > +
> >  #define EDQUOT               1133    /* Quota exceeded */
> >
> >
> > diff --git a/arch/parisc/include/uapi/asm/errno.h b/arch/parisc/include=
/uapi/asm/errno.h
> > index 8cbc07c1903e..93194fbb0a80 100644
> > --- a/arch/parisc/include/uapi/asm/errno.h
> > +++ b/arch/parisc/include/uapi/asm/errno.h
> > @@ -124,4 +124,6 @@
> >
> >  #define EHWPOISON    257     /* Memory page has hardware error */
> >
> > +#define EFTYPE               258     /* Wrong file type for the intend=
ed operation */
> > +
> >  #endif
> > diff --git a/arch/parisc/include/uapi/asm/fcntl.h b/arch/parisc/include=
/uapi/asm/fcntl.h
> > index 03dee816cb13..d46812f2f0f4 100644
> > --- a/arch/parisc/include/uapi/asm/fcntl.h
> > +++ b/arch/parisc/include/uapi/asm/fcntl.h
> > @@ -19,6 +19,7 @@
> >
> >  #define O_PATH               020000000
> >  #define __O_TMPFILE  040000000
> > +#define OPENAT2_REGULAR      0100000000
> >
> >  #define F_GETLK64    8
> >  #define F_SETLK64    9
> > diff --git a/arch/sparc/include/uapi/asm/errno.h b/arch/sparc/include/u=
api/asm/errno.h
> > index 4a41e7835fd5..71940ec9130b 100644
> > --- a/arch/sparc/include/uapi/asm/errno.h
> > +++ b/arch/sparc/include/uapi/asm/errno.h
> > @@ -117,4 +117,6 @@
> >
> >  #define EHWPOISON    135     /* Memory page has hardware error */
> >
> > +#define EFTYPE               136     /* Wrong file type for the intend=
ed operation */
> > +
> >  #endif
> > diff --git a/arch/sparc/include/uapi/asm/fcntl.h b/arch/sparc/include/u=
api/asm/fcntl.h
> > index 67dae75e5274..bb6e9fa94bc9 100644
> > --- a/arch/sparc/include/uapi/asm/fcntl.h
> > +++ b/arch/sparc/include/uapi/asm/fcntl.h
> > @@ -37,6 +37,7 @@
> >
> >  #define O_PATH               0x1000000
> >  #define __O_TMPFILE  0x2000000
> > +#define OPENAT2_REGULAR      0x4000000
> >
> >  #define F_GETOWN     5       /*  for sockets. */
> >  #define F_SETOWN     6       /*  for sockets. */
> > diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> > index 66bbf6d517a9..6d8d4c7765e6 100644
> > --- a/fs/ceph/file.c
> > +++ b/fs/ceph/file.c
> > @@ -977,6 +977,10 @@ int ceph_atomic_open(struct inode *dir, struct den=
try *dentry,
> >                       ceph_init_inode_acls(newino, &as_ctx);
> >                       file->f_mode |=3D FMODE_CREATED;
> >               }
> > +             if ((flags & OPENAT2_REGULAR) && !d_is_reg(dentry)) {
> > +                     err =3D -EFTYPE;
> > +                     goto out_req;
> > +             }
>
> ^^^
> This doesn't look quite right. Here's a larger chunk of the code:
>
> -------------------------8<--------------------------
>         if (d_in_lookup(dentry)) {
>                 dn =3D ceph_finish_lookup(req, dentry, err);
>                 if (IS_ERR(dn))
>                         err =3D PTR_ERR(dn);
>         } else {
>                 /* we were given a hashed negative dentry */
>                 dn =3D NULL;
>         }
>         if (err)
>                 goto out_req;
>         if (dn || d_really_is_negative(dentry) || d_is_symlink(dentry)) {
>                 /* make vfs retry on splice, ENOENT, or symlink */
>                 doutc(cl, "finish_no_open on dn %p\n", dn);
>                 err =3D finish_no_open(file, dn);
>         } else {
>                 if (IS_ENCRYPTED(dir) &&
>                     !fscrypt_has_permitted_context(dir, d_inode(dentry)))=
 {
>                         pr_warn_client(cl,
>                                 "Inconsistent encryption context (parent =
%llx:%llx child %llx:%llx)\n",
>                                 ceph_vinop(dir), ceph_vinop(d_inode(dentr=
y)));
>                         goto out_req;
>                 }
>
>                 doutc(cl, "finish_open on dn %p\n", dn);
>                 if (req->r_op =3D=3D CEPH_MDS_OP_CREATE && req->r_reply_i=
nfo.has_create_ino) {
>                         struct inode *newino =3D d_inode(dentry);
>
>                         cache_file_layout(dir, newino);
>                         ceph_init_inode_acls(newino, &as_ctx);
>                         file->f_mode |=3D FMODE_CREATED;
>                 }
>                 err =3D finish_open(file, dentry, ceph_open);
>         }
> -------------------------8<--------------------------
>
> It looks like this won't handle it correctly if the pathwalk terminates
> on a symlink (re: d_is_symlink() case). You should either set up a test
> ceph cluster on your own, or reach out to the ceph community and ask
> them to test this.
>

Thanks for reviewing. The d_is_symlink() case seems to be calling
finish_no_open so shouldn't this be okay?

> >               err =3D finish_open(file, dentry, ceph_open);
> >       }
> >  out_req:
> > diff --git a/fs/fcntl.c b/fs/fcntl.c
> > index beab8080badf..240bb511557a 100644
> > --- a/fs/fcntl.c
> > +++ b/fs/fcntl.c
> > @@ -1169,9 +1169,9 @@ static int __init fcntl_init(void)
> >        * Exceptions: O_NONBLOCK is a two bit define on parisc; O_NDELAY
> >        * is defined as O_NONBLOCK on some platforms and not on others.
> >        */
> > -     BUILD_BUG_ON(20 - 1 /* for O_RDONLY being 0 */ !=3D
> > +     BUILD_BUG_ON(21 - 1 /* for O_RDONLY being 0 */ !=3D
> >               HWEIGHT32(
> > -                     (VALID_OPEN_FLAGS & ~(O_NONBLOCK | O_NDELAY)) |
> > +                     (VALID_OPENAT2_FLAGS & ~(O_NONBLOCK | O_NDELAY)) =
|
> >                       __FMODE_EXEC));
> >
> >       fasync_cache =3D kmem_cache_create("fasync_cache",
> > diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
> > index 8344040ecaf7..4604e2e8a9cc 100644
> > --- a/fs/gfs2/inode.c
> > +++ b/fs/gfs2/inode.c
> > @@ -738,6 +738,12 @@ static int gfs2_create_inode(struct inode *dir, st=
ruct dentry *dentry,
> >       inode =3D gfs2_dir_search(dir, &dentry->d_name, !S_ISREG(mode) ||=
 excl);
> >       error =3D PTR_ERR(inode);
> >       if (!IS_ERR(inode)) {
> > +             if (file && (file->f_flags & OPENAT2_REGULAR) && !S_ISREG=
(inode->i_mode)) {
>
> Isn't OPENAT2_REGULAR getting masked off in ->f_flags now?
>
Yes, I thought the masking off was happening after this codepath got
executed. Maybe it's better anyway to pass another flags param to this
function and forward the flags from the gfs2_atomic_open function and
in other call sites pass 0 ? What do you think?

Regards,
Dorjoy

