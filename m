Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25F1E6BEA65
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Mar 2023 14:44:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbjCQNo3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Mar 2023 09:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbjCQNo2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Mar 2023 09:44:28 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EDCE20063
        for <linux-nfs@vger.kernel.org>; Fri, 17 Mar 2023 06:44:25 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32HDFZJk009360;
        Fri, 17 Mar 2023 13:44:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=gdndxZ+SkjwxrR9E57lPRCOS4KCke60FlkCHatP5xvM=;
 b=3DZy1FKVjIhQVgm4eJz1x8sPsVKYZkCWkkXYSJuaf9FHUbchjNV2kO72PQc+8Ghh3Ye6
 Njdb/2ZPQLdEAUpeX4bz0i627lRz6rxnW5lkp9Ntae5P0+/ATqcE+vj9cVAtnEsEdw3u
 pkVXrS2mHqa+4MOOl5uHVB0kgbBFFZm+VKkLbsZG9A/NzoQ/YscICP96P0QgrLViCvBO
 ATDwiEcKvZazDgq0Mxft1Bi+ObmJy0Qar3uZrow7RvI1sdRodeKFW8uAnG9RbTqt9dB6
 VFb+yyCJxzm8DUL2KrDc1MRvmDE+KB3bFn8sQSGQ//TlUnMGkZc1ApP+Rs0EQA/tBFQl yQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pbs263x7s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Mar 2023 13:44:18 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32HDgMPK015754;
        Fri, 17 Mar 2023 13:44:17 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2172.outbound.protection.outlook.com [104.47.73.172])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pch3xh4mq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Mar 2023 13:44:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iRIq1YJZGBijCDtpfwa3AyJmRiJguaMetWmJ3DMnye/2PStOdov1PD4SINQYcKuMD6PRfwTzqJlsR4EDyNqqjCuRvqZ3i39kJwWEZaJZXV2960cAkPJaMNqp6xInWmBU/Fc6T2MlcKNb4X9yz0yyIFQFMcXGhuU1Poo9CAq11JRW0Wm04XXEQmpjdCHDgh2E9/QGMWq9Ncc9wnT8IbF71JR26HYPVorXUGgRIRZIFK+92vxeXx7pbUfI9M64TElaLIXJfSWGeApvN/IcIGPHPcfKdYRVOla9xS0cByCvM1FM9v+3faQGs9ag8KvtjNMxfzXJtZER7Al4dzs26iaSjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gdndxZ+SkjwxrR9E57lPRCOS4KCke60FlkCHatP5xvM=;
 b=EYnVpOuybQD8NKbDQNWORjVZj+v6RNvpSlSHwyeR4eCvFnE8JXuRKeNnIMlwDFqAjbw9RPjgEQZWo370F/nSknh1qmHWF9hLUKDF1g4by0ThUMz8T9JAEIA31jC7qhkP3ben3hwOp2/setM2Hv/DJ7N6iyMv6Bi6u9pxJYsMhXJ1DXhtSfJXO0GuhN26q+sfYHJWx4ipyXMrLv3PRNPRf2VvT8UoFXfLqFK62jR0WGMolEYaECWgoNSVKWXZlN1qnBGgRGAAxTXjoFqGNoRUQ/Vi0DlNWIjPqO1YG57moYvKaPbzQiJX9nPdxPAo0Eoiz8vBAy4+VcZSw2ZuK1mGWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gdndxZ+SkjwxrR9E57lPRCOS4KCke60FlkCHatP5xvM=;
 b=mAHi5suacgKk4fxcVkUDanMOmhapgCH2BxCh+4O9FcYB4LEKDYW+f5uH5JRDuHaAY8y+0TYkn23x49xhpvzbPkfKHu75qLBG8M4wsvgyZIM8GHm37FoaLPCpsL4A/XYacGnVC1UNh+AUQ6KQxCnUcjfzUBdv4TiJ5+Ln3CeEBuc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BLAPR10MB5265.namprd10.prod.outlook.com (2603:10b6:208:325::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.35; Fri, 17 Mar
 2023 13:44:15 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5c2f:5e81:b6c4:a127]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5c2f:5e81:b6c4:a127%7]) with mapi id 15.20.6178.035; Fri, 17 Mar 2023
 13:44:15 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "dcritch@redhat.com" <dcritch@redhat.com>,
        "d.lesca@solinos.it" <d.lesca@solinos.it>
Subject: Re: [PATCH 2/2] sunrpc: add bounds checking to svc_rqst_replace_page
Thread-Topic: [PATCH 2/2] sunrpc: add bounds checking to svc_rqst_replace_page
Thread-Index: AQHZWL8ZX7drP5sCN0GjGgDz8G8l567++6EA
Date:   Fri, 17 Mar 2023 13:44:15 +0000
Message-ID: <7DAC68F4-8CE7-4578-BBF1-626285B44B6E@oracle.com>
References: <20230317105608.19393-1-jlayton@kernel.org>
 <20230317105608.19393-2-jlayton@kernel.org>
In-Reply-To: <20230317105608.19393-2-jlayton@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BLAPR10MB5265:EE_
x-ms-office365-filtering-correlation-id: b754b907-db9d-4f48-d3dc-08db26edb2f2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JMR+Ehei9zrfGKOx1EqcpNmIXB92WpgvUB2ohtxpYOrZnCxw3LSLaSE6TKpIg/8AeYiOuONHQM7Hnowle6ePrWNsUNc/4bxenRBuzaM1UzsOx7hKylqzFnZ6/psgDUZRN8wR6h0V4ju/ZNag+sO1LkqiGofH4SqHNLbZQtA4uw7xWyXXE8e6ZNDx2LS1HjBMIalvFJbSqA7epTBrmnucbpXOcQotFgryBnQwThguJplAJq/J/UxikKFo47p1Dlv2kWlm+UTVAPMaYmqA9R8LvsZ8LpZcb5Y2o88h7pGi6Zah7c46I5mrqQUu8EfCGxkgwelDqq3U5ShC8ciCjfzsidtCHiT/MpDl9V6l8XIXCn7664aVS7itSfkAe0tsS2ZMi0oLEQwAdk1g2y0qdcAwyo+4omasI4WHqcqdPCU+d7Aw4M3n8CqG8/G5lYWIdf2Q5gcVIKFfl5MWxNa40A2BqpRoMv5I9urqnVURX9w5M9pnryJIQZE9OamRmQPAw5yzd9QXZbFM7GmCZxZO43bqJrEJWMgQc5KUv2Y45fvPlGIgdd0BNPu0dbEodaZn4QTQKirnHq8QkUX6ax48E9mJC8lCm65grX8iyyrIHiew0V/BQycqzRNfcVuhAdVtRW+BUn79TL6UZq6gTm+yLPIsIS2ZxkisYRen/TNZnuyIX00rb1Mp21dgSnlp5LQyTXnYFaFG5XiafO7AI3MeM8TqwqEH3UADD4Jkl4H5Pz8S9z8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(346002)(136003)(396003)(366004)(376002)(451199018)(54906003)(478600001)(2616005)(33656002)(38100700002)(316002)(38070700005)(86362001)(122000001)(6486002)(71200400001)(53546011)(6512007)(6506007)(26005)(36756003)(186003)(8936002)(66946007)(8676002)(76116006)(66446008)(66556008)(66476007)(64756008)(91956017)(4326008)(2906002)(41300700001)(6916009)(5660300002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?z8SM2nozYgQKZQO9+//AkW/NHO7MXDqCgUng18aGp3439oKGtAG8kc30H1fj?=
 =?us-ascii?Q?R35dAFeMaBayGIi/Vf7M0j1STQepvdFD6DH0KNmhpBrsJGq1rIurLLPswcwW?=
 =?us-ascii?Q?XqQw0BausuS1BpedOzbgwq4u7H1DrFaBnDOuU6ksi+RuWhfXtfkZxY8ExZu2?=
 =?us-ascii?Q?S0R9LmIn1oDtGFaIaiP/kJ7fVnI1lSV7/UBYPhJhCs0IaM1KVFArTwn4QPiQ?=
 =?us-ascii?Q?/SsgXGbcvR/qxVe30e2swXKVUu6oQrfRsq3kymYrYMsMYBu03EDvyWsK8Ef6?=
 =?us-ascii?Q?Sw8K+NwQdEm5AbrMBszwVGLp+AI06lQrjA9npBX59vBLyDjahdVO1pDDppjl?=
 =?us-ascii?Q?g0JgTszNeKfOzKqOx8UP4h+owlxtwY8Z9JLNYChnfVfFaqUoXmQLt5t1TeUm?=
 =?us-ascii?Q?ip9oJ31eezIvtXCW4nB8IAprApsXSM1Eo0FhnvbYIvSbS3EY79uQJOySExAf?=
 =?us-ascii?Q?CXq0c744xQy0cZ0sfIg4JhsQ3oN74/uJLLFcAxow7Iaota4EIRuT7Ykx1Mn4?=
 =?us-ascii?Q?kmuh+VhVmz+8XsTON7FCYVDkWHEseOv3xQokQ+jn1+zjvaM0n6aOCO1/8jEm?=
 =?us-ascii?Q?401MgvBrcAcpStKPbepEr9mcUEV50q67FM0fAlLiBz4CZjq903q+KXz4l2fk?=
 =?us-ascii?Q?p2E8iMxcfAud/WcgjNbNc82PCtTCGRAmosyD5cgtvE6TN2rCjWZnRjOtWU3W?=
 =?us-ascii?Q?dbHw4mG0Om2Y5oawzqra+BcTSvl0vZwPlcPHyNV8O1jHwrtFmsc5e4iTCyvl?=
 =?us-ascii?Q?7ZQlRIieftxJ6ZTh0Q+fprpeWwio9AqAJZY5TQIfB6xzJ8wJITHyEOdRSjUA?=
 =?us-ascii?Q?fbimLu/et3HJuqPsPsMoLJq9BXfeUemmDDc03gLNfAwBxnR+Ppi3ITJo+ed2?=
 =?us-ascii?Q?KYy4sihuIEMqYEcCwFsNMJSb39w9o+bgq2TOFBM5ZxGjiClMlIxf5k0QOYms?=
 =?us-ascii?Q?9Q9w5xuC4jxXeSutEEpovuGStoaIJcLbzrQYs92fxvP9GaoTSAqWkUYZmbvk?=
 =?us-ascii?Q?tB5UC8l6h8kQhJWDVMXN7PtA4uOpc3PVa9AWpkL6N9yiW892zZ8bOeFr/NnU?=
 =?us-ascii?Q?rryGAABxLAjSlisFt41I0m7sRgd9eMJYGCm4Ur4oEAtIxqOaRorL3BlphNOh?=
 =?us-ascii?Q?5owEml2NGX2wWQW54xRVf1EoGMp41pjeJ8GXjrNXzb+qBzL2SE0IRyUxdqmf?=
 =?us-ascii?Q?wGT8MPYQl14Nw/O+rtEQgEqKycN41xs4YG2sALBPVtpTv21dIi81cZSFrici?=
 =?us-ascii?Q?XTmTQZEHKY5Tb9kwNw9UfuMqs0kydXqmHD3xJPPVfu7P8F1xT4GSp6NoXnNx?=
 =?us-ascii?Q?IkZliuqaRa/XvWC9cEsWYz1hfOq6JPIF76PgPaZjtKDjcZvYa3bYlyEJdGfW?=
 =?us-ascii?Q?MmLKxiKHMdvLy5wqUw84j7irzKIy/PyYTil2fiLy9sviYNLPcCD4DsgDUMA9?=
 =?us-ascii?Q?y1bSnOsT0UYt9axkFOhEyb9VoQklhXMOnik9Mevv1Vqx4CWgvBbzAve3r9Rb?=
 =?us-ascii?Q?b6eJJDnMXOzq+1at8vvpPC/kN94dvGAm3nr626Q19ET2UXHadk/lw0zPh7EN?=
 =?us-ascii?Q?HQWY5/eCFEQzEShhe1V7Bc41l7cqLu1lUKnx+xH9MEjIxrlLsDMQdXu7zVtB?=
 =?us-ascii?Q?4g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C8F5EEBD947CCC4F96BF7D19896C4BF1@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 8TwjWR8QAJUrTuJyPmeN1n7V2BSNPsJkDpvieHay2AnCsPB8INlksU4UzATq+rMTVZSlErmzNRx3dpvziHgvMakzuu/Rlp7YgN5ARrRyusmtYXNqHw3B1E4pCkl10srenxx2AMw4ObtSer5H4a2laGLecA4lyRHMjQpVA/2ABWUeBlwhJrnBBkXNfNSEKHEtKT5pOkf1ZPRX1aB+ae6Fwa3D9yPLKGPeA8Vghp4EfkSk0uRHbA8xWvyFlB/29ONOe5DcUS3PDu1pcvHpS4buGlJ0NAhRT+YE+NKQurGj4Ma1rygyms26Sq3Ce1/q540WjWy64PaEc0TQmh5xzcg7257owt7LyHdLV4h8mJfSJ1N46NFCW2pbqp9ngtInjbrfCUhbMlRHmAifdKclrEY9yLCfDiKVI3jnxuhxfEvHxZnePlqsi3kItBfUvCfh/L9QTNLCpOEdBE9ZDzjeHo4v6vpGKLFmz+Nnwn1Xtv297sSQF0IJc2qY7PhCaazBCtxJy4WSE/gNS7HAdAzY6SwWCXg6x1F9X6o7hYujdofWglmz1FiDCHbayZina32Ex0+pWvdvgSDmIivYQl2zahYYptQfKcDfyV7VreCLlk7f+P2SUMl2YetvqbV4JzqxR4/OGojhzjJgK4ZcmH1g6i6YBmv7fTtKxpL2WnFrKnAZ2qCDl9P25SREIzaHg2QgwGHZeDK0ETjXDGEqc1xmSXVnXn2zqMTl9JS9Td1v/4YbowOMXxMqZoUaOl2GK0iPCutI82bPZKRwYYZD8+X/wiWHIZ5FE9CnGc7wX+CEIt1zyrBFouxL7Yz6soN/hXeD2zWgR+szKsGkoxMLcMwJf7Z8QAs1PsYdVlOho31YZk2yvlY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b754b907-db9d-4f48-d3dc-08db26edb2f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2023 13:44:15.3782
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MF5Nh8tZErBlYGBsVpYsCMawnes0VBC7vted+pFxFYpAN0BhZzfgNx/wIVFJFyd1zZX7itXh9DjoVQuW9Lrhqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5265
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-17_08,2023-03-16_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxlogscore=731 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303170094
X-Proofpoint-ORIG-GUID: W501uXDEztMogIWJjJNtajO7vYUfzl6x
X-Proofpoint-GUID: W501uXDEztMogIWJjJNtajO7vYUfzl6x
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 17, 2023, at 6:56 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> There's no good way to handle this gracefully, but if rq_next_page ends
> up pointing outside the array, we can at least crash the box before it
> scribbles over too much else.
>=20
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> net/sunrpc/svc.c | 10 ++++++++++
> 1 file changed, 10 insertions(+)
>=20
> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> index fea7ce8fba14..864e62945647 100644
> --- a/net/sunrpc/svc.c
> +++ b/net/sunrpc/svc.c
> @@ -845,6 +845,16 @@ EXPORT_SYMBOL_GPL(svc_set_num_threads);
>  */
> void svc_rqst_replace_page(struct svc_rqst *rqstp, struct page *page)
> {
> +	struct page **begin, **end;
> +
> +	/*
> +	 * Bounds check: make sure rq_next_page points into the rq_respages
> +	 * part of the array.
> +	 */
> +	begin =3D rqstp->rq_pages;
> +	end =3D &rqstp->rq_pages[RPCSVC_MAXPAGES];
> +	BUG_ON(rqstp->rq_next_page < begin || rqstp->rq_next_page > end);

Linus has stated clearly that he does not want BUG_ON assertions
if the system is not actually in danger... and this is clearly
the result of a software bug, so a crash will occur anyway.

Can you make this a pr_warn_once() ?


> +
> 	if (*rqstp->rq_next_page) {
> 		if (!pagevec_space(&rqstp->rq_pvec))
> 			__pagevec_release(&rqstp->rq_pvec);
> --=20
> 2.39.2
>=20

--
Chuck Lever


