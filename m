Return-Path: <linux-nfs+bounces-2171-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF0587078D
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Mar 2024 17:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58E32B25944
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Mar 2024 16:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2EC5CDDD;
	Mon,  4 Mar 2024 16:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bezIgHC2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415915BAFA
	for <linux-nfs@vger.kernel.org>; Mon,  4 Mar 2024 16:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709571083; cv=none; b=e4Icv35b86Bp+q57CjSnF+bA2VZAT+DziseWtbwi0X7k+1x3LjbSeFajTsIQR3p4tl4vZpZmvvWqvFREW+47a8gCj1Nx37q3kfzbaa7B3Rr0nlMxUZtKyIquKwDU/EGJd0Wqr5zkftIGVmT2VwvgCfRrpAVevKEZfz7JW8t+7gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709571083; c=relaxed/simple;
	bh=K0/sCPkroJJFUs6+em+SR3CTnjuz37K2qtCwvl54JRo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JkUmqMntl+lVPP3z/Z4rIxksZBvd/RXHvmOky8k+q5URqSwt4MA6Yhp+8GL8g35WlZowjOE/qth6PEPWV4WXGtrF+tS3Ywwa8AIjJktCzUmpIEPq9sD3NRZ3Cfe6T0vVwN3F2Cpk8kvj2oq1PMFrTHYysJFP+qO1lmt04COili0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bezIgHC2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709571081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zW+DW+eXj2ZOUenUXkguceoutSIVgqfCaRHH4SRgQ48=;
	b=bezIgHC2DQZIHx0Ej+O2R0iFGK1pTRL6iHwkA3MjNgZCzNzTyW2BeKnAMo/koPaSt2dEvW
	FDFpTySi2QhskxMzn934HctmZpoY7uN81IeDw8xFe9jtT7R933uEbbKey9j4hR/PiOYpFl
	mD4R0oyyEQ2Fv2JGGOpLEaftUChtfN0=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-18-g3RBlbD-OveO95T6kWKniA-1; Mon, 04 Mar 2024 11:51:19 -0500
X-MC-Unique: g3RBlbD-OveO95T6kWKniA-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-68fba33cae0so6641646d6.1
        for <linux-nfs@vger.kernel.org>; Mon, 04 Mar 2024 08:51:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709571077; x=1710175877;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zW+DW+eXj2ZOUenUXkguceoutSIVgqfCaRHH4SRgQ48=;
        b=EmU0sTEdhHyTpm+hnGGVz78eAf+rErMbhoxQQyyNiQ/L+6lu4DFzxFT53mBquSie+2
         BrCIa2FI+KJIuuVBQmaahgkn7eyuVW0YclzJ2I8EWGUKV2Lj9sX/PVWMVfMWLn46PlHd
         Y4qosRVcrns8juTzFzZTxl0TM0z3keGAwrEHwV3Jz67/RZQfqIpDhYiY7DrTUMyfpZMi
         szgcMuYJ63YXFPGW8RjWqVjOpp6A1AJ8rRdN0lrqtFXbxRz+HEJ9rjqOmkhqa91G7g4e
         axPACduYsyGoIF4y6wcWKcByig58M1uFDASsaampofdaXcw3/cqVs/jDw2UYgs4ifN3y
         IJHQ==
X-Gm-Message-State: AOJu0Yz3cW9cpwBv0Zam5H5G9kKuSsxNjShDvSwpnMNDFY0P39allCoY
	6c0RIFsywYncZtO5k34sXbHg6Ti8uNsXNrDNszx8QwsfJx6Pt5NQfnEqbvANk96RPpyg3UeG5hf
	fYSNCSa+HthkDAA3kICjd+3v6AjgJj3CgcKQH+OygsVneQdpUdlvM70Oj9+LiwBeaEw==
X-Received: by 2002:a05:6214:3012:b0:68f:6000:6ac5 with SMTP id ke18-20020a056214301200b0068f60006ac5mr11120739qvb.4.1709571077704;
        Mon, 04 Mar 2024 08:51:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF7WRtqee84bZYEqJ4WD6TsVcj4VjGx4f2nropu1FRbSyFlaXViTpEKaE3c+5+9SLhiSt6fRA==
X-Received: by 2002:a05:6214:3012:b0:68f:6000:6ac5 with SMTP id ke18-20020a056214301200b0068f60006ac5mr11120720qvb.4.1709571077412;
        Mon, 04 Mar 2024 08:51:17 -0800 (PST)
Received: from [172.31.1.12] ([70.109.163.43])
        by smtp.gmail.com with ESMTPSA id jh19-20020a0562141fd300b0068fef023e6esm5279442qvb.88.2024.03.04.08.51.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 08:51:16 -0800 (PST)
Message-ID: <b4b4d325-f15f-4fb3-a52c-c3f39d56018a@redhat.com>
Date: Mon, 4 Mar 2024 11:51:15 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4 rpcbind] Supprt abstract addresses and disable
 broadcast
Content-Language: en-US
To: NeilBrown <neilb@suse.de>
Cc: linux-nfs@vger.kernel.org, Petr Vorel <pvorel@suse.cz>
References: <20240225235628.12473-1-neilb@suse.de>
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20240225235628.12473-1-neilb@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hey Neil,

My apologies on addressing this...
Too much PTO :-)

On 2/25/24 6:53 PM, NeilBrown wrote:
> The first two patches here I wrote some years ago but never posted - sorry.
> The third and fourth allow rpcbind to work with an abstract AF_UNIX
> address as preferentially used by recent kernels.
> 
> NeilBrown
> 
> 
>   [PATCH 1/4] manpage: describe use of extra port for broadcast rpc
>   [PATCH 2/4] rpcbind: allow broadcast RPC to be disabled.
You realize that the broadcast code is configured out by default
./configure  --help | grep rmt
   --enable-rmtcalls       Enables Remote Calls [default=no]

So do we want to introduce a flag and man page section
for something that is off by default?

steved.
>   [PATCH 3/4] Listen on an AF_UNIX abstract address if supported.
>   [PATCH 4/4] rpcinfo: try connecting using abstract address.
> 


