Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 690143205A2
	for <lists+linux-nfs@lfdr.de>; Sat, 20 Feb 2021 15:10:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbhBTOJi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 20 Feb 2021 09:09:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbhBTOJh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 20 Feb 2021 09:09:37 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22291C061574
        for <linux-nfs@vger.kernel.org>; Sat, 20 Feb 2021 06:08:57 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id d2so15720821edq.10
        for <linux-nfs@vger.kernel.org>; Sat, 20 Feb 2021 06:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ae3qYOfHqRj3gCzYg2lPzRV59DPhsFz46J7BQUDlJTE=;
        b=kqEFMVG1bcFyUU8GBlr6Gy69PpvaT+smTLdZScgNmuA+zAvHJqfbzyPQqDbYpXyE1l
         7b3HTrm9kBDzycLpwCHqLR9c0enHBCDltLWtfv/pgGWc/37TA5zPgjYRGkM0gjwKlOyo
         5NfXmqphxHmusl/cBNp2umSEn+AgDJ9kq8C7G9auqfdOtWHnb9DMrufOxLEqN/v7Iw/P
         RZ03GCKp5unPZO5225iImiSUM88cq3MiNdOtyOu6kgv8rwCA+zZ21nbw0gXkq4nnR4XH
         ecwjHdoZvhlPOEgrV7g8ZXy/iHSWzLHmIm/2H+AmnaQKfoW312Dn1cmp8J1zu8KBKUkw
         d9yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ae3qYOfHqRj3gCzYg2lPzRV59DPhsFz46J7BQUDlJTE=;
        b=qnEv9Yx4v8hfSb7M88DLLCh+PkcTIq17aAQixx0Ywc9k4pGAu7KdcBQqVcC91+Eeli
         7LfNZkl32KbDK74Ns+X0PdFj8wgJLLZ5O0Ybf00m+vFUanf4d8JUCMYHA0bJZ3XvnlQo
         8X0ytSFtfS1H75Z1DsoL1WZgFTLz8vGt0IZvDbALrA71vVKFLDHXTN85voEDCmeo3dVo
         wEGxM2vF3PWeKtu2DR0XqSJ1z+1Q7/iYaCKXrHbRwTM+e1VszHAi3MhrYx7KgRlzvOeA
         5EwB+TZNOgsxzDQmbqFZUyz2pF0IRGKBABj1aaV9Re8Inhv6eKBIG3e0XxE8BhdNWFJN
         ptsw==
X-Gm-Message-State: AOAM533C5OjhczBND+n2ckdzSo53YayO3Guylhd7JV9um8kulg8ZHlzC
        S6BlqvWFqkKQrjhWh5bauIQuaYHjyoi0ZZQBJ0LqZoukF4um/g==
X-Google-Smtp-Source: ABdhPJxwVDCQlLgAanxqYbXuRWBKarR7TgP2qECB+H+9oS93jXwtZPoqbS3IHehtfRGdyMMRlE9UFVn8ABGIcAQ07vM=
X-Received: by 2002:a05:6402:10c3:: with SMTP id p3mr13987947edu.67.1613830134889;
 Sat, 20 Feb 2021 06:08:54 -0800 (PST)
MIME-Version: 1.0
References: <20201029190716.70481-1-dai.ngo@oracle.com> <20201029190716.70481-2-dai.ngo@oracle.com>
 <CAN-5tyFnTSuMivnBPD9Aur+KDxX8fCOuSaF7qGKe6bFB7roK6Q@mail.gmail.com>
 <20210220010903.GE5357@fieldses.org> <69ea46ff-80d1-acfa-22a5-3d1b6230728f@oracle.com>
 <20210220032057.GA25183@fieldses.org>
In-Reply-To: <20210220032057.GA25183@fieldses.org>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Sat, 20 Feb 2021 09:08:43 -0500
Message-ID: <CAN-5tyHq2NcQRbx01cSyJob=72MDUnwjK_t6GiDjTc3twbnvwA@mail.gmail.com>
Subject: Re: [PATCH 1/2] NFSD: Fix use-after-free warning when doing
 inter-server copy
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Dai Ngo <dai.ngo@oracle.com>, linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Feb 19, 2021 at 10:21 PM J. Bruce Fields <bfields@fieldses.org> wrote:
>
> On Fri, Feb 19, 2021 at 05:31:58PM -0800, dai.ngo@oracle.com wrote:
> > If this is the cause why we don't drop the mount after the copy
> > then I can restore the patch and look into this problem. Unfortunately,
> > all my test machines are down for maintenance until Sunday/Monday.
>
> I think we can take some time to figure out what's actually going on
> here before reverting anything.

Yes I agree. We need to fix the use-after-free and also make sure that
reference will go away. I'm assuming to reproduce the use-after-free I
need to run with kazan, is that what you did Dai?

>
> --b.
>
> >
> > -Dai
> >
> > On 2/19/21 5:09 PM, J. Bruce Fields wrote:
> > >Dai, do you have a copy of the original use-after-free warning?
> > >
> > >--b.
> > >
> > >On Fri, Feb 19, 2021 at 07:18:53PM -0500, Olga Kornievskaia wrote:
> > >>Hi Dai (Bruce),
> > >>
> > >>This patch is what broke the mount that's now left behind between the
> > >>source server and the destination server. We are no longer dropping
> > >>the necessary reference on the mount to go away. I haven't been paying
> > >>as much attention as I should have been to the changes. The original
> > >>code called fput(src) so a simple refcount of the file. Then things
> > >>got complicated and moved to nfsd_file_put(). So I don't understand
> > >>complexity. But we need to do some kind of put to decrement the needed
> > >>reference on the superblock. Bruce any ideas? Can we go back to
> > >>fput()?
> > >>
> > >>On Thu, Oct 29, 2020 at 3:08 PM Dai Ngo <dai.ngo@oracle.com> wrote:
> > >>>The source file nfsd_file is not constructed the same as other
> > >>>nfsd_file's via nfsd_file_alloc. nfsd_file_put should not be
> > >>>called to free the object; nfsd_file_put is not the inverse of
> > >>>kzalloc, instead kfree is called by nfsd4_do_async_copy when done.
> > >>>
> > >>>Fixes: ce0887ac96d3 ("NFSD add nfs4 inter ssc to nfsd4_copy")
> > >>>Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> > >>>---
> > >>>  fs/nfsd/nfs4proc.c | 2 +-
> > >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> > >>>
> > >>>diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > >>>index ad2fa1a8e7ad..9c43cad7e408 100644
> > >>>--- a/fs/nfsd/nfs4proc.c
> > >>>+++ b/fs/nfsd/nfs4proc.c
> > >>>@@ -1299,7 +1299,7 @@ nfsd4_cleanup_inter_ssc(struct vfsmount *ss_mnt, struct nfsd_file *src,
> > >>>                         struct nfsd_file *dst)
> > >>>  {
> > >>>         nfs42_ssc_close(src->nf_file);
> > >>>-       nfsd_file_put(src);
> > >>>+       /* 'src' is freed by nfsd4_do_async_copy */
> > >>>         nfsd_file_put(dst);
> > >>>         mntput(ss_mnt);
> > >>>  }
> > >>>--
> > >>>2.20.1.1226.g1595ea5.dirty
> > >>>
