Return-Path: <linux-nfs+bounces-10943-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D699A74D7E
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Mar 2025 16:14:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A699A189D1F2
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Mar 2025 15:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30FC1C860C;
	Fri, 28 Mar 2025 15:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="KS7Zp2hq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CA41CD1E0
	for <linux-nfs@vger.kernel.org>; Fri, 28 Mar 2025 15:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743174844; cv=none; b=i+c9tQUfTM5i30zEjspGFyKmtm/Vl7LUwCJdMIeG6eTatYYsjesJUZ4WzodtzwyJGvHQP/XMQT4dFH9grrh3JwOkHmz5tVDJis/vauA79YQfI7wzO8eiirNr+IBsOhvNVgGtpwypEuUlHDmFaU7PinJNZK5XIZdD2xEKiCfWG6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743174844; c=relaxed/simple;
	bh=i4l5c0MLu9pbQghrstSFjBo9or1UXk6rtB7wxhp6iSI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nX1P3LII2id6O9S13B/5HXUQcVUjijjypDLQj+lM0xC6vwbUBMk0QbTVkvM1hswoRb60teYFEKu5zKYMxHCeD9g/QyAUgg35WLjwjc0nrxv0YK3hUH2G60SKO5oVmJNRn4iv/UwOv7pq0Qw5tkNAj17VmsRGM/+eCQ9IjWx1+w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=KS7Zp2hq; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3061513d353so24185131fa.2
        for <linux-nfs@vger.kernel.org>; Fri, 28 Mar 2025 08:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1743174841; x=1743779641; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eKwSp1CCSOKdFohGWTKpUftLeQoI8GTqTkogmxRYEcU=;
        b=KS7Zp2hqF+RuEd/QL/L/H2oiUjE/tWx56TDDlttzw7nLJSgZUmXAmbnIGIqkWT3Ftw
         hSZKhJlHg3XPO+F9N+zDXKwngSyA9600ux1ouil7vvYU7U3UmNJH1FKfcKXnzvAsV2UC
         Vzhc3mHWmkm2IztdHWQ7ghBQ6Lhow/QOEuFEzzFaMgkl4nD1RmlSNi/eCmXmZssJTUmk
         EQoA0VtYggytMURSKV3FPNY4WukxtmHqWkH6T30ivBcvFoNrQHHO6/ZSl87K3WceEdfz
         KiukHlDBeMqucdN7JXt5DagqGBwO0XuiSR5PEQ4kYl6Vmg0ed1DHnJf7lNpwZtWv5U/t
         sKIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743174841; x=1743779641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eKwSp1CCSOKdFohGWTKpUftLeQoI8GTqTkogmxRYEcU=;
        b=pq2nsb/aBwkLVzyceFBbMPp34UP4+J4o+I2IYtmZakxYJ/XI1HZ+txA90sGIahRUFd
         O0XM80wGUDbpGfd3Orsh1QXdbr7P3ohPAoPN4StXoFiub4BeDYlkjU4crwBnTUdWTJ5t
         EY6TFD8YKYfkpUoYGyXL3LRSBTEAn5MjN/1j4hBCbEawy+Zj7Sez+WEfASH5ljkZPxLc
         hf1HmFCU5fcpC4OrlsyMSqapv76NtTQpYSKoKWry+82k+MmtmvqYiTRnohMsG8YIIN8x
         pN69TXOmlD7gbOq2lHFpw+QmdqFYJOjwdAwh9KL0LW7NcxgvxzKToUvmkQMItxK8ZH9y
         rCMw==
X-Forwarded-Encrypted: i=1; AJvYcCWkNQzUfcioPAlwZ/rXHN0nZ/TVLNKiYYJFUHe/fuQF9wEPpNxTMtqdxra1iLiS91aOFibU+SALoHo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywra/QwgbnFx7q+XqBCT0tPCOmQzza8E3PkGYzBO/csrVTzlT0O
	xUB3lTEWyvfdhqC5qdY/P3tziIBj0q+Jeo+8oaxMdVL7UgU1jzIrDX1HSAYbzJ/m4mCrr2W7X5a
	jkZNwAaS0AtjKU3KfjG42LnYWK/o=
X-Gm-Gg: ASbGncvJivq6/j6jmtPNjTdEdY1xW+mGNbYmogjnQFgSlPUZHO/P4H7FqtE6C6m1ump
	gaa+QXSoyt+vD9ByItYf33l35TkSgRt0u79WXY0G//6tO6vyAu4obQM3LQaOdc7OkQcffhX7td1
	zbIMxrLzF+DVngLzAXaGLg20hbUoPhsj1ZfIsL6LFGRY3K0fVEIedrutfXzIQ2
X-Google-Smtp-Source: AGHT+IEngR/L+iE0zmGQV+4BC94dovrYJZIGNoA87PrVc6uUJa9Fv8XOftUUoKzBubn+6pJfCgbmRfUi6dlkmuL4a3k=
X-Received: by 2002:a2e:834e:0:b0:30c:c8d:ba3c with SMTP id
 38308e7fff4ca-30dc5e3209bmr23740391fa.17.1743174840586; Fri, 28 Mar 2025
 08:14:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACSpFtAj1TxzsMfxuSttA0_tqAZ2FZR69DuL5i-xK6bvMbtc_w@mail.gmail.com>
 <174312619109.9342.16173648063480052169@noble.neil.brown.name>
In-Reply-To: <174312619109.9342.16173648063480052169@noble.neil.brown.name>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Fri, 28 Mar 2025 11:13:48 -0400
X-Gm-Features: AQ5f1JozR1iB-qfEYIOp1CZeLd7SVIi7rV5ujqE49Lq-qTkzSPnAW0TPtsfczJw
Message-ID: <CAN-5tyHKrbL9DuFxvH6hnL4uwHDZ-d49X8DFBVReCvdh+Qh0XQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] nfsd: reset access mask for NLM calls in nfsd_permission
To: NeilBrown <neilb@suse.de>
Cc: Olga Kornievskaia <okorniev@redhat.com>, chuck.lever@oracle.com, jlayton@kernel.org, 
	linux-nfs@vger.kernel.org, Dai.Ngo@oracle.com, tom@talpey.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 27, 2025 at 9:43=E2=80=AFPM NeilBrown <neilb@suse.de> wrote:
>
> On Fri, 28 Mar 2025, Olga Kornievskaia wrote:
> > On Thu, Mar 27, 2025 at 7:54=E2=80=AFPM NeilBrown <neilb@suse.de> wrote=
:
> > >
> > > On Sat, 22 Mar 2025, Olga Kornievskaia wrote:
> > > > NLM locking calls need to pass thru file permission checking
> > > > and for that prior to calling inode_permission() we need
> > > > to set appropriate access mask.
> > > >
> > > > Fixes: 4cc9b9f2bf4d ("nfsd: refine and rename NFSD_MAY_LOCK")
> > > > Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> > > > ---
> > > >  fs/nfsd/vfs.c | 7 +++++++
> > > >  1 file changed, 7 insertions(+)
> > > >
> > > > diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> > > > index 4021b047eb18..7928ae21509f 100644
> > > > --- a/fs/nfsd/vfs.c
> > > > +++ b/fs/nfsd/vfs.c
> > > > @@ -2582,6 +2582,13 @@ nfsd_permission(struct svc_cred *cred, struc=
t svc_export *exp,
> > > >       if ((acc & NFSD_MAY_TRUNC) && IS_APPEND(inode))
> > > >               return nfserr_perm;
> > > >
> > > > +     /*
> > > > +      * For the purpose of permission checking of NLM requests,
> > > > +      * the locker must have READ access or own the file
> > > > +      */
> > > > +     if (acc & NFSD_MAY_NLM)
> > > > +             acc =3D NFSD_MAY_READ | NFSD_MAY_OWNER_OVERRIDE;
> > > > +
> > >
> > > I don't agree with this change.
> > > The only time that NFSD_MAY_NLM is set, NFSD_MAY_OWNER_OVERRIDE is al=
so
> > > set.  So that part of the change adds no value.
> > >
> > > This change only affects the case where a write lock is being request=
ed.
> > > In that case acc will contains NFSD_MAY_WRITE but not NFSD_MAY_READ.
> > > This change will set NFSD_MAY_READ.  Is that really needed?
> > >
> > > Can you please describe the particular problem you saw that is fixed =
by
> > > this patch?  If there is a problem and we do need to add NFSD_MAY_REA=
D,
> > > then I would rather it were done in nlm_fopen().
> >
> > set export policy with (sec=3Dkrb5:...) then mount with sec=3Dkrb5,vers=
=3D3,
> > then ask for an exclusive flock(), it would fail.
> >
> > The reason it fails is because nlm_fopen() translates lock to open
> > with WRITE. Prior to patch 4cc9b9f2bf4d, the access would be set to
> > acc =3D NFSD_MAY_READ | NFSD_MAY_OWNER_OVERRIDE; before calling into
> > inode_permission(). The patch changed it and lead to lock no longer
> > being given out with sec=3Dkrb5 policy.
>
> And do you have WRITE access to the file?
>
> check_fmode_for_setlk() in fs/locks.c suggests that for F_WRLCK to be
> granted the file must be open for FMODE_WRITE.
> So when an exclusive lock request arrives via NLM, nlm_lookup_file()
> calls nlm_do_fopen() with a mode of O_WRONLY and that causes
> nfsd_permission() to check that the caller has write access to the file.
>
> So if you are trying to get an exclusive lock to a file that you don't
> have write access to, then it should fail.
> If, however, you do have write access to the file - I cannot see why
> asking for NFSD_MAY_READ instead of NFSD_MAY_WRITE would help.

That's correct, the user doing flock() does NOT have write access to
the file. Yet prior to the 4cc9b9f2bf4d, that access was allowed. If
that was a bug then my bad. I assumed it was regression.

It's interesting to me that on an XFS file system, I can create a file
owned by root (on a local filesystem) and then request an exclusive
lock on it (as a user -- no write permissions).

okorniev@linux:~$ ls -l /export/foobar
-rw-r--r--. 1 root root 4 Mar 28 10:46 /export/foobar
okorniev@linux:~$ flock -x /export/foobar sleep 1s

>
> NeilBrown
>
>
> >
> >
> > >
> > > Thanks,
> > > NeilBrown
> > >
> > >
> > > >       /*
> > > >        * The file owner always gets access permission for accesses =
that
> > > >        * would normally be checked at open time. This is to make
> > > > --
> > > > 2.47.1
> > > >
> > > >
> > >
> >
> >
>
>

