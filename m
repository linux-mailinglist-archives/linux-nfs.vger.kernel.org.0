Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C90A894EA9
	for <lists+linux-nfs@lfdr.de>; Mon, 19 Aug 2019 22:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbfHSUCf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 19 Aug 2019 16:02:35 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:46811 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727970AbfHSUCf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 19 Aug 2019 16:02:35 -0400
Received: by mail-io1-f66.google.com with SMTP id x4so7022872iog.13
        for <linux-nfs@vger.kernel.org>; Mon, 19 Aug 2019 13:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=n1bV9dDSjRXeoM5JY3FU3IH0d0YLs3dNA9GIbt0KAcc=;
        b=cOq0k5TOwZYeDgMq+//qWZDuIBYt0CtBSYjgxhzkKIQBQw5bF3/7Lqo95aNZXp7VDG
         g5pR9kIZWQLnYrxpRpVB91OpqN/GVQYU848UBTapmYiYB0rz0NG/8afhIDBoAYaRTboC
         q4/zSY+lx1/oFB5K9uMarzDvOEkCt1UQCBDJ9s/dTAUaVUsiuBKK+pg13IWr0Ji+GpRc
         oPEeW8ayi7FyjRGu9g5S633HXu40KqdzuhbyVBO+3HDx+3jacYNN66aCJgCgIMywGpWm
         qSnWP1wUqSXKzWYRQl0q1/2c6qY6x0aWDm3VXmW1GY/T5DuENYSQGDW0/DsejjJL6+xo
         lJ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:message-id:subject:from:to:cc:date
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=n1bV9dDSjRXeoM5JY3FU3IH0d0YLs3dNA9GIbt0KAcc=;
        b=EdUxw9DtKQ4l44tBPv/aREdhi6ldPzb81D5C/RMGTsDO0ubDxlQTru3U3vJIkmnNHA
         QIiHxXPElxryVk9CScPOxA6ljGYa2VWkw5pKmsX6e5fFeJi2KGoMTzVVH9b/BplpVK+j
         nAxZe5U1RgPqrpdVB8dNqOpOJRWevkaXrczHma4ijBPVxwPgWCO7xWGnuIEv46ucIt7c
         CvkFZRohu+A2Qmsnz+d3VhQNRAwbGc5FVC9Us8943F9DtGpIxXGEqW5LOb+vGsTEfMVi
         eKK+yGyul8ZgUztuChaP7O8kaejsztGpIG9iOTZcbPJ5mne55Lso9Ii83/qFly7zPy65
         anvA==
X-Gm-Message-State: APjAAAXLdEJcn5FI1gjVjOBO+ohko/qB+tibez8GswBPycyA19UEAVP5
        ma9zcrBWVCSghgRHDKpwSIg=
X-Google-Smtp-Source: APXvYqxee0Sg3O+RjjTkHwSSuY1zwYv2BNwRqG7kfvU6tV2SUmrfGQ/AcZahGTfHPSf4JQR3Ul3+zg==
X-Received: by 2002:a02:8663:: with SMTP id e90mr22508347jai.98.1566244954269;
        Mon, 19 Aug 2019 13:02:34 -0700 (PDT)
Received: from gouda.nowheycreamery.com (d28-23-121-75.dim.wideopenwest.com. [23.28.75.121])
        by smtp.googlemail.com with ESMTPSA id t2sm26019801iod.81.2019.08.19.13.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 13:02:33 -0700 (PDT)
Message-ID: <cb9b5115fc445a5d775b6cdb6f58917e7c80b154.camel@gmail.com>
Subject: Re: [PATCH 4/6] NFS: Have nfs41_proc_reclaim_complete() call
 nfs4_call_sync_custom()
From:   Anna Schumaker <schumaker.anna@gmail.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Cc:     NeilBrown <neilb@suse.com>
Date:   Mon, 19 Aug 2019 16:02:32 -0400
In-Reply-To: <8bd34fcbd352a2d5c4a8c757919f044bfaa76c60.camel@hammerspace.com>
References: <20190819192900.19312-1-Anna.Schumaker@Netapp.com>
         <20190819192900.19312-5-Anna.Schumaker@Netapp.com>
         <8bd34fcbd352a2d5c4a8c757919f044bfaa76c60.camel@hammerspace.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

See 5a0c257f8e0f4c4b3c33dff545317c21a921303e (NFS: send state
management on a single connection)

My understanding is that it forces all the state management calls into
a single connection during session startup, but before the extra
network connections are bound to the session.

Anna

On Mon, 2019-08-19 at 19:56 +0000, Trond Myklebust wrote:
> On Mon, 2019-08-19 at 15:28 -0400, schumaker.anna@gmail.com wrote:
> > From: Anna Schumaker <Anna.Schumaker@Netapp.com>
> > 
> > An async call followed by an rpc_wait_for_completion() is basically
> > the
> > same as a synchronous call, so we can use nfs4_call_sync_custom()
> > to
> > keep our custom callback ops and the RPC_TASK_NO_ROUND_ROBIN flag.
> > 
> > Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
> > ---
> >  fs/nfs/nfs4proc.c | 13 ++-----------
> >  1 file changed, 2 insertions(+), 11 deletions(-)
> > 
> > diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> > index de2b3fd806ef..1b7863ec12d3 100644
> > --- a/fs/nfs/nfs4proc.c
> > +++ b/fs/nfs/nfs4proc.c
> > @@ -8857,7 +8857,6 @@ static int nfs41_proc_reclaim_complete(struct
> > nfs_client *clp,
> >  		const struct cred *cred)
> >  {
> >  	struct nfs4_reclaim_complete_data *calldata;
> > -	struct rpc_task *task;
> >  	struct rpc_message msg = {
> >  		.rpc_proc =
> > &nfs4_procedures[NFSPROC4_CLNT_RECLAIM_COMPLETE],
> >  		.rpc_cred = cred,
> > @@ -8866,7 +8865,7 @@ static int nfs41_proc_reclaim_complete(struct
> > nfs_client *clp,
> >  		.rpc_client = clp->cl_rpcclient,
> >  		.rpc_message = &msg,
> >  		.callback_ops = &nfs4_reclaim_complete_call_ops,
> > -		.flags = RPC_TASK_ASYNC | RPC_TASK_NO_ROUND_ROBIN,
> > +		.flags = RPC_TASK_NO_ROUND_ROBIN,
> >  	};
> >  	int status = -ENOMEM;
> >  
> > @@ -8881,15 +8880,7 @@ static int
> > nfs41_proc_reclaim_complete(struct
> > nfs_client *clp,
> >  	msg.rpc_argp = &calldata->arg;
> >  	msg.rpc_resp = &calldata->res;
> >  	task_setup_data.callback_data = calldata;
> > -	task = rpc_run_task(&task_setup_data);
> > -	if (IS_ERR(task)) {
> > -		status = PTR_ERR(task);
> > -		goto out;
> > -	}
> > -	status = rpc_wait_for_completion_task(task);
> > -	if (status == 0)
> > -		status = task->tk_status;
> > -	rpc_put_task(task);
> > +	status = nfs4_call_sync_custom(&task_setup_data);
> >  out:
> >  	dprintk("<-- %s status=%d\n", __func__, status);
> >  	return status;
> 
> Hmm... I'm a little confused. Why does RECLAIM_COMPLETE need
> RPC_TASK_NO_ROUND_ROBIN? It should be ordered so it is called after
> BIND_CONN_TO_SESSION in nfs4_state_manager(), so in principle it is
> supposed to be able to recover from an error like
> NFS4ERR_CONN_NOT_BOUND_TO_SESSION. Are there other situations where
> we
> need RPC_TASK_NO_ROUND_ROBIN?
> 
> -- 
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
> 
> 

