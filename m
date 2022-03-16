Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6582D4DB377
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Mar 2022 15:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356728AbiCPOla (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Mar 2022 10:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233445AbiCPOl3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 16 Mar 2022 10:41:29 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C22C56430
        for <linux-nfs@vger.kernel.org>; Wed, 16 Mar 2022 07:40:15 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22GCo82m003437;
        Wed, 16 Mar 2022 14:40:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=e8L5ZmKaazGM+B8J2uVDf+XKzkzrsvdDUOXRyr5waYY=;
 b=lfQKl5j21uxMmq+/kUY1S2OAhmP3NUOw/k7Ziiba2dahOtB1b8TwRtLKQrGHZj4sjo6D
 vA+oVmdAoHW1zffF5rKNiChCzv4QnXNc7k82i7RjqZQQatLbu70awijqnu1Gc0bGirKh
 /c7tpK2xeIxJOJL6JklIEqqidqHAaLqZ7mQCwvP9q5S/hDMBuOta3WxkFoWleGl1xu4j
 T1/uj/K7QXFKpiDifV1SZ9S61KH5JuY36orGceMQaQx6a7GFwOitzZVv3QSmS/y05ZqJ
 ke9cYcbpO+9lLBMu4jODQdW79V3Dc2tidevCeUlZDHrSD8Z0j/sMtbWMkCR4qgMyfy9I tw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3et5xwp5um-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Mar 2022 14:40:09 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22GEa3oD150084;
        Wed, 16 Mar 2022 14:40:08 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by aserp3020.oracle.com with ESMTP id 3et64kq8k5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Mar 2022 14:40:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CHPr9zn7MfupyZTgJMHkbZQ1J7tKxJ9GL4a+D6HIlkFZHwWXnszaQZxQbyARkJugM5plird+M8A+twyH3uIEQlTqAi+gFdauIoGTGVWwb0ZgsJmtvKm1B0xioV05NGH6rss6x8IF1bSzGnl5LE0uikFMUXXUbie8Bw7SFeyfZu5fTcnUlX6MgxVKhdL9P7CltcrBowbgkuPolP7nK1568wqa0W/FJgjx/Q/jAghvFNjuE7Ja6RDzH1mb9tdWFAWw6hFdzYwEVqxzst9Z4OTCi3TByuUfUYEvGWSfKTxIWCum159qHYDKykBm4JitJPgDvC8nBNOg1CadGBQiM2HUHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e8L5ZmKaazGM+B8J2uVDf+XKzkzrsvdDUOXRyr5waYY=;
 b=mjwvQdyVjgcPyuvKIVPUQp5QD6RKauIt8cnAEDmcCNZ9s9YYaAXDEriYpA4YELpxaIRO4rNRJ2e7SHl4xe+WcQYHfdQ86fBVXFD/5qxsz9TKLnknpLbAhQZNZPA7o+ywgQJZZq2fSi+CjYQWXocdwhor9Do5Hf7suruVRD7Lv2mIVqx8FnTfj0FU7Z1DrjRqgR/XpULZJjjSe/RIdyH8DlRDVG3m/05MAY7yRphwWaY0YMcaDWam+bTU2rvWC4Fi//SV6DVuo2kiSlV+FvYU+fX//ZHRhh6jakLroCtQZuyUCg+sGD8Xy+EgzWXjCkzSbNZ7xhiuZsLQtrJT0KNdRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e8L5ZmKaazGM+B8J2uVDf+XKzkzrsvdDUOXRyr5waYY=;
 b=rTRTvy25Mqwfd6gNTVHZsoqWDKTvPzkoeniVH4pIus/ZtBMw7HJXuRyfBgz/RchkVlR1y+gekuJB5stz0oWTFPdGBoBzFlR0PURfQzYDzUiq/Kd/p+LxMjuLDEmYVfYHSY2z9DvqGYOFMLI7D8mE1kuHyk/23XpBs7aojvD1pYY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN6PR10MB1714.namprd10.prod.outlook.com (2603:10b6:405:7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26; Wed, 16 Mar
 2022 14:40:06 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::94c5:42b1:5147:b6f0]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::94c5:42b1:5147:b6f0%6]) with mapi id 15.20.5081.015; Wed, 16 Mar 2022
 14:40:06 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Benjamin Coddington <bcodding@redhat.com>
CC:     Kurt Garloff <kurt@garloff.de>,
        Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v1] NFSv4.1 provide mount option to toggle trunking
 discovery
Thread-Topic: [PATCH v1] NFSv4.1 provide mount option to toggle trunking
 discovery
Thread-Index: AQHYKNyvQiH+fo5gFUC0apKHyPss06yhz+cAgADnKYCAAirnAIAdMhGAgAAhsoA=
Date:   Wed, 16 Mar 2022 14:40:06 +0000
Message-ID: <40CC442E-C228-4C66-A2F0-DB850DBC5EC5@oracle.com>
References: <20220223174041.77887-1-olga.kornievskaia@gmail.com>
 <CAN-5tyHy_+tBfv3PuD0CBwHbppHo3pRNwo0O9xRGjZxK0-rOjw@mail.gmail.com>
 <a494ba2b-7e2c-bcad-bac9-12804b113383@garloff.de>
 <B476B883-D5D4-4112-BB08-6D9172C5D335@garloff.de>
 <8849D8CD-0720-40E2-A752-1C9AADC93C55@redhat.com>
In-Reply-To: <8849D8CD-0720-40E2-A752-1C9AADC93C55@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a1376d78-9ad9-419c-e03b-08da075add01
x-ms-traffictypediagnostic: BN6PR10MB1714:EE_
x-microsoft-antispam-prvs: <BN6PR10MB1714EF8FECA43CF029894A4993119@BN6PR10MB1714.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MBeM7+7Kd0jPXTUjXCYE6ngLib2vfIt8IJr5SVCLqBsfS6LKZe0vQtBZ9krvuoODX2MSoTmfS2qKijJb0QV0Wwz6FbP+tIF02k6Pz/6JUkdtJpIOyk1ujCBUBggsDypZwN5Bdu77fsfo7s8CFJOsTioT/iEocKqIQOr8yEHlItx2pVXLfj8GGapiNq1gPYykhK55drW3XruU0f56UNJKn36XTY77i/yUzeHjCsWVqw+Z54CBXVUyTysc69geJIAtoE+Z6MnrhTx3qPsK1WzElF03BwuTjNpLesxaCipBCuW3EeInOfEpMjC4KKyvrVLvy4D3EI7TmbIxJ+63DuVCmMWSpaEXLQIy/rMRkAtY8XGoi71lkZA8GfevPHihMECAtkVKDW6o1dLX6vlq4Gfb7425qHcNMKpFXdzf1eyS8Y/MzGVKJWvEJsasWwnFiqI28NzlsNoJMiy/sD/vyySrfGliGvby9eBZsMnxkynA4/aZKoebJYzH0Koa06pNMcReYHxilqJ4d4o/2RHT2p9PnzWjfULQSmUac2M5wgrWhhEIfOawXeMNuXn3rRQZlFaUCwxmR9RO6a/hiYnR63LT8Ze7NwOEaPYJcclwDz5WK+R+DX4Vp0RhFPA6WW53Nznilfx77iD2Ir5x/OFvzrLxW8JgzG1KZCmdc3CDEbUd/H20tt7EyhJA/37GvdmjeH+S4Pmdho163IZmSRKaQsu7M0JzM+Bv/7hbri9mcSa6fK6wS/j5xqqM9GJ+ZZtQFeCZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(38100700002)(316002)(8676002)(122000001)(26005)(186003)(4326008)(71200400001)(83380400001)(6916009)(6512007)(33656002)(86362001)(54906003)(6486002)(8936002)(2906002)(38070700005)(5660300002)(6506007)(66946007)(91956017)(53546011)(64756008)(66446008)(66476007)(66556008)(508600001)(76116006)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hHIauucNfJbs8Jtr4ZjsqH/5Qzll7RKRdAq1CTtZQ8y8IjbkpO/sOdbTfufe?=
 =?us-ascii?Q?1RBG8sbFkK+5HsPAb7U75zarjc8+1C1ykKhWnIY6GZZ8/FFEREPEfPOwlE9X?=
 =?us-ascii?Q?fo183TG0J3yq1cMUFKwRvUM57NLgVSk/dioU8vH9urqUpzV+S3xp3VgArnGv?=
 =?us-ascii?Q?3dHAuPK0/X0fBFi47j6x77KTBbH5tqtFZyHUCdPZHG2WCiSoV3oSDYEHfL+a?=
 =?us-ascii?Q?wXdW2yZnk1lFOAwhXbmtdCMS/bKE7Z5kAP1egL8YkFYTgiCxBMWcr9SEmMhr?=
 =?us-ascii?Q?xmYmAmPYnseoN5eoyTZOhgzJIYE7LXs7QsKpzakGkKlUSvoGjmGlfOk33SYK?=
 =?us-ascii?Q?p/QLusDjHxIdAZt7SHgHLGQHhpz3LHmomtw/7hV34YP7uxAq/LPsRWS9Wob2?=
 =?us-ascii?Q?sTfwD/Me6Qau3918rvQI2L0oTLh3MJrSMtL9dHqjuvne9+cYTrar29A+nVCY?=
 =?us-ascii?Q?solZQtiZLUZMXt5Rb438CLzKctgxFZmQxXvwKtUJgEQot+aa09jyIVMs+Nkx?=
 =?us-ascii?Q?yxYZ4x9LZRm8GhYF+3YaDeSk1yD6LmpCrKoDaOPsXkyQaig2ZKDnWb8kQWiR?=
 =?us-ascii?Q?9+TVxyH5SBmjCuahtv+0a/S9gEQEWqpVxcI8osgrjVaCLtVH2yTngLWsLbff?=
 =?us-ascii?Q?jDQ6LRsKdxLC5IJYpNEN9IN6rDphyixWRqrQVKkyMEsjBaaDJ4mYKHM2n9oo?=
 =?us-ascii?Q?dCDse1AI/MjPdUATKnZWkQ1eGH+xrDxv6Wu0zTtRi/ZB3jgxwz67eJ8Rf0/y?=
 =?us-ascii?Q?eoMJjExQh006q2w95jwRjQIRSKBf3XEwnLiOcZY2N60ImnPwuZ4FDXcbShQF?=
 =?us-ascii?Q?B2bjQj99AIY8jftKVJ5z/uy9G/YmjmkT9IQEi9MUXLfFdDwAq9ol9CeOmFkA?=
 =?us-ascii?Q?rgZt+Kxwp8Xs339W9Dl/8yGyYh6a9hvYdeVn6bo3mhJBpwkxqNsEEUiqVl8B?=
 =?us-ascii?Q?xYDftl+7HjMSi8e0pFcej+9iaDQ4tFHPzSCEOsc7ztVgj25DfLs2hj44+eKW?=
 =?us-ascii?Q?0g/jylIq84N9tg+2T/YxLoO344o71eRUipfKJDSgONkzMpPruthLpP/za4Bo?=
 =?us-ascii?Q?OXUjgS9mrdIQWCsydEOrpOBVNpvMFfC7zW16IBHymGSjQQmrzSBinQ0OXLYa?=
 =?us-ascii?Q?DPO1sqbpGGB4tzO6o5CcZUR9r9Y+E3ME9bgYv8Ne28hr+6U89p+sOXrbpW/z?=
 =?us-ascii?Q?NtkR/qsxPjiBRrkpcFG06+Pstt0g4dBGeTC0FnngPjkCfYnF9jFWQWhex3fQ?=
 =?us-ascii?Q?NAvi1XWHinPnno409Vecxde78ugPkeHXDbafbESkPs4qPboiHpqPnGQYqPN/?=
 =?us-ascii?Q?uSJL9W+EODHfUHDppQQv89zFjshtpoRxSttU3m+q2+eMu4mKdLBe3ua+nssX?=
 =?us-ascii?Q?2sJ5gVr2HYcH3Ee7NJc3tnNl2t09f4sBAz70PLRLJrjthz0ADujXVuqe+9Br?=
 =?us-ascii?Q?TXtg0eNog6sCdI+FaeKB/Ahq7rCcFziCZDeJhgUCza5Yz7xexvYGsQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9764809AA583A341BABA3A8CB8D23C09@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1376d78-9ad9-419c-e03b-08da075add01
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2022 14:40:06.2060
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PCsjmFGHegpDIiY1WGaDmsMiuJSjCBR1YjpkRq9yyqtOjcX5ATyvF8ZrER31M7X5c1HQZCEgzs45LC2sJQPTyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1714
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10287 signatures=693139
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203160091
X-Proofpoint-GUID: IqRk0NbZgWRUqVc3l40ftUwzxU5T4psV
X-Proofpoint-ORIG-GUID: IqRk0NbZgWRUqVc3l40ftUwzxU5T4psV
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 16, 2022, at 8:39 AM, Benjamin Coddington <bcodding@redhat.com> wr=
ote:
>=20
> On 25 Feb 2022, at 17:48, Kurt Garloff wrote:
>=20
>> Hi,
>>=20
>> Am 24. Februar 2022 14:42:41 MEZ schrieb Kurt Garloff <kurt@garloff.de>:
>>> Hi Olga,
>>> [...]
>>>=20
>>> I see a number of possibilities to resolve this:
>>> (0) We pretend it's not a problem that's serious enough to take
>>>     action (and ensure that we do document this new option well).
>>> (1) We revert the patch that does FS_LOCATIONS discovery.
>>>     Assuming that FS_LOCATIONS does provide a useful feature, this
>>>     would not be our preferred solution, I guess ...
>>> (2) We prevent NFS v4.1 servers to use FS_LOCATIONS (like my patch
>>>     implements) and additionally allow for the opt-out with
>>>     notrunkdiscovery mount option. This fixes the known regression
>>>     with Qnap knfsd (without requiring user intervention) and still
>>>     allows for FS_LOCATIONS to be useful with NFSv4.2 servers that
>>>     support this. The disadvantage is that we won't use the feature
>>>     on NFSv4.1 servers which might support this feature perfectly
>>>     (and there's no opt-in possibility). And the risk is that there
>>>     might be NFSv4.2 servers out there that also misreport
>>>     FS_LOCATIONS support and still need manual intervention (which
>>>     at least is possible with notrunkdiscovery).
>>> (3) We make this feature an opt-in thing and require users to
>>>     pass trunkdiscovery to take advantage of the feature.
>>>     This has zero risk of breakage (unless we screw up the patch),
>>>     but always requires user intervention to take advantage of
>>>     the FS_LOCATIONS feature.
>>> (4) Identify a way to recover from the mount with FS_LOCATIONS
>>>     against the broken server, so instead of hanging we do just
>>>     turn this off if we find it not to work. Disadavantage is that
>>>     this adds complexity and might stall the mounting for a while
>>>     until the recovery worked. The complexity bears the risk for
>>>     us screwing up.
>>>=20
>>> I personally find solutions 2 -- 4 acceptable.
>>>=20
>>> If the experts see (4) as simple enough, it might be worth a try.
>>> Otherwise (2) or (3) would seem the way to go from my perspective.
>>=20
>> Any thought ls?
>=20
> I think (3) is the best way, and perhaps using sysfs to toggle it would
> be a solution to the problems presented by a mount option.
>=20
> I'm worried that this issue is being ignored because that's usually what
> happens when requests/patches are proposed that violate the policy of "we=
 do
> not fix the client for server bugs".  In this case that policy conficts w=
ith
> "no user visible regressions".
>=20
> Can anyone declare which policy takes precedent?

"No regressions" probably takes precedent. IMO 1) should be done
immediately.

This is not a server bug, necessarily. The server is responding
within the realm of what is allowed by specification and I can
see cases where a server might have a good reason to DELAY an
fs_locations request for a while.

So I think once 1) has been done and backported to stable, the
client functionality should be restored via 4) to ensure that a
server can't delay a client mount indefinitely. (Although I think
I've stated that preference before).

I don't see any need to involve a human in making the decision
to try fs_locations. The client should try fs_locations and if
it doesn't work, just move on as quickly as it can. As always,
I don't relish adding more administrative controls if we can
avoid it. Such controls add to our test matrix and our long
term technical debt. Easy to add, but very difficult to change
or remove once merged. I can't see an upside here.


--
Chuck Lever



