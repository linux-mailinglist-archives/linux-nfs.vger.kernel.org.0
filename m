Return-Path: <linux-nfs+bounces-3235-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1E18C29BE
	for <lists+linux-nfs@lfdr.de>; Fri, 10 May 2024 20:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B972283D47
	for <lists+linux-nfs@lfdr.de>; Fri, 10 May 2024 18:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5C628DC7;
	Fri, 10 May 2024 18:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OHvA6weV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B27D3F9E1
	for <linux-nfs@vger.kernel.org>; Fri, 10 May 2024 18:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715364923; cv=none; b=FUaopfXw5AgncrQsaGgqClOu85wzAjSbxGN/f1fVLYEWac2m1QvQEf+//hymaQhBX3uNq6AgS409AjYZ2JDBMmIIaC7L4yIVGbAgdmlAKgYygd9mXIGOC9OfYXZoszuiU+hA7POYLnacbqt1dA7ZbKFXPAm9HW2ScnTlvYaeC18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715364923; c=relaxed/simple;
	bh=igdhKWIsSAIDGEbOFqYIIC8vPF9VMMuapnvy+779TTg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UwG8dczsxPsvHrJXw8cXSLNem2CCq9lbklNpc2/T4XN0MgINlbE+WkVAJ2Us8OgVKWU43w8IQX7SoqfL4XwFpwq7uLtjQQUX2A683HxpCoha1e+3hUGkzvrbt4fg3mcDRAX74kqhws8wSynfKznMlncwuwPuwpao6R0cjA82TdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OHvA6weV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715364920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s5NLaOKLqeMX8O0gLJALEICkvPNM9atyA7bcrk4cLio=;
	b=OHvA6weV0UMbzINOZfIJe4B9ScnhJd6tIQwvkfHrAKac/6NvfSnqQ4+wiXuANh+pb03civ
	0y9rpoTqVomvLdRZUgjVwspwddo+dTDMvQzoSk0wNK+NIxRVjDr8BDQS42XDPKums34lOR
	4IMxXHz2h1gGuYMRdM2a9mK7PrFIGCg=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503-c338-I9aMdCIjUi8uMhy8A-1; Fri, 10 May 2024 14:15:18 -0400
X-MC-Unique: c338-I9aMdCIjUi8uMhy8A-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-6278a0d5f8bso17533a12.3
        for <linux-nfs@vger.kernel.org>; Fri, 10 May 2024 11:15:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715364918; x=1715969718;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s5NLaOKLqeMX8O0gLJALEICkvPNM9atyA7bcrk4cLio=;
        b=O6aViWRe9/f7csUSRI9PnYX7WdBtHdu/bPOMev+jytvpfAlzSkZWz4C0H/BKJfM3Py
         oUyARslopiDHbRYFyxcXUei4529Uu1XTk3QgDuYIncz1DvBG7X1wHtSb09kcECZ+EDOQ
         nB7YB4pqHjPVWyodXpBBunh/hdvzXDsfqEUl4z1RNSrzz4Qmffx/xiN95Dfi9/QFmgJk
         VKnrKAsY0t8E2to8m5/DIUHSa67+WAU358cTH+PIuqz5QzXH+229/C83Amf2C4AClxIy
         jPIe5ViGScbZ7Sc2+1y7uECLw66I3b+GUU3eMLYirf3NVPn6cIAE1FNMZs/mqPuK3YM8
         NMNA==
X-Gm-Message-State: AOJu0Yyhd+OuKUJBr3AsdLBdByS01MBRvQpg3Lgl4jSSDNNKgLLCEqFv
	MsVrTBmus7uepfcM051kG/qVjdCRqwn0A9EePT+zX8euL/vXiICEVhVT38zbjYEXKFXRtpNoGqz
	ai2tKWRkA2jVP7utTqTXKSMwD0K1AynK4THrWdQYPHS9yfl2ztIY/Fc+QyQ==
X-Received: by 2002:a05:6a21:8191:b0:1af:d51a:1b9d with SMTP id adf61e73a8af0-1afde09ec47mr3250946637.1.1715364917737;
        Fri, 10 May 2024 11:15:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHq6At/OmGTDJHLl04Fcly+cn9JQKrTPL/gB09g7I1DvK2riFohawMaapHSxsziuroYyXiTkw==
X-Received: by 2002:a05:6a21:8191:b0:1af:d51a:1b9d with SMTP id adf61e73a8af0-1afde09ec47mr3250919637.1.1715364917326;
        Fri, 10 May 2024 11:15:17 -0700 (PDT)
Received: from [172.31.1.12] ([70.105.245.214])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2b2d995sm3220049b3a.192.2024.05.10.11.15.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 May 2024 11:15:16 -0700 (PDT)
Message-ID: <db26ef11-a804-4718-928b-de073011ee76@redhat.com>
Date: Fri, 10 May 2024 14:15:14 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH nfs-utils v3 0/3] nfsdctl: new nfs-utils tool for managing
 the kernel NFS server
To: Jeff Layton <jlayton@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>
Cc: linux-nfs@vger.kernel.org
References: <20240423-nfsdctl-v3-0-9e68181c846d@kernel.org>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20240423-nfsdctl-v3-0-9e68181c846d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello

On 4/23/24 12:31 PM, Jeff Layton wrote:
> Lorenzo posted an updated version of his netlink interface patches [1],
> so here is an updated version of the companion userland patches. To be
> clear, to test these, you need a kernel with his netlink patches.
> 
> The series adds a new tool to nfs-utils called nfsdctl, intended
> as an eventual replacement for rpc.nfsd. It's a subcommand based
> interface like nmcli or virsh, so we can easily expand the interface
> later to deal with new sorts of configuration.
> 
> This version of the tool should be at feature parity with rpc.nfsd, at
> least as far as autostarting the server. This posting also includes a
> manpage and an update to the nfs-server systemctl service, to start
> using the new interface when possible.
> 
> I've also included a patch that adds the manpage source. It's much nicer
> to edit that and regenerate it if we have to update it later. We can
> drop that patch if you just want to keep the result though.
> 
> The one thing that's not quite right here is the way the nfsd_netlink.h
> file is handled. This set includes a copy of the proposed header, but it
> would be better to build against the UAPI header in the kernel-headers
> package instead. Older kernels have a subset of the new interface
> though, so we can't build this against that file universally.
> 
> Is there a good way to test for the presence of an enum value in
> autoconf? I didn't see any macros for it, but maybe there is some
> generic test for C symbols we can use?
> 
> [1]: https://lore.kernel.org/linux-nfs/cover.1713878413.git.lorenzo@kernel.org/T/#m5fd847189894f58e93706c40340e18858f242a27
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
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
> Jeff Layton (2):
>        nfsdctl: asciidoc source for the manpage
>        systemd: use nfsdctl to start and stop the nfs server
> 
> Lorenzo Bianconi (1):
>        nfsdctl: add the nfsdctl utility to nfs-utils
> 
>   configure.ac                 |   13 +
>   systemd/nfs-server.service   |    4 +-
>   utils/Makefile.am            |    4 +
>   utils/nfsdctl/Makefile.am    |   13 +
>   utils/nfsdctl/nfsd_netlink.h |   86 +++
>   utils/nfsdctl/nfsdctl.8      |  274 ++++++++
>   utils/nfsdctl/nfsdctl.adoc   |  140 +++++
>   utils/nfsdctl/nfsdctl.c      | 1426 ++++++++++++++++++++++++++++++++++++++++++
>   utils/nfsdctl/nfsdctl.h      |   93 +++
>   9 files changed, 2051 insertions(+), 2 deletions(-)
> ---
> base-commit: c6aa75d25b79121c4cf83ae09a04f8728c4e6593
> change-id: 20240412-nfsdctl-fa8bd8430cfd

I'm having a heck of a time to get this command to work.

On all of the sub commands I'm getting this error
     Error: Operation not supported

Debugging the "nfsdctl listener" command
the nl_recvmsgs() erroring out with -95

I'm assuming "nfnetlink" is the module
and it is loaded.

Something is missing... for all the commands
to fail like that... Not clear to what it is.

steved.


