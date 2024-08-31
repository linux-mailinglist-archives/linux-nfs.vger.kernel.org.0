Return-Path: <linux-nfs+bounces-6071-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D84369672E2
	for <lists+linux-nfs@lfdr.de>; Sat, 31 Aug 2024 19:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 974DB282EAF
	for <lists+linux-nfs@lfdr.de>; Sat, 31 Aug 2024 17:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A114D8DA;
	Sat, 31 Aug 2024 17:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VFxiMbeZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1955F10A3D
	for <linux-nfs@vger.kernel.org>; Sat, 31 Aug 2024 17:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725126789; cv=none; b=lsp0SLFMDBr5wry6J2H5PhDEZyTql7UfVYWAx8c4yfocVIfumFDc2xUegj8WksnVM28eIYoLY4UBWk50Sw6ewPXjKSunpxNZBpDjq8Ahzog7IEdsqzjAyTqhHMTHAOnMomkvbIu/2D1YGv1i9rzS6nQX6Wmil1LKE8jJ3J7kMyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725126789; c=relaxed/simple;
	bh=IkI+KJBPcD3bddtjaav5ivPCiYJ4eUjIMUNiXVYAoRE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bi+4wQhCcuGLxbPN0rYd9dwpYcpHxkyJrygAEe+Qsutyv2pXnOhyn0Z3kOAz5PCilXZVN/PbuBx2sE6D9gREWmoab3LrX6HbkfS2GREYK1khKI1AlhMnAj3wO//gAn9kpIbBeIPyNt0nWf9dqbPdCPAdcyi5mSlMX/VhntJg+hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VFxiMbeZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725126786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lyATMQCe1Dv18BB2Bk7Ib1oxkyvh46zvKhX/eDzdsRw=;
	b=VFxiMbeZhDedbvvETnZQQMZ91FhgPfUzsn1cT0LJz6CRn2pCn+4kVvBGbNbqdNcNbdm5Mk
	bcY1U6mgKZC6nO+4tYG5ojff3xAGROlxvrG3B4geJx6eJc11z1H2/T6VmFS2FlitqNTVI9
	XdthfqkVGekiNH10YsCVYxz9cKeOFD8=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-n4JRp-4SPSiQgGIMMfZ_fQ-1; Sat, 31 Aug 2024 13:53:03 -0400
X-MC-Unique: n4JRp-4SPSiQgGIMMfZ_fQ-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7a7fa54e84aso406960485a.1
        for <linux-nfs@vger.kernel.org>; Sat, 31 Aug 2024 10:53:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725126783; x=1725731583;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lyATMQCe1Dv18BB2Bk7Ib1oxkyvh46zvKhX/eDzdsRw=;
        b=FY9Hqyn1Yh+wqurIRlAAJJLorCjqj45M0rSKh6OxtPTzbWfER89QHpgJDToPABAOR5
         wkyzkDu/G1otjaO64pRVq2V7ITuA274+pAE67ez/Yo8j5bSwSBlXXAGgzzB/bns8E+vj
         bxuR0jSnKD//dkfcOYiMyNRdbNTQPfQgNogbdT4DaqOagjT+NNOxrdn7pk5LGv/8lQlP
         walAeAZd7ngI0XRu7eesZKpwxNuRj3CdwDxuKuq2WWg7P19udhtX5FoYAwGjXwtz0rZ7
         pPfRg/czGjIWgQdZ9cym4KDI36trShXXotnHrG7qaZ5o26c/rUR4AcY2NGHWckBMgFQq
         UfQA==
X-Forwarded-Encrypted: i=1; AJvYcCWnek5tR121mDYYXWCPhUZoFiXRhh8gy3CUgfscRxV2k4oN5YhLYz+Ykq4W+Mm1/t9ZAcICOW/2TsM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiydNmJzwkdyIhq9O0XiSo9WKgilJrV3wFfEC2ne/9nZyzRZq1
	hhU2UwxmH9F0yl5xEd7aT9CPVyDAL08imIfHl3nUbjI53O5RPIzLWcVhv/uJzl2neFnNZlhauvW
	cOZ9ILmsyr2v3o0BQi/HhCamuYo9rH3VjYDHWwVRbx0AkDTgmciiQXqx3mA==
X-Received: by 2002:a05:620a:319f:b0:7a1:e2e0:b3a7 with SMTP id af79cd13be357-7a804164e71mr1643821385a.13.1725126783317;
        Sat, 31 Aug 2024 10:53:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHW7CrkPpkSYtTqchZAWG0lXSGjYhvwGAVxPKJEGAH4bb7Sj0fgZZMy+E8Z/EiSrQgApxYd7A==
X-Received: by 2002:a05:620a:319f:b0:7a1:e2e0:b3a7 with SMTP id af79cd13be357-7a804164e71mr1643819285a.13.1725126783001;
        Sat, 31 Aug 2024 10:53:03 -0700 (PDT)
Received: from [172.31.1.12] ([70.105.250.234])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a806c2302csm260074685a.46.2024.08.31.10.53.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Aug 2024 10:53:02 -0700 (PDT)
Message-ID: <2f6bc707-b3d3-42fa-a038-6c060b688fc9@redhat.com>
Date: Sat, 31 Aug 2024 13:53:00 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH libtirpc 1/1] Move rpcbind.sock to /run
To: Petr Vorel <pvorel@suse.cz>, linux-nfs@vger.kernel.org
Cc: libtirpc-devel@lists.sourceforge.net, Josue Ortega <josue@debian.org>,
 NeilBrown <neilb@suse.de>, Thomas Blume <Thomas.Blume@suse.com>,
 Yann Leprince <yann.leprince@ylep.fr>
References: <20240830174335.89678-1-pvorel@suse.cz>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20240830174335.89678-1-pvorel@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/30/24 1:43 PM, Petr Vorel wrote:
> Most of the distros have /var/run as symlink to /run.
> 
> Because /var may be a separate partition, and could even be mounted via
> NFS, having to look directly to /run help to avoid issues rpcbind
> startup early in boot when /var might not be available.
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
Committed... (tag: libtirpc-1-3-6-rc1)

steved.

> ---
> Follow up for rpcbind patch which touches rpcbind.lock location.
> 
> Kind regards,
> Petr
> 
>   tirpc/rpc/rpcb_prot.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tirpc/rpc/rpcb_prot.h b/tirpc/rpc/rpcb_prot.h
> index eb3a0c4..06138bc 100644
> --- a/tirpc/rpc/rpcb_prot.h
> +++ b/tirpc/rpc/rpcb_prot.h
> @@ -476,8 +476,8 @@ extern bool_t xdr_netbuf(XDR *, struct netbuf *);
>   #define RPCBVERS_3 RPCBVERS
>   #define RPCBVERS_4 RPCBVERS4
>   
> -#define _PATH_RPCBINDSOCK "/var/run/rpcbind.sock"
> -#define _PATH_RPCBINDSOCK_ABSTRACT "\0/run/rpcbind.sock"
> +#define _PATH_RPCBINDSOCK "/run/rpcbind.sock"
> +#define _PATH_RPCBINDSOCK_ABSTRACT "\0" _PATH_RPCBINDSOCK
>   
>   #else /* ndef _KERNEL */
>   #ifdef __cplusplus


