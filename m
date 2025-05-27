Return-Path: <linux-nfs+bounces-11924-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45650AC5304
	for <lists+linux-nfs@lfdr.de>; Tue, 27 May 2025 18:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D24B51BA315C
	for <lists+linux-nfs@lfdr.de>; Tue, 27 May 2025 16:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0C327F198;
	Tue, 27 May 2025 16:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GCcVCLpa"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B88F4ED
	for <linux-nfs@vger.kernel.org>; Tue, 27 May 2025 16:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748363400; cv=none; b=bAF4buvotqkLXX2xW/N2cSDTsN7ZNAl1IvjXo7rJrr5EM+v/PoIAuwxJGv5Q7tuBMzHlv4K6t4GILewEcDVBjpz3z3Ff633nl1oUdGSDphPwKnRQF0uYU7Xlru8Ap/LUQcq4G7MGofQGqGaVVOteMBApPxD8tzrDxcImyndX4Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748363400; c=relaxed/simple;
	bh=phSkK3LFTiYZjw5mzkzdJwX2SwUHkrcBhyGZv50kzTk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CjCQ2tiXQPIEtCk3ItdFy7bZfybV+DNI42aUBozLPg8WGQfFdeucDKDc8X8pu7yznBujU1xp4tPLrom5N0Jgx7rsK44UqvIDFHb5L/sdQfgH3ysFVB77OnfnouTF0rBGa37IhQH5XPb2GxYuxu6R19o98IqEg0UxG3msVe8Qk50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GCcVCLpa; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5fff52493e0so4389259a12.3
        for <linux-nfs@vger.kernel.org>; Tue, 27 May 2025 09:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748363396; x=1748968196; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yywoH5OGt9B4TbiRqfJZOWFodTvSKSYl+FoOQNS0skc=;
        b=GCcVCLparQEm3xbcDYJytlfK9EYj16uRkq2B4QgR/cObqyrBcnmzOUD30HNMVh0TG8
         NtRTEKHW74nqmYIeWaCEnCCwBFMZXzRyCHwuJ34Oc7L4ixXPwko3crMZvv359rHyRXq5
         GODHMtAF0UOhTU7EMxpVaSaRPR7QHlNVEnUMMW2km1MPZVLSSyiWZhPvh+RbiYbBIi2z
         +o2xaToByX5kBJflaEAMZQMpVdzumAoNG5CoazXKme956DhssD26URBuPackgfng/MoD
         HZtPKJx3wRVhtQkCkGGlOLgJFGLAPrTBGbDQyfKcRef/fjQZrVpzr9ts2xxboQw2W52z
         m0jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748363396; x=1748968196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yywoH5OGt9B4TbiRqfJZOWFodTvSKSYl+FoOQNS0skc=;
        b=aS3U6wdENCxM33OXB3SwwptJmDTwRAZtvvKbflSMsQ55aDJvKDdDPCX8fKUEPMb5lj
         KiCWuvL8fvpSqIBh0tO2mg5REVjjPC3TsKzSh3/OAM38tFdDuoJ4WlCzUiyRwbkFtNS9
         BpmWlHms55MdjL3/WSANrjmblDUFqWNAsm4GDYYWCr+TPHZehaWIydfJilsUqq4FEEz2
         Tc4FFnzNsjWSuIBVT9qjjkhhw6+nS1HLvQyb1TuaIat8zr/EkO3wyXHL9QOpEpDq88cu
         iOhcuOOzr3eRZ50uRlaytotdmMutzQ95/AnGYe+ySEPDo/9ie80QnCyM3fd2rw0WKNdJ
         hJhg==
X-Forwarded-Encrypted: i=1; AJvYcCU5sO0joewhMK+nFasL+37foJ9XlSUWabX8boDT/ElrNx/Iln1Au1EtSpqpv+NAqNbhSifpmYOEoe4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmQ3b3/oqotqHlhRJudzyITBpjKjwRn+8U/eJonjkjLpK7YNte
	87tGyxTN+Wmp4ERFPulCNehlkJ4udi1vA+ZLYrdHVSrYvflQYyDR3ZYokLpZuYCQbnlKTqgeHbo
	LRBm4LOYemW/KZo4dRaupT6DNAj355g==
X-Gm-Gg: ASbGncvK+I4gCWIhTgIBLgjnAJeTHNvDHdlS4tsvcEibkizjyaCs/qLGGkIBdvuilSO
	owiVfOU8p9aaxzI6BEv5w4MMeiDUMgdPoR7dfw2LyfGxjWJIP53rLZgbunH/AZkctB1fATlC4jJ
	bRMmGUUn+Sc6M1qnTQm3Gp+b/Wt8hf1TsD
X-Google-Smtp-Source: AGHT+IHgKB2msaR47gRlBOtgq3TczT1tADaifSJqjGcx1WsU2bDg8oFD2e6b/f1wL6woQDE2woXTaAu9TrchnZ8wg50=
X-Received: by 2002:a05:6402:430d:b0:600:caf:51f1 with SMTP id
 4fb4d7f45d1cf-602da4fd6c9mr11573344a12.28.1748363396159; Tue, 27 May 2025
 09:29:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d539c502-e776-460f-852c-8af9722ad9f8@oracle.com>
 <174821817646.608730.16435329287198176319@noble.neil.brown.name> <f679b62b-cbf3-4225-a163-870c65ff0c9b@oracle.com>
In-Reply-To: <f679b62b-cbf3-4225-a163-870c65ff0c9b@oracle.com>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Tue, 27 May 2025 09:29:43 -0700
X-Gm-Features: AX0GCFtc8AuYbnrizF2gyXpOekGZ7JbqrbVuW3Qnf-xlTfCNgLs76EKDH1cDYR8
Message-ID: <CAM5tNy6sgLg1HFBBkRe5JoXbrDjWiJfoxW3S-ZHh7HGSoVXzgQ@mail.gmail.com>
Subject: Re: [PATCH nfs-utils] exportfs: make "insecure" the default for all exports
To: Chuck Lever <chuck.lever@oracle.com>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>, 
	Steve Dickson <steved@redhat.com>, Tom Haynes <loghyr@gmail.com>, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 27, 2025 at 8:05=E2=80=AFAM Chuck Lever <chuck.lever@oracle.com=
> wrote:
>
> On 5/25/25 8:09 PM, NeilBrown wrote:
> > On Mon, 26 May 2025, Chuck Lever wrote:
> >> On 5/20/25 9:20 AM, Chuck Lever wrote:
> >>> Hiya Rick -
> >>>
> >>> On 5/19/25 9:44 PM, Rick Macklem wrote:
> >>>
> >>>> Do you also have some configurable settings for if/how the DNS
> >>>> field in the client's X.509 cert is checked?
> >>>> The range is, imho:
> >>>> - Don't check it at all, so the client can have any IP/DNS name (a m=
obile
> >>>>   device). The least secure, but still pretty good, since the ert. v=
erified.
> >>>> - DNS matches a wildcard like *.umich.edu for the reverse DNS name f=
or
> >>>>    the client's IP host address.
> >>>> - DNS matches exactly what reverse DNS gets for the client's IP host=
 address.
> >>>
> >>> I've been told repeatedly that certificate verification must not depe=
nd
> >>> on DNS because DNS can be easily spoofed. To date, the Linux
> >>> implementation of RPC-with-TLS depends on having the peer's IP addres=
s
> >>> in the certificate's SAN.
> >>>
> >>> I recognize that tlshd will need to bend a little for clients that us=
e
> >>> a dynamically allocated IP address, but I haven't looked into it yet.
> >>> Perhaps client certificates do not need to contain their peer IP
> >>> address, but server certificates do, in order to enable mounting by I=
P
> >>> instead of by hostname.
> >>>
> >>>
> >>>> Wildcards are discouraged by some RFC, but are still supported by Op=
enSSL.
> >>>
> >>> I would prefer that we follow the guidance of RFCs where possible,
> >>> rather than a particular implementation that might have historical
> >>> reasons to permit a lack of security.
> >>
> >> Let me follow up on this.
> >>
> >> We have an open issue against tlshd that has suggested that, rather
> >> than looking at DNS query results, the NFS server should authorize
> >> access by looking at the client certificate's CN. The server's
> >> administrator should be able to specify a list of one or more CN
> >> wildcards that can be used to authorize access, much in the same way
> >> that NFSD currently uses netgroups and hostnames per export.
> >>
> >> So, after validating the client's CA trust chain, an NFS server can
> >> match the client certificate's CN against its list of authorized CNs,
> >> and if the client's CN fails to match, fail the handshake (or whatever
> >> we need to do).
> >>
> >> I favor this approach over using DNS labels, which are often
> >> untrustworthy, and IP addresses, which can be dynamically reassigned.
> >>
> >> What do you think?
> >
> > I completely agree with this.  IP address and DNS identity of the clien=
t
> > is irrelevant when mTLS is used.  What matters is whether the client ha=
s
> > authority to act as one of the the names given when the filesystem was
> > exported (e.g. in /etc/exports).  His is exacly what you said.
> >
> > Ideally it would be more than just the CN.  We want to know both the
> > domain in which the peer has authority (e.g.  example.com) and the type
> > of authority (e.g.  serve-web-pages or proxy-file-access or
> > act-as-neilb).
> > I don't know internal details of certificates so I don't know if there
> > is some other field that can say "This peer is authorised to proxy file
> > access requests for all users in the given domain" or if we need a hack
> > like exporting to nfs-client.example.com.
> >
> > But if the admin has full control of what names to export to, it is
> > possible that the distinction doesn't matter.  I wouldn't want the
> > certificate used to authenticate my web server to have authority to
> > access all files on my NFS server just because the same domain name
> > applies to both.
>
> My thought is that, for each handshake, there would be two stages:
>
> 1. Does the NFS server trust the certificate? This is purely a chain-of-
>    trust issue, so validating the certificate presented by the client is
>    the order of the day.
>
> 2. Does the NFS server authorize this client to access the export? This
>    is a check very similar to the hostname/netgroup/IP address check
>    that is done today, but it could be done just once at handshake time.
>    Match the certificate's fields against a per-export filter.
>
> I would take tlshd out of the picture for stage 2, and let NFSD make its
> own authorization decisions. Because an NFS client might be authorized
> to access some exports but not others.
>
> So:
>
> How does the server indicate to clients that yes, your cert is trusted,
> but no, you are not authorized to access this file system? I guess that
> is an NFS error like NFSERR_STALE or NFS4ERR_WRONGSEC.
>
> What certificate fields should we implement matches for? CN is obvious.
> But what about SAN? Any others? I say start with only CN, but I'd like
> to think about ways to make it possible to match against other fields in
> the future.
Just fyi, here's an example where filtering on the DNS or IP field in the
SAN (SubjectAltName) could improve security..
(Dusting off my CS sysadmin hat.)

Suppose I had a file system where student grades and exam questions
were stored.
The mount was restricted to faculty offices, where their machines had fixed
well known IP addresses and FQDNs assigned.
However, as it was for my case, the building their offices were in also had
student labs and the building was assigned a subnet by the campus
networking folk.
--> As such, a student could easily come in off hours (when the faculty wer=
e not
     around and, as such, had their office computers shut down) and
plug into the
     subnet (they just had to find an RJ45 jack somewhere that they
could access).
     --> They could then set their laptop up with the same IP address
as a faculty
           member's office computer and defeat ordinary /etc/exports
filtering based
           on client IP address.

However, these students would not have the X.509 cert. with a DNS or IP fie=
ld
set to the correct address in it. (They might have a valid cert. so
their laptop can
mount the file systems students have coursework assignments on, but it woul=
d
not have the DNS or IP of a faculty member's office computer.)
--> This additional filtering would stop them from accessing the
marks/exam question
      file system (or at least make it a lot harder for them to do so).

As already discussed, there is a tradeoff between using DNS or IP. (I'll ad=
mit
FreeBSD doesn't currently support the IP case, but it probably should.)

rick

>
> What would the administrative interface look like? Could be the machine
> name in /etc/exports, for instance:
>
> *,OU=3D"NFS Bake-a-thon",*   rw,sec=3Dsys,xprtsec=3Dmtls,fsid=3D42
>
> But I worry that will not be flexible enough. A more general filter
> mechanism might need something like the ini file format used to create
> CSRs.
>
>
> What about pre-shared keys? No certificate fields there.
>
>
> --
> Chuck Lever

