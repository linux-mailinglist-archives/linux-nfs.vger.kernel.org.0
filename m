Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14B562FF51D
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Jan 2021 20:52:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbhAUTvv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 Jan 2021 14:51:51 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:55378 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726724AbhAUTvg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 Jan 2021 14:51:36 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10LJYh8j080995;
        Thu, 21 Jan 2021 19:50:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=JnWjQYdyvI1tvj48tf9ytpUvFCfOdgYSgQUg5F4y1xQ=;
 b=jPq3gm4hiAtqyvDJTdjnngen5r/Jx3xTPJ4UxGKOXfqrJIU/k5/qfvWmbao/H2S7G75j
 pmJpCAmxjhBbFrd7RaF0S4avfLwzopumITX+Jg9TDSkaievf7fPMk3nU65MGXAn34EHU
 1QiPtEyr7OUgPmkMKHxyJvocQljEqLbzgPqY5QmUdFbBOFLjaj6jPWwTsfwpLwplSx0R
 iskxAURaj7K5OmJjlwim8vCFVWzWgm5TJrIwDZ08hGvjmDklyv3CZPz5cbcalr+2DE3Q
 OrRmiDi3LMHDORDbKJMJA3VKICkuzqOXyTGht4sIuKHYsF+Ike/Ce87+tIUixTJydx7u 2A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 3668qrh3bx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jan 2021 19:50:44 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10LJZlK5148188;
        Thu, 21 Jan 2021 19:50:43 GMT
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp2051.outbound.protection.outlook.com [104.47.45.51])
        by userp3030.oracle.com with ESMTP id 3668rfjcdw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jan 2021 19:50:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ki8G+E3AgmRLgT4TfC3OiBsNNJPQrd2BmlLH2Ouw/NCSbURjWitmDSMxcfkk5oKO9FQrIs1+zz5LjkYYUFJOrzWV/fyYl5YoDnO7u3pAQS2/yVluUDfHkj1zumN/s9FDsd3qwoKoqygsc9uCxBzklUD4B6tUicqo4Vb9+qjG1p5GBdbpjyI6tJ4vuc5ir1fWIRUVD8EAGztQPBQTSedwgjQvH3zRv1TN9Hcf+p/r2MdXKoyMtiW57uplWHIIPYKweHl2cLj1leEgKQeuXivutaT1uiXjvnc9O2tEEG+KuEIV4sS5Goy3XYqOKRssG44zJPIcU4ixnJckK/bArnVN9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JnWjQYdyvI1tvj48tf9ytpUvFCfOdgYSgQUg5F4y1xQ=;
 b=ee2gJVY1eZEPCXL71Nont1Y6J0SA7ZgfPMlyg7tF4byJtwMOigsKWIURSkEBF5Al/VxGAoOARGbGKQuhFzCnzpEO7AFeBx+zfGGMsO1doScaj+NzwCuq/pMvg+3ezKFGOM3QoghM5xZwDZbrpw4J5pxuI89Y0wEKY+GGAxIrV8sxIS+J7MpVZf+i3Bux0Yvoh4TOa0xESs6+SaBBT6wgajnEaCQfUY/bdTqBHXkVMjy8OUB5dO3vPFueIT2OPJFTXroklLSW7pfIBj2w1KfKkE40VMb49lQoJksSv/bkG2bGD8+uqpB4vTkSJ73ArG/2qHY+1/6N2IwNvGmIrJ8cfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JnWjQYdyvI1tvj48tf9ytpUvFCfOdgYSgQUg5F4y1xQ=;
 b=AotQ7vsG1N1a8F6l8cNfdyQAI02OOo0xJvN9bjVZHe3uhdKwa3G/vGWAU2D/KCWk58khlhdjvSBij/pbD32si+eCOLypsv/Q+xjEFgcF+Z6rdZGAGU33Od1GFWmp3QgSdim6rDz5eW0FOxrW1HYs2/U8jjOm//6zNeAKp/jUVbQ=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by SJ0PR10MB4816.namprd10.prod.outlook.com (2603:10b6:a03:2d3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12; Thu, 21 Jan
 2021 19:50:41 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3763.014; Thu, 21 Jan 2021
 19:50:41 +0000
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Dan Aloni <dan@kernelim.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Subject: Re: [PATCH v1 0/5] NFSv3 client RDMA multipath enhancements
Thread-Topic: [PATCH v1 0/5] NFSv3 client RDMA multipath enhancements
Thread-Index: AQHW8Cl9IG112JUQD02BlwhpBNKYzqoyfREA
Date:   Thu, 21 Jan 2021 19:50:41 +0000
Message-ID: <55B302B4-7202-45A7-84F3-8F33A79C138F@oracle.com>
References: <20210121191020.3144948-1-dan@kernelim.com>
In-Reply-To: <20210121191020.3144948-1-dan@kernelim.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernelim.com; dkim=none (message not signed)
 header.d=none;kernelim.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 93071ba9-7299-4dc8-ac1a-08d8be45d54f
x-ms-traffictypediagnostic: SJ0PR10MB4816:
x-microsoft-antispam-prvs: <SJ0PR10MB481610977078C90629383C2393A19@SJ0PR10MB4816.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /6QI3UE8BNLAnxrzaFYBMleCqdsc3hUmp+QSlHmeXVhclNcUdAtyKhGmCc2zCwmMEp8HuHshVtOGAqj90OyMPhtoS+ULcYOjFwJl2716dHzmmyD69t22F6fFtq/BwjfxQGwpF+AVtKeT+ihPY5Csnpe3rmEE8x9126ydS+DLoPNVmzaayAnS1M3hlRNZbMTl6sugub/gq/V/E6Cshof7VrSL0MsOGIqIqiWVvzuZ/tVIv7r3VzLTGmOPQXLvh11kXUIOIexkTdvls1l/FjtkHNmVSDma08CLtNLANDjq4YEWXxIznX9fPu+dJ1DWYLkM+XU/z0H2R5iOgNC6deTNYma1DVhYPnNWfTuufcXehhsLpjrJ1UBqVtsuns1TlCOeZULIodlR1p7tgdguOdeepeLUHtKvVq0rrEXcp5THcILz7JrTnLrqfjNA/lON2XLSts23phCiA21UpCwEZgKsWc2KE6shMEjiGiEHj9MHz4eOSks76HVatmf4lo1sjtHWoQczrGvuum386hMDHbZJCc9tM6dkHGty0LzUtZML40EKeOBLGpkoI+E7RSfiINvL4o4spGwrxtfdpFfIjfwlGviMbqD2VbimgL78BGgtKsVPqWL9tgJrKccxPMdcxgGJX+BjgOOy23ZFciw6Kt5pXCInap8Y8AQKCqEaFNhwzqQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6506007)(6916009)(53546011)(76116006)(66946007)(4326008)(44832011)(66476007)(498600001)(64756008)(186003)(91956017)(66556008)(26005)(66446008)(54906003)(6512007)(5660300002)(2616005)(8936002)(36756003)(2906002)(8676002)(6486002)(71200400001)(83380400001)(966005)(86362001)(33656002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?g8fTBJOEG8Y+BoyMP5pZxc5MGReGpTY0j2yUU+m9NFr6EMh3HwYQxPT346l4?=
 =?us-ascii?Q?CDZb8MWdCmbuyZR8lu6ZcMZ/hJd0c/MCdjzvleQX5+rZtu2VOoMTQHH8uWiT?=
 =?us-ascii?Q?Rg94etKvVJpRp1kJxdrhd3X5XK7ss+Ju933fwUa8v8NlvaKFYsixQeWzWnND?=
 =?us-ascii?Q?vQiAhjLiYVf65J+nBmrmJnMXNRLPsSzLDFuaHL7DfeSbCMAseDy4uuSwjZwP?=
 =?us-ascii?Q?lEHeC664/fFtss/KyUMY2tTDBNAekMRiw7Ibfl4GpADGs41+qfJCtJByGJrA?=
 =?us-ascii?Q?OmgnFNYPkVQXH9QjNyycko6PyCSg18PXiyt8CY7YTAwjc1t1oe2CJFDgKS9Q?=
 =?us-ascii?Q?C/063Uw1yzhTeISm1P6RLPkQUcvHwhHbaOY3QotFzwTR3OK7a9/RfH8e+exz?=
 =?us-ascii?Q?JfgZnFY3witn9WUuSlS2dARKruOobPp/AZZYCjE8UhjeuaOjuenDKTgMh/GA?=
 =?us-ascii?Q?DOsBhy72lyMPYj/H4kKht7NuzX3562cjlRh1td1JncspHl1RApTCskPeK8XU?=
 =?us-ascii?Q?mAEAmGFqaEbKnrEdw0skJzlvAQYxC1SAFlXswO/RBLeJ/6Rx8GZJxRmG66LN?=
 =?us-ascii?Q?SdQadJjeEnJNasccIthNoeZl8xPl9k7gEP4bXKgDNQituZm3lkx+Pyo1wVlu?=
 =?us-ascii?Q?1UJT6DSCqHYA1mTQfJ/jBXpb9Ruo0csVOxQEsee3geCLogx9wOVWifyxMzug?=
 =?us-ascii?Q?1udexM6H9IUXl49MDsJgMNm5/3tLVO6UHluEZBY8X8eTEGh7Ydi7K+1fiXWC?=
 =?us-ascii?Q?l6S0e6ZQcyFDQ4is/UuMCvsqxVELL8g3LM53cbSbCbdaCT1Byzh5wsU77d+3?=
 =?us-ascii?Q?19BC2AB8HPtYjIPuX+R/PZk0TlVjG4stAR5HyJFiF8SXV/xExtw0/i5GCkX9?=
 =?us-ascii?Q?SxVn5wSO41IBrR/U9Ev5KGXChAGHOKdq0Fhl9jWSpHlPkln3YQSA1ajItrXo?=
 =?us-ascii?Q?tQzK32rp1pcREM9NW3v2DPpbgEQaETPi/v9ckXX+G/xq9tF+XEZih23Itu4E?=
 =?us-ascii?Q?gRF0?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <802EB65FDE7C1D40BC952896450A0639@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93071ba9-7299-4dc8-ac1a-08d8be45d54f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2021 19:50:41.2619
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rylWastkPmnt3dtHWbCUNFMQuDZLs0iGKRfE+nqz/aAai/vhXBYBYom1iWnLYXdP9VmYEG/P6AIemb/nhMMzdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4816
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9871 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 suspectscore=0 phishscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101210100
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9871 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101210100
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hey Dan-


First, thanks for posting patches!


> On Jan 21, 2021, at 2:10 PM, Dan Aloni <dan@kernelim.com> wrote:
>=20
> Hi,
>=20
> The purpose of the following changes is to allow specifying multiple
> target IP addresses in a single mount. Combining this with nconnect and
> servers that support exposing multiple ports,

"port" is probably a bad term to use here, as that term already
has a particular meaning when it comes to IP addresses. In
standards documents, we've stuck with the term "endpoint".

I worked with the IETF's nfsv4 WG a couple years ago to produce
a document that describes how we want NFS servers to advertise
their network configuration to clients.

https://datatracker.ietf.org/doc/rfc8587/

That gives a flavor for what we've done for NFSv4. IMO anything
done for NFSv3 ought to leverage similar principles and tactics.


> we can achieve load
> balancing and much greater throughput, especially on RDMA setups,
> even with the older NFSv3 protocol.

I support the basic goal of increasing transport parallelism.

As you probably became aware as you worked on these patches, the
Linux client shares one or a small set of connections across all
mount points of the same server. So a mount option that adds this
kind of control is going to be awkward.

Anna has proposed a /sys API that would enable this information to
be programmed into the kernel for all mount points sharing the
same set of connections. That would be a little nicer for building
separate administrator tools against, or even for providing an
automation mechanism (like an orchestrator) that would enable
clients to automatically fail over to a different server interface.

IMO I'd prefer to see a user space policy / tool that manages
endpoint lists and passes them to the kernel client dynamically
via Anna's API instead of adding one or more mount options, which
would be fixed for the life of the mount and shared with other
mount points that use the same transports to communicate with
the NFS server.


As far as the NUMA affinity issues go, in the past I've attempted
to provide some degree of CPU affinity between RPC Call and Reply
handling only to find that it reduced performance unacceptably.
Perhaps something that is node-aware or LLC-aware would be better
than CPU affinity, and I'm happy to discuss that and any other
ways we think can improve NFS behavior on NUMA systems. It's quite
true that RDMA transports are more sensitive to NUMA than
traditional socket-based ones.


> The changes allow specifing a new `remoteports=3D<IP-addresses-ranges>`
> mount option providing a group of IP addresses, from which `nconnect` at
> sunrpc scope picks target transport address in round-robin. There's also
> an accompanying `localports` parameter that allows local address bind so
> that the source port is better controlled in a way to ensure that
> transports are not hogging a single local interface.
>=20
> This patchset targets the linux-next tree.
>=20
> Dan Aloni (5):
>  sunrpc: Allow specifying a vector of IP addresses for nconnect
>  xprtrdma: Bind to a local address if requested
>  nfs: Extend nconnect with remoteports and localports mount params
>  sunrpc: Add srcaddr to xprt sysfs debug
>  nfs: Increase NFS_MAX_CONNECTIONS
>=20
> fs/nfs/client.c                            |  24 +++
> fs/nfs/fs_context.c                        | 173 ++++++++++++++++++++-
> fs/nfs/internal.h                          |   4 +
> include/linux/nfs_fs_sb.h                  |   2 +
> include/linux/sunrpc/clnt.h                |   9 ++
> include/linux/sunrpc/xprt.h                |   1 +
> net/sunrpc/clnt.c                          |  47 ++++++
> net/sunrpc/debugfs.c                       |   8 +-
> net/sunrpc/xprtrdma/svc_rdma_backchannel.c |   2 +-
> net/sunrpc/xprtrdma/transport.c            |  17 +-
> net/sunrpc/xprtrdma/verbs.c                |  15 +-
> net/sunrpc/xprtrdma/xprt_rdma.h            |   5 +-
> net/sunrpc/xprtsock.c                      |  49 +++---
> 13 files changed, 329 insertions(+), 27 deletions(-)
>=20
> --=20
> 2.26.2
>=20

--
Chuck Lever



