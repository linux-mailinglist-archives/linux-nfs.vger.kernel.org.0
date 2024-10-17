Return-Path: <linux-nfs+bounces-7220-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 958FE9A2145
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Oct 2024 13:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17D451F24F0A
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Oct 2024 11:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810C81DCB21;
	Thu, 17 Oct 2024 11:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EJdE8t0F"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3301DC07D
	for <linux-nfs@vger.kernel.org>; Thu, 17 Oct 2024 11:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729165262; cv=none; b=hi7ynq1Q7s+e5UKgmFxDwafbOGf3GX2BmDHpPWTk1ct6kIjzQWqlRucbm45hC6Jc0wtj0QbLpltGSvHG2DpPZatFsfIKkehbB5ulzGV0ZNMfYLn9NdMcMMnvxKp3sRM9Gxp9LmqTA2YjEdyJGO05ySDeBDSR+EPoTZYH1hj5mDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729165262; c=relaxed/simple;
	bh=7AJ3VUIb3EQCzkEdvSYZNu6MuqinauiEQTgvSVld0mI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LfzedXrsVxD2b7XKEZuzRp9sjzwEjp3e/vaDurdXl3/iPBT6jyrWFF+Yfix1j9yHKHC7auVOzZGHYRMtZmiNzizCwPpdGvl6hGoPgc9jGCEr6LavDxDS3chTYvBEaYo6TY5ZlDWTPofOzsrZKMXuYm/hUEdFQ/0bUt2wHLSyIkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EJdE8t0F; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729165258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DgEV6BWdpyDQ3Oflij3rZs1+RKc3mSojquY+cTfX7PI=;
	b=EJdE8t0FWZxyvuf7fD+dirt6O4qnshiP542GdYfAk7/y613bZWu0Mhn6wkplM3vcUyVd8/
	+y68mlyTC7eV8Z+xTHEHIxFY8YB9OaMlXYckFR07llGMqR2B1Zk03mqdtn3Y3q0g8J59BY
	fYEpp70VC1A+gMQqs5p3nkrDmhptUpU=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-ux-Csbk4OhWu-kJ_E3k4NQ-1; Thu, 17 Oct 2024 07:40:57 -0400
X-MC-Unique: ux-Csbk4OhWu-kJ_E3k4NQ-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-460670f6e6eso12257511cf.3
        for <linux-nfs@vger.kernel.org>; Thu, 17 Oct 2024 04:40:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729165256; x=1729770056;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DgEV6BWdpyDQ3Oflij3rZs1+RKc3mSojquY+cTfX7PI=;
        b=JIXzsFIR32nVhkzDGmCv77ghnZ2xDeS6gv+Lqt7zAU4WSjPXRrfbrvPCDPSFA28iRg
         8Untd3UY6d8FktqQQme3dGINSL1d9/Sf/2xHwwDz2ECqsSTDKP1+nEJ8bQT+6mSnk16d
         OAN0ZHzxYQApHBqlolPU15oCGHNG79zohm9mIXqK6LchHJRi8U44v5HrO/qUE3aKN7Iy
         pF2xJcsF8bq/uOhbsCMrxY5wi7iEH7yltmHwRTfzacAGdzPmQIlT6cqva/uH6JzX6Kxc
         Jn0RMnj8HK06DGEbLllFjl91kwJVK36LlF7rA5izRBKZB3WV7Giowber+M10cnDJNO6A
         9nwA==
X-Gm-Message-State: AOJu0YzjqCuTit5kcSgUV9pQ+NA5diUkafKZoqIl4oUhvQGwRBuhfjo7
	CD0iOVbt+FR6Ou8tyk2yXC/NAGwVGBuJFupsoWuF8VX22WuIfBF8hap8/gsZm4P//P8aaC1ruLW
	cl76wNQVcV0BJlEKJrwDpn8V0mJxeG3Qjsy+Eau9j2BpmDNw/boKohB84Xw==
X-Received: by 2002:a05:622a:4cc8:b0:45d:5786:80b4 with SMTP id d75a77b69052e-4608a4da2fdmr119910191cf.26.1729165256420;
        Thu, 17 Oct 2024 04:40:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2Rdj/uN25KCQZhN+wjhmhtt7/Hsnno3EKtytOhyS9PybbTjJBvCCwEmOPFXDzZaXSDW6Z4Q==
X-Received: by 2002:a05:622a:4cc8:b0:45d:5786:80b4 with SMTP id d75a77b69052e-4608a4da2fdmr119909871cf.26.1729165256006;
        Thu, 17 Oct 2024 04:40:56 -0700 (PDT)
Received: from [172.31.1.12] ([70.109.132.202])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4609784bfe1sm11741491cf.0.2024.10.17.04.40.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Oct 2024 04:40:55 -0700 (PDT)
Message-ID: <7181e0bd-0fdf-4826-856e-6230f190614f@redhat.com>
Date: Thu, 17 Oct 2024 07:40:54 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH nfs-utils v6 0/3] nfsdctl: add a new nfsdctl tool to
 nfs-utils
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org, Neil Brown <neilb@suse.de>,
 Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, Chuck Lever <chuck.lever@oracle.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>
References: <20240722-nfsdctl-v6-0-1b9d63710eb5@kernel.org>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20240722-nfsdctl-v6-0-1b9d63710eb5@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/22/24 1:01 PM, Jeff Layton wrote:
> Hi Steve,
> 
> Here's an squashed version of the nfsdctl patches, that represents
> the latest changes. Let me know if you run into any other problems,
> and thanks for helping to test this!
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> Changes in v6:
> - make the default number of threads 16 in autostart
> - doc updates
> 
> Changes in v5:
> - add support for pool-mode setting
> - fix up the handling of nfsd_netlink.h in autoconf
> - Link to v4: https://lore.kernel.org/r/20240604-nfsdctl-v4-0-a2941f782e4c@kernel.org
> 
> Changes in v4:
> - add ability to specify an array of pool thread counts in nfs.conf
> - Link to v3: https://lore.kernel.org/r/20240423-nfsdctl-v3-0-9e68181c846d@kernel.org
> 
> Changes in v3:
> - split nfsdctl.h so we can include the UAPI header as-is
> - squash the patches together that added Lorenzo's version and convert
>    it to the new interface
> - adapt to latest version of netlink interface changes
>    + have THREADS_SET/GET report an array of thread counts (one per pool)
>    + pass scope in as a string to THREADS_SET instead of using unshare() trick
> 
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
>        nfsdctl: add the nfsdctl utility to nfs-utils
>        nfsdctl: asciidoc source for the manpage
>        systemd: use nfsdctl to start and stop the nfs server
> 
>   configure.ac                 |   19 +
>   systemd/nfs-server.service   |    4 +-
>   utils/Makefile.am            |    4 +
>   utils/nfsdctl/Makefile.am    |   13 +
>   utils/nfsdctl/nfsd_netlink.h |   96 +++
>   utils/nfsdctl/nfsdctl.8      |  304 ++++++++
>   utils/nfsdctl/nfsdctl.adoc   |  158 +++++
>   utils/nfsdctl/nfsdctl.c      | 1570 ++++++++++++++++++++++++++++++++++++++++++
>   utils/nfsdctl/nfsdctl.h      |   93 +++
>   9 files changed, 2259 insertions(+), 2 deletions(-)
> ---
> base-commit: b76dbaa48f7c239accb0c2d1e1d51ddd73f4d6be
> change-id: 20240412-nfsdctl-fa8bd8430cfd
> 
> Best regards,
Committed... (tag: nfs-utils-2-7-2-rc2)

Note: These changes need a v6.11 kernel for V3 to
come up properly

steved.


