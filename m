Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E58BA569251
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Jul 2022 21:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbiGFTEX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 6 Jul 2022 15:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbiGFTEV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 6 Jul 2022 15:04:21 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F3901C11C
        for <linux-nfs@vger.kernel.org>; Wed,  6 Jul 2022 12:04:21 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 266IrtVZ010525;
        Wed, 6 Jul 2022 19:04:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=wBtI+8MobOLQl1Qjb5Uw+9MXnwU4f+GFcIPGUofq2Xo=;
 b=mvwrq3LPfTfvtHHnQfk2pqsz6swx03Jip/fcqH2CVgk1/worXlITEVckO/KyyHZcZk/s
 akSAPOHK/PV8JJsPGh+HbNP6MGd1YgmXj/AeQXB9azOybXAybd/u/LtcQ+x/GlEv3IF9
 4uGDVDD4G01dAgwM9XufwEDCKwSrU6JwAvWhKZhzrIbUREZ8P1x8Vt1egEFyk1iP0P/I
 YHN4ks58Q0Jwzs6MpSM1hjii69Yjp8t5IWsCUnuOZ+mkx0G1jdp8KqsVSII02fDY7BAx
 mPu4b+BIgTu1jSRyBEz2zK1MVndz4xtsZbgQjI/4yquIxQNYgf67vGx5UWkBeiXPgWi7 tw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h4ubyaxb6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Jul 2022 19:04:13 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 266IZVfV012752;
        Wed, 6 Jul 2022 19:04:12 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h4ud6bbke-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Jul 2022 19:04:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RPv/lUu9GQrvFLjC2qkR+m/sD6zsptfg9rIkLKY/MyWuCyphhJVdkaO3eOd9IZAtQ18jE+xE5nGQzpMdVcwEwtZ1UfxtZJvOE2Md2wDaaFUq3c06Mt4NsjnGd75hlvqNkGFbh+6rqrOUZU2XO5pbzIyTGbPuspRN5oHZbI6SyTowq9xAT00fSzHvdDx4v+Th1TWE9w6cTDIGk1qkZGCUPgx/eDLuRVtVE/tFxO9/SDnPdIluZV2WXgZbI/vp5NXCye90/Of2HjVyDPWsyFpoOoucJmaszc8YooeVStDS/uAKiAEzz8goq+TXc739j1KU3cpR4/PTrvtV7nCSw2w4rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wBtI+8MobOLQl1Qjb5Uw+9MXnwU4f+GFcIPGUofq2Xo=;
 b=oSNTRqXv9U/Th/sWhqUndRgaR4S9DQU2H6Esoq+QWepp5XlbXtFoUR5ZVo8zK0tbhNjNgBHNBrPIHjl8k8vXS07ugllG1LifNnSNW7IX65M6VNcMP9S1EeWbCke8JaILAvRHkNfvVJfyRc6vblj9yldxaI88KzTtxtxV2MiJKd4jSwoGm5gjBkT82ikHPNWs3iHWXDLYpLZfwtV3abAGxuaKOTM21tnYcEUbfzGlrFFpypMHhbfsfmWRvxiqvedLiS2zE2YPFerjpsUH/Ustrh72rPnaf+LesM+Eyy7ci6iUKJWaznz2huld730iF0s/OXxgmypBvSRRTciN6ryCyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wBtI+8MobOLQl1Qjb5Uw+9MXnwU4f+GFcIPGUofq2Xo=;
 b=hLgIgPKaLaOjBI7GduE5fGpkzD3zfGXPUFLX8wB4Siowf4wZRzK5Y5YT1Cs9LSe3a7K0w/gOjCN+TrjfDFsAOebKdxAPI9cdqzz8jZelijwWzd5d3czPSELK2SU152la/m5L0KOGmUoyeG5ijt4QX+ra2WYc30STy432zp4/KHo=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB5101.namprd10.prod.outlook.com (2603:10b6:5:3b0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Wed, 6 Jul
 2022 19:04:11 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703%5]) with mapi id 15.20.5395.021; Wed, 6 Jul 2022
 19:04:11 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "trondmy@hammerspace.com" <trondmy@hammerspace.com>
Subject: Re: [PATCH v2 06/15] SUNRPC: Trace the rpc_create_args
Thread-Topic: [PATCH v2 06/15] SUNRPC: Trace the rpc_create_args
Thread-Index: AQHYebVzSa+eWnD3kUiFI4llCxQgxq1x4QaAgAAB5wA=
Date:   Wed, 6 Jul 2022 19:04:11 +0000
Message-ID: <19C9E307-B916-49EE-BA2F-079CA825095E@oracle.com>
References: <165452664596.1496.16204212908726904739.stgit@oracle-102.nfsv4.dev>
 <165452706752.1496.657240546600966342.stgit@oracle-102.nfsv4.dev>
 <732a3dd097707a57d4208f0bdb807abcd29ba224.camel@kernel.org>
In-Reply-To: <732a3dd097707a57d4208f0bdb807abcd29ba224.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 78a491a8-b9b0-4b39-7b10-08da5f824f83
x-ms-traffictypediagnostic: DS7PR10MB5101:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kGfiqn9IabJkaUfXEH5WPwpIrfIVxHSZQ2im/UcuZpQiFEJYK7SGcV+oEBFZDTyZNM+zR1GKYFNMYpHTAy2siEl/WbQoHzBwdEX9SB+hp33vRTNk9WghiP4Tbjm6kDDMjuSGmszn+/qcnMxQnxHSdJmAQ72u+ehNxMpXRK+CJZUL4gNzpqEByOx9gwArV5oAvQBgrVNvcloScO+OwaPflNUAQpA576ROWK2y+NmAwwQGVuJ0QAmmNpD4pxKhzmn9loSfg+jZ/spihwQZUi+ivFgHUh3smHnsIm3gyDlOeTJiVauxB39ChcxqRk+zL85MiuiqpzDpYWPtu4+b4lkeDnl1rcNF++pbEYDuFLCUkY9y+qbLdGak2LuukeRAlDX+sC2Gq1XSXmGdXtvC+V/g3SbJuMhtDsqSjw5tWo1buwJ5tOh1MD/8cuEeOjSSjoQHJyC28F6IhJzGRgaciTzREO2g+6c8/wCjAJ+8lvrbp9lW7DTIGTx44aWf4JT7/scTU6nGb9F71BYwLupBRYxx1kqCuwM9XcowYym94GJ44pFHtuThCNPCdevpjNM7Ce49JDl8R9rXT7R8378NXq5H3dVoMqmddvh9rF2HxwkJOmV6fFDofSjag+/v/wd0JPi6wuTTzKRHAEsM2AHWnlS7WsPvp6/2QbRBcjjppcWUpeXdyUSnVQvoJTZt3MM+diQ64X3NDnJCkSXR9eHjJLUnsjdkedAB8BnuO0si9fTivL988gKj2Z8Z3G29Y8M5/t0/W5g0R988CWfJJepMMMNPAUj0P7uPQS6FrCnS4JInLao6hwOQTEDZQ9MlS4v5Vmm4cJ0yQNVEx3XjgcAX2zCY629AgGEZcLGrQbSuAEMUz8M=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(346002)(366004)(39860400002)(376002)(136003)(26005)(91956017)(8676002)(4326008)(186003)(33656002)(71200400001)(66556008)(66476007)(76116006)(66446008)(64756008)(86362001)(478600001)(6486002)(4744005)(66946007)(5660300002)(8936002)(38070700005)(122000001)(38100700002)(41300700001)(2906002)(2616005)(53546011)(54906003)(6506007)(6916009)(316002)(6512007)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?e0gNagGHbvCzoFpfxrmadaqN/MsBcDQZdqrYuS0pVld9QghKYEYHxC1YLUNp?=
 =?us-ascii?Q?DoNFuil0KRA2IixdocbNDSQ53Tedq3kx8DbBOAsd2F3A92/FxX/GEKeta78p?=
 =?us-ascii?Q?UZOp1GcKz6z/9msatnua1pX5VJOCEKd6PQ0mPTJam6msDjLmitkSW9hvX0dR?=
 =?us-ascii?Q?W6Ecjl2PDwrQ8tPcwK5Dd/vU4/7KEJOezaKFwY50MccdCE7XAh++m9thwxqA?=
 =?us-ascii?Q?pBIRDcmR2eNTPLcGn3OJIO8+H/0l+uNafroeiYydSed/qzSdhH1UZwErF7v4?=
 =?us-ascii?Q?Obqjc1Mgwu3Eg981JSaye3Uh9cvJUz/SFryeQXGmCO3WkOCQmX40iPpiPFVj?=
 =?us-ascii?Q?aH/tVv1NsIKh28xC443nWsSnAQl8bEmIIDpv7uBmlx+rC8UBjw2S35Dc/pJu?=
 =?us-ascii?Q?bw04DRpHN43DHIz8QwErMH0hy8SUHgBSZpQcUx3DI0pgIabW6/xSDdugs80G?=
 =?us-ascii?Q?+RRmMwt8YMIgYahqFdR+0chpwRSH78T3ENLQFTnwn02HmZzfQ+Oz24yf9Fj1?=
 =?us-ascii?Q?xyeYFUPkn0cBOS9EVNKxr4mooWjZYPoXQQlC2ipKmAxVBvvgrDEoAYO6y0Ho?=
 =?us-ascii?Q?tPbFqsqJMnM5BbGz+TJgSjC8cDurxDWye3t8ixQlC0M+NfapBBtMni6TWZ0K?=
 =?us-ascii?Q?ncVVzdxEUF+ppw6mOmMJ9ITcBMOuBkk6HXTJI7Xh/mUHf1qEm3NbcSCYQzL/?=
 =?us-ascii?Q?nbtHjLF62z+AT788dHFIf2xeRtCGrp0+OfCAUd64AQiIKPAVAYK5ImdLJF2s?=
 =?us-ascii?Q?vmM4XX8+Lg25GXf0eoHpDvVc2+eNr6bF0kuZrP2D7hmgP9smg+ZlxFGlpcEA?=
 =?us-ascii?Q?UMili+ctxccDM35zvba7PWmDOCE33BP2aIWmYhXSGKAQzm4YrknQ0mPLsKXT?=
 =?us-ascii?Q?m+1SMwma2l0neb7HezgGJUtpXGxKd/9xqYA2R/9r7F5rwlMsyQ8AefULaqPo?=
 =?us-ascii?Q?NwEF7JIkHg78h0mWktrjDqT1GIkW+TChgpKDZomUpHmKcRbhobu5yLR9A5+L?=
 =?us-ascii?Q?wJCOvoXG7xFQejJrPfxrP+tw8qpKvDqVH4odWWOjCTY8db2hrv7+SsHvWs8f?=
 =?us-ascii?Q?V8KeNl6OLNNCdw+MZOq9wCN8sTa0ABOe2YvGPRORhdsXt8ZWty3rV7x7BLw9?=
 =?us-ascii?Q?L407YaFOV30o/CPncaZG0UrQWHA/PPGsLhLVrhnMf+ksRoiTXJlPDIsRaHtZ?=
 =?us-ascii?Q?7purCr/AmXZznEyx4ts9Qgay8JZIQ5ode4nE1WlRY9ORwuS2MklG3PqhRZDS?=
 =?us-ascii?Q?SmmSVx3GlaA9AQ01JDQPVkZKRa14k7mdVohLVjXJQSRh4JGb/fjVHeoC32GT?=
 =?us-ascii?Q?KkUbkhNN8WlGW9n2PMm9YtKORqgvR57Mv8SXROe1kMdreIdYwgmXy4yiJZ1R?=
 =?us-ascii?Q?RZ5cR+VMqLT2HEunEYxthQI8nUppntVBrS89vklKSg3J/1xBNQOdGdbVQqO9?=
 =?us-ascii?Q?Pcpys6DNCqGHOKZb2ad68Grq0bAmbo7vjHaocaTgyLb8x7eDiRbdAN8UFAwP?=
 =?us-ascii?Q?bH0JPQ4Pzm5qN4C4lt4YDfpparIjoiO+26ptFb0nSySxCahIFz5DGGSM7GB/?=
 =?us-ascii?Q?rP5N8wA0iMEFiTiflSO/LAAwmwnGwgt5cfZOizFK4A7lVdtKSraO2ArvbYuc?=
 =?us-ascii?Q?Uw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <77C0C656CFAF8944AB10481A95537686@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78a491a8-b9b0-4b39-7b10-08da5f824f83
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2022 19:04:11.0281
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: afnl8QEwPOXmIkP+RbAU5e8ThNfbo+fr1+RxvlVJsc80/2YxKmT84g8TFIiEvXH4CBhdRAQlL2SMsG+4ydL31w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5101
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-06_11:2022-06-28,2022-07-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 adultscore=0 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=949
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207060073
X-Proofpoint-GUID: XaWRekcFxcE99jxBjdjycCKnKPkwgaXe
X-Proofpoint-ORIG-GUID: XaWRekcFxcE99jxBjdjycCKnKPkwgaXe
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 6, 2022, at 2:57 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> All of these tracing patches seem like a reasonable thing to add on
> their own, IMO. It might be good to move them and some of the bugfixes
> to a separate series and get those merged ahead of the parts that add
> TLS support (which are more controversial).

Well, that's why I moved those to the front of this series. In the
past, Trond hasn't been shy about extracting patches from series
to apply sooner rather than later.

But, yes, if Anna and Trond say they'd like a separate series for
this, I'm happy to oblige.


--
Chuck Lever



