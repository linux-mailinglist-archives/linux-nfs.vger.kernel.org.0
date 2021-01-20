Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C50F2FDD56
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Jan 2021 00:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729047AbhATXpB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 20 Jan 2021 18:45:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48034 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725946AbhATV1h (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 20 Jan 2021 16:27:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611177962;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z7LIpeSREjryX81k+mFc82KLOqtfCr0cOSqkeeKtn88=;
        b=FnUjki+unQsxyN3s4japgVrFBs/o1LFOSZrJeMBYQyknX6b1UjcwiqqEisnypS+vDvmwK9
        0v4Im8j4upG7OPfS025gaDxRrebGZugnnBrFOQMcEWeR1Hs8bpRaDD2t4SlnLKDkgP8Tax
        f8m6YYOz2FYyVbziHCjEid2bdN+WuFE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-532-tBft08BtMrW7cIeildSC0g-1; Wed, 20 Jan 2021 16:26:00 -0500
X-MC-Unique: tBft08BtMrW7cIeildSC0g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 42C9110054FF;
        Wed, 20 Jan 2021 21:25:59 +0000 (UTC)
Received: from pick.fieldses.org (ovpn-113-179.phx2.redhat.com [10.3.113.179])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 287D81992D;
        Wed, 20 Jan 2021 21:25:59 +0000 (UTC)
Received: by pick.fieldses.org (Postfix, from userid 2815)
        id A9A5B12054F; Wed, 20 Jan 2021 16:25:57 -0500 (EST)
Date:   Wed, 20 Jan 2021 16:25:57 -0500
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 2/8] nfsd: simplify process_lock
Message-ID: <20210120212557.GA167212@pick.fieldses.org>
References: <1611095729-31104-1-git-send-email-bfields@redhat.com>
 <1611095729-31104-3-git-send-email-bfields@redhat.com>
 <B0EA0C57-443B-4FB5-8E21-4CBA082EF8A6@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B0EA0C57-443B-4FB5-8E21-4CBA082EF8A6@oracle.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Jan 20, 2021 at 09:01:53PM +0000, Chuck Lever wrote:
> 
> 
> > On Jan 19, 2021, at 5:35 PM, J. Bruce Fields <bfields@redhat.com> wrote:
> > 
> > From: "J. Bruce Fields" <bfields@redhat.com>
> > 
> > Similarly, this STALE_CLIENTID check is already handled inside
> > preprocess_confirmed_seqid_op().
> 
> I can't confirm this claim. Where is clid->cl_boot checked?


nfs4_preprocess_confirmed_seqid_op()->
	nfs4_preprocess_seqid_op()->
		nfsd4_lookup_stateid()->
			set_client()->
				STALE_CLIENTID()

> Did you mean nfs4_preprocess_confirmed_seqid_op() here?

Yeah.  But maybe it'd be better just to include that whole call stack in
the changelog.

--b.

> 
> 
> > (This may cause it to return a different error in some cases where
> > there are multiple things wrong; pynfs test SEQ10 regressed on this
> > commit because of that, but I think that's the test's fault, and I've
> > fixed it separately.)
> > 
> > Signed-off-by: J. Bruce Fields <bfields@redhat.com>
> > ---
> > fs/nfsd/nfs4state.c | 4 ----
> > 1 file changed, 4 deletions(-)
> > 
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index f9f89229dba6..7ea63d7cec4d 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -6697,10 +6697,6 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
> > 				&cstate->session->se_client->cl_clientid,
> > 				sizeof(clientid_t));
> > 
> > -		status = nfserr_stale_clientid;
> > -		if (STALE_CLIENTID(&lock->lk_new_clientid, nn))
> > -			goto out;
> > -
> > 		/* validate and update open stateid and open seqid */
> > 		status = nfs4_preprocess_confirmed_seqid_op(cstate,
> > 				        lock->lk_new_open_seqid,
> > -- 
> > 2.29.2
> > 
> 
> --
> Chuck Lever
> 
> 
> 

