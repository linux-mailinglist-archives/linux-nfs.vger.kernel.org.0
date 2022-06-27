Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2909755DEDA
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Jun 2022 15:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236519AbiF0S6W (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 27 Jun 2022 14:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240337AbiF0S5X (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 27 Jun 2022 14:57:23 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544A610FF
        for <linux-nfs@vger.kernel.org>; Mon, 27 Jun 2022 11:57:18 -0700 (PDT)
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0A8FA3F0C0
        for <linux-nfs@vger.kernel.org>; Mon, 27 Jun 2022 18:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1656356235;
        bh=zR2xWZau/XPeyKSmcjnGBY11HfciSu5RUfqC0sQi5aQ=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Content-Type;
        b=MLen4X0lmWRxJ9Prz2vzgUeC4Iyf9VM3QDfYUO0FkwX94vuYHM1oqCZ9u5Sh/XTmA
         IeEBDnV0Fd/daiEwmDIR0twQrqF6dpNfkor8xVs8aSQTxEhJ/nVfwCMAHUbZHPVfbl
         c6igs4En7yhJLGyjKMs10x5PyCXY30M7R3PvgTwnHgtkgu3dc3jPGPJcKFBAfspp8n
         ZizHogPFfqc9bbifSs/R4lRUG+VeG/SXoBbYXBRjq/ixMMM8loRAHD+bgrysV1f2jT
         l8+ZiGneoIrAE7ZdKWRnpcM6/ZE4fjqmAHn48ZzSRD0P6Xa+HLly+0Ks+KTKNX9dIg
         omumKOUb/D9/w==
Received: by mail-ej1-f72.google.com with SMTP id sb34-20020a1709076da200b00722f4a9865bso2777796ejc.1
        for <linux-nfs@vger.kernel.org>; Mon, 27 Jun 2022 11:57:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=zR2xWZau/XPeyKSmcjnGBY11HfciSu5RUfqC0sQi5aQ=;
        b=gqEsQneQE/vUy6cl+EZuDc08wLtmw548zD/19sZyP2hEa36xVpGgf6GtQK6ZJyk/8m
         Kxc2pU0yoNa03pKfuuNrGY7SZaVcaCy7dHRb+j1xZGr2OMkgI22/9hmq7Snn+wHHJeqJ
         I5ffuatAl+FauP+DUJiGf4X7SefSkwkBmHl+v3646WkK/N/2ztZb6Y9VFgZD07Co7sBm
         AckXolVguucgOZ37zp3QtOGgJYdw43dadc2f08CRrgwDWAP/VlnOWSYlBsiaFpAwfyiq
         4QbKI6WhGgUQXNkDMo93aE8W36Ft/bEfEVuRNXMT8+G3F4VZ4nyb6MpmbIm5qGxaEe+P
         ezzQ==
X-Gm-Message-State: AJIora+Bdv29QuvkmVDL3fIoFr62OitxPCERdgDBayjHP6WiS+4O43z4
        dXOsHghFF8m38znzzmhWKzUyTmoScTjCtelC39K3lf7Q9rRtHrjJ7z9R5IZkNC4zbCPCaljkfAg
        6JADUq04b+IN8U0/5q5kDeXXCW4LrQpaTn3fS3ULHt2HeBHZoPmuneA==
X-Received: by 2002:a17:907:1c8a:b0:6e9:2a0d:d7b7 with SMTP id nb10-20020a1709071c8a00b006e92a0dd7b7mr13628795ejc.572.1656356234714;
        Mon, 27 Jun 2022 11:57:14 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tGJ6l0PTdbHTYYsj1l5JuvDw7I37VDj1drVDSe/jx/RcA3Nc4k/D3IYdrVSFuHye5JBlbi/we+EQqPvlCFIwo=
X-Received: by 2002:a17:907:1c8a:b0:6e9:2a0d:d7b7 with SMTP id
 nb10-20020a1709071c8a00b006e92a0dd7b7mr13628778ejc.572.1656356234452; Mon, 27
 Jun 2022 11:57:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220607081909.1216287-1-marcel@linux-ng.de> <20220607081909.1216287-3-marcel@linux-ng.de>
In-Reply-To: <20220607081909.1216287-3-marcel@linux-ng.de>
From:   Andreas Hasenack <andreas@canonical.com>
Date:   Mon, 27 Jun 2022 18:57:03 +0000
Message-ID: <CANYNYEG553LGsgf47nM+Y-nDO=oQLaCrfPAFG+_vsXWrh3u+Zg@mail.gmail.com>
Subject: Re: [PATCH 3/3] cifs-utils/svcgssd: Add (undocumented) config options
 to man page
To:     linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URI_NOVOWEL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On the heels of this patch, you might want to add this tiny bit to
also update the nfs.conf(5) manpage:
--- a/systemd/nfs.conf.man
+++ b/systemd/nfs.conf.man
@@ -283,7 +283,10 @@
 .TP
 .B svcgssd
 Recognized values:
-.BR principal .
+.BR principal ,
+.BR verbosity ,
+.BR rpc-verbosity ,
+.BR idmap-verbosity .

 See
 .BR rpc.svcgssd (8)

On Tue, Jun 7, 2022 at 8:19 AM <marcel@linux-ng.de> wrote:
>
> From: Marcel Ritter <marcel@linux-ng.de>
>
> There seem to be some undocumented options implemented.
> Why not mention them in the man page?
>
> ---
>  utils/gssd/svcgssd.man | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/utils/gssd/svcgssd.man b/utils/gssd/svcgssd.man
> index 15ef4c94..8771c035 100644
> --- a/utils/gssd/svcgssd.man
> +++ b/utils/gssd/svcgssd.man
> @@ -61,6 +61,19 @@ this is equivalent to the
>  option.  If set to any other value, that is used like the
>  .B -p
>  option.
> +.TP
> +.B verbosity
> +Value which is equivalent to the number of
> +.BR -v .
> +.TP
> +.B rpc-verbosity
> +Value which is equivalent to the number of
> +.BR -r .
> +.TP
> +.B idmap-verbosity
> +Value which is equivalent to the number of
> +.BR -i .
> +
>
>  .SH SEE ALSO
>  .BR rpc.gssd(8),
> --
> 2.34.1
>
