Return-Path: <linux-nfs+bounces-2736-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB9E89E19C
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Apr 2024 19:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D29F9284B16
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Apr 2024 17:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517A313D88A;
	Tue,  9 Apr 2024 17:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UsOZ8mJy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E4813C66C
	for <linux-nfs@vger.kernel.org>; Tue,  9 Apr 2024 17:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712683913; cv=none; b=SBl4tTevYK/+KJsfu5tAci+LlemuahWwkddRJ3HqZge4ZEheMQS8e6X2yu6sDkuLPlfqqkp0wdcuOd2A1VbPVc1EmU0DX3YcwC65PdHZarBVZH/6YQ0f66aoqg2rfsmx8ROUGoDoabk7ehDQSrrB0j+azQLjkLY/7TMIvFK9meM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712683913; c=relaxed/simple;
	bh=xzJMe+khi49TgZe/2ADpayzaEMbOIdUtX2HJfYe7iT8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AqKmT8UfLFoVMoaZeFZC7hOzfF/DYzSinSI33Kloe7CL/s1FKyK1qScReHV/5PRp/NqcQYFfEzgMWi9V3Lxda+qus2dkpC0fL+jXSigMhs3DNXp34Hp11RtX0G0gWmZYCfIIFq5UBYHNSWfvBZ3Y1/djA3Dsd4zytWf/mllFSDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UsOZ8mJy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712683910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UwvM97yROB5AZtUoGIXIPQb3KEpwpnKIrfBzcps+odU=;
	b=UsOZ8mJyTx6mskZ3qQNq0qKSX6bQgQvBT66+7pwxZShWJNKQriW6dbPPXdvA8wycVgARAj
	6aqLIpNXKQk/MBMfUNBjmApNL/LgCdCHjVjR1zw2jP6xFhXkcO9Jho3phnmokVEYLlMFS6
	THNOJ7TWk8GCweu73rZeEhU7sxgXuo0=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-77-xa_CinN8Nm-yyPFwPsKDQw-1; Tue, 09 Apr 2024 13:31:49 -0400
X-MC-Unique: xa_CinN8Nm-yyPFwPsKDQw-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2a2d270a95cso1754863a91.1
        for <linux-nfs@vger.kernel.org>; Tue, 09 Apr 2024 10:31:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712683908; x=1713288708;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UwvM97yROB5AZtUoGIXIPQb3KEpwpnKIrfBzcps+odU=;
        b=V5PCOtmQY/LCtiPomXTvOZ1r2LTSUjxxdoOZDUZF09zQEh5L7HuVJIOcr5gyI0vMjx
         OOkoP663nPgNdVl3+fLAcFcW5PtJ8VAExj2iMid4hdK5JLou3AAPkcAOEWM/Juc73uXn
         NMJ44ToZXMUy2Wic+MPCZ3OHz66wK1MItx9cihrc5Idf4/+AkFuUa41xRq6luoGOr7d7
         OsbvIvSMNWUa0mkJ4BLT/Pcp5Am0YHARfBGXR9aKeHuRNLJPwITkKXV+agttp4Unux5W
         n3L/mHDn2CSjgajBHfgxnn5QjJ2UBBk4A/z9NjDA7YxiWK072S6a14NAp0Hu3SAQQ5x4
         3eww==
X-Forwarded-Encrypted: i=1; AJvYcCXS6d9e0RXGp1TgjmVH572KvXHNcJZF1BVSJIt8v9fAsm3Pe6kBPsRl8bi+Ky+bOdRg/EieD0+BQbpgAMb9oSMo0rHWiFF8JLnD
X-Gm-Message-State: AOJu0Yyt2eQPp65NzbAM++chuHdRh1SugUpjvyjuY2QuF4h7zNoISpzQ
	7vm+MRg7kYpcGhrdxmyCGWz97yc1+C8ZY3smX0oJdcF+AQEhlQkCZC3zrVXhYj5M2TxPIGtl6XS
	ttGJGubw++5dnFb0FyJ6nmnkeva4zzJoxnmirbVYmwv0kV9mfhQ6rYSAwUg==
X-Received: by 2002:a17:902:e5cb:b0:1e0:99b2:8a91 with SMTP id u11-20020a170902e5cb00b001e099b28a91mr431886plf.4.1712683908129;
        Tue, 09 Apr 2024 10:31:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/jj8fPTmhVmbgehLLHjqiFTXe9L2Kyb1oOe6N+BiD8LSQQ+HWQaOevwIpzfpkVBGbT/MMwA==
X-Received: by 2002:a17:902:e5cb:b0:1e0:99b2:8a91 with SMTP id u11-20020a170902e5cb00b001e099b28a91mr431868plf.4.1712683907730;
        Tue, 09 Apr 2024 10:31:47 -0700 (PDT)
Received: from [10.19.60.48] (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id p6-20020a170902780600b001e4a1f40221sm1570658pll.84.2024.04.09.10.31.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 10:31:47 -0700 (PDT)
Message-ID: <ad5d93a4-b587-415c-8d5f-e904a0021a9d@redhat.com>
Date: Tue, 9 Apr 2024 13:31:45 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: nfs-utils' .service files not usable with nfsv4-server.service
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Matt Turner <mattst88@gmail.com>,
 Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <CAEdQ38GJgxponxNxkcv+t8mhwRPzOjan58MTBgOL8p9tY=rvTw@mail.gmail.com>
 <79c69668-4f8e-448e-9f50-6977cda662fc@redhat.com>
 <CAEdQ38FOP0_g0FK5DYz954OwfJjLUf2pjQL1CX=VNC60kd8HEw@mail.gmail.com>
 <50d1fcab-ba94-405e-896a-5bbae128998b@redhat.com>
 <3138D81C-EAD9-41CD-A32D-DEA4AA002CEE@oracle.com>
 <1521cdb1-db67-4e7e-9dc2-c463d9df53fd@redhat.com>
 <ZhV55Pbv7DqhaNMs@tissot.1015granger.net>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <ZhV55Pbv7DqhaNMs@tissot.1015granger.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/9/24 1:24 PM, Chuck Lever wrote:
> On Sun, Apr 07, 2024 at 02:36:44PM -0400, Steve Dickson wrote:
>> On 4/7/24 12:29 PM, Chuck Lever III wrote:
>>> The nfs-server unit should be made to do the right thing
>>> no matter what is installed on the system and no matter what
>>> is in /etc/nfs.conf. I don't see why screwing with the
>>> distro packaging is needed?
>> nfs-server.service and nfsv4-server.service were never
>> meant to be compatible... One or the other... Maybe
>> that was the mistake.
> 
> I remember being uncomfortable with the addition of a second
> "NFS server" unit. If the logic to disable the NFSv3
> components when not in use can fit into nfs-server.service,
> that would be a better solution, IMO.
> 
Fair enough... thanks!

steved.


