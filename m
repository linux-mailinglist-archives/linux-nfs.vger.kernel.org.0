Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B74C4BC241
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Feb 2022 22:39:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235586AbiBRVjp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 18 Feb 2022 16:39:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235596AbiBRVjn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 18 Feb 2022 16:39:43 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BED925DA57
        for <linux-nfs@vger.kernel.org>; Fri, 18 Feb 2022 13:39:25 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21IIlct3014492;
        Fri, 18 Feb 2022 21:39:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=G2BbQreTouqvHX3zzZEMCAoOtLXBWS97FALiT986uO8=;
 b=pVr2c9DfJIA8f7BP8JdbwD7UuTkls1rvOHYFKIM5xZJfpiavzGP9g8a1+pGyy4jw9ORL
 24baOljc9+zFULeuiBZYp0eT9LXlit43xdATiptqtMYnEtLWIKsdPl7UGskbH9xbZegF
 06/KNnDJG599pAxd0ljeB8+T+TeqcCZR65dD3fuJKIc8Tgzr32ypJMmcy8jGVIQCpW+M
 2MZe+tk2dkVhS7gEpy8KOdmZSL/meqSwLUyQdv3N1BQ8VditrJfsNtLWpf+7sEJ0J5ZS
 E5l2kgb/UylVkD7dfrQZslahsfBfYcitci3bTZMRzJQqV7aGGj9VyJ8IuxuaHoeoQJjH Ig== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e8n3e2uge-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Feb 2022 21:39:20 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21ILZN8D029802;
        Fri, 18 Feb 2022 21:39:18 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
        by userp3030.oracle.com with ESMTP id 3e8nm1gjkc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Feb 2022 21:39:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MwmCS72eUw5KDXx0uwBDHEQwVmnID4NseAitIdP/UoCJ/8KNlDbMyVynHNqmUl576N8G+u15NwWSRgZl9SRLDLhIpa34YI7m4+vNSvrGzvdanvqMm9AG7hJ4rncdT6zK9r+rWX8v+VVEpBdjiCk4qVmvfAv8giMaJ/Jj7m2O6L6JAsGDJvSeUJx+cdK2bHYuNYRd5Cw3qLqlhQjlKyvocaRV4O7cMFEnmyS2Z/dzhYzDt3nE5Xx0v/jbGJ1AFagUFR4oKx/pOLIs+MyPZh+ewgCUHcrxXFJUKlDXDsh7pUlofmxGbmS2LN/TZjMbvPDa3Ik/133m0IHRKRdXltIfoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G2BbQreTouqvHX3zzZEMCAoOtLXBWS97FALiT986uO8=;
 b=kDyJFp5bfACIEGQogEro8J3j1hD5LBZjR8jsXCR3ieE51MyHB0da/UTPSIptsRSR08+mb8pyWHGapHlM7jCLUv3Q14uRz44Jyugd5voXbucjLhv1sX1dZDqktzIsCb0ecsFsJTZosxmQOHonGuuJegP8Hrf8xmLqlzM29bJdXQc6Z8nwF+CuxPZ1b/SydjbtCI/J28GbdZ84LcUXI8JP7nkIx/LBSIFEX4pHJhFfuzaCcn/n68JRXH+JfByLCFPlmWebxA4B7tJRp1Jyh2ZDRwg0jql9zJ34MgjH9Osw7zLDdZhy7HqmxGQJ/BnT7Re3TGRmqNJok1Sp5VruaKqKZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G2BbQreTouqvHX3zzZEMCAoOtLXBWS97FALiT986uO8=;
 b=WTIeHI5XPGUthxEd0YsNrhK4sDzsf/Tvt7bq237ZW4qse/Ul5hSo91IT0AML5IxP5o9/Q5JKSeXzYv8LvNl1QKF7jUG/F+ZX6Xp1L0oqCVqTGQr7fXFh68iy/asiDJiPtgBeZN+ZHFr9W+YVExYVqQ3aXRrWwj6R9I6mhNthJ0o=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN0PR10MB5320.namprd10.prod.outlook.com (2603:10b6:408:12a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Fri, 18 Feb
 2022 21:39:16 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::29c0:c62f:cba3:510e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::29c0:c62f:cba3:510e%7]) with mapi id 15.20.4995.016; Fri, 18 Feb 2022
 21:39:16 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Tom Talpey <tom@talpey.com>
CC:     Daire Byrne <daire@dneg.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: NFSv4 versus NFSv3 parallel client op/s
Thread-Topic: NFSv4 versus NFSv3 parallel client op/s
Thread-Index: AQHYHFU73YMeFauhOEOqtvI6JrMafKyLfu8AgA49EICAACfVgIAAA3UA
Date:   Fri, 18 Feb 2022 21:39:16 +0000
Message-ID: <66383037-8263-4D7B-B96C-C9CED24042FC@oracle.com>
References: <CAPt2mGMZh9=Vwcqjh0J4XoTu3stOnKwswdzApL4wCA_usOFV_g@mail.gmail.com>
 <6b528d29-1a9c-d16e-f649-5d994d6222b8@talpey.com>
 <CAPt2mGOnbN=N5TqCWzVtX7CYoptpknCbnSXGfoX8X87DsvhoKw@mail.gmail.com>
 <3849f322-94f7-fe73-4e08-1660be516384@talpey.com>
In-Reply-To: <3849f322-94f7-fe73-4e08-1660be516384@talpey.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4b85e3fe-a116-492b-c91d-08d9f3271d14
x-ms-traffictypediagnostic: BN0PR10MB5320:EE_
x-microsoft-antispam-prvs: <BN0PR10MB5320DAD29AD51030C532FFB893379@BN0PR10MB5320.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5Ut7h0RD1Qj+M5k2Z//i3qZhcre6INntD3IYvPKzEUWJfWVyZXIGKQWg+2Rzm+qJDudiFN8GmKh9z4AhZ5Lg1ltbaanJZd6OJPmwwpXTSQB/x4k47VLUhlQTQRJN9PF/ZvXsmdulZgstFSxm8dGjb2H6HZuCjK7mUbhxr0pr3irhtdpfrPpT5wYUVi/GUCvmAL8Ce84fqsRCg+WCLks8YzWIo2bY6sMgLH/DuyQfPBC3W1Fo8yM3RDCnHZcPmw7C0sE5ALcYy/WiFilyhdPCV/wE+cjTwk6KdGOVsun9Ls8uxyir6js7KvqZHYnrcePqkGHRhNqo3uE2aOZ4gKAGPwQ6EP7hve8FdsE+JKZBIAmN0fqbq5/7sTUdg/zetmcRNV1a7gdEjCL16LDd7c4zORC5ZyxVlzPIp2ibFllYx0JiL5G5qUZRcL3wrcnzogUoAolbRJyEOGq6n2dssm+I2ji0PzQ3HIEruwKkCkfrSyra68+asy75aU5d6awLd9On81wjak75XVtCJYB4q0nBgv420Kg9pbw1OCEIx7ZE1g1o1PDh8TQf/nrxUuux/ISUfwvEnIYdz0iLFWjm/h9gU1h3nUKlpHhNZ2LA5ooVlhTmLalm5TWD513zq6kdGTpZ/RWj8kzbs0XnLWkJsn5i/4iP1/OyZt7BNPIVruPWDwkv/5dRq57k++Gy3OK42b6Pgd6Kc5h3UZX/mza3FOtBt+J8n4/7Z1tWYmMTqRUcSsTvd4YCpCf8UN/1Ti4TXVKnfQ6/o2HqUjTaZI+BO6aNZC2a9IXlDNl8aS82FzEylfjmFgGOnfTB/IVfxZ4VatF02ClN9i+UPeJHVV/331CxsQs0Sv5sdxapbDWZHFoZ+mA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(33656002)(6486002)(966005)(83380400001)(86362001)(71200400001)(6506007)(53546011)(2616005)(26005)(186003)(6512007)(5660300002)(66946007)(91956017)(66556008)(66476007)(66446008)(64756008)(76116006)(2906002)(38070700005)(8676002)(36756003)(4326008)(6916009)(54906003)(38100700002)(8936002)(316002)(122000001)(486264002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ED/j4ZqA4+OEqpIGA7046NbjxWybKM21RWJ7SAk0V88ngWynwcMKg4Xb3I1R?=
 =?us-ascii?Q?6W20oBgFi3zW24oNJzB/tzvwCjLXTFYmfToZv5RXZ9fUrtpEKwwZYTSkKDsC?=
 =?us-ascii?Q?WudHs9m6q5DAa4LJKuxl6C+6t8qfhbac/uaDSvAgE8Hq4jdIaqgZUEY25/mD?=
 =?us-ascii?Q?2SYvzjrnnToWxBLmnTkcJr2d+FmMPVfwZDgEqgwgjvgWfFN3u5DVJlcnh0ap?=
 =?us-ascii?Q?49hJUpHP4iGHIUQ7abEYnW4o7Wcjqenp8kYNdwVDnbAMoprTFd3eObb3KSJD?=
 =?us-ascii?Q?uG17zlAGhojlDfvI2ud/Y+uElkJyBfnZ+6Ln+P3iKmRvhrBDwt/Sk7fI79Cb?=
 =?us-ascii?Q?4lxC2PcKqmPnQiRzLPqUCTdJZoXhYisK089uZpD32WiyzUb51hUs/oUlZOHe?=
 =?us-ascii?Q?0tY0+hAnl8ezPxMVpXDHHUGMJpEuei9qd1HrOAa+9CsNb7u5TF1faefSHS3x?=
 =?us-ascii?Q?i+B3HfTTDe+3XGoD8lCBKICr1UWp3QnTfoavuvKDB5i+wuBm4+mjkZwCUrSR?=
 =?us-ascii?Q?eFto6v392FgYkKj6wDV8jThERTULj+UMioZNBSvmr6fNOjtz1fItWb6+ZJDq?=
 =?us-ascii?Q?fSVgv3MQl2nGm4WWtprBqHxnBSXbeYLvxaovfGRcm49MV5fz6yYbFTvYZz9r?=
 =?us-ascii?Q?NxrRYUuTDtALZVsweiR8id5Ou88Q9wWbvIw6rEM3C0HI2QT90NHaszuTXU9+?=
 =?us-ascii?Q?iUXO0eG62HAle2mYAf9rfPxuv3EcoVR2oMlFBQe/9eCeWQRsPLITYH8NXZNr?=
 =?us-ascii?Q?Veo/VKqzjrXrnCLyu4jrW6GXqeMBWpzrYV01y7s6YDaKb1zYpkWYHdhCoDgd?=
 =?us-ascii?Q?NqhEgzy89N8OsRl/4So2GGYvwbffVDPi8/5tzE0Lu2SwdBW7oDkGoKOiQspt?=
 =?us-ascii?Q?Z6sscqSvb1GEmfR1YwsVceNCmQW07KzLOHHESLTyEbqxcRs23Ue/QBddi1zq?=
 =?us-ascii?Q?e4YG7qR+Z71R56HTQoTstvTwXFtxIdrdc8MkBS0eNAv6w2Iaini3z6iGL9pw?=
 =?us-ascii?Q?PkNejoR0NCMJM1PUgYWzaXZ0T3T+d/mgUhVFWhaGRoFj9uRGV0HJomPXtLed?=
 =?us-ascii?Q?3pZvLZV/lVktD1xOoMglbJFL4/QcRv/7dxM6ARw2K0T3MZ1944JB3VrfEOUs?=
 =?us-ascii?Q?rGX0lQVPz6mOU7ZpZbsxqGHxRIGzvnR/4MS1r9uyUCkRnJG99gLCAteupfas?=
 =?us-ascii?Q?mEkWoAPMBUfwlEyRWMHdMAodZIiw9xhRby7PiWu4f6wyY5JaHgwZSMF9AzqZ?=
 =?us-ascii?Q?6/IJAZbrcP12uS187gSd+dln3Qd1sYXfLjFCOQQSxjHSJ6Cw46RNjTau+xnf?=
 =?us-ascii?Q?H9jXuKUkMihrbtbWbPTHM3Daged/q7J0oYFyQQ+i+qmSNdSPTRePJcLTFaQC?=
 =?us-ascii?Q?3s2lc8iUTQRveZkpH5iGbLAEw4EvvTRjF3pOuhQ8WQHPSFJXv1Zn+FrxLzSe?=
 =?us-ascii?Q?HJUfizlx1JHoMVF1kb5RCWkH7l62mdVXUHvA34kkhTgSsQQjersRsAyJuS+0?=
 =?us-ascii?Q?/6wQOt4zIDHJng0NhgQWCBeQAB+DoC2XQLSzBCdyToNuN0BkrVrCZPI7P27t?=
 =?us-ascii?Q?VcALaslIsfEzeyty5xGOl900OY2osFbdsmGfAUO8Cn3LGIi4fGfADJ2cEuzJ?=
 =?us-ascii?Q?5hSqR5lUQehAxr8yIeaC89M=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <98CFD15F5736124CB2068B263F341A2A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b85e3fe-a116-492b-c91d-08d9f3271d14
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2022 21:39:16.4780
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: umQIpvb5baktfUC+QIBRIYZVNloUy5cuE9ykqrJvppADEW3goA6ehpdn1bxI1esxLX72ifPakXXlO/zwzBSCzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5320
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10262 signatures=677614
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202180132
X-Proofpoint-ORIG-GUID: ZTbTQE_5GexUpYdQUQGHDsxsV5AuEy6U
X-Proofpoint-GUID: ZTbTQE_5GexUpYdQUQGHDsxsV5AuEy6U
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Feb 18, 2022, at 4:26 PM, Tom Talpey <tom@talpey.com> wrote:
>=20
>=20
> On 2/18/2022 2:04 PM, Daire Byrne wrote:
>> On Wed, 9 Feb 2022 at 17:38, Tom Talpey <tom@talpey.com> wrote:
>>>=20
>>> On 2/7/2022 1:57 PM, Daire Byrne wrote:
>>>> Hi,
>>>>=20
>>>> As part of my ongoing investigations into high latency WAN NFS
>>>> performance with only a single client (for the purposes of then
>>>> re-exporting), I have been looking at the metadata performance
>>>> differences between NFSv3 and NFSv4.2.
>>>>=20
>>>> High latency seems to be a particularly good way of highlighting the
>>>> parallel/concurrency performance limitations with a single NFS client.
>>>> So I took a client 200ms away from the server and ran things like
>>>> open() and stat() calls to many files & directories using simultaneous
>>>> threads (200+) to see how many requests and operations we could keep
>>>> in flight simultaneously.
>>>>=20
>>>> The executive summary is that NFSv4 is around 10x worse than NFSv3 and
>>>> an NFSv4 client clearly flatlines at around 180 ops/s with 200ms. By
>>>> comparison, an NFSv3 client can do around 1,500 ops/s (access+lookup)
>>>> with the same test.
>>>>=20
>>>> On paper, NFSv4 is more compelling over the WAN as it should reduce
>>>> round trips with things like compound operations and delegations, but
>>>> that's only good if it can do lots of them simultaneously too.
>>>>=20
>>>> Comparing the slot table/xport stats between the two protocols while
>>>> running the benchmark highlights the difference:
>>>>=20
>>>> NFSv3
>>>> opts: rw,vers=3D3,rsize=3D1048576,wsize=3D1048576,namlen=3D255,acregmi=
n=3D3600,acregmax=3D3600,acdirmin=3D3600,acdirmax=3D3600,hard,nocto,noresvp=
ort,proto=3Dtcp,nconnect=3D4,timeo=3D600,retrans=3D10,sec=3Dsys,mountaddr=
=3D10.25.22.17,mountvers=3D3,mountport=3D20048,mountproto=3Dudp,fsc,local_l=
ock=3Dnone
>>>> xprt: tcp 0 1 2 0 0 85480 85380 0 6549783 0 102 166291 6296122
>>>> xprt: tcp 0 1 2 0 0 85827 85727 0 6575842 0 102 149914 6322130
>>>> xprt: tcp 0 1 2 0 0 85674 85574 0 6577487 0 102 131288 6320278
>>>> xprt: tcp 0 1 2 0 0 84943 84843 0 6505613 0 102 182313 6251396
>>>>=20
>>>> NFSv4.2
>>>> opts: rw,vers=3D4.2,rsize=3D1048576,wsize=3D1048576,namlen=3D255,acreg=
min=3D3600,acregmax=3D3600,acdirmin=3D3600,acdirmax=3D3600,hard,nocto,nores=
vport,proto=3Dtcp,nconnect=3D4,timeo=3D600,retrans=3D10,sec=3Dsys,clientadd=
r=3D10.25.112.8,fsc,local_lock=3Dnone
>>>> xprt: tcp 0 0 2 0 0 301 301 0 1439 0 9 80 1058
>>>> xprt: tcp 0 0 2 0 0 294 294 0 1452 0 10 79 1085
>>>> xprt: tcp 0 0 2 0 0 292 292 0 1443 0 10 102 1055
>>>> xprt: tcp 0 0 2 0 0 287 286 0 1407 0 9 64 1067
>>>>=20
>>>> So either we aren't putting things into the slot table quickly enough
>>>> for it to scale up, or it just isn't scaling for some other reason.
>>>>=20
>>>> The max slots of 101 for NFSv3 and 10 for NFSv4.2 probably accounts
>>>> for the aggregate difference of 10x I see in benchmarking?
>>>>=20
>>>> I tried increasing the /sys/module/nfs/parameters/max_session_slots
>>>> from 64 to 128 on the client (modprobe.conf & reboot) but it didn't
>>>> seem to make much difference. Maybe it's a server side limit then and
>>>> the lowest is being used:
>>>>=20
>>>> fs/nfsd/stat.h:
>>>> #define NFSD_SLOT_CACHE_SIZE            2048
>>>> /* Maximum number of NFSD_SLOT_CACHE_SIZE slots per session */
>>>> #define NFSD_CACHE_SIZE_SLOTS_PER_SESSION       32
>>>>=20
>>>> I'm sure there are probably good reasons for these values (like
>>>> stopping a client from hogging the queue) but is this the reason I see
>>>> such a big difference in the performance of concurrency for a single
>>>> client over high latencies?
>>>=20
>>> Daire, I'm interested in your results if you increase the server slot
>>> limits. Remember that the "slot" is an NFSv4.1+ protocol element. In
>>> NFSv3 and v4.0, there is no protocol-based flow control, so the max
>>> outstanding RPC counts are effectively the smaller of the client's and
>>> server's RPC task and/or thread limits, and of course the wire itself.
>>>=20
>>> With a 200msec RTT and a single-threaded workload, you'll get 5 ops/sec=
,
>>> times 32 slots that's pretty much the 180 you see. So I'd expect it to
>>> rise linearly as you scale both ends' slot numbers.
>> I finally got around to testing this again. I recompiled a server kernel=
 with:
>> NFSD_CACHE_SIZE_SLOTS_PER_SESSION=3D256
>> I ran some more tests and as predicted this helps a lot. Because the
>> client default for the client's max_sessions_slots=3D64 (where the
>> server is 32), I saw double the concurrency straightaway.
>=20
> Nice, thanks for the followup!
>=20
>> And then as I increased the client's max_sessions_slots (up to 256) it
>> kept on improving. I guess I would need to set the server and client
>> slots to be around 512 to see the same concurrency performance as for
>> NFSv3 with 200ms.
>> Which I guess leads on to some questions:
>> 1) Why is NFSD_CACHE_SIZE_SLOTS_PER_SESSION not a tunable? We don't
>> really want to maintain our own kernel compiles on our RHEL8 servers.
>=20
> I totally agree that it's reasonable to allow tuning. And, 32 is a
> woefully small maximum.

As denizens of this community know, I don't relish adding
tuning knobs when the setting can be abused or set improperly.
You'll have to convince me that we can't construct a reasonable
and safe internal heuristic that determines a good default slot
count value. (meaning: adjustable is OK, but I'd prefer it to
be a dynamic and automated setting, not one that needs to be
set via an administrative interface).


>> 2) Why is the default linux client slot count 64 and the server's is
>> 32? You can tune the linux client down and not up (if using a Linux
>> server).
>=20
> That's for Trond and Chuck I guess.

For the Linux NFS server, there is an enhancement request open
in this area:

https://bugzilla.linux-nfs.org/show_bug.cgi?id=3D375

If there are any relevant design notes or performance results,
that would be the place to put them.

IIRC the only downside to a large default slot count on the
server is that it can waste memory, and it is difficult to handle
the corner cases when the server is running on a small physical
host (or in a small container).


>> 3) What would be the recommended and safest way to have a few high
>> latency clients with increased slots and concurrency?
>=20
> So, slot counts are negotiable, and dynamic, between client and
> server in NVSv4.1+. But I don't believe that either the Linux client
> or server allow them to change after starting a session.
>=20
> IMO the best way is to write some code to manage slots both to increase
> on demand and decrease on non-use. But dynamic credit management is a
> devilishly hard thing to get right. It won't be trivial.
>=20
>> I'm thinking it would be better to have the server default be higher
>> and the linux client default be 32 instead to replicate the current
>> situation. But no doubt there are other storage filers that already
>> rely on the fact that the Linux client uses 64 (e.g. cloud Netapps and
>> the like).
>=20
> If that's true, it'd be a shame. The protocol allows any value. No
> constant number will ever be "best", or even correct.
>=20
>> It's probably just a lot less hassle to stick with NFSv3 for this kind
>> of high latency multi process concurrency use case.
>=20
> That, too, would be a shame. It's worth the effort to find a better
> NFSv4.1 Linux solution.
>=20
> Tom.

--
Chuck Lever



