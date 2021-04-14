Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4C3B35F61D
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Apr 2021 16:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233601AbhDNOZ0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 14 Apr 2021 10:25:26 -0400
Received: from mail-dm6nam08on2137.outbound.protection.outlook.com ([40.107.102.137]:15105
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233573AbhDNOZY (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 14 Apr 2021 10:25:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZpZGy1jTpiJC5RdcskVSt9pkuwlmLXTrg4WP0yKbR3GmUMr1DzCn4xP0SGDlq7QqrnTnx2b+guh5xu4bteTHwJdEfKCkwY2Syegzywpxt1HJuELqIJqqvEl2LcgqwM6wfKte/b4NkrJL9KjeVxCwlZb6+6XQwmT8v05vS2oqK1vtdkM8if3r+I988Omzx61UuEQ1uGKNDt3o+ujQSexOBYbmIlS0hcj8WcTUfuSiXZxk45mEDWYibQz+KjIZVIElHuVtM+ePs/ryIEzGTp2lQiGIS8APLKrhyRbqIKTWUQI2AWIQfPQ0wMJRVsP8NmH+lREiF8W5tmL+IPLdHjTkBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LR/KKKRW7AWnbJVCAaIjRAaoJODSvuGihM4Smg0Al8s=;
 b=jJin4SjQOPZtB8CiCFIAwphd6Li9PDSMcIUe9scSlzB4FtaRf+rFtxuqTv+N516+0bd0CMjWe32+JdS1kNla3VM5o7PkMFcaSTdRCQSkkoRp0dPgNbYkAk96jgw12NrFhdwITXDI4wgsYe4CgA6d7vvtNgjqHI4U3fBTMgqZkmB1hMiQGM9h5XRYjXXlIDaab0QUpWQrrFL7Q004vIHFTonfZ7IeXgs5/ViB1AxyRx1BnlfosLOVErcQgDquTkacpG8iQIVTT817pcAyHCJP8HIlIxOd5KiDO8u3/SeDrPz5L/BPMKOoPogOuuU13fQ590bFNEWvOlwpDaf77xYwMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=rutgers.edu; dmarc=pass action=none header.from=rutgers.edu;
 dkim=pass header.d=rutgers.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rutgers.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LR/KKKRW7AWnbJVCAaIjRAaoJODSvuGihM4Smg0Al8s=;
 b=SzSW+pBIbXIk8o2/tkuv3Tzit5XSXskDMpZlGgvmD3iDMxC9FEEERc+F26Z7+nosGFPd9M5N7lzyJFKf5CSIeeJNpOfyavK+gNap4jwBJZkIx/3rOhrrbS3LiTC6ltnF2v41qWc9iceRQXSeMMSeMxxOdbfzw6HKzuVsQeDoJX0=
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=rutgers.edu;
Received: from BL0PR14MB3588.namprd14.prod.outlook.com (2603:10b6:208:1cb::7)
 by BL1PR14MB5016.namprd14.prod.outlook.com (2603:10b6:208:319::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Wed, 14 Apr
 2021 14:25:00 +0000
Received: from BL0PR14MB3588.namprd14.prod.outlook.com
 ([fe80::2848:113d:4d17:51a0]) by BL0PR14MB3588.namprd14.prod.outlook.com
 ([fe80::2848:113d:4d17:51a0%6]) with mapi id 15.20.4042.016; Wed, 14 Apr 2021
 14:25:00 +0000
Content-Type: text/plain;
        charset=utf-8
Subject: Re: safe versions of NFS
From:   hedrick@rutgers.edu
In-Reply-To: <D511E83E-1C9D-49C7-BEE4-A3E96009B3B6@oracle.com>
Date:   Wed, 14 Apr 2021 10:24:59 -0400
Cc:     Benjamin Coddington <bcodding@redhat.com>,
        Patrick Goetz <pgoetz@math.utexas.edu>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <1EC571D9-9B20-4D82-803E-7865AD9CFC86@rutgers.edu>
References: <D8F59140-83D4-49F8-A858-D163910F0CA1@rutgers.edu>
 <e6501675-7cb4-6f5b-78f7-abb1be332a34@math.utexas.edu>
 <506B20E8-CE9C-499B-BF53-6026BA132D30@rutgers.edu>
 <1EA88CB0-7639-479C-AB1D-CAF5C67AA5C5@redhat.com>
 <22DE8966-253D-49A7-936D-F0A0B5246BE6@rutgers.edu>
 <08DD4F45-E1CB-4FCB-BA0C-A6B8BD86FEDE@redhat.com>
 <5F282359-128D-4F72-B393-B87956DFE458@oracle.com>
 <EE014097-EDF8-484B-81DF-9E7012122BB9@rutgers.edu>
 <D511E83E-1C9D-49C7-BEE4-A3E96009B3B6@oracle.com>
To:     Chuck Lever III <chuck.lever@oracle.com>
X-Mailer: Apple Mail (2.3654.40.0.2.32)
X-Originating-IP: [2620:0:d60:ac1a::a]
X-ClientProxiedBy: BL1PR13CA0226.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::21) To BL0PR14MB3588.namprd14.prod.outlook.com
 (2603:10b6:208:1cb::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from heidelberg.cs.rutgers.edu (2620:0:d60:ac1a::a) by BL1PR13CA0226.namprd13.prod.outlook.com (2603:10b6:208:2bf::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.6 via Frontend Transport; Wed, 14 Apr 2021 14:25:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 961ab5f7-01f2-4ad3-b6e9-08d8ff51164d
X-MS-TrafficTypeDiagnostic: BL1PR14MB5016:
X-Microsoft-Antispam-PRVS: <BL1PR14MB5016D724E1D2BFC25B32AC22AA4E9@BL1PR14MB5016.namprd14.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3hIwWuHiIAMkhD23OHtARvsQNjBSvcVddFwDPSEBNVOg4694j36TnS+PQuSQl3ibP7v+VVxleJEdXaFxT0iA2pVtrsvxnCb2z+73H/4j4p/oFsGHiUuCKXwHZ7cNavLZ/jsA9yxbll+5jmUkUHTJBBW7AcAGatspFiq2y0RXkMgjWiIFxp5dNa69O2y3+In5GkbASHQ0P0FWg+Si9BzL+Eav5dWSvZ+tSfBrsw5PX3mJ0psgYmewObo9QD0CaNDmKOzXISTtklKwM8+qYM8ZVqR4lCRyvta4nSGR16SCX5aXMMIzwLubx9I0L26Ow8CFfGOSXMWR15oFzpWOA/HuyXzPNHgEJayIRSlZNjkTBAbwhJBegwOEt925mP2p3RNz5KJVkJdP+WdS9CE4nWGsrTcC1DuIZZ2aFj5zBZ4kzmyDnTBo5ZBd2YGX3zDvZGfnQ5zxy6BOTmMCVc7p/pkZcDgjANvVK3POfGtQTqzODKE2HZwtBVNppvTo63ooAVdblVq9iMdZFEPCuMlRR8KQ/DSisWwUAeCyl7T747hc336qJug7sIRd7/34TomArVU9sLBznqp3NVa2NSwHMIjBrnpVSpcA6hbIGE2AJq9qVinCwjtW9eCOFvpQeQc9VOpASKkfvzetT3IkidQv96ldWw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR14MB3588.namprd14.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(39860400002)(396003)(366004)(16526019)(6916009)(30864003)(66556008)(8936002)(66946007)(66476007)(186003)(83380400001)(53546011)(86362001)(786003)(316002)(36756003)(75432002)(478600001)(38100700002)(8676002)(33656002)(6486002)(54906003)(2906002)(5660300002)(52116002)(2616005)(7696005)(4326008)(9686003)(3480700007)(2292003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?N2hLQUZIUm5ZNEI3VWlzN0d6SEdFZjR1bDZRRm8yd2tFeWxLWDBmOS8yaU1M?=
 =?utf-8?B?K25EVTNjS0k2RnduZDlJSlUwYm9TY2ZLa2V4ajVCQWZDVXcwaU5JRGsvZys3?=
 =?utf-8?B?bUxrZmt1OWQxVmpxWDZzRVNqRTZoaEpRZ0ZnUWxZVjhCbm91Y29ub2dqTVhT?=
 =?utf-8?B?bENNVk5YQzh2SXlRSHFqVzRxY0s2d1V6RXR2bnE4alJ2eEg5VkhiUjJ5bEpp?=
 =?utf-8?B?Mld6S3R6d0MwOUtmdkJqakltYTRldnFZR3lZZHk1Nk5BM2cxNFVTbjVBdytv?=
 =?utf-8?B?dkJqZXRQWXFZdlI1aC8xNFNyUzBSU3duWmVrMkNUbytaZlFJNjdRR01WZzdl?=
 =?utf-8?B?Z2YvMzVlcUhSaXgwbmlBQWZkNEdrdEhHREFIUmhqZFdKRU5zTXpQWnFmdm4z?=
 =?utf-8?B?M016Z0dDOEVpNkVxcE1ud1Z1TWJIZ05DbEcrNVRLRm8wRDd2b0F2dmc3dzJo?=
 =?utf-8?B?bmJIanNsYkVySHROMVU2d1FFanBRclk1RC9rSS9RSUhsYVg2R3V0T2ZyWkU1?=
 =?utf-8?B?N0lGYTZad1FPRzJwdWxBR29LbFhZMjBUTGFQanVxdGt1ZFgyck5uL3c3bjQ2?=
 =?utf-8?B?Vno4dm16amFiUW5TZjY2bk5qSFRQdjUrZkg3V3BnQ1MxNjI3a2ExNElRdmJi?=
 =?utf-8?B?Y2hVMTJlclJRNk5JQ1hUNDdmUXdaWjVJTW5PSGhYZDFWNzdPZEgrb1hiZ0lF?=
 =?utf-8?B?NnJ1Znp5WVEvWGJIVVA2Rk96SVBwYk1QWm9WU3JsVU9teGduUGtERWVueGtj?=
 =?utf-8?B?d3MwRWJReTNtbE1ueWFlbERaaitoWVBUbUMwd2Nsc282ODUzTFM1b1luVUwr?=
 =?utf-8?B?K1ltTjRBTkNBaWoyc2R2dFhObmlXSzg1bURrbERWeWZRZVc0UFJDOTJqRGgx?=
 =?utf-8?B?WDNFUysreW4yN2wxTERvNGdTSHdTa1ZlZ1lMOG0vNFNMMFlUZDhFMHVNTFZa?=
 =?utf-8?B?NTFyRVEzU3FpREtPMWxpOGZMYURQbExWSTgwMHRWaVpqUWZEZFJLZmhpL1c3?=
 =?utf-8?B?Q0tTSkJSZUVkNk9qdGVzRFpJOXFEdkd4S0ZpUE5icGZ0bkJlZmg3a09aWExq?=
 =?utf-8?B?Y25neEZtTlliV0F0SmVSYzdoM3YrYXZya1dhU1U0dmVtZGlvNk53STgzOEgz?=
 =?utf-8?B?UVdkWXlMY0krNFFyRERvVitBNzhnNWVrdTd0THNXclB4Q05Tc3F6aEZyUXl3?=
 =?utf-8?B?MlZLMVdqdUgrdlV1R0MwRjNCYy9mSzF4YWJNbXBMZFgyTy9SVXlzTU55dUF2?=
 =?utf-8?B?MTNaTE5iVlhBa0d4N3dFUlNaRitiWDhRWUlWODFIZHByK1ZDUDZlTG82enFL?=
 =?utf-8?B?SUtRZ0xkUGNqV1k5eTBQNFRLeURnNWFwMU5CeU5YZVBJUmlPQTFsQVQzREN5?=
 =?utf-8?B?QkEwb2U2RjJSREgrTEJHSk5WT09UWEc1WGpIc3VHUUUxUExRZDBtUmlGM0ZD?=
 =?utf-8?B?TnBTcEd4aEdhM2w4TzFkTFFudTRNWmhQOFlSY3F3WE45UzhNUXNlUnpTNzlh?=
 =?utf-8?B?V2lSQVpEb0w2SlZsc1RwN25VQWhVQklrUEFDZGgzaUQyNEhucVZrZklBOUsy?=
 =?utf-8?B?YUhKOW9xYWkrMGdmbHpvck5ORkYvbkE4SmU4ZTVTWkNvZzhMMHBvN0NZbW5O?=
 =?utf-8?B?QlhFWEUwSk5uT1J2ZU9CYnIxUjZuakcrcmoxZjJoS2QyWlFVS0FKSzJLWG5O?=
 =?utf-8?B?ZElyOGN4ZXpVRzczNHFJMGY5d2VhQS9UU2VlREljTVl3WFFoYXI5Nk4yeEIr?=
 =?utf-8?B?U1NpK0NURUNRTnhNWVlJa0l0MDh3Y0lwR001aUR2WGpRQlFpTklHQUNJbzU3?=
 =?utf-8?B?Mzd5NUJGYWt1d0dpMDlDdz09?=
X-OriginatorOrg: rutgers.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 961ab5f7-01f2-4ad3-b6e9-08d8ff51164d
X-MS-Exchange-CrossTenant-AuthSource: BL0PR14MB3588.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2021 14:25:00.5865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b92d2b23-4d35-4470-93ff-69aca6632ffe
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dqmVPhwIrjuZS96cETyIatv8Za8aVYVAEIN/XoRuWw4Exj7v5KZyCV3G4e4IuYlWKKHEUVaEGro6FqtSLrmfgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR14MB5016
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

sure. We=E2=80=99re hoping to move to a new enough kernel that it=E2=80=99s=
 OK. I wasn=E2=80=99t expecting this list to fix problems, but I thought th=
ere might be information in the community about the status in various kerne=
l releases, to guide us in what we need to do. If not, we=E2=80=99ll do our=
 own testing.

After looking at the features and our usage pattern, I=E2=80=99m not intere=
sted in turning off delegation. If 4.0 doesn=E2=80=99t have problems (and s=
o far it seems that it doesn=E2=80=99t), I think 4.0 with delegations is go=
ing to work better for us than 4.1 without delegations.=20

From a practical point of view getting a problem fixed is really difficult =
with intermittends, and the lead times for fixes to show up is in years. I =
think you=E2=80=99ll find that most sysadmins would rather find a workaroun=
d than fix the problem. I often don=E2=80=99t have vendor support, in part =
because when I do, difficult problems turn into an infinite discussion that=
 almost never terminates with a fix.=20

> On Apr 14, 2021, at 10:15 AM, Chuck Lever III <chuck.lever@oracle.com> wr=
ote:
>=20
> Good morning Charles,
>=20
>> On Apr 13, 2021, at 3:40 PM, hedrick@rutgers.edu wrote:
>>=20
>> This is from Centos 7.9, with all file systems mounted via NFS 4.0 (in t=
heory =E2=80=94 there may be 4.2 that were unmounted =E2=80=94lazy):
>=20
> There isn't much linux-nfs@ can do about problems in distributor
> kernels, and it's very possible the issue is already fixed in a
> more recent kernel. You did suggest that v5.8 seemed more solid,
> for instance, and my 30-second Googling suggests that Ubuntu 18
> is based on 4.15, which is ancient history for us upstream code
> monkeys.
>=20
> I recommend working with your Linux distributor to start root
> cause analysis and to let them document the issue properly. If
> they find that the problem is not already addressed in a newer
> kernel, then bring it back here to linux-nfs@.
>=20
>=20
> Sidebar: I find it interesting that the "just disable delegation"
> advice is still floating around the interwebs. And unfortunately
> it is probably still effective in some cases. The community
> should make an effort to nail those down and squash them, IMO.
>=20
>=20
>> 463 106.786384244 172.17.141.150 -> 172.17.11.218 TCP 66 nlogin > nfs [A=
CK] Seq=3D39641 Ack=3D46777 Win=3D24576 Len=3D0 TSval=3D520277320 TSecr=3D1=
478982393
>> 464 108.000270192 172.17.141.150 -> 172.17.11.218 NFS 238 V4 Call ACCESS=
 FH: 0xe696b554, [Check: RD LU MD XT DL]
>> 465 108.000361904 172.17.141.150 -> 172.17.11.218 NFS 238 V4 Call ACCESS=
 FH: 0xd61aa475, [Check: RD LU MD XT DL]
>> 466 108.000476711 172.17.11.218 -> 172.17.141.150 NFS 222 V4 Reply (Call=
 In 464) ACCESS, [Allowed: RD LU MD XT DL]
>> 467 108.000495290 172.17.141.150 -> 172.17.11.218 TCP 66 rndc > nfs [ACK=
] Seq=3D9189 Ack=3D8761 Win=3D16605 Len=3D0 TSval=3D520278534 TSecr=3D14789=
83647
>> 468 108.000591598 172.17.11.218 -> 172.17.141.150 NFS 222 V4 Reply (Call=
 In 465) ACCESS, [Allowed: RD LU MD XT DL]
>> 469 108.000608160 172.17.141.150 -> 172.17.11.218 TCP 66 rndc > nfs [ACK=
] Seq=3D9189 Ack=3D8917 Win=3D16605 Len=3D0 TSval=3D520278534 TSecr=3D14789=
83647
>> 470 118.952127064 172.17.141.150 -> 172.17.11.218 NFS 238 V4 Call ACCESS=
 FH: 0xef7d152e, [Check: RD LU MD XT DL]
>> 471 118.952356881 172.17.11.218 -> 172.17.141.150 NFS 222 V4 Reply (Call=
 In 470) ACCESS, [Allowed: RD LU MD XT DL]
>> 472 118.952372768 172.17.141.150 -> 172.17.11.218 TCP 66 rndc > nfs [ACK=
] Seq=3D9361 Ack=3D9073 Win=3D16605 Len=3D0 TSval=3D520289486 TSecr=3D14789=
94599
>> 473 119.999835420 172.17.141.150 -> 172.17.11.218 NFS 238 V4 Call ACCESS=
 FH: 0x94a968d5, [Check: RD LU MD XT DL]
>> 474 120.000067817 172.17.11.218 -> 172.17.141.150 NFS 222 V4 Reply (Call=
 In 473) ACCESS, [Allowed: RD LU MD XT DL]
>> 475 120.000082882 172.17.141.150 -> 172.17.11.218 TCP 66 rndc > nfs [ACK=
] Seq=3D9533 Ack=3D9229 Win=3D16605 Len=3D0 TSval=3D520290533 TSecr=3D14789=
95646
>> 476 140.000587688 172.17.141.150 -> 172.17.11.218 NFS 238 V4 Call ACCESS=
 FH: 0xe696b554, [Check: RD LU MD XT DL]
>> 477 140.000688677 172.17.141.150 -> 172.17.11.218 NFS 238 V4 Call ACCESS=
 FH: 0xd61aa475, [Check: RD LU MD XT DL]
>> 478 140.000746915 172.17.11.218 -> 172.17.141.150 NFS 222 V4 Reply (Call=
 In 476) ACCESS, [Allowed: RD LU MD XT DL]
>> 479 140.000759241 172.17.141.150 -> 172.17.11.218 TCP 66 rndc > nfs [ACK=
] Seq=3D9877 Ack=3D9385 Win=3D16605 Len=3D0 TSval=3D520310534 TSecr=3D14790=
15647
>> 480 140.000830146 172.17.11.218 -> 172.17.141.150 NFS 222 V4 Reply (Call=
 In 477) ACCESS, [Allowed: RD LU MD XT DL]
>> 481 140.000836443 172.17.141.150 -> 172.17.11.218 TCP 66 rndc > nfs [ACK=
] Seq=3D9877 Ack=3D9541 Win=3D16605 Len=3D0 TSval=3D520310534 TSecr=3D14790=
15647
>> 482 148.442466129 172.17.141.150 -> 172.17.11.218 NFS 226 V4 Call RENEW =
CID: 0x04da
>> 483 148.442650203 172.17.11.218 -> 172.17.141.150 NFS 182 V4 Reply (Call=
 In 482) RENEW
>> 484 148.442664846 172.17.141.150 -> 172.17.11.218 TCP 66 rndc > nfs [ACK=
] Seq=3D10037 Ack=3D9657 Win=3D16605 Len=3D0 TSval=3D520318976 TSecr=3D1479=
024089
>> 485 149.953317362 172.17.141.150 -> 172.17.11.218 NFS 238 V4 Call ACCESS=
 FH: 0xef7d152e, [Check: RD LU MD XT DL]
>> 486 149.953550872 172.17.11.218 -> 172.17.141.150 NFS 222 V4 Reply (Call=
 In 485) ACCESS, [Allowed: RD LU MD XT DL]
>> 487 149.953565993 172.17.141.150 -> 172.17.11.218 TCP 66 rndc > nfs [ACK=
] Seq=3D10209 Ack=3D9813 Win=3D16605 Len=3D0 TSval=3D520320487 TSecr=3D1479=
025600
>> 488 162.000571296 172.17.141.150 -> 172.17.11.218 NFS 226 V4 Call ACCESS=
 FH: 0xcd1903be, [Check: RD LU MD XT DL]
>> 489 162.000794395 172.17.11.218 -> 172.17.141.150 NFS 222 V4 Reply (Call=
 In 488) ACCESS, [Access Denied: MD XT DL], [Allowed: RD LU]
>> 490 162.000825598 172.17.141.150 -> 172.17.11.218 TCP 66 rndc > nfs [ACK=
] Seq=3D10369 Ack=3D9969 Win=3D16605 Len=3D0 TSval=3D520332534 TSecr=3D1479=
037647
>> 491 162.000998283 172.17.141.150 -> 172.17.11.218 NFS 238 V4 Call ACCESS=
 FH: 0xeabd4697, [Check: RD LU MD XT DL]
>> 492 162.001218772 172.17.11.218 -> 172.17.141.150 NFS 222 V4 Reply (Call=
 In 491) ACCESS, [Allowed: RD LU MD XT DL]
>> 493 162.040415201 172.17.141.150 -> 172.17.11.218 TCP 66 rndc > nfs [ACK=
] Seq=3D10541 Ack=3D10125 Win=3D16605 Len=3D0 TSval=3D520332574 TSecr=3D147=
9037647
>> 494 166.874398617 172.17.141.150 -> 172.17.11.218 TCP 66 [TCP Keep-Alive=
] nlogin > nfs [ACK] Seq=3D39640 Ack=3D46777 Win=3D24576 Len=3D0 TSval=3D52=
0337408 TSecr=3D1478982393
>> 495 166.874438892 172.17.141.150 -> 172.17.11.218 NFS 250 V4 Call SEQUEN=
CE
>> 496 166.874506845 172.17.11.218 -> 172.17.141.150 TCP 66 [TCP Dup ACK 46=
2#1] nfs > nlogin [ACK] Seq=3D46777 Ack=3D39641 Win=3D24559 Len=3D0 TSval=
=3D1479042521 TSecr=3D520277320
>> 497 166.874720218 172.17.11.218 -> 172.17.141.150 NFS 218 V4 Reply (Call=
 In 495) SEQUENCE
>> 498 166.874730215 172.17.141.150 -> 172.17.11.218 TCP 66 nlogin > nfs [A=
CK] Seq=3D39825 Ack=3D46929 Win=3D24575 Len=3D0 TSval=3D520337408 TSecr=3D1=
479042521
>> 499 166.874987010 172.17.141.150 -> 172.17.11.218 NFS 274 V4 Call TEST_S=
TATEID
>> 500 166.875172744 172.17.11.218 -> 172.17.141.150 NFS 234 V4 Reply (Call=
 In 499) TEST_STATEID
>> 501 166.875309487 172.17.141.150 -> 172.17.11.218 NFS 334 V4 Call OPEN D=
H: 0x534735df/
>> 502 166.875655661 172.17.11.218 -> 172.17.141.150 NFS 454 V4 Reply (Call=
 In 501) OPEN StateID: 0xd7ae
>> 503 166.875801366 172.17.141.150 -> 172.17.11.218 NFS 274 V4 Call TEST_S=
TATEID
>> 504 166.876042044 172.17.11.218 -> 172.17.141.150 NFS 234 V4 Reply (Call=
 In 503) TEST_STATEID
>> 505 166.876210946 172.17.141.150 -> 172.17.11.218 NFS 334 V4 Call OPEN D=
H: 0xdabfc399/
>> 506 166.876485761 172.17.11.218 -> 172.17.141.150 NFS 454 V4 Reply (Call=
 In 505) OPEN StateID: 0x9578
>> 507 166.876607463 172.17.141.150 -> 172.17.11.218 NFS 334 V4 Call OPEN D=
H: 0xdabfc399/
>> 508 166.876820365 172.17.11.218 -> 172.17.141.150 NFS 454 V4 Reply (Call=
 In 507) OPEN StateID: 0xfa83
>> 509 166.876941430 172.17.141.150 -> 172.17.11.218 NFS 274 V4 Call TEST_S=
TATEID
>> 510 166.877123487 172.17.11.218 -> 172.17.141.150 NFS 234 V4 Reply (Call=
 In 509) TEST_STATEID
>> 511 166.877205876 172.17.141.150 -> 172.17.11.218 NFS 334 V4 Call OPEN D=
H: 0x968ca393/
>> 512 166.877464268 172.17.11.218 -> 172.17.141.150 NFS 454 V4 Reply (Call=
 In 511) OPEN StateID: 0x25d5
>> 513 166.877600104 172.17.141.150 -> 172.17.11.218 NFS 274 V4 Call TEST_S=
TATEID
>> 514 166.877841822 172.17.11.218 -> 172.17.141.150 NFS 234 V4 Reply (Call=
 In 513) TEST_STATEID
>> 515 166.877997847 172.17.141.150 -> 172.17.11.218 NFS 334 V4 Call OPEN D=
H: 0xde4187cf/
>> 516 166.878265626 172.17.11.218 -> 172.17.141.150 NFS 454 V4 Reply (Call=
 In 515) OPEN StateID: 0xd5ce
>> 517 166.878393548 172.17.141.150 -> 172.17.11.218 NFS 274 V4 Call TEST_S=
TATEID
>> 518 166.878603997 172.17.11.218 -> 172.17.141.150 NFS 234 V4 Reply (Call=
 In 517) TEST_STATEID
>> 519 166.878692334 172.17.141.150 -> 172.17.11.218 NFS 334 V4 Call OPEN D=
H: 0x9f6703e9/
>> 520 166.878920958 172.17.11.218 -> 172.17.141.150 NFS 454 V4 Reply (Call=
 In 519) OPEN StateID: 0x69a1
>> 521 166.878964818 172.17.141.150 -> 172.17.11.218 NFS 274 V4 Call TEST_S=
TATEID
>> 522 166.879156141 172.17.11.218 -> 172.17.141.150 NFS 234 V4 Reply (Call=
 In 521) TEST_STATEID
>> 523 166.879195140 172.17.141.150 -> 172.17.11.218 NFS 334 V4 Call OPEN D=
H: 0xe5c84183/
>> 524 166.879435831 172.17.11.218 -> 172.17.141.150 NFS 454 V4 Reply (Call=
 In 523) OPEN StateID: 0x6069
>> 525 166.879518910 172.17.141.150 -> 172.17.11.218 NFS 274 V4 Call TEST_S=
TATEID
>> 526 166.879709592 172.17.11.218 -> 172.17.141.150 NFS 234 V4 Reply (Call=
 In 525) TEST_STATEID
>> 527 166.879796731 172.17.141.150 -> 172.17.11.218 NFS 334 V4 Call OPEN D=
H: 0x927973ae/
>> 528 166.880024682 172.17.11.218 -> 172.17.141.150 NFS 454 V4 Reply (Call=
 In 527) OPEN StateID: 0xf420
>> 529 166.880070944 172.17.141.150 -> 172.17.11.218 NFS 334 V4 Call OPEN D=
H: 0x927973ae/
>> 530 166.880265884 172.17.11.218 -> 172.17.141.150 NFS 454 V4 Reply (Call=
 In 529) OPEN StateID: 0xec63
>> 531 166.880301034 172.17.141.150 -> 172.17.11.218 NFS 274 V4 Call TEST_S=
TATEID
>> 532 166.880511051 172.17.11.218 -> 172.17.141.150 NFS 234 V4 Reply (Call=
 In 531) TEST_STATEID
>> 533 166.880575938 172.17.141.150 -> 172.17.11.218 NFS 334 V4 Call OPEN D=
H: 0x05761d23/
>> 534 166.880798417 172.17.11.218 -> 172.17.141.150 NFS 454 V4 Reply (Call=
 In 533) OPEN StateID: 0xb199
>> 535 166.880840801 172.17.141.150 -> 172.17.11.218 NFS 274 V4 Call TEST_S=
TATEID
>> 536 166.881008021 172.17.11.218 -> 172.17.141.150 NFS 234 V4 Reply (Call=
 In 535) TEST_STATEID
>> 537 166.881043797 172.17.141.150 -> 172.17.11.218 NFS 334 V4 Call OPEN D=
H: 0xb6b205f7/
>> 538 166.881270127 172.17.11.218 -> 172.17.141.150 NFS 454 V4 Reply (Call=
 In 537) OPEN StateID: 0x49df
>> 539 166.881304710 172.17.141.150 -> 172.17.11.218 NFS 334 V4 Call OPEN D=
H: 0xb6b205f7/
>> 540 166.881498628 172.17.11.218 -> 172.17.141.150 NFS 454 V4 Reply (Call=
 In 539) OPEN StateID: 0xf0d5
>> 541 166.881545126 172.17.141.150 -> 172.17.11.218 NFS 274 V4 Call TEST_S=
TATEID
>> 542 166.881732646 172.17.11.218 -> 172.17.141.150 NFS 234 V4 Reply (Call=
 In 541) TEST_STATEID
>> 543 166.881775578 172.17.141.150 -> 172.17.11.218 NFS 334 V4 Call OPEN D=
H: 0x0183cd1e/
>> 544 166.881978864 172.17.11.218 -> 172.17.141.150 NFS 454 V4 Reply (Call=
 In 543) OPEN StateID: 0x546d
>> 545 166.882021595 172.17.141.150 -> 172.17.11.218 NFS 274 V4 Call TEST_S=
TATEID
>> 546 166.882209030 172.17.11.218 -> 172.17.141.150 NFS 234 V4 Reply (Call=
 In 545) TEST_STATEID
>> 547 166.882252306 172.17.141.150 -> 172.17.11.218 NFS 334 V4 Call OPEN D=
H: 0x673ef4c3/
>> 548 166.882484514 172.17.11.218 -> 172.17.141.150 NFS 454 V4 Reply (Call=
 In 547) OPEN StateID: 0xa46d
>> 549 166.882523043 172.17.141.150 -> 172.17.11.218 NFS 334 V4 Call OPEN D=
H: 0x673ef4c3/
>> 550 166.882710061 172.17.11.218 -> 172.17.141.150 NFS 454 V4 Reply (Call=
 In 549) OPEN StateID: 0xaa9a
>> 551 166.882750420 172.17.141.150 -> 172.17.11.218 NFS 274 V4 Call TEST_S=
TATEID
>> 552 166.882933338 172.17.11.218 -> 172.17.141.150 NFS 234 V4 Reply (Call=
 In 551) TEST_STATEID
>> 553 166.882961488 172.17.141.150 -> 172.17.11.218 NFS 334 V4 Call OPEN D=
H: 0x3699764a/
>> 554 166.883192776 172.17.11.218 -> 172.17.141.150 NFS 454 V4 Reply (Call=
 In 553) OPEN StateID: 0x3c37
>> 555 166.883223581 172.17.141.150 -> 172.17.11.218 NFS 274 V4 Call TEST_S=
TATEID
>> 556 166.883407176 172.17.11.218 -> 172.17.141.150 NFS 234 V4 Reply (Call=
 In 555) TEST_STATEID
>> 557 166.883468198 172.17.141.150 -> 172.17.11.218 NFS 334 V4 Call OPEN D=
H: 0x94fd1187/
>> 558 166.883679012 172.17.11.218 -> 172.17.141.150 NFS 454 V4 Reply (Call=
 In 557) OPEN StateID: 0xbedf
>> 559 166.883719911 172.17.141.150 -> 172.17.11.218 NFS 274 V4 Call TEST_S=
TATEID
>> 560 166.883910224 172.17.11.218 -> 172.17.141.150 NFS 234 V4 Reply (Call=
 In 559) TEST_STATEID
>> 561 166.883937791 172.17.141.150 -> 172.17.11.218 NFS 334 V4 Call OPEN D=
H: 0xcd96c73b/
>> 562 166.884165115 172.17.11.218 -> 172.17.141.150 NFS 454 V4 Reply (Call=
 In 561) OPEN StateID: 0xbf6c
>> 563 166.884194351 172.17.141.150 -> 172.17.11.218 NFS 274 V4 Call TEST_S=
TATEID
>> 564 166.884378426 172.17.11.218 -> 172.17.141.150 NFS 234 V4 Reply (Call=
 In 563) TEST_STATEID
>> 565 166.884433848 172.17.141.150 -> 172.17.11.218 NFS 334 V4 Call OPEN D=
H: 0xd24bb22d/
>> 566 166.884661584 172.17.11.218 -> 172.17.141.150 NFS 454 V4 Reply (Call=
 In 565) OPEN StateID: 0xaaf5
>> 567 166.884719445 172.17.141.150 -> 172.17.11.218 NFS 274 V4 Call TEST_S=
TATEID
>> 568 166.884904098 172.17.11.218 -> 172.17.141.150 NFS 234 V4 Reply (Call=
 In 567) TEST_STATEID
>> 569 166.884952255 172.17.141.150 -> 172.17.11.218 NFS 334 V4 Call OPEN D=
H: 0x5e594598/
>> 570 166.885154240 172.17.11.218 -> 172.17.141.150 NFS 454 V4 Reply (Call=
 In 569) OPEN StateID: 0x11cb
>> 571 166.885206342 172.17.141.150 -> 172.17.11.218 NFS 274 V4 Call TEST_S=
TATEID
>> 572 166.885389478 172.17.11.218 -> 172.17.141.150 NFS 234 V4 Reply (Call=
 In 571) TEST_STATEID
>> 573 166.885454506 172.17.141.150 -> 172.17.11.218 NFS 334 V4 Call OPEN D=
H: 0xa4fd80c1/
>> 574 166.885686638 172.17.11.218 -> 172.17.141.150 NFS 454 V4 Reply (Call=
 In 573) OPEN StateID: 0x9363
>> 575 166.885745762 172.17.141.150 -> 172.17.11.218 NFS 274 V4 Call TEST_S=
TATEID
>> 576 166.885933232 172.17.11.218 -> 172.17.141.150 NFS 234 V4 Reply (Call=
 In 575) TEST_STATEID
>> 577 166.885980692 172.17.141.150 -> 172.17.11.218 NFS 334 V4 Call OPEN D=
H: 0x80e4743a/
>> 578 166.886212637 172.17.11.218 -> 172.17.141.150 NFS 454 V4 Reply (Call=
 In 577) OPEN StateID: 0x63af
>> 579 166.886272585 172.17.141.150 -> 172.17.11.218 NFS 274 V4 Call TEST_S=
TATEID
>> 580 166.886457823 172.17.11.218 -> 172.17.141.150 NFS 234 V4 Reply (Call=
 In 579) TEST_STATEID
>> 581 166.886514332 172.17.141.150 -> 172.17.11.218 NFS 334 V4 Call OPEN D=
H: 0xb3e2d284/
>> 582 166.886742488 172.17.11.218 -> 172.17.141.150 NFS 454 V4 Reply (Call=
 In 581) OPEN StateID: 0x52d9
>> 583 166.886803826 172.17.141.150 -> 172.17.11.218 NFS 274 V4 Call TEST_S=
TATEID
>> 584 166.886989516 172.17.11.218 -> 172.17.141.150 NFS 234 V4 Reply (Call=
 In 583) TEST_STATEID
>> 585 166.887100351 172.17.141.150 -> 172.17.11.218 NFS 334 V4 Call OPEN D=
H: 0x95137efa/
>> 586 166.887304377 172.17.11.218 -> 172.17.141.150 NFS 454 V4 Reply (Call=
 In 585) OPEN StateID: 0xb26e
>> 587 166.887395696 172.17.141.150 -> 172.17.11.218 NFS 274 V4 Call TEST_S=
TATEID
>> 588 166.887587544 172.17.11.218 -> 172.17.141.150 NFS 234 V4 Reply (Call=
 In 587) TEST_STATEID
>> 589 166.887703373 172.17.141.150 -> 172.17.11.218 NFS 334 V4 Call OPEN D=
H: 0x1d70394e/
>> 590 166.887919160 172.17.11.218 -> 172.17.141.150 NFS 454 V4 Reply (Call=
 In 589) OPEN StateID: 0x753c
>> 591 166.887999278 172.17.141.150 -> 172.17.11.218 NFS 274 V4 Call TEST_S=
TATEID
>> 592 166.888190709 172.17.11.218 -> 172.17.141.150 NFS 234 V4 Reply (Call=
 In 591) TEST_STATEID
>> 593 166.888298867 172.17.141.150 -> 172.17.11.218 NFS 334 V4 Call OPEN D=
H: 0x680da7ff/
>> 594 166.888530666 172.17.11.218 -> 172.17.141.150 NFS 454 V4 Reply (Call=
 In 593) OPEN StateID: 0x097c
>> 595 166.888605330 172.17.141.150 -> 172.17.11.218 NFS 274 V4 Call TEST_S=
TATEID
>> 596 166.888795331 172.17.11.218 -> 172.17.141.150 NFS 234 V4 Reply (Call=
 In 595) TEST_STATEID
>> 597 166.888902566 172.17.141.150 -> 172.17.11.218 NFS 334 V4 Call OPEN D=
H: 0x0a52a987/
>> 598 166.889113308 172.17.11.218 -> 172.17.141.150 NFS 454 V4 Reply (Call=
 In 597) OPEN StateID: 0x7781
>> 599 166.889162100 172.17.141.150 -> 172.17.11.218 NFS 274 V4 Call TEST_S=
TATEID
>> 600 166.889353078 172.17.11.218 -> 172.17.141.150 NFS 234 V4 Reply (Call=
 In 599) TEST_STATEID
>> 601 166.889461157 172.17.141.150 -> 172.17.11.218 NFS 334 V4 Call OPEN D=
H: 0x56462642/
>> 602 166.889699242 172.17.11.218 -> 172.17.141.150 NFS 454 V4 Reply (Call=
 In 601) OPEN StateID: 0xb209
>> 603 166.889772552 172.17.141.150 -> 172.17.11.218 NFS 274 V4 Call TEST_S=
TATEID
>> 604 166.889963172 172.17.11.218 -> 172.17.141.150 NFS 234 V4 Reply (Call=
 In 603) TEST_STATEID
>> 605 166.890070241 172.17.141.150 -> 172.17.11.218 NFS 334 V4 Call OPEN D=
H: 0x850c0567/
>> 606 166.890272350 172.17.11.218 -> 172.17.141.150 NFS 454 V4 Reply (Call=
 In 605) OPEN StateID: 0x8134
>> 607 166.890335412 172.17.141.150 -> 172.17.11.218 NFS 274 V4 Call TEST_S=
TATEID
>> 608 166.890542793 172.17.11.218 -> 172.17.141.150 NFS 234 V4 Reply (Call=
 In 607) TEST_STATEID
>> 609 166.890650208 172.17.141.150 -> 172.17.11.218 NFS 334 V4 Call OPEN D=
H: 0x31aa2390/
>> 610 166.890886053 172.17.11.218 -> 172.17.141.150 NFS 454 V4 Reply (Call=
 In 609) OPEN StateID: 0x1f30
>> 611 166.890959992 172.17.141.150 -> 172.17.11.218 NFS 274 V4 Call TEST_S=
TATEID
>> 612 166.891158969 172.17.11.218 -> 172.17.141.150 NFS 234 V4 Reply (Call=
 In 611) TEST_STATEID
>> 613 166.891264349 172.17.141.150 -> 172.17.11.218 NFS 334 V4 Call OPEN D=
H: 0x2ae7f451/
>> 614 166.891516937 172.17.11.218 -> 172.17.141.150 NFS 454 V4 Reply (Call=
 In 613) OPEN StateID: 0x3fce
>> 615 166.891591778 172.17.141.150 -> 172.17.11.218 NFS 274 V4 Call TEST_S=
TATEID
>> 616 166.891788024 172.17.11.218 -> 172.17.141.150 NFS 234 V4 Reply (Call=
 In 615) TEST_STATEID
>> 617 166.891902329 172.17.141.150 -> 172.17.11.218 NFS 334 V4 Call OPEN D=
H: 0xa5cb13d3/
>> 618 166.892117369 172.17.11.218 -> 172.17.141.150 NFS 454 V4 Reply (Call=
 In 617) OPEN StateID: 0x03d6
>> 619 166.892175933 172.17.141.150 -> 172.17.11.218 NFS 274 V4 Call TEST_S=
TATEID
>> 620 166.892398086 172.17.11.218 -> 172.17.141.150 NFS 234 V4 Reply (Call=
 In 619) TEST_STATEID
>> 621 166.892447518 172.17.141.150 -> 172.17.11.218 NFS 334 V4 Call OPEN D=
H: 0x3f5cfcdb/
>> 622 166.892671544 172.17.11.218 -> 172.17.141.150 NFS 454 V4 Reply (Call=
 In 621) OPEN StateID: 0x8bff
>> 623 166.892716533 172.17.141.150 -> 172.17.11.218 NFS 274 V4 Call TEST_S=
TATEID
>> 624 166.892901971 172.17.11.218 -> 172.17.141.150 NFS 234 V4 Reply (Call=
 In 623) TEST_STATEID
>> 625 166.892940753 172.17.141.150 -> 172.17.11.218 NFS 334 V4 Call OPEN D=
H: 0x40b4d194/
>> 626 166.893167930 172.17.11.218 -> 172.17.141.150 NFS 454 V4 Reply (Call=
 In 625) OPEN StateID: 0xe3e8
>> 627 166.893215973 172.17.141.150 -> 172.17.11.218 NFS 274 V4 Call TEST_S=
TATEID
>> 628 166.893398652 172.17.11.218 -> 172.17.141.150 NFS 234 V4 Reply (Call=
 In 627) TEST_STATEID
>> 629 166.893445197 172.17.141.150 -> 172.17.11.218 NFS 334 V4 Call OPEN D=
H: 0x4643d6fc/
>> 630 166.893682547 172.17.11.218 -> 172.17.141.150 NFS 454 V4 Reply (Call=
 In 629) OPEN StateID: 0xe194
>> 631 166.893731829 172.17.141.150 -> 172.17.11.218 NFS 274 V4 Call TEST_S=
TATEID
>> 632 166.893915920 172.17.11.218 -> 172.17.141.150 NFS 234 V4 Reply (Call=
 In 631) TEST_STATEID
>> 633 166.893960986 172.17.141.150 -> 172.17.11.218 NFS 334 V4 Call OPEN D=
H: 0xd246cbd3/
>> 634 166.894191435 172.17.11.218 -> 172.17.141.150 NFS 454 V4 Reply (Call=
 In 633) OPEN StateID: 0x22f5
>> 635 166.894240889 172.17.141.150 -> 172.17.11.218 NFS 274 V4 Call TEST_S=
TATEID
>> 636 166.894425035 172.17.11.218 -> 172.17.141.150 NFS 234 V4 Reply (Call=
 In 635) TEST_STATEID
>> 637 166.894470784 172.17.141.150 -> 172.17.11.218 NFS 334 V4 Call OPEN D=
H: 0xde40a6e1/
>> 638 166.894695618 172.17.11.218 -> 172.17.141.150 NFS 454 V4 Reply (Call=
 In 637) OPEN StateID: 0x9ce2
>> 639 166.894744788 172.17.141.150 -> 172.17.11.218 NFS 274 V4 Call TEST_S=
TATEID
>> 640 166.894929372 172.17.11.218 -> 172.17.141.150 NFS 234 V4 Reply (Call=
 In 639) TEST_STATEID
>> 641 166.894967975 172.17.141.150 -> 172.17.11.218 NFS 334 V4 Call OPEN D=
H: 0x0f26a4dc/
>> 642 166.895197152 172.17.11.218 -> 172.17.141.150 NFS 454 V4 Reply (Call=
 In 641) OPEN StateID: 0x879c
>> 643 166.895245038 172.17.141.150 -> 172.17.11.218 NFS 274 V4 Call TEST_S=
TATEID
>> 644 166.895429467 172.17.11.218 -> 172.17.141.150 NFS 234 V4 Reply (Call=
 In 643) TEST_STATEID
>> 645 166.895471234 172.17.141.150 -> 172.17.11.218 NFS 334 V4 Call OPEN D=
H: 0x82162062/
>> 646 166.895694775 172.17.11.218 -> 172.17.141.150 NFS 454 V4 Reply (Call=
 In 645) OPEN StateID: 0xab68
>> 647 166.895744208 172.17.141.150 -> 172.17.11.218 NFS 274 V4 Call TEST_S=
TATEID
>> 648 166.895929221 172.17.11.218 -> 172.17.141.150 NFS 234 V4 Reply (Call=
 In 647) TEST_STATEID
>> 649 166.895973162 172.17.141.150 -> 172.17.11.218 NFS 334 V4 Call OPEN D=
H: 0xb8b3b57f/
>> 650 166.896197535 172.17.11.218 -> 172.17.141.150 NFS 454 V4 Reply (Call=
 In 649) OPEN StateID: 0xfb0b
>> 651 166.896245960 172.17.141.150 -> 172.17.11.218 NFS 274 V4 Call TEST_S=
TATEID
>> 652 166.896430271 172.17.11.218 -> 172.17.141.150 NFS 234 V4 Reply (Call=
 In 651) TEST_STATEID
>> 653 166.896475752 172.17.141.150 -> 172.17.11.218 NFS 334 V4 Call OPEN D=
H: 0x2e6c2b31/
>> 654 166.896705501 172.17.11.218 -> 172.17.141.150 NFS 454 V4 Reply (Call=
 In 653) OPEN StateID: 0x8e00
>> 655 166.896754419 172.17.141.150 -> 172.17.11.218 NFS 274 V4 Call TEST_S=
TATEID
>> 656 166.896939911 172.17.11.218 -> 172.17.141.150 NFS 234 V4 Reply (Call=
 In 655) TEST_STATEID
>> 657 166.896983440 172.17.141.150 -> 172.17.11.218 NFS 334 V4 Call OPEN D=
H: 0x547cf5ea/
>> 658 166.897209526 172.17.11.218 -> 172.17.141.150 NFS 454 V4 Reply (Call=
 In 657) OPEN StateID: 0x0532
>> 659 166.897258079 172.17.141.150 -> 172.17.11.218 NFS 274 V4 Call TEST_S=
TATEID
>> 660 166.897443527 172.17.11.218 -> 172.17.141.150 NFS 234 V4 Reply (Call=
 In 659) TEST_STATEID
>> 661 166.897484081 172.17.141.150 -> 172.17.11.218 NFS 334 V4 Call OPEN D=
H: 0x33c176ce/
>> 662 166.897693578 172.17.11.218 -> 172.17.141.150 NFS 454 V4 Reply (Call=
 In 661) OPEN StateID: 0x3648
>> 663 166.937386876 172.17.141.150 -> 172.17.11.218 TCP 66 nlogin > nfs [A=
CK] Seq=3D59461 Ack=3D70165 Win=3D24576 Len=3D0 TSval=3D520337471 TSecr=3D1=
479042544
>> ^C663 packets captured
>> [hedrick@camaro ~]$=20
>>=20
>> Here=E2=80=99s the corresponding section of /var/log/messages
>>=20
>> Apr 13 15:36:05 camaro.lcsr.rutgers.edu kernel: nfs4_reclaim_open_state:=
 1 callbacks suppressed
>> Apr 13 15:36:05 camaro.lcsr.rutgers.edu kernel: NFS: nfs4_reclaim_open_s=
tate: Lock reclaim failed!
>> Apr 13 15:36:05 camaro.lcsr.rutgers.edu kernel: NFS: nfs4_reclaim_open_s=
tate: Lock reclaim failed!
>> Apr 13 15:36:05 camaro.lcsr.rutgers.edu kernel: NFS: nfs4_reclaim_open_s=
tate: Lock reclaim failed!
>> Apr 13 15:36:05 camaro.lcsr.rutgers.edu kernel: NFS: nfs4_reclaim_open_s=
tate: Lock reclaim failed!
>> Apr 13 15:36:05 camaro.lcsr.rutgers.edu kernel: NFS: nfs4_reclaim_open_s=
tate: Lock reclaim failed!
>> Apr 13 15:36:05 camaro.lcsr.rutgers.edu kernel: NFS: nfs4_reclaim_open_s=
tate: Lock reclaim failed!
>> Apr 13 15:36:05 camaro.lcsr.rutgers.edu kernel: NFS: nfs4_reclaim_open_s=
tate: Lock reclaim failed!
>> Apr 13 15:36:05 camaro.lcsr.rutgers.edu kernel: NFS: nfs4_reclaim_open_s=
tate: Lock reclaim failed!
>> Apr 13 15:36:05 camaro.lcsr.rutgers.edu kernel: NFS: nfs4_reclaim_open_s=
tate: Lock reclaim failed!
>> Apr 13 15:36:05 camaro.lcsr.rutgers.edu kernel: NFS: nfs4_reclaim_open_s=
tate: Lock reclaim failed!
>>=20
>>=20
>>=20
>>=20
>>> On Apr 13, 2021, at 1:24 PM, Chuck Lever III <chuck.lever@oracle.com> w=
rote:
>>>=20
>>>=20
>>>=20
>>>> On Apr 13, 2021, at 12:23 PM, Benjamin Coddington <bcodding@redhat.com=
> wrote:
>>>>=20
>>>> (resending this as it bounced off the list - I accidentally embedded H=
TML)
>>>>=20
>>>> Yes, if you're pretty sure your hostnames are all different, the clien=
t_ids
>>>> should be different.  For v4.0 you can turn on debugging (rpcdebug -m =
nfs -s
>>>> proc) and see the client_id in the kernel log in lines that look like:=
 "NFS
>>>> call setclientid auth=3D%s, '%s'\n", which will happen at mount time, =
but it
>>>> doesn't look like we have any debugging for v4.1 and v4.2 for EXCHANGE=
_ID.
>>>>=20
>>>> You can extract it via the crash utility, or via systemtap, or by doin=
g a
>>>> wire capture, but nothing that's easily translated to running across a=
 large
>>>> number of machines.  There's probably other ways, perhaps we should ta=
ck
>>>> that string into the tracepoints for exchange_id and setclientid.
>>>>=20
>>>> If you're interested in troubleshooting, wire capture's usually the mo=
st
>>>> informative.  If the lockup events all happen at the same time, there
>>>> might be some network event that is triggering the issue.
>>>>=20
>>>> You should expect NFSv4.1 to be rock-solid.  Its rare we have reports
>>>> that it isn't, and I'd love to know why you're having these problems.
>>>=20
>>> I echo that: NFSv4.1 protocol and implementation are mature, so if
>>> there are operational problems, it should be root-caused.
>>>=20
>>> NFSv4.1 uses a uniform client ID. That should be the "good" one,
>>> not the NFSv4.0 one that has a non-zero probability of collision.
>>>=20
>>> Charles, please let us know if there are particular workloads that
>>> trigger the lock reclaim failure. A narrow reproducer would help
>>> get to the root issue quickly.
>>>=20
>>>=20
>>>> Ben
>>>>=20
>>>> On 13 Apr 2021, at 11:38, hedrick@rutgers.edu wrote:
>>>>=20
>>>>> The server is ubuntu 20, with a ZFS file system.
>>>>>=20
>>>>> I don=E2=80=99t set the unique ID. Documentation claims that it is se=
t from the hostname. They will surely be unique, or the whole world would b=
low up. How can I check the actual unique ID being used? The kernel reports=
 a blank one, but I think that just means to use the hostname. We could obv=
iously set a unique one if that would be useful.
>>>>>=20
>>>>>> On Apr 13, 2021, at 11:35 AM, Benjamin Coddington <bcodding@redhat.c=
om> wrote:
>>>>>>=20
>>>>>> It would be interesting to know why your clients are failing to recl=
aim their locks.  Something is misconfigured.  What server are you using, a=
nd is there anything fancy on the server-side (like HA)?  Is it possible th=
at you have clients with the same nfs4_unique_id?
>>>>>>=20
>>>>>> Ben
>>>>>>=20
>>>>>> On 13 Apr 2021, at 11:17, hedrick@rutgers.edu wrote:
>>>>>>=20
>>>>>>> many, though not all, of the problems are =E2=80=9Clock reclaim fai=
led=E2=80=9D.
>>>>>>>=20
>>>>>>>> On Apr 13, 2021, at 10:52 AM, Patrick Goetz <pgoetz@math.utexas.ed=
u> wrote:
>>>>>>>>=20
>>>>>>>> I use NFS 4.2 with Ubuntu 18/20 workstations and Ubuntu 18/20 serv=
ers and haven't had any problems.
>>>>>>>>=20
>>>>>>>> Check your configuration files; the last time I experienced someth=
ing like this it's because I inadvertently used the same fsid on two differ=
ent exports. Also recommend exporting top level directories only.  Bind mou=
nt everything you want to export into /srv/nfs and only export those direct=
ories. According to Bruce F. this doesn't buy you any security (I still don=
't understand why), but it makes for a cleaner system configuration.
>>>>>>>>=20
>>>>>>>> On 4/13/21 9:33 AM, hedrick@rutgers.edu wrote:
>>>>>>>>> I am in charge of a large computer science dept computing infrast=
ructure. We have a variety of student and develo9pment users. If there are =
problems we=E2=80=99ll see them.
>>>>>>>>> We use an Ubuntu 20 server, with NVMe storage.
>>>>>>>>> I=E2=80=99ve just had to move Centos 7 and Ubuntu 18 to use NFS 4=
.0. We had hangs with NFS 4.1 and 4.2. Files would appear to be locked, alt=
hough eventually the lock would time out. It=E2=80=99s too soon to be sure =
that moving back to NFS 4.0 will fix it. Next is either NFS 3 or disabling =
delegations on the server.
>>>>>>>>> Are there known versions of NFS that are safe to use in productio=
n for various kernel versions? The one we=E2=80=99re most interested in is =
Ubuntu 20, which can be anything from 5.4 to 5.8.
>>>>>>=20
>>>>=20
>>>>=20
>>>>=20
>>>=20
>>> --
>>> Chuck Lever
>>>=20
>>>=20
>>>=20
>>=20
>=20
> --
> Chuck Lever
>=20
>=20
>=20

