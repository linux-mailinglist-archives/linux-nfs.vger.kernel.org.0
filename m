Return-Path: <linux-nfs+bounces-7592-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3829B6FFE
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Oct 2024 23:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 518E7282B99
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Oct 2024 22:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B081C462D;
	Wed, 30 Oct 2024 22:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WpzocFei"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93B11EF94E
	for <linux-nfs@vger.kernel.org>; Wed, 30 Oct 2024 22:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730328521; cv=none; b=UOYwNhiiLZPIx28a0CX4ERaxbIMvBDmy7j4lGIaJn9PvuxAtGyN/WXhvzVZaVK7TRf7+9zxFmVuiMDRCp866+KoqsWIy5hiZRmMjEwbokaAJG+DG8KW6uoqSTZh3O+W5jcR6YIFoYz2f7MbG5uG/AKrtExk2gCZKvfhIRSlmUFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730328521; c=relaxed/simple;
	bh=Tbwx7TTaWcsYfMBbk20KYEAWDIhdxkPJwx806PGIBEk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ufiR9rYwfESvFTHwemig6RF2wWi1VP5J4YykRTkghHRjsuRzzZXq7wl71QYE2dQ8P/JobT05jfaha+OqdUMaa67VxEpZlRhvVCCidn0+kETApTsgZN3sFBdanm/1f+zMDKlWspPjlzWWJHABd6UcBD4aFXPfByM0yOTOjQ+fKpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WpzocFei; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-37d47b38336so282964f8f.3
        for <linux-nfs@vger.kernel.org>; Wed, 30 Oct 2024 15:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730328516; x=1730933316; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CMUA/ZBul48C5q1PWHJWcTn8ZaQd95rTJ1PSbfiMFcI=;
        b=WpzocFeiZFd6bOaZXqLgRreKjJWUFSaB2Ie3qrk3GZ3u6WromE/DDAZSuqbJU6MNwf
         zjE3Nj1zdCmc1wfjZF1jE71cXcZCk1s7zPbz2Vs+AfdZiHfPcmdjiqt3DCWeU42m8qQP
         rh36UcaIvBrRjmshg2VaTLp5QlmdTkSP9F9EdJMKrmqegFu0xWQUIF8V7ZdCPLRooVbz
         926jNL+f+1ZhMf2U1eE6X5k2zAexHPdc2CHELwpW0Vz0EDMQ6V0K0i2Fy8iDOOqv6ajk
         YBtt6pcTAZDyUs56953F4xTxJJB/Dy3PQwBNVzdHwGSVG9MSU8Y9pYnXRN/vgaVtzpP8
         aUdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730328516; x=1730933316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CMUA/ZBul48C5q1PWHJWcTn8ZaQd95rTJ1PSbfiMFcI=;
        b=fRTAwnGCmB/8MfXwPvTUYls2KdA8/SRTuNDzvN8Uhy45mtr5qtufy1ySZN+2Q+OJ8M
         lUjju6DTd2jT6KKWMOpZVw58oNCWA2p49jS2JdH70LF5iRQTuLJhYSQZ9GQAjbKkfGq+
         gp96V4Ee9OcHzS/qXYpYiTngxZm35hXBj5dZan8Ft/y127qODwbwO7biJUcl2zkZT7nl
         DginxSwLntj4azdLYccwVR2QjSSqUHMPcVoRlTOKdT6jonu2IEDwoLOcR8EHuP8XOcvr
         ThW1dVgPjSdXDTB4fnvkheUEq3DwU3NiFiTQRWndHgsaylx4HE4Z55XKSL4G92pMUBs4
         CF2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUOzhQ1A8RpaV+jOlyuCNJhSbfBg7hgk1z9NCj6+bFTUfNZuJi23T7mRQgOCqiK8/b0Gml7Ofehtww=@vger.kernel.org
X-Gm-Message-State: AOJu0YydTPzovZAtM/E/vvFfBNhQUZ1j61tGpDpY7IjHIaNJTIrAbOyF
	pnGnGVuEjbbz9+nI3GBcJyirG4D7yPJ45TVzTllTgOqIhL+nd2WpdAWcVx1QaNFVbuFfsCHJZAJ
	Ev3DMmj6U+ui+LFRNnPLSGdxZ8g==
X-Google-Smtp-Source: AGHT+IGS1UB7/FDR/BcBqk2KmSNENsJh45do3ySj1eHmDLtGTBFP0555o21mswrv70mKmS3pg6fADypCryWXcbX+YlY=
X-Received: by 2002:adf:b345:0:b0:37d:2d27:cd93 with SMTP id
 ffacd0b85a97d-380612008dbmr12929968f8f.43.1730328515759; Wed, 30 Oct 2024
 15:48:35 -0700 (PDT)
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
 <B67E796E-1539-437C-9F54-091D178E0171@oracle.com> <CALXu0Uf4DfcgOqExZ8RYeHY8-fx_fzqCsqAUJogV2Dx8DMgJzQ@mail.gmail.com>
 <2FAFA39C-09C0-4FCC-948F-B6D0518BE5B5@oracle.com>
In-Reply-To: <2FAFA39C-09C0-4FCC-948F-B6D0518BE5B5@oracle.com>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Wed, 30 Oct 2024 15:48:25 -0700
Message-ID: <CAM5tNy5yyiE-e4gN50daU06xLjB8Z=SWrz1W9pMJ8am5vPeYCw@mail.gmail.com>
Subject: Re: [PATCH v3] nfsd: disallow file locking and delegations for NFSv4 reexport
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Cedric Blancher <cedric.blancher@gmail.com>, 
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 10:08=E2=80=AFAM Chuck Lever III <chuck.lever@oracl=
e.com> wrote:
>
> CAUTION: This email originated from outside of the University of Guelph. =
Do not click links or open attachments unless you recognize the sender and =
know the content is safe. If in doubt, forward suspicious emails to IThelp@=
uoguelph.ca.
>
>
>
>
> > On Oct 30, 2024, at 12:37=E2=80=AFPM, Cedric Blancher <cedric.blancher@=
gmail.com> wrote:
> >
> > On Wed, 30 Oct 2024 at 17:15, Chuck Lever III <chuck.lever@oracle.com> =
wrote:
> >>
> >>
> >>
> >>> On Oct 30, 2024, at 10:55=E2=80=AFAM, Cedric Blancher <cedric.blanche=
r@gmail.com> wrote:
> >>>
> >>> On Tue, 29 Oct 2024 at 17:03, Chuck Lever III <chuck.lever@oracle.com=
> wrote:
> >>>>
> >>>>> On Oct 29, 2024, at 11:54=E2=80=AFAM, Brian Cowan <brian.cowan@hcl-=
software.com> wrote:
> >>>>>
> >>>>> Honestly, I don't know the usecase for re-exporting another server'=
s
> >>>>> NFS export in the first place. Is this someone trying to share NFS
> >>>>> through a firewall? I've seen people share remote NFS exports via
> >>>>> Samba in an attempt to avoid paying their NAS vendor for SMB suppor=
t.
> >>>>> (I think it's "standard equipment" now, but 10+ years ago? Not
> >>>>> always...) But re-exporting another server's NFS exports? Haven't s=
een
> >>>>> anyone do that in a while.
> >>>>
> >>>> The "re-export" case is where there is a central repository
> >>>> of data and branch offices that access that via a WAN. The
> >>>> re-export servers cache some of that data locally so that
> >>>> local clients have a fast persistent cache nearby.
> >>>>
> >>>> This is also effective in cases where a small cluster of
> >>>> clients want fast access to a pile of data that is
> >>>> significantly larger than their own caches. Say, HPC or
> >>>> animation, where the small cluster is working on a small
> >>>> portion of the full data set, which is stored on a central
> >>>> server.
> >>>>
> >>> Another use case is "isolation", IT shares a filesystem to your
> >>> department, and you need to re-export only a subset to another
> >>> department or homeoffice. Part of such a scenario might also be polic=
y
> >>> related, e.g. IT shares you the full filesystem but will do NOTHING
> >>> else, and any further compartmentalization must be done in your own
> >>> department.
> >>> This is the typical use case for gov NFS re-export.
> >>
> >> It's not clear to me from this description why re-export is
> >> the right tool for this job. Please explain why ACLs are not
> >> used in this case -- this is exactly what they are designed
> >> to do.
> >
> > 1. IT departments want better/harder/immutable isolation than ACLs
>
> So you want MAC, and the storage administrator won't set
> that up for you on the NFS server. NFS doesn't do MAC
> very well if at all.
>
>
> > 2. Linux NFSv4 only implements POSIX draft ACLs, not full Windows or
> > NFSv4 ACLs. So there is no proper way to prevent ACL editing,
> > rendering them useless in this case.
>
> Er. Linux NFSv4 stores the ACLs as POSIX draft, because
> that's what Linux file systems can support. NFSD, via
> NFSv4, makes these appear like NFSv4 ACLs.
>
> But I think I understand.
>
>
> > There is a reason why POSIX draft ACls were abandoned - they are not
> > fine-granted enough for real world usage outside the Linux universe.
> > As soon as interoperability is required these things just bite you
> > HARD.
>
> You, of course, have the ability to run some other NFS
> server implementation that meets your security requirements
> more fully.
>
>
> > Also, just running more nfsd in parallel on the origin NFS server is
> > not a better option - remember the debate of non-2049 ports for nfsd?
>
> I'm not sure where this is going. Do you mean the storage
> administrator would provide NFS service on alternate
> ports that each expose a separate set of exports?
>
> So the only option Linux has there is using containers or
> libvirt. We've continued to privately discuss the ability
> for NFSD to support a separate set of exports on alternate
> ports, but it doesn't look feasible. The export management
> infrastructure and user space tools would need to be
> rewritten.
>
>
> >> And again, clients of the re-export server need to mount it
> >> with local_lock. Apps can still use locking in that case,
> >> but the locks are not visible to apps on other clients. Your
> >> description does not explain why local_lock is not
> >> sufficient or feasible.
> >
> > Because:
> > - it breaks applications running on more than one machine?
>
> Yes, obviously. Your description needs to mention that is
> a requirement, since there are a lot of applications that
> don't need locking across multiple clients.
>
>
> > - it breaks use cases like NFS--->SMB bridges, because without locking
> > the typical Windows .NET application will refuse to write to a file
>
> That's a quagmire, and I don't think we can guarantee that
> will work. Linux NFS doesn't support "deny" modes, for
> example.
>
>
> > - it breaks even SIMPLE things like Microsoft Excel
>
> If you need SMB semantics, why not use Samba?
>
> The upshot appears to be that this usage is a stack of
> mismatched storage protocols that work around a bunch of
> local IT bureaucracy. I'm trying to be sympathetic, but
> it's hard to say that /anyone/ would fully support this.
>
>
> > Of course the happy echo "hello Linux-NFSv4-only world" >/nfs/file
> > will always work.
> >
> >>> Of course no one needs the gov customers, so feel free to break locki=
ng.
> >>
> >>
> >> Please have a look at the patch description again: lock
> >> recovery does not work now, and cannot work without
> >> changes to the protocol. Isn't that a problem for such
> >> workloads?
> >
> > Nope, because of UPS (Uninterruptible power supply). Either everything
> > is UP, or *everything* is DOWN. Boolean.
>
> Power outages are not the only reason lock recovery might
> be necessary. Network partitions, re-export server
> upgrades or reboots, etc. So I'm not hearing anythying
> to suggest this kind of workload is not impacted by
> the current lock recovery problems.
>
>
> >> In other words, locking is already broken on NFSv4 re-export,
> >> but the current situation can lead to silent data corruption.
> >
> > Would storing the locking information into persistent files help, ie.
> > files which persist across nfsd server restarts?
>
> Yes, but it would make things horribly slow.
>
> And of course there would be a lot of coding involved
> to get this to work.
I suspect this suggestion might be a fair amount of code too
(and I am certainly not volunteering to write it), but I will mention it.

Another possibility would be to have the re-exporting NFSv4 server
just pass locking ops through to the backend NFSv4 server.
- It is roughly the inverse of what I did when I constructed a flex files
  pNFS server. The MDS did the locking ops and any I/O ops. were
  passed through to the DS(s). Of course, it was hoped the client
  would use layouts and bypass the MDS for I/O.

rick

>
> What if we added an export option to allow the re-export
> server to continue handling locking, but default it to
> off (which is the safer option) ?
>
> --
> Chuck Lever
>
>

