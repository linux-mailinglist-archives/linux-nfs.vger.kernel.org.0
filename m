Return-Path: <linux-nfs+bounces-20995-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IAzzA4Sn6GmuOQIAu9opvQ
	(envelope-from <linux-nfs+bounces-20995-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Apr 2026 12:48:36 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C879444F5E
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Apr 2026 12:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D44A3032F77
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Apr 2026 10:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B284C3CD8CE;
	Wed, 22 Apr 2026 10:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gsacapital.com header.i=@gsacapital.com header.b="CXIZXmNp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from eu-smtp-delivery-195.mimecast.com (eu-smtp-delivery-195.mimecast.com [185.58.86.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B633CD8BC
	for <linux-nfs@vger.kernel.org>; Wed, 22 Apr 2026 10:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776854800; cv=none; b=oTvPsy3dHLE1fqVxW/O+4xd3NoR2Afxf5fdITv7hiu+G5M8RNgj8eHjm6/tWiacc4xry4MEw3jaGyAimunBlMits++9E9MORZR9F8Q6BaKvx/jveSx/nJH4pYmCaEyNekDkcjRLRubfglSd0JwqkKemlk37qCnF1YyFUvD7rj8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776854800; c=relaxed/simple;
	bh=DmOJKFZ8Rx/gl8r3kty46BnJuPolDQJ2xpuAUzMYWws=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=gd3t5DwGPA7GGTH//+SxF2YRd7Pe5AaDnpnsWMljQpHRXHn1/cgSytRSYHWnooK4waNrQ8J0Fm4klZ5m+21MKGbaQBFF/irtXwAWb7yiLm2tVBsUnm4HOfF2gwSRVFz84jeFVS/3ecdSjTumBMlzQIRkqniBB5C7ApWSLf2S3kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gsacapital.com; spf=pass smtp.mailfrom=gsacapital.com; dkim=pass (1024-bit key) header.d=gsacapital.com header.i=@gsacapital.com header.b=CXIZXmNp; arc=none smtp.client-ip=185.58.86.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gsacapital.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gsacapital.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gsacapital.com;
	s=mimecast20170115; t=1776854791;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DmOJKFZ8Rx/gl8r3kty46BnJuPolDQJ2xpuAUzMYWws=;
	b=CXIZXmNpZfKiVk6oUe6pb6KsiGoW4JRvpb3saGF7Er7nLNsszRQPFORlUGThMswzcFacdu
	zJaK9vbOi8dFLIaxT3xGhzoA0P4umenrx2zFCLou3vGc+0TMzzfPhjXy8L21/se++eSepE
	6LKfsmwIN2gMKThFf41d0m9gNNZNYSU=
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11021143.outbound.protection.outlook.com
 [52.101.70.143]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 uk-mta-65-S71Ds9LOMzmeEi9ZmpJikA-1; Wed, 22 Apr 2026 11:46:29 +0100
X-MC-Unique: S71Ds9LOMzmeEi9ZmpJikA-1
X-Mimecast-MFC-AGG-ID: S71Ds9LOMzmeEi9ZmpJikA_1776854789
Received: from AM8PR04MB7764.eurprd04.prod.outlook.com (2603:10a6:20b:244::12)
 by AM9PR04MB8416.eurprd04.prod.outlook.com (2603:10a6:20b:3b7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Wed, 22 Apr
 2026 10:46:28 +0000
Received: from AM8PR04MB7764.eurprd04.prod.outlook.com
 ([fe80::1ecf:750b:3097:a66f]) by AM8PR04MB7764.eurprd04.prod.outlook.com
 ([fe80::1ecf:750b:3097:a66f%5]) with mapi id 15.20.9846.017; Wed, 22 Apr 2026
 10:46:28 +0000
From: Ben Roberts <ben.roberts@gsacapital.com>
To: Benjamin Coddington <ben.coddington@hammerspace.com>
CC: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] pNFS: deadlock in pnfs_send_layoutreturn
Thread-Topic: [PATCH v2] pNFS: deadlock in pnfs_send_layoutreturn
Thread-Index: AQHcx1LQb9GHfiAvKEmU31eXdHmo/LXYXo0AgAYtabCABPFOgIAHfPzA
Date: Wed, 22 Apr 2026 10:46:28 +0000
Message-ID: <AM8PR04MB776494AB2547E8DEE4C6186D8A2D2@AM8PR04MB7764.eurprd04.prod.outlook.com>
References: <20260408122534.537816-1-ben.roberts@gsacapital.com>
 <B8730746-9646-4416-8417-D73B24FAB79A@hammerspace.com>
 <AM8PR04MB7764059A4CC2893C16A3180E8A202@AM8PR04MB7764.eurprd04.prod.outlook.com>
 <14A7BAF5-7D96-4C34-9FEE-CA929267A174@hammerspace.com>
In-Reply-To: <14A7BAF5-7D96-4C34-9FEE-CA929267A174@hammerspace.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR04MB7764:EE_|AM9PR04MB8416:EE_
x-ms-office365-filtering-correlation-id: 3c026d67-96d5-4f85-db43-08dea05c6866
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021|56012099003|22082099003|18002099003
x-microsoft-antispam-message-info: Sr6p7olqcsXvTXlG2/+/2mC81laFkYQ3Ka/WIal22SkJNH6mMMFwTuhxAn/dq3oUjQhw8JuIgq976cqD7XYRgoq2ZniqpT3ei49K4d7ZC7glZw46MHDnUyCbnGQUFeOXZvYejdJf0Lferin3zg4Ia1AkC0nSLlujk7QrqsbqsCbm8ZAsTGv6zxaSlYs/PJyM8T4pOJpu4Dl9fiplw1xJuYw0f2C/vjDfBquveAED2HVpBs4RJkcxHmTzN14q/gO8d7Fn5p+xMVppxBZXikqpB2QijTLsbESN7h6Q7xoq+bGzly5NXeRhVvoOp37PX2kLlZcMkqPw7nhWPB5BfrXpUU1cMDxsoYSZWpsoxIf6SOGL7phMCMgwv6/VK8z5TA8wk7xyTUhWqn7jsg7Ja/YAZD5I1YMku2Rvs8HMpY0KWyi5yz2ndQtjjjafXvc9ITvROwOzCJFk1a5nMeHUtrkOULvRVZxoCbAhgT22UjknbnDzP6H7L4kwXyE+EBNpwXNSV5+FL7h51Sp6zkwytZIz7qJ9wVGWwTgK6aiY7JWH8SlnKeiukhXvbx7MQddija4FYknGMsd8GvFxdpOFKcP7k9qwhUcp2salfj/cyOTh9ZKtTG8UUd9hleT2JEy3WAwTrzFxm7lpp3wNjCIA6hVSE0OU+f+oyPVxRxQipLknFPJluQiXUyh0VYgamcpstcikfoypuS/Exst5ahGf87G9AUcAI5M1cTgVj8KZRip8e1S5/x0WiUFfagqIohik4phK93AnXFuV3LMMfRtNY8W1e2KXVs6WXSPNCzIwVdxmpGA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7764.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cB/Y2RRgBLsjl63TajK0z6fnRSz4OJAQvgNMvfzg+Xg1/5zcvnYqLVaHrLNn?=
 =?us-ascii?Q?vFwshadpYK00doDityO1JvXlPJSu1/yBfKAu1U7RNbONinxnJje4jThr5bR9?=
 =?us-ascii?Q?rSrP7gnvys/k47BlFqYXjEf1Wz4SrPHQBPAFtfk+ZwrjtCylg3enUTHXSJYn?=
 =?us-ascii?Q?5KQE1JVLlQN76olbHlj3H94s9EcMtq0wp1CTmbMBCFiS5ioV1egFwrDGweic?=
 =?us-ascii?Q?mm+KJ5munjWjQc7i4e7tIIrXRh0FUyDIGAoIBcOUu6zsKVE70jDXucaWX4xy?=
 =?us-ascii?Q?a+jk5DnCDLn1nwJUw8LUzpwn0PIFzVDFARMiul0yEFi8+0ueEJuYPz7aUzGu?=
 =?us-ascii?Q?zpwP/bEg/r/V68/+EJKj2olH2RTf5bKUks5AH7aCzIn31ecwBs1I6YJuTLpf?=
 =?us-ascii?Q?3Rf5pKVXOLi6WKQw2oiCQXtJuprHzPaaf1WfD5tI+f2ZbHPF2Pb/sXA3nUsE?=
 =?us-ascii?Q?cGU+5uGbCBdrhU2/c5vb7jPIoFPY6lmc7FtzgWq+UEyyVTYR6x4KWmbspW/g?=
 =?us-ascii?Q?Jblu1S6EilxPig6kErPJD90o7pxTncuKGltd+/vW6iXdRb9BvAUT/0lbbJxh?=
 =?us-ascii?Q?i3fv9wVJAT8w9uWHOVo3SE8i7wmGVaImzIxtECtQmJUim8YO4HiqNNnIdMOO?=
 =?us-ascii?Q?qmc+lXG4wa8QjHGCv6K26UhuHkLrV9Ysqt0uiXfRXeysWBwaBwNp+TgmnsJe?=
 =?us-ascii?Q?RI770hTZuznzrz3wBjQvd9wsaIV0eO2JxI9B0hzuqrwpUD1q5pfv7CCQMVfW?=
 =?us-ascii?Q?yWc+TrjOlVgCP7p/hvtnARbO8ZzyFl2be90VPegZ5SF4mHGBYxMj7wlbBCKB?=
 =?us-ascii?Q?8/Wnb47IYFs9Z+z2SUsnHFFG9DsU4YGcafSJLdByF/OlBNQrmCXQ1A1cntKE?=
 =?us-ascii?Q?7ZhIpIP6P2Me12tRh7PVxfr8VnTO+Y0YOmoSfgUBVIou/ELKwXOwsCmoi0QW?=
 =?us-ascii?Q?b+6tTwny3czDdX+zQtQp5Z3zGNWxMgn3tBVuV3aUqdGSL65GgDUB3n8VKh9W?=
 =?us-ascii?Q?1U4tfinXhqE80kRAK4+UmmfzQ42y3AEpkXvXIjv1rYiDiPvMAmPJJQKvThdJ?=
 =?us-ascii?Q?3nKJ4/sFE+Vcg1a06YPuDJGpcwqgmpihsb0zkMFlAASQ2WRV0ciGGbw91Fmp?=
 =?us-ascii?Q?EvIWTSoFew9Fb4xllwlDf9KR/ABXJrxUJ4ikjB6c7DRkdRoAhM8apbA6Bi5s?=
 =?us-ascii?Q?ZS1TNhTyPe1zmI0XtQk16QvVEST4GYZs6djWgZFa/B7jWv/0XKhOBt4uSfXF?=
 =?us-ascii?Q?cBlWyJlGZJ6lLlLiHpYSAddvcPeXYwVtjsrsGUWqiYSe9hlliCr04xpzsjgw?=
 =?us-ascii?Q?efC5SSIGCxHq3780SGlcqg26anhpQYyQRE6/lYmcTNNJuaznanvYdPnyEDQM?=
 =?us-ascii?Q?cVmOAqWUJgiJyzCenYrawBTWbMVdoRwE4eTM3hCqQX+Vsmg78t19lyEkf7Ki?=
 =?us-ascii?Q?0RJKCnZ5dsmYtz0DquojtjEm66RZWCokhju4l2pYyM3eeNpcGaMknuPbbzXe?=
 =?us-ascii?Q?c7tHgvsoxjKgAiCBUOAK58F4MHHb5+jKgwU1j+4Ei57VwFN5OV6uF81eZFJ4?=
 =?us-ascii?Q?44XngaUElHaH6EFugJoGVUWxqTDVw+EVqYK7S4bjMAdcLtb1lwHhjL+rz4Ao?=
 =?us-ascii?Q?0sUzijFGMIxUpa2mteIyLZvZ15QW/XbC7Nc4h0AvTMr2Vd7v5WBgBt52rsXL?=
 =?us-ascii?Q?jgBlQAZoDRLcBulbJWpLtDeeJ1EP20kTRkWxFvuCpkmbWva0jsCwaocdjAsf?=
 =?us-ascii?Q?99SUYwA8ow=3D=3D?=
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: NaH9wpclLrxfDGkEw5prjDFP97B7Pnj2Q5f01+H4Kz/gmLwUEhzJQqwG0Y+I2bwHKWu6a4j19+kyn5P4491tS5PMzcEEV5KchraeArW81b/G2yf9plZDVsPNCypLEAuAb8zYrdcxxA+L3T/rA6sZG+QeQk7w073C8AHw+JPbMJkELLdNz3yR6EpyAlNn8MpMUeS0qCvzHJTPJfalzwCpyPANZ+cJxRSs8tce+CPM+J7hP2ILN+qh2JTaPFNtDCWyfKSLrZ/VecQblyOepDkqaeLOLeXvtzp47XPYmrR0W5aV0s7/hisv0TJAtfe8Yx2yEbh+HFlBIAsTHL+KA22pzw==
X-OriginatorOrg: gsacapital.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7764.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c026d67-96d5-4f85-db43-08dea05c6866
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2026 10:46:28.2138
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1c223b65-c219-4d0f-b348-45bd61f327c6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SyCZqViIREAHo8vGtuOA2/v/KbBd5JnYf6fAY5H7G0hy1kQld+gnlwwJtK6FiTtOWm+qAkN0r7f1GwvM50wT5FUWZAH5GFIdKnyIC0WJp2k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8416
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OjOYqSO9I_9f5JIFApE5vtLweoH9rUPiZq7gUOh3QuQ_1776854789
X-Mimecast-Originator: gsacapital.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gsacapital.com,none];
	R_DKIM_ALLOW(-0.20)[gsacapital.com:s=mimecast20170115];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20995-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gsacapital.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ben.roberts@gsacapital.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gsacapital.com:dkim,gsacapital.com:url]
X-Rspamd-Queue-Id: 6C879444F5E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Ben,

> The kzalloc failure is definitely a rarely-used/tested path, so its possi=
ble
> there's an issue there no one has seen yet, but from what I can see it lo=
oks
> like every call to pnfs_send_layoutreturn() first calls
> pnfs_prepare_layoutreturn(), which already clears
> NFS_LAYOUT_RETURN_REQUESTED. I don't see how you can end up with another
> proccess seeing the flag.

Understood, thank you for the feedback here. I withdraw the patch request a=
nd
will take this back to the drawing board. Likely removing the patch from lo=
cal
systems and looking to capture more useful diagnostics if/when the problem
reoccurs.=20

> There's at least one body of work in this area that your systems
> don't yet have:
> https://lore.kernel.org/linux-nfs/20240613050055.854323-1-trond.myklebust=
@hammerspace.com/

For what it's worth, I checked this patch set and the changes are almost
completely present in the EL source. Patch 2 is only partially applied.=20

Ben Roberts

For details of how GSA uses your personal information, please see our Priva=
cy Notice here: https://www.gsacapital.com/privacy-notice=20

This email and any files transmitted with it contain confidential and propr=
ietary information and is solely for the use of the intended recipient.
If you are not the intended recipient please return the email to the sender=
 and delete it from your computer and you must not use, disclose, distribut=
e, copy, print or rely on this email or its contents.
This communication is for informational purposes only.
It is not intended as an offer or solicitation for the purchase or sale of =
any financial instrument or as an official confirmation of any transaction.
Any comments or statements made herein do not necessarily reflect those of =
GSA Capital.
GSA Capital Partners LLP is authorised and regulated by the Financial Condu=
ct Authority and is registered in England and Wales at Stratton House, 5 St=
ratton Street, London W1J 8LA, number OC309261.
GSA Capital Services Limited is registered in England and Wales at the same=
 address, number 5320529.


