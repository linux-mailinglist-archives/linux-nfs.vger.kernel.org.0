Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96F481251E6
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Dec 2019 20:32:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbfLRTcF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 18 Dec 2019 14:32:05 -0500
Received: from mail-vs1-f52.google.com ([209.85.217.52]:37362 "EHLO
        mail-vs1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbfLRTcF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 18 Dec 2019 14:32:05 -0500
Received: by mail-vs1-f52.google.com with SMTP id x18so2171256vsq.4
        for <linux-nfs@vger.kernel.org>; Wed, 18 Dec 2019 11:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ffW+fMDsvQTf+KkJ/1o6lvUICgqwjx6Ck6Xjq8VPv6Y=;
        b=k5I4begdCA/JToQGOCGogVRv8kHwq8GfBWCxgPywIK9nOS1IjsWbJVazyAFnCw3OXI
         6TvX8IOY450vAxZXHoEPT/KSTo56Z+Y4AcI1+nz3hMEj6Jd/gUNnfNe3cnTBZt1ZimbZ
         GbxrsMyvNjVqTc4z7XaJSDedtRDrX1YPu/y4yQvrMTykg+JL1HBAM1jJsRGrQoc3MhWy
         z606zzHKmYODbV4JK9nAmk8fVRhD9SencOebgvcFaeBgysqt+G2pI65ANByV4cKiBwD9
         q4a+ULSnBxV7Gyxf6QRTN2dQ2zca/Ls1CTxgw247p61oKZ7DN99bh4zPd1RwA4PiME/M
         ZN+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ffW+fMDsvQTf+KkJ/1o6lvUICgqwjx6Ck6Xjq8VPv6Y=;
        b=a9gBG6ut9iKQgoq1VmaqimQDSWOFs3vAaIDyhKrwu4zvUbHyFWSh9REZw2UUCxg/f/
         KHI1vekb1P7HgxfhiY3sWvJSc2uL7zZrYMtz55BWglD7ZEps1khNZP5zmPN/9V++IthX
         +5jnilm4/SnwPupe2NY5E5OhfBqdX25wnI2/sRXMste1jZghEpNKyI/rIE4l2mzDK87N
         zY72Y+W0JpFanYoeRKsFeEiFwXqHSu8qA5Jocq/xtjkUiZjlSS4ctG4nlxPz/8Hp2m3b
         1myM/E3XrkpXxWMQ7d3fi1ASVZqbimStxI7Ix9SCYH8REsk/T5UokhQJoCkrbiZPQV8d
         yYrw==
X-Gm-Message-State: APjAAAXFxcfXYs8JvfstNKGX9t2MtKLzrZkOwi6BeqSsyBl2gtTr/C5j
        0P2siJimz9ra4tC/TDsafLnW8akxFc4P/V9y6urCJg==
X-Google-Smtp-Source: APXvYqyEdlcrnrC+mk1/o0BTM7RzvUUAGGypUzc1KalpKVs0Y9mxIAGEILq9PICiYDKRd1e3khBX8sJe67AMIjq50ic=
X-Received: by 2002:a67:c90d:: with SMTP id w13mr2663124vsk.164.1576697524199;
 Wed, 18 Dec 2019 11:32:04 -0800 (PST)
MIME-Version: 1.0
References: <CAN-5tyHJLh8+htpb47Uz+ojo5EfrpP=zyE-Vfk=HjvBgK591=g@mail.gmail.com>
 <f4595e80487d9ace332e2ae69bc0c539a5c029bb.camel@hammerspace.com>
In-Reply-To: <f4595e80487d9ace332e2ae69bc0c539a5c029bb.camel@hammerspace.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Wed, 18 Dec 2019 14:31:52 -0500
Message-ID: <CAN-5tyGXUhhZVkrBxTwGP-Y2FXoMdN9kYtc9r0wS8P8EQuxyoQ@mail.gmail.com>
Subject: Re: acls+kerberos (limitation)
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Dec 18, 2019 at 2:05 PM Trond Myklebust <trondmy@hammerspace.com> wrote:
>
> On Wed, 2019-12-18 at 12:47 -0500, Olga Kornievskaia wrote:
> > Hi folks,
> >
> > Is this a well know but undocumented fact that you can't set large
> > amount of acls (over 4096bytes, ~90acls) while mounted using
> > krb5i/krb5p? That if you want to get/set large acls, it must be done
> > over auth_sys/krb5?
> >
>
> It's certainly not something that I was aware of. Do you see where that
> limitation is coming from?

I haven't figure it exactly but gss_unwrap_resp_integ() is failing in
if (mic_offset > rcv_buf->len). I'm just not sure who sets up the
buffer (or why  rvc_buf->len is (4280) larger than a page can a
page-limit might make sense to for me but it's not). So you think it
should have been working.

> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>
>
