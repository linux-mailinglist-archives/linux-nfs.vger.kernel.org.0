Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2170853B196
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Jun 2022 04:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232986AbiFBBuJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 1 Jun 2022 21:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232949AbiFBBuI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 1 Jun 2022 21:50:08 -0400
Received: from out20-110.mail.aliyun.com (out20-110.mail.aliyun.com [115.124.20.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4390B212571
        for <linux-nfs@vger.kernel.org>; Wed,  1 Jun 2022 18:49:58 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.3048671|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_news_journal|0.0168223-0.000627065-0.982551;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047213;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.NxZ.-1b_1654134595;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.NxZ.-1b_1654134595)
          by smtp.aliyun-inc.com(33.37.75.176);
          Thu, 02 Jun 2022 09:49:55 +0800
Date:   Thu, 02 Jun 2022 09:49:57 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Chuck Lever III <chuck.lever@oracle.com>
Subject: Re: filecache LRU performance regression
Cc:     Frank van der Linden <fllinden@amazon.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Matthew Wilcox <matthew.wilcox@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
In-Reply-To: <4C14DB3A-A5C1-41A9-8293-DF4FC2459600@oracle.com>
References: <20220601161003.GA20483@dev-dsk-fllinden-2c-d7720709.us-west-2.amazon.com> <4C14DB3A-A5C1-41A9-8293-DF4FC2459600@oracle.com>
Message-Id: <20220602094956.A396.409509F4@e16-tech.com>
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

> Certainly, though, the filecache plays somewhat different roles
> for legacy NFS and NFSv4. I've been toying with the idea of
> maintaining separate filecaches for NFSv3 and NFSv4, since
> the garbage collection and shrinker rules are fundamentally
> different for the two, and NFSv4 wants a file closed completely
> (no lingering open) when it does a CLOSE or DELEGRETURN.

if NFSv4 closed a file completely (no lingering open) when it does a
CLOSE or DELEGRETURN,
then the flowing problem seems to be fixed too.
https://lore.kernel.org/linux-nfs/20211002111419.2C83.409509F4@e16-tech.com/

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2022/06/02


