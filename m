Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C429E7EA630
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Nov 2023 23:57:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbjKMW5p (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 13 Nov 2023 17:57:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjKMW5p (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 13 Nov 2023 17:57:45 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C3221B5
        for <linux-nfs@vger.kernel.org>; Mon, 13 Nov 2023 14:57:41 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-5441ba3e53cso7449474a12.1
        for <linux-nfs@vger.kernel.org>; Mon, 13 Nov 2023 14:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699916260; x=1700521060; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iZ2W2huUmfaLUjGKY5af5fkFKDTlXtrKqV0nLw+bC/o=;
        b=gQrZebJhk1QywTHd7hKfN0iBGDhhiOGRwFudWAmq0dtH7L4QOpYumysu98BHK2Jjrz
         zp4WZRAlkTTVessgHMdGcTpfRJuOI3UTWRs4t1f/6GtylfCgrXBs+drP0C//0Xgje4jB
         n6JmZ3adIxZbEwxnfT56EIM7Z6iQg3PJBROwgW0It7vlRngoSV9iM0wqBLeQW8LUGFVo
         fiCSR+OLp9rN09HE12cD+Tsfwx1L18nE6AaMvQmNU7u0ywwwW/jyfe+G+q2TRtew4Y7h
         KV2YBKOuHp2SPki5Vvcu+SdPje8HNa9bGwg/26E2sjvFS5+oi6NssNpF1/oo6sh+Vuup
         UP9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699916260; x=1700521060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iZ2W2huUmfaLUjGKY5af5fkFKDTlXtrKqV0nLw+bC/o=;
        b=qrU48xgJIOeQGB+varGNhr0tT0hyYEwPSVmQ/ljRAA2OMT2Fi4UgNfQtU0aEoYcF7m
         Scos7YNSjUVGCE07o0lxIUQKoFkZhBbrkBTEVLk84m2hWQP5zIfY1uddkkS1pLDfxHgH
         u/GE3dCY3fS4XLDeMFL5JVJWmOHdXkGY0q08feuZTUNjf3zD1W9uQJguWKSNvAK3s4JA
         L/cmTYNlwLAnTvJ1UEDd7Xdgp+eozV6RlYmmvlcx32wRqUbdOIGdgXcI/8b6it/8X5EY
         dDHoJaEUE5s2xOrr7aEa51zwscM67ArUlRtvhBsd1pdpj6CY9yDmwgDGrZuxPOWRqmwB
         x6Mw==
X-Gm-Message-State: AOJu0Yw2HltG1w6JIOxhBLcmyk8FpBLAuz29gbF1crY9KJixO7kFODaH
        FdscxAJmFvdNFy4+P+BXMQTgh/daIWolc3zdwKs=
X-Google-Smtp-Source: AGHT+IGKP4CrpV3LZfgii7HyTE7NQx3QKNhrejVFYHjSTeivW9C7ZxvTB2fmjjO5Ug8gGYl5hASbGDVXOw4fuYNxVYg=
X-Received: by 2002:aa7:d587:0:b0:540:b0ec:bcc7 with SMTP id
 r7-20020aa7d587000000b00540b0ecbcc7mr5740640edq.5.1699916259733; Mon, 13 Nov
 2023 14:57:39 -0800 (PST)
MIME-Version: 1.0
References: <CANH4o6Md0+56y0ZYtNj1ViF2WGYqusCmjOB6mLeu+nOtC5DPTw@mail.gmail.com>
 <DD47B60A-E188-49BC-9254-6C032BA9776E@redhat.com> <CANH4o6NzV2_u-G0dA=hPSTvOTKe+RMy357CFRk7fw-VRNc4=Og@mail.gmail.com>
 <5ED71FE7-B933-44AC-A180-C19EC426CBF8@oracle.com>
In-Reply-To: <5ED71FE7-B933-44AC-A180-C19EC426CBF8@oracle.com>
From:   Cedric Blancher <cedric.blancher@gmail.com>
Date:   Mon, 13 Nov 2023 23:57:03 +0100
Message-ID: <CALXu0UeZgnWbMScdW+69a_jvRxM2Aou0fPvt0PG6eBR3wHt++Q@mail.gmail.com>
Subject: Re: NFSv4 referrals - custom (non-2049) port numbers in fs_locations?
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Martin Wege <martin.l.wege@gmail.com>,
        Benjamin Coddington <bcodding@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 13 Nov 2023 at 17:19, Chuck Lever III <chuck.lever@oracle.com> wrot=
e:
>
>
>
> > On Nov 10, 2023, at 2:54=E2=80=AFAM, Martin Wege <martin.l.wege@gmail.c=
om> wrote:
> >
> > On Wed, Nov 1, 2023 at 3:42=E2=80=AFPM Benjamin Coddington <bcodding@re=
dhat.com> wrote:
> >>
> >> On 1 Nov 2023, at 5:06, Martin Wege wrote:
> >>
> >>> Good morning!
> >>>
> >>> We have questions about NFSv4 referrals:
> >>> 1. Is there a way to test them in Debian Linux?
> >>>
> >>> 2. How does a fs_locations attribute look like when a nonstandard por=
t
> >>> like 6666 is used?
> >>> RFC5661 says this:
> >>>
> >>> * http://tools.ietf.org/html/rfc5661#section-11.9
> >>> * 11.9. The Attribute fs_locations
> >>> * An entry in the server array is a UTF-8 string and represents one o=
f a
> >>> * traditional DNS host name, IPv4 address, IPv6 address, or a zero-le=
ngth
> >>> * string.  An IPv4 or IPv6 address is represented as a universal addr=
ess
> >>> * (see Section 3.3.9 and [15]), minus the netid, and either with or w=
ithout
> >>> * the trailing ".p1.p2" suffix that represents the port number.  If t=
he
> >>> * suffix is omitted, then the default port, 2049, SHOULD be assumed. =
 A
> >>> * zero-length string SHOULD be used to indicate the current address b=
eing
> >>> * used for the RPC call.
> >>>
> >>> Does anyone have an example of how the content of fs_locations should
> >>> look like with a custom port number?
> >>
> >> If you keep following the references, you end up with the example in
> >> rfc5665, which gives an example for IPv4:
> >>
> >> https://datatracker.ietf.org/doc/html/rfc5665#section-5.2.3.3
> >
> > So just <address>.<upper-byte-of-port-number>.<lower-byte-of-port-numbe=
r>?
>
> > How can I test that with the refer=3D option in /etc/exports? nfsref
> > does not seem to have a ports option...
>
> Neither refer=3D nor nfsref support alternate ports for exactly the
> same reason: The mountd upcall/downcall, which is how the kernel
> learns of referral target locations, needs to be fixed first. Then
> support for alternate ports can be implemented in both refer=3D and
> nfsref.

Just turn "hostname" into "hostport", i.e. the "hostname" string in
the mountd protocol gets the port number encoded into it. Problem
done. This is seriously a non-brainer, and can be repeated for autofs,
which does not do port number either,

Ced
--=20
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur
