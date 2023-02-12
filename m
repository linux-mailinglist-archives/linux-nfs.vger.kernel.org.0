Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09873693637
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Feb 2023 07:04:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbjBLGBz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 12 Feb 2023 01:01:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjBLGBy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 12 Feb 2023 01:01:54 -0500
Received: from out28-82.mail.aliyun.com (out28-82.mail.aliyun.com [115.124.28.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA456586
        for <linux-nfs@vger.kernel.org>; Sat, 11 Feb 2023 22:01:50 -0800 (PST)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.2370305|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0421209-0.00164326-0.956236;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047206;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=1;RT=1;SR=0;TI=SMTPD_---.RJZeVeK_1676181707;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.RJZeVeK_1676181707)
          by smtp.aliyun-inc.com;
          Sun, 12 Feb 2023 14:01:47 +0800
Date:   Sun, 12 Feb 2023 14:01:48 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     linux-nfs@vger.kernel.org
Subject: question about the performance impact of sec=krb5
Message-Id: <20230212140148.4F0D.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.81.04 [en]
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,URI_TRY_3LD autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

question about the performance of sec=krb5.

https://learn.microsoft.com/en-us/azure/azure-netapp-files/performance-impact-kerberos
Performance impact of krb5:
	Average IOPS decreased by 53%
	Average throughput decreased by 53%
	Average latency increased by 3.2 ms

and then in 'man 5 nfs'
sec=krb5  provides cryptographic proof of a user's identity in each RPC request.

Is there a option of better performance to check krb5 only when mount.nfs4,
not when file acess?

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2023/02/12


