Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE46BBCDD
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Sep 2019 22:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502627AbfIWUb1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Sep 2019 16:31:27 -0400
Received: from fieldses.org ([173.255.197.46]:58046 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2502593AbfIWUb1 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 23 Sep 2019 16:31:27 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id CE1C3150F; Mon, 23 Sep 2019 16:31:26 -0400 (EDT)
Date:   Mon, 23 Sep 2019 16:31:26 -0400
To:     Trond Myklebust <trondmy@gmail.com>
Cc:     "J. Bruce Fields" <bfields@redhat.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 0/1] Clean up and fix NFS server handling of eof
Message-ID: <20190923203126.GB5085@fieldses.org>
References: <20190826170311.81482-1-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826170311.81482-1-trond.myklebust@hammerspace.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Thanks, applying!

But I like your explanation better than your explanation on the
patch--copying it into the changelog.

--b

On Mon, Aug 26, 2019 at 01:03:10PM -0400, Trond Myklebust wrote:
> Currently, the knfsd server assumes that a short read indicates and
> end of file. That assumption is incorrect. The short read means that
> either we've hit the end of file, or we've hit a read error.
> 
> In the case of a read error, the client may want to retry (as per
> the implementation recommendations in RFC1813, and RFC7530), but
> currently it is being told that it hit an eof.
> 
> The following patch cleans up read, and fixes the eof reporting
> to the two following cases:
> 1) read() returns a zero length short read with no error.
> 2) the offset+length of the read is >= the file size.
> 
> Trond Myklebust (1):
>   nfsd: Clean up nfs read eof detection
> 
>  fs/nfsd/nfs3proc.c |  9 ++-------
>  fs/nfsd/nfs4xdr.c  | 11 +++--------
>  fs/nfsd/nfsproc.c  |  4 +++-
>  fs/nfsd/vfs.c      | 37 ++++++++++++++++++++++++++-----------
>  fs/nfsd/vfs.h      | 28 ++++++----------------------
>  fs/nfsd/xdr3.h     |  2 +-
>  6 files changed, 41 insertions(+), 50 deletions(-)
> 
> -- 
> 2.21.0
