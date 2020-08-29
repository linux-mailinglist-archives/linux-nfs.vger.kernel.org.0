Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDA10256899
	for <lists+linux-nfs@lfdr.de>; Sat, 29 Aug 2020 17:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728239AbgH2PUg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 29 Aug 2020 11:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728235AbgH2PUe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 29 Aug 2020 11:20:34 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE950C061236
        for <linux-nfs@vger.kernel.org>; Sat, 29 Aug 2020 08:20:34 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id C2A876EF4; Sat, 29 Aug 2020 11:20:25 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org C2A876EF4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1598714425;
        bh=x+ePd/5KcBesBcqVuSJgZc95bE8NZ2WGILq9KSeDjxE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Uugjg3tB1IXJqAhE3wEUQ5aUnnt3HpZSF9HNmO2RFYS5EVkbgcOYNrf4o/blnewTS
         XBOft45oa3JQzU4PssRegrSH1UcEkaYZqw81bvoJtwb7WGJPXghH3Td58u5KI62B57
         yEjXhLrDGTF/b/uK11wJkrCdj20Ju/wEccwx0OgE=
Date:   Sat, 29 Aug 2020 11:20:25 -0400
From:   Bruce Fields <bfields@fieldses.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Hou Tao <houtao1@huawei.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2] nfsd: rename delegation related tracepoints to make
 them less confusing
Message-ID: <20200829152025.GA20499@fieldses.org>
References: <6F61F417-95DA-4CD7-A81A-FA8C6299CF40@oracle.com>
 <20200828070255.141460-1-houtao1@huawei.com>
 <D32F1F35-2725-4809-9D10-2ED6EE2A2613@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D32F1F35-2725-4809-9D10-2ED6EE2A2613@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Aug 28, 2020 at 09:21:55AM -0400, Chuck Lever wrote:
> 
> 
> > On Aug 28, 2020, at 3:02 AM, Hou Tao <houtao1@huawei.com> wrote:
> > 
> > Now when a read delegation is given, two delegation related traces
> > will be printed:
> > 
> >    nfsd_deleg_open: client 5f45b854:e6058001 stateid 00000030:00000001
> >    nfsd_deleg_none: client 5f45b854:e6058001 stateid 0000002f:00000001
> > 
> > Although the intention is to let developers know two stateid are
> > returned, the traces are confusing about whether or not a read delegation
> > is handled out. So renaming trace_nfsd_deleg_none() to trace_nfsd_open()
> > and trace_nfsd_deleg_open() to trace_nfsd_deleg_read() to make
> > the intension clearer.
> > 
> > The patched traces will be:
> > 
> >    nfsd_deleg_read: client 5f48a967:b55b21cd stateid 00000003:00000001
> >    nfsd_open: client 5f48a967:b55b21cd stateid 00000002:00000001
> > 
> > Suggested-by: Chuck Lever <chuck.lever@oracle.com>
> > Signed-off-by: Hou Tao <houtao1@huawei.com>
> 
> LGTM. I assume Bruce is taking this for v5.10.

Applying for 5.10, thanks.--b.

> 
> 
> > ---
> > v1: https://marc.info/?l=linux-nfs&m=159851134513236&w=2
> > 
> > fs/nfsd/nfs4state.c | 4 ++--
> > fs/nfsd/trace.h     | 4 ++--
> > 2 files changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index c09a2a4281ec9..0525acfe31314 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -5126,7 +5126,7 @@ nfs4_open_delegation(struct svc_fh *fh, struct nfsd4_open *open,
> > 
> > 	memcpy(&open->op_delegate_stateid, &dp->dl_stid.sc_stateid, sizeof(dp->dl_stid.sc_stateid));
> > 
> > -	trace_nfsd_deleg_open(&dp->dl_stid.sc_stateid);
> > +	trace_nfsd_deleg_read(&dp->dl_stid.sc_stateid);
> > 	open->op_delegate_type = NFS4_OPEN_DELEGATE_READ;
> > 	nfs4_put_stid(&dp->dl_stid);
> > 	return;
> > @@ -5243,7 +5243,7 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
> > 	nfs4_open_delegation(current_fh, open, stp);
> > nodeleg:
> > 	status = nfs_ok;
> > -	trace_nfsd_deleg_none(&stp->st_stid.sc_stateid);
> > +	trace_nfsd_open(&stp->st_stid.sc_stateid);
> > out:
> > 	/* 4.1 client trying to upgrade/downgrade delegation? */
> > 	if (open->op_delegate_type == NFS4_OPEN_DELEGATE_NONE && dp &&
> > diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> > index 1861db1bdc670..99bf07800cd09 100644
> > --- a/fs/nfsd/trace.h
> > +++ b/fs/nfsd/trace.h
> > @@ -289,8 +289,8 @@ DEFINE_STATEID_EVENT(layout_recall_done);
> > DEFINE_STATEID_EVENT(layout_recall_fail);
> > DEFINE_STATEID_EVENT(layout_recall_release);
> > 
> > -DEFINE_STATEID_EVENT(deleg_open);
> > -DEFINE_STATEID_EVENT(deleg_none);
> > +DEFINE_STATEID_EVENT(open);
> > +DEFINE_STATEID_EVENT(deleg_read);
> > DEFINE_STATEID_EVENT(deleg_break);
> > DEFINE_STATEID_EVENT(deleg_recall);
> > 
> > -- 
> > 2.25.0.4.g0ad7144999
> > 
> 
> --
> Chuck Lever
> 
> 
