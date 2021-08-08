Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDB9C3E3C8D
	for <lists+linux-nfs@lfdr.de>; Sun,  8 Aug 2021 21:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232184AbhHHTg7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 8 Aug 2021 15:36:59 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:25936 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230201AbhHHTg6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 8 Aug 2021 15:36:58 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 178JUqqr021578;
        Sun, 8 Aug 2021 19:36:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=3HyOMc9TGzbXtVViCiSP6GNiP3vWhHENoaX4Qz7LBcw=;
 b=ukndcz5Q4R0DdwTkeKH7jXxfSIopTBJtSU9VkM5Z1LHD8y0cMZ9uIxrjgSrYnDmp9/gp
 iOpwXqU34NW2TX6M4j923ddJRz0eIjd9gOzUXtrK8kkjijK9OjHDauD8qCciOZoU7+Mr
 KlWS5bEwAjCTjCFNHMhgartV1HtYNNhEZHBeGMcMLdpJoWnmsZ6HbsJzZhRwaxo6gSLK
 KjhxqaDPJ+rsZylJ9j+HtfVu22r5MVdjpTfF96NSFxvI6BIzjEnR26xW368UzlzEoYaY
 bJs19xvjDJQrsT1k3kwS2hdl9ApzAsgrrO95i9cmrvcDInYpgyB+UbkNaS/I4r2Ib0jL 0A== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=3HyOMc9TGzbXtVViCiSP6GNiP3vWhHENoaX4Qz7LBcw=;
 b=scpw2Uz8ew4xkwHp0IwL5UXdrKzgm2S7x0W2AxlMMZiV0tZH5YBbSkwRM+93syVZ1j2W
 UHvCnvHm+FAR2Xjsih0LDQjevXy8aKcJD9FT7i7P4MMzv7RgyhZi8/Lugg7rwCf6Hqis
 7PICvzj4KvRbeLzQs5SResTUdAVuZUm3BQzSY19x8rQLZuqPpLvlakdfiChI63/AkxpQ
 tSTSptnuDaxgV0W5RVreJVq0Se7fN5RSTmsNyA5BSzBV+CRiWdSQYfEcNW5oTe+OV/Qr
 a2Cw5hm7X8Nq8lk8lk5Ac1IaVoBcIIWD8oKhAVLrrEkXZyeoVnwNdmqW9nJlTU8OmL/e eQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a9gkd1va9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 08 Aug 2021 19:36:21 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 178JU1qo130888;
        Sun, 8 Aug 2021 19:36:20 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by userp3030.oracle.com with ESMTP id 3a9f9ty34r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 08 Aug 2021 19:36:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vyk4HCrnlQ6wjDHUyyj9biXaCpUhN9BIQX1LPEiPCCMRqCFMTJXeHOm6zfj5NZkfu39Jlpfl9Hp/8u78QQcrfHe/W/M/LVZAt6YUGJm5HWauz4N14JLRgtAEw8ELEQOm2RubO1cV+Z36JPDl98nssO6VVZTOwmi6bnOpfAI9I3eEDgYXGbyVn/tXogsmt6ILHgaGf9UQ++q50FDxMV2AV1/YrPYv3MtGGZGHSSKgFZ9hAPLV6LoYXM+uHNSc1UeaoURZKoc4EaCygRYkUBuSGIDxw0E1L5X/4K2c7hvbP7CHCe9e9yzN/3rOeliqN/w7662VI1xwEsjFEIyrwTEwDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3HyOMc9TGzbXtVViCiSP6GNiP3vWhHENoaX4Qz7LBcw=;
 b=GufDMXvkmFppMwBajEMxIiI2bf/54WjqnQndW0d+LYqYOVSW4niSBMFT29rg6vzZhmlPbs1vJbgev3lO3LRwidmgAqUoqqCUFUZeRHp4SqZyw80pTrdqNsforl06hwu2Kax4N1VJO/OsgBa3iz/Fzfvnu6dApgcgrR1ORYhgL0GFmAan5/iomCHnErmPL7S9n8xF0IRLHDV3f3fB494/1Yoxz0DqjSdR+5xaCwdl3nvngDDKJikHPP5Fw+VFaT8nExaZ09SRNnmcbQUD4wXt5ML9D2NkI1x8vvFJcqbjc7IGMN8mY2hZsQW2G0b6rNXDDUzBDFxIteU1t8Dv/v8PvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3HyOMc9TGzbXtVViCiSP6GNiP3vWhHENoaX4Qz7LBcw=;
 b=zJiQ8utlf0bjNGPzNPfcyfmagCSjeujDqPtwaFE3ckT8sZojJdD6QxN25rNP5XEA4FG43Yf+c8I2vNQNEDOua6TETHt9NZ1bMYOW9mgk67H6SXWTOgWzEEOeVEtJIOz8ARbURgpYsLuXuMUcPiSqAujouDyfV7azBecG7BXVgmo=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by SJ0PR10MB5408.namprd10.prod.outlook.com (2603:10b6:a03:3ba::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.19; Sun, 8 Aug
 2021 19:36:18 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::a8db:4fc8:ded5:e64]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::a8db:4fc8:ded5:e64%5]) with mapi id 15.20.4394.022; Sun, 8 Aug 2021
 19:36:18 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        libtirpc List <libtirpc-devel@lists.sourceforge.net>
Subject: Re: [PATCH 1/1] rpcbind: Fix DoS vulnerability in rpcbind.
Thread-Topic: [PATCH 1/1] rpcbind: Fix DoS vulnerability in rpcbind.
Thread-Index: AQHXi64Cdqj7NA+DcUC7//SLnyqazKtqAfOA
Date:   Sun, 8 Aug 2021 19:36:18 +0000
Message-ID: <72C62482-3E44-4D76-BFB0-18402D19FE2E@oracle.com>
References: <20210807170206.68768-1-dai.ngo@oracle.com>
In-Reply-To: <20210807170206.68768-1-dai.ngo@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3207c4f6-b203-47e4-0bb6-08d95aa3cb54
x-ms-traffictypediagnostic: SJ0PR10MB5408:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR10MB5408FF16AE2F7AE8312A572093F59@SJ0PR10MB5408.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TQcJ+2eU8NhIr9sGQdOffW+HhH1RTGz860JO1e+kX++q8QcSKZrBMocp8ZZzJTCaeZNK8lKsDBfSxsaX7lyZGjtdO7QYNIbjWmUc0Qg+NZNeBaDFH15zCzqvE58y1uqhMrqUcrCXlgMVVqnfZ1ti7tVx9H6+TAttYtA09a3JG9TJP1Ee9ISW8EWTRpNzqIDMMCumGuvK9ec1MB2MJC2phTUJh4pLu0J0VgLIA7XF6dI2y3Jt3yV0L8JvwiqmivHA+xaxb2FVf55UyOKnKxNJ4TAjv7ZEUsTNxN6XdELICXsvnWvjupwGUJYkTpSUgBae9F4OKfKeez4XSRYOPdTtqTN2qQfcAQmZhxfSKWRq9LyTeUSqEw3Tql1NNAUc/tr+7Zb8zXM1AZVP0rR/QiRQW9Hmp6xiQ+ZEiVxOn25u7aIYnmxntdl2tVnL2+O8Ogtz7WYUo3uGosdfIqDZ6P7sae/9Jnh3bOsa0pzb6/eU1hR6L0X7zBeUBEOQpAJWiZaCsvwmnlFjpOS67HzjYgOnKQcNaLWquPpEpvYsmX9l3b1nL7GYZQ8JQpua5ZjSLKR2OBYdYTpTVQ0BZQZ0Df3wzNJYdSWAiic8IFKOKp0r9yNMjCCNDlmWIGkeq/hJwFQFdCJ69vk7D0LGONbA2gxvPbryC7rqfSO98p0QYtwGrCOa4w1pyp0NRb9nkAhN7w3IyqIlycYDBoafXbjioH9cgEY4EJbGyAmsAx7+3ngKb8oGXlyx6RYVtJ/qiqYC6bNH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(366004)(396003)(39860400002)(376002)(122000001)(4326008)(38070700005)(66946007)(33656002)(316002)(186003)(91956017)(8676002)(37006003)(6862004)(26005)(53546011)(6636002)(66476007)(5660300002)(54906003)(64756008)(66556008)(38100700002)(66446008)(76116006)(6486002)(478600001)(8936002)(6506007)(36756003)(86362001)(2906002)(2616005)(71200400001)(6512007)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KwSSbsNYVFrOYK292Q+Wc7z/irbn6Brh//5JbDCXF6N+F3JivxPBav8XRCr0?=
 =?us-ascii?Q?ROhcVhhWp666VJ/Rfyh1yFY6TdfCU879ymFNav92TcRhEF10fQXz+QD8pz+p?=
 =?us-ascii?Q?phA1mAEM6MizLlDRW55RLiGJJur5LbKdJSHP0Vp1EgWD6xmaX0Ki7iTZ/mPH?=
 =?us-ascii?Q?47IISQaMab3pZGTPUTPRugABq7lvIdaIPxhUkP5/FtRbiFeRlXuRo32xPqD+?=
 =?us-ascii?Q?/5HoFl/Uo20TEVX3QDuECJ0zS5QcciuyqLvbLQs4iRJMrOdsaqCa5dA+ZTMI?=
 =?us-ascii?Q?dWKgZjdVhVJGtSjByDnGTc1pNx3BT+BmUFCtqZN5e9x5G3xTTgMfz5rZ5HUC?=
 =?us-ascii?Q?DcbGpCTt0dYOF1HURyU3NyWlKxSqLc8yvhJ7naU2z2Qa6txJqWl4jEaYQwKq?=
 =?us-ascii?Q?lgxv58l/IGZ857MQDl3q1dBnU6eNx7LNenrDr/jV4z//Akp8zi0YTQb33kvT?=
 =?us-ascii?Q?+7OSkutdFLk8Club8miyEFf/vWhfcrNOaLYzKJMFN0cmEG6d1FsNvU16tM/L?=
 =?us-ascii?Q?h7/4qFlqCRGJzilUeOpCWJ/2eVo5h2wNN7/M5kqkm3CEDIZ+/Iqi5wpK08yR?=
 =?us-ascii?Q?m5XYuon5UElM2zC2Mgza4UiKCr15vsDdEtYyX3nUETfNLB3b9JLSMxcDbt21?=
 =?us-ascii?Q?dd9ma4kV0e0VB1qNYY4cusPN1sbBcbaRec2QYJWPAt2gM082hGBH+k+wbwJP?=
 =?us-ascii?Q?F74769TOzdZHB5fj/K7ByNypbVxXXbu7HvA4LaKKIUXae7QoT1cpC3FG1RBV?=
 =?us-ascii?Q?XhpUcFj5FL82x2LZgV6ahowZaLVXrqyjAJThfXxVxhDnUZepV3EZUSH8qPuU?=
 =?us-ascii?Q?6eUAu34S4AtLlwByU+j0nWdkwtipfXaP9Sgsx6VM5iaCbs9DRCBIzHBq0kz+?=
 =?us-ascii?Q?XDtp3IhXJaiaIogwDb8yzMcb4Mb9fZTvMDlJWqXw8Jnc7guE6g6tfd0E3RpX?=
 =?us-ascii?Q?nPjnzftVFkNwyPWL9imyDmRqjJu+3WwWy/XqSPcd3h0EgZEqzZpxb4t+PR1N?=
 =?us-ascii?Q?OX18Hymi6MPhkcfA66F9cOgXAiXQcgh/+AWKkFEjWTripiG2QOstSaW2O4Yn?=
 =?us-ascii?Q?vmvTKumCBDqr8r34/Lcfq+yAo7rfMj1kcmQtuJEp8IkEc1XAYCTuiAoRST6m?=
 =?us-ascii?Q?CWJoKhjF4F3lEfD/UcgW8cydLIVR6jGm3UTYrNVFLv1RmGbrB63kGVyuF12R?=
 =?us-ascii?Q?VgEVcFn2tNYmni2oS859SuITjC0dkX4smvdNy+YniFa2YIXCs4dtyC03AFZZ?=
 =?us-ascii?Q?XDvSuvxAUp9iKFsdol5K67UglObfS3nrBNlOmV8jjJgjVMxGzlm+m2nSfxBl?=
 =?us-ascii?Q?JkhA1/7egG58fHWJx/kmzpFr?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C9E554C17B29AE419F5B253B5937AD6E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3207c4f6-b203-47e4-0bb6-08d95aa3cb54
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2021 19:36:18.5773
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MXorcUfaqzpmUoE14o/mFlV8lfFEKqkMdALF+mVd/xoV6f962iCY2XJcoEQXsbfZRoULOHD2+92D+i7ftNMkqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5408
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10070 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108080122
X-Proofpoint-ORIG-GUID: sk967h6QNUYYjOa_C9BjVufLrdHNxaM_
X-Proofpoint-GUID: sk967h6QNUYYjOa_C9BjVufLrdHNxaM_
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Dai-

Thanks for posting. I agree this is a real bug,
but I'm going to quibble a little with the
details of your proposed solution.


> On Aug 7, 2021, at 1:02 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
> Currently my_svc_run does not handle poll time allowing idle TCP

s/poll time/poll timeout/

> connections to remain ESTABLISHED indefinitely. When the number
> of connections reaches the limit the open file descriptors
> (ulimit -n) then accept(2) fails with EMFILE. Since libtirpc does
> not handle EMFILE returned from accept(2)

Just curious, should libtirpc be handling EMFILE?


> this get my_svc_run into
> a tight loop calling accept(2) resulting in the RPC service being
> down, it's no longer able to service any requests.
>=20
> Fix by add call to __svc_destroy_idle to my_svc_run to remove
> inactive connections when poll(2) returns timeout.
>=20
> Fixes: b2c9430f46c4 Use poll() instead of select() in svc_run()

I don't have this commit in my rpcbind repo.

I do have 44bf15b86861 ("rpcbind: don't use obsolete
svc_fdset interface of libtirpc"). IMO that's the one
you should list here.

Also, please Cc: Thorsten Kukuk <kukuk@thkukuk.de> on
future versions of this patch series in case he has
any comments.


> Signed-off-by: dai.ngo@oracle.com
> ---
> src/rpcb_svc_com.c | 3 +++
> 1 file changed, 3 insertions(+)
>=20
> diff --git a/src/rpcb_svc_com.c b/src/rpcb_svc_com.c
> index 1743dadf5db7..cb33519010d3 100644
> --- a/src/rpcb_svc_com.c
> +++ b/src/rpcb_svc_com.c
> @@ -1048,6 +1048,8 @@ netbuffree(struct netbuf *ap)
> }
>=20
>=20
> +extern void __svc_destroy_idle(int, bool_t);

Your libtirpc patch does not add __svc_destroy_idle()
as part of the official libtirpc API. We really must
avoid adding "secret" library entry points (not to
mention, as SteveD pointed out, a SONAME change
would be required).

rpcbind used to call __svc_clean_idle(), which is
undocumented (as far as I can tell). 44bf15b86861
removed that call.

I think a better approach would be to duplicate your
proposed __svc_destroy_idle() code in rpcbind, since
rpcbind is not actually using the library's RPC
dispatcher.

That would get rid of the technical debt of calling
an undocumented library API.

The helper would need to call svc_vc_destroy()
rather than __xprt_unregister_unlocked() and
__svc_vc_dodestroy(). Also not clear to me that
rpcbind's my_svc_run() needs the protection of
holding svc_fd_lock, if rpcbind itself is not
multi-threaded?


The alternative would be to construct a fully
documented public API with man pages and header
declarations. I'm not terribly comfortable with
diverging from the historical Sun TI-RPC programming
interface, however.


> +
> void
> my_svc_run()
> {
> @@ -1076,6 +1078,7 @@ my_svc_run()
> 			 * other outside event) and not caused by poll().
> 			 */
> 		case 0:
> +			__svc_destroy_idle(30, FALSE);
> 			continue;
> 		default:
> 			/*
> --=20
> 2.26.2
>=20

--
Chuck Lever



