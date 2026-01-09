Return-Path: <linux-nfs+bounces-17674-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF29D069CA
	for <lists+linux-nfs@lfdr.de>; Fri, 09 Jan 2026 01:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3399E302E86C
	for <lists+linux-nfs@lfdr.de>; Fri,  9 Jan 2026 00:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB39638DD3;
	Fri,  9 Jan 2026 00:30:48 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3285B1EB
	for <linux-nfs@vger.kernel.org>; Fri,  9 Jan 2026 00:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767918648; cv=none; b=aOmqTxjTiNsQgltitZMw8R3OvJQNE1mpiEQWpGJe6ZhcynXKkAeRKdcfbiG5bOos9JH79yaXwrBCFf3608SlMR4ncxqKmJOUDheUsyO50XERwLi2ezpHDRQ1P00GAXoCMwsbM17zRg8zOPqcGEe3Y0OJ6ZaHyleyImZoWBfO4dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767918648; c=relaxed/simple;
	bh=z1D1Cwzjd4g/K/QCXE7nZYDMfsTf/aXHhRgoEnMxggQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MzOyI3xNAAAXe+lA65AsIZfDKum7mZGxbpuDL1gkdzhm/eKIoT5rqNImjuLxJ23Ua7VODilsA8sEszrST+qFkcP86VobJFp+CPFUXSJPgZXBshXAuuMsWwnbPjZOtVJ5b0uI5ouYeG8p0yaJQdvADXNRN43VtXFr5IiQth+8vls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47d6a1f08bbso15617475e9.2
        for <linux-nfs@vger.kernel.org>; Thu, 08 Jan 2026 16:30:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767918645; x=1768523445;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ke48T+dmHioKwBmQtk+bHp7T4S36rea8Xuvpp6Dwbx0=;
        b=w5hQXHRDtsdZop2pUM5dA1FTg4qltp/JiJ4XJT1YKDav3GDZjGSy1fRnmCEbUqXSrv
         jNs1zW7JTHOqOGcS7i+i+bgeAkh8oi3QVXmlT8mPCe9VuCbvYNqzBp/WlkPHdNu7I7/4
         YqmodP6Z4rbIRinzgk3Kcr8cFbt+QhPGufQUCwY1hunr4vxRWBlp3BdG0I9jvcqwPDS5
         Wq5zRhLqrmGnypc7WINliyo9cu5u1k/6hsAIvfu0QNr1UALixpjdBZgow0fYW//X8L5r
         kvEYjHs5SADORdMRy1gZLLM546GWxifzWx/Vo1aedfvc8HHv0rcxA/1r9a6w6GeIA7o5
         hJ1w==
X-Forwarded-Encrypted: i=1; AJvYcCUtkPr50se0biVQd47vXGfWBuLtpkxWe2BxSLWhSdSZvL76PqTtGtSD5prd7/CZl8Z64lZeOToXbIw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyDXO2tohX6vmmOdzOrpP5Krt1oTkwJyP04WjJGhDErY4Cq0n3
	peUFP6b3jsM8ihezSDICa6CehyzepI5C3z3izH+07fFmRCltnPznxRCucQHwhg==
X-Gm-Gg: AY/fxX7TpcyN92HjpHZpnFlPvJbB6/0kM5WEj17X7vnG2L6BxojhwIgNoiYrKRtqy3G
	PG9MwDvpkhjpMac0rlK7Gy+cfIAhj972yRYWb5A2awlvpgFrzNSUGZvlE1qyxG1uPIKIrzrDj0N
	6fxOu7P3qLKeGEzwhrPiPVUnNl9Wtxn8BYXc1dtfyJv6knhp3nF5SOo1DoKVV1KCZ9zR1hjYZwe
	91xnQlywHI2RXI9sipBNW2IqDPiKBZkDVmcQvkN0bfLaabsahjOGGGjuTpwWKDgmxOIdDWn6Gi0
	y2lbfNwYqbIrzT3i7cYW4dys9smNDI06hC38pOHxrRcYlPXYFMUAQunFtclJ7itVCABCrLbpatz
	FopHRfh/9sF5gxrhUJCaSuA6CWEZBS2cpSTlmsGHf/v0l5Z/GgSvT4o0d5A4adLZpqDaGAJeafe
	rAERiwmTY8QIlosQWQJjGVMhBnFq/Y+RuaDjBHRDW8kdtLuQeO7cTNGw==
X-Google-Smtp-Source: AGHT+IE/oTAbOoqZAKoFQmP/Fl/3LrCp4PLpXVCAWqdMEZVUNPk294KjlbSfL529thJ7s3tvF13oHg==
X-Received: by 2002:a05:600c:444c:b0:477:7b16:5f77 with SMTP id 5b1f17b1804b1-47d84b0b303mr80837215e9.3.1767918645327;
        Thu, 08 Jan 2026 16:30:45 -0800 (PST)
Received: from [10.100.102.74] (89-138-76-94.bb.netvision.net.il. [89.138.76.94])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d865e3d22sm50393275e9.1.2026.01.08.16.30.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jan 2026 16:30:44 -0800 (PST)
Message-ID: <5ae5ed3a-5351-4dc1-98e4-0f31653ee2b6@grimberg.me>
Date: Fri, 9 Jan 2026 02:30:44 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: add a LRU for delegations
To: Chuck Lever <cel@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 linux-nfs@vger.kernel.org
References: <20260107072720.1744129-1-hch@lst.de>
 <0b0b21c1-0bfd-4e2e-9deb-f368a66f5e9c@app.fastmail.com>
 <20260107162202.GA23066@lst.de>
 <ea31c230-1ace-4721-872e-2313b497214f@grimberg.me>
 <45ba87f3-2322-424b-95b1-9129a2537545@app.fastmail.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <45ba87f3-2322-424b-95b1-9129a2537545@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 08/01/2026 16:34, Chuck Lever wrote:
>
> On Wed, Jan 7, 2026, at 2:22 PM, Sagi Grimberg wrote:
>> And, in general, I think that the server is in a much better position
>> to solicit preemptive delegation recalls as opposed
>> to the client voluntarily return delegations when crossing a somewhat
>> arbitrary delegation_watermark.
> The server and client have orthogonal interests here, IMO.

They both share the interest of reducing rpc calls...

>
> The server is concerned with resource utilization -- memory consumed,
> slots in tables, and so on -- that other active clients might benefit
> from having freed. The server doesn't really care which delegations
> are returned.
>
> A client wants to keep delegation state that applications are using,
> and it knows best which ones those are. It can identify specific
> delegations that are not being actively used and return those.

Yes, I agree to some extent. However arguably the client may want keep 
delegation
states around for as long as it can "just in case" the application opens 
the file again (the client
doesn't know the nature of the workload) assuming they fit in client 
memory. It doesn't know
anything about other clients nor the server resources.

The server on the other hand, has the knowledge of what delegations 
conflict (or may conflict)
and act accordingly (not grant or recall).

