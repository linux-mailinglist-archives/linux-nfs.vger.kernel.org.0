Return-Path: <linux-nfs+bounces-10470-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F14A4F4D4
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Mar 2025 03:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 152B67A5FDC
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Mar 2025 02:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1A91624DE;
	Wed,  5 Mar 2025 02:43:23 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F60F1624CF;
	Wed,  5 Mar 2025 02:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741142603; cv=none; b=QfM/k6yWIYUFSDFSrBcjN2ogLqi+LUZLtULEpuojcRb2h4526mYG+cycxAPwujNC85TYsaquBg8hZbEEl470GR8moLzzVlxwmjt72QuHQDJDSi5tksCIi0IE5rIUcUFAPXjr5SOfLiZZdzqxpYtV6XwcTUwhXiAkU6C3p06vorw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741142603; c=relaxed/simple;
	bh=T7wwcQuF0jLjAOVddsO77p+yHUtwBSvUCQxUkqGtjSs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=NmmXs8l7vOKjy794qaQqP33LsrddbKvLUZnByR+qznkzFOv5HrDtYIt62SyzEW0M7JdKB5teonhMkonjP6/Hetk8S9awl8pAYUQ9CmsAXBomEZ8EsY0nMdEV9cQCMrbl9ylnJOFKy1Buw+Qe2sY4qaf1NuZ9qxcnCsJFQmVlhyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Z6xfz2MQSz4f3khS;
	Wed,  5 Mar 2025 10:42:51 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 6D0DE1A06D7;
	Wed,  5 Mar 2025 10:43:13 +0800 (CST)
Received: from [10.174.179.247] (unknown [10.174.179.247])
	by APP4 (Coremail) with SMTP id gCh0CgBXu18_usdneuVPFg--.61586S3;
	Wed, 05 Mar 2025 10:43:13 +0800 (CST)
Message-ID: <e7c72dfc-ecbc-bd99-16f6-977afa642f18@huaweicloud.com>
Date: Wed, 5 Mar 2025 10:43:11 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
From: Li Nan <linan666@huaweicloud.com>
Subject: [Bug report] NULL pointer dereference in frwr_unmap_sync()
To: linux-nfs@vger.kernel.org, linux-nfs@vger.kernel.org
Cc: chuck.lever@oracle.com,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 trondmy@hammerspace.com, sagi@grimberg.me, cel@kernel.org,
 "wanghai (M)" <wanghai38@huawei.com>, yanhaitao2@huawei.com,
 chengjike.cheng@huawei.com, dingming09@huawei.com
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgBXu18_usdneuVPFg--.61586S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tFy5Gr4rZrWrAw1UGr15Arb_yoW8Ww1Upa
	4fKw45Gr4ktw45ZFsrA3W8C3WkZFsayF15Grs7Cr93AF4Dtr12qr4UAFyjqr9rGry7Ca1r
	XF1jqa1Yqwn5Jw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBSb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487
	Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aV
	AFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E
	8cxan2IY04v7Mxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82
	IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC2
	0s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMI
	IF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF
	0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87
	Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFDGOUUUUU
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/

We found a following problem in kernel 5.10, and the same problem should
exist in mainline:

During NFS mount using 'soft' option over RoCE network, we observed kernel
crash with below trace when network issues occur (congestion/disconnect):
   nfs: server 10.10.253.211 not responding, timed out
   BUG: kernel NULL pointer dereference, address: 00000000000000a0
   RIP: 0010:frwr_unmap_sync+0x77/0x200 [rpcrdma]
   Call Trace:
    ? __die_body.cold+0x8/0xd
    ? no_context+0x155/0x230
    ? __bad_area_nosemaphore+0x52/0x1a0
    ? exc_page_fault+0x2dc/0x550
    ? asm_exc_page_fault+0x1e/0x30
    ? frwr_unmap_sync+0x77/0x200 [rpcrdma]
    xprt_release+0x9e/0x1a0 [sunrpc]
    rpc_release_resources_task+0xe/0x50 [sunrpc]
    rpc_release_task+0x19/0xa0 [sunrpc]
    rpc_async_schedule+0x29/0x40 [sunrpc]
    process_one_work+0x1b2/0x350
    worker_thread+0x49/0x310
    ? rescuer_thread+0x380/0x380
    kthread+0xfb/0x140

Problem analysis:
The crash happens in frwr_unmap_sync() when accessing req->rl_registered
list, caused by either NULL pointer or accessing freed MR resources.
There's a race condition between:
T1
__ib_process_cq
  wc->wr_cqe->done (frwr_wc_localinv)
   rpcrdma_flush_disconnect
    rpcrdma_force_disconnect
     xprt_force_disconnect
      xprt_autoclose
       xprt_rdma_close
        rpcrdma_xprt_disconnect
         rpcrdma_reqs_reset
          frwr_reset
           rpcrdma_mr_pop(&req->rl_registered)
T2					
rpc_async_schedule
  rpc_release_task
   rpc_release_resources_task
    xprt_release
     xprt_rdma_free
      frwr_unmap_sync
       rpcrdma_mr_pop(&req->rl_registered)
					
This problem also exists in function rpcrdma_mrs_destroy().

-- 
Thanks,
Nan


