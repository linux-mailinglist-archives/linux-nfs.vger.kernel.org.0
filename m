Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E83ED497AB4
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Jan 2022 09:50:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236236AbiAXIup (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 24 Jan 2022 03:50:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232415AbiAXIup (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 24 Jan 2022 03:50:45 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB6CC06173B;
        Mon, 24 Jan 2022 00:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=cKte+RtJ76M253ZP7g5I3h2dJU
        k1ceOkSoxd+/nX15WoZyCnloB9bRbQi9nKBj3alrCaY71IyJ7hlBW5GbEMDIvU2UBarbfafttSInT
        aYvaXM2tHkG59+pMSoXz1O4tYR11A94lCCzzqfGn+bWkqbH6FTAzamx5uJ2sK15PRtjcb23iw9U9A
        g6pZ6i53rS5R235+xN8Jw7tfdA8u4+4QEkwi5H+0mdcCSjpSrM7zjq9JBGCaMU3qzvZZSdr8ETOE2
        PyoiH9cobtb7YHSls8e+wVeF29+XK2/QNtrfBG6z0Xo1Hgmq+jJyTjP2z9nhJCcC7huEvL7LlRhQi
        S5xVyNog==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nBv3g-002ecR-9u; Mon, 24 Jan 2022 08:50:40 +0000
Date:   Mon, 24 Jan 2022 00:50:40 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/23] DOC: update documentation for swap_activate and
 swap_rw
Message-ID: <Ye5oYHAyt7zyqR7m@infradead.org>
References: <164299573337.26253.7538614611220034049.stgit@noble.brown>
 <164299611278.26253.2945860698197438729.stgit@noble.brown>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164299611278.26253.2945860698197438729.stgit@noble.brown>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
