Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4125C497977
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Jan 2022 08:31:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241843AbiAXHbV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 24 Jan 2022 02:31:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232329AbiAXHbS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 24 Jan 2022 02:31:18 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C614C06173B;
        Sun, 23 Jan 2022 23:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wm9QWOWAoKnKE8jbHgQf6O6XgO5ODHRTGPygTipLI00=; b=ZhSOw6y0O+aXYSf2WxdcCVJjgg
        +ZN8avm2joj0S5DBp8UHCsG/XhcTwW86PbqDoGOj9MDtZ5b9GlDCnjYLHGbEfmOT2Qs+yrtb47ihy
        N1pmUz4y0aSlHckLeL2GtCuEdYduiKRlfsyB9sCAf5mMRxZkjFEYh6GZwlqD3o5xPS1q8hJOsFdsY
        kComh8k4+fsuflvjI+t0qG6EZuujnrUKInbRApEPjSiqrosquB3RYdhbl0/QMbWmG+luKBpQCYuyp
        6rcDu0RPp8q5dew29Bes1s0C3RbpuncnXVAFbtG4QJ5N84jhRvxI/1k2N8q4lrn4492kH8ISZej2B
        sCSHorCA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nBton-002UYH-Sm; Mon, 24 Jan 2022 07:31:13 +0000
Date:   Sun, 23 Jan 2022 23:31:13 -0800
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
Subject: Re: [PATCH 05/23] MM: reclaim mustn't enter FS for SWP_FS_OPS
 swap-space
Message-ID: <Ye5VwTxLAYOprjyy@infradead.org>
References: <164299573337.26253.7538614611220034049.stgit@noble.brown>
 <164299611276.26253.11555458501911153645.stgit@noble.brown>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164299611276.26253.11555458501911153645.stgit@noble.brown>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Jan 24, 2022 at 02:48:32PM +1100, NeilBrown wrote:
> If swap-out is using filesystem operations (SWP_FS_OPS), then it is not
> safe to enter the FS for reclaim.
> So only down-grade the requirement for swap pages to __GFP_IO after
> checking that SWP_FS_OPS are not being used.
> 
> This makes the calculation of "may_enter_fs" slightly more complex, so
> move it into a separate function.  with that done, there is little value
> in maintaining the bool variable any more.  So replace the
> may_enter_fs variable with a may_enter_fs() function.  This removes any
> risk for the variable becoming out-of-date.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
