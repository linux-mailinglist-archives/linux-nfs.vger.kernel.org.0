Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E37E3CD07C
	for <lists+linux-nfs@lfdr.de>; Mon, 19 Jul 2021 11:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235129AbhGSIjD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 19 Jul 2021 04:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234730AbhGSIjC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 19 Jul 2021 04:39:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A151C061574;
        Mon, 19 Jul 2021 01:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fV+v0WEDYq1e/99KIYLPM4pt2RQcHsAUsEfsMJoG2mk=; b=BcM7xFZbRqaTUQKPjlJgNNxrxl
        LObLueIAeKKSN9c0+2VWf7ks6Zz27TzT9TNCGMY3NOE2nJZrQTVS9XFQheOPiJ4jd32qiC/GsBmBf
        tRCZ49n+zh3URnbVy0zinXSf3GaBXsFBzE7pLNjsubLupGIULyEMPjwO0yqXA1qZUgAFa16ARNzV5
        JFKbKgu3a5SbWfGByf0NQ4ex6OWTigsk1izpWkGe4u8qHSX0oBIm2+mMyRU1sN6Q58JD2tKE74s0g
        wAFhfrM/ByJZGlIqQSGtcmxbT8eIrlXUSU+sWtu8ZJVTfr8PaEtD0ZsxDRMwrjh34H7QoThONt5IB
        l7KIVupQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m5POJ-006h2m-3V; Mon, 19 Jul 2021 09:17:26 +0000
Date:   Mon, 19 Jul 2021 10:16:47 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Christoph Hellwig <hch@infradead.org>, NeilBrown <neilb@suse.de>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, linux-nfs@vger.kernel.org,
        Wang Yugui <wangyugui@e16-tech.com>,
        Ulli Horlacher <framstag@rus.uni-stuttgart.de>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH/RFC] NFSD: handle BTRFS subvolumes better.
Message-ID: <YPVC/w4kw3y/14oF@infradead.org>
References: <20210613115313.BC59.409509F4@e16-tech.com>
 <20210310074620.GA2158@tik.uni-stuttgart.de>
 <162632387205.13764.6196748476850020429@noble.neil.brown.name>
 <edd94b15-90df-c540-b9aa-8eac89b6713b@toxicpanda.com>
 <YPBmGknHpFb06fnD@infradead.org>
 <28bb883d-8d14-f11a-b37f-d8e71118f87f@toxicpanda.com>
 <YPBvUfCNmv0ElBpo@infradead.org>
 <e1d9caad-e4c7-09d4-b145-5397b24e1cc7@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1d9caad-e4c7-09d4-b145-5397b24e1cc7@toxicpanda.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Jul 15, 2021 at 02:01:11PM -0400, Josef Bacik wrote:
> This is not a workable solution.  It's not a matter of simply tying into
> existing infrastructure, we'd have to completely rework how the VFS deals
> with this stuff in order to be reasonable.  And when I brought this up to Al
> he told me I was insane and we absolutely had to have a different SB for
> every vfsmount, which means we can't use vfsmount for this, which means we
> don't have any other options.  Thanks,

Then fix the problem another way.  The problem is known, old and keeps
breaking stuff.  Don't paper over it, fix it. 
