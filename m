Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8DC86836DE
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Jan 2023 20:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbjAaTzJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 31 Jan 2023 14:55:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbjAaTzD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 31 Jan 2023 14:55:03 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2103.outbound.protection.outlook.com [40.107.244.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6616859269
        for <linux-nfs@vger.kernel.org>; Tue, 31 Jan 2023 11:55:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QO3HgazWyZvECkAWtmhJszUSjYGOxQKLCTpXbdFfu/98SwBkf9AMsGTeXQ+lieDB8htkfauqFapDjC3z9kgEuTBZTJEkjVpqZA3tVDwP0Uf/OrrRsiaFXgunbzNZV2zBIfV193L5KxxwwwmWM3f7xdMXQAy1Tv/dDQTL3L6+Ys6JJpeYqnNr11FjuJ3JuSuxgGsRmw2BejQZqH5bAMmBYCfW8VQmcY1STbvXuXrj9gFAIojDrxvQrm7i9SSTur/xjQfIL3RHL+bdrYZFP5gHuSVk056QHEAz5b3lk/nOsT6eD0Ngb4Bbl+Aj7vF945T2NctiUb2Oh+9zpEhzwoFzJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i2DEOPcKAyr2gnkN0v2T8gf4WtyAgtcEH2OXRWnSXfU=;
 b=SnWLyI+zMFYdiSs0LHvIqxXPoUy3vHAPpknBYC6Te0AnO3d0YZuEttMiBUpHtd6DqL5qSJdh4v8WtKBohSY8xENqN/0uR9zV2VgpCZLIIIePKQeuJb8HUXVioPxxU83g/G+s71+/IoeUcvi+PL693ZWKFUMGFu3srQnAqKQ4gI7Ta3TfwbOcp+j4/3BaSwdXL9gd7YCMLPwbNpDJub7EcTf13n2f2ip9xx/S3xVzQMh69cFD1fpjL0T15SBFSNw3/H0yTxd2PDes/AaQlymulS1qYGgKBtwyPDWGgulS4ArLImD8JNzUx6+wZKCGBme9X2C2SyYvQtc13mwf/pIYFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fnal.gov; dmarc=pass action=none header.from=fnal.gov;
 dkim=pass header.d=fnal.gov; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fnal.gov; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i2DEOPcKAyr2gnkN0v2T8gf4WtyAgtcEH2OXRWnSXfU=;
 b=Tx5lMD18fIgJb0Ak62Jrx+PJ+nvXw0NJL10NfDnY9+7MLKMfT+q4qSNMrRdiFO6Ua95j01LvxREOrl/lImN0RA7Dt4qeKemVG4BswsHzzKVr5hP7tVcZU4SI267V3g+SQdGrAsEH0OD/KC8jQhE6lCsz0ID1eaL+LEELwC0fd6Hp4TiwtdEfdfXLnJ8M5pehQLkj3SMxIc8gwyH25jsDRHkctgY3FyqICAnB13HSdGMXy6nJCf5TRxgmw3o3sMB9BUvQPQ2d23XHWzGlwYomlDWyCe7fc6m0wBcQjZWfS/DHA5Q1Pqh408p5q6LbeP6MCYw8Q4WyZiHSk5ggAI4+LA==
Received: from SA1PR09MB7552.namprd09.prod.outlook.com (2603:10b6:806:170::5)
 by SA9PR09MB5869.namprd09.prod.outlook.com (2603:10b6:806:43::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Tue, 31 Jan
 2023 19:54:59 +0000
Received: from SA1PR09MB7552.namprd09.prod.outlook.com
 ([fe80::2826:5e6f:8093:45f9]) by SA1PR09MB7552.namprd09.prod.outlook.com
 ([fe80::2826:5e6f:8093:45f9%7]) with mapi id 15.20.6043.038; Tue, 31 Jan 2023
 19:54:59 +0000
From:   "Andrew J. Romero" <romero@fnal.gov>
To:     Olga Kornievskaia <aglo@umich.edu>
CC:     Chuck Lever III <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: RE: Zombie / Orphan open files
Thread-Topic: Zombie / Orphan open files
Thread-Index: AQHZNPfbZsyiVLox/EunGMra5E7rNa64haaAgAATyXCAACB5gIAAAJ1QgAAwxICAAAFS4A==
Date:   Tue, 31 Jan 2023 19:54:59 +0000
Message-ID: <SA1PR09MB7552C7543CE6E9D263C070D4A7D09@SA1PR09MB7552.namprd09.prod.outlook.com>
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
In-Reply-To: <CAN-5tyHOJ=qXUU73VsZC9Ezs7_-eZ46VDtiE_DWB3bdyr768gA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fnal.gov;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR09MB7552:EE_|SA9PR09MB5869:EE_
x-ms-office365-filtering-correlation-id: 91fa1e10-7585-491d-82f8-08db03c508e7
x-fermilab-sender-location: inside
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9/vYLebjR/vF2AZVGgkB93t1nJ4Z6iS4i1Sf0pMfeJqvlYyvmFzdrx3qzkFgxq5ANAFqJuGVm0Hizu/foJqa/6oQVvlw6oq2LFPtQhUKjIf1hdAsFnzxj/zO2PgdqbWZWUWGUXzaivRkzDLAltuEUCQAFEuJS7FJGstV8FT4idMj+zcouFqa5E1AJ9SK205DEkfHjfFfoW4sWextKjzo/JhhwXLJNP+HBuRHJUhE5Y3KUQedf31joW4QL+cpvZ5g/OeUS7qbDOSeiHksikAOslanZ8X7463Qjdca6gq4OCfbAkyt8/4gXmWdCyIizU3jlO2kFvFi3KGuAvpRPu9r7UxsRZRl4lkYPLxXxEKrxdWG9rMhgwmlMWIYixhVM8JdK/hMnI+nSIkgv5G5ZrqTIARnfiBR2MLsHz4G52WSqMLnETnbD9DqlRwrXTsHwtzxFmr/EodPXsKIerM81bcl9zWUJnIFzxij1gSJ4sFyZJ1+obwZUceiOGnYR2ShxmWp6q4RR+g045LXX9xCbb396fzMFMqeGPTJxFEKcURsi+0nAp7a+aL9gEyxkTBqufbwwH/7KhI7I0/dEir+jadqEPnWZRrUtJuxb9d9F30FWEJ1D9p4EAC1lZp17GSdxXulgihjq0UKlNQyfygHgMeXP1qTjJfAGziGeDJoPXcMuAEcIOpfZRbHFYe5bYik4FV0yACO3+LEiABoIhtO6mI51g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR09MB7552.namprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(451199018)(6506007)(6916009)(186003)(66556008)(26005)(4326008)(66476007)(66446008)(508600001)(64756008)(8676002)(9686003)(76116006)(66946007)(7696005)(38100700002)(122000001)(71200400001)(83380400001)(2906002)(52536014)(8936002)(86362001)(82960400001)(55016003)(33656002)(5660300002)(38070700005)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RmNic0s2ejB1b3YvUjZSYmtTZWxsL0NueUtyZ2NqM2VoajJXQk1tL3RpWGRP?=
 =?utf-8?B?cGFqOVhoL0Vsc2VwN2lZTFRwZmloYlpSeWQvTUduUko2ZHd2ZGk0K2lDNFJ1?=
 =?utf-8?B?NDJXTFF5aS85UURncktobFE5bk1EeTVQME1WQXN5bHZoa0JlSHk2UnJQSWNz?=
 =?utf-8?B?Zkh1VGJxbmFaZU13dkpOVENscERyM0hnazc0TEJWbUFyYWFOZC9TNlEwWURi?=
 =?utf-8?B?cDVwRkIwZklBVmVCeUw1dncwR1NacTdKeU90MmxQR3NENkhucllWcnhBOVZQ?=
 =?utf-8?B?Wmtvb3VKS0pkdVZTWkJrenM0elRCdi9HNzFvK2VybUJ3MC9WczVYKzVEUW9p?=
 =?utf-8?B?bHVXQktMckhyZ0NRNXpmSmxMMFdjci90bGY5dFRZWlh3R1F3eitZb01OY2hW?=
 =?utf-8?B?enNEMEYrSGV5cS9jczZIVzBFRzgyWVVWaEhnTnI1YXJTUDJ4c3RqYXZCc2tL?=
 =?utf-8?B?NEgwUHJ5alNnekkvN2dXT1ViMFJRUHFMZEphdjNQVjhQS2tmREFLbUR5cG5M?=
 =?utf-8?B?eGt3OTltNUhvQXU2NWIyNlR6QmJUWkNmeERlV0RMSGJTVlRiSkhDUWpsc2ZP?=
 =?utf-8?B?STd2N09FdUx1dW0ydGZJRi8weWxhNHFxTGVvdlRraFpNWlF2MDlmYThjNGVE?=
 =?utf-8?B?UkJtUDN1azF5TTdLRVBpK1F0SG05Y0FMancvUi9sd0hvazdTdFdodG5XUDlj?=
 =?utf-8?B?Wm9PVHZmK3NOU0NrUkx0ZXBCYzF2RFhJeFVZQ3JJMk8xbVJmUHBYWkF5ejVW?=
 =?utf-8?B?ZzR6SmkrSW1NNXV2dUlpL1JtTTBoQ2R1dTJYZFUvcW9EUTF4eW1vS1hyNVpa?=
 =?utf-8?B?RzhDVVFFQjh6RWZEN0ttYlkzVnBybERnU1owTjZ1SSt1a3hTTFNrMEM3eDVl?=
 =?utf-8?B?VWJ1Nm44bXNIcG5oa1JOYUxzeU5DcGx1RS80ZHhiVmY5VXVaaEx6Szg4OHl0?=
 =?utf-8?B?MmZKOEFaS0Q5K2NNa3Z2dDJiRk1qK0ZoRmo1UTVNV3FaYkpGMERFRnZWdTlJ?=
 =?utf-8?B?RDB1cjFVTHFnOG1VZzcybW56TktzbjJMKysxNEhtbThBZFRlWE94T1NhWmxQ?=
 =?utf-8?B?alh2VUJybzNzZ3JCNTBhb0JMcTUxVGxSQUJrNUlENkx2bHZET2JOYVBiNk8v?=
 =?utf-8?B?Ty9vRUJNNmt1THh3NG9WNUtHRFVETmdaNERvaENBOStDZlpxOU5IOTZMVVkv?=
 =?utf-8?B?Ly9MV0grSHFzZGZjc3FWUVdrZmZoUkJ2STRBTThnVVhpMXZQL3hCenU2dUsr?=
 =?utf-8?B?QkszSmVrSWRxZVRrVnRNTFExemlMYTZPS21FLzlhTEVEZndPWHJEcGNtNWds?=
 =?utf-8?B?YkdjTU1Ta05rcFc3VldFczNaTHpZckt0LzFEZi9QK2NQK0JCdUNpb1ZLbnVs?=
 =?utf-8?B?eVR5MzFJOXA2QzVoOTdQcjRvelhBUzl1bDhycDVQY1oxM0tMaC9UaU5nenJB?=
 =?utf-8?B?dGhFTFlPaEdGbGEvMU4yQjB3TS9zY3gvWExtMk44OHR1N3FodG14cmxEOHVP?=
 =?utf-8?B?MWkzVDcwTWp0ckRZRHplWmJwSnR1VmErTHM3VDdpbTFvS2FWcWVXMUYrZ2x6?=
 =?utf-8?B?aHF1cDN2bm1tcWJNY05pZktSOW1JZ2NndzFtMlhNZjdGeXlaNXRKenRXMmpx?=
 =?utf-8?B?eTY2KzRVWkRaenV1ODF1WC9ocW9vQm0wREdaMURwRWYvNkNmNW1kSUEvaUxq?=
 =?utf-8?B?aFErc0RXbnMwckdrY3Y1QkoxazNXUS8yb2MxalhyZ1gvdVRubTloVEJ1bko2?=
 =?utf-8?B?QnhDdENmRlVkalhnbzlTWVlGeXEyaDFPc3UyYXl4cXNLTk8xU1BsSHB1allU?=
 =?utf-8?B?U0k0QzZlSnI3MXdHUnJibEh5M1U3YzNTMWUyYWtyZ1JqRndibndvbk9lVlJJ?=
 =?utf-8?B?bVNsQk5QNXpFemFPZzJhWkhzWFM3QUFzMVJkd25XdW1oT0ZPbm9KeGhlOHFm?=
 =?utf-8?B?MVc3VmZiQUE5WW1yV2dxM2VFbC85UWh5MTkzSHZMZ0RUaXVSL2tIeTJOVVpS?=
 =?utf-8?B?WEwyY1AyVGc1anpCNVBWbjR2RW9HZi8vTWlWVm1nZ3A3NFJxdXdrTnUxRkIw?=
 =?utf-8?B?TW84U1VpMmVRVldIblRSaHVKUTJIMU5BU1lYYklabUhpRzBpdlI3aDJDeUNq?=
 =?utf-8?Q?HiawfNyneKXLqnFShV/bgq5Vo?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fnal.gov
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR09MB7552.namprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91fa1e10-7585-491d-82f8-08db03c508e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2023 19:54:59.5575
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9d5f83d3-d338-4fd3-b1c9-b7d94d70255a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA9PR09MB5869
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_GOV_DKIM_AU,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQoNCj4gV2hhdCB5b3UgYXJlIGRlc2NyaWJpbmcgc291bmRzIGxpa2UgYSBidWcgaW4gYSBzeXN0
ZW0gKGJlIGl0IGNsaWVudCBvcg0KPiBzZXJ2ZXIpLiBUaGVyZSBpcyBzdGF0ZSB0aGF0IHRoZSBj
bGllbnQgdGhvdWdodCBpdCBjbG9zZWQgYnV0IHRoZQ0KPiBzZXJ2ZXIgc3RpbGwga2VlcGluZyB0
aGF0IHN0YXRlLg0KDQpIaSBPbGdhDQoNCkJhc2VkIG9uIG15IHNpbXBsZSB0ZXN0IHNjcmlwdCBl
eHBlcmltZW50LA0KSGVyZSdzIGEgc3VtbWFyeSBvZiB3aGF0IEkgYmVsaWV2ZSBpcyBoYXBwZW5p
bmcNCg0KMS4gQW4gaW50ZXJhY3RpdmUgdXNlciBzdGFydHMgYSBwcm9jZXNzIHRoYXQgb3BlbnMg
YSBmaWxlIG9yIG11bHRpcGxlIGZpbGVzDQoNCjIuIEEgZGlzcnVwdGlvbiwgdGhhdCBwcmV2ZW50
cyANCiAgIE5GUy1jbGllbnQgPC0+IE5GUy1zZXJ2ZXIgY29tbXVuaWNhdGlvbiwNCiAgIG9jY3Vy
cyB3aGlsZSB0aGUgZmlsZSBpcyBvcGVuLiAgVGhpcyBjb3VsZCBiZSBkdWUgdG8NCiAgIGhhdmlu
ZyB0aGUgZmlsZSBvcGVuIGEgbG9uZyB0aW1lIG9yIGR1ZSB0byBvcGVuaW5nIHRoZSBmaWxlDQog
ICB0b28gY2xvc2UgdG8gdGhlIHRpbWUgb2YgZGlzcnVwdGlvbi4NCg0KKCBJIGJlbGlldmUgdGhl
IG1vc3QgY29tbW9uICJkaXNydXB0aW9uIiBpcw0KICBjcmVkZW50aWFsIGV4cGlyYXRpb24gKQ0K
DQozKSBUaGUgdXNlcidzIHByb2Nlc3MgdGVybWluYXRlcyBiZWZvcmUgdGhlIGRpc3J1cHRpb24N
CiAgICAgaXMgY2xlYXJlZC4gICggb3Igc3RhdGVkIGFub3RoZXIgd2F5ICwgIHRoZSBkaXNydXB0
aW9uIGlzIG5vdCBjbGVhcmVkIHVudGlsIGFmdGVyIHRoZSB1c2VyDQogICAgcHJvY2VzcyB0ZXJt
aW5hdGVzICkNCg0KICAgQXQgdGhlIHRpbWUgdGhlIHVzZXIgcHJvY2VzcyB0ZXJtaW5hdGVzLCB0
aGUgcHJvY2Vzcw0KICAgY2FuIG5vdCB0ZWxsIHRoZSBzZXJ2ZXIgdG8gY2xvc2UgdGhlIHNlcnZl
ci1zaWRlIGZpbGUgc3RhdGUuDQoNCiAgQWZ0ZXIgdGhlIHByb2Nlc3MgdGVybWluYXRlcywgbm90
aGluZyB3aWxsIGV2ZXIgdGVsbCB0aGUgc2VydmVyDQogIHRvIGNsb3NlIHRoZSBmaWxlcy4gIFRo
ZSBub3cgem9tYmllIG9wZW4gZmlsZXMgd2lsbCBjb250aW51ZSB0byANCiAgY29uc3VtZSBzZXJ2
ZXItc2lkZSByZXNvdXJjZXMuDQoNCiAgSW4gZW52aXJvbm1lbnRzIHdpdGggbWFueSB1c2Vycywg
dGhlIHByb2JsZW0gaXMgc2lnbmlmaWNhbnQNCg0KTXkgcmVhc29ucyBmb3IgcG9zdGluZzoNCg0K
LSBBcmUgbm90IHRvIGhhdmUgeW91ciB0ZWFtICBoZWxwIHRyb3VibGVzaG9vdCBteSBzcGVjaWZp
YyBpc3N1ZQ0KICAgKCB0aGF0IHdvdWxkIGJlIHF1aXRlIHJ1ZGUgKQ0KDQp0aGV5IGFyZToNCg0K
LSBEZXRlcm1pbmUgSWYgbXkgTkFTIHZlbmRvciBtaWdodCBiZSBhY2NpZGVudGFsbHkNCiAgbm90
IGRvaW5nIHNvbWV0aGluZyB0aGV5IHNob3VsZCBiZS4NCiAgKCAgSSBub3cgZG9uJ3QgcmVhbGx5
IHRoaW5rIHRoaXMgaXMgdGhlIGNhc2UuICkNCg0KDQotIERldGVybWluZSBpZiB0aGlzIGlzIGEg
a25vd24gYmVoYXZpb3IgY29tbW9uIHRvIGFsbCBORlMgaW1wbGVtZW50YXRpb25zDQogICAoIExp
bnV4LCAuLi4uZXRjICkgYW5kIGlmIHNvIGhhdmUgeW91ciB0ZWFtIGRldGVybWluZSBpZiB0aGlz
IGlzIGEgcHJvYmxlbSB0aGF0IHNob3VsZCBiZSBhZGRyZXNzZWQNCiAgIGluIHRoZSBzcGVjIGFu
ZCB0aGUgaW1wbGVtZW50YXRpb25zLiAgDQoNCg0KDQpBbmR5DQoNCg0KDQoNCg0K
