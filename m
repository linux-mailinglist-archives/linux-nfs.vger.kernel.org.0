Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC302C9536
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Dec 2020 03:31:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbgLACaG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Nov 2020 21:30:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28259 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725955AbgLACaF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 30 Nov 2020 21:30:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606789719;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=89GqSZbfHRJr8cAZtPlLIGEITP12D7+maoZw7tCdDrA=;
        b=Qc3LHaD8NvgPNL8EJjm89fI54i7XQ8/nQz2SJLACE8EjP+rk1hfcMTdeklniJ/ThrzmP/2
        h0R55c2VwI7FyTEUecdAU8qFaN6HEDN4DM5Y0oQZhTugNwtD1/4lwCcTp2nqY2egCA15Bn
        /eIirNCzKSccvgM7clspREa58wIuNX4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-McKqAs6cOjGtWG91mOYFiQ-1; Mon, 30 Nov 2020 21:28:37 -0500
X-MC-Unique: McKqAs6cOjGtWG91mOYFiQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B45E5809DC9;
        Tue,  1 Dec 2020 02:28:35 +0000 (UTC)
Received: from pick.fieldses.org (ovpn-115-208.rdu2.redhat.com [10.10.115.208])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7636613470;
        Tue,  1 Dec 2020 02:28:35 +0000 (UTC)
Received: by pick.fieldses.org (Postfix, from userid 2815)
        id 54A131205D0; Mon, 30 Nov 2020 21:28:34 -0500 (EST)
Date:   Mon, 30 Nov 2020 21:28:34 -0500
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: [PATCH 1/6] nfsd: add a new EXPORT_OP_NOWCC flag to struct
 export_operations
Message-ID: <20201201022834.GA241188@pick.fieldses.org>
References: <20201130212455.254469-1-trondmy@kernel.org>
 <20201130212455.254469-2-trondmy@kernel.org>
 <20201130225842.GA22446@fieldses.org>
 <1b525278a9a7541529290588a83852a0754cee3e.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1b525278a9a7541529290588a83852a0754cee3e.camel@hammerspace.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Dec 01, 2020 at 12:45:16AM +0000, Trond Myklebust wrote:
> On Mon, 2020-11-30 at 17:58 -0500, J. Bruce Fields wrote:
> > This is great, thanks:
> > 
> > On Mon, Nov 30, 2020 at 04:24:50PM -0500, trondmy@kernel.org wrote:
> > > From: Jeff Layton <jeff.layton@primarydata.com>
> > > 
> > > With NFSv3 nfsd will always attempt to send along WCC data to the
> > > client. This generally involves saving off the in-core inode
> > > information
> > > prior to doing the operation on the given filehandle, and then
> > > issuing a
> > > vfs_getattr to it after the op.
> > > 
> > > Some filesystems (particularly clustered or networked ones) have an
> > > expensive ->getattr inode operation. Atomicitiy is also often
> > > difficult
> > > or impossible to guarantee on such filesystems. For those, we're
> > > best
> > > off not trying to provide WCC information to the client at all, and
> > > to
> > > simply allow it to poll for that information as needed with a
> > > GETATTR
> > > RPC.
> > > 
> > > This patch adds a new flags field to struct export_operations, and
> > > defines a new EXPORT_OP_NOWCC flag that filesystems can use to
> > > indicate
> > > that nfsd should not attempt to provide WCC info in NFSv3 replies.
> > > It
> > > also adds a blurb about the new flags field and flag to the
> > > exporting
> > > documentation.
> > 
> > In the v4 case I think it should also turn off the "atomic" flag in
> > the
> > change_info4 structure that's returned by some operations.
> > 
> 
> To answer this comment (which I missed earlier): I don't know that we
> can turn off WCC for NFSv4. The GETATTR is a completely separate
> operation, so the server would have to second-guess what the client
> needs it for in order to optimise it away.

In the v4 case, we're setting the "atomic" field in the change_info4
struct to true even though the returned changeattrs clearly aren't
atomic with the operation in the re-export case.

That atomic field is initialized from fh_post_saved, so we just need to
set it to false in the v4 case as we are in the v3 case already.

Yes, it's true, that doesn't allow any optimizations because we still
have to get the post-op change attributes.

But it's a bug we may as well fix while we're here, and it probably
simplifies this patch if anything....

--b.

> 
> That is why this patch is labelled as being an optimisation for NFSv3
> only in the comments above.
> 
> -- 
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
> 
> 

