Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 616AE3DDCD8
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Aug 2021 17:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235341AbhHBPzW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 Aug 2021 11:55:22 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:56030 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235338AbhHBPzV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 2 Aug 2021 11:55:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1627919713; x=1659455713;
  h=date:from:to:cc:message-id:references:mime-version:
   content-transfer-encoding:in-reply-to:subject;
  bh=y5/tsy3bpVGh2h4bHJbcXXKuZiOYXi5X3UeL9AmVA88=;
  b=Woy1d0BestiQIdmxedFN/Z2AZCJrdGG0/tkupBufDwuWq/6p1tVarlDP
   J9sh8vTIjJpTyOvs9hU+UlUY4g2FbcuccmFtQZZ63foWggrLyKexiLXI7
   PaAPArCMexbYHuOZteDV0Dg8kJO09ZotwlwhkQWsxSe01dCA3G/XdKjtK
   k=;
X-IronPort-AV: E=Sophos;i="5.84,289,1620691200"; 
   d="scan'208";a="126573418"
Subject: Re: [PATCH] common/attr: fix the MAX_ATTRS and MAX_ATTRVAL_SIZE for nfs
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2a-c5104f52.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP; 02 Aug 2021 15:55:11 +0000
Received: from EX13MTAUEE002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2a-c5104f52.us-west-2.amazon.com (Postfix) with ESMTPS id 71843A1F64;
        Mon,  2 Aug 2021 15:55:10 +0000 (UTC)
Received: from EX13D30UEE003.ant.amazon.com (10.43.62.109) by
 EX13MTAUEE002.ant.amazon.com (10.43.62.24) with Microsoft SMTP Server (TLS)
 id 15.0.1497.23; Mon, 2 Aug 2021 15:55:09 +0000
Received: from EX13MTAUEE002.ant.amazon.com (10.43.62.24) by
 EX13D30UEE003.ant.amazon.com (10.43.62.109) with Microsoft SMTP Server (TLS)
 id 15.0.1497.23; Mon, 2 Aug 2021 15:55:09 +0000
Received: from dev-dsk-fllinden-2c-d7720709.us-west-2.amazon.com
 (172.19.206.175) by mail-relay.amazon.com (10.43.62.224) with Microsoft SMTP
 Server id 15.0.1497.23 via Frontend Transport; Mon, 2 Aug 2021 15:55:09 +0000
Received: by dev-dsk-fllinden-2c-d7720709.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 032F69D; Mon,  2 Aug 2021 15:55:08 +0000 (UTC)
Date:   Mon, 2 Aug 2021 15:55:08 +0000
From:   Frank van der Linden <fllinden@amazon.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     Eryu Guan <eguan@linux.alibaba.com>,
        Hao Xu <haoxu@linux.alibaba.com>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Message-ID: <20210802155508.GA28568@dev-dsk-fllinden-2c-d7720709.us-west-2.amazon.com>
References: <20210730124252.113071-1-haoxu@linux.alibaba.com>
 <20210730140134.GM60846@e18g06458.et15sqa>
 <B6E429FE-2D78-41D0-A55D-C7AA83D62877@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <B6E429FE-2D78-41D0-A55D-C7AA83D62877@hammerspace.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, Jul 31, 2021 at 10:07:13PM +0000, Trond Myklebust wrote:
> 
> 
> > On Jul 30, 2021, at 10:01, Eryu Guan <eguan@linux.alibaba.com> wrote:
> >
> > [cc linux-nfs for review]
> >
> > On Fri, Jul 30, 2021 at 08:42:52PM +0800, Hao Xu wrote:
> >> The block size of localfs for nfs may be much smaller than nfs itself.
> >> So we'd better set MAX_ATTRS and MAX_ATTRVAL_SIZE to 4096 to avoid
> >> 'no space' error when we test adding a bunch of xattrs to nfs.
> >>
> >> Signed-off-by: Hao Xu <haoxu@linux.alibaba.com>
> >
> > Since the xattr support is relatively new (merged a year ago for
> > NFSv4.2), I'd like nfs folks to take a look as well.
> >
> >> ---
> >>
> >> It's better to set BLOCK_SIZE to `_get_block_size $variable`
> >> here $variable is the localfs for nfs, since I'm not familiar with
> >> xfstests, anyone tell what's the name of it.
> >
> > fstests doesn't know the exported filesystem under NFS, so I don't think
> > we could the block size of it.
> >
> >>
> >> common/attr | 11 +++++++++--
> >> 1 file changed, 9 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/common/attr b/common/attr
> >> index 42ceab92335a..a833f00e0884 100644
> >> --- a/common/attr
> >> +++ b/common/attr
> >> @@ -253,9 +253,13 @@ _getfattr()
> >>
> >> # set maximum total attr space based on fs type
> >> case "$FSTYP" in
> >> -xfs|udf|pvfs2|9p|ceph|nfs)
> >> +xfs|udf|pvfs2|9p|ceph)
> >>      MAX_ATTRS=1000
> >>      ;;
> >> +nfs)
> >> +    BLOCK_SIZE=4096
> >> +    let MAX_ATTRS=$BLOCK_SIZE/40
> >> +    ;;
> >> *)
> >>      # Assume max ~1 block of attrs
> >>      BLOCK_SIZE=`_get_block_size $TEST_DIR`
> >> @@ -273,12 +277,15 @@ xfs|udf|btrfs)
> >> pvfs2)
> >>      MAX_ATTRVAL_SIZE=8192
> >>      ;;
> >> -9p|ceph|nfs)
> >> +9p|ceph)
> >>      MAX_ATTRVAL_SIZE=65536
> >>      ;;
> >> bcachefs)
> >>      MAX_ATTRVAL_SIZE=1024
> >>      ;;
> >> +nfs)
> >> +    MAX_ATTRVAL_SIZE=3840
> >> +    ;;
> >
> > Where does this value come from?
> >
> > Thanks,
> > Eryu
> >
> >> *)
> >>      # Assume max ~1 block of attrs
> >>      BLOCK_SIZE=`_get_block_size $TEST_DIR`
> >> --
> >> 2.24.4
> 
> The above hackery proves beyond a shadow of a doubt that this test is utterly broken. Filesystem block sizes have nothing at all to do with xattrs.
> 
> Please move this test into the filesystem-specific categories or else remove it altogether. It definitely does not belong in ‘generic’.

I ran in to this basic problem when trying to add support for NFS xattr tests in fstests.

fstests wants to see if the xattr implementation of filesystems acts as expected when you hit the xattr size limits. But there is no interface to query those limits. So fstests resorts to special knowledge about the filesystem implementation to deduce these limits.

That, however, falls apart for NFS, which has no builtin limits (aside from the max RPC xfer size). The limit for NFS is just whatever the filesystem on the server side has, so there is no one-size-fits-all limit you can set here. What works against a server exporting XFS will not work against a server exporting ext4, etc. And then you might have a server running on a system that implements xattrs as a 'resource fork', so the size could be equal to the maximum filesystem size. You just don't know.

If you're on Linux, you  could try to deduce the limit by just trying to set an xattr with increasing size until you hit the limit. That's sort of doable because Linux has an upper limit (64k) enforced by the fs-independent code, so you don't have to go beyond that. But, you're trying to see if things behave correctly in the first place when hitting the limit, so that's kind of a chicken-and-egg problem.

It's messy, there is no clean solution here.

- Frank
