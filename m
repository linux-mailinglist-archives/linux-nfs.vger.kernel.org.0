Return-Path: <linux-nfs+bounces-10253-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C154DA3F699
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Feb 2025 14:57:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AE91170338
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Feb 2025 13:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F876192B74;
	Fri, 21 Feb 2025 13:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aixigo.com header.i=@aixigo.com header.b="PKupf5oF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11021105.outbound.protection.outlook.com [52.101.65.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A5E204C00
	for <linux-nfs@vger.kernel.org>; Fri, 21 Feb 2025 13:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740146273; cv=fail; b=i5kHwWSAlkXtMls2qBu4hgyqF0mSK4u987KI8JRWMdjZ6yKfmnicZ9i4j/zmeHe2qhvjmyBL2BnnkLUcygN63JIn2ljL9z9pEdzhQTVMu8XLX90IWNUAVVJf2OKY2JLOYjUvFWXzL5WRBZOxnLK3U6oVsuVYyIQ3Z5iex4XkJkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740146273; c=relaxed/simple;
	bh=5GMdlIvDlp4n7zFGNgUBGucqLgXQtnEAcqzfsUCQfCo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=R7/x2YdNEJvI/VWST5doMlQRtAbL2xZi26pgZixXqNbvcs6tnri/KICxuGhjeHo3xVbX9AEUn2rDV6KCwxaMm9I098zCWM9gbqatgsGm6f2t1VMVPq9MXMgfkDx7/Ep4WOVq432GbwJhuoDdhvvQ8KQr9qKnmAQFsbdG5fAZk20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aixigo.com; spf=pass smtp.mailfrom=aixigo.com; dkim=pass (1024-bit key) header.d=aixigo.com header.i=@aixigo.com header.b=PKupf5oF; arc=fail smtp.client-ip=52.101.65.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aixigo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aixigo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lGBMnPaZVs/mD/k7Iox/iHd2BE7lB4m3xxixRaZQC6kRfPWXHGVzmBq6KQxGtMZHJXWXWPpNkD0neYOIYEHOxCrjLHtyON2nTkIwh0f1/P9uuHfrHyXdQNCIAFbNkdhfQbePtJfSXh/pMFhq/ACMQDih/HUEkAhRfW8vXxnodfDLjXHMko4Fc6JJVRI7MUc7H6oCRv0dYvo3GXvLPG8Lre6gvfAuRlhFyET3I0gyslg7lQ8l2hQ2IFaRkh6HX/+MFvYb6zv+4oz3EI8juvXdiP3txreokJHbAzwlGxtaRcc3LtLsNTwZtI6v+VYUrn62yeYsNL6FGJ0knf0mWAqKvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ksgTXQrWbdYZf3Amo8IO1Q+9sQGYtTlUPVD5fo+fzT4=;
 b=jTNxghtW2JV+nL+YuEMJ79vbG3vEeXQDggZ/1wDU0NcDMh4gOGCqp8S5bx2eS1yBI+1IDL4MwVpZSvEjK45y0/dDvIN5v9bFB76UGpCYlAq8atS6wrYOkqOiYWMvusgaOxPQmhMTDXCHlqHi5CQFMpYUP+PFqGtClzLd/JFylBMiRaFiUaXqjIka0uv0SoVQvV+FWmRe6dkTxOl1cEfJU5cMsMLV70MTs5y8/HCI7wi4Hc4YT0MejmHuv3f9OYCuTmshogbtGIUn4mXlsDKr3nWyk3y2NGxtrNx0MDedixDri+PG9wzYShBdnqeJgykeFEfDoGMpoMxWfFfs1Xycqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aixigo.com; dmarc=pass action=none header.from=aixigo.com;
 dkim=pass header.d=aixigo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aixigo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ksgTXQrWbdYZf3Amo8IO1Q+9sQGYtTlUPVD5fo+fzT4=;
 b=PKupf5oFRDtg1WMsz3HmTi4ArrWKnb/C2ubxqSwcYsk9YjknuHFdoskj4yCL/Zz95SAxFYuajjahradKUxpWGA5WAoDNZbIUHedtb7WlYHJ2j0xjxDCLEVgeCPmBR/J8crhUXb53ScQk7i7s2bv7pvWRlgQsA21+bH36yFQHS60=
Received: from PR3PR01MB6972.eurprd01.prod.exchangelabs.com
 (2603:10a6:102:70::22) by PA4PR01MB7551.eurprd01.prod.exchangelabs.com
 (2603:10a6:102:b9::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Fri, 21 Feb
 2025 13:57:47 +0000
Received: from PR3PR01MB6972.eurprd01.prod.exchangelabs.com
 ([fe80::77f5:5399:c3e8:ea7e]) by PR3PR01MB6972.eurprd01.prod.exchangelabs.com
 ([fe80::77f5:5399:c3e8:ea7e%4]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 13:57:47 +0000
From: Harald Dunkel <harald.dunkel@aixigo.com>
To: Salvatore Bonaccorso <carnil@debian.org>, Baptiste PELLEGRIN via Bugspray
 Bot <bugbot@kernel.org>
CC: "anna@kernel.org" <anna@kernel.org>, "jlayton@kernel.org"
	<jlayton@kernel.org>, "cel@kernel.org" <cel@kernel.org>,
	"herzog@phys.ethz.ch" <herzog@phys.ethz.ch>, "tom@talpey.com"
	<tom@talpey.com>, "trondmy@kernel.org" <trondmy@kernel.org>,
	"benoit.gschwind@minesparis.psl.eu" <benoit.gschwind@minesparis.psl.eu>,
	"baptiste.pellegrin@ac-grenoble.fr" <baptiste.pellegrin@ac-grenoble.fr>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: NFSD threads hang when destroying a session or client ID
Thread-Topic: NFSD threads hang when destroying a session or client ID
Thread-Index: AQHbe7QVvE1kcGnjskG+SpPDJPr0pLNR1aGAgAABZoo=
Date: Fri, 21 Feb 2025 13:57:47 +0000
Message-ID:
 <PR3PR01MB69723701495481CCA7D55F0585C72@PR3PR01MB6972.eurprd01.prod.exchangelabs.com>
References: <20250120-b219710c0-da932078cddb@bugzilla.kernel.org>
 <20250210-b219710c28-43a3ff2e1add@bugzilla.kernel.org>
 <Z7iC42RF-7Qj2s4d@eldamar.lan>
In-Reply-To: <Z7iC42RF-7Qj2s4d@eldamar.lan>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aixigo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PR3PR01MB6972:EE_|PA4PR01MB7551:EE_
x-ms-office365-filtering-correlation-id: 50587ca3-8378-485d-b339-08dd527fb918
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|7416014|10070799003|366016|7053199007|4013099003|4053099003|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ZYp6xN+icEjx4rkgBHn0J1Bre97SLA1hwtOnG1hSbrHb46alTEerEAU0Kta3?=
 =?us-ascii?Q?kT12ou4EI2qC9DJcaTBq+ExWxNNlnRGSxG5ewCAA3xo3AcOhfdp0bDtgwEW4?=
 =?us-ascii?Q?aPeYlVu2RPL0Gj7ZnNkLYcNpTdj/YJGOVWuw+Weum5RfkazZWAaYv/NlBy7R?=
 =?us-ascii?Q?j6YIND1w4AwLM7eLM140oH73/ifrjiuyASBPMSqSmV45/yRyLS3he1iYQ0Kn?=
 =?us-ascii?Q?3vpOMaV0E3oMJodH2DJJrLgrbAAyzUOfOBnW4RCV8LcOFd2g3c2nNIOKY8rD?=
 =?us-ascii?Q?Y7H4qyV47ttjw9ehmnooTdmgW1Qsk1DylY1wh5eYKf5a4pE/NOogeO6AhtYN?=
 =?us-ascii?Q?df+6gg+HWNPmNTzgY6W0fq+NJI6fxrLxdFm9JBPLpJIrsE259a6oqAEhFEaI?=
 =?us-ascii?Q?ZYple/U1h31CnzdNKgnNo16N/XBBvFPWZq3b6Ypvd06Zp4TtbfFz7Ue29ZXs?=
 =?us-ascii?Q?TkLCJaTJrJLvK2plgAlkk2EvzJIhCajoQXB73Ixq/lduKmKlMX5JU6FnmmPp?=
 =?us-ascii?Q?fWRVEFX5e7Yez9TFJgKzcVYs5jDRjMs42c4ks38miWqmkp48eUvZ7UFcaIPV?=
 =?us-ascii?Q?Qd7WdqhMX22IcHbcCyVWg8MdQHokNaXDkd+9pRbqd1jHm22rhQcimfofcqXL?=
 =?us-ascii?Q?UITg03LQoHZb51Ra21n/44bTg/R5Ecw5KJWVDPBE53ej3DsJhizO4UPUMdtb?=
 =?us-ascii?Q?7mbWlkRHqTNkqd0qQ7ZuhZiYgpLqzZDTXv5PKE/54WWTEdlcizlripYpNbWw?=
 =?us-ascii?Q?E/3Lg6joIDbC3egA20Dh0BJ3njmuceDg4cfKENHUWL5W3esn5nJYslx5keqr?=
 =?us-ascii?Q?EMcT1oa6mXkFbDSulypOI6C2EZ31dmIuvni/MqRRYNOZMAEJwbBvgyX5bd7S?=
 =?us-ascii?Q?AnnKtPEhPdJpoIUhpGufr4nSLyWHoirRbPHJwH9wFowKyNUdDq0XD7AAgOWX?=
 =?us-ascii?Q?FujTT+EeE9fLCovOlbIvfoshfK+lFeaYNLZ6iW+yrGciNdQCpXBVzDlxBJlG?=
 =?us-ascii?Q?oOLwPwoC9zdV65GiWTJOPokOyTKNfmXPjik8lpntfWCInE4N+ruRHwUsVV7o?=
 =?us-ascii?Q?raLqL/8Iyj4IJ9ILIIlkAWdnn6JfakRyV6Dy1OF1zJ9VvbOW1/L/o5zGQ4XS?=
 =?us-ascii?Q?qbVsvyLcxcQICoBHiuLZtjXtXP+KWmBIFUKOdRZgg/9MntcEfRhzndbOi/P7?=
 =?us-ascii?Q?7MCGf1jrjmQlVPavwCxR8B/8Ei8leDE3lrQV0rkL+URdbbpkoQ4hgBuDeIG4?=
 =?us-ascii?Q?q6i+R48PWSzb0/aTyMzqt9gbN7cCqIqf53zq41ltznJCGlQKCc0V18l0yenG?=
 =?us-ascii?Q?pm+tiNKqcuFJp6j1O0YIgKVvVnRlnURB+dsj0IXF6mc3YaABicBEeQX0bunJ?=
 =?us-ascii?Q?7L9Y3OK9KdXwHpkpUhkpHhM4z59jcTRXz1pZRm4pWlU6Pc0Qxw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR01MB6972.eurprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(10070799003)(366016)(7053199007)(4013099003)(4053099003)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?hnfwf16JlsFMqvKF2zfWR0K1kEL5qJPxjpGbFiXbYSQP6F1+0HDjNQFbm1lm?=
 =?us-ascii?Q?OZsmKPFuN5NBUt6TFUOOnMRe05w7On2fD2nASdvhSHoUKlW1oA8s428aMhIN?=
 =?us-ascii?Q?2Me9R67b0gjN6GWCaojM2jpQ3UjuvKeDgUVpPk7jmfyxP38S0nYFqumerEFZ?=
 =?us-ascii?Q?E4fAN96BHGAE/VWmtVJF9NhoEcB1Ty5LrfsJb2OYzHsgP8OwJwJ8cKIhtU5h?=
 =?us-ascii?Q?CK91lMMj7mzKC24qYAcARtyxu9YkY+uLBXaey02YBTasSvjzWIpkRUzIh3fU?=
 =?us-ascii?Q?rXw1gR3oV2q83LQcel7RX5slGyvKcCXTlN3DvMu0XaKTaZAEXucsF1yrZVDm?=
 =?us-ascii?Q?3zDV9E0gQX3DNN/ImLDXMouAMP/S7klVsar1EvQF+pnLTFzv8D1ZNenXvPcV?=
 =?us-ascii?Q?QliKxL9PIhdsB5EfF7xvfPg7ZVThE6KFJPQVwoCgo+SbiMH9BM/uqXcV+XI8?=
 =?us-ascii?Q?shH0TaZI/eR4xLFEvEVT/HKOj5a5CK8QcUs4QbrR9lKSHOp+vJLi52ZTpKym?=
 =?us-ascii?Q?o3S4v4hh4X2WbAvzX3xJZ5pKd3LlSnQ7Tx399XTIbsomk+Pum0iXGEv3Pb//?=
 =?us-ascii?Q?T37pyavKBmM332z1U/QN7pSODj1Enxmz46Z9W2yWzzKaAuyhcCgQLrdt7Mua?=
 =?us-ascii?Q?a1iWOvq9v+jvItHtZ8ps2KUZex5QT1AkvSMXuzgsHvRmrMIuGvBeR4onAbAU?=
 =?us-ascii?Q?oeQFXbqK7w8ry17DZzK5+m4Ex2mJLBJpab/QC/rZzE+B8J6qcI1Bx7yyPAkc?=
 =?us-ascii?Q?5S+ivIWz4J/ySuW5cdyp3+va7B2UzG8SrM++e14Ukckq3HWasWqUORt3B6Pq?=
 =?us-ascii?Q?XTDjMGDyogwgnmOuKi5YdrWEYaT0ZjFoOazisLBxihF2rxH2V/RQItBTO3nV?=
 =?us-ascii?Q?nee00tV1IUn1MMrGTaPcK4WjzZZUON0vOi1lBA03RrdgHyPYHH4gmRkzY/6s?=
 =?us-ascii?Q?XE/vqYdpsa7kWNgM8P4D4tptsZ95eeq2e63e3dyD7d0hFB5TgtZNOJnPqTY5?=
 =?us-ascii?Q?lIPWwFPL1/9SvaZcpnUMI8UAoSS2zVCVHZY62idLjwL/yN2e5mW9XtZZAKRf?=
 =?us-ascii?Q?EwalSoaPDmY/231zy10m8GNh5vDKA4Fu22X/SQW6wsxTWdIDGoqtBzENPlZm?=
 =?us-ascii?Q?K0fiykMs66ymmPjQjz3JkPbgKLddyINym2H2VRWQzBHBMI2FBZd9iD2OXYDh?=
 =?us-ascii?Q?4hsYSos6pIG2rtYX7SfO3QTxo69PMW0wrftAkv52qZVTuxtghTK9/84zvofr?=
 =?us-ascii?Q?l6hfpOKABr9GOqccRnBXcNUBAnCJ5pV7lZQi7x6h1lPTDUoaNrx3z2DzkHa0?=
 =?us-ascii?Q?IOig2ClkhcWSBc4D56Gw4kRhMF5GsZr4ChV3IEtDPqp+myGXJ3LVUyLABqwR?=
 =?us-ascii?Q?wCZcgnS9D1KOcedb4mjkmMIXlm9uzJpQKU5cilDn/pMCPrpBbRy7cDH/u6oM?=
 =?us-ascii?Q?sztOuFMCAfA5mewDRnbArcj1xPCLXMYLT2B8dS0OqA7VNtJExjDW1kuAr9Gr?=
 =?us-ascii?Q?4WqjbmPOLHhT2NY5xHXBJaBmtgiXtWuqtTZ5kRipNYUr7LaJJJa+hNGP/4Dw?=
 =?us-ascii?Q?hSdaQRUoxGccXD99kuPx4yHYZ50uWDKx0zEoirKNxeAukgoc8dDT1KJjXonb?=
 =?us-ascii?Q?pQ=3D=3D?=
Content-Type: multipart/mixed;
	boundary="_002_PR3PR01MB69723701495481CCA7D55F0585C72PR3PR01MB6972eurp_"
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aixigo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PR3PR01MB6972.eurprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50587ca3-8378-485d-b339-08dd527fb918
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2025 13:57:47.5666
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d1ea0a64-8cea-4700-8ee8-f34fa4bcf2b6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q7pH8XXeAe0Z9INcDgoWld+jSVxPTqzr6i0p2Wkt3WusEUCUK/iusXszvZSVOn/DhW+fGzx5vmMjPnjdD5Tz1tTufgBzKRXaztL7UbfU4zI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR01MB7551

--_002_PR3PR01MB69723701495481CCA7D55F0585C72PR3PR01MB6972eurp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi folks,

I don't like to bring bad news, but yesterday I had a problem with kernel 6=
.12.9 (twice), see attachment. AFAIK 6.12.9 is supposed to include 961b4b5e=
86bf56a2e4b567f81682defa5cba957e and 8626664c87eebb21a40d4924b2f244a1f56d88=
06.

Regards
Harri

________________________________________
From: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com> on behalf of Sa=
lvatore Bonaccorso <carnil@debian.org>
Sent: Friday, February 21, 2025 14:42
To: Baptiste PELLEGRIN via Bugspray Bot
Cc: anna@kernel.org; jlayton@kernel.org; cel@kernel.org; herzog@phys.ethz.c=
h; tom@talpey.com; trondmy@kernel.org; benoit.gschwind@minesparis.psl.eu; b=
aptiste.pellegrin@ac-grenoble.fr; linux-nfs@vger.kernel.org; Harald Dunkel;=
 chuck.lever@oracle.com
Subject: Re: NFSD threads hang when destroying a session or client ID

Hi,

On Mon, Feb 10, 2025 at 12:05:32PM +0000, Baptiste PELLEGRIN via Bugspray B=
ot wrote:
> Baptiste PELLEGRIN writes via Kernel.org Bugzilla:
>
> Hello.
>
> Good news for 6.1 kernels.
>
> With these patches applied :
>
> 8626664c87ee NFSD: Replace dprintks in nfsd4_cb_sequence_done()
> 961b4b5e86bf NFSD: Reset cb_seq_status after NFS4ERR_DELAY
>
> No hangs anymore for me since more than two weeks of server uptime. And p=
reviously the hangs occurred every weeks.
>
> I just see some suspicious server load maybe caused by the send of RPC_RE=
CALL_ANY to shutdown/suspended/courtesy clients.
>
> I see a lot of work on the list that try to address these problems :
>
> nfsd: eliminate special handling of NFS4ERR_SEQ_MISORDERED
> nfsd: handle NFS4ERR_BADSLOT on CB_SEQUENCE better
> nfsd: when CB_SEQUENCE gets ESERVERFAULT don't increment seq_nr
> nfsd: only check RPC_SIGNALLED() when restarting rpc_task
> nfsd: always release slot when requeueing callback
> nfsd: lift NFSv4.0 handling out of nfsd4_cb_sequence_done()
> nfsd: prepare nfsd4_cb_sequence_done() for error handling rework
>
> NFSD: Skip sending CB_RECALL_ANY when the backchannel isn't up
>
> NFSD: fix hang in nfsd4_shutdown_callback

So I see the backport of 961b4b5e86bf NFSD: Reset cb_seq_status after
NFS4ERR_DELAY landed in the just released 6.1.129 stable version.

Do we consider this to be sufficient to have stabilized the situation
about this issue? (I do  realize much other work has dne as well which
partially has flown down to stable series already).

This reply is mainly in focus of https://bugs.debian.org/1071562

Regards,
Salvatore
District Court Aachen - HRB 8057
Management Board: Arnaud Picut (CEO), Hicham El Bonne (CTO)
Chairman of the Supervisory Board: Benjamin Carl Lucas

--_002_PR3PR01MB69723701495481CCA7D55F0585C72PR3PR01MB6972eurp_
Content-Type: application/octet-stream; name="x2"
Content-Description: x2
Content-Disposition: attachment; filename="x2"; size=6348;
	creation-date="Fri, 21 Feb 2025 13:55:09 GMT";
	modification-date="Fri, 21 Feb 2025 13:55:09 GMT"
Content-Transfer-Encoding: base64

MjAyNS0wMi0yMFQxNTo0NTowOS42NTgyMDgrMDE6MDAgc3J2bDA1NiBrZXJuZWw6IFsgIDg1MS41
MjU1NTNdIC0tLS0tLS0tLS0tLVsgY3V0IGhlcmUgXS0tLS0tLS0tLS0tLQoyMDI1LTAyLTIwVDE1
OjQ1OjA5LjY1ODIyOSswMTowMCBzcnZsMDU2IGtlcm5lbDogWyAgODUxLjUzMDg3NF0gY2Jfc3Rh
dHVzPS01MjEgdGtfc3RhdHVzPS0xMDAzNgoyMDI1LTAyLTIwVDE1OjQ1OjA5LjY1ODIzMiswMTow
MCBzcnZsMDU2IGtlcm5lbDogWyAgODUxLjUzMDkyMl0gV0FSTklORzogQ1BVOiAyIFBJRDogMTM2
NCBhdCBmcy9uZnNkL25mczRjYWxsYmFjay5jOjEzMzkgbmZzZDRfY2JfZG9uZSsweDRlNS8weDU1
MCBbbmZzZF0KMjAyNS0wMi0yMFQxNTo0NTowOS43Njk1MjcrMDE6MDAgc3J2bDA1NiBrZXJuZWw6
IFsgIDg1MS41NDYzNDNdIE1vZHVsZXMgbGlua2VkIGluOiBycGNzZWNfZ3NzX2tyYjUgdGFyZ2V0
X2NvcmVfdXNlciB1aW8gdGFyZ2V0X2NvcmVfcHNjc2kgdGFyZ2V0X2NvcmVfZmlsZSB0YXJnZXRf
Y29yZV9pYmxvY2sgaXNjc2lfdGFyZ2V0X21vZCB0YXJnZXRfY29yZV9tb2QgbnZtZV9mYWJyaWNz
IG52bWVfa2V5cmluZyBudm1lX2NvcmUgbnZtZV9hdXRoIGJpbmZtdF9taXNjIG5sc19hc2NpaSBu
bHNfY3A0MzcgdmZhdCBmYXQgaW50ZWxfcmFwbF9tc3IgaW50ZWxfcmFwbF9jb21tb24gaW50ZWxf
dW5jb3JlX2ZyZXF1ZW5jeSBpbnRlbF91bmNvcmVfZnJlcXVlbmN5X2NvbW1vbiB4ODZfcGtnX3Rl
bXBfdGhlcm1hbCBpbnRlbF9wb3dlcmNsYW1wIGNvcmV0ZW1wIHBwZGV2IGpjNDIgcmFwbCBpbnRl
bF9jc3RhdGUgaVRDT193ZHQgaW50ZWxfcG1jX2J4dCBpbnRlbF91bmNvcmUgbWVpX21lIHBjc3Br
ciBlZTEwMDQgaVRDT192ZW5kb3Jfc3VwcG9ydCBwYXJwb3J0X3BjIHdhdGNoZG9nIGludGVsX3dt
aV90aHVuZGVyYm9sdCBpbnRlbF9wY2hfdGhlcm1hbCBtZWkgcGFycG9ydCBpbnRlbF9wbWNfY29y
ZSBpZTMxMjAwX2VkYWMgaW50ZWxfdnNlYyBpbnRlbF92YnRuIGpveWRldiBldmRldiBzZyBzcGFy
c2Vfa2V5bWFwIHBtdF90ZWxlbWV0cnkgcG10X2NsYXNzIGlwbWlfc3NpZiBhY3BpX3Bvd2VyX21l
dGVyIGFjcGlfcGFkIGJ1dHRvbiBhY3BpX2lwbWkgaXBtaV9zaSBpcG1pX2RldmludGYgaXBtaV9t
c2doYW5kbGVyIGxvb3AgZHJtIGVmaV9wc3RvcmUgbmZzZCBjb25maWdmcyBuZnNfYWNsIGxvY2tk
IGdyYWNlIGF1dGhfcnBjZ3NzIHN1bnJwYyBpcF90YWJsZXMgeF90YWJsZXMgYXV0b2ZzNCBleHQ0
IGNyYzE2IG1iY2FjaGUgamJkMiBidHJmcyBibGFrZTJiX2dlbmVyaWMgZWZpdmFyZnMgcmFpZDEw
IHJhaWQ0NTYgYXN5bmNfcmFpZDZfcmVjb3YgYXN5bmNfbWVtY3B5IGFzeW5jX3BxIGFzeW5jX3hv
ciBhc3luY190eCB4b3IgcmFpZDZfcHEgbGliY3JjMzJjIGNyYzMyY19nZW5lcmljIHJhaWQxIHJh
aWQwIG1kX21vZAoyMDI1LTAyLTIwVDE1OjQ1OjA5LjgwMzU0OSswMTowMCBzcnZsMDU2IGtlcm5l
bDogWyAgODUxLjU0NjUzMF0gIGRtX21vZCBoaWRfZ2VuZXJpYyB1c2JoaWQgaGlkIHNkX21vZCBh
aGNpIGxpYmFoY2kgeGhjaV9wY2kgY3JjdDEwZGlmX3BjbG11bCBjcmMzMl9wY2xtdWwgeGhjaV9o
Y2QgY3JjMzJjX2ludGVsIGxpYmF0YSBtZWdhcmFpZF9zYXMgZ2hhc2hfY2xtdWxuaV9pbnRlbCB1
c2Jjb3JlIHNjc2lfbW9kIGlnYiBzaGE1MTJfc3NzZTMgc2hhMjU2X3Nzc2UzIGkyY19pODAxIGky
Y19hbGdvX2JpdCBpMmNfc21idXMgc2hhMV9zc3NlMyB1c2JfY29tbW9uIGRjYSBzY3NpX2NvbW1v
biBmYW4gdmlkZW8gYmF0dGVyeSB3bWkgYWVzbmlfaW50ZWwgZ2YxMjhtdWwgY3J5cHRvX3NpbWQg
Y3J5cHRkCjIwMjUtMDItMjBUMTU6NDU6MDkuODE1MTU5KzAxOjAwIHNydmwwNTYga2VybmVsOiBb
ICA4NTEuNjgxMzc2XSBDUFU6IDIgVUlEOiAwIFBJRDogMTM2NCBDb21tOiBrd29ya2VyL3UzMjox
IE5vdCB0YWludGVkIDYuMTIuOSticG8tYW1kNjQgIzEgIERlYmlhbiA2LjEyLjktMX5icG8xMisx
CjIwMjUtMDItMjBUMTU6NDU6MDkuODI2Nzk1KzAxOjAwIHNydmwwNTYga2VybmVsOiBbICA4NTEu
NjkyODk1XSBIYXJkd2FyZSBuYW1lOiBJbnRlbCBDb3Jwb3JhdGlvbiBTMTIwMFNQL1MxMjAwU1As
IEJJT1MgUzEyMDBTUC44NkIuMDMuMDEuMDA0OS4wNjAxMjAyMDA1MTYgMDYvMDEvMjAyMAoyMDI1
LTAyLTIwVDE1OjQ1OjA5LjgzMzA1NCswMTowMCBzcnZsMDU2IGtlcm5lbDogWyAgODUxLjcwNDU1
Ml0gV29ya3F1ZXVlOiBycGNpb2QgcnBjX2FzeW5jX3NjaGVkdWxlIFtzdW5ycGNdCjIwMjUtMDIt
MjBUMTU6NDU6MDkuODM5MDE5KzAxOjAwIHNydmwwNTYga2VybmVsOiBbICA4NTEuNzEwNzgzXSBS
SVA6IDAwMTA6bmZzZDRfY2JfZG9uZSsweDRlNS8weDU1MCBbbmZzZF0KMjAyNS0wMi0yMFQxNTo0
NTowOS44NjAxMjErMDE6MDAgc3J2bDA1NiBrZXJuZWw6IFsgIDg1MS43MTY3MzhdIENvZGU6IDhi
IDMzIDQ1IDg5IGZlIGU5IGQxIGZiIGZmIGZmIDgwIDNkIDc3IGQ3IDAxIDAwIDAwIDBmIDg1IGYz
IGZiIGZmIGZmIDQ4IGM3IGM3IDA2IDZiIGUwIGMwIGM2IDA1IDYzIGQ3IDAxIDAwIDAxIGU4IDli
IDAxIDUzIGY2IDwwZj4gMGIgOGIgNzMgNTQgZTkgZDYgZmIgZmYgZmYgMGYgMWYgNDQgMDAgMDAg
ZTkgNTkgZmQgZmYgZmYgNDEgODkKMjAyNS0wMi0yMFQxNTo0NTowOS44NjYxODkrMDE6MDAgc3J2
bDA1NiBrZXJuZWw6IFsgIDg1MS43Mzc5MThdIFJTUDogMDAxODpmZmZmYTUwZjgxMjg3ZGM4IEVG
TEFHUzogMDAwMTAyODIKMjAyNS0wMi0yMFQxNTo0NTowOS44NzQzMDQrMDE6MDAgc3J2bDA1NiBr
ZXJuZWw6IFsgIDg1MS43NDM5MTVdIFJBWDogMDAwMDAwMDAwMDAwMDAwMCBSQlg6IGZmZmY4YjI2
NzA3MTkwZjAgUkNYOiAwMDAwMDAwMDAwMDAwMDI3CjIwMjUtMDItMjBUMTU6NDU6MDkuODgyNDE5
KzAxOjAwIHNydmwwNTYga2VybmVsOiBbICA4NTEuNzUyMDMxXSBSRFg6IGZmZmY4YjJkYTEzMjE3
ODggUlNJOiAwMDAwMDAwMDAwMDAwMDAxIFJESTogZmZmZjhiMmRhMTMyMTc4MAoyMDI1LTAyLTIw
VDE1OjQ1OjA5Ljg5MDUyMiswMTowMCBzcnZsMDU2IGtlcm5lbDogWyAgODUxLjc2MDEzMl0gUkJQ
OiBmZmZmOGIyNjRhZjFiYTE4IFIwODogMDAwMDAwMDAwMDAwMDAwMCBSMDk6IDAwMDAwMDAwMDAw
MDAwMDMKMjAyNS0wMi0yMFQxNTo0NTowOS44OTg2MjQrMDE6MDAgc3J2bDA1NiBrZXJuZWw6IFsg
IDg1MS43NjgyMzRdIFIxMDogZmZmZmE1MGY4MTI4N2M1OCBSMTE6IGZmZmY4YjJkYTRmZmZmZTgg
UjEyOiBmZmZmOGIyNjRhZjFiYTE4CjIwMjUtMDItMjBUMTU6NDU6MDkuOTA2NzQyKzAxOjAwIHNy
dmwwNTYga2VybmVsOiBbICA4NTEuNzc2MzU1XSBSMTM6IGZmZmY4YjI2NGI1YTBkMDAgUjE0OiAw
MDAwMDAwMDAwMDAwMDAxIFIxNTogZmZmZjhiMjY4MTJmNmUwMAoyMDI1LTAyLTIwVDE1OjQ1OjA5
LjkxNTk0MyswMTowMCBzcnZsMDU2IGtlcm5lbDogWyAgODUxLjc4NDQ3M10gRlM6ICAwMDAwMDAw
MDAwMDAwMDAwKDAwMDApIEdTOmZmZmY4YjJkYTEzMDAwMDAoMDAwMCkga25sR1M6MDAwMDAwMDAw
MDAwMDAwMAoyMDI1LTAyLTIwVDE1OjQ1OjA5LjkyMjUyOSswMTowMCBzcnZsMDU2IGtlcm5lbDog
WyAgODUxLjc5MzY5OF0gQ1M6ICAwMDEwIERTOiAwMDAwIEVTOiAwMDAwIENSMDogMDAwMDAwMDA4
MDA1MDAzMwoyMDI1LTAyLTIwVDE1OjQ1OjA5LjkzMDY5MiswMTowMCBzcnZsMDU2IGtlcm5lbDog
WyAgODUxLjgwMDI5NF0gQ1IyOiAwMDAwMDBjMDAwYmVkMDAwIENSMzogMDAwMDAwMDg1MjYyMjAw
NSBDUjQ6IDAwMDAwMDAwMDAzNzA2ZjAKMjAyNS0wMi0yMFQxNTo0NTowOS45Mzg4MTArMDE6MDAg
c3J2bDA1NiBrZXJuZWw6IFsgIDg1MS44MDg0MjNdIERSMDogMDAwMDAwMDAwMDAwMDAwMCBEUjE6
IDAwMDAwMDAwMDAwMDAwMDAgRFIyOiAwMDAwMDAwMDAwMDAwMDAwCjIwMjUtMDItMjBUMTU6NDU6
MDkuOTQ2OTI2KzAxOjAwIHNydmwwNTYga2VybmVsOiBbICA4NTEuODE2NTI0XSBEUjM6IDAwMDAw
MDAwMDAwMDAwMDAgRFI2OiAwMDAwMDAwMGZmZmUwZmYwIERSNzogMDAwMDAwMDAwMDAwMDQwMAoy
MDI1LTAyLTIwVDE1OjQ1OjA5Ljk0OTgyMiswMTowMCBzcnZsMDU2IGtlcm5lbDogWyAgODUxLjgy
NDY1NV0gQ2FsbCBUcmFjZToKMjAyNS0wMi0yMFQxNTo0NTowOS45NTYwMzUrMDE6MDAgc3J2bDA1
NiBrZXJuZWw6IFsgIDg1MS44Mjc1NDVdICA8VEFTSz4KMjAyNS0wMi0yMFQxNTo0NTowOS45NTYw
NDArMDE6MDAgc3J2bDA1NiBrZXJuZWw6IFsgIDg1MS44MzAwMDhdICA/IF9fd2FybisweDg5LzB4
MTMwCjIwMjUtMDItMjBUMTU6NDU6MDkuOTYxMjY1KzAxOjAwIHNydmwwNTYga2VybmVsOiBbICA4
NTEuODMzNzQyXSAgPyBuZnNkNF9jYl9kb25lKzB4NGU1LzB4NTUwIFtuZnNkXQoyMDI1LTAyLTIw
VDE1OjQ1OjA5Ljk2NTU0NSswMTowMCBzcnZsMDU2IGtlcm5lbDogWyAgODUxLjgzOTAwOV0gID8g
cmVwb3J0X2J1ZysweDE2NC8weDE5MAoyMDI1LTAyLTIwVDE1OjQ1OjA5Ljk2OTk2NyswMTowMCBz
cnZsMDU2IGtlcm5lbDogWyAgODUxLjg0MzI2Ml0gID8gcHJiX3JlYWRfdmFsaWQrMHgxYi8weDMw
CjIwMjUtMDItMjBUMTU6NDU6MDkuOTczOTg5KzAxOjAwIHNydmwwNTYga2VybmVsOiBbICA4NTEu
ODQ3Njc0XSAgPyBoYW5kbGVfYnVnKzB4NTgvMHg5MAoyMDI1LTAyLTIwVDE1OjQ1OjA5Ljk3ODQw
NiswMTowMCBzcnZsMDU2IGtlcm5lbDogWyAgODUxLjg1MTY4OF0gID8gZXhjX2ludmFsaWRfb3Ar
MHgxNy8weDcwCjIwMjUtMDItMjBUMTU6NDU6MDkuOTgzMjI3KzAxOjAwIHNydmwwNTYga2VybmVs
OiBbICA4NTEuODU2MTM2XSAgPyBhc21fZXhjX2ludmFsaWRfb3ArMHgxYS8weDIwCjIwMjUtMDIt
MjBUMTU6NDU6MDkuOTg4NDU4KzAxOjAwIHNydmwwNTYga2VybmVsOiBbICA4NTEuODYwOTM3XSAg
PyBuZnNkNF9jYl9kb25lKzB4NGU1LzB4NTUwIFtuZnNkXQoyMDI1LTAyLTIwVDE1OjQ1OjA5Ljk5
MzY5NSswMTowMCBzcnZsMDU2IGtlcm5lbDogWyAgODUxLjg2NjE4Nl0gID8gbmZzZDRfY2JfZG9u
ZSsweDRlNS8weDU1MCBbbmZzZF0KMjAyNS0wMi0yMFQxNTo0NTowOS45OTk1MDIrMDE6MDAgc3J2
bDA1NiBrZXJuZWw6IFsgIDg1MS44NzE0MDVdICA/IF9fcGZ4X3JwY19leGl0X3Rhc2srMHgxMC8w
eDEwIFtzdW5ycGNdCjIwMjUtMDItMjBUMTU6NDU6MTAuMDA0NjM2KzAxOjAwIHNydmwwNTYga2Vy
bmVsOiBbICA4NTEuODc3MjMxXSAgcnBjX2V4aXRfdGFzaysweDVmLzB4MTgwIFtzdW5ycGNdCjIw
MjUtMDItMjBUMTU6NDU6MTAuMDA5NzcxKzAxOjAwIHNydmwwNTYga2VybmVsOiBbICA4NTEuODgy
MzgxXSAgX19ycGNfZXhlY3V0ZSsweGI1LzB4NDkwIFtzdW5ycGNdCjIwMjUtMDItMjBUMTU6NDU6
MTAuMDE1MzMwKzAxOjAwIHNydmwwNTYga2VybmVsOiBbICA4NTEuODg3NTI4XSAgcnBjX2FzeW5j
X3NjaGVkdWxlKzB4MmYvMHg0MCBbc3VucnBjXQoyMDI1LTAyLTIwVDE1OjQ1OjEwLjAxOTk0MCsw
MTowMCBzcnZsMDU2IGtlcm5lbDogWyAgODUxLjg5MzA0MV0gIHByb2Nlc3Nfb25lX3dvcmsrMHgx
NzkvMHgzOTAKMjAyNS0wMi0yMFQxNTo0NToxMC4wMjQzMTcrMDE6MDAgc3J2bDA1NiBrZXJuZWw6
IFsgIDg1MS44OTc3MzddICB3b3JrZXJfdGhyZWFkKzB4MjUxLzB4MzYwCjIwMjUtMDItMjBUMTU6
NDU6MTAuMDI5MjQyKzAxOjAwIHNydmwwNTYga2VybmVsOiBbICA4NTEuOTAyMDU0XSAgPyBfX3Bm
eF93b3JrZXJfdGhyZWFkKzB4MTAvMHgxMAoyMDI1LTAyLTIwVDE1OjQ1OjEwLjAzMjkwNyswMTow
MCBzcnZsMDU2IGtlcm5lbDogWyAgODUxLjkwNzAwOV0gIGt0aHJlYWQrMHhjZi8weDEwMAoyMDI1
LTAyLTIwVDE1OjQ1OjEwLjAzNzI0MyswMTowMCBzcnZsMDU2IGtlcm5lbDogWyAgODUxLjkxMDY0
M10gID8gX19wZnhfa3RocmVhZCsweDEwLzB4MTAKMjAyNS0wMi0yMFQxNTo0NToxMC4wNDEzNjIr
MDE6MDAgc3J2bDA1NiBrZXJuZWw6IFsgIDg1MS45MTQ5NTVdICByZXRfZnJvbV9mb3JrKzB4MzEv
MHg1MAoyMDI1LTAyLTIwVDE1OjQ1OjEwLjA0NTcwMSswMTowMCBzcnZsMDU2IGtlcm5lbDogWyAg
ODUxLjkxOTEwMl0gID8gX19wZnhfa3RocmVhZCsweDEwLzB4MTAKMjAyNS0wMi0yMFQxNTo0NTox
MC4wNTAyMTkrMDE6MDAgc3J2bDA1NiBrZXJuZWw6IFsgIDg1MS45MjM0NDldICByZXRfZnJvbV9m
b3JrX2FzbSsweDFhLzB4MzAKMjAyNS0wMi0yMFQxNTo0NToxMC4wNTI4NjIrMDE6MDAgc3J2bDA1
NiBrZXJuZWw6IFsgIDg1MS45Mjc5OTJdICA8L1RBU0s+CjIwMjUtMDItMjBUMTU6NDU6MTAuMDU4
MTcxKzAxOjAwIHNydmwwNTYga2VybmVsOiBbICA4NTEuOTMwNTc2XSAtLS1bIGVuZCB0cmFjZSAw
MDAwMDAwMDAwMDAwMDAwIF0tLS0K

--_002_PR3PR01MB69723701495481CCA7D55F0585C72PR3PR01MB6972eurp_--

