Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE1F6B9FF6
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Mar 2023 20:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbjCNTrf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 Mar 2023 15:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjCNTre (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 Mar 2023 15:47:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39473645D;
        Tue, 14 Mar 2023 12:47:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 59420B81ACC;
        Tue, 14 Mar 2023 19:47:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E826AC433EF;
        Tue, 14 Mar 2023 19:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678823250;
        bh=rcZILeEMZPxS/d8YTx+9VSG/J7+wybp/InVGDfs/zpo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Qj/7X4y1Y5aIKXYYELdBYclAxhUVcDHpndiHZLmhbmJSlzCbf0EZu3d+6pO6NSW+U
         Xhq9xjl1dgtX16yF9xDs5WmlUIkVO+HdEqn02vHzU92Cj7bfyw4akTzAfAmxcWz64s
         50DpJzgAW2CvvvXOSGO4GsIimnJpOYHsWxPsy/q3OOcLCbrlkKv3xKNO85rUg7ID06
         D5G7EJ62T6Uqce+VJa0R61ZXSDhmVcYQvZgGA9aP8Qvx3pWVSmvs7DoifrBpGSQFj2
         nCYr5OEHY95AuWzuFqf8bSTkNfmUOT5G9dn9PuRV6pbqclYGIsajEQGgFOOdFNcm9I
         MYBm9hm5x4n1A==
Received: by mail-qv1-f45.google.com with SMTP id bo10so13023174qvb.12;
        Tue, 14 Mar 2023 12:47:30 -0700 (PDT)
X-Gm-Message-State: AO0yUKU2H5WGP2oS+DP5Ihm6Gfm855vX0tZMNjLCQ8q3j8wckPxwcLN8
        ox1mX9UpG7hgvfF9nEiEWMS++2aW4P8y+jiHzHs=
X-Google-Smtp-Source: AK7set9L1dAKh3yoJogBPeNvjI7idAiDwJJvdauMpYnWgYdvqnncGYRuxo9/Mc0GdLXat6Xw/x57jX83GWkWhAYnbUc=
X-Received: by 2002:ac8:40cd:0:b0:3d3:36eb:27c4 with SMTP id
 f13-20020ac840cd000000b003d336eb27c4mr661890qtm.13.1678823250062; Tue, 14 Mar
 2023 12:47:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230308080327.33906-1-chengen.du@canonical.com> <84E89457-478E-42F8-AC5F-DFFC58FBEFFB@hammerspace.com>
In-Reply-To: <84E89457-478E-42F8-AC5F-DFFC58FBEFFB@hammerspace.com>
From:   Anna Schumaker <anna@kernel.org>
Date:   Tue, 14 Mar 2023 15:47:14 -0400
X-Gmail-Original-Message-ID: <CAFX2JfkR3exLZUYS6mydhS-putG+6WoHjP790NJbXOQCw3McJQ@mail.gmail.com>
Message-ID: <CAFX2JfkR3exLZUYS6mydhS-putG+6WoHjP790NJbXOQCw3McJQ@mail.gmail.com>
Subject: Re: [PATCH] NFS: Correct timing for assigning access cache timestamp
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     Chengen Du <chengen.du@canonical.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Mar 14, 2023 at 2:51=E2=80=AFPM Trond Myklebust <trondmy@hammerspac=
e.com> wrote:
>
>
>
> > On Mar 8, 2023, at 03:03, Chengen Du <chengen.du@canonical.com> wrote:
> >
> > When the user's login time is newer than the cache's timestamp,
> > the original entry in the RB-tree will be replaced by a new entry.
> > Currently, the timestamp is only set if the entry is not found in
> > the RB-tree, which can cause the timestamp to be undefined when
> > the entry exists. This may result in a significant increase in
> > ACCESS operations if the timestamp is set to zero.
> >
> > Signed-off-by: Chengen Du <chengen.du@canonical.com>
> > ---
> > fs/nfs/dir.c | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
> > index a41c3ee4549c..6fbcbb8d6587 100644
> > --- a/fs/nfs/dir.c
> > +++ b/fs/nfs/dir.c
> > @@ -3089,7 +3089,6 @@ static void nfs_access_add_rbtree(struct inode *i=
node,
> > else
> > goto found;
> > }
> > - set->timestamp =3D ktime_get_ns();
> > rb_link_node(&set->rb_node, parent, p);
> > rb_insert_color(&set->rb_node, root_node);
> > list_add_tail(&set->lru, &nfsi->access_cache_entry_lru);
> > @@ -3114,6 +3113,7 @@ void nfs_access_add_cache(struct inode *inode, st=
ruct nfs_access_entry *set,
> > cache->fsgid =3D cred->fsgid;
> > cache->group_info =3D get_group_info(cred->group_info);
> > cache->mask =3D set->mask;
> > + cache->timestamp =3D ktime_get_ns();
> >
> > /* The above field assignments must be visible
> > * before this item appears on the lru.  We cannot easily
> > --
> > 2.37.2
> >
>
> Doh! Nice catch=E2=80=A6
>
> Anna, please pick this up for 6.2-rcX and add an appropriate
>
> Fixes: 0eb43812c027 ("NFS: Clear the file access cache upon login=E2=80=
=9D)

Will do!

Anna
>
> Thanks!
>   Trond
>
> _________________________________
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>
