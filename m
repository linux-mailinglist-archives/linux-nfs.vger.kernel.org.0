Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD135709B5
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Jul 2022 20:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbiGKSGh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 11 Jul 2022 14:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbiGKSGg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 11 Jul 2022 14:06:36 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332A328E2F
        for <linux-nfs@vger.kernel.org>; Mon, 11 Jul 2022 11:06:35 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26BG6J2H019621
        for <linux-nfs@vger.kernel.org>; Mon, 11 Jul 2022 18:06:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Bn+++S4LcK0U8wPqTCk0Lp6t8okiSjdAgVwGm4oUgNY=;
 b=NP/rvrdIkc+3QoDk22Wia0KmSui/kabUxDTgALhakdZy5NRbjLnIXDiNlTFOMp7VSZ+w
 lFZsFqgRVShAE9il/61JBfJkRw478FnXkIWwRqQkvA3QVlQX1sEu8rF8WIWLsrJF8Muf
 EIsLtIpYufDAlpE4QtKczbqVlbxz7PH85QGMroP4N2TA68MsAQaquSvXf8sqeOrCPJfm
 WdLmKWFFcZMe1EN6nJhlpWIqWc3kS1wFZAkNBd2ynb3peyE31zwXz9xSuDvXxlyrdob/
 l0N+6qMjqijUPD8/dVHjV36BwthTtUZyt1l9Cl72xX9lFqvF8q5x56+s+MpDGeivYeEW WQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71rfv9x6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Mon, 11 Jul 2022 18:06:34 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26BI1kXn009589
        for <linux-nfs@vger.kernel.org>; Mon, 11 Jul 2022 18:06:34 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h7042gv4t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Mon, 11 Jul 2022 18:06:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ug7/Cl2YB7GJKIl2sQ+14Uj4GXZqFCgrsM8ksQ6p7lrLSl7mfQJpcRjIF8GaSBOyoIqVRThsYcTBUAzDWwnQFVQwH5UeW9M7+QVIx49SOuWkO/3D+D5rOnYLmXw+zM5VqNzu5xHRArIV2i8hmBWP45wADpU5Ot8MSFN+Gd0vv43spPwcYo3XgAk4t30/MzQyS7vRmz68GCaoqWQF96tMk8QFp2mmjQzMhJIzxfkbxJfble9GBLSMYnT5JlNVlStSsgw3BCdlLU8XaUD9pxDNDxzkXQOnsHXwsGl6tHUEnC/HpZO/wTpjjyVcaUYbwSPj5TFeWBPnvCYyFbClB9NrSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bn+++S4LcK0U8wPqTCk0Lp6t8okiSjdAgVwGm4oUgNY=;
 b=X/nRTvQTuiOt+IDUzbrudRCnnLKpty1J6QXi0hdIjUCFB5D/4wesa9A9XXqiOoZTtm9oXGjqPNgYs0/K9Wi2To8jng4yrzbeHwnrD8XNCMOTx/5/lUGTk1xLqZ8fxQSbGiWkzxGIkMrDm+4SXs/PoWENIt6K3O9hfwhNAwx8r3CMeINsDoY/4KWu7YNnnH2oZi52s0S4P4m2UGhFVFFQZ/+8oJzk7CexxP4JhyQG5JZ7Sc+pwsXM6fvvAu1RbFtSI7SZgAL7pje02qY6rNyOOODrNncnRqIkakO/PQRmtffOYBuBCAF0OYslen/WOieJpzqXNHdVqwn6iXT+GOCP/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bn+++S4LcK0U8wPqTCk0Lp6t8okiSjdAgVwGm4oUgNY=;
 b=AyTOYG6e3xoGqw/GHdNmCdmw8qZgWGffO4cM14lPGFZiSce03FAZN5R8kHBY+bfb+Ha3LKnGsEqP1ywO68LrvzLSU+LkBu5DriuqdY2eTd40KymdEmrajYxStH8zTCu7u9IScSaC0gt+iWz4KN3/vA892JR/M0XfoA5O33TCtQw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM5PR10MB1786.namprd10.prod.outlook.com (2603:10b6:4:e::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.16; Mon, 11 Jul 2022 18:06:32 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703%7]) with mapi id 15.20.5417.026; Mon, 11 Jul 2022
 18:06:32 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Rick Macklem <rmacklem@uoguelph.ca>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: NFSv4.1/4.2 server returns same sessionid after
 DestroySession/CreateSession
Thread-Topic: NFSv4.1/4.2 server returns same sessionid after
 DestroySession/CreateSession
Thread-Index: AQHYlKIG8hnDNDQzXUuZ/p7iJwgH2615RPsAgAAqTQCAAAlZgA==
Date:   Mon, 11 Jul 2022 18:06:31 +0000
Message-ID: <24C858F4-5334-4417-BFA5-4D580274F47E@oracle.com>
References: <YQBPR0101MB97421B80206B30FC32170C25DD849@YQBPR0101MB9742.CANPRD01.PROD.OUTLOOK.COM>
 <DCE64EDD-FCE4-4C21-8B00-7833D5EB4EB2@oracle.com>
 <89044942-DAFE-4E9B-BC70-A8D2C847A422@oracle.com>
In-Reply-To: <89044942-DAFE-4E9B-BC70-A8D2C847A422@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 16b5828d-28b1-4510-89d5-08da636815d6
x-ms-traffictypediagnostic: DM5PR10MB1786:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n7sq99yO6Zdfk8EclX2IOeXwXdPUhtdTQp08hqh1QMkQmtFaCrmjKZxw1Y0KIXQjuScFiLQUIfYEFmsh4NNGgQCSYQQzGy1RxOYHVWsp7mBFAk3VlJeHTbdcDQHTyt+t4aNqJm40OX2cUJTjJZDM/pYoUcF9C7wxm1NDj8QCTvB28yRspjJmsEIVxgnQIQS0tsnWv4B5I12w43fzarsTVv7R7Wm9tWao8+llZYvD9ItBxkZZ5NoK8vKFU02GBeLormWDMzNjktZiinfm/utY4c+j7mxexIe3ezdqEbo8nxnq5ztiFrVT/MFPQ/lDKLzgRILQG8kOKwGmFOz3M1p5r+Ni77uoNJZ/V0CBAGO9W7k0ePt1WGJbVMJ4eH2TQWp/j72EFyhvvUu7ZOets4uNCW6Zpl+uF/LFuA7RzGi1BFCq065m1hSpZY1xIRR26KvUu/yAFNsa2pbXuqDtWSZdMeKlvpolBZ5VWYtmlTcO5ZZ4UTmnS4qdKghT4d3ypthc1bVZ7qR1FrlNA6VFsVApLhpgGBr9hIeGvLCpVakdy9Z4kT2ZQsfuLBIcIF8hCUvzqYb3UxipuaU/uDyG5l2xwvm83do6NxfJqqIFW8O+Op/iJOPUxwx93fP9dg7ANuKcxF6105Ek0CpeA1bdA2zDHZvWk5klH5A35ilrOPvFtCy3J5jZPAEIe9vyC7ajLlUGdmKvjcpXKllnQ4U59ptJBxdbXAAGpHWF0d8HAxIidv6CNJJyE5ReoaNgab8MQSQNvv4ryYIvjnM6Kad8A+yxfX02RuPD0lQwBKmA65pfQCGPtXWBG+RauD+Shj8XYL10DWlXEWS8LkRBhGDdFs+M96lTSdMZ0cRPAg+zmBj9b2uERUtbwQ12zXo+FIrxINhO
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(396003)(366004)(346002)(136003)(39860400002)(86362001)(53546011)(33656002)(38070700005)(5660300002)(6512007)(26005)(122000001)(71200400001)(2906002)(6506007)(316002)(478600001)(8936002)(186003)(6486002)(38100700002)(66476007)(41300700001)(83380400001)(64756008)(66556008)(4326008)(6862004)(8676002)(2616005)(36756003)(76116006)(66946007)(966005)(66446008)(91956017)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rKYYyn2PS8ZOPXjvoKQCyu8qnMYt+MGwME6AJdvo7jed2mwpaht70ttxlwd8?=
 =?us-ascii?Q?QUpnWTzfb7T3F3cL2Ak/TsvFI5M0gk5a5USQyB8kXQlPQ/7ik9fmGaidyTMW?=
 =?us-ascii?Q?Nr6Fyvlc1cDtWhKTrp8aqurIfKxtW53+msOFD+GvHemppje26fYH3GwDq2xP?=
 =?us-ascii?Q?/a+hpI2hvq2Sv8srVLIWeP4rqHktw20K4awDzNfh1bt2GSKMPPBMriIYpGg7?=
 =?us-ascii?Q?BkO1j/30H7Ndig6zzVq3TPr6ayGeV+jI9Of8imU9wc19DwLE79DSqMd9YfhA?=
 =?us-ascii?Q?7aCHtRWe6FvFu+QZfPvyXD7dJVuC9zOS/iSXNiFDKvTJzkMpWpqMxfKugXPV?=
 =?us-ascii?Q?4TuBsJKBAw81HDGElkRUxMXAVm9pzdtJAazv99SSpRjRB+01ftF+SqCEeViZ?=
 =?us-ascii?Q?JYXF4TPacdr0ip6CcO478ggxqZW4IYPFQMVGMknqL1XxNM0iE31POaAfn1/x?=
 =?us-ascii?Q?+nrLxeybT4TXZsWb3CdQfa8NBlsathh6L7Ov+ZQavIytaAjjmEF1tA5Oi9+a?=
 =?us-ascii?Q?nbQbN1JMGTpX+ur2+MFcIgmYoFTrt5yKm9jRKeHhq/C7eRzw4yiKGlRL1yf2?=
 =?us-ascii?Q?3O/GyaodN0B0TC2Q8A90ATE7peplQl2FPKf/q9H6IuAjqTUJTJuJCt+KrUDW?=
 =?us-ascii?Q?JuDeVy0TjQeXKBuoJyUwN0/8g1e7KP6p7/XRVIFKunuhkTToIOyapQtn4058?=
 =?us-ascii?Q?sCiCpuSBXOqsKMg72qFTTQU3aJoUhV2pd6AFvdWaM+o2MD2JH2WB+HGB5ZJA?=
 =?us-ascii?Q?h13t4642hLbb2JbPwCrSu0U6gC7Uv8tt6gevionNMBCI+Q6F0b7WGb/WIlNc?=
 =?us-ascii?Q?FFAa1AcuCUAL8XHb2UCQ78SYUhw+FFBMizqW8FkTvq1N3f9ZzmjYelDYBjvw?=
 =?us-ascii?Q?jJony8nc1NSgPeVpnLwAFKfA0s4PXV553qkL3/2pbjX/JRarVdCVeI09NQIw?=
 =?us-ascii?Q?li5y4aOo0stAJAsCQtK0xsNAt7OhjMpw2lRXBwEMn/lGYoTeB26YtvgDMQ+/?=
 =?us-ascii?Q?J9GesWLiFRHGwEHzPjurbS1boQB8ji6UxlL0Ua800wNlGfvo8Bw1sSZocmQ/?=
 =?us-ascii?Q?dhYL1Lp/dC0zPWieBBkQBypMWdN0zmlrS0w9m3yoURonJmn3xKc75uLwOyJV?=
 =?us-ascii?Q?87IL9gz6ImDFi6x9LzHLabhKfpS/zj1dj2WWpEUmaBnor/gveo58TNtHA/Mg?=
 =?us-ascii?Q?zGZmFReNqYI2pT2MyKDLOSVaQuxdaW4+/u62HrFrsTzEHku0g7Kx+mcs7fXD?=
 =?us-ascii?Q?QCQQpNDEnd3sgPnprfSwSl30nSrfL8CBrA+uZz+QHoJZj08IWAIlFRZc1ea5?=
 =?us-ascii?Q?0qoqgk5maRMRvPxD6HIMPvctfub5iXZh9FoSwLCRgbMqvJAnwRJr9OyIzS2X?=
 =?us-ascii?Q?Zy6xxjYJYeZnrNB54GYvrH6Ne72UwjezSSQSjVq0yz0+wZrNsKh4fOrNl7ej?=
 =?us-ascii?Q?v0h4mWCnGUr/8CJpOWAbIftcYd0MMKtyEC0W8pnwbZ03TBzElmozdEqE8CMs?=
 =?us-ascii?Q?ZrU1VWqjqaSahBl/N+U8W7Y6jOR+0P0GQ5Bnarf0avTQVndkflVoXCPxUC9T?=
 =?us-ascii?Q?8PFr5yAHV97bm2ysdxoavczWAZSFeis8+jTsVI0ZVxCY9wzbKM/6BAurUVLU?=
 =?us-ascii?Q?mg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C2D1262C0324F3408C3E0144B20DBA63@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16b5828d-28b1-4510-89d5-08da636815d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2022 18:06:31.9851
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aDJ68ys29c+GmrJRZAgJl5iS6+cIafQ84Ow4yREAxdtry3b5mAFle/TPRmza2wxSlUmA33ZBn+OTBWI+IIXS3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1786
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-11_23:2022-07-08,2022-07-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207110077
X-Proofpoint-GUID: _EgRJWJbTtciIBi68B_8zlmoz_edZAKu
X-Proofpoint-ORIG-GUID: _EgRJWJbTtciIBi68B_8zlmoz_edZAKu
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 11, 2022, at 1:33 PM, Chuck Lever III <chuck.lever@oracle.com> wro=
te:
>=20
>=20
>=20
>> On Jul 11, 2022, at 11:01 AM, Chuck Lever III <chuck.lever@oracle.com> w=
rote:
>>=20
>>=20
>>=20
>>> On Jul 10, 2022, at 6:10 PM, Rick Macklem <rmacklem@uoguelph.ca> wrote:
>>>=20
>>> Hi,
>>>=20
>>> I have been trying to improve the behaviour of the FreeBSD
>>> NFSv4.1/4.2 client when using the "intr" mount option.
>>>=20
>>> I have come up with the following scheme:
>>> - When RPCs are interrupted, mark the session slot as potentially bad.
>>> - When all session slots are marked potentially bad, do a
>>> DestroySession (only op in RPC) to destroy the session.
>>> - When the server replies NFS4ERR_BAD_SESSION,
>>> do a CreateSession (only op in RPC) to acquire a new session and
>>> continue on.
>>>=20
>>> When testing against a Linux 5.15 server, the CreateSession
>>> succeeds, but returns the same sessionid as the old session.
>>> Then all subsequent RPCs get the NFS4ERR_BAD_SESSION reply.
>>> (The client repeatedly does CreateSession RPCs that reply NFS_OK,
>>> but always with the same sessionid as the destroyed one.)
>>>=20
>>> Here's what I see in the packet trace:
>>> (everything works normally until all session slots are marked
>>> potentially bad at packet# 14216)
>>> packet# RPC
>>> 14216 DestroySession request for sessionid 2725cb62002ed418040...0
>>> 14302 DestroySession reply NFS_OK
>>> 14304 Getattr request (using above sessionid)
>>> 14305 Getattr reply NFS4ERR_BAD_SESSION
>>> 14306 CreateSession request
>>> *** Now here is where I see a problem...
>>> 14307 CreateSession reply NFS_OK with sessionid=20
>>> 2725cb62002ed418040...0 (same as above)
>>> 14308 Getattr request (using above sessionid)
>>> 14309 Getattr reply NFS4ERR_BAD_SESSION
>>> - and then this just repeats...
>>> The whole packet trace can be found here, in case you are interested:
>>> https://people.freebsd.org/~rmacklem/linux.pcap
>>>=20
>>> It seems to me that a successful CreateSession should always return
>>> a new unique sessionid?
>>=20
>> Hi Rick, thanks for the bug report.
>>=20
>> CREATE_SESSION has a built-in reply cache to thwart replay attacks.
>> It can legitimately return the same sessionid as a previous request.
>> Granted, DESTROY_SESSION is supposed to wipe that reply cache...
>>=20
>> I'd like to see if there's a test in pynfs that replicates or is close
>> to the series of operations in your trace so that I can reproduce on
>> my lab systems and watch it fail up close.
>=20
> I constructed a pynfs test that does something similar to your
> reproducer:
>=20
> diff --git a/nfs4.1/server41tests/st_destroy_session.py b/nfs4.1/server41=
tests/st_destroy_session.py
> index b8be62582366..014330e7d623 100644
> --- a/nfs4.1/server41tests/st_destroy_session.py
> +++ b/nfs4.1/server41tests/st_destroy_session.py
> @@ -1,12 +1,33 @@
> from .st_create_session import create_session
> from xdrdef.nfs4_const import *
> -from .environment import check, fail, create_file, open_file
> +from .environment import check, fail, create_file, open_file, close_file
> from xdrdef.nfs4_type import open_owner4, openflag4, createhow4, open_cla=
im4
> import nfs_ops
> op =3D nfs_ops.NFS4ops()
> import threading
> import rpc.rpc as rpc
>=20
> +def testDestroyBasic(t, env):
> + """Ensure operations outside a session fail with BADSESSION
> +
> + FLAGS: destroy_session all
> + CODE: DSESS1
> + """
> + c =3D env.c1.new_client(env.testname(t))
> + sess1 =3D c.create_session()
> + sess1.compound([op.reclaim_complete(FALSE)])
> + res =3D c.c.compound([op.destroy_session(sess1.sessionid)])
> + res =3D create_file(sess1, env.testname(t),
> + access=3DOPEN4_SHARE_ACCESS_READ)
> + check(res, NFS4ERR_BADSESSION)
> + sess2 =3D c.create_session()
> + res =3D create_file(sess2, env.testname(t),
> + access=3DOPEN4_SHARE_ACCESS_READ)
> + check(res)
> + fh =3D res.resarray[-1].object
> + open_stateid =3D res.resarray[-2].stateid
> + close_file(sess2, fh, stateid=3Dopen_stateid)
> +
> def testDestroy(t, env):
> """
> - create a session
>=20
> I'm not able to reproduce the problem on 5.19-rc5, but that
> probably means there's something going on that we haven't
> discovered yet.

My guess is that your client is sending CREATE_SESSION operations
with the same sequence ID (1) and that is hitting in NFSD's
CREATE_SESSION reply cache. So it's treating the client's new
requests as replays and returning an old (stale) sessionid.


--
Chuck Lever



