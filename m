Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10E046746EB
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Jan 2023 00:07:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbjASXHu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 19 Jan 2023 18:07:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbjASXH1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 19 Jan 2023 18:07:27 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A5F7677BC;
        Thu, 19 Jan 2023 14:59:21 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30JMnEGv031657;
        Thu, 19 Jan 2023 22:59:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=/nQmvUct/y4YNaBkAx5VGxDqyEQaNs3Jpx6wgeSPESQ=;
 b=I5tYOpOb/Zzw8mDWtJSqLSnsNh7VV8V3qb+374NBRfZRegbGT6kfirhxJL35RI7nMAcF
 cmG4xC6yygpuxeUg/s0IaMkenDdOcYLZIi7+Axloh9aE612xuihRdYr3/lZLj3MoOklX
 JgT2OwvIcFDYrUAAXjKBJf5dBDHzNorP7srxjCLJ/bj3rK+RcjzL1CMJRv30/YwV+0oW
 i1LZKSaTqh8bKe2QNYtyaZ3mhduOA9FSurB4ECbp6Y5ZV5e6gAvYXDW8Vo3Gidn0mc+F
 XcRdiDDCKAn4iqyHvv2QCxMSu4mZ2cQnLmR0IR5wnbv5TDj4vdmQeQ2oRLFpQk5GKbXK tg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3kaakfyr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Jan 2023 22:59:14 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30JLRY4Z027886;
        Thu, 19 Jan 2023 22:59:13 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n6qucb889-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Jan 2023 22:59:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jw1gkuVytynQzhkr+LreOOlh6fxTr0GoDuBaB/tJUxdIRZkwEqHqc2KHint/NZZ+UYPiBgkmokLknk/D8Z68NftWAkMxGRqNWwfff6MlJsKw22hnrM2fICqWr3g7cn+UDj8z5Ej5jSr7/cJIrTITmPW2MVnnrjut3gr0gtbQvKeGuI3Hy7KtfBxGdIOZCSSgyCF4hpcs57sjJzf7YGQgQrYDHYqmI7D5J/M3CY/DgU2i7w7v28Bb73dq47WevdBdXiqE1h80JEmGvBhjpwNmFWQ9va07nxt2wZOyri65rcgY8epo2ivV8QPlJ1i5HoIPibjymkprHesD7hWTt3OMrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/nQmvUct/y4YNaBkAx5VGxDqyEQaNs3Jpx6wgeSPESQ=;
 b=aLi5UYuxSmLy+BS0RLln6XAqPT75+ZMdQSI2Gbte9Tb3AHpBwgXBxOXX39LYaT4Z2yXzoNxmJDjO62Jjw7yCSTr9ZtxCsrqEaQ+XZdeSaNn7udW4V06FyZ1BKMfCFiKJ+NNmIHfHfsq+9j+wV5bs+mzJRL+ft86HOtQXfSezao8e5TBIXMY/dxdXopfIvnXYQop420Hjwnv007StUfdEobJjYT92z6peN+H2digaCYdeVGD8TpOIcoDXceEV0K7PudH8jsS+xcF+vspfxJbNl8cWZgBtWwIVSAmIn9Ah3D3nPiV6TTN+i7SKked9lW+rZzQ59vWRFtW5Il7r+SuCPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/nQmvUct/y4YNaBkAx5VGxDqyEQaNs3Jpx6wgeSPESQ=;
 b=ieREgRVABSMnXntrf3pEmOm1kZrg+HKGkNc3+J9Ojhms+4UsJjjKvO2gsZ/6UiOGGKOIT1PS4Qec7v/kCU3yHXmfCy8nHmjVlAIFDUAIQBhfzOSir+apu18a+CKh+jeKBf5DZAtzWA5JQgtXeX/qoQ+IDKdkAmmGQt0MGhIt74o=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN0PR10MB4984.namprd10.prod.outlook.com (2603:10b6:408:128::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.6; Thu, 19 Jan
 2023 22:59:11 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9%4]) with mapi id 15.20.6043.006; Thu, 19 Jan 2023
 22:59:11 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Ruben Vestergaard <rubenv@drcmr.dk>,
        Torkil Svensgaard <torkil@drcmr.dk>,
        Shachar Kagan <skagan@nvidia.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nfsd: don't free files unconditionally in
 __nfsd_file_cache_purge
Thread-Topic: [PATCH] nfsd: don't free files unconditionally in
 __nfsd_file_cache_purge
Thread-Index: AQHZLDsa7u6gikHAHEuRNYLKUO0CMa6mWtEA
Date:   Thu, 19 Jan 2023 22:59:11 +0000
Message-ID: <12CBA475-0901-41E9-90F2-9F0266ABAB74@oracle.com>
References: <20230119192021.83578-1-jlayton@kernel.org>
In-Reply-To: <20230119192021.83578-1-jlayton@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BN0PR10MB4984:EE_
x-ms-office365-filtering-correlation-id: 177ef20b-1dd0-4efb-722c-08dafa70c759
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c+fYeGYi5yfjK7byylEl/6vEv6jrfYeYtZ3YCk4xHt1toLPLcGiW2d3OOOx/bETsbyT+ouEahRF1d8qMpFYtw4rSBYz71qh58r6eutItXGbTWvilyHNFGT/424988ZQhWOmqcee3dOb88EKVXVjANF59RH4mJF4W9QaaJ+iNdvW6bEKqA2Pk3pvd2G47vva3tk5wE8UryKX+hXbBNhnjd7JPsEBPR1MPI+rsRBuk1/DyAvcNeBEGYgC2/vLXJtM4hOjzdAF+XwStEiNVFSA3JmsHpNDely/B345AeiAb1NY25odHoPcZX9JtSxVJgw9I4UXN9+h11nJleHWJVqfm/a7JAXsVejbJMUKBiGa2bOqqqmGVDcQ/l6LsMtrjOBuUCyblYekKsetLo5rWMzEAZZSW98lSL/XSIrEgV5c3TLYQimqTP8/dSg/w6+0hjgdLGUD3sQLbsk6NpxCiPBGSR4iGZf2BUNx4ShX7Jm8VjGcnT61cL2i7eWgJlDdNKaevaIHx/QNrfXgBqjkOqlqfT8GbpfBpUH0I71y+QckKv99En/gr6FVCWTy72VcYUhnKsfkDxZ+A1pRzRYxl7SUsw6KFkqXDJld6KHjMrEglD+EuJ3lSfoZ4YDvWwSvPDndtbvWIEZqXvuF+dyLirY9Ifh8TjzHCYxRdKXriUtS0GaNqwwWLlYfkmCOdFjhF2vNsJIhk+qousXUD7M4yCGJgCTUUCihAuhXeTrZa2qVYEOc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(39860400002)(396003)(346002)(136003)(451199015)(71200400001)(122000001)(8936002)(5660300002)(316002)(86362001)(6486002)(478600001)(33656002)(36756003)(6506007)(53546011)(38070700005)(2906002)(2616005)(83380400001)(54906003)(45080400002)(66446008)(66476007)(4326008)(6916009)(66556008)(76116006)(8676002)(91956017)(38100700002)(64756008)(26005)(186003)(6512007)(41300700001)(66946007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?28cGo1tyWLNh6niSy/Xo8Us9Q1/YQrYC+wU/jQlhnzgleJE8IxBuOf6ORyHJ?=
 =?us-ascii?Q?ifXnkkHgzSVjs7Ty4kY5YF65VHLpx4pK+Cxcttt/d0W6s5F1VwzcYBSFoG6C?=
 =?us-ascii?Q?zt3lxyeLHvsWd5kq5PvOlSMAmVIZARSvSGqm0HQn+FpBbGDHwRZXCubXRLLf?=
 =?us-ascii?Q?OB3q8f6dtQsx9GD1euKbeQDswPaTZjCE5d8AsvQve10BRHCRmd+QDiaYOn9R?=
 =?us-ascii?Q?HNhOy0cHymOf2M02TE1s1WUOV9UKmyTMCJVPpv+FbmxvX5jPHfjpLBAS+4u1?=
 =?us-ascii?Q?9j4c1TbGKx5QnX+Ny9l40pWo8KEEl/vjTawCWvHYmN9d73sd+cA0+Vo0Wt7K?=
 =?us-ascii?Q?AZFjlKXzsNcOKwqF+wdGIwo/QFAMR6qGWgm1lp+Y5lxLYsmk/kaytV1YbZbA?=
 =?us-ascii?Q?hM3CQXBJdRV2W6qCJ+iulVF3T9vjNey27So8UnIMHnKKAo9/Rn7rARFIEbDd?=
 =?us-ascii?Q?IR+OxnWQ6Htla9OiTgcP3GDcDDHps/jjBNu0S0yslrsjAtn0JP2IK+CeuNiG?=
 =?us-ascii?Q?Uou8bFlKzNHyTy0EEly6OkQTxEGLHj5p08WrESVon0rilehSjheUmthC16PM?=
 =?us-ascii?Q?nS5CJkt9X63y6dvXn3w86HaRVQfQs60sJlXHZjpSKNslJBEo9U0D9guJCO9C?=
 =?us-ascii?Q?xHKCV7AKonPDvA+nNG0w0EZT2UPe8NXek49h0GKU7+BKye6+3aLrHQVQHNyZ?=
 =?us-ascii?Q?wRfhG+4i4WAqioc3fnCZ4WQEaes/vGM1RWxR0gU3bILHlWhu6DMqHocuovkh?=
 =?us-ascii?Q?KP8e+FsU+TGIBRgTZdFDKBxRw5ROIBaJFc2U1lRWKTKjcH0F7pslQ0sQnmYo?=
 =?us-ascii?Q?BKHE8Gla38eBj5VW4Qxd/H7ADvA7ClrfvHQp7EOUlGaXXYVChEpl1TQ/vht3?=
 =?us-ascii?Q?i3MfWMdA0j9HW4DgbfzhH4ZO5mODpdJCo9fRakUE/3wtZUtA39fkisyDrflP?=
 =?us-ascii?Q?I2URQfayYh8AJSotT9dmfCB64ggTumkcqu5kTM5lWKgvcBMyoCWxd9C5pNtu?=
 =?us-ascii?Q?Uab7FmKr8jS+fuThMv9prYkTNXt7MQNL3CSir283Ckl6W8rXmgq247nPDveZ?=
 =?us-ascii?Q?WvPvzgR6Ylgbrr9yvD8SLNbzRy20ExC64ZDjUzSM3mCxC35jKBK8OJ1z9+jn?=
 =?us-ascii?Q?Ld5z+CtbnWo7NUwMjzZv00F2TK018XLpMtvQ5gRK8JTI37MGlTEeaT0rtf4u?=
 =?us-ascii?Q?tPyY+r0VV5YjcmlkboiH//qtbzWPBjZyn6L6ygL2vl6o+wu450EUoUgy5pfE?=
 =?us-ascii?Q?3+1GogGFYp+SsKuYTNkujGvvdYi3XemXy6cWfkPsb6OFx83HVWv9vpmH5gkm?=
 =?us-ascii?Q?F7kh8JWjoOW+QJNlIUW2bUB70cypla3I3b2RvpG0icHzyGwy3tLNL4OP6pSe?=
 =?us-ascii?Q?YGglQk2pQ7uNkf+a0rP74Un56ZRxdtoe/cvQdLrlzgw65nqvU63E+FRoAYd1?=
 =?us-ascii?Q?bqHCFCorBfZOsuIu52890FzIg5BOs+uMZEs7b8nFkkkYFs5GXbnoNKGdfCKH?=
 =?us-ascii?Q?TC1aCV5d7VJntLHZ0OqPace7BX2pgI8j3TAm7HC1fJd6GNAJNj2yjNWw8oF7?=
 =?us-ascii?Q?6BXls2nWXb4whQnI0OhwPbntI7XgeTm+S9NAtmMlafTrDnBt0ZAmefqIbI7K?=
 =?us-ascii?Q?sg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <32BF68C6ACF55C4EA3003B2DA6E3336B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: JicIBuHOmnOJjgcsaQtIpL4jM+HU8ulU289ACsiNChBxs8KCh9+Vg/br6r381Cj8HnR9rkhohQD0FAKUhyDFJdEIHoF+sLSza9fqxpfRQ8BvYNxW1WWYbooG5QFJYYU2MQK8t9qNeYG6bxBxifDTxLiSthzv5Pd5Hta5f66wEI/+FcisVdwxtJegvG7Md8k/5BVmf6A5nI4GQba59zQdb5oEMIBEzll9VzM3kej3FV094XbUdsdS1LaS29pPMXOT8vTPQFqOmZIAMz3Jhng6EUg4N5XuQOBPLYTlEaome4pwetPPZFtZDo2m8lDhY3x7N1mlJib6bZUu9MyM3wOQF8UVhpg1gFIqpEG7By7XZSGqjOGbGn/Exoli+nrhsrfBndl44BD1IcaZew12JuzGTQ+dp9WsJsyyCkpBete3Q44tR/eIEZ6ARrVZe7KCWrKfI/Nqs51knxzQxzuBz9rYdLmpqZNbHzlhQ5qnAUdILkAhQGcm0iP9vEYApmthxZZQrB3Ja7gMwKDD0C+C0j0HpwepuLPjYiJthXk4qVpm5kG4VjRHDjZP+LG5eST7kRs5unDrjKgx1klfqpJbgQ5rweY7dSieyQLDpLZ+ikKOsq/MY1h86ErZ8Wp0s1q+B17SZGGlILFwtV9xUuvzQ3iUV80ONKVcoMdU0SLHM3imBSXDb0m0fCognHf/F8nSogXpPDlGg/kk/u5Q0MYZJtLDJNmLULvTnDLWsnAgoNk/bUh/NinkcPRcLMTemCsKGHOO2cAAHN8kbN0hB1M2uj4hbmy/P30VnhXo0uX14RithHZSK9M6VFk9oKQArcPtbdtwVFg+eJWsI04EnEOU/v4xZqXDp4u+Ahwpeo501heTLOQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 177ef20b-1dd0-4efb-722c-08dafa70c759
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2023 22:59:11.3374
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DJlm0PQjFnCpLIXW1AXaGAhSNpLnmoCu32uqK0zieW7LKz5cMwVK9Wb/HMSYJgoumBM/L/uVxxeEofB2cZy3+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4984
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-19_14,2023-01-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 spamscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301190195
X-Proofpoint-GUID: VB7A6CeY8WCfvvT-oGzAs8SM-1EvDl6r
X-Proofpoint-ORIG-GUID: VB7A6CeY8WCfvvT-oGzAs8SM-1EvDl6r
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 19, 2023, at 2:20 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> nfsd_file_cache_purge is called when the server is shutting down, in
> which case, tearing things down is generally fine, but it also gets
> called when the exports cache is flushed.
>=20
> Instead of walking the cache and freeing everything unconditionally,
> attempt to unhash each entry and get a reference to it, and then put
> that reference. Only queue it to the dispose list if the refcount goes
> to 0.
>=20
> Fixes: ac3a2585f018 ("nfsd: rework refcounting in filecache")
> Reported-by: Ruben Vestergaard <rubenv@drcmr.dk>
> Reported-by: Torkil Svensgaard <torkil@drcmr.dk>
> Reported-by: Shachar Kagan <skagan@nvidia.com>
> Signed-off-by: Jeffrey Layton <jlayton@kernel.org>

FYI, checkpatch complained that the Signed-off-by does not
exactly match the From: address. I haven't see "Jeffrey"
before, but the DKIM check passed, so....

.... I've applied this to nfsd-fixes (formerly for-rc).


> ---
> fs/nfsd/filecache.c | 21 ++++++++++++++++++---
> 1 file changed, 18 insertions(+), 3 deletions(-)
>=20
> I was able to reproduce this today by running pynfs against the server
> while running "exportfs -ra" in a loop. This one is a bit different in
> that it happened in the open codepath, but that's probably just because
> delegations are more likely to be long-lived. With this patch, the
> server survives the run:
>=20
> [  337.962027] ------------[ cut here ]------------
> [  337.963823] refcount_t: underflow; use-after-free.
> [  337.965502] WARNING: CPU: 6 PID: 3401 at lib/refcount.c:28 refcount_wa=
rn_saturate+0xba/0x110
> [  337.967999] Modules linked in: nfsd(E) auth_rpcgss(E) nfs_acl(E) lockd=
(E) grace(E) sunrpc(E) nls_iso8859_1(E) nls_cp437(E) vfat(E) fat(E) ext4(E)=
 crc16(E) cirrus(E) kvm_intel(E) 9p(E) mbcache(E) joydev(E) virtio_net(E) d=
rm_shmem_helper(E) net_failover(E) kvm(E) jbd2(E) netfs(E) psmouse(E) evdev=
(E) pcspkr(E) failover(E) irqbypass(E) virtio_balloon(E) drm_kms_helper(E) =
9pnet_virtio(E) button(E) drm(E) configfs(E) zram(E) zsmalloc(E) crct10dif_=
pclmul(E) crc32_pclmul(E) nvme(E) ghash_clmulni_intel(E) virtio_blk(E) sha5=
12_ssse3(E) sha512_generic(E) nvme_core(E) t10_pi(E) virtio_pci(E) virtio(E=
) crc64_rocksoft_generic(E) aesni_intel(E) crypto_simd(E) crc64_rocksoft(E)=
 virtio_pci_legacy_dev(E) i6300esb(E) cryptd(E) serio_raw(E) crc64(E) virti=
o_pci_modern_dev(E) virtio_ring(E) btrfs(E) blake2b_generic(E) xor(E) raid6=
_pq(E) libcrc32c(E) crc32c_generic(E) crc32c_intel(E) autofs4(E)
> [  337.992040] CPU: 6 PID: 3401 Comm: nfsd Tainted: G            E      6=
.2.0-rc3+ #11
> [  337.994701] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1=
.16.1-2.fc37 04/01/2014
> [  337.998046] RIP: 0010:refcount_warn_saturate+0xba/0x110
> [  337.999852] Code: 01 01 e8 83 e5 4f 00 0f 0b c3 cc cc cc cc 80 3d 60 f=
4 05 01 00 75 85 48 c7 c7 30 b5 e1 9d c6 05 50 f4 05 01 01 e8 60 e5 4f 00 <=
0f> 0b c3 cc cc cc cc 80 3d 3b f4 05 01 00 0f 85 5e ff ff ff 48 c7
> [  338.005245] RSP: 0018:ffffa36802e4bd50 EFLAGS: 00010282
> [  338.006621] RAX: 0000000000000000 RBX: 0000000000000008 RCX: 000000000=
0000000
> [  338.008273] RDX: 0000000000000001 RSI: ffffffff9de03ef5 RDI: 00000000f=
fffffff
> [  338.009804] RBP: 0000000000000003 R08: 0000000000000000 R09: ffffa3680=
2e4bc00
> [  338.011719] R10: 0000000000000003 R11: ffffffff9e0bfdc8 R12: ffff9578d=
a461b80
> [  338.013533] R13: 0000000000000001 R14: ffff9578da422280 R15: ffff9578d=
a461b80
> [  338.015238] FS:  0000000000000000(0000) GS:ffff957a37d00000(0000) knlG=
S:0000000000000000
> [  338.017179] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  338.018680] CR2: 00007f324c1e1c08 CR3: 000000020360a004 CR4: 000000000=
0060ee0
> [  338.020377] Call Trace:
> [  338.021190]  <TASK>
> [  338.021956]  release_all_access+0x96/0x120 [nfsd]
> [  338.023192]  ? _raw_spin_unlock+0x15/0x30
> [  338.024192]  nfsd4_close+0x275/0x3d0 [nfsd]
> [  338.025468]  ? fh_verify+0x45e/0x780 [nfsd]
> [  338.027535]  ? __pfx_nfsd4_encode_noop+0x10/0x10 [nfsd]
> [  338.028775]  ? nfsd4_encode_operation+0xae/0x280 [nfsd]
> [  338.030593]  nfsd4_proc_compound+0x3ae/0x6f0 [nfsd]
> [  338.032341]  nfsd_dispatch+0x16a/0x270 [nfsd]
> [  338.034667]  svc_process_common+0x2eb/0x660 [sunrpc]
> [  338.036614]  ? __pfx_nfsd_dispatch+0x10/0x10 [nfsd]
> [  338.038827]  ? __pfx_nfsd+0x10/0x10 [nfsd]
> [  338.040267]  svc_process+0xad/0x100 [sunrpc]
> [  338.041981]  nfsd+0xd5/0x190 [nfsd]
> [  338.043362]  kthread+0xe9/0x110
> [  338.044680]  ? __pfx_kthread+0x10/0x10
> [  338.046376]  ret_from_fork+0x2c/0x50
> [  338.047892]  </TASK>
> [  338.049067] ---[ end trace 0000000000000000 ]---
> [  760.792789] BUG: kernel NULL pointer dereference, address: 00000000000=
00078
> [  760.795933] #PF: supervisor read access in kernel mode
> [  760.797477] #PF: error_code(0x0000) - not-present page
> [  760.799120] PGD 0 P4D 0
> [  760.800140] Oops: 0000 [#1] PREEMPT SMP PTI
> [  760.801383] CPU: 2 PID: 3401 Comm: nfsd Tainted: G        W   E      6=
.2.0-rc3+ #11
> [  760.803120] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1=
.16.1-2.fc37 04/01/2014
> [  760.805018] RIP: 0010:filp_close+0x23/0x70
> [  760.806099] Code: 90 90 90 90 90 90 90 0f 1f 44 00 00 41 54 55 53 48 8=
b 47 38 48 85 c0 0f 84 41 e1 6d 00 48 8b 47 28 48 89 fb 48 89 f5 45 31 e4 <=
48> 8b 40 78 48 85 c0 74 08 e8 6f 70 72 00 41 89 c4 f6 43 45 40 75
> [  760.809737] RSP: 0018:ffffa36802e4bc78 EFLAGS: 00010246
> [  760.811084] RAX: 0000000000000000 RBX: ffff9578c7d4d600 RCX: 000000000=
0000000
> [  760.812540] RDX: 000000000000098d RSI: 0000000000000000 RDI: ffff9578c=
7d4d600
> [  760.814433] RBP: 0000000000000000 R08: 0000011335048e60 R09: ffff9578f=
82f1540
> [  760.816089] R10: ffffa36802e4bcd0 R11: ffffa36802e4bcd8 R12: 000000000=
0000000
> [  760.817529] R13: 0000000000000001 R14: dead000000000100 R15: ffff9578f=
82f1558
> [  760.818982] FS:  0000000000000000(0000) GS:ffff957a37c80000(0000) knlG=
S:0000000000000000
> [  760.820544] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  760.821734] CR2: 0000000000000078 CR3: 00000001565ce002 CR4: 000000000=
0060ee0
> [  760.823141] Call Trace:
> [  760.823808]  <TASK>
> [  760.824419]  nfsd_file_free+0xe9/0x210 [nfsd]
> [  760.825610]  release_all_access+0x96/0x120 [nfsd]
> [  760.826680]  nfs4_free_ol_stateid+0x22/0x60 [nfsd]
> [  760.827747]  free_ol_stateid_reaplist+0x61/0x90 [nfsd]
> [  760.828858]  release_openowner+0x258/0x2a0 [nfsd]
> [  760.829792]  __destroy_client+0x183/0x290 [nfsd]
> [  760.830694]  nfsd4_setclientid_confirm+0x1a3/0x4f0 [nfsd]
> [  760.831763]  nfsd4_proc_compound+0x3ae/0x6f0 [nfsd]
> [  760.832717]  nfsd_dispatch+0x16a/0x270 [nfsd]
> [  760.833576]  svc_process_common+0x2eb/0x660 [sunrpc]
> [  760.834587]  ? __pfx_nfsd_dispatch+0x10/0x10 [nfsd]
> [  760.835576]  ? __pfx_nfsd+0x10/0x10 [nfsd]
> [  760.836462]  svc_process+0xad/0x100 [sunrpc]
> [  760.837317]  nfsd+0xd5/0x190 [nfsd]
> [  760.838133]  kthread+0xe9/0x110
> [  760.838862]  ? __pfx_kthread+0x10/0x10
> [  760.839755]  ret_from_fork+0x2c/0x50
> [  760.840534]  </TASK>
> [  760.841167] Modules linked in: nfsd(E) auth_rpcgss(E) nfs_acl(E) lockd=
(E) grace(E) sunrpc(E) nls_iso8859_1(E) nls_cp437(E) vfat(E) fat(E) ext4(E)=
 crc16(E) cirrus(E) kvm_intel(E) 9p(E) mbcache(E) joydev(E) virtio_net(E) d=
rm_shmem_helper(E) net_failover(E) kvm(E) jbd2(E) netfs(E) psmouse(E) evdev=
(E) pcspkr(E) failover(E) irqbypass(E) virtio_balloon(E) drm_kms_helper(E) =
9pnet_virtio(E) button(E) drm(E) configfs(E) zram(E) zsmalloc(E) crct10dif_=
pclmul(E) crc32_pclmul(E) nvme(E) ghash_clmulni_intel(E) virtio_blk(E) sha5=
12_ssse3(E) sha512_generic(E) nvme_core(E) t10_pi(E) virtio_pci(E) virtio(E=
) crc64_rocksoft_generic(E) aesni_intel(E) crypto_simd(E) crc64_rocksoft(E)=
 virtio_pci_legacy_dev(E) i6300esb(E) cryptd(E) serio_raw(E) crc64(E) virti=
o_pci_modern_dev(E) virtio_ring(E) btrfs(E) blake2b_generic(E) xor(E) raid6=
_pq(E) libcrc32c(E) crc32c_generic(E) crc32c_intel(E) autofs4(E)
> [  760.853527] CR2: 0000000000000078
> [  760.854340] ---[ end trace 0000000000000000 ]---
> [  760.855261] RIP: 0010:filp_close+0x23/0x70
> [  760.856185] Code: 90 90 90 90 90 90 90 0f 1f 44 00 00 41 54 55 53 48 8=
b 47 38 48 85 c0 0f 84 41 e1 6d 00 48 8b 47 28 48 89 fb 48 89 f5 45 31 e4 <=
48> 8b 40 78 48 85 c0 74 08 e8 6f 70 72 00 41 89 c4 f6 43 45 40 75
> [  760.859350] RSP: 0018:ffffa36802e4bc78 EFLAGS: 00010246
> [  760.860356] RAX: 0000000000000000 RBX: ffff9578c7d4d600 RCX: 000000000=
0000000
> [  760.861628] RDX: 000000000000098d RSI: 0000000000000000 RDI: ffff9578c=
7d4d600
> [  760.862898] RBP: 0000000000000000 R08: 0000011335048e60 R09: ffff9578f=
82f1540
> [  760.864172] R10: ffffa36802e4bcd0 R11: ffffa36802e4bcd8 R12: 000000000=
0000000
> [  760.865438] R13: 0000000000000001 R14: dead000000000100 R15: ffff9578f=
82f1558
> [  760.866692] FS:  0000000000000000(0000) GS:ffff957a37c80000(0000) knlG=
S:0000000000000000
> [  760.868053] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  760.869102] CR2: 0000000000000078 CR3: 00000001565ce002 CR4: 000000000=
0060ee0
>=20
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index 66449c41b19c..b9100707d347 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -908,9 +908,24 @@ __nfsd_file_cache_purge(struct net *net)
> 		nf =3D rhashtable_walk_next(&iter);
> 		while (!IS_ERR_OR_NULL(nf)) {
> 			if (!net || nf->nf_net =3D=3D net) {
> -				nfsd_file_unhash(nf);
> -				nfsd_file_lru_remove(nf);
> -				list_add(&nf->nf_lru, &dispose);
> +				/* Ignore it if it's no longer hashed */
> +				if (!nfsd_file_unhash(nf))
> +					continue;
> +
> +				/*
> +				 * Try to claim the LRU ref (if any). If it's
> +				 * not on the LRU, then try to take a ref. If that
> +				 * fails, then we'll ignore it.
> +				 */
> +				if (!nfsd_file_lru_remove(nf))
> +					nf =3D nfsd_file_get(nf);
> +
> +				/*
> +				 * Now try to put the ref we hold. If that works
> +				 * and it goes to zero, queue it to be freed.
> +				 */
> +				if (nf && refcount_dec_and_test(&nf->nf_ref))
> +					list_add(&nf->nf_lru, &dispose);
> 			}
> 			nf =3D rhashtable_walk_next(&iter);
> 		}
> --=20
> 2.39.0
>=20

--
Chuck Lever



