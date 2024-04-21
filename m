Return-Path: <linux-nfs+bounces-2903-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7723D8ABF2B
	for <lists+linux-nfs@lfdr.de>; Sun, 21 Apr 2024 14:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 976491C20434
	for <lists+linux-nfs@lfdr.de>; Sun, 21 Apr 2024 12:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6AB33F7;
	Sun, 21 Apr 2024 12:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BiCtk+7K"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68CE205E21
	for <linux-nfs@vger.kernel.org>; Sun, 21 Apr 2024 12:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713701886; cv=none; b=TCT/qo1JlnZrDuYww6OPhalWhucVP7w1yIwAwEzOxaQCtM2q2GEhYAgfEnJIw2TuMQ4driDyatqZ9e92TzYS+vpUitB3rcCY4A2wn2vDl1NPUCs+MTTf62qUuVB/3Momu7ZzvoYcQ0n/pDOCI9E/R4iXLmy9BTFXCoo3a8KYBSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713701886; c=relaxed/simple;
	bh=bb+Neoj3t3gIi/SlXmXrj8qrVJUtBZmuzSYv6SEg9d4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hOHjVvGSHqh9rJ+tUqU8LjcnhigkhokC2FYZVQlLf1C/O10hkr4+yBbu6P3diee4pYDZSpYgbTzGBahK46U9lAA/zM12cOK3mBtm8qpgIzrUgPjopchok0c4VnTMV1Maho6qYdQIiV5/bKyz1mTYlv3PGWmX9rj3xAlQUByeDcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BiCtk+7K; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713701883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oFstEBX0aJjOf0+8QaNEMbFCH18tCgmUDc/WD/0VXMo=;
	b=BiCtk+7K23ms474jwt7tWqAfGUAw8yl1E2aSyRueun06JwToC8x1nOvZf24NiPJ8q2hEFW
	FC3vWu8l7KvxtYVb7687LgEZB9jiB8pY0TZ37kpiqClJ7ANIhvgIwuRtI++jRUuGb1K/Q8
	coAZd6/RPGo8z1E1urhIoAFkBAhJfnI=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-c4uJNBLwNH-zU-UgLggJtw-1; Sun, 21 Apr 2024 08:17:59 -0400
X-MC-Unique: c4uJNBLwNH-zU-UgLggJtw-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6a0426da999so11019916d6.2
        for <linux-nfs@vger.kernel.org>; Sun, 21 Apr 2024 05:17:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713701879; x=1714306679;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oFstEBX0aJjOf0+8QaNEMbFCH18tCgmUDc/WD/0VXMo=;
        b=M9wm7762GRIkYo9aw6ObEv8PYeOxcxx89I/7/ydrxZQQroP0LG3+rDxudx5vOZOIWL
         VWy3ox/admqorAWY2Z5EyhRRaffmkWDs1DgU7m7JR8Q7eQBxaF4tE9EqiRQrH7FkGoNE
         Qe+OgpJoHInMQh9LUl7T0dtTvCP5S/NrfuS3kulNTu/rC1Xy1mXh0xtZZ4YRpS+Fy+Tn
         gcpbO9mHC/O/Kpz7GEW5p2YSS2Gfz3SjXPeBhOpSQevvYxQQXeymveXq5zUb7thVV4Ro
         WwbGhoy3nsjeQhmtMMRRuafw3XIKgvgXUNuZQyP7DcP6EBl1e0ZzMOLWFZZf/gSWdwEM
         u8Uw==
X-Gm-Message-State: AOJu0Yy6C+uB7/E1SsTd0UmA6ZV03tOgDCGpMWn5eOBMX85jWidbSXBl
	MgkC8whXIYFXpbCjz7tyJly/14+GaSrTAeM5Qz4ZqO5D2fEUq3pmst2CrLClR3E4CSI62NdKYHZ
	kBwM6mQ2eyFNPKP3anlwgXN4UneITHAbHh5cof2bEJEI7odxSn4YnFYp5cg==
X-Received: by 2002:ac8:7d8f:0:b0:437:bfea:1f52 with SMTP id c15-20020ac87d8f000000b00437bfea1f52mr9017551qtd.1.1713701879071;
        Sun, 21 Apr 2024 05:17:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdyW5T6N8EMdWXSPfFAl5YVcqBOcJ1XAjswINCU2G9cVBvY9aZE2o9FmgBPJNrJvdMlQIRNg==
X-Received: by 2002:ac8:7d8f:0:b0:437:bfea:1f52 with SMTP id c15-20020ac87d8f000000b00437bfea1f52mr9017524qtd.1.1713701878599;
        Sun, 21 Apr 2024 05:17:58 -0700 (PDT)
Received: from [172.31.1.12] ([70.109.136.115])
        by smtp.gmail.com with ESMTPSA id h10-20020ac8138a000000b00439a9319a4fsm231015qtj.48.2024.04.21.05.17.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Apr 2024 05:17:58 -0700 (PDT)
Message-ID: <110db294-3f0b-4119-9526-6da684826e74@redhat.com>
Date: Sun, 21 Apr 2024 08:17:56 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH nfs-utils v2 0/4] nfsdctl: new nfs-utils tool for managing
 the kernel NFS server
To: Jeff Layton <jlayton@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>
Cc: linux-nfs@vger.kernel.org
References: <20240416-nfsdctl-v2-0-9a4367b710d2@kernel.org>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20240416-nfsdctl-v2-0-9a4367b710d2@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

On 4/16/24 12:48 PM, Jeff Layton wrote:
> Lorenzo posted an updated version of his netlink interface patches
> yesterday [1]. This is an update to adapt to those changes, and to bring
> the tool closer to feature completion for release.
> 
> This series first adds Lorenzo's original userland nfsdctl tool to the
> nfs-utils tree, and then converts it to a subcommand-based interface, in
> the spirit of tools like nmcli or virsh.
> 
> This version should be at feature parity with rpc.nfsd. This posting
> also includes a manpage and an update to the nfs-server.service to
> start using the new interface when possible.
> 
> I've also included a patch that adds the manpage source. It's much nicer
> to edit that and regenerate it if we have to update it later. We can
> drop that patch if you just want to keep the result though.
> 
> Assuming we're good with the new kernel interfaces, this should be
> pretty close to ready for merge.
> 
> [1]: https://lore.kernel.org/linux-nfs/cover.1712853393.git.lorenzo@kernel.org/
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> Changes in v2:
> - Adapt to latest kernel netlink interface changes (in particular, send
>    the leastime and gracetime when they are set in the config).
> - More help text for different subcommands
> - New nfsdctl(8) manpage
> - Patch to make systemd preferentially use nfsdctl instead of rpc.nfsd
> - Link to v1: https://lore.kernel.org/r/20240412-nfsdctl-v1-0-efd6dcebcc04@kernel.org
> 
> ---
> Jeff Layton (3):
>        nfsdctl: convert it to a command-line based interface
>        nfsdctl: asciidoc source for the manpage
>        systemd: use nfsdctl to start and stop the nfs server
> 
> Lorenzo Bianconi (1):
>        nfsdctl: add the nfsdctl utility to nfs-utils
> 
>   configure.ac               |   13 +
>   systemd/nfs-server.service |    4 +-
>   utils/Makefile.am          |    4 +
>   utils/nfsdctl/Makefile.am  |   13 +
>   utils/nfsdctl/nfsdctl.8    |  274 +++++++++
>   utils/nfsdctl/nfsdctl.adoc |  140 +++++
>   utils/nfsdctl/nfsdctl.c    | 1401 ++++++++++++++++++++++++++++++++++++++++++++
>   utils/nfsdctl/nfsdctl.h    |  186 ++++++
>   8 files changed, 2033 insertions(+), 2 deletions(-)
> ---
> base-commit: 117102ee541f38fd7d9274feb8b5586f88d4f655
> change-id: 20240412-nfsdctl-fa8bd8430cfd
> 
> Best regards,
I'm not sure this is ready for prime time....

nfsdctl status
[nothing and there is a mount]

nfsdctl version
Error: Operation not supported

nfsdctl listener
Error: Operation not supported

nfsdctl threads 256
Error: Operation not supported

The command does bring up the server.

These are examples from the man page

I have not invested why... but it just makes
me nervous that examples in the man page
do not work.

I have everything queued up ready to go
so lets work on this during the Bakeathon
next week.

steved.


