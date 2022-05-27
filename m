Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB2D536825
	for <lists+linux-nfs@lfdr.de>; Fri, 27 May 2022 22:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbiE0Uh0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 27 May 2022 16:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351978AbiE0UhZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 27 May 2022 16:37:25 -0400
Received: from smtp-fw-9103.amazon.com (smtp-fw-9103.amazon.com [207.171.188.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D7261116E6
        for <linux-nfs@vger.kernel.org>; Fri, 27 May 2022 13:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1653683844; x=1685219844;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject;
  bh=ZvXHUkT9H2WUx0rJnGwyZXt7pM3obuMcN6VUSZLnW04=;
  b=MsUUbJ3iJ70ly5dbCGCInOXT2IRHu2nZ74Lk6b4NDWaFSVvN8UPATL0F
   B7iS8MwA+Q7/VuRLjsVAIaviVqHCyoTpGMQw2Vld6yGqClnPTtFziyKTr
   VXT//g4E9I8bIE/T0KNiCg4B2jL3jsLY/e8qt6Y9SqXxA0fteUbCilKfa
   s=;
X-IronPort-AV: E=Sophos;i="5.91,256,1647302400"; 
   d="scan'208";a="1019632674"
Subject: Re: filecache LRU performance regression
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2a-7d84505d.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9103.sea19.amazon.com with ESMTP; 27 May 2022 20:37:23 +0000
Received: from EX13MTAUWA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2a-7d84505d.us-west-2.amazon.com (Postfix) with ESMTPS id 4427A80BB9;
        Fri, 27 May 2022 20:37:22 +0000 (UTC)
Received: from EX13D20UWA001.ant.amazon.com (10.43.160.34) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.58) with Microsoft SMTP Server (TLS)
 id 15.0.1497.36; Fri, 27 May 2022 20:37:22 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX13D20UWA001.ant.amazon.com (10.43.160.34) with Microsoft SMTP Server (TLS)
 id 15.0.1497.36; Fri, 27 May 2022 20:37:22 +0000
Received: from dev-dsk-fllinden-2c-d7720709.us-west-2.amazon.com
 (172.19.206.175) by mail-relay.amazon.com (10.43.160.118) with Microsoft SMTP
 Server id 15.0.1497.36 via Frontend Transport; Fri, 27 May 2022 20:37:22
 +0000
Received: by dev-dsk-fllinden-2c-d7720709.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 1BEC1EF; Fri, 27 May 2022 20:37:21 +0000 (UTC)
Date:   Fri, 27 May 2022 20:37:21 +0000
From:   Frank van der Linden <fllinden@amazon.com>
To:     Chuck Lever III <chuck.lever@oracle.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Message-ID: <20220527203721.GA10628@dev-dsk-fllinden-2c-d7720709.us-west-2.amazon.com>
References: <5C7024DA-A792-4091-BFDE-CEED59BC1B69@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5C7024DA-A792-4091-BFDE-CEED59BC1B69@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-12.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, May 27, 2022 at 06:59:47PM +0000, Chuck Lever III wrote:
> 
> 
> Hi Frank-
> 
> Bruce recently reminded me about this issue. Is there a bugzilla somewhere?
> Do you have a reproducer I can try?

Hi Chuck,

The easiest way to reproduce the issue is to run generic/531 over an
NFSv4 mount, using a system with a larger number of CPUs on the client
side (or just scaling the test up manually - it has a calculation based
on the number of CPUs).

The test will take a long time to finish. I initially described the
details here:

https://lore.kernel.org/linux-nfs/20200608192122.GA19171@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com/

Since then, it was also reported here:

https://lore.kernel.org/all/20210531125948.2D37.409509F4@e16-tech.com/T/#m8c3e4173696e17a9d5903d2a619550f352314d20

I posted an experimental patch, but it's actually not quite correct
(although I think the idea behind it is makes sense):

https://lore.kernel.org/linux-nfs/20201020183718.14618-4-trondmy@kernel.org/T/#m869aa427f125afee2af9a89d569c6b98e12e516f

The basic problem from the initial email I sent:

> So here's what happens: for NFSv4, files that are associated with an
> open stateid can stick around for a long time, as long as there's no
> CLOSE done on them. That's what's happening here. Also, since those files
> have a refcount of >= 2 (one for the hash table, one for being pointed to
> by the state), they are never eligible for removal from the file cache.
> Worse, since the code call nfs_file_gc inline if the upper bound is crossed
> (8192), every single operation that calls nfsd_file_acquire will end up
> walking the entire LRU, trying to free files, and failing every time.
> Walking a list with millions of files every single time isn't great.

I guess the basic issues here are:

1) Should these NFSv4 files be in the filecache at all? They are readily
   available from the state, no need for additional caching.
2) In general: can state ever be gracefully retired if the client still
   has an OPEN?

- Frank
