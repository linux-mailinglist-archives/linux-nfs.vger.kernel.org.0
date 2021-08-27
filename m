Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD713F9B84
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Aug 2021 17:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233816AbhH0PQB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 27 Aug 2021 11:16:01 -0400
Received: from verein.lst.de ([213.95.11.211]:34260 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233587AbhH0PQA (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 27 Aug 2021 11:16:00 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4F80D67373; Fri, 27 Aug 2021 17:15:06 +0200 (CEST)
Date:   Fri, 27 Aug 2021 17:15:05 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     NeilBrown <neilb@suse.de>
Cc:     "J.  Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Christoph Hellwig <hch@lst.de>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] NFSD: drop support for ancient file-handles
Message-ID: <20210827151505.GA19199@lst.de>
References: <162995209561.7591.4202079352301963089@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162995209561.7591.4202079352301963089@noble.neil.brown.name>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Aug 26, 2021 at 02:28:15PM +1000, NeilBrown wrote:
> This patch also moves the nfsfh.h from the include/uapi directory into
> fs/nfsd.  I can find no evidence of it being used anywhere outside the
> kernel.  Certainly nfs-utils and wireshark do not use it.

That sounds fine, but I'd split this into a separate patch.

> fh_base and fh_pad are occasionally used to refer to the whole
> filehandle.  These are replaced with "fh_raw" which is hopefully more
> meaningful.

I think that kind of cleanup should also be a separate patch.  That
being said as far as I can tell fh_raw is only ever used in context
where we can just pass a void pointer.  So just giving the struct
for the "new" file handle after fh_size a name and passing that
would be much cleaner than a union with a char array.


> I found
>  https://www.spinics.net/lists/linux-nfs/msg43280.html
>  "Re: [PATCH] nfsd: clean up fh_auth usage"
> from 2014 where moving nfsfh.h out of uapi was considered but not
> actioned. Christoph said he would "do some research if the
> uapi <linux/nfsd/*.h> headers are used anywhere at all".  I can find no
> report on the result of that research.  My own research turned up
> nothing.

I can't remember doing much of research, and certainly not of finding
anything.

> -	memcpy((char*)&fh.fh_handle.fh_base, f->data, f->size);
> +	memcpy((char*)&fh.fh_handle.fh_raw, f->data, f->size);

Indedpendnt on what we're going to pass here, I don't think we
should need cast like this one (there are a few more).
