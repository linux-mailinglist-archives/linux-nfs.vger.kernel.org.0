Return-Path: <linux-nfs+bounces-4889-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4E6930C65
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jul 2024 03:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CCFE1C20CC7
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jul 2024 01:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14828825;
	Mon, 15 Jul 2024 01:44:43 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219CE4A35;
	Mon, 15 Jul 2024 01:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721007883; cv=none; b=rwAzUwznk/Ju/B8R8bVYu3rA7gjBJ22IeBOekpo0nWeWW3GdkvdCkwIMOtCCyVwTBOsAJHYadzm4hfZ4m0ChpmmQkWYxRexy21bT39JWOnMH6UnIZFmV69GR8NhFr75eikdsV0dH584LWwjt7aRUsCeC4yplt4rU9khsFUD5Wzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721007883; c=relaxed/simple;
	bh=1vJii2XnkjthCQadleBXOUiKDMQg8bzdEkqIYh+tMR4=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=FBuuNrP4ydPaM9hwblT1s5f/LYGiB8+l91P+6GHQvsI0Jp6lh/bLe6+UVX/HgWae8gVpEy2BNjTjO36leqL86oyoMWaD+2ao2PCkTQrn+wDcrhrYdi1yVlu1ph7UJUFxcM1GT66L1LB6kL/9HstoegB0OYX81CwmPNk2AVFfi30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WMlMD5qZfz4wsG;
	Mon, 15 Jul 2024 09:42:48 +0800 (CST)
Received: from kwepemd200011.china.huawei.com (unknown [7.221.188.251])
	by mail.maildlp.com (Postfix) with ESMTPS id 6B1581800A0;
	Mon, 15 Jul 2024 09:44:31 +0800 (CST)
Received: from [10.67.110.176] (10.67.110.176) by
 kwepemd200011.china.huawei.com (7.221.188.251) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Mon, 15 Jul 2024 09:44:30 +0800
Subject: Re: [PATCH -next,v2] gss_krb5: refactor code to return correct
 PTR_ERR in krb5_DK
To: Chuck Lever III <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>
CC: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
	Jeff Layton <jlayton@kernel.org>, Olga Kornievskaia <kolga@netapp.com>, Dai
 Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <ZpE9luTCrUnh8RBH@tissot.1015granger.net>
 <172093150291.15471.15426043640692195014@noble.neil.brown.name>
 <8A935EDD-1959-474E-BB5B-92E0F8C2CF2A@oracle.com>
From: cuigaosheng <cuigaosheng1@huawei.com>
Message-ID: <9c21336d-17c7-9e2b-2661-aa1d2b53ac11@huawei.com>
Date: Mon, 15 Jul 2024 09:44:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <8A935EDD-1959-474E-BB5B-92E0F8C2CF2A@oracle.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemd200011.china.huawei.com (7.221.188.251)

But crypto_sync_skcipher_setkey maybe return -ENOMEM, Should this be 
modified?

thanks!

On 2024/7/15 0:18, Chuck Lever III wrote:
>
>> On Jul 14, 2024, at 12:31 AM, NeilBrown <neilb@suse.de> wrote:
>>
>> On Sat, 13 Jul 2024, Chuck Lever wrote:
>>> On Fri, Jul 12, 2024 at 09:39:08AM -0400, Chuck Lever wrote:
>>>> On Fri, Jul 12, 2024 at 03:24:23PM +0800, Gaosheng Cui wrote:
>>>>> Refactor the code in krb5_DK to return PTR_ERR when an error occurs.
>>>> My understanding of the current code is that if either
>>>> crypto_alloc_sync_skcipher() or crypto_sync_skcipher_blocksize()
>>>> fails, then krb5_DK() returns -EINVAL. At the only call site for
>>>> krb5_DK(), that return code is unconditionally discarded. Thus I
>>>> don't see that the proposed change is necessary or improves
>>>> anything.
>>> My understanding is wrong  ;-)
>> True, but I think your conclusion was correct.
>>
>> krb5_DK() returns zero or -EINVAL.
>> It is only used by krb5_derive_key_v2(), which returns zero or -EINVAL,
>> or -ENOMEM.
> These are really the only three interesting return codes.
> Leaking other error codes to callers is not desirable, IMO.
>
> But looking at the current implementation of
> crypto_alloc_sync_skcipher(), it returns either
> ERR_PTR(-EINVAL) or a valid pointer; it doesn't return any
> other error value. Since it never returns -ENOMEM, there
> still doesn't seem to be a technical reason for modifying
> krb5_DK() to pass errors through.
>
>
>> krb4_derive_key_v2() is only used as a ->derive_key() method.
>> This is called from krb5_derive_key(), and various unit tests in
>> gss_krb5_tests.c
>>
>> krb5_derive_key() is only called in gss_krb5_mech.c, and each call site
>> is of the form:
>>   if (krb5_derive_key(...)) goto out;
>> so it doesn't matter what error is returned.
>>
>> The unit test calls are all followed by
>> KUNIT_ASSERT_EQ(test, err, 0);
>> so the only place the err is used is (presumably) in failure reports
>> from the unit tests.
>>
>> So the proposed change seems unnecessary from a practical perspective.
>>
>> Maybe it is justified from an aesthetic perspective, but I think that
>> should be clearly stated in the commit message.  e.g.
>>
>>   This change has no practical effect as all non-zero error statuses
>>   are treated equally, however the distinction between EINVAL and ENOMEM
>>   may be relevant at some future time and it seems cleaner to maintain
>>   the distinction.
>>
>> NeilBrown
>>
>>
>>> The return code isn't discarded. A non-zero return code from
>>> krb5_DK() is carried back up the call stack. The logic in
>>> krb5_derive_key_v2() does not use the kernel's usual error flow
>>> form, so I missed this.
>>>
>>> However, it still isn't clear to me why the error behavior here
>>> needs to change. It's possible, for example, that -EINVAL is
>>> perfectly adequate to indicate when sync_skcipher() can't find the
>>> specified encryption algorithm (gk5e->encrypt_name).
>>>
>>> Specifying the wrong encryption type: -EINVAL. That makes sense.
>>>
>>>
>>>>> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
>>>>> ---
>>>>> v2: Update IS_ERR to PTR_ERR, thanks very much!
>>>>> net/sunrpc/auth_gss/gss_krb5_keys.c | 8 ++++++--
>>>>> 1 file changed, 6 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/net/sunrpc/auth_gss/gss_krb5_keys.c b/net/sunrpc/auth_gss/gss_krb5_keys.c
>>>>> index 4eb19c3a54c7..5ac8d06ab2c0 100644
>>>>> --- a/net/sunrpc/auth_gss/gss_krb5_keys.c
>>>>> +++ b/net/sunrpc/auth_gss/gss_krb5_keys.c
>>>>> @@ -164,10 +164,14 @@ static int krb5_DK(const struct gss_krb5_enctype *gk5e,
>>>>> goto err_return;
>>>>>
>>>>> cipher = crypto_alloc_sync_skcipher(gk5e->encrypt_name, 0, 0);
>>>>> - if (IS_ERR(cipher))
>>>>> + if (IS_ERR(cipher)) {
>>>>> + ret = PTR_ERR(cipher);
>>>>> goto err_return;
>>>>> + }
>>>>> +
>>>>> blocksize = crypto_sync_skcipher_blocksize(cipher);
>>>>> - if (crypto_sync_skcipher_setkey(cipher, inkey->data, inkey->len))
>>>>> + ret = crypto_sync_skcipher_setkey(cipher, inkey->data, inkey->len);
>>>>> + if (ret)
>>>>> goto err_free_cipher;
>>>>>
>>>>> ret = -ENOMEM;
>>>>> -- 
>>>>> 2.25.1
>>>>>
>>>> -- 
>>>> Chuck Lever
>>>>
>>> -- 
>>> Chuck Lever
>>>
> --
> Chuck Lever
>
>

