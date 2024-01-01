Return-Path: <linux-nfs+bounces-851-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A88821397
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jan 2024 12:25:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0DA11F21912
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jan 2024 11:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5981C36;
	Mon,  1 Jan 2024 11:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="WibzVTXS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06D3210B;
	Mon,  1 Jan 2024 11:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1704108303; x=1704713103; i=markus.elfring@web.de;
	bh=KBCe5bAyw6ghD008K0JgVekThO7siyPaiU7l1J0vQGE=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=WibzVTXSTg+qNgBDrvuSXpIDRTZvvUPJ1JrzTsjybr5mgdqhGx1bSoOVi3ZY+9m1
	 BqwjqL0fpscze353vP4faBGkNV67s77noGVeWL8t7wjZ2g/x31Oz4TsFXG2BC4Y8o
	 lBXI0f5uPHoSOdQsgVmwajr7AfaorohMRyKslZS4tZBYDFcr0diC1m7LKbdPSAdQm
	 SRmxsJEPS05RfW2GfKZVFKhmF2Bw2qFay/1j+spUANlWKoiwnISlcN/X0zljIfzEg
	 sWaSHXopwvj421iaS+w1JnhfeAkLaz3GJXK6yzn5J3PMTBobYSIVqYQKQXKp4upqa
	 uD0YuTAGsYX9jU4L4w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.86.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MLzn1-1rcCo33Ymn-00I3sH; Mon, 01
 Jan 2024 12:25:02 +0100
Message-ID: <4307bce9-ccbd-4bc5-aa8e-b618a1664cbe@web.de>
Date: Mon, 1 Jan 2024 12:24:59 +0100
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sunrpc: Improve exception handling in krb5_etm_checksum()
Content-Language: en-GB
To: Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
 netdev@vger.kernel.org, kernel-janitors@vger.kernel.org
Cc: Anna Schumaker <anna@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
 Dai Ngo <Dai.Ngo@oracle.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Herbert Xu
 <herbert@gondor.apana.org.au>, Jakub Kicinski <kuba@kernel.org>,
 Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
 Olga Kornievskaia <kolga@netapp.com>, Paolo Abeni <pabeni@redhat.com>,
 Simo Sorce <simo@redhat.com>, Tom Talpey <tom@talpey.com>,
 Trond Myklebust <trond.myklebust@hammerspace.com>,
 LKML <linux-kernel@vger.kernel.org>
References: <9561c78e-49a2-430c-a611-52806c0cdf25@web.de>
 <ZZIhEJK68Sapos2t@tissot.1015granger.net>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <ZZIhEJK68Sapos2t@tissot.1015granger.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Vn/HkV0Ure2YCzmNLi3xwD29bLKJb2dTQOMTnC7oLEdFVLRHM3r
 uviIFdxclVy651SOw7PMjVJJ8NXHqmDZKU9M3JrQvWvhwV0U0VdhVxd5BY4meP0iy/8vyOi
 6OYy0JarKfUE+OS3eZMrHUzSJyWycyPrQJdqmMfsNyqVHiqnzSd79ivyma3qY0kE416y3yP
 RuSKnjlngaUQEPYhqMwww==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:UdF4WRWURZA=;pdsBrnNEagtfYnRIibWLfuZ6qQz
 OgKCfYYf0dvoBc/SZ9UbJEQC9Zpt/RDML186UyhsETArxUvCLaqqQqcnXn6B1cHz+LDh3JBse
 9Zm4+/ss6A5w5oMg+UP9wbWvy5wO419D4YeeUBKKOKqfuMq97xzMNx4XQHuMTzr2MgLMP1/zx
 CHXuriei2XUOtKnCoI/uMzHIGSqVf8IXgRLiudR4J0x2wawzZYoLg5Ef8IcAx8f8sbM88LXUM
 bI4Q3gGkCzUun4ytu9G4qS74O40/MHMfDcZjMnunOJ88A2uuixxwFbwtpCdNZ3nZb1LTbA+aB
 MpFjTkku53lDMjOn68DT1lkemkFSLE8Z/PtaH4Jd1GEX2IDUBhpgjx/eA1MCey2BBTmo6IopJ
 lBeXxgX88ZnO/ESzQspj20X6qd4/yBGroWfdRB5Z4nh/UD+if7///ijVBK4XVCDiQVJeDYP/p
 KcNhA8OTnGVGhBcsqFQfbViYHZb1Fb6IjtFMrudptaLfpkwtHpqTX7Wb2eS36k97PtxmIb85q
 lnC76zIY/IKfmbAUKGQHXMbE5Vmb6qpsEpmmKIZl6seGrORsk/8XZ1yOO0eyOhypUcMwHEX/o
 utxDtkkgQm04nUBddwCodG42Ey4s4JoP0y/fWtN57x2wadJ5Q2/XFfRv91zmL2uszTVRifJi9
 l7E+Vev+J/HDzCDny9b1znh+rf10C2r8LIDyLAH1okZ9b1dnFCbyOroVB5myZ64lFqTIQ4iF8
 HROSUEp8FNuJkChDTfG7BXNnYCYojOKaFyU8VpXBZTQnvg1qybXgPzfO5J8D7px8/jkvHhBdl
 O+HCwp5ivRsBu65NGv91drq5wdKvgNViLP4CpF5NX+k6B/VqZtKJ+wp/hZXVMxan1ABQK5Tes
 04MjYlWf3bDWlDfynN82OCl6qFElmzBgthArfeV5Eyfz2kZiZ1Op/sh6HvBS34s7cQ0SCJt7e
 LuVrEA==

=E2=80=A6
>> Thus use another label.
=E2=80=A6
>> ---
>>  net/sunrpc/auth_gss/gss_krb5_crypto.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
=E2=80=A6
> As has undoubtedly been pointed out in other forums, calling kfree()
> with a NULL argument is perfectly valid.

The function call =E2=80=9Ckfree(NULL)=E2=80=9D is not really useful for e=
rror/exception handling
while it is tolerated at various source code places.


>                                          Since this small GFP_KERNEL
> allocation almost never fails, it's unlikely this change is going to
> make any difference except for readability.

I became curious if development interests can grow for the usage of
an additional label.
https://wiki.sei.cmu.edu/confluence/display/c/MEM12-C.+Consider+using+a+go=
to+chain+when+leaving+a+function+on+error+when+using+and+releasing+resourc=
es


> Now if we want to clean up the error flows in here to look more
> idiomatic, how about this:
=E2=80=A6
> +++ b/net/sunrpc/auth_gss/gss_krb5_crypto.c
=E2=80=A6
> @@ -970,8 +970,9 @@ u32 krb5_etm_checksum(struct crypto_sync_skcipher *c=
ipher,
>
>  out_free_ahash:
>  	ahash_request_free(req);
> -out_free_mem:
> +out_free_iv:
>  	kfree(iv);
> +out_free_cksumdata:
>  	kfree_sensitive(checksumdata);
=E2=80=A6

I find it nice that you show another possible adjustment of corresponding =
identifiers.

Regards,
Markus

