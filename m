Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9BE53EF4AA
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Aug 2021 23:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbhHQVJP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 17 Aug 2021 17:09:15 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:23818 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235278AbhHQVJP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 17 Aug 2021 17:09:15 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17HL1f6R009796;
        Tue, 17 Aug 2021 21:08:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=stoCyX8gYDSeqHF/VWFfjBF/UiL6BvJ9vsPWAMl5Aw0=;
 b=tmjl62A+xXx0xJlDkmYbFuGGiDJQzO5/+LQcnrsaXvpQvQkO7Xujjq3jWqT6yqoDMfE7
 byXWsVe+9pv5Qo4Iqb2ikg7b0rWlj8n4V1SYsOVm9+xIh+wlRo+WBtAFl+xj7jqD6hDW
 6uhisvxqzZJKrC+Xd0Dk8mjadcJCg0pjc8q2Ahyq/RQorqbAZN/cUjJXAT2aLMi/VEb2
 k4Urd6pTs6OYAmNQAM8wLERi3TsnOzm2N7MJ7siPmB37pmANRTMNepTG5cr8pq4AGVWU
 u6pj4q9iIe4gT6uueqltBabeC2bzdgidCKq51ClJapdn9DuAAADroWsWq4WstkophlD1 fw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=stoCyX8gYDSeqHF/VWFfjBF/UiL6BvJ9vsPWAMl5Aw0=;
 b=ozpO2wngnlSgoeuSdnbCmEDH5IqTvEVRmaxJwTc/UreqM5fJ+6F0l2/EvKqRputi81Z/
 CApMnuaqJ8GcQamhwgLGTSpPSJB3nsfHrti2OAcxho0W0F8HA+LuuuMOVEDuKWl1mnY/
 IxpvdpEot5eNZ+4RpyFS8SO7N3iY+nqOcvMOK8LQ0HEScjvXehEXEZyZZUJOK75nGeP1
 fZ1kksDwntPUHRHH9PWyAoxK3agTwZCp1jy1KyUZlGFyzo1Gg5Wzu6nGWEnF63waDZvJ
 ZfmIn4uzixa4kSRMu9GdVQ/n/ZntpZGvmjPuTVKg3SkhHgr5wxm0imUKwsTX9KlE13+i Vw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3afgmbd2fk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 21:08:29 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17HL0tFO139115;
        Tue, 17 Aug 2021 21:08:29 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
        by aserp3030.oracle.com with ESMTP id 3ae3vg92p1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 21:08:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sjp39vfXciHAV7R4Iw9maMPrAz9HkAjfkrFwAkxW/wYJF9y7VY3IrTAzPyQTDDiCk/IexBGnR/0wjy8I062kNZdOWCNou0ceypYPmw1DYo6F8AbFzmsqCaOM/JHTvk7oUobR8lxEE3cOpYpxRGeujnm+XCZwUEUwfT0BQwPEoZXtV0ZmBgJxqfwuTXjzUMUXgMC7w2pNkzdsU7zYV2dvxcL+4TgP9ODrPE/FUPoy4PNY1IIN0RhFYu734RhL+Ie3JW56uRk6kp9fejKVAXEvbLuOwu+ofkW75/JGDdJSJKEhFCU28IiFGApNqdExEXXHqLystEQZzRrjvCmrTL38CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=stoCyX8gYDSeqHF/VWFfjBF/UiL6BvJ9vsPWAMl5Aw0=;
 b=DTNpNICnh89Ftk85y7To0hSMSwWL9DEKN1fLqsUJk1QDI/IHA3K87n5SQ8f9WsDB9uGfoubwHQXqsfrgSuGvVu72D5MX+gL6eMkDwQjK7CNG9zVRy7P6fffyS7XyEqQPMmHWF5Pa2RfU1IiCCBaYZc4+iiPh/VPpycY3z+BOlkNs71tmV5eP/28APYYqXTTheg/U8huhL2WLyjls7Bquxn8TOjCCyIKZeiXxxeP2ohYEOfrGgIG6XCMKSLo7iP8C/Ocd+g9IRAxEawG5wjVOqyvsMKQhaDc11oS2c/eST/KiKJwtB6JOGmbtJlVU08bswNGk/UfveSi7o4S17b1YPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=stoCyX8gYDSeqHF/VWFfjBF/UiL6BvJ9vsPWAMl5Aw0=;
 b=IDGHvRYaa+CLeruQACKMvZfsYJQvurfD0nmZweFeO+/IPrUjYzHwO50BoEp5K0hEhJ5l33B965RTG3JW8lQeomcq2lO2ZCx8s9wSW9f4AvuoLnTL1+lbMLfDNZ1yiRGv55PRXCaV2sUYvKHnszmtynnk+g9AMpI9LgUpxN3tNag=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by SJ0PR10MB5536.namprd10.prod.outlook.com (2603:10b6:a03:3fa::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16; Tue, 17 Aug
 2021 21:08:27 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::a8db:4fc8:ded5:e64]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::a8db:4fc8:ded5:e64%5]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 21:08:27 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Timo Rothenpieler <timo@rothenpieler.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Olga Kornievskaia <aglo@umich.edu>,
        Dai Ngo <dai.ngo@oracle.com>
Subject: Re: Spurious instability with NFSoRDMA under moderate load
Thread-Topic: Spurious instability with NFSoRDMA under moderate load
Thread-Index: AQHXSnp8j8N6G2OhyUK9Nr2RtJxnoarn3hgAgAATb4CANuhZgIBOXZcAgAAVhICAADVLgIAASYeAgAAo1oCAAAOTXYAA6JWAgAADg4CAAANlAIAAA4eAgAAZh4CAABNpAIABnm2AgAgMfgA=
Date:   Tue, 17 Aug 2021 21:08:27 +0000
Message-ID: <7B44D7FD-9D0F-4A0D-ABE9-E295072D953F@oracle.com>
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
 <4caff277-8e53-3c75-70c1-8938b2a26933@rothenpieler.org>
In-Reply-To: <4caff277-8e53-3c75-70c1-8938b2a26933@rothenpieler.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: rothenpieler.org; dkim=none (message not signed)
 header.d=none;rothenpieler.org; dmarc=none action=none
 header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c71e8ead-1e1b-4af8-7436-08d961c3286c
x-ms-traffictypediagnostic: SJ0PR10MB5536:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR10MB5536ADEAB4729F36DB40F91F93FE9@SJ0PR10MB5536.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MkCBrc0UzaqglXMdErD/lYkHUBgPWN/OOVOlIaVYI036hhd4w8F/Kvw7xpT/Bg9k0JgElQFLIDoxrQ4SkchF8Z7k/ZDAYVseImiJZrRSScnxuPUpRrBHtJMZpvaRTxu+UTQfqW9yhSJMEsrlzQVsRdyUxApPB1HScPpz4TgMuO1hb/ypEFXbYKWsv+Ps/Ro6h7LhNX41dLntYxVD0DYdIcv1rsgllh0PF7P7BlQc+HcxqIW5Z6K2bBDg+9gQk4JJSL7+Tg8FeRN2Q7SvBMoGz43zOjgATfbbyH71/d1tUnfAA3TQXFr6ewj07QKXFXVkho7xo8Tid7RgKbYVwKAbwIAQxfDV8PebieHjSGkdHRxEYowAU8xd252I21ZHLrWGb50d7NWNGfwl1S26Z+g2ZRKVQ1KlbidTiYJa0CuIvVfOOrxV1T2FYxyNUQQvXSOopefPa64p7MXY0w9cE/1CRMxdqq8ZUuyR75yuQ+EsOoaPqa5ualsuZCIQXyCi9gEoNdFLpIYWRmQJ839e1TVjZeMhW4xRkxwwDV04NYy4yfDJPD+MTwd8EV9DSC1zAu2GW2Vg5SoPeAjGK6iadeRLhY9A9g12WIJMzHGCkZwW3hXYdG1DGdOflgsMfOonCyXcItV8GR1qXJ9BGQfTrr0TDDAhMpYfbBEfATpnZS9gkE2LZPp/IWmWzDiTuPw5IJL2QXLQDz6hca0CsuIBHqlsW8Tcd0iD/j0FujfbeMfV1Uk/fdUB9nw/ndX3q/Y0CAJk
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(508600001)(53546011)(38070700005)(86362001)(4326008)(122000001)(2616005)(8936002)(107886003)(71200400001)(38100700002)(6506007)(186003)(8676002)(26005)(83380400001)(66476007)(66946007)(2906002)(316002)(64756008)(66556008)(6916009)(54906003)(33656002)(76116006)(91956017)(6512007)(6486002)(66446008)(36756003)(5660300002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1d8+jrnMmEvFYBdzunuBhO/fgzrisf4Xg3blHuwGlEQcZaL3H43diTegrsCx?=
 =?us-ascii?Q?47j66fYkPvyLJO3z3+HvtgsKQX8gG522u10e0tKaXFT7SpTrGRyaAHWNmei/?=
 =?us-ascii?Q?YeCgyV1RmYJROLbeigeQ8u/UqeFx1w21RtAY+Z5SCHDjNeLk6aeeqB3txtuv?=
 =?us-ascii?Q?vTDH+Vj83DdzVWVapTsln2sBmV6zR+3DDMKotJ+pjQN65nBCuhViEUIM/xKu?=
 =?us-ascii?Q?q7vpdEQFX6A57ZiV58pBaIdEcU/vplo+lIcrvb2q+qdKDVPpjE0O3eoUeLpU?=
 =?us-ascii?Q?93dOa75W+wML8QxWz68pdtGCgFl/82M6lXeBEIMt99iwttLbfHMMRmx1Vg8i?=
 =?us-ascii?Q?8RH90Pz19LmqgYban7p5S4zaG8lc6UVUusNnRdMQ+JpYXglxaL1KRl4dnedB?=
 =?us-ascii?Q?inzy15Ti1x25G+OkTWjF2RghDsvAbY9vmiLv8L+FzUzWrxJ8dhpdLawAlsHz?=
 =?us-ascii?Q?Q+loxdw6LiIGryG3xuqRQX8ssam5HzUrqYjsawo7bzLHpF2ojSIRzmK8IM9c?=
 =?us-ascii?Q?p5bLvn0HOZmmVee9J080+ZemHDT5lS1wpG0zdtCoRlShspo/Atz08Yp3H6Fa?=
 =?us-ascii?Q?1vVPqG4B/8fDW6SY8V5wjDWkgtnKSBrRANmJhMc3haK9gAidSw+U8FdkASaX?=
 =?us-ascii?Q?x3uOr9e8mqNfm/WubMXtPAQO6UnPn0qFu+paSwmIT/LfRxGOKOGoub16J7uK?=
 =?us-ascii?Q?2OXd/jYcoct56NFGAtv6XQf5aX0mo8vJK43ENYd09oomF0VXFB2CUt67Z1uC?=
 =?us-ascii?Q?rWL+fdMVjR311ORAXB5GdwN4wu739v7q8KQ3KKaJaY2DRhkDKL789tzS+QDD?=
 =?us-ascii?Q?BdBtPZdld91Ec+tpduEvEY1uxeGfnzUVPqaunAGguK3M9iAJX8Ec9yYizeJw?=
 =?us-ascii?Q?g9A0bQfo5c8TVt+ufk/XZzzIdTl9GqDxOZZE28bjAlyyTUeH3swCpGPO8x1e?=
 =?us-ascii?Q?P/h7QNxTV9rP1xf4QO9Lre+GHlOnjY2+ulEsPxY+kJTLnN87LbgoNIPJ6PhV?=
 =?us-ascii?Q?l6lPvJ+3J2MnKl9+zFz3WXHwldh1jGoBvg2aY73j7p9oOOOVsvNxJoRtp8xq?=
 =?us-ascii?Q?M24y4pCyc333+0niMbQIxlOKw31w4zI21w6FeFzL+q8WsGd7wPk4I/zQsSGT?=
 =?us-ascii?Q?y3ivJT5RT7Palowq7uh8VrFh0JVX519IYI8CZr6HN62zK+rmXLasLb4Vzj5g?=
 =?us-ascii?Q?/35glBCWOxnfMW3PUSzKMKi6WGPRl44O8a9M63fp4U5zWCPg4Bhdm5VvBn9A?=
 =?us-ascii?Q?cjOnnN9cya0Ba+O8SqIgBnRE7xDCf+K9tXGkCUzpuzbCWIFR/ai+W9Xw2gU9?=
 =?us-ascii?Q?OdE8AUk/7hQX19FD/VM9FCAH?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CB340D0EBDDE094FAA8335B505E5ADF4@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c71e8ead-1e1b-4af8-7436-08d961c3286c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2021 21:08:27.2965
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YP4VOPAdS1ZTLvMATak3NIH6keI2W9GhQ0CZm+IcNqY0fPFF4QfCzJg1ERLik/E5hXLspib1tbV3C7vBFOYVPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5536
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10079 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108170132
X-Proofpoint-ORIG-GUID: 1anw4rfGwXtUJTrgSkjZn4zzpB5jDQya
X-Proofpoint-GUID: 1anw4rfGwXtUJTrgSkjZn4zzpB5jDQya
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Aug 12, 2021, at 2:13 PM, Timo Rothenpieler <timo@rothenpieler.org> wr=
ote:
>=20
> On 11.08.2021 19:30, Chuck Lever III wrote:
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
>> The server tries to send CB_OFFLOAD when the offloaded copy
>> completes, but finds the backchannel transport is not connected.
>> The server can't report the problem until the client sends a
>> SEQUENCE operation, but there's really no other traffic going
>> on, so it just waits.
>> The client eventually sends a singleton SEQUENCE to renew its
>> lease. The server replies with the SEQ4_STATUS_BACKCHANNEL_FAULT
>> flag set at that point. Client's recovery is to destroy that
>> session and create a new one. That appears to be successful.
>=20
> If it re-created the session and the backchannel, shouldn't that mean tha=
t after I cancel the first stuck xfs_io command, and try it again immediate=
ly (before the backchannel had a chance to timeout again) it should work?
> Cause that's explicitly not the case, once the backchannel initially time=
s out, all subsequent commands get stuck, even if the system is seeing othe=
r work on the NFS mount being done in parallel, and no matter how often I r=
e-try and how long I wait in between or with it stuck.
>=20
>> But the server doesn't send another CB_OFFLOAD to let the client
>> know the copy is complete, so the client hangs.
>> This seems to be peculiar to COPY_OFFLOAD, but I wonder if the
>> other CB operations suffer from the same "failed to retransmit
>> after the CB path is restored" issue. It might not matter for
>> some of them, but for others like CB_RECALL, that could be
>> important.

I tried reproducing this using your 'xfs_io -fc "copy_range
testfile" testfile.copy' reproducer, but couldn't.

A network capture shows that the client tries CLONE first. The
server reports that's not supported, so the client tries COPY.
The COPY works, and the reply shows that the COPY was synchro-
nous. Thus there's no need for a callback, and I'm not tripping
over backchannel misbehavior.

The export I'm using is an xfs filesystem. Did you already
report the filesystem type you're testing against? I can't
find it in the thread.

If there's a way to force an offload-style COPY, let me know.

Oh. Also I looked at what might have been pulled into the
linux-5.12.y kernel between .12 and .19, and I don't see
anything that's especially relevant to either COPY_OFFLOAD
or backchannel.

--
Chuck Lever



