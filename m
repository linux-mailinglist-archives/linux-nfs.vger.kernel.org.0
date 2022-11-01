Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB795615094
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Nov 2022 18:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbiKARZz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 1 Nov 2022 13:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbiKARZx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 1 Nov 2022 13:25:53 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 900A61B1FB
        for <linux-nfs@vger.kernel.org>; Tue,  1 Nov 2022 10:25:51 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A1HE87V010713;
        Tue, 1 Nov 2022 17:25:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=EgXmjH8RawrNgnVoHWzKTrqtxIAu+tZmnvfhz7zhmfY=;
 b=V0ys4Xu7eeIkru2D2xRlVlRgMXaKbYyNH9BDVW3e/TCk5h4C3oz4pEmk2Q5cO5+qinFs
 k3M7tR9wLLuZkoZgnlQrHyvLqL/EEYGGllU7K4z+LrQOjEEXLEtYphOlbJp2p8GCLXNc
 EX+PphFHXByPA2RnlisTReA5vfeVo0de/PitX4BckRUxprMIrkJnCGT94xgOowYBAoiW
 LrWjv5P0fIggRYZt1rzl6I/Ev1N99AprtxVs24UejRQrC8OJi59mwUjMzbpBfFvT2+pj
 ZM3t9mvtuAMQj6ecSUZ/eHyC268UirUddxOydYEtXvQp+2GikOCVvpBXm3ivObb1/rFo ew== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgvqtfc3g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Nov 2022 17:25:44 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A1HM9Ka030290;
        Tue, 1 Nov 2022 17:25:43 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kgtm4pr7p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Nov 2022 17:25:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oUyOKjMDrsXb5dTDr7nPlOtn/7xZ3OV1VTKN/PFySHylCHLwb3ct4C5gMAi6xBKjx8y7v1MSZvytEar1vAp8Md/8B1c5la1YIGTuRQzoB/9VKVL58TbhNimJFFltarFXfpKHJeQ082tqpFzzq3XdPrkXiMt0D03ihx6QDCy2LUrzHDTHJdPg93n3FIMxp5/Fk9THLeLadnaLGCUD/tU7iO8izZ7y5X+/VuWIBTVWXRsXYjMl5i9hWj6lreBuePFVazxFKm8aOAP+smOfbVrJ4wilBpv0OD+SjJmlYZchBO8vDEJr6dfRXi/8KGr8mI5m6fxAeIVZqQJ4p8bxIdSsfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EgXmjH8RawrNgnVoHWzKTrqtxIAu+tZmnvfhz7zhmfY=;
 b=f3wbWVfraUA9JyLgIdVg9qkeQcDuvLVmm5jkA2azC8/Y9Ml6zdh0DqLfurI7ECCAdmKzIsRBeV7ohLG9YnlHprZ5mKy57kyTLOKqXayP3MVNjFsYZLWHoR2GdZmG1WgU4znn0MynG0QvGaYNPBMzqhSQYhLEjrbKSkuaLpxaZ0UsWHZ6DlYmYr6r3WjAqUha6f7LDTHQsFiuinKJbJNwv8iRa5HlEEKPY1mcpjwcCi03H6N/fI3f1EhLHol20MKTq9fhZy1wTKkk3LIsLZLRA0kNPlkg8ZbI2S6W5MAyNOGP2q3n6M+ZqwOPEPL6VPdRIDHbHLWQa6PMh06z+0KPwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EgXmjH8RawrNgnVoHWzKTrqtxIAu+tZmnvfhz7zhmfY=;
 b=aa9rDr5wVYdXq46F0JqDeo/zGmBlPSKB0HGH4VWR4D79I5ZRUJj6wyBvJ8s+CdnYQont0mbLRd9HstnZQFGSp4TpHwDzFo80jPcBMdeXSXbdaqoNRevit9F9n15z5/WfVIj3ZRQDPBC4zXKcuRLv+Qd6y5OkzUys2fNJUktQKMs=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB4989.namprd10.prod.outlook.com (2603:10b6:5:3a9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Tue, 1 Nov
 2022 17:25:41 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a%3]) with mapi id 15.20.5769.021; Tue, 1 Nov 2022
 17:25:41 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Neil Brown <neilb@suse.de>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v5 3/5] nfsd: rework refcounting in filecache
Thread-Topic: [PATCH v5 3/5] nfsd: rework refcounting in filecache
Thread-Index: AQHY7gDKf+UJMCSoA0e+WwOAy53hT64qUesA
Date:   Tue, 1 Nov 2022 17:25:40 +0000
Message-ID: <42F8EAC1-7383-4B98-BAD1-D676950718E0@oracle.com>
References: <20221101144647.136696-1-jlayton@kernel.org>
 <20221101144647.136696-4-jlayton@kernel.org>
In-Reply-To: <20221101144647.136696-4-jlayton@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DS7PR10MB4989:EE_
x-ms-office365-filtering-correlation-id: c056ebee-4346-4363-0f8c-08dabc2e1994
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +5NIk2e7uMCFpF9p9rEuIGGrEjAbYg9txPglpOZ3V4H38g4xv63WD8BVAoclKl9mS9g3JvOstab20YF9EOUdt/9rTSC46vjTWytDJOZKI4+c902wE5ZHqDKnkiqh0I5BEu8lLxo1qoOIc6+7oH3D/aiiF5IVAOMHmff+FbAWNnbJ0STVJS3l2LXXgqmtH0c4DI/yiU+DcbzpFrMA+XT7di1jG92qlRwi611Via7/GwBFE7ePd7ZaUkTPqPXytHOmm4+U6x077eZyKJJEMTrAf16d3llSPFpqn3u9feCct53qrj6a2QSRm7LN1+mTNKAfzmkI6I4DTtFlNThUbjKkCYZNke15stdRZ7DhJC+hf5asFVkzVNitaViWdokTFV9oKkQZadpgYjxQCrxeXN/Dj9qLvK43yjobpb4IxnC7/Fo7F40vkdPmxhwpmIRPlcLtYS1bywQ3+6z/od8Sv10eq6NCaMer27h5lLyZ1VoLv7oEBVEPkfmlKA9sQCF/DAMlxj6vrsqGCS41AKOddHyFS7tN4T25YfkTp36xZJ3gVOqo+vBqQ8ZfeguBAEeIi60R6CoWxJ+edEXdETjFv6FK42ZlAO4fmfd34uqN3nySaLr2uvBsQFOG+0lQE7oXM0bz8tg+1fBkPAtluIYj0/KJsvG/8QLFdnmuHi5j7oUA1sY08JRaPDjfoimj2Y4gkr8cne3JRv0x+MNtpJIdmC8ahtvZe9yrCcxhySZnaq7//aDFi4e11zUDe3S9FNdfdw1GsyZt2c9CvOEijadWCGWz/G9RV9GAck7QItmxGdNh1Kk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(396003)(376002)(136003)(346002)(451199015)(83380400001)(38070700005)(86362001)(33656002)(122000001)(38100700002)(30864003)(5660300002)(2906002)(186003)(64756008)(4326008)(66556008)(8676002)(66476007)(66946007)(66446008)(8936002)(6506007)(76116006)(54906003)(2616005)(26005)(6512007)(316002)(41300700001)(6916009)(91956017)(6486002)(478600001)(71200400001)(53546011)(66899015)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QfkFPgzdsM/5A7d2Q24B8p0RKDCF8/iUsg165nPU+9XBNEk1xpC6SMC4IWQd?=
 =?us-ascii?Q?pIWXFg7ls/luV3KuhA0CZ722FDQ7+oamEM2209EJJerTBzm9SY6v/xZ4JWJP?=
 =?us-ascii?Q?vhwhCk9UbxVOO46EKFJD1Dr7ZXiXOeQ2kfc4648g6xhfsj4gq7mlSNilMy9C?=
 =?us-ascii?Q?hSR9Gy69wwnlK1ATVuGayQxY63nzehUMKULLz67IpQR3RJtHEVtVBedPD9CU?=
 =?us-ascii?Q?59QLohX9rwZm+J/wqzXjEPB9A8prH7Q6F7GwjRGLUVqFLy2XS8AzW35j7iF0?=
 =?us-ascii?Q?1aZ6MMtrOUtth0SUcVfSAgCyXSZKFwlhddKkBBDW1AiaDs4RDIyl6ZGbXZeo?=
 =?us-ascii?Q?2Je+VeGKsXdfToYcPGXsekJhdlQySrZmepkx/sBssQbVmXEs6Rw0ixqkuoKi?=
 =?us-ascii?Q?Kq+sYU5lnG/6KM4091bJK5rjiFE4R/S6Yt/xh3QMMf8YuayO+pIbdaHKsWZm?=
 =?us-ascii?Q?oT7nIL2FjUiVA/j1jTjbMVSoOgIR84ZmlKHvcbgAezibrRQ0wmhKUXydFz7z?=
 =?us-ascii?Q?q7QLm4ZE4+gke2I6P1XWnBZr8a2LO1+LOfgPWG1MsyyQLPBheV9XhQuNc7li?=
 =?us-ascii?Q?X/G+oWIzU00VbFRo/gZ2RJoU2cRtaudmy9uyQ8jvGFXq9ATn2bxM9n3YQibV?=
 =?us-ascii?Q?Mo1LcUrs8F2OpeGwwh4Mi35dSdyBRQBNdOibGQD1hD/dC7pT1sUabT5vLlnS?=
 =?us-ascii?Q?PHBubOOJXfIb3Zu7MZ9RY6SfmtbBW4hbcj+PAY6lC8txe2o7U0ci6dJ/ob5A?=
 =?us-ascii?Q?FWBMQgjnZCoQVk5xs7EfcTQGEo9XjVREiC8/zm/iIGJiEQ/5SAPh5oknP0eA?=
 =?us-ascii?Q?KCQnzc9xWz+WSxWY6F8rgJxuxVFbW5+pk26dEgN3E2safPUN6qow8VS2GWm2?=
 =?us-ascii?Q?pZTfODlkRzNO+t4D3lJ8U/ApNUk3MyD1PKEthHcH1Seqv71NjORQT8vtwXe9?=
 =?us-ascii?Q?ikazpV4QC912E5bLuolOhzABwM45WIGJZL5uDajkEj0MpEW69tW+khfuKOQ3?=
 =?us-ascii?Q?FGSCeWElpPVcJVbUjH7ytH73sfZRL/mXcByMQ5n6UX12nEb9IAqgj2lkWvdk?=
 =?us-ascii?Q?Wb91MlyuuOeJwXV3noZjMYs4kGRLQmquSgxrcBNPu03tjOczA+SzN4G2OfCo?=
 =?us-ascii?Q?nwnK08QgswmTisOlpLxTKsivSQfVhv6QkcDcCQRxngHfRH0GhWpDC25hfvFg?=
 =?us-ascii?Q?FUs6xAn1yGWCBrlsp/dLwN8EbssNeD8lTY5pbp3brcC6pJ5g5xSkdS3BZ9yV?=
 =?us-ascii?Q?LomyxAU/krgY43xRS+GZ/RIN82argKRKMwvVZHxzj2UuFMt0XRIaBYYbokLg?=
 =?us-ascii?Q?hOjWxAYOL5uzXVmV5JhCZGu61R5j1k+KU+mPsqjkeDXN0pSZ0F4g2ow7LNZo?=
 =?us-ascii?Q?RJ2E8qACz0MEuVJexwkTCP5XyXwLxxeOYQ+cQew4aHWbI8i6pjqLQS8SlCmn?=
 =?us-ascii?Q?g8UrAmiczlSUChVIRA4NcWG3NwmY7IpRstpv3Cr6Db7RyHvC9EUMmljog2S2?=
 =?us-ascii?Q?TYX850cTSfnjezzCvr5j+WPmXLCpW7PKl57uB4wO3j+Jg2ost8YDBvNFZcBp?=
 =?us-ascii?Q?8B5y4ZX9HLzqNXu6fBaIQwnbJhLZ3QMsiWSKm/LD9b1Yj/IVcz/F71vilFWo?=
 =?us-ascii?Q?Jg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C3FBB7A223179444A0288239D2C59B22@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c056ebee-4346-4363-0f8c-08dabc2e1994
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2022 17:25:40.9685
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WN/QsojedxaPUcW3XeXPfGJ8/GfT19NsoiXV7TwH7gRNF6qkiAHIUGi/aN7MXpxjYYx3RJBlE7S4hLonQNVh8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4989
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-01_07,2022-11-01_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211010128
X-Proofpoint-GUID: vF1Fecd5Jy6N4dmYnIamYAZsH9ufVX3U
X-Proofpoint-ORIG-GUID: vF1Fecd5Jy6N4dmYnIamYAZsH9ufVX3U
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 1, 2022, at 10:46 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> The filecache refcounting is a bit non-standard for something searchable
> by RCU, in that we maintain a sentinel reference while it's hashed. This
> in turn requires that we have to do things differently in the "put"
> depending on whether its hashed, which we believe to have led to races.
>=20
> There are other problems in here too. nfsd_file_close_inode_sync can end
> up freeing an nfsd_file while there are still outstanding references to
> it, and there are a number of subtle ToC/ToU races.
>=20
> Rework the code so that the refcount is what drives the lifecycle. When
> the refcount goes to zero, then unhash and rcu free the object.
>=20
> With this change, the LRU carries a reference. Take special care to
> deal with it when removing an entry from the list.

Handful of minor nits below. I'm adding some remarks from the
other patches here for my own convenience. Nothing earth-
shattering, the series looks pretty close.

Test results:

When I run my test I "watch cat /proc/fs/nfsd/filecache". The
workload is 12-thread "untar git && make git && make test" on
NFSv3. It's showing worse eviction behavior than the current
code.

Basically all cached items appear to be immediately placed on
the LRU. Do you expect this behavior change? We want to keep
the LRU as short as possible; but maybe the LRU callback is
stopping after a few items, so it might not matter.

Can you look into it before I apply? I suspect it's because
the list_lru_isolate() call is moved after the REFERENCED
check.


> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> fs/nfsd/filecache.c | 247 ++++++++++++++++++++++----------------------
> fs/nfsd/trace.h     |   1 +
> 2 files changed, 123 insertions(+), 125 deletions(-)
>=20
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index 0bf3727455e2..e67297ad12bf 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -303,8 +303,7 @@ nfsd_file_alloc(struct nfsd_file_lookup_key *key, uns=
igned int may)
> 		if (key->gc)
> 			__set_bit(NFSD_FILE_GC, &nf->nf_flags);
> 		nf->nf_inode =3D key->inode;
> -		/* nf_ref is pre-incremented for hash table */
> -		refcount_set(&nf->nf_ref, 2);
> +		refcount_set(&nf->nf_ref, 1);
> 		nf->nf_may =3D key->need;
> 		nf->nf_mark =3D NULL;
> 	}
> @@ -353,24 +352,35 @@ nfsd_file_unhash(struct nfsd_file *nf)
> 	return false;
> }
>=20
> -static bool
> +static void
> nfsd_file_free(struct nfsd_file *nf)
> {
> 	s64 age =3D ktime_to_ms(ktime_sub(ktime_get(), nf->nf_birthtime));
> -	bool flush =3D false;
>=20
> 	trace_nfsd_file_free(nf);
>=20
> 	this_cpu_inc(nfsd_file_releases);
> 	this_cpu_add(nfsd_file_total_age, age);
>=20
> +	nfsd_file_unhash(nf);
> +
> +	/*
> +	 * We call fsync here in order to catch writeback errors. It's not
> +	 * strictly required by the protocol, but an nfsd_file coule get

^coule^could

> +	 * evicted from the cache before a COMMIT comes in. If another
> +	 * task were to open that file in the interim and scrape the error,
> +	 * then the client may never see it. By calling fsync here, we ensure
> +	 * that writeback happens before the entry is freed, and that any
> +	 * errors reported result in the write verifier changing.
> +	 */
> +	nfsd_file_fsync(nf);

I'm wondering if this call should be preceded by

	if (test_bit(NFSD_FILE_GC, &nf->nf_flags))

as you suggested last week.


> +
> 	if (nf->nf_mark)
> 		nfsd_file_mark_put(nf->nf_mark);
> 	if (nf->nf_file) {
> 		get_file(nf->nf_file);
> 		filp_close(nf->nf_file, NULL);
> 		fput(nf->nf_file);
> -		flush =3D true;
> 	}
>=20
> 	/*
> @@ -378,10 +388,9 @@ nfsd_file_free(struct nfsd_file *nf)
> 	 * WARN and leak it to preserve system stability.
> 	 */
> 	if (WARN_ON_ONCE(!list_empty(&nf->nf_lru)))
> -		return flush;
> +		return;
>=20
> 	call_rcu(&nf->nf_rcu, nfsd_file_slab_free);
> -	return flush;
> }
>=20
> static bool
> @@ -397,17 +406,23 @@ nfsd_file_check_writeback(struct nfsd_file *nf)
> 		mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK);
> }
>=20
> -static void nfsd_file_lru_add(struct nfsd_file *nf)
> +static bool nfsd_file_lru_add(struct nfsd_file *nf)
> {
> 	set_bit(NFSD_FILE_REFERENCED, &nf->nf_flags);
> -	if (list_lru_add(&nfsd_file_lru, &nf->nf_lru))
> +	if (list_lru_add(&nfsd_file_lru, &nf->nf_lru)) {
> 		trace_nfsd_file_lru_add(nf);
> +		return true;
> +	}
> +	return false;
> }
>=20
> -static void nfsd_file_lru_remove(struct nfsd_file *nf)
> +static bool nfsd_file_lru_remove(struct nfsd_file *nf)
> {
> -	if (list_lru_del(&nfsd_file_lru, &nf->nf_lru))
> +	if (list_lru_del(&nfsd_file_lru, &nf->nf_lru)) {
> 		trace_nfsd_file_lru_del(nf);
> +		return true;
> +	}
> +	return false;
> }
>=20
> struct nfsd_file *
> @@ -418,86 +433,80 @@ nfsd_file_get(struct nfsd_file *nf)
> 	return NULL;
> }
>=20
> -static void
> +/**
> + * nfsd_file_unhash_and_queue - unhash a file and queue it to the dispos=
e list
> + * @nf: nfsd_file to be unhashed and queued
> + * @dispose: list to which it should be queued
> + *
> + * Attempt to unhash a nfsd_file and queue it to the given list. Each fi=
le
> + * will have a reference held on behalf of the list. That reference may =
come
> + * from the LRU, or we may need to take one. If we can't get a reference=
,
> + * ignore it altogether.
> + */
> +static bool
> nfsd_file_unhash_and_queue(struct nfsd_file *nf, struct list_head *dispos=
e)
> {
> 	trace_nfsd_file_unhash_and_queue(nf);
> 	if (nfsd_file_unhash(nf)) {
> -		/* caller must call nfsd_file_dispose_list() later */
> -		nfsd_file_lru_remove(nf);
> +		/*
> +		 * If we remove it from the LRU, then just use that
> +		 * reference for the dispose list. Otherwise, we need
> +		 * to take a reference. If that fails, just ignore
> +		 * the file altogether.
> +		 */
> +		if (!nfsd_file_lru_remove(nf) && !nfsd_file_get(nf))
> +			return false;
> 		list_add(&nf->nf_lru, dispose);
> +		return true;
> 	}
> +	return false;
> }
>=20
> -static void
> -nfsd_file_put_noref(struct nfsd_file *nf)
> -{
> -	trace_nfsd_file_put(nf);
> -
> -	if (refcount_dec_and_test(&nf->nf_ref)) {
> -		WARN_ON(test_bit(NFSD_FILE_HASHED, &nf->nf_flags));
> -		nfsd_file_lru_remove(nf);
> -		nfsd_file_free(nf);
> -	}
> -}
> -
> -static void
> -nfsd_file_unhash_and_put(struct nfsd_file *nf)
> -{
> -	if (nfsd_file_unhash(nf))
> -		nfsd_file_put_noref(nf);
> -}
> -
> +/**
> + * nfsd_file_put - put the reference to a nfsd_file
> + * @nf: nfsd_file of which to put the reference
> + *
> + * Put a reference to a nfsd_file. In the v4 case, we just put the
> + * reference immediately. In the GC case, if the reference would be
> + * the last one, the put it on the LRU instead to be cleaned up later.
> + */
> void
> nfsd_file_put(struct nfsd_file *nf)
> {
> 	might_sleep();
> +	trace_nfsd_file_put(nf);
>=20
> -	if (test_bit(NFSD_FILE_GC, &nf->nf_flags))
> -		nfsd_file_lru_add(nf);
> -	else if (refcount_read(&nf->nf_ref) =3D=3D 2)
> -		nfsd_file_unhash_and_put(nf);
> -
> -	if (!test_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
> -		nfsd_file_fsync(nf);
> -		nfsd_file_put_noref(nf);
> -	} else if (nf->nf_file && test_bit(NFSD_FILE_GC, &nf->nf_flags)) {
> -		nfsd_file_put_noref(nf);
> -		nfsd_file_schedule_laundrette();
> -	} else
> -		nfsd_file_put_noref(nf);
> -}
> -
> -static void
> -nfsd_file_dispose_list(struct list_head *dispose)
> -{
> -	struct nfsd_file *nf;
> -
> -	while(!list_empty(dispose)) {
> -		nf =3D list_first_entry(dispose, struct nfsd_file, nf_lru);
> -		list_del_init(&nf->nf_lru);
> -		nfsd_file_fsync(nf);
> -		nfsd_file_put_noref(nf);
> +	/*
> +	 * The HASHED check is racy. We may end up with the occasional
> +	 * unhashed entry on the LRU, but they should get cleaned up
> +	 * like any other.
> +	 */
> +	if (test_bit(NFSD_FILE_GC, &nf->nf_flags) &&
> +	    test_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
> +		/*
> +		 * If this is the last reference (nf_ref =3D=3D 1), then transfer
> +		 * it to the LRU. If the add to the LRU fails, just put it as
> +		 * usual.
> +		 */
> +		if (refcount_dec_not_one(&nf->nf_ref) || nfsd_file_lru_add(nf)) {
> +			nfsd_file_schedule_laundrette();
> +			return;
> +		}

A subsequent patch adds the words "fall through" in a comment, and
checkscript flags that. I changed that comment to:

+                       /*
+                        * We're racing with unhashing, so try to remove it=
 from
+                        * the LRU. If removal fails, then someone else alr=
eady
+                        * has our reference.
+                        */

to mollify it.


> 	}
> +	if (refcount_dec_and_test(&nf->nf_ref))
> +		nfsd_file_free(nf);
> }
>=20
> static void
> -nfsd_file_dispose_list_sync(struct list_head *dispose)
> +nfsd_file_dispose_list(struct list_head *dispose)
> {
> -	bool flush =3D false;
> 	struct nfsd_file *nf;
>=20
> 	while(!list_empty(dispose)) {
> 		nf =3D list_first_entry(dispose, struct nfsd_file, nf_lru);
> 		list_del_init(&nf->nf_lru);
> -		nfsd_file_fsync(nf);
> -		if (!refcount_dec_and_test(&nf->nf_ref))
> -			continue;
> -		if (nfsd_file_free(nf))
> -			flush =3D true;
> +		nfsd_file_free(nf);
> 	}
> -	if (flush)
> -		flush_delayed_fput();
> }
>=20
> static void
> @@ -567,21 +576,8 @@ nfsd_file_lru_cb(struct list_head *item, struct list=
_lru_one *lru,
> 	struct list_head *head =3D arg;
> 	struct nfsd_file *nf =3D list_entry(item, struct nfsd_file, nf_lru);
>=20
> -	/*
> -	 * Do a lockless refcount check. The hashtable holds one reference, so
> -	 * we look to see if anything else has a reference, or if any have
> -	 * been put since the shrinker last ran. Those don't get unhashed and
> -	 * released.
> -	 *
> -	 * Note that in the put path, we set the flag and then decrement the
> -	 * counter. Here we check the counter and then test and clear the flag.
> -	 * That order is deliberate to ensure that we can do this locklessly.
> -	 */
> -	if (refcount_read(&nf->nf_ref) > 1) {
> -		list_lru_isolate(lru, &nf->nf_lru);
> -		trace_nfsd_file_gc_in_use(nf);
> -		return LRU_REMOVED;
> -	}
> +	/* We should only be dealing with GC entries here */
> +	WARN_ON_ONCE(!test_bit(NFSD_FILE_GC, &nf->nf_flags));
>=20
> 	/*
> 	 * Don't throw out files that are still undergoing I/O or
> @@ -592,40 +588,30 @@ nfsd_file_lru_cb(struct list_head *item, struct lis=
t_lru_one *lru,
> 		return LRU_SKIP;
> 	}
>=20
> +	/* If it was recently added to the list, skip it */
> 	if (test_and_clear_bit(NFSD_FILE_REFERENCED, &nf->nf_flags)) {
> 		trace_nfsd_file_gc_referenced(nf);
> 		return LRU_ROTATE;
> 	}
>=20
> -	if (!test_and_clear_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
> -		trace_nfsd_file_gc_hashed(nf);
> -		return LRU_SKIP;
> +	/*
> +	 * Put the reference held on behalf of the LRU. If it wasn't the last
> +	 * one, then just remove it from the LRU and ignore it.
> +	 */
> +	if (!refcount_dec_and_test(&nf->nf_ref)) {
> +		trace_nfsd_file_gc_in_use(nf);
> +		list_lru_isolate(lru, &nf->nf_lru);
> +		return LRU_REMOVED;
> 	}
>=20
> +	/* Refcount went to zero. Unhash it and queue it to the dispose list */
> +	nfsd_file_unhash(nf);
> 	list_lru_isolate_move(lru, &nf->nf_lru, head);
> 	this_cpu_inc(nfsd_file_evictions);
> 	trace_nfsd_file_gc_disposed(nf);
> 	return LRU_REMOVED;
> }
>=20
> -/*
> - * Unhash items on @dispose immediately, then queue them on the
> - * disposal workqueue to finish releasing them in the background.
> - *
> - * cel: Note that between the time list_lru_shrink_walk runs and
> - * now, these items are in the hash table but marked unhashed.
> - * Why release these outside of lru_cb ? There's no lock ordering
> - * problem since lru_cb currently takes no lock.
> - */
> -static void nfsd_file_gc_dispose_list(struct list_head *dispose)
> -{
> -	struct nfsd_file *nf;
> -
> -	list_for_each_entry(nf, dispose, nf_lru)
> -		nfsd_file_hash_remove(nf);
> -	nfsd_file_dispose_list_delayed(dispose);
> -}
> -
> static void
> nfsd_file_gc(void)
> {
> @@ -635,7 +621,7 @@ nfsd_file_gc(void)
> 	ret =3D list_lru_walk(&nfsd_file_lru, nfsd_file_lru_cb,
> 			    &dispose, list_lru_count(&nfsd_file_lru));
> 	trace_nfsd_file_gc_removed(ret, list_lru_count(&nfsd_file_lru));
> -	nfsd_file_gc_dispose_list(&dispose);
> +	nfsd_file_dispose_list_delayed(&dispose);
> }
>=20
> static void
> @@ -660,7 +646,7 @@ nfsd_file_lru_scan(struct shrinker *s, struct shrink_=
control *sc)
> 	ret =3D list_lru_shrink_walk(&nfsd_file_lru, sc,
> 				   nfsd_file_lru_cb, &dispose);
> 	trace_nfsd_file_shrinker_removed(ret, list_lru_count(&nfsd_file_lru));
> -	nfsd_file_gc_dispose_list(&dispose);
> +	nfsd_file_dispose_list_delayed(&dispose);
> 	return ret;
> }
>=20
> @@ -671,8 +657,11 @@ static struct shrinker	nfsd_file_shrinker =3D {
> };
>=20
> /*
> - * Find all cache items across all net namespaces that match @inode and
> - * move them to @dispose. The lookup is atomic wrt nfsd_file_acquire().
> + * Find all cache items across all net namespaces that match @inode, unh=
ash
> + * them, take references and then put them on @dispose if that was succe=
ssful.
> + *
> + * The nfsd_file objects on the list will be unhashed, and each will hav=
e a
> + * reference taken.
>  */
> static unsigned int
> __nfsd_file_close_inode(struct inode *inode, struct list_head *dispose)
> @@ -690,8 +679,9 @@ __nfsd_file_close_inode(struct inode *inode, struct l=
ist_head *dispose)
> 				       nfsd_file_rhash_params);
> 		if (!nf)
> 			break;
> -		nfsd_file_unhash_and_queue(nf, dispose);
> -		count++;
> +
> +		if (nfsd_file_unhash_and_queue(nf, dispose))
> +			count++;
> 	} while (1);
> 	rcu_read_unlock();
> 	return count;
> @@ -703,15 +693,23 @@ __nfsd_file_close_inode(struct inode *inode, struct=
 list_head *dispose)
>  *
>  * Unhash and put all cache item associated with @inode.
>  */
> -static void
> +static unsigned int
> nfsd_file_close_inode(struct inode *inode)
> {
> -	LIST_HEAD(dispose);
> +	struct nfsd_file *nf;
> 	unsigned int count;
> +	LIST_HEAD(dispose);
>=20
> 	count =3D __nfsd_file_close_inode(inode, &dispose);
> 	trace_nfsd_file_close_inode(inode, count);
> -	nfsd_file_dispose_list_delayed(&dispose);
> +	while(!list_empty(&dispose)) {

checkpatch complained about wanting whitespace between "while"
and "(!list_empty())".


> +		nf =3D list_first_entry(&dispose, struct nfsd_file, nf_lru);
> +		list_del_init(&nf->nf_lru);
> +		trace_nfsd_file_closing(nf);
> +		if (refcount_dec_and_test(&nf->nf_ref))
> +			nfsd_file_free(nf);
> +	}
> +	return count;
> }
>=20
> /**
> @@ -723,19 +721,15 @@ nfsd_file_close_inode(struct inode *inode)
> void
> nfsd_file_close_inode_sync(struct inode *inode)
> {
> -	LIST_HEAD(dispose);
> -	unsigned int count;
> -
> -	count =3D __nfsd_file_close_inode(inode, &dispose);
> -	trace_nfsd_file_close_inode_sync(inode, count);
> -	nfsd_file_dispose_list_sync(&dispose);
> +	if (nfsd_file_close_inode(inode))
> +		flush_delayed_fput();
> }
>=20
> /**
>  * nfsd_file_delayed_close - close unused nfsd_files
>  * @work: dummy
>  *
> - * Walk the LRU list and close any entries that have not been used since
> + * Walk the LRU list and destroy any entries that have not been used sin=
ce
>  * the last scan.
>  */
> static void
> @@ -1056,8 +1050,10 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struc=
t svc_fh *fhp,
> 	rcu_read_lock();
> 	nf =3D rhashtable_lookup(&nfsd_file_rhash_tbl, &key,
> 			       nfsd_file_rhash_params);
> -	if (nf)
> -		nf =3D nfsd_file_get(nf);
> +	if (nf) {
> +		if (!nfsd_file_lru_remove(nf))
> +			nf =3D nfsd_file_get(nf);
> +	}
> 	rcu_read_unlock();
> 	if (nf)
> 		goto wait_for_construction;
> @@ -1092,11 +1088,11 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, stru=
ct svc_fh *fhp,
> 			goto out;
> 		}
> 		open_retry =3D false;
> -		nfsd_file_put_noref(nf);
> +		if (refcount_dec_and_test(&nf->nf_ref))
> +			nfsd_file_free(nf);
> 		goto retry;
> 	}
>=20
> -	nfsd_file_lru_remove(nf);
> 	this_cpu_inc(nfsd_file_cache_hits);
>=20
> 	status =3D nfserrno(nfsd_open_break_lease(file_inode(nf->nf_file), may_f=
lags));
> @@ -1106,7 +1102,8 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct=
 svc_fh *fhp,
> 			this_cpu_inc(nfsd_file_acquisitions);
> 		*pnf =3D nf;
> 	} else {
> -		nfsd_file_put(nf);
> +		if (refcount_dec_and_test(&nf->nf_ref))
> +			nfsd_file_free(nf);
> 		nf =3D NULL;
> 	}
>=20
> @@ -1133,7 +1130,7 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct=
 svc_fh *fhp,
> 	 * then unhash.
> 	 */
> 	if (status !=3D nfs_ok || key.inode->i_nlink =3D=3D 0)
> -		nfsd_file_unhash_and_put(nf);
> +		nfsd_file_unhash(nf);
> 	clear_bit_unlock(NFSD_FILE_PENDING, &nf->nf_flags);
> 	smp_mb__after_atomic();
> 	wake_up_bit(&nf->nf_flags, NFSD_FILE_PENDING);
> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> index 940252482fd4..a44ded06af87 100644
> --- a/fs/nfsd/trace.h
> +++ b/fs/nfsd/trace.h
> @@ -906,6 +906,7 @@ DEFINE_EVENT(nfsd_file_class, name, \
> DEFINE_NFSD_FILE_EVENT(nfsd_file_free);
> DEFINE_NFSD_FILE_EVENT(nfsd_file_unhash);
> DEFINE_NFSD_FILE_EVENT(nfsd_file_put);
> +DEFINE_NFSD_FILE_EVENT(nfsd_file_closing);
> DEFINE_NFSD_FILE_EVENT(nfsd_file_unhash_and_queue);
>=20
> TRACE_EVENT(nfsd_file_alloc,
> --=20
> 2.38.1
>=20

--
Chuck Lever



