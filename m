Return-Path: <linux-nfs+bounces-11731-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 132D6AB7B12
	for <lists+linux-nfs@lfdr.de>; Thu, 15 May 2025 03:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CC55189AA66
	for <lists+linux-nfs@lfdr.de>; Thu, 15 May 2025 01:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3AC22798F3;
	Thu, 15 May 2025 01:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hyub.org header.i=@hyub.org header.b="hcsJzBZi"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail.hyub.org (hyub.org [45.33.94.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCC01F4CA0
	for <linux-nfs@vger.kernel.org>; Thu, 15 May 2025 01:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.33.94.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747273327; cv=none; b=rmFMU0WY5YgXzro5Edxp3JxGjuc0wFaNbydH7SHAx5mu1HRjFVvy9fad+KCyCbRQZ9zcUS8CBtEpItCT/domu2Uh+T2CdSMu3CvZs/wKdpOHQLsZUEBGaPvFtZySTSePQ5tYLSKyvPU91do7b73YuthG623GwXPQGBeCt5wnoFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747273327; c=relaxed/simple;
	bh=AvuLSV6zDdkadW1IeUvLRuHMKA2i2v2ZTr06+WPelx0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k4L82jjVxZfmWSessmQPD52N1N+opkkeKhd9E+TjLvrY6VuePRC6oBuPWoUuhoAwE+xmP4M+yKGYKrP+9GxMeO/YRNjhunS0TCTeMnntmODRUY+ryZzYw1hJ925rMnoXLb7TFKpNN2x4dK9LrHrYV55bizRKzuogTxq5Nj77s/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hyub.org; spf=pass smtp.mailfrom=hyub.org; dkim=pass (2048-bit key) header.d=hyub.org header.i=@hyub.org header.b=hcsJzBZi; arc=none smtp.client-ip=45.33.94.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hyub.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hyub.org
Received: by mail.hyub.org (Postfix) id E5748609F5;
	Thu, 15 May 2025 01:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hyub.org; s=dkim;
	t=1747272763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qtCXqlAWEroB7EG5AJcb9ba3gQUixJoangc/jD5HtcY=;
	b=hcsJzBZi90OENqVmswYRVmSnAF2yDEyQv4lCKCM25DrlGY1WdxuMnfaGHyUNZ4qQAUPRSD
	RfxBq/037IOXyQ3r+hHQEsgwqT0rup7YndI4wx5A9Cey5LFJMEnbvFhtXMXegQ7oe9OrrN
	yI2iWHZf+aen+XGWJGtUQcg+ot/qUUNUNG4gvP4IClW9mObrpQ1Jl5kKFi+8qXy/+NzfBP
	25EzB79kaxl/OEvX0AcpDXuHsohX7vl8yUZ7c+pockaiha6CAPR1ssdXHPUMJXB7jJ7/wY
	pBu1oNtBukd13USxXSbKRw3mjx6S0XzXh2k4ruolPRk/pvH3F+vClB15Mp5u5w==
Message-ID: <20c276fb-d840-4fec-a7b9-998f57d0a674@hyub.org>
Date: Thu, 15 May 2025 01:32:00 +0000
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH nfs-utils] exportfs: make "insecure" the default for all
 exports
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>
Cc: Steve Dickson <steved@redhat.com>, Tom Haynes <loghyr@gmail.com>,
 linux-nfs@vger.kernel.org
References: <20250513-master-v1-1-e845fe412715@kernel.org>
 <174719033130.62796.892917485792343533@noble.neil.brown.name>
 <7ccccc0cbaecb1a092983de6ab30f1db722d0006.camel@kernel.org>
From: Christopher Bii <christopherbii@hyub.org>
In-Reply-To: <7ccccc0cbaecb1a092983de6ab30f1db722d0006.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Just want to weigh in on this briefly,

Firstly:

Yes, people have arbitrary access to low ports on their systems, but
such privileges are voided behind a NAT. Meaning a, possibly accidental,
publicly facing server may indeed benefit from such a check.

Secondly:

Even if NAT's didn't exist and you needed no system capabilities to bind
to any port. It is entirely legitimate for server/client applications,
let alone ones living in the kernel, to restrict client access based on
any criterion that may (de)legitimize them. Look at smtp. Yes there are
workarounds to everything, but goal isn't to stop bad actors in whole,
or even in large part. If such a thing can deter a small portion of
malicious traffic, it worked.

Thirdly:

Kinda goes with the above. Evaluating the efficiency of individual
components of a larger system can often lead to false conclusions.

Unless this has actively caused any issues for people where they would
rather it be opt-in, I think this should remain unchanged. If anything,
I'd say the argument to take it out completely is much more compelling.

It's a simple toggle option, those likely to need the change can easily
do so. If we assume zero user knowledge, they are likely incapable of
stepping outside the default ports used by client/server. Meaning, best
case scenario, the connection from port 60000 may be the vacuum cleaner.

Regards,
Christopher Bii

Jeff Layton wrote:
> On Wed, 2025-05-14 at 12:38 +1000, NeilBrown wrote:
>> On Tue, 13 May 2025, Jeff Layton wrote:
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
>>>   support/nfs/exports.c      | 7 +++++--
>>>   utils/exportfs/exports.man | 4 ++--
>>>   2 files changed, 7 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/support/nfs/exports.c b/support/nfs/exports.c
>>> index 21ec6486ba3d3945df0800972ba1dfd03bd65375..69f8ca8b5e2ed50b837ef287ca0685af3e70ed0b 100644
>>> --- a/support/nfs/exports.c
>>> +++ b/support/nfs/exports.c
>>> @@ -34,8 +34,11 @@
>>>   #include "reexport.h"
>>>   #include "nfsd_path.h"
>>>   
>>> -#define EXPORT_DEFAULT_FLAGS	\
>>> -  (NFSEXP_READONLY|NFSEXP_ROOTSQUASH|NFSEXP_GATHERED_WRITES|NFSEXP_NOSUBTREECHECK)
>>> +#define EXPORT_DEFAULT_FLAGS	(NFSEXP_READONLY |	\
>>> +				 NFSEXP_ROOTSQUASH |	\
>>> +				 NFSEXP_GATHERED_WRITES |\
>>> +				 NFSEXP_NOSUBTREECHECK | \
>>> +				 NFSEXP_INSECURE_PORT)
>>>   
>>>   struct flav_info flav_map[] = {
>>>   	{ "krb5",	RPC_AUTH_GSS_KRB5,	1},
>>> diff --git a/utils/exportfs/exports.man b/utils/exportfs/exports.man
>>> index 39dc30fb8290213990ca7a14b1b3971140b0d120..0b62bb3a82b0e74bc2a7eb84301c4ec97b14d003 100644
>>> --- a/utils/exportfs/exports.man
>>> +++ b/utils/exportfs/exports.man
>>> @@ -180,8 +180,8 @@ understands the following export options:
>>>   .TP
>>>   .IR secure
>>>   This option requires that requests not using gss originate on an
>>> -Internet port less than IPPORT_RESERVED (1024). This option is on by default.
>>> -To turn it off, specify
>>> +Internet port less than IPPORT_RESERVED (1024). This option is off by default
>>> +but can be explicitly disabled by specifying
>>>   .IR insecure .
>>
>> I think you mean "can be explicit enabled if desired" or similar.
>>
> 
> Yeah, it is a little awkward. I want to keep "insecure" in the manpage
> so that people know what the option is (and don't try to use something
> like "nosecure"). I'll see if I can rephrase that.
> 
>> If you really want to do this, you should require either "insecure" or
>> "secure" and generate a warning like we did when changing other defaults
>> in the past.  After a period of time you can remove that requirement.
>>
>> NeilBrown
>>
> 
> Requiring the option _would_ break existing setups, so I'd be against
> that plan.
> 
> One thing we could do is have exportfs log a warning to syslog when
> neither option is specified. Admins could specify it either way to
> silence the message. Would that overcome your objection?
> 
>>
>>>   (NOTE: older kernels (before upstream kernel version 4.17) enforced this
>>>   requirement on gss requests as well.)
>>>
>>> ---
>>> base-commit: 2cf015ea4312f37598efe9733fef3232ab67f784
>>> change-id: 20250513-master-89974087bb04
>>>
>>> Best regards,
>>> -- 
>>> Jeff Layton <jlayton@kernel.org>
>>>
>>>
>>>
>>
> 


