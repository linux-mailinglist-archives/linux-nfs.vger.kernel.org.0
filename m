Return-Path: <linux-nfs+bounces-1927-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DED85545F
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Feb 2024 21:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56A001C25FC8
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Feb 2024 20:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 325AC12882A;
	Wed, 14 Feb 2024 20:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jr/NGEcx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0E455C1A
	for <linux-nfs@vger.kernel.org>; Wed, 14 Feb 2024 20:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707943905; cv=none; b=BEu5ZzDJFqI/bXTvRHDU4IxLjzT4Dyc/o/xZ3Qw69SpcGTJ/8HrRuxyEZwZBI3zoUTf865PmSrJpfcRSHs+owRvw/wBWs3FvTygBMn7LpAFpd4pbgdvKbBPtjvdOD+LCG1GL14yvUzESRd3sDs1vJtFg057dm0czBjtrzIhj244=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707943905; c=relaxed/simple;
	bh=8wHQxf2/giaej5NEXQ3/BYOnLCF3oOvSfr3c5ghf2kg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RkqPrYwMxIanAEWhIo5sjRm6kUNjID2+2UPXJOTd10jOwbVp32P4gUjep+7bCF1SlzBLW/bSA03/UzSlZoqKHN916b1qvanS9Aa1dJ0oOCloFTr32OdvopVX8OwawmrPmqHVQUabwEopQDfLr0x0cbA1K5ouKzVM7BlWfDl38T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jr/NGEcx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707943902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=35ZMXeTIQeylZcW1wM9+9plqACKjwEbwbzGYTEq1zVs=;
	b=Jr/NGEcx/49mxQxTBr8ipp0SvTq/dWFOnd9InV8LlIW/cbg2ksui7InQsXiyulj6T//gR7
	MfXIRhqS2aeR1kgodTStpYV9dGbvdhuZKB4vKcmli1G6I0ta9U/dzcqj4VmPIJwAB1ikA0
	ODnlM0lt7nRr9mLaSQzGqRsALhR8MCc=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-Mn54ywyCMACW4_iYXS2FOg-1; Wed, 14 Feb 2024 15:51:40 -0500
X-MC-Unique: Mn54ywyCMACW4_iYXS2FOg-1
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-607aa761658so139127b3.1
        for <linux-nfs@vger.kernel.org>; Wed, 14 Feb 2024 12:51:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707943900; x=1708548700;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=35ZMXeTIQeylZcW1wM9+9plqACKjwEbwbzGYTEq1zVs=;
        b=YdxL5ycPGvg2yEuo0geHmZFl0LvPMH2iG/0PgVOU7o9lrPDShfvtcN0Ch+TvvsASek
         t2+9BNxEkVfhtgoTjyv/t+38Si4OrTLN3xL0DoMsyAjSxLv7ds+z7BcUQSeaQWl8qA6V
         WGbDs3L/Lv4qIeDbCcYVOCyMQdAlsxOiFXP12yOSwjFHUDQ43ixiyh4T4TmTnK++ecm/
         rJ1MWonZy+rmXmCTqNQ0X/o+MEQKJKl09jfGsLUr5FP2G8Jg8+0reWXDKqMCyB1IpnHt
         QQsPv0+wp7yIL9eN1PrAIqutek7/JdKlSTJr7SEedvJPZlHxNpssSkemYXHgQvLgWWYC
         2bkA==
X-Forwarded-Encrypted: i=1; AJvYcCU4ANvMkHxF3vVP3KwsV5peAYbK6nCtGUsNomEcZfJPNaEgXH/5lOzcsmV1xmyjQJahpDGVKSTXT7inMaFrdDQ8Fzadpr6cUHVG
X-Gm-Message-State: AOJu0YwK9bbnwsi3yZ66ru7G1tAuKTeKRubUCmnYChm8FmFc3OWAgLPK
	WBB3dNHfxgCwKwZ+5mEmTZBb6QY5n5FUjkoX9tF8s9ENkc3Z/YW6fvA+ZpXzqvkP0oY9WjGsVoi
	Zx/FICbBGoiYR0ceXQQEY1NfYNPfMvCUZyKrH6X5QoytYg9KP04GM1k4HKw==
X-Received: by 2002:a25:ab31:0:b0:dcc:8617:d6da with SMTP id u46-20020a25ab31000000b00dcc8617d6damr2941262ybi.4.1707943900104;
        Wed, 14 Feb 2024 12:51:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE33aVn++VZCa65/kbV2WqDWu9lrQZeQ6WWZDhfXjCM4yLWB08I81y5HymwUVZ9wXzqXMQA5g==
X-Received: by 2002:a25:ab31:0:b0:dcc:8617:d6da with SMTP id u46-20020a25ab31000000b00dcc8617d6damr2941243ybi.4.1707943899732;
        Wed, 14 Feb 2024 12:51:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXKLqxXbrNxmfdTCGNcR28q1ofBLyfwROKdzjjO82sKcACjYVCYyyIOKyX0xMHIegqaFuW9rLSLTx3t2UGTbGne1p585GrzSjxJ
Received: from [172.31.1.12] ([70.105.242.203])
        by smtp.gmail.com with ESMTPSA id da52-20020a05620a363400b007853f736893sm4093837qkb.5.2024.02.14.12.51.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 12:51:39 -0800 (PST)
Message-ID: <a5b00b22-c10d-4dec-9cca-cba03d0e8250@redhat.com>
Date: Wed, 14 Feb 2024 15:51:38 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfs(5): Document the max value "timeo=" mount option
Content-Language: en-US
To: "Hanxiao Chen (Fujitsu)" <chenhx.fnst@fujitsu.com>,
 "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
References: <20240204101821.958-1-chenhx.fnst@fujitsu.com>
 <TYWPR01MB12085FB8AC5E6702F0BD22992E6452@TYWPR01MB12085.jpnprd01.prod.outlook.com>
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <TYWPR01MB12085FB8AC5E6702F0BD22992E6452@TYWPR01MB12085.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2/7/24 7:30 AM, Hanxiao Chen (Fujitsu) wrote:
> 
> 
>> -----邮件原件-----
>> 发件人: Chen Hanxiao <chenhx.fnst@fujitsu.com>
>> 发送时间: 2024年2月4日 18:18
>> 收件人: linux-nfs@vger.kernel.org
>> 主题: [PATCH] nfs(5): Document the max value "timeo=" mount option
>>
>> Signed-off-by: Chen Hanxiao <chenhx.fnst@fujitsu.com>
>> ---
>>   utils/mount/nfs.man | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/utils/mount/nfs.man b/utils/mount/nfs.man
>> index 7103d28e..233a7177 100644
>> --- a/utils/mount/nfs.man
>> +++ b/utils/mount/nfs.man
>> @@ -186,6 +186,10 @@ infrequently used request types are retried after 1.1
>> seconds.
>>   After each retransmission, the NFS client doubles the timeout for
>>   that request,
>>   up to a maximum timeout length of 60 seconds.
>> +.IP
>> +Any timeo value greater than default value will be set to the default value.
>> +For TCP and RDMA, default value is 600 (60 seconds).
>> +For UDP, default value is 60 (6 seconds).
>>   .TP 1.5i
>>   .BI retrans= n
>>   The number of times the NFS client retries a request before
>> --
> 
> Ping?
Thanks for the ping... the darn day job got in the way... again!! :-)

steved.

> 
> Regards,
> - Chen
> 


