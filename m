Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0246511ECAE
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Dec 2019 22:15:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbfLMVNL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Dec 2019 16:13:11 -0500
Received: from fieldses.org ([173.255.197.46]:32834 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbfLMVNL (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 13 Dec 2019 16:13:11 -0500
Received: by fieldses.org (Postfix, from userid 2815)
        id 15F10C5E; Fri, 13 Dec 2019 16:13:11 -0500 (EST)
Date:   Fri, 13 Dec 2019 16:13:11 -0500
From:   Bruce Fields <bfields@fieldses.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>
Subject: Re: [PATCH v2 10/12] nfsd: use boottime for lease expiry alculation
Message-ID: <20191213211311.GA12391@fieldses.org>
References: <20191213141046.1770441-1-arnd@arndb.de>
 <20191213141046.1770441-11-arnd@arndb.de>
 <CBC9899C-12BE-466E-8809-EA928AAE1F11@oracle.com>
 <CAK8P3a3RXqVqpeTmOrEGtXyeMGZV+5g_QzywGgLnfvi2GMDx=g@mail.gmail.com>
 <BBB37836-D835-4EB7-8593-080BF60BDA38@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BBB37836-D835-4EB7-8593-080BF60BDA38@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Dec 13, 2019 at 01:23:08PM -0500, Chuck Lever wrote:
> 
> 
> > On Dec 13, 2019, at 11:40 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > 
> > On Fri, Dec 13, 2019 at 5:26 PM Chuck Lever <chuck.lever@oracle.com> wrote:
> >>> On Dec 13, 2019, at 9:10 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > 
> >>> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
> >>> index 24534db87e86..508d7c6c00b5 100644
> >>> --- a/fs/nfsd/nfs4callback.c
> >>> +++ b/fs/nfsd/nfs4callback.c
> >>> @@ -823,7 +823,12 @@ static const struct rpc_program cb_program = {
> >>> static int max_cb_time(struct net *net)
> >>> {
> >>>      struct nfsd_net *nn = net_generic(net, nfsd_net_id);
> >>> -     return max(nn->nfsd4_lease/10, (time_t)1) * HZ;
> >>> +
> >>> +     /* nfsd4_lease is set to at most one hour */
> >>> +     if (WARN_ON_ONCE(nn->nfsd4_lease > 3600))
> >>> +             return 360 * HZ;
> >> 
> >> Why is the WARN_ON_ONCE added here? Is it really necessary?
> > 
> > This is to ensure the kernel doesn't change to a larger limit that
> > requires a 64-bit division on a 32-bit architecture.
> > 
> > With the old code, dividing by 10 was always fast as
> > nn->nfsd4_lease was the size of an integer register. Now it
> > is 64 bit wide, and I check that truncating it to 32 bit again
> > is safe.
> 
> OK. That comment should state this reason rather than just repeating
> what the code does. ;-)

Note that __nfsd4_write_time() already limits nfsd4_lease to 3600.

We could just use a smaller type for nfsd4_lease if that'd help.

--b.
