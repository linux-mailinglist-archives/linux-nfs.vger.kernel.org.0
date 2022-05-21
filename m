Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8F1852F7F9
	for <lists+linux-nfs@lfdr.de>; Sat, 21 May 2022 05:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354446AbiEUDYQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 May 2022 23:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352996AbiEUDYP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 May 2022 23:24:15 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60DF91957A0
        for <linux-nfs@vger.kernel.org>; Fri, 20 May 2022 20:24:14 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4L4pnM2BGGz1JC3y;
        Sat, 21 May 2022 11:22:47 +0800 (CST)
Received: from localhost.localdomain (10.175.101.6) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 21 May 2022 11:24:11 +0800
From:   Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
To:     <zhangxiaoxu5@huawei.com>, <bfields@fieldses.org>,
        <chuck.lever@oracle.com>, <linux-nfs@vger.kernel.org>,
        <yi.zhang@huawei.com>, <luomeng12@huawei.com>, <dai.ngo@oracle.com>
Subject: [v2 0/2] Fix null-ptr-deref in nfsd_fill_super()
Date:   Sat, 21 May 2022 12:08:43 +0800
Message-ID: <20220521040845.619409-1-zhangxiaoxu5@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Also do some clean up in init_nfsd().

Since there are much difference with the linux master branch,
@Bruce could you help to review this patch again.

Zhang Xiaoxu (2):
  nfsd: Unregister the cld notifier when laundry_wq create failed
  nfsd: Fix null-ptr-deref in nfsd_fill_super()

 fs/nfsd/nfsctl.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

-- 
2.31.1

