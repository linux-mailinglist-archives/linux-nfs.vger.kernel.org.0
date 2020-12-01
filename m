Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1764A2CA68E
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Dec 2020 16:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389972AbgLAPHp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 1 Dec 2020 10:07:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34699 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387462AbgLAPHp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 1 Dec 2020 10:07:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606835179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y+MROvh1AxNVSJuVngd7TZsTelIVxwvw/QDADrNuUck=;
        b=bUNSXMdP9wZefHFKm0UKgwfyqg2hpKC5vR8pOex3KMrLEKNav5XnK9MQHMzlZx5e+KQUyP
        nFuONpXMHds4kBqp/vKzNRIpAWA6w0xQgK5/p9jQz2UU/LbHKEO2SUtW291vdHf/6DUJQi
        YznrfV7G7wcw3uUIqQO9McOsKk2vEbE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-252-4xsZ0TO0MIGhMVwFi40uhQ-1; Tue, 01 Dec 2020 10:06:17 -0500
X-MC-Unique: 4xsZ0TO0MIGhMVwFi40uhQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9C1B41007465;
        Tue,  1 Dec 2020 15:06:16 +0000 (UTC)
Received: from pick.fieldses.org (ovpn-116-43.rdu2.redhat.com [10.10.116.43])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 561F26086F;
        Tue,  1 Dec 2020 15:06:16 +0000 (UTC)
Received: by pick.fieldses.org (Postfix, from userid 2815)
        id 438B51205B4; Tue,  1 Dec 2020 10:06:15 -0500 (EST)
Date:   Tue, 1 Dec 2020 10:06:15 -0500
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: [PATCH 1/6] nfsd: add a new EXPORT_OP_NOWCC flag to struct
 export_operations
Message-ID: <20201201150615.GH259862@pick.fieldses.org>
References: <20201130212455.254469-1-trondmy@kernel.org>
 <20201130212455.254469-2-trondmy@kernel.org>
 <20201130225842.GA22446@fieldses.org>
 <1b525278a9a7541529290588a83852a0754cee3e.camel@hammerspace.com>
 <20201201022834.GA241188@pick.fieldses.org>
 <66f93208c6edf2dad70ee41c349c5130b30b8ed4.camel@hammerspace.com>
 <20201201031130.GD22446@fieldses.org>
 <213a0908e8c9e743d6ae4d6f3b2679e2e879cce4.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <213a0908e8c9e743d6ae4d6f3b2679e2e879cce4.camel@hammerspace.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Dec 01, 2020 at 03:16:41AM +0000, Trond Myklebust wrote:
> On Mon, 2020-11-30 at 22:11 -0500, bfields@fieldses.org wrote:
> > On Tue, Dec 01, 2020 at 03:06:46AM +0000, Trond Myklebust wrote:
> > > A local filesystem might choose to set the 'non-atomic' flag
> > > without
> > > wanting to turn off NFSv3 WCC attributes. Yes, the latter are
> > > assumed
> > > to be atomic, but a number of commercial servers do abuse that
> > > assumption in practice.
> > 
> > What do you mean by abusing that assumption?
> > 
> > I thought that leaving off the post-op attrs was the v3 protocol's
> > way
> > of saying that it couldn't give you atomic wcc information.
> > 
> 
> I mean that a number of commercial servers will happily return NFSv3
> pre/post-operation WCC information that is not atomic with the
> operation that is supposed to be 'protected'.

Oh, OK.

But why do *we* want to do that?

If there's some reason a filesystem really needs NFSv3 post-operation
WCC information without providing an atomic guarantee, they can make
that argument when the filesystem's merged.

Separating these two flags on the off chance a future filesystem may
want to violate the protocol in this way seems unnecessary.

--b.

