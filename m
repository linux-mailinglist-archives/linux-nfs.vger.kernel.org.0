Return-Path: <linux-nfs+bounces-9229-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1DAA126FA
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jan 2025 16:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EAC11884E23
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jan 2025 15:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E63F24A7D4;
	Wed, 15 Jan 2025 15:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dPeH894t"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B78624A7D3
	for <linux-nfs@vger.kernel.org>; Wed, 15 Jan 2025 15:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736953981; cv=none; b=oe+ytiJ1NOCYZ3qV8gq8xiHlOMbl61QRpPHKEVTcAyHCYi3Tg/52jqPOjhTBwfSiF/0DFx1sDtFcX3DGDo7cCQinzIVY/cIm5MQp1VaiybCkG9VxPpr1yHXRPJSIS4M9VN/K9a0+9418ZT5MP3dUM71MmFDvxmuFaZIUV4lLnOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736953981; c=relaxed/simple;
	bh=FmadufUSplUmRzXlCaz8urVLAFh8cbIERQZD3qvv0Bk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CLMrI08wlp7vWCJnOr9P8V3f0u31Za8B3uI7wLLhRc4KK8zxDffnSENS9ODS1T/7DlpHTwocnp4OoeXBmSdPqDCSQPUyg0Z9gwHaSsYbj9bgfv6LX8wexFrzDQ9Iy9uKxdhxKMm/5pWWJFo/pJYAxxPnCFQq2MZTav28sZOCaGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dPeH894t; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736953978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H6MAEsOyaF6wYciFkY2/9GhEOY0dPyA6Z6ECr6ONBIs=;
	b=dPeH894twchqYRi0w3pG/bBHjgJ1a7DAfzZW609Pao9jzAVFIDPf8kjUqlUk/YRIAMuxHE
	E02/sCtWLdiqW7MYEXOc/1ni3uZbbeWiuzMvfqBRvFQ9RzF35BttmRTgiQkZ6VuNBsYgzE
	8lqf6X+dyk2N3M++UqxcmYMDNvStUOM=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-116-9aQQTtNxNhqgrGHqFap8lg-1; Wed, 15 Jan 2025 10:12:57 -0500
X-MC-Unique: 9aQQTtNxNhqgrGHqFap8lg-1
X-Mimecast-MFC-AGG-ID: 9aQQTtNxNhqgrGHqFap8lg
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-21640607349so148541025ad.0
        for <linux-nfs@vger.kernel.org>; Wed, 15 Jan 2025 07:12:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736953976; x=1737558776;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H6MAEsOyaF6wYciFkY2/9GhEOY0dPyA6Z6ECr6ONBIs=;
        b=t1eXzilGhzvqdsiyMV101aBm6jYQnIiPwsXLOqPZgwsn7Nm+DVMej3j7UUUx7tCR/r
         774LfKihVMz9k9nCXbhtMTxy2mJyPpL9cSqBjaJvkRZKCfwbPanbzNEc2ss52xQUtFqx
         Zi39hl3lTrRwtnt16OSlZ74gLv8eQtVcJaYiu4hc6nfZmLVCpxA24OO0d3OZR1FmArBM
         zbsiz00ZkZgTB8nknLzzc/Qnxep3VJ2jhRZqwu3Hc+tGDvkFr643Aib4p0aQB+1rtCG5
         ciQxyIsP4CQQnSjcG3Canrr657MeX+hLPDxHHkBxnwA1U2UfvcNPCxqvwgBtlpWeqcnT
         Pl5w==
X-Forwarded-Encrypted: i=1; AJvYcCX1vdtKIxiB4DOd7wNY5YIX+t3qPc00IiJfEtlSHFlFtOcaZpq/0S7eVpwnuulA4kWW2Z9NcpXekbY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtJacXXz5+GQySuDGagftbxa7Kti7NBu18m2mIsp0bzPnea6+P
	zRFez1ayV3lhcQS7zmm8onokJsWY1xicf8R5BcyErDElt5nuCOic7YjplyZs73UWiC7lDdHEA/k
	dRlr1260FRwKIwRmqSiWHGHcV8zeE/S5H4KcrXr1c4G7wZThOa+xr2b3Fjw==
X-Gm-Gg: ASbGncvSrRgv6kVTKzUep5TeOiOR+ZKio9Ffs6xbm4PycSPmLL+pvwd0L2f1c4/fDvg
	WCuWtTLxBUW7352tksnjnIo1FpThLWjy4HhoRVIO18TAB4LZr0TpOA8OwJG4eTtTIJgzanqOGRz
	TYfMekkUDHEXyG2TRan+bWzYdpXgVOAuIbYZjK5KP3E8iXDP6E7xfgo7sSFJtYj52A1R31w4us0
	Tq6ZEotj5dggsaUybIuwj7OVUXcUDV8ZxZ+zaDAm18IJGXbyOgBT/ND
X-Received: by 2002:a17:902:ea03:b0:216:31aa:12fc with SMTP id d9443c01a7336-21a83f6c665mr540083455ad.24.1736953976168;
        Wed, 15 Jan 2025 07:12:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGs8tfZ9O+vfr1oGQ8MVYUfoCDyCsFTlvoUcKYQaTV9NP/Q90uQEhwiY7BvVP+Y2aFLQLhx7g==
X-Received: by 2002:a17:902:ea03:b0:216:31aa:12fc with SMTP id d9443c01a7336-21a83f6c665mr540082905ad.24.1736953975824;
        Wed, 15 Jan 2025 07:12:55 -0800 (PST)
Received: from [172.31.1.150] ([70.109.132.27])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f2199ebsm84365775ad.143.2025.01.15.07.12.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2025 07:12:55 -0800 (PST)
Message-ID: <532ea7d0-afe9-47c0-8436-6891a4b63da4@redhat.com>
Date: Wed, 15 Jan 2025 10:12:53 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] nfsdctl: add support for new lockd configuration
 interface
To: Jeff Layton <jlayton@kernel.org>, Scott Mayhew <smayhew@redhat.com>
Cc: Yongcheng Yang <yoyang@redhat.com>, linux-nfs@vger.kernel.org
References: <20250110-lockd-nl-v2-0-e3abe78cc7fb@kernel.org>
 <Z4bScYOgDwbpyXjt@aion>
 <659d6f0153daf83ebfcad8d7bdb80adb6aa319b5.camel@kernel.org>
 <Z4fJz4re4iFyM2FE@aion>
 <5487afbab2acfe396e1ccc8ba3dfd1256fa00c7b.camel@kernel.org>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <5487afbab2acfe396e1ccc8ba3dfd1256fa00c7b.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/15/25 9:56 AM, Jeff Layton wrote:
> On Wed, 2025-01-15 at 09:44 -0500, Scott Mayhew wrote:
>> On Tue, 14 Jan 2025, Jeff Layton wrote:
>>
>>> On Tue, 2025-01-14 at 16:09 -0500, Scott Mayhew wrote:
>>>> On Fri, 10 Jan 2025, Jeff Layton wrote:
>>>>
>>>>> v2 is just a small update to fix the problems that Scott spotted.
>>>>>
>>>>> This patch series adds support for the new lockd configuration interface
>>>>> that should fix this RH bug:
>>>>>
>>>>>      https://issues.redhat.com/browse/RHEL-71698
>>>>>
>>>>> There are some other improvements here too, notably a switch to xlog.
>>>>> Only lightly tested, but seems to do the right thing.
>>>>>
>>>>> Port handling with lockd still needs more work. Currently that is
>>>>> usually configured by rpc.statd. I think we need to convert it to
>>>>> use netlink to configure the ports as well, when it's able.
>>>>>
>>>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>>>
>>>> I think the read_nfsd_conf call should be moved out of autostart_func
>>>> and into main (right before the command-line options are parsed).  Right
>>>> now if you enable debugging in nfs.conf, you get the "configuring
>>>> listeners" and "nfsdctl exiting" messages, but not the "nfsdctl started"
>>>> message.  It's not a big deal though and could be done if additional
>>>> debug logging is added in the future.
>>>>
>>>
>>> That sounds good. We can do that in a separate patch.
>>>
>>>> Reviewed-by: Scott Mayhew <smayhew@redhat.com>
>>>
>>> Thanks!
>>
>> Hey, Jeff.  I was testing this against a kernel without the lockd
>> netlink patch, and I get this:
>>
>> Jan 15 09:39:16 systemd[1]: Starting nfs-server.service - NFS server and services...
>> Jan 15 09:39:17 sh[1603]: nfsdctl: nfsdctl started
>> Jan 15 09:39:17 sh[1603]: nfsdctl: nfsd not found
>> Jan 15 09:39:17 sh[1603]: nfsdctl: lockd configuration failure
>> Jan 15 09:39:17 sh[1603]: nfsdctl: nfsdctl exiting
>> Jan 15 09:39:17 sh[1601]: rpc.nfsd: knfsd is currently down
>> Jan 15 09:39:17 sh[1601]: rpc.nfsd: Writing version string to kernel: -2 +3 +4 +4.1 +4.2
>> Jan 15 09:39:17 sh[1601]: rpc.nfsd: Created AF_INET TCP socket.
>> Jan 15 09:39:17 sh[1601]: rpc.nfsd: Created AF_INET6 TCP socket.
>>
>> Do we really want it falling back to rpc.nfsd if it can't configure
>> lockd?  Maybe it should emit a warning instead?
>>
> 
> I thought about that, and I think it's better to error out here.
> 
> Falling back to rpc.nfsd is harmless, and only people who are trying to
> set the grace period or lockd ports will ever hit this. lockd
> configuration is a no-op if none of those settings are set.
> 
>> At the very least, NFSD_FAMILY_NAME should no longer be hard-coded in
>> that "not found" error message in netlink_msg_alloc().
>>
> 
> Yeah, that would be good to fix.
> 

On a rawhide kernel (6.13.0-0.rc6) the server does
come up with 'nfsdctl autostart' but with the
new argument 'nlm' I'm getting

$ nfsdctl nlm
nfsdctl: nfsd not found

steved.


