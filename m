Return-Path: <linux-nfs+bounces-11494-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FFC2AAC6CA
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 15:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F10EF1BA2702
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 13:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB041A76D0;
	Tue,  6 May 2025 13:43:25 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C53182D2
	for <linux-nfs@vger.kernel.org>; Tue,  6 May 2025 13:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746539005; cv=none; b=nPHPCz1fI61k6zpojqIhyhXhcmR2UMEd42Wph2bt1jMKhNNJHaF7nq2mUsy9cv9oAMQays5EWajg677mCDlSE/UbAR/5HDnEzthDrF8UXYA/1rpARea3nnNAMr0hD/INNkSMrMau9gKX0sRLqn4Bruwyy3tgQeCPLB4rv30J1UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746539005; c=relaxed/simple;
	bh=zmYv5FYFtmGf/J3ZA03j/1damSzocnFGw9SdOz5VzpY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FM8GaTTnOyN26fZhtDgDmPon9DGtvvxnOMoRr5CnPMay+3WsGIczvVk0+XS7vIy3luYHdi+drQMRMIp5Wrrc3YpzmA/b6F6gVrgKaXie3ff0JEXAqvmZKWHDEfBJ9OfC8itm2SLtv9dFwz2Ey5ePjDzzcsG/h7jUGaP77Lv/DuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43cf58eea0fso25323425e9.0
        for <linux-nfs@vger.kernel.org>; Tue, 06 May 2025 06:43:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746539001; x=1747143801;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CU9xB6eBGrg/naXeKyR5FN1qVqo/tLHjTPl1OAeRqyw=;
        b=mO4sXj2/7z25W1ffJyLVTDanzesyUm5vr1UNlt3BJNg4d4DuCQDafRL9qKTFQNcX6y
         yZb16iTDwwv6XioZJ5HFXeFCqA7rwJU+AxeR+lw6HG9DPLy2kOTwlJrDsnKrvmEePIDR
         BFozYnSxYuwK3f32gc3chFnKes3xL3lq1z+nees7kupJ+TkhZX19cX2VGBn7NlTEaRBp
         4mVRwnRhDwqYwpz4R6CWszS+xVxbUxcifTqlTavcpPlR7KApWZlRIYquAPtrTmb9eyLr
         BykRsEnZJf36ZFxy81DPjBsAcrfnLUl54TKa7S9bUB8O8aQCje5YdQIjwAquBTuFFe0/
         AyUA==
X-Forwarded-Encrypted: i=1; AJvYcCV5hJH17xIVszm04FTqTkQU50ND+odwJM3fLqxsrE5LNyy+d2wXH/+3/D2gdfF6x4WEoi7NW/CG/y4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUN0XNmcrGcUziQlvA2eQQ5TdgsCWecURVxolj229rLMILzIhj
	sYrfX8A5wm6zy9vSG+YNqgGXYrAh+kZH6d+N5AL984uFFXa7fikB
X-Gm-Gg: ASbGncusKx+PCp1p3sVEC1mFR1YEDXFC+gIOtm4qGgvLgHbZwsPW0QHgzKf7o5xfIXM
	8PbcFWPlhvaLmxPiMCBvTzkNNCz4lVBO1qFFM4WeDVIPjrWJLsQxKWznz99uDyaJ+JNGcLCJR3W
	v2E6K3q+S8cs09+dVeVw8mkP/sB/zgT4hIeWFDYaozfQXpqMDxzkqrvG2UdQJRWZ/Ov/CirpQOs
	LN9PC+NFSjgTsNr6cztuZE8XU9l1RVV8/Nk+Z2iRXmI750JKrb9UOLajAV+92Pc4btXDbVsjmWa
	aaYigGGMd6l061tcN8JbwWqi7jEq45rvvzOFjQgBclqh9jt1bsaAiENh4NTCiEdgRL3NJIriD/t
	Aob1Hqw==
X-Google-Smtp-Source: AGHT+IE51Wb5EjCEHbSy8Y1/Om7ql/jJ/VciwukoLI5y1Ls8IGRvzn7wDRFGtlnE+CwLGXwuPOk3Sw==
X-Received: by 2002:a05:600c:a213:b0:43d:7588:66a5 with SMTP id 5b1f17b1804b1-441bbf3bd6dmr109110215e9.31.1746539001188;
        Tue, 06 May 2025 06:43:21 -0700 (PDT)
Received: from [10.50.5.11] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b2aece0asm214668945e9.14.2025.05.06.06.43.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 May 2025 06:43:20 -0700 (PDT)
Message-ID: <f66fd307-c5d6-40b5-87b7-fc6450cc09f1@grimberg.me>
Date: Tue, 6 May 2025 16:43:19 +0300
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] NFSv4.2: fix setattr caching of TIME_[MODIFY|ACCESS]_SET
 when timestamps are delegated
To: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Cc: Trond Myklebust <trondmy@kernel.org>,
 Anna Schumaker <Anna.Schumaker@netapp.com>, Thomas Haynes <loghyr@gmail.com>
References: <20250425124919.1727838-1-sagi@grimberg.me>
 <67a837dbebdbc6bb457998b1f61358970f31a4ed.camel@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <67a837dbebdbc6bb457998b1f61358970f31a4ed.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hey Jeff,

On 05/05/2025 16:23, Jeff Layton wrote:
> On Fri, 2025-04-25 at 15:49 +0300, Sagi Grimberg wrote:
>> nfs_setattr will flush all pending writes before updating a file time
>> attributes. However when the client holds delegated timestamps, it can
>> update its timestamps locally as it is the authority for the file
>> times attributes. The client will later set the file attributes by
>> adding a setattr to the delegreturn compound updating the server time
>> attributes.
>>
>> Fix nfs_setattr to avoid flushing pending writes when the file time
>> attributes are delegated and the mtime/atime are set to a fixed
>> timestamp (ATTR_[MODIFY|ACCESS]_SET. Also, when sending the setattr
>> procedure over the wire, we need to clear the correct attribute bits
>> from the bitmask.
>>
>> I was able to measure a noticable speedup when measuring untar performance.
>> Test: $ time tar xzf ~/dir.tgz
>> Baseline: 1m13.072s
>> Patched: 0m49.038s
>>
>> Which is more than 30% latency improvement.
>>
> (cc'ing Tom since he was the spec author for the timestamp delegation)
>
> Nice!

Indeed,

Do note that in order to get this change, I made nfsd send a space_limit 
(see under the
'---' separator) such that file close will not flush buffered data if it 
amounts to less than
the space_limit. Without this small patch, the flush invoked from close 
synchronizes everything
and making setattr async does not buy us as much.

>
>> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
>> ---
>> Tested this on a vm in my laptop against chuck nfsd-testing which
>> grants write delegs for write-only opens, plus another small modparam
>> that also adds a space_limit to the delegation.
>>
>>   fs/nfs/inode.c    | 49 +++++++++++++++++++++++++++++++++++++++++++----
>>   fs/nfs/nfs4proc.c |  8 ++++----
>>   2 files changed, 49 insertions(+), 8 deletions(-)
>>
>> diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
>> index 119e447758b9..6472b95bfd88 100644
>> --- a/fs/nfs/inode.c
>> +++ b/fs/nfs/inode.c
>> @@ -633,6 +633,34 @@ nfs_fattr_fixup_delegated(struct inode *inode, struct nfs_fattr *fattr)
>>   	}
>>   }
>>   
>> +static void nfs_set_timestamps_to_ts(struct inode *inode, struct iattr *attr)
>> +{
>> +	unsigned int cache_flags = 0;
>> +
>> +	if (attr->ia_valid & ATTR_MTIME_SET) {
>> +		struct timespec64 ctime = inode_get_ctime(inode);
>> +		struct timespec64 mtime = inode_get_mtime(inode);
>> +		struct timespec64 now;
>> +		int updated = 0;
>> +
>> +		now = inode_set_ctime_current(inode);
>> +		if (!timespec64_equal(&now, &ctime))
>> +			updated |= S_CTIME;
>> +
>> +		inode_set_mtime_to_ts(inode, attr->ia_mtime);
>> +		if (!timespec64_equal(&now, &mtime))
>> +			updated |= S_MTIME;
>> +
>> +		inode_maybe_inc_iversion(inode, updated);
>> +		cache_flags |= NFS_INO_INVALID_CTIME | NFS_INO_INVALID_MTIME;
>> +	}
>> +	if (attr->ia_valid & ATTR_ATIME_SET) {
>> +		inode_set_atime_to_ts(inode, attr->ia_atime);
>> +		cache_flags |= NFS_INO_INVALID_ATIME;
>> +	}
>> +	NFS_I(inode)->cache_validity &= ~cache_flags;
>> +}
>> +
>>   static void nfs_update_timestamps(struct inode *inode, unsigned int ia_valid)
>>   {
>>   	enum file_time_flags time_flags = 0;
>> @@ -701,14 +729,27 @@ nfs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
>>   
>>   	if (nfs_have_delegated_mtime(inode) && attr->ia_valid & ATTR_MTIME) {
>>   		spin_lock(&inode->i_lock);
>> -		nfs_update_timestamps(inode, attr->ia_valid);
>> +		if (attr->ia_valid & ATTR_MTIME_SET) {
> Is this also a bugfix? Is ATTR_MTIME_SET being handled correctly in the
> existing code?

I don't think so, the delegation holder is allowed to set attributes 
against the
server if it so chooses.

>
>> +			nfs_set_timestamps_to_ts(inode, attr);
>> +			attr->ia_valid &= ~(ATTR_MTIME|ATTR_MTIME_SET|
>> +						ATTR_ATIME|ATTR_ATIME_SET);
> It might look a little cleaner to move the ia_valid changes into
> nfs_set_timestamps_to_ts().

I tried to stay consistent with the nfs_update_timestamps() call. But I can
move it. sure.

>
>
>> +		} else {
>> +			nfs_update_timestamps(inode, attr->ia_valid);
>> +			attr->ia_valid &= ~(ATTR_MTIME|ATTR_ATIME);
>> +		}
>>   		spin_unlock(&inode->i_lock);
>> -		attr->ia_valid &= ~(ATTR_MTIME | ATTR_ATIME);
>>   	} else if (nfs_have_delegated_atime(inode) &&
>>   		   attr->ia_valid & ATTR_ATIME &&
>>   		   !(attr->ia_valid & ATTR_MTIME)) {
>> -		nfs_update_delegated_atime(inode);
>> -		attr->ia_valid &= ~ATTR_ATIME;
>> +		if (attr->ia_valid & ATTR_ATIME_SET) {
>> +			spin_lock(&inode->i_lock);
>> +			nfs_set_timestamps_to_ts(inode, attr);
>> +			spin_unlock(&inode->i_lock);
>> +			attr->ia_valid &= ~(ATTR_ATIME|ATTR_ATIME_SET);
>> +		} else {
>> +			nfs_update_delegated_atime(inode);
>> +			attr->ia_valid &= ~ATTR_ATIME;
>> +		}
>>   	}
>>   
>>   	/* Optimization: if the end result is no change, don't RPC */
>> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
>> index 970f28dbf253..c501a0d5da90 100644
>> --- a/fs/nfs/nfs4proc.c
>> +++ b/fs/nfs/nfs4proc.c
>> @@ -325,14 +325,14 @@ static void nfs4_bitmap_copy_adjust(__u32 *dst, const __u32 *src,
>>   
>>   	if (nfs_have_delegated_mtime(inode)) {
>>   		if (!(cache_validity & NFS_INO_INVALID_ATIME))
>> -			dst[1] &= ~FATTR4_WORD1_TIME_ACCESS;
>> +			dst[1] &= ~(FATTR4_WORD1_TIME_ACCESS|FATTR4_WORD1_TIME_ACCESS_SET);
>>   		if (!(cache_validity & NFS_INO_INVALID_MTIME))
>> -			dst[1] &= ~FATTR4_WORD1_TIME_MODIFY;
>> +			dst[1] &= ~(FATTR4_WORD1_TIME_MODIFY|FATTR4_WORD1_TIME_MODIFY_SET);
>>   		if (!(cache_validity & NFS_INO_INVALID_CTIME))
>> -			dst[1] &= ~FATTR4_WORD1_TIME_METADATA;
>> +			dst[1] &= ~(FATTR4_WORD1_TIME_METADATA|FATTR4_WORD1_TIME_MODIFY_SET);
>>   	} else if (nfs_have_delegated_atime(inode)) {
>>   		if (!(cache_validity & NFS_INO_INVALID_ATIME))
>> -			dst[1] &= ~FATTR4_WORD1_TIME_ACCESS;
>> +			dst[1] &= ~(FATTR4_WORD1_TIME_ACCESS|FATTR4_WORD1_TIME_ACCESS_SET);
>>   	}
>>   }
>>   
> FWIW, we've been chasing some problems with the git regression
> testsuite when attribute delegation is enabled. It would be interesting
> to test this patch to see if it changes that behavior.

Can you elaborate? didn't notice that git uses the times ATTR_*_SET 
variant too often.
>
> Otherwise, this seems like a reasonable thing to do, and I do like the
> potential performance improvement!
>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>


