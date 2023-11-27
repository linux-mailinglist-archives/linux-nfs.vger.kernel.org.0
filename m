Return-Path: <linux-nfs+bounces-106-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9E47FA7DB
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Nov 2023 18:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AAF7280A9F
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Nov 2023 17:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190E4374C3;
	Mon, 27 Nov 2023 17:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="PC160Ptt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A896D189
	for <linux-nfs@vger.kernel.org>; Mon, 27 Nov 2023 09:21:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IDdvSyzt7LzmQrm9Hkx0Si9WXSdSdQ8pMKwmRNBOYP87zaXVxJbSkhcXfeP4q83ZUenO/VWdMbMyv82UWYWobHxYJNXAkH86jYTLCqTjkt7Zcu0ho4d1cu/OWKPB/KtIRhWHvPBhB7LEzcbCrAP6pRsSFVit6o/Kkd/pnYqpgvVLvZXSL90V74/P9AhYZUs00VQgkblkDnjUAASc8svTyO0uR8bAyA2VZNHySZo7oPVaZYh5B0sG1VkfG6uzpgJCa+9VCALEisVWtq+5Yubk5jrLuQnlnkSzJBV0RY8xkYVq6RhQ64ntxn9PHI80j4nvriSBN+zzVesmuysfjcaVjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JGypFmz0QWxqmC0japhwwnoFGx/rViaW5XgJHmFIwS0=;
 b=GW5CzbnKk9rh/RHm9+kZF4kCtXYIjpjXzmFwCG08zDMzOHd9sW8DuMbQHWTxdhVgzGv0gZ2Kya2SkNKCB+bADevTnK8t8ntn9ON4I4EbK6evPkunVbLTsJ+YUJ36hnON4CFKcYImmT6oEfW3mprpI2DtlxeNPxHbQnWZtQBTIaasdRKpU/ylI3EofQ/ePMLvB2txxp/xtmqc1BtepPwwO7CdTcUSfN8ewB01+dmdo9KKpfM0bPMq2BwjQq/TV/J8nts5Ktwj3OcDIySu2D3pF06RVM/C0pMBivGT67KF2CnRXgl1M+oIkCnDN2zHWJa50E6tM0dmVBI5yDl7gNesjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JGypFmz0QWxqmC0japhwwnoFGx/rViaW5XgJHmFIwS0=;
 b=PC160PttN93YWKT+j3Cq929wzjFlo77IrTlk4TNwCACGZr7N41703GB9xdbnZ1DmhqNlJ4x4Y1377XqyPy9y7BsS2Ns/38tkfVfUPxlZbtHfubGEfwB0HrvlfJwl/rNFN7exUHTmf40KUnRXOEvTsS8/vW6YvLed3JUD15oSw8g=
Received: from DM8PR13MB5079.namprd13.prod.outlook.com (2603:10b6:8:22::9) by
 PH7PR13MB6482.namprd13.prod.outlook.com (2603:10b6:510:2f1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Mon, 27 Nov
 2023 17:21:04 +0000
Received: from DM8PR13MB5079.namprd13.prod.outlook.com
 ([fe80::50ca:9941:2396:90f0]) by DM8PR13MB5079.namprd13.prod.outlook.com
 ([fe80::50ca:9941:2396:90f0%5]) with mapi id 15.20.7025.022; Mon, 27 Nov 2023
 17:21:04 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "jlayton@kernel.org" <jlayton@kernel.org>, "thfeathers@sina.cn"
	<thfeathers@sina.cn>, "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC: "tom@talpey.com" <tom@talpey.com>, "Dai.Ngo@oracle.com"
	<Dai.Ngo@oracle.com>, "kolga@netapp.com" <kolga@netapp.com>, "neilb@suse.de"
	<neilb@suse.de>, "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] SUNRPC: _xprt_switch_find_current_entry return xprt with
 condition find_active
Thread-Topic: [PATCH] SUNRPC: _xprt_switch_find_current_entry return xprt with
 condition find_active
Thread-Index: AQHaIUhk3Aa390yJz0aunhS24L1iurCOaaGA
Date: Mon, 27 Nov 2023 17:21:04 +0000
Message-ID: <aa9e250a966c47782f79d258ea9818ae4fcbdbc5.camel@hammerspace.com>
References: <20231127153959.2067-1-thfeathers@sina.cn>
In-Reply-To: <20231127153959.2067-1-thfeathers@sina.cn>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR13MB5079:EE_|PH7PR13MB6482:EE_
x-ms-office365-filtering-correlation-id: c4378a8d-e343-4bfe-1481-08dbef6d3c42
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 wATfC7x3Ymo2ADeZ5pBgi+NHBAEPpkrKnyzH2Ha2oQpkos7Ob/5zt6Oe57ADMoiHcbX3p0WHZ4O5J/neNiwlpQUEyhO7OZzsr/unEaQY5GlJcowfSl3b6fZ3IHQIqNYwhOkEYjeslvOjAY56Mg2Ssn61KZ/nzNpWLABNG2q6G3VhEuOGh7RwC0ai2MwCI9QpmmtgXMb7AlNOAOK1Arn2ZsFbFV4QXH0kq8chG9ErfTIadvZjpt3pHoao+7SOjB/9m0tMX0+fWsY89pQK9T/b9K6Th32gXEaypBl/mGULEO1FmS9HlgBeabaOwAQrS5tgRdoaePUpzntnGXESxTK/NCtt7I/24hGkf0LM53cwCQmVvz7HkM3+yhwxrT+TTJBOjfGSa6jLAsfHVxbixD1a2xsCeAi6E6KJlCzg50/Dj+prp16oIFPb15UPmR3axCf8AdXgPqhFK7MuEBByiAHkfSPbc9eskiW5TRkogVAzOYxC4fWSRU4iGWZ3SCCc2dlLJl8SHrLLBsXA+axAVG7UrcCKR2mdJKQcH8ucD/uRTlDvAyarYgx3MlAaU5VW4sxmTN4agQzC0NWxA2nE0JgkTgnejdZAaj7gRX/G/M8ZLnRuAgRwd6rV9KsS+mOPHZbVi8zOgDt17q+RC7rwdF5NyaDo2QjBXy8ZfG70rCyWB2IMqXlc1fSduy9f2XYRSA74UTcdTq9irsd02JRSWueO4vGm98YZRjiLex/h23Og7t5o10xtTXCS3yi9Ku9yAvxi
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5079.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39840400004)(366004)(396003)(346002)(230922051799003)(230173577357003)(230473577357003)(230273577357003)(230373577357003)(1800799012)(451199024)(186009)(64100799003)(83380400001)(38100700002)(122000001)(8936002)(8676002)(6512007)(6506007)(71200400001)(316002)(91956017)(110136005)(6486002)(966005)(76116006)(86362001)(54906003)(66556008)(66476007)(66446008)(66946007)(64756008)(4326008)(478600001)(5660300002)(4744005)(41300700001)(4001150100001)(36756003)(38070700009)(2906002)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UTE5OW5DeGFPUEFWV2NGaHNDb0h6TUNBQUVKOFZvalpFdk5WSTBRcDNLM2R5?=
 =?utf-8?B?TytHVjhCZ21OWjlYYTJmRFJLaTU0Ry9LV1JZQjQyQzMzSThxc1BrdXpxZEtw?=
 =?utf-8?B?YW5ZQmRIRzVDb0FhS2RKVFNsYkQ3TmMzU2JpRURFZHYxNkhlWFpaQU1QMTl3?=
 =?utf-8?B?cW1GWFZ3V2IwTWpxWW8vL3FpNkhJb2s5dXhkMXlkMnNpSUlSWFh3dVFiZkVJ?=
 =?utf-8?B?UEh4Mkw5UlpFbkN5SEhMclQzNTgyUmFmeUZJY2hLbDU1WU50TGFuRVNubGxX?=
 =?utf-8?B?TXVZWTBlaERydTBsMVJYTHBiZWlRL1BwUmxBdW5UV1lsa1pkSHFibWVjNEZk?=
 =?utf-8?B?WERPQm4zUlBzV2t5NW5oR3k5WkZRRVRuWnFNZ3hXVFNWdlp0cXBwZ3hONWlS?=
 =?utf-8?B?dG5jK052VlRBeWFUNHE5M0hlNk5GeFA3MFFCeUpDOWdZVk1YWDhBY0prZjZj?=
 =?utf-8?B?bDVUc2dQMFIrRE5LZXd5Sm4wc25ocUEza3ZCQ1hCbzFteXpYMWlBVW4vUkQx?=
 =?utf-8?B?Z0wwSWQyRXZRVGxTSVdySmtnNWRXdGo0dlpzOXhGbHhkUWx4VWZPSnFjUEs2?=
 =?utf-8?B?aVQ1R2xGOXJZeGpxcEtyNlovVlpBSUxBU0xzVkRuRCtVUU1WTEZsYk4zMk83?=
 =?utf-8?B?WjJ1Q3hEMWI3RDZrcUhNTC9scGdDWUVEN2ZMallvVUdueGJ3bndoWXhzL0g5?=
 =?utf-8?B?MWl4K2NmVTR0MWIvQzRYS1lmd0RzRXJuYStTWHMzdDFqUkVwTEt4VERlUEFP?=
 =?utf-8?B?NjFnTVlHU09mR1d5aTlUQ0pjR3l0dTdQQWpjTGZWYVQyd3VxQXFNRmZOUmlM?=
 =?utf-8?B?a2ZoSzlaV0pNZFVoRVBiSStUUnFhdmZpTGlxTjJvdmJjTk5SUk5uVFVYN3Ir?=
 =?utf-8?B?M1JoVDVvTmZTUHgrYyt6M2tseHhBa3MreXNDK1UvdG9HV3JEUE9jMlJQTHNX?=
 =?utf-8?B?L2dnZjRKVTArc0tMRVFqR28vRGNiQ3QwMlM0NHJ5RUd0MWg1Tk5mZzV6WG5h?=
 =?utf-8?B?WFlIOTR6OW5mUHZZNE1GbGczMndmWU1nNFMyZFdOK3A0UU9XREdXdTlPQ296?=
 =?utf-8?B?N0pRNGlNNWxYQm54SGlIZFpFQllhZzE5Q282aE8zL3dKaHNFeFhzOS9pOVFY?=
 =?utf-8?B?amVoUkM0VnN2c1lyTWFvY24wWmJ3UGdhSVV2aUowODFUTlhSc2YySkRUY1pV?=
 =?utf-8?B?QS96akFab21NbTVTd3M2T3V3SldvNHIxc2pIZzc1blNRa3pkekN6YWR2VDhp?=
 =?utf-8?B?dUw0UnNxc3BvLzJDa2tCR3BNVG10WXFxci9aQ1lWcXQ5d0doZnpYdTBhT2xQ?=
 =?utf-8?B?MkhkeElXZmdvczkyYmxTVktSL2tiT2NtbXlaVC9rWThlMFFmSEhSeFhlY2Rx?=
 =?utf-8?B?Ty9jV2pmUHRkZkVoTWlLNkl5bDQ1SGVrTDBWMDNqNjEyTWN0WllnZnRCelBk?=
 =?utf-8?B?OHV4MUl6cTFwQi91aVhReXN1VVQwcjluUjRFWHNXSloxeENvQUptVFBuUnpE?=
 =?utf-8?B?MU5NTHR3MmFuejBubUprVEIxeEU0cEh2VWdmb3VqcFRZL052bit3bUcweXNO?=
 =?utf-8?B?UEZreDQrNXRGckJnYUtteEd1dzduVVJOREZOdzF4OVVIZGZXSEV0Y2tEMWUx?=
 =?utf-8?B?OXlPZFBXSDhaVTJDZGkwcENhZENheCtDTDZyclVmamttTEdKV2FMVHpRejZB?=
 =?utf-8?B?eis4YkJ3L2plZ1FtMVJ4MVZBSlZoVnNIRGN0VVZ3T3dONEYxNlhVNkRIcklP?=
 =?utf-8?B?clhWNHFWa3VxbXpJNU5tbEdFWWhQWFVrVEhqYktWdjREZVc4OExoalFQdkpQ?=
 =?utf-8?B?cSt4TUZQQ0MwSE1KaDdmTnlCaGcyZGZpK2NOb295azJGNVVtMXJWakVxVEw0?=
 =?utf-8?B?ZTVDSzFMNm9MQmRMVnhoQ0N2NnJ0VCtUTVZac0ZVLzRQWmdNMTVFY2VJSUk3?=
 =?utf-8?B?bVpERXJjRk44QWRtUU1rT3FpNUYrSW1IZTV5WG05L0ZXSm9XMlUzQ3lDWlNU?=
 =?utf-8?B?YitpcnYxWXRHVVVRVVZ0UVZocXlIN2ZMMlY0cnNNZWNGWU5maHgyV3VJOHE2?=
 =?utf-8?B?MWpLdTNiVVV6My9BbWI3blEzRHJZeFBzblFLdzBVS2wyTVhCVy9GUEVSMU5W?=
 =?utf-8?B?YXZaM1FxVHh5RGhYUTJRUnZCNVdSWG1vY00xbGNMM3hJZDVsNTVvSXVJYThD?=
 =?utf-8?B?OUxPYzlrOTFlYjRtNHIwOFhCNEZRenhRNlN2ZDNLNFJlMnVmYVphcVlTYjlC?=
 =?utf-8?B?QkRXYWpNMG02akNXTzNWdldkdjdBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FD84A6ACA095FF46A2B5AB695154DDDC@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5079.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4378a8d-e343-4bfe-1481-08dbef6d3c42
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2023 17:21:04.3891
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t1EQUJzmgil2VBiUX9Jtl/G1WXowvYZd3YCAjOZ41vhxpusuSXdWQQUIqwxJ0AYzurgFcpQalLo3TeLopPfMsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR13MB6482

T24gTW9uLCAyMDIzLTExLTI3IGF0IDIzOjM5ICswODAwLCBqc3Egd3JvdGU6DQo+IFtZb3UgZG9u
J3Qgb2Z0ZW4gZ2V0IGVtYWlsIGZyb20gdGhmZWF0aGVyc0BzaW5hLmNuLiBMZWFybiB3aHkgdGhp
cyBpcw0KPiBpbXBvcnRhbnQgYXQgaHR0cHM6Ly9ha2EubXMvTGVhcm5BYm91dFNlbmRlcklkZW50
aWZpY2F0aW9uwqBdDQo+IA0KPiBjdXJyZW50IGZ1bmN0aW9uIGFsd2F5cyByZXR1cm4gYSBhY3Rp
dmUgeHBydCBvciBOVUxMIG5vIG1hdHRlciB3aGF0DQo+IGZpbmRfYWN0aXZlDQoNCg0KVGhpcyBw
YXRjaCBjbGVhcmx5IGJyZWFrcyB4cHJ0X3N3aXRjaF9maW5kX2N1cnJlbnRfZW50cnlfb2ZmbGlu
ZSgpLg0KRnVydGhlcm1vcmUsIHdlIGRvIG5vdCBhY2NlcHQgcGF0Y2hlcyB3aXRob3V0IGEgcmVh
bCBuYW1lIG9uIGEgU2lnbmVkLQ0Kb2ZmLWJ5OiBsaW5lLg0KDQpTbyBOQUNLIG9uIHR3byBhY2Nv
dW50cy4NCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5l
ciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=

