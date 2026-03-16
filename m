Return-Path: <linux-nfs+bounces-20220-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MHMWLa0+uGmpagEAu9opvQ
	(envelope-from <linux-nfs+bounces-20220-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 18:32:29 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C89D29E4F2
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 18:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7ABB131B270A
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 17:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9FA3CFF5C;
	Mon, 16 Mar 2026 17:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HcYmuPi0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894453CF693
	for <linux-nfs@vger.kernel.org>; Mon, 16 Mar 2026 17:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773681764; cv=pass; b=uBI1mj0IaFmpjhON4E8s9fdGPwWKidlDBJRwZFNSAM+UsdyMTVT+C6ySaIKOr2tlUxF0cM8wCxBAGWKIxTm3bZs1ncLvBotEYgyI0RsCQBB1Sb6K1jEj8SrzRtC3lKwaQwfTR/jl6Rhmb+P+GeNVMhmv2PDjS57hcW+jy3tElG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773681764; c=relaxed/simple;
	bh=38YIF2h9LQRciTDudLh6dbVHlCWQ+CVfx4lmwVgz+TQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r4emgaLSmLv2vraSTJnFMb8WQ4+EtDT3jLWM/O3IUNzYo5fyaSfX1S9/pXm+6NDrMB0fiEcvfvUgMNBYCSOnkb67O+U0/yiohD1PyIOpWd2VcKNOJNMBXrpHq2wBO8qDhd0wRnbxZsVzpAvo1OOY3CVif6XxYBJyfUKEHPQl4ok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HcYmuPi0; arc=pass smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-5fff774800cso2874660137.0
        for <linux-nfs@vger.kernel.org>; Mon, 16 Mar 2026 10:22:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773681761; cv=none;
        d=google.com; s=arc-20240605;
        b=hYB2LokxnXESq2mGagGrbkzjRj/vV1PSmT3UG0R3el9XCw0U1iWhPROUOkoo5FTUth
         fISrqITijr+2CgBZ1mltUqO5qxZhYfC7he+i4Wp6VX8vFlwYyNLteN07FrhCjSxDyxPo
         bMjAC2wmO4dxXroRjEQdEXHmZ2r/psuo8uR136o6z/dA7/rAZ6EH/KPNU/xZL417zCBv
         kSfySp3Kc+jgHYzzZtSL2IXEo9TblsRuX97pvemzLc4+2awLMbXSR1GfyA5Y2mrRphvY
         aJby6Tn8w/G6w6fD1SJFPgf926vri34mKobfqQQWX4T++8DYCj7Of3OT7rw2Egm0wEGU
         dMLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=y3DZPi773JGtMdvcTYXrz3SkUkUANIodCa33A4wwy7k=;
        fh=3OmLAqZOaF2NZ79wj/0OeKoiUQ+Wsw5HcTSvuxgdSO4=;
        b=HsLtuMDlwRP8s9oggoTKAf9g8zjrKTb+mf8URw2TTRi6iZSrZdIDXaN0CQXEUujnuD
         9VgKD2YUhm3t2kFWYZnv6otkxuhikyld6I4rxbEaAnI01rn8K68qFIS1lSgaxqBZHRjO
         hzREJDHNOGbxjEofXrcKDPOdV4Bg06HlQCByjXIULMhLEI//im6Lu/nWiw222wiCuSOX
         KMivmYA68A0+s/DKKcs3di1xqX5apXVdTdSTysLAYm6XLRYlrvMR4MulgXi6ApeRdo8a
         o852FZkhNlX5N6LAsXBuFUIC9dMJdFFmn2Od6fjvWUy4s5tPV0gsgtrF9c88hQ2VeMUc
         LCfg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773681761; x=1774286561; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y3DZPi773JGtMdvcTYXrz3SkUkUANIodCa33A4wwy7k=;
        b=HcYmuPi0X/TZNmyRIOXExfvEHRzD0UyzV54M82kVNgBzzjKlBf7yjuyMETcJ7LusHX
         pr4wvj5PTOWmQLvZr0/nXx+Tqv/O77n+pWvH7woRd/u8jnCj3F1WihYuOO50zXEfUlpo
         P7srtkllUt2jcefTNJ+39OAhm63tB8Y/e4qItfYY80voDNkTai5h05geghQmFWiqCtW0
         lVyCyVhRPKH0p+C+PHpz9DqJJzT9jJr1wPNN1sOcV1X3tMTRY7A+UE4Hvqm+O1+2s7m+
         dinmKniZOJu9i7oMW+aLBtXr11vx6l/tDr23e4AjmBuEk2vF8T8I0ICnInpqLgKzBWYR
         m2dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773681761; x=1774286561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y3DZPi773JGtMdvcTYXrz3SkUkUANIodCa33A4wwy7k=;
        b=pMgl2wcOlJWuSCe5q7L4HbI+RVLq9wN5Uaqpv8HbImB6s6Ks9zytl5JKl1g/AHz+KX
         IBXkd2TWdtYRUMC+ZenkI/YLNss5CC+LqB4XC3cqCduycm0qU+QCqdgwSrMpCzD6iplS
         XSUA5ISTEIUzTXXsxGJtmMiBAUU98KkgHebMTWp1TUwgKyr9cc+Wha87GWyrdiwLq6OL
         +rhVOgxRr0evLekjFfp+xpRJiUtaf9OhdDehOyYrECCTIurCdQT7JM25Vkpoo3imq1T/
         g+zYUEjgbn9op5rpmxmsZrSVi10L7nA1kts4scN1PGiaQ8m0Otaen+iyusqBfPmSXSZ5
         SFyg==
X-Forwarded-Encrypted: i=1; AJvYcCUgMEu36OL/lgRxTFpLhc+2+b3Nc+QXinbxIAb6plp7+cXuPFnQUp+wC8kcsU6cdjH76+1lzUstZlI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ6fE/y2IvDHlAANj24+3AZBhN4yVw3iifZ4OKYRRpPXSNe19x
	mNF7CiikqXEM6Z4b6MW7FFP3Ivw/MAKTPnpECRBwN3qc0asf8i3gY74cdgHZfSHD0YFOEAoHkAZ
	b+0DZB7KI0qFcPe2YBfgNVUIFVQirPRM=
X-Gm-Gg: ATEYQzyW2zc2QE+Be9tBR9WRge4Elu4r8Vl4Mr9hfEZHeLEtM7jOrRa3LnYs0Ur451f
	zH2WEkapZaaVPhGXLYTzsN6fM12kGVdP609+semOJTJ53aSabrVSuJNXladM77Rp8O+5tAddmMu
	bMTzLxLZ7Cc6FaXimQZXRjiCV883/D99pu/7Jjl6lUefEU0UYdwGEI+AuKDccg+9b/011WZ6yMR
	hakJctaV36/kAuWnKzGRxoYiKWm99JGCISxMUTmw7s8ZQuktyWQz1MKPldkRyFB82GLLEzzWMxE
	d36KevddvoFY+KaVBYnWcA3ZtHjN34Ynxbr7mXg8c374b3k322jIB7s=
X-Received: by 2002:a05:6102:32c4:b0:5e1:866c:4f8a with SMTP id
 ada2fe7eead31-6020e52dbbamr5788771137.20.1773681761421; Mon, 16 Mar 2026
 10:22:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260307140726.70219-1-dorjoychy111@gmail.com>
 <20260307140726.70219-2-dorjoychy111@gmail.com> <5fcc2a6e6d92dae0601c6b3b8faa8b2f83981afb.camel@kernel.org>
In-Reply-To: <5fcc2a6e6d92dae0601c6b3b8faa8b2f83981afb.camel@kernel.org>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Mon, 16 Mar 2026 23:22:29 +0600
X-Gm-Features: AaiRm519sCKeQSwcsAIj83-gCCcOtyLCMrhp4On2ZfkD8pFyjWgcliN3tJw964Y
Message-ID: <CAFfO_h5pyrTTwJ3swHNLT=ZyeTJG=eHw626bTqQqAh+GeN3PhA@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] openat2: new OPENAT2_REGULAR flag support
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20220-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,gmail.com,arndb.de,dilger.ca,linaro.org,alpha.franken.de,hansenpartnership.com,gmx.de,davemloft.net,gaisler.com,redhat.com,dubeyko.com,samba.org,manguebit.org,microsoft.com,talpey.com,szeredi.hu];
	RCPT_COUNT_TWELVE(0.00)[42];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dorjoychy111@gmail.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 3C89D29E4F2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 16, 2026 at 10:53=E2=80=AFPM Jeff Layton <jlayton@kernel.org> w=
rote:
>
> On Sat, 2026-03-07 at 20:06 +0600, Dorjoy Chowdhury wrote:
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
> >  fs/gfs2/inode.c                            |  6 ++++++
> >  fs/namei.c                                 |  4 ++++
> >  fs/nfs/dir.c                               |  4 ++++
> >  fs/open.c                                  |  4 +++-
> >  fs/smb/client/dir.c                        | 14 +++++++++++++-
> >  include/linux/fcntl.h                      |  2 ++
> >  include/uapi/asm-generic/errno.h           |  2 ++
> >  include/uapi/asm-generic/fcntl.h           |  4 ++++
> >  tools/arch/alpha/include/uapi/asm/errno.h  |  2 ++
> >  tools/arch/mips/include/uapi/asm/errno.h   |  2 ++
> >  tools/arch/parisc/include/uapi/asm/errno.h |  2 ++
> >  tools/arch/sparc/include/uapi/asm/errno.h  |  2 ++
> >  tools/include/uapi/asm-generic/errno.h     |  2 ++
> >  21 files changed, 63 insertions(+), 2 deletions(-)
> >
> >
>
> I pointed Claude at this patch and got this back. Both issues that it
> found will need to be fixed:
>
>   Analysis Summary
>
>   Commit: 7e7fa2653ca57 - openat2: new OPENAT2_REGULAR flag support
>
>   This patch adds a new OPENAT2_REGULAR flag for openat2() that restricts=
 opens to regular files only, returning a new
>   EFTYPE errno for non-regular files. It adds filesystem-specific checks =
in ceph, gfs2, nfs, and cifs atomic_open paths,
>   plus a VFS-level fallback in do_open().
>
>   Issues found:
>
>   1. OPENAT2_REGULAR leaks into f_flags - do_dentry_open() strips open-ti=
me-only flags (O_CREAT|O_EXCL|O_NOCTTY|O_TRUNC)
>   but does not strip OPENAT2_REGULAR. When a regular file is successfully=
 opened via openat2() with this flag, the bit
>   persists in file->f_flags and will be returned by fcntl(fd, F_GETFL).
>   2. BUILD_BUG_ON not updated - The compile-time guard checks upper_32_bi=
ts(VALID_OPEN_FLAGS) but the code now accepts
>   VALID_OPENAT2_FLAGS. The guard should cover the expanded flag set.
>

Good catches! I guess for issue 1 I need to modify the line in
do_dentry_open implementation to
f->f_flags &=3D ~(O_CREAT | O_EXCL | O_NOCTTY | O_TRUNC | OPENAT2_REGULAR);
right?
And for issue 2, I should change the VALID_OPEN_FLAGS to
VALID_OPENAT2_FLAGS in both build_open_flags in fs/open.c and in
fcntl_init in fs/fcntl.c, correct?

Regards,
Dorjoy

