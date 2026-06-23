Return-Path: <linux-nfs+bounces-22776-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BItfFrkROmqo0wcAu9opvQ
	(envelope-from <linux-nfs+bounces-22776-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jun 2026 06:55:21 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E280F6B40B2
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jun 2026 06:55:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b=PY+QmjLC;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22776-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22776-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C60C7303DD07
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jun 2026 04:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7333A9622;
	Tue, 23 Jun 2026 04:55:04 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71E83A3804;
	Tue, 23 Jun 2026 04:55:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782190504; cv=none; b=VkDm6h6PQ5g1Z5NxojiLaoyPEPlVrI02+60vI2HiH2DbB/PtcqyWxz1UwryRO+AgZalgmBEjjfbUTOdU7GtldPdDsHsXFAV1fcl3fUR6oK9ruXh88VfTdjtPyf8bpskJ+9C7o4BtuQCR+igtFGr8kNjfBvdOodBFF7wKnB4A3tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782190504; c=relaxed/simple;
	bh=WhEL/BqwCBXzwugRJUHxcnan8uq6aZKyEugRw0UxD0I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lQ9IsUP49AmSk9heBKISU3eAiabWBWhrlAxnzX64kLUTCVZ6o9StND1XL5Ovs10PprKjRsKccbBtLbjPw/ISzNR/A70aBKI5xIPsceGygikmA6JT9fYNQeY2rZz+V85BCIUS+3mr4Hx8Cn1ZvNlFCre7qYR0hIugaV+GrCOVZ4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=PY+QmjLC; arc=none smtp.client-ip=115.124.30.99
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1782190498; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=vtLCPOvXkBkBfi3DgLhj2I+9Rs0o/4TKYRj6X2OritY=;
	b=PY+QmjLCYW9TynKfERnNXX9xEjsAfWDyDTosELDN39fMR8uslgQsqLb4yG2Fy44KAATuNFg5w556uu29FCYPybYhdVqacDcdesdl4LnmFtgeo/e21acH5elDHD5mpreCKt4uG2Q57fBdOg6WmBS6kkQHWY1CshapY86+VJ69M1A=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0X5Sjruz_1782190497;
Received: from 30.120.78.16(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0X5Sjruz_1782190497 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 23 Jun 2026 12:54:57 +0800
Message-ID: <c0bbe0c0-2b6f-47d9-8f45-b16bb455a089@linux.alibaba.com>
Date: Tue, 23 Jun 2026 12:54:54 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] NFS: invalidate i_blocks after COMMIT to fix stale block
 count on NFSv4
To: Trond Myklebust <trondmy@kernel.org>, anna@kernel.org,
 linux-nfs@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, joseph.qi@linux.alibaba.com,
 linux-xfs@vger.kernel.org
References: <20260622060038.13731-1-jefflexu@linux.alibaba.com>
 <2d09ab9a74d1eb21c99454dba8be597612d20efa.camel@kernel.org>
 <71d4ac02-d760-49ab-a01c-e7d1a6662a18@linux.alibaba.com>
 <2098148dfb9e156dd88242afecdea5d372b7a169.camel@kernel.org>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <2098148dfb9e156dd88242afecdea5d372b7a169.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-12.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	WHITELIST_SPF_DKIM(-3.00)[alibaba.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:trondmy@kernel.org,m:anna@kernel.org,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:joseph.qi@linux.alibaba.com,m:linux-xfs@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jefflexu@linux.alibaba.com,linux-nfs@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22776-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jefflexu@linux.alibaba.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,linux.alibaba.com:dkim,linux.alibaba.com:mid,linux.alibaba.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E280F6B40B2



On 6/23/26 12:51 PM, Trond Myklebust wrote:
> On Tue, 2026-06-23 at 12:04 +0800, Jingbo Xu wrote:
> 
>> +cc [linux-xfs@vger.kernel.org](mailto:linux-xfs@vger.kernel.org)
>>
>> On 6/22/26 9:56 PM, Trond Myklebust wrote:
>>
>>> On Mon, 2026-06-22 at 14:00 +0800, Jingbo Xu wrote:
>>>
>>>> NFSv4 COMMIT compound does not include GETATTR, and
>>>> nfs4_commit_done_cb
>>>> does not refresh inode attributes. Meanwhile, every WRITE marks
>>>> NFS_INO_INVALID_BLOCKS via nfs_post_op_update_inode_force_wcc_locked.
>>>>
>>>> After COMMIT, i_blocks remains stale until the next stat() triggers a
>>>> full revalidation. In writeback-heavy workloads where COMMITs happen
>>>> without intervening stat() calls, the cached block count can stay
>>>> indefinitely wrong.
>>>>
>>>> Mark NFS_INO_INVALID_BLOCKS on successful COMMIT completion so that
>>>> the
>>>> next nfs_getattr requesting STATX_BLOCKS will issue a GETATTR with
>>>> SPACE_USED, fetching the correct value from the server.
>>>>
>>>> This matches NFSv3 behavior where nfs3_commit_done already calls
>>>> nfs_refresh_inode with the wcc_data post-op attributes.
>>>>
>>>> Reproduce with xfstests generic/694 on NFSv4.0 loopback:
>>>>
>>>>   Server:
>>>>     mount /dev/vdc /data/test
>>>>     mount /dev/vdd /data/scratch
>>>>     exportfs -o insecure,rw,sync,no_root_squash,fsid=1
>>>> 127.0.0.1:/data/test
>>>>     exportfs -o insecure,rw,sync,no_root_squash,fsid=2
>>>> 127.0.0.1:/data/scratch
>>>>
>>>>   Client:
>>>>     mount -t nfs -o vers=4.0 localhost:/data/test /mnt/test
>>>>     mount -t nfs -o vers=4.0 localhost:/data/scratch /mnt/scratch
>>>>
>>>>   local.config:
>>>>     export TEST_FS_MOUNT_OPTS="-o vers=4.0"
>>>>     export MOUNT_OPTIONS="-o vers=4.0"
>>>>     export FSTYP=nfs
>>>>     export TEST_DEV=localhost:/data/test
>>>>     export SCRATCH_DEV=localhost:/data/scratch
>>>>     export TEST_DIR=/mnt/test
>>>>     export SCRATCH_MNT=/mnt/scratch
>>>>
>>>> This fixes xfstests generic/694.
>>>>
>>>> Assisted-by: Qoder:Qwen3.7-Max
>>>> Signed-off-by: Jingbo Xu <[jefflexu@linux.alibaba.com](mailto:jefflexu@linux.alibaba.com)>
>>>> ---
>>>>  fs/nfs/write.c | 2 ++
>>>>  1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/fs/nfs/write.c b/fs/nfs/write.c
>>>> index d7c399763ad9..88c5c9f7434c 100644
>>>> --- a/fs/nfs/write.c
>>>> +++ b/fs/nfs/write.c
>>>> @@ -1851,6 +1851,8 @@ static void nfs_commit_release_pages(struct
>>>> nfs_commit_data *data)
>>>>  		/* Latency breaker */
>>>>  		cond_resched();
>>>>  	}
>>>> +	if (status >= 0)
>>>> +		nfs_set_cache_invalid(data->inode,
>>>> NFS_INO_INVALID_BLOCKS);
>>>>  
>>>>  	nfs_init_cinfo(&cinfo, data->inode, data->dreq);
>>>>  	nfs_commit_end(cinfo.mds);
>>>
>>>
>>> That sounds like an XFS bug, not an NFS bug. COMMIT isn't changing the
>>> data contents of the file: it is just ensuring that the existing data
>>> is persisted onto disk.
>>>
>>
>>
>> Yes the underlying backend filesystem is indeed xfs.
>>
>> I retest it and can confirm that this failure is much likely
>> reproducible on NFS upon XFS, while NFS upon EXT4 succeeds for 50
>> consecutive test runs.
>>
>> Beside XFS itself also passes the test.
>>
>>
>> To be honest I'm not familiar with NFS, following is what AI concludes:
>>
>> ```
>> Root Cause Timing Sequence: NFSv4.0 Stale i_blocks After syncfs
>>
>>
>>    Client issues multiple UNSTABLE WRITEs — each WRITE compound includes
>> a piggy-backed GETATTR that returns the server's current SPACE_USED. The
>> client updates inode->i_blocks from the last completed WRITE's post-op
>> attributes.
>>
>>    Server-side delayed allocation — the export's local filesystem
>> (ext4/xfs) uses delayed allocation. Metadata blocks (indirect blocks /
>> extent tree nodes) are not yet allocated during most WRITE handling;
>> they materialize only when the local fs performs its own writeback.
>>
>>    Last WRITE completes before server metadata writeback (~80%
>> probability in user's environment) — the final GETATTR returns
>> SPACE_USED = 8388608 (data only, no metadata block). Client caches
>> i_blocks = 8388608.
>>
>>    syncfs triggers COMMIT — nfs_write_inode(WB_SYNC_ALL) calls
>> __nfs_commit_inode, which sends a COMMIT RPC to the server.
>>    Server executes vfs_fsync_range — this forces the local fs writeback,
>> which now allocates the metadata block. Server's true SPACE_USED becomes
>> 8388616 (+8 sectors = 4 KiB).
>>
>>    COMMIT response carries no file attributes — per RFC 7530 §16.3.3,
>> COMMIT4resok contains only a write verifier. The XDR decoder
>> (nfs4_xdr_dec_commit) never calls decode_getfattr.
>>
>>    nfs_commit_release_pages performs no attribute invalidation — it
>> neither sends a follow-up GETATTR nor marks NFS_INO_INVALID_BLOCKS. The
>> stale cached value persists.
>>
>>    Subsequent stat returns stale i_blocks — cache_validity is clean, so
>> nfs_getattr serves the cached value 8388608 without revalidation.
>>
>>    After cycle_mount, fresh GETATTR returns 8388616 — mismatch detected,
>> test fails.
>> ```
>>
> 
> 
> I agree with your AI that this may indeed be a consequence of XFS's delayed allocation feature. However that hardly changes the fact that it would be a violation of the POSIX rules for how write(), fsync() and stat() are supposed to work in this situation.
> 
> My point is that I fail to see why we should degrade the performance of the generic NFS client in order to address a bug in one of the back end filesystems (in this case XFS) being exported.
> 

Understand.  Just have no idea which is the proper way to fix this.


-- 
Thanks,
Jingbo


