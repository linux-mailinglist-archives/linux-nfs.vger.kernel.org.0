Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50F3C3E97F9
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Aug 2021 20:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbhHKSxQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Aug 2021 14:53:16 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:45132 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230000AbhHKSxM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 Aug 2021 14:53:12 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17BIpIQt008459;
        Wed, 11 Aug 2021 18:52:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=y1uAfNotmscJ8+5d+p/jRauvyzZ0H1i3zFFCSs2X7qY=;
 b=lyKFGCWY5/whMiluGoKxqL5UoDkvMDJAqIJBgFfp/R3ywA58xcbF8GDjTYnpNOClx/Um
 5K5GpQ64U3fBYkQSmL0zq5MrfKmaOGWvA8RqHbgG46TLBSDEhcaPMbYJQYfvonB9w+R/
 fbSgLY8ydNmCOQloxGkS7T/4jIi1vGY6+eEBQcIbh7LGGZeQeDv/4Spjl1wfja3SDLdq
 jio+9z3DPOeBz8f4K3KyrJcAL8a7i6enzbplXm8OcHzS+eSARl+HTfCw68c/66073gzg
 KKoy/DNX5STFBV/etUKw6lquAH2o926f4Tv8t3iMWPTuoWFLD9o/d87hFyZOZVL7xtHa Nw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=y1uAfNotmscJ8+5d+p/jRauvyzZ0H1i3zFFCSs2X7qY=;
 b=kTm6MWEwzGHB6LDkDuDH+23Ekk663qB1byFmQBwjSuwD3ev16LBXZP4I3UvJ2SMj77P4
 72NIa0pIF6Qop4KkezSLHs6Ena4C8SQwC9MyO2mQaIwGo1xYu/HksRfsqhXgOh9/VioQ
 wDIdt2Um+eIAP7Gux5uMbA/S6r/ZInYxmpJrVjcsCppA+5EEPMI8KMa8etqpXNf6ouy2
 Kg3o6XZ8huBLsjZmcGvxNSNMGsZ4/URYfLlGpV2Rlh9BPxEWbSBSLM4veCY/EM7jbcZM
 G73lHRfPEi18JhHbDIR2iZyyivgepNyQc3hzF6dYNjFoC5HtW1m7T1RPa9aSGl3Mdbtx Mw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3abwkgauab-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Aug 2021 18:52:39 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17BIpxOK031170;
        Wed, 11 Aug 2021 18:52:38 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by userp3020.oracle.com with ESMTP id 3aa3xvmjdg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Aug 2021 18:52:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gXg05ISgwVkAp0ZbiMdvYVDH5fFZchd60H+waWVeYKexyO8BT1svA/y14mpQlvZTvdePh8mshCbIw1tQS+Tc9ybEAFpZtynevmQQO3g5PuSZlrp3Y18ytr7JHM0UUoPDPYxLLXZOul+oPPX5Z1qCBuNasws3JVTkzX6U4ZapZFLHc6O6xalDSbocuRwwRq6IJOG2znySNeaPpgu78gvaKdc/UTjHQ/nh/jBkxsObuN8UfhNTga5ZTjIoTSMrM8wTmrCaNt6MmBNvw7Vdx46ZAwA1Qz8VhF86a3CUEgceCr3cOcjD3l/Ii7ufbCZ+Qlt4OpiB4isc+mNDYB4be2RANw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y1uAfNotmscJ8+5d+p/jRauvyzZ0H1i3zFFCSs2X7qY=;
 b=HdznXqrUeoct318xydPpjIF8t1f0DJXo469kOp7FQCK2KATzXl++w/qzRmCcyH1lAxwhZrCEyl2GlNTguqM+YKim5N+9GFT/VgY+69rMR7YFZVUUt1eDOwrAZXJYHARXleX+G2xV2jVfZC9tGtofqPoUHnjnnfQ7ZilqaBuQHKxElpLKu2KuY86vcqoeeo8JYVX0fVCyD1NfnIE2hL8iJfqbMpiUHhPdvdHHl4u3NmSs98jz6NGRxiJw0smL7ucEkFMtE8UXM4zn8MwBxWB9TUuS67Od/eD80vjLroqlM67Gu3hZfdiZZdWYFSTUIGaA4FCcoTQ8x7OqVD2SJllneQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y1uAfNotmscJ8+5d+p/jRauvyzZ0H1i3zFFCSs2X7qY=;
 b=edww8bCO7ouzwkp1pTEYmPjN2/L8Lh1SmBiKzdiY9wtReiRBmnv7OlBK+czw1xSB4m8f2oiE0wmvYl66FOHHx5WDHYjJErz8wj0/CDbTrnG2sJgz2FgJOIJqtCDeLPx1oljCGYTiGM6Bj/APxLZ7Pv7jNdn14Txoo137MRjP678=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by SJ0PR10MB4605.namprd10.prod.outlook.com (2603:10b6:a03:2d9::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16; Wed, 11 Aug
 2021 18:51:24 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::a8db:4fc8:ded5:e64]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::a8db:4fc8:ded5:e64%5]) with mapi id 15.20.4415.016; Wed, 11 Aug 2021
 18:51:24 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Olga Kornievskaia <aglo@umich.edu>
CC:     Timo Rothenpieler <timo@rothenpieler.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Dai Ngo <dai.ngo@oracle.com>
Subject: Re: Spurious instability with NFSoRDMA under moderate load
Thread-Topic: Spurious instability with NFSoRDMA under moderate load
Thread-Index: AQHXSnp8j8N6G2OhyUK9Nr2RtJxnoarn3hgAgAATb4CANuhZgIBOXZcAgAAVhICAADVLgIAASYeAgAAo1oCAAAOTXYAA6JWAgAADg4CAAANlAIAAA4eAgAAZh4CAABNpAIAAEuyAgAADt4A=
Date:   Wed, 11 Aug 2021 18:51:24 +0000
Message-ID: <95DB2B47-F370-4787-96D9-07CE2F551AFD@oracle.com>
References: <4da3b074-a6be-d83f-ccd4-b151557066aa@rothenpieler.org>
 <72ECF9E1-1F6E-44AF-850C-536BED898DDD@oracle.com>
 <e12c24fd-beaf-31ce-cb49-36ad32bd22b3@rothenpieler.org>
 <daae674a-84d4-de36-336d-693dc582e3ef@rothenpieler.org>
 <9355de20-921c-69e0-e5a4-733b64e125e1@rothenpieler.org>
 <a28b403e-42cf-3189-a4db-86d20da1b7aa@rothenpieler.org>
 <4BA2A532-9063-4893-AF53-E1DAB06095CC@oracle.com>
 <c8025457-7376-e1b7-bd6c-e5c6ee5d9ce7@rothenpieler.org>
 <141fdf51-2aa1-6614-fe4e-96f168cbe6cf@rothenpieler.org>
 <99DFF0B0-FE0F-4416-B3F6-1F9535884F39@oracle.com>
 <64F9A492-44B9-4057-ABA5-C8202828A8DD@oracle.com>
 <1b8a24a9-5dba-3faf-8b0a-16e728a6051c@rothenpieler.org>
 <5DD80ADC-0A4B-4D95-8CF7-29096439DE9D@oracle.com>
 <0444ca5c-e8b6-1d80-d8a5-8469daa74970@rothenpieler.org>
 <cc2f55cd-57d4-d7c3-ed83-8b81ea60d821@rothenpieler.org>
 <3AF4F6CA-8B17-4AE9-82E2-21A2B9AA0774@oracle.com>
 <CAN-5tyHNvYWd1M7sfZNV5q3Y_GZA2-DoTd=CxYvniZ1zkB5hyw@mail.gmail.com>
In-Reply-To: <CAN-5tyHNvYWd1M7sfZNV5q3Y_GZA2-DoTd=CxYvniZ1zkB5hyw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: umich.edu; dkim=none (message not signed)
 header.d=none;umich.edu; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f29691ff-cbcc-4955-c12c-08d95cf9049f
x-ms-traffictypediagnostic: SJ0PR10MB4605:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR10MB4605719CD479A3CCB8985DFB93F89@SJ0PR10MB4605.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8P5KE8YIi0ZTd+tQkmFC6JKQ0UbNKPRdFkovb+6W0+vwejzTR0ZTEONs+LGykxxd0x5S7cLBuneo8KSLLxhqwM6ITQytxsFFkqnENlE08ze+YxAbLCsOWHElULmmr+8AoIIua9ogStOB/Zkld/Czz8QiqcBZMKmoE75kK3uAsxhaESv49cuQBcADCTQE6HcQuWGef7rhoZGHpC6gWbnTaA6i0HFcsoae9Xy+2BuGIWNqHAfu4dvkqoECfNNxU4FPrH2YS1ADbuNewlnZSm3UOmEWoGoywQqCqsurdYptTM2l0i0oLuRnjl7ty40emGdQWGw5T4Y0oX9NLv/hOHh7GfOEh8Bl6jmGERunDNramJA5QemAvDm0UngHIgTPEFTollfn/ceUS2UkmF7AtFFhbKCpWKCHpY1MUkCyDP6IS2jIuZhQxWaayVrKyZfr6s/hpD7A7UAYC2+Eart+fdiTsavjgU63PAgN3HpvmD5gD4sNm9tQcFQ8+G8lOq1UXc44edg9Gij3z7p9nGPNUq7czJzHiLh0Hvx9ZpXUSHJcmsqx58eoN6i+Ouk5BXfWdUNIAnPge8NHjrdYxDDZgOs9VxFK4mCw/RaYONJEl1USg6I5UZS1dq5OroTMKogpnnlffr4t7U088oSRVo8szV2VrmQ+jyu/hLWaFntPGemuvSltuQwUeCvpYcKTI5X4eCMd5AXEZUIK+oCK0Ofj1ubQlJkKT+d5ImmH2oZ41xwN5xttjRfQowVBNho18++p9uMP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(39860400002)(346002)(376002)(136003)(36756003)(83380400001)(76116006)(91956017)(6512007)(186003)(64756008)(6486002)(4326008)(71200400001)(66556008)(66476007)(66446008)(38070700005)(66946007)(86362001)(2906002)(38100700002)(33656002)(6916009)(107886003)(478600001)(8936002)(54906003)(316002)(2616005)(8676002)(122000001)(6506007)(53546011)(26005)(5660300002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ISYtHMeje1Bd+d3lfS6x7/lj0Bg/rVhlA9hD4T5GamthG3qKXgEa3q1MQJeT?=
 =?us-ascii?Q?5ubswMXPDLDuEb8E47sedLJ5QNYw/EjW5wixCzkPYHfkQJU6U+09drOwZrdL?=
 =?us-ascii?Q?J4qJAHlCA2poWuZwfmT9VxuV3zTkd1i3BM6sd38FZt8Ar4wgMzbi9w5WOJh6?=
 =?us-ascii?Q?8GYMj+kI6amq7Wvje8WEHUs3yko9xw3EO87uDSJZJj8/spdi7YB08AisPFsX?=
 =?us-ascii?Q?1irdgYveKXQyrcwrfJYbd4qrOFvBv1Y0upJRpongVIlY69x4kV7gkP02lw3/?=
 =?us-ascii?Q?2jtcoo0VynpS6b9lmTlFgbMANRp94GL7bUrpYeFKzcRlzi8H35xBupayHfLk?=
 =?us-ascii?Q?DeTxZhgnVtMC90Oajl/r0HwPJETwKIfWkbiM2e0kM8dDVZbj5aOIoj7BXXvI?=
 =?us-ascii?Q?byie/x+uOcNjKhnrUO1ZQTRcpBab1NTjqxhqnpYG6/DuMcwdjUagV10eId8K?=
 =?us-ascii?Q?7qxXqpnCEkXJI1Rlh6akdvkvNY2e1NNTV8wAgbqhWrRLMRK8ZpTbQUyeSpMw?=
 =?us-ascii?Q?R2TzmnxkeOsS5O8SPVxvbLdOnJmPbfTOWvvpu5QROTpeyOvg0+1X3fUE0D5l?=
 =?us-ascii?Q?mHzofwZ7cdMCK0rQNXNQDLKWOtFGo1ACkf6iS5UFxN7jGnFY6QXlSdEvvxdk?=
 =?us-ascii?Q?t/uysJ+i23pAAa7/t1GUS3cUJlUE24xLWn1n/6YQ/OZ6dtEzP4jAMM4JNc1M?=
 =?us-ascii?Q?R4r0XJQhxW2H7oSnhVnjF77JeI424tlpzM3iW8hVzcoahwlpefvLzVw4vtDF?=
 =?us-ascii?Q?l52YBg01ZE6Mk7FprRh+tLRs2AGLY9zGr7XwCr7Bk54ARe4DB/iuCfS9OxE0?=
 =?us-ascii?Q?FxXHmhxsbuZG8K/jQWs3j2OjBg0lMyJNqz/zh9ioP1Awcoez8P//JavNMSTe?=
 =?us-ascii?Q?hzasS06w2TErk6YoSFFrV+zsfrPbnBXCdkJP/g4ez8zmOJYeLaTsNRv35PV7?=
 =?us-ascii?Q?lkus9QlIU9INdo4KZ9RoD23CF0k4FGaiMOcyDGjneor83M3MVZmhsIFbxjKA?=
 =?us-ascii?Q?Y18fyfVrk+s6iHbJDF8WRNJ1xjzCM/ktbKcpzgdtt3nQKEb4r8hgSBgyr3YE?=
 =?us-ascii?Q?bA3b7kiR4tVjSEEa2iFd/cw29blMYneeUMx8bzoMt85CLZbNcpKf/5Eplq4H?=
 =?us-ascii?Q?udi0lKPex0tsIPQvI6mZ0cqYGRwTokeaFb5xyU7omjvMDxc4z54DDStHWcvM?=
 =?us-ascii?Q?Il+yKTa/9jLtO3RkSfZ9AbZNdMGPM6HQ9MtYZVaaf52ot21WPU1ffOHWh22V?=
 =?us-ascii?Q?8+WQDQ5AioZ4BfzWnB7nnRYbOaJAeyVt9dZzGc3hjKkB1yHV0tpkJBTLsaZ3?=
 =?us-ascii?Q?DJX1Rm1rtadyNFrX/MoVxotIP8dP2GqMIV/lXRXI+G/2tw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2F7E170FCBAA5949BC73C9CE757C35BD@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f29691ff-cbcc-4955-c12c-08d95cf9049f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2021 18:51:24.3298
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m0ppL8y2J/8R9LSQAhIOJhT0m7xzxoTGXLCvDQ7owE8n2ZksF4kyEsP2UGq2mTig0NufQgu76PORPGAc8udjsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4605
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10073 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108110129
X-Proofpoint-GUID: xXNWXwB1AkmQepAYJovfr5V6aD7k5wkV
X-Proofpoint-ORIG-GUID: xXNWXwB1AkmQepAYJovfr5V6aD7k5wkV
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Aug 11, 2021, at 2:38 PM, Olga Kornievskaia <aglo@umich.edu> wrote:
>=20
> On Wed, Aug 11, 2021 at 1:30 PM Chuck Lever III <chuck.lever@oracle.com> =
wrote:
>>=20
>>=20
>>=20
>>> On Aug 11, 2021, at 12:20 PM, Timo Rothenpieler <timo@rothenpieler.org>=
 wrote:
>>>=20
>>> resulting dmesg and trace logs of both client and server are attached.
>>>=20
>>> Test procedure:
>>>=20
>>> - start tracing on client and server
>>> - mount NFS on client
>>> - immediately run 'xfs_io -fc "copy_range testfile" testfile.copy' (whi=
ch succeeds)
>>> - wait 10~15 minutes for the backchannel to time out (still running 5.1=
2.19 with the fix for that reverted)
>>> - run xfs_io command again, getting stuck now
>>> - let it sit there stuck for a minute, then cancel it
>>> - run the command again
>>> - while it's still stuck, finished recording the logs and traces
>>=20
>> The server tries to send CB_OFFLOAD when the offloaded copy
>> completes, but finds the backchannel transport is not connected.
>>=20
>> The server can't report the problem until the client sends a
>> SEQUENCE operation, but there's really no other traffic going
>> on, so it just waits.
>>=20
>> The client eventually sends a singleton SEQUENCE to renew its
>> lease. The server replies with the SEQ4_STATUS_BACKCHANNEL_FAULT
>> flag set at that point. Client's recovery is to destroy that
>> session and create a new one. That appears to be successful.
>>=20
>> But the server doesn't send another CB_OFFLOAD to let the client
>> know the copy is complete, so the client hangs.
>>=20
>> This seems to be peculiar to COPY_OFFLOAD, but I wonder if the
>> other CB operations suffer from the same "failed to retransmit
>> after the CB path is restored" issue. It might not matter for
>> some of them, but for others like CB_RECALL, that could be
>> important.
>=20
> Thank you for the analysis Chuck (btw I haven't seen any attachments
> with Timo's posts so I'm assuming some offline communication must have
> happened).
> ?
> I'm looking at the code and wouldn't the mentioned flags be set on the
> CB_SEQUENCE operation?

CB_SEQUENCE is sent from server to client, and that can't work if
the callback channel is down.

So the server waits for the client to send a SEQUENCE and it sets
the SEQ4_STATUS_BACKCHANNEL_FAULT in its reply.


> nfsd4_cb_done() has code to mark the channel
> and retry (or another way of saying this, this code should generically
> handle retrying whatever operation it is be it CB_OFFLOAD or
> CB_RECALL)?

cb_done() marks the callback fault, but as far as I can tell the
RPC is terminated at that point and there is no subsequent retry.
The RPC_TASK flags on the CB_OFFLOAD operation cause that RPC to
fail immediately if there's no connection.

And in the BACKCHANNEL_FAULT case, the bc_xprt is destroyed as
part of recovery. I think that would kill all pending RPC tasks.


> Is that not working (not sure if this is  a question or a
> statement).... I would think that would be the place to handle this
> problem.

IMHO the OFFLOAD code needs to note that the CB_OFFLOAD RPC
failed and then try the call again once the new backchannel is
available.


--
Chuck Lever



