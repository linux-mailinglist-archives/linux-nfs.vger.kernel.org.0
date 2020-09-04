Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCEC325DEBB
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Sep 2020 17:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbgIDP4N (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 4 Sep 2020 11:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727801AbgIDP4K (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 4 Sep 2020 11:56:10 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B924EC061244
        for <linux-nfs@vger.kernel.org>; Fri,  4 Sep 2020 08:56:09 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id A28CE2403; Fri,  4 Sep 2020 11:56:08 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org A28CE2403
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1599234968;
        bh=KsjAyd+xfK7a0mx4bX6URfo3cL4U50aCO/beFcK2O0M=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=TzLfIvzy9MbTUuwbcj4RU0YYfZyEZMB+WMyjZXnyH990fWHjqmfAa3ptYDE2f0eju
         N3jdLG/snY9zgGK2Mt++G8Te7SFzeIHqAjTtFIGExxTLCoq5bmtSmIK4l8k41/1Uh4
         3ffGlg+0zrcm4eKSsxzw/qdLm+hEkClsdZVtMDrU=
Date:   Fri, 4 Sep 2020 11:56:08 -0400
To:     Anna Schumaker <schumaker.anna@gmail.com>
Cc:     "J. Bruce Fields" <bfields@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v4 0/5] NFSD: Add support for the v4.2 READ_PLUS operation
Message-ID: <20200904155608.GA2158@fieldses.org>
References: <20200817165310.354092-1-Anna.Schumaker@Netapp.com>
 <20200826215437.GD62682@pick.fieldses.org>
 <CAFX2JfnEhgr4_CP4rJVsm37+Zo2uFs+zePAENtmPWx-Fmm-HfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFX2JfnEhgr4_CP4rJVsm37+Zo2uFs+zePAENtmPWx-Fmm-HfA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Aug 31, 2020 at 02:33:30PM -0400, Anna Schumaker wrote:
> On Wed, Aug 26, 2020 at 5:54 PM J. Bruce Fields <bfields@redhat.com> wrote:
> > On Mon, Aug 17, 2020 at 12:53:05PM -0400, schumaker.anna@gmail.com wrote:
> > > I tested by reading various 2G files from a few different underlying
> > > filesystems and across several NFS versions. I used the `vmtouch` utility
> > > to make sure files were only cached when we wanted them to be. In addition
> > > to 100% data and 100% hole cases, I also tested with files that alternate
> > > between data and hole segments. These files have either 4K, 8K, 16K, or 32K
> > > segment sizes and start with either data or hole segments. So the file
> > > mixed-4d has a 4K segment size beginning with a data segment, but mixed-32h
> > > has 32K segments beginning with a hole. The units are in seconds, with the
> > > first number for each NFS version being the uncached read time and the second
> > > number is for when the file is cached on the server.
> >
> > The only numbers that look really strange are in the btrfs uncached
> > case, in the data-only case and the mixed case that start with a hole.
> > Do we have any idea what's up there?
> 
> I'm not really sure. BTRFS does some work to make sure the page cache
> is synced up with their internal extent representation as part of
> llseek, so my guess is something related to that (But it's been a
> while since I looked into that code, so I'm not sure if that's still
> how it works)

Adding linux-btrfs in case they have any updates--are btrfs developers
aware of known performances issues with SEEK_HOLE/SEEK_DATA, and is it
something anyone's working on?

Anna's implementing a read optimization where the server uses seek to
identify holes to save transmitting all those zeroes back to the client,
and it's working as expected for ext4 and xfs but performing weirdly for
btrfs.

Original message:
	https://lore.kernel.org/linux-nfs/20200817165310.354092-1-Anna.Schumaker@Netapp.com/

--b.


> > > Read Plus Results (btrfs):
> > >   data
> > >    :... v4.1 ... Uncached ... 21.317 s, 101 MB/s, 0.63 s kern, 2% cpu
> > >    :    :....... Cached ..... 18.252 s, 118 MB/s, 0.67 s kern, 3% cpu
> > >    :... v4.2 ... Uncached ... 28.665 s,  75 MB/s, 0.65 s kern, 2% cpu
> > >         :....... Cached ..... 18.253 s, 118 MB/s, 0.66 s kern, 3% cpu
> > >   hole
> > >    :... v4.1 ... Uncached ... 18.256 s, 118 MB/s, 0.70 s kern,  3% cpu
> > >    :    :....... Cached ..... 18.254 s, 118 MB/s, 0.73 s kern,  4% cpu
> > >    :... v4.2 ... Uncached ...  0.851 s, 2.5 GB/s, 0.72 s kern, 84% cpu
> > >         :....... Cached .....  0.847 s, 2.5 GB/s, 0.73 s kern, 86% cpu
> > >   mixed-4d
> > >    :... v4.1 ... Uncached ... 56.857 s,  38 MB/s, 0.76 s kern, 1% cpu
> > >    :    :....... Cached ..... 18.252 s, 118 MB/s, 0.72 s kern, 3% cpu
> > >    :... v4.2 ... Uncached ... 54.455 s,  39 MB/s, 0.73 s kern, 1% cpu
> > >         :....... Cached .....  9.215 s, 233 MB/s, 0.68 s kern, 7% cpu
> > >   mixed-8d
> > >    :... v4.1 ... Uncached ... 36.641 s,  59 MB/s, 0.68 s kern, 1% cpu
> > >    :    :....... Cached ..... 18.252 s, 118 MB/s, 0.70 s kern, 3% cpu
> > >    :... v4.2 ... Uncached ... 33.205 s,  65 MB/s, 0.67 s kern, 2% cpu
> > >         :....... Cached .....  9.172 s, 234 MB/s, 0.65 s kern, 7% cpu
> > >   mixed-16d
> > >    :... v4.1 ... Uncached ... 28.653 s,  75 MB/s, 0.72 s kern, 2% cpu
> > >    :    :....... Cached ..... 18.252 s, 118 MB/s, 0.70 s kern, 3% cpu
> > >    :... v4.2 ... Uncached ... 25.748 s,  83 MB/s, 0.71 s kern, 2% cpu
> > >         :....... Cached .....  9.150 s, 235 MB/s, 0.64 s kern, 7% cpu
> > >   mixed-32d
> > >    :... v4.1 ... Uncached ... 28.886 s,  74 MB/s, 0.67 s kern, 2% cpu
> > >    :    :....... Cached ..... 18.252 s, 118 MB/s, 0.71 s kern, 3% cpu
> > >    :... v4.2 ... Uncached ... 24.724 s,  87 MB/s, 0.74 s kern, 2% cpu
> > >         :....... Cached .....  9.140 s, 235 MB/s, 0.63 s kern, 6% cpu
> > >   mixed-4h
> > >    :... v4.1 ... Uncached ...  52.181 s,  41 MB/s, 0.73 s kern, 1% cpu
> > >    :    :....... Cached .....  18.252 s, 118 MB/s, 0.66 s kern, 3% cpu
> > >    :... v4.2 ... Uncached ... 150.341 s,  14 MB/s, 0.72 s kern, 0% cpu
> > >         :....... Cached .....   9.216 s, 233 MB/s, 0.63 s kern, 6% cpu
> > >   mixed-8h
> > >    :... v4.1 ... Uncached ... 36.945 s,  58 MB/s, 0.68 s kern, 1% cpu
> > >    :    :....... Cached ..... 18.252 s, 118 MB/s, 0.65 s kern, 3% cpu
> > >    :... v4.2 ... Uncached ... 79.781 s,  27 MB/s, 0.68 s kern, 0% cpu
> > >         :....... Cached .....  9.172 s, 234 MB/s, 0.66 s kern, 7% cpu
> > >   mixed-16h
> > >    :... v4.1 ... Uncached ... 28.651 s,  75 MB/s, 0.73 s kern, 2% cpu
> > >    :    :....... Cached ..... 18.252 s, 118 MB/s, 0.66 s kern, 3% cpu
> > >    :... v4.2 ... Uncached ... 47.428 s,  45 MB/s, 0.71 s kern, 1% cpu
> > >         :....... Cached .....  9.150 s, 235 MB/s, 0.67 s kern, 7% cpu
> > >   mixed-32h
> > >    :... v4.1 ... Uncached ... 28.618 s,  75 MB/s, 0.69 s kern, 2% cpu
> > >    :    :....... Cached ..... 18.252 s, 118 MB/s, 0.70 s kern, 3% cpu
> > >    :... v4.2 ... Uncached ... 38.813 s,  55 MB/s, 0.67 s kern, 1% cpu
> > >         :....... Cached .....  9.140 s, 235 MB/s, 0.61 s kern, 6% cpu
> >
