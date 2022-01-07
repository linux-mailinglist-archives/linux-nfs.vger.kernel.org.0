Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25198487EA8
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Jan 2022 22:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbiAGV5N (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 7 Jan 2022 16:57:13 -0500
Received: from mta-102b.oxsus-vadesecure.net ([51.81.61.67]:60569 "EHLO
        nmtao102.oxsus-vadesecure.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230296AbiAGV5M (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 7 Jan 2022 16:57:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; bh=uDHkBGi2pI3quvv3XixD4SR0CnJDLtEzAdnQHk
 Oqc5k=; c=relaxed/relaxed; d=earthlink.net; h=from:reply-to:subject:
 date:to:cc:resent-date:resent-from:resent-to:resent-cc:in-reply-to:
 references:list-id:list-help:list-unsubscribe:list-subscribe:list-post:
 list-owner:list-archive; q=dns/txt; s=dk12062016; t=1641592628;
 x=1642197428; b=VI3dkYU1NKT4+aS/iDUmZsJ4WGj/GN7VTT7GfrF2LBrH9hoYSip+gFG
 npfZQKYLBxdz3wZCi1HfNWj4otZ4r+ocgMwYH6GVJ11q3YHin/gBcnMjicQpf2+Aab00D+P
 uG5/+izhq4JJE9NH7QSmAUsg4n7jsS1197EUgoLazYgWxJsiV0RpdYmF9jJmlJSNbneFYdb
 YTuj5DlCu082VBZzr/bJbWu26B3edNYUmgynSErHnzzazCTl5l8rBjurj8QmeVOVaKP4sKP
 Yu/QSb1+fmM06iOiyEWVBvm87nYyxjL1ANaQ+H1c74GsC/pP1mQmtuVF4Tol/+FopzLHnzW
 hEw==
Received: from FRANKSTHINKPAD ([76.105.143.216])
 by smtp.oxsus-vadesecure.net ESMTP oxsus1nmtao02p with ngmta
 id fd3ad984-16c81bcc0e1f7fe2; Fri, 07 Jan 2022 21:57:07 +0000
From:   "Frank Filz" <ffilzlnx@mindspring.com>
To:     "'J. Bruce Fields'" <bfields@fieldses.org>,
        "'Chuck Lever'" <chuck.lever@oracle.com>
Cc:     <linux-nfs@vger.kernel.org>, <devel@lists.nfs-ganesha.org>
References: <20220107213443.GG26961@fieldses.org>
In-Reply-To: <20220107213443.GG26961@fieldses.org>
Subject: RE: NFS testing
Date:   Fri, 7 Jan 2022 13:57:07 -0800
Message-ID: <05f501d80411$8417b150$8c4713f0$@mindspring.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Content-Language: en-us
Thread-Index: AQLbG0GQyLQQEp3Ups1glh97Sv158KpR6U+w
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I'm embarrassed that I don't do anything close to this for my weekly
nfs-ganesha merges...

I'd love to see some tools to make it easier to do more testing.

I wish there was a solution that didn't require two hosts for testing NFSv3
locks against nfs-ganesha.

I need to get back to the pynfs v3 tests...

Another test I have run is pjdfstests, which there seem to be multiple
versions of, I have repos of two versions here that are Ganesha aware. These
tests include a lot of POSIX compliance so will catch permission issues and
other POSIX oddities. I also haven't run them in ages...

https://github.com/ffilz/ntfs-3g-pjd-fstest
https://github.com/ffilz/pjdfstest

The nfs-ganesha tree also has a tool to help write lock tests (and can be
used for a few other things too - I recently added more flags to open so it
can test most open system call invocations of interest) in:

https://github.com/nfs-ganesha/nfs-ganesha/tree/next/src/tools/multilock

Hmm, I should incorporate the features of Bruce's lock tests into that...

The multilock tool can drive multiple clients to use system calls (so any
POSIX client can be used including a local process on the server) or
Gluster's libgfapi or Cephs libcephfs.

Frank

> -----Original Message-----
> From: J. Bruce Fields [mailto:bfields@fieldses.org]
> Sent: Friday, January 7, 2022 1:35 PM
> To: Chuck Lever <chuck.lever@oracle.com>
> Cc: linux-nfs@vger.kernel.org
> Subject: NFS testing
> 
> Chuck was asking about the regular NFS testing I do.  Cc'ing the list in
case this is
> useful to anyone else.
> 
> We'd really like to set up regular testing on some kind of common
infrastructure
> that more people can get to.  I'm not sure how to get there yet.
> 
> For now all I have is this pile of bash scripts that build kernels and
boot test VMs
> and run tests between them, all on a machine in my
> basement:
> 
> 	http://git.linux-nfs.org/?p=bfields/testd.git;a=tree
> 
> The "install.sh" file has notes on my setup.
> 
> The thing I run most regularly is this:
> 
> 	http://git.linux-nfs.org/?p=bfields/testd.git;a=blob;f=bin/do-all
> 
> which runs:
> 
> 	- connectathon, on v3, v4, v4.1, and v4.2, each with both
> 	  auth_sys and krb5.  Except v4.2, which I run with auth_sys,
> 	  krb5i, and krb5p.
> 	- at the same time as connectathon (so with the same
> 	  permutations as the above), I also run the tests in
> 
> 		http://git.linux-nfs.org/?p=bfields/lock-tests.git
> 
> 	  which check basic lock and lease functionality plus some odd
> 	  corner cases I ran into some years ago.
> 	- pynfs 4.0 tests:
>
http://git.linux-nfs.org/?p=bfields/testd.git;a=blob;f=bin/do-
> pynfs
> 	  I do two auth_sys runs, one as root, one not.  (Tests that
> 	  create special files need root, tests that expect permission
> 	  failures need non-root).  A couple krb5 runs are temporarily
> 	  disabled.
> 
> 	  My goal is that a normal result should be "everything passed",
> 	  so that it stands out when there's a regression.  So I skip a
> 	  few known failures:
> 		http://git.linux-
> nfs.org/?p=bfields/testd.git;a=blob;f=data/pynfs-skip
> 	- pynfs 4.1 tests: similar if a little less complicated:
>
http://git.linux-nfs.org/?p=bfields/testd.git;a=blob;f=bin/do-
> pynfs41
> 	  4.1 tests to skip:
> 		http://git.linux-
> nfs.org/?p=bfields/testd.git;a=blob;f=data/pynfs41-skip
> 	- xfstests:
>
http://git.linux-nfs.org/?p=bfields/testd.git;a=blob;f=bin/do-
> xfstests
> 	  This is the most time-consuming, so I just do a single run
> 	  over NFSv4.2 with auth_sys.
> 
> 	  As with pynfs I aim for the normal result to be "everything
> 	  passed", so I skip these known failures:
> 		http://git.linux-
> nfs.org/?p=bfields/testd.git;a=blob;f=data/xfstests-failed
> 	  I also normally skip anything that takes more than a couple
> 	  minutes, unfortunately:
> 		http://git.linux-
> nfs.org/?p=bfields/testd.git;a=blob;f=data/xfstests-slow
> 
> I also have some other test sets in there that I don't use as often.
> And I "bisect" script that will run other tests, e.g.
> 
> 	qtst <host> bisect <good> <bad> xfstests generic/465
> 
> and it'll crank away for a few hours and (hopefully) mail me a git-bisect
result
> telling me where generic/465 started failing.
> 
> --b.

