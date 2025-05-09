Return-Path: <linux-nfs+bounces-11620-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F09BAB14FE
	for <lists+linux-nfs@lfdr.de>; Fri,  9 May 2025 15:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6BC6169738
	for <lists+linux-nfs@lfdr.de>; Fri,  9 May 2025 13:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBAC129187E;
	Fri,  9 May 2025 13:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=puzzle-itc.de header.i=@puzzle-itc.de header.b="gL0xmALV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5536BB5B
	for <linux-nfs@vger.kernel.org>; Fri,  9 May 2025 13:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746796900; cv=none; b=A4fpqh+zrR/r5usK8+kTEO5PWE8iitSMcO1C350WrshGvi0Uv7is3iw7GWlDZRS0a6BPynlKulPzED2k1LzP49uv9aWZo9fqVgDjn93//3kIDyi1KWd+oO0RVBiD0D3G+qVBDHZJ9xJqP2KWUY9Q2D8grpKbk9FyhGmhQVCro1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746796900; c=relaxed/simple;
	bh=fblsidyECMV6+V2+VSu7at+vrk2DPpN7wJbC2gboAmQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e5zhc7LzyCQW4jqnxknQ7fa0ocOnNtDDOsE/67bz88PChCSORaA/V01/XuEYrDM+JqNoa77eHkYz08+JMunHWaNOLV5yhhT373M4oPMDqn29g74wD/Y356mu9gNke1tNGIYwmXEg0WmthufPZoL3alqSAUkRax3jWKixpNm/pUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=puzzle-itc.de; spf=pass smtp.mailfrom=puzzle-itc.de; dkim=pass (1024-bit key) header.d=puzzle-itc.de header.i=@puzzle-itc.de header.b=gL0xmALV; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=puzzle-itc.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=puzzle-itc.de
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43d0618746bso16342255e9.2
        for <linux-nfs@vger.kernel.org>; Fri, 09 May 2025 06:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=puzzle-itc.de; s=google; t=1746796895; x=1747401695; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:organization
         :autocrypt:from:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OqFVOiGRgM/0WeeF9gNzAZsDW1TBl0MpXz3RrJRn2gA=;
        b=gL0xmALVqZKdWhYjn5SsOnpc3wlQkYEob0rvI2wFnAXjP/+7Za3Y/d2YikgQPBZuhx
         Qhwro8ICManALWNcEBRf9PrxEAZV3mft+21TXJzXTO7waopUGnMXAmoey9/GgCku2olc
         RG19VLk32vDqa9ozBHBgP/WaP5QVm/6yf6aNo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746796895; x=1747401695;
        h=content-transfer-encoding:content-language:in-reply-to:organization
         :autocrypt:from:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OqFVOiGRgM/0WeeF9gNzAZsDW1TBl0MpXz3RrJRn2gA=;
        b=d/gBI2LUnB3vj5wxZQosfbFZBiRQC24NHpmStOWzJaVmo7qrw8AWDZBO/VRxeVrnNk
         Ho4CU+CkRZIRM7ab3kJj6s1aXDDvPBkn6Ptrc0JvQDJyNCp+MlajA3kgxXZjlfuk4ifv
         OGK8wJ80WGiTbUq7zMqxH3q/4u3BeN1PGS5l+mN9ml2qkI38wynbfCSwX5oW3IrmA4/j
         WyGCcR2cym/MBABRrNCj7PhDhdxRZclGsfYbaYiQXdxgJaiY8W4lcHehli20BEdmndNA
         8or/LrKBEgMCQK1WvnwKEepcQBKTNFfHA/QpPieOxKeAPHYUi8aPX77KytgPg9dBXVmX
         JIsg==
X-Gm-Message-State: AOJu0YyVDIqvFZ+DSPpFN8HGUDs/bzD6p7d7gTpjYYZTM7rtIoHdxM5d
	GgxhiAsuTaTL6+xoYrKScAaZs6gkJu5dHE18p8xLMEaeLdDm4YDaSTGZaKqdGFY5BtwrAyT8Fqk
	C3H4m5gP3tss/M5KtSo1h/wPvcSqRDUVHZHfEw1C71mANodx1oj1rJ1n7saMwFfgY
X-Gm-Gg: ASbGncui2pk2WFTi8ASEm/Vk0WSW3WvWFB3kw4KD0UpE/K6kcz2Jds5Ep5X/4h8/8Zy
	HDCMjX2aP/N+3fXhSNvla+vfHp5XPbRCCZD0vAT+9uFsrNjomN5c3StkjHg00o3sDr2z4xhLD5X
	3sdRXup9C4s4yQZApTnXQAR9823Ok2UXMO04gBy9XjzQf7gStVU/P1hIrl2AM6NpzNlAD2vtDiQ
	M89eQ3L4sRaucW2GLIad5obVHDaEeuV3fZZbVcvs+BuPlem8A86Z3yr9TTN3wnxahGTtGAXnqNG
	0ISL1U7x8+Jrcj0Jz9jDMMXGJeld72+/nogF2EKCPSqFAYNdgTuYnuyUi/Au63J26UwdoMN7DVP
	HVUApaw==
X-Google-Smtp-Source: AGHT+IEmNOXjmy0GeDtJdcAC6D6Nzsi/37zciD4vAaMPLvEbSfuDwm/tNhI5ZC7NPJ6y8ox30zCe2w==
X-Received: by 2002:a05:600c:4e45:b0:43d:46de:b0eb with SMTP id 5b1f17b1804b1-442d6d44814mr29346075e9.12.1746796895241;
        Fri, 09 May 2025 06:21:35 -0700 (PDT)
Received: from [10.44.72.28] (p5b285530.dip0.t-ipconnect.de. [91.40.85.48])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442cd3aeb79sm71890135e9.27.2025.05.09.06.21.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 May 2025 06:21:34 -0700 (PDT)
Message-ID: <8225a6a4-3b68-44db-ab99-17cf1a4f5175@puzzle-itc.de>
Date: Fri, 9 May 2025 15:21:34 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Trouble with multiple kerberos ticket caches
To: Orion Poplawski <orion@nwra.com>
Cc: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
References: <c4ecc067-9a51-40c8-9300-29119ff2e1d0@nwra.com>
 <e482c8e4-2939-4ef6-a004-e23fcf5e666d@nwra.com>
 <c123b772-ab05-4333-a868-c409c03fcfa2@puzzle-itc.de>
 <62ed2e30-30ba-4b45-b602-14da6f29e9dc@nwra.com>
From: Daniel Kobras <kobras@puzzle-itc.de>
Autocrypt: addr=kobras@puzzle-itc.de; keydata=
 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
 p63U1j1sBdH4lyrWIu/HHjYDEL8+XTvqMCBEHuI=
Organization: Puzzle ITC Deutschland GmbH
In-Reply-To: <62ed2e30-30ba-4b45-b602-14da6f29e9dc@nwra.com>
Content-Language: en-US
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi!

Am 07.05.25 um 19:39 schrieb Orion Poplawski:
> On 5/7/25 10:57, Daniel Kobras wrote:
>> Am 06.05.25 um 21:54 schrieb Orion Poplawski:
>>> More details.=C2=A0 The issue seems to arise when doing gssapi delegati=
on from a
>>> macOS client to the Linux box.=C2=A0 If I have ticket on macOS:
>>>
>>> Ticket cache: API:427671FC-DB63-442F-ACA4-13A9194F4398
>>> Default principal: user@AD.NWRA.COM
>>>
>>> Valid starting=C2=A0=C2=A0=C2=A0=C2=A0 Expires=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Service principal
>>> 05/06/25 13:29:54=C2=A0 05/06/25 23:29:54=C2=A0 krbtgt/AD.NWRA.COM@AD.N=
WRA.COM
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 renew until 05/13/25 =
13:29:50
>>> 05/06/25 13:30:30=C2=A0 05/06/25 23:29:54=C2=A0 krbtgt/NWRA.COM@AD.NWRA=
.COM
>>> 05/06/25 13:30:30=C2=A0 05/06/25 23:29:54=C2=A0 host/host@NWRA.COM
>>>
>>> and ssh to the Linux box, I can't access the nfs mount:
>>>
>>> -bash: /home/user/.bash_profile: Permission denied
>>>
>>> Ticket cache: KEYRING:persistent:30657:krb_ccache_efgrZpc
>>> Default principal: user@AD.NWRA.COM
>>>
>>> Valid starting=C2=A0=C2=A0=C2=A0=C2=A0 Expires=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Service principal
>>> 05/06/25 13:30:30=C2=A0 05/06/25 23:29:54=C2=A0 krbtgt/AD.NWRA.COM@AD.N=
WRA.COM
>>>
>>> I also notice that the ticket is non-renewable.
>>>
>>> If I then kinit I can access the home directory fine.=C2=A0 Other than =
the new
>>> ticket being renewable I don't see any difference:
>>>
>>> Ticket cache: KEYRING:persistent:30657:krb_ccache_efgrZpc
>>> Default principal: user@AD.NWRA.COM
>>>
>>> Valid starting=C2=A0=C2=A0=C2=A0=C2=A0 Expires=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Service principal
>>> 05/06/25 13:31:27=C2=A0 05/06/25 23:31:27=C2=A0 nfs/server@NWRA.COM
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 renew until 05/13/25 =
13:31:22
>>> 05/06/25 13:31:27=C2=A0 05/06/25 23:31:27=C2=A0 krbtgt/NWRA.COM@AD.NWRA=
.COM
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 renew until 05/13/25 =
13:31:22
>>> 05/06/25 13:31:27=C2=A0 05/06/25 23:31:27=C2=A0 krbtgt/AD.NWRA.COM@AD.N=
WRA.COM
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 renew until 05/13/25 =
13:31:22
>>>
>>> Actually, I also notice now that there is a krbtgt/NWRA.COM principal a=
s well.
>>>  =C2=A0 I wonder if that is the difference.
>>
>> Can you please check and compare the output of 'klist -ef' (which includ=
es
>> additional info on enctypes and flags) in both cases? It sounds like the=
 macOS
>> client is forwarding a ticket that is not accepted by the Linux client's=
 krb5
>> library. This could happen if eg. the default_tgs_enctypes configured in
>> krb5.conf on the macOS side is incompatible with the permitted_enctypes =
in
>> krb5.conf on the Linux side.
>=20
> That does indeed seem to be the issue - but it seems strange.
>=20
> On the mac:
>=20
> Valid starting       Expires              Service principal
> 05/07/2025 10:50:16  05/07/2025 20:50:16  krbtgt/AD.NWRA.COM@AD.NWRA.COM
>         Flags: FPIA, Etype (skey, tkt): aes256-cts-hmac-sha1-96,
> aes256-cts-hmac-sha1-96
>=20
> On the Linux box:
>=20
> Valid starting       Expires              Service principal
> 05/07/2025 11:17:25  05/07/2025 20:50:16  krbtgt/AD.NWRA.COM@AD.NWRA.COM
>          Flags: FfPA, Etype (skey, tkt): DEPRECATED:arcfour-hmac,
> aes256-cts-hmac-sha1-96

Can you please re-check the 'klist -ef' output on the mac once you've=20
ssh'ed to the Linux box, ie. once also the host ticket is present in the=20
ccache? The TGT that ends up on the Linux system gets requested by the=20
mac, which doesn't know about the krb5 configuration on the Linux side,
and therefore needs to guess the supported enctypes. MIT's libkrb5=20
derives the enctype to request for the forwarded TGT from the ticket for=20
the target service, ie. the host service in the case of ssh. On macOS,=20
you're likely using a Heimdal-based libkrb5, but I assume it uses a=20
similar heuristic.

If the ccache shows that related host ticket also uses RC4 enctypes,=20
this could be either due to the default set of ticket enctypes=20
configured on the mac, or because the AD computer account for your
Linux system does not allow any stronger enctypes (see=20
msDS-supportedEncryptionTypes attribute).

Either case would explain the weak session key in the forwarded TGT. But=20
then I wonder why the ssh login works at all, given that your Linux=20
system ought to reject the RC4 host ticket due to its restricted set of
permitted_enctypes. So something still doesn't add up.

> The linux box has crypto-policies:
>=20
> [libdefaults]
> permitted_enctypes =3D aes256-cts-hmac-sha384-192 aes128-cts-hmac-sha256-=
128
> aes256-cts-hmac-sha1-96 aes128-cts-hmac-sha1-96 camellia256-cts-cmac
> camellia128-cts-cmac
>=20
> Shouldn't that prevent it from ending up with arcfour-hmac in the first p=
lace?
>=20
> I tried adding this to the mac without any change:
>=20
> [libdefaults]
> permitted_enctypes =3D aes256-cts-hmac-sha384-192 aes128-cts-hmac-sha256-=
128
> aes256-cts-hmac-sha1-96 aes128-cts-hmac-sha1-96 camellia256-cts-cmac
> camellia128-cts-cmac
> default_tgs_enctypes =3D aes256-cts-hmac-sha384-192 aes128-cts-hmac-sha25=
6-128
> aes256-cts-hmac-sha1-96 aes128-cts-hmac-sha1-96 camellia256-cts-cmac
> camellia128-cts-cmac

Those are options for MIT's libkrb5. Unless you're using a non-default=20
stack on the mac, you probably want to use Heimdal's default_etypes, or=20
the more specific default_as_etypes/default_tgs_etypes instead.

Kind regards,

Daniel
--=20
Daniel Kobras
Principal Architect
Puzzle ITC Deutschland
+49 7071 14316 0
www.puzzle-itc.de

--=20
Puzzle ITC Deutschland GmbH
Sitz der Gesellschaft: Eisenbahnstra=C3=9Fe 1, 72072=20
T=C3=BCbingen

Eingetragen am Amtsgericht Stuttgart HRB 765802
Gesch=C3=A4ftsf=C3=BChrer:=20
Lukas Kallies, Daniel Kobras, Mark Pr=C3=B6hl


