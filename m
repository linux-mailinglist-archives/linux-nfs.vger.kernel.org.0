Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71619340DF4
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Mar 2021 20:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232859AbhCRTNT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 18 Mar 2021 15:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232785AbhCRTMz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 18 Mar 2021 15:12:55 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0DB6C06175F
        for <linux-nfs@vger.kernel.org>; Thu, 18 Mar 2021 12:12:54 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id k10so5706304ejg.0
        for <linux-nfs@vger.kernel.org>; Thu, 18 Mar 2021 12:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DyMaGr4z+lqJaWQXGZcY57W7iKUSlvKLVnUF6SKnlnE=;
        b=QvI5Q9WzLrcKPBzjLOroHzNYk8q0/VER36IcDGrmQuzyqdzS6XeagMn1N/NydZptx9
         OKB3vjUNw4WST8Al/y0D32h90aiD9HduUjVjEy8bdWr0D1HNzqhxRCFttcBQS1SPrH4E
         IlO64STuUNFnbpGZWLzZS4M4cNA8AjmuJ+9orwEgE0QII+6deQlgJJ7Ow8gUYxoEj6LQ
         aJ+PYW5L4gQEeZNPOw2R1nP3dbamDxoBS7jMrObAzLUc0x1S4Hfy/dOXaFHPHVc0A/OV
         PXFaTKjF6c07RlwjZ39PdKtD/XYqh52mwUmhtpPApxWPSD5ol9bE/GqcYZGy/ouJxHiO
         J+fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DyMaGr4z+lqJaWQXGZcY57W7iKUSlvKLVnUF6SKnlnE=;
        b=awJn3g7dQ7w1UONzM5okoE/if9Nm1Amwnm/QRhXbyxfpaQp4PJlHlQK+JnnNtF2BI/
         o71/xnI/M/H6NkbJykERzupE5jhYNQhKtkRaimd/oCrAkIF7NlH99LzXFWV0QxvZrtKg
         zuNA37SijA4oVSxjeT6Pvpv86+Hbl3qMwWJFPWu+ACo4wvTsHhWSYIH1NkmJDmJUDblb
         uKbJevFLLV5IhjwQj/QVpcLoFYb23CbehpPtx3/KGAciugrP/xENDliacbyGMUu6S9vu
         rI1+fNJhQEmUc4hIxigv9Yufs8/muk7mPKAwkWjrDy2SZzSWJyZ4XP7EgqtgRHV6KPnH
         An3A==
X-Gm-Message-State: AOAM530tRB9ZIqpo8OEfKkFdsEISdhYz3l0t/LXGG8y/5sjqCVp142cu
        bBOF3adQ1OJnSN7VoZwyqHw0Gg8yT0/5AmJvFafD3kZQMMsw
X-Google-Smtp-Source: ABdhPJyAOajd2udCvFqcI5sISt04jpYbTdwWQhWG7jzxuJiGigP2Hj0LVcUKlOb5xeUGZ/xFdHRzkvlNFKWQ/uDoztE=
X-Received: by 2002:a17:906:2314:: with SMTP id l20mr129150eja.178.1616094773311;
 Thu, 18 Mar 2021 12:12:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAN-5tyGuV-gs0KzVbKSj42ZMx553zy9wOfVb1SoHoE-WCoN1_w@mail.gmail.com>
 <20210227033755.24460-1-olga.kornievskaia@gmail.com> <CAFX2Jfk--KwkAss1gqTPnQt-bKvUUapNdHbuicu=m+jOtjrMyQ@mail.gmail.com>
 <f8f5323c-cdfd-92e8-b359-43caaf9d7490@schaufler-ca.com> <CAHC9VhR=+uwN8U17JhYWKcXSc9=ExCrG4O9-y+DPJg6xZ=WoYA@mail.gmail.com>
 <CAFX2JfnT49o-CkaAE3=c0KW9SDS1U+scP0RD++nmWwyKoBDWkA@mail.gmail.com>
 <CAHC9VhQNp-GQ6SMABNdN00RcDz30Os5SK217W-5swS8quakxPA@mail.gmail.com>
 <CAN-5tyG95bL8vbkG5B9OmAAXremJ-X5z09f+0ekLyigzibsZ5A@mail.gmail.com>
 <CAHC9VhTwqt0TDEWV97GaM8B5m4qmEwo+BYXYDeMs2D1LtZzUFg@mail.gmail.com>
 <CAN-5tyHdiuiOBX2bkZBGOTK-AMOccm27=qE-AZ_J9QQ00P91-Q@mail.gmail.com> <CAHC9VhTZe0azgqt_OSk0cy-nM+upz9z2_i0j1wQQLD8UgbX9+Q@mail.gmail.com>
In-Reply-To: <CAHC9VhTZe0azgqt_OSk0cy-nM+upz9z2_i0j1wQQLD8UgbX9+Q@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 18 Mar 2021 15:12:42 -0400
Message-ID: <CAHC9VhQyck5HKGKBcv-q70fv6zwTHD2hdfJ3e3SnjqoVty6inA@mail.gmail.com>
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

On Mon, Mar 15, 2021 at 12:15 PM Paul Moore <paul@paul-moore.com> wrote:
> As long as we are clear that the latest draft of patch 1/3 is to be
> taken from the v4 patch{set} and patches 2/3 and 3/3 are to be taken
> from v3 of the patchset I don't think you need to do anything further.
> The important bit is for the other LSM folks to ACK the new hook; if I
> don't see anything from them, either positive or negative, I'll merge
> it towards the end of this week or early next.

LSM folks, this is a reminder that if you want to object you've got
until Monday morning to do so :)

-- 
paul moore
www.paul-moore.com
