Return-Path: <linux-nfs+bounces-11664-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96875AB3CA3
	for <lists+linux-nfs@lfdr.de>; Mon, 12 May 2025 17:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C82616F2C0
	for <lists+linux-nfs@lfdr.de>; Mon, 12 May 2025 15:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382451A38E4;
	Mon, 12 May 2025 15:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=puzzle-itc.de header.i=@puzzle-itc.de header.b="kJBMJyTi"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BD91A08CA
	for <linux-nfs@vger.kernel.org>; Mon, 12 May 2025 15:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747064807; cv=none; b=Mnm7LjGiEAuCV3KykxoSCNiLdA8W9Ryqa80cki3KW2mkiImB5lnq3RYNdSXcBfRmkFfCaCbUrkTh0g7nhfmUzzElPkGRTWs//94Jh25ROL4yy8v3NqJwYqOw7p5NSawkkRDPmsvR4Dc999Vmx5Y1zYTWmKAUAiollvu8ICYfIsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747064807; c=relaxed/simple;
	bh=RJvZPj6L3BzzbZWOx3lFjGhG4803DKqnbihCO9jnKFw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OybRJwavCO2CeGCx9fankuiYlgm734qYN476Mf8RxtIdZ2fVKcRbw9K4MbiIrUKaQ2GQvJiNAmbHQYImTNRi0qSGcKUQdZUXE6d+Eq/xlFpB0ju1j0uU2OyjidlAPRos1R7trO6f3qWwP02e4TNQeMF8pezu6OVDjTfK2ndpuBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=puzzle-itc.de; spf=pass smtp.mailfrom=puzzle-itc.de; dkim=pass (1024-bit key) header.d=puzzle-itc.de header.i=@puzzle-itc.de header.b=kJBMJyTi; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=puzzle-itc.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=puzzle-itc.de
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5f62d3ed994so889888a12.2
        for <linux-nfs@vger.kernel.org>; Mon, 12 May 2025 08:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=puzzle-itc.de; s=google; t=1747064801; x=1747669601; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:organization
         :autocrypt:from:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YrfS8dYIjdj5XwHzW/1gEFkEloBHHLiYsHCy5GLXFr8=;
        b=kJBMJyTi2/rBmBlhGg4oqF7eiIEDlaEdrGYj+7hpvzznv38bgCVLwBzMYmxDLEcRDI
         ymk+d4rnpirzmS3FhFNm5XIYYOoQ+Cx+sbD3yf0TV6Dc7LwGVLL7YKOFWZbxlb4Qicol
         tubYarHYlFpremRI8KJCj9QlIIJjjvP9aPtvU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747064801; x=1747669601;
        h=content-transfer-encoding:content-language:in-reply-to:organization
         :autocrypt:from:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YrfS8dYIjdj5XwHzW/1gEFkEloBHHLiYsHCy5GLXFr8=;
        b=aNQB9PZ7iGBvXYGMtOmtLZhDoa+KeZwlp6/SpIeXYSbJRrYMbFzOx6cfylRRVZ+szc
         w1afsVkt/dYZddJOzv0BIGFf2iSI//k3AMq7+2WmiMQwAwpw4JkBQI40dkSRqsplfBrw
         t8nGcTiSF2PI1eGuUrn0Rw+sHmcNX/FGp4vR3e9d4pMQ4ehQ2yOkw0Xn+Ou88dwi8X0c
         OLw4qwi8CNYNsDW2PTQ0jgmpP2bvprBtQfyt+grNzM//j5N9/591njPT6RDEEBwaVgdH
         kTRtMXgnOSqAIKcpQN9O5+QmSKqtAxIKjEgKm9sEqS9FmEg16NUlsLFPnbinW7Q5Vk1o
         gAqg==
X-Gm-Message-State: AOJu0YyO/vZLse+iCN2gbM3wMMHmBfIvPYOCCLnEdp3ipi00TDfZ157b
	VAzDhrG+yaPqxcmHUcisjdIEJ6NYHp7SRXadSckqsNHJknDrw+HoMMpWB9Pi26Rl0jmRFhTHLCg
	+iAk9HHirjuJovBrdR2quzKzlGJ0RVCQGpUO5IpwhTfglMpdmuCOeFhO2J6NObqNc
X-Gm-Gg: ASbGncu2ixmWOXLbCjTSJ1bLU/QUwHb3laIFwsjvCSi05gW2ZBfr4jwptYSz4LizfjT
	0sYoWF9+tW/2Khd56XHrqtIo0AjBAzHRY9kzs2jfHk2sCvmCjTKvdsldml77gRBJItOp2IZs5gC
	BI4M1cmdWMOLGurxOxOfrQOse0lRHOmUEPsrwz/6job5yvWbmkkIwHcHYupw4ZCN3OLZTXrRElH
	+pAAaOAGhy6i10de2uvqdcWsCYBSmSsZR4rD/ZswND/tiAy2ukjbCCZlmlrS9ZjvDA+PcdHGd96
	xx5mK7t5cALKRhgsd/n/86BqvissQAxHZlP9iv8g6WOPbjpFIBc623L/5eu0cDzZ1yFkOYPPUek
	27ams4fQykPaZA4840XaWiriAxlU=
X-Google-Smtp-Source: AGHT+IFRhD0hfrVMNAFwTuuyVhv9BgA5LcnVBMRdPG+SzkoEupherC/HFKLdRIUcw8u5c0JyYAxOFA==
X-Received: by 2002:a17:907:d16:b0:ad2:3616:8c37 with SMTP id a640c23a62f3a-ad236169015mr933403766b.30.1747064801032;
        Mon, 12 May 2025 08:46:41 -0700 (PDT)
Received: from ?IPV6:2a02:8070:8e81:94c0:64b7:3fe2:77e5:f646? ([2a02:8070:8e81:94c0:64b7:3fe2:77e5:f646])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad219853438sm628141366b.162.2025.05.12.08.46.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 May 2025 08:46:40 -0700 (PDT)
Message-ID: <73fa0148-45d5-4eb2-81c2-c84d859a410c@puzzle-itc.de>
Date: Mon, 12 May 2025 17:46:39 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Trouble with kerberos encryption types
To: Orion Poplawski <orion@nwra.com>
Cc: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
References: <c4ecc067-9a51-40c8-9300-29119ff2e1d0@nwra.com>
 <e482c8e4-2939-4ef6-a004-e23fcf5e666d@nwra.com>
 <c123b772-ab05-4333-a868-c409c03fcfa2@puzzle-itc.de>
 <62ed2e30-30ba-4b45-b602-14da6f29e9dc@nwra.com>
 <8225a6a4-3b68-44db-ab99-17cf1a4f5175@puzzle-itc.de>
 <66ebdde2-916c-4984-8aa8-0a659d89acd8@nwra.com>
 <81edb674-2dd7-4ede-887f-40e6177661e8@nwra.com>
From: Daniel Kobras <kobras@puzzle-itc.de>
Autocrypt: addr=kobras@puzzle-itc.de; keydata=
 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
 p63U1j1sBdH4lyrWIu/HHjYDEL8+XTvqMCBEHuI=
Organization: Puzzle ITC Deutschland GmbH
In-Reply-To: <81edb674-2dd7-4ede-887f-40e6177661e8@nwra.com>
Content-Language: en-US
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi!

Am 09.05.25 um 23:03 schrieb Orion Poplawski:
> On 5/9/25 13:55, Orion Poplawski wrote:
>> On 5/9/25 07:21, Daniel Kobras wrote:
>>> Hi!
>>>
>>> Am 07.05.25 um 19:39 schrieb Orion Poplawski:
>>>> I tried adding this to the mac without any change:
>>>>
>>>> [libdefaults]
>>>> permitted_enctypes =3D aes256-cts-hmac-sha384-192 aes128-cts-hmac-sha2=
56-128
>>>> aes256-cts-hmac-sha1-96 aes128-cts-hmac-sha1-96 camellia256-cts-cmac
>>>> camellia128-cts-cmac
>>>> default_tgs_enctypes =3D aes256-cts-hmac-sha384-192 aes128-cts-hmac-sh=
a256-128
>>>> aes256-cts-hmac-sha1-96 aes128-cts-hmac-sha1-96 camellia256-cts-cmac
>>>> camellia128-cts-cmac
>>>
>>> Those are options for MIT's libkrb5. Unless you're using a non-default =
stack
>>> on the mac, you probably want to use Heimdal's default_etypes, or the m=
ore
>>> specific default_as_etypes/default_tgs_etypes instead.
>>
>> I ended up slimming down to:
>>
>>    permitted_enctypes =3D aes256-cts-hmac-sha1-96 aes128-cts-hmac-sha1-9=
6
>>    default_tkt_enctypes =3D aes256-cts-hmac-sha1-96 aes128-cts-hmac-sha1=
-96
>>    default_tgs_enctypes =3D aes256-cts-hmac-sha1-96 aes128-cts-hmac-sha1=
-96
>>
>> but those are the option names from man krb5.conf on the mac.
>=20
> I should have trusted you :) - I finally came across this:
>=20
> https://services.dartmouth.edu/TDClient/1806/Portal/KB/ArticleDet?ID=3D89=
203
>=20
> which has:
>=20
>          default_etypes =3D aes128-cts-hmac-sha1-96 aes256-cts-hmac-sha1-=
96
>=20
> and setting that does fix the skey encryption type.

Thanks for the update. So the heuristic to derive the enctype for the=20
forwarded TGT from the service ticket seems to be specific to MIT,=20
whereas Heimdal apparently just uses a client-side default.

> I'm still stuck with the non-renewable ticket that they mention as well, =
so it
> seems like GSSAPI auth from a mac is not very useful.

That's another Heimdal-specific behavior, which means that the renewal=20
of delegated tickets needs to be driven from the delegating side. With=20
OpenSSH, this is possible with the following settings:

ssh server:
   GSSAPIKeyExchange yes
   GSSAPIStoreCredentialsOnRekey yes

ssh client:
   GSSAPIKeyExchange yes
   GSSAPIRenewalForcesRekey yes


If this is not sufficient because the NFS client requires tickets beyond=20
the lifetime of the ssh session, then maybe a different approach like=20
gssproxy's impersonation feature (cf.=20
<https://github.com/gssapi/gssproxy/blob/main/docs/NFS.md#user-impersonatio=
n-via-constrained-delegation>)=20
is more suitable?

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


