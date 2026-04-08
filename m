Return-Path: <linux-nfs+bounces-20749-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CBFBMvle1mkfEwgAu9opvQ
	(envelope-from <linux-nfs+bounces-20749-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Apr 2026 15:58:17 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE003BD47F
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Apr 2026 15:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 58A09306F315
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Apr 2026 13:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1CB3D16EB;
	Wed,  8 Apr 2026 13:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GAAizi1K"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2932B2F3C3E;
	Wed,  8 Apr 2026 13:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775656669; cv=none; b=dwkkOKeKH3FKQtF33QPepJvKo2Fu4cdSNyowCBCF3wXsjlTZP/GjeISe36r0N5N+VrgFysHotA0yJ4Ai0WDPloVk5tJlJ4bfKH5Bzp3hvsSy1rBeFKsOv0ncbW9TF67kiUpdbwmPZUbotvFMfRJE+tqjsQih5dkza7UhZ0JDIws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775656669; c=relaxed/simple;
	bh=eVLjjD6NucLNM3IgqTfynPd8YU5hJYehqJ+FFbdw5Ss=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jJ289ijXwBmw7mtt39CuOOJv4ca0ca407vBKLRlPlFftHeZGtaAc/wiaNA6ROoRvhIzL4WF7mLLRqgNrSuEAJrOvn+u8c+5zpBrAdTjnYwphF12E3/uq0czTf+Not1enn8CNsRYBg9t1kgtldulONn+CZ8AzHxIOxxA6r04wvWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GAAizi1K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AF8BC19421;
	Wed,  8 Apr 2026 13:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775656668;
	bh=eVLjjD6NucLNM3IgqTfynPd8YU5hJYehqJ+FFbdw5Ss=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GAAizi1KTZck9qInqh6aW4v3LHFVnwqvhDLriVZHouBEPAlGm8noYsNACTTlLqZFn
	 M7MBkLT8GF9FoZ+pMWaFvQcE23GFVAqJZInx2GmhqkTzU1eoWbUfxrOtpnVa1Thf3S
	 XNd+Us5mIrJx9Ty44f2+f6Fa+oPyR6Q44CdWuvUo9bfiVzw0V8gobeUMo/jkXkSShT
	 nbZSBnb5Pc6E9XB2VizjQv1oP2waJAwb3LvlypL/TKbNt8gSaHpHNlSxCB34HtXPmP
	 xtZxzxOditT9lnqezOaUg1oThUHj8OugCiIybDvy4JwcKWaHtQ/NHQyyqpa6dC2fbi
	 s7UAI3VhzVtoA==
Message-ID: <2126005f-a8fa-4178-a675-e4b3d573c3fd@kernel.org>
Date: Wed, 8 Apr 2026 09:57:47 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/9] Automatic NFSv4 state revocation on filesystem
 unmount
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Chuck Lever <chuck.lever@oracle.com>
References: <20260408-umount-kills-nfsv4-state-v8-0-6e02a1d03d60@oracle.com>
 <ef770368759936131b2224a7d31eaf1f59272c6f.camel@kernel.org>
From: Chuck Lever <cel@kernel.org>
Content-Language: en-US
Organization: kernel.org
In-Reply-To: <ef770368759936131b2224a7d31eaf1f59272c6f.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20749-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3CE003BD47F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/8/26 9:56 AM, Jeff Layton wrote:
> nit: subject is a little misleading. You're not doing this on unmount
> anymore, but rather when unexporting.

The Subject: matches what I used on the v1 posting. But you're correct,
the mission of this patch series has changed.


> On Wed, 2026-04-08 at 08:29 -0400, Chuck Lever wrote:
>> When an NFS server exports a filesystem and clients hold NFSv4
>> state (opens, locks, delegations), unmounting the underlying
>> filesystem fails with EBUSY. The /proc/fs/nfsd/unlock_ip and
>> /proc/fs/nfsd/unlock_fs procfs interfaces handle this, but have
>> no netlink equivalents, and unlock_fs operates at whole-superblock
>> granularity.
>>
>> This series adds three new NFSD netlink commands, each with its own
>> attribute set:
>>
>>  - NFSD_CMD_UNLOCK_IP releases NLM locks held by a client IP
>>    address. Netlink equivalent of write_unlock_ip.
>>
>>  - NFSD_CMD_UNLOCK_FILESYSTEM revokes all NFS state on a
>>    superblock. Netlink equivalent of write_unlock_fs.
>>
>>  - NFSD_CMD_UNLOCK_EXPORT revokes NFSv4 state acquired through
>>    exports of a specific path, regardless of client.
>>
>> UNLOCK_FILESYSTEM and UNLOCK_EXPORT serve different intents.
>> UNLOCK_FILESYSTEM means "unmounting /data, release everything
>> on this superblock." UNLOCK_EXPORT means "no clients remain for
>> /data/projectA, release only the state acquired through exports
>> of that path." Userspace (exportfs -u) sends UNLOCK_EXPORT after
>> removing the last client for a given path, enabling the underlying
>> filesystem to be unmounted.
>>
>> The path-only design for UNLOCK_EXPORT avoids the auth_domain
>> naming complexity (use_ipaddr vs hostname-based domains) by not
>> requiring the caller to identify a specific client. Since this
>> mechanism is to be used to enable umount, this seemed like a
>> reasonable compromise.
>>
>> ---
>> Changes since v7:
>> - Rebase on Jeff's mountd netlink patches
>> - Fix pre-existing state revocation bugs
>>
>> Changes since v6:
>> - Send the complete series (v5 was missing patches 6 and 7)
>>
>> Changes since v5:
>> - Rename state_lock => nn->deleg_lock
>>
>> Changes since v4:
>> - 1/9 has been queued in nfsd-testing
>> - Split single NFSD_CMD_UNLOCK into three separate commands
>> - UNLOCK_EXPORT takes path only, no client attribute to avoid
>>   auth_domain naming complexity with use_ipaddr
>>
>> Changes since v3:
>> - All VFS changes replaced with new netlink "unlock" operation
>>
>> Changes since v2:
>> - Replace fs_pin with an SRCU umount notifier chain in VFS
>> - Merge the pending COPY cancellation patch
>> - Replace xa_cmpxchg() with xa_insert()
>> - Use cancel_work_sync() instead of flush_workqueue()
>> - Remove rcu_barrier()
>> - Correct misleading claims in kdoc comments and commit messages
>>
>> Changes since v1:
>> - Explain why drop_client() is being renamed
>> - Finish implementing revocation on umount
>> - Rename pin_insert_group
>> - Clarified log output and code comments
>> - Hold nfsd_mutex while closing nfsd_files
>>
>> ---
>> Chuck Lever (9):
>>       NFSD: Fix infinite loop in layout state revocation
>>       NFSD: Handle layout stid in nfsd4_drop_revoked_stid()
>>       NFSD: Extract revoke_one_stid() utility function
>>       NFSD: Add NFSD_CMD_UNLOCK_IP netlink command
>>       NFSD: Add NFSD_CMD_UNLOCK_FILESYSTEM netlink command
>>       NFSD: Replace idr_for_each_entry_ul in find_one_sb_stid()
>>       NFSD: Track svc_export in nfs4_stid
>>       NFSD: Add NFSD_CMD_UNLOCK_EXPORT netlink command
>>       NFSD: Close cached file handles when revoking export state
>>
>>  Documentation/netlink/specs/nfsd.yaml |  61 +++++++++
>>  fs/nfsd/filecache.c                   |  46 +++++++
>>  fs/nfsd/filecache.h                   |   1 +
>>  fs/nfsd/netlink.c                     |  36 +++++
>>  fs/nfsd/netlink.h                     |   3 +
>>  fs/nfsd/nfs4layouts.c                 |   2 +
>>  fs/nfsd/nfs4state.c                   | 240 ++++++++++++++++++++++++----------
>>  fs/nfsd/nfsctl.c                      | 126 +++++++++++++++++-
>>  fs/nfsd/state.h                       |   6 +
>>  fs/nfsd/trace.h                       |  32 ++++-
>>  include/uapi/linux/nfsd_netlink.h     |  24 ++++
>>  11 files changed, 498 insertions(+), 79 deletions(-)
>> ---
>> base-commit: b495a392b2748dca31d2a4b404632c6f907aa136
>> change-id: 20260318-umount-kills-nfsv4-state-138218f2f4e0
>>
>> Best regards,
>> --  
>> Chuck Lever
> 


-- 
Chuck Lever

