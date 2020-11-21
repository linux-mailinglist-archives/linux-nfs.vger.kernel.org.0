Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0F52BBB60
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Nov 2020 02:02:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbgKUBBl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 20:01:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22386 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727163AbgKUBBl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 20:01:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605920500;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=13JX49lgMqG7h+XNqlVi/YgKnlesi9HqI9UIEURl69Q=;
        b=cYnfzFxQ8J+AjiXwUG30Scd1rN3mbEd+oTPOuCwlUGKkCtGdUcr7FVCgs3557cpOPN/tdH
        xfJ/FzKUiuu9GASX2OGpVDnzNDXEeZivIcs9STJoZTHOqMvrsgpIZxsqmAoG+3j7SXpnpe
        40W6MjdNxM13k60mpYdAHxLPCPiB7jY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-424-XIs8jj_FOI29uYl3U4sXIw-1; Fri, 20 Nov 2020 20:01:35 -0500
X-MC-Unique: XIs8jj_FOI29uYl3U4sXIw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7D21010059A4;
        Sat, 21 Nov 2020 01:01:34 +0000 (UTC)
Received: from pick.fieldses.org (ovpn-113-103.rdu2.redhat.com [10.10.113.103])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4CDBC60853;
        Sat, 21 Nov 2020 01:01:29 +0000 (UTC)
Received: by pick.fieldses.org (Postfix, from userid 2815)
        id 6559F12033D; Fri, 20 Nov 2020 20:01:28 -0500 (EST)
Date:   Fri, 20 Nov 2020 20:01:28 -0500
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Daire Byrne <daire@dneg.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        linux-cachefs <linux-cachefs@redhat.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 6/8] nfsd: move change attribute generation to filesystem
Message-ID: <20201121010128.GK136478@pick.fieldses.org>
References: <20201120223831.GB7705@fieldses.org>
 <1605911960-12516-1-git-send-email-bfields@redhat.com>
 <1605911960-12516-6-git-send-email-bfields@redhat.com>
 <6c2bb6ae1ad586d6bf369afe561b77b271cd2ac8.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6c2bb6ae1ad586d6bf369afe561b77b271cd2ac8.camel@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Nov 20, 2020 at 07:58:38PM -0500, Jeff Layton wrote:
> On Fri, 2020-11-20 at 17:39 -0500, J. Bruce Fields wrote:
> > diff --git a/fs/xfs/xfs_export.c b/fs/xfs/xfs_export.c
> > index 465fd9e048d4..b950fac3d7df 100644
> > --- a/fs/xfs/xfs_export.c
> > +++ b/fs/xfs/xfs_export.c
> > @@ -16,6 +16,7 @@
> >  #include "xfs_inode_item.h"
> >  #include "xfs_icache.h"
> >  #include "xfs_pnfs.h"
> > +#include <linux/iversion.h>
> >  
> > 
> > 
> > 
> >  /*
> >   * Note that we only accept fileids which are long enough rather than allow
> > @@ -234,4 +235,5 @@ const struct export_operations xfs_export_operations = {
> >  	.map_blocks		= xfs_fs_map_blocks,
> >  	.commit_blocks		= xfs_fs_commit_blocks,
> >  #endif
> > +	.fetch_iversion		= generic_fetch_iversion,
> >  };
> 
> It seems a little weird to call a static inline here. I imagine that
> means the compiler has to add a duplicate inline in every .o file that
> does this? It may be cleaner to move generic_fetch_iversion into
> fs/libfs.c so we only have one copy of it.

OK.

(To be honest, I was a little suprised this worked.)

--b.

> 
> > diff --git a/include/linux/iversion.h b/include/linux/iversion.h
> > index 3bfebde5a1a6..ded74523c8a6 100644
> > --- a/include/linux/iversion.h
> > +++ b/include/linux/iversion.h
> > @@ -328,6 +328,32 @@ inode_query_iversion(struct inode *inode)
> >  	return cur >> I_VERSION_QUERIED_SHIFT;
> >  }
> >  
> > 
> > 
> > 
> > +/*
> > + * We could use i_version alone as the NFSv4 change attribute.  However,
> > + * i_version can go backwards after a reboot.  On its own that doesn't
> > + * necessarily cause a problem, but if i_version goes backwards and then
> > + * is incremented again it could reuse a value that was previously used
> > + * before boot, and a client who queried the two values might
> > + * incorrectly assume nothing changed.
> > + *
> > + * By using both ctime and the i_version counter we guarantee that as
> > + * long as time doesn't go backwards we never reuse an old value.
> > + *
> > + * A filesystem that has an on-disk boot counter or similar might prefer
> > + * to use that to avoid the risk of the change attribute going backwards
> > + * if system time is set backwards.
> > + */
> > +static inline u64 generic_fetch_iversion(struct inode *inode)
> > +{
> > +	u64 chattr;
> > +
> > +	chattr =  inode->i_ctime.tv_sec;
> > +	chattr <<= 30;
> > +	chattr += inode->i_ctime.tv_nsec;
> > +	chattr += inode_query_iversion(inode);
> > +	return chattr;
> > +}
> > +
> >  /*
> >   * For filesystems without any sort of change attribute, the best we can
> >   * do is fake one up from the ctime:
> 
> -- 
> Jeff Layton <jlayton@kernel.org>
> 

