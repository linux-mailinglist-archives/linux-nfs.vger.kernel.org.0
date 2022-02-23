Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 434094C155C
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Feb 2022 15:24:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241508AbiBWOXi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Feb 2022 09:23:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239615AbiBWOXi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Feb 2022 09:23:38 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E7D5B1892
        for <linux-nfs@vger.kernel.org>; Wed, 23 Feb 2022 06:23:10 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id z22so44418640edd.1
        for <linux-nfs@vger.kernel.org>; Wed, 23 Feb 2022 06:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1B/oCfMvlO7P1vRziqRGnhWRi/hgZFJlRfuqeZS3BEo=;
        b=bcXZdAHg80S5eA6IGDqF4AOeLbfFtLZw1Q3HUPam67/ro1UNQ/TW+Tt0LuwIgPZA60
         UZr6bHMU1Jy1VMCFdsBJpMJDrDEe4an3KbiOSe58KOb3hJTLZTbj7qCvtpX+g5QMPr9z
         rWASsvfSHzk5plT9ZxYC4Z3RYHv+PVbDzf0HJFLbaNe3HVv9UQa2uvifwGRlLZUDRtRM
         mBkKA7u3AYP+jkrMV/wMF3BQidJleB23Hw8WWZ3loK/7FJJ39QB5akIJYAqYSqrKH8a2
         Ss5jpDXDa3651y8HMRHB3pJReN43vupAkK3c/rgSlKolX/J7vYsJhFgCRCSY7GDvUyir
         zlzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1B/oCfMvlO7P1vRziqRGnhWRi/hgZFJlRfuqeZS3BEo=;
        b=Grv7d4yVqo+hvtkiUVCKYmY+L1LouSeub8EOcrNzWuFr+uCCvpygIpwkN3ykXQY8jX
         ae8l3D4irfSDhJD22XZMHTnBNOeLthH63/D7KjcGOc3AWhoDRTsguI06BFTFMab5GRpm
         0Y40AfMCTg5BEuLguadd8zMtArOxWC2+P3xYGHcyVMDCjoHoDXGwl7VPz9H59NTUMhBy
         D6+bREYblcZ8jTrzBfqRl4uynVF4Q4R0q4y0E4DxafdXmOjR48nLixdA5LZm/wArMya8
         ToaL65ADru/Klv3uzMhBcGkAH3aXu9PBFf/xRxW/1HsyL2wvCBYNUkj6WJdgDn3U/DeJ
         o4jw==
X-Gm-Message-State: AOAM532W8d7JPjJfnd8MDnaUYYolX0A1EseWwS++7xMUkSHnBwdirjVx
        KolZvMAU1pbq2j4IihjS0kVBXi+HJ/Gg8Y/krQs=
X-Google-Smtp-Source: ABdhPJyt67g4aNhewyXkoZ/8+MTHns5smc4vohE/dkgx78r3GQPANTTfI8vVT2t5NyV/t6hEKrFcOmU4k9bkyTAbL38=
X-Received: by 2002:a05:6402:5191:b0:40f:b9e0:4d1b with SMTP id
 q17-20020a056402519100b0040fb9e04d1bmr32107324edd.149.1645626188866; Wed, 23
 Feb 2022 06:23:08 -0800 (PST)
MIME-Version: 1.0
References: <50bd4b4d-3730-4048-fcce-6c79dfe70acf@garloff.de>
 <8957291b-ecd1-931e-5d0c-7ef20c401e5d@garloff.de> <F693AC98-DCB4-4086-AC19-EE1B71DB2551@netapp.com>
 <be851303-b1bb-7d8d-832e-a1a3db529662@garloff.de> <10d55787-7b97-8636-9426-73fdeda0a122@garloff.de>
 <6401c5e1-8f05-5644-9bea-207640a21b77@garloff.de>
In-Reply-To: <6401c5e1-8f05-5644-9bea-207640a21b77@garloff.de>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Wed, 23 Feb 2022 09:22:57 -0500
Message-ID: <CAN-5tyHC0m8nLgEi89EdKUo-kpEWsi-LUNHqAXc=gBzW+u52NA@mail.gmail.com>
Subject: Re: 6f283634 / 1976b2b3 breaks NFS (QNAP/Linux kNFSD)
To:     Kurt Garloff <kurt@garloff.de>
Cc:     "Kornievskaia, Olga" <Olga.Kornievskaia@netapp.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "Schumaker, Anna" <Anna.Schumaker@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Feb 23, 2022 at 8:20 AM Kurt Garloff <kurt@garloff.de> wrote:
>
> Hi Olga,
>
> any updates? Were you able to investigate the traces?
>
> Breaking NFS mounts from Qnap (knfsd with 3.4.6 kernel here,
> though Qnap might have patched it),is not something that
> should happen with a -stable kernel update, even if the problem
> would be on the Qnap side, which would not be completely
> surprising.
>
> So I think we should revert this patch at least for -stable,
> unless we understand what's going on and have a better fix
> than a plain revert.

Hi Kurt,

I apologize for the late response. I have looked at the network trace.
The problem stems from the broken server that claims to support
fs_locations but then decides to never reply to the query.

I can implement a mount option to say fs_locquery=off to handle mounts
against the broken servers?

However I would like to ask if the better path forward isn't to update
to the knfsd where the problem is fixed?

>
> Best,
> --
>
> Kurt Garloff <kurt@garloff.de>
>
