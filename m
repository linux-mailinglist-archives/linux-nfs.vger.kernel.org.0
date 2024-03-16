Return-Path: <linux-nfs+bounces-2351-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE6187DA08
	for <lists+linux-nfs@lfdr.de>; Sat, 16 Mar 2024 12:55:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 102D81F21A91
	for <lists+linux-nfs@lfdr.de>; Sat, 16 Mar 2024 11:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B36E18AEA;
	Sat, 16 Mar 2024 11:55:40 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC4B1865C
	for <linux-nfs@vger.kernel.org>; Sat, 16 Mar 2024 11:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710590140; cv=none; b=M0XyIFaIjS4qdnGrCLjFwItLehkzxPpvqcJdBTdyVmmTmOvgZiCRfkdqZM/PeSyG/GJmwSeACD70IvpZNmNz4fvVc18zdMF1LcS+wLOh3JZJGCI+mwXQWmDbOijIuuKYWpUkBYGQKrbNy7XdVNViTyQKvoNMxjafiKW20zMziQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710590140; c=relaxed/simple;
	bh=rqSu78Y3ywhM0qsLdaKjW2sW/Uz9jB/PjhOtEZuLhQ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=gWVrGupUJdJUkud99+Au1l7HxCUz6dXQYLM7eWtq6vHK9t2mOxh57OkDum7wCE+3KYjmsAS76oFwcy4bqbsyeR7SWe2y4btj3z/WzOKXkNz04tX+4RYWry/HkEurdqF8JTL/XhxmxDV6ETL+dRS9BYEW4ky8pmCHFEtLHj8LGnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nrubsig.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nrubsig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7cc05ce3c70so15300739f.0
        for <linux-nfs@vger.kernel.org>; Sat, 16 Mar 2024 04:55:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710590137; x=1711194937;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ooseJT0vdQWO/ouJv+060mxM3R75Wk1bCtUeeLJukYY=;
        b=ali29AeuQsVEF137Q3lT84LJeQY+OeG6xbFnjWTGjAZSPllkgitxL11D8xFVPW3rjY
         7Xy78q+kpA38Tr5ZmZAknCWFpp4TzlP5nHcN/6WjMoDruo0gKfXpN//op2ZUnUfaC4RR
         SzxVh14O6OcwBwTkY61ITcPxrqpsOQJMymzTTNAUGQ8Qckq8FDpoaP+49VjZsu4Jk7k3
         StSzif5IBm+9n0LscFj/jEPIR9prENGd75jt6xyIG9M+DyQvAzsj5mjO0XwbnmN6XbKT
         /umsnTCaNugGtW0pFixqiRO8qZJdzXoeC3oVKhN5IqiXS5CKfPPc5BYnpWsRJC/dtT2c
         TYRA==
X-Gm-Message-State: AOJu0YxqwWzAerKWmbnE5PrFeGnAkaCAF5VrNVJEcidsOUiLIXWAa3KJ
	93qgST12fzBmmgYw5YaOKTUf6Wz4dcmpXrbtQkJSH7LWj7heGNz52COwijhE4eb2wnabP5o7dKx
	BDJv2Xz0CIijQgUFSgQrQ97ab0QJjz4Y2rZg=
X-Google-Smtp-Source: AGHT+IEdJVerhSe2RPFtQAVNHoUpEPwJ6p16TOottQ6vrD/3w7a3EyZl/ncNWzUodfaHXMzGqeCCFFJkl6nINfOa9cA=
X-Received: by 2002:a5d:9583:0:b0:7c8:dd80:9f87 with SMTP id
 a3-20020a5d9583000000b007c8dd809f87mr6775593ioo.1.1710590136954; Sat, 16 Mar
 2024 04:55:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAvCNcDtTNDRvUVjUy4BE7eBCgmkb6hfkq3P0jaGDC=OXg0=6g@mail.gmail.com>
 <CAKAoaQmmEv+HRjmBMrSMGZn9RQr8C=2W4yeX4vNnohXFJPCV5A@mail.gmail.com>
 <65a29ca8.6b0a0220.ad415.d6d8.GMR@mx.google.com> <CAKAoaQkZ+b7NfrVi=gu1vCJBvv10=k85bG_kZV9G3jE45OOquw@mail.gmail.com>
 <0cd8fbfc707f86784dc7d88653b05cd355f89aad.camel@kernel.org>
 <24ACA376-5239-4941-BE53-70BF5E5E4683@oracle.com> <CAKAoaQny6G=JcKpJTYeLmNBEMgNkkc--T0Uvs1YbEX+JUD-PoA@mail.gmail.com>
 <CANH4o6NcMbcNKxARcqhthXWkKk6_r31iKGjnS-RhFBB_AJFaJg@mail.gmail.com> <470318C6-3252-445F-94F3-DDB7727F84C7@oracle.com>
In-Reply-To: <470318C6-3252-445F-94F3-DDB7727F84C7@oracle.com>
From: Roland Mainz <roland.mainz@nrubsig.org>
Date: Sat, 16 Mar 2024 12:55:10 +0100
Message-ID: <CAKAoaQ=6nGHD0uA+9EaQQPWBk8dvq0XVUPPgPAhbh=XPk+ecSg@mail.gmail.com>
Subject: |ca_maxoperations| - tuneable ? / was: Re: RFE: Linux nfsd's
 |ca_maxoperations| should be at *least* |64| ... / was: Re: kernel.org list
 issues... / was: Fwd: Turn NFSD_MAX_* into tuneables ? / was: Re: Increasing
 NFSD_MAX_OPS_PER_COMPOUND to 96
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 3:52=E2=80=AFPM Chuck Lever III <chuck.lever@oracle=
.com> wrote:
> > On Jan 18, 2024, at 4:44=E2=80=AFAM, Martin Wege <martin.l.wege@gmail.c=
om> wrote:
> > On Thu, Jan 18, 2024 at 2:57=E2=80=AFAM Roland Mainz <roland.mainz@nrub=
sig.org> wrote:
> >> On Sat, Jan 13, 2024 at 5:10=E2=80=AFPM Chuck Lever III <chuck.lever@o=
racle.com> wrote:
> >>>> On Jan 13, 2024, at 10:09=E2=80=AFAM, Jeff Layton <jlayton@kernel.or=
g> wrote:
> >>>> On Sat, 2024-01-13 at 15:47 +0100, Roland Mainz wrote:
> >>>>> On Sat, Jan 13, 2024 at 1:19=E2=80=AFAM Dan Shelton <dan.f.shelton@=
gmail.com> wrote:
[snip]
> >> That assumes that no process does random access into deep subdirs. In
> >> that case the performance is absolutely terrible, unless you devote
> >> lots of memory to a giant cache (which is not feasible due to cache
> >> expiration limits, unless someone (please!) finally implements
> >> directory delegations).
>
> Do you mean not feasible for your client? Lookup caches
> have been part of operating systems for decades. Solaris,
> FreeBSD, and Linux all have one. Does the Windows kernel
> have one that mfs-nfs41-client can use?

The ms-nfs41-client has its own cache.
Technically Windows has another, but that is in the kernel and
difficult to connect to the NFS client daemon without performance
issues.

[snip]
> Sending a full path in a single COMPOUND is one way to
> handle path resolution, but it has so many limitations
> that it's really not the mechanism of choice.

Which limitations ?

The reason why I am looking to stuff more info into a request:
- VPN has very high latency, so splitting requests hurts performance *BADLY=
*.
I've been slapped about path/dir lookup performance now many times,
and while there is more than one issue (Cygwin looks for "file" and
"file.lnk"&co for each file + our readdir implementation needs lots of
work) the biggest issue that we split requests up because they usually
do not fit.
- Windows API is async+multithreaded, which results in that requests
do not always come in the logical/expected/useful order, which leads
to cache issues.
Seriously this issue is so bad that it is worth a research paper
- Real-world paths on Windows are LONG with many subdirs, even worse
when projects and organisations change, shift, reorganise, move,
merge, split, get outsourced etc. over *DECADES*. Plus non-IT-users
have zero awareness about "path limits", and sometimes dump whole
sentences into directory names (e.g. "customer XYZ. can be ignored he
terminated the business relationship on 26 May 2001. please do not
delete dir" <----- xxx@@!!!! ).
That issue haunts us in other ways too, e.g.  in the ms-nfs41-client
project I had to extend the maximum supported path length multiple
times to support this craziness, right now we support 4096 byte paths
([1]), with the longest known path being 1772, and others reported
even more.
And this is not a specific issue to my current employer, I've seen
this in customer installations when I was at SUN (including long
debates about Solaris's 1024 byte limit) and RedHat too.

[1]=3DWindows opened the next can of pandora with removing the MAXPATH
limit a while ago, e.g. see
https://learn.microsoft.com/en-us/windows/win32/fileio/maximum-file-path-li=
mitation?tabs=3Dregistry
- and even before that there was the "\\?\" prefix.

[snip]
> > ca_maxoperations:
> >     The maximum number of operations the replier will accept
> >     in a COMPOUND or CB_COMPOUND. For the backchannel, the
> >     server MUST NOT change the value the client offers. For
> >     the fore channel, the server MAY change the requested
> >     value. After the session is created, if a requester sends
> >     a COMPOUND or CB_COMPOUND with more operations than
> >     ca_maxoperations, the replier MUST return
> >     NFS4ERR_TOO_MANY_OPS.
>
> The BCP 14 "MAY" here means that servers can return the same
> value, but clients have to expect that a server might return
> something different.
>
> Further, the spec does not permit an NFS server to respond to
> a COMPOUND with more than the client's ca_maxoperations in
> any way other than to return NFS4ERR_TOO_MANY_OPS. So it
> cannot return a larger ca_maxoperations than the client sent.
>
> NFSD returns the minimum of the client's max-ops and its own
> NFSD_MAX_OPS_PER_COMPOUND value, which is 50. Thus NFSD will
> return the same value as the client, unless the client asks
> for more than 50.

I finally (yay - Saturday) had a look at this issue and
collected&&processed statistics.
With a Linux 6.6.20-rt25 kernel nfsd I get this in the ms-nfs41-client:
---- snip ----
1010: requested: req.csa_fore_chan_attrs.(ca_maxoperations=3D16384,
ca_maxrequests=3D128)
1010: response:  session->fore_chan_attrs->(ca_maxoperations=3D50,
ca_maxrequests=3D66)
---- snip ----

So - if I understand it correctly - the negotiation works correctly,
and we get |ca_maxoperations=3D50| and |ca_maxrequests=3D66|.

But... this value is too small, at least for what we do on Windows.
I've collected samples (84 machines, a wide range of users, MS Office,
ERP, CAD, etc.) and 71% of all server lookup calls had to be split
(Linux 6.6 LTS kernel nfsd) for |ca_maxoperations=3D=3D50|, 39% for
|ca_maxoperations=3D=3D64| and <1% for |ca_maxoperations=3D=3D80|.

Question is... should the values for |ca_*| be a tuneable, or just
increase the limit to |80| ([1]) ?

[1]=3DI can provide the patch, with sufficient curses about Windows
*USERS* included...

----

Bye,
Roland
--=20
  __ .  . __
 (o.\ \/ /.o) roland.mainz@nrubsig.org
  \__\/\/__/  MPEG specialist, C&&JAVA&&Sun&&Unix programmer
  /O /=3D=3D\ O\  TEL +49 641 3992797
 (;O/ \/ \O;)

