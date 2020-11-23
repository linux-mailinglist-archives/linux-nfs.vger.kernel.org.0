Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9FC72C1304
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Nov 2020 19:33:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbgKWSUb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Nov 2020 13:20:31 -0500
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:21313 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbgKWSUb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Nov 2020 13:20:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1606155631; x=1637691631;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject;
  bh=tmTiTXrCK5kngU4fKT/ph5yRIVioVaCz6C/0bbMxlH0=;
  b=C5son/vGChySrPwnlc5Rv2iSdNahzu/6wBlBKepy/jWkUSzCno6wq0rN
   uA/PDWvWpzmx4K7W8WlPQfIOeiAxucpTfPGFeY5a78dEGRnswfTsPNw9G
   ACTmfgPuKKHTvEh7mCIL0bInojNNRlra8ftY7mrMh7GSKU4lf3gZk9WKO
   U=;
X-IronPort-AV: E=Sophos;i="5.78,364,1599523200"; 
   d="scan'208";a="65359094"
Subject: Re: [PATCH 1/1] NFSv4.2: fix LISTXATTR buffer receive size
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-474bcd9f.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 23 Nov 2020 18:20:24 +0000
Received: from EX13MTAUEE002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-1d-474bcd9f.us-east-1.amazon.com (Postfix) with ESMTPS id 5BBCCA1243;
        Mon, 23 Nov 2020 18:20:22 +0000 (UTC)
Received: from EX13D20UEE001.ant.amazon.com (10.43.62.84) by
 EX13MTAUEE002.ant.amazon.com (10.43.62.24) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 23 Nov 2020 18:20:21 +0000
Received: from EX13MTAUEE002.ant.amazon.com (10.43.62.24) by
 EX13D20UEE001.ant.amazon.com (10.43.62.84) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 23 Nov 2020 18:20:21 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.62.224) with Microsoft SMTP
 Server id 15.0.1497.2 via Frontend Transport; Mon, 23 Nov 2020 18:20:21 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 36E71C142A; Mon, 23 Nov 2020 18:20:20 +0000 (UTC)
Date:   Mon, 23 Nov 2020 18:20:20 +0000
From:   Frank van der Linden <fllinden@amazon.com>
To:     Chuck Lever <chuck.lever@oracle.com>
CC:     Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Message-ID: <20201123182020.GA28906@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
References: <20201113190851.7817-1-olga.kornievskaia@gmail.com>
 <99874775-A18C-4832-A2F0-F2152BE5CE32@oracle.com>
 <CAN-5tyEyQbmc-oefF+-PdtdcS7GJ9zmJk71Dk8EED0upcorqaA@mail.gmail.com>
 <07AF9A5C-BC42-4F66-A153-19A410D312E1@oracle.com>
 <CAN-5tyFpeVf0y67tJqvbqZmNMRzyvdj_33g9nJUNWW62Tx+thg@mail.gmail.com>
 <7E0CD3F3-84F2-4D08-8D5A-37AA0FA4852D@oracle.com>
 <20201119232647.GA11369@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
 <CAN-5tyH+ZCiqxKQEE9iGURP-71Xd2BqzHuWWPMzZURePKXirfQ@mail.gmail.com>
 <CAN-5tyEJ4Lbf=Ht2P4gwd9y4EPvN=G6teAiaunL=Ayxox8MSdg@mail.gmail.com>
 <4687FA42-6294-418D-9835-EDE809997AE3@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4687FA42-6294-418D-9835-EDE809997AE3@oracle.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Nov 23, 2020 at 12:37:15PM -0500, Chuck Lever wrote:
> 
> 
> > On Nov 23, 2020, at 11:42 AM, Olga Kornievskaia <olga.kornievskaia@gmail.com> wrote:
> >
> > Hi Frank, Chuck,
> >
> > I would like your option on how LISTXATTR is supposed to work over
> > RDMA. Here's my current understanding of why the listxattr is not
> > working over the RDMA.
> >
> > This happens when the listxattr is called with a very small buffer
> > size which RDMA wants to send an inline request. I really dont
> > understand why, Chuck, you are not seeing any problems with hardware
> > as far as I can tell it would have the same problem because the inline
> > threshold size would still make this size inline.
> > rcprdma_inline_fixup() is trying to write to pages that don't exist.
> >
> > When LISTXATTR sets this flag XDRBUF_SPARSE_PAGES there is code that
> > will allocate pages in xs_alloc_sparse_pages() but this is ONLY for
> > TCP. RDMA doesn't have anything like that.
> >
> > Question: Should there be code added to RDMA that will do something
> > similar when it sees that flag set?
> 
> Isn't the logic in rpcrdma_convert_iovs() allocating those pages?
> 
> 
> > Or, should LISTXATTR be re-written
> > to be like READDIR which allocates pages before calling the code.
> 
> AIUI READDIR reads into the directory inode's page cache. I recall
> that Frank couldn't do that for LISTXATTR because there's no
> similar page cache associated with the xattr listing.

Yep, correct.

> 
> That said, I would prefer that the *XATTR procedures directly
> allocate pages instead of relying on SPARSE_PAGES, which is a hack
> IMO. I think it would have to use alloc_page() for that, and then
> ensure those pages are released when the call has completed.
> 
> I'm not convinced this is the cause of the problem you're seeing,
> though.

Since the flag works with GETXATTR I would agree that it's probably
not the issue.

More likely, it seems like args->count is somehow off.

- Frank
