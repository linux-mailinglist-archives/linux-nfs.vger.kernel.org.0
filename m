Return-Path: <linux-nfs+bounces-11719-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A18AAB6B66
	for <lists+linux-nfs@lfdr.de>; Wed, 14 May 2025 14:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 186101643CE
	for <lists+linux-nfs@lfdr.de>; Wed, 14 May 2025 12:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F232276025;
	Wed, 14 May 2025 12:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZS79MkOT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DB822154D
	for <linux-nfs@vger.kernel.org>; Wed, 14 May 2025 12:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747225741; cv=none; b=kqkLJvDgGl/edPLdRbvaKCzqS0ivhLPaIc+QYnfpcrZr7S3c5cLixrT4nfv8m1f9cqeW5zkL3+P9USdECO26AB5cBfmN1J8mRCC0Kny9E1061lGr4cwJB8TSRfvRgFo3xe4N6eXg1vGHki4ixIstC3NoaDhSRUm72Z1ndnh0K0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747225741; c=relaxed/simple;
	bh=Ib36+uMhQfYrJuIaqBeRkatvuJe698hGH4D7+ecPzQ8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=airdhpY3MlDuHR/t8IHgag1w6V0oi48QpNqM9IJr9SEzP3k1nIjGzUzc8Njp/mogUZ35ACBhTIQpiwVLP3VWFnKh3frr+UxrLvFzhMxWUPMVxnsW3Bgvo9qOAxzpO0s25xhNGyakstysKJehZE+LbnUYKigP4vQxpeNq1N+TjkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZS79MkOT; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-601b6146b9cso3357716eaf.0
        for <linux-nfs@vger.kernel.org>; Wed, 14 May 2025 05:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747225739; x=1747830539; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+yH9NrU2R6oavDUjuTs0riUceAVYwqm9ekr72OZHpts=;
        b=ZS79MkOTjG3+X+D1ZlrRzjgwvTDIvXwE7paJAnbxmqXwvenYAj4CAaA+x6PL0QQnB/
         DLEoF8IXS33Hxvx4q6Zliaz8zZ4ngMLaP0L7Y3vTmJ3ySx8AN80rMLH1fL4Xqd7I4lNV
         sRTNKr2Er62Za2yusf1bdvaNEKoWxYVScaG2kH2/9HNud874CAieT1qep/MzFnrXbXlN
         FMKYacu50mUatwF/qDXOLlIONpfBLbCuDHLBK4Wv6ieaqRS7t/OoHGHkKQFiKbMcIqiX
         3FGxlpD9ZoysCztBqmAkAKLzllWhptsJ53JtHrazn7R1pgF3rr428Qy8XBT6ufsPjTuK
         iJJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747225739; x=1747830539;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+yH9NrU2R6oavDUjuTs0riUceAVYwqm9ekr72OZHpts=;
        b=GLdqjqG9m8nHbLbZPZzOy4fDHa59LKMw5HfkJhwqemu1JVK5zzgh/Ivw4AzChPEXKS
         MdF7N6JBCwhJPNthaIupDcuTrQ88DuuoeaoDLGVH4T6B1vUahC0uR19RfH5hb4W/Najr
         5ztIIwVZP3xE76TP/Jsz+gWNESMe/bRPlbgh5Nvct/rD0xDC5TQML7ttsAkb0PNmW817
         A7Cp/fZab82JEMdvGSomRAXs8UepqFN7zRQ+qQ9F5gzQYadZqaqxLJMvhpKrnYLKYdLu
         iNayKfTvc3gGwd+E8YXzaweFGdJThH3r4a26gP08qlwJ4hBKft/V6i7Om1iMnwkzpcmZ
         Xxsg==
X-Forwarded-Encrypted: i=1; AJvYcCXsZDrbH8850BFCZdq+awOBSyuHKElKB/Mp3fSCDwlfAf4r7lkswRPWkwXeRevLWxRj4ewAikQuC7k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQLlsP17iUHXioCUWT4jwbcTTV0bOXVFUQsoMiFwRo33Nonu//
	udRMX+pphTh8QPwvRY63XMBZRC2BrRxVace2kFy4NOJJ0f6nO2U6
X-Gm-Gg: ASbGncu6JfKvGEHHVCpxLfJYurYFPF/oGA3ROp7lJ1fz/gMI4qU0beqzZl2acawNZSQ
	BR4ZqwiVNCUwnDgA8OPErdtXWN4Dsj66i6L125QNasQ9p9sO+rjnX66GQ0O1oOcvrW/J7zh00CC
	mzOFUpCfWCsyXtEJw24z/EEI/i5hREyvI3eBs8Osr3G1gGAuKURcKt/7QXgSuL0BjhE7SvxCyXB
	KaQ9J66K0BeLjCqYHds+7xWamwLUV3tVDJ0N18pudXXaSw6pSPXBBmeXy1bBEmUD2aiWaxmIGkl
	cpYZaOlXVIzPc0nxlpxSRxE+uC0O9h0V8kbt4sBxZVNHJ7UE0lK41nA7o/0agBzyMaOPqzSyrBU
	=
X-Google-Smtp-Source: AGHT+IHks1lRBdJ14jMjbUv62fS8CstO3R5XPrFDJn5u6uyJPQthsu3cJ1QZEvIlRXTZktYxnn8JcQ==
X-Received: by 2002:a05:6871:7c17:b0:2d7:2200:b810 with SMTP id 586e51a60fabf-2e32b065932mr1667250fac.3.1747225738691;
        Wed, 14 May 2025 05:28:58 -0700 (PDT)
Received: from smtpclient.apple ([50.203.221.234])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2dba0797479sm2682392fac.21.2025.05.14.05.28.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 May 2025 05:28:58 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: [PATCH nfs-utils] exportfs: make "insecure" the default for all
 exports
From: Thomas Haynes <loghyr@gmail.com>
In-Reply-To: <174718900620.62796.18240600261000060825@noble.neil.brown.name>
Date: Wed, 14 May 2025 08:28:47 -0400
Cc: Jeff Layton <jlayton@kernel.org>,
 Steve Dickson <steved@redhat.com>,
 linux-nfs@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <6E05B8C0-79E5-4BEA-B177-072792644C1B@gmail.com>
References: <20250513-master-v1-1-e845fe412715@kernel.org>
 <174718900620.62796.18240600261000060825@noble.neil.brown.name>
To: NeilBrown <neil@brown.name>
X-Mailer: Apple Mail (2.3826.500.181.1.5)



> On May 13, 2025, at 10:16=E2=80=AFPM, NeilBrown <neil@brown.name> =
wrote:
>=20
> On Tue, 13 May 2025, Jeff Layton wrote:
>> Back in the 80's someone thought it was a good idea to carve out a =
set
>> of ports that only privileged users could use. When NFS was =
originally
>> conceived, Sun made its server require that clients use low ports.
>> Since Linux was following suit with Sun in those days, exportfs has
>> always defaulted to requiring connections from low ports.
>>=20
>> These days, anyone can be root on their laptop, so limiting =
connections
>> to low source ports is of little value.
>=20
> But who is going to export any filesystem to their laptop?
>=20
>>=20
>> Make the default be "insecure" when creating exports.
>=20
> So you want to break lots of configurations that are working perfectly
> well?
>=20
> I don't see any really motivation for this change.  Could you provide =
it
> please?


Consider a pNFS Flex File deployment with 1000s of data servers. The
metadata server needs access to each data server. If it needs to be on
a secure port, then the metadata server can easily run out of room.




>=20
> Thanks,
> NeilBrown
>=20
>>=20
>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>> ---
>> In discussion at the Bake-a-thon, we decided to just go for making
>> "insecure" the default for all exports.
>> ---
>> support/nfs/exports.c      | 7 +++++--
>> utils/exportfs/exports.man | 4 ++--
>> 2 files changed, 7 insertions(+), 4 deletions(-)
>>=20
>> diff --git a/support/nfs/exports.c b/support/nfs/exports.c
>> index =
21ec6486ba3d3945df0800972ba1dfd03bd65375..69f8ca8b5e2ed50b837ef287ca0685af=
3e70ed0b 100644
>> --- a/support/nfs/exports.c
>> +++ b/support/nfs/exports.c
>> @@ -34,8 +34,11 @@
>> #include "reexport.h"
>> #include "nfsd_path.h"
>>=20
>> -#define EXPORT_DEFAULT_FLAGS \
>> -  =
(NFSEXP_READONLY|NFSEXP_ROOTSQUASH|NFSEXP_GATHERED_WRITES|NFSEXP_NOSUBTREE=
CHECK)
>> +#define EXPORT_DEFAULT_FLAGS (NFSEXP_READONLY | \
>> + NFSEXP_ROOTSQUASH | \
>> + NFSEXP_GATHERED_WRITES |\
>> + NFSEXP_NOSUBTREECHECK | \
>> + NFSEXP_INSECURE_PORT)
>>=20
>> struct flav_info flav_map[] =3D {
>> { "krb5", RPC_AUTH_GSS_KRB5, 1},
>> diff --git a/utils/exportfs/exports.man b/utils/exportfs/exports.man
>> index =
39dc30fb8290213990ca7a14b1b3971140b0d120..0b62bb3a82b0e74bc2a7eb84301c4ec9=
7b14d003 100644
>> --- a/utils/exportfs/exports.man
>> +++ b/utils/exportfs/exports.man
>> @@ -180,8 +180,8 @@ understands the following export options:
>> .TP
>> .IR secure
>> This option requires that requests not using gss originate on an
>> -Internet port less than IPPORT_RESERVED (1024). This option is on by =
default.
>> -To turn it off, specify
>> +Internet port less than IPPORT_RESERVED (1024). This option is off =
by default
>> +but can be explicitly disabled by specifying
>> .IR insecure .
>> (NOTE: older kernels (before upstream kernel version 4.17) enforced =
this
>> requirement on gss requests as well.)
>>=20
>> ---
>> base-commit: 2cf015ea4312f37598efe9733fef3232ab67f784
>> change-id: 20250513-master-89974087bb04
>>=20
>> Best regards,
>> --=20
>> Jeff Layton <jlayton@kernel.org>
>>=20
>>=20
>>=20
>=20


