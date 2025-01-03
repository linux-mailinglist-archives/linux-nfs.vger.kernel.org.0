Return-Path: <linux-nfs+bounces-8899-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 081AFA00FE3
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Jan 2025 22:32:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B63DF3A447E
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Jan 2025 21:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CFB71ABEC7;
	Fri,  3 Jan 2025 21:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bg4FxCzr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27221B6D0F
	for <linux-nfs@vger.kernel.org>; Fri,  3 Jan 2025 21:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735939939; cv=none; b=G+43+qVhF5rolAxSGgAdyt04HCl9Q8CQFZFhhGbpCgdv3NH7KQioejiQDmczS5xkkwMy6oloWXdppXw0qk90ZuyENDi61EuXmQfE3wAMth9BrdPu+gTFsQBKWOC/vPI+iqvhzS+3iItdPoCSMDLJO/PUgSbI7PiKnqiO37ikzG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735939939; c=relaxed/simple;
	bh=qOZvud353fosXZsoiqy5Q/BOheBDn7g49XjJbHt6a4E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=USRMeGGExUJ9JEIpMsPl6on7JIHwT8WWDS2NElAUxEXlO7pdqDw6ZZ3ukRHKlVJlHnoXqBk184gYwU/js640GHWPa/RaznA3E8mdEfwUXlGByEgMtMpxAxswkLPm0UQspy4rMvcFDuR0WEKNrq+agUm26quhNW+DQbHCtgGnUjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bg4FxCzr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735939935;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VO2oXHF6W3Jziu/rbMMgG8br3yUrSNlEj4Fv5PxDMj4=;
	b=Bg4FxCzrYvYBooqUkgjDTtqa3HUmRLYAb9+Dy9mnUjAWq/R60zZvu9LHf1TGETuWJxOEnI
	+dghX0wr796Z2WlXNgcy7VAmCvkpFc/vldgj6O+zi7OrLenAPJ7aVRjV2b+f+Gl+cqaYr/
	mWnHbizUr484QWrTZes7LVotVgrxFw8=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-0RIuaQ0_Pbyxt_-FRdnwsQ-1; Fri, 03 Jan 2025 16:32:14 -0500
X-MC-Unique: 0RIuaQ0_Pbyxt_-FRdnwsQ-1
X-Mimecast-MFC-AGG-ID: 0RIuaQ0_Pbyxt_-FRdnwsQ
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6d8f6903d2eso204415776d6.2
        for <linux-nfs@vger.kernel.org>; Fri, 03 Jan 2025 13:32:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735939934; x=1736544734;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VO2oXHF6W3Jziu/rbMMgG8br3yUrSNlEj4Fv5PxDMj4=;
        b=YoCx4e8soFECGnItnDnswhpT9jYKPQT0UL9mQchm0ZNk2Yp4p+5Wgz3UnlBHO2abQ+
         pOeLYTutkk88ZrxvyVuxKOpsYFTVjqMdmaavzjozoNh7fYJkmSHnleSRACm9nsd8xZHl
         AFZbCtBDyoeo/eiX/iwqrPNlaUSq+Ouu0HHVtXuRHgzSd+tG9Z9PUdBbB8KcfNwEWTDT
         W2xF3QoZjGdDsDXXViT25+F678zR5xh/rn9q37ZFSXSb4KAE1Tig8KwT0b0vSDnrepIP
         4n4xR9uJtcwKJrtTZWPZil5ruh2buFCrSYRa+N6aroYOHXk/ccybu54VJw6/FIg6U5Ye
         VMiw==
X-Gm-Message-State: AOJu0YxMKCJNJjtPgNZODyqO1jl9u9vRo8tNUVlz2K0Tx2NrF8K9zRZw
	ZudP9/gnj0UQD4KUEkfisgT9BisWjmooEks6LZy6RZonaYJs1NWVWXJvk6KFJkkS7AO28Qrih3P
	eWUOi0wMZ68g4pWN5jFFveMf0Vo+zSPq+YN78mjP5WxmzP7dsdaSbXRO7Fg==
X-Gm-Gg: ASbGnctKH39y4c3RWYJ+tP0wXQld5qgpcbRAzOymRWWtY3sqvCJfPyuYDkwrmrpIXkr
	rJm81PWwKerjLKlH5av/8X/Uc8+cjN8Df5sxYUw95tLts/24jixE/2kgIqDLIzaiGcqKlaSa2bX
	DKCgE+2FvNlTG6gSUaaOmDJNHUeKPZgzOlrJJnBu1bzcuR9W8T0mm/m/ve/AHs8gOOi2c9yor+2
	9g3kAWXlXhM778uqjW9aBcwa+/hU5tKWziWyrvop0VdB9UsS1nCzv0F
X-Received: by 2002:a05:6214:262c:b0:6cb:d4e6:2507 with SMTP id 6a1803df08f44-6dd2335706fmr792791316d6.22.1735939934133;
        Fri, 03 Jan 2025 13:32:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHnSfTFvhvwRlhRiUc24/EHbHLmuPB/PgbtqPW/tD1p5Kv3hL/5P8+dDFfDZ5htDK3vVf1KaQ==
X-Received: by 2002:a05:6214:262c:b0:6cb:d4e6:2507 with SMTP id 6a1803df08f44-6dd2335706fmr792790706d6.22.1735939933266;
        Fri, 03 Jan 2025 13:32:13 -0800 (PST)
Received: from [172.31.1.150] ([70.109.132.27])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd1810d5casm145217166d6.39.2025.01.03.13.32.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jan 2025 13:32:12 -0800 (PST)
Message-ID: <54040b0e-1149-4b07-8fb5-dd569b13b12c@redhat.com>
Date: Fri, 3 Jan 2025 16:32:11 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Fix const qualifier error
To: wangmy@fujitsu.com
Cc: linux-nfs@vger.kernel.org, Wang Mingyu <wangmy@cn.fujitsu.com>
References: <1734597765-2780-1-git-send-email-wangmy@fujitsu.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <1734597765-2780-1-git-send-email-wangmy@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12/19/24 3:42 AM, wangmy@fujitsu.com wrote:
> From: Wang Mingyu <wangmy@cn.fujitsu.com>
Committed... (tag: nfs-utils-2-8-3-rc1)

steved.
> 
> erroe message:
> cc -DHAVE_CONFIG_H -I. -I../../support/include  -I/usr/include/tirpc  -I/usr/include/libxml2  -D_GNU_SOURCE -pipe  -Wall  -Wextra  -Werror=strict-prototypes  -Werror=missing-prototypes  -Werror=missing-declarations  -Werror=format=2  -Werror=undef  -Werror=missing-include-dirs  -Werror=strict-aliasing=2  -Werror=init-self  -Werror=implicit-function-declaration  -Werror=return-type  -Werror=switch  -Werror=overflow  -Werror=parentheses  -Werror=aggregate-return  -Werror=unused-result  -fno-strict-aliasing  -Werror=format-overflow=2 -Werror=int-conversion -Werror=incompatible-pointer-types -Werror=misleading-indentation -Wno-cast-function-type -g -O2 -MT file.o -MD -MP -MF .deps/file.Tpo -c -o file.o file.c
> file.c: In function ‘nsm_make_temp_pathname’:
> file.c:200:22: warning: assignment discards ‘const’ qualifier from pointer target type [-Wdiscarded-qualifiers]
>    200 |                 base = pathname;
>        |                      ^
> 
> Signed-off-by: Wang Mingyu <wangmy@cn.fujitsu.com>
> ---
>   support/nsm/file.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/support/nsm/file.c b/support/nsm/file.c
> index de122b0f..27332108 100644
> --- a/support/nsm/file.c
> +++ b/support/nsm/file.c
> @@ -197,7 +197,7 @@ nsm_make_temp_pathname(const char *pathname)
>   
>   	base = strrchr(pathname, '/');
>   	if (base == NULL)
> -		base = pathname;
> +		base = (char*)(&pathname);
>   	else
>   		base++;
>   


