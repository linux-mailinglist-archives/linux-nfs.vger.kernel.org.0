Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2E8057264
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Jun 2019 22:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbfFZUO1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 26 Jun 2019 16:14:27 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43731 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbfFZUO1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 26 Jun 2019 16:14:27 -0400
Received: by mail-qk1-f193.google.com with SMTP id m14so2771746qka.10
        for <linux-nfs@vger.kernel.org>; Wed, 26 Jun 2019 13:14:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lplayQ4LbrkD+5GX3cmWF3TDrEYKw7GLSMUfs1+Za0I=;
        b=EpYMGbTXH3LdI4lw4hM2CUyBrxABOV//H/PNDBEcypPIMffOTGNmK7vIzZ7qHfbyJs
         AFDqkisIVv1UpQIFb9V6LZ9bmzSrMA0vf46y2gHN1b9YqAvt0xpu8cEDHm1Uv0h6GmE4
         b11aEVlgSSlfC6/O8z48EMtYRceu+ppMyepxuzTmN1AHb8uXBWM6LsdcklvzZHhZ9zIS
         Z7t0IZjrRiVpQRn3396NlvWxbCn05KSgjJ4ztXJtGd7BDfLZCCb0KNlVD2WeLo5XdozY
         YMVPZrSb7sqed06LJU3kriSjAQdBs+G4qA8lp1vK+UXTpTQRXlY6j8hy6OlfjYDhPki1
         ZNbg==
X-Gm-Message-State: APjAAAU5S0LfGgj8wOAL4vnOC2nLpNNPVvrZcUeAn1a5Z+l50q7CiNwb
        JNkjZVFb3jt4B+HD+bEBtqBrh6/qwHg=
X-Google-Smtp-Source: APXvYqxcTq0fNqOYTaOq8JMXNdPRWJEHEJvqTWr5/gbdHHg8y/yNy2/9c36q5cCUoyWMYA6yWkWNNQ==
X-Received: by 2002:a37:c408:: with SMTP id d8mr5629215qki.18.1561580066255;
        Wed, 26 Jun 2019 13:14:26 -0700 (PDT)
Received: from dhcp-12-212-173.gsslab.rdu.redhat.com (nat-pool-rdu-t.redhat.com. [66.187.233.202])
        by smtp.gmail.com with ESMTPSA id d141sm8827863qke.3.2019.06.26.13.14.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jun 2019 13:14:25 -0700 (PDT)
Message-ID: <2b8a79f46c23e40c8bf60de4aaf37bd140c3f069.camel@redhat.com>
Subject: Re: [PATCH] SUNRPC: Fix possible autodisconnect during connect due
 to stale last_used
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Date:   Wed, 26 Jun 2019 16:14:24 -0400
In-Reply-To: <566e3eb7b501d48a2989461c316b66c03c56b129.camel@hammerspace.com>
References: <1561578606-24602-1-git-send-email-dwysocha@redhat.com>
         <566e3eb7b501d48a2989461c316b66c03c56b129.camel@hammerspace.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 2019-06-26 at 20:11 +0000, Trond Myklebust wrote:
> On Wed, 2019-06-26 at 15:50 -0400, Dave Wysochanski wrote:
> > When a connection is successful ensure last_used is updated before
> > calling
> > xprt_schedule_autodisconnect inside xprt_unlock_connect.  This
> > avoids
> > a
> > possible xprt_autoclose firing immediately after connect sequence
> > due
> > to
> > an old value of last_used given to mod_timer in
> > xprt_schedule_autodisconnect.
> > 
> > Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
> > ---
> >  net/sunrpc/xprt.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/net/sunrpc/xprt.c b/net/sunrpc/xprt.c
> > index f6c82b1..fceaede 100644
> > --- a/net/sunrpc/xprt.c
> > +++ b/net/sunrpc/xprt.c
> > @@ -800,6 +800,7 @@ void xprt_unlock_connect(struct rpc_xprt *xprt,
> > void *cookie)
> >  		goto out;
> >  	xprt->snd_task =NULL;
> >  	xprt->ops->release_xprt(xprt, NULL);
> > +	xprt->last_used = jiffies;
> >  	xprt_schedule_autodisconnect(xprt);
> >  out:
> >  	spin_unlock_bh(&xprt->transport_lock);
> 
> Let's just move that line into xprt_schedule_autodisconnect(), since
> in
> practice this means all callers are doing the same thing.
> 
> 

Will do and resubmit - thanks!

