Return-Path: <linux-nfs+bounces-1718-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B8B8475EF
	for <lists+linux-nfs@lfdr.de>; Fri,  2 Feb 2024 18:16:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 883231F2625D
	for <lists+linux-nfs@lfdr.de>; Fri,  2 Feb 2024 17:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B1545BF3;
	Fri,  2 Feb 2024 17:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K91e06HE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033C35B66F
	for <linux-nfs@vger.kernel.org>; Fri,  2 Feb 2024 17:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706894208; cv=none; b=VmrDy82Iah6fDtZEyIyXNHc5hCa7mD3GmhsV7t8ICR+G33chhHNn8sgRSWAYDAstDkrFt6MHlhT3gYh5g7mK4xjXIZgH90SttfkQE/+U7Eoxfk0DqjHMKd0axz+3NahnOUsuKmf0l2Fh+ZUkSFYI52mXVgRPVwmDQGTtRH88PzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706894208; c=relaxed/simple;
	bh=8i9nMk7RtT97GNhIzUlZZIirEi//LV79dIrK54Wrm0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t1R9CeC+Vy3gyGO7QLD4MuGMNAKcPOnm5vVE8T8fwgVKzxW7Vn+JNNsOwQJTuSmArE9KH986KVdkleYR7DpQxGCfAqfmr7GpS+OF0vt4BYHWcN3Nd8LOZxrVGdbo7SD8vMzmh6cnHRubQkILFxBgPad3Owr8apWJrGUBZLT0GR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K91e06HE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706894205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gGHvZm2pNMYsuKTK+gFhJ3VJB7gJXTCggUVWpF15icg=;
	b=K91e06HETwysIjHnSMKbAG5lkOY8k9zhTXBsQveX4RprxGuL420gflHABEwPVNc93iJgDM
	oMNmMnKmxYKVVAaErNryPxiGEyvp6kziIhBXhh3vggJuM3f+qMigMgW9mhomMeGLHHQbv6
	KyNqxF0vQPmlzpt2l8z8gUslrN/foY0=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-336-y26sexXZMNCJbl3oEcgYNA-1; Fri, 02 Feb 2024 12:16:42 -0500
X-MC-Unique: y26sexXZMNCJbl3oEcgYNA-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7816e45f957so284779385a.1
        for <linux-nfs@vger.kernel.org>; Fri, 02 Feb 2024 09:16:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706894202; x=1707499002;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gGHvZm2pNMYsuKTK+gFhJ3VJB7gJXTCggUVWpF15icg=;
        b=wWGLdv8o/u4Hz1+1Xni4sRBkm/wgo6lnzlCqpfgj+AQr6afN7ZKKJh4Wca0RxIJB5N
         hr1xr7iejkSw0DlON9A59ucDec0gDJTdPrwedHMX6DQLfuMbdkZqY2C5Y9ELojldyDvk
         ZN0ueyOn0qDoCkeu37yWZ6KPR+Ln6zjODLgOuN7AVvcueDq/c8kRKskijojH+v/ri0Q1
         HhMIjfZnBStxSZCMeOFbc3oHAuvjLmDbUK/ai621ICwgjrJGWQvonkuhFVJcTip+nI/q
         whGHeAP38awhwECNjnb261CUAfwD/Y9Zuv1vZN9SFz8w8QGpUnJ/qFK+gzeDCvzbijMt
         gU7Q==
X-Gm-Message-State: AOJu0YwhZdtDg7XlaLprBrJFYuNWGQIL2bs6ZqSRLKhjz9ng9NmVVbgM
	nulw6k+b+Ew9shUfhf44oTM76Q9RXfpHLENkTlL8qqWrqjJ+pM/sMn4oAhh1YNGhE5wK7ANaRYa
	pmixEwhpLHW08HTgiUrsqKUqnEATm2MRx1Z1UEy321CXFKwKK9HK6VFhdNQ==
X-Received: by 2002:a05:620a:a55:b0:785:457e:e57e with SMTP id j21-20020a05620a0a5500b00785457ee57emr2550708qka.17.1706894201806;
        Fri, 02 Feb 2024 09:16:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHc4Ushq1JgWV5BxoKJeNiUA7ZkzpIwnbZuPgQ2Qur/pvN6STYwi0pWbvGwv9vkISPGdtaw7A==
X-Received: by 2002:a05:620a:a55:b0:785:457e:e57e with SMTP id j21-20020a05620a0a5500b00785457ee57emr2550691qka.17.1706894201495;
        Fri, 02 Feb 2024 09:16:41 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWwWTCdNlVIKgFGqnZQcS7K5weUl5wZ49JcAg2LrzDx6xoz6dzwbVYnytEHAOUYEp7Wtg+f+uW6OyshEIOlLKv5acpPxIpt+iNBR8NcOuQW2p/iR3yu/Sa6Av2Ear7C9x/7aODyqo/JdMBYMUgNkiZbfkZPAgMkoMpOZG5qEFvMLeKymDpVlmbIul5d6byCb7pyazX3hzMTLstj4bEK8TthUGEFBHao5RJDOWwsJ0Bp7VXNU0Nrals=
Received: from localhost (nat-pool-mxp-t.redhat.com. [149.6.153.186])
        by smtp.gmail.com with ESMTPSA id u15-20020a05620a454f00b00784087c7f21sm823269qkp.84.2024.02.02.09.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 09:16:41 -0800 (PST)
Date: Fri, 2 Feb 2024 18:08:38 +0100
From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neilb@suse.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	"olga.kornievskaia" <olga.kornievskaia@gmail.com>,
	Tom Talpey <tom@talpey.com>, linux-nfs <linux-nfs@vger.kernel.org>
Subject: Re: Should we establish a new nfsdctl userland program?
Message-ID: <Zb0hlnQmgVikeNpi@lore-rh-laptop>
References: <8a7bbc05b6515109692cb88ad68374d14fc01eca.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Y4fqAr61eeYDETl5"
Content-Disposition: inline
In-Reply-To: <8a7bbc05b6515109692cb88ad68374d14fc01eca.camel@kernel.org>


--Y4fqAr61eeYDETl5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> The existing rpc.nfsd program was designed during a different time, when
> we just didn't require that much control over how it behaved. It's
> klunky to work with.
>=20
> In a response to Chuck's recent RFC patch to add knob to disable
> READ_PLUS calls, I mentioned that it might be a good time to make a
> clean break from the past and start a new program for controlling nfsd.
>=20
> Here's what I'm thinking:
>=20
> Let's build a swiss-army-knife kind of interface like git or virsh:
>=20
> # nfsdctl=A0stats			<--- fetch the new stats that got merged
> # nfsdctl add_listener		<--- add a new listen socket, by address or hostn=
ame
> # nfsdctl set v3 on		<--- enable NFSv3
> # nfsdctl set splice_read off	<--- disable splice reads (per Chuck's rece=
nt patch)
> # nfsdctl set threads 128	<--- spin up the threads
>=20
> We could start with just the bare minimum for now (the stats interface),
> and then expand on it. Once we're at feature parity with rpc.nfsd, we'd
> want to have systemd preferentially use nfsdctl instead of rpc.nfsd to
> start and stop the server. systemd will also need to fall back to using
> rpc.nfsd if nfsdctl or the netlink program isn't present.
>=20
> Note that I think this program will have to be a compiled binary vs. a
> python script or the like, given that it'll be involved in system
> startup.
>=20
> It turns out that Lorenzo already has a C program that has a lot of the
> plumbing we'd need:
>=20
>     https://github.com/LorenzoBianconi/nfsd-netlink

This is something I developed just for testing the new interface but I agre=
e we
could start from it.

Regarding the kernel part I addressed the comments I received upstream on v=
6 and
pushed the code here [0].
How do you guys prefer to proceed? Is the better to post v7 upstream and co=
ntinue
the discussion in order to have something usable to develop the user-space =
part or
do you prefer to have something for the user-space first?
I do not have a strong opinion on it.

Regards,
Lorenzo

[0] https://github.com/LorenzoBianconi/nfsd-next/tree/nfsd-next-netlink-new=
-cmds-public-v7

>=20
> I think it might be good to clean up the interface a bit, build a
> manpage and merge that into nfs-utils.
>=20
> Questions:
>=20
> 1/ one big binary, or smaller nfsdctl-* programs (like git uses)?
>=20
> 2/ should it automagically read in nfs.conf? (I tend to think it should,
> but we might want an option to disable that)
>=20
> 3/ should "set threads" activate the server, or just set a count, and
> then we do a separate activation step to start it? If we want that, then
> we may want to twiddle the proposed netlink interface a bit.
>=20
> I'm sure other questions will arise as we embark on this too.
>=20
> Thoughts? Anyone have objections to this idea?
> --=20
> Jeff Layton <jlayton@kernel.org>
>=20

--Y4fqAr61eeYDETl5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZb0hkwAKCRA6cBh0uS2t
rM+3AP4v3+P/FFC/bLjALNfUYitWBR12o0xfPHLw1+JXzqw3vgEAl36TAQSI1HpS
KKFMk1xIAE3pUhFwL1CcgU1Dhl5y4AM=
=sCuO
-----END PGP SIGNATURE-----

--Y4fqAr61eeYDETl5--


