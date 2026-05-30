Return-Path: <linux-nfs+bounces-22114-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2PKWArFRG2oEBAkAu9opvQ
	(envelope-from <linux-nfs+bounces-22114-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 30 May 2026 23:08:01 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DAD96136D9
	for <lists+linux-nfs@lfdr.de>; Sat, 30 May 2026 23:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D43830097CC
	for <lists+linux-nfs@lfdr.de>; Sat, 30 May 2026 21:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392A0329C54;
	Sat, 30 May 2026 21:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DVPTR4O1";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="lLAgBgKU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3206272E6D
	for <linux-nfs@vger.kernel.org>; Sat, 30 May 2026 21:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780175278; cv=none; b=S4S7jOZsVciw0QoIlMDiZ2iAULv43lkIdLeSRBV5tNMQHoEZoXZXupZGb9qMtfP9YIIWoh852lzWdmNf5pWgwc3tH49uQOtclQ9FRks8Hj7y5BP1CJksuJmtF8l49s6uDQIrGLmWmoBTBHwkJb/6l8tWuD+IpQBhta0CeBACiEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780175278; c=relaxed/simple;
	bh=qqQVwwRK0IflqQZ9I0PTVip4IG143v8Vi1sXUyLV0xk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=WGK9Q6Qhuz8Rhkw/Abu1HHgmxZPZ2bF1giF6dNphSCUQJfk7cH203WAmTEOBHVcE+7pwoUkQQZVb7i0ALK+FpKtE06EN5Cug81y3KxZjCArmGisoCW7QCk910tT+5qyyqcjDHo107Lz2SYwqHG+6geSB33+5voH+9QrSimjlME0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DVPTR4O1; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=lLAgBgKU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780175276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uQXntup3NtMIk1Q9DviMc+ZvL1zcRW3c/qGO5kcYW0k=;
	b=DVPTR4O15JH086y2oKbGfKx4Yq0fxwXHMPFC/DDLuHUdWghJMeBAWHAbg7Xvm8YIBN4k9Q
	ekpRWMv+mtI8OdrQqntiT8H2SmP/qIHX5vAXJUJhJ7e5f/k/f/3CtEDA2iCwZYFEflsnfp
	HH/YMVlA60TNt6NRSwmrsm+vi8l6ENI=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-yF4eWLzROUCuJE_HpDSdHA-1; Sat, 30 May 2026 17:07:54 -0400
X-MC-Unique: yF4eWLzROUCuJE_HpDSdHA-1
X-Mimecast-MFC-AGG-ID: yF4eWLzROUCuJE_HpDSdHA_1780175274
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-514ae0e3ad6so367651501cf.0
        for <linux-nfs@vger.kernel.org>; Sat, 30 May 2026 14:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780175274; x=1780780074; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uQXntup3NtMIk1Q9DviMc+ZvL1zcRW3c/qGO5kcYW0k=;
        b=lLAgBgKU+spM1VHz+7IEkuk74t2NVs5rfGXjirX6p8VZbIDnaAjcA3YkTbHu4dm/SK
         hqFooTp6Yhj5lUq5cmXF6ICnITrC7eTXfzrRrW7iBpJUKjU+xeahH9q1foawPc30Kwlu
         B0sdzaxi4zEeTXST7jWyMoW1WNrMFFcxpxAjHcEOfqVzD3OgFLEuKxTPhvYdZzwRGPfi
         Xt++wxwJKXwoZJnOGJpQlreIEDTBKWV7ZrAkP9UYN8nB2K7kOeiUUgvU6uUSCh0NOHQZ
         93YmMYWNRxpSktSZuj7oQR+Vx0m8WWV86CCUdvKqY8IwxWMOCRAW7m/gfQgxIoh4r26t
         C+IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780175274; x=1780780074;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uQXntup3NtMIk1Q9DviMc+ZvL1zcRW3c/qGO5kcYW0k=;
        b=FfMpcSpqn146rmfZ1+qSFJUkxccUqTGPHJMogREqvEdSom9pGvX/E4yDsO/wKiQ2VK
         JhBnXWBA5xbVHqA2yh4xflQ0lEcR3b9o2iNwVyLsPlD+Qm/NPYCdrjKMJZZW+RyzdpXY
         dk16hY8K4tJE7VIwiwqcXv1dOipJ8EWpMxm9bPRYGTAe22DIxtV3FHAnJq39fZjHAKbp
         8MpIr53KQcd01Fnk2xn70rq3NIcXSxlQUeYjXHGlP9X629r+djrQ8HtcaP6Ux+srYtzz
         xMBofOgbkWpL5ZNdTnHktJ4lCLLwpbJ1T2voCGp0fRxBezs105eEb4ttxy2HkmkVIrNQ
         /hRg==
X-Gm-Message-State: AOJu0YyTZk5czkUtFbCuHtbzT1ETsI9DhMB43oLVXTcELtePGNylfn7V
	YOaJ9TSx08qQD3vfIFbDCFOoCH8ifwA1gH68VRV0c0bZ7uKUQFPstClL9kOhFQT1kB6Cbtp07xr
	rkaYt7FqOeHEW2h1psw0uKTb7upSO1qdOHLuZpbRVDqn1sE0qu2KiKsLedPLBPMrODXf0VsIawm
	BhiNuDA8X7ViS4qT5sT2F1Ojx6Jx56+6r7uJAJSj0Ju1A=
X-Gm-Gg: Acq92OHztmRLSKEFx9OBJlhe1Cz4wBQ6ot9ms0SGR4dSJj2PboCS2Nml+nEB9D5+N03
	leI/w19N9d0d4oTvi6Dtc5rKrJtrSk63Lj1eEHLGGyHYDpiDLu4EFE97SR8Ez6q5Xkf9UQxblO6
	hrVh6ykucZ75uPh1Ih9+BCSwp9TKgiZ5zRVKkAbaNR8/mi9eNHajgm98/SHgeLE1QVqrmXhEKxx
	0asy9aKljStl6BreRRzoqWEQFPtz/4mr0uWHnEe8CJ011Mm98+b0pvijk2aarcU3348Hksbp6RF
	HgCN3Z499XgYTKLdQQcciWGUQGk/rwwRwWcqY4N0k9qWPE+eIJaIsyPox0uAuwR70zux5mmd+66
	XMvzIx62QEQT2YW0z2aD/Uyt5uEBoLLYG
X-Received: by 2002:a05:622a:98a:b0:50e:61ea:d8e0 with SMTP id d75a77b69052e-5173a82fe1dmr56550671cf.21.1780175274135;
        Sat, 30 May 2026 14:07:54 -0700 (PDT)
X-Received: by 2002:a05:622a:98a:b0:50e:61ea:d8e0 with SMTP id d75a77b69052e-5173a82fe1dmr56550291cf.21.1780175273585;
        Sat, 30 May 2026 14:07:53 -0700 (PDT)
Received: from [172.31.1.12] ([70.105.241.172])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517417ecb11sm18078311cf.0.2026.05.30.14.07.50
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 May 2026 14:07:51 -0700 (PDT)
Message-ID: <3d4decec-8156-4ca4-b9db-54edb53b3d96@redhat.com>
Date: Sat, 30 May 2026 17:07:50 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Removed warnings in nfs_sockaddr2universal()
From: Steve Dickson <steved@redhat.com>
To: Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <20260528191922.67906-1-steved@redhat.com>
Content-Language: en-US
In-Reply-To: <20260528191922.67906-1-steved@redhat.com>
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
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22114-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steved@redhat.com,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 9DAD96136D9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 5/28/26 3:19 PM, Steve Dickson wrote:
> in function 'nfs_sockaddr2universal',
>      inlined from 'nsm_xmit_getaddr.constprop' at ../../support/nsm/rpc.c:251:17:
> ../../support/nfs/getport.c:459:24: warning: 'strndup' specified bound 108 exceeds source size 26 [-Wstringop-overread]
>    459 |                 return strndup(sun->sun_path, sizeof(sun->sun_path));
>        |                        ^
> 
> Signed-off-by: Steve Dickson <steved@redhat.com>
Committed... (tag: nfs-utils-2-9-2-rc4)

steved
> ---
> This is a chatgpt solution to remove the warning... untested (yet)
> ---
>   support/nfs/getport.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/support/nfs/getport.c b/support/nfs/getport.c
> index 813f7bf9..608e185b 100644
> --- a/support/nfs/getport.c
> +++ b/support/nfs/getport.c
> @@ -452,11 +452,12 @@ char *nfs_sockaddr2universal(const struct sockaddr *sap)
>   	uint16_t port;
>   	size_t count;
>   	char *result;
> -	int len;
> +	int len = sizeof(struct sockaddr);
>   
>   	switch (sap->sa_family) {
>   	case AF_LOCAL:
> -		return strndup(sun->sun_path, sizeof(sun->sun_path));
> +		size_t path_len = len - offsetof(struct sockaddr_un, sun_path);
> +		return strndup(sun->sun_path, path_len);
>   	case AF_INET:
>   		if (inet_ntop(AF_INET, (const void *)&sin->sin_addr.s_addr,
>   					buf, (socklen_t)sizeof(buf)) == NULL)


