Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA7C2C4284
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Nov 2020 15:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729148AbgKYO40 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 25 Nov 2020 09:56:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47594 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726039AbgKYO40 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 25 Nov 2020 09:56:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606316185;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ie2mZVXv8VIoKm02HljM+p1latB4kaiVCyIytKOs7ao=;
        b=You0wdb5OMnlZqGftjrotoykJXbQG/w79H/B+z2YL3uPuAuN+GzGUkp81Tjm7nZJEKqkki
        uxYuYTin+FsxrRDzhUu3zEPSBhwY0UtmDTYWW/ZQyOO1sSMDOV5nIQdFBia5gRNnMJ7Gy6
        SRZuQhwdD7xxBu1f7XySW7/138IBXSM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-399-waI8F4pfN9epfnL65abOKA-1; Wed, 25 Nov 2020 09:56:19 -0500
X-MC-Unique: waI8F4pfN9epfnL65abOKA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C9C22107ACE3;
        Wed, 25 Nov 2020 14:56:18 +0000 (UTC)
Received: from pick.fieldses.org (ovpn-112-146.rdu2.redhat.com [10.10.112.146])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AAF8D19D61;
        Wed, 25 Nov 2020 14:56:18 +0000 (UTC)
Received: by pick.fieldses.org (Postfix, from userid 2815)
        id CA62E120304; Wed, 25 Nov 2020 09:56:17 -0500 (EST)
Date:   Wed, 25 Nov 2020 09:56:17 -0500
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Jeff Layton <jlayton@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: NFSD merge candidate for v5.11
Message-ID: <20201125145617.GA77389@pick.fieldses.org>
References: <48FA73BE-2D86-4A3F-91D5-C1086E228938@oracle.com>
 <0cbeed0a0fa2352961966efdd7e62247b5cd7a7b.camel@redhat.com>
 <5A43C026-0746-4F62-8298-2501EF1EF692@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5A43C026-0746-4F62-8298-2501EF1EF692@oracle.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Nov 24, 2020 at 07:36:21PM -0500, Chuck Lever wrote:
> 
> 
> > On Nov 24, 2020, at 6:14 PM, Jeff Layton <jlayton@redhat.com> wrote:
> > 
> > On Tue, 2020-11-24 at 17:51 -0500, Chuck Lever wrote:
> >> Hi-
> >> 
> >> I've added my NFSv4 XDR decoder series and Bruce's iversion
> >> series to my "for next" topic branch to get some early
> >> testing exposure for these changes.
> >> 
> >> Bruce's series is based on 8/8 posted on November 20, with
> >> Jeff's review comments integrated. The NFSD XDR decoder
> >> patches are based on v4, posted yesterday afternoon with
> >> Bruce's review comments integrated.
> >> 
> >> The full branch is available here:
> >> 
> >>   git://git.linux-nfs.org/projects/cel/cel-2.6.git cel-next
> >> 
> >> or
> >> 
> >>   http://git.linux-nfs.org/?p=cel/cel-2.6.git;a=shortlog;h=refs/heads/cel-next
> >> 
> >> ...and is still open for changes or additional patches. This
> >> branch is pulled into linux-next regularly.
> > 
> > Minor nit in:
> > 
> >    http://git.linux-nfs.org/?p=cel/cel-2.6.git;a=commit;h=2513716015eba398378bf453d5d2dd46c63a3399
> > 
> > You added a generic_check_iversion prototype to fs.h.
> > 
> > Move that into iversion.h. I think it makes more sense there, and that
> > avoids the huge rebuild that occurs when fs.h changes.
> 
> Declarations for most other generic_* functions are in fs.h.
> But OK, moved, and the series pushed.
> 
> So I think the btrfs/ext4/xfs-specific changes might need
> sign-off by those maintainers.

And nfs, I think that's the one I'm mostly likely to have messed up,
actually....

> Should I post this series to linux-fsdevel? Or, Bruce, do you want to?

I think I should do it.

--b.

