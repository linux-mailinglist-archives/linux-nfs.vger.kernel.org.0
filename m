Return-Path: <linux-nfs+bounces-13713-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E3BB2A2DD
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Aug 2025 15:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E2517B1CE8
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Aug 2025 13:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B25D20126A;
	Mon, 18 Aug 2025 13:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IaK3jF5E"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B952A286D5E
	for <linux-nfs@vger.kernel.org>; Mon, 18 Aug 2025 13:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755522208; cv=none; b=XJRQLTQnsz0b5q5Vt0uCM/g8+EuAWkWlTpjORagiC6EPOIQlMXcELAOmI4VQnKPyjfBVLn8+vwW5rf83EmQALebXgman4J3H1CpWrxcBPsP9RSV58p5FWSW3f7OStRDasIB8fk3s4thxGh7CCHDAJhXKI6Ua3rRqfsp037lhHgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755522208; c=relaxed/simple;
	bh=Ej7JgTieX1OCKCn0e3afWAhpQtqP3rCbmP0uNGrCqto=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=eeiui07mEH04uttullhKUfAVRXSW1pgT6g5laRAENx/2qAJwNbBANJMW03gc3cxCvdVPEachfTmaGgyxQBS1ansFoAlp1g8nhZeKmdzTafBb/WuvwVSGPaWdkq9jVU3ARqfKCpEZngnmfmCd4g2k/CFrdeDNXysidLU33dEwPWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IaK3jF5E; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755522205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B//pI9Q8pb4i6ncp1AYGqMVbejjIAMFDt5XUv00mB3I=;
	b=IaK3jF5EGa9ACj1QnBNy2IGzdIb02KNzr+nrhspoHO1xoWD1nALqU7xZBFU/bAy5mWw0Jb
	fvzIyB3O4wXJnjmGz2wN3VrF4wXx3aH7MuCcaIryGKyUNwxTkeQPPT2ujlQkP+cML4QKg8
	seIhvn0fWAM0oRyQbUOfgLYF8zKG8Zo=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-q_Z4w-5OMdGRQczAynNhKQ-1; Mon, 18 Aug 2025 09:03:24 -0400
X-MC-Unique: q_Z4w-5OMdGRQczAynNhKQ-1
X-Mimecast-MFC-AGG-ID: q_Z4w-5OMdGRQczAynNhKQ_1755522203
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7e870662c1dso1170542385a.2
        for <linux-nfs@vger.kernel.org>; Mon, 18 Aug 2025 06:03:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755522203; x=1756127003;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B//pI9Q8pb4i6ncp1AYGqMVbejjIAMFDt5XUv00mB3I=;
        b=XJDDGkuRjl8mfvtKv0zmzlsUvD+/qURsleWSk26KMVjiiUoAlpqnRmpLE4B3KQoLR+
         JJUYgG42KWBdDJNg/J3KO4TN3ZNJW88BXjA8gfN1NdfkAZp2tFPqXwh8XeW2fn60iEV6
         WdiCVkT57s/yWuP3ZhxsPrtBk0SDn1pZBg2f3VKEiKIU2QPsdBJLTOda3MRO6iGwVBUW
         7SeL7wKJhv1waJUFcSteK21YslqM+f13rMV+fWJcnl+i3erAC+PR+UaVEaNpzTy64MOL
         Y9cqhUwomf9Ib7t8Zcr7vvCjIstMaX3GLcPXvQArtV9OF3rgZgzd57QUU7i/beiMLLD+
         /reA==
X-Forwarded-Encrypted: i=1; AJvYcCWIm0xHaj1COT3ZMjAyerlhQ8R1QDxAFHawBcvqcyzckkIc7BOE9tF1PETv5xkW7KDJOwWA7NznOk4=@vger.kernel.org
X-Gm-Message-State: AOJu0YysEctaWaXkufL2iRxEl61jfPfQWLbA0nwqETX0jOzL+IJNnCE9
	pKhhqaHgR1cR+Px8miNaUVE3v3QEQl88RwM0kFIOWUZVIADkS+qhz9ca2hsENZP3o6SCpspYxZ9
	GWWtxXD5rM9rPRc4282NMnbNBj88xXsJal7wsdAUhpGZKahHadirV2QOi/fTXJ7BcCoO4Vg==
X-Gm-Gg: ASbGncszFr8buXsZZOWQvW4KP9D6OfqW6P6fy0LMTY6Kme5gw0jNMi0O/vUtNXL0+pc
	Se1TcvbKHV2wZ2cxi4CjkBAuK2voby0PygX17SbQ7uY9dBnik7wZiEuGroU2yrev1Tnr5SlVvKg
	FevMn5Iupb1K0DTCNoPF/wAqhlb1XfN9fEi7Hs8Szk3T6WpbtMUPcDuKoCnQzMCGrvm0HyHTJ0y
	bp0aVInA1KA0f2EdZQSpb5DngR1WXGbnPsGXGBhx7drrMyVpvEzuqTSMNTsxfPDg7w3kYJTS5OL
	P/ZNxLh1yWShWXvbHbGSOHe6FpjTPyRPnQLsgPUW
X-Received: by 2002:a05:620a:4043:b0:7e6:2f6a:5bae with SMTP id af79cd13be357-7e87e137b50mr1789670385a.62.1755522202959;
        Mon, 18 Aug 2025 06:03:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEOKFSISYRg850dWZQuUnbeRAfjECkVi61pA408ZUJRpRrieYgc8/gWwOkt+aLjHq/aj+/cdA==
X-Received: by 2002:a05:620a:4043:b0:7e6:2f6a:5bae with SMTP id af79cd13be357-7e87e137b50mr1789666085a.62.1755522202313;
        Mon, 18 Aug 2025 06:03:22 -0700 (PDT)
Received: from [172.31.1.136] ([70.105.250.115])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e87e06a389sm583725885a.27.2025.08.18.06.03.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 06:03:21 -0700 (PDT)
Message-ID: <7e8be3e3-f766-4120-8c8f-6ad5b715dcc8@redhat.com>
Date: Mon, 18 Aug 2025 09:03:20 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfsrahead: modify get_device_info logic
To: tbecker@redhat.com, linux-nfs@vger.kernel.org
References: <20250812213822.403844-1-tbecker@redhat.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20250812213822.403844-1-tbecker@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

On 8/12/25 5:38 PM, tbecker@redhat.com wrote:
> From: Thiago Becker <tbecker@redhat.com>
> 
> There are a few reports of failures by nfsrahead to set the read ahead
> when the nfs mount information is not available when the udev event
> fires. This was alleviated by retrying to read mountinfo multiple times,
> but some cases where still failing to find the device information. To
> further alleviate this issue, this patch adds a 50ms delay between
> attempts. To not incur into unecessary delays, the logic in
> get_device_info is reworked.
> 
> While we are in this, remove a second loop of reptitions of
> get_device_info.
> 
> Signed-off-by: Thiago Becker <tbecker@redhat.com>
> ---
>   tools/nfsrahead/main.c | 14 ++++++--------
>   1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/nfsrahead/main.c b/tools/nfsrahead/main.c
> index 8a11cf1a..b7b889ff 100644
> --- a/tools/nfsrahead/main.c
> +++ b/tools/nfsrahead/main.c
> @@ -117,9 +117,11 @@ out_free_device_info:
>   
>   static int get_device_info(const char *device_number, struct device_info *device_info)
>   {
> -	int ret = ENOENT;
> -	for (int retry_count = 0; retry_count < 10 && ret != 0; retry_count++)
> +	int ret = get_mountinfo(device_number, device_info, MOUNTINFO_PATH);
> +	for (int retry_count = 0; retry_count < 5 && ret != 0; retry_count++) {
> +		usleep(50000);
>   		ret = get_mountinfo(device_number, device_info, MOUNTINFO_PATH);
> +	}
get_mountinfo() will error out with an errno value (ret != 0) so
how is how are error detected? What am I missing...

Also why was a value of 50000 used to sleep?

steved.

>   
>   	return ret;
>   }
> @@ -135,7 +137,7 @@ static int conf_get_readahead(const char *kind) {
>   
>   int main(int argc, char **argv)
>   {
> -	int ret = 0, retry, opt;
> +	int ret = 0, opt;
>   	struct device_info device;
>   	unsigned int readahead = 128, log_level, log_stderr = 0;
>   
> @@ -163,11 +165,7 @@ int main(int argc, char **argv)
>   	if ((argc - optind) != 1)
>   		xlog_err("expected the device number of a BDI; is udev ok?");
>   
> -	for (retry = 0; retry <= 10; retry++ )
> -		if ((ret = get_device_info(argv[optind], &device)) == 0)
> -			break;
> -
> -	if (ret != 0 || device.fstype == NULL) {
> +	if ((ret = get_device_info(argv[optind], &device)) != 0 || device.fstype == NULL) {
>   		xlog(D_GENERAL, "unable to find device %s\n", argv[optind]);
>   		goto out;
>   	}


