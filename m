Return-Path: <linux-nfs+bounces-2758-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B06D8A1C52
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Apr 2024 19:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A5FC1F2896C
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Apr 2024 17:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F74715FA62;
	Thu, 11 Apr 2024 16:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MsYD6bOc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EDD160792
	for <linux-nfs@vger.kernel.org>; Thu, 11 Apr 2024 16:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712852213; cv=none; b=Cj/+JCY4utJVvuj35bzF5Fy3zb+KI90qEakMLLweO5x22Fgb5FYvRpAnfL0F1VBABVNxTbwbdAw02qT/t3Wy8Oib3cXpR8VpfSSOsOd4wkZ67tPC/TMgJMineNU7QRprtHgCK5oxItL4Wwsh/XFtcCMltYMcJLE81/Uoj/3vxJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712852213; c=relaxed/simple;
	bh=QB7zYTQh+xxUqKb5jxn+o68FXj6tF8CQ365Cd1AS6FY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=npNqZB/zM5+yy8QBdfc/jVH0byo9uB8wfr1u0QN4DpwbXpT5BRRgSrypehR+KZoQmY7Q37+Xn7BrK+uikJXqqZldyFXuS3HYm+cvr3SYseeMkh5MO/584MFIWYcZFbeW3Cj4Rvem50KK0sy8srHALgEV7jGbLrzrpqiAj9B5Rh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MsYD6bOc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712852209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xTIj/FzZMBNWkbPn2rtDWCjPPG9a/0ySNlLubc6G/pU=;
	b=MsYD6bOcjV8kvggh8Sra92oqMEoZhs0r0uPbhqlTGLStTyNlWo8zz+mhBF45Jjl2BJ+sh0
	hnKjrISGRNF05i8Bgbo3dYW4BV3y0lOR9qTxKlRjDj5lD5FnNnScb40HHerbro/UuUfPiD
	gwuKZobfGZDh2B0N9rQxRmEE/vFJ6VY=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-oibKdQSGOnGpOUI-bEbW7g-1; Thu, 11 Apr 2024 12:16:48 -0400
X-MC-Unique: oibKdQSGOnGpOUI-bEbW7g-1
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-6eb5585d6daso17687a34.0
        for <linux-nfs@vger.kernel.org>; Thu, 11 Apr 2024 09:16:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712852207; x=1713457007;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xTIj/FzZMBNWkbPn2rtDWCjPPG9a/0ySNlLubc6G/pU=;
        b=O2yFu21E2xGUiJkepJQVk5+0K7nbF8ByhqRmyetAK1h+1LYNYNtfUxL01HbT6GwiTh
         pd3qWaBbNRUT8C3G29rfaM7NJSVx1l0txKCMbVLXAObzXBq5XVQYnBWsPQopSg/wSdv0
         XDmGXxCCrKFjzbsobNp8X/cRbU3Anjg3FxLHRvWun0xzPFBIg1umKI0HYlbmf5qJggiy
         Wi6D6KNEp+XwHOVHuMSWaYz2zV/rr5gfo1IEBWQr2ocEMGoYCF3YtF14eYUTBzTiL+BA
         WkF8XAZsBQUfR6C6RyqmdBMb6Zatv5BK6gb/uQOjPJy49QyQ1Ixs3OQ3PF2kjmYMHtp9
         Hc3w==
X-Gm-Message-State: AOJu0YyPntgge2ivMqsCQG8sHKy/qmE5y/BBjb+5DjmE4Yre1f/3BsWH
	oldS0KGEFQkml5lH9Bhey8hco2lQ+o07H5YEKB9vPyD7vvMBqJF3MtwfyAdHGeGiYXW8KQF/pzx
	P9wlyFNh/t0JIT0rA0TeZHPLkHCQqixnwHlcEn+TbXJywELYwdTZrZ9/sDdrW2F4ETg==
X-Received: by 2002:a9d:6f10:0:b0:6ea:bc18:a04c with SMTP id n16-20020a9d6f10000000b006eabc18a04cmr70610otq.3.1712852206802;
        Thu, 11 Apr 2024 09:16:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCn23zsLpN1QV/mOhljevCOBXZ7ebnO73iKL9pXswoMXkaSG6hcER6oes7nLWlroBMwpBKHg==
X-Received: by 2002:a9d:6f10:0:b0:6ea:bc18:a04c with SMTP id n16-20020a9d6f10000000b006eabc18a04cmr70589otq.3.1712852206481;
        Thu, 11 Apr 2024 09:16:46 -0700 (PDT)
Received: from [10.19.60.48] (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id f17-20020ae9ea11000000b0078ec846066fsm245199qkg.7.2024.04.11.09.16.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 09:16:45 -0700 (PDT)
Message-ID: <662267b6-f27c-41e7-9df1-7915f4448127@redhat.com>
Date: Thu, 11 Apr 2024 12:16:45 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [nfs-utils PATCH] mount: warning "namlen=" option for a NFSv4
 mount
To: Chen Hanxiao <chenhx.fnst@fujitsu.com>
Cc: linux-nfs@vger.kernel.org
References: <20240403070228.308-1-chenhx.fnst@fujitsu.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20240403070228.308-1-chenhx.fnst@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/3/24 3:02 AM, Chen Hanxiao wrote:
> namlen is not a valid option for NFSv4.
> Currently, we could pass a namlen=xxx in a NFSv4 mount,
> the mount command succeed and namlen is ignored silently
> 
> # mount -o vers=4,namlen=100 192.168.122.19:/nfsroot /mnt/ -vvv
> mount.nfs: timeout set for Fri Mar 22 14:22:18 2024
> mount.nfs: trying text-based options 'namlen=100,vers=4.2,
> 	   addr=192.168.122.19,clientaddr=192.168.122.15'
> 
> This patch will remove "namlen=" option in a NFSv4 mount,
> and give a warning message in verbose mode.
> 
> Signed-off-by: Chen Hanxiao <chenhx.fnst@fujitsu.com>
Committed... (tag: nfs-utils-2-7-1-rc6

steved.
> ---
>   utils/mount/stropts.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/utils/mount/stropts.c b/utils/mount/stropts.c
> index dbdd11e7..a92c4200 100644
> --- a/utils/mount/stropts.c
> +++ b/utils/mount/stropts.c
> @@ -780,6 +780,14 @@ static int nfs_do_mount_v4(struct nfsmount_info *mi,
>   		goto out_fail;
>   	}
>   
> +	if (po_contains(options, "namlen")) {
> +		po_remove_all(options, "namlen");
> +		if (verbose) {
> +			printf(_("%s: Ignore unsupported nfs4 mount option 'namlen' in '%s'\n"),
> +				progname, *mi->extra_opts);
> +		}
> +	}
> +
>   	if (mi->version.v_mode != V_SPECIFIC) {
>   		char *fmt;
>   		switch (mi->version.minor) {


