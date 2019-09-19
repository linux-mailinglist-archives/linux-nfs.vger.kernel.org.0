Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC9BB7740
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Sep 2019 12:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388893AbfISKVa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 19 Sep 2019 06:21:30 -0400
Received: from mail-sy3aus01hn2012.outbound.protection.outlook.com ([52.103.199.12]:37131
        "EHLO AUS01-SY3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388742AbfISKV3 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 19 Sep 2019 06:21:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hwrBmWAtku0b+xmHFqQY7i/3sKi9SYgnzKt0vZav3N/0AS9EgxHa3WNvUKhHqCMw4HFmdMWdIZqF/Oki7RXjx2AD7ltwQratKrKxApyd7G5pzExzJthPDCwKNHGoDsSLoiDZICF4XO7PxiWNZXG/EpdBHKtIhn7qYp1dIjp0dFwK6pkT6QjCfXcavaptspUFTUrpQ1cnUSCj8TQs683sbke637Ugfhb592jbe3krEodR7sHC5Bl//rk/S+zkrPSGAdD3eJfsVhNtH0PsncGRRphzvxFYS63sM/r7P3LltpETxwilNJR0CZnwx9/3aNRx79xdEkc1vGAtFrI5p3aTig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ctOHH2mTYytKOkOB/KQgjBv82LXnbGG7XKgNOOQYhPo=;
 b=hAc5yDXkklK3pqIkdgurcd03K0/gEiWZ2hgvNbU5GzxGWR2GZ7HcUUNMfUO3cun5BIX1AnFjx5xr87HXSc6D1ZTOrkEGCnspfoTkZDUmEc57lsFIz/Dq2Wm3oNa5l7e4+HHg+odsL7msu0j9DM02HqaAzg+Nmi02Ss6CRTaZYwp5nvsWausUibDvWho5ZgdgRkkDD2inqjTaLgz6CS7suV+ITtLT2HUuAoU5fCqod8S67KlVWjjEt9uuX3QbiuDTPyBjJ8OSKaDTZNst0r1nYWD/HngsLcAX0TXEsFihDw4ovE3Hh4sXZ+tKxqh/bA5XSPCa14IesAw0GILlTdcTFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=student.uts.edu.au; dmarc=pass action=none
 header.from=student.uts.edu.au; dkim=pass header.d=student.uts.edu.au;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=studentutsedu.onmicrosoft.com; s=selector2-studentutsedu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ctOHH2mTYytKOkOB/KQgjBv82LXnbGG7XKgNOOQYhPo=;
 b=qvE7W5z/oFkIfozuTNZsvNSntWLY9foYbXmvZduvs8Ljs0xAQVyS73/PXq6qau4RpziPJdL+PKLuNupcQUkWlDeXG/0uWDnDoLIW9GWzCrQEHifuI2R6eUa6YfmyH/9ABXU5763gLe200qTTdPDGtSzZzIUw3W9no7EOArlDqmU=
Received: from SY2PR01MB2507.ausprd01.prod.outlook.com (52.134.170.12) by
 SY2PR01MB2217.ausprd01.prod.outlook.com (52.134.169.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.26; Thu, 19 Sep 2019 10:21:24 +0000
Received: from SY2PR01MB2507.ausprd01.prod.outlook.com
 ([fe80::8c04:bcd2:c5:813]) by SY2PR01MB2507.ausprd01.prod.outlook.com
 ([fe80::8c04:bcd2:c5:813%6]) with mapi id 15.20.2263.023; Thu, 19 Sep 2019
 10:21:24 +0000
From:   <13406208@student.uts.edu.au>
To:     Benjamin Timothy Handrijanto 
        <BenjaminTimothy.Handrijanto@student.uts.edu.au>
Subject: Darlehensangebot
Thread-Topic: Darlehensangebot
Thread-Index: AQHVbtP97RjfUz9+8k6wTZU69/8l4A==
Date:   Thu, 19 Sep 2019 10:21:24 +0000
Message-ID: <SY2PR01MB2507609FA016396EC26EAFFEA5890@SY2PR01MB2507.ausprd01.prod.outlook.com>
Reply-To: "chelsealoan4@gmail.com" <chelsealoan4@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0397.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:f::25) To SY2PR01MB2507.ausprd01.prod.outlook.com
 (2603:10c6:1:24::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=BenjaminTimothy.Handrijanto@student.uts.edu.au; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [154.160.2.147]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1210b683-2dc0-4d32-0c38-08d73ceb1f90
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:SY2PR01MB2217;
x-ms-traffictypediagnostic: SY2PR01MB2217:
x-microsoft-antispam-prvs: <SY2PR01MB2217D9FD16E1FEBF45B042A795890@SY2PR01MB2217.ausprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 016572D96D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(136003)(396003)(366004)(346002)(189003)(199004)(9686003)(71200400001)(52536014)(476003)(386003)(14454004)(3480700005)(43066004)(186003)(325944009)(71190400001)(786003)(5660300002)(66806009)(26005)(66446008)(99286004)(81156014)(102836004)(4744005)(52116002)(7696005)(66476007)(66556008)(64756008)(316002)(66066001)(25786009)(5003540100004)(7416002)(33656002)(6506007)(6862004)(221733001)(81166006)(6116002)(7736002)(55016002)(66946007)(8676002)(8936002)(2171002)(74316002)(8796002)(22416003)(6636002)(66574012)(305945005)(14444005)(478600001)(7116003)(256004)(2906002)(88552002)(3846002)(2860700004)(486006)(6436002)(81742002);DIR:OUT;SFP:1501;SCL:1;SRVR:SY2PR01MB2217;H:SY2PR01MB2507.ausprd01.prod.outlook.com;FPR:;SPF:None;LANG:de;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: student.uts.edu.au does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3HnPE3/rBeniKhcXTmvGGN16F26yUNd0NjlKihXWPZhp7a/cz8kNaP97YC9V+l5tLa6TFlbXkIQMlBelpMR1VptGoWlmuRV5Syg9FmfpFrpftueVao5Yci70msG1hD2vchrjGhn1kjkxTYu+41VGvtsVYz6a5B/gCTdP/5wIzTWICW+jOxQowFJ/RkNKb49g3RCmOeKMFUz1giaSGT/t3IULBoX3tU1V9kGpx/njm5C/NyKkUJmYgbVjrhSxyyeVY8FLlhtxJsOTemuUnz6KTyCtKzW4XF6OzxjBev3dWoiC33xylej1n0K5uPNNRfUMK1F6ETz8xN1Ix+8JvgEFFhCdVNpjK5eQXUbs7wP/NehtiMbr9F0nve4lmO2LN+BZqZM1xLEMZzfQOeFo/5utNYnvfKxQqqd2vDV5pfXBi/g=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <ADE81CE2A1DD314290E1101369512A80@ausprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: student.uts.edu.au
X-MS-Exchange-CrossTenant-Network-Message-Id: 1210b683-2dc0-4d32-0c38-08d73ceb1f90
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2019 10:21:24.2038
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e8911c26-cf9f-4a9c-878e-527807be8791
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KzmF1TNcdyIEHByS3tEBsZjP3UmR8NUpm2qJDAA3RA+hV53T+5Nvb5NnHQqZsy9sGZQMPXf32DgA34gFaZHp0P2N4Tdz/Y0YZ1xclLHaUqw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY2PR01MB2217
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Sch=F6nen Tag

Ben=F6tigen Sie ein echtes Darlehen online, um Ihre Rechnungen zu sichern u=
nd starten Sie ein
neues Gesch=E4ft? Ben=F6tigen Sie einen pers=F6nlichen Kredit? Wir bieten a=
lle Arten von Darlehen
mit 3% zinssatz und auch mit einem erschwinglichen r=FCckzahlungsbedingunge=
n.

F=FCr weitere Informationen antworten Sie mit den unten stehenden Informati=
onen.

Name:
Land:
Zustand:
Ben=F6tigte Menge:
Dauer:
Telefonnummer:
Monatliches Einkommen:

Bitte beachten Sie, dass auf Kontakt-E-Mail:
chelsealoan4@gmail.com
