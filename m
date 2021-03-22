Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4183344F54
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Mar 2021 19:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbhCVS4q (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 22 Mar 2021 14:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbhCVS40 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 22 Mar 2021 14:56:26 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 933BDC061574
        for <linux-nfs@vger.kernel.org>; Mon, 22 Mar 2021 11:56:25 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id bf3so20686620edb.6
        for <linux-nfs@vger.kernel.org>; Mon, 22 Mar 2021 11:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JJ7ibeBxKHTgycHdw+idDw+py3IqTITHx2UX7/7VRbM=;
        b=IV9J1zYUVgBcokEtS7VQHF284upyABOhLvv8E7WmS/CG9svupkt4Kn6BkCBAqaGTCa
         uGDgqkVYdzH9upRj+gxojN1qxal3yPpAQ1hIPEL3q+ZKY/4SUv9oJilIet6RTj92Eojb
         zAzgAz91PKTLJqWA0jPGIYRpyEp3BoKlW8MLpleuGeaLj3FmHpuLhjt3ktxmSB/s2/uK
         TM5g3sJy9kb6pkNCHyYO/7/EaoyNpM7lyBvyn7FsvZ/8HbvDm77FlD4/OlJdtfpP39RP
         zHqa+mSaXS74uVL/XZR49a6MmgYyCD4a5/r294CSON2J8IYOv9ct4dgU/DSo/6rmyJQp
         IghA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JJ7ibeBxKHTgycHdw+idDw+py3IqTITHx2UX7/7VRbM=;
        b=iR+/aV42/jmEWJfsvctNF8h0PCEezleDA+/t5NsmJ6r+30+8tBNZ1UmaY7l2RNAi55
         EMo39bjA79VXHN0aWc5lkffbMyH2gZoH0hY240KQqh/px8kLfjHf5HREbTbNNqtYwo6k
         sSCPP7/RXHVgLRir+wtuoMwPFxmd02EqRbEh2KNn6OSGwqohKD8yQkEBpLQTW9H4uG64
         VRfFXoslCNkbirNSpDWGxdUyC2GHsrfBX55jFS9p4ZLHgm6wWHGvWlRB/VkOzYsNqlTd
         sCx+TkpwW8Uy5JGZMxKNmak9WW6lObrRAMjgHxPWizyGiXnTpd1lReYrCV1DTvDlelQV
         f6OA==
X-Gm-Message-State: AOAM532g3IN38xAZPjbJY3gOrXMXtMAN8v6fe7uaqHNnGK8lQlmNAstQ
        X9+zIj+nV1zsYklFV99SYKuOJnr03TfS5kGNynoT
X-Google-Smtp-Source: ABdhPJwjIlDNu723BPHiu9qK1xolhOvuAbth3e/1MZ6jGYKH3ySg8bYmiTy+OAL5/WLaf4//LnT5KFqnzfGE+FwRVoU=
X-Received: by 2002:a05:6402:1cc1:: with SMTP id ds1mr1015942edb.135.1616439383635;
 Mon, 22 Mar 2021 11:56:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAN-5tyGuV-gs0KzVbKSj42ZMx553zy9wOfVb1SoHoE-WCoN1_w@mail.gmail.com>
 <20210227033755.24460-1-olga.kornievskaia@gmail.com> <CAFX2Jfk--KwkAss1gqTPnQt-bKvUUapNdHbuicu=m+jOtjrMyQ@mail.gmail.com>
 <f8f5323c-cdfd-92e8-b359-43caaf9d7490@schaufler-ca.com> <CAHC9VhR=+uwN8U17JhYWKcXSc9=ExCrG4O9-y+DPJg6xZ=WoYA@mail.gmail.com>
 <CAFX2JfnT49o-CkaAE3=c0KW9SDS1U+scP0RD++nmWwyKoBDWkA@mail.gmail.com>
 <CAHC9VhQNp-GQ6SMABNdN00RcDz30Os5SK217W-5swS8quakxPA@mail.gmail.com>
 <CAN-5tyG95bL8vbkG5B9OmAAXremJ-X5z09f+0ekLyigzibsZ5A@mail.gmail.com>
 <CAHC9VhTwqt0TDEWV97GaM8B5m4qmEwo+BYXYDeMs2D1LtZzUFg@mail.gmail.com>
 <CAN-5tyHdiuiOBX2bkZBGOTK-AMOccm27=qE-AZ_J9QQ00P91-Q@mail.gmail.com>
 <CAHC9VhTZe0azgqt_OSk0cy-nM+upz9z2_i0j1wQQLD8UgbX9+Q@mail.gmail.com> <CAHC9VhQyck5HKGKBcv-q70fv6zwTHD2hdfJ3e3SnjqoVty6inA@mail.gmail.com>
In-Reply-To: <CAHC9VhQyck5HKGKBcv-q70fv6zwTHD2hdfJ3e3SnjqoVty6inA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 22 Mar 2021 14:56:12 -0400
Message-ID: <CAHC9VhTZmp9x5MtJoboF4EW+_j9PdPc9uvgRbvoaLsEzYFyr3w@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] [security] Add new hook to compare new mount to an
 existing mount
To:     Linux Security Module list <linux-security-module@vger.kernel.org>
Cc:     Anna Schumaker <anna.schumaker@netapp.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Olga Kornievskaia <olga.kornievskaia@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Mar 18, 2021 at 3:12 PM Paul Moore <paul@paul-moore.com> wrote:
> On Mon, Mar 15, 2021 at 12:15 PM Paul Moore <paul@paul-moore.com> wrote:
> > As long as we are clear that the latest draft of patch 1/3 is to be
> > taken from the v4 patch{set} and patches 2/3 and 3/3 are to be taken
> > from v3 of the patchset I don't think you need to do anything further.
> > The important bit is for the other LSM folks to ACK the new hook; if I
> > don't see anything from them, either positive or negative, I'll merge
> > it towards the end of this week or early next.
>
> LSM folks, this is a reminder that if you want to object you've got
> until Monday morning to do so :)

Time is up, I just merged it into selinux/next ;)

Thanks everyone!

-- 
paul moore
www.paul-moore.com
