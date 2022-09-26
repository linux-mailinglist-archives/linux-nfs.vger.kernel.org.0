Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E847D5EAF34
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Sep 2022 20:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbiIZSH6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 26 Sep 2022 14:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiIZSHc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 26 Sep 2022 14:07:32 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 176516469
        for <linux-nfs@vger.kernel.org>; Mon, 26 Sep 2022 10:52:04 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28QHXx5X022201;
        Mon, 26 Sep 2022 17:51:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=XKsyEZmXyxcXjT477hyEs0c7HG3HR+jOnLAw+aaHhck=;
 b=rNXG7Q3+1RUaLqT3ybE4slrOaenDcTgYBlAB/7Erazr2++NOBpRDKXup0hYKWGx4QVbx
 D0dCZMe5DhVOuGv3JjvQZY46pCWp44m2VfQaF/wPz2ZbEklA5QPou+MqIddAbhQNKsmY
 wPa3qDvPzJjynH9PlYMmFglRcJmqxmKX1ml4EmMF9v1ddy8XCHUWj9YKs4m6QVgtC8ZM
 YGGt7AXmiUhcKPm1BDeknv0mVhz79uOs7c1Y4w8hvEzb32wK5OEiojOu6ps0kuYVdT+A
 SHrNikFVp6hFq5tJSwrvWTAzR4BmcNOxxK5iLfAg76YEgDrLliF/R5XX910rJyEnX9o8 ag== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jssrwcevp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Sep 2022 17:51:54 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28QFFgQY001456;
        Mon, 26 Sep 2022 17:51:53 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jtpuyqnnr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Sep 2022 17:51:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a6VUClCUbl9kZR/YL2/E3eODWDJw9LyB0eTLkU3YTxBeFzwjWrzBrv/wPJmHYBmOdkN+W5cnn04Vtiga179VHF7IzKPLIx8YYxL0nGPYW/hY1NTxeEcrBwzozi3KqpXccrV2X4baD0mG9leKOGpkmE2vSjOwu8/+c256pPyaXhbvROV/GBk4utZXGG+frTTjsHZ1U9Ildrnq1ALMT/4jfz/OiiE9pBGTSor4xCf/OHkc+g6L8e2kgcRzEVoZHRjAkET358V2IaLlVY2//ESzAQnpNjScRJdPMz7+aNDn28ed37mlhVxu4qrjFI+DGFZE1OtejX1wfsux0eBiNULx8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XKsyEZmXyxcXjT477hyEs0c7HG3HR+jOnLAw+aaHhck=;
 b=ltuGiwdS58ztTUsz74dNLEILdt7K8QiO6TtWdQZ7DGatMp0aOHGwHyMhhROsiVpoht5l1OgDOvQwLpvFZJWoAnwAv0yZQz4EJCkU/28U/e0+5zptWxTBbxwLmjN8TolJOzGpnfF7LqfVf0KbxCuZI48ntHL+W117ZwcXieYptdaYuIun5ZeUS279OIsuBSdTSsjwWzNtG0zQwvE7fJ1J1yh4pyAKlWbQuvTyrDEJlqxtjjK8sGEzVKXJMTLqlE19R/7ow5E3TFGx8cMg+CN+tgbHp8SDTwLXaXSnDpIGEVLqsrkzPRE7cqz+M8izh4d259UbZbY0gA78NC6bTwdzQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XKsyEZmXyxcXjT477hyEs0c7HG3HR+jOnLAw+aaHhck=;
 b=eOpJdk8K3m20vHKfEmHeDKrqRj07NAquw0qXbPKKv1owETCBY9q7efU69yZ7e6jEF0tQq9CQyChjorJGIsqeMzDjQW0NG/jt9enFQR9B3oLxXnH6LFVmf3FeIHk5iQS5h3NJqPlkShryY3K5VTignnW0CKOO/AUbrJ5WYpJo4NA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM6PR10MB4298.namprd10.prod.outlook.com (2603:10b6:5:21f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Mon, 26 Sep
 2022 17:51:51 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa%4]) with mapi id 15.20.5654.026; Mon, 26 Sep 2022
 17:51:51 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 3/4] nfsd: make nfsd4_run_cb a bool return function
Thread-Topic: [PATCH 3/4] nfsd: make nfsd4_run_cb a bool return function
Thread-Index: AQHY0cZ51eRBkuHk8kWRMF5Zpbx2Nq3x/cEA
Date:   Mon, 26 Sep 2022 17:51:51 +0000
Message-ID: <F3B08B69-F05B-4F83-B407-343884ABC263@oracle.com>
References: <20220926163847.47558-1-jlayton@kernel.org>
 <20220926163847.47558-4-jlayton@kernel.org>
In-Reply-To: <20220926163847.47558-4-jlayton@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DM6PR10MB4298:EE_
x-ms-office365-filtering-correlation-id: 3191f09e-c826-4baa-31ac-08da9fe7cac1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UCpgF202vWpbf6p9eQdJ+EiVym2ae2BMPpMcnOsKqNgOC6xtsC1hMB21nBt5JUGCPhLZ/kWEufuTM8zUbqD4nnL9/fg/Vl6Kml9Iup5zDnTJF/4OfX/NczyrWg+vhA/jra80/o5LujRGGE4HFumTDrP9APUDau02kazRvOg66JoE4fBKJVPaZK0EnXyfyJmx8nbtk8m1Hn11Ft749jMSGJxDwjqXIVL7DBN51ncLUPGD8oHJMY8XvimcBM8nXtopdp5lVgNyBf1m6iGEYv2tKmYF/pup99ns+/4wr13muck9tWfQ5u4S94U7iqTVQ72AYEeQKx0H05T6Nu9XFLqrN/TfIMTRk6Z1ZxqgJ2Z0pseV+Kk28mqhf8yX5GREY8iUydl69D8BDYRhHiz8m9cnack0GatULzAK1JMP2ypPMgVMPQj8k3fV8AnLd7UhvjZYmshJOZPiP9rydkyQLRL3CMsy9Gjzc6GSxt8y6PYIsEcgnoV1K9MWd/otR/N0xZmCK1AdJukuKvSJnRyCs9JyNQrjeEvq4Z23wcg0vawPZjs5AXGWz5DyGuDmX8R6wqo4UAc8Ri+/rjtjq+fD+qpgJdnK/1bcPzlHJyMmBCaFfadZrWaDJXlwg8mLh0LFDpsUYM4PLR46HmV6uOPqRkvoFhGP6arMuB6tCe/FQobDDD6cyiyR21jH8AJt7GzYDEnBM/Gt+1sv4F6s58V9kghdXiMcAS1ywS0wRnMg3WQNrlPpdRNjxrQLD/yxEupuYd/mCi+/K2mER8ONtP3eHOU04+XZ8+VHc8Hri4J/LHoBPnY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(376002)(39860400002)(136003)(396003)(451199015)(71200400001)(41300700001)(6512007)(26005)(6506007)(53546011)(6486002)(478600001)(5660300002)(2906002)(33656002)(86362001)(36756003)(6916009)(316002)(8936002)(4326008)(76116006)(91956017)(66446008)(8676002)(66946007)(66556008)(66476007)(64756008)(2616005)(38100700002)(122000001)(83380400001)(38070700005)(186003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iJSQ2XByMOD8ybTT+nlXGDNFIZ1ot39PETTwQ12GzLOKip++zJDFimcTQHe5?=
 =?us-ascii?Q?A7XN+MAQO8aJukJAu67TGOIudA8FC8iSUDZkKzWv5nWCQfqAS4cXzc5wLRH0?=
 =?us-ascii?Q?rvgu6J/jjZmE6AYYZlIv4MxXAUVYKvAu4S9vFlGVmFVJULK0LZ8HXzYedmgZ?=
 =?us-ascii?Q?GxLjOgA6hgeXKt0hQhhbFoqURSnUfYDJT/xAaQPYno7c7RuU/epgrYxEMjcu?=
 =?us-ascii?Q?435gh8AfarFOqAkdP9xuDKPYRPOkEyzg5lYa+w6DNvaL2Gr8+ne4jboKADGO?=
 =?us-ascii?Q?kOVL8t5csbRlFN9A6rP/GC4VpqGCNa2g/1FNIJWhyYeCk8Sc/tuwSQ+AYybx?=
 =?us-ascii?Q?Vyokd0Mo5X5XvmVtYqMkxjepc0INogBW+brsSenlKXevzsi2WqCBh4083yDr?=
 =?us-ascii?Q?knAusByunD+BPv7TimQ84vTlPt9NtO3YJTZ1Suzbpe7e3idQmX16f42hU9yq?=
 =?us-ascii?Q?dYGmmTIz557Jthb9Mlnwqr4CzZxj7gJoBXlVOrMzw2Tyf3O50EzYOx1p/maA?=
 =?us-ascii?Q?4gTfBtPDAWpv7i3T5pl8RZBcd4JvDy+RKbc/+batwHtMq1nK/Jwm1EeoBFNG?=
 =?us-ascii?Q?ENUSubncP0YxVnaJcp1Gziwh4b+VGkRNGXJ7W65JKStMGN7PtaL6eFE7fmCR?=
 =?us-ascii?Q?CuJJxltQa4Xwp5NsAuD4UUKy8y7Qx6nCb5Oq8unHbok9rpsUyRbMDL90lQI/?=
 =?us-ascii?Q?2/pYD/6uRzZkxmKLkD0ksd9EhOc4OFiIo/xB6ZnWc4Kf6HW3PSphBjz1mEHu?=
 =?us-ascii?Q?s9NGv2wJFeBFnqCsh7f3wCFvAdPgnxOAqNDvOWefnWxzyNVdMpwLzJg/sK5o?=
 =?us-ascii?Q?1Ek7nu9p1wni/pFd1Dz6ypsSotTdkY1bHzdOshFsKYDyHlTIbk7aLqF99bcc?=
 =?us-ascii?Q?hYzaUH0rovBCNEVUvVbd5myycuh4WIDH044IolYvHc7XIFwhuF3MCEtLMhxT?=
 =?us-ascii?Q?14KK+mnnTvq39Fwsau1//K3bQPAp6xQDfYqqpYQAFqkfKVYmYvGiku9vlw0s?=
 =?us-ascii?Q?iXRPY4Q+LWy/sX+qQ5bXYRIGV4lvd/4Kv4KNBNU6on/FH85B5C5tetYDuXVZ?=
 =?us-ascii?Q?i0CtNYhye+yXdmrmmLsca/abRH46bB187OFXa3TLLOCWaS3K888Yaa4MB1gl?=
 =?us-ascii?Q?GZJFhkBE6HM35sVxKNi7Dv7ul0WBozUKQ2bqSKBmZTqZvZNj6QYiAqUI5CxO?=
 =?us-ascii?Q?W4QKosdws270cVW7UT2G6zI2HC9zbIsR+9Adw/Z/UYQGAq+y3c9269wptUc3?=
 =?us-ascii?Q?31HPMCAOdr4iyb3Hj1ERYF46X3xX1301F/Vp50rEhlMhmCD6EtY0350g6dtF?=
 =?us-ascii?Q?8RpZeCPU5+eoGVi9QNiQzXeV+2ezzzQlVoYu/TsZrupq9DNGl/HgKcoP+KJA?=
 =?us-ascii?Q?d0WcR47jMAGCoo6S2xa4eF7LmzY5tJBkQwAFlIYQzIGc+bWgTyrD347VeL/g?=
 =?us-ascii?Q?lr86RNaxhS5q2RC9Ie9AAZiqWsCxK+YuRthiEZPCndIbirO7KljsdN4IY9k6?=
 =?us-ascii?Q?HpK0fSIXEHgKQDplrTtmN2padFloMYR69ETYkhX3swz/pzl+vhle/SVTAeR8?=
 =?us-ascii?Q?80vXb/GKLHX1r/nzfJ5NLAnLxEE0XWs1/vBIMj/IDib/+pn1X/fWfgFxikvb?=
 =?us-ascii?Q?oA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E1340C14019DAB488B61475618267B29@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3191f09e-c826-4baa-31ac-08da9fe7cac1
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2022 17:51:51.4110
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qta8XsnAf8Y4FMg99VsW1Cl4WyJWL73ZmsA2bYf7//KHi+tEivpamN1W12SczRJYLjLV2z9YoPppRlXEksNvEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4298
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-26_09,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209260111
X-Proofpoint-ORIG-GUID: J1Az2NcMpel8qj0ItU-AImh_jRdz8ffm
X-Proofpoint-GUID: J1Az2NcMpel8qj0ItU-AImh_jRdz8ffm
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 26, 2022, at 12:38 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> ...and mirror the semantics of queue_work. Also, queueing a delegation
> recall should always succeed when queueing, so WARN if one ever doesn't.

The description is not especially clear. It seems like the point
of this patch is really the part after the "Also, ..." Otherwise,
I'm not getting why this change is really needed?

Maybe a tracepoint would be less alarming to users/administrators
than would a WARN with a full stack trace? The kdoc comment you
added (thank you!) suggests there are times when it is OK for the
nfsd4_queue_cb() to fail.


> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> fs/nfsd/nfs4callback.c | 14 ++++++++++++--
> fs/nfsd/nfs4state.c    |  5 ++---
> fs/nfsd/state.h        |  2 +-
> 3 files changed, 15 insertions(+), 6 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
> index 4ce328209f61..ba904614ebf5 100644
> --- a/fs/nfsd/nfs4callback.c
> +++ b/fs/nfsd/nfs4callback.c
> @@ -1371,11 +1371,21 @@ void nfsd4_init_cb(struct nfsd4_callback *cb, str=
uct nfs4_client *clp,
> 	cb->cb_holds_slot =3D false;
> }
>=20
> -void nfsd4_run_cb(struct nfsd4_callback *cb)
> +/**
> + * nfsd4_run_cb - queue up a callback job to run
> + * @cb: callback to queue
> + *
> + * Kick off a callback to do its thing. Returns false if it was already
> + * queued or running, true otherwise.
> + */
> +bool nfsd4_run_cb(struct nfsd4_callback *cb)
> {
> +	bool queued;
> 	struct nfs4_client *clp =3D cb->cb_clp;

Reverse christmas tree, please.


>=20
> 	nfsd41_cb_inflight_begin(clp);
> -	if (!nfsd4_queue_cb(cb))
> +	queued =3D nfsd4_queue_cb(cb);
> +	if (!queued)
> 		nfsd41_cb_inflight_end(clp);
> +	return queued;
> }
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 211f1af1cfb3..90533f43fea9 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -4861,14 +4861,13 @@ static void nfsd_break_one_deleg(struct nfs4_dele=
gation *dp)
> 	 * we know it's safe to take a reference.
> 	 */
> 	refcount_inc(&dp->dl_stid.sc_count);
> -	nfsd4_run_cb(&dp->dl_recall);
> +	WARN_ON_ONCE(!nfsd4_run_cb(&dp->dl_recall));
> }
>=20
> /* Called from break_lease() with flc_lock held. */
> static bool
> nfsd_break_deleg_cb(struct file_lock *fl)
> {
> -	bool ret =3D false;
> 	struct nfs4_delegation *dp =3D (struct nfs4_delegation *)fl->fl_owner;
> 	struct nfs4_file *fp =3D dp->dl_stid.sc_file;
> 	struct nfs4_client *clp =3D dp->dl_stid.sc_client;
> @@ -4894,7 +4893,7 @@ nfsd_break_deleg_cb(struct file_lock *fl)
> 	fp->fi_had_conflict =3D true;
> 	nfsd_break_one_deleg(dp);
> 	spin_unlock(&fp->fi_lock);
> -	return ret;
> +	return false;
> }
>=20
> /**
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index b3477087a9fc..e2daef3cc003 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -692,7 +692,7 @@ extern void nfsd4_probe_callback_sync(struct nfs4_cli=
ent *clp);
> extern void nfsd4_change_callback(struct nfs4_client *clp, struct nfs4_cb=
_conn *);
> extern void nfsd4_init_cb(struct nfsd4_callback *cb, struct nfs4_client *=
clp,
> 		const struct nfsd4_callback_ops *ops, enum nfsd4_cb_op op);
> -extern void nfsd4_run_cb(struct nfsd4_callback *cb);
> +extern bool nfsd4_run_cb(struct nfsd4_callback *cb);
> extern int nfsd4_create_callback_queue(void);
> extern void nfsd4_destroy_callback_queue(void);
> extern void nfsd4_shutdown_callback(struct nfs4_client *);
> --=20
> 2.37.3
>=20

--
Chuck Lever



