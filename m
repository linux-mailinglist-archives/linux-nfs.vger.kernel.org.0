Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C47E9497AB0
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Jan 2022 09:50:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236318AbiAXIt7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 24 Jan 2022 03:49:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236266AbiAXIt7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 24 Jan 2022 03:49:59 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D5CBC06173B;
        Mon, 24 Jan 2022 00:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xyivSDGY+EBgTLLx3+YqxywRSiggQuJ6OFlbqF42w1Q=; b=Rvmtrcn8y47mAEE6mhP78/5kNr
        04j7U3Kh22adgIT/viRnnfGhDY2mnAFpnAW7ejqelo2CmkaCI1UmZQXXW3Hn7DIdF0A9G5IdpixDZ
        MAoeYw2XNMJ37bzfy9IgqdZv7Ax8gPLiCrSjhtU79CSTWHS6od+cJvOwkd575tRpj7hxMUZTgKojZ
        Wa+1x7vGHDW1c+5zlea6lyH3PR30gj1GFw4sjgnw9KplAiVOLWTmOZY8pX6qa9qUDKhLLIn8T8a83
        M/8xbQx67hvwdVLCbyOvpMmZ2bg5b/lchaehixXjpgvD0zVidvyss33wXGS+Fx9HNPVn/+JQYhsvv
        kGxsh9KA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nBv2w-002eBq-Km; Mon, 24 Jan 2022 08:49:54 +0000
Date:   Mon, 24 Jan 2022 00:49:54 -0800
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
Subject: Re: [PATCH 07/23] MM: perform async writes to SWP_FS_OPS swap-space
 using ->swap_rw
Message-ID: <Ye5oMkjAzTHTkWNR@infradead.org>
References: <164299573337.26253.7538614611220034049.stgit@noble.brown>
 <164299611277.26253.18349860115008677213.stgit@noble.brown>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164299611277.26253.18349860115008677213.stgit@noble.brown>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Jan 24, 2022 at 02:48:32PM +1100, NeilBrown wrote:
>  
> +static void sio_write_complete(struct kiocb *iocb, long ret)
> +{
> +	struct swap_iocb *sio = container_of(iocb, struct swap_iocb, iocb);
> +	struct page *page = sio->bvec.bv_page;
> +
> +	if (ret != 0 && ret != PAGE_SIZE) {

ret == 0 isn't really a success case for ki_complete, it is something
that should never happen at all.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
