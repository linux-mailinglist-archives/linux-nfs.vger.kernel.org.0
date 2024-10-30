Return-Path: <linux-nfs+bounces-7581-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 762509B695C
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Oct 2024 17:38:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D7381C21231
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Oct 2024 16:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45AB7213120;
	Wed, 30 Oct 2024 16:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Emx/rDR8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DCD2144CA
	for <linux-nfs@vger.kernel.org>; Wed, 30 Oct 2024 16:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730306306; cv=none; b=F1GWHiCRZY91sbJYN8zn8ycIJtQD4tPKc0FLCjuaUfGqbtgPOlxxJ5PGwjJ3lgIT/E9WGVQcE7a64b6OrKq7mqLBwx55/UkRk8jqNwi1BNAwepKmNjCkTA9AEsk+tml6ybJz6JWEux2ppHsECgPeUCUCqBwdB9Obl62jpmIicb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730306306; c=relaxed/simple;
	bh=rb3+67syiR1nhle56QzjckHiix2/mUbsVSgApxorO5c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=dsZm4dzSQYYjPBMuPc0ozJgJ9eR4zgrPOqsFBrDR5iHiIcpvqts8oHKAAdrqnvvEZoVYdlSHDZ6E3jlD8Qgiftc7JEMZyDEQXClQTp+KNoXEV7gYD7CPY1mMLkAxmagK803JEOu/h78peztfDGDeKPUx65gSA4NJMsjr/JxUvwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Emx/rDR8; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5cbb6166c06so141922a12.0
        for <linux-nfs@vger.kernel.org>; Wed, 30 Oct 2024 09:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730306302; x=1730911102; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rb3+67syiR1nhle56QzjckHiix2/mUbsVSgApxorO5c=;
        b=Emx/rDR8BpJFKLpFwxJvInkytChjhE6l8iRZCgSkxd1CHJsUnnBaTuMZdoRH8EQ8F2
         nLLAR5N3ngtKBiahZ3HFB34UyYBcGOno4uemecHQaINXPIDk2RxrlHVjUcyFvTWQQ9m6
         hKDoaOxpH9n6ZfXdoo1m+d6867HHWRFyfJ9WY4R8ZwTQSu+6wKCCNkjVpnOFEQ9/WfLP
         Z1z3ymollVTA3Rrxt/7G4NhEDjMjrlmQhDYGkkOp01Sbgswb4vOvOXQ2KEV4LFIPelE/
         C2FQMTKrm+TX84GMezDsGKtFhsxLAAMz/mX0mgGQ98719c61q8senkGbhs7FxqtE0ZFD
         pZbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730306302; x=1730911102;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rb3+67syiR1nhle56QzjckHiix2/mUbsVSgApxorO5c=;
        b=oapJsZw6BmNG+DUD3n1DHtIY82TG9bH2T+MOIoi47HSbZnl9UGn2h4qr6qhwfZ6h0z
         grQFyyDNy9jfcd6bmP+no/lSYPUPLM/+AbToASTfx+60rK6R85OrEpFVhgeq5SN1eec2
         yr4STkK8mSUdqA8r3Mhn/biICOeRtslWkkWwwJ5CrflW4kZH+v891uF/cPjZIoxSUmPO
         JEgFQkINnzSr7Evbx2q1SNq7tUZZu1oIX4QdnABB+rTUXgEbDKHNTzXL8D9IjzzuRJUv
         J2ndE3ranrqoiIBp4DSEmvv0SYr7M4r0j5sIjsr/Wm9YbaSdWRc8xkOUEv/x8SpeBB4R
         qKKw==
X-Gm-Message-State: AOJu0Ywj8lCVfBJsPaUudcEXKN47GRcIk3Fkr8SrUvJqQDRNTiUT0u4p
	PZ9+BkDt9yQSzFvh9/86dk9phqP6ok22vlPaMfeR+WXt/NV7gTuLaIXs4jg4hnpR3/nzqsNCA4N
	idESx0Nh9Hf4Mx1FWFX/gXeYmrNVoF4eF
X-Google-Smtp-Source: AGHT+IGWvwloYv7qqAS7E3Vf8c7g8kYGDguMbpCskhLKbmuHE6G/SAl2VomXFMz+F8+kUVMo2e1FUfZrIQUn/NzPI10=
X-Received: by 2002:a05:6402:358f:b0:5cb:6ca4:f552 with SMTP id
 4fb4d7f45d1cf-5cea9732e2fmr168036a12.35.1730306301728; Wed, 30 Oct 2024
 09:38:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023152940.63479-1-snitzer@kernel.org> <20241023155846.63621-1-snitzer@kernel.org>
 <CANH4o6Pi13aEtQW5-vmuJiuCNzx6tjn1+v=pLUpVMuffX-WkPA@mail.gmail.com>
 <7FB2B261-48F9-4DA0-B4B5-E8E30EC31CD9@oracle.com> <CAGOwBeX7xw7cPRXGO5RmLQUgzOjqr-7Bh4EhV=hONpXCAqsX-g@mail.gmail.com>
 <91F0EACF-76BC-49EE-9340-AC60F641B8B2@oracle.com> <CALXu0UcAw7xkObkVFFTi6d-F69_qrDwf9pTE+8We3k14CvywmA@mail.gmail.com>
 <B67E796E-1539-437C-9F54-091D178E0171@oracle.com>
In-Reply-To: <B67E796E-1539-437C-9F54-091D178E0171@oracle.com>
From: Cedric Blancher <cedric.blancher@gmail.com>
Date: Wed, 30 Oct 2024 17:37:45 +0100
Message-ID: <CALXu0Uf4DfcgOqExZ8RYeHY8-fx_fzqCsqAUJogV2Dx8DMgJzQ@mail.gmail.com>
Subject: Re: [PATCH v3] nfsd: disallow file locking and delegations for NFSv4 reexport
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 30 Oct 2024 at 17:15, Chuck Lever III <chuck.lever@oracle.com> wrot=
e:
>
>
>
> > On Oct 30, 2024, at 10:55=E2=80=AFAM, Cedric Blancher <cedric.blancher@=
gmail.com> wrote:
> >
> > On Tue, 29 Oct 2024 at 17:03, Chuck Lever III <chuck.lever@oracle.com> =
wrote:
> >>
> >>> On Oct 29, 2024, at 11:54=E2=80=AFAM, Brian Cowan <brian.cowan@hcl-so=
ftware.com> wrote:
> >>>
> >>> Honestly, I don't know the usecase for re-exporting another server's
> >>> NFS export in the first place. Is this someone trying to share NFS
> >>> through a firewall? I've seen people share remote NFS exports via
> >>> Samba in an attempt to avoid paying their NAS vendor for SMB support.
> >>> (I think it's "standard equipment" now, but 10+ years ago? Not
> >>> always...) But re-exporting another server's NFS exports? Haven't see=
n
> >>> anyone do that in a while.
> >>
> >> The "re-export" case is where there is a central repository
> >> of data and branch offices that access that via a WAN. The
> >> re-export servers cache some of that data locally so that
> >> local clients have a fast persistent cache nearby.
> >>
> >> This is also effective in cases where a small cluster of
> >> clients want fast access to a pile of data that is
> >> significantly larger than their own caches. Say, HPC or
> >> animation, where the small cluster is working on a small
> >> portion of the full data set, which is stored on a central
> >> server.
> >>
> > Another use case is "isolation", IT shares a filesystem to your
> > department, and you need to re-export only a subset to another
> > department or homeoffice. Part of such a scenario might also be policy
> > related, e.g. IT shares you the full filesystem but will do NOTHING
> > else, and any further compartmentalization must be done in your own
> > department.
> > This is the typical use case for gov NFS re-export.
>
> It's not clear to me from this description why re-export is
> the right tool for this job. Please explain why ACLs are not
> used in this case -- this is exactly what they are designed
> to do.

1. IT departments want better/harder/immutable isolation than ACLs
2. Linux NFSv4 only implements POSIX draft ACLs, not full Windows or
NFSv4 ACLs. So there is no proper way to prevent ACL editing,
rendering them useless in this case.

There is a reason why POSIX draft ACls were abandoned - they are not
fine-granted enough for real world usage outside the Linux universe.
As soon as interoperability is required these things just bite you
HARD.

Also, just running more nfsd in parallel on the origin NFS server is
not a better option - remember the debate of non-2049 ports for nfsd?

>
> And again, clients of the re-export server need to mount it
> with local_lock. Apps can still use locking in that case,
> but the locks are not visible to apps on other clients. Your
> description does not explain why local_lock is not
> sufficient or feasible.

Because:
- it breaks applications running on more than one machine?
- it breaks use cases like NFS--->SMB bridges, because without locking
the typical Windows .NET application will refuse to write to a file
- it breaks even SIMPLE things like Microsoft Excel

Of course the happy echo "hello Linux-NFSv4-only world" >/nfs/file
will always work.

> > Of course no one needs the gov customers, so feel free to break locking=
.
>
>
> Please have a look at the patch description again: lock
> recovery does not work now, and cannot work without
> changes to the protocol. Isn't that a problem for such
> workloads?

Nope, because of UPS (Uninterruptible power supply). Either everything
is UP, or *everything* is DOWN. Boolean.

>
> In other words, locking is already broken on NFSv4 re-export,
> but the current situation can lead to silent data corruption.

Would storing the locking information into persistent files help, ie.
files which persist across nfsd server restarts?

Ced
--=20
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur

