Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98AA8968B2
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Aug 2019 20:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729900AbfHTSm0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 20 Aug 2019 14:42:26 -0400
Received: from esa12.utexas.iphmx.com ([216.71.154.221]:14856 "EHLO
        esa12.utexas.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729639AbfHTSm0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 20 Aug 2019 14:42:26 -0400
X-Greylist: delayed 425 seconds by postgrey-1.27 at vger.kernel.org; Tue, 20 Aug 2019 14:42:25 EDT
IronPort-SDR: yewK+DP8CzKRELPZuBEkrOhE7qJB6D5th1gpCVxHblnwX3S6RTSJr+XRZgOdcaeEeLXJjzeolP
 9k+AlckAPiXSo6/E6mloTM5A++YJ5oXe/Ha7FvniL6y4ShByp8SAIavSP98se50ctFUi1kAoe5
 ATC5C3VNBG11wS33om506id5N6WfqqvBZQgKouHEyTwWECls+SHsyit02rO4ItopAFc84nDlS7
 BAVF5Xd0/r6lEHptDDci9TYqYT4W9r7n83cdpZPCZwPz2rgzqe37pd3hWlC3za707ci6012SnK
 R/0=
X-Utexas-Sender-Group: RELAYLIST-O365
X-IronPort-MID: 149730551
IronPort-PHdr: =?us-ascii?q?9a23=3A3R1dchEL9z++VMJZIiueRZ1GYnJ96bzpIg4Y7I?=
 =?us-ascii?q?YmgLtSc6Oluo7vJ1Hb+e4z0Q3SRYuO7fVChqKWqK3mVWEaqbe5+HEZON0pNV?=
 =?us-ascii?q?cejNkO2QkpAcqLE0r+eeblaCEmDuxHXUNluWynPFhcA4Dza0CB6nA=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2FGAQCAPFxdhzQoL2hmHAEBAQQBAQc?=
 =?us-ascii?q?EAQGBZ4FFUHB1BAsqCoQVg0cDhTKFSZ0TAxgXJQEIAQEBAQEBAQEBBwElCAI?=
 =?us-ascii?q?BAQKEVoJiOBMCBQEBBQECAQEGBAICEAEBAQgNCQgphS4MgnQETTkyAQEBAQE?=
 =?us-ascii?q?BAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBBQINKwxFEREMAQE4EQE?=
 =?us-ascii?q?iAiYCBDAVEgQ1gwABgWoDHQEOn2o9AmICC4EEKYhgAQFygTKCewEBBYEyAQM?=
 =?us-ascii?q?CBgGBCIJCGEEIgUsDBoEMKIt7BoFBPoE4DIV+AQEDgUiDIYJYjCyCa4c+lQQ?=
 =?us-ascii?q?JAoIdhmiNSwYbgjGLSIpNlT6QKwIEAgQFAg4BAQWBZ4F6chM7gmyCQgwOCYN?=
 =?us-ascii?q?PhRSFP0ABMYEpjHMBgSABAQ?=
X-IPAS-Result: =?us-ascii?q?A2FGAQCAPFxdhzQoL2hmHAEBAQQBAQcEAQGBZ4FFUHB1B?=
 =?us-ascii?q?AsqCoQVg0cDhTKFSZ0TAxgXJQEIAQEBAQEBAQEBBwElCAIBAQKEVoJiOBMCB?=
 =?us-ascii?q?QEBBQECAQEGBAICEAEBAQgNCQgphS4MgnQETTkyAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBBQINKwxFEREMAQE4EQEiAiYCBDAVEgQ1g?=
 =?us-ascii?q?wABgWoDHQEOn2o9AmICC4EEKYhgAQFygTKCewEBBYEyAQMCBgGBCIJCGEEIg?=
 =?us-ascii?q?UsDBoEMKIt7BoFBPoE4DIV+AQEDgUiDIYJYjCyCa4c+lQQJAoIdhmiNSwYbg?=
 =?us-ascii?q?jGLSIpNlT6QKwIEAgQFAg4BAQWBZ4F6chM7gmyCQgwOCYNPhRSFP0ABMYEpj?=
 =?us-ascii?q?HMBgSABAQ?=
X-IronPort-AV: E=Sophos;i="5.64,408,1559538000"; 
   d="scan'208";a="149730551"
X-Utexas-Seen-Outbound: true
Received: from mail-co1nam03lp2052.outbound.protection.outlook.com (HELO NAM03-CO1-obe.outbound.protection.outlook.com) ([104.47.40.52])
  by esa12.utexas.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA384; 20 Aug 2019 13:35:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DDmA3t2rTdtIT3L7I776PflIRgwY8QhiIsp2/0CV79e+MREbtcP3DC0wJsIXnXN4XB1sNPplszhgBfvZDsgRGmiTy/nN0frX6tIV2gUjAbcBfNy4tsZ30S6EdLJ8Ai07Yyx6guofdSewoPtWu53m7ERwMT+tAXd29aNy8e0nkwsHpEZ4u3dPcU/7n78SkQGwrL/e5zXmlAI3uZJGhGzhThY+boKmcO01xAt/ikUVmVFW+emY3SwwmIqXUi/Y0L/J+iD2trXmQ/4DMoXZd98IOZmw10+x506Fj35Y/yHczyqMkLYR2ae1kV4wO4X5OYxfdKPLo/I5zp9tVgl/KitVFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wXDQy7PzKbYLjFHKF599Iy+PT5+jJ3onq+11i0U4x/s=;
 b=VpEtcgrBeMEGFqaKrBcEi4vzoMK1scnoKxxGeOLKVGrbeBPPhMho4hmnFnudVLR/KWTnrVdqbR6MAxHaHK64PW1Ic98r8r5pOFGXpYZOjSIoNZr/BL3JLQG0ShWuZe2STCdXqHlXkxauRjcJsy14JN7nG10lLzNuoVrIpkzzh/qzzEU2obHGoI4wkb7yLleCdIZsjUNEHpsntDaPBeB4u0pvi4ITiNpVTDle2xW8vRaqAxS52oSN2hc4kfqbD+BYGh7mLzO3FFXFBsJFoCoekmscbTxv2nx9s+A+LTnlD5WH0XMQ93+liKHs46cBeky1pnEgcSf3T+WIP6IMTpd1+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=math.utexas.edu; dmarc=pass action=none
 header.from=math.utexas.edu; dkim=pass header.d=math.utexas.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=utexas.onmicrosoft.com; s=selector2-utexas-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wXDQy7PzKbYLjFHKF599Iy+PT5+jJ3onq+11i0U4x/s=;
 b=qKQU6XC3lmRbptueavm9CA+Z3AiFRLGKcb8NybEmdtnj100FXFNPQca1xbCsvGjPitBlxImI0gZ6s0GdtglfmEdDDVnSEj+QSgw2KRhTxnPF25UZjhxTrK5n2ZcR8Fq94+kJGd0k2KW4rrdwnc7J4+iFr9rJa3xpRXxjFR3Th4M=
Received: from DM5PR0601MB3606.namprd06.prod.outlook.com (10.167.108.144) by
 DM5PR0601MB3703.namprd06.prod.outlook.com (10.167.109.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Tue, 20 Aug 2019 18:35:16 +0000
Received: from DM5PR0601MB3606.namprd06.prod.outlook.com
 ([fe80::6dec:6d3b:c9d9:7a41]) by DM5PR0601MB3606.namprd06.prod.outlook.com
 ([fe80::6dec:6d3b:c9d9:7a41%3]) with mapi id 15.20.2178.018; Tue, 20 Aug 2019
 18:35:16 +0000
From:   "Goetz, Patrick G" <pgoetz@math.utexas.edu>
To:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Does NFSv4 translate POSIX ACL's?
Thread-Topic: Does NFSv4 translate POSIX ACL's?
Thread-Index: AQHVV4YCqNKAAnKluU6Tf/XbLwm5OQ==
Date:   Tue, 20 Aug 2019 18:35:16 +0000
Message-ID: <87bee5fc-5461-01b2-ad9d-9c60e86396c1@math.utexas.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CH2PR19CA0002.namprd19.prod.outlook.com
 (2603:10b6:610:4d::12) To DM5PR0601MB3606.namprd06.prod.outlook.com
 (2603:10b6:4:7c::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pgoetz@math.utexas.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [128.83.133.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 13c8b920-1b96-40a2-25f7-08d7259d2537
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM5PR0601MB3703;
x-ms-traffictypediagnostic: DM5PR0601MB3703:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <DM5PR0601MB3703C5BDA4480F04799BFA4283AB0@DM5PR0601MB3703.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 013568035E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(346002)(376002)(366004)(136003)(189003)(199004)(53936002)(6306002)(71200400001)(71190400001)(7736002)(52116002)(476003)(2616005)(305945005)(5660300002)(6486002)(6436002)(14454004)(2906002)(3846002)(6116002)(8936002)(478600001)(66066001)(86362001)(31686004)(386003)(6506007)(75432002)(6512007)(25786009)(88552002)(316002)(81156014)(81166006)(8676002)(786003)(186003)(966005)(66446008)(64756008)(66556008)(66476007)(14444005)(256004)(102836004)(6916009)(486006)(26005)(99286004)(31696002)(66946007);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR0601MB3703;H:DM5PR0601MB3606.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: math.utexas.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: NLZHYA+iRjGqu9pfnJEGVfokZzOeS4bccjMEC16D1mKccwg/vwa/woxJY88/Gy0zoRX2kKO4MfMuIpw99z0an/LUBBLSLBUxnjn2ZomT1Md0FzA3e+v5vCtc6L//rLIcZAUYTa7QkKEs4Weitf6OV+G0lYdv/joiOeq93CM73bi7zRIDJJl7aiZ8y2Zzm2d2i+pIQKkQtSsoX0mth8mUiQ9t5BlnES6w7U6eHEC6CLU/b+yXqiWqoiH96mfHOh96JtoYCEXQiruWdtZIjvkiRGG5wZ7OWMMcfTb25/WAgSFz5Go9Q7dQ/uxrhgKPqp/Dg+SF7gKiWGmRkRxNiFQY9QU2YQhnDxljNBnV7QpNb7wWv45ueYOfpPuNYvlCSbAvQaefFgufd53l5jbK/kl+1bLgW+PmCtYGKkEzXe7ojNM=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <FDC9AC83634D7C42843F73DE869FDC54@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: math.utexas.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 13c8b920-1b96-40a2-25f7-08d7259d2537
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2019 18:35:16.3358
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 31d7e2a5-bdd8-414e-9e97-bea998ebdfe1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dP46NnP/Pz/uZ80lHISbwT8OSuEFmipBrGHl2CvH8eKW3480BL8HcpWgARofumL/lCAlQUQwmbVkyWbeYyvfLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0601MB3703
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

UG9zdGluZyB0byB0aGlzIGxpc3Qgb3V0IG9mIGRlc3BlcmF0aW9uLCBhcyBJJ3ZlIGV4aGF1c3Rl
ZCBhbGwgdGhlIG90aGVyIA0KcmVzb3VyY2VzIEkgY2FuIGdldCBteSBoYW5kcyBvbi4NCg0KVGhl
IGZ1bGwgYmxvd24gaXNzdWUgaGFzIGJlZW4gcG9zdGVkIGhlcmU6DQoNCiANCmh0dHBzOi8vdW5p
eC5zdGFja2V4Y2hhbmdlLmNvbS9xdWVzdGlvbnMvNTM2MzAwL3doeS1pcy1uZnN2NC1ub3QtdHJh
bnNsYXRpbmctcG9zaXgtYWNscy1pbi1hLXVzYWJsZS13YXkNCg0KSSBoYXZlIGFuIE5GU3Y0IGV4
cG9ydGVkIGZvbGRlciAoYmFzZSBmaWxlc3lzdGVtOiBYRlMpIHdoaWNoIG11c3QgYWZmb3JkIA0K
cmVhZCBhY2Nlc3MgdG8gYSBwcm9ncmFtIG9uIGZvbGRlcnMgd2hpY2ggYXJlIG90aGVyd2lzZSBo
aWRkZW4gZnJvbSB0aGUgDQpwdWJsaWMuICBPbiB0aGUgTkZTIHNlcnZlcjoNCg0KICAgcm9vdEBr
cmFrZW46L0VNL0VNdGlmcyMgZ2V0ZmFjbCBwZ29ldHoNCiAgICMgZmlsZTogcGdvZXR6DQogICAj
IG93bmVyOiBwZ29ldHoNCiAgICMgZ3JvdXA6IGNucy1jbnNpdGxhYnVzZXJzDQogICB1c2VyOjpy
d3gNCiAgIGdyb3VwOjpyLXgNCiAgIG90aGVyOjotLS0NCiAgIGRlZmF1bHQ6dXNlcjo6cnd4DQog
ICBkZWZhdWx0OnVzZXI6Y3J5b3NwYXJjX3VzZXI6ci14DQogICBkZWZhdWx0Omdyb3VwOjpyLXgN
CiAgIGRlZmF1bHQ6bWFzazo6ci14DQogICBkZWZhdWx0Om90aGVyOjotLS0NCg0KICAgcm9vdEBr
cmFrZW46L0VNL0VNdGlmcyMgaWQgY3J5b3NwYXJjX3VzZXINCiAgIHVpZD0xMDE3KGNyeW9zcGFy
Y191c2VyKSBnaWQ9MTAxNyhjcnlvc3BhcmNfdXNlcikgDQpncm91cHM9MTAxNyhjcnlvc3BhcmNf
dXNlcikNCg0KDQpUaGUgTkZTIGNsaWVudCBhcHBlYXJzIHRvIGJlIHRyYW5zbGF0aW5nIHRoZSBQ
T1NJWCBBQ0w6DQoNCiAgIHJvb3RAamF2ZWxpbmE6L0VNL0VNdGlmcyMgbmZzNF9nZXRmYWNsIHBn
b2V0eg0KICAgQTo6T1dORVJAOnJ3YUR4dFRjQ3kNCiAgIEE6OkdST1VQQDpyeHRjeQ0KICAgQTo6
RVZFUllPTkVAOnRjeQ0KICAgQTpmZGk6T1dORVJAOnJ3YUR4dFRjQ3kNCiAgIEE6ZmRpOjEwMTc6
cnh0Y3kNCiAgIEE6ZmRpOkdST1VQQDpyeHRjeQ0KICAgQTpmZGk6RVZFUllPTkVAOnRjeQ0KDQog
ICByb290QGphdmVsaW5hOi9FTS9FTXRpZnMjIGlkIGNyeW9zcGFyY191c2VyDQogICB1aWQ9MTAx
Nyhjcnlvc3BhcmNfdXNlcikgZ2lkPTEwMTcoY3J5b3NwYXJjX3VzZXIpIA0KZ3JvdXBzPTEwMTco
Y3J5b3NwYXJjX3VzZXIpDQoNCkhvd2V2ZXIsDQoNCiAgIGNyeW9zcGFyY191c2VyQGphdmVsaW5h
Oi9FTS9FTXRpZnMkIHdob2FtaQ0KICAgY3J5b3NwYXJjX3VzZXINCiAgIGNyeW9zcGFyY191c2Vy
QGphdmVsaW5hOi9FTS9FTXRpZnMkIGxzIHBnb2V0eg0KICAgbHM6IGNhbm5vdCBvcGVuIGRpcmVj
dG9yeSAncGdvZXR6JzogUGVybWlzc2lvbiBkZW5pZWQNCg0KSG9zdCBPUyBvbiBib3RoIG1hY2hp
bmVzOiBVYnVudHUgMTguMDQNCk5GUyB2ZXJzaW9uOiAxLjMuNA0KTW91bnQgZW50cnkgaW4gL2V0
Yy9mc3RhYjoNCiAgIGtyYWtlbi5iaW9zY2kudXRleGFzLmVkdTovRU0gIC9FTSAgbmZzNCAgX25l
dGRldixhdXRvICAwICAwDQoNCg0KSSBmb3VuZCB0aGlzIGRvY3VtZW50IHRoYXQgQnJ1Y2Ugd3Jv
dGU6DQoNCiAgIGh0dHBzOi8vdG9vbHMuaWV0Zi5vcmcvaHRtbC9kcmFmdC1pZXRmLW5mc3Y0LWFj
bC1tYXBwaW5nLTAyDQoNCmJ1dCBpdCBkb2Vzbid0IGFwcGVhciB0byBoYXZlIHJpc2VuIHRvIHRo
ZSBsZXZlbCBvZiBSRkM/ICBSRkMgNzUzMCANCmRvZXNuJ3QgYXBwZWFyIHRvIGhhdmUgYW55dGhp
bmcgdG8gc2F5IG9uIHRoZSBtYXR0ZXIuICBTaW5jZSB0aGUgDQpwcm9jZXNzaW5nIHByb2dyYW0g
cHJpbWFyaWx5IHJ1bnMgb24gdGhlIHdvcmtzdGF0aW9ucywgSSBuZWVkIHRvIG1ha2UgDQp0aGlz
IHdvcmsgc29tZWhvdywgYW5kIGNhbid0IGFkZCB0aGUgcHJvZ3JhbSB1c2VyIHRvIHRoZSB1c2Vy
IGdyb3VwIGFzIA0KZXhwbGFpbmVkIGluIHRoZSBTdGFja0V4Y2hhbmdlIHBvc3QuDQoNCg0K
