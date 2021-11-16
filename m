Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0C62452C34
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Nov 2021 08:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbhKPHzV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 16 Nov 2021 02:55:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbhKPHzS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 16 Nov 2021 02:55:18 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B9BEC061570;
        Mon, 15 Nov 2021 23:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MXk0dMB6e6gfK6gZesuG2kP86bYpfpcfwlTsLC845C0=; b=gitEKn66h1yrZB0ydhd4Vicfwn
        A8qC2UHW4wqH3UfpvA9qFRhJt5G9Gqqj6hCIJ+rVzIpjBmvb1leLrLBzyplTGW7XfkqPUwpCHuwaB
        lI7QNu7wjZd1pjfw+n3sCRea0mb+CgEHxn5r0Jp/P4L+i3aISfm7hLvayyW0xTSi4QJD7J8/jp7NL
        8s9JIRVK4+plGH8ZMonQ2BbyTzKOvKWnCDAXy7x+L1w4SGRBBrv+8rTihd6F1JAGlVBW/aHeL1iNB
        ILo28dMNDsGwbCxtYOelB8IPFD4inryzahWa7twE9v6erq2rvjb0xUuPT2iG4W8Je4HX3GwUljfql
        uUry1TAg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mmtGI-000d13-M4; Tue, 16 Nov 2021 07:52:14 +0000
Date:   Mon, 15 Nov 2021 23:52:14 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/13] NFS: do not take i_rwsem for swap IO
Message-ID: <YZNjLtYKnQ/RFpxR@infradead.org>
References: <163702956672.25805.16457749992977493579.stgit@noble.brown>
 <163703064452.25805.5738767545414940042.stgit@noble.brown>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163703064452.25805.5738767545414940042.stgit@noble.brown>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I'd really much prefer the variant we discussed before where
swap I/O uses it's own method instead of overloading the normal
file I/O path all over.

