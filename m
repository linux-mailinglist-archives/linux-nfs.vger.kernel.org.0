Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF5F560C098
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Oct 2022 03:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbiJYBLU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 24 Oct 2022 21:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbiJYBKN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 24 Oct 2022 21:10:13 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11AFC1FFA6
        for <linux-nfs@vger.kernel.org>; Mon, 24 Oct 2022 17:19:53 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29OKpDWg010282;
        Tue, 25 Oct 2022 00:19:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=aV7P4bbM315GwSJLVi10umDK1TIyN8KuA0UuV4oM1oM=;
 b=SB+0UHQcWiK0raYSfWxYW+yMxGEIzsVOsDPtHFBhbq/D7JdO58iwTEGONl6FVsn88Xwe
 SK8rAQTVqxg0kbYaLbmTKRCwisxBVrgRGLKDLhtFtRy8ld0opbuBDA7FpDHzoowOGlbT
 ktd8DC8w8QCA4+CM0zoDdxZpjaHtMDezGKvT7bNu3hj1X2hKlM/95asNwWP2y+r54mmn
 joWgBG1TFLidfv5+udJgSXue8An5TUFf/RuMl1DnWpP1vnx557Uf54xax4dMDGPYff0G
 iOGpIXl8mhoEW8KRuK6vsEHZuz/IOfrqeENMsWsfcUpb6Tsmoga8wlj+Z+eaCbqZvYF7 mQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kc7a2xrj0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Oct 2022 00:19:51 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29ONMacX014375;
        Tue, 25 Oct 2022 00:19:50 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kc6y3uxs4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Oct 2022 00:19:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GPxOzTEUZRle64MXJOwCz0c4K1+oN3q0MxBCX7pKMy/QnchfdeWJpmIYXzBc0qyVWdOe0Qg43x3eKmJzKjFD+jiMlt4xRIjTBZdurLovXYGfkAyOFAadj1LFb34PpIKZL+73tR6cjrTarAUa9nE9V0dHFXLBnPtITCxifi02uXARaErwEe+S+CD17P/9oolpJ6dob6P1BvJy0e5KlL7u2E3rY52HQgvfmpppe59Fzr7EdlBZC20fXeHRvnZ0vgDecr40Fm4A2zJUb3JzE46ExWnbe8zIesI5AyLyCO8skVyU+cHt7pHtrpVosIiKFQgKL1t82AmUveabEkZ3Miobgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aV7P4bbM315GwSJLVi10umDK1TIyN8KuA0UuV4oM1oM=;
 b=mWY0lFTDHq5Cd9sdw134aIYVBC7nvQFPivKWJ4WkDBvYcFWwJobSzstBR1UceBdLaRQtcCF3BwD/AMBTwA4GRrVjmj73xRjOYUHCLcVUEKB+0eyALX65+V07bf/bbH6XYNxA+sEADQdN9nmmG1wONOCFXq2fzUlP/jbiXV8okI0U30xUKNrkpnb/5+XVUWnA55V2iJxZai69zrl1IVxBXFbJVbpdTxkBUrWuAMpW05eSPLmaTCjJhjVETs5cpj+OJhp540rHdSpJqEkX6zgf+PgbM2qUQhJaegEV1B5ty1zj9BrZ3cvHAwdkCb3L3qvt33OtUHb3jS5uq7t0qdKssw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aV7P4bbM315GwSJLVi10umDK1TIyN8KuA0UuV4oM1oM=;
 b=NZY1TMAobwsxvphia9LiaLEZosD9s++cqa1jJNrxK3E83pi51u495i054LFIzUFFscpFjAOZrT7HPAIKTYLIYE6zArHdwdsRyEaMGXvdku22Un8UrJxKz47Dwvtx53d9IWqkDVEhKZTKySHEXXm4Ys6HzJPELkgFxZZUgm+AhmU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BLAPR10MB4945.namprd10.prod.outlook.com (2603:10b6:208:324::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.26; Tue, 25 Oct
 2022 00:19:48 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a%3]) with mapi id 15.20.5746.021; Tue, 25 Oct 2022
 00:19:48 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v5 13/13] NFSD: Use rhashtable for managing nfs4_file
 objects
Thread-Topic: [PATCH v5 13/13] NFSD: Use rhashtable for managing nfs4_file
 objects
Thread-Index: AQHY6AJxNlboIvY4vEuTvEj23BK0Oq4ePvWA
Date:   Tue, 25 Oct 2022 00:19:48 +0000
Message-ID: <4099E49B-869F-4E90-AAC9-0D02D76A9DE0@oracle.com>
References: <166664935937.50761.7812494396457965637.stgit@klimt.1015granger.net>
 <166665109477.50761.4457095370494745929.stgit@klimt.1015granger.net>
 <166665500851.12462.15192873887843652314@noble.neil.brown.name>
In-Reply-To: <166665500851.12462.15192873887843652314@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BLAPR10MB4945:EE_
x-ms-office365-filtering-correlation-id: c53ab4e5-5f27-4106-4cfc-08dab61ea05a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SCVu/CO+7DBiMRpPm8R0+K6UWo3SpC70i42Qw9P5Zp/wZQEJLT6A6y/cTwDCHSrNrp38PNOmYtPq7TPobwCYCjenRBHYJYrxMbrMZqiiQZly465HPlsHP2ykri5Dp8xHQ+ecfaVJebNV1q0Ce6zN0zDH/zLuzzFu2y3/XJTrsjIWx5bZvaUcQENNC2aoLPoeAZB6gN/ZHWsvVn3w9MXjk/UZ/dqotdR6YsZLNrqxdGmMebhJNz5JUpaWWceytaU/7RuHS4qiZikd0DkVfQUsteHpZMTrqGhK+arj2Gqpk1p+wm7nfgsez7LavDbYJgZM2piDIuPZGJ+MBVhFpBO93Cq0W8huEpfoXPhTMV4OiEKlM/0u6WzH5/Su+Q2JM8i05S4OWaF/CI0ihA+tGSGe73n+vEL5JoNHUe3rEJBKR5kat6ZBGnswZ8EHlQgSpwPc1LorrAaD6B2hIiC2NJaQzkY77CwUtyOBo/pZ94WHgjhHmmtnb6W0BPio0nCUwxOOAI4oqJiM6PLlU0uNA6YBoqNjW0c7XFK9OwvZA0yMRRj8CiGOdrhx+g7RBV+pUYnQoKUxhjPQJ4PTPZjC+b/SG/kP5Frqil89kLG6Z2jmkKtsF/jL/yl8xQmZa2K/Ee5+Y0eFRWkb6mfUq4BhZXbeTvafAeiKtFLuvbjOoHq7QX+gqUJC1FkLByR2ttp3BRMRB1IXW0Iv8uYV9o2bNdiLd2BorP5u+27aBkgqACUaJK8vO3ePqWNDMtK2KeOT876HMmnnIdexUEjaN+cJgToyMV3YYmTktmC86sFLwXc1+4bDQWcO3GAsEx7IXjL5PCh2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(376002)(346002)(396003)(39860400002)(451199015)(478600001)(6486002)(38100700002)(66899015)(71200400001)(76116006)(8676002)(8936002)(38070700005)(6916009)(122000001)(83380400001)(316002)(36756003)(4326008)(91956017)(66556008)(66476007)(66946007)(64756008)(66446008)(6506007)(86362001)(6512007)(26005)(53546011)(41300700001)(5660300002)(2906002)(2616005)(186003)(33656002)(21314003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kC7OXxwESZmmyx4C6AxnUtacVvshAJ5nhwi7OiCmWRCADVPjOL1bV3hrdTmr?=
 =?us-ascii?Q?y54OTqdlunmmFZzvWGMvBXCKvlcDt9HLWN+r44ATMDms1V7L/N9TH3sfKjp8?=
 =?us-ascii?Q?3GHtwdcdSbSwyBNCp8wEQCSOKdBH4JLfTZHIZShzHM10nwn2ZbwjSNMH0WI3?=
 =?us-ascii?Q?NXwytmuGOS/FaUK2E873BcTNupj00UqOWS0Ffts3XSAph613PDn1BSx69gTs?=
 =?us-ascii?Q?TpIzZZjqmx0TN7dWw4Z1C534lGLM6sF2g9eginWX5VbyMSCvmrz6TjKmQlVu?=
 =?us-ascii?Q?YPHjv9SQWtGeY23fnuSehtXja/ywpODpYZbQzeDam4gdbrJ+NENe8/uwqSpn?=
 =?us-ascii?Q?ERmRTpkaeQSPnHlhW5oAGaj3V3zlEhYTa5PZHjJK5F2FgzGZAywo/YQVFXEL?=
 =?us-ascii?Q?ORZ+xPDDtAS/J4uVffsFFSE7pFXxna54K3/src7C5xWH0+GZb7K8mk/erWuS?=
 =?us-ascii?Q?1koQlSHMAWNVzi3M6zQGv6NM3n0l7MBXcES6ev3LVQRFYoDAEzlz921/rFFe?=
 =?us-ascii?Q?CzkxkAkIkZIyhA1QZ7kX8FZAiF91xpS2YdxTs4KymE0CWcfsUgEio5bhz3TE?=
 =?us-ascii?Q?f0mszTIBSrdntAfKHNm5vRL1boFRRE27OdSRm8SC/VcAuULWCdNh7Z79ieJD?=
 =?us-ascii?Q?+kkFmZWvlYENv/i50FuM6EDY/q7UCvU3mtMNdf2835iWWAlOrFxRpmqWqddQ?=
 =?us-ascii?Q?5bKahbDjDD0xZ99xBm0fNt/P3a5Ha4IezoJTUbrWw+BuxCRDlak8VfGMmbM8?=
 =?us-ascii?Q?9eNOos8ce7HEr+5F6SgdXoqAvN9leAzN9OIymNwFjs72P4aVlnMXc+YWuMxg?=
 =?us-ascii?Q?C+b4jy+nWyLjz64NV6RZNIVynb6pG+5vGGVZ0ZWxzmk4PiSdXgArx4MoMfBR?=
 =?us-ascii?Q?x8/303vjfpUiVxvk8hzfjWp3Bo0ptaDAG657J+HhVgZvWF2NGkxGzdyN/kj0?=
 =?us-ascii?Q?FSAb9rnplfZIqVv4yRLQdH7AL2OgRTZamNFyJFIv6UHTyRmb+GwBMI1b8AE9?=
 =?us-ascii?Q?Qhwfu3ksbkeh+cKKRjba81Xlacq+DyXyaPC0crIlO0trZniV0QVlyhkc1JcK?=
 =?us-ascii?Q?ovr+x+iNfhn+I3tiGf/IzYf6A3ixqfLvKAiTfkBPZnbTduLBRzh6hfMPYqyw?=
 =?us-ascii?Q?x6bSVTKiRv/53RQCy5KSGo6gpdQ0tBOy4dt7gAv/A6cgJmBNiwmsX6Ue9viV?=
 =?us-ascii?Q?nz8KXRYD1JbC5GboA47gcPZsDpUaSMjcgBV95ODh963Z47grzsftUwjbybn+?=
 =?us-ascii?Q?M2lYW+AjQljlO368DJLCY9yY+m3jTBd3hR6iBRDjvSdOXtuMrKjAXyGDDdeX?=
 =?us-ascii?Q?KRazPZrOc6p0tq99J1xqLfHsvGwasv3Ldn9FVNnY8bkzGuD6OXPh5WLn52ii?=
 =?us-ascii?Q?WpDfNSyJYFITc074xjVeAvAM2CEd098bxYk53fvAEWNbfsneG34dLz5PqCrM?=
 =?us-ascii?Q?oijLlCOqmerQIMg12j7y5PWM5jFJ64EKXj1IaCWqIeUMhgswxU0c1+bD/ksr?=
 =?us-ascii?Q?u/vGgs9TNg3x/GdRynKvKfwBCg6RSc6vEcqcdIR8Xvtg6zMhWbh02vTDC/n4?=
 =?us-ascii?Q?+Q1ljzNE7p1kSAyoi8cO0Xtw+tLAwWfTnh3M+2XU15faIDESfSBWjuwfqC/d?=
 =?us-ascii?Q?GA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <726A7C21AF7C3648847FADAB052EB9EB@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c53ab4e5-5f27-4106-4cfc-08dab61ea05a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2022 00:19:48.1424
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5LyfPGXpnMJVX+nvUsnxr5RKsaK71OaxA5m2s9fiOLr61OtMdPC9AIOJ1geugqX+fkdDYuyYiAUj7oEIZRhOFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4945
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-24_08,2022-10-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210250000
X-Proofpoint-GUID: n8ihokHBDzlub7pUgKPcsoM5VWyvrPGc
X-Proofpoint-ORIG-GUID: n8ihokHBDzlub7pUgKPcsoM5VWyvrPGc
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 24, 2022, at 7:43 PM, NeilBrown <neilb@suse.de> wrote:
>=20
> On Tue, 25 Oct 2022, Chuck Lever wrote:
>> fh_match() is costly, especially when filehandles are large (as is
>> the case for NFSv4). It needs to be used sparingly when searching
>> data structures. Unfortunately, with common workloads, I see
>> multiple thousands of objects stored in file_hashtbl[], which always
>> has only 256 buckets, which makes the hash chains quite lengthy.
>>=20
>> Walking long hash chains with the state_lock held blocks other
>> activity that needs that lock.
>>=20
>> To help mitigate the cost of searching with fh_match(), replace the
>> nfs4_file hash table with an rhashtable, which can dynamically
>> resize its bucket array to minimize hash chain length. The ideal for
>> this use case is one bucket per inode.
>>=20
>> The result is an improvement in the latency of NFSv4 operations
>> and the reduction of nfsd CPU utilization due to the cost of
>> fh_match() and the CPU cache misses incurred while walking long
>> hash chains in the nfs4_file hash table.
>>=20
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>> fs/nfsd/nfs4state.c |   64 +++++++++++++++++++++++++--------------------=
------
>> fs/nfsd/state.h     |    4 ---
>> 2 files changed, 31 insertions(+), 37 deletions(-)
>>=20
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index 681cb2daa843..5b90e5a6a04f 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -591,11 +591,8 @@ static void nfsd4_free_file_rcu(struct rcu_head *rc=
u)
>> void
>> put_nfs4_file(struct nfs4_file *fi)
>> {
>> -	might_lock(&state_lock);
>> -
>> -	if (refcount_dec_and_lock(&fi->fi_ref, &state_lock)) {
>> +	if (refcount_dec_and_test(&fi->fi_ref)) {
>> 		remove_nfs4_file_locked(fi);
>> -		spin_unlock(&state_lock);
>> 		WARN_ON_ONCE(!list_empty(&fi->fi_clnt_odstate));
>> 		WARN_ON_ONCE(!list_empty(&fi->fi_delegations));
>> 		call_rcu(&fi->fi_rcu, nfsd4_free_file_rcu);
>> @@ -709,20 +706,6 @@ static unsigned int ownerstr_hashval(struct xdr_net=
obj *ownername)
>> 	return ret & OWNER_HASH_MASK;
>> }
>>=20
>> -/* hash table for nfs4_file */
>> -#define FILE_HASH_BITS                   8
>> -#define FILE_HASH_SIZE                  (1 << FILE_HASH_BITS)
>> -
>> -static unsigned int file_hashval(const struct svc_fh *fh)
>> -{
>> -	struct inode *inode =3D d_inode(fh->fh_dentry);
>> -
>> -	/* XXX: why not (here & in file cache) use inode? */
>> -	return (unsigned int)hash_long(inode->i_ino, FILE_HASH_BITS);
>> -}
>> -
>> -static struct hlist_head file_hashtbl[FILE_HASH_SIZE];
>> -
>> static struct rhltable nfs4_file_rhltable ____cacheline_aligned_in_smp;
>>=20
>> static const struct rhashtable_params nfs4_file_rhash_params =3D {
>> @@ -4683,12 +4666,13 @@ move_to_close_lru(struct nfs4_ol_stateid *s, str=
uct net *net)
>> static noinline_for_stack struct nfs4_file *
>> find_nfs4_file(const struct svc_fh *fhp)
>> {
>> -	unsigned int hashval =3D file_hashval(fhp);
>> +	struct rhlist_head *tmp, *list;
>> 	struct nfs4_file *fi =3D NULL;
>>=20
>> 	rcu_read_lock();
>> -	hlist_for_each_entry_rcu(fi, &file_hashtbl[hashval], fi_hash,
>> -				 lockdep_is_held(&state_lock)) {
>> +	list =3D rhltable_lookup(&nfs4_file_rhltable, fhp,
>> +			       nfs4_file_rhash_params);
>> +	rhl_for_each_entry_rcu(fi, tmp, list, fi_rlist) {
>> 		if (fh_match(&fi->fi_fhandle, &fhp->fh_handle)) {
>> 			if (!refcount_inc_not_zero(&fi->fi_ref))
>> 				fi =3D NULL;
>> @@ -4708,33 +4692,45 @@ find_nfs4_file(const struct svc_fh *fhp)
>> static noinline_for_stack struct nfs4_file *
>> insert_nfs4_file(struct nfs4_file *new, const struct svc_fh *fhp)
>> {
>> -	unsigned int hashval =3D file_hashval(fhp);
>> +	struct rhlist_head *tmp, *list;
>> 	struct nfs4_file *ret =3D NULL;
>> 	bool alias_found =3D false;
>> 	struct nfs4_file *fi;
>> +	int err;
>>=20
>> -	spin_lock(&state_lock);
>> -	hlist_for_each_entry_rcu(fi, &file_hashtbl[hashval], fi_hash,
>> -				 lockdep_is_held(&state_lock)) {
>> +	rcu_read_lock();
>> +
>=20
> As mentioned separately, we need some sort of lock around this loop and
> the later insert.

Yep. I just ran out of time today.


>> +	list =3D rhltable_lookup(&nfs4_file_rhltable, fhp,
>> +			       nfs4_file_rhash_params);
>> +	rhl_for_each_entry_rcu(fi, tmp, list, fi_rlist) {
>> 		if (fh_match(&fi->fi_fhandle, &fhp->fh_handle)) {
>> 			if (refcount_inc_not_zero(&fi->fi_ref))
>> 				ret =3D fi;
>> 		} else if (d_inode(fhp->fh_dentry) =3D=3D fi->fi_inode)
>> 			fi->fi_aliased =3D alias_found =3D true;
>=20
> This d_inde)( =3D=3D fi->fi_inode test is no longer relevant.  Everything=
 in
> the list must have the same inode.  Best remove it.

My understanding is that more than one inode can hash into one of
these bucket lists. I don't see how rhltable_insert() can prevent
that from happening, and that will certainly be true if we go back
to using a fixed-size table.

I will try to test this assumption before posting the next revision.


> Thanks,
> NeilBrown
>=20
>> 	}
>> -	if (likely(ret =3D=3D NULL)) {
>> -		init_nfs4_file(fhp, new);
>> -		hlist_add_head_rcu(&new->fi_hash, &file_hashtbl[hashval]);
>> -		new->fi_aliased =3D alias_found;
>> -		ret =3D new;
>> -	}
>> -	spin_unlock(&state_lock);
>> +	if (ret)
>> +		goto out_unlock;
>> +
>> +	init_nfs4_file(fhp, new);
>> +	err =3D rhltable_insert_key(&nfs4_file_rhltable, fhp,
>> +				  &new->fi_rlist,
>> +				  nfs4_file_rhash_params);
>> +	if (err)
>> +		goto out_unlock;
>> +
>> +	new->fi_aliased =3D alias_found;
>> +	ret =3D new;
>> +
>> +out_unlock:
>> +	rcu_read_unlock();
>> 	return ret;
>> }
>>=20
>> static noinline_for_stack void remove_nfs4_file_locked(struct nfs4_file =
*fi)
>> {
>> -	hlist_del_rcu(&fi->fi_hash);
>> +	rhltable_remove(&nfs4_file_rhltable, &fi->fi_rlist,
>> +			nfs4_file_rhash_params);
>> }
>>=20
>> /*
>> @@ -5624,6 +5620,8 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct=
 svc_fh *current_fh, struct nf
>> 	 * If not found, create the nfs4_file struct
>> 	 */
>> 	fp =3D insert_nfs4_file(open->op_file, current_fh);
>> +	if (unlikely(!fp))
>> +		return nfserr_jukebox;
>> 	if (fp !=3D open->op_file) {
>> 		status =3D nfs4_check_deleg(cl, open, &dp);
>> 		if (status)
>> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
>> index 190fc7e418a4..eadd7f465bf5 100644
>> --- a/fs/nfsd/state.h
>> +++ b/fs/nfsd/state.h
>> @@ -536,16 +536,12 @@ struct nfs4_clnt_odstate {
>>  * inode can have multiple filehandles associated with it, so there is
>>  * (potentially) a many to one relationship between this struct and stru=
ct
>>  * inode.
>> - *
>> - * These are hashed by filehandle in the file_hashtbl, which is protect=
ed by
>> - * the global state_lock spinlock.
>>  */
>> struct nfs4_file {
>> 	refcount_t		fi_ref;
>> 	struct inode *		fi_inode;
>> 	bool			fi_aliased;
>> 	spinlock_t		fi_lock;
>> -	struct hlist_node       fi_hash;	/* hash on fi_fhandle */
>> 	struct rhlist_head	fi_rlist;
>> 	struct list_head        fi_stateids;
>> 	union {
>>=20
>>=20
>>=20

--
Chuck Lever



