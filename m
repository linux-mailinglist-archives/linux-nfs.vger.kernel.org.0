Return-Path: <linux-nfs+bounces-10700-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36864A699BB
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Mar 2025 20:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D0157A2275
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Mar 2025 19:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE06F21480E;
	Wed, 19 Mar 2025 19:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y6Bs1ks1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD852054F0
	for <linux-nfs@vger.kernel.org>; Wed, 19 Mar 2025 19:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742413735; cv=none; b=A0pH2E0nTD1whWdMiAOBuFu8UM6kzR5v3Hqh95avJNjMn7/yq98y6HKUjEeM0E3XCT7/tVv79T/dNXgaA8elXFOfN7wMOzWspOiRFTHtVKIDwtasb6TTX6e/bYnjw4iEmzxcRh4YH1xSfn5XOXOcHlUvLZ0H7/mKH1DE6BmDOOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742413735; c=relaxed/simple;
	bh=/75bs7DAEhmlwb1wodFPZsSpUFXEyXJoHhudsbSfyy8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pRt6rdb34q/Ee68r2vgsJlnVVRpVb6zWlaQ0ngfSf5gyng/TIdy6ls3wF2lOqmCvwkQaDBXwZyGp0IfS5IZE7ljbqc5g6brwMjhf6M2HpJNg9b4yfqHeCdZtX8CCzItF98ckXGiBEPwkxjlQWbFpzqK6vlrvs1wPPVMH+0/ymi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y6Bs1ks1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742413733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vth92+ttxGL27cDr02GBYyvfGSP6RZsmiZk0ubvkumw=;
	b=Y6Bs1ks1eoZqf2YHkL73GKoqy9Dni+s29kldwvrSP0LIOCjHCGhahITiv7iE78HzEFjoQK
	hA2hBcHQdFaiMwAFqsQE0eSA+6mUS7Ga7GhZO6rEBmJ7mm8S2kwRC6+ANYT4pUWlCLVL0D
	Q40b8H/4SIQ2PyL6oAcZTnb5724mdVk=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-llJFteboOaiC81E-u75s0A-1; Wed, 19 Mar 2025 15:48:50 -0400
X-MC-Unique: llJFteboOaiC81E-u75s0A-1
X-Mimecast-MFC-AGG-ID: llJFteboOaiC81E-u75s0A_1742413730
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-85e15e32366so4393139f.2
        for <linux-nfs@vger.kernel.org>; Wed, 19 Mar 2025 12:48:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742413729; x=1743018529;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vth92+ttxGL27cDr02GBYyvfGSP6RZsmiZk0ubvkumw=;
        b=IzztCt+HDc/cab69LA2VrESMhkQ7I6s59yvpbPcuD7yhE54IN5QZqjynxuW8Q9oeRK
         yL0pLj6gpLuSdjfdBzsP9Vuds5uuI3BsVgZARNPoXLyZdXNWZq+tvbqtx34vGd6HrDjW
         H7qEKwxXoZT6++a2Akg3uCMRJwUgvCxKU/Toow2oYMl3TAAFfLDaUbHatZNcccATLn8E
         zBu0XCGP7fcqBFemHjB/9RTm8HNb3LD3gLtrrAkEe7I98x1fGBF/iQWZALaXOwBX9voJ
         ZKvwJHZyHh2a3TT+1OeZyAWgQAHy5eaVDffGLah676VTpK0BzAdeEl4XuI/YlOBPVDn3
         n9hw==
X-Gm-Message-State: AOJu0Ywd8pffBBqggri2y/ZExX+Q4TkUTVV+csq2Ztyd4gqTP4ivoVVV
	ZeMeB+me5yYz0u+BYezFzoe7Svowe6Vt927RwXXL/kmetc1Qtqp0UNbb4RJmZAUfOw1N4Jbm7lZ
	uCcVJpaibCp0HI++cYNtcnknYiuVOQqXXeRHG9CnIM23kLDsqeXhydZxL6kfWqXGxLqL8
X-Gm-Gg: ASbGnctsr45HVXo0CAdclpouEpsTUuEKGhnwLd5LShBJllGxvQamxwRP+AR03WKDx2L
	oTy2PtwEsuUGlCzp1HVKeuBuUUifFDVHtr8Xk3U+ED7ZKZlPP/85yxUZf0V+2t+iXkhb+708rmv
	ws1uUYbrlzGIOxlAF/uhDFo+CW4Q6xIqxPBPmP9xotqwB82dLkPYnWuj1ukZdP5SwE1vw5C3XIY
	ZQJ+R0EKBi5K43Zgu7IImAqNgNAyKXCiUfhBtmQCHeADMfON/YQfsehulaIrEUT844TeUeeZLMs
	AdRuBRDuejm0qirL
X-Received: by 2002:a05:6602:4c8d:b0:85b:4940:65ab with SMTP id ca18e2360f4ac-85e137c173cmr473788639f.5.1742413729339;
        Wed, 19 Mar 2025 12:48:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG528kHraJMpG/HzXxQkVLdzWmhGK2E8tEzFgZcdUqlzAJ2ARY7Mvqx0EjXrK84Ybyj0yvOhg==
X-Received: by 2002:a05:6602:4c8d:b0:85b:4940:65ab with SMTP id ca18e2360f4ac-85e137c173cmr473787239f.5.1742413729028;
        Wed, 19 Mar 2025 12:48:49 -0700 (PDT)
Received: from [172.31.1.159] ([70.105.248.172])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f26371981bsm3341838173.40.2025.03.19.12.48.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Mar 2025 12:48:47 -0700 (PDT)
Message-ID: <c7cc739e-6a0c-4eed-b00f-99ddabf7c0e4@redhat.com>
Date: Wed, 19 Mar 2025 15:48:46 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] nfs-utils: nfsdctl: dont ignore rdma listener return
To: Olga Kornievskaia <okorniev@redhat.com>
Cc: linux-nfs@vger.kernel.org
References: <20250213154722.37499-1-okorniev@redhat.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20250213154722.37499-1-okorniev@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/13/25 10:47 AM, Olga Kornievskaia wrote:
> Don't ignore return code of adding rdma listener. If nfs.conf has asked
> for "rdma=y" but adding the listener fails, don't ignore the failure.
> Note in soft-rdma-provider environment (such as soft iwarp, soft roce),
> when no address-constraints are used, an "any" listener is created and
> rdma-enabling is done independently.
> 
> Fixes: e3b72007ab31 ("nfs-utils: nfsdctl: cleanup listeners if some failed")
> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
Committed... (tag: nfs-utils-2-8-3-rc7)

steved.

> ---
>   utils/nfsdctl/nfsdctl.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/utils/nfsdctl/nfsdctl.c b/utils/nfsdctl/nfsdctl.c
> index 05fecc71..244910ef 100644
> --- a/utils/nfsdctl/nfsdctl.c
> +++ b/utils/nfsdctl/nfsdctl.c
> @@ -1388,7 +1388,7 @@ static int configure_listeners(void)
>   			if (tcp)
>   				ret = add_listener("tcp", n->field, port);
>   			if (rdma)
> -				add_listener("rdma", n->field, rdma_port);
> +				ret = add_listener("rdma", n->field, rdma_port);
>   			if (ret)
>   				return ret;
>   		}
> @@ -1398,7 +1398,7 @@ static int configure_listeners(void)
>   		if (tcp)
>   			ret = add_listener("tcp", "", port);
>   		if (rdma)
> -			add_listener("rdma", "", rdma_port);
> +			ret = add_listener("rdma", "", rdma_port);
>   	}
>   	return ret;
>   }


