Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7842B51D6
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Nov 2020 21:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729852AbgKPUDS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 16 Nov 2020 15:03:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:48264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727864AbgKPUDS (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 16 Nov 2020 15:03:18 -0500
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 229F320A8B;
        Mon, 16 Nov 2020 20:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605556997;
        bh=sJs23miAxYmU1KLA+a9wL+vgosJovq8Y7WL4q7BANL4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=UvnxLFXoEo6ZsxJ2tfn12UcPQKEYhBw1oG+VOsHwfF9OagbBFk4w1S/oDbLWodbIm
         MMm5L7lErsvJtNjH3kTaAPkfmRv0481OaE/R0I0b2DcSTbpjjdtWrrhcSruOMIh16H
         +Gqlc8h7AsYunXaf41kbywabWeMsJAxiBY39OI/I=
Message-ID: <0047077b3bd79a96589626ba154e6d9e95a35478.camel@kernel.org>
Subject: Re: Adventures in NFS re-exporting
From:   Jeff Layton <jlayton@kernel.org>
To:     bfields <bfields@fieldses.org>
Cc:     Daire Byrne <daire@dneg.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        linux-cachefs <linux-cachefs@redhat.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Date:   Mon, 16 Nov 2020 15:03:15 -0500
In-Reply-To: <20201116190336.GH898@fieldses.org>
References: <444227972.86442677.1605206025305.JavaMail.zimbra@dneg.com>
         <20201112205524.GI9243@fieldses.org>
         <883314904.86570901.1605222357023.JavaMail.zimbra@dneg.com>
         <20201113145050.GB1299@fieldses.org> <20201113222600.GC1299@fieldses.org>
         <b0d61b4053442ba46fd2c707ee7e0608704c2598.camel@kernel.org>
         <20201116155619.GF898@fieldses.org>
         <83ebb6dc68216ce3f3dfd2a2736b7a301550efc5.camel@kernel.org>
         <20201116161407.GG898@fieldses.org>
         <db55bab87b6fc9dd1594f8c2e853f07b1165ff5d.camel@kernel.org>
         <20201116190336.GH898@fieldses.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1 (3.38.1-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 2020-11-16 at 14:03 -0500, bfields wrote:
> On Mon, Nov 16, 2020 at 11:38:44AM -0500, Jeff Layton wrote:
> > Hmm, ok... nfsd4_change_attribute() is called from nfs4 code but also
> > nfs3 code as well. The v4 caller (encode_change) only calls it when
> > IS_I_VERSION is set, but the v3 callers don't seem to pay attention to
> > that.
> 
> Weird.  Looking back....  That goes back to the original patch adding
> support for ext4's i_version, c654b8a9cba6 "nfsd: support ext4
> i_version".
> 
> It's in nfs3xdr.c, but the fields it's filling in, fh_pre_change and
> fh_post_change, are only used in nfs4xdr.c.  Maybe moving it someplace
> else (vfs.c?) would save some confusion.
> 
> Anyway, yes, that should be checking SB_I_VERSION too.
> 
> > I think the basic issue here is that we're trying to use SB_I_VERSION
> > for two different things. Its main purpose is to tell the kernel that
> > when it's updating the file times that it should also (possibly)
> > increment the i_version counter too. (Some of this is documented in
> > include/linux/iversion.h too, fwiw)
> > 
> > nfsd needs a way to tell whether the field should be consulted at all.
> > For that we probably do need a different flag of some sort. Doing it at
> > the fstype level seems a bit wrong though -- v2/3 don't have a real
> > change attribute and it probably shouldn't be trusted when exporting
> > them.
> 
> Oops, good point.
> 
> I suppose simplest is just another SB_ flag.
> 

Another idea might be to add a new fetch_iversion export operation that
returns a u64. Roll two generic functions -- one to handle the
xfs/ext4/btrfs case and another for the NFS/AFS/Ceph case (where we just
fetch it raw). When the op is a NULL pointer, treat it like the
!IS_I_VERSION case today.

-- 
Jeff Layton <jlayton@kernel.org>

