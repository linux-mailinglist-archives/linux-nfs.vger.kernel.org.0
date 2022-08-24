Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA5FC59FAC6
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Aug 2022 15:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237818AbiHXNBu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 24 Aug 2022 09:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237799AbiHXNBh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 24 Aug 2022 09:01:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0266C97B2C
        for <linux-nfs@vger.kernel.org>; Wed, 24 Aug 2022 06:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661346094;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QAPjAsJu7iOATQWB+c0GngHgi+xgKxQbdfkHrh5GaOU=;
        b=VoCTXM/8cjtH66VE0rJRbqD+bRlvnXIBfe+4TQcKQScxBjk3oKMlaASwf19lZGtTRDe4aN
        gXsBBSHbejEpFOBRquVrP8vwm/jaIKgS4H1pt9JEjvK/v7XktQ6xVLvAoJFpqVY9nnJaG0
        SJdsfONPVmqzM1W0veNGiujgP4KZ/Rw=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-634-RSKbT_xYP86Ii-wiIenf3Q-1; Wed, 24 Aug 2022 09:01:33 -0400
X-MC-Unique: RSKbT_xYP86Ii-wiIenf3Q-1
Received: by mail-ed1-f71.google.com with SMTP id o2-20020a056402438200b0043d552deb2aso10808759edc.0
        for <linux-nfs@vger.kernel.org>; Wed, 24 Aug 2022 06:01:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=QAPjAsJu7iOATQWB+c0GngHgi+xgKxQbdfkHrh5GaOU=;
        b=I+nqcik9b3/Ja19kDPsD4QnA9qLG/ES9pw9K1I6O9dtI2rR7OXsAt9aqQeGieAcRu2
         /yWIwGfMKls0/jBzBiX29nOqzwzKzIBpZyRZWolrrNkJKQ+YYyqBoqXzgQ+B6npbXVSJ
         AOJNsG2vhhxlahlc7jdSYNnf/S1xqaYR+FgHmkdAJyLR//4MgqVwMatN5fUUkrvE4/3B
         HmaZWKqdchHVsri9IVKxNjZL3NQ53Q6/0QRNl7Zt90xMa6nFHsDl409SPZ7AJeXtqgHi
         rkPAtTq9KArxPpShvTl0QowFYohOtlF+2fuRqvwRXvWqMdnqIG17tJzt/6r685QvabZx
         xYGA==
X-Gm-Message-State: ACgBeo2qXrKg67AOQxZ7jeyhv+buZlpVe+TcXAmTyF/NpjX71Z3J2esw
        KccC/ExUrIQH3LYvzgeegJnKo6YcSlOLzI1CR1xL+jbqlOLGUHvjTYserwJm3ElURBZi9uJskyN
        aooafwoSZKp9nQLRSQPFmcIbClgqF8I3ZubI7
X-Received: by 2002:a17:907:6da1:b0:73d:877d:c56c with SMTP id sb33-20020a1709076da100b0073d877dc56cmr2889265ejc.342.1661346092377;
        Wed, 24 Aug 2022 06:01:32 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5joQw+U7+cpfBdVsHUHveN+r+mfIGsH2drD6D8wqkR8Ewtl6W7Ks6IwlXoBRTkKxUtCYhE/QHr7QpxyWLrVAE=
X-Received: by 2002:a17:907:6da1:b0:73d:877d:c56c with SMTP id
 sb33-20020a1709076da100b0073d877dc56cmr2889259ejc.342.1661346092168; Wed, 24
 Aug 2022 06:01:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220824093501.384755-1-dwysocha@redhat.com> <20220824093501.384755-3-dwysocha@redhat.com>
 <429ecc819fcffe63d60dbb2b72f9022d2a21ddd8.camel@hammerspace.com>
In-Reply-To: <429ecc819fcffe63d60dbb2b72f9022d2a21ddd8.camel@hammerspace.com>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Wed, 24 Aug 2022 09:00:56 -0400
Message-ID: <CALF+zOknvMZyufSUD-g9Z9Y5RfwE-vUFT+CF0kxqbcpR=yJPJw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] NFS: Add support for netfs in struct nfs_inode
 and Kconfig
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "linux-cachefs@redhat.com" <linux-cachefs@redhat.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "daire.byrne@gmail.com" <daire.byrne@gmail.com>,
        "benmaynard@google.com" <benmaynard@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Aug 24, 2022 at 8:42 AM Trond Myklebust <trondmy@hammerspace.com> wrote:
>
> On Wed, 2022-08-24 at 05:35 -0400, Dave Wysochanski wrote:
> > As first steps for support of the netfs library, add NETFS_SUPPORT
> > to Kconfig and add the required netfs_inode into struct nfs_inode.
> > The struct netfs_inode is now where the vfs_inode is stored as well
> > as the fscache_cookie.  In addition, use the netfs_inode() and
> > netfs_i_cookie() helpers, and remove our own helper, nfs_i_fscache().
> >
> > Later patches will enable netfs by defining NFS specific version
> > of struct netfs_request_ops and calling netfs_inode_init().
> >
> > Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
> > ---
> >  fs/nfs/Kconfig         |  1 +
> >  fs/nfs/delegation.c    |  2 +-
> >  fs/nfs/dir.c           |  2 +-
> >  fs/nfs/fscache.c       | 20 +++++++++-----------
> >  fs/nfs/fscache.h       | 15 ++++++---------
> >  fs/nfs/inode.c         |  6 +++---
> >  fs/nfs/internal.h      |  2 +-
> >  fs/nfs/pnfs.c          | 12 ++++++------
> >  fs/nfs/write.c         |  2 +-
> >  include/linux/nfs_fs.h | 19 +++++--------------
> >  10 files changed, 34 insertions(+), 47 deletions(-)
> >
> > diff --git a/fs/nfs/Kconfig b/fs/nfs/Kconfig
> > index 14a72224b657..79b241bed762 100644
> > --- a/fs/nfs/Kconfig
> > +++ b/fs/nfs/Kconfig
> > @@ -5,6 +5,7 @@ config NFS_FS
> >         select LOCKD
> >         select SUNRPC
> >         select NFS_ACL_SUPPORT if NFS_V3_ACL
> > +       select NETFS_SUPPORT
> >
>
> NACK. I'm not at all OK with making netfs mandatory.
>

Just so we're on the same page, are you ok with netfs being enabled if
fscache is enabled like today?

