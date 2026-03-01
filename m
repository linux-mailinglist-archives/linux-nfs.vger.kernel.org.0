Return-Path: <linux-nfs+bounces-19471-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJacF21KpGkIcwUAu9opvQ
	(envelope-from <linux-nfs+bounces-19471-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 01 Mar 2026 15:17:17 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E401D02A2
	for <lists+linux-nfs@lfdr.de>; Sun, 01 Mar 2026 15:17:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 27A28300A307
	for <lists+linux-nfs@lfdr.de>; Sun,  1 Mar 2026 14:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19655322C73;
	Sun,  1 Mar 2026 14:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NZS8Mugp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E5632F75A
	for <linux-nfs@vger.kernel.org>; Sun,  1 Mar 2026 14:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772374634; cv=pass; b=V/TCrQUBb7XtRaZHW6Bny/y6/0hZjVWf6f7oaEI3SCHh5eFspDcO29eiUpzojfDvIqeIRp/41uiVodPQ/TUECVOWGHDUYVmdlfaKt+hGQW/zq3L4GEHQqp5m4wMwtYP4WCnpjOSE1+24ijDfd0OTDyo1PILFF0mFwox6N1qBOx0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772374634; c=relaxed/simple;
	bh=SMxg0/OH4xIlvKgwlrN+FwO3idaXn0crhP3eBKT/aqU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=etUcgMqTgb3Ugp8aByaEjkjNnty7OCRNUhD60lYwjt1E4aQ6sUZXWh3OTRRTUE9LhdF08DXwEgBQqSeEwwOqT0hBhuzTn1naq0MbNSaPssD5DJUFX/p1t+RA/ABMrXmN6u6kfhixIYyXGeBUjn+4xYZEeRbNXFtuVaGK78coqh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NZS8Mugp; arc=pass smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-94ddffda372so3298154241.1
        for <linux-nfs@vger.kernel.org>; Sun, 01 Mar 2026 06:17:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772374630; cv=none;
        d=google.com; s=arc-20240605;
        b=I5WtlKoPXUxr0LLGTQ/j/Mz/CUEXgDbMBSfvSgMQy4dAwuJo1nOM099gZsD6dyArlh
         iqkY0UuBvLuYSNaCPtBi4iDf/wtzOG2okbeQA7vp9j8ch4oU94RPWlREZ/MMbqKACkOR
         iE2ip5faiBSp4V05eehaIZ5hFe/CvsRp9JIEoz4Z3JgzPM6EitnohPI4RYqZJ0VbVAHU
         CjSodpJDUHQomSy2yquECPZSNH0a9/FIP7fGQgvfH623I3cUFSPQTwdHipAMJBn49RAg
         TwKyZla/gCf+BKdJ3GjnV09pMV8aHPmRiiDCvXONStgvKWCWAqavbW1NU6QA8BTiiBCG
         Mgrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=k8DjN1Dp2Dm3QRgl9BDPBcYHbhPl37cA0CZoGf3m+KA=;
        fh=c/635EzA8ndXQG12t5i/J2tkat1ZwS6AcZldEUQcjAY=;
        b=Dhdtj+2x1a1inrT3hGW9xfB9gd6BSu1vvYWBdXM0sEnOpQP5S2ma6uWErT9TV0mHab
         xFQLhEmrlt+bIc71YV7kr7gCz9QzIuqk3puDv2y5Dq4WebcpO+2iqOe7LEabIZtoIT3B
         j+xA3HGZyix6iOeD/ZCJCwWAGPuNXeAzSJ49sDKy1Z0wvXpVuoaR7yMb9T1gn6LMwKDe
         yqr5UdrEthwsZASCClQxZIwxH0LYjlJGXTfWWmTtGSQ4hzeyC90rOHv9/zBT6Fd7bo0B
         zztwsYI21IdHSoCMYjjnUEj9vXPqtLEcthYDxuWZ9CLnPIkqlELfDkFjwHEvj4BX5c0f
         jE1Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772374630; x=1772979430; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k8DjN1Dp2Dm3QRgl9BDPBcYHbhPl37cA0CZoGf3m+KA=;
        b=NZS8MugptPFY9pO1nC6vPdiCxnLR7X0KD2n7NPVC938SYVkNo9O4dCaGISthfTXLto
         vXCro1BpNzhK4PKm68y65oktTFzEJehIbFroTyFb751ACYDTY9La6HqRJFG547RtxM4K
         Ig/I8594Fy32eS1WgRe6cnyppA9kixLymPKg9ys+phq4qOflKDmPlsPQ2OcLrW3pz1Vj
         kIdp41RMHSEADS/yf7UsH11nDpqZJZN91BMIP9TDULiDgUufwzSQ1L1BrAjK6d5bn/j5
         f1JMXjBw+USqnXbbSF5LclySd4yIoPs0LbGZaPDF8B7uQfp78JVrKzbzZjrtlMbh+qgC
         2ozw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772374630; x=1772979430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k8DjN1Dp2Dm3QRgl9BDPBcYHbhPl37cA0CZoGf3m+KA=;
        b=JmM+cIbiHcptGW1Dh5UHhPiNEpsmEmDOyPBeo/3HkjFSxHddE7XQ1MYpHKF2/ACQNd
         hj3cwGHIoIedHDOTgp8pEdWRJYEhr4nDZjluINLOPV96hWrJ1Pi2CKhE1MV3xiBJkjIC
         /hUzFwi0vqfYKk6v/SN3vT9ukhQjE9nibJqCTxbTNEcKrX+dzEUyEFF0pDLkUeOILkcM
         8gxIhLHzh1cxUrJjfnNHjude9HJQEZoYT/xCsj4Ql2PGkhcxHrWZ74aXsyGiq5dnaA6K
         x//NlYiTtR+Nddwq2IGMbvnIkuf78XsiieG/le4YpsIh7Dgo0G9xLtSOmYTvAyIWwJ+i
         R2wQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvZIElswVJVxaYBV3kb626FzC3eUe0v+fGAA4UAMfbPvkW6jQHkHlU/zsvKx35/qhYkNyxPN9SJMM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgKOkvT+yCDxyETmG7AIM1osg+mh7bAog3z994mT11QmMzedkc
	esZoZkBeL+DO+kRWGwa2tfdKrf+hJDrcXWnT5kXEdMQNlXaCXt+fmNdJkSoZusiRO9B4uwRgnCm
	uCJwetzQZOpNRyykFOwpf4oijwivsr4I=
X-Gm-Gg: ATEYQzzmxQeFQdMA/sxDnz/wGAeMApKMdUAWv5/XwcYzQYhwcjKvOxqbm/opVOxvYE0
	0AmR1nhMfRV0HphjmT5wueB3IuIFNgAyXEaDF6E3CMsgxDZ5j2hv0kCfNWQbdLaacGymLYci2As
	3AYBQFuXHksXRiXN/5wpx21KjMS+JQD756uyfDMAepdkk/nchk6/hy6AAc1Coii47tp33Ytta9F
	rH0cXZUr2S0EfW3vvKM2NG2C7AONln4VnIjF+so4OGYs0rTf9AEe44wXRRtnx1RkQZjEogokvtd
	/k/aVe84BXClc1VD2V/1GsTufxmKQF6wDGsFXsyS7AvzV65FGZv8
X-Received: by 2002:a05:6102:2ad0:b0:5db:d36c:89d4 with SMTP id
 ada2fe7eead31-5ff33481927mr4431039137.3.1772374630288; Sun, 01 Mar 2026
 06:17:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260221145915.81749-1-dorjoychy111@gmail.com>
 <20260221145915.81749-2-dorjoychy111@gmail.com> <2f430eb613d4f6f6564f83d06f802ff47adea230.camel@kernel.org>
In-Reply-To: <2f430eb613d4f6f6564f83d06f802ff47adea230.camel@kernel.org>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Sun, 1 Mar 2026 20:16:59 +0600
X-Gm-Features: AaiRm523Vu6ZFdfEO8O_fCfURMW-nzweMn1jJ9AAv3XTYzZCngEPlvc0eYJc-g0
Message-ID: <CAFfO_h7i86qdKZObdFpWd8Mh+8VXVMFYoGgYBgzomzhGJJFnEQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] openat2: new OPENAT2_REGULAR flag support
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ceph-devel@vger.kernel.org, gfs2@lists.linux.dev, linux-nfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, v9fs@lists.linux.dev, 
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19471-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[41];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,gmail.com,arndb.de,dilger.ca,linaro.org,alpha.franken.de,hansenpartnership.com,gmx.de,davemloft.net,gaisler.com,redhat.com,dubeyko.com,samba.org,manguebit.org,microsoft.com,talpey.com,szeredi.hu];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dorjoychy111@gmail.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid]
X-Rspamd-Queue-Id: F3E401D02A2
X-Rspamd-Action: no action

On Sun, Mar 1, 2026 at 6:44=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wro=
te:
>
> On Sat, 2026-02-21 at 20:45 +0600, Dorjoy Chowdhury wrote:
> > This flag indicates the path should be opened if it's a regular file.
> > This is useful to write secure programs that want to avoid being
> > tricked into opening device nodes with special semantics while thinking
> > they operate on regular files. This is a requested feature from the
> > uapi-group[1].
> >
> > A corresponding error code EFTYPE has been introduced. For example, if
> > openat2 is called on path /dev/null with OPENAT2_REGULAR in the flag
> > param, it will return -EFTYPE.
> >
> > When used in combination with O_CREAT, either the regular file is
> > created, or if the path already exists, it is opened if it's a regular
> > file. Otherwise, -EFTYPE is returned.
> >
>
> It would be good to mention that EFTYPE has precedent in BSD/Darwin.
> When an error code is already supported in another UNIX-y OS, then it
> bolsters the case for adding it here.
>

Good suggestion. Yes, I can include this information in the commit
message during the next posting.

> Your cover letter mentions that you only tested this on btrfs. At the
> very least, you should test NFS and SMB. It should be fairly easy to
> set up mounts over loopback for those cases.
>

I used virtme-ng (which I think reuses the host's filesystem) to run
the compiled bzImage and ran the openat2 kselftests there to verify
it's working. Is there a similar way I can test NFS/SMB by adding
kselftests? Or would I need to setup NFS/SMB inside a full VM distro
with a modified kernel to test this? I would appreciate any suggestion
on this.

> There are some places where it doesn't seem like -EFTYPE will be
> returned. It looks like it can send back -EISDIR and -ENOTDIR in some
> cases as well. With a new API like this, I think we ought to strive for
> consistency.
>

Good point. There was a comment in a previous posting of this patch
series "The most useful behavior would indicate what was found (e.g.,
a pipe)."
(ref: https://lore.kernel.org/linux-fsdevel/vhq3osjqs3nn764wrp2lxp66b4dxpb3=
n5x3dijhe2yr53qfgy3@tfswbjskc3y6/
)
So I thought maybe it would be useful to return -EISDIR where it was
already doing that. But it is a good point about consistency that we
won't be doing this for other different types so I guess it's better
to return -EFTYPE for all the cases anyway as you mention. Any
thoughts?


> Should this API return -EFTYPE for all cases where it's not S_IFREG? If
> not, then what other errors are allowed? Bear in mind that you'll need
> to document this in the manpages too.
>

Are the manpages in the kernel git repository or in a separate
repository? Do I make separate patch series for that? Sorry I don't
know about this in detail.

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
> >  fs/gfs2/inode.c                            |  2 ++
> >  fs/namei.c                                 |  4 ++++
> >  fs/nfs/dir.c                               |  4 +++-
> >  fs/open.c                                  |  4 +++-
> >  fs/smb/client/dir.c                        | 11 ++++++++++-
> >  include/linux/fcntl.h                      |  2 ++
> >  include/uapi/asm-generic/errno.h           |  2 ++
> >  include/uapi/asm-generic/fcntl.h           |  4 ++++
> >  tools/arch/alpha/include/uapi/asm/errno.h  |  2 ++
> >  tools/arch/mips/include/uapi/asm/errno.h   |  2 ++
> >  tools/arch/parisc/include/uapi/asm/errno.h |  2 ++
> >  tools/arch/sparc/include/uapi/asm/errno.h  |  2 ++
> >  tools/include/uapi/asm-generic/errno.h     |  2 ++
> >  21 files changed, 55 insertions(+), 3 deletions(-)
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
> > index 31b691b2aea2..0a4220f72ada 100644
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
> >               err =3D finish_open(file, dentry, ceph_open);
> >       }
> >  out_req:
> > diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
> > index 8344040ecaf7..0dc3e4240d9e 100644
> > --- a/fs/gfs2/inode.c
> > +++ b/fs/gfs2/inode.c
> > @@ -749,6 +749,8 @@ static int gfs2_create_inode(struct inode *dir, str=
uct dentry *dentry,
> >               if (file) {
> >                       if (S_ISREG(inode->i_mode))
> >                               error =3D finish_open(file, dentry, gfs2_=
open_common);
> > +                     else if (file->f_flags & OPENAT2_REGULAR)
> > +                             error =3D -EFTYPE;
> >                       else
> >                               error =3D finish_no_open(file, NULL);
> >               }
> > diff --git a/fs/namei.c b/fs/namei.c
> > index 5fe6cac48df8..aa5fb2672881 100644
> > --- a/fs/namei.c
> > +++ b/fs/namei.c
> > @@ -4651,6 +4651,10 @@ static int do_open(struct nameidata *nd,
> >               if (unlikely(error))
> >                       return error;
> >       }
> > +
> > +     if ((open_flag & OPENAT2_REGULAR) && !d_is_reg(nd->path.dentry))
> > +             return -EFTYPE;
> > +
> >       if ((nd->flags & LOOKUP_DIRECTORY) && !d_can_lookup(nd->path.dent=
ry))
> >               return -ENOTDIR;
> >
> > diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
> > index b3f5c9461204..ef61db67d06e 100644
> > --- a/fs/nfs/dir.c
> > +++ b/fs/nfs/dir.c
> > @@ -2195,7 +2195,9 @@ int nfs_atomic_open(struct inode *dir, struct den=
try *dentry,
> >                       break;
> >               case -EISDIR:
> >               case -ENOTDIR:
> > -                     goto no_open;
> > +                     if (!(open_flags & OPENAT2_REGULAR))
> > +                             goto no_open;
> > +                     break;
>
> Shouldn't this also set the error to -EFTYPE?
>
> >               case -ELOOP:
> >                       if (!(open_flags & O_NOFOLLOW))
> >                               goto no_open;
> > diff --git a/fs/open.c b/fs/open.c
> > index 91f1139591ab..1524f52a1773 100644
> > --- a/fs/open.c
> > +++ b/fs/open.c
> > @@ -1198,7 +1198,7 @@ inline int build_open_flags(const struct open_how=
 *how, struct open_flags *op)
> >        * values before calling build_open_flags(), but openat2(2) check=
s all
> >        * of its arguments.
> >        */
> > -     if (flags & ~VALID_OPEN_FLAGS)
> > +     if (flags & ~VALID_OPENAT2_FLAGS)
> >               return -EINVAL;
> >       if (how->resolve & ~VALID_RESOLVE_FLAGS)
> >               return -EINVAL;
> > @@ -1237,6 +1237,8 @@ inline int build_open_flags(const struct open_how=
 *how, struct open_flags *op)
> >                       return -EINVAL;
> >               if (!(acc_mode & MAY_WRITE))
> >                       return -EINVAL;
> > +     } else if ((flags & O_DIRECTORY) && (flags & OPENAT2_REGULAR)) {
> > +             return -EINVAL;
> >       }
> >       if (flags & O_PATH) {
> >               /* O_PATH only permits certain other flags to be set. */
> > diff --git a/fs/smb/client/dir.c b/fs/smb/client/dir.c
> > index cb10088197d2..d12ed0c87599 100644
> > --- a/fs/smb/client/dir.c
> > +++ b/fs/smb/client/dir.c
> > @@ -236,6 +236,11 @@ static int cifs_do_create(struct inode *inode, str=
uct dentry *direntry, unsigned
> >                                * lookup.
> >                                */
> >                               CIFSSMBClose(xid, tcon, fid->netfid);
> > +                             if (oflags & OPENAT2_REGULAR) {
> > +                                     iput(newinode);
> > +                                     rc =3D -EFTYPE;
> > +                                     goto out;
> > +                             }
> >                               goto cifs_create_get_file_info;
> >                       }
> >                       /* success, no need to query */
> > @@ -433,11 +438,15 @@ static int cifs_do_create(struct inode *inode, st=
ruct dentry *direntry, unsigned
> >               goto out_err;
> >       }
> >
> > -     if (newinode)
> > +     if (newinode) {
> >               if (S_ISDIR(newinode->i_mode)) {
> >                       rc =3D -EISDIR;
> >                       goto out_err;
>
> This logic doesn't look quite right. If you do a create and race with a
> directory create, then it looks like you'll send back -EISDIR here
> instead of -EFTYPE?
>

Yes, I thought it would be useful for the caller to know what type of
file it actually is so I had kept this the same. Let me know if it is
preferable to return -EFTYPE always.

Thanks for reviewing!

Regards,
Dorjoy

