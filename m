Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4411318899
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Feb 2021 11:52:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbhBKKuF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 11 Feb 2021 05:50:05 -0500
Received: from mail-oln040092005057.outbound.protection.outlook.com ([40.92.5.57]:45182
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230116AbhBKKsD (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 11 Feb 2021 05:48:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K1hWq9TNqUHgxlG1P6telgjda/sKuzeujU6gurf+zHx9TPGH5VbYNn6XCIUYmOMnqhGd3DxqlpMC+zZ03e+3jSa9vL+ZeYXqbLqT8RnmuOo7AroAR4DdAuF1vKedTsqEPG439C4UdgnLBl+UeAzkzAqzLrZPuaLHoCbiYJHNICcQDpkDnMQ8HtzMaZStmt1ZKM8OS1Bov42LnT+RLmGmYEdj9AzHn9u7KfL4gDa4vgDLiVQoqW664LcYSPNRpPT10s4ak2MjQHxTY6TFpTVXORe2ywfAKncHlpRDr1nhGpPIVrkXoOk2jhrE079rWtRcMm8KrQ437bDDkCusXtyYRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hlPB8m2HwHUpeym8qXFe4phU8wAsMlpD5SlnuoL3DCg=;
 b=ei4PtGf5yPsa+qY3nMGdzRIibXZceB9d4mQPocMXJuX4ElFenOW77TsGUYqxkXClUxukTR7g5HJfbhCWnGO4l4a9QmZ1H9di4ZQS+8n1YgF7ktEBoGcUYfHVX5XFMr0P0w6abaTHJpmwfisVHPsMfiw8gK7pE2TA2MRgUaugkp9wsyxg1KHFt1ELk5UlukkvsHwWkjKTWw0LWAFDOF4eivXexLyi+cUPSBLyWPFYvzGCwftWsrESpqsIAgbv6GrK2wpzRrmSOa0YA8bJzwnkvPUM/H97fRuKdUmmlRXY2Cs+A9PZT+jSnlcNaY2EOq4hlBXdw3kxMYXHP88NdNOqKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=msn.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hlPB8m2HwHUpeym8qXFe4phU8wAsMlpD5SlnuoL3DCg=;
 b=eaOYZVicU0ZEBqiXeDqSavDAntORW3lDWkyPqP132Y5zJF1G4J87ShFf7/sGcNRMWThu+ulnLAIhc669+RBrz8HH+Q7I+iXrLeRMv+eiyf+f1XfGXzqM/vUWAdnoD8RPtAryByXkKJf68elksMD/8cPQ92vplH3srsge1nxbhGB/zw/kuhEFz8tZDAzMAxBfOTVi+Cn71ahRibgibroeFfHMfsdAeVGKVEI5UWTnC/x0RQTFmj5fVKySkvavsmbKO6KgsDtLfwBtO/qAYv2UnuCKJyXY42zFAQSPYxDb/jHfAAeo3aqpmF7Vq8KUgMFBo/bIP89J2x05oMyDe8JKKg==
Received: from BL2NAM02FT028.eop-nam02.prod.protection.outlook.com
 (10.152.76.55) by BL2NAM02HT146.eop-nam02.prod.protection.outlook.com
 (10.152.76.233) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25; Thu, 11 Feb
 2021 10:47:07 +0000
Received: from MWHPR15MB1821.namprd15.prod.outlook.com (10.152.76.53) by
 BL2NAM02FT028.mail.protection.outlook.com (10.152.77.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3846.25 via Frontend Transport; Thu, 11 Feb 2021 10:47:07 +0000
Received: from MWHPR15MB1821.namprd15.prod.outlook.com
 ([fe80::b987:f7af:fef2:bd39]) by MWHPR15MB1821.namprd15.prod.outlook.com
 ([fe80::b987:f7af:fef2:bd39%7]) with mapi id 15.20.3825.030; Thu, 11 Feb 2021
 10:47:07 +0000
From:   MIDWEST HERITAGE <antooonio766@msn.com>
Subject: REF/PAYMENTS CODE: 09284B
Thread-Topic: REF/PAYMENTS CODE: 09284B
Thread-Index: AQHXAGM9LU/KsWqtOkyr0jtF99dJsA==
Date:   Thu, 11 Feb 2021 10:47:06 +0000
Message-ID: <MWHPR15MB18211AF25D49B47B44DE79C58E8C9@MWHPR15MB1821.namprd15.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-incomingtopheadermarker: OriginalChecksum:DD808437F6B42E6E363454EE2761319A41ECF6AD6B8C98E6D90BEE0035BD6178;UpperCasedChecksum:95C78D2BBF9D864D9C511CAA8AF559C5AE5317D50B9496C91DD6800F07130E75;SizeAsReceived:12156;Count:40
x-tmn:  [mdUL3q6VltDuEEFnvTeJf4kfh9C8jeiHrbC5a0QVnbs=]
x-ms-publictraffictype: Email
x-incomingheadercount: 40
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 6bf88b25-2fff-49eb-ed0e-08d8ce7a605c
x-ms-exchange-slblob-mailprops: vJxI5U0j4N5NgHV1XdUJ85T1c/ZXG42rHacfM9fTyiWhv9sFyGkSCEIYIuocStg5+xg/m2ZweFZzx8QS/kIXjwABgPWi9T10KB6HNxu0ck6L4Gd1e784hW74yCRxTEtY/guAEcyZKnH00VYFrhegaUR4lIb0zBKPzHLbh2RgH6u7CS6OdjYXomj7C3IjA5RJt08PQnSRhGNrcN8xEtNLyih7bbJxd++CRSXQf+MyjlWfWhVtJOFT394N98Xwba8nCDtNLXUl3PuozmphOAedFeJpjlSfGAoZrKFcM2nz3WesF6/+rSEvMLhDI4JX8ISfwnYfHKNIM1s0cf9WfJZmGkYqG8s7rk1pZjerrzc21zdBaQz36pZxTi1OYeJbu9AcE7QXn/FBeBPuRTRCxQSLm+rGMvv1JajFh7UkamRdbrPZPp5fHlc59ECcFMDTBXTPbXOWKZx/A4wtE1+HRM0Ye92i92ILMGZkdO51xkw7/Xw743IRzhPjZcjsYjZCP9HT0yYUH7mFaxRI4dhBHlacENevBmeUxmTxud7xI/70YDpc9eLqTbFS6eRJpDNS+QFh8gcxcvq1W+iiqgkMl/TeDecbM27PpoKWHegI04F2Btc6zB+6xrUqLEtnk+7edLdlWh1lHIkkaVuSfjLmBniPoqP0adxgFd0wXOtiHqiGcldaSmIhlUZ+BRToN3DOj90Jw2awdYS5JOF0uHXH2kbUl4LzHZSSkTLw
x-ms-traffictypediagnostic: BL2NAM02HT146:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0pNRJcOPOVkgdgvIe4dQ1ZHLLtTNeRi3cF2bFqH/cEyhkmAyWpknP4MkrRVhMcC6QnqEki2tclhy8ymiVDs4jB0R04VcW9SZHTk6EHvuxBnNNDWIaVgNaEWt8kUkzxZz+5z4be6dke8ehhsHXa7H91rZp2Yc6d2gYRFXjw2coAONjVHjiXzJqB3ASSL7j/WIbtTiYAxSMdK1D1oOFkj5nlFA0OxV575B8D/ac2a6IK34SaQnH5Kq4IXTHCY/5U5NQ8i1CQsa37xJFo3+uycUco8vq+GrbIslscwe5Tk3pTuDuwztLB33Mp7ONG+LYsjmPM+Ve2xVDoWCXdAiPF/j7QKBft5Mkd20pAU9ffOHTcjh62D89JNPr0/F0XAChotz
x-ms-exchange-antispam-messagedata: xm/fQJoYBjT1UWDh5nzninDViIE5sHei/+7UWH143n1X0XY5OCxF0ZzGqXwSM/WyjxWE3+Slo0srH6XPraTqML6xmIS7d8IJqBCM9W3l1i1g9elni1v8FGOo3d5rvRgaQdJ0B8OwNZZ32628ajE/lg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT028.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bf88b25-2fff-49eb-ed0e-08d8ce7a605c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2021 10:47:06.9830
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2NAM02HT146
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

=0A=
=0A=
REF/PAYMENTS CODE: 09284B=0A=
AMOUNT: $3 Million USD.=0A=
ADDRESS: 3580 Ep Des Moines Iowa=0A=
Contact E-mail:   midwestheritage@citromail.hu=0A=
=0A=
=0A=
=0A=
Good Day,=0A=
=0A=
=0A=
Your payment file was submitted to our office from INTERNATIONAL MONETARY F=
UND (I.M.F) to release your long overdue payment of $3 Million USD to you.=
=0A=
=0A=
However we will open an account for you in our Bank here, and deposit the t=
otal fund into the new account, and your account and online logging details=
 will be sent to you, and you can be able to access the online and transfer=
 your fund through the online to your own bank account.=0A=
=0A=
Kindly send below information for processing.=0A=
=0A=
Your full name, address, Age, Next Of Kin, and your zip code and a copy of =
your passport photograph. As soon as we receive below information, Your Onl=
ine account will be set-up and the total fund will be deposited and you wil=
l be able to transfer from your account to any account of your choice.=0A=
=0A=
Yours in Service.=0A=
Mr. Tony S. Kaska=0A=
MIDWEST HERITAGE=0A=
BANK (C.E.O)=0A=
Contact E-mail:   midwestheritage@citromail.hu=0A=
