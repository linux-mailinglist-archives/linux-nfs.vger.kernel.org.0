Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3EC82581C8
	for <lists+linux-nfs@lfdr.de>; Mon, 31 Aug 2020 21:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729092AbgHaTbN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 31 Aug 2020 15:31:13 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:7718 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgHaTbN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 31 Aug 2020 15:31:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1598902272; x=1630438272;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject;
  bh=MNdkHh1nedSv0s9RpAKF7GNS+IdCwzO0mZxL79/3Nbs=;
  b=nhIidwXELfs0/zeVKEejgQC2Se7mrtgHOCLa2ekZCFupXMxQciYce7j5
   akFcJ8/Coutc2ZHJODuDT2ScuLB0J0VV7v543zVoN3J1T2CvRk4uiWEw1
   mLtbULdAwciHD8PREwqZtHUDORvmDl4/KK1n0pkzCCSw5nXGvYRNAme9h
   c=;
X-IronPort-AV: E=Sophos;i="5.76,376,1592870400"; 
   d="scan'208";a="51085556"
Subject: Re: [bfields@home.fieldses.org: all 6970bc51 SUNRPC/NFSD: Implement
 xdr_reserve_space_vec() results]
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2a-22cc717f.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 31 Aug 2020 19:31:11 +0000
Received: from EX13MTAUWA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2a-22cc717f.us-west-2.amazon.com (Postfix) with ESMTPS id C8F48A1FD3;
        Mon, 31 Aug 2020 19:31:09 +0000 (UTC)
Received: from EX13D27UWA004.ant.amazon.com (10.43.160.43) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 31 Aug 2020 19:31:08 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX13D27UWA004.ant.amazon.com (10.43.160.43) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 31 Aug 2020 19:31:09 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.160.118) with Microsoft SMTP
 Server id 15.0.1497.2 via Frontend Transport; Mon, 31 Aug 2020 19:31:08 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 32237C1366; Mon, 31 Aug 2020 19:31:09 +0000 (UTC)
Date:   Mon, 31 Aug 2020 19:31:09 +0000
From:   Frank van der Linden <fllinden@amazon.com>
To:     "J. Bruce Fields" <bfields@fieldses.org>
CC:     <linux-nfs@vger.kernel.org>
Message-ID: <20200831193109.GA9497@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
References: <20200831190218.GA19571@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200831190218.GA19571@fieldses.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Aug 31, 2020 at 03:02:18PM -0400, J. Bruce Fields wrote:
> 
> I'm getting a few xfstests failures, are they known?  Apologies if
> they've already been discussed.
> 
> --b.
> 
> generic/020     - output mismatch (see /root/xfstests-dev/results//generic/020.out.bad)
>     --- tests/generic/020.out   2019-12-20 17:34:10.433343742 -0500
>     +++ /root/xfstests-dev/results//generic/020.out.bad 2020-08-29 13:03:29.270527451 -0400
>     @@ -40,7 +40,8 @@
> 
>      *** add lots of attributes
>      *** check
>     -   *** MAX_ATTRS attribute(s)
>     +getfattr: /mnt/attribute_36648: Argument list too long
>     +   *** -1 attribute(s)
>      *** remove lots of attributes
>     ...
>     (Run 'diff -u /root/xfstests-dev/tests/generic/020.out /root/xfstests-dev/results//generic/020.out.bad'  to see the entire diff)
> 
> generic/097     - output mismatch (see /root/xfstests-dev/results//generic/097.out.bad)
>     --- tests/generic/097.out   2019-12-20 17:34:10.453343686 -0500
>     +++ /root/xfstests-dev/results//generic/097.out.bad 2020-08-29 13:07:00.070382348 -0400
>     @@ -5,18 +5,16 @@
>      *** Test out the trusted namespace ***
> 
>      set EA <trusted:colour,marone>:
>     +setfattr: TEST_DIR/foo: Operation not supported
> 
>      set EA <user:colour,beige>:
> 
>     ...
>     (Run 'diff -u /root/xfstests-dev/tests/generic/097.out /root/xfstests-dev/results//generic/097.out.bad'  to see the entire diff)

Yeah, they are known.

Problem 1, as seen in generic/097: xfstests assumes that xattr support is
all-or-nothing, and can't deal with NFS supporting the "user" namespace,
but not the "trusted" namespace, which it will never support.

Problem 2, as seen in generic/020: MAX_ATTRS is set to the wrong default
value (too large), which means that the test will trigger a generic Linux
xattr bug: you can set more xattrs than you can list. E.g. if you set enough
xattrs to have a total name size > XATTR_LIST_MAX. But then listxattrs can't
list them anymore. flistxattr(fd, NULL, 0) (a probe listxattr) will then
return E2BIG. This issue has been around forever in the xattr code.

I have some changes to xfstests to fix the tests, but I need to rebase
and re-test them.

- Frank
