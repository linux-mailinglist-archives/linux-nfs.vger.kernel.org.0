Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 868F662DE8B
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Nov 2022 15:45:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232841AbiKQOpW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Nov 2022 09:45:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240407AbiKQOpH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 17 Nov 2022 09:45:07 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A308FFD0
        for <linux-nfs@vger.kernel.org>; Thu, 17 Nov 2022 06:45:06 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AHE4kSN028265;
        Thu, 17 Nov 2022 14:45:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=c5ifzYaNwxvuPIJ4DpeJjycZ5KNQLREVHm62zR/PgsA=;
 b=Qg8ZxxUW9xzizRIoopWYYPUcydzALlQzzTnemMA6tuBS2lIbGRpbiSp0YiTHmMtRkcSy
 eF/U0c5mO8BA0GJFAQ3wvQaDHC5u41qXtKGBs1RjwMq0cPLn1KjqqaVQ8Y+CgYTNNoyb
 662UUcnWzZnrFXzp/HhC5X0eq5btOLPc/09UV4F8V4ToLjbBBWj51z8bgEhtylKbOU+r
 u8vUsXerXKFnhUgHJYeQpK34I85+WjukKa7zv2PoYedzoB4Xpo08k2zjGqSTl+jyeqQj
 K5xPm60DVwBCIKQQ33bRQ1o9sScRT8vsBQ5VaQLqDsdobHzYCLg5B13ny53leSvlmSQk Nw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kv8yks4f7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Nov 2022 14:45:03 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AHEBP2S010758;
        Thu, 17 Nov 2022 14:45:02 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kt1x95a65-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Nov 2022 14:45:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RxRGMMkCyKQWPkPOP6QcjXoX1loUEM6Y9ovHvGt/BokQSqiQK0dEffmKsGZjrozxJ/3f1dnjQbiav3V1GwCUewjt6iwPYP6PwcydV/ubQkPi1UcdZbgCAh12421Gx2pN6UnXQg0WFoi4OFjTCcZzT3bJ/q6BNO4A7AmI8HRmkvl9vz3gKstEFGgW9R5wMkwLi18Rerg++tagaDwfkW6QDL6kKZm7S5eE+K+phjFCA7mvUOtHhMQ4uXNhuFxE54OkNiXew7vaz/hSfZQ+Mkr33JLNHx292V9wFGYXWyXNFHuxqvbLtvz8qky2ol4kcn2xg3kOLndjSxU4ylt8C8NKYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c5ifzYaNwxvuPIJ4DpeJjycZ5KNQLREVHm62zR/PgsA=;
 b=Bhvekx5JDjmN5pwF1x2PT+MTqqPVdFcZNWR5M6ANhX2dE1qQVSVBCCsEtp5exFROE7++ptvCMNnEwhxQu6/yC+6UxtDgSRcSZOG8UZXzNLx8oTUuCDBniEPh4Ed/CUNI3ogUvTNcAzrV5CDdX84dKj5DfAhWukg/xN1Cbyqy7nvz/GcwGFo5rv+UWS5wkrCqXGtLxDQgFKYsNZF29OUzOQA1waa3c5DWvKRAQaQtQxJEMmwsPD3IioMRZQ9mIvt2Jk7wE+quukDvHyGh0l21LbnIk5skrOtZ0X3FuuWDDdXJ3HE8s+t1yfJ8IdhCY35XK+SiGGzTYr8RTnDAOsWx3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c5ifzYaNwxvuPIJ4DpeJjycZ5KNQLREVHm62zR/PgsA=;
 b=KbX213PIPncl6nglDutWOsvBlG9+P7KTPO0LfP5MEY1tH8xcBEDF7feVpobH06jqFMaco+Py1TNaMy9w4OkoE5ao0eT6xqN/k21pGWpZHj7D24yUqtcHUeojwx/HlkbRI6h4o9etAHd9iw6tzeE4J8a1l+HXkiImD05798wanW4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA2PR10MB4426.namprd10.prod.outlook.com (2603:10b6:806:117::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.20; Thu, 17 Nov
 2022 14:45:00 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::b500:ee42:3ca6:8a9e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::b500:ee42:3ca6:8a9e%5]) with mapi id 15.20.5813.019; Thu, 17 Nov 2022
 14:45:00 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     "jlayton@kernel.org" <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v5 1/4] NFSD: refactoring courtesy_client_reaper to a
 generic low memory shrinker
Thread-Topic: [PATCH v5 1/4] NFSD: refactoring courtesy_client_reaper to a
 generic low memory shrinker
Thread-Index: AQHY+jb36XA2Be0450iJEIXwUAubRK5DMegA
Date:   Thu, 17 Nov 2022 14:45:00 +0000
Message-ID: <CB4F87D6-8B46-4D84-A7FB-B095AA1745DA@oracle.com>
References: <1668656688-22507-1-git-send-email-dai.ngo@oracle.com>
 <1668656688-22507-2-git-send-email-dai.ngo@oracle.com>
In-Reply-To: <1668656688-22507-2-git-send-email-dai.ngo@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SA2PR10MB4426:EE_
x-ms-office365-filtering-correlation-id: 362bc1b1-93c4-4c0c-49e3-08dac8aa4e10
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R4NCz6kNt6RYPON/fcf0USCW7+b7DLcglrhoT+Bd1ivbsRbnkEoAxB5Bui5e7iMREMCZf+oj+t3whe4X7jhGA9CM1EK/LhpUhwtCRVEO7j0+x6rr/wm03WMJdruuOdRrntLCnJLdMieoG8KEWDBoodwJAq1sWUAnHC/MnAsT7CKLfqw/TeOezx0+yYZKAF0aCyBwRym3hD7az549zl4VwUTWRra88Y9CxqLYC8yCtGNGy+Etf5jQqzdUze5eXgbiS3iSoTu1l/N1543fntU+mpvewhi6uHWi7YEVxwD3VTbi02vbP+KjqwhUShtsEHjlFbZQZhlGrryKDyJn+7/HpHna/Nl4Qm0LFq/6BulyVISs82jgkudThnv2IWXY608hpR8iCfzHklPsSkuZQTFZFhGNpfXWKG1lzy6SUCD4IXrF66ZaET9IUwko4z2nQUiCqm7sdo19bacmJRElGF8Hu/9oqGxSjRX3mHEwanDlVnN/bkpS4d3pxJ2BeXboe5sXxtqVoi/TsE6MIrthvebPwdOydrUR2l78MXCgL/WvR4X5BCVyMiC5caIQ2OHWr9v+YUyGRXZu9QU3HMbDkphtgI0YFzU5ryknRp2Kiw877OU49BiiHFI8XlTBvxJILFOjvrKAcLKUO+gDkjMzXcpFeXiE1vr7sdik1qxzp26viDAFfTL98HPwyRN6QlS7rxPKDcMCmHCQaOSKGGU9FKD5XhouLkDFKb8Xr7DxYbaphcDxxdT5sA4COv454L+5Bp5K
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(136003)(39860400002)(346002)(366004)(451199015)(2906002)(83380400001)(36756003)(33656002)(91956017)(41300700001)(2616005)(76116006)(86362001)(8936002)(38100700002)(6506007)(37006003)(54906003)(122000001)(53546011)(6636002)(6512007)(38070700005)(26005)(6862004)(186003)(5660300002)(8676002)(64756008)(66446008)(66476007)(4326008)(66946007)(66556008)(6486002)(316002)(71200400001)(478600001)(41533002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UeamdT1pF+wh2nSqhRPW3w5dy+/R7HYWwx8fwDKTF3ONlPci/qV1jIc/Ruv4?=
 =?us-ascii?Q?uhueOtp+Z+DIXKGb21ldmcE0N6UoeiA5k2q3hcxtlQuxHy3Dc52hJ3iPvywt?=
 =?us-ascii?Q?IO3dOHvSgNAqH55CiPe8OiGbBY2CO5y2+FxsGAGymwlsXAT4hb5X1lIqMQez?=
 =?us-ascii?Q?6jORr8q+yx1J/yd6Yu1m+CXyei0yHmsMYHYu3kniTIYiMxJtd7vn36xQR3fN?=
 =?us-ascii?Q?BimDzIeLMod/pCTpLnEoWSNj3nvenuj/cvfcfB7wkcRKoXQcuGTSC4Way+kk?=
 =?us-ascii?Q?p1GRKyI4YpsoVscAwKsYF8kU8Fj1asCDwj/IYRRp3RjdmTIJIgH2z8ohaoTT?=
 =?us-ascii?Q?0TW9vJotbXdcTzU+P5e7vjachIfN4aCGaC3NXT/OxGoeLRl5fBRwR9u23chI?=
 =?us-ascii?Q?fIpyETBzEmynitH1PKX6M9/e2yUIAWRYkSxLdjZfPZh0SRl2GpQGd466q2dG?=
 =?us-ascii?Q?RdR6dQ5xE0PzbYdWo/3T9+slzqzD4fMYhB8OhXVl60ihOP/wbvHlWKk5VxVl?=
 =?us-ascii?Q?F9r+Q1a1THq/Ltsa56caUJPvPOqVQBonsibOisV1dM9z0VzMl5XaJcy5DvIl?=
 =?us-ascii?Q?1xm1E3vQBERK+Fnug33k2BT0kvP/XfYO1is0PejTfpBuDEEUV7bbHNHJPelT?=
 =?us-ascii?Q?YGHPw1VDDtbMCcEcxLRfrmVfxP7GUgIN62uwXDqGJqtMfugRwf8ozTdTF5SV?=
 =?us-ascii?Q?/FmJuPCdjESzCq0Wa1FV6ve3not0aPasiqfGUfb3IA01R3GfvSyQBROdkgXn?=
 =?us-ascii?Q?0V1jvNFZgjontCOaSH+fXzomDat5x+EPLs4a9XIh1uG+OEqUUk8AQA86HD46?=
 =?us-ascii?Q?RjppZwuaDlxu/2ggGsj2HQEuNyuAW5HjUJC/MKDnuFwh7mUG5DBkA/el48eE?=
 =?us-ascii?Q?YUgVuOOVk0zTrGPAZCN0yHy3hvy7fLIkBQ4lUOoCPMgzNipy8s5NMr0wJY5k?=
 =?us-ascii?Q?DeiWRmdKya3EsbaSDiC4LlANFnRXmAoGNhdx05wtqvUnSisSJhAmL/uZa92T?=
 =?us-ascii?Q?dBrIcTGX4qCl3TPIEP7AO2LVTJCuaIBdrSTE/mG0bsu6yIreJAm13ZOOulL4?=
 =?us-ascii?Q?JJwYG3ujVxqVKYQjh1fyZDyCx+iQSjwsV2FCVbnYY8ecMVSNI/hz5Kgcb5Z3?=
 =?us-ascii?Q?BgBp0gbZ6hlHTAxlVCuNTfWFR/vYnAOVtTCPQxhH/C026zmr8vL27Lm6ocXa?=
 =?us-ascii?Q?9SzVcggY0D5vG9VnYahbTEXYg3Pl9Hcpq5m8oXU5HqnnZfj6bgrXDOqkGjuL?=
 =?us-ascii?Q?OJMahHHNuKzOmot6dOOE3rp/hYy89sc8Av0/QLpbBpAjyoYQfb3PCfBv1lJi?=
 =?us-ascii?Q?Wvq0lk9WO1WLhfgnuu0/6CJPUM1T8sykfPCznYaP+zlkDGP2xKBmrHkjgNJ7?=
 =?us-ascii?Q?EOlEYbuhQH5DJhGB7//MvySYkrS4TYNdf1xba5y/6z2mfNTmbayrbOsgLE0V?=
 =?us-ascii?Q?fzoFYS8tQvmhHKjYbNJS5XWOYD8u8IXHcYg+rGMrtcDMzjBu3jzJ8Ip+335x?=
 =?us-ascii?Q?1iwDb+i+HVee1FqXxITx/6Yda1HRHdkzmNH8550FbJRkEE1VuUIisMg6oYg6?=
 =?us-ascii?Q?5dZqgD+PTZXD3TqjK9KnvMIOFacFppzuFq2VP4x6w+ILjJQgxICTBWMJSoV3?=
 =?us-ascii?Q?LQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B1065C0543D5C54E8076852A6E0503B4@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: GKDerkxQRe/JKbL/w7jcUR3MBL4n86xqtrR804wYhF7XpwajVLPmESgDmps7l+NK+g37aziTO8ymsjmczO6Ts5jMQ7/pi6i3F4IQ22XgGOfwj+NKGpnT+163mvJ5RlcNgJGT+dS0tocKCDdEOApMldLixXWVt8IJ83LY9oWJLfWFcduGCwgEdFAS/QogT9G9BOR3U4wBdfQuWf9hWJDdFRKtQO/czZPkHOqDkFMpGdA8ncSYDTHtrlfShlYaV1/ZUgsZyvVUdu/BmtYnztSzq2JwFzy+4W3+LAO563kJoQDQg5IkUdeDslhRLUXHbp+W5u0wKoPn5byEuvPI8XUFsgQoMmIN0OIxfxJGw9N/+V5NdyEqtQbr1hB8/f+u1ZYvZK/fhSE/oGkOT3fKzJoFwcEXA1lQnIBWc5UoBvR4O45GKyGP1Qsz+zsRSzG248uKYcUodT20qRW9ZEFAwmf8NIQc3rTscv1MGxTTsXH4c3yk3ew2pq8VEe2IqD2/kuh1QcosHOSa2/WrBREK0WsJVUNMmDlIWOoQ1Or220wgVCqh5iOAsseOTwhJIMTF2qRWwSjAfYwYYC0AD/+vtXYfyxjNpApod0KbD+kmZLKk2LPSCXX2oy4pLeeSmAjT5Oo3SEwCZ3ZDM7pzh7B7ByQYJ8UYkmgVoq2ZreigBEZUKjSGbh7v5bnkVxMxtsEh+E9EdRFneKPjIwJ6O7VNRtzAM0K2/7SH5VjuWvu1rF82m8dFm45YippeK7xd4xKxu6ECGBd6s9dpfbVep1l2nHhnxRZOx5HUivL4P6uVyF4Ss9Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 362bc1b1-93c4-4c0c-49e3-08dac8aa4e10
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2022 14:45:00.5563
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5lCRhM3Q3N1Bbejj5h6a/q9+2CeHn5QJGhOdWAslIxxxQnt110yeVedjMEovIbeMCOwWmc0y8QUKlCWJ+aq+/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4426
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-17_06,2022-11-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 phishscore=0
 spamscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211170111
X-Proofpoint-GUID: 7wblE5F91Q_ILY74X2pPHUmlPLUjqVfO
X-Proofpoint-ORIG-GUID: 7wblE5F91Q_ILY74X2pPHUmlPLUjqVfO
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 16, 2022, at 10:44 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
> Refactoring courtesy_client_reaper to generic low memory
> shrinker so it can be used for other purposes.
>=20
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
> fs/nfsd/nfs4state.c | 25 ++++++++++++++++---------
> 1 file changed, 16 insertions(+), 9 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 836bd825ca4a..142481bc96de 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -4347,7 +4347,7 @@ nfsd4_init_slabs(void)
> }
>=20
> static unsigned long
> -nfsd_courtesy_client_count(struct shrinker *shrink, struct shrink_contro=
l *sc)
> +nfsd_lowmem_shrinker_count(struct shrinker *shrink, struct shrink_contro=
l *sc)
> {
> 	int cnt;
> 	struct nfsd_net *nn =3D container_of(shrink,
> @@ -4360,7 +4360,7 @@ nfsd_courtesy_client_count(struct shrinker *shrink,=
 struct shrink_control *sc)
> }
>=20
> static unsigned long
> -nfsd_courtesy_client_scan(struct shrinker *shrink, struct shrink_control=
 *sc)
> +nfsd_lowmem_shrinker_scan(struct shrinker *shrink, struct shrink_control=
 *sc)
> {
> 	return SHRINK_STOP;
> }
> @@ -4387,8 +4387,8 @@ nfsd4_init_leases_net(struct nfsd_net *nn)
> 	nn->nfs4_max_clients =3D max_t(int, max_clients, NFS4_CLIENTS_PER_GB);
>=20
> 	atomic_set(&nn->nfsd_courtesy_clients, 0);
> -	nn->nfsd_client_shrinker.scan_objects =3D nfsd_courtesy_client_scan;
> -	nn->nfsd_client_shrinker.count_objects =3D nfsd_courtesy_client_count;
> +	nn->nfsd_client_shrinker.scan_objects =3D nfsd_lowmem_shrinker_scan;
> +	nn->nfsd_client_shrinker.count_objects =3D nfsd_lowmem_shrinker_count;
> 	nn->nfsd_client_shrinker.seeks =3D DEFAULT_SEEKS;
> 	return register_shrinker(&nn->nfsd_client_shrinker, "nfsd-client");
> }
> @@ -6125,17 +6125,24 @@ laundromat_main(struct work_struct *laundry)
> }
>=20
> static void
> -courtesy_client_reaper(struct work_struct *reaper)
> +courtesy_client_reaper(struct nfsd_net *nn)
> {
> 	struct list_head reaplist;
> -	struct delayed_work *dwork =3D to_delayed_work(reaper);
> -	struct nfsd_net *nn =3D container_of(dwork, struct nfsd_net,
> -					nfsd_shrinker_work);
>=20
> 	nfs4_get_courtesy_client_reaplist(nn, &reaplist);
> 	nfs4_process_client_reaplist(&reaplist);
> }
>=20
> +static void
> +nfsd4_lowmem_shrinker(struct work_struct *work)

All shrinkers run due to low memory, so I think this name
is a bit redundant. How about nfsd4_state_shrinker?


> +{
> +	struct delayed_work *dwork =3D to_delayed_work(work);
> +	struct nfsd_net *nn =3D container_of(dwork, struct nfsd_net,
> +				nfsd_shrinker_work);
> +
> +	courtesy_client_reaper(nn);
> +}
> +
> static inline __be32 nfs4_check_fh(struct svc_fh *fhp, struct nfs4_stid *=
stp)
> {
> 	if (!fh_match(&fhp->fh_handle, &stp->sc_file->fi_fhandle))
> @@ -7958,7 +7965,7 @@ static int nfs4_state_create_net(struct net *net)
> 	INIT_LIST_HEAD(&nn->blocked_locks_lru);
>=20
> 	INIT_DELAYED_WORK(&nn->laundromat_work, laundromat_main);
> -	INIT_DELAYED_WORK(&nn->nfsd_shrinker_work, courtesy_client_reaper);
> +	INIT_DELAYED_WORK(&nn->nfsd_shrinker_work, nfsd4_lowmem_shrinker);
> 	get_net(net);
>=20
> 	return 0;
> --=20
> 2.9.5
>=20

--
Chuck Lever



