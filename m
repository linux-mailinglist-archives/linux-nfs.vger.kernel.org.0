Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CEC425232D
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Aug 2020 23:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgHYVx7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 25 Aug 2020 17:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbgHYVx6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 25 Aug 2020 17:53:58 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F5F4C061574
        for <linux-nfs@vger.kernel.org>; Tue, 25 Aug 2020 14:53:58 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id E25CC1C1C; Tue, 25 Aug 2020 17:53:57 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org E25CC1C1C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1598392437;
        bh=6/m1ekZwNNktxuyxQznC2V+6DQTEo3xOxcaNSpJG1h4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Iy8DqrvQSA5B0lfD7tHEn0DUGwrakwWpy3cugBgf4Dtyi6XqUKRWKm2nKQhmZnwwT
         9mPX1xxKZVjw8NYjdP483M+XHGe4KlB8t0jTc6Ps/6zPQJQkiAQEog6J96U3e23nP0
         M7z6R1LM2WNuj5QsBHYrVQlR4XFFfxvLyHWhEHaI=
Date:   Tue, 25 Aug 2020 17:53:57 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Murphy Zhou <jencce.kernel@gmail.com>
Cc:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
        "J. Bruce Fields" <bfields@redhat.com>,
        Olga Kornievskaia <olga.kornievskaia@gmail.com>
Subject: Re: 5.9 nfsd update breaks v4.2 copy_file_range
Message-ID: <20200825215357.GC1955@fieldses.org>
References: <20200821015036.bn3yqiiuvunfxb42@xzhoux.usersys.redhat.com>
 <20200825212647.GB1955@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825212647.GB1955@fieldses.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Aug 25, 2020 at 05:26:47PM -0400, J. Bruce Fields wrote:
> On Fri, Aug 21, 2020 at 09:50:36AM +0800, Murphy Zhou wrote:
> > It's easy to reproduce by running multiple xfstests testcases on localhost
> > NFS shares. These testcases are:
> >   generic/430 generic/431 generic/432 generic/433 generic/565
> > 
> > This reproduces only on NFSv4.2.
> > 
> > Error log diff sample:
> > 
> > --- /dev/fd/63	2020-08-09 22:46:02.771745606 -0400
> > +++ results/generic/431.out.bad	2020-08-09 22:46:02.546745248 -0400
> > @@ -1,15 +1,22 @@
> >  QA output created by 431
> >  Create the original file and then copy
> > +cmp: EOF on /mnt/testdir/test-431/copy which is empty
> >  Original md5sums:
> >  ab56b4d92b40713acc5af89985d4b786  TEST_DIR/test-431/file
> > -ab56b4d92b40713acc5af89985d4b786  TEST_DIR/test-431/copy
> > +d41d8cd98f00b204e9800998ecf8427e  TEST_DIR/test-431/copy
> 
> When I check the files server-side after reproducing, the file "copy"
> has the correct contents.  So I guess the problem is that the client
> cache is out of date.  The difference with commit 94415b06e is that the
> client holds read delegations on both source and destination, throughout
> the COPY operation.

Olga, do you know what the client's doing in this case?

It seems to me that it should be invalidating its cache of the
destination range after a COPY, regardless of whether it holds a
delegation on the destination.  (Either that or updating the cache of
the destination to hold the copied data, if it's confident its cache of
the source range is up to date.)

--b.

> 
> --b.
> 
> >  Small copies from various points in the original file
> > +cmp: EOF on /mnt/testdir/test-431/a which is empty
> > +cmp: EOF on /mnt/testdir/test-431/b which is empty
> > +cmp: EOF on /mnt/testdir/test-431/c which is empty
> > +cmp: EOF on /mnt/testdir/test-431/d which is empty
> > +cmp: EOF on /mnt/testdir/test-431/e which is empty
> > +cmp: EOF on /mnt/testdir/test-431/f which is empty
> >  md5sums after small copies
> >  ab56b4d92b40713acc5af89985d4b786  TEST_DIR/test-431/file
> > -0cc175b9c0f1b6a831c399e269772661  TEST_DIR/test-431/a
> > -92eb5ffee6ae2fec3ad71c777531578f  TEST_DIR/test-431/b
> > -4a8a08f09d37b73795649038408b5f33  TEST_DIR/test-431/c
> > -8277e0910d750195b448797616e091ad  TEST_DIR/test-431/d
> > -e1671797c52e15f763380b45e841ec32  TEST_DIR/test-431/e
> > -2015eb238d706eceefc784742928054f  TEST_DIR/test-431/f
> > +d41d8cd98f00b204e9800998ecf8427e  TEST_DIR/test-431/a
> > +d41d8cd98f00b204e9800998ecf8427e  TEST_DIR/test-431/b
> > +d41d8cd98f00b204e9800998ecf8427e  TEST_DIR/test-431/c
> > +d41d8cd98f00b204e9800998ecf8427e  TEST_DIR/test-431/d
> > +d41d8cd98f00b204e9800998ecf8427e  TEST_DIR/test-431/e
> > +d41d8cd98f00b204e9800998ecf8427e  TEST_DIR/test-431/f
> >  d41d8cd98f00b204e9800998ecf8427e  TEST_DIR/test-431/g
> > 
> > Bisecting shows the first "bad" commit is:
> > 
> > commit 94415b06eb8aed13481646026dc995f04a3a534a
> > Author: J. Bruce Fields <bfields@redhat.com>
> > Date:   Tue Jul 7 09:28:05 2020 -0400
> > 
> >     nfsd4: a client's own opens needn't prevent delegations
> > 
> > I'm wondering if you're already aware of it, this simple report is for
> > your info.
> > 
> > Thanks.
> > 
> > -- 
> > Murphy
