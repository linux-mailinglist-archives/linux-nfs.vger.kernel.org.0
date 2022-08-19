Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE6BF599D9E
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Aug 2022 16:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbiHSOhk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 19 Aug 2022 10:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349361AbiHSOhk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 19 Aug 2022 10:37:40 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3A6EC4E1
        for <linux-nfs@vger.kernel.org>; Fri, 19 Aug 2022 07:37:39 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id gi31so2684737ejc.5
        for <linux-nfs@vger.kernel.org>; Fri, 19 Aug 2022 07:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=GApylcuHJ6o7AafYUj8ZriXMJRJhGktD8b9xSgEnGtQ=;
        b=RW2cigDougzpiNi3LbzhUsQr/l9sVkRsrKs4OaqgaGm62oln6cIQDfgwmIGsLmyBBG
         Xxegr4/ghU3Aff/vhg+IqxtsSHCrv++G1wKWZ2q2sEQtktznjNlzH0QXmb18LezxDZJk
         LxKKRGs7QM9FnmLNNcLvVALde6WrUovWSllxioIgG6iIW38hzFHOEmv7hfPcs25kNJjI
         afs7X680wQk4iACUOyab/5WrqURGx3kPHrPu2d2UQdKooVAZpXXrGN2HVpnfCceQarY7
         nAdEg3XgyRiJmY2Gy4cI/GPPwuuYVD9ClaIQmXt+GeD21nta190N341VmnC/eWrgx/UX
         UFuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=GApylcuHJ6o7AafYUj8ZriXMJRJhGktD8b9xSgEnGtQ=;
        b=qcIgBj30f4vwuVMY5Dl2yHRlXzdLMotA21vDNZetyXp6mQKBsunBhCbUWc6ogIlqET
         66Dxh8G0jM0GJKIBuszz4ndTJkMtJHPcYA8lFiF2PhBFZml2H+8OADTSd4+IoB/YKuHm
         NXlc1SBCbI7bp2M+Jt5cVW9e7NKhD9o+1HfDGYK0SvVZCVTaE49W7paXCpTV6lMlYJjJ
         k9OWRKiO0U7zv27SDuW4g/0p2KaoH7Bj92ucjvE9l8SO3O4T/bIxtqDqZBdMPfc46ICo
         Wa3Kys/HUBfkkKXAderwcjKizAHzicG8QCa7qosD1l/xOhy75Xe7HI2/+rXCT9himJ35
         JePw==
X-Gm-Message-State: ACgBeo3lPri+h8GwCxea3ABTQnLkoBTV1YlaccIAPMuiUQhpbc2of5lY
        84qNjE1RfB3ILm8Iqs1/OROf6ZyPjtDTu1lpJfU=
X-Google-Smtp-Source: AA6agR6dn7uSNI59kaFR3Z+FkWmUVnLrWzO8wrEGABgtHi6UBpNO7AOBDyI4EVj6O7uwDZYB3mwDf1Ej6SPsmFfcUf4=
X-Received: by 2002:a17:907:7349:b0:730:61c8:d80d with SMTP id
 dq9-20020a170907734900b0073061c8d80dmr4827547ejc.699.1660919857535; Fri, 19
 Aug 2022 07:37:37 -0700 (PDT)
MIME-Version: 1.0
References: <166086695960.5425.17748020864798390841@noble.neil.brown.name> <d6a1c7378a4c666be93d22707405e0e0136a01fa.camel@hammerspace.com>
In-Reply-To: <d6a1c7378a4c666be93d22707405e0e0136a01fa.camel@hammerspace.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Fri, 19 Aug 2022 10:37:26 -0400
Message-ID: <CAN-5tyHdSSfJLVff0DsW1+zq=tTxF152fA_BipN1He=q1LroZA@mail.gmail.com>
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

On Thu, Aug 18, 2022 at 8:17 PM Trond Myklebust <trondmy@hammerspace.com> wrote:
>
> On Fri, 2022-08-19 at 09:55 +1000, NeilBrown wrote:
> >
> > nfs_unlink() calls d_delete() twice if it receives ENOENT from the
> > server - once in nfs_dentry_handle_enoent() from nfs_safe_remove and
> > once in nfs_dentry_remove_handle_error().
> >
> > nfs_rmddir() also calls it twice - the nfs_dentry_handle_enoent()
> > call
> > is direct and inside a region locked with ->rmdir_sem
> >
> > It is safe to call d_delete() twice if the refcount > 1 as the dentry
> > is
> > simply unhashed.
> > If the refcount is 1, the first call sets d_inode to NULL and the
> > second
> > call crashes.
> >
> > This patch guards the d_delete() call from nfs_dentry_handle_enoent()
> > leaving the one under ->remdir_sem in case that is important.
> >
> > In mainline it would be safe to remove the d_delete() call.  However
> > in
> > older kernels to which this might be backported, that would change
> > the
> > behaviour of nfs_unlink().  nfs_unlink() used to unhash the dentry
> > which
> > resulted in nfs_dentry_handle_enoent() not calling d_delete().  So in
> > older kernels we need the d_delete() in
> > nfs_dentry_remove_handle_error()
> > when called from nfs_unlink() but not when called from nfs_rmdir().
> >
> > To make the code work correctly for old and new kernels, and from
> > both
> > nfs_unlink() and nfs_rmdir(), we protect the d_delete() call with
> > simple_positive().  This ensures it is never called in a circumstance
> > where it could crash.
> >
> > Fixes: 3c59366c207e ("NFS: don't unhash dentry during unlink/rename")
> > Fixes: 9019fb391de0 ("NFS: Label the dentry with a verifier in
> > nfs_rmdir() and nfs_unlink()")
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
> >  fs/nfs/dir.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
> > index dbab3caa15ed..8f26f848818d 100644
> > --- a/fs/nfs/dir.c
> > +++ b/fs/nfs/dir.c
> > @@ -2382,7 +2382,8 @@ static void
> > nfs_dentry_remove_handle_error(struct inode *dir,
> >  {
> >         switch (error) {
> >         case -ENOENT:
> > -               d_delete(dentry);
> > +               if (d_really_is_positive(dentry))
> > +                       d_delete(dentry);
> >                 nfs_set_verifier(dentry,
> > nfs_save_change_attribute(dir));
> >                 break;
> >         case 0:
>
> OK. I've kicked v1 out of my linux-next branch, and applied v2 to my
> testing branch. I'll try to give it some testing tomorrow.
>
> Olga, will you be able to test v2 to see if it fixes your bug report as
> well?

Will do.

>
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>
>
