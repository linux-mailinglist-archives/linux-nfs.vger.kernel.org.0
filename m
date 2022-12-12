Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE29064A81D
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Dec 2022 20:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232816AbiLLT2i (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Dec 2022 14:28:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233011AbiLLT2g (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 12 Dec 2022 14:28:36 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB8686362
        for <linux-nfs@vger.kernel.org>; Mon, 12 Dec 2022 11:28:35 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BCGwhua010536;
        Mon, 12 Dec 2022 19:28:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=ziWsyMZ1QIM8v4lRAGyORw/NOxRCJJzoLswwZEqkXO8=;
 b=2idPjVoCk1T3cbSALnGIjXP73HwYKikMVRrCX0gSPUQbHs6IcrihAz6b+dBP0WxBBR1f
 enF9Pw0DOAJ/BnZTkb1krs29NPRGYmkuQ4Jl6eVxl7+nFAGHLxmQIBVonfLO+PDWQ1Cq
 u7hJyCBQU7YLZrJxX6pPtYceUknVt0zfYztnrucKSd0qEHQsKUvLk8nsc7NV9SjtoXTG
 RsiGay5JqO7JCogpbvV2CvWWq9CFg9+2J3Yjk6+8UDcgtr/nSxF8OT+TjP05+sJck0z/
 K9uEdpAHKuo6E8UsMyZegmf0KkRiAuRCxpzNf9BQsqRjFliRb31Mkg+2L8oyv37NcCt1 RQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mcgq0bqu0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Dec 2022 19:28:31 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BCIpKZm009143;
        Mon, 12 Dec 2022 19:28:30 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mcgj4gn3x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Dec 2022 19:28:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eB+tnALjKr0c9JjEsisShiOBIT16H9fRlA8/InKmR3kqq6uRG5PQwnKIAVzgQMEM1OKhTcj/7qYJWZkVrxeXGtoNxL4Dp4LzpPw8cqRKQ/QbD8RIp70J8yh2nGfHMu9WZwD7mbgxyKd0UrCogyv0j7mIwSEToQ2OR8A+0WwrtNm7ZRS3sQjKEsicfBWH6kor+pUe8WPCy/LxDYDMFP8B7IvAw4hfQuRFi3gFjib06W0AHEwFa7mlqUH2TmftEeqTCZo+wf/3GAGW49BV8V/vhp6YoBHPULCAcODEFRrOtQI9vMqXYZ4soFOcP0bpQv3ZNwmFqQSQcKFiZ8zVLObAXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ziWsyMZ1QIM8v4lRAGyORw/NOxRCJJzoLswwZEqkXO8=;
 b=Wl93SHvv3NFeLqtI7wrNIwkmCnlhVMSRBj2xRFbDlLwZRHqaCNUcC7nEfUVMfgNpTLLUfJewIX0RDzOeJsOD0TsfpFgO0a629o+UiiSf/qAzP7rAMVRnUXAe+NGOgomR4vsb2kSrn80ZTTLqH2jKqYpyReZez2mH/tEw6YOATL0vZj8TYgtSvJQoL+Qo5GOCQ60n3Ku8FEPe3WShzj0nPff+ylV1nv40b+BN12+EnI/SaQbvIMNGeJeGWQI56kQksWtTWYgr48h8JQctXMIxvmnbZUP81Pz2EPgWzFAbwJEd+qRW37CQhtwJ3zyfXSvW2yUJy1A6MLgau4h+eYyKow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ziWsyMZ1QIM8v4lRAGyORw/NOxRCJJzoLswwZEqkXO8=;
 b=py2uji241hHKkDLRG0Y3Rg0Q0DWH7H1+wXV/FpEavZxkGsm0QtncQDx2dGfspdOTLZI7wl+ULQoi9tkEMoquQElNbOztAg2p5g0MNSDB1OXNs3MK9bBUobfitM3eEGz2M70d3id/FPZyXipxhCqEG2m8ehQdwVkTIjplJbUmEDE=
Received: from CH0PR10MB5131.namprd10.prod.outlook.com (2603:10b6:610:c6::24)
 by PH0PR10MB4469.namprd10.prod.outlook.com (2603:10b6:510:32::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Mon, 12 Dec
 2022 19:28:27 +0000
Received: from CH0PR10MB5131.namprd10.prod.outlook.com
 ([fe80::773f:eb65:8d20:f9c8]) by CH0PR10MB5131.namprd10.prod.outlook.com
 ([fe80::773f:eb65:8d20:f9c8%6]) with mapi id 15.20.5880.019; Mon, 12 Dec 2022
 19:28:27 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     Jeff Layton <jlayton@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Olga Kornievskaia <kolga@netapp.com>,
        "hdthky0@gmail.com" <hdthky0@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "security@kernel.org" <security@kernel.org>
Subject: Re: [PATCH 1/1] NFSD: fix use-after-free in __nfs42_ssc_open()
Thread-Topic: [PATCH 1/1] NFSD: fix use-after-free in __nfs42_ssc_open()
Thread-Index: AQHZDZX0xFKY8ZoZ9kagScnVZShYCK5qLYgAgAAUMoCAAAG1gIAABUyAgAAI5YCAAC2LgIAACFOAgAAJJACAAAYsgIAACqCAgAADN4A=
Date:   Mon, 12 Dec 2022 19:28:27 +0000
Message-ID: <4CAE538E-9F0B-4B44-956E-C6498A37A83A@oracle.com>
References: <1670786549-27041-1-git-send-email-dai.ngo@oracle.com>
 <7f68cb23445820b4a1c12b74dce0954f537ae5e2.camel@kernel.org>
 <56b0cb4f-dfe9-6892-7fef-1a2965cf1d99@oracle.com>
 <0ab8efccae708faa092a56c6935c33564814bfed.camel@kernel.org>
 <Y5czwRabTFiwah2b@kroah.com>
 <a47cc610af621e95ba359388e93d988f1ef5b17f.camel@kernel.org>
 <Y5dha1Hcgolctt0K@kroah.com>
 <7365935036c192bfc64cda41cb9ccb297e3eb86f.camel@kernel.org>
 <6D5F96AA-A8A7-4E19-A566-959F19A3CB0A@oracle.com>
 <6200943464679d51de50a05ab2ca1cc0c91d8685.camel@kernel.org>
 <a895cb89-f8f3-a2e1-1958-cf9379ecdcd5@oracle.com>
In-Reply-To: <a895cb89-f8f3-a2e1-1958-cf9379ecdcd5@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR10MB5131:EE_|PH0PR10MB4469:EE_
x-ms-office365-filtering-correlation-id: 16bfc82a-b1e6-45d9-a3fc-08dadc770b6c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dTRgSvqoxS8Xkq0aU2WEdC5T6okJ7bA+mvZcqbjedOpXqLHrOAbP0NtihZFtQotfFEfOrJgLJFBXDLejQri56RIuswOT/LMnpIeGWgwKygf94BNdQyC54FO3tPMDlf+kNzGvdwfMv+xB4HuFqAkq4c8aTW5QSYyOP1F3GV3mAdxD/c5onZFUHeZFBnqsPrnwK7RMvx1UTPdI5rB2Bi/e9nWLECorkJBRho+mzAPJYf+m0RsFwG7yaNf+b4HA/s+tM9AqXfs95TwXn4FaAQW1BZQMVtFpnpnIaGWkxOj5QcdUaid4ByC/atYGZ3dmceMaWDo8ZbYbfz2Lc1Mc/6i+QBzE7NHZXnx0bhz6p+8mpYFnmxFjw9YiFH2xT+Mxm7UDvNGS/PVdckknqPrLtQxVh+dI2EMuBtNKohcuqzE8+vm6xsU76y4fzx+pIhGbHy1sfjOXc3JHbL5uG+yt0WdeXvIAI9s3nUAjNfzjki1pYfDvrPpA+2n+DDfCcZPmJ9kz2MwXtSkMsiX5fRJwbtslpVxLTjsiMR4CuyrQ4VoJ7eYpwkThPlKxUNkVlq6/YLW1HQ5vjYRzgh/fh0ANESQpX8/bHBVBxgBck5/W4ms7+ID3f3Q89/wtoBqicnyJUUOwYhh8tF1KP2EXnhzHIcgd41MLAhOdGDWPpyU0Bxdwy2PeqOVHwGb9K9mxVwLYpgbjRFZER0OYHrMSMESu9gpRGFNt9P+79SR1iVdzv4q91Uw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5131.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(39860400002)(136003)(346002)(396003)(451199015)(6636002)(71200400001)(316002)(36756003)(37006003)(54906003)(4001150100001)(2906002)(6506007)(478600001)(6486002)(53546011)(83380400001)(122000001)(38100700002)(6512007)(38070700005)(33656002)(186003)(26005)(2616005)(86362001)(5660300002)(66899015)(8936002)(6862004)(41300700001)(4326008)(66556008)(8676002)(66476007)(66946007)(64756008)(66446008)(76116006)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?V/U7YjgW6rGpbVtgbPNVR7VcVImyy5w5l1tqa1aKjOzzs7n8oliJMVbnTKo6?=
 =?us-ascii?Q?wbAdn3SPL8n255hvu4xEdn36HeXjfl5lIks+gc/mWc/qqpGAz8UYMb18CjYZ?=
 =?us-ascii?Q?TLQ1BFHtIxWSzI5aoCT1g7/0EJkryBbU3xtTGstQf1KAAtyIJFl/ZdiMTC9C?=
 =?us-ascii?Q?G0xg8nIZdquI0hiGxEb1n/zRZUKZ4zbs4a3bNV0rEAMQl7qLUh7EUxfKc7ct?=
 =?us-ascii?Q?92sW++NrZaN+LrO+G8gzycCQtoIvO9Ymqz7sreqI0uiufrOhglgOhcBp0csQ?=
 =?us-ascii?Q?bYpotypjvCWAfizcnOVFoJXYMS04/VOSSkvGtrCWiuFq/VzUTCfNQeLjGgVA?=
 =?us-ascii?Q?42tCEkRLBgNTgGImOWyNfmoa0AWZ6mcDTIq/kr1/Zg1JCH18OJ/Xa8O75hh+?=
 =?us-ascii?Q?yyk9jh/s59DF4MoJyCsiptpfb3/cULCpVk1jlFh/ACn/gXQajoAtgW50/7V2?=
 =?us-ascii?Q?7evDheivE0Mv1QogWI/LpUSsnoJ5Qoj585wqrl9bkAFOwPkmp0Q3K/JpI0vY?=
 =?us-ascii?Q?/t7h0Qht4TsAoptYH0uBinnFv904Hkuv/6wupfXdZyxiXqxaKClDxSTrKqFm?=
 =?us-ascii?Q?ZRWhpstVf++nMYCwtZ7TQKlRlDOQB7/9+TGAkN0z87MPq3spFNGj+idiF1Tb?=
 =?us-ascii?Q?m92/k1wwFB430b5CvMqD4FXzugXxun6TGqLkeXyyGu+A7pr+76Msk5W/tMNG?=
 =?us-ascii?Q?FSL31MzfDvxUuSeiqsqusTHq4CeyebdHJZ45vItInziJ61q3h0kYS+EqSSVG?=
 =?us-ascii?Q?xORqf1CYqL/j6dHzpVT8a9HTHyap1M4DV2BpTlZqCDp9nVNlco7fmsS0crCZ?=
 =?us-ascii?Q?G6ePX8CyDFQoYiRDeWRyQ4z/HJALaus+qs6hXrPxReDu7ehcRq54bRU0rn6O?=
 =?us-ascii?Q?bBFSZzRt1Aj81EcsY5eNCM2GFPP5jjH9mHXXJg3Lny3Dgt546AZ5iakyF4nH?=
 =?us-ascii?Q?c2y5QVcG5We5hz6CqBy6/F4CuJt/HPy1AlsduzdzUVqfqn1Tjr9ea1dZTGg6?=
 =?us-ascii?Q?QcY4JqPfreeBqrr3ipTFhZvdn2Qt9ey3yrSM746KgLIYrpbs9iYmSPB0P2cP?=
 =?us-ascii?Q?Vc4uPWHFWtPMRM1cQ2AFEPW+um9PpXA5fBZf3giym9AMmEler9CXkafwNfln?=
 =?us-ascii?Q?blEuUbFKUbWOgxoDItcBc/nxf5EPD4C/5RE1Hef5y8ydb1MqazqeE6+FVzQH?=
 =?us-ascii?Q?wqf5mUTFgcALMIe6m/PHqS7NSsZES6sKwmMf9iVX3Zv5C3oV2C0qIIf+50rD?=
 =?us-ascii?Q?H8bRnqrrC/j3+K9QcFMXOMj8WN+EriRy0VHJ18XiRHjMhQvlXEZMeFjzcbKs?=
 =?us-ascii?Q?flEv2uCtp6SucJSs7lTIMfhwAsB4k+iUQvyPXAmRNKybx73NmmYnBn4Ncf0R?=
 =?us-ascii?Q?XwAZGmVr+leGoZw79OW4R3wTgSdGROahJ41hc7fz/bL53rsYbOSFeBRdvKWR?=
 =?us-ascii?Q?37ArRxeAbn/0gA6CuFiI7tWLLAlVHzyUZMWpnuPYAN6uq5tGn94ozOOgbHFg?=
 =?us-ascii?Q?yuY1ytzgnQoYKtygk6rmIm/XeKqexcgOIFa48El7gUfvDfbDoWS3nCC9Dwte?=
 =?us-ascii?Q?/8GpJoIp5YcG9cErh3qAcaDfwqfts3uHDkXDxsRomDYaHpEwbqWtCRR2Z3XP?=
 =?us-ascii?Q?EA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F21914AD963B424EA617D9E106EC89A0@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5131.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16bfc82a-b1e6-45d9-a3fc-08dadc770b6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2022 19:28:27.6922
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ygFl7VsXxLRPk+dks5xB1Qm5dj1ckEjQZEq86WhN9doHWweIHHoqAzhNXBzdX6L1kyaZMwBzFvCwGCD79sfqJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4469
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-12_02,2022-12-12_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 adultscore=0 bulkscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212120174
X-Proofpoint-ORIG-GUID: TGw5JpkVRZWMWotbpxa3pdj2xiNbyFce
X-Proofpoint-GUID: TGw5JpkVRZWMWotbpxa3pdj2xiNbyFce
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Dec 12, 2022, at 2:16 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
>=20
> On 12/12/22 10:38 AM, Jeff Layton wrote:
>> On Mon, 2022-12-12 at 18:16 +0000, Chuck Lever III wrote:
>>>> On Dec 12, 2022, at 12:44 PM, Jeff Layton <jlayton@kernel.org> wrote:
>>>>=20
>>>> On Mon, 2022-12-12 at 18:14 +0100, Greg KH wrote:
>>>>> On Mon, Dec 12, 2022 at 09:31:19AM -0500, Jeff Layton wrote:
>>>>>> On Mon, 2022-12-12 at 14:59 +0100, Greg KH wrote:
>>>>>>> On Mon, Dec 12, 2022 at 08:40:31AM -0500, Jeff Layton wrote:
>>>>>>>> On Mon, 2022-12-12 at 05:34 -0800, dai.ngo@oracle.com wrote:
>>>>>>>>> On 12/12/22 4:22 AM, Jeff Layton wrote:
>>>>>>>>>> On Sun, 2022-12-11 at 11:22 -0800, Dai Ngo wrote:
>>>>>>>>>>> Problem caused by source's vfsmount being unmounted but remains
>>>>>>>>>>> on the delayed unmount list. This happens when nfs42_ssc_open()
>>>>>>>>>>> return errors.
>>>>>>>>>>> Fixed by removing nfsd4_interssc_connect(), leave the vfsmount
>>>>>>>>>>> for the laundromat to unmount when idle time expires.
>>>>>>>>>>>=20
>>>>>>>>>>> Reported-by: Xingyuan Mo <hdthky0@gmail.com>
>>>>>>>>>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>>>>>>>>>> ---
>>>>>>>>>>>  fs/nfsd/nfs4proc.c | 23 +++++++----------------
>>>>>>>>>>>  1 file changed, 7 insertions(+), 16 deletions(-)
>>>>>>>>>>>=20
>>>>>>>>>>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
>>>>>>>>>>> index 8beb2bc4c328..756e42cf0d01 100644
>>>>>>>>>>> --- a/fs/nfsd/nfs4proc.c
>>>>>>>>>>> +++ b/fs/nfsd/nfs4proc.c
>>>>>>>>>>> @@ -1463,13 +1463,6 @@ nfsd4_interssc_connect(struct nl4_server=
 *nss, struct svc_rqst *rqstp,
>>>>>>>>>>>  	return status;
>>>>>>>>>>>  }
>>>>>>>>>>>=20
>>>>>>>>>>> -static void
>>>>>>>>>>> -nfsd4_interssc_disconnect(struct vfsmount *ss_mnt)
>>>>>>>>>>> -{
>>>>>>>>>>> -	nfs_do_sb_deactive(ss_mnt->mnt_sb);
>>>>>>>>>>> -	mntput(ss_mnt);
>>>>>>>>>>> -}
>>>>>>>>>>> -
>>>>>>>>>>>  /*
>>>>>>>>>>>   * Verify COPY destination stateid.
>>>>>>>>>>>   *
>>>>>>>>>>> @@ -1572,11 +1565,6 @@ nfsd4_cleanup_inter_ssc(struct vfsmount =
*ss_mnt, struct file *filp,
>>>>>>>>>>>  {
>>>>>>>>>>>  }
>>>>>>>>>>>=20
>>>>>>>>>>> -static void
>>>>>>>>>>> -nfsd4_interssc_disconnect(struct vfsmount *ss_mnt)
>>>>>>>>>>> -{
>>>>>>>>>>> -}
>>>>>>>>>>> -
>>>>>>>>>>>  static struct file *nfs42_ssc_open(struct vfsmount *ss_mnt,
>>>>>>>>>>>  				   struct nfs_fh *src_fh,
>>>>>>>>>>>  				   nfs4_stateid *stateid)
>>>>>>>>>>> @@ -1762,7 +1750,8 @@ static int nfsd4_do_async_copy(void *data=
)
>>>>>>>>>>>  		struct file *filp;
>>>>>>>>>>>=20
>>>>>>>>>>>  		filp =3D nfs42_ssc_open(copy->ss_mnt, &copy->c_fh,
>>>>>>>>>>> -				      &copy->stateid);
>>>>>>>>>>> +					&copy->stateid);
>>>>>>>>>>> +
>>>>>>>>>>>  		if (IS_ERR(filp)) {
>>>>>>>>>>>  			switch (PTR_ERR(filp)) {
>>>>>>>>>>>  			case -EBADF:
>>>>>>>>>>> @@ -1771,7 +1760,7 @@ static int nfsd4_do_async_copy(void *data=
)
>>>>>>>>>>>  			default:
>>>>>>>>>>>  				nfserr =3D nfserr_offload_denied;
>>>>>>>>>>>  			}
>>>>>>>>>>> -			nfsd4_interssc_disconnect(copy->ss_mnt);
>>>>>>>>>>> +			/* ss_mnt will be unmounted by the laundromat */
>>>>>>>>>>>  			goto do_callback;
>>>>>>>>>>>  		}
>>>>>>>>>>>  		nfserr =3D nfsd4_do_copy(copy, filp, copy->nf_dst->nf_file,
>>>>>>>>>>> @@ -1852,8 +1841,10 @@ nfsd4_copy(struct svc_rqst *rqstp, struc=
t nfsd4_compound_state *cstate,
>>>>>>>>>>>  	if (async_copy)
>>>>>>>>>>>  		cleanup_async_copy(async_copy);
>>>>>>>>>>>  	status =3D nfserrno(-ENOMEM);
>>>>>>>>>>> -	if (nfsd4_ssc_is_inter(copy))
>>>>>>>>>>> -		nfsd4_interssc_disconnect(copy->ss_mnt);
>>>>>>>>>>> +	/*
>>>>>>>>>>> +	 * source's vfsmount of inter-copy will be unmounted
>>>>>>>>>>> +	 * by the laundromat
>>>>>>>>>>> +	 */
>>>>>>>>>>>  	goto out;
>>>>>>>>>>>  }
>>>>>>>>>>>=20
>>>>>>>>>> This looks reasonable at first glance, but I have some concerns =
with the
>>>>>>>>>> refcounting around ss_mnt elsewhere in this code. nfsd4_ssc_setu=
p_dul
>>>>>>>>>> looks for an existing connection and bumps the ni->nsui_refcnt i=
f it
>>>>>>>>>> finds one.
>>>>>>>>>>=20
>>>>>>>>>> But then later, nfsd4_cleanup_inter_ssc has a couple of cases wh=
ere it
>>>>>>>>>> just does a bare mntput:
>>>>>>>>>>=20
>>>>>>>>>>         if (!nn) {
>>>>>>>>>>                 mntput(ss_mnt);
>>>>>>>>>>                 return;
>>>>>>>>>>         }
>>>>>>>>>> ...
>>>>>>>>>>         if (!found) {
>>>>>>>>>>                 mntput(ss_mnt);
>>>>>>>>>>                 return;
>>>>>>>>>>         }
>>>>>>>>>>=20
>>>>>>>>>> The first one looks bogus. Can net_generic return NULL? If so ho=
w, and
>>>>>>>>>> why is it not a problem elsewhere in the kernel?
>>>>>>>>> it looks like net_generic can not fail, no where else check for N=
ULL
>>>>>>>>> so I will remove this check.
>>>>>>>>>=20
>>>>>>>>>> For the second case, if the ni is no longer on the list, where d=
id the
>>>>>>>>>> extra ss_mnt reference come from? Maybe that should be a WARN_ON=
 or
>>>>>>>>>> BUG_ON?
>>>>>>>>> if ni is not found on the list then it's a bug somewhere so I wil=
l add
>>>>>>>>> a BUG_ON on this.
>>>>>>>>>=20
>>>>>>>> Probably better to just WARN_ON and let any references leak in tha=
t
>>>>>>>> case. A BUG_ON implies a panic in some environments, and it's best=
 to
>>>>>>>> avoid that unless there really is no choice.
>>>>>>> WARN_ON also causes machines to boot that have panic_on_warn enable=
d.
>>>>>>> Why not just handle the error and keep going?  Why panic at all?
>>>>>>>=20
>>>>>> Who the hell sets panic_on_warn (outside of testing environments)?
>>>>> All cloud providers and anyone else that wants to "kill the system th=
at
>>>>> had a problem and have it reboot fast" in order to keep things workin=
g
>>>>> overall.
>>>>>=20
>>>> If that's the case, then this situation would probably be one where a
>>>> cloud provider would want to crash it and come back. NFS grace periods
>>>> can suck though.
>>>>=20
>>>>>> I'm
>>>>>> suggesting a WARN_ON because not finding an entry at this point
>>>>>> represents a bug that we'd want reported.
>>>>> Your call, but we are generally discouraging adding new WARN_ON() for
>>>>> anything that userspace could ever trigger.  And if userspace can't
>>>>> trigger it, then it's a normal type of error that you need to handle
>>>>> anyway, right?
>>>>>=20
>>>>> Anyway, your call, just letting you know.
>>>>>=20
>>>> Understood.
>>>>=20
>>>>>> The caller should hold a reference to the object that holds a vfsmou=
nt
>>>>>> reference. It relies on that vfsmount to do a copy. If it's gone at =
this
>>>>>> point where we're releasing that reference, then we're looking at a
>>>>>> refcounting bug of some sort.
>>>>> refcounting in the nfsd code, or outside of that?
>>>>>=20
>>>> It'd be in the nfsd code, but might affect the vfsmount refcount. Inte=
r-
>>>> server copy is quite the tenuous house of cards. ;)
>>>>=20
>>>>>> I would expect anyone who sets panic_on_warn to _desire_ a panic in =
this
>>>>>> situation. After all, they asked for it. Presumably they want it to =
do
>>>>>> some coredump analysis or something?
>>>>>>=20
>>>>>> It is debatable whether the stack trace at this point would be helpf=
ul
>>>>>> though, so you might consider a pr_warn or something less log-spammy=
.
>>>>> If you can recover from it, then yeah, pr_warn() is usually best.
>>>>>=20
>>>> It does look like Dai went with pr_warn on his v2 patch.
>>>>=20
>>>> We'd "recover" by leaking a vfsmount reference. The immediate crash
>>>> would be avoided, but it might make for interesting "fun" later when y=
ou
>>>> went to try and unmount the thing.
>>> This is a red flag for me. If the leak prevents the system from
>>> shutting down reliably, then we need to do something more than
>>> a pr_warn(), I would think.
>>>=20
>> Sorry, I should correct myself.
>>=20
>> We wouldn't (necessarily) leak a vfsmount reference. If the entry was no
>> longer on the list, then presumably it has already been cleaned up and
>> the vfsmount reference put.
>=20
> I think the issue here is not vfsmount reference count. The issue is that
> we could not find a nfsd4_ssc_umount_item on the list that matches the
> vfsmount ss_mnt. So the question is what should we do in this case?
>=20
> Prior to this patch, when we hit this scenario we just go ahead and
> unmount the ss_mnt there since it won't be unmounted by the laundromat
> (it's not on the delayed unmount list).
>=20
> With this patch, we don't even unmount the ss_mnt, we just do a pr_warn.
>=20
> I'd prefer to go back to the previous code to do the unmount and also
> do a pr_warn.
>=20
>> It's still a bug though since we _should_ still have a reference to the
>> nfsd4_ssc_umount_item at this point. So this is really just a potential
>> use-after-free.
>=20
> The ss_mnt still might have a reference on the nfsd4_ssc_umount_item
> but we just can't find it on the list. Even though the possibility for
> this to happen is from slim to none, we still have to check for it.
>=20
>> FWIW, the object handling here is somewhat weird as the copy operation
>> holds a reference to the nfsd4_ssc_umount_item but passes around a
>> pointer to the vfsmount
>>=20
>> I have to wonder if it'd be cleaner to have nfsd4_setup_inter_ssc pass
>> back a pointer to the nfsd4_ssc_umount_item, so you could pass that to
>> nfsd4_cleanup_inter_ssc and skip searching for it again at cleanup time.
>=20
> Yes, I think returning a pointer to the nfsd4_ssc_umount_item approach
> would be better.  We won't have to deal with the situation where we can't
> find an item on the list (even though it almost never happen).
>=20
> Can we do this enhancement after fixing this use-after-free problem, in
> a separate patch series?

Is there a reason not fix it correctly now?

I'd rather not merge a fix that leaves the possibility of a leak.

--
Chuck Lever



