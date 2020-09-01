Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF2BF259F15
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Sep 2020 21:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbgIATS4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 1 Sep 2020 15:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731576AbgIATS4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 1 Sep 2020 15:18:56 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA4BAC061244
        for <linux-nfs@vger.kernel.org>; Tue,  1 Sep 2020 12:18:55 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 42BFF5F98; Tue,  1 Sep 2020 15:18:54 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 42BFF5F98
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1598987934;
        bh=1/0q7fnxeeAC3t8KuZliK4V55iKTBSIt8BXbGxbVV6g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=frA9yW8fUW6LKsN7Jj1vkavkQ/jEnnqSexecRdZeeAfssWV/+muzAb0u5HLBwsEzH
         LcFJY0T4u48c91CqQIUDycXAzJhTBuXBYMDFyH3dGLgBpAV1G4GsvKGilglkDyflfx
         L9uZmCgnXmpVeU0M0B+b/BLfEvxjWzQRLlxR6lq8=
Date:   Tue, 1 Sep 2020 15:18:54 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Anna Schumaker <schumaker.anna@gmail.com>
Cc:     "J. Bruce Fields" <bfields@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v4 2/5] NFSD: Add READ_PLUS data support
Message-ID: <20200901191854.GD12082@fieldses.org>
References: <20200817165310.354092-1-Anna.Schumaker@Netapp.com>
 <20200817165310.354092-3-Anna.Schumaker@Netapp.com>
 <20200828212521.GA33226@pick.fieldses.org>
 <20200828215627.GB33226@pick.fieldses.org>
 <CAFX2Jfn3LN9Zc-=4mAm1mQ3k8PN6C1yF4xqh6B-yyXCxFnp7hQ@mail.gmail.com>
 <20200901164938.GC12082@fieldses.org>
 <CAFX2Jf=vmnfV_4=401=BFnmZJCOqfEWTQRPHzRHePpJrTCcb7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFX2Jf=vmnfV_4=401=BFnmZJCOqfEWTQRPHzRHePpJrTCcb7w@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Sep 01, 2020 at 01:40:16PM -0400, Anna Schumaker wrote:
> On Tue, Sep 1, 2020 at 12:49 PM J. Bruce Fields <bfields@fieldses.org> wrote:
> >
> > On Mon, Aug 31, 2020 at 02:16:26PM -0400, Anna Schumaker wrote:
> > > On Fri, Aug 28, 2020 at 5:56 PM J. Bruce Fields <bfields@redhat.com> wrote:
> > > > We really don't want to bother encoding small holes.  I doubt
> > > > filesystems want to bother with them either.  Do they give us any
> > > > guarantees as to the minimum size of a hole?
> > >
> > > The minimum size seems to be PAGE_SIZE from everything I've seen.
> >
> > OK, can we make that assumption explicit?  It'd simplify stuff like
> > this.
> 
> I'm okay with that, but it's technically up to the underlying filesystem.

Maybe we should ask on linux-fsdevel.

Maybe minimum hole length isn't the right question: suppose at time 1 a
file has a single hole at bytes 100-200, then it's modified so at time 2
it has a hole at bytes 50-150.  If you lseek(fd, 0, SEEK_HOLE) at time
1, you'll get 100.  Then if you lseek(fd, 100, SEEK_DATA) at time 2,
you'll get 150.  So you'll encode a 50-byte hole in the READ_PLUS reply
even though the file never had a hole smaller than 100 bytes.

Minimum hole alignment might be the right idea.

If we can't get that: maybe just teach encode_read to stop when it
*either* returns maxcount worth of file data (and holes) *or* maxcount
of encoded xdr data, just to prevent a weird filesystem from triggering
a bug.

--b.
