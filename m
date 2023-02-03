Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64595689C36
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Feb 2023 15:51:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233536AbjBCOvN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 3 Feb 2023 09:51:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233656AbjBCOvG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 3 Feb 2023 09:51:06 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D9849EE05;
        Fri,  3 Feb 2023 06:51:01 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 313DPhDx022480;
        Fri, 3 Feb 2023 14:50:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=0rXj7iEuBDpR9gwPZHcbtAAZCOHnZvzs9e/0BH1Ikdw=;
 b=Xyd2exMoFb2R8U+sfm2t1H3PfvicLnJwXIIODqsLhdhZg8eurhPTsgQlYTzVSoo3QrOC
 7187NaHNtxN1zp246WfRGHFeeMmP7B10Uto1l8Z1KASIG8jLj0zIE3NYnOh/XW8iSHvA
 91PwAKLikYFCzk4Ndd9gtu3d4OXBLRVMdiQP3JxiCv698A/LukcmUI2UvAlEjO8p91gi
 xiI3Y+wTwM10LyG4L5t5UjuAuuhx69pWsAWemYnxoV/nuEYLZ9ENG2vqW0qiFmbaVN+t
 UsmqsHgIlNp/JJXhQScynz1g/0CW+YU3HT6covsxD8tou8G29uw1UenjwAyM0pAC7GMB xg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nfmbg5te0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Feb 2023 14:50:56 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 313ELo8Y034287;
        Fri, 3 Feb 2023 14:50:56 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2045.outbound.protection.outlook.com [104.47.51.45])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3nct5h748y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Feb 2023 14:50:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cd2wqg69L1SscPNYzpnUayP7d45LEnq4tyMQ36qXB8qqScinMimAqeGT1j5z1dmPgDnn2pg1NAAVn2LWPvdLtchTmNK0CTEam6Hm7WWzl7YG8EZy4VH4brayOmOsvOgG+50KrqGUSo+ECHbMPFmUfYpslcIyUVKhf9PeHwR+CC3FcNz7Ujg/rh6IWHG/E9VXGSpOjncXMHmanMNudaIxMh86SN04Z8o9VneQuUmG5en0QUXXLsPoThVzB5dUSvTbQKuYWaZkElXBkSw2sC4mljdqgsVBwGYdiVxRbW/k9u3MKU7UtfhRjVxgU6red/syFmPanI+TN0ZZgIzN56xSQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0rXj7iEuBDpR9gwPZHcbtAAZCOHnZvzs9e/0BH1Ikdw=;
 b=Su59Y3yvrojRrb4KEYFbyBYI5lUkLwV9Jn6rZBOe0tSQ9o9piuA64Yv2RsC6d7TCQC4MFDXUfP45FjZSJuYgh9C0T34D0a57WS0+1uQgJrfs0TKMn2BDBJKrwQslMNYAFDklM4q4/TmUrM/MJO/OehGAlOpxP83zCRpXVPEwC+z48rPcOEPqcNN3bl2Zzj0AMD39BNdumsGBDJ7f7fmssAjIRNfKyOoomGNz0Kd3wRu69AMTjC+0v8A8pW5lxV9u8SiKy2M6C3+3heBan2TAnnhKlZQXyUhziU001U2rHfHA8jurO0ldoN36PgwRlj0tD4EYuHmjG1wzx/V32/IBEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0rXj7iEuBDpR9gwPZHcbtAAZCOHnZvzs9e/0BH1Ikdw=;
 b=D7s3ZoEfHYv/KmWW6WyRZytph/lIpbM07LUCPysOBVoTLp2t0Cj1MkYBtAKS+0KxSrXuk81mpsBUUAzrqMhlK54r86Iq30iVIoHOGZqhGzgTfsYFJeDEwrylbYDlj3grlq7zR5qUBqqxpS7cGqO8WcKIjSIljvd8gf97ugT+EX0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW4PR10MB6678.namprd10.prod.outlook.com (2603:10b6:303:22c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.19; Fri, 3 Feb
 2023 14:50:54 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::96a2:2d53:eb8c:b5ed]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::96a2:2d53:eb8c:b5ed%4]) with mapi id 15.20.6086.007; Fri, 3 Feb 2023
 14:50:53 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Dai Ngo <dai.ngo@oracle.com>, Pumpkin <cc85nod@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] NFSD: fix deny mode logic in nfs4_upgrade_open
Thread-Topic: [PATCH] NFSD: fix deny mode logic in nfs4_upgrade_open
Thread-Index: AQHZNtkQTUc54cGJ8kWHJe+mTHkMtq68DvmAgAAcTwCAASTYAA==
Date:   Fri, 3 Feb 2023 14:50:53 +0000
Message-ID: <CE064BB1-510B-4268-A92E-8DAC680AAA22@oracle.com>
References: <20230202073611.13106-1-cc85nod@gmail.com>
 <CBAFB3E5-5737-47A7-8234-3A771E908C4F@oracle.com>
 <7b7edc8bacb863915d00673f9e03d38798341a69.camel@kernel.org>
In-Reply-To: <7b7edc8bacb863915d00673f9e03d38798341a69.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|MW4PR10MB6678:EE_
x-ms-office365-filtering-correlation-id: 977b5dbe-2790-449d-4123-08db05f60c69
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8HdLLxD0eL2943b2vOzMnw7wu7189xyNjQQKhM8r0UmgTDeN1DkHP6U4SDB7SbtlHoUX4lT91LaPQkqNkUsezd3mrsYlfQc0xMp88YJAHwxzzWTinuiIOODWkS6wvAzvkVbdn8BIj6cblX0OkxBsdcGzr5gyyXOxWzlGV1Y7ufW2WBAkourC851W6ztIS/IzmcFy7h+Y2jZVPnFqPLfe7An2LeNbX5vlyzOepqTStkY57B9tJW65kL/mqkD2hmSsqi03FuVl8qwxMq2nPnvqeFfMwLoKAK+05qemaGT2uQAa7oFiRk8N3dsPuxPMt1LQ3B98UzpvGrhxrNgflzxO3G3Hr1BsfTDiI2135l5s5A9pzWnNhi/gsLffXA8IhazPlYy4EX2vH3JnU2CEJD5e5sBvc/Wv/NxeMfN/JF2wvwhJFoDhHoWIS6/xbokA8B9zdO92rdqKA0MZjoOvZn98pVeFBghSI7rt4TbdbVt7OYr6kEb/Hd5AUv2Px6JyKfe3nsUMS+UVaBanKeyjPEOIsu580i5curCHjwDXbo2Rdyu//kk/e2ZZNDJWU9e0yyN0snQVcQkuMrkGuVsyNR36sH3stQMQcC1OADDIuZYkcADiNTi59xoYSMPu2uc3e58hzQjHqJgLK2v7/2qq0e0ur8KrUgmrWkCX3/gsYT8Hh8JLxd6tBTfnjgB8fSGWV3hpVv92XRsPMaW8rlbxzSnRxWmOF3Pok7AS6K+nFIDH2+E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(346002)(136003)(396003)(376002)(366004)(451199018)(6486002)(66476007)(41300700001)(6506007)(66556008)(186003)(2616005)(26005)(83380400001)(91956017)(122000001)(316002)(38100700002)(53546011)(36756003)(38070700005)(54906003)(71200400001)(76116006)(8676002)(66446008)(64756008)(6916009)(66946007)(4326008)(86362001)(478600001)(33656002)(6512007)(2906002)(8936002)(5660300002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bSJtlanvxvokxTxGX2yDOSHQQy3jrCOkG4BzJXcib9qMYtOVw9f22oY8YyEL?=
 =?us-ascii?Q?WR254AyEKrLaRNczDfdEWSvpxafXMFRG905Ig8B+21LBpPZ6Bf5FJ8R6sSns?=
 =?us-ascii?Q?FUbTkBpSRw3N+2ZjlXWIbcD4ZoGkIpyNxBieKLfwDfwGaq7WtZ0+EvA3nXBV?=
 =?us-ascii?Q?ySsyiaIqhd/eU+2jq9cwQxKiDoCTyJqebBfKMj5t++hPDOeRrdc2+ltB5lmE?=
 =?us-ascii?Q?Buo8eagB2sGdfitidNBIjPStnpVnw50WBoypAiuvI6sYc1RhaR3fKSRW/0vm?=
 =?us-ascii?Q?Vme6hf3i5kt4Bb0jOTSwnx9oGv7DMcRlT76sNnltlwfIOYgbNk+uuuCkGosL?=
 =?us-ascii?Q?U/cHVRio2SbNF1pU4vql345tiNZtWbMxQ0pQfQZbqTO9DvPgoBPAsPfE7hSo?=
 =?us-ascii?Q?JkRM3+yLeSqkyG5cPq/GKlQMlgSv88HTrTDCsdvW/QEzz5wjJ0yFVRiQdY0W?=
 =?us-ascii?Q?adkxiXS/bCpcMvjT7xCrYYTlLGQPuUW+sO1nccp3lMgfL9NIZNE+aSpL70vX?=
 =?us-ascii?Q?223DEnZE0JLuQKuxA1FbKYIzv0HHp7j9QuHVtRc4/efrgkoI/pAtbGAk2L4L?=
 =?us-ascii?Q?fpQxjNlAR7LTh3miMTS4k8DyMpQMdJ5zk+MquOlJFW5Ge+LSp4tpZg9WPzf2?=
 =?us-ascii?Q?P8bKcwzbSisbjX8nZ3YmPvk0d75L3P0WZ2AcdAw0GkcInM/TqMG957cGCxRN?=
 =?us-ascii?Q?KQMish1oD/HxWd2hgos/PHl5neBY+JopwF63Gj8BeFD9n7pKX1MRTF0xksUh?=
 =?us-ascii?Q?F/YXfoL22BuLiOC33JikIYyZ8rwAEiR17z6ukDa2ry7Jh/AnQXN2hTOGiidI?=
 =?us-ascii?Q?km1ApJboI1tUBHtxs93SxhmhJDim4n5AX9WjH7uQwoj6nIOb27wLvkNOkHFp?=
 =?us-ascii?Q?/b0Xlm1xYrRulmj3+iKP/8T/r/i0I8vSEvJTbK7eYLDo6Nu9Kkn1ZX9BVfhK?=
 =?us-ascii?Q?/XQJDmcUQJQ9PbRn1ZUvrmY78YrGVA+4aErGNa7YfMdHKhxeON77ddmJEp/m?=
 =?us-ascii?Q?0RtPYDjifWJrFEnw0uMpWx69IhQzu7g2VHyEw7Clo9v8iljnsJo+py71juQh?=
 =?us-ascii?Q?u6VTJ7kP5D6GL2Puxdcb5oCkpS2zfYpmOwEci/mamIFcXsU9p8aKBMFdJrYb?=
 =?us-ascii?Q?Y0WOIWAFQgfZRbxyK+OAbWEjL46yIOg8wJZZi/QrY4EgtHSDpoZgwwtzWaDu?=
 =?us-ascii?Q?6V8QX6aXwqeklc0bc2/Aazdud1/87ovF4ucqzUiX6iiP7Z+rxlzc8nY6IQ3Y?=
 =?us-ascii?Q?jsIBkakQjxplFAETEPSIc1PUYVeG9cI86/COiE11oJAcDamS6mLW/9ajgnDC?=
 =?us-ascii?Q?5v8RZV0gWtoSuKiTd0K7xkGuOVoW/rZSC3EImhBrKbDjJ+pmDO+FSeT3Bu1b?=
 =?us-ascii?Q?bzL01GeFmSy0mw2fJsXoUOzJ71SidlwzwlbVzM7li0o/n58oBdioAIm7LMkn?=
 =?us-ascii?Q?6DW/PByDaWC/d4adby6AVSKcIGdIKOAvTgU08JwhJ8TNvW1AeeKUWZp6z3iy?=
 =?us-ascii?Q?jb3gjx49RgjK9Qhh68aJNtGlrsSzlPbb2ReNBEDLqjoM1pyfvmbulEsr0dGX?=
 =?us-ascii?Q?5Od2dWCDhNi28qCgEGr+XpP4oZuUM8TvwlKC0SM4fTl2VdsAhKeGbCNuq+XE?=
 =?us-ascii?Q?XQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DDA9A61D50C3EB45B763192D0FBB45E5@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: CWgNQ47CEiomOACsfMOmUh+egUy1PiJ6kSfXG6XC3a2QeyYj83r/XWYMGHbFMxECTPgMCMEkyN1u5pCL32F3I9tIRQ5EG1xxsTDty5lSBDAL3GAqlxS0PGnSHdtQL7tOWl/UVz8H6C6bxYOt+q5Qd2QhIVNCNvOFu7dtP2XFBekg/qWwi2h7zGB9pLO6iikeJ5cYYmKVhzXNEjB3/LL9qvu6wFfYUU+HBw4ie597JlCMWxxcNApgKIM/u3PcJi4xQa/JwWjDgxCr61p56X92DxMCU0ASqHPt9e1W5nnNKy5ZDNKehoRDShSL4wXyNrykQbE6fUWUBWfrQX08hD0unMZV+tDlKXR9IRWfHJ8i0BPWIQpXxEtGJhTu8fYKUSjRanH/0c/VNhjitzSrL4hCv4Ob9M5Zf1Bt61VNhc5loWmE+qDn0C2t2f7Qt3DtLlv4DCxO3gNWWkMy+UA9g4nxVWHCio9kD5bT3Ku5QwvYWqv4L60R81eVNyyeQ8MZhiQUyEHVRaqgEbsQKtc/+IJvLLEWCk88RxCu6+XdSAKLDPtoB5izFx2cqa50v4LlaL2Tc92eC+e6NK48OQ93gRP7cM8BlyqHzJC0JRofSmZEHpJ3NcxhiC3UHRLuJiEGwOHVPpdedLTHBmtlXpBaGuLiw8+imIFApT4rbw5/MpnfuExfaaQ6c/yN2IXkRGWlsCt+9An3qEM5X1tUOAw2vJV6tqF4ePlaZvgz93L06dwSxpQyREFAnvxhxmRotR/plSnohJekcZpI1HyeZ0PsCnIXjGQYK/wluzFX2PO47CKld9KcNwDhqNGfsjkntivKQIfD
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 977b5dbe-2790-449d-4123-08db05f60c69
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2023 14:50:53.0750
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W03DpFWfe3BjsHBarN+5aZLRHKyOXUYQs5IWSHpCBAV89N0KMcVSdhSICaT3wOcmauy9w2fhzXpPlzmYFnc4CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6678
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-03_14,2023-02-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 adultscore=0 mlxscore=0 phishscore=0 mlxlogscore=846
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302030136
X-Proofpoint-ORIG-GUID: NYPgSAslcnrZ9AnYSGMfatoqIl3RNJsf
X-Proofpoint-GUID: NYPgSAslcnrZ9AnYSGMfatoqIl3RNJsf
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Feb 2, 2023, at 4:22 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Thu, 2023-02-02 at 19:41 +0000, Chuck Lever III wrote:
>>=20
>>> On Feb 2, 2023, at 2:36 AM, Pumpkin <cc85nod@gmail.com> wrote:
>>>=20
>>> If the upgrading deny mode is invalid or conflicts with other client, w=
e
>>> should try to resolve it, but the if-condition makes those error handli=
ng
>>> cannot be executed.
>>>=20
>>> Signed-off-by: Pumpkin <cc85nod@gmail.com>
>>> ---
>>> fs/nfsd/nfs4state.c | 2 +-
>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>=20
>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>> index 4ef529379..ebdfaf0f9 100644
>>> --- a/fs/nfsd/nfs4state.c
>>> +++ b/fs/nfsd/nfs4state.c
>>> @@ -5298,7 +5298,7 @@ nfs4_upgrade_open(struct svc_rqst *rqstp, struct =
nfs4_file *fp,
>>> 	/* test and set deny mode */
>>> 	spin_lock(&fp->fi_lock);
>>> 	status =3D nfs4_file_check_deny(fp, open->op_share_deny);
>>> -	if (status =3D=3D nfs_ok) {
>>> +	if (status !=3D nfs_ok) {
>>> 		if (status !=3D nfserr_share_denied) {
>>=20
>> if status =3D=3D nfs_ok then status will definitely not equal
>> share_denied. So this check is a bit nonsensical as it stands.
>>=20
>> Usually I prefer "switch (status)" in situations like this
>> because that avoids this kind of issue and I find it easier
>> to read quickly.
>>=20
>> Jeff, you are the original author of this function, and
>> Dai, your commit is the last one to touch this area. Can
>> you guys have a look? The one-liner looks correct, but I
>> might be missing something.
>>=20
>=20
> Yeah, that code is clearly broken and it looks like it was done in
> 3d69427151806 (NFSD: add support for share reservation conflict to
> courteous server).
>=20
> I don't believe that one-liner is correct though. If the result is
> nfs_ok, then we want to set the deny mode here and that won't happen.
>=20
> Something like this maybe? (completely untested):
>=20
> ---------------8<-------------------
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index c39e43742dd6..af22dfdc6fcc 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -5282,16 +5282,17 @@ nfs4_upgrade_open(struct svc_rqst *rqstp, struct =
nfs4_file *fp,
>        /* test and set deny mode */
>        spin_lock(&fp->fi_lock);
>        status =3D nfs4_file_check_deny(fp, open->op_share_deny);
> -       if (status =3D=3D nfs_ok) {
> -               if (status !=3D nfserr_share_denied) {
> -                       set_deny(open->op_share_deny, stp);
> -                       fp->fi_share_deny |=3D
> -                               (open->op_share_deny & NFS4_SHARE_DENY_BO=
TH);
> -               } else {
> -                       if (nfs4_resolve_deny_conflicts_locked(fp, false,
> -                                       stp, open->op_share_deny, false))
> -                               status =3D nfserr_jukebox;
> -               }
> +       switch (status) {
> +       case nfs_ok:
> +               set_deny(open->op_share_deny, stp);
> +               fp->fi_share_deny |=3D
> +                       (open->op_share_deny & NFS4_SHARE_DENY_BOTH);
> +               break;
> +       case nfserr_share_denied:
> +               if (nfs4_resolve_deny_conflicts_locked(fp, false,
> +                               stp, open->op_share_deny, false))
> +                       status =3D nfserr_jukebox;
> +               break;
>        }
>        spin_unlock(&fp->fi_lock);

Would pynfs have a case or two that could test this?

Can you post an official version of this patch with Reported-by
and Fixes tags?


--
Chuck Lever



