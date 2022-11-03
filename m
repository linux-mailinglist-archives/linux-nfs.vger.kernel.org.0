Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE5276188AF
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Nov 2022 20:22:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbiKCTWz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 3 Nov 2022 15:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231842AbiKCTWf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 3 Nov 2022 15:22:35 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 096AF248F4
        for <linux-nfs@vger.kernel.org>; Thu,  3 Nov 2022 12:19:55 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A3Hx4as007205;
        Thu, 3 Nov 2022 19:19:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=CkvdZBiniVob2Wuom5LmgEhtpXwE2xtN9vFKtTJeA+E=;
 b=kJL50MWndDY1j8XMbSGIlqRrovtaMTPW1jqbQ7UpIcJUd9eeUllebpwomM/KD7X+iiGG
 jfQ5kMBPSBA8szZpbQeQQusH/zGxt9EhKwo6i7SWzEgrJlNdGbDd1Ib50HZRWZzXXVHe
 2DOOhXg2ThU/Gu3aFyg8Pc/Ssx2nXSlYKLN8udWXwsQWiiXqmKtrj1rrnxUuVA3bds+5
 oRDJaBEebgLmyx+qRDlLJGHgx/p4M20G4udPhtM+QOKYrmYWwQrWkV3n76P5Nu+sLCS+
 QcDSP+KLNq6CILEeX2GvF9WkjWY+UMuYK9tU+75UHQ2vdh/YbKqZHWD7F+AlMvmhM57f Mw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgts1e6c4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Nov 2022 19:19:49 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A3H2cX6009624;
        Thu, 3 Nov 2022 19:19:48 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kgtmd2kuj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Nov 2022 19:19:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GEZSVaIQs93tdjKcjd5THWjYo+gLievC7iCzQK9ZEib57mVDVVx2DXRCpbTCm9x1eGpzMFwlpRudzkjAULROIt73WahBjHC3GVoQMXxw1bYDTzW6U9ncvqfuph0EJxxgqXvO8/bddWTHd6p5Hg04SYKgH5448RJso46QBWnHlzOxakYPaXJF40m7x5qzRl1dr7CjwMsvF4AxgFBe9zcW36y220AYwuj228Tvukr8s1Q8aN+lwqoM+7LE4g0Q0gLjgIddjRkfQXtUW23fz/4TUqdKy83pxN9OFSRLFLSfylRFqt3WMLIC4IW1KmjTlOgn/v84zv9nylREL3TZZ48QDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CkvdZBiniVob2Wuom5LmgEhtpXwE2xtN9vFKtTJeA+E=;
 b=M45EzOwhR5htDpGl45MXk2H79MkRZgpDzWq4Se4kPm1MIiuvPkVt+8fm+wgTQKMc5ANSODIS3CpnesvOhpIvYfkhGl7IwyPafzHESSjnpDDJzuM3Ztak3QKMW4fsdRSO5wcWQVBXKzcstgIU5/NSMFxNomA21SQ7RJlvzsPYuX3lkHe1bZHVp77Qin+pCIWlw1jhb4rLEs2ScjR2OS/SURkDRFBGbMjNcUbPHLFMMEkMN4gOtLMN/irC+NS5aAFz5GCp2OI9R3+TB1xRIjtiAE4Cor3xiaCCVXalF+dw1ccYknCp6tRPAAVhiHwzNnXeqkvmxEOCqf9Ckv7vwdjuSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CkvdZBiniVob2Wuom5LmgEhtpXwE2xtN9vFKtTJeA+E=;
 b=nMCOaounO5JAU2mCn90alAGli7oL8eURxC64svIVifNhyGTq79h07njRkooRVS6dM7hbDuApu2RZO/JGu9c4lARmtyopbFy+2s08GRMLzIwTc5+0z3EtSZKyVRLxSfoMxCOvJ3SekZPcWDZwbFjaIJW1nhWIih51j/U30IYdbnA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BLAPR10MB5380.namprd10.prod.outlook.com (2603:10b6:208:333::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Thu, 3 Nov
 2022 19:19:47 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a%3]) with mapi id 15.20.5791.022; Thu, 3 Nov 2022
 19:19:46 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Neil Brown <neilb@suse.de>
Subject: Re: [PATCH v6 0/4] nfsd: clean up refcounting in the filecache
Thread-Topic: [PATCH v6 0/4] nfsd: clean up refcounting in the filecache
Thread-Index: AQHY7us2x4AE6NdJ9E+wA555QW0aUa4tlKCA
Date:   Thu, 3 Nov 2022 19:19:46 +0000
Message-ID: <5952CF99-C6B4-4CFB-B518-395FF597344F@oracle.com>
References: <20221102184450.130397-1-jlayton@kernel.org>
In-Reply-To: <20221102184450.130397-1-jlayton@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BLAPR10MB5380:EE_
x-ms-office365-filtering-correlation-id: dd91bb3a-d0fb-4996-2764-08dabdd05edb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l2qczfQYhkKpbhBkLB9MGig+5hKjjsSJ6VpVDNwULuTv9PChKd8g3I2t+ljpUFI1nP0GA6Xhue8XH0gvJsn31PS05DWEJn2sCN1pqOFkbFnenzR5OTuXHkbzQV4XM6wyJj8ao8ck0j75W9sguVWn3somD+JgdYVJo/YRcpa/kWFELB+4wL6on1eeSHCvquKHyEj+CJd82XMJ5k9HyB6A+RWYmNM3OepO6/pP/SYHf7HV5/MQrilBqEmsu6lBDSjlaB7Y1OMj7bhAwylkUADiUibe+opZAlJxnYC4SDcEOzEqj9VxEQFrPmV2FEC7WvH7Aknb9OUX+28Dtz4X3r94clie4Xz43Pwp5zRPAokuAn4IBgFhh8awciNa0KQtM3LVqDSvg+DgaUZ6Xn3gD6OPRLYTW9detf2w1INfplxp+AxMkdpCsVAeGJ9riGJr2VQ2vlnK05BzMvovlMKg9sInO06J9yUZdUirGSAGHWdRQsBDq9jmHdFOl87qVrCqqZA4/VkfBj76nOSDg4TYPe224rgBlhknCdM0XDs7qYoTBvCbJVe/w2VvVLjZxe6CyivCnjEyW5PN1UScbKrq3H5dreitYAvwF69VDoQ8sFJmu0rQErge2/RmcNuRXVbYPT29dU7DS2KIb3A3hfjSpWLWRaCdqHOmuIr2qD7KcU0FuSgLAwp1XxkFwNeyIRfmewEqvx6OQPeGVOJbvxdsSYFhClR6FNBcO3/4QsboGa+5hvqPTEnbYSXXQHY6TPu2hn+MZxSACiGLB6mqPBFY3smsW1ftP6BE9JVsMxeGy+1v/FQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(396003)(346002)(39860400002)(376002)(366004)(451199015)(86362001)(38100700002)(2906002)(316002)(122000001)(6506007)(6916009)(186003)(54906003)(33656002)(2616005)(38070700005)(66946007)(36756003)(53546011)(91956017)(64756008)(76116006)(4326008)(8676002)(66476007)(66556008)(66446008)(8936002)(478600001)(26005)(6512007)(41300700001)(5660300002)(71200400001)(6486002)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rvsFpmHzE1GCrGj1hRIgpE7m+3rB7A3f57ZmOKO6gLFII0fQZvfQMP+GvvkX?=
 =?us-ascii?Q?o7rRsNfFBt1LdX4TNnVqimKTwp4jKYWKHhbvgwSuO1ExnEKDMvsZ32dzo1xA?=
 =?us-ascii?Q?DFBxDz9FYyzl+yx86gx1DAx+P5lKrrdvt5MvNdGJpXnQHqi4sIwDfhF6kXG0?=
 =?us-ascii?Q?tfcSeiu/+rxOGZt2geIiKwZjMIwsVp1bfrxYncHFxHauxWeAPJHfO22bR1h0?=
 =?us-ascii?Q?copX+xxj+bf1rBVzNCLVt9GJOErkmx5TEwwJbERY4xgUlnVkLWLQI8yMFH64?=
 =?us-ascii?Q?M2mXhUqLIXVdCaf/lh8qldq7gyZ21p3IH8aD1dTl/B+dL3WF/iHu9dHlQX+O?=
 =?us-ascii?Q?YgAPLADiQVTkrUiF4/UngtL2PLj2py4164BGVLwyYGVsybJYX1TOzxSK1O5+?=
 =?us-ascii?Q?i8r03bSmYWYZSpIkSOJhnrj/ZFJhRJMc/77d882Cny/TTIymMkqLeHNd5AqB?=
 =?us-ascii?Q?5ZKXlzgYOaHkFXfu8/XdtyqrZU4+Koo28utaMQVFES4wym3P7O7wAYQebEva?=
 =?us-ascii?Q?HNywA/rMUV5NAGTtwjBeQu59rUHrFQtjfr1/cdKMAGWvsNkrKzpQjqPhO1Vt?=
 =?us-ascii?Q?ufzc3y8oPGycRxFmhXRuI9R2Fjn8bXwP3RJlaSkSHki4iIvdxOiGtHYXNNAY?=
 =?us-ascii?Q?hGx9LS49eSqW4Y2iYfCui2SdV8WKwcl6+u4tlXGYlz9Aj/4oqEnOoyC3F8r9?=
 =?us-ascii?Q?/MYzohNXIAsj9UJB/9x0mlAounOhoNogdSrfsuaIM23YGzIfbJiR9UNMZpWL?=
 =?us-ascii?Q?2OClXY4dOZXZASbxlM7/ZI1+Q5ptnJdR/AmU8ND4dSVN39zUw3g+T+DHGd9V?=
 =?us-ascii?Q?qaLEOoM2Ioz5Is+XwM+8RetXwYL41+fpWQPkyDaxFGYYbg55lOFsbB57oK70?=
 =?us-ascii?Q?YAGOH05RK7J4CharSrxzr77WwJta0mF5Wnfu6s+GRDYGcTTnL4fmWtI/RikW?=
 =?us-ascii?Q?hcgaUHIsyBJHMc2XUzigQYbh0hARZXBG+RxH30w5U0QUxpzzt3VPv+Yr0iXf?=
 =?us-ascii?Q?pgyBa/3PKko0imE7O9cvSA4A0tk6eS7k4iq8o1Hz7yZBvtD3n912OX1/uE/5?=
 =?us-ascii?Q?uafXEIgOLI429Bc8vQRy4iFGF2UMGdM1tR1Dcizzqr0RVI13fkbuBxf39Zg9?=
 =?us-ascii?Q?OgN4lK6P8234AeqtmHNGDXg2/wWbzDkHnlU/1ggyn5xln75yAFGQf+y+CpIy?=
 =?us-ascii?Q?EfIw+uXJD58SsypvB3f8jNp8YG1e0W6fxEM+cVjiu5fd/nKrLAEoe0Y4jSLw?=
 =?us-ascii?Q?v0rgaKNri7Yp4uwejX/8QAAXZKj2sDY8JBXLv9POPz4ymnrlwN/dGwq8kxJj?=
 =?us-ascii?Q?aOCOWI75JmwbpoSUxR3wF598/7v1qLwZGKd2Sx7vbGO7UJ1izbJ2Y8tJH+w4?=
 =?us-ascii?Q?wChcr7uxhD8Ya3wHneORgAeU70rUCKrlpKVy7bsadKDmKmb83FzxGkGecPhT?=
 =?us-ascii?Q?Jn9NVhpFb5O9pyyEDl2ULwGsZ3Pwn9v91Rc/OXLvulM1GcrU4EwzjM/GBk3G?=
 =?us-ascii?Q?eRotZhKVu18AMdVy0ezT/hMirjbv7l67mGGj1mc8NhwdPAZH6l+8w+/5xNSW?=
 =?us-ascii?Q?3K7t+hqsvlPHGtxoWATE5z+qXAYVvUbRVxuBt+gkdWZ84WA9sTNkIJYrtOR7?=
 =?us-ascii?Q?Gg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0236AA3762AD964C8BEE60C681F89C60@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd91bb3a-d0fb-4996-2764-08dabdd05edb
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2022 19:19:46.8301
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3cI0Y/h9iecDsFYVaLw0GF93kS+vTmwP0fQL74aJe0K6t1gGeh/SZlJVpPSZCa+wSXpLC4UYKuXckrxDjvoVKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5380
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-03_04,2022-11-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211030130
X-Proofpoint-GUID: M8MvEZFyCnIqyrzw_QhxD8mQyVlgyZvI
X-Proofpoint-ORIG-GUID: M8MvEZFyCnIqyrzw_QhxD8mQyVlgyZvI
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Jeff-

> On Nov 2, 2022, at 2:44 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> v6:
> - merge the LRU handling fixes into the refcount fixing patches
> - call nfsd_file_close_inode from the notifier callbacks, which
>  decrements and queues any objects to be freed by the disposal
>  workqueue job
>=20
> Only two main changes in this patchset. I folded two patches together
> to avoid a problem that Chuck hit while testing. The other significant
> change is to have the notifier callbacks use the disposal workqueue
> job instead of freeing things themselves. Those don't need to be done
> synchronously.
>=20
> Jeff Layton (4):
>  nfsd: remove the pages_flushed statistic from filecache
>  nfsd: reorganize filecache.c
>  nfsd: rework refcounting in filecache
>  nfsd: fix up the filecache laundrette scheduling
>=20
> fs/nfsd/filecache.c | 406 +++++++++++++++++++++++---------------------
> fs/nfsd/filecache.h |   1 +
> fs/nfsd/trace.h     |  11 +-
> 3 files changed, 222 insertions(+), 196 deletions(-)

Tested and applied v6 to nfsd's for-next. Thanks!


--
Chuck Lever



