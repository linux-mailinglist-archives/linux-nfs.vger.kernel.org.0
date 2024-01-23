Return-Path: <linux-nfs+bounces-1295-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C4183926B
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jan 2024 16:16:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C72051C21C75
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jan 2024 15:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5866024D;
	Tue, 23 Jan 2024 15:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EVnGREhT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A516024C
	for <linux-nfs@vger.kernel.org>; Tue, 23 Jan 2024 15:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706023001; cv=none; b=ZWbExfh3bbF0aXEkzEyHD3bCh0/aJc+7Feuktr/JC6GoZhjTMv5oCQcUJCUTYRwOih3mH1mI6PyHRvL6rfhx7r2zXfIE8NTJIKPQU7uAHUYhOC5VSRS9V+oaVF0RlYoZyLSX1NgQQXViFs3u5jUudgDAc+iWsoy1ligh7JaEIxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706023001; c=relaxed/simple;
	bh=Whvptsm2zU6qezmFAsEVwnHkespnMPH/LhDqlKH0aiM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=i/nbdrAPEZ/ahojdbyMtfE3mIyfERfwQYYAYJ3NKuAeQ7Zz+YacCnPazdpx2gwtoFGAi/sQaDWfph2ivrDdp+uYKEfMRbupCNMpWWHEiUEhbiIFNmwuYGdp47O4Axipa3kF7KolDw85xPT9F8K4PNqrVXTJB14Lgeux5Jd10Dl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EVnGREhT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706022999;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IQRggNCjtx4DoslmpRLr2OHwBJdbw9djWZOxfvU5mPk=;
	b=EVnGREhTFoJCKDk4tZNomVof9ydqNwudod466HfqdOa6x7tcAdV87gKe6F7HBQd2jNjRFV
	70eGABfdwn3CsQnbzw/grIWcx8WOfwmV0Ypl3pmdTdmcqNk8YHKznYIT5J0erp0BkEXA2u
	ox4HE2CRnhsDqii4cYZwyXODoKXiLxc=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-E3jN9FuqPw6TOOVvUfh43g-1; Tue, 23 Jan 2024 10:16:31 -0500
X-MC-Unique: E3jN9FuqPw6TOOVvUfh43g-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7831a20711dso105911385a.0
        for <linux-nfs@vger.kernel.org>; Tue, 23 Jan 2024 07:16:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706022978; x=1706627778;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IQRggNCjtx4DoslmpRLr2OHwBJdbw9djWZOxfvU5mPk=;
        b=iG4puwbqu3wpXCuzv/ij8F7E9MUFv9jHic4a5m1y9KXB3q3w5Ulhx83dLBWL437NpO
         37d92BIfJJbW3lGSRhFfirk2t7nPvnoi+AexpmYQIu3VlYZvtvMIIaYHGzV+WlIYyMw7
         yt02HT/9xsrnoWQ7e/BxIH1OtyGAtZwHGkKAA10aWV2z2pz7UDVECQ6une0vTHgGhDM5
         +55/N1alCa7MEwbEhk6hU/JIlA6K4xNLwYp1IRhb3MtsCjmXZvsPFC1+wCvGF2TrAxVM
         8d4eTvk2EpP3qbJg1wHoXa2n2285ez5flSHZisIBAkynDSiPrIryPg7WvSGqg98dvwCC
         Bmzw==
X-Gm-Message-State: AOJu0YzzaS10jbzgWhw1oycfSfnhMrLOk3fjzP+ruISaknawf+E2fxaH
	PcnKYU7oRohNvXGNGQJqsRfVt6JtpnKMmRb716I/+6SZ/H4bgkZ6vfvtdgU2aOliVzfh76W4CP2
	+rxElpOjDgk2gzsrBJVgJmW0yPKOpyKAqDy2X2tkOo/KBKLjsKRB9xXFyR0kEqH3G7Rtht5KJhr
	HnRY9Qn9bp9wT+cFhuXYgT2mlh/5xmF1G2ya0wQqI=
X-Received: by 2002:a05:620a:1982:b0:783:8d11:acd1 with SMTP id bm2-20020a05620a198200b007838d11acd1mr11974208qkb.5.1706022978145;
        Tue, 23 Jan 2024 07:16:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFUoKLRhFmDsyqLKUTsxHd1f9wjdV1lxYnsdqchXri8ytGc196xoM8mETQjLMLD++2yjDwYzw==
X-Received: by 2002:a05:620a:1982:b0:783:8d11:acd1 with SMTP id bm2-20020a05620a198200b007838d11acd1mr11974184qkb.5.1706022977819;
        Tue, 23 Jan 2024 07:16:17 -0800 (PST)
Received: from [172.31.1.12] ([70.105.251.221])
        by smtp.gmail.com with ESMTPSA id u15-20020a05620a120f00b007836647671fsm3193442qkj.89.2024.01.23.07.16.17
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 07:16:17 -0800 (PST)
Message-ID: <6206ba66-5bee-4a4f-9af6-cf10f93163d3@redhat.com>
Date: Tue, 23 Jan 2024 10:16:16 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] reexport.c: Some Distros need the following include to
 avoid the following error
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
To: Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <20240122182909.97503-1-steved@redhat.com>
In-Reply-To: <20240122182909.97503-1-steved@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 1/22/24 1:29 PM, Steve Dickson wrote:
> reexport.c: In function ‘connect_fsid_service’:
> reexport.c:41:28: error: implicit declaration of function ‘offsetof’ [-Werror=implicit-function-declaration]
>     41 |                 addr_len = offsetof(struct sockaddr_un, sun_path) + strlen(addr.sun_path);
>        |                            ^~~~~~~~
> reexport.c:19:1: note: ‘offsetof’ is defined in header ‘<stddef.h>’; did you forget to ‘#include <stddef.h>’?
>     18 | #include "xlog.h"
>    +++ |+#include <stddef.h>
>     19 |
> reexport.c:41:37: error: expected expression before ‘struct’
>     41 |                 addr_len = offsetof(struct sockaddr_un, sun_path) + strlen(addr.sun_path);
>        |                                     ^~~~~~
> cc1: some warnings being treated as errors
> 
> Signed-off-by: Steve Dickson <steved@redhat.com>
Committed... (tag: nfs-utils-2-7-1-rc4)

steved.
> ---
>   support/reexport/reexport.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/support/reexport/reexport.c b/support/reexport/reexport.c
> index c7bff6a..1febf59 100644
> --- a/support/reexport/reexport.c
> +++ b/support/reexport/reexport.c
> @@ -9,6 +9,7 @@
>   #include <sys/vfs.h>
>   #include <unistd.h>
>   #include <errno.h>
> +#include <stddef.h>
>   
>   #include "nfsd_path.h"
>   #include "conffile.h"


