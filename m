Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA956616B9F
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Nov 2022 19:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbiKBSHh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 2 Nov 2022 14:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbiKBSHg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 2 Nov 2022 14:07:36 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BED92EF5A
        for <linux-nfs@vger.kernel.org>; Wed,  2 Nov 2022 11:07:35 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A2HWBFD012640;
        Wed, 2 Nov 2022 18:07:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=dn0k9QbcRvKV4GRUQAbOT3/C5jBeT8PERlldkjcbFFM=;
 b=Bo2V4f72S0hXZ9hNdCpGt4r7dlsGB1/q1IN7WWM+5P0hh47DB+2mPej6cserpvMGPOFj
 xf5gPUEHI98GvmFePTkRJjfgdrIOpZmFvVfQAIjOnpJWfmqWqqchxkbpyXAFHcmXCCig
 AR/pre50mZ1/3b2CEFbqSdhNs+DlT1b4Ihx+9hNtZZJMqK64aG1QmhEKLZdX5Y61xBx7
 GYrXjCHFh5eWxjvsXjsJisRfsmpCky88zJi16C2vZmZqV8y1gc6oQy6Ar2GrTcv8omQF
 T1aYPitjNrLljHHPGZY/MgT0utSCtwLSxtSDuRvfnT9sWAGcnC4xVq1h7whcqE78p97p 7w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgvqtjraj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Nov 2022 18:07:28 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A2FmEUB001254;
        Wed, 2 Nov 2022 18:07:28 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kgtm5tm8d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Nov 2022 18:07:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QW/4Y3m7Wc0L3DP4RR6sOInnf3wMnwkD6bmefjdGn/C0LAbgs65Lm4b24+LAGyLKoSG3isF4qPVZOaA+XEWz8TW7r8397ZxWxHJdgIR5WkDR3q3X8o2Cj4y51KZTfCVVDSIdYSQ7/5n8wQge3LWin6g8if7/W3mYwHgA5soYJFuK4ovC0dr+fn1jna0cyAoJSNL5CdauMc+VurQF8kaDUCA5Ttlot3DPULB26YtlR3XKRVG9vyAYvtxmj91EQpdOK24QjakxJXwSKB/QY7yPza03CdHVMKU3VCwzpaogFL2iALtZAynUTfcFE9iD1aZ5tryB+KeMKmi5qeM1Tqruvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dn0k9QbcRvKV4GRUQAbOT3/C5jBeT8PERlldkjcbFFM=;
 b=eUaR1umd/rl/q92606ic7TryvXyQ/FCLsx7Ewkt8H/z41aP1mT4k7ZsmgMUN3DpJsK/7xn9ybA+XI8LIXz4NPQbmo01kVfr00+6Ff1lNVdFEv8woUFvThYNNLFIKAbS35bLXlYYPg7yE6Hb5aH2+sphwWQg1smHfpret4NO7xxhUccP3BQTz6cLsgdF0NXvaVYFHBuNlne6/QHyKO/fcHOylEeqwTygvCV3sSIuCOmqAyLOQjEdzwytvmP6vQL9ar6eA6wrN0vSuw7JRQAwAHdN2r4iA2FdS1atf7otNCc1Z3ErTaQdJpCvvDGwDbAIXr8HnTl484JtsN9kawdhYgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dn0k9QbcRvKV4GRUQAbOT3/C5jBeT8PERlldkjcbFFM=;
 b=pa1jprMJzs7mTK7ynjC5KLsf7FNgVYjjuCBAbhCfzym0EmdjVhl2nZ4LgAtO9+HPGCPyP8wR/DybZI4ljF5MluUpSISh3QF9nVGiKQyMXPBE96MlK9oXqWDwIrqUvBugRSU13Xp6RxsOEwjdudUWoYQrcfv038mBlUPXtgILcw8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BLAPR10MB4948.namprd10.prod.outlook.com (2603:10b6:208:307::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Wed, 2 Nov
 2022 18:07:25 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a%3]) with mapi id 15.20.5769.021; Wed, 2 Nov 2022
 18:07:25 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Neil Brown <neilb@suse.de>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v5 3/5] nfsd: rework refcounting in filecache
Thread-Topic: [PATCH v5 3/5] nfsd: rework refcounting in filecache
Thread-Index: AQHY7gDKf+UJMCSoA0e+WwOAy53hT64qlIAAgAAEOACAAAdXgIAACmQAgAEyK4CAABNLAA==
Date:   Wed, 2 Nov 2022 18:07:25 +0000
Message-ID: <4E9232A2-E4C0-4877-96B1-5D745085BB05@oracle.com>
References: <20221101144647.136696-1-jlayton@kernel.org>
 <20221101144647.136696-4-jlayton@kernel.org>
 <166733783854.19313.2332783814411405159@noble.neil.brown.name>
 <bb8a4e623371ad4ac9d49f2cbe0d4880e8ba52ef.camel@kernel.org>
 <166734032156.19313.13594422911305212646@noble.neil.brown.name>
 <4ed166accb2fd4a1aa6e4013ca7639bc2e610e37.camel@kernel.org>
 <db00762c5e0b983c72bee2c6bfa4476b2090a942.camel@kernel.org>
In-Reply-To: <db00762c5e0b983c72bee2c6bfa4476b2090a942.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BLAPR10MB4948:EE_
x-ms-office365-filtering-correlation-id: 8b0c1502-6899-4ec5-5483-08dabcfd1898
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kFx04i5/YTV/4aVHnmplIaNojjWaZwgSWme9K7EYZmWBcBvPX4oyIS4SXvR9FnBkXeuSQ7rVsrruEqQCEmg74V1vt5hMpnU2Jpq6MqHLiFXXB+g/cU7uiCvGYRWPR/iH3krn6ibuz06ImzYaQqgaf74HJC5vOhkylNk9mGLyN/iJCxu8K//JBAgVZHGp2a3jS/5fZZSz4lRGuLlDlwAzQH951jsAkFZUeYbyvy5SX7pVmDuS8GmJHhiiroElQECg5rxaJzKOGWHC8xgNuAUDA6Y6qZYmkDQvOfETrU/gkou544+WmNCTltWas+5ZsS5yRnWWUMSsCLMBosbrp0DcYZK91GXRzfEs788mpko5xmxI8aNbKOB5xdpkS0Qp4MUg0KRuiS6Bx4yY7M9sFyQJV97YgFbjvZibbM+IxWKynQWZzVF3GddhUlDj5BystbMo2B4aU8Ch9cvzaNhlPCDE3SUleEo5KhjwfJkZZOPB2n6faqeSfNcPDICu+Jpc2HhTt7DC/N/L76pxOMfxZxKKdmXQwUA516DetgE2LrIbJz5YsQ1TO+F2U4DVaviEWGEgzkqw8aKD7tqQ76hXQjZHpc9EvaW/BrWFscCbmoCYjIgzV78bJAjVOVHsUXDRsDqJX0A8MZsnyR5C2ke4+SGK0xfbMc/gxFkuiKOAni8qv0A0th7XaO9ySOGZEnT4tuZd/j4w3axH4KzJmR2u7NTDwx1zl0Ysckka1Ibs6pbxnk2k/yakukaYCAtfYJrU/36pbrwI6N9Vg/6J6/T24gIgGipDWObmUsw+I+K/1BQwYwE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(396003)(39860400002)(346002)(136003)(366004)(451199015)(66899015)(36756003)(8936002)(2906002)(6506007)(5660300002)(6486002)(316002)(71200400001)(8676002)(91956017)(4326008)(66476007)(66946007)(66556008)(66446008)(64756008)(76116006)(122000001)(38100700002)(6916009)(33656002)(54906003)(41300700001)(86362001)(38070700005)(6512007)(2616005)(478600001)(53546011)(26005)(186003)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7guzHWCnjnWsxwXLa6SamJ2u0YUtLYy8Xd/ts36UqE5myDJAweTWgAwkY1c3?=
 =?us-ascii?Q?efAvaiFAW01MLaaAHH/fW+Y1Gem3stivYLzEpfs0dFCZGVvaYh+fsiEvLRpg?=
 =?us-ascii?Q?/OfwpzVTtcXIGIo1+W9BLe0KkihK1B2EYdYYK8Or5NmH0alqvJKI0FCum5VY?=
 =?us-ascii?Q?9u8HqOspraCl5OnKuEBi0f7F/r67iCd7FwuRVNQfTt6bYof786hs/1qw+YNW?=
 =?us-ascii?Q?yID8vVERlU3vJ1biBnYHgx8KeWz9qEnG9q8Z8AQGJdZ6DCuydwl/NcpX9/39?=
 =?us-ascii?Q?WXuenSyqsmC9eCiPVnzm+tJWT04l05ihjTNIlqhZWybmvACsohbGYJ4t8ldw?=
 =?us-ascii?Q?DQ6t2hscT9uc1ACXYcR0eU0jsZQb0MBx0Jij00jjxEiS4K9qEvKKdG5Rmx8P?=
 =?us-ascii?Q?5dlb3Tc7HzjRO9IPB41uh+4QKkj9DGcg1xecprjNq0OhkOAgDodmlEMc84Rt?=
 =?us-ascii?Q?2IOONi4sgro8U/LaWXt6IdSpjehLaoduuPQtWyC60L1csnmt7WUgxHpVFR03?=
 =?us-ascii?Q?tP6EpCCmXZ+j6SHAw8mICY0CfdI6Zvua4TIar6aTSyC2DxrQs/a4bv3k/0rb?=
 =?us-ascii?Q?vfRDSu1hZnyvdueLQcG60NaBlZorsUIs/FUxTmwb1SE+hzQdps+xEBkQ2n/q?=
 =?us-ascii?Q?boV2M8gvh00wAsCYk1OJGFej55XSf2ojugdsjRTblC5U/zRT++l0SnW3LJSU?=
 =?us-ascii?Q?lw9G7aNtdfcfl/yEUvRy80qi8XtpMZq/SCzvWlSQL+K6i8fpGWSoh0GJ+U7C?=
 =?us-ascii?Q?HyBiII3Xm6jQ6qI4Ph+8ZovD5L3J1ExSSDIRcZfRv0ga/OylKh33n/+AjzjH?=
 =?us-ascii?Q?c3HBOBlfLXU55WweOKxq4J2yVOgoN2Dw91U5JPH5iOUfM5aMyYJI1ONAbO3R?=
 =?us-ascii?Q?r/4WXVbOAflv8rrzJT5Ksu82Eh/HaQqU8KylDzkaIaPWpCz43A4JVYMff5P8?=
 =?us-ascii?Q?iFLiQFlXqmvXB77c54AChON8OX4sonet39fIiiJxdpy+dw+w0AadiEEF+OHY?=
 =?us-ascii?Q?xcXwd3sFYCeLN8Cjvtit6yEaMKAkOA5yXR3dDqbXlR7y7qlr39icexoSswGb?=
 =?us-ascii?Q?W+IpKyk4rd1chZp2CyX6PHLGe/zg7p7hl8Z1A66VVwwfwRBddjPeSn8lVGJx?=
 =?us-ascii?Q?WgO7n5qVSXdNsWOCHk1WAQiuE1LERZkA8W7EOgaSlF8r5s8d4fBmoeij2T6q?=
 =?us-ascii?Q?Mq6zwv/VqSWH1Y79dL2+hcKo4m3mxhiAHfhQMY2dEslRChGAo2uObVk2/7am?=
 =?us-ascii?Q?b5g2UgurYTEp+0j0w79YBCixcV8XshtZiAWQsCFBRjv617/GPjmRNEZRb/7h?=
 =?us-ascii?Q?dtnFcj2CJWJYo7nh1gdj+KuyFptVih3r1UKlTA6jYLHb2aFQFytPWeeAgqQw?=
 =?us-ascii?Q?F+wXpjeG1I1q2GeS2T1wmJIAaQcRoElm0duWhQLZ3alWJr60MkGTrSgSieyE?=
 =?us-ascii?Q?IaPhpN1G9cfyVQPFKmLZymql4X7cNRfMcaS9dHTIMRVHOA+RsvYpxhaNfUvg?=
 =?us-ascii?Q?Xm593tz388PuQCZPlMOgtsnaa+hFNI8AiL31DP4sd/4yLUcmc73vuoWRws85?=
 =?us-ascii?Q?nZa20mdryRLidiCPtSkxVl0zYwGC57YDKXJ13j1hb/RcHplDr5UrCd96J6hL?=
 =?us-ascii?Q?Kw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EBE2AB0479193A4F9F91EE4C9ADFEBF5@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b0c1502-6899-4ec5-5483-08dabcfd1898
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2022 18:07:25.1574
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5b5Z+ovz7LjMZr1MRaow1OPOpio9PEaZhGMaUDZGVq3RfLgOuisL8LevtREZQH+SpIoiUXORJfExYEYKGI0yTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4948
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_14,2022-11-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211020117
X-Proofpoint-GUID: x_BYApeYwSQa8LA7czdS9luJeJo7JHaL
X-Proofpoint-ORIG-GUID: x_BYApeYwSQa8LA7czdS9luJeJo7JHaL
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 2, 2022, at 12:58 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Tue, 2022-11-01 at 18:42 -0400, Jeff Layton wrote:
>> On Wed, 2022-11-02 at 09:05 +1100, NeilBrown wrote:
>>> On Wed, 02 Nov 2022, Jeff Layton wrote:
>>>> On Wed, 2022-11-02 at 08:23 +1100, NeilBrown wrote:
>>>>> On Wed, 02 Nov 2022, Jeff Layton wrote:
>>>>>> The filecache refcounting is a bit non-standard for something search=
able
>>>>>> by RCU, in that we maintain a sentinel reference while it's hashed. =
This
>>>>>> in turn requires that we have to do things differently in the "put"
>>>>>> depending on whether its hashed, which we believe to have led to rac=
es.
>>>>>>=20
>>>>>> There are other problems in here too. nfsd_file_close_inode_sync can=
 end
>>>>>> up freeing an nfsd_file while there are still outstanding references=
 to
>>>>>> it, and there are a number of subtle ToC/ToU races.
>>>>>>=20
>>>>>> Rework the code so that the refcount is what drives the lifecycle. W=
hen
>>>>>> the refcount goes to zero, then unhash and rcu free the object.
>>>>>>=20
>>>>>> With this change, the LRU carries a reference. Take special care to
>>>>>> deal with it when removing an entry from the list.
>>>>>=20
>>>>> The refcounting and lru management all look sane here.
>>>>>=20
>>>>> You need to have moved the final put (and corresponding fsync) to
>>>>> different threads.  I think I see you and Chuck discussing that and I
>>>>> have no sense of what is "right".=20
>>>>>=20
>>>>=20
>>>> Yeah, this is a tough call. I get Chuck's reticence.
>>>>=20
>>>> One thing we could consider is offloading the SYNC_NONE writeback
>>>> submission to a workqueue. I'm not sure though whether that's a win --
>>>> it might just add needless context switches. OTOH, that would make it
>>>> fairly simple to kick off writeback when the REFERENCED flag is cleare=
d,
>>>> which would probably be the best time to do it.
>>>>=20
>>>> An entry that ends up being harvested by the LRU scanner is going to b=
e
>>>> touched by it at least twice: once to clear the REFERENCED flag, and
>>>> again ~2s later to reap it.
>>>>=20
>>>> If we schedule writeback when we clear the flag then we have a pretty
>>>> good indication that nothing else is going to be using it (though I
>>>> think we need to clear REFERENCED even when nfsd_file_check_writeback
>>>> returns true -- I'll fix that in the coming series).
>>>>=20
>>>> In any case, I'd probably like to do that sort of change in a separate
>>>> series after we get the first part sorted.
>>>>=20
>>>>> But it would be nice to explain in
>>>>> the comment what is being moved and why, so I could then confirm that
>>>>> the code matches the intent.
>>>>>=20
>>>>=20
>>>> I'm happy to add comments, but I'm a little unclear on what you're
>>>> confused by here. It's a bit too big of a patch for me to give a full
>>>> play-by-play description. Can you elaborate on what you'd like to see?
>>>>=20
>>>=20
>>> I don't need blow-by-blow, but all the behavioural changes should at
>>> least be flagged in the intro, and possibly explained.
>>> The one I particularly noticed is in nfsd_file_close_inode() which
>>> previously used nfsd_file_dispose_list() which hands the final close of=
f
>>> to nfsd_filecache_wq.
>>> But this patch now does the final close in-line so an fsnotify event
>>> might now do the fsync.  I was assuming that was deliberate and wanted
>>> it to be explained.  But maybe it wasn't deliberate?
>>>=20
>>=20
>> Good catch! That wasn't a deliberate change, or at least I missed the
>> subtlety that the earlier code attempted to avoid it. fsnotify callbacks
>> are run under the srcu_read_lock. I don't think we want to run a fsync
>> under that if we can at all help it.
>>=20
>> What we can probably do is unhash it and dequeue it from the LRU, and
>> then do a refcount_dec_and_test. If that comes back true, we can then
>> queue it to the nfsd_fcache_disposal infrastructure to be closed and
>> freed. I'll have a look at that tomorrow.
>>=20
>=20
> Ok, I looked over the notification handling in here again and there is a
> bit of a dilemma:
>=20
> Neil is correct that we currently just put the reference directly in the
> notification callback, and if we put the last reference at that point
> then we could end up waiting on writeback.

I expect that for an unlink, that is the common case.


> There are two notification callbacks:
>=20
> 1/ fanotify callback to tell us when the link count on a file has gone
> to 0.
>=20
> 2/ the setlease_notifier which is called when someone wants to do a
> setlease
>=20
> ...both are called under the srcu_read_lock(), and they are both fairly
> similar situations. We call different functions for them today, but we
> may be OK to unify them since their needs are similar.
>=20
> When I originally added these, I made them synchronous because it's best
> if nfsd can clean up and get out the way quickly when either of these
> events happen. At that time though, the code didn't call vfs_fsync at
> all, much less always on the last put.
>=20
> We have a couple of options:
>=20
> 1/ just continue to do them synchronously: We can sleep under the
> srcu_read_lock, so we can do both of those synchronously, but blocking
> it for a long period of time could cause latency issues elsewhere.
>=20
> 2/ move them to the delayed freeing infrastructure. That should be fine
> but we could end doing stuff like silly renaming when someone deletes an
> open file on an NFS reexport.

Isn't the NFS re-export case handled already by nfsd_file_close_inode_sync(=
) ?
In that case, the fsync / close is done synchronously before the unlink, bu=
t
the caller is an nfsd thread, so that should be safe.


> Thoughts? What's the best approach here?
>=20
> Maybe we should just leave them synchronous for now, and plan to address
> this in a later set?

I need to collect some experimental evidence, but we shouldn't be adding
or removing notification calls with your patch set. It ought to be safe
to leave it for a subsequent fix.


>>> The movement of flush_delayed_fput() threw me at first, but I think I
>>> understand it now - the new code for close_inode_sync is much cleaner,
>>> not needing dispose_list_sync.
>>>=20
>>=20
>> Yep, I think this is cleaner too.
>>=20
>=20
> --=20
> Jeff Layton <jlayton@kernel.org>

--
Chuck Lever



