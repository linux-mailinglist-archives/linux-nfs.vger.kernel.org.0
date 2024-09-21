Return-Path: <linux-nfs+bounces-6589-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB68A97DE5A
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Sep 2024 20:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 796811F21879
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Sep 2024 18:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D9CD2A1C5;
	Sat, 21 Sep 2024 18:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IYi7hyZW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A0621345
	for <linux-nfs@vger.kernel.org>; Sat, 21 Sep 2024 18:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726944142; cv=none; b=d9PWB0tjOBcA6wAX6/b0fWG0yZ2ElQh3kUu6eoYMCJcXp2vtnDVQEuip/5zathFnM4QGNbmJTP2sLLcFq0j8JGwVk3HLxuWWs8gFE9s/a6Bcor+YNaqi3xKIayma0XvLRmk2f/MeS5B180+7+cO5fvXn7XYhmNFHilktLs67oCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726944142; c=relaxed/simple;
	bh=H22AMj5Kjg4ek99f1d8GqRRAS5N3gO8Dt6FqUukkwag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VvXMhfTYDcgEFybulVPQkr5qmpCdW4miAZt946yfsGZSbF2+xAvPNHBKRgJMC2dbQEAMCcDykbjNIf4umLRPRB/tpgToD8lAzXsLty9Z+hFOSse7JwJMJce2ewd+7xEEzUruiQkB/gkn+M4i4dcRduxyuv8+TS+0f11//A5ZkgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IYi7hyZW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726944138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WY9w9X16vrwU+AlRxsmWH5nrzsLSG2RDZaUw/RZIhqs=;
	b=IYi7hyZWdUdoBuBDAJZily1+bj9Xgy5TTdKdu61gcKkoL1nV1y/0xvYHDENQoWkFZhrPhn
	mNVNCOWLugkJPwctQjOM8wkQO3/ToRD6tIvJewhUn3z5WiL1oZRI6hROp/FQDWFydU7eUS
	/+k2+a6pc0/72FQnBstklZC7LHqo+D8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-OXJLM3rmMh-VfApJHiQBhA-1; Sat, 21 Sep 2024 14:42:16 -0400
X-MC-Unique: OXJLM3rmMh-VfApJHiQBhA-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6c518ae847dso56199476d6.2
        for <linux-nfs@vger.kernel.org>; Sat, 21 Sep 2024 11:42:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726944136; x=1727548936;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WY9w9X16vrwU+AlRxsmWH5nrzsLSG2RDZaUw/RZIhqs=;
        b=ZjRDfUdB8gaZqdkIAsAcU+I+mMdKRHAAMQXlEoOgR9xQggSeE8CDYz4sRVhRrc0yvp
         JNam+Xmq6kf+/nNvAOUcVe8U9tjHIJhKKo3/nNpmHdybyzgS1qedn6F4pkkGNWcQvb0Z
         WnqtDBt8bh/kfCrC4XBxiuQvDcwRo803ST2yOKhxbfsOTYJ6CKrPtBO+d9bkVc3eqpO8
         AFMbsZwZXSTGTBjLc8Gb+u66seZCEMGhgpDS4fawMyqlOOSBV2f08wVC3o+6DlS3t7kA
         0StiNBsMh9SdjgmbgT/haBK3tFBDUMZcGCMEvWl9oJRti9jcfAqCEW5ag6PU6eWm4xQ9
         HKUw==
X-Forwarded-Encrypted: i=1; AJvYcCU4nHukof/Pv2SmxDJ2n4Mbw/R2iKQyz82hi51AaXswcFL8ppVjzLbpg/0J6LVzt+sOOaUVvGkSIlA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhL4zLlmCLrbnKDZUaIBDGN9ynWmImZoRsj8jjxHLGkVJBEQkT
	K+dFyAY+69O5t4E2U06MCwd1SKXtKyXSa7sQIfb5rLeXgBMYFVMqwhMzj+We86ijCx0qQs8WJad
	NWU6i0RtbguXT0uBFbZuNUrdNSvyNjLCvkx04zvLwNWLlT43QLRzyB91NjQ==
X-Received: by 2002:a05:6214:5543:b0:6c1:6e39:b697 with SMTP id 6a1803df08f44-6c7bd46c864mr105256066d6.9.1726944136034;
        Sat, 21 Sep 2024 11:42:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4OglFN0b4bvFdz0qTHg/O7TuWK6IRRkIWch+0ApQBuR1zApvp6bZf2ZdO+muN3ZZJOQRltQ==
X-Received: by 2002:a05:6214:5543:b0:6c1:6e39:b697 with SMTP id 6a1803df08f44-6c7bd46c864mr105255886d6.9.1726944135751;
        Sat, 21 Sep 2024 11:42:15 -0700 (PDT)
Received: from [172.31.1.12] ([70.105.241.244])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c75e4445bbsm31080816d6.12.2024.09.21.11.42.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Sep 2024 11:42:14 -0700 (PDT)
Message-ID: <6586da61-3e71-4af0-b41b-c441882d0f69@redhat.com>
Date: Sat, 21 Sep 2024 14:42:12 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: rpc.idmapd runs out of file descriptors
To: Salvatore Bonaccorso <carnil@debian.org>, Sergio.Gelato@astro.su.se
Cc: Kevin Coffman <kwc@citi.umich.edu>, Neil Brown <neilb@suse.de>,
 "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
References: <ZmCB_zqdu2cynJ1M@astro.su.se> <ZuU7S2Gli6oAALPJ@eldamar.lan>
 <e43aa92c-d91c-4931-b807-5edec649b2b4@redhat.com>
 <Zugkgr-Y5_2iyQFS@as-2866.astro.su.se> <ZuhR1bpMZmDWsNew@eldamar.lan>
 <ZuhovpK7Xhkuu3h9@eldamar.lan> <Zuh2aG50e-cg3h81@eldamar.lan>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <Zuh2aG50e-cg3h81@eldamar.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/16/24 2:18 PM, Salvatore Bonaccorso wrote:
> dirscancb() loops over all clnt* subdirectories of/run/rpc_pipefs/nfs/.
> Some of these directories contain /idmap files, others don't. nfsopen()
> returns -1 for the latter; we then want to skip the directory, not abort
> the entire scan.
> 
> Reported-by: Sergio Gelato<sergio.gelato@astro.su.se>
> Closes:https://lore.kernel.org/linux-nfs/ZmCB_zqdu2cynJ1M@astro.su.se/
> Link:https://bugs.debian.org/1072573
> Patch-originally-by: Sergio Gelato<sergio.gelato@astro.su.se>
> Signed-off-by: Salvatore Bonaccorso<carnil@debian.org>
Committed... (tag: nfs-utils-2-7-2-rc1)

steved.
> ---
> Changes in v2:
> - Fix typo in URL for Debian bug reference
> - Reorder patch tags and use Closes tag after Reported-by
> 
>   utils/idmapd/idmapd.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/utils/idmapd/idmapd.c b/utils/idmapd/idmapd.c
> index cd9a965f8fbc..5231f56d24a8 100644
> --- a/utils/idmapd/idmapd.c
> +++ b/utils/idmapd/idmapd.c
> @@ -556,7 +556,7 @@ dirscancb(int fd, short UNUSED(which), void *data)
>   			if (nfsopen(ic) == -1) {
>   				close(ic->ic_dirfd);
>   				free(ic);
> -				goto out;
> +				continue;
>   			}
>   
>   			if (verbose > 2)
> -- 


