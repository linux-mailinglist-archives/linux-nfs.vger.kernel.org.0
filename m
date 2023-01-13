Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D66AB669EF9
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Jan 2023 18:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjAMRA4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Jan 2023 12:00:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjAMRAt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Jan 2023 12:00:49 -0500
Received: from out20-50.mail.aliyun.com (out20-50.mail.aliyun.com [115.124.20.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F095841A6A
        for <linux-nfs@vger.kernel.org>; Fri, 13 Jan 2023 09:00:39 -0800 (PST)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.05891162|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0254068-0.000303933-0.974289;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047199;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.QryFXa5_1673629230;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.QryFXa5_1673629230)
          by smtp.aliyun-inc.com;
          Sat, 14 Jan 2023 01:00:31 +0800
Date:   Sat, 14 Jan 2023 01:00:31 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Chuck Lever III <chuck.lever@oracle.com>
Subject: Re: a dead lock of 'umount.nfs4 /nfs/scratch -l'
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
In-Reply-To: <5B9215E4-99FF-4C52-901F-8D909DD165BD@oracle.com>
References: <20230112173046.82E4.409509F4@e16-tech.com> <5B9215E4-99FF-4C52-901F-8D909DD165BD@oracle.com>
Message-Id: <20230114010030.D461.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.81.04 [en]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

> > On Jan 12, 2023, at 4:30 AM, Wang Yugui <wangyugui@e16-tech.com> wrote:
> > 
> > Hi,
> > 
> >> Hi,
> >> 
> >>> Hi,
> >>> 
> >>> We noticed a dead lock of 'umount.nfs4 /nfs/scratch -l'
> >> 
> >> reproducer:
> >> 
> >> mount /dev/sda1 /mnt/test/
> >> mount /dev/sda2 /mnt/scratch/
> >> systemctl restart nfs-server.service
> >> mount.nfs4 127.0.0.1:/mnt/test/ /nfs/test/
> >> mount.nfs4 127.0.0.1:/mnt/scratch/ /nfs/scratch/
> >> systemctl stop nfs-server.service
> >> umount -l /nfs/scratch #OK
> >> umount -l /nfs/test #dead lock
> >> 
> >> Best Regards
> >> Wang Yugui (wangyugui@e16-tech.com)
> >> 2023/01/11
> >> 
> >>> kernel: 6.1.5-rc1
> > 
> > This problem happen on kernel 6.2.0-rc3+(upstream) too.
> 
> Can you clarify:
> 
> - By "deadlock" do you mean the system becomes unresponsive, or that
>   just the mount is stuck?

Just the 'mount -l' is stuck.
'Ctrl +C' can stop the 'mount -l', and then the mount point disapear.

> - Can you reproduce in a non-loopback scenario: a separate client and
>   server?

Yes. It happened on separate nfs client and  server too.

tested kernel version: 5.15.85, 6.1.5, 6.2.0-rc3+(upstream)

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2023/01/14

