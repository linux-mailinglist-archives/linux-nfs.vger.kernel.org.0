Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5411FE608
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Nov 2019 20:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbfKOTwH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 15 Nov 2019 14:52:07 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:45495 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbfKOTwH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 15 Nov 2019 14:52:07 -0500
Received: by mail-ua1-f65.google.com with SMTP id w10so906321uar.12;
        Fri, 15 Nov 2019 11:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HHbI26fz+zQpABS0zqXiY8c4KjnBwCq3pE9F7Wnb8fY=;
        b=J2q0LIOq9UNr8vaWrhFjK3y7keJnCFExHpkVvk1zXXQkwtbojNxqPueOGrFo+4lQfP
         Ob2upH2NnhOl8e3FxPoLV0SjuA3Txr9caDvzDsJ5ljV6kQIFoNJYKRbjoo5fFy+Y0oax
         9hYgpJU54IFLr2pKqbjFyycL265BkrtHoxfuMjrgVMtvi//MC7IctsbWYF+V8xwwhD2i
         CtDxHGWDoiNpPGUPwDJm6e0wajE/DblDMTbw89gVaeBcSzbRWqsWt/XZbHWJ0d3UF9yg
         E6ucy09GLMjWYkp1bFQQMWNQTMw1qq/ftSt/CuLwiHb0VB8LY6GZHTPqaJ/WO1/7nsgP
         srXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HHbI26fz+zQpABS0zqXiY8c4KjnBwCq3pE9F7Wnb8fY=;
        b=FLIKwIAZq3QlD0Em0UBkGe4Qz6JfPQrzWAAD97w0ManS7hu8aLeVSDyKetCIv5lfis
         8WlVmyj+SjmoTZXfcIZz1xjMemxI6jVE+qjNvoyjDF0hnZSpi0CUfhufabdldlAKQTkx
         0Dbxj0axmUFqTwsMYupLvbikhKzdNVul+7aJNIEHwDHDBX1geYq/oUgOsJSMTcaCKIz/
         w+U4eLKtTDOty9OQOA7kLORTaMEPgklcYnq2bWhRuhYXlvB0q/kTqe8ZaS66Q50u6hS0
         4iqyhqHSxyrUpj+SpoLBYXyteOqyiTr88D0M4Se4g2JVnlichQe2oryrbS6/myZcnbVK
         V50g==
X-Gm-Message-State: APjAAAWpvlL3wvT91V2JvcvCRWC9258uKe26IRdEDjqUfL/oxUe3ia+Y
        zl+8UDgbvdZCtzDO+zHfX2VJ8nan/JGwkFL2Fy7Jtg==
X-Google-Smtp-Source: APXvYqx+/nT4BADAMxeuRrzcjMfxVjvDdGp8/th+yZsYwloAo8QW5U97u4z3d7xWU/7ck/2px+YjHaoLWmjXtJR8Sk8=
X-Received: by 2002:ab0:1c06:: with SMTP id a6mr9926650uaj.93.1573847526571;
 Fri, 15 Nov 2019 11:52:06 -0800 (PST)
MIME-Version: 1.0
References: <3d8e949c-e266-c4f7-5179-c06ab3629418@canonical.com>
In-Reply-To: <3d8e949c-e266-c4f7-5179-c06ab3629418@canonical.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Fri, 15 Nov 2019 14:51:55 -0500
Message-ID: <CAN-5tyEgufUvN_FeLNnwdpGM0Yw1Jag8HQMAzti8Tg_xaOoOjg@mail.gmail.com>
Subject: Re: NFS: inter ssc open (memory leak detected)
To:     Colin Ian King <colin.king@canonical.com>
Cc:     Olga Kornievskaia <kolga@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Nov 15, 2019 at 4:24 AM Colin Ian King <colin.king@canonical.com> wrote:
>
> Hi,
>
> Static analysis with Coverity has detected a memory leak in the
> following commit:
>
> commit ec4b0925089826af45e99cdf78a8ac84c1d005f1
> Author: Olga Kornievskaia <kolga@netapp.com>
> Date:   Tue Oct 8 16:33:53 2019 -0400
>
>     NFS: inter ssc open
>
>
> In function nfs42_ssc_open(), fs/nfs/nfs4file.c, analysis is as follows:
>
>    3. alloc_fn: Storage is returned from allocation function kzalloc.
>    4. var_assign: Assigning: read_name = storage returned from
> kzalloc(len, 3136U).
> 336        read_name = kzalloc(len, GFP_NOFS);
>
>    5. Condition read_name == NULL, taking false branch.
> 337        if (read_name == NULL)
> 338                goto out;
>
>    6. noescape: Resource read_name is not freed or pointed-to in snprintf.
> 339        snprintf(read_name, len, SSC_READ_NAME_BODY, read_name_gen++);
> 340
> 341        r_ino = nfs_fhget(ss_mnt->mnt_root->d_inode->i_sb, src_fh,
> &fattr,
> 342                        NULL);
>
>    7. Condition IS_ERR(r_ino), taking true branch.
> 343        if (IS_ERR(r_ino)) {
> 344                res = ERR_CAST(r_ino);
>
>    8. Jumping to label out.
> 345                goto out;
> 346        }
> 347
> 348        filep = alloc_file_pseudo(r_ino, ss_mnt, read_name, FMODE_READ,
> 349                                     r_ino->i_fop);
> 350        if (IS_ERR(filep)) {
> 351                res = ERR_CAST(filep);
> 352                goto out;
> 353        }
> 354        filep->f_mode |= FMODE_READ;
> 355
> 356        ctx = alloc_nfs_open_context(filep->f_path.dentry, filep->f_mode,
> 357                                        filep);
> 358        if (IS_ERR(ctx)) {
> 359                res = ERR_CAST(ctx);
> 360                goto out_filep;
> 361        }
> 362
> 363        res = ERR_PTR(-EINVAL);
> 364        sp = nfs4_get_state_owner(server, ctx->cred, GFP_KERNEL);
> 365        if (sp == NULL)
> 366                goto out_ctx;
> 367
> 368        ctx->state = nfs4_get_open_state(r_ino, sp);
> 369        if (ctx->state == NULL)
> 370                goto out_stateowner;
> 371
> 372        set_bit(NFS_SRV_SSC_COPY_STATE, &ctx->state->flags);
> 373        set_bit(NFS_OPEN_STATE, &ctx->state->flags);
> 374        memcpy(&ctx->state->open_stateid.other, &stateid->other,
> 375               NFS4_STATEID_OTHER_SIZE);
> 376        update_open_stateid(ctx->state, stateid, NULL, filep->f_mode);
> 377
> 378        nfs_file_set_open_context(filep, ctx);
> 379        put_nfs_open_context(ctx);
> 380
> 381        file_ra_state_init(&filep->f_ra,
> filep->f_mapping->host->i_mapping);
> 382        res = filep;
> 383out:
>
>    CID 91575 (#1-2 of 2): Resource leak (RESOURCE_LEAK)
>
> 9. leaked_storage: Variable read_name going out of scope leaks the
> storage it points to.
>
> 384        return res;
>
>
> Looks like there are several return paths to out: that leak the
> allocation of read_name.

Thanks will fix.
