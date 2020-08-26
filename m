Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAF0F253430
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Aug 2020 17:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbgHZP7r (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 26 Aug 2020 11:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726783AbgHZP7p (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 26 Aug 2020 11:59:45 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF47C061574
        for <linux-nfs@vger.kernel.org>; Wed, 26 Aug 2020 08:59:33 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id d11so3528682ejt.13
        for <linux-nfs@vger.kernel.org>; Wed, 26 Aug 2020 08:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9/FLHFQnrN/NECm2CGcXbYzIxrsXLVKgEdJc4m+nzMU=;
        b=RQTVEdqV64gIMsMS/gu5eC4Cg9K6T4B+M2++baDy+v6FxX1Mst3PHnU2LU5cmiwG27
         BD/Y+JeD3m4fNAqZY3yXkmhD9Qegbd3re2WPnKiynFYwp809L6af4JcRy1rWln9FsbpT
         6da4bcLZ298qu01IHYId0bTuc2MXoUynIzhNhvudS1EJC3/IC7OIsQG8svrMZwYwhOqx
         WEWyL+vs/fDkvXDZj13iDdqI5u+XLFwVgoy0n4sEH+/jphAMvvXLZ4y1s5i27nYw7sJ1
         pg5DpWfqFKOmNCu/9ugW2a0HxtunMzpR7U+amg+HmoSbumSX9UfQwPmlOGbKVjuTI8hV
         s6Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9/FLHFQnrN/NECm2CGcXbYzIxrsXLVKgEdJc4m+nzMU=;
        b=U30QiYfcX7Fq36X7DP4pvSrjAnfb0pAhKEpqTK4t8mNMsri9dmluGU3vOPbKmMF2cK
         p2AIALJYWSG8H5Wjdjee2mdUIYXr7AWprPizMFBv91POeoeNmyTEHTqq7jz2Mw6kMBTY
         ua6Mz/oXhD36HeBFCb05sWv9jd4t52H57Xz2S81QR8h8qHcycAHon9J/XQnC5KIX/H2y
         Ys/2+fIroJgs6AmIV+4Rj+jFpxG/nMyAkinR5/7mEiGZWBtCOqqBmelD3iQPBba/9C91
         tdXqCSSJte7f9+pNzTZquYNE7ZlhtvTFJYZaW2D0Zw3/CLNdhKHRkHbnHIb8q9W2QPVl
         fjzw==
X-Gm-Message-State: AOAM5313lKQElrTuSTyhOVWeY6sN9ms0dTBix677zS4SZXLV/SDjZ9UI
        I3CUyU5D0sJhLe5xo4rN0guwveyqQP42KxQvATU=
X-Google-Smtp-Source: ABdhPJxqHNAC5fc9uJUBMstZrweuD8DQDzCeP3wrqAftBoG72uIOaTkW96EUQpAxftz9ApdEH9lkNdoD3Ych9NKCDg8=
X-Received: by 2002:a17:907:37b:: with SMTP id rs27mr9506847ejb.0.1598457571901;
 Wed, 26 Aug 2020 08:59:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200821015036.bn3yqiiuvunfxb42@xzhoux.usersys.redhat.com>
 <20200825212647.GB1955@fieldses.org> <20200825215357.GC1955@fieldses.org>
In-Reply-To: <20200825215357.GC1955@fieldses.org>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Wed, 26 Aug 2020 11:59:20 -0400
Message-ID: <CAN-5tyH7SdzHVtS2zk5Md7ShmmTneWt8jFgjqNb0Bhdm1o140w@mail.gmail.com>
Subject: Re: 5.9 nfsd update breaks v4.2 copy_file_range
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Murphy Zhou <jencce.kernel@gmail.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        "J. Bruce Fields" <bfields@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Aug 25, 2020 at 5:53 PM J. Bruce Fields <bfields@fieldses.org> wrote:
>
> On Tue, Aug 25, 2020 at 05:26:47PM -0400, J. Bruce Fields wrote:
> > On Fri, Aug 21, 2020 at 09:50:36AM +0800, Murphy Zhou wrote:
> > > It's easy to reproduce by running multiple xfstests testcases on localhost
> > > NFS shares. These testcases are:
> > >   generic/430 generic/431 generic/432 generic/433 generic/565
> > >
> > > This reproduces only on NFSv4.2.
> > >
> > > Error log diff sample:
> > >
> > > --- /dev/fd/63      2020-08-09 22:46:02.771745606 -0400
> > > +++ results/generic/431.out.bad     2020-08-09 22:46:02.546745248 -0400
> > > @@ -1,15 +1,22 @@
> > >  QA output created by 431
> > >  Create the original file and then copy
> > > +cmp: EOF on /mnt/testdir/test-431/copy which is empty
> > >  Original md5sums:
> > >  ab56b4d92b40713acc5af89985d4b786  TEST_DIR/test-431/file
> > > -ab56b4d92b40713acc5af89985d4b786  TEST_DIR/test-431/copy
> > > +d41d8cd98f00b204e9800998ecf8427e  TEST_DIR/test-431/copy
> >
> > When I check the files server-side after reproducing, the file "copy"
> > has the correct contents.  So I guess the problem is that the client
> > cache is out of date.  The difference with commit 94415b06e is that the
> > client holds read delegations on both source and destination, throughout
> > the COPY operation.
>
> Olga, do you know what the client's doing in this case?
>
> It seems to me that it should be invalidating its cache of the
> destination range after a COPY, regardless of whether it holds a
> delegation on the destination.  (Either that or updating the cache of
> the destination to hold the copied data, if it's confident its cache of
> the source range is up to date.)

It's on my todo list to reproduce this and see what's going on.

>
> --b.
>
> >
> > --b.
> >
> > >  Small copies from various points in the original file
> > > +cmp: EOF on /mnt/testdir/test-431/a which is empty
> > > +cmp: EOF on /mnt/testdir/test-431/b which is empty
> > > +cmp: EOF on /mnt/testdir/test-431/c which is empty
> > > +cmp: EOF on /mnt/testdir/test-431/d which is empty
> > > +cmp: EOF on /mnt/testdir/test-431/e which is empty
> > > +cmp: EOF on /mnt/testdir/test-431/f which is empty
> > >  md5sums after small copies
> > >  ab56b4d92b40713acc5af89985d4b786  TEST_DIR/test-431/file
> > > -0cc175b9c0f1b6a831c399e269772661  TEST_DIR/test-431/a
> > > -92eb5ffee6ae2fec3ad71c777531578f  TEST_DIR/test-431/b
> > > -4a8a08f09d37b73795649038408b5f33  TEST_DIR/test-431/c
> > > -8277e0910d750195b448797616e091ad  TEST_DIR/test-431/d
> > > -e1671797c52e15f763380b45e841ec32  TEST_DIR/test-431/e
> > > -2015eb238d706eceefc784742928054f  TEST_DIR/test-431/f
> > > +d41d8cd98f00b204e9800998ecf8427e  TEST_DIR/test-431/a
> > > +d41d8cd98f00b204e9800998ecf8427e  TEST_DIR/test-431/b
> > > +d41d8cd98f00b204e9800998ecf8427e  TEST_DIR/test-431/c
> > > +d41d8cd98f00b204e9800998ecf8427e  TEST_DIR/test-431/d
> > > +d41d8cd98f00b204e9800998ecf8427e  TEST_DIR/test-431/e
> > > +d41d8cd98f00b204e9800998ecf8427e  TEST_DIR/test-431/f
> > >  d41d8cd98f00b204e9800998ecf8427e  TEST_DIR/test-431/g
> > >
> > > Bisecting shows the first "bad" commit is:
> > >
> > > commit 94415b06eb8aed13481646026dc995f04a3a534a
> > > Author: J. Bruce Fields <bfields@redhat.com>
> > > Date:   Tue Jul 7 09:28:05 2020 -0400
> > >
> > >     nfsd4: a client's own opens needn't prevent delegations
> > >
> > > I'm wondering if you're already aware of it, this simple report is for
> > > your info.
> > >
> > > Thanks.
> > >
> > > --
> > > Murphy
