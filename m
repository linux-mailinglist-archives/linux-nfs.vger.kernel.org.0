Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBC271CA02F
	for <lists+linux-nfs@lfdr.de>; Fri,  8 May 2020 03:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgEHBjQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 7 May 2020 21:39:16 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4283 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726518AbgEHBjO (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 7 May 2020 21:39:14 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 919F6D0D62CC164AF885;
        Fri,  8 May 2020 09:39:10 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Fri, 8 May 2020 09:39:03 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <bfields@fieldses.org>, <chuck.lever@oracle.com>,
        <trond.myklebust@hammerspace.com>, <anna.schumaker@netapp.com>,
        <davem@davemloft.net>, <kuba@kernel.org>
CC:     <linux-nfs@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <wangxiongfeng2@huawei.com>
Subject: [PATCH 0/2] sunrpc: add missing newline when printing module parameters by sysfs
Date:   Fri, 8 May 2020 09:32:58 +0800
Message-ID: <1588901580-44687-1-git-send-email-wangxiongfeng2@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

When I cat parameters below ''/sys/module/sunrpc/parameters/', I found the 
following two parameter need a new line.

[root@hulk-202 ~]# cat /sys/module/sunrpc/parameters/pool_mode
global[root@hulk-202 ~]# cat /sys/module/sunrpc/parameters/auth_hashtable_size
16[root@hulk-202 ~]#

Xiongfeng Wang (2):
  sunrpc: add missing newline when printing parameter 'pool_mode' by
    sysfs
  sunrpc: add missing newline when printing parameter
    'auth_hashtable_size' by sysfs

 net/sunrpc/auth.c |  2 +-
 net/sunrpc/svc.c  | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

-- 
1.7.12.4

