Return-Path: <linux-nfs+bounces-6360-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D4CC9725BA
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Sep 2024 01:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00816B22A77
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Sep 2024 23:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2571117C992;
	Mon,  9 Sep 2024 23:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RCLwLP5V"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44F6130495
	for <linux-nfs@vger.kernel.org>; Mon,  9 Sep 2024 23:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725924228; cv=none; b=dQrR05BwJOH1MW2pFtx6i7vZQMmAmYMxtqMEAx7LlL65NzBezWsefCQQGeVBPE5MTq8M8GVzYBxXSxR03UAPnpNSrt4WPa9ZZwg9AVTPFMSObCCoCfBGtaqMaob/6u8coScezjdEKF3exW6YG3U2CwjBjTrde6mxLLD9diOyu9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725924228; c=relaxed/simple;
	bh=yp7ZP8Qossp5/zgS4gvU6mJSOdzez31J2ebAAJXHwbQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dQSc6IZ+dF3mp2k2zTpFa99+AQkb9Wzn8vhb4oiAaOYkhoAsJxo/EGLe+3rvSeoeofc2lqNNBz/41L6I5KscrfuzSo+dfUhfkWJ4xtWr32JXxFn1QSPDXRS9/ckZcdKDrJY0CxqCbdIS4HMUDWseC0GDM6kJ9iG2phSkh7QTQik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RCLwLP5V; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5e1b5b617b8so1379216eaf.0
        for <linux-nfs@vger.kernel.org>; Mon, 09 Sep 2024 16:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725924226; x=1726529026; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GpFNtQIz2+1Ycr0ii8t84GMaL2qbjTXeUNgZeW7Tt9s=;
        b=RCLwLP5V5qpCT7xzU1//PA2S5KXJQPpqcalfee61dQeEHCyZk+4vwRBDXsXt9TotoE
         4ToCZO0ORMllgWOwy8qd/J7Jdwoz8nEJGtAHr/VedX21SsAzrcLpMWMGChfcVzL4uFtp
         ELR2/8qqxGby+nTm628nO7V8d7e2e2xOWt3bLPzJNBYpNOG+rv74o2C+mUOspditF0Cv
         3YFeFBPBWnfoqgKDQ3aVTWFZqPf2rzTtOc3ssvOLIkdrZg/smn648GS/1wNP9+Kibk6P
         ixdVWkpzaIXdIiXIrLdPYlPqDqqjYU68sFyF27NMDj5iSTJ11tMFDONOgVWNlOCmav+k
         Ol6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725924226; x=1726529026;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GpFNtQIz2+1Ycr0ii8t84GMaL2qbjTXeUNgZeW7Tt9s=;
        b=VOjhTmlqQmA/Kv0M6+7Rb2AOP/+YbcsW/u/jB51i1Jjfja2ClUru8jXlIw2HQDsEg8
         Z0WXGrOH9oSEFuJDV8Yphrq9i3R2H8Rlq288nFQoQUXPf3mInfGUz6v1IxN3VKb7s0mi
         hbVvvlonmQSxndc/NvK+FRY5WKFfV4OBKrnJOTCtOnEf1ohCpGfreVPFUcCkD9dTG/NC
         yfXJuj/NhrmDKs4SgVsI18obdn2Vx7cnTRnWAUcpTp6jlsBZc6bxwunPCIPg6I+erhjG
         gNzUZN39G3CrU3yTR4DZEKEtGZeuKaFcad6gDycedQYQfOD+ZRLLt3MK8f3ACdDoVBXn
         t2cg==
X-Forwarded-Encrypted: i=1; AJvYcCVb08jfYN9XAz0DGwhj+aTzXq979rRCoJRcamW4wj/e6lkBQNdxopew4S3I/uRGKgEzJEXsxO/bqyk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvjMn/Zkqo77Jb/RfVeViyTsGnNFCZKupWAw471EWGe8vwwSYl
	ueE518nLi8AvDqn8nbyzNwWHdDVA4EwHe84CdkcvZabbMpVQjDlA
X-Google-Smtp-Source: AGHT+IGPKdUyTb7U/b7msVwfG+FZOcCp3kmb5eVndFp0UM6QpzZYsmpe66jCYZb3e72SXGXlkAaegw==
X-Received: by 2002:a05:6820:1c9b:b0:5dc:99d3:d3bc with SMTP id 006d021491bc7-5e1e3c20b93mr572181eaf.3.1725924225531;
        Mon, 09 Sep 2024 16:23:45 -0700 (PDT)
Received: from ?IPV6:2620:1f7:948:3000::e41? ([2620:1f7:948:3000::e41])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5e1bf100a4bsm1385367eaf.4.2024.09.09.16.23.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2024 16:23:45 -0700 (PDT)
Message-ID: <b717d82f-7eb4-475b-bd7b-e376172a2b42@gmail.com>
Date: Mon, 9 Sep 2024 16:23:43 -0700
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: NFS client to pNFS DS
Content-Language: en-US
To: "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>,
 Olga Kornievskaia <aglo@umich.edu>
Cc: Anna Schumaker <schumaker.anna@gmail.com>, linux-nfs@vger.kernel.org,
 Trond Myklebust <trondmy@hammerspace.com>
References: <CAN-5tyHXg8=Sv8MS7vJUwG+=Av8oL6Bk_ZDDfwjEf3-R0KT=dg@mail.gmail.com>
 <685478263.45656552.1723405271880.JavaMail.zimbra@z-mbx-2>
From: marc eshel <eshel.marc@gmail.com>
In-Reply-To: <685478263.45656552.1723405271880.JavaMail.zimbra@z-mbx-2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Can someone explain why the NFS client is reading 1M followed by 2 reads 
of 1/2M and repeats this pattern. For pNFS or NFS4.

The mount was for 4M rsize=4194304.

Thanks, Marc.


