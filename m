Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 550BD258302
	for <lists+linux-nfs@lfdr.de>; Mon, 31 Aug 2020 22:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728775AbgHaUwe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 31 Aug 2020 16:52:34 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:2504 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbgHaUwe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 31 Aug 2020 16:52:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1598907154; x=1630443154;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject;
  bh=aIhVjjwKkMcLbxVwt3UFwtPyh08ZpwGOgBIRLZ7MnfY=;
  b=BorrMmHGkBKVMdhh5CrmnqIjvYCDpzkvahu3zdr63NQUY4L0dPiLWnPz
   llHNu0DshxZY6DL7kgiaScghERR3o8DlbT0HrRZ49MxfiFRvpa7C1LbKX
   SkNBbwSlxPj8Y7s06E0irTYsS8ABddM1FLGFscIuvvEAbgUKq/1SmVAhR
   4=;
X-IronPort-AV: E=Sophos;i="5.76,376,1592870400"; 
   d="scan'208";a="64319940"
Subject: Re: [bfields@home.fieldses.org: all 6970bc51 SUNRPC/NFSD: Implement
 xdr_reserve_space_vec() results]
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1d-74cf8b49.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 31 Aug 2020 20:52:08 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1d-74cf8b49.us-east-1.amazon.com (Postfix) with ESMTPS id 0E233C19A4;
        Mon, 31 Aug 2020 20:52:06 +0000 (UTC)
Received: from EX13D06UWA001.ant.amazon.com (10.43.160.220) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.58) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 31 Aug 2020 20:52:06 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX13D06UWA001.ant.amazon.com (10.43.160.220) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 31 Aug 2020 20:52:05 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.160.118) with Microsoft SMTP
 Server id 15.0.1497.2 via Frontend Transport; Mon, 31 Aug 2020 20:52:06 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 38625C1366; Mon, 31 Aug 2020 20:52:06 +0000 (UTC)
Date:   Mon, 31 Aug 2020 20:52:06 +0000
From:   Frank van der Linden <fllinden@amazon.com>
To:     "J. Bruce Fields" <bfields@fieldses.org>
CC:     <linux-nfs@vger.kernel.org>
Message-ID: <20200831205206.GA18488@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
References: <20200831190218.GA19571@fieldses.org>
 <20200831193109.GA9497@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
 <20200831204027.GB19571@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200831204027.GB19571@fieldses.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Aug 31, 2020 at 04:40:27PM -0400, J. Bruce Fields wrote:
> 
> On Mon, Aug 31, 2020 at 07:31:09PM +0000, Frank van der Linden wrote:
> > On Mon, Aug 31, 2020 at 03:02:18PM -0400, J. Bruce Fields wrote:
> > >
> > > I'm getting a few xfstests failures, are they known?  Apologies if
> > > they've already been discussed.
> > >
> > > --b.
> > >
> > > generic/020     - output mismatch (see /root/xfstests-dev/results//generic/020.out.bad)
> > >     --- tests/generic/020.out   2019-12-20 17:34:10.433343742 -0500
> > >     +++ /root/xfstests-dev/results//generic/020.out.bad 2020-08-29 13:03:29.270527451 -0400
> > >     @@ -40,7 +40,8 @@
> > >
> > >      *** add lots of attributes
> > >      *** check
> > >     -   *** MAX_ATTRS attribute(s)
> > >     +getfattr: /mnt/attribute_36648: Argument list too long
> > >     +   *** -1 attribute(s)
> > >      *** remove lots of attributes
> > >     ...
> > >     (Run 'diff -u /root/xfstests-dev/tests/generic/020.out /root/xfstests-dev/results//generic/020.out.bad'  to see the entire diff)
> > >
> > > generic/097     - output mismatch (see /root/xfstests-dev/results//generic/097.out.bad)
> > >     --- tests/generic/097.out   2019-12-20 17:34:10.453343686 -0500
> > >     +++ /root/xfstests-dev/results//generic/097.out.bad 2020-08-29 13:07:00.070382348 -0400
> > >     @@ -5,18 +5,16 @@
> > >      *** Test out the trusted namespace ***
> > >
> > >      set EA <trusted:colour,marone>:
> > >     +setfattr: TEST_DIR/foo: Operation not supported
> > >
> > >      set EA <user:colour,beige>:
> > >
> > >     ...
> > >     (Run 'diff -u /root/xfstests-dev/tests/generic/097.out /root/xfstests-dev/results//generic/097.out.bad'  to see the entire diff)
> >
> > Yeah, they are known.
> 
> Thanks for the explanation.  And I see now you had a more exhaustive
> list of xfstest results here:
> 
>         https://lore.kernel.org/linux-nfs/20200317230339.GA3130@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com/
> 
> For some reason I didn't manage to find that before.
> 
> --b.

Yep - I think I've fixed the issues in xfstests I listed there. I just
need to re-run the tests, and not just for NFS. I'll do runs for xfs, ext4
and NFS. If everything looks ok, I'll send the changes in, they're pretty
simple.

- Frank
