Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23D5469FE87
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Feb 2023 23:29:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbjBVW36 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 22 Feb 2023 17:29:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232238AbjBVW35 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 22 Feb 2023 17:29:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B10619D
        for <linux-nfs@vger.kernel.org>; Wed, 22 Feb 2023 14:29:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D3075615B8
        for <linux-nfs@vger.kernel.org>; Wed, 22 Feb 2023 22:29:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52861C4339C
        for <linux-nfs@vger.kernel.org>; Wed, 22 Feb 2023 22:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677104995;
        bh=7IOH51jDc8h2K3I1lsDCDlbudH6UtTEhDEe39Ao/Ky8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fPzF3GzIQpBFqan29UIT7UeN6A2OCrE2+KKIc0M5noBi2RZG8KBvccVEdDVWXCq33
         fwVmlcXa/wf/25bGh0xY+8lejjXITPM2yDYrIMSDmkejZBvOuM/RgAETziaOtSNa/V
         o75f4A8iFcRlmONVxn+iHy3kOWwBb/2vg4ssdj/pjApbd+yMTzPnG93uJCAkVgPPbw
         HKJNmHOZ/5oNcP/MWNwLYD/ZSkUrmkJFxoeNzQtlVfkMi3uCirkBktQSMYiX6+IqDM
         u/phjgmZxmpQgkCWYaw9mjgEX+PlVnlA20Cd7rPUlp0aHhzH+C7/wHAl6Oe2ieoKuw
         tyh4JyAwKzExg==
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-536cb25982eso124517797b3.13
        for <linux-nfs@vger.kernel.org>; Wed, 22 Feb 2023 14:29:55 -0800 (PST)
X-Gm-Message-State: AO0yUKW50UafbCYEhE/uf+FPlc0FwGqlg/xq9iS4wgs4ZIdys+D0MMb+
        a6oXkiI3v9DrE37TEZWbhoNpL208ZaLPOd4PN+o=
X-Google-Smtp-Source: AK7set/rl6ulQSqCVVJmNrXzK9Ha8Sb6FbnbQlRhyqdSobGg0DQhhCqgnUn1luhwXoRikXeN6D/UMWKxQcJZRGQ8O4U=
X-Received: by 2002:a25:9c06:0:b0:a0d:8150:bed5 with SMTP id
 c6-20020a259c06000000b00a0d8150bed5mr677629ybo.3.1677104994366; Wed, 22 Feb
 2023 14:29:54 -0800 (PST)
MIME-Version: 1.0
References: <20230215115354.14907-1-jlayton@kernel.org> <ACB5CC34-59DD-42DD-95D4-F4B7CA93552A@oracle.com>
In-Reply-To: <ACB5CC34-59DD-42DD-95D4-F4B7CA93552A@oracle.com>
From:   Anna Schumaker <anna@kernel.org>
Date:   Wed, 22 Feb 2023 17:29:38 -0500
X-Gmail-Original-Message-ID: <CAFX2Jf=k4nfwv1WuUOa42PZAi0RkjvXDdRUCv6Fp-aSt=AiE6A@mail.gmail.com>
Message-ID: <CAFX2Jf=k4nfwv1WuUOa42PZAi0RkjvXDdRUCv6Fp-aSt=AiE6A@mail.gmail.com>
Subject: Re: [PATCH v2] nfsd: allow reaping files still under writeback
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Chuck,

On Sun, Feb 19, 2023 at 2:46 PM Chuck Lever III <chuck.lever@oracle.com> wrote:
>
>
>
> > On Feb 15, 2023, at 6:53 AM, Jeff Layton <jlayton@kernel.org> wrote:
> >
> > On most filesystems, there is no reason to delay reaping an nfsd_file
> > just because its underlying inode is still under writeback. nfsd just
> > relies on client activity or the local flusher threads to do writeback.
> >
> > The main exception is NFS, which flushes all of its dirty data on last
> > close. Add a new EXPORT_OP_FLUSH_ON_CLOSE flag to allow filesystems to
> > signal that they do this, and only skip closing files under writeback on
> > such filesystems.
> >
> > Also, remove a redundant NULL file pointer check in
> > nfsd_file_check_writeback, and clean up nfs's export op flag
> > definitions.
> >
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
>
> I assume that I'm taking this via the nfsd tree? If so,
> I would like an Acked-by from the NFS client maintainers...

The NFS changes look fine to me.

Acked-by: Anna Schumaker <Anna.Schumaker@Netapp.com>

>
> For the moment this is going to topic-filecache-cleanups,
> not to nfsd-next.
>
>
> > ---
> > fs/nfs/export.c          |  9 ++++++---
> > fs/nfsd/filecache.c      | 11 ++++++++++-
> > include/linux/exportfs.h |  1 +
> > 3 files changed, 17 insertions(+), 4 deletions(-)
> >
> > diff --git a/fs/nfs/export.c b/fs/nfs/export.c
> > index 0a5ee1754d50..102a454e27c9 100644
> > --- a/fs/nfs/export.c
> > +++ b/fs/nfs/export.c
> > @@ -156,7 +156,10 @@ const struct export_operations nfs_export_ops = {
> >       .fh_to_dentry = nfs_fh_to_dentry,
> >       .get_parent = nfs_get_parent,
> >       .fetch_iversion = nfs_fetch_iversion,
> > -     .flags = EXPORT_OP_NOWCC|EXPORT_OP_NOSUBTREECHK|
> > -             EXPORT_OP_CLOSE_BEFORE_UNLINK|EXPORT_OP_REMOTE_FS|
> > -             EXPORT_OP_NOATOMIC_ATTR,
> > +     .flags = EXPORT_OP_NOWCC                |
> > +              EXPORT_OP_NOSUBTREECHK         |
> > +              EXPORT_OP_CLOSE_BEFORE_UNLINK  |
> > +              EXPORT_OP_REMOTE_FS            |
> > +              EXPORT_OP_NOATOMIC_ATTR        |
> > +              EXPORT_OP_FLUSH_ON_CLOSE,
> > };
> > diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> > index e6617431df7c..98e1ab013ac0 100644
> > --- a/fs/nfsd/filecache.c
> > +++ b/fs/nfsd/filecache.c
> > @@ -302,8 +302,17 @@ nfsd_file_check_writeback(struct nfsd_file *nf)
> >       struct file *file = nf->nf_file;
> >       struct address_space *mapping;
> >
> > -     if (!file || !(file->f_mode & FMODE_WRITE))
> > +     /* File not open for write? */
> > +     if (!(file->f_mode & FMODE_WRITE))
> >               return false;
> > +
> > +     /*
> > +      * Some filesystems (e.g. NFS) flush all dirty data on close.
> > +      * On others, there is no need to wait for writeback.
> > +      */
> > +     if (!(file_inode(file)->i_sb->s_export_op->flags & EXPORT_OP_FLUSH_ON_CLOSE))
> > +             return false;
> > +
> >       mapping = file->f_mapping;
> >       return mapping_tagged(mapping, PAGECACHE_TAG_DIRTY) ||
> >               mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK);
> > diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
> > index fe848901fcc3..218fc5c54e90 100644
> > --- a/include/linux/exportfs.h
> > +++ b/include/linux/exportfs.h
> > @@ -221,6 +221,7 @@ struct export_operations {
> > #define EXPORT_OP_NOATOMIC_ATTR               (0x10) /* Filesystem cannot supply
> >                                                 atomic attribute updates
> >                                               */
> > +#define EXPORT_OP_FLUSH_ON_CLOSE     (0x20) /* fs flushes file data on close */
> >       unsigned long   flags;
> > };
> >
> > --
> > 2.39.1
> >
>
> --
> Chuck Lever
>
>
>
