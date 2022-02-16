Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31AB74B9145
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Feb 2022 20:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbiBPTfs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Feb 2022 14:35:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235008AbiBPTfn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 16 Feb 2022 14:35:43 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D54CF2AFEA6
        for <linux-nfs@vger.kernel.org>; Wed, 16 Feb 2022 11:35:30 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21GHiFYF027716;
        Wed, 16 Feb 2022 19:35:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=RyUPdVUu3AyCC3wq7opbhj2cnhsbSM2IUvC9h4RZy+U=;
 b=A2mbJ8ZzEzC5XoWp2HQD3yReeGa2KJDesOKpT4d1RlgM9ozAWio1Z+GtSvM7pgyvabCM
 E1/+yMnmzulXsURGfhyG4TTg64gBe30xlawSiMbx2D7zGE89yZ7juPAgwAeUK1B4jnZU
 EXAv6oXsD4fUSb6KAb1QvKwtMSybvxp33rDyBC1BBW8AE1g3E3cn4Kp4OWLEqGvTNXSK
 Qo06mgkcmEQXxUrcADQPRKLJnXTgRevPCJSR1/W2TNaKy8i7UeoKWpdVaSt+izl7PaFA
 nXiyurXPWI3d5Er7RVIoj6X1lw8LQCoDO+FAHwzWhFWFYs6JMerab0Bjdtn7pN8WumDD Xg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e8nr93cee-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Feb 2022 19:35:25 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21GJW8aK086865;
        Wed, 16 Feb 2022 19:35:24 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by aserp3020.oracle.com with ESMTP id 3e8nvsyevf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Feb 2022 19:35:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JljEpax96iFNmDsVmDq4blGEdnj0ReQpP5CJpmvatg+5nnFw6dj7Nx08gWu/oyTqO9cYxIM1udWByyxJYPxYN6NI4zmsVgzn5bFj0PyN/jr8It8BSXSmKoRA1O867dxzUOtDFAwkaUs4/SQB1XUtsPn/DkY8oDSzgDz4vrXvApVLdUXxJiELamO5FDdRe4IRtuabIiSE90TNtdFa+kvcuGaOFLcPpFcWe7LGN+owrqO9t9oSp6FS2LbuMwihseQJ3fOm9tK71VWsfqF7OAWBTZgl/cJU2WhsTU2AXvD/wa3JzHV6ckBfZq1h76dzUhgNfSjQyMVGLy81V1D9LC/IrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RyUPdVUu3AyCC3wq7opbhj2cnhsbSM2IUvC9h4RZy+U=;
 b=HaNK9fk/NYupnzckpmpVzGmX27G6/frXoZHJF7KlkZuMd42D90T1QsBcg+3Ht++wNT4B2AhCpRQywkduscvoWzBSOv0nWGZjASaLA2Eh5BVn3FfOTNy4YjFrQMswqo8B616bFplczZvru7DUqqVdQciQjTjcDgvuBlxnVe0e2iQcG7YgbJanHnu4b3uNUoLhSUbA1cWQGylNKwDtiziXGKL0k5jkZ2Sgk8VxOgDFVkE7DA/7y9JnthGYqghQckwAR2XzyNey5I9ES6O4nbVp5HkuZ4QitjJboC076F8HoVccBOMp1XkfFQzM/Srm+Sid3NKF/WO8Ui3HrX3Me86sJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RyUPdVUu3AyCC3wq7opbhj2cnhsbSM2IUvC9h4RZy+U=;
 b=JqK5bAy6SshjdBfqghyusNoFsd7NmCt9q7XyprHutn63DTIJB45W7T0REFSAdm3h4AmkaBMsrsKv0Rnm29gGFXDllsr7BmL+j7BxFdLmW3TXRZLDL4H7r8i+JLstBiZDP9oLFS3/JHsDm7QiI1ug+QGROQmhdlSDfKCWAbXR87Q=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN2PR10MB3614.namprd10.prod.outlook.com (2603:10b6:208:111::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Wed, 16 Feb
 2022 19:35:22 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::29c0:c62f:cba3:510e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::29c0:c62f:cba3:510e%7]) with mapi id 15.20.4995.016; Wed, 16 Feb 2022
 19:35:22 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Benjamin Coddington <bcodding@redhat.com>
CC:     Neil Brown <neilb@suse.de>, Steve Dickson <SteveD@RedHat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] nfsuuid: a tool to create and persist nfs4 client
 uniquifiers
Thread-Topic: [PATCH v2 1/2] nfsuuid: a tool to create and persist nfs4 client
 uniquifiers
Thread-Index: AQHYHqhMlT21uFtPcU6l7DrJSxeLtayNFxwAgAFGrYCAACKIAIAALKMAgAAKL4CAAAdIAIAACC0AgAAEqYCAAAnVAIAABAgAgANWcoCAALuNgIAASZiAgANdMwCAAAl0AA==
Date:   Wed, 16 Feb 2022 19:35:22 +0000
Message-ID: <9FC005FB-370E-4AFA-AD80-8599CBFCC1E0@oracle.com>
References: <cover.1644515977.git.bcodding@redhat.com>
 <9c046648bfd9c8260ec7bd37e0a93f7821e0842f.1644515977.git.bcodding@redhat.com>
 <7642FA55-F3F2-4813-86E2-1B65185E6B36@oracle.com>
 <3d2992df-7ef7-50ba-4f11-f4de588620d2@redhat.com>
 <DDB59BD9-8C29-45C3-ABAF-B25EDDB63E09@oracle.com>
 <D0908E76-C163-4DBF-A93C-665492EB9DB2@redhat.com>
 <E2C56D5B-AC77-48D1-9AF6-268406648657@oracle.com>
 <4657F9AE-3B9E-4992-9334-3FF1CF18EF31@redhat.com>
 <C7533D80-25B3-4722-94A9-0440C48B8574@oracle.com>
 <945849B4-BE30-434C-88E9-8E901AAFA638@redhat.com>
 <06B01290-E375-455E-A6D7-419CA653A0D1@oracle.com>
 <948D8123-E310-4A35-BF04-C030F20EA83C@redhat.com>
 <164479707170.27779.15384523062754338136@noble.neil.brown.name>
 <863AB69A-D5D6-4F22-950C-E5F468CD4552@redhat.com>
 <42AAFEDD-F4EE-4A91-BD23-E08B1149EF1C@oracle.com>
 <3AF29DC6-2EEB-4C3E-BD6C-BE31910921AE@redhat.com>
In-Reply-To: <3AF29DC6-2EEB-4C3E-BD6C-BE31910921AE@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1b6387e7-f872-42a6-5863-08d9f1837958
x-ms-traffictypediagnostic: MN2PR10MB3614:EE_
x-microsoft-antispam-prvs: <MN2PR10MB36147C8467F55F84F8DF74D493359@MN2PR10MB3614.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J7hLIKLjDoO4sTTN9sRnnVf6J82B6xQc56bju+Y4XtQ2/+VKUE8aRHwIFd8jGibvd7O8QJ3/3Yrr7OuiLlb7uJYTXX/z6/kgZFoPYpPAY/nWmBDEcDqh2LOddkQPUidA6amBBPVj7aWiruZPpfSfKHw4fFtAP30WgXc8FY9ZhHRnigea6E9c8s9GCKIa7jewHpyfFjN8vpft6bY/9B6m772/XhHYr43xIexMQ/4jZ9mZZr7v3A6llerQB3VSk5tFJ4RbNJQ7wubw5UieWM8Bt60KfE6dm8sW3H2Y1iBBorPBcwOK7PvWjzFF7DHwUWVdn3dk2250rH3fkoTNb+cX8vuxoYwc0Vp5bJ1zs48f1X/iJvO9KZ4HEBSGDTsncs98205AmtQmSr+L9/HtLytVPvpb6hVxvi49l9ixKsczv+YWhv91f8THaHhnicFBwMVsWE6VoxykA+Pb5z+7W3OUo8oh/9J/LlTHi/WCW/s8n73L/g9ksJnkmZKz9criO2/K6RU/s+7qcDgBPOOCKKo4a2SJk1RdsgZyE2XBU+McUuyM7WqnBPNhmDg3UXRjJculshNxzL4bS6ZvdeUgEm9nScJid0q/H7Fg0c6D/zK86Px4xaAWxZm+Gh33Edt5/FGBm8AM1YrVUTNNJcvSrTiVqg4/1XgIXu2G9F1bhyJV/tJVqVC1oMnsOyozevdkYTzzURjx29nmLdokuZlH0wxApuniisnwsP/+dSJk5siycfMFICvPcdeMeyHU645B6/5W
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(76116006)(91956017)(66946007)(5660300002)(8936002)(86362001)(6506007)(54906003)(6916009)(6486002)(316002)(36756003)(8676002)(66446008)(64756008)(4326008)(66556008)(66476007)(53546011)(508600001)(6512007)(71200400001)(33656002)(122000001)(2616005)(83380400001)(2906002)(38070700005)(186003)(26005)(38100700002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?824vpKQJBOAJu1Va/rV6I6vX1R8PVaD882K1vJusY1Miou8pBst4IPz/7afA?=
 =?us-ascii?Q?NTw3Mfn4UawhG1vPrc3KTPSyVo0LyG7i6YvGx0PoxlsewEJK8GYusL5kRp73?=
 =?us-ascii?Q?XzSyBFxivZ/mkFPziZtt97XYC48x3toMD+fG8iwKhwaMm59qX3StTKDZL8RL?=
 =?us-ascii?Q?RquyieOnqz/gkdnF6c8M8t8hWnbsUZQ3twhOWRGoUht9eQaOa5Gk0FHv+S0A?=
 =?us-ascii?Q?dXpxcdbfWnatj/+CB8Plp8nhd5rCRJnQKLgaPHnpS3XXQwImhdqFgb6E7CrA?=
 =?us-ascii?Q?RPM0764mAKJsvBqLuzCZ79SWxSBmq1yy4AMchXWFYh14ngtrFdtgdCcFMRZB?=
 =?us-ascii?Q?3WIR8nhnjxYvxQQTcl3CMsKhYuBQOHvmKRkgobYBbThQsQkjIcI5u8H5A2vS?=
 =?us-ascii?Q?PqAlw6D1NX8o8PzwqHqGzw8qcWOUYuzBn0+Ukn/S84T9wrlcfI3NnJBmXZXm?=
 =?us-ascii?Q?LPtq/r3FeSQeLuF39nZVdz+cKCfPm+U61Q0CJXmXldZfNQGrwdf7RT0/c2vJ?=
 =?us-ascii?Q?LgzyVvUtjjjmrYYp7CW968CRUHtKfD/UPiwmJnD9dFCpRZvwpTI0+LZL25eE?=
 =?us-ascii?Q?E84mRyEVQFTqR4Xa4UVBQ8l0IUxyYilu/uIz5nrqYo1VvnN1nj8JlF/GJTCQ?=
 =?us-ascii?Q?9JoqwmqqQOYfmG8nTxF7IAGBgIddDd1Q/Nrv4p20/Bc3WBfv+AN1Ks8tCBPy?=
 =?us-ascii?Q?+QuaHTF7lNYyS8tQsVGchm6waJeZuwKfKMYlnTqI37WWi4yudMUj1qa9rYvi?=
 =?us-ascii?Q?MdCQ6y2eWCtWlQyaFGmcUvMW6yAPBpmaZGBx9hQJqvRYDd8hSCvW+4rof36b?=
 =?us-ascii?Q?PzYVWd+8AMFilmbN+AO+8OFRbp5bWg3QI8uqsj2bDJmoXkYO7+57RmJ6dxnO?=
 =?us-ascii?Q?m4z94VZOI/ZwkfoJ0KTO/2x4XS4Xpx0mdfMxNWCEai2T2oOVqR6cp/V1g+Ve?=
 =?us-ascii?Q?oDySMS278aCfgWYuyMMuqflYU5qxSrC4kVZiafg3VdoRfo7IbQrcuSrmHN5F?=
 =?us-ascii?Q?cZ403IMS+sKOvO7/If0iwVE2txkXPHfiRQMNkqPyW42MSnI3gnJmRzsV92gb?=
 =?us-ascii?Q?Iy/thmmxejzDH/yL1FxOC9noNPktMprVr97LhAlW4HWGdnRmXGZwXMZdLpHb?=
 =?us-ascii?Q?Uq9f9fezMyMOyGHk6x0YysmXeGtcCavJrVbEFRR29RVtXEQh2rRTLK8VRMqm?=
 =?us-ascii?Q?N6/s6DZXoGrc51m0ccUfjuXwCJF9nYQM6P3DVTU2JYX5VtmdUy23aPC4g2MU?=
 =?us-ascii?Q?j9GXQ54Y6FrOL0n5LopjcVqoARTHBlUTVhd9FIaJQqh9Bx8GiCT+P4Bd6BWi?=
 =?us-ascii?Q?WUWkV3wnESCaI0c35MgPT7FHAAMPUyuOtCK+cChcAaJgR0CKWR3SyWeVcqsK?=
 =?us-ascii?Q?tsRLlyqdfm3P7+vhz2wBwZ0OPuVrewvpXB4cqr93/V4uqQq/5qywh3OhWYAb?=
 =?us-ascii?Q?J5sZe0u/46w2xlg8sWovUZNA8JpCrXRSmLHBSbeMFla/KDfmeJ2geY24jECQ?=
 =?us-ascii?Q?WZjUyyzs/6iv7eGgw2RnEY70Ei22JuOxx0xBUBYO+ZkE7UjMSnNFjW0SM++u?=
 =?us-ascii?Q?KZC9PIa40EkzDIz/9LxTheaYzo735LNDnLFPcaShoOPxOeBHNfckmmKGBVu+?=
 =?us-ascii?Q?0W8rRVOi8jfHmBbK7i3fjtA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D22506E481517642988C6630D2469DE4@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b6387e7-f872-42a6-5863-08d9f1837958
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2022 19:35:22.7385
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y/FJJ0Tv3L48Y32pYdVg+B4Z+vZV+gVZN04Pl4v0XU2sRoKvmYqTnDF+KakdVKFpIkV5KgEHjWtOxrR8ZDe3RA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3614
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10260 signatures=675971
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202160109
X-Proofpoint-GUID: SkZQGL4PCLI8rp7qt7Z6gxm7KNfUgvY6
X-Proofpoint-ORIG-GUID: SkZQGL4PCLI8rp7qt7Z6gxm7KNfUgvY6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Feb 16, 2022, at 2:01 PM, Benjamin Coddington <bcodding@redhat.com> wr=
ote:
>=20
> On 14 Feb 2022, at 10:39, Chuck Lever III wrote:
>=20
>>> On Feb 14, 2022, at 6:15 AM, Benjamin Coddington <bcodding@redhat.com> =
wrote:
>>>=20
>>> On 13 Feb 2022, at 19:04, NeilBrown wrote:
>>>=20
>>>> On Sat, 12 Feb 2022, Benjamin Coddington wrote:
>>>>> On 11 Feb 2022, at 15:51, Chuck Lever III wrote:
>>>>>=20
>>>>>>> On Feb 11, 2022, at 3:16 PM, Benjamin Coddington
>>>>>>> <bcodding@redhat.com> wrote:
>>>>>>>=20
>>>>>>> On 11 Feb 2022, at 15:00, Chuck Lever III wrote:
>>>>>>>=20
>>>>>>>>> On Feb 11, 2022, at 2:30 PM, Benjamin Coddington
>>>>>>>>> <bcodding@redhat.com> wrote:
>>>>>>>>>=20
>>>>>>>>> All the arguments for exacting tolerances on how it should be nam=
ed
>>>>>>>>> apply
>>>>>>>>> equally well to anything that implies its output will be used for
>>>>>>>>> nfs client
>>>>>>>>> ids, or host ids.
>>>>>>>>=20
>>>>>>>> I completely disagree with this assessment.
>>>>>>>=20
>>>>>>> But how, and in what way?  The tool just generates uuids, and spits
>>>>>>> them
>>>>>>> out, or it spits out whatever's in the file you specify, up to 64
>>>>>>> chars.  If
>>>>>>> we can't have uuid in the name, how can we have NFS or machine-id o=
r
>>>>>>> host-id?
>>>>>>=20
>>>>>> We don't have a tool called "string" to get and set the DNS name of
>>>>>> the local host. It's called "hostname".
>>>>>>=20
>>>>>> The purpose of the proposed tool is to persist a unique string to be
>>>>>> used as part of an NFS client ID. I would like to name the tool base=
d
>>>>>> on that purpose, not based on the way the content of the persistent
>>>>>> file happens to be arranged some of the time.
>>>>>>=20
>>>>>> When the tool generates the string, it just happens to be a UUID. It
>>>>>> doesn't have to be. The tool could generate a digest of the boot tim=
e
>>>>>> or the current time. In fact, one of those is usually part of certai=
n
>>>>>> types of a UUID anyway. The fact that it is a UUID is totally not
>>>>>> relevant. We happen to use a UUID because it has certain global
>>>>>> uniqueness properties. (By the way, perhaps the man page could menti=
on
>>>>>> that global uniqueness is important for this identifier. Anything wi=
th
>>>>>> similar guaranteed global uniqueness could be used).
>>>>>>=20
>>>>>> You keep admitting that the tool can output something that isn't a
>>>>>> UUID. Doesn't that make my argument for me: that the tool doesn't
>>>>>> generate a UUID, it manages a persistent host identifier. Just like
>>>>>> "hostname." Therefore "nfshostid". I really don't see how nfshostid
>>>>>> is just as miserable as nfsuuid -- hence, I completely disagree
>>>>>> that "all arguments ... apply equally well".
>>>>>=20
>>>>> Yes - your arguement is a good one.   I wasn't clear enough admitting
>>>>> you
>>>>> were right two emails ago, sorry about that.
>>>>>=20
>>>>> However, I still feel the same argument applied to "nfshostid"
>>>>> disqualifies
>>>>> it as well.  It doesn't output the nfshostid.  That, if it even conta=
ins
>>>>> the
>>>>> part outputted, is more than what's written out.
>>>>>=20
>>>>> In my experience with linux tools, nfshostid sounds like something I =
can
>>>>> use
>>>>> to set or retrieve the identifier for an NFS host, and this little to=
ol
>>>>> does
>>>>> not do that.
>>>>>=20
>>>>=20
>>>> I agree.  This tool primarily does 1 thing - it sets a string which wi=
ll
>>>> be the uniquifier using the the client_owner4.  So I think the word
>>>> "set" should appear in the name.  I also think the name should start "=
nfs".
>>>> I don't much care whether it is
>>>> nfssetid
>>>> nfs-set-uuid
>>>> nfssetowner
>>>> nfssetuniquifier
>>>> nfssetidentity
>>>> nfsidset
>>>> though perhaps I'd prefer
>>>> nfs=3Dset=3Did
>>>>=20
>>>> If not given any args, it should probably print a usage message rather
>>>> than perform a default action, to reduce the number of holes in feet.
>>>>=20
>>>> .... Naming  - THE hard problem of computer engineering ....
>>>=20
>>> No, it does NOT set the uniquifier string.  It returns it on stdout.  I=
f
>>> you run it without args it just prints the string.  Its completely harm=
less.
>>=20
>> OK, my understanding was that if you run it as root, and the
>> string isn't already set, it does indeed set a value in the
>> persistence file.
>>=20
>> That should be harmless, though. Once it is set, it is always
>> the same afterwards, and that's fine. Someone who just types
>> in the command to see what it does can't damage their
>> metatarsals; the worst that happens is the persistence file
>> is never used again.
>>=20
>> I agree that's not very "set"-like.
>>=20
>> nfsgetuniquifier
>> nfsguestuniquifier
>> nfsnsuniquifier
>> ns-uniquifier
>>=20
>> Use with copious amounts of tab completion.
>=20
> Coming back to this.. so it seems at least part of our disagreement about
> the name had to do with a misunderstanding of what the tool did.

I understand what your implementation does. I don't
understand why it works that way.

The disagreement is that I feel like you're trying to
abstract the operation of this little tool in ways that
no-one asked for. It's purpose is very narrow and
completely related to the NFSv4 client ID.


> Just to finally clear the air about it: the tool does not write to sysfs,=
 it
> doesn't try to modify the client in any way.  I'm going to leave it up to
> the distros.

Seems to me that the distros care only about where the
persistence file is located. I can't see a problem with
Neil's suggestion that the tool also write into sysfs.
The location of the sysfs API is invariant; there should
be no need to configure it or expose it.

Can you give a reason why the tool should /not/ write
into sysfs?


> Considering this, I think your only remaining objection to "nfsuuid" is t=
hat it
> might return data other than a uuid if someone points it at a file that
> contains data other than a uuid.
>=20
> I can fix that.  And its probably not a bad idea either.  The nfsuuid too=
l
> can ensure that the persisted data is a uuid.

Why is that necessary? I agree that any random string will
do, as long as it is the same after client reboots and is
globally unique. It can be a BLAKE2 hash or anything else.
Is there a hard requirement that the uniquifier is in the
form of an RFC 4122 UUID? (if there is, the requirement
should be explained in the man page).

I have no problem with using a UUID. I just don't believe
there's a hard requirement that it /must/ be a UUID.


> Maybe I also need to change the man page or description of the patch to b=
e
> clearer about what the tool does.  Any suggestions there?

I've made some in previous responses. The rules about
reboot persistence and global uniqueness are paramount.

So I initially agreed with Trond's statement that the
client ID uniquifier is not specific to a particular
mount request, so doesn't belong in mount.nfs.

All still true. But...

If mount.nfs handles it instead, you don't need a
separate tool (naming problem solved), there's no lag
between when the uniquifier is set and the first
SETCLIENTID (race condition solved), no udev rule is
needed (no additional implementation complexity), and
no man page and no new module parameters (no
additional administrative configuration complexity).

What's not to like?


--
Chuck Lever



