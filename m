Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA77A7E7FF6
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Nov 2023 19:03:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234613AbjKJSDA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 10 Nov 2023 13:03:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235538AbjKJSCY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 10 Nov 2023 13:02:24 -0500
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B96884B
        for <linux-nfs@vger.kernel.org>; Thu,  9 Nov 2023 23:55:13 -0800 (PST)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-1ea48ef2cbfso1001441fac.2
        for <linux-nfs@vger.kernel.org>; Thu, 09 Nov 2023 23:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699602912; x=1700207712; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bs83gGPnw34/z9+aqifKBNPKc0tEy6BpwSpebU68fXw=;
        b=lplrjcjH3+nNoSWCCuc6WGMorjzFX9qztJzxQcDCscfBibtZWF91zwKEyAwhYUntT3
         evX2BMLjjiPRiz5eLVTvcPUdJKuNloZHt5E0RxHQ2X0sVlhQX/9QoKEk2iJOCkExtw18
         aLEdyS5LbnyMq4NAsg1TV05jtURYJ5XfAp3yWNQhGUjkDCY0z3bJH7MO1koIUtNviYVh
         8AgOcR5WY2sLR3JrUckqFINIF/VKDufMriQCqXGKDY62dqnvW7x40HbBANhHQjqLT1dQ
         A6VK1RAuziDKyUPhaXQoy2XDu92887h+C09dlgKZtc+KrbxeUSu7IC1VuVoivsFTxPsm
         VOGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699602912; x=1700207712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bs83gGPnw34/z9+aqifKBNPKc0tEy6BpwSpebU68fXw=;
        b=wuABT1z7/2D7pnUu8WmPUAJs9HbZT+0wYHWZ2squ5gk+90RkAiocAMbf+1ew7sHctQ
         /gBQ6yGNyWI0ChgMbs1J96Z5t7LJuw2bTDrY7wVHyvBgAetxnqY8mx4cE4Yui/YN7F9I
         TLhzLCRD6PswMROYdI0SIWvJW8XfttbiAE373HqLkxa3B96iZYyJYdkaCPt5yWH6MKDM
         ZkLeoyIU/Yr93BErC0woiKdQreIrx3mGLALLkquORflPqeSDZjsM1adx3rfX5rl79OwD
         gD5dj2VhWKtXWzm7AS7J6gdo5FpnTZxwyp1WFuA9BrJvDxy3QHFYBaXtO1IsCI3X18Mp
         r5sQ==
X-Gm-Message-State: AOJu0YzGeW7IgcG1H2aznIVnT9LYOrKdSjSMeQRjwoyJs/r4+oOCude9
        lMUZ3uPpWjFjTYiLR/slMteon/Og6t0KFoXbshs=
X-Google-Smtp-Source: AGHT+IH/s9vUPnXAza1i0810hWB/fj3zhEhzw25rT+kIHtQ5os/8iT8BAPIDVYLC3mc5eGr7ZJox0AMTKmkYWcJZQqU=
X-Received: by 2002:a05:6870:2c90:b0:1e9:f6c3:8594 with SMTP id
 oh16-20020a0568702c9000b001e9f6c38594mr8416731oab.2.1699602912563; Thu, 09
 Nov 2023 23:55:12 -0800 (PST)
MIME-Version: 1.0
References: <CANH4o6Md0+56y0ZYtNj1ViF2WGYqusCmjOB6mLeu+nOtC5DPTw@mail.gmail.com>
 <DD47B60A-E188-49BC-9254-6C032BA9776E@redhat.com>
In-Reply-To: <DD47B60A-E188-49BC-9254-6C032BA9776E@redhat.com>
From:   Martin Wege <martin.l.wege@gmail.com>
Date:   Fri, 10 Nov 2023 08:54:00 +0100
Message-ID: <CANH4o6NzV2_u-G0dA=hPSTvOTKe+RMy357CFRk7fw-VRNc4=Og@mail.gmail.com>
Subject: Re: NFSv4 referrals - custom (non-2049) port numbers in fs_locations?
To:     Benjamin Coddington <bcodding@redhat.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
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

On Wed, Nov 1, 2023 at 3:42=E2=80=AFPM Benjamin Coddington <bcodding@redhat=
.com> wrote:
>
> On 1 Nov 2023, at 5:06, Martin Wege wrote:
>
> > Good morning!
> >
> > We have questions about NFSv4 referrals:
> > 1. Is there a way to test them in Debian Linux?
> >
> > 2. How does a fs_locations attribute look like when a nonstandard port
> > like 6666 is used?
> > RFC5661 says this:
> >
> > * http://tools.ietf.org/html/rfc5661#section-11.9
> > * 11.9. The Attribute fs_locations
> > * An entry in the server array is a UTF-8 string and represents one of =
a
> > * traditional DNS host name, IPv4 address, IPv6 address, or a zero-leng=
th
> > * string.  An IPv4 or IPv6 address is represented as a universal addres=
s
> > * (see Section 3.3.9 and [15]), minus the netid, and either with or wit=
hout
> > * the trailing ".p1.p2" suffix that represents the port number.  If the
> > * suffix is omitted, then the default port, 2049, SHOULD be assumed.  A
> > * zero-length string SHOULD be used to indicate the current address bei=
ng
> > * used for the RPC call.
> >
> > Does anyone have an example of how the content of fs_locations should
> > look like with a custom port number?
>
> If you keep following the references, you end up with the example in
> rfc5665, which gives an example for IPv4:
>
> https://datatracker.ietf.org/doc/html/rfc5665#section-5.2.3.3

So just <address>.<upper-byte-of-port-number>.<lower-byte-of-port-number>?

How can I test that with the refer=3D option in /etc/exports? nfsref
does not seem to have a ports option...

Thanks,
Martin
