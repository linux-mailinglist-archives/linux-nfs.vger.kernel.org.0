Return-Path: <linux-nfs+bounces-7511-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D686F9B1866
	for <lists+linux-nfs@lfdr.de>; Sat, 26 Oct 2024 15:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5782BB210FB
	for <lists+linux-nfs@lfdr.de>; Sat, 26 Oct 2024 13:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72BDA217F47;
	Sat, 26 Oct 2024 13:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dcui9sqQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C2C1D363B
	for <linux-nfs@vger.kernel.org>; Sat, 26 Oct 2024 13:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729947850; cv=none; b=oB2QcHkEw9i8GTH/YEawz28Ewt996+WsFAxKB6Po8P+FysvBDdgBWviXNWfSr08L1BeDJYSvQXNtRP3hwe4ob60bFSAqd0KvU2ePqJ9B5Wt3Dodv/Kv4fKRsP5fvv9BBHCyI83tVUJWQbCkT3YdV2dftoFFnob5oxGU6xeNDCCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729947850; c=relaxed/simple;
	bh=pSKFteR4BLroUjrL6+YVAa0bMPnOgLe+O9Sq0/bofKo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HsjPRSeAHNkFxAZ4PPo9l/qUxJMz+9N7SpCQSus/K+izJtoK1MJ6qvW2A2Y2t3YdLCxb/bFVlQTHl0D6DcJxC0ABb/5W9O9wpelZMKaABahjCpWbz2Obw580q0TZWXQ/Vjhucet4kPa4eRvUrfGzJXXR01rQcsE3ugzRTH2SPZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dcui9sqQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729947846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oP5qh+2LMA7a60ZaSKTVi4dOBgz3urbmbQ3HXtyem6o=;
	b=dcui9sqQnVWnLja2y88QIQd+7/dc/MwaPtHnwEjQN3rYciJHUq99MAhd6yr4rHDboxiGfR
	BQZBLmyq88BfPLBEaUlKW2two3I5Kpysj5rPEez3P6Kjz5o7aeO7KysNQMMyyTmYGSaAwF
	AVDkf7ZLqOTUjMQzQ0/cpVLY8AZ1fqQ=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-A2tLaInrM_6j7wB3H8_LFA-1; Sat, 26 Oct 2024 09:04:05 -0400
X-MC-Unique: A2tLaInrM_6j7wB3H8_LFA-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6cbf054c552so43282086d6.1
        for <linux-nfs@vger.kernel.org>; Sat, 26 Oct 2024 06:04:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729947844; x=1730552644;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oP5qh+2LMA7a60ZaSKTVi4dOBgz3urbmbQ3HXtyem6o=;
        b=MA7lnFATdG4U3kb0lQJXNvhgbQnglZicmKS6OxCGpPWfqk6z3Fl1gu2PzO2fMdf2Jf
         avGic8mTb9+B1fS2oFGtihG4XVNb5DdI8fgNpjEacQ4jnePFdBO+KkkRNK9r33Y27ay2
         0MuWfKuMDMudO027e+XSPOh6OLjX3WDMBVpS2pH30PMOpWvXySpn9SehE+b0px8siYhi
         yihpd365x1MJ16TdgIHaNVk+BjGzNYoLhKnJHvlGjzJsJca6QADkg/gvNA9IoO+x0Lh1
         CVunVjYPyWg7JhnE7W6kloLIUQ48ZrZwI7Dp6+d50JF5/jc82vCImM6MbJiPC2QOoSfa
         lG/Q==
X-Gm-Message-State: AOJu0Yw4umPtJLEoBxYGoigND+x94klhQyVm23viTZNJbB0V66IDpYM6
	UDgGmEXzKVPKUm5oSgLRUgQznPw3qOWebii7cdVnI739kURacFyCsFzxBNKzU3fFjYlKkFZm5ZB
	lIDZ8czhIcF0tfet3tL6gY/LH6XojnBzM8WpDf0sGM6S0SkVLkxP4cMdidw==
X-Received: by 2002:a05:6214:5710:b0:6cb:c905:f380 with SMTP id 6a1803df08f44-6d1856747f8mr45469936d6.2.1729947844475;
        Sat, 26 Oct 2024 06:04:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOr7q+FyP5hVzimjQTuBDZI2U3QLGmIw03Lea12ADlLfLZkF/2c5bPvkXfaAtHENLRaDn4hQ==
X-Received: by 2002:a05:6214:5710:b0:6cb:c905:f380 with SMTP id 6a1803df08f44-6d1856747f8mr45469426d6.2.1729947844105;
        Sat, 26 Oct 2024 06:04:04 -0700 (PDT)
Received: from [172.31.1.136] ([70.109.134.69])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d179a068d1sm15101956d6.101.2024.10.26.06.04.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Oct 2024 06:04:02 -0700 (PDT)
Message-ID: <1fc7de18-eaf0-4a1e-bd41-e6072b0f3d7f@redhat.com>
Date: Sat, 26 Oct 2024 09:04:01 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: NFSv4 referrals broken when not enabling junction support
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: linux-nfs@vger.kernel.org, Chuck Lever III <chuck.lever@oracle.com>
References: <Zv7NRNXeUtzpfbJg@eldamar.lan>
 <e7341203-c53c-4005-9d70-239073352b2b@redhat.com>
 <ZxUVlpd0Ec5NaWF1@eldamar.lan> <Zxv8GLvNT2sjB2Pn@eldamar.lan>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <Zxv8GLvNT2sjB2Pn@eldamar.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/25/24 4:14 PM, Salvatore Bonaccorso wrote:
> Hi Steve,
> 
> On Sun, Oct 20, 2024 at 04:37:10PM +0200, Salvatore Bonaccorso wrote:
>> Hi Steve,
>>
>> On Tue, Oct 08, 2024 at 06:12:58AM -0400, Steve Dickson wrote:
>>>
>>>
>>> On 10/3/24 12:58 PM, Salvatore Bonaccorso wrote:
>>>> Hi Steve, hi linux-nfs people,
>>>>
>>>> it got reported twice in Debian that  NFSv4 referrals are broken when
>>>> junction support is disabled. The two reports are at:
>>>>
>>>> https://bugs.debian.org/1035908
>>>> https://bugs.debian.org/1083098
>>>>
>>>> While arguably having junction support seems to be the preferred
>>>> option, the bug (or maybe unintended behaviour) arises when junction
>>>> support is not enabled (this for instance is the case in the Debian
>>>> stable/bookworm version, as we cannot simply do such changes in a
>>>> stable release; note later relases will have it enabled).
>>>>
>>>> The "breakage" seems to be introduced with 15dc0bead10d ("exportd:
>>>> Moved cache upcalls routines  into libexport.a"), so
>>>> nfs-utils-2-5-3-rc6 as this will mask behind the #ifdef
>>>> HAVE_JUNCTION_SUPPORT's code which seems needed to support the refer=
>>>> in /etc/exports.
>>>>
>>>> I had a quick conversation with Cuck offliste about this, and I can
>>>> hopefully state with his word, that yes, while nfsref is the direction
>>>> we want to go, we do not want to actually disable refer= in
>>>> /etc/exports.
>>> +1
>>>
>>>>
>>>> Steve, what do you think? I'm not sure on the best patch for this,
>>>> maybe reverting the parts masking behind #ifdef HAVE_JUNCTION_SUPPORT
>>>> which are touched in 15dc0bead10d would be enough?
>>> Yeah there is a lot of change with 15dc0bead10d
>>>
>>> Let me look into this... At the up coming Bake-a-ton [1]
>>
>> Thanks a lot for that, looking forward then to a fix which we might
>> backport in Debian to the older version as well.
> 
> Hope the Bake-a-ton was productive :)
> 
> Did you had a chance to look at this issue beeing there?
Yes I did... and we did talk about the problem.... still looking into it.

steved.
> 
> Regards,
> Salvatore
> 


