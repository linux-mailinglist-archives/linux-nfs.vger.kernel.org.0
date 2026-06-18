Return-Path: <linux-nfs+bounces-22681-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7wW3EgJVNGpYVAYAu9opvQ
	(envelope-from <linux-nfs+bounces-22681-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Jun 2026 22:28:50 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 915726A2882
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Jun 2026 22:28:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=rutgers.edu header.s=selector1 header.b=ZBhzm4Wc;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22681-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22681-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=rutgers.edu;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4BE923026885
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Jun 2026 20:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CDF8327BFB;
	Thu, 18 Jun 2026 20:28:16 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11022130.outbound.protection.outlook.com [40.93.195.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99ED2E06ED
	for <linux-nfs@vger.kernel.org>; Thu, 18 Jun 2026 20:28:14 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781814496; cv=fail; b=WuKgWDH59htaMxNYaZqWRuFgRUSHNZBF8RphfErrGAYHvhoGDXLbZat5YBHoEjH5bJDw5aLeSzljZUihYeOe7olHTwWzfvCwJswPBClP+pJjMPCN56E5ihuinORaNGdhPAN23eyyfD6eX22VABZfOoPUTW6UEEuI0whdUW/+cMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781814496; c=relaxed/simple;
	bh=BX3SRvoyv0Fq3I1Dg6+4DJNFYh13N/yTOxmodU4Nkd0=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ls8QMDe72Z/DFID4nOUyjotL2IFHdjQiwLU5BSf6T5VNhE20co9nouOByG/3RAxPXgqrPUV/3XLfhZLu4cu20UJi6kmmZI/f3PI8ygXxLXge//HaQy+7YIQejzrx2fs1L+VNuKIrQpb2UaC6XVSBaQmm5FqbpXppu5ibt+VPIwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rutgers.edu; spf=none smtp.mailfrom=rutgers.edu; dkim=pass (2048-bit key) header.d=rutgers.edu header.i=@rutgers.edu header.b=ZBhzm4Wc; arc=fail smtp.client-ip=40.93.195.130
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ir6IDVtz7q7l/pvBeIjiSedo51kR9MYZvQPfH8Fz+53A0FEuJvQlfI2Grf8by88eGvSVfYyw4Wh/nKBT6Ri1yRYDhp5VFE7+DuXF6M0+G1lMOgoqMV/0xUOEThGZ37ceCeWr4e2sgvpC88nowCbCHjrJUVQnwfCk1SlXzU+2DAajLAZw8P0+2wX0XTTm7usPGnZS7TzxGjdaY+SVv3JX6Iup4CK0NASMcziKyXND9YE8opPOLAiKo1D8HgqnbISv7HT5V76AIyzZ9kgLSqqHcu3Uuxtqn9FWi3vdxtp9Fhdt3AgvCmp5e8lpiyZ+ssAkXFYh1KOXL5MiXWAnNtkwYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BX3SRvoyv0Fq3I1Dg6+4DJNFYh13N/yTOxmodU4Nkd0=;
 b=NWVM74TjFeoDeEtBLh24QnTM4MrrcAr6Zie61qcpJ/91AXu3RGpTkZgk/RdRBxPCqnq+58GjiG4cVn9L+k0zwqPdlDhR9F59SMENicPVGQTfXJ85kjDNNWsHKQ3eDjcoIvxVbkzqN/zfcS9apG/d9V3zDSHUfkCcLAoph7nuZssMX6Ta2nVLBo/YK0Luzd+rBq/25U5oWbjxMV9pzsaHLYAU7+1gGbCORGS032dm6n3bmKe7gTv4qNy7r2u4LkB5MpGUmqgFyBBzyb8F7Gzg8SQ9ru+OhLLIQckg6bNVQPjKRXnLZtlu/Av0zABcSCIAomsaORXSVCu+uPpEyQKkwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=rutgers.edu; dmarc=pass action=none header.from=rutgers.edu;
 dkim=pass header.d=rutgers.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rutgers.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BX3SRvoyv0Fq3I1Dg6+4DJNFYh13N/yTOxmodU4Nkd0=;
 b=ZBhzm4WcJ5P/RtwUc4rs8DPPW8uWCjNMChMIdaReLbwXBIPm6NOHljBHNlp3k4fmASuGxwAJSvCqsimRUtxYwfGECa1JEzCDm4u5FlhPQupLOFbclkrT9LwO2V1Qall5VimfTSao1WYstUwybNyTzj4GrSyfQ7q4eMoOfJIU0zStQbv4qVARKGgQ9CSkktLp2JEe1/I3/0cVtWcHofjdJD6wuem289jZQu6qh7n4wDn7c9nLEfHKDEjp1Bb0945vCwgYOnHvvlYT6MLsfKRuojoop9h33ZR3R9hobxfRlaSW0G79OR1oxPL5KjYxX0Aw5uRxYuCdEmc7Ug9p6o9ruA==
Received: from PH0PR14MB5493.namprd14.prod.outlook.com (2603:10b6:510:12a::11)
 by IA0PPF0355D125F.namprd14.prod.outlook.com (2603:10b6:20f:fc04::f85) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.12; Thu, 18 Jun
 2026 20:28:12 +0000
Received: from PH0PR14MB5493.namprd14.prod.outlook.com
 ([fe80::6b2d:b599:ee8a:ce30]) by PH0PR14MB5493.namprd14.prod.outlook.com
 ([fe80::6b2d:b599:ee8a:ce30%7]) with mapi id 15.21.0139.009; Thu, 18 Jun 2026
 20:28:12 +0000
From: Charles Hedrick <hedrick@rutgers.edu>
To: Anna Schumaker <anna@kernel.org>, Shyam Prasad N <nspmangalore@gmail.com>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>, Trond Myklebust
	<trondmy@kernel.org>
Subject: Re: Status of delegations feature in NFSv4 client
Thread-Topic: Status of delegations feature in NFSv4 client
Thread-Index: AQHc/UQeE4Mmc459BEmwjTpPiejKKbZDIF8AgAGl0pg=
Date: Thu, 18 Jun 2026 20:28:12 +0000
Message-ID:
 <PH0PR14MB54939D7737271F876BCD16ACAAE32@PH0PR14MB5493.namprd14.prod.outlook.com>
References:
 <CANT5p=py8E7Rnd4C-1vMHMw2_dMxS_Cshy3hcbOEXzaO1pVqLQ@mail.gmail.com>
 <9ec7f349-c7f5-4936-9750-1f14dad394bd@app.fastmail.com>
In-Reply-To: <9ec7f349-c7f5-4936-9750-1f14dad394bd@app.fastmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR14MB5493:EE_|IA0PPF0355D125F:EE_
x-ms-office365-filtering-correlation-id: eb41f136-4e2c-45c3-854e-08decd781e56
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|1800799024|786006|23010399003|376014|38070700021|22082099003|18002099003|56012099006|11063799006|4143699003;
x-microsoft-antispam-message-info:
 KUFvNss3QqRxHnd+8HF+fLHcZT5Er3JffaK1TVoWb0+QJ2oIAHhzT4+x8oNK+ZrrpBzZDf67iwT21fR0J1ntQREVgoTCGQ4HNnZ2KFbgHkrEdxbdn5mI9shlZ7E8MGUthtRQBr7i+CiDbfgqp4TtbkW/Z2ywEbNheIQvWG2KQApEoR3zz3r2eREc9KLlQ+og9Gm7tlLqupaEiJ+OdAtXZsYay2fMAQ+X2eTPL/ES/KpA6RB6tMsFEVY6FAfXGiWUN/humZuC8O2/RHpJ20tzFYDlfKwGpcd9j8/kyGadKcA00jo75lVQ4c3mL8ugqFJC/e4iFC0WjfnaKJrp47l7eKVe5dBxYvsgRXGL2cgfT1CHAoH7CYuU6FOmFKnz9vfVSTDVKjMvDVcmlpOPM0llpFVywX6UeEvxhgWPvSo9gWciYCA4fx5xqcJJqMZFpHI5W1BBatoigHiTKrgIXkqg4BaMlN+XBoFV2eXqDjpvjN3Dho8DLxX3egD0q40zC37aKLjijZY7ihSsF6q2uewt184KvNRwcfNb9fFWENsYF+FmkaFLfI4GIHqhJSbPhPtVchzYd7ZjleTiB7jKERPHYb2sfoDmoRrSouvAV0rnnHiTr+BzoW8nybVuW12ilY/k4Ep7NbMDVuV3X6QBlSBOfwvb0z2kAPaVutJ3sygqjutGm9Mu9n0ITKtor7/Mf/dbs5Uy+2Y6BpXCRpMcQtSwr6C2Y4bnXSLJFGNl7QNBwok=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR14MB5493.namprd14.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(786006)(23010399003)(376014)(38070700021)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?PolRA0bvLgPR8hK1rXnB5xMz/unMmoD7DGXif0eLHXRzFTrB340ag+OKu4?=
 =?iso-8859-1?Q?BOiyx9oDTuNvwwxi3Nq2B+1A80mD69C+ZEJD3lh74PmwfqN2ECUJczb70a?=
 =?iso-8859-1?Q?KX4b+cMdS0vJ2ltQV+ABHtBkjoKZzTj9i6PtIKB0XfFQDUgj6wxwyKXEV1?=
 =?iso-8859-1?Q?inwjqdgy0bYOFKcEj/Yvx6u7I4c75stCl/enn2viM56RxlkqwUgplljAA3?=
 =?iso-8859-1?Q?zLcrwReDb0XvL/RAeFuX4wrrQd7CwuUmwLQRBTR4vm51S4GkTpip0Y8ZOj?=
 =?iso-8859-1?Q?CL1DFcSbLodgalvROKYGGuxoQD+/12UqGBB+vIQksxsARd4Nof0hBbT6rd?=
 =?iso-8859-1?Q?UGjdqRyD+ji9TEIZRKYtg64KYN7Becw9TRTWpzixl/1SHsj6qB+DiDI710?=
 =?iso-8859-1?Q?gpoJco3MdY6x9lwxrRcXemZ103dhy5wb4RZVDqMxF7HWscMKdLVxXfcODU?=
 =?iso-8859-1?Q?pRPErWcz77385Yz3iusFS4g2l7d4MODCcwLHoALnpNAOwfr0SIelmmppHm?=
 =?iso-8859-1?Q?Sa14dqTSzExOh4FGDTa8FOGeVi4q+ubeeOHT8IHgLCSEv/ULS3Q8AU7LQQ?=
 =?iso-8859-1?Q?kyn2f5yDS8IngF9Cf9QaGDwIV2SHn/RxkLJGDRTFNPdHL4yG1Ni1zIrGDC?=
 =?iso-8859-1?Q?YwM3tmjz4FADO9WZ7N0XOa+P35vnU3zTGr9ezvdIGItZKMS+Jr7os4XsFo?=
 =?iso-8859-1?Q?HNDtnOE4lV/yDuGDFkrmxI8gY5KHZEB1mebqrjlHbfs+O6j/Zkpg7sEFm+?=
 =?iso-8859-1?Q?pm9vqs6CUFgHeE+DySSJxIFRkZWbT2iYAZbt653ROUvOzr5OFhPgfb2nR4?=
 =?iso-8859-1?Q?secGLLt754/EAHOLJK64eL5KYxAjxB4AzYJuI6rONUbaAL0Gm65NLYa1Oj?=
 =?iso-8859-1?Q?iVvv4ZWc2LxDKxSF8QobT9Z6HsH8S5zC1Wz29CZcQtQ6ggLhjgzqt29o76?=
 =?iso-8859-1?Q?Qda0m6rGoVypNejzAKGteheyOY+I0X+rDsUYMqjaQfvOEUlvQFnMY+3rnp?=
 =?iso-8859-1?Q?c0npjP5V+o+3ywPTszKrjtXZINXjMXvYnbcKqJISbNffOyN4bzYZlWaA3v?=
 =?iso-8859-1?Q?DOZ5VjsyMwZC6t63mR/61iwapQv20B37HThxLp8/2Qk4QUVqR3sXKLIhaS?=
 =?iso-8859-1?Q?dEelLXrBAfLN3XxGIeGX4SQbmHRUCYJMcAzRAuvMI9zUFLwmOPH9/PzLaK?=
 =?iso-8859-1?Q?lP3xILV8gzd8oJhpEUvRcaXeZURqBMFVLatO6OuBDHS0P45t3hW9b525YK?=
 =?iso-8859-1?Q?6bfetdil1WBhUATgBy9ZROOhxV4xJf1AE73I5PPCFyIPg4tZ1Lg/MwED2J?=
 =?iso-8859-1?Q?mVAG5LdtBFvDBF7LFUxnJdJCoocjlqdTBAiaE86npaN2U7zgl4DFGNi11X?=
 =?iso-8859-1?Q?2G0Uxz7wQtVaVN3n+Yhym4OgJEj4baZt8O8NSGXYFRgFLxwBEvjHcQgiFF?=
 =?iso-8859-1?Q?stNi6eQjEvU9k5MBi2plNUph+0HNmFyGBUSdOb9O4UAw7MP+oe4fgEamW/?=
 =?iso-8859-1?Q?lVhlhoaVCzUWmgOEF3VnySnRWsFFzQ3lEnye4ore/VUnXV6SCZ5yqdCWP/?=
 =?iso-8859-1?Q?7jquzOh+91sbQSyImStf+qQnOV8HYiuRPhtHuA3mtqpaH8iIw0L/83AlEJ?=
 =?iso-8859-1?Q?XAEsFOqQrq7kmoosseah8iA/JfF6f4hsnn5ltuNaxhi9PDCnDsCe7RZUEN?=
 =?iso-8859-1?Q?tnXBrgftNYeLtlsCQXRdoUdJh0QqUtnJocWICC9mgVBwpjlOplD6kAZGas?=
 =?iso-8859-1?Q?wiHjFcquGcyIvU+G6yoL9mw9UC3Ss1afDZQb6qy9HFFhzenZ94hi3ygGKT?=
 =?iso-8859-1?Q?C9VeEJ4LyQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: eb41f136-4e2c-45c3-854e-08decd781e56
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2026 20:28:12.1815
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b92d2b23-4d35-4470-93ff-69aca6632ffe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vg/0fMLP+W7JHyUeYRFOW3GZfsjDrCiK8f1kSefmvWdgM1pbGGmPDn95y+0CR80wnqs6weJeEBVbxaGFhmsoMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF0355D125F
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[rutgers.edu,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[rutgers.edu:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22681-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 915726A2882

=0A=
>> I wanted to understand if the file delegations feature on the NFSv4=0A=
>> client is stable enough on Linux to support it in production=0A=
>> environments? It looks like this feature has been around on the client=
=0A=
>> or a really long time now. We tried running some workloads and file=0A=
>> delegations offer really good perf benefits.=0A=
>=0A=
>Like you've said above, file delegations have been around for a long time=
=0A=
>and I would expect them to be stable for production environments.=0A=
=0A=
If there is a problem in NFS, we will see it. Rare events occur several tim=
es a semester. Impossible events occur at least once a year.=0A=
=0A=
The worst case for delegations is heavy use of vscode with an NFS home dire=
ctory. This will hang an Ubuntu 24.04 client, kernel 6.8. We have been succ=
essful with Ubuntu 24.04 upgraded to kernel 6.17, and a Redhat 9.8 server. =
I assume a Redhat 9.8 client would also be OK, since they backport things.=
=0A=
=0A=
Our kernels have file delegation but not directory delegation, so I can't c=
omment on the latter.=0A=
=0A=
=0A=
=0A=

