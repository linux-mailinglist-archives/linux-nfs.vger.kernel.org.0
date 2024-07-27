Return-Path: <linux-nfs+bounces-5086-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6179B93E002
	for <lists+linux-nfs@lfdr.de>; Sat, 27 Jul 2024 17:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15099281745
	for <lists+linux-nfs@lfdr.de>; Sat, 27 Jul 2024 15:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D177B181CE8;
	Sat, 27 Jul 2024 15:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fS/3CMzd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2A617E9
	for <linux-nfs@vger.kernel.org>; Sat, 27 Jul 2024 15:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722095521; cv=none; b=h5se4zrj1xmAejymduZlALosBwUoKqGPRgbvKWBpG4M3/0VRo3p/dS8DN0F2er96nRdl9h1JZ2lleb8bnEUlcmj0gSicT/10/AKuLxbuovflq5GFxYKk/1Jybs9xREAEIJqxeXDs/49kgauxp6BrHS2FZRXj/nOz/oHf1ysfzV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722095521; c=relaxed/simple;
	bh=wKRw4Lj60znWvlLhierxgNsukDEW1JJiRoYM2oe1JPc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kvM6ueDCcrRoSZcDx0CkzEhCvN8KmOQzqfCEIF9XgcVP00CXF1rSv1eqvNz1tETQRB/YagqmUNE7YPNPGg6dKwgWC0VXWTRSa4sw6b9pFJ48k9DSM+n6NyzLTirhoILBf/A0X7z7dh8H2N2bpUoPTMcvbVTW0OeSV2FHyALBaxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fS/3CMzd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722095518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DjXP4U2ZQjAvrtS/Sv0nT/6vVppQeGfEzHCoGoW4rWE=;
	b=fS/3CMzdHPu7d/X8S3dm+me2iDh9QSYJubX09OclJLrQ8fwTNXDfSZUemIFh8KKlxriJ0H
	d4W+ztZ9ATJkSn/h22oFJpWX54qCOJ1BtL7JhUDVzzN9l/0gKL2QxJEmQiuNXA8xkVyuUi
	wnrzZetxYJFpWZjf9jO0aG+61nswuyA=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-OoMjL-9VOs--wqVKy9A0nQ-1; Sat, 27 Jul 2024 11:51:56 -0400
X-MC-Unique: OoMjL-9VOs--wqVKy9A0nQ-1
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-70446c55dc4so525001a34.0
        for <linux-nfs@vger.kernel.org>; Sat, 27 Jul 2024 08:51:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722095514; x=1722700314;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DjXP4U2ZQjAvrtS/Sv0nT/6vVppQeGfEzHCoGoW4rWE=;
        b=kmljiLh7cvddMmRn8dmfCx266EsrZYf5CiVIeOABVt5ZqA/VvVUn4iOt2zuZpoHqV2
         KFV7vG5fij0xSZxhdv7JC/AyfVS8Gp2dlwg+VskqU0QwGqPKrYiHG36cugrl0n+CXWe/
         yP8bWo7KInMUGnRSGM8X7K6gTB1yk8klmOS6vMR0ws7TCE8TvLkSUnispwx0C+eHV3Rg
         M/d1KUrPhLm/kcZwvWO5pHLmn6IyW9pggNynKOb9khRXdVcgtIvuZCAVhB0P8iGCvOPu
         QBxWJMAc5ZTYlFg71RPbHLdEn5kWCoHR9ZkA8NF87S3In2yx44mCuTMxf9FV6+T64wYj
         b72A==
X-Forwarded-Encrypted: i=1; AJvYcCWF5T9o0doRHIxC5BwMrhtdUdqqtxcJV/AfVDNvidd9dXYh42A1CZMtbqnq8MWMf7w2WaXw0XukH5c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0tfVvTCoUqkxBrA/CaKvpjXNwtY5VkPztLw+vaSic5xZ6/RUa
	4Y/NkrmnkMd21m+26IwXDT45AP7gPtYot6h3y/QbZVJRHdiv2Cmy+wkmO+FPEdaDwVQaZtppAY4
	VSa+W/GsprYWaLRXXS3ao/C7c7xj1t91Ac4udH2rJ6SISfxou+Em1egk54lnF294wFg==
X-Received: by 2002:a05:6830:604:b0:708:b80d:f40 with SMTP id 46e09a7af769-7092fb4217dmr5855115a34.5.1722095514663;
        Sat, 27 Jul 2024 08:51:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6tjcATRoI7n6wR11Cd8apVsh1C6FyUyKR25+pUGsXVh11uTv7wDzCh8BPngq2mbCAGq9tIQ==
X-Received: by 2002:a05:6830:604:b0:708:b80d:f40 with SMTP id 46e09a7af769-7092fb4217dmr5855111a34.5.1722095514290;
        Sat, 27 Jul 2024 08:51:54 -0700 (PDT)
Received: from [172.31.1.12] ([70.109.163.123])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44fe812350bsm24739621cf.9.2024.07.27.08.51.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Jul 2024 08:51:53 -0700 (PDT)
Message-ID: <778657bc-5d5c-4103-858a-d3e86962e681@redhat.com>
Date: Sat, 27 Jul 2024 11:51:52 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Can rpc.mountd NOT be hardcoded to listen on 0.0.0.0?
To: =?UTF-8?Q?Niklas_Hamb=C3=BCchen?= <mail@nh2.me>, linux-nfs@vger.kernel.org
References: <dfcca43f-0dad-4188-b092-0176cfaab2c8@nh2.me>
 <53701c8f-d3a7-4e34-b0ca-c8a8daec4446@nh2.me>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <53701c8f-d3a7-4e34-b0ca-c8a8daec4446@nh2.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

On 7/27/24 11:09 AM, Niklas Hambüchen wrote:
> I wrote a possible implementation of `--host` for nfs-utils's `rpc.mountd` here:
> 
> https://github.com/nh2/nfs-utils/compare/mountd-listen-host-option
> 
> (stable link: https://github.com/nh2/nfs-utils/commit/b77a10686fe042d3709bcde958edd0926d3e5f41)
> 
> Please let me know if that would be acceptable.
> In case that patch is already good, feel free to pull it!
> 
> I haven't tested it in a real NFS setup yet, just compiled and started it locally so far.
When you do finish the testing please use
'git commit -s' which will add the Signed-off-by: tag
and then using 'git format-patch' to create the patch

To post the patch, inline, I generally use
'git send-email'

Finally, I don't see any man page update for
this new option.

Thanks!

steved.


