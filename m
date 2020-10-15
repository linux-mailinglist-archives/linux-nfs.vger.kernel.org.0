Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2630E28EA1B
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Oct 2020 03:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388858AbgJOBag (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 14 Oct 2020 21:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732241AbgJOB3i (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 14 Oct 2020 21:29:38 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE12C002167
        for <linux-nfs@vger.kernel.org>; Wed, 14 Oct 2020 17:11:43 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id c22so1083088ejx.0
        for <linux-nfs@vger.kernel.org>; Wed, 14 Oct 2020 17:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YhQAlU/O3+F66rAF0SQgGMOn0AEmbnJlAAn0mVQDbwM=;
        b=Q44mY8DePq2cnsfSybdLzUthzmNa6k+3rKBSFTkb2+l8A449A3ZDmYomgU6jLgWkNJ
         51gMoRY1+agdTxuSDyZ27B83AAdRgm9Y472hwvjuYYyF+dFjwh2PNw+EiD7ObnluTE4l
         OOu1QXUf/hxS3FGd2SsC0rHhvhfIS9jR5xQ7elvP4iwSguusTEtWHxO6H9l9ESoXujgX
         35VGD/lUt5HdJxTE0HEU38DWmnnDlg06uHTBFwGymgyjhhsjBrsKJQ79/Geg8yJ8QbUZ
         ZrqGL9m5+fqzBGK5hpKaYsZ3Q/LiP8SaAl5Bh/DMw7juVHzhHQgzbWq7Kc9jUNr7aTOQ
         s3qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YhQAlU/O3+F66rAF0SQgGMOn0AEmbnJlAAn0mVQDbwM=;
        b=fjThCGfKFVUliqmNyMYTUl8qAFHzxbKpW8k4kQiBUQLC39AGw+EqiuJnMPB8EHSQvd
         JDlo9RIUib7nKoCZNUwpjvUfpSEu2Z1t2YM7rjLoI9Zj2HR72VSY1N6x81r4yWHfjY8Q
         Bikc06NE/dVDyjfH2ixQNFJVzoBBfb9GmNisMVGtTpXeO5Uf2+VA+TdjkL78ZXuPVC1y
         AWct8g0kuqo7yleH9DYlEXdbz7+SDQwwuD/rbhxzJlLSdFPLdi5b/p6qc02uBmvjojMa
         pWuh+zQ71QmILKF8m8vcnByhgPUCVT3bL6h28gHGTT9BXmjnGd5EUTBsgmqod6rrUu0r
         a8/g==
X-Gm-Message-State: AOAM533pj4aQKZ8tynVkGIO3eAVUepa13iGo/hozI6rqnS+9zgBa87Fd
        1ApOAcznmR87EjmTBZc21hCMMmFwdVr8cG+nLH6P
X-Google-Smtp-Source: ABdhPJy7ph8qHGox7X42/Eb6A+rX5E52y/8i06JWpsLLAOjnzVUUNczwHGNT6zRvxevXGWy7WdUKonvXDU5CUzagekc=
X-Received: by 2002:a17:906:c444:: with SMTP id ck4mr1608332ejb.398.1602720701798;
 Wed, 14 Oct 2020 17:11:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAN-5tyETQWVphrgqWjcPrtTzHHyz5DGrRz741yPYRS9Byyd=3Q@mail.gmail.com>
 <CAHC9VhRP2iJqLWiBg46zPKUqxzZoUOuaA6FPigxOw7qubophdw@mail.gmail.com>
 <CAN-5tyFq775PeOOzqskFexdbCgK3Gk_XB2Yy80SRYSc7Pdj=CA@mail.gmail.com>
 <CAHC9VhTzO1z6NmYz6cOLg5OvJiyQXdH_VmLh4=+h1MrGXx36JQ@mail.gmail.com>
 <CAN-5tyGJxUZb5QdJ=fh+L-6rc2B-MhQbDcDkTZNAZAAJm9Q8YQ@mail.gmail.com>
 <FB6C74CE-5D9F-4469-A49B-93CC8A51D7D5@gmail.com> <CAN-5tyFQbfkiuno07C6Azc7RcF3z3qF3PP0FutFMD3raBgnQmA@mail.gmail.com>
 <CAEjxPJ7PoAG6f+gVdodx=6X8+_Z_WCFXAuxnpB8WmC1gTF4iQQ@mail.gmail.com>
 <CAN-5tyEy57xoqEbZAThZKHriJywx-5DMKBD5tsXwo5ccGwuctw@mail.gmail.com>
 <CAHC9VhQpCXFySZY42==KR57hfAkVLdS6mSAcp2UHn-GWjEfVLg@mail.gmail.com> <bc766b2b-d1f1-d767-579c-02e10ae32a9a@schaufler-ca.com>
In-Reply-To: <bc766b2b-d1f1-d767-579c-02e10ae32a9a@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 14 Oct 2020 20:11:30 -0400
Message-ID: <CAHC9VhS7UeCX9BXPrHNH90_sLHKGxTbbtjdm6GBOgDM9=T05FA@mail.gmail.com>
Subject: Re: selinux: how to query if selinux is enabled
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Olga Kornievskaia <aglo@umich.edu>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Chuck Lever <chucklever@gmail.com>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Oct 14, 2020 at 12:31 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 10/14/2020 8:57 AM, Paul Moore wrote:
> > On Wed, Oct 14, 2020 at 10:37 AM Olga Kornievskaia <aglo@umich.edu> wrote:
> >> On Tue, Oct 13, 2020 at 7:51 PM Stephen Smalley wrote:
> >>> I would suggest either introducing a new hook for your purpose, or
> >>> altering the existing one to support a form of query that isn't based
> >>> on a particular xattr name but rather just checking whether the module
> >>> supports/uses MAC labels at all.  Options: 1) NULL argument to the
> >>> existing hook indicates a general query (could hide a bug in the
> >>> caller, so not optimal), 2) Add a new bool argument to the existing
> >>> hook to indicate whether the name should be used, or 3) Add a new hook
> >>> that doesn't take any arguments.
> >> Hi Stephen,
> >>
> >> Yes it seems like current api lacks the needed functionality and what
> >> you are suggesting is needed. Thank you for confirming it.
> > To add my two cents at this point, I would be in favor of a new LSM
> > hook rather than hijacking security_ismaclabel().  It seems that every
> > few years someone comes along and asks for a way to detect various LSM
> > capabilities, this might be the right time to introduce a LSM API for
> > this.
> >
> > My only concern about adding such an API is it could get complicated
> > very quickly.  One nice thing we have going for us is that this is a
> > kernel internal API so we don't have to worry about kernel/userspace
> > ABI promises, if we decide we need to change the API at some point in
> > the future we can do so without problem.  For that reason I'm going to
> > suggest we do something relatively simple with the understanding that
> > we can change it if/when the number of users grow.
> >
> > To start the discussion I might suggest the following:
> >
> > #define LSM_FQUERY_VFS_NONE     0x00000000
> > #define LSM_FQUERY_VFS_XATTRS   0x00000001
> > int security_func_query_vfs(unsigned int flags);
> >
> > ... with an example SELinux implementation looks like this:
> >
> > int selinux_func_query_vfs(unsigned int flags)
> > {
> >     return !!(flags & LSM_FQUERY_VFS_XATTRS);
> > }
>
> Not a bad start, but I see optimizations and issues.
>
> It would be really easy to collect the LSM features at module
> initialization by adding the feature flags to struct lsm_info.
> We could maintain a variable lsm_features in security.c that
> has the cumulative feature set. Rather than have an LSM hook for
> func_query_vfs we'd get
>
> int security_func_query_vfs(void)
> {
>         return !!(lsm_features & LSM_FQUERY_VFS_XATTRS);
> }

Works for me.

> In either case there could be confusion in the case where more
> than one security module provides the feature. NFS, for example,
> cares about the SELinux "selinux" attribute, but probably not
> about the Smack "SMACK64EXEC" attribute. It's entirely possible
> that a bit isn't enough information to check about a "feature".

In the LSM stacking world that shouldn't matter to callers, right?  Or
perhaps more correctly, if it matters to the caller which individual
LSM supports what feature then the caller is doing it wrong, right?

-- 
paul moore
www.paul-moore.com
