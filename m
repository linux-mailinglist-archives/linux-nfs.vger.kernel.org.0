Return-Path: <linux-nfs+bounces-8221-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0186C9D9877
	for <lists+linux-nfs@lfdr.de>; Tue, 26 Nov 2024 14:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DB15B2C989
	for <lists+linux-nfs@lfdr.de>; Tue, 26 Nov 2024 13:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA701D47D2;
	Tue, 26 Nov 2024 13:22:38 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1141D5140;
	Tue, 26 Nov 2024 13:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732627358; cv=none; b=TOJ2xToPwypkRLgUOuRpLlP+hcpytLliEcy1v0s2LRYCxs1Kv4C1cseS6BG9hxboCES86IB7qfNKERls3Q5mqbz1UbuNZD5OhAXSoaxYVC5yUs59NcOiwUm36xiC1+KVPWxl4w7VNVF8dwHEUsTAmrZ4tmiyYNcb860lFF2kMVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732627358; c=relaxed/simple;
	bh=6jshdgel+VxnNRWgH3u9JS+wG7b3RqMgAN8FYNpngK8=;
	h=Message-ID:Date:MIME-Version:To:CC:From:Subject:Content-Type; b=RrAivgd3iaX6NdKEpMMVT/A7SIX6fTkkAOK3B/IWX6MWtGaeZf5wqzk/k6HemzILC1keKqcUPHYITamWcCA05BiXeFVf1utGaHG/ObdxSgGbniCYm6BrbqpqvbxIg1ghgtU276wuqMXyTZTbrpFKNt7ZGDQVIh6KXiJGVPycmbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XyNVL6sSTz1k0V3;
	Tue, 26 Nov 2024 21:20:26 +0800 (CST)
Received: from kwepemg500017.china.huawei.com (unknown [7.202.181.81])
	by mail.maildlp.com (Postfix) with ESMTPS id 8CC1A14010C;
	Tue, 26 Nov 2024 21:22:33 +0800 (CST)
Received: from [10.174.179.155] (10.174.179.155) by
 kwepemg500017.china.huawei.com (7.202.181.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 26 Nov 2024 21:22:32 +0800
Message-ID: <d695379f-3dbb-4e5a-a857-e4cd31df6843@huawei.com>
Date: Tue, 26 Nov 2024 21:22:31 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
To: <trondmy@kernel.org>, <anna@kernel.org>,
	<trond.myklebust@hammerspace.com>, Jeff Layton <jlayton@kernel.org>
CC: <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "yukuai (C)"
	<yukuai3@huawei.com>, Hou Tao <houtao1@huawei.com>, "zhangyi (F)"
	<yi.zhang@huawei.com>, yangerkun <yangerkun@huawei.com>,
	<chengzhihao1@huawei.com>
From: Li Lingfeng <lilingfeng3@huawei.com>
Subject: [bug report] NFSv4.0: deadlock of state manager and lock
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemg500017.china.huawei.com (7.202.181.81)

Hi, we have found a deadlock recently due to that only the first task in
the list of nfs_seqid_counter can be executed.

T1 -- NFSPROC4_CLNT_LOCKU
nfs4_locku_prepare
  nfs_wait_on_sequence
   list_add_tail // add to sequence->list
   // This is the first task.

nfs4_locku_done
  nfs4_async_handle_exception
   rpc_sleep_on
   // Sleep on clp->cl_rpcwaitq,
   // and wait for being woken up by T2
   <-------- can not get here -------->
   nfs_release_seqid
    rpc_wake_up_queued_task // wake up T2

T2 -- state manager
nfs4_state_manager
  nfs4_do_reclaim
   nfs4_reclaim_open_state
    __nfs4_reclaim_open_state
     nfs40_open_expired
      nfs4_open_expired
       nfs4_do_open_expired
        _nfs4_open_expired
         nfs4_open_recover
          nfs4_open_recover_helper
           _nfs4_recover_proc_open
            nfs4_run_open_task
            ...
            nfs4_open_prepare
             nfs_wait_on_sequence
              list_add_tail // add to sequence->list
              // This is the second task.
              rpc_sleep_on
              // Sleep on sequence->wait,
              // and wait for being woken up by T1
  <-------- can not get here -------->
  nfs4_clear_state_manager_bit
   rpc_wake_up // wake up T1

T1 occupies the first position of sequence->list and waits to be woken up
by T2.
T2 has to be woken up by T1 who occupies the first position.

We haven't come up with a suitable solution yet. Any suggestions will be
appreciated.

Thanks.


