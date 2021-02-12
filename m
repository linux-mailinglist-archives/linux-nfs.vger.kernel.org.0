Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A41E31A0F4
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Feb 2021 15:56:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbhBLO4F (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 12 Feb 2021 09:56:05 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:7561 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbhBLO4E (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 12 Feb 2021 09:56:04 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B602696da0002>; Fri, 12 Feb 2021 06:55:22 -0800
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 12 Feb
 2021 14:55:21 +0000
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 12 Feb
 2021 14:55:19 +0000
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Fri, 12 Feb 2021 14:55:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c9Gs2Kpn3aO8zyYqLBxd85Z2Xwpbdl6+orE6A/6loyzA3artswiLsLcbsrTElAcxEIv5jcfW2+YrASyNNFgy83XXrGaJ+84ShfCA5jyBuaLB85wK9f6E4O3hZIh4zkuhQjef5bBzkFjitwzKD0jHJQYe+xTy0iMPVSdhJ7OBQKq+l2WUK5D1zKeikQdSekFVVBzmeGOet8f6jqTjhTrAAyLz+i+79h4cbS4LnOxXUq1cO3kWdONmnJbotuaXqz6I09RjixNdhwPhszlshLIrbcky6RNlopMgCVl3IvuoqwcecalOsJKZ9B7LYUXvkiY7joVnKlSZCwwx2kP4HVlTRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zHCtDwwctYBHDBXITygFI3ROSz0mflR76UfRSUvgrxs=;
 b=CrI46xyiRyEAdycMcGOysEjKgPdfu3gIUqJshe8JJMmVxwc94QTOAQ8RsyOv0mW6ROI0g98DQeNySxooU9WChFBMWn0kSDmugbDuVf7ae3KFy4UpqLu6LsncDVkWOpUJ0X4SXADu3+Hh+79UsuY7kUpLvmr1t6jmtzpxZcneREDyvlQufr/HgPM6t4SljKPSgbh3adbyl2nGrxkfdT8owg3yO6TdG49KDFQKJs70IOJQVCbp/5Bw/AeDzykyN0aCrJmqOLJj472pdR/Yl982QhyvaqmQRHmqxuMog5TUgtDj6O3GmhCjsJBFCwmeau0smyGkG73c07JomZNIqLdlUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2860.namprd12.prod.outlook.com (2603:10b6:5:186::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.20; Fri, 12 Feb
 2021 14:55:16 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::d6b:736:fa28:5e4]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::d6b:736:fa28:5e4%7]) with mapi id 15.20.3846.030; Fri, 12 Feb 2021
 14:55:16 +0000
Date:   Fri, 12 Feb 2021 10:55:15 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Chuck Lever <chuck.lever@oracle.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v1] svcrdma: Hold private mutex while invoking
 rdma_accept()
Message-ID: <20210212145515.GS4247@nvidia.com>
References: <161308170145.1097.4777972218876421176.stgit@klimt.1015granger.net>
 <20210212144355.GA1696322@nvidia.com>
 <1103A656-BAB3-40C4-A935-3D432073AD83@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1103A656-BAB3-40C4-A935-3D432073AD83@oracle.com>
X-ClientProxiedBy: BL0PR02CA0136.namprd02.prod.outlook.com
 (2603:10b6:208:35::41) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL0PR02CA0136.namprd02.prod.outlook.com (2603:10b6:208:35::41) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25 via Frontend Transport; Fri, 12 Feb 2021 14:55:16 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lAZql-0077uL-9W; Fri, 12 Feb 2021 10:55:15 -0400
X-Header: ProcessedBy-CMR-outbound
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1613141722; bh=zHCtDwwctYBHDBXITygFI3ROSz0mflR76UfRSUvgrxs=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Header;
        b=kwb097RzGvj62oY2eMceIw0O8AwYmjD1OTOBVYpaMVXT1leW3b2y6GrhgmMsjQCvk
         M0a9MYsarP4KP/GuAWbU6t/h3qdz0QrS5hIDKSX04BHszH0pzI5V5uMXGMeMTcJ2Ov
         LYVUoRhsVo6NdPXAGNLxJGORkzvuMLpBgAgnTWlaHcLSm4FMXjFFzu6fW7uc44ezdT
         rXJXDfTdDU48RRNMORJCU6SD7KUFpTnWT1oH5Zs8Jq6pLh3BbpKLPsEWKI2cl8mDh2
         Cciz3opiaR2sjUtaJDim344Zg4ecERYKXAtFX49di7PCHn/M5b+Bbredr0JL3n0wfP
         MLApwNLbIDhyA==
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Feb 12, 2021 at 02:50:42PM +0000, Chuck Lever wrote:
> Hi Jason-
> 
> Thanks for your review.
> 
> 
> > On Feb 12, 2021, at 9:43 AM, Jason Gunthorpe <jgg@nvidia.com> wrote:
> > 
> > On Thu, Feb 11, 2021 at 05:15:30PM -0500, Chuck Lever wrote:
> >> RDMA core mutex locking was restructured by d114c6feedfe ("RDMA/cma:
> >> Add missing locking to rdma_accept()") [Aug 2020]. When lock
> >> debugging is enabled, the RPC/RDMA server trips over the new lockdep
> >> assertion in rdma_accept() because it doesn't call rdma_accept()
> >> from its CM event handler.
> >> 
> >> As a temporary fix, have svc_rdma_accept() take the mutex
> >> explicitly. In the meantime, let's consider how to restructure the
> >> RPC/RDMA transport to invoke rdma_accept() from the proper context.
> >> 
> >> Calls to svc_rdma_accept() are serialized with calls to
> >> svc_rdma_free() by the generic RPC server layer.
> >> 
> >> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> >> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > 
> > Fixes line
> 
> Wasn't clear to me which commit should be listed. d114c6feedfe ?

Yes, this is the earliest it can go back, arguably it should be
backported further, but the bug from missing this lock is very small

> > But this really funny looking, before it gets to accept the handler is
> > still the listen handler so any incoming events will just be
> > discarded.
> 
> Yeah, not clear to me why two CM event handlers are necessary.
> If they are truly needed, a comment would be helpful.

Looks like the only thing it does here is discard the disconnected
event before accept, so if svc_xprt_enqueue() can run concurrently
with the accept process they can be safely combined
 
> > However the rdma_accept() should fail if the state machine has been
> > moved from the accepting state, and I think the only meaningful event
> > that can be delivered here is disconnect. So the rdma_accept() failure
> > does trigger destroy_id, which is the right thing on disconnect anyhow.
> 
> The mutex needs to be released before the ID is destroyed, right?

Yes, noting that the handler can potentially still be called until the
ID is destroyed, so its has to be safe against races with the
svc_xprt_enqueue() too.

Though the core code as a destroy_id_handler_unlock() which can be
called under lock that is used to make the destruction atomic with the
handlers.

Jason
 
