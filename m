Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 017505EB089
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Sep 2022 20:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbiIZSvw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 26 Sep 2022 14:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbiIZSvv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 26 Sep 2022 14:51:51 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44EB47D1E8
        for <linux-nfs@vger.kernel.org>; Mon, 26 Sep 2022 11:51:50 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28QHYSuH005504;
        Mon, 26 Sep 2022 18:51:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=oVb1xftDcrK24kMZLAeAW8zzyGPcwWY0qyMMX9WL9Ao=;
 b=eZoC5OFkg8KenDmqgM7Ej78G8e3asXdzhkWhzxApMa92rSxSbXMTdpynSOOp4kQXGC8k
 2I08sZA3ICNXCV5j0fJk8hVaDlXqHFI1xMBQj68VaCs3qu4bQgv7nhkJBUBFNC2IKxga
 4p3nsIrF29kFLNekUEBi5NAPfvYG65VPZmGATocvQ2Ydlcol3+GoNPaI6N9EpG+Fzind
 w5QuSovM848as3jWHOOdJS+y+oqWQJdAKsx8nloqii4AgXmySH4bX4W51Obi6r5ZlLZA
 Oj/9PChUEwl8WCrvvgrUDUJw3ZHq75sXQ5KRBieFbCUJ92VnCDllrNV5yB8raD+LhSJo 5w== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jst0kmfkk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Sep 2022 18:51:46 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28QI2gXq023804;
        Mon, 26 Sep 2022 18:51:46 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jtpq790c2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Sep 2022 18:51:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JZOI8drYe13paCOg3BpVhajbLFbPqzfIFW/r2fNdEFc1TbeTvGqQyokbR6eJ0Ds7bdpgDImXKaABJDp5cCrIKVeLsZKNZDddNSvh8mm7NvasgxUyVFJbMHCPu3l8GAXClIAFxahvcqoTRtrp3RAsVW4DZpj2yZ/4ExMPa/iI3t7XuG5zAJu1sWAaNQQH4mhVFpzyQMopPddwyOR7ojMVbaviY4zGlvBK5T528n3DWtAGrmJy/GvnpNAqOyJn9LJXYamyeiDVBj950RlZ+omX8jRxF0Zc53jzdYsbxz7JLXMHvGm7CpB78I6Usn7kkDiyv/iYM1k+J+A2Dh9Udiufug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oVb1xftDcrK24kMZLAeAW8zzyGPcwWY0qyMMX9WL9Ao=;
 b=oV3eI8w90Bf3qHWWcgDv8mpPb8RYneTR8nGuxUxGlmul5u9I6/A3uRmm6Ttl0vh7nyutjgH8NoN59lqsaSPsQDNYLsjR4MbHNtoIpOM/HrZl7eJOPJJ8nC6Zp3rWUTj/KOHTk26W+DJ89Zjg2uOQfisWBt8DaCL27+3YenvYZfC8JxRb88IL/foZjrxMUIW4lw6Ofe0cOozl1q1haVAf/2TDhXIPd+dL5vmyreNXYDohHD9HjsAAdKJBTB7cD4OAO7SAYsWH3lLlNrIwY/kW5RPnpKmUWoyGP21+bTHhNOeH8fBq5k90AbcB7kQkuWz0VjbbouCyyGjyZQajo6BrnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oVb1xftDcrK24kMZLAeAW8zzyGPcwWY0qyMMX9WL9Ao=;
 b=mRpjFyO2+EGR13dAymEFVtTKbx46MTvE01OD7cHADDLJXjkGxvWJ0rJ/RvGql0cPYJyi6KS7Af68HJtxG/0kgQK8tz3wsmZTj8Jceq5VSoGIitl7jLb0xPDM4B6n3HSr4zwE/Bzxjb6IYnm0I1iU/fUVkGars6X2HuLkmnEKhkw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB4446.namprd10.prod.outlook.com (2603:10b6:a03:2d9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Mon, 26 Sep
 2022 18:51:43 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa%4]) with mapi id 15.20.5654.026; Mon, 26 Sep 2022
 18:51:43 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] nfsd: make nfsd4_run_cb a bool return function
Thread-Topic: [PATCH v2 1/2] nfsd: make nfsd4_run_cb a bool return function
Thread-Index: AQHY0deMNi0CuqlitEGY2lsl3vS/l63yDlkA
Date:   Mon, 26 Sep 2022 18:51:43 +0000
Message-ID: <AE632F67-832B-43F2-A122-AA67BAFA7A0C@oracle.com>
References: <20220926184102.57254-1-jlayton@kernel.org>
In-Reply-To: <20220926184102.57254-1-jlayton@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SJ0PR10MB4446:EE_
x-ms-office365-filtering-correlation-id: 80d85b54-49eb-40be-cc99-08da9ff027eb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TT7zLBGVSyFQks84P6CFXV6O3tHRHoYR6hWKI3rk9ZYSc9d2JDIU8+KZ8EO2zGdSBmAfauf6brJPgPeSBbhCUTbmrMukIOgbeVlYbmTVCKJB4PKCNCeozGHfvSulwyXwl9k0U4spnY6W+DhoBa/dPWA/wZxIu7P00H77VVJ+VBhFvR0oBY2JqaXBHvqRHvoObS9IAP4z2npOh21HJ8K7TXGl4689MAIDa2Xm1JlsZ7iYqSh/aARJWu+essJcD2oopA5ZX8JZ+vH46IMcaQCaPYodQvp/2/tEtjhcGAG6ieSAvaNpiJFRXAf1QsTIfa7/LSNOMgt8kkjbiC0Fnsa1QVYsjaTA/D1TyNio0WyfBgLSE2VwzUPaob/zCbDCqlHeuQmCR2vw+JCwryuA0QU33s6ZxpqI51x8V/1A4EJXn5pMoisxydMTM0sw7BPu6HpJMnvfDokIsU4fGWvY/Lnvu5tKV+aMMIwwmSbCvi7V0q/fqEN3PKMMzi1PdaoXr3+o78YZ8UzK3roNmjhYrz8a7U0r5V+dUKHf1Cu/JZ0ToT0bcJCjUhR/8s8eQLxVHKTE4/3Fbz4PAfi2cxzQhhdXiV7FDXToGLQPTe6OVo5rpZ9Y5MSup7uTkUBTY+OWk1EgAoDyRDeYit2KSPD/DWfQl9CY07mPs95leWH5Mn2Gq+buM+raZv/97Z4vyhju+XABvG1wXvZmoufJoqRu+ZyLZsi2TnE62GLJQ5gY1hCg2HDXl5zhGhG8nJPP5Dj5W1AA+bqsT2iQzC5AV711al9yNE9fw5vqV8J3oEK+fZCzb7Q=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(376002)(396003)(39860400002)(136003)(451199015)(38070700005)(36756003)(33656002)(38100700002)(86362001)(83380400001)(2906002)(5660300002)(71200400001)(2616005)(26005)(6506007)(6512007)(122000001)(53546011)(186003)(4326008)(91956017)(316002)(6916009)(478600001)(66556008)(64756008)(66476007)(41300700001)(66946007)(76116006)(8676002)(66446008)(8936002)(6486002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?E3pi+XeRG+G+8GwlN820gitudKC5V5WdAjsZBLwYWEyDyzCCnB9ALkbbfcrS?=
 =?us-ascii?Q?Ss8Td6/qxWs9/Lna093FimwCbI5j9Y0VICgVb/fNAf4NigSveZKpwTKi4pK/?=
 =?us-ascii?Q?4wUku6fqevfREHaVV3NQyhBxi1ctiMQHQqNmLw/y2uzn398bNRsTPNhPaUqY?=
 =?us-ascii?Q?rT9Pjm9ykZMtIZ9VnKVHhsL4YRqm+SGCgxZFl3v+SgUwuOAsU0B6Yx5Rr5GJ?=
 =?us-ascii?Q?6p2YBt43IJueTQDM6nf0Uwi6+GU9HM7ttewxuf0kLc0gBo90yy0QbATzdZXn?=
 =?us-ascii?Q?xV7yM7vB693kvhW1OW8ev9BkwGTX61d5aDY/lYzgdmF1i5Lt8nxuw/2rkug7?=
 =?us-ascii?Q?6P+sfJB6yNubfTE0+EX3txqvkGdJ9tqdX1M/+fRaCA2/wx0CnHzgmXPxIO77?=
 =?us-ascii?Q?6xYDDnrVXhwBzN73Rr4ad4buuh5Za7x9hT3q/VQwsuAGXYIwcPCwh8pTsSoE?=
 =?us-ascii?Q?DfIf27jtGOE26HTpmcVX1YEkJSXCTO6wDpo567Ac0KMaznzsX1WKnNiw/TNR?=
 =?us-ascii?Q?mYEI4XMN8DchRr/pVw6m1CdXe/yC8K+6jNNA0vSB78DUoABPmkLLYY802DuP?=
 =?us-ascii?Q?cF843Dme7XhW+8SIWIEG2Cp4PxNOWZDg89XIUBY1QOWEg+TPfVQqz6q0+rQI?=
 =?us-ascii?Q?GLNTT0X/+zLZIt8kGOvkznKGBsrGjshEWztUeXz2Z6/NOB4yqzn0/P66vY/K?=
 =?us-ascii?Q?nK4pv1FNQXrEU+ZbLinJpGlosyqzMeklgNFx1dExh1mVTAb4//gLip7PoRkE?=
 =?us-ascii?Q?cHW1MlSokvaK8OlzD9hqTfoxZAWkWKEAxNxFah1jtbL8cRcjNAiVmeVAckiL?=
 =?us-ascii?Q?0+cFas5kcaM19KAHnHkQ60xlKPX84Ec97p+TJ7BNg2jAsP9pGQy9CNiv7pN5?=
 =?us-ascii?Q?Gs1akebR1ok4/R1P12lHzi5btQlwaKSy6Y7gu6yzBqkDhmtHu7H+Zv75mtcQ?=
 =?us-ascii?Q?Li+woC1oJZWYMXENcczKv3lbNUD0uUStcDSxOLgXnPtDhDR9cU/nJvCVwsnY?=
 =?us-ascii?Q?JX+XqaUj/c1h+2wZWmdQ0tyMSw53HfL2h4wfcbZEzQPjzQZMPzREkqLkio5/?=
 =?us-ascii?Q?C4aB9EhGFpnQ49FBg398eXz0zNnbQ+Kq+WIvpw9GfI5mA+HZkeOTs+rrxxIx?=
 =?us-ascii?Q?Nn7Yi3VtiRbUcAkJHm6Y1z4F3bEL8T4D0wX2BeKHCcyJ+0no5rVth/cbUsXB?=
 =?us-ascii?Q?8c3BgZRhUi3UPqLzE3pxBSEj4cO2JVyjtjXeFSMWFV6YbuNW7I/+51IA/ZKc?=
 =?us-ascii?Q?zHqCjh++K03BSDksZTAIGOZEYD00g13OUB1x7K/tofgVwcLh8v+QkFEfquje?=
 =?us-ascii?Q?1AaybiQ4eS6Mws6qd5VPRfhJZZSX711uopK46srEJoxYmTWx+XC3g85knREW?=
 =?us-ascii?Q?3JJxnmTaheXT372rzQi3OEBORx+iBrtRnYW7wcURybNbaH5X4DAU6+Ma1DWA?=
 =?us-ascii?Q?00DHJ/fYmZJkK7kTYgPPJl2Q1t7sBM3ygh7Hd24F6EH/LeF/eppxSD1Lj3KA?=
 =?us-ascii?Q?30SiypUWDEDqF5uXjCclsoY6ZL4hWUJjJE4FnRGnGBpsqm1VnndBaxUaYZij?=
 =?us-ascii?Q?A0eaYpZ0zCH7txg1agNC5JEylyFQTVw2p017Y9CojUw0WLiKCakflsT8wBtN?=
 =?us-ascii?Q?BA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <357E3BD94B6BA4499509B43186BD07FF@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80d85b54-49eb-40be-cc99-08da9ff027eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2022 18:51:43.6766
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zDj/EDj49OnfJfypPusezJhqLTPvFeuMP09kdxR58hVnRpH+QfmNaxV9J8XaTXyx3fBiIeIJ0k2uZG3jbz4sdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4446
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-26_09,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 adultscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209260117
X-Proofpoint-GUID: yaocXx3SHD8_Q7JXQpittM8HwOZlQpwj
X-Proofpoint-ORIG-GUID: yaocXx3SHD8_Q7JXQpittM8HwOZlQpwj
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 26, 2022, at 2:41 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> queue_work can return false and not queue anything, if the work is
> already queued. If that happens in the case of a CB_RECALL, we'll have
> taken an extra reference to the stid that will never be put. Ensure we
> throw a warning in that case.
>=20
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> fs/nfsd/nfs4callback.c | 14 ++++++++++++--
> fs/nfsd/nfs4state.c    |  5 ++---
> fs/nfsd/state.h        |  2 +-
> 3 files changed, 15 insertions(+), 6 deletions(-)

Thank you, Jeff. Both applied to nfsd's for-next.


> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
> index 4ce328209f61..c4ee4a820a62 100644
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
> + * on a queue, true otherwise.
> + */
> +bool nfsd4_run_cb(struct nfsd4_callback *cb)
> {
> +	bool queued;
> 	struct nfs4_client *clp =3D cb->cb_clp;
>=20
> 	nfsd41_cb_inflight_begin(clp);
> -	if (!nfsd4_queue_cb(cb))
> +	queued =3D nfsd4_queue_cb(cb);
> +	if (!queued)
> 		nfsd41_cb_inflight_end(clp);
> +	return queued;
> }
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index e116f50afcf2..c78c3223161e 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -4859,14 +4859,13 @@ static void nfsd_break_one_deleg(struct nfs4_dele=
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
> @@ -4892,7 +4891,7 @@ nfsd_break_deleg_cb(struct file_lock *fl)
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



