Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 754CE4ACD6A
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Feb 2022 02:08:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233865AbiBHBGS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 7 Feb 2022 20:06:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239540AbiBGX7L (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 7 Feb 2022 18:59:11 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 970BBC061355
        for <linux-nfs@vger.kernel.org>; Mon,  7 Feb 2022 15:59:09 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 217MKPW8011771;
        Mon, 7 Feb 2022 23:59:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=ZwJI8fdm5j8tQGJriFUOnFyvO1AXL/fBEwn8GGcIYmw=;
 b=pVtXK8p1Kd3ZlkZ/fvQHoLHbqWu6noZAa6RlpvRoMOcG+T7TZ1XV+/Ra0C2fW0qk8YP+
 Y4OuD5lDRsF9HIFWYU7hxF2yJZDiASsjZbq6XVWx0A2BETZAythzbX7KfEyl2r6AJGbJ
 Z2vPB8wqzkm/cststpLwzLqoTiWmrOmO64OQ6w8PP1wpH8qQtwsyC988PA1UUf9gK/HL
 XhEZqUGtIKbTNgSBUh/WlxM12UoqGfmpumrxQZjzUf8iDjHMdDxx3T9QsPhpbtG1oKLz
 ZWDEwaHnyfbEtiOMUCLlpikqk0/9EAx0b+pPVgTiJYt4JCGwjGBToGLjBowriNKrm2hM Qw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e345shp46-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Feb 2022 23:59:06 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 217NtVAT050874;
        Mon, 7 Feb 2022 23:59:05 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by aserp3020.oracle.com with ESMTP id 3e1h254exq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Feb 2022 23:59:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d6LAYPCDyLp8JxGHr9mhJ9SkoE6a3NYPKK4HUQstbc7XMQzj+AWx0+YQgIhok/BizaRJzjHUA/qgGgzsW6FsvrQLm0ZgtUwhS7yc1nMx7u2+g1C+fZGrnP4zcaqUcb6ccMualdaOsGc29VKDeAJMuCv+JX/EjCBhv6iXaiwCf+xFxh0dtcCxgw4bwOlxoRc/aQMuGHZj13IGysUygU89ya13+O1GiD8Uye8/JTiSDyZ/XqN9ZG5zGThCJpLLkvDkMuhOdq/jgL++i3Lr1D9zLz8xBP/9nwr1NFRIHE34Pji+9uFx6a69Y3LsokNR4Xgz72tSMrvrXuVa6nJ+v8SJng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZwJI8fdm5j8tQGJriFUOnFyvO1AXL/fBEwn8GGcIYmw=;
 b=eSOe50Fx5Y8AsUAvZsQJIT8X7y7uKzHiEowm81vZGC+TPfrgMw4oojq6aHgAlhOjWAvoL0x/hFRPiqU4Nz2WSRDTMCxTo4w6hYp41yqTbUMu7j1SI9hRTmRh6WRhKsx3CRxEABakOxOnCWvUWXrHL25Glr1xex8oPgrdfC/9JATVWev/2k9ZKFr0t2auNF557X9uKDRYafC45LQ7DEECYKq8o6FKb4+v+1f74aCqepSMXEpYuYbgKKdiCQr9AYswP6aAlx0YMAGU40xvbGY1orOpXQyO8o1KZ1FuiVHXxJsh1Ao6ncEWtI0dak0otIoAzagrT5FaHZQHlcVr3IfDtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZwJI8fdm5j8tQGJriFUOnFyvO1AXL/fBEwn8GGcIYmw=;
 b=mI3PDnOkvf+LnwnIkCx3H0Axc4AfB6JVkOYpzsZ6pAIgkvXLmG/UclnxV3qAyd44iUNAWL3j0mi6LZk1h77/LhpcUWtcnchWkNUh5Mrpr/W6rmnbOh0Pns+NlLE30ucp/LDqCjUdv/Je4qKmNtpEUAVy/l0W1/gzH+BQSDxRSOE=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by DS7PR10MB5375.namprd10.prod.outlook.com (2603:10b6:5:3ab::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Mon, 7 Feb
 2022 23:59:04 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::c8a5:6173:74d9:314d]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::c8a5:6173:74d9:314d%3]) with mapi id 15.20.4951.018; Mon, 7 Feb 2022
 23:59:03 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     "bcodding@redhat.com" <bcodding@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: v4 clientid uniquifiers in containers/namespaces
Thread-Topic: v4 clientid uniquifiers in containers/namespaces
Thread-Index: AQHYGqGbn3llxfcWCk+UU34Bdwb7RKyFReOAgAAYOYCAAsQQAIAAHReAgABAAoCAAEjVgA==
Date:   Mon, 7 Feb 2022 23:59:03 +0000
Message-ID: <43990B9C-013C-4E77-AADA-F274ACBE4757@oracle.com>
References: <6CEC5101-0512-4082-81F8-BDFEC5B6DF3A@redhat.com>
 <6ac83db82e838d9d4e1ac10cb13e43c5c12b2660.camel@hammerspace.com>
 <439C77F9-D5AD-4388-B954-3B413C1DF0E2@redhat.com>
 <596C2475-76AA-4616-919C-9C22B6658CA7@redhat.com>
 <DB8B60C8-B772-4604-A841-47F789723D5D@oracle.com>
 <b192022ce73ea690a117d7710b492e83be99df31.camel@hammerspace.com>
In-Reply-To: <b192022ce73ea690a117d7710b492e83be99df31.camel@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 11b20021-63e2-42e4-039f-08d9ea95d1c4
x-ms-traffictypediagnostic: DS7PR10MB5375:EE_
x-microsoft-antispam-prvs: <DS7PR10MB5375A427E434AA3EDCB773BD932C9@DS7PR10MB5375.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G+2O0DINZXgkEFInwZke7he9/Evi/j+lQos+gUXclVFYrck7ZOr5Omyss7eRCm0CWs82IbXN7Sb/5HLWtM4v4jSnzRoqjHZMvWFAwdmHx5hkQiuaiyRVtRTckJd4ci2tpE6ma6DtPfi1fcYVXhIvVjkP0WPemm5MDnkBYubqeEEa9sdnaP6VJTZ4Fr5v6AxF2GccTesvYywQUXeigNUyDy739PwbxqTemTkBtjpTiHoNGvsE5SDz3uSdm1JiKEu5Et/S6LDz+kjnyOJsEfC6Z53lWhIIFnjTP0FOkg6nlpvacMEBXbp+0QRknF0ypE+0YWYE7gcmYB0MWHLyo1+3Xeh+SRr7RFVmD7+xRJn5rVLel4oUnuxiUmve1LhrjfTj9w2lWUlfGKapCFwxkbKg8KwFhIYxwQILa8AfHnA7vfCsg0LwsjE5rWvHDhb6oJvGffX+ATkpDiaLHSRDpsPSRD6Hm7i1QERK3untfZYsbNAfK2K7zig9MdGb2CTBnHsxPxjn1BIWck/9EV+VydaQqWXshOtZDxuAvlDLHMzhKVZWBhH/DgzykKb4lERomCro+3jsXEXBwS1Zr6CzzKDrKqjjpsgYqqfcEB3cmIuzSKTDJzWfSL5sSg7gQ1daCk0EskMRUQ4QrFJa3jcG9XJErIsF6zj7c5C5/JJqZ3FlwU45oBVTGv+3rvqBXT4PHstVMv8yGmXcp34RB8v7wu+9GWaOcmGmeOZwiHMGzcsAQs/8p1725fGU4E+Mul70T03e
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(66446008)(71200400001)(33656002)(66476007)(66556008)(186003)(26005)(2616005)(8676002)(2906002)(6512007)(53546011)(36756003)(6506007)(122000001)(5660300002)(83380400001)(38100700002)(54906003)(64756008)(38070700005)(6916009)(86362001)(508600001)(6486002)(4326008)(76116006)(66946007)(316002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KJLIus/uqlZXvE8KRBWe+9TNmeCrHUrfCbGsOcn5SZxw3OMzTxpUaCNG7/hy?=
 =?us-ascii?Q?v4W+Z5URkvPZgCgt02d6+eYB78Olhzx8FzB3GEjlcRx+K7vGm+Mt7JaUu8IT?=
 =?us-ascii?Q?qwxAAub4tPNOSvMNmz/GsEjZFcx3zVOCIU9indNDa3bnePNVVt4Y/f5zyAz4?=
 =?us-ascii?Q?3PtcKixLa+bgf2yXjLvtIjcOf/PgxBD9d6EfvNXYNYfzrILekICNu50zDc+q?=
 =?us-ascii?Q?HIgj9f1+vUB7uq/5NFpuf0GRSNCwq2Rq5LmqDPRw5CBKAWiUV/ZHSAIrGMc4?=
 =?us-ascii?Q?Nnhr5/nhvArG3CJQ2tSGcZ5WLcU5o1Ne3W2vnjrfWVqOykSz0EoTYUGQDFpn?=
 =?us-ascii?Q?4pesuPbqQa0Mu+QLZsCSXfpOxBVPCBvmKQS1/BlZeZjqDGSNnAWfKkJW4x/X?=
 =?us-ascii?Q?CetmKjxFXJb0ldtDcyXFwzK01c+BTGgxRYpKLdHffrHor8rjZwVUaZTdZz3r?=
 =?us-ascii?Q?YwSE3MRk8f6CpI2TVaNwWl7P6bsry5XUS3GX1rSMfdAqZTlmf25niD0z19eU?=
 =?us-ascii?Q?dcK2hzET0sVb/YKaW4V7sqZzivqlYhdPd3wJnPDElldTj1/ksIiCzfETRFRK?=
 =?us-ascii?Q?bSM5DtiKNf2GRZ0H61dHovDoTd7XpruSeBboCaeaq6MOXdaWk87+d32nD0/k?=
 =?us-ascii?Q?wyzuDEtD69Y5Jgy7sGFd0xJOdfUIj21qXR4I3Xv21pmX5WzjnZF1jIwIDd6Q?=
 =?us-ascii?Q?jM9y6YcH0smGGltrWH9B6Kl49byHHm0Z5jAIy2RDKD9yq9KVVY6qOLsLOZwh?=
 =?us-ascii?Q?DPN0xhZmZ0RihHKS4LOnm5Qs+sEvas19w7xATSDYNSI1K9HEEkll/UQS/+GM?=
 =?us-ascii?Q?8yJjwE1bVKBkar7PF6pgwYwTrHf/ZORrUMyFpFoN0hawZtcLa/PqDAJnZeo/?=
 =?us-ascii?Q?HaERQXwrmZvSlM4zXxkIq8FpEcaCxSUK25MQ1MeVy5U3YuwjmfK0MMBgTnz1?=
 =?us-ascii?Q?/KBiT03V4wEZjuma7fu8MWhg8TJU+Oyu5hfX/vRJCDB3VUUGUztpGqGhoG5W?=
 =?us-ascii?Q?XDkTQ0EF+fy2XnH90NmzvnsWh3HIcHSvl52KEsFD1AWASQBWR4ZYmTPT9tdV?=
 =?us-ascii?Q?JRi+QF2XF51DzrJlm+BN/FnDdURomhNFHycaMmVIQFhkFTWAy7vxMegCCJfh?=
 =?us-ascii?Q?Vg+c4jvQ6rnPDV0rZ0h0ocMPq7Jeu9S00B95YqLYT6+VkmWQtpNXFgfKBXk1?=
 =?us-ascii?Q?8r19VWasQburO1Of2nhbFVrJi+MuZyoaPaOHqF3SLSWF6MEC3ay8fmmKv0Li?=
 =?us-ascii?Q?QxHW034uHi4tH81jIQGUyF8EojkRaESaxcofOKTyToOIsuKtm6vvrEJj1SBn?=
 =?us-ascii?Q?gMtcNx1+evAOI5zJ+HhlSNyNi7mWVBsIn87mwQeUy1AF+a9BZu9SxGFIwBqo?=
 =?us-ascii?Q?1TncjMveZY9Gc77fUfz0h7/okuOkqYHW73vi22rAzSjLEwVfgh4Y1p7XKf+u?=
 =?us-ascii?Q?sKmAldl5lgfS6xjT+wpuGaEjHIQegpogn7HY0J/cB91cF935s/Ed+7/U1xpC?=
 =?us-ascii?Q?x6UiJNs8hyLUfkl/MTBT6FSeC/ar2W6PxVY3uHn7pFXfA7andI8PFW0X8/U6?=
 =?us-ascii?Q?fb9x/8NC1pAKkNmQ5EwFC3DR5qtcwleKUQ/1ViGCEw4aV2i7VYCS1WdbZNgU?=
 =?us-ascii?Q?Rkdfnea2jzKjnFW7Sh6acvI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3B8C8959B562B7469B4E31FB2059351C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11b20021-63e2-42e4-039f-08d9ea95d1c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2022 23:59:03.8853
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fSo6jSp+3Onr7PeGopM+gFBTDARpany6LGWO4HrBAAH5LVIVuA2hl6j0mqsW8hWdcuKyjo6kmQoH8W1uYm1pDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5375
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10251 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 bulkscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202070130
X-Proofpoint-GUID: VCS8M_WFMHDfEdku1uFEPOMzYfgJseZw
X-Proofpoint-ORIG-GUID: VCS8M_WFMHDfEdku1uFEPOMzYfgJseZw
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Feb 7, 2022, at 2:38 PM, Trond Myklebust <trondmy@hammerspace.com> wro=
te:
>=20
> On Mon, 2022-02-07 at 15:49 +0000, Chuck Lever III wrote:
>>=20
>>=20
>>> On Feb 7, 2022, at 9:05 AM, Benjamin Coddington
>>> <bcodding@redhat.com> wrote:
>>>=20
>>> On 5 Feb 2022, at 14:50, Benjamin Coddington wrote:
>>>=20
>>>> On 5 Feb 2022, at 13:24, Trond Myklebust wrote:
>>>>=20
>>>>> On Sat, 2022-02-05 at 10:03 -0500, Benjamin Coddington wrote:
>>>>>> Hi all,
>>>>>>=20
>>>>>> Is anyone using a udev(-like) implementation with
>>>>>> NETLINK_LISTEN_ALL_NSID?
>>>>>> It looks like that is at least necessary to allow the init
>>>>>> namespaced
>>>>>> udev
>>>>>> to receive notifications on
>>>>>> /sys/fs/nfs/net/nfs_client/identifier,
>>>>>> which
>>>>>> would be a pre-req to automatically uniquify in containers.
>>>>>>=20
>>>>>> I'md interested since it will inform whether I need to send
>>>>>> patches
>>>>>> to
>>>>>> systemd's udev, and potentially open the can of worms over
>>>>>> there.=20
>>>>>> Yet its
>>>>>> not yet clear to me how an init namespaced udev process can
>>>>>> write to
>>>>>> a netns
>>>>>> sysfs path.
>>>>>>=20
>>>>>> Another option might be to create yet another daemon/tool
>>>>>> that would
>>>>>> listen
>>>>>> specifically for these notifications.  Ugh.
>>>>>>=20
>>>>>> Ben
>>>>>>=20
>>>>>=20
>>>>> I don't understand. Why do you need a new daemon/tool?
>>>=20
>>> Because what we've got only works for the init namespace.
>>>=20
>>> Udev won't get kobject notifications because its not using
>>> NETLINK_LISTEN_ALL_NSIDs.
>>>=20
>>> We need to figure out if we want:
>>>=20
>>> 1) the init namespace udevd to handle all client_id uniquifiers
>>> 2) we expect network namespaces to run their own udevd
>>> 3) or both.
>>>=20
>>> I think 2 violates "least surprise", and 3 might not be something
>>> anyone
>>> ever wants.  If they do, we can fix it at that point.
>>>=20
>>> So to make 1 work, we can try to change udevd, or maybe just
>>> hacking about
>>> with nfs_netns_object_child_ns_type will be sufficient.
>>=20
>> I agree that 1 seems like the preferred approach, though
>> I don't have a technical suggestion at this point.
>>=20
>=20
> I strongly disagree. (1) requires the init namespace to have intimate
> knowledge of container internals. Why do we need to make that a
> requirement? That violates the expectation that containers are
> stateless by default, and also the expectation that they operate
> independently of the environment.
>=20
> If you really do want external control over the uuid that is set, then
> it should be pretty trivial to do so by using the standard container
> tools for manipulating the namespace (e.g. to mount a file that is
> under control of the parent as /etc/nfs4-uuid.conf or whatever).
>=20
> However in most cases that I can think of, if the container is doing
> its own NFS mounting, then it is going to have to be set up with its
> own nfs-utils, etc, so there is no reason why we can't also require
> udev.

What Ben described in 1. more closely aligned with how I thought
containers work today.

But it could be that 2. gives the ability to migrate the guest
container to another physical host and take its nfs4_unique_id
with it.

I don't have a strong preference between the two. I'm in favor
of doing whichever gets us to "done" faster.


--
Chuck Lever



