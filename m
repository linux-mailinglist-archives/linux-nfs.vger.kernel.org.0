Return-Path: <linux-nfs+bounces-17722-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 282CDD0D3DA
	for <lists+linux-nfs@lfdr.de>; Sat, 10 Jan 2026 10:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4252F3013ECC
	for <lists+linux-nfs@lfdr.de>; Sat, 10 Jan 2026 09:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8DE1A5BB4;
	Sat, 10 Jan 2026 09:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WDmXR6Vt";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="MkFMohqi"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5564950097C
	for <linux-nfs@vger.kernel.org>; Sat, 10 Jan 2026 09:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768036826; cv=none; b=JniZKchDsEBqPW4CU5oEgFnPR2xYAQkM5WJowRgFYOm1bb4CQxn/iuKf8ell+ELokz4nc+sV6jQJL7mGys9RFult8Rt0mkNBvs6GD0qWzrZrNytB5oUFUxAxXwvlT+6uPcsq2yM3Uos8cav6XVcsakkEaSsszFuepzWokW7MC7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768036826; c=relaxed/simple;
	bh=xXH8lEb+Ca5HUsTNPR+fNA0rcbqpdx0LKOruCqMOCPA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=azvPf1YlZVR2SdmGG4I6OZP6/p6M2vdwzblEQIAyslZWmlpP29hkRW/QOqppoYcUepRki3ZTybv2pSPha1NcWoTaL8pd7V26YMrxB/gJK6pLxXwPfEZ2RlG/O/o+UEkFLj0heH9NPTNYYzGvLvZhuftliE+pkrrWgab2oAo3MWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WDmXR6Vt; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MkFMohqi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768036824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vm8E5bPinOAt84jeeiC4Dw54UlBaLugWpv17FVubOto=;
	b=WDmXR6Vtr8lcyU8AZ2rkiCZucCsoXgl2Q+48wCH2VTRgZ307Fi9Z1Df64R/gUUkTATqcYA
	EWEOhW4bdA6QIz3qf1HfAVwOMjb/i9NEptEGRZ1je5O+a3YgEJcmLc9mMRWM5JR6vn/BO7
	i9SPEeEU7D1OkhrKnNRoOVO7vB2gfrg=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-y10MlszHMBKqWXJMcMKgHA-1; Sat, 10 Jan 2026 04:20:22 -0500
X-MC-Unique: y10MlszHMBKqWXJMcMKgHA-1
X-Mimecast-MFC-AGG-ID: y10MlszHMBKqWXJMcMKgHA_1768036822
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-93f550cdb2dso7111364241.1
        for <linux-nfs@vger.kernel.org>; Sat, 10 Jan 2026 01:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768036822; x=1768641622; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vm8E5bPinOAt84jeeiC4Dw54UlBaLugWpv17FVubOto=;
        b=MkFMohqiKnAhox0J418tI5pVuqnf+YOiIuamGer+2efLS1Ex52sPhD/MVMpc/3YeeH
         ECaDZca+5pMYXd/IEw4C3Lvwai0Zhps7kwWk2p+cBt8d2Hiu+7tJ3MhpcirvCz8wrimS
         ffM8hFkoG7F817UFV1KfEYyFwStDocfc86UVw+AQ8aE0pQfpxKkQj8TpApWiMbb32Vkm
         sND3F43MlIYEObroBty+v7TSmdSEyBrJmttTrlf4XCUc7R5Tqy50agq0grTQVEH277oB
         6IvVKqC67OaYY5v5cVCqKoFeUzHbNVeULNQM5DkmqUhxLufdf4Mdpt1hh+l7cdc87HPC
         IOqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768036822; x=1768641622;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vm8E5bPinOAt84jeeiC4Dw54UlBaLugWpv17FVubOto=;
        b=F6OoIUe2bZ3ofXRjo4E7fXwu3aq/2eBW8d+CvVz9SfbHiUa/LMRRQ19qustv2xReoN
         KX+ZY0oK9AGjCwtwrwnJIRYMxQxAbag46vlI9NkRE/DjZUy9uG4zeoR6V4m2tF3g5170
         MKbVFcWK9s1J1HxmZWa0guxQfEs1IdCJyosd/Dm6C8ACQpGqRiM0W9SMdhTD+ZJVxYV+
         Aq0f4nlBAivtrf6XkJl8HH1rX59V9v/EkK63EsADw9o32lxrK26m1s4kkHnTzGMHMs3W
         4DaOL5y7BcKtUUrm0a70snKztq7vxe+oUatfv/kc4FUTFJi7/aRXnFZtQ28+hR9Iy/yn
         iXJw==
X-Gm-Message-State: AOJu0Yw2lBy6oAFLOuxda5OSL5RQoecBZm54hIJ7RINug1vQX/JrKpOp
	pQBNLBBW75fKW9jJR7Wt4/O2ZM7s1MNpizqi6/f0InwpeBNO0pmgOJozUyDz0eyU/srljsKThZ5
	3KrwgUb9cotEvDrhDb9Qzi+yw8yx4hk1Vg4zE35uzk0QItICKtHEgwf315SqfeJOlAr72Dw==
X-Gm-Gg: AY/fxX5cnxki4yGmValsVxgq6WNkQUq60uX4KSTC+JYOpZI+OOg80Tg6qwWojVRLvIQ
	hGAMCJSUjspUmgVeDw+mtLply0WMYr/NFjd6mBwjHuCl5TeDoqokO+CaObYjAXeKIPKPyaRPEYO
	W350NtOfnXwW/NBABdAuIDlDYBlxFW3VCnb8BJ/W/5N1XfwmeOtAhoVTpaaFOQ26BBHa31JIrw5
	zjoRqc9kMH4PRiPb62h2cz1oLCpZCWxF59TIHFuvbv5lBzUVbFBSADxLB7fiEYLoREINzrCWNtJ
	DX9PPKxJZLwJNMUEpods2vkadYi7u8BcUWMjfUR+CLSGnH+/jyoBP7rojBDyWJRWKGxSSJ7yf0O
	uj22ayP0w
X-Received: by 2002:a05:6122:2210:b0:55e:76ed:e6c with SMTP id 71dfb90a1353d-56347d4b3cemr4448089e0c.7.1768036821695;
        Sat, 10 Jan 2026 01:20:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFTY6Eg9ULxNdB5FlGoQv0gw+S+QzrH0RCwY+Q7kS6daBhcXkCuqg4oPZSPZwVp8+g9rB7kUQ==
X-Received: by 2002:a05:6122:2210:b0:55e:76ed:e6c with SMTP id 71dfb90a1353d-56347d4b3cemr4448087e0c.7.1768036821375;
        Sat, 10 Jan 2026 01:20:21 -0800 (PST)
Received: from [172.31.1.12] ([70.105.242.59])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5634e959afbsm9429181e0c.1.2026.01.10.01.20.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Jan 2026 01:20:20 -0800 (PST)
Message-ID: <46742bfa-767b-470d-a123-893f8c574b2e@redhat.com>
Date: Sat, 10 Jan 2026 04:20:16 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] nfsd/nfsdctl: default to starting with v4.0 servers
 disabled
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org
References: <20251008-master-v1-0-c879be4973c8@kernel.org>
 <d71e37c054c51428f34a51b6a980a62bc07a68e7.camel@kernel.org>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <d71e37c054c51428f34a51b6a980a62bc07a68e7.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/9/26 2:04 PM, Jeff Layton wrote:
> On Wed, 2025-10-08 at 16:13 -0400, Jeff Layton wrote:
>> At this week's NFS Bakeathon, we had a discussion around deprecating the
>> NFSv4.0 protocol. To prepare for that eventuality, make the NFS server
>> only accept NFSv4.0 if it was explicitly requested in the config file or
>> in command-line options.
>>
>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>> ---
>> Jeff Layton (2):
>>        nfsd: disable v4.0 by default
>>        nfsdctl: disable v4.0 by default
>>
>>   utils/nfsd/nfsd.c       | 5 +++--
>>   utils/nfsdctl/nfsdctl.c | 2 +-
>>   2 files changed, 4 insertions(+), 3 deletions(-)
>> ---
>> base-commit: 612e407c46b848932c32be00b835a7b5317e3d08
>> change-id: 20251008-master-724587cca99a
>>
>> Best regards,
> 
> Steved, ping?
Working on it...

steved.

> 
> Also, if anyone else wants to send an Acked-by for this, I wouldn't
> complain.
> 
> Cheers,


