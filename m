Return-Path: <linux-nfs+bounces-7608-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41CB89B7F95
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Oct 2024 17:03:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B97C21F25C70
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Oct 2024 16:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEABD1B86D5;
	Thu, 31 Oct 2024 16:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xlr+mymh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F6B1B5325
	for <linux-nfs@vger.kernel.org>; Thu, 31 Oct 2024 16:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730390617; cv=none; b=pxOIf3Nyf5aTwfx2Esovh0Nn/SbuPOJEUbVVB+ApL9Z/bmMqXpzpejtfwa9t2YltPeoCLSr0HlDc7qOW0SdNTJ5wGYFcm1zh5vy5ZywNn6UTOmCHkW2P+7vR9nGTkcW7hzxEUpF6Yg+HUgJNoC3Y9ZHrZUQA23HA8kT8us+wU6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730390617; c=relaxed/simple;
	bh=NALVlEl/Fn5kVMSnI3ZpHMLd2rogP0fihJ7n1NPtcCU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HGbFAUDn41IAgIUVc0TVjxOph2pMrKNuxsC+p1l97MT5kcVz9EAlzdvhtheQiPN3llHhJ+eOXcECnlcMdvFU+oKED0NC85+FMSQStcDcLch3rj0FxtLdtsneY8gjFsxovYub+I9jdJa38Os1VJRfVCiTfz8rzfzJoWJCkZ3ON0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xlr+mymh; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6e3b7b3e9acso8940367b3.1
        for <linux-nfs@vger.kernel.org>; Thu, 31 Oct 2024 09:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730390614; x=1730995414; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OvqAauleeZQuIcxAThJQDp0O8juX+v3FlowaGcrxVns=;
        b=Xlr+mymhGYBRQZ37m0y4uHQkJX+IKJ5Qjm2aT22NYZQWyvj8TamKW+pHayBYJmvab/
         tOqtcCRWLZM2Objr+36TckRckj5OSjN4kNcPR36MYWhrCC6nL8CdMEMfQ298dr2EXBUY
         xWbRTQmX2iyzbGjQ4/QpEpI5oYx2gMATnaPpsOoz3Y2gwNLCu6myHTv0GBgfZ8AgS9yr
         +OWAp4g4KFe1T8Hz/pRNmMB6hNe1dA5zEg2OvusjZhrelW5toobowtgKOis2bP6okHSx
         BRYDUzCE83l8v+IWxJCqR5qKRXQDX6Y86+gxih9+FQ78hZpudPIetDfvkJNz5zG7qTLv
         GzJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730390614; x=1730995414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OvqAauleeZQuIcxAThJQDp0O8juX+v3FlowaGcrxVns=;
        b=k+0e1Q/GObMJzhv9ndYSJpaaayqsgIYOjtrNFmhTOJocUZwUkGT/Q6ixQFNk5P1rRB
         MoFzxIMddzUgX0C7DcRuVFK2SDunVbhBmjmBgW8QF9FqQMVIfdUoofyW27QDZm04kNgL
         Wb7JvYzjNjcfDcdF1iVXsfLdNUr2PDfrY5oWh2u13ZlI2kGsKgq8HvU6oqOQaEH6N6It
         +ZbxN+zDxyogkGcYvbwyCHDiuM5uwAlZNWH8YeNRhU+gKKjV1/PF8uTS812fY0JSrltR
         ywHlRhHB9SmIUQslKJSDZOdMs0nwvcTf2ayCvO63zfJyhIgD3Dl2aGerb8zrAkYGcHTB
         dzMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhQ5679zW0JXx+ESjY/dyUpYZ6ZsU1F7cHugAvI/OIiqXrMPxnrso4qi1Mq2nvjQ7pzrh2UKBpO00=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVM2b0hDhQGoj0JAYV2zDiP3v8WLl3z2EpmON3orDlB37/YMvF
	olMZdn9sHQqbvp5ijS0jgnQ/VzGBlfcN9AEYuPSEHe8fiAFel9yRPZwCMBByyPJ+HCTrTjdXUF9
	mB2Gwn/LppZWCaqMFrirYy4mKkg==
X-Google-Smtp-Source: AGHT+IG/pCJJL4L2c1+kKyord6f37KEqV8KpU4/3gyRhEEY6qr2C+eXU1kw4b/mVAV47zG+1gkhdZ2hbz873XMKZJQ8=
X-Received: by 2002:a05:690c:3587:b0:6e2:313a:a022 with SMTP id
 00721157ae682-6ea64bdd2fcmr4791377b3.33.1730390613471; Thu, 31 Oct 2024
 09:03:33 -0700 (PDT)
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
 <CAM5tNy78G02014XAETh0AB1oTHE6YQhF0g9UyXAC5_k5J7rhYw@mail.gmail.com> <DBDD309B-BCEF-4F35-86FD-7B2743FA6084@oracle.com>
In-Reply-To: <DBDD309B-BCEF-4F35-86FD-7B2743FA6084@oracle.com>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Thu, 31 Oct 2024 09:02:58 -0700
Message-ID: <CAM5tNy4tMYK0LNc5b=Ed5JFTwd2fznDiFmzvxzb5dhqZ+hx-Bw@mail.gmail.com>
Subject: Re: [PATCH v3] nfsd: disallow file locking and delegations for NFSv4 reexport
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>, Cedric Blancher <cedric.blancher@gmail.com>, 
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 8:01=E2=80=AFAM Chuck Lever III <chuck.lever@oracle=
.com> wrote:
>
>
>
> > On Oct 31, 2024, at 10:48=E2=80=AFAM, Rick Macklem <rick.macklem@gmail.=
com> wrote:
> >
> > On Thu, Oct 31, 2024 at 4:43=E2=80=AFAM Jeff Layton <jlayton@kernel.org=
> wrote:
> >>
> >> On Wed, 2024-10-30 at 15:48 -0700, Rick Macklem wrote:
> >>> On Wed, Oct 30, 2024 at 10:08=E2=80=AFAM Chuck Lever III <chuck.lever=
@oracle.com> wrote:
> >>>>
> >>>> CAUTION: This email originated from outside of the University of Gue=
lph. Do not click links or open attachments unless you recognize the sender=
 and know the content is safe. If in doubt, forward suspicious emails to IT=
help@uoguelph.ca.
> >>>>
> >>>>
> >>>>
> >>>>
> >>>>> On Oct 30, 2024, at 12:37=E2=80=AFPM, Cedric Blancher <cedric.blanc=
her@gmail.com> wrote:
> >>>>>
> >>>>> On Wed, 30 Oct 2024 at 17:15, Chuck Lever III <chuck.lever@oracle.c=
om> wrote:
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>>> On Oct 30, 2024, at 10:55=E2=80=AFAM, Cedric Blancher <cedric.bla=
ncher@gmail.com> wrote:
> >>>>>>>
> >>>>>>> On Tue, 29 Oct 2024 at 17:03, Chuck Lever III <chuck.lever@oracle=
.com> wrote:
> >>>>>>>>
> >>>>>>>>> On Oct 29, 2024, at 11:54=E2=80=AFAM, Brian Cowan <brian.cowan@=
hcl-software.com> wrote:
> >>>>>>>>>
> >>>>>>>>> Honestly, I don't know the usecase for re-exporting another ser=
ver's
> >>>>>>>>> NFS export in the first place. Is this someone trying to share =
NFS
> >>>>>>>>> through a firewall? I've seen people share remote NFS exports v=
ia
> >>>>>>>>> Samba in an attempt to avoid paying their NAS vendor for SMB su=
pport.
> >>>>>>>>> (I think it's "standard equipment" now, but 10+ years ago? Not
> >>>>>>>>> always...) But re-exporting another server's NFS exports? Haven=
't seen
> >>>>>>>>> anyone do that in a while.
> >>>>>>>>
> >>>>>>>> The "re-export" case is where there is a central repository
> >>>>>>>> of data and branch offices that access that via a WAN. The
> >>>>>>>> re-export servers cache some of that data locally so that
> >>>>>>>> local clients have a fast persistent cache nearby.
> >>>>>>>>
> >>>>>>>> This is also effective in cases where a small cluster of
> >>>>>>>> clients want fast access to a pile of data that is
> >>>>>>>> significantly larger than their own caches. Say, HPC or
> >>>>>>>> animation, where the small cluster is working on a small
> >>>>>>>> portion of the full data set, which is stored on a central
> >>>>>>>> server.
> >>>>>>>>
> >>>>>>> Another use case is "isolation", IT shares a filesystem to your
> >>>>>>> department, and you need to re-export only a subset to another
> >>>>>>> department or homeoffice. Part of such a scenario might also be p=
olicy
> >>>>>>> related, e.g. IT shares you the full filesystem but will do NOTHI=
NG
> >>>>>>> else, and any further compartmentalization must be done in your o=
wn
> >>>>>>> department.
> >>>>>>> This is the typical use case for gov NFS re-export.
> >>>>>>
> >>>>>> It's not clear to me from this description why re-export is
> >>>>>> the right tool for this job. Please explain why ACLs are not
> >>>>>> used in this case -- this is exactly what they are designed
> >>>>>> to do.
> >>>>>
> >>>>> 1. IT departments want better/harder/immutable isolation than ACLs
> >>>>
> >>>> So you want MAC, and the storage administrator won't set
> >>>> that up for you on the NFS server. NFS doesn't do MAC
> >>>> very well if at all.
> >>>>
> >>>>
> >>>>> 2. Linux NFSv4 only implements POSIX draft ACLs, not full Windows o=
r
> >>>>> NFSv4 ACLs. So there is no proper way to prevent ACL editing,
> >>>>> rendering them useless in this case.
> >>>>
> >>>> Er. Linux NFSv4 stores the ACLs as POSIX draft, because
> >>>> that's what Linux file systems can support. NFSD, via
> >>>> NFSv4, makes these appear like NFSv4 ACLs.
> >>>>
> >>>> But I think I understand.
> >>>>
> >>>>
> >>>>> There is a reason why POSIX draft ACls were abandoned - they are no=
t
> >>>>> fine-granted enough for real world usage outside the Linux universe=
.
> >>>>> As soon as interoperability is required these things just bite you
> >>>>> HARD.
> >>>>
> >>>> You, of course, have the ability to run some other NFS
> >>>> server implementation that meets your security requirements
> >>>> more fully.
> >>>>
> >>>>
> >>>>> Also, just running more nfsd in parallel on the origin NFS server i=
s
> >>>>> not a better option - remember the debate of non-2049 ports for nfs=
d?
> >>>>
> >>>> I'm not sure where this is going. Do you mean the storage
> >>>> administrator would provide NFS service on alternate
> >>>> ports that each expose a separate set of exports?
> >>>>
> >>>> So the only option Linux has there is using containers or
> >>>> libvirt. We've continued to privately discuss the ability
> >>>> for NFSD to support a separate set of exports on alternate
> >>>> ports, but it doesn't look feasible. The export management
> >>>> infrastructure and user space tools would need to be
> >>>> rewritten.
> >>>>
> >>>>
> >>>>>> And again, clients of the re-export server need to mount it
> >>>>>> with local_lock. Apps can still use locking in that case,
> >>>>>> but the locks are not visible to apps on other clients. Your
> >>>>>> description does not explain why local_lock is not
> >>>>>> sufficient or feasible.
> >>>>>
> >>>>> Because:
> >>>>> - it breaks applications running on more than one machine?
> >>>>
> >>>> Yes, obviously. Your description needs to mention that is
> >>>> a requirement, since there are a lot of applications that
> >>>> don't need locking across multiple clients.
> >>>>
> >>>>
> >>>>> - it breaks use cases like NFS--->SMB bridges, because without lock=
ing
> >>>>> the typical Windows .NET application will refuse to write to a file
> >>>>
> >>>> That's a quagmire, and I don't think we can guarantee that
> >>>> will work. Linux NFS doesn't support "deny" modes, for
> >>>> example.
> >>>>
> >>>>
> >>>>> - it breaks even SIMPLE things like Microsoft Excel
> >>>>
> >>>> If you need SMB semantics, why not use Samba?
> >>>>
> >>>> The upshot appears to be that this usage is a stack of
> >>>> mismatched storage protocols that work around a bunch of
> >>>> local IT bureaucracy. I'm trying to be sympathetic, but
> >>>> it's hard to say that /anyone/ would fully support this.
> >>>>
> >>>>
> >>>>> Of course the happy echo "hello Linux-NFSv4-only world" >/nfs/file
> >>>>> will always work.
> >>>>>
> >>>>>>> Of course no one needs the gov customers, so feel free to break l=
ocking.
> >>>>>>
> >>>>>>
> >>>>>> Please have a look at the patch description again: lock
> >>>>>> recovery does not work now, and cannot work without
> >>>>>> changes to the protocol. Isn't that a problem for such
> >>>>>> workloads?
> >>>>>
> >>>>> Nope, because of UPS (Uninterruptible power supply). Either everyth=
ing
> >>>>> is UP, or *everything* is DOWN. Boolean.
> >>>>
> >>>> Power outages are not the only reason lock recovery might
> >>>> be necessary. Network partitions, re-export server
> >>>> upgrades or reboots, etc. So I'm not hearing anythying
> >>>> to suggest this kind of workload is not impacted by
> >>>> the current lock recovery problems.
> >>>>
> >>>>
> >>>>>> In other words, locking is already broken on NFSv4 re-export,
> >>>>>> but the current situation can lead to silent data corruption.
> >>>>>
> >>>>> Would storing the locking information into persistent files help, i=
e.
> >>>>> files which persist across nfsd server restarts?
> >>>>
> >>>> Yes, but it would make things horribly slow.
> >>>>
> >>>> And of course there would be a lot of coding involved
> >>>> to get this to work.
> >>> I suspect this suggestion might be a fair amount of code too
> >>> (and I am certainly not volunteering to write it), but I will mention=
 it.
> >>>
> >>> Another possibility would be to have the re-exporting NFSv4 server
> >>> just pass locking ops through to the backend NFSv4 server.
> >>> - It is roughly the inverse of what I did when I constructed a flex f=
iles
> >>>  pNFS server. The MDS did the locking ops and any I/O ops. were
> >>>  passed through to the DS(s). Of course, it was hoped the client
> >>>  would use layouts and bypass the MDS for I/O.
> >>>
> >>
> >> How do you handle reclaim in this case? IOW, suppose the backend serve=
r
> >> crashes but the reexporter stays up. How do you coordinate the grace
> >> periods between the two so that the client can reclaim its lock on the
> >> backend?
> > Well, I'm not saying it is trivial.
> > I think you would need to pass through all state operations:
> > ExchangeID, Open,...,Lock,LockU
> > - The tricky bit would be sessions, since the re-exporter would need to
> >   maintain sessions.
> >   --> Maybe the re-exporter would need to save the ClientID (from the
> >         backend nfsd) in non-volatile storage.
> >
> > When the backend server crashes/reboots, the re-exporter would see
> > this as a failure (usually NFS4ERR_BAD_SESSION) and would pass
> > that to the client.
> > The only recovery RPC that would not be passed through would be
> > Create_session, although the re-exporter would do a Create_session
> > for connection(s) it has against the backend server.
> > I think something like that would work for the backend crash/recovery.
>
> The backend server would be in grace, and the re-exporter
> would be able to recover its lock state on the backend
> server using normal state recovery. I think the re-
> exporter would not need to expose the backend server's
> crash to its own clients.
For what I suggested, the re-exporting server does not hold any state,
except for sessions. (It essentially becomes like an NFSv3 stateless
server.) It would expose the backend server's crash/reboot to the
client, which would do the recovery.
(By pass through I mean "just repackage the arguments and do
the operation against the backend server" instead of doing the
operations in the re-exporter server. For example, it would have
a separate "struct nfsd4_operations" array with different functions
for open, lock, ...)

Sessions are the weird case and the re-exporter would have to
maintain session(s) for the client. On backend server reboot, the
re-exporter would see NFS4ERR_BAD_SESSION. It would then
nuke the session(s) for the client, so that it sees NFS4ERR_BAD_SESSION
as well and starts state recovery. Those state recovery ops would
be passed through to the backend server.

When the re-exporter reboots, it only needs to recover sessions.
It would reply NFS4ERR_BAD_SESSION to the client.
The client would do a Create_session using the backend server's
clientID. At that point, the re-exporter would know the clientID, which
it could use to Create_session against the backend server and then
it could create the session for the client side, assuming the Create_sessio=
n
on the backend server worked ok.

rick

>
>
> > A crash of the re-exporter could be more of a problem, I think.
> > It would need to have the ClientID (stored in non-volatile storage)
> > so that it could do a Create_session with it against the backend server=
.
> > - It would also depend on the backend server being courteous, so that
> >  an re-exporter crash/reboot that takes a while such that the lease exp=
ires
> >  doesn't result in a loss of state on the backend server.
>
> The backend server would not be in grace after the re-export
> server crashes. There's no way for the re-export server's
> NFS client to recover its lock state from the backend server.
>
> The re-export server recovers by re-learning lock state from
> its own clients. The question is how the re-export server
> could re-initialize this state in its local client of the
> backend server.
>
>
> --
> Chuck Lever
>
>

