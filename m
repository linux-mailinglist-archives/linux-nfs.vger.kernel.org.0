Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC0037FFBD
	for <lists+linux-nfs@lfdr.de>; Thu, 13 May 2021 23:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233437AbhEMVTg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 13 May 2021 17:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233421AbhEMVTd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 13 May 2021 17:19:33 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B52C061574
        for <linux-nfs@vger.kernel.org>; Thu, 13 May 2021 14:18:21 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id k10so10569828ejj.8
        for <linux-nfs@vger.kernel.org>; Thu, 13 May 2021 14:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M01C2fZMqcHUcLVFtRi4PocgfBCLnoPYqt52x2I+p50=;
        b=mrGBJBiukLLBTr13cWEBLfXJDXued3EVhwJ83I6jjp4O5v/9wq8i7BIb2XYEk3f0S8
         Jcs/8fj2E49r648OSArycLj2Mxk8YLQZOR/FoW15VnjDNS6YuvZMrHIvlF4YNCGqjMQp
         eqMKPt9JwQaR9FOM+LX4VjCDl/AgvSKS8YpGgATmQFBWb46/pi9bpj5EzKMmu07ASujn
         hj2MYtiSR+Kx5p0Rpf5G4uiRpdkoRmRgpYFHRYtXIwS9DE8Cs8QEYwmic07TO87OSvp7
         wanlAMuMBIny66OHBsQRSJPVWHoCMQh8e13BJw/oXMU/Jgeh/BMKufQzAFQgbzjiKBfd
         XxZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M01C2fZMqcHUcLVFtRi4PocgfBCLnoPYqt52x2I+p50=;
        b=EQcVu3ZP5IH78A0xI8ly4p4UL/8c0yio213QdT6PnrMb1OeiUTYZvqQXjozRkCnp4k
         VZs/vRj8ec9vRsMbsyk+7AHbzsThr+nhf98puEfQ5S/DWVrLFHET1oFE/Ah3S2OimnB6
         GM+NOhha2FNq9rBg4sEdhZkEFhTfyqaIAYQbol5zy0pCEYJZfKmXAsm1BrmK6oUd5TWJ
         wLqU58ab838CGrAWpL+r9D30NNzt9M+dVR9gj7ONQVEiWnUI6s3Pj7xWzbuOjfgG3gXa
         HprZNuyxUP1AkrXAWwcYvzBrN/UxOcP1S98nu/U9UGF9xsWJE49WSZ4EW8j1LjI/RZEW
         M7/Q==
X-Gm-Message-State: AOAM530O+4zlqBiKD5aIXwp0IrVxtaLdA09LKtCC9hnxbSTxm2pVHCuX
        YnSjJpKUS6F8GDPnDoerIZnfq7hoQU3WIIzws88=
X-Google-Smtp-Source: ABdhPJzshDT0rVidhKAQJGiqJkBgUd1l4a4H+lI9ezFDLO7klZG/yTzp4COnP0Ws1Xl7dZsihS77MdM8biqt5RCNFOg=
X-Received: by 2002:a17:906:e105:: with SMTP id gj5mr46953790ejb.388.1620940700503;
 Thu, 13 May 2021 14:18:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210426171947.99233-1-olga.kornievskaia@gmail.com>
 <20210426171947.99233-10-olga.kornievskaia@gmail.com> <20210427044214.vlbmbfdh5dpq4vhl@gmail.com>
In-Reply-To: <20210427044214.vlbmbfdh5dpq4vhl@gmail.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Thu, 13 May 2021 17:18:09 -0400
Message-ID: <CAN-5tyGe32FEeK0+bnMU16zu5Y6RkVqEey4G3VocEtx8vSQwiw@mail.gmail.com>
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
>

Jumping back to this comment because now that I went back to try to
modify the code I'm having doubts.

We still need numbering of xprt switches because they are different
for different mounts. So xprt_switches directory would still have
switch-0 for say a mount to server A and then switch-0 for a mount to
server B.  While yes I see that for a given rpc client that's making a
link into a xprt_switches directory will only have 1 link. And "yes"
the name of the link could be "switch". But isn't it more informative
to keep this to be the same name as the name of the directory under
the xprt_switches?

>
> --
> Dan Aloni
