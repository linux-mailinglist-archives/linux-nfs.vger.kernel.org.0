Return-Path: <linux-nfs+bounces-11794-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C326ABB387
	for <lists+linux-nfs@lfdr.de>; Mon, 19 May 2025 05:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25F3D1892CFC
	for <lists+linux-nfs@lfdr.de>; Mon, 19 May 2025 03:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC37126C17;
	Mon, 19 May 2025 03:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YD1gIDru"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB98E11185
	for <linux-nfs@vger.kernel.org>; Mon, 19 May 2025 03:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747624182; cv=none; b=czGwJbbAWFyJDOUcvApvHvfChfSyaSrZqunVv0SPKHjS6ZQ6Wv8vsdo8ap7NKA1yrhNxvmyXCHmJzb9LGaHzQExGepQRxJRf9/gbvE23EfQ8mFFdVZhgbJNpMQLSbrbskbnAlwl78vP3W2hL/kvVasvgh8fHnprtWsPztjc1qRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747624182; c=relaxed/simple;
	bh=kSLYu4uHFlGcIgpBfEybh47j8ev2XTdwoYmxrsBuMzU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q0qnDYp2XIWX/tbUT3C+aHkqjWQaFhcna2LnC9pa+M617Gz6bUgGruSZql6tdCCfKlEsYmPEBmlQ8JF5UHquBHtPS+ulfnfRVRDp2XmswI3bOrB0LneVrqmgDkqyggItBxLkxdslN/Oo3q5D4CBjhOYMubKix5ZszG/G6/ZTfrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YD1gIDru; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-601dd3dfc1fso1408145a12.0
        for <linux-nfs@vger.kernel.org>; Sun, 18 May 2025 20:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747624178; x=1748228978; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fMEYAxHuYVP6XupBEnYcukaYFBJ4HPM3DUfpygG7p1w=;
        b=YD1gIDruOWgTaT7Oe2MSVqsA97O8mbyekHXBXURcYvav94c31MZZqxuToYMjR6l8QR
         8lw6eBICOqnxRxC032V4jMBYNFTrnRA7jSBesq0EQk0rvxarBTzSndDsK3UbMt0B1mFi
         pATey8Ba88ce8peYlO1KNWNFZHJJfv+ut73Ws7SXuFqe+GcBSfpVPE3nIugDUEh7cMZ/
         p2G09FZX9+2mo+TdBIcDFmYZsvW6cOLjtG4ZdRpICPFx1S6CA7y7IoJgsrcdnJmNXrcC
         KRqc2INhmkCnWzAktiuNJUwjULp9f1T2h29J/izjrqzKDvcYROvRHpkIdE1Eu+G6nBeR
         F04A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747624178; x=1748228978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fMEYAxHuYVP6XupBEnYcukaYFBJ4HPM3DUfpygG7p1w=;
        b=AyA203BlQXEJgqGVVU61z+9ezp2EilfKAkhhf5C8xvZs0ftHBDkHnsF5ibrulTBwW+
         tiFQt0uUPCpU4Q1SijUjVCLvaA9kHJCwdRv7vgunkCD94JduA98WtzvTjKmfTOfaD32p
         eHRFZdme3GnJ/tqJLb414Uw1stYYrpMVmpubQ59iK8VfvVsU3ruVAQ1yCexPrMsFcFOf
         mzG0QEkIKb2l8vxHkbbKJjadonc8WrLi3BM8Gvysw76w4kZVp0gLsiPvcuhpjphW2GVB
         ssZbEM0dJ7vVyGzi/Etg92NNutINn+f65QDjLRyM37eYgYfPa63zTpgEyQs0HTQlVVBK
         Bvbg==
X-Gm-Message-State: AOJu0YyfASKjZ/p7isrouB5yqhVycjMNBqcRrW5maCpUmjVLEdrRtYy3
	c4YuugGIwhRFWBRe2sFggVxM7sX3hQKSx3zOy4herFHLV/DfkhttEHXcM52WmU8JudB2F4tecVT
	4o7qO+lTmdinlZj0WG26g/cDMtBy25g==
X-Gm-Gg: ASbGnctsHT2hHonVXZcRPnyqHOxXbINk6pxWtW+vzQBRYetB4koJdPeHIjgKTwQSdYZ
	//6KpXyeckHqXWGWykKYqyGO7D8KxKWHcRMm9JrXoYjtUawoywROTGBBESMwLOfWzNCsEAHOJfV
	A/u4KmrbCDVOQdYO4oklPFukjoQ95TS9wXgEusnIFTdmyckkUAHvP0qJQjVkIOmaat
X-Google-Smtp-Source: AGHT+IGk4BjiXVJoUItGPN7n+Kp+oDChydfAYzAJO0C+lKvd729Y1Tv/qXTzEJ4KkUz9Clqwk2bYcwEBR70pC7DSiBg=
X-Received: by 2002:a05:6402:274d:b0:5fb:1fba:cd93 with SMTP id
 4fb4d7f45d1cf-6011407dd4fmr9503779a12.5.1747624177772; Sun, 18 May 2025
 20:09:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANH4o6Pvc7wuB0Yh8sEQDRg59_=rUNtnpgJizZ5mmmGNgY5Qrg@mail.gmail.com>
 <CAAvCNcBPac+uDC6x_V_jW1q_JCG3yEeCMjvpc869AmBAhti3Xw@mail.gmail.com>
In-Reply-To: <CAAvCNcBPac+uDC6x_V_jW1q_JCG3yEeCMjvpc869AmBAhti3Xw@mail.gmail.com>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Sun, 18 May 2025 20:09:25 -0700
X-Gm-Features: AX0GCFsaa-C-q3J8D2pfEqrjZeDLNEbi1q_SofN_Q3GGi0pN8jIQue533KVWOAA
Message-ID: <CAM5tNy5cxxmksGyXRx4RTTAYqJaJJP49LA3VHzgtz7vvZuqYtw@mail.gmail.com>
Subject: Re: Why TLS and Kerberos are not useful for NFS security Re: [PATCH
 nfs-utils] exportfs: make "insecure" the default for all exports
To: Dan Shelton <dan.f.shelton@gmail.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>, libtirpc-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 18, 2025 at 7:15=E2=80=AFPM Dan Shelton <dan.f.shelton@gmail.co=
m> wrote:
>
> On Wed, 14 May 2025 at 23:51, Martin Wege <martin.l.wege@gmail.com> wrote=
:
> > Interoperability is also a big problem (nay, it's ZERO
> > interoperability), as this is basically a Linux kernel client/kernel se=
rver only
> > solution.
> > libtirpc doesn't support TLS, Ganesha doesn't support TLS, so yeah,
> > this is an issue, and not a solution.
> >
> > Fazit: Supporting your argumentation with Kerberos5 or TLS is not gonna=
 fly.
>
> I tried to add TLS support to libtirpc, but I think it's simply not
> possible. The APIs are just not compatible.
> Ganesha folks also tried the same, and failed - their ntirpc would
> require a major redesign to support TLS.
Well, I'll admit I don't know if the userspace RPC code in FreeBSD
is considered the tirpc or not. (It's in libc and happens to have Frank's
initials on it from long ago when he worked on it for NetBSD.)

Anyhow, at a quick glance, it doesn't look all that difficult.

The low level functions in clnt_vc.c that do I/O on the socket
are called __msgread() and __msgwrite(). If RPC over TLS is
enabled, those functions would need to use SSL_read() and SSL_write().

When a new TCP connection is created (in clnt_vc_create() in this code),
it then needs to do a Null RPC with AUTH_TLS (7) as the authentication
flavor. If it gets STARTTLS in the reply's verifier, then it does a
SSL_connect(). If that succeeds, it flips some flag to tell the I/O
functions to use SSL_read() and SSL_write().
(There is some arm waving to create the SSL context and associate
the TCP socket with it. You can find all that in the sources for
rpc.tlsclntd.c in FreeBSD.)

I haven't actually done this (I did the daemons and krpc mods for
FreeBSD, but not libc ones), but unless there is some corner
that makes it really difficult, it doesn't look like a lot of work to me.
(If Frank or anyone else wants to do this, they can email me for
more info.)

rick
ps: The biggest hassle is that, once you do it, the applications that
      use the library will also need to link in a bunch of SSL
libraries as well.
      (The simple thing is to have a separate library version. Since it's i=
n
       libc in FreeBSD, this is more bothersome.)

>
> So, why do the NFS folks even bother with NFS over TLS, if it is this
> kind of mismatch?
>
> Dan
> --
> Dan Shelton - Cluster Specialist Win/Lin/Bsd
>

