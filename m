Return-Path: <linux-nfs+bounces-8898-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E1AA00FE4
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Jan 2025 22:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 544A416307F
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Jan 2025 21:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA831C07EC;
	Fri,  3 Jan 2025 21:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RxcGVESe"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C712D1B21BD
	for <linux-nfs@vger.kernel.org>; Fri,  3 Jan 2025 21:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735939913; cv=none; b=Eal7vNafV+YAlI127E8S0oCdxuMSNfqTB5EvTTcM+Nro8hPwuX2ghN+pIsqulsqaA/y0s3/VvrdxzsUAS/i3AFvECEHpqZfSQRNqnavVnTy+31paGHiDuz75zl2BPGNrem493rrl+7x6u5TsXbx0Sgml+/ntfyCkRqc5zhPX5x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735939913; c=relaxed/simple;
	bh=qOZvud353fosXZsoiqy5Q/BOheBDn7g49XjJbHt6a4E=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=htYgEHFLHHOFHiM5OZfPI3wn5hviE7x8z2Z+6/Xop07rivrQLFJfaFcDzkaS+jPE83BUfEaTOEYXLH9UW4JbtsahhePmrpQW3/ld4DQvOOAiDyTpK88T5aeaAyOdYR6Ip4DYb/ZLStKl6HxQX7gbb/cC1KHktwgzISr3IFUp/bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RxcGVESe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735939910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VO2oXHF6W3Jziu/rbMMgG8br3yUrSNlEj4Fv5PxDMj4=;
	b=RxcGVESer3r1e82BngFpbAWr5yCvXPLc0HE/IsGkcBApEq+/3ylr4Y1LAXJKjcaZkw9AZ6
	pEnoSXYIRYgjHnDXhAE1pbXbjECFaCtF2kOzRLQWEbmLN3fJDjo+KNRi5l/cwSbR25LKbe
	m4GiCALcugnbypuN+nj53mjCBBKRtWE=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-423-AqZURSY6N0S_q1cZL69ytw-1; Fri, 03 Jan 2025 16:31:49 -0500
X-MC-Unique: AqZURSY6N0S_q1cZL69ytw-1
X-Mimecast-MFC-AGG-ID: AqZURSY6N0S_q1cZL69ytw
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6d8f8f69fb5so245017736d6.1
        for <linux-nfs@vger.kernel.org>; Fri, 03 Jan 2025 13:31:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735939909; x=1736544709;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VO2oXHF6W3Jziu/rbMMgG8br3yUrSNlEj4Fv5PxDMj4=;
        b=X7pGFSu2WQ7ggdD0K1eMtjhr+lfPW6uFMP7dveMDQsY9PEu037WRqreMm2P87KiG/I
         8ER4Dj+9tdZpdRV40uGMNOMSbIu9ksnYux3QeY/rGdTYQbVuTlxl23JeNREl2aPhGDni
         91t1E6eJEqAgF9/JY2owXdtk/NpOoupFITjs9W9gy41EAhaV9xOMhb2kjhBx1EvT9Gue
         VVWXaO5lmLeAw8lFDPCYUHZk93aVVCaM0yTa2h4Wgeevnw2Sa6flF3r5qom8yYnJfkNo
         kOR3Btg/RZ9Swn8zkGDBtx3aU3PmcmMSfMrVe+VP3sZPjKLJZ/jhl7OH8iIEy0C5qju6
         n/Vw==
X-Forwarded-Encrypted: i=1; AJvYcCUgHp5rWSe/VD9uYsWm2ff1QxXA8hn2R4BydyEx8xmLvnDgNMQPm3Ig1gL5I/T6MiZfqsCix73hF40=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0nbCwjUXcJRE7EgCcGzemTnbCcjIkAJHmpXU+FbejSmZHa/Vk
	rvbRd7XQEaMG24V4O5TW9FQhkawhcrCvAFxHBFFqw3eyV/aVdwp2rm4xGYfR7aDBfy98gFX8KLh
	272tKOxJInYcAh/hfis5QHQ33nJZuGYrm1dRcLoTKDkbTYR4lsGSdWnha7A==
X-Gm-Gg: ASbGnct1skHb7LHIG8b4zL8QucevszAGJbNhWDu/+NtDeBkg1MYdO2NqCPYF8EB3wBY
	8ol4ZbQ827f94/Di/FVdtQCpzSQMhq9BDkD7jrUx893SKKwzEIIyEchays98Y9xWbyob/YWgqow
	Hv3/fBqGMkKq1YVj5UEn1Olm8tTB15YD5D32vlRkGlOwXGmsWfA2XWbVvg/2ZkvPN5OnXEjaqUI
	LTvdSJUfF8mVk0Zv+8KeDPuFtNOlGDs0RkSkr3VdLTM8LheDz1dJzB4
X-Received: by 2002:a05:6214:e4a:b0:6d4:1613:be3e with SMTP id 6a1803df08f44-6dd155eded1mr871070206d6.22.1735939908930;
        Fri, 03 Jan 2025 13:31:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEXPpCsXDkvSFtm7C4oZ+P+WkM9QTBNzQ23q9AZbv1i96nvvW4Qc9gqwnqSuHw7eBYXHMzVlQ==
X-Received: by 2002:a05:6214:e4a:b0:6d4:1613:be3e with SMTP id 6a1803df08f44-6dd155eded1mr871070016d6.22.1735939908624;
        Fri, 03 Jan 2025 13:31:48 -0800 (PST)
Received: from [172.31.1.150] ([70.109.132.27])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd181c1e99sm144335516d6.93.2025.01.03.13.31.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jan 2025 13:31:48 -0800 (PST)
Message-ID: <7c29029a-43bc-4e9f-9d45-d13f1b48e192@redhat.com>
Date: Fri, 3 Jan 2025 16:31:47 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Fix const qualifier error
To: wangmy@fujitsu.com, Linux NFS Mailing list <linux-nfs@vger.kernel.org>
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


