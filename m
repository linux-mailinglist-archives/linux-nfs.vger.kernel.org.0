Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66DC72CF53A
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Dec 2020 21:02:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbgLDUBZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 4 Dec 2020 15:01:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbgLDUBZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 4 Dec 2020 15:01:25 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96144C061A4F
        for <linux-nfs@vger.kernel.org>; Fri,  4 Dec 2020 12:00:44 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id qw4so10379672ejb.12
        for <linux-nfs@vger.kernel.org>; Fri, 04 Dec 2020 12:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=swiVvhEVC+yjxP5EYWrOXln6oIpSc/s/NOSTPz+GxnI=;
        b=iF4S0Pue0eHf6bLzwD0bS7KpH6U/oUzz7ZqRkpv2KCgpZltCA/i6R0JohK3mJn4hqH
         PxIsb55TizuCpCkVd6/feiTocj7qI7DlFVnE/I9YkSfa7LdBhc2P9sWLZZ7NDgl0fqN0
         EUxiT6/Ho8Hlgt3u2MdYbchMmeLfrI0LRWuRttobqqEHKrNJ2jFhQmRF4HWYQAhUr8hR
         7aVMz9JxVhw7EieWlBLBI+qVK+FIbpZUSLNyBb/TfPaNNDcY10/eCxvDaWs/8VW6ade5
         VYVAhZhTWzP5Zg2ANarVKLNMRNhyM3A/BFpC9LiFEVTKnYcGfNzWcEJd6WuS+9LOHYcS
         IDSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=swiVvhEVC+yjxP5EYWrOXln6oIpSc/s/NOSTPz+GxnI=;
        b=Bs/CxR41hoW3J4teRp+NjCOG5zp2ZWwY+j7Vmr06ULxPD2KCopBK6d3MXwvaQZ1DTq
         sXlUfPWIzCSuKKdvAbjPlrVDNrmV/ZRjEiE9K0V4i9GDpueMe2pvVbnl0Jv821MaRq6N
         9Rgjk3LWh7npW2PbYlQbGA8TMYWu9Aw6PAabe2R9++EoE06HpngtOGAnWMfzdgSbsRIW
         B0pwgA9WZXKRrjzEF3DJT/wNn2Zc6YDTjWEdfJ1IPHdlqEMC/mWF6iSdJYZPTeeOPWo/
         zotMGy9ygsnwi/IHb+TOFpkF1mHopI+1vAIM5Mfh7lGcyHN+mdwb2DX0qBZyc2wMSJPR
         n33A==
X-Gm-Message-State: AOAM530CjJfsurkWOazOJz8gHQZ6RKJIJAMuBg5ZwvubvNVQXJyRUhku
        SEwC3HS7dSsn/BDEjllMaXbSgUUWh42ZxgzWbCUrJo8/
X-Google-Smtp-Source: ABdhPJxF7dF77Hkwki2gHi7Zf8tgMrA4p3oG9tV1GLFjjoF8ZUZ30Iik0VCwFdzdmu9dipwXrg9JR29lbqfmC6nZEQI=
X-Received: by 2002:a17:906:ae14:: with SMTP id le20mr8860609ejb.451.1607112043325;
 Fri, 04 Dec 2020 12:00:43 -0800 (PST)
MIME-Version: 1.0
References: <20201203201841.103294-1-Anna.Schumaker@Netapp.com> <852166252.2305208.1607096860375.JavaMail.zimbra@desy.de>
In-Reply-To: <852166252.2305208.1607096860375.JavaMail.zimbra@desy.de>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Fri, 4 Dec 2020 15:00:32 -0500
Message-ID: <CAN-5tyFJeLRyDUdtGkheGkmDE=i-FJprLFiav_mEPA35QeKLQA@mail.gmail.com>
Subject: Re: [PATCH 0/3] NFS: Disable READ_PLUS by default
To:     "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
Cc:     schumaker anna <schumaker.anna@gmail.com>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        Anna Schumaker <Anna.Schumaker@netapp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I object to putting the disable patch in, I think we need to fix the problem.

The current problem is generic/263 is failing because the end of the
buffer is corrupted since we lost the bytes when hole was expanded. I
don't know what the solution is: (1) hole expanding handling needs to
be fixed to not lose data or (2) we shouldnt be reporting that we read
the bytes we lost.

On Fri, Dec 4, 2020 at 10:49 AM Mkrtchyan, Tigran
<tigran.mkrtchyan@desy.de> wrote:
>
> Hi Anna,
>
> I see problems with gedeviceinfo and bisected it to c567552612ece787b178e3b147b5854ad422a836.
> The commit itself doesn't look that can break it, but might
> be can help you find the problem.
>
> What I see, that after xdr_read_pages call the xdr stream points
> to a some random point (or wrong page)
>
> Regards,
>    Tigran.
>
>
> ----- Original Message -----
> > From: "schumaker anna" <schumaker.anna@gmail.com>
> > To: "linux-nfs" <linux-nfs@vger.kernel.org>
> > Cc: "Anna Schumaker" <Anna.Schumaker@Netapp.com>
> > Sent: Thursday, 3 December, 2020 21:18:38
> > Subject: [PATCH 0/3] NFS: Disable READ_PLUS by default
>
> > From: Anna Schumaker <Anna.Schumaker@Netapp.com>
> >
> > I've been scratching my head about what's going on with xfstests generic/091
> > and generic/263, but I'm not sure what else to look at at this point.
> > This patchset disables READ_PLUS by default by marking it as a
> > developer-only kconfig option.
> >
> > I also included a couple of patches fixing some other issues that were
> > noticed while inspecting the code. These patches don't help the tests
> > pass, but they do fail later on after applying so it does feel like
> > progress.
> >
> > I'm hopeful the remaning issues can be worked out in the future.
> >
> > Thanks,
> > Anna
> >
> >
> > Anna Schumaker (3):
> >  NFS: Disable READ_PLUS by default
> >  NFS: Allocate a scratch page for READ_PLUS
> >  SUNRPC: Keep buf->len in sync with xdr->nwords when expanding holes
> >
> > fs/nfs/Kconfig          |  9 +++++++++
> > fs/nfs/nfs42xdr.c       |  2 ++
> > fs/nfs/nfs4proc.c       |  2 +-
> > fs/nfs/read.c           | 13 +++++++++++--
> > include/linux/nfs_xdr.h |  1 +
> > net/sunrpc/xdr.c        |  3 ++-
> > 6 files changed, 26 insertions(+), 4 deletions(-)
> >
> > --
> > 2.29.2
