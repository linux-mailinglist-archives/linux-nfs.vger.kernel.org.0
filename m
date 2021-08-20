Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7373F2E9E
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Aug 2021 17:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240972AbhHTPNG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Aug 2021 11:13:06 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:14368 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235928AbhHTPNF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Aug 2021 11:13:05 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17KFCKfK001855;
        Fri, 20 Aug 2021 15:12:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=QVC9nF3vNYdS5B6664TtzrwtymjdeGFfa7fSa45VrHA=;
 b=Ky4vgC3iAqZW4OJzg1ZnV7s7GZJ3RmWCFmqZzfmne/bADgB9lpLlKZZZWQ5q0lVvIQ8q
 Td0CpIXpNQ/+PQysMPx9T8skoF1YBkOkHmZM9U0dTwLFhobcPlp5Dizedl4of9HOuOAM
 jTh+R6W6E2iKFWJLNvPPYC0pbW1Vkxoo4WglKrDv8RQr1D48FjB3WfqxfhyBoZDPZLN2
 ld3KyGRfKChFGH6Cv2hwjb965yN7/DwawxW65/+8gg7YUzKFgZHf9vqFWjRnMMQD7AEj
 iyXWt1WtAf6fuMsiByJc+zXwSBkgelSz2y55fSb6C34Rv+ctRHs2IyIvMhIkGAN5fta7 hw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=QVC9nF3vNYdS5B6664TtzrwtymjdeGFfa7fSa45VrHA=;
 b=bDlT7K72j+c1RrohLcLcPz7WBlSRfT/QRp3u2BFMDoHYDeepVJqOTxCIuD6W5Dlj6mC3
 3f9RDZBelBe1ymLwUYBko0B744W20WRt8JFVwok26bA04XfDrOFS5xMrp5NQJ7TKJ9Vg
 zVPVeyXr+FQfcSxPco2yxOU3BrZryOr/VmBkgYRvB00nVaL6pXk8BbbdbfOcgGhXvsmn
 e1Q0U1fkWHp2w/gmA5RHiuZkGk4ahOjc3/gpRDnEDY7rtO0oh65fe7wKw16afvrORnYS
 mjlksBdnCW3tbmRgHDcONXg0eZkqMvA2aTdPZXMCtbxQTMFr7OfnE6s7B7siKXtdOvKc Uw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3aje2684a1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Aug 2021 15:12:19 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17KFB5Jo007708;
        Fri, 20 Aug 2021 15:12:07 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by aserp3020.oracle.com with ESMTP id 3ae5ndrnm4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Aug 2021 15:12:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bCTro9UYa6xBeuIhGaDMb/aapGmAi8At3nDqS6qyTxOUHbXBrPoPtu5BcWj2AH/JRo9CrP7/MZYHc138kqC8tAo2EpYfnEv1i1uC4L1VT4caw8fkbE2Z2tunXgLam3/Hk+q0OeY6jx0E/sByTPZXnhb26r3nMksTC18A5XsUalf8qWH1fHM4mPaOc9CrUD5sKRRWJn4kfK6PNWXg+sQBEJUmvnfSnhEGolSLcstKHj+onFt9GEY7CKR+HAvNJ4PJImaBYAwnPjRC9ySe+WE8FLm8Pkbw7fanWVkg5c58T1Trjw/0yW16HT+1zzdA3KCWrG78wOvf+nly2tC/LmV3mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QVC9nF3vNYdS5B6664TtzrwtymjdeGFfa7fSa45VrHA=;
 b=gGBcTjz4ElSxThDlX4hfNm1d41VUxpH9BlvNIhOZ/ncpKHP7DuUF1Ojdd6pXnntCNilCYfbcWtxChTtQNzaCtiRN+/RQQHQSyKunUUUKd3xwfiQtiB0XvFYMwiVUU+nllb++e1nMnObud2J3/EoNbryTBrdXDpjm69f/w9Zs5cAsYgimTcUBCScIv4iC/aY2fiasbP0AjgXqgvwTPH/tfluRyUd4Y6obBIVk8RmVZQaUv9FG6Iz8HK1P9v4DtEuvK2mCF4elqPzY8fNrD7zmxpnwXwaLXTIA+1oJ5T43zF1cWmvuegGZyxdpw2gBcvsJOKu+w6uwpvZ/PMvjpnaUUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QVC9nF3vNYdS5B6664TtzrwtymjdeGFfa7fSa45VrHA=;
 b=m1/aeq3cmwYy1fRoerfjLEG0NyUIm9qjA/1+BBg3Ak2wlhBfZuWwxUCzA51o8qUGry2yiIEQE07lxh6UjdqixWB0JsI3neyNe/NonXuQLIsSVRp1tbKT8YGjE6jO6o1XmTuJT5LzWjjDtTAHCHP41ZH0fldr7lpcpDMFcd0GFts=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB3413.namprd10.prod.outlook.com (2603:10b6:a03:150::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.18; Fri, 20 Aug
 2021 15:12:05 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::a8db:4fc8:ded5:e64]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::a8db:4fc8:ded5:e64%7]) with mapi id 15.20.4436.019; Fri, 20 Aug 2021
 15:12:05 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Timo Rothenpieler <timo@rothenpieler.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Olga Kornievskaia <aglo@umich.edu>,
        Dai Ngo <dai.ngo@oracle.com>
Subject: Re: Spurious instability with NFSoRDMA under moderate load
Thread-Topic: Spurious instability with NFSoRDMA under moderate load
Thread-Index: AQHXSnp8j8N6G2OhyUK9Nr2RtJxnoarn3hgAgAATb4CANuhZgIBOXZcAgAAVhICAADVLgIAASYeAgAAo1oCAAAOTXYAA6JWAgAADg4CAAANlAIAAA4eAgAAZh4CAABNpAIABnm2AgAX5FgCABmbVAA==
Date:   Fri, 20 Aug 2021 15:12:04 +0000
Message-ID: <D55A1FA5-71D4-4D37-9B88-E1733BEDBE47@oracle.com>
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
 <716B2A38-9705-41D7-969B-665EF90156C7@oracle.com>
In-Reply-To: <716B2A38-9705-41D7-969B-665EF90156C7@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: rothenpieler.org; dkim=none (message not signed)
 header.d=none;rothenpieler.org; dmarc=none action=none
 header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1cacc97c-b6ab-4c3d-3dfd-08d963ecdec0
x-ms-traffictypediagnostic: BYAPR10MB3413:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR10MB341394673B2358197766AD6A93C19@BYAPR10MB3413.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Tq/dvoO4HU2TTKZ9NJJZ9NibMLkjRhGJyouDsUqo61IswbT4UVm01dIFUCIhFZ44yw+iB0m/glKFS1zlJ2SZkzZiRMcUjWYL09Js2BWZj7afB8LFqppgXYcckIwYg8zqZDnC8tEV1DTIS2t+vidQWFKQ78c6Caf9grFrzkALSbGjKULh26wFRj1pvJk/zkEeZEUX+1sgY7pO0KPRWeC5vHJdU21/ZNPkZ7u9ltscliMczZow9XQtt2J+uuz2ARuXxV4SdwRMDA0iCBhr58hlRcH1QYKtMlp2jsLvy5Mt7ZgcnZ2pSdhIaGehrnVoEdm1mhBYyeLkC/yBZ0li77oVx7hedDsfhvqVlk5nkSkBSsC9RL/0I+rSGReuzxpL5yzc/tq4byJYtQVetu4XmJYOG8c6LW+a2yg2XcGEd+GMqG9x2Lb2qoJxHo074lvz1D3L3OVVaydfkrz3elGlUKXyitnvh3veyMipCgI6JPdFEaqOF4AL7k1KOGSp2KQ3wXW/CdO+El4tS0oMgGcuIViooa6DK/dK5cHqUT2INTPY2uOWqZv2hLDO5oxLOtuSsnlQcWbzgMp30kCAjluY1ZnKV5aEQz1TocjOvtyFTZmgF7K0OspkU7iSnuq88ng/K1n3KoKa3DWXgg6ErHrNFWPQkvnH37IH5sR7AaII8BwtOAUift6owuUOHC7l+KT95Nm0F3Jrer6E2wSz7jtO0Oz7/ku+c2tJeoYdmIwnZFYsnO186VVS+awj3GLz7SGDI/tj
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(366004)(346002)(396003)(376002)(136003)(122000001)(53546011)(6506007)(66946007)(316002)(86362001)(6916009)(8676002)(76116006)(186003)(36756003)(54906003)(4326008)(6512007)(6486002)(5660300002)(8936002)(26005)(478600001)(66446008)(38100700002)(83380400001)(2906002)(71200400001)(107886003)(38070700005)(33656002)(64756008)(66476007)(91956017)(66556008)(66574015)(2616005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XDWkDY3hlhHWufBZQqp6Nk28EDbjyE9b20bU/3hLf0N3XSdbxv9j7t/iRnqo?=
 =?us-ascii?Q?Oj0+jUw8su8gjzk++NS7/EsJfRzN+hDyutVcZd0sOTpbaJcaHhifVhEcOzJ/?=
 =?us-ascii?Q?Sn8d17204J1GmjqVOkVKcv3tXpUWku+SeNI7Lc8m2wBpvcHWL/U09wiSsYA6?=
 =?us-ascii?Q?ZkXssVUghCGgtVYsFEgSkivaZj8Ra1SX4SwF5Dy4Dh2NmSrVjL+jrrYPAnsK?=
 =?us-ascii?Q?4BNTq5nulGOiIuA/o5+sGW+dlg5CK4uIRMRCSINkLqUFeAz/cGZb/H5V5QGd?=
 =?us-ascii?Q?eSBKXMYJurEWs5hy8NgwjJss2kTK8RPH/TJkEnZM6kmB+KLgSIv9BA7h+W8d?=
 =?us-ascii?Q?GGdkEbvtc/vV/ZwHQmhDnS6VZ/n4F5sGkb/1op3VXvJmic7RMLazatgLuh6s?=
 =?us-ascii?Q?KMVgSBY0obPWVU8ST9mrp9aNtm5r388ufbDD18XcxKo4KqysHy5XbKoYNvni?=
 =?us-ascii?Q?Zn1ivQFlMozbTgpsbFRa1qT8Q/b1dCAqDSrKC+qCWfNJ6yG4+avaU3yWybeb?=
 =?us-ascii?Q?+ZwxEZVeG4zvPq2fenM3BJ0kWJ31IdHrKRHUCZ7PiOlefr1UfvhvmjsyKkDI?=
 =?us-ascii?Q?URjzGJ6ix71q0PpvjH1MgTbs9zqxylB9v6SxVaDqwpyF/Cu7XbNLhj7owRQB?=
 =?us-ascii?Q?0GO3RFIyRqbfZIVGBFkCAfM0HhCYcUYX4jn4qH7Yt4x+4rJDqzfB3CT7qbQ5?=
 =?us-ascii?Q?8tLFX1zdkKjs1D756IQvLsnWM9Xe7/vrL5Wn4c3qgqD0NyKauFo3iJ/xllzm?=
 =?us-ascii?Q?81ng2wqmoCA5dEVKzeBUf4QYBWSwROln3obqvfzkSOmyRatCBc1EtxUUrHYW?=
 =?us-ascii?Q?scXZMgxQOPAv6NjyLYJjKQAfsd13rWaKLw4RFavNfzTJRqJcDu8ckaiW+NRr?=
 =?us-ascii?Q?PPnvpbd4BaZIO/34L/6n9Pxn5YG7HGMJCvs4a9NypKAo8/xTePcvK3lllLW/?=
 =?us-ascii?Q?SVEqshDq98bLL7AMllxjPAuPPj+degBmSKTZfQIh908l/MPp3O3ozwf6MOWx?=
 =?us-ascii?Q?bO4RCRbuvZBtB+IIvIP2G6W61IoNVgGs+p+ro383NP0D6mOT9qbzukScWylY?=
 =?us-ascii?Q?ljsl4xk2wfhg+nC8sXlaSBNsjs1L/z5UQREs/vRpjPnzHhounzAxN6jjrkl4?=
 =?us-ascii?Q?ng6Ai7wddR2kZmKj7UMWrV/Ds4rt/5AgH8BMAnPYIM+TKQVdemGnBBtecDF/?=
 =?us-ascii?Q?nXg5CGyNjc2RGKAV2Usg1zzmgcgk7YYK2pILW+la3ooNT2popzbHXnNhc9N5?=
 =?us-ascii?Q?rRptnXkdav5KyafmMFaGKvtt4VEuRehk5SWvc5jjC4WeZ+a8JCRFAvZtmly8?=
 =?us-ascii?Q?ksYc3iIAQ9t3SG8Sz1+aJPBx?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <36B47CF77DCB1649AA0B978397DCBFF7@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cacc97c-b6ab-4c3d-3dfd-08d963ecdec0
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2021 15:12:04.9033
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: baZyAn2omDcbDqD2oMYK63uz/st4o1M87gMwREsUUpl/4Khm42BaSNGQ6ZUMNd/TqLiHB/PMEmeGXNcjFiAHYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3413
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10082 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108200086
X-Proofpoint-ORIG-GUID: rVQpJ6Oo78nUzy_R5T4AKHWgyupwD7-C
X-Proofpoint-GUID: rVQpJ6Oo78nUzy_R5T4AKHWgyupwD7-C
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


> On Aug 16, 2021, at 9:26 AM, Chuck Lever III <chuck.lever@oracle.com> wro=
te:
>=20
>> On Aug 12, 2021, at 2:13 PM, Timo Rothenpieler <timo@rothenpieler.org> w=
rote:
>>=20
>> On 11.08.2021 19:30, Chuck Lever III wrote:
>>>> On Aug 11, 2021, at 12:20 PM, Timo Rothenpieler <timo@rothenpieler.org=
> wrote:
>>>>=20
>>>> resulting dmesg and trace logs of both client and server are attached.
>>>>=20
>>>> Test procedure:
>>>>=20
>>>> - start tracing on client and server
>>>> - mount NFS on client
>>>> - immediately run 'xfs_io -fc "copy_range testfile" testfile.copy' (wh=
ich succeeds)
>>>> - wait 10~15 minutes for the backchannel to time out (still running 5.=
12.19 with the fix for that reverted)
>>>> - run xfs_io command again, getting stuck now
>>>> - let it sit there stuck for a minute, then cancel it
>>>> - run the command again
>>>> - while it's still stuck, finished recording the logs and traces
>>> The server tries to send CB_OFFLOAD when the offloaded copy
>>> completes, but finds the backchannel transport is not connected.
>>> The server can't report the problem until the client sends a
>>> SEQUENCE operation, but there's really no other traffic going
>>> on, so it just waits.
>>> The client eventually sends a singleton SEQUENCE to renew its
>>> lease. The server replies with the SEQ4_STATUS_BACKCHANNEL_FAULT
>>> flag set at that point. Client's recovery is to destroy that
>>> session and create a new one. That appears to be successful.
>>=20
>> If it re-created the session and the backchannel, shouldn't that mean th=
at after I cancel the first stuck xfs_io command, and try it again immediat=
ely (before the backchannel had a chance to timeout again) it should work?
>=20
> I would guess that yes, subsequent COPY_OFFLOAD requests
> should work unless the backchannel has already timed out
> again.
>=20
> I was about to use your reproducer myself, but a storm
> came through on Thursday and knocked out my power and
> internet. I'm still waiting for restoration.
>=20
> Once power is restored I can chase this a little more
> efficiently in my lab.

OK, I think the issue with this reproducer was resolved
completely with 6820bf77864d.

I went back and reviewed the traces from when the client got
stuck after a long uptime. This looks very different from
what we're seeing with 6820bf77864d. It involves CB_PATH_DOWN
and BIND_CONN_TO_SESSION, which is a different scenario. Long
story short, I don't think we're getting any more value by
leaving 6820bf77864d reverted.

Can you re-apply that commit on your server, and then when
the client hangs again, please capture with:

# trace-cmd record -e nfsd -e sunrpc -e rpcrdma

I'd like to see why the client's BIND_CONN_TO_SESSION fails
to repair the backchannel session.

--
Chuck Lever



