Return-Path: <linux-nfs+bounces-4695-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6048F929948
	for <lists+linux-nfs@lfdr.de>; Sun,  7 Jul 2024 20:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14C6628176A
	for <lists+linux-nfs@lfdr.de>; Sun,  7 Jul 2024 18:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F127558B6;
	Sun,  7 Jul 2024 18:19:25 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D459D376E0
	for <linux-nfs@vger.kernel.org>; Sun,  7 Jul 2024 18:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720376365; cv=none; b=ejKw5Vo85Rg9dx4zUjuqSiuTivg8SIYc+76bG/dD4MMEr/wtPjKiSkNf+lQGbZeJeoRAP/WLm/Y8YGk9RY9iW7ol51w8bcHPQyJTsJdGPlcstralVyV/rrDhR3t5ZrSMyTptiMKC5G5t2gYknTKqLt7Sl5rXNC2npjrkOjtuLD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720376365; c=relaxed/simple;
	bh=4uEnuECRmc1lLaxGSvQz3sSt7F+WzvzckG2ClG3Sj/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UImDYo0GUOzvR57uEk0qL1EmyuKE8b03m1hKsF55NamCKczSLXUZCzxqlMNpY9wP5Qnzk3+5vt06Uh0UuzlNcdb2SxtMV/V6hpykGoOzayLoqJZWePypKDNPa1lyIekeIPlqrPrYBFeC1n9ZvTxesBbc3JGj8aw3lI9WIaEBV7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-426593b99daso2065615e9.1
        for <linux-nfs@vger.kernel.org>; Sun, 07 Jul 2024 11:19:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720376362; x=1720981162;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p0bSXMePrhsHVmQFn13s5dnD4VpRtZ3KN4WkUBvycM0=;
        b=gwp6gNXXeUgGu5ubR8G/2ha1ghhzNYB1qWrm+TK92/ZK4/kX3WkbkIfsrDJaju6IMR
         J18zHAGa/Sb8JGT81AF/UcYdw1PcztD0QyR5c7znXF0w9rA04fbnlscUUXWYX1DnnFte
         8wtQWi2jOljhtYqGmyuv6HflbX7hwunN7k9CCgZiwF2EIqapFkS6TfyAT2JTc5TPr3Z3
         otYL1tMj5IFtcRUf41+avviKPMPxqCHtnqmkwc+DGUt/BIa5I9dJfkUWkC9pA0XK+/+K
         6cVljPTnm4zqfNCbJVPHUt7G5+JkDy5KVem4GQw9MlFQkfCTmnBDjcbt2fVdV5GrcZ8V
         cQZw==
X-Gm-Message-State: AOJu0YwE2gsdh4q2ynEbpuSX9ogW6WxDAtoQu/nNF6nc+zFxfZbfHjZV
	NbOQN6eLSi8D7PZjkyfTNfizRQw3VQvRYy733Y1L8xD0Bo3cjvm1
X-Google-Smtp-Source: AGHT+IE4a8YUS/RzYa0lcg354UVV0HNyiSyEwNRmMWeW7IvlrgnbUHvfLvYumcx7WDzVqUpjkdu4iw==
X-Received: by 2002:a5d:64c7:0:b0:365:da7f:6c13 with SMTP id ffacd0b85a97d-3679dd09dc0mr7905740f8f.2.1720376362032;
        Sun, 07 Jul 2024 11:19:22 -0700 (PDT)
Received: from [10.100.102.74] (85.65.198.251.dynamic.barak-online.net. [85.65.198.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367a0522ea3sm8668128f8f.27.2024.07.07.11.19.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Jul 2024 11:19:21 -0700 (PDT)
Message-ID: <13ac3e25-968c-4f14-82e9-580326e0e953@grimberg.me>
Date: Sun, 7 Jul 2024 21:19:19 +0300
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfc] nfsd: offer write delegation for O_WRONLY opens
To: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org
References: <20240706224207.927978-1-sagi@grimberg.me>
 <114581777d5b61b6973ec9ef2537ee887989e197.camel@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <114581777d5b61b6973ec9ef2537ee887989e197.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 07/07/2024 14:06, Jeff Layton wrote:
> On Sun, 2024-07-07 at 01:42 +0300, Sagi Grimberg wrote:
>> Many applications open files with O_WRONLY, fully intending to write
>> into the opened file. There is no reason why these applications should
>> not enjoy a write delegation handed to them.
>>
>> Cc: Dai Ngo <dai.ngo@oracle.com>
>> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
>> ---
>> Note: I couldn't find any reason to why the initial implementation chose
>> to offer write delegations only to NFS4_SHARE_ACCESS_BOTH, but it seemed
>> like an oversight to me. So I figured why not just send it out and see who
>> objects...
>>
>>   fs/nfsd/nfs4state.c | 10 +++++-----
>>   1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index a20c2c9d7d45..69d576b19eb6 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -5784,15 +5784,15 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
>>   	 *  "An OPEN_DELEGATE_WRITE delegation allows the client to handle,
>>   	 *   on its own, all opens."
>>   	 *
>> -	 * Furthermore the client can use a write delegation for most READ
>> -	 * operations as well, so we require a O_RDWR file here.
>> -	 *
>> -	 * Offer a write delegation in the case of a BOTH open, and ensure
>> -	 * we get the O_RDWR descriptor.
>> +	 * Offer a write delegation in the case of a BOTH open (ensure
>> +	 * a O_RDWR descriptor) Or WRONLY open (with a O_WRONLY descriptor).
>>   	 */
>>   	if ((open->op_share_access & NFS4_SHARE_ACCESS_BOTH) == NFS4_SHARE_ACCESS_BOTH) {
>>   		nf = find_rw_file(fp);
>>   		dl_type = NFS4_OPEN_DELEGATE_WRITE;
>> +	} else if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE) {
>> +		nf = find_writeable_file(fp);
>> +		dl_type = NFS4_OPEN_DELEGATE_WRITE;
>>   	}
>>   
>>   	/*
>
> I *think* the main reason we limited this before is because a write
> delegation is really a read/write delegation. There is no such thing as
> a write-only delegation.
>
> Suppose the user is prevented from doing reads against the inode (by
> permission bits or ACLs). The server gives out a WRITE delegation on a
> O_WRONLY open. Will the client allow cached opens for read regardless
> of the server's permissions? Or, does it know to check vs. the server
> if the client tries to do an open for read in this situation?

That is a good point. As far as I can tell, the client will still send 
ACCESS to the server
in this case...

looks like vfs do_open->may_open will call inode_permission -> 
nfs_permission -> nfs_do_access...
I don't see any type of bypass if a delegation is present (correctly afaiu).

iiuc the only user that can omit talking to the server for access is the 
permissions field that is returned
in the delegation, and nfsd keeps it cleared, so all users will need to 
issue access (if not already cached).

