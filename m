Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 093EA676B0F
	for <lists+linux-nfs@lfdr.de>; Sun, 22 Jan 2023 05:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjAVEnR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 21 Jan 2023 23:43:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjAVEnR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 21 Jan 2023 23:43:17 -0500
Received: from out28-58.mail.aliyun.com (out28-58.mail.aliyun.com [115.124.28.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2A023131
        for <linux-nfs@vger.kernel.org>; Sat, 21 Jan 2023 20:43:14 -0800 (PST)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1565999|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0620024-0.00028846-0.937709;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047205;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=1;RT=1;SR=0;TI=SMTPD_---.QzYYT9s_1674362592;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.QzYYT9s_1674362592)
          by smtp.aliyun-inc.com;
          Sun, 22 Jan 2023 12:43:12 +0800
Date:   Sun, 22 Jan 2023 12:43:13 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     linux-nfs@vger.kernel.org
Subject: any guide to install/test nfs sec=krb5?
Message-Id: <20230122124313.31CB.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.81.04 [en]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

Is there any guide to install/test nfs sec=krb5?

test env:
krb5 server : windows  active directory
linux: rocky linux 9.1,  already 'realm join' with sssd.

1) from redhat
https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/9/html/configuring_and_using_network_file_services/securing-nfs_configuring-and-using-network-file-services
Procedure
Create the nfs/hostname.domain@REALM principal on the NFS server side.
Create the host/hostname.domain@REALM principal on both the server and the client side.
Add the corresponding keys to keytabs for the client and server.

but we need more detail.


2, from isilon
http://doc.isilon.com/ECS/3.3/AdminGuide/ecs_t_file_access_confgure_kerberos.html
http://doc.isilon.com/ECS/3.7/AdminGuide/GUID-2018CF69-5F1E-4F3A-BA90-3659F85DE415.html
more detail than redhat.

but the following fail.
Test registration by running.
kinit -k host/<fqdn>@NFS-REALM.LOCAL

host/<fqdn> will is already created when 'realm join'?
host/<fqdn> is created here again, so there is some trouble?

'kinit -k nfs/<fqdn>@NFS-REALM.LOCAL' works as the document.


any guide please, thanks a lot.

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2023/01/22


