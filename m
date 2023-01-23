Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD8D2677490
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Jan 2023 05:08:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbjAWEIm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 22 Jan 2023 23:08:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjAWEIl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 22 Jan 2023 23:08:41 -0500
Received: from out28-43.mail.aliyun.com (out28-43.mail.aliyun.com [115.124.28.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99250F74D
        for <linux-nfs@vger.kernel.org>; Sun, 22 Jan 2023 20:08:39 -0800 (PST)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.06008863|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0652376-0.000505812-0.934257;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047190;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=1;RT=1;SR=0;TI=SMTPD_---.R-NMqVF_1674446916;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.R-NMqVF_1674446916)
          by smtp.aliyun-inc.com;
          Mon, 23 Jan 2023 12:08:37 +0800
Date:   Mon, 23 Jan 2023 12:08:37 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     linux-nfs@vger.kernel.org
Subject: Re: any guide to install/test nfs sec=krb5?
In-Reply-To: <20230123015546.5653.409509F4@e16-tech.com>
References: <20230122124313.31CB.409509F4@e16-tech.com> <20230123015546.5653.409509F4@e16-tech.com>
Message-Id: <20230123120836.1D16.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.81.04 [en]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

> Hi,
> 
> > Is there any guide to install/test nfs sec=krb5?
> 
> A better document:
> https://www.delltechnologies.com/asset/en-us/products/storage/industry-market/h17769_integrating_onefs_with_kerberos_wp.pdf
> 3.1.2 Configurations for Kerberized NFS with AD
> 
> we just directly add nfs/ SPN in 'Figure 5 Check SPNs in AD'.
> and we no longer need ''ktpass.exe -mapUse'  in another document:
> http://doc.isilon.com/ECS/3.3/AdminGuide/ecs_t_file_access_confgure_kerberos.html
> http://doc.isilon.com/ECS/3.7/AdminGuide/GUID-2018CF69-5F1E-4F3A-BA90-3659F85DE415.html
> 
> and then 'mount.nfs4 -o sec=krb5' works in rocky linux 9.1.

I test more case with different nfs server / nfs client version.

SPN host/
	'realm join' auto create
SPN nfs/
	setspn.exe -S nfs/T3610 T3610; 	setspn.exe -S nfs/T3610.e16-tech.com T3610

'kinit -k  nfs/t3610.e16-tech.com@E16-TECH.COM' no need to work
'kinit -k host/t3610.e16-tech.com@E16-TECH.COM' no need to work.

el9: rocky linux 9.1
el8: oracle linux 8.6
el7: centos 7.9

nfs-server/el9   nfs-client OK/el7, *1/el8, OK/el9
nfs-server/el8   nfs-client OK/el7, *1/el8, *1/*2/el9
nfs-server/el7   nfs-client OK/el7, OK/el8, *1/*2/el9
   *1 Permission denied
   *2 Invalid argument     # when kernel 5.15 in nfs-server, kerenl 6.1 in nfs-client

nfs-utils version:  1.3.0/el7, 2.3.3/el8, 2.5.4/el9
kernel: same 5.15.y/6.1.y on el9/el8/el7

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2023/01/23

> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2023/01/23
> 
> > test env:
> > krb5 server : windows  active directory
> > linux: rocky linux 9.1,  already 'realm join' with sssd.
> > 
> > 1) from redhat
> > https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/9/html/configuring_and_using_network_file_services/securing-nfs_configuring-and-using-network-file-services
> > Procedure
> > Create the nfs/hostname.domain@REALM principal on the NFS server side.
> > Create the host/hostname.domain@REALM principal on both the server and the client side.
> > Add the corresponding keys to keytabs for the client and server.
> > 
> > but we need more detail.
> > 
> > 
> > 2, from isilon
> > http://doc.isilon.com/ECS/3.3/AdminGuide/ecs_t_file_access_confgure_kerberos.html
> > http://doc.isilon.com/ECS/3.7/AdminGuide/GUID-2018CF69-5F1E-4F3A-BA90-3659F85DE415.html
> > more detail than redhat.
> > 
> > but the following fail.
> > Test registration by running.
> > kinit -k host/<fqdn>@NFS-REALM.LOCAL
> > 
> > host/<fqdn> will is already created when 'realm join'?
> > host/<fqdn> is created here again, so there is some trouble?
> > 
> > 'kinit -k nfs/<fqdn>@NFS-REALM.LOCAL' works as the document.
> > 
> > 
> > any guide please, thanks a lot.
> > 
> > Best Regards
> > Wang Yugui (wangyugui@e16-tech.com)
> > 2023/01/22
> > 
> 


