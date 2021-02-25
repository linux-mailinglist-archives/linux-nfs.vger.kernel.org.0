Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9F3D324F3C
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Feb 2021 12:31:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235330AbhBYLai (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 25 Feb 2021 06:30:38 -0500
Received: from outbound-smtp57.blacknight.com ([46.22.136.241]:42131 "EHLO
        outbound-smtp57.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235197AbhBYL3u (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 25 Feb 2021 06:29:50 -0500
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp57.blacknight.com (Postfix) with ESMTPS id 50873FA94E
        for <linux-nfs@vger.kernel.org>; Thu, 25 Feb 2021 11:28:51 +0000 (GMT)
Received: (qmail 7064 invoked from network); 25 Feb 2021 11:28:51 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 25 Feb 2021 11:28:50 -0000
Date:   Thu, 25 Feb 2021 11:28:49 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     linux-mm@kvack.org, chuck.lever@oracle.com, netdev@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net-next 3/3] mm: make zone->free_area[order] access
 faster
Message-ID: <20210225112849.GM3697@techsingularity.net>
References: <161419296941.2718959.12575257358107256094.stgit@firesoul>
 <161419301128.2718959.4838557038019199822.stgit@firesoul>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <161419301128.2718959.4838557038019199822.stgit@firesoul>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

As a side-node, I didn't pick up the other patches as there is review
feedback and I didn't have strong opinions either way. Patch 3 is curious
though, it probably should be split out and sent separetly but still;

On Wed, Feb 24, 2021 at 07:56:51PM +0100, Jesper Dangaard Brouer wrote:
> Avoid multiplication (imul) operations when accessing:
>  zone->free_area[order].nr_free
> 
> This was really tricky to find. I was puzzled why perf reported that
> rmqueue_bulk was using 44% of the time in an imul operation:
> 
>        ???     del_page_from_free_list():
>  44,54 ??? e2:   imul   $0x58,%rax,%rax
> 
> This operation was generated (by compiler) because the struct free_area have
> size 88 bytes or 0x58 hex. The compiler cannot find a shift operation to use
> and instead choose to use a more expensive imul, to find the offset into the
> array free_area[].
> 
> The patch align struct free_area to a cache-line, which cause the
> compiler avoid the imul operation. The imul operation is very fast on
> modern Intel CPUs. To help fast-path that decrement 'nr_free' move the
> member 'nr_free' to be first element, which saves one 'add' operation.
> 
> Looking up instruction latency this exchange a 3-cycle imul with a
> 1-cycle shl, saving 2-cycles. It does trade some space to do this.
> 
> Used: gcc (GCC) 9.3.1 20200408 (Red Hat 9.3.1-2)
> 

I'm having some trouble parsing this and matching it to the patch itself.

First off, on my system (x86-64), the size of struct free area is 72,
not 88 bytes. For either size, cache-aligning the structure is a big
increase in the struct size.

struct free_area {
        struct list_head           free_list[4];         /*     0    64 */
        /* --- cacheline 1 boundary (64 bytes) --- */
        long unsigned int          nr_free;              /*    64     8 */

        /* size: 72, cachelines: 2, members: 2 */
        /* last cacheline: 8 bytes */
};

Are there other patches in the tree? What does pahole say?

With gcc-9, I'm also not seeing the imul instruction outputted like you
described in rmqueue_pcplist which inlines rmqueue_bulk. At the point
where it calls get_page_from_free_area, it's using shl for the page list
operation. This might be a compiler glitch but given that free_area is a
different size, I'm less certain and wonder if something else is going on.

Finally, moving nr_free to the end and cache aligning it will make the
started of each free_list cache-aligned because of its location in the
struct zone so what purpose does __pad_to_align_free_list serve?

-- 
Mel Gorman
SUSE Labs
