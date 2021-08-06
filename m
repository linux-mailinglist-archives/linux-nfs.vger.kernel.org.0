Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 287573E302E
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Aug 2021 22:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244636AbhHFUMw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 6 Aug 2021 16:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244426AbhHFUMw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 6 Aug 2021 16:12:52 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C59BEC0613CF
        for <linux-nfs@vger.kernel.org>; Fri,  6 Aug 2021 13:12:34 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id i6so14730714edu.1
        for <linux-nfs@vger.kernel.org>; Fri, 06 Aug 2021 13:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AmpSKDdHkrsEDDHUGuoqCuytr0WqvHAJwTc46DXpH/c=;
        b=GPXbTQl2VB4+epJgG2oiAfT88YWlHVAsrtH/MxYdw/B1eIJOz0125/RxUHvVApqaz8
         VtuYK8ZDwkskcmnokr+yTcuvAbVfokFigy3cA/Mp/1m94uzD/nf82jc8HQryNI68LE2l
         EUvrwdCms5UcDD1VWJrAq/F7q4zMS2UTU+SPBTSRKl2grdg0WkwTixUxmjaKx1GI9FC3
         ZPHOIEOdtvuC6uL9WUzyyKIr50i3lM6wljyf5uODbNrL7oZXy3sAKxIQaloBt2fIxYDF
         xzIbRo+otpzbmTDtfDGz4Io+XglrmPr5Ed3C122HnxQbru03gHbpGFYONpSjKzpWM8b8
         txPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AmpSKDdHkrsEDDHUGuoqCuytr0WqvHAJwTc46DXpH/c=;
        b=PBnZYObvufbr6kAVeamCAqw9WHkjNWfeffi8KPCPBRl6HTzG5scmrzrtyX5geKvxHg
         4NGqVxK2/mJrZJWzWigyK2dasdi7GANNmUyfmwBsyKTx4FmjlXrdqXFp2CWhbs0h9bD1
         vhPzVxkgsvvkjiFAWeoDiDP6Zh/8vHqXZFBtfrz2SYCckpCn7Dwurb/tDWlROtYSKjtV
         KAi2URW/pfWXhvDuVm0iTgkqiyT1toqk1t77GOBGEsegkdv3Vbxc6JoIFlVeGjqvLHd/
         kpi1TxopUuHIS04WQIXUCjG8NT0Mz0tWeS76UlA+JoM1VVClHsJAOMhMAtIxvG/PA94w
         RO9w==
X-Gm-Message-State: AOAM5332a5alIlaJxPBL0I1aXTZquzIn+TFTdjEYYXRVD+aHIF42S3CP
        d4D1Rgkx+LW270Xg3YqPM2AUuNGVpF02x3391c4=
X-Google-Smtp-Source: ABdhPJyrVDxg+TIC59kTSrdYyMXUx7GH5kOKYv4ton2PbdGX6FEMkV41vp2vu4D2PR6090yf1AqCf9rgNHoHw2h0DH4=
X-Received: by 2002:a05:6402:34c4:: with SMTP id w4mr4768117edc.67.1628280753331;
 Fri, 06 Aug 2021 13:12:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210616011013.50547-1-olga.kornievskaia@gmail.com> <20210616011013.50547-7-olga.kornievskaia@gmail.com>
In-Reply-To: <20210616011013.50547-7-olga.kornievskaia@gmail.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Fri, 6 Aug 2021 16:12:22 -0400
Message-ID: <CAN-5tyGque598rzk2GQK3u=sWP35DHndJw50mWM-zfzF46L6oQ@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] NFSv4 allow for nconnect value of trunkable transport
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello folks (Chuck, Trond have graciously participated previously and
I look forward to hearing back from you),

I would like to restart the conversation about the client's behaviour
with regards to discovered truncable transports.

I have put forth a version and patch 6 is the one that deals with the
combination of trunkable transport and nconnect and I look for
feedback from the community. I have written my views in the comments
in the patch.

My current position is: given that it's unclear how to reconcile
managing connections to the same IP together with connections to other
IPs. I propose we don't bring in nconnect  in play when truncable
transport is discovered (basically option #2 in my comments below). I
believe that's the simplest thing to do now and we can add nconnect
behaviour later.

Thank you.


On Tue, Jun 15, 2021 at 9:10 PM Olga Kornievskaia
<olga.kornievskaia@gmail.com> wrote:
>
> From: Olga Kornievskaia <kolga@netapp.com>
>
> If the new mount asked for nconnect mount, then create old client
> number of connections to the destination address that has been
> established as the same server with trunkable address.
>
> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
>
> --- There might be a number of objection to this patch. One
> I can think of is that this patch creates the nconnects based on
> whether or not the new mount asked for nconnect instead of
> unconditionally creating nconnect number of connections. The patch
> still creates nconnect connections based on the original value
> instead of picking the value of clp->cl_nconnect. I would have
> preferred that would be done. I don't see what can be wrong with
> using the new value. But I feared to go against what was objected
> before. My preference would be to (1) create clp->cl_nconnect
> connections or (2) not use this patch at all or (3) use as is
> here (meaning at least not create extra connections unless asked
> for by the mount).
> ---
>  fs/nfs/nfs4client.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
> index af57332503be..50fa9d53b444 100644
> --- a/fs/nfs/nfs4client.c
> +++ b/fs/nfs/nfs4client.c
> @@ -427,6 +427,15 @@ static void nfs4_add_trunk(struct nfs_client *clp, struct nfs_client *old)
>
>         rpc_clnt_add_xprt(old->cl_rpcclient, &xprt_args,
>                           rpc_clnt_test_and_add_xprt, NULL);
> +
> +       if (clp->cl_nconnect > 1) {
> +               int i;
> +
> +               for (i = 0; i < old->cl_nconnect - 1; i++)
> +                       if (rpc_clnt_add_xprt(old->cl_rpcclient, &xprt_args,
> +                                             NULL, NULL) < 0)
> +                               break;
> +       }
>  }
>
>  /**
> --
> 2.27.0
>
