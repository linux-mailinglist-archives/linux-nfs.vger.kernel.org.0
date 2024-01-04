Return-Path: <linux-nfs+bounces-911-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E698239C0
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Jan 2024 01:42:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4CCF287748
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Jan 2024 00:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9298D4414;
	Thu,  4 Jan 2024 00:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dnwTFixZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E784417
	for <linux-nfs@vger.kernel.org>; Thu,  4 Jan 2024 00:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704328969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hazj/EglDv+zjaOJ1/S2j+NXvIVn0r3XtXmpta+OTJc=;
	b=dnwTFixZqYybo5NsO89ThCLjupx+kc6W60wRJnxsCJa4nVBeUY2TyNKkYk4F6x+q9rIcC+
	xA6cTR5XTMTkyNCSkyXz/LXKO0VlKCrJUz2umcZYBAHOLieK3ULa3VmC9BSqQe6+bRmK/g
	C5F2taFw98ZdtCmWg6wmp/OvC+VgwVg=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-36kBkOK0NKaN7PNJ5L2P3g-1; Wed, 03 Jan 2024 19:42:47 -0500
X-MC-Unique: 36kBkOK0NKaN7PNJ5L2P3g-1
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-6dbe8af9ae8so11769a34.0
        for <linux-nfs@vger.kernel.org>; Wed, 03 Jan 2024 16:42:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704328967; x=1704933767;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hazj/EglDv+zjaOJ1/S2j+NXvIVn0r3XtXmpta+OTJc=;
        b=MsScVni+jeT7SbEGgsDoGN9zuQJZYDbAqdiT/0Ty2RDC7GtSQQ/nalDm7BdznLeXPy
         aGkQqm6pnEYUXrGWMuV4Lpyy3S6pOgVD+8Nj/KZJAedDpKu0OVIUGp+sGBPfL/7Tfv/7
         vk4Ikkldwxh3tiWuiz0sNAd6N5sxVeg2s8zjEqDEnhdWluepQbVuRRhcHe4Y33NQ32Qh
         x6mK1z6ndIYaIpqUyFv/9RurgapylYgIjkRZCi2yhn1VBGpYKKYsM/5qWpIor5eG09f1
         yaJowRWReVg7q0tHJPI8HK1EaoOBb9t3v6oMwVj7nkmjwWHf5EcwBPSgAkxYZXO6uzbM
         5E2w==
X-Gm-Message-State: AOJu0YzNWgR2eCQ1GHvAKNItKCiBeCfCXX1RmYTzE1M+P2kE+KBwejTi
	9ya8LP1sj+QElBtkASKU2hQJImIRL96Q4JtHYHMeONoHtfr4srDiwWgEZWx+/8wYUmTdfrAqx29
	PM97S7+tOsjkt7wKXMIm/60A4RLngpnTu7Uvy
X-Received: by 2002:a05:6830:348d:b0:6db:9bc7:7426 with SMTP id c13-20020a056830348d00b006db9bc77426mr33965945otu.0.1704328967065;
        Wed, 03 Jan 2024 16:42:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEOGQkRmfjU4QW28Kg5JJvIoAjg/y7YPURlLkcAJwajwzrAN1UueJuJIV99mGO1M6YgHpGMDQ==
X-Received: by 2002:a05:6830:348d:b0:6db:9bc7:7426 with SMTP id c13-20020a056830348d00b006db9bc77426mr33965936otu.0.1704328966831;
        Wed, 03 Jan 2024 16:42:46 -0800 (PST)
Received: from [172.31.1.12] ([70.109.152.76])
        by smtp.gmail.com with ESMTPSA id cr9-20020a05622a428900b00427b3271ab4sm13062221qtb.41.2024.01.03.16.42.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jan 2024 16:42:46 -0800 (PST)
Message-ID: <ddc121f6-e80d-43ea-894d-2ad10cdf3051@redhat.com>
Date: Wed, 3 Jan 2024 19:42:45 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [nfs-utils PATCH] reexport.h: Include unistd.h to compile with
 musl
Content-Language: en-US
To: liezhi.yang@windriver.com, linux-nfs@vger.kernel.org
References: <20231214101206.70608-1-liezhi.yang@windriver.com>
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20231214101206.70608-1-liezhi.yang@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/14/23 5:12 AM, liezhi.yang@windriver.com wrote:
> From: Robert Yang <liezhi.yang@windriver.com>
> 
> Fixed error when compile with musl
> reexport.c: In function 'reexpdb_init':
> reexport.c:62:17: error: implicit declaration of function 'sleep' [-Werror=implicit-function-declaration]
>     62 |                 sleep(1);
> 
> Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
> ---
>   support/reexport/reexport.h | 2 ++
>   1 file changed, 2 insertions(+)
I believe this is fixed the last RC release
Please me know if that is not the case.

steved.

> 
> diff --git a/support/reexport/reexport.h b/support/reexport/reexport.h
> index 85fd59c1..02f86844 100644
> --- a/support/reexport/reexport.h
> +++ b/support/reexport/reexport.h
> @@ -1,6 +1,8 @@
>   #ifndef REEXPORT_H
>   #define REEXPORT_H
>   
> +#include <unistd.h>
> +
>   #include "nfslib.h"
>   
>   enum {


