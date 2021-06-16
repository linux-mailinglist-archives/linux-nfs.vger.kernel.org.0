Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 200773AA70D
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Jun 2021 00:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbhFPWx7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Jun 2021 18:53:59 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:56881 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229616AbhFPWx6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 16 Jun 2021 18:53:58 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 15GMpZDA020903
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Jun 2021 18:51:36 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 4851215C3CB8; Wed, 16 Jun 2021 18:51:35 -0400 (EDT)
Date:   Wed, 16 Jun 2021 18:51:35 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Frank van der Linden <fllinden@amazon.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "hsiangkao@linux.alibaba.com" <hsiangkao@linux.alibaba.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "joseph.qi@linux.alibaba.com" <joseph.qi@linux.alibaba.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Subject: Re: [PATCH] nfs: set block size according to pnfs_blksize first
Message-ID: <YMqAd8u+DwKbatnj@mit.edu>
References: <1623847469-150122-1-git-send-email-hsiangkao@linux.alibaba.com>
 <4898aa11dc26396c13bbc3d8bf18c13efe4d513a.camel@hammerspace.com>
 <YMoFcdhVwMXJQPJ+@B-P7TQMD6M-0146.local>
 <2c14b63eacf1742bb0bcd2ae02f2d7005f7682d8.camel@hammerspace.com>
 <YMoNnr1RYDOLXtKJ@B-P7TQMD6M-0146.local>
 <80199ffaf89fc5ef2ad77245f9a5e75beed2dc37.camel@hammerspace.com>
 <20210616171708.GA24636@dev-dsk-fllinden-2c-d7720709.us-west-2.amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210616171708.GA24636@dev-dsk-fllinden-2c-d7720709.us-west-2.amazon.com>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Jun 16, 2021 at 05:17:08PM +0000, Frank van der Linden wrote:
> 
> The problem here for xfstests is how to define the 'correct' behavior
> across all filesystems so that there's a clean pass/fail, as long
> as these inconsistencies exist.

Note that the original xfstest in question is to check what happens
when you have a pre-existing xattr with a small (16 byte) value, and
replacing (overwriting) the xattr with a large (but valid) value.

The problem was that generic/486 was using the preferred size for
efficient I/O size as the "block" size, and then using a percentage of
this "block" size as the arbitrary "large xattr size".

It was not about the error codes being returned, which is a bit
confusing, and for which different man pages (attr_set and setxattr)
are differently incomplete.  That's really a different issue, and the
fact that different file systems can use different error codes is not
necessarily something that we need to rationalize, in particular for
file systems like NFS where the error codes returned are not entirely
under the control of the NFS client or server code.

Cheers,

					- Ted
