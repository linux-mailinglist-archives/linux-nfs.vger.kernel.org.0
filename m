Return-Path: <linux-nfs+bounces-6383-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9695F9749F8
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Sep 2024 07:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C95FE1C23EF4
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Sep 2024 05:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E7C40862;
	Wed, 11 Sep 2024 05:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eD897J1k"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3B23BBC5
	for <linux-nfs@vger.kernel.org>; Wed, 11 Sep 2024 05:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726034087; cv=none; b=Rwpj4QNfO23H3g3bYFdQEhHW2fXjaqisdbjTxkGcRHjU4CxMrZsbE1Dp6sD93wKznOQJlESiBekFaPFt9X1M6RfDVUIMHspkhMSEWfRT6CV0nFFUsjI/Wu1gh6DLs4Uvsg4Kz/c6XajnByrkU/jQr72fetTr6x/e3jUqPA1DpGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726034087; c=relaxed/simple;
	bh=uPojNh2R915XWin0RCUnNC10rUaM42UXUW++K2LVKp0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jSEcd9yNhyGpqsC4yboG7HFvMdpiCi3pP1HEv/MTFIvYiVqUqufaCKygs67XIRu333Hw4vfn2qUyYnITAdOqgAz/KXM1UhnWIKn4Icq8h5mzwWPmTMGDLSASNja00QZwBOn9ZW5hDVFEovLW89bA+kPdwo+jgpOACHKSabkZSk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eD897J1k; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2059112f0a7so58334405ad.3
        for <linux-nfs@vger.kernel.org>; Tue, 10 Sep 2024 22:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726034084; x=1726638884; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AuJJDbpwRFdBsveD5+oz89oTVqHP9f23wNHM0Imudyc=;
        b=eD897J1kc8DVzdyQTG9JN4A34A7gjwuTxnkY9sKMvUHodCgcl+P6kHIBx2CJQLhADg
         UtgY3g4PqPV7W891wzxgbNZ+jy8AInw+/9SvZIUssKE41+3wLTlxMKFMY1S0jEiDs9MU
         4Fvh6HF0WPvanIFzayAQqd5Va44b9Of2hsSqoojvEgOotRgRxec9NKjZijHHDLRHkRC2
         avAHeQGbh/vFeWRyCdAWKWfhqBsXJCHW10/35J1CKXTAmODgbr30pXBmokEDz59tVtLK
         W9OlKGSU2mxoWrbmeW0gpkj4H91ncdW3xI1pdJ/jHhqK1fjx7UaUF1ltbVI4LuT66WH7
         QbYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726034084; x=1726638884;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AuJJDbpwRFdBsveD5+oz89oTVqHP9f23wNHM0Imudyc=;
        b=V4bYwEyacMc3ETcdY6/QHarnY8nQ26E084GjwWmZ6G6U35aakG9L6qPrkQ9XixK6ya
         gHirgUes9vkl0aXO58KYEQuE1fuO9XCx5Us+N5F6BhiaPU1HqUdu9vPTabNDvg6LLfAE
         ECCmy3kDqPFd/YjeaTdZALrHlzhqIhpd4qVYCKwEAz26J7AHCNO231MzqshHaqv8vSmk
         o8Y4leg+1qHFhsr3k4gyoMGj/PrUJOqgVpPpH5Gp6A2gakqTJ9Gkt8L/VOgTD7hyPwTW
         tMQaLV0we2Y6VlHAcJE+v9MMdAWMDgp/EBReAVyX8DUPMm0S/Lq9CjO1aRzVJ77Jh3R7
         getQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgf2TD0mqaZOFNI+h4NbVAl/IG5kGxPx3jOahVwNebpvxnnemmOpAh3c/3ZRiVNA6p7p5plThd8Hw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHhmmWhFZy7Z5fQ9JkGtWN1wrmsZauVVMN7anQKaqZzoH9a23J
	37NNZR264aU5emyj3jDJMJlO3ubur+lCEJf7UGDgXwx1+V1NT9F7
X-Google-Smtp-Source: AGHT+IEv/YkrMvGEwL6NTn68A/LBs3eWYaApPgRcQ2XZnxVAkHxk61zk0WgX1f/TlTA9l27iUIIHHg==
X-Received: by 2002:a17:90a:4d87:b0:2d8:94ae:8ae0 with SMTP id 98e67ed59e1d1-2dad4be6714mr18313572a91.0.1726034084126;
        Tue, 10 Sep 2024 22:54:44 -0700 (PDT)
Received: from [192.168.86.101] (syn-075-080-015-010.res.spectrum.com. [75.80.15.10])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2db041a02c7sm7569229a91.19.2024.09.10.22.54.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 22:54:43 -0700 (PDT)
Message-ID: <4c90da07-6de7-4158-ae8b-5eba1d39e367@gmail.com>
Date: Tue, 10 Sep 2024 22:54:42 -0700
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: NFS client to pNFS DS
To: "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
Cc: Olga Kornievskaia <aglo@umich.edu>,
 schumaker anna <schumaker.anna@gmail.com>,
 linux-nfs <linux-nfs@vger.kernel.org>,
 Trond Myklebust <trondmy@hammerspace.com>
References: <CAN-5tyHXg8=Sv8MS7vJUwG+=Av8oL6Bk_ZDDfwjEf3-R0KT=dg@mail.gmail.com>
 <685478263.45656552.1723405271880.JavaMail.zimbra@z-mbx-2>
 <b717d82f-7eb4-475b-bd7b-e376172a2b42@gmail.com>
 <2102290340.59910889.1725952999821.JavaMail.zimbra@desy.de>
Content-Language: en-US
From: Marc Eshel <eshel.marc@gmail.com>
In-Reply-To: <2102290340.59910889.1725952999821.JavaMail.zimbra@desy.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Tigran,

Thank you for the information, but still why there are more 512K reads 
than 1M, I see now about 5 reads of size 512K for every 1M read.

Marc.

On 9/10/24 12:23 AM, Mkrtchyan, Tigran wrote:
> Hi Marc,
>
> AFAIK, 1M is the max IO size that linux nfs client will use.
>
> linux/nfs_xdr.h:#define NFS_MAX_FILE_IO_SIZE    (1048576U)
>
> Best regards,
>     Tigran.
>
> ----- Original Message -----
>> From: "marc eshel" <eshel.marc@gmail.com>
>> To: "Tigran Mkrtchyan" <tigran.mkrtchyan@desy.de>, "Olga Kornievskaia" <aglo@umich.edu>
>> Cc: "schumaker anna" <schumaker.anna@gmail.com>, "linux-nfs" <linux-nfs@vger.kernel.org>, "Trond Myklebust"
>> <trondmy@hammerspace.com>
>> Sent: Tuesday, 10 September, 2024 01:23:43
>> Subject: Re: NFS client to pNFS DS
>> Can someone explain why the NFS client is reading 1M followed by 2 reads
>> of 1/2M and repeats this pattern. For pNFS or NFS4.
>>
>> The mount was for 4M rsize=4194304.
>>
>> Thanks, Marc.

