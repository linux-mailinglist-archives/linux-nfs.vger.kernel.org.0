Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB222D4780
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Dec 2020 18:09:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbgLIRIb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Dec 2020 12:08:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727211AbgLIRIb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 9 Dec 2020 12:08:31 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40939C0613CF
        for <linux-nfs@vger.kernel.org>; Wed,  9 Dec 2020 09:07:51 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id cm17so2377293edb.4
        for <linux-nfs@vger.kernel.org>; Wed, 09 Dec 2020 09:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wb4X1wDN8qYAEmsthsJxVCHnvXBJ+MtAFLYKxYwaUCQ=;
        b=NuTy4y+L7Bk5h3HQSCry5aaSY39SMI1wFp3LRixfcsOiP/Yre8sPBdFYrtjdRfKiEK
         clCKyLa5LQFmB7DsZ4bpNr2rMkZ5nn1aX03bYlLxY+ETYZRj4Jtqm7KPPxVSsfLlgpoG
         Oq5ouIaLxcononKgwvnGGQIPqBHcTPj6NkwqOjAIcBh1X7Id2eM5c9cw5FbJbA8bxP/x
         E5YG4zhu0UbDqPrFMdCAR98navz4oh/HivwRRZUgrp57F1RBXyPUKWHyTOD5+H9dDV0h
         lF5wVC2k7V/3hFjBZxXZ1ZW013mlpAehgTOzTioEcuIexy8koPgRZLIpLm1+XhFBvj7n
         Ycag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wb4X1wDN8qYAEmsthsJxVCHnvXBJ+MtAFLYKxYwaUCQ=;
        b=QJ6kWek/Li57FmNcoT4cpvB+cW21P95mlmUaBYDzKW0yGL1Le5Z0oFhAeBek1noluX
         FHmOeoPB+CJdbzkrN5QxI0JHU9Fm082O+kw4oPvYllrBhhQtRwFsPT/o+Kc0P/3Cl3Pu
         yb+fj/6id4loxmib8NJJWhz79jdi5+FOvpN1tnAolODMwOBkxO3/BRyrA/tbNkCT5j8h
         /dAEpBB8fiicSyG9VMFR/+fxGncCwBXwH61xjsmXaYnePAvytZfxfEwOQaS7r7uojzgM
         yNK7IBnPlSYVDD7sdSaijFLIXVw1VGAOdw+wg/VTl2mj0oV1PlZVD/tkypA2rt0VNGuw
         CXQA==
X-Gm-Message-State: AOAM531/MsujQjy883XqbsdHv3uEMl4oi8stS9X74fpKD92qWTeaCose
        SA6t7fPd6y/eodqMxs3h5Nay2EG1uFIl89Gjp0UBGi4b
X-Google-Smtp-Source: ABdhPJyzfIeJ4M+YkgLfFozPY4+d8d2rMCpcIQmbgp8290UWJ5Td9e073LOmW9/qc5LlcEYX5VBB+6yf0+v/kD5zG9w=
X-Received: by 2002:a50:c406:: with SMTP id v6mr3014131edf.367.1607533669894;
 Wed, 09 Dec 2020 09:07:49 -0800 (PST)
MIME-Version: 1.0
References: <20201203201841.103294-1-Anna.Schumaker@Netapp.com>
 <852166252.2305208.1607096860375.JavaMail.zimbra@desy.de> <CAN-5tyFJeLRyDUdtGkheGkmDE=i-FJprLFiav_mEPA35QeKLQA@mail.gmail.com>
 <14eac8ec352c76206c811f75b130957bb75ff590.camel@hammerspace.com>
In-Reply-To: <14eac8ec352c76206c811f75b130957bb75ff590.camel@hammerspace.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Wed, 9 Dec 2020 12:07:38 -0500
Message-ID: <CAN-5tyFwgWTBsCOBJ=7ELS4md4SBgiMQ4EPAS7LCxzCK74X13g@mail.gmail.com>
Subject: Re: [PATCH 0/3] NFS: Disable READ_PLUS by default
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "tigran.mkrtchyan@desy.de" <tigran.mkrtchyan@desy.de>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "Anna.Schumaker@netapp.com" <Anna.Schumaker@netapp.com>,
        "schumaker.anna@gmail.com" <schumaker.anna@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Dec 9, 2020 at 11:59 AM Trond Myklebust <trondmy@hammerspace.com> wrote:
>
> On Fri, 2020-12-04 at 15:00 -0500, Olga Kornievskaia wrote:
> > I object to putting the disable patch in, I think we need to fix the
> > problem.
>
> I can't see the problem is fixable in 5.10. There are way too many
> changes required, and we're in the middle of the week of the last -rc
> for 5.10. Furthermore, there are no regressions introduced by just
> disabling the functionality, because READ_PLUS has only just been
> merged in this release cycle.
>
> I therefore strongly suggest we just send [PATCH 1/3] NFS: Disable
> READ_PLUS by default and then fix the rest in 5.11.

Sure, but shouldn't there be more ifdefs inside of the xdr code to
turn it off completely?

>
>
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>
>
