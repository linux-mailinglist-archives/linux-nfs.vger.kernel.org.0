Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE485539343
	for <lists+linux-nfs@lfdr.de>; Tue, 31 May 2022 16:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345274AbiEaOo0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 31 May 2022 10:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236138AbiEaOoZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 31 May 2022 10:44:25 -0400
Received: from out20-97.mail.aliyun.com (out20-97.mail.aliyun.com [115.124.20.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D50E8FF85
        for <linux-nfs@vger.kernel.org>; Tue, 31 May 2022 07:44:23 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1268614|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.234318-0.0468408-0.718841;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047192;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.NwasG1p_1654008260;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.NwasG1p_1654008260)
          by smtp.aliyun-inc.com(33.37.73.205);
          Tue, 31 May 2022 22:44:20 +0800
Date:   Tue, 31 May 2022 22:44:21 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Chuck Lever III <chuck.lever@oracle.com>
Subject: Re: [PATCH v2] nfsd: serialize filecache garbage collector
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
In-Reply-To: <A12757CE-17B8-4F21-9EC9-3CA0496A8B99@oracle.com>
References: <20220531103427.47769-1-wangyugui@e16-tech.com> <A12757CE-17B8-4F21-9EC9-3CA0496A8B99@oracle.com>
Message-Id: <20220531224421.7601.409509F4@e16-tech.com>
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

> > On May 31, 2022, at 6:34 AM, Wang Yugui <wangyugui@e16-tech.com> wrote:
> > 
> > When many(>NFSD_FILE_LRU_THRESHOLD) files are kept as OPEN, such as
> > xfstests generic/531, nfsd proceses are in CPU high-load state,
> > and nfsd_file_gc(nfsd filecache garbage collector) waste many CPU times.
> 
> Over the past few days, I've been able to reproduce a lot of bad
> behavior with generic/531. My test client has 12 physical CPU
> cores, and my lab network is 56Gb InfiniBand.
> 
> Unfortunately this patch doesn't really begin to address it. For
> example, with this patch applied, CPU idle is in single digits
> on the NFS server that exports the test's scratch device, and
> that server can still get into a soft lock-up. IMO that is
> because this change works around the underlying problem but
> makes no attempt to root-cause or address that issue.
> 
> I agree that the NFS server's behavior needs attention, but I'm
> not inclined to apply this particular patch as it is.

Yes. this patch is just particular for xfstests generic/531.

In xfstests  generic/531, when many(>500K ) files are kept as OPEN, a
file delete will cause LRU walk( CPU soft look-up) too.

big LRU data is still fast to add, but very slow to remove some random
one?

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2022/05/31

