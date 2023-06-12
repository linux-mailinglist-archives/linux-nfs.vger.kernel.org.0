Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCDA772C87E
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Jun 2023 16:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239066AbjFLO24 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Jun 2023 10:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237526AbjFLO2W (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 12 Jun 2023 10:28:22 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A504E44A9;
        Mon, 12 Jun 2023 07:26:31 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35CEOVOR032677;
        Mon, 12 Jun 2023 14:25:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=bbetwhjPDwq4aDNyyjU7ypkLHJocVzVeoYWXDKqMFpI=;
 b=SlITf8A4QA52J8L2zfa5VHgXbLloKL6fakGZKch2hNNs56Ste+hFqmNRH0k3eJNiKu+/
 q/8LoXbRaQheoK+yPT32978+bOF+0VkN2qiXjIwNWdCk1OzCe3AbjCOnPD/dl54hH+pI
 qX6sPs6Q46fin4S5SbPKeSH9T+nbdwoLhIo9JYBHWGNFJHI6RJzDQjl8pXafoB4bTMdt
 cXjlS4V8f+VqyaP8Zl+b0nZww8a8k4VVL7peYgDvJQ4J3XGo+cWlal3Sp9Uo9umt96iX
 3KZSIyI41VHtCMb0U2cAk5bksSvBaAUoQtJ43znSD4q2emGWM8m+hzLDGs+sRKfcfnEC vA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4hquk297-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jun 2023 14:25:51 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35CEGL4a017780;
        Mon, 12 Jun 2023 14:25:50 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm2kekw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jun 2023 14:25:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=COA64P9ldmnCTSES7BEMKFFrakcka6xxgaPwOzrqPFLvov2SREtvVF8YWRAM2LJEZ8pq6pEnVDyPG6VMNfr+jWc8yzBYyNo7O8Wfa+IAWhJajeIjZUWiM2fIFc5Ygx4ZOfGBzKWCR9u4SfsGkP9tmHMMvxc6aQs+UGgXmmLsloXpHC2hLTQ/0h1PIg03rgsVNtTFo8Mfjl4Vw1ksI8yDNkzcIwJNJxBhpZWsQv83YA2EpzPUC2M8rgMj/DoFEkYcMhzNman0NUlH4O/UEx8TydGCpDL2E8FxGzVCipmE+nCHz85vyhy7/5wyk3k2UXDAiSrSstgzetVh63BJUdP1CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bbetwhjPDwq4aDNyyjU7ypkLHJocVzVeoYWXDKqMFpI=;
 b=JpYz2OzzMPxzJNHYg4nF6uMJEZVk6lY27APFLKyIdJs1xxnwbamtdK6EC4Dtrtj+SpjGaRcxxwhZyFSd9/znIxYq8BwmmlVX3fDvHCun22rcGBEKwGCZqQAPP31lCqbKgHRT1+FCypepDdyA1CKBlsftjyYGVYECqj6kOZ+4KamFz/sWJ8v29v4g6EYV9WRbpnAULEniDYAQvOLktla4UGMiwgN9NU9eZ6UIAM9X40PTt3+SInLqYh1/00k2A3D0MI0IG+Nrv+bLOD8qHw/b2LL7gpaLMKuQUivUNCtqa71okvkhJ/Ggykzxv8EYRaZt/skGKdr+SEmDwRcoqCUbiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bbetwhjPDwq4aDNyyjU7ypkLHJocVzVeoYWXDKqMFpI=;
 b=aPOU0TbQvP1F05wTf1zhjPd+FJM8mUCDhwICUlkKt6nn2dwGaA7rF5264vyZUYlBWeBN3P3z6oTr/XbtlEXUi7O7rk2OKAhTYzTxSU81RsPj2vgrgtfYgMd3L4SBNKzKLdSaK0UK/s4VTD78ImS57EIN/g2ngpqjnyOVles8RxI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH0PR10MB5034.namprd10.prod.outlook.com (2603:10b6:610:c9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Mon, 12 Jun
 2023 14:25:48 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%5]) with mapi id 15.20.6455.043; Mon, 12 Jun 2023
 14:25:48 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Chuck Lever <cel@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Tom Talpey <tom@talpey.com>
Subject: Re: [PATCH v2 1/5] SUNRPC: Revert cc93ce9529a6 ("svcrdma: Retain the
 page backing rq_res.head[0].iov_base")
Thread-Topic: [PATCH v2 1/5] SUNRPC: Revert cc93ce9529a6 ("svcrdma: Retain the
 page backing rq_res.head[0].iov_base")
Thread-Index: AQHZnTeXVqDYwGGSmEqfgO2otPvR8K+HOLuAgAAAWIA=
Date:   Mon, 12 Jun 2023 14:25:48 +0000
Message-ID: <2AA26C51-C9FA-4913-BD52-D12E3D58F6EB@oracle.com>
References: <168657879115.5619.5573632864481586166.stgit@manet.1015granger.net>
 <168657900128.5619.7769165526407423007.stgit@manet.1015granger.net>
 <e3225c285c67f4b2840ee3f5ac138e6e8c63fc89.camel@kernel.org>
In-Reply-To: <e3225c285c67f4b2840ee3f5ac138e6e8c63fc89.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CH0PR10MB5034:EE_
x-ms-office365-filtering-correlation-id: 884b033b-7342-43b2-2950-08db6b50eaca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RQlX1hzI8zsSKDgPRR+JO5JqcPuQgRruMSX7tSq/ZWTtBGMggXnai2nsI9L8qLlne2Mr6pTDM/vO+3UKVcwhPmQ+2LkBjzPVUoagqfq2JUVdssh23ZULr84ukI7jScR6cln5NkIXFVOOtgyXQbTaTTGCwtk5MPM1E8MxE5jBMYLzl5rGP0gYwmDFSKA0jX1nlytP5SyVAUpXre7mD9UaWO1o3bHhLg2a715hHW5/Q1nKqR0RI3tEuAY2BjySZ1my2CZN8VHeJpjVkrZCFgBZsCBTm5y0iEPEj+oNWgGi5xrLH3Zncojpcp830lWhAupzmSzOs7D9PJmXOeZFfh0oFVIueTp7jlOwMX7j60USAuNajd+Es5WWKpaGZC/1Tefk8r9S4SqRpIIRmNkitkEwNfRCNT8CoPbqXV1iDCpPVDRwBXyBw8IQikZZ0snVLUO31WTkzz/isSZik74Sn7jczG09onMxynTIS49oRqYohuoZHCYfH28WIG1TVC9Yo/8llDKL+ElVoTG7mo69Uz3AMGSTcqDqGb0olI620dSjre8uVwpI1cE5tY+gwIBYON11ddszJID9mBhXFIWPLIUkQ/8e7hln4Yk5dCHYFcpuPapJNkHW501kxy/GlKOp3sNfEi7LkxjdabcgDpaWk3Q/0g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(396003)(376002)(346002)(366004)(451199021)(6916009)(4326008)(66946007)(76116006)(91956017)(66446008)(66476007)(66556008)(64756008)(36756003)(186003)(478600001)(2616005)(2906002)(54906003)(8676002)(316002)(41300700001)(86362001)(6486002)(6506007)(33656002)(53546011)(38070700005)(71200400001)(122000001)(8936002)(83380400001)(5660300002)(26005)(38100700002)(6512007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RmWxicg4Fc7xrC3XZmcf09EkT2I1KlvH3irjiI7lHDcnYsDnhCzfD27UjSDw?=
 =?us-ascii?Q?cL4dLEuYsLeC2U0YaC8sPPZ0rT1UN7hG1ml1rArtMqpS3DlHIiJGzYVG67C5?=
 =?us-ascii?Q?CsXKhuJZgqoRtwQfLokhG7pd9OMR8Xg6fbbQqo9VUsnm9iO31T/dBTdZgQ4c?=
 =?us-ascii?Q?oshy0mLvZhgXO5xkDTib9M3ZteMUfCUt9dLoaDAH9t+e3iJNPnjrg6R+rvb+?=
 =?us-ascii?Q?04BvY+PlnXowfUaFi8s3HJ6PW/ko2OzaNG64/zc5KkQizI0FnQhbv2zyfX5c?=
 =?us-ascii?Q?4ags7LQ+TpKARMKZOTvi5qTpzJHw02w4GWmTlhMJXS+B1HAI/y5CDrRIq7z9?=
 =?us-ascii?Q?gSLj3TLRoD2QfeloYZxX9gQW2bq+dg4eWsH4vOKRrB+QjeEmcJFosU75fHYm?=
 =?us-ascii?Q?0soH/RyYUHRLYHsnlX6emZYJLGfAOKQsMyepHanuSZI3IoK84lSc4Z0Q5IzN?=
 =?us-ascii?Q?a79uyeSV4uA1Jmd/goyvrjRMgtlOfuZia/8Iyoe+8lYvDAMGGuRDuiIKEGA4?=
 =?us-ascii?Q?s/B6eJO0I5rL4l6MSCFcLdJouDGTzsZSkaelR0ha0b16mBP8hOYq+9YK+R5J?=
 =?us-ascii?Q?j5OYtHiIzmloosyoONiVT7fAxI5J2rN+5keHuJdBnBwL9He4C/hXX1UzNc9i?=
 =?us-ascii?Q?ZaA80nuhVqEM/D/adbUGuS7YNgWCyebXc0Z+4ZVD0yWvll2Wayf4X2dGQ3ni?=
 =?us-ascii?Q?n4ymOv0pxHhTSgXaVXhwo8Ccb4Wj185ZZ+NAsE4BXNm2b9QO9CSkZRDaocyj?=
 =?us-ascii?Q?pVN7J4v3dXrFQyX8CXNGmFR0ijCU8A6BdLDis+r7AfNlCS7ppWLxvmQ7N9Ja?=
 =?us-ascii?Q?OMOqeLpCAiRmsezolzk2eSQnvRF9e2B+UZpT6EHRMUqWGD99I/+WI4fsP/Yv?=
 =?us-ascii?Q?LejvKxBGyfMicPVB0ABHxnDR/y0irgJTmBrXaG8cq3P8IEXUryKU4kAuhHSE?=
 =?us-ascii?Q?1nCEecpaeitja1jsH9sWD0JCbMWqllKUAj4JgVNUaHXAwYhK7fJAkNDPfnGF?=
 =?us-ascii?Q?wMjgehZYoZholxEpVEZhVRNXsmayaZ1BbFp0i7wfmyMHO7m+Zmwmkw6dbz4i?=
 =?us-ascii?Q?hpl/P5oGFE2luGJIQkFbBqqBIKYdydJVOlJuF0NpLWHodlztWLej1M+PoN3J?=
 =?us-ascii?Q?Q4NF88awbrEumAgwgO63/cWNiOoWMxfo4Bbgo1hY9gB3AVeQvnQPf9wXj28G?=
 =?us-ascii?Q?p5q9e0Eh0A6W1RZSCA7gcBZLcc5r2yf0OKmno/VjXter0wWReT/ihBvyDKub?=
 =?us-ascii?Q?7VGgMH3QiV0qiDUHpupoNCARotCxBgxg8z7zKAkdSn6LChdr3QnZvRTcRfYE?=
 =?us-ascii?Q?6aB8QyXECK6/NiX7q+ZlaLGWoOAXGgAOYU78qWF0Bik4K3YPG/rk9F7cGOIl?=
 =?us-ascii?Q?9xXmKay/1dlme1ECwY/EmbmOVHFPgi43FxVSfBq17+1z/noXcgprXKbNfUBp?=
 =?us-ascii?Q?QYICP6I+tgjRobSJDO8h7ma9BrJnoDDTNy3d1MoqxGPbbpKLYmsN4GWaEIr7?=
 =?us-ascii?Q?opzcYtn5G5Yb96l28ypLOG9hj9Yxj+CQ1f/5WT9JDdyKF2iuYC5x5Ios17+B?=
 =?us-ascii?Q?GYCuJNPu2A+tH4Ja1tbpiZljXwboUvXoaJ3hMImFZ05XkAsMU1NR5wbKxtT1?=
 =?us-ascii?Q?YA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1706522E5B0B32479142D1094C07985E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 4/noVe9rnPBFuI32+ptnVSQkSfWWqsAJyz34lE9PcWSUpzzO6B34oVverhoSEeMfUhOZFGH8OZy8sUTQF+qQyrnoHkv1bjN/ouJtTpwkWyzHmWQ0tv7c3+yLUEhloUiHAu5YQ3Lac9JK35GGNEc/IsyTz64+cceSA5rRzNRHMoUR3RFWsgQVk16TR51O9M+QBMuqsQtZFbLtYwABDmyXIFkO/2uRirJO2p1e7G5ADPL6VJ0VALss8R1QN2TkTxUBrpj16YALebPNm5iufhcNcScF0q8SbzjqdpLNQJdImcaSx0MUC85vGt+HrTpcf+xc3sqfy2JmENkBYowJymInUHDkSXdil5yJvK8mwaVcFQEhgBVy+Bnrg17XermWOfJnfL8b8+1vJc7fefx47h4eZNDdaZGy+yLxEck/XLafP3pIJCxQGKMliREII0q71wDjB/PJjhZQ236CIGTmsliZEvtGOJ82gt+jQoSVHN59g/bZBQxxr7hHOP8/pEoLKNJ1siw+qAx+U4TEeRfMV0Zx0ClzOuureDrp9KNxx1L7yk/mXXCutU1OLufb7aHNClb+Bb9FpvQCfBoCWcdEviNn3djzcX/aaUc38v+z8Y0FWent3HFWs8Qddays2SqxDhnauuA1xTuQlp/ZY43IZT4t3JBpUw8uiHswKyy+Ss3pMebFc/1rcyADIltcOGDA8/0pvbdUtrfXvrb4UWRFZwBoo3R6IuOBTOyRSoAYV28cpcAQDfjXwAU56b9fXxnjt7lWFV1FM6lOH2WQEU66mX1UgUpMoWMGCHD4xGQnN0y6M1/Zs5Gz5Bl78NLKNaa2QRgN
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 884b033b-7342-43b2-2950-08db6b50eaca
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2023 14:25:48.3667
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3nsA+uRjFCoXzwKAA2oTzuSGyxPBkvRfPYoprLQGMJewHK2x1Nj2OHrdvsdUv46/vZLG7Xo7PuwrXOUMAKHraA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5034
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_06,2023-06-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306120123
X-Proofpoint-ORIG-GUID: Xv_vDyxioxZH_FS48SdAHuKjge7LtqVn
X-Proofpoint-GUID: Xv_vDyxioxZH_FS48SdAHuKjge7LtqVn
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jun 12, 2023, at 10:24 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Mon, 2023-06-12 at 10:10 -0400, Chuck Lever wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>>=20
>> Pre-requisite for releasing pages in the send completion handler.
>> Reverted by hand: patch -R would not apply cleanly.
>>=20
>=20
> I'm guessing because there were other patches to this area in the
> interim that you didn't want to revert?

Correct.


>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>> net/sunrpc/xprtrdma/svc_rdma_sendto.c |    5 -----
>> 1 file changed, 5 deletions(-)
>>=20
>> diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma=
/svc_rdma_sendto.c
>> index a35d1e055b1a..8e7ccef74207 100644
>> --- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
>> +++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
>> @@ -975,11 +975,6 @@ int svc_rdma_sendto(struct svc_rqst *rqstp)
>> ret =3D svc_rdma_send_reply_msg(rdma, sctxt, rctxt, rqstp);
>> if (ret < 0)
>> goto put_ctxt;
>> -
>> - /* Prevent svc_xprt_release() from releasing the page backing
>> - * rq_res.head[0].iov_base. It's no longer being accessed by
>> - * the I/O device. */
>> - rqstp->rq_respages++;
>> return 0;
>>=20
>> reply_chunk:
>>=20
>>=20
>=20
> --=20
> Jeff Layton <jlayton@kernel.org>

--
Chuck Lever


