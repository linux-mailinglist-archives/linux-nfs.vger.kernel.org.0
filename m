Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFC55332F42
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Mar 2021 20:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbhCITpx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 9 Mar 2021 14:45:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55080 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231253AbhCITp1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 9 Mar 2021 14:45:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615319127;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2ISEKAhxoHEqz9Foo7+T5MpVFYer3dlOYkmfL7jYpNA=;
        b=Pwgp1PmvHifP92XmA3SRmOdh10NkwDYlp+I/tFMeKu+4jMdU+Mvd7QLrVAjr//AisOuJtC
        1NOJ1Y65HGp8A6uIuqF6F8S8JyGMqMpcXAFjbzYgRncpsBsiCkZGU+xh7H0FvlBYWCNOSC
        MzgjKPeVdRMD374l7Hpr3k+xS66FSgQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-t_f8ZQ2XPdS9uTghbSKthg-1; Tue, 09 Mar 2021 14:45:24 -0500
X-MC-Unique: t_f8ZQ2XPdS9uTghbSKthg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B08AE800C78;
        Tue,  9 Mar 2021 19:45:23 +0000 (UTC)
Received: from aion.usersys.redhat.com (ovpn-112-89.rdu2.redhat.com [10.10.112.89])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0302A6062F;
        Tue,  9 Mar 2021 19:45:20 +0000 (UTC)
Received: by aion.usersys.redhat.com (Postfix, from userid 1000)
        id 13C731A003C; Tue,  9 Mar 2021 14:45:19 -0500 (EST)
Date:   Tue, 9 Mar 2021 14:45:19 -0500
From:   Scott Mayhew <smayhew@redhat.com>
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        chuck.lever@oracle.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/1] NFSD: fix error handling in callbacks
Message-ID: <20210309194519.GF2597609@aion.usersys.redhat.com>
References: <20210309144127.57833-1-olga.kornievskaia@gmail.com>
 <YEeWK+gs4c8O7k0u@pick.fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YEeWK+gs4c8O7k0u@pick.fieldses.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 09 Mar 2021, J. Bruce Fields wrote:

> On Tue, Mar 09, 2021 at 09:41:27AM -0500, Olga Kornievskaia wrote:
> > From: Olga Kornievskaia <kolga@netapp.com>
> > 
> > When the server tries to do a callback and a client fails it due to
> > authentication problems, we need the server to set callback down
> > flag in RENEW so that client can recover.
> 
> I was looking at this.  It looks to me like this should really be just:
> 
> 	case 1:
> 		if (task->tk_status)
> 			nfsd4_mark_cb_down(clp, task->tk_status);
> 
> If tk_status showed an error, and the ->done method doesn't return 0 to
> tell us it something worth retrying, then the callback failed
> permanently, so we should mark the callback path down, regardless of the
> exact error.

That switch was added because the server was erroneously setting
SEQ4_STATUS_CB_PATH_DOWN in the event that a client returned an
NFS-level error for a CB_RECALL that the client had already done a
FREE_STATEID for.  Removing the switch will cause the server to go back
to that behaviour, won't it?

-Scott
> 
> --b.
> 
> > 
> > Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> > ---
> >  fs/nfsd/nfs4callback.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
> > index 052be5bf9ef5..7325592b456e 100644
> > --- a/fs/nfsd/nfs4callback.c
> > +++ b/fs/nfsd/nfs4callback.c
> > @@ -1189,6 +1189,7 @@ static void nfsd4_cb_done(struct rpc_task *task, void *calldata)
> >  		switch (task->tk_status) {
> >  		case -EIO:
> >  		case -ETIMEDOUT:
> > +		case -EACCES:
> >  			nfsd4_mark_cb_down(clp, task->tk_status);
> >  		}
> >  		break;
> > -- 
> > 2.27.0
> > 
> 

