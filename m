Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0B4C35A8B4
	for <lists+linux-nfs@lfdr.de>; Sat, 10 Apr 2021 00:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234880AbhDIW0R (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 9 Apr 2021 18:26:17 -0400
Received: from elasmtp-curtail.atl.sa.earthlink.net ([209.86.89.64]:46436 "EHLO
        elasmtp-curtail.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234602AbhDIW0R (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 9 Apr 2021 18:26:17 -0400
X-Greylist: delayed 7264 seconds by postgrey-1.27 at vger.kernel.org; Fri, 09 Apr 2021 18:26:17 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mindspring.com;
        s=dk12062016; t=1618007164; bh=ZoiMwY7LpzT/lCaRojlHniOtbNobkmLtNZhi
        Ym8rjh4=; h=Received:From:To:Cc:References:In-Reply-To:Subject:Date:
         Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
         X-Mailer:Thread-Index:Content-Language:X-ELNK-Trace:
         X-Originating-IP; b=FpKYreDOxlRCM7ocsOyZVaUqvkJdvHidSUAIulgiSDRFX/
        AZLeInORKWP2g8CEojfoGxfnNZpJ32A7WpLpY3QR9JXF+qNt3GGzkzPyi5nXlgBzPpa
        RmPN7ooGXwNj+houlZ/KuExdMa2c7zjWnPWNAsxxBfb/L695S/7PDPsdPZ83PocMQHB
        XukF2gCyjNREnsMWxrHqTpv7M1Q2aEZjIZQuvTiKEH4rB6ptNpAlp4yMaDex+uzJOII
        y7nwh2HEyTDj2n7w8Kzm1kDp6rNPn/WdtWoHNpLs5cbzR7TBcOlw6ihfswR01TbGvQD
        YdqBKG7tIrEFBdeh9GyRos4061kQ==
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=dk12062016; d=mindspring.com;
  b=nOPhAPF7stZ+ZRma2N/ZgOEkpCJeZmj8zYIcp8LVbPCdxCLhofHJWMW0FftH9JaYgAyhW0tkHTyFClUJff/DN/L5/FuH4HrS7RHMSvIakfObYsLBZk1F0H3a1/okYaGIDQ0GdexjdxaanUO+1F4aU3cOpJVM/D7TQqvOKrhpnHNynoFl1plg0EO5ElICn+pkofgqvOVEERkK7aL34Q8jgr4Qan6z6GrSv9C8O3fgrD5mmqrb5tQKdRi4FHSOgqPvycWphDv83XUFIu3U2sSbY38YJB/X+awi3Ue+mufTjrYYmoNRlWitbNuNyafYGW0d1n3KVeK96rVS5vT5EKbF6A==;
  h=Received:From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer:Thread-Index:Content-Language:X-ELNK-Trace:X-Originating-IP;
Received: from [76.105.143.216] (helo=FRANKSTHINKPAD)
        by elasmtp-curtail.atl.sa.earthlink.net with esmtpa (Exim 4)
        (envelope-from <ffilzlnx@mindspring.com>)
        id 1lUxgW-000DMO-3t; Fri, 09 Apr 2021 16:24:56 -0400
From:   "Frank Filz" <ffilzlnx@mindspring.com>
To:     "'J. Bruce Fields'" <bfields@fieldses.org>,
        "'Rick Macklem'" <rmacklem@uoguelph.ca>
Cc:     "'Olga Kornievskaia'" <olga.kornievskaia@gmail.com>,
        "'J. Bruce Fields'" <bfields@redhat.com>,
        "'Chuck Lever'" <chuck.lever@oracle.com>,
        "'linux-nfs'" <linux-nfs@vger.kernel.org>, <nfsv4@ietf.org>
References: <20210331192819.25637-1-olga.kornievskaia@gmail.com> <YGUm7/HE3HqVJik2@pick.fieldses.org> <CAN-5tyETvKvUq_X7+2E0o=9GjJ628DC=QJW5xKA2-X7UHc_DOw@mail.gmail.com> <YQXPR0101MB0968C9AB372DC12408F496D8DD7B9@YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM> <20210402210157.GC16427@fieldses.org>
In-Reply-To: <20210402210157.GC16427@fieldses.org>
Subject: RE: [PATCH 1/1] NFSD fix handling of NFSv4.2 SEEK for data within the last hole
Date:   Fri, 9 Apr 2021 13:24:55 -0700
Message-ID: <131001d72d7e$681efef0$385cfcd0$@mindspring.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQJ9eI9Po8dWwwI+8Q91Byov2S54uQDjlne3AeR/+ncBmd/oGAGa/dQ9qTAjWRA=
Content-Language: en-us
X-ELNK-Trace: 136157f01908a8929c7f779228e2f6aeda0071232e20db4d0eb70eec7d54903ebdd8540ed99a872c350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 76.105.143.216
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

> Adding nfsv4@ietf.org:
> 
> On Thu, Apr 01, 2021 at 09:32:05PM +0000, Rick Macklem wrote:
> > I discussed this on nfsv4@ietf.org some time ago.
> > The problem with "fixing" the server is that it breaks the unpatched
> > Linux client.
> >
> > If the client is careful, it can work correctly for both a Linux and
> > RFC5661 conformant server. That's what the FreeBSD client tries to do.
> > --> I'd suggest that be your main goal.
> >
> > The FreeBSD server ships "Linux compatible", but there is a switch to
> > make it RFC5661 compatible.
> > --> I wouldn't make it default the RFC compatible for
> >       quite a while after the client that handles RFC compatible
> >       ships.
> >
> > I tried to convince folks to "errata" the RFC to Linux compatible
> > (since Linux was the only shipping 4.2 at the time, but they did not
> > consider it an "errata").
> 
> Previous discussion here:
> 
> 	https://mailarchive.ietf.org/arch/msg/nfsv4/bPLFnywt1wZ4kolMkzeSYc
> a0qIM/
> 
> There's no rejection on that thread, was it elsewhere?

Yea, it would be nice to resolve this. I remember having to tweak Ganesha's
implementation to not break the Linux client.

I'm still not sure I got it right...

Frank

