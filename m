Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4D1C3AA716
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Jun 2021 00:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbhFPW5s (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Jun 2021 18:57:48 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:57265 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229602AbhFPW5s (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 16 Jun 2021 18:57:48 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 15GMtW1L022032
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Jun 2021 18:55:32 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 08A4E15C3CB8; Wed, 16 Jun 2021 18:55:32 -0400 (EDT)
Date:   Wed, 16 Jun 2021 18:55:31 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "joseph.qi@linux.alibaba.com" <joseph.qi@linux.alibaba.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Subject: Re: [PATCH] nfs: set block size according to pnfs_blksize first
Message-ID: <YMqBY0hk/AmgGMeb@mit.edu>
References: <1623847469-150122-1-git-send-email-hsiangkao@linux.alibaba.com>
 <4898aa11dc26396c13bbc3d8bf18c13efe4d513a.camel@hammerspace.com>
 <YMoFcdhVwMXJQPJ+@B-P7TQMD6M-0146.local>
 <2c14b63eacf1742bb0bcd2ae02f2d7005f7682d8.camel@hammerspace.com>
 <YMoNnr1RYDOLXtKJ@B-P7TQMD6M-0146.local>
 <YMojdN145g9JqAC8@mit.edu>
 <YMo6CKAaNcZlqzNC@B-P7TQMD6M-0146.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMo6CKAaNcZlqzNC@B-P7TQMD6M-0146.local>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Jun 17, 2021 at 01:51:04AM +0800, Gao Xiang wrote:
> 
> Considering the original XFS regression report [1], I think
> underlayfs blksize may still be needed. And binary search to get the
> maximum attr value may be another new case for this as well. Or
> alternatively just add by block size to do a trip test.
> 
> Although I have no idea if we can just skip the case when testing with
> NFS. If getting underlayfs blksize is unfeasible, I think we might
> skip such case for now since nfs blksize is not useful for generic/486.
> 
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=199119

I've looked at the original XFS regression size, and I don't see why
using the underlaying blocksize matters at all.  This is especially
true if you look at the comment in the test, and the commit which
fixed the bug.  All that is needed for the xfs regression test is to
start with a small xattr, and replace it with a large xattr.  The
blocksize is really irrelevant.

						- Ted
