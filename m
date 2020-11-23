Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3A222C1476
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Nov 2020 20:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729982AbgKWTYq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Nov 2020 14:24:46 -0500
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:36034 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729420AbgKWTYp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Nov 2020 14:24:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1606159486; x=1637695486;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qprakT3d/KEOlMK4AKKkn5b9A9v4AWBvkvQi0H4fgP0=;
  b=KcezmVJ1T8FQMtswdNLr2y7O+gmxWx1eYIuDBa0hmk4yOCCnkQslmwBa
   6PEDdwYJGUpU6+KbJbSuywlVC6svxDmpB3BotuonCAmQlk4Fb8AGsMBVE
   f60b+pHiiSNtYqYVAFJtrjyoj2SGX1rakyv+ftTXLO/gwA3Jpy05JyNnG
   s=;
X-IronPort-AV: E=Sophos;i="5.78,364,1599523200"; 
   d="scan'208";a="65640694"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1a-16acd5e0.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 23 Nov 2020 19:24:39 +0000
Received: from EX13MTAUEB002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-1a-16acd5e0.us-east-1.amazon.com (Postfix) with ESMTPS id B3FFDA007F;
        Mon, 23 Nov 2020 19:24:36 +0000 (UTC)
Received: from EX13D13UEB001.ant.amazon.com (10.43.60.86) by
 EX13MTAUEB002.ant.amazon.com (10.43.60.12) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 23 Nov 2020 19:24:35 +0000
Received: from EX13MTAUEB002.ant.amazon.com (10.43.60.12) by
 EX13D13UEB001.ant.amazon.com (10.43.60.86) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 23 Nov 2020 19:24:35 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.60.234) with Microsoft SMTP
 Server id 15.0.1497.2 via Frontend Transport; Mon, 23 Nov 2020 19:24:35 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 64EE4C142A; Mon, 23 Nov 2020 19:24:34 +0000 (UTC)
Date:   Mon, 23 Nov 2020 19:24:34 +0000
From:   Frank van der Linden <fllinden@amazon.com>
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
CC:     Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [UNVERIFIED SENDER] Re: [PATCH 1/1] NFSv4.2: fix LISTXATTR
 buffer receive size
Message-ID: <20201123192434.GB28906@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
References: <20201113190851.7817-1-olga.kornievskaia@gmail.com>
 <99874775-A18C-4832-A2F0-F2152BE5CE32@oracle.com>
 <CAN-5tyEyQbmc-oefF+-PdtdcS7GJ9zmJk71Dk8EED0upcorqaA@mail.gmail.com>
 <07AF9A5C-BC42-4F66-A153-19A410D312E1@oracle.com>
 <CAN-5tyFpeVf0y67tJqvbqZmNMRzyvdj_33g9nJUNWW62Tx+thg@mail.gmail.com>
 <7E0CD3F3-84F2-4D08-8D5A-37AA0FA4852D@oracle.com>
 <20201119232647.GA11369@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
 <CAN-5tyH+ZCiqxKQEE9iGURP-71Xd2BqzHuWWPMzZURePKXirfQ@mail.gmail.com>
 <CAN-5tyEJ4Lbf=Ht2P4gwd9y4EPvN=G6teAiaunL=Ayxox8MSdg@mail.gmail.com>
 <20201123173802.GA26158@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201123173802.GA26158@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Nov 23, 2020 at 05:38:02PM +0000, Frank van der Linden wrote:
> It wouldn't be the end of the world to change LISTXATTRS (and GETXATTR)
> to use preallocated pages. But, I didn't do that because I didn't want to
> waste the max size (64k) every time, even though you usually just get
> a few hundred bytes at most. So it seems like fixing XDRBUF_SPARSE_PAGES
> is cleaner.

Correcting myself here.. this is true of GETXATTR, since there is no
maximum length argument for that call - so your only choice is to
allocate the max of what you can handle, and SPARSE seems to
be the best option fr that.

For LISTXATTRS, there is a max length argument. It's a bit unusual,
in that it specifies the maximum number of bytes of *XDR* data you
want to receive. So you don't need to allocate the maximum number
of pages.  But, I decided to still use the SPARSE option, since the
common 0 length argument to the listxattr syscall, used to probe
the length of the buffer needed, would still require the maximum
length (64k) to be allocated, because there is no 0 lengh 'probe'
option for the RPC. So all you can do is ask for the maximum
size you can handle, and see what you get back to determine
the length.

Olga's comment about caching: the code actually does cache
the data for all valid replies, even if the system call
only was a len == 0 probe call. That way, the followup
system call that actually retrieves the data can normally
just get it from the cache.

In any case, I need to set up an RDMA environment to see
if I can reproduce and fix the issue. I hope to do that
today or tomorrow.

- Frank
