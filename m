Return-Path: <linux-nfs+bounces-19898-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aLvtJRwYr2nHNgIAu9opvQ
	(envelope-from <linux-nfs+bounces-19898-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 09 Mar 2026 19:57:32 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F8223F025
	for <lists+linux-nfs@lfdr.de>; Mon, 09 Mar 2026 19:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A3694301134E
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Mar 2026 18:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C973ED5AB;
	Mon,  9 Mar 2026 18:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=schu.net header.i=schu@schu.net header.b="ND7v+M7x"
X-Original-To: linux-nfs@vger.kernel.org
Received: from ssl.schu.net (ssl.schu.net [136.143.158.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC8F3ED11C
	for <linux-nfs@vger.kernel.org>; Mon,  9 Mar 2026 18:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.143.158.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773082649; cv=none; b=RMIUL9bMOi885+Qsni8+r1A0EyJlzvzL9C2LMrrHSZ4NFl4NPCYwapKsfcLaBcQwNRq4cjwwhGP1jTht5dYBIWtcqxAmDxnUvvBz5p1krshrg0amx5m84BQ61Ulp1Yb0A7fXsRniUVgjrS8jagpgvqbUGJlO42UeUrrH3hmtrhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773082649; c=relaxed/simple;
	bh=B7KAMARPwEaCd5USio6/S7xKwQ9/OKzi8sUBysxym6o=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Gn8ytq5C6ZaCB01Fb4s7RLSrcld+Wc49WGxSPoX+jEMAg7rxiQ1gO+leHi/++9tclhAzXHBPlcIaW/v+IzcCcKkPTpdDlfgqL/CE4Pd0qoiBZJETGpt5HDWJEJbHv0F8mQYdfRH4hoezjlCEKHGLdkz6ihighkpSt6afJwmnKX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schu.net; spf=pass smtp.mailfrom=schu.net; dkim=pass (2048-bit key) header.d=schu.net header.i=schu@schu.net header.b=ND7v+M7x; arc=none smtp.client-ip=136.143.158.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schu.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schu.net
Received: from [192.168.120.145] (2-97-186-64.aptalaska.net [64.186.97.2])
	(authenticated bits=0)
	by ssl.schu.net (8.15.2/8.15.2) with ESMTPSA id 629IvBUI009288
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 9 Mar 2026 11:57:11 -0700
Message-ID: <6214ba33-1ed3-4c8b-bba1-8d4894cb2dd1@schu.net>
Date: Mon, 9 Mar 2026 11:57:10 -0700
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Current state of nfsdv4 recovery.
To: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
References: <0d586513-819c-4af9-8c9f-8d09d326e547@schu.net>
 <1fcd27cb44217d5db08e488528a2648c2906a435.camel@kernel.org>
Content-Language: en-US
From: Matthew Schumacher <schu@schu.net>
In-Reply-To: <1fcd27cb44217d5db08e488528a2648c2906a435.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Report: Content analysis details:   (-2.5 points)
	pts  rule name              description
	---- ---------------------- -------------------------------------------
	-1.0 ALL_TRUSTED            Passed through trusted hosts only via SMTP
	-1.5 BAYES_00               BODY: Bayes spam probability is 0 to 1%
	                            [score: 0.0000]
X-Spam-Bayes: Learn: no autolearn_force=no
X-Spam-Score: No, -2.5 hits
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=schu.net; h=message-id
	:date:mime-version:subject:to:references:from:in-reply-to
	:content-type:content-transfer-encoding; s=schu; i=
	schu@schu.net; t=1773082632; bh=B7KAMARPwEaCd5USio6/S7xKwQ9/OKzi
	8sUBysxym6o=; b=ND7v+M7xUXwDgIQQACuRnoJqMsdi+q83HcS7DMVkatnGSuMG
	9tZlvN1er7BhwWhpWdXGXk6jkbi9FN9yynQIvK7w+Z8bC0OeHK3xdsAYC07FLVBP
	Fu44vkbzl6QzN624FhNKlSIbYT/axDwK+ceCDUin8k50+0OUG3McQLW1FCNzdDHd
	deV/3VT6ILbryMgquqWY45r8iRakWW3d2UGkV+1yTt4iUoQHaIOngmeO5zSRvEm9
	Fq4lR8362dz2xwKXNWYUZdb51qh4dxyiI4prtHrtdK9XNHDjGYeOWR6rUvWj5jb0
	2bvbLyj7u5LHwMEQk7kK5DVA5I5AnsPn9YJ32w==
X-Scanned-By: MIMEDefang 3.2 on 192.168.98.12
X-Rspamd-Queue-Id: 44F8223F025
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[schu.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[schu.net:s=schu];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19898-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[schu.net:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[schu@schu.net,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linux-nfs.org:url,schu.net:dkim,schu.net:mid]
X-Rspamd-Action: no action

On 3/6/26 12:49 PM, Jeff Layton wrote:
> On Fri, 2026-03-06 at 11:46 -0800, Matthew Schumacher wrote:
>> Hello List,
>>
>> I am building an HA nfsv4 cluster and need to have my locking migrate
>> when a node fails or goes into standby for maint.  There is a lot of
>> documentation around the net, but some of it seems old, like this:
>> https://wiki.linux-nfs.org/wiki/index.php/Nfsd4_server_recovery. I think
>> I have what I need worked out, but I'm still losing locks on recovery.
>> Can someone help me understand how this currently works or point me to
>> the up to date documentation?
>>
>> This is what I'm currently doing:
>>
>> Moving from nodeA to nodeB
>>
>> NodeA: Remove nfsd ip address
>> NodeA: /usr/sbin/exportfs -au
>> NodeA: /usr/sbin/rpc.nfsd 0
>> NodeA: killall --ns $$ -q -v -w rpc.mountd
>> NodeA: killall --ns $$ -q -v -w nfsdcld
>> NodeA: killall --ns $$ -q -v -w rpc.idmapd
>> NodeA: killall --ns $$ -q -v -w rpcbind
>> NodeA: umount /var/lib/nfs/rpc_pipefs
>> NodeA: zpool export (which umounts /var/lib/nfs)
>>
>> NodeB: zpool import (which mounts /var/lib/nfs)
>> NodeB: mount /proc/fs/nfs if not previously mounted
>> NodeB: mount -t rpc_pipefs -o nodev sunrpc /var/lib/nfs/rpc_pipefs
>> NodeB: /sbin/rpcbind -l -w
>> NodeB: /usr/sbin/rpc.idmapd
>> NodeB: /usr/sbin/nfsdcld -d
>> NodeB: /usr/sbin/exportfs -av
>> NodeB: /usr/sbin/rpc.mountd
>> NodeB: /usr/sbin/rpc.nfsd -s -V 4.2 -U -t 8
>> NodeB: start nfsd ip address
>>
>>   From what I understand, nfsdcld writes the lock information to
>> /var/lib/nfs/nfsdcltrack/main.sqlite which is moved to the other side
>> and everything is started, but I still lose locks when I migrate.
>>
>> Mar  6 08:39:14 nfsha user.warn kernel: [37675.787509] NFS:
>> 10.255.255.3: lost 1 locks
>>
>> I think the problem is that kernel (6.12.74) isn't getting the locks
>> reported to it when nfsdcld starts.  Here are some logs:
>>
<snip old logs>
>>
>> I think the problem is that nfsdcld can't pass the locks to the kernel
>> using /var/lib/nfs/rpc_pipefs/nfsd/cld as it's missing.  I'm not sure
>> why, /var/lib/nfs/rpc_pipefs/ has everything else:
>>
<snip old pipefs>
>>
> 
> That's very odd. You might want to look in dmesg and see if there are
> any warnings in there about creating the pipes in rpc_pipefs.
> 


Hello Jeff, others...
I did get nfsdcld to talk to the kernel, but I still lose my sessions 
when I move NFS from one node to another.  I wonder if my understanding 
is correct:

If I have /var/lib/nfs mounted, and nfsdcld running, then it should 
persist my sessions and locks to the main.sqlite database, then when I 
shut down nfsdcld, umount /var/lib/nfs, then mount /var/lib/nfs on a 
different node and start nfsdcld it should tell the kernel about my 
sessions and locks and everything keep working.

Is that correct?

Right now I see my client happily working with a session:

Mar  9 11:39:46 nodeA user.warn kernel: [245803.517797] encode_sequence: 
sessionid=1773078573:732586373:19:0 seqid=1939 slotid=0 max_slotid=0 
cache_this=0

Then when I move the NFS server to another node and assume the same IP 
address, the clients session is reset:

Mar  9 11:45:55 nodeA user.warn kernel: [246172.155392] 
nfs41_sequence_process ERROR: -10052 Reset session
Mar  9 11:45:55 nodeA user.warn kernel: [246172.155394] nfs4_free_slot: 
slotid 0 highest_used_slotid 4294967295
Mar  9 11:45:55 nodeA user.warn kernel: [246172.155396] 
nfs41_sequence_process: Error -10052 free the slot
Mar  9 11:45:55 nodeA user.warn kernel: [246172.155397] 
nfs41_sequence_call_done ERROR -10052
Mar  9 11:45:55 nodeA user.warn kernel: [246172.155397] 
nfs4_schedule_lease_recovery: scheduling lease recovery for server 
10.255.255.3
Mar  9 11:45:55 nodeA user.warn kernel: [246172.155411] 
nfs41_sequence_call_done rpc_cred 000000009fd26b60
Mar  9 11:45:55 nodeA user.warn kernel: [246172.155413] 
nfs4_schedule_state_renewal: requeueing work. Lease period = 5
Mar  9 11:45:55 nodeA user.warn kernel: [246172.155570] NFS: Got error 
-10052 from the server on DESTROY_SESSION. Session has been destroyed 
regardless...
Mar  9 11:45:55 nodeA user.warn kernel: [246172.155572] --> 
nfs4_proc_create_session clp=00000000ea3d2c57 session=00000000348f3ed3
Mar  9 11:45:55 nodeA user.warn kernel: [246172.155574] 
nfs4_init_channel_attrs: Fore Channel : max_rqst_sz=1049620 
max_resp_sz=1049480 max_ops=8 max_reqs=64
Mar  9 11:45:55 nodeA user.warn kernel: [246172.155576] 
nfs4_init_channel_attrs: Back Channel : max_rqst_sz=4096 
max_resp_sz=4096 max_resp_sz_cached=0 max_ops=2 max_reqs=16
Mar  9 11:45:55 nodeA user.warn kernel: [246172.155732] 
nfs4_reset_session: session reset failed with status -10022 for server 
10.255.255.3!
Mar  9 11:45:55 nodeA user.warn kernel: [246172.155734] 
nfs4_handle_reclaim_lease_error: handled error -10022 for server 
10.255.255.3
Mar  9 11:45:55 nodeA user.warn kernel: [246172.155946] 
_nfs4_proc_exchange_id: server_scope mismatch detected
Mar  9 11:45:55 nodeA user.warn kernel: [246172.193390] NFS: 
10.255.255.3: lost 1 locks


On the server side I see:

Mar  9 11:45:05 nodeB daemon.notice rpc.mountd[26917]: Version 2.8.5 
starting
Mar  9 11:45:05 nodeB daemon.info nfsdcld[26920]: 
sqlite_startup_query_grace: current_epoch=6 recovery_epoch=0
Mar  9 11:45:05 nodeB daemon.info nfsdcld[26920]: 
sqlite_check_db_health: returning 0
Mar  9 11:45:05 nodeB daemon.info nfsdcld[26920]: cld_pipe_init: init 
pipe handlers
Mar  9 11:45:05 nodeB daemon.info nfsdcld[26920]: cld_pipe_open: opening 
upcall pipe /var/lib/nfs/rpc_pipefs/nfsd/cld
Mar  9 11:45:05 nodeB daemon.info nfsdcld[26920]: cld_pipe_open: open of 
/var/lib/nfs/rpc_pipefs/nfsd/cld failed: No such file or directory
Mar  9 11:45:05 nodeB daemon.info nfsdcld[26920]: main: Starting event 
dispatch handler.
Mar  9 11:45:05 nodeB user.warn kernel: [246116.696423] set_max_drc 
nfsd_drc_max_mem 259694592
Mar  9 11:45:05 nodeB daemon.info nfsdcld[26920]: cld_inotify_cb: called 
for EV_READ
Mar  9 11:45:05 nodeB daemon.info nfsdcld[26920]: cld_pipe_open: opening 
upcall pipe /var/lib/nfs/rpc_pipefs/nfsd/cld
Mar  9 11:45:05 nodeB user.warn kernel: [246116.697573] nfsd: creating 
service
Mar  9 11:45:05 nodeB daemon.info nfsdcld[26920]: cld_get_version: 
version = 2.
Mar  9 11:45:05 nodeB daemon.info nfsdcld[26920]: Doing downcall with 
status 0
Mar  9 11:45:05 nodeB daemon.info nfsdcld[26920]: cld_gracestart: 
updating grace epochs
Mar  9 11:45:05 nodeB user.warn kernel: [246116.801997] 
alloc_cld_upcall: allocated xid 0
Mar  9 11:45:05 nodeB user.warn kernel: [246116.802105] 
nfsd4_cld_get_version: userspace returned version 2
Mar  9 11:45:05 nodeB user.warn kernel: [246116.802107] 
alloc_cld_upcall: allocated xid 1
Mar  9 11:45:05 nodeB daemon.info nfsdcld[26920]: sqlite_grace_start: 
current_epoch=7 recovery_epoch=6
Mar  9 11:45:05 nodeB daemon.info nfsdcld[26920]: cld_gracestart: 
sending client records to the kernel
Mar  9 11:45:05 nodeB daemon.info nfsdcld[26920]: Sending client Linux 
NFSv4.2 nodeA
Mar  9 11:45:05 nodeB daemon.info nfsdcld[26920]: Doing downcall with 
status 0
Mar  9 11:45:05 nodeB user.info kernel: [246117.076010] NFSD: Using 
nfsdcld client tracking operations.
Mar  9 11:45:05 nodeB user.info kernel: [246117.076012] NFSD: starting 
90-second grace period (net f0000000)
Mar  9 11:45:55 nodeB user.warn kernel: [246167.001121] 
__find_in_sessionid_hashtbl: 1773078573:732586373:19:0
Mar  9 11:45:55 nodeB user.warn kernel: [246167.001124] 
__find_in_sessionid_hashtbl: session not found
Mar  9 11:45:55 nodeB user.warn kernel: [246167.001460] 
nfsd4_destroy_session: 1773078573:732586373:19:0
Mar  9 11:45:55 nodeB user.warn kernel: [246167.001463] 
__find_in_sessionid_hashtbl: 1773078573:732586373:19:0
Mar  9 11:45:55 nodeB user.warn kernel: [246167.001464] 
__find_in_sessionid_hashtbl: session not found
Mar  9 11:45:55 nodeB daemon.notice rpc.mountd[26917]: v4.2 client 
attached: 0x5f2a885f69af1531 from "10.255.255.1:39802"
Mar  9 11:45:55 nodeB user.warn kernel: [246167.001785] 
nfsd4_exchange_id rqstp=00000000c4f6faf6 exid=00000000ac47a836 
clname.len=32 clname.data=00000000c870e87d ip_addr=10.255.255.1 flags 
103, spa_how 0
Mar  9 11:45:55 nodeB user.warn kernel: [246167.001797] 
nfsd4_exchange_id seqid 0 flags 20001
Mar  9 11:45:55 nodeB daemon.info nfsdcld[26920]: cld_create: create 
client record.
Mar  9 11:45:55 nodeB user.warn kernel: [246167.003796] 
__find_in_sessionid_hashtbl: 1773081905:1596622943:23:0
Mar  9 11:45:55 nodeB user.warn kernel: [246167.003798] nfsd4_sequence: 
slotid 0
Mar  9 11:45:55 nodeB user.warn kernel: [246167.004116] found domain 
10.255.255.0/24
Mar  9 11:45:55 nodeB user.warn kernel: [246167.004118] found fsidtype 1
Mar  9 11:45:55 nodeB user.warn kernel: [246167.004119] found fsid length 4
Mar  9 11:45:55 nodeB user.warn kernel: [246167.004120] Path seems to be </>
Mar  9 11:45:55 nodeB user.warn kernel: [246167.004121] Found the path /
Mar  9 11:45:55 nodeB user.warn kernel: [246167.004190] nfsd: 
fh_compose(exp 00:12/1 /, ino=1)
Mar  9 11:45:55 nodeB user.warn kernel: [246167.004209] --> 
nfsd4_store_cache_entry slot 00000000640dc198
Mar  9 11:45:55 nodeB user.warn kernel: [246167.004464] 
__find_in_sessionid_hashtbl: 1773081905:1596622943:23:0
Mar  9 11:45:55 nodeB user.warn kernel: [246167.004466] nfsd4_sequence: 
slotid 0
Mar  9 11:45:55 nodeB user.warn kernel: [246167.004468] 
alloc_cld_upcall: allocated xid 2
Mar  9 11:45:55 nodeB daemon.info nfsdcld[26920]: 
sqlite_insert_client_and_princhash: returning 0
Mar  9 11:45:55 nodeB daemon.info nfsdcld[26920]: Doing downcall with 
status 0
Mar  9 11:45:55 nodeB daemon.info nfsdcld[26920]: cld_gracedone: grace done.

When the session is reset and the lock lost my VM no longer performs I/O 
until it's restarted.

Should my locks and sessions be moving over or am I missing something?

Thanks!


