Return-Path: <linux-nfs+bounces-10627-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61CA7A62EF4
	for <lists+linux-nfs@lfdr.de>; Sat, 15 Mar 2025 16:17:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4E8817A5C5
	for <lists+linux-nfs@lfdr.de>; Sat, 15 Mar 2025 15:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9C017995E;
	Sat, 15 Mar 2025 15:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IZx14UYB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71CF16EB54
	for <linux-nfs@vger.kernel.org>; Sat, 15 Mar 2025 15:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742051857; cv=none; b=B7wJGAANiODkLb4Vy8LjzEu8hhhC9VA+xPWuTIXOm2mp6G0x++HCYaEnhs9GG5XpNE/5XScVYTlYEDm/9hNcjGs5Uh9+wkHJuoYyeiGT6grPJHkxY1xOf4Ox3XtZ6yNMNkONBCxzfQX8CR9kfIe5Sv5+kZk47w2yxjmigwi9eSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742051857; c=relaxed/simple;
	bh=JO+fXQ5STYyFiQBNteIU35gZiaQX91IBsfHJ6154rPc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GNqwUcF3E2DczsgktJGqM6cXP1pgA0OFm8lnXBPD2TT41xSNI+QXxJYFkwqVHfUWS4vMtDMGown1DnbMpZaua7v025Bc32xbFGJHKMP6HuKgewhhaSusxn/JvU2mGcGJW8xNdFSCHQRgYFv1Tz+0NlZIxw86CmLKXkQGKwctQBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IZx14UYB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742051853;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WTPzozSkUruypuJ47N+7+cAyIZWWwW0puQ6AfqR994w=;
	b=IZx14UYBSJpTiVo2632HjJiuMX2eybmidzqw3ZEqriU2qqa6UQztW6BKYusfZqZaQ+X6JK
	blJhYOd9hUQHxe8aSZpjeeLwN8jfvUd+to+dYiB5SZI5sOPYivzQ2ANbrwC5Ik83rFyZvZ
	fJXKMbXh9KY9SYD8a6CBOwCYaaXS5ZI=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-161-H18_QdN3NsOuFl9R9JG_aA-1; Sat, 15 Mar 2025 11:17:32 -0400
X-MC-Unique: H18_QdN3NsOuFl9R9JG_aA-1
X-Mimecast-MFC-AGG-ID: H18_QdN3NsOuFl9R9JG_aA_1742051851
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4769a1db721so79867291cf.3
        for <linux-nfs@vger.kernel.org>; Sat, 15 Mar 2025 08:17:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742051851; x=1742656651;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WTPzozSkUruypuJ47N+7+cAyIZWWwW0puQ6AfqR994w=;
        b=VELNgZZjADYzVhM2L8bUjcpOa6/5qGicr0dvH+XOu/EO+ANnynEOy19en21uiPn7HA
         qqnbQYfDmSlNrGQPj3hdgUM9RtrxAqZyfOPdVgAa1h9lYlwMMf2QdOxHQmyfWZLeBD7L
         MJC/bOy6HWEOtW9Vew0OMeErsEwLDsDDuzG7siaCmVueozu3VX6gpRskoTTybsCZ7eVG
         3GWlpZDSyDUvNsQsZk2hJFzXr0ElT2VAe+sqwfNG2xc/dQQS5jLNvC4BcKzB6ot1mhyX
         fXxgKccXNafXLRq3oGpj/z2qWXXvdk8GjhBHIzL83ERC6s/BCes2hSRiO4T3uETfrH9r
         OU+g==
X-Gm-Message-State: AOJu0YzIJ5lYN1mQTP/Pi9vthshxuLPIZenPN/NIHcu9EKMkTiw9EY2Z
	3vNZwPW5S39H4EBJu+QV5wf5bH5RN4UH6g9b9e7xbygDpDc+kzFP/m3gxppkLNE7tjekdM88UKD
	5FGXD0AWfoV57Cb4u07DMmw3mybGyvPqwVT/6O97IaRzZ9EywEPvvxcubvw==
X-Gm-Gg: ASbGnctB0d/oObBU0l/+E78hHlnyYQ6nfvysQ2cISFXaN+X3rtwHx3Y5+al8Pu2bzxh
	oLNWeiU3CcfeBwMjltZE9Vs080rlHfU18nxMrIvxIKZpMMUqh4APu8Jqm6u1+UWPDPMTpHzKwiR
	8VoDXzExhHYu/tOPsxiraiZLISid79wo8UX9wre27x1+cbRDPOn8mROzTWzGC6TUsagk3Gc8mY+
	E4M9pfOne2u7+M8gwJJVfUyAEVl1cQXOshaHuq5ppUUL6PTZCKpX3SctPPHZX6XhODbBtqxhs82
	sSMc8bzLkkrjVLw=
X-Received: by 2002:ac8:590b:0:b0:476:8a83:9617 with SMTP id d75a77b69052e-476c8142fa2mr105611611cf.21.1742051851618;
        Sat, 15 Mar 2025 08:17:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFn/C1Gcyu44Exw+OkBDphvqXabIe8R8/o/sG/mjZDQ6x/ub1msOPsweEOT9RXuxYeLIFkG3w==
X-Received: by 2002:ac8:590b:0:b0:476:8a83:9617 with SMTP id d75a77b69052e-476c8142fa2mr105611381cf.21.1742051851328;
        Sat, 15 Mar 2025 08:17:31 -0700 (PDT)
Received: from [172.31.1.12] ([70.105.253.144])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-476bb82c73csm34834461cf.79.2025.03.15.08.17.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Mar 2025 08:17:30 -0700 (PDT)
Message-ID: <9e7f3d6a-0989-4778-a2c0-ffafdebefa87@redhat.com>
Date: Sat, 15 Mar 2025 11:17:29 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: GSSPROXY ( for NFS with sec=krb5, krb5i , krb5p ) is development
 still active or is it being depreciated
To: Benjamin Coddington <bcodding@redhat.com>,
 "Andrew J. Romero" <romero@fnal.gov>
Cc: linux-nfs@vger.kernel.org
References: <PH0PR09MB115997CF2D7A117949CDDB375A7D02@PH0PR09MB11599.namprd09.prod.outlook.com>
 <PH0PR09MB115990D120B04F28C93F4014CA7D32@PH0PR09MB11599.namprd09.prod.outlook.com>
 <E11151A2-D253-4F26-BB94-5CDA22FEF1B6@redhat.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <E11151A2-D253-4F26-BB94-5CDA22FEF1B6@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/14/25 8:18 AM, Benjamin Coddington wrote:
> On 13 Mar 2025, at 7:30, Andrew J. Romero wrote:
> 
>> Hi
>>
>> Alexander Bokovoy provided excellent answers to most of my questions on
>> this topic See: Thread: gssproxy  security, configuration and life-cycle
>> questions on gss-proxy@lists.fedorahosted.org
>>
>> Remaining question:
>>
>> Prior to RHEL-9 , in the section of the gssd man page ( under the heading
>> CONFIGURATION FILE ...  ....options  that  can be set on the command line
>> can also be controlled through .... values set in the [gssd] section of
>> /etc/nfs.conf ) there was a configuration parameter "use-gss-proxy"
> 
> I don't see any git history of gssd.man with use-gss-proxy, but the value
> does appear in nfs.conf.man.  It has not been removed there.  It probably
> should be added to gssd.man.
+1

> 
>> why was this parameter removed from the current man page, can it be
>> re-added ?  ( apparently the parameter is still functional ... if that's
>> the case , it should not simply be removed from the documentation with no
>> commentary )
> 
> I'm not sure thats what happened.  It looks like it wasn't ever in gssd.man
> to me.  Maybe Steve D can clarify?

My question is does the use-gss-proxy param need to be on
by default... I agree that parameter needs to be documented in the
gssd.man man page... which smayhew as sent a patch.

Does use-gss-proxy=yes add more complexity that is needed?

Personally I would like to turn it off.

steved.


