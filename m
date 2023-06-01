Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6DF371A06F
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Jun 2023 16:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233376AbjFAOj1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 1 Jun 2023 10:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233887AbjFAOjV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 1 Jun 2023 10:39:21 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD97195
        for <linux-nfs@vger.kernel.org>; Thu,  1 Jun 2023 07:39:08 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 351E4RMv003245;
        Thu, 1 Jun 2023 14:39:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=NwO8WLoghjZU+OgAtvrNJtPGqVoL67GTyIumkqgw3ck=;
 b=fz/02V1WMvKK1Cf73BsdIfGiFYqS1cMa46n/x5IuDqxEtzqiOVU46cJMNlRcQzbaS3SO
 gIicuhPsuzKLyDyRZHQy+08qcXMO6rK5mPca7vtmUs8fFpPneuTciYKJbRHhf9PmSpOt
 c3qcAzONcZtcgLrHFctn693n5T5+XVzura63TlLd251OMbo8jexRfqbDRY2H0gQ/X/va
 XsBkRqWWOWa/qm0NNp1QLzKwK9ERaNV8WkCipFCvFg5Mrd1ZUlb3t3euXc+b9HI1bjgW
 UaatbvaNzzEXPIF3h0q48ZtdPlYu+qR6VO/SKqtndQzN8GM+n/LtJef62KzmRW9YbceO og== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhmjs0es-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Jun 2023 14:39:02 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 351D4YPk000521;
        Thu, 1 Jun 2023 14:39:00 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2046.outbound.protection.outlook.com [104.47.57.46])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qu8qbst0u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Jun 2023 14:39:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eJ/qtH8HG3TdkSLxTKjQgk/tYNluwAqXBuickI7zZLlYQ9sZR97wB9/vzX93GYUv6AvF5L7zjwTQcwWCr7B0M2lmiZE8nmp7Bi93bNmdf4/LFIJAhsmXqeI/t4v0TYV7o34IRkhlgrGjQ08y0GCJ7xx0od4CiZJQ5+ueOtZGL/G2EFeFTbBwoYd6MzU3dZzwqLje7DWnzWxyvycZ6QxSV0lyOy3K4pzpSMLt+Aw3eT/h6oA/2USvwunU0Fb2fmsNTUpkDDv/nU71/k++MWcXBLqaXzCOs5gkBW2pckcoHWELwAaUNw4acPhhgq4+IgX334rivMy6YsuQb96erwRTLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NwO8WLoghjZU+OgAtvrNJtPGqVoL67GTyIumkqgw3ck=;
 b=dKjMhZ55J0YdwcjxLZm4iH3gxfKqBuYYvCluKnHMQwUvnCk5U5eaOpVcHT1WRfv6fYRbejQkr8AvDo05xAQkla12k9cBaJvyxYGajUTmRP23Wt9KyR3iGCEKNn4zSirkHCSWISwe3rNaMRWDUCGXGYzPtKwTWy3+4xu55z++yfssnE+7ZICm38pDUAsQVAUShbkngNdDhq/yp6tTD8tL4q/4xjsH04JHl3obsM++etZ7rYKjZoQINlhFhEap9o73pLSm/Anol5pYPdGjrC1XeOU965gAyfoKaHFf/gdxGOFdAbrme99KY5aQWGpCATd4HwEsuWaR8tnTTWBQXLoaZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NwO8WLoghjZU+OgAtvrNJtPGqVoL67GTyIumkqgw3ck=;
 b=b+3C8yIsSLE3L6SSsDIkfzp75QRjlab6oKgCk/PpAtzNHxbDQk8PSZ+LelSLJo9K6pun6sEybncaKFD4/fo08wUaZp3OX3zdZVmz7R9/dUFZ3XuoAch8gtUBv61bAsp6CA/aVfof0UdE7xHRSfUE7PQRoTro5bw+kJ5iNVtP5Nc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SN7PR10MB6667.namprd10.prod.outlook.com (2603:10b6:806:299::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Thu, 1 Jun
 2023 14:38:58 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%5]) with mapi id 15.20.6455.020; Thu, 1 Jun 2023
 14:38:58 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dmitry Antipov <dmantipov@yandex.ru>
CC:     Jeff Layton <jlayton@kernel.org>, Tom Rix <trix@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH] sunrpc: fix clang-17 warning
Thread-Topic: [PATCH] sunrpc: fix clang-17 warning
Thread-Index: AQHZlJYb6vjx06AMBkGvsuYKh+iggq92BGoA
Date:   Thu, 1 Jun 2023 14:38:58 +0000
Message-ID: <2D3D2D8E-4E7A-4B50-A1FF-486D7F6C26D4@oracle.com>
References: <20230601143332.255312-1-dmantipov@yandex.ru>
In-Reply-To: <20230601143332.255312-1-dmantipov@yandex.ru>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SN7PR10MB6667:EE_
x-ms-office365-filtering-correlation-id: f61414cc-4220-40a8-ab35-08db62adef2c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V7DS8GFQQHpNzG7yKVU/+xfmSpPmczXxw9NV4KqLnhA1IMacBo8F7MwsmOSac44znTFcnY4HnD5xad6dFgtV+uoX8I8PeqU/znZYWuSq75k3IsG237vNn9ER7UYcNLx40fdFVnVRtYnosviv/wZiCeuPiEsMEbASy6sK9gdEHvbyDht1fEVpgum5e7jBlgv0sft7LfVVaVhSGi+DOhKcOx96e4iuD4nAOSueVCl8cFDQeczKUWwvJ37DeHNnf9O3QAVS3XmznGZeaPqOb7jfWhqKiqt/D58cg72vVmhOz/H9tIIcpi+gN/cxEYIRDM4zd5vF6TE3OmfUoQtuDXfmAqOP9yC7OfZ3fbw9/Js1Vk1/Pn7LZ/K+LNdV39GOjFkUAZ+KJDnAZ4tYqcljd9/i97RAy9Hwbzd+4FM4iXDeFGLQH30fLwjjg5JGRREhjankSwRIMfBjhC6Z5ODOWHN+FpI0dz9z1UMUKoYAiFQrE4otpinEP8E9/LWu+6UQ+1C0f4C/ZuiJqezpBBHjsumNTQgetvx6h8XPApARn/tVlDU8QayFqd9Sd6mwj/99Ubgo0xnFGrVmIH0qPecWxKx8UVgUVbDnBauoPVSO2HQhXEQ3y+axdGF+wdVb+t7L47vuRsdvBKlqGibCHmf5LfyQPw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(366004)(39860400002)(346002)(136003)(451199021)(6486002)(71200400001)(83380400001)(2616005)(36756003)(38100700002)(38070700005)(86362001)(122000001)(53546011)(6506007)(6512007)(33656002)(26005)(186003)(76116006)(66556008)(6916009)(66476007)(66446008)(66946007)(91956017)(64756008)(2906002)(4326008)(54906003)(8936002)(8676002)(5660300002)(41300700001)(478600001)(316002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9+/4ohGt7zFxGHoCVLC2PFVkHX+VgF1Kd5g0IuNZ6tBy5i4UZkwc9ilJfNdZ?=
 =?us-ascii?Q?j467i04SMA8gxH/l4WwPzJhCYr/AlOGq8eEvLWvdZvYOO6L9sORFI0iUx1Pp?=
 =?us-ascii?Q?KY528dOsnvGfvgoquDpngTTILHkTwaEj96q5ZfsIkbf7YtDiWHhZKYOEk1j4?=
 =?us-ascii?Q?XdgkCeYGE7VZC2MesqBtzyDY6uNdk8yfk6SUh/OlZ32ii7j5jjEy4qsCDdpT?=
 =?us-ascii?Q?L3zd0gMhyEoNNyCxiPKTADExNclL090DLRwyDdUUTbmaLfWGK3/v1TV6sG4f?=
 =?us-ascii?Q?RxdT3/WULiPUiVuK/OgRTkQHZSbQc+nc45IsR/ox1V0gNojJcB10XNyVjAmH?=
 =?us-ascii?Q?yJZ+b6mgeAK3COsS7+UGEzpWmUn1QADElvBwE6Trn6jPJtFp2mjCvF5abaTn?=
 =?us-ascii?Q?6WYE0Yz4EBHLdrWFh+nuYSHGjqTc0LaMI8L2vW5nlH6PBoibNNG5wqTU3d8i?=
 =?us-ascii?Q?gNGffZ9yl6FL+eaYpWvlObkc3cnNAWjNFMUvzjHIgD7RL7khkacoiT5Sj6Mi?=
 =?us-ascii?Q?bQSo6M5jd/ZLmwUM/4wvFJYUp5FLwaU1LtJxUk5NdG/JYShNsojc++xOHfx6?=
 =?us-ascii?Q?FyNtp9IGwbt71PSAaXvplvX0mL0fAOl09BZ8H+2/Q6Q7Td0vSgAmmk/HDJCd?=
 =?us-ascii?Q?Ywi66A02GwbY3seyVH8RUXl/nOowoudmt2i3fjgZhwBI2nLzMoqGqqXlIPzk?=
 =?us-ascii?Q?xVmRhkHE2dTfwlG0mhAWhT9SV1Y6Rns52WMtLniQZXVJtGsmSG+040r7pJXN?=
 =?us-ascii?Q?sbAaTiNk7XlbhZSaM4jFExeCk4Gsl4g5nkS6QIVwN7KxiQUV2cLEWxWbi0IR?=
 =?us-ascii?Q?eq0rA9VQGWpLAgDTNYnFiF+qSYCQ9xNZ3DJctp1xqmTPQb7GF/UjahyBN17d?=
 =?us-ascii?Q?YJTyrhcayNAny6sx/COlytG305eziGqeJWk4Z5pAenbCrGbDSezy1nVlLTQy?=
 =?us-ascii?Q?zDGx8B4BXSB0ByoLtE1xbyp9wfAwY43mG6Da+Fd57KH+XQSaF0QDwCcJOa59?=
 =?us-ascii?Q?wrBBNn7i8aDpIkWBE6ai1aXMtoLUdkyu7hfPW76bO4HXDgviJtb1at8iVGwA?=
 =?us-ascii?Q?VZwld0l9+iodcXicc6+5KoFnlCzS9VWw2zjUQXf1tDdHdlnBDTtDQ5Hj/VaS?=
 =?us-ascii?Q?2c6Og+Py1pEpA51VSmuHr0gOAxfD3eXGXo2U/hRy5ebdFfa8le/bbWrZGuv1?=
 =?us-ascii?Q?zW9KlkRebEr/G8enMmv6gorvPyMQMqq3CgLf08LIpI3iyl4oIZwaxZMS1elq?=
 =?us-ascii?Q?FHqJlnneUGk2IAPzjEdrj5CAY2V7lvGLFMnMKlO/+aAn70crHkxLKgteb06Y?=
 =?us-ascii?Q?9xObdOjJt3d9on9FqPXLIQZ1bhZOhO6HOS13BH0JbOEU8+fPccirZF1D4mm3?=
 =?us-ascii?Q?Fmhn04TILNzHBg8r6T4bDbrqTDwZEaDC4Qie6NbfCLrMFA+w21MhGQr9tizT?=
 =?us-ascii?Q?c21i2d+o82Ie7oWKbtiRoBkA92yYaLmjqVkfreuHcjPDyMjcaX2cxjcAnSs9?=
 =?us-ascii?Q?tTymfXuG8XSKYjHy1nMTk6OVqa9pfz239AzAYioergM94L0IRG5FE5iJVh18?=
 =?us-ascii?Q?bygGzVs0x8rVku4OdsX0aeCRPIYCNROKFo8HQPxxI7uek4fJZWtssU8LtZ4Z?=
 =?us-ascii?Q?qQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3C10D17724D72E448617FD47B2CCDD4A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: xiw6Kmo6/AKkgNrw3Oo/FSlhUheJ8rzugjl7GC9ERY22Cog3HEQISeDol+R7inN9vRdwzTuN2NBvw5cmjx8VVTL/97liuJX3C0Bd1tdSg1Nb7ELeEjk5Ho7STB8/aSB4epfQ8pQ7BUZhyt+a4vRdHmfguZItZZ/UuHdYv4C710ndYkSJvyleDCFlczTGluKIWOMgZgWkmhzL/SaGKyPg56MJyEya7pBL2kqH3u11KvxRg8HMyOog/fRrFCwZ8C1sgSg3j8/clUzLDZszVybAceL5JXFAYDfSP5yALxn4ecNTpmJ2uJaqSV9pFcip2XMN110D6AX3fGBJGYEaEh/cK3hpwBDHk+FFBRTywym2p8UuntULUXgPIS/vkvcGtRxqfWsGFRicgulaLo28hm7bHsS6gfDS+7dRF5AwjAOcDXTn4QigxNtKSmmnvHWIbgNGFcqKUOqddTfg6Nz8U2pf94d3iYj43Gj/t/VlyQwRl4awthaNZiu8hzgOKC7PCFAk0Ob1zPLB3bvflm6kxzVvmDroKuVIp5ZXQ4b21J3EbUqdOmQQmxuySU7d8Q+pAtGDqYjzRsKDtIGg7ecA5KVIfXOPmAQKVTeKPU3MmA2gce4Bdrnh8jk6cT4nGofhZ2b2ifa3CtvvMEsen41GcDgUcsY1KPpf4G5Uioh568jwesTtN+V48noXlXv/YsZ9070lyDQR5ZtIYkj+UcV6Bm+vVQ0+j7jVyOfnoTndaiPtKphc8AtuVLrLZikezE2biJ+M1T21r58RmMvsFjnXlqf31fWUlA2aWFf0dtpFz65RMjDepKVY66cNPofRVhFg2V/H5fjB+Gos15inGcADt111Ux1KJkKpIs5IGaxWnBZ8mseqUBUg+bjqOk72MEfuby9T
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f61414cc-4220-40a8-ab35-08db62adef2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2023 14:38:58.4050
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lmkYNN0EsVwUHCZ3dv/DgvL6q/76KZt7hXlSkudUz8K9MV6m6Npq2dtqcoEAil03ADJNBx5LyBOqdOjQhVfqMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6667
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-01_08,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 mlxlogscore=757
 suspectscore=0 malwarescore=0 adultscore=0 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2306010129
X-Proofpoint-ORIG-GUID: Jtzq-UHpdMrrH-Yl7GiMGXA9uzKXQB-g
X-Proofpoint-GUID: Jtzq-UHpdMrrH-Yl7GiMGXA9uzKXQB-g
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

[ adding Dan Carpenter ]

> On Jun 1, 2023, at 10:33 AM, Dmitry Antipov <dmantipov@yandex.ru> wrote:
>=20
> Fix the following warning observed when building 64-bit (actually arm64)
> kernel with clang-17 (make LLVM=3D1 W=3D1):
>=20
> include/linux/sunrpc/xdr.h:779:10: warning: result of comparison of const=
ant
> 4611686018427387903 with expression of type '__u32' (aka 'unsigned int') =
is
> always false [-Wtautological-constant-out-of-range-compare]
>  779 |         if (len > SIZE_MAX / sizeof(*p))
>=20
> That is, an overflow check makes sense for 32-bit kernel only.
>=20
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
> include/linux/sunrpc/xdr.h | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
> index 72014c9216fc..b2d5dc89cf7b 100644
> --- a/include/linux/sunrpc/xdr.h
> +++ b/include/linux/sunrpc/xdr.h
> @@ -776,7 +776,7 @@ xdr_stream_decode_uint32_array(struct xdr_stream *xdr=
,
>=20
> if (unlikely(xdr_stream_decode_u32(xdr, &len) < 0))
> return -EBADMSG;
> - if (len > SIZE_MAX / sizeof(*p))
> + if (unlikely(SIZE_MAX =3D=3D U32_MAX ? (len > U32_MAX / sizeof(*p)) : 0=
))
> return -EBADMSG;
> p =3D xdr_inline_decode(xdr, len * sizeof(*p));
> if (unlikely(!p))
> --=20
> 2.40.1
>=20

--
Chuck Lever


