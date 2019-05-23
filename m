Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA1BB28209
	for <lists+linux-nfs@lfdr.de>; Thu, 23 May 2019 17:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730867AbfEWP7e (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 23 May 2019 11:59:34 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:41224 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730790AbfEWP7e (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 23 May 2019 11:59:34 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=xuyu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0TSUF5sN_1558627171;
Received: from ali-6c96cfe0d157.local(mailfrom:xuyu@linux.alibaba.com fp:SMTPD_---0TSUF5sN_1558627171)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 23 May 2019 23:59:31 +0800
To:     gregkh@linuxfoundation.org, kolga@netapp.com,
        linux-nfs@vger.kernel.org
From:   Yu Xu <xuyu@linux.alibaba.com>
Subject: [backport request][stable] NFSv4.x: fix incorrect return value in
 copy_file_range
Cc:     joseph.qi@linux.alibaba.com, caspar@linux.alibaba.com
Message-ID: <0f0e59bd-2520-e265-265e-4a29bf776c60@linux.alibaba.com>
Date:   Thu, 23 May 2019 23:59:30 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

I'm using kernel v4.19.y and find that v4.19.y fails in the latest 
xfstests generic/075, 091, 112, 127 and 263, which can be simply 
reproduced as follows:

# kernel 4.19.y
$ xfs_io -fc "copy_range -s 0 -d 1 -l 1 /mnt/nfs/file" /mnt/nfs/file
copy_range: Invalid argument

# kernel 5.1.0
$ xfs_io -fc "copy_range -s 0 -d 1 -l 1 /mnt/nfs/file" /mnt/nfs/file
# success

I notice that upstream (v5.1+) has already fixed this issue with:
1) commit 45ac486ecf2dc998e25cf32f0cabf2deaad875be
2) commit 0769663b4f580566ef6cdf366f3073dbe8022c39

But these patches do not cc stable@vger.kernel.org (why? forgotten?). 
And will v4.19.y consider to backport these patches?


Thanks,
Yu






