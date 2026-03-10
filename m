Return-Path: <linux-nfs+bounces-19996-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gLQJFx1GsGnFhgIAu9opvQ
	(envelope-from <linux-nfs+bounces-19996-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Mar 2026 17:26:05 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DE4254B0B
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Mar 2026 17:26:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E1E0F32A9F18
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Mar 2026 15:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149842E5B09;
	Tue, 10 Mar 2026 15:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HttFZ2bc";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ixRDDgQS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F35335564
	for <linux-nfs@vger.kernel.org>; Tue, 10 Mar 2026 15:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773158048; cv=none; b=NbFWCXgH5Ewmoh9JJ8s7nylS4E51fHB4l8PWaXnvbAu7upxyCy2yEHIowU32YufLzdlNHBPD6PVSkEAldsbRVLJegCKsUNrYi84UHN6r2XJSNyHXW1RNEH2bDoOcdgfEBQXK4wIiAgPwb/6nvgM0yOS3W2V+My+TbdaJMlCy+Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773158048; c=relaxed/simple;
	bh=7ioZg7a21Rv9QZoScWBj+SMby5OM3ZgiP3sGqe4puAE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C9XvQThFMh1VtXEWsW6/afCh/uQZEZjCQJB8cXwZeOlhPvyCYU+RhTzdCrVpGABBZcED4MMsnUO5RImaa+anB20Hy9kn2p++qFQq7oC0fBn7OhXf5qvdH9KdPQaMB+HMNM10VmC0/vZDSX9D/1DWAsl5Rr0r1nFW5uADNBZYOhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HttFZ2bc; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ixRDDgQS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773158045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jpt9mFqhFlyM1KgSXg/5BnGp4jYfmibnU9uxuFIL7VU=;
	b=HttFZ2bcJPrkbDaGygTI6TmSd8HMvJntb2glLTsbaFsEUciTnK3OqPBfjAcF/ZWAOwEQU9
	z3RNQ0zi51wHbsMKV+/lvf79MsTsF7YAVvrKirT2vX2Hl8of8dYUlcmnNFm/ELbeaTgoW7
	Au4ERzbymSg3SHwU4LzHnwn3lgmf0HA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-AhvnWthyMuOLWSLMbBRUJA-1; Tue, 10 Mar 2026 11:54:03 -0400
X-MC-Unique: AhvnWthyMuOLWSLMbBRUJA-1
X-Mimecast-MFC-AGG-ID: AhvnWthyMuOLWSLMbBRUJA_1773158042
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4853a9467c5so14832155e9.2
        for <linux-nfs@vger.kernel.org>; Tue, 10 Mar 2026 08:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773158040; x=1773762840; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jpt9mFqhFlyM1KgSXg/5BnGp4jYfmibnU9uxuFIL7VU=;
        b=ixRDDgQSw7owrkyg2iVZOKtl3goUm8TmNWrmkTadnIXIsfEwVlkQB2hu21/Wm4nnoY
         93xODnKdDHe5PFi0rZUXGoLSTq88wxLgZcie0gUSUZdbeMGJif5JvR+P9mcHziqnPz8E
         nfKSL1JznuIAcG4n4OvHBb6eSUtBselhPOGOYu3D7KyX1lMLiuEIpnGZ9aOUv1mJM5Ko
         AqSQnMyWInGNRSKb7LAb4NXAgL2TYFAql0K6Qo9wbF+7pMoUWvGw+01SscNU6/riweOp
         eyQAl8QqnMnQnmTL78H8XoJVbGLY5NgWe7E8NWMSNDiSHyqc9+KGTfvhtzEOfIs0BS81
         mKNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773158040; x=1773762840;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jpt9mFqhFlyM1KgSXg/5BnGp4jYfmibnU9uxuFIL7VU=;
        b=NNUxA0hTjELwv/CPw3d1cyHTVebile9EbZHtI5FNJEfrRkSHvlPIcqG6/mdL8FdVKY
         05LjxdtMm1XaUdYhk4eClZbmXGaDwZn29SnjWBWK3bHBpbPkNNBgfiZ7JzUwVmzmRMoh
         jx6T/sPWK0KSA/kvgKv2EZ/Ob1eW07G/MHC+JFjwboDThrCxZnBIhdDtZDpJZ4uSqtPX
         fsigKrg1+3qKE7MMraRdAC2SZYb7EMOmHUFW7ijRTkRe9TYfWH1CHu06R8UChwXMJ8MO
         U7GW2s8Hr/0oHeP6UpybCOJ9nQCzKLHY1hTqkA1KxjtjnUPFPfFnSkhCb1eAPm4JrBj/
         Im4Q==
X-Gm-Message-State: AOJu0Yzerk1xLCwlVBtDPYwMbDZVfgyl6rJotklOeHzWq7NF1bfGexbP
	L6LQT2dFxmd7DF7OW5OSB9ztpYpAoiS85oR/lcXN1oa/S59IYIaBnQONrIhB/zB3uWuk/DvnBu4
	pC2hp+Euy2sJdsgjyP+ZgCalKVN8EunTVZtbzemvi10ZSZboJwtUv9Lp9ZWrEKBcYVVFUwA==
X-Gm-Gg: ATEYQzwyl3/H9YmWmYcHYsbfIz+fIOhxqWgKVdUb8OthtqlLaG3iHWUmLTadECDe/N3
	0h9UvaqAEdWPF5GpICp1G7SNH3TsTat6p7jZt+FD9sK4mtn6FZDZOF856PTJ+ffv0zNfTddGbWW
	auHCldJ0n7WCx9dEKJnLXRWcCReDttfzQxVQ+zUeN4fI6Ug7RAIQuE5E7KM92vZcn+l/HnaXHZ0
	PbGmXR/ywL2z1KHCzzbXoYMO6teIoh7I5SZIrKzgTv7+mNVtvYUhMPH+KivYSNcJiZB4bFbOK9f
	2g/GagjjbF5H6vUYK9hJz5vX4mZIcqmoj1iQl8wFUjOvhoEP4DUwl3dfPY09O+gzBKmwSBwiV3t
	dW7GUfDmOpS8Yv3BJWyH11UmI
X-Received: by 2002:a05:600c:138a:b0:47e:e2eb:bc22 with SMTP id 5b1f17b1804b1-4852691c5bamr281188685e9.5.1773158040431;
        Tue, 10 Mar 2026 08:54:00 -0700 (PDT)
X-Received: by 2002:a05:600c:138a:b0:47e:e2eb:bc22 with SMTP id 5b1f17b1804b1-4852691c5bamr281188235e9.5.1773158039887;
        Tue, 10 Mar 2026 08:53:59 -0700 (PDT)
Received: from [10.193.213.69] ([144.121.52.163])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541acea11sm95368475e9.7.2026.03.10.08.53.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2026 08:53:58 -0700 (PDT)
Message-ID: <7a6d7d71-b57d-4d57-ab79-ccf56e15308a@redhat.com>
Date: Tue, 10 Mar 2026 11:53:48 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "nfsrahead: enable event-driven mountinfo
 monitoring and skip non-NFS devices"
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <20260310123623.53580-1-steved@redhat.com>
 <pfrnxhemafqrmfgvo26j5dal4o7g4sxu5thtdgwmwxvlwabynh@p6ssyobhcehn>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <pfrnxhemafqrmfgvo26j5dal4o7g4sxu5thtdgwmwxvlwabynh@p6ssyobhcehn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: E5DE4254B0B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19996-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steved@redhat.com,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action



On 3/10/26 9:28 AM, Aaron Tomlin wrote:
> On Tue, Mar 10, 2026 at 08:36:23AM -0400, Steve Dickson wrote:
>>   #1  0x00007f1a8670b15e raise (libc.so.6 + 0x1a15e)
>>   #2  0x00007f1a866f26d0 abort (libc.so.6 + 0x16d0)
>>   #3  0x00007f1a866f373b __libc_message_impl.cold (libc.so.6 + 0x273b)
>>   #4  0x00007f1a8676f665 malloc_printerr (libc.so.6 + 0x7e665)
>>   #5  0x00007f1a8676f684 malloc_printerr_tail (libc.so.6 + 0x7e684)
>>   #6  0x00005624543b1d32 main (/usr/libexec/nfsrahead + 0xd32)
>>   #7  0x00007f1a866f45b5 __libc_start_call_main (libc.so.6 + 0x35b5)
>>   #8  0x00007f1a866f4668 __libc_start_main@@GLIBC_2.34 (libc.so.6 + 0x3668)
>>   #9  0x00005624543b1fb5 _start (/usr/libexec/nfsrahead + 0xfb5)
>> ELF object binary architecture: AMD x86-64
> 
> Hi Steve,
> 
>> https://bodhi.fedoraproject.org/updates/FEDORA-2026-e033b6bafe
>>
>> This reverts commit 0f5fe65d83f7455112aea82bf96f99523cb03ca7.
>> ---
> 
> I thought this was resolved with [PATCH 1/2] nfsrahead: zero-initialise device_info struct [1], no?
> 
> [1]: https://lore.kernel.org/linux-nfs/20260309145025.107623-1-atomlin@atomlin.com/T/#t
> 
> Please note that series [2] is based on this particular patch.
> 
> 
> [2]: https://lore.kernel.org/linux-nfs/20260309145025.107623-1-atomlin@atomlin.com/T/#m1309a5bf24457934f3d2db7ca5706e240aae51d1
> 
> 
> Kind regards,
Okay... v2 does apply so I'll go with those....

steved.



