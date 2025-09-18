Return-Path: <linux-nfs+bounces-14566-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20666B84EE5
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Sep 2025 15:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E71D31B27B3A
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Sep 2025 13:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F8122A7E2;
	Thu, 18 Sep 2025 13:58:08 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FEC22A4FC;
	Thu, 18 Sep 2025 13:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758203888; cv=none; b=kxbVUbapYr4hXvwyFMn48brEeI4etXZikONfA049++OEimMuUW3E+JOZAf1Ih4pdb972Q0VJlLtBu38m8+J7yz+hLhawpUc7nghF+kEB/jqSPTi0NOG9wKw8hOJNVKLUTm6NV5dMI9kpKDpYkiRm3TW7F7k3DmMrkCEsnI2c210=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758203888; c=relaxed/simple;
	bh=Y9bxL/FUIvRSnifQ87FvBbYFnHGqwIUE5l6I5v2tr/I=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:CC:Content-Type; b=ubLkzY3zaDh//T5i4E/YbXSAkQHzAmeyWUe9KjiEG+0eLXaTSWR3gVgZrh5ufTK0J7QfahsBjV24N0Mf4puPZeTW78UqA2nXDcodQJcaeoFqYxQLJq8VeHWDu6zXdW9wCBqaLkzZlFxEU9Y8CE8Xk4cZ5HRMwZsYqPM3o2pxxIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4cSHDG0VBbz13NgR;
	Thu, 18 Sep 2025 21:53:50 +0800 (CST)
Received: from kwepemj200013.china.huawei.com (unknown [7.202.194.25])
	by mail.maildlp.com (Postfix) with ESMTPS id 3803B140137;
	Thu, 18 Sep 2025 21:58:01 +0800 (CST)
Received: from [10.174.179.155] (10.174.179.155) by
 kwepemj200013.china.huawei.com (7.202.194.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 18 Sep 2025 21:58:00 +0800
Message-ID: <34bd5595-8f3f-4c52-a1d5-d782fc99efb9@huawei.com>
Date: Thu, 18 Sep 2025 21:57:59 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
To: Dai Ngo <Dai.Ngo@oracle.com>, Chuck Lever <chuck.lever@oracle.com>, Jeff
 Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, Olga Kornievskaia
	<okorniev@redhat.com>, Tom Talpey <tom@talpey.com>
From: Li Lingfeng <lilingfeng3@huawei.com>
Subject: [Question] nfsd: possible reordering between nf->nf_file assignment
 and NFSD_FILE_PENDING clearing?
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>, yangerkun
	<yangerkun@huawei.com>, "zhangyi (F)" <yi.zhang@huawei.com>, Hou Tao
	<houtao1@huawei.com>, "chengzhihao1@huawei.com" <chengzhihao1@huawei.com>,
	"yukuai (C)" <yukuai3@huawei.com>, <leo.lilong@huawei.com>,
	<wutengda2@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemj200013.china.huawei.com (7.202.194.25)

Recently, we encountered a null pointer dereference on a relatively old
5.10 kernel that does not include commit c4c649ab413ba ("NFSD: Convert
filecache to rhltable"), which exhibited the same behavior as described
in [1]. I was wondering if it might be caused by the reordering between
the assignment of nf->nf_file and the clearing of NFSD_FILE_PENDING.

Just to mention, I don't believe the analysis in [1] is entirely accurate,
since hlist_add_head_rcu includes a write barrier.

We haven't encountered this issue on newer kernel versions, but the
assignment of nf->nf_file and the clearing of NFSD_FILE_PENDING appear
consistent across different versions.

Our expected outcome should be like this:
                 T1                                    T2
nfsd_read
  nfsd_file_acquire_gc
   nfsd_file_do_acquire
    nfsd_file_lookup_locked
     // get nfsd_file from nfsd_file_rhltable
                                         nfsd_read
                                          nfsd_file_acquire_gc
                                           nfsd_file_do_acquire
                                            nfsd_file_alloc
                                             nf->nf_flags // set 
NFSD_FILE_PENDING
                                            rhltable_insert // insert to 
nfsd_file_rhltable
                                            nf->nf_file = file // set 
nf_file
    wait_on_bit
    // wait NFSD_FILE_PENDING to be cleared
                                            clear_and_wake_up_bit // 
clear NFSD_FILE_PENDING
    // get file after being awakened
  file = nf->nf_file

Or like this:
                 T1                                    T2
nfsd_read
  nfsd_file_acquire_gc
   nfsd_file_do_acquire
    nfsd_file_lookup_locked
     // get nfsd_file from nfsd_file_rhltable
                                         nfsd_read
                                          nfsd_file_acquire_gc
                                           nfsd_file_do_acquire
                                            nfsd_file_alloc
                                             nf->nf_flags // set 
NFSD_FILE_PENDING
                                            rhltable_insert // insert to 
nfsd_file_rhltable
                                            nf->nf_file = file // set 
nf_file
                                            clear_and_wake_up_bit // 
clear NFSD_FILE_PENDING
    // get file directly
  file = nf->nf_file

But is it possible that due to reordering, it ends up like this:
                 T1                                    T2
nfsd_read
  nfsd_file_acquire_gc
   nfsd_file_do_acquire
    nfsd_file_lookup_locked
     // get nfsd_file from nfsd_file_rhltable
                                         nfsd_read
                                          nfsd_file_acquire_gc
                                           nfsd_file_do_acquire
                                            nfsd_file_alloc
                                             nf->nf_flags // set 
NFSD_FILE_PENDING
                                            rhltable_insert // insert to 
nfsd_file_rhltable
                                            clear_and_wake_up_bit // 
clear NFSD_FILE_PENDING
    // get file directly
  file = nf->nf_file
                                            nf->nf_file = file // set 
nf_file
  // Null dereference due to uninitialized file pointer.

[1]: 
https://lore.kernel.org/all/20230818065507.1280625-1-haydenw.kernel@gmail.com/

Any suggestion will be appreciated.

Thanks,
Lingfeng.


