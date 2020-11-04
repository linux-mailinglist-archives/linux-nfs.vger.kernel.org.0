Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56A512A6640
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Nov 2020 15:21:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgKDOV0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 4 Nov 2020 09:21:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbgKDOV0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 4 Nov 2020 09:21:26 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B07C0613D3;
        Wed,  4 Nov 2020 06:21:26 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id za3so29984837ejb.5;
        Wed, 04 Nov 2020 06:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DCfTmW4aQ62j6jmdezgBr0zOm5Qd+OLVYInBG1WvUE8=;
        b=RYrzdi56fiG5T+Z4pLBAbdoEFVS9a018tvCaPSKaRdaiuPp+/Tz5xU8mcqjcyUfXxD
         ZeXROBIDOWEouOJ91hOa9daYvjKaDy9uSKR0R/vVg658OfPtDRzq35nyIfkr2x0/Pmyu
         hlwyM+y6TKApP+iLaQOU2ME8MZiZXJI52pVhXQNCBRCjVOTvVyJ/xSRw+ihS/A+yVOye
         MkX3z8dMKn/1gbn9bGxfxU8TUTGzkNkkt+CW5IQN/Gp9aDeUtZrzkpi+2ZW1xUMq36Ng
         bG5BWt097lYEVgHEuZDL79KyPyZot1wxqkTe1DwkYW4i+HVan4RGU+eWlV8ByyF/ApVs
         Kj9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DCfTmW4aQ62j6jmdezgBr0zOm5Qd+OLVYInBG1WvUE8=;
        b=DDiu1Jbc/bH/kzYv1IPQzUQ67o4V7WN0dvv+bXocynY++hMVjCy0yplIbIZyscyF4F
         /Ci697oowzV/fbwlRkzCuyUDpFbSTc0BV5JOj9wX6Wzm6I43UOaK57q73Z1Lmw17iWUu
         4rNZV6ceVSXuytppOxLv3LJaLyUk0RUqhq/FXVHz+/pVL7q3UexDeDeW8ViyoTYEFQqZ
         H4ajngzJIYimxmcNrdKzRxS4yS03IEUTcvhXo8edZ7RMHLwNw7tTXDO24OOQUhIXhd3l
         btsRx2gA7j9WgzK6jkisswP1uaYd9fPPpamR/SmC4HNj/ghRvrPGyF9KOp1yHS/yotpN
         0qaQ==
X-Gm-Message-State: AOAM531+pU4IPga/Hebx+H1FnulvixGmaCeo9KoGvdBLIWgmJNFtOZ0E
        M4dnuq1G1qtbzqyOTaFUhRF+NCJjFLp02o7qTjg=
X-Google-Smtp-Source: ABdhPJyfBRKxhJ+WxtwZ9BbdFZ9+T5PIgznvtRyZZd5h/KEtHcIk8J5qA1Cu8KvKEfbwWPC2+dpvrIk0wD8eon6G+tw=
X-Received: by 2002:a17:906:ccc5:: with SMTP id ot5mr12307694ejb.248.1604499684911;
 Wed, 04 Nov 2020 06:21:24 -0800 (PST)
MIME-Version: 1.0
References: <CAN-5tyETQWVphrgqWjcPrtTzHHyz5DGrRz741yPYRS9Byyd=3Q@mail.gmail.com>
 <CAHC9VhRP2iJqLWiBg46zPKUqxzZoUOuaA6FPigxOw7qubophdw@mail.gmail.com>
 <CAN-5tyFq775PeOOzqskFexdbCgK3Gk_XB2Yy80SRYSc7Pdj=CA@mail.gmail.com>
 <CAHC9VhTzO1z6NmYz6cOLg5OvJiyQXdH_VmLh4=+h1MrGXx36JQ@mail.gmail.com>
 <CAN-5tyGJxUZb5QdJ=fh+L-6rc2B-MhQbDcDkTZNAZAAJm9Q8YQ@mail.gmail.com>
 <FB6C74CE-5D9F-4469-A49B-93CC8A51D7D5@gmail.com> <CAN-5tyFQbfkiuno07C6Azc7RcF3z3qF3PP0FutFMD3raBgnQmA@mail.gmail.com>
 <CAEjxPJ7PoAG6f+gVdodx=6X8+_Z_WCFXAuxnpB8WmC1gTF4iQQ@mail.gmail.com>
 <CAN-5tyEy57xoqEbZAThZKHriJywx-5DMKBD5tsXwo5ccGwuctw@mail.gmail.com>
 <CAHC9VhQpCXFySZY42==KR57hfAkVLdS6mSAcp2UHn-GWjEfVLg@mail.gmail.com>
 <bc766b2b-d1f1-d767-579c-02e10ae32a9a@schaufler-ca.com> <CAHC9VhS7UeCX9BXPrHNH90_sLHKGxTbbtjdm6GBOgDM9=T05FA@mail.gmail.com>
In-Reply-To: <CAHC9VhS7UeCX9BXPrHNH90_sLHKGxTbbtjdm6GBOgDM9=T05FA@mail.gmail.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Wed, 4 Nov 2020 09:21:14 -0500
Message-ID: <CAN-5tyF_JTMr4+05_YH2VQGft4aXXon3ZjuiVuOn-Z-DLVvTQg@mail.gmail.com>
Subject: Re: selinux: how to query if selinux is enabled
To:     Paul Moore <paul@paul-moore.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
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

On Wed, Oct 14, 2020 at 8:11 PM Paul Moore <paul@paul-moore.com> wrote:
>
> On Wed, Oct 14, 2020 at 12:31 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> > On 10/14/2020 8:57 AM, Paul Moore wrote:
> > > On Wed, Oct 14, 2020 at 10:37 AM Olga Kornievskaia <aglo@umich.edu> wrote:
> > >> On Tue, Oct 13, 2020 at 7:51 PM Stephen Smalley wrote:
> > >>> I would suggest either introducing a new hook for your purpose, or
> > >>> altering the existing one to support a form of query that isn't based
> > >>> on a particular xattr name but rather just checking whether the module
> > >>> supports/uses MAC labels at all.  Options: 1) NULL argument to the
> > >>> existing hook indicates a general query (could hide a bug in the
> > >>> caller, so not optimal), 2) Add a new bool argument to the existing
> > >>> hook to indicate whether the name should be used, or 3) Add a new hook
> > >>> that doesn't take any arguments.
> > >> Hi Stephen,
> > >>
> > >> Yes it seems like current api lacks the needed functionality and what
> > >> you are suggesting is needed. Thank you for confirming it.
> > > To add my two cents at this point, I would be in favor of a new LSM
> > > hook rather than hijacking security_ismaclabel().  It seems that every
> > > few years someone comes along and asks for a way to detect various LSM
> > > capabilities, this might be the right time to introduce a LSM API for
> > > this.
> > >
> > > My only concern about adding such an API is it could get complicated
> > > very quickly.  One nice thing we have going for us is that this is a
> > > kernel internal API so we don't have to worry about kernel/userspace
> > > ABI promises, if we decide we need to change the API at some point in
> > > the future we can do so without problem.  For that reason I'm going to
> > > suggest we do something relatively simple with the understanding that
> > > we can change it if/when the number of users grow.
> > >
> > > To start the discussion I might suggest the following:
> > >
> > > #define LSM_FQUERY_VFS_NONE     0x00000000
> > > #define LSM_FQUERY_VFS_XATTRS   0x00000001
> > > int security_func_query_vfs(unsigned int flags);
> > >
> > > ... with an example SELinux implementation looks like this:
> > >
> > > int selinux_func_query_vfs(unsigned int flags)
> > > {
> > >     return !!(flags & LSM_FQUERY_VFS_XATTRS);
> > > }
> >
> > Not a bad start, but I see optimizations and issues.
> >
> > It would be really easy to collect the LSM features at module
> > initialization by adding the feature flags to struct lsm_info.
> > We could maintain a variable lsm_features in security.c that
> > has the cumulative feature set. Rather than have an LSM hook for
> > func_query_vfs we'd get
> >
> > int security_func_query_vfs(void)
> > {
> >         return !!(lsm_features & LSM_FQUERY_VFS_XATTRS);
> > }
>
> Works for me.
>
> > In either case there could be confusion in the case where more
> > than one security module provides the feature. NFS, for example,
> > cares about the SELinux "selinux" attribute, but probably not
> > about the Smack "SMACK64EXEC" attribute. It's entirely possible
> > that a bit isn't enough information to check about a "feature".
>
> In the LSM stacking world that shouldn't matter to callers, right?  Or
> perhaps more correctly, if it matters to the caller which individual
> LSM supports what feature then the caller is doing it wrong, right?

Hi folks,

I would like to resurrect this discussion and sorry for a delayed
response. I'm a little bit unsure about the suggested approach of
adding something like selinux_func_query_vfs() call where selinux has
such a function. What happens when selinux is configured to be
"disabled" wouldn't this call still return the same value as when it
is configured as "permissive or enforcing"?

Thank you.



>
> --
> paul moore
> www.paul-moore.com
