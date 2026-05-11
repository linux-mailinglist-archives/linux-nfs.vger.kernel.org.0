Return-Path: <linux-nfs+bounces-21471-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kAVhMYflAWqKmAEAu9opvQ
	(envelope-from <linux-nfs+bounces-21471-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 11 May 2026 16:19:51 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4108450FF71
	for <lists+linux-nfs@lfdr.de>; Mon, 11 May 2026 16:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4F537307022B
	for <lists+linux-nfs@lfdr.de>; Mon, 11 May 2026 14:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0AE161FFE;
	Mon, 11 May 2026 14:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RiXGFLNT";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="CpFTIxwg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4973FB7F6
	for <linux-nfs@vger.kernel.org>; Mon, 11 May 2026 14:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778509028; cv=none; b=IOayyZUlfq0mH0SLW97HEZ3eNDton17Wr3UVieCZMfh1QG0hBcGEvUpX7QLgNitRItSn3eMzFpCstE1l6Pv7ecKyXkM4S1xK9kRFR37RW3VOns/F8WlnLxpFRsB1rU3KCYd3TKUEsBl9c30YnS3UQGkySGULvG13k9jIoz2wdU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778509028; c=relaxed/simple;
	bh=go9DAuI44v5J4nzkkASCUksQLVvkH2KrziCIj0KQN+c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DMAdp7hMVgJGEQuklALadHmBzoe4WhmJsQF14oyW8ttMQCOY4R4HLOrp0RLV8dJcjrvusyM34tDn0evU6ppy444mF7kn8GbO/f2MItZ3vJSBb4ytAw7C6EMp89EAU5y7IxbmdyNL+iXvqp8rOrPcd1Edys5pHYlIH5kKegKxWMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RiXGFLNT; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=CpFTIxwg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778509026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UFxgrqEvXz7ZuIfs3TR3cZGhazugIQOtaJ9wZHvdNXc=;
	b=RiXGFLNTe22JV6I3z0BAWMX3oGpjVQZCrS7VFWniAimARXXIqoX3Map86Ru0ygoii+zm2e
	gCzOhBwKMd16iN2bw1iITTwCrms6d20pyERAoJkrL5IvED86im3EfxqSsIiuNtTrWd35F+
	6aC9up3+5m+HAKYJWEd9ZoYnwVrQ9uM=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-711-IkX2WidHMsGEXfAXGVSGvQ-1; Mon, 11 May 2026 10:17:02 -0400
X-MC-Unique: IkX2WidHMsGEXfAXGVSGvQ-1
X-Mimecast-MFC-AGG-ID: IkX2WidHMsGEXfAXGVSGvQ_1778509021
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-575597e1259so4072551e0c.1
        for <linux-nfs@vger.kernel.org>; Mon, 11 May 2026 07:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778509021; x=1779113821; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UFxgrqEvXz7ZuIfs3TR3cZGhazugIQOtaJ9wZHvdNXc=;
        b=CpFTIxwgQI6zvjW4bNT/4Jm8+4xnt+Pm+FK/cMk4jZDERy1zBklKcvta9vV8C16y6C
         QNY3YhtiM0Ly/6GDDI2OYrEMOESFOs2Qxi9SwUVu6uFnZuP3ulq1SRRGB+HNxSvI/qbX
         X4Q31H0icJePWto0nwWIHQfFsm3/6dDPmsZn3sAeh043grgsb+jbZRN7HdIHG4BzdxgA
         5XmUEPyLntUBM5P+dnewATH8xWwG6D4elMAOwIFKvJ9hremMDLq37saOiot5dH++uOLj
         YcxT+nBLQbwYRkGoNXgogc8tYXvD0YMhVW5wDVr130KcZeKflaiZW8pJYGlygCzjfaAh
         RSmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778509021; x=1779113821;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UFxgrqEvXz7ZuIfs3TR3cZGhazugIQOtaJ9wZHvdNXc=;
        b=BISp8NIrJHogPaa/q/9jUcNYsEA2XU5ON8cD/AxBW/OtJXD0CQQJQhpBf00ZorSVnp
         C71vTKn3eYWDofmYCVCfEums+Na27xBgFMpVoLpfWYfVW3NdxGefY30/qJp9Fv9N3HJd
         bVw3qFi4ckhrXSM3FmjI3AVZPHXml2+C4SB+KNLnQkMkxVYRfyj2TeiLh0ZUTrWqFIDC
         RyTfIcSczyNaas/t9OI3Stb+s2FXn8iphOPPGeyR0yrn0Q25GErvRl7c8uPr/mUd1TdD
         2sW8lxJPdR8RQp6R1i0TD1+5VhpD0KiVnYn8Xyq2fPwQv41uGlvcqHsmwDkWDDpR476v
         gRyQ==
X-Gm-Message-State: AOJu0YyVUtX9l4qGdA1weJ5wi3Ovq7bou6wFmchRVNZfDVhurBNLeI9w
	FGpdmp24MH6ukbMo1QnFJGpjZNzlctHI20nGqfEzCWJoGw6twUR1ZclmNZat/jbr+9Ltrjd3HBA
	INhNg/z42/YMps0DwBGN1WYMwDtXmZV7uoFHCCRF+U63pWSkanqmjSTe/o1/IJg==
X-Gm-Gg: Acq92OEUnDN6d9KlKDmFMUWHshWlBN+jSoHdRTsUjIxhTf2r4b6pDzJqX6OgVF3pTrR
	AV6ixjC6ddSSVrqXGsMFeuzHbhyHLvy7cv4Y409DiUXL/z19wpfyyor8xdeZuuGVgv9TGKlOHq2
	1hnOhwYrw6lFI2egOSEct1oxqPO3hw7OBDomnS4mFmDVz29w51S3CCtwNd8yuTOMWpnpVG952AS
	XxXHDg3xSCr0utg75pzKZwZSRlFK9aVZL6NIiIKK47Z+MjO5s1wLvQyU41Xn7b0NnJ55LDyHI9R
	y75cgszYpSqF3IYB7M+AHq7JErbxyhRGq5+LUx+s0gg4Tv94VSmBcHh762n+Hu2aj9Iud2GcWsO
	JSA8GCePz6eO1awQbO90z/Q==
X-Received: by 2002:a05:6122:e149:b0:56a:fff5:b4d6 with SMTP id 71dfb90a1353d-5755953264amr12489574e0c.4.1778509021518;
        Mon, 11 May 2026 07:17:01 -0700 (PDT)
X-Received: by 2002:a05:6122:e149:b0:56a:fff5:b4d6 with SMTP id 71dfb90a1353d-5755953264amr12489538e0c.4.1778509021048;
        Mon, 11 May 2026 07:17:01 -0700 (PDT)
Received: from [172.31.1.12] ([70.105.248.114])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-575585f72c1sm11424487e0c.12.2026.05.11.07.16.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2026 07:16:59 -0700 (PDT)
Message-ID: <a033a1da-d186-4996-9d54-b7ac3a2f940c@redhat.com>
Date: Mon, 11 May 2026 10:16:58 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [nfs-utils PATCH] fh_key_file.c: Fix build error with musl
To: Benjamin Coddington <ben.coddington@hammerspace.com>,
 liezhi.yang@windriver.com
Cc: linux-nfs@vger.kernel.org
References: <20260508135732.524301-1-liezhi.yang@windriver.com>
 <CD3EAA3F-F758-4CAF-A692-065CA82917AC@hammerspace.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <CD3EAA3F-F758-4CAF-A692-065CA82917AC@hammerspace.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4108450FF71
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21471-lists,linux-nfs=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steved@redhat.com,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action



On 5/8/26 10:08 AM, Benjamin Coddington wrote:
> On 8 May 2026, at 9:57, liezhi.yang@windriver.com wrote:
> 
>> From: Robert Yang <liezhi.yang@windriver.com>
>>
>> Fixed:
>> error: implicit declaration of function 'strerror'
> 
> Giulio sent a patch for this already:
> https://lore.kernel.org/linux-nfs/20260408173535.3992116-1-giulio.benetti@benettiengineering.com/
> 
> Steve D - did you pick that one up yet?
Nope! It was hiding in a bunch of kernel patch
w/out a nfs-utils subject tag.

It is on todo list now...

steved.


