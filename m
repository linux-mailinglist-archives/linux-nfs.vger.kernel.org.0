Return-Path: <linux-nfs+bounces-11941-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA98AC5FAC
	for <lists+linux-nfs@lfdr.de>; Wed, 28 May 2025 04:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD7BA9E0EA1
	for <lists+linux-nfs@lfdr.de>; Wed, 28 May 2025 02:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885C77F7FC;
	Wed, 28 May 2025 02:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cn24f8t4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5558E28E0F
	for <linux-nfs@vger.kernel.org>; Wed, 28 May 2025 02:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748400510; cv=none; b=ugPNPOA3HvVaoF0BeUV2xje6KBJo1J+dHsmeV9ZBVZCz3ydtUHToCWgYRCbey2l1sxJZaY1rEgt+5xQGX9t9IJHkxICqwqzfcLNGafiIBDYSTwQPFojHxctSanBITjihnJOjRXzrrzsg/j50YRmItzJEAmzx3ya2K0rEmju7y0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748400510; c=relaxed/simple;
	bh=MzDz2ulc+VQaM62mIyWQmOfGbQJ/63JFIP2XwlY60T4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u9i0MZapgxrHbF4HAGtnoZ0EcbLWTX3750MEvzqt/IGOT7N3UI7jtKs6nSK95NXliHHfmcqza1RoJQOClmSKpMcBowYlWiBuPJftxPVrWvFWP3T58utsFn8yLhtP6V5uXqdzYQqx0dKx6N1aShQVNAv8AeX4tbjmEt4FJzLhPpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cn24f8t4; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-601f278369bso8166350a12.1
        for <linux-nfs@vger.kernel.org>; Tue, 27 May 2025 19:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748400506; x=1749005306; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ABLs8GI/jPw1zGmiQ4vNIFEB3X6GwD5hM3qy89QCWuQ=;
        b=cn24f8t4Hqu8k+FEjkf7FbbfyqHoGRQ5rbUVq7GeEewPG9CRS7QnqAtNbKG5fUtTmf
         Cq4PeowdAMQA8smQpzfDl7Svdb++x91uQ1KW+MlzyXMxUbovD3tJPcd1+iyrWyN/JToH
         tPYKeXDEaJVNKoE4LTrOQBpEhqTvh0m67Dum6FunOTwNrhObeymjdAzi6FPmxOWVKTIr
         uVgcMherWeqVH5sLC+mJ16WZr5ugfVRpzZRjZGDF9dtV+0j87tmYuIVrozAd2H+UCfBO
         1AskXPG3/RmBRN9rRTVHqEn69pqdDCQnvkELpmTkqukULbJsuHHYgio/DUYv7nw167Pa
         oJuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748400506; x=1749005306;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ABLs8GI/jPw1zGmiQ4vNIFEB3X6GwD5hM3qy89QCWuQ=;
        b=Qf9pDF13miZJbvRXCgFtSTNWE3bhdYQK4zHD0flEpIoP7ihFBc31TOw6LsW8x5WHIR
         WHqqtuEjavwtXuyRUzhb+tXnMCplUupzGwMs52fgmgVtWk3SV+fkNNKKzRWnn2z4M53i
         qRcxKc+tNjhn5I1uQRkirZTe7YUedDXyfbio7xS9ggmfcrR9jwzBSHVXR+nKzeKYxhzb
         ndXfcE5BQCEUzkqEeFLS49Vscup6uYupci5ekTJvKWQJAE6PFpeEBkffWBNikAfS/NVm
         4yr2LUp0P2sOT7uIRNUQF2nKEsFvSiQqNqvKMMtlrMyUbO7nYZ+8mHuvsF4OWBrstauv
         ApZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnd92LYKB3BOKOYb01W+kCHAl6wBvLMmKWOWcBt+UHUWAQH2gfK6mW94KZThVC767HlwVXqiqZFiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF+E12OWN8YB/U5nEuJoN47tNOB8vk+4Kryk0wWBPUc7NapcGk
	wsgy+rvO/QlRmAI9kN3Onheqg0xXJ8jnXQ8TBMlU39AzzQn6UJURCaJbWYI+sg3sUKQNA8jJ63X
	uzWzoyXqbpeNRJpAByHN7c/VH3Bc77A==
X-Gm-Gg: ASbGncuw6U/F0WWruqczUYKQ4GoCEitRd+lC2sLjQGmwNyHl2OTQaGW8iN7/oCDo5Kk
	fu+8nncTEhBrSiETDD0yeiPhnDbTViPdT0pIB9/dbR2xzM48tLoRfhSMCRuSKDM8suVnUr5d4bC
	a6o574Gu3FxM0j1H+e6gorNcc4jThnvAzd
X-Google-Smtp-Source: AGHT+IH+f+GoS06xepo6OQZwNN0zPxKuZZK/IfaawW8KQkpGd0euqBHVw9pJexqxUUTg1MAVtwfI0FbTBtAxsDjJN2o=
X-Received: by 2002:a05:6402:280d:b0:600:e549:3c19 with SMTP id
 4fb4d7f45d1cf-6051c33c687mr296435a12.1.1748400506111; Tue, 27 May 2025
 19:48:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e6daff16-2949-4413-b801-58393d9cb993@oracle.com> <174839547480.608730.18119418768033620929@noble.neil.brown.name>
In-Reply-To: <174839547480.608730.18119418768033620929@noble.neil.brown.name>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Tue, 27 May 2025 19:48:13 -0700
X-Gm-Features: AX0GCFvFn3JG4yByKTmHtyStAG2v5MPAf8u_0El7MgFMcXpwIvMMHYP_tlDbjW0
Message-ID: <CAM5tNy70Q4Q8s2J=DqufXfFKNh97gCBg36ozm=VNYw0WVE281Q@mail.gmail.com>
Subject: Re: [PATCH nfs-utils] exportfs: make "insecure" the default for all exports
To: NeilBrown <neil@brown.name>
Cc: Chuck Lever <chuck.lever@oracle.com>, Benjamin Coddington <bcodding@redhat.com>, 
	Jeff Layton <jlayton@kernel.org>, Steve Dickson <steved@redhat.com>, Tom Haynes <loghyr@gmail.com>, 
	linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 27, 2025 at 6:24=E2=80=AFPM NeilBrown <neil@brown.name> wrote:
>
> On Wed, 28 May 2025, Chuck Lever wrote:
> > On 5/27/25 3:18 PM, Benjamin Coddington wrote:
> > > On 27 May 2025, at 11:05, Chuck Lever wrote:
> > >
> > >> On 5/25/25 8:09 PM, NeilBrown wrote:
> > >>> On Mon, 26 May 2025, Chuck Lever wrote:
> > >>>> On 5/20/25 9:20 AM, Chuck Lever wrote:
> > >>>>> Hiya Rick -
> > >>>>>
> > >>>>> On 5/19/25 9:44 PM, Rick Macklem wrote:
> > >>>>>
> > >>>>>> Do you also have some configurable settings for if/how the DNS
> > >>>>>> field in the client's X.509 cert is checked?
> > >>>>>> The range is, imho:
> > >>>>>> - Don't check it at all, so the client can have any IP/DNS name =
(a mobile
> > >>>>>>   device). The least secure, but still pretty good, since the er=
t. verified.
> > >>>>>> - DNS matches a wildcard like *.umich.edu for the reverse DNS na=
me for
> > >>>>>>    the client's IP host address.
> > >>>>>> - DNS matches exactly what reverse DNS gets for the client's IP =
host address.
> > >>>>>
> > >>>>> I've been told repeatedly that certificate verification must not =
depend
> > >>>>> on DNS because DNS can be easily spoofed. To date, the Linux
> > >>>>> implementation of RPC-with-TLS depends on having the peer's IP ad=
dress
> > >>>>> in the certificate's SAN.
> > >>>>>
> > >>>>> I recognize that tlshd will need to bend a little for clients tha=
t use
> > >>>>> a dynamically allocated IP address, but I haven't looked into it =
yet.
> > >>>>> Perhaps client certificates do not need to contain their peer IP
> > >>>>> address, but server certificates do, in order to enable mounting =
by IP
> > >>>>> instead of by hostname.
> > >>>>>
> > >>>>>
> > >>>>>> Wildcards are discouraged by some RFC, but are still supported b=
y OpenSSL.
> > >>>>>
> > >>>>> I would prefer that we follow the guidance of RFCs where possible=
,
> > >>>>> rather than a particular implementation that might have historica=
l
> > >>>>> reasons to permit a lack of security.
> > >>>>
> > >>>> Let me follow up on this.
> > >>>>
> > >>>> We have an open issue against tlshd that has suggested that, rathe=
r
> > >>>> than looking at DNS query results, the NFS server should authorize
> > >>>> access by looking at the client certificate's CN. The server's
> > >>>> administrator should be able to specify a list of one or more CN
> > >>>> wildcards that can be used to authorize access, much in the same w=
ay
> > >>>> that NFSD currently uses netgroups and hostnames per export.
> > >>>>
> > >>>> So, after validating the client's CA trust chain, an NFS server ca=
n
> > >>>> match the client certificate's CN against its list of authorized C=
Ns,
> > >>>> and if the client's CN fails to match, fail the handshake (or what=
ever
> > >>>> we need to do).
> > >>>>
> > >>>> I favor this approach over using DNS labels, which are often
> > >>>> untrustworthy, and IP addresses, which can be dynamically reassign=
ed.
> > >>>>
> > >>>> What do you think?
> > >>>
> > >>> I completely agree with this.  IP address and DNS identity of the c=
lient
> > >>> is irrelevant when mTLS is used.  What matters is whether the clien=
t has
> > >>> authority to act as one of the the names given when the filesystem =
was
> > >>> exported (e.g. in /etc/exports).  His is exacly what you said.
> > >>>
> > >>> Ideally it would be more than just the CN.  We want to know both th=
e
> > >>> domain in which the peer has authority (e.g.  example.com) and the =
type
> > >>> of authority (e.g.  serve-web-pages or proxy-file-access or
> > >>> act-as-neilb).
> > >>> I don't know internal details of certificates so I don't know if th=
ere
> > >>> is some other field that can say "This peer is authorised to proxy =
file
> > >>> access requests for all users in the given domain" or if we need a =
hack
> > >>> like exporting to nfs-client.example.com.
> > >>>
> > >>> But if the admin has full control of what names to export to, it is
> > >>> possible that the distinction doesn't matter.  I wouldn't want the
> > >>> certificate used to authenticate my web server to have authority to
> > >>> access all files on my NFS server just because the same domain name
> > >>> applies to both.
> > >>
> > >> My thought is that, for each handshake, there would be two stages:
> > >>
> > >> 1. Does the NFS server trust the certificate? This is purely a chain=
-of-
> > >>    trust issue, so validating the certificate presented by the clien=
t is
> > >>    the order of the day.
> > >>
> > >> 2. Does the NFS server authorize this client to access the export? T=
his
> > >>    is a check very similar to the hostname/netgroup/IP address check
> > >>    that is done today, but it could be done just once at handshake t=
ime.
> > >>    Match the certificate's fields against a per-export filter.
> > >>
> > >> I would take tlshd out of the picture for stage 2, and let NFSD make=
 its
> > >> own authorization decisions. Because an NFS client might be authoriz=
ed
> > >> to access some exports but not others.
> > >>
> > >> So:
> > >>
> > >> How does the server indicate to clients that yes, your cert is trust=
ed,
> > >> but no, you are not authorized to access this file system? I guess t=
hat
> > >> is an NFS error like NFSERR_STALE or NFS4ERR_WRONGSEC.
> > >>
> > >> What certificate fields should we implement matches for? CN is obvio=
us.
> > >> But what about SAN? Any others? I say start with only CN, but I'd li=
ke
> > >> to think about ways to make it possible to match against other field=
s in
> > >> the future.
> > >>
> > >> What would the administrative interface look like? Could be the mach=
ine
> > >> name in /etc/exports, for instance:
> > >>
> > >> *,OU=3D"NFS Bake-a-thon",*   rw,sec=3Dsys,xprtsec=3Dmtls,fsid=3D42
> > >>
> > >> But I worry that will not be flexible enough. A more general filter
> > >> mechanism might need something like the ini file format used to crea=
te
> > >> CSRs.
> > >
> > > It might be useful to make the kernel's authorization based on mappin=
g to a
> > > keyword that tlshd passes back after the handshake, and keep the more
> > > complicated logic of parsing certificate fields and using config file=
s up in
> > > ktls-utils userspace.
> >
> > I agree that the kernel can't do the filtering.
> >
> > But it's not possible that tlshd knows what export the client wants to
> > access during the TLS handshake; no NFS traffic has been exchanged yet.
> > Thus parsing per-export security settings during the handshake is not
> > possible; it can happen only once tlshd passes the connected socket bac=
k
> > to the kernel.
> >
> > And remember that ktls-utils is shared with NVMe and now QUIC as well.
> > tlshd doesn't know anything about the upper layer protocols. Therefore
> > adding NFS-specific authorization policy settings to ktls-utils is a
> > layering violation.
> >
> > What makes the most sense is that the handshake succeeds, then NFSD
> > permits the client to access any export resources that the server's
> > per-export security policy allows, based on the client's cert.
>
> We certainly need a mapping between content of the certificate and an
> "auth_domain" as understood by net/sunrpc, then a mapping from
> auth_domain and filesystem to export options - we already have the
> latter.
>
> There seem to be two option for the first mapping.
> 1/ tlshd can pass the "important" parts of the certificate (and the PSK
>   info) to the sunrpc module much as the IP layer currently passes the IP
>   address and port number to the sunrpc module.  sunrpc then passes this =
up to
>   mountd which does whatever mapping magic we want and passes down an
>   auth_domain which is then used for further lookup.
>
> 2/ tlshd can do some initial interpretation of the certificate (and PSK)
>   and determine one or more tags which serve to sufficiently classify the
>   certificate for local needs.  It passes them to sunrpc and thence to
>   mountd which gives relevant details to nfsd.
>
> So the core question is: what sort of info do we want to pass from tlshd
> to mountd (via sunrpc) and where is the processing easiest.  Or maybe:
> which part of the processing can usefully be shared with other clients
> of tlshd and which are truly nfsd-specific?
I'm a simple minded guy, so here's a simple minded suggestion...
Define CNs using a DNS like syntax. For example:
alice.faculty.cis.uoguelph.ca
bob.student.cis.uoguelph.ca

When a handshake gets the cert., extract the above CN and push it
into the kernel, associated with the TCP connection.

Then in /etc/exports, specify a CN or a wildcarded suffix. For example:
/exports/faculty/alice
(rw,sec=3Dsys,xprtsec=3Dmtls,cn=3Dalice.faculty.cis.uoguelph.ca)
/exports/faculty/data (rw,sec=3Dsys,xprtsec=3Dmtls,cn=3D*.faculty.cis.uogue=
lph.ca)
/exports/students (rw,sec=3Dsys,xprtsec=3Dmtls,cn=3D*.student.cis.uoguelph.=
ca)

Then whatever processes /etc/exports pushes the cn strings into the kernel,
associating them with the file systems.

Then, when an RPC request arrives on the TCP connection, tag it with the
CN string (alice.faculty.cis.uoguelph.ca or bob.student.cis.uoguelph.ca)
and when exports need to be checked for a file system, it is just a string
compare (either the whole string or a suffix when wildcarded).

You can use the same string comparison rules as DNS names. Ascii case
independent and Puny encoding for non-ascii chars.

rick


>
> I'd be inclined to keep as much understanding of the various details of
> certificates in tlshd as possible.  It has to deal with some of that
> complexity, and mountd really doesn't.
>
> >
> >
> > > I'm imagining something like this in /etc/exports:
> > >
> > > /exports *(rw,sec=3Dsys,xprtsec=3Dmtls,tlsauth=3Dany)
> > > /exports/home *(rw,sec=3Dsys,xprtsec=3Dmtls,tlsauth=3Dusers)
> > >
> > > .. and then tlshd would do the work to create a map of authorized
> > > certificate identities mapped to a keyword, something like:
> > >
> > > CN=3D*                any
> > > CN=3D*.nfsv4bat.org   users
> > > SHA1=3D4EB6D578499B1CCF5F581EAD56BE3D9B6744A5E5   bob
> >
> > I think mountd is going to have to do that, somehow. It already knows
> > about netgroups, for example, and this is very similar.
>
> netgroups is a good example.  mountd knows what a netgroup is but
> doesn't really know about the internal details.  There is a function
> "innetgr()" which it calls to do the required magic.  We similarly want
> a simple way for mountd to know that a given certificate matches a given
> tlsgroup.  A library function would be OK.  strcmp would be good too.
>
> We export to a netgroups as:
>         /path @netgroup(options)
> could we export to a certificate as
>         /path &tlsgroup(options)
> ??
>
> It's always seems weird to me have the "sec=3D" in the options list.
> The authentication bit comes before the options.  An IP address or
> hostname meand AUTH_SYS. A krb5 indicator means krb5 etc....
> But that isn't the way we went .... unfortunately??
>
> Thanks,
> NeilBrown
>
>
> >
> >
> > > I imagine more flexible or complex rule logic might be desired in the
> > > future, and having that work land in ktls-utils would be nicer than h=
aving
> > > to do kernel work or handling various bits of certificate logic or re=
verse
> > > lookups in-kernel.
> >
> > I agree that the kernel will have to be hands off (or, it will act as a
> > pipe between the user space pieces that actually handle the security
> > policy, if you will).
> >
> >
> > --
> > Chuck Lever
> >
>
>

