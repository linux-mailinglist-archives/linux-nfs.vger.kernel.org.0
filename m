Return-Path: <linux-nfs+bounces-20980-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMLwFchL52mX6QEAu9opvQ
	(envelope-from <linux-nfs+bounces-20980-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Apr 2026 12:04:56 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E094394E0
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Apr 2026 12:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5025230148BB
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Apr 2026 10:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0631138836C;
	Tue, 21 Apr 2026 10:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=verivus.ai header.i=@verivus.ai header.b="gBpl1IrB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from SY5PR01CU010.outbound.protection.outlook.com (mail-australiaeastazon11022108.outbound.protection.outlook.com [40.107.40.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967143A8738;
	Tue, 21 Apr 2026 10:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.40.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776765838; cv=fail; b=m0DrwLtBula4OwGBLVX6AWNhBr54cJsZpkwfPZrNFIB3heWeLqzdJiPQyehITXxiZbbT3/rH77ri8fDtwV8wbB0P0+Fp4Kt1CCONwROPbnG0j7POHVbeySJ8nQKXvmEO9JIJSOVKRwMepypZ+mDTDxWabiFeY8OETRwpWiV8eA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776765838; c=relaxed/simple;
	bh=aXcVBxawkF0cTDEs9UMKTlF9pbddXzVGWcjbzlzDfVU=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=OYa2BE8mL28GzJFkqYPtpPI/2ml6QghcBRSBNDchiNz7Nu7hjCNVz3yRe4HNgW7NBjAUWYgMKthseswIkW4SlmNWjyjEGeSqSVGrL/R68yoSWly64Y2Qrpznefa7NPunLuwQiAs9v1xsW8TNIRLJvUORMe6CcnLCWnl8j0BApE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=verivus.ai; spf=pass smtp.mailfrom=verivus.ai; dkim=fail (2048-bit key) header.d=verivus.ai header.i=@verivus.ai header.b=gBpl1IrB reason="signature verification failed"; arc=fail smtp.client-ip=40.107.40.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=verivus.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=verivus.ai
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sqe3XEsABNLoqFLdIL4f3q3ShaUvn1DPAbO0Ia8+SiQ+Yt330fMkRiHJiptEkAtUv7a6bgzT1y/0c0Lk6If4FYIHQTEsk7poF/e8Ilwgjtkc3bo7mrAKL3arnW4+s9ysAmhqKn/w0PPxGXawDeJEZk6cM/iuetg+fQMiHC/bwA1se17zJdFjH+d4ujEEzCZlsuapMcvR1jkJBAWyWDDQ8Ty94RtQ5Tf7cYNjSwZDkLna/NKDj3TtxZlkWcyhoo8BiTtlXClGp6np0kPAXT5PAGc5H9VcYvf8EkKTTuhwPrZs4+jBRT/4FTyZfgi7QKwqLfRAczdiYgdZk5iCziHQHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tPtICyVoNelKc1GYNyyFO9OY0cjiBqZQ7xqaVe5P7bw=;
 b=Xdrkm9/yORCv7Qtpq5A/Smc0Hzj1DI0kN5Xe0TSUXvfrFI1816wXmS3NJJBXO33TULzN6kSe9iVuot0T8Agqwjccm92OukGiOj21Z2ij4OGRcOBBtTSh0Z5KzNdJlrVyb8RD3qviop36VT5M/0y8vE/hdXLldMeYAvrUt1lF7dd17FsqoxZ8IGWAH8jzYndpiDwuCvk/sfx325yKgmKUsljB9obRfW68/yaNdBDOCLWTE9ckP9TAQZXD8vV4BATk6uYkAiEoNc2tWkxGeBrqIhRV1Y8/mCB69fNfsmcvHHt5xy3XFVRuPNTwqPi8R1p8RG8XX1cvv+QaMCI0/LHQfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=verivus.ai; dmarc=pass action=none header.from=verivus.ai;
 dkim=pass header.d=verivus.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verivus.ai;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tPtICyVoNelKc1GYNyyFO9OY0cjiBqZQ7xqaVe5P7bw=;
 b=gBpl1IrBy4ukhffrIOFfIAJloqLqFxVByy+OxFalX6V1Jyjd18746QlUeQw4NkdC94/OEVwyU0GoKJMqb6nGN76H6GoITSxVCY/oX9Vem4HmmvwuoPeQhr9dj5n0LavQsQ6u6BW/iWbgGALAfo+pb22b5jrtCE/OnwzeS6QJ5rPcnlAc/puiRT1hLqwgHwafo3Sr9BlcbLDNaEyUMLzQLUwfBmbKmCPoq3v+ncqliRIOi+xlOVxTvdpEQ4s948Crl5tZCASMoaK8VTbJdIBbCSLelrlHPO7NtwXjKOhwrdptIP8p5n8qf8W//Gdjx9Ixb7dkLhfq3gTiI1eOj17NTQ==
Received: from ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:22a::5)
 by SY9P300MB1529.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:2d6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 10:03:40 +0000
Received: from ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM
 ([fe80::1e3f:9cb9:4a95:b5a2]) by ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM
 ([fe80::1e3f:9cb9:4a95:b5a2%5]) with mapi id 15.20.9846.017; Tue, 21 Apr 2026
 10:03:40 +0000
From: Werner Kasselman <werner@verivus.ai>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
CC: Christoph Hellwig <hch@lst.de>, "linux-nfs@vger.kernel.org"
	<linux-nfs@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, Werner Kasselman <werner@verivus.ai>
Subject: [PATCH 0/2] pnfs/blocklayout: harden GETDEVICEINFO volume parser
Thread-Topic: [PATCH 0/2] pnfs/blocklayout: harden GETDEVICEINFO volume parser
Thread-Index: AQHc0XYh0byrc61ZFkCBwCLmStDlTg==
Date: Tue, 21 Apr 2026 10:03:40 +0000
Message-ID: <20260421100338.1227152-1-werner@verivus.com>
Accept-Language: en-AU, en-AT, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: git-send-email 2.43.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=verivus.ai;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ME0P300MB0853:EE_|SY9P300MB1529:EE_
x-ms-office365-filtering-correlation-id: 7caa47a3-547b-41d4-c72a-08de9f8d4392
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700021|18002099003|56012099003;
x-microsoft-antispam-message-info:
 8axu93fhtRKWD42pm6ZeLon0JPvaPUmTNeC8YNtgM9tnvzawyUucyCHe82aJrsdWqgDoQTI8ILkx9hrdcHpo5FrCM4rO2wEz5Bkkmpgu5ObFQKQZS+50Pg3b9Ju6YaiBTiYs0SMYuTb/N9pH/kAFcB3soO8dke4Ih0QME1tcVaYhIXTSLQFB6udLwVWa6wPwQUBs8VF46HbC7Tfyv/Jfi8qQbF2q8Z1eNhL9dCrQtsy7gK/6M66AVB1SgA2E1DHnXeaxvN39e3PGpW4MDcRTz3qHHlqaHXmU5OsB4GXXUCjShYQtKJ0NUScT5itRCL0xbyqmXvNWS9Q19mJ12MlyBtDADOYDEE+yH5wUEr+1yD/n4qLCvxDlBcKwX9emmoMRzouAleME2kCd4NaulL2rbaaL6KBP8NDrzjQDHD/m0QwFXNdGHdMEX/53tDwAGrp//gp7j6tAjj6JhJWS8Z3Q8dxBGflHXDwFgOMySZoqbVIdU2xlm7e/y6SMT6dz8iWi0M+lesDecx5pqvlyj0y90BHN5sLcXK4MYtqiQ0jQkoYNAlQM6RYG7z9hzlfyH8/djkJ2xkMrN2IU4eeqVj1QqZnrtDE97WY0fqSVnIEpwIdO4vcKivIIThwcYhkm6JjGVP8sRRmTqwvbPL25xVsAzRrim3fqV5TxRPv7G2jmSWsdPrvtLRmxA+P2EQqVQpfa7NiDqmTWGZT6MMxoUIBKI1STUtPOk0GlYXtJbfm+tKUrDFqVqhPSim00XxY3KqbNj2u/yKYXbyxmnzfMP0n8muypMJNUQUWHC8Q2wVBJUdM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(18002099003)(56012099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?11t2cliS8yGjpsHDCHG68MO5RLWUGuWy0GjtYIY9gk3GWV37fZptpliyF2?=
 =?iso-8859-1?Q?yqUwX0BWNThCpG8xE41sWGEX3KVWFOBh/THQk9j4+q0YraYr5x/ilou7jb?=
 =?iso-8859-1?Q?ftZEQdAzzMjn5veNZShdecjxzBjmlL2tnbWT5z+OgcIHgEjC7pnJ11+llg?=
 =?iso-8859-1?Q?JA8jTzmJdDqntOIbQb1ArQi7yTeV7tlZVU++p5gZyqPXme2AA0lQV/8Lhk?=
 =?iso-8859-1?Q?NQUobzs7+K3UNs1iEf2XuYUc5QKI8WnkP1/JbmkabSs4YEuMFNOGYuwepJ?=
 =?iso-8859-1?Q?UzeG5XBkodqXH/J7C4aa6rIR5bYZsHg3k0qtm/hCavWXgqPLCfTtHiZWvK?=
 =?iso-8859-1?Q?Jo35u8s+8adMn0lg0wj514w5uNpDulSZsIZtkcTBFfiUa5wrUlNMgmd0zf?=
 =?iso-8859-1?Q?RxrHw0184aIx27V0bqJYuwmvZqxM0+tuMb8/IT2cSlDB2P+zBk24rUoJbu?=
 =?iso-8859-1?Q?sX94x9QFFFZTZoRbipMfGPp5DKyoRBi8F4kRaZb9DviGqXX+0Y9FUanKS8?=
 =?iso-8859-1?Q?ZxBb417XmX4Q6DxYrWw/o3a1iPAHKlTerhfC8u8wuQ1hVF58PTn/GYtMr3?=
 =?iso-8859-1?Q?QW+14ifeoDqU2vGqQuZQkSN04b99+yEVW2VkbyBlEtzIbIB7Pp3WwcGYi4?=
 =?iso-8859-1?Q?NANo4mIZYyLPXLvo+wR+6mZ5XiqjM63PXRqpqz2+wn7/2JStxVcJjVjeSL?=
 =?iso-8859-1?Q?FJWuyZ6QZ+k7dsry0QgjakMexc2HDC3c+PVG3xIbTjaC2oVfjWJH0DKKhB?=
 =?iso-8859-1?Q?wBSBlA/hygYmiGHtcaOYyPB7eTNj9zQLWrVJuHXTdBCsUbzGBdma/j3xZw?=
 =?iso-8859-1?Q?IIsOi/Jon5fvf6H7BFDJ+7h6RH2r0LTXSAwyCkpD0N13XLvTZYgy/j2nJc?=
 =?iso-8859-1?Q?6pebEiNfOa05Wo0dnKKXQ/7V9n6kz2OqiGNHStQaRtdePofHOTsB+MsWnB?=
 =?iso-8859-1?Q?rM8TwkyLJ/VTkn4jEgwoxqtaglwMpbOtZ3475dwd79TWQznzddn6WKyGnR?=
 =?iso-8859-1?Q?E3q01R7Uk5Hs0F6P39iHJHkasLOu2bWsHm+6jsdCqabbVOmPE8OmDs+Bku?=
 =?iso-8859-1?Q?h4L2WkTOtHTAs8tT4OND0QrLyWAW6GHIMzrzqeQFO+vrRy8OMVd19LCsZ4?=
 =?iso-8859-1?Q?gCiYTOcS1E8Z5/Hfya9fbicO/td7MvcM0D8mpZIZX3X3PKmqElHexXycQX?=
 =?iso-8859-1?Q?VnEZiudkWmayaNstcDnU9jU/44NY2Nb4XKPnk8wvNthCr0ZE0gE+HYzzsY?=
 =?iso-8859-1?Q?l4zz2spzQ1VhV1LlsxQovSvBQ1zI75gaFOBn2IncybIJebaNJ+4Wckh6z9?=
 =?iso-8859-1?Q?dz8wqpDvyjn/9XWTzPvyln9nrEpBGjIdUPbEXi76DwGSFUCJpnojsL60tt?=
 =?iso-8859-1?Q?QrqzKqcoYcIqC7FLAjTKK5QFNSAxAGYs3KB9MPvwSUFXJLTg2MYrxWPnvy?=
 =?iso-8859-1?Q?ywr+6iUSr3WKE3yIR12lgLKCQqbQTosN4JAAdhpdpAzY0D3cAeklFNNKZ4?=
 =?iso-8859-1?Q?R/0qnWTu1S5Niu/evoDbVZ0dt2RBcq/1ngD96R68q2Cuqmv3qmAkykYFkz?=
 =?iso-8859-1?Q?ut1eZ+O2BYj+k3imYRdkSWV3NfhA/h8GiLBOG5r4l0n1iyY9E/50P1SmaD?=
 =?iso-8859-1?Q?nUNmLce2Y96RkwV5HpeuWmDuHcBsj3KEXo24wor1a9PTEYeDyQszwAd7M+?=
 =?iso-8859-1?Q?gsFLFV9PZYfPQ2wSWS/syQVeDot9qby2FOgjSCzueLx0KvECyAir1XoKJZ?=
 =?iso-8859-1?Q?MEu0ODBt0+F0NdSQ3aXlltIN9H/MNa8HvLIhLsZEg11kW2EWBLPQuHhCmO?=
 =?iso-8859-1?Q?a4baMquI6A=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7caa47a3-547b-41d4-c72a-08de9f8d4392
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2026 10:03:40.5921
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ccdcedb0-4edc-4cc8-9791-c44ee6610030
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2FZ4wgG48qW+9xHVFg2s777JliBIQGtvZEst3jr1hCMVdeCZicPIzavG16IJwI6PiG9TbmpVY3XEAVomj+RbGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY9P300MB1529
X-Spamd-Result: default: False [1.64 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_REJECT(1.00)[verivus.ai:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[verivus.ai : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20980-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[verivus.ai:-];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[werner@verivus.ai,linux-nfs@vger.kernel.org];
	MAILSPIKE_FAIL(0.00)[104.64.211.4:query timed out];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[verivus.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 60E094394E0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The recursive-descent volume parser in fs/nfs/blocklayout/dev.c has=0A=
three problems reachable from a malicious NFS server:=0A=
=0A=
 - Server-supplied volume indices are used without bounds checking,=0A=
   causing an OOB heap read at volumes[idx].type.=0A=
 - The mutual recursion between bl_parse_deviceid and the type-specific=0A=
   parsers has no depth limit, so a cyclic or deeply chained topology=0A=
   overflows the kernel stack.=0A=
 - When nr_volumes is 0, the entry point computes nr_volumes - 1 as the=0A=
   starting index, underflowing to -1.=0A=
=0A=
Patch 1 fixes the memory-safety issues: index validation, depth cap,=0A=
and nr_volumes =3D=3D 0 rejection.=0A=
=0A=
Patch 2 adds a total parse-operation budget (PNFS_BLOCK_MAX_PARSE_OPS)=0A=
to prevent resource exhaustion from DAG-shaped topologies where shared=0A=
child references cause exponential tree materialization.=0A=
=0A=
A standalone test exercising all three bug classes and the fixes is at:=0A=
  tools/testing/pnfs-blocklayout/test-volume-parser.c=0A=
=0A=
Werner Kasselman (2):=0A=
  pnfs/blocklayout: validate volume indices and limit recursion depth=0A=
  pnfs/blocklayout: cap total parse operations in volume topology=0A=
=0A=
 fs/nfs/blocklayout/blocklayout.h |  2 ++=0A=
 fs/nfs/blocklayout/dev.c         | 61 ++++++++++++++++++++++++--------=0A=
 2 files changed, 49 insertions(+), 14 deletions(-)=0A=
=0A=
--=0A=
2.43.0=0A=
=0A=

