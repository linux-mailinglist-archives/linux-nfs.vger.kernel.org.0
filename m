Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 312C722631A
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Jul 2020 17:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbgGTPRx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 Jul 2020 11:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgGTPRx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 20 Jul 2020 11:17:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C8EC061794
        for <linux-nfs@vger.kernel.org>; Mon, 20 Jul 2020 08:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RTJCQoT4n3eWjZd87cifxoVNLQME7QIUwsdXFeCJ158=; b=Oly5kqo+KwadkUB4cUygk58rbp
        MRC4xydVj5qb+0LEU7vRlfG1/kiqkmx/KptgXdtczWVZPp2A6vnQqDB252lEUtdXduN0P9qymCI5u
        v89xLosSCAPb5i1lfhjBOxW3cjkLwvZY82rXdw6YJGJdvuOe/TxkQmDavE6j7Kr9QVigFKKrGCDbu
        1jEyTbbz86Lbrx5QrTIWinJqxdU74tYW6svxP25Au+S4E/EcrrGGiK1TQGJ0xwXOL8DbYH22eUbjj
        4ONW4mtlpQqZJcaTxIX95yEjU56QPWjuZdttlm8KutyHy08cvloYC8EOET3ORMu5cM6rLkpgrw2Fs
        rRQITaXg==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxXXy-0004fJ-Na; Mon, 20 Jul 2020 15:17:42 +0000
Date:   Mon, 20 Jul 2020 16:17:42 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "ltp@lists.linux.it" <ltp@lists.linux.it>,
        "pvorel@suse.cz" <pvorel@suse.cz>,
        "bfields@fieldses.org" <bfields@fieldses.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "alexey.kodanev@oracle.com" <alexey.kodanev@oracle.com>,
        "yangx.jy@cn.fujitsu.com" <yangx.jy@cn.fujitsu.com>
Subject: Re: [RFC PATCH 1/1] Remove nfsv4
Message-ID: <20200720151742.GA16973@infradead.org>
References: <20200720091449.19813-1-pvorel@suse.cz>
 <ffb5cd64d5d65b762bdc85b6044b7fdc526d27cb.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ffb5cd64d5d65b762bdc85b6044b7fdc526d27cb.camel@hammerspace.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Jul 20, 2020 at 01:32:09PM +0000, Trond Myklebust wrote:
> On Mon, 2020-07-20 at 11:14 +0200, Petr Vorel wrote:
> > Reasons to drop:
> > * outdated tests (from 2005)
> > * not used (NFS kernel maintainers use pynfs [1])
> > * written in Python (we support C and shell, see [2])
> > 
> > [1] http://git.linux-nfs.org/?p=bfields/pynfs.git;a=summary
> > [2] https://github.com/linux-test-project/ltp/issues/547
> > 
> 
> Unlike pynfs, these tests run on a real NFS client, and were designed
> to test client implementations, as well as the servers.
> 
> So if they get dropped from ltp, then we will have to figure out some
> other way of continuing to maintain them.

NFS tests using the kernel sound like a prime candidate for xfstests.
