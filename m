Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5C83CA2FD
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Jul 2021 18:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235167AbhGOQtc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 15 Jul 2021 12:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235611AbhGOQt1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 15 Jul 2021 12:49:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 675D9C0613E0;
        Thu, 15 Jul 2021 09:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/7GiXib3FgEjPnkD4KLHXuIXZQxX/7FD3SVEsgiVNzY=; b=dME7+2ncCfG2ezk4CF7jiu1RpM
        r5+knDZtC4nH4E/BqHKQOr8VxzIaJ2BWu0IQysCWbZoLYJ2kAXh47/EyK9Yzle5ualiHEIqyELU4d
        NGch2dBbSGdUf/fAnibR2iaNndlmKMexlohGDPysHKllwJzHw2SV6ys4ZqgC/KHe/eCIGjw2hqjHN
        RKz2OKYT4beY6/XKx1LEcR3lbYsk3LNVs5TvwzyoaaszNhyAS9OZrYUWbDGsJoQTspPmgoiaaymci
        lPy+wmIU1/Xsr4UIIjXLXjxu+WLDEkrw4yflgfcPRlLPzH8sw5gKhZXdOomFlM/Ss1ZM4mm+pWfa9
        9V6qZ4yw==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m44U6-003WwI-Az; Thu, 15 Jul 2021 16:45:23 +0000
Date:   Thu, 15 Jul 2021 17:45:14 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     NeilBrown <neilb@suse.de>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, linux-nfs@vger.kernel.org,
        Wang Yugui <wangyugui@e16-tech.com>,
        Ulli Horlacher <framstag@rus.uni-stuttgart.de>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH/RFC] NFSD: handle BTRFS subvolumes better.
Message-ID: <YPBmGknHpFb06fnD@infradead.org>
References: <20210613115313.BC59.409509F4@e16-tech.com>
 <20210310074620.GA2158@tik.uni-stuttgart.de>
 <162632387205.13764.6196748476850020429@noble.neil.brown.name>
 <edd94b15-90df-c540-b9aa-8eac89b6713b@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <edd94b15-90df-c540-b9aa-8eac89b6713b@toxicpanda.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Jul 15, 2021 at 10:09:37AM -0400, Josef Bacik wrote:
> I'm going to restate what I think the problem is you're having just so I'm
> sure we're on the same page.
> 
> 1. We export a btrfs volume via nfsd that has multiple subvolumes.
> 2. We run find, and when we stat a file, nfsd doesn't send along our bogus
> st_dev, it sends it's own thing (I assume?).  This confuses du/find because
> you get the same inode number with different parents.
> 
> Is this correct?  If that's the case then it' be relatively straightforward
> to add another callback into export_operations to grab this fsid right?
> Hell we could simply return the objectid of the root since that's unique
> across the entire file system.  We already do our magic FH encoding to make
> sure we keep all this straight for NFS, another callback to give that info
> isn't going to kill us.  Thanks,

Hell no.  btrfs is broken plain and simple, and we've been arguing about
this for years without progress.  btrfs needs to stop claiming different
st_dev inside the same mount, otherwise hell is going to break lose left
right and center, and this is just one of the many cases where it does.
