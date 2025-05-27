Return-Path: <linux-nfs+bounces-11923-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A11AC527F
	for <lists+linux-nfs@lfdr.de>; Tue, 27 May 2025 17:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 553A616B7F1
	for <lists+linux-nfs@lfdr.de>; Tue, 27 May 2025 15:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D7B27CCC4;
	Tue, 27 May 2025 15:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l/Wp5LNS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D43D1DF26E
	for <linux-nfs@vger.kernel.org>; Tue, 27 May 2025 15:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748361504; cv=none; b=YY5KCV+hi2naShZbrylSbJXmCpNmAu9S+SGrj0zPWOHX704V8T9yUCx4ZOYFAJzGJsjotPfFaZessibkWVql93A8bLyRC4yHILg7xRJ3GVBu04FFt66ekhUhbERTXgZpduURQ3tkpJmnbUFjtrGGYKVNkqqq88+xATQXi36Iwp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748361504; c=relaxed/simple;
	bh=F2m1w3X4bRaaM3+3sHtWTh9R6Q5MMJ+Xj5ISKyxHiZ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XeY7R3cb3JgZFlu2hLdaWKPhDVES6zo1/nAVnS2mcnY58JIfDIhc+rY0DLQ+63qSnZARlxlJpzWCHCqqz9hlAuQA56uOnZbc0kivtXDL9lyZjFGWDGfI+gE30PG9uvz0+Mh5KIO9Piq/DPLkz9CKBiEQtPgaqnDinusyDijLn00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l/Wp5LNS; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6045a3a2c5eso3630434a12.2
        for <linux-nfs@vger.kernel.org>; Tue, 27 May 2025 08:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748361498; x=1748966298; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HjjS5zJIo5Dte89oa6l5XcQ0z2c1Rn/UUR6whtrZ01M=;
        b=l/Wp5LNS2oyTfjz88Mnqze5Y3mukmiuKxQWWTE6xtM0M5Te49deRBlF0aXsnFXPSpb
         PQs1hCCSzAQo46e8h+yqhzHGSLe+Y/V6weuH8zOm5cjfZ1lAB+lA4P7LWLLXgPJmw3x4
         xzL7yaiVEHr2Ja23lvZ7FZfrYF5NghMRyBjYRoXBjFqiEIMcRRLlcb3t/aBPdEmOnjGR
         FwOWmZrEXMWpNmT9AoLgrm9uTdo6i7XHROyuHnQBbimGLYEhwMWiI7KdgenledLkEh5h
         9nfAOzsyGVb+WihmoTpVBhTXGutSgf3cSf4fLcqk5zcHD7EI3KTJZLTs9/pEmAVTvbGH
         05dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748361498; x=1748966298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HjjS5zJIo5Dte89oa6l5XcQ0z2c1Rn/UUR6whtrZ01M=;
        b=faPi81rXncDgFtWlKYFg8ePrv55fapmzp8bok/S/j79F7Mc55WhxnALfFpVhRuT9+R
         znhEEKNhqlrV9YUkFRCr8YKYvCy03/v6+WZlqe0oBJt8OD/b2nwzVLb3A53G44LhsxXZ
         D9ffx8g8VCtIDDRrJJiH173pumoD6ZbvtoHSn+qvGePUmghv+DMaAcSSYUca4u/meNZx
         qU+6Vn3VEKgJjhuIv/WRmxcFMHXajBgXqBuG1uAQrs+VSlIGeLvzn9gz9/44HuBOa+vy
         Iw7G0xkHTN+7R80oJ7QkFxuWSNYGIq1oXRI8ka2/0qD28zqw4ZDFARahob5j5eWrlooZ
         FrqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIOCwOCbnOtcW7CucM8aPqTmFJ1IZuQhyuY04ECHPFjHiORC1zR5kv8/QecKAx4zELFcbkrQbLwBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhqQT7wrjNPx4mV9glS8UuH5cbfK2y74Cdud+P2yB1ozZhJA+K
	02HnJ++FaBSAiyZBEf2ZS8cMnKca7fRTMVvmaUONmfvu/0FPJTMgaY6J7AAyPMDWkjlGulVLl7D
	ONtaiOi9bTWSDEOXfWiDdTNUzYCd6zA==
X-Gm-Gg: ASbGncte1H9rEFDPqyDgLvoVDvNBGM6fpTqtlvHGGf48Evs1oE87PupCR6RKbTY4oy4
	63SoMJEcZgvUlLCC5+9mvDf6S8y+7EWQHz/YEFQtduu+2uiuBeDLq4TjRIOI22KZCBc2QY8ObHm
	1yQazYULgiGoTeSmHhss7z+zMZEM5Kj7/L
X-Google-Smtp-Source: AGHT+IGSyjlr7h4i5mPWP9KAZSCPNV+Xign+mltNKSQWJosfljNiRDUJN1Pnm9IxZBX5/TqEOqN1W78hASFZX6xHNVk=
X-Received: by 2002:a05:6402:26c3:b0:5fe:e3a7:a8bb with SMTP id
 4fb4d7f45d1cf-602da407a83mr10602928a12.25.1748361497948; Tue, 27 May 2025
 08:58:17 -0700 (PDT)
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
Date: Tue, 27 May 2025 08:58:05 -0700
X-Gm-Features: AX0GCFv8yFa8XOaqKw5MCmEFoK3jjd7YlWjYDHssGFKLxLMQTaDPtptZDdpylog
Message-ID: <CAM5tNy41RagQfYZRWxP6YV-+3azy-ftizZXtCEOzT5cRBe74nQ@mail.gmail.com>
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
>
> What would the administrative interface look like? Could be the machine
> name in /etc/exports, for instance:
>
> *,OU=3D"NFS Bake-a-thon",*   rw,sec=3Dsys,xprtsec=3Dmtls,fsid=3D42
>
> But I worry that will not be flexible enough. A more general filter
> mechanism might need something like the ini file format used to create
> CSRs.
One thing you might want to consider as well is the case of compounds not
associated  with files (such as the initial EXCHANGEID, CREATESESSION).
- A naughty client can do a pretty good job of a DOS with those.

Right now there is SP4_NONE and SP4_MACH_CRED for Kerberos.
I have tried to suggest to the NFSv4 working group that SP4_MACH_CRED
should be allowed for the mtls case as well, although I'm not sure it has
gained traction. (Something might be buried in David Noveck's security
draft. I haven't gotten around to looking at it lately.)

rick

>
>
> What about pre-shared keys? No certificate fields there.
>
>
> --
> Chuck Lever

