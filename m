Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CAAF67299E
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Jan 2023 21:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjARUoq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 18 Jan 2023 15:44:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbjARUoo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 18 Jan 2023 15:44:44 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A56735FD71
        for <linux-nfs@vger.kernel.org>; Wed, 18 Jan 2023 12:44:41 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30II4b5v004668;
        Wed, 18 Jan 2023 20:44:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=XlsYnEH5MsSQSAdXHaXQBnD7C/+mc59AWvcu8RaarPo=;
 b=iQNrQcdlOZ1zVpGFRNsBA+b6e3Iz8Cld8iDnVfG+aUfQZmOmOxApat6w1tTYMqrxWqzB
 7nYfzNINX4108CmiKyv5RBmiqJmT2YGZeOnxufnvuF903TVqZnih3uIALBXkdfxBXmWN
 dqqTquxFYocfwIr/KI45k6Us3+9WDCsUaapL+yyvHytsp2byKqClHRoF+rKmTAwdeg6z
 Mi3i9paNS4UcST6MJy/V1Rb5TMlFaRVhysQeIrMgM8LcGxtuA2BrHYWtoyxR1k8y1slA
 5DQhrajnJY9Bn0MmgFkUNs7Hgs068GGHvx7+MpB8FTcfkyKVyLpiTT9dt40dIOnU9pb6 jA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n40mdg2ph-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jan 2023 20:44:38 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30IKSvVd028748;
        Wed, 18 Jan 2023 20:44:37 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2044.outbound.protection.outlook.com [104.47.51.44])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n6qufrkxf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jan 2023 20:44:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y8iSA78Ehn5pMUFWP6B6EYRLUoqc4CP6IYIUT+yTn4YfAPxjQL43v7lYicscTPtbepP5c9dSHdCWlhVyynenEwvbY5+xM8I7PVzjIIB6nKe7ThzOb1eKinQJcP9Dhr1kLiTYfRFvPidNPivO7fm0S/D5PIRmO5Cd1W5BpJjJjpFSV23299fNkt0XbU2pX9VaIlR5TSIHRwWL1BJcq3NFXVkctEldqFrcgXxAGeXbOs7Cdu9E7r0+dbPkSDtyDAft8k3jBD8SlT74mba3vNgUx+O+EZGq61yBb6hEkTj27AJc00BlxSzVo1f+Otf9+0VAzrFUyUrMUZraQH20xdOEPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XlsYnEH5MsSQSAdXHaXQBnD7C/+mc59AWvcu8RaarPo=;
 b=GPcPPZDjrDRVNyAk6zCoD5ea6oPFHWqs+KBpTVc+v+fBJKyaRQCXTEK+sOYdbCfdowjVT7rAzVte1kuh8BjBdHYPwx6wMkxi3id/Onpck2/qu9bE2YByabtrpH/kZDjDbOHlPXm5+0wBMDA6tEPshhCi+qW2wHm179C0z6bYc+bcZXKEp7BcGVGG6jpMT/XnAqwGv3hIftJ6NZpAN73ODPwZ7qvXFpADtGGVeL6MW9dodc9O20hnGTZeRNuqrUnDpn0KlyxRah5MG3DX9/lEjmXl6QBtwXn70p5WmFlTrh7XDin0uoeZ5yR2vNyiw1Dkqb0K4F4uoBmD2V2S8MENnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XlsYnEH5MsSQSAdXHaXQBnD7C/+mc59AWvcu8RaarPo=;
 b=DO4cTGs2GycU8f4QoICNxWWaWNR/gKwua50d5iyMGdnEO30mWV4noUls9MGpZrPm/NceasIemhsDNbNP6CITStQp3/p0VeoYJczfUKPkf4hK+eT3VBPuaSIX2NLaNkFVMlwnT2BVFUBpeN2VFAkOdOmbVVnKEsXVcXoSOSvdr1E=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM4PR10MB6112.namprd10.prod.outlook.com (2603:10b6:8:b7::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.12; Wed, 18 Jan 2023 20:44:34 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9%5]) with mapi id 15.20.6002.013; Wed, 18 Jan 2023
 20:44:34 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 3/6] nfsd: simplify the delayed disposal list code
Thread-Topic: [PATCH 3/6] nfsd: simplify the delayed disposal list code
Thread-Index: AQHZK2K9iQAA9AGCR0S9mUeEchObFK6kiaSAgAAJkYCAABFcgA==
Date:   Wed, 18 Jan 2023 20:44:34 +0000
Message-ID: <B3C099E6-D684-40E4-ABE8-9514C40F28B9@oracle.com>
References: <20230118173139.71846-1-jlayton@kernel.org>
 <20230118173139.71846-4-jlayton@kernel.org>
 <0BDD4ABB-2470-483A-A2F7-C65B84546FB5@oracle.com>
 <7c2f30279da9f1c927ee3141fa14a7c14ca50297.camel@kernel.org>
In-Reply-To: <7c2f30279da9f1c927ee3141fa14a7c14ca50297.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DM4PR10MB6112:EE_
x-ms-office365-filtering-correlation-id: 87ac346c-d967-4cbd-9edc-08daf994ce92
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QerHCX9saH3r7BiGxL9wnpPRqjBth/9Px/TgPPdNM8GnXqmLDaOj/qUqIpzzsozrjMxJ7WF2dsaflX5HOIZ15BD4nlna4z5pFxm0D5aX0+dDZO2Z+ch2xIZvNDBFzEMH7+UuUcl59GS5fryp7lS2gWPUAHGrHfYY1sVC2ZkhJEx9nteuL7IM+1e2kL/Dr7lxsjD957JrXfPY9SKTD2wTuHJ5ezqDi0VpCjEhEQ5TZ1MO8DAVp8Fdlrt0DJ7ca7tTnbymH3oL/A4XomjfAKAqhelCAWO6gM2gC/bzWW0Re7WFXR+oYWmUGjl02fHbMQN3ycSW820vCbs9kCRgPhqqRUjLL0QO/ZRn4O1XKieXqaGuhyyrts7oTpPZBHOU/UTVAJAcEbrWRG5rwglamOkFHL/ltMPH3XJ5mE0+Huv7g7vi7gJt1+04uDqtBZqKdh55GEsjueLKnXFJ8c+KREXaAOtO+MiDCBiErbGoxMlpWhyFhtikU1r8WNagVxZnIyCnOS5SALI0Wn8UbWos8E8ARVNu+ZMjyAQLV44fxvMPzol0Lp631c8WunJjqwVmPLkTrb4zaOFKUIOzD52HA8ZnhMTX5psshWeRx7AJSLw4wyiK/WC6s5r1vgg+lhWvVBZQ9sE8pNcbaEXlxCNhqMxwvHwUHqHWBKfktWSOCVIEnlXiK0i4YqmaAcOyY+D6fp/D7s6eMKZGBThj8KmxE631sLkH6Eegc8WtGufm85cK2Rs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(346002)(376002)(396003)(366004)(451199015)(91956017)(76116006)(66946007)(4326008)(6916009)(66556008)(66476007)(64756008)(8676002)(66446008)(41300700001)(36756003)(86362001)(2616005)(316002)(2906002)(122000001)(33656002)(38100700002)(8936002)(5660300002)(38070700005)(71200400001)(6486002)(26005)(186003)(6512007)(478600001)(53546011)(6506007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BGuiCdpB7JIvMw/aSJhm/SmxRYnV/omCF/NZoKuES1ta6chr7iqxunPXtyUp?=
 =?us-ascii?Q?LWu00YPa7lDJBme8BDT1Cmmw+oHNpy22H3SNNIajuvaZ5ipcM6eBwxbGBEuN?=
 =?us-ascii?Q?TUe+Tm9MHC3fTj72zcu7iAE+P2GKN0Wc5jIrvpjunnDbl4zi4Hy4HVrSRBgo?=
 =?us-ascii?Q?ZY9RQCXvnnoHGQVRiWdq1loziPCS4+qKjNJhuPYihh6gKzXft0d7Gw+yiQbY?=
 =?us-ascii?Q?Ae20U3N+0CZY6Z6D3dgFyriLijfcyxp/QrsvKEviTlS7OriNdsK0O4LQG/2R?=
 =?us-ascii?Q?fZDeQIAe9tDMEu5IfGDmC3HceO0VtloKDSmjtB9nMWuluKkdX9pzSZDlftr2?=
 =?us-ascii?Q?i21y5KyIHEiGGiju62emnRKjmyDpU2b/T5YH39L62X2xL71Dp5ZhGVkn/XPX?=
 =?us-ascii?Q?4OtTtxQHZwfBxy05nvGD8colb7Wg6+DzEftbDmqYd1QErrfFIYJwGgLY0lTT?=
 =?us-ascii?Q?UIJFIDFC/ruNCiho0Q0pzFdrtopCnvOymsrsAGxE6SgZ/aNfOq3NrDxw1Olo?=
 =?us-ascii?Q?O5CfPUz5Y6a33X7mcvZEnHotC2TXBfsXx8Oa8RelO0eTNmjMEVPmTGlv60+r?=
 =?us-ascii?Q?xYByS/3r3OzFOCnuJKSqxGxboopaPei8SfZc9LRXdEYJ6gwiaMPUva+4I9aY?=
 =?us-ascii?Q?Ex82lItpmoOBRG9rNx0Vo8S5yFPZO1Mof9oh/HtCV4qepGd8SxDaHg9JThCl?=
 =?us-ascii?Q?HU2ZvU9T92VzhEGyQqAbbLSmnajICy3mKzP/PptpcvDz0h1nHOLPwsVJvPYp?=
 =?us-ascii?Q?dD4I+ti1moQJKaeYpFyRk56WoKFUMZ5pq41U/GFgUqNGJf64GpnQqDUQnCKC?=
 =?us-ascii?Q?XcO8yeoN1jbqG6T71DJMU6fk33CuTk3D/94GslHrmqwukIWGb1jahWcHl5+H?=
 =?us-ascii?Q?jmE7IGvOsvsTduD/dC6fXyUP/yCBXGpBCpcN1O1K796phdhbZLKwrEjZKkcy?=
 =?us-ascii?Q?2FVw/u8gZRJjgS8a31cd+DtV0JdMFyGy6zFPyI7cRJDti/kixnnk19NGZ/gr?=
 =?us-ascii?Q?5fl8j3crUTcma8voZiSSfro82nI7Q1dRvJZ9PH1P2hS7zbw8nO9e1hstp++B?=
 =?us-ascii?Q?ffCcrMWhy42TZRRuZcUnJcTMLwRhu3FBHSGcm58N/WvqYnf4mkMnX5FrkKOB?=
 =?us-ascii?Q?h98XepTMz/VZPsfs96UpGHSczwumPxeVybbOn8NPUa9LCn25NrdMzGUn9iPq?=
 =?us-ascii?Q?U1jQ/u9YrXqPlhzJ5K3ymVhkpt10wNLhAl/FfgKHecWMywnxUzqd2yektiZy?=
 =?us-ascii?Q?d8o5TqhfNZCJQWdzY6BYbULXocItI1SuVaz+ENo5UKdSgfjrvsOt50rAziYc?=
 =?us-ascii?Q?/ierBEGttePgteOWc+4dbqzVHdm+3KlPNkJwf3v7kIoOWI0rFNjaHeFdcS4E?=
 =?us-ascii?Q?A6JYjqlK5pF1gWvCSC+XkMivCrthNdJlG/GnmRHRKMttgA2Nmrvg6gmz/2BG?=
 =?us-ascii?Q?/kJKg1Yoq0r0vBfEadmE/tSVXcLFR00qjovEMlqMULqh/888wgaG7i+xZ8OE?=
 =?us-ascii?Q?ATl2T4I8L2Eb6HJD6mzuBNb14keszvmG2MflViECcE6dzDOBSQABrBqLzE/f?=
 =?us-ascii?Q?A/CaBNFklJTB2Y+f2PZi/G1s7tRiZvCjcayKeUOo40vqCV2+KwfsX8O7BKbc?=
 =?us-ascii?Q?xw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <21052CAAE067A94E974D14CEBBDC80D8@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Lcp7C4/VhBRtqZstAg7mkuoRFh6epsgK6XrClY+TQT0MPALM9kULPjvzUQCPDZfr6NXfzef4u5E1GOOPVAncfxlA+Db9dVYDWmP16WH3LQdSbniltb4z8jrlvIvOjvdC+8VU8ZfaIPcr/tGM6PIn1OkT5YKsrGSJndY8n/poOrUuCUmp8XrbJRVpxqjjR/jXKKm9nrSKsYHLMjMANpj0Xic/9dzc9qyy6eqaoTks269RrzOFlSILOwCmICkoM6c/C1v+MNvl/5mvvXlvPSyUOF0acwpEhoe5EQjx5lHudzNZ245Zb4Aq76aaQpVwhj9FLl7Le6yItXtmu6hO4gRe5ByDrn5FOrwx57l4v7DkwiPJaLfmWSK24MiB585bzJ+TzkmrSnAXIXcSiyQBe5CoralGcPd1XMVo2FhbS2Zo1MlMZFKIpja51pe4rI4SLQOslIRL3G5/M20vE+6P2D3L1eI2RcLH1yAVgvEyd9FaFjKWj/VOU/8rE52fnuD4ypLCEfvn2Yh8dtyo0aHTxMu1Gb71t4wYima4a6DrDVWXq5cDQFcMSCy4f/61R7IhGOQXazPczlHer7tE7iOgS3FcFOeuM7wTVDCtacM9DQjeTWnoHgY5YfO5Y+DBbhsKCaJUBqggcHryr1ONai1y9eotCmZYJ5UlrrT1HUQ0pSolb8XFM2u470Ijxas9UiA3CBzK3LO5mDII3Ra8lbxvp17pxr7T/np6d2b5BzWBkQN/9kzFnpJzCZj0PJLR8trvYYnIvLPKm7EOhniF7NM93j+vWDRPb8vOZ10EBW+9Jsnu+lQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87ac346c-d967-4cbd-9edc-08daf994ce92
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2023 20:44:34.1899
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TIVix/eXzSDViYJihBC9rYPmgGdwwnEbfpkI0K6jMbdb4ImU/sEwwCFfvfrkdurm6vUjl7sPVcE7F09z6ETmzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6112
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-18_05,2023-01-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301180175
X-Proofpoint-ORIG-GUID: WgM8Guw89UYkVt7CkE7gSrDX16GOyEHs
X-Proofpoint-GUID: WgM8Guw89UYkVt7CkE7gSrDX16GOyEHs
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 18, 2023, at 2:42 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Wed, 2023-01-18 at 19:08 +0000, Chuck Lever III wrote:
>>=20
>>> On Jan 18, 2023, at 12:31 PM, Jeff Layton <jlayton@kernel.org> wrote:
>>>=20
>>> When queueing a dispose list to the appropriate "freeme" lists, it
>>> pointlessly queues the objects one at a time to an intermediate list.
>>>=20
>>> Remove a few helpers and just open code a list_move to make it more
>>> clear and efficient. Better document the resulting functions with
>>> kerneldoc comments.
>>=20
>> I'd like to freeze the filecache code until we've sorted out the
>> destroy_deleg_unhashed crashes. Shall I simply maintain 3/6 and
>> 4/6 and any subsequent filecache changes (like my rhltable
>> rewrite) on a topic branch?
>>=20
>> One good reason to do that is to enable an eventual fix to be
>> backported to stable kernels without also needing to pull in
>> intervening clean-up patches.
>>=20
>> I've already applied a couple small changes that I would rather
>> wait on for this reason. I might move those over to the topic
>> branch as well... I promise to keep it based on nfsd-next so it
>> makes sense to continue developing filecache work on top of the
>> topic branch.
>>=20
>> The other patches in this series are sensible clean-ups that I
>> plan to apply for v6.3 if there are no other objections.
>>=20
>=20
> So that means you won't take patches 3 and 4, but the rest are ok?

They all look fine to me. I've applied 1, 2, 5, and 6 to nfsd-next,
and 3 and 4 along with several others have been applied to a
branch called topic-filecache-cleanups, which is published now so
you can continue developing against that and so it will get pulled
into the 0-day test harness.

I will merge the stuff in that topic branch at some point, I'm just
not committing yet to applying it specifically to v6.3.

Yes, you can call me "too conservative." :-) But I am sensitive to
addressing the destroy_unhashed_deleg crashers in v6.1, which is
to become an LTS if I understand correctly. That's the main reason
for adding this extra step for filecache-related clean-ups. Narrow
bug fixes still go right into nfsd-next or nfsd-fixes, as usual.

If this arrangement becomes onerous, I will mix those commits back
into the general nfsd-next population and we will never speak of it
again.


--
Chuck Lever



