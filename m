Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4216497ACD
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Jan 2022 09:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235066AbiAXI4a (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 24 Jan 2022 03:56:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232547AbiAXI43 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 24 Jan 2022 03:56:29 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 974B5C06173B;
        Mon, 24 Jan 2022 00:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UeEStLq1BcaRCxlc7CK5jWbcG0Yi+4h/9FQlvr3ixBU=; b=AqbURbgTjyxvDrFz8NjYHx7gka
        p7fHZJQ/PKW4QktMWpkLsjNHc+NXOBgYeYxw7buCKzE9cI6oj3i7jvbO3oTjoQIVILFYSeOq+vR6C
        0O6aWDNH6kvejWIMRISU2QEzLkGfSAo2b2tVQxfr+feytZxFq1lRNPiBuKCekf/osPEOVsudAVJnI
        HcmglMDhItYNdfWJeKjtbnnChfOvmzpD8HVHELXXSeDpQkRejvKlmlgr0xzTzm7zY1AmpxTS9c6X/
        ZAomAuKWJDJ9NddslHFKG2OTjts/MYHkXRux/lI3lf9czp+iXnlxKwhKMm6GEs5VPRxsokUsrbxCN
        8VutyOiA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nBv9F-002h4I-0F; Mon, 24 Jan 2022 08:56:25 +0000
Date:   Mon, 24 Jan 2022 00:56:24 -0800
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
Subject: Re: [PATCH 11/23] VFS: Add FMODE_CAN_ODIRECT file flag
Message-ID: <Ye5puPat8w9/nQ6R@infradead.org>
References: <164299573337.26253.7538614611220034049.stgit@noble.brown>
 <164299611280.26253.2845018521780218144.stgit@noble.brown>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164299611280.26253.2845018521780218144.stgit@noble.brown>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Jan 24, 2022 at 02:48:32PM +1100, NeilBrown wrote:
> Currently various places test if direct IO is possible on a file by
> checking for the existence of the direct_IO address space operation.
> This is a poor choice, as the direct_IO operation may not be used - it is
> only used if the generic_file_*_iter functions are called for direct IO
> and some filesystems - particularly NFS - don't do this.
> 
> Instead, introduce a new f_mode flag: FMODE_CAN_ODIRECT and change the
> various places to check this (avoiding pointer dereferences).
> do_dentry_open() will set this flag if ->direct_IO is present, so
> filesystems do not need to be changed.
> 
> NFS *is* changed, to set the flag explicitly and discard the direct_IO
> entry in the address_space_operations for files.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

It would be nice to throw in a cleanup to remove noop_direct_IO as well.

