Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 935061AB8D0
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2020 08:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437379AbgDPG4Z (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 16 Apr 2020 02:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2436700AbgDPG4W (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 16 Apr 2020 02:56:22 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 628CCC061A0C;
        Wed, 15 Apr 2020 23:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=C5xKJW9GVLUaEwmsGcgxx38194ESNJpidrJ6svW+S14=; b=nNqwKXMcvO1nCQPM6W3MouyrS5
        MCb8h0GleAEjJan4ZUms7JqwTlQvsvnhav/+i5elBTStKBOPlYONP0aFn4xujiGrbUhMSJr1yY6xA
        WFDV0IVuJgs3xulDUdJz/FW1fWMXoeYm7/bsUi7qFJgG8EblogzGCSwk7vRCYAvHFdRjouKDclHZX
        qS0kd77pONKQKEJxxj9q7lfpY9lFJ5IWtC9dgCaAwruR+Zi9o2IJABHqcuD1oWO5hLMM/sSEjAu4y
        Hlb6UcyGt8fXE/zq6GExtd5DiddbTh3FtQRFSJw9XMCCfW6brizWGSy6JDytp6jvaFZFIZSE67LaE
        fvV0qhYQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jOyRe-0003t8-6k; Thu, 16 Apr 2020 06:56:18 +0000
Date:   Wed, 15 Apr 2020 23:56:18 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "Anna.Schumaker@Netapp.com" <Anna.Schumaker@netapp.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Michal Hocko <mhocko@kernel.org>,
        linux-mm@kvack.org, linux-nfs@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2 V3] MM: Discard NR_UNSTABLE_NFS, use NR_WRITEBACK
 instead.
Message-ID: <20200416065618.GB1092@infradead.org>
References: <87tv2b7q72.fsf@notabene.neil.brown.name>
 <87v9miydai.fsf@notabene.neil.brown.name>
 <87ftdgw58w.fsf@notabene.neil.brown.name>
 <87wo6gs26e.fsf@notabene.neil.brown.name>
 <87r1wos23k.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r1wos23k.fsf@notabene.neil.brown.name>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Apr 16, 2020 at 10:31:27AM +1000, NeilBrown wrote:
>  	return global_node_page_state(NR_FILE_DIRTY) +
> -		global_node_page_state(NR_UNSTABLE_NFS) +
>  		get_nr_dirty_inodes();

Nit: this could a single line now:

  	return global_node_page_state(NR_FILE_DIRTY) + get_nr_dirty_inodes();

> +		/* This page is really still in write-back - just that the
> +		 * writeback is happening on the server now.
> +		 */

This needs to switch to the canonical kernel comment style.

> +	if (off == NR_VMSTAT_ITEMS - 1) {
> +		/* We've come to the end - add any deprecated counters
> +		 * to avoid breaking userspace which might depend on
> +		 * them being present.
> +		 */

Same here.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
