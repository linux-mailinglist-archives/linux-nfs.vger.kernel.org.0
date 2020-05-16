Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0A4B1D60B4
	for <lists+linux-nfs@lfdr.de>; Sat, 16 May 2020 14:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbgEPMKb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 16 May 2020 08:10:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:50164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726206AbgEPMKb (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 16 May 2020 08:10:31 -0400
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3CDF020657;
        Sat, 16 May 2020 12:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589631030;
        bh=04AbjCXytLCX9HGH+nxYI/rMKrxzV75ANLTUs/yDM/U=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=SMTPQgb5Hvr3EbSz8749/ImgGuqyITyV1BhWKkpIsG4uZvS3A8v4N4yBOg2pUraBL
         1hgcVaRxrBMQYG0UP2evthJttAR0wLXuH+VM4zJiTFU+ORtBk0A7FzFIHVT2ZxNYiw
         WMKg2+5Mt3WfubCC5gI9laL/Q1s/JC3gYvsbGOt8=
Message-ID: <61e877867de7e683d88e2cc5d0945b0aecce1d2a.camel@kernel.org>
Subject: Re: [PATCH] ceph: don't return -ESTALE if there's still an open file
From:   Jeff Layton <jlayton@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Luis Henriques <lhenriques@suse.com>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        fstests <fstests@vger.kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "J. Bruce Fields" <bfields@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Sat, 16 May 2020 08:10:27 -0400
In-Reply-To: <CAOQ4uxhPzcX6Ti8UX4WOg9gJJn+YTuk9OgU80d9imoJ2QdXaWQ@mail.gmail.com>
References: <20200514111453.GA99187@suse.com>
         <8497fe9a11ac1837813ee5f14b6ebae8fa6bf707.camel@kernel.org>
         <20200514124845.GA12559@suse.com>
         <4e5bf0e3bf055e53a342b19d168f6cf441781973.camel@kernel.org>
         <CAOQ4uxhireZBRvcPQzTS8yOoO4gQt78M0ktZo-9yQ-zcaLZbow@mail.gmail.com>
         <20200515111548.GA54598@suse.com>
         <61b1f19edcc349641b5383c2ac70cbf9a15ba4bd.camel@kernel.org>
         <CAOQ4uxiWZoSj3Pjwskd_hu-ErV9096hLt13CDcW6nEEvcwDNVA@mail.gmail.com>
         <e227d42fdc91587e34bc64ac252970d39d9b4eee.camel@kernel.org>
         <CAOQ4uxhPzcX6Ti8UX4WOg9gJJn+YTuk9OgU80d9imoJ2QdXaWQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2 (3.36.2-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, 2020-05-16 at 09:58 +0300, Amir Goldstein wrote:
> [pulling in nfs guys]
> 
> > > Questions:
> > > 1. Does sync() result in fully purging inodes on MDS?
> > 
> > I don't think so, but again, that code is not trivial to follow. I do
> > know that the MDS keeps around a "strays directory" which contains
> > unlinked inodes that are lazily cleaned up. My suspicion is that it's
> > satisfying lookups out of this cache as well.
> > 
> > Which may be fine...the MDS is not required to be POSIX compliant after
> > all. Only the fs drivers are.
> > 
> > > 2. Is i_nlink synchronized among nodes on deferred delete?
> > > IWO, can inode come back from the dead on client if another node
> > > has linked it before i_nlink 0 was observed?
> > 
> > No, that shouldn't happen. The caps mechanism should ensure that it
> > can't be observed by other clients until after the change.
> > 
> > That said, Luis' current patch doesn't ensure we have the correct caps
> > to check the i_nlink. We may need to add that in before we can roll with
> > this.
> > 
> > > 3. Can an NFS client be "migrated" from one ceph node to another
> > > with an open but unlinked file?
> > > 
> > 
> > No. Open files in ceph are generally per-client. You can't pass around a
> > fd (or equivalent).
> 
> Not sure we are talking about the same thing.
> It's not ceph fd that is being passed around, it's the NFS client's fd.
> If there is no case where NFS client would access ceph client2
> with a handle it got from ceph client1, then there is no reason to satisfy
> an open_by_handle() call for an unlinked file on client2.
> If file was opened on client1, it may be "legal" to satisfy open_by_handle()
> on client2, but I don't see how stopping to satisfy that can break anything.
> 

Not currently, but eventually we may need to allow for that...which is
another good reason to handle this on the (Ceph) client instead, as the
client can then decide whether treat an unlinked file as an ESTALE
return based on its needs.

> > > I think what the test is trying to verify is that a "fully purged" inodes
> > > cannot be opened db handle, but there is no standard way to verify
> > > "fully purged", so the test resorts to sync() + another sync() + drop_caches.
> > > 
> > 
> > Got it. That makes sense.
> > 
> > > Is there anything else that needs to be done on ceph in order to flush
> > > all deferred operations from this client to MDS?
> > 
> > I'm leaning toward something like what Luis has proposed, but adding in
> > appropriate cap handling.
> 
> That sounds fine.
> 
> > Basically, we have to consider the situation where one client has the
> > file open and another client unlinks it, and then does an
> > open_by_handle_at. Should it succeed in that case?
> > 
> > I can see arguments for either way.
> 
> IMO, the behavior should be defined for a client that has the file open.
> For the rest it does not really matter.
> 
> My argument is that is it easy to satisfy the test's expectation and conform
> to behavior of other filesystems without breaking any real workload.
> 
> To satisfy the test's expectation, you only need to change behavior of ceph
> client in i_count 1 use case. If i_count is 1 need to take all relevant caps
> to check that i_nlink is "globally" 0, before returning ESTALE.
> But if i_count > 1, no need to bother.

Makes sense. Thanks.

-- 
Jeff Layton <jlayton@kernel.org>

