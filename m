Return-Path: <linux-nfs+bounces-22111-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id VxzHC4JRG2oEBAkAu9opvQ
	(envelope-from <linux-nfs+bounces-22111-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 30 May 2026 23:07:14 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7461C6136C3
	for <lists+linux-nfs@lfdr.de>; Sat, 30 May 2026 23:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B036D3008762
	for <lists+linux-nfs@lfdr.de>; Sat, 30 May 2026 21:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0FC272E6D;
	Sat, 30 May 2026 21:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I9ibBPXA";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="uEaNOmny"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5C61FBC8E
	for <linux-nfs@vger.kernel.org>; Sat, 30 May 2026 21:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780175199; cv=none; b=GsESNlm8GAki8JEBmXRsnYLWLz1+nMCgWVG6cC8Ny+mfuavBH3wnKagTRr2IhklY9ysdq27jo1KRdKfFz2FiHb9CTtfzTUG3Get5/GmH7/tBKuCBK3fEw5dmbnY3aTqf4NfJji7Mwq9SGNUGGxSB1fhWL10jLb7OdLobyIiHvYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780175199; c=relaxed/simple;
	bh=fSWSFRZsYtlzsMNq0SAuX2u9uXHbl9mKKo6tEGJCyck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UvpR9LOe7Q38Gs7YU+c7sQZW6LxwNAfojqbYovxSIe380b0ce0UMo4nJ/rUDRKwWE8kxk4PvW22xJBZVyJa0M9B4qgfGHPGjrg/vpliNb8uMZRwXQVOBKWuwmDIFUrhl1Z/Uab/8lMapgE2WRl7q72fn7KrOfbpp7M3hWeY4sb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I9ibBPXA; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=uEaNOmny; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780175196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kUzrkD94ya+2Y8cl3w1n1ViHc3DtV48m7X0DobAryL8=;
	b=I9ibBPXAw8YHjbG/AfpFGyTOWj/fyfGY8aS+3UC30vhzwyHrGdMZrYBM2V/OZ4E2TZ3fex
	OUBhQgxsK2k9JSqzNl7gAQyRQqrsBemtgvyXeqWJFps063CHerWgBFYeOgCEX6TzEoofB5
	fhJFvJvk+kN0RBh7/OZAh4I6olmYcno=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303-pGMRo93pOAu3oMcr65qhsQ-1; Sat, 30 May 2026 17:06:34 -0400
X-MC-Unique: pGMRo93pOAu3oMcr65qhsQ-1
X-Mimecast-MFC-AGG-ID: pGMRo93pOAu3oMcr65qhsQ_1780175194
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-516d4a9e852so45626891cf.0
        for <linux-nfs@vger.kernel.org>; Sat, 30 May 2026 14:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780175193; x=1780779993; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kUzrkD94ya+2Y8cl3w1n1ViHc3DtV48m7X0DobAryL8=;
        b=uEaNOmny+MFSloh9clM94j1L5iLTmo/no/jbJ15vN7z3+nRs9WpPFTSdgfFa/XHQ0L
         0loZztWISZ4bT+v0uQDyExjjrD+WGFsTDRhCENMq5HPJTl59YLPuC/i8TUE2eBOdFUoi
         N2PZf7obN5XyKfRpfovi2nFqovB+egDB/3voxVOMQO7WqScf4EHVrHp3IiBLN2DXm9Bb
         mmmLXbsiWYCzjZQhGasGc7tsMgVOgnONt6mXll4n3+dyOXhjJv/57ulbIIWx9YZo6yrM
         /DjBt+A0C/DGo9gWHZRyDMjOOne7UFXoTYzwX/k83/BAKjLTwFxBPjsz+W4hmUhUSVJa
         5yKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780175193; x=1780779993;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kUzrkD94ya+2Y8cl3w1n1ViHc3DtV48m7X0DobAryL8=;
        b=nTTEI86iGQLDp2ImKKksu4r877roi00NGGZzNkOW+qOUOTjQUyF8B6LjzGqBw+1CsD
         dWGXaVze8z/rJRbV0bfi/4zMD8qAuElvychTjEjy1iGidwbCn+fN6FPTZF+XrJhJUOwo
         MIrANayW4CBDgvCAlGaebncEIUMNvOAAA0H6Lpe4GAbrfJAyuyAqqnG4FS+tAW1zwi2z
         NM3BTBTLRsKtDxhbcTsz6TOLM7IJ0nESn1o2mIA6i3RCdRY7Lr16FoUAscgUa7MEy9Zx
         RW5be+XhzGOBo8Ws6/xTXegjsQXldspZd0LRW8aVGb+K2y8rO925OqFttWXekIaypyRa
         BrIQ==
X-Forwarded-Encrypted: i=1; AFNElJ9KRKK5FThjf4U2jFiSS9a49Nbh1rBNmRia/9QjDy+1kCND5YUBGQAepclKFYMd13F09G9RpMkn56w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtNiBmMt6AzDRtug/OBL/TyXENt5/okczJeWlcCyUMEnPbjNVB
	v68iy3vfXh7ECbwH/+QdPVZL2HWvTKrJjQSAN/BY0Mdi6gSujwI0HhDQuquW+05dU3v0muarbk9
	DWPI0kxuzcWf0MLvia931RT/ZOc5GH4Yj5vblRGgsVmr6tiL1at3bmPEl0slt/A==
X-Gm-Gg: Acq92OGnuKMVS0pgZTIUF0GPfFY1zVDdUu+nUiYx1wontZN5IP0LxtVmUyOsPM9Xwtm
	+3+AHX5Cw2iHNsArnJ9exQFIb/USVnGvzgUHVQWBcY44Z2AWVRxLB8F6PLrO8kHDbx5oHruWKWU
	AUThsxv8aag2KIZIy+f/d1W6Yq5Gpqy44V0i+WNgi7TbaGrIyX4zj3OQ9+fa4RZLNJB9LCOLSMn
	c8v8EbgoXeVYOKEmm5QRGiH/6yVw8VBKm6rL2L1mGXjN54zUXSGqOSGDXsqoEaUKzorf4tM/7mu
	iDMqoFNqGC79Gp6jpmCQGfyTuIFGC1MT5Jq7Qj3cCIBzjuiL0LspbaNO7vcgnM0uHKCBiTaxDOL
	QvPvZ5ypPhUGa3xnHlACrc33H3hBdXqvy
X-Received: by 2002:a05:622a:858a:b0:516:da7e:e0ac with SMTP id d75a77b69052e-5173a655127mr58122681cf.23.1780175193673;
        Sat, 30 May 2026 14:06:33 -0700 (PDT)
X-Received: by 2002:a05:622a:858a:b0:516:da7e:e0ac with SMTP id d75a77b69052e-5173a655127mr58122361cf.23.1780175193313;
        Sat, 30 May 2026 14:06:33 -0700 (PDT)
Received: from [172.31.1.12] ([70.105.241.172])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51741b4cee4sm17453811cf.12.2026.05.30.14.06.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 May 2026 14:06:31 -0700 (PDT)
Message-ID: <ed6af330-1efc-492f-a545-b5203e55b2b9@redhat.com>
Date: Sat, 30 May 2026 17:06:30 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] support: mark unused arguments in netlink handlers with
 UNUSED()
To: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
References: <20260525-fixes-v1-1-b4247bf20c91@kernel.org>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20260525-fixes-v1-1-b4247bf20c91@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22111-lists,linux-nfs=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steved@redhat.com,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7461C6136C3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 5/25/26 8:34 AM, Jeff Layton wrote:
> Use the project's UNUSED() macro from nfslib.h to suppress
> -Wunused-parameter warnings on the error_handler, finish_handler,
> and ack_handler callback parameters that are required by the
> libnl callback signatures but not referenced in the function bodies.
> 
> Fixes: 3ddc8e81240f ("exportfs: release NFSv4 state when last client is unexported")
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
Committed... (tag: nfs-utils-2-9-2-rc4)

steved
> ---
> Just some fixes for some new warnings I saw crop up recently.
> ---
>   support/nfs/nfsdnl.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/support/nfs/nfsdnl.c b/support/nfs/nfsdnl.c
> index ece0b57afd4b..ded035b90b1f 100644
> --- a/support/nfs/nfsdnl.c
> +++ b/support/nfs/nfsdnl.c
> @@ -16,6 +16,7 @@
>   #include <netlink/msg.h>
>   #include <netlink/attr.h>
>   
> +#include "nfslib.h"
>   #include "xlog.h"
>   #include "nfsdnl.h"
>   
> @@ -27,7 +28,7 @@
>   
>   #define NFSDNL_BUFSIZE	(4096)
>   
> -static int error_handler(struct sockaddr_nl *nla, struct nlmsgerr *err,
> +static int error_handler(struct sockaddr_nl *UNUSED(nla), struct nlmsgerr *err,
>   			 void *arg)
>   {
>   	int *ret = arg;
> @@ -35,14 +36,14 @@ static int error_handler(struct sockaddr_nl *nla, struct nlmsgerr *err,
>   	return NL_STOP;
>   }
>   
> -static int finish_handler(struct nl_msg *msg, void *arg)
> +static int finish_handler(struct nl_msg *UNUSED(msg), void *arg)
>   {
>   	int *ret = arg;
>   	*ret = 0;
>   	return NL_SKIP;
>   }
>   
> -static int ack_handler(struct nl_msg *msg __attribute__((unused)),
> +static int ack_handler(struct nl_msg *UNUSED(msg),
>   		       void *arg)
>   {
>   	int *ret = arg;
> 
> ---
> base-commit: a806c9d65662ecf5d40c00d60a514e13ada8d76e
> change-id: 20260525-fixes-2d98ed62dfae
> 
> Best regards,


