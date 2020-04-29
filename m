Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC891BE47D
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Apr 2020 18:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgD2Q7C (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 29 Apr 2020 12:59:02 -0400
Received: from fieldses.org ([173.255.197.46]:36902 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727071AbgD2Q7C (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 29 Apr 2020 12:59:02 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 08414200D; Wed, 29 Apr 2020 12:59:02 -0400 (EDT)
Date:   Wed, 29 Apr 2020 12:59:01 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Olga Kornievskaia <aglo@umich.edu>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: handling ERR_SERVERFAULT on RESTOREFH
Message-ID: <20200429165901.GC4799@fieldses.org>
References: <CAN-5tyE6JTeK7RFA7AkcO63p6iFE2v1+x2RFwRrTB1Jb1Yr76Q@mail.gmail.com>
 <98410608e028cb4b53024c7669e0fb70fea98214.camel@hammerspace.com>
 <CAN-5tyGDC9ittxr7d4wL_fKLQu9NLdZWwB19iEPsCn+Y0_sqVg@mail.gmail.com>
 <98a10c8775e4127419ac57630f839744bdf1063d.camel@hammerspace.com>
 <CAN-5tyGfCXVTz4dq3Qj2eXww8BNB_dT=0QwWteEGM93MZBJudw@mail.gmail.com>
 <b96e65b7aeb72e466d2a0170d4347652b6ab0ec5.camel@hammerspace.com>
 <8549f1fc955faedc35d810a4ad3e21904379a59a.camel@hammerspace.com>
 <CAN-5tyFRDg7W9pt57jTzoRgL8L=0_d7gCoRiAqWQR36iny33NQ@mail.gmail.com>
 <20200429154638.GB4799@fieldses.org>
 <CAN-5tyE7i3qxv7WyrAZkq2VCFrh1Kw4Q1eonG2Ep_YLFkMiJwQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN-5tyE7i3qxv7WyrAZkq2VCFrh1Kw4Q1eonG2Ep_YLFkMiJwQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Apr 29, 2020 at 12:22:16PM -0400, Olga Kornievskaia wrote:
> On Wed, Apr 29, 2020 at 11:46 AM J. Bruce Fields <bfields@fieldses.org> wrote:
> >
> > On Tue, Apr 28, 2020 at 10:12:29PM -0400, Olga Kornievskaia wrote:
> > > I also believe that client shouldn't be coded to a broken server. But
> > > in some of those cases, the client is not spec compliant, how is that
> > > a server bug? The case of SERVERFAULT of RESTOREFH I'm not sure what
> > > to make of it. I think it's more of a spec failure to address. It
> > > seems that server isn't allowed to fail after executing a
> > > non-idempotent operation but that's a hard requirement. I still think
> > > that client's best set of action is to ignore errors on RESTOREFH.
> >
> > Maybe.  But how is a server hitting SERVERFAULT on RESTOREFH, anyway?
> > That's pretty weird.
> 
> An example error is ENOMEM. A server is doing operations to lookup the
> filehandle (due to it being some other place) and needs to allocate
> memory. It's possible that resources are currently unavailable.

This is a filehandle that's been previously used in the compound.  All
the resource use I can think of here (filehandle storage, xdr reply
buffer space...) is very predictable in this compound.  If anything was
to cause trouble I'd expect it to be the GETATTR reply.

--b.
