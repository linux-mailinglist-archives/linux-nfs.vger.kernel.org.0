Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0C8976D8DD
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Aug 2023 22:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232537AbjHBUvO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 2 Aug 2023 16:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232648AbjHBUvL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 2 Aug 2023 16:51:11 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A199273E;
        Wed,  2 Aug 2023 13:51:04 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 372HJTps021298;
        Wed, 2 Aug 2023 20:50:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=wt92KfmkRfIFHKixi2z5+MXBUk+CggxfydbF8ffNZwY=;
 b=ywIxFwkWy1Ib7MPEMe81b+co0pV9sfiFw8emfQPh7pZ67O+1MrLVxkUGa9YoMUONBkZR
 bmBV6iQrvZo8RhqESDd3masJc38y7QhWfIZmBpbZODrNfK40ourRfkGvgXQ8zY4R17p8
 m57aqL8J7axAM8E5HIEBbiN/laSw5XvUostBsAH4L0D8GXbftC8+eAj0edRtMBb2p6gX
 5yq5orJPjfbcBN62hESKu68BmADk83t3RhZrkwUHsCed4vMqVoN7AGTM2uUAxLE+WVW6
 aIg+wusc4+wgSXrv9KFeY4PCnN9HuJhaNA1wxG7HWZec439aYQqnhbrIn0dEddimEQZ7 3w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4s6e872f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Aug 2023 20:50:54 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 372KDDju004033;
        Wed, 2 Aug 2023 20:50:53 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s4s7eg359-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Aug 2023 20:50:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mBAOdRucfFr64683S9XbhkoZrnOHWpM+M6VmSDRxpetobx831h1h6RZ/Mz7SoRcsQZ3Gtg9Fs/He1vg2Veeikvzct3nqZXcsCtbSUw5dspP7nRlwN/SHIQYhcJe7CNdgJluZiKlfT0mfaFoFVa+4hu9tNs4g7PRoyNQWL33/X7NTNvz8R64BGQqp/t0xW0juGjQKhB3kb/xPYT8im0YHALN8yhk91peOw/Zv8R/gnwNKUygGBXfEkkQt3cr5zEaaQFqCnRS6y31P75MtL+srQftWCi1iBrKd6YJnsrS8UYZdjnYskmLpW5UpADqOxnN0yEIKcijieteil+7v1V7fJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wt92KfmkRfIFHKixi2z5+MXBUk+CggxfydbF8ffNZwY=;
 b=DFpPKb0c7u9wUIIp5r9doRPcgM2AwHCv1gJRUUv48YJMIEkf/RIq4K+s33clH2SU3Q+rzQiFbgDgPZWyvT2Ln6oAfzNLHco1t97EfQJohu7TJQLnRvx+rGkeXWVNyBvQj9teWXrl6goObXU85ZiRtEQS8HwoNv9aFW9VZzOuMTMKRSouX3vQ52h61jMLXduEuPmGlXCdPJ9A1psYwE36c5doUfGrNax2Y0taOM1f4JJX7o3UzKKjHDQ9bZm+fZyqFVHD4eYOKCIlZ4tP6Pvo5jVVoVIRHSm5SsbervuppuxR/E+tOI8/ngGNVNtnsiqPVMcORUF0MIlmxUzIYSKOSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wt92KfmkRfIFHKixi2z5+MXBUk+CggxfydbF8ffNZwY=;
 b=A+NTY9q+OSz7c+oA0nOnBH0kQkngJc89p2OLm41VFuNuEsHHGFvux/FS6r/fyXUa5KFTDe4U+LqyJw+EVH8dnHozgMxaOkDauvZ6lVNRKvHHqmcbeGw+WfkKfSjmQn6x548BzdbWpYtnBMOgG53nJDofj44zHM9EDPI7W4IJyUo=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BLAPR10MB4995.namprd10.prod.outlook.com (2603:10b6:208:333::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Wed, 2 Aug
 2023 20:50:51 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6652.020; Wed, 2 Aug 2023
 20:50:51 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Jeff Layton <jlayton@kernel.org>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] nfsd: don't hand out write delegations on O_WRONLY
 opens
Thread-Topic: [PATCH v3] nfsd: don't hand out write delegations on O_WRONLY
 opens
Thread-Index: AQHZxXKcq4aR2J1kN0CfqUBjCvKex6/XenOAgAAAp4A=
Date:   Wed, 2 Aug 2023 20:50:51 +0000
Message-ID: <9D0539E3-AFCF-4308-8C03-3C34B5D3B23F@oracle.com>
References: <20230802-wdeleg-v3-1-d7cd1d696045@kernel.org>
 <169100930100.32308.6829680445843128900@noble.neil.brown.name>
In-Reply-To: <169100930100.32308.6829680445843128900@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BLAPR10MB4995:EE_
x-ms-office365-filtering-correlation-id: 5df4bba3-6659-4c00-afa1-08db939a285c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BUU0mhbkmUGKmOvkIR2zF4WM6M70z6sjnM+Njxl88WIpd+/Ug/j8KAVCL2IXSxnAgmQsmj/M5zJOlyLY5rVjlQ+9/h50Cq6+s/3aAci5suSoWpVn5xnnd1ITvuAM8GuGTJM9K8I24ywMyozX0yud9tc6AY3WzBNK0x84sIVqqI8wdoGDD547UlYyv9r5CEepVTv/rU0cTS1z5/9Aq9AbQ/s6t4GKsXoORCrN/3OuP0aHhEvcrYKooDT2TTnBwm6/OwvrnL/suwGooi+/iRy8nuobnCmWoGwhMrhGE+iEfn+YkOrYs4EttokW2PWJwnwcpFrv7jGiogFg1oG8OpGAtzPb0sllvUrF7K39QbfPWLmTk82gruuqK7I8ay5HaR03IRZM7ZOEIOKCfK9gDHljqeB1mEz1vqnyp+4NTrqRBno2X95yi6YjVO8EkVmmjjzoduzo1RPKPJaC/06QgJleLFVw3zNDs2K9zfmMdFJTa6QunLoV+yjIqw8MLn6rc03n4yPi6G3kM+9rV5J4FWefNUJVZ7ONiPnRh2ZRCUcQJkHY2cdPEtmwasjWn146Lt2s1TfB63OzpTyR9+sQHk/l34yEDp9LZypnKzCqcCIFLiPJqRSCqLbNS351hJ+n+8fUpvQJXz0w/8rZT3kb2AXLaiZTOTkobuRAeYT8ApNbhYE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(346002)(366004)(396003)(136003)(451199021)(2616005)(53546011)(6506007)(83380400001)(26005)(186003)(316002)(76116006)(2906002)(91956017)(66946007)(4326008)(6916009)(64756008)(66446008)(66476007)(66556008)(5660300002)(41300700001)(8676002)(8936002)(6486002)(71200400001)(966005)(6512007)(478600001)(54906003)(38100700002)(122000001)(33656002)(36756003)(86362001)(38070700005)(66899021)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3NUoYC4BCHalE8sPzSvwBZMF8KhGweoz0ACJVTmuoQMMpmS8WpYP1ylwfhcc?=
 =?us-ascii?Q?ITaBwwDsaUuDNu0CgpmTJjUYML2P6RrBNK01VnOZPRZ1tk21H8ytWNmxfWh3?=
 =?us-ascii?Q?j9StVo0rWfSXrqlHZHwccKTCXuVWVl8xtOeZWjb18aZ6r48jLJSK3eQwScEW?=
 =?us-ascii?Q?wuNlTxkwKU3HYvbwjkatWD45xZq/ymxyWfOMwUURGHorOqwC9XWdsn8BbK+z?=
 =?us-ascii?Q?8sdDHaAaP1GixgfqrE6iHOUoWeZAchCB1ADOeyvgBqXzVa58dBhGfxvAPD52?=
 =?us-ascii?Q?72rEE54eUNDrYrKiSStSUBMxH69TtVmDC/0srdrJD6EADbJsa03UeAuo2ry0?=
 =?us-ascii?Q?TWsBnM+tcniHNRnLH79oX8N03pVa42FMh/4UFrUt+9ZcZKI4zcbQv4B35TqD?=
 =?us-ascii?Q?Gy0arRULzXpyyEpDfnBZPUopHyYQXsd/6D/r0kulOV3Rk5ZQqXfvt9gIwi/c?=
 =?us-ascii?Q?gA7kmPOXL0UWXoQZTw0Qo7pVh5Bf/xPfQ8J11XkoEZ1wn9pZejfflG5Wq7FL?=
 =?us-ascii?Q?BTrjXyHbvriiXenL/7KLb+bbLRpsZ63PFmekvc8q0X0lDS0r4M7bsYWVhJ1f?=
 =?us-ascii?Q?gr9jhMtbaf+34ZVT+Ke20K88eS6mGzr+9sNTpRNrNNagZxE1TNay6O2yH0TL?=
 =?us-ascii?Q?1GQ9FaXA14L1AiLYagmt6jsn9jMbrSRjAJ62LDtCllfX7teG2sT3AVy0LRAK?=
 =?us-ascii?Q?J2pTryL82cHyXDsfVhCegfCwsefZQlocJW+X+u8/YC8e5xnRadrtGetY8uh+?=
 =?us-ascii?Q?mIdsiip+71bRpSaGGqloHSKkGvCEzOAzV+5pwXXrsrpFLZ+pNrJlc7c1ds5o?=
 =?us-ascii?Q?/B9HBNaxPQEl7GY1SASe6/c88tPuYoWLC4GpVS+Ygjhyox9p86V3Y3WVORv2?=
 =?us-ascii?Q?Z4+cZhcXSmEy0IfhJoexKP2koRy7iB67CGOxLVwIGtTNVnrNZhQrfpejPUff?=
 =?us-ascii?Q?871hTJll2x17cVySNT9Ekxt2MnU6ESKoqvleLtjRsBvwmQenFQnMB6fTp5Q3?=
 =?us-ascii?Q?8/bQ/80+YSWRGJRwR8g334jNto3ZcZi0bxVJxN5NPjkgSwMjFGdLYGjZiJ2p?=
 =?us-ascii?Q?/NjhAhtMGW8g8GF3aYHN6gzTZh3cVhPNaTB/bidDTsE8M7kgX0MjBnuAJumI?=
 =?us-ascii?Q?pMkGFOIJTxZuHoGe42+Fl63bkKdM9Qqh21ZJgDNxjM6aUa/OxpdX/dE5lEGX?=
 =?us-ascii?Q?C3JybgFNjJ1tLd8u8AP/9dPcdcWxJm2Ck752SY/es7ys8DKgcP/5ofJZ/sTz?=
 =?us-ascii?Q?C9lyP+16asvTHqT5zNlyPDkX3hKSQay1XeEJCsFENkgNYNHY5nF68X/0Cr+4?=
 =?us-ascii?Q?VToy9LHyxH7FQnIeZFGKpdVbuo+k/VDYBE0Fn+NKvn4qU82o3yH6q1KOn6EX?=
 =?us-ascii?Q?pTzMGw7KlkMnZ0hdxi9Q3TPtI7XEq5SsOcxWEdZ8WOwxy+Xz3rkveGEYiC8p?=
 =?us-ascii?Q?FW2cpIZ2qmgHSSmBJd16BTQDalBgrVrpgSFde3V87EclHEBTBO4vlZdWC3Fu?=
 =?us-ascii?Q?9jNVMYQAUrdWcNXkPGAQlU0dgBbuKFPSasyok7jDM+jcdxGhJCoYHDp9vo9D?=
 =?us-ascii?Q?W8GXCxzFmX3Q3Cg59cev/81yG13Ii5GtIjmAJooXcxHwnMI/3631GiZDSsxy?=
 =?us-ascii?Q?3A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <783D0D40CDC1B14D8760898F80B13E94@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: p2cKVkfX6/W4evjEhyRLxsxpSKtKj//xYazFXP9oQfKG2CQH5vnY2SFfZEcQMhoZ05+lh0OYu7CI1Ru1kSWIoguTDt38mTaBscuORSdlit5gXtBUuFnVVfxwKSawYfPEo+ofzPdCVTcSAh0l7uuL+QJidjT/cy2meHWCGvjAcP3m94cmjkNQZQlpdCG9oUuj0DzAZJe1Kowlt3tLBCOcgenI8JCpMeARl5+oNaOsKkSM5AXrtvZlvsDDRxl0SBR0dJXXUO81NEDq05HWWslEISKNi8rzyrHtv2BjtnvNnZgnj7YMl6OFcpWPojgJnZ9DzTk7+iK6J50TbnEw69/BvROY8oUXf4sCUNde3gNH4Z7WeuLmquY7+74yi8KL+nrYwN8LVbrYGvA3tAYIjv5humoiHtXi7Zz3KNzlqOvxSlKCAOAlycssxaTkB+Ya10uOuORZpp24jYW4GzpcsrmwY0KTRXdqm+VmNv9AVg93ZZuT4JNI0XpFpRJVIA2vTU/72acFCUNEEplJGRPn3S8OO2DwJYuv8/qt3Ndbsp0VEMb2OfAyHSPzZxbGZP+A8zRpGXAligPbZVkalt5TAFE1w0E3oCEzYJ3mD3JvRXNZBPRUrA8fTgzDgc8LMQ5Ain7kFgA+APKZry4sO4hrDdchzv3YWC0Bh4eBuHNs/oKCc6TSY4Nv9tpr0kMgqFz/+oowQNUMP8p/FyOTf86KFsKBcRXhHI67KpNMlXCl3+tWU9WK/NiREylHJhVpqdQ6LwuibtFEvNtBxa0/2T1Sin3m/1LUow1dMkqAucty836sk46EOh1B1n2Xxq11t6DFM+Cgk8mF0FR0L7Ci8sUFEQlQ6uI1cvokvvE4rthI+B39seRkPx/ZL+qoMqqsO+c3i9ld
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5df4bba3-6659-4c00-afa1-08db939a285c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2023 20:50:51.4060
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s2Xg/9X4bxpFRZT3HcX3qbzr/qvYYh4+BDD+DCekZpMQ3fJyueqAOPEocEbUHgsXcOIhRbS5Tqb1v2+/2xtIiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4995
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-02_18,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 mlxlogscore=953 spamscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308020183
X-Proofpoint-GUID: 1wqFV220dZmZQuoWVY2eLkmhqfLjgeRQ
X-Proofpoint-ORIG-GUID: 1wqFV220dZmZQuoWVY2eLkmhqfLjgeRQ
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Aug 2, 2023, at 4:48 PM, NeilBrown <neilb@suse.de> wrote:
>=20
> On Thu, 03 Aug 2023, Jeff Layton wrote:
>> I noticed that xfstests generic/001 was failing against linux-next nfsd.
>>=20
>> The client would request a OPEN4_SHARE_ACCESS_WRITE open, and the server
>> would hand out a write delegation. The client would then try to use that
>> write delegation as the source stateid in a COPY or CLONE operation, and
>> the server would respond with NFS4ERR_STALE.
>>=20
>> The problem is that the struct file associated with the delegation does
>> not necessarily have read permissions. It's handing out a write
>> delegation on what is effectively an O_WRONLY open. RFC 8881 states:
>>=20
>> "An OPEN_DELEGATE_WRITE delegation allows the client to handle, on its
>>  own, all opens."
>>=20
>> Given that the client didn't request any read permissions, and that nfsd
>> didn't check for any, it seems wrong to give out a write delegation.
>>=20
>> Only hand out a write delegation if we have a O_RDWR descriptor
>> available. If it fails to find an appropriate write descriptor, go
>> ahead and try for a read delegation if NFS4_SHARE_ACCESS_READ was
>> requested.
>>=20
>> This fixes xfstest generic/001.
>>=20
>> Closes: https://bugzilla.linux-nfs.org/show_bug.cgi?id=3D412
>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>> ---
>> Changes in v3:
>> - add find_rw_file helper to ensure spinlock is taken appropriately
>> - refine comments over conditionals
>> - Link to v2: https://lore.kernel.org/r/20230801-wdeleg-v2-1-20c14252bab=
4@kernel.org
>>=20
>> Changes in v2:
>> - Rework the logic when finding struct file for the delegation. The
>>  earlier patch might still have attached a O_WRONLY file to the deleg
>>  in some cases, and could still have handed out a write delegation on
>>  an O_WRONLY OPEN request in some cases.
>> ---
>> fs/nfsd/nfs4state.c | 48 +++++++++++++++++++++++++++++++++++++----------=
-
>> 1 file changed, 37 insertions(+), 11 deletions(-)
>>=20
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index ef7118ebee00..c551784d108a 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -649,6 +649,18 @@ find_readable_file(struct nfs4_file *f)
>> return ret;
>> }
>>=20
>> +static struct nfsd_file *
>> +find_rw_file(struct nfs4_file *f)
>> +{
>> + struct nfsd_file *ret;
>> +
>> + spin_lock(&f->fi_lock);
>> + ret =3D nfsd_file_get(f->fi_fds[O_RDWR]);
>> + spin_unlock(&f->fi_lock);
>> +
>> + return ret;
>> +}
>> +
>> struct nfsd_file *
>> find_any_file(struct nfs4_file *f)
>> {
>> @@ -5449,7 +5461,7 @@ nfs4_set_delegation(struct nfsd4_open *open, struc=
t nfs4_ol_stateid *stp,
>> struct nfs4_file *fp =3D stp->st_stid.sc_file;
>> struct nfs4_clnt_odstate *odstate =3D stp->st_clnt_odstate;
>> struct nfs4_delegation *dp;
>> - struct nfsd_file *nf;
>> + struct nfsd_file *nf =3D NULL;
>> struct file_lock *fl;
>> u32 dl_type;
>>=20
>> @@ -5461,21 +5473,35 @@ nfs4_set_delegation(struct nfsd4_open *open, str=
uct nfs4_ol_stateid *stp,
>> if (fp->fi_had_conflict)
>> return ERR_PTR(-EAGAIN);
>>=20
>> - if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE) {
>> - nf =3D find_writeable_file(fp);
>> + /*
>> +  * Try for a write delegation first. RFC8881 section 10.4 says:
>> +  *
>> +  *  "An OPEN_DELEGATE_WRITE delegation allows the client to handle,
>> +  *   on its own, all opens."
>> +  *
>> +  * Furthermore the client can use a write delegationf or most read
>> +  * operations as well, so we require a O_RDWR file here.
>> +  *
>> +  * Only a write delegation in the case of a BOTH open, and ensure
>> +  * we get the O_RDWR descriptor.
>> +  */
>=20
> This comment isn't working for me, and it isn't just the need for
>    s/f / f/
> Neither the "Furthermore" or the "Only a" seem to make sense.

I changed this to "Offer a write delegation in the case ..."
when I applied it.


> I think the key take away from the RFC quote is "all opens" and that
> implies "opens for read".  i.e. all delegations imply read access.
> So I would then start the code with
>=20
>    if (!(open->op_share_access & NFS4_SHARE_ACCESS_READ))=20
>         return ERR_PTR(-EACCES);
>=20
> then choose between readable and rw.
> So the comment would say:
>=20
>  * RFC8881 section 10.4 says:
>  *
>  *  "An OPEN_DELEGATE_READ delegation allows a client to handle,=20
>  *   on its own, requests to open a file for reading ...."
>  * and
>  *  "An OPEN_DELEGATE_WRITE delegation allows the client to handle,
>  *   on its own, all opens."
>  * and as "all" includes "for reading", any delegation must
>  * allow reading.  So if the original access is write-only we
>  * do not return a delegation, otherwise we require at least
>  * "readable", to return a DELGATE_READ and "rw" to return
>  * DELEGATE_WRITE which we only try if the original open
>  * requested write access.
>=20
> Code looks good, though I find the growth of find_foo_file APIs
> aesthetically unpleasant.=20
> NeilBrown
>=20
>=20
>> + if ((open->op_share_access & NFS4_SHARE_ACCESS_BOTH) =3D=3D NFS4_SHARE=
_ACCESS_BOTH) {
>> + nf =3D find_rw_file(fp);
>> dl_type =3D NFS4_OPEN_DELEGATE_WRITE;
>> - } else {
>> + }
>> +
>> + /*
>> +  * If the file is being opened O_RDONLY or we couldn't get a O_RDWR
>> +  * file for some reason, then try for a read deleg instead.
>> +  */
>> + if (!nf && (open->op_share_access & NFS4_SHARE_ACCESS_READ)) {
>> nf =3D find_readable_file(fp);
>> dl_type =3D NFS4_OPEN_DELEGATE_READ;
>> }
>> - if (!nf) {
>> - /*
>> -  * We probably could attempt another open and get a read
>> -  * delegation, but for now, don't bother until the
>> -  * client actually sends us one.
>> -  */
>> +
>> + if (!nf)
>> return ERR_PTR(-EAGAIN);
>> - }
>> +
>> spin_lock(&state_lock);
>> spin_lock(&fp->fi_lock);
>> if (nfs4_delegation_exists(clp, fp))
>>=20
>> ---
>> base-commit: a734662572708cf062e974f659ae50c24fc1ad17
>> change-id: 20230731-wdeleg-bbdb6b25a3c6
>>=20
>> Best regards,
>> --=20
>> Jeff Layton <jlayton@kernel.org>


--
Chuck Lever


