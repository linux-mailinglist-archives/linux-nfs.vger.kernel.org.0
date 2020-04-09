Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCDC01A391E
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Apr 2020 19:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgDIRrx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 9 Apr 2020 13:47:53 -0400
Received: from mail-qv1-f66.google.com ([209.85.219.66]:41241 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbgDIRrw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 9 Apr 2020 13:47:52 -0400
Received: by mail-qv1-f66.google.com with SMTP id b4so3580381qvw.8
        for <linux-nfs@vger.kernel.org>; Thu, 09 Apr 2020 10:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mU+jK6oSXvXUu0iMk0azL+iihEGB8rK62t4KgCJhr1o=;
        b=UOcWrhunHXn7fIbjHL+5nubto1kmCA/CKqBDAN7CAmFkEcxWVHzV7Jzmt/zJ0WAmsj
         pQiE37UVHskxqP8bT9er9XFR2uKKIo9OdCjVpoCeUuLGZwl395SIjF8bAfdRd1GBqOVj
         rrtSomhJC/5R1tYj3axvSm/cbu9tnuKTLBo1bwCEOST6XFaulmgxZQxNRGqdxHvFlRje
         bwRpEH1oI+cVlFnyM+eNo6ehNP81+iWuszYGio1H6mFOkFzHiBPy0qXj7fjv6GxHZ4wK
         hmgc8sCokL0ownQ2lUfOTkVeU8AhI3CJiyMmsjiYLUbVDHZdlJNguo+De7687aU52ipb
         lmRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mU+jK6oSXvXUu0iMk0azL+iihEGB8rK62t4KgCJhr1o=;
        b=J9WBMD4QliGKUFG0fc6xSjy+bK/B4n4a8EiXRlpEHB8ZDo8ZaQGYRt9+EFCui8zDfR
         S5k9myw3LQj1jDcCM8dt1OwYK4Pb5ks7CfMIWpH2Lq4BiSqugYIGnW+18oq0qODzkMy7
         gX5xre36cXpLuYpGVngjKlxYoA4q7r9brlx6nBJv6h+TpBzFXqqiCIFTg/1TciUdYhNf
         eM3cvrDrqRFkLDO9PfML9zD1me4Orfgn5OQwwWPIYRmGqN0UtpmvkPWisoNLbjK60I3o
         8P+PcBcvHpUyvuMEama+AcvVrBdVEp4LHBJJoeggywqLCx2vkytknBGaoDUdZwcfMkcB
         GH0Q==
X-Gm-Message-State: AGi0PuZH3/hhB0dQdPJR5Q1KIMWH8x6fs0EKHAqDHnlUaBmVhQo3EUZ7
        QPes7zyOVrfk9SikNvrjmwAdfA==
X-Google-Smtp-Source: APiQypL+Q7BpbAn83T1arM6DbPqeT9jeLwq9a96Wq+1FgTLbj2zCq5NbWHBLwbhIsCVW+8uYszsjmA==
X-Received: by 2002:a0c:9aea:: with SMTP id k42mr1256564qvf.91.1586454471855;
        Thu, 09 Apr 2020 10:47:51 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id c27sm21869064qkk.0.2020.04.09.10.47.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Apr 2020 10:47:51 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jMbHK-0003WT-DU; Thu, 09 Apr 2020 14:47:50 -0300
Date:   Thu, 9 Apr 2020 14:47:50 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH v1 3/3] svcrdma: Fix leak of svc_rdma_recv_ctxt objects
Message-ID: <20200409174750.GK11886@ziepe.ca>
References: <20200407190938.24045.64947.stgit@klimt.1015granger.net>
 <20200407191106.24045.88035.stgit@klimt.1015granger.net>
 <20200408060242.GB3310@unreal>
 <D3CFDCAA-589C-4B3F-B769-099BF775D098@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D3CFDCAA-589C-4B3F-B769-099BF775D098@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Apr 09, 2020 at 10:33:32AM -0400, Chuck Lever wrote:
> Hi Leon-
> 
> > On Apr 8, 2020, at 2:02 AM, Leon Romanovsky <leon@kernel.org> wrote:
> > 
> > On Tue, Apr 07, 2020 at 03:11:06PM -0400, Chuck Lever wrote:
> >> Utilize the xpo_release_rqst transport method to ensure that each
> >> rqstp's svc_rdma_recv_ctxt object is released even when the server
> >> cannot return a Reply for that rqstp.
> >> 
> >> Without this fix, each RPC whose Reply cannot be sent leaks one
> >> svc_rdma_recv_ctxt. This is a 2.5KB structure, a 4KB DMA-mapped
> >> Receive buffer, and any pages that might be part of the Reply
> >> message.
> >> 
> >> The leak is infrequent unless the network fabric is unreliable or
> >> Kerberos is in use, as GSS sequence window overruns, which result
> >> in connection loss, are more common on fast transports.
> >> 
> >> Fixes: 3a88092ee319 ("svcrdma: Preserve Receive buffer until ... ")
> > 
> > Chuck,
> > 
> > Can you please don't mangle the Fixes line?
> 
> I've read e-mail from others that advocate this form of mangling
> instead of using commit message lines that are too long.

Really? 

At least I won't accept Fixes lines that are not in the cannonical
format, I routinely fix these things in all sorts of ways, but I've
never seen someone shorten it with ...

> > A lot of automatization is relying on the fact that this line is canonical,
> > both in format and in the actual content.
> 
> Understood, but checkpatch.pl does not complain about it. Perhaps,
> therefore, it is the automation that is not correct.

checkpatch.pl doesn't check Fixes lines for correctness, because it
doesn't have access to the git or something. This was talked about
too.. Stephen likes to check them as part of linux-next though.

However, checkpatch.pl does not complain for long lines on Fixes:
tags demanding they be shortened

> The commit ID is what automation should key off of. The short
> description is only for human consumption. 

Right, so if the actual commit message isn't included so humans can
read it then what was the point of including anything?

Jason
