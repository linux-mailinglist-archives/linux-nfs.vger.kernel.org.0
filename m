Return-Path: <linux-nfs+bounces-2769-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EAF38A1F57
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Apr 2024 21:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBDECB2B539
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Apr 2024 19:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE07FD534;
	Thu, 11 Apr 2024 19:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="euhlLzyO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2115.outbound.protection.outlook.com [40.107.237.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F12C3D9E
	for <linux-nfs@vger.kernel.org>; Thu, 11 Apr 2024 19:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712862724; cv=fail; b=Y21G41WiwkF8IsozaitgWR820jFukvb8LIhqEDa92Kbx0MSr2e6qUge5nnHIwk4epVd9VKYojLSt6qqunA2lVXp7K+NsIi+ZONnlLKmRsElJkamqe0u9sp/nKw2gIDphgqBJTZdnnENkWaXMPuySn0V3yOec25K01YOymovwD7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712862724; c=relaxed/simple;
	bh=WdwYkjac4qxYC5ib7WKgwAqL24jU0ORnKmt076ygu6o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fnUS8LYCWP3g29qQ/EBLOiV7o7Y5jN5te2NKVZlw2S6LVImswePpZ5KQqQ5lEsSrDM2hrH6XL7e7/7ROTcnZzNl/9weoXI3hTFEcZqfExkv64aEInluGEAFnVg6mGeJSCQuHgQRejSjlbE9q8v5jU5/f3WNmXtO7jaIr13DjRbY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=euhlLzyO; arc=fail smtp.client-ip=40.107.237.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l5g1j7cYKG124rcam0XWNkYAX/cEnEie8yPsiC1XX+yH20Bu/IkXW4GgUX9ZVFyutQp8tAMDXvXF13giI8t1fDuqjae4FcAl+VqFueJ2Y0PPYmpZpHaIaQzJQhJORBWTPrVQaMOMpRjX4MJBufsABiYhIzDbFs1qbL1fuTngl8il+RHi1VUhu43gXclFrj+qFjG0bEwWLhbN4xMI8ZshTCLebnbG4mLHKkVqFl+T8UDrVwa74uYAnHJFtamO2FkuDtHdls8M31rqPIIZIFv5Ur5f4EwjARGrsuzs6W2DGx6XP76GRtbfPhXDOQGBfMpDoX8GRZewDl8PLQUFwWkwoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WdwYkjac4qxYC5ib7WKgwAqL24jU0ORnKmt076ygu6o=;
 b=jZvGXGwtEXNApXZxokhM6wVHax/2lm+mCOOwfj+xmJDue8A5Y279mD+gn9q3vzmSVDS+JHZsftRzst8ox70Kg4rWioP/NaVaouutizOLhk0hVfJqQdlrBU8nI0psIWX9rjBh8qttrfvbJqIZnveZhv515HBwpvl4+LoiM/0fPJE1wKFWEQuGLbPp+YkQD+X5uQykLOxiuAFzP7r8bs0u8gu30rej9inDEuzrzl88M825O/HdhpnNVBgXolann/Wpi2u1drEuazEGRaH8FtJfLMWrE2nnGqLJDqe0yRSPyIHf5tVAd9nWWXHvhBPn1CfF9ymvUZTgsOXhPUevSUTT8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WdwYkjac4qxYC5ib7WKgwAqL24jU0ORnKmt076ygu6o=;
 b=euhlLzyOM/Py8TIffnFpAb1KCNWsr0sRmpitNLTYN5Nb+tpHxo42e5/v9/f7YtbHCbsqPwW0cxQuhFINbE91la59N/4WSi8BQNlq3F2sbafu9aJ4wNdKo7if+17oaBhvDJwLurvaDbL1incQuSaA5bn7EsjWYRfp3aEL71xzop8=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by PH0PR13MB5683.namprd13.prod.outlook.com (2603:10b6:510:112::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Thu, 11 Apr
 2024 19:11:58 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::5bb5:501a:fb40:5057]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::5bb5:501a:fb40:5057%6]) with mapi id 15.20.7409.042; Thu, 11 Apr 2024
 19:11:58 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "SteveD@redhat.com" <SteveD@redhat.com>
CC: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2] nfsd: allow more than 64 backlogged connections
Thread-Topic: [PATCH v2] nfsd: allow more than 64 backlogged connections
Thread-Index: AQHacYO+U9hQkdHelkq+kHdJEXXWKbFjpTaA
Date: Thu, 11 Apr 2024 19:11:58 +0000
Message-ID: <6241cb24ebbb7e9a171e0ab0581d6b2fef90df1b.camel@hammerspace.com>
References: <20240308180223.2965601-1-trond.myklebust@hammerspace.com>
In-Reply-To: <20240308180223.2965601-1-trond.myklebust@hammerspace.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|PH0PR13MB5683:EE_
x-ms-office365-filtering-correlation-id: d344a800-d216-4e0b-b20e-08dc5a5b424e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 M4jNqsjjVsTzU76Tkahl1pTAkdB30xwRifgUUgNKxTNBb6CKi/3eaa+HdvZisU9w81CXCICcgh1vldY3tbi6zVCM5vyRBwmSMai9iD3LoakX4ouGQIKNtuTYOvaU3LQUruwL9SbRDq88cMxLJ6CEI+nyiiDMebRleeGMTnMJWzoTofLAINcq5ncxgh3T0noZl7uflnSNGFvt+bCrbKbZSWn63tpcIYjJZZTJFdx1Uw2Uc6b5W1d59tGy3JZYeXQPklxpRXM7EOS54VUllhmMIcizyrL4FnQ/rKqoZN1d2RV78/boADtb6wpvPU9fJeFX9qhjvkUC9aj+hkHoHCsfVbs6w+mIqLoQq9s455/AXXp3BGk7/GE0F/2eK01PMshOfujZllNrj0Yy0eZXmSTXUd5rnhiTEq372ttiNJZmPciqw1nqA6r7rknNYjpAPW1c73fqA0BNTSB1BGo7bR6iFIDJpZ4r8g+tgtb3YzE5FtiRVNuFyqinDaZsM3PPgyy1dk4cejIGoG1P/AaMwXKMAP9QGKIlRrnqeqDcfK2wxpuM2yeinOFtdokMBu5IeKptR0lbZyE1vlydWN//8ykJOrIMMTUDO5kuO/fwJV7fWyxPKqDWbqukM2qcC/dmIhfMUAA8sXlqR3YaEPzrWhQbzhMLdVgIBlYX3uqyMJDTF3Mf+Koa+Tvaa0+kSc/RBObihJGKoJVmrOdMmcOgur/J71zR2+N2GalWOfwb42vw2HI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aHZ4cGZyUjdHbElTckdLV1NRS3JMUGRXREtoVVpEV3R0UHc0d3M1MlFsOTZG?=
 =?utf-8?B?cktkaUwxSis0aVBVcytHcXJUdnBqRXQ3RVJPK2Vid0hQQndDdUtNUjN1OVRw?=
 =?utf-8?B?OFV2UUs0S1FCRnVvbXJGQmgzY1RPNEI5K2t4cjNjTTJudzRWekZWNWtaeklG?=
 =?utf-8?B?WlhWOWJtOGg5S2UzeU1FWXdramdzSXhYYXhWVDVOSDhlYnQrcHkzQnhaVW5R?=
 =?utf-8?B?VkV0OUp2TU53aTN1NUx1MmJrTGJTNElJTkdSa0tyb3ZZTEpuVFRIWDJqNkJs?=
 =?utf-8?B?b3VabjAyU1NoRGZQQmg4QkErUnZ0VGMyODc0VFRrMDRSQzcrK05CNjMwUU5m?=
 =?utf-8?B?U2s2U2g0blNPSFY0VndPWTBpelo3UTVkZTRjOHQ3citBSG52dUpFQURpeVNa?=
 =?utf-8?B?ZU1DeSt3ZE1zb3U2M1JLdXRlaVQxNE81aVpEcHlNaUhFajNucjl0MkdJVmtG?=
 =?utf-8?B?aWNzR2RuVzcveGdRbW8yU0t5YnZjTDV3S3pBclh6TGVYRGNabXN4VDc3dkNE?=
 =?utf-8?B?b2Y1U2FnQnFVVjJ4bHFpWGRSNVVycVNaS2VVZUt0amJ3Y1pGc20zUUk2MkJq?=
 =?utf-8?B?SXN3NG5BY3ZZdGsvUlF6bDJ6cnV3NmxHY1hmSkRUZGc3emdqNWdZd2ZTa0Y0?=
 =?utf-8?B?VUZDMWp4NXJLNW1HemU3Y01LYTJXcVJNdktndHc0dDhmM1VoaUVrQzRCZzQ5?=
 =?utf-8?B?WElBaVAwQnJmNGFPa05oS3JSMUdMT3FsL3RDdUU0UytLYWpqelUxOEkwNzJs?=
 =?utf-8?B?Qk9SdmZaQ2d1UG5lM0dWN3AwY3lUYS9zcm91UnFYbzZNbVpyc1pMTTZjSEVQ?=
 =?utf-8?B?QUhveng3TEpvS0xWby9xZ1YxelpFOWhzbSs4VlRZMWlsa0JuQ0ZDSWs2SWpZ?=
 =?utf-8?B?alhyeFNpcFZTdDBiNzk5NVpvK0t2U1gwWjhqZUJHNWxYRU1PWHVGajVob0NF?=
 =?utf-8?B?UXFDVDR6aGYyY2NEK2h3aWxteTZ2M1AvK1NaRk0xN0NBb2xCSHdKSmNEYlE4?=
 =?utf-8?B?bzZLVnk3RlU3UHVxOGNPaGcvNFh5NTE0R2tZV0pqTm5yQ1kxTjQrRnpWZ1JD?=
 =?utf-8?B?RHdDSEM0bStXRkxkUVNNTWROOEpUN1YxQjhSaEpIWGNUQkdydkpqQjJVQ1Nr?=
 =?utf-8?B?OXlqaE5GR0FnWGE5WHA2c1RsN0lFbkxOcENCOGl6OTlIMkw0KzlhV2hzaU5T?=
 =?utf-8?B?K3J3SmhBZllVT0pYV0Z0ZVBHNkZpYzlhakpXVkU4MStnUldhcThGMVhzUU9B?=
 =?utf-8?B?N3JJRWpLcDM5bkJGdkdoRVBuK1JOUzBQWGw1bUdCaVcybXlRZTI1SjZ1elFr?=
 =?utf-8?B?OFhMVTY4WVkrVko4L2xTSU55RVdrR2d1WXNIVVlGUkZteTg0Z2FFaCtHT0Uz?=
 =?utf-8?B?eWdCSG9FL2RiVFRTQjJxTVNvcGp2b0t2bm1zQmJ1Rkg1Wkx1T1VaQ3BxdmVS?=
 =?utf-8?B?dnlia3M1YXFONUs1S3MxSUJrL2xKdXlSbS9iRUxaODVzRmsydDJlWnp0UlBO?=
 =?utf-8?B?SjB0a2dIMjFIYzJLWnRjb0pZNFJmTk1ySFFpSThrd2w4blJMRXpydTEvSlhw?=
 =?utf-8?B?ektMdURxZUpEaVh6U0YreGhMVC93L1hHMTFndTRkMXFZWTdUWkZQS0VPMmtX?=
 =?utf-8?B?QXZQb1lrajVMSEdZM2RobVJIQ1B5TC9aWEdNY2NnTGYrbHZOa2lHc25ZaTZI?=
 =?utf-8?B?Z3R5TmFGYjhwOE1GbFZQU1dBRS85SU1keHNzRlkwb2tzZUM0U0hnUUJWR3d1?=
 =?utf-8?B?UVlHYWlQVWVENHVqaXFkZmFVOGxzYTJLUnZISjVISlkxMXFzWklDRThhcUdQ?=
 =?utf-8?B?SGlLSi84bjdacXl5WE9DanRTcmU2enV2U3BCVmt0cjVhald3TXlOb245dHlX?=
 =?utf-8?B?UUplZ21FYTIwK2UwN0s5dHBHTnFPdlk5VzFscnZTRWVVd1c5Q0hEZjhwa1E3?=
 =?utf-8?B?SFhQR25lcWdNYnMvRW0yKzVXTmNlemJza3ZiVURpa2JzQ0VxZVF1cFp0U3F3?=
 =?utf-8?B?NFowS2p3SFlWdEMyUmNoakMxdU5YZ2VNb2JDMlg4d2lrNS9ZVkhXQ1ZLM0tF?=
 =?utf-8?B?SzFRZ1B5RGlKV2lDYk4yYkp4SStHajBKeUpHSGdUTm0vV0VQQ2hxZE5RQzBC?=
 =?utf-8?B?ZEpqYWhPQTJFRmd0Z2x3NjR4ZnBaSXVDRWZwNC9seEk0Q2RDQ05kckhULzVY?=
 =?utf-8?B?aDAwOTVwWElaU3B5RjJDcHpXbWpNZHU4WTlUYlJXeHRpc2UzbVYyY3NYNWQv?=
 =?utf-8?B?bjUwM1MxdmpoMjVKZktrNjJjckN3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <25126F2658A8644CAF35E657E3B6CD99@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d344a800-d216-4e0b-b20e-08dc5a5b424e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2024 19:11:58.0701
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aN+0jcgM1L/PXwjRPG19OcnqPzpaT9krcMdQ8wqEsIknPVhOj5nJXHrQ5+d+pkiahupuY8GL/q0POWj+ujS4wQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR13MB5683

T24gRnJpLCAyMDI0LTAzLTA4IGF0IDEzOjAyIC0wNTAwLCB0cm9uZG15QGdtYWlsLmNvbSB3cm90
ZToNCj4gRnJvbTogVHJvbmQgTXlrbGVidXN0IDx0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2Uu
Y29tPg0KPiANCj4gV2hlbiBjcmVhdGluZyBhIGxpc3RlbmVyIHNvY2tldCB0byBiZSBoYW5kZWQg
dG8NCj4gL3Byb2MvZnMvbmZzZC9wb3J0bGlzdCwNCj4gd2UgY3VycmVudGx5IGxpbWl0IHRoZSBu
dW1iZXIgb2YgYmFja2xvZ2dlZCBjb25uZWN0aW9ucyB0byA2NC4gU2luY2UNCj4gdGhhdCB2YWx1
ZSB3YXMgY2hvc2VuIGluIDIwMDYsIHRoZSBzY2FsZSBhdCB3aGljaCBkYXRhIGNlbnRyZXMNCj4g
b3BlcmF0ZQ0KPiBoYXMgY2hhbmdlZCBzaWduaWZpY2FudGx5LiBHaXZlbiBhIG1vZGVybiBzZXJ2
ZXIgd2l0aCBtYW55IHRob3VzYW5kcw0KPiBvZg0KPiBjbGllbnRzLCBhIGxpbWl0IG9mIDY0IGNv
bm5lY3Rpb25zIGNhbiBjcmVhdGUgYm90dGxlbmVja3MsDQo+IHBhcnRpY3VsYXJseQ0KPiBhdCBh
dCBib290IHRpbWUuDQo+IExldCdzIHVzZSB0aGUgUE9TSVgtc2FuY3Rpb25lZCBtYXhpbXVtIHZh
bHVlIG9mIFNPTUFYQ09OTi4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFRyb25kIE15a2xlYnVzdCA8
dHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbT4NCj4gLS0tDQo+IHYyOiBVc2UgU09NQVhD
T05OIGluc3RlYWQgb2YgYSB2YWx1ZSBvZiAtMS4NCj4gDQo+IMKgdXRpbHMvbmZzZC9uZnNzdmMu
YyB8IDMgKystDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlv
bigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL3V0aWxzL25mc2QvbmZzc3ZjLmMgYi91dGlscy9uZnNk
L25mc3N2Yy5jDQo+IGluZGV4IDQ2NDUyZDk3MjQwNy4uOTY1MGNlY2VlOTg2IDEwMDY0NA0KPiAt
LS0gYS91dGlscy9uZnNkL25mc3N2Yy5jDQo+ICsrKyBiL3V0aWxzL25mc2QvbmZzc3ZjLmMNCj4g
QEAgLTIwNSw3ICsyMDUsOCBAQCBuZnNzdmNfc2V0ZmRzKGNvbnN0IHN0cnVjdCBhZGRyaW5mbyAq
aGludHMsIGNvbnN0DQo+IGNoYXIgKm5vZGUsIGNvbnN0IGNoYXIgKnBvcnQpDQo+IMKgCQkJcmMg
PSBlcnJubzsNCj4gwqAJCQlnb3RvIGVycm9yOw0KPiDCoAkJfQ0KPiAtCQlpZiAoYWRkci0+YWlf
cHJvdG9jb2wgPT0gSVBQUk9UT19UQ1AgJiYNCj4gbGlzdGVuKHNvY2tmZCwgNjQpKSB7DQo+ICsJ
CWlmIChhZGRyLT5haV9wcm90b2NvbCA9PSBJUFBST1RPX1RDUCAmJg0KPiArCQnCoMKgwqAgbGlz
dGVuKHNvY2tmZCwgU09NQVhDT05OKSkgew0KPiDCoAkJCXhsb2coTF9FUlJPUiwgInVuYWJsZSB0
byBjcmVhdGUgbGlzdGVuaW5nDQo+IHNvY2tldDogIg0KPiDCoAkJCQkiZXJybm8gJWQgKCVtKSIs
IGVycm5vKTsNCj4gwqAJCQlyYyA9IGVycm5vOw0KDQpQaW5nIG9uIHRoZSBhYm92ZS4NCg0KLS0g
DQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3Bh
Y2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=

