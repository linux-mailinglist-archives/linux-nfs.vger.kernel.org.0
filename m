Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 534A254C8C8
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jun 2022 14:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343511AbiFOMns (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 15 Jun 2022 08:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348747AbiFOMnm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 15 Jun 2022 08:43:42 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B972E22
        for <linux-nfs@vger.kernel.org>; Wed, 15 Jun 2022 05:43:41 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4LNQ2S1jY6zDrK8;
        Wed, 15 Jun 2022 20:43:12 +0800 (CST)
Received: from kwepemm600015.china.huawei.com (7.193.23.52) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 15 Jun 2022 20:43:38 +0800
Received: from [10.174.176.52] (10.174.176.52) by
 kwepemm600015.china.huawei.com (7.193.23.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 15 Jun 2022 20:43:37 +0800
Message-ID: <ff6de37e-899a-8b23-d1a9-bf11fde10e5d@huawei.com>
Date:   Wed, 15 Jun 2022 20:43:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "zhangxiaoxu5@huawei.com" <zhangxiaoxu5@huawei.com>
From:   "chenxiaosong (A)" <chenxiaosong2@huawei.com>
Subject: Question about reporting unexpected wb err in nfs write()/flush()
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.52]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600015.china.huawei.com (7.193.23.52)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Trond:

OK, I understand, I will not clear wb err in close(). I will not change 
rules that apply to all filesystems.

But if old wb err (such as -ERESTARTSYS or -EINTR, etc.) exist in struct 
address_space->wb_err, nfs_file_write() will always return the 
unexpected error. filemap_check_wb_err() will return the old error even 
if there is no new writeback error between filemap_sample_wb_err() and 
filemap_check_wb_err().
```c
    since = filemap_sample_wb_err() = 0 // never be error
      errseq_sample
        if (!(old & ERRSEQ_SEEN)) // nobody see the error
          return 0;
    nfs_wb_all // no new error
    error = filemap_check_wb_err(..., since) != 0 // unexpected error
```

I will fix this by store old err before filemap_sample_wb_err(), and 
restore old err after filemap_check_wb_err():
```c
   // Store the wb err
   old_err = file_check_and_advance_wb_err(file)
   since = filemap_sample_wb_err()
   nfs_wb_all // detect new wb err
   error = filemap_check_wb_err(..., since)
   // Restore old wb err if no new err is detected
   if (!error && old_err)
   errseq_set(&file->f_mapping->wb_err, old_err);
```

Is my fixes reasonable ?
