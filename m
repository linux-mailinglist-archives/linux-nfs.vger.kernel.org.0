Return-Path: <linux-nfs+bounces-7604-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 920A89B7D45
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Oct 2024 15:48:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3A731C20FA0
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Oct 2024 14:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E3E19D07E;
	Thu, 31 Oct 2024 14:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lQN8UICs"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DAE19AD78
	for <linux-nfs@vger.kernel.org>; Thu, 31 Oct 2024 14:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730386126; cv=none; b=mRZg3ffcQ61w1y/XAxL1bBuPFiShyehjkoVp+38BFGvGjAN3fUFUsnL1IxOcUdg13Pb1AhirdFr+B4nHq8ew/BKbhGmzWcCN7ty316+dcEleFRnUe9Up8MjaQxTFfmq/7NelbzeUNCg4WXn0xYUbm9vjpVSPR0MoxZOtG1t2hto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730386126; c=relaxed/simple;
	bh=xxRRzOzMZkmjCGOYISmwPkygUlBXT93yh94HISnYPUA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fC+TcJ/uFinYZrSPad5ZDIGqHaPYXResNYXYZ4ZnFwQ3vqUXllA4jE8huSwyUB/+hRuuFgx4E2RLkzKkkX3mnQNtxw0+dhSMaWcQxSIE7T3UvLaTMFWZ/q1EcHbSuz7RSny9KbCC93ykLimXBkGsB3CFC0JLFfO6g8bICtmqLyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lQN8UICs; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c937b5169cso1668222a12.1
        for <linux-nfs@vger.kernel.org>; Thu, 31 Oct 2024 07:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730386122; x=1730990922; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nr95+LPpfQ2PqwTOdn5x6PJe5PdcCOPKM7eWKMmW6xI=;
        b=lQN8UICs6xRXGUgXMkAAhbdRplqYoG+U1n1eIbOYVQVajIvOSBm2yA8Qa2J46IFHsq
         jqPK0s1j28j4s51tS+ey6QTAC4AJSmdAd9VijnU0D9D3r7MzZ6qC++iVI+doP1kd2uKl
         AE56d+k1nk0aeb1f/gA8wZBeTaEQZI2Yr90DK7tHyJK3UAsTEo3DsPCe1uSH7qqUt6bh
         3auYsKXJz/NgmulDBYFOB4SFP/ub/2zq0zU86LeyW8+frdctzmPpDk45dQyFzqja/fYU
         LhMqWyfF2J49j7uFtmEgGWMzxvxXvQRdLgY+FaEqgj146hMKHkbug8rbI9TCjvWdLThf
         h4nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730386122; x=1730990922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nr95+LPpfQ2PqwTOdn5x6PJe5PdcCOPKM7eWKMmW6xI=;
        b=hYzVz+QfGV6ZNDPF5u7EA24ZObZsDtrPL632TMiRfZ+ru6l5I/eh9CqEu31apdVpav
         bIBDtk/B90aFpLf4GUjalEncPRkZNanUzSuUlPMXntto3WsYTkD4aUKUSQqDULvJZyJy
         2MPcdyWKVemCUIuas2uyRF/GiDmDBNp1f+yXSY57MmMtd4ClWzNkX7Y5o3Z3771dJROU
         RZdCtT+rlPrTFYewWdnd2pUzKL1VeZFS7S1c9dok8Wf6BodYGnLEn0XN0pUBX3YwxhAw
         pmi6LWZHYqAg6YpKgZBDUCsW3Gsh5EA+Y+WJa/818AZ2OMSs+dhuaBd2NzsuvVqutp0x
         ZxLw==
X-Forwarded-Encrypted: i=1; AJvYcCUlDIajDw03bQn5p6b0QDuf/3zsnYVa50s/tR4I8g3QqudQZLPp4krQtVG8/Dri/1vs0JYEhERU3JU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc/ezdeTkT707VAFdSLBhv96GSPTZm9xEUOwilmZfs//nr+L7H
	oe7asFMhO9O8b6dgj0ogj+KZgAsr234P4Ohk44W6rfEP72fb9iX2LbTjWyiVZ5idPWj9aWe2Jk7
	2CauoFFac5mXBGe8SVqQ3cErMpg==
X-Google-Smtp-Source: AGHT+IGLSyQAB0d45USOK2868cm0FvKl6lEDme7gdTmCCS2Z4B8PUsYaHdqGgfSsfGcfwfAvzZMp9vRo4W7uAcOWPkY=
X-Received: by 2002:a05:6402:234e:b0:5ce:b8ee:4191 with SMTP id
 4fb4d7f45d1cf-5ceb8ee420cmr226463a12.12.1730386122031; Thu, 31 Oct 2024
 07:48:42 -0700 (PDT)
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
 <2FAFA39C-09C0-4FCC-948F-B6D0518BE5B5@oracle.com> <CAM5tNy5yyiE-e4gN50daU06xLjB8Z=SWrz1W9pMJ8am5vPeYCw@mail.gmail.com>
 <0f27eb1d81cefcb791f26ad8619deec6df80f94b.camel@kernel.org>
In-Reply-To: <0f27eb1d81cefcb791f26ad8619deec6df80f94b.camel@kernel.org>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Thu, 31 Oct 2024 07:48:32 -0700
Message-ID: <CAM5tNy78G02014XAETh0AB1oTHE6YQhF0g9UyXAC5_k5J7rhYw@mail.gmail.com>
Subject: Re: [PATCH v3] nfsd: disallow file locking and delegations for NFSv4 reexport
To: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever III <chuck.lever@oracle.com>, Cedric Blancher <cedric.blancher@gmail.com>, 
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 4:43=E2=80=AFAM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> On Wed, 2024-10-30 at 15:48 -0700, Rick Macklem wrote:
> > On Wed, Oct 30, 2024 at 10:08=E2=80=AFAM Chuck Lever III <chuck.lever@o=
racle.com> wrote:
> > >
> > > CAUTION: This email originated from outside of the University of Guel=
ph. Do not click links or open attachments unless you recognize the sender =
and know the content is safe. If in doubt, forward suspicious emails to ITh=
elp@uoguelph.ca.
> > >
> > >
> > >
> > >
> > > > On Oct 30, 2024, at 12:37=E2=80=AFPM, Cedric Blancher <cedric.blanc=
her@gmail.com> wrote:
> > > >
> > > > On Wed, 30 Oct 2024 at 17:15, Chuck Lever III <chuck.lever@oracle.c=
om> wrote:
> > > > >
> > > > >
> > > > >
> > > > > > On Oct 30, 2024, at 10:55=E2=80=AFAM, Cedric Blancher <cedric.b=
lancher@gmail.com> wrote:
> > > > > >
> > > > > > On Tue, 29 Oct 2024 at 17:03, Chuck Lever III <chuck.lever@orac=
le.com> wrote:
> > > > > > >
> > > > > > > > On Oct 29, 2024, at 11:54=E2=80=AFAM, Brian Cowan <brian.co=
wan@hcl-software.com> wrote:
> > > > > > > >
> > > > > > > > Honestly, I don't know the usecase for re-exporting another=
 server's
> > > > > > > > NFS export in the first place. Is this someone trying to sh=
are NFS
> > > > > > > > through a firewall? I've seen people share remote NFS expor=
ts via
> > > > > > > > Samba in an attempt to avoid paying their NAS vendor for SM=
B support.
> > > > > > > > (I think it's "standard equipment" now, but 10+ years ago? =
Not
> > > > > > > > always...) But re-exporting another server's NFS exports? H=
aven't seen
> > > > > > > > anyone do that in a while.
> > > > > > >
> > > > > > > The "re-export" case is where there is a central repository
> > > > > > > of data and branch offices that access that via a WAN. The
> > > > > > > re-export servers cache some of that data locally so that
> > > > > > > local clients have a fast persistent cache nearby.
> > > > > > >
> > > > > > > This is also effective in cases where a small cluster of
> > > > > > > clients want fast access to a pile of data that is
> > > > > > > significantly larger than their own caches. Say, HPC or
> > > > > > > animation, where the small cluster is working on a small
> > > > > > > portion of the full data set, which is stored on a central
> > > > > > > server.
> > > > > > >
> > > > > > Another use case is "isolation", IT shares a filesystem to your
> > > > > > department, and you need to re-export only a subset to another
> > > > > > department or homeoffice. Part of such a scenario might also be=
 policy
> > > > > > related, e.g. IT shares you the full filesystem but will do NOT=
HING
> > > > > > else, and any further compartmentalization must be done in your=
 own
> > > > > > department.
> > > > > > This is the typical use case for gov NFS re-export.
> > > > >
> > > > > It's not clear to me from this description why re-export is
> > > > > the right tool for this job. Please explain why ACLs are not
> > > > > used in this case -- this is exactly what they are designed
> > > > > to do.
> > > >
> > > > 1. IT departments want better/harder/immutable isolation than ACLs
> > >
> > > So you want MAC, and the storage administrator won't set
> > > that up for you on the NFS server. NFS doesn't do MAC
> > > very well if at all.
> > >
> > >
> > > > 2. Linux NFSv4 only implements POSIX draft ACLs, not full Windows o=
r
> > > > NFSv4 ACLs. So there is no proper way to prevent ACL editing,
> > > > rendering them useless in this case.
> > >
> > > Er. Linux NFSv4 stores the ACLs as POSIX draft, because
> > > that's what Linux file systems can support. NFSD, via
> > > NFSv4, makes these appear like NFSv4 ACLs.
> > >
> > > But I think I understand.
> > >
> > >
> > > > There is a reason why POSIX draft ACls were abandoned - they are no=
t
> > > > fine-granted enough for real world usage outside the Linux universe=
.
> > > > As soon as interoperability is required these things just bite you
> > > > HARD.
> > >
> > > You, of course, have the ability to run some other NFS
> > > server implementation that meets your security requirements
> > > more fully.
> > >
> > >
> > > > Also, just running more nfsd in parallel on the origin NFS server i=
s
> > > > not a better option - remember the debate of non-2049 ports for nfs=
d?
> > >
> > > I'm not sure where this is going. Do you mean the storage
> > > administrator would provide NFS service on alternate
> > > ports that each expose a separate set of exports?
> > >
> > > So the only option Linux has there is using containers or
> > > libvirt. We've continued to privately discuss the ability
> > > for NFSD to support a separate set of exports on alternate
> > > ports, but it doesn't look feasible. The export management
> > > infrastructure and user space tools would need to be
> > > rewritten.
> > >
> > >
> > > > > And again, clients of the re-export server need to mount it
> > > > > with local_lock. Apps can still use locking in that case,
> > > > > but the locks are not visible to apps on other clients. Your
> > > > > description does not explain why local_lock is not
> > > > > sufficient or feasible.
> > > >
> > > > Because:
> > > > - it breaks applications running on more than one machine?
> > >
> > > Yes, obviously. Your description needs to mention that is
> > > a requirement, since there are a lot of applications that
> > > don't need locking across multiple clients.
> > >
> > >
> > > > - it breaks use cases like NFS--->SMB bridges, because without lock=
ing
> > > > the typical Windows .NET application will refuse to write to a file
> > >
> > > That's a quagmire, and I don't think we can guarantee that
> > > will work. Linux NFS doesn't support "deny" modes, for
> > > example.
> > >
> > >
> > > > - it breaks even SIMPLE things like Microsoft Excel
> > >
> > > If you need SMB semantics, why not use Samba?
> > >
> > > The upshot appears to be that this usage is a stack of
> > > mismatched storage protocols that work around a bunch of
> > > local IT bureaucracy. I'm trying to be sympathetic, but
> > > it's hard to say that /anyone/ would fully support this.
> > >
> > >
> > > > Of course the happy echo "hello Linux-NFSv4-only world" >/nfs/file
> > > > will always work.
> > > >
> > > > > > Of course no one needs the gov customers, so feel free to break=
 locking.
> > > > >
> > > > >
> > > > > Please have a look at the patch description again: lock
> > > > > recovery does not work now, and cannot work without
> > > > > changes to the protocol. Isn't that a problem for such
> > > > > workloads?
> > > >
> > > > Nope, because of UPS (Uninterruptible power supply). Either everyth=
ing
> > > > is UP, or *everything* is DOWN. Boolean.
> > >
> > > Power outages are not the only reason lock recovery might
> > > be necessary. Network partitions, re-export server
> > > upgrades or reboots, etc. So I'm not hearing anythying
> > > to suggest this kind of workload is not impacted by
> > > the current lock recovery problems.
> > >
> > >
> > > > > In other words, locking is already broken on NFSv4 re-export,
> > > > > but the current situation can lead to silent data corruption.
> > > >
> > > > Would storing the locking information into persistent files help, i=
e.
> > > > files which persist across nfsd server restarts?
> > >
> > > Yes, but it would make things horribly slow.
> > >
> > > And of course there would be a lot of coding involved
> > > to get this to work.
> > I suspect this suggestion might be a fair amount of code too
> > (and I am certainly not volunteering to write it), but I will mention i=
t.
> >
> > Another possibility would be to have the re-exporting NFSv4 server
> > just pass locking ops through to the backend NFSv4 server.
> > - It is roughly the inverse of what I did when I constructed a flex fil=
es
> >   pNFS server. The MDS did the locking ops and any I/O ops. were
> >   passed through to the DS(s). Of course, it was hoped the client
> >   would use layouts and bypass the MDS for I/O.
> >
>
> How do you handle reclaim in this case? IOW, suppose the backend server
> crashes but the reexporter stays up. How do you coordinate the grace
> periods between the two so that the client can reclaim its lock on the
> backend?
Well, I'm not saying it is trivial.
I think you would need to pass through all state operations:
ExchangeID, Open,...,Lock,LockU
- The tricky bit would be sessions, since the re-exporter would need to
   maintain sessions.
   --> Maybe the re-exporter would need to save the ClientID (from the
         backend nfsd) in non-volatile storage.

When the backend server crashes/reboots, the re-exporter would see
this as a failure (usually NFS4ERR_BAD_SESSION) and would pass
that to the client.
The only recovery RPC that would not be passed through would be
Create_session, although the re-exporter would do a Create_session
for connection(s) it has against the backend server.
I think something like that would work for the backend crash/recovery.

A crash of the re-exporter could be more of a problem, I think.
It would need to have the ClientID (stored in non-volatile storage)
so that it could do a Create_session with it against the backend server.
- It would also depend on the backend server being courteous, so that
  an re-exporter crash/reboot that takes a while such that the lease expire=
s
  doesn't result in a loss of state on the backend server.

Anyhow, something like that.
Like I said, I'm not volunteering to code it, rick

>
> >
> > >
> > > What if we added an export option to allow the re-export
> > > server to continue handling locking, but default it to
> > > off (which is the safer option) ?
> > >
> > > --
> > > Chuck Lever
> > >
> > >
> >
>
> --
> Jeff Layton <jlayton@kernel.org>

