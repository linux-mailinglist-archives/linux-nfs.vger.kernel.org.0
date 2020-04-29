Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 616181BE3AB
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Apr 2020 18:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbgD2QW3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 29 Apr 2020 12:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726456AbgD2QW3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 29 Apr 2020 12:22:29 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA2EEC03C1AD
        for <linux-nfs@vger.kernel.org>; Wed, 29 Apr 2020 09:22:28 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id p16so2003633edm.10
        for <linux-nfs@vger.kernel.org>; Wed, 29 Apr 2020 09:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6rI/EOJNlUmn/lR0qRlL7zUw750jHD1jj8mdNLfTnoM=;
        b=EabKSNBxyV+rUbcyIe5jGhrob+JqySCEGWE4yNsOdKXhp10MA8xCQARzqkYwadfZhO
         8++rXAKScl7PPaR4hGN2d4TG2iweANPbnqe8+Fh2mLJD/L+AY3WTHJ/AmtvA8GLw4xbu
         +zu0wAfFZc07XVDkWLtMqL0JZcE8zI8fdTccrgCOrioMQSZeUMKeC8WJZJUMTkJXaNzs
         1VzQMYPRK3EQrk9t9uffwxiQmjYc39nVT9MBcHt2fwRt1JCXNxusw8blidVVHaHP3RZR
         aZE8hnz6vcKRKvhHrBfTOy6xwIJvmwcw2JQvNrQre7IEhmqf3Yy1PNnTyysvvsGOcyqB
         jKOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6rI/EOJNlUmn/lR0qRlL7zUw750jHD1jj8mdNLfTnoM=;
        b=KIyqXtvimnmVbO87I6Ctr4kfr2xOW4dNNsUJrJIJe3VfjJvHjXwqmGiMLvIm5NVW8p
         PvzN7JiUwxrWwm0h1HXT7gZgi7rrpk9wN3flO0m0kEfnckGnFSTz5NNN2MLg/FQNyKv4
         FQ98R1HS77H4NqHF0jyCnUznUgaK+g5kg85rcj5WbVD3+n6IIVxHQ2s4hntt1GsKIdKv
         4QPgD3/zBYKhcpcJnyD7U58txP8qMtxz1cffiIHUYn00FMXVu5QMwno8mN38W8L9Vkst
         0JvmxXUbQ1AEOJuWPTVelRFgBJmzDLxBGWVzn0D7f8UFEuR8TEzM4SA9veJfoY3KcdjX
         6UGg==
X-Gm-Message-State: AGi0PuYl0XzNwtJmxTI7waGfeKAScHo9u3G1Tc4vzUlDv0WdxRWwhOuw
        ekO0Ghu7re6BCafIMVHdsW9WWPKoJpeb1fx1mfbG5w==
X-Google-Smtp-Source: APiQypKtU1i1+ATUd/2TqdPITtzVVIh8++tZNI72DOY9AZk7jMiCeLMJZSo1r96w3NV0lqkEHENbedrAUFOz57+ehJ0=
X-Received: by 2002:aa7:d514:: with SMTP id y20mr3303811edq.28.1588177347552;
 Wed, 29 Apr 2020 09:22:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAN-5tyE6JTeK7RFA7AkcO63p6iFE2v1+x2RFwRrTB1Jb1Yr76Q@mail.gmail.com>
 <98410608e028cb4b53024c7669e0fb70fea98214.camel@hammerspace.com>
 <CAN-5tyGDC9ittxr7d4wL_fKLQu9NLdZWwB19iEPsCn+Y0_sqVg@mail.gmail.com>
 <98a10c8775e4127419ac57630f839744bdf1063d.camel@hammerspace.com>
 <CAN-5tyGfCXVTz4dq3Qj2eXww8BNB_dT=0QwWteEGM93MZBJudw@mail.gmail.com>
 <b96e65b7aeb72e466d2a0170d4347652b6ab0ec5.camel@hammerspace.com>
 <8549f1fc955faedc35d810a4ad3e21904379a59a.camel@hammerspace.com>
 <CAN-5tyFRDg7W9pt57jTzoRgL8L=0_d7gCoRiAqWQR36iny33NQ@mail.gmail.com> <20200429154638.GB4799@fieldses.org>
In-Reply-To: <20200429154638.GB4799@fieldses.org>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Wed, 29 Apr 2020 12:22:16 -0400
Message-ID: <CAN-5tyE7i3qxv7WyrAZkq2VCFrh1Kw4Q1eonG2Ep_YLFkMiJwQ@mail.gmail.com>
Subject: Re: handling ERR_SERVERFAULT on RESTOREFH
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Apr 29, 2020 at 11:46 AM J. Bruce Fields <bfields@fieldses.org> wrote:
>
> On Tue, Apr 28, 2020 at 10:12:29PM -0400, Olga Kornievskaia wrote:
> > I also believe that client shouldn't be coded to a broken server. But
> > in some of those cases, the client is not spec compliant, how is that
> > a server bug? The case of SERVERFAULT of RESTOREFH I'm not sure what
> > to make of it. I think it's more of a spec failure to address. It
> > seems that server isn't allowed to fail after executing a
> > non-idempotent operation but that's a hard requirement. I still think
> > that client's best set of action is to ignore errors on RESTOREFH.
>
> Maybe.  But how is a server hitting SERVERFAULT on RESTOREFH, anyway?
> That's pretty weird.

An example error is ENOMEM. A server is doing operations to lookup the
filehandle (due to it being some other place) and needs to allocate
memory. It's possible that resources are currently unavailable. Since
RESTOREFH doesn't allow EDELAY, server can only return SERVERFAULT.
But as I mentioned before, even if EDELAY was allowed, client only
resends the whole compound which is incorrect in case of
non-idempotent operations.
