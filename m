Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6F3154CCE9
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jun 2022 17:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238503AbiFOP3f (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 15 Jun 2022 11:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356490AbiFOP2w (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 15 Jun 2022 11:28:52 -0400
Received: from out20-87.mail.aliyun.com (out20-87.mail.aliyun.com [115.124.20.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A55438BF
        for <linux-nfs@vger.kernel.org>; Wed, 15 Jun 2022 08:28:33 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.05318995|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0829322-0.00105054-0.916017;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047204;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.O5CZ1si_1655306888;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.O5CZ1si_1655306888)
          by smtp.aliyun-inc.com;
          Wed, 15 Jun 2022 23:28:09 +0800
Date:   Wed, 15 Jun 2022 23:28:11 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Chuck Lever III <chuck.lever@oracle.com>
Subject: Re: [RPC] nfsd: NFSv4 close a file completely
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
In-Reply-To: <0CBF71FB-7754-4992-BE16-A3CFD404DECC@oracle.com>
References: <20220612072253.66354-1-wangyugui@e16-tech.com> <0CBF71FB-7754-4992-BE16-A3CFD404DECC@oracle.com>
Message-Id: <20220615232810.95CE.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.04 [en]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

> > On Jun 12, 2022, at 3:22 AM, Wang Yugui <wangyugui@e16-tech.com> wrote:
> > 
> > NFSv4 need to close a file completely (no lingering open) when it does
> > a CLOSE or DELEGRETURN.
> > 
> > When multiple NFSv4/OPEN from different clients, we need to check the
> > reference count. The flowing reference-count-check change the behavior
> > of NFSv3 nfsd_rename()/nfsd_unlink() too.
> > 
> > Link: https://bugzilla.linux-nfs.org/show_bug.cgi?id=387
> > Signed-off-by: Wang Yugui <wangyugui@e16-tech.com>
> > ---
> > TO-CHECK:
> > 1) NFSv3 nfsd_rename()/nfsd_unlink() feature change is OK?
> > 2) Can we do better performance than nfsd_file_close_inode_sync()?
> > 3) nfsd_file_close_inode_sync()->nfsd_file_close_inode() in nfsd4_delegreturn()
> > 	=> 'Text file busy' about 4s
> > 4) reference-count-check : refcount_read(&nf->nf_ref) <= 1 or ==0?
> > 	nfsd_file_alloc()	refcount_set(&nf->nf_ref, 1);
> > 
> > fs/nfsd/filecache.c | 2 +-
> > fs/nfsd/nfs4state.c | 4 ++++
> > 2 files changed, 5 insertions(+), 1 deletion(-)
> 
> I suppose I owe you (and Frank) a progress report on #386. I've fixed
> the LRU algorithm and added some observability features to measure
> how the fix impacts the cache's efficiency for NFSv3 workloads.
> 
> These new features show that the hit rate and average age of cache
> items goes down after the fix is applied. I'm trying to understand
> if I've done something wrong or if the fix is supposed to do that.
> 
> To handle the case of hundreds of thousands of open files more
> efficiently, I'd like to convert the filecache to use rhashtable.

A question about the comming rhashtable.

Now multiple nfsd export share a cache pool.

In the coming rhashtable, a nfsd export could use a private cache pool
to improve scale out?

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2022/06/15


