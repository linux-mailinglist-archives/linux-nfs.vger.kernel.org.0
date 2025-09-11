Return-Path: <linux-nfs+bounces-14279-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F34CB53063
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Sep 2025 13:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A0BF3A8FA8
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Sep 2025 11:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D96158874;
	Thu, 11 Sep 2025 11:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XOdy/wxW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2145316905
	for <linux-nfs@vger.kernel.org>; Thu, 11 Sep 2025 11:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757590099; cv=none; b=Ft84ZlTR4/Lze1kgwUwZrtJ6ub/0IsMJp8sHvpzoyq0gtMDkgv5HNfAXHPUP36V3yVKcFIeM4TaQiHcsShXpv99IC6nY7WnBQX0VQ2SeoSBGjdPwVUUSbSeGSechxKA5uC3pyoXCVi4LKZbDKpd9c4sDoiYECJAjpYYD5D3+wFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757590099; c=relaxed/simple;
	bh=BeqIWipaJTeHP3eW7XwzfXIVZY3iIIXy7DaffO7ej2Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Q5hrcmmDQgTuMUXKlAniGEz7eRUNyRlbbcDe3/faQ7cnSqofPabGqX+WqtS0/OoGUR0FRNNJA6mYH2S7mykf8Z61dToCL9PPaDf0O5Hbm9U4RkEGRpWI5JDUvRPNEFJdYHH6ZSr0/wUwekhMmWM/rDCUWpTfGrFnwGUd7yfAaZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XOdy/wxW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757590096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yM3AEDGpxrJZLnGdZst+gbZ0QqSy+LttNAOFymrKymA=;
	b=XOdy/wxWiI4TxD0BsuVyI3fLN8ggIEVRsm/K8UStZWqCsHeaB8FzYOxxMt2bDGJ7V7hNOk
	3eHpWKkGwHBWuQxxzKjnPHM5cnUNbmTrhc2/P1uBD+0y1CaG8SjMzcMbN+P0qObJzM2ant
	jgrteppkp13Ats+b2arKjDMenutcvXk=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-iVxjZVsWN-GL0UNqYodWhQ-1; Thu, 11 Sep 2025 07:28:15 -0400
X-MC-Unique: iVxjZVsWN-GL0UNqYodWhQ-1
X-Mimecast-MFC-AGG-ID: iVxjZVsWN-GL0UNqYodWhQ_1757590095
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b5f31ef7dfso31156901cf.1
        for <linux-nfs@vger.kernel.org>; Thu, 11 Sep 2025 04:28:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757590095; x=1758194895;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yM3AEDGpxrJZLnGdZst+gbZ0QqSy+LttNAOFymrKymA=;
        b=N/PVd39TOo2u5dh4NkyecvrnNsDzk4zTwxvtdRaiOjUHYl0nwY17mY4L3VEAd8xJAo
         35bsLLpKIZAb0Q4EB6ir2gkWS83nRbmr8htJbPyLJjqVMFT9xKT4jP2iS6rwNh0XNvD/
         MLi3/a0cIQvCUmt8uNKPO9X4nqR+3pa4B6Flvn5fI4lZF9kLeMDpGSsECzvqCqeZIKeG
         EZFVFoELKriCrJkMPcesG6r1G8qDlzF4loeoZfP+h+fXpKgH4nvcXn2Kiga2y25iJN5N
         skBP7cP9a+XSnjgl0aOBUm75UqWup+twsCaQmEAJODI7sn0pYLby5/fPEM8DgNZShe8N
         7N+g==
X-Forwarded-Encrypted: i=1; AJvYcCV2dxqUIC0NLa8wns0RuumXSCMwS805e66X2LXLNu/ar3WticYjcBtBKNlE0dO+tpYnRFe5mylwDKM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr7UaCHyHsV30gygrPpfT2PY1M+R/x4fPTKAZkcRr1Ui3n5z0J
	6klgkACM3PnnyJ7LeqpMg0WeKrD3M/BhuhzEYWHUf95OA/NwueO3ttSQfhXSRtjgsm3tW1HBEjC
	MBAQ1xs96ZWGmO1xCy6UTfcyYDY+sysikxnnIY/xxTHpBEKeQKIIlckcwxqM7uw==
X-Gm-Gg: ASbGncuaD37bMkQdQwI+6GWCrPk0rJuowjfC9wuniluFEuaHNsxV+flZ89EAIwtus6N
	2HDzrzJxu7P8vrukG+UwqR35mscemIUPpRbHkAo1uJNUMw2h3YZGoJxOgAL9sy469xb+TK4ZMMm
	0INOF76TnZMjf+BdXKHo7LP7PoywyPaRZR/1q+hpu57N0y/70R+BPPjGdcwLfcofuExVINsOAdT
	E0FQx915DfZ1EU0CQfc2/9rjXSadg9D/LQniXlQQBuw9siiP0r0K0FvI81bSOgcmikiWzsw9gWt
	VwZOMHjPaTrmV/3DyO2KHwcrolfMFf1Y3/HwoDNvBSAqmFYVhiuubJEvn6ajAFOxIsBk2H4xVk0
	QGiQ1Y5smLPk5
X-Received: by 2002:a05:622a:5c99:b0:4b3:4077:6875 with SMTP id d75a77b69052e-4b6347c1088mr36715031cf.25.1757590094788;
        Thu, 11 Sep 2025 04:28:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFC0iEyRUypMPnx/+BUIWHFlihmJVHTdLjhmdkfYirhqEaB5GZID4r+mf+FTYm43EROhPKhuQ==
X-Received: by 2002:a05:622a:5c99:b0:4b3:4077:6875 with SMTP id d75a77b69052e-4b6347c1088mr36714781cf.25.1757590094387;
        Thu, 11 Sep 2025 04:28:14 -0700 (PDT)
Received: from ?IPV6:2603:6000:d605:db00:e99e:d1e3:b6a2:36ac? ([2603:6000:d605:db00:e99e:d1e3:b6a2:36ac])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b639b99de1sm8563631cf.8.2025.09.11.04.28.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 04:28:12 -0700 (PDT)
Message-ID: <f7a895c5-228e-459a-8777-d7027df6bcd1@redhat.com>
Date: Thu, 11 Sep 2025 07:28:11 -0400
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
Committed... (tag: nfs-utils-2-8-4-rc4)

steved.
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


