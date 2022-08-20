Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4202259A9CA
	for <lists+linux-nfs@lfdr.de>; Sat, 20 Aug 2022 02:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242928AbiHTAIN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 19 Aug 2022 20:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244863AbiHTAIH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 19 Aug 2022 20:08:07 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507371156E5
        for <linux-nfs@vger.kernel.org>; Fri, 19 Aug 2022 17:08:05 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id ca13so270913ejb.9
        for <linux-nfs@vger.kernel.org>; Fri, 19 Aug 2022 17:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=ZfgABdzngtEViS5eCZAQXiitTIRXN+lflH98+wK6OZ4=;
        b=lODvQCx2O3rKO2nTe7Ic3UoCmUHbLGbSi3nO/85LhAL+lakHTo4RGAY29VIPrmc+t4
         I/ThIi6eJ+nsG8JIVpJyFV4XTv1njAhFhlAYSXzU6VNCUawLPdbHYDYFSbJpB3JqgUem
         r9xONV9eLTM3wgaOmy64nIx7W0ZcpZbjuRK+he96AQL5k8oOJRL4g4rseeySqFEPNjGe
         G9Y+o0CbxWUGrJVwD0vTIJGb2QVgMc+PcrABZ2LwrMkeiANDdw9U9X0mEjNGRSHa+uD4
         CkJdXwblYGlY/R7EN6mIb+EeJehez5FQnt23j5ukHqa/kKXo1OKTEq40VAHb/AaYt9Ts
         Uyng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=ZfgABdzngtEViS5eCZAQXiitTIRXN+lflH98+wK6OZ4=;
        b=Qwrx1YqYFV/v8doCS98Ici74lebafivkIsmaZ10OU4WmusxKeOEc16kQ+zANraIeri
         sraEf1uplaw7lzSoxcMhOJcantjAABqA64OPIuXqTtO1l95Jel5awx4fySyx6d70uqD0
         pHXT/zsWtYjTcQ9hS6wKLBVpYdHfrHhiTkpP5TeKyx+aJps62zYn2KZkIG8iUyT1yiZC
         3HxeIvLvz/l8DLbkgdTz52X/I3W/Kc1AAyay1UDslL6uR96etSZeB9oJvS9PWo8t217R
         evDjqDALyfMEFsGbimqBzHw7VjoYgBYk3WWJSpbWsr0I9ImzhzY9dWYzFb1FyV4IMf4w
         QH2g==
X-Gm-Message-State: ACgBeo1dZBNany7CqK8UT3yWEHTsfTNaW7XUtx4bE+mCMzvz1BzHRNWY
        ezXtncxu+d2/FdCZlr8wEjFJAxmV1AD6yagG7TU=
X-Google-Smtp-Source: AA6agR7UwABEYz5WMHnifHM71nfJHAnXB3Z+mP3li4bGPSO6slzAWGJUmGGYLvYsaf/KZRqw1qALl1HHoz5SSgzjlz0=
X-Received: by 2002:a17:907:1c93:b0:730:c9c3:f6f8 with SMTP id
 nb19-20020a1709071c9300b00730c9c3f6f8mr6683285ejc.17.1660954083670; Fri, 19
 Aug 2022 17:08:03 -0700 (PDT)
MIME-Version: 1.0
References: <166086695960.5425.17748020864798390841@noble.neil.brown.name>
 <d6a1c7378a4c666be93d22707405e0e0136a01fa.camel@hammerspace.com> <CAN-5tyHdSSfJLVff0DsW1+zq=tTxF152fA_BipN1He=q1LroZA@mail.gmail.com>
In-Reply-To: <CAN-5tyHdSSfJLVff0DsW1+zq=tTxF152fA_BipN1He=q1LroZA@mail.gmail.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Fri, 19 Aug 2022 20:07:52 -0400
Message-ID: <CAN-5tyFFXGadpyT0mR7-YTAQmzi0w7k950T6Tnh=KhnZ1OF+Rw@mail.gmail.com>
Subject: Re: [PATCH v2] NFS: unlink/rmdir shouldn't call d_delete() twice on ENOENT
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "neilb@suse.de" <neilb@suse.de>,
        "hooanon05g@gmail.com" <hooanon05g@gmail.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Aug 19, 2022 at 10:37 AM Olga Kornievskaia <aglo@umich.edu> wrote:
>
> On Thu, Aug 18, 2022 at 8:17 PM Trond Myklebust <trondmy@hammerspace.com> wrote:
> >
> > On Fri, 2022-08-19 at 09:55 +1000, NeilBrown wrote:
> > >
> > > nfs_unlink() calls d_delete() twice if it receives ENOENT from the
> > > server - once in nfs_dentry_handle_enoent() from nfs_safe_remove and
> > > once in nfs_dentry_remove_handle_error().
> > >
> > > nfs_rmddir() also calls it twice - the nfs_dentry_handle_enoent()
> > > call
> > > is direct and inside a region locked with ->rmdir_sem
> > >
> > > It is safe to call d_delete() twice if the refcount > 1 as the dentry
> > > is
> > > simply unhashed.
> > > If the refcount is 1, the first call sets d_inode to NULL and the
> > > second
> > > call crashes.
> > >
> > > This patch guards the d_delete() call from nfs_dentry_handle_enoent()
> > > leaving the one under ->remdir_sem in case that is important.
> > >
> > > In mainline it would be safe to remove the d_delete() call.  However
> > > in
> > > older kernels to which this might be backported, that would change
> > > the
> > > behaviour of nfs_unlink().  nfs_unlink() used to unhash the dentry
> > > which
> > > resulted in nfs_dentry_handle_enoent() not calling d_delete().  So in
> > > older kernels we need the d_delete() in
> > > nfs_dentry_remove_handle_error()
> > > when called from nfs_unlink() but not when called from nfs_rmdir().
> > >
> > > To make the code work correctly for old and new kernels, and from
> > > both
> > > nfs_unlink() and nfs_rmdir(), we protect the d_delete() call with
> > > simple_positive().  This ensures it is never called in a circumstance
> > > where it could crash.
> > >
> > > Fixes: 3c59366c207e ("NFS: don't unhash dentry during unlink/rename")
> > > Fixes: 9019fb391de0 ("NFS: Label the dentry with a verifier in
> > > nfs_rmdir() and nfs_unlink()")
> > > Signed-off-by: NeilBrown <neilb@suse.de>
> > > ---
> > >  fs/nfs/dir.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
> > > index dbab3caa15ed..8f26f848818d 100644
> > > --- a/fs/nfs/dir.c
> > > +++ b/fs/nfs/dir.c
> > > @@ -2382,7 +2382,8 @@ static void
> > > nfs_dentry_remove_handle_error(struct inode *dir,
> > >  {
> > >         switch (error) {
> > >         case -ENOENT:
> > > -               d_delete(dentry);
> > > +               if (d_really_is_positive(dentry))
> > > +                       d_delete(dentry);
> > >                 nfs_set_verifier(dentry,
> > > nfs_save_change_attribute(dir));
> > >                 break;
> > >         case 0:
> >
> > OK. I've kicked v1 out of my linux-next branch, and applied v2 to my
> > testing branch. I'll try to give it some testing tomorrow.
> >
> > Olga, will you be able to test v2 to see if it fixes your bug report as
> > well?
>
> Will do.

Finished testing successfullly. Tested-by.

>
> >
> > --
> > Trond Myklebust
> > Linux NFS client maintainer, Hammerspace
> > trond.myklebust@hammerspace.com
> >
> >
