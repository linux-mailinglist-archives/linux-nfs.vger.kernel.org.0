Return-Path: <linux-nfs+bounces-11792-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE562ABB2A1
	for <lists+linux-nfs@lfdr.de>; Mon, 19 May 2025 02:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFCE71894B04
	for <lists+linux-nfs@lfdr.de>; Mon, 19 May 2025 00:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A47CA6F;
	Mon, 19 May 2025 00:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VqoLcarq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB9A28E8
	for <linux-nfs@vger.kernel.org>; Mon, 19 May 2025 00:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747614292; cv=none; b=o7wZoXh2rMb+K9oaotkJBDDE0iLANGZWsNwxxHD8gmtebB0Y55VioqJ9+VM0SGm1/0+zgiqie5YkVuqpKfgKZU7iijPf7LRd69eAO8MI9i80SjyFWrT+PrTu02uCrSVMKu058Ot2dnDKe9IUQ1g82tw9C55P+QMhjtAJYGvEvVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747614292; c=relaxed/simple;
	bh=8CIY6BcgL56Q1L8dNpqZQ4wtPKbcD9mnosKyFtvSFwQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G4Hc8a5t9tXL27VSJI7agKYVsEN/qXfeknkL876irIdKdH0oTg+W9hxE6+Zg5KFYmfW/Sn2pwBbZjfbIUmSYEnDhlU4hD0M6eg6kg1Wxqo6pSDDyrvWF8d8MPbB6NPvH/at/Qt/qeSBCHtKZsaFrkZNVQ0mo5Hw61Jff95Dcsmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VqoLcarq; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-601968db16bso3198299a12.3
        for <linux-nfs@vger.kernel.org>; Sun, 18 May 2025 17:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747614288; x=1748219088; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MFXpL3WO3y5oVAdNs755WJna16/zbampsPo5CSINW0Q=;
        b=VqoLcarq2rGz7o5sYBjZQpa9uZr31O5T+ZRfjJyK4dX0t5CxpIZlEMfuOlZampZNpG
         EICM0cwWdMYwi//uCAq+9nhHYcJGt0vQV1+/Dbk0kTRIUFMrLb6b9laKZ1Uc44dVzIhZ
         PS6x9jVGtcXeDzPiH7TJmFaZSJLDcAVx42lWsbO2KQ04ewFyg2BbNcqNnKh7pRy4e1JR
         9uuWYzxFyM9iaLdpkCf1IqNxb3m6WfiVi7PqaInoXo5VWuJIWoZRe24oUe7JNRMaLUg+
         iobLJhN7i3g/gy0Ymoh/pceJWX6pL7gWkDu7M0LsdAeku3XAfvdocbDkfc+n30WOSG3J
         o1QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747614288; x=1748219088;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MFXpL3WO3y5oVAdNs755WJna16/zbampsPo5CSINW0Q=;
        b=at0mRGeto7sgYsOHVvPsCpTDSo1wvV5dNmYW8tqbrh8J4TyNZ2JJ7VZuQKCEKUjzOY
         qmtRHjXE5HCrc8eyIkNSq8r24rVFjeojDXPd/nwx6mMduI+xR25FvKX7mdOndkRwyKoF
         a5UsGeXWk8IaxDOAtSzT8pLXYCbP0/FeZ4ZvBg3i1mfnbnGZPWqs8MS1l6m/b2hbk6Xr
         Y6kkjJoPHLjaL5xaRdbh+Wp45pIjoFXNhIcEseNtTHOkvg/aeFgcHN9yZts4hq+w3Bba
         5G8iC3Z0HVDFMzw0jWlf3U3qafYzLPua7FlTxcjsCnxc2EmD01Z0+LgkHs7z+KO0zgML
         O1Nw==
X-Gm-Message-State: AOJu0YzmN+uIOnFYNqwjlNqc6UHX8caaiS/h+gHcQapQqOddU+J5bc1R
	aeHRBpXdr1NSwDTj0RnMVRS6mx51SfRP9AYs4hgs0S+6+UHtlb+X8/PyvnB59XTcZOknIQ8CrZG
	Qv7g4CK14VqX+tUpVKlP7MVds/Ik5nZG2gaA=
X-Gm-Gg: ASbGncvJCYHqWWH6E6lPKk6mW0W3GqEfTDo5HhSL2ssp2SFdoiGG5dbQrV0MP62KdSJ
	oJcQZhGHGDHAQiPBEirOz74Je/ND9URXBxxDskrOv9gWawjIPH4dxWWnwBTnIezz7gRIFAsYgEn
	pBpkny9/sTIcFOJs6ApXZeFvNpycLnEQHunQyYOf9f1N4pIUoJSB5Ry2pTPDNbqVTO
X-Google-Smtp-Source: AGHT+IHcv6yR9i0NU3doOMnqMrwfB4mdgJmPD10AnKdSPVFVyddWGTkXBoBxMv03HpAVK5mRkN2JUayRHHKaACRpccA=
X-Received: by 2002:a05:6402:2345:b0:601:9be9:b506 with SMTP id
 4fb4d7f45d1cf-6019be9b53bmr6616669a12.14.1747614288192; Sun, 18 May 2025
 17:24:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANH4o6Pvc7wuB0Yh8sEQDRg59_=rUNtnpgJizZ5mmmGNgY5Qrg@mail.gmail.com>
 <4ff815cc-6d9b-4af3-a53a-7700a8f85f08@oracle.com> <CANH4o6OAPvm__cuhUcMEvsSRmHd-XwKYt_wdHYDCOozeho2rqg@mail.gmail.com>
In-Reply-To: <CANH4o6OAPvm__cuhUcMEvsSRmHd-XwKYt_wdHYDCOozeho2rqg@mail.gmail.com>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Sun, 18 May 2025 17:24:34 -0700
X-Gm-Features: AX0GCFtP6xgo5mcqLa0M_yX7o3qYMmIVyUV7uWRHctwf2vldWJPxxYJSviOUayw
Message-ID: <CAM5tNy669D_YwffFEqebor3TqhXMjcPNGTTKLpkp9Lf2+LxSEA@mail.gmail.com>
Subject: Re: Why TLS and Kerberos are not useful for NFS security Re: [PATCH
 nfs-utils] exportfs: make "insecure" the default for all exports
To: Martin Wege <martin.l.wege@gmail.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 18, 2025 at 1:00=E2=80=AFPM Martin Wege <martin.l.wege@gmail.co=
m> wrote:
>
> CAUTION: This email originated from outside of the University of Guelph. =
Do not click links or open attachments unless you recognize the sender and =
know the content is safe. If in doubt, forward suspicious emails to IThelp@=
uoguelph.ca.
>
>
> On Thu, May 15, 2025 at 2:29=E2=80=AFPM Chuck Lever <chuck.lever@oracle.c=
om> wrote:
> >
> > On 5/14/25 5:50 PM, Martin Wege wrote:
> > > On Wed, May 14, 2025 at 1:55=E2=80=AFPM NeilBrown <neil@brown.name> w=
rote:
> > >>
> > >> On Wed, 14 May 2025, Jeff Layton wrote:
> > >> Ignoring source ports makes no sense at all unless you enforce some =
other
> > >> authentication, like krb5 or TLS, or unless you *know* that there ar=
e no
> > >> unprivileged processes running on any client machines.
> > >
> > > I don't like to ruin that party, but this is NOT realistic.
> > >
> > > 1. Kerberos5 support is HARD to set up, and fragile because not all
> > > distributions test it on a regular basis. Config is hard, not all
> > > distributions support all kinds of encryption methods, and Redhat's
> > > crusade&maintainer mobbing to promote sssd at the expense of other
> > > solutions left users with a half broken, overcomplicated Windows
> > > Active Directory clone called sssd, which is an insane overkill for
> > > most scenarios.
> > > gssproxy is also a constant source of pain - just Google for the
> > > Debian bug reports.
> > >
> > > Short: Lack of test coverage in distros, not working from time to
> > > time, sssd and gssproxy are more of a problem than a solution.
> > >
> > > It really only makes sense for very big sites and a support contract
> > > which covers support and bug fixes for Kerberos5 in NFS+gssproxy.
> >
> > Brief general comment: We are well aware of the administrative
> > challenges presented by Kerberos. :-)
>
> Well, the primary roadblock for development and TESTING seems to be
> the absolute insane setup requirements. Every doc I find talks about
> sssd, LDAP, Krb5.
>
> I think what is needed for small scale testing is the so called
> "grocery shop setup":
> Two machines with local accounts (i.e. /etc/passwd), one NFS server
> with Krb5 server, one NFS client with Krb5 client.
> NO LDAP, NO TLS, NO Krb5 preauth
>
> Unfortunately all docs describing that are GONE.
>
> >
> >
> > > 2. TLS: Wanna make NFS even slower? Then use NFS with TLS.
> > >
> > > NFS filesystem over TLS support then feels like working with molasses=
.
> >
> > We'd like to hear quantitative evidence. In general, TLS with a NIC
> > that has encryption offload is going to be faster than NFS/Kerberos wit=
h
> > the privacy service.
>
> You can test it yourself:
> 1. WAN config with 0.1s latency per hop, 2 hops, leads to "simple"
> tasks like mkdir, mkfile, mknod to take > 1.6 seconds.
It doesn't matter if you use TLS or not, a 100msec transit delay is going
to result in abysmal performance.
Btw, last week I was doing remote testing during the Bakeathon from
the centre of the universe (Valemount, BC. A village with a population
about 1000
3 time zones away from Ann Arbor). I got a ping RTT of about 60-70msec,
so a lot better than what you listed above. But, yes, performance was not
terrific. However, with or without TLS doesn't matter for this case.

Try testing with/without TLS when your client->server ping RTT is a
reasonable value.

> 2. Parallelism is ruined by all traffic going through the TLS layer.
I don't see why TLS will make any difference w.r.t. this. Each RPC usually
(not always) ends up as a separate TLS data record. Any serialization is
just the same as a TCP connection without TLS, from what I can see.

> 3. Latency is unbearable high, and [2] is not going to save the
> situation this time (never was a solution anyway)
Yes, but why would you assume this is used in such an environment?
(Try Cifs/SMB over connection with a 100msec transit delay (200msec RTT)
and see how well it performs.)
Maybe someone can try pinging a server "across town" and see what the
RTT is? Also, no one said this was for WAN environments.

Performance (or lack thereof) across WANs is another topic.

> 3. TLS layer does not respect RPC boundaries, a problem shared with
> ssh and other encryption and compression programs.
I cannot comment w.r.t. other implementations, but for FreeBSD, each RPC
message is typically a separate TLS data record, as I noted above.
(Once in a while, two RPC messages may get queued on TCP send queue
such that the KTLS sends them as one TLS data record, but it does not
delay waiting for more data than 1 RPC message before sending a TLS
data record.)

> Simply said, TLS
> has no concept or api similar to TCP CORK, or just flush. RPC packages
> get "stuck" in the TLS layer, leading to excessive waiting times until
> more data arrives. This might even not be fixable without a better TLS
> protocol, or at least an API which handles message boundaries.
It's not a problem for the TLS protocol (a data record can be any size
up to 14K, if I recall correctly. It might be an issue for some TLS
implementation
that chooses to wait for "more data" before sending a small TLS data record=
.

>
> >  krb5p cannot be offloaded, full stop.
>
> Sigh.
>
> Who is claiming that? Same marketing gurus who "foresaw the rise of the T=
LS"?
Well, RPCSEC_GSS using privacy (which is what krb5p is) only encrypts the d=
ata
portion of the RPC message and not the header.
To offload it, the offload hardware would need to know the exact byte
ranges within
the RPC messages to encrypt/decrypt. It isn't going to happen unless the wh=
ole
world adopts RPCSEC_GSS with privacy using Kerberos mechanism.

TLS on the other hand gets used quite a but. When was the last time you acc=
essed
a web site with "http" and not "https"?

>
> >
> > An increasing number of encryption-capable NICs are reaching the
> > marketplace, and the selection of encryption algorithms available for
> > TLS includes some CPU-efficient choices.
>
> Poinnt [3]. TLS is just very poorly suited for RPC, and no hardware
> acceleration will fix that.
Maybe. I have not been able to get any experience with offload hardware.
(I have heard that the QAT stuff does require significant setup time, so I
suspect that it does not help w.r.t. NFS over TLS, which uses lots of
small TLS data records, but I have not seen any test results to confirm thi=
s.)

>
> TLS is designed for large chunk transfers. All the tiny bitsy RPC
> packages don't work well over TLS, unless there is a lot of parallel
> traffic, or large READ or WRITE transfers.
>
> >
> > Thus our expectation is that TLS will become a more performant
> > solution than Kerberos.
>
> Which marketing team came up with that "prediction"?
>
> Judging from WAN experience, judging from the design and API deficits,
> NFS over TLS is simply a failed experiment.
>
> Just some statistics:
> Our company is consulting 86 companies trying to deploy NFS over TLS
> since the beginning of 2024, and NONE of them thinks it is usable,
> ready for production or even close to something like that. Everyone is
> pretty upset about latency spikes, lack of throughput, very high CPU
> usage and other problems.
I will note that without offload hardware, I see about 30% of one CPU core
being used when transferring a large file over a 1Gbps LAN connection
x86-64 with AESNI).
This is fine for clients, but means a server with a lot of NFS over TLS act=
ive
client connections will either need a lot of cores or hardware offload, I t=
hink?

>
> > In addition, the trend is towards always-on
> > encryption (QUICv1). IMO you will not be able to avoid encryption-in-
> > transit in the future.
> >
> >
> > > Exacerbated by Linux's crazy desire to only support hyper-secure
> > > post-quantum encryption method (so no fast arcfour, because that is
> > > "insecure", and everyone is expected to only work with AMD
> > > Threadripper 3995WX), lack of good threading through the TLS eye of
> > > the needle, and LACK of support in NFS clients.
> >
> > I believe the IETF has also broadly discouraged the use of easy-to-
> > defeat encryption algorithms.
>
> Sometimes I think the IETF decisions are a) from Mars or b) done by
> marketing, and not rooted in reality.
I know Elon Musk wants to go to Mars, but I don't think he participates in
IETF meetings.

>
> > Perhaps this desire is not limited to only
> > Linux.
>
> And how should the "small shops" (below what Oracle would call
> multi-million enterprises) should deploy an usable NFS over TLS
> configuration then? Basically you force them to either have ZERO
> security, or a security they CANNOT AFFORD.
I deployed it here at home with nothing except command line openssl.
(There are easier ways to do a site local CA, but it works.)

You can look at:
https://people.freebsd.org/~rmacklem/nfs-over-tls-setup.txt
or for Kerberos
https://people.freebsd.org/~rmacklem/nfs-krb5-setup.txt

rick

> No middle ground.
>
> Which brings us back to the debate of the secure/insecure export
> option, and overkill Krb5 configs like sssd.
>
> >
> > Using a deprecated encryption algorithm means you get very little
> > real security in addition to worse performance, so it's not a good
> > choice.
>
> Then please forget about using TLS. and don't recommend a
> broken-by-design solution.
>
> Thanks,
> Martin
>

