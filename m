Return-Path: <linux-nfs+bounces-8895-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB93A00DA0
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Jan 2025 19:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E15B816440A
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Jan 2025 18:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4260F1FC7D8;
	Fri,  3 Jan 2025 18:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jLVl4nL6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C581FBEB5
	for <linux-nfs@vger.kernel.org>; Fri,  3 Jan 2025 18:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735929081; cv=none; b=uyIbvXYkIMgX5j8VbxJhr0tcBS66xD6idZclQfTD5aiOmrGfmcjq+ULdADXsbsxCTBGwY8vJwPpSstFZbtRaXdL1A2i7/W6NR3PTwLbq2WqYDV1SNl52ivKcOK84x+tl4MXypzE7sZnDNcvQDDSzsYkcG75QdaR9luEd5zIbUo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735929081; c=relaxed/simple;
	bh=Y5n5FYhuZlOCJQJonAhcHxUxSeKpmgk+FXlpFyksnzw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=QOiPuZDvl06LW5T3W2oCvAcb5UTkwLD4LMUA30I25OjGjk+qJ9azAxPU4rOJfHjhD03eNs0GtnKe+3hXKFrrQkbdAtrwbPR4/fHWr15T3dCKF3tXU9CtsAP4p7A9vzjkOG8gFwNEox2+CyQkPE6rWPg89GnJ3b2IUcksflUrXGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jLVl4nL6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735929077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xXdyAuwdJWo2/k+yjX5EjxTsHfLJvoguSQifqUTzsmU=;
	b=jLVl4nL6yklgqTLwij27l7FVk0LEnnbPfkZ2PJapO21AZ+IuTbc/9YQGkxoKKNOpZdRtEd
	dfws4pBwCTHefz9xnwGKCAUfvgxPv0gfrDWvrV+9LW8m1vDM98l7WXIHYV2Hrf1TvLkHoa
	50Q08Bvm1PY/QsO2HbF6NquzqHVZsAA=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179-JzqAcFeHMKi1dNGA0prMdA-1; Fri, 03 Jan 2025 13:31:15 -0500
X-MC-Unique: JzqAcFeHMKi1dNGA0prMdA-1
X-Mimecast-MFC-AGG-ID: JzqAcFeHMKi1dNGA0prMdA
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7b6e241d34eso1805193585a.0
        for <linux-nfs@vger.kernel.org>; Fri, 03 Jan 2025 10:31:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735929074; x=1736533874;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xXdyAuwdJWo2/k+yjX5EjxTsHfLJvoguSQifqUTzsmU=;
        b=xCdrQzCFWQAQVl/xpiLZwLo9+9+M0gGgU60ibDRLjuEsKv/tm2/I7qnUyapjvbzMY4
         viaLenaAZJsVKmzX7P5bMBNV5vuHrMtFQAdb5AiTcpjAtqe3UIihQQdU+DPqGWgeHvUe
         xEBTKgx5gfmzRs7LsGAmz9T5+RNIdbf0rWFULAarOtPfILJJ2aW4P55ZBAZyPdRjNl5H
         s0WpQTcXCeQ0i7tOryRLY/MejSFMSiAfdtrSrH52vnF0S+efvCprp+gMhPQ1UBFWT0B/
         L4nzelUE8sRlBHhLarYu2rraLXWb2SbGZcZEB/sbbFg5yIXhdw3J5xNegabsiudF6QRc
         GTpw==
X-Gm-Message-State: AOJu0YyPqA9/TjbLjHr1cY6c/wVhlkUx4LrJfKYt9ajG8D+/OQ4MZRY3
	ZfbtjrDDsao8Z8Cp9ongNDKbdCI9mwprjUBt110tNpqp55nZ5ac0Zwl+hFpHNGRsS17BmF2Ow51
	6j/iW4d3F50VctRF4rKRxiQoE5b6txpZq44aVhpimGTGpfO9Q/LRYH8b+TJJezJYUe/3wckBxWg
	+YlS6Thm/hI9EW81j9+9PGWRWXBeY6OZIfEyCNZlc=
X-Gm-Gg: ASbGncubS9qx8yXQKaGAkx/QQGGMUiYhC7DXWTnp4xi8dX8KyKwXbXiINxFyU9DfRK/
	bylfEI7pJ4W6Q39WMjA90KhJ57kfydohseubcMFRVIX42WjHNwxVa4KKI+e9rMP/GnICR5L7nEx
	G+DSKheK0fBSCrCVJJXSdJijctpA9wyGOHSHftjvmNWDNdAQSDlby+4sBpXrJAw++IxkBXh8mY/
	aQKsG4zjBi5fZI9FiGBIeEVNjFOPwnbQEM46FE2uXZZE0cKIwx54Ca/
X-Received: by 2002:ad4:5aaa:0:b0:6d8:838f:8b54 with SMTP id 6a1803df08f44-6dd2339ff7fmr776319116d6.39.1735929074321;
        Fri, 03 Jan 2025 10:31:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGLa2srrFKosKqU0yzLZomHo+TSwmt9UfZXOGtq9cDy8LREuovSYK3Xqgfabxpi5gW9MaeXYA==
X-Received: by 2002:ad4:5aaa:0:b0:6d8:838f:8b54 with SMTP id 6a1803df08f44-6dd2339ff7fmr776318786d6.39.1735929073939;
        Fri, 03 Jan 2025 10:31:13 -0800 (PST)
Received: from [172.31.1.150] ([70.109.132.27])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd181c1e99sm143008816d6.93.2025.01.03.10.31.11
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jan 2025 10:31:12 -0800 (PST)
Message-ID: <e8641a94-e77f-4bde-96cc-b8fef5434eee@redhat.com>
Date: Fri, 3 Jan 2025 13:31:11 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nsm_make_temp_pathname: Removed A Warning
From: Steve Dickson <steved@redhat.com>
To: Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <20250103134614.323240-1-steved@redhat.com>
Content-Language: en-US
In-Reply-To: <20250103134614.323240-1-steved@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 1/3/25 8:46 AM, Steve Dickson wrote:
> file.c:200:22: warning: assignment discards ‘const’ qualifier from pointer target type [-Wdiscarded-qualifiers]
> 
> Signed-off-by: Steve Dickson <steved@redhat.com>
> ---
>   support/nsm/file.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/support/nsm/file.c b/support/nsm/file.c
> index de122b0f..8d4ab9a9 100644
> --- a/support/nsm/file.c
> +++ b/support/nsm/file.c
> @@ -197,7 +197,7 @@ nsm_make_temp_pathname(const char *pathname)
>   
>   	base = strrchr(pathname, '/');
>   	if (base == NULL)
> -		base = pathname;
> +		base = (char *)pathname;
>   	else
>   		base++;
>   
NAK... to previous patches fix this problem.

steved.


