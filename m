Return-Path: <linux-nfs+bounces-10780-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3351A6E461
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Mar 2025 21:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 502663B18E4
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Mar 2025 20:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0F917E0;
	Mon, 24 Mar 2025 20:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T5ZfhNeC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC9D1D5159
	for <linux-nfs@vger.kernel.org>; Mon, 24 Mar 2025 20:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742848108; cv=none; b=VZdav+5TzU9xY4myuwkkV7krYco/x7Q7fzZteCv0aht+ZK2BhcN376Vh2PfeUWZ+uEiw6iI1qSPLBho3ANRofuijP6FZQSxc22eJkYB9QnlAIbpL0YRwVthpPypyHC8MO89OInkhB0mNTWLbPBXLbjwRo4I65vYhaY9fu+LDqQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742848108; c=relaxed/simple;
	bh=90LbhIOFZYFafFGPJ1wROAvAmZEV5WrX+7ie6dAdEwI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=psD0TZtaw9BbuGGuFu2WzfrN4NjaxF8zR/zMAq+HcjHWFXF7Jc5vieDfJ57sPzAlkHudXyiLYI7RBGCLl7GBmQWB9Cmm6sRLu9fjcsTLIHBnUtQwpp3ZfoWQW6p5ikuVzEOIGEm95/XMC5EzVQLFFXnZ9n0b8FJNUcxrXFrGyDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T5ZfhNeC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742848105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=suUt0a8HjCT1jFB5A9X5eNdnyC//Rqi33duBvpCAVxA=;
	b=T5ZfhNeCH6b195DWw3XTwlaebRSISCgqHNzh1tx8TGT1gk1ZUD2x+x42scHrS2sI1YH0o2
	2AZ5Cnt5H2rR0OrMVD2vjIDPHXptMan3hUdcT/mgkGw7X/3QyKpa+tOnDxt2fcI+KxqfAs
	VQg3xP7QfScGJQ2O4dXbc3nwQ5U2jrU=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-228-ggSUJ7jhN1GJZ2uhUcNZnw-1; Mon, 24 Mar 2025 16:28:24 -0400
X-MC-Unique: ggSUJ7jhN1GJZ2uhUcNZnw-1
X-Mimecast-MFC-AGG-ID: ggSUJ7jhN1GJZ2uhUcNZnw_1742848103
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6eb1e240eddso81849316d6.0
        for <linux-nfs@vger.kernel.org>; Mon, 24 Mar 2025 13:28:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742848103; x=1743452903;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=suUt0a8HjCT1jFB5A9X5eNdnyC//Rqi33duBvpCAVxA=;
        b=vWHDrkkFNqMXerSBNG+HnXfl0yzT/V1sSL4Eag5Z8TNkmxLUnFXq2ADax0t1JWnNsn
         e4xBE19RhOYtUG73gD0VgRPAkWn5glzqVFcBqDo8Otdpp80ViHN22m6GPRSiRzSt7C+d
         DDp/71mSF2f9rIBL22wvt9XDREltRdlMLRGVIZgkW9nZ8xOMTtvbnyNiWmh5nOIJOc5a
         Ib7aZx6t8KUbNcH7pmJgbeDzBR3aABEwEa+HMuY6mPGQT/+n2UZxxLMC5Y/rXGqvun17
         jqxdMS7CEXqkeuZ6qOlxFMc7Bd//1JHswnowVGPIoUsdsy2RbF5NQIjVEvdmngEkiLHu
         1bFg==
X-Gm-Message-State: AOJu0YzOsQf1UT49ibLyida38sNS4VGExBvegQ6aEsDdTzV34wqydoC5
	n3ebpAhbobVGlB4Ce++lU+keYC8Bj4Xw+9LMJO0Kx6rvqMpPK3MrgFD2DtF7iX/ONFU8pu0dMGB
	js3Occgbmk6t6hbYgceGoGhLWTYJkn4qnXSgXPBwnrd/cSn+5bNmii8Bl/w==
X-Gm-Gg: ASbGncs6CHHCQZwAxh6rJ59ka72Z64zw4O9Tuvjy67K9mltiUJmo7bQP8ZSexOayPd7
	jx8sN7dEkZ0eU0i2DVk5bR2cjEsBA8znnHeBmiCxKlgTPWC11KLfMDFXREiiIvCZG49MTuVf4im
	tMr+Hc4/DiqXyDndSBZGDhWLFZ1C8eIlBCg/NEM9UO+UcDXcoHlu4v/39kKewvn6aNtJgcJjNA2
	zIdvA5rYLFBF1kxlXJp3SvMs+nhJAi3x36whoZ+0LtJ4tAp0jqal/OjwrmU8zl4wLXRjKeRVmIW
	WG2ySy49mK1XCP4=
X-Received: by 2002:a05:620a:40c1:b0:7c5:4913:500a with SMTP id af79cd13be357-7c5ba15ef2emr1703513485a.19.1742848103371;
        Mon, 24 Mar 2025 13:28:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/iKXVYxpq7ZE2tOyJPXdpLWYqweeVXHu+TcTuPzSEGkmuAFwQmjtWc1vCwFWjZBgguBMGpA==
X-Received: by 2002:a05:620a:40c1:b0:7c5:4913:500a with SMTP id af79cd13be357-7c5ba15ef2emr1703510785a.19.1742848102995;
        Mon, 24 Mar 2025 13:28:22 -0700 (PDT)
Received: from [172.31.1.159] ([70.105.244.27])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5b92b2bb6sm554046885a.11.2025.03.24.13.28.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Mar 2025 13:28:22 -0700 (PDT)
Message-ID: <da846f4b-8064-4519-a604-0f0214c48857@redhat.com>
Date: Mon, 24 Mar 2025 16:28:21 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] utils/mount/nfs.man: add noalignwrite
To: Dan Aloni <dan.aloni@vastdata.com>
Cc: linux-nfs@vger.kernel.org
References: <c1ba003f46c0d9b59dcb6d1bd0afdb94b5f7df3f.camel@kernel.org>
 <20250310125214.2592313-1-dan.aloni@vastdata.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20250310125214.2592313-1-dan.aloni@vastdata.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/10/25 8:52 AM, Dan Aloni wrote:
> Signed-off-by: Dan Aloni <dan.aloni@vastdata.com>
Committed... (tag: nfs-utils-2-8-3-rc8)

steved
> ---
>   utils/mount/nfs.man | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/utils/mount/nfs.man b/utils/mount/nfs.man
> index eab4692a87de..b5c5913bf315 100644
> --- a/utils/mount/nfs.man
> +++ b/utils/mount/nfs.man
> @@ -618,6 +618,17 @@ option is not specified,
>   the default behavior depends on the kernel version,
>   but is usually equivalent to
>   .BR "xprtsec=none" .
> +.TP 1.5i
> +.BI noalignwrite
> +This option disables the default behavior of extending buffered write operations
> +to full page boundaries.
> +.IP
> +Normally, the NFS client rounds non-aligned buffered writes up to the system
> +page size, which can lead to "lost writes" when multiple clients write
> +concurrently to distinct non-overlapping regions. Use this option when your
> +applications perform non-aligned buffered writes and you can guarantee that file
> +regions do not overlap, thus avoiding the need for file locking.
> +.IP
>   .SS "Options for NFS versions 2 and 3 only"
>   Use these options, along with the options in the above subsection,
>   for NFS versions 2 and 3 only.


