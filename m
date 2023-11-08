Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0B5F7E5F8E
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Nov 2023 22:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbjKHVA7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 8 Nov 2023 16:00:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjKHVA6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 8 Nov 2023 16:00:58 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9CE4213F
        for <linux-nfs@vger.kernel.org>; Wed,  8 Nov 2023 13:00:56 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6ce2b6b3cb6so48072a34.3
        for <linux-nfs@vger.kernel.org>; Wed, 08 Nov 2023 13:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1699477256; x=1700082056; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h7liRufg49/RU3WhlB+//eXGJe7JD0FPNb3R1JhYvKc=;
        b=a2iNtPfVtnq8V8pyeUR0Ws20fuOBnneSVB5f62PcOknnhWShE5E8s3HDtLp5eD3eXc
         +dSca1TMlnDZVX0tE6TewIf6iugtXHSzIMXsa3CqqCf4j/LaRHYoHQW8FuPyz554Qmfx
         UiYDFSInrksEVPPgpIJHWvwwtbP+42UqT190G6a+ArIAsIBmDl2/4i7Tz7IyVbp2JvN4
         1O8/p0fK45bJn5Olh9SxoiFfqr7HbQm6KwRq0W6G9QD2u0S876Au2Sz/GLDPDX1rfAIt
         sbg4XI/6TxhoRo2McdJ4ktehUfpYug1DPl2PxPV76DkN1xLKe/g22C7Eck3vuId+DgM6
         +wyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699477256; x=1700082056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h7liRufg49/RU3WhlB+//eXGJe7JD0FPNb3R1JhYvKc=;
        b=WUyWOEa4Qr0SbCOr/aK+UwC4l7ENNE6fgR4EOHOpcOiRPAsNfEX0UkjAzPkXlFTqxm
         1unVM7Sg7CDzMPalxcKY0CqVXjEysj8rECUCFVOHwngdG1DrZE5jy5JA2jW5+b0WiMuF
         Z2ZBU2Y4uzsB3LaZg9c9j3zk7Qc3UNeU7QyXir7KcNnIW2vTSlGKTUk5TZt6RIyx+w2C
         QjSPnWw/+YR8YXZi1j4sIfzYa+a+hFm5ZETET1RG60SeKd5Ebj2b+Jujdbu8U+vXT0J7
         SkoVWOIKPuDAbwxDIUoGo9SxdTgI5CsUzyjR/RDsAvLJdlIMpBLYzmNnJrG7Ffut+7nm
         z1RA==
X-Gm-Message-State: AOJu0YxjbxitXAaTcRYI4pWf2sVsRlqkskKfPrLbH7zSpeyI+obPPily
        pRYEaGx3raFbTNz4yGQPvXQdP2viTtDjASssy9B8
X-Google-Smtp-Source: AGHT+IEd0ZpMRgMDPqDg2Wh7KFXuaegxDDPWKJU3cYRlMeKgIo3eiH2A2tq9nK03p6GlcKcB7RZEC20oMr/OtISugh0=
X-Received: by 2002:a05:6870:20a:b0:1f0:630c:a589 with SMTP id
 j10-20020a056870020a00b001f0630ca589mr3530034oad.46.1699477256059; Wed, 08
 Nov 2023 13:00:56 -0800 (PST)
MIME-Version: 1.0
References: <20231031123207.758655-1-omosnace@redhat.com> <CAHC9VhRo2GzW0jSqmm0Sv3z_-q9PTsvScV5oQwF5uNh+ZcWreA@mail.gmail.com>
 <CAFqZXNtFfZ3FEoVAfM5r_a-mTqphz7qw=F3_Em87dRz6ca4EaQ@mail.gmail.com>
In-Reply-To: <CAFqZXNtFfZ3FEoVAfM5r_a-mTqphz7qw=F3_Em87dRz6ca4EaQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 8 Nov 2023 16:00:45 -0500
Message-ID: <CAHC9VhRO=s9yt+3xcDa1y7E4csz_7mOhuf51VFkMr+sN=Ez+Vg@mail.gmail.com>
Subject: Re: [PATCH 0/2] lsm: fix default return values for some hooks
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     linux-security-module@vger.kernel.org,
        Benjamin Coddington <bcodding@redhat.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Nov 8, 2023 at 4:30=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.com=
> wrote:
> On Wed, Nov 8, 2023 at 4:12=E2=80=AFAM Paul Moore <paul@paul-moore.com> w=
rote:
> > On Tue, Oct 31, 2023 at 8:32=E2=80=AFAM Ondrej Mosnacek <omosnace@redha=
t.com> wrote:
> > >
> > > Some of the default return values listed in <linux/lsm_hook_defs.h>
> > > don't match the actual no-op value and can be trivially fixed.
> > >
> > > Ondrej Mosnacek (2):
> > >   lsm: fix default return value for vm_enough_memory
> > >   lsm: fix default return value for inode_getsecctx
> > >
> > >  include/linux/lsm_hook_defs.h | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > These both look like reasonable -stable candidates to me, what do you t=
hink?
>
> Yes, that would be my assessment as well.

Okay, good.  I've just gone ahead and merged these into lsm/stable-6.7
and I'll plan to send them up to Linus on Thursday or Friday this
week.  Thanks.

--=20
paul-moore.com
