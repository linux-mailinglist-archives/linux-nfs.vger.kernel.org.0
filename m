Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49E9A636578
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Nov 2022 17:11:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237748AbiKWQLa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Nov 2022 11:11:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236514AbiKWQL2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Nov 2022 11:11:28 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FBDC6E546;
        Wed, 23 Nov 2022 08:11:27 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ANG9b8u013171;
        Wed, 23 Nov 2022 16:11:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=C+FcYcKgZNmSzZmXd3RgJuixQASMtYcgKBDFAgOvxFA=;
 b=uVQcjqjG5ANaCrm0c7hK9+lTEt6boqjhb07VxWIj7H9tz6DUQ5nUsX2h48N5o1D3dO+X
 sCc/xm4qRcvVXsBf0TJprMDi89gSCPgOSUg3ZK8JNWotyvWPvQwUBUn9NUfiE8LfZB6H
 QNaPpR50QMtLwgYCyDuHBUFK22i9rozL9nBaiBtoKlNSTY/+PciHz2Wf37GnT00FtzVB
 ciS5nmqT6Lg2wZJ1PcVBGIta9hqvakeWsTK/DNMAS8lEvc9aBgBd/j3dPH6qIar5XvhF
 GuokbWDD+NG1RzVX9h95+hnwlA+VesSh7EpRmuvvMRUFPmFxRP9k+4ObSAyH6mTbJLAA 9g== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m1p5fg46d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Nov 2022 16:11:10 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ANFMCCB034539;
        Wed, 23 Nov 2022 16:11:10 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kxnkcuxhf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Nov 2022 16:11:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NfpXeSiIXoqtkJ0PRXTJfrT9xITqO0RKPaCYeOKpPRaJo5v3rERETpRdlVPB7fDHje3+MuYcwY8QpnQ3ayL4W1QIcL3cm5tqpluhCpB1EiEZ68Y3twN7deaWsYpSm8isQ63p2RkGl40WOO9/gXRwr5rogljqzEs2EGAKjaQSHHx4XGISFUnC+7IS3mmesIFZdugp8SN9P6/KhH40kGiJoehgGjTZAjpgqX7Khsi1wMWrQGwvJ7OlfGMdviz1wi5yJQelJVpIZxCkejf43NSskeOQeY/6c1Xv2wiOHKDnXXoPNSr23wa0FfN5qucioCmbCw4x9xmGIxi4tEBvHswbzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C+FcYcKgZNmSzZmXd3RgJuixQASMtYcgKBDFAgOvxFA=;
 b=Kt4ukQkAsZ+tEmsjG6JAJn/YIrn14IIFV+2hz1oYSR2KrTcs0wlWEGy4g02GbBVhfN9MHpNezxzG5NmY4F7p/4SVu51vtVooWFtNdaK4jol8BXGzf+N+bwAGsr5/6izn4iJK/Y0/QX0uWwjLrtJWKtEs9+SnFs1zgXRT+vXQxnEnd6lJrVJsqLsHdoQ3PKohXXIHonCClYX/K+E7znYM/mei8seyjBqxaa3hCNY9lBB342WkFpWkzf3dHFzwhQuf4346WSn54Gh/PfyfBez7eGLLJs6QQ/JAmceh3F+Id6sVbb2YvUhHQ5A0foYTaj93VkXxAnJtazfGa/ahEtHnIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C+FcYcKgZNmSzZmXd3RgJuixQASMtYcgKBDFAgOvxFA=;
 b=rPdl2x7NIdeGAAvs7pSWuQ7LnsainJXUQ0WhPlqnf+4Y+KN3I5tVfZH9r0Fb3iOSgTrMbQXmY162Us2xXziynWy40qrc21tZpQWD54MEoMwso2jOmxl3C3AqCljfpLKn3paXwSLrRYt3N73NMhocCAEXjGcUvsdtPEyxHxmuMMQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO1PR10MB4737.namprd10.prod.outlook.com (2603:10b6:303:91::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Wed, 23 Nov
 2022 16:11:07 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::b500:ee42:3ca6:8a9e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::b500:ee42:3ca6:8a9e%6]) with mapi id 15.20.5857.018; Wed, 23 Nov 2022
 16:11:07 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Anders Blomdell <anders.blomdell@control.lth.se>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anna Schumaker <anna@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Benjamin Coddington <bcodding@redhat.com>
Subject: Re: Kernel 6.0.5 breaks virtual machines that boot from nfs mounted
 qcow2 images
Thread-Topic: Kernel 6.0.5 breaks virtual machines that boot from nfs mounted
 qcow2 images
Thread-Index: AQHY9gcBJU7eFYwcqEeGEUKtEHfZtK5MWxIAgABlQoA=
Date:   Wed, 23 Nov 2022 16:11:07 +0000
Message-ID: <C72ADBC7-C50C-48C7-B0B7-79AACFA94FB6@oracle.com>
References: <65115206-ec17-443e-8495-91661a2fd9be@control.lth.se>
 <0abaa41e-79e1-3c0c-6d1b-47d4e21f2296@control.lth.se>
In-Reply-To: <0abaa41e-79e1-3c0c-6d1b-47d4e21f2296@control.lth.se>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CO1PR10MB4737:EE_
x-ms-office365-filtering-correlation-id: ec833173-87de-407a-f590-08dacd6d5454
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: btI/4Y9NX4PzrDZWm329CiQaZgrVIyyRHEN4oU8LAWeuPVPQmX37X+lKUb5PDcEgX80gReTpg8VQQw53ZGRLYhGZUu0dhPL3XD+9VRmZGbwVUPkbLJ6n4Uj1Tef8ogXyzOBG/zqTF5j7b5LYToQtIO45k4HSW+NvjEbrDw9z5uTZZeAm1DV9t+QA9RAgUWN4CkebJR8q3Voznif7pR4az78AFDsOP36YThm4A+dnDE4d5r3b7/j62RzzxwMV4ASY3CP+9pvDPwAJVBwEhY2XHYXD3uYFreWG4VUBkezRYkScdNzlUV4TNbkcvua6qgtOKQd4u7nUyqfrKpsYrINSgV634TRmOY5dYoJNouNcfXGMRN3whktsEFbSCG8EDqNUNqfYaU+9oNwmOYLjdyecXMKOw3KVxxXTijbYfasCtdApLjZZ4q9Jltfp4vW4A/0UM9fYx7qRhoUe43u865nzBLXh9BVK6Hd+cUcJgi6+43MPVmF6+RqBXb92gfq6FS/dML+0MbweiwB9hlkqQsVNMZk+hDEUSBA8yJI+GTfYGe0lIWHYgy2kyrdT0qE4mLnlcxUWZh1RxvpzJgC+SHLCo5Di+JIhjZnLg2DXw6ClmvMmtmY8p/y7Dc3ra74V2yt3mFq8jpDvpenUUweJmRqrMjzu/Z/pipIc0Jhnf9HCcnyerLfLOmKIu0s+plVJUZMasQqN/qZvmvIGaQRZp3ICKtRURPOuModWqUIyFJ5ciPrz2fTD29sMZH/Gh3kp3bU0gpZDHjOlskznrEUGjAWHgA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(376002)(39860400002)(136003)(366004)(451199015)(53546011)(122000001)(38100700002)(6506007)(86362001)(33656002)(38070700005)(76116006)(71200400001)(5660300002)(66946007)(26005)(186003)(6512007)(316002)(66446008)(966005)(6916009)(91956017)(2616005)(64756008)(478600001)(4326008)(66476007)(6486002)(54906003)(8936002)(8676002)(66556008)(2906002)(83380400001)(41300700001)(4001150100001)(66899015)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?65jXQ0rdObIT0pBKXPK8XRHSlpa77sq21AQRs1cXqiG7qH/rDvbFudcWh7fQ?=
 =?us-ascii?Q?fxUe0JUeaED/yUgoGtdVCoGTo1MJrzATm+btvI0rBxuD09s7FZqpWFmq2yNW?=
 =?us-ascii?Q?M30exDq8Mb9IUJFIeKUBpruEM7nMPcwphDPVhzSkdmwL6Y5kYT/qwQOfD7iz?=
 =?us-ascii?Q?3E4VFYOwTM7yZcjl5H7LbNqijEWgBzxfCzFVqO1UaOxaaLLov+Dw6GxqRcPA?=
 =?us-ascii?Q?+6NRwc8aB+0qyN2WgeVvZ4Fd2cABywq9UEXFWPrxWvcde0xrLFIKLcl1ecqt?=
 =?us-ascii?Q?U/q3L1JfC6LWneA3MgHsWGPSc4uIdVOH8HCkTCb/MVaJSmHl/QEw11vgml5O?=
 =?us-ascii?Q?0yQxCqtGUkqifURLrL3qD10HW9qYj4AFayFqn+R4SErvQ5p3xDi2QmxgF0Qm?=
 =?us-ascii?Q?YbAX/OjxrAqpHGnHFeKgFPVe+2VejarU3CeXw5Ud/28a6QWX6oLovncZEWcK?=
 =?us-ascii?Q?yDXmp4Unn8I/t/TwZ4Da3EklClpCy8NTAKaLSjkR52+f4tXRCd21TNmYy9BL?=
 =?us-ascii?Q?yL6w2yejjrnHAhyFHb1RZ8w/r311ims51KGHz4rcgKsBcMQjkprVLcDXFkvz?=
 =?us-ascii?Q?Mr7t9u1c31l+cXvO9GlmnzQH92RPkfFKuX45zx2WiW47ThdkVE8mxOjJr8qr?=
 =?us-ascii?Q?LoNYsmAl4n/kEUcEiS4Rgc8hpX+7wB/F6oX5a2cyOXJaIE5fgvaBgKn+NhWt?=
 =?us-ascii?Q?+sKm8po9z7NdF4dWWZC6+G46mZyDRstyx8MjyGaJR1y2cY4gJvDtQC9RPS73?=
 =?us-ascii?Q?NBz9v/0c9oO2ouUpAHo1pZeccta07vYUk0Ho1kO8wl+E2JBUPMlFt+L0ijve?=
 =?us-ascii?Q?KHPXHHDNFYCPMUZwRGFYZuCjSoGeTo9SUPfTqG3sQ658LffX7zFSAYZt1tpz?=
 =?us-ascii?Q?KPP/mp9zebHSmKzzyLxAOC3bME9+PkaAJPgjMKrS48XhZKMJmMiyM+iZo8pR?=
 =?us-ascii?Q?oVTinFN7swdY8DLgo9VwRiyCib2XB1MJIzkk8NjuVK4mNdLT8ceqJNsU9gDe?=
 =?us-ascii?Q?lwvnOckSRP1CEw9mInDYPYM/iRz4xOj75gGfy7HhVw7vyzgMowb6lOn3Pn+4?=
 =?us-ascii?Q?Lta7WuRotnkB3RlzBWHra11eXMKDbDe99dy4g6Au93nvQXGW8ai0wAqAlXO2?=
 =?us-ascii?Q?6GWzku3qVMDXUUBIuDDTD5fKOKsItjIM7gLmG7UzVPxKhopOM0aC0eVpUFnd?=
 =?us-ascii?Q?LlV0aytEJLR3RICpu2Kqe42eSDnSyIhqHcl9gxnH4ItpXw9duHkqp4GaRztF?=
 =?us-ascii?Q?vepIFsh+O1Vke6M5+JUVPWHdBv/W4UhumxUl462kdz4KB6JFzkpDWojBKqK1?=
 =?us-ascii?Q?6/6j0Elht8wibUIXjmJnNpfSQUGPD3Yq/jUz4nBrEZHWP+i2dk96YlJF/0ML?=
 =?us-ascii?Q?r+GBStwxfXXyEXSoDlcXzpp5pWN13Wilki/ZEmDIZzg4aEo0rG1FBXAfHrrr?=
 =?us-ascii?Q?iyDMm84EU2GzuQa935Q0eU9O0gyAsg3v2U9JxeB47uMLee5kegmhFNcYNIl0?=
 =?us-ascii?Q?09FmhW/d/qmgpo7GvJGkouw/GpXFQQBZK5Cd45aJCdnpLq5KetQr6BJ3/L74?=
 =?us-ascii?Q?V64INsywEh0Fq+uXEeoUto5iOr2gSPrciSenhZOTJCzcTQDxy92arGmiyPu/?=
 =?us-ascii?Q?hA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <01F028115C68494F970949FB5321DEDE@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?BEDTuW7ua7h9D5DnnuaHaAY9ih4vcA0USt/ZY6iEmfYlNtyDaRIXkHj+VseR?=
 =?us-ascii?Q?vSLECaf3uqvtGi6e5axxOVlJsbWuKgf5DzzjBbZxJYrdhtH7Cw/hllbXG9S9?=
 =?us-ascii?Q?OjpxPrgLDi4VD25bDkssUicD8r8r157IhD3JbNVp79uR9Ac4OHGxbHXA3Ydu?=
 =?us-ascii?Q?saP4SCrjICuY/hMhhAMogEmguZJWQZR2CgZqmHXQ4TBVl9cgMz2OlqVeBVXF?=
 =?us-ascii?Q?IgDR9nJeKYlJ0QGwJKevHsXtLTmvlgotE2yYJJ/G13ikVIBeRtCH6aohUJQ6?=
 =?us-ascii?Q?T9IiC8+jcx5vzsowPvrdj6rUWPOy/JonTCyHZnHBidFWV+Dz+EJwUTmMDEkk?=
 =?us-ascii?Q?+nu8mqy/FVGfEPS2K7+6Q4UuP2sO10tqDd65wXduL51rb5HdRlOV2C/iwjLe?=
 =?us-ascii?Q?hjwk9ruEr9DTJE6wMuci05gcknPuf4fSkm8sGI1AQpuwrdCN9sM2Kx0ZX9bw?=
 =?us-ascii?Q?1Tdxtwm3H4X8BKZ+E9I2G8xYXjZ9wO9igi3rNQlpIQYfXKOy2YkHtwGHQZW4?=
 =?us-ascii?Q?s7Re9k8xxPnvny/oVRTcAL15lDAIJRjd365VvJ8ErDsvtcK/hzUEbajIjx8R?=
 =?us-ascii?Q?lvAbJMgcztuopXMlhM4Qn3vnjkKJdEEHj3FGhqVGDeKrY9fYoyQZMgjxnZ8d?=
 =?us-ascii?Q?Jb4phXfD1334IzgKvm09oqFi10PhZVfpLrTNz4K//lFyQ4O1+AREbx1FhqX9?=
 =?us-ascii?Q?pmAs6BkJ4LeV8jM8qxftEUWmFqVSWj5HzYVcGYhfbhKLe4PCWhKswmPg8gnH?=
 =?us-ascii?Q?oZ8J7Fwmdrh6HLq9ZKBeyxZdcHxk8T2WgQztOwgx/k17EW2C91NPhQIDqKlq?=
 =?us-ascii?Q?OFGYNKY87amINxUAg23Z3zNtHFvrR1lz/SnXH7A2gXd81jIoX87djvHRKfl9?=
 =?us-ascii?Q?X1AyqEJXp0ZNlaehT77tCIz2rQGoU8sCTmoODSJ+wm4y2d6ORaWtY26JAOAV?=
 =?us-ascii?Q?IcJeIysA2c+YUb4SiGvpXLV1lU4xiGb+eQg+uHuZKpp7F5Lx3ZXga7/3traL?=
 =?us-ascii?Q?e6BWjwSnq5rJv4k3WcB8wMJzTQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec833173-87de-407a-f590-08dacd6d5454
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2022 16:11:07.5861
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fC4mvs/NxcsQMWyl8t0YdB/5nWC3/fLBlSvw4nuwGW9mUZt2nqxWJqSYnYJ5mJCeSpjYWnFQbplRuipAZ+16iA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4737
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-23_09,2022-11-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211230119
X-Proofpoint-ORIG-GUID: EYQ0eFz7hxLYR5uJ3hR8ysc4Str6-tjL
X-Proofpoint-GUID: EYQ0eFz7hxLYR5uJ3hR8ysc4Str6-tjL
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 23, 2022, at 5:08 AM, Anders Blomdell <anders.blomdell@control.lth=
.se> wrote:
>=20
> Our problems turned out to be a fallout of Al Viros's splice rework, wher=
e nfsd reads with non-zero offsets and not ending
> on a page boundary failed to remap the last page. I belive that this is a=
 decent fix for that problem (tested on v6.1-rc6,
> 6.0.7 and 6.0.9)
>=20
> ---- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -873,7 +873,7 @@ nfsd_splice_actor(struct pipe_inode_info *pipe, struc=
t pipe_buffer *buf,
>        unsigned offset =3D buf->offset;
>         page +=3D offset / PAGE_SIZE;
> -       for (int i =3D sd->len; i > 0; i -=3D PAGE_SIZE)
> +       for (int i =3D sd->len + offset % PAGE_SIZE; i > 0; i -=3D PAGE_S=
IZE)
>                svc_rqst_replace_page(rqstp, page++);
>        if (rqstp->rq_res.page_len =3D=3D 0)        // first call
>                rqstp->rq_res.page_base =3D offset % PAGE_SIZE;

Hello Anders, I will wait for Al's review.

The official version of your patch will need to include Signed-off-by and
Fixes tags.


> On 2022-11-11 20:35, Anders Blomdell wrote:
>> The text below is an excerpt of  https://bugzilla.redhat.com/show_bug.cg=
i?id=3D2142132
>> Description of problem:
>> Virtual machines that boots from nfs mounted qcow2 images fails to boot =
when
>> the nfs server runs kernel 6.0.5
>> The erros are often
>>   Booting from Hard Disk...
>>   GRUB loading.
>>   Welcome to GRUB!
>>   error ../../grub-core/kern/dl.c:ELF header smaller than expected.
>>   Entering rescue mode...
>>   grub rescue>
>> Version-Release number of selected component (if applicable):
>>   qemu-6.2.0-16.fc36.x86_64
>>   kernel-6.0.5-200.fc36.x86_64
>> How reproducible:
>>   always
>> Steps to Reproduce:
>> 1. Run a virtual machine with boot disk qcow2 formatted mounted from an =
nfs server
>>    running kernel-6.0.5-200.fc36.x86_64
>> Actual results:
>> Machine fails to boot
>> Expected results:
>> Clean boot
>> Additional info:
>> Git repo is linux-stable
>> A git bisect lands me at 310d9d5a5009a93377200b98daa2d84aa2bd8160
>> So commit 746de1f86fcd works
>> But cherry picking f0f6b614f83d 310d9d5a5009 bfbfb6182ad1 on top of 746d=
e1f86fcd is broken.
>> The bfbfb6182ad1 is picked due to the commit comment
>> commit bfbfb6182ad1d7d184b16f25165faad879147f79
>> Author: Al Viro <viro@zeniv.linux.org.uk>
>> Date:   Sat Sep 10 22:14:02 2022 +0100
>>     nfsd_splice_actor(): handle compound pages
>>     pipe_buffer might refer to a compound page (and contain more than a =
PAGE_SIZE
>>     worth of data).  Theoretically it had been possible since way back, =
but
>>     nfsd_splice_actor() hadn't run into that until copy_page_to_iter() c=
hange.
>>     Fortunately, the only thing that changes for compound pages is that =
we
>>     need to stuff each relevant subpage in and convert the offset into o=
ffset
>>     in the first subpage.
>>     Acked-by: Chuck Lever <chuck.lever@oracle.com>
>>     Tested-by: Benjamin Coddington <bcodding@redhat.com>
>>     Fixes: f0f6b614f83d "copy_page_to_iter(): don't split high-order pag=
e in case of ITER_PIPE"
>>     Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
>> The bisect I did:
>> git bisect start
>> # status: waiting for both good and bad commits
>> # bad: [3829606fc5dffeccdf80aebeed3aa75255257f35] Linux 6.0.5
>> git bisect bad 3829606fc5dffeccdf80aebeed3aa75255257f35
>> # status: waiting for good commit(s), bad commit known
>> # good: [0b0649b1d27a768d37f23acf4d88e6e90cca7856] Linux 5.19.4
>> git bisect good 0b0649b1d27a768d37f23acf4d88e6e90cca7856
>> # good: [0b0649b1d27a768d37f23acf4d88e6e90cca7856] Linux 5.19.4
>> git bisect good 0b0649b1d27a768d37f23acf4d88e6e90cca7856
>> # good: [3d7cb6b04c3f3115719235cc6866b10326de34cd] Linux 5.19
>> git bisect good 3d7cb6b04c3f3115719235cc6866b10326de34cd
>> # good: [7c5c3a6177fa9646884114fc7f2e970b0bc50dc9] Merge tag 'for-linus'=
 of git://git.kernel.org/pub/scm/virt/kvm/kvm
>> git bisect good 7c5c3a6177fa9646884114fc7f2e970b0bc50dc9
>> # bad: [eeac7730418563152b0e3172bce9bac4ff6d6bc4] perf pmu-events: Avoid=
 passing pmu_events_map
>> git bisect bad eeac7730418563152b0e3172bce9bac4ff6d6bc4
>> # good: [f20c95b46b8fa3ad34b3ea2e134337f88591468b] Merge tag 'tpmdd-next=
-v5.20' of git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd
>> git bisect good f20c95b46b8fa3ad34b3ea2e134337f88591468b
>> # good: [c993e07be023acdeec8e84e2e0743c52adb5fc94] Merge tag 'dma-mappin=
g-5.20-2022-08-06' of git://git.infradead.org/users/hch/dma-mapping
>> git bisect good c993e07be023acdeec8e84e2e0743c52adb5fc94
>> # good: [e2ebff9c57fe4eb104ce4768f6ebcccf76bef849] vfs: Check the trunca=
te maximum size in inode_newsize_ok()
>> git bisect good e2ebff9c57fe4eb104ce4768f6ebcccf76bef849
>> # good: [c8a684e2e110376c58f0bfa30fb3855d1e319670] Merge tag 'leds-5.20-=
rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/pavel/linux-leds
>> git bisect good c8a684e2e110376c58f0bfa30fb3855d1e319670
>> # good: [c72687614b3627b3ea55d8d169e31cac70f56f3e] Merge tag 'rpmsg-v5.2=
0' of git://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux
>> git bisect good c72687614b3627b3ea55d8d169e31cac70f56f3e
>> # bad: [f30adc0d332fdfe5315cb98bd6a7ff0d5cf2aa38] Merge tag 'pull-work.i=
ov_iter-rebased' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs
>> git bisect bad f30adc0d332fdfe5315cb98bd6a7ff0d5cf2aa38
>> # good: [60349fd52ecbb8b14545ff25aba2f2e230c4d618] remoteproc: using pm_=
runtime_resume_and_get instead of pm_runtime_get_sync
>> git bisect good 60349fd52ecbb8b14545ff25aba2f2e230c4d618
>> # good: [8520008417c581c4c22e39597f92b9814ae34c31] fold __pipe_get_pages=
() into pipe_get_pages()
>> git bisect good 8520008417c581c4c22e39597f92b9814ae34c31
>> # good: [746de1f86fcd33464acac047f111eea877f2f7a0] pipe_get_pages(): swi=
tch to append_pipe()
>> git bisect good 746de1f86fcd33464acac047f111eea877f2f7a0
>> # good: [5d5d353bed32dc3ea52e2619e0d1c60b17133b91] Merge tag 'rproc-v5.2=
0' of git://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux
>> git bisect good 5d5d353bed32dc3ea52e2619e0d1c60b17133b91
>> # bad: [f0f6b614f83dbae99d283b7b12ab5dd2e04df979] copy_page_to_iter(): d=
on't split high-order page in case of ITER_PIPE
>> git bisect bad f0f6b614f83dbae99d283b7b12ab5dd2e04df979
>> # bad: [310d9d5a5009a93377200b98daa2d84aa2bd8160] expand those iov_iter_=
advance()...
>> git bisect bad 310d9d5a5009a93377200b98daa2d84aa2bd8160
>> # first bad commit: [310d9d5a5009a93377200b98daa2d84aa2bd8160] expand th=
ose iov_iter_advance()...
>=20
> --=20
> Anders Blomdell                  Email: anders.blomdell@control.lth.se
> Department of Automatic Control
> Lund University                  Phone:    +46 46 222 4625
> P.O. Box 118
> SE-221 00 Lund, Sweden

--
Chuck Lever



