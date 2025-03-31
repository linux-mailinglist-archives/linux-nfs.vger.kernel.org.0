Return-Path: <linux-nfs+bounces-10965-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0796A76B68
	for <lists+linux-nfs@lfdr.de>; Mon, 31 Mar 2025 17:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A6731883CCB
	for <lists+linux-nfs@lfdr.de>; Mon, 31 Mar 2025 15:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9CBA2144A6;
	Mon, 31 Mar 2025 15:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GzqhJsjX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23184211A0D
	for <linux-nfs@vger.kernel.org>; Mon, 31 Mar 2025 15:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743436669; cv=none; b=TNxloOKZG+4gshUjt+unMYeKxkWSiMjp5JYGFhbTXRyirrCakitxN9kwN1amtlAI/GbyL5UA1j5Unn3HqwDXSCu/+gC/v/1YHjfrIknVnlUCWgQWiMj4OwFcIw4bAvdFkm9LTYoDIzm6K8V/qrsN0DmEbxPhqz5lt1lRJkzEwzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743436669; c=relaxed/simple;
	bh=T4ZXoS4+z+X59eVjgvFMxhCV0fHswDRnLNk16rznrx8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tkn/pJoae2izzwlVDNhXBCYINO9rFpWoi/VvVIgAfPCtmr5S8St+MERQ711k0ILJcHkvEzDgL7466RlPrbYB5uJeiP5VTITSs38I7VSFWYuG8pYVAscQgcHiXT41n6jPG2s6v0Q6pEPeNOKaYXaT7gFzSBk/juDy4JnuzVMtEdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GzqhJsjX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743436666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ARQvl6eb5G/d0Q5+QAgY0Ic2dtUK7SZy2q5rXofgMwk=;
	b=GzqhJsjXMDXN80+rkxpusapiPFrObSybJl8wu3mRm9SENthzz4wEiCYrCdr50+k7JLVvmm
	HudJwRCBRDBstfjTnRGoRhXH4LlHTLdMjeod9zDGVZLMAeH2TiywpEb2T2lCVw023NNIee
	VXnkZOgy8iurI9/kCBmnERJt29TliR4=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-m3ajCmVxPcWIqehoRaT3AQ-1; Mon, 31 Mar 2025 11:57:44 -0400
X-MC-Unique: m3ajCmVxPcWIqehoRaT3AQ-1
X-Mimecast-MFC-AGG-ID: m3ajCmVxPcWIqehoRaT3AQ_1743436664
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c543ab40d3so696797885a.2
        for <linux-nfs@vger.kernel.org>; Mon, 31 Mar 2025 08:57:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743436664; x=1744041464;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ARQvl6eb5G/d0Q5+QAgY0Ic2dtUK7SZy2q5rXofgMwk=;
        b=wm5rOKtki+yoUBzir2zZ3S/bPA4Ah2nI1bD7PG4ADDrsr1wosFsvNIHryyS84kTe/H
         mMzVe4BpEv35LhYYNi6h4qBon7KaLEhfCRkS4DbONCeHclAbnxBxhZJ+L8UmTtUHY7OH
         SEj8gz+dWYbn1ODX9kS4iR+6RGcbaYfHolOJJUq7P3b/3l+8z6KNM3i5XTDVbXtdFC8U
         Xr3nke9rvKLYmVQ+SlSxWtufcTFX3OnBrtHmt19jRanoDgEnqSWVdnYXlrZseZWw4zVN
         U4+AB6iURT2suVGfzGOnUOCZLLE0231mAXWmt0cvDt9/rLYNVBkbKQNzX9QATfK57xGB
         G+Cg==
X-Gm-Message-State: AOJu0YyduKy3v8DvfUZ6mVw7uKLr5eUEb27ZdhiSnrO8IdpNwSJgmLt0
	jy3nhsMwmLSQ98wtCV4cwlniJAgiKdCwsBjywtRXGcgDIFgu5M5ouElu1B8pXu7lhmF5eMZC1bJ
	r8L/8DN8GHUr1xa5Qs5iB2d96+3RpkWryVfYUwuaZ/uv/XZVmgE0hxtiUwA==
X-Gm-Gg: ASbGncteAKjw52/3m3px5AapB4bPd82Sit3+4cFrIrzltg9wFRHx4CR3W42Zwrh/sAQ
	k7QSRXkWC+fiCxaQt1Ck7MNiwk9CV7atrCXiuoBbbbkMTeODyCrvAUBM68qBPWdnNQIEyeGqnJA
	vDhsNFDi3XA2TAC6jPTz2uiLjj1aOi+TkF7lQiktoZLS2KbVbZUPFgR3Tc+3sKzm7X0QpCQYwwr
	TrAZaHIjRobqDJxtUm9CjYpB+Ar695W7Jo1O/7TfEkiLtLH/W9JdwmSA7j6x36vBlGyoUCNprbk
	EBtF8fyf+kluhT4xGQ==
X-Received: by 2002:a05:620a:2681:b0:7c5:59e1:f0d with SMTP id af79cd13be357-7c69087dd1emr1110561785a.39.1743436664161;
        Mon, 31 Mar 2025 08:57:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJkfzA2bgSBj5bMXVb5RPFZXUDrOzGE+hxX2ryFfa0NqKfabKeiu4FaR4V0+jp9Wn/Rz6pdw==
X-Received: by 2002:a05:620a:2681:b0:7c5:59e1:f0d with SMTP id af79cd13be357-7c69087dd1emr1110558385a.39.1743436663831;
        Mon, 31 Mar 2025 08:57:43 -0700 (PDT)
Received: from [10.193.213.71] ([144.121.52.163])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5f768227asm514285285a.31.2025.03.31.08.57.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Mar 2025 08:57:43 -0700 (PDT)
Message-ID: <5393a1f8-898e-4e1d-b516-7d0070086655@redhat.com>
Date: Mon, 31 Mar 2025 11:57:42 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ANNOUNCE: nfs-utils-2.8.3 released.
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: Linux NFS Mailing list <linux-nfs@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <64a11de6-ca85-40ce-9235-954890b3a483@redhat.com>
 <Z-oRa3cF97JCGkVo@lorien.valinor.li>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <Z-oRa3cF97JCGkVo@lorien.valinor.li>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/30/25 11:52 PM, Salvatore Bonaccorso wrote:
> Hi Steve,
> 
> On Sun, Mar 30, 2025 at 03:37:33PM -0400, Steve Dickson wrote:
>> Hello,
>>
>> The release has a number changes in time for
>> the upcoming Spring Bakeathon (May 12-16):
>>
>>      * A number of man pages updates
>>      * Bug fixes for nfscld and gssd
>>      * New argument to nfsdctl as well as some bug fixes
>>      * Bug fixes to mountstats and nfsiostat
>>      * Updates to rpcctl
>>
>> As well as miscellaneous other bug fixes see
>> the Changelog for details.
>>
>> The tarballs can be found in
>>    https://www.kernel.org/pub/linux/utils/nfs-utils/2.8.3/
>> or
>>    http://sourceforge.net/projects/nfs/files/nfs-utils/2.8.3
>>
>> The change log is in
>>     https://www.kernel.org/pub/linux/utils/nfs-utils/2.8.3/2.8.3-Changelog
>> or
>>   http://sourceforge.net/projects/nfs/files/nfs-utils/2.8.2/2.8.3-Changelog
>>
>>
>> The git tree is at:
>>     git://linux-nfs.org/~steved/nfs-utils
>>
>> Please send comments/bugs to linux-nfs@vger.kernel.org
> 
> Thansk for this new release!
> 
> Noticed that the nfs-utils-2-8-3 and release commit is not yet in
> https://git.linux-nfs.org/?p=steved/nfs-utils.git . Could you push
> those as well?
Done!! My bad... sorry about that... Can you say brain fart :-)

steved.
> 
> Regards,
> Salvatore
> 


