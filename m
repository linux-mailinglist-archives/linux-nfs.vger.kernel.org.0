Return-Path: <linux-nfs+bounces-11554-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3857AAD935
	for <lists+linux-nfs@lfdr.de>; Wed,  7 May 2025 09:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AD5B3A50A4
	for <lists+linux-nfs@lfdr.de>; Wed,  7 May 2025 07:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C19921FF59;
	Wed,  7 May 2025 07:50:05 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97915220F20
	for <linux-nfs@vger.kernel.org>; Wed,  7 May 2025 07:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746604205; cv=none; b=niKkw5fDkokj9k74ckGX9W4/pGYAcbBUq0Piogz/sRdkgU2z0ECEI8idZq9cI/ofCogs6bOjHCN9/7JjdLLnxdvDUmBEjqKeOxGZOZvVOzpIEJhCUpWT+gA/9h6C99Wq5SkKxAuj7HtCEeaamSTDf/pqSULlEpsOPqb6F/O6f4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746604205; c=relaxed/simple;
	bh=0aUBr2iPSWKnwAwkpV9FO2LdVd3xps7OB7drF/jOb1A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sPwKUtqcuisvMHJPR/NUzvg5I2Rd8EAupiiRl6WE+6RoPeedUO23eOus9n5/pf8d2Ozmvg73N84P1vfg5lkUXenatckK9f8MLAqHzZEHWq8xkEblz49mdPT0omffnFI4yjf06v3pCSLBcmqdKmR10Gnkiu0pTo6DVJgPAuue4Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43cfecdd8b2so43018065e9.2
        for <linux-nfs@vger.kernel.org>; Wed, 07 May 2025 00:50:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746604202; x=1747209002;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L8n3qXfnGWQxspDxfSGkwgtKVwzUiL9sbiMeF5o/i3s=;
        b=NKeNMz6NEPdpm2xa88zFIiNIxkmN/ffNL7/fnsKqLwkOLItaZ696bFLy4ErXl1B0JL
         0RbAAQgmMW71OSwYKeFoJhbcIMyFio7Jlra9vJzqxtczNvsk34Rkkpa1GgX3oKZhZ1/Y
         Cpe6WhHFusYR/F+KsBd7CSqX1fevObuyG/z+wr700+lnIvFZm7ja6cYu4ObVSwlhPBYc
         i1gatyH8ERjxqoVqMDc4qCc7cp8MqC6yoGiZmM4gpDQ4ZXRAWNptgVhEEg2UPzHb/nEe
         peHvVGBCkjErjifF61zjzglIJkHPZcRwmn0itmNwJAz8aWSC/2l8PgqWLgZlbDoUSzlO
         PsZA==
X-Forwarded-Encrypted: i=1; AJvYcCV/1lisrgx/BY3QW6dbS8WGiKwQ/C024ErgwgGe62wzqyE3MaQMEbukb3wIiBjL913QRar5stSZaso=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvcvDlJBiBvUanlMG+vsHesQM5U28vQq1wN8IZC2+QVu8fvQ1V
	+XBRNZJc18urb106K1DuStLojBIuy687BrIeEQwUMbhgVOokwgTVO7aupA==
X-Gm-Gg: ASbGncs+LIlS1XCSY9ey/DWiDdA3VlTfo4Suv4xzi3WYKNaPt5Z7XhWotG5M/b7dV9B
	qAlbYxjKTJKKCBqMUCOriZSgzISIIvSjXuRyRlww2QjfvXVcfpFpx6KJqwvkX1y5lAPK/6Wf3S0
	zPmh6JcFKfEEO6zEGSgdF8MOSVOZv5rirE1CwaUkZTMJKS06lBgmlVa8YACE0Ql9r655VBPkT0b
	quwvgapbo7zWJPTlppl1Nn4z60YE/3En80CYago4COPeNurZku5g/7LQMqj1yTbaKZ65DNpIk+C
	+yzGWRiemn+lk4N6jZMbgaSnSdpof9pKB/9n7anWH8uTeYDB6skSlYqA/jjpPUMkxVut0lnRuPs
	ps6HR1Q==
X-Google-Smtp-Source: AGHT+IF1vprA2n5E+jroTf7GicLPh1OLjR2W+OefRYgngvbtY0+MbtGhgFvbp4eTOgWyLhqV7bQbVw==
X-Received: by 2002:a05:600c:4e48:b0:43c:fdbe:43be with SMTP id 5b1f17b1804b1-441d44d7c33mr15941505e9.27.1746604201603;
        Wed, 07 May 2025 00:50:01 -0700 (PDT)
Received: from [10.50.5.11] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441d43a764fsm21071985e9.37.2025.05.07.00.50.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 May 2025 00:50:01 -0700 (PDT)
Message-ID: <ee591788-e2fc-4407-9f78-d73a6f406438@grimberg.me>
Date: Wed, 7 May 2025 10:50:00 +0300
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: kernel TLS configuration, was: Re: [ANNOUNCE] ktls-utils 1.0.0
To: Christoph Hellwig <hch@infradead.org>,
 Chuck Lever <chuck.lever@oracle.com>
Cc: kernel-tls-handshake <kernel-tls-handshake@lists.linux.dev>,
 Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
 linux-nvme@lists.infradead.org
References: <oracle/ktls-utils/push/refs/tags/ktls-utils-1.0.0/000000-c787cd@github.com>
 <32e4bd99-a85f-4f53-94bd-b8c3ecf2c66f@oracle.com>
 <aBoCELZ_x-C4talt@infradead.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <aBoCELZ_x-C4talt@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 06/05/2025 15:35, Christoph Hellwig wrote:
> Hi Chuck,
>
> let me use this as a vehicle to rant^H^H^H^Hprovide constructive
> feedback about configuration of the tls upcalls now that I finally
> got around playing with both NVMe and TCP over TLS.
>
> For modular systems configuations the amount of monolithic state
> in tlshd.conf is a bit unfortunate.
>
> For NVMe it isn't all that bad, but having to hardcode the .nvme
> keyring still means that:
>
>   - we need userspace configuration past just enabling tlshd to enable
>     any kernel subsystem using TLS upcalls.
>   - hard code the keyring used in the userspace configuration
>
> Can't we ensure the upcall passes the keyring to use and avoid
> this issue entirely?
>
> For NFS hardcoding the keys and certs in tlshd.conf is even more anoying,
> because it limits to a single client key and cert for the entire system.
>
> I have a hacky little patch for the NFS client to pass keyids for the
> client key and the certificate as mount options, which seems to work
> nicely, but it still requires adding another keyring (see above) or
> giving the user read permissions for the keys while it would prefer
> that it would just work and we would not need to give any root login
> session a way to read the keys.
>

Christoph,

Just so I understand, this is a separate issue from passing the keyring to
tlshd correct? Is the suggesting that nfs will create a special .nfs keyring
similar to what nvme does?

Note that nvme also allows the user to pass its own keyring (never tried
it before - we probably need a blktest for it //hannes). So in this 
case, the
possessor will need to set user READ perms on the key itself (assuming that
it updated tlshd.conf to know this keyring)?

