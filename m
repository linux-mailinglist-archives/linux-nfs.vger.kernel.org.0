Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1630845CAB9
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Nov 2021 18:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbhKXRSH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 24 Nov 2021 12:18:07 -0500
Received: from mail-mw2nam12on2135.outbound.protection.outlook.com ([40.107.244.135]:6625
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229590AbhKXRSF (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 24 Nov 2021 12:18:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HdAAAOvduDRTYI7ORFb7ASc/02+1ENgakE3BUO0+u5NWJSq9MMU+nvV485+opR7e7fR84cAN65LLB64MBHrVJsV10rc2qrElYI00nSJ4yXnCKnb36lbWpSjOAjWuDBGLGd0VuZbqwY/7vnBPj8qyxwQy2sP4f4GFvPGQpvDtdF5HpFcpsbF4fBPbtRfrLQUbQu/MDTYpY8A/gTcttFUnVW6DPNMR+g4SOPk37c+mSX+XCtmkymS981SmXXLAAj7t4vfkyCeeVTxaJWM+jT0Uh00zL65cGlCecoapHvaCOCb+Z3RXjFnYBhNElyz14W8IfkyE3UTbXp7dc0wpTrVXTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7IFNE6ZF4zksFFe4sJN7XBtUTFbH65if7ydkQIWGKiU=;
 b=GHOrvQN4InJ1RzMyks3b5fAHlgGAuAWRmEYCEjQHc7L4nkXkBq9gWmsqRUcgTQ/6Yx5S9C12erz+IY9E3T4qo5FfumNUh2nrxCSECdiVVA+V29AB6rv96SBjYRmmSmokQM3TXjW2uJziQsi1ywXl3Wb44ASLFhJcNF+ONWQPFWv8DKsTxrHBIVLN3J8FoTEmXgE52QjWn7WFSUK/Fy8ZD4xE5pCP3hpRY+VGFvUhZLx9u9MupBONcYJhZ+Ympp1mTnbZcCY/AY/mdQoKRu4TbPNzNF51N7kqQWU0S3Tr7ZFCdl3rryEy2Tz78khOshljnjF0O4fX5ICWffPT6tqibQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7IFNE6ZF4zksFFe4sJN7XBtUTFbH65if7ydkQIWGKiU=;
 b=EqhLP5gk36sq6FD1zq0zSBlQG/WhqzBym/SQAU9TrS06hBX9kaxFWe7JHS++0VMYvZkjLLZ+y17ItfAyWtLtjr+hs3MyNo3k5f3nedMBgFU5SI/NIh9lf9hl0qhVJFnQqi8PcIQ2TbkiNaiRp/rJebJyWYUoEnpmdFQ4CCiRuUo=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH0PR13MB4682.namprd13.prod.outlook.com (2603:10b6:610:de::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.14; Wed, 24 Nov
 2021 17:14:53 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::288c:e4f1:334a:a08]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::288c:e4f1:334a:a08%3]) with mapi id 15.20.4734.022; Wed, 24 Nov 2021
 17:14:53 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>
CC:     "olivier@bm-services.com" <olivier@bm-services.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "carnil@debian.org" <carnil@debian.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: Kernel panic / list_add corruption when in nfsd4_run_cb_work
Thread-Topic: Kernel panic / list_add corruption when in nfsd4_run_cb_work
Thread-Index: AQHWn6R0BWW7FfEHY0ewFe9+CvNb36mUB/AAgAAVOICAAA6DgIAI+hOAgitf9YCAST4LAIAAZRgAgAMoGoCAAAhggIAAAwoAgAAP/YA=
Date:   Wed, 24 Nov 2021 17:14:53 +0000
Message-ID: <e17bbb0a22b154c77c6ec82aad63424f70bfda94.camel@hammerspace.com>
References: <20201011075913.GA8065@eldamar.lan>
         <20201012142602.GD26571@fieldses.org> <20201012154159.GA49819@eldamar.lan>
         <20201012163355.GF26571@fieldses.org> <20201018093903.GA364695@eldamar.lan>
         <YV3vDQOPVgxc/J99@eldamar.lan>
         <3899037dd7d44e879d77bba67b3455ee@bm-services.com>
         <DACA385D-5BBF-46D0-890D-71572BD0CB8A@oracle.com>
         <20211124152947.GA30602@fieldses.org>
         <0dbe620703eb27f36c02b4e001e74d67390bce9e.camel@hammerspace.com>
         <20211124161038.GC30602@fieldses.org>
In-Reply-To: <20211124161038.GC30602@fieldses.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a62f2bed-c4a3-482c-9a7c-08d9af6dee9b
x-ms-traffictypediagnostic: CH0PR13MB4682:
x-microsoft-antispam-prvs: <CH0PR13MB46821353E81A0FD21D46FC14B8619@CH0PR13MB4682.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fi0+rhVy5i5n0N9TnoftlYMo4YxOP9QXWc4agVyG/RyAKTHwMB4l0T1rf0zsi6GFCr4zxsFS1Wjime8xWb6t5x7VLnxffyn9LvSlSquZCV6tSKc8vDrLAy/eJon63zh9YZ7PEOuaLLBGLdVYAk/jPBFMAiWfkq/AyhFTAALmUyTsmi/QWFqc2DyRMRbn1dATyuF47uwrBTflU6FD0ZkKDlzLNLnKjPqIb4j0gvIGVNtSVQNZBGUCeBRFmjwtXm8s/60CTQA/HW5MGbNZGez8Q5k7BsjrFWYVmf+PLTAdyuUpp8oD7natTjmDq4vPBRmjRacNuPeIK4/bFKQfM93o20gN5xxxXrfx+zaNJclQSI3HSHU6jTzmZOtCRsrUVMFSc9i5y3CjYM9SXTkU4OTAC/KK0GEqxHjiJjlVKDoN2eQTk6En5qRI4EIPDEmGZQp0SrVoD8j843ntXscoR8YagEH56917oSJvB0MJbofKlqyjyMS97MWn0KrGcWXWf3hjW8JgwCc1WiYMfV2E76yRDrbfS5paY+MADsy3mJ15i/v2dJlRrT+e2Xf669SQffAaPo1YWM+fSsvyLfjKGOnT+JVQ9QpDL2sn3f0WADfRbaniK8U9JRo28VtbiC61dOMxtj5KLWTdpNM0cJi22Id5iKJd9s+RxFrO1VkS/peOBjYOnE+ljw6b4RkmgKR0zWnhJA4yoAP4jrSpPojlfCh5tA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(39840400004)(346002)(366004)(376002)(6486002)(64756008)(2616005)(66446008)(66556008)(122000001)(6916009)(4326008)(316002)(8676002)(38070700005)(6506007)(53546011)(26005)(54906003)(66946007)(38100700002)(4001150100001)(2906002)(83380400001)(76116006)(6512007)(8936002)(186003)(71200400001)(66476007)(5660300002)(36756003)(966005)(508600001)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Si9CR1Fab2NGU2c1OW5Fc0pmbm51UWZrNU1pUnkwUWNiNzYzdGJNb3VDcWp2?=
 =?utf-8?B?VDNibS9yaVRaelY1YkdXaVBxTnk0dkFxK3JvSW1TTjlEWVpuS1ZJaDU5bXln?=
 =?utf-8?B?SkkvRXc4ZW5JdU8rZHJEOHkvYnprOEhmeGFQVC9CN0I3QU5yWGlzQ3drcDNB?=
 =?utf-8?B?RDdzajA4NURXTDNTOWVmRDlpb2pkTDg3VzJjdFM3ZUV0Q2RQYXgvNmlxTDVy?=
 =?utf-8?B?QU9lK09ZcmxMRk9wVUh3T2R4QjBoY1V1b1hWbFhWYTNBenpQYkNDdmNDOWp3?=
 =?utf-8?B?UnFKR01SOTVoeFJudUpKNlJITXU0TEdDdkEvcVJCR1RMbTMrMS8vaitLWnNI?=
 =?utf-8?B?VStGaUQyV0hiV1MxZ205aVJHRkpqZWlmYUNXTWdlVUk5MURaUGtMSDVrcytK?=
 =?utf-8?B?QWZJdHd2NXJnL2Q4RFNnODVVQkNmWExYYmFCSUc4L0JaTVJPYXUyWTdsUGoz?=
 =?utf-8?B?RUdVQlhva09ZZ2c3aS85dkd4Z2xnVFNOSE5iUDJXMUc1WWc2VFlrVy9CcFBx?=
 =?utf-8?B?dE42SEFXQlh0c0tnaysrYytIbFo3eEttRFhrVUl2SWNEYkpwb0FmOE5LZzhE?=
 =?utf-8?B?Zk43bUM5aEdKdVlGWmNTYXBMUVhuYnNMUVZsUEFIcllXTS8xMG8vZndRWFdp?=
 =?utf-8?B?TVRkTWFQbEJ2WWVJSi8wY2Q5MHkzT0x2Q0NnbXdIMFhYQlkxUW53WDFCaWVn?=
 =?utf-8?B?L2pxV3F1TXRVRUpUOTBid0pDU0QyYXEyZU9SMndQODM5NkJHV01qSGtwNWUy?=
 =?utf-8?B?MVVWQzMwUXhaL1dxQU9NSmprRzA0bjBOZVpaKytuYlVlWXNySm5Ld0FqUHpp?=
 =?utf-8?B?NTh0cXRnemc3V1JHeEIzaEdBUDhlREdxR3hNZFZoSEFZWmVYN2xOTlZ0QTZC?=
 =?utf-8?B?b3M5K3F0elFZMjNWeGhTSWNadGgyNHJGK3UzQjVMR2lKQUxueU81SnF3d09m?=
 =?utf-8?B?WkpZYk1LY1JUN212c05objZVd0I0cUFlTW54a05RRGJkeG8xUHU5ZVRpZ1Z4?=
 =?utf-8?B?dU0xQkRwR2lhN2FzMHIrbDZxam9HS3ArUFhZNysrQk4rRVBXS1Y4bEdiOC8v?=
 =?utf-8?B?Z2Z5SDNVRURoSW9QKzJXUVdLTUlveHduNFFZSWF1OVFBaXg2Y1JaVW1Ibk9l?=
 =?utf-8?B?TG1ZcjNmTkRmclB3MGxVZ2FzY2dKWU91RUV4U2ZVQ016TXJsbmJQcTJtTUli?=
 =?utf-8?B?ekJ3SmJ4SWtFdTBtZHA5czg0TUtQb3ZVQS9tNkVpSndZVVAvWUNhUEVQc2NE?=
 =?utf-8?B?YThTaUs2RHFCUW1CZ2JPNENJUEpoRlBCbFVOSElXRDdrTkNvVVhDVW9KVURI?=
 =?utf-8?B?M0I3TnBTVDBmbUFhdFBZMDFQdkgxRUowWGZ5dmRNdEhwdkQ2TmM1U1Z1dGtL?=
 =?utf-8?B?OHEyQXNtUkFuWXFUd0ZObWtaQVhDSlZaaUNaaTNoendBUUJzblpFQ29TdWRi?=
 =?utf-8?B?REFrcUhBeEFGNWx2dzhVb1IrMVdncjAwLzI1NlhzMVVLcEhVZjNncGZDQys4?=
 =?utf-8?B?TXcwbHpnRmMwenYyNnJIUEdXc0VjM205OWFGUkhQMGR6dFlJaEJiUGM2bVA2?=
 =?utf-8?B?VC84L01vTmhrN0RmZlVFc1dMUDJuQ2NFNVZVaUdVdEIyZ1pGVTc2U1pXNmp4?=
 =?utf-8?B?d25rN0FtV0tnc011RGp4VHAzOENrRitpTGxSUjY5R1J3cmNyWUtrQWp3RHJM?=
 =?utf-8?B?UzJBQm82cEpISUNrUi90UW13Z2VIcWE1UkVqK1BKeE9MTDZTOWFMT1N3b2hB?=
 =?utf-8?B?VTBjRkFpazNhMkN6ZE5DRzZhTEh5YTJ6dVZQbFB5Z1JSSVNKZUpYM3BPU3Zu?=
 =?utf-8?B?dlc5cFU5T1pjUy9Kb05Lb2VvYnMxUmxFR0lCaTkwaHZKWWEvbUZKQnpDN3Zw?=
 =?utf-8?B?NnppLy8yOGJ3UDlXWk9zclBDeVhlRjl4YXN6ZmFzdTM0K0Nhbi9adEExYjdF?=
 =?utf-8?B?WVB3MXYrdmlXb3FxT3IveEgwTFZJNnJtTjZmblQ1WXVFOTVNQ2RtdldwRUV3?=
 =?utf-8?B?NkdhdUxtZ0J1Skw2QXNQSXZaTUFpTGtWL2psT2M2WUJWOEFJY3FubGJBVDZh?=
 =?utf-8?B?S1d0bUNyK2ZCbVRtOG1POHBWVFhObEkxanF4U2RsUXV3Ukp3Q3hhRGVMNk82?=
 =?utf-8?B?VmRUTGtHWjdiM2srdzQwSjRRSzNzMUtLOVJ2SmZXMlE0aEpyMlpWMFlPbzh3?=
 =?utf-8?Q?4p3Sl690oEKaWhAKoHK6igM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <55C82D7731E39E46B996CB4BDDD979AD@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a62f2bed-c4a3-482c-9a7c-08d9af6dee9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2021 17:14:53.8101
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gWd2/f9TyK3tNSPus/4gOZoN4g2Ak/fjfYAN0hwC0VNKYwVR6iHYUlwfNgLBkHfrQh5VxIcZ0xgzRtL/ZlFABQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR13MB4682
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDIxLTExLTI0IGF0IDExOjEwIC0wNTAwLCBiZmllbGRzQGZpZWxkc2VzLm9yZyB3
cm90ZToNCj4gT24gV2VkLCBOb3YgMjQsIDIwMjEgYXQgMDM6NTk6NDdQTSArMDAwMCwgVHJvbmQg
TXlrbGVidXN0IHdyb3RlOg0KPiA+IE9uIFdlZCwgMjAyMS0xMS0yNCBhdCAxMDoyOSAtMDUwMCwg
QnJ1Y2UgRmllbGRzIHdyb3RlOg0KPiA+ID4gT24gTW9uLCBOb3YgMjIsIDIwMjEgYXQgMDM6MTc6
MjhQTSArMDAwMCwgQ2h1Y2sgTGV2ZXIgSUlJIHdyb3RlOg0KPiA+ID4gPiANCj4gPiA+ID4gDQo+
ID4gPiA+ID4gT24gTm92IDIyLCAyMDIxLCBhdCA0OjE1IEFNLCBPbGl2aWVyIE1vbmFjbw0KPiA+
ID4gPiA+IDxvbGl2aWVyQGJtLXNlcnZpY2VzLmNvbT4gd3JvdGU6DQo+ID4gPiA+ID4gDQo+ID4g
PiA+ID4gSGksDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gSSB0aGluayBteSBwcm9ibGVtIGlzIHJl
bGF0ZWQgdG8gdGhpcyB0aHJlYWQuDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gV2UgYXJlIHJ1bm5p
bmcgYSBWTXdhcmUgdkNlbnRlciBwbGF0Zm9ybSBydW5uaW5nIDkgZ3JvdXBzIG9mDQo+ID4gPiA+
ID4gdmlydHVhbCBtYWNoaW5lcy4gRWFjaCBncm91cCBpbmNsdWRlcyBhIFZNIHdpdGggTkZTIGZv
ciBmaWxlDQo+ID4gPiA+ID4gc2hhcmluZyBhbmQgMyBWTXMgd2l0aCBORlMgY2xpZW50cywgc28g
d2UgYXJlIHJ1bm5pbmcgOQ0KPiA+ID4gPiA+IGluZGVwZW5kZW50IGZpbGUgc2VydmVycy4NCj4g
PiA+ID4gDQo+ID4gPiA+IEkndmUgb3BlbmVkIGh0dHBzOi8vYnVnemlsbGEubGludXgtbmZzLm9y
Zy9zaG93X2J1Zy5jZ2k/aWQ9MzcxDQo+ID4gPiA+IA0KPiA+ID4gPiBKdXN0IGEgcmFuZG9tIHRo
b3VnaHQ6IHdvdWxkIGVuYWJsaW5nIEtBU0FOIHNoZWQgc29tZSBsaWdodD8NCj4gPiA+IA0KPiA+
ID4gSW4gZmFjdCwgd2UndmUgZ290dGVuIHJlcG9ydHMgZnJvbSBSZWRoYXQgUUUgb2YgYSBLQVNB
TiB1c2UtDQo+ID4gPiBhZnRlci0NCj4gPiA+IGZyZWUNCj4gPiA+IHdhcm5pbmcgaW4gdGhlIGxh
dW5kcm9tYXQgdGhyZWFkLCB3aGljaCBJIHRoaW5rIG1pZ2h0IGJlIHRoZSBzYW1lDQo+ID4gPiBi
dWcuDQo+ID4gPiBXZSd2ZSBiZWVuIGdldHRpbmcgb2NjYXNpb25hbCByZXBvcnRzIG9mIHByb2Js
ZW1zIGhlcmUgZm9yIGEgbG9uZw0KPiA+ID4gdGltZSwNCj4gPiA+IGJ1dCB0aGV5J3ZlIGJlZW4g
dmVyeSBoYXJkIHRvIHJlcHJvZHVjZS4NCj4gPiA+IA0KPiA+ID4gQWZ0ZXIgZm9vbGluZyB3aXRo
IHRoZWlyIHJlcHJvZHVjZXIsIEkgdGhpbmsgSSBmaW5hbGx5IGhhdmUgaXQuDQo+ID4gPiBFbWJh
cnJhc2luZ2x5LCBpdCdzIG5vdGhpbmcgdGhhdCBjb21wbGljYXRlZC7CoCBZb3UgY2FuIG1ha2Ug
aXQNCj4gPiA+IG11Y2gNCj4gPiA+IGVhc2llciB0byByZXByb2R1Y2UgYnkgYWRkaW5nIGFuIG1z
bGVlcCBjYWxsIGFmdGVyIHRoZQ0KPiA+ID4gdmZzX3NldGxlYXNlDQo+ID4gPiBpbg0KPiA+ID4g
bmZzNF9zZXRfZGVsZWdhdGlvbi4NCj4gPiA+IA0KPiA+ID4gSWYgaXQncyBwb3NzaWJsZSB0byBy
dW4gYSBwYXRjaGVkIGtlcm5lbCBpbiBwcm9kdWN0aW9uLCB5b3UgY291bGQNCj4gPiA+IHRyeQ0K
PiA+ID4gdGhlIGZvbGxvd2luZywgYW5kIEknZCBkZWZpbml0ZWx5IGJlIGludGVyZXN0ZWQgaW4g
YW55IHJlc3VsdHMuDQo+ID4gPiANCj4gPiA+IE90aGVyd2lzZSwgeW91IGNhbiBwcm9iYWJseSB3
b3JrIGFyb3VuZCB0aGUgcHJvYmxlbSBieSBkaXNhYmxpbmcNCj4gPiA+IGRlbGVnYXRpb25zLsKg
IFNvbWV0aGluZyBsaWtlDQo+ID4gPiANCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqBzdWRvIGVjaG8g
ImZzLmxlYXNlcy1lbmFibGUgPSAwIiA+L2V0Yy9zeXNjdGwuZC9uZnNkLQ0KPiA+ID4gd29ya2Fy
b3VuZC5jb25mDQo+ID4gPiANCj4gPiA+IHNob3VsZCBkbyBpdC4NCj4gPiA+IA0KPiA+ID4gTm90
IHN1cmUgaWYgdGhpcyBmaXggaXMgYmVzdCBvciBpZiB0aGVyZSdzIHNvbWV0aGluZyBzaW1wbGVy
Lg0KPiA+ID4gDQo+ID4gPiAtLWIuDQo+ID4gPiANCj4gPiA+IGNvbW1pdCA2ZGU1MTIzNzU4OWUN
Cj4gPiA+IEF1dGhvcjogSi4gQnJ1Y2UgRmllbGRzIDxiZmllbGRzQHJlZGhhdC5jb20+DQo+ID4g
PiBEYXRlOsKgwqAgVHVlIE5vdiAyMyAyMjozMTowNCAyMDIxIC0wNTAwDQo+ID4gPiANCj4gPiA+
IMKgwqDCoCBuZnNkOiBmaXggdXNlLWFmdGVyLWZyZWUgZHVlIHRvIGRlbGVnYXRpb24gcmFjZQ0K
PiA+ID4gwqDCoMKgIA0KPiA+ID4gwqDCoMKgIEEgZGVsZWdhdGlvbiBicmVhayBjb3VsZCBhcnJp
dmUgYXMgc29vbiBhcyB3ZSd2ZSBjYWxsZWQNCj4gPiA+IHZmc19zZXRsZWFzZS7CoCBBDQo+ID4g
PiDCoMKgwqAgZGVsZWdhdGlvbiBicmVhayBydW5zIGEgY2FsbGJhY2sgd2hpY2ggaW1tZWRpYXRl
bHkgKGluDQo+ID4gPiDCoMKgwqAgbmZzZDRfY2JfcmVjYWxsX3ByZXBhcmUpIGFkZHMgdGhlIGRl
bGVnYXRpb24gdG8NCj4gPiA+IGRlbF9yZWNhbGxfbHJ1LsKgDQo+ID4gPiBJZiB3ZQ0KPiA+ID4g
wqDCoMKgIHRoZW4gZXhpdCBuZnM0X3NldF9kZWxlZ2F0aW9uIHdpdGhvdXQgaGFzaGluZyB0aGUg
ZGVsZWdhdGlvbiwNCj4gPiA+IGl0DQo+ID4gPiB3aWxsIGJlDQo+ID4gPiDCoMKgwqAgZnJlZWQg
YXMgc29vbiBhcyB0aGUgY2FsbGJhY2sgaXMgZG9uZSB3aXRoIGl0LCB3aXRob3V0IGV2ZXINCj4g
PiA+IGJlaW5nDQo+ID4gPiDCoMKgwqAgcmVtb3ZlZCBmcm9tIGRlbF9yZWNhbGxfbHJ1Lg0KPiA+
ID4gwqDCoMKgIA0KPiA+ID4gwqDCoMKgIFN5bXB0b21zIHNob3cgdXAgbGF0ZXIgYXMgdXNlLWFm
dGVyLWZyZWUgb3IgbGlzdCBjb3JydXB0aW9uDQo+ID4gPiB3YXJuaW5ncywNCj4gPiA+IMKgwqDC
oCB1c3VhbGx5IGluIHRoZSBsYXVuZHJvbWF0IHRocmVhZC4NCj4gPiA+IMKgwqDCoCANCj4gPiA+
IMKgwqDCoCBTaWduZWQtb2ZmLWJ5OiBKLiBCcnVjZSBGaWVsZHMgPGJmaWVsZHNAcmVkaGF0LmNv
bT4NCj4gPiA+IA0KPiA+ID4gZGlmZiAtLWdpdCBhL2ZzL25mc2QvbmZzNHN0YXRlLmMgYi9mcy9u
ZnNkL25mczRzdGF0ZS5jDQo+ID4gPiBpbmRleCBiZmFkOTRjNzBiODQuLjhlMDYzZjQ5MjQwYiAx
MDA2NDQNCj4gPiA+IC0tLSBhL2ZzL25mc2QvbmZzNHN0YXRlLmMNCj4gPiA+ICsrKyBiL2ZzL25m
c2QvbmZzNHN0YXRlLmMNCj4gPiA+IEBAIC01MTU5LDE1ICs1MTU5LDE2IEBAIG5mczRfc2V0X2Rl
bGVnYXRpb24oc3RydWN0IG5mczRfY2xpZW50DQo+ID4gPiAqY2xwLA0KPiA+ID4gc3RydWN0IHN2
Y19maCAqZmgsDQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGxvY2tzX2Zy
ZWVfbG9jayhmbCk7DQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgaWYgKHN0YXR1cykNCj4gPiA+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZ290byBvdXRfY2xudF9vZHN0YXRlOw0KPiA+
ID4gKw0KPiA+ID4gwqDCoMKgwqDCoMKgwqDCoHN0YXR1cyA9IG5mc2Q0X2NoZWNrX2NvbmZsaWN0
aW5nX29wZW5zKGNscCwgZnApOw0KPiA+ID4gLcKgwqDCoMKgwqDCoMKgaWYgKHN0YXR1cykNCj4g
PiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBnb3RvIG91dF91bmxvY2s7DQo+ID4g
PiDCoA0KPiA+ID4gwqDCoMKgwqDCoMKgwqDCoHNwaW5fbG9jaygmc3RhdGVfbG9jayk7DQo+ID4g
PiDCoMKgwqDCoMKgwqDCoMKgc3Bpbl9sb2NrKCZmcC0+ZmlfbG9jayk7DQo+ID4gPiAtwqDCoMKg
wqDCoMKgwqBpZiAoZnAtPmZpX2hhZF9jb25mbGljdCkNCj4gPiA+ICvCoMKgwqDCoMKgwqDCoGlm
IChzdGF0dXMgfHwgZnAtPmZpX2hhZF9jb25mbGljdCkgew0KPiA+ID4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoGxpc3RfZGVsX2luaXQoJmRwLT5kbF9yZWNhbGxfbHJ1KTsNCj4gPiA+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBkcC0+ZGxfdGltZSsrOw0KPiA+ID4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBzdGF0dXMgPSAtRUFHQUlOOw0KPiA+ID4gLcKg
wqDCoMKgwqDCoMKgZWxzZQ0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgfSBlbHNlDQo+ID4gPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHN0YXR1cyA9IGhhc2hfZGVsZWdhdGlvbl9sb2Nr
ZWQoZHAsIGZwKTsNCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqBzcGluX3VubG9jaygmZnAtPmZpX2xv
Y2spOw0KPiA+ID4gwqDCoMKgwqDCoMKgwqDCoHNwaW5fdW5sb2NrKCZzdGF0ZV9sb2NrKTsNCj4g
PiANCj4gPiBXaHkgd29uJ3QgdGhpcyBsZWFrIGEgcmVmZXJlbmNlIHRvIHRoZSBzdGlkPw0KPiAN
Cj4gSSdtIG5vdCBzZWVpbmcgaXQuDQoNCkhtbS4uLiBJIHRob3VnaHQgd2Ugd2VyZSBsZWFraW5n
IHRoZSByZWZlcmVuY2UgdGFrZW4gYnkNCm5mc2RfYnJlYWtfb25lX2RlbGVnKCksIGJ1dCB0aGF0
IGRvZXMgZ2V0IGNsZWFuZWQgdXAgYnkNCm5mc2Q0X2NiX3JlY2FsbF9yZWxlYXNlKCkNCg0KPiAN
Cj4gPiBBZmFpY3MgbmZzZF9icmVha19vbmVfZGVsZWcoKSBkb2VzIHRha2UgYSByZWZlcmVuY2Ug
YmVmb3JlDQo+ID4gbGF1bmNoaW5nDQo+ID4gdGhlIGNhbGxiYWNrIGRhZW1vbiwgYW5kIHRoYXQg
cmVmZXJlbmNlIGlzIHJlbGVhc2VkIHdoZW4gdGhlDQo+ID4gZGVsZWdhdGlvbiBpcyBsYXRlciBw
cm9jZXNzZWQgYnkgdGhlIGxhdW5kcm9tYXQuDQo+IA0KPiBSaWdodC7CoCBCYXNpY2FsbHksIHRo
ZXJlIGFyZSB0d28gImxvbmctbGl2ZWQiIHJlZmVyZW5jZXMsIG9uZSB0YWtlbg0KPiBhcw0KPiBs
b25nIGFzIHRoZSBjYWxsYmFjaydzIHVzaW5nIGl0LCBvbmUgdGFrZW4gYXMgbG9uZyBhcyBpdCdz
ICJoYXNoZWQiDQo+IChzZWUNCj4gaGFzaF9kZWxlZ2F0aW9uX2xvY2tlZC91bmhhc2hfZGVsZWdh
dGlvbl9sb2NrZWQpLg0KPiANCj4gSW4gdGhlIC1FQUdBSU4gY2FzZSBhYm92ZSwgd2UncmUgaG9s
ZGluZyBhIHRlbXBvcmFyeSByZWZlcmVuY2Ugd2hpY2gNCj4gd2lsbCBiZSBkcm9wcGVkIG9uIGV4
aXQgZnJvbSB0aGlzIGZ1bmN0aW9uOyBpZiBhIGNhbGxiYWNrJ3MgaW4NCj4gcHJvZ3Jlc3MsDQo+
IGl0IHdpbGwgdGhlbiBkcm9wIHRoZSBmaW5hbCByZWZlcmVuY2UuDQo+IA0KPiA+IEhtbS4uLiBJ
c24ndCB0aGUgcmVhbCBidWcgaGVyZSByYXRoZXIgdGhhdCB0aGUgbGF1bmRyb21hdCBpcw0KPiA+
IGNvcnJ1cHRpbmcNCj4gPiBib3RoIHRoZSBubi0+Y2xpZW50X2xydSBhbmQgbm4tPmRlbF9yZWNh
bGxfbHJ1IGxpc3RzIGJlY2F1c2UgaXQgaXMNCj4gPiB1c2luZyBsaXN0X2FkZCgpIGluc3RlYWQg
b2YgbGlzdF9tb3ZlKCkgd2hlbiBhZGRpbmcgdGhlc2Ugb2JqZWN0cw0KPiA+IHRvDQo+ID4gdGhl
IHJlYXBsaXN0Pw0KPiANCj4gSWYgdGhhdCB3ZXJlIHRoZSBwcm9ibGVtLCBJIHRoaW5rIHdlJ2Qg
YmUgaGl0dGluZyBpdCBhbGwgdGhlIHRpbWUuDQo+IExvb2tpbmcuLi4uwqAgTm8sIHVuaGFzaF9k
ZWxlZ2F0aW9uX2xvY2tlZCBkaWQgYSBsaXN0X2RlbF9pbml0KCkuDQo+IA0KPiAoSXMgdGhlIFdB
Uk5fT04gdGhlcmUgdG9vIHVnbHk/KQ0KPiANCg0KSXQgaXMgYSBsaXR0bGUgbmFzdHkgdGhhdCB3
ZSBoaWRlIHRoZSBsaXN0X2RlbCgpIGNhbGxzIGluIHNldmVyYWwNCmxldmVscyBvZiBmdW5jdGlv
biBjYWxsLCBzbyB0aGV5IHByb2JhYmx5IGRvIGRlc2VydmUgYSBjb21tZW50Lg0KDQpUaGF0IHNh
aWQsIGlmLCBhcyBpbiB0aGUgY2FzZSBoZXJlLCB0aGUgZGVsZWdhdGlvbiB3YXMgdW5oYXNoZWQs
IHdlDQpzdGlsbCBlbmQgdXAgbm90IGNhbGxpbmcgbGlzdF9kZWxfaW5pdCgpIGluIHVuaGFzaF9k
ZWxlZ2F0aW9uX2xvY2tlZCgpLA0KYW5kIHNpbmNlIHRoZSBsaXN0X2FkZCgpIGlzIG5vdCBjb25k
aXRpb25hbCBvbiBpdCBiZWluZyBzdWNjZXNzZnVsLCB0aGUNCmdsb2JhbCBsaXN0IGlzIGFnYWlu
IGNvcnJ1cHRlZC4NCg0KWWVzLCBpdCBpcyBhbiB1bmxpa2VseSByYWNlLCBidXQgaXQgaXMgcG9z
c2libGUgZGVzcGl0ZSB5b3VyIGNoYW5nZS4NCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4
IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1t
ZXJzcGFjZS5jb20NCg0KDQo=
