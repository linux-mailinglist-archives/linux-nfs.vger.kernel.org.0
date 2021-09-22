Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB6041457F
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Sep 2021 11:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234288AbhIVJtn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 22 Sep 2021 05:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234233AbhIVJtn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 22 Sep 2021 05:49:43 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B00C061574
        for <linux-nfs@vger.kernel.org>; Wed, 22 Sep 2021 02:48:13 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id v24so7720623eda.3
        for <linux-nfs@vger.kernel.org>; Wed, 22 Sep 2021 02:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dneg.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qceiZJW+xNuPv6DC8Ddv9FCnq8sX7E1T/cLTUPwqWEI=;
        b=W4DnfMgdaR/KzheXlvRl+xb/caTettvk56FczFBf1MvCyCiE0Pg9FI0B7Ghq3EzDQA
         yNrURYUJ+3iFprxCGyDcgN5uYyAE/ntZz3mnCMTUnW6OyGrYmM3ALiVYE5Bdq16O/Im8
         tNuSvTlwHhHRXf1wD02GWryGuA0LcQRm67CRIC1c2YHZAiusSLfaiVjxNj8HrZYXUxvP
         FmyMs1WKIqXzr2LVqo/AlRu9K3X6eHUL9HqomKwFQWrt2S5f/44mXmrvmNxh11U6NUlE
         wU2NfRpznZXfSmP5gICxgNOcyXljSjG0/g30K0ldmo/Z+kf6/tU/Cm2vYNRro00njGlv
         5cxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qceiZJW+xNuPv6DC8Ddv9FCnq8sX7E1T/cLTUPwqWEI=;
        b=3tmn/ybj/lMbEd787BQFvnN7W8oYv0b6fT8VzK9yxGdGSPSHjh4497zK42x6gxhxl1
         oGqEmUlJwEJrRfEuenLBFtrRR7JT3TOMW8JTE3YgsY3uL4YJXU1E/C681f+Xp2MzMgMS
         6RQYu1d9mlwBuenmK+b9FLEl7v2B4r45pwAnk+C/SVdzmonao1Fy3A8RLDypIBo7WmVK
         Q0ZbxzlyIcfudN2z9mXRAEgufxpkovMxnFyUsIeoIrBuu55n5Uj6UEJHieVO6MbVavOf
         RcEPb2ZSjZgx/2TF8VKLkYPUB7RZ1wSKF17QvH1qCq2gfIBB1otDycPrILz5wTTT4pAT
         6cvQ==
X-Gm-Message-State: AOAM532YqKwGgJLiFBrkjvX7wLW/qHFfHTB1VQD4nTasfL4GHICqATHR
        Y34hrBjWscWC0EYaw5X18HX7RQZi7sfidIFJO1mOyQ==
X-Google-Smtp-Source: ABdhPJwOItM4/kumpCdPGX63zXOJImLAqUljPGeP3BP972olG9mw0oXDNowo/+aHVOM7yjbevRT35w0MVBJiXc+DwiE=
X-Received: by 2002:a17:906:3745:: with SMTP id e5mr40672498ejc.400.1632304091632;
 Wed, 22 Sep 2021 02:48:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210921143259.GB21704@fieldses.org> <37851433-48C9-4585-9B68-834474AA6E06@oracle.com>
 <20210921160030.GC21704@fieldses.org>
In-Reply-To: <20210921160030.GC21704@fieldses.org>
From:   Daire Byrne <daire@dneg.com>
Date:   Wed, 22 Sep 2021 10:47:35 +0100
Message-ID: <CAPt2mGOf8orCkOj9hCM_sSu2uucPiRFPEK+yep+kufv-cDvhSA@mail.gmail.com>
Subject: Re: [PATCH] nfs: reexport documentation
To:     Bruce Fields <bfields@fieldses.org>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 21 Sept 2021 at 17:00, Bruce Fields <bfields@fieldses.org> wrote:
>
> > Any recommended workarounds? Or does this simply mean that
> > administrators need to notify client users to unmount (or
> > at least stop their workloads) before rebooting the proxy?
>
> I think so.
>
> If you don't use any file locking or delegations I suppose you're also
> OK.  Delegations might be useful, though.
>
> I'd expect reexport to be useful mainly for data that changes very
> rarely, if that helps.
>
> --b.

Firstly, it's great to see this documentation and the well maintained
wiki page for something we use in production (a lot) - thanks Bruce!

I can only draw on our experience to say:
* if the nfs re-export server doesn't crash, we rarely have cause to reboot it.
* we re-export read-only software repositories to WAN/cloud instances
(an ideal use case).
* we also re-export read/write production storage but every client
process is writing unique files - there are no writes to the same
file(s) from any clients of the re-export server.

We don't use or need crossmnt functionality, but I know from chatting
to others within our industry that the fsid/crossmnt limitation causes
them the most grief and confusion. I think in the case of Netapps,
there are similar problems with trying to re-export a namespace made
up of different volumes?

As noted on the wiki, the only way around that is probably to have a
"proxy" mode (similar to what ganesha does?).

Daire
