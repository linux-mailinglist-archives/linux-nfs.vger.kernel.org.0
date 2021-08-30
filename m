Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC4C3FB2E6
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Aug 2021 11:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235304AbhH3JMB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Aug 2021 05:12:01 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:47856 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234714AbhH3JMA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 30 Aug 2021 05:12:00 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id AD9342210A;
        Mon, 30 Aug 2021 09:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1630314666; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u9PHrKLeF/G92NZinwTPYi6Jk6TfyNGd5chLk0Q8RQw=;
        b=K+blWjJcwt1t6ZUxLw4mt6iY/X3AYSEpp+NgugaOuXgmjzDCUYli0wwrMc5ibDdmGsskje
        q7ovXoWsoNBgUQERrN98XxrPqK+VyMYtgLw5X07pYm6oM1djM8NFrRDMWmpXoLsO/vhY1J
        lg/OQ4n38Mu2nTZd0iXndKwD7cBPvNk=
Received: from suse.com (unknown [10.163.43.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 60D45A3B9D;
        Mon, 30 Aug 2021 09:11:06 +0000 (UTC)
Date:   Mon, 30 Aug 2021 10:11:04 +0100
From:   Mel Gorman <mgorman@suse.com>
To:     NeilBrown <neilb@suse.de>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        Mike Javorski <mike.javorski@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-mm@kvack.org
Subject: Re: [PATCH] MM: clarify effort used in alloc_pages_bulk_*()
Message-ID: <20210830091104.GA3997@suse.com>
References: <163004202961.7591.12633163545286005205@noble.neil.brown.name>
 <CAOv1SKDTcg5WDp5zf3ZGL0enJ7K693W-9TMYKcrgweyzp6Qjhg@mail.gmail.com>
 <163004848514.7591.2757618782251492498@noble.neil.brown.name>
 <6CC9C852-CEE3-4657-86AD-9D5759E2BE1C@oracle.com>
 <CAOv1SKAiPB62sQcnDCKC5vYbbmakfbe80KRu3JEVZVO7Trk8cw@mail.gmail.com>
 <CAOv1SKATk1iP=J9r2x0CQzNuwq2VoRvN8Mkba3DsKq6W_tfrDQ@mail.gmail.com>
 <416268C9-BEAC-483C-9392-8139340BC849@oracle.com>
 <CAOv1SKCjvgSfUoFtufZ5-dB-quG=djnn-UHO286S410aVxrV0Q@mail.gmail.com>
 <12B831AA-4A4E-4102-ADA3-97B6FA0B119E@oracle.com>
 <163027609524.7591.4987241695872857175@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <163027609524.7591.4987241695872857175@noble.neil.brown.name>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Aug 30, 2021 at 08:28:15AM +1000, NeilBrown wrote:
> 
> The alloc_pages_bulk_*() interfaces do not make it clear what degree
> of success can be expected.
> 
> The code appears to allocate at least one page with the same effort as
> alloc_page() when used with the same GFP flags, and then to allocate any
> more only opportunistically.  So a caller should not *expect* to get a
> full allocation, but should not be *surprised* by one either.
> 
> Add text to the comment clarifying this.
> 
> Also fix a bug.  When alloc_pages_bulk_array() is called on an array
> that is partially allocated, the level of effort to get a single page is
> less than when the array was completely unallocated.  This behaviour is
> inconsistent, but now fixed.
> 
> Fixes: 0f87d9d30f21 ("mm/page_alloc: add an array-based interface to the bulk page allocator")
> Signed-off-by: NeilBrown <neilb@suse.de>

Acked-by: Mel Gorman <mgorman@suse.com>

-- 
Mel Gorman
SUSE Labs
