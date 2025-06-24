Return-Path: <linux-nfs+bounces-12732-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B1AAE6F45
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Jun 2025 21:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 016903AECCD
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Jun 2025 19:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E8AB2E88A2;
	Tue, 24 Jun 2025 19:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DGs6yY6S"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6CD2E7F03
	for <linux-nfs@vger.kernel.org>; Tue, 24 Jun 2025 19:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750792285; cv=none; b=f/pbA+L6qQX5ccBbVV81hrMNq/QiZdqDhGymuYZEdQqC3qVIZmRGJgW2q10mUkUdSvp0J3JmERNT3KrtBqmbXWJrReQoG5zkg3XaAMjoFEoDd8Ry0LEENsjknTNirJzGrQFJrYHBwbzwPVnNsNYPi6N40Dkz8vMG8lnSSXTCl4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750792285; c=relaxed/simple;
	bh=nN0LF7A16b4fpWAw/+0LN3rbnBsC24zomaabgd7zaTU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BBYYRg/1JcGZFqtJuJnvJpoJYEGSwx6TFrYF5QCUholJEXJ9QTlL+fM3HGXItxEhDRRlVaQAh/cKDOVHOh33qruwyh8hCeKny+uhJDGhps1gxdjcWVXEv1A+XiYkze4Xd8zAJ6Lpsv5iwSI3PPw6L8kY1cubVAl5mPVo7HkMBx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DGs6yY6S; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750792282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9HC0lJR7h4HlyrCusHaTY+t6vYZOa+EUM6lTOiX/ryA=;
	b=DGs6yY6SdoEb7z+MPFBNiXZKjCo1onMzWUGylMqAcVbn6w5Lg74Jgo0zWrehtfY5CrRwmM
	SLPUj4+0+150JLvPVqCG6juJZ9VjiNNv/B/Fc8p2/2R3pBtYVYdR+OWCn2sk53A+qH43Rz
	3zyRlIMxtTWBzSfZBvg1HvMM/7Qtx4M=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-YtGES9jdMPuFNHDRNMlZ7g-1; Tue, 24 Jun 2025 15:11:20 -0400
X-MC-Unique: YtGES9jdMPuFNHDRNMlZ7g-1
X-Mimecast-MFC-AGG-ID: YtGES9jdMPuFNHDRNMlZ7g_1750792280
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6fd5e0bc378so4516166d6.1
        for <linux-nfs@vger.kernel.org>; Tue, 24 Jun 2025 12:11:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750792280; x=1751397080;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9HC0lJR7h4HlyrCusHaTY+t6vYZOa+EUM6lTOiX/ryA=;
        b=RsiMwTSoZgw+eLLK1azMnBaAr2f4HK3JS1HFikp1NZxnoz2qeyAVBrd4OAQwmAAMb/
         gRD76QSNtnei3FYyEm2kIrYC6PM3OC/b+wdvBLlgA7udDyFqYmSLTGfTfxQ+2nh/SC7g
         GTmVP0DSBCWQ/zs/OL5gSpYxQ0LQRfvP8O6rIeS5edfK650Zn5+5IgWCxKZNWImJrPsv
         DrxVxj1NMHin8xE0K5oxJzjcAJGnxT80uUmRDyKmRsnQCDoHY2g2Ih53gzNGPcOOD01p
         BNT8jvso39+wFxJvBL70WZ9OcgLL2y3aFzNGN/ynY2jnvfLaYsrv6Mf2+PFybkrVDLGq
         YxYg==
X-Forwarded-Encrypted: i=1; AJvYcCWP+E64OBV/bWucmSakp1fNAgzgy6BpGfffY20n4gqMuH8lweD6aDa8n28rtxDhmpmR/iQN5g5lm4o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqw+6dGmpM4Jud5DVCCl4CVieNblsOwvB5aiTnnlj5wTW93EyP
	KJicD7znmjlTq4W8QuZSJMIQBfkqhSWDuviHxmn8PwLn0140K0F7aEUuvTbYgZTDbi5VwQ0drm2
	W7J2G6nCeOt6zCJROjLTo0XDsqf1v1Csfg5GrT4fIJk2Jx/C6EtV6UkZDD0mQTg==
X-Gm-Gg: ASbGnct+DDcOFIYPwkdDSvRFJM1GG4zCysBQ2cVmTEaesAf/GaJF/XAPtHB5zgPKyhY
	mLIr9ZnjaB/lhX6qjibm3bsOJXwXyGkB4y/vZv5t53TlptYoCBVUu4QI+Ux6tU+DqIYWBVwCV9M
	Hh3zCE1qXm9txvC//ytlasFiJLFZU78aFNlFV2GkI3K09byYZTGMgwm1LQdG+vrwkAgcFT/20nq
	Z1jal3Cr9YOmOb6V6k2Hhf2hzhHbvj2paxJ+JWf3Mm/VW0NFqUpwx07vY2Jvnch63G+wcvsHQws
	0pSimH/F5XRmXQqHkWprlA==
X-Received: by 2002:ad4:5f0b:0:b0:6fa:d8bb:2944 with SMTP id 6a1803df08f44-6fd5ef2b6a4mr1538366d6.4.1750792280105;
        Tue, 24 Jun 2025 12:11:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4j7+X9G6rNwbJtB/7eaC391QUZ2rOBKidsjGRkg1LjAUdBXH0b8cjB3XCBikIh1NP+2usuQ==
X-Received: by 2002:ad4:5f0b:0:b0:6fa:d8bb:2944 with SMTP id 6a1803df08f44-6fd5ef2b6a4mr1538016d6.4.1750792279623;
        Tue, 24 Jun 2025 12:11:19 -0700 (PDT)
Received: from [172.31.1.12] ([70.105.246.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd0931178asm60246336d6.0.2025.06.24.12.11.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jun 2025 12:11:19 -0700 (PDT)
Message-ID: <9cb69c30-168d-4356-8faf-590be859c8f8@redhat.com>
Date: Tue, 24 Jun 2025 15:11:18 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfsroot-generator: do not fail if nfsroot is not
 configured
To: Antonio Alvarez Feijoo <antonio.feijoo@suse.com>,
 linux-nfs@vger.kernel.org
References: <20250609135911.48232-1-antonio.feijoo@suse.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20250609135911.48232-1-antonio.feijoo@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/9/25 9:59 AM, Antonio Alvarez Feijoo wrote:
> If the user configures an alternative way to boot the system, the
> nfsroot-generator should not fail.  In other words, the presence of
> the nfsroot-generator in the initrd does not imply that nfsroot must
> be mandatory.
> 
> Signed-off-by: Antonio Alvarez Feijoo <antonio.feijoo@suse.com>
Committed...

steved.

> ---
>   systemd/nfsroot-generator.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/systemd/nfsroot-generator.c b/systemd/nfsroot-generator.c
> index 52bd0752..f3cb60c3 100644
> --- a/systemd/nfsroot-generator.c
> +++ b/systemd/nfsroot-generator.c
> @@ -78,10 +78,10 @@ static int get_nfsroot_info_from_cmdline(struct nfsroot_info *info)
>   		/* Mount type: "nfs" or "nfs4" */
>   		colon = strchr(root, ':');
>   		if (colon == NULL)
> -			return EINVAL;
> +			return 0;
>   		if (strncmp(root, "nfs:", strlen("nfs:")) &&
>   			strncmp(root, "nfs4:", strlen("nfs4:")))
> -			return EINVAL;
> +			return 0;
>   
>   		nfsroot = colon + 1;
>   	}


