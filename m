Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 013E328632B
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Oct 2020 18:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728544AbgJGQF5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 7 Oct 2020 12:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728177AbgJGQF5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 7 Oct 2020 12:05:57 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC02C061755
        for <linux-nfs@vger.kernel.org>; Wed,  7 Oct 2020 09:05:57 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 83E6969C3; Wed,  7 Oct 2020 12:05:56 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 83E6969C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1602086756;
        bh=+eYBaeT1bfmMnAcszS5mtmzOWCe9ejzwWD7J6m/UFlY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TyDyD3/v6FBl8l7CtEvjoLeUZAn7eWigOZtzMIaKx28VF+CQcNvUM/A+jzJaHCMAK
         EAzsJcW3UzFnBE4tf/B2X9qL91CJ3gtbdkc930fQor33qwJlPUQItuPzv/wyVz2QMl
         TD0/wruBMSbJkRE5nz8+j51DThne3bjUAerVjyJQ=
Date:   Wed, 7 Oct 2020 12:05:56 -0400
From:   Bruce Fields <bfields@fieldses.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Benjamin Coddington <bcodding@redhat.com>,
        Olga Kornievskaia <aglo@umich.edu>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: unsharing tcp connections from different NFS mounts
Message-ID: <20201007160556.GE23452@fieldses.org>
References: <20201006151335.GB28306@fieldses.org>
 <95542179-0C20-4A1F-A835-77E73AD70DB8@redhat.com>
 <CAN-5tyGDC0VQqjqUNzs_Ka+-G_1eCScVxuXvWsp7xe7QYj69Ww@mail.gmail.com>
 <20201007001814.GA5138@fieldses.org>
 <57E3293C-5C49-4A80-957B-E490E6A9B32E@redhat.com>
 <5B5CF80C-494A-42D3-8D3F-51C0277D9E1B@redhat.com>
 <8ED5511E-25DE-4C06-9E26-A1947383C86A@oracle.com>
 <20201007140502.GC23452@fieldses.org>
 <85F496CD-9AAC-451C-A224-FCD138BDC591@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85F496CD-9AAC-451C-A224-FCD138BDC591@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Oct 07, 2020 at 10:15:39AM -0400, Chuck Lever wrote:
> 
> 
> > On Oct 7, 2020, at 10:05 AM, Bruce Fields <bfields@fieldses.org> wrote:
> > 
> > On Wed, Oct 07, 2020 at 09:45:50AM -0400, Chuck Lever wrote:
> >> 
> >> 
> >>> On Oct 7, 2020, at 8:55 AM, Benjamin Coddington <bcodding@redhat.com> wrote:
> >>> 
> >>> On 7 Oct 2020, at 7:27, Benjamin Coddington wrote:
> >>> 
> >>>> On 6 Oct 2020, at 20:18, J. Bruce Fields wrote:
> >>>> 
> >>>>> On Tue, Oct 06, 2020 at 05:46:11PM -0400, Olga Kornievskaia wrote:
> >>>>>> On Tue, Oct 6, 2020 at 3:38 PM Benjamin Coddington <bcodding@redhat.com> wrote:
> >>>>>>> 
> >>>>>>> On 6 Oct 2020, at 11:13, J. Bruce Fields wrote:
> >>> 
> >>>>> Looks like nfs4_init_{non}uniform_client_string() stores it in
> >>>>> cl_owner_id, and I was thinking that meant cl_owner_id would be used
> >>>>> from then on....
> >>>>> 
> >>>>> But actually, I think it may run that again on recovery, yes, so I bet
> >>>>> changing the nfs4_unique_id parameter midway like this could cause bugs
> >>>>> on recovery.
> >>>> 
> >>>> Ah, that's what I thought as well.  Thanks for looking closer Olga!
> >>> 
> >>> Well, no -- it does indeed continue to use the original cl_owner_id.  We
> >>> only jump through nfs4_init_uniquifier_client_string() if cl_owner_id is
> >>> NULL:
> >>> 
> >>> 6087 static int
> >>> 6088 nfs4_init_uniform_client_string(struct nfs_client *clp)
> >>> 6089 {
> >>> 6090     size_t len;
> >>> 6091     char *str;
> >>> 6092
> >>> 6093     if (clp->cl_owner_id != NULL)
> >>> 6094         return 0;
> >>> 6095
> >>> 6096     if (nfs4_client_id_uniquifier[0] != '\0')
> >>> 6097         return nfs4_init_uniquifier_client_string(clp);
> >>> 6098
> >>> 
> >>> 
> >>> Testing proves this out as well for both EXCHANGE_ID and SETCLIENTID.
> >>> 
> >>> Is there any precedent for stabilizing module parameters as part of a
> >>> supported interface?  Maybe this ought to be a mount option, so client can
> >>> set a uniquifier per-mount.
> >> 
> >> The protocol is designed as one client-ID per client. FreeBSD is
> >> the only client I know of that uses one client-ID per mount, fwiw.
> >> 
> >> You are suggesting each mount point would have its own lease. There
> >> would likely be deeper implementation changes needed than just
> >> specifying a unique client-ID for each mount point.
> > 
> > Huh, I thought that should do it.
> > 
> > Do you have something specific in mind?
> 
> The relationship between nfs_client and nfs_server structs comes to
> mind.

I'm not following.  Do you have a specific problem in mind?

--b.

> 
> Trunking discovery has been around for several years. This is the
> first report I've heard of a performance regression.
> 
> We do know that nconnect helps relieve head-of-line blocking on TCP.
> I think adding a second socket would be a very easy thing to try and
> wouldn't have any NFSv4 state recovery ramifications.
> 
> 
> --
> Chuck Lever
> 
> 
