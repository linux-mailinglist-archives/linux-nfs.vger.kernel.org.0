Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 066AA6F31F4
	for <lists+linux-nfs@lfdr.de>; Mon,  1 May 2023 16:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232419AbjEAO0h (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 1 May 2023 10:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232376AbjEAO0g (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 1 May 2023 10:26:36 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61857E5B;
        Mon,  1 May 2023 07:26:33 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 341EJ07S019602;
        Mon, 1 May 2023 14:26:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=zHJ9h3ZJMTC4frau5gx54nf4tkcmyHkhGHNTivE8Kd4=;
 b=bGGcImiQCJJIKXn4U/AE/AddCcGxKC3U4DZK+NSRscnbMTVIiHLSHG09WAskKLD1ylX4
 oecNZmiFqkPRpRot76pS4UUCvcLjBcEO9IEv+hZVKDxQ8W2yhF/yn/80l+MpV8h7BdiK
 qayHo3aS74hrn/AwRlgQKmdaJUvFI809iNeABU4uI59qabsAylTGYXw8yWmyooavwrTe
 E6hAYTZWWhoHx2Snb2romkUhsrvncCQumCliKf9yTbpeWrQMHI/Gvf3cu/tfZ0DhHurh
 jxUmBIo7ln3Szg9YkhU6KO9Pg1enPLcS09jlpKuPPVmsuNFan+4kBVtvIbzVAoMAuZFe Sw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8sne2gh3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 May 2023 14:26:24 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 341Df5DK036217;
        Mon, 1 May 2023 14:26:23 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q8sp4hb1m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 May 2023 14:26:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i54uDC1a2EOXotjWEUzm780qTPpy/cfXjHKTzOGkyjkYO0t/6+oWUIGUwe8woA8gpLOeKAOCcvW5FZlT7vH0KTqckY0Fv7Qgkfz3K33Qy5Z4n0oY64gsY+/B2pl9EPwtuHFk9/q5rRYQdTXVKpSlWcQKezkdPfG3rlJTv7liinDbD/TzqRcJmRuiI+n7xnE91+g7o7F+ryFbyLCgDGmco4sdhoFVKe8g8TGIveeu+x35vvnrLS5VVcq09UwwW4iXyTbDdAz6JzPzLF4kTRHu3b2jZD2kriZ/UFhgQukjp8gTyjwH+nKM4rE5ZaIwLodm57aWUYCF9jBuVkHntUoPjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zHJ9h3ZJMTC4frau5gx54nf4tkcmyHkhGHNTivE8Kd4=;
 b=At8KzRkUvSRlQRBSBrfYWqV2rg/FSsw14s4WKZ0APjmR8Dkl4EuYVNE2GQ4LPl79lf1Kn2+bMPrBBfLsj+w1CMWsxqOLQu7lkLaQtAxAFyuCjm91giGHcLGfxSXpVy5BVcXNed5m2i0QxHF7h4H3pgxmUKpG5hWHJ1OYyWzfkC7YFgj1IP2SoMdHc8E/GzLP/wmMwqKxh8JEqCGZJZH81aGhqLLBQesZo36A5M/2CAES7G6QhOXZ0WByYCh75mvykZANAwU6a9lIUc7u1C6FieeeElMvlM2gYvaRwrAIVEHOt8FSiMStcDHHcb/pbQDgmrlUK0A4LEw4IfP4fjLmMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zHJ9h3ZJMTC4frau5gx54nf4tkcmyHkhGHNTivE8Kd4=;
 b=En4Nv6a/VMD5IFIUlyKoVC0Uk6GaxQUN9xTg3etYvkoH0zSh2C2pNh0Bcb41FnRvuApj0bZeYwHqxTLyJzBhvGVHA58Xmmua654NHeIEbSPKQfoDvLQGFzbrJnK8o7khNs4pwF2DaGcv6fJxQXfQl3nL3Q0f6QHC/lTwbsca5dE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM6PR10MB4332.namprd10.prod.outlook.com (2603:10b6:5:220::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Mon, 1 May
 2023 14:26:20 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%5]) with mapi id 15.20.6340.030; Mon, 1 May 2023
 14:26:20 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Ard Biesheuvel <ardb@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "ebiggers@kernel.org" <ebiggers@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Scott Mayhew <smayhew@redhat.com>
Subject: Re: [PATCH] SUNRPC: Avoid relying on crypto API to derive CBC-CTS
 output IV
Thread-Topic: [PATCH] SUNRPC: Avoid relying on crypto API to derive CBC-CTS
 output IV
Thread-Index: AQHZfDXav6g/iMhhakayQmRGB85AKK9FeVQA
Date:   Mon, 1 May 2023 14:26:20 +0000
Message-ID: <033D5303-69C9-42B2-878A-581FD2184954@oracle.com>
References: <20230501140408.2648535-1-ardb@kernel.org>
In-Reply-To: <20230501140408.2648535-1-ardb@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DM6PR10MB4332:EE_
x-ms-office365-filtering-correlation-id: b53b215a-7ab2-4eed-cbd0-08db4a5008c7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yYjlnXvT9Qac0omHmDG+NiU0lYqBcAAChxvGHZdIt5mlFyzvARAlwJKNPckKdoS11x/EKDiOKES1t9kzbWi5BE8I3LVJmhcsnpCyZvLunKDDWFBKyojhI7ujhkefqbYrK1NyF8waZRJQXu/vFQP/36glv7TcswjHCkTZ+dQzi9I4M1xj10DBEXp6JazwRGVpmJd5PF3S3nKkioE0ekKn4sROeFYKYxKHKHC5Juacl3AbIUbei6OlInDq3X7EiVb1Z7jAsW8bhTPSMfR0Xo8nSOUx7iM0K45xCKSNmbWt0wlEXu4inH9AyaBE3SmNT3Sxg4uTeW1FCcjOq5bL8XdzTBmuAir1bifQAuzz9z3FrcE+hsoE5ZcGEi4vBTEiVhgXCePvioFUVkBRgTi56Xe6BPOMTxvYsB3vnKvjFnC9YT6eDtbqoyw6BiMHMDgrXu598VFsom7Yeu8wOkY4BC3WY67AFpwNFLVSjd9cbweZVNrnMvVU6sX55OqAuIsjnpzCFBRi6eiiNFApY3nOfDjlIMYbofGrIsRV199cnK2JLLbRP/Ar/zxyzrrpjrSw5wNkx3QUlXjp8rPIpQCaqCSJVXYbD+JWBRjt4dtzj4+r49edRorZY0FqRJW2kLxbBQJGDkFfoOD8DbsCIqyR9nL1tA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(376002)(136003)(366004)(39860400002)(451199021)(33656002)(86362001)(36756003)(38070700005)(38100700002)(122000001)(83380400001)(2616005)(6512007)(186003)(6506007)(26005)(53546011)(6486002)(71200400001)(478600001)(54906003)(76116006)(91956017)(66476007)(66556008)(4326008)(66946007)(41300700001)(64756008)(8936002)(66446008)(316002)(6916009)(5660300002)(8676002)(2906002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?N+W5ABYKVKIETf5w+TivFxlegvqV0T8k8EvvNlbD/hxm88xF1PeGKOclngc7?=
 =?us-ascii?Q?ZDlTC3EcXNpNEE4rq8GvtaJjR7s7OuCQxT5iMTCwgI/GEkwfFmQB+37A2zQj?=
 =?us-ascii?Q?4A61ypHlUFs//1zc11EfWbrB9TxIlgCbTIxqFyxeKjSK7n7RP9f2FFANfNmQ?=
 =?us-ascii?Q?O8UUiRy69n4jnoypXGUrClLzoQHcttHl5skEfucr8Vblmqsb6VJA1mHVSx5T?=
 =?us-ascii?Q?wn2xjCW7VKW2m0YV/VXoh+UcQwHY2z/Ycq6akRwpa5IGv+Z69QiT41TUXhEt?=
 =?us-ascii?Q?JF23ZN05lfVZQMuO0yWz4fMEqk2o2iG2eja1Ufw5OwQUHOeK/QITbDP3ZHnx?=
 =?us-ascii?Q?BH2jPFctTZ1iE1nXcUCOYUtlXnu/0h2Gn4IRGUBB1gq5cDSB17n43njslIlX?=
 =?us-ascii?Q?bbUzxcsgqLsMxktNegtr5UR56cSCPDi4+BwmYCzUkzzwYiIpf7pcJG26xNtq?=
 =?us-ascii?Q?uRWQoppgpWstJFXJpIVCbxyyXHjgzCuwRki/QYe/Hk988fALvS9OoqTCslKM?=
 =?us-ascii?Q?mdfg+78EpqWacyU4LfjUjZFMSUhYfjPRa2AhXi5XAPh1Er0KAgsx0Yn7uL8u?=
 =?us-ascii?Q?vZS3ZgK/Tlyl+wJ2Ob/VBaOPQUqgpH8Hj+bvqXUfgUWpuJCwIqHP60rJMapG?=
 =?us-ascii?Q?nJ6frIfZPxfs7/S8Qyr+Giy6SHgLHibfJr+lAYXznb32nCcZ6F52x0VK9Nxy?=
 =?us-ascii?Q?kth8LPzDAJPZUUbqadQ8UHukayLNWxNj41KFxbnwRWZO8cgfWT6LcanwhwoB?=
 =?us-ascii?Q?jazReo9JKt8yTL6IectU2QPiX/zYZNWzzpTi5Io8PpcIr4vw8cpxwkFANH5Z?=
 =?us-ascii?Q?PYdGQ8rAkSVmccZu7lo/DFuM4xhyGB4l1/o3ZXbUC32twTzvBVIn/d5sOJ4x?=
 =?us-ascii?Q?DvVlgYvD0+mcDvEwFobHXmxGeDmMUYu+KX/7Avl1Dyc8v61zS7r+vEzv2KFD?=
 =?us-ascii?Q?2zgPogSSn3pS7sBIQ5AmXxCpIJV3mqGQNVs1fZvxRWb+4daCIgY5Ihu0UebW?=
 =?us-ascii?Q?V/SB2dUv1aXEKXqOW/QpNPCetr88tIBl1POIS+uMMXOryGdBVDqT5wHqjOte?=
 =?us-ascii?Q?Hhqh9e12klzP2lRqjQ1vcvApgapUG1tcEr3Sew+8KqskSy+9RVXl6C9AoLY6?=
 =?us-ascii?Q?5dE3paF/DrK0Vrjwc2h1OkJRYmLAIRIFeeW/+VkYJzfYW03VlSGV2nofUAv8?=
 =?us-ascii?Q?K5p9BTr5IE3YEYIPzTj2/rAifc/NE2IvyLWx+u+3NLUQHEfv62TCI8qSCwr8?=
 =?us-ascii?Q?Dv1zlKB6mpwvwtJZ8/3vjUCP0dNtxBYKDLoI5DWyTT6u/cgVQoxNM37t6UKz?=
 =?us-ascii?Q?/BdJDF5vTYl87RaQCQd0E/EYlyCEiSmD6pF6JH8E4TMhPj6kDL1wER3Udyp1?=
 =?us-ascii?Q?TDALoBG/T9ce4RkWWLDbMSHK64vjP2ufTKVUrzSmg13xAfegNVfNLcwI7x8c?=
 =?us-ascii?Q?mXN659/4BiH4kuKE5WdjpiEe0TeZJ+b+Yuyj50zFh1vuOps+xjRH+AkfNCR0?=
 =?us-ascii?Q?v93WANkRQHc5AZ7kcVLNrbhqETciEkbmDOrtNYipJUub5N65ljAVNSuAS47H?=
 =?us-ascii?Q?PcFnfgL48VfZSEeYmhKmTsBpQlqaSoyd2hf5YlAhMRVXGaxvgXaf4dg9LDhX?=
 =?us-ascii?Q?qg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <42939E1020EA7144B827CB4674DAED8F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: CbEYkkxSLq+okhoOSNpRW9hn0qwpPueG6sWg3a0iJLqsk2UZlBfr63nW6vHYL+18Whh30MUKnQUrhk5yIcJKL3Lp9thMufyFSNv5TODLa2uM8LglwIrS81YhQ7QUpBBhr+b2stM1WIWa4ejRvcUvWBwcPApqCJt4E0rU4n/xktV8ez+lhMos/IRWiFuay0qyEnY+RY++rPzeP4o4Y9nMaABzmBlpvOzwJiYsqw5MLtrHyZEl65PGUmV5TEJy4GyzKB6g4gThmdOcjUKijtG24NmfXRhbp6vBg8xpSPX9ZipfN8fFoalHTat7os7htatUIg7IoVbhKQE5QKc9UtIoMTOqz98dCJjqXJIhCp0NmKopnjGySFKp72ENl5vm5wy50teV/atqtVWfmg7+HGJnZdvufMDFiIPwdWrvhIP0KkGP6zW1ETTK4+/5Cfl/4uY4GAFNNCuG4MAcbp6blplHizTm+cpMvYRTF0pLjKWKze7/GdKkRtyZK2RvkZuP+yJS/NVa1dz0FCJOiE/DxgfyJxWDdNDOznFLH9ptwmT4kcTvT9qbWETeAI2Nu2tcFaneLJ8TExBPC0GxjKiL+XW76atmt+N0Nr8gDPXZelbMCq4Zm8cHvSvrNl5W/kbmrM8cjj2YiOS836/sCjqWaQjCF3W+gOpJYWmEHzKtEZD2AbLlBk1cRAwdZNAoGwFPamkUQXJIbECE1dKhKQiLn9rpbjZqTm1vCj4aWhKHAiy6cBgVj0T80l1tIHSj//K507a88it8Ey3txT7yC0mOXx99vFzJ42M1SYvMHytkCfhIPRxTHygFqJCPda8lj5MtJhgSoD4yIFdxcOn4oh5OFGnF3VzltOT+QhF5MoJdymaJzL4W3deyWCwOkE5q1d2Um0KcK+A+gMVe+HMnFPS5dyAW2r2h+/E/gjchsHmZLXMwD50=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b53b215a-7ab2-4eed-cbd0-08db4a5008c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2023 14:26:20.8032
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dLyxN4XP87p8IyNezY7cGEupP72zBFmDZS6Wm9AowSymSfB38rgJZw7B+setON9/ytUY34+HSlg9TeUeGwqBQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4332
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-01_07,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305010115
X-Proofpoint-GUID: DAjhua5N9Ozss0HJr-W0NmNbgjQxwScq
X-Proofpoint-ORIG-GUID: DAjhua5N9Ozss0HJr-W0NmNbgjQxwScq
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On May 1, 2023, at 10:04 AM, Ard Biesheuvel <ardb@kernel.org> wrote:
>=20
> Scott reports SUNRPC self-test failures regarding the output IV on arm64
> when using the SIMD accelerated implementation of AES in CBC mode with
> ciphertext stealing ("cts(cbc(aes))" in crypto API speak).
>=20
> These failures are the result of the fact that, while RFC 3962 does
> specify what the output IV should be and includes test vectors for it,
> the general concept of an output IV is poorly defined, and generally,
> not specified by the various algorithms implemented by the crypto API.
> Only algorithms that support transparent chaining (e.g., CBC mode on a
> block boundary) have requirements on the output IV, but ciphertext
> stealing (CTS) is fundamentally about how to encapsulate CBC in a way
> where the length of the entire message may not be an integral multiple
> of the cipher block size, and the concept of an output IV does not exist
> here because it has no defined purpose past the end of the message.
>=20
> The generic CTS template takes advantage of this chaining capability of
> the CBC implementations, and as a result, happens to return an output
> IV, simply because it passes its IV buffer directly to the encapsulated
> CBC implementation, which operates on full blocks only, and always
> returns an IV. This output IV happens to match how RFC 3962 defines it,
> even though the CTS template itself does not contain any output IV logic
> whatsoever, and, for this reason, lacks any test vectors that exercise
> this accidental output IV generation.
>=20
> The arm64 SIMD implementation of cts(cbc(aes)) does not use the generic
> CTS template at all, but instead, implements the CBC mode and ciphertext
> stealing directly, and therefore does not encapsule a CBC implementation
> that returns an output IV in the same way. The arm64 SIMD implementation
> complies with the specification and passes all internal tests, but when
> invoked by the SUNRPC code, fails to produce the expected output IV and
> causes its selftests to fail.
>=20
> Given that the output IV is defined as the penultimate block (where the
> final block may smaller than the block size), we can quite easily derive
> it in the caller by copying the appropriate slice of ciphertext after
> encryption.
>=20
> Cc: Trond Myklebust <trond.myklebust@hammerspace.com>
> Cc: Anna Schumaker <anna@kernel.org>
> Cc: Chuck Lever <chuck.lever@oracle.com>
> Cc: Jeff Layton <jlayton@kernel.org>
> Reported-by: Scott Mayhew <smayhew@redhat.com>
> Tested-by: Scott Mayhew <smayhew@redhat.com>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Thanks Ard. I always like a patch description with lots
of context. I agree that looking at the output IV is a
GSS Kerberos idiosyncrasy.

Since I'm responsible for the GSS Kerberos Kunit tests,
I can take this one for v6.4-rc1.


> ---
> net/sunrpc/auth_gss/gss_krb5_crypto.c | 7 +++++++
> 1 file changed, 7 insertions(+)
>=20
> diff --git a/net/sunrpc/auth_gss/gss_krb5_crypto.c b/net/sunrpc/auth_gss/=
gss_krb5_crypto.c
> index 212c5d57465a1bf5..22dca4647ee66b3e 100644
> --- a/net/sunrpc/auth_gss/gss_krb5_crypto.c
> +++ b/net/sunrpc/auth_gss/gss_krb5_crypto.c
> @@ -639,6 +639,13 @@ gss_krb5_cts_crypt(struct crypto_sync_skcipher *ciph=
er, struct xdr_buf *buf,
>=20
> ret =3D write_bytes_to_xdr_buf(buf, offset, data, len);
>=20
> + /*
> + * CBC-CTS does not define an output IV but RFC 3962 defines it as the
> + * penultimate block of ciphertext, so copy that into the IV buffer
> + * before returning.
> + */
> + if (encrypt)
> + memcpy(iv, data, crypto_sync_skcipher_ivsize(cipher));
> out:
> kfree(data);
> return ret;
> --=20
> 2.39.2
>=20

--
Chuck Lever


