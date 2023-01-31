Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7041E683952
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Jan 2023 23:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbjAaW0s (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 31 Jan 2023 17:26:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbjAaW0r (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 31 Jan 2023 17:26:47 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2112.outbound.protection.outlook.com [40.107.95.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57AB4AB
        for <linux-nfs@vger.kernel.org>; Tue, 31 Jan 2023 14:26:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Se0ww0dD96gXG++h6AnnATFmG2/Y+nex0D5rA+kLtwy3SK9kPqR0YloW2EnAEL9tvJadxmOAL+12S2Ny66mKS15THcJpH/HR6rrpkjESR2GYpHzMuu+WaSFP3dOv5zQE/PaBMKuU18pOHZJI/WxxyYgx0Da2B8Pkk1yrdaA5ZronOWCpEiGFkM7cxKvxgiZjolATWK0X/vhoe5sjv0M/RUc3HkwgDJxeGHG1dTertqbfq1jJWAt32cWpi3L871O7/RffvFPbC8IthvSRZ4o+3zDmgVvDzOlI8b4tl5ucDXSHvsBAPmVoUdn+2dmQdhiIA//xdR6ASe7CoccDBsNITg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XNfURy3brJVVsw2q47YbkgHoWTXfSP9q7loBXV/HzGg=;
 b=c3jjwRIumDOZxevEdpUxs+bokjNYjxjiWX6YmcWSJFfrOEH/fmucEoxupijDUvwz3GYzMoFcn5p95MA9mCc807O9LM1IcJcYZi6OegIo1ffMcjbG2gdG0k5C/KHcQJDV4JfLdtSg2gup7uWscCsQroiGT2LtyCAJzvv9G5FWFwzdWePQEYWpYqs8E6gjIN9J3/wkubhO6/a6LmeKkwFx9efEG/J/0UL2IUIVR9uga6PGPHnZUbHve/XpCWX7Wvi07t53lfr5iiOQGLWdUIUCyD+SeRtcqU0YMXB4aPPZmFNRDL1UFdp6ipJM/+VLG0DH8JIE6m/FTZ3eHhhbLq76fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fnal.gov; dmarc=pass action=none header.from=fnal.gov;
 dkim=pass header.d=fnal.gov; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fnal.gov; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XNfURy3brJVVsw2q47YbkgHoWTXfSP9q7loBXV/HzGg=;
 b=QvG8eU7yK08iIH4H0zbrrq6/0tHxJKvZDNRWdsuN/4FxNMnqIHz2xG8S79ed/QeEJ3rY8alGhvi1ArSY6N0HAc3MMFSemTVSWh26WSH6ijxyC/22bv1tvdfA9T15brRAjUfpxk1BVB3ZmuI4iCo7nzG89N1Q08IlWbzh1rkyZckMPVg7/QdnV0p+NcGl7g0l1B7jfY99quvX8k3bfFt88R0JA+iBg3OEH7HiAEBPp+T7kqNe/9Jx/Y3IHKTg28bZL8TGqsS+WiKhTskgeA9CJnaCy5HsUSSzAwD9VkkjXj9o65PIJ/HgbxPgJcYMAfBDMr6Eon9cS1u2t4VmXsKZKQ==
Received: from SA1PR09MB7552.namprd09.prod.outlook.com (2603:10b6:806:170::5)
 by DM6PR09MB4967.namprd09.prod.outlook.com (2603:10b6:5:272::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Tue, 31 Jan
 2023 22:26:44 +0000
Received: from SA1PR09MB7552.namprd09.prod.outlook.com
 ([fe80::2826:5e6f:8093:45f9]) by SA1PR09MB7552.namprd09.prod.outlook.com
 ([fe80::2826:5e6f:8093:45f9%7]) with mapi id 15.20.6043.038; Tue, 31 Jan 2023
 22:26:44 +0000
From:   "Andrew J. Romero" <romero@fnal.gov>
To:     Olga Kornievskaia <aglo@umich.edu>
CC:     Chuck Lever III <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: RE: Zombie / Orphan open files
Thread-Topic: Zombie / Orphan open files
Thread-Index: AQHZNPfbZsyiVLox/EunGMra5E7rNa64haaAgAATyXCAACB5gIAAAJ1QgAAwxICAAAFS4IAALB6AgAAATYA=
Date:   Tue, 31 Jan 2023 22:26:43 +0000
Message-ID: <SA1PR09MB7552674B97042D59646F6EF1A7D09@SA1PR09MB7552.namprd09.prod.outlook.com>
References: <YQBPR01MB10724B629B69F7969AC6BDF9586C89@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
 <YQBPR01MB10724AEE306F99C844101EED086CF9@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
 <YQBPR01MB10724F79460F3C02361279E8686CF9@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
 <654e3b7d15992d191b2b2338483f29aec8b10ee1.camel@kernel.org>
 <YQBPR01MB10724B36E378F493B9DED3C7E86D39@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
 <3c02bd2df703a68093db057c51086bbf767ffeb1.camel@kernel.org>
 <YQBPR01MB1072428BC706EE8C5CC34341186D39@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
 <936efa478e786be19cb9715eba1941ebc4f94a1b.camel@kernel.org>
 <SA1PR09MB75521717AA00DCAD6CAB5118A7D39@SA1PR09MB7552.namprd09.prod.outlook.com>
 <2bc328a4a292eb02681f8fc6ea626e83f7a3ae85.camel@kernel.org>
 <SA1PR09MB75528A7E45898F6A02EDF82EA7D09@SA1PR09MB7552.namprd09.prod.outlook.com>
 <0BBE155A-CE56-40F7-A729-85D67A9C0CC3@oracle.com>
 <SA1PR09MB755212AB7E5C5481C45028A8A7D09@SA1PR09MB7552.namprd09.prod.outlook.com>
 <CAN-5tyHOJ=qXUU73VsZC9Ezs7_-eZ46VDtiE_DWB3bdyr768gA@mail.gmail.com>
 <SA1PR09MB7552C7543CE6E9D263C070D4A7D09@SA1PR09MB7552.namprd09.prod.outlook.com>
 <CAN-5tyGdaL_pYgqgS0TDwqCzVu=0rgLau8TDZMTe+hmC395UtQ@mail.gmail.com>
In-Reply-To: <CAN-5tyGdaL_pYgqgS0TDwqCzVu=0rgLau8TDZMTe+hmC395UtQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fnal.gov;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR09MB7552:EE_|DM6PR09MB4967:EE_
x-ms-office365-filtering-correlation-id: 189a1565-6ca8-454e-6011-08db03da3b8f
x-fermilab-sender-location: inside
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rvL2rC3Wl5prOeOTRnU1KfiZgx+f7EzzEVf57jHpOwVoQt001nD5bpuZ3blXHcvXH2zdF7YJAvxLDXXNZmMCpluv7L+wErwoyXVxvCCQI0jvBbQnRMbtJGkQohGKaqN1V0hdY8xAHTmyzXcdc5R3ihGskAlYGctHT2PUXFRjdqys7H/TFad3B+ZiBsuK5Za+2s43VOmhHeZ7+biF3j1/cMkLF0adt6YOjwszHKJ2dwipvr+4cIOE0ZnRsQgxjMYfXB0w9f8mql4FInfx4eLb0C9WNRJaPevnghh+u2QuYGsnAEmI6CEZK4bl+SNQu5RNn0udVadkN/rvxhR+tXw06m8nt/KTQe6bGebhLCw6LBTSWQwgyhl7mc1hJwDugCj5KuefJAPQDygA25JAgdjBXlQnqYgzG5ftsYdc6acoYwCO4Wq2C+8vTvEYNRdTTaSybz2QDf6IoQxBYSPfBSidkYUXUGPEMt8DhPyeSzJY14z+gXbPwpDhtk4xNf0Qm/IL9XYx+//4aXDwxOxv7jWnxUfKrGUN70u+FDjBnJOItwtUb+7wTZAwm4LJgM5jHK2liaCmUngkFHzOfbYCZ0uQxZeGB/t6+7luMZktIAfX7YqxGx1hzmvaHGyvPeS6HHZ1mz13fcm4wPxECXdW2awYM4InxILruZB4PtQ8nxIvV10ZayossmOfGIx9pYlD+IxMgfxq0Fom0xiwpAC3iWOr1w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR09MB7552.namprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(451199018)(66476007)(83380400001)(33656002)(86362001)(6916009)(66946007)(64756008)(82960400001)(8676002)(66446008)(38070700005)(4326008)(55016003)(76116006)(2906002)(7696005)(508600001)(6506007)(5660300002)(54906003)(66556008)(26005)(38100700002)(8936002)(52536014)(9686003)(186003)(122000001)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UzdFbEdGVEJjaDZSdi8xemFFSzhCeWN4bjdVRkkrTVlud0xEeEVhMitybzZI?=
 =?utf-8?B?Q3h1eVd3L2ZZRUxkRExRTlFtcmpxZGovdTFaRzZPcHVTU09iNGh3dllPR1pp?=
 =?utf-8?B?NW9xei9FU2xZUHllTklnSlhqbjNJb2lrVjZUWHh3NDBxSDRVSlBFOGV0OFN0?=
 =?utf-8?B?QldoRXdMT0xLb2hOeTJaMFZWbmFyQ2ZLcUpORnBxbTBsZERybVc2c0pKWEFi?=
 =?utf-8?B?WExlaFNaSGtyZ04yVjQyV2ZaZDJReXdwY2lhcnd1M1Z6elg1Q0ZOY3kwOWNn?=
 =?utf-8?B?RHd3bVRyblVyb0tUUElXMGZDRkZocjJHNVlWZFB5NmlLVUZORG5IMG1YcVU3?=
 =?utf-8?B?Z3ZwM05pdk9VVUJTTVJweVI1RUVBWGl0N1VDTGI1TC9UUnlMOGFsU2ZVd0lh?=
 =?utf-8?B?RkxBdkNlYWdwa0swUEgwYzRSenYyNVUrZ2xreWMyZUk2cDJlZEQ4aTBSWmQx?=
 =?utf-8?B?SklJdUhOSmljMCs1WFdiRWRTS0F3MTV6MC9ZOGxPencwQndzMFVJREFxK29L?=
 =?utf-8?B?aXZjbEpNOVNaejZNeDRTRXZ6UmdaZVh2Ump5Y3FlbUxrNGF3QUNMS2lxWTZM?=
 =?utf-8?B?dElOWXVRU3hvK3pKa1BobEhtOHVtdW1qZE8yZFZjUW1ULzFwYkFTVnZQaE85?=
 =?utf-8?B?N3BFZmV1NVRYSG9xZUU0WWRHOUtQL3ZWZWdLWjB5bjFUdXpvbDMxR3FUcG13?=
 =?utf-8?B?b3dyQTdLa05TSXY4TDBtTXdmOS94VkEvcVFDWCtSL2ZXdVlvK3ZKK3BENndE?=
 =?utf-8?B?WWJMYjdsZzNoWkpTdS9wMGlUaEU0QUFEUjQvZmhzc0R4aVM1RUJrMUFJMmY5?=
 =?utf-8?B?N0JtcXFZT0pqQUdlMzYxTDNSRENuelRBSGg4QTE0TGNvbGgwUEFpSkFOOGV2?=
 =?utf-8?B?TTZ0T2hXbS9GNHpMTmQvQlc4WmNBRC8zSlMzdmhrd2daMTRYZ0xvM1AwZDJl?=
 =?utf-8?B?ZE9FRlR5QmFQWEtBVXBYUTBMRzdsdXVZUExYS3h2dGxjS3g0bjRJU0d2SE9X?=
 =?utf-8?B?SDdpRVhnYm1Ud2JYT3FrOFRWQlBaTDZIanh1ZlRBYkxUZ1g1RjVEYy9QSWVS?=
 =?utf-8?B?ZzdzWjd3MHhTZnRhQjFjSldxc1cwL2x1dlRkSGpUczZBUzVqbXYwNEZDZm5P?=
 =?utf-8?B?NFVnWmlsSlEzK2tlOXNkZS9uTlY3ZVFGV0cxc2lWWkpiUDFJbmRCT0twNENl?=
 =?utf-8?B?d1hWNW5idzA2QU1rcm9UcUJuRllYYjhaYVVqSWpFVnkxLzYvRVdwSy91YTZF?=
 =?utf-8?B?QVdkeXlLMjI4L25JU3loL0FPZEVHaTdUMTBrKy9RUjVGcWZFS0RmUWtsK3hq?=
 =?utf-8?B?UDZQN3ROa0dOWllBNUlBZTA0cjdDM013N3kybXA5aCtMRWE3Zktac1IrV09v?=
 =?utf-8?B?cmhzOUJwVWZsNXJsS01qVUN2RlVUS0x4dU5TVlRjQmJEN3FjNGZ4RWhxeDRL?=
 =?utf-8?B?dHV5NERQSUpjUXhKMEFMOWRlWVQ0SGdsRXE0M1BZdFhTWm84QVI3ZUo3Qjdm?=
 =?utf-8?B?ZkgvYVNHTTduQWI0bTU3bThiMW5teW5TblA4Zk51RC9YbG9qS0RBK3VGa1Z3?=
 =?utf-8?B?K2VXSE9EVzdpZldQdjFvRkxjVFNaVDFDZWZERVVWYncydDF6bGpKSS9vdU9k?=
 =?utf-8?B?OXJDZ1NETmNBZ0RoTEdyd3ZCbWFrL2hXZ2I0VDZUbnNrVlhTQVZSVVZXTWxq?=
 =?utf-8?B?YmJiQlBUVS9xWFd6RHBoV2t4WmU1aDArUGlMMnowSlhkWFdSUmxDYmJKNUZm?=
 =?utf-8?B?Sis3TVBPekVucHJtUVN6dmxQTG9UaWh3bDFpRC9jV1NKVnBZbjIxS2g3T08x?=
 =?utf-8?B?Y1IvdHNFaWYrK3FJM0pzcnJDYkphWmU0QmdZTEk5N3ZQNlErOWdYMmdscFU5?=
 =?utf-8?B?Q0YwbStCVzhpTWVBRXI3NzBGbE9obHJiaVJrN3BzaXNXcHBsTkl6eGtKYzZQ?=
 =?utf-8?B?bnA1V1k2RlFUa3lnRFo0b2RtQzNqNFFhM3RhQlhXWkhZNHdYZDdVYlFVQzJC?=
 =?utf-8?B?U0lrcUVURC93c1had2luMFl3dE05SmtDQjJtV3dJSzdJcUVhV2R5S2JaSENJ?=
 =?utf-8?B?YWhySTdXR2E3ajV3aFFHWUZ6blFmbHJNbk4xN0MrQVFHSmoxeGVlSVNrOEJD?=
 =?utf-8?Q?O+xwais2GGwxvq2K5Rt794pxR?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fnal.gov
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR09MB7552.namprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 189a1565-6ca8-454e-6011-08db03da3b8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2023 22:26:43.9906
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9d5f83d3-d338-4fd3-b1c9-b7d94d70255a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR09MB4967
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_GOV_DKIM_AU,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

SGkgT2xnYQ0KDQpUaGlzIGlzIGdyZWF0IGluZm8gIQ0KDQpDYW4geW91IG1ha2Ugc3VyZSB0aGF0
IHRoZSBob3N0IHByaW5jaXBhbCBpcyBub3QgZ3JhbnRlZCBhbnkNCnJlYWQgb3Igd3JpdGUgYWNj
ZXNzICggdmlhICBBQ0wgZW50cnksIG93bmVyLCBncm91cCBvciBFdmVyeW9uZSBhY2Nlc3MpIA0K
dG8gdGhlIGFjdHVhbCBkaXJlY3RvcnkgYW5kIGZpbGUgYmVpbmcgb3BlbmVkLg0KDQpJZiwgYnkg
c3BlYyBvciB3ZWxsIGVzdGFibGlzaGVkIGNvbnZlbnRpb24sICB0aGUgY2xpZW50IGhvc3QgcHJp
bmNpcGFsIGp1c3QgbmVlZHMgdG8gc3VibWl0IHRoZSAiY2xvc2UgcmVxdWVzdCINCnRvIHRoZSBO
RlMgc2VydmVyIDsgYnV0LCBuZWVkcyBubyBhY2Nlc3MgdG8gdGhlIGFjdHVhbCBkaXJlY3Rvcnkg
dHJlZSBvciBmaWxlcywgdGhlbg0KbXkgTkFTIHZlbmRvciB3aWxsIG5lZWQgdG8gdGFrZSBhY3Rp
b24uDQoNCklmIEkgbmVlZCB0byBncmFudCBkaXJlY3RvcnkgLyBmaWxlIGFjY2VzcyB0byBhbGwg
aG9zdCBwcmluY2lwYWxzIG9uLXNpdGUNCkkgd2lsbCBwcm9iYWJseSBnZXQgc2VyaW91cyBjb21w
dXRlci1zZWN1cml0eSBvcHBvc2l0aW9uLg0KDQpUaGFua3MgIQ0KDQpBbmR5DQoNCj4gDQo+IFdo
YXQgeW91IGRlc2NyaWJlICAtLS0gaGF2aW5nIGRpZmZlcmVudCB2aWV3cyBvZiBzdGF0ZSBvbiB0
aGUgY2xpZW50DQo+IGFuZCBzZXJ2ZXIgLS0gaXMgbm90IGEga25vd24gY29tbW9uIGJlaGF2aW91
ci4NCj4gDQo+IEkgaGF2ZSB0cmllZCBpdCBvbiBteSBLZXJiZXJvcyBzZXR1cC4NCj4gR290dGVu
IGEgNW1pbiB0aWNrZXQuDQo+IEFzIGEgdXNlciBvcGVuZWQgYSBmaWxlIGluIGEgcHJvY2VzcyB0
aGF0IHdlbnQgdG8gc2xlZXAuDQo+IE15IHVzZXIgY3JlZGVudGlhbHMgaGF2ZSBleHBpcmVkIChh
ZnRlciA1bWlucykuIEkgdmVyaWZpZWQgdGhhdCBieQ0KPiBkb2luZyBhbiAibHMiIG9uIGEgbW91
bnRlZCBmaWxlc3lzdGVtIHdoaWNoIHJlc3VsdGVkIGluIHBlcm1pc3Npb24NCj4gZGVuaWVkIGVy
cm9yLg0KPiBUaGVuIEkga2lsbGVkIHRoZSBhcHBsaWNhdGlvbiB0aGF0IGhhZCBhbiBvcGVuZWQg
ZmlsZS4gVGhpcyByZXN1bHRlZA0KPiBpbiBhIE5GUyBDTE9TRSBiZWluZyBzZW50IHRvIHRoZSBz
ZXJ2ZXIgdXNpbmcgdGhlIG1hY2hpbmUncyBnc3MNCj4gY29udGV4dCAod2hpY2ggaXMgYSBkZWZh
dWx0IGJlaGF2aW91ciBvZiB0aGUgbGludXggY2xpZW50IHJlZ2FyZGxlc3MNCj4gb2Ygd2hldGhl
ciBvciBub3QgdXNlcidzIGNyZWRlbnRpYWxzIGFyZSB2YWxpZCkuDQo+IA0KPiBCYXNpY2FsbHkg
YXMgZmFyIGFzIEkgY2FuIHRlbGwsIGEgbGludXggY2xpZW50IGNhbiBoYW5kbGUgY2xlYW5pbmcg
dXANCj4gc3RhdGUgd2hlbiB1c2VyJ3MgY3JlZGVudGlhbHMgaGF2ZSBleHBpcmVkLg0KPiA+DQo+
ID4NCj4gPg0KPiA+IEFuZHkNCj4gPg0KPiA+DQo+ID4NCj4gPg0KPiA+DQo=
