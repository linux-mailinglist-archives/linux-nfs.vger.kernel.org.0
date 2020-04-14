Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20F701A7A8D
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Apr 2020 14:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440020AbgDNMTi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 Apr 2020 08:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2440011AbgDNMTd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 Apr 2020 08:19:33 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B46EC061A0C
        for <linux-nfs@vger.kernel.org>; Tue, 14 Apr 2020 05:19:33 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id t3so9051969qkg.1
        for <linux-nfs@vger.kernel.org>; Tue, 14 Apr 2020 05:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=COIbcevwLYkzrhP2CU190PF2JhFzcK8tcNLYHrnm44U=;
        b=ZRER/ysHClBeCuSTucMariAEakIOsNBLRQomZpMIWd39mCAZVNA3TIcDSP/kruVs3p
         9BvKuSi9zEruLi/xJu+fjlrkF6ljfJscGeoIecRAxyAa6RLpqRg26mNY6PiOFIkgNO1p
         VQZ6WysBhueSLv9B6PByvqGbIEX+knuOQw8uu/e5CMF2FPKKRGoYdgGs6nJbqQ0k1far
         NtQLnvDRWSqpFtQ1NiPn2wv2w62idaPTrrqJziHhQNwCj5mv/Yva31xwSmCJYNWL/hcg
         n8U3psolduGgBJMSJSvzqggkXBkZKoUgq4Gf5vrqUPJya0v2tPpzL36T4axCa2B7TC7E
         lklQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=COIbcevwLYkzrhP2CU190PF2JhFzcK8tcNLYHrnm44U=;
        b=ZIOGgfJEn/pP1LH/TE16gTvjwu3rD/HAjCuvG1uFCCEufTj0AwqDflAK0vuc3kb1eP
         Oem83XStsAJFkPiFQiDki+SpIozLAVxp5uKj9PpnWADktuHAEHNCeVO5O+AyCuIzGtHx
         L+iGxZQYdeev/8w2BTFttO9ECzQz14Wiu8MKbxUxQKyg+QUuLJ8VPkQ0vdLTBPuhbkuq
         kEl+vuyR9dLruutwOSmwDsLUQVTB6EaEDKq8Vzp5JaHrkCCWzMCTd5ViCGrQdTd5gL6Q
         bomfGCHGdEeY4SrfZ0bn2Gg6v5BPV2B/qUAZ5nkBJrUjjLBQWTcJUAc/9IMsGOIgBXDr
         +k0g==
X-Gm-Message-State: AGi0PuacgAVg4ZwH1Cw10zTjV8tMed98NiFTCzyANtYdwn3zQOTZDw0j
        nT6aNwckDzdnvr7ng92VR+I09w==
X-Google-Smtp-Source: APiQypL8ULZ+MER7vN942OA42vx7sz6KeyfTSfPn36TqLzkf7700PHy4u+kbH20EPHxJ/INOqtiYfA==
X-Received: by 2002:a37:b887:: with SMTP id i129mr13233238qkf.28.1586866772522;
        Tue, 14 Apr 2020 05:19:32 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id d4sm10806832qtc.48.2020.04.14.05.19.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Apr 2020 05:19:31 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jOKXL-0003F8-C7; Tue, 14 Apr 2020 09:19:31 -0300
Date:   Tue, 14 Apr 2020 09:19:31 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Leon Romanovsky <leon@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH v1 3/3] svcrdma: Fix leak of svc_rdma_recv_ctxt objects
Message-ID: <20200414121931.GA5100@ziepe.ca>
References: <20200407190938.24045.64947.stgit@klimt.1015granger.net>
 <20200407191106.24045.88035.stgit@klimt.1015granger.net>
 <20200408060242.GB3310@unreal>
 <D3CFDCAA-589C-4B3F-B769-099BF775D098@oracle.com>
 <20200409174750.GK11886@ziepe.ca>
 <20200413192907.GA23596@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200413192907.GA23596@fieldses.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Apr 13, 2020 at 03:29:07PM -0400, J. Bruce Fields wrote:
> On Thu, Apr 09, 2020 at 02:47:50PM -0300, Jason Gunthorpe wrote:
> > On Thu, Apr 09, 2020 at 10:33:32AM -0400, Chuck Lever wrote:
> > > The commit ID is what automation should key off of. The short
> > > description is only for human consumption. 
> > 
> > Right, so if the actual commit message isn't included so humans can
> > read it then what was the point of including anything?
> 
> Personally as a human reading commits in a terminal window I prefer the
> abbreviated form.

Frankly, I think they are useless, picking one of yours at random:

    Fixes: 4e48f1cccab3 "NFSD: allow inter server COPY to have... "

And sadly the '4e48f1cccab3' commit doesn't appear in Linus's tree so
now we are just totally lost, with a bad commit ID and a mangled
subject line.

> I haven't been doing the redundant parentheses and quotes either.  Was
> that dreamt up by an Arlo Guthrie fan?  ("KID, HAVE YOU REHABILITATED
> YOURSELF?")

Well it seems like you are just aren't following the standard style
at all. :(

Jason
