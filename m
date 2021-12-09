Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8204346F74B
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Dec 2021 00:15:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbhLIXTc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 9 Dec 2021 18:19:32 -0500
Received: from mail-eopbgr660052.outbound.protection.outlook.com ([40.107.66.52]:4560
        "EHLO CAN01-QB1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229760AbhLIXTa (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 9 Dec 2021 18:19:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=akLmwOiDv6wbjx9wFFt2e+nxKvHixBPcFIzcyB8/IH06G17penOH7q/HDA6Xp+Mv1RXe2k1MYDdfOoDsHPdbzuHIiStocf+zC078Qk7sRgVvAd8IaIgPKQu0dWjUhOknLofWjrqI5D+ToG0WYrAB9VPlDKesIU3VhXFFi5N2vUHXXhKK9HNsJUUbXj0vpEQenjjdQKpxgeSzv0GF9z/+YjB/puf6Cww5bymzKpgCffiUc9tc5XTI0rOzas5jQheS3A02GIP4KvFrN5t00flnK/grLan8VhaNH6RkEBkZHGe2Dlv88UBol5olCRl7iWRY2t7z5pzXYHmEy4I2JOcLUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OSNFc4aOJBxIUIwtHBZwt9zv2Wa8gnWnhU0roFl9TMs=;
 b=ZSLABYb+fzuHuupThUZKBaQ8eZEMGIcg9mG83I0MH3VjfoMyMB4YmSHHHKqq/mbsEbvqTFwPZL1OfE4GeJx6QpRxu0ITUEJiP8XpJn+Li6Ae/5BpLBwx3+hekfXhkA1sSD6rEW6yua9M4KBMKFdWDDhGxpXlIgPXUWMBxu+l1s+Fgxt4UhMGjaBf8QKXSWHhF/V5Z0j9LHatMwEDn1+WaxJ408AjNA92ovcJlPhpftcYvCd0n9WXt8zCou/kZWV3OYLOyXP51w0j1E3tSIhZAPMMMdkFx7PHSdgLm6IPs6z/cItcQhCXag6e920+4wxYmWNUMsCAqCIJ3g8gQHxkEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uoguelph.ca; dmarc=pass action=none header.from=uoguelph.ca;
 dkim=pass header.d=uoguelph.ca; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uoguelph.ca;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OSNFc4aOJBxIUIwtHBZwt9zv2Wa8gnWnhU0roFl9TMs=;
 b=Cv4k8DIa/EpVRaq96JVbG48BBoV/SnlGjlaq/zq5K/KIm2Z4pvzddE74vVNS48Tu2O0CZXccE49HJKf+QyNaCatNr7pcBXKo3gxe2O3m50mbC/Pw2EmtXoBRGWBCNv8QvZbrvyjci5ZtLc3BQe+HahUIn9DFhkE5Fci0NKKP6O12GpdE0fBF2oXWJcmsrEA40DK0zG9AS7RotcKSWuTOu853sQDeMmstaZVImakZs4gHVvwNXacLNFXZ/0/SfC21UxbDgqY6f4tUyTgswysLsn8XG7+IwdIMfy3Qz23i7rqt1D1Db3svtVy+e6XqIPSyNxZ5NBeM/EWe36F/TSOZ2A==
Received: from YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:19::29) by YQXPR01MB2485.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:42::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Thu, 9 Dec
 2021 23:15:54 +0000
Received: from YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::e56f:b7a2:3830:5706]) by YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::e56f:b7a2:3830:5706%3]) with mapi id 15.20.4755.022; Thu, 9 Dec 2021
 23:15:54 +0000
From:   Rick Macklem <rmacklem@uoguelph.ca>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: knfsd server returns writeverf of all 0 bits (but was not rebooted)
Thread-Topic: knfsd server returns writeverf of all 0 bits (but was not
 rebooted)
Thread-Index: AQHX7VIEQoc8yG9ZVUucpKOORDcyug==
Date:   Thu, 9 Dec 2021 23:15:54 +0000
Message-ID: <YQXPR0101MB09686CB60B96426316F4252ADD709@YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: b552a280-fc9e-7e8d-f6e6-9f3b11b55fce
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uoguelph.ca;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f3c3c50e-b71d-42ab-f243-08d9bb69d9b7
x-ms-traffictypediagnostic: YQXPR01MB2485:EE_
x-microsoft-antispam-prvs: <YQXPR01MB24859AFD425B64DAB71874F6DD709@YQXPR01MB2485.CANPRD01.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gNvRaf49IA3k07YXYOxF9cNhmibpn7RTYym+fQbvnuXI5nv88K6ha8fBLoim3y5e3QLIq8ToCPVJjm7II8lVbPdDsgSfcu4E26YmxB7VWNQOv1BWB+p/y6taAGVMluVh5chwIXszFY2qAQu/D4GiNBtHv1lzNike9B9uKL1tdMnCeF77G2rfo3aXURAGW+dTQC+DfhBW+wiL60FPaX9H2hf9lFHDG/9ZajR/kmZ4bvc+xEWEMvzzNNlQ8ue3PcRaCfURIYQpksQKmKdpVS1pyTJAj0Sa+VeaXgvxJZFiMBdEkrt8IeHqJ3tjPMOwPBso9t5SDdL373MOwDPezDveKjN/GfSRHj1uhrTBCjRFzm/3QQV6fYDEUugIW0CSoSShTgmF/i5Lc7VW0ffaKEvSeg4GzZFtKJy7G1aAZFIgRM8oTkSF3DmbIlYb2hA0i29isQQosoATL2dbVrHB0sIkZoDKMuPHdSJGrC7RX9g9BzhDhB8fIIhH/w+KcQrNvKWSS1rvLAYvOK///bZlhxsHiyAvYwEUYS6vI9Rqk5gn35iIgk1emHOFjg3A+aOmzx1dDhaAfsBH34FHLAYP6t/Hjs98XfvPoANjZCsaZI3RdIV476K+JYtBaa9yyLuYJir/klU0xPE62BcipP9R3zothIj2F3PD7U/qxMDT1ss7saNF9QBemNbf+oJf300knnd7IsH2Uhx0vTNCFMYAUsCKxw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(86362001)(55016003)(64756008)(66556008)(122000001)(8936002)(66476007)(66946007)(6506007)(5660300002)(508600001)(66446008)(6916009)(91956017)(76116006)(71200400001)(38100700002)(2906002)(9686003)(8676002)(316002)(38070700005)(786003)(7696005)(186003)(4744005)(33656002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?gYw67sz6gz8Ha80/5YSzoyWMOkAn+Nlrt43i6zZ/g1KbUUuqIPrfpsueww?=
 =?iso-8859-1?Q?Oe4LUKJiZneVVBSBy1RrTdJ4oKVHXn17nZe3lm0ER5Kjos+Rsgg+Ws5zzW?=
 =?iso-8859-1?Q?HkETPZdjeB0ICcWnNN6U1Wu+GHV/38mJKTvENvSxekeo2W7jKs7mruWEQm?=
 =?iso-8859-1?Q?0uCA8DgFLaxrcKfZbfZk/qN2rXbjQ5M0iA6W28EyHr9XlkZxCOlaccME1j?=
 =?iso-8859-1?Q?uebK6SD2/lnLgsdO5Z4uI8N+JIG6GB98AuiOwWMyzoM5bX4FS4FeLNoVJK?=
 =?iso-8859-1?Q?63gil3LlZiB1u7E/3Hvi1SkqVqHgnNUGJnUCdBrWlDgmC2LgZIiYW4ldRA?=
 =?iso-8859-1?Q?/DtKdohsxrZQk6TGtiguUw06S85HpeeMDkMf0pv1H9B8ld8MgFT9U+Kxds?=
 =?iso-8859-1?Q?zayYj4erRf1VkVkySiriIYrltoVyX12oWwqW5aVRByqTAmUFMNtwULTo3u?=
 =?iso-8859-1?Q?xa42aoncuZRLtBnyEg1gM7Sjct88+mQI4Xlwm2s7VCDc+9yl1bEv2BCr6G?=
 =?iso-8859-1?Q?yuTexYgh+bl81aB6NVzyqvE7flbDx2fDTC7Is6tFHOyN1yY83Y/GjMw/0Q?=
 =?iso-8859-1?Q?QFMc5ccucFeB6oCJEfjJto369mZZx03OA2aJt73oT2vDo71kU3Ms2LF8cC?=
 =?iso-8859-1?Q?2JG1nWmuqoLeXo1ZZQQarW3Q93IEZbpoeocdUXX5Z1GpYAYQLU/MARjxDp?=
 =?iso-8859-1?Q?lsAQCD6xOz36XP9+x9S1EWs018kMnw7H896+nb2qslGljK2k+J+3laXfpG?=
 =?iso-8859-1?Q?Da7rNcSwvGT27AvC77ywPmkHJi88NHj2HM2GsX/yi7TLHnWz87DA6EKtce?=
 =?iso-8859-1?Q?mrMmFQ3CDaOzVYIDGGWeO5pwkG0jXj5Qmb3mZB6tDXAR8efmmUJxB9OH+E?=
 =?iso-8859-1?Q?bEOBPPG2hAaOqrEtZeEkDcZW8R7dye3i2gbgUg/WrG3PFIYJZedxlKumWg?=
 =?iso-8859-1?Q?zTDTDJiho8ivwORmr76rYT6h4Y/iCh4jw7h0LmxHsBn2k+FZWuFcsutTKM?=
 =?iso-8859-1?Q?IpofRVfsRQTPjgcpGpnojNc5m7fvk5BIr2uPfxJFaOm504XB8b7vyiqrQg?=
 =?iso-8859-1?Q?nVnJ0+UhXLWMElk9C53pCKtayEOdi3iwXH8W+eMSIN5I9uPQJJ8QhSzoK4?=
 =?iso-8859-1?Q?4skUmkI9hKMnRj34hcKfXBoIoFaeNOB13uxTWCi4P9WtO2gJhd3kduxZsJ?=
 =?iso-8859-1?Q?bY3g/6xKmiBm0igTs9Kgq+wweCto4uRwCojaAAearpTroOZ7JQpFEaUEee?=
 =?iso-8859-1?Q?D2qowv5ktEUpYaeKdNrDo8jxDJuz4FzVELSjlFON4sgrtvuenjgaLNZmQl?=
 =?iso-8859-1?Q?ogSMe5p0ukVcrzmie2l30jTODt6GqyxaGfa/CFxD1tNx749n89G8+zileD?=
 =?iso-8859-1?Q?/mJG07fZk+Sjb8pWbycZyAi/uBvEmBMrT7duVY7FmFBYmEDV1aS5YDZ71v?=
 =?iso-8859-1?Q?uINGorvr6QSXIec1gTKCExdb18tJMn4PRzXlM+yN3uusoScISj+KomSMfY?=
 =?iso-8859-1?Q?PR2o+Ce0GKsX/ulvrreqjGr6FA9f87dlhgQCm7fksffryuIerWAtX3YWmq?=
 =?iso-8859-1?Q?KcSI+OlVBYmCqUFVkQfybAmCo+roNSGp05FNPwliq3IThtfU6bz+jtnQA3?=
 =?iso-8859-1?Q?8LN073B9g4AXCntqm1T9cbsEcZ9FkvVF/FQolk5C4mO9DhxX8D3vUSoHtW?=
 =?iso-8859-1?Q?VNJ3P+fNPlhF2wZdUcnTTeS8b6yEmQZ+cz13M6guvaM1xQIci3gni9v0fw?=
 =?iso-8859-1?Q?Nj/A=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: uoguelph.ca
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f3c3c50e-b71d-42ab-f243-08d9bb69d9b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2021 23:15:54.7757
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: be62a12b-2cad-49a1-a5fa-85f4f3156a7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ViJtuD4NGybv4nIjM1zljK1JxM6PVUTEBLLfp9AP9wBQ/7RmedR7MBbvI6iPlBi+32bc2zEeDzLay8bUjJ2Drw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQXPR01MB2485
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,=0A=
=0A=
When testing against the knfsd in a Linux 5.15.1 kernel, I received a=0A=
write reply with FILE_SYNC and a writeverf of all 0 bytes.=0A=
(Previous write verifiers were not all 0 bytes.)=0A=
=0A=
The server seemed to be functioning normally and had not rebooted.=0A=
=0A=
Is this intended behaviour?=0A=
=0A=
Normally I would not expect the writeverf in a Write operation reply=0A=
to change unless the server had rebooted, but I can see there might=0A=
be circumstances where the knfsd server wants all non-FILE_SYNC=0A=
writes to be redone by the client and would choose to change the=0A=
writeverf.=0A=
However, changing it to all 0 bytes seems particularly odd?=0A=
=0A=
rick=
