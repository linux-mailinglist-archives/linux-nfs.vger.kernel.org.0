Return-Path: <linux-nfs+bounces-20046-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OKJnHUmUsWnkDAAAu9opvQ
	(envelope-from <linux-nfs+bounces-20046-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Mar 2026 17:11:53 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B1E267100
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Mar 2026 17:11:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5CAED3023149
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Mar 2026 16:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F1036EA9D;
	Wed, 11 Mar 2026 16:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IRXlTI1P";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zc0iZ/NJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAAC0356A3C
	for <linux-nfs@vger.kernel.org>; Wed, 11 Mar 2026 16:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773245498; cv=none; b=kkMfEeR98tQVhHlXabrzRWQR5UOi2F6sx/Zx9BhAQ+p4fd04xafSeYnFkX7Nh/tuHAxCEm6pVMeFUcRKeAa/tOwtud3NYsllB3EArce80ScCGAb6bFPOp41MmCI+AyDJvGtkprDwnrQ5w+mUGO9K+M9y6eoJ+6ElPGH7EgTRDwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773245498; c=relaxed/simple;
	bh=51uhfxB38NvAWQoD5fDCv+FNGpViRePBGKW+W46d8H0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TkyHCylcoXWyIrrRrUBlv3aDQ3cuxgVpSmoYYq7jEcZkaVxLMhRu9Hd9x+FctrYQK3D80x9UKq/SIHNlTyZkFdKJ59FB4mLtm5hu4nfBOUVkNvrX81OIFF/4HpGlQwE3LkLBcRV8TTNKJsAZtYfE1QUlpOTDQiqqrBNDOt2P4Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IRXlTI1P; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zc0iZ/NJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773245495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7hRvyW5QK1SazLHhh8czV9Sk95vVqAHFeh+jqPER2ao=;
	b=IRXlTI1PYwzGy0pG3qMG/fT4KoCytaQHQKy6HJKGtcW7zrUSs9D6nv0v2t+Ackjpg1ejEy
	qrAwrsUs/OOF7wJ4ADVdZ0vse70XlzsTqXwyHW7ssdqQXw3AwZRTH1tzbyuVg34ATFSh0c
	Ag4ixBOK5u5XWOX1HyVoF3KV9uXd+mc=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-192-82YWdehHPvec4Co3oZAHbg-1; Wed, 11 Mar 2026 12:11:34 -0400
X-MC-Unique: 82YWdehHPvec4Co3oZAHbg-1
X-Mimecast-MFC-AGG-ID: 82YWdehHPvec4Co3oZAHbg_1773245494
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-89502dfd7b4so862366d6.1
        for <linux-nfs@vger.kernel.org>; Wed, 11 Mar 2026 09:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773245492; x=1773850292; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7hRvyW5QK1SazLHhh8czV9Sk95vVqAHFeh+jqPER2ao=;
        b=Zc0iZ/NJ2/mTvHf070KHuvxnxa4JoVBcimU+LKz5tVBGgQxNQMhhoxGAeSBbgvdyXH
         TB8+wSNfd1ziOh6qkryCjT7tGjU7H/4gVznM9b1G/J5DGbDsuXTB5SWbyFzMrE/xGWrf
         T8jLWP98C6K1bDsOeBRsQ0tqvLeP/UM9kb+7A9YtlQYjkpSJBEa3v0l1+EkhdmKOqPQC
         sDRKRVb7AEblqKrq9rLeV5ox9LIyNNj1mA9qSpcbu10n5uxdBUZ7Ky7BowJinGauRl8p
         0L6emE+mhF4zMkx/jKp5oUZrSfpXSUcw6df9IfM6qMhbLd2SNXHAs+soil1T/xLWmdJ1
         YLPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773245492; x=1773850292;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7hRvyW5QK1SazLHhh8czV9Sk95vVqAHFeh+jqPER2ao=;
        b=eLyBYu5Mqj5tQgSHUBeqZ9YR5B/5kkvSov6LPNGnJKmMT8E9FWnxWD3EHR77O/uva+
         O5dGhLWqxvuP8m5W8wwBJsL3Xmxax5pqezpvhUayP2hn2vVGKViXTjfeUouYgcWnMx6+
         X4FKt0xhxm54k/qYQ4FyzcvzqjhlO1kHsiUgGt6GjvM0KW1n3x2b0f7InuirHKMuYze/
         MpRWyxTGipziJMLQu9fEK8v8vikRzCi1c5WJVg2rrq3iwSHyq0CvY6t6yuOuDRNrS4aq
         z2hW+zxeabvVWdWh7CpalpkLPutTbqiandFvJwD9Zpk46Jto55uSEf74Jpe8p1+3AI4l
         qIgg==
X-Forwarded-Encrypted: i=1; AJvYcCURZnpeGT7oi9+HiojoKTJVRv8208ZxUXMFo1kon0fD9OC4s08CSqDPUsJXAwGO5Dvb8SFWTP++DKU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7McNUiKcvsIpV4zshA7fq+VzX/WXUCyPRDQX836QzWehT000K
	y/8utqPdehf7WjwHiLF+jSD6CO5PNAj+xPAEfjd7iiHwE0l4IwxO2CxOJKq0wREExL9kAQjOr39
	AU+Yh1FnavVeSiG5jDN4GtWDURWfBfzxttB6Q+3qKGL0tuyPiosBTCrJ1pKrWk9nX5OikPA==
X-Gm-Gg: ATEYQzypOst89CqmtNAKnvAO+3qrzwup441Z6MMOqSvCri8gRULeYcyfFdLTiczymyJ
	dN5YKyAgBteHamsi/nfsJo/4747nuichKaU1Qd+ETeD1bxAcyGa3QtAqNv0rclqv/xO4cfcKDDt
	HV/bCO+3/hOOptw46YPp8B3a1lC6YrAG293FOcS1dNkAMwpXiYDnaqmk8WgqDMkB8gsVaXcXUFd
	35QJxjyQyuF5KN1SqVbuiCTsI4CFfoHOQoYfJlm8S7UFlJ37y+mGxnPr3pRM065XP6HWW9tx/Us
	Q+L/UG+raCcDQKqLRScoma9DJojV9D2PcoX18USBCov6DlNheNJ9kKAVKAivhMhK3V3ats9OiKl
	DwWWIo9bcV6pUTJFwwt47vw==
X-Received: by 2002:a05:620a:44c2:b0:8cd:8f04:50ef with SMTP id af79cd13be357-8cda1a08f6fmr392504685a.34.1773245492020;
        Wed, 11 Mar 2026 09:11:32 -0700 (PDT)
X-Received: by 2002:a05:620a:44c2:b0:8cd:8f04:50ef with SMTP id af79cd13be357-8cda1a08f6fmr392496085a.34.1773245491178;
        Wed, 11 Mar 2026 09:11:31 -0700 (PDT)
Received: from [172.31.1.12] ([70.105.248.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cda1ff7642sm177174285a.21.2026.03.11.09.11.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2026 09:11:30 -0700 (PDT)
Message-ID: <ba6c3715-a285-467b-a20a-2a3c963a2e5c@redhat.com>
Date: Wed, 11 Mar 2026 12:11:19 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] nfsrahead: fix uninitialised memory crash and refine
 fast-path logging
To: Yi Zhang <yi.zhang@redhat.com>, Aaron Tomlin <atomlin@atomlin.com>
Cc: tbecker@redhat.com, linux-nfs@vger.kernel.org
References: <20260309145025.107623-1-atomlin@atomlin.com>
 <CAHj4cs8zCdtm7PYcbqtsQpWWCB9n71D00b5LPksLq5op7WUd=Q@mail.gmail.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <CAHj4cs8zCdtm7PYcbqtsQpWWCB9n71D00b5LPksLq5op7WUd=Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20046-lists,linux-nfs=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steved@redhat.com,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 19B1E267100
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/11/26 4:27 AM, Yi Zhang wrote:
> Hi Aaron
> 
> Verified the issue was fixed now with your patch, thanks.
> 
> Tested-by: Yi Zhang <yi.zhang@redhat.com>
Thank you very much!!! A new release is on its way!

steved.

> 
> On Mon, Mar 9, 2026 at 10:50 PM Aaron Tomlin <atomlin@atomlin.com> wrote:
>>
>> Hi Steve, Yi,
>>
>> This series addresses two issues stemming from the recent fast-path
>> optimisation used to reject non-NFS block devices, which were caught during
>> blktests.
>>
>>      1.  [PATCH 1/2] fixes the glibc abort(3) by explicitly
>>          zero-initialising the device_info struct. This prevents the cleanup
>>          path from attempting to free uninitialised stack memory when the
>>          fast-path triggers an early exit.
>>
>>      2.  [PATCH 2/2] updates the error handling in main() to log a
>>          descriptive debug message rather than a general error when a device
>>          is intentionally skipped, preventing misleading udev journal spam.
>>
>> Aaron Tomlin (2):
>>    nfsrahead: zero-initialise device_info struct
>>    nfsrahead: quieten misleading error for non-NFS block devices
>>
>>   tools/nfsrahead/main.c | 8 ++++++--
>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> --
>> 2.51.0
>>
> 
> 


