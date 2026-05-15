Return-Path: <linux-nfs+bounces-21634-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IElzKAEYB2qQrgIAu9opvQ
	(envelope-from <linux-nfs+bounces-21634-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 15 May 2026 14:56:33 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F190550018
	for <lists+linux-nfs@lfdr.de>; Fri, 15 May 2026 14:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1F823303AF9E
	for <lists+linux-nfs@lfdr.de>; Fri, 15 May 2026 12:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630192652AF;
	Fri, 15 May 2026 12:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HmcIt7yS";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="rIxl0u1O"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37C52701B8
	for <linux-nfs@vger.kernel.org>; Fri, 15 May 2026 12:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778849545; cv=none; b=KndRAQy7SX+osEcBT9G/50WopPYrW+uL5yCxgsPaJ8TkZKRne4pFa5rbEAfgk9pRiPrgH9zcQA/ll2afPtykHr5r7+ErctuRgc3Bcvn2KfgHLzi8oYEiwhqkEc1vEj0hi50dS13uSrMnM35xGwFbgqc6fK8nqNh0rNDYATGCbeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778849545; c=relaxed/simple;
	bh=ZjDOMYC5Ar6O8cBcD4ar+74n+A1GVTCa4oW9DtJJrrg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=V1YeFaG3q0/uqyPMV2+cdBC829u5t4Dx9IDB9xwD/leeeV4QdtVl+/jcZj3Uk8amZkMckQ92jMQr/zaseKTCTWa8vvrSgpJzNFqT5xymW5mQqNi0E6RH2H2v5B4wrEosvrywNDN/pndQ7gJnAEwuPv4aQZ8k4LtvZrLULRyUgUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HmcIt7yS; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rIxl0u1O; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778849542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5zMwYkZTZDv6iF84JmlPnKLybvxBF0GID4tmUif16pk=;
	b=HmcIt7ySzJi96ya4M6tr2BwOobgViEVam7fkoVbTqYrenyswIDvhOMgdTJwvLZQr0ADPB4
	56b6jnxS45TBl0uxki9q5h1RqCr+rvzNujEbhtkRlFFVVXeHeVsK+dArh+6p+Da7pC0hvY
	fhjS21ql9h7f9PF9UAYHklMZ/+7AG/M=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-0IErFPe8M3u0zKUN-5sB8A-1; Fri, 15 May 2026 08:52:21 -0400
X-MC-Unique: 0IErFPe8M3u0zKUN-5sB8A-1
X-Mimecast-MFC-AGG-ID: 0IErFPe8M3u0zKUN-5sB8A_1778849541
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-50ea1a7a5d0so115542191cf.3
        for <linux-nfs@vger.kernel.org>; Fri, 15 May 2026 05:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778849540; x=1779454340; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5zMwYkZTZDv6iF84JmlPnKLybvxBF0GID4tmUif16pk=;
        b=rIxl0u1OrRW80+/XbdNcUTJoti9Ompcr5DRXsVk2EXKIcCeEK58BLvfv6PaKiVrQS4
         Cpx+OE8ujab6SHZKgFChvHMsFmJVxsuJfp6Bykx2KAF0AJ7SmKGkpwNcVI2+MQSRQoAk
         ABi9h1b+O+zHhDWvd19R0a3zdLANyvBAmy4VPF2Zexng5sPoJHu/n5tbm36tXVL6ZLGj
         MXrIFo41VmvtfORr1XP0PuZMXAxzGW1KhWm2EZnthVXDbKrpjoYN5fOp4vIasVe/y0Pw
         Yc91Bf57qZb1SchJHnHXY/1shKBSdDE28j/WAzGOnHOpz74+pBszxZbI7Zkjb6+b6Wl0
         eQPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778849540; x=1779454340;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5zMwYkZTZDv6iF84JmlPnKLybvxBF0GID4tmUif16pk=;
        b=T3+UH6xfxQ64yqjzv9kq0TJvH050sp3xcmHuWQTHNcLvLLFivOl1Ta6ELjDhjFRF6o
         m0Wh0HrY3pR7yZNceTyIJDhV6nzO654iDAKhJXzuz0IC3IJezNLkJMDGKQDCyzlW7z8k
         Bsh03vdu0tPxIElB8I+wgvVSZKMZwj66kfLVWs7U0QMJ3uDVkobhE52pO+vsN8GHyf9E
         WwOPL2spXWOIGRTMO5L3eMtOAtxXQeqd4rx+iAxZEX4qD6bt+32Tbrzz4X0anY+q9azK
         91gCheuynVxCGMydh99BFp79XR09Jtm9XBuYwwCLg0csvczGNnMUfZrzl4vJ+Zb6kUJe
         SngA==
X-Forwarded-Encrypted: i=1; AFNElJ8Gw366+SY8Ea7dGdBczjtOytbRTqVugz4yMFcAYC5/5qAkKz9A3F+swTvt/ePIH2xgRvQC5wvXlWo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6yeRLMPrb/hQtmabWDSvQjo0Nc5vdNjRTD3Bg9yIdxxNzuM+I
	KaYLVwO7DBZ3geIXAje2PteuBqEj0rCdaTk6VFfj01egvJcWlq1y38tfCEuwFaKebZXSIGvNBfw
	wTPCAY7KkGAymBJ9vNmyGqO52ghqY/DPBcLBj3uYHyEIaSf0revd9/bfcY8vxbdh915Qu4Q==
X-Gm-Gg: Acq92OHbTFA+4lrfa/WeYvFl7+IPZGDr/CoCAkpGwtnCkiyrWLGyJ89k0jZehyC/sH0
	3fi8gtTum0Lz1zNLR35SaCxJgi0DHGsfT2e2IKSpCkOUzAc3afjJlCiQSqLkTEmAquizqtMWWu4
	FY2xs+76D+55wrFypoJwEW/E88BTI1eFAt/pe3yNqVVV25iFM+8RO61FFxYUnU5P9fMmZnIwXDb
	02goRcVl8A48HU2z2WcQ/Rr2cevpIbd32aJpsm8MhmLL3gB04jS0kCesMTQ+MzFyJWKsJB/H1jM
	MONfurtFtqpzlW3hwe4C+BPdzKZn799b9RxlzB1cxr/atrYWUj3YjzAELu2VpNn+FbjaYKrWSuC
	EiqPDQeQbQIm23sDG8UNzYQ==
X-Received: by 2002:a05:622a:4886:b0:50e:2b1e:9d14 with SMTP id d75a77b69052e-5165a0df605mr49079001cf.29.1778849539745;
        Fri, 15 May 2026 05:52:19 -0700 (PDT)
X-Received: by 2002:a05:622a:4886:b0:50e:2b1e:9d14 with SMTP id d75a77b69052e-5165a0df605mr49078521cf.29.1778849539194;
        Fri, 15 May 2026 05:52:19 -0700 (PDT)
Received: from [10.17.16.21] ([144.121.52.162])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516456b6856sm43706901cf.7.2026.05.15.05.52.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2026 05:52:18 -0700 (PDT)
Message-ID: <3351afd6-13d4-4ee0-a5ba-08b6591db437@redhat.com>
Date: Fri, 15 May 2026 08:52:18 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] support/backend_sqlite.c: fix getrandom() fallback
To: Giulio Benetti <giulio.benetti@benettiengineering.com>,
 linux-nfs@vger.kernel.org
References: <20260408173535.3992116-1-giulio.benetti@benettiengineering.com>
 <20260408173535.3992116-3-giulio.benetti@benettiengineering.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20260408173535.3992116-3-giulio.benetti@benettiengineering.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 5F190550018
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-21634-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steved@redhat.com,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action



On 4/8/26 1:35 PM, Giulio Benetti wrote:
> In old Linux/Glibc versions __NR_getrandom is defined in <sys/random.h>
> so let's add it to fix build failure.
> 
> Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
Committed (tag: nfs-utils-2-9-2-rc3)

steved
> ---
> V1->V2
> * added patch
> ---
>   support/reexport/backend_sqlite.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/support/reexport/backend_sqlite.c b/support/reexport/backend_sqlite.c
> index 0eb5ea37..a1e981e4 100644
> --- a/support/reexport/backend_sqlite.c
> +++ b/support/reexport/backend_sqlite.c
> @@ -9,6 +9,8 @@
>   #include <string.h>
>   #include <unistd.h>
>   
> +#include <sys/syscall.h>
> +
>   #ifdef HAVE_GETRANDOM
>   # include <sys/random.h>
>   # if !defined(SYS_getrandom) && defined(__NR_getrandom)


