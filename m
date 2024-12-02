Return-Path: <linux-nfs+bounces-8306-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C61629E0AF5
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Dec 2024 19:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85E8028228B
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Dec 2024 18:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07EBC1DDC02;
	Mon,  2 Dec 2024 18:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AHuGx+Xe"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228511DA0EB
	for <linux-nfs@vger.kernel.org>; Mon,  2 Dec 2024 18:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733164013; cv=none; b=tStvq/FX/GWSeHZasvQ4O5LqxsoQBF/1ThC31N/yyVopknpZjLc4CfaQ2xh2OeKcso07eXFM33VZ2gJQGC76kA9BLbv+TJzg0kw6nOAffnuMB5vme+pi5drM6w07deDxIhfOQ9N2g/W5gZ90zuC/EYpkfNPeybeEXHQ2xz7uiNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733164013; c=relaxed/simple;
	bh=MjjPpxRwzJRpQr3G+Juqhe5O7GctCToO/icV+gKyKQs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l9/Poshz2dk+Q3knWLaVaxYpNEbuSY92VV2SihhCfG24SJaDPrCkCMM/NnF/kkEb1QwWoA6eRFiKVXjon3hADkvINACgI3BPj6lLodXBQR/Jycxgsb12/HXfxOIN0PV05cnugmnPc5OYoPy0AqxY0cu+M//EPO4j9ei8XyHW+VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AHuGx+Xe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733164011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uSSUBulKfYWzdkbdL/6KioQzaKwy8hJigfGy76ZTCnM=;
	b=AHuGx+Xe2puKyO/j9LEoozTi+jcwiO0q7PJomk4O57URUdySx0x3EQA3nk0FRLQ9RAGj8I
	gK8fY4H0pxPsq7bHkMXW3hUS27qxhoxvlmaV2efLYdd3HhqWdJtzrqddc77S7nxt4YhhOu
	F1+7DHtosdx0gD6DKAyl8Xx4nc7T60U=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-Oq0U6T5NOcOp_uIxd1V6Mg-1; Mon, 02 Dec 2024 13:26:49 -0500
X-MC-Unique: Oq0U6T5NOcOp_uIxd1V6Mg-1
X-Mimecast-MFC-AGG-ID: Oq0U6T5NOcOp_uIxd1V6Mg
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a71bdd158aso45114755ab.1
        for <linux-nfs@vger.kernel.org>; Mon, 02 Dec 2024 10:26:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733164009; x=1733768809;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uSSUBulKfYWzdkbdL/6KioQzaKwy8hJigfGy76ZTCnM=;
        b=jae/DEZrwf8mFy5nTfVqzFsKlClpG7rrsNn/DD6EJ48Uc6eOJGfMGnwam03CXHNnqM
         Ml9vf+wxY5DvSeojgIQgVaWhyrKfV/jBzgjUznUJVOg1U8P8Wx/uTpUVEpPx5mWT1NUP
         hAvTOkme6ee4shGXSEc0nNF64M0SQ/nVZ9et7qX8ANMv6HpmubNpWxrRcWnr0nv1gn7A
         OMmw5qJKSEL5wQMCQMkM3HPI7Xfod1fMWug+7/9lwBLL7wRFOX1SrjBlmqKCzJc239yH
         hiyn3/au9nkHHpH1J8Wjh4t8TJKEcgd9TwJR/irXiXemzTlM9SiY+R+YHO/ugdNye8Rk
         YWBw==
X-Gm-Message-State: AOJu0Yxwbs1fGlr4T5A0t3l4fDRQDsYTN2sJnTS7rYNg+JtWqYEUnSXp
	l03e57UgJph47pZfDfiBQlq7iIbK22ftpPs8rt8NH4ne+PiD/VO+ybBNpi4oDkRU29iogO+Y8+N
	pbL0X7/bdpPKQpZzAH1bAi5F78Sz4mzOmzgmQFfvxykrphMbfZw42ULYY5Q==
X-Gm-Gg: ASbGncsne8XbNYBxjilAffdxSdJjHbVgMI/TH7o/1P7OTo/9NmfGs7vKVk0OfY0xX7g
	jhLSuq8S+sFRKrCOychWfT2777F8OmgTv9uj7e5JP07KlOc1wgmzzzKR7lFRdRysi46E5WiLqka
	zrsfRsarrxA5IaKf4ptpGy8bKG15cek9i5SMMsOfa3yDI9SvxgS0COuR5+QHPWurYp3kbBcDyEb
	zudmJH7ZJqdp0VAt040owGQbLM9EQjVIUqiaEo4MZ0RVr3WzQ==
X-Received: by 2002:a05:6e02:1989:b0:3a7:91a4:c752 with SMTP id e9e14a558f8ab-3a7c55ec10emr223191215ab.23.1733164009112;
        Mon, 02 Dec 2024 10:26:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGvKy+JCyzSQ2A2ZslsQRGmp/g9djZkzeS+BU26Q+sOqwziG9NVIq1LjtRicfokh5xLB16CdQ==
X-Received: by 2002:a05:6e02:1989:b0:3a7:91a4:c752 with SMTP id e9e14a558f8ab-3a7c55ec10emr223190975ab.23.1733164008802;
        Mon, 02 Dec 2024 10:26:48 -0800 (PST)
Received: from [172.31.1.12] ([70.105.249.243])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e230e90813sm2130395173.152.2024.12.02.10.26.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2024 10:26:48 -0800 (PST)
Message-ID: <e86284ac-7a77-440b-bb5d-bdb1e6f23a40@redhat.com>
Date: Mon, 2 Dec 2024 13:26:46 -0500
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
 <1fc7de18-eaf0-4a1e-bd41-e6072b0f3d7f@redhat.com>
 <Z0VVLw9htR7_C5Bc@elende.valinor.li>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <Z0VVLw9htR7_C5Bc@elende.valinor.li>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/25/24 11:57 PM, Salvatore Bonaccorso wrote:
> Hi Steve,
> 
> On Sat, Oct 26, 2024 at 09:04:01AM -0400, Steve Dickson wrote:
>>
>>
>> On 10/25/24 4:14 PM, Salvatore Bonaccorso wrote:
>>> Hi Steve,
>>>
>>> On Sun, Oct 20, 2024 at 04:37:10PM +0200, Salvatore Bonaccorso wrote:
>>>> Hi Steve,
>>>>
>>>> On Tue, Oct 08, 2024 at 06:12:58AM -0400, Steve Dickson wrote:
>>>>>
>>>>>
>>>>> On 10/3/24 12:58 PM, Salvatore Bonaccorso wrote:
>>>>>> Hi Steve, hi linux-nfs people,
>>>>>>
>>>>>> it got reported twice in Debian that  NFSv4 referrals are broken when
>>>>>> junction support is disabled. The two reports are at:
>>>>>>
>>>>>> https://bugs.debian.org/1035908
>>>>>> https://bugs.debian.org/1083098
>>>>>>
>>>>>> While arguably having junction support seems to be the preferred
>>>>>> option, the bug (or maybe unintended behaviour) arises when junction
>>>>>> support is not enabled (this for instance is the case in the Debian
>>>>>> stable/bookworm version, as we cannot simply do such changes in a
>>>>>> stable release; note later relases will have it enabled).
>>>>>>
>>>>>> The "breakage" seems to be introduced with 15dc0bead10d ("exportd:
>>>>>> Moved cache upcalls routines  into libexport.a"), so
>>>>>> nfs-utils-2-5-3-rc6 as this will mask behind the #ifdef
>>>>>> HAVE_JUNCTION_SUPPORT's code which seems needed to support the refer=
>>>>>> in /etc/exports.
>>>>>>
>>>>>> I had a quick conversation with Cuck offliste about this, and I can
>>>>>> hopefully state with his word, that yes, while nfsref is the direction
>>>>>> we want to go, we do not want to actually disable refer= in
>>>>>> /etc/exports.
>>>>> +1
>>>>>
>>>>>>
>>>>>> Steve, what do you think? I'm not sure on the best patch for this,
>>>>>> maybe reverting the parts masking behind #ifdef HAVE_JUNCTION_SUPPORT
>>>>>> which are touched in 15dc0bead10d would be enough?
>>>>> Yeah there is a lot of change with 15dc0bead10d
>>>>>
>>>>> Let me look into this... At the up coming Bake-a-ton [1]
>>>>
>>>> Thanks a lot for that, looking forward then to a fix which we might
>>>> backport in Debian to the older version as well.
>>>
>>> Hope the Bake-a-ton was productive :)
>>>
>>> Did you had a chance to look at this issue beeing there?
>> Yes I did... and we did talk about the problem.... still looking into it.
> 
> Reviewing the open bugs in Debian I remembered of this one. If you
> have already a POC implementation/bugfix available, would it help if I
> prod at least the two reporters in Debian to test the changes?
> 
> Thanks a lot for your work, it is really appreciated!
I was not able to reproduce this at the Bakeathon
with the latest nfs-utils... and today I took another
look today...

Would mind showing me the step that cause the error
and what is the error?

tia,

steved.





