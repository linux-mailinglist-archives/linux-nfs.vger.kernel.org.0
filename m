Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5A37420609
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Oct 2021 08:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232720AbhJDGwK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 4 Oct 2021 02:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232750AbhJDGwJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 4 Oct 2021 02:52:09 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 155F9C061745
        for <linux-nfs@vger.kernel.org>; Sun,  3 Oct 2021 23:50:21 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id t8so28966934wri.1
        for <linux-nfs@vger.kernel.org>; Sun, 03 Oct 2021 23:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=puzzle-itc.de; s=google;
        h=to:cc:references:from:organization:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=b2sz41UKr3wRMVuvl8In0+lVUcPOb9MC2yBBYv71nj8=;
        b=WjVSq3Kf5i1rR6YpTJKiTx0R6zfyHJ6qxpob/CkBxFAYfzOC6JD/tTGg9th+lzmNNu
         gNfLZL63/Q2A3tVrrv6ZTXL5v6KA7I6y53JijB0oh1MrN9f0ajSq62NENdPVihCRoO6G
         OvLIanLHXUKp0WkGsjPzzO1QvZ00VyJFFhqS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=b2sz41UKr3wRMVuvl8In0+lVUcPOb9MC2yBBYv71nj8=;
        b=QZI4YR19V6n6KIMAXhMEwDvAReC72ES3Mw797H8efF8pf/MRttOGZWAN2WLtbIF+bD
         QL2AFeUSG9n/0vKz+tCXADqYAXYjs4a3OECsYMgFtmxtD/+dJrbEAhrD78e7L67gH/LH
         /B980gawbLj808vitOAVKhe2x/0zfpG+Ul4rFBT6qfA3nteZxzeJxmmQseQFLw/wUSvY
         jLPu9Cvmyc6WvGXhnfbqCDK7vONEWTY0fUf7AAWdHGc4P0EJl9fHH5EpLDRjpPDtiZiR
         KwvTfiMzeW0fSHnoRbhEZttjiYqGqSWy0myTdIYbEU+dr/RPXkozGTfxshXnGeFMPrBZ
         J4PA==
X-Gm-Message-State: AOAM531xbVw/5YkScAi5Ev58NnlG86eGl6NT8GYz1kIwMghlPx4f1Ljo
        2+LXpXhvn25x+POAZc64MleQzL2wTp0A1X6pvp+MWnPBuWzihKYgA0ysRaD624JvPRfBGSxvyW0
        cBPy8TrSopOPmXamalWm2MQ==
X-Google-Smtp-Source: ABdhPJz6YErjhp5eM3CJEkRlO1Bkf0lXhKUIFqZ3XRrtRmsilEv2KWYGdKYH6sHO3E2AnfG+3LfDWg==
X-Received: by 2002:adf:a38d:: with SMTP id l13mr7694547wrb.103.1633330219605;
        Sun, 03 Oct 2021 23:50:19 -0700 (PDT)
Received: from tuedko18.puzzle-itc.de ([2a02:8070:888b:3700:900d:cdcb:2241:176d])
        by smtp.gmail.com with ESMTPSA id p3sm6671222wmp.43.2021.10.03.23.50.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Oct 2021 23:50:19 -0700 (PDT)
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
        Volodymyr Khomenko <volodymyr@vastdata.com>
References: <20211001135921.GC959@fieldses.org>
 <31738001-8f5b-61c9-67b6-810e6f188318@puzzle-itc.de>
 <20211001174429.GH959@fieldses.org>
From:   Daniel Kobras <kobras@puzzle-itc.de>
Organization: Puzzle ITC Deutschland GmbH
Subject: Re: [PATCH] SUNRPC: fix sign error causing rpcsec_gss drops
Message-ID: <6b93a085-fea3-bf93-ac60-2d19b2694e78@puzzle-itc.de>
Date:   Mon, 4 Oct 2021 08:50:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211001174429.GH959@fieldses.org>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Bruce!

Am 01.10.21 um 19:44 schrieb J. Bruce Fields:
> On Fri, Oct 01, 2021 at 06:50:12PM +0200, Daniel Kobras wrote:
>> Am 01.10.21 um 15:59 schrieb J. Bruce Fields:
>>> From: "J. Bruce Fields" <bfields@redhat.com>
>>>
>>> If sd_max is unsigned, then sd_max - GSS_SEQ_WIN is a very large number
>>> whenever sd_max is less than GSS_SEQ_WIN, and the comparison:
>>>
>>> 	seq_num <=3D sd->sd_max - GSS_SEQ_WIN
>>>
>>> in gss_check_seq_num is pretty much always true, even when that's
>>> clearly not what was intended.
>>>
>>> This was causing pynfs to hang when using krb5, because pynfs uses zero
>>> as the initial gss sequence number.  That's perfectly legal, but this
>>> logic error causes knfsd to drop the rpc in that case.  Out-of-order
>>> sequence IDs in the first GSS_SEQ_WIN (128) calls will also cause this.
>>>
>>> Fixes: 10b9d99a3dbb ("SUNRPC: Augment server-side rpcgss tracepoints")
>>
>> I wonder about the Fixes tag: That changeset added tracepoints to the
>> exit path, but the buggy logic seems to have been present since the
>> pre-git ages. Or am I missing something about 10b9d99a3dbb?
>=20
> The relevant parts of 10b9d99a3dbb were:
>=20
>  struct gss_svc_seq_data {
>         /* highest seq number seen so far: */
> -       int                     sd_max;
> +       u32                     sd_max;
>=20
> and
>=20
> -gss_check_seq_num(struct rsc *rsci, int seq_num)
> +static bool gss_check_seq_num(const struct svc_rqst *rqstp, struct rsc *=
rsci,
> +                             u32 seq_num)
>=20
> Together, they mean the comparison
>=20
> 	seq_num <=3D sd->sd_max - GSS_SEQ_WIN
>=20
> in the case sd_max is zero, effectively ends up being
>=20
> 	seq_num <=3D 4294967168
>=20
> instead of what was intended,
>=20
> 	seq_num <=3D -128
>=20
> .

Sorry, indeed I had missed the change in signedness. Thanks for elaborating=
!

>> (This might explain some reports of--as you stated elsewhere--"once in
>> a blue moon my krb5 mounts hang" we've investigated, albeit on kernels
>> that predate 10b9d99a3dbb.)
>=20
> Sounds like it was something else, I'm afraid!

Darn! ;-)

Kind regards,

Daniel
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

