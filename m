Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5267831A0D7
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Feb 2021 15:45:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbhBLOok (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 12 Feb 2021 09:44:40 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:18023 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbhBLOoj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 12 Feb 2021 09:44:39 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B6026942e0000>; Fri, 12 Feb 2021 06:43:58 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 12 Feb
 2021 14:43:58 +0000
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Fri, 12 Feb 2021 14:43:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HfyO9uzeC5BIFrM0CYj/M/utedXA3BnZZvKUM/d2XLTdOkWNois9DD9QQP5PkrmU0I7i4VGfV2K0+aAcQfhxW3MzlcQbRYEOZDGmqkVJ6O38UEP8cEyxbu1gmVfBEeDUafyLZOTvbZ36/BbrsofxhSwVQMK4b26dXWtoDAaPgTyem4FYFsGsIBNdD1m7x11+GDiF6RODGAeuuvFGVV+nj34M1TV/7fXoFiYBqXQyCmRRHOmedJ+A4Z3HV8y3zlhUNdslRwhCyZrbi5twOR9V7iN3+UZFPMbmpwQA1Qxa6CNsaD07XOgJ0HmO86BWm+HiypA1cBtEnKZyhvW6Ta1mhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/vWkVSjt9tzOlMD9ioDzCqTgtE0n2rdoJh0wPEgm3E0=;
 b=MzrtW1mC+tbG4rvYpxNTNb4cMbFfIZ07yaP4yTStiy2YyeQmrnL0xsyojmEuGlYuaCNGeKm9On11X7u4LEpU/k/90FyKhwaDVab7cFjcgYEF2s4GbrnlDVw/lKUH79xKG4+fFn9KJkrS1o2lSOhxKgG5cV4rVGDOEV9fyDruU1aB7gff/jYyXfARWG94PnXuI2f6n44MXCrNaAXy9qvwW+fbPlqmbxFfrA+3BtpQJ5fSggQQG+53YPvnkygzsxKKJZMeiWWkV0qOFZM7rDYV40LZjJsA4zWyyqJVCiE2YsIjyiMDiSieOK7CxnkEJUAs7F4YjrwOvvKxnyYCbjSlow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4944.namprd12.prod.outlook.com (2603:10b6:5:1ba::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.26; Fri, 12 Feb
 2021 14:43:57 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::d6b:736:fa28:5e4]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::d6b:736:fa28:5e4%7]) with mapi id 15.20.3846.030; Fri, 12 Feb 2021
 14:43:57 +0000
Date:   Fri, 12 Feb 2021 10:43:55 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Chuck Lever <chuck.lever@oracle.com>
CC:     <linux-nfs@vger.kernel.org>, <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v1] svcrdma: Hold private mutex while invoking
 rdma_accept()
Message-ID: <20210212144355.GA1696322@nvidia.com>
References: <161308170145.1097.4777972218876421176.stgit@klimt.1015granger.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <161308170145.1097.4777972218876421176.stgit@klimt.1015granger.net>
X-ClientProxiedBy: BL0PR02CA0132.namprd02.prod.outlook.com
 (2603:10b6:208:35::37) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL0PR02CA0132.namprd02.prod.outlook.com (2603:10b6:208:35::37) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25 via Frontend Transport; Fri, 12 Feb 2021 14:43:56 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lAZfn-0077jA-4H; Fri, 12 Feb 2021 10:43:55 -0400
X-Header: ProcessedBy-CMR-outbound
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1613141038; bh=/vWkVSjt9tzOlMD9ioDzCqTgtE0n2rdoJh0wPEgm3E0=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Header;
        b=hSKnifMKlK3Ks1TeyNIQLk7XY/Ut8w+1z8extlO4pC+QrqfVZXvIEXXD2M5yK7QkD
         eDwUkoZ2XOrN10wT87m9cQHMetrX7BuHhGy2T9V8d5jPVoRQw48QC1Xmh26+1Sk9SA
         EnHb0rBhArFNmEYZrip4MsOd1jVXa2q4VPE4bdLwZMWYKxSiWqcIEgXk3UVhJUYwYJ
         4tpFx5AkuXm+K6tr7VfTqJ9S4Mupo+eyDG8tc1sVK+kdqqC8IMaXwvllUA4fAEDMtS
         0CAfkZNQ215vqrdTkFlM/uN0tzva8wAQkQ+szT4Q/JBMCTUN+uqXfegB3JEGJoQ1Lt
         tIk9ozu42bkHA==
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Feb 11, 2021 at 05:15:30PM -0500, Chuck Lever wrote:
> RDMA core mutex locking was restructured by d114c6feedfe ("RDMA/cma:
> Add missing locking to rdma_accept()") [Aug 2020]. When lock
> debugging is enabled, the RPC/RDMA server trips over the new lockdep
> assertion in rdma_accept() because it doesn't call rdma_accept()
> from its CM event handler.
> 
> As a temporary fix, have svc_rdma_accept() take the mutex
> explicitly. In the meantime, let's consider how to restructure the
> RPC/RDMA transport to invoke rdma_accept() from the proper context.
> 
> Calls to svc_rdma_accept() are serialized with calls to
> svc_rdma_free() by the generic RPC server layer.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

Fixes line

> ---
>  net/sunrpc/xprtrdma/svc_rdma_transport.c |    2 ++
>  1 file changed, 2 insertions(+)

It could even be right like this..

This should be inside the lock though:

        newxprt->sc_cm_id->event_handler = svc_rdma_cma_handler;

But this really funny looking, before it gets to accept the handler is
still the listen handler so any incoming events will just be
discarded.

However the rdma_accept() should fail if the state machine has been
moved from the accepting state, and I think the only meaningful event
that can be delivered here is disconnect. So the rdma_accept() failure
does trigger destroy_id, which is the right thing on disconnect anyhow.

Jason
