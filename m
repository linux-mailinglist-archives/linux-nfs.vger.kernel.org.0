Return-Path: <linux-nfs+bounces-15852-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4E7C2593E
	for <lists+linux-nfs@lfdr.de>; Fri, 31 Oct 2025 15:30:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0EFFC4E4A0B
	for <lists+linux-nfs@lfdr.de>; Fri, 31 Oct 2025 14:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5DB326D6C;
	Fri, 31 Oct 2025 14:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=poochiereds-net.20230601.gappssmtp.com header.i=@poochiereds-net.20230601.gappssmtp.com header.b="X7loCCHY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5237134D38A
	for <linux-nfs@vger.kernel.org>; Fri, 31 Oct 2025 14:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761920987; cv=none; b=bFNRzMmKWyUUEajrHZYbr3nw8fYZk0zgQkHcT4+A+W1BOBL4sDj7sme0FhUsak08T7+6RGhhAHQ9UHcLbg9Ehotv6MzIMMrQDsYRzQk8BqT6L4AaUV8aUsrVL7g3cXI4zwnf9yG7Tky9DiB37ntR0YMLrUrz/BhRXAk5glQHde4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761920987; c=relaxed/simple;
	bh=ecUJjZvL0TiBLp9OoLqYZ2KEt3Y7Ucv3CU7ctmLoUhQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Lm/DMyDlELmefnNDV/M74pzkiAR/wk8xECyP3WxDtqlk6UQwDxJSeiwPFA/t0VmyngRYj39YU+N0Uvc+EBQhonn2LS5w6eLsZ2aSy7skkgtnEtjpa94O2bg2lCsxjL1rVvqBnTgedcGKTjHj3I1zA1vhWb8JWGXXHuxC1L4XX5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=poochiereds.net; spf=pass smtp.mailfrom=poochiereds.net; dkim=pass (2048-bit key) header.d=poochiereds-net.20230601.gappssmtp.com header.i=@poochiereds-net.20230601.gappssmtp.com header.b=X7loCCHY; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=poochiereds.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=poochiereds.net
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7865782eec4so1680877b3.2
        for <linux-nfs@vger.kernel.org>; Fri, 31 Oct 2025 07:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poochiereds-net.20230601.gappssmtp.com; s=20230601; t=1761920983; x=1762525783; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ecUJjZvL0TiBLp9OoLqYZ2KEt3Y7Ucv3CU7ctmLoUhQ=;
        b=X7loCCHYSwfa67WjQlb5XR4NoY4v0zbkaux8LytL6h8vcE4s/4zOtgveStPwtncsoi
         Dqa+QW98UyV0qF3sizG9vwhfgHpQ6mIvI4rebif9eKnrnYcWMP65YKlxbeLQ0r9g6AD+
         vB3dzxpW8ZbKY8l8iiAWEXwjW89Wv3WR281JzDACidKm8cTLSrepodTdJ9MX4ahtE9sE
         jJRUAiJxgCjrz1FsQGqxrJ54ngs99YBFUClJvEik9qz8AsReKYvlIGDLq5Y4QeZEw3z5
         hU31p4pmUUW8j9GHjCbEQVFCCrqPB08BbnoR6/79j5EOIpWfNI4Z5yvFVI1Z03w0nCKE
         y5FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761920983; x=1762525783;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ecUJjZvL0TiBLp9OoLqYZ2KEt3Y7Ucv3CU7ctmLoUhQ=;
        b=CSLXbjudSJrLmG4XrsJreybIQ/8Zow8z6/6iFznw3eSexnfwWJ7sRpSysoxs0j/cVm
         20tSEk7snVUjGNKo4TYAoDodqyzR3yW0p9XbE66HQmcxJeInMEz/P7AgweDfguZKc8ZP
         /wSFcYJmnW94LceypUT1PlpjjLex3tI+nOxZuVRlqpRlM0L0rIj5lAZbhT5XTE7vE/Mz
         W6ROyJ/4HIRVKjc7nF8zhaBa41kcSqorjsaLlnWKXUbR+dwnz6lQ482Fad6ZHHyt3Ice
         /nlLPobj/eHK06a5kXDeses2A1W8qGdKxYKFlPXmhHHtePuJjV5wwTzV5TxNgjKz8zNT
         eTJw==
X-Gm-Message-State: AOJu0Yw6FNOE1lbh/6tUPQuPAHtM8+dsL3sfM1R5WpuoV3I/96sdnTis
	A+NoTw6i1ro+KgW3yRiJeFMb/ZKF87Mu12Tdnqej4sBZujqIJvIkqemWFRZQF9eY7K0=
X-Gm-Gg: ASbGncu/plYNvTi65GeVyM/Rywmv4nrVStjQdGLn7/35ef4Y43y7Mu0yCTvg1VsEzI4
	woFKomB0iRHbr/0QGrFakrK+A4CFRLG/PKaVMyOh+pSsB+gPc073q1Pg6kKAg8GFkcvbZlZkv5I
	aU/0fDEIbTb/MQBXylRP+B5o1Tp312m6qWwwHPFkoW5r7nl44bWZdNuWaoRYi3ZxUlLvNNDxTh/
	4OpvFR6UR74AWyimzPcrS8+w4yX/zO3ThuT/ibbooU/8oP2OZeHnDGdBFl3T1TVo19K4+sFUTJG
	VZqtSZfOjAtfO7aTw0SgqUzg2yMVUbSeQmpiX5V5Rhyqbiv/AxFwN2H4yJMyeEFs76pU09qE1Lg
	qSeQ8B/yo1IzoOSVyoQc9QhzawjyTA+KvG74N8v+H5IeA7bk7cdtRtLQosqn9meC5yI7pnGoKje
	JRpXFivWcZEjBLN9D4wER/QZjHzLpitKArvObK8CoLljVwBWQdIhkb5mtS
X-Google-Smtp-Source: AGHT+IGS+9g6Y5XSHoREC6Pypby5piLQPdRoTSvK/Js2/FL2stdZmlOq6a9kzSrV72LDbH8+Z55p9A==
X-Received: by 2002:a05:690c:6082:b0:783:7143:d819 with SMTP id 00721157ae682-7864840a4b7mr34773017b3.17.1761920983136;
        Fri, 31 Oct 2025 07:29:43 -0700 (PDT)
Received: from [192.168.1.3] (68-20-15-154.lightspeed.rlghnc.sbcglobal.net. [68.20.15.154])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7864c6645adsm5460087b3.40.2025.10.31.07.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 07:29:42 -0700 (PDT)
Message-ID: <b1451224bfa93fc8a6f94e4da2fe327fe366cd0f.camel@poochiereds.net>
Subject: Re: [NFS-Ganesha-Devel] Clarification on delegation behavior for
 same-client conflicting OPEN
From: Jeff Layton <jlayton@poochiereds.net>
To: Suhas Athani <Suhas.Athani@ibm.com>, "devel@lists.nfs-ganesha.org"
	 <devel@lists.nfs-ganesha.org>
Cc: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
 "nfsv4@ietf.org"	 <nfsv4@ietf.org>, Kaleb KEITHLEY <kkeithle@ibm.com>,
 Frank Filz <ffilz@ibm.com>,  Rajesh Prasad <Rajesh.Prasad3@ibm.com>
Date: Fri, 31 Oct 2025 10:29:41 -0400
In-Reply-To: <DM4PR15MB62545DA30C0BB065DE454D9E9AFBA@DM4PR15MB6254.namprd15.prod.outlook.com>
References: 
	<DM4PR15MB62545DA30C0BB065DE454D9E9AFBA@DM4PR15MB6254.namprd15.prod.outlook.com>
Autocrypt: addr=jlayton@poochiereds.net; prefer-encrypt=mutual;
 keydata=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
 q/2QWqNFB6xOBr5rQ5xwl
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-10-30 at 17:35 +0000, Suhas Athani via Devel wrote:
>=20
> Hello NFS community,
>=20
> We=E2=80=99re seeking clarification on server behavior for OPEN delegatio=
ns when the same client issues a potentially conflicting=C2=A0OPEN on a fil=
e=C2=A0for which it already holds a delegation.
> =C2=A0
> Context and RFC references
>=20
> =C2=A0*=20
> =C2=A0=C2=A0=C2=A0RFC 8881(10.4 Open Delegation)
> =C2=A0=C2=A0=C2=A0=C2=A0-=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=E2=80=9CThere must be no current OPE=
N conflicting with the requested delegation.=E2=80=9D
> =C2=A0=C2=A0=C2=A0=C2=A0-=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=E2=80=9CThere should be no current d=
elegation that=C2=A0conflicts=C2=A0with the delegation being requested.=E2=
=80=9D
> =C2=A0
> =C2=A0*=20
> =C2=A0=C2=A0=C2=A0RFC 8881(10.4.1 Open Delegation and Data Caching)
> =C2=A0=C2=A0=C2=A0=C2=A0-=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0For delegation handling, READs/WRITEs=
 without OPEN are treated as the functional equivalents of a corresponding =
type of OPEN, and the server =E2=80=9Ccan use the client ID=C2=A0associated=
 with the current session to determine if the operation=C2=A0has been done =
by the holder of the delegation (in which case, no recall is necessary) or =
by another client=C2=A0(in=C2=A0which case, the delegation must be recalled=
 and I/O not proceed until the delegation is returned or revoked).=E2=80=9D
> =C2=A0
> =C2=A0*=20
> =C2=A0=C2=A0=C2=A0Historical reference: RFC 5661 (obsoleted=C2=A0by=C2=A0=
RFC 8881) carries the same=C2=A0sections 10.4 and 10.4.1
> Questions=C2=A0
> 1) Same-client conflicting OPEN:
>=20
> =C2=A0*=20
> =C2=A0=C2=A0=C2=A0If a client holds an OPEN_DELEGATE_READ on a file and t=
hen the same client issues an OPEN that requires write access (or otherwise=
 conflicts), should the=C2=A0server:
> =C2=A0*=20
> =C2=A0=C2=A0=C2=A0
>=20
>=20
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0-=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Allow the OPEN to complete immediatel=
y without recalling the delegation (i.e., no recall necessary for same-clie=
nt), per RFC 8881 10.4.1; or
> =C2=A0
> =C2=A0*=20
> =C2=A0=C2=A0=C2=A0Recall the delegation anyway and delay the operation un=
til DELEGRETURN?=C2=A0

The Linux NFS server allows the open to complete, which I think has
been the consensus around this point in earlier discussions. Basically,
activity from the holder of a delegation is not considered
"conflicting". That client presumably knows about any changes and can
update its cache accordingly, so we don't need to recall the delegation
in this case.

> 2) OPEN_DELEGATE_WRITE symmetry:
>=20
> =C2=A0*=20
> =C2=A0=C2=A0=C2=A0If a client holds an OPEN_DELEGATE_WRITE and then the=
=C2=A0same client issues an=C2=A0OPEN=C2=A0that requires read access (or ot=
herwise changes share access/deny modes), should the=C2=A0server=C2=A0simil=
arly=C2=A0allow=C2=A0the=C2=A0operation to=C2=A0proceed=C2=A0without=C2=A0r=
ecall, or=C2=A0recall and=C2=A0delay?

WRITE delegations should probably have been called READ_WRITE. The
Linux NFS server and the spec treat them as a superset of a READ
delegation. So, opening the file for READ when you hold a WRITE deleg
is not considered conflicting activity.

> 3) Any updates since=C2=A0RFC=C2=A05661:
>=20
> =C2=A0*=20
> =C2=A0=C2=A0=C2=A0Are there=C2=A0clarifications=C2=A0or consensus updates=
=C2=A0in=C2=A0RFC=C2=A08881 (vs. RFC=C2=A05661) or=C2=A0later documents tha=
t=C2=A0alter expected behavior=C2=A0in the=C2=A0same-client case?
>=20
>=20
> Thank you in advance for your time and insights. Looking forward to your =
guidance and clarification on these points.
>=20
> Regards,
> Suhas Athani
> NFS-ganesha Team
>=20
>=20
>=20
>=20
> _______________________________________________
> Devel mailing list -- devel@lists.nfs-ganesha.org
> To unsubscribe send an email to devel-leave@lists.nfs-ganesha.org

--=20
Jeff Layton <jlayton@poochiereds.net>

