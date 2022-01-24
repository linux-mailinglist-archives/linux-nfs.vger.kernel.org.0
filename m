Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84792497974
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Jan 2022 08:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbiAXHab (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 24 Jan 2022 02:30:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232329AbiAXHaa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 24 Jan 2022 02:30:30 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4AD7C06173B;
        Sun, 23 Jan 2022 23:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=T/0oTeq5v1ZGP3qGpJ+MQW5tAL9vDWjxzsmMqt+GWbk=; b=1ZX+gL19O9OIi5/UKe7DGF8ZyC
        oX9e8rVU9GSB6cHERUs8lIDyyB923CxgTzr8ESuwgAljOlDFc2ZRCSm1GyjdVImceT+mvFGLBdE0H
        jLtJ3H0omGP9hBMOEVHHba5PqhYfG217gGGswIx3bK6QYilFewk0pMiCrAACvst+ckm5l8AO1Ebk/
        am0dt7ar8ILik1psIJkvff/5VM2377zwMBs/83+P5gWjLtVJsQa/vCrqyQ0d+AyXnVd+QLMhOPDAy
        yWElEUvYhyMt1DSsFTxRIOSYScYzUwNXkJuqEUmAV8mSGfgUp7S7As4suReB+lpWftPV57uFphamo
        9us+R7UQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nBto0-002USC-MT; Mon, 24 Jan 2022 07:30:24 +0000
Date:   Sun, 23 Jan 2022 23:30:24 -0800
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
Subject: Re: [PATCH 04/23] MM: move responsibility for setting SWP_FS_OPS to
 ->swap_activate
Message-ID: <Ye5VkIzxstxIpik6@infradead.org>
References: <164299573337.26253.7538614611220034049.stgit@noble.brown>
 <164299611275.26253.11641346650863170349.stgit@noble.brown>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164299611275.26253.11641346650863170349.stgit@noble.brown>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Jan 24, 2022 at 02:48:32PM +1100, NeilBrown wrote:
> If a filesystem wishes to handle all swap IO itself (via ->direct_IO),

Right now it's half ->direct_IO and half ->readpage and about to change
with your series, isn't it?

> rather than just providing devices addresses for submit_bio(),
> SWP_FS_OPS must be set.
> Currently the protocol for setting this it to have ->swap_activate
> return zero.  In that case SWP_FS_OPS is set, and add_swap_extent()
> is called for the entire file.
> 
> This is a little clumsy as different return values for ->swap_activate
> have quite different meanings, and it makes it hard to search for which
> filesystems require SWP_FS_OPS to be set.
> 
> So remove the special meaning of a zero return, and require the
> filesystem to set SWP_FS_OPS if it so desires, and to always call
> add_swap_extent() as required.
> 
> Currently only NFS and CIFS return zero for add_swap_extent().
> 
> Signed-off-by: NeilBrown <neilb@suse.de>

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
