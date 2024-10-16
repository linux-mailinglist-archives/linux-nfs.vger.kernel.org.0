Return-Path: <linux-nfs+bounces-7205-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7022B9A0D6C
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Oct 2024 16:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A20141C23712
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Oct 2024 14:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6104220E034;
	Wed, 16 Oct 2024 14:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BPRvQ7EY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46B620F5A4
	for <linux-nfs@vger.kernel.org>; Wed, 16 Oct 2024 14:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729090389; cv=none; b=Y3YSOxQgT5ZGB8hD3xKEj55VDeIAuwu/o7406syrXDL/GG6GSm98uWuHd6Gh5YylOr7UNzTPodi7R4s0n6X+Zh4s7f6v5ckA3uBQRAabflfDV52hu25+CVFCFh0F6LE2ew7pnnNBwVRy8ghZPiSp8OXSHYw0HbV4V7bfrB6+oj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729090389; c=relaxed/simple;
	bh=roiJS00kFrlem/SNvblbGRCKRxdxVq5bUoICJl7bw/U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jInrPlueXMQ5UJ7/OG6utDJuMtRfMRAbAcoGC7XMtIACTMUa6cft0TXypL4Ev1G8SZkUyt/D1yRiuRLx7rWl4fQXSbz2Xig/Zc2WDVIFDnjPd++GWtOxvaknRx7Hux40szTX2LGnJben5GBRb7Qp8UbNWRC3d4qc0mWVuUiY+qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BPRvQ7EY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729090386;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CNxJqq7rV31+2+DtZfbZyziK3/pMm9iusk3GAAtb2vo=;
	b=BPRvQ7EYomdwdcssQ0RZdwZGNfGkZkuUPlwR8EigeCAHSVTqJP6N1zBBhCFwJM2ad1c2R2
	hdZgXskLBEOUbHb50j5Xk+BmhiSiLNSoV0hv2ALDPLax5Hy2f+L+8jn0njnJQ0cVe3iO5K
	raVSjy/rQeb4Fvfo3Tq7du4Ay8q9wPk=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-0jQQ-DMsPLqMlIf3ObGzlQ-1; Wed, 16 Oct 2024 10:53:05 -0400
X-MC-Unique: 0jQQ-DMsPLqMlIf3ObGzlQ-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7b119d20b46so1186161585a.1
        for <linux-nfs@vger.kernel.org>; Wed, 16 Oct 2024 07:53:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729090383; x=1729695183;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CNxJqq7rV31+2+DtZfbZyziK3/pMm9iusk3GAAtb2vo=;
        b=DYVEeSbUrQhqfYER6mNlEFflwXjdclw+lUuDFiOIwPf5gPEcR6pHjdIsRNL6wcHS1T
         N60LlFUVD/n5vwtYlfioKpSdNNwuAqAvJbuoE6ItzKwFK4xBoc9BPLtizREvE8NEYgPX
         gwQ9ZBSCBRoGM5gI6UDWb5A/4jZQJFEI4TK601tYxlFrN8WxpqVsyoNs1MyOirn7kxVJ
         x565U4CnulRbtDY4cPU3kUmAEb77AC4swVsulS7ioPeZRzXZpVODha2P2TaZpRAE1HTM
         4ZVva+PRASSqowXSrkM0S2IBAESWolKvZXHRaeAPewDKCHxgo4z2OHGg2TA06AiDMvA0
         GPoA==
X-Gm-Message-State: AOJu0YybCbkNoYOXl8FDT7af0QGvCYbiO2rh7hexR1IvWq+SWLQRTg5r
	AuxUvvOn6Vq2PmR70FNiipQC7DP2tErzLfPXET4L/3p/REFeyNrUAsMdni+9yU4n4iSvj4IO7u1
	sEXG6whdr51rE4ny2kXrB4DUEFyY+HDOLLoIVw46dKIoAc8DkZKpZvofsYILxI7llgw==
X-Received: by 2002:a05:620a:4446:b0:7af:ce6e:1663 with SMTP id af79cd13be357-7b12101be7bmr2079249985a.60.1729090383049;
        Wed, 16 Oct 2024 07:53:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDeHExcS+ZMliSzoibLiiyHkys/KtqDuIYMcCMBHXx0AyjwfaeK+GvUywypdDx2oyEfyuLZQ==
X-Received: by 2002:a05:620a:4446:b0:7af:ce6e:1663 with SMTP id af79cd13be357-7b12101be7bmr2079247685a.60.1729090382709;
        Wed, 16 Oct 2024 07:53:02 -0700 (PDT)
Received: from [172.31.1.12] ([70.109.132.202])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b1363b65b8sm196706885a.121.2024.10.16.07.53.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2024 07:53:02 -0700 (PDT)
Message-ID: <3f266a7c-e8d5-4e3f-b679-af06cf8b3b11@redhat.com>
Date: Wed, 16 Oct 2024 10:53:01 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] svc_fd_create: skip getsockname on a non-network socket
To: Chen Hanxiao <chenhx.fnst@fujitsu.com>,
 libtirpc-devel@lists.sourceforge.net
Cc: linux-nfs@vger.kernel.org
References: <20241014085525.2067-1-chenhx.fnst@fujitsu.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20241014085525.2067-1-chenhx.fnst@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/14/24 4:55 AM, Chen Hanxiao wrote:
> As svcfd_create(3) said, it can:
> Create a service on top of any open file descriptor.
> 
> But getsockname and getpeername in svc_fd_create assume that
> fd should be a connected socket.
> 
> This patch will leave xp_raddr and xp_laddr uninitialized
> if fd is not a connected socket.
> 
> Signed-off-by: Chen Hanxiao <chenhx.fnst@fujitsu.com>
Committed... (tag: libtirpc-1-3-6-rc3)

steved.
> ---
>   src/svc_vc.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/src/svc_vc.c b/src/svc_vc.c
> index 3dc8a75..438cbc5 100644
> --- a/src/svc_vc.c
> +++ b/src/svc_vc.c
> @@ -59,6 +59,7 @@
>   #include <rpc/rpc.h>
>   
>   #include "rpc_com.h"
> +#include "debug.h"
>   
>   #include <getpeereid.h>
>   
> @@ -232,6 +233,12 @@ svc_fd_create(fd, sendsize, recvsize)
>   
>   	slen = sizeof (struct sockaddr_storage);
>   	if (getsockname(fd, (struct sockaddr *)(void *)&ss, &slen) < 0) {
> +		if (errno == ENOTSOCK) {
> +			if (libtirpc_debug_level > 3) {
> +				LIBTIRPC_DEBUG(4, ("svc_fd_create: ENOTSOCK, return directly"));
> +			}
> +			return ret;
> +		}
>   		warnx("svc_fd_create: could not retrieve local addr");
>   		goto freedata;
>   	}


