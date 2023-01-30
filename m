Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 596AB681861
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Jan 2023 19:10:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbjA3SK0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Jan 2023 13:10:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234005AbjA3SKW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 30 Jan 2023 13:10:22 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 447422131
        for <linux-nfs@vger.kernel.org>; Mon, 30 Jan 2023 10:10:18 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30UHXktq012055;
        Mon, 30 Jan 2023 18:10:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=kPiKI+XrkV7mxqCkKE2qK7hPiAG3dGLjCCF52tt1Jas=;
 b=ZjvSXhVafPF09DkdpGE36ICjvmi1jGIqrRoLHjB2UqC2xGuhzs6bdXkQuKDWummq/T7G
 G7ck+dIjCiiDQ7A8NnOK08xqTc4ATPai2zsZ5D+fyNlmg+GQL3GpAKezePRcMv/1uzVt
 JXRBgqBYAdlGcFsKh4W5D/ERvVnLYbpwEr5uDj7ivjk/F6X0/wbwMBTL22S38K73wak+
 x0/Z1/kxBsFPPIffNz0QsoyjQpDRZAMBm6O4F4B8cy2Qu+b3Ed9KOjWVeGt+Z2QDCqUI
 x0wxHyZhf7k3TYXMf4DmaqqTHlxoEwbmJkzB2K0ReZUvTwPTvYUzzSGNOczpz3mBvEWI yQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ncvmhkkq3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Jan 2023 18:10:07 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30UI8SDo039524;
        Mon, 30 Jan 2023 18:10:06 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3nct5b8kt6-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Jan 2023 18:10:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VBgrT11wgcpzhcoh7eqjiRVIZg5kZYDBz7ph3OZfxNFjBqwVi5rjF93y3wHKxCtWwmCQV1HiesFUXC5dNasexFkuRFEcYS8LDP1gkJVs5RLlBtZs5kRK5SMaMMtohkjlXdPnpCwefBqsnWGsFf4B8bjax2TZeykBDKJyO5R4+/NLOcdumQquxw2jZxJOXCHQl/ezRiNmn7kcdfOSVCFlphySt63hiJLeEGnhjhGKlmbMWPjVWzzy6qdq8LG4rEUObUrIfBOD3zQA9gXO9vRvGPBWAVIvEonbB5JJ6uqEQdypNtLCERWnxZOfAGtiVE3pCwqgP4jgWKjl9kybeHNS1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kPiKI+XrkV7mxqCkKE2qK7hPiAG3dGLjCCF52tt1Jas=;
 b=TDnSLwGAS7BaCg3/5rsA7SdN3Kkce6vyfytj0yLnG8GCP4SJsJ4QuAYwbVNjh+yr5i31GYJQjAST61LUTmpzFPmhjISt53ubEGUUB0276/9vR/QRdSSo9kxCuZhVEGzd9w+zKQXhKT5u/1kuEVAXjA2fqs2OjLUt4z/bs2+FogHLi1xaE7WgNhC1yq1Z7otW1k62nmxM6UQUmBAJv6pH9pgdjpsaRiW06pFNmx2vtEwSoasUA47OSODTm5j46ytX/Ez0XL1nVlool0GvAUyrTRtiOhhDjCt4Tbxh1uXg8/yTNhnYveWKuATkpukRM6S+MU9NNWwI6Zonx7vBBT8AoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kPiKI+XrkV7mxqCkKE2qK7hPiAG3dGLjCCF52tt1Jas=;
 b=w33UoB9hM0Kfl/8U+Q7qCZvFMmGwB/8adxFXNHiU6NlGvjCO8ckQC1CLLs+ATW8KjWSgIAZTMw9l9ZF+7IK8UZGjkEX7JqlOW9oX3H0TzGnGtVUDmx7BDmR5LAV4NOnVhincmKjzJUlu3CkYkfctXMiTXXsyqnjcxszOjmTwhCE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB5675.namprd10.prod.outlook.com (2603:10b6:510:127::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.20; Mon, 30 Jan
 2023 18:10:02 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::96a2:2d53:eb8c:b5ed]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::96a2:2d53:eb8c:b5ed%6]) with mapi id 15.20.6064.021; Mon, 30 Jan 2023
 18:10:02 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@redhat.com>
CC:     Chuck Lever <cel@kernel.org>, Neil Brown <neilb@suse.de>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH RFC] NFSD: Convert filecache to rhltable
Thread-Topic: [PATCH RFC] NFSD: Convert filecache to rhltable
Thread-Index: AQHZIRZdLVddJev/70WpowDSuI8Nnq6sjLEAgAAFSwCAABIAAIAKxfqA
Date:   Mon, 30 Jan 2023 18:10:02 +0000
Message-ID: <8F6C9C15-F7B1-40AC-8DC1-3D2AE834B414@oracle.com>
References: <167293053710.2587608.15966496749656663379.stgit@manet.1015granger.net>
 <d65c6afc3f1dfd29e7cc46e1bd00b458c3f0d2f8.camel@redhat.com>
 <FB44286A-6F2C-4E41-BF22-E0FB8F2F524D@oracle.com>
 <15afb0215ec76ffb54854eda8916efa4b5b3f6c3.camel@redhat.com>
In-Reply-To: <15afb0215ec76ffb54854eda8916efa4b5b3f6c3.camel@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH7PR10MB5675:EE_
x-ms-office365-filtering-correlation-id: 446cef7f-338f-44fc-e6c4-08db02ed354c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dKBkr9YxdSysPB3nH7MyfG8cOfY1pS3nNnTpbn/R6xutHN91YBZ1S+MNJm12x5RV4lhxD4T8kzW2dQvC/x49MFkAiCPgLQhksGD3t69zCKTBiQqZLuBl2uMQDl/PLA6G1hbJ5k1J0Qr/ntwVyb8QlytouMBeUzA04DeXIPiAjknOGD4MMSRvpyduAsK+dt9p1xgQlKb8CsNnjOvG8AYzx5oqGme4PgOiydaF3qaSpv9D4A6nY9ovfH6Xjt9HBIZlbmHh8bmV3b62z+4Ao8KtvSjTWA4wdva8CUDAADxx4iLyrEnIWVk1TrnNBkegYdKIyB3OzgKwB8hZcc2oG2JgLa23Bp37e/eyVnqooQuF1VaA2uNKKPOAmFFakvnJf/9umc/eqKm/t5uMtRlep50y0LZbLDSTOp8J0QoHZZ97PhXfwlBQgpToAWcL+jKfbKjU5a6JVHvM/tuX4Cvts4hmAEFFUqa2k1h/bMeTk+mcr2rWBOLJWg4PzUigI94uWLCllw25XMxCnGHyWDpbmgOV2pmTUZtz+cso2/Gw378zuhOZ/lmcRVXmH6k00IdAaTjDDcLEdwqlXyqROMuUiSVCO5eBCP9qB5wjEPvOmZslGoUucOaO+XIrDBkuo0wHZH3ntjHUV4JyMFloy/hZOiPQDqHyprXhfXL7CpCYbV3iJcf2RD/rwE2zuV6YL2V/U0VJGdMDD/T58VzN71CNZOVWv7+VXdlN+/lEEg7eGIpfPKE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(366004)(136003)(396003)(39860400002)(346002)(451199018)(316002)(54906003)(66946007)(83380400001)(36756003)(5660300002)(2906002)(30864003)(8936002)(38070700005)(86362001)(33656002)(38100700002)(122000001)(91956017)(76116006)(66556008)(6916009)(66476007)(66446008)(8676002)(4326008)(64756008)(41300700001)(71200400001)(478600001)(6486002)(2616005)(26005)(186003)(6512007)(53546011)(6506007)(45980500001)(579004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PoZlF1tVSHXWg4l4Zj5Y7O0RXWKL1DpgpUMjKy1sBdkhf2b5nOD9eA9sDmT+?=
 =?us-ascii?Q?XRMnXcmOAAVuI4iTMzvuzxPoHzNb9rwFmVMFkZ2XQj7V+KSpEaqaD80Eo2zr?=
 =?us-ascii?Q?zXnJ+ixGarClBOFiMInupNhtlDHCAYIHCXIlsT/YljQ0wQEaryaUGp8anon5?=
 =?us-ascii?Q?IXZCLbg0iE+bJx0Q094MSaNz2arsTrdoTz5ZtK32361plEcojsNh2MJEgNuP?=
 =?us-ascii?Q?9DXgxPX1oENH4QDMB4ScgzdL2ltQuXpVzX+xLKGU4SKdWwDWzUUbwKd505SH?=
 =?us-ascii?Q?KhVWYBwTGhxvaSxeEKGzwJHHiQ/792ICpQPUUEYoONPKbasBLqOSHvEKp+jn?=
 =?us-ascii?Q?qhUUB2msIDl9vtuJKGWfoKxRcbBdfRps3FeWbJJpQl10MDeXWrwiQaGNSk4s?=
 =?us-ascii?Q?Tenmoxv6sJ977NUMuB8C31UoD0gAvsIhEIngLsTREwZV/LlidQhtSyOUjarf?=
 =?us-ascii?Q?WXvZ4YK4UaOvH7sFaZ9ULAOvQIOK5mQEyxEs0L3YsY4fZSjAc0ItIOXBhpOX?=
 =?us-ascii?Q?ZyFovEh4xUd4Hn5IGWRLmXgcVGjrzGd+zVaj2MKjboSDAAE03QMssYTl8a3g?=
 =?us-ascii?Q?ICAnfMOcO0AzZ4YkMvYkevL6pzUDrWixwvdTw8CpW7RGYPH8SsoZcsoOQQLo?=
 =?us-ascii?Q?2q1B23TYx6kBCmZ8+oIHd8oHF9qVhDKSZ8v0vOIrm/N2QLGamBSV9A0CwGs8?=
 =?us-ascii?Q?zlGVBkS4DgH6dcUN89Z+o9K2oJ5ViTqjTbajG3BGinJXlwzLsbWo5j4AexM1?=
 =?us-ascii?Q?JNX27QzkmUEbbShsYG8gzByKaW4ADeg2wPDV5mhGR6gJ6ZgxrKsc8ipFje4n?=
 =?us-ascii?Q?ceJgqGp2QFgOXsURhzh7pTJYvvLzHeBJDNU2+s2EpYIPTI2z7x9wTP1/hZDQ?=
 =?us-ascii?Q?bxYJ7Fc94oENj9YKjpSIobdVcpQ173PvWZtzKCSFAqOWwe3bWDOCZPlMgH3+?=
 =?us-ascii?Q?KgJ2xDhFfTW2syWDbcIPiMGG3iqfpXC3T75uMvNC78c8LaL9LeyWl6Yi3aFC?=
 =?us-ascii?Q?+UYWqcK8PUDN9Lze1uKaR0KSKUt8dQsBXAIb8YlKQOUkpabbg1rrMjNraxcg?=
 =?us-ascii?Q?Y8gEjmCMFTwd1uy+5Gbgn03Ed8RinnxPLyrmlPLqxBfljUjSPG6FMjeHEsJT?=
 =?us-ascii?Q?RFOiXwJWtrBPk4ZBVDRXv8fy3sTk6OXGz1HnnWdgz9SMloNGc8FibdRfffft?=
 =?us-ascii?Q?06WsZhFEGX9EA+Awi/YGjaTttJl3qJa3hvPh2eafYk8Y409GHloqGla5KN9c?=
 =?us-ascii?Q?swSb4e9XwRb7XaakO3SHImJLQ3MwYS3VLZmKcXJJcfeHsh6u6rk5dOdof6ED?=
 =?us-ascii?Q?vXg3i4tu0D0smI1Im515fcZpMi1LDYzM6AVJGmXHxEjVTaCYbomYOb8KxJep?=
 =?us-ascii?Q?Zu0eSKcbve6ijHw4F57ig4aF98BWqWJf8ByYUSKuwqFMebtIKVQqFG2eQI5W?=
 =?us-ascii?Q?ktgba2Ek9wf8/w+UmRKRz3wOrisOnpZ3ux1240aQJD2+iOKuhyOGuDp6GqcP?=
 =?us-ascii?Q?p+sdgbMwkVfdT5QwkT9Vz8lzT7VmDIcUOVIz0e6hqaV/y3BAbvfao6CLApl8?=
 =?us-ascii?Q?vyN9SRzs4niApqZZFsKFMtpz/WkUEw5jqY3zhptwWgspWIb321Skfid68yno?=
 =?us-ascii?Q?hw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <344255B3AE1A7B43997EB4940BDF3DE9@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: fAQA4ci7J38GcTvfBMdgs2Utxi+fyUGOUJ1jN0rxMmQO9ByigdFUSENE/ZV7aXR+MEZ8XCBybsgSCxAkdrOWPAbj/Q+uFzYYps5LSOzCu/1W1wUMqz1AV86ctJShcwUjgBS1zmUcyz+vkrx+chynBpn0chWah1CQXiSqnfSV3/Hl6Q3mpbgyVkuQHBUzWoQ6aORNW4Zv38yjSKKi34uz2oFmZ4/iVFtm9uaPhxk4sGLPDGqhflllarPPuGJWDfwygoh1zdHUr/STa8zysFHW4ZEGFvATvyN+z7H9OMPdp1MfaaErgFLPA6z4YZ4f9iwr6UkNwV/EJNIMjCq3s6TPE9aTQsfWNoB8SpQ2BwktEuVtDPUHSLmPs5cToSSNTnmPi3bYib7+/pa2c1JA+12zG/U3P1UfX8Gltfwv0IKxNhKJwxv8Qtqhv/yfuYJonS+GZ3fPZ+E2xRpottDhHQtdUmHKLgdfUIgRFBj8XgG7FTu2M+RfZ0umGES2GY1gnVXdYZexFOwrQOFyptHh0iffu74G/p0sDCvap+013FsrM0tgJIo2UOaOPS4ZSWEbA2yFss77dFI8r9ZSoiMGxWL0VRWgm0cvJf2W2wHVCs3CE5zHC0SXh9OevGnSgqVuF6Mp2+fs0111/ZgIH9t5hw64tmiFN28F3tjpnrHfIEmcc/X9AIPvChD3PjgrCJm4l4vwkGMgoodGcyURdEtVQeG6zvT47Zuln2U04vDFFiNBmmjACUcXm+5hzJUbatBnr3fIqMxo7x2Bps8lXcOvrBHWlVcY7kWRxaJhCH+FnFR0QjjNP+mCKiNICOg1gqnFzD8GqtI+oQvoYggP3TW9y4JI4Q==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 446cef7f-338f-44fc-e6c4-08db02ed354c
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2023 18:10:02.7325
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r5NVt0cutcpsjQ+BO6HBnxCZYXUiTRqA0rPmMQ3r32m0kSAiKiGmhpA9XEt31FIY4Jx6RtuAOsXZFC456dWy0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5675
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-30_17,2023-01-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301300175
X-Proofpoint-ORIG-GUID: 6x2DtJ-2UZYO991r_YCFoA9LN-d4KrWA
X-Proofpoint-GUID: 6x2DtJ-2UZYO991r_YCFoA9LN-d4KrWA
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 23, 2023, at 4:38 PM, Jeff Layton <jlayton@redhat.com> wrote:
>=20
> On Mon, 2023-01-23 at 20:34 +0000, Chuck Lever III wrote:
>>=20
>>> On Jan 23, 2023, at 3:15 PM, Jeff Layton <jlayton@redhat.com> wrote:
>>>=20
>>> On Thu, 2023-01-05 at 09:58 -0500, Chuck Lever wrote:
>>>> From: Chuck Lever <chuck.lever@oracle.com>
>>>>=20
>>>> While we were converting the nfs4_file hashtable to use the kernel's
>>>> resizable hashtable data structure, Neil Brown observed that the
>>>> list variant (rhltable) would be better for managing nfsd_file items
>>>> as well. The nfsd_file hash table will contain multiple entries for
>>>> the same inode -- these should be kept together on a list. And, it
>>>> could be possible for exotic or malicious client behavior to cause
>>>> the hash table to resize itself on every insertion.
>>>>=20
>>>> A nice simplification is that rhltable_lookup() can return a list
>>>> that contains only nfsd_file items that match a given inode, which
>>>> enables us to eliminate specialized hash table helper functions and
>>>> use the default functions provided by the rhashtable implementation).
>>>>=20
>>>> Since we are now storing nfsd_file items for the same inode on a
>>>> single list, that effectively reduces the number of hash entries
>>>> that have to be tracked in the hash table. The mininum bucket count
>>>> is therefore lowered.
>>>>=20
>>>> Suggested-by: Neil Brown <neilb@suse.de>
>>>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>>>> ---
>>>> fs/nfsd/filecache.c |  289 +++++++++++++++++++------------------------=
--------
>>>> fs/nfsd/filecache.h |    9 +-
>>>> 2 files changed, 115 insertions(+), 183 deletions(-)
>>>>=20
>>>> Just to note that this work is still in the wings. It would need to
>>>> be rebased on Jeff's recent fixes and clean-ups. I'm reluctant to
>>>> apply this until there is more evidence that the instability in v6.0
>>>> has been duly addressed.
>>>>=20
>>>>=20
>>>> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
>>>> index 45b2c9e3f636..f04e722bb6bc 100644
>>>> --- a/fs/nfsd/filecache.c
>>>> +++ b/fs/nfsd/filecache.c
>>>> @@ -74,70 +74,9 @@ static struct list_lru			nfsd_file_lru;
>>>> static unsigned long			nfsd_file_flags;
>>>> static struct fsnotify_group		*nfsd_file_fsnotify_group;
>>>> static struct delayed_work		nfsd_filecache_laundrette;
>>>> -static struct rhashtable		nfsd_file_rhash_tbl
>>>> +static struct rhltable			nfsd_file_rhltable
>>>> 						____cacheline_aligned_in_smp;
>>>>=20
>>>> -enum nfsd_file_lookup_type {
>>>> -	NFSD_FILE_KEY_INODE,
>>>> -	NFSD_FILE_KEY_FULL,
>>>> -};
>>>> -
>>>> -struct nfsd_file_lookup_key {
>>>> -	struct inode			*inode;
>>>> -	struct net			*net;
>>>> -	const struct cred		*cred;
>>>> -	unsigned char			need;
>>>> -	bool				gc;
>>>> -	enum nfsd_file_lookup_type	type;
>>>> -};
>>>> -
>>>> -/*
>>>> - * The returned hash value is based solely on the address of an in-co=
de
>>>> - * inode, a pointer to a slab-allocated object. The entropy in such a
>>>> - * pointer is concentrated in its middle bits.
>>>> - */
>>>> -static u32 nfsd_file_inode_hash(const struct inode *inode, u32 seed)
>>>> -{
>>>> -	unsigned long ptr =3D (unsigned long)inode;
>>>> -	u32 k;
>>>> -
>>>> -	k =3D ptr >> L1_CACHE_SHIFT;
>>>> -	k &=3D 0x00ffffff;
>>>> -	return jhash2(&k, 1, seed);
>>>> -}
>>>> -
>>>> -/**
>>>> - * nfsd_file_key_hashfn - Compute the hash value of a lookup key
>>>> - * @data: key on which to compute the hash value
>>>> - * @len: rhash table's key_len parameter (unused)
>>>> - * @seed: rhash table's random seed of the day
>>>> - *
>>>> - * Return value:
>>>> - *   Computed 32-bit hash value
>>>> - */
>>>> -static u32 nfsd_file_key_hashfn(const void *data, u32 len, u32 seed)
>>>> -{
>>>> -	const struct nfsd_file_lookup_key *key =3D data;
>>>> -
>>>> -	return nfsd_file_inode_hash(key->inode, seed);
>>>> -}
>>>> -
>>>> -/**
>>>> - * nfsd_file_obj_hashfn - Compute the hash value of an nfsd_file
>>>> - * @data: object on which to compute the hash value
>>>> - * @len: rhash table's key_len parameter (unused)
>>>> - * @seed: rhash table's random seed of the day
>>>> - *
>>>> - * Return value:
>>>> - *   Computed 32-bit hash value
>>>> - */
>>>> -static u32 nfsd_file_obj_hashfn(const void *data, u32 len, u32 seed)
>>>> -{
>>>> -	const struct nfsd_file *nf =3D data;
>>>> -
>>>> -	return nfsd_file_inode_hash(nf->nf_inode, seed);
>>>> -}
>>>> -
>>>> static bool
>>>> nfsd_match_cred(const struct cred *c1, const struct cred *c2)
>>>> {
>>>> @@ -158,53 +97,16 @@ nfsd_match_cred(const struct cred *c1, const stru=
ct cred *c2)
>>>> 	return true;
>>>> }
>>>>=20
>>>> -/**
>>>> - * nfsd_file_obj_cmpfn - Match a cache item against search criteria
>>>> - * @arg: search criteria
>>>> - * @ptr: cache item to check
>>>> - *
>>>> - * Return values:
>>>> - *   %0 - Item matches search criteria
>>>> - *   %1 - Item does not match search criteria
>>>> - */
>>>> -static int nfsd_file_obj_cmpfn(struct rhashtable_compare_arg *arg,
>>>> -			       const void *ptr)
>>>> -{
>>>> -	const struct nfsd_file_lookup_key *key =3D arg->key;
>>>> -	const struct nfsd_file *nf =3D ptr;
>>>> -
>>>> -	switch (key->type) {
>>>> -	case NFSD_FILE_KEY_INODE:
>>>> -		if (nf->nf_inode !=3D key->inode)
>>>> -			return 1;
>>>> -		break;
>>>> -	case NFSD_FILE_KEY_FULL:
>>>> -		if (nf->nf_inode !=3D key->inode)
>>>> -			return 1;
>>>> -		if (nf->nf_may !=3D key->need)
>>>> -			return 1;
>>>> -		if (nf->nf_net !=3D key->net)
>>>> -			return 1;
>>>> -		if (!nfsd_match_cred(nf->nf_cred, key->cred))
>>>> -			return 1;
>>>> -		if (!!test_bit(NFSD_FILE_GC, &nf->nf_flags) !=3D key->gc)
>>>> -			return 1;
>>>> -		if (test_bit(NFSD_FILE_HASHED, &nf->nf_flags) =3D=3D 0)
>>>> -			return 1;
>>>> -		break;
>>>> -	}
>>>> -	return 0;
>>>> -}
>>>> -
>>>> static const struct rhashtable_params nfsd_file_rhash_params =3D {
>>>> 	.key_len		=3D sizeof_field(struct nfsd_file, nf_inode),
>>>> 	.key_offset		=3D offsetof(struct nfsd_file, nf_inode),
>>>> -	.head_offset		=3D offsetof(struct nfsd_file, nf_rhash),
>>>> -	.hashfn			=3D nfsd_file_key_hashfn,
>>>> -	.obj_hashfn		=3D nfsd_file_obj_hashfn,
>>>> -	.obj_cmpfn		=3D nfsd_file_obj_cmpfn,
>>>> -	/* Reduce resizing churn on light workloads */
>>>> -	.min_size		=3D 512,		/* buckets */
>>>> +	.head_offset		=3D offsetof(struct nfsd_file, nf_rlist),
>>>> +
>>>> +	/*
>>>> +	 * Start with a single page hash table to reduce resizing churn
>>>> +	 * on light workloads.
>>>> +	 */
>>>> +	.min_size		=3D 256,
>>>> 	.automatic_shrinking	=3D true,
>>>> };
>>>>=20
>>>> @@ -307,27 +209,27 @@ nfsd_file_mark_find_or_create(struct nfsd_file *=
nf, struct inode *inode)
>>>> }
>>>>=20
>>>> static struct nfsd_file *
>>>> -nfsd_file_alloc(struct nfsd_file_lookup_key *key, unsigned int may)
>>>> +nfsd_file_alloc(struct net *net, struct inode *inode, unsigned char n=
eed,
>>>> +		bool want_gc)
>>>> {
>>>> 	struct nfsd_file *nf;
>>>>=20
>>>> 	nf =3D kmem_cache_alloc(nfsd_file_slab, GFP_KERNEL);
>>>> -	if (nf) {
>>>> -		INIT_LIST_HEAD(&nf->nf_lru);
>>>> -		nf->nf_birthtime =3D ktime_get();
>>>> -		nf->nf_file =3D NULL;
>>>> -		nf->nf_cred =3D get_current_cred();
>>>> -		nf->nf_net =3D key->net;
>>>> -		nf->nf_flags =3D 0;
>>>> -		__set_bit(NFSD_FILE_HASHED, &nf->nf_flags);
>>>> -		__set_bit(NFSD_FILE_PENDING, &nf->nf_flags);
>>>> -		if (key->gc)
>>>> -			__set_bit(NFSD_FILE_GC, &nf->nf_flags);
>>>> -		nf->nf_inode =3D key->inode;
>>>> -		refcount_set(&nf->nf_ref, 1);
>>>> -		nf->nf_may =3D key->need;
>>>> -		nf->nf_mark =3D NULL;
>>>> -	}
>>>> +	if (unlikely(!nf))
>>>> +		return NULL;
>>>> +
>>>> +	INIT_LIST_HEAD(&nf->nf_lru);
>>>> +	nf->nf_birthtime =3D ktime_get();
>>>> +	nf->nf_file =3D NULL;
>>>> +	nf->nf_cred =3D get_current_cred();
>>>> +	nf->nf_net =3D net;
>>>> +	nf->nf_flags =3D want_gc ?
>>>> +		BIT(NFSD_FILE_HASHED) | BIT(NFSD_FILE_PENDING) | BIT(NFSD_FILE_GC) =
:
>>>> +		BIT(NFSD_FILE_HASHED) | BIT(NFSD_FILE_PENDING);
>>>> +	nf->nf_inode =3D inode;
>>>> +	refcount_set(&nf->nf_ref, 1);
>>>> +	nf->nf_may =3D need;
>>>> +	nf->nf_mark =3D NULL;
>>>> 	return nf;
>>>> }
>>>>=20
>>>> @@ -362,8 +264,8 @@ nfsd_file_hash_remove(struct nfsd_file *nf)
>>>>=20
>>>> 	if (nfsd_file_check_write_error(nf))
>>>> 		nfsd_reset_write_verifier(net_generic(nf->nf_net, nfsd_net_id));
>>>> -	rhashtable_remove_fast(&nfsd_file_rhash_tbl, &nf->nf_rhash,
>>>> -			       nfsd_file_rhash_params);
>>>> +	rhltable_remove(&nfsd_file_rhltable, &nf->nf_rlist,
>>>> +			nfsd_file_rhash_params);
>>>> }
>>>>=20
>>>> static bool
>>>> @@ -680,21 +582,19 @@ static struct shrinker	nfsd_file_shrinker =3D {
>>>> static void
>>>> nfsd_file_queue_for_close(struct inode *inode, struct list_head *dispo=
se)
>>>> {
>>>> -	struct nfsd_file_lookup_key key =3D {
>>>> -		.type	=3D NFSD_FILE_KEY_INODE,
>>>> -		.inode	=3D inode,
>>>> -	};
>>>> -	struct nfsd_file *nf;
>>>> -
>>>> 	rcu_read_lock();
>>>> 	do {
>>>> +		struct rhlist_head *list;
>>>> +		struct nfsd_file *nf;
>>>> 		int decrement =3D 1;
>>>>=20
>>>> -		nf =3D rhashtable_lookup(&nfsd_file_rhash_tbl, &key,
>>>> +		list =3D rhltable_lookup(&nfsd_file_rhltable, &inode,
>>>> 				       nfsd_file_rhash_params);
>>>> -		if (!nf)
>>>> +		if (!list)
>>>> 			break;
>>>>=20
>>>=20
>>> Rather than redriving the lookup multiple times in the loop, would it b=
e
>>> better to just search once and then walk the resulting list with
>>> rhl_for_each_entry_rcu, all while holding the rcu_read_lock?
>>=20
>> That would be nice, but as you and I have discussed before:
>>=20
>> On every iteration, we're possibly calling nfsd_file_unhash(), which
>> changes the list. So we have to invoke rhltable_lookup() again to get
>> the updated version of that list.
>>=20
>> As far as I can see there's no "_safe" version of rhl_for_each_entry.
>>=20
>> I think the best we can do is not redrive the lookup if we didn't
>> unhash anything. I'm not sure that will fit easily with the
>> nfsd_file_cond_queue thingie you just added in nfsd-fixes.
>>=20
>> Perhaps it should also drop the RCU read lock on each iteration in
>> case it finds a lot of inodes that match the lookup criteria.
>>=20
>=20
> I could be wrong, but it looks like you're safe to traverse the list
> even in the case of removals, assuming the objects themselves are
> rcu-freed. AFAICT, the object's ->next pointer is not changed when it's
> removed from the table. After all, we're not holding a "real" lock here
> so the object could be removed by another task at any time.
>=20
> It would be nice if this were documented though.

Given Herbert's confirmation that we can continue to use the
returned list after an item has been deleted from it, I will
update this patch to do that.

I had some concerns that, because we don't control the maximum
length of these lists, it could result in indeterminately long
periods where synchronize_rcu() would not make progress, so I
had proposed releasing the RCU read lock and performing the
lookup again during each loop iteration.

I think the usual Linux philosophy of "optimize the common case"
should apply here, and that case is that the list will contain
only a few items in nearly all instances.

Also, there are two or three other instances in the filecache
where we traverse a looked-up list without releasing the read
lock. If long lists is a problem, it will likely be an issue
in those cases first and more often.

Thus I'm going with grabbing the lock once and deleting all the
nfsd_files that are ready before releasing it.

This patch is probably going into v6.4, and I intend to post
this again for review at least once before then.


>>>> +		nf =3D container_of(list, struct nfsd_file, nf_rlist);
>>>> +
>>>> 		/* If we raced with someone else unhashing, ignore it */
>>>> 		if (!nfsd_file_unhash(nf))
>>>> 			continue;
>>>> @@ -836,7 +736,7 @@ nfsd_file_cache_init(void)
>>>> 	if (test_and_set_bit(NFSD_FILE_CACHE_UP, &nfsd_file_flags) =3D=3D 1)
>>>> 		return 0;
>>>>=20
>>>> -	ret =3D rhashtable_init(&nfsd_file_rhash_tbl, &nfsd_file_rhash_param=
s);
>>>> +	ret =3D rhltable_init(&nfsd_file_rhltable, &nfsd_file_rhash_params);
>>>> 	if (ret)
>>>> 		return ret;
>>>>=20
>>>> @@ -904,7 +804,7 @@ nfsd_file_cache_init(void)
>>>> 	nfsd_file_mark_slab =3D NULL;
>>>> 	destroy_workqueue(nfsd_filecache_wq);
>>>> 	nfsd_filecache_wq =3D NULL;
>>>> -	rhashtable_destroy(&nfsd_file_rhash_tbl);
>>>> +	rhltable_destroy(&nfsd_file_rhltable);
>>>> 	goto out;
>>>> }
>>>>=20
>>>> @@ -922,7 +822,7 @@ __nfsd_file_cache_purge(struct net *net)
>>>> 	struct nfsd_file *nf;
>>>> 	LIST_HEAD(dispose);
>>>>=20
>>>> -	rhashtable_walk_enter(&nfsd_file_rhash_tbl, &iter);
>>>> +	rhltable_walk_enter(&nfsd_file_rhltable, &iter);
>>>> 	do {
>>>> 		rhashtable_walk_start(&iter);
>>>>=20
>>>> @@ -1031,7 +931,7 @@ nfsd_file_cache_shutdown(void)
>>>> 	nfsd_file_mark_slab =3D NULL;
>>>> 	destroy_workqueue(nfsd_filecache_wq);
>>>> 	nfsd_filecache_wq =3D NULL;
>>>> -	rhashtable_destroy(&nfsd_file_rhash_tbl);
>>>> +	rhltable_destroy(&nfsd_file_rhltable);
>>>>=20
>>>> 	for_each_possible_cpu(i) {
>>>> 		per_cpu(nfsd_file_cache_hits, i) =3D 0;
>>>> @@ -1042,6 +942,36 @@ nfsd_file_cache_shutdown(void)
>>>> 	}
>>>> }
>>>>=20
>>>> +static struct nfsd_file *
>>>> +nfsd_file_lookup_locked(const struct net *net, const struct cred *cre=
d,
>>>> +			struct inode *inode, unsigned char need,
>>>> +			bool want_gc)
>>>> +{
>>>> +	struct rhlist_head *tmp, *list;
>>>> +	struct nfsd_file *nf;
>>>> +
>>>> +	list =3D rhltable_lookup(&nfsd_file_rhltable, &inode,
>>>> +			       nfsd_file_rhash_params);
>>>> +	rhl_for_each_entry_rcu(nf, tmp, list, nf_rlist) {
>>>> +		if (nf->nf_may !=3D need)
>>>> +			continue;
>>>> +		if (nf->nf_net !=3D net)
>>>> +			continue;
>>>> +		if (!nfsd_match_cred(nf->nf_cred, cred))
>>>> +			continue;
>>>> +		if (!!test_bit(NFSD_FILE_GC, &nf->nf_flags) !=3D want_gc)
>>>> +			continue;
>>>> +		if (test_bit(NFSD_FILE_HASHED, &nf->nf_flags) =3D=3D 0)
>>>> +			continue;
>>>> +
>>>> +		/* If it was on the LRU, reuse that reference. */
>>>> +		if (nfsd_file_lru_remove(nf))
>>>> +			WARN_ON_ONCE(refcount_dec_and_test(&nf->nf_ref));
>>>> +		return nf;
>>>> +	}
>>>> +	return NULL;
>>>> +}
>>>> +
>>>> /**
>>>> * nfsd_file_is_cached - are there any cached open files for this inode=
?
>>>> * @inode: inode to check
>>>> @@ -1056,15 +986,12 @@ nfsd_file_cache_shutdown(void)
>>>> bool
>>>> nfsd_file_is_cached(struct inode *inode)
>>>> {
>>>> -	struct nfsd_file_lookup_key key =3D {
>>>> -		.type	=3D NFSD_FILE_KEY_INODE,
>>>> -		.inode	=3D inode,
>>>> -	};
>>>> -	bool ret =3D false;
>>>> -
>>>> -	if (rhashtable_lookup_fast(&nfsd_file_rhash_tbl, &key,
>>>> -				   nfsd_file_rhash_params) !=3D NULL)
>>>> -		ret =3D true;
>>>> +	bool ret;
>>>> +
>>>> +	rcu_read_lock();
>>>> +	ret =3D (rhltable_lookup(&nfsd_file_rhltable, &inode,
>>>> +			       nfsd_file_rhash_params) !=3D NULL);
>>>> +	rcu_read_unlock();
>>>> 	trace_nfsd_file_is_cached(inode, (int)ret);
>>>> 	return ret;
>>>> }
>>>> @@ -1074,14 +1001,12 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, s=
truct svc_fh *fhp,
>>>> 		     unsigned int may_flags, struct nfsd_file **pnf,
>>>> 		     bool open, bool want_gc)
>>>> {
>>>> -	struct nfsd_file_lookup_key key =3D {
>>>> -		.type	=3D NFSD_FILE_KEY_FULL,
>>>> -		.need	=3D may_flags & NFSD_FILE_MAY_MASK,
>>>> -		.net	=3D SVC_NET(rqstp),
>>>> -		.gc	=3D want_gc,
>>>> -	};
>>>> +	unsigned char need =3D may_flags & NFSD_FILE_MAY_MASK;
>>>> +	struct net *net =3D SVC_NET(rqstp);
>>>> +	struct nfsd_file *new, *nf;
>>>> +	const struct cred *cred;
>>>> 	bool open_retry =3D true;
>>>> -	struct nfsd_file *nf;
>>>> +	struct inode *inode;
>>>> 	__be32 status;
>>>> 	int ret;
>>>>=20
>>>> @@ -1089,32 +1014,38 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, s=
truct svc_fh *fhp,
>>>> 				may_flags|NFSD_MAY_OWNER_OVERRIDE);
>>>> 	if (status !=3D nfs_ok)
>>>> 		return status;
>>>> -	key.inode =3D d_inode(fhp->fh_dentry);
>>>> -	key.cred =3D get_current_cred();
>>>> +	inode =3D d_inode(fhp->fh_dentry);
>>>> +	cred =3D get_current_cred();
>>>>=20
>>>> retry:
>>>> -	rcu_read_lock();
>>>> -	nf =3D rhashtable_lookup(&nfsd_file_rhash_tbl, &key,
>>>> -			       nfsd_file_rhash_params);
>>>> -	if (nf)
>>>> -		nf =3D nfsd_file_get(nf);
>>>> -	rcu_read_unlock();
>>>> -
>>>> -	if (nf) {
>>>> -		if (nfsd_file_lru_remove(nf))
>>>> -			WARN_ON_ONCE(refcount_dec_and_test(&nf->nf_ref));
>>>> -		goto wait_for_construction;
>>>> +	if (open) {
>>>> +		rcu_read_lock();
>>>> +		nf =3D nfsd_file_lookup_locked(net, cred, inode, need, want_gc);
>>>> +		rcu_read_unlock();
>>>> +		if (nf)
>>>> +			goto wait_for_construction;
>>>> 	}
>>>>=20
>>>> -	nf =3D nfsd_file_alloc(&key, may_flags);
>>>> -	if (!nf) {
>>>> +	new =3D nfsd_file_alloc(net, inode, need, want_gc);
>>>> +	if (!new) {
>>>> 		status =3D nfserr_jukebox;
>>>> 		goto out_status;
>>>> 	}
>>>> +	rcu_read_lock();
>>>> +	spin_lock(&inode->i_lock);
>>>> +	nf =3D nfsd_file_lookup_locked(net, cred, inode, need, want_gc);
>>>> +	if (unlikely(nf)) {
>>>> +		spin_unlock(&inode->i_lock);
>>>> +		rcu_read_unlock();
>>>> +		nfsd_file_slab_free(&new->nf_rcu);
>>>> +		goto wait_for_construction;
>>>> +	}
>>>> +	nf =3D new;
>>>> +	ret =3D rhltable_insert(&nfsd_file_rhltable, &nf->nf_rlist,
>>>> +			      nfsd_file_rhash_params);
>>>> +	spin_unlock(&inode->i_lock);
>>>> +	rcu_read_unlock();
>>>>=20
>>>> -	ret =3D rhashtable_lookup_insert_key(&nfsd_file_rhash_tbl,
>>>> -					   &key, &nf->nf_rhash,
>>>> -					   nfsd_file_rhash_params);
>>>> 	if (likely(ret =3D=3D 0))
>>>> 		goto open_file;
>>>>=20
>>>> @@ -1122,7 +1053,7 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, str=
uct svc_fh *fhp,
>>>> 	nf =3D NULL;
>>>> 	if (ret =3D=3D -EEXIST)
>>>> 		goto retry;
>>>> -	trace_nfsd_file_insert_err(rqstp, key.inode, may_flags, ret);
>>>> +	trace_nfsd_file_insert_err(rqstp, inode, may_flags, ret);
>>>> 	status =3D nfserr_jukebox;
>>>> 	goto out_status;
>>>>=20
>>>> @@ -1131,7 +1062,7 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, str=
uct svc_fh *fhp,
>>>>=20
>>>> 	/* Did construction of this file fail? */
>>>> 	if (!test_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
>>>> -		trace_nfsd_file_cons_err(rqstp, key.inode, may_flags, nf);
>>>> +		trace_nfsd_file_cons_err(rqstp, inode, may_flags, nf);
>>>> 		if (!open_retry) {
>>>> 			status =3D nfserr_jukebox;
>>>> 			goto out;
>>>> @@ -1157,14 +1088,14 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, s=
truct svc_fh *fhp,
>>>> 	}
>>>>=20
>>>> out_status:
>>>> -	put_cred(key.cred);
>>>> +	put_cred(cred);
>>>> 	if (open)
>>>> -		trace_nfsd_file_acquire(rqstp, key.inode, may_flags, nf, status);
>>>> +		trace_nfsd_file_acquire(rqstp, inode, may_flags, nf, status);
>>>> 	return status;
>>>>=20
>>>> open_file:
>>>> 	trace_nfsd_file_alloc(nf);
>>>> -	nf->nf_mark =3D nfsd_file_mark_find_or_create(nf, key.inode);
>>>> +	nf->nf_mark =3D nfsd_file_mark_find_or_create(nf, inode);
>>>> 	if (nf->nf_mark) {
>>>> 		if (open) {
>>>> 			status =3D nfsd_open_verified(rqstp, fhp, may_flags,
>>>> @@ -1178,7 +1109,7 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, str=
uct svc_fh *fhp,
>>>> 	 * If construction failed, or we raced with a call to unlink()
>>>> 	 * then unhash.
>>>> 	 */
>>>> -	if (status =3D=3D nfs_ok && key.inode->i_nlink =3D=3D 0)
>>>> +	if (status !=3D nfs_ok || inode->i_nlink =3D=3D 0)
>>>> 		status =3D nfserr_jukebox;
>>>> 	if (status !=3D nfs_ok)
>>>> 		nfsd_file_unhash(nf);
>>>> @@ -1273,7 +1204,7 @@ int nfsd_file_cache_stats_show(struct seq_file *=
m, void *v)
>>>> 		lru =3D list_lru_count(&nfsd_file_lru);
>>>>=20
>>>> 		rcu_read_lock();
>>>> -		ht =3D &nfsd_file_rhash_tbl;
>>>> +		ht =3D &nfsd_file_rhltable.ht;
>>>> 		count =3D atomic_read(&ht->nelems);
>>>> 		tbl =3D rht_dereference_rcu(ht->tbl, ht);
>>>> 		buckets =3D tbl->size;
>>>> @@ -1289,7 +1220,7 @@ int nfsd_file_cache_stats_show(struct seq_file *=
m, void *v)
>>>> 		evictions +=3D per_cpu(nfsd_file_evictions, i);
>>>> 	}
>>>>=20
>>>> -	seq_printf(m, "total entries: %u\n", count);
>>>> +	seq_printf(m, "total inodes: %u\n", count);
>>>> 	seq_printf(m, "hash buckets:  %u\n", buckets);
>>>> 	seq_printf(m, "lru entries:   %lu\n", lru);
>>>> 	seq_printf(m, "cache hits:    %lu\n", hits);
>>>> diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
>>>> index b7efb2c3ddb1..7d3b35771565 100644
>>>> --- a/fs/nfsd/filecache.h
>>>> +++ b/fs/nfsd/filecache.h
>>>> @@ -29,9 +29,8 @@ struct nfsd_file_mark {
>>>> * never be dereferenced, only used for comparison.
>>>> */
>>>> struct nfsd_file {
>>>> -	struct rhash_head	nf_rhash;
>>>> -	struct list_head	nf_lru;
>>>> -	struct rcu_head		nf_rcu;
>>>> +	struct rhlist_head	nf_rlist;
>>>> +	void			*nf_inode;
>>>> 	struct file		*nf_file;
>>>> 	const struct cred	*nf_cred;
>>>> 	struct net		*nf_net;
>>>> @@ -40,10 +39,12 @@ struct nfsd_file {
>>>> #define NFSD_FILE_REFERENCED	(2)
>>>> #define NFSD_FILE_GC		(3)
>>>> 	unsigned long		nf_flags;
>>>> -	struct inode		*nf_inode;	/* don't deref */
>>>> 	refcount_t		nf_ref;
>>>> 	unsigned char		nf_may;
>>>> +
>>>> 	struct nfsd_file_mark	*nf_mark;
>>>> +	struct list_head	nf_lru;
>>>> +	struct rcu_head		nf_rcu;
>>>> 	ktime_t			nf_birthtime;
>>>> };
>>>>=20
>>>>=20
>>>>=20
>>>=20
>>> --=20
>>> Jeff Layton <jlayton@redhat.com>
>>=20
>> --
>> Chuck Lever
>>=20
>>=20
>>=20
>=20
> --=20
> Jeff Layton <jlayton@redhat.com>

--
Chuck Lever



