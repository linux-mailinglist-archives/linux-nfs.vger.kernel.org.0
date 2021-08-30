Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85DC73FB2ED
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Aug 2021 11:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234714AbhH3JNF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Aug 2021 05:13:05 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:47876 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235496AbhH3JNE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 30 Aug 2021 05:13:04 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 56B3B22107;
        Mon, 30 Aug 2021 09:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1630314730; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nywd0oz6iwwHwglHPbyfAVv9NJlMdcowHwWK98LNbhY=;
        b=lffSWkpWgFlYo+ZZM06LAjRDIY5hi3nsHxp8I8HExonKk5tXEZT5IYAPnn1X3QghJbBNeE
        qyHE9DDsETENNM0pWho6lb8RIB/O5MxI3x3o0bPdAmP3RY7sJIGAsSOBk/820h5BSTnrrS
        /t2QDjpvXH3Xf5ebqgUZbXx8r8PE7aE=
Received: from suse.com (unknown [10.163.43.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id CFF69A3B9C;
        Mon, 30 Aug 2021 09:12:09 +0000 (UTC)
Date:   Mon, 30 Aug 2021 10:12:08 +0100
From:   Mel Gorman <mgorman@suse.com>
To:     NeilBrown <neilb@suse.de>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        Mike Javorski <mike.javorski@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] SUNRPC: don't pause on incomplete allocation
Message-ID: <20210830091208.GB3997@suse.com>
References: <163004202961.7591.12633163545286005205@noble.neil.brown.name>
 <CAOv1SKDTcg5WDp5zf3ZGL0enJ7K693W-9TMYKcrgweyzp6Qjhg@mail.gmail.com>
 <163004848514.7591.2757618782251492498@noble.neil.brown.name>
 <6CC9C852-CEE3-4657-86AD-9D5759E2BE1C@oracle.com>
 <CAOv1SKAiPB62sQcnDCKC5vYbbmakfbe80KRu3JEVZVO7Trk8cw@mail.gmail.com>
 <CAOv1SKATk1iP=J9r2x0CQzNuwq2VoRvN8Mkba3DsKq6W_tfrDQ@mail.gmail.com>
 <416268C9-BEAC-483C-9392-8139340BC849@oracle.com>
 <CAOv1SKCjvgSfUoFtufZ5-dB-quG=djnn-UHO286S410aVxrV0Q@mail.gmail.com>
 <12B831AA-4A4E-4102-ADA3-97B6FA0B119E@oracle.com>
 <163027659478.7591.8897815399981483759@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <163027659478.7591.8897815399981483759@noble.neil.brown.name>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Aug 30, 2021 at 08:36:34AM +1000, NeilBrown wrote:
> 
> alloc_pages_bulk_array() attempts to allocate at least one page based on
> the provided pages, and then opportunistically allocates more if that
> can be done without dropping the spinlock.
> 
> So if it returns fewer than requested, that could just mean that it
> needed to drop the lock.  In that case, try again immediately.
> 
> Only pause for a time if no progress could be made.
> 
> Reported-and-tested-by: Mike Javorski <mike.javorski@gmail.com>
> Reported-and-tested-by: Lothar Paltins <lopa@mailbox.org>
> Fixes: f6e70aab9dfe ("SUNRPC: refresh rq_pages using a bulk page allocator")
> Signed-off-by: NeilBrown <neilb@suse.de>

Acked-by: Mel Gorman <mgorman@suse.com>

-- 
Mel Gorman
SUSE Labs
