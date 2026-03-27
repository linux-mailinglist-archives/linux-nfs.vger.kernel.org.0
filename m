Return-Path: <linux-nfs+bounces-20458-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QBU1L3mGxmlALQUAu9opvQ
	(envelope-from <linux-nfs+bounces-20458-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Mar 2026 14:30:33 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2332F3453EA
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Mar 2026 14:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E953F30136A1
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Mar 2026 13:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 275D73E9F7A;
	Fri, 27 Mar 2026 13:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CPTsuhK1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DC83E9295;
	Fri, 27 Mar 2026 13:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774618183; cv=none; b=CRZCdTBnksJ8p/4iW37kM9IerEK0dNxVZhVlcb6XaqHD0LNsU7l5CdRSY6KguqROtkUQHDVQYvAt2xQIb8CaFNFXH5sNCpwAKZPer7DN6xTNgwCIYjt2AdTff9BUeOUybv8BZ2nokBLEIlp/Y2bdeivBRA/R1q2aZaSDQMUM0X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774618183; c=relaxed/simple;
	bh=LYzfOk2ppMdF00L+G44VOZTOfJhMm8f9vTuYA/zHiXM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QXxNvEN+Onn6ChoFhxqiGjOYet6AnZYAa3E65MR+P4PeNBPJkQdbN/nlYUuHZB39lMP+DYN5cT6qPO+yznhwU3g23MgDVHUVMyUGIUTMY7zME7WvCluE1xREiAnGNFHzOh6Uu8WR9wQ/qDEv5oMagR49dZ5APxTOMBUhn/CIa9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CPTsuhK1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F04ABC19423;
	Fri, 27 Mar 2026 13:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774618182;
	bh=LYzfOk2ppMdF00L+G44VOZTOfJhMm8f9vTuYA/zHiXM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CPTsuhK1PkBHmo3XQXJ0Bp6Ki8BsZ3aYrROnURnpOtbOhIzTHaCUpxypx5/o9L6/g
	 95q9IGeQPplHab9/dpfa3iO2ML93VWPl5XpHSqe2q4B/cbh1jw6aR+tp2Agbj7M8RM
	 MBLn0w+bwcub40IDqYkzQcUbFFwRoDnnzvPdbrhpU4IdqrC727NVPIc5Sh7xp0flzg
	 LbSz6LZJLjvdk6zP4ndjND75+NzOJLRHNRLe4HuGBWmPSV9zYBnWrCvYb4uRk8XJgY
	 caBJ5+vqkNdpdM57PS9XassbEqLYjK062KNQoC+GajEJA9YGD7dF/MQGpfSkd1s6RS
	 PMhRfgXCOieWg==
Message-ID: <68739c85-3964-4cee-aea5-cb625be42caf@kernel.org>
Date: Fri, 27 Mar 2026 09:29:40 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/7] Automatic NFSv4 state revocation on filesystem
 unmount
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Chuck Lever <chuck.lever@oracle.com>
References: <20260326-umount-kills-nfsv4-state-v5-0-d2ce071b3570@oracle.com>
 <5a77934e46108731495207230f51445ec07ac08c.camel@kernel.org>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <5a77934e46108731495207230f51445ec07ac08c.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20458-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2332F3453EA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/27/26 8:03 AM, Jeff Layton wrote:
> On Thu, 2026-03-26 at 13:55 -0400, Chuck Lever wrote:
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
> 
> Can you comment a bit about your intentions with userland here? Do you
> plan to extend nfsdctl to add this support or add a new binary to nfs-
> utils? Do you have userland patches or is that still TBD?

I have a version of exportfs that performs the netlink UNLOCK command as
part of unexporting. There are some conditions where it skips this; for
example, when unexporting all before a shutdown, otherwise state
recovery doesn't work.

These new UNLOCK commands stand alone as a feature, even though they are
not the full solution for addressing the unmounting failure after an
export, so I didn't post the exportfs patch this time. I'm sure there
are some details about that logic/policy that will need more debate.

Someone could add the UNLOCK commands to nfsdctl, but that isn't a
requirement for this work.


>> ---
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
>> Chuck Lever (7):
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
>>  fs/nfsd/netlink.c                     |  36 ++++++
>>  fs/nfsd/netlink.h                     |   3 +
>>  fs/nfsd/nfs4layouts.c                 |   2 +
>>  fs/nfsd/nfs4state.c                   | 226 +++++++++++++++++++++++-----------
>>  fs/nfsd/nfsctl.c                      | 126 ++++++++++++++++++-
>>  fs/nfsd/state.h                       |   6 +
>>  fs/nfsd/trace.h                       |  32 ++++-
>>  include/uapi/linux/nfsd_netlink.h     |  24 ++++
>>  11 files changed, 484 insertions(+), 79 deletions(-)
>> ---
>> base-commit: 65058e9e9b20619f920397f529072e853dd43811
>> change-id: 20260318-umount-kills-nfsv4-state-138218f2f4e0
>>
>> Best regards,
>> --  
>> Chuck Lever
> 


-- 
Chuck Lever

