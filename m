Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0966BF669
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Sep 2019 18:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbfIZQF5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 26 Sep 2019 12:05:57 -0400
Received: from fieldses.org ([173.255.197.46]:33998 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726984AbfIZQF5 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 26 Sep 2019 12:05:57 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id AC0611513; Thu, 26 Sep 2019 12:05:56 -0400 (EDT)
Date:   Thu, 26 Sep 2019 12:05:56 -0400
From:   Bruce Fields <bfields@fieldses.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Kevin Vasko <kvasko@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: NFSv4 client locks up on larger writes with Kerberos enabled
Message-ID: <20190926160556.GC29192@fieldses.org>
References: <CAMd28E-pJp4=kvp62FJqGLZo-jGA2rH2OT6-hK_N=TvMiJuT2A@mail.gmail.com>
 <20190925164831.GA9366@fieldses.org>
 <57192382-86BE-4878-9AE0-B22833D56367@oracle.com>
 <CAMd28E-zcjuCfVbDCra4Av3Ewsdd-Ai=E0j3tF2GKJ8P6nG8=w@mail.gmail.com>
 <FCAD9EFD-26AD-41F0-BCCA-80E475219731@oracle.com>
 <20190925200723.GA11954@fieldses.org>
 <1BC54D7A-073E-40FD-9AA3-552F1E1BD214@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1BC54D7A-073E-40FD-9AA3-552F1E1BD214@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Sep 26, 2019 at 08:55:17AM -0700, Chuck Lever wrote:
> > On Sep 25, 2019, at 1:07 PM, Bruce Fields <bfields@fieldses.org> wrote:
> > 
> > On Wed, Sep 25, 2019 at 11:49:14AM -0700, Chuck Lever wrote:
> >> Sounds like the NFS server is dropping the connection. With
> >> GSS enabled, that's usually a sign that the GSS window has
> >> overflowed.
> > 
> > Would that show up in the rpc statistics on the client somehow?
> 
> More likely on the server. The client just sees a disconnect
> without any explanation attached.

So watching a count of disconnects might at least tell us something?

> gss_verify_header is where the checking is done on the server.
> Disappointingly, I see some dprintk's in there, but no static
> trace events.

Kevin, was this a Linux server?

--b.

> > In that case--I seem to remember there's a way to configure the size of
> > the client's slot table, maybe lowering that (decreasing the number of
> > rpc's allowed to be outstanding at a time) would work around the
> > problem.
> 
> > Should the client be doing something different to avoid or recover from
> > overflows of the gss window?
> 
> The client attempts to meter the request stream so that it stays
> within the bounds of the GSS sequence number window. The stream
> of requests is typically unordered coming out of the transmit
> queue.
> 
> There is some new code (since maybe v5.0?) that handles the
> metering: gss_xmit_need_reencode().
