Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0428226ABC8
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Sep 2020 20:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbgIOS0P (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 15 Sep 2020 14:26:15 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:24074 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727559AbgIOS0L (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 15 Sep 2020 14:26:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1600194371; x=1631730371;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject;
  bh=kJMkYQ5mUgUe6/LCH7hCqrkAXoDDE6Iuab8BgTClL6g=;
  b=NzoCSDd07Ywd8Nbor+MiFBTkZyu7JGqihbV8kg0IIoy03a43/nW9rhWu
   OLjhMh8e45hi8MtQCh6IJPGexASkNnrx+eVSg8o9R+/3MdBX06dhfPtFg
   EkyqsLnqE/LYzAJHYFcqTqF9UhNv1VT3qNR3loW+3nrFsZrG6hBu4zYyt
   o=;
X-IronPort-AV: E=Sophos;i="5.76,430,1592870400"; 
   d="scan'208";a="75174976"
Subject: Re: [PATCH 1/1] NFSv4.2: fix client's attribute cache management for
 copy_file_range
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1a-e34f1ddc.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 15 Sep 2020 18:19:45 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-1a-e34f1ddc.us-east-1.amazon.com (Postfix) with ESMTPS id A1D6DA1FF7;
        Tue, 15 Sep 2020 18:19:42 +0000 (UTC)
Received: from EX13D07UWA003.ant.amazon.com (10.43.160.35) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.58) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 15 Sep 2020 18:19:41 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX13D07UWA003.ant.amazon.com (10.43.160.35) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 15 Sep 2020 18:19:41 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.160.118) with Microsoft SMTP
 Server id 15.0.1497.2 via Frontend Transport; Tue, 15 Sep 2020 18:19:41 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id CB0E9C1400; Tue, 15 Sep 2020 18:19:41 +0000 (UTC)
Date:   Tue, 15 Sep 2020 18:19:41 +0000
From:   Frank van der Linden <fllinden@amazon.com>
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
CC:     <trond.myklebust@hammerspace.com>, <anna.schumaker@netapp.com>,
        <linux-nfs@vger.kernel.org>, <jencce.kernel@gmail.com>
Message-ID: <20200915181932.GA27779@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
References: <20200914202334.7536-1-olga.kornievskaia@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200914202334.7536-1-olga.kornievskaia@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Sep 14, 2020 at 04:23:34PM -0400, Olga Kornievskaia wrote:
> 
> 
> From: Olga Kornievskaia <kolga@netapp.com>
> 
> After client is done with the COPY operation, it needs to invalidate
> its pagecache (as it did no reading or writing of the data locally)
> and it needs to invalidate it's attributes just like it would have
> for a read on the source file and write on the destination file.
> 
> Once the linux server started giving out read delegations to
> read+write opens, the destination file of the copy_file range
> started having delegations and not doing syncup on close of the
> file leading to xfstest failures for generic/430,431,432,433,565.
> 
> Reported-by: Murphy Zhou <jencce.kernel@gmail.com>
> Fixes: 2e72448b07dc ("NFS: Add COPY nfs operation")
> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> ---
>  fs/nfs/nfs42proc.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
> index 142225f0af59..a9074f3366fa 100644
> --- a/fs/nfs/nfs42proc.c
> +++ b/fs/nfs/nfs42proc.c
> @@ -356,7 +356,11 @@ static ssize_t _nfs42_proc_copy(struct file *src,
> 
>         truncate_pagecache_range(dst_inode, pos_dst,
>                                  pos_dst + res->write_res.count);
> -
> +       NFS_I(dst_inode)->cache_validity |= (NFS_INO_REVAL_PAGECACHE |
> +                       NFS_INO_REVAL_FORCED | NFS_INO_INVALID_SIZE |
> +                       NFS_INO_INVALID_ATTR | NFS_INO_INVALID_DATA);
> +       NFS_I(src_inode)->cache_validity |= (NFS_INO_REVAL_PAGECACHE |
> +                       NFS_INO_REVAL_FORCED | NFS_INO_INVALID_ATIME);
>         status = res->write_res.count;
>  out:
>         if (args->sync)
> --
> 2.18.1

Should this be copied to stable@ ?

- Frank
