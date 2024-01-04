Return-Path: <linux-nfs+bounces-910-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A80AE8239B7
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Jan 2024 01:39:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 376C9287078
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Jan 2024 00:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC3BF4F5;
	Thu,  4 Jan 2024 00:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G+WBiCol"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DECF4EB
	for <linux-nfs@vger.kernel.org>; Thu,  4 Jan 2024 00:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704328778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4BUPgWyVtlJ9usLQuZmv4zFKIIAeL7q3FzPiROXZguc=;
	b=G+WBiColAhNmXNgMCCR+gEBj7pkgoQm/Zk5HFWVLwBI1NUWul1y4y94wARKXy+z0WpuzCT
	DkC6sU8pZYNBOZAMILL/nkkULrFLdjLL6eo4IUSFmdtF5o4OAtyqjRo/j8zL24Mf/csI2H
	9Qyf7TEjZiI8luOF/iXAMSiJydFVhFg=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-340-CFng5LnWPwWr2AqvjQvfDg-1; Wed, 03 Jan 2024 19:39:36 -0500
X-MC-Unique: CFng5LnWPwWr2AqvjQvfDg-1
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-20455c22255so2485fac.1
        for <linux-nfs@vger.kernel.org>; Wed, 03 Jan 2024 16:39:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704328776; x=1704933576;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4BUPgWyVtlJ9usLQuZmv4zFKIIAeL7q3FzPiROXZguc=;
        b=K9eCmr3ICJzOs+uOIlb7G8BqANn7VXwZmfuDDdRtVba3PLXQ4Hsi7qbcXhPgL9CX95
         8nh6wP6SAk87E6M1bmPLxw93MAwwreZSsDCM9smqHcTd6lS5ZN3iS5O00PTFCEOjiQaC
         qxFpsPPyXsRIVprKUG/3nwZOI/0x4D+Wvap03m3bl42iHAe4PL9k0jyYp1stRYlbt+nq
         3Q8KYxeWxIBrpUMUMl4D2kFMGb4Nbjxlg2lZMEB+OFfR/xm2IXkYZ3g3kXFWWCRHiqe1
         kxoF18Gnv82qVyo8uF+eyUdBbAY+JlWN13aMlFIxE/wzgeeZpwGqxU551GPmj+bhZc24
         Cmfw==
X-Gm-Message-State: AOJu0Yypzj70tTItgiY7WkkY9SXiMIybARi45PurOo9pCgpy8i4krV48
	VfuVVX7Hz+qWg0gRueCjF08E1LWKxHnM9uGtzzeZsHgUvpOnej50JgI3Fs/ue++4SIVzYnRCSqk
	B4ZicRMJfa3VEQd4xHq5ZtvdAmTHu
X-Received: by 2002:a05:6870:8a10:b0:1fa:f404:b958 with SMTP id p16-20020a0568708a1000b001faf404b958mr36163522oaq.3.1704328775964;
        Wed, 03 Jan 2024 16:39:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFSVUswUiylI478qJKaqNmhm6PIilw9fYFwxgvwcVBLJc+FdCV35g7f1hPCbqCZKpZfQRIj+A==
X-Received: by 2002:a05:6870:8a10:b0:1fa:f404:b958 with SMTP id p16-20020a0568708a1000b001faf404b958mr36163514oaq.3.1704328775707;
        Wed, 03 Jan 2024 16:39:35 -0800 (PST)
Received: from [172.31.1.12] ([70.109.152.76])
        by smtp.gmail.com with ESMTPSA id z27-20020a05620a261b00b007811b8e3ff5sm10680889qko.48.2024.01.03.16.39.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jan 2024 16:39:35 -0800 (PST)
Message-ID: <382a47bb-7d7d-4ed6-bbe2-3afad19480fe@redhat.com>
Date: Wed, 3 Jan 2024 19:39:35 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] reexport/{fsidd,reexport}.c: Re-add missing includes
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>, linux-nfs@vger.kernel.org
Cc: Giulio Benetti <giulio.benetti@benettiengineering.com>
References: <20231205223543.31443-1-pvorel@suse.cz>
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20231205223543.31443-1-pvorel@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/5/23 5:35 PM, Petr Vorel wrote:
> Older uClibc-ng requires <unistd.h> for close(2), unlink(2) and write(2),
> <sys/un.h> for struct sockaddr_un.
> 
> Fixes: 1a4edb2a ("reexport/fsidd.c: Remove unused headers")
> Fixes: bdc79f02 ("support/reexport.c: Remove unused headers")
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
Committed... (tag: nfs-utils-2-7-1-rc3

steved.
> ---
> Changes v1->v2:
> * Add also <sys/un.h>
> 
>   support/reexport/fsidd.c    | 2 ++
>   support/reexport/reexport.c | 1 +
>   2 files changed, 3 insertions(+)
> 
> diff --git a/support/reexport/fsidd.c b/support/reexport/fsidd.c
> index 8a70b78f..51750ea3 100644
> --- a/support/reexport/fsidd.c
> +++ b/support/reexport/fsidd.c
> @@ -7,6 +7,8 @@
>   #include <dlfcn.h>
>   #endif
>   #include <event2/event.h>
> +#include <sys/un.h>
> +#include <unistd.h>
>   
>   #include "conffile.h"
>   #include "reexport_backend.h"
> diff --git a/support/reexport/reexport.c b/support/reexport/reexport.c
> index 0fb49a46..c7bff6a3 100644
> --- a/support/reexport/reexport.c
> +++ b/support/reexport/reexport.c
> @@ -7,6 +7,7 @@
>   #endif
>   #include <sys/types.h>
>   #include <sys/vfs.h>
> +#include <unistd.h>
>   #include <errno.h>
>   
>   #include "nfsd_path.h"


