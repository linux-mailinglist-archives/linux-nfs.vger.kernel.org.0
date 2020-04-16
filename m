Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 478441AD32B
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Apr 2020 01:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725805AbgDPXaw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 16 Apr 2020 19:30:52 -0400
Received: from mail-eopbgr700130.outbound.protection.outlook.com ([40.107.70.130]:7041
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725770AbgDPXav (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 16 Apr 2020 19:30:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=naL2U0/ClywqvuhZacYg5gPEA+NRbKKTnoLZLGwX4Pak33y6gQVuurxO3Xb25FVl/9fTJBPXxURqgp3uUO4c/s/7K4bARxqaARjPKWSk/XEwJc6Zg+U75+xMvhuNc2FJjhKCX7qRrhmUWGFVja7TuNomuAlxzna8aszJ+1NeVXYfPh+jB/XTN21l7y3PtCRtqt5WvqcdRYQ53VtTmo0vHfKR+Nuh8B76+Yi45J7K+iiYQXohe6reEbZvW8eTZ0iLs3FPefC77xn58U+Eufy0/8Anx1jD9XkYi42QAXg5MEXIuoH2o2UoeIx9h2UDSNPrsThxXCL37etfwBb7mwdHjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=afV9f+mTC8QeJ7RoyIalj9hcmmTN5SJTVvnSjn+7nI0=;
 b=H1e98sJI/Ov2JKztNvnDmcOHiSCen0zWtk8fct412Ss4zr9XzJzQpenEu/xTUfvH4HIL0z5T0RPqCPIrNmZHnEDl8rKLf1+JnyfdcPueZDAGdMmDTCKDXviOXaJcVWal5km30M5+D/R50RieWvXA39OQxrEA5VdWur044TpuEc81HD1z1GbPTa0eGNmyuL2oMwxCCKw354Gzu6RQFVNKqprJuDHVOQKPNCXvumBXtZu2OhaLMckClfEIU71UeK99wmfY8FeUg8NwlsydG/Vult2aIL8NdkkkzBSTOLlLt9eW4bhskgtHUlxrCmyIDG95Ae4DKHVDQpM503pXZjENuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=afV9f+mTC8QeJ7RoyIalj9hcmmTN5SJTVvnSjn+7nI0=;
 b=Sc8Q9wvKc+ikmDP9xpmFaHqYlRQgteu77gDYKm2qefMPwQa/e0EQ4H2mlOYfkzH6oOCxCbhbyZF8Pkzwt1Jx3MMwUqLDSxnCt5YjV87wIBEycOHfcGvCXyhylaz8bgNINBHinivlbH3ePnYZLfbwRSFT40eDc2sljPcyiZCtzP4=
Received: from CH2PR13MB3398.namprd13.prod.outlook.com (2603:10b6:610:2a::33)
 by CH2PR13MB3527.namprd13.prod.outlook.com (2603:10b6:610:29::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.6; Thu, 16 Apr
 2020 23:30:49 +0000
Received: from CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::49f6:ce9b:9803:2493]) by CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::49f6:ce9b:9803:2493%6]) with mapi id 15.20.2937.007; Thu, 16 Apr 2020
 23:30:49 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] Please pull another NFS client bugfix
Thread-Topic: [GIT PULL] Please pull another NFS client bugfix
Thread-Index: AQHWFEav9k7H+BHYw02oEswjsl2GTah8ZY+A
Date:   Thu, 16 Apr 2020 23:30:48 +0000
Message-ID: <e2f62ab02037ca4ab2f72081851d3e0d0c521e77.camel@hammerspace.com>
References: <74a2fbfca03c6150c0a88e915109babbc45b9e08.camel@hammerspace.com>
In-Reply-To: <74a2fbfca03c6150c0a88e915109babbc45b9e08.camel@hammerspace.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6e453b20-9385-47bf-1dd4-08d7e25e3218
x-ms-traffictypediagnostic: CH2PR13MB3527:
x-microsoft-antispam-prvs: <CH2PR13MB3527EB297F6EF62BDACDAFF7B8D80@CH2PR13MB3527.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:873;
x-forefront-prvs: 0375972289
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB3398.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39830400003)(396003)(366004)(136003)(376002)(346002)(54906003)(316002)(91956017)(186003)(2906002)(26005)(76116006)(6506007)(36756003)(8676002)(81156014)(8936002)(2616005)(4326008)(5660300002)(478600001)(6512007)(6916009)(6486002)(86362001)(71200400001)(66946007)(66476007)(66556008)(64756008)(66446008);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t+X5Imti3JcVDWGVWbLV2HU2rtWB/vTpODiUfF1tqwzg04OEy1FrXmzPtm6onLNyoogTzRqShaFBBIctKNShddhaa5Q+ftR8EFcyBUWWNxEpd5m/g1Y1gDHOcBfLz6eM3AGDSfZKAOt9H+AB89bUX6Q2wAqSdWhwDTex/j/amtydKiSKVY/YR6KEoC3Ft2bJG31nyhZKvNebbSy6uIX5gohOwFDFnUfMgCyFoMwtVgIgMQyxHTsqxGAzihlcJsBckp1gzgjj4kKgBc1OG+BOIELYwtgllM9azGrdTmzEhu29evBx3xdVFMs82yc6fSco7Fypww4a1dYF10pZmcuuqKL5KTHjroa9PIUQsaNUG4sMxryZICTpKlSJwso9B6HtpciPeoekCTQmA2YJrw7q+iOFlBZYPhp5c5I8YjPeluEPx+e5umCAbN1R5xjJwxk7
x-ms-exchange-antispam-messagedata: UH3xIBZkoU6iHpn2PquxSeWF+mayyom6gdHnP1P0/8YzYoHQLR9Dn/FB/8VfSIA1pJheKYq3g6ioPt/MRAOSi4hcyPUFwe4Zs2wn7jm1CqMXgxWij9B+H5m3OAIGWtkqVnZd+S3KPOMODneNyL5N5Q==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <7B002E6C9E220E42ABE38D3D4C464679@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e453b20-9385-47bf-1dd4-08d7e25e3218
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2020 23:30:48.9829
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gnGTtJ/PjFw5ml6kScT8rTgoIEvKAwgVKuaww0XLQ9EYeKfltEZR88wEeEmv/0wkvEG39cw/P4buysUU6pHPEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3527
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDIwLTA0LTE2IGF0IDE5OjI4IC0wNDAwLCBUcm9uZCBNeWtsZWJ1c3Qgd3JvdGU6
DQo+IEhpIExpbnVzLA0KPiANCj4gVGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdA0K
PiA4ZjNkOWYzNTQyODY3NDVjNzUxMzc0ZjVmMWZjYWZlZTZiM2YzMTM2Og0KPiANCj4gICBMaW51
eCA1LjctcmMxICgyMDIwLTA0LTEyIDEyOjM1OjU1IC0wNzAwKQ0KPiANCj4gYXJlIGF2YWlsYWJs
ZSBpbiB0aGUgR2l0IHJlcG9zaXRvcnkgYXQ6DQo+IA0KPiAgIGdpdDovL2dpdC5saW51eC1uZnMu
b3JnL3Byb2plY3RzL3Ryb25kbXkvbGludXgtbmZzLmdpdCB0YWdzL25mcy0NCj4gZm9yLTUuNy0z
DQo+IA0KPiBmb3IgeW91IHRvIGZldGNoIGNoYW5nZXMgdXAgdG8NCj4gZmJmNGJjYzlhODM3MzEy
Mjg4MTkwOTMzMWYyZjk1NjZhMTI4MTI2ZToNCj4gDQo+ICAgTkZTOiBGaXggYW4gQUJCQSBzcGlu
bG9jayBpc3N1ZSBpbiBwbmZzX3VwZGF0ZV9sYXlvdXQoKSAoMjAyMC0wNC0xMyANCj4gMTU6NTU6
MjEgLTA0MDApDQo+IA0KPiBUaGFua3MNCj4gICBUcm9uZA0KPiANCj4gLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiBORlMg
Y2xpZW50IGJ1Z2ZpeCBmb3IgTGludXggNS43DQo+IA0KPiBCdWdmaXg6DQo+IC0gRml4IGFuIEFC
QkEgc3BpbmxvY2sgaXNzdWUgaW4gcG5mc191cGRhdGVfbGF5b3V0KCkNCj4gDQo+IC0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0N
Cj4gVHJvbmQgTXlrbGVidXN0ICgxKToNCj4gICAgICAgTkZTOiBGaXggYW4gQUJCQSBzcGlubG9j
ayBpc3N1ZSBpbiBwbmZzX3VwZGF0ZV9sYXlvdXQoKQ0KPiANCj4gIGZzL25mcy9wbmZzLmMgfCAz
ICsrLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0K
DQpTb3JyeSBhYm91dCB0aGUgZHVwLCBMaW51cy4gSSBpbmFkdmVydGVudGx5IGhpdCAnc2VuZCcg
YmVmb3JlIEkgaGFkDQphZGRlZCB0aGUgdXN1YWwgQ2NzLi4uDQoNCi0tIA0KVHJvbmQgTXlrbGVi
dXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWts
ZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
