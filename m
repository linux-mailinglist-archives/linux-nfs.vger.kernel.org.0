Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDF1E5FB45C
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Oct 2022 16:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbiJKONx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 Oct 2022 10:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiJKONw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 11 Oct 2022 10:13:52 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A2775388
        for <linux-nfs@vger.kernel.org>; Tue, 11 Oct 2022 07:13:51 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29BDTDti004307;
        Tue, 11 Oct 2022 14:13:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=FhCrjjQvZT29zbAVD/+dDSYGKSnZXXEG3CO2hnQzm64=;
 b=E6Mc1gk2UgolRI+q/6YVEuwvniMiA5FWsBuwKE+o9BaAgOT/m0EVTvIdubuHVOAw+s9W
 RPWf3YAXnf2bFZEXPPwde31ykxPFnSIDivDpJL4bDApyyqPIGU0rrCyGBSFmatjE7C+e
 j+dU9sUJFuLambxco2sJBFGP732gIQRZhXyRoDS1i8WUMOu1/eVnMvpfY8xWOfanBDxE
 02kbzHfDt1/4JfK/aWak8ixYzu3aU1tEF/x3UogbiZUewBKcXa/jGJq0ByWjHB92v+9U
 bY9UG2J8mqWcRKAj+xO9IPxNKlsI4amKtE/ucs7xZUmMyc/5O9gc+WBeqtQbDuh63ji/ HQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k31rteve2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Oct 2022 14:13:41 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29BDKFIQ002893;
        Tue, 11 Oct 2022 14:13:38 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2041.outbound.protection.outlook.com [104.47.57.41])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3k2yn3nv1d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Oct 2022 14:13:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RmOxyZYjoJ/sw1C6hMxP40gbjiBJvhdbJaGbeiNTBFStc6b/Zdar0yF5WvNasqE5PpqYQ2yiyIEB94I+PDK0IJqyD+BVzvOe4dmCL3pqAAoxYrcFYvigFiYcaJxCkLa+GTtJUDWTHdeH3cAvA7fVm5wNGUsU2NZT0mg4YRoFCNAPAewvp3DTO2XZU+fogovrE9W6f5MSIpNvCV+QcH51E8RFNRU1pLNp8/c7DbZK69DS1e7llmX9pHZbA/aRqkCqhV713fW2LbHU/Nr8OQdQ+D3N1Z7GEqZWxwUVn03GPdZhhMqHm9Ok+DYR76DZoqjzobB04nqO5f+R8WsfTbUJfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FhCrjjQvZT29zbAVD/+dDSYGKSnZXXEG3CO2hnQzm64=;
 b=GQgFrDCMT5CqNEBcMieTAvZdR4OeI9LFgEM5yXUR7n0aw49RJmES8HsJKn9ZnB9XxFiQBWpBNKegDYCINKHbj2ZETmBckMXE+Jb93CtzkGpnXAPj/ibCgBphuxWB6Xsi0vakFIwe6iqABecL2Q9jjMqH9ZIIHAt6LxodcwVzqnQnjcSYbSYJVPdQDHugHi7j9DSJ5bQ41CuhDg/o9CctE+Yk3nVMH+ysOP5Hmm1XkBdyvYizGTmUMYkG3sUlJFcjMQ6DjfaG3HatvEEVoTsotZzg1foY1vKwSQBa3iB7uL5r1m8MgVeaODDHDwUdaaO20xnw1XZZOchZnBFGZIPj4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FhCrjjQvZT29zbAVD/+dDSYGKSnZXXEG3CO2hnQzm64=;
 b=MCJGRbRuN7jOVaZiRgAMNVcQUwPwRoOgnamvLEpbMd5V5ioFKM/9TfH4wGcyz1ffnj2FCWH+1SMjAPUssiBKFYVLZhlMlJEXA9CaEMEPvvH1RPsuZelN0oZI5BHaXyy9ziJKMetzuThLofVDBPeMz5ULj0vUKEk4F6UyDygcSMY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB5008.namprd10.prod.outlook.com (2603:10b6:5:3b1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.21; Tue, 11 Oct
 2022 14:13:36 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a%3]) with mapi id 15.20.5709.015; Tue, 11 Oct 2022
 14:13:36 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
CC:     Jeff Layton <jlayton@kernel.org>, Dai Ngo <dai.ngo@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        syzbot <syzbot+ff796f04613b4c84ad89@syzkaller.appspotmail.com>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>
Subject: Re: [PATCH] NFSD: unregister shrinker when nfsd_init_net() fails
Thread-Topic: [PATCH] NFSD: unregister shrinker when nfsd_init_net() fails
Thread-Index: AQHY3G10iu4fpKkrz0yGWZtl8/tWcq4JPnGA
Date:   Tue, 11 Oct 2022 14:13:36 +0000
Message-ID: <D68E9E4C-93CE-4723-9A7B-A22CACA35093@oracle.com>
References: <0000000000008c976e05ea9f491d@google.com>
 <66b0ff35-c468-1a5b-3327-7e2ffcc768ee@I-love.SAKURA.ne.jp>
In-Reply-To: <66b0ff35-c468-1a5b-3327-7e2ffcc768ee@I-love.SAKURA.ne.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DS7PR10MB5008:EE_
x-ms-office365-filtering-correlation-id: f690ca21-7b87-499b-a675-08daab92c9c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dc3yROfvT1PqPkITOwO7t32M7xAjHOCRjEVu+NNhTe7mmevj8AihPXbWxQP+xDXntPu8i4EFCxZPDobJvbAIDSMMIYHSBySvQ9mlqMpX1LL/5wugxB3xPHbUzvDzmdlRvGQm+7nEWDrdw0aAHN44QzzYIS0W2wNGu//pkCWRE6VMa2ouCfQIt8gkjJrhiwknqsCy6LqccYtGfcDKQy7Cy9PnDfW2IyJ7WJTLusFeldGUGryNKpFIjkAdtCUX4/GZliycloyG14wLSPYwDek0/o/Cs4cKLbTiG0jH2xWCT+p19gSSZ3OxzWw59KHrd9iLQHZnrGF1+36H2NbZ/dlrU2u6vox5g/CmOUlRclkbLI2QrhGCzmvCKjSvAT7s++ItYb+yhisTySGc9mY5+zCfyB3vBthtSJylcvJynQ5oT6TvDEjzo9VXPztur0O4XWVD5dL8H7FvMqpkMarXIEyHHhGjCR9tHQfHbf6BXhrBQgBbknmrzI3QOlzP81o2lnYOY8FjCHnkZwJ5dRHlgFBLgiGtfYSFebQfherwSCC3F+PIe6F2UhQKIhko74TBrRtXz3kaCG+uQNGV2aK4Xfyk3ibvgovPkXuerCgh1U7/v2Dyd02TtIAHZPota17WguXaNuJGGJQCmUcdflegUAb3VrFsuZVeGQuAhopTS10RYoqkuFFnUdpSpWmU7l/40gYF4Py7cvcfij9R7Nf6ffhtukAb6SegBNvKjipBizkM1U3SiRMByVGDsB7uItSN1z6JpYviaUIH/a3itttOsnHwZbUO5C/vg2AMnpjzTmLRlnOJmuGEyG7QPwVBEZkD00itwnMrmGEZTTwAOlKPs9+vccMCh5FCEpk0N4xLQm+ES1aD5sZuHYxXc8B3opTUhAWIDnGUar6jVhhey9MVi0cEQw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(396003)(39860400002)(346002)(366004)(376002)(451199015)(6512007)(26005)(6916009)(316002)(122000001)(38100700002)(38070700005)(6486002)(71200400001)(8676002)(54906003)(36756003)(33656002)(86362001)(83380400001)(2616005)(186003)(53546011)(6506007)(966005)(478600001)(5660300002)(2906002)(8936002)(64756008)(66446008)(41300700001)(66946007)(91956017)(4326008)(66476007)(66556008)(76116006)(99710200001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?e0acmeQUMO8ed0FZ9Wa0cWhh/Ws1g3ifeg2dKzLd+BWPJaLtCNph4ksH7P4A?=
 =?us-ascii?Q?wfhvg0f8LOnZ4yJxUNsBDqEuhe/J5/eqc8UQB4wSCupMCtlareGFEvs1XENC?=
 =?us-ascii?Q?MgYz/80aaWBrs7oUxEP3N/vs1nfElR6bv3vfqOI7g73Vat+DERoJiNO1hOEH?=
 =?us-ascii?Q?SXe1XqWpQPo1oW/UaYV9X8TSjEh1rf1wf2H6tPv/50g8nmDmRNE34En7dGhx?=
 =?us-ascii?Q?TTA4vTJuMqaxCCfFGPjWmzKB2h5Q6goeGQxTRUFwdlTp4aQ2+6ri7pqUzByO?=
 =?us-ascii?Q?0SrwboiI5rGBCJdxOhnvKLbo0TgqH+VxbPTPfTyIT0PS936JL2tTRJJwYO9T?=
 =?us-ascii?Q?oVIGw+yvVWCCqAMditTfiR0e9DmyDzmqyUZXI10OdZubHuzBf+YnxpbxuC6w?=
 =?us-ascii?Q?Dp3ko83FCDB94CDgsq362HVXyj6qo6+R16tVXynNZM5L7CIyQh9JOxvrKKL7?=
 =?us-ascii?Q?SJmopG8VYA2dmdxL54xuGAfdlDEP7ZMXnKBCAjzg+9zebSaZcFwmyH+FW0FB?=
 =?us-ascii?Q?llRJkw8WJBIUj11vQXUILwDJXaU+Ty/GmWqUH+3cpbkSJgAs5T0WKaSxJ6n3?=
 =?us-ascii?Q?XR+7xJgIAarRRle9sAwLQ89tWLIJqpqII3xh6ITOETwgiSv9b8PI13M4dRz4?=
 =?us-ascii?Q?p72ecIBaSyhnArZSbGTtiiBJvxeiO4m1FnqOonw7CFwzfHA9nl7u1Kk98fF3?=
 =?us-ascii?Q?AG4qM2gObsgFfDfWj7/nDE98BHPeNz11uwm74lEhrgxvA/XsfVY+//qTFAoL?=
 =?us-ascii?Q?zO+JJwcdEAbLP+28nG5C/Hc4qFXgM3D/C/MOzXbBIHQMMnLRZxz7+lhzN9jx?=
 =?us-ascii?Q?gARTGnH7KTT+idS3CJlGayq62tZLT0oMi5LhNdTU+Y/4EjT5Kcvr5pWMi6xp?=
 =?us-ascii?Q?jMOxleuiBb/l3NEt3cfmpb9sE5tbgfPMjnLwF278vxc62z20tKXm5/m+RH8k?=
 =?us-ascii?Q?VAOXR4bM3g5WP/lPnETgQo4AnQmrCKmFS9M7PMAPBJTgAdI0TjwgB3R6zBZm?=
 =?us-ascii?Q?uI0gFVk57gaXmBEv1OFAf94JL33KNzComvs6W4gQipOoH386MhhduW9eJh1T?=
 =?us-ascii?Q?WyN1spTR44XMeLFIz3ZspmlfdEqwZZ4KFSqpcE0Tb/4B/0Q93Fg25AC6+Pc/?=
 =?us-ascii?Q?/AE9bIuPmfvrNr5xI17QMF7ZKBQq9SnAZAGNOImMWFmhsj2Tg+IFL2MnEYD5?=
 =?us-ascii?Q?pg8kuXKyN3tTaRYaBBKmR0lSYnpb+2iNETpJsu7cl/C+zCg+VAqqLERMWnDi?=
 =?us-ascii?Q?kFlDAmN27Kg7Qqkg9xlH6DB6prvoBbBvPJMAa0OCZBPlGgczKYCKK6ub197H?=
 =?us-ascii?Q?GBKFcsVMtBXpONlhDHwIjd6KeXVEqirtFQJE4GuiNuf24x4hEAJC4Z+wbUGq?=
 =?us-ascii?Q?4JtNB3TCZR/Gh8C4yi8V19TYUmH+3tP0hJwfnBFcxIslNR5tO5D715BAzfZQ?=
 =?us-ascii?Q?wp5MwGBAHuGP6wiaytLq+ebo8RtZKhb01FLwdwVafxCJQDi1zhTwQ6sbft61?=
 =?us-ascii?Q?yJoAF6nzS7cgk7ld8s1ti7OkU4FJQLp1xHXy2RZhY7YSz7mRkOgty8l90nlv?=
 =?us-ascii?Q?wRdy00OGOYjZvU+KCKGnRGtA2KkuItDMUUpRclm4GX3mskjMGq8K5yAZ2LB0?=
 =?us-ascii?Q?5w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <49BADFFC0FF2EF45B0F742315075A6E1@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f690ca21-7b87-499b-a675-08daab92c9c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2022 14:13:36.4807
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kacdv3CALKnZjma3zPBbMmWlosfqZIQ41lA+/u17FP0ZdE/BSvQalWLzP5ydy1Pf1OxCoCvSAlZOF3KZk4lRsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5008
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-11_08,2022-10-11_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 malwarescore=0 phishscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210110081
X-Proofpoint-GUID: LgJvMLdJZTkPgCnauADtRyj8neBcVfvx
X-Proofpoint-ORIG-GUID: LgJvMLdJZTkPgCnauADtRyj8neBcVfvx
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 10, 2022, at 1:59 AM, Tetsuo Handa <penguin-kernel@I-love.SAKURA.n=
e.jp> wrote:
>=20
> syzbot is reporting UAF read at register_shrinker_prepared() [1], for
> commit 7746b32f467b3813 ("NFSD: add shrinker to reap courtesy clients on
> low memory condition") missed that nfsd4_leases_net_shutdown() from
> nfsd_exit_net() is called only when nfsd_init_net() succeeded.
> If nfsd_init_net() fails due to nfsd_reply_cache_init() failure,
> register_shrinker() from nfsd4_init_leases_net() has to be undone
> before nfsd_init_net() returns.
>=20
> Link: https://syzkaller.appspot.com/bug?extid=3Dff796f04613b4c84ad89 [1]
> Reported-by: syzbot <syzbot+ff796f04613b4c84ad89@syzkaller.appspotmail.co=
m>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Fixes: 7746b32f467b3813 ("NFSD: add shrinker to reap courtesy clients on =
low memory condition")

I've applied this to nfsd's for-rc branch:

https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/log/?h=3Dfor-=
rc

Thanks!


> ---
> fs/nfsd/nfsctl.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index 6a29bcfc9390..dc74a947a440 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -1458,12 +1458,14 @@ static __net_init int nfsd_init_net(struct net *n=
et)
> 		goto out_drc_error;
> 	retval =3D nfsd_reply_cache_init(nn);
> 	if (retval)
> -		goto out_drc_error;
> +		goto out_cache_error;
> 	get_random_bytes(&nn->siphash_key, sizeof(nn->siphash_key));
> 	seqlock_init(&nn->writeverf_lock);
>=20
> 	return 0;
>=20
> +out_cache_error:
> +	nfsd4_leases_net_shutdown(nn);
> out_drc_error:
> 	nfsd_idmap_shutdown(net);
> out_idmap_error:
> --=20
> 2.34.1
>=20
>=20

--
Chuck Lever



