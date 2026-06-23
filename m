Return-Path: <linux-nfs+bounces-22774-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id diTaNRcGOmrr0AcAu9opvQ
	(envelope-from <linux-nfs+bounces-22774-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jun 2026 06:05:43 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 376246B3F1C
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jun 2026 06:05:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b=QtCL8OW7;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22774-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22774-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A59EB304DB98
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jun 2026 04:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261BF395AE2;
	Tue, 23 Jun 2026 04:04:45 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B3339022B;
	Tue, 23 Jun 2026 04:04:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782187485; cv=none; b=uFnxxRe6tfe38/NcVWNXKSUrZIi1ZyvY8zacmgW3JGGsJSQXxQ4eF+Md5Fj8x6g5rwakcbHH/SaZt0ADbEnaGiCZk6aQIg2KYFK4n+VpntN5Nghdots5+I2xVUTzAgMA3BVoOpYwG5K3KTMOaf4DJpA3hYukDI9UhZ9c3HV/IA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782187485; c=relaxed/simple;
	bh=36HmSz0nfuCjvaQ0XW7BUfHd8BrN+aGz2B0yqJ07nPM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mE2dh1UnGj6F61rj8ubquN+/zHvAOui8JLKfNfHluy3lu3vyKJKh1oTTHWWgamuNys/ro8vmb8KKr2NY9sJdbJhZfOkw0X1PmOfwt6JvIgjSD+v+ecB83jNGPt8uWFQNR5sI1E1p830jCD5So81dlwqNkregQ4DSLGblgR/Qppo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=QtCL8OW7; arc=none smtp.client-ip=115.124.30.133
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1782187479; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=yqkrfYs2jEBOpbs4UxnwxjJjFItCcyIqQyhy6JXkNqo=;
	b=QtCL8OW7CBNpYOtuz4nKXwJXrI03v/F8fG+EBIpPP9AM/BRzbxh3jKASW8u2mpeJLTNVd+R0o3AvgIssu+xlnlTu+FvM2kKVnaovMnZFc3cxOIw70c/zor3UmPc5JS4+H2pnH3unaSbVkHzRdI+Ys7zPpD9j7uTKFZE4DCnFW4I=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R921e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0X5SkNzW_1782187478;
Received: from 30.120.78.16(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0X5SkNzW_1782187478 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 23 Jun 2026 12:04:38 +0800
Message-ID: <71d4ac02-d760-49ab-a01c-e7d1a6662a18@linux.alibaba.com>
Date: Tue, 23 Jun 2026 12:04:35 +0800
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
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <2d09ab9a74d1eb21c99454dba8be597612d20efa.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-12.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	WHITELIST_SPF_DKIM(-3.00)[alibaba.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
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
	TAGGED_FROM(0.00)[bounces-22774-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jefflexu@linux.alibaba.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.alibaba.com:dkim,linux.alibaba.com:mid,linux.alibaba.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 376246B3F1C

+cc linux-xfs@vger.kernel.org

On 6/22/26 9:56 PM, Trond Myklebust wrote:
> On Mon, 2026-06-22 at 14:00 +0800, Jingbo Xu wrote:
>> NFSv4 COMMIT compound does not include GETATTR, and
>> nfs4_commit_done_cb
>> does not refresh inode attributes. Meanwhile, every WRITE marks
>> NFS_INO_INVALID_BLOCKS via nfs_post_op_update_inode_force_wcc_locked.
>>
>> After COMMIT, i_blocks remains stale until the next stat() triggers a
>> full revalidation. In writeback-heavy workloads where COMMITs happen
>> without intervening stat() calls, the cached block count can stay
>> indefinitely wrong.
>>
>> Mark NFS_INO_INVALID_BLOCKS on successful COMMIT completion so that
>> the
>> next nfs_getattr requesting STATX_BLOCKS will issue a GETATTR with
>> SPACE_USED, fetching the correct value from the server.
>>
>> This matches NFSv3 behavior where nfs3_commit_done already calls
>> nfs_refresh_inode with the wcc_data post-op attributes.
>>
>> Reproduce with xfstests generic/694 on NFSv4.0 loopback:
>>
>>   Server:
>>     mount /dev/vdc /data/test
>>     mount /dev/vdd /data/scratch
>>     exportfs -o insecure,rw,sync,no_root_squash,fsid=1
>> 127.0.0.1:/data/test
>>     exportfs -o insecure,rw,sync,no_root_squash,fsid=2
>> 127.0.0.1:/data/scratch
>>
>>   Client:
>>     mount -t nfs -o vers=4.0 localhost:/data/test /mnt/test
>>     mount -t nfs -o vers=4.0 localhost:/data/scratch /mnt/scratch
>>
>>   local.config:
>>     export TEST_FS_MOUNT_OPTS="-o vers=4.0"
>>     export MOUNT_OPTIONS="-o vers=4.0"
>>     export FSTYP=nfs
>>     export TEST_DEV=localhost:/data/test
>>     export SCRATCH_DEV=localhost:/data/scratch
>>     export TEST_DIR=/mnt/test
>>     export SCRATCH_MNT=/mnt/scratch
>>
>> This fixes xfstests generic/694.
>>
>> Assisted-by: Qoder:Qwen3.7-Max
>> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
>> ---
>>  fs/nfs/write.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/fs/nfs/write.c b/fs/nfs/write.c
>> index d7c399763ad9..88c5c9f7434c 100644
>> --- a/fs/nfs/write.c
>> +++ b/fs/nfs/write.c
>> @@ -1851,6 +1851,8 @@ static void nfs_commit_release_pages(struct
>> nfs_commit_data *data)
>>  		/* Latency breaker */
>>  		cond_resched();
>>  	}
>> +	if (status >= 0)
>> +		nfs_set_cache_invalid(data->inode,
>> NFS_INO_INVALID_BLOCKS);
>>  
>>  	nfs_init_cinfo(&cinfo, data->inode, data->dreq);
>>  	nfs_commit_end(cinfo.mds);
> 
> That sounds like an XFS bug, not an NFS bug. COMMIT isn't changing the
> data contents of the file: it is just ensuring that the existing data
> is persisted onto disk.
> 

Yes the underlying backend filesystem is indeed xfs.

I retest it and can confirm that this failure is much likely
reproducible on NFS upon XFS, while NFS upon EXT4 succeeds for 50
consecutive test runs.

Beside XFS itself also passes the test.


To be honest I'm not familiar with NFS, following is what AI concludes:

```
Root Cause Timing Sequence: NFSv4.0 Stale i_blocks After syncfs


   Client issues multiple UNSTABLE WRITEs — each WRITE compound includes
a piggy-backed GETATTR that returns the server's current SPACE_USED. The
client updates inode->i_blocks from the last completed WRITE's post-op
attributes.

   Server-side delayed allocation — the export's local filesystem
(ext4/xfs) uses delayed allocation. Metadata blocks (indirect blocks /
extent tree nodes) are not yet allocated during most WRITE handling;
they materialize only when the local fs performs its own writeback.

   Last WRITE completes before server metadata writeback (~80%
probability in user's environment) — the final GETATTR returns
SPACE_USED = 8388608 (data only, no metadata block). Client caches
i_blocks = 8388608.

   syncfs triggers COMMIT — nfs_write_inode(WB_SYNC_ALL) calls
__nfs_commit_inode, which sends a COMMIT RPC to the server.
   Server executes vfs_fsync_range — this forces the local fs writeback,
which now allocates the metadata block. Server's true SPACE_USED becomes
8388616 (+8 sectors = 4 KiB).

   COMMIT response carries no file attributes — per RFC 7530 §16.3.3,
COMMIT4resok contains only a write verifier. The XDR decoder
(nfs4_xdr_dec_commit) never calls decode_getfattr.

   nfs_commit_release_pages performs no attribute invalidation — it
neither sends a follow-up GETATTR nor marks NFS_INO_INVALID_BLOCKS. The
stale cached value persists.

   Subsequent stat returns stale i_blocks — cache_validity is clean, so
nfs_getattr serves the cached value 8388608 without revalidation.

   After cycle_mount, fresh GETATTR returns 8388616 — mismatch detected,
test fails.
```


-- 
Thanks,
Jingbo


