Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB051312C
	for <lists+linux-nfs@lfdr.de>; Fri,  3 May 2019 17:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbfECPas (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 3 May 2019 11:30:48 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41026 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbfECPas (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 3 May 2019 11:30:48 -0400
Received: by mail-qk1-f193.google.com with SMTP id g190so218311qkf.8
        for <linux-nfs@vger.kernel.org>; Fri, 03 May 2019 08:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=fWAzmRq1kAPqx4gKbf9hzlwHx9jMxWbxjoZzcU7wboY=;
        b=OdZRcLunh5bK6zm4tKuCSVSEC2d/99AuA68asO6A5MymXnK13tk6+pMQV4Fp367xS4
         R4JZu580LssqD8LKWTgLfOQBHcFhB7GhuLtzY+VbHyuYmVVJpbQ3exUCFlT/e1MiFWlm
         xxdOjfFP8q4kiG12CBOXSBlk2I51rts0AzQ7jMOeVIzsNzeAf1XyDCt52JWmzTPREZA6
         Z//A2cv94KdBnK3vR1i+YTaglxSZFU18BkOmh2AyU3fOtUxZSgrHZRKpJ0OGZzP+8xtt
         BGcB873tZuT+WSx9NxkBTHcvNupRYbmfNkR2irg0mBsQIC0rafOT1V3LfOKxyFt4jLZ+
         J/rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=fWAzmRq1kAPqx4gKbf9hzlwHx9jMxWbxjoZzcU7wboY=;
        b=aIMOz4J1U/Xe9XGPoUVmtWFy+VjlN89Tbj+ff3Qt6cK1yI1MwmQ2ombl/HRlLiRrBT
         BO3+eS/Pe0Y/4oexY4lBkPbKnYv7rsArMZrMaViRIxtijuRrzEfH619dS8QgdI5vM1UW
         yqu6fiXyzMju80c20WXmUHelhw7yQjjGMHfG3EznHQVBXMuVrgMKjYBmmnqGiOyQuufp
         xSCJEuTV3O3jPolBiy1+El+s0fUKipG9VzBMTJ2Sf8Uy/4nU3PTdh/E58djjZxqFX7/a
         9L+emELrjnem05ykZXgzst7cM7LE5HQIw/lPVQvTtO8OQ7Fwg2ZXJa3I1S3Wxkdvd2a2
         zuAg==
X-Gm-Message-State: APjAAAXuBTNk++c+ww5ZHDowp6nSd56dxXuOYqoI+gf61mzTEJNJGSh4
        sLQotkLf/eIDr6J1pfyUp694Qxyhuw==
X-Google-Smtp-Source: APXvYqxnggaIiJ6lt6eWP+qDbF7jLQS0NoOyJYFyerADvhYd1EtpW7C0RIQJ6Ymc27VUbvk+uQrCoQ==
X-Received: by 2002:a05:620a:34b:: with SMTP id t11mr8362223qkm.279.1556897447283;
        Fri, 03 May 2019 08:30:47 -0700 (PDT)
Received: from leira ([12.41.144.226])
        by smtp.gmail.com with ESMTPSA id a3sm1540244qti.47.2019.05.03.08.30.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 03 May 2019 08:30:46 -0700 (PDT)
Message-ID: <0fb44ee09e95964ab04c0b25470d871d43bf91b6.camel@gmail.com>
Subject: Re: [RFC PATCH 3/5] SUNRPC: Remove the bh-safe lock requirement on
 xprt->transport_lock
From:   Trond Myklebust <trondmy@gmail.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Fri, 03 May 2019 11:28:54 -0400
In-Reply-To: <EBFAF849-B5F1-4CFD-8DB4-7D66815353C8@oracle.com>
References: <20190503111841.4391-1-trond.myklebust@hammerspace.com>
         <20190503111841.4391-2-trond.myklebust@hammerspace.com>
         <20190503111841.4391-3-trond.myklebust@hammerspace.com>
         <20190503111841.4391-4-trond.myklebust@hammerspace.com>
         <EBFAF849-B5F1-4CFD-8DB4-7D66815353C8@oracle.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.1 (3.32.1-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 2019-05-03 at 10:21 -0400, Chuck Lever wrote:
> > On May 3, 2019, at 7:18 AM, Trond Myklebust <trondmy@gmail.com>
> > wrote:
> > 
> > Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> > ---
> > net/sunrpc/xprt.c                          | 61 ++++++++++---------
> > ---
> > net/sunrpc/xprtrdma/rpc_rdma.c             |  4 +-
> > net/sunrpc/xprtrdma/svc_rdma_backchannel.c |  4 +-
> > net/sunrpc/xprtrdma/svc_rdma_transport.c   |  8 +--
> > net/sunrpc/xprtsock.c                      | 23 ++++----
> > 5 files changed, 47 insertions(+), 53 deletions(-)
> 
> For rpc_rdma.c and svc_rdma_backchannel.c:
> 
>    Reviewed-by: Chuck Lever <chuck.lever@oracle.com>
> 
> For svc_rdma_transport.c:
> 
> These locks are server-side only. AFAICS it's not safe
> to leave BH's enabled here. Can you drop these hunks?

Oops... Yes, I don't know why I mistook that for the xprt-
>transport_lock...

You mean these 3 hunks, right?

> > diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c
> > b/net/sunrpc/xprtrdma/svc_rdma_transport.c
> > index 027a3b07d329..18ffc6190ea9 100644
> > --- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
> > +++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
> > @@ -221,9 +221,9 @@ static void handle_connect_req(struct
> > rdma_cm_id *new_cma_id,
> > 	 * Enqueue the new transport on the accept queue of the
> > listening
> > 	 * transport
> > 	 */
> > -	spin_lock_bh(&listen_xprt->sc_lock);
> > +	spin_lock(&listen_xprt->sc_lock);
> > 	list_add_tail(&newxprt->sc_accept_q, &listen_xprt-
> > >sc_accept_q);
> > -	spin_unlock_bh(&listen_xprt->sc_lock);
> > +	spin_unlock(&listen_xprt->sc_lock);
> > 
> > 	set_bit(XPT_CONN, &listen_xprt->sc_xprt.xpt_flags);
> > 	svc_xprt_enqueue(&listen_xprt->sc_xprt);
> > @@ -396,7 +396,7 @@ static struct svc_xprt *svc_rdma_accept(struct
> > svc_xprt *xprt)
> > 	listen_rdma = container_of(xprt, struct svcxprt_rdma, sc_xprt);
> > 	clear_bit(XPT_CONN, &xprt->xpt_flags);
> > 	/* Get the next entry off the accept list */
> > -	spin_lock_bh(&listen_rdma->sc_lock);
> > +	spin_lock(&listen_rdma->sc_lock);
> > 	if (!list_empty(&listen_rdma->sc_accept_q)) {
> > 		newxprt = list_entry(listen_rdma->sc_accept_q.next,
> > 				     struct svcxprt_rdma, sc_accept_q);
> > @@ -404,7 +404,7 @@ static struct svc_xprt *svc_rdma_accept(struct
> > svc_xprt *xprt)
> > 	}
> > 	if (!list_empty(&listen_rdma->sc_accept_q))
> > 		set_bit(XPT_CONN, &listen_rdma->sc_xprt.xpt_flags);
> > -	spin_unlock_bh(&listen_rdma->sc_lock);
> > +	spin_unlock(&listen_rdma->sc_lock);
> > 	if (!newxprt)
> > 		return NULL;
> > 
> > 

-- 
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trond.myklebust@hammerspace.com



