Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3059C47BC27
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Dec 2021 09:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235823AbhLUIsz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 21 Dec 2021 03:48:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233569AbhLUIsy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 21 Dec 2021 03:48:54 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41CD7C061574;
        Tue, 21 Dec 2021 00:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5sNRK7eak2tna64oFZaxQtUv30cBHlHdDha2g9J+6XE=; b=akbQMUgNdDQpa6emCnYiLroiEO
        NeCw+yt7z3/+UEQkkBfJzEeHH7rdyG1KvDLCKRWx8ZvLeUC0c5nDFYIjv4kTuzVKEel8CQ6GBWrDJ
        KpURrzLBLdCu4PadpP1ERk4QRCRw5NqcXDl9u7UqVLUWrU/m8OImS8wPLX5BZS3PVyd/rAVZVdcGl
        gX0/puxTRQIlGYW1Ox8MqXhnB8DIpppqF0mkAL/twThymucKliTaimCUiDZeBkXi/ib/tsr8+Arvr
        YVo8s4at+wsufH7ureeF4wOD9LkgK32HMDfOzcFu5KPMUO+ZK/sYu+mUE3nzTr51qJekCsZ/GWfTK
        z9n/L31A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mzapF-005yRg-Se; Tue, 21 Dec 2021 08:48:49 +0000
Date:   Tue, 21 Dec 2021 00:48:49 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Anna Schumaker <anna.schumaker@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-mm@kvack.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        fstests@vger.kernel.org
Subject: Re: [PATCH 00/18 V2] Repair SWAP-over-NFS
Message-ID: <YcGU8W6+hEfRAVY9@infradead.org>
References: <163969801519.20885.3977673503103544412.stgit@noble.brown>
 <CAFX2Jfn8jER-aV_ttiAe1tkh8f+m=5-whEBTWbHO1uVwf=B4bw@mail.gmail.com>
 <163994803576.25899.6298619065481174544@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163994803576.25899.6298619065481174544@noble.neil.brown.name>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Dec 20, 2021 at 08:07:15AM +1100, NeilBrown wrote:
> > Thanks for fixing swap-over-NFS! Looks like it passes all the
> > swap-related xfstests except for generic/357 on NFS v4.2. This test
> > checks that we get -EINVAL on a reflinked swapfile, but I'm not sure
> > if there is a way to check for that on the client side but if you have
> > any ideas it would be nice to get that test passing while you're at
> > it!
> 
> Thanks for testing!.
> I think that testing that swap fails on a reflinked file is bogus.  This
> isn't an important part of the API, it is just an internal
> implementation detail.
> I certainly understand that it could be problematic implementing swap on
> a reflinked file within XFS and it is perfectly acceptable to fail such
> a request.  But if one day someone decided to implement it - should that
> be seen as a regression?

Yes, there is really no fundamental reason not to support swap to
reflinked files, especially for NFS.  We'll need some kind of opt-in/out
for this test.
