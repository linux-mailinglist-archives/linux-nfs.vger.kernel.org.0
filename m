Return-Path: <linux-nfs+bounces-4875-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD9C930363
	for <lists+linux-nfs@lfdr.de>; Sat, 13 Jul 2024 04:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D29D1F22355
	for <lists+linux-nfs@lfdr.de>; Sat, 13 Jul 2024 02:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C439125B9;
	Sat, 13 Jul 2024 02:59:43 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A12A1849;
	Sat, 13 Jul 2024 02:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720839583; cv=none; b=DB+mBvH5RObZSt6mRHkMZLhQUhlN5xEpBC26j17Heki0Hqc+8saYEVZHdxXhU7aTgK8IX13UgKptuB9HwQva7qD81b61Alp/x7CtEk7bB+X26ydGoAnSeu3AVMpZpfzmXvM12dN9cm+/4895bt/eFBIPOTWTEOXZVXG4+a2jex4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720839583; c=relaxed/simple;
	bh=O6bTVwvQaYdt6K0mhtCJE/WG81yT3XSy98eP6Cc32Xw=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=lbBwvQfxFKdECoIq8D7JPBw37weGM7c0D0aRoBC6IBahWzRifTvv6zHjRmLobWmAfcyTqTCtE5qJJNdB8Zjxk9kRxCFGnvHoOrIGwWa0tX+QzdSNaFjwV6dw/BL/U1wPTrvrdRvSGPV87QqadJ6Py6954xFSRBKZwfVw16DvpmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4WLY354cx1z1JC9c;
	Sat, 13 Jul 2024 10:54:41 +0800 (CST)
Received: from kwepemd200011.china.huawei.com (unknown [7.221.188.251])
	by mail.maildlp.com (Postfix) with ESMTPS id AE3A418009E;
	Sat, 13 Jul 2024 10:59:27 +0800 (CST)
Received: from [10.67.110.176] (10.67.110.176) by
 kwepemd200011.china.huawei.com (7.221.188.251) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Sat, 13 Jul 2024 10:59:26 +0800
Subject: Re: [PATCH -next,v2] gss_krb5: refactor code to return correct
 PTR_ERR in krb5_DK
To: Chuck Lever <chuck.lever@oracle.com>
CC: <trondmy@kernel.org>, <anna@kernel.org>, <jlayton@kernel.org>,
	<neilb@suse.de>, <kolga@netapp.com>, <Dai.Ngo@oracle.com>, <tom@talpey.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <linux-nfs@vger.kernel.org>,
	<netdev@vger.kernel.org>
References: <20240712072423.1942417-1-cuigaosheng1@huawei.com>
 <ZpEx/Jejy/CiXE5Z@tissot.1015granger.net>
 <ZpE9luTCrUnh8RBH@tissot.1015granger.net>
From: cuigaosheng <cuigaosheng1@huawei.com>
Message-ID: <0735690c-9c05-b932-7883-c2f7425b3076@huawei.com>
Date: Sat, 13 Jul 2024 10:59:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZpE9luTCrUnh8RBH@tissot.1015granger.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd200011.china.huawei.com (7.221.188.251)

Thanks for reviewing this patch.

I think this modification makes sense, for example, if 
crypto_sync_skcipher_setkey

return -ENOMEM, it's better to return -ENOMEM than to return -EINVAL,

just like elsewhere.

On 2024/7/12 22:28, Chuck Lever wrote:
> On Fri, Jul 12, 2024 at 09:39:08AM -0400, Chuck Lever wrote:
>> On Fri, Jul 12, 2024 at 03:24:23PM +0800, Gaosheng Cui wrote:
>>> Refactor the code in krb5_DK to return PTR_ERR when an error occurs.
>> My understanding of the current code is that if either
>> crypto_alloc_sync_skcipher() or crypto_sync_skcipher_blocksize()
>> fails, then krb5_DK() returns -EINVAL. At the only call site for
>> krb5_DK(), that return code is unconditionally discarded. Thus I
>> don't see that the proposed change is necessary or improves
>> anything.
> My understanding is wrong  ;-)
>
> The return code isn't discarded. A non-zero return code from
> krb5_DK() is carried back up the call stack. The logic in
> krb5_derive_key_v2() does not use the kernel's usual error flow
> form, so I missed this.
>
> However, it still isn't clear to me why the error behavior here
> needs to change. It's possible, for example, that -EINVAL is
> perfectly adequate to indicate when sync_skcipher() can't find the
> specified encryption algorithm (gk5e->encrypt_name).
>
> Specifying the wrong encryption type: -EINVAL. That makes sense.
>
>
>>> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
>>> ---
>>> v2: Update IS_ERR to PTR_ERR, thanks very much!
>>>   net/sunrpc/auth_gss/gss_krb5_keys.c | 8 ++++++--
>>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/net/sunrpc/auth_gss/gss_krb5_keys.c b/net/sunrpc/auth_gss/gss_krb5_keys.c
>>> index 4eb19c3a54c7..5ac8d06ab2c0 100644
>>> --- a/net/sunrpc/auth_gss/gss_krb5_keys.c
>>> +++ b/net/sunrpc/auth_gss/gss_krb5_keys.c
>>> @@ -164,10 +164,14 @@ static int krb5_DK(const struct gss_krb5_enctype *gk5e,
>>>   		goto err_return;
>>>   
>>>   	cipher = crypto_alloc_sync_skcipher(gk5e->encrypt_name, 0, 0);
>>> -	if (IS_ERR(cipher))
>>> +	if (IS_ERR(cipher)) {
>>> +		ret = PTR_ERR(cipher);
>>>   		goto err_return;
>>> +	}
>>> +
>>>   	blocksize = crypto_sync_skcipher_blocksize(cipher);
>>> -	if (crypto_sync_skcipher_setkey(cipher, inkey->data, inkey->len))
>>> +	ret = crypto_sync_skcipher_setkey(cipher, inkey->data, inkey->len);
>>> +	if (ret)
>>>   		goto err_free_cipher;
>>>   
>>>   	ret = -ENOMEM;
>>> -- 
>>> 2.25.1
>>>
>> -- 
>> Chuck Lever
>>

