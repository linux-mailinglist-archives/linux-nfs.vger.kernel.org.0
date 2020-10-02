Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F192E2819F7
	for <lists+linux-nfs@lfdr.de>; Fri,  2 Oct 2020 19:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388176AbgJBRm4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 2 Oct 2020 13:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726813AbgJBRmz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 2 Oct 2020 13:42:55 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A17AC0613D0
        for <linux-nfs@vger.kernel.org>; Fri,  2 Oct 2020 10:42:55 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 44382410D; Fri,  2 Oct 2020 13:42:55 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 44382410D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1601660575;
        bh=45ubtBSFdzHPHqBKxI+PLcNQ1Sij/tPMc0FefrYi634=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ce9J24R9DgYU36IyXSSVm/cuq0+hZYcsw69KOaTfwVHIe7HbfEadkEHitUt0bivcw
         OSys2aBgIg+OqC3s/w6qL/TIRxqwhB6Cdc7GPPUdp7ih8nzwbhbflPZWzoaVyQtFwS
         Oe5XtYJoiB/hOumkzxAlHkIWOtNkTfEIAN8EFavI=
Date:   Fri, 2 Oct 2020 13:42:55 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH v3 00/15] nfsd_dispatch() clean up
Message-ID: <20201002174255.GB31151@fieldses.org>
References: <160159301676.79253.16488984581431975601.stgit@klimt.1015granger.net>
 <20201002173908.GA31151@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201002173908.GA31151@fieldses.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Oct 02, 2020 at 01:39:08PM -0400, J. Bruce Fields wrote:
> I'm seeing a pynfs4.0 GATT9 regression.  That's a test that attempts a
> compound with 90 GETATTR ops each a request for all mandatory
> attributes.  The test expects OK or RESOURCE but looks like its getting
> a corrupted response?  (I haven't looked at the wire traffic yet.)  I
> think it's one of the final patches changing how errors are returned.

Also some other tests that send compounds with lots of ops:

GATT9    st_getattr.testLotsofGetattrsFile                        : FAILURE
           nfs4lib.InvalidCompoundRes: Invalid COMPOUND result:
           Truncated response list.
COMP6    st_compound.testLongCompound                             : FAILURE
           COMPOUND with len=150 argarry got Invalid COMPOUND
           result: Truncated response list., expected
           NFS4ERR_RESOURCE
COMP4    st_compound.testInvalidMinor                             : FAILURE
           nfs4lib.InvalidCompoundRes: Invalid COMPOUND result:
           Truncated response list.

Bisect lands on the last patch ("Hoist status code...").

--b.

> 
> --b.
> 
> On Thu, Oct 01, 2020 at 06:58:46PM -0400, Chuck Lever wrote:
> > Hi Bruce-
> > 
> > Here's the latest version of the nfsd_dispatch clean up series,
> > building on the "non-controversial" patches I posted last week.
> > 
> > The purpose of this series is three-fold:
> > 
> > o Prepare to add NFS procedure tracepoints
> > o Prepare to eventually deprecate NFSv2
> > o Minor optimizations of the dispatcher hot path
> > 
> > 
> > Changes since v2:
> > - Fixed crasher caused by invoking NFSv2 ROOT or WRITECACHE
> > - Hoisted encoding of NFS status code into XDR Reply encoders
> > - Numerous bug fixes, clean ups, and patch re-ordering
> > 
> > Changes since v1:
> > - Pulled in latest version of rq_lease_breaker cleanup
> > - Added patches to make NFSv2 error encoding similar to NFSv3
> > - Clarified nfsd_dispatch's new documenting comment
> > - Renamed a variable
> > 
> > ---
> > 
> > Chuck Lever (14):
> >       NFSD: Add missing NFSv2 .pc_func methods
> >       lockd: Replace PROC() macro with open code
> >       NFSACL: Replace PROC() macro with open code
> >       NFSD: Encoder and decoder functions are always present
> >       NFSD: Clean up switch statement in nfsd_dispatch()
> >       NFSD: Clean up stale comments in nfsd_dispatch()
> >       NFSD: Clean up nfsd_dispatch() variables
> >       NFSD: Refactor nfsd_dispatch() error paths
> >       NFSD: Remove vestigial typedefs
> >       NFSD: Fix .pc_release method for NFSv2
> >       NFSD: Call NFSv2 encoders on error returns
> >       NFSD: Remove the RETURN_STATUS() macro
> >       NFSD: Map nfserr_wrongsec outside of nfsd_dispatch
> >       NFSD: Hoist status code encoding into XDR encoder functions
> > 
> > J. Bruce Fields (1):
> >       nfsd: rq_lease_breaker cleanup
> > 
> > 
> >  fs/lockd/svc4proc.c         | 248 ++++++++++++++++++++++++-------
> >  fs/lockd/svcproc.c          | 250 ++++++++++++++++++++++++-------
> >  fs/nfsd/export.c            |   2 +-
> >  fs/nfsd/nfs2acl.c           | 160 +++++++++++++-------
> >  fs/nfsd/nfs3acl.c           |  88 ++++++-----
> >  fs/nfsd/nfs3proc.c          | 238 +++++++++++++++---------------
> >  fs/nfsd/nfs3xdr.c           |  25 +++-
> >  fs/nfsd/nfs4proc.c          |   6 +-
> >  fs/nfsd/nfs4xdr.c           |  11 +-
> >  fs/nfsd/nfsproc.c           | 283 ++++++++++++++++++++----------------
> >  fs/nfsd/nfssvc.c            | 121 ++++++++-------
> >  fs/nfsd/nfsxdr.c            |  52 ++++++-
> >  fs/nfsd/xdr.h               |  16 +-
> >  fs/nfsd/xdr3.h              |   1 +
> >  fs/nfsd/xdr4.h              |   1 +
> >  include/uapi/linux/nfsacl.h |   2 +
> >  16 files changed, 984 insertions(+), 520 deletions(-)
> > 
> > --
> > Chuck Lever
