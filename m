Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F142C278BAE
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Sep 2020 17:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729162AbgIYPAj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 25 Sep 2020 11:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbgIYPAj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 25 Sep 2020 11:00:39 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17021C0613CE
        for <linux-nfs@vger.kernel.org>; Fri, 25 Sep 2020 08:00:39 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 4E4CC448D; Fri, 25 Sep 2020 11:00:38 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 4E4CC448D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1601046038;
        bh=wvv+T1eI7U/Q2epi4zn34ng68nDztInWhLt2u+EGEnI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GsCACbhxwwjdvjlOQrL9wFavacgjRNI6OMbLUto+F9oIEo+lsKdfsFwLBQC1AuQ38
         zC/h38uALM3G1RQlxPqJiSWOU/cojMBQUACoc1vryRN5reCEe6KID/R7Qrv72PrnOn
         zwEIPqHQv8xA3PVQDmOZGt5rQVjwDbWIddCjMO2o=
Date:   Fri, 25 Sep 2020 11:00:38 -0400
From:   Bruce Fields <bfields@fieldses.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Bill Baker <Bill.Baker@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2 00/27] NFSD operation monitoring tracepoints
Message-ID: <20200925150038.GF1096@fieldses.org>
References: <160071167664.1468.1365570508917640511.stgit@klimt.1015granger.net>
 <20200924213617.GA12407@fieldses.org>
 <945A7DE6-909D-4177-852F-F80EF7DFE6B3@oracle.com>
 <20200925143218.GD1096@fieldses.org>
 <23DF63F3-44AC-4DDE-AAB9-E178F4B68103@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23DF63F3-44AC-4DDE-AAB9-E178F4B68103@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Sep 25, 2020 at 10:36:42AM -0400, Chuck Lever wrote:
> 
> 
> > On Sep 25, 2020, at 10:32 AM, Bruce Fields <bfields@fieldses.org> wrote:
> > 
> > On Fri, Sep 25, 2020 at 09:59:51AM -0400, Chuck Lever wrote:
> >> Thanks Bruce, for your time, attention, and comments!
> >> 
> >>> On Sep 24, 2020, at 5:36 PM, J. Bruce Fields <bfields@fieldses.org> wrote:
> >>> 
> >>> On Mon, Sep 21, 2020 at 02:10:49PM -0400, Chuck Lever wrote:
> >>>> As I've been working on various server bugs, I've been adding
> >>>> tracepoints that record NFS operation arguments. Here's an updated
> >>>> snapshot of this work for your review and comment.
> >>>> 
> >>>> The idea here is to provide a degree of NFS traffic observability
> >>>> without needing network capture. Tracepoints are generally lighter-
> >>>> weight than full network capture, allowing effective capture-time
> >>>> data reduction:
> >>> 
> >>> I do wonder when tracepoints seem to duplicate information you could get
> >>> from network traces, so thanks for taking the time to explain this.  It
> >>> makes sense to me.
> >>> 
> >>> The patches look fine.  The only one I'm I'm on the fence about is the
> >>> last with the split up of the dispatch functions.  I'll ask some
> >>> questions there....
> >> 
> >> To be clear to everyone, this series is still "preview". I expect
> >> more churn in these patches, thus I don't consider the series ready
> >> to be merged by any stretch.
> > 
> > OK!
> > 
> > One thing I was wondering about: how would you limit tracing to a single
> > client, say if you wanted to see all DELEGRETURNs from a single client?
> > I guess you'd probably turn on a tracepoint in the receive code, look
> > for your client's IP address, then mask the task id to match later
> > nfs-level tracepoints.  Is there enough information in those tracepoints
> > (including network namespace) to uniquely identify a client?
> 
> Client IP address information is in the RPC layer trace data. The
> DELEGRETURN trace record includes client ID. So maybe not as
> straightforward as it could be.

I guess what I meant was "limit tracing to a single network endpoint",
not exactly limt to a single NFSv4 client....  So, we can do that as
long as all the relevant information is in rpc-layer tracepoints, and as
long as task id is a reliable way to match up trace points.

Is the network namespace in there anywhere?  It looks like there'd be no
way to distinguish clients in different namespaces if they had the same
address.

--b.

> 
> 
> > --b.
> > 
> >>>> - One or a handful of these can be enabled at a time
> >>>> - Each tracepoint records much less data per operation than capture
> >>>> - Extra capture-time filtering can reduce data amount even further
> >>>> - Some of these operations are infrequent enough that their
> >>>> tracepoint could be enabled persistently without a significant
> >>>> performance impact (for example, for security auditing)
> >>>> 
> >>>> The topic branch has been updated as well:
> >>>> 
> >>>> git://git.linux-nfs.org/projects/cel/cel-2.6.git nfsd-more-tracepoints
> >>>> 
> >>>> 
> >>>> Changes since RFC:
> >>>> * s/SPDK/SPDX and corrected the spelling of Christoph's surname
> >>>> * Fixed a build error noticed by <lkp@intel.com>
> >>>> * Introduced generic headers for VFS and NFS protocol display macros
> >>>> * nfsd4_compoundstatus now displays NFS4ERR codes symbolically
> >>>> * The svc_process tracepoint now displays the RPC procedure symbolically
> >>>> * NFSD dispatcher now displays procedure names and status codes symbolically
> >>>> * fh_verify tracepoint tentatively included; it adds a lot of noise, but perhaps not much value
> >>>> * Cleaned up the remaining PROC() macros in the server code
> >>>> * Removed trace_printk's that were introduced during the RFC series
> >>>> * Removed redundant nfsd4_close tracepoint
> >>>> 
> >>>> ---
> >>>> 
> >>>> Chuck Lever (27):
> >>>>     NFS: Move generic FS show macros to global header
> >>>>     NFS: Move NFS protocol display macros to global header
> >>>>     NFSD: Add SPDX header for fs/nfsd/trace.c
> >>>>     SUNRPC: Move the svc_xdr_recvfrom() tracepoint
> >>>>     SUNRPC: Add svc_xdr_authenticate tracepoint
> >>>>     lockd: Replace PROC() macro with open code
> >>>>     NFSACL: Replace PROC() macro with open code
> >>>>     SUNRPC: Make trace_svc_process() display the RPC procedure symbolically
> >>>>     NFSD: Clean up the show_nf_may macro
> >>>>     NFSD: Remove extra "0x" in tracepoint format specifier
> >>>>     NFSD: Constify @fh argument of knfsd_fh_hash()
> >>>>     NFSD: Add tracepoint in nfsd_setattr()
> >>>>     NFSD: Add tracepoint for nfsd_access()
> >>>>     NFSD: nfsd_compound_status tracepoint should record XID
> >>>>     NFSD: Add client ID lifetime tracepoints
> >>>>     NFSD: Add tracepoints to report NFSv4 session state
> >>>>     NFSD: Add a tracepoint to report the current filehandle
> >>>>     NFSD: Add GETATTR tracepoint
> >>>>     NFSD: Add tracepoint in nfsd4_stateid_preprocess()
> >>>>     NFSD: Add tracepoint to report arguments to NFSv4 OPEN
> >>>>     NFSD: Add a tracepoint for DELEGRETURN
> >>>>     NFSD: Add a lookup tracepoint
> >>>>     NFSD: Add lock and locku tracepoints
> >>>>     NFSD: Add tracepoints to record the result of TEST_STATEID and FREE_STATEID
> >>>>     NFSD: Rename nfsd_ tracepoints to nfsd4_
> >>>>     NFSD: Add tracepoints in the NFS dispatcher
> >>>>     NFSD: Replace dprintk callsites in fs/nfsd/nfsfh.c
> >>>> 
> >>>> 
> >>>> fs/lockd/svc4proc.c           | 263 +++++++++--
> >>>> fs/lockd/svcproc.c            | 265 +++++++++--
> >>>> fs/nfs/callback_xdr.c         |   2 +
> >>>> fs/nfs/nfs4trace.h            | 387 ++--------------
> >>>> fs/nfs/nfstrace.h             | 113 +----
> >>>> fs/nfs/pnfs.h                 |   4 -
> >>>> fs/nfsd/nfs2acl.c             |  79 +++-
> >>>> fs/nfsd/nfs3acl.c             |  54 ++-
> >>>> fs/nfsd/nfs3proc.c            |  25 +
> >>>> fs/nfsd/nfs4callback.c        |  28 +-
> >>>> fs/nfsd/nfs4layouts.c         |  16 +-
> >>>> fs/nfsd/nfs4proc.c            |  43 +-
> >>>> fs/nfsd/nfs4state.c           | 100 ++--
> >>>> fs/nfsd/nfsd.h                |   1 +
> >>>> fs/nfsd/nfsfh.c               |  36 +-
> >>>> fs/nfsd/nfsfh.h               |   7 +-
> >>>> fs/nfsd/nfsproc.c             |  21 +
> >>>> fs/nfsd/nfssvc.c              | 198 +++++---
> >>>> fs/nfsd/trace.c               |   1 +
> >>>> fs/nfsd/trace.h               | 844 ++++++++++++++++++++++++++++++----
> >>>> fs/nfsd/vfs.c                 |  18 +-
> >>>> fs/nfsd/xdr4.h                |   3 +-
> >>>> include/linux/nfs4.h          |   4 +
> >>>> include/linux/sunrpc/svc.h    |   1 +
> >>>> include/trace/events/fs.h     |  30 ++
> >>>> include/trace/events/nfs.h    | 511 ++++++++++++++++++++
> >>>> include/trace/events/sunrpc.h |  33 +-
> >>>> include/uapi/linux/nfsacl.h   |   2 +
> >>>> net/sunrpc/svc_xprt.c         |   4 +-
> >>>> net/sunrpc/svcauth.c          |   5 +-
> >>>> 30 files changed, 2187 insertions(+), 911 deletions(-)
> >>>> create mode 100644 include/trace/events/nfs.h
> >>>> 
> >>>> --
> >>>> Chuck Lever
> >> 
> >> --
> >> Chuck Lever
> 
> --
> Chuck Lever
> 
> 
