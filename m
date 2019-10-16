Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A37B1D862F
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Oct 2019 05:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729457AbfJPDFW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 15 Oct 2019 23:05:22 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36714 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728416AbfJPDFV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 15 Oct 2019 23:05:21 -0400
Received: by mail-qt1-f193.google.com with SMTP id o12so33977565qtf.3
        for <linux-nfs@vger.kernel.org>; Tue, 15 Oct 2019 20:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:message-id:subject:to:cc:in-reply-to:references:organization
         :mime-version:date:user-agent:content-transfer-encoding;
        bh=tMWdEAj99GCi1XzAiRKMujM/LlrI4PhQZwQP8QPRW+U=;
        b=ZZDjNftuh6sLaX/w1hwJj3PR82EUXHJAjS5JnCGx2CfIReOtd3Gx7AbCcY2oFzwUJ2
         Cbuwbl6DcZhI+IhmiFTWTUX0C8R4CsOeXHYkxu8IPqMgs8W17GR4OA70Yg7/fRkxJC3/
         kvo0JbbYaaoapjnVWdKO03sA5VA4Zz7in+VD/ojY73nzVi/ayFX7T6pvEVMw3C4IAaUI
         4fCsOFTi7qCqeWXSRY8+C5tBkNX4E7n7Du1F8zr7zkun6uIPr+gQoSpgj92mNglWcq7F
         CQx9BqRR96b4bze6ZBrUP+HJS9RHUWA5hREgvzEZj/nbat1kNMUAyW74uJOV10Cmk52q
         FVUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:subject:to:cc:in-reply-to
         :references:organization:mime-version:date:user-agent
         :content-transfer-encoding;
        bh=tMWdEAj99GCi1XzAiRKMujM/LlrI4PhQZwQP8QPRW+U=;
        b=Fr4Y9vRr+Bhzn/lBdoHPL9KW980IATxa/iKfQYgOrxxVMOeNSqLx9CtcEWs8EE1a3A
         7QvTxxXD6w3+92t+M3YUpO9OnjE1ZsRRwv9W+UIEELwx8IKHsLw/k6vJiEQDmek4AK4H
         cYFvQWvV/Xi2hR4wpHZmcXfx68ykNpvypnARkzikYKUusbuLYRU2vV97ich1LvYTvkg+
         nfvqTnC0K6RE9jCy0PO5OgrANljRZh2r8h4G0srF3vjh31JhZR/7BQlimKQfgmCCKezq
         ygdrEeDtWjTAC1GIy7FpBzHaVGUdDpFXcciy3foNvTnafNmUqXoTHcrt8L/5hrUAFVr9
         bySg==
X-Gm-Message-State: APjAAAU25pnxQsI64F24VqT5QxzoDz42sFmVE/btUVBnXj6SoVqG4ByD
        JOlYI+dzGg9sfB5IVY8kcA==
X-Google-Smtp-Source: APXvYqwdIRShvk77P5fboMZehE6K13qWTL4Z5Ej/Ok3vZEP48KofFv7HRB/H9JTEhgoXDeqERjEXzw==
X-Received: by 2002:ac8:fda:: with SMTP id f26mr42565292qtk.34.1571195119971;
        Tue, 15 Oct 2019 20:05:19 -0700 (PDT)
Received: from leira (107-1-192-66-ip-static.hfc.comcastbusiness.net. [107.1.192.66])
        by smtp.gmail.com with ESMTPSA id u123sm10674939qkh.120.2019.10.15.20.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 20:05:18 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trondmy@hammerspace.com>
Message-ID: <8ac0b07bd523e4a040b4dc5e53639e1ea3b68db6.camel@hammerspace.com>
Subject: Re: [PATCH] SUNRPC: backchannel RPC request must reference XPRT
To:     NeilBrown <neilb@suse.de>,
        "bfields@fieldses.org" <bfields@fieldses.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
In-Reply-To: <87a7a1r3t2.fsf@notabene.neil.brown.name>
References: <87tv8iqz3b.fsf@notabene.neil.brown.name>
         <20191011165603.GD19318@fieldses.org>
         <87imoqrjb8.fsf@notabene.neil.brown.name>
         <711ebfa5340c6e29ff640e855db5ad8e41a09a60.camel@hammerspace.com>
         <87a7a1r3t2.fsf@notabene.neil.brown.name>
Organization: Hammerspace Inc
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Date:   Tue, 15 Oct 2019 23:04:53 -0400
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 2019-10-16 at 10:23 +1100, NeilBrown wrote:
> On Tue, Oct 15 2019, Trond Myklebust wrote:
> 
> > Hi Neil,
> > 
> > On Tue, 2019-10-15 at 10:36 +1100, NeilBrown wrote:
> > > The backchannel RPC requests - that are queued waiting
> > > for the reply to be sent by the "NFSv4 callback" thread -
> > > have a pointer to the xprt, but it is not reference counted.
> > > It is possible for the xprt to be freed while there are
> > > still queued requests.
> > > 
> > > I think this has been a problem since
> > > Commit fb7a0b9addbd ("nfs41: New backchannel helper routines")
> > > when the code was introduced, but I suspect it became more of
> > > a problem after
> > > Commit 80b14d5e61ca ("SUNRPC: Add a structure to track multiple
> > > transports")
> > > (or there abouts).
> > > Before this second patch, the nfs client would hold a reference
> > > to
> > > the xprt to keep it alive.  After multipath was introduced,
> > > a client holds a reference to a swtich, and the switch can have
> > > multiple
> > > xprts which can be added and removed.
> > > 
> > > I'm not sure of all the causal issues, but this patch has
> > > fixed a customer problem were an NFSv4.1 client would run out
> > > of memory with tens of thousands of backchannel rpc requests
> > > queued for an xprt that had been freed.  This was a 64K-page
> > > machine so each rpc_rqst consumed more than 128K of memory.
> > > 
> > > Fixes: 80b14d5e61ca ("SUNRPC: Add a structure to track multiple
> > > transports")
> > > cc: stable@vger.kernel.org (v4.6)
> > > Signed-off-by: NeilBrown <neilb@suse.de>
> > > ---
> > >  net/sunrpc/backchannel_rqst.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/net/sunrpc/backchannel_rqst.c
> > > b/net/sunrpc/backchannel_rqst.c
> > > index 339e8c077c2d..c95ca39688b6 100644
> > > --- a/net/sunrpc/backchannel_rqst.c
> > > +++ b/net/sunrpc/backchannel_rqst.c
> > > @@ -61,6 +61,7 @@ static void xprt_free_allocation(struct
> > > rpc_rqst
> > > *req)
> > >  	free_page((unsigned long)xbufp->head[0].iov_base);
> > >  	xbufp = &req->rq_snd_buf;
> > >  	free_page((unsigned long)xbufp->head[0].iov_base);
> > > +	xprt_put(req->rq_xprt);
> > >  	kfree(req);
> > >  }
> > 
> > Would it perhaps make better sense to move the xprt_get() to
> > xprt_lookup_bc_request() and to release it in xprt_free_bc_rqst()? 
> 
> ... maybe ...
> 
> > Otherwise as far as I can tell, we will have freed slots on the
> > xprt-
> > > bc_pa_list that hold a reference to the transport itself, meaning
> > > that
> > the latter never gets released.
> 
> Apart from cleanup-on-error paths, xprt_free_allocation() is called:
>  - in xprt_destroy_bc() - at most 'max_reqs' times.
>  - in xprt_free_bc_rqst(), if the bc_alloc_count >= bc_alloc_max
> 
> So when xprt_destroy_bc() is called (from nfs4_destroy_session, via
> xprt_destroy_backchannel()), bc_alloc_max() is reduced, and possibly
> the requests are freed and bc_alloc_count is reduced accordingly.
> If the requests were busy, they won't have been freed then, but will
> then be freed when xprt_free_bc_reqst is called - because
> bc_alloc_max
> has been reduced.
> 
> Once nfs4_destroy_session() has been called on all session, and
> xprt_free_bc_rqst() has been called on all active requests, I think
> they should be no requests left to be holding a reference to
> the xprt.
> 
> And if there were requests left, and if we change the refcount code
> (like you suggest) so that they weren't holding a reference, then
> they
> would never be freed. - freeing an xprt doesn't clean out the
> bc_pa_list.
> 
> Though ... the connection from a session to an xprt isn't permanent
> (I
> guess, based on the rcu_read_lock in nfs4_destroy_session... which
> itself seems a bit odd as it doesn't inc a refcount while holding the
> lock).
> 
> So maybe the counts can get out of balance.
> 
> Conclusion: I'm not sure the ref counts are entirely correct, but I
>    cannot see a benefit from moving the xprt_get/put requests like
> you
>    suggest.
> 

I don't buy that conclusion.

Nothing stops me from changing the value of NFS41_BC_MIN_CALLBACKS to
zero. Why should that affect the existence or not of the transport by
changing the number of references held? That parameter is supposed to
determine the number of pre-allocated requests and nothing else.

I do agree with your assessment that destroying the xprt does not
currrently destroy the contents of xprt->bc_pa_list if they are non-
zero, but that would be a bug, and an easy one to fix.


-- 
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trond.myklebust@hammerspace.com



