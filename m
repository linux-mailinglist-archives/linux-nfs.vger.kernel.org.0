Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21AED68342C
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Jan 2023 18:44:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbjAaRok (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 31 Jan 2023 12:44:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjAaRoh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 31 Jan 2023 12:44:37 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2115.outbound.protection.outlook.com [40.107.92.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E10B4AA75
        for <linux-nfs@vger.kernel.org>; Tue, 31 Jan 2023 09:44:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S/TLh4HXlttXaPN+C3GXibZGd5xjRvbSwVwqNMFo2KliTO0b3x9dzP3Vm3C9OgcWv8ROcbS6YZwMNMELPkqBQbmDJy/QGvysbuDychYOeGXPLT/AZl0hMr7aRNJ5yNS6xDkDAeMcit31kzUEDl3ymlgG+WTy7pq0+1rBVOZyEkOf16lIt6pV+X3F2ANiI37WIW3hKAok7kqnN7QeLx/dBNowBg/zdopAyisdDP7xBI8NXyUXIRFekFtVF7gUMDiLTSgK5vH60L1KLUQOmt19cxpi7EFXs5J0T+PJ8wU2gnqSkR7p76FqFZdnZJBnnpbBXVZe9bxkaHujdV/bwhlsSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hOG4FLew3+7Dw+/+YbIy0NK0Of4u5W39GYWtOBKo9DY=;
 b=UfcTldR2Bt5oU6ktSJuO8oi25h2XNdo7HWPcBUT4gBon99Z2MijKEXqSBn1LnZdLuKjaNGhWcPcjuXVoQ6zIVfD9f7i8jW001CphqGkquLUC3MHzQW6DyHOOTxMxN34cTrzp5dJkT0adUoMaLg0nYsT8ziaxK6C6YqM+m6Fj69U35+lH9SChoJQW8Iz/b9c3su8JnS45gAPiHOOmSl/Emg/aNi152DAF1y5AI7LR/2EiUcXOUaxzSc02M46wp2nFaHfOiLO9cRLT+1YPRP8vqfeC2Lo1Znc7swbWb+72i5DKzp6AP2PG7Dgd6E93f0UGvRN6HSlxxXZjkDi9yIjydw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fnal.gov; dmarc=pass action=none header.from=fnal.gov;
 dkim=pass header.d=fnal.gov; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fnal.gov; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hOG4FLew3+7Dw+/+YbIy0NK0Of4u5W39GYWtOBKo9DY=;
 b=e/xMUWLFLokNTOxUvbjQQfUVcKA13w63m/FrKKfaekMZRp+71KGv2+sLhEV3UH8OBG7U4C+IM5b2Mqo6GS60SnV2Cthxk8ujwf6OWnQn5GHRR4ksM0oNgQEGecH1e5G0d3fCS9TrVun0HL72GunQHvoDY8zi5aXouykVEJpoxcTpqNpnXjDkXYI8gullrsTJfGPRZPW/2Iy3EVqCufxPVQOmNLZBPWzR0N6DIcrJdL468wZnR37e4InMHnLS+0tUzY6gI5V7KBzhD1R1Px3TRFjZEYQ4gg31mOaZnthJQ8w3lu+4cX++olweq+x4hXxBLiITJ8aSnd63HCb+eYB2OQ==
Received: from SA1PR09MB7552.namprd09.prod.outlook.com (2603:10b6:806:170::5)
 by BLAPR09MB7043.namprd09.prod.outlook.com (2603:10b6:208:288::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Tue, 31 Jan
 2023 17:44:33 +0000
Received: from SA1PR09MB7552.namprd09.prod.outlook.com
 ([fe80::2826:5e6f:8093:45f9]) by SA1PR09MB7552.namprd09.prod.outlook.com
 ([fe80::2826:5e6f:8093:45f9%7]) with mapi id 15.20.6043.038; Tue, 31 Jan 2023
 17:44:33 +0000
From:   "Andrew J. Romero" <romero@fnal.gov>
To:     Olga Kornievskaia <aglo@umich.edu>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: RE: Zombie / Orphan open files
Thread-Topic: Zombie / Orphan open files
Thread-Index: AQHZNPfbZsyiVLox/EunGMra5E7rNa64t7qAgAAP31A=
Date:   Tue, 31 Jan 2023 17:44:33 +0000
Message-ID: <SA1PR09MB7552C455D6DE6BA20C54C3B8A7D09@SA1PR09MB7552.namprd09.prod.outlook.com>
References: <YQBPR01MB10724B629B69F7969AC6BDF9586C89@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
 <YQBPR01MB10724AEE306F99C844101EED086CF9@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
 <YQBPR01MB10724F79460F3C02361279E8686CF9@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
 <654e3b7d15992d191b2b2338483f29aec8b10ee1.camel@kernel.org>
 <YQBPR01MB10724B36E378F493B9DED3C7E86D39@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
 <3c02bd2df703a68093db057c51086bbf767ffeb1.camel@kernel.org>
 <YQBPR01MB1072428BC706EE8C5CC34341186D39@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
 <936efa478e786be19cb9715eba1941ebc4f94a1b.camel@kernel.org>
 <SA1PR09MB75521717AA00DCAD6CAB5118A7D39@SA1PR09MB7552.namprd09.prod.outlook.com>
 <CAN-5tyFro=naMgub9uAZ0wa20WhZwV2Rh6xv_meNice1EG+Dug@mail.gmail.com>
In-Reply-To: <CAN-5tyFro=naMgub9uAZ0wa20WhZwV2Rh6xv_meNice1EG+Dug@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fnal.gov;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR09MB7552:EE_|BLAPR09MB7043:EE_
x-ms-office365-filtering-correlation-id: 11ea4a03-f909-4167-9771-08db03b2d04e
x-fermilab-sender-location: inside
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9mcJb8ASZSMsd/o24I2TA2w7j+VV8CG29txpwQ1mnhD4lDa+igDHw3LQRon7rmUs7f4DotVwIsuveGzTus8dSPJLUkfo72xi4nNXwu1nBOv6pYbGeYOJt6ViIhBfY3zUZ0mtG9e7+oSWZKPQk7KvGgAcAzxhXzc3wEDqCUAz52JE5tqoPm8gYVQyf7fuelfP5P59A+baD7oDtByNOb/p/uyzsMJEPoGq9SYNkJk2ZYWs9AAT+zykH9OrJNFq2HwHAqA2PcpCqQLLDCVG0cTJjDM2VbM5d36nfdJ+TcweIfuxzC3xGLFjTJ4SNN3ImQSfvsj0aTSzlg7scTuGGYOytanI6S21DQGzU8A0a2azwot4wFxFZXpuorW7S01XhsJfYNlMeFDwhM8xe8VZliYuBkls0vUom5v2p4MDX+6Mb6eD4fVnSmXvtpHk/fHoAZ8L++qdZuayzDpwkBXAmPBwy5Dwu5fj7rDjzrxMjz1Vh18TQW8veNHTQXRp3NN3qXGv5hjU2FX12tpNbUq2h1Y8d93eQ4pniVpIKsJi0s9udlxjP/Jk4h7NsFpHtoGtY+MQ/KKp3pGXEJrKzqJmynQQ09JcbFU9sKzmPL3mjoP2lymPs9jMGrkcFZhywHo7uapxaN/xt7j+6k27gJpXaaATkoA0G3puE6HGTvNh9xOo6kEseq8j6H6TBbIOMdED05RNmADnYIWO48Ql+DvDt41Rtg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR09MB7552.namprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(451199018)(71200400001)(7696005)(66899018)(508600001)(6506007)(26005)(186003)(9686003)(64756008)(8676002)(38100700002)(76116006)(66946007)(82960400001)(122000001)(83380400001)(4326008)(66556008)(66476007)(6916009)(66446008)(55016003)(8936002)(2906002)(33656002)(86362001)(5660300002)(38070700005)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NktlbXNSUlg4QVlTQkhhNjVnbjllajJRMjNSRFByU0owa2tjUGZXZkRSN0JC?=
 =?utf-8?B?dXdBTElIb2ZsWTVJTUtHTHI5emorSVdHMUkvOHFlODlFU2dxbEFnaXRlY0Jz?=
 =?utf-8?B?UkF2VWpySkNscDRnaE90ZHpqYWYrRThRNm9ySGJLV2YyNExFL1hjUWYwSWhE?=
 =?utf-8?B?M1BPZmpDYUtvaFR1cndQUEQ4Ukw2OWRsVXpkVnd5UmphYmtBczFYRHBkdTFi?=
 =?utf-8?B?c2JkMlpvR1NtOWRvcTJrRy9xaEZUN1psZEtEcEZ3YzJhZkVLOUE0bjQ2Vjk2?=
 =?utf-8?B?eXM0WXdMbWhuK0dvVDRXNklxMVhodUU3ckNqSjFaYU0vKzBxTjc1OWJUbWlQ?=
 =?utf-8?B?bFpqNndoZlVhcFM1T3dKdXpHNEs1VTRjZlZORUplK1JBQlo5N205U1hreFc4?=
 =?utf-8?B?eTFkd1dubWhuS1VveGFJUGYwcTVoNHZSaDJEaG1NTHBwYjZRWTBzTHdJRmxz?=
 =?utf-8?B?V0owZm0wS2czQWxlNU12ZTgva2dkWmRwRm9sT0grUG9FQ25jbklYZ3ZnOXQv?=
 =?utf-8?B?cTJnM21ubVVnRnNpeFFlbTJUa2MvdXBOeUF2NWExWWF6ZW5ES0ZBN0pVUTgr?=
 =?utf-8?B?QkI2eEl1WWlkLzIwU0hXQ0ZqNWZkeWowODVuWFpoSlZNNm9sT0VpRldnbnR4?=
 =?utf-8?B?RXI3UWNhWlloZENLdTJjTG1nR0FzOFh1eVJtUjU4eEdtWU1lcEJXcU5xckFJ?=
 =?utf-8?B?elpjT3JMUkF2ZWxQVlVxWkNtdisvRERDdm5IejNucFBZUW9xT25qQXQ5enV6?=
 =?utf-8?B?T1hGbHhYYkkra2trY0lmbWVuWitaeEFLeFNxVE5idG5EWWk1UldDalRuVE9T?=
 =?utf-8?B?ak9SYjN1QlV4QStORFdDQTQwUWt3YTNhYURCaGhsVk5xc1pwOGdnNTFzdW54?=
 =?utf-8?B?amppRFNHY1JoWFk1RWg1VzRabnRNUzNabjc2dGpxZ0JqK2d3VHhtU1lpS1I5?=
 =?utf-8?B?ODY1SDRubE9paFRNSk56Tm1tY2VFemx6Y29pV0lENXcyM2p3aEFlaG9WRjNh?=
 =?utf-8?B?bTNBRGtFVXllQWFIaHVHOWFWWC9Tc3hHeG9rNkduT1JEelhzdVM4Qm1IVGdw?=
 =?utf-8?B?aFg2UFJOdVhtSG1aOEw4QXY5MS9zc05KOVYveFlrdlB2MTdTU2pRV2QweU1H?=
 =?utf-8?B?Sm9QSjl4UnhVYnJYeTVZT1NCTnBUNHY3Mm9lRDdLdFFMWEl5MHZSTHFEUFRU?=
 =?utf-8?B?WWdvblhTcVdSNlB1NWFnd3JZd3RHQjQwY21xNzVabEJSM1RpQk9CT1hTc08w?=
 =?utf-8?B?YVozQ29FVEMvNHg0aldibnJlYUM3MXBGWFl5WWNVWG5NSmhFVk51ZDlnMGE0?=
 =?utf-8?B?cjlNYVZ5WlNMK04zSWdDRkh4a0o0QVdtdzRLOThwWFZOYUQvTGpBMGU5MEQ2?=
 =?utf-8?B?aHpLL1Z6ZjdTc0NpWldoUlhFRHR5dGhzTzVid3I3dk1BZzhHbThNRkdIWjRZ?=
 =?utf-8?B?Z01RSHFGY2xUWHY2UTYxZU1xY2U4SUJpMVdTclBVR2R0MzB4eUhDTzhHbmZW?=
 =?utf-8?B?NG9KR2dvejBpYllsNTJZR2c4N0pjQ3FOOXdaNkNKUXZIa2dQNnJQYm4rS1Mv?=
 =?utf-8?B?akpJclVncC9vOW4rdFZyemJ4VElBejk4c05kelNId1JHR0VWN2U5VGhXYktk?=
 =?utf-8?B?a1Z5NmFHN0pyeHZZOUJHem10Y2o5b3pvb3RFVU1ycENoMnZYOUdwcFJHTC9u?=
 =?utf-8?B?amhWUGpaV3U4bXIrT2dwb1AvRUJYaVBaSThxaWhFbkRKbmxGcTRONGV4OTdo?=
 =?utf-8?B?K0ordjMrbDN2RW9QbHNyLzJYUXArc0ptOUxBZkcrbkV0NXgxRVA4VzFldyt5?=
 =?utf-8?B?Y3lZc0JmQzRzUXAxVjZRdWpTMU1lTUlZZmVsdGV2UzY2cENEaXhUK05NNk00?=
 =?utf-8?B?QksvRlIrVDdnL3c1Q1pGMnZTc3hocDBsYmhGUlhTTjlVSDFBcWhuZno0TWxz?=
 =?utf-8?B?Y2JiRXRpR0kvQ29uNU1PSU9SaFAwL25lbWFpN3NQNjYzODVzeTRUZXU2U2w1?=
 =?utf-8?B?Q1o2eDhxMGY1ZThuakRhQUVKK3Zsa201L1ZzdTVJdUdMenZKV1BvMHRxNzZq?=
 =?utf-8?B?czhaWVVtVnlHVnZsMzVodXpjazRvVUJDT0poSEZRS0FiTE5iVU5oV2FXY0JJ?=
 =?utf-8?Q?8xBdM0P5DctXk2XrAJjA9vwjY?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fnal.gov
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR09MB7552.namprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11ea4a03-f909-4167-9771-08db03b2d04e
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2023 17:44:33.6462
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9d5f83d3-d338-4fd3-b1c9-b7d94d70255a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR09MB7043
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_GOV_DKIM_AU,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQoNCj4gRnJvbTogT2xnYSBLb3JuaWV2c2thaWEgPGFnbG9AdW1pY2guZWR1Pg0KPiA+IEhpDQo+
ID4NCj4gPiBUaGlzIGlzIGEgcXVpY2sgZ2VuZXJhbCBORlMgc2VydmVyIHF1ZXN0aW9uLg0KPiA+
DQo+ID4gRG9lcyB0aGUgTkZTdjR4ICBzcGVjaWZpY2F0aW9uIHJlcXVpcmUgb3IgcmVjb21tZW5k
IHRoYXQ6ICAgdGhlIE5GUyBzZXJ2ZXIsIGFmdGVyIHNvbWUgcmVhc29uYWJsZSB0aW1lLA0KPiA+
IHNob3VsZCAvIG11c3QgY2xvc2Ugb3JwaGFuIC8gem9tYmllIG9wZW4gZmlsZXMgPw0KPiANCj4g
V2h5IHNob3VsZCB0aGUgc2VydmVyIGJlIHJlc3BvbnNpYmxlIGZvciBhIGJhZGx5IGJlaGF2aW5n
IGNsaWVudD8gSXQNCj4gc2VlbXMgbGlrZSB5b3UgYXJlIGFkdm9jYXRpbmcgZm9yIHRoZSB3b3Js
ZCB3aGVyZSBhIHByb2JsZW0gaXMgaGlkZGVuDQo+IHJhdGhlciB0aGFuIHNvbHZlZC4gQnV0IGJl
Y2F1c2UgYnVncyBkbyBvY2N1ciBhbmQgc29tZSBjdXN0b21lcnMgd2FudA0KPiBhIHF1aWNrIHNv
bHV0aW9uLCBzb21lIHN0b3JhZ2UgcHJvdmlkZXJzIGRvIGhhdmUgd2F5cyBvZiBkZWFsaW5nIHdp
dGgNCj4gcmVsZWFzaW5nIHJlc291cmNlcyAobGlrZSBvcGVuIHN0YXRlKSB0aGF0IHRoZSBjbGll
bnQgd2lsbCBuZXZlciBhc2sNCj4gZm9yIGFnYWluLg0KPiANCj4gV2h5IHNob3VsZCB3ZSBleGN1
c2UgYmFkIHVzZXIgYmVoYXZpb3VyPyBGb3IgdGhpbmdzIGxpa2UgbG9uZyBydW5uaW5nDQo+IGpv
YnMgdXNlcnMgaGF2ZSB0byBiZSBlZHVjYXRlZCB0aGF0IHRoZWlyIGNyZWRlbnRpYWxzIG11c3Qg
c3RheSB2YWxpZA0KPiBmb3IgdGhlIGR1cmF0aW9uIG9mIHRoZWlyIHVzYWdlLg0KPiANCj4gV2h5
IHNob3VsZCB3ZSBleGN1c2UgcG9vciBhcHBsaWNhdGlvbiBiZWhhdmlvdXIgdGhhdCBkb2Vzbid0
IGNsb3NlDQo+IGZpbGVzPyBCdXQgaW4gYSB3YXkgd2UgZG8sIHRoZSBPUyB3aWxsIG1ha2Ugc3Vy
ZSB0aGF0IHRoZSBmaWxlIGlzDQo+IGNsb3NlZCB3aGVuIHRoZSBhcHBsaWNhdGlvbiBleGlzdHMg
d2l0aG91dCBleHBsaWNpdGx5IGNsb3NpbmcgdGhlDQoNCg0KRnJvbSB0aGUgcGVyc3BlY3RpdmUg
b2YgdGhlIHN5c3RlbS1hZG1pbiBvZiBhIGxhcmdlIE5GUyBzZXJ2ZXINCnRoYXQgcHJvdmlkZXMg
c2VydmljZXMgdG8gYSBsYXJnZSBtdWx0aS1taXNzaW9uIHVzZXIgYmFzZSwNCk1ha2luZyB0aGUg
ZmlsZS1zZXJ2aWNlICggY2xpZW50IGFuZCBzZXJ2ZXIgZmlsZS1zZXJ2aWNlIGNvbXBvbmVudHMg
KQ0KdG9sZXJhbnQsIG9mIGZvb2xpc2huZXNzIGFuZCBtYWxpY2UgKCBET1MgLyBERE9TICkgYXQg
dGhlIGFwcGxpY2F0aW9uDQpsYXllciwgaXMgaGlnaGx5IGFkdmFudGFnZW91cy4gIA0KDQpUaGlz
IGlzIG5vdCBhIHByb2JsZW0gb2YgZGV0ZXJtaW5pbmcgd2hlcmUgdG8ganVzdGx5IHBsYWNlIGJs
YW1lLg0KV2UgYXJlIGFsbCBmYWlybHkgY2VydGFpbiB0aGF0IHRoZSAiY3VscHJpdHMiIGFyZSB1
c2VycyBjcmVhdGluZyAvIHVzaW5nIGJhZCBhcHBsaWNhdGlvbnM7IGhvd2V2ZXIsDQpXZSBhcmUg
MTAwJSBjZXJ0YWluIHRoYXQgdGhlIHN0cmF0ZWd5IG9mIGVsaW1pbmF0aW5nIGFsbCBiYWQgYXBw
bGljYXRpb25zICggYWNjaWRlbnRhbCBhbmQNCmludGVudGlvbmFsKSBpcyBhIGJpdCBsaWtlIGds
b2JhbC1wZWFjZSAuLi4gaGlnaGx5IGRlc2lyYWJsZTsgYnV0LCBub3Qgc28gZWFzeSB0byBpbXBs
ZW1lbnQuDQoNCg0KPiBmaWxlLiBTbyBJJ20gY3VyaW91cyBob3cgZG8geW91IGdldCBpbiBhIHN0
YXRlIHdpdGggem9tYmllPw0KDQpJIHRoaW5rIGluIG1vc3QgY2FzZXMgaXRzOg0KZmlsZSBpcyBv
cGVuIGZvciBhIHBlcmlvZCBvZiB0aW1lIGxvbmcgZW5vdWdoIHRvIGJlIGFmZmVjdGVkIGJ5IGEg
ImRpc3J1cHRpb24iLg0KDQpUaGUgbW9zdCBjb21tb24gImRpc3J1cHRpb24iIGZvciBtZSBhcHBl
YXJzIHRvIGJlIEtlcmJlcm9zIHRpY2tldCBleHBpcmF0aW9uDQpmb3IgaW50ZXJhY3RpdmUgdXNl
ciBzZXNzaW9ucy4gKCBmb3Iga25vd24gbG9uZyBydW5uaW5nIGJhY2tncm91bmQgL3JvYm90aWMg
dGFza3MNCkkgaGF2ZSBwZW9wbGUgbWFuYWdlIChrZXl0YWIgYmFzZWQgKSBjcmVkZW50aWFscyB3
aXRoIGdzc3Byb3h5IC4uIHdvcmtzIG5pY2VseTsgYnV0DQpub3QgZm9yIGludGVyYWN0aXZlIHVz
ZSApDQoNCg0KDQoNCg0KDQoNCg0KDQo=
