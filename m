Return-Path: <linux-nfs+bounces-11587-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7285FAAE740
	for <lists+linux-nfs@lfdr.de>; Wed,  7 May 2025 18:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDE367B88AC
	for <lists+linux-nfs@lfdr.de>; Wed,  7 May 2025 16:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70CDD28B4F0;
	Wed,  7 May 2025 16:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=puzzle-itc.de header.i=@puzzle-itc.de header.b="dY7Pe9tn"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C243A1FBC92
	for <linux-nfs@vger.kernel.org>; Wed,  7 May 2025 16:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746637082; cv=none; b=Cja8nZaBu3KoyM3bNghBxnSYZTWi67atFAXkyeuO8Kl7Rg+IP07DtxVqc5QR9EwHNvJDbhr93ZdBNKmjYUwIniGuP9pw5KvZBE+uOrcR+Q7cT9hZDaxf4EIzkDg+ZPR/mMm/z/jI2ajKtihpMp6fB/0QjUC761bd/VXT9V2/vpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746637082; c=relaxed/simple;
	bh=AAqdxuRRPWuzUM0izygC16SchDxsg1wRqC3Z1LHTm2I=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=IElLp83RjbsQfCsNCzXwUq7MYUI5jqK5wEPPwgii8b4veoBh5AjTfeqTMyEmn+hIzlsuKKwNhjecunMUYuUEqBXJ6b52JjsCZdukVngFfRf3eIQ1Upza8n7MGS2xcyv9z2GerCq5t12X5e7NyjyXlLbl1t2NOwLtcyl1EuTM2J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=puzzle-itc.de; spf=pass smtp.mailfrom=puzzle-itc.de; dkim=pass (1024-bit key) header.d=puzzle-itc.de header.i=@puzzle-itc.de header.b=dY7Pe9tn; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=puzzle-itc.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=puzzle-itc.de
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ac2963dc379so3595266b.2
        for <linux-nfs@vger.kernel.org>; Wed, 07 May 2025 09:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=puzzle-itc.de; s=google; t=1746637077; x=1747241877; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:organization
         :autocrypt:from:cc:references:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qI7aE7gNXcJRle2tQPFIWXyGno/LZ4w6wmz6ZkCHqM0=;
        b=dY7Pe9tnjpVRBbU9qpe9iDDkwNR3w47gmA2irFbCpiX1HpyLxpZNF7ESQBnH2bwAW/
         PxM9u637MnS20sA6iyokYDNtiweR3/G/grg2Qxgcuc15GEB0LmDG/InVdG7X/NqNrhYR
         gMwBwmbav36l1P/JDbownSmjWT8j6VoPQdPE4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746637077; x=1747241877;
        h=content-transfer-encoding:content-language:in-reply-to:organization
         :autocrypt:from:cc:references:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qI7aE7gNXcJRle2tQPFIWXyGno/LZ4w6wmz6ZkCHqM0=;
        b=v9wpw7zTzHIXDEfbCeQqqIz7mgSmDSowbKyFSpLZvGaPdigQ/h0YjSRaOLDD0z9J+h
         ZcAcIdc25gJC5+g5nfYQ3KLDI6KXZAC+MK9HLzLlWs9+/au0ibsXTfiTyBP0MPBhMPs/
         +n1Y3wcH8v7H9NwrVoRvt1IyX1NbZMAwmZ5BCSs9PBU2mo2/ufgUL/RJiuVH04hWsxla
         l6ZgDj/SBDi9xBq9rZstTBflSQkyIb04d3pyzcx/kK0nW5K/EBIN97/fcu+xc70mDK+U
         W9wHQi/08FoU/+iZC6jh7ZqJuuZuPOHmFYKYDZAazwMFica6T+ZE/QSreo3es1C7RPc0
         YOiQ==
X-Gm-Message-State: AOJu0YybkshdQWjOAatS7EyvpMkwsd5+BKHUpWaL2I8eSsF4ldEDC4ca
	dK6GSeSOxj+hGesNkZpofymrsOrq71HNz0XwAlK2WC7AlkRq1ti3fqjqIRLLg6TKjxV4UeVYl1C
	0iLWW+tH7DenYGhIWN7ageNxN6LyLh5aoodWVFWsWUtQ8+nECOrfgspQNRCRxvh6w
X-Gm-Gg: ASbGncsnufmcQ8EL0w2BIZPu8frnyEAHDx/jMyxTD1oIPTp7s2IQhluoXhSkOfveOcz
	JzUaAi7jh6x148d63zNesM581EpHKM56WLTyMHzSaZMDypO71F2k4lavg+RcQhthFNUERDUTk3x
	qRSBb/Bk2zQGpIlYx9k6jkVZSDxNQeYk1yB+gTJKWPQpIVFS1ANW4FamaFhbxtkw6Z58bmNp/jY
	Z67JZ+zjg4g7aIzwoFWeQhAgfhCCLyN0q8wczRhd9vHeFPOmWvNh5XcThcagYD0uE+Qgk+GbN50
	rGC/0nRP3gVI29ScXZE3aNJxLgHS58BHLvbxuBGY4T77YjWSSy8Hc7/NeXyCpHPYkA/lfdBVkEb
	Dp31iDi/UaGMTzA==
X-Google-Smtp-Source: AGHT+IFGS6uY0nw9OXpEkzpGO0zWttOJhCWLbehmcWgy6s97rlUDWG19AOkrQv6iLtE9TCMSHR+ylw==
X-Received: by 2002:a17:907:da9:b0:ace:9d3d:2ad5 with SMTP id a640c23a62f3a-ad1e8c935c1mr376931566b.32.1746637076753;
        Wed, 07 May 2025 09:57:56 -0700 (PDT)
Received: from ?IPV6:2a02:8070:8e81:94c0:9297:6dcd:b2a:ba60? ([2a02:8070:8e81:94c0:9297:6dcd:b2a:ba60])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad189508c83sm939944366b.139.2025.05.07.09.57.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 May 2025 09:57:56 -0700 (PDT)
Message-ID: <c123b772-ab05-4333-a868-c409c03fcfa2@puzzle-itc.de>
Date: Wed, 7 May 2025 18:57:55 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Trouble with multiple kerberos ticket caches
To: Orion Poplawski <orion@nwra.com>
References: <c4ecc067-9a51-40c8-9300-29119ff2e1d0@nwra.com>
 <e482c8e4-2939-4ef6-a004-e23fcf5e666d@nwra.com>
Cc: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
From: Daniel Kobras <kobras@puzzle-itc.de>
Autocrypt: addr=kobras@puzzle-itc.de; keydata=
 xsDNBFuyIr8BDADfcwWSZafsIOyivFu+Bh3ynelaKS35BuF43EfZmmCmAKzpVrkqo0vYpWb+
 GKn8wyyy+Z89BGvWjMmGQ5tUzIF+2cGgc3SoAeqSOY0CkUPC6ea0rKA/02LiEJR3ScUx5QU9
 uz5H0Y7Xcj0MnqLFw6poZmZqVJ6i0YYNYB0/vtrsmZgRdbkCxq+PINdnCAva9ROkiOwW6iyy
 nmejJETfsy5wIuiVPJ/SyTtnQuBgGvESVzW46JRZS8+aD9PLip/nn0buJCQHZADswMnn62vV
 3fNDCnPFo3z5c//jKm+0MesGEBNtdNdHdLyQy9HizvCE7zpV4HVhDGo8FV9JHReWRb4zv7Cc
 6Ro3kKP7XTdEs1/qxxMtJakW+VY19tS+qFR9C4+PoaeK0/RS7GeI5SMxTHVI2xCkMwG1nNWB
 aZ14XDH1ieXjqQKQr/TCcNbfeZAXO021oqhUN6YKH0H6Iywu7Mos9syqCxFZ6KRYhKaZgJzP
 Jlb6iTcDyFZRbRldOnQiKkEAEQEAAc0xRGFuaWVsIEtvYnJhcyAoUHV6emxlIElUQykgPGtv
 YnJhc0BwdXp6bGUtaXRjLmRlPsLBDgQTAQoAOBYhBM3oc+2tF4TjZ5+mipqV0zLLbB3XBQJb
 siK/AhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEJqV0zLLbB3XE1kMAIlngQYG6ufb
 sSPWbK+mqb9cvYkJrQkgdyNNMHd48MVBWMBq89ycfVnQi0DOzRNqXl6sX/dZQnb/ThWEDoFW
 wvKee2onXGGYVrAf3p1RRFxO1laKXeSECSJE4bru0Lo/mU4tnxOAa+3ugirgIpgvw19zN/Ic
 P9nnlFFyFoLecnc/jUN7BCNmCpjYsregRoKRBT68FGISFEwot2ut4IvP1u6V01JcMpDTtLKs
 u3QxbIkfkVIoyfVGZjWbFhtzl8qRE6Ug7esUHsBEsjvpb5OE9XCwHACn3c8yScKk7xI9dpXt
 bxIIokCJHMZBxO1Q7CUuGYGtAgb2k++/Wh5FxqDTkVglf2UH0nN5B03Sike8TDmZwW59iTiV
 r8sBAsKDizSzTzOESi7f3lcG90anNHf8oLBeMfzfUQZNypneZ/8R7CKzr6msICKhqrR8F9Ed
 889RusI3CPb10OLDRBW4d19nTC5Hyvk4+7vtcenY8g5hGeqLHUgGn28rcK+qkjKr922HU87A
 zQRbsiK/AQwAxUDhTjEPV9kluZ/Mo/B7Sq8D2aGzfiTQm1c2t5I8BrCbOIQr+t5p1i6wsbUw
 SXahmnHzqUSdLs62aT+i25RsUBMpplYepG66zT5q+7YoBzsh6Sl4zchVTAsDSpUhGFkSZ9mh
 53G9Y3hbv36ROIYJOisWx8KdCG/HFjC8GaWDT5vgvUUL8u90qDXaot5VZXz5RP8+Y2LAfs1R
 Ys/9vd9R+93rDLfceDxDjWiXgUXMhywB8ZzC8ulEwWkzFniWQA09g1+w/9/zhTxD/obCCqQW
 cFhPvZAM7GV4Shx8VhKrsSqwZufVY0d6oA5rB16j/o2lw/2SMOVyZodj8ErwMTYsWsIUt4iG
 XEu0STSrihGz59YimfdHxKg9sFgwD43JcM3+2pXRSE3Q4oazr3TnyIT/dtlNbjtQOjT7apy9
 xZG7kjjvbxjWBkdbmNCNG4te+ueT4Hi/HF5Yw/0xNeOq4WtAT8nGxOLVGLToqugb2P6nKXjF
 0BDJu8S42/jSw4XByNsHABEBAAHCwPYEGAEKACAWIQTN6HPtrReE42efpoqaldMyy2wd1wUC
 W7IivwIbDAAKCRCaldMyy2wd12i4DACUIrpZZqCFVD/jngeYexLci/lmNIUh+pnw/1sI15O+
 N4T7ISCUGLvO7ZFO1qCcLC/UrYxQD+qgBnmQ9mRHXFSiEXcTLQG9QB8h/uP/2ZqhZVjWLdZS
 NFVQBct2etq5NB+z484CT5PhYcpHMzWF8DwwoxqlGxd8MRZ4IEu5Gaa8ZYagZQvSRn/82y6j
 svvBhMidgy6FphmxOwzFgf9EmAToDTJ5Kp5250C/XU9YrPIlg6ALAI5iFlQf5NJIG1dnV3wJ
 xSUgDrMtHpfzP0eTFskimusVtsZmsA9SRyny1fiySsl9xm6bOtwmfmSgK1pQznTg5mMHKsgy
 m66zlacn8OBoZ16acBmNGZL2Du5UUlxsFDGgGNdiXwomLkEhtpPJZC4230d2ngQqLzfBA9CH
 orAjkyCQkC4vNM8gadJcCEmNW8jxQAFAEypFu9JewCA8DiPOIU2xPw27ocZVPuRQIwiAuF3Z
 p63U1j1sBdH4lyrWIu/HHjYDEL8+XTvqMCBEHuI=
Organization: Puzzle ITC Deutschland GmbH
In-Reply-To: <e482c8e4-2939-4ef6-a004-e23fcf5e666d@nwra.com>
Content-Language: en-US
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi!

Am 06.05.25 um 21:54 schrieb Orion Poplawski:
> More details.  The issue seems to arise when doing gssapi delegation from=
 a
> macOS client to the Linux box.  If I have ticket on macOS:
>=20
> Ticket cache: API:427671FC-DB63-442F-ACA4-13A9194F4398
> Default principal: user@AD.NWRA.COM
>=20
> Valid starting     Expires            Service principal
> 05/06/25 13:29:54  05/06/25 23:29:54  krbtgt/AD.NWRA.COM@AD.NWRA.COM
>          renew until 05/13/25 13:29:50
> 05/06/25 13:30:30  05/06/25 23:29:54  krbtgt/NWRA.COM@AD.NWRA.COM
> 05/06/25 13:30:30  05/06/25 23:29:54  host/host@NWRA.COM
>=20
> and ssh to the Linux box, I can't access the nfs mount:
>=20
> -bash: /home/user/.bash_profile: Permission denied
>=20
> Ticket cache: KEYRING:persistent:30657:krb_ccache_efgrZpc
> Default principal: user@AD.NWRA.COM
>=20
> Valid starting     Expires            Service principal
> 05/06/25 13:30:30  05/06/25 23:29:54  krbtgt/AD.NWRA.COM@AD.NWRA.COM
>=20
> I also notice that the ticket is non-renewable.
>=20
> If I then kinit I can access the home directory fine.  Other than the new
> ticket being renewable I don't see any difference:
>=20
> Ticket cache: KEYRING:persistent:30657:krb_ccache_efgrZpc
> Default principal: user@AD.NWRA.COM
>=20
> Valid starting     Expires            Service principal
> 05/06/25 13:31:27  05/06/25 23:31:27  nfs/server@NWRA.COM
>          renew until 05/13/25 13:31:22
> 05/06/25 13:31:27  05/06/25 23:31:27  krbtgt/NWRA.COM@AD.NWRA.COM
>          renew until 05/13/25 13:31:22
> 05/06/25 13:31:27  05/06/25 23:31:27  krbtgt/AD.NWRA.COM@AD.NWRA.COM
>          renew until 05/13/25 13:31:22
>=20
> Actually, I also notice now that there is a krbtgt/NWRA.COM principal as =
well.
>   I wonder if that is the difference.

Can you please check and compare the output of 'klist -ef' (which=20
includes additional info on enctypes and flags) in both cases? It sounds=20
like the macOS client is forwarding a ticket that is not accepted by the=20
Linux client's krb5 library. This could happen if eg. the=20
default_tgs_enctypes configured in krb5.conf on the macOS side is=20
incompatible with the permitted_enctypes in krb5.conf on the Linux side.

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


