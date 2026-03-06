Return-Path: <linux-nfs+bounces-19859-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0MNtNaRfq2mmcQEAu9opvQ
	(envelope-from <linux-nfs+bounces-19859-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 07 Mar 2026 00:13:40 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A74E2288E0
	for <lists+linux-nfs@lfdr.de>; Sat, 07 Mar 2026 00:13:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 875E0300FEFD
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Mar 2026 23:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2047836998E;
	Fri,  6 Mar 2026 23:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=schu.net header.i=schu@schu.net header.b="O8JW2xjf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from ssl.schu.net (ssl.schu.net [136.143.158.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD20B34F479
	for <linux-nfs@vger.kernel.org>; Fri,  6 Mar 2026 23:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.143.158.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772838818; cv=none; b=cBs/Q+bkKpxQ1sL5TBbVQzjpsylShEDBX441xK1ll6KXmWHavgCoEFURx+CvxIkw2BBJKxpfs4MgluMLui+t1LNtE89qI2sX028z3uOf26KGCkOg/yKOhtB1oLJy9M8BQc+daDG7LKEiDYLIzziZggg78JXfQmddzhUutAVk1tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772838818; c=relaxed/simple;
	bh=aYNVaT+ciMchtOf+i3qomAq/5qA3k2fIDul1O538nL4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=r4NgFvRsQK95aqr9SsIm8A49Agu2LdiVQ3TQk/e/N43opkSZh1Ucg4iXcuDlIyjEk1PqGTSlyOWoqMaq8r/I73I7KNOZ5wZRO9IJ9/pZC6wapYEyqmeF38qPS0joMhdB7N0m+3VsZkmXFCW24adDfnoMBHf7y20N7AQuIPpdJN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schu.net; spf=pass smtp.mailfrom=schu.net; dkim=pass (2048-bit key) header.d=schu.net header.i=schu@schu.net header.b=O8JW2xjf; arc=none smtp.client-ip=136.143.158.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schu.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schu.net
Received: from [192.168.120.145] (2-97-186-64.aptalaska.net [64.186.97.2])
	(authenticated bits=0)
	by ssl.schu.net (8.15.2/8.15.2) with ESMTPSA id 626NDZBe002174
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO)
	for <linux-nfs@vger.kernel.org>; Fri, 6 Mar 2026 15:13:36 -0800
Message-ID: <816d2a4b-d8bf-4242-b774-94886967430e@schu.net>
Date: Fri, 6 Mar 2026 15:13:35 -0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Current state of nfsdv4 recovery.
To: linux-nfs@vger.kernel.org
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
	schu@schu.net; t=1772838816; bh=aYNVaT+ciMchtOf+i3qomAq/5qA3k2fI
	Dul1O538nL4=; b=O8JW2xjf3jfluj0ctXp5cjB8rng+12kLAvQCtpJAHbOjC2Cq
	/ofVuf/hTgnfT9NK0V5Hy0yCMpwJee66XO1Wgwyn7z+zYAPXxomfH/owrG2KN6II
	20aeTWboaBwCt0UhQZIngXQJB5sSUnuOKMY9rWERNbbdbUaL4/qJYtyGFaOHrAjb
	WhSN4ofR9YjuPjXVltdGufL15Y7l3oUE4UyTHtykCR/mnpC9qZ+mcb72akK5y+vS
	tNdHvXj7CLDD98IETKwSYBZ3l1lMdzbjfs0aouZDjGAI5dlooJ0o8zSreOVbcbKm
	M9K4QlGeXAW8zeR5W/IWtMkArs3jtaGpCISg+A==
X-Scanned-By: MIMEDefang 3.2 on 192.168.98.12
X-Rspamd-Queue-Id: 4A74E2288E0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[schu.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[schu.net:s=schu];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19859-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[schu.net:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[schu@schu.net,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.985];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,schu.net:dkim,schu.net:mid]
X-Rspamd-Action: no action



On 3/6/26 12:49 PM, Jeff Layton wrote:
> On Fri, 2026-03-06 at 11:46 -0800, Matthew Schumacher wrote:
<snip>
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
>> Mar  6 08:38:46 nfsha daemon.warn rpc.idmapd[14113]: Setting log level to 0
>> Mar  6 08:38:46 nfsha daemon.warn rpc.idmapd[14113]: libnfsidmap: Unable
>> to determine the NFSv4 domain; Using 'localdomain' as the NFSv4 domain
>> which means UIDs will be mapped to the 'Nobody-User' user defined in
>> /etc/idmapd.conf
>> Mar  6 08:38:46 nfsha daemon.info nfsdcld[14116]:
>> sqlite_startup_query_grace: current_epoch=2 recovery_epoch=1
>> Mar  6 08:38:46 nfsha daemon.info nfsdcld[14116]:
>> sqlite_check_db_health: returning 0
>> Mar  6 08:38:46 nfsha daemon.info nfsdcld[14116]: attaching
>> /var/lib/nfs/nfsdcltrack/main.sqlite
>> Mar  6 08:38:46 nfsha daemon.notice rpc.mountd[14125]: Version 2.8.5
>> starting
>> Mar  6 08:38:46 nfsha daemon.info nfsdcld[14116]: detaching database
>> Mar  6 08:38:46 nfsha daemon.info nfsdcld[14116]:
>> sqlite_copy_cltrack_records: returning 0
>> Mar  6 08:38:46 nfsha daemon.info nfsdcld[14116]: sqlite_prepare_dbh:
>> num_cltrack_records = 2
>> Mar  6 08:38:47 nfsha user.info kernel: [37649.053531] NFSD: Using UMH
>> upcall client tracking operations.
>> Mar  6 08:38:47 nfsha user.info kernel: [37649.055262] NFSD: Using UMH
>> upcall client tracking operations.
> 
> The kernel failed to recognize the cld upcall for some reason, so it
> fell back to running the usermodehelper upcall.
<snip>

Thanks for the reply, I figured out why /var/lib/nfs/rpc_pipefs/nfsd/cld 
was missing, I had CONFIG_NFSD_LEGACY_CLIENT_TRACKING enabled in the 
kernel.  Now that that is fixed, nfsv4 recovery seems to be working 
because I see it notifying the nfs clients and ending the grace period, 
but I'm still losing the lock.  Any idea why?  Or how to debug?

Mar  6 14:53:31 nfsha daemon.warn rpc.idmapd[3243]: Setting log level to 0
Mar  6 14:53:31 nfsha daemon.warn rpc.idmapd[3243]: libnfsidmap: Unable 
to determine the NFSv4 domain; Using 'localdomain' as the NFSv4 domain 
which means UIDs will be mapped to the 'Nobody-User' user defined in 
/etc/idmapd.conf
Mar  6 14:53:31 nfsha daemon.notice rpc.mountd[3252]: Version 2.8.5 starting
Mar  6 14:53:31 nfsha daemon.info nfsdcld[3254]: 
sqlite_startup_query_grace: current_epoch=5 recovery_epoch=0
Mar  6 14:53:31 nfsha daemon.info nfsdcld[3254]: sqlite_check_db_health: 
returning 0
Mar  6 14:53:31 nfsha daemon.info nfsdcld[3254]: cld_pipe_init: init 
pipe handlers
Mar  6 14:53:31 nfsha daemon.info nfsdcld[3254]: cld_pipe_open: opening 
upcall pipe /var/lib/nfs/rpc_pipefs/nfsd/cld
Mar  6 14:53:31 nfsha daemon.info nfsdcld[3254]: cld_pipe_open: open of 
/var/lib/nfs/rpc_pipefs/nfsd/cld failed: No such file or directory
Mar  6 14:53:31 nfsha daemon.info nfsdcld[3254]: main: Starting event 
dispatch handler.
Mar  6 14:53:31 nfsha daemon.info nfsdcld[3254]: cld_inotify_cb: called 
for EV_READ
Mar  6 14:53:31 nfsha daemon.info nfsdcld[3254]: cld_pipe_open: opening 
upcall pipe /var/lib/nfs/rpc_pipefs/nfsd/cld
Mar  6 14:53:31 nfsha daemon.info nfsdcld[3254]: cld_get_version: 
version = 2.
Mar  6 14:53:31 nfsha daemon.info nfsdcld[3254]: Doing downcall with 
status 0
Mar  6 14:53:31 nfsha daemon.info nfsdcld[3254]: cld_gracestart: 
updating grace epochs
Mar  6 14:53:31 nfsha daemon.info nfsdcld[3254]: sqlite_grace_start: 
current_epoch=6 recovery_epoch=5
Mar  6 14:53:31 nfsha daemon.info nfsdcld[3254]: cld_gracestart: sending 
client records to the kernel
Mar  6 14:53:31 nfsha daemon.info nfsdcld[3254]: Sending client Linux 
NFSv4.2 virttest-2
Mar  6 14:53:31 nfsha daemon.info nfsdcld[3254]: Sending client Linux 
NFSv4.2 virttest-1
Mar  6 14:53:31 nfsha daemon.info nfsdcld[3254]: Doing downcall with 
status 0
Mar  6 14:53:31 nfsha user.info kernel: [ 1831.162648] NFSD: Using 
nfsdcld client tracking operations.
Mar  6 14:53:31 nfsha user.info kernel: [ 1831.162651] NFSD: starting 
90-second grace period (net f0000000)
Mar  6 14:53:31 nfsha daemon.info IPaddr(failover-ip)[3283]: INFO: Using 
calculated netmask for 10.255.255.3: 255.255.255.0
Mar  6 14:53:31 nfsha daemon.info IPaddr(failover-ip)[3283]: INFO: eval 
ifconfig eth3:0 10.255.255.3 netmask 255.255.255.0 broadcast 10.255.255.255
Mar  6 14:53:34 nfsha daemon.notice rpc.mountd[3252]: v4.2 client 
attached: 0x2baa617369ab5aeb from "10.255.255.1:51662"
Mar  6 14:53:34 nfsha daemon.info nfsdcld[3254]: cld_create: create 
client record.
Mar  6 14:53:34 nfsha daemon.info nfsdcld[3254]: 
sqlite_insert_client_and_princhash: returning 0
Mar  6 14:53:34 nfsha daemon.info nfsdcld[3254]: Doing downcall with 
status 0
Mar  6 14:53:42 nfsha daemon.notice rpc.mountd[3252]: v4.2 client 
attached: 0x2baa617469ab5aeb from "10.255.255.2:53976"
Mar  6 14:53:42 nfsha daemon.info nfsdcld[3254]: cld_create: create 
client record.
Mar  6 14:53:42 nfsha daemon.info nfsdcld[3254]: 
sqlite_insert_client_and_princhash: returning 0
Mar  6 14:53:42 nfsha daemon.info nfsdcld[3254]: Doing downcall with 
status 0
Mar  6 14:53:42 nfsha daemon.info nfsdcld[3254]: cld_gracedone: grace done.
Mar  6 14:53:42 nfsha user.info kernel: [ 1842.038046] NFSD: all clients 
done reclaiming, ending NFSv4 grace period (net f0000000)
Mar  6 14:53:42 nfsha daemon.info nfsdcld[3254]: sqlite_grace_done: 
current_epoch=6 recovery_epoch=0
Mar  6 14:53:42 nfsha daemon.info nfsdcld[3254]: Doing downcall with 
status 0
Mar  6 14:53:48 nfsha user.warn kernel: [ 1847.336008] NFS: 
10.255.255.3: lost 1 locks

I'm mounting with:

mount -t nfs -o 
rw,sync,vers=4.2,hard,noresvport,proto=tcp,timeo=600,retrans=2 
10.255.255.3:/dev/datastore-stub /datastore


