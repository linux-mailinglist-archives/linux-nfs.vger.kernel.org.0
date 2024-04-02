Return-Path: <linux-nfs+bounces-2602-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95652895993
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Apr 2024 18:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B20D1F2464B
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Apr 2024 16:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02BC714B08B;
	Tue,  2 Apr 2024 16:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bLzSbLbE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603BA14C5A3
	for <linux-nfs@vger.kernel.org>; Tue,  2 Apr 2024 16:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712074847; cv=none; b=KUDeOhVbIE/9DjUQ+J6vX2Y4Fd68Dg/AA+o3yMLbzimKGWDMTwRUDdkkknbeX6X7ROhC6hxmK7ayHYlxbb7NXSsGJYcK1Le2V7A8pH18tMmFtiewB+qDJZqf9M9yFYZbm1dRtLJDBLYBTSuPJ52aTHKuunE+idvhBDCTCwG1LG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712074847; c=relaxed/simple;
	bh=45vXkl/rcYv+94xcyIDIR6W02nIABWxNGfXAOetVs54=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HwrqvFudZzEJFJ3kP8D8kW5Y9mOIRaak70t1ZnHpuE0qyaKODnzGa/3jeA9kqVP8UzC05aOYWTOTe3RtCu4WQIttb7YT492aaJsNXzlc0opraR6rWCNefTIf1RVAC9qB7ipgBHVgGOjtrhP2l+1Z7HnWkTsHYzA1+Nbnh4EdMwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bLzSbLbE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712074845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x5Nzy2/q23qrlyr0SuAObpcRnYE3MZof6+YbCc/4IBs=;
	b=bLzSbLbEJxy5A5zWaiSSQIoA+eeHiDnoDTA/HOSThIWjmHa4cgAxtIhWey8RIcUffg1nZ/
	C5xgW0AAo2zW6kfStRjjpGJSvwW6HMKRtEdElA0TZ9uzaCKlcnIEljLIOqijuxAP218s6h
	6YSSjB4LJS3Zn0yuJcHJUME/2FEaFlw=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-6zP_L9HfNCGMfk9TXGY9pQ-1; Tue, 02 Apr 2024 12:20:44 -0400
X-MC-Unique: 6zP_L9HfNCGMfk9TXGY9pQ-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-78d346eeb02so5784885a.1
        for <linux-nfs@vger.kernel.org>; Tue, 02 Apr 2024 09:20:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712074842; x=1712679642;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x5Nzy2/q23qrlyr0SuAObpcRnYE3MZof6+YbCc/4IBs=;
        b=QI60ZZ2XmhmsFAikPDQYK5dwCDZFCi47SZor1V3DiLXKX+vPkbNTLEWchaHHM6aEee
         uj/lpRpEWdJtl6mfUojfEobacu+5Xzk381Q6puZVfZClClHXhIdky7nbB8wV9N3VEXAs
         gL97wGklDho6P0NjQ7YQeFMglP7D7dGrHYt7V1xEQS93egu8wc+y/htG1jNGsJS91OSN
         VDMP8lTksZHtXjwJBBoOmDTAHEScyFCVcsx4AZKjuWk0Tt+jTcNENa5R5g7ErgzOVal+
         46RRPBc4fYts3SzaElmdeMw2LfuNJGLNawK+XVw9Del61Uy1PZnQIvkFGB1SxC889D/V
         fPGw==
X-Gm-Message-State: AOJu0YyLG+p1E5j7nEm9zfpwRX5SSsVWGY34VI//ZA1Hn1IR0y6ue+Kp
	NgvwKV1aEx9W22je1Lts/3EQ5PyNFWr4JfH2vxy/Ui8c/hXcaPxi/gX8ZY3rBiaMbg1UYBsh6du
	CGFUFwSU9MIG8gBiNavb8d4k/+RZgiACSNPI0rceZcllP/8/lpGXQIHD0prdnAOZIcA==
X-Received: by 2002:a05:620a:1a87:b0:78d:3570:488d with SMTP id bl7-20020a05620a1a8700b0078d3570488dmr393317qkb.3.1712074841755;
        Tue, 02 Apr 2024 09:20:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWgzjLXvwXF7LMpH/vcYAagL4ifZbwUJIfbEBh200PPCItShAtW+Amj6jK0MeTgt14IyuR1g==
X-Received: by 2002:a05:620a:1a87:b0:78d:3570:488d with SMTP id bl7-20020a05620a1a8700b0078d3570488dmr393308qkb.3.1712074841469;
        Tue, 02 Apr 2024 09:20:41 -0700 (PDT)
Received: from [10.19.60.48] (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id q13-20020a05620a0c8d00b00789e800c204sm4415086qki.62.2024.04.02.09.20.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Apr 2024 09:20:40 -0700 (PDT)
Message-ID: <ac34a186-68d2-41c6-b350-2f0d425eb156@redhat.com>
Date: Tue, 2 Apr 2024 12:20:39 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [nfs-utils PATCH] mount: reject "namlen=" option for a NFSv4
 mount
To: Chen Hanxiao <chenhx.fnst@fujitsu.com>
Cc: linux-nfs@vger.kernel.org
References: <20240322103618.1270-1-chenhx.fnst@fujitsu.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20240322103618.1270-1-chenhx.fnst@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

On 3/22/24 6:36 AM, Chen Hanxiao wrote:
> namlen is not a valid option for NFSv4.
> Currently, we could pass a namlen=xxx in a NFSv4 mount,
> the mount command succeed and namlen is ignored silently
I'm not sure it makes senses to fail a mount for
a parameter  that is ignored. Maybe throw a warning
that the par is being ignored...

What problem did this patch solve for you?

steved.

> 
> # mount -o vers=4,namlen=100 192.168.122.19:/nfsroot /mnt/ -vvv
> mount.nfs: timeout set for Fri Mar 22 14:22:18 2024
> mount.nfs: trying text-based options 'namlen=100,vers=4.2,
> 	   addr=192.168.122.19,clientaddr=192.168.122.15'
> 
> This patch reject "namlen=" option in a NFSv4 mount.
> 
> Signed-off-by: Chen Hanxiao <chenhx.fnst@fujitsu.com>
> ---
>   utils/mount/stropts.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/utils/mount/stropts.c b/utils/mount/stropts.c
> index dbdd11e7..028ff6a6 100644
> --- a/utils/mount/stropts.c
> +++ b/utils/mount/stropts.c
> @@ -780,6 +780,15 @@ static int nfs_do_mount_v4(struct nfsmount_info *mi,
>   		goto out_fail;
>   	}
>   
> +	if (po_contains(options, "namlen")) {
> +		if (verbose) {
> +			printf(_("%s: Unsupported nfs4 mount option(s) passed '%s'\n"),
> +				progname, *mi->extra_opts);
> +		}
> +		errno = EINVAL;
> +		goto out_fail;
> +	}
> +
>   	if (mi->version.v_mode != V_SPECIFIC) {
>   		char *fmt;
>   		switch (mi->version.minor) {


