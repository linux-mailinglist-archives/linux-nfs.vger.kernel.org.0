Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB326445B6
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Dec 2022 15:32:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbiLFOcn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 6 Dec 2022 09:32:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbiLFOcl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 6 Dec 2022 09:32:41 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65FF6FF2
        for <linux-nfs@vger.kernel.org>; Tue,  6 Dec 2022 06:32:35 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B6E4ELP018714;
        Tue, 6 Dec 2022 14:32:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=nvpMLJ6xtY/HfnDGTEZtiuJeYwvpZObN1R39Eo4vYNY=;
 b=YH4xT3H5tJoc7D8k64eQ3cOylg0u14PRc9rYbHMz1jXFxmIbWBkleCLLgbWNo368bW7X
 tblp404UXnmkK+nsb8Y8p6wHPGerPk0R7kWUW85A5RHdJ5qYVv8viUB4XMHzF4s8EqBu
 lMlEkqbCUNa3KA4MBuLKcO/qj2cjBW3ZaELUHbaqsXd3WDR9BsX+qUoMWdJ27CG5E7n+
 0OJ80eFhuOTQk8qiSSLu++oXMDweGY0cV6L+WK6ukQzBXjGspswhEUQdjs3l4LpLpe4g
 Yt6KT3iEN2987zSNREdhluwR/dZwrmbxGQC+Wz3otxxmDxbElJeKcHoE3hzAaZDagxOi fg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m7ybgqcp5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Dec 2022 14:32:21 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B6EO3lt010355;
        Tue, 6 Dec 2022 14:32:20 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2047.outbound.protection.outlook.com [104.47.74.47])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ma4ja7u20-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Dec 2022 14:32:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZXX9hPzFL9Nnsk13wr9gOKnQPptUfSEbr4KGsL6FdDrJkV4fXieIUhHnMIYoDUyqLbzWPjuum8wATuXjTljTdBl6EzCNVXr2y8JoyTlifmw0r+wylv5JGhbQqYuezLE+bUQpVu9EYtPQFAzrjxl+WdIRCZM8mADI2io9R9oGN9H742B2ahnXFi1vVQ2JDm7Pu0M4O7Y0WXdTm9XiuHmVfrED1t7z39F94+YUEfR1PhC6s+5AMiB+z0R/KOS/sRZcztzk9lSNRpJf9LLjBqCCmXHDGsoGh7DmfUK9gB3P5cRa7vuOXNx15WbP0U8XpWOTppbfNjyMFOOx2F9nT1jDng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nvpMLJ6xtY/HfnDGTEZtiuJeYwvpZObN1R39Eo4vYNY=;
 b=O2lTPpMQXYSNutFob9kmcB1UOV85Z99nZbpk7AD7ahfQJNYAstMClSiXoK3EIAsw2nKuhD4V2m0ScteLTHTV/+6egq437rKoLpNewnrWsRBauez4qEXBDvN3TNzzkvY7VXXcvvAEMga2UN0hWuNf2YcCguKtGf8TVz10LdLbBVvff7UncvUo9muvNAu1FgUmFt/seX6DoxSX2ixXuQ0Op77QiKrE6thZ/VIbgc4Pc0NOeVIzTK7O8xGhhf16SKPvHbUv2zCp+2UOz0CeahuJ2B/jtin3dY4NH8AfvUL+M1JF+8Ei5vWQLdRk9bGN7elf0DpuHUuzWtM8YJp+jZS1VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nvpMLJ6xtY/HfnDGTEZtiuJeYwvpZObN1R39Eo4vYNY=;
 b=u4de0mjOwa/vN29ETuIlhQRDqXIN6ZRnRnEkkhKu5s37whZqcF2Wso80gU5yXxDw1Oa9XS3x7VTNTKuJIMG3QO4siHs82vsL+yfvTiw7+2F8laGGZJsZFOdQfAiq3j32AgSWbjjUEdgBkPkVABkI5ttfGJQLqyhSpzO1wk73H68=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN0PR10MB4981.namprd10.prod.outlook.com (2603:10b6:408:12d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Tue, 6 Dec
 2022 14:32:13 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::1fab:d731:c933:ed]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::1fab:d731:c933:ed%8]) with mapi id 15.20.5880.014; Tue, 6 Dec 2022
 14:32:13 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Benjamin Coddington <bcodding@redhat.com>
CC:     Theodor Mittermair <tmittermair@cvl.tuwien.ac.at>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: NFS performance problem (readdir, getattr, actimeo, lookupcache)
Thread-Topic: NFS performance problem (readdir, getattr, actimeo, lookupcache)
Thread-Index: AQHZCRoQ0sR8+FbrrEeyEVhIhKcs+q5g2RaAgAATxAA=
Date:   Tue, 6 Dec 2022 14:32:13 +0000
Message-ID: <22200778-0055-454B-84F2-E633E321C834@oracle.com>
References: <dc3b95d2-93d0-992f-8f02-75c5bbb3bdff@cvl.tuwien.ac.at>
 <0193C32D-D74A-423C-AF08-58EB436FABDD@redhat.com>
In-Reply-To: <0193C32D-D74A-423C-AF08-58EB436FABDD@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BN0PR10MB4981:EE_
x-ms-office365-filtering-correlation-id: acae0554-8c88-4ee2-ee5e-08dad796aa8b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V1qZ7MdD5dIvidbqEVD8DjNUPVTDWufK5y7oPmcMdFhtnE+8BTdaLsMoPcxawjd37c96sTuVvhlLua6SGtt8CPPCWb23M0pIqvW+CH2pW/ogeYiEBVF2G8yzv49tUoB875jMPO3loKMi5BogjFHURL1O7MUYDRm+hyOcK8edSmq1RkXPAdsxOEj+xBBjMQ43PkgH/SBn2wPbOsANtxb4qbSZSHlUsVMAW3YHhBYDYTeGmftFb25xBqTTFQjOEPN7YtHkhyEQkQQPVwJVpPiOuq7Jnx2CsqMWKKolyc/OJRk+9GHw2jjwVFKxFJK5iQDpYhDbTCbcnUpa6Lf1C1KUP/ACn1JqJENZE69Pjq8EdnowToEKQIDd/th86NmXJ+Fi2QXDh/7ZzOMvSF7fheoYZkjNq03DpXQicpl8LsbYcfgsWuy+HOK+fL4PQJYGKSMJm0xqUExGtzZYYm0xPzMfFIom2CbsCoxsUeqvEJkLMByJpqiw4azSsdLu+4Xkhd60rObReai6UzO2FfEBolbBpSJ2eO3JzVxH6o/pEi2uLFXOBVXnWELpNk873lPKaYGsHn6v4VgXZ3GqPBTaV1zCekHxcRRmseXnvDZnLFMn7IuUL9+NX4Fw/fdxgNZLpZbV0v3+gNu9b5Umzi5D0OxTaPEpCj8nsRTF4mmxsjsUgjeiiyAU+/VI32cT9NM1t6nuS6wajiXWQNpmmrfp15AF24qaO07/4TN0vKVHvVTohCg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(39860400002)(346002)(396003)(366004)(136003)(451199015)(83380400001)(122000001)(33656002)(86362001)(8936002)(5660300002)(38070700005)(66574015)(4326008)(2906002)(41300700001)(478600001)(8676002)(26005)(186003)(53546011)(64756008)(6506007)(6512007)(6916009)(2616005)(66556008)(66946007)(66446008)(6486002)(91956017)(54906003)(316002)(66476007)(76116006)(38100700002)(71200400001)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Zwf5YL7/j1s3OAqM2rj67MY47Hpa6ZoVwkTgvLbpE525LtCBOZNQfdUB/jmm?=
 =?us-ascii?Q?8ITwJwnUVRO4RVbzujwS/7+CqOLFluQuUvTH85+91CYyD3iAP/pdYkXWg7Ox?=
 =?us-ascii?Q?L00zff4p2ubH2fakwGcKzHAO0PmsOFiDdumnB7fDcImG59xhgg0qYE9GJO5s?=
 =?us-ascii?Q?Bm8Xwft+wGRpJUpcykRwLbSm0CN079wWSQZZ03kyZYMvcD4AAjp0PGOQ4D0p?=
 =?us-ascii?Q?ICv/oW7eyFAlOLbCL47Go9fFIhBtHHVxwx1rAbNxVXpnjM9Xj/9PxLfNPAbi?=
 =?us-ascii?Q?DhYu85EkxobtgGGEAXgcnDG75SlYsgvzxPO1vrz5DAKdsPg3OqqUGijeVzMr?=
 =?us-ascii?Q?jgHmmn5JP8Z44NxfswSg300VnY++IPHv+kzopb7A4nI5NMAMHaSLC4ig+eHI?=
 =?us-ascii?Q?mY/6UED26CE7iDIAWyrWtnqReYExL+0ZsfOCkm8uv21lsHh2MK6U6Ghfkw+E?=
 =?us-ascii?Q?tPl0RMGnh4gL1Bzi/kybBYTzIFNuiaHQAVouZi5q1cpVWUaR0tWalA9oAa6i?=
 =?us-ascii?Q?qz6sH7pYmUPwTJXCAMBfzvJzzOhU/xQI8se4lqEJ4aWvuw1R2kHaCOfIKhOy?=
 =?us-ascii?Q?eX0EduANiBxbVVECG37suy2BYMsjG+ASWBRLq7+SEr8bfQxAYdCLNDTEBmAy?=
 =?us-ascii?Q?f8vQD268VyPleVuUqO8zN4gGTRMT5Jybmuh+NSFktc8Gj4r4ModquSfTF4mw?=
 =?us-ascii?Q?EGaXPmoT6bLJCLdQszdYVWpUfr1bxHUdTivSFp4ll3wyAxDiCSK8D/jHBHuP?=
 =?us-ascii?Q?lZ6GBCYvARpjws9gQigE3aywTvk28rFstMabHSqtQqjX50uRwyes0p5kLqHp?=
 =?us-ascii?Q?13F97eS6n43K9fx7+R5g5e9uXs968A1Fje3GqXZNXaMivLYg/ZfcgRvZYxyt?=
 =?us-ascii?Q?UfdtAOdsxQ54yFyCRk9xDclCQ15MornBBBdgvHm8LYqzCPLAzN+0Xfjcn5em?=
 =?us-ascii?Q?bXtaUVnYijsTRxgfK/A/5j/17mbHh75T1ETALd//Og/y82RrEAjVhFjvEP/e?=
 =?us-ascii?Q?87JRutXQnhPjhca8sbu4vHPLT5NKR5qV90ax1BKRv08wqiOi9K+FeIAN9ELp?=
 =?us-ascii?Q?RLVpISGPNpDBcZ6TiDMixbks0n4TJneuOrAT6ze5pf965c53oCIFe1rOudv/?=
 =?us-ascii?Q?JzkOLALPkIIhxR+GaHMJonDPNAb8sOn/Tg1D4D/MhgiO7gyi9bWOwqAmyU4b?=
 =?us-ascii?Q?Ph5h+p1XXNNtBaQeGAK5KpHOfuHFnC5uvpQVhg72RxSNFjEtokqixmyfKMs3?=
 =?us-ascii?Q?NLQa/0XfRBHpeO9BvunjPLmvCmlKI6SGW02890BXYKI9E16Jqlescqmpbceq?=
 =?us-ascii?Q?9SVW1wKG2VXJ++bQVe2dcRJm5U3kiQwBNtmBjm+E1E0FLS1PyMAk53SErHL7?=
 =?us-ascii?Q?zXCtOtvz0Ize6h/+M2De5hb+/UlEA//6JGInq5hfSSrT6eqo8W0Oca3c0Jdq?=
 =?us-ascii?Q?IQFzZ7T617F3YYc1UYEmjLvM1gQ09231d3iNB2utIaqtB64Oao9XJ5945F6X?=
 =?us-ascii?Q?JNGSjn/KMiS64ZXFAXrBZlxqrq752ks2iPgsyCxSkKl6QP1J4f0emwcWBDlT?=
 =?us-ascii?Q?IALsTJiQRTEiqkOChr9QcmFSQtVqYBaxKu2aEuKWGLivufKwz4sdaWqZDJ94?=
 =?us-ascii?Q?Aw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <44038C981FE0E0428DED9801AF81FBA3@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: nXmsxfj+z8hA72dVkBPzmnHo5LvziKtBr9t2QwWXduNOHkWKlkppN8IjIjIXZS62b8vuwsd0SdJX4IL5mJn96ocoodVs8csWRA3iUjRUL+clUpShSwIZ7x0gInL/ForJOymULJm2VVCBF3GvQLC1uiDk9OLsOmbk/SGRAq5+ty1N0iPgL27D04A4T30EmA+rx4+KsbuT6u7MZ5ijc8QbSHXsEevGMDTmeSOuC0KRyXk0FMR3DLg3bgo2GvG+3KDdEzCJPlh4xD9h9LANyXPTr3K5PhnxSmogHJUKyeDftN2dc+JjetDhSz9VToF2qX6RWCiY5ovOPpzqOemGrvHHpJzh3VTd5X80//MxXy/fnb89m5IJJP6xMEEf0AB7paP2+w0zSVBb+44q7CgYoxt94fyQDFTHiA/onC9zICvtT10ZiLzDJAF4M4+JyvEFmC6bXxgXYi/zE5J7vcHrrF+822BgcbqhEEMTzw+iphOp5wiLevisSsZVqnlmBRT9LdosAujikLIqx/RZUcTg32xB9fhssgwKgmCzNrl5hudsD1jRBJK+82mwJ+avvHd9278MOQ60nCcoT2mmefXfa52cw2pUkxt2APFeKH2oIzcWUYbigw2i1Y1B3hj+PvnOsZ18PUVnhWDheUPxRElvkdoA8sWPOc0XIP2L2InR/7cnXlDgslFYQR5PBAqjerpCjxGRjTl5XIvWBqE7WmtAct8EqQafn4CwNPvlQAgHnzSCJA6HbnxVihE5zXbFvHCwYShpZJAk08GRnB1if9e61jsMsC1Iu0p9I+1ZDr5yEvEp6/CwwE/v51GINeRQSxTYKs4xjAiQhfc1rmTmf6BvrRPm6A==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acae0554-8c88-4ee2-ee5e-08dad796aa8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2022 14:32:13.2241
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dLP/IDJ37FgLetlSlqhk3zgj7Sj+SLU2fqVtOQ0cFaEqRiyg7inPSwtoIiBZWGwTRtTm5hc4vUMDHnE69NlsDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4981
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-06_10,2022-12-06_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212060119
X-Proofpoint-ORIG-GUID: M9GNhkM1QKfG94-VG81Z1lEycVl1AMf0
X-Proofpoint-GUID: M9GNhkM1QKfG94-VG81Z1lEycVl1AMf0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Dec 6, 2022, at 8:21 AM, Benjamin Coddington <bcodding@redhat.com> wro=
te:
>=20
> On 5 Dec 2022, at 21:18, Theodor Mittermair wrote:
>=20
>> Hello,
>=20
> Hi Theodor,
>=20
> .. snip ..
>=20
>> From what i gathered around the internet and understood, there seem to b=
e
>> heuristics involved when the client decides what operations to transmit =
to
>> the server.  Also, the timed-out cache seems to be creating what some
>> called a "getattr storm", which i understand in theory.
>=20
> When `du` gathers information, it does so by switching between two syscal=
ls:
> getdents() and stat() (or some equivalents).  The getdents() syscall caus=
es
> the NFS client to perform either READDIR or READDIRPLUS - the choice of
> which is governed by a heuristic.  The heuristic can only intelligently
> determine which readdir operation to use based on whether the program is
> performing this pattern of getdents(), stat(), stat(), stat(), getdents()=
,
> stat(), stat(), stat().  The way it can tell is by checking if each inode=
's
> attributes have been cached, so the cache timeouts end up coming into pla=
y.
>=20
>> But why does the first request manage to be smarter about it, since it
>> gathers the same information about the exact same files?
>=20
> It's not smarter, it just optimistically uses READDIRPLUS on the very fir=
st
> call of getdents() for a directory, but can only do so if the directory's
> dentries have not yet been cached.  If they /are/ cached, but each dentry=
's
> individual attributes have timed out, then the client must send an
> individual GETATTR for each entry.
>=20
> What is happening for you is that your attribute caches for each inode ar=
e
> timing out, but the overall directory's dentry list is not changing.
> There's no need to send /any/ readdir operations - so the heuristic doesn=
't
> send READDIRPLUS and you end up with one full pile of getdents() results =
of
> individual GETATTRs for every entry.

Are those GETATTRs emitted one at a time sequentially, or concurrently?

--
Chuck Lever



