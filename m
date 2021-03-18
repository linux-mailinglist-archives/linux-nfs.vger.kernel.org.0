Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA99341094
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Mar 2021 00:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbhCRW7j (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 18 Mar 2021 18:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232470AbhCRW7a (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 18 Mar 2021 18:59:30 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F8FC06174A;
        Thu, 18 Mar 2021 15:59:26 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id b9so6572788ejc.11;
        Thu, 18 Mar 2021 15:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/hE6AybIk7Evw8i9qbXtbP68rZ7vjRX0+lEbRx60I5M=;
        b=RSgUvhZOGOMSYAqC5rdr4BqeZXnaYjOfHFtolBeoT3lK+GOQ5ROLuos4NYyphsomfm
         7+qoQqMq1spDsmvOoNk4ihwGgdQ4J6LPz3E8craILAbNGV9RqGEo7UG4zZPFQ68pdi6+
         7cdqo19YbsM0rgTGgXYr6EhasP+OWdaJD/bHsU7gv1Ok9hBCZ9xJuw47a4NJj8A0suY2
         I8q0lRRX0afMBqH/cO/jBJRUZX/AX3NJmigErtnOZWS3dJk31YglFlsMDJGMCVSmZabG
         1zTLcSImgXR0WG7PasHmcQ5x37/d+UmwAxlxfAtRN/Bleu7lGH6vz5PAFX0iAFnMi5R8
         jJZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/hE6AybIk7Evw8i9qbXtbP68rZ7vjRX0+lEbRx60I5M=;
        b=phtFq2VcbB+K7ax+Pu9th1DBQ922G/KDHPMqbURp+vkvgqLuOMz7BGg5U47EyzgCDP
         ul0hzg61UfAf/QmhhHQcC0TRw9zoemyoeCVk5Oa21ufcSjrvEOLZZISQs/vf+LXvbqSE
         Xt+73BSODirxJLdQe5K/jvTrggPtw6up64ko9vo03SCQjDa3B+pWgMdFoRUERgCyicE9
         zkrdsxk7pvJlAH9XltLwqUf7WRPOgX2bKw9Z15xpM4mk+QaPFJAbj5f8rwU+ddiPTFfB
         yA+3ZaOZbeFyVmEIqhA1IZVMDeJcChX7bwx7zG5EfXquGqPG8AdMrZ7uS8AG16gy2pyY
         2h1A==
X-Gm-Message-State: AOAM533K9ee3JtX0Ue7FvYNQkuz9UqWPBQfwHtnfMB2AmtTyZ7r/fSpt
        9izt9FlIdsbyZs2cVAOwHJlNXsqcWwnnIG+yEQU=
X-Google-Smtp-Source: ABdhPJw+X3pDPs0x4+YlFgE51LAGtwxW1xBUtWuqk59dytB96xEEZi31T+e/yvgzBiXOp8VoD+h8YYnzORw3ZBm8eW0=
X-Received: by 2002:a17:906:e2d4:: with SMTP id gr20mr1020555ejb.432.1616108364886;
 Thu, 18 Mar 2021 15:59:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAN-5tyGuV-gs0KzVbKSj42ZMx553zy9wOfVb1SoHoE-WCoN1_w@mail.gmail.com>
 <20210227033755.24460-1-olga.kornievskaia@gmail.com> <CAFX2Jfk--KwkAss1gqTPnQt-bKvUUapNdHbuicu=m+jOtjrMyQ@mail.gmail.com>
 <f8f5323c-cdfd-92e8-b359-43caaf9d7490@schaufler-ca.com> <CAHC9VhR=+uwN8U17JhYWKcXSc9=ExCrG4O9-y+DPJg6xZ=WoYA@mail.gmail.com>
 <CAFX2JfnT49o-CkaAE3=c0KW9SDS1U+scP0RD++nmWwyKoBDWkA@mail.gmail.com>
 <CAHC9VhQNp-GQ6SMABNdN00RcDz30Os5SK217W-5swS8quakxPA@mail.gmail.com>
 <CAN-5tyG95bL8vbkG5B9OmAAXremJ-X5z09f+0ekLyigzibsZ5A@mail.gmail.com>
 <CAHC9VhTwqt0TDEWV97GaM8B5m4qmEwo+BYXYDeMs2D1LtZzUFg@mail.gmail.com>
 <CAN-5tyHdiuiOBX2bkZBGOTK-AMOccm27=qE-AZ_J9QQ00P91-Q@mail.gmail.com>
 <CAHC9VhTZe0azgqt_OSk0cy-nM+upz9z2_i0j1wQQLD8UgbX9+Q@mail.gmail.com>
 <CAHC9VhQyck5HKGKBcv-q70fv6zwTHD2hdfJ3e3SnjqoVty6inA@mail.gmail.com> <1e3cd4d7-2a80-a5c1-b5cd-919bfb1e493@namei.org>
In-Reply-To: <1e3cd4d7-2a80-a5c1-b5cd-919bfb1e493@namei.org>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Thu, 18 Mar 2021 18:59:13 -0400
Message-ID: <CAN-5tyF8FRX207si4sdjqg0Wv00yKniFAB4dvVXduw=OZEwy6w@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] [security] Add new hook to compare new mount to an
 existing mount
To:     James Morris <jmorris@namei.org>
Cc:     Paul Moore <paul@paul-moore.com>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Mar 18, 2021 at 6:51 PM James Morris <jmorris@namei.org> wrote:
>
> On Thu, 18 Mar 2021, Paul Moore wrote:
>
> > On Mon, Mar 15, 2021 at 12:15 PM Paul Moore <paul@paul-moore.com> wrote:
> > > As long as we are clear that the latest draft of patch 1/3 is to be
> > > taken from the v4 patch{set} and patches 2/3 and 3/3 are to be taken
> > > from v3 of the patchset I don't think you need to do anything further.
> > > The important bit is for the other LSM folks to ACK the new hook; if I
> > > don't see anything from them, either positive or negative, I'll merge
> > > it towards the end of this week or early next.
> >
> > LSM folks, this is a reminder that if you want to object you've got
> > until Monday morning to do so :)
>
> I'm unclear on whether a new v5 patchset was being posted -- I assume not?

v4 addressed all the existing concerns/comments that were made. no new
version is planned unless somebody else has any more comments.

>
> --
> James Morris
> <jmorris@namei.org>
>
