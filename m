Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EBD611BE02
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Dec 2019 21:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfLKUgN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Dec 2019 15:36:13 -0500
Received: from mail-vs1-f48.google.com ([209.85.217.48]:45437 "EHLO
        mail-vs1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbfLKUgN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 Dec 2019 15:36:13 -0500
Received: by mail-vs1-f48.google.com with SMTP id l24so16791089vsr.12
        for <linux-nfs@vger.kernel.org>; Wed, 11 Dec 2019 12:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xGrBdxSZoGPiFZJu2qSwSXu2ncRXSi1pVjKU6q9XQ4E=;
        b=IPCSe0J0xK0GtU4QHS1OFxSoSL8tWw5EZAQhUaGprOEz7MTfnc6Oo5e+7GXPIinHv+
         H/dVk1BPbhdMj9BQmVTwg7fEpdj5r2FxiypadzIgQTGt/wT0kAa0OQ+lHN8Sx2wxgc7D
         rmlbO/n+XI/Z3QE6fEgCtHKwqCpVJFsu2ZwJUUZARt6jOzGu/tUBO5RqbpnSr7IxzVNg
         rm04hAkJPXsrcacIFaH1vzw1Vf1s66EoQctsPCy802EbOV4+MP+PFKwrWOxV9YpoFO5b
         uMbsUWSoUGTTCHRBiyd5ubi2cD1Mu/62CBZx/NGNLjtkkr68SkES7dbdwsXUAukQvsmp
         zTAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xGrBdxSZoGPiFZJu2qSwSXu2ncRXSi1pVjKU6q9XQ4E=;
        b=A8ennouH4YV6YNsK3+AYBvbSz+n2GS5+Gh93dS2Vc8PGFkM2pWthwIjHijCV1wy0pt
         YxaM14Mwt1ynxrQhGctAS0m+UYceXXCiYQ7gjzRPveLdNQXZE+aUVIzQL5d1Kg/ZEFT1
         qQnr8a3a31GXtTdNb5N39e0ElN1c7jCTDVsh+AuGGeZe/UtkC4N9LlviC7GG0mnRZpbr
         fQT1K86axhhvnWf7WntcD82bvArzYsg0R8KsZNV/z+azXLMVxi+Pxi04MGnsMHB2PU0v
         3GzR9M4fcrCNDGvoGJVKFQNfFKzN4IaQznGTyX51QWFmfwzFwng3Y1xAA/N+8s+i7Bkp
         s+SA==
X-Gm-Message-State: APjAAAWDJgQ9fpq3Y83Y/kPG82hk1Di63eEhGcWUnvIE69p6wK5J/E76
        IWAqrgqksQ7Rmr1Yg1Ubf8DYk4BAmDinRw2sfLa+nw==
X-Google-Smtp-Source: APXvYqwYU0l0I5z8NzOuGV5y+OR7DJ0m1X2z9Wn2jVIPoM3BzdyGRRx5pGhTPwMwM/bvSII9yB0lUavTggr0uHwOh0M=
X-Received: by 2002:a67:c097:: with SMTP id x23mr4546889vsi.164.1576096571900;
 Wed, 11 Dec 2019 12:36:11 -0800 (PST)
MIME-Version: 1.0
References: <CAN-5tyH_+OZJ+eUGvqvo+-EuG1OdaoFYERNKi=k=CDxpOFVoCQ@mail.gmail.com>
 <e2541b5d08b823aaec01195178e87ba39526aa92.camel@hammerspace.com> <CAN-5tyFVb_jqt+jknn2+o6_Cu=7cKw4qt9B_e2pd0azu2-7zaQ@mail.gmail.com>
In-Reply-To: <CAN-5tyFVb_jqt+jknn2+o6_Cu=7cKw4qt9B_e2pd0azu2-7zaQ@mail.gmail.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Wed, 11 Dec 2019 15:36:00 -0500
Message-ID: <CAN-5tyHm+aG9GmM1EWFDLeKfLxJWvGSGbRP5QwN4=phwaNQkyQ@mail.gmail.com>
Subject: Re: NFS/TCP timeouts
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Trond,

I'd like to raise this once again. Is this true that setting a timeout
limit (TCP_USER_TIMEOUT) is not user configurable (rather I'm pretty
sure it is not) but my question is why shouldn't it be tied to the
"timeo" mount option? Right now, only the sesson/lease manager thread
sets it via rpc_set_connect_timeout() to be lease period related.

Is it the fact that we don't want to allow user to control TCP
settings via the mount options? But somehow folks are expecting to be
able to set low "timeo" value and have the (dead) connection to be
considered dead earlier than for a rather long timeout period which is
happening now.

Thanks.

On Wed, Oct 3, 2018 at 3:06 PM Olga Kornievskaia <aglo@umich.edu> wrote:
>
> On Wed, Oct 3, 2018 at 2:45 PM Trond Myklebust <trondmy@hammerspace.com> wrote:
> >
> > On Wed, 2018-10-03 at 14:31 -0400, Olga Kornievskaia wrote:
> > > Hi folks,
> > >
> > > Is it true that NFS mount option "timeo" has nothing to do with the
> > > socket's setting of the user-specified timeout TCP_USER_TIMEOUT.
> > > Instead, when creating a TCP socket NFS uses either default/hard
> > > coded
> > > value of 60s for v3 or for v4.x it's lease based. Is there no value
> > > is
> > > having an adjustable TCP timeout value?
> > >
> >
> > It is adjusted. Please see the calculation in
> > xs_tcp_set_socket_timeouts().
>
> but it's not user configurable, is it? I don't see a way to modify
> v3's default 60s TCP timeout. and also in v4, the timeouts are set
> from xs_tcp_set_connect_timeout() for the lease period but again not
> user configurable, as far as i can tell.
>
> >
> > --
> > Trond Myklebust
> > Linux NFS client maintainer, Hammerspace
> > trond.myklebust@hammerspace.com
> >
> >
