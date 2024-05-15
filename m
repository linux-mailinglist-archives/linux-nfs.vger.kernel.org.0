Return-Path: <linux-nfs+bounces-3262-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A998C6907
	for <lists+linux-nfs@lfdr.de>; Wed, 15 May 2024 16:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7BF51C2192E
	for <lists+linux-nfs@lfdr.de>; Wed, 15 May 2024 14:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71FA3155730;
	Wed, 15 May 2024 14:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hZZV665u"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09CF57CA1;
	Wed, 15 May 2024 14:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715784735; cv=none; b=jLMt2wi+zdKyBgi4AxhygTN2js48GWdle0DpmqQFlaUlCGkhpUIPKwrpBF4XJK7YjuzJr+ifQB+0s6/NnxhJt9SoHqj8tXWD9K/UVJCLT0A9YQIGZ8wfWYlcrn+n/NuNxUcTUhFHuKtOygWS725hyyW+vqUqdAQKIP1YhAotZzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715784735; c=relaxed/simple;
	bh=mfIWBKjyaGtpfqqPaQXhJaL2BgJixSHpCSI3TbRvwWI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M7YJ+iwphaq7YBo3IOdqUpXVEvbCGywiODP01VOu1zVSZTUCkGPkAKwk6+uIC4gx4n7NOjCjPhYQ1I3XhgetiTvk/ldNiO5APUagl0w6MAv7xTE0KT1iPZYA1hG1YwHzxhk5Q+FdCZ0o6dH5K/CGy2Yw0r9+RaQdRU3zxi8o/Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hZZV665u; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1ecd9a81966so55610655ad.0;
        Wed, 15 May 2024 07:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715784733; x=1716389533; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dyd4g9Mj6udeAMgwbujT15lk0egPi/YMbqByHib0kUE=;
        b=hZZV665uFO7NGWa8XzZ7KyohlwJnBkLZEn9AYcxgf2Dig8RqjKANpwtkT0nxS/vH15
         ov+hSoVD3YX5EitLuOJYvhBvh9pwP9Ds4oefJmJwel9bQYStcSqOfBt00EU0qjOrof4L
         v24MW+Q7zBLvKvYKHRcvaMntW03OzkWJ2pH63B6iqO5aNTmjyP0yBEn6C7SvXe/HC0RO
         sv0cRIvbbKbqcfX4EAq7ofkfLHf9rXqnWMlAGuVOp4dVib/isJ85/jaex06TApnY20ho
         WogOPNVbkmkw3r8ST7304lBrRI6y0XLynDpPyhCL3XJuQA3vD9YJbhOvYb6RkZPEw/oO
         yuWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715784733; x=1716389533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dyd4g9Mj6udeAMgwbujT15lk0egPi/YMbqByHib0kUE=;
        b=j4zd3lmuv9wvaU2vJXe8le/StFvKaTNQO9plHr+Inku+sxzLu+CTuXLYPHhvpUvBVt
         3kGm3LQTd2kVPgTh0y0URHKH/J/gs9Pqv4bzLiu/aSCVrCly1f1yTEUWsftOTAiQHeBi
         lpgSc0gBWZdPvWdA/3PQynz37jSSw+iu+Ilf2tFxRfz9gMC8bjc8L3OYf3lK2/KukEop
         O9KmEEr2wIdRuyYou5BDFxuA7FMvUtHVi0FmvrT6hzIlqROxeevFNLa4XL+zF7zZtMv9
         cOTsMWzMoF8eu45e9Bh+BnTf1RSk9qMrauWrNIrr9MVxIdej4miTCTxJynR9COqrOq3c
         knnA==
X-Forwarded-Encrypted: i=1; AJvYcCWrJMij3OtFpBlfedza+IsFjmQrVoYvFWu9EV194uDEc6cHcoouaEAGbAm+2MUL+Bve8rPL3ngvS+OMSEMsb9HEqVieLniZS6RpuG+tW/ABy6dTHoeZ7hXxPXKNJNfxvItUtt9bWO1U37b6X9nscQOT
X-Gm-Message-State: AOJu0YwMylmvCT/XdTsRqbffuugfm/rZ65pGvVmU8ZAE4NKLEujRlJX7
	orespycBLzc9l+y//vgv0oo3TibTndcf32culf9ENTF67qxEmM4KtvpyAdmXBxUd8sIsactvwuj
	Io+XWic6mn9bYX+IukVzpajdxJD4=
X-Google-Smtp-Source: AGHT+IEBX22RX9w1vE00S9nBou9S9ivxyjpVGwDAKjzpwjQAP1/Pb2AKyIRA1BYuB73/SpuaEfwQls/e50YW11bQYuk=
X-Received: by 2002:a17:902:d2d0:b0:1e4:59a2:d7c1 with SMTP id
 d9443c01a7336-1eefa58c6ebmr289967395ad.33.1715784733009; Wed, 15 May 2024
 07:52:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503130905.16823-1-stephen.smalley.work@gmail.com> <171497439414.9775.6998904788791406674@noble.neil.brown.name>
In-Reply-To: <171497439414.9775.6998904788791406674@noble.neil.brown.name>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 15 May 2024 10:52:01 -0400
Message-ID: <CAEjxPJ6DTNY3p9MmdV0K1A7No7joczGTeOe26Q4wr6yujk9zKA@mail.gmail.com>
Subject: Re: [PATCH v3] nfsd: set security label during create operations
To: NeilBrown <neilb@suse.de>
Cc: selinux@vger.kernel.org, linux-nfs@vger.kernel.org, chuck.lever@oracle.com, 
	jlayton@kernel.org, paul@paul-moore.com, omosnace@redhat.com, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 6, 2024 at 1:46=E2=80=AFAM NeilBrown <neilb@suse.de> wrote:
>
> On Fri, 03 May 2024, Stephen Smalley wrote:
> > When security labeling is enabled, the client can pass a file security
> > label as part of a create operation for the new file, similar to mode
> > and other attributes. At present, the security label is received by nfs=
d
> > and passed down to nfsd_create_setattr(), but nfsd_setattr() is never
> > called and therefore the label is never set on the new file. This bug
> > may have been introduced on or around commit d6a97d3f589a ("NFSD:
> > add security label to struct nfsd_attrs"). Looking at nfsd_setattr()
> > I am uncertain as to whether the same issue presents for
> > file ACLs and therefore requires a similar fix for those.
> >
> > An alternative approach would be to introduce a new LSM hook to set the
> > "create SID" of the current task prior to the actual file creation, whi=
ch
> > would atomically label the new inode at creation time. This would be be=
tter
> > for SELinux and a similar approach has been used previously
> > (see security_dentry_create_files_as) but perhaps not usable by other L=
SMs.
> >
> > Reproducer:
> > 1. Install a Linux distro with SELinux - Fedora is easiest
> > 2. git clone https://github.com/SELinuxProject/selinux-testsuite
> > 3. Install the requisite dependencies per selinux-testsuite/README.md
> > 4. Run something like the following script:
> > MOUNT=3D$HOME/selinux-testsuite
> > sudo systemctl start nfs-server
> > sudo exportfs -o rw,no_root_squash,security_label localhost:$MOUNT
> > sudo mkdir -p /mnt/selinux-testsuite
> > sudo mount -t nfs -o vers=3D4.2 localhost:$MOUNT /mnt/selinux-testsuite
> > pushd /mnt/selinux-testsuite/
> > sudo make -C policy load
> > pushd tests/filesystem
> > sudo runcon -t test_filesystem_t ./create_file -f trans_test_file \
> >       -e test_filesystem_filetranscon_t -v
> > sudo rm -f trans_test_file
> > popd
> > sudo make -C policy unload
> > popd
> > sudo umount /mnt/selinux-testsuite
> > sudo exportfs -u localhost:$MOUNT
> > sudo rmdir /mnt/selinux-testsuite
> > sudo systemctl stop nfs-server
> >
> > Expected output:
> > <eliding noise from commands run prior to or after the test itself>
> > Process context:
> >       unconfined_u:unconfined_r:test_filesystem_t:s0-s0:c0.c1023
> > Created file: trans_test_file
> > File context: unconfined_u:object_r:test_filesystem_filetranscon_t:s0
> > File context is correct
> >
> > Actual output:
> > <eliding noise from commands run prior to or after the test itself>
> > Process context:
> >       unconfined_u:unconfined_r:test_filesystem_t:s0-s0:c0.c1023
> > Created file: trans_test_file
> > File context: system_u:object_r:test_file_t:s0
> > File context error, expected:
> >       test_filesystem_filetranscon_t
> > got:
> >       test_file_t
> >
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > ---
> > v3 removes the erroneous and unnecessary change to NFSv2 and updates th=
e
> > description to note the possible origin of the bug. I did not add a
> > Fixes tag however as I have not yet tried confirming that.
>
> I think this bug has always been present - since label support was
> added.
> Commit d6a97d3f589a ("NFSD: add security label to struct nfsd_attrs")
> should have fixed it, but was missing the extra test that you provide.
>
> So
> Fixes: 0c71b7ed5de8 ("nfsd: introduce file_cache_mutex")
> might be appropriate - it fixes the patch, though not a bug introduced
> by the patch.
>
> Thanks for this patch!
> Reviewed-by: NeilBrown <neilb@suse.de>

FWIW, I finally got around to testing Linux v5.14 and it did pass
these NFS tests so this was a regression. I haven't been able to
bisect yet.

