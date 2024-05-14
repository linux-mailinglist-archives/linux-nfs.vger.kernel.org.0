Return-Path: <linux-nfs+bounces-3257-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C678C5D99
	for <lists+linux-nfs@lfdr.de>; Wed, 15 May 2024 00:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0884282D79
	for <lists+linux-nfs@lfdr.de>; Tue, 14 May 2024 22:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7915C181CFB;
	Tue, 14 May 2024 22:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earthlink.net header.i=@earthlink.net header.b="CJXcModG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mta-102a.earthlink-vadesecure.net (mta-102a.earthlink-vadesecure.net [51.81.61.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C34F181CE9
	for <linux-nfs@vger.kernel.org>; Tue, 14 May 2024 22:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.81.61.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715725130; cv=none; b=noUGdE023c1/+GYNJHeji1em15jHP56gfdj/2uZt3i8uo5lIYNvqMD1scnnF30Sxw6dQ/te0PVZycldKeyfT0sYxrPsvW1rho2PFYCbGmMyRwVBmtArHNlznCoaoKgALdey89LHsnlOc3XeRPHePOj1YFXWLoGZeSj10TmBVyTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715725130; c=relaxed/simple;
	bh=wsQ3S2Qw2jrfkdv5Sza1kfOD2kHWvZdCoUJjA0tMfsI=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=F4RCslBp4gVHSBuj0/nBYxwZg8Pc1uuSWYbKDi4YHLKjH4aeCsjDVK2a+DyjO69+JV2+lMzm5Xj0+DeSZxcm13Dqqwujd3v7njvWOCHyMG8HJ6dbcO4NVEDRore05obRaSKQZvPtjE/wAn6o+QCHXe5qP/yYfr0ovAvuGIWnWNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mindspring.com; spf=pass smtp.mailfrom=mindspring.com; dkim=pass (2048-bit key) header.d=earthlink.net header.i=@earthlink.net header.b=CJXcModG; arc=none smtp.client-ip=51.81.61.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mindspring.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mindspring.com
DKIM-Signature: v=1; a=rsa-sha256; bh=wsQ3S2Qw2jrfkdv5Sza1kfOD2kHWvZdCoUJjA0
 tMfsI=; c=relaxed/relaxed; d=earthlink.net; h=from:reply-to:subject:
 date:to:cc:resent-date:resent-from:resent-to:resent-cc:in-reply-to:
 references:list-id:list-help:list-unsubscribe:list-subscribe:list-post:
 list-owner:list-archive; q=dns/txt; s=dk12062016; t=1715724813;
 x=1716329613; b=CJXcModGfloIMbTA8IudCc2443sFUoUQfRMCyrKYo8ILuOtjSDPIbNR
 my02X4UcHy+6lzjZPKzLNnB/tJ6XZ3nqZ1mdGfvB6OmZXQSwTFg9sAUhXcd3sqHOMCPoZj2
 PH7A86pF0VJ5R8rzt96o1cvZi2ElrHhlElxFwevw3j4lEqyBLRKUeJA8tLlXc32HiI2lNr1
 AGLSYOFbytAJczwP/L2jnv0dIL491iYVMre2qnZmhpB6Jqv7YGwzp1J/6ixFfP1J9fuvd/r
 XeRsSJpQ2HZphdAHWiHDP26Omax0yZGK1Q/fEPbQRmnPEGVeW17bnw2GjTgFaEIsorsc/D6
 BTg==
Authentication-Results: earthlink-vadesecure.net;
 auth=pass smtp.auth=ffilzlnx@mindspring.com smtp.mailfrom=ffilzlnx@mindspring.com;
Received: from FRANKSTHINKPAD ([174.174.49.201])
 by vsel1nmtao02p.internal.vadesecure.com with ngmta
 id b0b2da87-17cf7aa070535064; Tue, 14 May 2024 22:13:32 +0000
From: "Frank Filz" <ffilzlnx@mindspring.com>
To: "'Olga Kornievskaia'" <aglo@umich.edu>
Cc: "'Chuck Lever III'" <chuck.lever@oracle.com>,
	"'Linux NFS Mailing List'" <linux-nfs@vger.kernel.org>
References: <CAN-5tyFBn3C_CTrsftuYeWJHe7KWxd82YFCyrN9t=az8J4RU0w@mail.gmail.com> <2C80B5BC-AAEC-41F8-BEB6-C920F88C89BB@oracle.com> <0b1101daa646$d26a6300$773f2900$@mindspring.com> <CAN-5tyGECFmtzFsYNSZicPcH4SMKF0yovk6V20sWJ1LrZKzzyA@mail.gmail.com>
In-Reply-To: <CAN-5tyGECFmtzFsYNSZicPcH4SMKF0yovk6V20sWJ1LrZKzzyA@mail.gmail.com>
Subject: RE: sm notify (nlm) question
Date: Tue, 14 May 2024 15:13:32 -0700
Message-ID: <0b1401daa64b$f5831ee0$e0895ca0$@mindspring.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 15.0
Content-Language: en-us
Thread-Index: AQHEASMWtXHACiXspnILht8YFbc9TwH0RebzAOjRexECfegJKbGZvMmA



> -----Original Message-----
> From: Olga Kornievskaia [mailto:aglo@umich.edu]
> Sent: Tuesday, May 14, 2024 2:50 PM
> To: Frank Filz <ffilzlnx@mindspring.com>
> Cc: Chuck Lever III <chuck.lever@oracle.com>; Linux NFS Mailing List =
<linux-
> nfs@vger.kernel.org>
> Subject: Re: sm notify (nlm) question
>=20
> On Tue, May 14, 2024 at 5:36=E2=80=AFPM Frank Filz =
<ffilzlnx@mindspring.com> wrote:
> >
> > > > On May 14, 2024, at 2:56=E2=80=AFPM, Olga Kornievskaia =
<aglo@umich.edu>
> wrote:
> > > >
> > > > Hi folks,
> > > >
> > > > Given that not everything for NFSv3 has a specification, I post =
a
> > > > question here (as it concerns linux v3 (client) implementation)
> > > > but I ask a generic question with respect to NOTIFY sent by an =
NFS server.
> > >
> > > There is a standard:
> > >
> > > https://pubs.opengroup.org/onlinepubs/9629799/chap11.htm
> > >
> > >
> > > > A NOTIFY message that is sent by an NFS server upon reboot has a
> > > > monitor name and a state. This "state" is an integer and is
> > > > modified on each server reboot. My question is: what about state
> > > > value uniqueness? Is there somewhere some notion that this value
> > > > has to be unique (as in say a random value).
> > > >
> > > > Here's a problem. Say a client has 2 mounts to ip1 and ip2 (both
> > > > representing the same DNS name) and acquires a lock per mount. =
Now
> > > > say each of those servers reboot. Once up they each send a =
NOTIFY
> > > > call and each use a timestamp as basis for their "state" value =
--
> > > > which very likely is to produce the same value for 2 servers
> > > > rebooted at the same time (or for the linux server that looks =
like
> > > > a counter). On the client side, once the client processes the =
1st
> > > > NOTIFY call, it updates the "state" for the monitor name (ie a
> > > > client monitors based on a DNS name which is the same for ip1 =
and
> > > > ip2) and then in the current code, because the 2nd NOTIFY has =
the
> > > > same "state" value this NOTIFY call would be ignored. The linux
> > > > client would never reclaim the 2nd lock (but the application
> > > > obviously would never know it's missing a lock)
> > > > --- data corruption.
> > > >
> > > > Who is to blame: is the server not allowed to send "non-unique"
> > > > state value? Or is the client at fault here for some reason?
> > >
> > > The state value is supposed to be specific to the monitored host. =
If
> > > the client is indeed ignoring the second reboot notification, =
that's incorrect
> behavior, IMO.
> >
> > If you are using multiple server IP addresses with the same DNS =
name, you
> may want to set:
> >
> > sysctl fs.nfs.nsm_use_hostnames=3D0
> >
> > The NLM will register with statd using the IP address as name =
instead of host
> name. Then your two IP addresses will each have a separate monitor =
entry and
> state value monitored.
>=20
> In my setup I already have this set to 0. But I'll look around the =
code to see what
> it is supposed to do.

Hmm, maybe it doesn't work on the client side. I don't often test NLM =
clients with my Ganesha work because I only run one VM and NLM clients =
can=E2=80=99t function on the same host as any server other than =
knfsd...

Frank



