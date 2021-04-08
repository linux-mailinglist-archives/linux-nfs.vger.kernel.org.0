Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82F8F358851
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Apr 2021 17:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbhDHP0O (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 8 Apr 2021 11:26:14 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:47740 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232001AbhDHP0M (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 8 Apr 2021 11:26:12 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 138FPWmD010726;
        Thu, 8 Apr 2021 15:25:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=afKWK8xVbfbh7kMGqjp+UvFiSpDiws5dKdByArx58sE=;
 b=bDq6VOLKhx1H0lsFROmsLfVXEeisQ/h13SWtj01/wPozJHDG/F+0GX07kfcDt5/VWFyn
 fJEQ9B7J9ICnaJakGV4XWxJd8+V+ev4xMXOhTz/fCxofkxBatGDO6f9VU4KtImfOAVc1
 IrXCOw8wIY9rffTrF75vLEbZ1VCmg4pDosGY1/1/Yd8YO+nr05Uyh993l9JX+endssGB
 UX1Y7c3lza/G5Rhm1RSIqUstPRYPNFD3jqmUrSy7iIHqWNvtpWbCN4fRh/l//fofKJ1/
 lZ4yN+WsAHfOv9buRMiF0oHsvsCL5D46pYsi9jvYIjYE5r2VgbiDsoIyo/MYFl1I4nKo ng== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 37rva66a4e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Apr 2021 15:25:56 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 138FLAPG091960;
        Thu, 8 Apr 2021 15:25:55 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by userp3020.oracle.com with ESMTP id 37rvb1bqqu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Apr 2021 15:25:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ah5WShw+sYIIEflXZqt6gHifFK3cBdcV1W1++P7rHX15mibydobizSLTB1I6pMSgSJOmK6h0VAyc2h93xb++QL0i7DIgfA9RPvIJhuqVW7tYlYM6CtaP5S27gKuCEIfMsyAOnsUlRsA7M/UfcEOU1yUi2Ka48Kd4UB+GTAmKtVJ/ZfZVwhkoUqgQd2WLG1ZhKDFf0L2IuTiJ3D+kQSvDFPGp6eRDSnfdcBWte9XEuGW5f9PwPxX7HkSCIeewoYTsoBW635ilH/6x0S/S/mb0pDVzuwURlQFf2RLnftSN6m+0VVKRj1OJQ/v6akfSeeFNEyGHnBnk2ENtYXRmXHtVoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=afKWK8xVbfbh7kMGqjp+UvFiSpDiws5dKdByArx58sE=;
 b=fbOHR4f5qwbvQYD0ih8Zb3Fa0S0DdAmttLTLNA8yQrPFLKmGm+C0nNTKODKKcr93ZJ8APDv25wVY2m4rQxD+fTKUR5lUbOYVhYH+SkGokvzqrwqBtp8QRvMoAqqn2YwyTFK/nz3Uc8CHTe8kF65Jft/VBwHkyrhZ0IZm6HBNkfZ+41jSF3X22j2eYAbfQmvRE6LElSzAhQydZ1bH7SVdXcv9G/a3953uEJ7tx0L6gH+j/jvOH+0XUOkv+2YMEOkm3Ww3xJsc5euP3o5FcX6lXiWOpVnOCmb+pBqpKUHIeEIBD9vIhSzjTqWeh9V+L6OtAdvBs/KiBTRe9V/oMOZ2Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=afKWK8xVbfbh7kMGqjp+UvFiSpDiws5dKdByArx58sE=;
 b=y+YUCXqamBdllzTcm5PCJhek9rLYbZxspUipuM/hJgPzb9p8YcXNe0pOwPhS/toJlZvzTI7hb8k9Uszym68zWAYhT//enYJ9NOC3y+3f0i66y5GnznUlUrxNPUCNiirie86IfgTi4A00fvIbGTq7oBisvMr8857d2yBf5yS1dec=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by SJ0PR10MB4768.namprd10.prod.outlook.com (2603:10b6:a03:2d3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.20; Thu, 8 Apr
 2021 15:25:53 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9%4]) with mapi id 15.20.3999.035; Thu, 8 Apr 2021
 15:25:53 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Dai Ngo <dai.ngo@oracle.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Bruce Fields <bfields@fieldses.org>
Subject: Re: [PATCH v2 0/2] enhance NFSv4.2 SSC to delay unmount source's
 export. 
Thread-Topic: [PATCH v2 0/2] enhance NFSv4.2 SSC to delay unmount source's
 export. 
Thread-Index: AQHXKBgu9IXq70YdMUCq9qUqUB+L96qntQoAgAA0ZoCAAABtAIAAA/oAgAAAWACAAAyNgIAAS1AAgAAC94CAAP2GgIAAC9wAgAAeIICAABT2AIAAF5kAgAATgoCAACPHAIAA8l4A
Date:   Thu, 8 Apr 2021 15:25:53 +0000
Message-ID: <BB59428B-1B24-4FED-9465-F721EF99EFED@oracle.com>
References: <20210402233031.36731-1-dai.ngo@oracle.com>
 <D85FBDD3-5397-4D47-932D-159AFE2A5E0F@oracle.com>
 <CAN-5tyHVOEr7zZM92PVS0GYJQ2M6rSs6_zqZwuioumQQm7zzUQ@mail.gmail.com>
 <7BED2160-1052-49EE-BB62-6ACF6F84C91C@oracle.com>
 <CAN-5tyEKqNHmwiMfCpkZrCVYeaO-FH69v5L4Tk_8EsoTfytpVA@mail.gmail.com>
 <01CD778D-57A0-442A-8D1D-5084F0FC2497@oracle.com>
 <CAN-5tyFEXBiWVbCq0Hgh01W=OVZkdYYAEujSug6biBaU=Ny8Og@mail.gmail.com>
 <99a1f327-ce69-e6eb-39fc-77991bec5b4c@oracle.com>
 <c16b4437-a554-be60-3c04-fd578b9f88ff@oracle.com>
 <CAN-5tyGS0ZO4PtTseLSmC4=fYQCUwMs6FB509g2PSCg1v+jySg@mail.gmail.com>
 <0b0c7c79-d593-c4ae-db9b-46600f2cea28@oracle.com>
 <CAN-5tyGw8_xOfMM4PNUCvo_wKEHs5NgLo3ZQf-sTGb6FHJ_r8Q@mail.gmail.com>
 <3b6e1b4f-4276-e503-9432-e15a339cac9f@oracle.com>
 <CAN-5tyG7HPQxAK-o-q8=_-wtewBcymian2AQV__p=HgL+jJPcQ@mail.gmail.com>
 <d9a26bed-6e29-a0ea-b6a0-2fd30c240a9b@oracle.com>
 <CAN-5tyG4gQ4t0PF9v=8m4BfS-a3iRud0ywmLX2g-Vm8+FCosJA@mail.gmail.com>
In-Reply-To: <CAN-5tyG4gQ4t0PF9v=8m4BfS-a3iRud0ywmLX2g-Vm8+FCosJA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aa373fd5-4eae-492b-baf1-08d8faa29947
x-ms-traffictypediagnostic: SJ0PR10MB4768:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR10MB476894102E9CD19A15EE5D0A93749@SJ0PR10MB4768.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5aMx4cSKjcmAyahmKwM7N+n+u+5mESSPYG4nl40VjCDENu4Rng9xeNnFzTEGcbztdIWRBicG0Za/nhBoe9Z1vGipnTanszkzwaCegO+VrK0jLW3TdYVqTJbNJ1YK8AEnc9XTY3wISjx0+JaCKGBmgfhgLK9q+jumINyWR5lGepx91bpc6VPvEmtKUWEywTeANoy1Ax326J8Budd+PxT5dSsVuFunedFxdvAa+FEKEFpsLju5VKz0jJIeq5mHFznqYnFUc1en+CWK4by4XSp91+b6/DP7CMAb9xofj+qxBfoBZGDptGLHw1b037IHNMoz877JtOaHcKiIvQXDES+z/5k94O1H9imH1DwQ9qLUF5Ktlty+2smWhU8ZBeJzWUFrgjgtwr5V6CxE5lwZoDfob59iHghe+Yg37m7IeVJK9ScU7XPa94uu0YCqyyUl12l41+urAzVdULUXfrMWp13xmjG5h+H+Bn1YVFub2apiPJAAX3zMXOKfEURrSzX2RorrlQ3qMxxFY2BUJXTG41728tE/j4nZdAUth5WsRlP3ziN2lhiUU7lF8YZ70eDmGIyp9RMGY60sBW31e0od1J5yUy7D2SZTs3MxA5F15z8vnP+AvM46o8NDsy3Sm+jnIAr5uWvaEWpZ0cq1GtQ70ZoZpQFf3YDVDl/x1M9CQbXQf6rFVEEja3MDCqZIIvxnLruN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(39860400002)(396003)(136003)(346002)(8676002)(71200400001)(86362001)(6512007)(36756003)(53546011)(33656002)(6506007)(478600001)(8936002)(4326008)(66946007)(66476007)(66446008)(66556008)(2616005)(91956017)(76116006)(83380400001)(64756008)(4744005)(5660300002)(186003)(26005)(4743002)(54906003)(2906002)(110136005)(6636002)(6486002)(316002)(38100700001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?n/727WjkbwpS/zmUhJF+Gfm8OGB2XqkzNtuwVXZGO0ry8wWFwQZiiRgwcfcX?=
 =?us-ascii?Q?6u6D5hJ2imzaLy8ls71ZpGqgXFKrV5nCPyorGGoVsHGiX5zSplHg3J3xpugO?=
 =?us-ascii?Q?9hMgMP5u8EI+GZQfkpvTnU0naognoD/76e+27uUWyLodGThIapOYJ45lgs4a?=
 =?us-ascii?Q?y9mm2spfVLpTo+LstjvDw82EQeJbSWr17QdWLkgoI3KTpgSJLX5MYefggk/p?=
 =?us-ascii?Q?BzmfSqJYK8p+vdU3M/GeVeMabmyxWheILoqW1UWc765WLia5eUDjOmYmqk/i?=
 =?us-ascii?Q?G1WMfZeyIcwf96MFVEbxiolXslYosh7UFnMbSG/0inaSVaFGvZgiaQFY7uXi?=
 =?us-ascii?Q?DE9nBzrZz6hM/fdEsANTRhg9PYehzhQ3QkBut+0GMS2LQmpkfLdEoqim5xuh?=
 =?us-ascii?Q?zDgEEXEgdJk+TjOzoXlTvn4eATY36EKTSIqbI07FSvDn205b0NqtguhOIXGd?=
 =?us-ascii?Q?fAzPgtnpqqjIE0S9slWoebikTK3s0LkVGVUZyuUV8FKZqirKKnTd02TEJO0N?=
 =?us-ascii?Q?uu/gvv7PxihaG1906NahWNAZkbK04oaT2liP+j5vsLXO30306wCygS2b9Qp+?=
 =?us-ascii?Q?4e6+z9LRojjRA5dmNE9hFCGXCiWp6Hy+7vnlg78Xe6rSjLiqUoaHP2xWZiSZ?=
 =?us-ascii?Q?V77sItaymMwpY07eTR1/bIfuiwdqCFhuPjk0h1B39Barkx4xd3zuU64VY0kA?=
 =?us-ascii?Q?+UDoemxlteVE9gGv6Ad6D9XLUd75kx5zDd2m1EQLuHJ4LjSdndpOScKMWX/U?=
 =?us-ascii?Q?h+4F7FingMwCNxDhNQOe1OlZT7eLgS5ZKs/jY0MXnzuVq50vumHG3DMS8LPL?=
 =?us-ascii?Q?5rXbsP47gCFcuS/vOVUEhLF9+qXzR3h2vtbNhytHjo1TbDMRN9uYPoU7Oh/g?=
 =?us-ascii?Q?mx4sdWMTpsixlF/h7O0BWNZWswK8iesVD2kw7QhRHNidKr0uI++z6xwENaOE?=
 =?us-ascii?Q?AN5LX1SIjpqe/ljNnjcHUcgEy5x7vYESYwcGB98bh5oXm29NmWJOA+y5LJ+K?=
 =?us-ascii?Q?MsHI5+1rfESyRmBs/THv4KAsuSBoCyfwY6uGwksLMB08lyakJc+ChfNQbhIb?=
 =?us-ascii?Q?JCMMYNZHbxE97M6MHbIGzFhCoAK028EeOhNJAjvpmykFnoR10NEVr84lgjbj?=
 =?us-ascii?Q?tSFUReOd0fDXIW2ShuxWkFMQgPvdmrt47mYOEQVi3ItP29J/gLyrSjxiRZWf?=
 =?us-ascii?Q?0cv14ED/wDUVJnI9mOOOlBSLNU724q8WTW4JRxsSeRjQeqFoBApaCHbQH0yP?=
 =?us-ascii?Q?9AM7U48O5EnhRDi4K4Tn7mXJeX8Na6K7PL+OAsfZQzjRCsHvvmXgxB9JFZey?=
 =?us-ascii?Q?0ZM4Gaz6KTLc1SZRKLk0a3Hc?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B869CAE86D91F149A013E8FB8C36FF92@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa373fd5-4eae-492b-baf1-08d8faa29947
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2021 15:25:53.5070
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ge6CzPbdeD2PLh0jJd6VYyHKd/OKyAkBXqewjaHtk+2M/TBfWsT1A/IU0tZfsSMBf77RrgJtlGsYfMkMp9Rrzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4768
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9948 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104080105
X-Proofpoint-GUID: 6tEMhmJwWTW3v1FgHlRMZ9TTEHZdsjrf
X-Proofpoint-ORIG-GUID: 6tEMhmJwWTW3v1FgHlRMZ9TTEHZdsjrf
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9948 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104080105
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Apr 7, 2021, at 8:58 PM, Olga Kornievskaia <olga.kornievskaia@gmail.co=
m> wrote:
>=20
> Furthermore, I still really would like Bruce or Chuck to weigh in on
> the use of the semaphore.

The semaphore caught my eye too.

The usual trick to prevent a mount from disappearing is to
bump a reference count until it is safe for the mount to
possibly go away. Dai, if you can make this work with just
an extra reference count, I would prefer that.


> We are holding onto a semaphore while doing
> vfs_kern_mount(), I thought it's frowned upon to hold any locks while
> doing network operations. What if vfs_kern_mount() is trying to reach
> an unresponsive server, then all other unmount are blocked, right? I
> still don't understand why we need a semaphore. I think a spin lock
> that protects access to the list of umounts is sufficient. I probably
> should be commenting on the actual patch here.




--
Chuck Lever



