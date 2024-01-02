Return-Path: <linux-nfs+bounces-856-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F27498218E1
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Jan 2024 10:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 918501F22080
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Jan 2024 09:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F9B63B2;
	Tue,  2 Jan 2024 09:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="VgRSL4Cz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A422EDF5D;
	Tue,  2 Jan 2024 09:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1704187576; x=1704792376; i=markus.elfring@web.de;
	bh=hm9XvsB8Hc+GdCwiF3RHaf2+W9Sx9+rzWWOPBtlg8U0=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=VgRSL4Czpr9uuX6BZvWm6E0gbIKeKF81KU2N7arwbRFR5No28HHwxGXvX3eL0/xX
	 ADPm6qFgZ+PJjFjBABOeiQq/yOmmzoq1UjKm44h7B86l+W5O/BJrpgAXE9Bp7tOzk
	 xkmSrYbwevpo0ANCoT5mOcvTi6xDfDAn/fwDvE+3qtKiFiQjJDPbD6mwVQBuiEPi7
	 fCrjUwMhDHmUKSDAJEtzdmjHevc8Y3Xm3tWr2JLFBF0dSZ4NbpAl1s0DCJhosWR4L
	 QdoWKZ2iRFuS2nozEF2jHLBumDA+/BPsb29VkO/d7FRJu++S3khtFR8kzBqlAWvO5
	 8eukZlFUxjOAWTODNA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N0Zns-1qzTBD0WHs-00wanB; Tue, 02
 Jan 2024 10:26:15 +0100
Message-ID: <f96d8343-e7b3-491d-b191-f2ddb4ba5269@web.de>
Date: Tue, 2 Jan 2024 10:26:12 +0100
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
 <4307bce9-ccbd-4bc5-aa8e-b618a1664cbe@web.de>
 <ZZLuaRwSZI16EKdP@tissot.1015granger.net>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <ZZLuaRwSZI16EKdP@tissot.1015granger.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fHraEXCZs9bFHLtOOPd8xSkwRa+bWUmDA46Cp6Cx+X+wgYf5Du9
 kWjIIkrOvlTarY4rBGy9eMpWqFRSmflO8KGY2pJiVlfFYYnbRCXVMXZR4G79TElPx1ek8yi
 0ZPOUb32uwUl3TE2JjWkw99MUtTGbQtMol7sDX7byJhEsqJE+3Y8UPaerVS1DdeV2c/N8Xb
 G7kAL10sJ7zGV86fLOdSQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:fOO4Nl2obn4=;zj++G77n+wQ4X6DGe67n4Af16x/
 BnxbsJbuio2eixsTb/MVEc0LnPGtsEU0hDvLoOhNCfqMd7Dd13yjijAJ8kxPmLJNwKLmbU+9g
 GTolCHXPMbY/Fb1mF5CbvSORa/KRBEaHJWhfb/4WMwRJuQwOoOWYeXR1TpZSbbzKzk7LewqFN
 7kteIP6AgATwYi17wcLWY1vD5T9gPjz3X+iAXtRdZ0yDP64EzpYXzm6LXVsz92xpbVcKqLzzv
 Hvtn/gxVx39NSfMEIp6r3L2V3ZWwSwkl+4OEj5VAiHBbZ+yH53hqwyOCkfmSKcgEz8RviyJ1V
 5jQN984jOSpSA2gGVZS9cj6t04UvaG0wyD56HlFkzqtMMr6MVPTj66Rd7mb1fD20vsZVixyVR
 8fgs5YqgdPyan4BxcLC6QJ4WRNMYoPq9rd76GF5kkaKZ7Ku+KQusyxUCoD+8wfObSpAERXFbY
 AGQaJPGz4xsdieT3b7tU0hlZlRLfUelGl/lXlpo7ByhI9sBpXS2RTaP7nfU45mREQjoLeNUt9
 8m39WxYJ/yqV3TZe5ya/sIAX7zJYXOaHJe0y7u/6webrFvce621s/Wts162oEq6jPgTwx0lgU
 hds8POQUd39R+xuQqijLrIX9uV1L3peqvWQ0ewkULKfYaAGzn5ICa+JOp46cuBKeFggicAB7C
 maQcifEoTsdkGlPVgMN+MQoedwh2aq3FjAL4TuvpXXPRFtJHKuwzVnuoAoFWUkL4CJEf6EO2Q
 CVda/bE9wfp3N1S68w8ZirbZhP0DZM1oCJjI7sd3oV6aH3kbagluVHtvRnIjm5uwKMEeM6KQ/
 qUOSCegDKHcIqxgQnkbePreeh4ehreXnLvBRHjgrdnTae7B7m/5p6mZLqPpcI7M/xzD5NQpOq
 JF+JiTG4++QKzdjT/h7YW1G1qrD6hndR32dUK4msLr/io/C8guszxK/7TMZ+0BodcrdZC7N59
 7Y3h44frkfzqJfKJrthHeA8l8BM=

=E2=80=A6
> +++ b/net/sunrpc/auth_gss/gss_krb5_crypto.c
=E2=80=A6
> @@ -970,8 +969,7 @@ u32 krb5_etm_checksum(struct crypto_sync_skcipher *c=
ipher,
>
>  out_free_ahash:
>  	ahash_request_free(req);
> -out_free_mem:
> -	kfree(iv);
> +out_free_cksumdata:
>  	kfree_sensitive(checksumdata);
>  	return err ? GSS_S_FAILURE : GSS_S_COMPLETE;
>  }
=E2=80=A6

How do you think about to use the identifier =E2=80=9Cout_free_checksumdat=
a=E2=80=9D?

Regards,
Markus

