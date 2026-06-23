Return-Path: <linux-nfs+bounces-22790-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3IukNtuMOmrP/gcAu9opvQ
	(envelope-from <linux-nfs+bounces-22790-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jun 2026 15:40:43 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A6B6B7845
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jun 2026 15:40:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=VsIUO+OV;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22790-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22790-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 00D51303C16D
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jun 2026 13:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598D122E3F0;
	Tue, 23 Jun 2026 13:40:42 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A591E37C923
	for <linux-nfs@vger.kernel.org>; Tue, 23 Jun 2026 13:40:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782222042; cv=none; b=BtMQq4OmN9OgGCvmagha/Ycb5jwrBk7BcqIncJjO2VzHlCegb6/ej/uV7JQCEUEwtME1lwYITkjcu1VJ7LLfrT7XdupkI1UjqcQZexbz9k/3dxY1RAK0j5O9YmC0jIyVFZo2I0u6ROqQfrboIXCy9w442TJrHZiF37q3KrIwenY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782222042; c=relaxed/simple;
	bh=+y8e9NimRMjpo7356N7egKZZhctvy+JRoTz8abIb8o0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X3zyIE2Q9vxRoP+IplKv0+BHZHpK68TMSYv6C8BLWxu8D+bysyM6ikIIYMkTgc10PqBMZArX1RZ9kyCYV7XdsWNtEVeEqRCHCUs8dhrU2p4aq4wv9XXvHotYeUvzX4QGR57sk7/EC4WEkeJNxVTdtJyPCMpcwqb+rW+57iyggq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VsIUO+OV; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782222038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=epYrm0WZ/LZwpjAO25dZiA5wCMeVac8DJdD354sTpOM=;
	b=VsIUO+OVOrlUixC5VgbhzWYA/giW8RalzAenPgTXJ8CqxC1dcD87jZjp7IXm3e6xVjj7Lp
	euCwSJ0mUVIw2jKiskifkfhlyPZLHc79FzCl+1JpfZJMlWKx11dxzvOu8nF+3yJ+dpR5vr
	ap3KQ/KghW98tf8GsUSFz4EiH/BwaaM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-41-aJGEi20qNouKXtrirJLvzQ-1; Tue,
 23 Jun 2026 09:40:33 -0400
X-MC-Unique: aJGEi20qNouKXtrirJLvzQ-1
X-Mimecast-MFC-AGG-ID: aJGEi20qNouKXtrirJLvzQ_1782222031
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2CC1319540D6;
	Tue, 23 Jun 2026 13:40:31 +0000 (UTC)
Received: from bfoster (unknown [10.22.88.75])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C994A1955F73;
	Tue, 23 Jun 2026 13:40:29 +0000 (UTC)
Date: Tue, 23 Jun 2026 09:40:27 -0400
From: Brian Foster <bfoster@redhat.com>
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Cc: Trond Myklebust <trondmy@kernel.org>, anna@kernel.org,
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	joseph.qi@linux.alibaba.com, linux-xfs@vger.kernel.org
Subject: Re: [PATCH] NFS: invalidate i_blocks after COMMIT to fix stale block
 count on NFSv4
Message-ID: <ajqMy2kusx1CETBX@bfoster>
References: <20260622060038.13731-1-jefflexu@linux.alibaba.com>
 <2d09ab9a74d1eb21c99454dba8be597612d20efa.camel@kernel.org>
 <71d4ac02-d760-49ab-a01c-e7d1a6662a18@linux.alibaba.com>
 <2098148dfb9e156dd88242afecdea5d372b7a169.camel@kernel.org>
 <c0bbe0c0-2b6f-47d9-8f45-b16bb455a089@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c0bbe0c0-2b6f-47d9-8f45-b16bb455a089@linux.alibaba.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22790-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jefflexu@linux.alibaba.com,m:trondmy@kernel.org,m:anna@kernel.org,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:joseph.qi@linux.alibaba.com,m:linux-xfs@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[bfoster@redhat.com,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bfoster@redhat.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 87A6B6B7845

On Tue, Jun 23, 2026 at 12:54:54PM +0800, Jingbo Xu wrote:
> 
> 
> On 6/23/26 12:51 PM, Trond Myklebust wrote:
> > On Tue, 2026-06-23 at 12:04 +0800, Jingbo Xu wrote:
> > 
> >> +cc [linux-xfs@vger.kernel.org](mailto:linux-xfs@vger.kernel.org)
> >>
> >> On 6/22/26 9:56 PM, Trond Myklebust wrote:
> >>
> >>> On Mon, 2026-06-22 at 14:00 +0800, Jingbo Xu wrote:
> >>>
> >>>> NFSv4 COMMIT compound does not include GETATTR, and
> >>>> nfs4_commit_done_cb
> >>>> does not refresh inode attributes. Meanwhile, every WRITE marks
> >>>> NFS_INO_INVALID_BLOCKS via nfs_post_op_update_inode_force_wcc_locked.
> >>>>
> >>>> After COMMIT, i_blocks remains stale until the next stat() triggers a
> >>>> full revalidation. In writeback-heavy workloads where COMMITs happen
> >>>> without intervening stat() calls, the cached block count can stay
> >>>> indefinitely wrong.
> >>>>
> >>>> Mark NFS_INO_INVALID_BLOCKS on successful COMMIT completion so that
> >>>> the
> >>>> next nfs_getattr requesting STATX_BLOCKS will issue a GETATTR with
> >>>> SPACE_USED, fetching the correct value from the server.
> >>>>
> >>>> This matches NFSv3 behavior where nfs3_commit_done already calls
> >>>> nfs_refresh_inode with the wcc_data post-op attributes.
> >>>>
> >>>> Reproduce with xfstests generic/694 on NFSv4.0 loopback:
> >>>>
> >>>>   Server:
> >>>>     mount /dev/vdc /data/test
> >>>>     mount /dev/vdd /data/scratch
> >>>>     exportfs -o insecure,rw,sync,no_root_squash,fsid=1
> >>>> 127.0.0.1:/data/test
> >>>>     exportfs -o insecure,rw,sync,no_root_squash,fsid=2
> >>>> 127.0.0.1:/data/scratch
> >>>>
> >>>>   Client:
> >>>>     mount -t nfs -o vers=4.0 localhost:/data/test /mnt/test
> >>>>     mount -t nfs -o vers=4.0 localhost:/data/scratch /mnt/scratch
> >>>>
> >>>>   local.config:
> >>>>     export TEST_FS_MOUNT_OPTS="-o vers=4.0"
> >>>>     export MOUNT_OPTIONS="-o vers=4.0"
> >>>>     export FSTYP=nfs
> >>>>     export TEST_DEV=localhost:/data/test
> >>>>     export SCRATCH_DEV=localhost:/data/scratch
> >>>>     export TEST_DIR=/mnt/test
> >>>>     export SCRATCH_MNT=/mnt/scratch
> >>>>
> >>>> This fixes xfstests generic/694.
> >>>>
> >>>> Assisted-by: Qoder:Qwen3.7-Max
> >>>> Signed-off-by: Jingbo Xu <[jefflexu@linux.alibaba.com](mailto:jefflexu@linux.alibaba.com)>
> >>>> ---
> >>>>  fs/nfs/write.c | 2 ++
> >>>>  1 file changed, 2 insertions(+)
> >>>>
> >>>> diff --git a/fs/nfs/write.c b/fs/nfs/write.c
> >>>> index d7c399763ad9..88c5c9f7434c 100644
> >>>> --- a/fs/nfs/write.c
> >>>> +++ b/fs/nfs/write.c
> >>>> @@ -1851,6 +1851,8 @@ static void nfs_commit_release_pages(struct
> >>>> nfs_commit_data *data)
> >>>>  		/* Latency breaker */
> >>>>  		cond_resched();
> >>>>  	}
> >>>> +	if (status >= 0)
> >>>> +		nfs_set_cache_invalid(data->inode,
> >>>> NFS_INO_INVALID_BLOCKS);
> >>>>  
> >>>>  	nfs_init_cinfo(&cinfo, data->inode, data->dreq);
> >>>>  	nfs_commit_end(cinfo.mds);
> >>>
> >>>
> >>> That sounds like an XFS bug, not an NFS bug. COMMIT isn't changing the
> >>> data contents of the file: it is just ensuring that the existing data
> >>> is persisted onto disk.
> >>>
> >>
> >>
> >> Yes the underlying backend filesystem is indeed xfs.
> >>
> >> I retest it and can confirm that this failure is much likely
> >> reproducible on NFS upon XFS, while NFS upon EXT4 succeeds for 50
> >> consecutive test runs.
> >>
> >> Beside XFS itself also passes the test.
> >>
> >>
> >> To be honest I'm not familiar with NFS, following is what AI concludes:
> >>
> >> ```
> >> Root Cause Timing Sequence: NFSv4.0 Stale i_blocks After syncfs
> >>
> >>
> >>    Client issues multiple UNSTABLE WRITEs — each WRITE compound includes
> >> a piggy-backed GETATTR that returns the server's current SPACE_USED. The
> >> client updates inode->i_blocks from the last completed WRITE's post-op
> >> attributes.
> >>
> >>    Server-side delayed allocation — the export's local filesystem
> >> (ext4/xfs) uses delayed allocation. Metadata blocks (indirect blocks /
> >> extent tree nodes) are not yet allocated during most WRITE handling;
> >> they materialize only when the local fs performs its own writeback.
> >>
> >>    Last WRITE completes before server metadata writeback (~80%
> >> probability in user's environment) — the final GETATTR returns
> >> SPACE_USED = 8388608 (data only, no metadata block). Client caches
> >> i_blocks = 8388608.
> >>
> >>    syncfs triggers COMMIT — nfs_write_inode(WB_SYNC_ALL) calls
> >> __nfs_commit_inode, which sends a COMMIT RPC to the server.
> >>    Server executes vfs_fsync_range — this forces the local fs writeback,
> >> which now allocates the metadata block. Server's true SPACE_USED becomes
> >> 8388616 (+8 sectors = 4 KiB).
> >>
> >>    COMMIT response carries no file attributes — per RFC 7530 §16.3.3,
> >> COMMIT4resok contains only a write verifier. The XDR decoder
> >> (nfs4_xdr_dec_commit) never calls decode_getfattr.
> >>
> >>    nfs_commit_release_pages performs no attribute invalidation — it
> >> neither sends a follow-up GETATTR nor marks NFS_INO_INVALID_BLOCKS. The
> >> stale cached value persists.
> >>
> >>    Subsequent stat returns stale i_blocks — cache_validity is clean, so
> >> nfs_getattr serves the cached value 8388608 without revalidation.
> >>
> >>    After cycle_mount, fresh GETATTR returns 8388616 — mismatch detected,
> >> test fails.
> >> ```
> >>
> > 
> > 
> > I agree with your AI that this may indeed be a consequence of XFS's delayed allocation feature. However that hardly changes the fact that it would be a violation of the POSIX rules for how write(), fsync() and stat() are supposed to work in this situation.
> > 
> > My point is that I fail to see why we should degrade the performance of the generic NFS client in order to address a bug in one of the back end filesystems (in this case XFS) being exported.
> > 
> 

Is the implication here that st_blocks changing across an fsync is a
POSIX violation? If so, can you clarify where that is said? My
understanding is that the rules/definitions here are rather vague and
st_blocks is a simple count of blocks allocated to the inode (i.e., so
this is ambiguous wrt delalloc, metadata blocks, etc.), but I could be
missing something.

> Understand.  Just have no idea which is the proper way to fix this.
> 

If I follow the above sequence correctly, the behavior being reported is
basically that NFS submits a write and caches a post-op block count on
the way out, a commit/fsync completes and doesn't update the block count
on the client, but XFS actually changes the block count during the fsync
due to a metadata (presumably bmap btree) block allocation on writeback
and delalloc conversion.

generic/694 basically does a sync -> sample inode block count -> mount
cycle -> resample and compare test, and then fails if the samples don't
match across the mount cycle. This presumably fails on NFS due to the
block count caching above. I.e., the post-fsync sample returns the
pre-fsync cached value and thus implies the value has changed purely
across the mount cycle, right?

A couple things to note here.. g/694 can either use falloc to create the
file or fall back to buffered write if falloc fails. Is that a factor
going through NFS in this case (i.e. fallocate is not supported)? Also
it looks like the sync was added to the test to explicitly address this
sort of problem in other cases.

It feels a little odd to me to call this an fs bug, tbh. The intent of
the test seems more to catch an incorrect block count calculation as
opposed to enforce any sort of caching or accounting rules. The test may
or may not even perform writes, after all. It seems more like the issue
is just that the fsync that was added for consistency at the fs level is
not sufficient for NFS due to this attribute caching.

Is this actually a problem for NFS in practice or will it eventually get
the latest value from the server? If the latter, maybe the test simply
needs to be fixed up or skipped for NFS..?

Brian

> 
> -- 
> Thanks,
> Jingbo
> 
> 


