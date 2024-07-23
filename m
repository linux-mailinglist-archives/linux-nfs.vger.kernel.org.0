Return-Path: <linux-nfs+bounces-5021-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9378293A42C
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jul 2024 18:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B63951C22141
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jul 2024 16:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5103156F4D;
	Tue, 23 Jul 2024 16:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g0pjnCU/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D20B156F40
	for <linux-nfs@vger.kernel.org>; Tue, 23 Jul 2024 16:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721751006; cv=none; b=MNmTDsWkRBMh5MxMBF5eNs/KkaKHRqjoDBoTq09BWRF0rGgBXU14YfsOprDUnXNg8bnxto9gbSxpskSgo8UO4a3M3Knay+XVGYjtwXJahcem7XEtLiUTQ8WTq6ZBcNo4wrEQ+CKQw7dqvK4lU6/a99dOpvYo/aVOG+gI/uVV4VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721751006; c=relaxed/simple;
	bh=ZkkwEis/cSGo32NusDDGt9mxHFKfJRken03qRoL+h3s=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=pfDh7m2ncQ2viVRfT5M/QfJaoe78SV2jBIQ9l8U3Iv5rXwA4Fs8dGWOgFLyew8CHg/3J1yQWAhJiRohrkBOctGCe9dioY1DHm3fIp92sGk4V/CR76xS2yDpUEzh6S7mn8ZBYgB8KfupnRUs5P+9ziLwsOQ41ilPs97ORt7VOstE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g0pjnCU/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721751003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TSPTMBA7e1XZ1uweF5UCxPGFk2g4PaLAMmwiSryHLvk=;
	b=g0pjnCU/mxnKWcQcDwwvUS/1CCLsfNbAgjN8xUQC9UVsAUtXkBEsai0wnTyzQ+8ua1CijH
	XhVlh1nZ5U6qPHlRfdeGyZRMNXMcoD9yw0qatnf6yJLxnhP/7AMF33W+ydQQnR1Y6BzsdB
	6v//KHqa7pymivZEVeuTp/Hmi0w2NP8=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-KuT9yYKcM0KeMbBGoGWUXA-1; Tue, 23 Jul 2024 12:10:01 -0400
X-MC-Unique: KuT9yYKcM0KeMbBGoGWUXA-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-447e6ac9852so2744861cf.1
        for <linux-nfs@vger.kernel.org>; Tue, 23 Jul 2024 09:10:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721750999; x=1722355799;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TSPTMBA7e1XZ1uweF5UCxPGFk2g4PaLAMmwiSryHLvk=;
        b=i29FzNv/Ji9rSSTP4EeCDMAdj7e0Q876sXxsLxrMM7sUscsSw/vvhygOpRv5Q0cx9m
         MrhJDXdjBBybtUwOlDBPa9+amXnKNFWEJTZlQT/UQUlsOe0n0ssYSIa1O1O4zb6Rz+bs
         xAgudg3Z2a76OewkTlDwVPiyJyHIf6rymHf5sshBgwLMRs+YGs3tZSOlHgk3ONBX6gc9
         FyCnrq4IheAakrB97+w6oUBbkmIQC892N1nuMHqG3tvQpgi7MfAnPS9u4SXTCCuqzrOi
         DA8gzXVoU6BwTSLRkEzIvJzffxiO93PnHOhLScX2lK+8tD5B4k93QDjCZLAi4TAHLag1
         8Yww==
X-Gm-Message-State: AOJu0Yzp2rB92sRkOThElGOpgOHTFJlegz+fSnrY86d6BV5VkLgNqDUi
	woQP3HFAFOKUvxMHiqSGlgKbRfYHOOckGrBnHl0RLH6o7jSdZHpyVTsUEa/Q3ZtfONe3uGJ9Oru
	0T8RBp72VNOu0mJxU3SpjYoOnd0VhaI2pUEGRycDwqTOW0PNr6LvKbxxk3JHXxuY4QlJNZpF+35
	ICo4oiqOmOS3FOSpZkxjXeUWB2itNtf839wER56Nc=
X-Received: by 2002:a05:622a:198c:b0:447:f3d8:e394 with SMTP id d75a77b69052e-44fa523b6bdmr83600111cf.2.1721750999456;
        Tue, 23 Jul 2024 09:09:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzXeGIXniAg89UL2FzcqkYWijHz1unCsilw+i9d6086CXzIvu3IyrqdFXRfFFp5+wGr2qZpA==
X-Received: by 2002:a05:622a:198c:b0:447:f3d8:e394 with SMTP id d75a77b69052e-44fa523b6bdmr83599891cf.2.1721750998901;
        Tue, 23 Jul 2024 09:09:58 -0700 (PDT)
Received: from [10.193.21.13] ([66.187.232.65])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44f9cd04bb6sm46098821cf.35.2024.07.23.09.09.58
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 09:09:58 -0700 (PDT)
Message-ID: <ca3fafa4-2e80-44ec-ad25-f9bd3afe367b@redhat.com>
Date: Tue, 23 Jul 2024 12:09:57 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rpc-gssd.service has status failed (due to rpc.gssd
 segfault).
From: Steve Dickson <steved@redhat.com>
To: Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <20240722091638.53546-1-steved@redhat.com>
Content-Language: en-US
In-Reply-To: <20240722091638.53546-1-steved@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/22/24 5:16 AM, Steve Dickson wrote:
> From: Paulo Andrade <pandrade@redhat.com>
> 
> Ensure strings are not NULL before doing a strdup() in error path.
> 
> Fixes: https://issues.redhat.com/browse/RHEL-43286
> Signed-off-by: Steve Dickson <steved@redhat.com>
Committed...

steved.

> ---
>   utils/gssd/gssd.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/utils/gssd/gssd.c b/utils/gssd/gssd.c
> index d7a28225..01ce7d18 100644
> --- a/utils/gssd/gssd.c
> +++ b/utils/gssd/gssd.c
> @@ -365,12 +365,12 @@ gssd_read_service_info(int dirfd, struct clnt_info *clp)
>   
>   fail:
>   	printerr(0, "ERROR: failed to parse %s/info\n", clp->relpath);
> -	clp->upcall_address = strdup(address);
> -	clp->upcall_port = strdup(port);
> +	clp->upcall_address = address ? strdup(address) : NULL;
> +	clp->upcall_port = port ? strdup(port) : NULL;
>   	clp->upcall_program = program;
>   	clp->upcall_vers = version;
> -	clp->upcall_protoname = strdup(protoname);
> -	clp->upcall_service = strdup(service);
> +	clp->upcall_protoname = protoname ? strdup(protoname) : NULL;
> +	clp->upcall_service = service ? strdup(service) : NULL;
>   	free(servername);
>   	free(protoname);
>   	clp->servicename = NULL;


