Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9977D7C5652
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Oct 2023 16:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbjJKOEO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Oct 2023 10:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376300AbjJKODr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 Oct 2023 10:03:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC108E9
        for <linux-nfs@vger.kernel.org>; Wed, 11 Oct 2023 07:03:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02CE5C433C7
        for <linux-nfs@vger.kernel.org>; Wed, 11 Oct 2023 14:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697033021;
        bh=DAsM6qG2pnHAi1d/qzI8zGjCTSorJZWWsEbDAILhGRc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=l3BlYj3+IJIOwELg6xZnCzua6Hg+psBr0pG+tFodlfEXMpnp2D06Ba9/ek1WTCDcM
         MVh+kBgCm7Hsh/n8wZJJ4kcIoXQw6BzDdxWOiXKCCHK6dKaErXU5kpKm269fM6pYEz
         mf34P80+xnjeoLtSFwI3BWKWXB1NxANuNxTrKZdbRuM3ApUHiT0E8drU19EE/wQTmT
         NHXkD6R1Lk7/dHwZszzXdD+nYwm1JvbP0/jkeaSB6mOAxI6P2AW0vmQXtQ9IAdgUkn
         q8M7vGi9JD5lZ7vs99H32YoukQa8ifNFuboaEyTzP66gqNm2obXZzj5KPZt6hq8+nB
         yZc+6m/GzNltg==
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4180adafdc6so43136771cf.2
        for <linux-nfs@vger.kernel.org>; Wed, 11 Oct 2023 07:03:40 -0700 (PDT)
X-Gm-Message-State: AOJu0Yyv9TzXfZZkGSpoZ/0uxUSnMYRpNkr5nMQNInCmwSYQwA1H1OI5
        rCZICVRnpKnEShlGSzOrHIeGZ4Jxpymr/UoT7sk=
X-Google-Smtp-Source: AGHT+IEIb1QlM6RXDfZMME0I5UrR/Nchn6u4x50+3mh59YqxXfeeuMrGKyz6vi7rKd4vnSzMdCfSYL4wHfF4v2fUNZs=
X-Received: by 2002:ac8:5703:0:b0:418:19c6:c22c with SMTP id
 3-20020ac85703000000b0041819c6c22cmr24912065qtw.68.1697033020273; Wed, 11 Oct
 2023 07:03:40 -0700 (PDT)
MIME-Version: 1.0
References: <2e840ad028869edeb4238869eca81593820688b1.camel@kernel.org>
 <CAFX2Jfmrh1YVtf_G1pSsORnF5qVMBjrgMBsS4BWTmx+vLdoAZw@mail.gmail.com> <09B062C8-6D70-4BAF-88C0-07A3BA3A36EC@redhat.com>
In-Reply-To: <09B062C8-6D70-4BAF-88C0-07A3BA3A36EC@redhat.com>
From:   Anna Schumaker <anna@kernel.org>
Date:   Wed, 11 Oct 2023 10:03:24 -0400
X-Gmail-Original-Message-ID: <CAFX2Jfmxee0c77kQ8WOAyKbVM55e2f0P-8y4Vc3Nf_=t+kZFKw@mail.gmail.com>
Message-ID: <CAFX2Jfmxee0c77kQ8WOAyKbVM55e2f0P-8y4Vc3Nf_=t+kZFKw@mail.gmail.com>
Subject: Re: missing patches for v6.6-rc
To:     Benjamin Coddington <bcodding@redhat.com>
Cc:     Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        Dai Ngo <dai.ngo@oracle.com>,
        Scott Mayhew <smayhew@redhat.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Oct 11, 2023 at 10:01=E2=80=AFAM Benjamin Coddington
<bcodding@redhat.com> wrote:
>
> On 11 Oct 2023, at 9:55, Anna Schumaker wrote:
>
> > Hi Jeff,
> >
> > On Tue, Oct 10, 2023 at 8:49=E2=80=AFAM Jeff Layton <jlayton@kernel.org=
> wrote:
> >>
> >> Hi Anna,
> >>
> >> There are a couple of client side patches that I think we want in v6.6=
,
> >> but that haven't shown up in linux-next yet. Do you still plan to take
> >> these from Dai and Scott?
> >
> > I've pushed out Dai's patch to my linux-next branch, and I can do
> > another pull request before the end of the 6.6 cycle. Is Scott's patch
> > still needed after your patch "nfs: decrement nrequests counter before
> > releasing the req" which went into 6.6-rc5? If so, it doesn't apply
> > cleanly on top of the current code so I'll need to fix it up.
>
> Yes, that patch is definitely needed.
>
> Want me to send a current version?

Sure! That would be great!

Anna

>
> Ben
>
