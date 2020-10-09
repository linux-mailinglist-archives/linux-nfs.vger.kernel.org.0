Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4719B288EF9
	for <lists+linux-nfs@lfdr.de>; Fri,  9 Oct 2020 18:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389820AbgJIQdd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 9 Oct 2020 12:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389818AbgJIQdd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 9 Oct 2020 12:33:33 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B00DC0613D2;
        Fri,  9 Oct 2020 09:33:33 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id p15so13953985ejm.7;
        Fri, 09 Oct 2020 09:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lG0OSVPziKHc6Mg8l0qWbO9mcnKpzSjXHAItvjG7zj4=;
        b=ncQeW3RzLPsOjh8Uhi68eGc6A/wMRysr5879vD9BwOYq3KJnaqFEwpI8FHYHe3EryP
         nWG5GmBsV0im+RukgzDrrwtnNGCwGos0jxJZsDOd5kBYTNriCNGdYv43xQZZYF6dmPbD
         4nmuOKmtX4aggqYS3p6cCfmWFk9ojyYzUov3r7RNrvBtrB8VGnty7lz1F6yz/7Cg0OYr
         a9MdCmkgSWr5Rk14t9ip0+mRS9vPPeEtK/lZGWAvneppmax6+J7W2a2sM/22DMoqiAJR
         cv9NmG8qoA9FbO6DUh8TYX5a1PgDV8avkVEE5BH5rv/mC4sWD/k/6j+v4T1v2IkUyM2Y
         oJDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lG0OSVPziKHc6Mg8l0qWbO9mcnKpzSjXHAItvjG7zj4=;
        b=GKHRqzFEwHhy/Ioh18LhTKn/Bkd2ZFhD24JQB7p6U0s0SsD79bu5aiHIo/LnUnUsBN
         splOr7Sn8N+JeK1/mFLz1X364MDCFt4WpvCdGPFWUUCtvJOLPVk6U36TKJSv5nuEw4jz
         ZiM6hIresKSP2kJAcj5v8seba0+sYqIGImgbtOM+hDRCuyPT6vbdVToW2GJMkU2eDUXK
         m1nQ+eheoGCAzZPBGQzE4cpm0e+mFGDrk4mbMCfrUDa/VYgFQ3H4yrldZwoZDadK28YW
         WBS2CRVaP700Xl2UvwY2/MBE5ke6iI6MLsecLqDt+L5V9BKDo51gseTaDfSNOcMcOdcW
         6baw==
X-Gm-Message-State: AOAM531rhtgvhQ3+behcfsR5ZPelN5qKDsaazi5//XrEsmz4eGLRVHxk
        Gz5b6PdvGN6x7sUd0VYoQeoMFzfRUsnCTBCvAw9j0SGQTK8=
X-Google-Smtp-Source: ABdhPJwMvP2opYbBt9kjj+djsM+tt6K/ZHC7rt2EBXtuJyoTsue9zBicHFs0klzUUux+SkNHHMTZ2G4gncDfX+TdZ9M=
X-Received: by 2002:a17:906:9701:: with SMTP id k1mr16071264ejx.0.1602261211981;
 Fri, 09 Oct 2020 09:33:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAN-5tyETQWVphrgqWjcPrtTzHHyz5DGrRz741yPYRS9Byyd=3Q@mail.gmail.com>
 <CAHC9VhRP2iJqLWiBg46zPKUqxzZoUOuaA6FPigxOw7qubophdw@mail.gmail.com>
 <CAN-5tyFq775PeOOzqskFexdbCgK3Gk_XB2Yy80SRYSc7Pdj=CA@mail.gmail.com>
 <CAHC9VhTzO1z6NmYz6cOLg5OvJiyQXdH_VmLh4=+h1MrGXx36JQ@mail.gmail.com>
 <CAN-5tyGJxUZb5QdJ=fh+L-6rc2B-MhQbDcDkTZNAZAAJm9Q8YQ@mail.gmail.com> <FB6C74CE-5D9F-4469-A49B-93CC8A51D7D5@gmail.com>
In-Reply-To: <FB6C74CE-5D9F-4469-A49B-93CC8A51D7D5@gmail.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Fri, 9 Oct 2020 12:33:20 -0400
Message-ID: <CAN-5tyFQbfkiuno07C6Azc7RcF3z3qF3PP0FutFMD3raBgnQmA@mail.gmail.com>
Subject: Re: selinux: how to query if selinux is enabled
To:     Chuck Lever <chucklever@gmail.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Oct 9, 2020 at 10:08 AM Chuck Lever <chucklever@gmail.com> wrote:
>
>
>
> > On Oct 9, 2020, at 7:49 AM, Olga Kornievskaia <aglo@umich.edu> wrote:
> >
> > On Thu, Oct 8, 2020 at 9:03 PM Paul Moore <paul@paul-moore.com> wrote:
> >>
> >> ->On Thu, Oct 8, 2020 at 9:50 AM Olga Kornievskaia <aglo@umich.edu> wrote:
> >>> On Wed, Oct 7, 2020 at 9:07 PM Paul Moore <paul@paul-moore.com> wrote:
> >>>> On Wed, Oct 7, 2020 at 8:41 PM Olga Kornievskaia <aglo@umich.edu> wrote:
> >>>>> Hi folks,
> >>>>>
> >>>>> From some linux kernel module, is it possible to query and find out
> >>>>> whether or not selinux is currently enabled or not?
> >>>>>
> >>>>> Thank you.
> >>>>
> >>>> [NOTE: CC'ing the SELinux list as it's probably a bit more relevant
> >>>> that the LSM list]
> >>>>
> >>>> In general most parts of the kernel shouldn't need to worry about what
> >>>> LSMs are active and/or enabled; the simply interact with the LSM(s)
> >>>> via the interfaces defined in include/linux/security.h (there are some
> >>>> helpful comments in include/linux/lsm_hooks.h).  Can you elaborate a
> >>>> bit more on what you are trying to accomplish?
> >>>
> >>> Hi Paul,
> >>>
> >>> Thank you for the response. What I'm trying to accomplish is the
> >>> following. Within a file system (NFS), typically any queries for
> >>> security labels are triggered by the SElinux (or I guess an LSM in
> >>> general) (thru the xattr_handler hooks). However, when the VFS is
> >>> calling to get directory entries NFS will always get the labels
> >>> (baring server not supporting it). However this is useless and affects
> >>> performance (ie., this makes servers do extra work  and adds to the
> >>> network traffic) when selinux is disabled. It would be useful if NFS
> >>> can check if there is anything that requires those labels, if SElinux
> >>> is enabled or disabled.
> >>
> >> [Adding Chuck Lever to the CC line as I believe he has the most recent
> >> LSM experience from the NFS side - sorry Chuck :)]
> >>
> >> I'll need to ask your patience on this as I am far from a NFS expert.
> >>
> >> Looking through the NFS readdir/getdents code this evening, I was
> >> wondering if the solution in the readdir case is to simply tell the
> >> server you are not interested in the security label by masking out
> >> FATTR4_WORD2_SECURITY_LABEL in the nfs4_readdir_arg->bitmask in
> >> _nfs4_proc_readdir()?  Of course this assumes that the security label
> >> genuinely isn't needed in this case (and not requesting it doesn't
> >> bypass access controls or break something on the server side), and we
> >> don't screw up some NFS client side cache by *not* fetching the
> >> security label attribute.
> >>
> >> Is this remotely close to workable, or am I missing something fundamental?
> >>
> >
> > No this is not going to work, as NFS requires labels when labels are
> > indeed needed by the LSM. What I'm looking for is an optimization.
> > What we have is functionality correct but performance might suffer for
> > the standard case of NFSv4.2 seclabel enabled server and clients that
> > don't care about seclabels.
>
> Initial thought: We should ask linux-nfs for help with this.
> I've added them to the Cc: list.
>
> Olga, are you asking if the kernel NFS client module can somehow find
> out whether the rest of the kernel is configured to care about security
> labels before it forms an NFSv4 READDIR or LOOKUP request?

Yes exactly, but I'm having a hard time trying to figure out how to
use security_ismaclabel() function as has been suggested by Casey.

> I would certainly like to take the security label query out of every
> LOOKUP operation if that is feasible!

A LOOKUP doesn't add the seclabel query (by default) like READDIR does
(it's hard-coded in the xdr code). LOOKUP uses server's bitmask and
chooses the version without the seclabel bitmask because no label is
passed into it. It looks like LOOKUP just allocates a label in
nfs_lookup_revalidate_dentry().  So it's not driven by the something
that I see used by the xattr_handle example in the NFS code.

>
>
> --
> Chuck Lever
> chucklever@gmail.com
>
>
>
