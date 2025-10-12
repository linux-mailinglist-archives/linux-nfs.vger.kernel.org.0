Return-Path: <linux-nfs+bounces-15161-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0281CBD08FF
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Oct 2025 19:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 114F21892482
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Oct 2025 17:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7B02EDD72;
	Sun, 12 Oct 2025 17:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H0j/1SX5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6572ED854
	for <linux-nfs@vger.kernel.org>; Sun, 12 Oct 2025 17:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760291879; cv=none; b=IFAnUnmGNfRIv6wSLNbEJ/MLKx7iGxUyfOy+Oq63Bu69Ly1lrZDCJji2Sl/U3jZqkiAKvVv69we7OVNufYPWbQKFmQNN9Rle5C0+v/awAmGhReGz+HjK0dPmV6/5sZnBiOlPP5Tm/rfgh0CVD7Rn42rS6lJPh9rSW2/Jt/nPKB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760291879; c=relaxed/simple;
	bh=dIa6LC613mYhl2CLAXvXtPZk55MGU9mnOnR558GXunM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RBzJAmjTN27MxNII1XPHzg4Xg0P2tV9B6Td3rfTrP7IANKaUwR70thyfIA6Qh9L/KihzXBrdznSWfWrO7z2oMN/saGUcfRZoH14aNIIMfKNV01rmfZq6LnLXMzpaERvIm0x7NXUjLotsWb3+iFuUp6sHxUL4E2bbQClBriTC84E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H0j/1SX5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760291876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Utpv+62PaLVyv5NKnoU/rVjv/h2E+smFCvLAYqjlmoA=;
	b=H0j/1SX57eokzFXvJGxN+Sak9/x4Q9QEdSsp9U9FJBmxIXHq6H2wOLw3YO90oL3gL4TMHt
	nk3QUI5zopuLvs0QMjMrXMFtHrvrMXUKDSOZHHP1KD78/oJQSYooIJEZeOtlJk4lVY1dio
	mhBhDq8Gh2b8x/P+4ZdM60hqpHVv0Yc=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358-oDQimWi4MWGPzx71IYJciQ-1; Sun, 12 Oct 2025 13:57:54 -0400
X-MC-Unique: oDQimWi4MWGPzx71IYJciQ-1
X-Mimecast-MFC-AGG-ID: oDQimWi4MWGPzx71IYJciQ_1760291874
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-78f3a8ee4d8so176651576d6.1
        for <linux-nfs@vger.kernel.org>; Sun, 12 Oct 2025 10:57:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760291874; x=1760896674;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Utpv+62PaLVyv5NKnoU/rVjv/h2E+smFCvLAYqjlmoA=;
        b=OdSCkXZNavMbETs6hJNZTOl8FMBg/YFqy5TFV6IXu82E81+j6dx6K6MdCdLAikOVq9
         CgJcu60ldibckChya2SSi3GS9nIGCpEjZsYAzIZ4XATLLiOZNL2757ue+qs0QcuyL/Zi
         Ffqehc9YtQ0DL/M1EEkZF+cdGadWX1HZBreEcRPG+t6w94R+LmOVPoZDfWz+SNWjp/fI
         aj8v9LNk7ro/KvtuM7zElOZNY/2n1MTuhS31K10lEoQ2F9YRq7pxWhiuTeQYgSH2XRP4
         G4TkRWD+2gscxQIH9GSXubtNQ9UNQoKNNPFXQ0QWBMHZMXrzHJHWMBntPc96O2vuylfd
         lEKA==
X-Gm-Message-State: AOJu0YxHmyBZYzzNFjnmLZ6gbeKITyGzmR+dt9r+EQtH8wkhCgFKFouy
	XWTRwqkQhiGDqcZmbwy9SDIiTJy56Cha6jpBzCtXqx3XViqesDi4Uga9OXMi6jpCyomo1kjvFui
	lhYhUTEwXz3LJI7ZRVzbbbFhEWtvAg+WC/ZUCRk9Zw5PPS1IwWaRvS/oEdYD5yw==
X-Gm-Gg: ASbGncvcwM42ePMUWCxZ1dneXtXixtFALbYsIOEMGXDJXIdDKr3JoLwuGQub69+KS2q
	c8bRiBDQjY3okOyQSVZ73YXQh8z0+zg2zEB6KZsPuITxKOxBbXJBBLN5dqL4lfH8kRiuv9IBx6V
	8x6pZgWu4qrVGELoqEecjNIg68oBNMWBbCgyeEJoTFcgAillHygggZkxlaFQ3nKUVGPWKPvbxXU
	8vEfkbiwRg0QNWhOBbCVJl+mvI2dNxG5TR+6QuRAVz9X/u/GOhJHS/9L10puKZRCOZHh1y0gwef
	H8xVGD5C4525lS+MdF9GCfMcJqJOppri7Ww=
X-Received: by 2002:a05:6214:2509:b0:784:d90f:b6d4 with SMTP id 6a1803df08f44-87b210a04b5mr248144436d6.15.1760291873714;
        Sun, 12 Oct 2025 10:57:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRH5ZhWRFmVNjnioHiad4+NWcgoaERxVtoowq/txkAMolsUyOSG8hqkZjMVwLcygfdVRORpQ==
X-Received: by 2002:a05:6214:2509:b0:784:d90f:b6d4 with SMTP id 6a1803df08f44-87b210a04b5mr248144146d6.15.1760291873265;
        Sun, 12 Oct 2025 10:57:53 -0700 (PDT)
Received: from m8.users.ipa.redhat.com ([2603:7000:9400:fe80::318])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87bc347991dsm56107306d6.22.2025.10.12.10.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 10:57:51 -0700 (PDT)
Message-ID: <dae495a93cbcc482f4ca23c3a0d9360a1fd8c3a8.camel@redhat.com>
Subject: Re: [PATCH] nfsd: Use MD5 library instead of crypto_shash
From: Simo Sorce <simo@redhat.com>
To: Eric Biggers <ebiggers@kernel.org>, Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
 NeilBrown	 <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, Dai
 Ngo	 <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
 linux-crypto@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Sun, 12 Oct 2025 13:57:50 -0400
In-Reply-To: <20251012170018.GA1609@sol>
References: <20251011185225.155625-1-ebiggers@kernel.org>
	 <582606e8b6699aeacae8ae4dcf9f990b4c0b5210.camel@kernel.org>
	 <20251012170018.GA1609@sol>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2025-10-12 at 10:00 -0700, Eric Biggers wrote:
> On Sun, Oct 12, 2025 at 07:12:26AM -0400, Jeff Layton wrote:
> > On Sat, 2025-10-11 at 11:52 -0700, Eric Biggers wrote:
> > > Update NFSD's support for "legacy client tracking" (which uses MD5) t=
o
> > > use the MD5 library instead of crypto_shash.  This has several benefi=
ts:
> > >=20
> > > - Simpler code.  Notably, much of the error-handling code is no longe=
r
> > >   needed, since the library functions can't fail.
> > >=20
> > > - Improved performance due to reduced overhead.  A microbenchmark of
> > >   nfs4_make_rec_clidname() shows a speedup from 1455 cycles to 425.
> > >=20
> > > - The MD5 code can now safely be built as a loadable module when nfsd=
 is
> > >   built as a loadable module.  (Previously, nfsd forced the MD5 code =
to
> > >   built-in, presumably to work around the unreliablity of the name-ba=
sed
> > >   loading.)  Thus, select MD5 from the tristate option NFSD if
> > >   NFSD_LEGACY_CLIENT_TRACKING, instead of from the bool option NFSD_V=
4.
> > >=20
> > > To preserve the existing behavior of legacy client tracking support
> > > being disabled when the kernel is booted with "fips=3D1", make
> > > nfsd4_legacy_tracking_init() return an error if fips_enabled.  I don'=
t
> > > know if this is truly needed, but it preserves the existing behavior.
> > >=20
> >=20
> > FIPS is pretty draconian about algorithms, AIUI. We're not using MD5 in
> > a cryptographically significant way here, but the FIPS gods won't bless
> > a kernel that uses MD5 at all, so I think it is needed.
>=20
> If it's not being used for a security purpose, then I think you can just
> drop the fips_enabled check.  People are used to the old API where MD5
> was always forbidden when fips_enabled, but it doesn't actually need to
> be that strict.  For this patch I wasn't certain about the use case
> though, so I just opted to preserve the existing behavior for now.  A
> follow-on patch to remove the check could make sense.

It would be nice to move MD5 (and reasonably soon after SHA-1 too) out
of lib/crypto and in some generic hashing utility place because they
are not cryptographic algorithms anymore and nobody should use them as
such.

That said MD5 appears to be used for cryptographic purposes (key/IV
derivation) in ecryptfs (which is pretty bad) and therefore ecryptfs
should be disabled in fips mode regardless (at least until they change
this aspect of the fs).

Specifically for this patch though I do not think you should keep
disabling nfsd4_legacy_tracking_init() in fips mode, as md5 here is not
used in a cryptographic capacity, it is just an identifier that is
easier to index.

Simo.

--=20
Simo Sorce
Distinguished Engineer
RHEL Crypto Team
Red Hat, Inc


