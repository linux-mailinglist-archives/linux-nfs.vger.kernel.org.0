Return-Path: <linux-nfs+bounces-6643-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBBC8985E4F
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Sep 2024 15:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88312289E5E
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Sep 2024 13:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5EA417BEB3;
	Wed, 25 Sep 2024 12:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=flyingcircus.io header.i=@flyingcircus.io header.b="pyw3yG6j"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail.flyingcircus.io (mail.flyingcircus.io [212.122.41.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EE018CC0D;
	Wed, 25 Sep 2024 12:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.122.41.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266190; cv=none; b=GXAb6eor1Dzh1qVe3JVOILh53Nsnx4OQpMZ8TxFiHJawcHSIJ7cGz8JI2uzVFTMFT0nTEDLkoJPTBV/cJ3H5m0BrJsMiOgRY6MOhv0Bm83H5o0kX6iI761Q4gbSRDBJJVO/G0Fi8wnRRZklX+dxmhp+G6+lFs9MVIyA7dWIEuyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266190; c=relaxed/simple;
	bh=ya6fXFaj3s7GG/rMLvAoi7Q217bUupngsB/Jp1MGGzk=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=Qwg3dxrOo68z6dapfUPlxlfaSXAY03aD6T3ihHJYlPWqTAd18vtO1jgIUIUTfFU+E8piaHa/CjQRq/vbwUCIWIwblqsYM1ar9B11MIFSdkuc2OdCkIZS0c3etlBr6wQxCAvZ/uM31Xb6wMCgsSl9RXqM5+gZfi6K2eox+xM19xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=flyingcircus.io; spf=pass smtp.mailfrom=flyingcircus.io; dkim=pass (1024-bit key) header.d=flyingcircus.io header.i=@flyingcircus.io header.b=pyw3yG6j; arc=none smtp.client-ip=212.122.41.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=flyingcircus.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flyingcircus.io
From: Christian Theune <ct@flyingcircus.io>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flyingcircus.io;
	s=mail; t=1727266177;
	bh=2UZLjeem2hjmQMoIAa/d+WzWg7T0RCf5kbmB0Z2wzeY=;
	h=From:Subject:Date:Cc:To;
	b=pyw3yG6jyxzcKvAmmslIwW/VuWSWkFv3ks1P45Sch3uatceX4AJZCzxMc0xE1wxRP
	 MMClZsWu582ubfNDdBSwJa1pcOfkL7BjQwg2j945rdn74jTpPH37mPeYg1sVHcGmaa
	 F5AliTJ4SOJpm4h+tCtn9FOiym/LCc9umGIcRTZo=
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: nfsv41: stale file handles after VM shutdown/poweron - but works
 during warm reboot
Message-Id: <AFE3E539-B98A-465F-9860-EE142D00285F@flyingcircus.io>
Date: Wed, 25 Sep 2024 14:09:16 +0200
Cc: linux-nfs@vger.kernel.org,
 stable@vger.kernel.org,
 regressions@lists.linux.dev
To: chuck.lever@oracle.com,
 jlayton@kernel.org

Hi,

we're experiencing a weird NFS (client?) issue when we cold restart a =
Linux virtual
machine running an NFS server. The client will reconnect when the server =
comes back
but we end up with stale file handles and have to unmount/remount.

Initially I thought we did something stupid running the `soft` option =
and wanted
to convert to `hard,timeo=3D6,retrans=3D10` but noticed that our =
original problems
that caused me to investigate did not go away when changing the mount =
options.

The issue seems to be (surprisingly!) caused when restarting the NFS =
server VM
using a "cold boot" approach: calling shutdown and then having the VM =
started
with a fresh Qemu process. When restarting the NFS server VM using a =
warm
reboot we do not see stale file handles. This appears not to be a race
condition or timeouts happening as its reliably reproducable in either
direction - I've tried dozens of times and it always works with a reboot =
and
always ends up with stale file handles when shutting down/starting a =
fresh VM.

I've played around with shutting off the NFS server service and =
introducing
delays before cold and warm restarts but the symptoms remain the same.

I've tried reading through man pages, kernel documentation, and kernel =
code
but haven't found anything that points to me doing something wrong. The =
nfsd
and client settings are all at their defaults in /proc (at least I =
didn't
find any config management modifying them and peeking at a few of them =
they
ran at their defaults).

The issue can be observed on 5.15.164 as well as 6.11. We've been =
running
identical setups for many years and haven't observed this issue until a =
few
months ago. We=E2=80=99ve been running with 5.15 for a while now and I =
think this
might have been introduced somewhere along the way.

I've added the client side kernel traces here. Network traffic was not
enlightening.

I tried chopping the traces into parts that reflect what happens on the =
server.

Setup
=3D=3D=3D=3D=3D

Server and client are both Qemu/KVM VMs running NixOS with a (for =
practical
purposes) vanilla kernel (two one line patches that change the =
`bridge-stp` and
`request-key` helper paths).=20

Mount:

<server>:/srv/nfs/shared on /mnt/nfs/shared type nfs4 =
(rw,relatime,vers=3D4.2,rsize=3D8192,wsize=3D8192,namlen=3D255,hard,proto=3D=
tcp6,timeo=3D100,retrans=3D30,sec=3Dsys,clientaddr=3D<v6network>::1137,loc=
al_lock=3Dnone,addr=3D<v6network>::1136)

Export:

/srv/nfs/shared  <server>(rw,sync,root_squash,no_subtree_check) =
<client>(rw,sync,root_squash,no_subtree_check)


Case 1 (cold reboot - ends up broken)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

We're stopping the server, waiting for a bit and then poweroff. =
Basically:

server> systemctl stop nfs-server; sleep 30; poweroff

The poweroff causes the VM to be automatically restarted after a few =
seconds
with a fresh Qemu process - but with all identical settings from the =
previous
instance.

The client sees the following rpc and nfs trace:

server> systemctl stop nfs-server

client kernel log>
[ 4965.503048] RPC:       xs_tcp_state_change client 000000004f6bb8b0...
[ 4965.503975] RPC:       state 8 conn 1 dead 0 zapped 1 sk_shutdown 1
[ 4965.505105] RPC:       xs_tcp_state_change client 000000004f6bb8b0...
[ 4965.505930] RPC:       state 9 conn 0 dead 0 zapped 1 sk_shutdown 3
[ 4965.506712] RPC:       xs_tcp_state_change client 000000004f6bb8b0...
[ 4965.507469] RPC:       state 7 conn 0 dead 0 zapped 1 sk_shutdown 3
[ 4965.508261] RPC:       xs_close xprt 000000004f6bb8b0
[ 4965.509108] RPC:       xs_tcp_state_change client 000000004f6bb8b0...
[ 4965.509916] RPC:       state 7 conn 0 dead 0 zapped 1 sk_shutdown 3

server> sleep 30

client kernel log>
[ 4998.558930] nfs4_renew_state: start
[ 4998.559497] <-- nfs41_proc_async_sequence status=3D0
[ 4998.560074] nfs4_renew_state: done
[ 4998.560473] --> nfs4_alloc_slot used_slots=3D0000 =
highest_used=3D4294967295 max_slots=3D30
[ 4998.561379] <-- nfs4_alloc_slot used_slots=3D0001 highest_used=3D0 =
slotid=3D0
[ 4998.562442] encode_sequence: sessionid=3D1727262693:2026340752:2:0 =
seqid=3D47 slotid=3D0 max_slotid=3D0 cache_this=3D0
[ 4998.563650] RPC:       xs_connect scheduled xprt 000000004f6bb8b0
[ 4998.564385] RPC:       xs_bind =
0000:0000:0000:0000:0000:0000:0000:0000:788: ok (0)
[ 4998.565372] RPC:       worker connecting xprt 000000004f6bb8b0 via =
tcp to <v6network>::1136 (port 2049)
[ 4998.566606] RPC:       000000004f6bb8b0 connect status 115 connected =
0 sock state 2
[ 4998.567594] RPC:       xs_tcp_state_change client 000000004f6bb8b0...
[ 4998.567596] RPC:       state 7 conn 0 dead 0 zapped 1 sk_shutdown 3
[ 4998.567600] RPC:       xs_error_report client 000000004f6bb8b0, =
error=3D111...
[ 4998.569979] RPC:       xs_close xprt 000000004f6bb8b0
[ 4998.570565] RPC:       xs_tcp_state_change client 000000004f6bb8b0...
[ 4998.571276] RPC:       state 7 conn 0 dead 0 zapped 1 sk_shutdown 3
[ 5001.630875] RPC:       xs_connect scheduled xprt 000000004f6bb8b0
[ 5001.631969] RPC:       xs_bind =
0000:0000:0000:0000:0000:0000:0000:0000:745: ok (0)
[ 5001.632890] RPC:       worker connecting xprt 000000004f6bb8b0 via =
tcp to <v6network>::1136 (port 2049)
[ 5001.634262] RPC:       000000004f6bb8b0 connect status 115 connected =
0 sock state 2
[ 5001.635306] RPC:       xs_tcp_state_change client 000000004f6bb8b0...
[ 5001.635308] RPC:       state 7 conn 0 dead 0 zapped 1 sk_shutdown 3
[ 5001.635312] RPC:       xs_error_report client 000000004f6bb8b0, =
error=3D111...
[ 5001.637871] RPC:       xs_close xprt 000000004f6bb8b0
[ 5001.638465] RPC:       xs_tcp_state_change client 000000004f6bb8b0...
[ 5001.639237] RPC:       state 7 conn 0 dead 0 zapped 1 sk_shutdown 3
[ 5004.702871] RPC:       xs_connect scheduled xprt 000000004f6bb8b0
[ 5004.703851] RPC:       xs_bind =
0000:0000:0000:0000:0000:0000:0000:0000:1012: ok (0)
[ 5004.704995] RPC:       worker connecting xprt 000000004f6bb8b0 via =
tcp to <v6network>::1136 (port 2049)
[ 5004.706752] RPC:       000000004f6bb8b0 connect status 115 connected =
0 sock state 2
[ 5004.708103] RPC:       xs_tcp_state_change client 000000004f6bb8b0...
[ 5004.708106] RPC:       state 7 conn 0 dead 0 zapped 1 sk_shutdown 3
[ 5004.708110] RPC:       xs_error_report client 000000004f6bb8b0, =
error=3D111...
[ 5004.711656] RPC:       xs_close xprt 000000004f6bb8b0
[ 5004.712489] RPC:       xs_tcp_state_change client 000000004f6bb8b0...
[ 5004.713521] RPC:       state 7 conn 0 dead 0 zapped 1 sk_shutdown 3
[ 5007.774811] RPC:       xs_connect scheduled xprt 000000004f6bb8b0
[ 5007.775819] RPC:       xs_bind =
0000:0000:0000:0000:0000:0000:0000:0000:811: ok (0)
[ 5007.776749] RPC:       worker connecting xprt 000000004f6bb8b0 via =
tcp to <v6network>::1136 (port 2049)
[ 5007.778362] RPC:       000000004f6bb8b0 connect status 115 connected =
0 sock state 2
[ 5007.779413] RPC:       xs_tcp_state_change client 000000004f6bb8b0...
[ 5007.779416] RPC:       state 7 conn 0 dead 0 zapped 1 sk_shutdown 3
[ 5007.779420] RPC:       xs_error_report client 000000004f6bb8b0, =
error=3D111...
[ 5007.782197] RPC:       xs_close xprt 000000004f6bb8b0
[ 5007.782884] RPC:       xs_tcp_state_change client 000000004f6bb8b0...
[ 5007.783757] RPC:       state 7 conn 0 dead 0 zapped 1 sk_shutdown 3
[ 5010.846776] RPC:       xs_connect scheduled xprt 000000004f6bb8b0
[ 5010.847884] RPC:       xs_bind =
0000:0000:0000:0000:0000:0000:0000:0000:920: ok (0)
[ 5010.848923] RPC:       worker connecting xprt 000000004f6bb8b0 via =
tcp to <v6network>::1136 (port 2049)
[ 5010.850346] RPC:       000000004f6bb8b0 connect status 115 connected =
0 sock state 2
[ 5010.851478] RPC:       xs_tcp_state_change client 000000004f6bb8b0...
[ 5010.851480] RPC:       state 7 conn 0 dead 0 zapped 1 sk_shutdown 3
[ 5010.851484] RPC:       xs_error_report client 000000004f6bb8b0, =
error=3D111...
[ 5010.854398] RPC:       xs_close xprt 000000004f6bb8b0
[ 5010.855067] RPC:       xs_tcp_state_change client 000000004f6bb8b0...
[ 5010.855829] RPC:       state 7 conn 0 dead 0 zapped 1 sk_shutdown 3
[ 5013.918740] RPC:       xs_connect scheduled xprt 000000004f6bb8b0
[ 5013.919802] RPC:       xs_bind =
0000:0000:0000:0000:0000:0000:0000:0000:691: ok (0)
[ 5013.920747] RPC:       worker connecting xprt 000000004f6bb8b0 via =
tcp to <v6network>::1136 (port 2049)
[ 5013.922364] RPC:       000000004f6bb8b0 connect status 115 connected =
0 sock state 2

server> poweroff

(server powers off and gets restarted)

client kernel log>

[ 5082.014329] RPC:       xs_tcp_state_change client 000000004f6bb8b0...
[ 5082.015431] RPC:       state 1 conn 0 dead 0 zapped 1 sk_shutdown 0
[ 5082.016693] RPC:       xs_tcp_send_request(116) =3D 0
[ 5082.032137] nfs41_sequence_process ERROR: -10052 Reset session
[ 5082.033051] nfs4_free_slot: slotid 0 highest_used_slotid 4294967295
[ 5082.033883] nfs41_sequence_process: Error -10052 free the slot
[ 5082.034713] nfs41_sequence_call_done ERROR -10052
[ 5082.035406] nfs4_schedule_lease_recovery: scheduling lease recovery =
for server <server>
[ 5082.036710] nfs41_sequence_call_done rpc_cred 000000001946c07d
[ 5082.037565] RPC:       xs_tcp_send_request(100) =3D 0
[ 5082.038660] NFS: Got error -10052 from the server on DESTROY_SESSION. =
Session has been destroyed regardless...
[ 5082.040040] --> nfs4_proc_create_session clp=3D00000000872dbfe2 =
session=3D00000000b29d3016
[ 5082.041071] nfs4_init_channel_attrs: Fore Channel : =
max_rqst_sz=3D1049620 max_resp_sz=3D1049480 max_ops=3D8 max_reqs=3D64
[ 5082.042467] nfs4_init_channel_attrs: Back Channel : max_rqst_sz=3D4096 =
max_resp_sz=3D4096 max_resp_sz_cached=3D0 max_ops=3D2 max_reqs=3D16
[ 5082.044069] nfs4_schedule_state_renewal: requeueing work. Lease =
period =3D 5
[ 5082.045066] RPC:       xs_tcp_send_request(196) =3D 0
[ 5082.046099] nfs4_reset_session: session reset failed with status =
-10022 for server <server>!
[ 5082.047361] nfs4_handle_reclaim_lease_error: handled error -10022 for =
server <server>
[ 5082.048601] RPC:       xs_tcp_send_request(244) =3D 0
[ 5082.049712] --> nfs4_proc_create_session clp=3D00000000872dbfe2 =
session=3D00000000b29d3016
[ 5082.050852] nfs4_init_channel_attrs: Fore Channel : =
max_rqst_sz=3D1049620 max_resp_sz=3D1049480 max_ops=3D8 max_reqs=3D64
[ 5082.052201] nfs4_init_channel_attrs: Back Channel : max_rqst_sz=3D4096 =
max_resp_sz=3D4096 max_resp_sz_cached=3D0 max_ops=3D2 max_reqs=3D16
[ 5082.053763] RPC:       xs_tcp_send_request(196) =3D 0
[ 5082.055159] --> nfs4_setup_session_slot_tables
[ 5082.055770] --> nfs4_realloc_slot_table: max_reqs=3D30, =
tbl->max_slots 30
[ 5082.056681] nfs4_realloc_slot_table: tbl=3D00000000cf1ff1fa =
slots=3D0000000002cd9cdc max_slots=3D30
[ 5082.057752] <-- nfs4_realloc_slot_table: return 0
[ 5082.058328] --> nfs4_realloc_slot_table: max_reqs=3D16, =
tbl->max_slots 16
[ 5082.059207] nfs4_realloc_slot_table: tbl=3D000000005982b642 =
slots=3D0000000017686be5 max_slots=3D16
[ 5082.060307] <-- nfs4_realloc_slot_table: return 0
[ 5082.060912] slot table setup returned 0
[ 5082.061403] nfs4_proc_create_session client>seqid 2 sessionid =
1727263096:1126483273:1:0
[ 5082.062737] --> nfs4_alloc_slot used_slots=3D0000 =
highest_used=3D4294967295 max_slots=3D30
[ 5082.063857] <-- nfs4_alloc_slot used_slots=3D0001 highest_used=3D0 =
slotid=3D0
[ 5082.064781] encode_sequence: sessionid=3D1727263096:1126483273:1:0 =
seqid=3D1 slotid=3D0 max_slotid=3D0 cache_this=3D0
[ 5082.066063] RPC:       xs_tcp_send_request(132) =3D 0
[ 5082.068110] decode_attr_lease_time: lease time=3D90
[ 5082.068780] decode_attr_maxfilesize: maxfilesize=3D0
[ 5082.069411] decode_attr_maxread: maxread=3D1024
[ 5082.070006] decode_attr_maxwrite: maxwrite=3D1024
[ 5082.070612] decode_attr_time_delta: time_delta=3D0 0
[ 5082.071227] decode_attr_pnfstype: bitmap is 0
[ 5082.071810] decode_attr_layout_blksize: bitmap is 0
[ 5082.072452] decode_attr_clone_blksize: bitmap is 0
[ 5082.073090] decode_attr_change_attr_type: bitmap is 0
[ 5082.073735] decode_attr_xattrsupport: XATTR support=3Dfalse
[ 5082.074414] decode_fsinfo: xdr returned 0!
[ 5082.075357] --> nfs4_alloc_slot used_slots=3D0001 highest_used=3D0 =
max_slots=3D30
[ 5082.076299] <-- nfs4_alloc_slot used_slots=3D0003 highest_used=3D1 =
slotid=3D1
[ 5082.077212] nfs4_free_slot: slotid 1 highest_used_slotid 0
[ 5082.077909] nfs41_sequence_process: Error 0 free the slot
[ 5082.078569] nfs4_free_slot: slotid 0 highest_used_slotid 4294967295
[ 5082.079571] nfs4_schedule_state_renewal: requeueing work. Lease =
period =3D 60
[ 5082.080520] --> nfs4_alloc_slot used_slots=3D0000 =
highest_used=3D4294967295 max_slots=3D30
[ 5082.081506] <-- nfs4_alloc_slot used_slots=3D0001 highest_used=3D0 =
slotid=3D0
[ 5082.082376] encode_sequence: sessionid=3D1727263096:1126483273:1:0 =
seqid=3D2 slotid=3D0 max_slotid=3D0 cache_this=3D0
[ 5082.083612] RPC:       xs_tcp_send_request(124) =3D 0
[ 5082.113634] --> nfs4_alloc_slot used_slots=3D0001 highest_used=3D0 =
max_slots=3D30
[ 5082.114614] <-- nfs4_alloc_slot used_slots=3D0003 highest_used=3D1 =
slotid=3D1
[ 5082.115482] nfs4_free_slot: slotid 1 highest_used_slotid 0
[ 5082.116142] nfs41_sequence_process: Error 0 free the slot
[ 5082.116772] nfs4_free_slot: slotid 0 highest_used_slotid 4294967295
[ 5082.117766] <-- nfs41_proc_reclaim_complete status=3D0
[ 5082.118379] --> nfs4_alloc_slot used_slots=3D0000 =
highest_used=3D4294967295 max_slots=3D16
[ 5082.119308] <-- nfs4_alloc_slot used_slots=3D0001 highest_used=3D0 =
slotid=3D0
[ 5082.120110] nfs4_free_slot: slotid 0 highest_used_slotid 4294967295
[ 5082.120805] --> nfs4_alloc_slot used_slots=3D0000 =
highest_used=3D4294967295 max_slots=3D30
[ 5082.121690] <-- nfs4_alloc_slot used_slots=3D0001 highest_used=3D0 =
slotid=3D0
[ 5082.122438] nfs4_free_slot: slotid 0 highest_used_slotid 4294967295

The client now shows the following error when trying to access files on =
the
NFS mountpoint (shared is a directory in /mnt/nfs that is the =
mountpoint):

client> ls /mnt/nfs/
ls: cannot access '/mnt/nfs/shared': Stale file handle
shared

While doing that, the client kernel log continues:

[ 5121.788081] NFS: nfs_weak_revalidate: inode 33681408 is valid
[ 5121.788941] NFS: revalidating (0:50/33681408)
[ 5121.789816] --> nfs41_call_sync_prepare data->seq_server =
00000000862cf9f3
[ 5121.790950] --> nfs4_alloc_slot used_slots=3D0000 =
highest_used=3D4294967295 max_slots=3D30
[ 5121.791958] <-- nfs4_alloc_slot used_slots=3D0001 highest_used=3D0 =
slotid=3D0
[ 5121.792904] encode_sequence: sessionid=3D1727263096:1126483273:1:0 =
seqid=3D3 slotid=3D0 max_slotid=3D0 cache_this=3D0
[ 5121.794289] RPC:       xs_tcp_send_request(172) =3D 0
[ 5121.799020] --> nfs4_alloc_slot used_slots=3D0001 highest_used=3D0 =
max_slots=3D30
[ 5121.800014] <-- nfs4_alloc_slot used_slots=3D0003 highest_used=3D1 =
slotid=3D1
[ 5121.800876] nfs4_free_slot: slotid 1 highest_used_slotid 0
[ 5121.801562] nfs41_sequence_process: Error 0 free the slot
[ 5121.802232] nfs4_free_slot: slotid 0 highest_used_slotid 4294967295
[ 5121.803240] nfs_revalidate_inode: (0:50/33681408) getattr failed, =
error=3D-116
[ 5121.804471] NFS: revalidating (0:50/33681408)
[ 5121.805080] --> nfs41_call_sync_prepare data->seq_server =
00000000862cf9f3
[ 5121.805968] --> nfs4_alloc_slot used_slots=3D0000 =
highest_used=3D4294967295 max_slots=3D30
[ 5121.806955] <-- nfs4_alloc_slot used_slots=3D0001 highest_used=3D0 =
slotid=3D0
[ 5121.807885] encode_sequence: sessionid=3D1727263096:1126483273:1:0 =
seqid=3D4 slotid=3D0 max_slotid=3D0 cache_this=3D0
[ 5121.809522] RPC:       xs_tcp_send_request(172) =3D 0
[ 5121.810845] --> nfs4_alloc_slot used_slots=3D0001 highest_used=3D0 =
max_slots=3D30
[ 5121.811864] <-- nfs4_alloc_slot used_slots=3D0003 highest_used=3D1 =
slotid=3D1
[ 5121.812791] nfs4_free_slot: slotid 1 highest_used_slotid 0
[ 5121.813501] nfs41_sequence_process: Error 0 free the slot
[ 5121.814207] nfs4_free_slot: slotid 0 highest_used_slotid 4294967295
[ 5121.815242] nfs_revalidate_inode: (0:50/33681408) getattr failed, =
error=3D-116
[ 5121.816279] NFS: nfs_weak_revalidate: inode 33681408 is invalid
[ 5121.817311] NFS: revalidating (0:50/33681408)
[ 5121.828500] NFS: nfs_weak_revalidate: inode 33681408 is invalid
[ 5146.013099] nfs4_renew_state: start
[ 5146.013647] nfs4_renew_state: failed to call renewd. Reason: lease =
not expired
[ 5146.014510] nfs4_schedule_state_renewal: requeueing work. Lease =
period =3D 36
[ 5146.015356] nfs4_renew_state: done
[ 5155.718411] NFS: nfs_weak_revalidate: inode 33681408 is valid
[ 5155.719976] NFS: revalidating (0:50/33681408)
[ 5155.720628] --> nfs41_call_sync_prepare data->seq_server =
00000000862cf9f3
[ 5155.721545] --> nfs4_alloc_slot used_slots=3D0000 =
highest_used=3D4294967295 max_slots=3D30
[ 5155.722519] <-- nfs4_alloc_slot used_slots=3D0001 highest_used=3D0 =
slotid=3D0
[ 5155.726973] encode_sequence: sessionid=3D1727263096:1126483273:1:0 =
seqid=3D6 slotid=3D0 max_slotid=3D0 cache_this=3D0
[ 5155.728990] RPC:       xs_tcp_send_request(172) =3D 0
[ 5155.731070] --> nfs4_alloc_slot used_slots=3D0001 highest_used=3D0 =
max_slots=3D30
[ 5155.732292] <-- nfs4_alloc_slot used_slots=3D0003 highest_used=3D1 =
slotid=3D1
[ 5155.733384] nfs4_free_slot: slotid 1 highest_used_slotid 0
[ 5155.734088] nfs41_sequence_process: Error 0 free the slot
[ 5155.734867] nfs4_free_slot: slotid 0 highest_used_slotid 4294967295
[ 5155.741211] nfs_revalidate_inode: (0:50/33681408) getattr failed, =
error=3D-116
[ 5155.742647] NFS: revalidating (0:50/33681408)
[ 5155.748003] --> nfs41_call_sync_prepare data->seq_server =
00000000862cf9f3
[ 5155.748977] --> nfs4_alloc_slot used_slots=3D0000 =
highest_used=3D4294967295 max_slots=3D30
[ 5155.750066] <-- nfs4_alloc_slot used_slots=3D0001 highest_used=3D0 =
slotid=3D0
[ 5155.754045] encode_sequence: sessionid=3D1727263096:1126483273:1:0 =
seqid=3D7 slotid=3D0 max_slotid=3D0 cache_this=3D0
[ 5155.757104] RPC:       xs_tcp_send_request(172) =3D 0
[ 5155.759310] --> nfs4_alloc_slot used_slots=3D0001 highest_used=3D0 =
max_slots=3D30
[ 5155.760383] <-- nfs4_alloc_slot used_slots=3D0003 highest_used=3D1 =
slotid=3D1
[ 5155.761233] nfs4_free_slot: slotid 1 highest_used_slotid 0
[ 5155.761870] nfs41_sequence_process: Error 0 free the slot
[ 5155.762585] nfs4_free_slot: slotid 0 highest_used_slotid 4294967295
[ 5155.768250] nfs_revalidate_inode: (0:50/33681408) getattr failed, =
error=3D-116
[ 5155.769224] NFS: nfs_weak_revalidate: inode 33681408 is invalid
[ 5155.771968] NFS: revalidating (0:50/33681408)
[ 5155.772574] --> nfs41_call_sync_prepare data->seq_server =
00000000862cf9f3
[ 5155.773522] --> nfs4_alloc_slot used_slots=3D0000 =
highest_used=3D4294967295 max_slots=3D30
[ 5155.774379] <-- nfs4_alloc_slot used_slots=3D0001 highest_used=3D0 =
slotid=3D0
[ 5155.779036] encode_sequence: sessionid=3D1727263096:1126483273:1:0 =
seqid=3D8 slotid=3D0 max_slotid=3D0 cache_this=3D0
[ 5155.780960] RPC:       xs_tcp_send_request(172) =3D 0
[ 5155.781797] --> nfs4_alloc_slot used_slots=3D0001 highest_used=3D0 =
max_slots=3D30
[ 5155.782721] <-- nfs4_alloc_slot used_slots=3D0003 highest_used=3D1 =
slotid=3D1
[ 5155.783734] nfs4_free_slot: slotid 1 highest_used_slotid 0
[ 5155.784485] nfs41_sequence_process: Error 0 free the slot
[ 5155.785084] nfs4_free_slot: slotid 0 highest_used_slotid 4294967295
[ 5155.789037] nfs_revalidate_inode: (0:50/33681408) getattr failed, =
error=3D-116
[ 5155.789873] NFS: nfs_weak_revalidate: inode 33681408 is invalid

Unmounting and remounting the mountpoint puts the client into a working =
state again.

Case 2 (ends up in a working state)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Here, we also shutdown the NFS server, wait for a bit, but then perform =
a "warm" reboot.

server> systemctl stop nfs-server ; sleep 30 seconds; reboot system

The individual steps as seen from the client:

server> systemctl stop nfs-server

client kernel log>
[ 5511.593152] RPC:       xs_tcp_state_change client 0000000005eb3fd3...
[ 5511.593997] RPC:       state 8 conn 1 dead 0 zapped 1 sk_shutdown 1
[ 5511.594763] RPC:       xs_tcp_state_change client 0000000005eb3fd3...
[ 5511.595581] RPC:       state 9 conn 0 dead 0 zapped 1 sk_shutdown 3
[ 5511.596371] RPC:       xs_tcp_state_change client 0000000005eb3fd3...
[ 5511.597131] RPC:       state 7 conn 0 dead 0 zapped 1 sk_shutdown 3
[ 5511.597957] RPC:       xs_close xprt 0000000005eb3fd3
[ 5511.599868] RPC:       xs_tcp_state_change client 0000000005eb3fd3...
[ 5511.600621] RPC:       state 7 conn 0 dead 0 zapped 1 sk_shutdown 3

server> sleep 30; reboot
[ 5526.935766] nfs4_renew_state: start
[ 5526.936259] nfs4_renew_state: failed to call renewd. Reason: lease =
not expired
[ 5526.937164] nfs4_schedule_state_renewal: requeueing work. Lease =
period =3D 36
[ 5526.938060] nfs4_renew_state: done
[ 5563.799229] nfs4_renew_state: start
[ 5563.799869] <-- nfs41_proc_async_sequence status=3D0
[ 5563.800512] nfs4_renew_state: done
[ 5563.800990] --> nfs4_alloc_slot used_slots=3D0000 =
highest_used=3D4294967295 max_slots=3D30
[ 5563.802030] <-- nfs4_alloc_slot used_slots=3D0001 highest_used=3D0 =
slotid=3D0
[ 5563.803244] encode_sequence: sessionid=3D1727263096:1126483275:2:0 =
seqid=3D43 slotid=3D0 max_slotid=3D0 cache_this=3D0
[ 5563.804487] RPC:       xs_connect scheduled xprt 0000000005eb3fd3
[ 5563.805269] RPC:       xs_bind =
0000:0000:0000:0000:0000:0000:0000:0000:914: ok (0)
[ 5563.806376] RPC:       worker connecting xprt 0000000005eb3fd3 via =
tcp to 2a02:238:f030:1c3::1136 (port 2049)
[ 5563.807676] RPC:       0000000005eb3fd3 connect status 115 connected =
0 sock state 2
[ 5578.071084] RPC:       xs_tcp_state_change client 0000000005eb3fd3...
[ 5578.072089] RPC:       state 7 conn 0 dead 0 zapped 1 sk_shutdown 3
[ 5578.072898] RPC:       xs_error_report client 0000000005eb3fd3, =
error=3D113...
[ 5578.074168] RPC:       xs_close xprt 0000000005eb3fd3
[ 5578.074806] RPC:       xs_tcp_state_change client 0000000005eb3fd3...
[ 5578.075629] RPC:       state 7 conn 0 dead 0 zapped 1 sk_shutdown 3
[ 5578.076533] RPC:       xs_connect scheduled xprt 0000000005eb3fd3
[ 5578.077353] RPC:       xs_bind =
0000:0000:0000:0000:0000:0000:0000:0000:791: ok (0)
[ 5578.078422] RPC:       worker connecting xprt 0000000005eb3fd3 via =
tcp to 2a02:238:f030:1c3::1136 (port 2049)
[ 5578.079767] RPC:       0000000005eb3fd3 connect status 115 connected =
0 sock state 2
[ 5581.143007] RPC:       xs_tcp_state_change client 0000000005eb3fd3...
[ 5581.144027] RPC:       state 7 conn 0 dead 0 zapped 1 sk_shutdown 3
[ 5581.144804] RPC:       xs_error_report client 0000000005eb3fd3, =
error=3D113...
[ 5581.146013] RPC:       xs_close xprt 0000000005eb3fd3
[ 5581.146667] RPC:       xs_tcp_state_change client 0000000005eb3fd3...
[ 5581.147475] RPC:       state 7 conn 0 dead 0 zapped 1 sk_shutdown 3
[ 5584.150918] RPC:       xs_connect scheduled xprt 0000000005eb3fd3
[ 5584.151952] RPC:       xs_bind =
0000:0000:0000:0000:0000:0000:0000:0000:842: ok (0)
[ 5584.153297] RPC:       worker connecting xprt 0000000005eb3fd3 via =
tcp to 2a02:238:f030:1c3::1136 (port 2049)
[ 5584.154840] RPC:       0000000005eb3fd3 connect status 115 connected =
0 sock state 2
[ 5587.223096] RPC:       xs_tcp_state_change client 0000000005eb3fd3...
[ 5587.224119] RPC:       state 7 conn 0 dead 0 zapped 1 sk_shutdown 3
[ 5587.224971] RPC:       xs_error_report client 0000000005eb3fd3, =
error=3D113...
[ 5587.226296] RPC:       xs_close xprt 0000000005eb3fd3
[ 5587.227011] RPC:       xs_tcp_state_change client 0000000005eb3fd3...
[ 5587.227878] RPC:       state 7 conn 0 dead 0 zapped 1 sk_shutdown 3
[ 5590.230822] RPC:       xs_connect scheduled xprt 0000000005eb3fd3
[ 5590.231841] RPC:       xs_bind =
0000:0000:0000:0000:0000:0000:0000:0000:893: ok (0)
[ 5590.232897] RPC:       worker connecting xprt 0000000005eb3fd3 via =
tcp to 2a02:238:f030:1c3::1136 (port 2049)
[ 5590.234566] RPC:       0000000005eb3fd3 connect status 115 connected =
0 sock state 2
[ 5593.302883] RPC:       xs_tcp_state_change client 0000000005eb3fd3...
[ 5593.303910] RPC:       state 7 conn 0 dead 0 zapped 1 sk_shutdown 3
[ 5593.304850] RPC:       xs_error_report client 0000000005eb3fd3, =
error=3D113...
[ 5593.306104] RPC:       xs_close xprt 0000000005eb3fd3
[ 5593.306799] RPC:       xs_tcp_state_change client 0000000005eb3fd3...
[ 5593.307585] RPC:       state 7 conn 0 dead 0 zapped 1 sk_shutdown 3
[ 5596.310840] RPC:       xs_connect scheduled xprt 0000000005eb3fd3
[ 5596.311711] RPC:       xs_bind =
0000:0000:0000:0000:0000:0000:0000:0000:925: ok (0)
[ 5596.312594] RPC:       worker connecting xprt 0000000005eb3fd3 via =
tcp to 2a02:238:f030:1c3::1136 (port 2049)
[ 5596.314192] RPC:       0000000005eb3fd3 connect status 115 connected =
0 sock state 2


The server is booting and the client recovers while logging this:


[ 5602.390691] RPC:       xs_connect scheduled xprt 0000000005eb3fd3
[ 5602.391719] RPC:       xs_bind =
0000:0000:0000:0000:0000:0000:0000:0000:980: ok (0)
[ 5602.392668] RPC:       worker connecting xprt 0000000005eb3fd3 via =
tcp to 2a02:238:f030:1c3::1136 (port 2049)
[ 5602.394223] RPC:       0000000005eb3fd3 connect status 115 connected =
0 sock state 2
[ 5605.462614] RPC:       xs_tcp_state_change client 0000000005eb3fd3...
[ 5605.463527] RPC:       state 7 conn 0 dead 0 zapped 1 sk_shutdown 3
[ 5605.464312] RPC:       xs_error_report client 0000000005eb3fd3, =
error=3D113...
[ 5605.465430] RPC:       xs_close xprt 0000000005eb3fd3
[ 5605.466074] RPC:       xs_tcp_state_change client 0000000005eb3fd3...
[ 5605.466903] RPC:       state 7 conn 0 dead 0 zapped 1 sk_shutdown 3
[ 5608.470590] RPC:       xs_connect scheduled xprt 0000000005eb3fd3
[ 5608.471618] RPC:       xs_bind =
0000:0000:0000:0000:0000:0000:0000:0000:1015: ok (0)
[ 5608.472730] RPC:       worker connecting xprt 0000000005eb3fd3 via =
tcp to 2a02:238:f030:1c3::1136 (port 2049)
[ 5608.474014] RPC:       0000000005eb3fd3 connect status 115 connected =
0 sock state 2
[ 5609.495200] RPC:       xs_tcp_state_change client 0000000005eb3fd3...
[ 5609.496171] RPC:       state 1 conn 0 dead 0 zapped 1 sk_shutdown 0
[ 5609.497356] RPC:       xs_tcp_send_request(116) =3D 0
[ 5609.511115] nfs41_sequence_process ERROR: -10052 Reset session
[ 5609.512033] nfs4_free_slot: slotid 0 highest_used_slotid 4294967295
[ 5609.512809] nfs41_sequence_process: Error -10052 free the slot
[ 5609.513589] nfs41_sequence_call_done ERROR -10052
[ 5609.514246] nfs4_schedule_lease_recovery: scheduling lease recovery =
for server <server>
[ 5609.515446] nfs41_sequence_call_done rpc_cred 000000001946c07d
[ 5609.516272] RPC:       xs_tcp_send_request(100) =3D 0
[ 5609.517198] NFS: Got error -10052 from the server on DESTROY_SESSION. =
Session has been destroyed regardless...
[ 5609.518645] --> nfs4_proc_create_session clp=3D0000000002fc3705 =
session=3D000000009488146a
[ 5609.519601] nfs4_init_channel_attrs: Fore Channel : =
max_rqst_sz=3D1049620 max_resp_sz=3D1049480 max_ops=3D8 max_reqs=3D64
[ 5609.520801] nfs4_init_channel_attrs: Back Channel : max_rqst_sz=3D4096 =
max_resp_sz=3D4096 max_resp_sz_cached=3D0 max_ops=3D2 max_reqs=3D16
[ 5609.523115] nfs4_schedule_state_renewal: requeueing work. Lease =
period =3D 5
[ 5609.524103] RPC:       xs_tcp_send_request(196) =3D 0
[ 5609.525090] nfs4_reset_session: session reset failed with status =
-10022 for server <server>!
[ 5609.526350] nfs4_handle_reclaim_lease_error: handled error -10022 for =
server <server>
[ 5609.527548] RPC:       xs_tcp_send_request(244) =3D 0
[ 5609.528414] --> nfs4_proc_create_session clp=3D0000000002fc3705 =
session=3D000000009488146a
[ 5609.529500] nfs4_init_channel_attrs: Fore Channel : =
max_rqst_sz=3D1049620 max_resp_sz=3D1049480 max_ops=3D8 max_reqs=3D64
[ 5609.530905] nfs4_init_channel_attrs: Back Channel : max_rqst_sz=3D4096 =
max_resp_sz=3D4096 max_resp_sz_cached=3D0 max_ops=3D2 max_reqs=3D16
[ 5609.532526] RPC:       xs_tcp_send_request(196) =3D 0
[ 5609.533669] --> nfs4_setup_session_slot_tables
[ 5609.534365] --> nfs4_realloc_slot_table: max_reqs=3D30, =
tbl->max_slots 30
[ 5609.535199] nfs4_realloc_slot_table: tbl=3D000000009c22d728 =
slots=3D0000000025e05bce max_slots=3D30
[ 5609.536186] <-- nfs4_realloc_slot_table: return 0
[ 5609.536744] --> nfs4_realloc_slot_table: max_reqs=3D16, =
tbl->max_slots 16
[ 5609.537734] nfs4_realloc_slot_table: tbl=3D0000000002a05f6b =
slots=3D000000009aa80389 max_slots=3D16
[ 5609.538775] <-- nfs4_realloc_slot_table: return 0
[ 5609.539446] slot table setup returned 0
[ 5609.539994] nfs4_proc_create_session client>seqid 2 sessionid =
1727263639:3068450331:1:0
[ 5609.541129] --> nfs4_alloc_slot used_slots=3D0000 =
highest_used=3D4294967295 max_slots=3D30
[ 5609.542047] <-- nfs4_alloc_slot used_slots=3D0001 highest_used=3D0 =
slotid=3D0
[ 5609.543029] encode_sequence: sessionid=3D1727263639:3068450331:1:0 =
seqid=3D1 slotid=3D0 max_slotid=3D0 cache_this=3D0
[ 5609.544295] RPC:       xs_tcp_send_request(132) =3D 0
[ 5609.545479] decode_attr_lease_time: lease time=3D90
[ 5609.546158] decode_attr_maxfilesize: maxfilesize=3D0
[ 5609.546798] decode_attr_maxread: maxread=3D1024
[ 5609.547357] decode_attr_maxwrite: maxwrite=3D1024
[ 5609.547943] decode_attr_time_delta: time_delta=3D0 0
[ 5609.548482] decode_attr_pnfstype: bitmap is 0
[ 5609.549005] decode_attr_layout_blksize: bitmap is 0
[ 5609.549534] decode_attr_clone_blksize: bitmap is 0
[ 5609.550125] decode_attr_change_attr_type: bitmap is 0
[ 5609.550766] decode_attr_xattrsupport: XATTR support=3Dfalse
[ 5609.551413] decode_fsinfo: xdr returned 0!
[ 5609.552242] --> nfs4_alloc_slot used_slots=3D0001 highest_used=3D0 =
max_slots=3D30
[ 5609.553039] <-- nfs4_alloc_slot used_slots=3D0003 highest_used=3D1 =
slotid=3D1
[ 5609.553917] nfs4_free_slot: slotid 1 highest_used_slotid 0
[ 5609.554541] nfs41_sequence_process: Error 0 free the slot
[ 5609.555273] nfs4_free_slot: slotid 0 highest_used_slotid 4294967295
[ 5609.560764] nfs4_schedule_state_renewal: requeueing work. Lease =
period =3D 60
[ 5609.562070] --> nfs4_alloc_slot used_slots=3D0000 =
highest_used=3D4294967295 max_slots=3D30
[ 5609.563074] <-- nfs4_alloc_slot used_slots=3D0001 highest_used=3D0 =
slotid=3D0
[ 5609.563980] encode_sequence: sessionid=3D1727263639:3068450331:1:0 =
seqid=3D2 slotid=3D0 max_slotid=3D0 cache_this=3D0
[ 5609.565352] RPC:       xs_tcp_send_request(124) =3D 0
[ 5609.644135] --> nfs4_alloc_slot used_slots=3D0001 highest_used=3D0 =
max_slots=3D30
[ 5609.645214] <-- nfs4_alloc_slot used_slots=3D0003 highest_used=3D1 =
slotid=3D1
[ 5609.646049] nfs4_free_slot: slotid 1 highest_used_slotid 0
[ 5609.646722] nfs41_sequence_process: Error 0 free the slot
[ 5609.647369] nfs4_free_slot: slotid 0 highest_used_slotid 4294967295
[ 5609.648352] <-- nfs41_proc_reclaim_complete status=3D0
[ 5609.648964] --> nfs4_alloc_slot used_slots=3D0000 =
highest_used=3D4294967295 max_slots=3D16
[ 5609.649813] <-- nfs4_alloc_slot used_slots=3D0001 highest_used=3D0 =
slotid=3D0
[ 5609.650544] nfs4_free_slot: slotid 0 highest_used_slotid 4294967295
[ 5609.651237] --> nfs4_alloc_slot used_slots=3D0000 =
highest_used=3D4294967295 max_slots=3D30
[ 5609.652134] <-- nfs4_alloc_slot used_slots=3D0001 highest_used=3D0 =
slotid=3D0
[ 5609.652874] nfs4_free_slot: slotid 0 highest_used_slotid 4294967295
[ 5632.396766] NFS: permission(0:50/33681408), mask=3D0x81, res=3D-10
[ 5632.397471] NFS: revalidating (0:50/33681408)
[ 5632.397973] --> nfs41_call_sync_prepare data->seq_server =
000000001a362fd8
[ 5632.398705] --> nfs4_alloc_slot used_slots=3D0000 =
highest_used=3D4294967295 max_slots=3D30
[ 5632.399547] <-- nfs4_alloc_slot used_slots=3D0001 highest_used=3D0 =
slotid=3D0
[ 5632.400600] encode_sequence: sessionid=3D1727263639:3068450331:1:0 =
seqid=3D3 slotid=3D0 max_slotid=3D0 cache_this=3D0
[ 5632.401933] RPC:       xs_tcp_send_request(172) =3D 0
[ 5632.406551] decode_attr_type: type=3D040000
[ 5632.407276] decode_attr_change: change attribute=3D7
[ 5632.407922] decode_attr_size: file size=3D18
[ 5632.408428] decode_attr_fsid: =
fsid=3D(0x7de545f823d44d4e/0xadabff1eec0b0f80)
[ 5632.409210] decode_attr_fileid: fileid=3D33681408
[ 5632.409752] decode_attr_fs_locations: fs_locations done, error =3D 0
[ 5632.410441] decode_attr_mode: file mode=3D0775
[ 5632.410944] decode_attr_nlink: nlink=3D3
[ 5632.411464] decode_attr_owner: uid=3D0
[ 5632.411953] decode_attr_group: gid=3D900
[ 5632.412473] decode_attr_rdev: rdev=3D(0x0:0x0)
[ 5632.412982] decode_attr_space_used: space used=3D0
[ 5632.413558] decode_attr_time_access: atime=3D1727245731
[ 5632.414115] decode_attr_time_metadata: ctime=3D1727245730
[ 5632.414746] decode_attr_time_modify: mtime=3D1727245730
[ 5632.415336] decode_attr_mounted_on_fileid: fileid=3D33681408
[ 5632.416084] decode_getfattr_attrs: xdr returned 0
[ 5632.416712] decode_getfattr_generic: xdr returned 0
[ 5632.417833] --> nfs4_alloc_slot used_slots=3D0001 highest_used=3D0 =
max_slots=3D30
[ 5632.418779] <-- nfs4_alloc_slot used_slots=3D0003 highest_used=3D1 =
slotid=3D1
[ 5632.419659] nfs4_free_slot: slotid 1 highest_used_slotid 0
[ 5632.420315] nfs41_sequence_process: Error 0 free the slot
[ 5632.421024] nfs4_free_slot: slotid 0 highest_used_slotid 4294967295
[ 5632.422037] NFS: nfs_update_inode(0:50/33681408 fh_crc=3D0xd3a763c6 =
ct=3D2 info=3D0x427e7f)
[ 5632.423110] NFS: (0:50/33681408) revalidation complete
[ 5632.423890] NFS: permission(0:50/33681408), mask=3D0x1, res=3D0
[ 5632.424892] NFS: nfs_weak_revalidate: inode 33681408 is valid
[ 5632.428895] NFS: permission(0:50/33681408), mask=3D0x81, res=3D0
[ 5632.429693] NFS: revalidating (0:50/33681408)
[ 5632.430402] --> nfs41_call_sync_prepare data->seq_server =
000000001a362fd8
[ 5632.431191] --> nfs4_alloc_slot used_slots=3D0000 =
highest_used=3D4294967295 max_slots=3D30
[ 5632.432112] <-- nfs4_alloc_slot used_slots=3D0001 highest_used=3D0 =
slotid=3D0
[ 5632.433025] encode_sequence: sessionid=3D1727263639:3068450331:1:0 =
seqid=3D4 slotid=3D0 max_slotid=3D0 cache_this=3D0
[ 5632.434228] RPC:       xs_tcp_send_request(172) =3D 0
[ 5632.435149] decode_attr_type: type=3D040000
[ 5632.435692] decode_attr_change: change attribute=3D7
[ 5632.436237] decode_attr_size: file size=3D18
[ 5632.436738] decode_attr_fsid: =
fsid=3D(0x7de545f823d44d4e/0xadabff1eec0b0f80)
[ 5632.437518] decode_attr_fileid: fileid=3D33681408
[ 5632.438052] decode_attr_fs_locations: fs_locations done, error =3D 0
[ 5632.438796] decode_attr_mode: file mode=3D0775
[ 5632.439312] decode_attr_nlink: nlink=3D3
[ 5632.439772] decode_attr_owner: uid=3D0
[ 5632.440147] decode_attr_group: gid=3D900
[ 5632.440582] decode_attr_rdev: rdev=3D(0x0:0x0)
[ 5632.441272] decode_attr_space_used: space used=3D0
[ 5632.441998] decode_attr_time_access: atime=3D1727245731
[ 5632.442796] decode_attr_time_metadata: ctime=3D1727245730
[ 5632.443613] decode_attr_time_modify: mtime=3D1727245730
[ 5632.444374] decode_attr_mounted_on_fileid: fileid=3D33681408
[ 5632.445216] decode_getfattr_attrs: xdr returned 0
[ 5632.445948] decode_getfattr_generic: xdr returned 0
[ 5632.447188] --> nfs4_alloc_slot used_slots=3D0001 highest_used=3D0 =
max_slots=3D30
[ 5632.448043] <-- nfs4_alloc_slot used_slots=3D0003 highest_used=3D1 =
slotid=3D1
[ 5632.448876] nfs4_free_slot: slotid 1 highest_used_slotid 0
[ 5632.449551] nfs41_sequence_process: Error 0 free the slot
[ 5632.450206] nfs4_free_slot: slotid 0 highest_used_slotid 4294967295
[ 5632.451060] NFS: nfs_update_inode(0:50/33681408 fh_crc=3D0xd3a763c6 =
ct=3D2 info=3D0x427e7f)
[ 5632.451966] NFS: (0:50/33681408) revalidation complete
[ 5632.452663] NFS: nfs_weak_revalidate: inode 33681408 is valid
[ 5632.453284] NFS: permission(0:50/33681408), mask=3D0x24, res=3D0
[ 5632.454370] NFS: open dir(/)
[ 5632.454787] NFS: readdir(/) starting at cookie 0
[ 5632.455619] NFS: nfs_do_filldir() filling ended @ cookie 512
[ 5632.456475] NFS: readdir(/) returns 0
[ 5632.457038] NFS: permission(0:50/33681408), mask=3D0x81, res=3D0
[ 5632.457862] NFS: revalidating (0:50/1677168)
[ 5632.458536] --> nfs41_call_sync_prepare data->seq_server =
000000001a362fd8
[ 5632.459514] --> nfs4_alloc_slot used_slots=3D0000 =
highest_used=3D4294967295 max_slots=3D30
[ 5632.460527] <-- nfs4_alloc_slot used_slots=3D0001 highest_used=3D0 =
slotid=3D0
[ 5632.461465] encode_sequence: sessionid=3D1727263639:3068450331:1:0 =
seqid=3D5 slotid=3D0 max_slotid=3D0 cache_this=3D0
[ 5632.462847] RPC:       xs_tcp_send_request(184) =3D 0


I=E2=80=99m at the point where I=E2=80=99m considering that this might =
be a bug.

Hugs,
Christian

--=20
Christian Theune =C2=B7 ct@flyingcircus.io =C2=B7 +49 345 219401 0
Flying Circus Internet Operations GmbH =C2=B7 https://flyingcircus.io
Leipziger Str. 70/71 =C2=B7 06108 Halle (Saale) =C2=B7 Deutschland
HR Stendal HRB 21169 =C2=B7 Gesch=C3=A4ftsf=C3=BChrer: Christian Theune, =
Christian Zagrodnick


