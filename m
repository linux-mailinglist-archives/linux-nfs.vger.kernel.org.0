Return-Path: <linux-nfs+bounces-12125-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0613EACEE1E
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Jun 2025 12:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AACD3AC0B4
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Jun 2025 10:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A07215062;
	Thu,  5 Jun 2025 10:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E9aGDzXm"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01251219A8B
	for <linux-nfs@vger.kernel.org>; Thu,  5 Jun 2025 10:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749120756; cv=none; b=bO376QLbasLlev0hOhVj3Xgl96a4/EF2WWWa7w+cJiqCF+a2AHaZ84QM/A1OyZB5i6GsnquoWLi6ux+iIBY8J32TstvFpHG8y9iHXjG/ITekDHDuZFmgZKORocdUbHc117MzG8f5A8eUu5DZ3fKElCr7zcVE8aWpNArsO+DrNCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749120756; c=relaxed/simple;
	bh=pHggzhLBJ8ktaZKI2iMO9SQ9mSf8E17wpmjdCYzWPE8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=IT6g7DGE16/YUSQA6KJBZVvlphNZDvirfWnWvQU/Fatg/nKsZEPnGD9ZWaFj4ecENLk5mrsrwp2+ZyRHzhaING9FYBjcLagivtIHNMzp6FNQ3+QITsqVI50JZprQ8BeyJ+qi8aOSV4trrpq8RIo+P++lFrqVDwzEQ0XIPQO0hco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E9aGDzXm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749120752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OsPyDXSUklJ4YSehzGFAE8ZZ+Kg+x75waAzpMMOCiQI=;
	b=E9aGDzXmiwh06AmGIsT8LxXalz26Z5D9mIhr9DHMwxuzOX5zHATwjPmgaFb6hAADNPLIon
	6+Pu8D7iERwjefApJf6cUHyL5yJhG+dQlDFDAevTq4GGzCtf/8kK5NpbJty9qjwcOw/QcO
	ZCzg3RyKtW7dMykz7HoowXfcA4VOhDA=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-JIpRXvP3N-az_0azUsInXQ-1; Thu, 05 Jun 2025 06:52:31 -0400
X-MC-Unique: JIpRXvP3N-az_0azUsInXQ-1
X-Mimecast-MFC-AGG-ID: JIpRXvP3N-az_0azUsInXQ_1749120751
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6fab979413fso17630476d6.2
        for <linux-nfs@vger.kernel.org>; Thu, 05 Jun 2025 03:52:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749120750; x=1749725550;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OsPyDXSUklJ4YSehzGFAE8ZZ+Kg+x75waAzpMMOCiQI=;
        b=ASd6qYWtjLHnD9gq2ujMFLF+B9ErbeweG2WKoOQnybbSO36B8CHAOU4GfrEc2/44CO
         McwPfZkfxn+4QfZYzmEP/GLDfFEq8itS6qc8l9XG0rtSS75wE7k09eim+zsr8IWwTAyA
         n7s8SW8wth8Lwylrzw4m8Lkv1AZ94bD9/si+cFb3vC8XyVWqmodSvRzVx34gQceftsgc
         jFM8Kte8jYyYiAlJgMvWS1nNZu5bdxh5xrlp0dRkC3JOmOWzLSyOcmQvrdNLNFeEjAYg
         snram6XpITkr7aFkJa6SIOvRxmHhdl2CFla6YP1vxHWc3gbZcti9krTGJlApqWZ6Iqv3
         +BBQ==
X-Gm-Message-State: AOJu0Yz4GcuXvCPI0jUN2iR1HzAGs7SIqE+qWSgDJ/zY9d0idYpHAq+U
	ULH9d55NgxJs/Za21QJZW9LQrt3iT53vCvoM1F+RAyIoMrVDA3P2F/b3cnoM6+BOV8BKZK7zN4v
	CbaK9UacpgBU9T+QMkW646I0D2RzliAQTtKcmV2lCJJjDWrFP0HNo5wHM0EA+7lgTOZ3tmIU785
	Ta9mwrHP8XNcoqVMobwDmrh0bEYD6Spapzh+BWV81F2B4=
X-Gm-Gg: ASbGncsGfeqgPqwd30KIhG5F2lhqWRfcPDGYvj5xe4/sm2cnhlVJRcxR+r8vVwUvjsa
	3asKbWq4yplATFmSi8gr500Heu5z7JuwBF2fDiPi2vri63TpqnVIImsJN5miwk0rjf7Mb88Kzsy
	x6LpvnpgJGDkeANJaO4nxIbZFdzumWGtJHjV3CWnM59JKAklmH6nZUg6pxFF+pD+EsyGXr0bKCJ
	6sAl2hzdkegL6K8QB5fAt6ooAi4GA0iGKnB6A1rCUwq2SduZvc/wfFCr7mooFHXYCSq54eYnEuQ
	qPOawouCYIE=
X-Received: by 2002:ad4:5aeb:0:b0:6f6:e701:9612 with SMTP id 6a1803df08f44-6faf7009499mr101435816d6.34.1749120750439;
        Thu, 05 Jun 2025 03:52:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEOSa9cVDNJeAH6549Cs+Pd42dNnbsC9E1gMvXk5sHj74ZX6vLgerZYI313pKuZY9Nkf0K4jg==
X-Received: by 2002:ad4:5aeb:0:b0:6f6:e701:9612 with SMTP id 6a1803df08f44-6faf7009499mr101435496d6.34.1749120750040;
        Thu, 05 Jun 2025 03:52:30 -0700 (PDT)
Received: from [172.31.1.12] ([70.105.242.209])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fac6d4d500sm119438806d6.43.2025.06.05.03.52.29
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jun 2025 03:52:29 -0700 (PDT)
Message-ID: <8a44d4f6-015b-4421-a6bd-a968fa3a6481@redhat.com>
Date: Thu, 5 Jun 2025 06:52:28 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configure.ac: AC_PROG_GCC_TRADITIONAL is obsolete.
From: Steve Dickson <steved@redhat.com>
To: Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <20250604151233.89866-1-steved@redhat.com>
Content-Language: en-US
In-Reply-To: <20250604151233.89866-1-steved@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/4/25 11:12 AM, Steve Dickson wrote:
> configure.ac:581: warning: The macro 'AC_PROG_GCC_TRADITIONAL' is obsolete.
> configure.ac:581: You should run autoupdate.
> ./lib/autoconf/c.m4:1676: AC_PROG_GCC_TRADITIONAL is expanded from...
> configure.ac:581: the top level
> 
> Signed-off-by: Steve Dickson <steved@redhat.com>
Committed... (tag: nfs-utils-2-8-4-rc2)

steved.
> ---
>   configure.ac | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/configure.ac b/configure.ac
> index d8205e80..e402c22d 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -578,7 +578,7 @@ AC_FUNC_ERROR_AT_LINE
>   AC_FUNC_FORK
>   AC_FUNC_GETGROUPS
>   AC_FUNC_GETMNTENT
> -AC_PROG_GCC_TRADITIONAL
> +AC_PROG_CC
>   AC_FUNC_LSTAT
>   AC_FUNC_LSTAT_FOLLOWS_SLASHED_SYMLINK
>   AC_HEADER_MAJOR


