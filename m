Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 606964AC9BC
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Feb 2022 20:42:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234652AbiBGTkL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 7 Feb 2022 14:40:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237188AbiBGTi2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 7 Feb 2022 14:38:28 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2105.outbound.protection.outlook.com [40.107.243.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD8CC0401DA
        for <linux-nfs@vger.kernel.org>; Mon,  7 Feb 2022 11:38:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L/0agI8BSS66V+In3hYbWLwVivhutBcIBrn1sKJ0D8DwLxXyy72vvNNJIQY4O4CktDZJvPfBaGgQeJVdo46K64peF0V1/uZIpem/zpEvObgdcDoIqMDlZMP02S+3jS901lyga1OVgLXgMC4ch0BfJWv8YqKrKuJlH3MSpW/kVlndr9qyAElD8BWPt08rXCc1OzeoQf8SEWBOnriic7lKtJ8x30/0N5C/XVfmXZKlZwBVfEACl2RL65MpAjeIl/C4XXAs6vOQFlSLUm2P5g/PrA7r+n013EBuhixgXGtFBVR7/J+hkh72OsQCi6UyXdX4UNpA2leU0SMOdSNCk6ZGNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sfeSXUHR7hHZx7+a0XU8wuKsCkjdF5T8MvzYjRuOVTU=;
 b=HxeaLjHlvBg9oJSEd9sJkQDjqRxzLGVZe0aReS5/SoyXHcTyPIIjMzyyVagkoax8qhyCJyWQOyi0IT6cnonZ44YKz8LKOYoPuEzvtJy6Wm5YE5Zl+y4R7kcoX77WWqcILmnCGzmIRcNAJrDIFJtKH+TwvNmveyHal2/GnJAPznmeksgFFSZ6CegawXNYvv59FypSgj+oD5T2HBsyOWI6+S/qYFdoX4/zLcdQLWCtBnTwstQ0adomlaVU5LeN8BdfPYwFlXp9NznYbSGfwvew8rJEaQCURYvDRYD35ZOdsXIZU2RHf4bKxbwcapsDGzX/Jb536BYOVIHnhEPKOac78g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sfeSXUHR7hHZx7+a0XU8wuKsCkjdF5T8MvzYjRuOVTU=;
 b=eN/y57Zli/Epy3zFDtsbWQtlnS8LkpZPm9mpC78/S9elAiS40mK08cQ+20ZVc+tO4JQBt8g1Q1wpkfr+XI8VGKI0EUtHep0AOvx7ti836yz7dcqiXakghQobWbm1/qR26CxgKxxjBGSOBJ5BqWCPe5fXxu7lJuh9WOARDXcXk2M=
Received: from DM8PR13MB5079.namprd13.prod.outlook.com (2603:10b6:8:22::9) by
 PH0PR13MB5363.namprd13.prod.outlook.com (2603:10b6:510:fd::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4975.8; Mon, 7 Feb 2022 19:38:23 +0000
Received: from DM8PR13MB5079.namprd13.prod.outlook.com
 ([fe80::9839:95f8:577f:b2b5]) by DM8PR13MB5079.namprd13.prod.outlook.com
 ([fe80::9839:95f8:577f:b2b5%4]) with mapi id 15.20.4975.011; Mon, 7 Feb 2022
 19:38:23 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bcodding@redhat.com" <bcodding@redhat.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: v4 clientid uniquifiers in containers/namespaces
Thread-Topic: v4 clientid uniquifiers in containers/namespaces
Thread-Index: AQHYGqGY+wEK6KvlxECYW5WP2WwW2KyFReGAgAAYO4CAAsQQAIAAHRgAgAA//4A=
Date:   Mon, 7 Feb 2022 19:38:23 +0000
Message-ID: <b192022ce73ea690a117d7710b492e83be99df31.camel@hammerspace.com>
References: <6CEC5101-0512-4082-81F8-BDFEC5B6DF3A@redhat.com>
         <6ac83db82e838d9d4e1ac10cb13e43c5c12b2660.camel@hammerspace.com>
         <439C77F9-D5AD-4388-B954-3B413C1DF0E2@redhat.com>
         <596C2475-76AA-4616-919C-9C22B6658CA7@redhat.com>
         <DB8B60C8-B772-4604-A841-47F789723D5D@oracle.com>
In-Reply-To: <DB8B60C8-B772-4604-A841-47F789723D5D@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7d1c0344-4e52-4138-1493-08d9ea71673a
x-ms-traffictypediagnostic: PH0PR13MB5363:EE_
x-microsoft-antispam-prvs: <PH0PR13MB53634C4EE6C956672921E903B82C9@PH0PR13MB5363.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZanDupsO/kcLSVXoHHxx/wuDeMhPfB89+ToRO+jICReK3CNqXBHPdjufGbLweyD1T8TDo2PnfcgMTax7QnBbOndKSyMJxDrk8ZCnhw/4laZlx2/ioAX8AXSru+9rESjBGhUNGr8rsW3cl4zxptlb7m+Dd1WLBKf26Tdi1be+fIn7S+l8dZHbpwhAPLOC6fr5DcYD3KSCL7XM2TGiaL4tWWHdrUPWIRkSl5R2c6hRiba9DJgfPAuqPM0s2EtL7A4ROe5j3i1O8n1JUXZe/CSLN+bNt2hA5MaCWuWsbSBBTBmAxEcI3rL8V005VNY211QK2emskyCUUvrmxiDWodCyRr2qNqCb7hiVK8WiRrsXNrJIsMwqwmCyeGS3+VbMMF5foBMDKzvW6vw8NPUg0tYk+4aUJlKDFNwVPFT1t4452gHXZQTv2IV8vLJLaPhzf4Yxd9gyAreQ87eBe8YyKUO9bdeP3iwLvgqfaIhVJ0v1F7NiuvIcg+xP5O/W7z8GY9sfLfnJQ4SiT/zFdf19KsA/Rcpf7PIpsEeoBY7KiPMQ7oVDmR1sQKFsioDPPgbQz7lZKPtuCMkIc3n78tYf9Q6+wgv299DSDg6zT7bjWNpmkSow8Gf1Z9IFja2R/mrMBuDCLnTIc/yKXQrPfb5okQEkqf4y3iaCbBEuWzN5y2DA6RgrlySmviZWyuxGnZ66fMEGPKDLZwTPUgvFJV9suKdBPQi7TtK5yK/9Ut2QmUTvUa8XNnoqlgkoEH18nrM9GFnv
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5079.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(36756003)(2906002)(186003)(26005)(508600001)(122000001)(38100700002)(110136005)(86362001)(8676002)(6506007)(53546011)(71200400001)(83380400001)(6512007)(4326008)(66476007)(76116006)(66446008)(66946007)(8936002)(66556008)(91956017)(64756008)(2616005)(5660300002)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?djhFbzVnVGpkbFJyaW4yR3NKYlMvN1dkK2tCSjZDMTF5OFYyU1VDY29tb0V3?=
 =?utf-8?B?Smx2LzB5TTdpZEtMZmRKNHpMbDBCZTZjRURnNXF5a3NiUmtwTkV4YWxZYnZy?=
 =?utf-8?B?SFc2ekFZK3dhMlg4ZHorMFcyeUJ5b0VxaUdDWVRNN2hHd1crRkhxN09QaTlX?=
 =?utf-8?B?dWtYUG5JelNMd0gyUllrWWFpZ25tY1Q4NHhRUy9aeDRtVHNOTkcrMUo2T2Rm?=
 =?utf-8?B?Nmt6V1RUU1B3UDM0K09QUlNiSlNBbnppWkMzU1huaE9CbktUSGFrcDNRNFRY?=
 =?utf-8?B?ZWxaUDdkL3NabTFuTGQ2Umg2eXp6QTVGRlU3cWZ0dXc2TDJhYmFNdzZhRUFt?=
 =?utf-8?B?MkQybGc2aU53aTVad04vQzF1Z05YSXltcVRJeUp1dmV4R2hvZ1VTSEYvc3px?=
 =?utf-8?B?LzB2amhmUy9yNDRjbnFvb1VNSmd0dWtZSzdnQkdpTzRjUFZGSDBkWU5ocVRs?=
 =?utf-8?B?TnozUld4OWNscTlXWStJWjZZaEljOU9UZUVIUDd3Z0ZBMnl1cGlhQzRCUG5a?=
 =?utf-8?B?VGczK3ArZjIzSndJVGRrVno1cE1MMmdibUZ0TGJBNVc3YTR2TkdNa2RQNTB6?=
 =?utf-8?B?OXhvMkRQSy9xNUxpZjdVRFVmWTNDSWJ1ZklQQVNuTHhUbUNONkwrRklOc3hC?=
 =?utf-8?B?NjRRUWFXcGVvcVd5WjlIaUw5dmU0UFd1QXUwcHZucXM1UGtDMWNnem1EVVhP?=
 =?utf-8?B?M0pLU0hUa2kyejdDb0NPNUdiMVpWdTdqb3djNWMzMkVtZFRtNUUxTkhGaVFX?=
 =?utf-8?B?cDR6VjhYN0x6Z3g2Y2d5eGdtTGRaVnZlY01rWG1NcGpXWEh1MHl3bU93cFBn?=
 =?utf-8?B?RzNuTkNaK2RPa09NZTJDR0hwSHN1THgzRWcvNFdSUXpqaGN1QVNKclUyU29X?=
 =?utf-8?B?d3ZHM0FmTHNrRGJaUGNNMk5IOXgyeUlrVXEwWW1jeTYvQW5Ic09xQmRlM0gz?=
 =?utf-8?B?TEt1V2xSMC9ST2xRUWdPUzFDdFQ1T1EwaFJPT3hwQWs2MURKTU9DNEpyVHh5?=
 =?utf-8?B?QVIzUVZXMmUrenRtZkhHMFJCNE1ZVUpvVE1zNXB2N2ZWOEhiTXB4Y3JVcjMv?=
 =?utf-8?B?MWUyN3g4RnNEdUVMOUhiZEg1NXBqenlmRUk5WHRWN2ZCbjJNc1FGc1I2L2xH?=
 =?utf-8?B?WHJuMGhNSGFtMi93Y1oxWExibEl1cE10Uk5xS3lqWTVyYVBEWmZBRGY0ZXZo?=
 =?utf-8?B?eHRvamhyaXBHdG84cHVUMjFtUzZKREZTZ0NDTUNsNCsyK1pKV3l2aGM3d0lp?=
 =?utf-8?B?RUFmd0JkQk1qY3RJc1c4N3FOZVNQL1dzY3RPUHFEcDloM2tDK3ZlRzNhWjZt?=
 =?utf-8?B?QmFodS9WejN4My8wVGtFbURtbG1BWkZHM2h3WWx2UHQ3emNwd3Z0cUhiSUpH?=
 =?utf-8?B?U1M4aGtzK1lZbW8vUkQrRmIwL3JwL0hvY0xDRVN6V2w5bzlNNFd6U3k3d1Fz?=
 =?utf-8?B?UmpPalpwMitmQkN5UVE4N1JHREtQN0xDT015b1JOcWFkMnBJTnVlald4Mkd2?=
 =?utf-8?B?cDViME9HMjNCZ05tQ25qbnVTN0JQRHFod3luallGa1ErVWNZVlBLUHIwcVJN?=
 =?utf-8?B?elNOL3I1SndqTnQwcnJrOGlCR0QyNU1USitaOWpWM29qU21PcXdWSVprOVNT?=
 =?utf-8?B?QTNlbUU5NDN1d1BWajV3eThQcHZzZEdjRHV2VlhVaGgzOUlNVld5Y3Zrd3N0?=
 =?utf-8?B?bzNSS3dwL252ejBxRDBGT2lDZW9GR1lKNmNucFVGKzU2ckZwSnRqcXhvSWpY?=
 =?utf-8?B?dGIwRVdtejFmeE85aDAwSkJZbi9LZUkxQk1QczY2dU9ZTHQ4bWZYRm83NHZ5?=
 =?utf-8?B?LzgrVXBmNXAzQnJrbTNUZy9PM1lwVjdUYUQvYWxCc0MwVmVQUHVaVGFOaE1t?=
 =?utf-8?B?TXA2RENRbllFQ2Q4SVAyWE1nNnJ4VUJCZ01MczJXTE12b3p5QnNwankraGp1?=
 =?utf-8?B?UGhjdlVucVpPcjFKRWs2aXNZQTNBWWhNTUFwdnMyU3Y2RnRrU3FOS0xhYjJR?=
 =?utf-8?B?T09uK2xOc1ZyMkVvOHVPWEQrbUw2cHJONFpxTllqQUpmMUFpbEFEQnRSUmN6?=
 =?utf-8?B?U1NzU2dkVXVNMHFXcVV1ZytJeStTVExickxra3RnZmhZVUNncXh4aHZpSVU0?=
 =?utf-8?B?WU90a2p3RWx1eTlMQ1ZuQU1BKy9CdDNQWjJsVnRHWUhGYXlwdDhWeUIwOWsy?=
 =?utf-8?Q?OGhCuH1DsyjtV3UW21KLuTU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <22CD367FCBC9BB46B51214343972F5EA@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5079.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d1c0344-4e52-4138-1493-08d9ea71673a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2022 19:38:23.2449
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6KsdEGh9xQp4pHx7FnwU7narMStOjX4b4xxHcGqIZ81CLpsdDb98tlCsBjcG2+f9nE/0ugVrDLW8iMHyve6h+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR13MB5363
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDIyLTAyLTA3IGF0IDE1OjQ5ICswMDAwLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6
DQo+IA0KPiANCj4gPiBPbiBGZWIgNywgMjAyMiwgYXQgOTowNSBBTSwgQmVuamFtaW4gQ29kZGlu
Z3Rvbg0KPiA+IDxiY29kZGluZ0ByZWRoYXQuY29tPiB3cm90ZToNCj4gPiANCj4gPiBPbiA1IEZl
YiAyMDIyLCBhdCAxNDo1MCwgQmVuamFtaW4gQ29kZGluZ3RvbiB3cm90ZToNCj4gPiANCj4gPiA+
IE9uIDUgRmViIDIwMjIsIGF0IDEzOjI0LCBUcm9uZCBNeWtsZWJ1c3Qgd3JvdGU6DQo+ID4gPiAN
Cj4gPiA+ID4gT24gU2F0LCAyMDIyLTAyLTA1IGF0IDEwOjAzIC0wNTAwLCBCZW5qYW1pbiBDb2Rk
aW5ndG9uIHdyb3RlOg0KPiA+ID4gPiA+IEhpIGFsbCwNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBJ
cyBhbnlvbmUgdXNpbmcgYSB1ZGV2KC1saWtlKSBpbXBsZW1lbnRhdGlvbiB3aXRoDQo+ID4gPiA+
ID4gTkVUTElOS19MSVNURU5fQUxMX05TSUQ/DQo+ID4gPiA+ID4gSXQgbG9va3MgbGlrZSB0aGF0
IGlzIGF0IGxlYXN0IG5lY2Vzc2FyeSB0byBhbGxvdyB0aGUgaW5pdA0KPiA+ID4gPiA+IG5hbWVz
cGFjZWQNCj4gPiA+ID4gPiB1ZGV2DQo+ID4gPiA+ID4gdG8gcmVjZWl2ZSBub3RpZmljYXRpb25z
IG9uDQo+ID4gPiA+ID4gL3N5cy9mcy9uZnMvbmV0L25mc19jbGllbnQvaWRlbnRpZmllciwNCj4g
PiA+ID4gPiB3aGljaA0KPiA+ID4gPiA+IHdvdWxkIGJlIGEgcHJlLXJlcSB0byBhdXRvbWF0aWNh
bGx5IHVuaXF1aWZ5IGluIGNvbnRhaW5lcnMuDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gSSdtZCBp
bnRlcmVzdGVkIHNpbmNlIGl0IHdpbGwgaW5mb3JtIHdoZXRoZXIgSSBuZWVkIHRvIHNlbmQNCj4g
PiA+ID4gPiBwYXRjaGVzDQo+ID4gPiA+ID4gdG8NCj4gPiA+ID4gPiBzeXN0ZW1kJ3MgdWRldiwg
YW5kIHBvdGVudGlhbGx5IG9wZW4gdGhlIGNhbiBvZiB3b3JtcyBvdmVyDQo+ID4gPiA+ID4gdGhl
cmUuIA0KPiA+ID4gPiA+IFlldCBpdHMNCj4gPiA+ID4gPiBub3QgeWV0IGNsZWFyIHRvIG1lIGhv
dyBhbiBpbml0IG5hbWVzcGFjZWQgdWRldiBwcm9jZXNzIGNhbg0KPiA+ID4gPiA+IHdyaXRlIHRv
DQo+ID4gPiA+ID4gYSBuZXRucw0KPiA+ID4gPiA+IHN5c2ZzIHBhdGguDQo+ID4gPiA+ID4gDQo+
ID4gPiA+ID4gQW5vdGhlciBvcHRpb24gbWlnaHQgYmUgdG8gY3JlYXRlIHlldCBhbm90aGVyIGRh
ZW1vbi90b29sDQo+ID4gPiA+ID4gdGhhdCB3b3VsZA0KPiA+ID4gPiA+IGxpc3Rlbg0KPiA+ID4g
PiA+IHNwZWNpZmljYWxseSBmb3IgdGhlc2Ugbm90aWZpY2F0aW9ucy7CoCBVZ2guDQo+ID4gPiA+
ID4gDQo+ID4gPiA+ID4gQmVuDQo+ID4gPiA+ID4gDQo+ID4gPiA+IA0KPiA+ID4gPiBJIGRvbid0
IHVuZGVyc3RhbmQuIFdoeSBkbyB5b3UgbmVlZCBhIG5ldyBkYWVtb24vdG9vbD8NCj4gPiANCj4g
PiBCZWNhdXNlIHdoYXQgd2UndmUgZ290IG9ubHkgd29ya3MgZm9yIHRoZSBpbml0IG5hbWVzcGFj
ZS4NCj4gPiANCj4gPiBVZGV2IHdvbid0IGdldCBrb2JqZWN0IG5vdGlmaWNhdGlvbnMgYmVjYXVz
ZSBpdHMgbm90IHVzaW5nDQo+ID4gTkVUTElOS19MSVNURU5fQUxMX05TSURzLg0KPiA+IA0KPiA+
IFdlIG5lZWQgdG8gZmlndXJlIG91dCBpZiB3ZSB3YW50Og0KPiA+IA0KPiA+IDEpIHRoZSBpbml0
IG5hbWVzcGFjZSB1ZGV2ZCB0byBoYW5kbGUgYWxsIGNsaWVudF9pZCB1bmlxdWlmaWVycw0KPiA+
IDIpIHdlIGV4cGVjdCBuZXR3b3JrIG5hbWVzcGFjZXMgdG8gcnVuIHRoZWlyIG93biB1ZGV2ZA0K
PiA+IDMpIG9yIGJvdGguDQo+ID4gDQo+ID4gSSB0aGluayAyIHZpb2xhdGVzICJsZWFzdCBzdXJw
cmlzZSIsIGFuZCAzIG1pZ2h0IG5vdCBiZSBzb21ldGhpbmcNCj4gPiBhbnlvbmUNCj4gPiBldmVy
IHdhbnRzLsKgIElmIHRoZXkgZG8sIHdlIGNhbiBmaXggaXQgYXQgdGhhdCBwb2ludC4NCj4gPiAN
Cj4gPiBTbyB0byBtYWtlIDEgd29yaywgd2UgY2FuIHRyeSB0byBjaGFuZ2UgdWRldmQsIG9yIG1h
eWJlIGp1c3QNCj4gPiBoYWNraW5nIGFib3V0DQo+ID4gd2l0aCBuZnNfbmV0bnNfb2JqZWN0X2No
aWxkX25zX3R5cGUgd2lsbCBiZSBzdWZmaWNpZW50Lg0KPiANCj4gSSBhZ3JlZSB0aGF0IDEgc2Vl
bXMgbGlrZSB0aGUgcHJlZmVycmVkIGFwcHJvYWNoLCB0aG91Z2gNCj4gSSBkb24ndCBoYXZlIGEg
dGVjaG5pY2FsIHN1Z2dlc3Rpb24gYXQgdGhpcyBwb2ludC4NCj4gDQoNCkkgc3Ryb25nbHkgZGlz
YWdyZWUuICgxKSByZXF1aXJlcyB0aGUgaW5pdCBuYW1lc3BhY2UgdG8gaGF2ZSBpbnRpbWF0ZQ0K
a25vd2xlZGdlIG9mIGNvbnRhaW5lciBpbnRlcm5hbHMuIFdoeSBkbyB3ZSBuZWVkIHRvIG1ha2Ug
dGhhdCBhDQpyZXF1aXJlbWVudD8gVGhhdCB2aW9sYXRlcyB0aGUgZXhwZWN0YXRpb24gdGhhdCBj
b250YWluZXJzIGFyZQ0Kc3RhdGVsZXNzIGJ5IGRlZmF1bHQsIGFuZCBhbHNvIHRoZSBleHBlY3Rh
dGlvbiB0aGF0IHRoZXkgb3BlcmF0ZQ0KaW5kZXBlbmRlbnRseSBvZiB0aGUgZW52aXJvbm1lbnQu
DQoNCklmIHlvdSByZWFsbHkgZG8gd2FudCBleHRlcm5hbCBjb250cm9sIG92ZXIgdGhlIHV1aWQg
dGhhdCBpcyBzZXQsIHRoZW4NCml0IHNob3VsZCBiZSBwcmV0dHkgdHJpdmlhbCB0byBkbyBzbyBi
eSB1c2luZyB0aGUgc3RhbmRhcmQgY29udGFpbmVyDQp0b29scyBmb3IgbWFuaXB1bGF0aW5nIHRo
ZSBuYW1lc3BhY2UgKGUuZy4gdG8gbW91bnQgYSBmaWxlIHRoYXQgaXMNCnVuZGVyIGNvbnRyb2wg
b2YgdGhlIHBhcmVudCBhcyAvZXRjL25mczQtdXVpZC5jb25mIG9yIHdoYXRldmVyKS4NCg0KSG93
ZXZlciBpbiBtb3N0IGNhc2VzIHRoYXQgSSBjYW4gdGhpbmsgb2YsIGlmIHRoZSBjb250YWluZXIg
aXMgZG9pbmcNCml0cyBvd24gTkZTIG1vdW50aW5nLCB0aGVuIGl0IGlzIGdvaW5nIHRvIGhhdmUg
dG8gYmUgc2V0IHVwIHdpdGggaXRzDQpvd24gbmZzLXV0aWxzLCBldGMsIHNvIHRoZXJlIGlzIG5v
IHJlYXNvbiB3aHkgd2UgY2FuJ3QgYWxzbyByZXF1aXJlDQp1ZGV2Lg0KDQotLSANClRyb25kIE15
a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQu
bXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
