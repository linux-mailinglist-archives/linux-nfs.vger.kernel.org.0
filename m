Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB0796F1A21
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Apr 2023 16:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjD1ODv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 28 Apr 2023 10:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjD1ODu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 28 Apr 2023 10:03:50 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E3F26A6
        for <linux-nfs@vger.kernel.org>; Fri, 28 Apr 2023 07:03:49 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-5ef41569a3fso45255806d6.3
        for <linux-nfs@vger.kernel.org>; Fri, 28 Apr 2023 07:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1682690628; x=1685282628;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k0A9CLYek3mMsCr5Uq7VlFX58wbVWy6XjArvmZ1fzp0=;
        b=NcIypNV6hGEKq25CVVweURDBkYYYcyS5rE+E8LdLGudOEkqhxU9ToS1scDjuceLmXM
         MKYJb+tBX0OgVM75Ub9YlbRY+xrCLkBy6fZYWdROynje/QDF3bGmEzuGqGEf4EdIUryZ
         ksKSEcC9J4Meg1Hm+tVP/KrWD2Cw6ZwFhNYUy3hVDtZ6NspnheI8UtAeNrhVLk/jeyIi
         ae7IKbQo7XS37mH5uw0EcouxN/dMuLdh4VNcQa8nAJ0g35yjz+GEWzagtDYOj7uTWIDT
         jeTCIKVy66bytQaPBjsPtCkvQ8VseLcIdzUYUUTeOhsCaoi3dIWKdxEuRiK2yFQxW8VR
         ovRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682690628; x=1685282628;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k0A9CLYek3mMsCr5Uq7VlFX58wbVWy6XjArvmZ1fzp0=;
        b=lLnyYvM71mvx01CnQOV4penVzwORW4o+wqq188SHxi0N5iP2BDhDpMkew61jmhh/HQ
         DRCjp9ixhTmhpv7fT2WJ2EI0G6Yb9KEm+/54CuO2iosME2P/S6+VfjS+Q+HHSFX7VVLj
         G4/HNtq/83dnrNMUHQjr01gedvoivBProEgJ7MNI7ubgU0qXzGYSoRB4bwhwnUCFSb7k
         eQjoOIZZhMvzNiIFcLyujH60MtqDrwIomAGhQ2FvAOChuJg707js6o9RmITWGVblXns9
         gH380fcKmbWhD67NY094kpGhjp08YrTK74UYWaJnf1OsuyZnwvsDq13HMeRYFbMAulKX
         xEdg==
X-Gm-Message-State: AC+VfDxpz2ZVSVa0Ef6F2TLsbRl1GU91lZURdtevmo2v30OgZA+pXF65
        djSvGWZdy0L/3ix/Y19MI4ga2w==
X-Google-Smtp-Source: ACHHUZ74wbSdfRVbXMlemal0tDqc22sgL2Ym+7Q+4Xde68L6NDEyg90D2idVqyjWaTUKZrsG4W+KUQ==
X-Received: by 2002:a05:6214:21cb:b0:5ef:519:afc with SMTP id d11-20020a05621421cb00b005ef05190afcmr8795377qvh.15.1682690628244;
        Fri, 28 Apr 2023 07:03:48 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id g19-20020a0caad3000000b005dd8b93457csm6420790qvb.20.2023.04.28.07.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 07:03:47 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1psOhP-003CeC-4G;
        Fri, 28 Apr 2023 11:03:47 -0300
Date:   Fri, 28 Apr 2023 11:03:47 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Chuck Lever <cel@kernel.org>, Bernard Metzler <BMT@zurich.ibm.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH RFC] RDMA/core: Store zero GIDs in some cases
Message-ID: <ZEvSQzOjhwEYi6m0@ziepe.ca>
References: <168261567323.5727.12145565111706096503.stgit@oracle-102.nfsv4bat.org>
 <ZEvMo4qkj9NSLXTA@ziepe.ca>
 <34E28C03-5D1A-4DAA-9B5B-D453F8C256BD@oracle.com>
 <ZEvOec75yMrin/hB@ziepe.ca>
 <36CE272E-15F4-40B3-83E8-98BCFE55CA20@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36CE272E-15F4-40B3-83E8-98BCFE55CA20@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Apr 28, 2023 at 01:58:53PM +0000, Chuck Lever III wrote:
> 
> 
> > On Apr 28, 2023, at 9:47 AM, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > 
> > On Fri, Apr 28, 2023 at 01:42:24PM +0000, Chuck Lever III wrote:
> >> 
> >> 
> >>> On Apr 28, 2023, at 9:39 AM, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >>> 
> >>> On Thu, Apr 27, 2023 at 01:14:43PM -0400, Chuck Lever wrote:
> >>>> From: Bernard Metzler <bmt@zurich.ibm.com>
> >>>> 
> >>>> Tunnel devices have zero GIDs, so skip the zero GID check when
> >>>> setting up soft iWARP over a tunnel device.
> >>> 
> >>> Huh? Why? How does that make any sense?
> >> 
> >> Read it as a cry for help.
> >> 
> >> The scenario is attempting to set up a soft iWARP device
> >> with a slave that is a tunnel device. The set up seems to
> >> work, but when connecting, the ULP gets an ADDR_ERROR
> >> because the setup did not add an entry to the GID table.
> > 
> > Don't assign a 0 IP to the tunnel?
> 
> That's a little cryptic... can you expand?
> 
> Right now I have a Tailscale VPN device with assigned IP
> addresses:
> 
> 3: tailscale0: <POINTOPOINT,MULTICAST,NOARP,UP,LOWER_UP> mtu 1280 qdisc fq_codel state UNKNOWN group default qlen 500
>     link/none      inet 100.64.0.16/32 scope global tailscale0
>        valid_lft forever preferred_lft forever
>     inet6 fd7a:115c:a1e0::10/128 scope global         valid_lft forever preferred_lft forever
>     inet6 fe80::725c:1b6d:60ed:fce4/64 scope link stable-privacy         valid_lft forever preferred_lft forever
> 
> And after that i/f is UP, I've done this:

That seems OK..

>  $ sudo rdma link add siw0 type siw netdev tailscale0
>
> With the patch I sent, I can do NFS/RDMA via soft iWARP through
> the tunnel. I'm not at all claiming that's a good fix, but only
> that this scenario is supposed to work, but currently doesn't.

Then there is something wrong in SIW, it should not be reporting 0
GIDs to the core code for that kind of device.

I don't remember what iwarp uses for it's guid format .. Maybe it was
mac adress or something and tunnels don't have a MAC, it should make
up a dummy GID for the tunnel instead of using 0..

Jason
