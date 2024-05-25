Return-Path: <linux-nfs+bounces-3379-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F688CEEED
	for <lists+linux-nfs@lfdr.de>; Sat, 25 May 2024 14:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CA6CB2078D
	for <lists+linux-nfs@lfdr.de>; Sat, 25 May 2024 12:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24613101F4;
	Sat, 25 May 2024 12:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i/enWfU/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4971F1E487
	for <linux-nfs@vger.kernel.org>; Sat, 25 May 2024 12:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716641109; cv=none; b=gMd12RIG5+M3cpomzVw8RG7lsjOewc0Eto8+wUWAaTDQ3rkoorgmGZ7HjQboDp/nAvw+hCDWKwtu1UM3yk4+h9Ma1mNbbIwl5xwpMlwXmH1s/vveDZ9MNhAyuhoSPfBSqbONkLMVaqI84y4vckbin80LracfANMBV3/TnjyWlgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716641109; c=relaxed/simple;
	bh=xE0qmoe0zco5Tezif5LfOIi1LXwjEgMkNXdejrwpXYY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lJjm1SKsLxnE7JM8LFLK0NtKe9lbVPe12IA3bxRyRxYb+514i8y8u3D6Ab7T5EQiNMW7SWcnz2/dsAaJxHOJRUUfwbykZr3ERLe5Gmph2iLCZdMwz1NJZU5wBcuqjqn/4Qd4pmvfp22yGqpu1uv/RqibdC/wNGvvaKRIRoxBxrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i/enWfU/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716641105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m7tRpEvY0mpvQ9IYgGgB2D8NPeZlqhtGZQ66o+2iAo8=;
	b=i/enWfU/fA29EbpepM5eWJoURCSs0LZ59kafcAISn3+ct0L9OreyYdS7YNKxUKggJ9jbfm
	rMQ58QAvbJQakE39EL2VsRVZ1EEZRqSnddxME644RL0tuk81LcvDaO3rNKacdc7xnFcmA7
	gpQTX5WjuK0oVbDY6ZjAdyMnS5aW4Uc=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-46-Yc3MD4jHO2OlWDhnK0XWwQ-1; Sat, 25 May 2024 08:45:00 -0400
X-MC-Unique: Yc3MD4jHO2OlWDhnK0XWwQ-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6ab8ca6df0bso5616966d6.3
        for <linux-nfs@vger.kernel.org>; Sat, 25 May 2024 05:45:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716641099; x=1717245899;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m7tRpEvY0mpvQ9IYgGgB2D8NPeZlqhtGZQ66o+2iAo8=;
        b=WgyMsbF8FQaAvoXODnpxnr25OIoZM8k0Z7vWWS+26P+DyfQh/ILBEb/LLSmn7c0br5
         HKqFczFjeFWtt9rfDAVDDQGRwZ/8+7+W0IMYbNBB5qHd8OS/IqFtcV+PFtr9pRUP7USt
         q5uNVKEZXF2Qta8YJKdYaJYhEWkt/xN0/Rmx7ZOyIyD50iAqKDfA2wy1nhZHSReAPMcK
         /m/2QA7q2x12ccUuNZ7MoUgmlqsC0dgnWmi1HEEtJkS873DOTMJrUXOFTiF5t07+Zb+t
         CiHXBP84BjY0ysNSQjqDmivN6FCmjws5Ns7RlpS6PSX52Ip2m3C6KBPszVzKEaBk69U4
         +EoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXp+k4JrdyW4riL0xICeeiUHFanD9w7BnqjbM2rJVhpQYSp08xdGGGTWUPHVCj6RUiJrph4kjLfA+y3xPkUm4rx4tLeaLkZcIlI
X-Gm-Message-State: AOJu0YxAAGVxSw7gERzkPWppW0BCg/4DkH+5vYcB9bjh0s5EiG9/2vuK
	w8n7Y2MnHrzpXWRLScEA6uGvvoYJ1yTS8wOY0FxuAL718ACxSf82Cu1l+Kfb7G636028BoVkfLD
	8jAuOFAcPjALQshbv6h3OgCKPmUXXw63jCN5tTkd25cjCcUrurugoWnHlI3SbPacE2g==
X-Received: by 2002:a05:620a:2a16:b0:790:a8bf:e816 with SMTP id af79cd13be357-794ab116e7amr541159385a.5.1716641099203;
        Sat, 25 May 2024 05:44:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyBPDcLhcoapmawNYpa/muCLdtf5R2KjJrUqQ8UDG7jnSoU0tR4fzWtB/4OWs6i2qqB7mMxQ==
X-Received: by 2002:a05:620a:2a16:b0:790:a8bf:e816 with SMTP id af79cd13be357-794ab116e7amr541157085a.5.1716641098807;
        Sat, 25 May 2024 05:44:58 -0700 (PDT)
Received: from [172.31.1.12] ([70.105.245.214])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-794abcdca88sm144109985a.66.2024.05.25.05.44.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 May 2024 05:44:58 -0700 (PDT)
Message-ID: <85db2b8e-c06a-4f64-bc11-611fb024e95e@redhat.com>
Date: Sat, 25 May 2024 08:44:57 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: RFC2224 support in Linux /sbin/mount.nfs4?
To: Dan Shelton <dan.f.shelton@gmail.com>,
 Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <CAAvCNcCTWbU-ejURuUC0_xhcoU3GF+2jX28rV4+2cKgfO5Lqxg@mail.gmail.com>
 <619bbf23-dbfe-4c26-adb9-1cc89f3f22a2@redhat.com>
 <CAAvCNcCGhZ917yerEOMcEEj7+_Yz5by8en2F4Yr5zLk0iQEGjg@mail.gmail.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <CAAvCNcCGhZ917yerEOMcEEj7+_Yz5by8en2F4Yr5zLk0iQEGjg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/24/24 1:11 PM, Dan Shelton wrote:
> On Wed, 15 May 2024 at 23:46, Steve Dickson <steved@redhat.com> wrote:
>>
>> Hey!
>>
>> On 5/14/24 5:57 PM, Dan Shelton wrote:
>>> Hello!
>>>
>>> Solaris, Windows and libnfs NFSv4 clients support RFC2224 URLs, which
>>> provide platform-independent paths where resources can be mounted
>>> from, i.e. nfs://myhost//dir1/dir2
>>>
>>> Could Linux /sbin/mount.nfs4 support this too, please?
>> Why? What does it bring to the table that the Linux client
>> does already do via v4... with the except, of course, public
>> filehandles, which is something I'm pretty sure the Linux
>> client will not support.
> 
> This is NOT for Linux only. Every OS has its own system to describe
> shares, and not all are compatible. URLs are portable.
True... It is just clear to me how having NFS URLs are portable...
portable to whom?

> 
>>
>> So again why? WebNFS died with Sun... Plus RFC2224 talks
>> about v2 and v3... How does it fit in a V4 world.
> 
> This is NOT about WebNFS or SUN, this is to make the job of admins easier.
I'm all for making admins jobs easier... But what problem would NFS URLs
solve?

steved.
> 
> Dan


