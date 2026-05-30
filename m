Return-Path: <linux-nfs+bounces-22113-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJT6BalRG2oEBAkAu9opvQ
	(envelope-from <linux-nfs+bounces-22113-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 30 May 2026 23:07:53 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 714206136D2
	for <lists+linux-nfs@lfdr.de>; Sat, 30 May 2026 23:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 434D13008D18
	for <lists+linux-nfs@lfdr.de>; Sat, 30 May 2026 21:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCCD1272E6D;
	Sat, 30 May 2026 21:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cuay+XkS";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Icr+eN0w"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9BB22A80D
	for <linux-nfs@vger.kernel.org>; Sat, 30 May 2026 21:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780175249; cv=none; b=Dveql8K8DOlm+R11v8627pDwREK5Wyr0fjX8qPXlbsJ7ogMKUOtdVyIPWhsZPDPlMKyu5TlLuYXcC5vHQgcjYUfPN+/Q2Kn85v2jSu+Ntl07rJQzIZtPJGZZ9+nw8kbeFpyh+2G+XdKw8x6CnH5vKimQ5W8gIGJunDBd1/wvbmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780175249; c=relaxed/simple;
	bh=wLCXIUh4q0Faug23/QHKlrtCWtLtipd7q4hkIkAzqME=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ItWVdHvDUpXvsHMUtEvmL4AA8UuZ+eeJSt6laDX2nHKAM+htaVVco7TCVzD/8KZdORLUUxwEdc6FG5UkGIc85rWvxOZxX+i+MrKis09QiYr8NGeWuoK9xq8GqqJygSCaCNS7vJ6O7EtGwGHZpIIO4VjdFXj1jqUblKITwXYz0WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cuay+XkS; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Icr+eN0w; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780175247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dV2uk9Vv/nEhbaHou0S/kIQ7wmTmQ/29MCDriRbBG6c=;
	b=cuay+XkS69hMe6bfqW+tTVPHzOiaEggDB1YX/7/qqLhdSjL3UrVnT+ikQv0ZT67FjELDHB
	i+wpe6ll7Ufgo5fK+ppXbRf/fPEeOVcWm68hinipNnHtbE54EK5R6zYBgP5ssEaknnGnif
	ui8I3SIuLEuKFeXl8XbQXlPfmnavzW4=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-SjQLauTaNvWtMUJRTZ6M6Q-1; Sat, 30 May 2026 17:07:25 -0400
X-MC-Unique: SjQLauTaNvWtMUJRTZ6M6Q-1
X-Mimecast-MFC-AGG-ID: SjQLauTaNvWtMUJRTZ6M6Q_1780175245
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8ccdfe1ff26so30349936d6.1
        for <linux-nfs@vger.kernel.org>; Sat, 30 May 2026 14:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780175245; x=1780780045; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dV2uk9Vv/nEhbaHou0S/kIQ7wmTmQ/29MCDriRbBG6c=;
        b=Icr+eN0wloei6arNR7GEWuJG3HCDLOZDonc8cwvVZ/L/V0eRnaVrdGrjM9zVZkYt2J
         kM0AtGzwoBs4CYa3V0vu8xm8mLrqY6Haih+559UpcJdwoaw4a51yNNVSuFfjsX3qudny
         FaUIVbc/UwfE79tXUq2BWtJZ5nKmCSs8YiR2YPuWPoVP0Zp9zH+RfaThs41kNV3D46Bw
         Qx33sSvoinKAnXiNHr6mWw0BtxPr4mmLRr+ZiRW9ezmb39i2OtjwwOTugIa35Nz83gMV
         5Oyb8+ki+Pzk9SkKwOVdGy25REBLXX4QzCcGirihGpZqv3dbDDVkzif4jPhu2t55RiL6
         tMlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780175245; x=1780780045;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dV2uk9Vv/nEhbaHou0S/kIQ7wmTmQ/29MCDriRbBG6c=;
        b=WAW+e0lNv1JO8UnTrDnFYs5TwOzIkX2rBqxV/25OBdJnb+VHmpfcM45VQ7y5eL0dv+
         MEsoo5fRTrfOOe2t5Szk/5E3VHotDlLQ1LJ0rHJeBacXDmEHi7Ehngw6DShl8kdMV819
         eQk4c2m3QJ8HlLGWCtzB6MaByPatCbwWOBG7n3zmny1q5Q2ZudtMlSTTSZpjDSmFtKLb
         JSHJwBi6NolkDFg6Ah8gwxU1my0E6TPvuCfqTEiBYdSWYLA7xgSbZMX9xMyK1WwkyAea
         lH3X9taYG4qyKfeEosdMf1VHU85gJgN8euI7QWHpxAW0Zh6HEJoZRoUfbGR8NdriYaPp
         hTFg==
X-Forwarded-Encrypted: i=1; AFNElJ+fvn0fyOArWKijKMOjnZtsfJJAznIwnIOGAqQRPTAR50E044HkroTav5boZfHoMX6UmbaMiH2N42k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9HAHo/RNXKtnkC6bagIy3j77dNaav7NfEnGErv0ZCp/szrERQ
	CMpf3oYww/dRFwpfYlEe6FfFHi2euTEONBkcD6cGXOqnGL3iNYAoT0fhru+Soo4OXccLf6+49q7
	rF1rnpj09MRs131pdrzl/RaWtjh5+OA5gxlhnTurC3ijbqT+uDU0dutBLAHlf8AdpQQot1g==
X-Gm-Gg: Acq92OFAYerNj+9aGiTJYmPkTcjuFoalU1qN8Axyd5RkCehBPosFtET185bsBY1Wcjm
	v/kfMIwQ19RDYAGht8ciLLxK4RsQThYjEHMAdhNlGCKiN2keKmao1EmZYx7lT03eh2QOa3GGpxB
	PiScd19QUld0ZoATszYO0SnQhALiYhZ9BXoxxoEiF+x77LO/zayuhybE4yZqRCRRZrc+C2jx25C
	sPXr3NtK5irALUk5kj82r2lCOXgEs5/wU68xKy6cqOPGbAfIjYKWnU53032k0GGc0dyzyZusfSJ
	FbZUwJHrApcpjDRqFC/2ppGSwC40IQK3W8r5c6Ayq/bHbuLc0nVopNP1aKIzW7p/OqRR3b4afMZ
	2m1iHpfD9ejS+wGaVt+bf13dCFlAd4pGh
X-Received: by 2002:ad4:5b8a:0:b0:8cc:f592:3023 with SMTP id 6a1803df08f44-8ccf5923483mr47056506d6.37.1780175245334;
        Sat, 30 May 2026 14:07:25 -0700 (PDT)
X-Received: by 2002:ad4:5b8a:0:b0:8cc:f592:3023 with SMTP id 6a1803df08f44-8ccf5923483mr47056296d6.37.1780175244948;
        Sat, 30 May 2026 14:07:24 -0700 (PDT)
Received: from [172.31.1.12] ([70.105.241.172])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ccea272fdfsm52141596d6.49.2026.05.30.14.07.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 May 2026 14:07:23 -0700 (PDT)
Message-ID: <eb605903-1715-40ba-b279-d7428c9b8663@redhat.com>
Date: Sat, 30 May 2026 17:07:21 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH nfs-utils] libnfsidmap: avoid malloc(0) for empty
 Local-Realms
To: xu18736995897@163.com, linux-nfs@vger.kernel.org
Cc: xuchenchen <xuchenchen@kylinos.cn>
References: <20260526025103.5461-1-xu18736995897@163.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20260526025103.5461-1-xu18736995897@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22113-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[163.com,vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steved@redhat.com,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,kylinos.cn:email]
X-Rspamd-Queue-Id: 714206136D2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 5/25/26 10:51 PM, xu18736995897@163.com wrote:
> From: xuchenchen <xuchenchen@kylinos.cn>
> 
> conf_get_list() can return an empty list when Local-Realms is present
> but contains only empty fields, such as ", ,". In that case the Realms
> list logging path computes a buffer size of zero and then writes a NUL
> byte to the result of malloc(0).
> 
> Reserve space for the terminating NUL byte and use calloc() so the log
> buffer is valid even when the realm list is empty.
> 
> Signed-off-by: xuchenchen <xuchenchen@kylinos.cn>
Committed... (tag: nfs-utils-2-9-2-rc4)

steved
> ---
>   support/nfsidmap/libnfsidmap.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/support/nfsidmap/libnfsidmap.c b/support/nfsidmap/libnfsidmap.c
> index 0a912e52..16a79f00 100644
> --- a/support/nfsidmap/libnfsidmap.c
> +++ b/support/nfsidmap/libnfsidmap.c
> @@ -404,15 +404,14 @@ int nfs4_init_name_mapping(char *conffile)
>   	if (idmap_verbosity >= 1) {
>   		struct conf_list_node *r;
>   		char *buf = NULL;
> -		int siz=0;
> +		size_t siz = 1;
>   
>   		if (local_realms) {
>   			TAILQ_FOREACH(r, &local_realms->fields, link) {
>   				siz += (strlen(r->field)+4);
>   			}
> -			buf = malloc(siz);
> +			buf = calloc(1, siz);
>   			if (buf) {
> -				*buf = 0;
>   				TAILQ_FOREACH(r, &local_realms->fields, link) {
>   					sprintf(buf+strlen(buf), "'%s' ", r->field);
>   				}


