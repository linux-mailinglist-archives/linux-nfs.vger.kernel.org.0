Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C04A2819A1
	for <lists+linux-nfs@lfdr.de>; Fri,  2 Oct 2020 19:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388390AbgJBRjP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 2 Oct 2020 13:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbgJBRjJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 2 Oct 2020 13:39:09 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C48C0613D0
        for <linux-nfs@vger.kernel.org>; Fri,  2 Oct 2020 10:39:09 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 6A53D2C0; Fri,  2 Oct 2020 13:39:08 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 6A53D2C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1601660348;
        bh=R0jV+MuohxC+NEQaPKNQK1Wxm/5O3YFw3XO25ArM9QM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mD8/sUoA4rpqQZrT/E2iPGZZSWoTm65O5O2uAZP0zVKJ39YGFUUCF0cY4BzVFqAhe
         WPXm874QBQWmo3cdhdDKsCGR82nr5KP2cdhiQua2Anh3i69+wZtmDd6NZL4SVc8QQx
         1isV2JGko5TD2eROPPo7AhVJYzzlnGx5gRLsLLyA=
Date:   Fri, 2 Oct 2020 13:39:08 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH v3 00/15] nfsd_dispatch() clean up
Message-ID: <20201002173908.GA31151@fieldses.org>
References: <160159301676.79253.16488984581431975601.stgit@klimt.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <160159301676.79253.16488984581431975601.stgit@klimt.1015granger.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I'm seeing a pynfs4.0 GATT9 regression.  That's a test that attempts a
compound with 90 GETATTR ops each a request for all mandatory
attributes.  The test expects OK or RESOURCE but looks like its getting
a corrupted response?  (I haven't looked at the wire traffic yet.)  I
think it's one of the final patches changing how errors are returned.

--b.

On Thu, Oct 01, 2020 at 06:58:46PM -0400, Chuck Lever wrote:
> Hi Bruce-
> 
> Here's the latest version of the nfsd_dispatch clean up series,
> building on the "non-controversial" patches I posted last week.
> 
> The purpose of this series is three-fold:
> 
> o Prepare to add NFS procedure tracepoints
> o Prepare to eventually deprecate NFSv2
> o Minor optimizations of the dispatcher hot path
> 
> 
> Changes since v2:
> - Fixed crasher caused by invoking NFSv2 ROOT or WRITECACHE
> - Hoisted encoding of NFS status code into XDR Reply encoders
> - Numerous bug fixes, clean ups, and patch re-ordering
> 
> Changes since v1:
> - Pulled in latest version of rq_lease_breaker cleanup
> - Added patches to make NFSv2 error encoding similar to NFSv3
> - Clarified nfsd_dispatch's new documenting comment
> - Renamed a variable
> 
> ---
> 
> Chuck Lever (14):
>       NFSD: Add missing NFSv2 .pc_func methods
>       lockd: Replace PROC() macro with open code
>       NFSACL: Replace PROC() macro with open code
>       NFSD: Encoder and decoder functions are always present
>       NFSD: Clean up switch statement in nfsd_dispatch()
>       NFSD: Clean up stale comments in nfsd_dispatch()
>       NFSD: Clean up nfsd_dispatch() variables
>       NFSD: Refactor nfsd_dispatch() error paths
>       NFSD: Remove vestigial typedefs
>       NFSD: Fix .pc_release method for NFSv2
>       NFSD: Call NFSv2 encoders on error returns
>       NFSD: Remove the RETURN_STATUS() macro
>       NFSD: Map nfserr_wrongsec outside of nfsd_dispatch
>       NFSD: Hoist status code encoding into XDR encoder functions
> 
> J. Bruce Fields (1):
>       nfsd: rq_lease_breaker cleanup
> 
> 
>  fs/lockd/svc4proc.c         | 248 ++++++++++++++++++++++++-------
>  fs/lockd/svcproc.c          | 250 ++++++++++++++++++++++++-------
>  fs/nfsd/export.c            |   2 +-
>  fs/nfsd/nfs2acl.c           | 160 +++++++++++++-------
>  fs/nfsd/nfs3acl.c           |  88 ++++++-----
>  fs/nfsd/nfs3proc.c          | 238 +++++++++++++++---------------
>  fs/nfsd/nfs3xdr.c           |  25 +++-
>  fs/nfsd/nfs4proc.c          |   6 +-
>  fs/nfsd/nfs4xdr.c           |  11 +-
>  fs/nfsd/nfsproc.c           | 283 ++++++++++++++++++++----------------
>  fs/nfsd/nfssvc.c            | 121 ++++++++-------
>  fs/nfsd/nfsxdr.c            |  52 ++++++-
>  fs/nfsd/xdr.h               |  16 +-
>  fs/nfsd/xdr3.h              |   1 +
>  fs/nfsd/xdr4.h              |   1 +
>  include/uapi/linux/nfsacl.h |   2 +
>  16 files changed, 984 insertions(+), 520 deletions(-)
> 
> --
> Chuck Lever
