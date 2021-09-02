Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71FC53FE858
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Sep 2021 06:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbhIBEUR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 2 Sep 2021 00:20:17 -0400
Received: from out20-39.mail.aliyun.com ([115.124.20.39]:59990 "EHLO
        out20-39.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbhIBEUM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 2 Sep 2021 00:20:12 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04758037|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0527919-0.000311258-0.946897;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047198;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=6;RT=6;SR=0;TI=SMTPD_---.LEMlkBh_1630556352;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.LEMlkBh_1630556352)
          by smtp.aliyun-inc.com(10.147.40.7);
          Thu, 02 Sep 2021 12:19:12 +0800
Date:   Thu, 02 Sep 2021 12:19:15 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] Don't block writes to swap-files with ETXTBSY.
Cc:     NeilBrown <neilb@suse.de>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        David Howells <dhowells@redhat.com>,
        trond.myklebust@primarydata.com, linux-nfs@vger.kernel.org
In-Reply-To: <20210827151644.GB19199@lst.de>
References: <162993585927.7591.10174443410031404560@noble.neil.brown.name> <20210827151644.GB19199@lst.de>
Message-Id: <20210902121914.BFAC.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.04 [en]
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

# drop  torvalds@linux-foundation.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org

A Question about ETXTBSY of nfs.
# I tried google/bing, but yet no good info is found.

test case:
/ssd is a  nfs directory
kernel: 5.10.61, 5.4.106 and more

1, on Node1:
[root@T630 ~]# echo -e '#!/bin/bash\necho hello' >/ssd/a.sh
[root@T630 ~]# chmod a+x /ssd/a.sh

2, on Node2:
[root@T640 ~]# /ssd/a.sh
-bash: /ssd/a.sh: /bin/bash: bad interpreter: Text file busy
[root@T640 ~]# bash /ssd/a.sh
hello
[root@T640 ~]# /ssd/a.sh
-bash: /ssd/a.sh: /bin/bash: bad interpreter: Text file busy

Is there any way(flush, sync)  to avoid this ETXTBSY error(Text file busy)?

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2021/09/02

> On Thu, Aug 26, 2021 at 09:57:39AM +1000, NeilBrown wrote:
> > 
> > Commit dc617f29dbe5 ("vfs: don't allow writes to swap files")
> > broke swap-over-NFS as it introduced an ETXTBSY error when NFS tries to
> > swap-out using ->direct_IO().
> > 
> > There is no sound justification for this error.  File permissions are
> > sufficient to stop non-root users from writing to a swap file, and root
> > must always be cautious not to do anything dangerous.
> > 
> > These checks effectively provide a mandatory write lock on swap, and
> > mandatory locks are not supported in Linux.
> > 
> > So remove all the checks that return ETXTBSY when attempts are made to
> > write to swap.
> 
> Swap files are not just any files and do need a mandatory write lock
> as they are part of the kernel VM and writing to them will mess up
> the kernel badly.  David Howells actually has sent various patches
> to fix swap over NFS in the last weeks.


