Return-Path: <linux-nfs+bounces-2379-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A3A87F14E
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Mar 2024 21:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8FA81F244B8
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Mar 2024 20:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59DA758201;
	Mon, 18 Mar 2024 20:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IcRJfqve"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B154D58206
	for <linux-nfs@vger.kernel.org>; Mon, 18 Mar 2024 20:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710794381; cv=none; b=qoldKql8j2WpVhgAmDRyKMgPERAts8AIe1lF80J7xdBGAJex7D2eiRvsUAjQGUkGdhFeCf54a0q0YzGndvUPo/I4qe5pwMMFj2yugwSfrJR5H9+s1pQRfv0/oWNLkNNGdbQoiEUQ9A6ulv6ja1b7Hdl75WfE5cbPhPOfdvd2njc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710794381; c=relaxed/simple;
	bh=/BTNCEydw7T5Gi2crPMpDCd+e6NuWfhfBVOrJ7LziRA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BJAqCExHItnvIsdiwV6LPXqTRK8sVj7XwKeW5wT5j3PK64diclgyYkr5l5xlg3Bmtlb4MUxaD8u2XSbXeIVm0pboo8zqOgVJhrtuBpUAXq2slnzMONdPgyu9E2Jt57FFwdIOh0jbrXF6Y3cRjrAOM8aaJePlrSOmlt8taYF8iNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IcRJfqve; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710794378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6wmGT9oYPtbNy4aopW2PKmhVIgg3bbWmH3vRC3YSnzs=;
	b=IcRJfqveJiNgLmVYRZoH1Ti9xs1n/z+Pkt0dGXIOkc78kVPfZJnWh/pxWtY9gWjSS0NkZJ
	6gchyZmYdCVbfQG4ziMzvS8MaAf7fOF7V8AsdYbenA57w1LtHTsbUw/wS+EWZuO6e5lICT
	ilZwwT0kPo8hKoJj28sN95EMFniPkXQ=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-mR4rVHJ9PXCYooQS7lnHSg-1; Mon, 18 Mar 2024 16:39:36 -0400
X-MC-Unique: mR4rVHJ9PXCYooQS7lnHSg-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-430c76df729so6790961cf.0
        for <linux-nfs@vger.kernel.org>; Mon, 18 Mar 2024 13:39:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710794374; x=1711399174;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6wmGT9oYPtbNy4aopW2PKmhVIgg3bbWmH3vRC3YSnzs=;
        b=uTRR6ctdWZbsj/ASD2yukRmHfej0y1XjiiuWKdEnuPjOa6Iyf0eZFGCKXN8HdeYYh9
         egnB16L3NDx0yZqSWXAg9Js3QHtfnCsgE0OGM67YDaNX+iiGaB+tyCtJ0846COJLgcSf
         /2LD0I2KBy9CcBc3PjPl+5M6/tWlVbE77pv9d2f2TSAjgB57AtWFY7vnkBolFpsuTMBZ
         +2FhXtZXF9rM7cDrpO5IsT1qS89WpodrmnqQtalUSznm6UQx8EycFUksoRXsei1QQYez
         ZebYIAIqTvzOb/jFNLtex3YE6uQbBRB5q6GxPwlVDE6Is2E+U9fmqK29oRHUm/kNq3f7
         +YpQ==
X-Gm-Message-State: AOJu0YxRUha3gYQUOikMq8ArZGecGcCbrFhvrn8uHpNRkYyYC6IreqEd
	lm459t15qrWgNgcpns66/3OoFtPhxPz59KjSP6Fs4QPcD/leYoGztkEfNlo6lRAMHF91nJYoaQ+
	ZxOt8Oiver2qkrin0jwJcaFID3hhTGiS4qY0g4jLr+T1nkWKn07pGFB+pGUS6YlVzFA==
X-Received: by 2002:a05:620a:198c:b0:788:3a16:d8b5 with SMTP id bm12-20020a05620a198c00b007883a16d8b5mr12357733qkb.4.1710794373942;
        Mon, 18 Mar 2024 13:39:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjRCg4q0LGX8lo+2asqJqj9EyKXNKvGRYNhaxcpHq5FZvLg+hAr8FEWMk6JRMHWs5GOY059A==
X-Received: by 2002:a05:620a:198c:b0:788:3a16:d8b5 with SMTP id bm12-20020a05620a198c00b007883a16d8b5mr12357719qkb.4.1710794373554;
        Mon, 18 Mar 2024 13:39:33 -0700 (PDT)
Received: from [172.31.1.12] ([70.105.251.209])
        by smtp.gmail.com with ESMTPSA id z7-20020ae9c107000000b00789e1c94cf4sm3968019qki.113.2024.03.18.13.39.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 13:39:33 -0700 (PDT)
Message-ID: <6413ab2a-6629-4b5d-95ae-53bc790d132e@redhat.com>
Date: Mon, 18 Mar 2024 16:39:32 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3 libtirpc v2] Support abstract addresses for rpcbind in
 libtirpc
Content-Language: en-US
To: NeilBrown <neilb@suse.de>
Cc: linux-nfs@vger.kernel.org
References: <20240311014327.19692-1-neilb@suse.de>
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20240311014327.19692-1-neilb@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/10/24 9:41 PM, NeilBrown wrote:
> This resend includes a couple of bug fixes.
> In the first patch, __rpc_taddr2uaddr_af() was reported a "universal" address
> of the absract socket as starting with "\0" instead of "@".
> 
> In the second patch, only one local_rpcb() call wants the target address.
> 
> Thanks,
> NeilBrown
> 
>   [PATCH 1/3] Allow working with abstract AF_UNIX addresses.
>   [PATCH 2/3] Change local_rpcb() to take a targaddr pointer.
>   [PATCH 3/3] Try using a new abstract address when connecting to
> 
Committed... (tag: libtirpc-1-3-5-rc3)

steved.


