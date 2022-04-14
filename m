Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 556C850185C
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Apr 2022 18:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbiDNQK1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 14 Apr 2022 12:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359011AbiDNPmd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 14 Apr 2022 11:42:33 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F6638F
        for <linux-nfs@vger.kernel.org>; Thu, 14 Apr 2022 08:26:07 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23EDdI45028178;
        Thu, 14 Apr 2022 15:26:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=SdKUCrAfWaV8SaVPnAeVFKvnAl2Awayc11NILnBOWpg=;
 b=utcZPY2121pRBe78gBgosY9PRgcZokuK8M1imREXnnAg7Zvd5d9T7vEapGHdBejVI3Q9
 lon0IaVEYvoPtWcKDjHbUA4ZgAMDmtqYVSz1bQsn8MuqIqdgN700tMWnMMBJ9MEghSLV
 WJjq5+bPwrVMYJKy93kN9ULF3AJFRHUhm1NOBu6FzUQDZOtXTzkVsVsyuhB8DHkbVyxU
 P9ntfqxy2gpwCdATWZ2FOw85B4fTu32WdMBs/eVIHSpr9X3QXHR2BeNNyrrXqA6LBSFJ
 cjovpeCfruY9DHU6LWh4CpkLLOzn1Z650wsscjSSXm/L3h35Bco5eSwVx7YuoObOP7hr lQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb21a4paq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Apr 2022 15:26:02 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23EFCSso023839;
        Thu, 14 Apr 2022 15:25:59 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fb0k4w4hn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Apr 2022 15:25:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XzTsahyO4WkuFzca0Q5bqRCovrWF3AzOyaCZH+GPnMtji2YwpEUezD5Q5HXwP6EvPF0i+POKycm4n1WyCUD4y85LAkwvsodk1yw5N4A1yMSVZmKwE1icHPzZIWw/XMqLOKrJbc++Na603tGsZXqclLlI79YqAcdSNfqjdQUb0RCNgpcXp/Cl56ujlq6wpSJal/KcEAJFhbvfY4Qd1jHwKdRBACtE6fqlQzHjBW3ixxQb+89ohDB92YWYPgEufhBultY7h6ixWSxZ7R9k4w9uX1ADmINu8JlzvuoQgPUZNXKhulUlwxVKBbD+nmgfI2fCCmiQ0vUj0Kcs5Yk33COYbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SdKUCrAfWaV8SaVPnAeVFKvnAl2Awayc11NILnBOWpg=;
 b=bvnUmKdqfF94zTG4hvwOGW3hctNE3Q2nU46BUP2inIq+G65De6KzJCVHeuK1S1WAv2So0RF8ju4yL9xwxlfTZF4SDb3AU9Jp5tkaFeNcLVv+qpcyAPaKQocous2aLGUEVrUbZvZ9icPghU0jem0vOt/x6QalS5z3FLH79wDLn62WE+kWTQyw/obvGE5/wwdsVzCpkD+N8vVw+KkL9C1nFMz8zuAX3KDTAIuZRuD9bXwWNhF2RNBvGGZTlzBPuy8S4niV1SDTLK5PMWfAMphquC05rKqwm8jwYm2bqWJIuFVOOGgMTblqI2wkm1SaJE3fwBx0yVoQzMa9GYRLVZdy1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SdKUCrAfWaV8SaVPnAeVFKvnAl2Awayc11NILnBOWpg=;
 b=xBYqjd/GVXaipU7xug1Y4RjpLHOY5NKL1mzeRx+zfQWIBCRXVaJGNBSMK84/7+bi4URtcJsT2X/qF0lqN12K0VQNPlnc2InEyl0/xDy0blZ+SB+y63sxAL9gMQ6jpFyZISaMSiCdIz0BGDt7mFjWgNKrJeHiVIKiGYiYD3Yg+Rc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB5533.namprd10.prod.outlook.com (2603:10b6:a03:3f7::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Thu, 14 Apr
 2022 15:25:57 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::f427:92a0:da5d:7d49]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::f427:92a0:da5d:7d49%7]) with mapi id 15.20.5164.020; Thu, 14 Apr 2022
 15:25:57 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] Documentation: Add an explanation of NFSv4 client
 identifiers
Thread-Topic: [PATCH] Documentation: Add an explanation of NFSv4 client
 identifiers
Thread-Index: AQHYTeNKNj3im2ccyUWrdlE9NE+XpKzr2+yAgACIEgCAAmwqgIAAu/AA
Date:   Thu, 14 Apr 2022 15:25:57 +0000
Message-ID: <DCBB40E7-3043-4B57-991F-D1439237C491@oracle.com>
References: <164970912423.2037.12497015321508491456.stgit@bazille.1015granger.net>
 <164974719723.11576.583440068909686735@noble.neil.brown.name>
 <4918188E-9271-47F2-8F5A-D6D5BEB85F36@oracle.com>
 <164990959799.11576.7740616159032491033@noble.neil.brown.name>
In-Reply-To: <164990959799.11576.7740616159032491033@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: be96b089-15bf-4301-be96-08da1e2b12b7
x-ms-traffictypediagnostic: SJ0PR10MB5533:EE_
x-microsoft-antispam-prvs: <SJ0PR10MB5533645528D5640D8D553BE093EF9@SJ0PR10MB5533.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TNAKL4ZW4LQ/Tl9aMeiFOto1XlWkOEBunLWBv72lpc+cOJr7bq6va2f3ZKCyPTAa1UGBWgcEfi5PQ8h3nevMy5PlK0qaclhVIzuiIAC9SLMm6kRVKjzShgrkZj8fYVKxVX8MV21PfCLHOLtBIH1DgQrScmBerauFG6VEcazN9hG02tGYsjVN0IIryqRkHI8tk71Ir5KCrc2sZs6radPswnEEukpbX3ZmEAwJezQpdw4upKYlnN02aq27UUckPCwb5brt/DLPfH9XBId2/QQkT5bKOjzYYhNJ7SZC8fWP/bhsggYvXE9Gfwa+N87LTpuKaJ1cLdTKi9nJ+Knb5OMg3pp3Qg54LqJBak7h8XUzePR/icuKucIFIU3wcPK4V3RWnqGaZ90jkt0lbFOJAgBObRcLThgSBpgRpleankIHY7z0ic/aCvk4iFDfoKBtbUBGA8p6dndmkwNN8cJvy5AI/2MVrs/mNHR+jwRouYgKS2M71uw2MsglZdz5TGzJRowFl0ohu0mtIwqKEoTtAmsJLvi+0WodzZ0cTMmHhSnv9uJ160zu3MnO7AHFBslPaB86uHdUI2Yu39+c0mhwyMnolZc41aNXNp7dgwHiu3Gl1qQRXFVb2vEawiBSCxdz5NbmctOE4xzAos9EbFjtuHU1rMJuAeJ85LalBFt2XCUeu45HqEiZv/APodUX1ox2BEoRBksjILmXuYvz7kpH/KGlv82yMpbXLiJEjSRBuY+vRClw62pzBCqZXFZzav04We0R
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(508600001)(122000001)(83380400001)(5660300002)(53546011)(8936002)(38070700005)(316002)(86362001)(6916009)(8676002)(2616005)(6512007)(6506007)(6486002)(36756003)(71200400001)(76116006)(4326008)(91956017)(186003)(26005)(33656002)(66556008)(64756008)(66476007)(2906002)(66446008)(66946007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mcagAJMdCCH1hj8h2EHOEucwWBveRBeiSKRzSsmX2bUs2J/0FNoGuNoZlnAx?=
 =?us-ascii?Q?pviCISpSvGBh90q0cI09OrbBqJwYfzL8En1xo6q3wOX1bRDnQjOKC9qH8mIY?=
 =?us-ascii?Q?BsrBBXoDgiEgdeL6qlI6nPkxBXPbHeQUTkrjRoJ0cmFyGFq6yHplpwqcqYca?=
 =?us-ascii?Q?Y7zIR2X2TjgrMTgvUK8vP9NpaFbNJpJ+BSOYYw9n8E8LOBWZO/0UzlbmI3lx?=
 =?us-ascii?Q?u9RIzksndxWpc1mKU50+KnhjbOwzVSAQJH1Q+3jRhS1xQ6dFQoCJnmBYRu7h?=
 =?us-ascii?Q?KIPzzm8yczVdYv5yk6j9B4KRkALpnVwaf4NPipUx8OXOmsECkKNpwH2vczcb?=
 =?us-ascii?Q?pBv+GvZTDkQsXILJ/fLVTPi+TyBNfi/IqgVMbvNGdJCa3m4q2JbAMEgBhCwr?=
 =?us-ascii?Q?s4qzk4LcMOlxhwZzKP8kJipTqY9tr+sc60GYpnSjvUTYImQkjdCqF+7FeCio?=
 =?us-ascii?Q?f0NGTL0R9/dfNpuXFOT/LkQQ7+8BblaRSZHqujN4UJYosws7Xt+VihBkPnF+?=
 =?us-ascii?Q?ACyqMh6ixdXhKXEtUVEvSdFPx/kGPG3GrXwrV/e/mKSr3BZda7ZJAY+tH0KM?=
 =?us-ascii?Q?0PJ9pQtM5wVkM0sCpW2YVDPq+K8nCAAnRIjk+JSGlCr1Xam+4Lm/5jXbhsTb?=
 =?us-ascii?Q?U9dX1v89sKPptdX3mkkstrtpGAFBhX0iqT6Sd6pJ387k9ob3a1Dt6IBiIxf2?=
 =?us-ascii?Q?KdkrOBO8UK9TGaNtAJoJ72up2vTswLm+awEWNNMcXU3ivR0DpbkL0zS9Ktyo?=
 =?us-ascii?Q?7Z4cDQxDpga3MUVsVm0tO7Oz2z6y3p5kfVzXUczvXKXGW0vNpAYOz4rvrKRT?=
 =?us-ascii?Q?blTuaVhd3NZre1ZUwdALu+bI93CxrJjrVtD/UkwbSZA17BKJj+1PYe+0SRuc?=
 =?us-ascii?Q?ke56pw7ro8GRDsRCenDNLwdUgAsaAw8+UuH6tmDsDjKcJW+4dGXxIEXOfj+T?=
 =?us-ascii?Q?2S6Us6uNYSx0UuPJafUSorh9W/iiezy9vm+74jQ2y1JE59MHLQVL14WWzyub?=
 =?us-ascii?Q?i0W9Pg0+TJUMSo6dlFnGIT7birYtCpqPnrMIs0ACgarDDKYDI2bMLrx0Z8N0?=
 =?us-ascii?Q?jlSYfrSUf4B2kr//uD5Uwu0xwW6lBq0gXadRuw3L2tHrZ7t1sy8GRTVaxURw?=
 =?us-ascii?Q?O2NfaLbgr3ijhoUW83HQmY6xe5Z0iPGGPZaN9Qji0f6uQkvabwkFSbn5w247?=
 =?us-ascii?Q?yW/nd7Kb0MHUNptqEe6TOnryAZJBasId5OP52nsCStz4envIWQxDVsWmusmw?=
 =?us-ascii?Q?/hBcROWyHnsW4Ai3ItTnevkRS5Dk8NhmPA3x3flqHiLCjRXJbbMLlgwmIRQu?=
 =?us-ascii?Q?yfhRhOVVo2Qy7jgDIWisaBn03oqOs1F4AN8nAsRn9xb0VN/AVlw4yCsqtEfT?=
 =?us-ascii?Q?hkXQavlZiTFDzOJpbvEVHUdzB5z5IlfZNuL+wAHMkCiEYFrwT5iwH5NhH0OV?=
 =?us-ascii?Q?fU5x/aMSGbgzAkv/GD1SQ+W0gxv4tWKxoi6B3CXudM3yuPPzQTKlbaelaOO/?=
 =?us-ascii?Q?9YfO2rIoh+dKKzws/LXI1+k5sRX1W6G8w5PJpvnF4cfPsjngMi9vZXdQw0pE?=
 =?us-ascii?Q?LxN8HCX6iI5cAunXvODb/oOY1OM2XeVFFkx/2Kox1g99LfzezRhBUC40mUco?=
 =?us-ascii?Q?lIK2vZlU9dSXG2JVUP3h//uPRV9dd8J22VaeeGPxWSHXFzyW98BbFNefrib6?=
 =?us-ascii?Q?i9Pg8XedxynQPaNedkOBjb4QKXg1iDobx0JjR1Y8RDYiCbu1Wx7XMNdQAmdo?=
 =?us-ascii?Q?UW86ahvd+FjM4uoYUw+EHl/E+z9oC5A=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <014DA7E5A81BF943801B88A4894E7153@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be96b089-15bf-4301-be96-08da1e2b12b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2022 15:25:57.1867
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mpz0XGii7c6zV+JLxyBwxv0eWARDl9440gZz1u/0zDUeLMMn5V2Dnjin06jqQECw2CFqbfPHMtazxZGHT7IhOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5533
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-14_04:2022-04-14,2022-04-14 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 mlxscore=0
 bulkscore=0 phishscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204140082
X-Proofpoint-GUID: N-BFsjVZTK1yc7TbnGhembPfNt4G2Ba8
X-Proofpoint-ORIG-GUID: N-BFsjVZTK1yc7TbnGhembPfNt4G2Ba8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Apr 14, 2022, at 12:13 AM, NeilBrown <neilb@suse.de> wrote:
>=20
> On Wed, 13 Apr 2022, Chuck Lever III wrote:
>>=20
>>> On Apr 12, 2022, at 3:06 AM, NeilBrown <neilb@suse.de> wrote:
>>>=20
>>> On Tue, 12 Apr 2022, Chuck Lever wrote:
>>>> +
>>>> +If a client's "co_ownerid" string or principal are not stable,
>>>> +state recovery after a server or client reboot is not guaranteed.
>>>> +If a client unexpectedly restarts but presents a different
>>>> +"co_ownerid" string or principal to the server, the server orphans
>>>> +the client's previous open and lock state. This blocks access to
>>>> +locked files until the server removes the orphaned state.
>>>> +
>>>> +If the server restarts and a client presents a changed "co_ownerid"
>>>> +string or principal to the server, the server will not allow the
>>>> +client to reclaim its open and lock state, and may give those locks
>>>> +to other clients in the mean time. This is referred to as "lock
>>>> +stealing".
>>>=20
>>> This is not a possible scenario with Linux NFS client.  The client
>>> assembles the string once from various sources, then uses it
>>> consistently at least until unmount or reboot.  Is it worth mentioning?
>>=20
>> Neil, thanks for the eyes-on. I've integrated the other suggestions
>> in your reply. However there are some corner cases here that I'd
>> like to consider before proceeding.
>>=20
>> Generally, preserving the cl_owner_id string is good defense against
>> lock stealing. Looks like the Linux NFS client didn't do that before
>> ceb3a16c070c ("NFSv4: Cache the NFSv4/v4.1 client owner_id in the
>> struct nfs_client").
>>=20
>> If a server filesystem is migrated to a server that the client hasn't
>> contacted before, and the client's uniquifier or hostname has changed
>> since the client established its lease with the first server, there
>> is the possibility of lock stealing during transparent state migration.
>>=20
>> I'm also not certain how the Linux NFS client preserves the principal
>> that was used when a lease is first established. It's going to use
>> Kerberos if possible, but what if the kernel's cred cache expires and
>> the keytab has been altered in the meantime? I haven't walked through
>> that code carefully enough to understand whether there is still a
>> vulnerability.
>>=20
>=20
> I don't think id stability relates to lock stealing.
>=20
> - global uniqueness guards against stealing
> - stability guards against misplacing locks during migration ("stolen"
> - seems an inappropriate term as no entity an be blamed for stealing).

An entity can be blamed: the client didn't adequately protect it's
locks during a migration or reboot recovery. That permits other
clients to lock those files instead.

The issue I was most concerned about describing here was principal
changes, not co_ownerid changes. But if either one changes, there
is going to be a potential problem.


> Certainly stability of both the identity and the credential are
> important.  If that stability is not provided then that is a kernel bug.
> As you say, ceb3a16c070c fixed a bug in this area.
> I don't think this document is an appropriate place to warn against
> kernel bugs - that doesn't fit with the purpose given in the intro.
>=20
> I don't know know if the credential can change either - I hope not.
> IF the credential can actually change, that would be a kernel bug.
> IF the same credential cannot be renewed, that is a separate problem,
> but should be treated like any other credential that cannot be renewed.
>=20
> I won't argue strongly against this text - I just don't see how it is
> appropriate and think it could be confusing.

Well, it seems like this document is perhaps warning against something
that is not likely but still a risk. The warning doesn't seem to cause
more harm -- rather it seems like keeping the principal and co_ownerid
string stable is perhaps a little too restrictive, but that isn't a
constraint that introduces more risk to data, IMO.

I think we can agree on the initial text for this document, and admit
that it might need some editing as we go along.


--
Chuck Lever



