Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 826B9487E54
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Jan 2022 22:34:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbiAGVeo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 7 Jan 2022 16:34:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbiAGVeo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 7 Jan 2022 16:34:44 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 239D9C061574
        for <linux-nfs@vger.kernel.org>; Fri,  7 Jan 2022 13:34:44 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 607AD4C7F; Fri,  7 Jan 2022 16:34:43 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 607AD4C7F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1641591283;
        bh=lpYrhNcTXlsOJ+9sd0EpwwzEdmW3fi+1TNQsqAn4EEM=;
        h=Date:To:Cc:Subject:From:From;
        b=WN96+ifnWF2AgMZp8knvU0HrcT6y87K8+PccA33qq+LUnlb2bzQxOM6wc9SQmtkQi
         +OAC0LWEzxtfcOPXzc1nZ/ukh9eA7/SO7XQjoBl+FrDP3iRMgQYnPKrS38rbL0Zhiw
         n6vODf61GgLZabt7qGSLp29eV8c2rQ6t3C9IGWr0=
Date:   Fri, 7 Jan 2022 16:34:43 -0500
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Subject: NFS testing
Message-ID: <20220107213443.GG26961@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Chuck was asking about the regular NFS testing I do.  Cc'ing the list in
case this is useful to anyone else.

We'd really like to set up regular testing on some kind of common
infrastructure that more people can get to.  I'm not sure how to get
there yet.

For now all I have is this pile of bash scripts that build kernels and
boot test VMs and run tests between them, all on a machine in my
basement:

	http://git.linux-nfs.org/?p=bfields/testd.git;a=tree

The "install.sh" file has notes on my setup.

The thing I run most regularly is this:

	http://git.linux-nfs.org/?p=bfields/testd.git;a=blob;f=bin/do-all

which runs:

	- connectathon, on v3, v4, v4.1, and v4.2, each with both
	  auth_sys and krb5.  Except v4.2, which I run with auth_sys,
	  krb5i, and krb5p.
	- at the same time as connectathon (so with the same
	  permutations as the above), I also run the tests in

		http://git.linux-nfs.org/?p=bfields/lock-tests.git

	  which check basic lock and lease functionality plus some odd
	  corner cases I ran into some years ago.
	- pynfs 4.0 tests:
		http://git.linux-nfs.org/?p=bfields/testd.git;a=blob;f=bin/do-pynfs
	  I do two auth_sys runs, one as root, one not.  (Tests that
	  create special files need root, tests that expect permission
	  failures need non-root).  A couple krb5 runs are temporarily
	  disabled.

	  My goal is that a normal result should be "everything passed",
	  so that it stands out when there's a regression.  So I skip a
	  few known failures:
		http://git.linux-nfs.org/?p=bfields/testd.git;a=blob;f=data/pynfs-skip
	- pynfs 4.1 tests: similar if a little less complicated:
		http://git.linux-nfs.org/?p=bfields/testd.git;a=blob;f=bin/do-pynfs41
	  4.1 tests to skip:
		http://git.linux-nfs.org/?p=bfields/testd.git;a=blob;f=data/pynfs41-skip
	- xfstests:
		http://git.linux-nfs.org/?p=bfields/testd.git;a=blob;f=bin/do-xfstests
	  This is the most time-consuming, so I just do a single run
	  over NFSv4.2 with auth_sys.

	  As with pynfs I aim for the normal result to be "everything
	  passed", so I skip these known failures:
		http://git.linux-nfs.org/?p=bfields/testd.git;a=blob;f=data/xfstests-failed
	  I also normally skip anything that takes more than a couple
	  minutes, unfortunately:
		http://git.linux-nfs.org/?p=bfields/testd.git;a=blob;f=data/xfstests-slow

I also have some other test sets in there that I don't use as often.
And I "bisect" script that will run other tests, e.g.

	qtst <host> bisect <good> <bad> xfstests generic/465

and it'll crank away for a few hours and (hopefully) mail me a
git-bisect result telling me where generic/465 started failing.

--b.
