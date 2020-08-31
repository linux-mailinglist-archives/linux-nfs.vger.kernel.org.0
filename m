Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1BB92582E7
	for <lists+linux-nfs@lfdr.de>; Mon, 31 Aug 2020 22:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728957AbgHaUk3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 31 Aug 2020 16:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbgHaUk2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 31 Aug 2020 16:40:28 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CB4FC061573
        for <linux-nfs@vger.kernel.org>; Mon, 31 Aug 2020 13:40:28 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 78F226EF3; Mon, 31 Aug 2020 16:40:27 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 78F226EF3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1598906427;
        bh=dZ+oyj3pA/Zxf3Lugmr9xSstH4oPo+ldtgiHw5o/LoE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LE6qm3aGTY+HYgIlHxGbUYTp8ns1EPg6sS0btTesH+VuEQrdbr4nDt+sDWkYK0dpm
         ru1050v/UsiY35877jpyeis8NduGPuCD3geltStuLWBY4c2PLW/rqwgDD53coZaFjF
         zvtdzNkoLe+Fd9XwJNrLp4lsQ4lva4tNAciSrRRw=
Date:   Mon, 31 Aug 2020 16:40:27 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Frank van der Linden <fllinden@amazon.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [bfields@home.fieldses.org: all 6970bc51 SUNRPC/NFSD: Implement
 xdr_reserve_space_vec() results]
Message-ID: <20200831204027.GB19571@fieldses.org>
References: <20200831190218.GA19571@fieldses.org>
 <20200831193109.GA9497@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200831193109.GA9497@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Aug 31, 2020 at 07:31:09PM +0000, Frank van der Linden wrote:
> On Mon, Aug 31, 2020 at 03:02:18PM -0400, J. Bruce Fields wrote:
> > 
> > I'm getting a few xfstests failures, are they known?  Apologies if
> > they've already been discussed.
> > 
> > --b.
> > 
> > generic/020     - output mismatch (see /root/xfstests-dev/results//generic/020.out.bad)
> >     --- tests/generic/020.out   2019-12-20 17:34:10.433343742 -0500
> >     +++ /root/xfstests-dev/results//generic/020.out.bad 2020-08-29 13:03:29.270527451 -0400
> >     @@ -40,7 +40,8 @@
> > 
> >      *** add lots of attributes
> >      *** check
> >     -   *** MAX_ATTRS attribute(s)
> >     +getfattr: /mnt/attribute_36648: Argument list too long
> >     +   *** -1 attribute(s)
> >      *** remove lots of attributes
> >     ...
> >     (Run 'diff -u /root/xfstests-dev/tests/generic/020.out /root/xfstests-dev/results//generic/020.out.bad'  to see the entire diff)
> > 
> > generic/097     - output mismatch (see /root/xfstests-dev/results//generic/097.out.bad)
> >     --- tests/generic/097.out   2019-12-20 17:34:10.453343686 -0500
> >     +++ /root/xfstests-dev/results//generic/097.out.bad 2020-08-29 13:07:00.070382348 -0400
> >     @@ -5,18 +5,16 @@
> >      *** Test out the trusted namespace ***
> > 
> >      set EA <trusted:colour,marone>:
> >     +setfattr: TEST_DIR/foo: Operation not supported
> > 
> >      set EA <user:colour,beige>:
> > 
> >     ...
> >     (Run 'diff -u /root/xfstests-dev/tests/generic/097.out /root/xfstests-dev/results//generic/097.out.bad'  to see the entire diff)
>
> Yeah, they are known.

Thanks for the explanation.  And I see now you had a more exhaustive
list of xfstest results here:

	https://lore.kernel.org/linux-nfs/20200317230339.GA3130@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com/

For some reason I didn't manage to find that before.

--b.

> 
> Problem 1, as seen in generic/097: xfstests assumes that xattr support is
> all-or-nothing, and can't deal with NFS supporting the "user" namespace,
> but not the "trusted" namespace, which it will never support.
> 
> Problem 2, as seen in generic/020: MAX_ATTRS is set to the wrong default
> value (too large), which means that the test will trigger a generic Linux
> xattr bug: you can set more xattrs than you can list. E.g. if you set enough
> xattrs to have a total name size > XATTR_LIST_MAX. But then listxattrs can't
> list them anymore. flistxattr(fd, NULL, 0) (a probe listxattr) will then
> return E2BIG. This issue has been around forever in the xattr code.
> 
> I have some changes to xfstests to fix the tests, but I need to rebase
> and re-test them.
> 
> - Frank
