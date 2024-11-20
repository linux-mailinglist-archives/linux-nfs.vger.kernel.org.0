Return-Path: <linux-nfs+bounces-8166-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 563B09D434B
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Nov 2024 21:56:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DE161F2180F
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Nov 2024 20:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9479413C695;
	Wed, 20 Nov 2024 20:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bJNjaHN/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA02716DED2
	for <linux-nfs@vger.kernel.org>; Wed, 20 Nov 2024 20:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732136178; cv=none; b=j3Dz3nTqjo2djB3uwLCdIwlknYtVha3mFW9SJjyvx4X2SrrWN9WOR1RGvo093DHocZqx+HXXTLqZA3+NT1fAZ9CQRThmxsg483PbT0qNF0DeGohZUzqHqKGW5K+mIyg9gny7UujZF240d8CW94UOHTmzrE1QOntLQvq1vWM2dPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732136178; c=relaxed/simple;
	bh=CNfaBOoLSnr9vncx7NT8aWW9K0aISwHgyFLMpuNKe94=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=HYY/UEWB/tC4C8/PvqBY0nvA616vZVLVTLu95Q/g2029B/jkE7wTr5wk+qwimfGz4LYSwLVW6o3RlsGZ6gt/gSEo1Y17aBD049YWDH0vftqBhIsDjAeSfjuhTwooFHEEPxn2WlLOJdyykLLCaAOG/P9ZZ9O87VbVexzWMTUKm2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bJNjaHN/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732136175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A9r4Y5Ro7EwjenHPs525itthvfiyqpyE3ePj0hb1Fws=;
	b=bJNjaHN/wAPEElvBJ0RpMoD1g8pZuM+3l1T1bhZCA/Lq4cTU4D9Gvuqihmqlajx1aEKVuI
	J3NUPomgqoj6Akg8ljeki6QjnzgunlDA+xSr2Wp16dndVSPWIOVnrGnV2VbSazxeOj0eaH
	G8n+COquPMqLCflkewwLcEAIKGvrw6c=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-SIG-M-O2MEqHk9iXnczxaw-1; Wed, 20 Nov 2024 15:56:14 -0500
X-MC-Unique: SIG-M-O2MEqHk9iXnczxaw-1
X-Mimecast-MFC-AGG-ID: SIG-M-O2MEqHk9iXnczxaw
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a763f42b35so1017275ab.1
        for <linux-nfs@vger.kernel.org>; Wed, 20 Nov 2024 12:56:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732136172; x=1732740972;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A9r4Y5Ro7EwjenHPs525itthvfiyqpyE3ePj0hb1Fws=;
        b=XLTZRaVDnCPfHYk4mq5We6kC778ygg1iXGguWNHDYHmyRO/yiwZrXd3wrdZLJbmrUs
         hyZwGbB+TCzBh1eNfLvsSk4yKmg+FapjqfImhELOc7w1uUwG56hC0PZrvFC9pxCitOTZ
         +3IZSZtX9JhXsL/tSSEQ+2lOae23XOnhzVxg1vS4025ge8KI0yxvW7UGfkP0TF6TOzKL
         soXcfzs4wX4rk2D7/6bi6nj9WDM+pz5bp34f8wpDSWYurvD+C1uBkjU5iEU2k8DBW1Yu
         uHS2/dV3wg77/D5eZ413LzIBDLoEGII482kT8umGzt2ns82coKdoCwXywshmFXZZ838o
         MUQg==
X-Gm-Message-State: AOJu0Yw6UbBrWy2zzGfvpJrr160pXiVr77BB3k4jPvw5tFpi6BbyfKRl
	GJOKAwWVSyFpLQTegmsEwR6JfN+qDtMvTq3J66Er0czXeZ/uQSTkw+2xASNlbuXQBLepcGp8hmU
	GMJhuNw2/amdfLS8IQk5nRL2nryi6D0apsczByGn8QbnvkEHx4feuLZEFjKp/akmPk5n+uPy/yN
	ZQgdNLqgCuJBlC7d1YCD1IF+JqM6TM/1yq287HrJQ=
X-Received: by 2002:a92:c24d:0:b0:3a7:776e:93fb with SMTP id e9e14a558f8ab-3a7864a9067mr54616375ab.8.1732136172732;
        Wed, 20 Nov 2024 12:56:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGRYImp8g6M7NWWggQ+LBEM6jeC8n5kKMGSxkXBEFpDvvg7Q7LBqSzffKJQCQa8JcGbYHj1kw==
X-Received: by 2002:a92:c24d:0:b0:3a7:776e:93fb with SMTP id e9e14a558f8ab-3a7864a9067mr54616125ab.8.1732136172406;
        Wed, 20 Nov 2024 12:56:12 -0800 (PST)
Received: from [172.31.1.12] ([70.105.249.243])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a777efbfc7sm11012075ab.52.2024.11.20.12.56.09
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2024 12:56:11 -0800 (PST)
Message-ID: <59ca2dd7-583f-4141-aef9-4acff857c957@redhat.com>
Date: Wed, 20 Nov 2024 15:56:09 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] nfs(5): Update rsize/wsize options
From: Steve Dickson <steved@redhat.com>
To: Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <20241119165942.213409-1-steved@redhat.com>
Content-Language: en-US
In-Reply-To: <20241119165942.213409-1-steved@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/19/24 11:59 AM, Steve Dickson wrote:
> From: Seiichi Ikarashi <s.ikarashi@fujitsu.com>
> 
> The rsize/wsize values are not multiples of 1024 but multiples of the
> system's page size or powers of 2 if < system's page size as defined
> in fs/nfs/internal.h:nfs_io_size().
> 
> Signed-off-by: Steve Dickson <steved@redhat.com>
Committed... (tag: nfs-utils-2-8-2-rc2)

I know we are still discussing this but I think
this version is better than what we have.

So update patches are welcome!

steved.
> ---
>   utils/mount/nfs.man | 24 +++++++++++++++---------
>   1 file changed, 15 insertions(+), 9 deletions(-)
> 
> V2: Replaced PAGE_SIZE with "system's page size"
> 
> diff --git a/utils/mount/nfs.man b/utils/mount/nfs.man
> index 233a7177..eab4692a 100644
> --- a/utils/mount/nfs.man
> +++ b/utils/mount/nfs.man
> @@ -215,15 +215,18 @@ or smaller than the
>   setting. The largest read payload supported by the Linux NFS client
>   is 1,048,576 bytes (one megabyte).
>   .IP
> -The
> +The allowed
>   .B rsize
> -value is a positive integral multiple of 1024.
> +value is a positive integral multiple of
> +system's page size
> +or a power of two if it is less than
> +system's page size.
>   Specified
>   .B rsize
>   values lower than 1024 are replaced with 4096; values larger than
>   1048576 are replaced with 1048576. If a specified value is within the supported
> -range but not a multiple of 1024, it is rounded down to the nearest
> -multiple of 1024.
> +range but not such an allowed value, it is rounded down to the nearest
> +allowed value.
>   .IP
>   If an
>   .B rsize
> @@ -257,16 +260,19 @@ setting. The largest write payload supported by the Linux NFS client
>   is 1,048,576 bytes (one megabyte).
>   .IP
>   Similar to
> -.B rsize
> -, the
> +.BR rsize ,
> +the allowed
>   .B wsize
> -value is a positive integral multiple of 1024.
> +value is a positive integral multiple of
> +system's page size
> +or a power of two if it is less than
> +system's page size.
>   Specified
>   .B wsize
>   values lower than 1024 are replaced with 4096; values larger than
>   1048576 are replaced with 1048576. If a specified value is within the supported
> -range but not a multiple of 1024, it is rounded down to the nearest
> -multiple of 1024.
> +range but not such an allowed value, it is rounded down to the nearest
> +allowed value.
>   .IP
>   If a
>   .B wsize


