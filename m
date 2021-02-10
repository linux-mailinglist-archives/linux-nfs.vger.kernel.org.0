Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1A3D3162D3
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Feb 2021 10:55:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbhBJJyc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 10 Feb 2021 04:54:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbhBJJw0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 10 Feb 2021 04:52:26 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFAD9C0613D6
        for <linux-nfs@vger.kernel.org>; Wed, 10 Feb 2021 01:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=n09wwhZPZMXRQlfuuptpJPZK8mMhtnt/MOWmfwDWJnA=; b=rrYVXN3xejO6bWjUBoXyyXkN7N
        wf6ebGNzeLGzfhuXhXBChpz46OM39D6ZS2FlZXhPgyqifVQnMvzBILKzk1hHFB7rAbi5uDKfWBfBJ
        wl94xJbv3yrJ3f10rcASvjcJlg1Keh7RjGGdedXzvjkW645ZvyRKGA5VDGMd5/TCWOzJFjQp+vY6x
        5PF8GYXav/a2sSd/8Su2IrydijNRyX+ipDaPAfFH/yLQGbjoJleIMYvsg0AGb4sa8AfgEZL1mM36B
        P8t8j+JjtYwpWJi4DbI2QIVwyLKS6rt76auhQRmDt+bDKc3JwMJDT6a6pLib2uNlcRUCRXbOk+xTm
        cfO221lA==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l9m9f-008fhd-Lz; Wed, 10 Feb 2021 09:51:30 +0000
Date:   Wed, 10 Feb 2021 09:51:27 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Jesper Dangaard Brouer <brouer@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: Re: alloc_pages_bulk()
Message-ID: <20210210095127.GA2066247@infradead.org>
References: <2A0C36E7-8CB0-486F-A8DB-463CA28C5C5D@oracle.com>
 <EEB0B974-6E63-41A0-9C01-F0DEA39FC4BF@oracle.com>
 <20210209113108.1ca16cfa@carbon>
 <7e8efe19-94da-3f75-2380-2a54b36d5ab5@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e8efe19-94da-3f75-2380-2a54b36d5ab5@suse.cz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Feb 09, 2021 at 06:27:11PM +0100, Vlastimil Babka wrote:
> 
> > The fourth patch introduces a bulk page allocator with no
> > in-kernel users as an example for Jesper and others who want to
> > build a page allocator for DMA-coherent pages.  It hopefully is
> > relatively easy to modify this API and the one core function toget > the
> semantics they require.
> 
> So it seems there were no immediate users to finalize the API?

__iommu_dma_alloc_pages would be a hot candidate.
