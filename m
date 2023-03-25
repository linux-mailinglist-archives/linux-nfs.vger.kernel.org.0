Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED24C6C9076
	for <lists+linux-nfs@lfdr.de>; Sat, 25 Mar 2023 20:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbjCYT1m (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 25 Mar 2023 15:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjCYT1l (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 25 Mar 2023 15:27:41 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F5A430C0;
        Sat, 25 Mar 2023 12:27:40 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32PJ9gpG005643;
        Sat, 25 Mar 2023 19:27:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Cl8AdA6LHjt6KDeAu8CDHcce868Bf4rcqVoNnpBXUc8=;
 b=OmokZVhAOpT3f9nmepsSQ3yBj2Cmh1GXNBO1kmZdorVhlpuHtraGwYo9Fd+pBuYmhJoN
 gq2j3pkm3HSgCUG0FugQfJic5mnDufOueZjKJV/OGoLI7lu8pgzXTm4XM0BOlo7S2ZKy
 BY7QU50sg1u4wgp9lzRS17bXeMiMhFSAzpGLuMnZk5R7oy9LlyAili7K96t42786/Okn
 gEqN+alJRMDhpkTxFhVGb0MvzY1Hc6x6UMTIF8sy5+1D8CnArs0x2F5MbSUHp8Jh5riB
 FdVzxo2m/XRYzc15rcYdI2e0nMH0tgiX1ckQF5m4Qq2KH5NIAJRKxWJAaoUN+IKj5CJ5 DQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pj6v100g4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 25 Mar 2023 19:27:30 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32PFfq1L005453;
        Sat, 25 Mar 2023 19:27:29 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3phqd38u1u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 25 Mar 2023 19:27:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VwGBvHc4vtCKU9mOKFmM+2sPRg48cFh9xA1yzNGkoi38CvzSLcBVGx9oWudNF4XMmqLYTPqI4oMKVe9zxZQpgPLiwcyZtzNbgxNPuh+3weE3LkFOSjtOxKpk/EJmXBQ91363yFSVRDFtDxuLBdhvKo+NChCYa27/D9yCSadFHkqke7Hue2u32p7reg4LrUh6USbljfgT/DDRiqPfd6wLuBJrSZxQTNBZZ7JTy4/BBXGhevLq7of2mXXhh6uovVq9FD0pGGpkSVTRbIna3bfqCp30BavqAPFjn0daKoig9qkNasmg3uyhuvvMmqs40OG8hlv5OJeLkxBbK1zPpvh0ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cl8AdA6LHjt6KDeAu8CDHcce868Bf4rcqVoNnpBXUc8=;
 b=UH2gwDGFuf0za+JWSVVpYrJIYdzhXdaeaAMhl2Ta7Xt+zfyvkC66qjOwGqfAk4lrKc6XM9adbV1leC8k8CrAeTPBvfG5GnMYAcgrj9DOIvEMBkQdo/4C7LSGxn6n4uy+ji8lN7NdaDAoUleWBvZT+bEfwioyzOHRsL6+5d4EfTHFIJRD1ig6H7DHQ3bB1/8dDrYyFypZVrtm2YZc4+E5rwBMkrHOmS1FM6xL7GmywYwNS5DyKD/oVBHt5oZ62G4SL5IKTHDOxiBH7opu8ahaXMsQrO1nbQVLN5xAnrfWUuR+zlmFEWnxPLdJt5tuKM+5ucxEKYFBuUYNDnBj4/HO1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cl8AdA6LHjt6KDeAu8CDHcce868Bf4rcqVoNnpBXUc8=;
 b=g9TC/M7lY5mLuVpPeYLQEKCmJ2nIxDftRqIDtGG+YrKxe3651NLeMFPPCB0gn7CiM/jmcvrOXP0zsWrHwjRg2b4HGFCnWIMnYFTCbV4lUDFZMAuCNvOCf8jSH9SDzPQY4g0WsmWSR59mn8qxzFN22PG2QgsvOxLwwYZxQ+ctVnk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH3PR10MB7561.namprd10.prod.outlook.com (2603:10b6:610:178::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.39; Sat, 25 Mar
 2023 19:27:27 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5c2f:5e81:b6c4:a127]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5c2f:5e81:b6c4:a127%6]) with mapi id 15.20.6178.041; Sat, 25 Mar 2023
 19:27:27 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>
Subject: [GIT PULL] nfsd fix for 6.3-rc4
Thread-Topic: [GIT PULL] nfsd fix for 6.3-rc4
Thread-Index: AQHZX0/VhlVAD0JVPUyUQaF4hfdpfA==
Date:   Sat, 25 Mar 2023 19:27:26 +0000
Message-ID: <72D3CC33-6DD5-4AC0-A33F-DF91B79AEEF6@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CH3PR10MB7561:EE_
x-ms-office365-filtering-correlation-id: 5822fd69-4593-4ac5-0b0a-08db2d66f7c6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l8pPWVFSIsebLw0DHgWkydy+pQn+OFOBB/ulH1/PvZlE5TRyW3B4UonWG1BpW0sbv2LOZaQ8sdmJawoMlLUfFwTn+zO7BSe0PwY2zxFoUXL4gSYJEiT/ECN9jIDNRSkowNxzVqMgKVIBu+dY043BS9TKFwLzfiOb6afmLmSJ07Os6wuK+VoxMbYEgSBOPcYfjetR8Py+FAsU6YAviLp5OJbivLkow4c0ZxN4ZLmvDeeyrKPYSHmtIiN8Spq+Ik4H6/Mu9pP4TR4g7WDmzB2XRnkC6fC0PFVUAriVQKufE9wUFxrQDv2pdQ7DRnzjsI322SmKOrfAyNE6Ywj+dQzjZWr2exIS+9n7YPTVD2hucI0KED8NAsC6wnZSc/+u/p9BJ9VEnZ/UP8F3G7WlYEqNTIy8oFhn/9Vigxw6iWjd+iO0c+d+DAuMZvWahm4AZ07o57FjHpVkcxa1j/znJR/VUDG17c6OdVShG6/aeEYZ/6j5ckgZITYoaIy2BpJj5v+7wEBfA8Lgt9LjS7pLb2MrFZItperYJ+IOaCL46eErwxzszef3s486C8RgK7mYStaxchO/wQrTDcBFvLEcgZitOQgerRFbzuT4pEbpwAq4RuOaWzDf41X61r5FKIex2ojR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(376002)(39860400002)(366004)(396003)(451199021)(6512007)(83380400001)(122000001)(71200400001)(316002)(33656002)(38070700005)(6506007)(86362001)(2616005)(186003)(36756003)(6486002)(76116006)(4326008)(66556008)(91956017)(41300700001)(478600001)(8936002)(66476007)(66946007)(64756008)(6916009)(2906002)(5660300002)(4744005)(38100700002)(26005)(66446008)(966005)(8676002)(54906003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Q55pIzZM9thUeK8lxsH98dlwYhK4lmxHL+n+OrZ5DGtjYkWeiVrS/+UYCpJm?=
 =?us-ascii?Q?ePzE2ga+BzCR2mfwZcrkJs4IK7xeDBgt4fBx/KS5s24C+vLwr32Sp2TAyN8Q?=
 =?us-ascii?Q?6BiCTRZGVzCIAXEu2tHMZgAKnng1Afc7HNEfW7wSmig3Z/nmQkeUwlMLazMK?=
 =?us-ascii?Q?h82M4DW13sB4D66tUWTzl5AcGFjfc1hC65dxGpAftJCIN9sLLXmVB0+zw1sJ?=
 =?us-ascii?Q?o3koEB3HfVV+C+T/UeSghguTtpd6Sbdevb2Z5FP2MtcvRWS+A519vOqP8U1m?=
 =?us-ascii?Q?Syu7KZR9sHXR9WUCPJuo8Ab7dsYu1bWOMxiEUNexnlLWUV4aty70k9V/9uPR?=
 =?us-ascii?Q?5WREvY/jqt1DQkL1e39vR3pEBmxKREsQbsPusE4UbxdzAResOkgc5Usp8p5t?=
 =?us-ascii?Q?3Z0PmNJYkSdp/hJlMLRIImaKglA9SDoQNRvMsNDHgVzQW3rnhZrrrYZun4z3?=
 =?us-ascii?Q?37W5G3Dmfp34c3jWgi2TLRBxdP244G8P4Aop/PTq5Ss/6akESRiN/xehxn2s?=
 =?us-ascii?Q?4NqfQeXAnDDR2Og8y8kSEfRBUlPmvFQd0xs2FEp6hmwijYdO66Z48oycTRjJ?=
 =?us-ascii?Q?3sqUs5cIhAN1BjLuQK1XaRT3/oQAJ3WEp+GPhE5BsYdDl7nTd6WzvcXgiKuG?=
 =?us-ascii?Q?mZYFxojiH4e8mQ3ecyB4Q+nfUeA0Zr6Sc4SoOSpRi+rrWl8/UAKqFU6wEz92?=
 =?us-ascii?Q?km8QL/mDc+ofZbC+wD18WvqIdumv5FUAL1Jzu/73ypstgBSykWr06rKn1AZz?=
 =?us-ascii?Q?oaZP4hnQ/9y+DMpxuEPoXuAu2FTAU5Ueb5rOQq67A06iDjqs6CbPHMW9iYTl?=
 =?us-ascii?Q?CFnHiz7HqhvlTymdBst68p1tDOzVGeytmkIuWhvtL7Deuw33pe8QXOSATwlM?=
 =?us-ascii?Q?ctyI/sdbf++EafO2VIzqC3PdIy32vsNdzgYD2pM9/OxOM7uDEybkmnCmrK5I?=
 =?us-ascii?Q?wROVXKrJY7/sNmpiVNetuGZVBN60QuH0EP8EOW7dLJywAbRV0VMcV0nVieA7?=
 =?us-ascii?Q?uZSsswAQR8lZ1A8CuRMdljImEos1vynOcYQlZkn2J9xnVHnKAedJp9iNzYXV?=
 =?us-ascii?Q?fNjT823eCr+wQ26Q3IdsfGu0Z0o4PBYn05UnAHcPh1o2cMJKufUC9LWXTI7u?=
 =?us-ascii?Q?m84J2aHLF6yjTwN4P1Qh/kSB3HnD/oCdmH5Ak2tkXT140a5DPUCNDE2gi1eL?=
 =?us-ascii?Q?Z5D3nNfXuwNxtPDX56dt/EK8evwucsMuTemTyaLFc/nK7bY+IihDMTc+UFDe?=
 =?us-ascii?Q?ExnbBx65+sVCq1M37aq2To7cn0ESemRALP6+drpUemysysQC8xEO8OqkKd3n?=
 =?us-ascii?Q?xallMPBv0Onw/fw9DHIoESmnhOu3MCXMpxyCa/aUGItzhwr3TNGasjmwokLh?=
 =?us-ascii?Q?o/c/V/zpAt/jKqiG8fxacrUEy74st/1Lrf/25qNHG7BxSqmwuE2GKKUnPK17?=
 =?us-ascii?Q?qHxehZEf+mFttB7VTlHhWX4LNqDKJzvTPdfFcvcBrdPLJ97DfTQVrYAvBSj5?=
 =?us-ascii?Q?AvC0FhF2n8xGN7aHywzbjtTILTGRXKbMIQnoTnf8zIUhLLBipz4OYhybEmPr?=
 =?us-ascii?Q?ja+frSfZR0QJyxUzBu9TKAhiZ+ONDRXbP52KEXSe9fWduMee+vqLsszvAZqk?=
 =?us-ascii?Q?sQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <99108AD2EBBDE84EB9DC106945ED9F0D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: dUSO5xwjLrFI3HTec7o14cEWJbx5PvdB2Ilu4ay7+n8qPgeoO7D3r44+Q0kMNOLGTuiq4iz9Nny5E3yKRZgc2N4CYiDaiBM2ERoFvBZFAspx65i96Cgr4ixD3U61zQOvnHs3j7q65syyO/aywofwYHNgDYjAyQyhSbbG6ClnrVCaKdP07IyQ/9VR11miO/10NTsOK9UIxbgl/RMqUqYmc3spsqvSAzUzY6+oIOxGzU1BtYrv/Bk1CMF3bqQAPh4L9FpmJSVD9sn8JfKPu5C/9mtV467DQ6OAq80KrC9HtXlQOyPlnK2L49njDZqjm8docyYJUH//ta1ag+wW0TEtELqrLfhR5N7BUJ0Z4eZeG7O34rgbZki/HMlFro3tozEX4feagSXVG8i8hBx+bihJz13zpsqhkH5gzLtDu0Go3OC3jnlJ7XCI1726R2ZOzdBCS9Nt6pyfV4Q6FWMGe6j/PL/Y2K6ywYRFrBzOY0a5AjRpaKPPsfs0olz/gkcnkSvB75HFYn9GL6ujxBqBmh6xCLlMfDvsRaJdQfEOPVWjmG5ogrTNCtILNmEfhu4lopCCy618S46XiFpNyIaDb9SSRQjsj92WrLge2BsmiQycVYB96wc6ybmD0IX/IddYZyeJSntBT62BjHnwVnOqZ2xu8lFYxz+nYF5RQm/xtc+PI28li2ClQjv4F7nVhzLrSVyp96WE80R9Ltu9mBnqcR6iEuF081unfGp2QySDMrPEiw3pLAdgE0qGxvlo7pLJLsP1lN0ZqOtv9ovWWNhIgyaqXBWx+RJeQumNMjl3SPj1cMP9IiasYr3kiBa955vsnRqhg6VB8jCUXRbp1VwJQRk7Os/8c+1RxqowYOV4pz1CHeA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5822fd69-4593-4ac5-0b0a-08db2d66f7c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2023 19:27:26.9296
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NQUP1+FvWXYYJfvEQZhFa6gJllaDofKL4aEBU3IBq7EbhtSPhoUB3joy1m+ms82+llQOjnvzExXl2MhOBU5nKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7561
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303250160
X-Proofpoint-ORIG-GUID: 29X6KEzLuXBo6KMpilQbXAMdOf8Chsey
X-Proofpoint-GUID: 29X6KEzLuXBo6KMpilQbXAMdOf8Chsey
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Linus -

The following changes since commit 27c934dd8832dd40fd34776f916dc201e18b319b=
:

  nfsd: don't replace page in rq_pages if it's a continuation of last page =
(2023-03-17 18:18:15 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6=
.3-4

for you to fetch changes up to 5f24a8725fe7bc2c6adf7ce00dd3e818387d8995:

  SUNRPC: Fix a crash in gss_krb5_checksum() (2023-03-22 16:58:26 -0400)

----------------------------------------------------------------
nfsd-6.3 fixes:
- Fix a crash when using NFS with krb5p

----------------------------------------------------------------
Chuck Lever (1):
      SUNRPC: Fix a crash in gss_krb5_checksum()

 net/sunrpc/auth_gss/gss_krb5_crypto.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--
Chuck Lever


