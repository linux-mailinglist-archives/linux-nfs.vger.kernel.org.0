Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D444428E256
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Oct 2020 16:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbgJNOhj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 14 Oct 2020 10:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727875AbgJNOhi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 14 Oct 2020 10:37:38 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47628C061755;
        Wed, 14 Oct 2020 07:37:38 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id c22so5237781ejx.0;
        Wed, 14 Oct 2020 07:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WWQUs1iKiL0g+WuQeTob+uddOusmv5uTWIOTWJtZDHc=;
        b=k5J+g+KwT03/K1PomluP39o+tUilGk44BG0xTfzs3jHO+5lgUDz0elaz/0WlzMo8zj
         mV6lcGRRId/5lG9mh8l96zURAVT0xrwHoVUZuPBJO5Tj444U5jdMjNyB1kQOAcKB8mDU
         LImFQkhUAY1UGdUk3wTCLB1TV5jaatZt7juMqkpxoYxOHmoV05KjFAO3UX8bM1A89Um8
         TxAihmKrq/dgMZIrDUNzjEds4F7vxM9rkwe5sUxcVz46PhknsluYMrh1CDM8sdEm3v79
         lXi7FokpNEVBzriVI+Jok17g3Xn59D0hi3j3EIJsFSfTevGizGOV2t8Y1rLiiqTZEyN6
         HqmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WWQUs1iKiL0g+WuQeTob+uddOusmv5uTWIOTWJtZDHc=;
        b=o5/tL5kr+MGpSFeY9FUgo67nyc9QW8NZ9U972ToyN8f1CH8yuuxoSy7O05OQ5g5usw
         S6BgvRNO22XSOCyFNGBCkpTFgekqGGxSq8sEB9GNAmFHGrW7gMWgKuVZMVG818Jx4G47
         FK75FLVwlb6XtEP+/6IYtANVGACZ6qOPgRJhgxySzYS6ZHT3iDQx/dnbkwR5ziDjRzsP
         4OLjfqniUWt4xmPi+EZ2RogmtJ/huIjPRTFLC//0C7mFWTuF/4u+mvozpapAMLhbY++O
         jsb1XH8hZx+MpCbeWiBDRMhBtHYFuvnjSixR8PWFkm3hw4xDZl943NHX8Ac3kZGyUEIZ
         ZAEA==
X-Gm-Message-State: AOAM530XzwMVI5bpGPOmAKXpdh8sgbka/UdDVRbIgSiFIgo3tUZDYii1
        rN5oozl2mL0nhgt8LEBz//nIVzPU/dmrAqComUw=
X-Google-Smtp-Source: ABdhPJyoJT2DnvAYr186xONfeWoAVBGf9jXVT4NM0KNKlQmd7sC+AwDmDY/d+5amEclT/rVc5QxueLx/HujFttEzFcM=
X-Received: by 2002:a17:906:7013:: with SMTP id n19mr5582979ejj.388.1602686256864;
 Wed, 14 Oct 2020 07:37:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAN-5tyETQWVphrgqWjcPrtTzHHyz5DGrRz741yPYRS9Byyd=3Q@mail.gmail.com>
 <CAHC9VhRP2iJqLWiBg46zPKUqxzZoUOuaA6FPigxOw7qubophdw@mail.gmail.com>
 <CAN-5tyFq775PeOOzqskFexdbCgK3Gk_XB2Yy80SRYSc7Pdj=CA@mail.gmail.com>
 <CAHC9VhTzO1z6NmYz6cOLg5OvJiyQXdH_VmLh4=+h1MrGXx36JQ@mail.gmail.com>
 <CAN-5tyGJxUZb5QdJ=fh+L-6rc2B-MhQbDcDkTZNAZAAJm9Q8YQ@mail.gmail.com>
 <FB6C74CE-5D9F-4469-A49B-93CC8A51D7D5@gmail.com> <CAN-5tyFQbfkiuno07C6Azc7RcF3z3qF3PP0FutFMD3raBgnQmA@mail.gmail.com>
 <CAEjxPJ7PoAG6f+gVdodx=6X8+_Z_WCFXAuxnpB8WmC1gTF4iQQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ7PoAG6f+gVdodx=6X8+_Z_WCFXAuxnpB8WmC1gTF4iQQ@mail.gmail.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Wed, 14 Oct 2020 10:37:26 -0400
Message-ID: <CAN-5tyEy57xoqEbZAThZKHriJywx-5DMKBD5tsXwo5ccGwuctw@mail.gmail.com>
Subject: Re: selinux: how to query if selinux is enabled
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Chuck Lever <chucklever@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Oct 13, 2020 at 7:51 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, Oct 9, 2020 at 12:36 PM Olga Kornievskaia <aglo@umich.edu> wrote:
> >
> > On Fri, Oct 9, 2020 at 10:08 AM Chuck Lever <chucklever@gmail.com> wrote:
> > >
> > >
> > >
> > > > On Oct 9, 2020, at 7:49 AM, Olga Kornievskaia <aglo@umich.edu> wrote:
> > > >
> > > > On Thu, Oct 8, 2020 at 9:03 PM Paul Moore <paul@paul-moore.com> wrote:
> > > >>
> > > >> ->On Thu, Oct 8, 2020 at 9:50 AM Olga Kornievskaia <aglo@umich.edu> wrote:
> > > >>> On Wed, Oct 7, 2020 at 9:07 PM Paul Moore <paul@paul-moore.com> wrote:
> > > >>>> On Wed, Oct 7, 2020 at 8:41 PM Olga Kornievskaia <aglo@umich.edu> wrote:
> > > >>>>> Hi folks,
> > > >>>>>
> > > >>>>> From some linux kernel module, is it possible to query and find out
> > > >>>>> whether or not selinux is currently enabled or not?
> > > >>>>>
> > > >>>>> Thank you.
> > > >>>>
> > > >>>> [NOTE: CC'ing the SELinux list as it's probably a bit more relevant
> > > >>>> that the LSM list]
> > > >>>>
> > > >>>> In general most parts of the kernel shouldn't need to worry about what
> > > >>>> LSMs are active and/or enabled; the simply interact with the LSM(s)
> > > >>>> via the interfaces defined in include/linux/security.h (there are some
> > > >>>> helpful comments in include/linux/lsm_hooks.h).  Can you elaborate a
> > > >>>> bit more on what you are trying to accomplish?
> > > >>>
> > > >>> Hi Paul,
> > > >>>
> > > >>> Thank you for the response. What I'm trying to accomplish is the
> > > >>> following. Within a file system (NFS), typically any queries for
> > > >>> security labels are triggered by the SElinux (or I guess an LSM in
> > > >>> general) (thru the xattr_handler hooks). However, when the VFS is
> > > >>> calling to get directory entries NFS will always get the labels
> > > >>> (baring server not supporting it). However this is useless and affects
> > > >>> performance (ie., this makes servers do extra work  and adds to the
> > > >>> network traffic) when selinux is disabled. It would be useful if NFS
> > > >>> can check if there is anything that requires those labels, if SElinux
> > > >>> is enabled or disabled.
> > > >>
> > > >> [Adding Chuck Lever to the CC line as I believe he has the most recent
> > > >> LSM experience from the NFS side - sorry Chuck :)]
> > > >>
> > > >> I'll need to ask your patience on this as I am far from a NFS expert.
> > > >>
> > > >> Looking through the NFS readdir/getdents code this evening, I was
> > > >> wondering if the solution in the readdir case is to simply tell the
> > > >> server you are not interested in the security label by masking out
> > > >> FATTR4_WORD2_SECURITY_LABEL in the nfs4_readdir_arg->bitmask in
> > > >> _nfs4_proc_readdir()?  Of course this assumes that the security label
> > > >> genuinely isn't needed in this case (and not requesting it doesn't
> > > >> bypass access controls or break something on the server side), and we
> > > >> don't screw up some NFS client side cache by *not* fetching the
> > > >> security label attribute.
> > > >>
> > > >> Is this remotely close to workable, or am I missing something fundamental?
> > > >>
> > > >
> > > > No this is not going to work, as NFS requires labels when labels are
> > > > indeed needed by the LSM. What I'm looking for is an optimization.
> > > > What we have is functionality correct but performance might suffer for
> > > > the standard case of NFSv4.2 seclabel enabled server and clients that
> > > > don't care about seclabels.
> > >
> > > Initial thought: We should ask linux-nfs for help with this.
> > > I've added them to the Cc: list.
> > >
> > > Olga, are you asking if the kernel NFS client module can somehow find
> > > out whether the rest of the kernel is configured to care about security
> > > labels before it forms an NFSv4 READDIR or LOOKUP request?
> >
> > Yes exactly, but I'm having a hard time trying to figure out how to
> > use security_ismaclabel() function as has been suggested by Casey.
>
> I would suggest either introducing a new hook for your purpose, or
> altering the existing one to support a form of query that isn't based
> on a particular xattr name but rather just checking whether the module
> supports/uses MAC labels at all.  Options: 1) NULL argument to the
> existing hook indicates a general query (could hide a bug in the
> caller, so not optimal), 2) Add a new bool argument to the existing
> hook to indicate whether the name should be used, or 3) Add a new hook
> that doesn't take any arguments.

Hi Stephen,

Yes it seems like current api lacks the needed functionality and what
you are suggesting is needed. Thank you for confirming it.

>
> >
> > > I would certainly like to take the security label query out of every
> > > LOOKUP operation if that is feasible!
> >
> > A LOOKUP doesn't add the seclabel query (by default) like READDIR does
> > (it's hard-coded in the xdr code). LOOKUP uses server's bitmask and
> > chooses the version without the seclabel bitmask because no label is
> > passed into it. It looks like LOOKUP just allocates a label in
> > nfs_lookup_revalidate_dentry().  So it's not driven by the something
> > that I see used by the xattr_handle example in the NFS code.
