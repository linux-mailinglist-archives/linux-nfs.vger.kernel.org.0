Return-Path: <linux-nfs+bounces-8308-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA1B9E0CA2
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Dec 2024 20:58:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38F25283966
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Dec 2024 19:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE81E1DD863;
	Mon,  2 Dec 2024 19:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dE0Ww7jl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AD81D63CA
	for <linux-nfs@vger.kernel.org>; Mon,  2 Dec 2024 19:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733169484; cv=none; b=teB7euNsFQhIBQfQ+z0r63ehb909VTMPKTP1nwppw5TUT4m0Xuh1YrWNIQOpOWWnf6um4fTmBiZtHXvjhsngDBYgk4Eef0A3ZJu1Kslqq6ciOOao9q4u/K+NBSmJrX9ajAnNeek41i5cr3QKwYrx0YiWrjZk0YtYd+iHN+weH+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733169484; c=relaxed/simple;
	bh=1rM6+sJ1BwWCjpLlU80RCzTMoup3fVFlRFOh10IrOuM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WB5cfs6OwhLtimHe7cUqQUKBXo8aEQMJ+YmKm06qZ7PASyCrk513ZUmf6+aL2Z2vqsNGelC/gx4n3VmT6s/j8hKm8tcY0+XbvDz+8qjNonoyItPcBdI8VS3d6WUgqQ0EOm/7uErJ+25aQ4BEf+L665Nponu6JdH47C69s9WtSDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dE0Ww7jl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733169481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nkSrjuY6Vphuc83eobPcYaiTKCDKc5ItAAMmMvlZG3s=;
	b=dE0Ww7jl0LrYGXkeA0ihewvgFP6SRw/X/Qi3yptA+ueomL3DcN783mPH8g4hQEBg7Gq9r/
	jt+xXugj5oGKUBTF+FAJJWkvocgj2OZQRkqIXr8bPUuerzzrIAnVnyzaPzBInlVchPU92z
	IS79J2t0EO4KmLp3bh252OXP+wC72HU=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14-3fcu-gPWN0GvzSw6K0X8pQ-1; Mon, 02 Dec 2024 14:57:57 -0500
X-MC-Unique: 3fcu-gPWN0GvzSw6K0X8pQ-1
X-Mimecast-MFC-AGG-ID: 3fcu-gPWN0GvzSw6K0X8pQ
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6d87ee5fb22so66453786d6.1
        for <linux-nfs@vger.kernel.org>; Mon, 02 Dec 2024 11:57:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733169477; x=1733774277;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nkSrjuY6Vphuc83eobPcYaiTKCDKc5ItAAMmMvlZG3s=;
        b=C2AQpGLs6LIXJF4yIKrxg0MOCDedNEfix471oVQBGB95WyrX7GKj0560c/dCTL7vK8
         F6nL1AVvb/S9Hmy+nC2Be/ao0UNKF3KZKazQcWFEHfQLn07QMbxOy4+FNpK1KM3jz4bp
         kCECc6GSOVF8tkUHpkgvhQfB9PCjzxicwPyWj+8Wgany6zi8qtqVeeTq+Mu3jW0MSei7
         GQIV62ksw0ph3sZpBG2CdZO1RwGAbYG4c7PG0gvTgZ1dmXoSLxDBFpEoM3fkG2Ru76cv
         aJQb3O12WqEhK4PDTED6CZEgw9kwUFOeGx6ioQ7JFM/yvCMgNtcMpzXtDJ+x/R6sDECs
         Rrog==
X-Gm-Message-State: AOJu0YyD+wruQ2a16vKUmHqfJWZwlFlLKXSmH5Yv3nUyqvo5UGIvTwBi
	YQ1jS1R2CqEMvYbSImwUrvURvr5p72gpwWLgNcpOo/N607JOYZYCGdNSJrcD4oPuzCrqnfsWG7t
	x9b+5RDlIMF13H32e6S1c6mxqdtS+hsylwroLW5HR9WGWecxTC4ZpJIusvA==
X-Gm-Gg: ASbGncsy5vP0DswpwCGuRlbbogyYiec4ZMSiX2vcILbSlCyH63cqdhJLG1mWKmxcvtw
	Yx9uI9LI06e5fww/cHb5y4UwlY3FU9JHAi/s2HX2zWE9Khbgn8yZFprmOqWqh8UoKwFfdxJRC6B
	u8a0IB+3EeS23cYENyyeQwN8BP8okLHaFkb2nTaE/pXOadwZPLQAfe9vgaLPmXZLmv3GyxaEtsw
	sCW/FlkbW51pYjlcv+lm63as//b3IBju7bmyiMv0vSfjzGQaw==
X-Received: by 2002:a05:6214:21c6:b0:6d8:9124:8799 with SMTP id 6a1803df08f44-6d891248a94mr232791946d6.5.1733169476841;
        Mon, 02 Dec 2024 11:57:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH5vrWAHL0VqZ1gdjNFj+3I4uJ3bwESogActmIgJL0cdW1ONEnhFswBWbK5+aO46KjLmFfquQ==
X-Received: by 2002:a05:6214:21c6:b0:6d8:9124:8799 with SMTP id 6a1803df08f44-6d891248a94mr232791656d6.5.1733169476572;
        Mon, 02 Dec 2024 11:57:56 -0800 (PST)
Received: from [172.31.1.12] ([70.105.249.243])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d88c634940sm36817566d6.130.2024.12.02.11.57.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2024 11:57:55 -0800 (PST)
Message-ID: <328fdce3-a66b-4254-a178-389caf75a685@redhat.com>
Date: Mon, 2 Dec 2024 14:57:54 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: NFSv4 referrals broken when not enabling junction support
To: Salvatore Bonaccorso <carnil@debian.org>,
 Sam Hartman <hartmans@debian.org>, Anton Lundin <glance@ac2.se>
Cc: linux-nfs@vger.kernel.org, Chuck Lever III <chuck.lever@oracle.com>
References: <Zv7NRNXeUtzpfbJg@eldamar.lan>
 <e7341203-c53c-4005-9d70-239073352b2b@redhat.com>
 <ZxUVlpd0Ec5NaWF1@eldamar.lan> <Zxv8GLvNT2sjB2Pn@eldamar.lan>
 <1fc7de18-eaf0-4a1e-bd41-e6072b0f3d7f@redhat.com>
 <Z0VVLw9htR7_C5Bc@elende.valinor.li>
 <e86284ac-7a77-440b-bb5d-bdb1e6f23a40@redhat.com>
 <Z04OnJtb1oDl5sfd@eldamar.lan>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <Z04OnJtb1oDl5sfd@eldamar.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/2/24 2:46 PM, Salvatore Bonaccorso wrote:
> Hi Steve,
> 
> On Mon, Dec 02, 2024 at 01:26:46PM -0500, Steve Dickson wrote:
>>
>>
>> On 11/25/24 11:57 PM, Salvatore Bonaccorso wrote:
>>> Hi Steve,
>>>
>>> On Sat, Oct 26, 2024 at 09:04:01AM -0400, Steve Dickson wrote:
>>>>
>>>>
>>>> On 10/25/24 4:14 PM, Salvatore Bonaccorso wrote:
>>>>> Hi Steve,
>>>>>
>>>>> On Sun, Oct 20, 2024 at 04:37:10PM +0200, Salvatore Bonaccorso wrote:
>>>>>> Hi Steve,
>>>>>>
>>>>>> On Tue, Oct 08, 2024 at 06:12:58AM -0400, Steve Dickson wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 10/3/24 12:58 PM, Salvatore Bonaccorso wrote:
>>>>>>>> Hi Steve, hi linux-nfs people,
>>>>>>>>
>>>>>>>> it got reported twice in Debian that  NFSv4 referrals are broken when
>>>>>>>> junction support is disabled. The two reports are at:
>>>>>>>>
>>>>>>>> https://bugs.debian.org/1035908
>>>>>>>> https://bugs.debian.org/1083098
>>>>>>>>
>>>>>>>> While arguably having junction support seems to be the preferred
>>>>>>>> option, the bug (or maybe unintended behaviour) arises when junction
>>>>>>>> support is not enabled (this for instance is the case in the Debian
>>>>>>>> stable/bookworm version, as we cannot simply do such changes in a
>>>>>>>> stable release; note later relases will have it enabled).
>>>>>>>>
>>>>>>>> The "breakage" seems to be introduced with 15dc0bead10d ("exportd:
>>>>>>>> Moved cache upcalls routines  into libexport.a"), so
>>>>>>>> nfs-utils-2-5-3-rc6 as this will mask behind the #ifdef
>>>>>>>> HAVE_JUNCTION_SUPPORT's code which seems needed to support the refer=
>>>>>>>> in /etc/exports.
>>>>>>>>
>>>>>>>> I had a quick conversation with Cuck offliste about this, and I can
>>>>>>>> hopefully state with his word, that yes, while nfsref is the direction
>>>>>>>> we want to go, we do not want to actually disable refer= in
>>>>>>>> /etc/exports.
>>>>>>> +1
>>>>>>>
>>>>>>>>
>>>>>>>> Steve, what do you think? I'm not sure on the best patch for this,
>>>>>>>> maybe reverting the parts masking behind #ifdef HAVE_JUNCTION_SUPPORT
>>>>>>>> which are touched in 15dc0bead10d would be enough?
>>>>>>> Yeah there is a lot of change with 15dc0bead10d
>>>>>>>
>>>>>>> Let me look into this... At the up coming Bake-a-ton [1]
>>>>>>
>>>>>> Thanks a lot for that, looking forward then to a fix which we might
>>>>>> backport in Debian to the older version as well.
>>>>>
>>>>> Hope the Bake-a-ton was productive :)
>>>>>
>>>>> Did you had a chance to look at this issue beeing there?
>>>> Yes I did... and we did talk about the problem.... still looking into it.
>>>
>>> Reviewing the open bugs in Debian I remembered of this one. If you
>>> have already a POC implementation/bugfix available, would it help if I
>>> prod at least the two reporters in Debian to test the changes?
>>>
>>> Thanks a lot for your work, it is really appreciated!
>> I was not able to reproduce this at the Bakeathon
>> with the latest nfs-utils... and today I took another
>> look today...
>>
>> Would mind showing me the step that cause the error
>> and what is the error?
> 
> Let me ask the two reporters in Debian, Cc'ed.
> 
> Sam, Anton can you provide here how to reproduce the issue with
> nfs-utils which you reported?
> 
Please note setting "enable-junction=no" does disable
the referral code. aka in dump_to_cache()

#ifdef HAVE_JUNCTION_SUPPORT
         write_fsloc(&bp, &blen, exp);
#endif

So unless I'm not understanding something (which is very possible :-) )
disabling junctions also disables referrals.

steved.

> Context:
> - https://bugs.debian.org/1035908
> - https://bugs.debian.org/1083098
> 
> Regards,
> Salvatore
> 


