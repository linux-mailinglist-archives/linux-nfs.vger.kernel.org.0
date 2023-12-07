Return-Path: <linux-nfs+bounces-387-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED11809193
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Dec 2023 20:38:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C25E51F2114C
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Dec 2023 19:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CCB74F8A1;
	Thu,  7 Dec 2023 19:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LBnm8U9O"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42833212A
	for <linux-nfs@vger.kernel.org>; Thu,  7 Dec 2023 11:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701977796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=43PalgbCrEkiI8n0ZCZ8vDGvEIvj3aXH5R4Ze2hxu1g=;
	b=LBnm8U9OgYNlRrUOlB8yzd+GqRg2if6fPO0Ey1/kUdp4EEa5Bk9VdSCtrLsVYde+igbFQk
	m4IoAsm89xPqUXfOQe5bgGTs9P3W+ClHhmrybviflxiOnHZU2ODnW2yLjg7iR1/bRj/8xs
	zYINcPSz/Izxc3SBDfPeYK6RtrGuKTU=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-iBcPjN5WMlC-0SnRJbZNFQ-1; Thu, 07 Dec 2023 14:36:35 -0500
X-MC-Unique: iBcPjN5WMlC-0SnRJbZNFQ-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-67ad0651f33so3331616d6.1
        for <linux-nfs@vger.kernel.org>; Thu, 07 Dec 2023 11:36:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701977795; x=1702582595;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=43PalgbCrEkiI8n0ZCZ8vDGvEIvj3aXH5R4Ze2hxu1g=;
        b=Vh5FKG5k+ONZzx/HScB8ksUbFwuALZtJjSczontQq4ghTg3IH8JPL6V/qBqZyT7vlN
         7675XinG5Rlbu9YPwv6bM+jlQCYgdTrADEH59kekIC4XjJIN3d3PlmhwYi/hsmjtRMu8
         NFWlOnmayYmAA6MGs1UbRbcxJ2md/k94bDNHoXmgtE1JmjIwef6YgPUoqmlXQZZVddhI
         mugiVh/U1S0cGbjnYlv41IxtjKKyJOfHQ+S8ycDFN9/SVD/Lc89evxQHM+1KdVlDa/WP
         MkwXVEcjSXswbZJ3rFWrTe4qNvg5sU5/oPfMxuHowgPxrxrLxWeCR0TIG0RS8ONXJ6SG
         NCog==
X-Gm-Message-State: AOJu0Yzz3as3R2u4+0EY5Jz76Q5/7PGkLrf4WglHbS8KpCW4Mu9W4AF1
	y+HE3yD33+4WJE5vs5XSVfvMae7zk7Os03a5Co28mBE9uFaS+WbtBWhtxsooi0fDBwsDBEwNw93
	2q7II4NosxTUTEm3/3Cs8
X-Received: by 2002:a0c:ef4a:0:b0:67a:e675:4657 with SMTP id t10-20020a0cef4a000000b0067ae6754657mr5954799qvs.5.1701977794764;
        Thu, 07 Dec 2023 11:36:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH923V3e8ltLSfjnA5olLzy5NTkpgvzu6fylpDypq4xEzEd4NgcqhXD4l6V3qMsxa2o+nCTEA==
X-Received: by 2002:a0c:ef4a:0:b0:67a:e675:4657 with SMTP id t10-20020a0cef4a000000b0067ae6754657mr5954785qvs.5.1701977794495;
        Thu, 07 Dec 2023 11:36:34 -0800 (PST)
Received: from [10.19.60.48] (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id lg9-20020a056214548900b0067a3ad49979sm144714qvb.96.2023.12.07.11.36.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Dec 2023 11:36:34 -0800 (PST)
Message-ID: <3dac71e2-e8a2-4c40-9d05-9369253914f3@redhat.com>
Date: Thu, 7 Dec 2023 14:36:33 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/5] Possible changes to nfs-utils junction support
To: Chuck Lever <cel@kernel.org>, linux-nfs@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>
References: <170050610386.123525.8429348635736141592.stgit@manet.1015granger.net>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <170050610386.123525.8429348635736141592.stgit@manet.1015granger.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/20/23 1:53 PM, Chuck Lever wrote:
> Bruce suggested, years ago, that the nfsref command should become
> the premier administrative interface for managing NFSD's referral
> behavior.
> 
> Towards that end, some clean-up is needed for the nfsref command in
> nfs-utils, which is presented for review here.
> 
> I'm hesitant to introduce more documentation at this time for the
> refer= and replica= export options if we plan to remove them in the
> medium term.
> 
> ---
> 
> Chuck Lever (5):
>        junction: Replace xmlParseMemory
>        junction: Remove xmlIndentTreeOutput
>        nfsref: Remove unneeded #include in utils/nfsref/nfsref.c
>        nfsref: Improve nfsref(5)
>        configure: Make --enable-junction=yes the default
> 
> 
>   configure.ac            |  6 ++---
>   support/junction/xml.c  |  3 +--
>   utils/nfsref/nfsref.c   |  2 --
>   utils/nfsref/nfsref.man | 60 +++++++++++++++++++++--------------------
>   4 files changed, 35 insertions(+), 36 deletions(-)
> 
> --
> Chuck Lever
> 
Committed... (tag: nfs-utils-2-7-1-rc2)

steved.


