Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 871A83327EA
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Mar 2021 14:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231660AbhCIN52 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 9 Mar 2021 08:57:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbhCIN5Z (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 9 Mar 2021 08:57:25 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B080C06174A
        for <linux-nfs@vger.kernel.org>; Tue,  9 Mar 2021 05:57:24 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id mj10so27897056ejb.5
        for <linux-nfs@vger.kernel.org>; Tue, 09 Mar 2021 05:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xw4prKFIV71j3r5FDBwxwDqhwqt4DbdRefFH2AydYfw=;
        b=MqfqFIwfDH0yVdx1fT9GW5t9qjCO7m+z6cKng4k+nOaHoDRViaqdKeg6rlxDvtHUxM
         OlcuEv9KkfcQ8/L/igUF9zJgqUnjdIT4L1bmJKRky9wDrFfxkZ84sjsbaiBmpeJ/0fE3
         8m7JqN3xzhS37LqW4DfHHAlhRokXukN1tRBT36ihFaDFji8zwILErQxmkslPPNaMPsuT
         uJP7vfDSwQ+otsuwJ2PQVvs+H9wBit7p/VeeggJXqKdcPYERveflp+0/+F64+lVMsFSW
         Srzqv2WEyfgha1PPfouyC1peTnidsQOYF6GB3WVjUxW7fipH9RO5FzRiOf9m2m+oa/Ip
         UIKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xw4prKFIV71j3r5FDBwxwDqhwqt4DbdRefFH2AydYfw=;
        b=GSqYkUIAHVsbTk7bhc0qMvCNziYqP/FHBfCU+d26JId8q5GlZAd6uoSrNtX84Kzfp1
         OJo4PRssRW4qiH8SPhDeKh+lV1dHNIor0qzyHCrUYVH4sqbr1QU1Q4gaPqgn5nGL/59T
         OlYZVo/j9ztEmK3BFDnuMyrpdxZOWTHqTB4r4S1RBRwNazjcpolObkaZDENUcISl6v2/
         aNQDlqzq2m6ynmby3jJmFmXYz5AwWYpgZxs0ORtHHZDCoBBiFzlytZ0hD3BMWCjXVBbS
         sMm1+xpnnWS2C9EK76cAd0tz5lvrIGYDx9sR/Fbjx0cNdQEhuUTsrfTg2sknIE30SW58
         gFBA==
X-Gm-Message-State: AOAM533YQMMfwLTiTs1b0/Q9tZQBr0FyP4V1OGo6c2IBSWHtlEucxKg1
        pEqzoG1jlHin5TC9RHzPgC3mUfkxi1HPvjXdCt0=
X-Google-Smtp-Source: ABdhPJzEaRsHISJWw/egT6cQk+nRAi/7CSRO1+oa33TOkfs57qdZ0fP2crcepshCDl7s5EewtDnMM3U8Cc8S+uJ7i2E=
X-Received: by 2002:a17:906:30d9:: with SMTP id b25mr3059058ejb.348.1615298243178;
 Tue, 09 Mar 2021 05:57:23 -0800 (PST)
MIME-Version: 1.0
References: <20210302194659.98563-1-dai.ngo@oracle.com> <CAN-5tyHr6VEfBubU_gBRyCfzkAzGkwiBvO-0S9Kbnpj_LnVdQQ@mail.gmail.com>
 <4d18eb5e-b1b8-7f26-85b9-b6f9e1b1b231@oracle.com>
In-Reply-To: <4d18eb5e-b1b8-7f26-85b9-b6f9e1b1b231@oracle.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Tue, 9 Mar 2021 08:57:11 -0500
Message-ID: <CAN-5tyF8hvRZujiCt6e3shNXdEGEQ=kJvOYbFhWx2DCGVo9qPA@mail.gmail.com>
Subject: Re: [PATCH] NFSv4.2: destination file needs to be released after
 inter-server copy is done.
To:     Dai Ngo <dai.ngo@oracle.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Mar 8, 2021 at 3:10 PM <dai.ngo@oracle.com> wrote:
>
> Thanks Olga for reviewing the patch, reply inline below:
>
> On 3/8/21 10:35 AM, Olga Kornievskaia wrote:
> > On Tue, Mar 2, 2021 at 2:47 PM Dai Ngo <dai.ngo@oracle.com> wrote:
> >> This patch is to fix the resource leak problem of the source file
> >> when doing inter-server copy. The fix is to close and release the
> >> file in __nfs42_ssc_close after the copy is done.
> >>
> >> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> >> ---
> >>   fs/nfs/nfs4file.c | 6 ++++++
> >>   1 file changed, 6 insertions(+)
> >>
> >> diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
> >> index 57b3821d975a..20163fe702a7 100644
> >> --- a/fs/nfs/nfs4file.c
> >> +++ b/fs/nfs/nfs4file.c
> >> @@ -405,6 +405,12 @@ static void __nfs42_ssc_close(struct file *filep)
> >>          struct nfs_open_context *ctx = nfs_file_open_context(filep);
> >>
> >>          ctx->state->flags = 0;
> >> +
> >> +       if (!filep)
> >> +               return;
> >> +       get_file(filep);
> >> +       filp_close(filep, NULL);
> >> +       fput(filep);
> >>   }
> > I don't understand this logic. There is no reason to call
> > filp_close()?
>
> This is to follow the steps done in nfsd_file_put/.../nfsd_file_free.
> However since this is the source file the flush is probably not needed,
> just there to be safe. I will remove it.

As I said before the only thing that's needed is the fput() which was
originally in the code (but got incorrectly changed to nfsd_put()). I
prefer to keep it there because this deals with cleaning up the SSC
state. I don't see any significant reason to move it out.

> > All this would be done by doing a fput(). Also fput()
> > would drop a reference on the mount point. So we are doing this then
> > we can't call that extra disconnect that was added by another patch.
>
> nfsd4_interssc_disconnect does not need to access the source file.
> I tested both patches together and did not see any problem. If there
> is use-after_free condition the code detects it and there would be
> warning messages in /var/log/messages.

We don't need and don't want to do the nfsd4_interssc_disconnect in
the non-error path. All the ref-counting on the superblock is
accomplished already. The other patch is not needed and neither is
correct, it makes the incorrect refcounts in failure cases.

I nack both patches. The only patch which I will send that's needed is this:

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 8d6d2678abad..3581ce737e85 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1304,7 +1304,7 @@ nfsd4_cleanup_inter_ssc(struct vfsmount *ss_mnt,
struct nfsd_file *src,
                        struct nfsd_file *dst)
 {
        nfs42_ssc_close(src->nf_file);
-       /* 'src' is freed by nfsd4_do_async_copy */
+       fput(src->nf_file);
        nfsd_file_put(dst);
        mntput(ss_mnt);
 }

> > Anyway I don't see why there is any reason to call anything but the
> > fput(), I'm not sure why __nfs42_ssc_close() is a better function and
> > doesn't lead to the "use_after_free".
>
> Since __nfs42_ssc_open was called open the file, I think __nfs42_ssc_close
> is an appropriate place to close the file.

Again let's keep the cleaning of the server's SSC state in one place.



> -Dai
>
> >
> >>   static const struct nfs4_ssc_client_ops nfs4_ssc_clnt_ops_tbl = {
> >> --
> >> 2.9.5
> >>
