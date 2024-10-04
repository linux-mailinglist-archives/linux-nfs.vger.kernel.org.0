Return-Path: <linux-nfs+bounces-6853-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F17BE98FF4E
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Oct 2024 11:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 190B91C217BB
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Oct 2024 09:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0567136671;
	Fri,  4 Oct 2024 09:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="uev6nA5G"
X-Original-To: linux-nfs@vger.kernel.org
Received: from esa6.fujitsucc.c3s2.iphmx.com (esa6.fujitsucc.c3s2.iphmx.com [68.232.159.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BF1140E30
	for <linux-nfs@vger.kernel.org>; Fri,  4 Oct 2024 09:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.159.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728032766; cv=fail; b=VJlxoN+6nAn2Gj6ZCDYCOH/1x8GSWy5G4BVqtbI0VgolG/tqv67zKuYkvcjGrw+nMzjj78laYRNl4t5D/2o71dI7CgWbK6opRKLyCbAbZPVPgGiJCAUcj1Dg7soCH1+3mx86u9PJGSEwUqVtS8O/S+RUDG+4hoSnmepyFijLuk4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728032766; c=relaxed/simple;
	bh=kymWXJygJ+kIXc8F6QeF8PWJtnikEpcNO0taA8tiEjE=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=OUo+ylmgDKs66G8Qu2D2hmWfiKqaIBDgIoCCMbbof3htqfvByBmUyEPI79vS8bX+UzdGaY4SIOKghetzdtUI9tJHIRNrd3sTeYny0GNT9zM2rKHkcHzsvY4NiCyn2Ww4JFH4NLc0q28XF60YRymdDkkkbiN99DrxpjdeO52d+Ro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=uev6nA5G; arc=fail smtp.client-ip=68.232.159.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1728032764; x=1759568764;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=kymWXJygJ+kIXc8F6QeF8PWJtnikEpcNO0taA8tiEjE=;
  b=uev6nA5G6AE8nI0d7QRKMiYnG42Ap2nEvwJFy/Fgj/kWah4tzFEggD4j
   aP514N0gt700mBzgSAyXX7GyO4WdYZ4k1uNiqzKexuH0BsCd19GkhSrs7
   sb8gaqPzp++2M53F1FtK1sGbFstIsmdM32NUeEL9B1QlBkMZdNOF9D0NX
   OzpxFalZ4GirTb0Ae3YJ4vEKRAOg5SvRYIyXA6tgGeVRx2VJ8fo+lysIg
   Uqq0T+4H0eilTl08mY6YMq5bhzk96Y9SeJpII0hTDQrnliXlt/2tWR+rg
   j31qOaW+PlWdVYViKnJXK54hFrWt5ZXWhZv5qqWz/qDM6jb6lfRicVt5n
   g==;
X-CSE-ConnectionGUID: PkRCmlvZRlG5OOs7llD4kA==
X-CSE-MsgGUID: 7V+PnLiUT2aoQQS2yvygMA==
X-IronPort-AV: E=McAfee;i="6700,10204,11214"; a="132721831"
X-IronPort-AV: E=Sophos;i="6.11,177,1725289200"; 
   d="scan'208";a="132721831"
Received: from mail-japaneastazlp17011026.outbound.protection.outlook.com (HELO TYVP286CU001.outbound.protection.outlook.com) ([40.93.73.26])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 18:04:49 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TPWtgG/Caa64/GkiCyNwa/PTWathkCEu91Cl0XRiDXn+N70c9UtoC46nUPrRV1pqUsmQ7UcuSff0/akUpL5XO1fk8Cexn7+lDhNrLbFj6+Z2S4TF7ZM9bpem5ACR6WP/QUsBF4v76CA9xon1LniVe2VoUPHKGvuxLGAJE9vg/FJ5YidD0zXU8XuEA40E9hFfqifmTLFzJTb3LYnbol3i+eh4ZrvmAib8o4IrBiAlKK25G857n7TEzg/ZELZafi7zXvMf38nAwD0jChyGSHiTUNN1PxOTi966zFehS5cTdAkdFAPNNIiUB7wbYJqikeetTWajTeUwsfDd5xmcc0vRFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TqJruTllwjINVLcnnMoeK7PIJHcWo12CDV87N4bWCXo=;
 b=MjEg1Ljq6Fq2uVPIq3mVuW3p64M32+nbcImVG2x3hy2YnRizAJzqHAZuQdqkaXI+sTohunra0EoOYDdYcFYX+WmDdZAgAuGd8cqemUmuDOwRVdqZLa7M9O0GK4e9hYrAoTlK2Q0Z/Hc0l/RwE7tsAKj5fK9TCq6z5qQIhAgW65z41lWE91msGTD/FYVJYWFllmTbrnxw7H7ezgW5N+jLjCTRKxhCYCCalb7jpFahoGxvIp9dzmQEwxMiZbVTyWYRAghqp6gxk1NXUIcyKxTpOVIoLc7tvzA/bFl1MAtI6005NKLbla/0W6ELw7jzMVQxIyOlVNvK+e7HCfwoIgLT0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSZPR01MB7772.jpnprd01.prod.outlook.com (2603:1096:604:1b4::7)
 by OS7PR01MB11820.jpnprd01.prod.outlook.com (2603:1096:604:23a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Fri, 4 Oct
 2024 09:04:46 +0000
Received: from OSZPR01MB7772.jpnprd01.prod.outlook.com
 ([fe80::df28:316e:ef65:39a9]) by OSZPR01MB7772.jpnprd01.prod.outlook.com
 ([fe80::df28:316e:ef65:39a9%4]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 09:04:46 +0000
From: "Seiichi Ikarashi (Fujitsu)" <s.ikarashi@fujitsu.com>
To: "'linux-nfs@vger.kernel.org'" <linux-nfs@vger.kernel.org>
CC: "'smayhew@redhat.com'" <smayhew@redhat.com>
Subject: [PATCH] nfsdcld: prevent from accessing /var/lib/nfs/nfsdcld in
 read-only file system during boot
Thread-Topic: [PATCH] nfsdcld: prevent from accessing /var/lib/nfs/nfsdcld in
 read-only file system during boot
Thread-Index: AdsWOjXVtImMI0OWRkCXWrVaBy7hTA==
Date: Fri, 4 Oct 2024 09:04:46 +0000
Message-ID:
 <OSZPR01MB7772A3965EF12B8BEBFEAA7A88722@OSZPR01MB7772.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=fe68d520-0fb5-4044-85b0-a382bfde0a4c;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2024-10-04T08:47:37Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB7772:EE_|OS7PR01MB11820:EE_
x-ms-office365-filtering-correlation-id: 91853719-4725-4db2-cb2e-08dce45397ee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700018|1580799027;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?VXJYR25PMkt1MkJDRVh0UzNJR1p5MXB0NnBycnA0c05MMGEvSzh3eTZC?=
 =?iso-2022-jp?B?Skh0N1ZjVzI0V0ZnaW96N2dYbm5vVm9rNHJWeVM1N0t6eElEZk05dk5W?=
 =?iso-2022-jp?B?S3RGV3dycjhpQTMxK3NJVXY4V01tREJFOFp3QzBIbWw4UUFTS2gxSXFu?=
 =?iso-2022-jp?B?RWcyY2cwRWMzdEsvUmNpR0Z5MUR3WkdsUDg1WlV3QTBtYnhSeDI2bWky?=
 =?iso-2022-jp?B?dXJ5WTc0aDNITHFScmJjQnFzUnZzUy9VWWl1R0FRWUNsMGdFaWIzN1hp?=
 =?iso-2022-jp?B?c1ZhTDFpeDVMQzBnYmwwRFJqWnRQTXIwVHFVdk9jMWwvTktHRmtZYWZw?=
 =?iso-2022-jp?B?N0wwb0I2SUovakxkQ3dJTHN2TVVEZW10WXozNXVmS0Y2eldqUCs3Ui9M?=
 =?iso-2022-jp?B?eTRyQyt4R1Z2WUF2aEZVSUpvNXNGS1Y1VDVPa1JNNSttR0wvRTJ6Wk93?=
 =?iso-2022-jp?B?MEMrcHZVK2RHNVRJWlBFNTVoMW8zOXYybnlrTDdpK2kyOVZab3NjM2Y4?=
 =?iso-2022-jp?B?MGpIOFAwS21oNmpVUnlOVllXQ3FPeDlkclNCai9FalhBbkZPTFRDckJ3?=
 =?iso-2022-jp?B?dDFBdzU0Nkx3c0JITmpWMXFkQ3FqRGhoVHhibnhGenF0OFpPZ0VqZWNw?=
 =?iso-2022-jp?B?andDZUN6MWV6RjVIQ1hFZnB6L3RyY2hJUzNacW1NSUF4aE0xcTFqOEgz?=
 =?iso-2022-jp?B?bTVuWkM0MlFWZFBaaDBkTHorNUZMdlZMTnc5WnF5RFV3WWx3anc0b1pM?=
 =?iso-2022-jp?B?S0NTMVRDbGJvTk5qNVIzWUxNYkM1NGUreXVab3EySEdFVE5nazJKemF4?=
 =?iso-2022-jp?B?RUt3ekdJME8yeU9KdHJyMy8xRy94QlZOWDlRU1VOZFZJSVU4RVJicnow?=
 =?iso-2022-jp?B?VklLbWQrV2lHOS9XcWl2cWJ4YW1mZ0ZaZitPUmo1T2xkaEEvRytGeDIx?=
 =?iso-2022-jp?B?SVFraGl3bXFSODI0VXpuRUFBYlhybnU4U1lWQVh6b0VpbVFUZGZrbm45?=
 =?iso-2022-jp?B?K0o0YUQvMEYyRmNFaE9Ib0Jyb3dHTXoyRzBObW53dktnazdiQ0x6WWZy?=
 =?iso-2022-jp?B?ZFBMdWt5d05XNWRyUEYzd1FPNFgyZGlsdXd6bWt3VkZkNW1qQ0RBRVFE?=
 =?iso-2022-jp?B?MC9NSi9CYXhCbmpmY1RMMFhpZklvaDlUekxyM013Y1I1bVUxV3FaRWg2?=
 =?iso-2022-jp?B?UVJ4eStQRGxSNmxhdGpLbURvdW1lSlQ0a0Q2cDZybmd2U2U0VGFqaVg1?=
 =?iso-2022-jp?B?S1QvSVhGdVZrcjdVWk1RWUNkUDM0bXlvQUh6UERaSUt2bDc1ZW44bENY?=
 =?iso-2022-jp?B?bHUwMldCSHJFQjJnbTE4V3Y1Z2hRVlM4Yk9NR21YR2NyNlRFUVFYaGFZ?=
 =?iso-2022-jp?B?SzM5OGtKWDIwOTAyMUh6UlhucGhwYmt3WklCNlFra3RKR1k4TXJDYnI4?=
 =?iso-2022-jp?B?ZjIvbzZGWWZzMVJwVFpLZDNVUnZvUEMxSlNIY2R2VE1mQi9GTkppbVBV?=
 =?iso-2022-jp?B?VTZnMitTOHIySHJiR2tyU1crdE83ZExIMkNGNGtTK0Rzd3ZIdVlHSWlF?=
 =?iso-2022-jp?B?ZDljODJBNFBIaHdvTko1Q1Y0UGlBSzBHWHptcG5tK0NSSFErT01OZkVh?=
 =?iso-2022-jp?B?YzFxYnVGMjMydkRpTXc5bGJWbkdTY2l0N2tWc1A1a2pPdHJnVU56NU1v?=
 =?iso-2022-jp?B?TFh0UVg4dkpsS0VVWVEvUGVKVG1UZ1l6T1hlMVhMVUNScUsrcm9GclE2?=
 =?iso-2022-jp?B?S2kvc09EbUo0aEZiaUs5U3JiczZTQjBlekN5NHJFWW4wRVk1MWFKYm5m?=
 =?iso-2022-jp?B?RWtYWm5MUStsUVNNWURSM294ZExTSEd2SlRoSkNleDEvVDdXdndSWktX?=
 =?iso-2022-jp?B?N1FjTzRONTc2eXVCSk84c1FFZFZSWEQ1enVNeTNLVUhGVENkZE9MOXc2?=
 =?iso-2022-jp?B?UjhYVUFnWEtEenJla1dEVTZ6UVlmd0VYMS9SWWpLbWRmbHVFSGRZTGxo?=
 =?iso-2022-jp?B?OD0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7772.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?Mm8xZ3REMVd6cEJaRjBPakVQZXRQV1BWYm9ZT0swYXBxcm8raVU2MXU2?=
 =?iso-2022-jp?B?UXBzQ3pES3JQd1hVQVdhWnRpOVpld2JPSmRHakNNNlRGZG9VU1M0VjZ3?=
 =?iso-2022-jp?B?bzh6WFlvMHpZcU82L1o3UVNaaDJpNURDVjhISDZ2bURCS0ZoQ3BQamcv?=
 =?iso-2022-jp?B?SWVqTWxCcUFHeDRpVkJDbjBORGRYbWFBM2dRS24reW96S3ZMc0lueWkv?=
 =?iso-2022-jp?B?Y0RncmwvRXJLMmIzVHBYdlR0dzFHYUxiU0pqeVpFdk93aU1YWlBVS0Q0?=
 =?iso-2022-jp?B?MUtENFpHa3BqbWhBMlZVZTg4Wi9NM2hnYmxLcGtFVVNtTUh1R2pOMEdM?=
 =?iso-2022-jp?B?clV4dW5sT3d0V1pVTWF2M016QjR0UTcrSnNQZXp2eWo1MnE3RUFxQ0di?=
 =?iso-2022-jp?B?aWFURWdUSEpYY21icUZXL0d5OUNBVUdPcTlTNTY2YXZjZkM3TGhxRzRj?=
 =?iso-2022-jp?B?c0FXcEc0WUgxbVpuS2Z0YSszTFFrTG5sa2xHOHNGU2hSZmE2STVCdDEv?=
 =?iso-2022-jp?B?dXE1YStMdDBuMlYvNnNKSjF4aThmRUJFVzR2d0o3M3EzUXdQaG9BSFN0?=
 =?iso-2022-jp?B?TnVSSVk2YmtFNTdlSWNKN2tyVm5WVG40eG8yM3puT0txREU5b3RacklJ?=
 =?iso-2022-jp?B?OC9DUEgvM00zYjlUNU8zVTJjNDREMG45MlJNZkpqdWxwelZhUHlXV0Np?=
 =?iso-2022-jp?B?LzFzeTNXa3pSbjdhU0Yza0hVUDVVN1AwcDdaOFlVNnJoRFgrTElQZjdY?=
 =?iso-2022-jp?B?YjJwRi9jS3pUR3lSR3Bib0FCYVRDd1NlNWpPRkQxZkxxMkhZdFNDRVI1?=
 =?iso-2022-jp?B?VzNWNjhFMVNUMkdQdmN5ZlByN3RmR3ZwbE5ISkxiSi93SEw2d2kvWGZZ?=
 =?iso-2022-jp?B?ZnA5NTI2aW03S2p4a20wQ3M2L3RUWndOa0dFSHBFQ2w3c0NrV2d1Nldp?=
 =?iso-2022-jp?B?dlN1NWlqZUtNOVdKZDQwSnZrVFZaMHZESmQxRVF0bmFhRXVhYlJ4a3ZQ?=
 =?iso-2022-jp?B?UjVhbm1wMzBDVGpkcVVXd1NvTmh1bHExbmM3ZXk5VmY0OTZUZ3FkOHJO?=
 =?iso-2022-jp?B?d2lmN1RJaE5ycVJtWW80aXkzeDNEMFEvNi9hWjlSZnRIT0YzZnhZKzBW?=
 =?iso-2022-jp?B?eGpyLzZOZUIzTHRtQ1BvN29rMWYrNERZQ0R2THNOUHhJdWg3cFhDNXp0?=
 =?iso-2022-jp?B?MmpCckorSnFwSi9sSTd5Nk5XYkZlbktWekJXcHFxa3RYYWIxdjZEU0Rs?=
 =?iso-2022-jp?B?ekN1T3p6bjduajhocmRJZEtPRHNueGZJSXZZUGFYdkJCVG9GTGRZMHVq?=
 =?iso-2022-jp?B?WEZGSWlZTDRZMDhvWHhNblBtOVFGWE9RTWhXc0ZSYXdBL0NDRWRSNjE2?=
 =?iso-2022-jp?B?aHBVVkpEV3NZY3FxOXZzRUE4Mm9Gc3lQcmJGRWxWOWtLZmQzR2lNQVJi?=
 =?iso-2022-jp?B?a2x0RmRCUjh4RW9rMUplTzgrbFJkNGFjTUxYRy9NM2E1a3UwMEtmZnVD?=
 =?iso-2022-jp?B?NGJZSW80K284S1cyMGpjOXRCM0ZPWnZ6SG50UCtiZmxoNjBMSjFKZEM1?=
 =?iso-2022-jp?B?dnpoRzhsZzJEUzZ1KzJtSXBRQ1BvOFFhdC81Z2N5eG5zTEIvb1Rndjho?=
 =?iso-2022-jp?B?cEtZWk8rQWp4ek5aVEw1bDUxZDZYbisrOC8zeHhyZWVzUzdZWS8vTDVF?=
 =?iso-2022-jp?B?VFpNWERHVVdvbUhvT25xeGlpR1dKcE1PUVJvNEQ5eDRJVUhST3UyTGF0?=
 =?iso-2022-jp?B?UFJVMjFuUWRISVZLdU5jelI5QUdWQnp2QVA4RFdCaVByeklSMWQvYkpi?=
 =?iso-2022-jp?B?d1lVWHNqM283VEtXZWRrSzlzMUN4a0NCNjR4a055eHNlWGVRR2Fhejhh?=
 =?iso-2022-jp?B?Q3U4andpWVNhcHRadTAvVzYrRHZEdFFVUEpDM3ZLaUEyYzVOb2NiQzBV?=
 =?iso-2022-jp?B?cWhpL3g0amxCZE0yRnFhT3V2WHBDa3JiWnBrMXFUUnBlWkhqOW1FY1Vp?=
 =?iso-2022-jp?B?Nk1keEpwZVNWTitNN2FIN21aeUh1RkNyUS9WT3ZRVlJyWFMzVHNsamhJ?=
 =?iso-2022-jp?B?ZnE5U1JROWI5MzJNVGp3QlVHbFBHT3lFdThCdUIrZ3hpQjRYM0JMYXMv?=
 =?iso-2022-jp?B?WEtiV04xMkppeWJ5dHVSNUNESEFEOWpFaTdNYmdkb0I3ZjVtSmJ6UnJm?=
 =?iso-2022-jp?B?cW5ZcnBFU3V3Y3piZFVrYW1HdG5HTFFrR251VVNtM1daTWtxbm8rZ0Vs?=
 =?iso-2022-jp?B?L0htQnk3eXVTcnF2RkJPWWlVUldFaFI0cmpid1VOL20vMEQ3OEdvaW9s?=
 =?iso-2022-jp?B?RUJUNQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Ze9DkJg4uouDNqc/R0gVO+LOIr1lB4rcrmDnrS3uIJjwwC1QsU2ZCHkQKkivKplJquY5qR0SW432hmzeduFLZ1otn/hnKrUqaaPxeSfdZf+X9W+c6fXAw3H/Vn6hWjlJqUlbzNwP34lfzYi20UyyaSukM9jnAhzM2cVscrJtpXtZbsGrqe/G1p2TW5pQ64B4/2fsa2EasrXtX4L2hcIg2lloz79ZQuDCcgZ4pHcZKY6zXYEoZc+XS4qqEXfpLWMYvbDfhoxDE0CiWDSLe+CbCneqXVNHj9yuKOkz20/CDo/U4AxYz7Q7f2wv3SEMFEUvEMwtgLaoTMIepAPSHARDvnbcy7QmW2Me4APbKzpUJRVHELPDuosvjX46WvyvGt8NRxrsWreX5o+DsQBt1Kj5H76ztMM9n+nlCawROWrXGbIjd8J5nU4ld/6yr7nzKxpOqxYVL6O+4W7NnPHWrG4QV9N9ZdK/ecgpE3AP4ZMR0Wg748tETkAvkJ91NJ3tErNg5ZOcaXz0TGSglKVhxyIMW+DD92ARUHEbdQfCHLpr9m5vLjUUGJwuVC+88Cm2VCQHun385HVd48bPeAc8+bR48aSNfUiTP5+EVw0Vwcz+r9Hy6FPX4MtdLTrUUlqVaDzq
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7772.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91853719-4725-4db2-cb2e-08dce45397ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2024 09:04:46.1802
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7/0Lb1Hg2oZpFT1F3UT3VR5BjEyBiczy92QrbeeStrhuZmRvSuu/LRyBDPDaTJtj7uYbaFwfXNXWT0f4+47BgC7QFByDYoGsDSmj9DoHPXE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB11820

I saw a VMWare guest that hit a rare condition during boot;
nfsdcld started too early to check access on /var/lib/nfs/nfsdcld which wer=
e
still in read-only file system as follows:

  nfsdcld[...]: Unexpected error when checking access on /var/lib/nfs/nfsdc=
ld: Read-only file system
  systemd[1]: nfsdcld.service: Main process exited, code=3Dexited, status=
=3D226/NAMESPACE
  systemd[1]: nfsdcld.service: Failed with result 'exit-code'.

nfsdcld.service needs to wait the root file system to be remounted at least=
.

Signed-off-by: Seiichi Ikarashi <s.ikarashi@fujitsu.com>
---
 systemd/nfsdcld.service | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/systemd/nfsdcld.service b/systemd/nfsdcld.service
index 3ced565..188123d 100644
--- a/systemd/nfsdcld.service
+++ b/systemd/nfsdcld.service
@@ -4,7 +4,7 @@ Documentation=3Dman:nfsdcld(8)
 DefaultDependencies=3Dno
 Conflicts=3Dumount.target
 Requires=3Drpc_pipefs.target proc-fs-nfsd.mount
-After=3Drpc_pipefs.target proc-fs-nfsd.mount
+After=3Drpc_pipefs.target proc-fs-nfsd.mount systemd-remount-fs.service
=20
 [Service]
 Type=3Dforking

