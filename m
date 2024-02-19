Return-Path: <linux-nfs+bounces-2026-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2B7859AE3
	for <lists+linux-nfs@lfdr.de>; Mon, 19 Feb 2024 04:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A50571C20EAB
	for <lists+linux-nfs@lfdr.de>; Mon, 19 Feb 2024 03:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074641FDB;
	Mon, 19 Feb 2024 03:02:45 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C771FC8
	for <linux-nfs@vger.kernel.org>; Mon, 19 Feb 2024 03:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708311764; cv=none; b=tnTfg6r2KmNFh31LO+TfmCdk5Je/XzwLphE/QmW4k2j2ib3tL2qlAGO6YiIEqgfWCRU7H1eWOtd4M6BbhG8Jhi9SJTAQkklPVamW8UbsP2gLj75CEim90wJKuQzkXVfs6En1N5BES2LxT9sVEmRRVnH8ZbOzMzXaER+ZuLudUvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708311764; c=relaxed/simple;
	bh=BbyjbUd5AEcRtsQyZYm3uHKHxWjmkGGKV+1JxaVgpQk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=fOHKpoxBeb9hiDgUHOcif35QyOJG5wwf95HqoKLUWRQ005erWbwg1fQR/GLOWrrAmTxd3OalpqdHfv4pOr/V28u9cb7fmdZwZVxu9b1z7Y4CwxPvJV2GWvezVdzkFfnJNtNemSjsojOrQbWwpOlfPqMh4i+odd6NezJN47Vnuog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nrubsig.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nrubsig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7bfe5aa702fso156095039f.3
        for <linux-nfs@vger.kernel.org>; Sun, 18 Feb 2024 19:02:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708311762; x=1708916562;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nb/Mp519U7aJJW1i5VaP1nx2e9Ux8ZYOxe4Hga8Lhgs=;
        b=SRoQKm7gMuDQjNF7i4RZ9wEcFFTHMUW+Lt2J//uXtn3weTIzPOxdXPhy2HByLr9vrM
         5AV454VmbeVlF+cgWCFbwc19vTSxQV2Eofr9JYO6RF/DtUulXqk9Ajj5Y00Bp+0pJx53
         mRuubtp6WM+E2iko+57caEs2RSqPPKCZcPdAc2uSwhYa9tY/MaF0YLbsPkQri/20kKHs
         L6HBBjRk2lcXknhOkbrM7XxANVhJ06qdISKCVnaVmi0kTnkxDu4QaUepYfHUBQ8SFENA
         Eh6OlIViiewG/RaAMnbtf/5JcHRGmlYpn+50kAeySuRcG2fC/56tPOFI0U0ZDaYKsjzo
         JWig==
X-Gm-Message-State: AOJu0YwtBOEP3S113YfOitQQiJNOC5hkbQ6ewk6FbDNRX96rdNGEuwE6
	NKHwED/8FPLlNa623WXwT+7FlyTcQ0/BmA2FEk+d7wi3mTDaYKje5VJmzYD0x98W3XW4bKAS+ga
	S5itZXHzNtwY5/0TBeC1+MnQLoc3s8IDGavk=
X-Google-Smtp-Source: AGHT+IHeMG7WVqJgs8/H7fx2wMk4DfTisnLar1Reisi9cF55Ej8V4/u12hkklfIVlrRJQU+CbLHQpn6/6FmV0v2I92M=
X-Received: by 2002:a5d:9608:0:b0:7c7:3a2b:3c25 with SMTP id
 w8-20020a5d9608000000b007c73a2b3c25mr5036567iol.20.1708311762046; Sun, 18 Feb
 2024 19:02:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKAoaQkeevOpxQPjH+KZt3fyYweLsrY-bhHsqvOpdVXuGYwqXA@mail.gmail.com>
 <ZdI0I8YV2Vir8f7g@manet.1015granger.net>
In-Reply-To: <ZdI0I8YV2Vir8f7g@manet.1015granger.net>
From: Roland Mainz <roland.mainz@nrubsig.org>
Date: Mon, 19 Feb 2024 04:02:15 +0100
Message-ID: <CAKAoaQ=CaBGSnoTK9GteCj=CWjMxiGcEhozCOuqu7-ygBeAHYQ@mail.gmail.com>
Subject: Re: "nfsd: inode locked twice during operation." errors ...
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 18, 2024 at 5:45=E2=80=AFPM Chuck Lever <chuck.lever@oracle.com=
> wrote:
> On Sun, Feb 18, 2024 at 01:00:33PM +0100, Roland Mainz wrote:
> > I'm getting the following errors from nfsd in the kernel log on a regul=
ar basis:
> > ---- snip ----
> > [349278.877256] nfsd: inode locked twice during operation.
> > [349279.599457] nfsd: inode locked twice during operation.
> > [349280.302697] nfsd: inode locked twice during operation.
> > [349280.803115] nfsd: inode locked twice during operation.
> > ---- snip ----
> >
> > nfsd runs on "Linux 5.10.0-22-rt-686-pae #1 SMP PREEMPT_RT Debian
> > 5.10.178-3 (2023-04-22) i686 GNU/Linux", exported filesystem is btrfs
> > on a SSD.
> > NFSv4.1 client is the Windows ms-nfs41-client (git
> > #e67a792c4249600164852cfc470ac0acdb9f043b) compiling gcc under Cygwin
> > 3.5.0.
> >
> > Is the nfsd issue known, and if "yes" is there a patch ?
>
> I believe that warning message vanishes as a side-effect of this
> series of commits:
>
> 7fe2a71dda34 NFSD: introduce struct nfsd_attrs
> 93adc1e391a7 NFSD: set attributes when creating symlinks
> d6a97d3f589a NFSD: add security label to struct nfsd_attrs
> c0cbe70742f4 NFSD: add posix ACLs to struct nfsd_attrs
> 927bfc5600cd NFSD: change nfsd_create()/nfsd_symlink() to unlock director=
y before returning.
> b677c0c63a13 NFSD: always drop directory lock in nfsd_unlink()
> e18bcb33bc5b NFSD: only call fh_unlock() once in nfsd_link()
> 19d008b46941 NFSD: reduce locking in nfsd_lookup()
> debf16f0c671 NFSD: use explicit lock/unlock for directory ops
> bb4d53d66e4b NFSD: use (un)lock_inode instead of fh_(un)lock for file ope=
rations
> dd8dd403d7b2 NFSD: discard fh_locked flag and fh_lock/fh_unlock
>
> plus this fix:
>
> 00801cd92d91 NFSD: fix regression with setting ACLs.

Ouch... ;-(
... so the patch at the bottom of
https://patchwork.kernel.org/project/linux-nfs/patch/533299E9.6010806@gmail=
.com/#8291331
is not sufficient, right ?

> Any upstream Linux kernel after v6.0 should operate without that
> warning. I don't see those commits in origin/linux-5.10.y.

Are the kernels in the Linux 6.6-stable branch "safe" as NFSv4.x for
NFSv4.1 client development ?

----

Bye,
Roland
--=20
  __ .  . __
 (o.\ \/ /.o) roland.mainz@nrubsig.org
  \__\/\/__/  MPEG specialist, C&&JAVA&&Sun&&Unix programmer
  /O /=3D=3D\ O\  TEL +49 641 3992797
 (;O/ \/ \O;)

