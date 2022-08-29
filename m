Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51D845A53D4
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Aug 2022 20:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbiH2SPq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 29 Aug 2022 14:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiH2SPq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 29 Aug 2022 14:15:46 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF24895DF;
        Mon, 29 Aug 2022 11:15:44 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27TGid6f019477;
        Mon, 29 Aug 2022 18:15:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=vp7sWFGmYIshGIBKsKnrl64wXW0O2h581mbh5Hq9udM=;
 b=JC6i6miLMCwkp0Un36G83sJS4WtGaI9EWlam+xf9H5Ib6MLdz8Z4vfyr91gp2OpoN1YJ
 bJIxg1Jj6A9nA2rfOvvjTQSBMCfSo/3lC4yyYb2Xtr2bjHV4jLTVN+75Z9PDkni63I35
 LZuqGsQxMMtKALFQ29PmRGbiO63htNkRyB+6oCRvVBz39w8K4kDcL07YpApDmzMtW34M
 MTCfb/eykjKK7gpiqFfFs/aauTc3aNGZCYqnuGwQlvP0o4BnPiAVUGFVHl8XQ0JKHAWK
 IaKmOw98Hs+WtbcvvoXcBN43yLknXhv7SBmBaZNSYF22CF3NX2AEppsrWfXcYy5+xEtc og== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j7b59v3yh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Aug 2022 18:15:33 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27TGf39A003191;
        Mon, 29 Aug 2022 18:15:32 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2046.outbound.protection.outlook.com [104.47.73.46])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j79q317y5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Aug 2022 18:15:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sh6EIKE/nVIOrRn6n0YYv2BzqjzIEPCSl6lySWIDFNQM/b8wlKqIFZ8vZSBkU9J7hO72kQ8fUWWUVUw8NcUk4NBlXHw5V0bz3NKyL7f4gy10rsZV19VIUK0o0FN5tFopvhTdz2/eje97+hzjw3z1hVKqIrvnSw82dsvGrN5wQwjCpGWM5NIJh5ZOAVB3lyFMcCZafO+jQYVYuqRDVVFwEaRMppOP0ycdw1PL9d2kP71fpYcxBucgSZr/xuGwKxzsrwRHds9MhKN/ZtC2FTyvgECANnXxP5LS1gf3HmelVCYF06xj6nsmqmAkbT1RdQR4C+dXPYTK7HSxTK5J8oWWOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vp7sWFGmYIshGIBKsKnrl64wXW0O2h581mbh5Hq9udM=;
 b=Xd4YB43yQldsHtk18LdbgKIkXMJafmfG9E4RFyt1KmlHhTynd9t7wXaDwBQ67G6CWCB8jtGatlCt74oIrPmN40XxcPtFy74/1LImxxnpB/ONSyWSa176solDnH5dJt0PghqTQtFa8ihPMHUUIsxiF3Yga8oyzT5D0bQaSl6nQY0frrwit5pzNMC4YzelaD20RJy8pqUw9fv2IZeU2DX6VH/0Z1NGTeG3dNXXv7Xdtvn91PbsqcGSmOQCvRuJKzuSsO3E0z5N3o+FWHT/oXzsUwVX06eOQoS6Vo5f4apALtwhXX2aAITDEuwt7zWukBH9zQc4Q0XdG+5eUixS+gpypQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vp7sWFGmYIshGIBKsKnrl64wXW0O2h581mbh5Hq9udM=;
 b=uSrWuW8Xu9vo2gETshELLTJoEV2+tF7+DwWa6vpnGgA0xcpwcrG+B6R+NrG05PxivYHllIcleFrO9eQLg1veNW3zrFwnCyZD06wQ3hR/0aI156suf1YVY728IClQv52QxHZDzvgW0WjJ3Q9M6XIKw+5V5t2LlHqkKMzRc5GX6xs=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MWHPR10MB1694.namprd10.prod.outlook.com (2603:10b6:301:9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Mon, 29 Aug
 2022 18:15:28 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa%4]) with mapi id 15.20.5566.021; Mon, 29 Aug 2022
 18:15:28 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Leon Romanovsky <leon@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v1] RDMA/core: Fix check_flush_dependency splat on addr_wq
Thread-Topic: [PATCH v1] RDMA/core: Fix check_flush_dependency splat on
 addr_wq
Thread-Index: AQHYtjxDHzOcFbDad0CgCtqOY9xpUa28It+AgABhkYCAAUS4AIAAULmAgAMZTACAAAltAIAAAa6AgABhRICABIF0gIAACD6AgAACMgCAAA64gA==
Date:   Mon, 29 Aug 2022 18:15:28 +0000
Message-ID: <904E5390-9D6B-4772-AAE6-DBF33F31698C@oracle.com>
References: <YwSLOxyEtV4l2Frc@unreal>
 <584E7212-BC09-48E1-A27E-725E54FA075E@oracle.com> <YwXtePKW+sn/89M6@unreal>
 <591D1B3D-B04A-4625-8DD0-CA0C2E986345@oracle.com>
 <YwjKpoVbd1WygWwF@nvidia.com>
 <08F23441-1532-4F40-9C2A-5DBD61B11483@oracle.com>
 <YwjT9yz8reC1HDR/@nvidia.com>
 <FF62F78D-95EE-4BA1-9FC6-4C6B1F355520@oracle.com>
 <YwztJVdYq6f5M9yZ@nvidia.com>
 <90CD6895-348C-4B75-BAC5-2F7A0414494B@oracle.com>
 <Ywz15s75El7iwRYf@nvidia.com>
In-Reply-To: <Ywz15s75El7iwRYf@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6cf464de-a4cc-404d-7f56-08da89ea73cf
x-ms-traffictypediagnostic: MWHPR10MB1694:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Lz+17140KsndDP2GDXQdYA2mHXpLZrTIiljgds4ow25k4s9COOlXViFv3EI+N/9/ikHADKL8sK5l/in1ICE5efo77OywLcWqoEhYfXCqVCPVUWkP3y9az8vOKRPHiij8U8hpaw5vZL4WExbML/yZZnzZYsbQPClZzhWiLaamR/KMIr0YXkRByRP+gnr0xKWvN8XDrIoqLYWt9T6NoXXqbwikQKJtXU9vO4dli1tKRKJQEeiAF8JvrgRRhOyjjnPu44+KnMrriIm83NPVqRN6NGrhDkGeFier5wTcf2IfP1pVKduYaaZ04DoKLFKrXerIByRW/iPO2uRzpa48WBFSZpEFNd1z5TFfMMUMEMc4ASJ29NIBmCECD2SAUcnidif/CsIS+xDosLvstovIgm+XazAFmtZ/U2x3QNaovNNy9fXW+rVTHrtefqEc5SzSrHEX3iOE6OkVhrsFsSUpp1fiLAIdmftnPLdC/cpxul59uMC9i6eMuqTpcM3c4EVcWPKtAcM/F7PMJtXVAHFfeTG6RKgWtfmK5DHMmXR3u2IWVwLYfBVGA9FlWJcc7r8xTC7UWQcSryeYYFjSyLy4/suxywqIjKZF2S1kbVu2DqA+1CU0/uqXlQ/UjDv+yZUuG/7Mo4C8EVeiLTlo/PWD67iTr1LNuWJ69vHkatgmGiY7iO4EU+Ezhlyyf5FZAT87+qTxqXXAbrzf7YXU3NEdXDLj2vi5NMYCb0AxrP600UZIlPDayQFYNF4Iq3YFK2J+XqymiuwECX3rSEUg6HhFHueI8v6UGRQRi7wfg8C8iKVLEuE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(376002)(366004)(346002)(136003)(39860400002)(53546011)(38070700005)(6512007)(26005)(86362001)(41300700001)(71200400001)(6486002)(122000001)(478600001)(6506007)(186003)(2616005)(38100700002)(76116006)(91956017)(5660300002)(2906002)(83380400001)(8936002)(316002)(54906003)(8676002)(6916009)(33656002)(4326008)(64756008)(66556008)(66446008)(66476007)(66946007)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ly/sJ8WCYdaaBKOLQqY8vXoODqkd8jeM2isB8QuzSV3P/Q+TEBWuq2q4WJwR?=
 =?us-ascii?Q?ebI5m7bGMaR/8+kLP9fvrLzgP2LisAAIZVYSs0RWrBB3E/Dh/2fVmHR95vrR?=
 =?us-ascii?Q?AR2WPuGFlKhTKSKW+FrxAeU+Lf5BswBLci9Pzislofus0nRIv0PuUK85O+eG?=
 =?us-ascii?Q?AfrEmenWUjxTip3N/G4xw2HpzL9sDneT2zg2odjLh1kS+gstnBY8xI064/Bv?=
 =?us-ascii?Q?6un1E5GXrRuXz+1bO6WpuqTeNtr97xnpQqBGzNY3BsBBXwKYm3qls5kXcScT?=
 =?us-ascii?Q?lpNpqRLejPaeqsAZUf3bQOmRi5liIgeq3m39KM4U9M7TOtIo/CKoFuRw2D6O?=
 =?us-ascii?Q?ZSd9e4Uu++xq92L7w7VDtUCQtAixvEgujTb76pwLk/z9atE2ak3JSd4K/rS2?=
 =?us-ascii?Q?R52q0owiV52x9aITQYyZBIcqEakAfamIJjVkXwZuxdeB6Nrhvngv5EjZoP8V?=
 =?us-ascii?Q?L4xF1ymn2tnS6/gUiIVtclPhROFilPsnzL+bNEgpK9Y7pYe7DFXc2tQ78Ips?=
 =?us-ascii?Q?85ZM/ylAGwUh4cjB48OQdiFnLIsRzr/5fN6kD+xK2PKx6n+6IsIFLvXcCNeg?=
 =?us-ascii?Q?xYQ79DiFWha097dcJwqNhXUupObtmfsQQbeIWo/OwDLNUE4eYlzYarrUU997?=
 =?us-ascii?Q?SkrIqRzhRibtzP8pFFMJnZSOTU5r7KVrjydYPHiVykqYrte7j2foNnJaIPw5?=
 =?us-ascii?Q?LeVZtioPL/GR9/rHD/+OSUTRgYK1qFQc53gD0yA3XWzSPneOmbIqwzun+XcH?=
 =?us-ascii?Q?qzn2ZWBb1Fxal+oXqbhDCDqFis4h36ShO+ThrfuWdyqI4JjZb+MRDtEFcWXA?=
 =?us-ascii?Q?PkBdeMAbEZ5WOPhmneizPj6YLd2qQK/xc5uyJzGlaj1uJ8/J7UftxMrfOll5?=
 =?us-ascii?Q?IwflNdWAo38L4i8odkm838QbJtZv9PPV8NdZXhQao3C+c/ZpmPdNibzUUlKN?=
 =?us-ascii?Q?c95ZBJA7F5npWCkJ4f+mdUw/VdbTr3xC1xJVSUlKp/1S3nJ1sNmXBIhTrqK7?=
 =?us-ascii?Q?5rDgxHLLSEW0UUQX2lb7T0YESMUcCOcVFJmSObxLPZr4JsQGOkKsGgGMvlBW?=
 =?us-ascii?Q?jAAMguKi8Q20RujjiBzZ1OFXOs3ORj8Mvk2hN7Y0iAuQCWGuYOdDgjZXQd8t?=
 =?us-ascii?Q?epXgUlbLqUO2JWKwqC4vLNHfFNkNLg+BDqdIP/RdB0LUsXzoBmr9aOjDf1k4?=
 =?us-ascii?Q?VjkUd9gB13Hcd11a99q3YZx2gO8e2YZVAso7GItWjhfeBs7/2vZgxuTLe4+G?=
 =?us-ascii?Q?UU6176ke2BZYgbwTyYjYuRvwQgBO1pMg4Nv/WCh3gVAdfPBIcH7dDNrmPbrI?=
 =?us-ascii?Q?HnzLP201nRJgHYgmME/TqYKzDdYWaFmRMbM3e31bDT36PATURLgN0uEZYoDv?=
 =?us-ascii?Q?BS/NGG3cqcuiYHgiHIRHGMuZ2h1uo/uaEdV4r9ibiykt2YylrevV7foitBAg?=
 =?us-ascii?Q?q0F7yuYbacSJSIewWUJ4A4PIir1VO4s9ksqh9vpUJgKiy5M1MIIQJ56Czqgr?=
 =?us-ascii?Q?3vqdSsCgnk5EeJTKxf1bPWThkhhOgxxZyZlKJnjeBkdHnwAm3AwZyhj4Ivf6?=
 =?us-ascii?Q?ldrz1/fKNjX4tIUBV+PmEQF6BP4RO6U0AGZybljh/QbOfvVHiWNc/ygw1U1i?=
 =?us-ascii?Q?rg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <81B315D599BC064B90AD0BB8FC68AC8E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cf464de-a4cc-404d-7f56-08da89ea73cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2022 18:15:28.1396
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hsnGlUmYx4GE8/JAVF4BHE7cpMgbgCuXxzEgMWFsLl+pYCqfns4NN8jWGtf4W6tcn1XcfjUAhX/DW8OfxZ8sDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1694
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-29_09,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 bulkscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208290084
X-Proofpoint-ORIG-GUID: 1owcVnC0yohRczvo8KZk7jmbO9LHAxen
X-Proofpoint-GUID: 1owcVnC0yohRczvo8KZk7jmbO9LHAxen
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Aug 29, 2022, at 1:22 PM, Jason Gunthorpe <jgg@nvidia.com> wrote:
>=20
> On Mon, Aug 29, 2022 at 05:14:56PM +0000, Chuck Lever III wrote:
>>=20
>>=20
>>> On Aug 29, 2022, at 12:45 PM, Jason Gunthorpe <jgg@nvidia.com> wrote:
>>>=20
>>> On Fri, Aug 26, 2022 at 07:57:04PM +0000, Chuck Lever III wrote:
>>>> The connect APIs would be a place to start. In the meantime, though...
>>>>=20
>>>> Two or three years ago I spent some effort to ensure that closing
>>>> an RDMA connection leaves a client-side RPC/RDMA transport with no
>>>> RDMA resources associated with it. It releases the CQs, QP, and all
>>>> the MRs. That makes initial connect and reconnect both behave exactly
>>>> the same, and guarantees that a reconnect does not get stuck with
>>>> an old CQ that is no longer working or a QP that is in TIMEWAIT.
>>>>=20
>>>> However that does mean that substantial resource allocation is
>>>> done on every reconnect.
>>>=20
>>> And if the resource allocations fail then what happens? The storage
>>> ULP retries forever and is effectively deadlocked?
>>=20
>> The reconnection attempt fails, and any resources allocated during
>> that attempt are released. The ULP waits a bit then tries again
>> until it works or is interrupted.
>>=20
>> A deadlock might occur if one of those allocations triggers
>> additional reclaim activity.
>=20
> No, you are deadlocked now.

GFP_KERNEL can and will give up eventually, in which case
the connection attempt fails and any previously allocated
memory is released. Something else can then make progress.

Single page allocation nearly always succeeds. It's the
larger-order allocations that can block for long periods,
and that's not necessarily because memory is low -- it can
happen when one NUMA node's memory is heavily fragmented.


> If a direct reclaim calls back into NFS we are already at the point
> where normal allocations fail, and we are accessing the emergency
> reserve.
>=20
> When reclaim does this it marks the entire task with
> memalloc_noio_save() which forces GFP_NOIO on every allocation that
> task makes, meaning every allocation comes from the emergency reserve
> already.
>=20
> This is why it (barely) works *at all* with RDMA.
>=20
> If during the writeback the reserve is exhaused and memory allocation
> fails, then the IO stack is in trouble - either it fails the writeback
> (then what?) or it deadlocks the kernel because it *cannot* make
> forward progress without those memory allocations.
>=20
> The fact we have cases where the storage thread under the
> memalloc_noio_save() becomes contingent on the forward progress of
> other contexts that don't have memalloc_noio_save() is a fairly
> serious problem I can't see a solution to.

This issue seems to be addressed in the socket stack, so I
don't believe there's _no_ solution for RDMA. Usually the
trick is to communicate the memalloc_noio settings somehow
to other allocating threads.

We could use cgroups, for example, to collect these threads
and resources under one GFP umbrella.  /eyeroll /ducks

If nothing else we can talk with the MM folks about planning
improvements. We've just gone through this with NFS on the
socket stack.


> Even a simple case like mlx5 may cause the NIC to trigger a host
> memory allocation, which is done in another thread and done as a
> normal GFP_KERNEL. This memory allocation must progress before a
> CQ/QP/MR/etc can be created. So now we are deadlocked again.

That sounds to me like a bug in mlx5. The driver is supposed
to respect the caller's GFP settings. Again, if the request
is small, it's likely to succeed anyway, but larger requests
are not reliable and need to fail quickly so the system can
move onto other fishing spots.

I would like to at least get rid of the check_flush_dependency
splat, which will fire a lot more often than we will get stuck
in a reclaim allocation corner. I'm testing a patch that
converts rpcrdma not to use MEM_RECLAIM work queues and notes
how extensive the problem actually is.


--
Chuck Lever



