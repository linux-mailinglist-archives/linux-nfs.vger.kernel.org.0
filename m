Return-Path: <linux-nfs+bounces-7612-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B22E39B894C
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Nov 2024 03:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65A4A1F22A59
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Nov 2024 02:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3492F132106;
	Fri,  1 Nov 2024 02:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KWTxKE/W"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4236313777E
	for <linux-nfs@vger.kernel.org>; Fri,  1 Nov 2024 02:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730428039; cv=none; b=gES4xKk5/M30cTR1gXW90SzDzRgn6woOyzAR9Ce1tLBK08ojTUxG8HSNGfgGbhi9CZIlGRCsSfG4qucl+ReSAoyJ2V896o0x6C+9kA/RIVNoZS0DZ1VPlTpbST0XAPICCVXT1BYiLD3mdnEr3LaHPVPRZZvLnbkYuuqwERUoCes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730428039; c=relaxed/simple;
	bh=FFtDTXxxJDzHqttt3yo2hJcxZXvP++ooiYm3ozZMzX0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IGk+uWjjfKnQF+JYbgWH1msDSOoN43kQcC09zRw5KK24yEJHqSUtsi5nSPFYCRMifKqql6ko5We2eDRCQZ+kM+PeLvLQTu2d4Bdk3qplSn+2aOkmdsyxHw4onZEGTnjrFDHCErW4YDqWGij5Ik2nWoPge2JrHgZN82ebI5knFWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KWTxKE/W; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730428032;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AuIeR0CURUIdPc8dB8c06x52sP5yO/gx5bYj9nXTypU=;
	b=KWTxKE/Wz6ksHF6kapz1SXA+/uSCGYgrTR6zR5dSj94/+Ew60yl/icrqYLn7PKqf/ywc0U
	Pb3WNJO1nU4piqnPXF0sdmeReATtblmJCeqw9LbI7QKwQrEYeBKOfnDBIEPvJMiEJ5n52D
	h8ZzUEk8z1zHGQQSMVfy/xYgSXA/l/w=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-DbNBHeekNgam3E3-OQVjyw-1; Thu, 31 Oct 2024 22:27:09 -0400
X-MC-Unique: DbNBHeekNgam3E3-OQVjyw-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7b14a4e771fso244569885a.3
        for <linux-nfs@vger.kernel.org>; Thu, 31 Oct 2024 19:27:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730428027; x=1731032827;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AuIeR0CURUIdPc8dB8c06x52sP5yO/gx5bYj9nXTypU=;
        b=m2Dv7Z41Eo8ewiXmF76XMyMeYlvdhLQhD6RTE1k1xONRwXOAZmx/FD5rpHLKoki9YH
         wdcXvDnyO0LrQ2fSbZga8BJQqB/DX/DfKVTzUwoG9gYNDIjvrX0s8zPE+RR0Fju4uoRh
         baQuVxb+q1jPwdcgYdfQrcj/IhpfmzW/DRjleZGAtKt3RZ0PXwwj4g5IgLUoTwf+WL9E
         6srLKkxyIcS0rAHjQdLMqmZ9Slz2/RLkPerzzSwe0cn21HCjaVAjjdrBbKEW8l7mA2Gx
         +hizgD78pLhBR8OJ36nmO9V2LSLS9w5HTKxveVNe7aCxDCERfdp3cA6PkggHvk0q2D3T
         iWOA==
X-Gm-Message-State: AOJu0YzJmHm1MzpkEtFZvKIpUMiQinkhSL9sTseDOQ6/D94nIWlJxr3R
	EiLkkVdg/PdLeevAS4sdnipq4eewU1LrXXdQkR1VJcHd9OHIpsTsOzcNBjCgjApAoM7NpJo6wNR
	zeawThTzJHnI1/R2ZkgG+a4TCm8tKgVb9qYJMpe5IQS8gNNKyykk1uyh20ueKTUk2qA==
X-Received: by 2002:a05:620a:178d:b0:7ae:64a2:be61 with SMTP id af79cd13be357-7b193eff6a3mr3168187985a.36.1730428027415;
        Thu, 31 Oct 2024 19:27:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHN1lheMnxCXm9T4vAwhN8smffBTdKLBI6+ZDXmriVpMGkSThtagc4XYB7aImtt0MEeqC8dAg==
X-Received: by 2002:a05:620a:178d:b0:7ae:64a2:be61 with SMTP id af79cd13be357-7b193eff6a3mr3168186885a.36.1730428027088;
        Thu, 31 Oct 2024 19:27:07 -0700 (PDT)
Received: from [172.31.1.136] ([70.105.251.7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b2f3a7139fsm127973185a.76.2024.10.31.19.27.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 19:27:04 -0700 (PDT)
Message-ID: <9ef76fc7-e575-4229-867a-a6a56efabaec@redhat.com>
Date: Thu, 31 Oct 2024 22:27:02 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ANNOUNCE: libtirpc-1.2.6 released.
To: Petr Vorel <pvorel@suse.cz>,
 libtirpc <libtirpc-devel@lists.sourceforge.net>
Cc: linux-nfs@vger.kernel.org
References: <91ef3508-d0a6-48db-adfc-4f7831fba74e@redhat.com>
 <91ef3508-d0a6-48db-adfc-4f7831fba74e@redhat.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <91ef3508-d0a6-48db-adfc-4f7831fba74e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/29/24 7:20 AM, Petr Vorel wrote:
> From: Steve Dickson <steved@redhat.com>
> 
> Hi Steve,
> 
>> Hello,
>>
>> The 1.2.6 version of libtirpc has just been release.
> 
> I suppose this should be 1.3.6.
Yes.. My bad... Re-using old email... Sorry about that!

> 
>>
>> Minor release... a couple rpcbind config changes and
>> a few configuration changes for macOS.
>>
>> The tarball:
>> http://sourceforge.net/projects/libtirpc/files/libtirpc/1.2.6/ 
>> libtirpc-1.2.6.tar.bz2
> 
> https://sourceforge.net/projects/libtirpc/files/libtirpc/1.3.6/ 
> libtirpc-1.3.6.tar.bz2
True!

> 
>>
>> Release notes:
>> http://sourceforge.net/projects/libtirpc/files/libtirpc/1.2.6/ 
>> Release-1.2.6.txt
> 
> Could you please delete Release-1.2.6.txt
> https://sourceforge.net/projects/libtirpc/files/libtirpc/1.3.6/ 
> Release-1.2.6.txt
> 
> and upload:
> http://sourceforge.net/projects/libtirpc/files/libtirpc/1.3.6/ 
> Release-1.3.6.txt
Thanks for point this out...

steved.
> 
> Kind regards,
> Petr
> 
>>
>> The git tree is at:
>>     git://linux-nfs.org/~steved/libtirpc
>>
>>
>> steved.
>>
>>
> 


