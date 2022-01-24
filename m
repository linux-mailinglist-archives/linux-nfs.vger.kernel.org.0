Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79BDE497AD5
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Jan 2022 09:57:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242529AbiAXI5m (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 24 Jan 2022 03:57:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232822AbiAXI5j (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 24 Jan 2022 03:57:39 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 035D6C06173B;
        Mon, 24 Jan 2022 00:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=asCzRIoppSmO4QZ+TuOt/SZMZHwp70x1LmUoq7XNu7Q=; b=wkisxQoTZF4xxUhI4XNl0vmyAb
        NaQNpYi3/atnNwVIRwialv+9VcPJBMjLRySEa8ydT6FiRSbl3p+KlrMFOb8aEszRtMn3Njn84hhTb
        MWmCM0HL65mpZm9l8tb+eLPX/hfVz50HuZg3Fvchqe7NxMVrELHqms3SDzFEKhVqrkewzcmlcKI5f
        jJuRh2H3JzAT7C3+N1jwFYKo3Ue93W1sUv1zjcmfb7VQOi3Vtl1pEiUrVs0S878556JItPFPjaQXm
        4l0u5c/SWH9uOUFgZAz48eeh+MpxA+ZQBgTF1GErn6OCo393nweUWLLiHH7rZfe1k2W7itdFBHo96
        XeVt/e9w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nBvAM-002hYe-PY; Mon, 24 Jan 2022 08:57:34 +0000
Date:   Mon, 24 Jan 2022 00:57:34 -0800
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
Subject: Re: [PATCH 13/23] NFS: rename nfs_direct_IO and use as ->swap_rw
Message-ID: <Ye5p/n8EF2dzV8ch@infradead.org>
References: <164299573337.26253.7538614611220034049.stgit@noble.brown>
 <164299611281.26253.6497855219394305186.stgit@noble.brown>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164299611281.26253.6497855219394305186.stgit@noble.brown>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

> +extern int nfs_swap_rw(struct kiocb *, struct iov_iter *);

Might be worth to drop the pointless extern while you're at it.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
