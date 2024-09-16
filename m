Return-Path: <linux-nfs+bounces-6509-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 901CF97A091
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Sep 2024 13:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC9AE1C20CFB
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Sep 2024 11:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2D0149C57;
	Mon, 16 Sep 2024 11:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B+n+pYTV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8E24962E
	for <linux-nfs@vger.kernel.org>; Mon, 16 Sep 2024 11:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726487682; cv=none; b=EhPoiy7x7V+kcdVh6fDQ8QmvZzzgKGh66lswYa5CamXcOmENxZfh6kkjKlLB47IO2FPf8uztBO8e76hN55EYZnftUB9sweeiOTVRx6Hr+WWL1ATHF5fpk1PR9DwODuV3qsLOuPxn7OMJyZDFVqOgBNLj7SyVFvK+9C6KqxjLJ2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726487682; c=relaxed/simple;
	bh=HR2CMxIjf12d+4KPqiy7+8DqUBNWV7+a55zRMb8ZUiw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EyGAVcAapvhtmF57oiM8L9fLpSMCnncZc9Mw48E55/gP751/viCRZH8y6cz5FgFCQGSD/On31XpgOeL/hS9EPK1MUbSCtmkGLLfnJo++M5tiYDDpuj0opoPXHfTErJLD68Cbbr9DAJ04OfJoORFAfINfh4gFahoHook7ZPAiuQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B+n+pYTV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726487679;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3DOKxoad5TsFnFAl6iAn9/fsphwaakGh+gujNI+aorE=;
	b=B+n+pYTVitUgdRkXu7dsnyQNQTGc0mFAgq+kjdSH+59sbeQsqoskpKNk4KYHlZ+pNecspj
	PyXxn/vXj1saH+7afZ++3mAbvFAXTQhfj97bi4jegFQsw7LcNH7Eoiy4eC3ijb058oynfe
	6pktlA4dzHN1o++jhHcpi2inFHRB9Ec=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-uohiaWKVMjOKMjfwo4bupg-1; Mon, 16 Sep 2024 07:54:38 -0400
X-MC-Unique: uohiaWKVMjOKMjfwo4bupg-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7a99d13f086so208675885a.1
        for <linux-nfs@vger.kernel.org>; Mon, 16 Sep 2024 04:54:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726487677; x=1727092477;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3DOKxoad5TsFnFAl6iAn9/fsphwaakGh+gujNI+aorE=;
        b=KSyXzrxJWOPy+2DuwvJJZZQ1N8fdcYisPAS3qpyb36zm5WBPZkJz0PAmUW18JZ3ua1
         bVoDlU/QDlOhIvHPx93HZ0oY2B9DRN/5tGRhSAyaZ3uRIK74FusNGvaaMpSTQN6abbbp
         UntNaPtZyeC/cqc55PJHG6SqmY7iiv6ZXLdnZQhp3UL9w/1eMmAUQbYQnczb+5PNQ5W/
         hnL2uOowxJTPz6JQ4SKyAv5RvY18zeD75lXgAGwvfoAzOluXVXwaRogYs7HgEYA7N3BT
         m8IX2W4g3MZWW7Ek+KnWiIOL2pW6VKMB8DcrhJ95f+XeBLsq/1q40bv+qCG1IR8ffVn9
         BQXw==
X-Gm-Message-State: AOJu0YzWsAJ12BkVbd4zzcK6/AHliNwLheYRRAdh/0lSiun14OgHMtcT
	B/lLkGymSCFf7dzeMZPpyuyvt9kqSexgcASs8THYOLk4rsAzIrxhcEvGFvba6vnsdOP13nhz2Gl
	6NnumiIjdYiN8TvwXpcWlYQPMFA3BGFhEJpXTF4PzOobAnb4OHCXhpkjkHpmpS7wC23Kv
X-Received: by 2002:a05:620a:408a:b0:7a9:a8c5:d4b3 with SMTP id af79cd13be357-7ab30d35bf4mr2389948985a.33.1726487677350;
        Mon, 16 Sep 2024 04:54:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKVXJF7kGR7Nwr78U/vSSSpknARPRpCPDBjTAsg0MguTNZB+IsFf91vu8ICNXyZceTjnZxFg==
X-Received: by 2002:a05:620a:408a:b0:7a9:a8c5:d4b3 with SMTP id af79cd13be357-7ab30d35bf4mr2389945685a.33.1726487676972;
        Mon, 16 Sep 2024 04:54:36 -0700 (PDT)
Received: from [172.31.1.12] ([70.105.241.244])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ab3e994390sm241292485a.47.2024.09.16.04.54.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Sep 2024 04:54:36 -0700 (PDT)
Message-ID: <e43aa92c-d91c-4931-b807-5edec649b2b4@redhat.com>
Date: Mon, 16 Sep 2024 07:54:35 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: rpc.idmapd runs out of file descriptors
To: Salvatore Bonaccorso <carnil@debian.org>,
 Sergio Gelato <sergio.gelato@astro.su.se>, Kevin Coffman
 <kwc@citi.umich.edu>, Neil Brown <neilb@suse.de>
Cc: linux-nfs@vger.kernel.org
References: <ZmCB_zqdu2cynJ1M@astro.su.se> <ZuU7S2Gli6oAALPJ@eldamar.lan>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <ZuU7S2Gli6oAALPJ@eldamar.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/14/24 3:29 AM, Salvatore Bonaccorso wrote:
> Hi all,
> 
> On Wed, Jun 05, 2024 at 05:19:27PM +0200, Sergio Gelato wrote:
>> Observed on Debian 12 (nfs-utils 2.6.2):
>>
>> May 28 09:40:25 HOSTNAME rpc.idmapd[3602614]: dirscancb: scandir(/run/rpc_pipefs/nfs): Too many open files
>> [repeated multiple times]
>>
>> Investigation with lsof on one of the affected systems shows that file desciptors are not being closed:
>>
>> [...]
>> rpc.idmap 675 root  126r      DIR               0,40        0      10813 /run/rpc_pipefs/nfs/clnt11e6 (deleted)
>> rpc.idmap 675 root  127u     FIFO               0,40      0t0      10817 /run/rpc_pipefs/nfs/clnt11e6/idmap (deleted)
>> rpc.idmap 675 root  128r      DIR               0,40        0      10834 /run/rpc_pipefs/nfs/clnt11ef (deleted)
>> rpc.idmap 675 root  129u     FIFO               0,40      0t0      10838 /run/rpc_pipefs/nfs/clnt11ef/idmap (deleted)
>> rpc.idmap 675 root  130r      DIR               0,40        0      10855 /run/rpc_pipefs/nfs/clnt11f8 (deleted)
>> rpc.idmap 675 root  131u     FIFO               0,40      0t0      10859 /run/rpc_pipefs/nfs/clnt11f8/idmap (deleted)
>>
>> Raising the verbosity level to 3 results in no "Stale client:" lines.
>> strace shows no close() calls other than for the /run/rpc_pipefs/nfs directory.
>>
>> I believe this is because in dirscancb() the loop is exited prematurely
>> the first time nfsopen() returns -1, preventing later entries in the queue
>> from being reaped. I've tested the patch below, which seems indeed to cure
>> the problem. The bug appears to be still unfixed in the current master branch.
> 
>> From: Sergio Gelato <Sergio.Gelato@astro.su.se>
>> Date: Tue, 4 Jun 2024 16:02:59 +0200
>> Subject: rpc.idmapd: nfsopen() failures should not be fatal
>>
>> dirscancb() loops over all clnt* subdirectories of /run/rpc_pipefs/nfs/.
>> Some of these directories contain /idmap files, others don't. nfsopen()
>> returns -1 for the latter; we then want to skip the directory, not abort
>> the entire scan.
>> ---
>>   utils/idmapd/idmapd.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/utils/idmapd/idmapd.c b/utils/idmapd/idmapd.c
>> index e79c124..f3c540d 100644
>> --- a/utils/idmapd/idmapd.c
>> +++ b/utils/idmapd/idmapd.c
>> @@ -556,7 +556,7 @@ dirscancb(int fd, short UNUSED(which), void *data)
>>   			if (nfsopen(ic) == -1) {
>>   				close(ic->ic_dirfd);
>>   				free(ic);
>> -				goto out;
>> +				continue;
>>   			}
>>   
>>   			if (verbose > 2)
> 
> Did this felt trough the cracks? Does the patch from Sergio looks good
> to you?
It did because it was not in the appropriate format... The patch
was an attachment, not in-line, no  Signed-off-by: line and
the patch was not create by git format-patch command (which
adds PATCH in the subject line).

I have filters that look for things like that and I just
didn't see it...

steved.



