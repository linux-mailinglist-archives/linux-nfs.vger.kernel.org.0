Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72F7A340882
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Mar 2021 16:14:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbhCRPNi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 18 Mar 2021 11:13:38 -0400
Received: from mail-eopbgr1310125.outbound.protection.outlook.com ([40.107.131.125]:10944
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231273AbhCRPNK (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 18 Mar 2021 11:13:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iiQrgwxYSO4Q9gSfAJlxXsSZIZ821IFHOVJkvnP0Lf9E/WBa2nUmmZXB9GwioGkYVf3xG83GZ5o7thB4lyUF2seGpzDvFsnHYqC+AFIunRBu0pUBdQU8RorYh+2Rzo6BNdyBeL1z4yqQujAf4G7ANsbmKjkQTunvMygBG75puyl0mVTZT7+LCb2IAfjYbOnO6P7lKEAFB1VtNcTLe6tiXnBPeH+h2dMMleEg+mqAQl9/+Mkw22TvFX3DOzOHnyosZtUkIt+YbttVmCs8s5gc+REw8sM7ARym3GmwBH+UTsSxEUkXb7yGk40unbb/hKmZTZz0UxEjKwOwwK3Hit2UNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JN0HJlY8DPn74wFwRVewqFQ3J7tq7K/8uuIMmC+k8Hc=;
 b=C9O35kwZ3mjOzd4SmyRi000Do2F3CP4KpCZqXCrc8uMFhEx7FAVPCyyMFumL72VtJ752JilZdc+SuIWMkCOJWY3bKKKaMTF/qhod4+TiDRGB1C0gdU0t5W7inYF61vkyiIIHGpV200qLSEe5bMJoS8tgImXQr8drX7StMv2LTiKa/KFpa4m3S4kpYr+ryX3fhqPEKXwX59qyVaRhZk4yeIbyPBfpacoC9KV6mLUpESZqpuuqMEpHWvOt9oungQwK+K/iRsrFwiINB6SnRQO6G6ojkWylLy4lK9FXiQbFW63iHmcRbDzzxyYrkBp+r2VWwqdMpDRDP/20QsqWCvUyNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JN0HJlY8DPn74wFwRVewqFQ3J7tq7K/8uuIMmC+k8Hc=;
 b=clI385DY/Cz1ruxmY1cnqyUKfHM3Con28jXzy69u7bLFeavSmvVXatF6X/05ok1L6f2bn5vvbGb/nBwNwEKMKqUpR8uTiwp7owJK0/fAModubI4595SsVZSLVOYC60wlnToZWlEDt30TaO2Cbs/fjyQGO7rQAtMdHhdkTIZOTSc=
Received: from SG2P153MB0361.APCP153.PROD.OUTLOOK.COM (2603:1096:0:4::11) by
 SG2P15301MB0062.APCP153.PROD.OUTLOOK.COM (2603:1096:3:10::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.4; Thu, 18 Mar 2021 15:13:06 +0000
Received: from SG2P153MB0361.APCP153.PROD.OUTLOOK.COM
 ([fe80::cd6e:9dc1:85ac:f488]) by SG2P153MB0361.APCP153.PROD.OUTLOOK.COM
 ([fe80::cd6e:9dc1:85ac:f488%6]) with mapi id 15.20.3977.015; Thu, 18 Mar 2021
 15:13:06 +0000
From:   Nagendra Tomar <Nagendra.Tomar@microsoft.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: RE: [RFC] nconnect xprt stickiness for a file
Thread-Topic: [RFC] nconnect xprt stickiness for a file
Thread-Index: AdcbmG3Wy+rLrgPySr2+3WoogOFJygAZiM4AAACZxwAAAg0hAA==
Date:   Thu, 18 Mar 2021 15:13:06 +0000
Message-ID: <SG2P153MB0361581E473CD1F4FBEB4EDC9E699@SG2P153MB0361.APCP153.PROD.OUTLOOK.COM>
References: <KU1P153MB01977184017092050048033F9E699@KU1P153MB0197.APCP153.PROD.OUTLOOK.COM>
         <FFBB2134-E8A6-46A7-ADA0-5E222DC11620@oracle.com>
 <70f050a8ac12a0054a01c2bf2b11a557e6a67fd4.camel@hammerspace.com>
In-Reply-To: <70f050a8ac12a0054a01c2bf2b11a557e6a67fd4.camel@hammerspace.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-03-18T15:13:04Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=4fdd0bfb-f726-4ddf-bd32-08697d558c9a;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: hammerspace.com; dkim=none (message not signed)
 header.d=none;hammerspace.com; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [122.172.188.128]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f6a0815f-38de-459e-ade7-08d8ea205588
x-ms-traffictypediagnostic: SG2P15301MB0062:
x-microsoft-antispam-prvs: <SG2P15301MB00625FEA587CA4D6BE3D6C559E699@SG2P15301MB0062.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IKgx3KZEZS8M8nzJgg2UwfsXmUcKNezp5nLoMy6i4VD+tG3KR2ul0Ov3MAj8LwdBXMUJMGsvuAeFMGyZOb7PKhBM+zbLBPKnBmUqNhZ0VKU5uHVAXjS4HrCOz8GJw0deP6WwRMPG3T/T4VHmvH8QRYKvxl9MkZGMoF2YSQLhv6roghRoe0MN7PmsQx9eb+YuEBvMKG69yeLx1ag5xBIolRtO/s/0pCSAsT0LrlgJFW5V4Pl0QU8HJX7v6q3RsfCk4Aa7PMj2oiDaYskRI8bFSQcq7oQhsVA8oYoeWNqXqT1a/wGttaNcyqx1M8L2LZlin679LZV2KINBtzAKiPB6OQTRW7K3mA3F74lMcnTox7jFvnjbVpEsfAOMAYXydDwjshEHAKUvfaO+tTwJ4rrnD93nP+1D5BQIKF+h4P72Jbx/dYKsqcbk/77yULbaVvS2ERixrSL5xT25a22OvWW9APaqVbWzrhExY0WKz55m2VAXx02DlkkxJ5XnS3U6zneflrPVfpoGH43iMMJZ9fEnRlZq1quI7+YCQmZfiPNerLcRVml9UXcoFLKjtw9B+O7I8gZZvm/UpaBuurBDF/XLjZndNm0Jyl+IifA8DzoIR8ZezbDrzuRFDbKMI27H3PGV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2P153MB0361.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(376002)(366004)(346002)(396003)(478600001)(83380400001)(8676002)(52536014)(316002)(66446008)(66946007)(9686003)(76116006)(5660300002)(71200400001)(66476007)(55016002)(38100700001)(64756008)(66556008)(33656002)(86362001)(55236004)(8990500004)(53546011)(6506007)(10290500003)(26005)(4326008)(7696005)(186003)(82950400001)(2906002)(110136005)(8936002)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?SUEzM0lTdTBKYXFXUXlkU1IvWi9iNTVsUEZvZCs5eDBEQ3F6akJObXlDWjRp?=
 =?utf-8?B?aVFBRGxXeHpSNFMzZjJoSFlRQmJndlZ4K1B6MkZXVVhmUno3R0RJRHBMT1hw?=
 =?utf-8?B?anJQNzVxV2xTenZDNS9NSjNrUHpaZmVWZXRiTFhNQU9QaDRXYzNHUFkyM0N4?=
 =?utf-8?B?OStwL2RxMVB3Q0tIZDBXK2xSY0ZOMTZRL3FmN2tYV3pIQXJwNU9Nd094cW1s?=
 =?utf-8?B?QmwyUjhGMDJHbEYvTzd6S2dJbTJRck40MFVsTEdDcDVGQ2grL3FkZ1hQUE5r?=
 =?utf-8?B?NlluMEdSdElQY2w5eEdGZFQ0ODh0TlQ4YmFkRUFod0VCMHlMa09rQ3R2Q3BQ?=
 =?utf-8?B?RjBoQ0RaWmJqRzZnYXRRNEd6UkplZlFhYmczSStNMzc1dzdsem9PWVFFekF0?=
 =?utf-8?B?ZjBCUDg1RURycWFtUWNldG4zNkVrZDNMdGVVSFpvVzNCR2g2MUMzalhDUkN2?=
 =?utf-8?B?cXZMLzd3ZlpXVUIxTzFUQ2NqdkpFa0tMNU41cjY4RDVPUDhDN0g5cnh6bG5S?=
 =?utf-8?B?V1BtckJCT1BlQnZuQWtoQWJmY1hLY2loTXhIK3hNbUR5NUp2UlYwWU1ndG1t?=
 =?utf-8?B?YURmYnRQUkRETGtQQ0gxMUdKbTZBMzNoTnh5S1FnOVo3NmRSR3BxTUF6dTRC?=
 =?utf-8?B?UFRsVGpYZWxWRnlEOXp5WUp3dTZlUm1SaG91QzNGYVNsaVJSb3hNNDIwM2lI?=
 =?utf-8?B?VG9rVHlIK2dFMkFDaUtCN1NuTW1pelJJd0pZV0JKTlBHTW5JYmxuOXR3OTJW?=
 =?utf-8?B?SW9KWE9SVWVJZmRQNU9pTHF1N05vUUpqVWR3dGFaVW1kV0ZZenNhSWJ3SHlt?=
 =?utf-8?B?M1E2a3d4ZUdjc0ZqZGdMRnZUc20yY01CaWF2TFJKWVJkQUExblQrdlY5L3pK?=
 =?utf-8?B?Z3ZTc2JYZkxwa3ZwVlRWMkRPSE1QYXNiZWFSdzN2ZnhPdnUvLzBoVlhQMEpz?=
 =?utf-8?B?Y0dIRmZINWxkcUVQajNTQm5zVVpjMzRoTTFrWHRQZVlXS0htWXJKbEtlS3NC?=
 =?utf-8?B?SE5ETXpLU0VnVnFQcTVDaXBRbTN5aDBvbFVzeXl1R0pCNzJTR092MzU5ZUZW?=
 =?utf-8?B?RGw4YzRNWjAvWnJSWm04M29DN1RBQzU0d25tUFFFbnM0V0EybWNhcVVsT1Zr?=
 =?utf-8?B?V1NPVUNqaURRd3IwVEZaY2NJMXkwcXcrOWxCb21XazY5eW4zSU5ETDdlVExP?=
 =?utf-8?B?Z2FNdlA4akpmUWt0TjF4bnVoSEZ0ODdwRkVOUzRQamt1WVZWSzJlVnRPZHdC?=
 =?utf-8?B?RUNOYU1FSm1zdmdjdk92dUFraTErTnhmVnhPZE5vaHYrN3dRT0xTSGEyNzN5?=
 =?utf-8?B?L0U4d24zT1VPSXVKWkVXZW1iTWxkTGFsNU5EdlZBbEYxN2U0ZzhBUEZEbUtp?=
 =?utf-8?B?YWdGeWNoQ2JvMHd1QWZoUGpyVFc4ckdhbjlmY09nZ0lOTWhtVlhkdnlKRDRo?=
 =?utf-8?B?ODlWRTdVM1RRUldUUTB5K2YrVGFKYU1HdElQRlBNWTNtWHJQdVNtemVyQUJU?=
 =?utf-8?B?bmtVZnAxT3dZU0d4M3RGQUJ6KzhXSEN2b3lhNXhwenRVR2JFRGxOclh4S3lw?=
 =?utf-8?B?QWxWbEJlcXYwL0tKNjRjVDFUeTBRUW1OSVFYdi9Ia0dPVUxTWVVYVG1sT2RT?=
 =?utf-8?B?dXNQT1ppOW42YnRLTk1NVWxXMTRzT2R6RHBUM2FxZUw0ME91STMzWjNsVEdP?=
 =?utf-8?B?UlZ3YjlkcjltQVc4aWprM0JVSUtaV21Obk9wMWhqdkExMDdPZmMyNlY0ZUVN?=
 =?utf-8?Q?87JozGst1yPveNJLI5DlqOvKZouJ2F9nGFFn7qk?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2P153MB0361.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f6a0815f-38de-459e-ade7-08d8ea205588
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2021 15:13:06.5170
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vyCV/BhyVb8fOA4ZE06zXPY0QvveLHLXcchVClMklae4w0hufi4PodDI6Q9PmgzMC2JQtjJkWT+xtPvYX0jyTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2P15301MB0062
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

VGhhbmtzIFRyb25kIGFuZCBDaHVjayBmb3IgeW91ciBpbnB1dHMhDQpTb3JyeSwgSSBkaWRu4oCZ
dCBtYWtlIHRoZSBORlMgdmVyc2lvbiBjbGVhci4gSXTigJlzIHYzLCBzbyBwTkZTIGFuZCBhbnl0
aGluZyBmYW5jeSBpcyBub3QgYW4gb3B0aW9uLg0KQWN0dWFsbHkgbmNvbm5lY3Qgd29ya3MgZ3Jl
YXQgd2l0aCB0aGUgY2hhbmdlIHRvIGZvcmNlIHNwZWNpZmljIGZpbGUgcmVxdWVzdHMgdG8gc3Bl
Y2lmaWMgY29ubmVjdGlvbnMuDQpJ4oCZbGwgYWRkIGEgbW91bnQtdGltZS1zZWxlY3RhYmxlIHhw
cnQgcG9saWN5LCBhcyBUcm9uZCBzdWdnZXN0ZWQuICBXaWxsIHRyeSB0byBrZWVwIHRoZSBjaGFu
Z2UNCmdlbmVyaWMgc28gdGhhdCBpdCBjYW4gYmUgb2YgdXNlIGZvciBvdGhlcnMgd2l0aCBzaW1p
bGFyIOKAnGRvbuKAmXQgc3ByZWFkIHNhbWUgZmlsZSByZXF1ZXN0cyB0byBtdWx0aXBsZSBub2Rl
c+KAnQ0KdXNlY2FzZXMuIEnigJltIHN1cmUgdGhlcmUgd291bGQgYmUgb3RoZXIgY2x1c3RlcmVk
IE5GUyBzZXJ2ZXJzIHdobyB3aWxsIGJlbmVmaXQgZnJvbSByZXN0cmljdGluZyANCmZpbGUgcmVx
dWVzdHMgdG8gc3BlY2lmaWMgY29ubmVjdGlvbnMvbm9kZXMuDQoNClRoYW5rcywNClRvbWFyDQoN
Ci0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBUcm9uZCBNeWtsZWJ1c3QgPHRyb25k
bXlAaGFtbWVyc3BhY2UuY29tPiANClNlbnQ6IDE4IE1hcmNoIDIwMjEgMTk6NDQNClRvOiBOYWdl
bmRyYSBUb21hciA8TmFnZW5kcmEuVG9tYXJAbWljcm9zb2Z0LmNvbT47IGNodWNrLmxldmVyQG9y
YWNsZS5jb20NCkNjOiBsaW51eC1uZnNAdmdlci5rZXJuZWwub3JnDQpTdWJqZWN0OiBbRVhURVJO
QUxdIFJlOiBbUkZDXSBuY29ubmVjdCB4cHJ0IHN0aWNraW5lc3MgZm9yIGEgZmlsZQ0KDQpPbiBU
aHUsIDIwMjEtMDMtMTggYXQgMTM6NTcgKzAwMDAsIENodWNrIExldmVyIElJSSB3cm90ZToNCj4g
DQo+IA0KPiA+IE9uIE1hciAxNywgMjAyMSwgYXQgOTo1NiBQTSwgTmFnZW5kcmEgVG9tYXIgPA0K
PiA+IE5hZ2VuZHJhLlRvbWFyQG1pY3Jvc29mdC5jb20+IHdyb3RlOg0KPiA+IA0KPiA+IFdlIGhh
dmUgYSBjbHVzdGVyZWQgTkZTIHNlcnZlciBiZWhpbmQgYSBMNCBsb2FkLWJhbGFuY2VyIHdpdGgg
dGhlDQo+ID4gZm9sbG93aW5nDQo+ID4gQ2hhcmFjdGVyaXN0aWNzIChyZWxldmFudCB0byB0aGlz
IGRpc2N1c3Npb24pOg0KPiA+IA0KPiA+IDEuIFJQQyByZXF1ZXN0cyBmb3IgdGhlIHNhbWUgZmls
ZSBpc3N1ZWQgdG8gZGlmZmVyZW50IGNsdXN0ZXIgbm9kZXMNCj4gPiBhcmUgbm90IGVmZmljaWVu
dC4NCj4gPiDCoMKgIE9uZSBmaWxlIG9uZSBjbHVzdGVyIG5vZGUgaXMgZWZmaWNpZW50LiBUaGlz
IGlzIHBhcnRpY3VsYXJseQ0KPiA+IHRydWUgZm9yIFdSSVRFcy4NCj4gPiAyLiBNdWx0aXBsZSBu
Y29ubmVjdCB4cHJ0cyBsYW5kIG9uIGRpZmZlcmVudCBjbHVzdGVyIG5vZGVzIGR1ZSB0bw0KPiA+
IHRoZSBzb3VyY2UgDQo+ID4gwqDCoCBwb3J0IGJlaW5nIGRpZmZlcmVudCBmb3IgYWxsLg0KPiA+
IA0KPiA+IER1ZSB0byB0aGlzLCB0aGUgZGVmYXVsdCBuY29ubmVjdCByb3VuZHJvYmluIHBvbGlj
eSBkb2VzIG5vdCB3b3JrDQo+ID4gdmVyeSB3ZWxsIGFzDQo+ID4gaXQgcmVzdWx0cyBpbiBSUENz
IHRhcmdldGVkIHRvIHRoZSBzYW1lIGZpbGUgdG8gYmUgc2VydmljZWQgYnkNCj4gPiBkaWZmZXJl
bnQgY2x1c3RlciBub2Rlcy4NCj4gPiANCj4gPiBUbyBzb2x2ZSB0aGlzLCB3ZSB0d2Vha2VkIHRo
ZSBuZnMgbXVsdGlwYXRoIGNvZGUgdG8gYWx3YXlzIGNob29zZQ0KPiA+IHRoZSBzYW1lIHhwcnQg
DQo+ID4gZm9yIHRoZSBzYW1lIGZpbGUuIFdlIGRvIHRoYXQgYnkgYWRkaW5nIGEgbmV3IGludGVn
ZXIgZmllbGQgdG8NCj4gPiBycGNfbWVzc2FnZSwNCj4gPiBycGNfeHBydF9oaW50LCB3aGljaCBp
cyBzZXQgYnkgTkZTIGxheWVyIGFuZCB1c2VkIGJ5IFJQQyBsYXllciB0bw0KPiA+IHBpY2sgYSB4
cHJ0Lg0KPiA+IE5GUyBsYXllciBzZXRzIGl0IHRvIHRoZSBoYXNoIG9mIHRoZSB0YXJnZXQgZmls
ZSdzIGZpbGVoYW5kbGUsIHRodXMNCj4gPiBlbnN1cmluZyBzYW1lIGZpbGUNCj4gPiByZXF1ZXN0
cyBhbHdheXMgdXNlIHRoZSBzYW1lIHhwcnQuIFRoaXMgd29ya3Mgd2VsbC4NCj4gPiANCj4gPiBJ
IGFtIGludGVyZXN0ZWQgaW4ga25vd2luZyB5b3VyIHRob3VnaHRzIG9uIHRoaXMsIGhhcyBhbnlv
bmUgZWxzZQ0KPiA+IGFsc28gY29tZSBhY3Jvc3MNCj4gPiBzaW1pbGFyIGlzc3VlLCBpcyB0aGVy
ZSBhbnkgb3RoZXIgd2F5IG9mIHNvbHZpbmcgdGhpcywgZXRjLg0KPiANCj4gV291bGQgYSBwTkZT
IGZpbGUgbGF5b3V0IHdvcms/IFRoZSBNRFMgY291bGQgZGlyZWN0IEkvTyBmb3INCj4gYSBwYXJ0
aWN1bGFyIGZpbGUgdG8gYSBzcGVjaWZpYyBEUy4NCg0KVGhhdCdzIHRoZSBvdGhlciBvcHRpb24g
aWYgeW91ciBjdXN0b21lcnMgYXJlIHVzaW5nIE5GU3Y0LjEgb3IgTkZTdjQuMi4NCg0KVGhhdCBo
YXMgdGhlIGFkdmFudGFnZSB0aGF0IGl0IGFsc28gd291bGQgYWxsb3cgdGhlIHNlcnZlciB0bw0K
ZHluYW1pY2FsbHkgbG9hZCBiYWxhbmNlIHRoZSBJL08gYWNyb3NzIHRoZSBhdmFpbGFibGUgY2x1
c3RlciBub2RlcyBieQ0KcmVjYWxsaW5nIHNvbWUgbGF5b3V0cyBmb3Igbm9kZXMgdGhhdCBhcmUg
dG9vIGhvdCBhbmQgbWlncmF0aW5nIHRoZW0gdG8NCm5vZGVzIHRoYXQgaGF2ZSBzcGFyZSBjYXBh
Y2l0eS4NCg0KVGhlIGZpbGUgbWV0YWRhdGEgYW5kIGRpcmVjdG9yeSBkYXRhK21ldGFkYXRhIHdp
bGwgaG93ZXZlciBzdGlsbCBiZQ0KcmV0cmlldmVkIGZyb20gdGhlIG5vZGUgdGhhdCB0aGUgTkZT
IGNsaWVudCBpcyBtb3VudGluZyBmcm9tLiBJIGRvbid0DQprbm93IGlmIHRoYXQgbWlnaHQgc3Rp
bGwgYmUgYSBwcm9ibGVtIGZvciB0aGlzIGNsdXN0ZXIgc2V0dXA/DQoNCi0tIA0KVHJvbmQgTXlr
bGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5t
eWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
