Return-Path: <linux-nfs+bounces-3942-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8993490BC46
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 22:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CFEE1F2248C
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 20:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2709216A94F;
	Mon, 17 Jun 2024 20:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="csHO33Ju"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1AF4D11B
	for <linux-nfs@vger.kernel.org>; Mon, 17 Jun 2024 20:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718656771; cv=none; b=mOsLp8MDgppq/rY3gzpghFcJviPN3lUBzPRnSmF2Vf+3YbtiueAnjtrzjIpt7XelRlwg5B9IC3OkHgPz4LMuaA0ZtluCZkYhfOJYpiCIR7FFXYV+Wwk35/ylG/pBstpCrSFyjdgbr5pKcewJpo8WOHXZGIIj5pYPwT1cWxz1s6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718656771; c=relaxed/simple;
	bh=AAYzZbThi4Qf5MzY6qJ1AcwRDoJxdhDcVdVcKtL7ijY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fk4dpZdAy9zF/DkhPN3GT7kHdUd8bU/3BOuyDbXhz4TP7NdkJOCrzP8eyRSmID9m/53RBE/C3cToU5vI+QSyXEtH2NpHVofHybjaN7CHXiHyIVWVzVHVNUsdWPQsqpuoctLf/fCHHBmU/vDZwrLpAJxusw5d4UQBBBhVv6yXAq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=csHO33Ju; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718656768;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zq3CD16CHMWfuBBtvmiQ8jMBkisb8ddvB21m05lvi+Y=;
	b=csHO33JuFmbuMzRqufBmbXDzQNoePCPGEHSx8Ot4B/WpxsfQEhW6e+/E/5heFZpbtTfwWs
	aulaD4RVx1eIBJuS3Y7nhpxUlnUn91fjdq2yD/Pk50f5xETHDmNGpRkr+JyIINnv9S2hce
	EttM9cXLF29y0Q5J4b206xLDJiCBXIA=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-Kb13WbYIM1WR-4CcdUSk4g-1; Mon, 17 Jun 2024 16:39:27 -0400
X-MC-Unique: Kb13WbYIM1WR-4CcdUSk4g-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4404d9bf846so3884641cf.3
        for <linux-nfs@vger.kernel.org>; Mon, 17 Jun 2024 13:39:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718656766; x=1719261566;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zq3CD16CHMWfuBBtvmiQ8jMBkisb8ddvB21m05lvi+Y=;
        b=K0FwojZoCNrH0NzNcA5h9vaEWd0/KwWABm/x1PNibkG9hOfonH+RUtQXIAnk8j7R+a
         LzHdRsWOZbSTDsxbFguluGIbVWmXko+MkiB0OGM4SWSTvKwDg2lhKQbmIAkfdx2kIqwD
         eej8RR7ZKUmpEEIGeCsrT5uHjyqgi13qFF/CAjI/2Aj1TNY0BuThCpqNITGP+KZQ9WtK
         W424wFEQV3l3zSx0XHa53uL84X+DtwSWTMQh+Su/hJo3pVeSPQkqO0LIE1IXDkooMpZp
         AFJYFXSwiUzQo6n4x5ASMIWZLaXSxJLsyGNxMdiVuQxrD9x1ptjU7UMzbQi42L7Bug0f
         ngWg==
X-Gm-Message-State: AOJu0YyKBjeJ4l2RhjxZDeNuB9wlyy23FzfPWiD4/+X8Ii2K6B1jhrhK
	v5vssELofzSbSqVm6tvW+hOlWMsIsvh/P951PJ+t+vegL8YKdaK6dDAkMJWXq3gr8eUkTnRVIkH
	ydu5EAH8yxGoGIAVcH1Ty3uTvfwCcq6YNzJjjJLTJBQhQeSzfwxcsWwZ9QQ==
X-Received: by 2002:ad4:5748:0:b0:6b0:6370:28d4 with SMTP id 6a1803df08f44-6b2b00b9b68mr116159016d6.6.1718656766496;
        Mon, 17 Jun 2024 13:39:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqxx1cdI7GIATc/HCf48qy9FcmyuDa1Q1mkTR+Iwk4PJh8Eb3UtgRj6qeFzRz/oD3CCAVs2A==
X-Received: by 2002:ad4:5748:0:b0:6b0:6370:28d4 with SMTP id 6a1803df08f44-6b2b00b9b68mr116158786d6.6.1718656766051;
        Mon, 17 Jun 2024 13:39:26 -0700 (PDT)
Received: from ?IPV6:2603:6000:d605:db00:165d:3a00:4ce9:ee1f? ([2603:6000:d605:db00:165d:3a00:4ce9:ee1f])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5c3009csm58787286d6.62.2024.06.17.13.39.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jun 2024 13:39:25 -0700 (PDT)
Message-ID: <fc356631-3bfb-4c08-8106-6bc7109fac7f@redhat.com>
Date: Mon, 17 Jun 2024 15:39:24 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH nfs-utils v5 0/4] nfsdctl: new nfs-utils tool for managing
 the kernel NFS server
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org, Lorenzo Bianconi <lorenzo@kernel.org>,
 Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>,
 Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>
References: <20240613-nfsdctl-v5-0-0b7a39102bac@kernel.org>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20240613-nfsdctl-v5-0-0b7a39102bac@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Jeff,

On 6/13/24 11:44 AM, Jeff Layton wrote:
> Hi Steve,
> 
> The new netlink management interfaces [1] have been merged for v6.10
> [2]. Please consider merging this series into nfs-utils. I think the
> code is fine but it may need some autoconf/automake love. See below...
With these... I'm going to make a release, once I get a couple
other patces sorted out, and then apply these as the first patches
after the release since they are kernel dependent.

steved.

> 
> This series adds a new tool to nfs-utils called nfsdctl, which is
> intended as an eventual replacement for rpc.nfsd (and maybe other
> tools). It's a subcommand based interface like nmcli or virsh, so we can
> easily expand the interface later to deal with new sorts of
> configuration.
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
> This does ship a copy of nfsd_netlink.h along with the tool that gets
> used if the uapi headers aren't new enough. This is a temporary measure.
> Once new enough kernels are shipping in the field (in a year or so?), we
> can drop that and some related autoconf junk.
> 
> [1]: https://lore.kernel.org/linux-nfs/cover.1713878413.git.lorenzo@kernel.org/T/#m5fd847189894f58e93706c40340e18858f242a27
> [2]: https://lore.kernel.org/linux-nfs/171606732267.14195.18399250065227381901.pr-tracker-bot@kernel.org/T/#t
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
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
>        nfsdctl: asciidoc source for the manpage
>        systemd: use nfsdctl to start and stop the nfs server
>        nfsdctl: add support for pool-mode
> 
> Lorenzo Bianconi (1):
>        nfsdctl: add the nfsdctl utility to nfs-utils
> 
>   configure.ac                 |   19 +
>   systemd/nfs-server.service   |    4 +-
>   utils/Makefile.am            |    4 +
>   utils/nfsdctl/Makefile.am    |   13 +
>   utils/nfsdctl/nfsd_netlink.h |   96 +++
>   utils/nfsdctl/nfsdctl.8      |  293 ++++++++
>   utils/nfsdctl/nfsdctl.adoc   |  152 ++++
>   utils/nfsdctl/nfsdctl.c      | 1584 ++++++++++++++++++++++++++++++++++++++++++
>   utils/nfsdctl/nfsdctl.h      |   93 +++
>   9 files changed, 2256 insertions(+), 2 deletions(-)
> ---
> base-commit: 94b48ccc0b0304809027fcead03343f4c716c4f4
> change-id: 20240412-nfsdctl-fa8bd8430cfd
> 
> Best regards,


