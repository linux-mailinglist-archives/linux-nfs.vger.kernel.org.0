Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 571C631DF59
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Feb 2021 20:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbhBQTCd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 17 Feb 2021 14:02:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbhBQTCc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 17 Feb 2021 14:02:32 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC9AC061574
        for <linux-nfs@vger.kernel.org>; Wed, 17 Feb 2021 11:01:52 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id l12so17898675edt.3
        for <linux-nfs@vger.kernel.org>; Wed, 17 Feb 2021 11:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelim-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TCo+YNJ4/itDDlR0170lhTKFf8mNEKh93PYPg809NQM=;
        b=ooojZqF4omD/L6Hs89uYdNcQ0+VEGyiIP56vH+tzjk4yiU/Bf5+5gkEyWWmILmGG4z
         /BwNiD2qhcgdK/81gh95tIt7YjFxKdM5lAGRLfvecXDOPxyzGZB2M3SIVZLoLj6SmKO1
         FPNOg3ZaoFca3sVSUuwf/kfw8t1AwEhBYCTn6Zg2r7FAaUdDe1MU7+ZaKoy6+HviFCnM
         F5gvm+X2mwhPflGiDvO8aB3Ii2JWmAIIkHC0BaB+hfbCRurS9EaP0OID/VEpOlTATO79
         dcseKiQ0ZiE+5yfTGDRhBEy1E5dJPdm+b1wn+SB2vWXlTxjJo/QoMSa1MFkPfLIXRq/O
         eXkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TCo+YNJ4/itDDlR0170lhTKFf8mNEKh93PYPg809NQM=;
        b=aZn0vlpuO18rLm15ouhDbWhtzzqAuUSAAQvVsxurtYXoKKqaaaco7Q7wF+dxD7r/aF
         8WWfvbqVoLubqCHDWA2L5/yqUnqxeegCG3dYZyJ9ZcDroN4b5GHR+0xDw/0UE4VfdRq5
         BWajMYU6jNNrNu4Bn8FaDaOula8cxMHcfCGxb93gIcUjgNEZA+l4SRC2PGjsWftSIHnF
         KJ/XIgXup4ssaNyWoLFjH3JO567YqMT8XEICpvs1B4gSh5BGczrnIS6Y+HcpubnYoB50
         mHZ36FY33Xx+gFOirDU7FdYl8U+K4idCq5KHcwyDXCVjkmiUm5unZY1wYlQbEEQaBekk
         ryXg==
X-Gm-Message-State: AOAM532BN1ZAh5/U2GequyIbU4TlStUMxLbQlqiv31ZTQRvr7yQQEHJQ
        BT9ZFw5Jh1d7bVTl6kSKKtRuN1PE7PBnaw==
X-Google-Smtp-Source: ABdhPJxfHTcsbOigOfcP0yPsJwSzi4JVMVTk+3bSGm7i+5kMs2/cpDRx/zz9bw1ecEaqLFickKNlLQ==
X-Received: by 2002:a50:fa91:: with SMTP id w17mr249004edr.195.1613588510654;
        Wed, 17 Feb 2021 11:01:50 -0800 (PST)
Received: from gmail.com ([77.124.84.167])
        by smtp.gmail.com with ESMTPSA id e19sm904196eds.10.2021.02.17.11.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 11:01:50 -0800 (PST)
Date:   Wed, 17 Feb 2021 21:01:47 +0200
From:   Dan Aloni <dan@kernelim.com>
To:     Anna Schumaker <anna.schumaker@netapp.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: Re: [PATCH v1 3/8] sunrpc: add a directory per sunrpc xprt
Message-ID: <20210217190147.d4xbhlkyk4in3qlc@gmail.com>
References: <20210215174002.2376333-1-dan@kernelim.com>
 <20210215174002.2376333-4-dan@kernelim.com>
 <CAFX2JfkkYA=6gg9UzyT1=nuKrYJ+0c+Jd4BhasAgCR=T5Rgokw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFX2JfkkYA=6gg9UzyT1=nuKrYJ+0c+Jd4BhasAgCR=T5Rgokw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Feb 16, 2021 at 04:46:55PM -0500, Anna Schumaker wrote:
> > +static ssize_t rpc_netns_xprt_dstaddr_show(struct kobject *kobj,
> > +               struct kobj_attribute *attr, char *buf)
> > +{
> > +       struct rpc_netns_xprt *c = container_of(kobj,
> > +                               struct rpc_netns_xprt, kobject);
> > +       struct rpc_xprt *xprt = c->xprt;
> > +
> > +       if (!(xprt->prot & (IPPROTO_TCP | XPRT_TRANSPORT_RDMA))) {
> 
> We might want to change these restrictions later on, so if we're going
> to put this into each function then maybe it would make sense to have
> a quick inline to check protocol support?

Yeah, I agree.

> I do the same check in the setup function for my patches, so if you
> want I can add the inline function and then it'll just be there for
> you to use.

Sure, go ahead.

> 
> > +               sprintf(buf, "N/A");
> > +               return 0;
> 
> I'm guessing the point of putting "N/A" here is so userspace tools
> don't have to guess which files exist or not for each protocol type?
> Should I change my patches to match this style too?

Yes, though I'm not sure what are the common kernel convention here.
Maybe a "-" string is sufficient?

-- 
Dan Aloni
