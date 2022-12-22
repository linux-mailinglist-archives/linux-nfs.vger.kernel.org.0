Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0870653D93
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Dec 2022 10:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235163AbiLVJjB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 22 Dec 2022 04:39:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232013AbiLVJi7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 22 Dec 2022 04:38:59 -0500
Received: from out20-97.mail.aliyun.com (out20-97.mail.aliyun.com [115.124.20.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B3AE27937
        for <linux-nfs@vger.kernel.org>; Thu, 22 Dec 2022 01:38:57 -0800 (PST)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04451506|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_news_journal|0.00574092-0.000153648-0.994105;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047201;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.QbHwKJm_1671701934;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.QbHwKJm_1671701934)
          by smtp.aliyun-inc.com;
          Thu, 22 Dec 2022 17:38:55 +0800
Date:   Thu, 22 Dec 2022 17:38:55 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
Subject: Re: a nfsd_file_free panic when shudown
In-Reply-To: <20221222161514.FC5C.409509F4@e16-tech.com>
References: <20221222141515.3AE5.409509F4@e16-tech.com> <20221222161514.FC5C.409509F4@e16-tech.com>
Message-Id: <20221222173854.61D6.409509F4@e16-tech.com>
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

Hi, Jeff Layton 

> Hi,
> > a nfsd_file_free panic when shudown.
> > 
> > This is a kernel 6.1.1 with some nfsd 6.2 pathes.
> > It happened when os shutdown.
> > 
> > but the reproducer is yet not clear.
> > we just gather the info of the attachment file.
> 
> Now I can reproduce it.
> 1)  'tail -f xxx' to keep a file is open from nfs4 client
> 2) 'shutdow -r now' the nfs server.
> 
> more panic info in the attachment files (panic-2.txt/panic-3.txt)
> 
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2022/12/22
> 
> > 
> > the path list that applied to kernel 6.1.1.
> > Subject: nfsd: don't call nfsd_file_put from client states seqfile display
> > Subject: NFSD: Pass the target nfsd_file to nfsd_commit()
> > Subject: NFSD: Revert "NFSD: NFSv4 CLOSE should release an nfsd_file
> > Subject: NFSD: Add an NFSD_FILE_GC flag to enable nfsd_file garbage collection
> > Subject: nfsd: fix up the filecache laundrette scheduling
> > Subject: NFSD: Flesh out a documenting comment for filecache.c
> > Subject: NFSD: Clean up nfs4_preprocess_stateid_op() call sites
> > Subject: NFSD: Trace stateids returned via DELEGRETURN
> > Subject: NFSD: Trace delegation revocations
> > Subject: NFSD: Use const pointers as parameters to fh_ helpers
> > Subject: NFSD: Update file_hashtbl() helpers
> > Subject: NFSD: Clean up nfsd4_init_file()
> > Subject: NFSD: Add a nfsd4_file_hash_remove() helper
> > Subject: NFSD: Clean up find_or_add_file()
> > Subject: NFSD: Refactor find_file()
> > Subject: NFSD: Use rhashtable for managing nfs4_file objects
> > Subject: NFSD: Fix licensing header in filecache.c
> > Subject: nfsd: remove the pages_flushed statistic from filecache
> > Subject: nfsd: reorganize filecache.c
> > Subject: NFSD: Add an nfsd_file_fsync tracepoint
> > Subject: nfsd: rework refcounting in filecache
> > Subject: nfsd: under NFSv4.1, fix double svc_xprt_put on rpc_create failure
> > Subject: NFSD: fix use-after-free in __nfs42_ssc_open()
> > 
> > 
> > It happened just after 'Subject: nfsd: rework refcounting in filecache'
> > is added, so this patch maybe related.

It is confirmed that this panic is caused by the patch
'nfsd: rework refcounting in filecache'.

the problem is 100% reproduced when this patch is applied.
the problem is yet not reproduced when this patch is not applied.

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2022/12/22


