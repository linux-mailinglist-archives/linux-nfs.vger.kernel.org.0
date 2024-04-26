Return-Path: <linux-nfs+bounces-3021-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADCD08B3021
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Apr 2024 08:16:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A57828552B
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Apr 2024 06:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB70613A404;
	Fri, 26 Apr 2024 06:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jM2BxCfa"
X-Original-To: linux-nfs@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BE42F2F
	for <linux-nfs@vger.kernel.org>; Fri, 26 Apr 2024 06:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714112162; cv=none; b=nE8uv+e7XNr2KKIZ/ykagXwizXypJuzuVas9+OxFIGr/gZeWwDKmZaHrruGfPiKdRyzaSDrX5RQcaA84xAk5+SIfFvQzvkQXkujKRyzzS1Ne3vt0Jf58Qmh8SSN/OG6z+sQZeRsffxAuIOu74gd71jdk5QTLepFgyuzaULrclrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714112162; c=relaxed/simple;
	bh=QAyNPvY0KZPbruuKRSXP3MqtO6m3L9C7lLS5H3Lg+LI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oFcoE6v7hsYtH2nce81vV1JE30kuofwR/vopwWslqUFRXubluwN7G4UXQKr9zoRZPPAQtphrzl3P2LZ0sh9KtRATzyuaF/uuOcY0spp488BS052qfm/zWfBXZ3vhrH+n+zTYXw/ITLXRJgUwv4JgrBLFHQokdo2W6bKSgjo/jBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jM2BxCfa; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <30ab2ca2-2eaa-3c11-c5ff-580230b4b84c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714112157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aIAc3aTp2W7uCmLY2a8d0qFZ0Nnn/6NEqixZwXEZuwg=;
	b=jM2BxCfaqcITCfS63Ul887BWapRQOBR5NjeI5wwYFrXHiejnlngcfhtEyB8paKngJuS2UQ
	FoCZPU8eWjuPvmd914TPO3Csw0JGa34EyrWWCCXc1uwyv1PjBitjwYYoFbgrAZ8zBYUC/Z
	t/UPGj6NGS0+xuAKKqVpryNo0qsK528=
Date: Fri, 26 Apr 2024 14:15:27 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] SUNRPC: Remove comment for sp_lock
To: NeilBrown <neilb@suse.de>
Cc: trond.myklebust@hammerspace.com, anna@kernel.org, chuck.lever@oracle.com,
 jlayton@kernel.org, kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com,
 linux-nfs@vger.kernel.org
References: <20240426034750.26945-1-guoqing.jiang@linux.dev>
 <171410437515.7600.14267125361277447684@noble.neil.brown.name>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Guoqing Jiang <guoqing.jiang@linux.dev>
In-Reply-To: <171410437515.7600.14267125361277447684@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi Neil,

On 4/26/24 12:06, NeilBrown wrote:
> On Fri, 26 Apr 2024, Guoqing Jiang wrote:
>> It is obsolete since sp_lock was discarded in commit 580a25756a9f
>> ("SUNRPC: discard sp_lock").
>>
>> Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
>> ---
>>   net/sunrpc/svc_xprt.c | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
>> index b4a85a227bd7..ec78c277a02e 100644
>> --- a/net/sunrpc/svc_xprt.c
>> +++ b/net/sunrpc/svc_xprt.c
>> @@ -46,7 +46,6 @@ static LIST_HEAD(svc_xprt_class_list);
>>   
>>   /* SMP locking strategy:
>>    *
>> - *	svc_pool->sp_lock protects most of the fields of that pool.
>>    *	svc_serv->sv_lock protects sv_tempsocks, sv_permsocks, sv_tmpcnt.
>>    *	when both need to be taken (rare), svc_serv->sv_lock is first.
>>    *	The "service mutex" protects svc_serv->sv_nrthread.
>
> I usually make an effort to find those sorts of things but I obviously
> missed it this time.
> Thanks.

I find it occasionally during investigate one nfs issue 😁.

> Reviewed-by: NeilBrown <neilb@suse.de>

Thanks for your review!

Guoqing

