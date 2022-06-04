Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C09CA53D7AC
	for <lists+linux-nfs@lfdr.de>; Sat,  4 Jun 2022 18:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238071AbiFDQPA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 4 Jun 2022 12:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbiFDQO4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 4 Jun 2022 12:14:56 -0400
Received: from out20-25.mail.aliyun.com (out20-25.mail.aliyun.com [115.124.20.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD682F39D
        for <linux-nfs@vger.kernel.org>; Sat,  4 Jun 2022 09:14:53 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.0602784|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00982534-0.000584877-0.98959;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047204;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.Nz4mdg-_1654359289;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.Nz4mdg-_1654359289)
          by smtp.aliyun-inc.com(33.37.68.185);
          Sun, 05 Jun 2022 00:14:49 +0800
Date:   Sun, 05 Jun 2022 00:14:52 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Chuck Lever III <chuck.lever@oracle.com>
Subject: Re: filecache LRU performance regression
Cc:     Frank van der Linden <fllinden@amazon.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Matthew Wilcox <matthew.wilcox@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
In-Reply-To: <1D00FCD4-8EFE-4080-A706-61FD7886CA52@oracle.com>
References: <20220602094956.A396.409509F4@e16-tech.com> <1D00FCD4-8EFE-4080-A706-61FD7886CA52@oracle.com>
Message-Id: <20220605001452.5CD6.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.04 [en]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

> > On Jun 1, 2022, at 9:49 PM, Wang Yugui <wangyugui@e16-tech.com> wrote:
> > 
> > Hi,
> > 
> >> Certainly, though, the filecache plays somewhat different roles
> >> for legacy NFS and NFSv4. I've been toying with the idea of
> >> maintaining separate filecaches for NFSv3 and NFSv4, since
> >> the garbage collection and shrinker rules are fundamentally
> >> different for the two, and NFSv4 wants a file closed completely
> >> (no lingering open) when it does a CLOSE or DELEGRETURN.
> > 
> > if NFSv4 closed a file completely (no lingering open) when it does a
> > CLOSE or DELEGRETURN,
> > then the flowing problem seems to be fixed too.
> > https://lore.kernel.org/linux-nfs/20211002111419.2C83.409509F4@e16-tech.com/
> 
> I agree, that's probably related.
> 
> But let's document this issue as a separate bug, in case it
> isn't actually as related as it looks like at first. Can you
> open a bug report on bugzilla.linux-nfs.org? kernel/server
> 
> --
> Chuck Lever

I opened  a bug report in bugzilla.linux-nfs.org
https://bugzilla.linux-nfs.org/show_bug.cgi?id=387

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2022/06/05

