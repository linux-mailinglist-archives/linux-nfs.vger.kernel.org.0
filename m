Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D28112B2FD2
	for <lists+linux-nfs@lfdr.de>; Sat, 14 Nov 2020 19:50:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726136AbgKNSto (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 14 Nov 2020 13:49:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbgKNSto (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 14 Nov 2020 13:49:44 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46BAEC0613D1
        for <linux-nfs@vger.kernel.org>; Sat, 14 Nov 2020 10:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vMSktjt+UCDwNSIBqwe4SAFftEbiuIcAtMHlZ9JW6LU=; b=Ub+k8v5BUZOhHlFyjoN8MLx+/+
        uL7G8BdZKp3pKHJF1d/Bes/pY9XTkPSQogLqLG908PgiD6t2nCXL10tbSdUwvUj4AOFhdxd+R35O4
        k/y5emJnI/Chz7GNeFDj8Q9ZzSy+U2LLS53TlKgnp0gtHxlBuSt3XEF77Y2bZA1fmzE6omNyDfavp
        FbdDNouuEVRtQ7av92h+OlMHbVaWqmYlRffY8Do3es74lkV51xYMb2aS/bQ56OPusudz04OLOfKe4
        m8veNdK/I1k7nxSDEq7zhPoNA5DvU8vbyS6mPXUxLfifYAJBI30GHavxwuXIIfpamh+ZDiCEXiHq2
        WzCY27nA==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ke0cI-0003fa-Oa; Sat, 14 Nov 2020 18:49:42 +0000
Date:   Sat, 14 Nov 2020 18:49:42 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v1 06/61] NFSD: Replace READ* macros in
 nfsd4_decode_access()
Message-ID: <20201114184942.GA13976@infradead.org>
References: <160527962905.6186.17550620763636619885.stgit@klimt.1015granger.net>
 <160527977531.6186.18215866313473241680.stgit@klimt.1015granger.net>
 <20201114092846.GA29362@infradead.org>
 <E38DF8DB-D9C8-4139-AB5F-5905FCFB44E5@oracle.com>
 <20201114184516.GA12185@infradead.org>
 <573FCC0F-9F4E-4378-9839-799DA15AA9B6@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <573FCC0F-9F4E-4378-9839-799DA15AA9B6@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, Nov 14, 2020 at 01:48:13PM -0500, Chuck Lever wrote:
> So you would prefer:
> 
> static __be32 nfsd4_decode_access(struct nfsd4_compoundargs *argp,
>                                   struct nfsd4_access *access)
> 
> ?

My personal preference is two tab alignments for the continuation
line, but that vs aligning to the opening brace has always been one
of two options with people picking one (another thing recent
checkpatch.pl gets wrong).
