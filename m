Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7332D3AA24D
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Jun 2021 19:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbhFPRTU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Jun 2021 13:19:20 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:15844 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbhFPRTT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 16 Jun 2021 13:19:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1623863833; x=1655399833;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject;
  bh=Q5Mb33N4s7iNRGes5OdOYv09jmgB3B1sa4DEf0ih+tA=;
  b=TvOjupV/814yzagPb7xGEzK5DpfZVCh7lDTu/jw55yUBWbG6O+vCHPeT
   oPG6jl9780zjwMJzvGjF3BbOW6EEjvJxRWVDX51XzZokaqHy1UYhkkrq3
   OZt7nmOU1zO39znEQN+NPgwk0mjvKRO7vdXcp5RLnP3QW3Ox/JtYnnQtO
   4=;
X-IronPort-AV: E=Sophos;i="5.83,278,1616457600"; 
   d="scan'208";a="140498779"
Subject: Re: [PATCH] nfs: set block size according to pnfs_blksize first
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-1a-67b371d8.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP; 16 Jun 2021 17:17:12 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-67b371d8.us-east-1.amazon.com (Postfix) with ESMTPS id 7B7BEA17D6;
        Wed, 16 Jun 2021 17:17:10 +0000 (UTC)
Received: from EX13D07UWA003.ant.amazon.com (10.43.160.35) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.58) with Microsoft SMTP Server (TLS)
 id 15.0.1497.18; Wed, 16 Jun 2021 17:17:09 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX13D07UWA003.ant.amazon.com (10.43.160.35) with Microsoft SMTP Server (TLS)
 id 15.0.1497.18; Wed, 16 Jun 2021 17:17:09 +0000
Received: from dev-dsk-fllinden-2c-d7720709.us-west-2.amazon.com
 (172.19.206.175) by mail-relay.amazon.com (10.43.160.118) with Microsoft SMTP
 Server id 15.0.1497.18 via Frontend Transport; Wed, 16 Jun 2021 17:17:09
 +0000
Received: by dev-dsk-fllinden-2c-d7720709.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 7AEC99A; Wed, 16 Jun 2021 17:17:08 +0000 (UTC)
Date:   Wed, 16 Jun 2021 17:17:08 +0000
From:   Frank van der Linden <fllinden@amazon.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     "hsiangkao@linux.alibaba.com" <hsiangkao@linux.alibaba.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "joseph.qi@linux.alibaba.com" <joseph.qi@linux.alibaba.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Message-ID: <20210616171708.GA24636@dev-dsk-fllinden-2c-d7720709.us-west-2.amazon.com>
References: <1623847469-150122-1-git-send-email-hsiangkao@linux.alibaba.com>
 <4898aa11dc26396c13bbc3d8bf18c13efe4d513a.camel@hammerspace.com>
 <YMoFcdhVwMXJQPJ+@B-P7TQMD6M-0146.local>
 <2c14b63eacf1742bb0bcd2ae02f2d7005f7682d8.camel@hammerspace.com>
 <YMoNnr1RYDOLXtKJ@B-P7TQMD6M-0146.local>
 <80199ffaf89fc5ef2ad77245f9a5e75beed2dc37.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <80199ffaf89fc5ef2ad77245f9a5e75beed2dc37.camel@hammerspace.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Jun 16, 2021 at 03:14:17PM +0000, Trond Myklebust wrote:
> The setxattr() manpage appears to suggest ERANGE is the correct return
> value here.
> 
>        ERANGE The size of name or value exceeds a filesystem-specific
> limit.
> 
> 
> However I can't tell if ext4 and xfs ever do that. Furthermore, it
> looks as if the VFS is always returning E2BIG if size > XATTR_SIZE_MAX.
> 

The basic issue here is that there are two limits: the generic one
(XATTR_SIZE_MAX), and the fs-specific one.

When crossing the generic one, the xattr code returns E2BIG. When
crossing the fs-specific one, it looks like there are a few filesystems
that return E2BIG, but others (like ext4) return ENOSPC.

For the server, NFS4ERR_XATTR2BIG is the right value to return for all
these cases.  For the generic limit, it's an easy check. For the
fs-specific limit, the server code doesn't necessarily know what's
going on, since filesystems don't have a way to advertise their
limits. So ENOSPC will *probably* mean that the attribute was too
large for the filesystem, but it might not.

You could change the server code to translate ENOSPC to NFS4ERR_XATTR2BIG.
But that might not be totally correct either, you're going to end up returning
an error to the client that is not correct in all cases either way.

The problem here for xfstests is how to define the 'correct' behavior
across all filesystems so that there's a clean pass/fail, as long
as these inconsistencies exist.

- Frank
