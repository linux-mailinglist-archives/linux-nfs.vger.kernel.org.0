Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30905537353
	for <lists+linux-nfs@lfdr.de>; Mon, 30 May 2022 03:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbiE3Bgw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 29 May 2022 21:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbiE3Bgw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 29 May 2022 21:36:52 -0400
Received: from out20-86.mail.aliyun.com (out20-86.mail.aliyun.com [115.124.20.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D4063DF
        for <linux-nfs@vger.kernel.org>; Sun, 29 May 2022 18:36:51 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04445068|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_enroll_verification|0.0182193-0.00142166-0.980359;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047199;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.NvNh89i_1653874608;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.NvNh89i_1653874608)
          by smtp.aliyun-inc.com(33.37.67.126);
          Mon, 30 May 2022 09:36:48 +0800
Date:   Mon, 30 May 2022 09:36:50 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Chuck Lever III <chuck.lever@oracle.com>
Subject: Re: filecache LRU performance regression
Cc:     Frank van der Linden <fllinden@amazon.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Matthew Wilcox <matthew.wilcox@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
In-Reply-To: <69EAFC64-E5B1-450A-9DCE-695E478A213B@oracle.com>
References: <20220529103218.65DA.409509F4@e16-tech.com> <69EAFC64-E5B1-450A-9DCE-695E478A213B@oracle.com>
Message-Id: <20220530093649.43F8.409509F4@e16-tech.com>
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

> 
> > On May 28, 2022, at 10:32 PM, Wang Yugui <wangyugui@e16-tech.com> wrote:
> > 
> > Hi,
> > 
> >>> On May 27, 2022, at 4:37 PM, Frank van der Linden <fllinden@amazon.com> wrote:
> >>> 
> >>> On Fri, May 27, 2022 at 06:59:47PM +0000, Chuck Lever III wrote:
> >>>> 
> >>>> Hi Frank-
> >>>> 
> >>>> Bruce recently reminded me about this issue. Is there a bugzilla somewhere?
> >>>> Do you have a reproducer I can try?
> >>> 
> >>> Hi Chuck,
> >>> 
> >>> The easiest way to reproduce the issue is to run generic/531 over an
> >>> NFSv4 mount, using a system with a larger number of CPUs on the client
> >>> side (or just scaling the test up manually - it has a calculation based
> >>> on the number of CPUs).
> >>> 
> >>> The test will take a long time to finish. I initially described the
> >>> details here:
> >>> 
> >>> https://lore.kernel.org/linux-nfs/20200608192122.GA19171@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com/
> >>> 
> >>> Since then, it was also reported here:
> >>> 
> >>> https://lore.kernel.org/all/20210531125948.2D37.409509F4@e16-tech.com/T/#m8c3e4173696e17a9d5903d2a619550f352314d20
> >> 
> >> Thanks for the summary. So, there isn't a bugzilla tracking this
> >> issue? If not, please create one here:
> >> 
> >>  https://bugzilla.linux-nfs.org/
> >> 
> >> Then we don't have to keep asking for a repeat summary ;-)
> >> 
> >> 
> >>> I posted an experimental patch, but it's actually not quite correct
> >>> (although I think the idea behind it is makes sense):
> >>> 
> >>> https://lore.kernel.org/linux-nfs/20201020183718.14618-4-trondmy@kernel.org/T/#m869aa427f125afee2af9a89d569c6b98e12e516f
> >> 
> >> A handful of random comments:
> >> 
> >> - nfsd_file_put() is now significantly different than it used
> >>  to be, so that part of the patch will have to be updated in
> >>  order to apply to v5.18+
> > 
> > When many open files(>NFSD_FILE_LRU_THRESHOLD),
> > nfsd_file_gc() will waste many CPU times.
> 
> Thanks for the suggestion. I agree that CPU and
> memory bandwidth are not being used effectively
> by the filecache garbage collector.
> 
> 
> > Can we serialize nfsd_file_gc() for v5.18+ as a first step?
> 
> If I understand Frank's problem statement correctly,
> garbage collection during an nfsd_file_put() under
> an NFSv4-only workload walks the length of the LRU
> list and finds nothing to evict 100% of the time.
> That seems like a bug, and fixing it might give us
> the most improvement in this area.
> 
> 
> > diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> > index 3d944ca..6abefd9 100644
> > --- a/fs/nfsd/filecache.c
> > +++ b/fs/nfsd/filecache.c
> > @@ -63,6 +63,8 @@ static struct delayed_work		nfsd_filecache_laundrette;
> > 
> > static void nfsd_file_gc(void);
> > 
> > +static atomic_t nfsd_file_gc_queue_delayed = ATOMIC_INIT(0);
> > +
> > static void
> > nfsd_file_schedule_laundrette(void)
> > {
> > @@ -71,8 +73,10 @@ nfsd_file_schedule_laundrette(void)
> > 	if (count == 0 || test_bit(NFSD_FILE_SHUTDOWN, &nfsd_file_lru_flags))
> > 		return;
> > 
> > -	queue_delayed_work(system_wq, &nfsd_filecache_laundrette,
> > +	if(atomic_cmpxchg(&nfsd_file_gc_queue_delayed, 0, 1)==0){
> > +		queue_delayed_work(system_wq, &nfsd_filecache_laundrette,
> > 			NFSD_LAUNDRETTE_DELAY);
> 
> I might misunderstand what this is doing exactly.
> I'm sure there's a preferred idiom in the kernel
> for not queuing a new work item when one is already
> running, so that an open-coded cmpxchg is not
> necessary.

Thanks. I dropped queue_delayed_work related change and reposted it.

> It might be better to allocate a specific workqueue
> for filecache garbage collection, and limit the
> maximum number of active work items allowed on that
> queue to 1. One benefit of that might be reducing
> the number of threads contending for the filecache
> data structures.

In this way, the number of threads of filecache garbage collection is
reduced. but filecache is still accessed by all nfsd threads for filecache
fetch/save.

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2022/05/30

> If GC is capped like this, maybe create one GC
> workqueue per nfsd_net so GC activity in one
> namespace does not starve filecache GC in other
> namespaces.
> 
> Before I would take patches like this, though,
> performance data demonstrating a problem and some
> improvement should be presented separately or as
> part of the patch descriptions.

> If you repost, start a separate thread and cc:
> 
> M:      Tejun Heo <tj@kernel.org>
> R:      Lai Jiangshan <jiangshanlai@gmail.com>
> 
> to get review by workqueue domain experts.
> 
> 

