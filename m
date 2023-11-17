Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFDE17EF346
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Nov 2023 14:04:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbjKQNEW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Nov 2023 08:04:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKQNEW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Nov 2023 08:04:22 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF10D52
        for <linux-nfs@vger.kernel.org>; Fri, 17 Nov 2023 05:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uo1kgCdkTwrjI5cP4C8NMzcAVl9mOmCA57e+hhUGPNI=; b=TgVlPpQQByy/XyxLQIz1sSL8yI
        h1BLFP1QHaAESKWCNiw2IzXRLAPh5r58TPFJNjdSsnlvyXndC3cT8iGfoUCycWJWM9rRNM7/PENTY
        IXYtXfOj4E3okbw3iHtvAma3cBgGfYjExIgV4KjceRCVipNLmhFbE3t/dqQcfptXxrYA+/AQR/5Cr
        lPprRK6J1GiiDstvtvnijqwWU3l83Fs3xBRN7Fql8WszOKjybAiqRqAV50ctc9TLcnkbtOJABuMbl
        i4PlKlCOJRbvIUWKNb2ZumbFsYLMWhtuQ85DlGB4o/Sq7b0arZezOE5kbCx5pCbSKj9b7Q7EA/R4C
        oFjf8IxQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1r3yW9-006bQv-0K;
        Fri, 17 Nov 2023 13:04:17 +0000
Date:   Fri, 17 Nov 2023 05:04:17 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Benjamin Coddington <bcodding@redhat.com>
Cc:     trond.myklebust@hammerspace.com, anna@kernel.org,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 1/2] pNFS: Fix the pnfs block driver's calculation of
 layoutget size
Message-ID: <ZVdk0WTHcaYf7kKa@infradead.org>
References: <21a1f2a6155398965f79ed64f0bd23bf38a50367.1700220277.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21a1f2a6155398965f79ed64f0bd23bf38a50367.1700220277.git.bcodding@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Nov 17, 2023 at 06:25:13AM -0500, Benjamin Coddington wrote:
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
> 
> Instead of relying on the value of the 'bytes_left' field, we should
> calculate the layout size based on the offset of the request that is
> being written out.
> 
> Reported-by: Benjamin Coddington <bcodding@redhat.com>
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> Fixes: 954998b60caa ("NFS: Fix error handling for O_DIRECT write scheduling")
> Reviewed-by: Benjamin Coddington <bcodding@redhat.com>
> Tested-by: Benjamin Coddington <bcodding@redhat.com>
> ---
>  fs/nfs/blocklayout/blocklayout.c | 5 ++---
>  fs/nfs/direct.c                  | 5 +++--
>  fs/nfs/internal.h                | 2 +-
>  fs/nfs/pnfs.c                    | 3 ++-
>  4 files changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/nfs/blocklayout/blocklayout.c b/fs/nfs/blocklayout/blocklayout.c
> index 943aeea1eb16..c1cc9fe93dd4 100644
> --- a/fs/nfs/blocklayout/blocklayout.c
> +++ b/fs/nfs/blocklayout/blocklayout.c
> @@ -893,10 +893,9 @@ bl_pg_init_write(struct nfs_pageio_descriptor *pgio, struct nfs_page *req)
>  	}
>  
>  	if (pgio->pg_dreq == NULL)
> -		wb_size = pnfs_num_cont_bytes(pgio->pg_inode,
> -					      req->wb_index);
> +		wb_size = pnfs_num_cont_bytes(pgio->pg_inode, req->wb_index);
>  	else
> -		wb_size = nfs_dreq_bytes_left(pgio->pg_dreq);
> +		wb_size = nfs_dreq_bytes_left(pgio->pg_dreq, req_offset(req));
>  
>  	pnfs_generic_pg_init_write(pgio, req, wb_size);
>  
> diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
> index f6c74f424691..5918c67dae0d 100644
> --- a/fs/nfs/direct.c
> +++ b/fs/nfs/direct.c
> @@ -205,9 +205,10 @@ static void nfs_direct_req_release(struct nfs_direct_req *dreq)
>  	kref_put(&dreq->kref, nfs_direct_req_free);
>  }
>  
> -ssize_t nfs_dreq_bytes_left(struct nfs_direct_req *dreq)
> +ssize_t nfs_dreq_bytes_left(struct nfs_direct_req *dreq, loff_t offset)
>  {
> -	return dreq->bytes_left;
> +	loff_t start = offset - dreq->io_start;
> +	return dreq->max_count - start;

We normally put an empty line after the variable declarations.  But
looking at this, thee local variables seems a bit pointless to me,
as does not simply making this an inline function.

> +extern ssize_t nfs_dreq_bytes_left(struct nfs_direct_req *dreq, loff_t offset);

and you might as well drop the pointless extern here while you're at it.

Otherwise this looks good to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>
