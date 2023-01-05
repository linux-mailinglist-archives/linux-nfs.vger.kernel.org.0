Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE2A665EE95
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Jan 2023 15:19:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbjAEOTB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 5 Jan 2023 09:19:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjAEOS7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 5 Jan 2023 09:18:59 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7707C59322
        for <linux-nfs@vger.kernel.org>; Thu,  5 Jan 2023 06:18:58 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 305E4HO5025023;
        Thu, 5 Jan 2023 14:18:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=C3fDRjgRZCoaAnECdTQusdVc5RAZHoOlQ0/BFnxUZJg=;
 b=D5JpUCbQABxz12fsCLstnDop0D7b2VyxYDtxfSDOLGbqjXlrnwbbuysQeJo0WLrgY90o
 EFo41VZ4YypAVWihBfwAdqWIYTnRATPkGmrO3g5FHBPVlMswhtSAZS4I9nHeGS5FmrMt
 ThvEqr0nOpW95tU7XMuwC699uwFzqGvGET0vziJqxSdKWMuDCulxi6IZeiTXKd+Bk4Ry
 pAaTuB6gBNbf+4rh2KJlpYIbmzehyahl1Vn9w0aVruS8EKWljHZ1PuIdSXQ+mVpeeJq9
 FpO5EBIPKwhoaRM6gtgD0KA3o5uU1V4eysd+tNpyqhDRDexNBD/o8kK9MmESCdXW2UO2 rQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtdmtruc3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 14:18:55 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 305CwS4F002423;
        Thu, 5 Jan 2023 14:18:55 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mwepsu205-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 14:18:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hcbUBfZylaazFB52OTDc2eVN0kckTvWDTyuO6rZfeLDdWCuKbaG2pnO/9yOCwKO+q4pT8CbZiz0eUfHbE/wbNrjs84kFaLbebug756VDW6cGZxpPI21xu1wMzK+i+csw1BtMYBrq+TeRAvS+hLh5kVwLBWNKaygvdj5WnIK3c9igwkdQqdcnsl8Jrz01u0ERioH+w0g8KPF11JpSu81imDb9fA/q0bKduSfQYHcLxF61uzBjaSKawHYA3aN24NocUNDOBOc5cHRPdb34jQEP5kSl/XvqR/mZVlNkA8D2S/e68UPhf3SUBBeF8fxO9PWAs4emNRQLHqLfhrIbvzlt/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C3fDRjgRZCoaAnECdTQusdVc5RAZHoOlQ0/BFnxUZJg=;
 b=fnP53+ipEqQBWjh1gloLmvN0eX7ISiimjiQjiH0zUfrP7oB0oiThyuc9eJQRZHj1+rhGe0WUo7LyX0s4pS0Rm+tje4hEb188EK8UZkTyNtZNge0c+fDh70ZFvB34mlWiq/YOitfsr0WYiWGHDNWiMD57Hjj+wGrZb+v4lOl4FKdWW0cM+t98MvJ3RoHVVevxYH3kS/kz9ZFVE+eZD+txJzzjH3DOn4hS2X2XeycThQKVE/5JPuPfwU+jcin5jkVoAyAvxqtIFFnGzD3lem7TH9JO0At7bmdjKFDvrg/HLZM7X7u6HhhlPAYK/oj6bptbk6QBWoNogKLaX7uWxLOKXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C3fDRjgRZCoaAnECdTQusdVc5RAZHoOlQ0/BFnxUZJg=;
 b=TqyUhOc8bXj+ZHEeqJ6npu88UncYSrbZqiHN1F6F8R8Nm1imsVHBIrSRry+uWz05zMlCmXT3gjbCpK9A/eS9rAX2l4k2fFIVwEbvBtlEPadDxM4ONDLDlGzcBrKhF+6/q3jCCmgsEh4e1ZZSoySgaTM2rscKfKkEKXhV646BYkU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SN4PR10MB5541.namprd10.prod.outlook.com (2603:10b6:806:20e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 14:18:53 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9%4]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 14:18:52 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 2/4] nfsd: NFSD_FILE_KEY_INODE only needs to find GC'ed
 entries
Thread-Topic: [PATCH 2/4] nfsd: NFSD_FILE_KEY_INODE only needs to find GC'ed
 entries
Thread-Index: AQHZIP9icvcrgLzObkKRs2F8ILhq166P30YA
Date:   Thu, 5 Jan 2023 14:18:52 +0000
Message-ID: <22E267B9-BA8C-46BA-A76E-A7A72FA5D9B3@oracle.com>
References: <20230105121512.21484-1-jlayton@kernel.org>
 <20230105121512.21484-3-jlayton@kernel.org>
In-Reply-To: <20230105121512.21484-3-jlayton@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SN4PR10MB5541:EE_
x-ms-office365-filtering-correlation-id: f4438c66-22a8-4b54-33eb-08daef27c5e2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XdL2V5TwGYI+O+iGlQ1o5Ptb2Xe0nu1yl1kvQ096er/8XsnDI2bHqBa6CHGB185RYL+wZl4NgBfaWl9GSwpACD1GsmOciy+DGfUoAi+O5zmwgQ07VdqjRAkhcr9kAvCl7bO5QoPp/lz2FiT74O2ip0RdXjOOW92j8hhyKIiOSOrfqykfCsOKirpQAiMo+k2SqxBqaAYfwJWK4B/miBEOkHDKtQZ+toFN1A2DjxGLzySTv5UoCENINngVw2/ch2haA24sLdcI0P6jlaiAG8XLL5CJqC87sT+gUaBWl9TV483OIX5uOWfpmB70L0qmk4py5saksq/lyqCdzdpSo3yWX33j96pwApTDZXTp9yOkK/m7rBLsFD7Q2wQWVPY9WLibQ6DSUdP5rQvrGVfVrhdsjXiNpo4MVJ78W4rmtJLd58WiiAbtWNAUGYmsZZZMN4z94rfWVubBuZ9XsrBQ821gUbgaD7Q/tn6MKP/BYCni6itIzDF4clmnG4WJejzsqg/lZw8J0Pd34AYCNKdYLU60SM4c3mHjHO75mnIX5Mjfk95c+F8sqmiCyTni2f+W0cuYb0inugFKfl5w+77RkeHeOgy+roII3JSs6Ege0rJDu5xX/gpWftnMLjcXs94DHUjBPN431cQrDhcuxgNn9sufcN0wrPilF8R9AQwcNkloD58AVNTnlckXlH57pp2Ura9aMDDiy8hPf8+NNd9yjf3HZBSnAPrSsfKpHVRz3Fo+0afAC1O3nVdtCeQYVtuX/bGk
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(136003)(346002)(366004)(39860400002)(376002)(451199015)(86362001)(41300700001)(6506007)(122000001)(5660300002)(66556008)(53546011)(4326008)(38070700005)(6486002)(83380400001)(8936002)(478600001)(38100700002)(316002)(66446008)(71200400001)(26005)(186003)(8676002)(64756008)(6512007)(91956017)(66476007)(76116006)(66946007)(2616005)(36756003)(6916009)(2906002)(33656002)(37363002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?n5yA8s+jIp2hkKgSFAKYv6GlgMvGTsqPp9UK0fb8Z0KNXQLkurqQskdcrPq2?=
 =?us-ascii?Q?b2kR+EiaiavbptiWYDXZubuYrcpKz737IHaBRgRoXmHdbGAj4jKTpekKbUaP?=
 =?us-ascii?Q?zXG3uUdN/zTJ8O4RPJQsVKC+x8mMCYnb7MkIRRBm6CxD8dMt08lLoZWzQA9I?=
 =?us-ascii?Q?lp74voa4Cr7TSMLBrkXmM4KNexxTKWNoC33l2AzRbZjBnLzDy15vs07UQfib?=
 =?us-ascii?Q?iuPoyzJRMc3CUuErfYdyMVr2eqLswn6G4LvRs3JfE1YY+wlYYqJ2wLHeDzm+?=
 =?us-ascii?Q?ZTiHDR97pqxfNk2iEsYQKFFaOv5cJ85NjBbmG/URU2pWe5Z+gMeRPLFkHvGj?=
 =?us-ascii?Q?awyyf9+5DMadzSMv/OewgHwFGIsRwMLDeoRaHg3EXafcAT3I4pgVMjF4cpJ8?=
 =?us-ascii?Q?arMNiC71xu1mTqBj/OwbjlMRZ+Rquc6trtMnR3W2H/kiOpnNlJu3fYwmCp/v?=
 =?us-ascii?Q?O5Dy9HJiFCHreUAHyv3ZLlwnKb46G4HBKYHoST4QMAKTE/sQHxhFoGk1l/SG?=
 =?us-ascii?Q?mbavUoT67qLLR6XlmiqdnQIPrSskK+Ao7OMELTiEIrbbbDnQ1fSMXFr+FpoV?=
 =?us-ascii?Q?p24ClBV07OI4cfQHj1TjxWViNomtZ0om1p0XXahbdz2T+BlnAe1QvP+eqZFC?=
 =?us-ascii?Q?vxwCcqKIKGDPYyf1BAdfooU85vWyoMOljaFQvwxzVxxQTlhlHyT1oEyNMwWW?=
 =?us-ascii?Q?UYneGbf7raTn7PfxRYF6bOxcrVYoG0nbFkJnCe+U9swC+h1lB0aWMevSDVJU?=
 =?us-ascii?Q?OsCqxL5n1AmOxWS/6gyZyYe6xbFwPb+dG+iyfaS+QF5rTgPpcVRBnZseyCQU?=
 =?us-ascii?Q?gx/40lN51geGkWxjXB5yX3fho1FZi9iz/OSS/2MxcVJDLKwFLKmCoS87yqUk?=
 =?us-ascii?Q?zK8ODgu+fhwFCvAsrZ+LLDMds/4ncCBG4oNGjfzoCaeANX2fUW0SU1LSW7I9?=
 =?us-ascii?Q?V+gatfxnqBA/Rxm8DXoW4MOjuQWqzhpr2FjwGkDy4im6GAs7aSFXLhi2oie8?=
 =?us-ascii?Q?fS2K2v7NlZya48fIYbksNz2nXGnyJx5QAJjXV+eq8Z9dmGHwDQVv8NPdRA87?=
 =?us-ascii?Q?71apTfqoFNU5n3T2ZfZF6D9HKhRMid8HgOdanaH/sSaIamAF0OgbrQYb0bnq?=
 =?us-ascii?Q?iqH7KNmX27S6GPnWh/NN0KGjffic4XhPDmxyKHK23a2EDODjXGSD/uJBSBPj?=
 =?us-ascii?Q?db2lPy5ALv17Zhsowz/myTAOxnht0gkkA4CRndjMNl+RRbjJHXT3bOJcDlxp?=
 =?us-ascii?Q?IZ9bOJgg+HuKq2M+CbhcFzLENJ39vXKe8zU6t+zbq5MjNJwARsdjZiXmoWwG?=
 =?us-ascii?Q?+RL1SeMwFQhZ5usQ3gde1RTXQ0wNetf7zWw6oDcBylqaAa/Ds+ZcBgak3wpV?=
 =?us-ascii?Q?M6D7xwZzrhoMmeP30hYvmPfzWYc75ccwaKiyGsgDgAY68bLT0kp9Bw6IbRU0?=
 =?us-ascii?Q?8SqwU0kyE54Bcu3L0JpdyNrbajwY6UM6sJHT55Vhyatxdx5UypPEmgtRBJDV?=
 =?us-ascii?Q?R4UI15CBsdS2x917A03n2POoLbcp4VYf1gskKGWB1rKmXvrtkbMrhPiLY18u?=
 =?us-ascii?Q?2b4KL5nwRBcZnCmyrRo89VrEuEvXUbvSIeLcEGlXrLy9+UNk1bAW2J8gohxE?=
 =?us-ascii?Q?qg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <342CABB23312504EAE59453323B7B533@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: b2gawy8YONXTKrpRmJ4nK4QH0an4B0VR9y2UIScF59tXsNUMPyVi62mS/bROuuK2rsU9pI2g6I9WJ4K5gyKvfggk3kwxIp6uKpHq6Mb5tEdhdTlfH9KWI3xQymWOvbWMZliJRYmzuSx3SB8qUDSV1yN+h7bUmHN9t1xG4KEpg3ZNSX4Ha7yH/x64XwY52oom5Hjh1Mudx2QbZCDFzJ5XCRcvTTvFlTlaiillCS6qCfV0vN9sEw8k71bDQenvtCIsnonGuycOX5N4uAytEwE4AxLUip06I+Gufkl/lSjHfHI5pGBUzRpT4Ig6j6bD9OnVdqnuf4aadvrjRtwYb0/ptZvgiGhs/DiWNYwQPW1827rN7UAa/G55OPGIrvrukmbY+Juj4wKbMR9p/XXijP1pbBaFeR47pSi+RuMfbdRQcpylfTeQCwgb6o+MuhY8aWEGQEI/02AmW2hCfXEhEP1dKChz6WajhX2aUycl8guPXd5iOb8xqYVDKOGq+Wcvu+dfNNQ9ijJyzX9eix9SIuwDCR2xOLqaHxPu0yDG/sKEOP1qyddF7oViuiW+/fMmuM7LqaT8a574W3VizSZau+qKakHrpGtBdcmYiI2lVgR9B9FHTEIwVoCHKCOVAgw59QrqjqsHtAcM9FhCY4q2mpEMl6nyiCTEb7ng8ScWbUwvukZq2tPMdDL1Qu7+o/7jEXnTO68nfFjvZGsXLuw5ObsUNmUxGg1TR8j8t9R7PtDPlDHMYDadhAiedNLvdTyIxFxVCeVdkvIvfwjNkS0GAyHYxxk4D6e5NrIZlTO5plVPyno=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4438c66-22a8-4b54-33eb-08daef27c5e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2023 14:18:52.8576
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EC6oFH/XBS3Wuef3Ac6VAtaCv8FHCQrwOWz1dhk8nAZhNP2VW2DNVKpFrDptjyE02teeLYmI2nky2Fh6GzHtrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5541
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-05_05,2023-01-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 phishscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301050113
X-Proofpoint-GUID: 0JpphyGahzC96Vt9cufCd1Cm1kNi-lA8
X-Proofpoint-ORIG-GUID: 0JpphyGahzC96Vt9cufCd1Cm1kNi-lA8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Jeff-


> On Jan 5, 2023, at 7:15 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> Since v4 files are expected to be long-lived, there's little value in
> closing them out of the cache when there is conflicting access.

Seems like targeting long-lived nfsd_file items could actually
be a hazardous behavior. Are you sure it's safe to leave it in
stable kernels?


> Rename NFSD_FILE_KEY_INODE to NFSD_FILE_KEY_INODE_GC,

I'd prefer to keep the name as it is. It's for searching for
inodes, and adding the ".gc =3D true" to the search criteria is
enough to show what you are looking for.


> and change the
> comparator to also match the gc value in the key. Change both of the
> current users of that key to set the gc value in the key to "true".
>=20
> Also, test_bit returns bool, AFAICT, so I think we're ok to drop the
> !! from the condition later in the comparator.

And I'd prefer that you leave this clean up for another patch.


> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> fs/nfsd/filecache.c | 14 +++++++++-----
> 1 file changed, 9 insertions(+), 5 deletions(-)
>=20
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index 9fff1fa09d08..a67b22579c6e 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -78,7 +78,7 @@ static struct rhashtable		nfsd_file_rhash_tbl
> 						____cacheline_aligned_in_smp;
>=20
> enum nfsd_file_lookup_type {
> -	NFSD_FILE_KEY_INODE,
> +	NFSD_FILE_KEY_INODE_GC,
> 	NFSD_FILE_KEY_FULL,
> };
>=20
> @@ -174,7 +174,9 @@ static int nfsd_file_obj_cmpfn(struct rhashtable_comp=
are_arg *arg,
> 	const struct nfsd_file *nf =3D ptr;
>=20
> 	switch (key->type) {
> -	case NFSD_FILE_KEY_INODE:
> +	case NFSD_FILE_KEY_INODE_GC:
> +		if (test_bit(NFSD_FILE_GC, &nf->nf_flags) !=3D key->gc)
> +			return 1;
> 		if (nf->nf_inode !=3D key->inode)
> 			return 1;
> 		break;
> @@ -187,7 +189,7 @@ static int nfsd_file_obj_cmpfn(struct rhashtable_comp=
are_arg *arg,
> 			return 1;
> 		if (!nfsd_match_cred(nf->nf_cred, key->cred))
> 			return 1;
> -		if (!!test_bit(NFSD_FILE_GC, &nf->nf_flags) !=3D key->gc)
> +		if (test_bit(NFSD_FILE_GC, &nf->nf_flags) !=3D key->gc)
> 			return 1;
> 		if (test_bit(NFSD_FILE_HASHED, &nf->nf_flags) =3D=3D 0)
> 			return 1;
> @@ -681,8 +683,9 @@ static void
> nfsd_file_queue_for_close(struct inode *inode, struct list_head *dispose)
> {
> 	struct nfsd_file_lookup_key key =3D {
> -		.type	=3D NFSD_FILE_KEY_INODE,
> +		.type	=3D NFSD_FILE_KEY_INODE_GC,
> 		.inode	=3D inode,
> +		.gc	=3D true,
> 	};
> 	struct nfsd_file *nf;
>=20
> @@ -1057,8 +1060,9 @@ bool
> nfsd_file_is_cached(struct inode *inode)
> {
> 	struct nfsd_file_lookup_key key =3D {
> -		.type	=3D NFSD_FILE_KEY_INODE,
> +		.type	=3D NFSD_FILE_KEY_INODE_GC,
> 		.inode	=3D inode,
> +		.gc	=3D true,
> 	};
> 	bool ret =3D false;
>=20
> --=20
> 2.39.0
>=20

--
Chuck Lever



