Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2FC418D88
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Sep 2021 03:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232429AbhI0Bmu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 26 Sep 2021 21:42:50 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:20616 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232400AbhI0Bmt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 26 Sep 2021 21:42:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1632706872; x=1664242872;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xJ0TLHwb9tSGKFai8gOTtlCcwirLmQjZkSZn+OmDpkI=;
  b=j0BYjf5Ulk8E3mvqPz2nJjLb44kDMpdtH9VujN1fjll4P4q9x70Wq4QV
   f9BO34L024UP7lDPGaWE4f9Ah934jarjAGe+ifimAOIRNXfVvfsRzUhuw
   zWOZDM3q0mdivrU63+PY2N16j12jimppqEhpNJXVwUkfLEBJ1cyNdsXa+
   KFEeKCslN0PV8jrxcyRTDjykfNf+lSZW17vBwLiXtdf9BRr0ZT2zOty+v
   2bAM4oQpLrSUthxt21OnenU5xWRhYvffVDKkiQXO9Rr/z4J/WD37B49Nt
   xPdNE00ALDlvVpW9jI5oGGnx0k3d+z5MWmr2wL3ac92dvwqGeg5bMT0bk
   g==;
X-IronPort-AV: E=Sophos;i="5.85,325,1624291200"; 
   d="scan'208";a="180083663"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 27 Sep 2021 09:41:11 +0800
IronPort-SDR: 5Jfqv9qYeTz0DEvIMjYP9A+FhMKd9pjpiWIyRbBYx9X3LlB0d1WdYC8rSrNyi73i+4iTzcAzHz
 z9ekdEvBIdx/6XS1VIFk64eJxRbFrdoyZetRB7MT8hJXKBoM9HiqkI6XLkX7oLqbIMDGuegRuA
 xp+b5ggQ1IYdAv3CY3lTL7b89EXTtYkEuXjUtJ6McjIIV+xgUdV4q+BvObrJTJRFMk/3shiCoD
 wHJtzFHTLKaHkz1ArD9AY4C8UgrwD8U/cCCOsKp8CiRkx+J419G6/F8aQT4/TLvTsegYPgARk1
 fmbProhGv24w52dOI718/CqW
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2021 18:15:44 -0700
IronPort-SDR: 2u5Kd+5CA/V+rqpVf6hVfdVbC2nxUyGClnluDquovWzV1Hu+kRoGya1LT5uON1thcana3zHSN5
 /ePjDWo+lr81mu9kp8hfiXQSRIH9rQG06rTLE8K7H1Msko/9hORWGqyTUOehBwi9OG8zCtBKwX
 P1tlzZJET4vRgX9Kb4G+dIi346Lmp5FDkf4e7q/E2uNOWn67r+K94ltUtqSgG4ZDaKoN2N/3+j
 xkl1chK+q/NsWpeCoCo/szDSNKRunk+PunM1zPvIg2aCqXyyBsWcVwrM6qggmyeF0+wxO0QPjC
 Ov4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2021 18:41:11 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4HHlj224R2z1Rvlf
        for <linux-nfs@vger.kernel.org>; Sun, 26 Sep 2021 18:41:10 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1632706869; x=1635298870; bh=xJ0TLHwb9tSGKFai8gOTtlCcwirLmQjZkSZ
        n+OmDpkI=; b=HN3oMIlc4PuWgWFdu4EY/XuVN0W8MKCvMIm7xDne77yHlFKv2Rz
        6IZ2P0nYmvVYAcdt0dA/M2RUDjkC5PheQOH4SGJaVKtoWyATP35gmtiyylPJ9bgt
        yE+GnEiKKNrU3L/xW3temhUlOJFv/d5GBdO1McLsUFAXOZI5os7no8VPJ1+whrSz
        tO5sZyzNHDzZHcxKyL/f5rA/c2imN/HzjV1ep3/qqbyix2apLOeA0ZeBzmu7iF3w
        97W18UizbSD2qtiiDiBkDdM4f7hBsMrjSPlnEcwlS6CqN72Nw0dXVeUoNPuJ8ePY
        3thuGvs1qdVy7pWAwHtLX4nP18HxjrjRKoQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id NFl3VnVGBiWA for <linux-nfs@vger.kernel.org>;
        Sun, 26 Sep 2021 18:41:09 -0700 (PDT)
Received: from [10.89.85.1] (c02drav6md6t.dhcp.fujisawa.hgst.com [10.89.85.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4HHlhy0bYrz1RvTg;
        Sun, 26 Sep 2021 18:41:05 -0700 (PDT)
Message-ID: <2f933d26-541c-06eb-e5d3-336c05f31f1d@opensource.wdc.com>
Date:   Mon, 27 Sep 2021 10:41:04 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.1.1
Subject: Re: [PATCH v3 9/9] mm: Remove swap BIO paths and only use DIO paths
Content-Language: en-US
To:     Dave Chinner <david@fromorbit.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>, hch@lst.de,
        trond.myklebust@primarydata.com, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, darrick.wong@oracle.com,
        viro@zeniv.linux.org.uk, jlayton@kernel.org,
        torvalds@linux-foundation.org, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <YU84rYOyyXDP3wjp@casper.infradead.org>
 <163250387273.2330363.13240781819520072222.stgit@warthog.procyon.org.uk>
 <163250396319.2330363.10564506508011638258.stgit@warthog.procyon.org.uk>
 <2396106.1632584202@warthog.procyon.org.uk>
 <YU9X2o74+aZP4iWV@casper.infradead.org>
 <5fde9167-6f8b-c698-f34d-d7fafd4219f7@opensource.wdc.com>
 <20210927012527.GF1756565@dread.disaster.area>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <20210927012527.GF1756565@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 2021/09/27 10:25, Dave Chinner wrote:
> On Mon, Sep 27, 2021 at 08:08:53AM +0900, Damien Le Moal wrote:
>> On 2021/09/26 2:09, Matthew Wilcox wrote:
>>> On Sat, Sep 25, 2021 at 04:36:42PM +0100, David Howells wrote:
>>>> Matthew Wilcox <willy@infradead.org> wrote:
>>>>
>>>>> On Fri, Sep 24, 2021 at 06:19:23PM +0100, David Howells wrote:
>>>>>> Delete the BIO-generating swap read/write paths and always use ->swap_rw().
>>>>>> This puts the mapping layer in the filesystem.
>>>>>
>>>>> Is SWP_FS_OPS now unused after this patch?
>>>>
>>>> Ummm.  Interesting question - it's only used in swap_set_page_dirty():
>>>>
>>>> int swap_set_page_dirty(struct page *page)
>>>> {
>>>> 	struct swap_info_struct *sis = page_swap_info(page);
>>>>
>>>> 	if (data_race(sis->flags & SWP_FS_OPS)) {
>>>> 		struct address_space *mapping = sis->swap_file->f_mapping;
>>>>
>>>> 		VM_BUG_ON_PAGE(!PageSwapCache(page), page);
>>>> 		return mapping->a_ops->set_page_dirty(page);
>>>> 	} else {
>>>> 		return __set_page_dirty_no_writeback(page);
>>>> 	}
>>>> }
>>>
>>> I suspect that's no longer necessary.  NFS was the only filesystem
>>> using SWP_FS_OPS and ...
>>>
>>> fs/nfs/file.c:  .set_page_dirty = __set_page_dirty_nobuffers,
>>>
>>> so it's not like NFS does anything special to reserve memory to write
>>> back swap pages.
>>>
>>>>> Also, do we still need ->swap_activate and ->swap_deactivate?
>>>>
>>>> f2fs does quite a lot of work in its ->swap_activate(), as does btrfs.  I'm
>>>> not sure how necessary it is.  cifs looks like it intends to use it, but it's
>>>> not fully implemented yet.  zonefs and nfs do some checking, including hole
>>>> checking in nfs's case.  nfs also does some setting up for the sunrpc
>>>> transport.
>>>>
>>>> btrfs, cifs, f2fs and nfs all supply ->swap_deactivate() to undo the effects
>>>> of the activation.
>>>
>>> Right ... so my question really is, now that we're doing I/O through
>>> aops->direct_IO (or ->swap_rw), do those magic things need to be done?
>>> After all, open(O_DIRECT) doesn't do these same magic things.  They're
>>> really there to allow the direct-to-BIO path to work, and you're removing
>>> that here.
>>
>> For zonefs, ->swap_activate() checks that the user is not trying to use a
>> sequential write only file for swap. Swap cannot work on these files as there
>> are no guarantees that the writes will be sequential.
> 
> iomap_swapfile_activate() is used by ext4, XFS and zonefs. It checks
> there are no holes in the file, no shared extents, no inline
> extents, the swap info block device matches the block device the
> extent is mapped to (i.e. filesystems can have more than one bdev,
> swapfile only supports files on sb->s_bdev), etc.

OK. But I was referring to the additional check in zonefs_swap_activate() before
iomap_swapfile_activate() is called. We must prevent that function from being
called for a full sequential write only zone file since such file will pass all
checks (no hole, all extents written etc) but cannot be used for swap since it
is not writtable when full (no overwrites allowed in sequential zones).

> 
> Also, I noticed, iomap_swapfile_add_extent() filters out extents
> that are smaller than PAGE_SIZE, and aligns larger extents to
> PAGE_SIZE. This allows ensures that when fs block size != PAGE_SIZE
> that only a single IO per page being swapped is required. i.e. the
> DIO path may change the "one page, one bio, one IO" behaviour that
> the current swapfile mapping guarantees.
> 
> Cheers,
> 
> Dave.
> 


-- 
Damien Le Moal
Western Digital Research
