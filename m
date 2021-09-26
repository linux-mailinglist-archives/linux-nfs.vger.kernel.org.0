Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89319418D00
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Sep 2021 01:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232078AbhIZXKh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 26 Sep 2021 19:10:37 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:2900 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232089AbhIZXKg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 26 Sep 2021 19:10:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1632697738; x=1664233738;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TDOTPmawcYz4rmiMAIYJQQx5dPP35Ldh0mdFUTfrChI=;
  b=pKAwwubOACDga88BVy5Cihwv8pCk3nxNi7ovxxin+oK5NMopggY7eJvq
   Dh4xWrSXmK7GpNWKNWhSBJt4j2Qv7kSwAsMJXakMOMYE7kPBK6iaSW0+N
   TY9u8zzpcbbHMBhtt6CVWccLda5DcOlC8jKIZovjm+WBDeFLIX7LkjVKR
   ZrhZcbKv0weH5heImDa0Ghh4WUhTprO7ybBtZq5JcY4OLKez5CVrwRC2r
   +xwMf+67QjYvzc+x1XiwWXII7oEDSbYxz2/ZkniADKS8Kcmx8aGwUU9MO
   uJXMLSLWatqaqCPUE6/lovsNqYSdbNi9VNmCBpy3KWdZ7BZ689CHjMN+1
   w==;
X-IronPort-AV: E=Sophos;i="5.85,325,1624291200"; 
   d="scan'208";a="181015789"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Sep 2021 07:08:57 +0800
IronPort-SDR: Ofd3jVc+5Y/QQNeVlrevGR6B8xlIweozP+2W+xSRltOZQM7KC+lHY34bLhrlKi0iBTQpKCbh0A
 aLBpHYGdAefdknQ1VOOTs/SFCWmn1Gc91+La/buvROqt6HvQqoKlKtV61dQGa/+JL3O4+wn62i
 fL4CNdam1Yca8hSOQe2+ZvSiaPaR8SqP0HKe5MtInSV0fC+s4wKL3cbSem5/B3BPwCzEQaQa7O
 57+j6YPP0XUTthAai3fOLsBh/SvlmO7SyDu8pmUIBK9EjVvYmvCcJcbXtwFKTplJh9XC25+Bvv
 bmLvJ4z323hYNGDG3yAjWB7p
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2021 15:45:06 -0700
IronPort-SDR: cKkY98heNQawLBDv1UlE8GmIZkvgJY2UwIST/+01OhJSAphKFqxWQg8KtPmU9mSbQjIEPB/amK
 GQX6SVOhXYsVMLy/9a6j3tE0nRZG6lqRPJY9CU3cwXgnWwI/OuzIMVw9mnJoNoIakx5VVKFMHO
 jB1QglkWliv9xZNkqaQ3sWq/AVPYifSb0lOp95CcMZd8svEICjD4JRzP1ZOYafBImfHm3bBjJf
 vWpkp0W/kARhld0580emkMQHWkpsyeX/hj9XYs2RKlfZAUFEOfmLTBk+0oU2jtXQ742ozwXfcR
 nbA=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2021 16:08:59 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4HHhKQ409Cz1RvlM
        for <linux-nfs@vger.kernel.org>; Sun, 26 Sep 2021 16:08:58 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1632697737; x=1635289738; bh=TDOTPmawcYz4rmiMAIYJQQx5dPP35Ldh0md
        FUTfrChI=; b=TmqmtvnUWB/0fOST0cEzXPQ5EjlnNrPpSxR+bjf6UJqZZo55P3D
        FIoK8AI8+hr11KKXdI9k4f+fj7jXDyP+GSOexgk0xQ5mvJef7ZgJvnuC6IfeSIxu
        68YNCNVQ/KNmrGCLycrn5vhJmh7iefjax+lFC53KM9o6w0POibu9PNHkEiXeA9GO
        gl732LcWzZi0+Eh76bIZJ07k9YXnl8VYPQcR6VMWAdskcbLH7wUyZXqpzFX9nOqn
        Q1Syji8+Zfe5lPXeAqSxX7a3Uzh6sEh0tLn4ixpeKfBTVQFKr4wfz9w2ASbpPiGH
        D7WlSzZ0SuLjRdJmxdhMRyEoDIkt+zeXcPA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id V7daijV7cLGm for <linux-nfs@vger.kernel.org>;
        Sun, 26 Sep 2021 16:08:57 -0700 (PDT)
Received: from [10.89.85.1] (c02drav6md6t.dhcp.fujisawa.hgst.com [10.89.85.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4HHhKL6dDzz1RvTg;
        Sun, 26 Sep 2021 16:08:54 -0700 (PDT)
Message-ID: <5fde9167-6f8b-c698-f34d-d7fafd4219f7@opensource.wdc.com>
Date:   Mon, 27 Sep 2021 08:08:53 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.1.1
Subject: Re: [PATCH v3 9/9] mm: Remove swap BIO paths and only use DIO paths
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>
Cc:     hch@lst.de, trond.myklebust@primarydata.com,
        Jens Axboe <axboe@kernel.dk>,
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
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <YU9X2o74+aZP4iWV@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 2021/09/26 2:09, Matthew Wilcox wrote:
> On Sat, Sep 25, 2021 at 04:36:42PM +0100, David Howells wrote:
>> Matthew Wilcox <willy@infradead.org> wrote:
>>
>>> On Fri, Sep 24, 2021 at 06:19:23PM +0100, David Howells wrote:
>>>> Delete the BIO-generating swap read/write paths and always use ->swap_rw().
>>>> This puts the mapping layer in the filesystem.
>>>
>>> Is SWP_FS_OPS now unused after this patch?
>>
>> Ummm.  Interesting question - it's only used in swap_set_page_dirty():
>>
>> int swap_set_page_dirty(struct page *page)
>> {
>> 	struct swap_info_struct *sis = page_swap_info(page);
>>
>> 	if (data_race(sis->flags & SWP_FS_OPS)) {
>> 		struct address_space *mapping = sis->swap_file->f_mapping;
>>
>> 		VM_BUG_ON_PAGE(!PageSwapCache(page), page);
>> 		return mapping->a_ops->set_page_dirty(page);
>> 	} else {
>> 		return __set_page_dirty_no_writeback(page);
>> 	}
>> }
> 
> I suspect that's no longer necessary.  NFS was the only filesystem
> using SWP_FS_OPS and ...
> 
> fs/nfs/file.c:  .set_page_dirty = __set_page_dirty_nobuffers,
> 
> so it's not like NFS does anything special to reserve memory to write
> back swap pages.
> 
>>> Also, do we still need ->swap_activate and ->swap_deactivate?
>>
>> f2fs does quite a lot of work in its ->swap_activate(), as does btrfs.  I'm
>> not sure how necessary it is.  cifs looks like it intends to use it, but it's
>> not fully implemented yet.  zonefs and nfs do some checking, including hole
>> checking in nfs's case.  nfs also does some setting up for the sunrpc
>> transport.
>>
>> btrfs, cifs, f2fs and nfs all supply ->swap_deactivate() to undo the effects
>> of the activation.
> 
> Right ... so my question really is, now that we're doing I/O through
> aops->direct_IO (or ->swap_rw), do those magic things need to be done?
> After all, open(O_DIRECT) doesn't do these same magic things.  They're
> really there to allow the direct-to-BIO path to work, and you're removing
> that here.

For zonefs, ->swap_activate() checks that the user is not trying to use a
sequential write only file for swap. Swap cannot work on these files as there
are no guarantees that the writes will be sequential.

-- 
Damien Le Moal
Western Digital Research
