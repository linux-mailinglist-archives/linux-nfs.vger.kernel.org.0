Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD48A3E2610
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Aug 2021 10:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244560AbhHFI0n (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 6 Aug 2021 04:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244106AbhHFIZ7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 6 Aug 2021 04:25:59 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 150BAC0619C0
        for <linux-nfs@vger.kernel.org>; Fri,  6 Aug 2021 01:18:31 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id d6so3292501uav.2
        for <linux-nfs@vger.kernel.org>; Fri, 06 Aug 2021 01:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oRINHIhGfpdECjbAWjxe8NCFfhDC/n86ssJULKDPhmA=;
        b=OvVgEpKzEDMU8cgihSAEKuEjP5IfZ8rbtWlFLdngFqtrTL5fK1CX0NS4xQj++RKSVB
         yVez7hdiedBIpuLGnZoKY5PPD4mryOnVQh31czsX1KY5p84kn/zeyXojCmSM2Dkqw1jz
         xAZyFZz7o/659lHhsG5JSIw1m3Pz+HLGSd6kw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oRINHIhGfpdECjbAWjxe8NCFfhDC/n86ssJULKDPhmA=;
        b=AmMrvLGDbUbxWl8HEFMEEJ4kRm1lQhnZo2CcOkfMg0BrTUv8HiDzsjczf2DGa5A8W0
         Iar7vZy/cmvkiYrCcpYuyf3GdkCZOd/J0W/5Sx48JmMP2zABRV8Sxc6SDhCf8pqIZceN
         lckQW3Fpyj22CGE/qU0/Amjt87AjxHSvOKPqHpGCIi7lTEnUfXU/JIj8oh1hBhyHeiNF
         EhX46tgcCpLLQHqYfnhpELtVuKRqP2rkaT6cPehI44u3fEFl9b/nXEOeM+2PWufObyYG
         7vCVxBbkmTphbBZ8uoqZBtY7BqSJ4tuBDfrcbnFwJn8QByODi/tJCyiFJOEL0jYmb00S
         FlTg==
X-Gm-Message-State: AOAM53396w5XWqOetZpmEANa3ic9dCpmptiQufLx7fU/S16ers3a8R41
        rVh/naXExAvsDPvju/k3QsmSAm9CkTNmoKgIb8kQWQ==
X-Google-Smtp-Source: ABdhPJwNHoJAQK2vyoS6CI4mikJ6sKLtxvgwY+3QqhxnrCcHZcmZAhSUiHUKQcB0A6vLxde6qR99BdAABMh7bTKc0/A=
X-Received: by 2002:ab0:36af:: with SMTP id v15mr7156096uat.8.1628237910214;
 Fri, 06 Aug 2021 01:18:30 -0700 (PDT)
MIME-Version: 1.0
References: <162742539595.32498.13687924366155737575.stgit@noble.brown>
 <162742546554.32498.9309110546560807513.stgit@noble.brown>
 <CAOQ4uxjXcVE=4K+3uSYXLsvGgi0o7Nav=DsV=0qG_DanjXB18Q@mail.gmail.com>
 <162751852209.21659.13294658501847453542@noble.neil.brown.name>
 <CAOQ4uxj9DW2SHqWCMXy4oRdazbODMhtWeyvNsKJm__0fuuspyQ@mail.gmail.com>
 <CAJfpeguoMjCvLpKHgtQmNFk4UsHdyLsWK4bvsv6YJ52uZ=+9gg@mail.gmail.com> <CAOQ4uxiAcqXYNhG9ZGU4=7oY9idEwa9FND-VVdLgGO2RoXr6qg@mail.gmail.com>
In-Reply-To: <CAOQ4uxiAcqXYNhG9ZGU4=7oY9idEwa9FND-VVdLgGO2RoXr6qg@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 6 Aug 2021 10:18:19 +0200
Message-ID: <CAJfpegtOLgJO9VPpyHS0PB8JSeHjZ8aMwa0fMGrcRFsB8CTUJg@mail.gmail.com>
Subject: Re: [PATCH 07/11] exportfs: Allow filehandle lookup to cross internal
 mount points.
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     NeilBrown <neilb@suse.de>, Christoph Hellwig <hch@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 6 Aug 2021 at 10:08, Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Fri, Aug 6, 2021 at 10:52 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> > On Thu, 29 Jul 2021 at 07:27, Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > > Given that today, subvolume mounts (or any mounts) on the lower layer
> > > are not followed by overlayfs, I don't really see the difference
> > > if mounts are created manually or automatically.
> > > Miklos?
> >
> > Never tried overlay on btrfs.  Subvolumes AFAIK do not use submounts
> > currently, they are a sort of hack where the st_dev changes when
> > crossing the subvolume boundary, but there's no sign of them in
> > /proc/mounts (there's no d_automount in btrfs).
>
> That's what Niel's patch 11/11 is proposing to add and that's the reason
> he was asking if this is going to break overlayfs over btrfs.
>
> My question was, regardless of btrfs, can ovl_lookup() treat automount
> dentries gracefully as empty dirs or just read them as is, instead of
> returning EREMOTE on lookup?
>
> The rationale is that we use a private mount and we are not following
> across mounts from layers anyway, so what do we care about
> auto or manual mounts?

I guess that depends on the use cases.  If no one cares (as is the
case apparently), the simplest is to leave it the way it is.

Thanks,
Miklos
