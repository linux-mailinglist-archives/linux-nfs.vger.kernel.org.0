Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D430185103
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2020 22:24:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727545AbgCMVX5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Mar 2020 17:23:57 -0400
Received: from mail-dm6nam11on2072.outbound.protection.outlook.com ([40.107.223.72]:6052
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727052AbgCMVXy (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 13 Mar 2020 17:23:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hClaUH73B0LHbupHNlqJS3bQxU+dbqqsR5dgTEVpaZ0kih94Dm6L+NRDRgTo++0PnsLhLPS1aBN09I1nwGoULVMzBGcZklapsudYICLh+wXBmzfaAlnBfIJrfNUKiu9bd/wkgKWhYpXEPGc/lbNVzs4Aas2YP048lzktumlqsCV4O7vK+E7y9nhSuYIEabKTVxNZNhAdezFHBoSo0BrsQfsyXtPJEw6E+uo7FrMfIqQ0fZO1nkPNm+FujK7ur7aTfYm4TRNZQRH+JBDK/eehEaB48WDp34VtwIQmnKVtOLJh6lprLkHkY7nwOm83d7OQ0C36eyHF1hrXGN9XtFQnuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OupXjqReRfSnc5tVGkNPnNXuYNA48xdwLUH6+K3Pvsc=;
 b=SScJQZ4MtjJSPOHQDrL4pvk6wkNNIHwvbepviwBqVfWAHtbVAzgK6YA2k9+UHw9K+tgczXLlHPhoeATr37QN6UQ1x32QDIvoREIhug8Mm16DPglH8ZvPLfM5sv5FUg8y/1mdopaTXvrWn4COvmZOZqANBTKLyeEy3Knjj84NQVddX4UyPaGpxx29MAp/Ox5COhO8NB13DryqiHZ1+MJ603XwaHxeobFodGdNySThq2pR0Ihpt+Qe9FL/CvPJmmYILaQ5MOvbo0o8Viz4oW56ygyZb08lnHfRKYMvpjS3XYnkJzqq/emm4ynzOY8lrfGr2Cc0UHNCblD4NIxP+0nWuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netapp.com; dmarc=pass action=none header.from=netapp.com;
 dkim=pass header.d=netapp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=netapp.onmicrosoft.com; s=selector1-netapp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OupXjqReRfSnc5tVGkNPnNXuYNA48xdwLUH6+K3Pvsc=;
 b=gD//Dyy+I5SpEnb/Z/XfU7g6rdmiK/G1LgYaPogMumjOwmHk1xMA9aJqhPtXJsaUrrHypsOdIdmJbbn+J3rpInjr80/iobwQGuAvIFKv5ytNIqO6jRuqh0ej7i/EUDuBrZdrZABhKsHM0alljB2oHuorEzmN+Mxxavgv4BvIdTo=
Received: from DM6PR06MB6617.namprd06.prod.outlook.com (2603:10b6:5:25f::14)
 by DM6PR06MB5867.namprd06.prod.outlook.com (2603:10b6:5:1ad::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.15; Fri, 13 Mar
 2020 21:23:52 +0000
Received: from DM6PR06MB6617.namprd06.prod.outlook.com
 ([fe80::f1d5:1417:3acd:c3be]) by DM6PR06MB6617.namprd06.prod.outlook.com
 ([fe80::f1d5:1417:3acd:c3be%6]) with mapi id 15.20.2793.018; Fri, 13 Mar 2020
 21:23:52 +0000
From:   "Schumaker, Anna" <Anna.Schumaker@netapp.com>
To:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Please pull NFS Client fixes for 5.6-rc6
Thread-Topic: [GIT PULL] Please pull NFS Client fixes for 5.6-rc6
Thread-Index: AQHV+X2xvtPTlyiGnESyhrHKya0f4A==
Date:   Fri, 13 Mar 2020 21:23:52 +0000
Message-ID: <301a18ca0151b97f54ff6f67b4d32afed696459b.camel@netapp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.0 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anna.Schumaker@netapp.com; 
x-originating-ip: [68.32.74.190]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 02a3e18b-d5a1-47ec-0854-08d7c794d41e
x-ms-traffictypediagnostic: DM6PR06MB5867:
x-microsoft-antispam-prvs: <DM6PR06MB5867FEB2E934C9AA9FC50988F8FA0@DM6PR06MB5867.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1186;
x-forefront-prvs: 034119E4F6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(366004)(376002)(346002)(136003)(396003)(199004)(86362001)(186003)(66446008)(4326008)(6486002)(76116006)(66556008)(64756008)(66476007)(478600001)(66946007)(5660300002)(91956017)(8936002)(81166006)(26005)(71200400001)(6506007)(8676002)(316002)(6916009)(2616005)(81156014)(2906002)(54906003)(36756003)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR06MB5867;H:DM6PR06MB6617.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: netapp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dSNS7eBz7knXoAlf99dsGgsrSGkU3ateSxeFLjBPhouBpIaUjnnPSFc9Ite+cDoU9tLO2q7+fr4P7KZjLGBpISCOTs39P9y7sFyl7Mpj27BI3gK9oz8M/jnSBzUhSN+9QY+G6puziWpN3NU576oE6ZEnPZV/BWiFRdhO6JaUCuGIqnwImkmegMcICLX3xJQ6w7wqKUAJkWVr7a3qwt/hIOAxixn8fzrBZwQP8iHBY6Q6uxSRBjAo9wxXjxfQH+NJvZqKBqAPcz9UtF4ybXo/YjnCE7rBQOuTE42qUSe7RlCbrt9C7JOeWFGqJZ1K0uB3o8U2gxlGLTYBlKuA+eiTO0jXRE8D6Pq6HBsn/QE1UzFpEFsV37nYh8deJdXm2d7JnG34OFhmiucBTm9dVztwqbjYMzP2Pgu64x5nG+QqrhJFnzqHUl+EE/ZdCHklHYDz
x-ms-exchange-antispam-messagedata: ThHKrHmyrhbPe4jzfOH7tTesRKKb2ueusK9gchL9pHM/H4XIyUPFKv0KnCkKtooy1N5+8er8Xr6yFwY9hiEyGM/dAp46+LwRPVP3kv0pbQdk6jdl3hR06cTDLitX32QjMxnDZ21Y3WxDmUtTKkYwiA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <E12D15A1EF2F7245A85596C2BA2FF2CC@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02a3e18b-d5a1-47ec-0854-08d7c794d41e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2020 21:23:52.2825
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nC42lJB0YQ7SEEo48YPSu/F6NAvDhuGuHHGUptgfgApfMuWD/iWH5/fLhaZavKOsP3Wqp13zk3edBMOwx3qLlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR06MB5867
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

SGkgTGludXMsDQoNClRoZSBmb2xsb3dpbmcgY2hhbmdlcyBzaW5jZSBjb21taXQgNWQ2Mzk0NGY4
MjA2YTgwNjM2YWU4Y2I0YjkxMDdkM2I0OWY0M2QzNzoNCg0KICBORlN2NDogRW5zdXJlIHRoZSBk
ZWxlZ2F0aW9uIGNyZWQgaXMgcGlubmVkIHdoZW4gd2UgY2FsbCBkZWxlZ3JldHVybiAoMjAyMC0w
Mi0NCjEzIDE2OjIzOjAyIC0wNTAwKQ0KDQphcmUgYXZhaWxhYmxlIGluIHRoZSBHaXQgcmVwb3Np
dG9yeSBhdDoNCg0KICBnaXQ6Ly9naXQubGludXgtbmZzLm9yZy9wcm9qZWN0cy9hbm5hL2xpbnV4
LW5mcy5naXQgdGFncy9uZnMtZm9yLTUuNi0zDQoNCmZvciB5b3UgdG8gZmV0Y2ggY2hhbmdlcyB1
cCB0byA1NWRlZTFiYzBkNzI4NzdiOTk4MDVlNDJlMDIwNTA4N2U5OGI5ZWRkOg0KDQogIG5mczog
YWRkIG1pbm9yIHZlcnNpb24gdG8gbmZzX3NlcnZlcl9rZXkgZm9yIGZzY2FjaGUgKDIwMjAtMDIt
MjUgMTM6NTM6MjQNCi0wNTAwKQ0KDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpUaGVzZSBhcmUgbW9zdGx5IGZzY29udGV4
dCBmaXhlcywgYnV0IHRoZXJlIGlzIGFsc28gb25lIHRoYXQgZml4ZXMgY29sbGlzaW9ucw0Kc2Vl
biBpbiBmc2NhY2hlLg0KDQpUaGFua3MsDQpBbm5hDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQoNClNjb3R0IE1heWhldyAo
NCk6DQogICAgICBORlM6IEVuc3VyZSB0aGUgZnNfY29udGV4dCBoYXMgdGhlIGNvcnJlY3QgZnNf
dHlwZSBiZWZvcmUgbW91bnRpbmcNCiAgICAgIE5GUzogRG9uJ3QgaGFyZC1jb2RlIHRoZSBmc190
eXBlIHdoZW4gc3VibW91bnRpbmcNCiAgICAgIE5GUzogRml4IGxlYWsgb2YgY3R4LT5uZnNfc2Vy
dmVyLmhvc3RuYW1lDQogICAgICBuZnM6IGFkZCBtaW5vciB2ZXJzaW9uIHRvIG5mc19zZXJ2ZXJf
a2V5IGZvciBmc2NhY2hlDQoNCiBmcy9uZnMvY2xpZW50LmMgICAgIHwgMSArDQogZnMvbmZzL2Zz
X2NvbnRleHQuYyB8IDkgKysrKysrKysrDQogZnMvbmZzL2ZzY2FjaGUuYyAgICB8IDIgKysNCiBm
cy9uZnMvbmFtZXNwYWNlLmMgIHwgMiArLQ0KIGZzL25mcy9uZnM0Y2xpZW50LmMgfCAxIC0NCiA1
IGZpbGVzIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo=
