Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2D7B1C7518
	for <lists+linux-nfs@lfdr.de>; Wed,  6 May 2020 17:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729311AbgEFPjZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 6 May 2020 11:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbgEFPjY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 6 May 2020 11:39:24 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A7FC061A0F;
        Wed,  6 May 2020 08:39:24 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id c10so2401893qka.4;
        Wed, 06 May 2020 08:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2ldQrxl/Gb/wRFAuytJca8G56Q/kIoRyMgqfl16exiE=;
        b=W3A5OKo7EkhcaGvEPgsUd40S+A9dKvHLVTse38jjDrCHcO85rqqAN0GHAUo750jKyf
         nyA5TcYQXQ2MrVo54oLywdjDeDIlUplaqoiz40BV7sBfvhgecZId6WEOYJDg9R49u8Kw
         foCMvWelVeem7ZglJ/p1VQ+HEblaVfrWJPe6RcDwq1P+z0pQU6KZ/sHqCyZPKdgyqXaw
         PBGjLKtnykHXNfErxwV5CpskQr4FU7FN9XX1EPqG99C1oWgEQGn5WLAGIoelwMqq++OZ
         lYpPrR+WZrOlkJRh1kVaqi8Nhc5GImNuEab/bdcH1teKlcLPuDTDf1eGZmu7DXLL3+3L
         z6mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=2ldQrxl/Gb/wRFAuytJca8G56Q/kIoRyMgqfl16exiE=;
        b=djbdbxr+KM922bXBEADKXc5QUCYr7Aym5EIcPI27ev9msh63jx+CKpDZEbIECWBVcp
         VXxFD7Ua1zz6iUlDbvrqNJ3ChlOdmOjcZlImNltqeKKx5YHkJwdIGxrJAdXAvLtulish
         oSXyiYDYjSZ+soTCqWnbKfrs9h9mkpwLWcfUjEiEoRsyeAKGLnX1tW9Idg3ZBuieBwdq
         TqXaaUEP2lwQCU9Y4WZyBoRUV7cUDTtjVWYk6zct4dgcpg/I5W9hggUEOe6+RdjpfjEU
         Q9zoFJtB9FibfaVdqj8sijypexD89kufAQT24uiZ7fEq2rBjd/SjVAChV8N6jCDrcMNW
         szNQ==
X-Gm-Message-State: AGi0Pua5dsU5fhxhqG+6RXxDvmA7VWL+41DRmdcH0+snJT3Dzcs6ChaD
        5YTCFQntahfVRRpP3QjklWUUn3/G+i8=
X-Google-Smtp-Source: APiQypJq9xuh1jpId2VAIHlIswKTJyc1R1BJ5CsV28I3FE7cxiBPL30JoJze5y6XJEwIj1F2XNuCIw==
X-Received: by 2002:ae9:ef84:: with SMTP id d126mr9252708qkg.19.1588779563482;
        Wed, 06 May 2020 08:39:23 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:b0df])
        by smtp.gmail.com with ESMTPSA id n9sm1893626qkn.10.2020.05.06.08.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 08:39:22 -0700 (PDT)
Date:   Wed, 6 May 2020 11:39:20 -0400
From:   Tejun Heo <tj@kernel.org>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     "J. Bruce Fields" <bfields@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        Jeff Layton <jlayton@redhat.com>,
        David Howells <dhowells@redhat.com>, Shaohua Li <shli@fb.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] allow multiple kthreadd's
Message-ID: <20200506153920.GB3350@mtj.thefacebook.com>
References: <1588348912-24781-1-git-send-email-bfields@redhat.com>
 <CAHk-=wiGhZ_5xCRyUN+yMFdneKMQ-S8fBvdBp8o-JWPV4v+nVw@mail.gmail.com>
 <20200501182154.GG5462@mtj.thefacebook.com>
 <20200505021514.GA43625@pick.fieldses.org>
 <20200505210118.GC27966@fieldses.org>
 <20200505210956.GA3350@mtj.thefacebook.com>
 <20200505212527.GA1265@fieldses.org>
 <20200506153658.GA21307@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506153658.GA21307@fieldses.org>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello, Bruce.

On Wed, May 06, 2020 at 11:36:58AM -0400, J. Bruce Fields wrote:
> On Tue, May 05, 2020 at 05:25:27PM -0400, J. Bruce Fields wrote:
> > On Tue, May 05, 2020 at 05:09:56PM -0400, Tejun Heo wrote:
> > > It's not the end of the world but a bit hacky. I wonder whether something
> > > like the following would work better for identifying worker type so that you
> > > can do sth like
> > > 
> > >  if (kthread_fn(current) == nfsd)
> > >         return kthread_data(current);
> > >  else
> > >         return NULL;     
> > 
> > Yes, definitely more generic, looks good to me.
> 
> This is what I'm testing with.
> 
> If it's OK with you, could I add your Signed-off-by and take it through
> the nfsd tree? I'll have some other patches that will depend on it.

Please feel free to use the code however you see fit. Given that it'll be
originating from you, my signed-off-by might not be the right tag. Something
like Original-patch-by should be good (nothing is fine too).

Thanks.

-- 
tejun
