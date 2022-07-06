Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE8D5696A7
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Jul 2022 01:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234442AbiGFX47 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 6 Jul 2022 19:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233613AbiGFX46 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 6 Jul 2022 19:56:58 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D0C2D1C8
        for <linux-nfs@vger.kernel.org>; Wed,  6 Jul 2022 16:56:58 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id m6-20020a05600c3b0600b003a0489f412cso179156wms.1
        for <linux-nfs@vger.kernel.org>; Wed, 06 Jul 2022 16:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eOGG5TEyvbbE0DQj04oC5N4GBb+43dSxLzH6oyzn9Rc=;
        b=YguXpB43+Mg3KH8/XIYRNPZR3TWPNkIOc1OgStIKKPm9DN7gv1AiUCzdfWZnWjjZ7b
         hy4Lv3Pb8N/kaVEEfItsKuOTckq5r0TF/jtAVko0iMifu1CTn4hlmzZM9qKSouhAZTON
         bFzR43FZ5iDTu2q25oF1dRSirk9BZA+qVcShrF9RXnZ1xaM6ZLeN3z4ZJlJZ+NjPwg31
         gkP2KHhcMXBeeI5tpIRSS7ld2rTFrPTOFsHcoY4zrzq/x1XMzbILCdVDjM1J2ABWSYMG
         cs8IHunVV+w8WkozKK+oE3d+5onUPLHt9b8AyfxmAc1d03ghhSs9sGyBLYfTn/veSIhw
         SOnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eOGG5TEyvbbE0DQj04oC5N4GBb+43dSxLzH6oyzn9Rc=;
        b=byKI5dbNGjphss9y6rv7qRUrMOkJ/UPb4GtUEfOvfNT3/+40dU5tT3PtJi7q3SDTSc
         YEJOt/l/JXttn4zErB4TMn4gDc5M5sqZS6D+FgjGYK4vWXJa1WfgyN2qL2a5PkbKZz5G
         MtXIH0UOwB2TycOROiWTHeOlZ39atwESXxa+SA6seNUS2fSQcThp5oTgWzrmh/V1MinZ
         dLU38UG2z5X568xUAknC5HHOjbt+FQWmDVFuc2E2atQ1xzjUeiCdZw+yRMGzU7zUL2+k
         A8a2cFDlh2eU4b9a1Dacr9kczQSMrgVboJXTwunO6X0zR0B/d2sPeMby09DJPrCKs896
         5mEw==
X-Gm-Message-State: AJIora97B0St8oEBhRbZtNgARejeEWWWVNglCpp/NMkhjl7C2+xBSDzN
        pEuhALSQZ6Y4XlgAgi2zhm8qTtq2x0YU8rkUS1JCFNwM
X-Google-Smtp-Source: AGRyM1t8Y95NQoXnAAZv1dcNiCfBVoj6Sq7z3HDCZXs0E1yBuvTwcKoZEIjf94DMfST44BCeaU99oJD9iflfTEXz0ac=
X-Received: by 2002:a1c:7719:0:b0:3a0:31a6:4469 with SMTP id
 t25-20020a1c7719000000b003a031a64469mr1181985wmi.20.1657151816590; Wed, 06
 Jul 2022 16:56:56 -0700 (PDT)
MIME-Version: 1.0
References: <CACt_J9PHSjkz_-x0K=7+AYjiX1Ur5cV+brC9Tv4i7dkG=NSBuQ@mail.gmail.com>
 <3D87B9ED-3A00-478B-AC17-435B71D0A349@redhat.com>
In-Reply-To: <3D87B9ED-3A00-478B-AC17-435B71D0A349@redhat.com>
From:   jie wang <yjxxtd12@gmail.com>
Date:   Thu, 7 Jul 2022 07:56:44 +0800
Message-ID: <CACt_J9NXmz4WCBT8iAT1MRNnhE1k5DpQct+00t-hTsbZrru06g@mail.gmail.com>
Subject: Re: Question abount sm-notify when use NFSv3 lock
To:     Benjamin Coddington <bcodding@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Thanks the reply, I have tried it, but it doesn't work, '-v' can only
use the local address


On Wed, Jul 6, 2022 at 10:39 PM Benjamin Coddington <bcodding@redhat.com> wrote:
>
> On 6 Jul 2022, at 8:28, jie wang wrote:
>
> > Hi, all
> >   When we use NFSv3, we have a LoadBalance in front of NFS server. For
> > example, LoadBalance's ip is ip2 and NFS server's ip is ip1, and
> > client use ip2 to mount.
> >
> >   Now client use flock to lock file, then I restart NFS server and
> > execute sm-notify -f. Then the problem occurs, the sm-notify request's
> > src ip is ip1, not ip2, so rpc.statd will ignore this notify, because
> > it does not match ip2 when mount, so client will not reclaim lock, and
> > lock lost when restart NFS server.
> >
> >   Do you know how to address this ? Thanks a lot.
>
> The sm-notify(8) man page shows you can use '-v' to specify an ipaddr or
> hostname.
>
> Ben
>
