Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1B2360B978
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Oct 2022 22:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbiJXUNM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 24 Oct 2022 16:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbiJXUMm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 24 Oct 2022 16:12:42 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59AAE16D887
        for <linux-nfs@vger.kernel.org>; Mon, 24 Oct 2022 11:30:59 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29OFYVRC029526;
        Mon, 24 Oct 2022 17:26:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=S4LD5fqrogsQvH1Tb5nd3/+T+7vL4jCsnMWo7EYfcbQ=;
 b=mN0R690UQiJx6XfBfCWTzduPo96WPBIHcKpZZC6fqk8A9AWOmBB3GzK3UEwGKagBjOeB
 rRK/ZCCRKJm102IB8j4gVfOnp0BbWPZIZ86eJIThKsCDknN1tBjM2MODl+iRl3v+WbvF
 JrcPEKDNHsjQtjcQye13BK9TXS3OZiBrsE83jhdTNHGCbP+5jZxQdJj2pVZVD7kt/gTS
 o+Fc+GDUwPk6h2INZRWylRc0N96zbGekIyKqiSPMN11ad+UcGfVDx1U2WKrSkLGoEYQm
 7r1WIqg87vuFvlZT959K6EUdDiyJFqy/wsMVAnYRFGRNJERAxUgby7l8n/2eS51BGLVb 1Q== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kc7a2vbq2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Oct 2022 17:26:24 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29OGmmoe039839;
        Mon, 24 Oct 2022 17:26:24 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2172.outbound.protection.outlook.com [104.47.73.172])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kc6y9tnw2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Oct 2022 17:26:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cMcKr3MFV7eCwbHTYILPwg5780xneVIVXFTQfrSi+0aQ7tANscg7CdC4g/CU9uO8LEEKVMaAOotaET/A2alaC6sP81aoueTcAXPLO9tkD5+9x/DlQknkGhXSF01zCCHMppE2DLZqkdPgk7LV8jUQhajADqbXpQNmXaljJpwvaC5OD91jlR9p9lKTJtED8mlrY46NXA8qWS6F4ei7fG7iLcPsUa1YXFbrMzzYgnElv3EpmaU8sjShMCdNPuWcYiFB6DOQXqZ0ezHDSFaB70XKQnCTRk3vD25qsw/7Aii8OQ3jpUmlX41/ZlyJFmiSjdQP1wM1DB7i8Q/p1G+PEblbIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S4LD5fqrogsQvH1Tb5nd3/+T+7vL4jCsnMWo7EYfcbQ=;
 b=U7c0xOCJGZUr8WJTiUbmqlsRhuqo1OxnwBF2Amlzbt5XJtlOaaZYsdH4pZ4MKacMgCvP0yNSIZknak4gNlvfok56aoWNZdISbmQl/0nybwcwtNDJ71v4GLSVLpbO/+HF3p1I+DAjnb6r7Rff5F0tzwoml3Vquomj/rZu/Kg368+Y3ECQNQx4TppCn8JN/pqL/+cXB9qiHEq3fo79edED7Qc+NTb3JKZyGZxAQQb1YorvmEhApMyHFIbVfztr7BKZQtGa4aIvyMJeE0vv6S8R/88NmdZGzfA9+wSn70J61p8AEZiYyejjRdfMGfd63Qo3gsW1r3jZZfhlipWe9zNW5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S4LD5fqrogsQvH1Tb5nd3/+T+7vL4jCsnMWo7EYfcbQ=;
 b=ADKQnP+QMHrC26drdfhxzSFqvq3kl5k9hthOoSjm+8O7xRQ+8lpjb9A+lTFn8juPCwAZvpiHHjj6H3FamcCV/0rOV39iZY6FRJLl6zCGVu4stMvhYFEHayZIyhi9jZXU8+PrZlGn1dSWDXIqw1ospTLSDyZDTH5StISPRfA8jpM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BL3PR10MB6188.namprd10.prod.outlook.com (2603:10b6:208:3bf::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Mon, 24 Oct
 2022 17:26:21 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a%3]) with mapi id 15.20.5746.021; Mon, 24 Oct 2022
 17:26:19 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v4 5/7] NFSD: Use rhashtable for managing nfs4_file
 objects
Thread-Topic: [PATCH v4 5/7] NFSD: Use rhashtable for managing nfs4_file
 objects
Thread-Index: AQHY4ywcCv9nfMlOd0+Wa/Y/m9MOsq4c6pOAgADqiAA=
Date:   Mon, 24 Oct 2022 17:26:19 +0000
Message-ID: <51A1D02F-4BD7-4AA4-AB5A-6962D8708122@oracle.com>
References: <166612295223.1291.11761205673682408148.stgit@manet.1015granger.net>
 <166612313084.1291.5764156173845222109.stgit@manet.1015granger.net>
 <166658201312.12462.15430126129561479021@noble.neil.brown.name>
In-Reply-To: <166658201312.12462.15430126129561479021@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BL3PR10MB6188:EE_
x-ms-office365-filtering-correlation-id: 683bb655-68b2-423f-014f-08dab5e4dd0e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J9Tv4ieP75tZphxVkTgEI9+ScqFc9ilWc45YIB1DOUvEUeqJvdkha8uK+/WGGGyJSSr+V/BOkYFHdrzpgRtWdIL0tOkuMtq4WhhG3UGDshc5t8GyIHd5pVGBpuitwSy1iEP8GegfczrPumcfd6y5aohT5kPJRLULrrECUMn4UA0AcJhw3hoDTkbWNe75ZmSi2JtM6m/2m8sWiYzDOMRGLgEqLc4f95FwC0qHfUuoE45aqNR1HWS2PIOhUlTAqUeS/g9Z9lLZkOTPhulxYB7+iYSDvRSmHoHVb6B+VMnIPfkmesjM4mqN443RuYk4xNvEYa1nDUclgpxZIPSTQD2l1/LmiKA9waGYhCdjd8ZoqGI/xgds+eNbuL2P/cSOeEh9HvGxCqytXl/YBv/3cbBSgIlsfwmMKfYpZx3sdMB9p6Ixvhrhernmt8hLSrIzYaLGuGN5dFtPr895/vzRukajP875h7A87dHQxOd81VdyhINV/Fn6jRIaq5b664XSc5pF/nkeVmxNe1TONW7JvpgyzqqfPIszBCNN5ZSAwzaQ6WyKMlU/xQyTbQyjCgmcURuEW+YDj/DNLEfSBB+k0H1QHVYcBSczfg6urfTMKZ1rhATdCdy6Nz52WS+N92YEc8kp3rr98U9ZzwI+0Q/+a+tA35p2+NIai46qA9Xd4HRMspAM9MLsw5PlvvRLi5VO3fwE1kNQ+P/xAYI9gvh2g8qqiayqZjZUasQB3Qe7fEr/kJR1xaBX810zn74IVqpasqnYDze649CiZIX70j/XHxcbr+bYqwIBfj3QWsNYP9tyTqjzVmgs2Ox6WVCHSEYfdRsL
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(39860400002)(366004)(136003)(346002)(451199015)(36756003)(83380400001)(38070700005)(33656002)(86362001)(91956017)(38100700002)(122000001)(76116006)(6916009)(66899015)(66556008)(2616005)(316002)(5660300002)(66476007)(6506007)(186003)(66946007)(8936002)(2906002)(478600001)(53546011)(26005)(64756008)(6512007)(8676002)(66446008)(4326008)(71200400001)(41300700001)(6486002)(21314003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aD8Rqc0XypFEhrzRsZEBSJ0dLxCZ43mnBJyhZBxD1s1VdS9ck65mKvyvQO9c?=
 =?us-ascii?Q?LXQhmSFP132VK9ePp8dSvSFNwasHK3/ej68QSuQeaoj4v1R5ASBe6rkzk6DJ?=
 =?us-ascii?Q?gEm83t99mfh1IVL0G9mQ66oFL+pLg5s+NwHhRJzLsWyllb8f+mi0aJLeqa4r?=
 =?us-ascii?Q?VXM20Us/e30edUAD3gWWf8WwQnXNEpQpXUE7lDpzK4RZuYAHFYu7GjaVqGH1?=
 =?us-ascii?Q?NpifcCXU5kEopUta/XaPFhRWoR9vHxslSVl8/NKsPgNcc31JIz51oiSrdbTi?=
 =?us-ascii?Q?Sv4A7T4dQYmXWStYQ3gNbFy3FiDU5szPhdRv3jcc/eNQqq+dx1MfQ1YGM1AG?=
 =?us-ascii?Q?rwVQf/ERJ+2sbqPVmLIHX1HuHUjC9gNCze9h4kOkAcxIgZO8RN7KcX2JEY3u?=
 =?us-ascii?Q?M4+KvZ2LKJlWQF+xuNLd8EBWIQv+E/fjPqn5FZngipWhSdkiKuGsF1FDn5Wa?=
 =?us-ascii?Q?XvgPV7zSgPWxRw/FTcz9iwK2VUW1fu9Y+fr0SY+pKdvG1np7itd4kasj5w+L?=
 =?us-ascii?Q?Jv5BHo+30x9Ex6FbhSi6H+B8BWDhbEQcX2WVNT9iH/KtXA1xYtqSbvgrwGeA?=
 =?us-ascii?Q?yUfOdaKUAVLxJLZmDAucrga6F1EuXUy8wyNAQuM8h+b5mjKsY4f869r30uVn?=
 =?us-ascii?Q?dCFlkKz3MotjlYyWZ+P673fLGstqMDytuL32cgkvyJSmCe5F3fud6W6Eb6Kg?=
 =?us-ascii?Q?YLYQ3Uqyp8vWd7AGn6bhaj/puz5zIr3XFln93LQ15zZRaoShrmBt6tAw1Lgy?=
 =?us-ascii?Q?G6Ir3ccJRmAZ/julFnj96OrsTDT8bWQjk+Gew15/u7ta/MXTzviR27XcKrdb?=
 =?us-ascii?Q?5J/6usn9vYSlA+xmNJ4jUiT4Q9rvJgdy5JDtYTHwlMaz+w6zigSayDh0duan?=
 =?us-ascii?Q?1SNUkQ+muA5RPr2Rk18Le64vjj32hXf/bhPTdmIuk6546VAgZ5Mu1ab3C0oE?=
 =?us-ascii?Q?B9tSukVAYmT76SGKEP3s1LkexIAx5XxswOXdeo4/0863QiXVD8mXej/FPGn+?=
 =?us-ascii?Q?51SPndfrrTaQGvG+ZXvNZOsk6zs3rDh9BI1piY+d2eUvcjXy1SkNnd8QaWsK?=
 =?us-ascii?Q?sGfJqtSjXniaBrcsdeFKpOzeC+vIVOGb4M3JbVQA8ZoHpa/A7zV7esnGcQjW?=
 =?us-ascii?Q?PsjUFWlWjmkbaujRNEs4a8R6u0yLNS+8ebwYcyQrTvjJIm/0wN8cCanKTm2t?=
 =?us-ascii?Q?QTHlZO8tw1j9ZdfIfjcrFymjMaMe/mqIncIF8c48+cTQz8g0glINy/rakpWu?=
 =?us-ascii?Q?2xkP0PKLh3Y+B0+17dcItchDDP5Ifu6IkYr83tPvaaNxmFBm4yHGrYD33u4U?=
 =?us-ascii?Q?rZ+uEI4w3/dJMJV1ojTZS3R/AWnxFviFv8omw8sp5xHyeHm4DhBOGCkuNsJz?=
 =?us-ascii?Q?I4hFDBt4xExXpn3nJCRYZfou/7BOlY4srqiFn8W56szVQGEzcO11ajc5jLIG?=
 =?us-ascii?Q?U9K+qYAF26hAMvX5HfsIPyyNclXASOuXV34fmr1OGtvYMEKHe7wndB+bFJCw?=
 =?us-ascii?Q?o/qaysTKvFtKwhIIJrf+bdLe/NH2HC9Lnvvomd/kaCyExgaDS6YRAH4iROuP?=
 =?us-ascii?Q?2zr3hR81ljDjusZwxr58YH9+NstBVJ0xnKQnY/B9+ejtKVdt4FzYRRPrsw1Z?=
 =?us-ascii?Q?SQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1F6E638771628F47B895B27E8D9C7C31@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 683bb655-68b2-423f-014f-08dab5e4dd0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2022 17:26:19.2043
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cWBol67xiO4HUGFsQJcKsey8VpVnkb8L5CYbt+PfTtRBeytQxF6qCUORSqIHemHXnOhO8uJJmFRxyS69TVNfLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6188
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-24_05,2022-10-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210240106
X-Proofpoint-GUID: jD3f8IGiw6Ao9AHB1hQ0fs0EOH61Wt54
X-Proofpoint-ORIG-GUID: jD3f8IGiw6Ao9AHB1hQ0fs0EOH61Wt54
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 23, 2022, at 11:26 PM, NeilBrown <neilb@suse.de> wrote:
>=20
> On Wed, 19 Oct 2022, Chuck Lever wrote:
>> fh_match() is costly, especially when filehandles are large (as is
>> the case for NFSv4). It needs to be used sparingly when searching
>> data structures. Unfortunately, with common workloads, I see
>> multiple thousands of objects stored in file_hashtbl[], which always
>> has only 256 buckets, which makes the hash chains quite lengthy.
>>=20
>> Walking long hash chains with the state_lock held blocks other
>> activity that needs that lock.
>=20
> Using a bit-spin-lock for each hash chain would be a simple fix if this
> was the only concern.  See for example fscache_hash_cookie().
> I'm not at all against using rhltables, but thought I would mention that
> there are other options.

rhashtable uses bit-spin-locks, and as I said in the other thread,
without the state_lock this all seems to work without crashing,
lockdep or KASAN splat, or test workload failures.


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
>> Note that hash removal is no longer protected by the state_lock.
>> This is because insert_nfs4_file() takes the RCU read lock then the
>> state_lock. rhltable_remove() takes the RCU read lock internally;
>> if remove_nfs4_file() took the state_lock before calling
>> rhltable_remove(), that would result in a lock inversion.
>=20
> As mentioned separately, lock inversion is not relevant for
> rcu_read_lock().

Understood.


> Also, I cannot see any need for state_lock to be used for protecting
> additions to, or removals from, the rhash table.

Agreed.


>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>> fs/nfsd/nfs4state.c |  215 +++++++++++++++++++++++++++++++++++----------=
------
>> fs/nfsd/state.h     |    5 -
>> 2 files changed, 147 insertions(+), 73 deletions(-)
>>=20
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index 2b850de288cf..a63334ad61f6 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -44,7 +44,9 @@
>> #include <linux/jhash.h>
>> #include <linux/string_helpers.h>
>> #include <linux/fsnotify.h>
>> +#include <linux/rhashtable.h>
>> #include <linux/nfs_ssc.h>
>> +
>> #include "xdr4.h"
>> #include "xdr4cb.h"
>> #include "vfs.h"
>> @@ -84,6 +86,7 @@ static bool check_for_locks(struct nfs4_file *fp, stru=
ct nfs4_lockowner *lowner)
>> static void nfs4_free_ol_stateid(struct nfs4_stid *stid);
>> void nfsd4_end_grace(struct nfsd_net *nn);
>> static void _free_cpntf_state_locked(struct nfsd_net *nn, struct nfs4_cp=
ntf_state *cps);
>> +static void remove_nfs4_file(struct nfs4_file *fi);
>>=20
>> /* Locking: */
>>=20
>> @@ -577,11 +580,8 @@ static void nfsd4_free_file_rcu(struct rcu_head *rc=
u)
>> void
>> put_nfs4_file(struct nfs4_file *fi)
>> {
>> -	might_lock(&state_lock);
>> -
>> -	if (refcount_dec_and_lock(&fi->fi_ref, &state_lock)) {
>> -		hlist_del_rcu(&fi->fi_hash);
>> -		spin_unlock(&state_lock);
>> +	if (refcount_dec_and_test(&fi->fi_ref)) {
>> +		remove_nfs4_file(fi);
>> 		WARN_ON_ONCE(!list_empty(&fi->fi_clnt_odstate));
>> 		WARN_ON_ONCE(!list_empty(&fi->fi_delegations));
>> 		call_rcu(&fi->fi_rcu, nfsd4_free_file_rcu);
>> @@ -695,19 +695,82 @@ static unsigned int ownerstr_hashval(struct xdr_ne=
tobj *ownername)
>> 	return ret & OWNER_HASH_MASK;
>> }
>>=20
>> -/* hash table for nfs4_file */
>> -#define FILE_HASH_BITS                   8
>> -#define FILE_HASH_SIZE                  (1 << FILE_HASH_BITS)
>> +static struct rhltable nfs4_file_rhltable ____cacheline_aligned_in_smp;
>> +
>> +/*
>> + * The returned hash value is based solely on the address of an in-code
>> + * inode, a pointer to a slab-allocated object. The entropy in such a
>> + * pointer is concentrated in its middle bits.
>> + */
>> +static u32 nfs4_file_inode_hash(const struct inode *inode, u32 seed)
>> +{
>> +	u32 k;
>> +
>> +	k =3D ((unsigned long)inode) >> L1_CACHE_SHIFT;
>> +	return jhash2(&k, 1, seed);
>=20
> I still don't think this makes any sense at all.
>=20
>        return jhash2(&inode, sizeof(inode)/4, seed);
>=20
> uses all of the entropy, which is best for rhashtables.

I don't really disagree, but the L1_CACHE_SHIFT was added at
Al's behest. OK, I'll replace it.


>> +}
>>=20
>> -static unsigned int file_hashval(struct svc_fh *fh)
>> +/**
>> + * nfs4_file_key_hashfn - Compute the hash value of a lookup key
>> + * @data: key on which to compute the hash value
>> + * @len: rhash table's key_len parameter (unused)
>> + * @seed: rhash table's random seed of the day
>> + *
>> + * Return value:
>> + *   Computed 32-bit hash value
>> + */
>> +static u32 nfs4_file_key_hashfn(const void *data, u32 len, u32 seed)
>> {
>> -	struct inode *inode =3D d_inode(fh->fh_dentry);
>> +	const struct svc_fh *fhp =3D data;
>>=20
>> -	/* XXX: why not (here & in file cache) use inode? */
>> -	return (unsigned int)hash_long(inode->i_ino, FILE_HASH_BITS);
>> +	return nfs4_file_inode_hash(d_inode(fhp->fh_dentry), seed);
>> }
>>=20
>> -static struct hlist_head file_hashtbl[FILE_HASH_SIZE];
>> +/**
>> + * nfs4_file_obj_hashfn - Compute the hash value of an nfs4_file object
>> + * @data: object on which to compute the hash value
>> + * @len: rhash table's key_len parameter (unused)
>> + * @seed: rhash table's random seed of the day
>> + *
>> + * Return value:
>> + *   Computed 32-bit hash value
>> + */
>> +static u32 nfs4_file_obj_hashfn(const void *data, u32 len, u32 seed)
>> +{
>> +	const struct nfs4_file *fi =3D data;
>> +
>> +	return nfs4_file_inode_hash(fi->fi_inode, seed);
>> +}
>> +
>> +/**
>> + * nfs4_file_obj_cmpfn - Match a cache item against search criteria
>> + * @arg: search criteria
>> + * @ptr: cache item to check
>> + *
>> + * Return values:
>> + *   %0 - Success; item matches search criteria
>> + */
>> +static int nfs4_file_obj_cmpfn(struct rhashtable_compare_arg *arg,
>> +			       const void *ptr)
>> +{
>> +	const struct svc_fh *fhp =3D arg->key;
>> +	const struct nfs4_file *fi =3D ptr;
>> +
>> +	return fh_match(&fi->fi_fhandle, &fhp->fh_handle) ? 0 : 1;
>> +}
>=20
> This doesn't make sense.  Maybe the subtleties of rhl-tables are a bit
> obscure.
>=20
> An rhltable is like an rhashtable except that insertion can never fail.=20
> Multiple entries with the same key can co-exist in a linked list.
> Lookup does not return an entry but returns a linked list of entries.
>=20
> For the nfs4_file table this isn't really a good match (though I
> previously thought it was).  Insertion must be able to fail if an entry
> with the same filehandle exists.

I think I've arrived at the same conclusion (about nfs4_file insertion
needing to fail for duplicate filehandles). That's more or less open-coded
in my current revision of this work rather than relying on the behavior
of rhltable_insert().


> One approach that might work would be to take the inode->i_lock after a
> lookup fails then repeat the lookup and if it fails again, do the
> insert.  This keeps the locking fine-grained but means we don't have to
> depend on insert failing.
>=20
> So the hash and cmp functions would only look at the inode pointer.
> If lookup returns something, we would walk the list calling fh_match()
> to see if we have the right entry - all under RCU and using
> refcount_inc_not_zero() when we find the matching filehandle.

That's basically what's going on now. But I tried removing obj_cmpfn()
and the rhltable_init() failed outright, so it's still there like a
vestigial organ.

If you now believe rhltable is not a good fit, I can revert all of the
rhltable changes and go back to rhashtable quite easily.

Let me do that and post what I have.


--
Chuck Lever



