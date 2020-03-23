Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABB1418F840
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Mar 2020 16:09:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725900AbgCWPJV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Mar 2020 11:09:21 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:37634 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725861AbgCWPJV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Mar 2020 11:09:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584976160;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vR/mNKJSb3FVAxCBiiSAjKSmF5hK3GAkovfAYmkEdh4=;
        b=fPj376rV0ehS1y8ugmaziXnKYObVh1+IoSH6MnzHnS8CYx3+7F/8rRKf+Pj/6jq+/aSheR
        AZ23FRsOLNqj70KIn3sgMCULnjbrY0qRWeF4/T6RYWUy7BzGyGhB6Btst9Nc2WV3KilhXb
        oabdTivJ8MMaV5rNcVxIMnrspH+86BQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-345-Zw8fKO6LMvmqE0b_h1nNFw-1; Mon, 23 Mar 2020 11:09:14 -0400
X-MC-Unique: Zw8fKO6LMvmqE0b_h1nNFw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AD23518B640A;
        Mon, 23 Mar 2020 15:09:12 +0000 (UTC)
Received: from pick.fieldses.org (ovpn-120-198.rdu2.redhat.com [10.10.120.198])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7C1DE5DA7C;
        Mon, 23 Mar 2020 15:09:12 +0000 (UTC)
Received: by pick.fieldses.org (Postfix, from userid 2815)
        id 307401201F8; Mon, 23 Mar 2020 11:09:11 -0400 (EDT)
Date:   Mon, 23 Mar 2020 11:09:11 -0400
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Vasily Averin <vvs@virtuozzo.com>,
        Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfsd: memory corruption in nfsd4_lock()
Message-ID: <20200323150911.GA64741@pick.fieldses.org>
References: <db0980d0-8c99-940a-1748-04e679a366d1@virtuozzo.com>
 <5B820E18-763C-4562-9F50-56A0F1894406@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5B820E18-763C-4562-9F50-56A0F1894406@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Mar 23, 2020 at 09:50:34AM -0400, Chuck Lever wrote:
> 
> 
> > On Mar 23, 2020, at 3:55 AM, Vasily Averin <vvs@virtuozzo.com> wrote:
> > 
> > New struct nfsd4_blocked_lock allocated in find_or_allocate_block()
> > does not initialised nbl_list and nbl_lru.
> > If conflock allocation fails rollback can call list_del_init()
> > access uninitialized fields and corrupt memory.
> > 
> > Fixes: 76d348fadff5 ("nfsd: have nfsd4_lock use blocking locks for v4.1+ lock")
> > Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
> > ---
> > fs/nfsd/nfs4state.c | 32 +++++++++++++++-----------------
> > 1 file changed, 15 insertions(+), 17 deletions(-)
> > 
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index 369e574c5092..176ef8d24fae 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -6524,6 +6524,13 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
> > 		goto out;
> > 	}
> > 
> > +	conflock = locks_alloc_lock();
> > +	if (!conflock) {
> > +		dprintk("NFSD: %s: unable to allocate lock!\n", __func__);
> > +		status = nfserr_jukebox;
> > +		goto out;
> > +	}
> 
> Nit: What do people think about removing this dprintk() as part of the fix?

I don't think we want a dprintk every place we kmalloc.  All for
removing them.--b.

