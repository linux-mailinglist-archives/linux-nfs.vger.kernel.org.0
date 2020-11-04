Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A04342A64FB
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Nov 2020 14:22:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729481AbgKDNWd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 4 Nov 2020 08:22:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbgKDNWd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 4 Nov 2020 08:22:33 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D84C0613D3;
        Wed,  4 Nov 2020 05:22:32 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id cw8so16162040ejb.8;
        Wed, 04 Nov 2020 05:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qbJlQYjdsQ7pFp1tga73Zyb8dzNLz6U3izaZiUDMhuY=;
        b=JCZD3sorqW9uTFYFWZccWJut/oGor4NG6CgBlJVJalYMu8n9NjS0crWJaWLrgrHgtf
         MT1JKhLxrIFpCOybZpvMAzV4Qf+Mx2LpPKFkOkckz+T4XkdreW7eed79ALV88epkASXu
         CEplQU/hMCUdVyjIHL/qt5O/mv91MR34pJF3HBRXMvLHtAMclC3O0rF6Bu82Mv2Yv5d5
         FISos8Ugsvg0JDiRLHlJ0ooKNI3UNtDLK1rVhsHSkT0l3IqcgpQQ5Ke9LwRlhXWgukdY
         fuBcmEEqA8XgGfAvanFFc4gT4dj7RTynjKgedZsOi9Y+iq9cv5wWhgWLbl4D3clczdTS
         GLng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qbJlQYjdsQ7pFp1tga73Zyb8dzNLz6U3izaZiUDMhuY=;
        b=NTmZjWLFi49OUxD6Z/12p3Y37dYhMgfnLd92ABc8nnR5RV5L8QOcoPO/iCzr7yG3DT
         6lP5VH4zJ+V/6kZuUYxpBAKDIl48T7qxGSLbCi3KWuL/L2InS6GkcCqqLtZFi72LOfwI
         dkBuf0A9RMeWi7IfamCf3d/USqZwD7lDx3Ci7BfghH0x6I9bFeg2+nDk6yx2k8K/NINS
         FPJJniX5EYJelB5pW9GfkX/xwMTj35YfzDJK5GggcLPxsYEcnwKdNw0U7AXJEkqVXCQV
         BAki3ybbkj0Rq3AoXfzTmxrQcyBjeYPAiUhVR58f679BMphMvZEQ9695R+lcrYsALLrq
         y+ug==
X-Gm-Message-State: AOAM533NZJRNAUXW4SWn3ts0xtNmYxLb2oJwvQIiOjhzVSonVvEX8Uuu
        UcKB1anuFE39N4XnrlUliVdtObC4NhHBP8Wv+vY=
X-Google-Smtp-Source: ABdhPJxKuXYCXvL/NCF2umwTr7/ap6ZcM2gmwdfodWFcQE0pYek5otQhRDlVF698b4lB2dwhyFZUb3ECIz1eaUtFaW4=
X-Received: by 2002:a17:906:3899:: with SMTP id q25mr26605468ejd.0.1604496151605;
 Wed, 04 Nov 2020 05:22:31 -0800 (PST)
MIME-Version: 1.0
References: <20201102162438.14034-1-chenwenle@huawei.com> <20201102162438.14034-3-chenwenle@huawei.com>
 <8db50c039cb8b8325bb428c60ff005b899654fb4.camel@hammerspace.com> <ebee08ee-ecbe-c47c-1f7c-799f86b3879c@gmail.com>
In-Reply-To: <ebee08ee-ecbe-c47c-1f7c-799f86b3879c@gmail.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Wed, 4 Nov 2020 08:22:20 -0500
Message-ID: <CAN-5tyF-LVzfm2hGmBJhQXUvt_d19tmhk76DFmNuS-SaTZDvDg@mail.gmail.com>
Subject: Re: [PATCH 2/2] NFS: Limit the number of retries
To:     Wenle Chen <solomonchenclever@gmail.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "chenwenle@huawei.com" <chenwenle@huawei.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nixiaoming@huawei.com" <nixiaoming@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Nov 4, 2020 at 6:36 AM Wenle Chen <solomonchenclever@gmail.com> wro=
te:
>
>
>
> Trond Myklebust =E6=96=BC 2020/11/3 =E4=B8=8A=E5=8D=881:45 =E5=AF=AB=E9=
=81=93:
> > On Tue, 2020-11-03 at 00:24 +0800, Wenle Chen wrote:
> >>    We can't wait forever, even if the state
> >> is always delayed.
> >>
> >> Signed-off-by: Wenle Chen <chenwenle@huawei.com>
> >> ---
> >>   fs/nfs/nfs4proc.c | 4 +++-
> >>   1 file changed, 3 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> >> index f6b5dc792b33..bb2316bf13f6 100644
> >> --- a/fs/nfs/nfs4proc.c
> >> +++ b/fs/nfs/nfs4proc.c
> >> @@ -7390,15 +7390,17 @@ int nfs4_lock_delegation_recall(struct
> >> file_lock *fl, struct nfs4_state *state,
> >>   {
> >>          struct nfs_server *server =3D NFS_SERVER(state->inode);
> >>          int err;
> >> +       int retry =3D 3;
> >>
> >>          err =3D nfs4_set_lock_state(state, fl);
> >>          if (err !=3D 0)
> >>                  return err;
> >>          do {
> >>                  err =3D _nfs4_do_setlk(state, F_SETLK, fl,
> >> NFS_LOCK_NEW);
> >> -               if (err !=3D -NFS4ERR_DELAY)
> >> +               if (err !=3D -NFS4ERR_DELAY || retry =3D=3D 0)
> >>                          break;
> >>                  ssleep(1);
> >> +               --retry;
> >>          } while (1);
> >>          return nfs4_handle_delegation_recall_error(server, state,
> >> stateid, fl, err);
> >>   }
> >
> > This patch will just cause the locks to be silently lost, no?
> >
> This loop was introduced in commit 3d7a9520f0c3e to simplify the delay
> retry loop. Before this, the function nfs4_lock_delegation_recall would
> return a -EAGAIN to do a whole retry loop.

This commit was not simplifying retry but actually handling the error.
Without it the error isn't handled and client falsely thinks it holds
the lock. Limiting the number of retries as Trond points out would
lead to the same problem which in the end is data corruption.
Alternative would be to fail the application. However ERR_DELAY is a
transient error and the server would, when ready, return something
else. If server is broken and continues to do so then the server needs
to be fix (client isn't coded to the broken server). I don't see a
good argument for limiting the number of re-tries.

> When we retried three times and waited three seconds, it was still in
> delay. I think we can get a whole loop and check the other points if it
> was changed or not. It is just a proposal.
