Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 253F647BC0B
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Dec 2021 09:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234800AbhLUIqY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 21 Dec 2021 03:46:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234361AbhLUIqX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 21 Dec 2021 03:46:23 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94677C061574;
        Tue, 21 Dec 2021 00:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JhiAW2eWgEksdZBxQUfFNAk6gBj2wiZNzgvEleJmSD8=; b=QRDZxGxvDhUFMF+T6jxGx19J19
        gn30wGZCsdBtv/+zgpSHb7K7Zsoi/o+KotPU4iLqHWww0LyIl7X1rQluihE/9O72XX8wjWJfx2MHR
        dzJXGXfsrn/kLw/OLQAcDZpt0R60XE7Fu9U/wF5r2ErVfVoPT2ggfH2WK+tF6tO4U/FFhtRA5s+Ze
        jdtApXdW94g09RdGKwTShLv7dAkbH5BLgkjJAyp3uT0OvbTdkxYVb3GyFikW4eqZp6Bkdb+8Lropw
        7XOjyy905TLjPjvi55XQ+aIUYxfywuWdnqWGx35B4v+/C0WZyA21AyBpkg9OZyeSlRTkOLCwX8008
        +dZr0Q8g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mzamp-005y59-5I; Tue, 21 Dec 2021 08:46:19 +0000
Date:   Tue, 21 Dec 2021 00:46:19 -0800
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
Subject: Re: [PATCH 08/18] MM: Add AS_CAN_DIO mapping flag
Message-ID: <YcGUWxqQts79Kv6B@infradead.org>
References: <163969801519.20885.3977673503103544412.stgit@noble.brown>
 <163969850302.20885.17124747377211907111.stgit@noble.brown>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163969850302.20885.17124747377211907111.stgit@noble.brown>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Dec 17, 2021 at 10:48:23AM +1100, NeilBrown wrote:
> Currently various places test if direct IO is possible on a file by
> checking for the existence of the direct_IO address space operation.
> This is a poor choice, as the direct_IO operation may not be used - it is
> only used if the generic_file_*_iter functions are called for direct IO
> and some filesystems - particularly NFS - don't do this.
> 
> Instead, introduce a new mapping flag: AS_CAN_DIO and change the various
> places to check this (avoiding a pointer dereference).
> unlock_new_inode() will set this flag if ->direct_IO is present, so
> filesystems do not need to be changed.
> 
> NFS *is* changed, to set the flag explicitly and discard the direct_IO
> entry in the address_space_operations for files.

For other can flags related to file operations we usuall stash them into
file->f_mode.  Any reason to treat this different?
