Return-Path: <linux-nfs+bounces-3332-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD52D8CBF7A
	for <lists+linux-nfs@lfdr.de>; Wed, 22 May 2024 12:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ECF11F23406
	for <lists+linux-nfs@lfdr.de>; Wed, 22 May 2024 10:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87FA68002E;
	Wed, 22 May 2024 10:50:51 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBB279B9D;
	Wed, 22 May 2024 10:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716375051; cv=none; b=gJQnQMLgOTeOII8PJ7JPA+CE439fklymDLHbG4B1WvltfJuqi14irR9JFmL1zoh4Y4eZPql4Sk49+DWJn9e83gmCNWPpZUqcT7SHwi/mCNYcTHg36BlChonnGj4OycIjboW+XljzkoUs6lQDR3zImglT2JBBa2rDnctIG4fY7dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716375051; c=relaxed/simple;
	bh=VyBReXjt4mK/tUMAyCCPZcz5+wqr2j9lYzuGW1fGTIs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gicwYsIdEtqoALWWaRL0yNq8YkEE6HZdH7vPbA6HuicAXXMtwziPplpT86sO/CjErOY4G/ulz5J1nrLnWRovVcgC5Edz5x9lEtxnYUuk0gHZpfq2tTpVFCXjaGCQ0Mm3XyHdI45q37Zv/140/QICzn1eHDnBvwOTyNMf/EErmKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-354c3b445bbso426748f8f.1;
        Wed, 22 May 2024 03:50:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716375048; x=1716979848;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1BnHc3XspGm0v4PnkZaEeuFqvR0cRw7aXohQPjr95aY=;
        b=J+S0GK87ZRsWvGxuFvZc3ztgNHaPAjSdZ4MoJXvmgJxtKewQhkSH3bx2NHTGnPM3Pw
         M3FqKUakT7eBkwWFINvuGUrrMY4WeIfFGW9WWAXlrUpAwM9QOcoZLZ9GrZOdEc9W/daX
         aEIeOb7XCZPIiQ/ZaXFdZRAWHuqW/elT845h0dygUJXOvyHiILlLVQ/cPIHATMw1hlwC
         IwwGOhNhuG7x1ScteLebeVXDRZbP1hF4+1jdA1glJOahSYAjJ4NBCMV06e1cq6fukirI
         VBkUvZS+uGn2Y+yLrS3tCYoDAJ63Z52MzDxeV59XK0ELSSXcTlk9L9hAbZ86td6zrvcp
         +18A==
X-Forwarded-Encrypted: i=1; AJvYcCVXnWE9PFH7WUcQn876d/AhAk70EyJxaDuR9nqEWTw1CkygBJRl6OsP8SlbggaCvmlhmnx8alLq/8q1Ph9wTMZU52eq1UpRJk3mLPPavplg8MQBD8qQyd+8h7ycHitdcrV1bMN5Hg==
X-Gm-Message-State: AOJu0YyZ6NH472gN6ReHH6tuHvNPtWQyVzMeJwrgFPPvu+s4jsmdvbXw
	i8bKcZ4C4D1XGOfd1uSSCxN46I9/0Ihx1yOSguOavj0JcISu5SzD
X-Google-Smtp-Source: AGHT+IGSF2AVRpH6Y4O/xml9TIH1QyFLkrQi4blx+ftI6lROnk9Fsw05hHINZrkwwdozuInSgu5v2w==
X-Received: by 2002:a05:600c:3ba8:b0:418:f770:ba0 with SMTP id 5b1f17b1804b1-420fd22a4d5mr12400595e9.0.1716375047841;
        Wed, 22 May 2024 03:50:47 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42011d91edfsm406112765e9.44.2024.05.22.03.50.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 May 2024 03:50:47 -0700 (PDT)
Message-ID: <c1aa177a-3328-4447-af23-246beacf3169@grimberg.me>
Date: Wed, 22 May 2024 13:50:46 +0300
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Safe to delete rpcrdma.ko loading start-up code
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Chuck Lever III <chuck.lever@oracle.com>,
 Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <DE53C92C-D16E-4FA7-9C0B-F83F03B1896F@oracle.com>
 <8cc80bdb-9f17-4f44-b2e6-54b36ac85b63@grimberg.me>
 <20240521124306.GE20229@nvidia.com>
 <5b0b8ffe-75ad-4026-a0e8-8d74992ab7b6@grimberg.me>
 <20240521133727.GF20229@nvidia.com>
 <46c36727-ef93-44ca-9741-df2325d4420c@grimberg.me>
 <20240521152325.GG20229@nvidia.com>
 <e558ee64-48fc-48b9-addd-eab7f9f861ad@grimberg.me>
 <20240521163713.GL20229@nvidia.com>
 <0f9ddfe5-67ff-470b-8901-d513dceb757e@grimberg.me>
 <20240521232905.GQ20229@nvidia.com>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240521232905.GQ20229@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 22/05/2024 2:29, Jason Gunthorpe wrote:
> On Tue, May 21, 2024 at 11:30:00PM +0300, Sagi Grimberg wrote:
>
>> I just don't see why the presence of an rdma device dictates that
>> all the ulps autoload. Does rxe/siw count as rdma HW?
> It doesn't do all of them, just the ones the distro decides it wants
> to do, usually for boot volumes. It is a weird historical thing :|

Well, as mentioned, I find it odd. For the same reason why
all tcp flavors of the ulps discussed in this thread don't autoload if 
the machine
has a nic (which means pretty much every machine).

Having said that, I don't have the same PoV as distro folks...

