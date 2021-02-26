Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2020B32663E
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Feb 2021 18:21:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbhBZRVJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 26 Feb 2021 12:21:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbhBZRVH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 26 Feb 2021 12:21:07 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1122CC061574
        for <linux-nfs@vger.kernel.org>; Fri, 26 Feb 2021 09:20:27 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id p15so2542507ljc.13
        for <linux-nfs@vger.kernel.org>; Fri, 26 Feb 2021 09:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vndn5oTxJ/m3PkFwHqrmxGrBZ1ijQqRjFXcAaocq8ac=;
        b=UJrukWoj6vwXj2H5cURtG20SWW0/83Ar42gqV2vnUwB2ofJ+dpeSTPxmLtNc+tAQ3g
         db2KTo4DAL/mnCvgiBtxXYlPsLtVxw56U6qHndqGwHmcFH+4IXxwLQosxU/z/HVbvlK8
         eMNQanPn8nYqzQFViVW9/nwtSZUYfZeJ9MtZw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vndn5oTxJ/m3PkFwHqrmxGrBZ1ijQqRjFXcAaocq8ac=;
        b=CDvsvkpyPptBzg8GcvgT4oQuaFJ3NkCiPzCsWwxvdMhej/pULrmvtDADhjvOQthPXC
         Iuj/dnSkAYfO9MXvcQU4YdynOFVgO3+Jv+oMx1K7xgNoNUgs6mP2Oj8wS8hmYCSCACSP
         oGeZxCZ13+B37s3r17hhh0Iq1hu1l9NLw16ne9E/KAB/GH2znt1z15n3xMJtb3pZNz8n
         7dq+26ENNauZd/1LygtKL/JDJgZPS8uhCsJst6rFCMwxjEUDzoElIHvrxG2XtizXGOiT
         IszasU1Yurz7Eq6K0A1Kw6Bujs71+LHr0wQCiXUoaRBGS6M5J1f/tS/9a+GVcp6Ufx5L
         9arA==
X-Gm-Message-State: AOAM533Il7SqH70IYuHqJ23EgVNWRwLVMV3K2ryZOtcJuVel0CEfZRLB
        IATd+c+yTDJhEqBLrRkVLA9NGyhjL55+8Q==
X-Google-Smtp-Source: ABdhPJyzcMp61s4iKxj8EZzO2BNx85tZxFHHWcGnQIyyl5BmTD22WtQGEBvuy77/BmhDrxBnH2Fuww==
X-Received: by 2002:a2e:530a:: with SMTP id h10mr2312356ljb.63.1614360025298;
        Fri, 26 Feb 2021 09:20:25 -0800 (PST)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id h62sm593571lfd.234.2021.02.26.09.20.24
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Feb 2021 09:20:24 -0800 (PST)
Received: by mail-lf1-f41.google.com with SMTP id p21so14870915lfu.11
        for <linux-nfs@vger.kernel.org>; Fri, 26 Feb 2021 09:20:24 -0800 (PST)
X-Received: by 2002:ac2:41d5:: with SMTP id d21mr1781907lfi.487.1614360024177;
 Fri, 26 Feb 2021 09:20:24 -0800 (PST)
MIME-Version: 1.0
References: <CAFX2JfnuPuE7Bd5nAwgwrVQQ84vAMVwpPf0SFZFTwpX0rib+Hg@mail.gmail.com>
 <CAFX2Jf=SXFy4PbWBGJeFUq5TQbVXpYMNZL8B=kckN_tFX-j01w@mail.gmail.com>
In-Reply-To: <CAFX2Jf=SXFy4PbWBGJeFUq5TQbVXpYMNZL8B=kckN_tFX-j01w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 26 Feb 2021 09:20:07 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi8guJetYqTaypq44Et49d3ABEJiOqdNwXU=ztZ=JwBng@mail.gmail.com>
Message-ID: <CAHk-=wi8guJetYqTaypq44Et49d3ABEJiOqdNwXU=ztZ=JwBng@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull NFS Client Updates for Linux 5.12
To:     Anna Schumaker <schumaker.anna@gmail.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Feb 25, 2021 at 2:17 PM Anna Schumaker <schumaker.anna@gmail.com> wrote:
>
> Sorry to bother you since I know you're busy. I haven't seen this get
> pulled yet, and I'm worried it's slipped through the cracks since
> we're getting close to the end of the merge window.

Hmm. I don't have this original email AT ALL in my mailbox.

Maybe it was marked as spam and I never noticed it. Or maybe there was
some other issue with it  getting delivered.

Anyway, re-sending was the right thing to do. Will pull asap.

Thanks,

     Linus
