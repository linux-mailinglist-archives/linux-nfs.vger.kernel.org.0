Return-Path: <linux-nfs+bounces-21635-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8BPBNV8bB2rnrgIAu9opvQ
	(envelope-from <linux-nfs+bounces-21635-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 15 May 2026 15:10:55 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 32DE25503D4
	for <lists+linux-nfs@lfdr.de>; Fri, 15 May 2026 15:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70F0A306B35F
	for <lists+linux-nfs@lfdr.de>; Fri, 15 May 2026 12:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A9A2010EE;
	Fri, 15 May 2026 12:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VYiS8LMi";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="oydsPSv6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A014C26158C
	for <linux-nfs@vger.kernel.org>; Fri, 15 May 2026 12:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778849557; cv=none; b=AnYmU4xoU91dQ5GtqJyQdraVxzwfR9XaBEG/Ypjh22VrqtkrY+L3vrK37gRDXC6ap+HrdTFv22BjyZnWk2CVGgPSF0SHyySLHZQsj4/FN83kyaCVFecN/nCUGm5+t/UPIR6/tAIn3PvYqScXw5eVH8gwAev3FARGabTXmabo7xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778849557; c=relaxed/simple;
	bh=avOheTGlF5sDWbnBOFFww7nbE8gEd0nYwjPpnm1e8GY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=EmEo8IJA47znRR2FqmobBUF4JywKsabDlRwLZjQ4EWcgs0uEgJ9RmNlTZi3adGeOXke/Fvo+W9194MxNNyiHCYZCu1YjAVtnPPJZpFB/vjwa5akcJ3Yh/TFhyQsI20y+vbMzab/a9Hw5t8GV0Knon7Y6T8v/bScbWSxe7QWDGuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VYiS8LMi; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=oydsPSv6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778849554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jAf7gNgnVPGzZ4K4FSbwbqPsuhJgEu4fQ1TiSKW6/i8=;
	b=VYiS8LMiFS25s2mluqUR4RmNMyOyZoZ5D0sttsY6t1hAwIJ77Ve0Ib0ONu7R+kkVFR8rGp
	ZMOogC5ZvPX4ZwaPpy302VtBz2m41R+OQeT5VS/sE5rtBlY/RYVhc7nENofU9YOJdzoNbH
	MlmqvL7bIk5RQ+CZaID4lWT4ji6Dmlw=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-411-qahdHZs-P2OBiPBDOOXczQ-1; Fri, 15 May 2026 08:52:33 -0400
X-MC-Unique: qahdHZs-P2OBiPBDOOXczQ-1
X-Mimecast-MFC-AGG-ID: qahdHZs-P2OBiPBDOOXczQ_1778849553
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8aca14d1faaso286861966d6.3
        for <linux-nfs@vger.kernel.org>; Fri, 15 May 2026 05:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778849551; x=1779454351; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jAf7gNgnVPGzZ4K4FSbwbqPsuhJgEu4fQ1TiSKW6/i8=;
        b=oydsPSv6cR/1wQPGSdUGu0s07iU4grmzTlMVys5dAuJmftijJi2hIuVNZP/o/Il8Zz
         71F3bExNKLWwpRSvKtte2tsrvS/gwdXkk+6EiZLUjrKH5ELr9P5dcsDiQip4qdb0vYnw
         1nO7VnZ+KAIq10XPyX9nG0XVgAgCo27/yPqUMTToDB2Dnwnwiun7JxIVGrXO/LnQvugs
         lFSQJyeFE0EVKY5fFRoFW+UA6uBfzVEMw18cIJIpn+5nhS1MYd7HsIP94bB74TCmrQMe
         1TGFYrsOlHf9pC0NJ4M2WGl5FUOsSKuTZZ2kyDElN4T3JJDrmqOAGzmYemVWyCAJLIf0
         bRJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778849551; x=1779454351;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jAf7gNgnVPGzZ4K4FSbwbqPsuhJgEu4fQ1TiSKW6/i8=;
        b=D+43is33gQVGtHZmPZMhzgyTlszhL1HgaWlBPwu2xvynbMKRxNsjKKTioeUAF9ETi6
         3e0UHz6N0I9X22c2GSkKII80k4y8lcbRnxYBsC39kwyubQgg7D7tl93jbUG4mf5bo+ex
         +Kaks3U0pF0sP3Ryf4tDzeqArkc7QCWGp10+24CdHCktsgV6d/Btx8CNnPXpP0haihfG
         3R7MamDVmAmaajDQCCwEpAEZULP9RoJU9NFTA9V8MhGyM+AGQzhV/kPVPclk7bRb4TBt
         8pF+yg8Fxx6z5Ir+/kjFV7UTFGmXoxtY5FeXI/5Sb7TvnnivcCQOwZoloilA+2O7DDLx
         LL2w==
X-Forwarded-Encrypted: i=1; AFNElJ8XG/yKH77+kTb5rO//ntqfcJwuvSuRMs/kX+ug/VjLk42ryh/KT36Lofx/aidghohtRsJ9Mg3P4ww=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZgRPUBaxpsIRZ3t/Yy5a2LnW5/cQOgcmOjxa0Y4WIqVMbwEVH
	nLjkubjXIe6CqixbnZJUD4pTocfHxfG2uhmN2HbkKPyYlEONT4bTQ/xRjdL52h4ONOH0CvfWS5H
	S5QtNUQjVsiSXQbKD3vJP6rdmPzDScZ1w3Uem/+mGHy2wVWQx5gz9yIzLrR08dlq8Q44SOw==
X-Gm-Gg: Acq92OFOGNHhYybKYfgfZmYA7yKVhHbNhsp+omaAQ9zpRBQYFnxHfIi31AhoigH8dzf
	afpw4SNjl5psplRDcEEn5jTIqBG6HCkLhnzLRXQCIbKw3RjLtlblKK/Y+Sr7FJKo/OMmP6ZAqbq
	YNGDBmHAy6VQsYQfzZi5da28ZhNIkH4Qisl6vt9LWXyhOvVX8r6v4vdbfu8sKS0zQk3yHJijEkJ
	TTGJ4hzwskLnTMPtd0hQjRQ5ctoiaw27wa6CM7TYGEoPG+MjgHWEzGg2rqsCcARFpUO80XSgx3T
	DMqrYSFVlOIQYhCdR7PFng12VGjJOY390GJAGSlQuhqEvRm1WL0VrzyQkYVvdhB6ygrv60hf9te
	a3kzS9ymMBooDQ/tBwfMmjw==
X-Received: by 2002:a05:620a:298d:b0:909:b197:4692 with SMTP id af79cd13be357-911d1335796mr564828985a.62.1778849551509;
        Fri, 15 May 2026 05:52:31 -0700 (PDT)
X-Received: by 2002:a05:620a:298d:b0:909:b197:4692 with SMTP id af79cd13be357-911d1335796mr564823285a.62.1778849551019;
        Fri, 15 May 2026 05:52:31 -0700 (PDT)
Received: from [10.17.16.21] ([144.121.52.162])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910bc83b0f9sm547197085a.29.2026.05.15.05.52.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2026 05:52:30 -0700 (PDT)
Message-ID: <b2b370b6-8576-493a-b124-776e1249c312@redhat.com>
Date: Fri, 15 May 2026 08:52:29 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] fh_key_file: fix missing string.h inclusion
To: Giulio Benetti <giulio.benetti@benettiengineering.com>,
 linux-nfs@vger.kernel.org
References: <20260408173535.3992116-1-giulio.benetti@benettiengineering.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20260408173535.3992116-1-giulio.benetti@benettiengineering.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 32DE25503D4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21635-lists,linux-nfs=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action



On 4/8/26 1:35 PM, Giulio Benetti wrote:
> Add #include <string.h> to fix build failure.
> 
> Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
Committed (tag: nfs-utils-2-9-2-rc3)

steved
> ---
> V1->V2:
> * no changes
> ---
>   support/nfs/fh_key_file.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/support/nfs/fh_key_file.c b/support/nfs/fh_key_file.c
> index 5f5eafc1..81ea1500 100644
> --- a/support/nfs/fh_key_file.c
> +++ b/support/nfs/fh_key_file.c
> @@ -26,6 +26,7 @@
>   #include <sys/types.h>
>   #include <unistd.h>
>   #include <errno.h>
> +#include <string.h>
>   #include <uuid/uuid.h>
>   
>   #include "nfslib.h"


