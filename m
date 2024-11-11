Return-Path: <linux-nfs+bounces-7868-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9887C9C4394
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Nov 2024 18:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D97E2816D3
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Nov 2024 17:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F195B1A725A;
	Mon, 11 Nov 2024 17:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QqWgy6VA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CF614A4FB
	for <linux-nfs@vger.kernel.org>; Mon, 11 Nov 2024 17:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731346166; cv=none; b=VFqn8yzYyBudcWNwncPTOkmb8qLPD8bzoAb8Kp+PkrgLzwchiNv0d44SmmEeB07+H21zbvtr2N1LXBgwAEQu/Md+zXgFtVFbeHzlxhtVe3ckY5G6OKW3zwoRDziJ/Q7GpQTrtmOSKyihMySbukH3Pdjwn0l0TXL2pIvmRG+feRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731346166; c=relaxed/simple;
	bh=lV+w0dPU7Lw3ADnecbCV9RDsuQmvAOXmgzfKdeDz6eY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NGCEUDXKvOjnypxEAjRfPSp3HrJyDU4nlls8IqdUN4VZsLdA8zL3JAYH2fGwvuYRWpTSdL6OARS30/PvHaO9YGG2xLj3scY0hnyybjCBr1OScXg2h/yeWbyhpkRiURW8C3XO8yczg7CI6CGdvFrDuTAY5ikq4EJKhppwog6mQLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QqWgy6VA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731346164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b8ev59Cw9HuLp7HAgNCndqNWy2fgIzr4ojOt3FWhNIQ=;
	b=QqWgy6VAesCdtBTglVumxACiCeolaaDnzg1TM3p1+6I2e+z4ZTkLLXhSLwRxMDkOacdx5+
	ChTaycRLymQkXryN+qE18X4BK+HTji4yI9IhOo2EibtcpPhnsbY2pyHCZpl2/rsLd3wO1N
	XKFlYav3iMVW1hAcieaD5MNP0mVkZ3I=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-220-na2r1khxMpy9kMi0TMpqFw-1; Mon, 11 Nov 2024 12:29:22 -0500
X-MC-Unique: na2r1khxMpy9kMi0TMpqFw-1
X-Mimecast-MFC-AGG-ID: na2r1khxMpy9kMi0TMpqFw
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-83b567c78c3so511150539f.1
        for <linux-nfs@vger.kernel.org>; Mon, 11 Nov 2024 09:29:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731346160; x=1731950960;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b8ev59Cw9HuLp7HAgNCndqNWy2fgIzr4ojOt3FWhNIQ=;
        b=RsxoVqm5Ya7/HgCrkAahPHsAKg8gnJhvQ0L0h8k/ARbX0QDbVQXG6zpVZ+YdHYeGKE
         z2O5z0lYMV/DYsW4FjS3aera/9Aqe9YGX5crM+66/EvM/ZJGAdGohro6Dtqb2J5IGAj1
         aglf0ru0I3ms4In5EoTBbb7OfvqsT/sAD+aBKPQAfgbPSW3PKMznByT+VwaOKmPNuaFU
         y3iaRaI6fvpMO727UG4hukPSX/LuoAYRDooMjY89YMMO3HXCJZXlrb9a9MOuD4SrB6q2
         jvtqNgLHpvnNUJt5tL9kiURdRYCGLA99zrew+EWDeRhF94VUm64/v0voGs9nKnwU3dSW
         Q3ag==
X-Forwarded-Encrypted: i=1; AJvYcCUOOxkyu1WmRj0G9NwWthblmbd36RFyLVt3BZ03AqJBNjFfLxj7Izhl5Zpr4kqqDbT5CGLDrp3XZRc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpZS1v9z1wCqOoX3w1JEOCkUDpzx1zR2axM1mdD+sTAnKfMOd/
	P2pEMED44XREuFhvKgdvoZn1HaKhVtJjQntdYo5pc2mMThiOV6vl9XGt/5UVLUGAcrjVVqob6Ug
	mDzVy5yYO1j7iqlI43ANYEJdqLg5AWkanQ8m1wIXu6xUtGZv/3bynlRVVCpviwN0bTQ==
X-Received: by 2002:a5d:84c6:0:b0:83a:943d:a280 with SMTP id ca18e2360f4ac-83e008096c3mr1171814839f.1.1731346160556;
        Mon, 11 Nov 2024 09:29:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHPVTS3jN4e4tmvTrqadF1+cpE3+FFPlzr301L07wo1di3gq5s1U31Ki4iegv2p8yYse03DLg==
X-Received: by 2002:a5d:84c6:0:b0:83a:943d:a280 with SMTP id ca18e2360f4ac-83e008096c3mr1171811339f.1.1731346160182;
        Mon, 11 Nov 2024 09:29:20 -0800 (PST)
Received: from ?IPV6:2603:6000:d605:db00:d7de:cb5e:42f:cca3? ([2603:6000:d605:db00:d7de:cb5e:42f:cca3])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4de787f0addsm1455090173.125.2024.11.11.09.29.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 09:29:19 -0800 (PST)
Message-ID: <7ecb7822-0fc8-43e3-be85-37f94fef222f@redhat.com>
Date: Mon, 11 Nov 2024 11:29:18 -0600
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [nfs/nfs-utils/rpcbind] rpcbind: avoid dereferencing NULL
 from realloc()
To: Zhi Li <yieli@redhat.com>, linux-nfs@vger.kernel.org
References: <20230228083544.4035733-1-yieli@redhat.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20230228083544.4035733-1-yieli@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/28/23 2:35 AM, Zhi Li wrote:
> Fixes:https://bugzilla.redhat.com/show_bug.cgi?id=2173869
> 
> Signed-off-by: Zhi Li<yieli@redhat.com>
Committed... (tag: rpcbind-1_2_8-rc2)

steved.

> ---
>   src/rpcbind.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/src/rpcbind.c b/src/rpcbind.c
> index ecebe97..6379a4e 100644
> --- a/src/rpcbind.c
> +++ b/src/rpcbind.c
> @@ -471,6 +471,8 @@ init_transport(struct netconfig *nconf)
>   		nhostsbak = nhosts;
>   		nhostsbak++;
>   		hosts = realloc(hosts, nhostsbak * sizeof(char *));
> +		if (hosts == NULL)
> +			errx(1, "Out of memory");
>   		if (nhostsbak == 1)
>   			hosts[0] = "*";
>   		else {
> -- 2.39.0
> 


