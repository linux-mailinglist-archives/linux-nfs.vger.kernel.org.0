Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34EB12EF566
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Jan 2021 17:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbhAHQCc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 8 Jan 2021 11:02:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727748AbhAHQCc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 8 Jan 2021 11:02:32 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB3AC061380
        for <linux-nfs@vger.kernel.org>; Fri,  8 Jan 2021 08:01:46 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id E27BD3C33; Fri,  8 Jan 2021 11:01:45 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org E27BD3C33
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1610121705;
        bh=8FBf/QqTX9dKgA3jh+HDcK+GSH2D/qxiK9DGnikHvZ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NauzL8UpMU1hsIf9zAG7t0Sr61PoZ17AVanwtJB282CNdEuxlg2fDvh3lGIaNRcQ6
         bIgTSgbTDDmY6WDsGB0NWbdRzNp8RSthU4KB4niZLuMnuNB5EC2IEaxlv5CTTxxz7i
         +dL5bcn1LLbLcGwOebhSj54uDGLL5NnWnDtIMvvw=
Date:   Fri, 8 Jan 2021 11:01:45 -0500
From:   Bruce Fields <bfields@fieldses.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v1 00/42] Update NFSD XDR functions
Message-ID: <20210108160145.GD4183@fieldses.org>
References: <160986050640.5532.16498408936966394862.stgit@klimt.1015granger.net>
 <20210108031800.GA13604@fieldses.org>
 <FDB7EF17-AD34-4CB5-824D-0DB2F5FA6F6A@oracle.com>
 <20210108155209.GC4183@fieldses.org>
 <FE877FEA-2A2E-4558-9B95-64116804E924@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FE877FEA-2A2E-4558-9B95-64116804E924@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Jan 08, 2021 at 10:56:14AM -0500, Chuck Lever wrote:
> 
> 
> > On Jan 8, 2021, at 10:52 AM, Bruce Fields <bfields@fieldses.org> wrote:
> > 
> > On Fri, Jan 08, 2021 at 10:50:09AM -0500, Chuck Lever wrote:
> >> 
> >> 
> >>> On Jan 7, 2021, at 10:18 PM, bfields@fieldses.org wrote:
> >>> 
> >>> I haven't had a chance to review these, but thought I should mention I'm
> >>> seeing a failure in xfstests generic/465 that I don't *think* is
> >>> reproduceable before this series.  Unfortunately it's intermittent,
> >>> though, so I'm not certain yet.
> >> 
> >> Confirming: does that failure occur with NFSv3?
> > 
> > I've only tried it over 4.2.
> 
> Interesting. This series shouldn't have any impact on NFSv4
> direct I/O functionality:
> 
> fs/nfs_common/nfsacl.c          |  52 +++
> fs/nfsd/nfs2acl.c               |  62 ++--
> fs/nfsd/nfs3acl.c               |  42 ++-
> fs/nfsd/nfs3proc.c              |  71 +++--
> fs/nfsd/nfs3xdr.c               | 538 ++++++++++++++++++--------------
> fs/nfsd/nfsproc.c               |  74 +++--
> fs/nfsd/nfssvc.c                |  34 --
> fs/nfsd/nfsxdr.c                | 350 ++++++++++-----------
> fs/nfsd/xdr.h                   |  12 +-
> fs/nfsd/xdr3.h                  |  20 +-
> include/linux/nfsacl.h          |   3 +
> include/linux/sunrpc/msg_prot.h |   3 -
> include/linux/sunrpc/xdr.h      |  13 +-
> include/trace/events/sunrpc.h   |  15 +-
> include/uapi/linux/nfs3.h       |   6 +
> 15 files changed, 680 insertions(+), 615 deletions(-)
> 
> Can you try to nail it down a little?

I took a look back through my testing history and realized I've seen it
fail previously.  So it was just coincidence that I saw it fail a couple
times after applying the series but not before yesterday.  Sorry for the
noise!

--b.
