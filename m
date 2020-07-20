Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2629D226E23
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Jul 2020 20:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729430AbgGTSRA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 Jul 2020 14:17:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:50350 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728703AbgGTSRA (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 20 Jul 2020 14:17:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0122AACFE;
        Mon, 20 Jul 2020 18:17:06 +0000 (UTC)
Date:   Mon, 20 Jul 2020 20:16:58 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "ltp@lists.linux.it" <ltp@lists.linux.it>,
        "bfields@fieldses.org" <bfields@fieldses.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "alexey.kodanev@oracle.com" <alexey.kodanev@oracle.com>,
        "yangx.jy@cn.fujitsu.com" <yangx.jy@cn.fujitsu.com>,
        Cyril Hrubis <chrubis@suse.cz>, Yong Sun <yosun@suse.com>
Subject: Re: [RFC PATCH 1/1] Remove nfsv4
Message-ID: <20200720181658.GA32123@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20200720091449.19813-1-pvorel@suse.cz>
 <ffb5cd64d5d65b762bdc85b6044b7fdc526d27cb.camel@hammerspace.com>
 <20200720151742.GA16973@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200720151742.GA16973@infradead.org>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Christoph,

> On Mon, Jul 20, 2020 at 01:32:09PM +0000, Trond Myklebust wrote:
> > On Mon, 2020-07-20 at 11:14 +0200, Petr Vorel wrote:
> > > Reasons to drop:
> > > * outdated tests (from 2005)
> > > * not used (NFS kernel maintainers use pynfs [1])
> > > * written in Python (we support C and shell, see [2])

> > > [1] http://git.linux-nfs.org/?p=bfields/pynfs.git;a=summary
> > > [2] https://github.com/linux-test-project/ltp/issues/547


> > Unlike pynfs, these tests run on a real NFS client, and were designed
> > to test client implementations, as well as the servers.

> > So if they get dropped from ltp, then we will have to figure out some
> > other way of continuing to maintain them.

> NFS tests using the kernel sound like a prime candidate for xfstests.
In the past Yong Sun moved some ext4 related tests from LTP to xfstests.
LTP has various NFS related tests. IMHO more important than where these tests
should be is if anybody has a deeper look into them an cleanup them / rewrite
them from scratch.

Kind regards,
Petr
