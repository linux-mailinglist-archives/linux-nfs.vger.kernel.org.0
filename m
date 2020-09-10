Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B51B52650F0
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Sep 2020 22:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbgIJUgr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 10 Sep 2020 16:36:47 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:61364 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726928AbgIJUb2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 10 Sep 2020 16:31:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1599769887; x=1631305887;
  h=date:from:to:subject:message-id:references:mime-version:
   in-reply-to;
  bh=GnEwkxhugnPrYPCFbMdMmPwSq72WqSjPuDvNLdjzQCg=;
  b=SVbJKMvbCSqezgXBR9sEahR9gmmprn4nbD1duNjP8GyolMpvTRwPqIsp
   /EWMwcX9JnBn8GNVk8AuHhIsXv1zhJdsp0KzgODY1Vju5SjgVI5oYLqIn
   7Sq5hx4qBFEoiZGe6qkqnDE4TjhXohMil1ysKdstVLp06wFntPAvjVXaL
   U=;
X-IronPort-AV: E=Sophos;i="5.76,413,1592870400"; 
   d="scan'208";a="53089658"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1a-67b371d8.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 10 Sep 2020 20:31:26 +0000
Received: from EX13MTAUEE001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-1a-67b371d8.us-east-1.amazon.com (Postfix) with ESMTPS id C3D9BA07F6;
        Thu, 10 Sep 2020 20:31:24 +0000 (UTC)
Received: from EX13D05UEE003.ant.amazon.com (10.43.62.168) by
 EX13MTAUEE001.ant.amazon.com (10.43.62.226) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 10 Sep 2020 20:31:24 +0000
Received: from EX13MTAUEE002.ant.amazon.com (10.43.62.24) by
 EX13D05UEE003.ant.amazon.com (10.43.62.168) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 10 Sep 2020 20:31:23 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.62.224) with Microsoft SMTP
 Server id 15.0.1497.2 via Frontend Transport; Thu, 10 Sep 2020 20:31:23 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 9FDC4C1400; Thu, 10 Sep 2020 20:31:23 +0000 (UTC)
Date:   Thu, 10 Sep 2020 20:31:23 +0000
From:   Frank van der Linden <fllinden@amazon.com>
To:     <linux-nfs@vger.kernel.org>, <anna.schumaker@netapp.com>,
        <trond.myklebust@hammerspace.com>, <dhowells@redhat.com>
Subject: Re: [PATCH] nfs: round down reported block numbers in statfs
Message-ID: <20200910203123.GA8274@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
References: <20200910200644.8165-1-fllinden@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200910200644.8165-1-fllinden@amazon.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Sep 10, 2020 at 08:06:44PM +0000, Frank van der Linden wrote:
> nfs_statfs rounds up the numbers of blocks as computed
> from the numbers the server return values.
> 
> This works out well if the client block size, which is
> the same as wrsize, is smaller than or equal to the actual
> filesystem block size on the server.
> 
> But, for NFS4, the size is usually larger (1M), meaning
> that statfs reports more free space than actually is
> available. This confuses, for example, fstest generic/103.
> 
> Given a choice between reporting too much or too little
> space, the latter is the safer option, so don't round
> up the number of blocks. This also simplifies the code.
> 
> Signed-off-by: Frank van der Linden <fllinden@amazon.com>

I doubted whether I should send this in as an RFC, since this
is one of those things that might generate more discussion.

In any case, let me add some details here:

generic/103 is a test that sees if adding an xattr to a full
filesystem correctly returns ENOSPC. To achieve that, it gets
the number of free blocks (f_bavail), uses fallocate to allocate that
space minus some slack (512k), and then fills it up with 64k-sized
xattrs.

For NFS (4.2) this fails, because the filesystem rounds the free
blocks up to f_bsize (1M). So even f_bavail minus 512k can
be more than is actually available. The fallocate fails, and
the test fails before it gets to the xattr part.

Other client implementations simply use the lowest common
denominator for f_bsize (512), so the space reporting always
works out. But since wrsize is used here, you have to make
a choice between rounding up or rounding down, and the latter
seems safer.

Sure, all the caveats apply: the stats are just a snapshot, applications
shouldn't rely on the exact data, etc, but I think the xfstest
in question is a decent example of why rounding down is a bit better.

It also simplifies the code.

- Frank
