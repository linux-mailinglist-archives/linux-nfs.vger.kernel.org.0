Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE4B65ABC05
	for <lists+linux-nfs@lfdr.de>; Sat,  3 Sep 2022 03:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbiICB0V (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 2 Sep 2022 21:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiICB0U (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 2 Sep 2022 21:26:20 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E413D599D
        for <linux-nfs@vger.kernel.org>; Fri,  2 Sep 2022 18:26:19 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 282KE1lD001629;
        Sat, 3 Sep 2022 01:26:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=nM90/GjkfTx8zpOD1HR+Ghj2jAqIWVlSBwk5yE64k3w=;
 b=Z3lakJEvHHfbZkjdphcWrMKbzAN83MSsnl3LqVgGNav7WbsB/vavy1dquWVRz3OT8rYH
 GK0VqWuhWLf+9MSox9hUYh9bDldKSu+7r1edBAUPtRNV4nUEjE/55a0Yx1Bini94jYlb
 L1fbTKmvEcdBOEWl2/HnUD1osUTQGaHtz+3x33vb4RBtc+qG6bH4d2DT7YGzpIogqLt6
 pZJO9wqhTZ+kbi3hGz3FAa5/EKAIxuQcRqBE5hA84FYZRJmOSnG/6cg/r5QpX/x/UW8W
 nOJHaUb1hevlpZT3ksRxx2cUuTFqRiCfkcjQkJ7nUgh3asbpqrapMG9keRrqZabhK+C4 +A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j7bttgfhd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 03 Sep 2022 01:26:15 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 282MUORT036675;
        Sat, 3 Sep 2022 01:26:14 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jarpcmmf7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 03 Sep 2022 01:26:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ne6r89f2p0/FEPG0Gg67XhFqu+vJRZgp7k9A8Iq8pu9pn1jmU8pHXNsbn5PJBdR9en5inanPaUpc9Y3ATJuulX/sKEtCaFDiOvMry0zE3b5yqtH1eShRDIuTHS4TJjF/3ZDCyo5Fi8559oXIrdliDENc9k6JThiR73q/mLy522jtAmpChikmBKxBa2g+lXbQnba/lGqchWeAePJdxkHrUKz5QeBuMl0wT+srNQhmn2/7VcujVT8VSCvLG2XKlWs+cVRs8ciuB3A6dshSYoU9rq1ACBOPUc9QGpJ1XesJpMlZ13RCfVftYtIKeBN7g4V+qG0Gc72eBWRcZ2H5fH5zRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nM90/GjkfTx8zpOD1HR+Ghj2jAqIWVlSBwk5yE64k3w=;
 b=O48j6v+3FhQ64GFfg5Il2Izmr4A51ZWs6+YzCJKIBuYSmszqYDWuxs2zp0RfjN+9/T1BOPoesc/6r8QOMM6+wyFYVirgcV1h26W5smoMWqJj64760kyrhCZ9frUZJx7ZIS3qsGH+BFWzUcNX9L4kV4DWDEaV7LjKFTcUz88DFKvScEvpLDDb/kq6aGekSbHZXBYTWrgnjd8kSxxgOFoYsmWqi/VE9I1xE6c5QJeJsiQu86l+lcKLtT4IxYBKPEer9oB4am0KuMe2hpIEs/XULw+w/y0H8+XhUoUDlmfd82GZGAcbnMWvSog1IB9MiOgXaOhNWSNYBEB4LizOF7uMdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nM90/GjkfTx8zpOD1HR+Ghj2jAqIWVlSBwk5yE64k3w=;
 b=MMVRypA0v7gLr4IBQRGrje2c62YVrNxshG4ru9GmcHLZgCvrj6DJgXbCr4do5yh+AR0ZaJuZMvBgULlY9NadROvXJQRAc5Qk9PPPfjElYMYtGx08kkEu8QpGpW8isxla/8ClajpmMffFlXRHwEmIEERigZlqGMtGnvSUlfANUl4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BLAPR10MB5090.namprd10.prod.outlook.com (2603:10b6:208:322::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.11; Sat, 3 Sep
 2022 01:26:12 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa%4]) with mapi id 15.20.5588.012; Sat, 3 Sep 2022
 01:26:12 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] NFSD: add shrinker to reap courtesy clients on low
 memory condition
Thread-Topic: [PATCH v4 2/2] NFSD: add shrinker to reap courtesy clients on
 low memory condition
Thread-Index: AQHYvLpF3IXRGSf70UK3afu6RNBIZ63JEv+AgAJR5wCAACuHAIAAzI6AgAAUu4CAABrwAIAAYjKA
Date:   Sat, 3 Sep 2022 01:26:12 +0000
Message-ID: <44A716C4-3904-424D-A5D6-CE46FC9145F0@oracle.com>
References: <1661896113-8013-1-git-send-email-dai.ngo@oracle.com>
 <1661896113-8013-3-git-send-email-dai.ngo@oracle.com>
 <FA83E721-C874-4A47-87BA-54B13E0B12A3@oracle.com>
 <2df6f1fe-c8eb-d5a1-0a11-2fd965555a33@oracle.com>
 <7041D47D-ECB3-497E-9174-96E9E36FFBDE@oracle.com>
 <eb197dde-8758-7ef4-8a7b-989273e09abc@oracle.com>
 <3CD64E7F-8E81-4B37-AAF3-499B47B25D19@oracle.com>
 <fc5a3aa7-af8e-656d-a16e-c07c201ec62a@oracle.com>
In-Reply-To: <fc5a3aa7-af8e-656d-a16e-c07c201ec62a@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9f7a4789-ac02-4db6-8f11-08da8d4b4991
x-ms-traffictypediagnostic: BLAPR10MB5090:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hOYRgv3z17AmS47untZoqDXG+VYQrisiA1AbNWTnTxIOW7/xe3sdGKLyWujoBiZ5eBSdvPnC0yHH087nWE5PEqp05Dxl/8x4wwVx2F1TDGqycuvHMN5NVNxDKMx6Wd2T45WjyV+4AlmXCd6N8nXLvjkIs1sn3cdAuJHXRVkkuL/dOOcB4IfYatTl355hWlJM87G4oS40cald2SuRkrudfQU7dFF0mYKTmacc7w8OE84u2QtxSWKIW9n2896mdM7zCg89BnNvMnKNJ2ii8sngW09scz3e4HAfRdow+8LPehEpIfbCKZWV/52mLXsn1sVZ36OiojPv84z3cOLA2q+wxPlGBsq8yW5601RXq3Dbpnb/rTljosAMwCehyEjYAY5j80faGlNyizCT0bsxnTHYA6ZpJwPM3Ub7pCuYiQSg52HeP8tHx/ucq9okPFHpMS1QlVOo7bNviy0xskAluL5b9Q8pgjL58GwHNM/UgSkaBWS0eooFFRlnTKU6tee0EudBt05Y8ba48DUd6i7CWbX8YfXo/a2NFs1fsLcWXAPJColn0OCFnk/343j2XUstqtuPNv8x0qHFkpahf3tjH5kgvfpIQFGAg5G+Bh6G5R5DBXguGL3/qavVIWaZG/fEfoPJAmHIdRX1bhsYMslzI7QY5SO8MO1MJXotK8yRhHtyZilRiyCzCB+8PiOxRQY3I6C/2BWOJJHIL+wseHVP1mm1x5chpboQgDOWwGChaliA0mnMEfYKXhp9WmRDhOpXSWQBaSBC7dGjJQ8AaWuvuesYdoxtUzeEP4jEaCkGt/i4FpQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(346002)(136003)(39860400002)(376002)(396003)(6512007)(6506007)(26005)(71200400001)(186003)(2616005)(53546011)(8936002)(5660300002)(6862004)(33656002)(6486002)(41300700001)(86362001)(36756003)(478600001)(122000001)(38070700005)(83380400001)(6636002)(37006003)(54906003)(2906002)(316002)(38100700002)(4326008)(8676002)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(91956017)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Bkg1GN4P0nvkZdqUx2V7rVFHI9/I6XIJmQTGdSoJGnG89GboEiH8NEfq83mD?=
 =?us-ascii?Q?p3C5CnxVrHuJSGj5ajXuqRIO3wH5Vlao/MwBK5jVZljvR4HweVK0cMZJVcf3?=
 =?us-ascii?Q?NojOdNFek7oBt6yHGnFBko1alQKZNblbx3MhYw/J+CFY1o4Vyr+7CBl1uYvm?=
 =?us-ascii?Q?CSTLdKdZ0M8DUsXsCkydp1iJe9KqCxdpWqSObJsTHMrvbpMym3M1ig8wJWBX?=
 =?us-ascii?Q?ANH42uNi1M/RoUp6FfvxKL02MNyBEEMuV3PjOHEj2QqPZreKGnltawUdZlm7?=
 =?us-ascii?Q?tz1I8raCYi1/mWnyOzgeXYmpGh43RbWwKyW+1EYZsADwLzWIFRFnXCxtrVsJ?=
 =?us-ascii?Q?LwBUwp5bG/gPpfbAM1S+9JjP9O+keRPl7qCXdsph//xu5nCAt8rs4aSzcq4H?=
 =?us-ascii?Q?cTrQTSubTNyKawmOHMd0GmfY7OSwO1DKidWBbujzU1gFli2Tz4rkeYWGGzQG?=
 =?us-ascii?Q?r6Aa0pX02lVRqLcFVF2vZt59Exmzpxg93bT1zgYoIoxV723/R8VfwaZKNOEs?=
 =?us-ascii?Q?HM2mVcW3xIt82Z5Dgid+hPGq9fkf5rocLZlzXfNHFzgllvpcirZi3Eq7qypD?=
 =?us-ascii?Q?nEZASYWM7ukwjavZPocaoMyb1lO3N+k67QxfrAxOEs5DephfwIQaTGrRVIwZ?=
 =?us-ascii?Q?ajqHMNwxO5IAvs+nTL+1x+59ptVZcevjAXvhASr6tiIyo3dUFh2ECz52adIv?=
 =?us-ascii?Q?kMy7o77EROG2MfwJOQvxt82wxyFneDmr2JbmZYALShuv/0EFp/bws2Xdezsz?=
 =?us-ascii?Q?ADXZP0RQneAEIXhDvPjsWGdUqspwFA+a4cL2uclTUTyp+esI3lYjvHin7gAk?=
 =?us-ascii?Q?3ZwSRgQ1QLvCmanygTZI4VMljTNKEnU8KLyRmGC3lNOLk1S7jGr9sgJiZfKz?=
 =?us-ascii?Q?Rl5RKkkn2IzcrXDjs1MUvwy3k6GTMdEa72wSdAkZEAl4oA33BAtjQ2E0n2OX?=
 =?us-ascii?Q?27toSg+pkqUPm7wp71C2z3FlH6KYwxSKeMYw+ZrU2q4pzi6iduEY6VjUX6x2?=
 =?us-ascii?Q?JbxRQC3VIIOvJak3R3/RzFjkFBbSm+3e6mlswnZpo4+x96Q0Cq7QKK0Vf9Q2?=
 =?us-ascii?Q?Fb4JYiD9WMp21OE0e2a/AFGtH9AFaCrFukwvW3bYxXcW5dBDNu/1+Lhfhnjh?=
 =?us-ascii?Q?GMnlROaapv1vTQgfA7WvoW255SnIb1TetxASk8WWGx9bthgZTxADz6Jxvpit?=
 =?us-ascii?Q?SDvmdft9bFPEI/diFCpf/obOD15zl6P+xFjWZsNewOTjvbQGcU0W2WSrTNel?=
 =?us-ascii?Q?fLtWaX2q+W26aeqnoV7nzqvEPpngbNi5NyzxbYwYCEdLuYXmhBnxSZ7P0R/C?=
 =?us-ascii?Q?sJsW2Tzu8gbxnyrGQ4jLrWDijAYw3ek8ZI0Bu9WwNTCx+0mjzYwbPrXdndFv?=
 =?us-ascii?Q?Wk0wGU4yDaFQwfWLyp8vqKXcwVQ3RQ6+T/H70sLaBec9GBrWzp0pu69QUP/3?=
 =?us-ascii?Q?VHEL4heFqpiadEiaAV9emi/gzRhIk/KrWv6amJ4G2Ay7jZ22gXkUKKTLrIHe?=
 =?us-ascii?Q?b6cadOeS0FTUSz7XYIm8IZP2I/R9P8aN4BDQOW7Q3ajMiBb1aTyZ1CzaWwqX?=
 =?us-ascii?Q?dIMPg4zs1OH8M2BN4zVz8LZpGYmXVrtbw84lFZhWgEERt7oGpZIr9BlQCrxW?=
 =?us-ascii?Q?oQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D44E947BC639A54881677CCA82EF3320@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f7a4789-ac02-4db6-8f11-08da8d4b4991
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2022 01:26:12.2529
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5NT5aqSKgxXKAjStBcZInRQp6eBmfBvVrmmFyZVUdoYMaYJZYlVRNeUaw8F9Uvj7yDx5lawu5bG/V+fYjojMMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5090
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-02_08,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 spamscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209030006
X-Proofpoint-ORIG-GUID: fXqYLJgipElKUZ4SarpSvlEGjWbGMfXK
X-Proofpoint-GUID: fXqYLJgipElKUZ4SarpSvlEGjWbGMfXK
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


> On Sep 2, 2022, at 3:34 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
> On 9/2/22 10:58 AM, Chuck Lever III wrote:
>>>> Or, nfsd_courtesy_client_count() could return
>>>> nfsd_couresy_client_count. nfsd_courtesy_client_scan() could
>>>> then look something like this:
>>>>=20
>>>> 	if ((sc->gfp_mask & GFP_KERNEL) !=3D GFP_KERNEL)
>>>> 		return SHRINK_STOP;
>>>>=20
>>>> 	nfsd_get_client_reaplist(nn, reaplist, lt);
>>>> 	list_for_each_safe(pos, next, &reaplist) {
>>>> 		clp =3D list_entry(pos, struct nfs4_client, cl_lru);
>>>> 		trace_nfsd_clid_purged(&clp->cl_clientid);
>>>> 		list_del_init(&clp->cl_lru);
>>>> 		expire_client(clp);
>>>> 		count++;
>>>> 	}
>>>> 	return count;
>>> This does not work, we cannot expire clients on the context of
>>> scan callback due to deadlock problem.
>> Correct, we don't want to start shrinker laundromat activity if
>> the allocation request specified that it cannot wait. But are
>> you sure it doesn't work if sc_gfp_flags is set to GFP_KERNEL?
>=20
> It can be deadlock due to lock ordering problem:
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> WARNING: possible circular locking dependency detected
> 5.19.0-rc2_sk+ #1 Not tainted
> ------------------------------------------------------
> lck/31847 is trying to acquire lock:
> ffff88811d268850 (&sb->s_type->i_mutex_key#16){+.+.}-{3:3}, at: btrfs_ino=
de_lock+0x38/0x70
> #012but task is already holding lock:
> ffffffffb41848c0 (fs_reclaim){+.+.}-{0:0}, at: __alloc_pages_slowpath.con=
stprop.0+0x506/0x1db0
> #012which lock already depends on the new lock.
> #012the existing dependency chain (in reverse order) is:
>=20
> #012-> #1 (fs_reclaim){+.+.}-{0:0}:
>       fs_reclaim_acquire+0xc0/0x100
>       __kmalloc+0x51/0x320
>       btrfs_buffered_write+0x2eb/0xd90
>       btrfs_do_write_iter+0x6bf/0x11c0
>       do_iter_readv_writev+0x2bb/0x5a0
>       do_iter_write+0x131/0x630
>       nfsd_vfs_write+0x4da/0x1900 [nfsd]
>       nfsd4_write+0x2ac/0x760 [nfsd]
>       nfsd4_proc_compound+0xce8/0x23e0 [nfsd]
>       nfsd_dispatch+0x4ed/0xc10 [nfsd]
>       svc_process_common+0xd3f/0x1b00 [sunrpc]
>       svc_process+0x361/0x4f0 [sunrpc]
>       nfsd+0x2d6/0x570 [nfsd]
>       kthread+0x2a1/0x340
>       ret_from_fork+0x22/0x30
>=20
> #012-> #0 (&sb->s_type->i_mutex_key#16){+.+.}-{3:3}:
>       __lock_acquire+0x318d/0x7830
>       lock_acquire+0x1bb/0x500
>       down_write+0x82/0x130
>       btrfs_inode_lock+0x38/0x70
>       btrfs_sync_file+0x280/0x1010
>       nfsd_file_flush.isra.0+0x1b/0x220 [nfsd]
>       nfsd_file_put+0xd4/0x110 [nfsd]
>       release_all_access+0x13a/0x220 [nfsd]
>       nfs4_free_ol_stateid+0x40/0x90 [nfsd]
>       free_ol_stateid_reaplist+0x131/0x210 [nfsd]
>       release_openowner+0xf7/0x160 [nfsd]
>       __destroy_client+0x3cc/0x740 [nfsd]
>       nfsd_cc_lru_scan+0x271/0x410 [nfsd]
>       shrink_slab.constprop.0+0x31e/0x7d0
>       shrink_node+0x54b/0xe50
>       try_to_free_pages+0x394/0xba0
>       __alloc_pages_slowpath.constprop.0+0x5d2/0x1db0
>       __alloc_pages+0x4d6/0x580
>       __handle_mm_fault+0xc25/0x2810
>       handle_mm_fault+0x136/0x480
>       do_user_addr_fault+0x3d8/0xec0
>       exc_page_fault+0x5d/0xc0
>       asm_exc_page_fault+0x27/0x30

Is this deadlock possible only via the filecache close
paths? I can't think of a reason the laundromat has to
wait for each file to be flushed and closed -- the
laundromat should be able to "put" these files and allow
the filecache LRU to flush and close in the background.


--
Chuck Lever



