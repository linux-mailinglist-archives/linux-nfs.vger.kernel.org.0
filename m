Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9B24339E1C
	for <lists+linux-nfs@lfdr.de>; Sat, 13 Mar 2021 14:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233509AbhCMNAm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 13 Mar 2021 08:00:42 -0500
Received: from outbound-smtp53.blacknight.com ([46.22.136.237]:35113 "EHLO
        outbound-smtp53.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233492AbhCMNAF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 13 Mar 2021 08:00:05 -0500
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp53.blacknight.com (Postfix) with ESMTPS id 975D06403A
        for <linux-nfs@vger.kernel.org>; Sat, 13 Mar 2021 12:59:33 +0000 (GMT)
Received: (qmail 5122 invoked from network); 13 Mar 2021 12:59:33 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 13 Mar 2021 12:59:33 -0000
Date:   Sat, 13 Mar 2021 12:59:31 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Alexander Duyck <alexander.duyck@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-Net <netdev@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 5/7] SUNRPC: Refresh rq_pages using a bulk page allocator
Message-ID: <20210313125931.GX3697@techsingularity.net>
References: <20210312154331.32229-1-mgorman@techsingularity.net>
 <20210312154331.32229-6-mgorman@techsingularity.net>
 <CAKgT0Uf-4CY=wU079Y87xwzz_UDm8AqGBdt_6OuVtADR8AN0hA@mail.gmail.com>
 <17DF335E-9194-4A16-B18E-668AD1362697@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <17DF335E-9194-4A16-B18E-668AD1362697@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Mar 12, 2021 at 07:22:43PM +0000, Chuck Lever III wrote:
> Mel, I can send you a tidied and tested update to this patch,
> or you can drop the two NFSD patches and I can submit them via
> the NFSD tree when alloc_pages_bulk() is merged.
> 

Send me a tidied version anyway. I'm happy enough to include them in the
series even if it ultimately gets merged via the NFSD tree. It'll need
to be kept as a separate pull request to avoid delaying unrelated NFSD
patches until Andrew merges the mm parts.

-- 
Mel Gorman
SUSE Labs
