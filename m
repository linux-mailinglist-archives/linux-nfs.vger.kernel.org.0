Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3F3C2FF3DF
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Jan 2021 20:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725883AbhAUTKd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 Jan 2021 14:10:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbhAUTJy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 Jan 2021 14:09:54 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F210AC0613ED
        for <linux-nfs@vger.kernel.org>; Thu, 21 Jan 2021 10:58:18 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id a9so2790241wrt.5
        for <linux-nfs@vger.kernel.org>; Thu, 21 Jan 2021 10:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelim-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OKw0ZYFzMtpOMM08Mm3InuewDzOdzcoJxbqdwYvyWfQ=;
        b=mSViQzbBlhrFgwyRpbEBzfAgQ/hf6aqj9nOWcuLb8cKuXDRLyL9JVMQFuZJO4Ow9uP
         02eSqaGtzOsX4aIOY8X6PTD6wtaQOwyxhArN/CntSYy0Ox0+xL51xh7DXPdMpUaIE5Wl
         Say7XizujsCiWL52EHBGfec9C51pXeQozjEKyHMH1LYYWSIKp/EgFbv3JjZd9sLon8vn
         cLxK22IwZ85Mao5e4yiZqmg3fXSitVgDaB3xDRKnZRvdGwfvsdtGwlM9D7/auxlRUXeu
         t2JqKEmoqCjgPZ+ylluCRjZxqx76rQlsRuWMgBjoP0TP2LRHF0an3d+3OL45psteg2bp
         axOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OKw0ZYFzMtpOMM08Mm3InuewDzOdzcoJxbqdwYvyWfQ=;
        b=K4plr8iG7Dt+cHyjYMZfiAHzsZT4xlXEpQk7g71+ROxgwxgTaMREGr5jz7PMHVlqAH
         dSrfJhFrUptlGb1zhAhVmu3iC/J5kmbKvgJI9NwKnx2+cTdn/F2GGsmt0f0sZAokjh9L
         CBsUSYnrxqS6cnasd+9JZVkbta+c8J4DQcY2JlyAddyY6x1SLSYw+EMotQccS7EzjNxF
         LiCvu8dd10xImyWq2DBMJxvMtvxMdlG3S6/Dwh1zbNqst+ymi5zCMbT6ndju/kTEDHUq
         Bz2rnNXnuDAPGgTGW+kmCDlkMWVVOdgd9BE5YneVBL7D5zPJdgLxXDIfT34mh6tAsDKm
         LWSg==
X-Gm-Message-State: AOAM532zUxeSd/j6onL8EyQG1ncySnq2OxEpj2AJAxoa4JXjwHn75MJi
        8CCmsrvXPM/fNFD65sd0JGvvhQ==
X-Google-Smtp-Source: ABdhPJxlsvZHJSO4GeMwHFhBGPE/S6zqSZFKrAAlug0SzLoThgZK/5p0f70ZWnhnkqRSFIXLTe2O6A==
X-Received: by 2002:adf:b781:: with SMTP id s1mr896988wre.290.1611255497693;
        Thu, 21 Jan 2021 10:58:17 -0800 (PST)
Received: from gmail.com ([77.124.84.167])
        by smtp.gmail.com with ESMTPSA id v4sm9541391wrw.42.2021.01.21.10.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 10:58:16 -0800 (PST)
Date:   Thu, 21 Jan 2021 20:58:13 +0200
From:   Dan Aloni <dan@kernelim.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Jim Foraker <foraker1@llnl.gov>,
        Ben Woodard <woodard@redhat.com>
Subject: Re: [RFC] NFSv3 RDMA multipath enhancements
Message-ID: <20210121185813.GA3135951@gmail.com>
References: <20210112141706.GA3146539@gmail.com>
 <3AB7389B-2EA9-4894-9656-9C8512166E0E@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3AB7389B-2EA9-4894-9656-9C8512166E0E@oracle.com>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Jan 13, 2021 at 09:59:58AM -0500, Chuck Lever wrote:
> > To my understanding NFSv4.x with pNFS has advanced dynamic transport
> > management logic along file layouts supporting stripe over file offsets,
> > however there are cases in which we would like to achieve good
> > performance even with the older protocol.
>
> Hi Dan, my curiosity is piqued about the RPC request dispatch changes
> you have in mind. Can you post them here for review?

These changes depend on the initial changes I'd like to contribute. The
gist of them concerns the xprt multipath algorithm where in addition to
round robin, we add further considerations regarding transport picking.
For example, for data IOs, the NUMA node to which the memory pages
attached to the RPC request may be used to pick a transport with an
outgoing local port that is closer to that memory in the server
architecture compared to the other local ports. So the idea is to lessen
data transfer bottlenecks in hardware.

> Also, if you can tell us, what NFS server supports NFS/RDMA but not
> NFSv4 ?

For example, there are VAST Data clusters currently supporting NFSv3 (as
one logical server), with the NFSv4 support coming soon.

--
Dan Aloni
