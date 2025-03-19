Return-Path: <linux-nfs+bounces-10699-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE5DA699B1
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Mar 2025 20:47:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 799A517F37D
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Mar 2025 19:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC31218FDAF;
	Wed, 19 Mar 2025 19:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SkpjOJzO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE23D1E51EA
	for <linux-nfs@vger.kernel.org>; Wed, 19 Mar 2025 19:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742413659; cv=none; b=H8/fJXwvA1SrImBeV6MAiVpUbsHG0YiRK0yXPpKmfKEJq4XsUAt05W4gXnghXUL4LNz1MZOQvIeX4FXjrHkucWD8PgLhtmicRKtQzhAeAV+qgyBFnjMIW1MdZPdh0xXTvC+7pNYKt3d645x63D+R0XYMZkfX44a6ApnkHGv4HQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742413659; c=relaxed/simple;
	bh=zSgn7a36y7z3u1xUS4tdGnJNtMUFGthOugrog0In3rY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Abj+EHdMBm0JFP20TQVfCGdf1gnJotagLk553aXeww0VsJD2Kp1he2yazW5ocuJ2k/7N8T73hb1w/yyeLmdFap2K092sOVhEHV0j6nZe40FxtzBRA2HskbSp6ggSw5lg3eRPYR2cy39SBZ1amWupgdYqK+eZLMpi85r0k/Mw7LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SkpjOJzO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742413656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H0YY2Fg6qo+PXQq1ViNkAlDNeK3rwWonU/T1UIHfgZQ=;
	b=SkpjOJzOE0ABg3EtHw+hRWcQDMVSfvUzZUgLLmrcr7O2fyxwFo/epuNckSdh7wse3+PM7j
	qR8qAc4U/4p48A/STu1n4npQow31w8N8gliU6hKUXCt9q2j0H4oLtlPutiEqV9fPPrh1Uz
	OJ0BEqK5REhrhg3mb7u3pqoQYkRrNTE=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-3HFi81-wMYOG0OMSZEbghQ-1; Wed, 19 Mar 2025 15:47:35 -0400
X-MC-Unique: 3HFi81-wMYOG0OMSZEbghQ-1
X-Mimecast-MFC-AGG-ID: 3HFi81-wMYOG0OMSZEbghQ_1742413654
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3d586b968cfso802265ab.1
        for <linux-nfs@vger.kernel.org>; Wed, 19 Mar 2025 12:47:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742413654; x=1743018454;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H0YY2Fg6qo+PXQq1ViNkAlDNeK3rwWonU/T1UIHfgZQ=;
        b=ljqMMsMfOP++lMdcREQXF7Iwfj+LMoIGo3KnLQ3p9XZr8KGNoDQqZNwEniecFAXRVX
         1md3xEdhZGRgJJbE6WNiqOVImFEBa716R7Y1o1E8GXWN1zq2IMKRFTpjtW+AiKMUUrcr
         4Pv1rRdBAG7BNgXfTgbXD/dIC4aFYW8IO7okOEDWnsCF/J3pHc2QvvW6X9DTVeGjTi7t
         FNq3s58gGlxRQ5npOtsiyJLR1hP6FVhYEDSf+APmDfdnglA14ht2kyhm56SXmfIGpbAd
         z6tsmu2JOgR/lq//HOW0/oVeXk5A7Sz05UcPexIJjD+TQo7Z+FJTJmXr8JtbNGEHzXQ1
         PJQw==
X-Forwarded-Encrypted: i=1; AJvYcCV0NPz6Jofr9GFkKhjAvEMezMmQ4WUFIntwzFINR0VkWwcUd+CBGrunYW5e8VmlljK+ZXQFkjApZUE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7ie2Vx0lPSJ5KyzynHccNxNiMvReVCIzgsv6g8GmnovhCvivq
	S+K6U4xbwGswCIWdDZxN92ac4Q9Bg1KggVVuRlaMOo5NNF9azNfIx0TdnD9kuR2gUPErASPbvcv
	IzalQwCHE4NBH0lnRm2jky9bpcTGRQJnmcA6vTw01O5joCEFSggBUxrKJ6w==
X-Gm-Gg: ASbGncs8IxIQraKPvsd9ZvDOPrCiYP0P3SL42s+krGiBzZXnECGysGKySeWoDgYn+0T
	YQ+RwmieV3GuVgkR3a1B9mgacIKnFBDzI3VqiQr/lF0O0wm6nanex+OZ2VXq92l/OltLMxl88w2
	VDzXBw/it9+BBXfc00Xurj+QHW6XODTrCB06gs8AKykFR7wK7/LlvEk60PxLYsb0PUuwysSxYWF
	3hVdE3ipue7EaMldMD1oDnqw2RaKnfFVbyBOJNGVHX0AhA87R4CB/maqXIfmNc/DYz0E5ZHY4FQ
	PqruVrR8ompiAAmq
X-Received: by 2002:a05:6e02:216a:b0:3d3:d132:2ce8 with SMTP id e9e14a558f8ab-3d586b2fd20mr44119155ab.9.1742413654386;
        Wed, 19 Mar 2025 12:47:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBpkk8rAE9zMrjCCESZS6pEdz0EliTaQ27k7O5uKlrsQQT7QZ3PiesWHFA5q4MTmOchEB/Kw==
X-Received: by 2002:a05:6e02:216a:b0:3d3:d132:2ce8 with SMTP id e9e14a558f8ab-3d586b2fd20mr44118955ab.9.1742413654100;
        Wed, 19 Mar 2025 12:47:34 -0700 (PDT)
Received: from [172.31.1.159] ([70.105.248.172])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f26382a6b1sm3355814173.139.2025.03.19.12.47.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Mar 2025 12:47:32 -0700 (PDT)
Message-ID: <98af0777-af0e-466c-be1b-e5b727e8ec97@redhat.com>
Date: Wed, 19 Mar 2025 15:47:30 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] nfsdctl: add support for new lockd configuration
 interface
To: Jeff Layton <jlayton@kernel.org>
Cc: Scott Mayhew <smayhew@redhat.com>, Yongcheng Yang <yoyang@redhat.com>,
 linux-nfs@vger.kernel.org
References: <20250110-lockd-nl-v2-0-e3abe78cc7fb@kernel.org>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20250110-lockd-nl-v2-0-e3abe78cc7fb@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/10/25 8:46 AM, Jeff Layton wrote:
> v2 is just a small update to fix the problems that Scott spotted.
> 
> This patch series adds support for the new lockd configuration interface
> that should fix this RH bug:
> 
>      https://issues.redhat.com/browse/RHEL-71698
> 
> There are some other improvements here too, notably a switch to xlog.
> Only lightly tested, but seems to do the right thing.
> 
> Port handling with lockd still needs more work. Currently that is
> usually configured by rpc.statd. I think we need to convert it to
> use netlink to configure the ports as well, when it's able.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
I have reluctantly committed these because the
nlm arg still fails (genl_ctrl_resolve() is not finding the family)
but all the other args seem to work and other patches
are dependent on these that do fixes bugs.

The Bakeathon is coming up so hopefully we can test these
patch there.

Committed (tag: nfs-utils-2-8-3-rc7)

steved.


> --- 
> Changes in v2:
> - properly regenerate manpages
> - fix up bogus merge conflict
> - add D_GENERAL xlog messages when nfsdctl starts and exits
> - Link to v1: https://lore.kernel.org/r/20250109-lockd-nl-v1-0-108548ab0b6b@kernel.org
> 
> ---
> Jeff Layton (3):
>        nfsdctl: convert to xlog()
>        nfsdctl: fix the --version option
>        nfsdctl: add necessary bits to configure lockd
> 
>   configure.ac                  |   4 +
>   utils/nfsdctl/lockd_netlink.h |  29 ++++
>   utils/nfsdctl/nfsdctl.8       |  15 +-
>   utils/nfsdctl/nfsdctl.adoc    |   8 +
>   utils/nfsdctl/nfsdctl.c       | 331 ++++++++++++++++++++++++++++++++++--------
>   5 files changed, 321 insertions(+), 66 deletions(-)
> ---
> base-commit: 65f4cc3a6ce1472ee4092c4bbf4b19beb0a8217b
> change-id: 20250109-lockd-nl-6272fa9e8a5d
> 
> Best regards,


