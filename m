Return-Path: <linux-nfs+bounces-8321-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A18D49E1BB3
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Dec 2024 13:12:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 646B5166285
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Dec 2024 12:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7DC1E412E;
	Tue,  3 Dec 2024 12:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AQPnHzRn"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB408F6C
	for <linux-nfs@vger.kernel.org>; Tue,  3 Dec 2024 12:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733227925; cv=none; b=u+QKLJHlF1bSRFbyk39LYX+16SpHm8cysV5Y+hxs0zy6U8jBgP/BymA35P9oNgOMEBX20Mz8CwUjVUXz1afwhKOfQa8pr/6yQIUQRQLMyzghmC2WIPQFpCaxb5RJhQcV+C69ASlU/czWc00PurhxHh9xcUq2v7/KzOZ0L5feGu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733227925; c=relaxed/simple;
	bh=PcXte/OmVXMRIY8hTg++jexwFrCi3iPmc6ysqGyZSYo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dpFFAfwFa3yQUzmXvOHiuyvmA4hazHGF8wecBTAEqcSjgp9hnyy/fx1ggwaSrQ5Lht3jA2KDJw1Aav6RIZBjPoh1P9GWrU03TU3j3cUwD0/cV6nmkGbBmYMYIU8bNdgscu5gz+inAnhSlJx5vbx3nGVLRweBxnZ2SXkNyWFgaGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AQPnHzRn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733227923;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/cDq6hfQa/mV4E8AUneOJ9PtSO112nhhv8XSbq6208I=;
	b=AQPnHzRnwz2BbtSIR0Bz4tiJymbKbVd4WiY9CkCr3tpzlSIOAUFc1u0CsGG78M3kMoG8El
	uaCf2Ql06K/Xarah1a8ySj4AFhhOZd6UwMzuqpqdoRxg0WDHaBF/kwglM5woHbN6MyrDCy
	uqRX0vC3ro1pr8fZxJXCC/rjQqRnMZ0=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-NBcTQyZlOz2ZBjO8ngb3bw-1; Tue, 03 Dec 2024 07:12:01 -0500
X-MC-Unique: NBcTQyZlOz2ZBjO8ngb3bw-1
X-Mimecast-MFC-AGG-ID: NBcTQyZlOz2ZBjO8ngb3bw
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-841ca214adaso496044539f.1
        for <linux-nfs@vger.kernel.org>; Tue, 03 Dec 2024 04:12:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733227921; x=1733832721;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/cDq6hfQa/mV4E8AUneOJ9PtSO112nhhv8XSbq6208I=;
        b=qEpMI+JNkA0KLQxKckkQgFcdaUFSmkJYyJgUdZGlcInjL9OAHmM8cCR8V83S+8Wx5p
         g2ZQkl72axzit478+LRitA/csIL8iS74rMqleBf98KRCIhw8a412QSO6YtaSgqGMOiBf
         alh6MMiIJuGJ4TCMwrQiAVVDg0r/C12GNVIqeQ4ogfFD4bmiktBkfcCHfLJMYx+64yXi
         PrN5pj10AJoOdsoGeLP6s8JkzMGJSko7tF4YZwgsJ/md5zDME9ufGZeF/4MawJxqnW1g
         WZYUvxHe1TPNuI5vLEVPSA66CMYjGwd3+jIazGf7R1Lmtee9bK4wmUBSpbeZWqSgZgO8
         hqww==
X-Gm-Message-State: AOJu0YwCMG0djcXvkm8rWWJG1FFhY5c/bWt0DJt7eAf3ErTH51W8z+q5
	jE8/xLca+e7xjoGTfcv8dQuS16Md7qbvIwxIscpKZDYxD4dmUby48xyS/txIRbswAbKgDe4aSJ2
	v8H4eDikXPLJvI7sJ+FVGupVmLO4Sfp2rwIzpHvC/WxYvBOw4Q6F88J9YEw==
X-Gm-Gg: ASbGncurThhPa0Pn8/+nStltt38+OCA5dMqtBKg23jA8nsHU793ch7k7lqfcD/F1Ss/
	KjeV3Adf5n9DYxvU2tCQ8lCMqjnx67v0wuGMAn/VJGhQ29i/cgZ6XvuSOqVeTUBAgJpecQck68P
	U6B/0N8RqrxYTsNfqajqkMEdHenCVkxwL+OVMxr1xpgFF7cmDYM2pjKUcSO76JyO2wX7VPPJZ8V
	vuQcw/MlkfOq7lZPR2CWMhlnVpSP/L6Exs/gk0DQWqM6ajTQA==
X-Received: by 2002:a05:6602:13c5:b0:83a:b901:3150 with SMTP id ca18e2360f4ac-8445b573fcemr263918439f.8.1733227921183;
        Tue, 03 Dec 2024 04:12:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEP3tDeO7Lkx4ybLbPkewCfvGq3n323GNxzqzmLjMiG9Fz6cruW4AIBQKbFqWFih4eZCjG8FA==
X-Received: by 2002:a05:6602:13c5:b0:83a:b901:3150 with SMTP id ca18e2360f4ac-8445b573fcemr263917039f.8.1733227920829;
        Tue, 03 Dec 2024 04:12:00 -0800 (PST)
Received: from [172.31.1.12] ([70.105.249.243])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e230e5f236sm2570212173.83.2024.12.03.04.11.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 04:11:59 -0800 (PST)
Message-ID: <00a0d65f-6cce-4ae9-84d7-2eabf919063c@redhat.com>
Date: Tue, 3 Dec 2024 07:11:57 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [nfs-utils PATCH] exports: Fix referrals when
 --enable-junction=no
To: Chuck Lever <chuck.lever@oracle.com>, Scott Mayhew <smayhew@redhat.com>
Cc: linux-nfs@vger.kernel.org
References: <328fdce3-a66b-4254-a178-389caf75a685@redhat.com>
 <20241202203046.1436990-1-smayhew@redhat.com>
 <Z04pmCa0es/DH8WS@tissot.1015granger.net>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <Z04pmCa0es/DH8WS@tissot.1015granger.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/2/24 4:41 PM, Chuck Lever wrote:
> On Mon, Dec 02, 2024 at 03:30:46PM -0500, Scott Mayhew wrote:
>> Commit 15dc0bea ("exportd: Moved cache upcalls routines into
>> libexport.a") caused write_fsloc() to be elided when junction support is
>> disabled.  Get rid of the bogus #ifdef HAVE_JUNCTION_SUPPORT blocks so
>> that referrals work again (the only #ifdef HAVE_JUNCTION_SUPPORT should
>> be around actual junction code).
> 
> I agree, this looks like an unintended regression in 15dc0bea.
> 
> Reviewed-by: Chuck Lever <chuck.lever@oracle.com>
> 
> I suggest adding:
> 
> Link: https://bugs.debian.org/1035908
> Link: https://bugs.debian.org/1083098
> 
>> Fixes: 15dc0bea ("exportd: Moved cache upcalls routines into libexport.a")
>> Signed-off-by: Scott Mayhew <smayhew@redhat.com>
Fair enough... I'm also going to tone down
the "bogus" to "unnecessary"... Lets keep it civil.

steved.

>> ---
>>   support/export/cache.c | 7 -------
>>   1 file changed, 7 deletions(-)
>>
>> diff --git a/support/export/cache.c b/support/export/cache.c
>> index 6c0a44a3..3a8e57cf 100644
>> --- a/support/export/cache.c
>> +++ b/support/export/cache.c
>> @@ -34,10 +34,7 @@
>>   #include "pseudoflavors.h"
>>   #include "xcommon.h"
>>   #include "reexport.h"
>> -
>> -#ifdef HAVE_JUNCTION_SUPPORT
>>   #include "fsloc.h"
>> -#endif
>>   
>>   #ifdef USE_BLKID
>>   #include "blkid/blkid.h"
>> @@ -999,7 +996,6 @@ static void nfsd_retry_fh(struct delayed *d)
>>   	*dp = d;
>>   }
>>   
>> -#ifdef HAVE_JUNCTION_SUPPORT
>>   static void write_fsloc(char **bp, int *blen, struct exportent *ep)
>>   {
>>   	struct servers *servers;
>> @@ -1022,7 +1018,6 @@ static void write_fsloc(char **bp, int *blen, struct exportent *ep)
>>   	qword_addint(bp, blen, servers->h_referral);
>>   	release_replicas(servers);
>>   }
>> -#endif
>>   
>>   static void write_secinfo(char **bp, int *blen, struct exportent *ep, int flag_mask, int extra_flag)
>>   {
>> @@ -1120,9 +1115,7 @@ static int dump_to_cache(int f, char *buf, int blen, char *domain,
>>   		qword_addint(&bp, &blen, exp->e_anongid);
>>   		qword_addint(&bp, &blen, fsidnum);
>>   
>> -#ifdef HAVE_JUNCTION_SUPPORT
>>   		write_fsloc(&bp, &blen, exp);
>> -#endif
>>   		write_secinfo(&bp, &blen, exp, flag_mask, do_fsidnum ? NFSEXP_FSID : 0);
>>   		if (exp->e_uuid == NULL || different_fs) {
>>   			char u[16];
>> -- 
>> 2.46.2
>>
>>
> 


