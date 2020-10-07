Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D561285553
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Oct 2020 02:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbgJGASQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 6 Oct 2020 20:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgJGASP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 6 Oct 2020 20:18:15 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9010C061755
        for <linux-nfs@vger.kernel.org>; Tue,  6 Oct 2020 17:18:15 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 8EDC7367; Tue,  6 Oct 2020 20:18:14 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 8EDC7367
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1602029894;
        bh=PBP3kZ0UmnFXH3VUn/gGdbjdMG+BcQaacF2gsZp143Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eoxl4sNnGEhoPd3o7BIVNMO0nfXF8/7SjhuGqh/pAIdwBaPSvgL9H/Y8t83vxU3EM
         9IEhCNhY/CUcgBw+tbaTByFw359ezYSUREkfpaALpuZzI6RSLoQ+Bofwk+BFcpaBFt
         ZyhetgbCtBsdbsFZpLcWU4QL21Vw49r6OK/zYdr0=
Date:   Tue, 6 Oct 2020 20:18:14 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Olga Kornievskaia <aglo@umich.edu>
Cc:     Benjamin Coddington <bcodding@redhat.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Subject: Re: unsharing tcp connections from different NFS mounts
Message-ID: <20201007001814.GA5138@fieldses.org>
References: <20201006151335.GB28306@fieldses.org>
 <95542179-0C20-4A1F-A835-77E73AD70DB8@redhat.com>
 <CAN-5tyGDC0VQqjqUNzs_Ka+-G_1eCScVxuXvWsp7xe7QYj69Ww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN-5tyGDC0VQqjqUNzs_Ka+-G_1eCScVxuXvWsp7xe7QYj69Ww@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Oct 06, 2020 at 05:46:11PM -0400, Olga Kornievskaia wrote:
> On Tue, Oct 6, 2020 at 3:38 PM Benjamin Coddington <bcodding@redhat.com> wrote:
> >
> > On 6 Oct 2020, at 11:13, J. Bruce Fields wrote:
> >
> > > NFSv4.1+ differs from earlier versions in that it always performs
> > > trunking discovery that results in mounts to the same server sharing a
> > > TCP connection.
> > >
> > > It turns out this results in performance regressions for some users;
> > > apparently the workload on one mount interferes with performance of
> > > another mount, and they were previously able to work around the
> > > problem
> > > by using different server IP addresses for the different mounts.
> > >
> > > Am I overlooking some hack that would reenable the previous behavior?
> > > Or would people be averse to an "-o noshareconn" option?
> >
> > I suppose you could just toggle the nfs4_unique_id parameter.  This
> > seems to
> > work:
> >
> > flock /sys/module/nfs/parameters/nfs4_unique_id bash -c "OLD_ID=\$(cat
> > /sys/module/nfs/parameters/nfs4_unique_id); echo imalittleteapot >
> > /sys/module/nfs/parameters/nfs4_unique_id; mount -ov4,sec=sys
> > 10.0.1.200:/exports /mnt/fedora2; echo \$OLD_ID >
> > /sys/module/nfs/parameters/nfs4_unique_id"
> >
> > I'm trying to think of a reason why this is a bad idea, and not coming
> > up
> > with any.  Can we support users that have already found this solution?
> >
> 
> What about reboot recovery? How will each mount recover its own state
> (and present the same identifier it used before). Client only keeps
> track of one?

Looks like nfs4_init_{non}uniform_client_string() stores it in
cl_owner_id, and I was thinking that meant cl_owner_id would be used
from then on....

But actually, I think it may run that again on recovery, yes, so I bet
changing the nfs4_unique_id parameter midway like this could cause bugs
on recovery.

--b.
