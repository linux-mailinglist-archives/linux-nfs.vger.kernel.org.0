Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 390095B7DAB
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Sep 2022 01:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbiIMX5s (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 13 Sep 2022 19:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiIMX5r (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 13 Sep 2022 19:57:47 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A57481E5
        for <linux-nfs@vger.kernel.org>; Tue, 13 Sep 2022 16:57:45 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28DN79hw025230;
        Tue, 13 Sep 2022 23:57:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=dqn2dVM9sncO2YijTJHNJ1xiIbMfrQnQX7y93zhydB0=;
 b=aQFfqx2tvrHYPDu5m+g/KT+3z2QBh4qyKb2S+bE3oTOwiN9zbHZtmXwM2VG5yj9yy8PJ
 f2ki7JwbmAt9vqeWyReO0v2ehX9nzYw47khYu2zHlfeRWpxCTBWAYWe+z6cJXNY275l2
 YR3CV1SeIJo03p5YNcqsvvK5ESSESW2NtK8E/iL1+xRWtYX6VvgrANstoQBMOCWtZ24Z
 JPlOi6gN53oLc/2MqUSuzDyuM5YA8He2LCqGXY7fpW4pSSehLlAkRn4Jq91TrTUR5mlx
 cMTLg6F0X6ypFoFu8egi+AAk+e5SXfgvx+L38nH26h/z4Tyh7kekgBKwQVB9UzdNZ3Ju lw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jjxyc8nxq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Sep 2022 23:57:40 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28DLt5Sc024024;
        Tue, 13 Sep 2022 23:57:39 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jjyegpkwf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Sep 2022 23:57:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K3XCIl8hqV63PZ2etAdxBtvX+/yfzQNRXmCXx+XWlOfkGe8aT2JAUWduTikHrfCWlZBtWEa4T01ctRgWsolnSEx1gp5zG013dNxAV30x/5t0bug6BU4SrErDocJKXzEmDhl/VcixtaxzZvcEAF9UsvlWNnr5DeuEFUZtyFf750pSmXAOTzprnqhhTuNCgnHPIEpRugYWsgRvBvUcfcm/oMSOV758uwtg4R8396ky3ukRpEIyU9rNhsZ1hdCkMEIEX9xcEANr6enqOnNM7HS3/+aN16sqI97lTc4yroSoRmgcIrlI/H24xUIr1aJQDj5t9C0fRWD3L/mTMqlhHcNSzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dqn2dVM9sncO2YijTJHNJ1xiIbMfrQnQX7y93zhydB0=;
 b=et7jYfuVz82SnDJqJn22Asdg/PCnsbMaZ67a9yRnLrhorw2WyQs2a5O52ugyIn05uccPoJXTU/3YwHZOEE/IubWa2k4c0kS0xA5goGa1aop1f4HqCUqwQVD0wr8x8S/tSre+fkiuWQzMn0C4nr7c9yKGpf/IfsHIwPrjyTaoZMUoAkmAz2ha2JqYnE/yWJe5V5q3zYJ6jjKmaP+gUj/8vLV3iOXLVABEiFMWA3Jd4NGoW7jRrt0OLdtBg6ERJRSMvCGolCGrq8Q7Ri0jbI/v95LizOXTeluYnRYBAZKkERkCazL1SG0btzIvsObYgqBg68bfRkM9I5aMiaAJblndCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dqn2dVM9sncO2YijTJHNJ1xiIbMfrQnQX7y93zhydB0=;
 b=BWbNbs9ziUma6sVzwAmFHonvPtCXlluCb/qEt+r4diU5oEwczkPzVs2zeMJcQois5WIJcAfVf7jRAQFP8ZuNiRCGa2vUAHc/qa8iIHC+JRXoWEzyK9tRs0hQUdjZeVHv1Pi3STvUs6bN+H+SufAgm9RIaEqwlMpNl0ubPExE/Lo=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO1PR10MB4691.namprd10.prod.outlook.com (2603:10b6:303:92::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Tue, 13 Sep
 2022 23:57:37 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa%4]) with mapi id 15.20.5612.022; Tue, 13 Sep 2022
 23:57:37 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     "jlayton@kernel.org" <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v6 2/2] NFSD: add shrinker to reap courtesy clients on low
 memory condition
Thread-Topic: [PATCH v6 2/2] NFSD: add shrinker to reap courtesy clients on
 low memory condition
Thread-Index: AQHYx4rDXodEiJC/VkSHvU72wcAza63eChwA
Date:   Tue, 13 Sep 2022 23:57:37 +0000
Message-ID: <2892FF26-A2A0-43E1-9D6C-4DC8B4E4F52C@oracle.com>
References: <1663085170-23136-1-git-send-email-dai.ngo@oracle.com>
 <1663085170-23136-3-git-send-email-dai.ngo@oracle.com>
In-Reply-To: <1663085170-23136-3-git-send-email-dai.ngo@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CO1PR10MB4691:EE_
x-ms-office365-filtering-correlation-id: 2e886351-8e36-40d5-b01d-08da95e3bc14
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5qAGpSCZjlg0nJOUMeKXqjRokP1PVref1g8bsdBI1ySZfvmTSThJr0xzaznPtEFrE3QCLUB/ytVL1P7F7gePBTUg/4BjCC7haTOpAw+pJrFQwYH81p3JUIvrOFF/+wCfTVIhHhXF22pmUP2cV2iQf+oMWhx9hQ5cDk5CLOgY+yxUH/je91bjZD+/ZuU0XBvZXTxuYa/Rl+7NIZuA4sNDTUBFiI3Vq4V0/GLpPG05rk8uOQjPUZkdoYsr3A2bKe9soPyKh5f/I7linqx0V52MxyMTQ7bkVs3PEXYgksTWNGaKuhRkU1vzSjIei0/4WEBWByyDGKNRFyFnZNU7505LqdL3qOEbKSFUqPwvHGsDItzl5ukmzv8R3A8h8K9r/9mR+jAgw6qTo/vbLbEFqP5rkWlm3n/921/4FDcyY6Fa1prU+ixblw4qPCh/zKBCKSC2+Z6qG29uvDby21w/VD+uBVGBdWy8q83AYn7kjnQll7kswRaE8jwMzSTIlS2fEHWJI4pM4HTljcYMW9rxwCwHYVKnCcBgql/Eiac1aEAo01pEgk4ff2Qaqc08SNWxgtCNoK80YlQuZ+n1GcLcxipxq24Uo9ax4OWc6br+4ClqlG718OHpQHYPUHDj+pNCp0ktjA/hRVM7vrCKNw5hneWeeuq9gXIn2t3CbqBMQBg5R8B92e/TnwTBjHxl2a9/CkS2/LaKPGlHgZ/ARxzngclgWHsmUhwlXeTZVjWhnqkhTxkKXzKWuozKDRzvAZYBsJ51hs64jhNhci44LpizW4muBQ7XKLXLTyKk7Xng+VobAW0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(376002)(39860400002)(346002)(396003)(451199015)(316002)(38100700002)(6636002)(6506007)(5660300002)(64756008)(122000001)(6512007)(6862004)(71200400001)(186003)(53546011)(76116006)(6486002)(54906003)(41300700001)(66476007)(66556008)(36756003)(33656002)(38070700005)(86362001)(478600001)(83380400001)(37006003)(91956017)(2906002)(8676002)(4326008)(66946007)(66446008)(26005)(2616005)(8936002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jcY4Pc/ab6Ey9cytyzcpfmZx66ZnPDeZD5ZvQJh6YAvKKMHgkMelJBXNX9cK?=
 =?us-ascii?Q?AeXsVE5+YMG8UX2OBvZu2PdzAZrvs4+otUH4Uv2bI3RW+97L6f+NqJrox8bf?=
 =?us-ascii?Q?ANYzOGUjJp2Lv0lPLlCQj8N8XGMfgeav6La9ifVl/WPKqvM2gXdG//nTb+Ig?=
 =?us-ascii?Q?8NOo0DV/seeg9567mspJzQydjAhuqLlHyZgKLeAE/8ZmW89mh5qIs+LGt5Iw?=
 =?us-ascii?Q?el4DhUg8HoRgqH9yPMwYA3IxwzGYPLp8m2dTPsIlsSAzDZ0YJZ9ep107oNed?=
 =?us-ascii?Q?NA5w9XI4x9CH4oVOJT3b/MuH4TiSZqk3ja40kulBCsZSvYfLzhhAYnqb0ZOA?=
 =?us-ascii?Q?qLVsekoaOHUK3kGmwyofyzkXrr6rjI+tfdQx77Kx9UvRZx7XJEL01pAeOP6j?=
 =?us-ascii?Q?kcjyOesHkPBIn25zplB+LWlIZ7U2xzKl38y/guAHxeZb57YYVvEag3vyr2jo?=
 =?us-ascii?Q?89dsB8RgTy8iJ3L5WmFlBOVKx+WlrJiv0ZDc4z7yqFYdU1yCSTPno/qX4LIC?=
 =?us-ascii?Q?+QTHV9tQHzOvEeTFDsOY6n4Xwl0TBgP2/0zv1xrwkKzViwerBDDjPORw6YyB?=
 =?us-ascii?Q?HQ6KaYTqgyX9bLm7aIjo78KuppQiMUAR9MI4xkqtv9OMmBfcSd+qftQlkhyl?=
 =?us-ascii?Q?eqPMCpWdVPNV0wp3jYbRIS1BilhF9LYZp31d9VHQUCJdzCo5E9jl4UxS0V2b?=
 =?us-ascii?Q?mHQNfABhTZEBnAYNLphGBa36C0NMuG3HrTDN8Yiv8srHYSrLO4AI/biuYatp?=
 =?us-ascii?Q?hul+NvZH3lf6QK+KLcKECTtTUlOCx6smeqolK875+iiCkaCTAJVFoXNxrATq?=
 =?us-ascii?Q?kk3/quaxUCuyuAuYONDNDJdoGKtmNVf+3N+tOMApRn/10PLCsj9sTJ758V2N?=
 =?us-ascii?Q?xTzSOSyHAhLDkgszYAteGB0dZXYe8eh3QA8Spx7XkB+NZ7U9EPgYMuPceNJG?=
 =?us-ascii?Q?lLRSo1+aKoNkubkkdze3aV/PojGUzBpFGlxvudi07SNUGboEg3QRhl6eJZmV?=
 =?us-ascii?Q?aLw56xTlj1ccfgPsVOaU8f7nGlnp6XX/s25y8tBh+7AG+hbIcnXQWag1MdTt?=
 =?us-ascii?Q?JOksdI3w0xxXYypJMXi3XTkERbrllWne4rplWXLhWhiFuqEQX4jyx0lzfW/j?=
 =?us-ascii?Q?RAl7pd3RyrJB24Nr4PJ+CgEmuUl4nuUzWQRDJpzS59IIpNLPaBJPqss3JGqg?=
 =?us-ascii?Q?PPWMWTYVpvRlgZAgu4YCx/KxyIjwnpEPwvusU1L1LQGLEm61eshwZ/hMbQz1?=
 =?us-ascii?Q?WTPDZcZ1NN9qlz99bYPz3TKn4uxQAs/C9OZmXzMCjTpzf/TNGixx94BRKgyg?=
 =?us-ascii?Q?fcLIMOIsxqPox9D83mJevMB3CIi+8tf45c68Qcl2uO7jcQIlvrDmBd2qkFEg?=
 =?us-ascii?Q?joizk368UT/LHTOKJh97/fsjVln7obnAxmgj6GjtZTZx9OmgY6A5apKZoHGS?=
 =?us-ascii?Q?EPkdc+ML7Nb7ylm+7PDa/HfSKaWL2wxhpQZD3Fg06lBxebpqPoBZUAsBlew1?=
 =?us-ascii?Q?hM2jInQlha/qfeWKWiUoHABe/c9eL1xHfBxmMgJYxhyk6dVDGCRZhK6FqS81?=
 =?us-ascii?Q?YpQ0E3jfY4R0uVHppDkD1ojFUxg5QarNt2qkhAWOWbXkaVSEvKbLy6xQ0Nze?=
 =?us-ascii?Q?Yw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FA50C72831C34C449F8331E4DF1A9D51@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e886351-8e36-40d5-b01d-08da95e3bc14
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2022 23:57:37.1308
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IsVIW4mmCH5OcFG32iKJSJeOC/WMhk++IBZf/b3QthCg7kvW5pSpbOubLSA9tbNNj86Q4fYOjUbnrhnW+lzfaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4691
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-13_10,2022-09-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 phishscore=0 spamscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2208220000 definitions=main-2209130111
X-Proofpoint-ORIG-GUID: n3OJDAHYwYAJonOKkdXDgKwE5jFdmx4R
X-Proofpoint-GUID: n3OJDAHYwYAJonOKkdXDgKwE5jFdmx4R
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 13, 2022, at 9:06 AM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
> Add courtesy_client_reaper to react to low memory condition triggered
> by the system memory shrinker.
>=20
> The delayed_work for the courtesy_client_reaper is scheduled on
> the shrinker's count callback using the laundry_wq.
>=20
> The shrinker's scan callback is not used for expiring the courtesy
> clients due to potential deadlocks.
>=20
> The courtesy_client_reaper rechedules itself to run if low memory
> condition persits and there are more courtesy clients in the system.
>=20
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
> fs/nfsd/netns.h     |   3 ++
> fs/nfsd/nfs4state.c | 102 +++++++++++++++++++++++++++++++++++++++++++++++=
-----
> fs/nfsd/nfsctl.c    |   6 ++--
> fs/nfsd/nfsd.h      |   7 ++--
> 4 files changed, 106 insertions(+), 12 deletions(-)
>=20
> diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
> index 55c7006d6109..37457b104eee 100644
> --- a/fs/nfsd/netns.h
> +++ b/fs/nfsd/netns.h
> @@ -194,6 +194,9 @@ struct nfsd_net {
> 	int			nfs4_max_clients;
>=20
> 	atomic_t		nfsd_courtesy_clients;
> +	atomic_t		nfsd_client_shrinker_cb_count;

Now that you have a separate function to handle courtesy
client reaping, please get rid of nfsd_client_shrinker_cb_count.


> +	struct shrinker		nfsd_client_shrinker;
> +	struct delayed_work	nfsd_shrinker_work;
> };
>=20
> /* Simple check to find out if a given net was properly initialized */
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 3af4fc5241b2..fed4ca3fb581 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -4347,7 +4347,28 @@ nfsd4_init_slabs(void)
> 	return -ENOMEM;
> }
>=20
> -void nfsd4_init_leases_net(struct nfsd_net *nn)
> +static unsigned long
> +nfsd_courtesy_client_count(struct shrinker *shrink, struct shrink_contro=
l *sc)
> +{
> +	int cnt;
> +	struct nfsd_net *nn =3D container_of(shrink,
> +			struct nfsd_net, nfsd_client_shrinker);
> +
> +	atomic_inc(&nn->nfsd_client_shrinker_cb_count);
> +	cnt =3D atomic_read(&nn->nfsd_courtesy_clients);
> +	if (cnt > 0)
> +		mod_delayed_work(laundry_wq, &nn->nfsd_shrinker_work, 0);
> +	return (unsigned long)cnt;
> +}
> +
> +static unsigned long
> +nfsd_courtesy_client_scan(struct shrinker *shrink, struct shrink_control=
 *sc)
> +{
> +	return SHRINK_STOP;
> +}
> +
> +int
> +nfsd4_init_leases_net(struct nfsd_net *nn)
> {
> 	struct sysinfo si;
> 	u64 max_clients;
> @@ -4368,6 +4389,17 @@ void nfsd4_init_leases_net(struct nfsd_net *nn)
> 	nn->nfs4_max_clients =3D max_t(int, max_clients, NFS4_CLIENTS_PER_GB);
>=20
> 	atomic_set(&nn->nfsd_courtesy_clients, 0);
> +	atomic_set(&nn->nfsd_client_shrinker_cb_count, 0);
> +	nn->nfsd_client_shrinker.scan_objects =3D nfsd_courtesy_client_scan;
> +	nn->nfsd_client_shrinker.count_objects =3D nfsd_courtesy_client_count;
> +	nn->nfsd_client_shrinker.seeks =3D DEFAULT_SEEKS;
> +	return register_shrinker(&nn->nfsd_client_shrinker, "nfsd-client");
> +}
> +
> +void
> +nfsd4_leases_net_shutdown(struct nfsd_net *nn)
> +{
> +	unregister_shrinker(&nn->nfsd_client_shrinker);
> }
>=20
> static void init_nfs4_replay(struct nfs4_replay *rp)
> @@ -5909,10 +5941,50 @@ nfs4_get_client_reaplist(struct nfsd_net *nn, str=
uct list_head *reaplist,
> 	spin_unlock(&nn->client_lock);
> }
>=20
> +static void
> +nfs4_get_courtesy_client_reaplist(struct nfsd_net *nn,
> +				struct list_head *reaplist)
> +{
> +	unsigned int maxreap =3D 0, reapcnt =3D 0;
> +	struct list_head *pos, *next;
> +	struct nfs4_client *clp;
> +
> +	maxreap =3D NFSD_CLIENT_MAX_TRIM_PER_RUN;
> +	atomic_set(&nn->nfsd_client_shrinker_cb_count, 0);
> +	INIT_LIST_HEAD(reaplist);
> +
> +	spin_lock(&nn->client_lock);
> +	list_for_each_safe(pos, next, &nn->client_lru) {
> +		clp =3D list_entry(pos, struct nfs4_client, cl_lru);
> +		if (clp->cl_state =3D=3D NFSD4_ACTIVE)
> +			break;
> +		if (reapcnt >=3D maxreap)
> +			break;
> +		if (!mark_client_expired_locked(clp)) {
> +			list_add(&clp->cl_lru, reaplist);
> +			reapcnt++;
> +		}
> +	}
> +	spin_unlock(&nn->client_lock);
> +}
> +
> +static inline void
> +nfs4_process_client_reaplist(struct list_head *reaplist)
> +{
> +	struct list_head *pos, *next;
> +	struct nfs4_client *clp;
> +
> +	list_for_each_safe(pos, next, reaplist) {
> +		clp =3D list_entry(pos, struct nfs4_client, cl_lru);
> +		trace_nfsd_clid_purged(&clp->cl_clientid);
> +		list_del_init(&clp->cl_lru);
> +		expire_client(clp);
> +	}
> +}
> +
> static time64_t
> nfs4_laundromat(struct nfsd_net *nn)
> {
> -	struct nfs4_client *clp;
> 	struct nfs4_openowner *oo;
> 	struct nfs4_delegation *dp;
> 	struct nfs4_ol_stateid *stp;
> @@ -5941,12 +6013,8 @@ nfs4_laundromat(struct nfsd_net *nn)
> 	}
> 	spin_unlock(&nn->s2s_cp_lock);
> 	nfs4_get_client_reaplist(nn, &reaplist, &lt);
> -	list_for_each_safe(pos, next, &reaplist) {
> -		clp =3D list_entry(pos, struct nfs4_client, cl_lru);
> -		trace_nfsd_clid_purged(&clp->cl_clientid);
> -		list_del_init(&clp->cl_lru);
> -		expire_client(clp);
> -	}
> +	nfs4_process_client_reaplist(&reaplist);
> +
> 	spin_lock(&state_lock);
> 	list_for_each_safe(pos, next, &nn->del_recall_lru) {
> 		dp =3D list_entry (pos, struct nfs4_delegation, dl_recall_lru);
> @@ -6029,6 +6097,23 @@ laundromat_main(struct work_struct *laundry)
> 	queue_delayed_work(laundry_wq, &nn->laundromat_work, t*HZ);
> }
>=20
> +static void
> +courtesy_client_reaper(struct work_struct *reaper)
> +{
> +	struct list_head reaplist;
> +	struct delayed_work *dwork =3D to_delayed_work(reaper);
> +	struct nfsd_net *nn =3D container_of(dwork, struct nfsd_net,
> +					nfsd_shrinker_work);
> +
> +	nfs4_get_courtesy_client_reaplist(nn, &reaplist);
> +	nfs4_process_client_reaplist(&reaplist);
> +	if (atomic_read(&nn->nfsd_client_shrinker_cb_count) > 0 &&
> +			atomic_read(&nn->nfsd_courtesy_clients) > 0) {
> +		queue_delayed_work(laundry_wq, &nn->nfsd_shrinker_work,
> +				NFSD_CLIENT_SHRINKER_MINTIMEOUT * HZ);

IIUC, the count_objects callback will schedule reaping again if
it should be necessary. In fact, I wonder if it's possible for
count_objects to schedule this nn just as we're calling
queue_delayed_work() here -- that would corrupt the list of
work queue items, I would think.

I don't think we want a recursive invocation here -- you can get
rid of this queue_delayed_work and CLIENT_SHRINKER_MINTIMEOUT.


> +	}
> +}
> +
> static inline __be32 nfs4_check_fh(struct svc_fh *fhp, struct nfs4_stid *=
stp)
> {
> 	if (!fh_match(&fhp->fh_handle, &stp->sc_file->fi_fhandle))
> @@ -7845,6 +7930,7 @@ static int nfs4_state_create_net(struct net *net)
> 	INIT_LIST_HEAD(&nn->blocked_locks_lru);
>=20
> 	INIT_DELAYED_WORK(&nn->laundromat_work, laundromat_main);
> +	INIT_DELAYED_WORK(&nn->nfsd_shrinker_work, courtesy_client_reaper);
> 	get_net(net);
>=20
> 	return 0;
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index 917fa1892fd2..597a26ad4183 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -1481,11 +1481,12 @@ static __net_init int nfsd_init_net(struct net *n=
et)
> 		goto out_idmap_error;
> 	nn->nfsd_versions =3D NULL;
> 	nn->nfsd4_minorversions =3D NULL;
> +	retval =3D nfsd4_init_leases_net(nn);
> +	if (retval)
> +		goto out_drc_error;
> 	retval =3D nfsd_reply_cache_init(nn);
> 	if (retval)
> 		goto out_drc_error;
> -	nfsd4_init_leases_net(nn);
> -
> 	get_random_bytes(&nn->siphash_key, sizeof(nn->siphash_key));
> 	seqlock_init(&nn->writeverf_lock);
>=20
> @@ -1507,6 +1508,7 @@ static __net_exit void nfsd_exit_net(struct net *ne=
t)
> 	nfsd_idmap_shutdown(net);
> 	nfsd_export_shutdown(net);
> 	nfsd_netns_free_versions(net_generic(net, nfsd_net_id));
> +	nfsd4_leases_net_shutdown(nn);
> }
>=20
> static struct pernet_operations nfsd_net_ops =3D {
> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> index 57a468ed85c3..cd92f615faa3 100644
> --- a/fs/nfsd/nfsd.h
> +++ b/fs/nfsd/nfsd.h
> @@ -343,6 +343,7 @@ void		nfsd_lockd_shutdown(void);
> #define	NFSD_COURTESY_CLIENT_TIMEOUT	(24 * 60 * 60)	/* seconds */
> #define	NFSD_CLIENT_MAX_TRIM_PER_RUN	128
> #define	NFS4_CLIENTS_PER_GB		1024
> +#define	NFSD_CLIENT_SHRINKER_MINTIMEOUT	1   /* seconds */
>=20
> /*
>  * The following attributes are currently not supported by the NFSv4 serv=
er:
> @@ -498,7 +499,8 @@ extern void unregister_cld_notifier(void);
> extern void nfsd4_ssc_init_umount_work(struct nfsd_net *nn);
> #endif
>=20
> -extern void nfsd4_init_leases_net(struct nfsd_net *nn);
> +extern int nfsd4_init_leases_net(struct nfsd_net *nn);
> +extern void nfsd4_leases_net_shutdown(struct nfsd_net *nn);
>=20
> #else /* CONFIG_NFSD_V4 */
> static inline int nfsd4_is_junction(struct dentry *dentry)
> @@ -506,7 +508,8 @@ static inline int nfsd4_is_junction(struct dentry *de=
ntry)
> 	return 0;
> }
>=20
> -static inline void nfsd4_init_leases_net(struct nfsd_net *nn) {};
> +static inline int nfsd4_init_leases_net(struct nfsd_net *nn) { return 0;=
 };
> +static inline void nfsd4_leases_net_shutdown(struct nfsd_net *nn) {};
>=20
> #define register_cld_notifier() 0
> #define unregister_cld_notifier() do { } while(0)
> --=20
> 2.9.5
>=20

--
Chuck Lever



