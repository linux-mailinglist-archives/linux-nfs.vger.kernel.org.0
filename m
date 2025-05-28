Return-Path: <linux-nfs+bounces-11939-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66CFBAC5E9D
	for <lists+linux-nfs@lfdr.de>; Wed, 28 May 2025 03:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16FB84A03F2
	for <lists+linux-nfs@lfdr.de>; Wed, 28 May 2025 01:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0BA2AE6D;
	Wed, 28 May 2025 01:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L+zmuvo+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601CF23A6
	for <linux-nfs@vger.kernel.org>; Wed, 28 May 2025 01:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748394400; cv=none; b=MRCumLVtll/4opzIeWTI+G6HntKtiM1l5PCVZem16vEbKI/KHQrT+/pPRxjKHWPpXpiKZizDLrc7xieScj2pJQDaH9zhhBW235KSKXPWpv9LeaReebrQrKL091U+MoND6NDALpgpkWyk5j1ZBrMziC82E6E6UbTwKjpmKaFUaEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748394400; c=relaxed/simple;
	bh=b2JBPQeI/srTnXSLT5hCufnLaB5Reg55GE0ssLbUcI4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZyVy8UREkPKaPp+973kbdDlAwD6GhwWL3MJu7xFf6GUQS/V2o8dGine5roMDdxtGIyb/OSHDAQDJHDDO9Bh+x4viL3qEhiZgFGdEwrhcw7zcyxvGwE/jWXsvEUx/HJczb/7/X8sJOq6U9EL4Mr7aW3oWcIgrt+MWUOVcU0CnW1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L+zmuvo+; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6046ecc3e43so4744878a12.3
        for <linux-nfs@vger.kernel.org>; Tue, 27 May 2025 18:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748394397; x=1748999197; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GN8P9fH3X3n4T/S9pDH57JME3AI4/3/zBQYtrrUBuh4=;
        b=L+zmuvo+tPj1TWjdy1p7aaT/gvPtVKVjHt5UOQkFHe6HTYhQJXaLNBBUYN0XWjbIuQ
         Hbfmo1/XdpgaTDukBLChBfI+xiWGjNTZTkQSYQL0SS9/jKdgNhdKaAMGwM4U1DK/4IPY
         9WoUexeMqTR/X0/NEwtrFANJVDOCLn3qnK+08dWdQHy1K86bfEYrmMrYnbZkg1YOLjCq
         +cpVTBUmWBgxjury2dFpJJ0gqQddNUkYg1ddF3n2mYnlwh3WZ6rUU3uyW7N6yaoejYWH
         wKvebLWXeUzdB9+l1/Ll1Gy56C5MO5tA1RgkUf6EK2oqq11rj3rIxUDFsUBs4ScF3JHt
         wbIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748394397; x=1748999197;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GN8P9fH3X3n4T/S9pDH57JME3AI4/3/zBQYtrrUBuh4=;
        b=brbSExoK6EKgGu3J7hzLVV1qGg0JXdy4IYjfThIMxrcTzQJX3ufG4AzgB/BYEw1RwS
         yfaPkcm0bvxTeepiJbZYeeDWRkXnnGSG+WDaSno57hv5XSKFg4Pd21VT6cRoM4ZN+uMV
         u3cqFNYGoCNWjny6t6qivefRhyuFo/gCB1cmTRLA4gG9s/9rQl8fygTqSe+/k9JgYi97
         jbDPdtEDZ9ycQUc2IGdwyynSVLob5vl3+69e5AOL6opI3ZacnF9+f5Rtkcu1k+1Z/2Xg
         hyRYWmCNSBfwO/hNDJfnGYcq78HXSAJWV/AMnxwiUVBN8LqxwSWdmE6cVZrd3lYOrj+6
         24Fw==
X-Forwarded-Encrypted: i=1; AJvYcCV8yWx5ZVgsFqRGa626aB/yog7ubCjBbZKwD2Y2sdbesZaMRneFIsxf7i/eAh4kO1Uzt2cucrmsydE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGWMrsR84lyJS2w3eLqOCOtCw5KYwtw+ZYQmT0PjTTDmKsPnNc
	uOZ4BhejWTmJ3FDcGrLuRQjhR5cTqxxQKUVa/ShOtvmLffRR/uZrcLHfyUD/yX/zv0wtAdBWHOm
	+TjIJl/RfDRvLqVB7AFwTVhhO6TiCBg==
X-Gm-Gg: ASbGncvzxR62gVz3jhDVJRZ3jtvtt31SpWiAqZdXoDqcM/qCsZ3/DHCxr3hwWHrm8tq
	V/1OcO5FJlLr98heo6AJbUTyH/GpLpSgOp3Ftq3hXNFvZvUElgfVn4/dp/R+FSamJH31xeMw9+3
	6kAdVd6JsyUBlJrVqzd89HqDsEVo9gazXV
X-Google-Smtp-Source: AGHT+IEl+Qx6pX7CrJSqHdwSnIAWmGF+1PwJ+p9KvMiw+vNUDCx6IWdITA8apGK1VukcUtxaHchR7Ej7HB2CHxo1d7o=
X-Received: by 2002:a05:6402:35d3:b0:5f8:afab:9e14 with SMTP id
 4fb4d7f45d1cf-6051c5076bamr196472a12.28.1748394396496; Tue, 27 May 2025
 18:06:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d539c502-e776-460f-852c-8af9722ad9f8@oracle.com>
 <174821817646.608730.16435329287198176319@noble.neil.brown.name>
 <f679b62b-cbf3-4225-a163-870c65ff0c9b@oracle.com> <CAM5tNy6sgLg1HFBBkRe5JoXbrDjWiJfoxW3S-ZHh7HGSoVXzgQ@mail.gmail.com>
 <3b1f01ad-2c20-4e3a-8543-c3fd6bf20086@oracle.com>
In-Reply-To: <3b1f01ad-2c20-4e3a-8543-c3fd6bf20086@oracle.com>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Tue, 27 May 2025 18:06:24 -0700
X-Gm-Features: AX0GCFsFwxK0t7arpepXuMVirFD_nxVd2wFAjaecyUxSr2pbdlA89kc5L39F3c8
Message-ID: <CAM5tNy5jp7Swoa_NpaTyaSkvDhYtRk0aFO=NSyuFLTBCrwTt4A@mail.gmail.com>
Subject: Re: [PATCH nfs-utils] exportfs: make "insecure" the default for all exports
To: Chuck Lever <chuck.lever@oracle.com>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>, 
	Steve Dickson <steved@redhat.com>, Tom Haynes <loghyr@gmail.com>, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 27, 2025 at 9:58=E2=80=AFAM Chuck Lever <chuck.lever@oracle.com=
> wrote:
>
> On 5/27/25 12:29 PM, Rick Macklem wrote:
> > On Tue, May 27, 2025 at 8:05=E2=80=AFAM Chuck Lever <chuck.lever@oracle=
.com> wrote:
> >>
> >> On 5/25/25 8:09 PM, NeilBrown wrote:
> >>> On Mon, 26 May 2025, Chuck Lever wrote:
> >>>> On 5/20/25 9:20 AM, Chuck Lever wrote:
> >>>>> Hiya Rick -
> >>>>>
> >>>>> On 5/19/25 9:44 PM, Rick Macklem wrote:
> >>>>>
> >>>>>> Do you also have some configurable settings for if/how the DNS
> >>>>>> field in the client's X.509 cert is checked?
> >>>>>> The range is, imho:
> >>>>>> - Don't check it at all, so the client can have any IP/DNS name (a=
 mobile
> >>>>>>   device). The least secure, but still pretty good, since the ert.=
 verified.
> >>>>>> - DNS matches a wildcard like *.umich.edu for the reverse DNS name=
 for
> >>>>>>    the client's IP host address.
> >>>>>> - DNS matches exactly what reverse DNS gets for the client's IP ho=
st address.
> >>>>>
> >>>>> I've been told repeatedly that certificate verification must not de=
pend
> >>>>> on DNS because DNS can be easily spoofed. To date, the Linux
> >>>>> implementation of RPC-with-TLS depends on having the peer's IP addr=
ess
> >>>>> in the certificate's SAN.
> >>>>>
> >>>>> I recognize that tlshd will need to bend a little for clients that =
use
> >>>>> a dynamically allocated IP address, but I haven't looked into it ye=
t.
> >>>>> Perhaps client certificates do not need to contain their peer IP
> >>>>> address, but server certificates do, in order to enable mounting by=
 IP
> >>>>> instead of by hostname.
> >>>>>
> >>>>>
> >>>>>> Wildcards are discouraged by some RFC, but are still supported by =
OpenSSL.
> >>>>>
> >>>>> I would prefer that we follow the guidance of RFCs where possible,
> >>>>> rather than a particular implementation that might have historical
> >>>>> reasons to permit a lack of security.
> >>>>
> >>>> Let me follow up on this.
> >>>>
> >>>> We have an open issue against tlshd that has suggested that, rather
> >>>> than looking at DNS query results, the NFS server should authorize
> >>>> access by looking at the client certificate's CN. The server's
> >>>> administrator should be able to specify a list of one or more CN
> >>>> wildcards that can be used to authorize access, much in the same way
> >>>> that NFSD currently uses netgroups and hostnames per export.
> >>>>
> >>>> So, after validating the client's CA trust chain, an NFS server can
> >>>> match the client certificate's CN against its list of authorized CNs=
,
> >>>> and if the client's CN fails to match, fail the handshake (or whatev=
er
> >>>> we need to do).
> >>>>
> >>>> I favor this approach over using DNS labels, which are often
> >>>> untrustworthy, and IP addresses, which can be dynamically reassigned=
.
> >>>>
> >>>> What do you think?
> >>>
> >>> I completely agree with this.  IP address and DNS identity of the cli=
ent
> >>> is irrelevant when mTLS is used.  What matters is whether the client =
has
> >>> authority to act as one of the the names given when the filesystem wa=
s
> >>> exported (e.g. in /etc/exports).  His is exacly what you said.
> >>>
> >>> Ideally it would be more than just the CN.  We want to know both the
> >>> domain in which the peer has authority (e.g.  example.com) and the ty=
pe
> >>> of authority (e.g.  serve-web-pages or proxy-file-access or
> >>> act-as-neilb).
> >>> I don't know internal details of certificates so I don't know if ther=
e
> >>> is some other field that can say "This peer is authorised to proxy fi=
le
> >>> access requests for all users in the given domain" or if we need a ha=
ck
> >>> like exporting to nfs-client.example.com.
> >>>
> >>> But if the admin has full control of what names to export to, it is
> >>> possible that the distinction doesn't matter.  I wouldn't want the
> >>> certificate used to authenticate my web server to have authority to
> >>> access all files on my NFS server just because the same domain name
> >>> applies to both.
> >>
> >> My thought is that, for each handshake, there would be two stages:
> >>
> >> 1. Does the NFS server trust the certificate? This is purely a chain-o=
f-
> >>    trust issue, so validating the certificate presented by the client =
is
> >>    the order of the day.
> >>
> >> 2. Does the NFS server authorize this client to access the export? Thi=
s
> >>    is a check very similar to the hostname/netgroup/IP address check
> >>    that is done today, but it could be done just once at handshake tim=
e.
> >>    Match the certificate's fields against a per-export filter.
> >>
> >> I would take tlshd out of the picture for stage 2, and let NFSD make i=
ts
> >> own authorization decisions. Because an NFS client might be authorized
> >> to access some exports but not others.
> >>
> >> So:
> >>
> >> How does the server indicate to clients that yes, your cert is trusted=
,
> >> but no, you are not authorized to access this file system? I guess tha=
t
> >> is an NFS error like NFSERR_STALE or NFS4ERR_WRONGSEC.
> >>
> >> What certificate fields should we implement matches for? CN is obvious=
.
> >> But what about SAN? Any others? I say start with only CN, but I'd like
> >> to think about ways to make it possible to match against other fields =
in
> >> the future.
> > Just fyi, here's an example where filtering on the DNS or IP field in t=
he
> > SAN (SubjectAltName) could improve security..
> > (Dusting off my CS sysadmin hat.)
> >
> > Suppose I had a file system where student grades and exam questions
> > were stored.
> > The mount was restricted to faculty offices, where their machines had f=
ixed
> > well known IP addresses and FQDNs assigned.
> > However, as it was for my case, the building their offices were in also=
 had
> > student labs and the building was assigned a subnet by the campus
> > networking folk.
> > --> As such, a student could easily come in off hours (when the faculty=
 were not
> >      around and, as such, had their office computers shut down) and
> > plug into the
> >      subnet (they just had to find an RJ45 jack somewhere that they
> > could access).
> >      --> They could then set their laptop up with the same IP address
> > as a faculty
> >            member's office computer and defeat ordinary /etc/exports
> > filtering based
> >            on client IP address.
> >
> > However, these students would not have the X.509 cert. with a DNS or IP=
 field
> > set to the correct address in it. (They might have a valid cert. so
> > their laptop can
> > mount the file systems students have coursework assignments on, but it =
would
> > not have the DNS or IP of a faculty member's office computer.)
> > --> This additional filtering would stop them from accessing the
> > marks/exam question
> >       file system (or at least make it a lot harder for them to do so).
> >
> > As already discussed, there is a tradeoff between using DNS or IP. (I'l=
l admit
> > FreeBSD doesn't currently support the IP case, but it probably should.)
>
> To be clear, there is a marked difference between relying on reverse DNS
> queries versus relying on a DNS hostname or IP address contained in a
> client certificate's SAN field. DNS queries are untrustworthy, but
> fields in a certificate (once its trust chain has been validated) are OK
> to use, IMO.
Yes, after sending this (an early morning brain fart;-) I realized I actual=
ly
just demonstrated a case where the IP or DNS field matching the client's
host IP address was not useful.
--> For the above example, it only shows that certs. can be differentiated
      between student and faculty.

However, having the IP/DNS match work limits the use of a compromised
cert. to the subnet it was meant to be used on.
Or, put another way, if the faculty offices are on a separate subnet from
the student labs, the students would have difficulties using a compromised
cert. before it ends up in a CRL. (Admittedly, for separate subnets, just
filtering on client host IP address as /etc/exports now does can work, as w=
ell.)

Another advantage of using client certs is the "identity squashing" case,
where the cert. identifies the user, avoiding any need for Kerberos.
(Then, if the compromised cert. cannot be used outside of the subnet
it was issued for, you are in a better place than if the compromised cert.
can be used from anywhere.)

I do think CRLs should be supported, but it takes a while for someone
to realize a cert. has been compromised and then do what it takes to
get it into a CRL (notifying the sysadmin or ??).

rick

>
> But I would like NFSD's administrative interface to be unambiguous about
> which DNS/IP information is being matched against.
>
>
> > rick
> >
> >>
> >> What would the administrative interface look like? Could be the machin=
e
> >> name in /etc/exports, for instance:
> >>
> >> *,OU=3D"NFS Bake-a-thon",*   rw,sec=3Dsys,xprtsec=3Dmtls,fsid=3D42
> >>
> >> But I worry that will not be flexible enough. A more general filter
> >> mechanism might need something like the ini file format used to create
> >> CSRs.
> >>
> >>
> >> What about pre-shared keys? No certificate fields there.
> >>
> >>
> >> --
> >> Chuck Lever
>
>
> --
> Chuck Lever

