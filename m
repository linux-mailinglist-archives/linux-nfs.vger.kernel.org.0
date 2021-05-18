Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5242387359
	for <lists+linux-nfs@lfdr.de>; Tue, 18 May 2021 09:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242076AbhERHft (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 18 May 2021 03:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240235AbhERHfs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 18 May 2021 03:35:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2192DC061573
        for <linux-nfs@vger.kernel.org>; Tue, 18 May 2021 00:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=37Kn3wU7h4fxXGH3w1mRKHTrlpASYF2B7OB9XxPtwso=; b=tO9Tp7MPLO9/8oYQ5RwlGhF/Sh
        MjznWhtCZuDsMcP+umfPgHgHMRuDSBs/qgMLXks4Fg3bieqTd3EU7BXIx+keEwGE9mDqq2e6Ezs1g
        RPXlNU6illE/co7HDmKYCo03vZMywnRSOhXuwT5O/mSRjd8QRyRYqfDZGAr+PHGUul6trG/qquH/s
        2O4fb/04DgMyMhUdCaeoBCDXNQ2EPm7EN0wu5KfqriF75ZMetb+EB36O3w3QyExTZrQyfdv0QNTQM
        nm634qqv2PPTruudTHBUvSKdjnOfa4qBQC6JtqbOKw0H3rLrmKNNGfVC4hva0wk+1f5dZjHVptfgv
        lR1pxXpA==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1liuEX-00Dlgy-G5; Tue, 18 May 2021 07:33:46 +0000
Date:   Tue, 18 May 2021 08:33:41 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "bfields@fieldses.org" <bfields@fieldses.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        "nickhuang@synology.com" <nickhuang@synology.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "robbieko@synology.com" <robbieko@synology.com>,
        "bingjingc@synology.com" <bingjingc@synology.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        viro@zeniv.linux.org.uk
Subject: Re: [PATCH] nfsd: Prevent truncation of an unlinked inode from
 blocking access to its directory
Message-ID: <YKNt1cJn/e0w/ftm@infradead.org>
References: <20210514035829.5230-1-nickhuang@synology.com>
 <00195ec8bf1752306f549540eed74c3938c5e312.camel@hammerspace.com>
 <YJ9yD1S6Yl2m0gOO@infradead.org>
 <20210517185659.GA4216@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210517185659.GA4216@fieldses.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, May 17, 2021 at 02:56:59PM -0400, bfields@fieldses.org wrote:
> On Sat, May 15, 2021 at 08:02:39AM +0100, Christoph Hellwig wrote:
> > On Fri, May 14, 2021 at 03:46:57PM +0000, Trond Myklebust wrote:
> > > Why leave the commit_metadata() call under the lock? If you're
> > > concerned about latency, then it makes more sense to call fh_unlock()
> > > before flushing those metadata updates to disk.
> > 
> > Also I'm not sure why the extra inode reference is needed.  What speaks
> > against just moving the dput out of the locked section?
> 
> I don't know.  Do you know why do_unlinkat() is doing the same thing?

No.  Al, any idea why unlink does the final dput under i_rwsem?
