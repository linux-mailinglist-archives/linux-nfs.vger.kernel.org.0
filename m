Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D26A4529F5
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Nov 2021 06:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236185AbhKPFrs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 16 Nov 2021 00:47:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236154AbhKPFrl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 16 Nov 2021 00:47:41 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF74CC079794;
        Mon, 15 Nov 2021 19:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=c8TaYYX1zKy7i28b/mSLAzG8phHLkyan0csYuEpNJ5I=; b=LskO0SarMS4mrwrBP1UbwKNj3m
        JljHVvow4H2WyVhlEBH+Gbgu/pcis3a78BgOUygrhGyZI0khPAMW55pPVRvFmQh1Ksgnl6SZtDy0L
        +O16MvL70j6spBSqLn2Sfx79pJXxlPei9W618gtw/deWxHtGqzZJAABXXZeBdkvcA2AUQyN1ruQio
        95INbyhDl4R4sivN+sLfiFDizLIWhZLZ2/vayt45mZVavtk7Kj9o6MGNjMUOIVIoosaVJQaSP6ZHM
        zuG8xJ2ssl+k8fkSJGvagwPwIsz1xaPoaBeoYd9qfJwIwcFlVCte++qLPdZro39hsiEiNsHkHELNu
        0eeoYo4g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mmp9v-006RCM-DE; Tue, 16 Nov 2021 03:29:23 +0000
Date:   Tue, 16 Nov 2021 03:29:23 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/13] Repair SWAP-over-NFS
Message-ID: <YZMlk2sVjt5viat2@casper.infradead.org>
References: <163702956672.25805.16457749992977493579.stgit@noble.brown>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163702956672.25805.16457749992977493579.stgit@noble.brown>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Nov 16, 2021 at 01:44:04PM +1100, NeilBrown wrote:
> swap-over-NFS currently has a variety of problems.
> 
> Due to a newish test in generic_write_checks(), all writes to swap
> currently fail.

And by "currently", you mean "for over two years" (August 2019).
Does swap-over-NFS (or any other network filesystem) actually have any
users, and should we fix it or rip it out?

