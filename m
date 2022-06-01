Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0A853AABA
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Jun 2022 18:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355090AbiFAQKk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 1 Jun 2022 12:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349045AbiFAQKj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 1 Jun 2022 12:10:39 -0400
Received: from smtp-fw-9103.amazon.com (smtp-fw-9103.amazon.com [207.171.188.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E98D7A502D
        for <linux-nfs@vger.kernel.org>; Wed,  1 Jun 2022 09:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1654099838; x=1685635838;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject;
  bh=6NbvgqSx8K4tqnN8O/xHkvNOAwGmcXSlcMLEnelM2/Q=;
  b=s+uXpc3N8JHVodZqhMarRbvNTVX5TqWkLceGVUsM2OSR4L+RZ0Huzge+
   p4Onyq58COx7oKJt9KdoTetJE86ctqAn/WqiO/lIudJI7yo1XjiJx5Ik2
   WNZnEjY/53KRppZV+UcoYtRlvdgcfyBPcIr+1Vhv+ByFeHTciWaWYJDxQ
   U=;
X-IronPort-AV: E=Sophos;i="5.91,268,1647302400"; 
   d="scan'208";a="1020759995"
Subject: Re: filecache LRU performance regression
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1d-35b1f9a2.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9103.sea19.amazon.com with ESMTP; 01 Jun 2022 16:10:06 +0000
Received: from EX13MTAUEE002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1d-35b1f9a2.us-east-1.amazon.com (Postfix) with ESMTPS id 253CC2014FB;
        Wed,  1 Jun 2022 16:10:04 +0000 (UTC)
Received: from EX13D21UEE004.ant.amazon.com (10.43.62.91) by
 EX13MTAUEE002.ant.amazon.com (10.43.62.24) with Microsoft SMTP Server (TLS)
 id 15.0.1497.36; Wed, 1 Jun 2022 16:10:04 +0000
Received: from EX13MTAUEE002.ant.amazon.com (10.43.62.24) by
 EX13D21UEE004.ant.amazon.com (10.43.62.91) with Microsoft SMTP Server (TLS)
 id 15.0.1497.36; Wed, 1 Jun 2022 16:10:04 +0000
Received: from dev-dsk-fllinden-2c-d7720709.us-west-2.amazon.com
 (172.19.206.175) by mail-relay.amazon.com (10.43.62.224) with Microsoft SMTP
 Server id 15.0.1497.36 via Frontend Transport; Wed, 1 Jun 2022 16:10:04 +0000
Received: by dev-dsk-fllinden-2c-d7720709.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 0A335F5; Wed,  1 Jun 2022 16:10:03 +0000 (UTC)
Date:   Wed, 1 Jun 2022 16:10:03 +0000
From:   Frank van der Linden <fllinden@amazon.com>
To:     Chuck Lever III <chuck.lever@oracle.com>
CC:     Wang Yugui <wangyugui@e16-tech.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Matthew Wilcox <matthew.wilcox@oracle.com>,
        "Liam Howlett" <liam.howlett@oracle.com>
Message-ID: <20220601161003.GA20483@dev-dsk-fllinden-2c-d7720709.us-west-2.amazon.com>
References: <5C7024DA-A792-4091-BFDE-CEED59BC1B69@oracle.com>
 <20220527203721.GA10628@dev-dsk-fllinden-2c-d7720709.us-west-2.amazon.com>
 <ADD1751A-7F67-4729-BFFC-D6938CA963A0@oracle.com>
 <BED36887-054D-4DC9-A5F1-CB6DD1F0DC16@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BED36887-054D-4DC9-A5F1-CB6DD1F0DC16@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-12.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Jun 01, 2022 at 12:34:34AM +0000, Chuck Lever III wrote:
> > On May 27, 2022, at 5:34 PM, Chuck Lever III <chuck.lever@oracle.com> wrote:
> >
> >
> >
> >> On May 27, 2022, at 4:37 PM, Frank van der Linden <fllinden@amazon.com> wrote:
> >>
> >> On Fri, May 27, 2022 at 06:59:47PM +0000, Chuck Lever III wrote:
> >>>
> >>>
> >>> Hi Frank-
> >>>
> >>> Bruce recently reminded me about this issue. Is there a bugzilla somewhere?
> >>> Do you have a reproducer I can try?
> >>
> >> Hi Chuck,
> >>
> >> The easiest way to reproduce the issue is to run generic/531 over an
> >> NFSv4 mount, using a system with a larger number of CPUs on the client
> >> side (or just scaling the test up manually - it has a calculation based
> >> on the number of CPUs).
> >>
> >> The test will take a long time to finish. I initially described the
> >> details here:
> >>
> >> https://lore.kernel.org/linux-nfs/20200608192122.GA19171@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com/
> >>
> >> Since then, it was also reported here:
> >>
> >> https://lore.kernel.org/all/20210531125948.2D37.409509F4@e16-tech.com/T/#m8c3e4173696e17a9d5903d2a619550f352314d20
> >
> > Thanks for the summary. So, there isn't a bugzilla tracking this
> > issue? If not, please create one here:
> >
> >  https://bugzilla.linux-nfs.org/
> >
> > Then we don't have to keep asking for a repeat summary ;-)
> 
> I can easily reproduce this scenario in my lab. I've opened:
> 
>   https://bugzilla.linux-nfs.org/show_bug.cgi?id=386
> 

Thanks for taking care of that. I'm switching jobs, so I won't have much
time to look at it or test for a few weeks.

I think the basic problem is that the filecache is a clear win for
v3, since that's stateless and it avoids a lookup for each operation.

For v4, it's not clear to me that it's much of a win, and in this case
it definitely gets in the way.

Maybe the best thing is to not bother at all with the caching for v4,
although that might hurt mixed v3/v4 clients accessing the same fs
slightly. Not sure how common of a scenario that is, though.

- Frank
