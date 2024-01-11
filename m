Return-Path: <linux-nfs+bounces-1031-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FEAD82ABA2
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jan 2024 11:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 016441F2121D
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jan 2024 10:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B240911737;
	Thu, 11 Jan 2024 10:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="XLQEayMq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from sonic309-13.consmr.mail.bf2.yahoo.com (sonic309-13.consmr.mail.bf2.yahoo.com [74.6.129.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6155312E47
	for <linux-nfs@vger.kernel.org>; Thu, 11 Jan 2024 10:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1704967847; bh=VGKB+LCbXj1Sg1tlBk9ol50fsnIBO8w9o69zvIxVhrc=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=XLQEayMqlbZxlvioAOiPTSPD7PA4mj0xB0DeZJPg6SwIxg90U1eOI2yED8wVaGSFEuaHZZKLHOalbEtELC8H3WiAjoZPFoxClaw6VWhI8I59hR0wGtv2OwYIeFsYGt9uX775oIg1ajIOfUOxRGaz4a3gBCMGuFHEtseR3xJkaxoyF8h6HHy1NSIqHaldri2ksGWjnPnq1D+ddk1MClDrOACFRfZrJp7xjO34qqBdJyjNG+hyFIGX0ERFWoTeyB5otl7//5YWNvnFnnqFNeeBOhCrheApp4sNrcpd5Q3fzK0NEOxQgItlCOk83x6g18ntpB4jgN3BqxdyseE2croa1Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1704967847; bh=xAwqFVgRQkL6Y0B6LVaKSL5n8HBZhz8GPWlHo6TzKZ0=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=cpyW6j4Dx0cQ2pLH+NHjkEAFdY7aAKnqA1ppgQMNFVNdioTWdjymU4RPfSzRxZ3vVhTtpM5DkCQC4A6pzvkSPmkaY1H1E+a1x9U2DC1v5rmjf8uaw5l/DQeIbjQdfjFNhCUfLNFJRgGyJkVgOePBUvNvm92jnkZdRgeLuAv6mFlSVcVUorxQJ631yv7XwqJ91P3ukJaMdFEORELzswNyoFpii6CX16YIArjTcCvFT+REucQzt+d+uWOYXU0Sl4x9CMbk8LNmGDjE8tS5TwcQwlzkSc0+ZIkbI6h7paWC3j7/aEJ8JPmIlsy+qVGGz2U8UKTNMXim7j/4DP2BDkaX9w==
X-YMail-OSG: eDjBPuUVM1lGOGsMphIIzHvbLkdU6fTaiVskrxNqU1RI9_.TuT4xnlbi2P7lHWy
 wHiQqRVhVG5nW9YyWfMjX0zE.EjsW2VGiBi9swEEvzp14WTws6BcLireVPTV3ohwrFRgCdsGeITW
 X2B04qxA7HhCxXRFaXxAuM2h.eSMgPc.t6g3l1sovmyObTHpDS9_sqjLq2WWINvEfJQ.1y0SX_UR
 xLWBz2duxNQGwXXUT5pFSS6348OtQKZyyyx5rh73KmIRUs87TkbSB1aJetIPwZzahYg4.Sebik0N
 hJpA6RbJ72.Wv41t0wZceJQeJW33S0v5bnewcyFI0gTDMFR3FPeH4Onxjmp_h5B7Ft7grTLWBUDh
 EgBcuRbwp0b.6MtUL.t655vCkifdcPL.Vtnsz2IIsK48XXiX5nFLQ6aLfOzfkWCqBC0OQSwA_FxJ
 RVX4kmPtU_gRAIq_42WCE7N0c_cQd7A_fTgf041NMs634MgHRjZ9O4hXV6KVYBcXJj.0oQs4t1eI
 vAozLGs.ifhg8FeJNgTWlW6TJhAf73jgIJoZGu0.vcVh5QcYSQ6El7QswAQ7re0PFk6Tz..X8qkm
 Uv2jx6sMspdfORujJchWbrEUJjaiL5XajQ0ikuILNEwcd5zg0OAKE3Ky3Ltxr39wXSDknf67oPPI
 Cbg.izHJevuvNDv8mL2z_ESfS_x27LN4CdRkKSwrTah8w8CIOnAf4QMKsYxPMKa6Hi35oq7b51lz
 EhmwFCNlixNZgnKAdkFzPddlD1NcvrtDjelpK3UbDh5wypXdPu_awtOl15k3tmAiLHtmAgPJgsRq
 zbilP.KjlUiRyE7zppVmMtc2BQ7ik3AFR2X1f2RMlZ8gqdxBTol4aQwM.4UD3gMgRRkXGGxk1isP
 2E1JDx09T0D7.lqMjsSwa9_..tybKPY0fusQpetJx6QDqfjNns1QpTNOHCXhRi1bqooOV6hoN_yg
 tWsu2AWWG3gbYIAiIHmtktbD.WlH3WJXjBse3eT0wx_r76biouksE5Cs7t4NDpFZjnYbpTLhq5Qn
 ckinUFOuT0.WAMmCTHrbfickfxCgHHQ83DC1pvqo7TDdtvT8KRHOb5EV5VB0wvxdXySWIbM49lya
 G7rcyVXY.yJAvxfHOA_A8Ra8XO2SqQBgh9DrM8cR_QKJprW.Vi5.hYS2FlUwE7jVwZrcGzn.Is89
 Xnvq7hYc8.Y6tFJjgF0F9fudPavDy26UgPDjQ5IeIVPVNMUwTEjetP9oVj4VuLO7hbLXzdIJfN4W
 SGx_wVTjuGcu9.sicQluzrLG4CVvbw26EVs21mUyv.EBTsrmdi6y1Z7.fOx_pIJUuG9zciZQK8YN
 Zjd6TtauqrGwZst2XG6w3CxyubPBGicFuGBCr4Yf16aGvNuJbp1ceckuXYteWFEd22GlDb_5_OvV
 SiZ..ydQHZnBe5n51Emhooff9ii2gGoPPQxEtRR2a18dmiBzphuc5f7oAY2SbT0GTplErQcuSKXq
 5SU_UmFsi.SA8cimzYnc4zGmWb1GgFpLq82Gz1u297MRgUhWHi6UpLJ05hjT9ckgNdvyKEAaF9Q5
 FBfLpjk7cNUnJHKRdpjsIgtZhP.Ixul1wgQiaZERT3AIDa3WqU4cGrGEy9C6cj9wPXlzkZwEwoXZ
 hrb_5P_Bze32EKqhSNTh177ZavUKbLcse5RqwmW0NeiaYXFZYl9P7Q8VCFpGwEPRW6vqcOjg01XB
 yUJ8IyofrsAXkmuE5tiKGfZEisVrOqanirXBmZfNz84wpmhFMIxd9hQ_IDohwoz1L.Ul3mcLb8rM
 JTPDTgO4J.BkKsWyQY2OjfXcvN0zdAGgN5qCbgTwKyOrYX0oZM8fysJUxHmEXRjsgwi5KCPjkcZp
 e7CmTjIx9SQOkSxrWSDEcpEQtwHuZjPZnQqjZapIZ_hAau6lMoZE4xl1nVodayf5oHSxUC8S2Bo3
 shY8PGINVoumO6IbSODIkcxjeROsZK3rwDvzHf6C9A49vNsH5eH7KIgK7RoNmG4Lq1URDH.fXanE
 cosXO5e9FOzQt_K2zMXVP5Xy8srER2oAKjn4DkZIW_Xhd3qpyYIM35IhNzGzu.QcJdLluybBYcYx
 OJzTT4BBCaWzjtYpaBvkKtoU_HpIHhHcxVQIKoJffEFAvcTf0VMNeM.W3DkeFSTM0B7FS63FG3AL
 zoprdkfqt7oE_5._tMrKz4yuQqiiOzf80jvnxxHDUx9PJJ295FiLkkiwOzgBcB7ihU6EZCDhB9ME
 NEJoQSqV7TvTxGXa0vncJnR7dJY5GCibfPpWkKIldCgEl67WBubBJwg--
X-Sonic-MF: <email200202@yahoo.com>
X-Sonic-ID: 605597fd-cd08-4d26-8d90-61d7014dcedf
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.bf2.yahoo.com with HTTP; Thu, 11 Jan 2024 10:10:47 +0000
Received: by hermes--production-gq1-78d49cd6df-hlpbq (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 20d75bad1adb0dad25301cdfc3e296bf;
          Thu, 11 Jan 2024 10:10:43 +0000 (UTC)
Message-ID: <3b8250ac-79e4-46d1-a508-5773e6330fb4@yahoo.com>
Date: Thu, 11 Jan 2024 21:10:39 +1100
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] After kernel upgrade 6.1.70 to 6.1.71, the computer
 hangs during shutdown
Content-Language: en-US
To: Greg KH <gregkh@linuxfoundation.org>
Cc: regressions@lists.linux.dev, kernel@gentoo.org, stable@vger.kernel.org,
 linux-nfs@vger.kernel.org
References: <58ac38ae-4d64-4a53-81e0-35785961c41c.ref@yahoo.com>
 <58ac38ae-4d64-4a53-81e0-35785961c41c@yahoo.com>
 <2024011127-excluding-bodacious-1950@gregkh>
From: email200202 <email200202@yahoo.com>
In-Reply-To: <2024011127-excluding-bodacious-1950@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.22010 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

Hi Greg

I'm sorry. This my first kernel report.

I didn't test 6.6.x and 6.7.x.  I use only 6.1.x.

Best Regards

John G

On 11/1/24 20:30, Greg KH wrote:
> On Thu, Jan 11, 2024 at 07:20:02PM +1100, email200202 wrote:
>> Reverting the following 3 commits fixed the problem in kernel 6.1.71:
>>
>> f9a01938e07910224d4a2fd00583725d686c3f38
>> bb4f791cb2de1140d0fbcedfe9e791ff364021d7
>> 03d68ffc48b94cc1e15bbf3b4f16f1e1e4fa286a
> When sending us git ids, please show the full context so we have a hint
> as to what they are.  For this, it should be:
>
> f9a01938e079 ("NFSD: fix possible oops when nfsd/pool_stats is closed.")
> bb4f791cb2de ("nfsd: call nfsd_last_thread() before final nfsd_put()")
> 03d68ffc48b9 ("nfsd: separate nfsd_last_thread() from nfsd_put()")
>
> Do you also have these issues in the latest 6.6.y release?  6.7?
>
> thanks,
>
> greg k-h


