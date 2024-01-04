Return-Path: <linux-nfs+bounces-912-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17DA78239C1
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Jan 2024 01:46:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D2341C249D3
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Jan 2024 00:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD117A2A;
	Thu,  4 Jan 2024 00:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KlBC20sG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5242EA29
	for <linux-nfs@vger.kernel.org>; Thu,  4 Jan 2024 00:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704329154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KkWwSNklpJ8E06Au5xFEoxWh+RdWypKvqiwsHLu/U1A=;
	b=KlBC20sGnlxe26rYK+5KeLGdi3576t/pOpDiOFEDO0T1mPzNvnJZhINHXsB4niS9TR3m5o
	f4Z+Ppt7R+Mxvzo+sCch/Rk22J8mwkPpCwiv9DxSnThg64HS1c3Pf3vlE0hNJ/A2WZmQm0
	MADeFy9potM0/PI/2A8Hf9fkhm9GIJM=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-82AnVoawNWCevMmnBgz6pA-1; Wed, 03 Jan 2024 19:45:47 -0500
X-MC-Unique: 82AnVoawNWCevMmnBgz6pA-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-28bea0ff98cso2521874a91.0
        for <linux-nfs@vger.kernel.org>; Wed, 03 Jan 2024 16:45:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704329146; x=1704933946;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KkWwSNklpJ8E06Au5xFEoxWh+RdWypKvqiwsHLu/U1A=;
        b=linqzTeE/RtrF422PHAGxENEjDgbJKBkh1SGxUrtV6QJRRGmokEkYZM1tKaqxOOyGl
         g1Dv6Mc/90mhQheiHHQiB5zLLhBXpoQFm+hkaQ2XOVN/x0CPhrrLuUthJEEarQtDebGH
         HV6P/Ub+La46kpcv1FVGIKhkNoEVUhmhldp8aXhnWVlcE12b3SyqrKgBJP8TpA8SF1qN
         Oy5PL8fp7Z8jmQFrLuBkQ3llD+Ig4A7QtpvAj43POijkrTzUolp90JsOS0kKfbrfRLyh
         rOTJQ4Gv4Wso/tsdXkIxF0ObyDyA/9x26f2lIqrcz/2923q2+2PSccJbTS41o/TOW9Cb
         T2rA==
X-Gm-Message-State: AOJu0YxS3QPdecAfNC3U+wb2WVg6Yj1cDyHUQwT1jcULJz1zIm9i5B/K
	7oF+Ata1XXSRCOwQxBKoCSiIB/3ryJl5tquHbjUf1vQnEyOH3sYvUpqvQK00aa7CeIvnOm+face
	w/jkFOZum8+e2LqsGdzqGOzosGRMc
X-Received: by 2002:a05:620a:1918:b0:781:917:bc0f with SMTP id bj24-20020a05620a191800b007810917bc0fmr42998591qkb.4.1704328718488;
        Wed, 03 Jan 2024 16:38:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEBLukOPQzgwj4ha++GuUsW2JUCc49tUL7tOV4NU4jz1cUyei2LsVtmQvThyuKOwNQyJMyJ8w==
X-Received: by 2002:a05:620a:1918:b0:781:917:bc0f with SMTP id bj24-20020a05620a191800b007810917bc0fmr42998584qkb.4.1704328718162;
        Wed, 03 Jan 2024 16:38:38 -0800 (PST)
Received: from [172.31.1.12] ([70.109.152.76])
        by smtp.gmail.com with ESMTPSA id z27-20020a05620a261b00b007811b8e3ff5sm10680889qko.48.2024.01.03.16.38.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jan 2024 16:38:37 -0800 (PST)
Message-ID: <9fc4294f-4fb9-45b7-a4e8-7243f075ea16@redhat.com>
Date: Wed, 3 Jan 2024 19:38:37 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] nfs-utils: handle BAD_INTEGRITY ERROR
Content-Language: en-US
To: Olga Kornievskaia <olga.kornievskaia@gmail.com>
Cc: linux-nfs@vger.kernel.org, chuck.lever@oracle.com
References: <20231206213332.55565-1-olga.kornievskaia@gmail.com>
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20231206213332.55565-1-olga.kornievskaia@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/6/23 4:33 PM, Olga Kornievskaia wrote:
> From: Olga Kornievskaia <kolga@netapp.com>
> 
> This patch series is re-work of the previous patch series that handles
> gss error for bad integrity. In this version, gssd is changed to use
> rpc_gss_seccreate() function in tirpc which exposes the gss errors to
> the caller. This functionality is further checked with configure for the
> presence of this function in the tirpc library.
> 
> Note that the current libtirpc (1.3.4 version) needs a fix to
> rpc_gss_seccreate() to work correctly for the gssd that passes in
> credentials to be used for the gss context establishement.
> 
> Olga Kornievskaia (6):
>    gssd: revert commit a5f3b7ccb01c
>    gssd: revert commit 513630d720bd
>    gssd: switch to using rpc_gss_seccreate()
>    gssd: handle KRB5_AP_ERR_BAD_INTEGRITY for machine credentials
>    gssd: handle KRB5_AP_ERR_BAD_INTEGRITY for user credentials
>    configure: check for rpc_gss_seccreate
> 
>   aclocal/libtirpc.m4    |  5 +++++
>   utils/gssd/gssd_proc.c | 26 +++++++++++++++++++++++---
>   2 files changed, 28 insertions(+), 3 deletions(-)
> 
Committed... (tag: nfs-utils-2-7-1-rc3)

steved.


