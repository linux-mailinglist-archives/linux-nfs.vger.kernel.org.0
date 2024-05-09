Return-Path: <linux-nfs+bounces-3223-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5C18C1191
	for <lists+linux-nfs@lfdr.de>; Thu,  9 May 2024 16:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0126D1C20B96
	for <lists+linux-nfs@lfdr.de>; Thu,  9 May 2024 14:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0ED3A8CB;
	Thu,  9 May 2024 14:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aeo3//GI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4AA91A2C3A
	for <linux-nfs@vger.kernel.org>; Thu,  9 May 2024 14:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715266600; cv=none; b=qz7DVMBiMbbdaVB/ZTrmB+kdXymteCEujyaY8qBEwqNod/hX6Jzn6kJWXnIshCtN0Oq/A0eybHBUS3Fxe6llaPzufC+tyIbWNI3eS0e5p3MwhokDB1Tcl+oNGqBAwZxDumxtTuM+xcjpwnVmG+0iYuXuKzsalx2ALNPpwor1Dkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715266600; c=relaxed/simple;
	bh=OxkEaiMbL04LDCaNNAhNBhg/6eEUU3AHPlsXmHN1lVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=DHn3+ou+IMLAE9x6FkJedmwOjNd1U1wMibIug32hFfCwOwKFA320Y6POwZDcVYRCNj8dnfhKQnoqEdAnXSoUhabUmLe3Ii/Vh+QCIoRnovNSi3GvMAfNOSIpRl9g7S/dPlqrb8ixboaFqxSbGbWLMzgj3rrrugDyc23GkeXrkrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aeo3//GI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715266597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QzJ0Cm3OUl9P8i6t1c6wwHK+AH1YO3y2nyZ99a0NTSU=;
	b=aeo3//GIU9S6FL0C8MmwGZGKYiBFMXP0dBX26VMq5C3Xk1p+ZSzivWc2Eu15YY7TKR9ec3
	D2Rzx1CDQjfNHASTUQPlp4T+gYu4nkFV1f4aBU8Ncv4/+giGPsQKlGXnOP7Bi92dKepQj8
	MraVMmFTJCZ6SqUL9awBkW47s+SA550=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-PrAefuI5O-2tsIxKZ3cESQ-1; Thu, 09 May 2024 10:56:21 -0400
X-MC-Unique: PrAefuI5O-2tsIxKZ3cESQ-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2b4331da4a8so334073a91.1
        for <linux-nfs@vger.kernel.org>; Thu, 09 May 2024 07:56:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715266580; x=1715871380;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QzJ0Cm3OUl9P8i6t1c6wwHK+AH1YO3y2nyZ99a0NTSU=;
        b=sN2mIQt1KNOkKZ+M7O8DfmSlm+72h5zzv/ixJywtGyIUGS10fK/mNH3F+et1blM+VY
         OeiKaS1WizEpiZLJ67itAW+yMhg54xa3RPE50i0P4/lM+wLPnd3zkXRhbjpFLb0raVDO
         QNVb5q/bYFqDP1G+YY1bOjsKYxbN1l4bV5tooYvud4A63sBRM9N7U9L5LJY5QTpMeUcY
         FINAJq/lJj+FTm0wroeHkYlfImEGebA9XqMX3HcXPkLCJkUgZsDNeW/xX+RBl+8iCfa8
         VsxKfsMC9COxGFsFZhK66vEeX+jpvPv29cwm6v/aB9Wu7R6FqnSUOeEo5Yml6sNtxXdJ
         IGew==
X-Forwarded-Encrypted: i=1; AJvYcCXccc0ycLeZWnwmmFyGXcPWRgUMVINZYqubq+qcNdppeN8OaT38hSehJokdW0RN1XrDyTtNUC94dkufn4h0byl4FK3qK6L2NsP4
X-Gm-Message-State: AOJu0YylTpjwD7jLOFIZeFqYzxjFHqzT0F6evXl0kl9abw4sgn7RSAyC
	q5WYr/Vc7KAHr0VFvn66pRjJ9o4O+vV8d96sqf7q22qsFn4c21bz9TLPjDI1FyGz614KdCl1WON
	iqqI9UOQlGkIqL7MOgNRUe10gFxmEBPNcVDTWrZrsKtTrcE0WidyVbY2bQsy4ZxUOaQ==
X-Received: by 2002:a17:902:ecc7:b0:1de:ddc6:27a6 with SMTP id d9443c01a7336-1eeb01a3cffmr64810405ad.2.1715266580271;
        Thu, 09 May 2024 07:56:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF28K6Pxsm2CWnwwyjuVFO/bCoJTUH22vZtZpkyxN513CMmkg1DUu/cG7Poh4J0f+ISu3OLSA==
X-Received: by 2002:a17:902:ecc7:b0:1de:ddc6:27a6 with SMTP id d9443c01a7336-1eeb01a3cffmr64810175ad.2.1715266579800;
        Thu, 09 May 2024 07:56:19 -0700 (PDT)
Received: from [10.19.60.48] (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bad9e66sm15243725ad.110.2024.05.09.07.56.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 May 2024 07:56:18 -0700 (PDT)
Message-ID: <f4e2cf9a-04e4-47a8-88f5-70544b516d3e@redhat.com>
Date: Thu, 9 May 2024 10:56:16 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mount: If a reserved ports is used, do so for the pings
 as well
To: Trond Myklebust <trondmy@hammerspace.com>,
 "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
 "alex@caoua.org" <alex@caoua.org>
References: <ZhkMcZDhJhsVjo52@vm1.arverb.com>
 <42faba18-0042-407e-9957-497806cfeed1@redhat.com>
 <838909fda3f022bdf1ae3775ae0c0395e6102f85.camel@hammerspace.com>
 <32779e7d-1f5d-449d-890f-6d26f0d6cf4a@redhat.com>
 <ae1d55fc8e6951832548323228fc2b9a0eb5dfe4.camel@hammerspace.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <ae1d55fc8e6951832548323228fc2b9a0eb5dfe4.camel@hammerspace.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 4/21/24 6:14 PM, Trond Myklebust wrote:
> On Sun, 2024-04-21 at 17:38 -0400, Steve Dickson wrote:
>>
>>
>> On 4/21/24 12:06 PM, Trond Myklebust wrote:
>>> On Sun, 2024-04-21 at 07:09 -0400, Steve Dickson wrote:
>>>>
>>>>
>>>> On 4/12/24 6:26 AM, Alexandre Ratchov wrote:
>>>>> Hi,
>>>>>
>>>>> mount.nfs always uses a high port to probe the server's ports
>>>>> (regardless of
>>>>> the "-o resvport" option).  Certain NFS servers (ex.  OpenBSD -
>>>>> current) will
>>>>> drop the connection, the probe will fail, and mount.nfs will
>>>>> exit
>>>>> before any
>>>>> attempt to mount the file-system.  If mount.nfs doesn't ping
>>>>> the
>>>>> server from
>>>>> a high port, mounting the file system will just work.
>>>>>
>>>>> Note that the same will happen if the server is behind a
>>>>> firewall
>>>>> that
>>>>> blocks connections to the NFS service that originates from a
>>>>> high
>>>>> port.
>>>> Committed... (tag: nfs-utils-2-7-1-rc7)
>>>>
>>>> I just hope we don't run out of privilege ports during
>>>> a mount storm (aka when a server reboots).
>>>
>>> Agreed, and that is why this change was entirely the wrong thing to
>>> do.
>> Well the patch was sitting around for a while without any objection
>> so I figured I would go with it since it would make mounts
>> work on other OSs
>>
>>>
>>> The point of the ping is to allow for fast failover in the case
>>> where
>>> the portmap/rpcbind server returns incorrect or stale information.
>>>
>>> If there are servers out there that deliberately break the
>>> convention
>>> for NULL ping, as described in RFC5531, then we might allow
>>> optional
>>> use of the privileged port for those servers, but please don't
>>> force
>>> this on everyone else.
>> The patch is on the top of stack... easy revert-able... Is that what
>> you are suggesting?
> 
> That is my suggestion for now, yes.
> 
> I don't have any objection to a patch that adds opt-in functionality
> either to turn off the NULL ping, or to force that ping to use a
> privileged port. However we should not change the default behaviour to
> cause the existing paucity of privileged ports to be even more of a
> problem.
> 

Reverted.

steved.


