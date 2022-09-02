Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D39D5AB7D7
	for <lists+linux-nfs@lfdr.de>; Fri,  2 Sep 2022 19:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235637AbiIBR63 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 2 Sep 2022 13:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234778AbiIBR62 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 2 Sep 2022 13:58:28 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 051FF2CDFD
        for <linux-nfs@vger.kernel.org>; Fri,  2 Sep 2022 10:58:25 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 282GAhMV010357;
        Fri, 2 Sep 2022 17:58:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=wE6wgM2CGlBBLgNKeqEFQgAx+8gpWc/Zeos1wNEQSOI=;
 b=I7W9WNlkN4oGNXmlV17IcPuqbX2yvcoqa5/pZblFh6zBBaCJCS3OkPIm3eI/VFGHq044
 1vSRydVCneFP7fqVdeDtGRp67I/bPl9ALCx1wNgE1xKCOZb+9JkeoDNrgYilkCF7ojeq
 vK4hz5lk/9Tuj/Y0BO+fagN8vZKdP4smNWFNM2Oqfo4k9MDBqlQ9uWA6NW9REQYGPNWN
 hAbUWniYtr5jRjFTBMe8Oe7uLxFhLdsSY22sKyxU5Wx4blw8Ir3jIEPZMKRhGR8LzRQo
 UvGKPFXFypOn4eosiZkVkGU4nlY+h08wRe9BaknhltCnUOwe56GNIUhNzJ+WNaW91g4g dw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j7avsqw6t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Sep 2022 17:58:21 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 282F0gcE002243;
        Fri, 2 Sep 2022 17:58:21 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j79q7v2wc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Sep 2022 17:58:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kvboBD0/xicB2Ee2oMpv0rPl2n2Xu/mXJIV/8BWnX2XsMe1Jrp1ZI8KGJhEVu69C8VWk6NsCHI1cOHpCrp/a5pw5VF/ZISgc4XiRn2YRhLZ/NAg59ewmjej0AUQJlQbALMjx3Gj9DEOZYzPrI+tGD8l/OMcD66ShexZbRIypbZn048KmXIp7M3HViNMwUHltVdx9GW+sUrRUp0xderYhWzgbG3zr98zgZiyPfArpKQiKwCDUSo9iUeaq1Dixad10suD9/qv8gOUy0EWglOId4EPNHlSjmxUbp90ZiQqmmOugsjEla2FV9iaLv3yQ3+T2CoUW5HcK4JalwgLUIuPTJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wE6wgM2CGlBBLgNKeqEFQgAx+8gpWc/Zeos1wNEQSOI=;
 b=dOWc4GE7TmFKwW+x6mYGfBAoCRE+UJ5pDH87VR3viYPAlN7GRRv1z+rRQMh1fRTTFrjoKWJcAt8vHiicUZgyfJMG46O+4PzuppuMXXSDxZ0SajgtY0SljjQLicSswhKS3de6ud/tDEyONzW1PpAO2B8cMREWERTvMJeLjT0ZjH5/CW4jZOaBvsgO81mNv9KgY7NLrFoQmpmqLXo5O8fB0D1VWv2JgEi8TDrZJKIvYARjroyRyqo5sQzfymIYepl0PLRwMpPIxrm7ZUmOnBTNr8RgA5PGsbB2bad5dds3jaRdG2rygeeg+SmgtEuZ27229DEZKdPpmQ2rMbW+OXZ5Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wE6wgM2CGlBBLgNKeqEFQgAx+8gpWc/Zeos1wNEQSOI=;
 b=EITvKgDPi2U9JKXCGOCD8W3DlgCTRQty0PMZPqHPlrV06CsV+bQx2g7YRpMhPwI40Pr35f8pOlJfey7WXGQOs5irJMjFlaiAzZJUhXO/k0w43T3dMwfh/s8s0mEuz7ogkBYo/JNl9hiN1wHSL3bbBq350J7bMPvFFYgih2Xcwos=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB4960.namprd10.prod.outlook.com (2603:10b6:5:38c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Fri, 2 Sep
 2022 17:58:19 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa%4]) with mapi id 15.20.5588.012; Fri, 2 Sep 2022
 17:58:19 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] NFSD: add shrinker to reap courtesy clients on low
 memory condition
Thread-Topic: [PATCH v4 2/2] NFSD: add shrinker to reap courtesy clients on
 low memory condition
Thread-Index: AQHYvLpF3IXRGSf70UK3afu6RNBIZ63JEv+AgAJR5wCAACuHAIAAzI6AgAAUu4A=
Date:   Fri, 2 Sep 2022 17:58:19 +0000
Message-ID: <3CD64E7F-8E81-4B37-AAF3-499B47B25D19@oracle.com>
References: <1661896113-8013-1-git-send-email-dai.ngo@oracle.com>
 <1661896113-8013-3-git-send-email-dai.ngo@oracle.com>
 <FA83E721-C874-4A47-87BA-54B13E0B12A3@oracle.com>
 <2df6f1fe-c8eb-d5a1-0a11-2fd965555a33@oracle.com>
 <7041D47D-ECB3-497E-9174-96E9E36FFBDE@oracle.com>
 <eb197dde-8758-7ef4-8a7b-989273e09abc@oracle.com>
In-Reply-To: <eb197dde-8758-7ef4-8a7b-989273e09abc@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e0d73167-3195-4d0c-12aa-08da8d0cb833
x-ms-traffictypediagnostic: DS7PR10MB4960:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rHbXLL0jABlambrzoRN2+fDpOkUKuu3kSGHPVoUuR7RUwg/o0z87EwlMvpd/ambdz/yBioDOQKIc62wMq2dfDGxewgGQDySKlVssSBXbNWChJz+yrycAptuFrkVLcBVqVcQ8kAdtf13etcczjy3LKyuNU6HhNh7c6ruPQowoLUw8t+bIrJsgkLdaW1SDMLz6cve+xxQIRjXqYh7rI33ULiO1LCXRZJBpZ3orCkZJFbKJwLbCIrDh6a3Dub0REc1wkgeialj8gGjLityr8a5x1+D/8ohTF01V9on+0dUlyA2iVdqqryIaMaYkKJ6RDUE2j21Y/6fuqjdgOFkXhfrSHJQ6qTiJrCyScD4O8ojRY+7SoVF+Z/EeuLVkWZQkEqgcff8f1VfoMtw25vbF5EPeTQXhTAquecdwxjA037528ERiC+SBHqOJXnx4Qw0GuHCXIpEQeEVOJWU3q1ddjQUG/nrbdJnkgkbKdFg6nwZzqBEaf633nii3OCQXjAyp+KUSBcivSBukZHnEHejFvPqRQyidt25Xgusy73haLKzSTlwnT6QktMxPioZOPkU+VSsnEeP0GPVZmkLGcV1CAF+EDS/6sOPSbfXpULImKLFELlbvP0Sqm5wshqoOZVBjDgc3wHTLHZY+1jYIMkr1RoWgqAlcOKsXvd83fa2t2HCHKHpAUhXlnSL9XkFnjGawU4RGcW4RdkU2+DMoTmcNfkCxYuA3v8IiN5CzkzsQMDQuanU/Lcgu1ziHzAOa6mcKY/DTlXynXusVc+iR9Uox+3lCZAKk4OJ1PpfzAeHYqZB/6P8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(346002)(366004)(376002)(136003)(39860400002)(66446008)(53546011)(41300700001)(5660300002)(71200400001)(8936002)(33656002)(6862004)(86362001)(6512007)(6506007)(2906002)(26005)(38070700005)(122000001)(38100700002)(83380400001)(2616005)(186003)(316002)(37006003)(478600001)(76116006)(66556008)(64756008)(4326008)(6636002)(54906003)(8676002)(66476007)(66946007)(91956017)(6486002)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FOengagJ4y3Zx39YLhhRzNaPnh6qQ7xh68sJr4Txy2YaC3uvbdzknGFESuVl?=
 =?us-ascii?Q?dL8WdT/N95BEsMktNdyTmHwE8hRVKhT2YjkfSBjCAsgTn/AyoSwf7PP29YMS?=
 =?us-ascii?Q?mRfC+UGC/B7hSnLdvxPicNQcSeSoExbZoFY4oZKK6SdjlcOSPtZy4Cxot0QP?=
 =?us-ascii?Q?j+FBRy3oSjNQO/Y9pRSAFuxAgDA+8Pd8TWO5pQnM5lCfOoNRmRZMSc2uVOyi?=
 =?us-ascii?Q?X5jrqWyRaYmmPqR0mAN932pFJbXH7yrDc2gH+3zUP6uIC+YJQ9n8DXZ8r37v?=
 =?us-ascii?Q?uJl+SbaidMMg3gXlPhbRGGGe3bJM0+a5QyGF0OHN3Lqp7MX57O1mi/kLwsFg?=
 =?us-ascii?Q?RICH2XkAc0GpZuTJ2EixonioMKMEUoTZZ6GeiP5VMT/y2VvtXiwdO9WlzWtk?=
 =?us-ascii?Q?6lLjO/JLKCiuzk70tE7z7qyMoo5rwuRcgFEUvJLhJkOFb2ietr9mRp3QATd4?=
 =?us-ascii?Q?R9ZB48a++rWXKg7xtxBnCC26jj3RfUNhLAfCyJJaR+s0ty7SebSqsYjw5hxK?=
 =?us-ascii?Q?eiwKiBpBs2kbVdX5fxqxYiIkiay6fvVdJQm7YYN1MnZJr/OX93pCpyzd+NG3?=
 =?us-ascii?Q?d7K0tbUYzZbSrOtU/sOAJnZLEEsTRIkqlrGL6uU9RcbMU7Xc9QD90jxoTVXH?=
 =?us-ascii?Q?9KH2fP+QJwRMI3OAZu+uy/EaONgauqjxqy/lXmNCvB2eLoDecp9JcXPsNd+Z?=
 =?us-ascii?Q?HRvYD66U99l2MuBT/lB1gKtyO/4yWcUKNsddNNRZRLjEBTqTdqxG8Gfk3jDK?=
 =?us-ascii?Q?0UJzvxrmBHA8z70uAJiP39Hu6tYsN7eVmDK8roBK+x0PBdn8nlrWIVhOpP6q?=
 =?us-ascii?Q?FKe+0UZDqMtmmoNYrFnPHn+N4Vs/egXf7s/Vge5YwFgKQPz8yt14toH0lKGu?=
 =?us-ascii?Q?anO7wVIrdT3Lod1CLFh+SeBLdn6j4NOAhH/N5xXLIiNyutoANQ6AFrOVY5y0?=
 =?us-ascii?Q?tEYM0iUEyrtf3bp7MnYtBpQrgEohDl4dEnI/+lbUWMMBpD3JWZquTtIxy2Xx?=
 =?us-ascii?Q?xGhI1KkPj/OVmd9hjkded4yCgM7i4epNmANcp1e1fxHsVN90B6aTJWSeqGVL?=
 =?us-ascii?Q?Vx5IYBlmo1pqL7ep2jhwwqithmyj/7B3BUkA7BdieCxnJdVpxN1K3iO3v8wd?=
 =?us-ascii?Q?r3QUDAcCQ2SuxKHDBenL6FqnMEstsI11jHz3aDLzhi2WYVvAT4kLdE0CH1lv?=
 =?us-ascii?Q?Anu+o55+dMBairV5fz+u9BiuzhtxveD/Rd7WK/mDWkjMzmMFSucpBgYDjt84?=
 =?us-ascii?Q?OYjcTntpfPbA+nxy2bkGY8BEuol3QvtJnGSNpNXIuoVy1FL7hjv9Jp5WSeCT?=
 =?us-ascii?Q?SOd4Ap37rSppmuq8dtX802r4KaKvHINEpwWLxNgLyt/L8dtzpG3dMlbdAI2t?=
 =?us-ascii?Q?lM3zFPxsOEcpTptANZwLl3Ajw+0xL7eVp3did4Z3l3O8jCNggD8Qh0/evA1W?=
 =?us-ascii?Q?5bYjPIjTA60Sow+Xpp/wy+h/nJbZuYq5Lf9JlnbL1A+aQrFibQHYrZ7EWVR0?=
 =?us-ascii?Q?acKE80h0ARJO3yF4DKTAxpmTzAUEpfVzxDRqKf2nQGO539xUIKyg5o9630RP?=
 =?us-ascii?Q?kPGLJTCey/jEx6MFK+sA0/r4JHTw4f43BMdotYUz/WdpgPliKqDD7C99FjTo?=
 =?us-ascii?Q?SQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EDA399BACEB635458DAE98B16E7B76A9@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0d73167-3195-4d0c-12aa-08da8d0cb833
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2022 17:58:19.5669
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Df1ELpcY12iDnHU5vI86GaLmG2zNyrAnpiwaFkEupSkMTVjjqN4gf7aGri+IEKpF8qlQhJ6TRxCl3rOjaMcaeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4960
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-02_04,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 bulkscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209020082
X-Proofpoint-GUID: ZmUvEqihzo0bqZ9weO2WBpVZ_HVa9Qex
X-Proofpoint-ORIG-GUID: ZmUvEqihzo0bqZ9weO2WBpVZ_HVa9Qex
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


> On Sep 2, 2022, at 12:44 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
> On 9/1/22 9:32 PM, Chuck Lever III wrote:
>>=20
>>> On Sep 1, 2022, at 9:56 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>>=20
>>> Hi Chuck,
>>>=20
>>> On 8/31/22 7:30 AM, Chuck Lever III wrote:
>>>>> 	struct list_head *pos, *next;
>>>>> 	struct nfs4_client *clp;
>>>>>=20
>>>>> -	maxreap =3D (atomic_read(&nn->nfs4_client_count) >=3D nn->nfs4_max_=
clients) ?
>>>>> -			NFSD_CLIENT_MAX_TRIM_PER_RUN : 0;
>>>>> +	cb_cnt =3D atomic_read(&nn->nfsd_client_shrinker_cb_count);
>>>>> +	if (atomic_read(&nn->nfs4_client_count) >=3D nn->nfs4_max_clients |=
|
>>>>> +							cb_cnt) {
>>>>> +		maxreap =3D NFSD_CLIENT_MAX_TRIM_PER_RUN;
>>>>> +		atomic_set(&nn->nfsd_client_shrinker_cb_count, 0);
>>>>> +	}
>>>> I'm not terribly happy with this, but I don't have a better suggestion
>>>> at the moment. Let me think about it.
>>> Do you have any suggestion to improve this, I want to incorporate it
>>> before sending out v5?
>> Let's consider some broad outlines...
>>=20
>> With regards to parametrizing the reaplist behavior, you want
>> a normal laundromat run to reap zero or more courtesy clients.
>> You want a shrinker laundromat run to reap more than zero. I
>> think you want a minreap variable as well as a maxreap variable
>> in there to control how the reaplist is built. Making @minreap
>> a function parameter rather than a global atomic would be a
>> plus for me, but maybe that's not practical.
>=20
> I'm not quite understand how the minreap is used, I think it
> will make the code more complex.
>=20
>>=20
>> But I would prefer a more straightforward approach overall. The
>> proposed approach seems tricky and brittle, and needs a lot of
>> explaining to understand. Other subsystems seem to get away with
>> something simpler.
>>=20
>> Can nfsd_courtesy_client_count() simply reduce
>> nn->nfs4_max_clients, kick the laundromat, and then return 0?
>> Then get rid of nfsd_courtesy_client_scan().
>=20
> I need to think more about this approach. However at first glance,
> nn->nfs4_max_clients is used to control how many clients, including
> active and courtesy clients, are allowed in the system. If we lower
> this count, it also prevent new clients from connecting to the
> system. So now the shrinker mechanism does more than just getting
> rid of unused resources, maybe that's ok?

I don't want to go down the path of kicking out active clients if
we don't need to. Maybe you can make the laundromat code more
careful to make a distinction between active and courtesy clients.

It might sense in the long run to separate the laundromat's
processing of courtesy and active clients anyway.


>> Or, nfsd_courtesy_client_count() could return
>> nfsd_couresy_client_count. nfsd_courtesy_client_scan() could
>> then look something like this:
>>=20
>> 	if ((sc->gfp_mask & GFP_KERNEL) !=3D GFP_KERNEL)
>> 		return SHRINK_STOP;
>>=20
>> 	nfsd_get_client_reaplist(nn, reaplist, lt);
>> 	list_for_each_safe(pos, next, &reaplist) {
>> 		clp =3D list_entry(pos, struct nfs4_client, cl_lru);
>> 		trace_nfsd_clid_purged(&clp->cl_clientid);
>> 		list_del_init(&clp->cl_lru);
>> 		expire_client(clp);
>> 		count++;
>> 	}
>> 	return count;
>=20
> This does not work, we cannot expire clients on the context of
> scan callback due to deadlock problem.

Correct, we don't want to start shrinker laundromat activity if
the allocation request specified that it cannot wait. But are
you sure it doesn't work if sc_gfp_flags is set to GFP_KERNEL?


> I will experiment with ways to get rid of the scan function to
> make the logic simpler.


--
Chuck Lever



