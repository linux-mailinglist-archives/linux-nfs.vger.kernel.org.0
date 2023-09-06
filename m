Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7125793DE3
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Sep 2023 15:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236881AbjIFNl2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 6 Sep 2023 09:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbjIFNl2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 6 Sep 2023 09:41:28 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A554CCF1
        for <linux-nfs@vger.kernel.org>; Wed,  6 Sep 2023 06:41:23 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 386DW8Lt029108;
        Wed, 6 Sep 2023 13:41:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=bOrhGNZlBhiVrKKzW/fcp9nfcPj/bFEfnxswSaui2Fs=;
 b=I18+Gvou31g69QPvFHwjZYzjzQwhursf6pbdH956EMafvtJEPpGA9wLg0WpMBiLbTU8a
 MMXGo+6mRuaHP7arywF+QLmtBvL+PjJ4xeOB/1aQcpIe/ziFBdBFsY9oIF7JSXwPCySL
 KQBtv6tkpXb0CX/eF5rycS5AEtUCpuVPRN+2mefOSTniGklTWY86mXDTvicMiUa58clG
 KrE7uyjbBX20etScKmHPm58hSb14fEL+TYKJEpXm8t70vtaPC9VtVhEwpbA2hP2wOvg8
 HTKdgRyGQ9H5nmOzdOReXw9PnaA3yfB9B8SnpJ9o4ier2zxrzZoU/NccmjGGA7EtyWBy qg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sxt75r2fx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Sep 2023 13:41:01 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 386DRMCN028459;
        Wed, 6 Sep 2023 13:41:00 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3suug68g49-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Sep 2023 13:41:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UUlmOZODM1OqQjEIyNG281YQ4oJpqKBdkXD4GO1RMkmVX0Tc5YeuLTmPQHd7uOZFCgLy4ISz5ZuISYdNlMt7+xqFpN/ntE6Ksi8TczvIuHeGSTcVnWZV4vtzs7ZEfqAdyUiDp6m8cpGxwz1+Bsiv+iqkbgqjSd9/aCAT4FLPcHJB4owwNcDbFMFlMINHb4v2EDhNg4iw8R+n+Eh8PJwz0jrvBYXb2sTt+x3pxzQm5mnuj9q/s/GJ4Sq79oCLK7e125Ho3Bt149DCWsSRkCBekDRZVD53FkzfJrtfN+xlfNpnd3MbOdB+0lKayEzFa/XV34dwKoS0R3TD9IpF7Ox3pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bOrhGNZlBhiVrKKzW/fcp9nfcPj/bFEfnxswSaui2Fs=;
 b=YU84BAt8z5jT2OYnvEXMtyvWtHPJF5LTzhtt87yOvITds1hUtSNmZGGjcqUvuDknDSfYhtwAkbCtUc0VA4Lzrsw1VMuhkJyXU1kAWp8JLwi2onXpJGXwOmCYvYyZqjdqQryHzQt+mytg9wUNSZ+nQFjW447grILHUdw2RWD9d8jSOLKiuP0YrkMy/5Z+yNI4LztTsh2y15da1++0K02D7OgOD+xjuxId4XtJbF4pTyuIn3wEPjq5es/xNpRmihw5Uq9DAOZTTkQU911hsqcwydUTNFfIWcPr4k82xBCeXMXNeUV3oA+rOpf/u6D6HOiAmaLW+GmTPufuMf5k26HS8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bOrhGNZlBhiVrKKzW/fcp9nfcPj/bFEfnxswSaui2Fs=;
 b=g+/l93B9yTEBihnKwlpADZmmhICylXk1H/uLt/bcGAo4YWLoXwe9g84gr3oJT6Q0V3MgzGyAYj1+WEBVGlU0RjtC3NpzQSagPC3Vp1dl5nQdKVmBwWPLJz2ULQB2NapchPX3W2Q8bbu1bagT9v5Fbv/lKJeygYbHkM2fmlPGzHY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB4421.namprd10.prod.outlook.com (2603:10b6:510:33::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Wed, 6 Sep
 2023 13:40:58 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6745.034; Wed, 6 Sep 2023
 13:40:58 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     "trondmy@kernel.org" <trondmy@kernel.org>
CC:     Anna Schumaker <anna.schumaker@netapp.com>,
        Russell Cattelan <cattelan@thebarn.com>,
        Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] Revert "SUNRPC: Fail faster on bad verifier"
Thread-Topic: [PATCH] Revert "SUNRPC: Fail faster on bad verifier"
Thread-Index: AQHZ4F7ccnSO24xLIUyt1pMDrzj157ANzr2A
Date:   Wed, 6 Sep 2023 13:40:58 +0000
Message-ID: <2854B02F-61E7-4AD0-BF7C-0DC132834416@oracle.com>
References: <20230906010328.54634-1-trondmy@kernel.org>
In-Reply-To: <20230906010328.54634-1-trondmy@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH0PR10MB4421:EE_
x-ms-office365-filtering-correlation-id: 7717aaec-d167-4079-6e82-08dbaedee6e8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6Y5eTDOCzdQX+CxOuFQOQOgh1tCXnu5lATh7NE1u66ppW8WU/wIomloHDLueK3QaD0SayIUBLSTvtaGhjFF2AXEznysUIq7ip3rMi+RqtqAilkt438+qLl25fehW9ojXVvmiTjTOXfofK5mXMN9OvcegIsZGp5XYw2r7r0aN4ZMVBjpcLNoragjFrKsFnxwo7haRWj5ddjRVTXTAknmiFlAE9qIr/NjGI9oRdxDhL/osxyb+rzyK+D72Hk6xNhLy5I3PLRe+JtEFyxvvT7cAN6P/ld0jTUfdI7ZM06545i2IwMAU52erQyyIuKEyLaSFwWl/pEaZY3I1nBwR4l1pifrdQAgr/0MIY5qVO3LzaOUTCzHNTH7fAL4d1PtCYeibGxuFVvgReO24pExgSyBzHnQ5N+RRFW4/zWj6JZkzjjTK6b7JVzqSvrQ7wjXhm8Lchh3Zh/O7RNyVLHAkqKwlDB/bX4Et8Z6O275iFhvnCNUFNhZseuGBLC1BlbPCDtvjcwuUGpI5x4AOiO9cN4ZKka2sK3v+AnzItpbXxwAwbou9OFZL7uX7vb076/v8ittISrUQaBFf5lyDDV/Oz9C/YCVCvlrvdb5TMDwlOFrMg1puK3Ro1DK6PTeVEhFsuv5WMG7FAm/9mkKaYyP+0yjUiA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(39860400002)(396003)(346002)(451199024)(186009)(1800799009)(76116006)(66446008)(66946007)(86362001)(54906003)(6916009)(41300700001)(91956017)(316002)(64756008)(66476007)(66556008)(6512007)(2616005)(966005)(26005)(33656002)(53546011)(6506007)(6486002)(4326008)(8936002)(5660300002)(8676002)(71200400001)(36756003)(38100700002)(38070700005)(478600001)(83380400001)(2906002)(122000001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bNWIZXuD6VfsfCnDIkRjekvVSWul5fpsnE+MghEBQwEh0LaSdjI8mKwv6xTz?=
 =?us-ascii?Q?3JYihPtqzyHZSgTsd6D+1dgziAMUE7j1fK51paBs0CpPbNwoiAq82bHvhCRG?=
 =?us-ascii?Q?4OK++b2sSWzBlFLhS76oq6S/P/5wfaPLV8zLCrLMXUcIs1TaJvl7h15qydrW?=
 =?us-ascii?Q?KtZJWOIug1HCiXMd4sXxiM5DufKxx3ogumrSiS5wpGFhHkFRjR2t1HmDzQE/?=
 =?us-ascii?Q?pmjLrqnJeixmWUrJmy/umOG2CpyqaGR4A0JneBfkh9GS7nG3JJSIW9KYdOJn?=
 =?us-ascii?Q?km8CVZU6euFJZcCwttelCfd93unsZeruODwalrXVdW2wvlkvRKnWAZvlQoRS?=
 =?us-ascii?Q?DjpupVLYX6qUih/J5sYEVXUKI65EJO9KUFTcBZueW+AlAm8mNagCmhQi2Mpy?=
 =?us-ascii?Q?URQMHOa/E8/qIByXB670fRzzPzJZONkA4kTbqZKoQIFifi3G3hwQ60+15YXl?=
 =?us-ascii?Q?cTvR6jABaTMG6tH9SJ5La1Z/ts9v03fdjFF5KffnMqJW8VcjnoraeVzZ5PIb?=
 =?us-ascii?Q?g2qSblMOZlqYQPWBLMNZ27tiE4noK+6d0ATjTkzaCFXT8qra0YRYfYGQ7xUf?=
 =?us-ascii?Q?Vi2f6bXLlXkld1xipJK8XZjsW0X4OxQKpTzOnAu5/TTrJ3r+nFwS6Fnrq7A4?=
 =?us-ascii?Q?FmIbSpQONrQEK7WHFtNZyedA5U8e8cJKd0o7ePMKbzl1qfj9kNth/mRhJunZ?=
 =?us-ascii?Q?aP3XfdcO4POgFTryIpAOd5i6EYcKsFQxu2IzExpjE+sBQyVgsbxx3+K96gY/?=
 =?us-ascii?Q?IvmZfuzdaqch1OtAS7WHg/ULq9gQAMYGukg/kQ8V2XAu64/5fIKfONruKA8p?=
 =?us-ascii?Q?b4nCwIo4Aqu9JE2AdL6Hff1J9to95PLsfnmJD/FMXW8dJ4TBM5rUk18xFyLd?=
 =?us-ascii?Q?lgrx3SpIbewcbTIeMccmkrKPrS7ILWvtr0Ul7cBZ4nKZMU2Crk1kTRrXzXi+?=
 =?us-ascii?Q?+pMFPJyS1KlvsptEb6qEJeE07I4LS5Xp8F/Qn/T3FjMLqFubUn+7eYkJ+vQ/?=
 =?us-ascii?Q?M+qb/9o7xeI5xF8waBj/XqZuIbgQSQaA6m7Xm8kSm9p+foAZXxW00SpCB/uf?=
 =?us-ascii?Q?poREWOUHqvBcxp59I6j/zvSlobS1NVOnkmJSmlVXRrkxtAqOss7MReecRW2w?=
 =?us-ascii?Q?zwZ7MrvGHmnTndjoyxojqKt4KXGt/kByx4hOFKYScoA6U2jtfWXHs6t+ndPJ?=
 =?us-ascii?Q?fr5+SWuwlsYesZ1wtXRHdpIpbLExiB9En4XgxLXpNntWnQb371TEPJrSoZQY?=
 =?us-ascii?Q?hCeVePJPTcfj0LnaeAQ58fyQmUAQlW49QUvUtYcH+sFqcNGRFIjYN+E/Sz6K?=
 =?us-ascii?Q?PUMZsTVqObjzz7IIWNChJDFClBV7fhOjB+Zoh+MxFyU2z2dbLBp74uuz57yX?=
 =?us-ascii?Q?9k2Yi/BbjrDknjNuDXtChyctSgd9VodkjahEwUjjDlCRa05nQsV1752yvGWk?=
 =?us-ascii?Q?jn01qzCR8y+sCADiYnfruTvuhRNY9kCqzLU7dZSwiUePPSd+VAH0AyT7BpCe?=
 =?us-ascii?Q?nCeSlHJnFEo6OPLSkPzOrbQMtuVKzpOFlpXHA2CWbRST2gnxECxPXCPOBruj?=
 =?us-ascii?Q?PJGYAPYqaJkqR99oR2uV1wluWplWclNnUjjMav7XWgxQajXpoJ1roT06cGQr?=
 =?us-ascii?Q?5g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3AD35BE47BC85740B18B1309933E5907@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: c2GNj5kDGM/wwBxGH5baDnWkFDxPJ8J7k0XR9mh3ErNp5ful0pFJZJPp/MKzEY39IriJfvUMhddosB6r8gMvfv3RtOziLrjVpVuEJYJ8SLN1ZshIJlA0hA3CH+uRa7K9MXXhDUl9Yc7SGjHp+PDBzz5HcVvgMgqWmESNCeHDT+nrUHcvFS3C6sZp/c9pZvNp6NY7aF99ZofY/INnvoW6cVlVIE4CJfIUbPydCO7ixJMwInt2jl/16bqo4QyUt3CKWMllKkJsns37rDkz0G3hWsDbJHoLmkGoQ1Z5HT5LUREthOG+b4FktOOyAOdrg3Ku4J6oA7KRu0vv2yx3EkBvISgHbMd+t1Xs40knjH4Rsupk4vy7zt8A3W4XHEKBmjq0E8IUpNGklrInWO6NVNpGvlj5T9oBlGB6d6Iun7MlvxV6Q5OIIuBChzydoq7c4AhxS5RkO+jnRlGEHACyr0RpcATVBixVMhfacZhijaa1DtBZX/fEgkLz1cOZJVF+7aVT9l+CKoFHtsINvceMp8o+uO5RtmirGtQUAea8WvHNdaw4tzdteZWP8HwHy+3HNH1rR+Cax3VDuTY4+8LUAC0ZeNpPN5ItEog1aW3uI/5x0YMtGvLyfSCIXVY2P2gBZmov8xJV1Qiqtq2TZaH4eTdZBhGzJidukC0Pdgy6BOEliBbd3rBAi1poh5v/K1QSzKwcpWX4I7ErHezICKCb5mWCcuKoI+byyu8FLx51I1ffhFliAGXe0ligEWuHdWxFZcnaW9KzRyquTU1P5aqylzhCKu972nDL2fcglElnN2NsXgUZdgGeCJY2X/C7vvRKZD96ZGEPStUr97f0OQDB/YSDXZa1mEAfOJNvKPv7hpEiqwU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7717aaec-d167-4079-6e82-08dbaedee6e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2023 13:40:58.2419
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7Eak5l9lH0dg/8QE4MyqDie4yqySjyhoHYmXLfODwi3kHNO8ebh92QbWB+8BjqA1Q5jK+HVxIX/D45Ij6jGrgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4421
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-06_06,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 phishscore=0 bulkscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309060118
X-Proofpoint-GUID: maDbqiNxlmDr6nnSAYUTIIL7wOv58dIL
X-Proofpoint-ORIG-GUID: maDbqiNxlmDr6nnSAYUTIIL7wOv58dIL
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 5, 2023, at 9:03 PM, trondmy@kernel.org wrote:
>=20
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>=20
> This reverts commit 0701214cd6e66585a999b132eb72ae0489beb724.
>=20
> The premise of this commit was incorrect. There are exactly 2 cases
> where rpcauth_checkverf() will return an error:
>=20
> 1) If there was an XDR decode problem (i.e. garbage data).
> 2) If gss_validate() had a problem verifying the RPCSEC_GSS MIC.

There's also the AUTH_TLS probe:

https://www.rfc-editor.org/rfc/rfc9289.html#section-4.1-7

That was the purpose of 0701214cd6e6.

Reverting this commit is likely to cause problems when our
TLS-capable client interacts with a server that knows
nothing of AUTH_TLS.


> In the second case, there are again 2 subcases:
>=20
> a) The GSS context expires, in which case gss_validate() will force a
>   new context negotiation on retry by invalidating the cred.
> b) The sequence number check failed because an RPC call timed out, and
>   the client retransmitted the request using a new sequence number,
>   as required by RFC2203.
>=20
> In neither subcase is this a fatal error.
>=20
> Reported-by: Russell Cattelan <cattelan@thebarn.com>
> Fixes: 0701214cd6e6 ("SUNRPC: Fail faster on bad verifier")
> Cc: stable@vger.kernel.org
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
> net/sunrpc/clnt.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
> index 12c46e129db8..5a7de7e55548 100644
> --- a/net/sunrpc/clnt.c
> +++ b/net/sunrpc/clnt.c
> @@ -2724,7 +2724,7 @@ rpc_decode_header(struct rpc_task *task, struct xdr=
_stream *xdr)
>=20
> out_verifier:
> trace_rpc_bad_verifier(task);
> - goto out_err;
> + goto out_garbage;
>=20
> out_msg_denied:
> error =3D -EACCES;
> --=20
> 2.41.0
>=20

--
Chuck Lever


