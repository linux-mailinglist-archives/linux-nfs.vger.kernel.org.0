Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8320274334A
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Jun 2023 05:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbjF3DmV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 29 Jun 2023 23:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232113AbjF3DmS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 29 Jun 2023 23:42:18 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D7935A5
        for <linux-nfs@vger.kernel.org>; Thu, 29 Jun 2023 20:42:16 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35TNguWc031772;
        Fri, 30 Jun 2023 03:42:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=IU7LGyTju8knhu++8h/nN8cc0WhR3gmr7DmrE7iav7Q=;
 b=lIJ4Y8Q3jVMUVGXMPo4836PYAOzF5bON7+h66kHlLK3WMCyYxUy4H+QVIDTEcmXIbZfq
 KsUFYV3Ip6ci8QAsxXf6wpGCPQ/mCPvzQngJyYhX5j3RdZ6+f335xmdT94veA7dlw75P
 Fpi6SZwjDg+OOP2nACR+CWotYVpwWV49UsapB+lSm/tGH3Z1YBLLE9lsUI8dIO0owZBl
 yZ1hDh2Sa73v/Zg+phMfqmNowcW7r94YJUlfkg1x7Dk33AQOfpjG+GygXhpZcGovcNyQ
 QEstdZHkORhgp9igGw0DkMRuiiKRbEMoycT0l6IO5JzWQe7awv4AMuIqrCpKyI/8KlBR nw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdqdty7jr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Jun 2023 03:42:08 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35U2Cfcb029638;
        Fri, 30 Jun 2023 03:42:07 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpx89pv0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Jun 2023 03:42:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MkE3spOOCHw5kLO1aCcffl2In93SzSbqplZKC0+9DAZHzpkWFm0VQhbVsXrixFdxqfJr+UquaRbesTLauOwkEzl/gd2NJTu1Q73NsiocTSHq7tgbprWfGvZm5NMamvKIyzDjW41fLODl9UIaF0UH9V+EIcUOz5jdSmV7ch/CpVWboEYHN91e0a/AZ1nBj2aMNCC2VGWQDGI9nXUF4nMIin5+CVmkw2QnzfXz6kBSjBUVJVGEvj1SNsesesZQ8Ep/0sXA6oKE3WchqcqsV2W1468qHlOKlLBGPKSK4/Luvb8Rm4wy/+mGdbLi7sSql4gu0q7mYihApQdizUbdzi6yCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IU7LGyTju8knhu++8h/nN8cc0WhR3gmr7DmrE7iav7Q=;
 b=Rz+vUpVYv3VUXelFyJd/FJ6CmNLKiIz/VdxN0YpI0lXScEReWLL3+IGl6tPUYCRK5gO3297t4PLk/a/AAHEDmx5KHzp/NnHEVcRWjbhetkzEI7gXE7kl4UEokvWM9UWD98giKkshF1o8OPqhGno/O8xrxBuhZl/t1aUQAwu2k3F8203mPIP7/0nYeshKPyi8/yM1BgqwJ4MsmrMC/jqOZ+mnPb6Vk11wAH+7sJSp1Lg2OyTycALRaZR3Ziv+r8Hh97SO9dD+I91NnamRQD0URafXmaPicrpCBWStf3rKMreF1VkIHi76r+5Aw2If47RviVnELLOPUk3SlwVEiKwRBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IU7LGyTju8knhu++8h/nN8cc0WhR3gmr7DmrE7iav7Q=;
 b=G1484EGqK9K8TDXpmGgr0ix3QzNJnteNzqHcU9w0GrROodNB4YcBidI+NXYk6er5QFXmAm/dAVJaLhneOdgvw9oXr783xZBaErrWjLDCGnFln7drcw5Q45IeFrm2efVIFuyvs9Y3SZ4P6NoXMl9C2eVZxVSd0bbMMXlkWF+b718=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN0PR10MB5318.namprd10.prod.outlook.com (2603:10b6:408:126::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Fri, 30 Jun
 2023 03:42:04 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ae00:3b69:f703:7be3]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ae00:3b69:f703:7be3%4]) with mapi id 15.20.6544.012; Fri, 30 Jun 2023
 03:42:04 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Chuck Lever <cel@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "lorenzo@kernel.org" <lorenzo@kernel.org>,
        Jeff Layton <jlayton@redhat.com>,
        "david@fromorbit.com" <david@fromorbit.com>
Subject: Re: [PATCH RFC 0/8] RPC service thread scheduler optimizations
Thread-Topic: [PATCH RFC 0/8] RPC service thread scheduler optimizations
Thread-Index: AQHZqrl2uS8uVRR3u02d9WNHz0RH/6+io5qAgAAGMACAAApiAA==
Date:   Fri, 30 Jun 2023 03:42:04 +0000
Message-ID: <5D075D4B-D0BA-4B40-B5CA-3C66A954B6E0@oracle.com>
References: <168806401782.1034990.9686296943273298604.stgit@morisot.1015granger.net>
 <168809295522.9283.8453285193952262503@noble.neil.brown.name>
 <168809428416.9283.10675552657236895730@noble.neil.brown.name>
In-Reply-To: <168809428416.9283.10675552657236895730@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BN0PR10MB5318:EE_
x-ms-office365-filtering-correlation-id: 9f97a6d5-ede1-4157-1ff6-08db791bf8cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j2+UoF2LnFdo4oe7DxlU1iojcCgN4MSQkfW3nj8sMYwJbI2x29Rb4+DNJjLtvvF8Krjcko/RvMvcz31tdmx+/nO9DOdftAs2H9n9X78otIsEmfcJfsBvXvsBIRtn12TO5cn7gB32DUK5J9Y8Hs5lEMKMwo1tbIk/ITrJTex+RNZHx0auuU/MgLbr18/+s4xtP+oVNc4wmGyTJZhvUbZzug6BxK5F/4j9ciwjKaDvJ/ENEVHVwZEsN2xbkaPOIx5Hft1YuOD4iLlH2Z0NkvAwAF8oH3Lgqtz91RX8bgjvi9tzvVZINym4RN8bBneTXIiLxxHkwJc1pflcs9+2U7yRkZcX78mWUn46yH0/AVvehYi+vujuGhW9p/ENqqxDCHCRNw6eEeW8v318AmRoWtszvcVzaGLsUWykK5ucp6K33iokU9DEVndm0gloo4YKPyvzFVaZ70kNjNK7thJ+8/7WZDjs9S+rXmEYq7mQemojMtTgE8eVgcn0Wnr/1mMHkODDuMb3ZRHeoCgnPtnUTd/d/NNyubGn9RS7f0OBFZammC/PgzDt+rbu1k5LsnoUimYr41o+y8yyLaKsRXtdlCM7vRK95khPY5E6JGJbFwtfeH/Qr3X9V5ZrBbJj60ofWoepPsMR/SKt8u0YFPmDtOMj2A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(136003)(366004)(376002)(396003)(451199021)(83380400001)(38070700005)(2616005)(2906002)(122000001)(38100700002)(36756003)(8936002)(8676002)(5660300002)(86362001)(71200400001)(54906003)(6512007)(41300700001)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(6916009)(4326008)(91956017)(316002)(6486002)(33656002)(478600001)(186003)(66899021)(53546011)(6506007)(26005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KMVlepsjNq2hCKvbuIThfX1uhIaSoP09IoBbqcSQoG9USxUCUoWGlV5+wzgz?=
 =?us-ascii?Q?s1n38oS41IKHKQ/SYVh9GdtCs4B5k+maKA+jkgYJb7j8SX3qa0phe1rgRcvw?=
 =?us-ascii?Q?gBxdFTwERdRynBNdfXTlETnMgeX79wpuFNZjhxyCZ/LNrYfYPccSIWt6LGOE?=
 =?us-ascii?Q?wOo3Tz0LI2RaZk9KIR2YpzPIoD+iunrl9uYmKSY3/milUI7ZpVeh7Uo8Dv8W?=
 =?us-ascii?Q?6uCByt9D0v2Y0oa6/XoHdieu5jQxCwZDbyPKywBS3CVGd4c/fPaxgpld9Zel?=
 =?us-ascii?Q?IDx0IP5pzoTS0nvHywoTtIaN0NuYvJoCVxboFTkPqqGgkUFmrcDtqbikzZvw?=
 =?us-ascii?Q?Rp4h5Oebc14RKQhwqC+dS0Zfa3m3xhAs1Cfpp9aAiQ4azcNP7b87CtTEwymp?=
 =?us-ascii?Q?OB8DgpTbSoRQ0Ved4Dep/ltI40byFmymPhXzFavdYE4/l76BCGDpNGlUWFc8?=
 =?us-ascii?Q?gN5jrvxn8FER277iOhpo7R9/rPM0pfWPV6z2QrSdUjNtIBHXb4Ml+sbQDK6Y?=
 =?us-ascii?Q?AqaaBUIeYRefL7+jx/zyoxPM3SxHUu5HyoNtV1pMoAy42nY3Wl2aPI1Ty+g+?=
 =?us-ascii?Q?ks9y0COKKDN8B/M/jF8ukTO3AkqUf/Qc3QdSZCe0ylr/8sBdwvKEZlKAyp3c?=
 =?us-ascii?Q?z8PC62HlY8AJRze7VR7uLNEqWAhYjYXOpW9L4v9+FS/ktKY3445FWgUbedNW?=
 =?us-ascii?Q?xqn2kerIOvcAmKFmOOZy3I21N4bvZ2wShs277GKQzoPGcE729DjPfA+jYM/K?=
 =?us-ascii?Q?ABkmgZ/OIf/6aJwwdbK2YgxExXgIlrMgB5tTjO++MBcoGXEnj2W2TOhCxZJQ?=
 =?us-ascii?Q?DMZ7uKfftKkyw20arTpuYUweAHxH7WQi/F1cMQqnyjtGh8vWHsHA7acYoIUb?=
 =?us-ascii?Q?CFL5Wfg9AYuy/z6CPMTENveFBIxW/W5vVxGAamVT9U/P9Q6PPFKX0SCxAMSX?=
 =?us-ascii?Q?U2zl60g4IyOu3rRyT/kIabT2vRT4CLjixDET9ZW576enIFAbsV7ujWjt22aD?=
 =?us-ascii?Q?IUDNCSrWvp5GtSvmKpLzSgFJLBhrkVQjKtQPomz73Jl8VKRTZGVrEbX9qa4G?=
 =?us-ascii?Q?1WY7HJCysK3+FK1fVOmA4fQzojZgE6JDudoa/klArcLfB89o9oEpq+i0mkCN?=
 =?us-ascii?Q?kGkCmldI3Z2dbTB2T/S+GbsTKUXBRGZ4b0MLBmkQ9W+8g45NNZcy8TVznGN7?=
 =?us-ascii?Q?jJV/iC29ByPOjCXxix72drzT+0I885rBR/kcquZsNYpnS9Zve/u7KoM3xYit?=
 =?us-ascii?Q?pOyIJKXqAymoRHIg3x+ZlzmuIJJVV1VnAQlEzeI3nvMF7f7aLNQvNT1Gfti0?=
 =?us-ascii?Q?KCNUdSjkH4v+EnbYsUfeLjy+YZMEcw0XinOdDG38BC5RVmhhUcME4xYWfhR7?=
 =?us-ascii?Q?3V4dXHx7uqACgk8Z1wUjQcv9Dpd3xpS09H4gipr46R7ljcgECumS0Yx7+Vpi?=
 =?us-ascii?Q?6TNnpp9j2yvpVwjlRDlW0p+axTOw4CKO8P1bxld/YffBpYYstP7uWOnLZVOf?=
 =?us-ascii?Q?Mv4DEUldgNtRwLSv9qeHWvYvjGfCMqraX9g4e7bszS7Pqu0Qi87HVm0cbL3E?=
 =?us-ascii?Q?cIabKxAQtfFNfR0VVs8eBvrUCDIhwCUEUNOfIMbkCJu7sBv+/yNJjX6/oWy2?=
 =?us-ascii?Q?1A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7FFFF7BBD4935E4CB9F7D973D32C0CCF@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ziOjChXzSWXQ9ciMMju9AqohYlndHbPv2C0+B+rTB9FrFYXJRTwJ7Vu8rE+Mtgpiro/WpwrdUnbz880kVmWaEiLj4qe6nT0l8wU3BdZcLh9fvqg5OE9fda3Z7U9i+um4+20DW8OAm4+d5zvrPfH62cp8o6W5f33bzJ5cmDXXjy+BPEBkNlBfnq3TUp4gmrN2I7JkkoJzkk98kdneFn+bTjrfV0mbhCvS6jaZYIK4I3V0yJMAgvTsb9ogkOfBrKqdBebFOagq6LVg9Oq0HxmrOCY9XEKD9cmQPPkZzqeJa0Y+ZpagOEDrambvf/2lYpGd1N8uwFWo1iU7YNV/hW6fAHKRw0emW442sq0GjYI9+TUyBSvi/CwgzZM+kqz0DbLBImL1HRZHLiCR84sTKJL696/8hgSOI4MeFaAlHZf1pYf2VRAuCrjIKe2DMQSRqpExrFq5HkKa7pbgzG79AR7upBuAd0sdfrw13onBmm/KyuCmLZ4XqcHGIoQOuVyxAP/s9fY6sTdzAM9BHIVeAfVUvhaklXOuEzdUuNRFBcNy5p9G2bkohEBIRYhfvsPrwDkBwK5otRtw/N9kCwDGFubXmXcBK8QXt/xoz+gIMjo52g0ywJZ4CsT3IpO4jsortFxAtbmVSvfx7A3BZ0SPjSs1MVk7EMzbf2b9c/UW7SB0zTUzEnnxUo5tmk6+gSen2+jc433ycqmwcwwUa9BqLryQn5b6svyOdJRAAdthy9lSr8Y7Vj02lPWSnk3VYf3nrgC6JWE7dcTxwOZOqVVYTRXYiKdTWQWM905OD48UQAw32/ZY1Iph8nL5vnq5cU+ph1+zwd/s1A4ED83tDLZOaR/fe0a9em1bTGHCCC+3QylPm2ccgbTO70Ywa0q+vo3zlciv
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f97a6d5-ede1-4157-1ff6-08db791bf8cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2023 03:42:04.8156
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z4RUZeeWM1+eGr5T1Dqh4u0W58KdXL5GJrz/JBIH5yDQA55KMGzx2yE2kpMFy02j/87VF4j5Ro+9Iv7+tL7x9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5318
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-30_01,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 adultscore=0 mlxlogscore=978 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306300030
X-Proofpoint-GUID: gKmZ_2XUBX9YWZZoIHr-dfmU6O_nIK58
X-Proofpoint-ORIG-GUID: gKmZ_2XUBX9YWZZoIHr-dfmU6O_nIK58
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jun 29, 2023, at 11:04 PM, NeilBrown <neilb@suse.de> wrote:
>=20
> On Fri, 30 Jun 2023, NeilBrown wrote:
>>=20
>> I agree that an a priori cap on number of threads is not ideal.
>> Have you considered using the xarray to only store busy threads?
>> I think its lookup mechanism mostly relies on a bitmap of present
>> entries, but I'm not completely sure.
>=20
> It might be event better to use xa_set_mark() and xa_clear_mark() to
> manage the busy state.
> These are not atomic so you would need an atomic operation in the rqst.
>=20
> #define XA_MARK_IDLE XA_MARK_1
>=20
> do {
> rqstp =3D xa_find(xa, ..., XA_MARK_IDLE);
> if (test_and_set_bit(RQ_BUSY, &rqstp->rq_flags)) {
>     xa_clear_mark(xa, rqstp->xa_index, XA_MARK_IDLE);
>     break;
> }
> } while {rqstp);
>=20
> xa_find() should be nearly as fast at find_next_bit()

Yes, xa_find() is fast, and takes only the RCU read lock. Unfortunately,
xa_clear_mark and xa_set_mark (and adding and removing items) require
taking the xa_lock().

The current list-based mechanism is lockless, and so is the replacement
I've proposed. Jeff and I regarded the addition of a spin lock in the
select-an-idle-thread-and-wake-it-up function as something we want to
avoid.

Thus the pool's idle bitmap enables the use of atomic bit testing,
setting, and clearing to make it unnecessary to hold a spin lock while
selecting and marking the chosen thread. After selection, only the RCU
read lock is needed to safely map that bit position to an svc_rqst
pointer.

We might be able to use another sp_flags bit to cause thread selection
to sleep, if we also protect the thread selection process with the RCU
read lock. Flip the bit on, wait one RCU grace period, and it should be
safe to copy and replace the idle bitmap. Once bitmap replacement is
complete, clear the bit and wake up any threads waiting to find an idle
worker.

The balancing act is whether we want to add that kind of cleverness to
handle a situation that will be relatively rare. Is it sensible to
allow more than a few thousand RPC service threads in a pool?


--
Chuck Lever


