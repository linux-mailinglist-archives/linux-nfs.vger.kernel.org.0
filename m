Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63E6F3B2FDA
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Jun 2021 15:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbhFXNQM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 24 Jun 2021 09:16:12 -0400
Received: from mail-dm3nam07on2128.outbound.protection.outlook.com ([40.107.95.128]:4321
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231157AbhFXNQM (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 24 Jun 2021 09:16:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kCAf9u9SAw+1Id78TNBnH0U1hGxO7t5UXRVdrpWjRlbKIg1s9dV0gSz86OfKAb0Mv3oVaTANpjiyrhlXxjpJfHXea3k/WFVxJvZuoANESjyn20re/ra//3XyLZ4bnFsO7msMNjeYMj2uJUGFtBL5QxoJc+KHX0XjBWDiF57x1Cit8LEFMAzxPLsQYoGIHui+TL4mJ2S218ZvUiIaTeRonTHCSLQBXF3yZJUPB9sLrwL5WZ/BxTXUfMS5W5AfQNvsUrD6/UfzS8p3I9/d2tzN6JiFGAes6Jv8Fd8cOQRONY3m6t1ZUlS8lrcVLAqeVthoBcqk8Hcv0aaF7rFheg+XkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B9p9+jVkA1+uTYju0JHIvaNvV0Dl857Pel1F+Tt5bo0=;
 b=cu9eCe1g96jBu2vrvmHNZT+ei72Raf4lVD9sGmeNKDEwPYOAyYOCgl7ErPKpmZb/JxQJ7HIa3seOPoPYogHra8avISAGp7yNyKo7dCBwF2/t0f0gb+D/p+UuYSo1pyrEQ4jja3OnIChvcoCCeH3qtMh36tSZtF1mWq5zhHpv4a0O7HtPSg3cWbLn73fqZaSO+xFXFqWOQPuvQjQ52UdnawHXQTNIgccw0UTTg1RbWjijbyM6d6rVglAT4aR+SzlceQI/NiOk7WMj0N8w9r3D4HRRFmtIk+TMkgmhPka0IRDJ0GD39G3iiGKcbrGezUxw2SNhsoDKzS432scIT4UZgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B9p9+jVkA1+uTYju0JHIvaNvV0Dl857Pel1F+Tt5bo0=;
 b=DarBl9JfIUkrL+/tdnMWoNNekRa7hGW8aIHPFEpMc90otNZtNsDsnHlpjc2KWZFBh2cHlMiIKKiYOzXaOMIeYB8GxQC+5RbtzreEdJCXpctXrN1t+S3dhxQF+HLWDbdMtHND5HgOh4/WvuGQsN7iow2zz1OsKQFzZDnBzxw3XuM=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH2PR13MB4457.namprd13.prod.outlook.com (2603:10b6:610:6e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.7; Thu, 24 Jun
 2021 13:13:51 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::cc40:f406:86f9:3e05]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::cc40:f406:86f9:3e05%4]) with mapi id 15.20.4264.021; Thu, 24 Jun 2021
 13:13:50 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "hsiangkao@linux.alibaba.com" <hsiangkao@linux.alibaba.com>
CC:     "joseph.qi@linux.alibaba.com" <joseph.qi@linux.alibaba.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "agruenba@redhat.com" <agruenba@redhat.com>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Subject: Re: [PATCH v2 2/2] nfs: NFSv3: fix SGID bit dropped when inheriting
 ACLs
Thread-Topic: [PATCH v2 2/2] nfs: NFSv3: fix SGID bit dropped when inheriting
 ACLs
Thread-Index: AQHXZ/p9JKsZgIWR+Emv3Y4NX21acasjJZWA
Date:   Thu, 24 Jun 2021 13:13:50 +0000
Message-ID: <26c10bd670d4a4672470baf2c30db7af7b7aa593.camel@hammerspace.com>
References: <1624430335-10322-1-git-send-email-hsiangkao@linux.alibaba.com>
         <1624430335-10322-2-git-send-email-hsiangkao@linux.alibaba.com>
In-Reply-To: <1624430335-10322-2-git-send-email-hsiangkao@linux.alibaba.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dd4ac13f-c242-40ee-8693-08d93711e8ca
x-ms-traffictypediagnostic: CH2PR13MB4457:
x-microsoft-antispam-prvs: <CH2PR13MB44570071C67424F4E33CEC63B8079@CH2PR13MB4457.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lC+esyNA5wbmd/Pl09m4kPx5WKBXkjf1oXIeawJyZ2T8e/JA8AW/Fbp4iFPSt7cEahPStRdRYUJmRYEAXt3W557sU1UR4dEMdB2xep0i922qejAYDjkx6KbOzWqv7kjJwn0j42IEh6MXQaPWnCZvaf0em96mtfpKaDPOwuO3Js+K4BuskW02NNRNnnYrj2iJoq2qpQh070UFddnd73YEs4lDuLlXOv+xFnYFW1uwpaUd1As1iknX95QeqZouVt0qJ2gvqXX6Flm9+D8W005dOOHbCw9uiZy53fcYMpSxjFgRi4CrxSJGQ277nuBpIPaMa+JZMQk4GcZgQhIvAjNiSRpoR//Zh6cnFC8C+Ee/l8hr4nU9p+2n5VU9Lml8oPWgPJ5o1NhdqF6D6o0/khAgmwnO1LvDfiFX5qIa2LGrrSb1b5oiOLhnT0TKm4+gQjx31zwHrt3GljnkB+bGOzVrrtqFFHODfEm9ygxk3IRrPr8zs3FDviL5ld7sLudiLRM61ld4WubgbrQx788sy8fP1VB0mZDdeWLIoqll5sfecSecYIxtQzfJmym7HZu+NqkWHAfPwqt/fN6GyrBq+ZFZphIO5X7KimCUwyxO8Lq1yXA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(346002)(376002)(2616005)(6506007)(5660300002)(26005)(2906002)(76116006)(64756008)(66556008)(66446008)(186003)(66946007)(66476007)(508600001)(122000001)(38100700002)(4326008)(86362001)(8676002)(36756003)(71200400001)(54906003)(6486002)(8936002)(110136005)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZTdjY0RSWWRaYi9VM0Q4ejl0VFA1UEpFQlhiNGJhaHpxaVFTaDNkZlE1aFdw?=
 =?utf-8?B?dUpvSXZuTVpVckRXalppK2RzbWNkcVpET0NFcWtPSnBkQXgwUWVVR3JhT0tn?=
 =?utf-8?B?aTZDY0NpZlR2TSsyeUIwdEdCYmxHRElYUTFnRUJFcU1lbDFLMU1zZEtqajNN?=
 =?utf-8?B?b1lLcE5lNk5vQUNPRUFBNysxY0tGRFM1UENaZ3ZBU1NUUW9DVGlVS2VoY1Jt?=
 =?utf-8?B?SFRPL1dXejU0NXpOL2o4eFpMSVZ4UFQzMnNvQ054YXY3MmhYV0VWUU4rRksv?=
 =?utf-8?B?Qjl5L2VjcVBxNm5FY1FwZG1nMEJhQ2FqNzN0QzVOcmVOME1qbVNkTFlOL2ZK?=
 =?utf-8?B?ZURSRW9jd2d6MC9nRzNpclBmR2Y2azJXVG9MS3A5Z2R5dFNwMWQzaXpQT3c5?=
 =?utf-8?B?Z2FBcXlEQ1UyWnFUWUNUaTltdVhuWGNZakExVi9oK015dmhTUXcyS0YzQ3d6?=
 =?utf-8?B?TWNpTGJvSGpVOHJtYzdNNk51WjlQZURkNldBbmRPK3BCY1crUFNKNE5LSDhU?=
 =?utf-8?B?cUY4WVhucER0bmtlcm4vZlpSc0FNK3F3eXlDV0FaUzNWMVd1VnlSdlZ1SGQ4?=
 =?utf-8?B?dElTMWhFK3RWdVdaR1l5cEVqbUEweXBjd1d2aG8xY0hEeTZYM3dsd1Iwbkhl?=
 =?utf-8?B?U3V6dkd1Vnl1RXhXamlxamRhalRvM1U1dVZkOWVxVDJ3aDNNOU5qVUk3WkZN?=
 =?utf-8?B?RVhhdC80Zy92cDlFdzVUaDlpMkdjUnNWL3pzSndnWmxOTjdGOEQxTjNTTnZI?=
 =?utf-8?B?QlNVZHFNMUM2VnlncmZacEkzSVdnaXByUmg1Wnk2TWc3eC9GM09GeTMyR3cw?=
 =?utf-8?B?RWZ1SldTT2tqK1ZIakJVVU1JVFpWT2FtYlF0RlhpZ2srWXVDWW8vOVVhTUpH?=
 =?utf-8?B?Zk54Y21kSXU4R2JidjFEVlBvekptcnd4TW4vbHlTdG9MeitaQnZZVHF2OTFj?=
 =?utf-8?B?bkUrVk9hU1BOTzk3T3BLTEhtY1p0WHdzS25COW42UzRtbUk0ZzVkUlhZUWhs?=
 =?utf-8?B?a0JlUjMvWkpkaFlJZFBobFZ6bEo1UDZ6YU9RNFdGeEx0eGRuMDdpTmduR3NI?=
 =?utf-8?B?cFZBUy9XTC9wSGI1WVlQRDY2Q2MyOXNkUTFPT3R3ZGNwcEpYM09pR3BjZGta?=
 =?utf-8?B?NDZyWk1mbHcxS2x2UklqelAvbHhidzl0S0ppa013NGIzREdUdE5BS1FKZks2?=
 =?utf-8?B?S3drVlpETkI3UEJneTVDNDhST05jMS9wS0FlRDRISEtFZEhMYVYrbFlYQ0lm?=
 =?utf-8?B?SkhqeGdBRGtwRmRnTDN3OExUR2s4RVFBbGZBOW1od3RYcGNMNDVlR2ZGVlk5?=
 =?utf-8?B?Q1hmMGpUYmIvWElqNFA5anJ5blpJNlp5OFUxNlY0L3RwRXBwNjl4WktvV1lq?=
 =?utf-8?B?aFBZdXd2a3hvQkU1TW9BVi8zYnZyTWhzb0lxOFUwYXZNdWdNRUNvZ2trUDFZ?=
 =?utf-8?B?VUx0OG5iZ2cxcTR3bytWQzRoODJKb0JLdk85cWhmUElPNmo1YnhzQkdUTUd2?=
 =?utf-8?B?MlVmUXdlNHZsMmt0aCtJUzBoN3dxRGoxWXpTcU5JbzhwQWd5QmZQRi9RSkdP?=
 =?utf-8?B?M2xpZzF6emNnV1lBOWwyOHFtWDMzNkhsWFI0c0diSmYyYWFSYldnM3Z3cHpa?=
 =?utf-8?B?NWRLWE1jYi9ETlBkUXlNb3d6QjgwQVlQdG9EdVh2UEttcmU3WGxUZUdQcWJs?=
 =?utf-8?B?K2xTSDZubHhPY1pJdXl0S1RBendMaHZ2dm9NWWZUdjVvcU9MbkFyN2JaZFk1?=
 =?utf-8?Q?RGeQtUcZw/BJMxswqt3qg4kla3pZ60nkjMrLgQr?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <DDEE3B178C6C9D498B1565D8891EC16D@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd4ac13f-c242-40ee-8693-08d93711e8ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2021 13:13:50.8198
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RmrDc+fZQn5K2ZiCkr3dB2WOffR++GR7MtWFq94CCQq4IhEstY4KGyXFFL7gLuFHO3RqMfgfOdtgV6ZyYOrTEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB4457
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDIxLTA2LTIzIGF0IDE0OjM4ICswODAwLCBHYW8gWGlhbmcgd3JvdGU6DQo+IGdl
bmVyaWMvNDQ0IGZhaWxzIHdpdGggTkZTdjMgYXMgc2hvd24gYWJvdmUsICINCj4gwqDCoMKgwqAg
UUEgb3V0cHV0IGNyZWF0ZWQgYnkgNDQ0DQo+IMKgwqDCoMKgIGRyd3hyd3NyLXgNCj4gwqDCoMKg
IC1kcnd4cndzci14DQo+IMKgwqDCoCArZHJ3eHJ3eHIteA0KPiAiLCB3aGljaCB0ZXN0cyAiU0dJ
RCBpbmhlcml0YW5jZSB3aXRoIGRlZmF1bHQgQUNMcyIgZnMgcmVncmVzc2lvbg0KPiBhbmQgbG9v
a3MgYWZ0ZXIgdGhlIGZvbGxvd2luZyBjb21taXRzOg0KPiANCj4gYTNiYjJkNTU4NzUyICgiZXh0
NDogRG9uJ3QgY2xlYXIgU0dJRCB3aGVuIGluaGVyaXRpbmcgQUNMcyIpDQo+IDA3MzkzMTAxN2I0
OSAoInBvc2l4X2FjbDogQ2xlYXIgU0dJRCBiaXQgd2hlbiBzZXR0aW5nIGZpbGUNCj4gcGVybWlz
c2lvbnMiKQ0KPiANCj4gY29tbWl0IDA1NWZmYmVhMDU5NiAoIltQQVRDSF0gTkZTOiBGaXggaGFu
ZGxpbmcgb2YgdGhlIHVtYXNrIHdoZW4NCj4gYW4gTkZTdjMgZGVmYXVsdCBhY2wgaXMgcHJlc2Vu
dC4iKSBzZXRzIGFjbHMgZXhwbGljaXRseSB3aGVuDQo+IHdoZW4gZmlsZXMgYXJlIGNyZWF0ZWQg
aW4gYSBkaXJlY3RvcnkgdGhhdCBoYXMgYSBkZWZhdWx0IEFDTC4NCj4gSG93ZXZlciwgYWZ0ZXIg
Y29tbWl0IGEzYmIyZDU1ODc1MiBhbmQgMDczOTMxMDE3YjQ5LCBTR0lEIGNhbiBiZQ0KPiBkcm9w
cGVkIGlmIHVzZXIgaXMgbm90IG1lbWJlciBvZiB0aGUgb3duaW5nIGdyb3VwIHdpdGgNCj4gc2V0
X3Bvc2l4X2FjbCgpIGNhbGxlZC4NCj4gDQo+IFNpbmNlIHVuZGVybGF5ZnMgd2lsbCBoYW5kbGUg
QUNMIGluaGVyaXRhbmNlIHdoZW4gY3JlYXRpbmcNCj4gZmlsZXMgaW4gYSBkaXJlY3RvcnkgdGhh
dCBoYXMgdGhlIGRlZmF1bHQgQUNMIGFuZCB0aGUgdW1hc2sgaXMNCj4gc3VwcG9zZWQgdG8gYmUg
aWdub3JlZCBmb3Igc3VjaCBjYXNlLiBUaGVyZWZvcmUsIEkgdGhpbmsgbm8gbmVlZA0KPiB0byBz
ZXQgYWNscyBleHBsaWNpdGx5ICh0byBhdm9pZCBTR0lEIGJpdCBjbGVhcmVkKSBidXQgb25seSBh
cHBseQ0KPiBjbGllbnQgdW1hc2sgaWYgdGhlIGRlZmF1bHQgQUNMIG9mIHRoZSBwYXJlbnQgZGly
ZWN0b3J5IGRvZXNuJ3QNCj4gZXhpc3QuDQoNCkhtbS4uLiBIYXMgdGhpcyBwYXRjaCBiZWVuIHRl
c3RlZCB3aXRoIGEgU29sYXJpcyBzZXJ2ZXI/IFlvdXIgYXNzZXJ0aW9uDQphYm92ZSBhcHBlYXJz
IHRvIGJlIHRydWUgZm9yIExpbnV4IHNlcnZlcnMsIGJ1dCB0aGlzIGNvZGUgbmVlZHMgdG8NCmlu
dGVyb3BlcmF0ZSB3aXRoIG5vbi1MaW51eCBkcmFmdCBwb3NpeCBhY2wgY29tcGF0aWJsZSBzZXJ2
ZXJzIHRvby4NCg0KSSd2ZSBhbHJlYWR5IHRha2VuIHRoZSBvdGhlciBwYXRjaCBpbiB0aGlzIHNl
cmllcywgc2luY2UgdGhhdCBvbmUNCmFwcGVhcnMgY29ycmVjdCwgYW5kIGRvZXNuJ3QgaGF2ZSBh
bnkgaW50ZXJvcGVyYWJpbGl0eSBjb25zZXF1ZW5jZXMuDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0
DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1
c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
