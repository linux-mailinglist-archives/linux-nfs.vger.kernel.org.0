Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4370674305
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Jan 2023 20:40:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbjASTkt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 19 Jan 2023 14:40:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbjASTkt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 19 Jan 2023 14:40:49 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584A59373D
        for <linux-nfs@vger.kernel.org>; Thu, 19 Jan 2023 11:40:48 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id v3so2397500pgh.4
        for <linux-nfs@vger.kernel.org>; Thu, 19 Jan 2023 11:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8KONNU3M5iye4R6ERz57Ll2LImdcXCbtSGNfCYPSxo4=;
        b=g+p0/84XbWuqF0pVYaQs68mOUz23db/1Hv2BsuuAsK6R/GzPOfL9hVE/erNybBqthT
         PNe2rxtl+Xph+YR601Wavf6X1SawuIy2NrPbma4lwbeB7TLeyVCCfmNwlW6WmHgIaC8g
         NAbKMG3R6uTrblVA27BaVMkRbNMWzlJGUkpCrDXuCFEGa8en4mPQedQVelkkbfg8WS1/
         53gbKctChu8QFjxgmj/TUi0nv7jOGMkKPH2SoWc+IoWRn6cIxZ4lAFMORBAIlTKpvgvC
         Yh4EFuwspub/BChrYpNsnOgI4qV/86DJW/fcvgIdc0cGzSppEA9Z1Cn+ykbQKhs3ku1p
         vIWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8KONNU3M5iye4R6ERz57Ll2LImdcXCbtSGNfCYPSxo4=;
        b=ppgdUTr0yJ2mgntE8oR/6aggLo6P/zrfOGBJNL8XgsjlLq8Fir5v2oxs+QBDvl4Csu
         fG/Xwf++2Pmokh7QAxlqyXuR09dnDTeUme+cJ+fNWQab2igP0mdFgDwJDsJUesoEaStg
         H5WExK/7fteltREOMyJQ5xVqLy1bRRJma1JWSlXsUZ8/4GPKe3HiGb1jOqJo6ylmbKYd
         guZ9+YouVK8fvrfELwcBBGK7ZUiO9bNNGlEyB/KfBVjD3pvAprD/aw+/5T1OQC1C3LVP
         /3pwKLUssETrz6cWHTeAG/SLF6Mht/y8knzx4yjfa8C/yCsLE5IsnCzapeWUGNjm41y5
         yfmg==
X-Gm-Message-State: AFqh2krPPkjA5XJlABNJ0HGMbOnbp17zC5zmKwKPeR+GB7XhnCy2was3
        7msteBkRNuRjCr5xb+/Cg+2hKMXReswAudaRtraVB91vZzM=
X-Google-Smtp-Source: AMrXdXvL+KZyWKBpjI0xiuWhJ3TaFHRN12YPPdLgaJ0tsm1g4OAKxhsETVoR1IuHfL+ld8/sjkMA7g7XNrWSKscW0TU=
X-Received: by 2002:a62:1b0a:0:b0:58d:8e62:6c0b with SMTP id
 b10-20020a621b0a000000b0058d8e626c0bmr1159251pfb.42.1674157247726; Thu, 19
 Jan 2023 11:40:47 -0800 (PST)
MIME-Version: 1.0
References: <20230119175010.57814-1-olga.kornievskaia@gmail.com> <C3BB5432-E3A1-4BC0-983F-0A1B11E828A0@hammerspace.com>
In-Reply-To: <C3BB5432-E3A1-4BC0-983F-0A1B11E828A0@hammerspace.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Thu, 19 Jan 2023 14:40:36 -0500
Message-ID: <CAN-5tyE6pnnNxsVC+FpJ6rb6=66+KX6RAZb4Y-UfDH=bAr=JPA@mail.gmail.com>
Subject: Re: [PATCH 1/1] pNFS/filelayout: treat GETDEVICEINFO errors as LAYOUTUNAVAILABLE
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     Anna Schumaker <anna.schumaker@netapp.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Jan 19, 2023 at 1:24 PM Trond Myklebust <trondmy@hammerspace.com> w=
rote:
>
>
>
> > On Jan 19, 2023, at 12:50, Olga Kornievskaia <olga.kornievskaia@gmail.c=
om> wrote:
> >
> > If the call to GETDEVICEINFO fails, the client fallback to doing IO
> > to MDS but on every new IO call, the client tries to get the device
> > again. Instead, mark the layout as unavailable as well. This way
> > the client will re-try after a timeout period.
> >
> > Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> > ---
> > fs/nfs/filelayout/filelayout.c | 1 +
> > fs/nfs/pnfs.c                  | 7 +++++++
> > fs/nfs/pnfs.h                  | 2 ++
> > 3 files changed, 10 insertions(+)
> >
> > diff --git a/fs/nfs/filelayout/filelayout.c b/fs/nfs/filelayout/filelay=
out.c
> > index 4974cd18ca46..13df85457cf5 100644
> > --- a/fs/nfs/filelayout/filelayout.c
> > +++ b/fs/nfs/filelayout/filelayout.c
> > @@ -862,6 +862,7 @@ fl_pnfs_update_layout(struct inode *ino,
> >
> > status =3D filelayout_check_deviceid(lo, fl, gfp_flags);
> > if (status) {
> > + pnfs_mark_layout_unavailable(lo, iomode);
> > pnfs_put_lseg(lseg);
> > lseg =3D NULL;
> > }
> > diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
> > index a5db5158c634..bac15dcf99bb 100644
> > --- a/fs/nfs/pnfs.c
> > +++ b/fs/nfs/pnfs.c
> > @@ -491,6 +491,13 @@ pnfs_layout_set_fail_bit(struct pnfs_layout_hdr *l=
o, int fail_bit)
> > refcount_inc(&lo->plh_refcount);
> > }
> >
> > +void
> > +pnfs_mark_layout_unavailable(struct pnfs_layout_hdr *lo, enum pnfs_iom=
ode fail_bit)
> > +{
> > + pnfs_layout_set_fail_bit(lo, pnfs_iomode_to_fail_bit(fail_bit));
>
> I suggest rather using pnfs_layout_io_set_failed() so that we also evict =
the layout segment that references this unrecognised deviceid. In fact, the=
re is already an exported function pnfs_set_lo_fail() (which could definite=
ly do with a better name!) that does this.

I'm not opposed to this approach. In the proposed patch, I treated it
as the layout being still valid but unavailable. My question is: I
think we need to return the layout before doing this, correct? Should
I be making changes to export something like
pnfs_set_plh_return_info() or would adding a new function to pnfs.c
that does pnfs_set_lo_fail and returns the layout?

something like
+void pnfs_invalidate_return_layout(struct pnfs_layout_segment *lseg)
+{
+       pnfs_layout_io_set_failed(lseg->pls_layout, lseg->pls_range.iomode)=
;
+       pnfs_set_plh_return_info(lseg->pls_layout, lseg->pls_range.iomode, =
0);
+}
+EXPORT_SYMBOL_GPL(pnfs_invalidate_return_layout);

        status =3D filelayout_check_deviceid(lo, fl, gfp_flags);
        if (status) {
+               pnfs_invalidate_return_layout(lseg);
                pnfs_put_lseg(lseg);
                lseg =3D NULL;

>
> > +}
> > +EXPORT_SYMBOL_GPL(pnfs_mark_layout_unavailable);
> > +
> > static void
> > pnfs_layout_clear_fail_bit(struct pnfs_layout_hdr *lo, int fail_bit)
> > {
> > diff --git a/fs/nfs/pnfs.h b/fs/nfs/pnfs.h
> > index e3e6a41f19de..9f47bd883fc3 100644
> > --- a/fs/nfs/pnfs.h
> > +++ b/fs/nfs/pnfs.h
> > @@ -343,6 +343,8 @@ void pnfs_error_mark_layout_for_return(struct inode=
 *inode,
> > void pnfs_layout_return_unused_byclid(struct nfs_client *clp,
> >      enum pnfs_iomode iomode);
> >
> > +void pnfs_mark_layout_unavailable(struct pnfs_layout_hdr *lo,
> > +  enum pnfs_iomode iomode);
> > /* nfs4_deviceid_flags */
> > enum {
> > NFS_DEVICEID_INVALID =3D 0,       /* set when MDS clientid recalled */
> > --
> > 2.31.1
> >
>
> _________________________________
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>
