Return-Path: <linux-nfs+bounces-8626-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 126D29F4F7A
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Dec 2024 16:31:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B68AB188293A
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Dec 2024 15:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7921F7570;
	Tue, 17 Dec 2024 15:30:54 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E204F23DE;
	Tue, 17 Dec 2024 15:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734449454; cv=none; b=pl8n05KxkQvUBQ6rGQmFDqipT7LhRg3O8kDA3sEzw3ILa9PNrUYR0xkH+Vxxoek/04XD8p6qS6HECqqxO17EDMxYIcyooD6DDK3QY172h7vXfm6IVAs6Gkf6EIdYXFNUok4OsyEaWxK7WBAN1/6M5Yv3Ao5FZx6TbdJjf8roVaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734449454; c=relaxed/simple;
	bh=0jP07AZUMSc6f0wRDS7d5gjNEdL7iMR43aPgZCmn4VM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=b2hmo8EkXhYS/CBnA+6KqcZfjOXi1ljfCIzjJo0Rwygb1FI5CV9C80yEE93ryHg77QRp4FurEkCaour8mtD1GVpwyWqpTCztlyamOiFVGnj/lwwIXkkXlXwACaLpX/+BLeOrwxVN3yOLrHudwsAIFgHp5o2SV96WLOdFxDneLVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4YCLKF3zcPz1V6dQ;
	Tue, 17 Dec 2024 23:27:29 +0800 (CST)
Received: from kwepemg500017.china.huawei.com (unknown [7.202.181.81])
	by mail.maildlp.com (Postfix) with ESMTPS id 360D21402E2;
	Tue, 17 Dec 2024 23:30:43 +0800 (CST)
Received: from [10.174.179.155] (10.174.179.155) by
 kwepemg500017.china.huawei.com (7.202.181.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 17 Dec 2024 23:30:41 +0800
Message-ID: <ef9774e3-572b-427f-99e9-c6a456ffe4fc@huawei.com>
Date: Tue, 17 Dec 2024 23:30:41 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: CVE-2024-50106: nfsd: fix race between laundromat and
 free_stateid
To: <cve@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cve-announce@vger.kernel.org>, "linux-nfs@vger.kernel.org"
	<linux-nfs@vger.kernel.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Olga Kornievskaia
	<okorniev@redhat.com>, Chuck Lever <chuck.lever@oracle.com>, Jeff Layton
	<jlayton@kernel.org>, NeilBrown <neilb@suse.de>, yangerkun
	<yangerkun@huawei.com>, "zhangyi (F)" <yi.zhang@huawei.com>, Hou Tao
	<houtao1@huawei.com>, "yukuai (C)" <yukuai3@huawei.com>,
	"chengzhihao1@huawei.com" <chengzhihao1@huawei.com>, Li Lingfeng
	<lilingfeng3@huawei.com>, ZhangXiaoxu <zhangxiaoxu5@huawei.com>
References: <2024110553-CVE-2024-50106-c095@gregkh>
From: Li Lingfeng <lilingfeng3@huawei.com>
In-Reply-To: <2024110553-CVE-2024-50106-c095@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemg500017.china.huawei.com (7.202.181.81)

Hi,
after analysis, we think that this issue is not introduced by commit
2d4a532d385f ("nfsd: ensure that clp->cl_revoked list is protected by
clp->cl_lock") but by commit 83e733161fde ("nfsd: avoid race after
unhash_delegation_locked()").
Therefore, kernel versions earlier than 6.9 do not involve this issue.

// normal case 1 -- free deleg by delegreturn
1) OP_DELEGRETURN
nfsd4_delegreturn
  nfsd4_lookup_stateid
  destroy_delegation
   destroy_unhashed_deleg
    nfs4_unlock_deleg_lease
     vfs_setlease // unlock
  nfs4_put_stid // put last refcount
   idr_remove // remove from cl_stateids
   s->sc_free // free deleg

2) OP_FREE_STATEID
nfsd4_free_stateid
  find_stateid_locked // can not find the deleg in cl_stateids


// normal case 2 -- free deleg by laundromat
nfs4_laundromat
  state_expired
  unhash_delegation_locked // set NFS4_REVOKED_DELEG_STID
  list_add // add the deleg to reaplist
  list_first_entry // get the deleg from reaplist
  revoke_delegation
   destroy_unhashed_deleg
    nfs4_unlock_deleg_lease
    nfs4_put_stid


// abnormal case
nfs4_laundromat
  state_expired
  unhash_delegation_locked
   // set NFS4_REVOKED_DELEG_STID
  list_add
   // add the deleg to reaplist
                                 1) OP_DELEGRETURN
                                 nfsd4_delegreturn
                                  nfsd4_lookup_stateid
nfsd4_stid_check_stateid_generation
                                   nfsd4_verify_open_stid
                                    // check NFS4_REVOKED_DELEG_STID
                                    // and return nfserr_deleg_revoked
                                  // skip destroy_delegation

                                 2) OP_FREE_STATEID
                                 nfsd4_free_stateid
                                  // check NFS4_REVOKED_DELEG_STID
                                  list_del_init
                                   // remove deleg from reaplist
                                  nfs4_put_stid
                                   // free deleg
  list_first_entry
   // cant not get the deleg from reaplist


Before commit 83e733161fde ("nfsd: avoid race after
unhash_delegation_locked()"), nfs4_laundromat --> unhash_delegation_locked
would not set NFS4_REVOKED_DELEG_STID for the deleg.
So the description "it marks the delegation stid revoked" in the CVE fix
patch does not hold true. And the OP_FREE_STATEID operation will not
release the deleg.

Thanks.

在 2024/11/6 1:10, Greg Kroah-Hartman 写道:
> Description
> ===========
>
> In the Linux kernel, the following vulnerability has been resolved:
>
> nfsd: fix race between laundromat and free_stateid
>
> There is a race between laundromat handling of revoked delegations
> and a client sending free_stateid operation. Laundromat thread
> finds that delegation has expired and needs to be revoked so it
> marks the delegation stid revoked and it puts it on a reaper list
> but then it unlock the state lock and the actual delegation revocation
> happens without the lock. Once the stid is marked revoked a racing
> free_stateid processing thread does the following (1) it calls
> list_del_init() which removes it from the reaper list and (2) frees
> the delegation stid structure. The laundromat thread ends up not
> calling the revoke_delegation() function for this particular delegation
> but that means it will no release the lock lease that exists on
> the file.
>
> Now, a new open for this file comes in and ends up finding that
> lease list isn't empty and calls nfsd_breaker_owns_lease() which ends
> up trying to derefence a freed delegation stateid. Leading to the
> followint use-after-free KASAN warning:
>
> kernel: ==================================================================
> kernel: BUG: KASAN: slab-use-after-free in nfsd_breaker_owns_lease+0x140/0x160 [nfsd]
> kernel: Read of size 8 at addr ffff0000e73cd0c8 by task nfsd/6205
> kernel:
> kernel: CPU: 2 UID: 0 PID: 6205 Comm: nfsd Kdump: loaded Not tainted 6.11.0-rc7+ #9
> kernel: Hardware name: Apple Inc. Apple Virtualization Generic Platform, BIOS 2069.0.0.0.0 08/03/2024
> kernel: Call trace:
> kernel: dump_backtrace+0x98/0x120
> kernel: show_stack+0x1c/0x30
> kernel: dump_stack_lvl+0x80/0xe8
> kernel: print_address_description.constprop.0+0x84/0x390
> kernel: print_report+0xa4/0x268
> kernel: kasan_report+0xb4/0xf8
> kernel: __asan_report_load8_noabort+0x1c/0x28
> kernel: nfsd_breaker_owns_lease+0x140/0x160 [nfsd]
> kernel: nfsd_file_do_acquire+0xb3c/0x11d0 [nfsd]
> kernel: nfsd_file_acquire_opened+0x84/0x110 [nfsd]
> kernel: nfs4_get_vfs_file+0x634/0x958 [nfsd]
> kernel: nfsd4_process_open2+0xa40/0x1a40 [nfsd]
> kernel: nfsd4_open+0xa08/0xe80 [nfsd]
> kernel: nfsd4_proc_compound+0xb8c/0x2130 [nfsd]
> kernel: nfsd_dispatch+0x22c/0x718 [nfsd]
> kernel: svc_process_common+0x8e8/0x1960 [sunrpc]
> kernel: svc_process+0x3d4/0x7e0 [sunrpc]
> kernel: svc_handle_xprt+0x828/0xe10 [sunrpc]
> kernel: svc_recv+0x2cc/0x6a8 [sunrpc]
> kernel: nfsd+0x270/0x400 [nfsd]
> kernel: kthread+0x288/0x310
> kernel: ret_from_fork+0x10/0x20
>
> This patch proposes a fixed that's based on adding 2 new additional
> stid's sc_status values that help coordinate between the laundromat
> and other operations (nfsd4_free_stateid() and nfsd4_delegreturn()).
>
> First to make sure, that once the stid is marked revoked, it is not
> removed by the nfsd4_free_stateid(), the laundromat take a reference
> on the stateid. Then, coordinating whether the stid has been put
> on the cl_revoked list or we are processing FREE_STATEID and need to
> make sure to remove it from the list, each check that state and act
> accordingly. If laundromat has added to the cl_revoke list before
> the arrival of FREE_STATEID, then nfsd4_free_stateid() knows to remove
> it from the list. If nfsd4_free_stateid() finds that operations arrived
> before laundromat has placed it on cl_revoke list, it marks the state
> freed and then laundromat will no longer add it to the list.
>
> Also, for nfsd4_delegreturn() when looking for the specified stid,
> we need to access stid that are marked removed or freeable, it means
> the laundromat has started processing it but hasn't finished and this
> delegreturn needs to return nfserr_deleg_revoked and not
> nfserr_bad_stateid. The latter will not trigger a FREE_STATEID and the
> lack of it will leave this stid on the cl_revoked list indefinitely.
>
> The Linux kernel CVE team has assigned CVE-2024-50106 to this issue.
>
>
> Affected and fixed versions
> ===========================
>
> 	Issue introduced in 3.17 with commit 2d4a532d385f and fixed in 6.11.6 with commit 967faa26f313
> 	Issue introduced in 3.17 with commit 2d4a532d385f and fixed in 6.12-rc5 with commit 8dd91e8d31fe
>
> Please see https://www.kernel.org for a full list of currently supported
> kernel versions by the kernel community.
>
> Unaffected versions might change over time as fixes are backported to
> older supported kernel versions.  The official CVE entry at
> 	https://cve.org/CVERecord/?id=CVE-2024-50106
> will be updated if fixes are backported, please check that for the most
> up to date information about this issue.
>
>
> Affected files
> ==============
>
> The file(s) affected by this issue are:
> 	fs/nfsd/nfs4state.c
> 	fs/nfsd/state.h
>
>
> Mitigation
> ==========
>
> The Linux kernel CVE team recommends that you update to the latest
> stable kernel version for this, and many other bugfixes.  Individual
> changes are never tested alone, but rather are part of a larger kernel
> release.  Cherry-picking individual commits is not recommended or
> supported by the Linux kernel community at all.  If however, updating to
> the latest release is impossible, the individual changes to resolve this
> issue can be found at these commits:
> 	https://git.kernel.org/stable/c/967faa26f313a62e7bebc55d5b8122eaee43b929
> 	https://git.kernel.org/stable/c/8dd91e8d31febf4d9cca3ae1bb4771d33ae7ee5a

