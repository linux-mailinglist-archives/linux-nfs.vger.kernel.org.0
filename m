Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D43A2F4ED1
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Jan 2021 16:34:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbhAMPdf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 13 Jan 2021 10:33:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbhAMPdf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 13 Jan 2021 10:33:35 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6CAC061575
        for <linux-nfs@vger.kernel.org>; Wed, 13 Jan 2021 07:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8VsZe1+UAeqhj1RZDRTI2Z7NEhPRtKjeIWhhfOA2pjw=; b=SH/wKdt2NkeQjfkgtiLEuOlHQZ
        0Db5ThmUUrRXXvY2Lq48FDFNtrZf3bgFGhqAPvXZRji99Xl1Ud+52jhSYpQFxP2RIqBZLOQVcPcqw
        WYGOkZ8fOhzE3odrWQTvZX5cji7bGzi4Z5YqEYOlhNS0QHrUzGudorkN2bvCW+7hiuUhsv5MO9Li1
        1bcS9YIMiXaElmA52WlhRZ0OFtjkBg3t+F93vUGFh6fZLfSK309GrzRydYKwI/JJF/rJQ5UZOcmSY
        1q+LgZz0KdG2L2/870BVPeV0UDv8Rw5ew8DKM6/LQhjtk3OA0lQ9/W80ksyOrpzPBhtphFeC0WAlE
        Uy/ScwQQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1kzi69-006Pl6-Pi; Wed, 13 Jan 2021 15:30:26 +0000
Date:   Wed, 13 Jan 2021 15:30:13 +0000
From:   "hch@infradead.org" <hch@infradead.org>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "hch@infradead.org" <hch@infradead.org>,
        "pgoetz@math.utexas.edu" <pgoetz@math.utexas.edu>,
        "wangzhibei1999@gmail.com" <wangzhibei1999@gmail.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "greg@kroah.com" <greg@kroah.com>, "w@1wt.eu" <w@1wt.eu>,
        "security@kernel.org" <security@kernel.org>,
        "bfields@fieldses.org" <bfields@fieldses.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: nfsd vurlerability submit
Message-ID: <20210113153013.GA1527598@infradead.org>
References: <CAHxDmpR1zG25ADfK2jat4VKGbAOCg6YM_0WA+a_jQE82hbnMjA@mail.gmail.com>
 <CAHxDmpRfmVukMR_yF4coioiuzrsp72zBraHWZ8gaMydUuLwKFg@mail.gmail.com>
 <20210112153208.GF9248@fieldses.org>
 <8296b696a7fa5591ad3fbb05bfcf6bdf6175cc38.camel@hammerspace.com>
 <42fcbc42-f1b3-5d99-c507-e1b579f5a37a@math.utexas.edu>
 <20210112180326.GI9248@fieldses.org>
 <20210113081238.GA1428651@infradead.org>
 <0da3d3f1fee1a70eab3f78212f9282b03e21fc4d.camel@hammerspace.com>
 <20210113144026.GA1517953@infradead.org>
 <cfe4b764e6a3a58e10d95dfe660afa12c30d8008.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cfe4b764e6a3a58e10d95dfe660afa12c30d8008.camel@hammerspace.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Jan 13, 2021 at 03:16:52PM +0000, Trond Myklebust wrote:
> How would that work then? Would you just look at the project ID of the
> directory identified by the filehandle as the export point, and then
> match to the project ID on the target inode? That sounds like it
> doesn't even need to encode anything special in the filehandle.

True, we would not even have to encode them.

> How do you set a project ID in XFS?

With the XFS_IOC_SETXFLAGS ioctl.

On the command line side people usually do it using the xfs_quota
tool as part of setting up the tree quotas, but it can also be done
separately using the chproj subcommand of xfs_io.
