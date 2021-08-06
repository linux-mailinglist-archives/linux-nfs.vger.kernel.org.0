Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAA0C3E248B
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Aug 2021 09:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240830AbhHFHw3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 6 Aug 2021 03:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241355AbhHFHw2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 6 Aug 2021 03:52:28 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74FADC06179A
        for <linux-nfs@vger.kernel.org>; Fri,  6 Aug 2021 00:52:13 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id bg4so4691133vsb.6
        for <linux-nfs@vger.kernel.org>; Fri, 06 Aug 2021 00:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B9Mx6FUSysA8MLwLdNNR3QTzovVkEjBB6X0ikf8q3Pc=;
        b=Iu2eSsj9w7Hgnsy81F8tI3U6TyXrFGwKXBDZGvoZTDwZy7ZF8H3ebxcow/3FxtydF5
         9fMGelET7p3YYC9b/u94E6xkz+Z6g5hEXy7Lr5rJsBGP6Vehy370KnrnDS8A9Cktp3aI
         T5buRGtXpZ77Pp/BmRTZlq637tB29CeJUp5KU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B9Mx6FUSysA8MLwLdNNR3QTzovVkEjBB6X0ikf8q3Pc=;
        b=EldOOqaSTYKfMhx1ZvbgyY6oT9YpFzdnpKJF3Z7cUHe6Lab6n6i/iOT1XJeiaD3amQ
         H1gYQQR57E1CXTd87SMkSbDa0u1aKtq5tTy5nw8CVfHoOebKaCI8pvW/oAZ1Ul4w8//4
         F524H0zTh6doID7PWZV59r/IPhG6fUt1I9/+UE7eVf79B2kewWqMrVWUJwH7TstEBuDb
         LIQ8VzRyL88H4+QhzuRqnnkgEtLbF6JoAC1ydFj/mVTYjnbEsQ+PZStSJ33LP/PVZrlG
         qRIF2T+YoC8Hg5JJrWP43MiC0DiOucs4s85sWCvsYMnRb+Ho2AKqHx4XJ69/mAgPas/l
         ac+g==
X-Gm-Message-State: AOAM530fdwDlLMLZhsgBJzz+lRdAXedA3Fyxshtv4G9pkFz9EH0j9B7s
        MeKtnYo5jVnK/1qaFmyaWQm/aXnCjI2HI7KMI9hx0A==
X-Google-Smtp-Source: ABdhPJxH7DKI62ekt2JL2r3/Idizp8Tts/YooL7kxDugTvIL0u3sdovZtVR+qvxIcidlqORqkS4VUQPBHWVr5hWGhgM=
X-Received: by 2002:a67:ef96:: with SMTP id r22mr6532458vsp.21.1628236332608;
 Fri, 06 Aug 2021 00:52:12 -0700 (PDT)
MIME-Version: 1.0
References: <162742539595.32498.13687924366155737575.stgit@noble.brown>
 <162742546554.32498.9309110546560807513.stgit@noble.brown>
 <CAOQ4uxjXcVE=4K+3uSYXLsvGgi0o7Nav=DsV=0qG_DanjXB18Q@mail.gmail.com>
 <162751852209.21659.13294658501847453542@noble.neil.brown.name> <CAOQ4uxj9DW2SHqWCMXy4oRdazbODMhtWeyvNsKJm__0fuuspyQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxj9DW2SHqWCMXy4oRdazbODMhtWeyvNsKJm__0fuuspyQ@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 6 Aug 2021 09:52:01 +0200
Message-ID: <CAJfpeguoMjCvLpKHgtQmNFk4UsHdyLsWK4bvsv6YJ52uZ=+9gg@mail.gmail.com>
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

On Thu, 29 Jul 2021 at 07:27, Amir Goldstein <amir73il@gmail.com> wrote:

> Given that today, subvolume mounts (or any mounts) on the lower layer
> are not followed by overlayfs, I don't really see the difference
> if mounts are created manually or automatically.
> Miklos?

Never tried overlay on btrfs.  Subvolumes AFAIK do not use submounts
currently, they are a sort of hack where the st_dev changes when
crossing the subvolume boundary, but there's no sign of them in
/proc/mounts (there's no d_automount in btrfs).

Thanks,
Miklos
