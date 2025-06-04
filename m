Return-Path: <linux-nfs+bounces-12113-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D47D4ACE558
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Jun 2025 21:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19BCF1894576
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Jun 2025 19:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0891F418E;
	Wed,  4 Jun 2025 19:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ifPOv1Sb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62E5111BF
	for <linux-nfs@vger.kernel.org>; Wed,  4 Jun 2025 19:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749066803; cv=none; b=VH3+qA0uR2B98FoWnZwWSDO1iD8wPR04WzbW5cWwlxvjj5Dow2fHE7K2sxBcvn0h4uMty3xBgSnRf3LALSDwuj+QdVPxdsIv4mZFtfv2X63MCWOjtaLss0Cq4zmea6P2DcNBsvmzcKD2h6AfV/vAEJpzkYskwTzVsHzL0apLStw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749066803; c=relaxed/simple;
	bh=O9j+HVQVhuRbfYAEb3aB8SCEOeX6uNiChLFY1pY8JJk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m8gL/QKwcpruBEyJ/o0/7i99scpZaNssRCgnWszUdbv6kTlQgCL4b42VI5OXd53EBqGyth/GdS3qTnlt/s1FtM2icutG55yrEBlawCH6e31/V6QLN5BvDAPMTCtq4fsHdXNtnrHvfEm0cdNWf6EGItyR3O4X7gwZL0jhgHbJ3uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ifPOv1Sb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749066799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sNCAZauu0KVtFcF/gfYr86cnT/PYJ4bje9pvuDsXSlY=;
	b=ifPOv1SbdlmPBpcnU4MS09AEwjRofDRGQCd9BPd9M5NMQNcIS6JiPyZn+KGxg814JQ2p24
	9e7YcXKMGFrd3rDA/NljUlIPR8maEVpGOGjUTy4n8P6k4wchCn+yj8hTHFz2ah7bNKTjhS
	Z/rOupKoNEpV45POE8NbevwamArZu10=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-X5Cc80pTPoCsUN86U2xbYg-1; Wed, 04 Jun 2025 15:53:18 -0400
X-MC-Unique: X5Cc80pTPoCsUN86U2xbYg-1
X-Mimecast-MFC-AGG-ID: X5Cc80pTPoCsUN86U2xbYg_1749066798
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7d09bc05b77so36929885a.1
        for <linux-nfs@vger.kernel.org>; Wed, 04 Jun 2025 12:53:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749066798; x=1749671598;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sNCAZauu0KVtFcF/gfYr86cnT/PYJ4bje9pvuDsXSlY=;
        b=wkBvSNaRNExuhkFQZFUfWLNRywSrxTheUtlbj68lqt/V9ZAq8hnlpaRApyk5K+L+XL
         x7gM3HaWWb9eKbqs8JWM9pe6QiYyisH8Nyq9lpvc7r2jVDGDjLzvIIL5HQyYuu47z4Hy
         NXdUnYZ14KJ1f4WWMIdUeBz2Vp2ccPMpZpB7C6rRR1pF/CBhiOXDLmzxfmsmfH5Mv5D7
         CatihzqDjD5d1yXx+s1dlgBNOw1A9M5TmtDBM9x0/fjTZiLl1SVaeN77ZgPsBjAznyL4
         /bZVPMk2BfuP+OhK/6gRRnobnzFMx2JaLx2vC29y7HUXGdL6VyLKujxaPbmOqWt8i7hG
         b5TA==
X-Forwarded-Encrypted: i=1; AJvYcCV6euXr2CqOvfY0GgbOv10D0TWrm3dmza1yRUdhRhhlraIM1HqkJI5bwHJMXfogSmB3vJIqoiiGFsg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBk90cJ6RKODE+fans7urBFUp1fx/pAbXRaKPcVvf9zd9acpBe
	7RBlB21T6YPaE9n/84eyPq1RULaLJDbgBYsSdk8r/uyBlIQWt0JEG5PBh1I53TvZ/a66AZy5Iir
	xCwMrH/LOPfCCtiqZfNJ2tH4Fi7oKczXjbo/0jXhuw1vbWS/B0kBL7pBe1vfE1A==
X-Gm-Gg: ASbGncv3iDmSjFb0GNK0RmE6jPauydAhW2npUnhERxIkEV7G6A884FfG2gPYisOSwvk
	uGLZvPVd58qqbd6jnH1dFVu9GVlBr1MUSglXsCSc634516GRZ/uA2fN9+BFzaZDz2DAkfsvx2GF
	O+4VC2g35+1ZjKlJkdiDvMCjPTQFfSs2B4s/UbAn4UCtGGTmAZFMyY+wzEYjNP2IL9JpwWfsooc
	1SS7f42TSG/Hi3tYrhgucjSCjgvPmy/Cs2IXwiX8hvBw9sbBqmjGKiwVQYfU4o7tB57zQKdHKK8
	W1sScNsZQV0=
X-Received: by 2002:a05:620a:3915:b0:7cc:aedc:d0c1 with SMTP id af79cd13be357-7d219869714mr697760285a.5.1749066798068;
        Wed, 04 Jun 2025 12:53:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4RjIlKvAfNRc7xO2rj6txxsqyBwhBC7+Q4ArGz1lRR64vv4bTqhbxgyQUlKbUFkWEPJIz/A==
X-Received: by 2002:a05:620a:3915:b0:7cc:aedc:d0c1 with SMTP id af79cd13be357-7d219869714mr697757385a.5.1749066797701;
        Wed, 04 Jun 2025 12:53:17 -0700 (PDT)
Received: from [172.31.1.12] ([70.105.242.209])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d09a0e5c3asm1075310785a.22.2025.06.04.12.53.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jun 2025 12:53:16 -0700 (PDT)
Message-ID: <e6dbb6be-4e58-4d94-8912-05a5eee87ada@redhat.com>
Date: Wed, 4 Jun 2025 15:53:15 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH nfs-utils] exportfs: make "insecure" the default for all
 exports
To: Jeff Layton <jlayton@kernel.org>
Cc: Tom Haynes <loghyr@gmail.com>, linux-nfs@vger.kernel.org
References: <20250513-master-v1-1-e845fe412715@kernel.org>
 <7bbb789d-b3ae-4258-bebf-40ed87587576@redhat.com>
 <16285c94bc3498fb7a612f62e718ae8a53c42c3c.camel@kernel.org>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <16285c94bc3498fb7a612f62e718ae8a53c42c3c.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/4/25 3:17 PM, Jeff Layton wrote:
> On Wed, 2025-06-04 at 14:26 -0400, Steve Dickson wrote:
>> Hello all,
>>
>> On 5/13/25 9:50 AM, Jeff Layton wrote:
>>> Back in the 80's someone thought it was a good idea to carve out a set
>>> of ports that only privileged users could use. When NFS was originally
>>> conceived, Sun made its server require that clients use low ports.
>>> Since Linux was following suit with Sun in those days, exportfs has
>>> always defaulted to requiring connections from low ports.
>>>
>>> These days, anyone can be root on their laptop, so limiting connections
>>> to low source ports is of little value.
>>>
>>> Make the default be "insecure" when creating exports.
>>>
>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>> ---
>>> In discussion at the Bake-a-thon, we decided to just go for making
>>> "insecure" the default for all exports.
>>> ---
>>>    support/nfs/exports.c      | 7 +++++--
>>>    utils/exportfs/exports.man | 4 ++--
>>>    2 files changed, 7 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/support/nfs/exports.c b/support/nfs/exports.c
>>> index 21ec6486ba3d3945df0800972ba1dfd03bd65375..69f8ca8b5e2ed50b837ef287ca0685af3e70ed0b 100644
>>> --- a/support/nfs/exports.c
>>> +++ b/support/nfs/exports.c
>>> @@ -34,8 +34,11 @@
>>>    #include "reexport.h"
>>>    #include "nfsd_path.h"
>>>    
>>> -#define EXPORT_DEFAULT_FLAGS	\
>>> -  (NFSEXP_READONLY|NFSEXP_ROOTSQUASH|NFSEXP_GATHERED_WRITES|NFSEXP_NOSUBTREECHECK)
>>> +#define EXPORT_DEFAULT_FLAGS	(NFSEXP_READONLY |	\
>>> +				 NFSEXP_ROOTSQUASH |	\
>>> +				 NFSEXP_GATHERED_WRITES |\
>>> +				 NFSEXP_NOSUBTREECHECK | \
>>> +				 NFSEXP_INSECURE_PORT)
>>>    
>>>    struct flav_info flav_map[] = {
>>>    	{ "krb5",	RPC_AUTH_GSS_KRB5,	1},
>>> diff --git a/utils/exportfs/exports.man b/utils/exportfs/exports.man
>>> index 39dc30fb8290213990ca7a14b1b3971140b0d120..0b62bb3a82b0e74bc2a7eb84301c4ec97b14d003 100644
>>> --- a/utils/exportfs/exports.man
>>> +++ b/utils/exportfs/exports.man
>>> @@ -180,8 +180,8 @@ understands the following export options:
>>>    .TP
>>>    .IR secure
>>>    This option requires that requests not using gss originate on an
>>> -Internet port less than IPPORT_RESERVED (1024). This option is on by default.
>>> -To turn it off, specify
>>> +Internet port less than IPPORT_RESERVED (1024). This option is off by default
>>> +but can be explicitly disabled by specifying
>>>    .IR insecure .
>>>    (NOTE: older kernels (before upstream kernel version 4.17) enforced this
>>>    requirement on gss requests as well.)
>>>
>>> ---
>>> base-commit: 2cf015ea4312f37598efe9733fef3232ab67f784
>>> change-id: 20250513-master-89974087bb04
>>>
>>> Best regards,
>> My apologies but I got a bit lost in the fairly large thread
>> What as is consensus on this patch? Thumbs up or down.
>> Will there be a V2?
>>
>> I'm wondering what type documentation impact this would
>> have on all docs out there that say one has to be root
>> to do the mount.
>>
>> I guess I'm not against the patch but as Neil pointed
>> out making things insecure is a different direction
>> that the rest of the world is going.
>>
>> my two cents,
>>
>>
> 
> Thumbs down for now. Neil argued for a more measured approach to
> changing this.
> 
> I started work on a manpage patch for exports(5) but it's not quite
> ready yet. I also want to look at converting some manpages to asciidoc
> as we go, to make future updates easier.
Sounds like a plan... Thanks!

steved.



