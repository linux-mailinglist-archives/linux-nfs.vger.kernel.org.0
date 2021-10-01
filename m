Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8391B41F274
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Oct 2021 18:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354576AbhJAQwC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 1 Oct 2021 12:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbhJAQv7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 1 Oct 2021 12:51:59 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9839C061775
        for <linux-nfs@vger.kernel.org>; Fri,  1 Oct 2021 09:50:14 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id w29so16452823wra.8
        for <linux-nfs@vger.kernel.org>; Fri, 01 Oct 2021 09:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=puzzle-itc.de; s=google;
        h=to:cc:references:from:organization:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Rsyvszb1A26dd6eichbXnm4rdUyDFF1unlohl0En06c=;
        b=P3LagZhHXELZRwp7IaErG3jj1R39OC5PzwnAmEDd+IFa/9TknBRR8p1qb25lU42gmP
         iXpyXxjkFQnCRzFYdaD8mbK7BGHx8p0gJ4qX9OJLNnQUXrI0P9IH4stQp+WrE3RbIa2/
         SavQwljVAQm8YW7eNeaVEk2KJflOQ244IJwoQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Rsyvszb1A26dd6eichbXnm4rdUyDFF1unlohl0En06c=;
        b=R6lkiBH2nN1q2tAHa16dtSvBLb3jBnTylKoPFqwO2O6hh6JJv81EQ4YxWoISCJ8KWv
         QqzlawxkZmRtkjeDvxvWUCLvcsiAlKhkqG36fMEJ7sQFO0KUNq0dk+R0TU53Xs1k07/q
         43v61f7YeJLUlLN9ts00PYzjbBIIvtEoDY4wdrXLh3GSmqiwC+jImHLyXDbRlMO+vHqi
         6mHvxu3bzjLB/syUcWmh+Usq0pOVuN035ECAKUoBaxEW4hqiIW6PdzO4Cm3O3O8rAhV+
         Kd6moDGHNkkauiHFi9i/ssCzhZ1wlJpvLZdI/KITWInJHMu4o4Vb5yFYan5+ZXBz/G5q
         HOBw==
X-Gm-Message-State: AOAM533G+b4UfF5gSIpUMMOg/DBpa8KQSNuMcu9ClurJ/2juHoOfmF20
        /eUGY/9cskt3CBWm3yUnhsIZeJqY3FLqQK9Yt31SsMNb4uh1jC2sZ9T+flpl7kl4bJDQPm/nk8U
        8SSX75QfvjqsOpA==
X-Google-Smtp-Source: ABdhPJyEt1syhcetzTllbDGL7fXAZaS8m8zdGHKZjNvr6f67cOqlKcgc8l6l4zvFOMQ4s2KvbOfGPg==
X-Received: by 2002:a5d:6d8a:: with SMTP id l10mr13757793wrs.121.1633107013389;
        Fri, 01 Oct 2021 09:50:13 -0700 (PDT)
Received: from tuedko18.puzzle-itc.de ([2a02:8070:888b:3700:a91e:d4a4:26a5:266c])
        by smtp.gmail.com with ESMTPSA id j7sm7282045wrr.27.2021.10.01.09.50.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Oct 2021 09:50:12 -0700 (PDT)
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org,
        Volodymyr Khomenko <volodymyr@vastdata.com>
References: <20211001135921.GC959@fieldses.org>
From:   Daniel Kobras <kobras@puzzle-itc.de>
Organization: Puzzle ITC Deutschland GmbH
Subject: Re: [PATCH] SUNRPC: fix sign error causing rpcsec_gss drops
Message-ID: <31738001-8f5b-61c9-67b6-810e6f188318@puzzle-itc.de>
Date:   Fri, 1 Oct 2021 18:50:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211001135921.GC959@fieldses.org>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Bruce!

Am 01.10.21 um 15:59 schrieb J. Bruce Fields:
> From: "J. Bruce Fields" <bfields@redhat.com>
>=20
> If sd_max is unsigned, then sd_max - GSS_SEQ_WIN is a very large number
> whenever sd_max is less than GSS_SEQ_WIN, and the comparison:
>=20
> 	seq_num <=3D sd->sd_max - GSS_SEQ_WIN
>=20
> in gss_check_seq_num is pretty much always true, even when that's
> clearly not what was intended.
>=20
> This was causing pynfs to hang when using krb5, because pynfs uses zero
> as the initial gss sequence number.  That's perfectly legal, but this
> logic error causes knfsd to drop the rpc in that case.  Out-of-order
> sequence IDs in the first GSS_SEQ_WIN (128) calls will also cause this.
>=20
> Fixes: 10b9d99a3dbb ("SUNRPC: Augment server-side rpcgss tracepoints")

I wonder about the Fixes tag: That changeset added tracepoints to the
exit path, but the buggy logic seems to have been present since the
pre-git ages. Or am I missing something about 10b9d99a3dbb? (This might
explain some reports of--as you stated elsewhere--"once in a blue moon
my krb5 mounts hang" we've investigated, albeit on kernels that predate
10b9d99a3dbb.)

Kind regards,

Daniel

> Cc: stable@vger.kernel.org
> Signed-off-by: J. Bruce Fields <bfields@redhat.com>
> ---
>  net/sunrpc/auth_gss/svcauth_gss.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svca=
uth_gss.c
> index 7dba6a9c213a..b87565b64928 100644
> --- a/net/sunrpc/auth_gss/svcauth_gss.c
> +++ b/net/sunrpc/auth_gss/svcauth_gss.c
> @@ -645,7 +645,7 @@ static bool gss_check_seq_num(const struct svc_rqst *=
rqstp, struct rsc *rsci,
>  		}
>  		__set_bit(seq_num % GSS_SEQ_WIN, sd->sd_win);
>  		goto ok;
> -	} else if (seq_num <=3D sd->sd_max - GSS_SEQ_WIN) {
> +	} else if (seq_num + GSS_SEQ_WIN <=3D sd->sd_max) {
>  		goto toolow;
>  	}
>  	if (__test_and_set_bit(seq_num % GSS_SEQ_WIN, sd->sd_win))
>=20


--=20
Daniel Kobras
Principal Architect
Puzzle ITC Deutschland
+49 7071 14316 0
www.puzzle-itc.de

--=20
Puzzle ITC Deutschland GmbH
Sitz der Gesellschaft: Eisenbahnstra=C3=9Fe 1, 72072=20
T=C3=BCbingen

Eingetragen am Amtsgericht Stuttgart HRB 765802
Gesch=C3=A4ftsf=C3=BChrer:=20
Lukas Kallies, Daniel Kobras, Mark Pr=C3=B6hl

