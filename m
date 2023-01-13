Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BDCD669F07
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Jan 2023 18:06:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjAMRGm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Jan 2023 12:06:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjAMRGh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Jan 2023 12:06:37 -0500
Received: from out20-3.mail.aliyun.com (out20-3.mail.aliyun.com [115.124.20.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 745CBD2F4
        for <linux-nfs@vger.kernel.org>; Fri, 13 Jan 2023 09:06:32 -0800 (PST)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.05114544|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.102835-0.00427078-0.892894;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047198;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.Qry5mT3_1673629588;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.Qry5mT3_1673629588)
          by smtp.aliyun-inc.com;
          Sat, 14 Jan 2023 01:06:29 +0800
Date:   Sat, 14 Jan 2023 01:06:29 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
Subject: Re: a dead lock of 'umount.nfs4 /nfs/scratch -l'
Cc:     Charles Edward Lever <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
In-Reply-To: <FBFF4BF0-EC67-472B-9B8A-A0891B1EFA90@hammerspace.com>
References: <5B9215E4-99FF-4C52-901F-8D909DD165BD@oracle.com> <FBFF4BF0-EC67-472B-9B8A-A0891B1EFA90@hammerspace.com>
Message-Id: <20230114010628.D465.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 8bit
X-Mailer: Becky! ver. 2.81.04 [en]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

> 
> > On Jan 13, 2023, at 09:41, Chuck Lever III <chuck.lever@oracle.com> wrote:
> > 
> > 
> > 
> >> On Jan 12, 2023, at 4:30 AM, Wang Yugui <wangyugui@e16-tech.com> wrote:
> >> 
> >> Hi,
> >> 
> >>> Hi,
> >>> 
> >>>> Hi,
> >>>> 
> >>>> We noticed a dead lock of 'umount.nfs4 /nfs/scratch -l'
> >>> 
> >>> reproducer:
> >>> 
> >>> mount /dev/sda1 /mnt/test/
> >>> mount /dev/sda2 /mnt/scratch/
> >>> systemctl restart nfs-server.service
> >>> mount.nfs4 127.0.0.1:/mnt/test/ /nfs/test/
> >>> mount.nfs4 127.0.0.1:/mnt/scratch/ /nfs/scratch/
> >>> systemctl stop nfs-server.service
> >>> umount -l /nfs/scratch #OK
> >>> umount -l /nfs/test #dead lock
> >>> 
> >>> Best Regards
> >>> Wang Yugui (wangyugui@e16-tech.com)
> >>> 2023/01/11
> >>> 
> >>>> kernel: 6.1.5-rc1
> >> 
> >> This problem happen on kernel 6.2.0-rc3+(upstream) too.
> > 
> > Can you clarify:
> > 
> > - By "deadlock" do you mean the system becomes unresponsive, or that
> >  just the mount is stuck?
> > 
> > - Can you reproduce in a non-loopback scenario: a separate client and
> >  server?
> > 
> 
> I¡¯m not seeing how the use of the ¡®-l¡¯ flag is at all relevant here. The exact same thing will happen if you don¡¯t use ¡®-l¡¯. All the latter does is hide the fact that it is happening from user space.
> 
> As far as I¡¯m concerned, this is pretty much expected behaviour when you turn off the server before unmounting. It means that the client can¡¯t flush any remaining dirty data to the server and it can¡¯t clean up state. So just don¡¯t do that?

In the case, 'df -h' will fail to work without the 'umount -l'.

so I thought we should make 'umount -l' to works.

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2023/01/14

