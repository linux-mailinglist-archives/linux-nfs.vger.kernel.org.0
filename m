Return-Path: <linux-nfs+bounces-13962-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A36B3DD99
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Sep 2025 11:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A1A87AF279
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Sep 2025 09:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0A63043B0;
	Mon,  1 Sep 2025 09:07:47 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7205259CA3;
	Mon,  1 Sep 2025 09:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756717667; cv=none; b=PAxAsoowNbZ/emGutL0ruTyBpmOOGOohl/pkzuUAEmuPAhFkrEYRsSqxfGJAm/AH4+cTNvzQ4LMP2+eQAxFRXp5E3Q0mA3uggT8JdytkoqZP/FVkMA1Q1tXU/V0BcF4Z3CNhSXRgCw+mISm454BlVcy1Gu77RKC30F+mPC0APHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756717667; c=relaxed/simple;
	bh=tDNOYerZSrcEkI2xl7rcTVr1tudkesmYvSal+nq5LTI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BNgLE0C2Mlx5LiF9/HFmatA6iJqIUDVtgjVu0DPAbemDiuQHdWVZWA7JJdt+pxUX0rN2EVJXtuwcJ2h+1sNiyRRQT1AYiTyIROxeyAfhH1AjHC+1z4u9HRJBpL37A0wgnl36lVQwfWn7MHXJvElpTaxpFEX043exF6oBouyL9HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4cFjZm5zvhz2CgSh;
	Mon,  1 Sep 2025 17:03:12 +0800 (CST)
Received: from kwepemj200013.china.huawei.com (unknown [7.202.194.25])
	by mail.maildlp.com (Postfix) with ESMTPS id EDE9C140109;
	Mon,  1 Sep 2025 17:07:40 +0800 (CST)
Received: from [10.174.179.155] (10.174.179.155) by
 kwepemj200013.china.huawei.com (7.202.194.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 1 Sep 2025 17:07:39 +0800
Message-ID: <de669327-c93a-49e5-a53b-bda9e67d34a2@huawei.com>
Date: Mon, 1 Sep 2025 17:07:39 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [Question]nfs: never returned delegation
To: Trond Myklebust <trondmy@kernel.org>, "zhangjian (CG)"
	<zhangjian496@huawei.com>, <anna@kernel.org>
CC: <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Chuck Lever
	<chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, NeilBrown
	<neil@brown.name>, yangerkun <yangerkun@huawei.com>, "zhangyi (F)"
	<yi.zhang@huawei.com>, Hou Tao <houtao1@huawei.com>,
	"chengzhihao1@huawei.com" <chengzhihao1@huawei.com>, Li Lingfeng
	<lilingfeng@huaweicloud.com>
References: <ff8debe9-6877-4cf7-ba29-fc98eae0ffa0@huawei.com>
 <e539e0ed77438b4f4353a78451add2ab5e69ec38.camel@kernel.org>
From: Li Lingfeng <lilingfeng3@huawei.com>
In-Reply-To: <e539e0ed77438b4f4353a78451add2ab5e69ec38.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemj200013.china.huawei.com (7.202.194.25)

Hi,

在 2025/8/11 21:03, Trond Myklebust 写道:
> On Mon, 2025-08-11 at 20:48 +0800, zhangjian (CG) wrote:
>> Recently, we meet a NFS problem in 5.10. There are so many
>> test_state_id request after a non-privilaged request in tcpdump
>> result. There are 40w+ delegations in client (I read the delegation
>> list from /proc/kcore).
>> Firstly, I think state manager cost a lot in
>> nfs_server_reap_expired_delegations. But I see they are all in
>> NFS_DELEGATION_REVOKED state except 6 in NFS_DELEGATION_REFERENCED (I
>> read this from /proc/kcore too).
>> I analyze NFS code and find if NFSPROC4_CLNT_DELEGRETURN procedure
>> meet ETIMEOUT, delegation will be marked as NFS4ERR_DELEG_REVOKED and
>> never return it again. NFS server will keep the revoked delegation in
>> clp->cl_revoked forever. This will result in following sequence
>> response with RECALLABLE_STATE_REVOKED flag. Client will send
>> test_state_id request for all non-revoked delegation.
>> This can only be solved by restarting NFS server.
>> I think ETIMEOUT in NFSPROC4_CLNT_DELEGRETURN procedure may be not
>> the only case that cause lots of non-terminable test_state_id
>> requests after any non-privilaged request.
>> Wish NFS experts give some advices on this problem.
>>
> You have the following options:
>
>     1. Don't ever use "soft" or "softerr" on the NFS client.
>     2. Reboot your server every now and again.
>     3. Change the server code to not bother caching revoked state. Doing
>        so is rather pointless, since there is nothing a client can do
>        differently when presented with NFS4ERR_DELEG_REVOKED vs.
>        NFS4ERR_BAD_STATEID.
>     4. Change the server code to garbage collect revoked stateids after
>        a while.
>
I found that a server-side bug could also cause such behavior, and I've
reproduced the issue based on the master (commit b320789d6883).
nfs4_laundromat                       nfsd4_delegreturn
  list_add // add dp to reaplist
           // by dl_recall_lru
  list_del_init // delete dp from
                // reaplist
                                        destroy_delegation
                                         unhash_delegation_locked
                                          list_del_init
                                          // dp was not added to any list
                                          // via dl_recall_lru
  revoke_delegation
  list_add // add dp to cl_revoked
           // by dl_recall_lru

The delegation will be left in cl_revoked.

I agree with Trond's suggestion to change the server code to fix it.

Thanks,
Lingfeng

