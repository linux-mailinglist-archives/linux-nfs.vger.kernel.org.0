Return-Path: <linux-nfs+bounces-7867-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6594B9C4387
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Nov 2024 18:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DA11B25651
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Nov 2024 17:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807BD25777;
	Mon, 11 Nov 2024 17:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QGGJ4IO+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB66F19F10A
	for <linux-nfs@vger.kernel.org>; Mon, 11 Nov 2024 17:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731345953; cv=none; b=AfP8NNqNzbBIDD7xqn8G20EsodO0hALmyQYivZHRH2jOiIHwqCYFtdYK1lRsp2PR0jiC2K5fW5K8HGYZzUkO8YAGw4xh95VuNkH5DOR21EnhMWNzal7m3tU3mY28PETy21LHsOeJWUi6gZ3qD3WLaqlWnPq9vTYvb9okw8fgWE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731345953; c=relaxed/simple;
	bh=8NVDPiKt/C7sDCYEbNMcnEjrINWSIQEGN/bS8hLWyRc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PpAHOZCT73iwqUg+B+ttx/QNcnKSd1cXVvvV/YFaq71/R0XivcMi0FO3CSkeM4OleGg867RPjRYNR5/ssHXy/Qxfkhg7Exm/eaYjyrzkLGybK8tcJhghEiJRMoG9mrKF4TXUD4zohzaFxylnBNVmf1xiYmGGCUcFbfb8wtmFLOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QGGJ4IO+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731345950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v90q+9V9nwIQWRKGj7y+M+cNXjya24fJBCKNCkvVJOw=;
	b=QGGJ4IO+J0fq04OaBYSfOdoiPfqt91z4bU7kkowvNPD2Ummsdab+E3POdE/hyIQ24HWl+J
	ljRgDCykJybK5l9/EpMGQ8OliqfiupmBrboN0HaTTMOQUS9di4uP7bd0PXCUWWnNHg1SF+
	YtcvfQ6d2T9WwKDUvvxHHAzNL23Ycko=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-In1eNdvaMIyZe-K3DiJbKg-1; Mon, 11 Nov 2024 12:25:48 -0500
X-MC-Unique: In1eNdvaMIyZe-K3DiJbKg-1
X-Mimecast-MFC-AGG-ID: In1eNdvaMIyZe-K3DiJbKg
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-83acaa1f819so554432439f.3
        for <linux-nfs@vger.kernel.org>; Mon, 11 Nov 2024 09:25:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731345948; x=1731950748;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v90q+9V9nwIQWRKGj7y+M+cNXjya24fJBCKNCkvVJOw=;
        b=vWlXm+vzZqJXbSED6OY9AyfZrO1Ka4fA8AzVtR2qt1gEYEE9hVK9U5oWaTilYuJ3nt
         av5Bdt9qshhfOzOUo6zY68LUbDL/x5KtUAEJJsHp0BC4HcH2zvPjijrMReqnpQ0GWcn7
         8V25DHBeLSQOIgQnT0DXVaIK6yEA78XnnhuFQ/Vb8euxzVA3GfEvQYgtRj9+HDs0mQTa
         zvJkwwBJlp74t1GAwAaor7q8DihnAhfCCVZdKc71vl3OIsnuONOj7i7Ltm70RgZ0x2yr
         2WmBx7pmQnTXUdOkZbKxUg8ehybOHJUzOJaslgCNDeM4QcqK/VUf1VK928NQqPzUJsjp
         HvMQ==
X-Gm-Message-State: AOJu0YyQm/HFAxrBEf2CqTcgTT3o1zNhkmt5RtuGRCEnSx0m5f8V/LSi
	UKtt994AZ6X00jh05TS63RHr+ENBdSWW3hM5N4QZAQjCSAvOa9bONY/evTXm4nil6XwzIQI8Phu
	Et6QXOTPQ5D6JgMHs/IgF4STQkQovfEXkjfl7Ji8ioptG/c3idx/FPWpaGw==
X-Received: by 2002:a05:6602:1607:b0:837:7d54:acf1 with SMTP id ca18e2360f4ac-83e0328ffd9mr1550996339f.2.1731345948021;
        Mon, 11 Nov 2024 09:25:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF7j4P14JOgeSj5Iovr8GMcfIGEwljHeEURSbQjguiBkEdNEj2lmnONasqmiwX+6yG1zBssEA==
X-Received: by 2002:a05:6602:1607:b0:837:7d54:acf1 with SMTP id ca18e2360f4ac-83e0328ffd9mr1550994939f.2.1731345947690;
        Mon, 11 Nov 2024 09:25:47 -0800 (PST)
Received: from ?IPV6:2603:6000:d605:db00:d7de:cb5e:42f:cca3? ([2603:6000:d605:db00:d7de:cb5e:42f:cca3])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-83e13526c3fsm140035439f.39.2024.11.11.09.25.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 09:25:46 -0800 (PST)
Message-ID: <54e46053-c43d-4662-b9af-85186be11123@redhat.com>
Date: Mon, 11 Nov 2024 11:25:45 -0600
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Makefile.am: allow mount.nfs to be writeable by owner
To: Scott Mayhew <smayhew@redhat.com>
Cc: linux-nfs@vger.kernel.org
References: <20241106181342.776776-1-smayhew@redhat.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20241106181342.776776-1-smayhew@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/6/24 12:13 PM, Scott Mayhew wrote:
> On Red Hat-based systems, the debug symbol files are built with a
> .gdb_index section to speed up gdb initialization.  The gdb-add-index
> program calls objcopy to merge the index file into the object file.
> That fails if the object file isn't writeable by the owner.
> 
> Signed-off-by: Scott Mayhew <smayhew@redhat.com
Committed... (tag: nfs-utils-2-8-2-rc1)

steved.

> ---
>   utils/mount/Makefile.am | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/utils/mount/Makefile.am b/utils/mount/Makefile.am
> index 5ff1148c..83a8ee1c 100644
> --- a/utils/mount/Makefile.am
> +++ b/utils/mount/Makefile.am
> @@ -50,7 +50,7 @@ install-exec-hook:
>   	  ln -sf mount.nfs mount.nfs4 && \
>   	  ln -sf mount.nfs umount.nfs && \
>   	  ln -sf mount.nfs umount.nfs4 && \
> -	  chmod 4511 mount.nfs )
> +	  chmod 4711 mount.nfs )
>   uninstall-hook:
>   	(cd $(DESTDIR)$(sbindir) && \
>   	    rm -f mount.nfs4 umount.nfs umount.nfs4)


