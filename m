Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 603702A6B50
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Nov 2020 18:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731283AbgKDRC6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 4 Nov 2020 12:02:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731513AbgKDRC5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 4 Nov 2020 12:02:57 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1349C0613D4
        for <linux-nfs@vger.kernel.org>; Wed,  4 Nov 2020 09:02:55 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id gn41so13486404ejc.4
        for <linux-nfs@vger.kernel.org>; Wed, 04 Nov 2020 09:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x2M/mARoDzrcfFFiwEe2r6gawenXxInWJUsbPLXI4aU=;
        b=M7sTa4A3JZbX13eK8mgywZ5kdDjq33XlU/mpL1bHzx7FoLS3ztmx9M9jWTjyj1wfCe
         s4N1kwTO9+A0wg+7pPU5k95P7JqFWQN1hHzwrzWO+IpYNzYRFmYpzZAv5Kc5wjJia+wl
         65vkjtjKE6b52MBX9xVcDRMRdlWj1Rw1clG+312fBrHk5k1tlLpWaibkbe2Z5Kqpq9+U
         1EZn6bUY51uaVkjJtrchPAq6GJ7mOhY5N4M7DLhxQhxcPoiQ2VEJ6rrKF/Pj/PyAOW/z
         lhhpy5AWmnZvME8LvXYIzSHyoaFgMnW45UfjiBWxz0X/tpkmusE8zKDNuh8d4jjde4Bg
         v8Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x2M/mARoDzrcfFFiwEe2r6gawenXxInWJUsbPLXI4aU=;
        b=cT+ZyTHXI/kDjr3dO7iYAr+HxSYAuu8pSR/NeO1Rf5twokLypJnDhwl/UIqQJKEX4x
         e2DmUaFK6f8wNTsozfCxcweOiZgnEMdDKUd8v/dvMfrRFPHo1ah6PXqDiGdsI8sbj9JK
         CDtJRDYqJKt42Ojk5NkHRU49M6QreVglGC4BJeT8XIi19lJ1hswzL+FGNJpGXZblyy1y
         pMZDA2Qx2YG8VA322Hj/ScS4wlyz2iSyyAD7bvtbNymlOrKyz1cGU6XdgwH5jtHHYmRF
         4eAIBGN/2MjDd816DFpBh4LLhSmvMILvVgb3STXUpAnt4dUoH7lKTtw9j4CgCI3wWunQ
         yH2g==
X-Gm-Message-State: AOAM531DBokLCPi1XT6fNoKQRcHhK5AGWVqnwugXtG4KDiajVtDw/tzo
        qc67ctAzZFZr1MRiCzbq9G2VObSKAawWnKLhi9kN
X-Google-Smtp-Source: ABdhPJwnz1UtFa7ZfNIrVWs1o+Tvv5+b2V30m/yWN9QZtdmkerlPloaXcjzTHxCBxaQbBdQJ58kX093S2c9nCvxtPDo=
X-Received: by 2002:a17:906:1159:: with SMTP id i25mr5847474eja.398.1604509374270;
 Wed, 04 Nov 2020 09:02:54 -0800 (PST)
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
 <CAN-5tyF_JTMr4+05_YH2VQGft4aXXon3ZjuiVuOn-Z-DLVvTQg@mail.gmail.com>
In-Reply-To: <CAN-5tyF_JTMr4+05_YH2VQGft4aXXon3ZjuiVuOn-Z-DLVvTQg@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 4 Nov 2020 12:02:41 -0500
Message-ID: <CAHC9VhQgJ93LrEFBBJ-kz8C9b4RukODzRRRJVKgwGEL8jPVZaQ@mail.gmail.com>
Subject: Re: selinux: how to query if selinux is enabled
To:     Olga Kornievskaia <aglo@umich.edu>
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

On Wed, Nov 4, 2020 at 9:21 AM Olga Kornievskaia <aglo@umich.edu> wrote:
> On Wed, Oct 14, 2020 at 8:11 PM Paul Moore <paul@paul-moore.com> wrote:
> > On Wed, Oct 14, 2020 at 12:31 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> > > On 10/14/2020 8:57 AM, Paul Moore wrote:
> > > > On Wed, Oct 14, 2020 at 10:37 AM Olga Kornievskaia <aglo@umich.edu> wrote:
> > > >> On Tue, Oct 13, 2020 at 7:51 PM Stephen Smalley wrote:

...

> > > > To start the discussion I might suggest the following:
> > > >
> > > > #define LSM_FQUERY_VFS_NONE     0x00000000
> > > > #define LSM_FQUERY_VFS_XATTRS   0x00000001
> > > > int security_func_query_vfs(unsigned int flags);
> > > >
> > > > ... with an example SELinux implementation looks like this:
> > > >
> > > > int selinux_func_query_vfs(unsigned int flags)
> > > > {
> > > >     return !!(flags & LSM_FQUERY_VFS_XATTRS);
> > > > }
> > >
> > > Not a bad start, but I see optimizations and issues.
> > >
> > > It would be really easy to collect the LSM features at module
> > > initialization by adding the feature flags to struct lsm_info.
> > > We could maintain a variable lsm_features in security.c that
> > > has the cumulative feature set. Rather than have an LSM hook for
> > > func_query_vfs we'd get
> > >
> > > int security_func_query_vfs(void)
> > > {
> > >         return !!(lsm_features & LSM_FQUERY_VFS_XATTRS);
> > > }
> >
> > Works for me.
> >
> > > In either case there could be confusion in the case where more
> > > than one security module provides the feature. NFS, for example,
> > > cares about the SELinux "selinux" attribute, but probably not
> > > about the Smack "SMACK64EXEC" attribute. It's entirely possible
> > > that a bit isn't enough information to check about a "feature".
> >
> > In the LSM stacking world that shouldn't matter to callers, right?  Or
> > perhaps more correctly, if it matters to the caller which individual
> > LSM supports what feature then the caller is doing it wrong, right?
>
> Hi folks,
>
> I would like to resurrect this discussion and sorry for a delayed
> response. I'm a little bit unsure about the suggested approach of
> adding something like selinux_func_query_vfs() call where selinux has
> such a function. What happens when selinux is configured to be
> "disabled" wouldn't this call still return the same value as when it
> is configured as "permissive or enforcing"?

Hello again.

To start, the non-LSM portion of the kernel shouldn't be calling
selinux_func_query_vfs() directly, it should call
security_func_query_vfs(); it would be up to the individual LSMs to
indicate to the LSM hooks layer what is required.  If SELinux wasn't
built into the kernel, or was disabled at boot, I would expect that
the security_func_query_vfs() function would adjust to exclude the
SELinux requirements.

-- 
paul moore
www.paul-moore.com
