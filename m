Return-Path: <linux-nfs+bounces-4854-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF8692F61E
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jul 2024 09:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09F371C21EF1
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jul 2024 07:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8DC613D8B3;
	Fri, 12 Jul 2024 07:25:50 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B613635;
	Fri, 12 Jul 2024 07:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720769150; cv=none; b=khqrG/1urAiEE2rCx7kbG3Jl01kC/66F6SSSknfSixCqCpImS1tra4mLxvul34/LowqayjFHZ/J3ATHfw0YYtEQr7Mpc90oeoUEBj4T8kln5uNXncoedwyTVZv2anJ2ZKHDHLopOBUzIeZGEJjymqFwNtaHucClQu67DXB5g2Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720769150; c=relaxed/simple;
	bh=Crg6r5zrhZ2perSdfw1G2O4TpBlg/S2xMW4vARpTK6c=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=R+5HmMPfj+HXuqQA0+vW1COOxnjT/WUVfGmk7fhk5LdVe/BfB3oVdbZMP25BPbxE/H7qNMKHyX0V3oNNBV4T7pRWcFLrB8f1viy6z3nZHbGBeGpPQ7pA0mWQV/ZoYLnuGU0SyfF5BZj08jzBOU1see/8gWULn0TZ5X2wdfH0LaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WL31K6VjPz28fS9;
	Fri, 12 Jul 2024 15:21:25 +0800 (CST)
Received: from kwepemd200011.china.huawei.com (unknown [7.221.188.251])
	by mail.maildlp.com (Postfix) with ESMTPS id C51361A016C;
	Fri, 12 Jul 2024 15:25:39 +0800 (CST)
Received: from [10.67.110.176] (10.67.110.176) by
 kwepemd200011.china.huawei.com (7.221.188.251) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Fri, 12 Jul 2024 15:25:39 +0800
Subject: Re: [PATCH -next] gss_krb5: refactor code to return correct PTR_ERR
 in krb5_DK
To: Hariprasad Kelam <hkelam@marvell.com>
CC: <trondmy@kernel.org>, <anna@kernel.org>, <chuck.lever@oracle.com>,
	<jlayton@kernel.org>, <neilb@suse.de>, <kolga@netapp.com>,
	<Dai.Ngo@oracle.com>, <tom@talpey.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <linux-nfs@vger.kernel.org>, <netdev@vger.kernel.org>
References: <20240712060312.1905013-1-cuigaosheng1@huawei.com>
 <ZpDWp9P6M+LUVcBZ@test-OptiPlex-Tower-Plus-7010>
From: cuigaosheng <cuigaosheng1@huawei.com>
Message-ID: <28e91219-6e53-f0e8-52f2-fab055ee3d70@huawei.com>
Date: Fri, 12 Jul 2024 15:25:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZpDWp9P6M+LUVcBZ@test-OptiPlex-Tower-Plus-7010>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd200011.china.huawei.com (7.221.188.251)

yeah, thanks very much.

On 2024/7/12 15:09, Hariprasad Kelam wrote:
> On 2024-07-12 at 11:33:12, Gaosheng Cui (cuigaosheng1@huawei.com) wrote:
>> Refactor the code in krb5_DK to return PTR_ERR when an error occurs.
>>
>> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
>> ---
>>   net/sunrpc/auth_gss/gss_krb5_keys.c | 8 ++++++--
>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/sunrpc/auth_gss/gss_krb5_keys.c b/net/sunrpc/auth_gss/gss_krb5_keys.c
>> index 4eb19c3a54c7..b809e646329f 100644
>> --- a/net/sunrpc/auth_gss/gss_krb5_keys.c
>> +++ b/net/sunrpc/auth_gss/gss_krb5_keys.c
>> @@ -164,10 +164,14 @@ static int krb5_DK(const struct gss_krb5_enctype *gk5e,
>>   		goto err_return;
>>   
>>   	cipher = crypto_alloc_sync_skcipher(gk5e->encrypt_name, 0, 0);
>> -	if (IS_ERR(cipher))
>> +	if (IS_ERR(cipher)) {
>> +		ret = IS_ERR(cipher);
>           need to use PTR_ERR?
>
> Thanks,
> Hariprasad k
>
>
> .

