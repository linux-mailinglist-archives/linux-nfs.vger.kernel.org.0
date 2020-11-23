Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB93C2C1240
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Nov 2020 18:44:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729699AbgKWRm7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Nov 2020 12:42:59 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:29115 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729531AbgKWRm7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Nov 2020 12:42:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1606153379; x=1637689379;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject;
  bh=VUg6x+ANWjgsaSaTT6UTOCd37LoYILU1+WJ93vr5FwA=;
  b=sf+qqCExEkuWw4TqPIqnMXqUbHK3vhHdqbivTNH/OIc3WhsWJCrX6NG4
   qlao5MuMhviCxOmQ0b2MVxiJe46LSBNhb79utyYTP9ydiCzIFegzfKM1m
   fgRmbqVEVlajlHBZyMpUCcNfZwQiOG5659yvJNrq4BpwAsosgDRrFL5KI
   g=;
X-IronPort-AV: E=Sophos;i="5.78,364,1599523200"; 
   d="scan'208";a="98342870"
Subject: Re: [PATCH 1/1] NFSv4.2: fix LISTXATTR buffer receive size
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1d-74cf8b49.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 23 Nov 2020 17:38:07 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-1d-74cf8b49.us-east-1.amazon.com (Postfix) with ESMTPS id 32C16C07BF;
        Mon, 23 Nov 2020 17:38:04 +0000 (UTC)
Received: from EX13D25UEA002.ant.amazon.com (10.43.61.122) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 23 Nov 2020 17:38:04 +0000
Received: from EX13MTAUEA002.ant.amazon.com (10.43.61.77) by
 EX13D25UEA002.ant.amazon.com (10.43.61.122) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 23 Nov 2020 17:38:03 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.61.169) with Microsoft SMTP
 Server id 15.0.1497.2 via Frontend Transport; Mon, 23 Nov 2020 17:38:03 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 6FACAC142A; Mon, 23 Nov 2020 17:38:02 +0000 (UTC)
Date:   Mon, 23 Nov 2020 17:38:02 +0000
From:   Frank van der Linden <fllinden@amazon.com>
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
CC:     Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Message-ID: <20201123173802.GA26158@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
References: <20201113190851.7817-1-olga.kornievskaia@gmail.com>
 <99874775-A18C-4832-A2F0-F2152BE5CE32@oracle.com>
 <CAN-5tyEyQbmc-oefF+-PdtdcS7GJ9zmJk71Dk8EED0upcorqaA@mail.gmail.com>
 <07AF9A5C-BC42-4F66-A153-19A410D312E1@oracle.com>
 <CAN-5tyFpeVf0y67tJqvbqZmNMRzyvdj_33g9nJUNWW62Tx+thg@mail.gmail.com>
 <7E0CD3F3-84F2-4D08-8D5A-37AA0FA4852D@oracle.com>
 <20201119232647.GA11369@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
 <CAN-5tyH+ZCiqxKQEE9iGURP-71Xd2BqzHuWWPMzZURePKXirfQ@mail.gmail.com>
 <CAN-5tyEJ4Lbf=Ht2P4gwd9y4EPvN=G6teAiaunL=Ayxox8MSdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAN-5tyEJ4Lbf=Ht2P4gwd9y4EPvN=G6teAiaunL=Ayxox8MSdg@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Nov 23, 2020 at 11:42:46AM -0500, Olga Kornievskaia wrote:
> Hi Frank, Chuck,
> 
> I would like your option on how LISTXATTR is supposed to work over
> RDMA. Here's my current understanding of why the listxattr is not
> working over the RDMA.
> 
> This happens when the listxattr is called with a very small buffer
> size which RDMA wants to send an inline request. I really dont
> understand why, Chuck, you are not seeing any problems with hardware
> as far as I can tell it would have the same problem because the inline
> threshold size would still make this size inline.
> rcprdma_inline_fixup() is trying to write to pages that don't exist.
> 
> When LISTXATTR sets this flag XDRBUF_SPARSE_PAGES there is code that
> will allocate pages in xs_alloc_sparse_pages() but this is ONLY for
> TCP. RDMA doesn't have anything like that.
> 
> Question: Should there be code added to RDMA that will do something
> similar when it sees that flag set? Or, should LISTXATTR be re-written
> to be like READDIR which allocates pages before calling the code.

Hm.. so if the flag never worked for RDMA, was NFS_V3_ACL ever tested
over RDMA? That's the only other user.

If the flag simply doesn't work, I agree that it should either be fixed
or just removed.

It wouldn't be the end of the world to change LISTXATTRS (and GETXATTR)
to use preallocated pages. But, I didn't do that because I didn't want to
waste the max size (64k) every time, even though you usually just get
a few hundred bytes at most. So it seems like fixing XDRBUF_SPARSE_PAGES
is cleaner.

- Frank
