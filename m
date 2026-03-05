Return-Path: <linux-nfs+bounces-19808-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WP8xMPmhqWl5BQEAu9opvQ
	(envelope-from <linux-nfs+bounces-19808-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 05 Mar 2026 16:32:09 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C403214951
	for <lists+linux-nfs@lfdr.de>; Thu, 05 Mar 2026 16:32:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3F6163014123
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Mar 2026 15:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F4D3BED38;
	Thu,  5 Mar 2026 15:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F2rVxI+U";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Eesy2J5v"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6D8345CC9
	for <linux-nfs@vger.kernel.org>; Thu,  5 Mar 2026 15:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772724682; cv=none; b=BQKXwfvphlZbMZ0XZklTc5565zuL4FCZwxo8l8wr3STEuueH4kAHBYtmDEj//l7dqcubQfiBzERYzVcxLAg7AIS8w7eP9FQMPEIBs6W/9c7AjpwFtqsmtiVnyKp3sLsByQbos8r5pJL8Agng6F+MTHp07mcX6l75CVCP8dtmhwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772724682; c=relaxed/simple;
	bh=CluwwjLA3E71Xn3UrbiZ45Vszbz3rBh4l3pVOcCIl7c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qia+5g/dG1VKM4JJh5JU9SdYMdirJXddrHy7lFHi9T+X0KDNdtETRYnAwrhK8iYcU254SmUOohfvKt6f4cdsV8hJKp/yOHf2yqeiaM3zKscLfOXcVFSGPoQANmMCcA6yEIYWsVJ7TF7mpylMx11MQjm4/GEhOUmyY8RvrfGFW7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F2rVxI+U; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Eesy2J5v; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772724680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LB03pPDh1M9WgZBDLqFGxUQyX5pGe/xzJ0/TEr5do6M=;
	b=F2rVxI+UxVP13lZ/s2UJ+fm1ETFJ3u7I45RdUuBiYmNkDT+U5ZlzcW9/aKwKxdfNE7jX/d
	CwJNeyxNxI6IsNnazvz4SEn1RAlKUZY6g2bDOsSEGcIQgyc8AWmHoIJyDk6a6Fk9S7s+tf
	KG3wXpvChwqGeN6NeH34/nsqtU4g+eY=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-170-AVy6MnBxPauvokVq-LRB9w-1; Thu, 05 Mar 2026 10:31:18 -0500
X-MC-Unique: AVy6MnBxPauvokVq-LRB9w-1
X-Mimecast-MFC-AGG-ID: AVy6MnBxPauvokVq-LRB9w_1772724678
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-89a0249d51aso237021576d6.1
        for <linux-nfs@vger.kernel.org>; Thu, 05 Mar 2026 07:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772724677; x=1773329477; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LB03pPDh1M9WgZBDLqFGxUQyX5pGe/xzJ0/TEr5do6M=;
        b=Eesy2J5vc8aLZUvtxybqHuXLRVAtwVo6qFm6Ipyke+JXI8NM1z2Xz0FlWPM3M/rM7S
         WKi6MNOt8TRBf8GMlXZq7dHj8baGUyuYw4Fx3crdNlmWyfjEfX12eZ8AxZpY3JIwAB6A
         ZzHDZ4sTjxCBQkXVEZRhft7uN6dCv0iH+5fagG4EKmXquka+pPEf/fqARnW8b0e8WCHW
         D9vhce9mgeKLcWnxtcWTn5DszszjI/O3zh8YaKn0PTyRLDt97SpgOFj6H8XpW30Vt99K
         neunAAUMvSQOI3Dw1N3aDV/MmwXUcfdcMxqTV7FfCJyZQ1ksdSVbLplJ/IAGJFT9P8Jq
         EoeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772724677; x=1773329477;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LB03pPDh1M9WgZBDLqFGxUQyX5pGe/xzJ0/TEr5do6M=;
        b=eUoPUn4Yr8jtASVfs4/ISEEGktQy1B0SdeABqIadzlZ/trSQGxYvVTy3Bj8EFv/2aD
         KEi1Gf10IZ1oeByoFWle6dvV1sN8SK0asnJdBJusEy0m6rDEIj8RwGHf8Y+gXrHlKK/w
         J5nWgbW2y3aMmW/z1/lYb012P+PjiC3Hl2broxBgT69JYgoYVVGe+J+HO8wEORObzb+4
         ooRM+aq7aTsxTkoy7L/XCDA2RucJU/4KWcL+dUF3PmK000dKX5qWSky7oVHfe36hQ5mL
         WsbICfRTzuTH16+4qUjvxVRP8BbGUnXTQOBqQREcpv2la/z2mp3IETknIMd/K2u8hPjR
         3BVw==
X-Gm-Message-State: AOJu0Yxl57qBsAUstykmZAtyKr9YLtvsxL45WGt08kJ4pRWYGVlPsqNr
	6Pme8kBLj5fyFkXgphIkkWfzdSvH+HEqg6Cf+Ybu3wCvM28r48kulV/5XNEwsdZk+/uA4bHNGRN
	DrUjdx79gfRmjStojwsP5D54ZPGX9qV5xVq+pBNghaAdsZ4luQBxBOHQbDq2svkFlujBa8A==
X-Gm-Gg: ATEYQzwge2+BcDFH2mQshrKRV4q0BVg1Kv4qKO2+hlt8CzlHzotKDyple5hlUUBMqzD
	Qygo1omSTLAYqxhnNZYkPtlu5aVBI9MHYt9XZkv3LVI3abHko+ZCG27L7JYNr05qm30Zw2PfQYF
	/6bqjSgyWZvP08lgaU4FVNL/bHZ2t5XVQeq4hpY03sIWsKk5ZsK/ddg9MEaclmbR4Leqm7Bm42i
	vU1BPhpVw+xsWPod+2d05AoS9im69e6DAmGWIPkXLbtgeFssAiqrKw47vZ3wW5I2oPLZtGC+B15
	lHVAxdT+nPTD+ovrKmsx9DpL8iI4HWUNy7fW/gA3z3AQ2pAcbVYs0w0DhLjCwL3/+rxMEINv8l1
	gqoCQIj3R472aElBSGPg2rA==
X-Received: by 2002:a05:6214:1d06:b0:899:e545:4f74 with SMTP id 6a1803df08f44-89a1997c1aamr84554976d6.7.1772724677335;
        Thu, 05 Mar 2026 07:31:17 -0800 (PST)
X-Received: by 2002:a05:6214:1d06:b0:899:e545:4f74 with SMTP id 6a1803df08f44-89a1997c1aamr84553616d6.7.1772724675596;
        Thu, 05 Mar 2026 07:31:15 -0800 (PST)
Received: from [10.17.16.21] ([144.121.52.162])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a20471119sm39060866d6.40.2026.03.05.07.31.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2026 07:31:14 -0800 (PST)
Message-ID: <6a213da9-7c4f-4912-8ba4-80104a34ddcf@redhat.com>
Date: Thu, 5 Mar 2026 10:31:14 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "nfsrahead: enable event-driven mountinfo
 monitoring"
To: Christoph Hellwig <hch@infradead.org>
Cc: Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <20260305124221.55407-1-steved@redhat.com>
 <aamQbSl40bG5pjD5@infradead.org>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <aamQbSl40bG5pjD5@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 3C403214951
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19808-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steved@redhat.com,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action



On 3/5/26 9:17 AM, Christoph Hellwig wrote:
> On Thu, Mar 05, 2026 at 07:42:21AM -0500, Steve Dickson wrote:
>> This reverts commit 2b62ac4c273a647df07400dc1126fceb76ad96c0.
> 
> Why?
> 
> 
https://lore.kernel.org/linux-block/CAHj4cs8URj2fJ7KyP9ViAm6npVOaMiAErnw2uFyPYEU2wb7G_w@mail.gmail.com/T/#t

steved.


