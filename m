Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE4336C5E4
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Apr 2021 14:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236152AbhD0MNw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 27 Apr 2021 08:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235410AbhD0MNt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 27 Apr 2021 08:13:49 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51EE9C061574
        for <linux-nfs@vger.kernel.org>; Tue, 27 Apr 2021 05:13:06 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id ja3so13283081ejc.9
        for <linux-nfs@vger.kernel.org>; Tue, 27 Apr 2021 05:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UFzYx95fCpTKdBvczj9jKieBWg1KYVsjciv6B7VRpXY=;
        b=PCJWmF345jck+HVwRPWApCZIR57fYkHHTo4s1zHYs6+WOyu/b9BChyouTs55O6PXdT
         vWOD0IzuDOaV17xLr7c+ZEzuRdZf+KKfdKeVPWOqklP4Tm1SNUpwJqcaT0xDnMQFQipe
         6FK+kbtxi8KueCxAbUlhHFLQopyIr9e8IbGtwjscnmtb7PPklENfx+4esKuEP3LTZsTI
         GLyeRTDDIIMau1o75YU5rc52z5EGPfKVzAE8M0PqevW4dxF6BqtZTyflke6nkkJed/Qi
         KbEutBTlgVnIAd6afrUOTpmMkD0TOMyo4fPOLmPwkFSmUmn/SRwT+AROk9lR+lDkA5GD
         f/hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UFzYx95fCpTKdBvczj9jKieBWg1KYVsjciv6B7VRpXY=;
        b=W2BKM3VSBn7c7Ehc+O/VNffNf8C1t8sedHY29tCD80ekxcDcBT4Coah/wnZ4tnB1Vn
         WzPh+yqHkAsvKlqPgHYTzwwUXYUjLJP8uV+W938IdLTifRTDltOdAF99Np1RxApSk6uX
         DBdZGm++Tk/GFu0MyumB6MrMUCUfFbRMu6ZcafEBYCGxbfSROysqQFV+P114gsTVPjTg
         Bu8cZSBZk0UdsEhzR43df1tiEVIIkdGsdcDRA4q6dgOQ0iz8zB/HIbHkwaV4eWiIVZ9a
         byZ5AatPQDYHgxfkYkm/ukUIE/Djj+44NUg5g3SfcOm0MPlxwavYrBC+SAU4ZWRyCMRS
         jVAg==
X-Gm-Message-State: AOAM530VNaiGO0/HtmkOFzHK7lHpB8HjRSnqJHlsRElmiShydXBZj/JN
        ham+/IJVJ7VvvrsZCLTUa0ijVw6X4ivCTcuqrZ8=
X-Google-Smtp-Source: ABdhPJwumVgN7kEJ75+1p7kOs2u30ruEbEI24AJNmXwHkKyGdcWCQmJmyyPsvHB8Hs4IyN762dZIbkKslv3U1RF8fhs=
X-Received: by 2002:a17:907:2708:: with SMTP id w8mr11336563ejk.0.1619525585020;
 Tue, 27 Apr 2021 05:13:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210426171947.99233-1-olga.kornievskaia@gmail.com>
 <20210426171947.99233-10-olga.kornievskaia@gmail.com> <20210427044214.vlbmbfdh5dpq4vhl@gmail.com>
In-Reply-To: <20210427044214.vlbmbfdh5dpq4vhl@gmail.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Tue, 27 Apr 2021 08:12:53 -0400
Message-ID: <CAN-5tyHPHk891-NkHt=6o+OuxRB+0ZqQRKqJ=hFThE=oYM0V7Q@mail.gmail.com>
Subject: Re: [PATCH v3 09/13] sunrpc: add a symlink from rpc-client directory
 to the xprt_switch
To:     Dan Aloni <dan@kernelim.com>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Apr 27, 2021 at 12:42 AM Dan Aloni <dan@kernelim.com> wrote:
>
> On Mon, Apr 26, 2021 at 01:19:43PM -0400, Olga Kornievskaia wrote:
> > From: Olga Kornievskaia <kolga@netapp.com>
> >
> > An rpc client uses a transport switch and one ore more transports
> > associated with that switch. Since transports are shared among
> > rpc clients, create a symlink into the xprt_switch directory
> > instead of duplicating entries under each rpc client.
> >
> > Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> >
> >..
> > @@ -188,6 +204,11 @@ void rpc_sysfs_client_destroy(struct rpc_clnt *clnt)
> >       struct rpc_sysfs_client *rpc_client = clnt->cl_sysfs;
> >
> >       if (rpc_client) {
> > +             char name[23];
> > +
> > +             snprintf(name, sizeof(name), "switch-%d",
> > +                      rpc_client->xprt_switch->xps_id);
> > +             sysfs_remove_link(&rpc_client->kobject, name);
>
> Hi Olga,
>
> If a client can use a single switch, shouldn't the name of the symlink
> be just "switch"? This is to be consistent with other symlinks in
> `sysfs` such as the ones in block layer, for example in my
> `/sys/block/sda`:
>
>     bdi -> ../../../../../../../../../../../virtual/bdi/8:0
>     device -> ../../../5:0:0:0

I think the client is written so that in the future it might have more
than one switch?

>
>
> --
> Dan Aloni
