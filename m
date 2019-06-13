Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5EB44011
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2019 18:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391004AbfFMQCp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 13 Jun 2019 12:02:45 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:34142 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390289AbfFMQCo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 13 Jun 2019 12:02:44 -0400
Received: by mail-vs1-f67.google.com with SMTP id q64so12981548vsd.1
        for <linux-nfs@vger.kernel.org>; Thu, 13 Jun 2019 09:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DIkB/dcUV6AQ5Y/LmFnalLKzVJRQj6rElsJVosogalA=;
        b=aJSW8euWsUG1zhBjQBD9w5oqlu4a5pwYz7r4QrTFai+fap1RrjRawyeYySWPG9NGlx
         lCnxep5loDhWwoKJAFFw3oTXFFeg8IK/UGn1TUQimghRMRhKDXnMZY1KYLBGvjTgsS57
         x8Td8Vp2mGSlDS5ln2r2bRdHwXV8Lwb28uzybRlTLbaaloKrZhIgekU8PwTNbNqh4HMh
         S+z4au45iR9kgQt6DJVDLwrw9HubMrQXFh9GNkuJIztxvLrQfdw2n7RdEm94bJkjbgGU
         Wx5MbxPOAz+x2D7ENJdM5bAG6rCiPPlNFedfsjTKXjtPMiihrb0wv07tqDMlVZL4GQnX
         anUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DIkB/dcUV6AQ5Y/LmFnalLKzVJRQj6rElsJVosogalA=;
        b=BHfgcR9hVKnYWoXneEn7JUbC+kymbLbHQRnMKjaWg9RSYQVjL9dWsRTXhPnQNLHFsI
         sLsdRhPrwGvODftScHR8ALAY4zq8OkoFRo+Pzvsf+y9++ViK1p0JMabCdhdyZGUEuGGy
         wx/PhIuufPsY+7XcUw+yxwVS4QyKWTzO2ekRQJodFgvhlHwndK2GezZ8hgFIXVpcyJA/
         LqrL9IJvA7VU84QTml+riX2ae4xDjBsYizcNcV9PVmdZBmqLDQHy3YfsoNhtSdvqVybM
         j2hjZYJwfmuwcOVbaaggj3XkK8+sCLH5hegHrgVhrkRd2+GMDO8JqHwwwbVZzNrt9EO3
         lYHw==
X-Gm-Message-State: APjAAAVKR+9PUvUJeDF+/ijWXBmCAD+yZCoi7l1XfPpZrG9GrYMObDw7
        1EDifLPZvdbun4yFdZUUcvEmFyB3OaOEMuidN+4=
X-Google-Smtp-Source: APXvYqxrw38bMsMaVJNLQWvxYGSFS/BTWJB7fllmeP0KFjoX+JfhWwavK3zXF+BK9GC/iz7eDQZpCvfh/0z0AsYOsKg=
X-Received: by 2002:a67:dc1:: with SMTP id 184mr17168191vsn.164.1560441763607;
 Thu, 13 Jun 2019 09:02:43 -0700 (PDT)
MIME-Version: 1.0
References: <bcb2d38fe9c9bb15aeb9baa811aeb9a8697ea141.1560348835.git.bcodding@redhat.com>
 <20190613145149.GD2145@fieldses.org>
In-Reply-To: <20190613145149.GD2145@fieldses.org>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Thu, 13 Jun 2019 12:02:32 -0400
Message-ID: <CAN-5tyFzGGFhuFriN=a-U8X1r-A9+q1V6V4XQM_tmbUdFPyFxg@mail.gmail.com>
Subject: Re: [PATCH] NFS: Don't skip lookup when holding a delegation
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Benjamin Coddington <bcodding@redhat.com>,
        trond.myklebust@hammerspace.com,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Jun 13, 2019 at 11:00 AM J. Bruce Fields <bfields@fieldses.org> wrote:
>
> On Wed, Jun 12, 2019 at 10:45:13AM -0400, Benjamin Coddington wrote:
> > If we skip lookup revalidation while holding a delegation, we might miss
> > that the file has changed directories on the server.
>
> The delegation should prevent the file disappearing from this directory,
> so if I've been following the discussion, the bug was due to overlooking
> the case where the change happened before we got the delegation.  Given
> that history it seems worth calling out that case specifically?
>
> Maybe a comment along the lines of:
>
>                 /*
>                  * Note that the file can't move while we hold a
>                  * delegation.  But this dentry could have been cached
>                  * before we got a delegation.  So it's only safe to
>                  * skip revalidation when the parent directory is
>                  * unchanged:
>                  */
>
> But maybe there's a pithier way to say that.

What is preventing the file from disappearing from the directory while
holding the delegation: is it the server's responsibility to recall
the delegation when it gets a move or is it client's responsibility
not to rely on the cached attributes?

According to this patch it's client's responsibility, in the case, I
find the working " file can't move" confusing as they imply to me that
client can assume file isn't moved (ie, server will prevent it from
happening).

>
> --b.
>
> > The directory's
> > change attribute should still be checked against the dentry's d_time to
> > perform a complete revalidation.
> >
> > Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
> > ---
> >  fs/nfs/dir.c | 10 ++++------
> >  1 file changed, 4 insertions(+), 6 deletions(-)
> >
> > diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
> > index a71d0b42d160..10cc684dc082 100644
> > --- a/fs/nfs/dir.c
> > +++ b/fs/nfs/dir.c
> > @@ -1269,12 +1269,13 @@ nfs_do_lookup_revalidate(struct inode *dir, struct dentry *dentry,
> >               goto out_bad;
> >       }
> >
> > -     if (NFS_PROTO(dir)->have_delegation(inode, FMODE_READ))
> > -             return nfs_lookup_revalidate_delegated(dir, dentry, inode);
> > -
> >       /* Force a full look up iff the parent directory has changed */
> >       if (!(flags & (LOOKUP_EXCL | LOOKUP_REVAL)) &&
> >           nfs_check_verifier(dir, dentry, flags & LOOKUP_RCU)) {
> > +
> > +             if (NFS_PROTO(dir)->have_delegation(inode, FMODE_READ))
> > +                     return nfs_lookup_revalidate_delegated(dir, dentry, inode);
> > +
> >               error = nfs_lookup_verify_inode(inode, flags);
> >               if (error) {
> >                       if (error == -ESTALE)
> > @@ -1707,9 +1708,6 @@ nfs4_do_lookup_revalidate(struct inode *dir, struct dentry *dentry,
> >       if (inode == NULL)
> >               goto full_reval;
> >
> > -     if (NFS_PROTO(dir)->have_delegation(inode, FMODE_READ))
> > -             return nfs_lookup_revalidate_delegated(dir, dentry, inode);
> > -
> >       /* NFS only supports OPEN on regular files */
> >       if (!S_ISREG(inode->i_mode))
> >               goto full_reval;
> > --
> > 2.20.1
