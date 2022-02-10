Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB95E4B118C
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Feb 2022 16:22:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243522AbiBJPVl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 10 Feb 2022 10:21:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239853AbiBJPVl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 10 Feb 2022 10:21:41 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB69DB1
        for <linux-nfs@vger.kernel.org>; Thu, 10 Feb 2022 07:21:38 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21ADXuNd013525;
        Thu, 10 Feb 2022 15:21:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=/p5yFMD+9sZmU2NONkh7YBUpu0+JPKVa4ehcOtfFx0I=;
 b=JPL8DHnH096bIgkTL1I3qdf92iSzP4FfdJAqTDArgh2ImppO8yrxeN0Hiaqqiep3/u/j
 8QeqSOpzPk28ybJ/hDX3CHY5CNTXOBTq2e/eeUfADXVQ1uNg56gyfsq6ci1ZmtvDESv2
 qpScPmx+z/qfSzNSS+i2SynmeAKMAPHjfZSPrLVBlLz2Wkf9TirC5pzQqpCxp5WzH4qh
 hBVs/n4MriDWTTHUX4GPTi8MrvuO/7X/FfeLP4FnWkbT3O/lt1c7hKUufnTPdxFZYg1T
 O+o3ZuseR8KKfgXAv8VgCdapKGrQOJyJ9F3IQi7UbuYnrZMmewEoWvsaCfzrGWYMGwuQ 5Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e345st9rf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Feb 2022 15:21:35 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21AFGDu4079579;
        Thu, 10 Feb 2022 15:21:34 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by aserp3030.oracle.com with ESMTP id 3e51rtegnx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Feb 2022 15:21:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g9RV0jQyT2apRthbuoeN/Bf1OeWwgrTnd7TUl8F5mbWakGLU/9VtTGSja5jmBkdwsDtKJvDlQxUF/E+mYSuSS3KyfKskrAQULYBdw98v4SIGiW/uJ8HgOreEksKDQp8PfeiPGNJT4+VobhN5k4cM+UumYCnF0yd8buqrJ0AAiT0+8WYbIKUFkYkNKVKZJjs/kZkLu5MSKb9tdHBWpmmfZNWaEkZg501ir+4GYURIkKuT5itOho6ZitIvHV6n/DXbQqk8HpIB/LZh8s5OE402/fmTSCOhBwEKHmQ6MCjbOneg8tjKE3AjVWAydPymyj1AvjMoZYg6WY8gIsbF3aIs8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/p5yFMD+9sZmU2NONkh7YBUpu0+JPKVa4ehcOtfFx0I=;
 b=hRzF2usqJJHq+XMtHQV94mB88ZqEDhCSJNN2KxwVf0OaWim/cGSE6cazEYxnGZIEdINiZozaejLw6bgP3WuIZ959wpaj1mwwRo7SlO8uqmH2CTxinb59pSHnZrxmiZHbYJ9G5nD+YZ43hn2w2Ta6DbsL+xI9Y+eXlmmfNHGnP1TSmDaqQ1fRVr93kTaH2LCZZrI5wO3vSQ9/Aw7HPWEeCrYymquMrXJAiQtnej+QLr2rf1v0f7ijrIMXZvBG8p4aYCq8Nho9gCRvjYDZlH45BvJV4rBj17X9ts5IohUCkRNNx9cIKUoep1MVSbKCefZ6ZIHhYpQZGtrlaz43L2Sogg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/p5yFMD+9sZmU2NONkh7YBUpu0+JPKVa4ehcOtfFx0I=;
 b=i6Yq0I+h4wLchSv3pL/nkFZhtyImL+qnahWwVc3n5MwIq7m9g6mGKIikYHFDw9mCBu/ginE0UNa4v9l8+nreS1kXKLy08MHJFfwCa/BCaqGljqPnPcbh53vX8ZtUQWIlGF0dSrLYXLWuTDEzOvNQQWkdojhDvUJoeCNEd5iD1/M=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by MN2PR10MB4367.namprd10.prod.outlook.com (2603:10b6:208:1d3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Thu, 10 Feb
 2022 15:21:32 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::c8a5:6173:74d9:314d]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::c8a5:6173:74d9:314d%3]) with mapi id 15.20.4951.019; Thu, 10 Feb 2022
 15:21:32 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Benjamin Coddington <bcodding@redhat.com>
CC:     Steve Dickson <steved@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [nfs-utils PATCH] nfs4id: a tool to create and persist nfs4
 client uniquifiers
Thread-Topic: [nfs-utils PATCH] nfs4id: a tool to create and persist nfs4
 client uniquifiers
Thread-Index: AQHYGca9ZpW/pPf5rEWUIwyc/qfEDKyJ14OAgAAE1wCAADSIgIAAHlWAgAAWowCAAorMAIAAH4+A
Date:   Thu, 10 Feb 2022 15:21:32 +0000
Message-ID: <10D2854A-310D-44DD-A31D-83385AD7D87C@oracle.com>
References: <c2e8b7c06352d3cad3454de096024fff80e638af.1643979161.git.bcodding@redhat.com>
 <6f01c382-8da5-5673-30db-0c0099d820b5@redhat.com>
 <33B10EBB-3DD1-45FE-B7D2-D5EA21DFB172@oracle.com>
 <839b09ed-fd21-bda1-0502-d7c6f1fa9e88@redhat.com>
 <32D8EBC9-652A-49D7-B763-A82E2AEF6282@oracle.com>
 <281b1976-9b40-fc53-301a-2846c2ead5aa@redhat.com>
 <13069AB1-28EB-43F6-83BF-41E9B9501C75@redhat.com>
In-Reply-To: <13069AB1-28EB-43F6-83BF-41E9B9501C75@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 768cf496-b11c-475b-39a5-08d9eca904a9
x-ms-traffictypediagnostic: MN2PR10MB4367:EE_
x-microsoft-antispam-prvs: <MN2PR10MB436718EEBFA6FFB2D21026FD932F9@MN2PR10MB4367.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5M4BUpdGt8H413rtAVqNQtYlKWE2W693KISyuTPQ0WTx4dsXZz4jldHO8ALcTiNix2i5CyQj87VFn5msk2xpnGJcz7RgW4MZptnWIgZn9jDH90e51/rdYbnYaBBizqUglUuFLsQlG9jMrg9XOJhtPQorjVvmN6mH4v4D19wj/pCrnsBs0jsbbuetP+rwEu9hsqRevfJ51/UA+U7g2/ixsBB4gG6+haMiBVTi0qsnIsfbcaaiRFvVXhlmifvx3sKGR1ffl6GvUV/u4dkp+vt1aNZRHEo+em/uuqyixTLJLH/aAxOdzBmZJzsBS7u//xWMlrPB/zEU9tr5ZqayeAcfXtxKGn3NfYK9kVMPkUR6ldcYWgKnNWehj77jcebWcCuxKMVRJrqLgPrM+iCfEiTp8ViURYTlB2aWMbGcNeGGvXGE4ffEkSO7UE8f83Ed4bfpelaOonRaFbZTDMvmublM+cXeJhvtgqjtc17Ca/WaKGFQThNYwQ2fsLRmIVfJFe58hL9m3gq9BAm0iVkuopVR1etps/5L4RJ99sNceItAiOWngL9xjnx/pCGAcqQLG/LYhb8K/7sbuBzZNtqOTWD+NPDPbUFKpOtrCisbDBlKYzposXY2iKCShwtFsx4r6AyD+/ZkK0HuI2zj12e82dr26y+uh3zag53HK04QO/IeQWShDkGfo0355G/1mI76iSVibB8C1KXt+uMGNf+xJ+g0jfLcGOeG6bgB8T8xIWQNmOzXygvQzj8L40CmfAvFSDojVmM1KX1wf0owUVnwqA5pWA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(54906003)(6506007)(6512007)(6486002)(66476007)(38070700005)(38100700002)(316002)(53546011)(36756003)(5660300002)(122000001)(2906002)(2616005)(71200400001)(64756008)(66556008)(8936002)(66946007)(4326008)(86362001)(186003)(26005)(76116006)(33656002)(508600001)(66446008)(8676002)(6916009)(32563001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sILnnbkxq09VyhNBwLAJ80wh4V5rWf51savHKCe4KMGjgacyFW5T+Nr/vmuC?=
 =?us-ascii?Q?kPDcqGUK8UUHqxJ24SPIc6STnWQrhz18E4+K2fTzOTlocIJnno3mGB0ucgx3?=
 =?us-ascii?Q?xIPo4BwJWbIeBy/UW97LHuOSNmt/khqyKka2fyzX0e066vksWq/EfoXFXFzU?=
 =?us-ascii?Q?ENgwYrKTXR08GA589ZebqcCPV1qcwlkazbXNZkXoDefI00MM1zHAVseV4Ijz?=
 =?us-ascii?Q?ILcvKMQe/vH2rTM5QAJs1/vZBbT6OYd1qUHDtZRYDh7453MlYcFtwOUdyaEe?=
 =?us-ascii?Q?8ORrH2Xba1G//rZVeAHnO352YZLO5o+aovRIasig3zSh0kDci79NlX20Qj2D?=
 =?us-ascii?Q?Qj3OR4ZAroftj092KXArjpWLaIY2if1Z+1TBLpL9286qyFC6ViWQg6HmckvL?=
 =?us-ascii?Q?Hq1PHY5CgSsbwHF+ptB4SrhhRPqP0VSn21J64Asac4so57ChYTz1cAcdemB8?=
 =?us-ascii?Q?p0xIN86upGoapqYpjkBlp0ePY1JbvICHXfZHc+vWZq+Ql1QCHSwQuk2oAali?=
 =?us-ascii?Q?i8ryteaBVlG2PjLJkOvCrBp0RJ9yMSLpVy2+vrDMopdaVUyMhFk5SeZJr287?=
 =?us-ascii?Q?72AmRIuj4Pq5eQLQ2A33ZFK6CmOu0s6bn9gBPJt4UUs3AsBx+gjc/XUawBvb?=
 =?us-ascii?Q?GnG1xq8IIyfN9T7aNmsBpip48G7obrhwtBH65l9u45nTUJ3+1W856Mysg8F/?=
 =?us-ascii?Q?+RCuK8jxg7JTSTJHESKAgFop+UwNnmRSSlfpOR91urSMEaP831gmozcsgt9i?=
 =?us-ascii?Q?rnYz6aBN9BtgZsyh2EN+on1lUK7O5h62UGau4jx15e7yGyoMR3niZGw4L9vG?=
 =?us-ascii?Q?n2qCoRgJ0NJ7KAfSNAPr1khRv8CH3oeeGNVPjDUaIsJCs2JpzfeUV7l83cjv?=
 =?us-ascii?Q?TJr/74osgWvct4ntDSDoz7saBkKit5ePrb4NbVRdQdD1qQH1pQrRk9IpkNRI?=
 =?us-ascii?Q?Gpm2W6gs+DwUrb2VvOhYgeRu4CSNBJ3/mBl9CCzmg6MrUad9+l5M0LmvmKub?=
 =?us-ascii?Q?tF2rXVre0z4dAaETIVbKvvZvGJnS70gjOrPkaDtrdybQ8bCiCvmxyfEYbsiS?=
 =?us-ascii?Q?biHnvyYoyht1XtuOnikJgxpy+hni/TEj3Dg2WpvUbHAUMTAcv5U4G3swN95M?=
 =?us-ascii?Q?SSSwfuP5+vth4xHeHAr/ker5wJ+U0hNU9m+Qdt9f8oT+7dY/KeRg92lu3P+1?=
 =?us-ascii?Q?J+VU2vTybpYvp76f61+RUda9Q4X4PTdtPbUEgzLYreNVobTa9eEY/BRC0vL5?=
 =?us-ascii?Q?ShWa62z0SOFhk1KKM4fmx49mFnXem92Ij503Y4Rgi5xGyqqGBfEEErU5Iz53?=
 =?us-ascii?Q?ZiNrxz49LcJYwuQRBJ4rWwHWa6TAwaZWHKwKeXqSQmHIxidIyS7QHm1hV8N/?=
 =?us-ascii?Q?FJaHzxo93QMzpqPZ3kGChCzBFoo7adcMRlbGZhUCu1QPmWQShlEyNXz/XFlR?=
 =?us-ascii?Q?wX1bI/XKG5lLvSA/SIGQUSsNLDayaA+bJTLTtTp1WpL7EMYlpx3GhmE3l3yU?=
 =?us-ascii?Q?WiBNhpG+tqMhgJ0LgM7McKcAhal155X4IVLGzxzeaVA5eyKkoOIh2fVYu7BI?=
 =?us-ascii?Q?E3fda6E4Oq3kTbFdPiR2l5Af9ICPY3RtegMXLspnc2H6Rz6F4X7u8FoPIWoo?=
 =?us-ascii?Q?7HX3liswowToShLqUuWK9Eg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <062482430097E94A91BBDDB9FA06E425@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 768cf496-b11c-475b-39a5-08d9eca904a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2022 15:21:32.0994
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iBGQAU1COpt3pfrkkK+w0HOqTFrdXLQB0NVw2WNqGoPRjdD5SpYL1M/ICWeAH+oE5Dbykj5EsYx8HqSogh18dA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4367
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10254 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 adultscore=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202100083
X-Proofpoint-GUID: gioPyfLOzS3tSnc4yuLFhtLjPX77-L_f
X-Proofpoint-ORIG-GUID: gioPyfLOzS3tSnc4yuLFhtLjPX77-L_f
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Feb 10, 2022, at 8:28 AM, Benjamin Coddington <bcodding@redhat.com> wr=
ote:
>=20
> On 8 Feb 2022, at 17:39, Steve Dickson wrote:
>=20
>> On 2/8/22 4:18 PM, Chuck Lever III wrote:
>>>=20
>>>=20
>>>> On Feb 8, 2022, at 2:29 PM, Steve Dickson <steved@redhat.com> wrote:
>>>>=20
>>>>=20
>>>>=20
>>>> On 2/8/22 11:21 AM, Chuck Lever III wrote:
>>>>>> On Feb 8, 2022, at 11:04 AM, Steve Dickson <steved@redhat.com> wrote=
:
>>>>>>=20
>>>>>> Hello,
>>>>>>=20
>>>>>> On 2/4/22 7:56 AM, Benjamin Coddington wrote:
>>>>>>> The nfs4id program will either create a new UUID from a random sour=
ce or
>>>>>>> derive it from /etc/machine-id, else it returns a UUID that has alr=
eady
>>>>>>> been written to /etc/nfs4-id.  This small, lightweight tool is suit=
able for
>>>>>>> execution by systemd-udev in rules to populate the nfs4 client uniq=
uifier.
>>>>>>> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
>>>>>>> ---
>>>>>>>  .gitignore               |   1 +
>>>>>>>  configure.ac             |   4 +
>>>>>>>  tools/Makefile.am        |   1 +
>>>>>>>  tools/nfs4id/Makefile.am |   8 ++
>>>>>>>  tools/nfs4id/nfs4id.c    | 184 +++++++++++++++++++++++++++++++++++=
++++
>>>>>>>  tools/nfs4id/nfs4id.man  |  29 ++++++
>>>>>>>  6 files changed, 227 insertions(+)
>>>>>>>  create mode 100644 tools/nfs4id/Makefile.am
>>>>>>>  create mode 100644 tools/nfs4id/nfs4id.c
>>>>>>>  create mode 100644 tools/nfs4id/nfs4id.man
>>>>>> Just a nit... naming convention... In the past
>>>>>> we never put the protocol version in the name.
>>>>>> Do a ls tools and utils directory and you
>>>>>> see what I mean....
>>>>>>=20
>>>>>> Would it be a problem to change the name from
>>>>>> nfs4id to nfsid?
>>>>> nfs4id is pretty generic, too.
>>>>> Can we go with nfs-client-id ?
>>>> I'm never been big with putting '-'
>>>> in command names... nfscltid would
>>>> be better IMHO... if we actually
>>>> need the 'clt' in the name.
>>>=20
>>> We have nfsidmap already. IMO we need some distinction
>>> with user ID mapping tools... and some day we might
>>> want to manage server IDs too (see EXCHANGE_ID).
>> Hmm... So we could not use the same tool to do
>> both the server and client, via flags?
>>=20
>>>=20
>>> nfsclientid then?
>> You like to type more than I do... You always have... :-)
>>=20
>> But like I started the conversation... the naming is
>> a nit... but I would like to see one tool to set the
>> ids for both the server and client... how about
>> nfsid -s and nfsid -c
>=20
> The tricky thing here is that this little binary isn't going to set
> anything, and we probably never want people to run it from the command li=
ne.
>=20
> A 'nfsid -s' and 'nfsid -c' seem to want to do much more.  I feel they ar=
e
> out of scope for the problem I'm trying to solve:  I need something that
> will generate a unique value, and persist it, suitable for execution in a
> udevd rule.
>=20
> Perhaps we can stop worrying so much about the name of this as I don't th=
ink
> it should be a first-class nfs-utils command, rather just a helper for ud=
ev.
>=20
> And maybe the name can reflect that - "nfsuuid" ?

The client ID can be an arbitrary string, so I think not.



--
Chuck Lever



