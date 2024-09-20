Return-Path: <linux-nfs+bounces-6582-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2D497DAA3
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Sep 2024 00:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B413F1F221E0
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Sep 2024 22:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E7F18D634;
	Fri, 20 Sep 2024 22:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZcM69Jev"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C3218D62F
	for <linux-nfs@vger.kernel.org>; Fri, 20 Sep 2024 22:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726872090; cv=none; b=PmSfggk4mSPoL9ykdO79Swsc/jzON8PSqWX6V7qb/1DN4/nmwxyxOw0R9MGyxvEPm+Ty+9gThImteadB3m9a8Jh6tvNomllvnvde9tx2EFhCIJlf/T7aYcQviJGSCjJNBk3731JhDxzOds6eCHdSJtoNOQZGCHLHD6UcszmmpRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726872090; c=relaxed/simple;
	bh=yPjw/4nNfNHd++hSCKB3UpIVTWNA8jDzE/WpFb0N04g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SriIWSOFPcG9dFqtZSHL8VOofLkQcSUvgQ7p2fWatHyzG7m4GVHtYEAbGNLtxG+igIgYj0hLqmVFUNqvCwONiI34wC0EVla85E2kgQXmr7HJ0+Nb3N04kziPCEdO9A55g/tYRdhBqmg4et31zaPUJMcXEy32O7nZz8d9CHIOa1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZcM69Jev; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7db908c9c83so1351170a12.2
        for <linux-nfs@vger.kernel.org>; Fri, 20 Sep 2024 15:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726872088; x=1727476888; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oSZbRXIQPSUlUDkWbO6YvNgSct1jZO+BnzpSd1WooY8=;
        b=ZcM69JevV3zH3G9rlOmCiBTEhrtyptGNCZmLEsCkRHPbf1DG1xpKzyPaXzbA512gOr
         A5Y0VU26aJJtFbJx4s7mZgHPPJHpVXd35TUObonrB16iX57v9n4DFPVFzWw/nDIWHTtY
         krEZ032r1bdRKuQFWM9iRNZUBGXDlljY+xtDFTHOBqNwUzoKDmmUKoWc7i8QouRdTLIt
         E6XMYESj2CCccoDD3/VN3A14jpXyJv8gMHiB0AlBIMn7QRv/8yNVwWsuN3zDqMxUw+jv
         qyJQvk/jloYITx5ygKIB11Eyl1oxZ66nr8Kltn9LLjPg1r90fgzGPkenDzIS74pgTbru
         rNYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726872088; x=1727476888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oSZbRXIQPSUlUDkWbO6YvNgSct1jZO+BnzpSd1WooY8=;
        b=RHSBMCH8rZFEZEpdig2Hfiiq/++CuXsUCbkYgT76fUWBgLLPB4CJJpk7MUQL2Vu5U7
         Jv9TAAx0ttR43/Ev/Oyb9e3LNXUj8S5s330tgblp3Ul0PfCm2vkKAsl4n5YuGor3RFpn
         hC3yQjxninKTWNPGHmr5N0FJ77kVlPcR3XGnCFs18wUSAAPa5liseTVcziz8BEfLgZ0V
         i30DUMX+7J30fN99x4Z8UR7YTx5aIhgeDtpmIcCsBjyJt6mL2tvpPaOMnWtqEzERQ4b2
         LNuantl9DJOMCYGgibquzPUBEBFxDulcfwA0VQzPtlBPc2a4cVv1GCoEniTyyVTZDSrJ
         ZnNg==
X-Forwarded-Encrypted: i=1; AJvYcCVIQvzASu5z55fvtriPUv72YEQkeCr3kDFWRKNaVaX2IXOjMW3R0f8oIWJLVmxoibDA9xW7WAJuLEY=@vger.kernel.org
X-Gm-Message-State: AOJu0YziGDkPyQ+YXbuiTyDL8wh7JOrZ3vbC+uqXnFtSL4/3Hwt3Xm6q
	a9kyrApnLBfFKoT/zbLtcSn2BTCIsvErNJWDGtDkEDO2V/NnKfTWOLGyIVGDAMlLxXIZ01AKko8
	sYzwwgxjKehWA4zvuaebh/s981/kd83yDPFyx
X-Google-Smtp-Source: AGHT+IFZNUH7m6HqWBq1trLOtyxZm8aJEuRRGQnIhczq1VLGVf2oSoO3pghlIsWmL0npolTVLq3WGh3ae3ZUkD44rIU=
X-Received: by 2002:a17:90b:3b8c:b0:2d8:a9ca:17a4 with SMTP id
 98e67ed59e1d1-2dd7f44a848mr5242193a91.21.1726872087372; Fri, 20 Sep 2024
 15:41:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <66eaf3f1.050a0220.252d9a.0019.GAE@google.com> <18e1d9caf56a56fadabd6abb82c63e0ba0c3dc34.camel@kernel.org>
 <172680104122.17050.16032356795670302194@noble.neil.brown.name> <96DE704B-2EB0-43D5-B34C-3323840F1BB2@oracle.com>
In-Reply-To: <96DE704B-2EB0-43D5-B34C-3323840F1BB2@oracle.com>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Sat, 21 Sep 2024 00:41:13 +0200
Message-ID: <CANp29Y5c+Af7H4kNM8S=uwMu2X2B=R_ODFDe2O4fD4d-xOuiSw@mail.gmail.com>
Subject: Re: [syzbot] [nfs?] KASAN: slab-use-after-free Read in rhashtable_walk_enter
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Neil Brown <neilb@suse.de>, Jeff Layton <jlayton@kernel.org>, 
	syzbot <syzbot+24cd636199753ac5e0ca@syzkaller.appspotmail.com>, 
	Dai Ngo <dai.ngo@oracle.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>, Olga Kornievskaia <okorniev@redhat.com>, 
	"syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>, Tom Talpey <tom@talpey.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 20, 2024 at 8:51=E2=80=AFPM 'Chuck Lever III' via syzkaller-bug=
s
<syzkaller-bugs@googlegroups.com> wrote:
>
>
>
> > On Sep 19, 2024, at 10:57=E2=80=AFPM, NeilBrown <neilb@suse.de> wrote:
> >
> >> So we're tearing down the server and cleaning out the nfsd_file hash,
> >> and we hit a UAF. That probably means that we freed a nfsd_file withou=
t
> >> removing it from the hash? Maybe we should add a WARN_ON() in
> >> nfsd_file_slab_free that checks whether the item is still hashed?
> >>
> >> It is strange though. struct nfsd_file is 112 bytes on my machine, but
> >> the warning is about a 4k allocation. I guess that just means that the
> >> page got recycled into a different slabcache.
> >
> > The code that is crashing hasn't come close to touching anything that i=
s
> > thought to be an nfsd_file.
> > The error is detected in the list_add() in rhashtable_walk_enter() when
> > the new on-stack iterator is being attached to the bucket_table that is=
 being
> > iterated.  So that bucket_table must (now) be an invalid address.
> >
> > The handling of NFSD_FILE_CACHE_UP is strange.  nfsd_file_cache_init()
> > sets it, but doesn't clear it on failure.  So if nfsd_file_cache_init()
> > fails for some reason, nfsd_file_cache_shutdown() would still try to
> > clean up if it was called.
> >
> > So suppose nfsd_startup_generic() is called.  It increments nfsd_users
> > from 0 so continues to nfsd_file_cache_init() which fails for some
> > reason after initialising nfsd_file_rhltable and then destroying it.
> > This will leave nfsd_file_rhltable.tbl as a pointer to a large
> > allocation which has been freed.  nfsd_startup_generic() will then
> > decrement nfsd_users back to zero, but NFSD_FILE_CACHE_UP will still be
> > set.
> >
> > When nfsd_startup_generic() is called again, nfsd_file_cache_init() wil=
l
> > skip initialisation because NFSD_FILE_CACHE_UP is set.  When
> > nfsd_file_cache_shutdown() is then called it will clean up an rhltable
> > that has already been destroyed.  We get exactly the reported symptom.
> >
> > I *think* nfsd_file_cache_init() can only fail with -ENOMEM and I would
> > expect to see a warning when that happened.  In any case
> > nfsd_file_cache_init() uses pr_err() for any failure except
> > rhltable_init(), and that only fails if the params are inconsistent.
> >
> > So I think there are problems with NFSD_FILE_CACHE_UP settings and I
> > think they could trigger this bug if a kmalloc failed, but I don't thin=
k
> > that a kmalloc failed and I think there must be some other explanation
> > here.
>
> Also, the FILE_CACHE_UP logic has been around for several releases.
> Why is this UAF showing up only now?

The most likely reason for that is that syzbot has only recently got
some nfsd interface descriptions. It just didn't fuzz nfsd before.

--=20
Aleksandr

> The "unable to register" messages suggest a possible reason.
>
> --
> Chuck Lever
>
>

