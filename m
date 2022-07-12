Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA46D571BAD
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Jul 2022 15:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbiGLNst (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 Jul 2022 09:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiGLNss (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 12 Jul 2022 09:48:48 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9128F9FE7
        for <linux-nfs@vger.kernel.org>; Tue, 12 Jul 2022 06:48:41 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26CCtjAK020890;
        Tue, 12 Jul 2022 13:48:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=8uj2vYHs3wUMfsxM407hTxaP8NXs2zhUlaeFpIOCHiQ=;
 b=IWul5QSh8yseGdTCmA5HNB5jWbal6jcdhxiYfHLDuGMbYRcnLO42ZPrrnoVSrkXC5Th8
 ftv+NyrgW3jPNLD4xPqg/iWp6Izk3vtQoa9gS2IwwJAfgipPHpQD36FudrWEMVpVV7l0
 zjueDlUqIIyn94J9yhglxUAwrCShWWuDPFN6DrxFYF9DMbCOK/GoO7+pJyDvOqjAlzgK
 1m88TJu04beMAUSsrzKPUYiSJBqWU5XMTgFm7yYa6o1knkHqTdPlugYq1KBsgiWUYyHQ
 MdLml3y2VijAZWMQm0hCiNhwtIvG+8zY8oXKnNQtt/I88EcyYYi1hVuD3Gj0l2TC4fmU mA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71sc6uck-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jul 2022 13:48:34 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26CDelFk013004;
        Tue, 12 Jul 2022 13:48:28 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h704394kh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jul 2022 13:48:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=In7c3jpNQj5Tzy+3JcGemUgxVjuloFRhc2jpzeXo+cjIFiQ/AoQ8LBQToJMKyIs6byIEqF+gW1QNAsyLWK3JQZuBKjG/rJRiS6otYjTKcPNHNAzthVhbysGU5/X6HV9H4xQDASxhjhGFo26t/44O9dWHgUE+NGYtfKziT/+BiqNrn2MU5OtX5PRMgRhle52AfcMGL7BFhfY6vuuPxV3NnMEpLovFvRUggpjgggCjOFUaRBRz4VnNaOR4PyFBKlqT2O7f7eWPzN2wXyhDBoFzc8KL1Z/0BbcobNrr7Y5wjNGu9dG2EurhXPO2KoSM4pahatwkxSOBzo/ih2AcUJ5VkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8uj2vYHs3wUMfsxM407hTxaP8NXs2zhUlaeFpIOCHiQ=;
 b=DI9PuybhBEq3S071KdZuVxu/2Ap6DRPucFT5DP1/+S/ay0572qU/LtsIv/i22NHn3KnJkwjHp0Z9ATytTx/HcDxX985WXBzpbF19msvZXUSMQUGNVj7nyKOUXTq8b3JLyUk74JXc9xk/BPFHQLbrPkL4DqNsrnsyXuL3rN3XIDL+jt26piRXS26z2FugswcmQVCa4O4euzzNmxKXspXuAy1GuHugLuRk2Qn55tcm8E7Bd/FkXYDI/1JkyOlqaQNdQ1/BGc5PnPmI2/oXNRdxWFyxED/6v3wToTgSrzsSDqTsMngPSpiQnCJwRQTmVCt7FX1ZsXCN+F8emlzR0Bh3JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8uj2vYHs3wUMfsxM407hTxaP8NXs2zhUlaeFpIOCHiQ=;
 b=cKSRySu/wPR4m+x8x3OiHV/cGUJewf0nxz6WBH1oIlWOuTdHHRNOh1XmZMQdJgB0R9MofNGGp4hwtg5hH7FZNl8EiAhJPgLX1BmHgq2e0XhOPEmuiA3vK8DTagDiRvpGCMj3W/yP0gDcj3ANyUe48MQDt8lHPBbOlRBRx7rLQrg=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN0PR10MB5333.namprd10.prod.outlook.com (2603:10b6:408:115::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Tue, 12 Jul
 2022 13:48:26 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703%7]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 13:48:25 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "trondmy@hammerspace.com" <trondmy@hammerspace.com>
Subject: Re: [PATCH v2 00/15] RPC-with-TLS client side
Thread-Topic: [PATCH v2 00/15] RPC-with-TLS client side
Thread-Index: AQHYebVuZqvrXSpmmEGc/2a/uQZ/m6165IuAgAAUJ4A=
Date:   Tue, 12 Jul 2022 13:48:25 +0000
Message-ID: <F713FAF6-8910-4BA2-86C6-C5B09223AC0F@oracle.com>
References: <165452664596.1496.16204212908726904739.stgit@oracle-102.nfsv4.dev>
 <c9b6787ba9154d1f4c2bf25387a35453ad20badb.camel@kernel.org>
In-Reply-To: <c9b6787ba9154d1f4c2bf25387a35453ad20badb.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a0aa9ab9-2cc6-44b0-00cc-08da640d31c3
x-ms-traffictypediagnostic: BN0PR10MB5333:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6r2qPsWmfV6sb2EJvY3zJ+b0RlbqdiJ2KJchUOJB+YMF4p+bVgjrVrypdq8TWw35co/M/HbmHPIQko4Mz4cY0osJ85GgY+FVNL69KvYM41UjleBEXc9pCzNZI6tv/aGKpq+3rkjr6nBolAG+1iVBkc2D2DKUoSYWMjYJMXI2X3jIH7VQI00sKtD3lMSvl8TRjn9acPOE06a+uUYO/c9fXCK98uc7HWUpnkLvbfo9r4mcQeqjFOxeWKysjNzsqxfwAAMIkYip5FjiW5XNnxpRBz/Kxib6lsbgF7NmtMwlXZus4ek2yxPLrYdxkj5Kx35IBGL1UAk/hWVpMYnk15bpqP7+5RpvZs1Y8c2UkirKApBsCbAOxulsjdDD3pmpIcQ/l61OAS8lOjGrHk+jZkUFKQCUwEsXl9gp4HTl8HnQCiTyjuPTbBVu8vxEtqnQPBp6hioN+1V7nkqK02P3SjDmdWJkQqp3SSxWzNd2G6tePC9MNRdSHk3jLJPQQusg7ZJKbiBMXO4rjMHzUZYCuhh9+LvxQ6lbHdLAUGpH7VJ44Z7Lain0tjpecM8t5ahVjLZ2+GP8A36RQ8v5xcnjsfIQNjspB/amH2ht6RAw+msfpQ+fxXcqINEBSG7frc/brxqXlLDKzz1Ra1jYdf0kR1lawgJlADNmYgtM19DC7m6PPsHB31UCVCROVt82khfuFrMMPcVIZs6L21mrmJTP4LizBxHTtviqorZ+BA2Hn5Fc+le7Lk+BxfqKfQIqWcQ46ifE3EZq4JveiOPueIFJwZ7ZVUuzDAO1oD1iZ0iJfiDdJ6eKdcXP+HXiFI2hIPthokUlALVUQSLXQ6T47TLTIqRrCNyrCWu6ppxq6vkZfgJahZp3KbXVzqkesE0JqCBvz482
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(366004)(396003)(376002)(346002)(136003)(186003)(71200400001)(38070700005)(478600001)(5660300002)(966005)(2616005)(6486002)(8936002)(36756003)(2906002)(33656002)(41300700001)(38100700002)(8676002)(66446008)(66476007)(86362001)(66556008)(6512007)(316002)(6916009)(66946007)(64756008)(54906003)(4326008)(26005)(122000001)(83380400001)(53546011)(6506007)(91956017)(76116006)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mdT5Sp5mx7PdBaJiJ9YRZ8RYaMKTIzV6SWtIbTn1Cen0ymf5A5GADdIQXVdr?=
 =?us-ascii?Q?mZchaYsWUdzGWVChw7+/7LcFqGZwsq42A+fLI3GiBRFVqjFKVMVAfQUfYrXb?=
 =?us-ascii?Q?dohu1zdl+MmU63lYh2vxyUkxf6efp45kUUM9FL8QxxvPmBM+NwFFCYUt2gG7?=
 =?us-ascii?Q?q8zYdvPIm20nATCGeY+boEOCHj2rg6KjauDmxutRFVB4IWaHvkJWe6a/26Pb?=
 =?us-ascii?Q?Ws9w7q/Kb3KHCSCSUfsCN0vXi98Ij7AnWCBtyXIAoQprtYeXBb9EVBCu+ymc?=
 =?us-ascii?Q?KZAQph2MicDP5FXQ3Q+nFVUZCKsHjxOCpCqib7614qrbyo1kP+Xw0xBPwEqm?=
 =?us-ascii?Q?eUuTZicOuZqAkHoNApDZNGsa07TNoR5F/WnzHmA99z2+wbALC+UkoxC1xMOi?=
 =?us-ascii?Q?pAa2tFoFNMMjEhE8a0qlzfFFKfgpbBR2mt0X31sATc0FqjDIa1d4SCBeydAD?=
 =?us-ascii?Q?8CJYXLCZEE0XK+QokjMr/YzzbtWkVOU3/8DbtRI07KkkYuLGtmK5L5yL2z8m?=
 =?us-ascii?Q?USjhao0exvMpE9jNUktEy2Q5o5pERKJkN5/akybtnMsmBob+XONgpzfkqIE/?=
 =?us-ascii?Q?2JOZAz+6gbP39KJzYoif4sIkyDci/ClDnOhgeRujmY+vhT3hfR2TTjnbQ26b?=
 =?us-ascii?Q?4BWQeMOrpcfQAnDTp9U+PzaERgP5WPCU1Us1x0ZCZ99PkuBtGalaFJyHea23?=
 =?us-ascii?Q?cDe11wf4sJE8F5wRnc7ohQ5hKCoB29f3SE1h9pgrO+hNFNre3b+vo0SOB2Fd?=
 =?us-ascii?Q?ndHBrCQu71Ay7OtxDdf8RcPy+0Joz3LbNytPDxgli5vY/UVih8WLuJzI2gIL?=
 =?us-ascii?Q?Qzg1llbJP1pQJQvtNMk+XPfhjXCRh8beFSqIM63uhMCBXXe7j9JkUDijWUkR?=
 =?us-ascii?Q?1aexY2ziG2EwcZyaqUfwEEJt1zuqkJew7oRdya9soRcn/eqBT+a3C6hbQA8e?=
 =?us-ascii?Q?Xh23pmMqxVO4b8kJfb3QFi79s+238z6geTxVDGzbP8sCvQoPCxOFSM9IYD2h?=
 =?us-ascii?Q?5qMbIQ4c9gDehAtMittKQi7CPWatKhWHaN1wjrb1pyE2PyWrKO7jiGiVQzsN?=
 =?us-ascii?Q?LV7URX6TKPdOvzVZy8FqqYzgE5mEE/X+qPTyE92BOpvBJ2h5Jq6taK7nGKqi?=
 =?us-ascii?Q?lY1fV2Wngor1VkGrqTQEDtRY4mQ2rBckksmRSw0dtSsWK92rfrMJEPUTOtG3?=
 =?us-ascii?Q?jNM0ci6UPI/yP8FnGUAB9EHiX9t1MxKfHrMiZpRZ8vYUqKPRVOpgC734jwnG?=
 =?us-ascii?Q?575bBxDPmJ9BxmqSHs+dNwWlpit7KMGBrhg1olGIijiUeipyOwOQgxyaQHCt?=
 =?us-ascii?Q?KKHukC+WaQfjrgmgRDA0a+aFaeZwWKCtDTCDNWXbwwnAIEJcZBcjWAdEy6ZF?=
 =?us-ascii?Q?NR/7N985iI7R5OzFNXPN+c8dh6+28/nwA1tKoIJyrY2niQ26caTLsCn05V99?=
 =?us-ascii?Q?uBTuOs6eUpXRpS+Sm/9POcDc9ACBeuZHiuFR3OATRSoyqMZk9s0NdwuJraDe?=
 =?us-ascii?Q?cVrQ22My/3EuqLmTx3NBf0s1zRn4BlU/GcBMYtPws5JIZj6+C4eqOez+cz8+?=
 =?us-ascii?Q?YNqvbf7gP00XRdOSq+lsA4GB2vfhKEIYstQmU2P3DrvodwRqyDmUWRujY2bF?=
 =?us-ascii?Q?xw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E14BD03AC743E64D8971A4E082992EA2@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0aa9ab9-2cc6-44b0-00cc-08da640d31c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2022 13:48:25.8249
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V0q1mc5tB25XaVmNGDDTkmttSUe+v9AMqvcoDUD2RzvMAupzOHuyHX2czDuUfgY8jUKufizYxQPEQ0bixPp/Ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5333
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-12_08:2022-07-12,2022-07-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207120053
X-Proofpoint-GUID: OlNTO9PEpwr-V3rXBqEhPr7oOK2EqBnZ
X-Proofpoint-ORIG-GUID: OlNTO9PEpwr-V3rXBqEhPr7oOK2EqBnZ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 12, 2022, at 8:36 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Mon, 2022-06-06 at 10:50 -0400, Chuck Lever wrote:
>> Now that the initial v5.19 merge window has closed, it's time for
>> another round of review for RPC-with-TLS support in the Linux NFS
>> client. This is just the RPC-specific portions. The full series is
>> available in the "topic-rpc-with-tls-upcall" branch here:
>>=20
>> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git
>>=20
>> I've taken two or three steps towards implementing the architecture
>> Trond requested during the last review. There is now a two-stage
>> connection establishment process so that the upper level can use
>> XPRT_CONNECTED to determine when a TLS session is ready to use.
>> There are probably additional changes and simplifications that can
>> be made. Please review and provide feedback.
>>=20
>> I wanted to make more progress on client-side authentication (ie,
>> passing an x.509 cert from the client to the server) but NFSD bugs
>> have taken all my time for the past few weeks.
>>=20
>>=20
>> Changes since v1:
>> - Rebased on v5.18
>> - Re-ordered so generic fixes come first
>> - Addressed some of Trond's review comments
>>=20
>> ---
>>=20
>> Chuck Lever (15):
>>      SUNRPC: Fail faster on bad verifier
>>      SUNRPC: Widen rpc_task::tk_flags
>>      SUNRPC: Replace dprintk() call site in xs_data_ready
>>      NFS: Replace fs_context-related dprintk() call sites with tracepoin=
ts
>>      SUNRPC: Plumb an API for setting transport layer security
>>      SUNRPC: Trace the rpc_create_args
>>      SUNRPC: Refactor rpc_call_null_helper()
>>      SUNRPC: Add RPC client support for the RPC_AUTH_TLS auth flavor
>>      SUNRPC: Ignore data_ready callbacks during TLS handshakes
>>      SUNRPC: Capture cmsg metadata on client-side receive
>>      SUNRPC: Add a connect worker function for TLS
>>      SUNRPC: Add RPC-with-TLS support to xprtsock.c
>>      SUNRPC: Add RPC-with-TLS tracepoints
>>      NFS: Have struct nfs_client carry a TLS policy field
>>      NFS: Add an "xprtsec=3D" NFS mount option
>>=20
>>=20
>> fs/nfs/client.c                 |  14 ++
>> fs/nfs/fs_context.c             |  65 +++++--
>> fs/nfs/internal.h               |   2 +
>> fs/nfs/nfs3client.c             |   1 +
>> fs/nfs/nfs4client.c             |  16 +-
>> fs/nfs/nfstrace.h               |  77 ++++++++
>> fs/nfs/super.c                  |   7 +
>> include/linux/nfs_fs_sb.h       |   5 +-
>> include/linux/sunrpc/auth.h     |   1 +
>> include/linux/sunrpc/clnt.h     |  15 +-
>> include/linux/sunrpc/sched.h    |  32 ++--
>> include/linux/sunrpc/xprt.h     |   2 +
>> include/linux/sunrpc/xprtsock.h |   4 +
>> include/net/tls.h               |   2 +
>> include/trace/events/sunrpc.h   | 157 ++++++++++++++--
>> net/sunrpc/Makefile             |   2 +-
>> net/sunrpc/auth.c               |   2 +-
>> net/sunrpc/auth_tls.c           | 120 +++++++++++++
>> net/sunrpc/clnt.c               |  34 ++--
>> net/sunrpc/debugfs.c            |   2 +-
>> net/sunrpc/xprtsock.c           | 310 +++++++++++++++++++++++++++++++-
>> 21 files changed, 805 insertions(+), 65 deletions(-)
>> create mode 100644 net/sunrpc/auth_tls.c
>>=20
>> --
>> Chuck Lever
>>=20
>=20
> Chuck,
>=20
> How have you been testing this series? It looks like nfsd support is not
> fully in yet, so I was wondering if you had a 3rd party server. I'd like
> to do a little testing with this, and was wondering what I needed to
> cobble together a test rig.

Ben Coddington has an ngnix module to support RPC-with-TLS that can
front-end a stock Linux NFSD. Rick has a FreeBSD server implementation
of RPC-with-TLS. Rick's probably taken his server down, but Ben's
server is still up on the bake-a-thon VPN.


--
Chuck Lever



