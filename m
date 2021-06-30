Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1913B82CC
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Jun 2021 15:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234758AbhF3NZg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 30 Jun 2021 09:25:36 -0400
Received: from mail-bn8nam12on2130.outbound.protection.outlook.com ([40.107.237.130]:53459
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234679AbhF3NZg (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 30 Jun 2021 09:25:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fri3TzsgIlRkOUCMW86b/EAassulBqNhqoInkAQvt0LSAz9jdvn9z+o1FlE3OT3AO+hI9gZBD5u8XCp/Fv9d/HGhWzNPr0iAlziVKTeW91IzMTvunMVUNPSu+Q6e/ql1G/GmQyS184h3xyGk+QoN/6mPipDa1drTxyr3xHUWEH5vH7cWkDJ3Y5d9PDjhUfJIZFn3M1FVBYHX193SG0+fbNvQtUg18h9pXE/bCXea/pi8Vh4ngiwEouoogkYOFNOhlEFVZ/doyOHGfjFtQpGDx/fLo1dDQ5PtWCIleYLQwn1UHxPf26CuurLZTnl0ZQAiA6GflmGiFmlO96RW6UkYSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2cuDbEzhdywhvWbKZkL+1kn9Qbr46vXWeabjBExlKmE=;
 b=Y2jaMDlSrSFHn3ozgKDSu/AczMbMYQwUr/p6HZegsTD8Qni0ehigu0ckHlqaqPxsTadGO6EBKEPZFURKq6Vzaxz1f/II0R945+ApmbbZyu84b6J4hDCa0eNNXRVVN/5gVCYhKESZbpstdwtXhLRjUqgI78uNg5tlokmoBSr7NCujENcmfOwojCf2/ab1KHtXvvGQ99EYRV63nlMOjbDAaF7/ugEns7gEJ7GLddYbCiRt7cHjmDiWp3vV6kGOyLoVFw4tH0BYQ9383aZt8hgmKHToU2aigS4cGcgTQcQGO41VPyEjuEGZ5OrENWexcN5zq/DfksrkbmtuLJZvH1l9rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2cuDbEzhdywhvWbKZkL+1kn9Qbr46vXWeabjBExlKmE=;
 b=PSIRkvQDQ+UsVwgc7ERTzcEGyInZcE3AruTc4/C+MSgqE5fxKZ3v9iu9WoVwfMjqO9EgJRY/iMgAHTbni6TIVVt5Dn88Podb+0x21Ro38SUtGzebFT4e1k5cVgSmbWJp6L79tOW+UHB9cjAraEBrErplRO2A+vcNk4T8XUaoAJlKWNn+Vxe2NMM29EiJVT5u4IeBP5T+1IIkK4vvZU/Gy8Sm4w3tS27cxBs9aVZSdm5/RbwZUS3jyrIDByfpaYewvwG2EhdTZJ8fDpwf7N7y4Xd+u7bfjXMFvCuew9hH8Lw492f5DL1yQIeggQ0X7UvcDNPNCDCZtUq9H9BdxZo29A==
Received: from BN0PR01MB7168.prod.exchangelabs.com (2603:10b6:408:157::13) by
 BN6PR01MB2418.prod.exchangelabs.com (2603:10b6:404:59::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.26; Wed, 30 Jun 2021 13:23:05 +0000
Received: from BN0PR01MB7168.prod.exchangelabs.com
 ([fe80::f462:9765:b015:17f0]) by BN0PR01MB7168.prod.exchangelabs.com
 ([fe80::f462:9765:b015:17f0%5]) with mapi id 15.20.4264.027; Wed, 30 Jun 2021
 13:23:05 +0000
From:   "Marciniszyn, Mike" <mike.marciniszyn@cornelisnetworks.com>
To:     Chuck Lever III <chuck.lever@oracle.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "Hillman, Richie" <Richie.Hillman@cornelisnetworks.com>,
        "Dalessandro, Dennis" <dennis.dalessandro@cornelisnetworks.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: RE: NFS trace new to 5.13.0 (GA)
Thread-Topic: NFS trace new to 5.13.0 (GA)
Thread-Index: AddtE3KnceyIXtJFQ4q1p77amM2J2QAAn1oAAAHqJXAAJVAOoA==
Date:   Wed, 30 Jun 2021 13:23:05 +0000
Message-ID: <BN0PR01MB71681D740C603FB85A8B0C83F2019@BN0PR01MB7168.prod.exchangelabs.com>
References: <CH0PR01MB71539295AEF1947518073D0FF2029@CH0PR01MB7153.prod.exchangelabs.com>
 <A9DA4F5A-9BA8-4395-82CF-24C071AF1F8C@oracle.com>
 <CH0PR01MB7153CDA5ADFA9306044DEF80F2029@CH0PR01MB7153.prod.exchangelabs.com>
In-Reply-To: <CH0PR01MB7153CDA5ADFA9306044DEF80F2029@CH0PR01MB7153.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none
 header.from=cornelisnetworks.com;
x-originating-ip: [70.15.25.19]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 794feb4a-d531-4b77-96f4-08d93bca31f1
x-ms-traffictypediagnostic: BN6PR01MB2418:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR01MB241803B8F980F1199B56537AF2019@BN6PR01MB2418.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:651;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6wsFil4ROlq0W2hFkmIcEVQ0OYAHPepowUQKRERVX48pPAD7MvQOWDkBpvVp5gf8ehNgcQinr5eNWuJCROgL0wc74020WIbSWkT6W5tr0fGMHdfx1FLpdQJWbZy733nEEmzbEIE9tGGsJ4hBmHDS6lNrmXQxk8Nwk1dtuIideuz7b2rcGJWfBU3HcelGOBSPiPUbD6zYt4KurTqBkR+r2J1uYImPIUTOhpwu5w91a9bsYIjcabu2BbBriQ1HUTshSqcN6wh4MiVdsVY/nMMLuwyqcFzoPCo0mFgfcIHi7vF6PaD5/a2RliGwkFJCJKPN3nPzj3QgcNRVpyi+/yIs50fSV7j0/49r7aqXyM/K5kjCE0UOTWI4C/P0G3OU/1ykBuCdXnXrk1MCXIx46bC3fxByQ0Mbac662UfVen349aanftQSQwqScxWfD3ymDV13F/v0WRLQM/sLr5QWDrW7wvYkJNrXRUHlOBhARg0ZcpoMQ9wcHvxHa58nUe0ASig7elppKEZrOC8Jejrfqg7ZQsVxYV6vX+Uyy/LGmQMWBQXRXL7Dej4bP44Ob/3HFMoWlfjN7JTkJc5MNtuqzQtIGMpo8NF/GF02AemRrwv9XsDjsEYRT1OwyhYzv6sOkAMNEobBUn34DTepT4VnBqijSA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR01MB7168.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39840400004)(136003)(366004)(346002)(376002)(7696005)(478600001)(54906003)(66476007)(38100700002)(66946007)(4744005)(64756008)(122000001)(6506007)(66446008)(316002)(52536014)(5660300002)(76116006)(66556008)(8936002)(6916009)(2906002)(4326008)(8676002)(71200400001)(33656002)(86362001)(55016002)(186003)(9686003)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qwd1xKrmktG8k83zDKazefiZeReATAjCw+ExAOuRdt5hCPMNj9a0laOpnjK3?=
 =?us-ascii?Q?AVTaf3Z2QENER7o5RLop8f+MDbcAKYhswREWJvMv/D0EJbIDo4PYnMQumr/t?=
 =?us-ascii?Q?ioNWpchPMhDHRpVAsXwZXRGoz0IxK2veR1gskaZLF2ZCA3lHmsoo0Zc1LkB6?=
 =?us-ascii?Q?ruHM7bNc4L5jorT5IfpAYHn+lUjxvDmkidL7t9q3PxIn0mQ/kNCF0ywhE9PA?=
 =?us-ascii?Q?io/gdrNYQJkZnIEhvaGcRFp+mKr+v1Ywd7h2dEp1VIP2xyBBQnloLar5l1vC?=
 =?us-ascii?Q?EZ8ph+radREnh8dNvkn+DRpZh9mo7CNp8zbsdoydsK20y/6kYqLujTtvGy1n?=
 =?us-ascii?Q?KiopvPFplMPe9fXIrox3Jtq1N0XfwwPVCI4t7nGcv97SX1F/inxenYF2dJ2u?=
 =?us-ascii?Q?TcXAfLDWPrgcRu8HT/UaLAJsruQlk11FgjJ6HvnQ10gJxCnKN/KPpRzeg4dc?=
 =?us-ascii?Q?D9d127sYUjC1FhTM+gcpxVje1hpTxmZVAdS0XDqwfTrQulduDx+aN9GzKeYX?=
 =?us-ascii?Q?U1INR0u42v4omLHUHTn/yISHlI4buxNKhscLyyk5aN+6Dt8mZrCeic1N1czo?=
 =?us-ascii?Q?s/cL+AjIB1WuV3c7Hg22W7KzVuoK2HBSSfnyT3HuN+n/clkf6Mi9lUNYhGLC?=
 =?us-ascii?Q?RvayEbq78F5vHBMhTzYyZ9rKhVPIfghTCLtw5NJRZRAVCqeZmYXtJmbXrpQU?=
 =?us-ascii?Q?ibKokSZyzh85SWcpgA60Jn39aJ+RrnJ9IwbamJa8Zxm2Ji3Bxkt4hLHoU+lY?=
 =?us-ascii?Q?kUxM66a/PIsZPo7nnrV2X4R9TpUW0h9vPAG/dhnK+s3P80n916mByNTyI2nM?=
 =?us-ascii?Q?m6GGvLjr38WhGQgP9Lg5K0js1+f8IQgBCFj5rIdyd+DBeo4XWavg0bSU3S1b?=
 =?us-ascii?Q?oyi/swrTfufduMhR2lN9VTyeRBcitMP7e2M8Wy4I9phEXcUFEDQKGIMOy5j+?=
 =?us-ascii?Q?BeHQ3P96CEjlqc6q0776F7Ghz/B6cAxgg17XguMNz5TKEblmOBWBPXGYRyK3?=
 =?us-ascii?Q?qK2qpQcM0O7SQmdqPrmCX4FfBCYMeZn/nmJxAWTbYN0CfXNOx+74nrTVNbtD?=
 =?us-ascii?Q?/wNa+Rjg6rqzqa/aDnDsH2j0ufmQvr6+RoFiulmAeyt+8KIEfUbcskTtL3kv?=
 =?us-ascii?Q?YL16goYJ6GSpzqonWw6iFPZGaFG/FnOv1eE7jaqYTbLJWbI9KhEAYCpAJ/0/?=
 =?us-ascii?Q?T+wTnJSLL19HdVYM//3Dq63ySS8SJLGaxbzCk+7xM/tL+Qo5Io/bGSn+x3zM?=
 =?us-ascii?Q?LIGWcSjzAVwuGt0pQG9YBeK8v3MNYUetbL5DPg224UGqYL8em3ROGdGFRcm6?=
 =?us-ascii?Q?BWI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR01MB7168.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 794feb4a-d531-4b77-96f4-08d93bca31f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2021 13:23:05.2643
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RQwfRvA7xpqnBKyIoxZeBfRRUrtWoNkaT+5jfQVtyiaijmi5tntb5mUAHVFO6AZ4UGuA/wdh93Nflq+VN4V7Oyib6L7RIImBVHOr73LMj7lCIDb64dU5rmR1uRMhx6ES
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR01MB2418
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

> > The NFS server in v5.13 is afflicted by a late-breaking bug-fix to the
> > alloc_pages_bulk_array() API. It's been fixed in Linus'
> > tree, but that tree is otherwise unstable for me.
> >
> > Have a look at commit 66d9282523b for a one-liner fix, it should apply
> > cleanly to v5.13.
> >
>
> Thanks.  I'm testing with 5.13 + that fix right now.   Will know in the A=
M.
>

The testing completed with zero errors.

I also re-tested rc7 with similar results.

Thanks for your help,
Mike
External recipient
