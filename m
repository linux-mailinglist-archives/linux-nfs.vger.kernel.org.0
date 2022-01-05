Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD533485562
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Jan 2022 16:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241199AbiAEPF6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 5 Jan 2022 10:05:58 -0500
Received: from mail-os0jpn01on2105.outbound.protection.outlook.com ([40.107.113.105]:10503
        "EHLO JPN01-OS0-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241393AbiAEPFY (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 5 Jan 2022 10:05:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kNvXKxrv5WrsKnMtyEt4onO5TWZspuEI0r1uNkPprQk=;
 b=K8dN2NvHOhF5U1lLpppu8BSFnG3FDKImWBh3V2XLCSlVDOMJlLVozR2SVoCD0/ivD3kdVeYXy85QouISK+zopD4m4hsK4iUpCI1hGgaQmn8vq8qWbFe1j0k3dUEnHi8c9QzRXF7ToADJLXMhDNhCKqlmnL2Dq+Ngehria0XpvaU=
Received: from TY2PR0101CA0029.apcprd01.prod.exchangelabs.com
 (2603:1096:404:8000::15) by OSAPR01MB2116.jpnprd01.prod.outlook.com
 (2603:1096:603:17::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Wed, 5 Jan
 2022 15:05:22 +0000
Received: from OS0JPN01FT012.eop-JPN01.prod.protection.outlook.com
 (2603:1096:404:8000:cafe::25) by TY2PR0101CA0029.outlook.office365.com
 (2603:1096:404:8000::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7 via Frontend
 Transport; Wed, 5 Jan 2022 15:05:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.101.26.97)
 smtp.mailfrom=renesas.com; dkim=fail (signature did not verify)
 header.d=dialogsemiconductor.onmicrosoft.com;dmarc=pass action=none
 header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 20.101.26.97 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.101.26.97; helo=mailrelay4.diasemi.com;
Received: from mailrelay4.diasemi.com (20.101.26.97) by
 OS0JPN01FT012.mail.protection.outlook.com (10.13.140.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4867.9 via Frontend Transport; Wed, 5 Jan 2022 15:05:20 +0000
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (104.47.1.53) by
 AZSRVEX-EDGE1V.diasemi.com (10.6.15.4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2044.4; Wed, 5 Jan 2022 15:05:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XK0KtE7d08V8fJF/C/uWfG9p6W1QJtEV87tNzFiNQ9muu7p3SwdaVzOdi6fSiqiQvKwp9sKAkyR5WH0ypkeY1f3gLiMwV2koFMqqNLGBWnchvJja5gbnKdB+7JEEidmSEmXmCXxYQAJXcOe7oLWfT25kmcagbOjX/+FTlkfG4z9/Y7je59RHtA2VJLxyUoT/QTyoWgOW/vlTqme9SKyV8MjSaBsC9X8eKpJ/QIbjZAiVosBnda98tDa2SZeggKkFiA0A35G7qhgXdxssBq1m8s1HR3SngDY089txsjcUifs7ht7oPoodbav0vdwgrNRZn/n01Dv2UaYYDe4Nj53PhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kNvXKxrv5WrsKnMtyEt4onO5TWZspuEI0r1uNkPprQk=;
 b=dsxMs678mr8r0Ii3arRxEGMdqBN7DMI7VCjNavkNyl5dOSw6YAlOf67y+dfNh9LFAn1NB96BRiWNG7p96zyqELqhJBDcYWClomws+qwDTVrLk7iUEtW/l4ieErSASJe1OKV2RvC9Lc1G2xQQlIJ35N8VUF3QOIHzOyK+e+hGn5TkqadYM37IUHKzPqlavREVrnaSAxh/QHftbLb9ppssgqvVOttfiOq9GIly0VfhloTvdDMFo16vi5P1FQ9Ix1+dIvoWamiwVyRHo/VYZwv/a/DUaRl7v94NcIPgWQB7dV4KB3ttOj/vv6cV5VJu0N/bMgHNt+soZiyiNrSdDNuFeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kNvXKxrv5WrsKnMtyEt4onO5TWZspuEI0r1uNkPprQk=;
 b=k8hP0XTFnw3Lgd6tU9Q4YhE2SaHHwbt1eisg7fTKO1KmkaXxlmmgOogRFSyTEut/pP+t3blit975QSvD4c3jJHp7iOZzhf4h+59bu9pzdeBCK9e4L+xIW5l2NH5ohq2vcZq737+8IF1Q1OkEuU/wHqPSO0NZyKdLPmWsyoNV918=
Received: from DU2PR10MB5096.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2d9::19)
 by DU0PR10MB5171.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:343::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.14; Wed, 5 Jan
 2022 15:05:17 +0000
Received: from DU2PR10MB5096.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d67:573c:339:722]) by DU2PR10MB5096.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d67:573c:339:722%3]) with mapi id 15.20.4844.016; Wed, 5 Jan 2022
 15:05:17 +0000
From:   Ondrej Valousek <ondrej.valousek.xm@renesas.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "bfields@fieldses.org" <bfields@fieldses.org>,
        "trondmy@kernel.org" <trondmy@kernel.org>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Subject: RE: [PATCH 0/8] Support btime and other NFSv4 specific attributes
Thread-Topic: [PATCH 0/8] Support btime and other NFSv4 specific attributes
Thread-Index: AQHYAOOnWznuBWlA7k+POKyqIasZNKxRxaOAgALAoRA=
Date:   Wed, 5 Jan 2022 15:05:17 +0000
Message-ID: <DU2PR10MB5096010E9570E2718198EDD5E14B9@DU2PR10MB5096.EURPRD10.PROD.OUTLOOK.COM>
References: <20211217204854.439578-1-trondmy@kernel.org>
         <20220103205103.GI21514@fieldses.org>
 <2b27da48604aaa34acce22188bfd429037540a89.camel@hammerspace.com>
In-Reply-To: <2b27da48604aaa34acce22188bfd429037540a89.camel@hammerspace.com>
Accept-Language: cs-CZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=diasemi.com;
X-MS-Office365-Filtering-Correlation-Id: b9805fab-410d-4e79-9a6b-08d9d05ccb1f
x-ms-traffictypediagnostic: DU0PR10MB5171:EE_|OS0JPN01FT012:EE_|OSAPR01MB2116:EE_
X-Microsoft-Antispam-PRVS: <OSAPR01MB211677BFEA3885505CCB3316D94B9@OSAPR01MB2116.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: CMnSNiH9dmUG7rkHjxRlO7MQUmvFcpurTxfHeBJ1f8z+P8XpK7E5dY+qNs46ZJ+MA3HOYIuKAloE6DA8yR5aEnpAAjeMZgw0uinWebsEh69Yb/WD2jnZcUaCVxC3YwfKIDieSeOBJ9OgOVKoV52SSvy9xSoq/oadxuE3uyuRsdhW1a3ZjdgLh4WZRgDU2v+h/0INV66nEXRz2i80kjx2FRNMOSzju08kogE9lxarouNUqm41Z26/baWCMVrAaRkm1yFZGoBxfcnXDv9yPNTUY8MMwP031AcfNW3T4UOZQ3orfFfVsqWtmkxneB8TEaGdWZjpWnS9x5lH5gE75VO7Z0PdU30LHd/Eixu00cXSFks6baq4f0GPUjektkQU5hfYiuaL0IxXAe/ctfBNVb0x5O/wG6+adurAYEJg5PMxb/CBW46tNE3EJaX5+AJF4Q0hrf0COVAWQIzzNMSEgXt4wL6QQh+fF1CxzqNEI4GpEXEw08xH1Na202vSVvYbhyAEAAc5LIE7dYCVNaOgnx0u4NOyEqjebmumlAgdbwRoAO81ABBiySX6hjMGDeEaZBOiT7R+vx/36wZQbUEJNnIXhy5wQ2B8T4P3gcIAjIYEZ65uhd4HzMQKzvmNDXl1QFs0q95HbHjGNH13SxYhX5gTZf/UhPhQU9l7HnDQ/bJgu+rhMzGAW9TiEIUWzg8uQzq/MEXjVa0lpJEHIbr5yxUpZA==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR10MB5096.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(76116006)(83380400001)(86362001)(55016003)(8936002)(55236004)(64756008)(66446008)(38070700005)(4326008)(71200400001)(316002)(38100700002)(186003)(508600001)(66476007)(52536014)(110136005)(66556008)(53546011)(122000001)(8676002)(66946007)(6506007)(66574015)(54906003)(26005)(7696005)(9686003)(5660300002)(33656002)(2906002);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5171
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: OS0JPN01FT012.eop-JPN01.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 727569b1-f949-46f9-a5f5-08d9d05cc900
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KpGcWxVCtGi4mhT4dASc4dv3F7NHOzrOxMY1y2iU9RPclgNE4s2XRKs4dL8zjtVA2XvxfT4pPH++jtWvQMdOEPUqVn26NCPn8CDbdVT11rPIJmiTxEB5XGrUdGjZ+hSA7o1+T+VQzL7lLc3b28DmuRz6ls/gdqNLX7iAj+TJFJJJicba3EXJz0X4Q4ohqtxbbAzHJj1F7By7Lr0a2XP7PyVd89H/f6flXB1ob2M6h3+OYBuNwQppEoYIXEKCDXqTjA4l2uwqfq6SAyKb1jW6xzzvAOjhfdzZpzYAjtXKsiZpDvXXWx8umcz7yoTNAHQvwl4/+IBv3lIBjVCFfHuiKkFA4IAO5dIZYWVtmYtSlMifjbrwJb+OUPJ4TGTrlVoIkinxyOrC+i7sOwdbi+RpIyLQzSqTEXj/Tq/8dk3B6y5cLO5HV+It/D3zdbAoA2frGsu5/gQe4Pw40sVMPdEzthEDH7TuYq3j2oNp430xEMKL5V9iTvRQxPDSwBHu5Sd+CwfTJGvvM35xc43n8pMAd63JCmiKO/bMUcocabLKkqUql4sxaHXMScPMCelXzXzejZr8SGsWNXCfX/mVi/NrKBk6S1me7ua2Pv7EC3xZBKZdWWTFPP0skDN/GMIQYre2tf/9hzx/ThIR19wAqofx/xgAdnz0weI5L9S1lGPEQsVwConR5Rp3feZ0+AcPE/Vy03v+ACxDLyd4s+3q3jsm+XK7Dv8JoMbLXlcWm7IQrUvEIA7A/ar2ORUCfkWMbf8vmRfWORSy989lwD4zI1l7oAhy5BcOwJ1BK65R2hTZGVk=
X-Forefront-Antispam-Report: CIP:20.101.26.97;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mailrelay4.diasemi.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(40470700002)(36840700001)(2906002)(186003)(26005)(47076005)(66574015)(5660300002)(356005)(8676002)(316002)(83380400001)(81166007)(54906003)(4326008)(110136005)(33656002)(336012)(36906005)(70206006)(55016003)(52536014)(82310400004)(36860700001)(86362001)(9686003)(6506007)(53546011)(40460700001)(7696005)(70586007)(508600001)(8936002)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 15:05:20.7894
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9805fab-410d-4e79-9a6b-08d9d05ccb1f
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[20.101.26.97];Helo=[mailrelay4.diasemi.com]
X-MS-Exchange-CrossTenant-AuthSource: OS0JPN01FT012.eop-JPN01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB2116
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

SGkgYWxsLA0KU29ycnkgZm9yIGNvbmZ1c2lvbiBhbmQgbWF5YmUgZHVtYiBxdWVzdGlvbnM6DQot
IFRoZSBhaW0gaXMgdG8gdHJhbnNmZXIgdGhlc2UgYXR0cmlidXRlcyB2aWEgUkZDODI3NiAoRmls
ZSBTeXN0ZW0gRXh0ZW5kZWQgYXR0cmlidXRlcyBpbiBORlN2NCk/DQotIEFGQUlLIHN1cHBvcnQg
Zm9yIFJGQzgyNzYgaW4gTkZTIChvbmx5IHZlcnNpb24gNC4yKSBzZXJ2ZXIgaXMgc2luY2Uga2Vy
bmVsIDUuOSwgcmlnaHQ/IE5GUyBjbGllbnQgc3VwcG9ydHMgdGhlc2UgYXMgd2VsbD8NCi0gVGhl
IHBhdGNoZXMgYmVsb3cgaW1wbGVtZW50cyB0aGUgZmVhdHVyZSBpbiBib3RoLCBuZnMgY2xpZW50
IEFORCBzZXJ2ZXIsIHJpZ2h0Pw0KDQpJIGFtIGJpdCBjb25mdXNlZCBhcyAiYnRpbWUiIGRvZXMg
bm90IHNlZW0gdG8gYmUgc3RvcmVkIGFzIGV4dGVuZGVkIGF0dHJpYnV0ZSBpbiBtb3N0IGxvY2Fs
IGZpbGVzeXN0ZW1zIChjaGVja2VkIGV4dDQpIGJ1dCBpcyBpbiBzdGFuZGFyZCBpbm9kZSBzdHJ1
Y3R1cmUuDQpUaGFua3MsDQpPbmRyZWoNCg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
RnJvbTogVHJvbmQgTXlrbGVidXN0IDx0cm9uZG15QGhhbW1lcnNwYWNlLmNvbT4NClNlbnQ6IHBv
bmTEm2zDrSAzLiBsZWRuYSAyMDIyIDIxOjUyDQpUbzogYmZpZWxkc0BmaWVsZHNlcy5vcmc7IHRy
b25kbXlAa2VybmVsLm9yZw0KQ2M6IGxpbnV4LW5mc0B2Z2VyLmtlcm5lbC5vcmc7IGFubmEuc2No
dW1ha2VyQG5ldGFwcC5jb20NClN1YmplY3Q6IFJlOiBbUEFUQ0ggMC84XSBTdXBwb3J0IGJ0aW1l
IGFuZCBvdGhlciBORlN2NCBzcGVjaWZpYyBhdHRyaWJ1dGVzDQoNCk9uIE1vbiwgMjAyMi0wMS0w
MyBhdCAxNTo1MSAtMDUwMCwgSi4gQnJ1Y2UgRmllbGRzIHdyb3RlOg0KPiBPbiBGcmksIERlYyAx
NywgMjAyMSBhdCAwMzo0ODo0NlBNIC0wNTAwLCB0cm9uZG15QGtlcm5lbC5vcmcgd3JvdGU6DQo+
ID4gRnJvbTogVHJvbmQgTXlrbGVidXN0IDx0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29t
Pg0KPiA+DQo+ID4gTkZTdjQgaGFzIHN1cHBvcnQgZm9yIGEgbnVtYmVyIG9mIGV4dHJhIGF0dHJp
YnV0ZXMgdGhhdCBhcmUgb2YNCj4gPiBpbnRlcmVzdCB0byBTYW1iYSB3aGVuIGl0IGlzIHVzZWQg
dG8gcmUtZXhwb3J0IGEgZmlsZXN5c3RlbSB0bw0KPiA+IFdpbmRvd3MgY2xpZW50cy4NCj4gPiBB
c2lkZSBmcm9tIHRoZSBidGltZSwgd2hpY2ggaXMgb2YgaW50ZXJlc3QgaW4gc3RhdHgoKSwgV2lu
ZG93cw0KPiA+IGNsaWVudHMgaGF2ZSBhbiBpbnRlcmVzdCBpbiBkZXRlcm1pbmluZyB0aGUgc3Rh
dHVzIG9mIHRoZSAnaGlkZGVuJywNCj4gPiBhbmQgJ3N5c3RlbScNCj4gPiBmbGFncy4NCj4gPiBC
YWNrdXAgcHJvZ3JhbXMgd2FudCB0byByZWFkIHRoZSAnYXJjaGl2ZScgZmxhZ3MgYW5kIHRoZSAn
dGltZQ0KPiA+IGJhY2t1cCcNCj4gPiBhdHRyaWJ1dGUuDQo+ID4gRmluYWxseSwgdGhlICdvZmZs
aW5lJyBmbGFnIGNhbiB0ZWxsIHdoZXRoZXIgb3Igbm90IGEgZmlsZSBuZWVkcyB0bw0KPiA+IGJl
IHN0YWdlZCBieSBhbiBIU00gc3lzdGVtIGJlZm9yZSBpdCBjYW4gYmUgcmVhZCBvciB3cml0dGVu
IHRvLg0KPiA+DQo+ID4gVGhlIHBhdGNoIHNlcmllcyBhbHNvIGFkZHMgYW4gaW9jdGwoKSB0byBh
bGxvdyB1c2Vyc3BhY2UgcmV0cmlldmFsDQo+ID4gYW5kIHNldHRpbmcgb2YgdGhlc2UgYXR0cmli
dXRlcyB3aGVyZSBhcHByb3ByaWF0ZS4gSXQgYWxzbyBhZGRzIGFuDQo+ID4gaW9jdGwoKQ0KPiA+
IHRvIGFsbG93IHJldHJpZXZhbCBvZiB0aGUgcmF3IE5GU3Y0IEFDQ0VTUyBpbmZvcm1hdGlvbiwg
dG8gYWxsb3cNCj4gPiBtb3JlIGZpbmUgZ3JhaW5lZCBkZXRlcm1pbmF0aW9uIG9mIHRoZSB1c2Vy
J3MgYWNjZXNzIHJpZ2h0cyB0byBhDQo+ID4gZmlsZSBvciBkaXJlY3RvcnkuIEFsbCBvZiB0aGlz
IGluZm9ybWF0aW9uIGlzIG9mIHVzZSBmb3IgU2FtYmEuDQo+DQo+IFNhbWUgcXVlc3Rpb24sIHdo
YXQgZmlsZXN5c3RlbSBhbmQgc2VydmVyIGFyZSB5b3UgdGVzdGluZyBhZ2FpbnN0Pw0KPg0KDQpT
YW1lIGFuc3dlci4NCg0KPiAtLWIuDQo+DQo+ID4NCj4gPiBBbm5lIE1hcmllIE1lcnJpdHQgKDMp
Og0KPiA+ICAgbmZzOiBBZGQgdGltZWNyZWF0ZSB0byBuZnMgaW5vZGUNCj4gPiAgIG5mczogQWRk
ICdhcmNoaXZlJywgJ2hpZGRlbicgYW5kICdzeXN0ZW0nIGZpZWxkcyB0byBuZnMgaW5vZGUNCj4g
PiAgIG5mczogQWRkICd0aW1lIGJhY2t1cCcgdG8gbmZzIGlub2RlDQo+ID4NCj4gPiBSaWNoYXJk
IFNoYXJwZSAoMSk6DQo+ID4gICBORlM6IFN1cHBvcnQgc3RhdHhfZ2V0IGFuZCBzdGF0eF9zZXQg
aW9jdGxzDQo+ID4NCj4gPiBUcm9uZCBNeWtsZWJ1c3QgKDQpOg0KPiA+ICAgTkZTOiBFeHBhbmQg
dGhlIHR5cGUgb2YgbmZzX2ZhdHRyLT52YWxpZA0KPiA+ICAgTkZTOiBSZXR1cm4gdGhlIGZpbGUg
YnRpbWUgaW4gdGhlIHN0YXR4IHJlc3VsdHMgd2hlbiBhcHByb3ByaWF0ZQ0KPiA+ICAgTkZTdjQ6
IFN1cHBvcnQgdGhlIG9mZmxpbmUgYml0DQo+ID4gICBORlN2NDogQWRkIGFuIGlvY3RsIHRvIGFs
bG93IHJldHJpZXZhbCBvZiB0aGUgTkZTIHJhdyBBQ0NFU1MgbWFzaw0KPiA+DQo+ID4gIGZzL25m
cy9kaXIuYyAgICAgICAgICAgICAgfCAgNzEgKystLS0NCj4gPiAgZnMvbmZzL2dldHJvb3QuYyAg
ICAgICAgICB8ICAgMyArLQ0KPiA+ICBmcy9uZnMvaW5vZGUuYyAgICAgICAgICAgIHwgMTQ3ICsr
KysrKysrKy0NCj4gPiAgZnMvbmZzL2ludGVybmFsLmggICAgICAgICB8ICAxMCArDQo+ID4gIGZz
L25mcy9uZnMzcHJvYy5jICAgICAgICAgfCAgIDEgKw0KPiA+ICBmcy9uZnMvbmZzNF9mcy5oICAg
ICAgICAgIHwgIDMxICsrKw0KPiA+ICBmcy9uZnMvbmZzNGZpbGUuYyAgICAgICAgIHwgNTUwDQo+
ID4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgZnMvbmZzL25m
czRwcm9jLmMgICAgICAgICB8IDE3NSArKysrKysrKysrKy0NCj4gPiAgZnMvbmZzL25mczR0cmFj
ZS5oICAgICAgICB8ICAgOCArLQ0KPiA+ICBmcy9uZnMvbmZzNHhkci5jICAgICAgICAgIHwgMjQw
ICsrKysrKysrKysrKysrKy0tDQo+ID4gIGZzL25mcy9uZnN0cmFjZS5jICAgICAgICAgfCAgIDUg
Kw0KPiA+ICBmcy9uZnMvbmZzdHJhY2UuaCAgICAgICAgIHwgICA5ICstDQo+ID4gIGZzL25mcy9w
cm9jLmMgICAgICAgICAgICAgfCAgIDEgKw0KPiA+ICBpbmNsdWRlL2xpbnV4L25mczQuaCAgICAg
IHwgICAxICsNCj4gPiAgaW5jbHVkZS9saW51eC9uZnNfZnMuaCAgICB8ICAxNSArKw0KPiA+ICBp
bmNsdWRlL2xpbnV4L25mc19mc19zYi5oIHwgICAyICstDQo+ID4gIGluY2x1ZGUvbGludXgvbmZz
X3hkci5oICAgfCAgODAgKysrKy0tDQo+ID4gIGluY2x1ZGUvdWFwaS9saW51eC9uZnMuaCAgfCAx
MDEgKysrKysrKw0KPiA+ICAxOCBmaWxlcyBjaGFuZ2VkLCAxMzU2IGluc2VydGlvbnMoKyksIDk0
IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gLS0NCj4gPiAyLjMzLjENCg0KLS0NClRyb25kIE15a2xl
YnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZSB0cm9uZC5teWts
ZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0KTGVnYWwgRGlzY2xhaW1lcjogVGhpcyBlLW1haWwg
Y29tbXVuaWNhdGlvbiAoYW5kIGFueSBhdHRhY2htZW50L3MpIGlzIGNvbmZpZGVudGlhbCBhbmQg
Y29udGFpbnMgcHJvcHJpZXRhcnkgaW5mb3JtYXRpb24sIHNvbWUgb3IgYWxsIG9mIHdoaWNoIG1h
eSBiZSBsZWdhbGx5IHByaXZpbGVnZWQuIEl0IGlzIGludGVuZGVkIHNvbGVseSBmb3IgdGhlIHVz
ZSBvZiB0aGUgaW5kaXZpZHVhbCBvciBlbnRpdHkgdG8gd2hpY2ggaXQgaXMgYWRkcmVzc2VkLiBB
Y2Nlc3MgdG8gdGhpcyBlbWFpbCBieSBhbnlvbmUgZWxzZSBpcyB1bmF1dGhvcml6ZWQuIElmIHlv
dSBhcmUgbm90IHRoZSBpbnRlbmRlZCByZWNpcGllbnQsIGFueSBkaXNjbG9zdXJlLCBjb3B5aW5n
LCBkaXN0cmlidXRpb24gb3IgYW55IGFjdGlvbiB0YWtlbiBvciBvbWl0dGVkIHRvIGJlIHRha2Vu
IGluIHJlbGlhbmNlIG9uIGl0LCBpcyBwcm9oaWJpdGVkIGFuZCBtYXkgYmUgdW5sYXdmdWwuDQo=
