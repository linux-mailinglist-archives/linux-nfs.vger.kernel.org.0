Return-Path: <linux-nfs+bounces-2134-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B507686D95F
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Mar 2024 03:06:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AFB01F243AF
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Mar 2024 02:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 576AD39AE8;
	Fri,  1 Mar 2024 02:06:29 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F0A39ACE;
	Fri,  1 Mar 2024 02:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709258789; cv=none; b=ITS57n3gdkR5MClQV0ybJKMQ0EZiMsPHnw7ydnVGSfOCXMGqTt48WD5sxKRm5SJQANrjdFY77BAi5nS+WRASGTjVR/nkz58NnOAfbdEShDpDD+igkU8PZ9rqnZlCOlTTjABtv0WwVuqxbut0jlvR/5Om2ZrfnaSPzmiZKIpy3FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709258789; c=relaxed/simple;
	bh=fJAAOCcqK3dYdJ3pSM8aaqXhrQJt3qoqEqGB4cghUIE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ni4G7gS0MZIw/mSC/6kl91/ZrA91lIsjc5kRE75Tdsn1ApL38Frj8T+1/+12L3A1OfDd/C5rgfw4pJS/exkYmvlO66D6dfkZhTPNBrmZLwGiLMa3VS1dhDKmsaGHEVFNFonpzC95tl7tNXZhoNNcIOEeYtF4rStn/WchJZ3ronY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: c989d866796349e792069577c80d5396-20240301
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:e3765211-90fa-4aee-99e5-92fc7f0ccea8,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.37,REQID:e3765211-90fa-4aee-99e5-92fc7f0ccea8,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6f543d0,CLOUDID:6bdbe08f-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:2402292140264UI5XS11,BulkQuantity:5,Recheck:0,SF:44|64|66|38|24|17|1
	9|102,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:40,QS:nil,B
	EC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: c989d866796349e792069577c80d5396-20240301
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 561634308; Fri, 01 Mar 2024 10:06:19 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 5A3E2E000EBC;
	Fri,  1 Mar 2024 10:06:19 +0800 (CST)
X-ns-mid: postfix-65E1381B-294018254
Received: from [172.20.15.254] (unknown [172.20.15.254])
	by mail.kylinos.cn (NSMail) with ESMTPA id 01990E000EBC;
	Fri,  1 Mar 2024 10:06:18 +0800 (CST)
Message-ID: <b5be1cba-42b2-4474-a607-771331dbc9c8@kylinos.cn>
Date: Fri, 1 Mar 2024 10:06:17 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfs: use KMEM_CACHE() to create nfs_commit_data cache
Content-Language: en-US
To: Trond Myklebust <trondmy@hammerspace.com>,
 "anna@kernel.org" <anna@kernel.org>,
 "kunwu.chan@linux.dev" <kunwu.chan@linux.dev>
Cc: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20240229094112.1154644-1-kunwu.chan@linux.dev>
 <6a1136c39cc9d8e4ae4800ad81e8e72f3b8b4516.camel@hammerspace.com>
From: Kunwu Chan <chentao@kylinos.cn>
In-Reply-To: <6a1136c39cc9d8e4ae4800ad81e8e72f3b8b4516.camel@hammerspace.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Thanks for the reply.

On 2024/2/29 21:40, Trond Myklebust wrote:
> On Thu, 2024-02-29 at 17:41 +0800, kunwu.chan@linux.dev wrote:
>> From: Kunwu Chan <chentao@kylinos.cn>
>>
>> Use the KMEM_CACHE() macro instead of kmem_cache_create() to simplify
>> the creation of SLAB caches when the default values are used.
>>
>> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
>> ---
>>  =C2=A0fs/nfs/write.c | 5 +----
>>  =C2=A01 file changed, 1 insertion(+), 4 deletions(-)
>>
>> diff --git a/fs/nfs/write.c b/fs/nfs/write.c
>> index bb79d3a886ae..6a75772d447f 100644
>> --- a/fs/nfs/write.c
>> +++ b/fs/nfs/write.c
>> @@ -2148,10 +2148,7 @@ int __init nfs_init_writepagecache(void)
>>  =C2=A0	if (nfs_wdata_mempool =3D=3D NULL)
>>  =C2=A0		goto out_destroy_write_cache;
>>  =20
>> -	nfs_cdata_cachep =3D kmem_cache_create("nfs_commit_data",
>> -					=C2=A0=C2=A0=C2=A0=C2=A0 sizeof(struct
>> nfs_commit_data),
>> -					=C2=A0=C2=A0=C2=A0=C2=A0 0, SLAB_HWCACHE_ALIGN,
>> -					=C2=A0=C2=A0=C2=A0=C2=A0 NULL);
>> +	nfs_cdata_cachep =3D KMEM_CACHE(nfs_commit_data,
>> SLAB_HWCACHE_ALIGN);
>>  =C2=A0	if (nfs_cdata_cachep =3D=3D NULL)
>>  =C2=A0		goto out_destroy_write_mempool;
>=20
> If this were being done as part of an actual functional code change,
> then I'd be OK with it, but otherwise it is just unnecessary churn that
> gets in the way of back porting any future fixes.
It's just my personal opinion, I meant to do some cleanup. It's not=20
entirely necessary either, as everyone prefers a different style of=20
code. It doesn't matter.
>=20
>=20
--=20
Thanks,
   Kunwu


