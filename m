Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3A56C6FE3
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Mar 2023 19:01:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbjCWSBe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 23 Mar 2023 14:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjCWSBc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 23 Mar 2023 14:01:32 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 757DAE1AA
        for <linux-nfs@vger.kernel.org>; Thu, 23 Mar 2023 11:01:31 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32NHo7mj004707;
        Thu, 23 Mar 2023 18:01:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Hz8zR0/y+ktbMoBvsK7ys9u88RcTX27bCSjRQSbo/7M=;
 b=PZTQvQzvZRPyHf3mMvjE4KkuUGMVdBBkhcGFJTSLTzxybyqpxoB6MdmAoLs3+gKj+vvf
 hRBr7LWuBxItOusEFb1I0uuGlKJ8DNANRFlkEU9D1e7JaBnw2MSyHn2oP56AzEbKBUDb
 m5qp9Pnrbas2StxhEsbk/4sb3XKeA0ZAlozGRYy+spmAy0du/WJMLCz9qEdWr04Kvva2
 6KuUldvr9ut9EwUHu38LpDse3i/KSOLXJM3/bu94N7MM9iw/wTBVAXhZtNFOmmK6OjsV
 BN126jXxWuxY2OQkq47BqUemmrbkhEIZFzxzHvlf59UnNTV9aJH1gpVXYwb+0Q908awd qg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pgugp00tf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Mar 2023 18:01:23 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32NGmbVt023069;
        Thu, 23 Mar 2023 18:01:23 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pgt20ct37-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Mar 2023 18:01:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C03rl64gYwl1i3Yj+adwlJxrX6SaeybLkBNYlrDBve7Wb7GZGLl9wKG/Jr9pkYxJXvJSTR48otKOgAXEhHofqUUQa6ftWwt1ddJzWZCqiM/niQPkZi++GyCwAPaWC7lpZlNx5MSpqRMZ55bjz479YcPX5zEdfdJWCyPx/s+Vffb9N2j5OFxaqjf097GJWBZQko0WFK0hInlQVaZq7xzmvgjnTPV+NgnkQiSbPSvvCtOurGWuKaR2aQYMXLm+Z+IlfbhkcgtG5AJKBz59xw3gZOsz5LRc2UfYVldei5SdDtw5cXZi+wvB07UulQ3w/mkGNcH9iGsS1s5TbMXtHU8YvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hz8zR0/y+ktbMoBvsK7ys9u88RcTX27bCSjRQSbo/7M=;
 b=DvC/c+qYT0LfTwaqnabixJmpzJKKU8YPmax4QNR2KCrZFb5py/RnLln3H7ehebjrY33dLDSAFAKtlOJu35KVMcpC3SZ+QC2Wvt//fG1scc3dAazYhltDKYWqE1jRyo2l6Lzxva+ujMBNYlrcmlfR9nIJ7nT+WzlFhvg1KsuHHxfTj5OIKsEmcsjPkUTe1PvRPci+VSzkiGbNqr0v5u6fiZqrEVW8Vgcwqedra8LVboDI1Divh3HZmjD91WW/t99RHC3HUn8uibYzpNtDqeWAn3ojIqJHF1rSNs4xvIPGszrHmpoAgSwTtp36peTztVQiXpsgbmAjny290OxrKJzSTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hz8zR0/y+ktbMoBvsK7ys9u88RcTX27bCSjRQSbo/7M=;
 b=gZnhyE6uiQIR2XVTX+tLMWpDZgxnykOFwRcSuYL0UEOeyrvnivfPpk/QcAx9eXAW3zjgP9DBV6D3EhfAH9I8cmMl7TBrgG1+kt05xQpGH92KHk0ZzR31WRmSEVN5juL4Fm74LX3xXUSKouw1q6EGQNHql8nCLC5x6ZDPgsiZ2W8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB4750.namprd10.prod.outlook.com (2603:10b6:a03:2d5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 18:01:20 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5c2f:5e81:b6c4:a127]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5c2f:5e81:b6c4:a127%8]) with mapi id 15.20.6178.038; Thu, 23 Mar 2023
 18:01:20 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Steve Dickson <steved@redhat.com>
CC:     Jeff Layton <jlayton@kernel.org>, Chuck Lever <cel@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v1 0/4] nfs-utils changes for RPC-with-TLS server
Thread-Topic: [PATCH v1 0/4] nfs-utils changes for RPC-with-TLS server
Thread-Index: AQHZWzlAXSqCgHySYk+ZhP0eJ9zOUa8FIOaAgAOKbACAAAErgA==
Date:   Thu, 23 Mar 2023 18:01:20 +0000
Message-ID: <7AC1BDBB-B6E3-49A8-A468-C045F0218495@oracle.com>
References: <167932279970.3437.7130911928591001093.stgit@manet.1015granger.net>
 <d5c93e97f10a8ae803efaad02559dd118e9b9b6f.camel@kernel.org>
 <da936d7d-a864-a2ff-64a4-a295653a6aa7@redhat.com>
In-Reply-To: <da936d7d-a864-a2ff-64a4-a295653a6aa7@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SJ0PR10MB4750:EE_
x-ms-office365-filtering-correlation-id: d09c358e-e2cf-42e5-7222-08db2bc89b7d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HoJiR9+B8e17AIuRl/YE4SfKjkt2unYOf55cKBCDm9Ds+2mMVDXfsAf1XT945AzDjIR9eVUe+fPlNKxGNKuCVCk7Ytr0805AWwM1Nq9H73gggWpsb08xXXWTzuFH2j8bxjni//63g6OgrnffqsO3ZO9QxQa0+M5QJ2EpLkQGk+KA0wq/331zGUiIWpS+mLdbj5OwrXLnrKQ/nfe5Azmt8ciW4FAY2Dg1vht9QCbLD/dpq07rh9g8cn8BAu2mB/xDu5kekMFx7FbTLUnpk9YM+W7CXFJ3qMQvNo+TfZ5cQWdfpER9ecolb1VzlwDjMSJxJxhSBHU+eHE2nRKZovTh9A88EnE2LYPuPwWrPrbHgcuVNS2TYdc0d+24uYWnZfA+8/21fSzZoOfw1cUKTkOIm0/g05lPYg5Vcz4HYTtRFfyJlDVuGnIp6lvukPnEWzSZpEHZfak89ycYc18wSULLih5ePe287tF3a/YCGbKkemR4JNd0jG3hGeCjWyB4Tgkfhm8eIoCEXCYqiWohqRiWsazOilED1l3NbwLnhO1kBO2ldBD6ErhoCjkC3QiDdRkFwGfPGUDFbKLWLs3hsm4SPv/St7xeUwqB02hxo9NIJXS4z/EEF96SI468/eCgikLCuTg14/hvosEElfpGr+v6Ry6G3B7YnHaDp8zdycjbDjEDg7c55GG+i3GLXNCyqJ/RgYxjgeij+KjHPz++IxcJt64jUbvFVWsXjHP3CzWsIe4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(396003)(376002)(366004)(39860400002)(346002)(451199018)(26005)(6512007)(53546011)(6506007)(36756003)(83380400001)(38070700005)(33656002)(86362001)(38100700002)(122000001)(186003)(2616005)(478600001)(54906003)(8936002)(76116006)(66476007)(66556008)(64756008)(66946007)(66446008)(91956017)(5660300002)(8676002)(316002)(4326008)(6916009)(41300700001)(966005)(6486002)(2906002)(71200400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fVz15u4OreHmZJatQQzRU4lcbWr/BALIKZZTsEVMmcLO8RVk4fpQ68zxMpbO?=
 =?us-ascii?Q?azNkYWx2JwQ1rdB0dpxr/QS7GP8ylplV4yAu62dc6NVEjGO+DXTZ6J+9ojHT?=
 =?us-ascii?Q?WIPbg8tXO1SckdYvkAjrSnhrcMYrReRZo/Ge8YyjAxd+kTqESSIsSChsk/ta?=
 =?us-ascii?Q?aTkjJDCTKKBwVD7ZlB+C6irFgszHS+WQGzX152uz9/UsB5wtSnv8CB8s7cru?=
 =?us-ascii?Q?sVOikj8tn/oei14loDcTQniAMO9fOyawkOvcJHgf3R2qx3rczOQE60ndlLOB?=
 =?us-ascii?Q?736XQoXVPCVKzd8NYlRHJeazcb+YioUk+jX21vbahvZjRz9rYLkOuMMk4ca7?=
 =?us-ascii?Q?x+lakLEVUSzUaWDF2AE5rwBrnIfnVxe6EdCRgrJvW04JVMVRifHvm+27GuJc?=
 =?us-ascii?Q?2U+DUOSSqAL0iTB1HKgF3qUGF29Mmb4G1Hxd/SragBLtbdE51Uc8VZnjJLTA?=
 =?us-ascii?Q?mTX9QyXAnw5fkSvijZTOIEnykYww6bea44ApiQuffpJ/d2T02EqyYeM0rEYg?=
 =?us-ascii?Q?GirR+mQ+pGEIswpVeGApKHmakr/emRqSpyEg8c7QV63AdR+gEFkQ3VkEXQZa?=
 =?us-ascii?Q?l9fy4qo6Y8t3bc1LhEfpY+pyZOpPIPBht3Kzld/Rbk6ZxinYDk8PAEat3DKp?=
 =?us-ascii?Q?6apFzjW6BUZRRLyZF3WL44SA/D1VH2ZTqT6XeNfP14HfzTYzSMdmSjTB3h1X?=
 =?us-ascii?Q?CiyHEEp4XJ9vkN2C2oVCtzNkR9NtyLou1sUqUcx7s9Txrq28GYb1L8FKe01k?=
 =?us-ascii?Q?TZXVrc47yIPQ8pKGT/iGqmb5kliN203w+6kX9w/ZKkdSP4DpLuXv77YWNfG3?=
 =?us-ascii?Q?d+Jm1ZvNJVU1cjWwtOcnCMjO/Yxp/z6sfAy62KJDdqRIeZiG9WhF/47ALxP2?=
 =?us-ascii?Q?vGr86alIpNTWTjzKF86aoaQHx+PnvyXM57TycG1Ty8iGgIWlOulYsPcaRTSd?=
 =?us-ascii?Q?cltXOQXRe2RahIsNK3fxVyg6s2VxNqnAYyYKA00cSqaYFJFJgF/sVNrCCyGP?=
 =?us-ascii?Q?uaggSzQ6xAmDjF1OPoOO91PbCNO2N34aHMZdXFyLaCOJYR6246jVjRE6hxpn?=
 =?us-ascii?Q?0gl0vNISthQLMla0qRk6SOPSmfxzLjMou7u8FxJmZ4BhxGzsly3WJR5r90pT?=
 =?us-ascii?Q?wSXNLL/yOigmJEqZXv6EaNVwW0IHU7khJONm8yw39KEdoOkXNUxlKEGYI9Y8?=
 =?us-ascii?Q?Gy/izyPcCJKQ05LCsrlJ7xiX6lQTEEebJB+iD7mO5usytvUTetQwPP6mOJUD?=
 =?us-ascii?Q?txbowGMKgT7is3+Wy0PEwLqLOWIyyagOzRIzM7mQ2/Crzlwt/W09wIIlvJ+I?=
 =?us-ascii?Q?ZLXhHx31+zB+NqX5P7sF1/+6cnMFk/h/Fa8rtGQWuRmnPnfX+yzRJ1+VgByS?=
 =?us-ascii?Q?oKapLdUUUp8Tr4XBs6JhFpEVOmuY+0rYZGnOrIQfX9xO3/hFTnly4+k+Mjwt?=
 =?us-ascii?Q?0Z71LwhU8onGrFoFi1FUvLOAFtMvC6jFUPKgY4GrN8yHLCCDmgk84rBkefaY?=
 =?us-ascii?Q?3ZMUDB5yb9ePdoG144ss1HqQ5tLpzihjTl1PCbVlZEDffOKbEqAv+le+svRQ?=
 =?us-ascii?Q?g70F575S4LplGyV7CYKY5N6/FoQSuJGnGs7iPdN46oNmE1SbIeV8ysMhknOY?=
 =?us-ascii?Q?Nw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2ACE42A25770B0478D7EBFC85A5E40C2@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: wp5zx6LXFi1V+hF87HYy0WKfJK82xqtgOqMdPxa/SAH/n9WMOBScGO4S8W+I+fOIdq4QeMIiKL/i7xrud2kxIpLc4NPp1BiS2rl2pS7mKlLh2LOejoxFMo4+KtC/xct+t+LSfcMJX+PMYqDMkBwX73zjhj7/lIF+Sj01uVnTSDK3+StmyOv+WY6kMc5V5JftwiO4VMjYT7EOrFRvEdZgLdjDu8K3slERN3OlqbLBucZu/2wEIbWwriKtbmnmEFfSWEEPIF2CB6z8P6vDiA+d8Bb3abLBgcQ7cJHInWw1obzOZPxciAvp/2FX658vaO2TZ13kM7LUyUkLRD3s/JeQlQ9Y0iV2jisrhhoF7eIQB0JVm9kjoSAq1DJ6WYdrwuYC5BiyetXDBX+vai7/dUxw2qfiftdCehEAvfM/fgq+5nJcfgxgJwFqUhbCQFHNnns9Zcfxd/BoiZEKfjgjmuy2BOEIyVHuAmaq7u4K4ewqK8VtDT1Cxkfq7av/bRymiec+HoJi68Mxy0+NkMQFGnt1LppQvD9EJQgPfj1PXOjC8hMgTXpRdvVqqblDTNKCgYx+dT/7DUSzoBGqniflhae8virxic1vCwnIQ0rwx6ku4j/qFsOO/wmerfydgZdOWDk/19Tpgos5iGZRnPvjvb7Msy+zQrAMtDU8r+/snRnMDKS7RAbKHHJK+6MhV3R32ObJTd2iTRtxvzvAQ25QXL+slSt0fS1ngyknYSSpGhPxt7z8cPiBZi9Pl68AxitwM8FjjIfSdlkYb+gN9nPFpBKGcjyEoH67/ircvktdIqX51CpPbRtVQ/Zp3L8bc1TntuQP
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d09c358e-e2cf-42e5-7222-08db2bc89b7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2023 18:01:20.5044
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tlFt3NTSMXH7fMZ44sin9YQZ7/YBoFCYIMJyFefA9pignOWXEfly9wzcPvFUF8/3YwrIioJJPprxj+t36ZnrPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4750
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_21,2023-03-23_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 suspectscore=0
 phishscore=0 mlxlogscore=767 adultscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303230130
X-Proofpoint-ORIG-GUID: 4HI818kdTKhdjc0c52wu-cii-l5iIDL8
X-Proofpoint-GUID: 4HI818kdTKhdjc0c52wu-cii-l5iIDL8
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 23, 2023, at 1:57 PM, Steve Dickson <steved@redhat.com> wrote:
>=20
>=20
>=20
> On 3/21/23 7:52 AM, Jeff Layton wrote:
>> On Mon, 2023-03-20 at 10:35 -0400, Chuck Lever wrote:
>>> Hi Steve-
>>>=20
>>> This is server-side support for RPC-with-TLS, to accompany similar
>>> support in the Linux NFS client. This implementation can support
>>> both the opportunistic use of transport layer security (it will be
>>> used if the client cares to) and the required use of transport
>>> layer security (the server requires the client to use it to access
>>> a particular export).
>>>=20
>>> Without any other user space componentry, this implementation will
>>> be able to handle clients that request the use of RPC-with-TLS. To
>>> support security policies that restrict access to exports based on
>>> the client's use of TLS, modifications to exportfs and mountd are
>>> needed. These can be found here:
>>>=20
>>> git://git.linux-nfs.org/projects/cel/nfs-utils.git
>>>=20
>>> They include an update to exports(5) explaining how to use the new
>>> "xprtsec=3D" export option.
>>>=20
>>> The kernel patches, along with the the handshake upcall, are carried
>>> in the topic-rpc-with-tls-upcall branch available from:
>>>=20
>>> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git
>>>=20
>>> This was posted under separate cover.
>>>=20
>>> ---
>>>=20
>>> Chuck Lever (4):
>>>       libexports: Fix whitespace damage in support/nfs/exports.c
>>>       exports: Add an xprtsec=3D export option
>>>       exportfs: Push xprtsec settings to the kernel
>>>       exports.man: Add description of xprtsec=3D to exports(5)
>>>=20
>>>=20
>>>  support/export/cache.c       |  15 ++++++
>>>  support/include/nfs/export.h |   6 +++
>>>  support/include/nfslib.h     |  14 +++++
>>>  support/nfs/exports.c        | 100 ++++++++++++++++++++++++++++++++---
>>>  utils/exportfs/exportfs.c    |   1 +
>>>  utils/exportfs/exports.man   |  45 +++++++++++++++-
>>>  6 files changed, 172 insertions(+), 9 deletions(-)
>>>=20
>> Nice work, Chuck! This all looks pretty straightforward. I have a
>> (minor) concern about potentially blocking nfsd threads for up to 20s in
>> a handshake, but this seems like a good place to start.
> Yes! But Will here be a V2 with the suggested changes?

I've done the suggested updates in my private tree already, so I can post a=
 refresh soon.


> It would be good to get a new release with these patches
> in before the upcoming Bakeathon.

The concept and operation of xprtsec=3D is pretty new... would there be a p=
roblem if all this were to change significantly after community review?

--
Chuck Lever


