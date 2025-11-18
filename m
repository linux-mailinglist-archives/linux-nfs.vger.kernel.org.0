Return-Path: <linux-nfs+bounces-16478-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 805F5C67451
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Nov 2025 05:34:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 111CE349B01
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Nov 2025 04:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E8E29D26E;
	Tue, 18 Nov 2025 04:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tylerwross.com header.i=@tylerwross.com header.b="t+KE9bx0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-106117.protonmail.ch (mail-106117.protonmail.ch [79.135.106.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A59C26FDBF
	for <linux-nfs@vger.kernel.org>; Tue, 18 Nov 2025 04:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763440356; cv=none; b=n3p0BaUEcImXQTF6J9lKVBVo3CDyD28R8EgHb19wGfjUKY/ep7LdMbzlujy06b1wIkqRkvxW6H/DEuS1b63K1yNsHj00s2kgCEMUJzC1Dmevp1WULXKbbnMKHEi+kDfzx6rWugik3ThQ355QZTh8mkMzx7hPsGukvOufS6In4AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763440356; c=relaxed/simple;
	bh=nuRIHtv5U99cDIpLLV/kXOkNEVJD3HdK+5LqhQPPiD8=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=lFNhiYbW5/mYybU/S5839NMdrZqOZ2jaV0jPiw6IrEbffOV014nvRINeNpJ6/pWo5aR9Eakl19z6RnvJ+6P8LPHQ6Hg1q3JPGRJ1y5xfaDP+cRpEBsKCDIe4dMJFhZgTJwuvRsnltHnUfWj0F4+45bfdBEk89DkfT4SGUdrTnMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tylerwross.com; spf=pass smtp.mailfrom=tylerwross.com; dkim=pass (2048-bit key) header.d=tylerwross.com header.i=@tylerwross.com header.b=t+KE9bx0; arc=none smtp.client-ip=79.135.106.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tylerwross.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tylerwross.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tylerwross.com;
	s=protonmail; t=1763440350; x=1763699550;
	bh=RHaICD/smsxq0ap90+TA4M5P2rpdL2fxxs+YXu9JLp4=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=t+KE9bx0MZQVGCYdHC+8Th3tr1bWeB9b8S5PBVV+lTBFbzsnnJZHpimF3o0ZSwhyF
	 ZfuiJumJMQGMSNZIu93yGDWwJKjMQhqM4Mcv4ywnfRCQ3cVuJ0U9nwsH9lnmRwb34y
	 QK3LBog6/tG00PmYPSKHJdvuioa9OV/h1vcSzFyQHyUwUX6T2ZuBE3oRiShKOhKgPI
	 izLQc6TapImQUHsbOvstD3e+RSTJszpXd6kJrpiYjX9bRatpHZAh80OssxV29a+EdW
	 7lSTA4/MvXY3tYwQXwc5R37A7GhAyxfVfjlYTZoH7KZpkadlKyEFfHIiK57NIstdYj
	 jxp/8TGDMhvXw==
Date: Tue, 18 Nov 2025 04:32:24 +0000
To: Scott Mayhew <smayhew@redhat.com>
From: "Tyler W. Ross" <TWR@tylerwross.com>
Cc: Trond Myklebust <trondmy@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, Anna Schumaker <anna@kernel.org>, Salvatore Bonaccorso <carnil@debian.org>, "1120598@bugs.debian.org" <1120598@bugs.debian.org>, Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, Steve Dickson <steved@redhat.com>, Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: ls input/output error ("NFS: readdir(/) returns -5") on krb5 NFSv4 client using SHA2
Message-ID: <16121fbd-17d1-41c5-ac8d-177533e8afea@TylerWRoss.com>
Feedback-ID: 101639484:user:proton
X-Pm-Message-ID: 8de409d5e24b9c82696b0800b548f9e2e7108555
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/17/25 4:05 PM, Scott Mayhew wrote:
> On Mon, 17 Nov 2025, Tyler W. Ross wrote:
>=20
>> Weird behavior I just discovered:
>>
>> Explicitly setting allowed-enctypes in the gssd section of /etc/nfs.conf
>> to exclude aes256-cts-hmac-sha1-96 makes both SHA2 ciphers work as
>> expected (assuming each is allowed).
>>
>> If allowed-enctypes is unset (letting gssd interrogate the kernel for
>> supported enctypes) or includes aes256-cts-hmac-sha1-96, then the XDR
>> overflow occurs.
>>
>> Non-working configurations (first is the commented-out default in nfs.co=
nf):
>> allowed-enctypes=3Daes256-cts-hmac-sha384-192,aes128-cts-hmac-sha256-128=
,camellia256-cts-cmac,camellia128-cts-cmac,aes256-cts-hmac-sha1-96,aes128-c=
ts-hmac-sha1-96
>> allowed-enctypes=3Daes256-cts-hmac-sha384-192,aes256-cts-hmac-sha1-96
>> allowed-enctypes=3Daes128-cts-hmac-sha256-128,aes256-cts-hmac-sha1-96
>> allowed-enctypes=3Daes256-cts-hmac-sha384-192,aes128-cts-hmac-sha256-128=
,aes256-cts-hmac-sha1-96
>>
>> Working configurations (first is default sans aes256-cts-hmac-sha1-96):
>> allowed-enctypes=3Daes256-cts-hmac-sha384-192,aes128-cts-hmac-sha256-128=
,camellia256-cts-cmac,camellia128-cts-cmac,aes128-cts-hmac-sha1-96
>> allowed-enctypes=3Daes256-cts-hmac-sha384-192,aes128-cts-hmac-sha256-128
>> allowed-enctypes=3Daes256-cts-hmac-sha384-192,aes128-cts-hmac-sha1-96
>> allowed-enctypes=3Daes128-cts-hmac-sha256-128,aes128-cts-hmac-sha1-96
>>
>=20
> That doesn't really make sense.  You should only need to use the
> allowed-enctypes setting if you're talking to an NFS server that doesn't
> have support for the new encryption types.
>=20
> It basically works like the "permitted_enctypes" option in krb5.conf,
> except it only affects NFS rather than affecting your krb5 configuration
> as a whole.

Agreed. It really doesn't make sense. It may just be me being confounded=20
by some ancillary behavior I don't understand.

I find it especially strange that
allowed-enctypes=3Daes256-cts-hmac-sha384-192 works, but unset
allowed-enctypes with a manually acquired aes256-cts-hmac-sha384-192=20
ticket doesn't work.

allowed-enctypes=3Daes256-cts-hmac-sha384-192 works both with an=20
automatically acquired service ticket (kinit then ls) and a manually=20
acquired service ticket (via kvno -e).

> Can you go back and re-do the tracepoint capture, except this time
> umount your NFS filessytems before starting the capture (i.e. perform
> the mount command while trace-cmd is running).  I'm curious what values
> the rpcgss_update_slack tracepoint shows.

Here are the 2 rpcgss_update_slack occurrences, with a couple lines of=20
context. Let me know if you'd like the full report: it's ~1300 lines.

mount.nfs4-1043  [005] .....   190.746932: rpc_task_run_action:  task:00000=
002@00000001 flags=3DDYNAMIC|NO_ROUND_ROBIN|SOFT|SENT|TIMEOUT|NORTO|CRED_NO=
REF runstate=3DRUNNING|0x4 status=3D0 action=3Dcall_status
mount.nfs4-1043  [005] .....   190.746932: rpc_task_run_action:  task:00000=
002@00000001 flags=3DDYNAMIC|NO_ROUND_ROBIN|SOFT|SENT|TIMEOUT|NORTO|CRED_NO=
REF runstate=3DRUNNING|0x4 status=3D0 action=3Dcall_decode
mount.nfs4-1043  [005] .....   190.746933: rpc_xdr_recvfrom:     task:00000=
002@00000001 head=3D[0xffff8a61a2848fd4,4392] page=3D0(0) tail=3D[(nil),0] =
len=3D312
mount.nfs4-1043  [005] .....   190.746938: rpcgss_update_slack:  task:00000=
002@00000001 xid=3D0xb28269cc auth=3D0xffff8a6189400798 rslack=3D19 ralign=
=3D11 verfsize=3D9
mount.nfs4-1043  [005] .....   190.746939: rpc_task_run_action:  task:00000=
002@00000001 flags=3DDYNAMIC|NO_ROUND_ROBIN|SOFT|SENT|TIMEOUT|NORTO|CRED_NO=
REF runstate=3DRUNNING|0x4 status=3D0 action=3Drpc_exit_task
mount.nfs4-1043  [005] .....   190.746939: rpc_task_end:         task:00000=
002@00000001 flags=3DDYNAMIC|NO_ROUND_ROBIN|SOFT|SENT|TIMEOUT|NORTO|CRED_NO=
REF runstate=3DRUNNING|0x4 status=3D0 action=3Drpc_exit_task
mount.nfs4-1043  [005] .....   190.746940: rpc_stats_latency:    task:00000=
002@00000001 xid=3D0xb28269cc nfsv4 EXCHANGE_ID backlog=3D12836 rtt=3D136 e=
xecute=3D12995 xprt_id=3D1
--
mount.nfs4-1043  [002] .....   190.755687: rpc_task_run_action:  task:00000=
001@00000002 flags=3DMOVEABLE|DYNAMIC|SENT|NORTO|CRED_NOREF runstate=3DRUNN=
ING|0x4 status=3D0 action=3Dcall_status
mount.nfs4-1043  [002] .....   190.755687: rpc_task_run_action:  task:00000=
001@00000002 flags=3DMOVEABLE|DYNAMIC|SENT|NORTO|CRED_NOREF runstate=3DRUNN=
ING|0x4 status=3D0 action=3Dcall_decode
mount.nfs4-1043  [002] .....   190.755688: rpc_xdr_recvfrom:     task:00000=
001@00000002 head=3D[0xffff8a6182b4e6ac,2920] page=3D0(0) tail=3D[(nil),0] =
len=3D192
mount.nfs4-1043  [002] .....   190.755691: rpcgss_update_slack:  task:00000=
001@00000002 xid=3D0xb68269cc auth=3D0xffff8a6187759498 rslack=3D9 ralign=
=3D9 verfsize=3D9
mount.nfs4-1043  [002] .....   190.755694: rpc_task_run_action:  task:00000=
001@00000002 flags=3DMOVEABLE|DYNAMIC|SENT|NORTO|CRED_NOREF runstate=3DRUNN=
ING|0x4 status=3D0 action=3Drpc_exit_task
mount.nfs4-1043  [002] .....   190.755694: rpc_task_end:         task:00000=
001@00000002 flags=3DMOVEABLE|DYNAMIC|SENT|NORTO|CRED_NOREF runstate=3DRUNN=
ING|0x4 status=3D0 action=3Drpc_exit_task
mount.nfs4-1043  [002] .....   190.755694: rpc_stats_latency:    task:00000=
001@00000002 xid=3D0xb68269cc nfsv4 LOOKUP_ROOT backlog=3D7101 rtt=3D91 exe=
cute=3D7218 xprt_id=3D1


And here's with allowed-enctypes=3Daes256-cts-hmac-sha384-192

mount.nfs4-1100  [005] .....   580.221598: rpc_task_run_action:  task:00000=
002@00000001 flags=3DDYNAMIC|NO_ROUND_ROBIN|SOFT|SENT|TIMEOUT|NORTO|CRED_NO=
REF runstate=3DRUNNING|0x4 status=3D0 action=3Dcall_status
mount.nfs4-1100  [005] .....   580.221598: rpc_task_run_action:  task:00000=
002@00000001 flags=3DDYNAMIC|NO_ROUND_ROBIN|SOFT|SENT|TIMEOUT|NORTO|CRED_NO=
REF runstate=3DRUNNING|0x4 status=3D0 action=3Dcall_decode
mount.nfs4-1100  [005] .....   580.221598: rpc_xdr_recvfrom:     task:00000=
002@00000001 head=3D[0xffff8b2b98850fd4,4392] page=3D0(0) tail=3D[(nil),0] =
len=3D336
mount.nfs4-1100  [005] .....   580.221604: rpcgss_update_slack:  task:00000=
002@00000001 xid=3D0x4c050148 auth=3D0xffff8b2b88864818 rslack=3D25 ralign=
=3D14 verfsize=3D12
mount.nfs4-1100  [005] .....   580.221605: rpc_task_run_action:  task:00000=
002@00000001 flags=3DDYNAMIC|NO_ROUND_ROBIN|SOFT|SENT|TIMEOUT|NORTO|CRED_NO=
REF runstate=3DRUNNING|0x4 status=3D0 action=3Drpc_exit_task
mount.nfs4-1100  [005] .....   580.221606: rpc_task_end:         task:00000=
002@00000001 flags=3DDYNAMIC|NO_ROUND_ROBIN|SOFT|SENT|TIMEOUT|NORTO|CRED_NO=
REF runstate=3DRUNNING|0x4 status=3D0 action=3Drpc_exit_task
mount.nfs4-1100  [005] .....   580.221607: rpc_stats_latency:    task:00000=
002@00000001 xid=3D0x4c050148 nfsv4 EXCHANGE_ID backlog=3D13249 rtt=3D164 e=
xecute=3D13435 xprt_id=3D1
--
mount.nfs4-1100  [000] .....   580.230841: rpc_task_run_action:  task:00000=
001@00000002 flags=3DMOVEABLE|DYNAMIC|SENT|NORTO|CRED_NOREF runstate=3DRUNN=
ING|0x4 status=3D0 action=3Dcall_status
mount.nfs4-1100  [000] .....   580.230841: rpc_task_run_action:  task:00000=
001@00000002 flags=3DMOVEABLE|DYNAMIC|SENT|NORTO|CRED_NOREF runstate=3DRUNN=
ING|0x4 status=3D0 action=3Dcall_decode
mount.nfs4-1100  [000] .....   580.230841: rpc_xdr_recvfrom:     task:00000=
001@00000002 head=3D[0xffff8b2ba07b66ac,2920] page=3D0(0) tail=3D[(nil),0] =
len=3D204
mount.nfs4-1100  [000] .....   580.230845: rpcgss_update_slack:  task:00000=
001@00000002 xid=3D0x50050148 auth=3D0xffff8b2b88864b18 rslack=3D12 ralign=
=3D12 verfsize=3D12
mount.nfs4-1100  [000] .....   580.230847: rpc_task_run_action:  task:00000=
001@00000002 flags=3DMOVEABLE|DYNAMIC|SENT|NORTO|CRED_NOREF runstate=3DRUNN=
ING|0x4 status=3D0 action=3Drpc_exit_task
mount.nfs4-1100  [000] .....   580.230847: rpc_task_end:         task:00000=
001@00000002 flags=3DMOVEABLE|DYNAMIC|SENT|NORTO|CRED_NOREF runstate=3DRUNN=
ING|0x4 status=3D0 action=3Drpc_exit_task
mount.nfs4-1100  [000] .....   580.230848: rpc_stats_latency:    task:00000=
001@00000002 xid=3D0x50050148 nfsv4 LOOKUP_ROOT backlog=3D7760 rtt=3D98 exe=
cute=3D7878 xprt_id=3D1



TWR


