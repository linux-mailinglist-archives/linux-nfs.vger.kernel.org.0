Return-Path: <linux-nfs+bounces-6917-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 316A7993C13
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Oct 2024 03:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F9F0B216A4
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Oct 2024 01:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8FC729A5;
	Tue,  8 Oct 2024 01:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jYGjGjJO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6307EC4;
	Tue,  8 Oct 2024 01:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728350295; cv=none; b=g9tdOuLar09OJHIluzKWE8qa3pOH/oRH7e2h7myYuB7OAw8B7pV9hRtR7aZAgSrvhQRl+QjWHsadjb5X3QjxWPvceCgYCenlKJMkQVWXBUIE+vVzS4AdcVF5lBvd6cR4KGPKCigr4s2FzopxuoH/jpHOhge/BY+br+u8LjRch6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728350295; c=relaxed/simple;
	bh=1f3nGRrCB4boZubey7XIg+NBRkGNjN0JZqt+g/JrTTk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rgrn0xyfiT9rekdEb1e18s7Y9J59RodjkID0U8gCYDmKZW3PdBPpqP/nFYAmkIAidNthsvzPeBB3KUfDICL5LqFbzR8qOmCJm2CeATlgFpILs6rJxmXbQikTafFOnWLtRudM/ZaA8rxXIRxjaENmsRiFnOZZ9X8gn3PdUBmmHP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jYGjGjJO; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2fad0f66d49so75455941fa.3;
        Mon, 07 Oct 2024 18:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728350292; x=1728955092; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Nyh2UooDeyTvEJgeydzupzYKaLiQrarZ3CByd9UGTg=;
        b=jYGjGjJOnvhGSzWp5ZJI+OQyNrTucgWoY4AMVekZE/64SI8TPDRpAXpE36WiWgbN0o
         ImWIe1XcrzoCp5z7jX1ht27kEeNLdAiitE++Q/ES4fTJ9NIzLHiF/B20vGmbWMAfOOtw
         LvYfre8FUfCsva3M9fytoDid0Gj4gfTXMpuCmenKGnKVT0zt3hNk3hXVjFZ0xJkssG1o
         NTJtZYU41J9xm4Z03hl64fj1q/HwQg/XA1YRelTZyG56Oz1Pm+lBuVxsfRyKon2PdALl
         32MzHkvn0/17gI6RnenhB7YmLhq7Nz5pkzfdHilj6orD3MknS5TgxcXd/1hGAhVnXQGn
         4YXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728350292; x=1728955092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Nyh2UooDeyTvEJgeydzupzYKaLiQrarZ3CByd9UGTg=;
        b=MK4CqhUv2dCqAJByU5WSbzArDHIgiHRUXvqIE1JO52H6wUHQgL5/mttDFiOV92gtjR
         VH/EzbOfZcwNFoYwqxzGd4Dtj3kmJK47TBVdUl3nysvBexEJHuZLDrO4HmtWOReypGKO
         QGfxzMZdQNfEA9eSFkBNgcKv1pSX2sZ9l1du9IUAYsniuMspnp/QiRFR58cr7/L1nxEM
         8YTbnrtabAhE5+Mt+cZdVIDV+RBtNcYHsrtOaYgpyA/YQN0rTY684tusqy+Q8zMRiO1n
         k8Ar1OMJM0IAJ3/8UN87Rlb03JDOsAkhM16Aw7lOb690qghIQIQd2kOcu/81ufKJ8i6H
         gTig==
X-Forwarded-Encrypted: i=1; AJvYcCUgBZ1FtmHkNJTF5rde/E07jksyjIm2ROxgmgRK2iED7IDHufvz0rddJGBurH/6x8k2A5BxOoD/+Lgx0Og=@vger.kernel.org, AJvYcCVTXAwTm7PBooTlA8oKKuWlkiPxutiCiaDS2fPE+ZLHIZ0WNf1Hl1vooAFIULno9wa56uGjMDnPnglD@vger.kernel.org
X-Gm-Message-State: AOJu0YxiLPKx9s0vu6SArYx8P/xWp+rpN6GtAXErh1py89cCOytH5LOf
	5ZjLu8NLCwrp+Pe2HTbI3vzNEQbFt2TysDpJ7hQVVjbi12mUHyl7SqE+k2HmAEo4BRmWAUtOKvA
	QpiFsa990DVaR0+U/ge9fl9y6sw==
X-Google-Smtp-Source: AGHT+IEI91Ye/CsDLs9ZZSrxBVxgyB+7AUO7bG4Ndh7lPNe9TluR0lNqCwwp+LMHn0KbaewrvRkgeUFPd+Ht9/ulKbM=
X-Received: by 2002:a05:651c:548:b0:2fa:cc64:616c with SMTP id
 38308e7fff4ca-2faf3c15875mr50535271fa.15.1728350291429; Mon, 07 Oct 2024
 18:18:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <EEC2DC14-EBE9-4F41-9BBE-47F9DDD110C7@oracle.com>
 <172825777599.1692160.7897699757454912990@noble.neil.brown.name> <A247373D-46F3-46F1-8C8C-996A95B1A49B@oracle.com>
In-Reply-To: <A247373D-46F3-46F1-8C8C-996A95B1A49B@oracle.com>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Mon, 7 Oct 2024 18:17:59 -0700
Message-ID: <CAM5tNy79vTM7v_-Cq9mCvudqL7JfrZ-Bc7dLvpNWQ-MkkxmPOA@mail.gmail.com>
Subject: Re: [PATCH] nfsd: Fix NFSD_MAY_BYPASS_GSS and NFSD_MAY_BYPASS_GSS_ON_ROOT
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Neil Brown <neilb@suse.de>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>, 
	Tom Talpey <tom@talpey.com>, Linux NFS Mailing List <linux-nfs@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 8:51=E2=80=AFAM Chuck Lever III <chuck.lever@oracle.=
com> wrote:
>
> CAUTION: This email originated from outside of the University of Guelph. =
Do not click links or open attachments unless you recognize the sender and =
know the content is safe. If in doubt, forward suspicious emails to IThelp@=
uoguelph.ca.
>
>
>
>
> > On Oct 6, 2024, at 7:36=E2=80=AFPM, NeilBrown <neilb@suse.de> wrote:
> >
> > On Mon, 07 Oct 2024, Chuck Lever III wrote:
> >>
> >>
> >>> On Oct 6, 2024, at 6:29=E2=80=AFPM, Pali Roh=C3=A1r <pali@kernel.org>=
 wrote:
> >>>
> >>> On Monday 07 October 2024 09:13:17 NeilBrown wrote:
> >>>> On Mon, 07 Oct 2024, Chuck Lever wrote:
> >>>>> On Fri, Sep 13, 2024 at 08:52:20AM +1000, NeilBrown wrote:
> >>>>>> On Fri, 13 Sep 2024, Pali Roh=C3=A1r wrote:
> >>>>>>> Currently NFSD_MAY_BYPASS_GSS and NFSD_MAY_BYPASS_GSS_ON_ROOT do =
not bypass
> >>>>>>> only GSS, but bypass any authentication method. This is problem s=
pecially
> >>>>>>> for NFS3 AUTH_NULL-only exports.
> >>>>>>>
> >>>>>>> The purpose of NFSD_MAY_BYPASS_GSS_ON_ROOT is described in RFC 26=
23,
> >>>>>>> section 2.3.2, to allow mounting NFS2/3 GSS-only export without
> >>>>>>> authentication. So few procedures which do not expose security ri=
sk used
> >>>>>>> during mount time can be called also with AUTH_NONE or AUTH_SYS, =
to allow
> >>>>>>> client mount operation to finish successfully.
> >>>>>>>
> >>>>>>> The problem with current implementation is that for AUTH_NULL-onl=
y exports,
> >>>>>>> the NFSD_MAY_BYPASS_GSS_ON_ROOT is active also for NFS3 AUTH_UNIX=
 mount
> >>>>>>> attempts which confuse NFS3 clients, and make them think that AUT=
H_UNIX is
> >>>>>>> enabled and is working. Linux NFS3 client never switches from AUT=
H_UNIX to
> >>>>>>> AUTH_NONE on active mount, which makes the mount inaccessible.
> >>>>>>>
> >>>>>>> Fix the NFSD_MAY_BYPASS_GSS and NFSD_MAY_BYPASS_GSS_ON_ROOT imple=
mentation
> >>>>>>> and really allow to bypass only exports which have some GSS auth =
flavor
> >>>>>>> enabled.
> >>>>>>>
> >>>>>>> The result would be: For AUTH_NULL-only export if client attempts=
 to do
> >>>>>>> mount with AUTH_UNIX flavor then it will receive access errors, w=
hich
> >>>>>>> instruct client that AUTH_UNIX flavor is not usable and will eith=
er try
> >>>>>>> other auth flavor (AUTH_NULL if enabled) or fails mount procedure=
.
> >>>>>>>
> >>>>>>> This should fix problems with AUTH_NULL-only or AUTH_UNIX-only ex=
ports if
> >>>>>>> client attempts to mount it with other auth flavor (e.g. with AUT=
H_NULL for
> >>>>>>> AUTH_UNIX-only export, or with AUTH_UNIX for AUTH_NULL-only expor=
t).
> >>>>>>
> >>>>>> The MAY_BYPASS_GSS flag currently also bypasses TLS restrictions. =
 With
> >>>>>> your change it doesn't.  I don't think we want to make that change=
.
> >>>>>
> >>>>> Neil, I'm not seeing this, I must be missing something.
> >>>>>
> >>>>> RPC_AUTH_TLS is used only on NULL procedures.
> >>>>>
> >>>>> The export's xprtsec=3D setting determines whether a TLS session mu=
st
> >>>>> be present to access the files on the export. If the TLS session
> >>>>> meets the xprtsec=3D policy, then the normal user authentication
> >>>>> settings apply. In other words, I don't think execution gets close
> >>>>> to check_nfsd_access() unless the xprtsec policy setting is met.
> >>>>
> >>>> check_nfsd_access() is literally the ONLY place that ->ex_xprtsec_mo=
des
> >>>> is tested and that seems to be where xprtsec=3D export settings are =
stored.
> >>>>
> >>>>>
> >>>>> I'm not convinced check_nfsd_access() needs to care about
> >>>>> RPC_AUTH_TLS. Can you expand a little on your concern?
> >>>>
> >>>> Probably it doesn't care about RPC_AUTH_TLS which as you say is only
> >>>> used on NULL procedures when setting up the TLS connection.
> >>>>
> >>>> But it *does* care about NFS_XPRTSEC_MTLS etc.
> >>>>
> >>>> But I now see that RPC_AUTH_TLS is never reported by OP_SECINFO as a=
n
> >>>> acceptable flavour, so the client cannot dynamically determine that =
TLS
> >>>> is required.
> >>>
> >>> Why is not RPC_AUTH_TLS announced in NFS4 OP_SECINFO? Should not NFS4
> >>> OP_SECINFO report all possible auth methods for particular filehandle=
?
> >>
> >> SECINFO reports user authentication flavors and pseudoflavors.
> >>
> >> RPC_AUTH_TLS is not a user authentication flavor, it is merely
> >> a query to see if the server peer supports RPC-with-TLS.
> >>
> >> So far the nfsv4 WG has not been able to come to consensus
> >> about how a server's transport layer security policies should
> >> be reported to clients. There does not seem to be a clean way
> >> to do that with existing NFSv4 protocol elements, so a
> >> protocol extension might be needed.
> >
> > Interesting...
> >
> > The distinction between RPC_AUTH_GSS_KRB5I and RPC_AUTH_GSS_KRB5P is no=
t
> > about user authentication, it is about transport privacy.
>
> RPC_AUTH_GSS_KRB5I is Kerberos user authentication plus
> Kerberos integrity protection.
>
> RPC_AUTH_GSS_KRB5P is Kerberos user authentication plus
> Kerberos confidentiality.
>
> So, both of these pseudoflavors select Kerberos user
> authentication (versus, say, RPC_AUTH_UNIX, which does
> not).
I'd argue they also select on-the-wire protection. It just happens
that they use the session key for a user credential.
I'd agree with Neil, in that the 'p' refers to on-the-wire privacy.
>
>
> > And the distinction between xprtsec=3Dtls and xprtsec=3Dmtls seems to b=
e
> > precisely about user authentication.
>
> No: xprtsec authentication is /peer/ authentication. User
> authentication is still set via sec=3D . See the final
> paragraph in Section 4.2 of RFC 9289.
True, but for krb5[ip] there is a (mis)use of a user principal for the
client's machine credential. (The user principal that does SetClientID
or ExchangeID.)
--> I'd argue that this user principal is really a client machine (or peer,
if you prefer) credential.
--> I think that the host based service principal in the client's keytab
      is a pita and maybe one of the reasons that krb5[ip] doesn't get
      used that much.

>
>
> > I would describe the current pseudo flavours as not "a clean way" to
> > advise the client of security requirements, but they are at least
> > established practice.
> >
> > RPC_AUTH_SYS_TLS  seems to me to be an obvious sort of pseudo flavour.
> >
> > But I suspect all these arguments and more have already been discussed
> > within the working group and people can sensibly have different
> > opinions.
>
> Yes, these arguments were discussed within the WG, and
> I even wrote a draft (now expired) that treated the
> various combinations of TLS and user authentication
> flavors as unique pseudoflavors. The idea was rejected.
I'll encourage NeilBrown to make comments related to the D. Noveck
security draft over on nfsv4@ieft.org. (I'll admit I have great difficulty
getting around to reading/commenting on these drafts, but I will try to
get around to the security one one of these days.)

The piece I'd like to see is mtls being accepted as a reasonable
alternative to krb5i/krb5p for SP4_MACH_CRED.

Personally, I think the pseudo-flavors make sense.
Maybe I/Neil can illicit further discussion w.r.t. them, rick

>
>
> > Thanks for helping me understand NFS/TLS a bit better.
> >
> > NeilBrown
> >
> >
> >
> >>
> >>
> >>>> So there is no value in giving non-tls clients access to
> >>>> xprtsec=3Dmtls exports so they can discover that for themselves.  Th=
e
> >>>> client needs to explicitly mount with tls, or possibly the client ca=
n
> >>>> opportunistically try TLS in every case, and call back.
> >>>>
> >>>> So the original patch is OK.
> >>>>
> >>>> NeilBrown
> >>
> >>
> >> --
> >> Chuck Lever
>
>
> --
> Chuck Lever
>
>

