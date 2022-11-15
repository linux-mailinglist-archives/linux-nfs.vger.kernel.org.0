Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53196629BF5
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Nov 2022 15:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiKOOXr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 15 Nov 2022 09:23:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbiKOOXp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 15 Nov 2022 09:23:45 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 403DE15FCE;
        Tue, 15 Nov 2022 06:23:44 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AFDdcDo003865;
        Tue, 15 Nov 2022 14:23:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=oXKwwe0+Q+TqzNeyiSsT1JNFWH53liTVzE1yCLaCPQ4=;
 b=VYlNtRyTdYbnYKINLJv/fXzoqtlJdchs9SzdVV/CHJhl1ZarvbmeWvIRWtIszj4XYNuL
 s2Gcxx6GfoSTJPtzl4MCKiUNt9lS4Ne/46wv/fB67wSXZuMDX7fp4MBIChXq0WIInSbA
 Q+RiEsbwhX9drPJ0mYxtP152U4eb/0b3qQFKH/7oTQzMtaYIqy+zPYVL3BWB/WiLKD4X
 Laj+lnkJJJIZgcDQi3aqAv7r33oGeq8518MEbAlYWnuIk33b+uEq43hdKdKwUK5k6N5f
 ITDva7ZQfUtRKkawI5U84YkPLCl9n73XGLfogWmga7LWM++mHqMn/Iz6HnfWfnTcAyx6 Uw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kv3n11dxy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Nov 2022 14:23:38 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AFE6iJl031772;
        Tue, 15 Nov 2022 14:23:37 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2042.outbound.protection.outlook.com [104.47.57.42])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kt1xbvey2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Nov 2022 14:23:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lAkk6F9PoXfGrWA8tTjUTK+OoVAS6KnmL5x+b2UDPfAYVO+cSOlrvYGcVtWnbWetnxC/lEhjrYnZ6Kf8SeA7bEXX7PhPqgmeevZ90NYV+rkgnBsRS5wsFY0VWdoMoqzzQTGH8Jx1pJVpdu4bxXacG/j/KrpkW3SmXrCxsG2+AbVovTlpPCdNXPNT02LS8JASErABpS1J+ZriKWe7P82UxoBh4X926lOzdCBjOU13o7OxGCUw3LcjjT3B58jX2OyJqwk7qxxQt9Q11caVZ+xSiN3vmjORgMQCaPdFigPEPrNbQBBT0eQxCW2LOZbEG0T/FBKNncFlkf6Le0wAdGph4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oXKwwe0+Q+TqzNeyiSsT1JNFWH53liTVzE1yCLaCPQ4=;
 b=KJR2FxPez2pTMf05ftLE1teTQFuNZ8f5gRBjQgm9uPK9srfvoAF1PIFVQrzhpEeJQ9WHtJ3bG7eKFKthII6vNFKDn/ajWRFwCIJWYqZZPSUwWn5gmn+l4sSUS4EYxEgGD7y5GRTMOEQr2gGMqkl+A0tX5L+0yS6Hgb7rybPv35ZyMNziV7nRFu6CXjTekk3he3uHc/fDXz7ZG8I7ZC4LmqASWCOGW0N2A+Ubt/UqXFFLrzjFSyBiQRqkqyXNwY/vONHyHyO15/59j58eHArdwso/eBbdPx/83jlATyq/m2/Fhn8/korO/KhcN1vlGALzbuFE2CxxZCIgEennOUFnQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oXKwwe0+Q+TqzNeyiSsT1JNFWH53liTVzE1yCLaCPQ4=;
 b=qVrT4RpndK/18sBMLp7U+2UMweq8xjiFW0rNp6azkevXFw0ar9HuyC/Bvi3K/kGTIUdQY2BsYblGj5vFE6Kd2xe8Ezl8jCJC5ElUxkxUOOr1OoImRQVao1vc6K962q8H0/lHLxTwKjqEPy7/mJqM38FyaK61ni8eE3xOuRfUR+g=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH0PR10MB5003.namprd10.prod.outlook.com (2603:10b6:610:ca::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Tue, 15 Nov
 2022 14:23:36 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::b500:ee42:3ca6:8a9e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::b500:ee42:3ca6:8a9e%4]) with mapi id 15.20.5813.018; Tue, 15 Nov 2022
 14:23:36 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Steven Rostedt <rostedt@goodmis.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] trace: Relocate event helper files
Thread-Topic: [PATCH v2] trace: Relocate event helper files
Thread-Index: AQHY+DwRDNK42nvg4ES6zBIsBj20T64/r3EAgABbx4A=
Date:   Tue, 15 Nov 2022 14:23:35 +0000
Message-ID: <DF49C9C8-5AD9-42A4-98D9-6DA61D9D3E1F@oracle.com>
References: <166843895843.170837.8663873976042560070.stgit@klimt.1015granger.net>
 <Y3NT6sCGhtf16FaO@unreal>
In-Reply-To: <Y3NT6sCGhtf16FaO@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CH0PR10MB5003:EE_
x-ms-office365-filtering-correlation-id: f17c7169-3dbf-4a12-0a28-08dac714fb8d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p9G3UM2MPiD4/waWu9gBLaSfxBhVp9owyH5lzFThcUArhqJbCn4b6kJUWxLz/z5deNI6LutSbUwHQXwqXgH/Lgj05aBoh71xEo+3rnSBlZvpDJmgUf6eTkKxDz32K9+otqAVU790bgs1TVj8H32asm4DxS+rYHw66bW6FtZQWFTjvnnL1OhrTSQ08S9PCeo6rZupTwjZWiDCSxgCHks0CsEndhXv5knxnlVdRVRInxA/3g9Qo3Ol5nKQlxtXLqy5YIR4wmfUgQuIPy92NRoUnAjrKFKQ33GMPsw7OOpxn+C2/ya9RhgVW31+MI/mgh/2B1E2ly2CPzOHW9FjcKckBSy+duu0v54EqPE6aO+NPSIKWujHCMuDjxqXzDUyGBhC+p1GNb3gTE+DguWsjji86RQOg+hVX5Ta6At8zowrxnWk95rK1qHomyuCgoGIFoWqWz4NMz+lQMYDF8Mxvi28znIvpNsP8/Puh3L/3uxeJjR2f6O4+LyHEvPAPlQ/B3B+bZUV8ljUlGc3oJmjx6ZLLjJoMQDG3b2Gq2SaZ/vhHwW5lUSbBNx5aw4V07VZKadw/yItC4fuusM47HXUjYDHcCmhc1rZ91EW8RddfCGi/t7FWPC78pRGmtzjTjhQytiFWRwyOqaGqKQrUdsVxRVgRXgR5RA5wyIgeCLA4Z5Fn2cbKtGJuv1FMjz1Lh2TEGaElLymffqh0rxVXj+OQ66UToHW/oylZKi0Mtk0FQn3x9z9axWRM4viA2yV8B/x0utCOBJUusclWotfMIGkTukgd5cvrIIOG9+Ok0xV+nxf/uk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(396003)(376002)(39860400002)(346002)(451199015)(38070700005)(33656002)(6486002)(71200400001)(54906003)(6506007)(6916009)(478600001)(6512007)(8936002)(66946007)(66476007)(26005)(64756008)(66446008)(76116006)(36756003)(8676002)(66556008)(91956017)(4326008)(2616005)(41300700001)(5660300002)(186003)(83380400001)(2906002)(316002)(38100700002)(53546011)(122000001)(86362001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jEW6FgkPj3l04/xBYVf79WXh9SlPzBb0UDwloyW+tjoQZsScYFcf3jKfHbdc?=
 =?us-ascii?Q?4BdBRMz9lIIj7bAmA6KctrPTp4VDBP6OvLUqeAoSs10XeUJuHepxATTq1IwG?=
 =?us-ascii?Q?RLQtQ8kpSwDZI3PGsIZ8M8bCQuN2LgTQbgrSlP5BPaWDskAzz3NUoVhqda7B?=
 =?us-ascii?Q?zLg0RohiGzunjvD/AnNJJeAunI7K6BgsMm7SDMINDCb7j75ZKPBIR71Y0vM4?=
 =?us-ascii?Q?P/tpEChKVjlO0mxcVqtDSA7Pcw6EV1U2NYKH+pCt/KLkpoM8f0g3ttugz8Xa?=
 =?us-ascii?Q?C27HOHAJ0ZfUJXYWKMS6ELg1OuxfbA2/6W0AvtDd/vkRDAXk80/s4M1aVhLx?=
 =?us-ascii?Q?io11zEzI+tBwWOrSJ8AXOozw8RpKGuIgVjMsosBMelW5I1H2tc9FbVpTIxWv?=
 =?us-ascii?Q?IxpUH+hvAtp4VDdPqYJKe03/0mlVai38gY197L8P+7oCHF0pFb+uH5vxDD7S?=
 =?us-ascii?Q?2mvYCdYrRSZzYLWlimAOrGt9u2TjC8lHkM8j83pf3b/MhqZjG/Ivnrh5vl3v?=
 =?us-ascii?Q?b3Sewmpiw6tTgDrK7Yg9gpdCHrGybqUGIeKZCT3zYP0Yhz+VX1EO/Zj1jS2b?=
 =?us-ascii?Q?xo9hX1N8KOhyJIGw/8W6BaeaOf0/Wfzm39d+zyoywhEYpBXOcNXzRNhrWte0?=
 =?us-ascii?Q?SArvXlnjfQdoPIdRX15Fzw17ADYz22wpDabe2DXLxjj7k3TR1G/i0/aNTNJQ?=
 =?us-ascii?Q?bInvTcpPYJ/yW7U2Vi+7is0G+2Gu7WR1Bn4pT5yABOYI3rVOK7eOiXR2PjN0?=
 =?us-ascii?Q?NXAiCTt4DPx2XcvH3fqCT9uYfuf8YfSEiLCtWxAZbp4P1fyZ/5ax1AeTexhr?=
 =?us-ascii?Q?IzS10Ox1Zs/j57oxgKyMBQ4A5vbYMsJ7ZZpDr2ukMI7ppki7KLYcQZBoL9W+?=
 =?us-ascii?Q?dYjd6azYzChNNUizJpUceOM52JxeYSE5UYOBz/s9+Omo2CMVYNFsI2NoGKqE?=
 =?us-ascii?Q?3fW/7Rd/lfr8DqZDfh/uGwGeVjO+V4zTKi49IBvyfML4APISdKxUKpcOky+R?=
 =?us-ascii?Q?f4+ZnDTn69lmq5w5f9plHKRa1ae3MjQj0egpknB77ZbXqnFVAmYHyJZ3ts34?=
 =?us-ascii?Q?Th3yMEtWpqrHaSgslN88iR9AigGtxH+XtxnRd5ngn3Igc4P9c2mSHBslPO8+?=
 =?us-ascii?Q?FtRBZtsRyyuO+vIbLf7RyA0dnIJX/KoDQIDw2pAhFa0gd3Aca7lh8i0TfoB6?=
 =?us-ascii?Q?Wkk9ZaO5M/jiX+OlqhNuFc7CwlMLOL2XhTNj7ijbJdrMmfD9ACOHUdyP9L0J?=
 =?us-ascii?Q?F2fz0MESZTfWlUjRboGpfZtnYm3s6auGbEqt6l1qWv/cyVGHCvNMk5iMJTMk?=
 =?us-ascii?Q?GWum7Hhhke/avl9X7Ftid1QsVOkKqUUPN/0er2ibzdDu3IK+zf6xNrn4qUAO?=
 =?us-ascii?Q?Jmt5idcDqm/QHUQAw/mc9daZ5MQkHAsIZm5Qp373ipbrGjncYzq81ahXTH+T?=
 =?us-ascii?Q?nma2ybKYVWOE2pIVSgTdD+n0gELGbB3N+HHQq9mi79IRKA+X7ogB61Kk4NU4?=
 =?us-ascii?Q?lS752J5SA0x89swwXN/0u8v8Syszb/g/voOZzpmpIB7UwEdh77FZA8GDs81N?=
 =?us-ascii?Q?9UI8MulE5FU4bbRnEXcRwZMQQ7HyR0tXMiwZwS+rO7Dn+Y2JsqG1BE6ShWUI?=
 =?us-ascii?Q?6A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2F18D9C5C44FF740A287C0A64374F329@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: qTTq9h/ahpyunGCJqWHKWILYrJm7EVB/iDz8SdvcxguAJoDjpD7Kh2JZnYybW+8YUN2CNopuFVcr0WpOvhdczI366HlIG+DT/8CqTASZYrCJOBzWg6t03nlsowR0baHI5od+5XpALd9h2PtiaQGFr2lhdQ3F5RqiESxESs5mtf0uYK2XldP00yek5ertSJUq8rCfNkVZvInpPRL/OrgH18Q2ZeWIiAyH4Az/OiGB+jmuxiybaR2y+yWgwnLYfN/IryKg+11BTvguQsuF9klAhGf+txm5qjzMhdwjE11m/Gslouj8Y4YumhGMNQQfvmAHP9j0x889tg0OA9ZbwteOEumj1UY3TQHHyV+OE2/OM7gAzhuMhXpLNQRh5JZMFq3DWZ+PcDkCTPacBsR7G22v8lMCWouZYC9Xu0DNjM9htV2geIFhGWfqlNGg9XDxxj2cSKHVnmGiY8mXeS0+QIG4dgLn2Mp+w1VUJrK0b27pvjhiQouPr4ADurX8IwKRAYJZtN3ExccbkJqmRw34e1zD/IzWqMThvl+HyyNOW/x7rs9ko9LJCpfVCJgExVqTLhJP2SopU+mRG2yhk0fsOgQlcQ5QRC8Q3LOL0pvmzzheMcDfZD3e3ZLXIipmAj0H7LYtJkWK8GpRBCdr0v5TGmi2zVFDdLOVWPkDanqkqdQSQoPwkSTxvYg9d7Mu45UOYp4K+ct3+qImeSIieUAbZvqJakGWfct7EYsl9BAfr+mFG636qY450ODTNqLwrXWpQrBJPlJPC6smbPbMnuiejGXDwzX2/uo9nlNprkLqw78/2hQx9594LwQWmUhii23rBxFPfS4dGATG3kNJ047hoLYAhDeMCfa0DNVkxF11arBsw1IaPN2JJQyjqmNf5KQ+3ptIO022H7gxQSYf5go3Km1OMqJj74GQakGxYtFNIcVVPiE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f17c7169-3dbf-4a12-0a28-08dac714fb8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2022 14:23:35.9788
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rKL+rHJwrlKfdwHtU8RBNyJZESPXLNeyynbhYgaiZnuxyHQAa5pTSw/jhAQwKbcKM0f7cxrPpKu8jUe8dvCaHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5003
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-15_08,2022-11-15_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211150097
X-Proofpoint-GUID: dvEIlnmjVZz2jocSkt0dvhZndATK6Zx2
X-Proofpoint-ORIG-GUID: dvEIlnmjVZz2jocSkt0dvhZndATK6Zx2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 15, 2022, at 3:55 AM, Leon Romanovsky <leon@kernel.org> wrote:
>=20
> On Mon, Nov 14, 2022 at 10:16:12AM -0500, Chuck Lever wrote:
>> Steven Rostedt says:
>>> The include/trace/events/ directory should only hold files that
>>> are to create events, not headers that hold helper functions.
>>>=20
>>> Can you please move them out of include/trace/events/ as that
>>> directory is "special" in the creation of events.
>>=20
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>> drivers/infiniband/core/cm_trace.h  |    2=20
>> drivers/infiniband/core/cma_trace.h |    2=20
>> fs/nfs/nfs4trace.h                  |    6 -
>> fs/nfs/nfstrace.h                   |    6 -
>> include/trace/events/fs.h           |  122 -----------
>> include/trace/events/nfs.h          |  375 -----------------------------=
------
>> include/trace/events/rdma.h         |  168 ----------------
>> include/trace/events/rpcgss.h       |    2=20
>> include/trace/events/rpcrdma.h      |    4=20
>> include/trace/events/sunrpc.h       |    2=20
>> include/trace/events/sunrpc_base.h  |   18 --
>> include/trace/misc/fs.h             |  122 +++++++++++
>> include/trace/misc/nfs.h            |  375 +++++++++++++++++++++++++++++=
++++++
>> include/trace/misc/rdma.h           |  168 ++++++++++++++++
>> include/trace/misc/sunrpc.h         |   18 ++
>> 15 files changed, 695 insertions(+), 695 deletions(-)
>> delete mode 100644 include/trace/events/fs.h
>> delete mode 100644 include/trace/events/nfs.h
>> delete mode 100644 include/trace/events/rdma.h
>> delete mode 100644 include/trace/events/sunrpc_base.h
>> create mode 100644 include/trace/misc/fs.h
>> create mode 100644 include/trace/misc/nfs.h
>> create mode 100644 include/trace/misc/rdma.h
>> create mode 100644 include/trace/misc/sunrpc.h
>>=20
>> Note: with an Acked-by from both the NFS client and RDMA core
>> maintainers I can take this through the nfsd for-next tree, unless
>> someone has another suggestion.
>=20
> Please update MAINTAINERS file too.
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4db8e4e02c05..86e57325eb6e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10054,6 +10054,7 @@ F:      drivers/infiniband/
> F:     include/rdma/
> F:     include/trace/events/ib_mad.h
> F:     include/trace/events/ib_umad.h
> +F:     include/trace/misc/rdma.h
> F:     include/uapi/linux/if_infiniband.h
> F:     include/uapi/rdma/
> F:     samples/bpf/ibumad_kern.c
>=20
>=20
> Thanks,
> Acked-by: Leon Romanovsky <leonro@nvidia.com>

Done. Thanks!

--
Chuck Lever



