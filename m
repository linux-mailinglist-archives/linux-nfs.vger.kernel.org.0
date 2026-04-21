Return-Path: <linux-nfs+bounces-20979-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GCFKBJpL52mX6QEAu9opvQ
	(envelope-from <linux-nfs+bounces-20979-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Apr 2026 12:04:10 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 765B4439497
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Apr 2026 12:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A2701300BC9D
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Apr 2026 10:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F648386450;
	Tue, 21 Apr 2026 10:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=verivus.ai header.i=@verivus.ai header.b="TI7OxR3j"
X-Original-To: linux-nfs@vger.kernel.org
Received: from SY5PR01CU010.outbound.protection.outlook.com (mail-australiaeastazon11022105.outbound.protection.outlook.com [40.107.40.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCFC39FCAC;
	Tue, 21 Apr 2026 10:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.40.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776765830; cv=fail; b=sFiivPjHKfSOjDgNn9OFD9UfN1TVa7YUPpE02lAIxxzXrx62GMsWAgoAmSBbIpXK3puJjDj3kRV0aGC31KBFaboqPn66xTcEwy5n5mYstHmtLoZGD8/gOBMl9b2l/KPQkXblNnGUWHjkUoWXgzsvELHlDvKXJT0/s71JpRQeGXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776765830; c=relaxed/simple;
	bh=1qpgihLq9g/Q3izlEesuvt8o2Xo7cOj7UcosuipBBpY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=duSctYfIdkAaSZy3kr9kFSEOf0PKUuxbJEYCbNyf46vZLGRkE3jIaW39ecRodKEr33Uor1LYPVM+fUF8pN/BAEZMXPLHrniMKKM/LwK4pJrxukHLx6nQYtctkXS0IIOu5JKe+MwTjY7ITIayNfqszPt4m3mwVsK2oMOMqaKPviM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=verivus.ai; spf=pass smtp.mailfrom=verivus.ai; dkim=fail (2048-bit key) header.d=verivus.ai header.i=@verivus.ai header.b=TI7OxR3j reason="signature verification failed"; arc=fail smtp.client-ip=40.107.40.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=verivus.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=verivus.ai
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=do/huFbunlxnIRpMTKTbYuH768x3MWRcIly1mviQlH2gcAuzWxzDEn6ys3QBorO69047Ikqb9YmwFZxdFha/Rd8filCCd+mYo7zY2NKLImFwR9dT61QSNF55XC6NFE3XRv5XgyUP68kSJ5I6CL6Pzbu/RAXv1zOtTEA3BRfEboBPJtiW7uYEzGoqRKxVeNVWD6kq28IYU7WYVfrZd3WlMTblrEIaQmA8q0fACQ9AEYtp19TMOnldmR93c4mR03xXvmMWvCUhsCVz7kp95qc6UCMtiKjtQp4TymUVPB33uuKAuS0+Cr/p/BT9IL5RZaiq4TE5p/T3H1qU1We9bx3ERg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S7DoKxb/hVXlseKPtErZQyEhdxOFYdLv0+7II1dusYg=;
 b=RVk9iqtW4ArMDWDJhOmZorFTmFqXjVvJuMaQ+tRnQrBntjUm7cRUt6rTbWMqYq0rWlivlkrN15M+MwIF8aJZjB6sLkiX5GXsc2v3eHkbQSv3ikJG65+WPZegyf6Ebh4E7tMfpUqdqPvz5YMV8yLnrPQ0YabcTbAgIjXQNjKJAFuw3e+s9KzfKEGwInOxYl95jrT3OlFEma8hkcdwjecJOeoCwdG8AmJe4okI3LguXoeheDnZgXP6u+iCpwU2DBG2JNhw6eWnfeqlvuX2HDYoFTJiGxxo9tHyQD1iJcZ5Fu62Qe74zlYFkwidyFU9C60AHNbXDLlyGkTvHLeENslVPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=verivus.ai; dmarc=pass action=none header.from=verivus.ai;
 dkim=pass header.d=verivus.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verivus.ai;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S7DoKxb/hVXlseKPtErZQyEhdxOFYdLv0+7II1dusYg=;
 b=TI7OxR3j+M9QD39upA7Tvs5haNRMgwMoGPyvtxVfxj7ZbaSz7Go1aFYiicHcxiYflhGI5CE3M9edaYr+jAZn6u8jw/WEnLEb3fo+OtUbi/aCeHR931X4kioRjCCOn9tzvF9BsyY0Iyp9+oF+REWVYa7XfMBcke/XpV/wNyVcF6T+b96uwZk9rGKwlwgUGl3PDpZYV5MKc3hsis0mkweHqDv1696AzOWHveO6UZu8L1KtbvaDOwW+l9tT6hkaf7Kzv04oq7VT3l1QyBlMxJWYWy0ZM3j0rxTXvP8iAxG7L5dBL3EZ4l8NqF8lmQjO8PFi1tbCca9WP5bd5lig4DoYGA==
Received: from ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:22a::5)
 by SY9P300MB1529.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:2d6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 10:03:44 +0000
Received: from ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM
 ([fe80::1e3f:9cb9:4a95:b5a2]) by ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM
 ([fe80::1e3f:9cb9:4a95:b5a2%5]) with mapi id 15.20.9846.017; Tue, 21 Apr 2026
 10:03:44 +0000
From: Werner Kasselman <werner@verivus.ai>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
CC: Christoph Hellwig <hch@lst.de>, "linux-nfs@vger.kernel.org"
	<linux-nfs@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, Werner Kasselman <werner@verivus.ai>
Subject: [PATCH 2/2] pnfs/blocklayout: cap total parse operations in volume
 topology
Thread-Topic: [PATCH 2/2] pnfs/blocklayout: cap total parse operations in
 volume topology
Thread-Index: AQHc0XYj7nnCqxfCHEWqw//Ynpi3KQ==
Date: Tue, 21 Apr 2026 10:03:44 +0000
Message-ID: <20260421100338.1227152-3-werner@verivus.com>
References: <20260421100338.1227152-1-werner@verivus.com>
In-Reply-To: <20260421100338.1227152-1-werner@verivus.com>
Accept-Language: en-AU, en-AT, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: git-send-email 2.43.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=verivus.ai;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ME0P300MB0853:EE_|SY9P300MB1529:EE_
x-ms-office365-filtering-correlation-id: 9ae4d0cd-fd57-4f6b-77b0-08de9f8d460a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 0AxBtqAm7IEk31mL7N7Qbr0r3p70TyaDT6deKQPq01ewkpObHV4PDVC/Kg/E9rA9oXCAS7JLSiocrQbEanlb0Ryx4LjOefvvqhtkSrXNBoy6iGSzpadHtkW/eEshQ5ca4HbqAUp6Qwp2vaOPC5h1e88MCRiNojHaGAMYpYURe1WkudY5DAJqZmceNCIZAzW5ty3k7KlVlNnLk0pg7ZEMsjdve7qWW40XaDyttRuTz7gG9KBj642/vTWPFL5hRjQmWrteD/GNMHUe2lmuvE++4ueM+o08XfXFrk3yrQREvz3+pmAMVT4wZBs9Hi3Z6JfXgmvIMmbf3SNBfY5KiURLKfS6pZJ+LLjXypE5GfIOHZU7EmDuyF5cxAhujHj3BBtWof8HwuFFvMWeL+UCWaXKJuJKcf3TDdQw6creS+Fu2yBeu9pit9gVUNVOUpiqLgCFjFUprZW9cn6tnxzUzQa1KYdG/NH+nYiOd3svuAqKLXN8/ZSu7qF1nWbp//wjE11NNXyTN8M7WWX99Nh96+DBRHMP+87USov/bdRZZ182/t+1pWFwPgJRTq7pMnOLJGtSrUQjxTRQcCgigmB9Ai/SEfqB+kha5afJcDd8KYkLikNnsujgBi+ivpA+t9u4GdYQpBVuF9k9txLbthnVm3K6NeBoodrVoKkgH6Atj5Y0BIUs4APezj2Jtne+ayCxIM+E3zmXlMvSQVIyW8n2CfgrBCsHtWleQFewDMa6TKoRFQ102dZ0hV6MaD/Ifh6LXFKNdRiZ1wz0ydTdewhkFISAAdGydSJHqw8C/9Ew2pOyo1s=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?br0qsDn233WwjdHbTKtLHUSXyf30g83fxnYwDKSjo6WTUo7Q2Ecb99ocFU?=
 =?iso-8859-1?Q?oRXkhmfIJlWj+i64Np7LiDo001IAoWGV7La2rgvr2Bn7mIeY8AlIaUuD5P?=
 =?iso-8859-1?Q?LiUFQ3W14Utko163TmgKYn5ZKK4RDP/NyWwbWFsDyLov/CCJrJ7YUvESh6?=
 =?iso-8859-1?Q?mPQMnG7uj52weHnMUhMxKy9oOg9I4arv1T5X491UA6CPZmPFJ9ipu9/dWb?=
 =?iso-8859-1?Q?P9xHXsZOqbBl7LgEOot3gnZnK0OJPNRkSQ7kR9p7fiFAaRpdTBhpKr6FWF?=
 =?iso-8859-1?Q?SR90oqaM6J63HUj6xZSGul9/ZhhukE15PF0OdmvL0L4aiA+3IuYQBOOBIN?=
 =?iso-8859-1?Q?M4zaB077ukrGUlay14IfjDqfWJB3HWt/N6HkRPY68xBd+4YML1z3d5MTEq?=
 =?iso-8859-1?Q?jd4WEYJi71jalWp2hAOJYp+RfavByyG8d/t3tnPNljMsKmdgecRvuY/nkq?=
 =?iso-8859-1?Q?HVm45TJE45CUAlDx2nmWN20tXZFbCtbeCkr9lSBywC0gFkQfuL6wOnzNi+?=
 =?iso-8859-1?Q?UIhm0YpmygjK0g2FN80jKApTVPLsRJgy5hazmY0VLTO5n+Nq5gSBF9RGa8?=
 =?iso-8859-1?Q?V1PTulqdLTorP9+AIM9gBxeIoB0VMyj9Tjt8gOiPtzA5WV20GC/aMmYIWA?=
 =?iso-8859-1?Q?oEqeP5GfdNXt6bYb1ztMOODdZN4A/m4Oe0utqlaY+KztwabtirldZ6+4Y5?=
 =?iso-8859-1?Q?mOkMKgFCNcisd5zfhtMFfXiOMd+YJY1EyPduJsBkz7nyNbw06+xDFOAa8r?=
 =?iso-8859-1?Q?OUbnavGZbRmfdtAH3w2MFw4U8Yd+6CSoW4VeRoHShxoux9oOH0leu11j4g?=
 =?iso-8859-1?Q?s6MNeUprwkMnxbZ3Ebr5Orn4ndGp7J8vKeaHnJc25HMj8NDMdvByJv9Q0L?=
 =?iso-8859-1?Q?O5jvS74m8P5b4UqMZAQjUr0yvkC6U/+GO/mfwG5QLEx66nh2X3RHdOCJ43?=
 =?iso-8859-1?Q?oA9XZ4j2/7La+f9E8v9WyY0DDWS1YrehHc/8LaLfrAx3Eh/b65TRVknfEE?=
 =?iso-8859-1?Q?tXg2IuZN75uGdc/jwk7L45p/ih5iM0ZCrElWoOlJqbFii7n06v7NvmwguF?=
 =?iso-8859-1?Q?QlEYzIkzD7EIIGDH4nOTvQgmNsb3avprZ0CVHVAy4Lys01UhYwRFtQRt3j?=
 =?iso-8859-1?Q?+n9gRzCODIql2OYy97P8YtR5alldBqo04a+sX9KDMGX9LLhRAa7UOV/Rp+?=
 =?iso-8859-1?Q?2pyQ0AFD/JuBlF/hyJBp5lSfeZ0BsevlERGe1813NJ+bhy+8Qbdvc5sC1G?=
 =?iso-8859-1?Q?mkXXAh5QC2B3ZT80rHOQs/UapVwxDZmjvS2dYlXVuww++W8avYfLeXOB67?=
 =?iso-8859-1?Q?PpQcthfuOcC22FkG1sqwx8Q0oiwYDrrsK1Vl4IJM8Y0fYHpCq7ehICuLSR?=
 =?iso-8859-1?Q?Mg1UhgGZwNtMhQgOhI7WB/v4scAdHzgPdQ+oIAvabzt0Ik4xLPW3S5aFXp?=
 =?iso-8859-1?Q?oOPhUE7nvbzxKVrUp7+rXtohEvxCb2CpFa+zo8ZVtaBx7pD8yEuI4cFLUZ?=
 =?iso-8859-1?Q?UCACq/j/MJ0+yoCySPDiVdLXq09UNSOVubVD8AlD7SQd2eM9IrBU/twZC/?=
 =?iso-8859-1?Q?AsqiyFJ0wejSufno0/MNU7oarH853//hCvRz+Dc7JSt5TAuaoDoXo1NDWF?=
 =?iso-8859-1?Q?Inr9cxGE5773n+egMHcYnJmKT3OxWAaZOhLUKPMwe0LVT+R/qvDUR1fTJo?=
 =?iso-8859-1?Q?/JqVWXC0Aa2523hl94jrk0m85f99vm9HuvTjgPTuNeWI/2rlbGMU3EgaaG?=
 =?iso-8859-1?Q?PC9JvgHDj+1Fp6Dodw5C18y1lEY89oLhFiQasLf9GD2crQZ1tLJjE3AfjF?=
 =?iso-8859-1?Q?SkA/LaCjfA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: verivus.ai
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ae4d0cd-fd57-4f6b-77b0-08de9f8d460a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2026 10:03:44.7412
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ccdcedb0-4edc-4cc8-9791-c44ee6610030
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 53c4awuU4qNIQQppTmgR9XHcw92z5DbWosrpkGWXGfYAa/xx3sSoSnm5aBd6fSovMqhv6HQuAVjyxmcqXih9rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY9P300MB1529
X-Spamd-Result: default: False [1.64 / 15.00];
	R_DKIM_REJECT(1.00)[verivus.ai:s=selector1];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[verivus.ai : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20979-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[verivus.ai:-];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[werner@verivus.ai,linux-nfs@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 765B4439497
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The recursive-descent volume parser materializes a separate device=0A=
tree node for every volume reference.  When CONCAT or STRIPE volumes=0A=
reference the same child index, the parser re-parses that subtree for=0A=
each reference, causing work exponential in nesting depth.=0A=
=0A=
Cap the total number of bl_parse_deviceid() calls at=0A=
PNFS_BLOCK_MAX_PARSE_OPS (1024) to bound CPU and memory consumption=0A=
from server-controlled GETDEVICEINFO topologies.=0A=
=0A=
Signed-off-by: Werner Kasselman <werner@verivus.com>=0A=
---=0A=
 fs/nfs/blocklayout/blocklayout.h |  1 +=0A=
 fs/nfs/blocklayout/dev.c         | 31 +++++++++++++++++++------------=0A=
 2 files changed, 20 insertions(+), 12 deletions(-)=0A=
=0A=
diff --git a/fs/nfs/blocklayout/blocklayout.h b/fs/nfs/blocklayout/blocklay=
out.h=0A=
index ec8917cc335d..6c00d98d4317 100644=0A=
--- a/fs/nfs/blocklayout/blocklayout.h=0A=
+++ b/fs/nfs/blocklayout/blocklayout.h=0A=
@@ -49,6 +49,7 @@ struct pnfs_block_dev;=0A=
 #define PNFS_BLOCK_MAX_UUIDS	4=0A=
 #define PNFS_BLOCK_MAX_DEVICES	64=0A=
 #define PNFS_BLOCK_MAX_DEPTH	16=0A=
+#define PNFS_BLOCK_MAX_PARSE_OPS 1024=0A=
 =0A=
 /*=0A=
  * Random upper cap for the uuid length to avoid unbounded allocation.=0A=
diff --git a/fs/nfs/blocklayout/dev.c b/fs/nfs/blocklayout/dev.c=0A=
index d9b1af863535..6e0df65c9b1f 100644=0A=
--- a/fs/nfs/blocklayout/dev.c=0A=
+++ b/fs/nfs/blocklayout/dev.c=0A=
@@ -288,7 +288,7 @@ static bool bl_map_stripe(struct pnfs_block_dev *dev, u=
64 offset,=0A=
 static int=0A=
 bl_parse_deviceid(struct nfs_server *server, struct pnfs_block_dev *d,=0A=
 		struct pnfs_block_volume *volumes, int nr_volumes, int idx,=0A=
-		int depth, gfp_t gfp_mask);=0A=
+		int depth, int *remaining, gfp_t gfp_mask);=0A=
 =0A=
 =0A=
 static int=0A=
@@ -441,13 +441,14 @@ bl_parse_scsi(struct nfs_server *server, struct pnfs_=
block_dev *d,=0A=
 static int=0A=
 bl_parse_slice(struct nfs_server *server, struct pnfs_block_dev *d,=0A=
 		struct pnfs_block_volume *volumes, int nr_volumes, int idx,=0A=
-		int depth, gfp_t gfp_mask)=0A=
+		int depth, int *remaining, gfp_t gfp_mask)=0A=
 {=0A=
 	struct pnfs_block_volume *v =3D &volumes[idx];=0A=
 	int ret;=0A=
 =0A=
 	ret =3D bl_parse_deviceid(server, d, volumes, nr_volumes,=0A=
-				v->slice.volume, depth + 1, gfp_mask);=0A=
+				v->slice.volume, depth + 1, remaining,=0A=
+				gfp_mask);=0A=
 	if (ret)=0A=
 		return ret;=0A=
 =0A=
@@ -459,7 +460,7 @@ bl_parse_slice(struct nfs_server *server, struct pnfs_b=
lock_dev *d,=0A=
 static int=0A=
 bl_parse_concat(struct nfs_server *server, struct pnfs_block_dev *d,=0A=
 		struct pnfs_block_volume *volumes, int nr_volumes, int idx,=0A=
-		int depth, gfp_t gfp_mask)=0A=
+		int depth, int *remaining, gfp_t gfp_mask)=0A=
 {=0A=
 	struct pnfs_block_volume *v =3D &volumes[idx];=0A=
 	u64 len =3D 0;=0A=
@@ -473,7 +474,7 @@ bl_parse_concat(struct nfs_server *server, struct pnfs_=
block_dev *d,=0A=
 	for (i =3D 0; i < v->concat.volumes_count; i++) {=0A=
 		ret =3D bl_parse_deviceid(server, &d->children[i], volumes,=0A=
 				nr_volumes, v->concat.volumes[i],=0A=
-				depth + 1, gfp_mask);=0A=
+				depth + 1, remaining, gfp_mask);=0A=
 		if (ret)=0A=
 			return ret;=0A=
 =0A=
@@ -490,7 +491,7 @@ bl_parse_concat(struct nfs_server *server, struct pnfs_=
block_dev *d,=0A=
 static int=0A=
 bl_parse_stripe(struct nfs_server *server, struct pnfs_block_dev *d,=0A=
 		struct pnfs_block_volume *volumes, int nr_volumes, int idx,=0A=
-		int depth, gfp_t gfp_mask)=0A=
+		int depth, int *remaining, gfp_t gfp_mask)=0A=
 {=0A=
 	struct pnfs_block_volume *v =3D &volumes[idx];=0A=
 	u64 len =3D 0;=0A=
@@ -504,7 +505,7 @@ bl_parse_stripe(struct nfs_server *server, struct pnfs_=
block_dev *d,=0A=
 	for (i =3D 0; i < v->stripe.volumes_count; i++) {=0A=
 		ret =3D bl_parse_deviceid(server, &d->children[i], volumes,=0A=
 				nr_volumes, v->stripe.volumes[i],=0A=
-				depth + 1, gfp_mask);=0A=
+				depth + 1, remaining, gfp_mask);=0A=
 		if (ret)=0A=
 			return ret;=0A=
 =0A=
@@ -521,7 +522,7 @@ bl_parse_stripe(struct nfs_server *server, struct pnfs_=
block_dev *d,=0A=
 static int=0A=
 bl_parse_deviceid(struct nfs_server *server, struct pnfs_block_dev *d,=0A=
 		struct pnfs_block_volume *volumes, int nr_volumes, int idx,=0A=
-		int depth, gfp_t gfp_mask)=0A=
+		int depth, int *remaining, gfp_t gfp_mask)=0A=
 {=0A=
 	if (idx < 0 || idx >=3D nr_volumes) {=0A=
 		dprintk("volume index %d out of range (0..%d)\n",=0A=
@@ -534,6 +535,11 @@ bl_parse_deviceid(struct nfs_server *server, struct pn=
fs_block_dev *d,=0A=
 		return -EIO;=0A=
 	}=0A=
 =0A=
+	if (--(*remaining) < 0) {=0A=
+		dprintk("volume topology too complex\n");=0A=
+		return -EIO;=0A=
+	}=0A=
+=0A=
 	d->type =3D volumes[idx].type;=0A=
 =0A=
 	switch (d->type) {=0A=
@@ -541,13 +547,13 @@ bl_parse_deviceid(struct nfs_server *server, struct p=
nfs_block_dev *d,=0A=
 		return bl_parse_simple(server, d, volumes, idx, gfp_mask);=0A=
 	case PNFS_BLOCK_VOLUME_SLICE:=0A=
 		return bl_parse_slice(server, d, volumes, nr_volumes,=0A=
-				idx, depth, gfp_mask);=0A=
+				idx, depth, remaining, gfp_mask);=0A=
 	case PNFS_BLOCK_VOLUME_CONCAT:=0A=
 		return bl_parse_concat(server, d, volumes, nr_volumes,=0A=
-				idx, depth, gfp_mask);=0A=
+				idx, depth, remaining, gfp_mask);=0A=
 	case PNFS_BLOCK_VOLUME_STRIPE:=0A=
 		return bl_parse_stripe(server, d, volumes, nr_volumes,=0A=
-				idx, depth, gfp_mask);=0A=
+				idx, depth, remaining, gfp_mask);=0A=
 	case PNFS_BLOCK_VOLUME_SCSI:=0A=
 		return bl_parse_scsi(server, d, volumes, idx, gfp_mask);=0A=
 	default:=0A=
@@ -567,6 +573,7 @@ bl_alloc_deviceid_node(struct nfs_server *server, struc=
t pnfs_device *pdev,=0A=
 	struct xdr_buf buf;=0A=
 	struct folio *scratch;=0A=
 	int nr_volumes, ret, i;=0A=
+	int remaining =3D PNFS_BLOCK_MAX_PARSE_OPS;=0A=
 	__be32 *p;=0A=
 =0A=
 	scratch =3D folio_alloc(gfp_mask, 0);=0A=
@@ -599,7 +606,7 @@ bl_alloc_deviceid_node(struct nfs_server *server, struc=
t pnfs_device *pdev,=0A=
 		goto out_free_volumes;=0A=
 =0A=
 	ret =3D bl_parse_deviceid(server, top, volumes, nr_volumes,=0A=
-				nr_volumes - 1, 0, gfp_mask);=0A=
+				nr_volumes - 1, 0, &remaining, gfp_mask);=0A=
 =0A=
 	node =3D &top->node;=0A=
 	nfs4_init_deviceid_node(node, server, &pdev->dev_id);=0A=
-- =0A=
2.43.0=0A=
=0A=

