Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0B5DB6CBF
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Sep 2019 21:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730159AbfIRTjB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 18 Sep 2019 15:39:01 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:37755 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727648AbfIRTjB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 18 Sep 2019 15:39:01 -0400
Received: by mail-vk1-f196.google.com with SMTP id v78so288890vke.4
        for <linux-nfs@vger.kernel.org>; Wed, 18 Sep 2019 12:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FM6TopUxE1Rtc6tttT63BlLsMhhNsHt3UWMSnYgpWdY=;
        b=NlRb0CMOb3VFC9J5MfHfgo5t1sDQG8KY1DNrNwCpV1y7e95Gu4hiFPt+t0kuyOFWEL
         yltM6kNPRpxe+DYeGYFQTDMl3Wup1bm1RJx0ODaevRejHY+cWW3hyRbebfqRInn0IvV9
         E4KW16rYVGEyZ2jcowymvu8OUwxT+fzyHn5g3GGGsO880ACUw//OenRAkg+3Y2SStWy0
         /r7yFcGPwz+wSjDTFEbgUmWRqOUUz9wbPUNfaMUBAbSJcE9s/CM16fZbuYvd/ROZzJuE
         hEOJKc7w91CG8XmClwca7T0UxMfeWL28w9ifIGLAWVPAMUhv9C4iT5RoXubUtAFTNoH4
         bEnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FM6TopUxE1Rtc6tttT63BlLsMhhNsHt3UWMSnYgpWdY=;
        b=m1PO3Vadd1dVVUwabwdWYjWzCrxz10UgzCSviaAF0FPe91nyjCsh/0J1pS9Hs4ciyc
         PW7gn7aOQ9Kq3fliVCIuzhl6NGFvXRZwEuBlbcrOBYRLf6YLYsMf/YwsiF56xX0T12dU
         Nt5cEIzHXzcDCNjtdpDIprToMPHKtK8Aq1eCjI6YpTI5wyjw4ekduU/hqhmZO7+jllhF
         lg0nBzn41Yv7T4o2mUW7Dc+r0EQHY9RKynVoHWbHYDdq2g2HFSOaMJwBqcYe/vKQoxft
         65Ry3yCQClalNHgJwiHM4LxLdRmp9NxCDx6toUSD5Y+T2GQmytq3tuxtHEj7nUavIR57
         jRhQ==
X-Gm-Message-State: APjAAAUboQ3ZYzwxBc1PdreyjzyErJptpbhf+pYNflXxKvf33/nsyoXM
        4dOBPfQlyreTigr2EQQNprqpqwJrNyr38R6eOPQ=
X-Google-Smtp-Source: APXvYqxa+QfBCnGmHhvnMAcVexbErXO9TRxeyGp78vn0w4265oILp+ROr9Ufaovcl85nb0IbnTyzvBRHV1scBM5IZfc=
X-Received: by 2002:a1f:53c5:: with SMTP id h188mr2904187vkb.33.1568835539816;
 Wed, 18 Sep 2019 12:38:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190916204419.21717-1-trond.myklebust@hammerspace.com>
In-Reply-To: <20190916204419.21717-1-trond.myklebust@hammerspace.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Wed, 18 Sep 2019 15:38:48 -0400
Message-ID: <CAN-5tyF27z=+3tbU1De_wR0aosiczn67dNanBmBe4icj=uAYwQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] Various NFSv4 state error handling fixes
To:     Trond Myklebust <trondmy@gmail.com>
Cc:     Anna Schumaker <Anna.Schumaker@netapp.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Trond,

These set of patches do not address the locking problem. It's actually
not the locking patch (which I thought it was as I reverted it and
still had the issue). Without the whole patch series the unlock works
fine so something in these new patches. Something is up with the 2
patches:
NFSv4: Handle NFS4ERR_OLD_STATEID in CLOSE/OPEN_DOWNGRADE
NFSv4: Handle NFS4ERR_OLD_STATEID in LOCKU

If I remove either one separately, unlock fails but if I remove both
unlock works.

On Mon, Sep 16, 2019 at 4:46 PM Trond Myklebust <trondmy@gmail.com> wrote:
>
> Various NFSv4 fixes to ensure we handle state errors correctly. In
> particular, we need to ensure that for COMPOUNDs like CLOSE and
> DELEGRETURN, that may have an embedded LAYOUTRETURN, we handle the
> layout state errors so that a retry of either the LAYOUTRETURN, or
> the later CLOSE/DELEGRETURN does not corrupt the LAYOUTRETURN
> reply.
>
> Also ensure that if we get a NFS4ERR_OLD_STATEID, then we do our
> best to still try to destroy the state on the server, in order to
> avoid causing state leakage.
>
> v2: Fix bug reports from Olga
>  - Try to avoid sending old stateids on CLOSE/OPEN_DOWNGRADE when
>    doing fully serialised NFSv4.0.
>  - Ensure LOCKU initialises the stateid correctly.
>
> Trond Myklebust (9):
>   pNFS: Ensure we do clear the return-on-close layout stateid on fatal
>     errors
>   NFSv4: Clean up pNFS return-on-close error handling
>   NFSv4: Handle NFS4ERR_DELAY correctly in return-on-close
>   NFSv4: Handle RPC level errors in LAYOUTRETURN
>   NFSv4: Add a helper to increment stateid seqids
>   pNFS: Handle NFS4ERR_OLD_STATEID on layoutreturn by bumping the state
>     seqid
>   NFSv4: Fix OPEN_DOWNGRADE error handling
>   NFSv4: Handle NFS4ERR_OLD_STATEID in CLOSE/OPEN_DOWNGRADE
>   NFSv4: Handle NFS4ERR_OLD_STATEID in LOCKU
>
>  fs/nfs/nfs4_fs.h   |  11 ++-
>  fs/nfs/nfs4proc.c  | 204 ++++++++++++++++++++++++++++++---------------
>  fs/nfs/nfs4state.c |  16 ----
>  fs/nfs/pnfs.c      |  71 ++++++++++++++--
>  fs/nfs/pnfs.h      |  17 +++-
>  5 files changed, 229 insertions(+), 90 deletions(-)
>
> --
> 2.21.0
>
