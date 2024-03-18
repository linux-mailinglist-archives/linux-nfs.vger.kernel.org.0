Return-Path: <linux-nfs+bounces-2378-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 415F887F13B
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Mar 2024 21:36:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6BB0B22F27
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Mar 2024 20:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7279A5810B;
	Mon, 18 Mar 2024 20:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UlO/dyut"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D3A52F98
	for <linux-nfs@vger.kernel.org>; Mon, 18 Mar 2024 20:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710794165; cv=none; b=RdNyIwxdgOVd5/O1Xe4sEpLnYPJl7wFiLuQwACieNCEVUNLTrddTRG8hZUc2wsjsmnAFeYlrBNcKPKIm5U9dlt8h3iV/H6l7N1/lRUVvn9w1RjifL1Ipj1VY8w9vmtuClVlgEieZu2FwiBtMBDpTJiJQyjz7hxDCS3KSIP7S5JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710794165; c=relaxed/simple;
	bh=NW7QtAas/bpNRU/eCT4YWiCycIfHrdks8iwb9nV6qIo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XOIjpUaStF0agszPdmBJU5BHYMCdLNJhXqgGM5YlKgNZziJlBY2TCEIXq9MVuWpC/cT7rMl8K3/UMjdy8oYzDIXyL0/oI3floGFC++WnkfOzgkda+Mh4G11dpCnSybN+3WEDoQdLDo+uEmWI03Y3LmEyuKJWWHJiz5KCZJ4tttU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UlO/dyut; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710794159;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yH6pAHtYtpeyDicyAL/QCAqskID5PH41fK5Rdgn3Rd4=;
	b=UlO/dyutjQuzc8copZ3QbKCFv/tI5eDXOUwVrdoChCxWlXPYPmRBjucF89McIfw7RbXhIK
	dhfEmjeNcsLc7pPgTMj3dcvlHjUAhDkibtl4q2Aym6pr26JUbo9SjUHuHEg54TSFv8YI9F
	qB2fxPYiQlRdCWNrS0tQERU9+8gFls0=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-CTR2ykFCOzacbZCohw6LRQ-1; Mon, 18 Mar 2024 16:35:58 -0400
X-MC-Unique: CTR2ykFCOzacbZCohw6LRQ-1
Received: by mail-yb1-f199.google.com with SMTP id 3f1490d57ef6-dc25481a6b7so330485276.1
        for <linux-nfs@vger.kernel.org>; Mon, 18 Mar 2024 13:35:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710794157; x=1711398957;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yH6pAHtYtpeyDicyAL/QCAqskID5PH41fK5Rdgn3Rd4=;
        b=d2SvHIf67FbwnPjCWicVxpme6Cm05ZARzcvxENpf2lIO9Ru4jijh5znCucNZQIbMg8
         OYEPUlewixMx0i+ouCPewfG93MCFWZsgdk5N3NKcZKIZy580sWLixF9ObvCPZsiCK6j2
         m3qGnX9a0P44w7IzrVf8Gnl8rCt8cJPLUmXXAl9UTWe1Lvd3+5LrqDpq5lvsD4pm/d6O
         FBH6nSQnJRhPGr26eOGsEWh8po6ZBHRYnOYmO4Wm94uFQnnAVbag0jsU+Wl4ek72RYHW
         Z5nqammV+PdikIxn8+cfO+7wC5SiTIxCNFf4YM1INDwOUDZYBnbXZGSzQ6+aZvF1P9wv
         6scQ==
X-Gm-Message-State: AOJu0YxF+mHCupxHx1alKAix5Tqdj5Obm5MTdiuwknKCKZK6yKbxpmep
	kcBlrnB+dcxyatMRB+MC3BUs3AukS4Vb2qOHPa/s2XaLs5RjwsEuIuB2PXUssNuxLso2MV5UGVR
	r1JQSRdCeQ4SstIoE69halDofqm8CwD2WfxO5y7RXtwaBK6e1Klr2SmtT+g==
X-Received: by 2002:a25:3155:0:b0:dc7:45fd:b454 with SMTP id x82-20020a253155000000b00dc745fdb454mr2224278ybx.1.1710794157255;
        Mon, 18 Mar 2024 13:35:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE61EY+M+qRiNZFuh0YAn6bX4YE35/YIfVYFIPX+KKrvy9u1Sue7pmj/7K/jhwjKDqU6GM9wQ==
X-Received: by 2002:a25:3155:0:b0:dc7:45fd:b454 with SMTP id x82-20020a253155000000b00dc745fdb454mr2224263ybx.1.1710794156778;
        Mon, 18 Mar 2024 13:35:56 -0700 (PDT)
Received: from [172.31.1.12] ([70.105.251.209])
        by smtp.gmail.com with ESMTPSA id hg1-20020a05622a610100b00430b5dcac34sm3781981qtb.8.2024.03.18.13.35.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 13:35:56 -0700 (PDT)
Message-ID: <194e429f-0c73-4e6b-ae53-795406849669@redhat.com>
Date: Mon, 18 Mar 2024 16:35:54 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4 rpcbind] Supprt abstract addresses and disable
 broadcast
To: NeilBrown <neilb@suse.de>
Cc: linux-nfs@vger.kernel.org, Petr Vorel <pvorel@suse.cz>
References: <20240225235628.12473-1-neilb@suse.de>
 <b4b4d325-f15f-4fb3-a52c-c3f39d56018a@redhat.com>
 <171012164367.13576.5737075738433892235@noble.neil.brown.name>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <171012164367.13576.5737075738433892235@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/10/24 9:47 PM, NeilBrown wrote:
> On Tue, 05 Mar 2024, Steve Dickson wrote:
>> Hey Neil,
>>
>> My apologies on addressing this...
>> Too much PTO :-)
>>
>> On 2/25/24 6:53 PM, NeilBrown wrote:
>>> The first two patches here I wrote some years ago but never posted - sorry.
>>> The third and fourth allow rpcbind to work with an abstract AF_UNIX
>>> address as preferentially used by recent kernels.
>>>
>>> NeilBrown
>>>
>>>
>>>    [PATCH 1/4] manpage: describe use of extra port for broadcast rpc
>>>    [PATCH 2/4] rpcbind: allow broadcast RPC to be disabled.
>> You realize that the broadcast code is configured out by default
>> ./configure  --help | grep rmt
>>     --enable-rmtcalls       Enables Remote Calls [default=no]
>>
>> So do we want to introduce a flag and man page section
>> for something that is off by default?
>>
> 
> Hmmm.... I guess I didn't know that when I wrote the patch - or forgot.
> 
> I wrote the patch a few years ago and found it when I was doing the
> abstract address stuff and though I better submit it.  I was wrong.
> 
> Please just ignore those first two patches.
Ignored... the last two patches were committed (tag: rpcbind-1_2_7-rc3)

steved.

> 
> Thanks,
> NeilBrown
> 


