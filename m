Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4546F1AD016
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2020 21:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728611AbgDPTFh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 16 Apr 2020 15:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730533AbgDPTFe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 16 Apr 2020 15:05:34 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D6AC061A0F
        for <linux-nfs@vger.kernel.org>; Thu, 16 Apr 2020 12:05:34 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id v7so22626175qkc.0
        for <linux-nfs@vger.kernel.org>; Thu, 16 Apr 2020 12:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XhfGxn6jc7e8D8i7SongnP0TYe1kQlI7ZqhlC/3v4ao=;
        b=g4omBsfXROniaxYIxlhCUVRClP59Iuiw1htHSX0ztzQOdE3r4L6oOcqbNqm72vGgon
         oFi8qTGtqNyYxyZm7NZF3UNsF1dAMG9dhj0GHWOoUKf6k52gSK+OhV0XjS1mtbFeNCLN
         gWFzqG+9zyhKbEAVA5H6Opbpyod7cLafsSkok/zDp3Ny0ENWhS3aG77PhKv/hbfm/5qt
         hstzl7ffFY2JcJqic1tippB1DHLsOcy2clhzXh7x4ukVAbkz6YhEAs4+xe8Qy7kQHYcz
         P5yJjnWBSK6hdxDpQ7CBAi4DAKq5Lzf7GkdNRWSmgDgBZdvWddCzFbJr5KRf3Q7iDTw3
         ZKHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XhfGxn6jc7e8D8i7SongnP0TYe1kQlI7ZqhlC/3v4ao=;
        b=PtXcq65acIrbQZ8m7BZjsBRxu5/aE9fbIZkeRwzk9N019E+WIsU4c1wD7YnJiyDiuI
         dgZDNr8MY8gSeFk7sKhuyNNNsB+aNhbKj8SO3OwAknhayPRhSZoSO74eWjDwjjcA5Y2T
         iyeKu1O6nTq+IDXBtpnViEc4EBHNNbplwWakDRyEOfcFC70i97k/uZpLEfH0r8vMfPad
         /FNZWw7e//jC8elBZ58cPcXUHyDTA0GCeGbFww7H2BQzG9U1ZeAqck6LXntO4CBn/Y2L
         ofOjO9Hrd0ARS+IiHs9XMptlOyzOetTV7jAnTtzgo8m5wQx2EYUa1fmrs42hBFB6f5Qz
         tsPA==
X-Gm-Message-State: AGi0PuYYnB6R9kyDvnPSS5r43bhcRxdCoy6gkjctapFxbvAswrIyDCHX
        eeAdamfF7ohipxypNxdidoJvVQ==
X-Google-Smtp-Source: APiQypIcyHlxTWxUikFJ0W4WN7Qm8jAEhbxfg+Epu22JCk0t+ZiPOKJNocPmN/Fmgy08lIlI06SZWA==
X-Received: by 2002:a37:67c4:: with SMTP id b187mr11383303qkc.296.1587063933377;
        Thu, 16 Apr 2020 12:05:33 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id b19sm1739084qkg.72.2020.04.16.12.05.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Apr 2020 12:05:32 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jP9pM-0007EN-6V; Thu, 16 Apr 2020 16:05:32 -0300
Date:   Thu, 16 Apr 2020 16:05:32 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Leon Romanovsky <leon@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH v1 3/3] svcrdma: Fix leak of svc_rdma_recv_ctxt objects
Message-ID: <20200416190532.GA5100@ziepe.ca>
References: <20200407190938.24045.64947.stgit@klimt.1015granger.net>
 <20200407191106.24045.88035.stgit@klimt.1015granger.net>
 <20200408060242.GB3310@unreal>
 <D3CFDCAA-589C-4B3F-B769-099BF775D098@oracle.com>
 <20200409174750.GK11886@ziepe.ca>
 <20200413192907.GA23596@fieldses.org>
 <20200414121931.GA5100@ziepe.ca>
 <20200414151303.GA9796@fieldses.org>
 <20200414152016.GE5100@ziepe.ca>
 <20200414161744.GB9796@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414161744.GB9796@fieldses.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Apr 14, 2020 at 12:17:44PM -0400, J. Bruce Fields wrote:
> On Tue, Apr 14, 2020 at 12:20:16PM -0300, Jason Gunthorpe wrote:
> > On Tue, Apr 14, 2020 at 11:13:03AM -0400, J. Bruce Fields wrote:
> > > On Tue, Apr 14, 2020 at 09:19:31AM -0300, Jason Gunthorpe wrote:
> > > > On Mon, Apr 13, 2020 at 03:29:07PM -0400, J. Bruce Fields wrote:
> > > > > On Thu, Apr 09, 2020 at 02:47:50PM -0300, Jason Gunthorpe wrote:
> > > > > > On Thu, Apr 09, 2020 at 10:33:32AM -0400, Chuck Lever wrote:
> > > > > > > The commit ID is what automation should key off of. The short
> > > > > > > description is only for human consumption. 
> > > > > > 
> > > > > > Right, so if the actual commit message isn't included so humans can
> > > > > > read it then what was the point of including anything?
> > > > > 
> > > > > Personally as a human reading commits in a terminal window I prefer the
> > > > > abbreviated form.
> > > > 
> > > > Frankly, I think they are useless, picking one of yours at random:
> > > > 
> > > >     Fixes: 4e48f1cccab3 "NFSD: allow inter server COPY to have... "
> > > > 
> > > > And sadly the '4e48f1cccab3' commit doesn't appear in Linus's tree so
> > > 
> > > Ow, apologies.  Looks like I rebased after writing that Fixes tag.
> > > 
> > > I wonder if it's possible to make git warn....
> > > 
> > > Looks like a pre-rebase hook could check the branch being rebased for
> > > "Fixes:" lines referencing commits on the rebased branch.
> > 
> > I have some silly stuff to check patches before pushing them and it
> > includes checking the fixes lines because they are very often
> > wrong, both with wrong commit IDs and wrong subjects!
> 
> I'd be interested in seeing it.

Sure, let me put my scripts on github..

Jason
