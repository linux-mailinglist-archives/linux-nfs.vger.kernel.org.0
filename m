Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B12307F01CD
	for <lists+linux-nfs@lfdr.de>; Sat, 18 Nov 2023 19:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbjKRSDu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 18 Nov 2023 13:03:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbjKRSDt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 18 Nov 2023 13:03:49 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2121.outbound.protection.outlook.com [40.107.220.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8863AA
        for <linux-nfs@vger.kernel.org>; Sat, 18 Nov 2023 10:03:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GBTjM/xwrYePhAEFz8S4Sh13+rPHp0FnaBf/RRMO48FTiPT4OOvYAe3cRWJv8z28UHBeRE6VqmPUC5HShFQ1bCjQl47l/oATYT2SNxa3+5uUx7f9LFGBxHfomMUe3kXoeRd1BVW+/sH7D19F4Wkxu7F/UQFf2jSC/DKhmbS3hAPtHiNCzQGxlJHuQqPzGn7bk+bC18ELavVAd3aHoF/uY+6hVE9Sqa0iN5po3PWsw6wDGK/N9NCuZnPO4Qs/DTentCKbMU/w6O9LjGatov4umwpDvFbt2S8kvtcMBV7sazdbP6ssIT6zLv7/jIxQOmN3GrDgEd0jLDWMo9qQsXGSGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2XzZF4W/5E+OAspEVWkhdsBsaT6tLVPBMo6kt5zg+Vw=;
 b=azagQAVfQQ+CkJs03LGcalqzrd4LQvmn0H6hvv+NbV01jGCvTU7LKd3/vzNKp2lGeMWtjZDH52jXnbuUD6U8oDzIBeCt6dWc1v+rPABQqIv8wqnDRPLR9BfaMbF042yGhONfsENDi3ywKPkesActoFgjJBXGpqyluMHSa+1SI8nds8CD53pjN541Mz1A9gI63xzpGvqbFZICPNHv+DbSOWF/11T+7WHtMeWXWhY0MPnoMat3y716w5l0zhIFi30vh6bCXm0/Ce/PIX1kp4x9ht6kusBmwvMpB18V+YcxPfxuUnNCLUuSnUpinK3O5uGTbjgahBAVqbrDMxwu1DqnZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2XzZF4W/5E+OAspEVWkhdsBsaT6tLVPBMo6kt5zg+Vw=;
 b=ClE2qx1jJwPkJME67yd9QWsn+WUQW0SSA91BmJzPyreL1BFfeuUJCz3F82kru24n47BFVFwQuiAykPfd83iAyznMg1PESrU9gsYJw9TbfpJFGuapjkzYz7ZBinWhJ+s6bCYp3eyrABADR0au2GNQ6o0OFHHO8UefrTex0l1fvu0=
Received: from DM8PR13MB5079.namprd13.prod.outlook.com (2603:10b6:8:22::9) by
 SJ0PR13MB5872.namprd13.prod.outlook.com (2603:10b6:a03:43a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.23; Sat, 18 Nov
 2023 18:03:41 +0000
Received: from DM8PR13MB5079.namprd13.prod.outlook.com
 ([fe80::50ca:9941:2396:90f0]) by DM8PR13MB5079.namprd13.prod.outlook.com
 ([fe80::50ca:9941:2396:90f0%5]) with mapi id 15.20.7002.026; Sat, 18 Nov 2023
 18:03:41 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: Who owns bugzilla.linux-nfs.org - account creation broken? Re:
 How owns bugzilla.linux-nfs.org? Fwd: [Bug 218138] NFSv4 referrals - no way
 to define custom (non-2049) port numbers for referrals
Thread-Topic: Who owns bugzilla.linux-nfs.org - account creation broken? Re:
 How owns bugzilla.linux-nfs.org? Fwd: [Bug 218138] NFSv4 referrals - no way
 to define custom (non-2049) port numbers for referrals
Thread-Index: AQHaGSm5IPgy8h3QmEuPQMOdkvJBtLB/omOAgACnlYCAAAIBgIAAA/eAgAAQ2wA=
Date:   Sat, 18 Nov 2023 18:03:41 +0000
Message-ID: <c762fb4fd6e3c529e75541d6944a187a357578c9.camel@hammerspace.com>
References: <bug-218138-226593@https.bugzilla.kernel.org/>
         <bug-218138-226593-fRCLxzGk3u@https.bugzilla.kernel.org/>
         <CALXu0Ucz2MGCYdMw74ZKGUj_hpGcLP-pxC=MSgpUFGU58=jc=g@mail.gmail.com>
         <CALXu0UdY=ZgcAqvC6Y-X6htxPQ9=XWemt8V4dxTA99wQmHKz=w@mail.gmail.com>
         <959BB15F-5B91-4413-BCFC-EDAC78EE32F6@oracle.com>
         <d8bb0bf43c8fe38ef83248fb55a9549919530cf2.camel@hammerspace.com>
         <095736A1-C749-4B8C-900C-C0471D8F8422@oracle.com>
In-Reply-To: <095736A1-C749-4B8C-900C-C0471D8F8422@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR13MB5079:EE_|SJ0PR13MB5872:EE_
x-ms-office365-filtering-correlation-id: e6063bc4-7cb2-4823-8dcd-08dbe860b2ac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lYXPANsR04pvMiJZmT/Yul7xdw6Ec4vbllKsvHXmty/mkKlVjGIHkIgskWb5JD4AFQDCe/DckObiZJ/hUjB5yhqkpM46inh3tkVZ0klrtI2v3kcBBLsG6aY/ZLCWh7iMsIUtAEmTReZRcQ7A/eP5pBlhAH98t3OuqSP2hCt9PTQqjGl7Xo26aQWenUX0dTMYnWytEaBbT3wnQUWgR9onlANNACafFJ4BktL4G4oebmAGLQxqisir899wCFi3yTGRXEMLEmhfVSrUe591oXmqrVsXJaGGuA+KF75WtOj90LuWdsq3cpuahu7oUBSuOYEGCXwAsLHq+8x3sqf5yTWT74FKAVfZm05YLISekjGOGY+ZDGdHqM2icbQ8H6kCphmudyjnkDtmxDMQAmy7IVC4RFBPQMCsnBYyJZ9Hxc6jqw2HK+/n99/FA/n4vSO0UxJjBLHgXWv+gbaXge5HkHX0k3aao428Qeq33XAtnvv3daW1DIzu2LbLBnLXWiFb/UdKyKbjGvY3zEqsu+CCgcZoe9PXgXAU2afaIDbD06l5rtW4Ki6IFMyYDceZYsfWLn6z5ZZvh6jr/qhBk5mApU3NGUR7dROBhNui7b3IO1HBivudBmiGAoKHRpgHZvD2fFjzfrSV2g6pPC2Jh8ExpuqA/0TtXrqmlCXwaxy9lIzCviKs3kBbnPIMAJEZKSTOfOnD+IBFqUO7vA15L7XEMjKP2/mM2XNXOn4OR0l8MNLvlVM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5079.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39850400004)(346002)(366004)(376002)(136003)(230922051799003)(230173577357003)(230273577357003)(186009)(1800799012)(451199024)(64100799003)(41300700001)(122000001)(38100700002)(36756003)(38070700009)(4001150100001)(83380400001)(2906002)(86362001)(6512007)(26005)(2616005)(15650500001)(5660300002)(66556008)(71200400001)(66946007)(66446008)(76116006)(66476007)(6916009)(91956017)(53546011)(6486002)(478600001)(6506007)(64756008)(8936002)(316002)(8676002)(4326008)(43043002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L3phdEZHNWJiRm8rdC9qc2NJU2F1aE1qaXpnYXg3S2VYbHp5TDZ0R1UzaGFy?=
 =?utf-8?B?M1RoajF6eEFVbmVsRjd0ZWYrUHFrOFdTRDluaDcwV0ZOVTdLZWg4UmhObS9s?=
 =?utf-8?B?Q0NNV3Z6SVB1eEpnWW56SXBuelAyY2dQNUxiT25paHNhSTlBYVlRUnBITlJD?=
 =?utf-8?B?RElqQlV2bFY1Z1dJRVBTMy9ZeFZmb1oxcTFXOXNUNDdEUTgvaFVyS25Cb1FH?=
 =?utf-8?B?MXlUVUxoVVJNeWoyeXNoSzBEWW1rRU53VFNZMXErb0ZydW5ISkw2SGVtUXpp?=
 =?utf-8?B?R0Q2ZGI2UTlFdUgrSm1naFlQRGFDcmVkQlVvekpaL0c4Z2h5ODlETUdZZWFo?=
 =?utf-8?B?Z3hvQmRKamQzQm9CWURGSGJmVXFwTGo3bjhzY3RzTWFJZGdEWERDY1c0LzFj?=
 =?utf-8?B?bTZUY29lOUhGN1M4QThUSTdvb1NlRU5VUzJTQXFEaU5OL3RJWkpPdi9hMVF4?=
 =?utf-8?B?eFJRbGpNbWlXR283bm1OOU16WXYzVmVEMkxsS2RISUVtckFVTS9FekN5QkEr?=
 =?utf-8?B?YzlOOG1YZXdJSUZUSzZkVUswaFdFOGNsWFZNRDVDK2M5dTIyOGMycDYxRkxp?=
 =?utf-8?B?dzBLTDJRRzFWOVRSZVdYZEJPT0xUaUFlMnpoQXBMYXFyOHc2ZFJ4emhaRDNy?=
 =?utf-8?B?b3pwUjNkQ3FlNjNnbFRSV3RtekdxL1ZTM3VablVuTlpFS0NUaFNxSGVjMURJ?=
 =?utf-8?B?S2dvOGROUVNubFFkMlFWbzVNUmJnS3JPU1FvYWM5MTh3MDBtMm5BNldtSThZ?=
 =?utf-8?B?L1B4UkJsTUd0a2FzYTRrNVJnZmtWWitSU2RVQXIrK1hjQXRIR0Vwc1dPRW5B?=
 =?utf-8?B?ZXFSaUpCRW1ieWdZQWpYRkpMNk9qdHZQUnBjamNBRXdybU94VTJKbTFwaURr?=
 =?utf-8?B?NHFXY21LMnVjYmF2UmRZOEd2VVJ0YUpnQU1PYkZsbm82UzR4QlRkWHdmM0k5?=
 =?utf-8?B?aU9udHJBM0ViQktaL3JacWJVNmg3QzJwM1hBcnZJdnV1a0xqL2JSVVVCSmFh?=
 =?utf-8?B?RVdzVUNiSnZYMG9FbTVGU2xhSXMzNFNPbTBTWkY3RUw5YnBMakl1SkhuYWtu?=
 =?utf-8?B?Y0FjZVEvMlFWTS9hVjM4YUptcXRVZTh5RTZxYUtsM0pCN1VnMW9ISDlId1lx?=
 =?utf-8?B?WWYrZmhmMVRkZTdkZnU1U05PRGRyWnFvaHJnREtRQ3Qwam5qRlgrR3VEZnRV?=
 =?utf-8?B?aWRpaldiOURvN2w4Y25jZ2tudDQ5MEFPWUR1QTQ0Mm9BSmt0RXFXZXY0c1pY?=
 =?utf-8?B?VHE4Rktvd3JtT0hKV1VJbTdnUW0zOGplWkdBUEhCc1pGWjVlZjBMbGp6azNK?=
 =?utf-8?B?UEFBSWpkRHc2Uk92UzA0anczSUgrZ3pMUFFTU3cwbjZjZW1welU3cDJSaXVX?=
 =?utf-8?B?N1g0R21OdmZTMGhuaG9mbWdQdUVlOFVQb3RBRmVjK0ZIMDE5OFVCTzBxREIv?=
 =?utf-8?B?Z0s0b3ZHWG5FUXR6SWhVdUVFZzJnWm5kTHNCcmNtQnZHVUw0RnRPWlpTWXhX?=
 =?utf-8?B?dVoxM3A5UmFFVk9LeVZMYU8xNld6aDg2RVNqK1ZEeXV3eXRvVWNxSGJZeTJO?=
 =?utf-8?B?OUFlbFBZOHFCajZyd0xFNHE1Y0IxSnBTbjFRQTFndklWNVhheXVyOHQ5OThq?=
 =?utf-8?B?YTBucWlYQkowREkwd25jRlBlV0ZZVWZyZ1dYSVFNOHVNa0xhWmhHbUlRWWlw?=
 =?utf-8?B?V1FXcWY5a0pxUTBGc25TbUNzc0JEZVdQL2ZGVm1lRzQwQXNNRU9yWDFtWm9Z?=
 =?utf-8?B?R1hocWhkQmxrK3hpZ2RmSll0enlrcWlKWnZkcUxPaUc2Zm9mTjMzM1drRG40?=
 =?utf-8?B?VTdGUFI5bnRIclNFNkhqM1M5ZWNBMlFtSjlEUjVrS1F4M3BXZlJ1MFJMblZQ?=
 =?utf-8?B?V3ZjNzljOGJsWHc5cUVoQXVXYTQzZk5BQmVmdXJxWXM1TlFrNFNiZStHS3k1?=
 =?utf-8?B?S0pCTjV0Z2I4NmJJZXh3cDhtUjlVbzhZb240VWxlRWZYYkNrRmVNdzFuN25v?=
 =?utf-8?B?QXVsM3NaUm1zbVZ2SVloODllTkxtcHEyWWlpMFJiL1piWGo2aWFSenl5Ykcx?=
 =?utf-8?B?cXVVNW41eWx1ZnRGeHlidStsQjBoZUtWRmpkbU9BSjkya3dYRnExZnRnVjRV?=
 =?utf-8?B?QmRpaDVvV3E1N0tySVVob1BuYUo2YUJnQ2RzNU5zQ2tPU3doVkVqYk5TdEVI?=
 =?utf-8?B?Y3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <29076A9BF701B24DB47DC3E9FA156BEA@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5079.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6063bc4-7cb2-4823-8dcd-08dbe860b2ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2023 18:03:41.4896
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I1i/56zx+RhsuccdThQuhWTDbI8CSnwV2mGD+AZ1uslmuA6qb4yMAL0ARwjwNjZxIykw5Ns39dtZAIKGgsykCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR13MB5872
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gU2F0LCAyMDIzLTExLTE4IGF0IDE3OjAzICswMDAwLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6
DQo+IA0KPiA+IE9uIE5vdiAxOCwgMjAyMywgYXQgMTE6NDnigK9BTSwgVHJvbmQgTXlrbGVidXN0
DQo+ID4gPHRyb25kbXlAaGFtbWVyc3BhY2UuY29tPiB3cm90ZToNCj4gPiANCj4gPiBPbiBTYXQs
IDIwMjMtMTEtMTggYXQgMTY6NDEgKzAwMDAsIENodWNrIExldmVyIElJSSB3cm90ZToNCj4gPiA+
IA0KPiA+ID4gPiBPbiBOb3YgMTgsIDIwMjMsIGF0IDE6NDLigK9BTSwgQ2VkcmljIEJsYW5jaGVy
DQo+ID4gPiA+IDxjZWRyaWMuYmxhbmNoZXJAZ21haWwuY29tPiB3cm90ZToNCj4gPiA+ID4gDQo+
ID4gPiA+IE9uIEZyaSwgMTcgTm92IDIwMjMgYXQgMDg6NDIsIENlZHJpYyBCbGFuY2hlcg0KPiA+
ID4gPiA8Y2VkcmljLmJsYW5jaGVyQGdtYWlsLmNvbT4gd3JvdGU6DQo+ID4gPiA+ID4gDQo+ID4g
PiA+ID4gSG93IG93bnMgYnVnemlsbGEubGludXgtbmZzLm9yZz8NCj4gPiA+ID4gDQo+ID4gPiA+
IEFwb2xvZ2llcyBmb3IgdGhlIHR5cGUsIGl0IHNob3VsZCBiZSAid2hvIiwgbm90ICJob3ciLg0K
PiA+ID4gPiANCj4gPiA+ID4gQnV0IHRoZSBwcm9ibGVtIHJlbWFpbnMsIEkgc3RpbGwgZGlkIG5v
dCBnZXQgYW4gYWNjb3VudA0KPiA+ID4gPiBjcmVhdGlvbg0KPiA+ID4gPiB0b2tlbg0KPiA+ID4g
PiB2aWEgZW1haWwgZm9yICpBTlkqIG9mIG15IGVtYWlsIGFkZHJlc3Nlcy4gSXQgYXBwZWFycyBh
Y2NvdW50DQo+ID4gPiA+IGNyZWF0aW9uDQo+ID4gPiA+IGlzIGJyb2tlbi4NCj4gPiA+IA0KPiA+
ID4gVHJvbmQgb3ducyBpdC4gQnV0IGhlJ3MgYWxyZWFkeSBzaG93ZWQgbWUgdGhlIFNNVFAgbG9n
IGZyb20NCj4gPiA+IFN1bmRheSBuaWdodDogYSB0b2tlbiB3YXMgc2VudCBvdXQuIEhhdmUgeW91
IGNoZWNrZWQgeW91cg0KPiA+ID4gc3BhbSBmb2xkZXJzPw0KPiA+IA0KPiA+IEknbSBjbG9zaW5n
IGl0IGRvd24uIEl0IGhhcyBiZWVuIHJ1biBhbmQgcGFpZCBmb3IgYnkgbWUsIGJ1dCBJDQo+ID4g
ZG9uJ3QNCj4gPiBoYXZlIHRpbWUgb3IgcmVzb3VyY2VzIHRvIGtlZXAgZG9pbmcgc28uDQo+IA0K
PiBVbmRlcnN0b29kIGFib3V0IGxhY2sgb2YgcmVzb3VyY2VzLCBidXQgaXMgdGhlcmUgbm8tb25l
IHdobyBjYW4NCj4gdGFrZSBvdmVyIGZvciB5b3UsIGF0IGxlYXN0IGluIHRoZSBzaG9ydCB0ZXJt
PyBZYW5raW5nIGl0IG91dA0KPiB3aXRob3V0IHdhcm5pbmcgaXMgbm90IGNvb2wuDQo+IA0KPiBE
b2VzIHRoaXMgYW5ub3VuY2VtZW50IGluY2x1ZGUgZ2l0LmxpbnV4LW5mcy5vcmcNCj4gPGh0dHA6
Ly9naXQubGludXgtbmZzLm9yZy8+IGFuZA0KPiB3aWtpLmxpbnV4LW5mcy5vcmcgPGh0dHA6Ly93
aWtpLmxpbnV4LW5mcy5vcmcvPiBhcyB3ZWxsPw0KPiANCj4gQXMgdGhpcyBzaXRlIGlzIGEgbG9u
Zy10aW1lIGNvbW11bml0eS11c2VkIHJlc291cmNlLCBpdCB3b3VsZA0KPiBiZSBmYWlyIGlmIHdl
IGNvdWxkIGNvbWUgdXAgd2l0aCBhIHRyYW5zaXRpb24gcGxhbiBpZiBpdCB0cnVseQ0KPiBuZWVk
cyB0byBnbyBhd2F5Lg0KPiANCg0KRXZlciBzaW5jZSB0aGUgTkZTdjQgY29kZSB3ZW50IGludG8g
dGhlIGtlcm5lbCwgSSd2ZSBiZWVuIHRlbGxpbmcgeW91DQp0aGF0IGJ1Z3ppbGxhLmxpbnV4LW5m
cy5vcmcgaXMgZGVwcmVjYXRlZC4gV2UgZG9uJ3QgbmVlZCAyIGJ1ZyB0cmFja2luZw0KcmVzb3Vy
Y2VzLCBhbmQgYnVnemlsbGEua2VybmVsLm9yZyBpcyB0aGUgbW9yZSBnZW5lcmFsIG9wdGlvbiB0
aGF0DQp0cmFja3MgYWxsIExpbnV4IGtlcm5lbCByZWxhdGVkIGlzc3Vlcy4NCg0KLS0gDQpUcm9u
ZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRy
b25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
