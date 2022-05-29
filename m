Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37B0C536F20
	for <lists+linux-nfs@lfdr.de>; Sun, 29 May 2022 04:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbiE2Ccb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 28 May 2022 22:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiE2Ccb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 28 May 2022 22:32:31 -0400
Received: from out20-206.mail.aliyun.com (out20-206.mail.aliyun.com [115.124.20.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00B45B3FE
        for <linux-nfs@vger.kernel.org>; Sat, 28 May 2022 19:32:21 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04948568|-1;BR=01201311R121S10rulernew998_84748_2000303;CH=blue;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0186616-0.00150413-0.979834;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047202;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.NuwvtCj_1653791538;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.NuwvtCj_1653791538)
          by smtp.aliyun-inc.com(33.37.77.208);
          Sun, 29 May 2022 10:32:19 +0800
Date:   Sun, 29 May 2022 10:32:19 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Chuck Lever III <chuck.lever@oracle.com>
Subject: Re: filecache LRU performance regression
Cc:     Frank van der Linden <fllinden@amazon.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Matthew Wilcox <matthew.wilcox@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
In-Reply-To: <ADD1751A-7F67-4729-BFFC-D6938CA963A0@oracle.com>
References: <20220527203721.GA10628@dev-dsk-fllinden-2c-d7720709.us-west-2.amazon.com> <ADD1751A-7F67-4729-BFFC-D6938CA963A0@oracle.com>
Message-Id: <20220529103218.65DA.409509F4@e16-tech.com>
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
> 
> > On May 27, 2022, at 4:37 PM, Frank van der Linden <fllinden@amazon.com> wrote:
> > 
> > On Fri, May 27, 2022 at 06:59:47PM +0000, Chuck Lever III wrote:
> >> 
> >> 
> >> Hi Frank-
> >> 
> >> Bruce recently reminded me about this issue. Is there a bugzilla somewhere?
> >> Do you have a reproducer I can try?
> > 
> > Hi Chuck,
> > 
> > The easiest way to reproduce the issue is to run generic/531 over an
> > NFSv4 mount, using a system with a larger number of CPUs on the client
> > side (or just scaling the test up manually - it has a calculation based
> > on the number of CPUs).
> > 
> > The test will take a long time to finish. I initially described the
> > details here:
> > 
> > https://lore.kernel.org/linux-nfs/20200608192122.GA19171@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com/
> > 
> > Since then, it was also reported here:
> > 
> > https://lore.kernel.org/all/20210531125948.2D37.409509F4@e16-tech.com/T/#m8c3e4173696e17a9d5903d2a619550f352314d20
> 
> Thanks for the summary. So, there isn't a bugzilla tracking this
> issue? If not, please create one here:
> 
>   https://bugzilla.linux-nfs.org/
> 
> Then we don't have to keep asking for a repeat summary ;-)
> 
> 
> > I posted an experimental patch, but it's actually not quite correct
> > (although I think the idea behind it is makes sense):
> > 
> > https://lore.kernel.org/linux-nfs/20201020183718.14618-4-trondmy@kernel.org/T/#m869aa427f125afee2af9a89d569c6b98e12e516f
> 
> A handful of random comments:
> 
> - nfsd_file_put() is now significantly different than it used
>   to be, so that part of the patch will have to be updated in
>   order to apply to v5.18+

When many open files(>NFSD_FILE_LRU_THRESHOLD),
nfsd_file_gc() will waste many CPU times.

Can we serialize nfsd_file_gc() for v5.18+ as a first step?

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 3d944ca..6abefd9 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -63,6 +63,8 @@ static struct delayed_work		nfsd_filecache_laundrette;
 
 static void nfsd_file_gc(void);
 
+static atomic_t nfsd_file_gc_queue_delayed = ATOMIC_INIT(0);
+
 static void
 nfsd_file_schedule_laundrette(void)
 {
@@ -71,8 +73,10 @@ nfsd_file_schedule_laundrette(void)
 	if (count == 0 || test_bit(NFSD_FILE_SHUTDOWN, &nfsd_file_lru_flags))
 		return;
 
-	queue_delayed_work(system_wq, &nfsd_filecache_laundrette,
+	if(atomic_cmpxchg(&nfsd_file_gc_queue_delayed, 0, 1)==0){
+		queue_delayed_work(system_wq, &nfsd_filecache_laundrette,
 			NFSD_LAUNDRETTE_DELAY);
+	}
 }
 
 static void
@@ -468,15 +472,22 @@ nfsd_file_lru_walk_list(struct shrink_control *sc)
 	return ret;
 }
 
+// nfsd_file_gc() support concurrency, but serialize it
+atomic_t nfsd_file_gc_running = ATOMIC_INIT(0);
 static void
 nfsd_file_gc(void)
 {
-	nfsd_file_lru_walk_list(NULL);
+	if(atomic_cmpxchg(&nfsd_file_gc_running, 0, 1)==0){
+		nfsd_file_lru_walk_list(NULL);
+		atomic_set(&nfsd_file_gc_running, 0);
+	}
 }
 
 static void
 nfsd_file_gc_worker(struct work_struct *work)
 {
+	atomic_set(&nfsd_file_gc_queue_delayed, 0);
+	// pr_info("nfsd_file_gc_worker\n");
 	nfsd_file_gc();
 	nfsd_file_schedule_laundrette();
 }

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2022/05/29


