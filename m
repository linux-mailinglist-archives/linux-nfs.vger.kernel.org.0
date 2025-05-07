Return-Path: <linux-nfs+bounces-11578-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D53AAE2D7
	for <lists+linux-nfs@lfdr.de>; Wed,  7 May 2025 16:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0266527064
	for <lists+linux-nfs@lfdr.de>; Wed,  7 May 2025 14:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D3C28CF7B;
	Wed,  7 May 2025 14:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PPE2sESa"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19BB28D841
	for <linux-nfs@vger.kernel.org>; Wed,  7 May 2025 14:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746627355; cv=none; b=Mb1OfjY6KF3pDUHoh77H5kSlWKsF284XnODIk2FsOPpdrgoo+XhwP5KNI+jSbAu1X/rj6MhtOS8D/Z1JH1cWqWO/EthpfTNfzKHtWnYY6rHIQ/mmHx+HEmn/S7CiQB7xaQ/oHf9saRsTJ3DdIJIyCyqcieVhUFd8VZBvMJDR3/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746627355; c=relaxed/simple;
	bh=fJckmf9IwjYeead7dT1KUL8OcRRAIxNLq2zNTa3lYpQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=pzlvRzaUkHjAmEo24P8X+zcuySjBMNhGZNtTMGmqtk2v/7glWutvfOya4BT0MEiWDn95YueQfT/8U5dz830KB6m9/5qUos62vgO+TlUGm8I8J/qgH2g+6r1tRFWA+VoKC2T7U2dId5kw2Cdbzj1IZg+RWXf420PD8qlVr5/4mhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PPE2sESa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746627352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jfVK6HHLff73J58o9PanfKB8cNl8BoppLGUFG9f83E4=;
	b=PPE2sESarGD8v178on+BMILBWLdmApkl88jttaLWscS4jqC4Q5fMt8M7wV2ZxZefMoLQZy
	3FQIqg8CqDEQ1jDEbgpV0+aa/txk3vyGUycf1zjZDNZx+6QkC6q/5tWVsifN9vOWkqhHtx
	1lXF+9WfSYhLGqK+Qun1iTVDhzPYwuE=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-9qTqh53pPNylZaxDWb6SxA-1; Wed, 07 May 2025 10:15:51 -0400
X-MC-Unique: 9qTqh53pPNylZaxDWb6SxA-1
X-Mimecast-MFC-AGG-ID: 9qTqh53pPNylZaxDWb6SxA_1746627351
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4766afee192so147190621cf.0
        for <linux-nfs@vger.kernel.org>; Wed, 07 May 2025 07:15:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746627350; x=1747232150;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jfVK6HHLff73J58o9PanfKB8cNl8BoppLGUFG9f83E4=;
        b=N2YsSla5qU5HrQD8VKLx+SZh7DRjz8E1MkYlH4+Mr7FGjUmE751sH2UA4asLtEo12A
         Fu9EVFGkfAGuXxmHGRE3vR2zdzerOdRvBcSOdo7Bt8reGAmVC8iAaY1xoErIeBhYtD6j
         zfPrJ8AgRm0bG6g7FfE9sFTz37jwhEZeaKBL5KcbSxGrhWKEGJQ4Jgpe5PvNY6I//MpT
         j/ZMyDInb7aTQXF2TRYUTAfrYRps08+nFIltg10gNirDULiFaWR25VC5EoGEILK8Nk3d
         uXxDO8HkRhEM2RuANsd2+KaIsjuFbcVWwOmuCsp++8Uc7ENV/YW/riiltaN6tLHu59L1
         JTgQ==
X-Gm-Message-State: AOJu0YwScEv2QhXiASThxP4Em/QfZWdM2eR9XjvGJVH1xCg8K+0nGN+a
	U6Tc+sX3U0wFT3HlNaPRkLRQmQAsfnVXX0gMXbEFjPuZy+7Rocdb6hFBBbl0X2Lg8ZymTpkqW8u
	JJ3XHbBfOV5REgShrymPlFFGfpJGPgIo53R5kuCykqcCV6ba4fWVpHIuEBHZUwQZSoFFMmWIUW3
	6fLRadvJPMQmAAbMy89bXfTbr3YvBWT2kVrhX4s5Y=
X-Gm-Gg: ASbGncuOlsEIoPGm+X8qybVt39bwa+hy6DfI5qpqEnV9B3zLti7/MzlUegBaYYWB06t
	7IwK7wnoUri9Wom8VAc/T2UHWorFxdtyhbPjIE9mxDiRVATmJqzjqqfD+1/Mvf+u3o7DtMNCKU1
	cb8f8Fb1Zc/oOM7cb3dqyLcAVXn/S3M1DVtqHHa/T6hboHY5ua+8J8HxPejPq343bC4GwwL87DH
	BbX9q3ArCJ2tlO7TLVjFM/6JgKFHc04vXneG/SF91c/cX4ZGTjIvkTrbXyYg+6atOzTloE9v1qa
	HD/U6qAryQ==
X-Received: by 2002:a05:622a:4d9b:b0:491:286a:8606 with SMTP id d75a77b69052e-49222ca000emr50210911cf.0.1746627350457;
        Wed, 07 May 2025 07:15:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbZ8pFyrQacvlFgLuV1wmsFo7TUeoD0jLI+2fzY9WOsMB26hfJv1aj7iYV/ZFtnpHe7AIeMA==
X-Received: by 2002:a05:622a:4d9b:b0:491:286a:8606 with SMTP id d75a77b69052e-49222ca000emr50210481cf.0.1746627350017;
        Wed, 07 May 2025 07:15:50 -0700 (PDT)
Received: from [172.31.1.12] ([70.105.247.97])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-49220f81e34sm14773511cf.11.2025.05.07.07.15.49
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 May 2025 07:15:49 -0700 (PDT)
Message-ID: <08c25488-ecd8-4c05-b70b-6b56535151c0@redhat.com>
Date: Wed, 7 May 2025 10:15:48 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfsdctl: Warning Clean Up
From: Steve Dickson <steved@redhat.com>
To: Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <20250507114407.101530-1-steved@redhat.com>
Content-Language: en-US
In-Reply-To: <20250507114407.101530-1-steved@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/7/25 7:44 AM, Steve Dickson wrote:
> Removed a number of unused variables
> 
> Initialized a variable that could be used
> before initialized
> 
> Signed-off-by: Steve Dickson <steved@redhat.com>
Committed... (tag: nfs-utils-2-8-4-rc1)

steved.
> ---
>   utils/nfsdctl/nfsdctl.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/utils/nfsdctl/nfsdctl.c b/utils/nfsdctl/nfsdctl.c
> index c2e34260..e7a0e124 100644
> --- a/utils/nfsdctl/nfsdctl.c
> +++ b/utils/nfsdctl/nfsdctl.c
> @@ -1521,7 +1521,7 @@ static int configure_versions(void)
>   
>   static int configure_listeners(void)
>   {
> -	char *port, *rdma_port;
> +	char *port, *rdma_port = NULL;
>   	bool rdma, udp, tcp;
>   	struct conf_list *hosts;
>   	int ret = 0;
> @@ -1675,10 +1675,7 @@ static void nlm_usage(void)
>   
>   static int nlm_func(struct nl_sock *sock, int argc, char ** argv)
>   {
> -	int *threads, grace, lease, idx, ret, opt, pools;
> -	struct conf_list *thread_str;
> -	struct conf_list_node *n;
> -	char *scope, *pool_mode;
> +	int opt;
>   
>   	optind = 1;
>   	while ((opt = getopt_long(argc, argv, "h", help_only_options, NULL)) != -1) {


