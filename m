Return-Path: <linux-nfs+bounces-18353-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yGGsJFSHc2krxAAAu9opvQ
	(envelope-from <linux-nfs+bounces-18353-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 15:36:04 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3038677247
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 15:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 619753001597
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 14:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410CA24468B;
	Fri, 23 Jan 2026 14:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JZDjN7AU";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="EL2TlcLL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C46A930
	for <linux-nfs@vger.kernel.org>; Fri, 23 Jan 2026 14:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769178924; cv=none; b=s5Z7M1+7wySk7OM1OH5/pCiKsheWAS/YRh90s5qq6AvSPO00DPSemSyDoqd8IS1J6HhmDI3NNBjn2PkjfU3gu5C7M6SsRvIPcvQZ+2+ED88/ytCCnuaDeKurKO4aIK8g0KfflF6ZzsnDNlLun123+BBKVx77RSm8vp9mBr+iYZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769178924; c=relaxed/simple;
	bh=PAdsefzrrZ1xaC8cC3WCC6zXeXI5h8kRPgpXsT5+rMY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PqfATCfH96oDkHijq2Jjsa4cF7JswpOtNV1Kft/CRibBCsETL4Yk7nRDlbyYzpCQw2zmZ8DOq8H4fySLIEm9YJfOkhpXIJwHQxROIQuSOadWnPyuOZzEmFoTe+zaojFj1OWL5XZvfoSXgwCY0ostUoJmB2sK14+ZKkwDEzNIfXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JZDjN7AU; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=EL2TlcLL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769178921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EDcHQn9C/gokEhBlLQhjSx406Sk+RPHdWhKQ92xoLxU=;
	b=JZDjN7AU8/IsQrKnPoDKFPQ2NmwA552bTtTWne38ab4qa+WsSY6hCmqwzoUulGc05gGRJF
	VzQHAlg4dkdF3/1V9qUvEwOjHMB0tQFusqZ23WI4loJ5vv1cpzvovjC/as2fHo0pbPdjLI
	A2iTqLzzX5S+9vF5045pK8oTrZMrSC0=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-lcXoY-4YOsGgubHI_0XjuQ-1; Fri, 23 Jan 2026 09:35:20 -0500
X-MC-Unique: lcXoY-4YOsGgubHI_0XjuQ-1
X-Mimecast-MFC-AGG-ID: lcXoY-4YOsGgubHI_0XjuQ_1769178919
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-29f2b45ecffso32949515ad.2
        for <linux-nfs@vger.kernel.org>; Fri, 23 Jan 2026 06:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769178919; x=1769783719; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EDcHQn9C/gokEhBlLQhjSx406Sk+RPHdWhKQ92xoLxU=;
        b=EL2TlcLL/y9HDfNbK+MhPBz2DYo/UHGl/fYQ+jT+bNVQ31WDM9emh42USuT+lsRFeJ
         4RJl6oeULnhUqiprcpM0mYa3L983Nc49oPLkNnvGmweN4dPCulJxtq+DU40MaC3usLGL
         aPJjccj7cfcc8kpMX8hvdNoAzH5hMzGUf7euyocBM3o6MHyiB2wEgNroEd+TG5A/CK0L
         JJKjpLoOL5c/z8DevlEtAmSvrLjR2zwxKfKXaVDbVjT0bdR8c5DLi3RoVjwWlzcM7HjT
         ifD/hOKGmPSRqyf9Fn6Go13BIEfC7qAjY7i8o2Xi99XWTUeGyo4R/Am0h6ZFXjmOYv1G
         IYMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769178919; x=1769783719;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EDcHQn9C/gokEhBlLQhjSx406Sk+RPHdWhKQ92xoLxU=;
        b=Qwa66+t03gUiah3EVWuP/BSOvalFIDD7iLrroVCsNimF3QNkZkvUdl1whFutZqTVFa
         LXNkwiAdeBUfude0j37ATXNGSxFxaqGvAye67WSrdSl2jMw958em1EAiT5Ul8c1GLh+V
         np4H0lfvrbvbc2EtPVAa/9ddcBQm18Vwfs6kgOPqJsnUvgh4bpNuDMvZqSHUlQYHDz5c
         ZU3wSqzBe9bO9sJ6ZlMHxw+3Nyh9vnmO6e27zDu2cWKAYpPekLAzj7vskgOXoYW10WII
         BxeRREsnKbDOvq/+Ux9T2giDNUDSj9WazUOk2M9TyhExggzg5QYM038Tf0qiL6gYOe1M
         tb7A==
X-Gm-Message-State: AOJu0YwRssHHWgrEH3ahSikEZZJ3H3k2vHwWl5v5ccF1mXOjdqTVc3Oh
	UUA+ALnmLxBMjeKyhiFUNsul3GFvxYcYI58PAqRU+QEo10DPT55R/1Zu1mF4yazhBLW6irmPG8y
	6L0SD/v+1JbcadG4kkMRZuMUU8Zja8m5Rkt5G3n2I81ngZ6VUYiiRzHn0PmUy1g==
X-Gm-Gg: AZuq6aITeqBR0o4ocZgnSGsnKMQ/hkjEqlGPgg7yEWl5ad52hxzCgKKuKTzvM7FuiSq
	guwjfcFe/ea10CAsg+yKcO6HRZ6sKojw4+JmwO8nLu9umHPeKSX4w/gRcxPB8b3xiFZ6TmXEjZH
	xLaYpcchGpUAVVkcd0xZYO5o9lR4TYrUE9afy6G3Wbt8lYMtbUxIrbU7S/pojvNxTDS7VIOWABL
	WlpIAl5gMbOSRQPqMrBTGrS9K/FO5+VFIZgNw7h70/klS31V3VH1bAa5iU5/BkJnjoRTt6646yV
	h+h4DGlmlBQXAZJWeBr+LyrTbT/RYoJ194V0dzSkBee2dndF+t1lQl2IHAHWNnCzkKM30ct9TQh
	3oVElPG95FQ==
X-Received: by 2002:a17:902:e547:b0:2a0:cccf:9d24 with SMTP id d9443c01a7336-2a7fe56c13emr29852475ad.16.1769178919219;
        Fri, 23 Jan 2026 06:35:19 -0800 (PST)
X-Received: by 2002:a17:902:e547:b0:2a0:cccf:9d24 with SMTP id d9443c01a7336-2a7fe56c13emr29852025ad.16.1769178918668;
        Fri, 23 Jan 2026 06:35:18 -0800 (PST)
Received: from [10.17.16.21] ([144.121.52.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a802fb0262sm22215685ad.70.2026.01.23.06.35.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jan 2026 06:35:17 -0800 (PST)
Message-ID: <4f9e3ca5-fd16-48f0-895a-9ac74004bf69@redhat.com>
Date: Fri, 23 Jan 2026 09:35:16 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Add missing exports for rpc_gss_getcred +
 authdes_getucred
To: Trond Myklebust <trondmy@kernel.org>
Cc: linux-nfs@vger.kernel.org,
 Libtirpc-devel Mailing List <libtirpc-devel@lists.sourceforge.net>
References: <7a1ece728aaa225a92d4d639e3f7797ae7bfb9ac.1759775772.git.trond.myklebust@hammerspace.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <7a1ece728aaa225a92d4d639e3f7797ae7bfb9ac.1759775772.git.trond.myklebust@hammerspace.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18353-lists,linux-nfs=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steved@redhat.com,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,hammerspace.com:email]
X-Rspamd-Queue-Id: 3038677247
X-Rspamd-Action: no action



On 10/6/25 2:52 PM, Trond Myklebust wrote:
> From: Trond Myklebust<trond.myklebust@hammerspace.com>
> 
> Both functions are listed as part of the official API in the libtirpc
> manpages. However they are not listed as being exported, and therefore
> do not turn up in the shared library.
> 
> Signed-off-by: Trond Myklebust<trond.myklebust@hammerspace.com>
Committed.... sorry it took so long.

steved.

> ---
>   src/libtirpc.map    | 5 +++++
>   src/libtirpc.map.in | 5 +++++
>   2 files changed, 10 insertions(+)
> 
> diff --git a/src/libtirpc.map b/src/libtirpc.map
> index 479b4ff044b5..0d0f2f4cdf75 100644
> --- a/src/libtirpc.map
> +++ b/src/libtirpc.map
> @@ -295,6 +295,11 @@ TIRPC_0.3.3 {
>       svc_max_pollfd;
>   } TIRPC_0.3.2;
>   
> +TIRPC_1.3.7 {
> +    authdes_getucred;
> +    rpc_gss_getcred;
> +} TIRPC_0.3.3;
> +
>   TIRPC_PRIVATE {
>     global:
>       __libc_clntudp_bufcreate;
> diff --git a/src/libtirpc.map.in b/src/libtirpc.map.in
> index 6cf563b443b1..6c0b9b2e8bac 100644
> --- a/src/libtirpc.map.in
> +++ b/src/libtirpc.map.in
> @@ -295,6 +295,11 @@ TIRPC_0.3.3 {
>       svc_max_pollfd;
>   } TIRPC_0.3.2;
>   
> +TIRPC_1.3.7 {
> +    authdes_getucred;
> +    rpc_gss_getcred;
> +} TIRPC_0.3.3;
> +
>   TIRPC_PRIVATE {
>     global:
>       __libc_clntudp_bufcreate;
> -- 2.51.0
> 


