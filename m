Return-Path: <linux-nfs+bounces-22883-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EoRVFMvNQmpOCwoAu9opvQ
	(envelope-from <linux-nfs+bounces-22883-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jun 2026 21:55:55 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFBF6DE86A
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jun 2026 21:55:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=rutgers.edu header.s=selector1 header.b=juH+m14G;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22883-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22883-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=rutgers.edu;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC3B3300FEE4
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jun 2026 19:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF81C31A555;
	Mon, 29 Jun 2026 19:55:25 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11022131.outbound.protection.outlook.com [40.93.195.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAF4285CB4
	for <linux-nfs@vger.kernel.org>; Mon, 29 Jun 2026 19:55:24 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782762925; cv=fail; b=KHQDrRKqrYfCIssJTP0q2hVpduvHJvQbgC1iqpUwQfrnopoiRomXrFu3BPzctMxJL9cRE/J5TiUJJTX7QkHxRuSHK1yNUMjiFe6Xa9drIuj1vXFatBVgU4gLPrQ5r8ULWgC2xmYxAY0OUlU4JyxohWB3uKWHa5GSn/n+s/CAtDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782762925; c=relaxed/simple;
	bh=iTA+p5b9lRuIhTP+F0k0fp7OEhiAfnHaUy/4RdWiLJQ=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tW0dWum4ExM+GP6F8eAK3/+oxTX8r5ZIj1YMfTbDMbbAgxD8W8RfAUW38rZhBOjWQPWnwbO16NcbKFRJ+m5FxozHbdqtoeJ9Wwe6ellOhFE8ReNjl+VYWfGmwRs5xzpkVGf5ubBHHejxol+aUjH8sKUE6ABPhhpzgY4xKGNsnMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rutgers.edu; spf=none smtp.mailfrom=rutgers.edu; dkim=pass (2048-bit key) header.d=rutgers.edu header.i=@rutgers.edu header.b=juH+m14G; arc=fail smtp.client-ip=40.93.195.131
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L29CWXkztAI/QvB4hW7iDbs2c53plGaUcIJXL0GuMg9oM5TlO0EPvDAYDEfOgp0GVnnR1cJ8jAdbtozi1Qw7gFqLY8K8UhZ07LNCxrdt2GubhJfUPuSd4SiysCOr3CWAFODseR27D8imGvDUO9d2PNSUOs/C/ObROmpYUQgEl+edHAUuwUiohRNt6mpY2yytxLG47EjZUztcn36UNl187jndOFp62IJjBkUqx3tQzw6hURg6+opVTbcf6KdMwyUpIrHoWgxy0y0IOBfE81vCQIz2sfAaDpCkiF40hVQhNM84gKMbAdb/TykG08HPSzo7MEs4GEf19109AEbQBYQW0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iTA+p5b9lRuIhTP+F0k0fp7OEhiAfnHaUy/4RdWiLJQ=;
 b=kxZJW6bJOvI7DbjZEQaTMDhZVatFxBwbtTirA2ttSiZmuz1sJkwnHsUtTT1/tXk5s7p2rTRCoDkVgVdjy4TvndrYK5izLDzEzhjIvXNtHsU87uaTgG1R/Mqm22u+qessZwe42EkNQY1XM9FZDk0f02CmrlA2dPK8XElr4hGVyI3wQ4IXtmE1yC+T1u4sM1Q/2/INwFeKMEtK/QUBeYpW/fYCfaDn3znw4RciK0Xg/qALj4E41EBi9Bbhbtw792h4gf3hJ/yStZgsnPofRU1tNJzcvi5mvSLavrBgjHjROtN5hqpSi+Tx46m35DSB3bIG0P18Cfell9Y5r77ne0aC8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=rutgers.edu; dmarc=pass action=none header.from=rutgers.edu;
 dkim=pass header.d=rutgers.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rutgers.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iTA+p5b9lRuIhTP+F0k0fp7OEhiAfnHaUy/4RdWiLJQ=;
 b=juH+m14GpSA5GUW3ei3bBek9BymimFll2lkn4QMvDcWYOiNU9q4F6Qshnl7fTe0dR8WgpfizcjmfonEk2XV5q/f4tZ4ya1ZIWDIkqAgX0XLi6so/zVoxxOhL7xMkXfj9TCw+bu4dGwEPzb/6s/Gto6I0BJoozt5UiqB4V+V6X46HyxvBF1g+YncCz1/6ywk/7MymuCQIsLQGqwF98fYBD8osHvexzJHW5+oK/SIyjnO32RiyFhe1JFUMhE1xat8Dl74uRI0OnS34iO6fmOjUoYxAZKQE8GSknwjXIUz9s2olaRKsyVKPUVmK2Hospd4luJ7sG23QZsaVPGfwHQgQ3Q==
Received: from PH0PR14MB5493.namprd14.prod.outlook.com (2603:10b6:510:12a::11)
 by MN2PR14MB4142.namprd14.prod.outlook.com (2603:10b6:208:1d5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 19:55:21 +0000
Received: from PH0PR14MB5493.namprd14.prod.outlook.com
 ([fe80::6b2d:b599:ee8a:ce30]) by PH0PR14MB5493.namprd14.prod.outlook.com
 ([fe80::6b2d:b599:ee8a:ce30%7]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 19:55:21 +0000
From: Charles Hedrick <hedrick@rutgers.edu>
To: Anna Schumaker <anna@kernel.org>, Shyam Prasad N <nspmangalore@gmail.com>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>, Trond Myklebust
	<trondmy@kernel.org>
Subject: Re: Status of delegations feature in NFSv4 client
Thread-Topic: Status of delegations feature in NFSv4 client
Thread-Index: AQHc/UQeE4Mmc459BEmwjTpPiejKKbZDIF8AgAGl0piAEUA6lg==
Date: Mon, 29 Jun 2026 19:55:21 +0000
Message-ID:
 <PH0PR14MB549322C03B6E7AD14F8ABCC1AAE82@PH0PR14MB5493.namprd14.prod.outlook.com>
References:
 <CANT5p=py8E7Rnd4C-1vMHMw2_dMxS_Cshy3hcbOEXzaO1pVqLQ@mail.gmail.com>
 <9ec7f349-c7f5-4936-9750-1f14dad394bd@app.fastmail.com>
 <PH0PR14MB54939D7737271F876BCD16ACAAE32@PH0PR14MB5493.namprd14.prod.outlook.com>
In-Reply-To:
 <PH0PR14MB54939D7737271F876BCD16ACAAE32@PH0PR14MB5493.namprd14.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR14MB5493:EE_|MN2PR14MB4142:EE_
x-ms-office365-filtering-correlation-id: 1c1a850b-2982-4dc5-04d4-08ded6185a52
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|10070799003|786006|23010399003|1800799024|22082099003|18002099003|38070700021|56012099006|11063799006|4143699003;
x-microsoft-antispam-message-info:
 8nPmbPlmld+TCZu96HJeQVZHls5IZcAd0qUmQ6rkQWiaUt2J4+nakfF/AD4ucizXhPOJ1f2uv2Ia0uzielQJmhVbc+sVWCJQ2Ru84K30sja6dWVlkx6FnUavq6gbM5ZvxLoo4BNv02kIyv4UG8DoGM39JVhvSirPkT7FLfC7ujhzqUw96BZIiiIW1lnyEJTIvDhBqd5rVrOFPuRZIHWNcE7Inw4sD0DhWB16guOO4OQVGkVBRhptEAIQSmpSt4AgMCbK90hJreuJ/pNzahG3h4ftb4zYQptArB8rc0fBYNwMD8aQ5IRi+t8vdEoFq+p2Ih06UbPxaJore+k4iWSM3cRx8SNwat7PJv0+2A9+ZzCwiLAFzLBOY24uKUfknkM7XX3/PyOKjDPHT/AFusdRunCSbAW4VGOmx2jqg54T8m+iOXLLUrcKNzcdPv58Kk6iUuD3wdwKxiGUWeZ7sF6vXMyr/LX+E2RTNhvwW4A/iMFTxD6YC2pqULjWRZRhjLf58Lmffqo2nCFHLN1IqMWZg+5xbKZEf2dmmn2JZVdRyMX2ieA99BtqRBz1oLR3le3NwE1VwXl6R4E+Buz8ValNAqIu5ZYhotpB7rgz7rgHfN75IuyN6gISCFcSz0kVUgnVwaWrNomRPc9PfMjb1U47CAwufn26itJEybsAZZr77AuZd4KUurJmMuSSPDuPlcGg6A1ulFSbyql+Ycibpz8kUB1Mt2JCuJy/WvV+uqVTlaU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR14MB5493.namprd14.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(786006)(23010399003)(1800799024)(22082099003)(18002099003)(38070700021)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?D4840bNRVXkdQPBaaNwnZwwZkjSFdgcNYmB/0uFrpjymk2dcBADkTXOX64?=
 =?iso-8859-1?Q?zpSsuEvAFb/dKLGo5TIlctXYNxPVqpknCvG2GaE2DsFwCtXR4DkdxCXbuK?=
 =?iso-8859-1?Q?f/RF5hUXh1DsXl8BSiLrtkhK/45dj9lh++v4/VfNEjEaclLefk+R3eIGq9?=
 =?iso-8859-1?Q?PAa1s8t8BVsIcrHF9x35UnKVWYdY1lArs904PdRWPWkUffj1PM6Uo5ayR/?=
 =?iso-8859-1?Q?/dMuA/+bx0S6AZvwIIwQt145vCx0iV6tbejPxZ6ipa5FfdWWuGOehX5J+d?=
 =?iso-8859-1?Q?ZFQYf81eaSTz0QpFjH4M+uvwajogtPKsmA6nMrRiuZMq74l6hC5KNTuxCI?=
 =?iso-8859-1?Q?scsARH+GYnXSkGQ837iMvZgEJ5XHnkghOdyfZ2ytK2iWR61ghujyMjeBMg?=
 =?iso-8859-1?Q?K83E69xHSIfWdt6sxQvXccPbTcwI4FIiDi4G+SjN+n/OBmwz/sEMZGSjxv?=
 =?iso-8859-1?Q?8BTSoeWamikjJg/bisHrP7H5WqR2hq5J4AOSpwpps/VbTO4D+NHNo1atPk?=
 =?iso-8859-1?Q?9013d9XM8l9wnXDdy8WjycOkxOJ9gRFPEVaYu9TmHZpY08t17U/yxykSd8?=
 =?iso-8859-1?Q?C2UO6w1Gg4uthmL5hQwFZAcoEsWp7phItr3RuLlR4k7EAgdaC9KdAxCMJo?=
 =?iso-8859-1?Q?XUA7AfwKuUhP1Wuq19y/CVKEw4ftm1EvsM1PEnQfqHc7YMKYn+6qZUrVLK?=
 =?iso-8859-1?Q?LSySiK0IzzwtfvuaOw6aMYbt0PgNyaQTv21S2qpbXNmGF5n+Rs5+Wi1IBA?=
 =?iso-8859-1?Q?w3BX9OjY+PI2NhlH3dpDSqwEJD0MvYhRExL068lpXSUALXzusqY03K/cYY?=
 =?iso-8859-1?Q?0C1Llvjyw1ArnQpKFqu75ZqUqr6nIVdW2bIdpazLSkZW1qcmHoDICtlp7p?=
 =?iso-8859-1?Q?nz3jb6zw5jr/m/ldLSa1kHbJFPstUfe6Y1hmMl4niouOLI9dpUuzuioi4U?=
 =?iso-8859-1?Q?DsjFg49pB2vc8aw5D67bMfiQoizUoFj8gYVV5v5JSIRsX3je3l1WxMZt3R?=
 =?iso-8859-1?Q?nx70aQZddXIGsLlByamAdTKWbH1uoYCyruS6qhRtIV/R2dLNfoMyrylhnz?=
 =?iso-8859-1?Q?9pkOYW81zrXu10csU5XwlkodQp33v20L52Yuxr0jJz6h3IGOOvWa3MicvN?=
 =?iso-8859-1?Q?I2Hw/15j6kSa6HSzfN6ZqVT0Pt2M67gJFgAk2QrPGaSW7ZF7ECYNXvxW3T?=
 =?iso-8859-1?Q?IIKpUiPz5SvAL51C7/AwETFPjT9zjddH19DyKsGvqK8jyniP0V+s6cbt+1?=
 =?iso-8859-1?Q?LnR/HMK5KsanRJ/nolW91qbhYCD532p5YmrEEoBDB68t3etybB8A8l8Trw?=
 =?iso-8859-1?Q?uzh8f1E8S9+ISXQir4tLowoDqwJlsnvGpib0wpxmx+PEiOnkrlGPasvOUJ?=
 =?iso-8859-1?Q?mtUqbKRq4Ov2k7KDjyLvllRXaeXJ7Kmo8HPSBHmZOacpRoBVFbdeFrzVwv?=
 =?iso-8859-1?Q?TmksVLnfb07khiVZs2re0FbwHXepgjvl+r5xEYSUCvMO4Qy6/ZH3woeKSH?=
 =?iso-8859-1?Q?y1T6wTgG3M9b7XGsflKb0bynzeKGTyA8z1JTyaCzUz4pswXwhGv0//7POv?=
 =?iso-8859-1?Q?dzVulAfxpC/eRVm4xmUhuJ1XU3aAiwm2SPwJQsMLybaol4uKwbFg5M93LF?=
 =?iso-8859-1?Q?HsHQMzYpaLfERIAulApl6n/6H+l0Ae5jwp8vjm3xJEF192nKHZg/VP+JUM?=
 =?iso-8859-1?Q?LDzhGVl5Dyj9JAInnp35EXUPqDRjeXgTTJpSMyOY73V5m7jXL2bJR7IZnb?=
 =?iso-8859-1?Q?/s23KjrPOTrFohz2vOrG/hA0CqcXSD4yfJegwWoAhuUdHAfVs1ucLupIwt?=
 =?iso-8859-1?Q?AagyuPCj9A=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: rutgers.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR14MB5493.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c1a850b-2982-4dc5-04d4-08ded6185a52
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2026 19:55:21.5475
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b92d2b23-4d35-4470-93ff-69aca6632ffe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nB7qHSKuHZdqiSibrUq+tWP35vSrCx8q/ZcEki9ZQEkkI7GQxlgYzUUM0nFuYYLXsQgk0OX76H91V4P7G9YJMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR14MB4142
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[rutgers.edu,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[rutgers.edu:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22883-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:anna@kernel.org,m:nspmangalore@gmail.com,m:linux-nfs@vger.kernel.org,m:trondmy@kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[hedrick@rutgers.edu,linux-nfs@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[rutgers.edu:+];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hedrick@rutgers.edu,linux-nfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,rutgers.edu:dkim,rutgers.edu:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8DFBF6DE86A

> >> I wanted to understand if the file delegations feature on the NFSv4=0A=
> >> client is stable enough on Linux to support it in production=0A=
> >> environments? It looks like this feature has been around on the client=
=0A=
> >> or a really long time now. We tried running some workloads and file=0A=
> >> delegations offer really good perf benefits.=0A=
> >=0A=
> >Like you've said above, file delegations have been around for a long tim=
e=0A=
> > and I would expect them to be stable for production environments.=0A=
>=0A=
>If there is a problem in NFS, we will see it. Rare events occur several ti=
mes a semester. Impossible events occur at least once a year.=0A=
>=0A=
>The worst case for delegations is heavy use of vscode with an NFS home dir=
ectory. This will hang an Ubuntu 24.04 client, kernel 6.8. We have been suc=
cessful with Ubuntu 24.04 >upgraded to kernel 6.17, and a Redhat 9.8 server=
. I assume a Redhat 9.8 client would also be OK, since they backport things=
.=0A=
>=0A=
>Our kernels have file delegation but not directory delegation, so I can't =
comment on the latter.=0A=
=0A=
Ugh. The upgrade to 6.17 failed. TEST_STATEID loops on some clients. Next t=
ry: 7.0 when the Ubuntu 7.0 HWE comes out in August. there are known causes=
 of this problem that look like they have been fixed in 7.0 but not 6.17. A=
nd it looks like Ubuntu didn't backport.=0A=
=0A=
I'm not sure where the right place for this is, but it would be useful for =
sites like mine to know what it's safe to use in what release. So far NFS 4=
.2 looks OK for Ubuntu's 6.8 and 6.17 except for a very odd problem due to =
network interruption. But with delegations off.=0A=
=0A=
=0A=
=0A=

