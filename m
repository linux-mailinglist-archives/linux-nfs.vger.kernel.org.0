Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD136E616C
	for <lists+linux-nfs@lfdr.de>; Sun, 27 Oct 2019 08:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbfJ0HZF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 27 Oct 2019 03:25:05 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:44777 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbfJ0HZE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 27 Oct 2019 03:25:04 -0400
Received: by mail-yb1-f195.google.com with SMTP id w5so2693365ybs.11;
        Sun, 27 Oct 2019 00:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0++xSMUHY1b2ynJOJZbzscLl9Hvq7kC0p6PzVZGLpt8=;
        b=O7JXupgbuixvTKzsH5NgxAZt1uCox/bzNuYd8FmjhOkZSEBiqrZP9TyI8XMRDHt4c7
         KSUx8PND/3A/JrM78+k0s9EIqkx+svlB/VhbU7bfKQcQ2ZfMZk02v8RqvOn0mhMd8pBB
         wEp/qHZWWlBFPBuHvsWi4DVOPWWh53lMxXAG1aHJPl6TnhvCag8NYO9qBm2VR4KMSjMc
         st8PaeaJbLQyEZdWA7hvwZNQd/Lg9Xfs+kcVzxRR/nHjAoKwI3u7Oz1FBj0WXRqH1N76
         WvFwl6tSakaOAV5D6g42Rtf+EDfFAvUFX7GO9ONyGpaROSEQZkgcIm2g5Ld5Wugx+ocA
         CrQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0++xSMUHY1b2ynJOJZbzscLl9Hvq7kC0p6PzVZGLpt8=;
        b=hhFetzG3xD7tpZQuw8Q6AETDtFCOsZO3XAyWWudIrgXrAyVj9z1qaG7wCdXb/Sg6++
         U70QSR6+APHldMNDKERdEinvCnPYf7sbqIZdLABefE9K68YVJstvaEIoi0Dxd8BBmQGw
         UytKn4JX9M1l2n1vgC67r3f6h+q1FrlF/9ObWuRAnC0LV1aciLDgQlqEWBHXrQrOmk30
         2lu3urtHMYTDQyTiGN1hN8beJqpzlWdToVJdaIjWrkYmPDkhva/157DWw74j6MDyB5Iy
         0bybfxBmkXx6Xwny0nZttokldvB6pOZvCVbY5pCtx0U/4KRhZipGtlygybb68uhH6Gox
         NN6Q==
X-Gm-Message-State: APjAAAWkOUnE+7VXvPFfyT76DgJRON9mIMxjqpw4gz0SJhW6Clssgmp5
        sK7enp6hj3Y/GOhKGT2jouB4q2lxz+Qz7919s1U=
X-Google-Smtp-Source: APXvYqyYhy4CH/Z7Nlg815OS/2z91s5DQvSZba10DJ00L5dfJlIE3NIpMH0a/LD0StWNrh9UDnpk8alGvxMvThdluKM=
X-Received: by 2002:a25:1444:: with SMTP id 65mr9107267ybu.132.1572161103775;
 Sun, 27 Oct 2019 00:25:03 -0700 (PDT)
MIME-Version: 1.0
References: <20191022204453.97058-1-salyzyn@android.com> <20191022204453.97058-3-salyzyn@android.com>
 <CAJfpegsCzwXF5fD1oA+XMrPQ7u8URsXRGOOHkB=ON7fLnd_gFQ@mail.gmail.com>
In-Reply-To: <CAJfpegsCzwXF5fD1oA+XMrPQ7u8URsXRGOOHkB=ON7fLnd_gFQ@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sun, 27 Oct 2019 09:24:52 +0200
Message-ID: <CAOQ4uxh_K=p7z+qbkjSf_+hhVsw9xBuNc61dYnpkHFVUfxJaCw@mail.gmail.com>
Subject: Re: [PATCH v14 2/5] overlayfs: check CAP_DAC_READ_SEARCH before
 issuing exportfs_decode_fh
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Mark Salyzyn <salyzyn@android.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-team@android.com, Jonathan Corbet <corbet@lwn.net>,
        Vivek Goyal <vgoyal@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-doc@vger.kernel.org,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

+ ebiederm and nfsd folks

On Wed, Oct 23, 2019 at 11:08 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
>
>
> On Tue, Oct 22, 2019 at 10:46 PM Mark Salyzyn <salyzyn@android.com> wrote:
> >
> > Assumption never checked, should fail if the mounter creds are not
> > sufficient.
>
> A bit more explanation would be nice.  Like a pointer to the explanation given in the open_by_handle_at(2) code where this check was presumably taken from.
>

Well, it's not that simple (TM).
If you are considering unprivileged overlay mounts, then this should be
ns_capable() check, even though open_by_handle_at(2) does not
currently allow userspace nfsd to decode file handles.

Unlike open_by_handle_at(2), overlayfs (currently) never exposes file
data via decoded origin fh. AFAIK, it only exposes the origin st_ino
st_dev and some nlink related accounting.

I have been trying to understand from code if nfsd exports are allowed
from non privileged containers and couldn't figure it out (?).
If non privileged container is allowed to export nosubtreecheck export
then non privileged container root can already decode file handles...

Thanks,
Amir.
