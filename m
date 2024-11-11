Return-Path: <linux-nfs+bounces-7848-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8559C38FD
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Nov 2024 08:25:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 726C7B20DE9
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Nov 2024 07:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8656A1547F5;
	Mon, 11 Nov 2024 07:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="Eqscrxtn"
X-Original-To: linux-nfs@vger.kernel.org
Received: from esa6.fujitsucc.c3s2.iphmx.com (esa6.fujitsucc.c3s2.iphmx.com [68.232.159.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC8A136A
	for <linux-nfs@vger.kernel.org>; Mon, 11 Nov 2024 07:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.159.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731309901; cv=fail; b=KA1tMjZ8+vtZpA70zEx+nfgGwRD9Id0aXgu7YZQ0AV96h876Vbgt9mxfCOVsjWWFM2mxN7J0JiqYIhxTFteyW+Rv7gA11+xnrKrypg+YPa2qrnVtr5pakd3BqmuTnbtF8aRY1jPhe/izMAIqYVjzbI9IfRVMaDVCL3w51kq3cSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731309901; c=relaxed/simple;
	bh=0Ui3GdkCr8yEI9NltvzaCRRZwWJ66dJ0DFirreMTZHU=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=NQAu3MZYShMeP+diR7DkumqnIFCcUYt3FQYIvTwRXZFERW5jjEETFHUI7pO696Dx0Oes3Hmk1409GqfgKSO1jQqTpQ5x3C1zZN0PsyzMjvZJtpl3IOsRte75ITBPlbqtCRdQEYJL+PXK2r3+Ee+4Ij5fDI9LZfAA4CHKNjH7gW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=Eqscrxtn; arc=fail smtp.client-ip=68.232.159.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1731309899; x=1762845899;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=0Ui3GdkCr8yEI9NltvzaCRRZwWJ66dJ0DFirreMTZHU=;
  b=Eqscrxtnk//XZILa313FmAjkVYMDHl5c/5GJEFXvQjooO7ocwUv9W8o2
   rd/3ziU+KyONziM+E5OFxL5LxpLVlXSVFjZ67f/06iua+WOt5QRrMm5TN
   b7CgsqxyBA807CghoSPP+2G/m/ENslaxVzR6PfrhVY6iluG0TQxut1gyI
   RkUSfybynWUdnLITPDsVAZipRyalRSOHsriZyWG0lUKm6gJO8q7DNwkhC
   57QIAtUvt+rvcailpTXfqfloNro0LiOqxqTwYfo8WNYEz7Wnl5bL99qTF
   lSNzjC9kPp7LfBLeyzZ65pMyl4g/Bw2f+h2ZqGhUwjUtgS5laTs2+0dSo
   w==;
X-CSE-ConnectionGUID: Sn8iBSuJQPqgGRCpfXG/6A==
X-CSE-MsgGUID: U/Mfpk/FS3+zPQh6HK5mhw==
X-IronPort-AV: E=McAfee;i="6700,10204,11252"; a="136452186"
X-IronPort-AV: E=Sophos;i="6.12,144,1728918000"; 
   d="scan'208";a="136452186"
Received: from mail-japanwestazlp17011031.outbound.protection.outlook.com (HELO OS0P286CU010.outbound.protection.outlook.com) ([40.93.130.31])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2024 16:23:41 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sdSBIdKVTwf+wOezQN/WY/EhU2PbO0HZax16+zv/hoP4Nxkap6ZaCTob4iHFTV8zFq1qaZRlkW/mbj6cjxoAXPL0XNeJ2S/FGGY4iwBQ5hw7nVTG1w0qqPpaC8jz0mWFkbtN0RZmFHTwi5uU61bf+9jGcpV4Vmk5qwBMLGWvlSkXCDCJeCCPdtMWsCDojGGObKte2lRjL504lOxtqoIQV2Z33z2ywxaJZhU/5y6TFOkdYadJRbdwZTMeUs2sQZJ6xWmIxT4G4MBGXuBgqMTm2z1JhPc8ZVVBjKZNxI38mo/m7AExlxX41h9A0782MKtlNxp9YyX9qkqe1ByRAgLmaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Ui3GdkCr8yEI9NltvzaCRRZwWJ66dJ0DFirreMTZHU=;
 b=GOIWIG1TW61Cli8/OsYn9N2cLsZDf7+aGq9Gr1F3s+xFZB5hiblqySCa9z7PEWsZP4MDUf3dJgm6Ocgo9QiGTAAtMZ1q37pqgk9pcK00/luz5E12HyH0Zoe1vlqJlVaer4bYHQFsh0q35VJU+cw9dBw7JSSMSKfSCQOSjiYMXdstIl7wbdRL8749Op/gu9/sxb9+8WZIDOdR0TssiwMay5wuFvrKxtgvkR/VGdD14H3+QhoGsiooHzNdViYkEC4VOco2zNWzgOKY8aZNhul/dYZ/odm3/V+hZQJoiCKSgcbdH5ccDN2WiiRyOhT3N7zuOVeHlYBSePjgMLX22ST5KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSZPR01MB7772.jpnprd01.prod.outlook.com (2603:1096:604:1b4::7)
 by TYWPR01MB8695.jpnprd01.prod.outlook.com (2603:1096:400:167::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Mon, 11 Nov
 2024 07:23:37 +0000
Received: from OSZPR01MB7772.jpnprd01.prod.outlook.com
 ([fe80::df28:316e:ef65:39a9]) by OSZPR01MB7772.jpnprd01.prod.outlook.com
 ([fe80::df28:316e:ef65:39a9%4]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 07:23:37 +0000
From: "Seiichi Ikarashi (Fujitsu)" <s.ikarashi@fujitsu.com>
To: "'steved@redhat.com'" <steved@redhat.com>
CC: "'chuck.lever@oracle.com'" <chuck.lever@oracle.com>,
	"'linux-nfs@vger.kernel.org'" <linux-nfs@vger.kernel.org>
Subject: [PATCH] nfs(5): Update rsize/wsize options
Thread-Topic: [PATCH] nfs(5): Update rsize/wsize options
Thread-Index: Ads0CNAGIEAUadG7QF6DMBzDxhWiYQ==
Date: Mon, 11 Nov 2024 07:23:37 +0000
Message-ID:
 <OSZPR01MB7772841F20140ACC90AA433B88582@OSZPR01MB7772.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=d62fb4e2-1d97-4f5d-92a6-a8090d9b46d0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2024-11-11T07:10:12Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB7772:EE_|TYWPR01MB8695:EE_
x-ms-office365-filtering-correlation-id: 57326c51-d2bb-40fc-4848-08dd0221c256
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?R3FVMTVVbDdFNVNGenpxYURtdHhhNWgxZHB4VC92TVYwUGp0M0tRblFT?=
 =?iso-2022-jp?B?S01QNzRUeHRlU09Pd3dHbGQ0TVc4Sk9UZDlrWE1OMkpaNlJtcWxZUzZM?=
 =?iso-2022-jp?B?VUsxeGJGRk5PL1QwS1RLaWVSU1lWQm9Xc2cwakRwOHRtWWtrWlNpVkNB?=
 =?iso-2022-jp?B?U2VGdkEyM1Zrcy9UTjJoK2JWVEpra1IrZHRCVUNFNlIvbzBDQkY1K0hB?=
 =?iso-2022-jp?B?REdXTTQ4ZTFQWks2eHNQK2orWi9EdjJQOC84dkFUU0JxZ2EzMk9IQnlO?=
 =?iso-2022-jp?B?SnVtSXdrQlUwTkRmVUlrRWFoTlU2bDg0ajdtZmNSVnZNNTNseGE4dDhi?=
 =?iso-2022-jp?B?QzNjWkZyQjJBSmVyanR6YVlNbzRET3NrYXIyRXo4c0toeDZpVmR6b2dz?=
 =?iso-2022-jp?B?VWZXT0lpcHEvQTB4SG1WSHFSTzJITkNLYzh4cERuNVdranFXMDFib0U5?=
 =?iso-2022-jp?B?ZkJjMnlVTW9xSWFTemxHcFFkR1JmYW9sbi9pSHVXZ3hFMmc4ZmNtdGdY?=
 =?iso-2022-jp?B?cCtYa21YeXVEUndRRmlpVmowcUdsME5PWkxieDFpZnFseFVlbkgyNkQr?=
 =?iso-2022-jp?B?Vm1xWG13bWZSTURjV0VtZExYSmpzQUs5SVlaVTFRWFJSU2FITVJjc2lt?=
 =?iso-2022-jp?B?Sm0vMzQ3WStEYmg5U3VrNFJLOHJ5N3dNbGlNSHpLM2lURlhJZzhMdEZp?=
 =?iso-2022-jp?B?SzNpTGdOQnN5NVAwblRNZzMxdG1yVFhPTmFFRUFtbWI3RzdKc0thSDZK?=
 =?iso-2022-jp?B?MmR2cGZzY3cyeEsxWkNmNFI0OVJFZlZLK2JVekpHMzJSV1Q0QTdqTjNM?=
 =?iso-2022-jp?B?dTdOMHBxa2tyTlVGaEM2NUkzS3ZINmI1Si9iblNpUElHUE5NN2VHeUlN?=
 =?iso-2022-jp?B?TWFKa1A1cXpLeXVYRE5SajFGVUNnbHFzUHNpRE9JdVk4Mmk1eVJQMzZv?=
 =?iso-2022-jp?B?RnYyd3hWVGgxTlVTVzBEQWxHeXN4QmlGQ1VMZzZHOWdZUEkycExiaktY?=
 =?iso-2022-jp?B?QWJQZ1dKZ216UFNoNDBlOFV5a1NvRk83TExVeGZyZzR3b0RhZUxWNkhJ?=
 =?iso-2022-jp?B?UDFtRSszZ0lvRXh1YWlGZllNNndnNTlSQ3ZRV3pGZFZRM0hWWS9YUXRC?=
 =?iso-2022-jp?B?QkJkZVorMzFSUFNFNFpzSnpvdjZrckZ0SGxnZmtsajA4RWxVNk5jcXBH?=
 =?iso-2022-jp?B?cDBQNGtXVnpMcDN5d2NZeElmNXR6NFpHNUZXZWVzR1NRb0Q3Q01OUHhY?=
 =?iso-2022-jp?B?ekllRnBzQkdwNU9EV1FxeTN3V01YNWhBMStuSzhNdXczVEdhMFkxTUZL?=
 =?iso-2022-jp?B?K2cvL2xvWk1MWWtaQVp2eHgvSlVwNVRHaitxSjYyM2c5K0pNeGUwTE9O?=
 =?iso-2022-jp?B?MklHUksyaE4zWDBNQWtHN2NacTFIc3l6Um5tM1BWSlFXeXBDVHE5R20r?=
 =?iso-2022-jp?B?dmJLUkQwUXlsWExFUm83TCt0V3RmRmdFWVBiNWVtTnRRZENLOXd5OG1k?=
 =?iso-2022-jp?B?WTRmUnRXUDFtQ211NFNrWlpMUlJZWDN2a2cxR0V6VjJkTWdMK3RwUGR2?=
 =?iso-2022-jp?B?UzkvSEtNL2l6TnQrRi93NWR6VEE5SkFGNWdlcXNaaGFzNS9sTjNEblB2?=
 =?iso-2022-jp?B?M0d5RjZKZEZQME90ZFlVQkZ4OGJLajA2bzZaVUIzRDhUcjNlNWRFTmxy?=
 =?iso-2022-jp?B?eVRoMWZjQmRQOXo5LzNoRmJkd2ppVWVkTWJkamhicmhGWms3V3BHQk9X?=
 =?iso-2022-jp?B?VWhRWFNYZTl3Tm9ZN0NvVUN0a2xMNnZvNmFFWlBPaXMwSytpQ3pXcnJ1?=
 =?iso-2022-jp?B?RkxOSk13a1JxbnVueUo2K3ZUUEtpbjAvbXl3dGRMY2xVY21ETGF3bTFo?=
 =?iso-2022-jp?B?cnd5SjFqRU45TTMyMnRXRDFOMUswRnd0aTdkTU1pckFkWGt0TkNBZ0M5?=
 =?iso-2022-jp?B?dTUvY09hLzFoeTZpUFY1ZXUwQVUxNjFld2NvVDBlaWpGTkE2Q0h5UTlq?=
 =?iso-2022-jp?B?YW1UMVdYSEYzVURPTVVwZE43eW94Si94U2FralkvRktrUkRTc0Z0aisy?=
 =?iso-2022-jp?B?dHc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7772.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?L21RTHNjbXN3TXFTSzNTRG41cjhaQjd6TjY4T1hWZFFTRkxybW43VEZE?=
 =?iso-2022-jp?B?bzN6a2ZkZGtwY0RtNE1mZUJ4RzFDT0gxbUcyVGdzdCt4WnBxQ2F0QWF1?=
 =?iso-2022-jp?B?NDZ4MnNOSzljVDU3Q0xUT0x2WmdGckw5bE5nZjJ0by85QzBvQndxZ0Iv?=
 =?iso-2022-jp?B?eGlxYUcxb3BGVzBWeGZFNlc2WWgwRVZ5SWwvaC9yU2ZxNzMxR25MclVa?=
 =?iso-2022-jp?B?RmlqRDdoN0JXczdHSDVFOHNmQkRyMVZiRkNLRm1PaHB3eG5TSDI5TWgx?=
 =?iso-2022-jp?B?ckR3Ymx2SGxLVzd0RDNwZE9WaE1uakVLRmhxaldWeS96USs4UUhkaHk4?=
 =?iso-2022-jp?B?SWxDbUdrZzZqMjdZRUtMbU94UXFLOWtUMHAwNnVVaU9PWmFZQ0dsRUlR?=
 =?iso-2022-jp?B?RDJRNWozQkhrTFBUZ3h6OWc1b2t1eDlQdEMzenFnbjFoK0xxRFkvTDYv?=
 =?iso-2022-jp?B?K3dwVUMwczQ2R1dCRlFpeHdOd3dpdFVQMnp6YXdXeFBIb2dYQURITzI2?=
 =?iso-2022-jp?B?QVUvN2tIL1BaYTdONEIrWkQrUWdET1h3RzFFVFlNZXU5Q0R1Q3E5SmVL?=
 =?iso-2022-jp?B?TjFxdjVlRFNYWmluUnB4Sk1KUnd4WWJqRlp3VDRxck1SRVJVYVgyMjJG?=
 =?iso-2022-jp?B?aENDZVF6d0w5cE1Dbm9BOUtDNFUzeTRobEE2bE1BMmlsdzNjN0dUaFFR?=
 =?iso-2022-jp?B?VkYvOGpPdkNmOVdYTi9SL1MxSjBoWm5Tb0oxek1qQjdKaWNvTzVVWlln?=
 =?iso-2022-jp?B?WXlyRWV6YzRaNjdiUjVKd01GN1p1UVJieTRaV0hCSUx5RWlreGxyVXJj?=
 =?iso-2022-jp?B?d3UrZWRuaGxtNldFakplVE15cVhiZTlIUzdQakhKM2QrSktXYjZUUXJ3?=
 =?iso-2022-jp?B?L2MyUlRKejVqZFIweHF5SW1iaHRzelU1VWt1Z2JsSVgwK2tZbC83L21q?=
 =?iso-2022-jp?B?b2tqWlVmd1NyUy95Z29lVmhPSEw3UW9sMkR2cEFpUHo4bzF5QUJzNXE1?=
 =?iso-2022-jp?B?RGcrdUdPRUw4ZkhCeW4xS3o2NjRlSDBmclJSNEtvQTNCS0RrK3hWYmJo?=
 =?iso-2022-jp?B?WXFPbmJDZWJvR3RBVjhQZzdzMzlJR2NFSWpqYXh1eWZ2bnl5ZTRkbktj?=
 =?iso-2022-jp?B?SnFxeGxMYXloUGdLdHQ3RHhJNkVOdkZRV3B1ckUyVlRSYnUvOUhxTUtu?=
 =?iso-2022-jp?B?dWhXYUhNWkNFb3daYTJiUy9OK3d4c2FBRzhFTEZDV3hobnNDbDhVdGlw?=
 =?iso-2022-jp?B?bUduZEdJaTFrU3B3UXBSVk90OWs5M0N2M1Y3d1ptcTBndlZzci9xV1Bi?=
 =?iso-2022-jp?B?NkgrbGFUQlpnSDYxbTcxenJkczhqck9adlQxR0swd3FDcXJMU291S0Uy?=
 =?iso-2022-jp?B?NE5HQjJuVk5SU05FQ3dENm13VlFwZWcwK3FKOHdnSVNMckhjdUZXQ2dK?=
 =?iso-2022-jp?B?VXJtWmg3M3paNzVyUXRYWHJOSzQ3Qitna3Z1ajdPZkErT1FSbkNBUUpU?=
 =?iso-2022-jp?B?ZE9vQ0tHMDVFbmZ0cDFTNnp1ZGF4ZGZRN2dQRjlyN0pnMG83MjFWdmJw?=
 =?iso-2022-jp?B?dGxBaldXcGNxQWJFR244SWU1T3VoZ3AvQmNoSGtMa0xCMUdzVTFibW8z?=
 =?iso-2022-jp?B?Q1k1QnVNeHdPNTU5NW1PeklJSVFtV24rZlJhS3FiaEdzUG10NHFKRnI1?=
 =?iso-2022-jp?B?Q3V2Tk1UZ2NoQTVXUVE2THptMzVPZytZMVVpcTIwdk9WMTFEZGN1RUxi?=
 =?iso-2022-jp?B?QnJuWVRTRERqdm1sNWE4STV6cEt3dW9zTk1teVNvSGVrdWEwWUtpa0I3?=
 =?iso-2022-jp?B?NDNRYUlQUC9VRzZyTUhpTzhtM2ppa2JmOHpmZEFPeU04MmxwN1JCaG1H?=
 =?iso-2022-jp?B?Wnp1c2Y4QmtWR2thZk0rM0VOKytQQlp5UEVPTG41ak80Z2dIV3lBMXZY?=
 =?iso-2022-jp?B?R3A4MGJ2eWFUNDFwNUZKOVl2MGpZTHA0V1RtbjQyODJnVEtIMk1HNWhC?=
 =?iso-2022-jp?B?UmU1VEVkQkJPV3BQa1dLYVZGOTRUY0tReFczTHl1VDl5R0hlNnVscmhi?=
 =?iso-2022-jp?B?U1Ixdi8reW93TTRMM0s2YW9DNnlPVUxVNWFXYnFTY0g2WnE2VzhjTHhX?=
 =?iso-2022-jp?B?b1ZMVER3MW9KTlozeFZ3K2dEMWNrWTlIRWNrT3pId3NUeXA1M1NId1Yr?=
 =?iso-2022-jp?B?STM4YkpNM08vRTV3SFJMM0NkMFBVWUFQWTBwaTZxcnU3MGRSMzVrUk5u?=
 =?iso-2022-jp?B?RzU1czdrREk3cGRwT3JsbExkd2JEMGdZajFZL3pnN004cmFSQ2ZwS3RU?=
 =?iso-2022-jp?B?b2d2dnVQaElnTVY4azdwaVlFMDBVanBTY0E9PQ==?=
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
	sokIiZB/OYI4bv4Dmq+uPiqWTsn/TRWi84RrjMgpuoRfuymAfPlgiKqurvHDuwIe/QE5ao+9fRE1RlK0pz6SOoeXLSR+7QWwifKGAuvGQGz9EvpELlGx15HwcLOFgrcU21VFesIqQelp3zFQlc8E1lprhdP6LLCDrN/LuKbafBz/1q6zks/C2Iy6smH8pMLaSB2vhKZ+RSNSdJm+dwcZnm3lNowexfO2076SAvEAG3vu0eb65z3OFi+809WmSJoEQTtHq4hRlSAItn2BcuQAI3/HTpwgAepVCZg0NxWAXFAC0H3MG0Nlu8Am2LKrFcCkQYZsUrT+5eruNttQzP+SF2WNwrmCU2FJ0wrdZY2NUBaFq3+VO+z3DjkohKWumI01YnfqFA9OMw9B8QHHv4CjAaR4dqslQ3OPc7rUOdd7mzATUgzHWcpXwWhRHEd3jsWfDt3pZjxkSDfeVq4kncjCKX5iQTliUkZjhN1gnRi5rBjcjmWUSYyitWpSRDZ7KCL45QVxA9qjYUyjr0SNIum81KCyGhcfXLJ+8yDa/fxC2PD+sjQC5nJIMas5ACP4YVvAk/ULWJQle4UUMOcznOJbiRdxLcrSi2OkbJN+BZt6GnhnZFzLzHuzRawETrKeE5mY
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7772.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57326c51-d2bb-40fc-4848-08dd0221c256
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2024 07:23:37.3468
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5H61LH4jzRO/OSlDx2dFHNosRtoqPlGRSZRFxIj0/oNV639/XAoizF7sX3GIifSN9YaLLRxlGx9CNhvixRbsEXtunjcqRHzrKtwrge5RhvA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8695

The rsize/wsize values are not multiples of 1024 but multiples of PAGE_SIZE
or powers of 2 if < PAGE_SIZE as defined in fs/nfs/internal.h:nfs_io_size()=
.

Signed-off-by: Seiichi Ikarashi <s.ikarashi@fujitsu.com>
---
utils/mount/nfs.man | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/utils/mount/nfs.man b/utils/mount/nfs.man
index 233a717..01fa22c 100644
--- a/utils/mount/nfs.man
+++ b/utils/mount/nfs.man
@@ -215,15 +215,18 @@ or smaller than the
 setting. The largest read payload supported by the Linux NFS client
 is 1,048,576 bytes (one megabyte).
 .IP
-The
+The allowed
 .B rsize
-value is a positive integral multiple of 1024.
+value is a positive integral multiple of
+.BR PAGE_SIZE ,
+or a power of two if it is less than
+.BR PAGE_SIZE .
 Specified
 .B rsize
 values lower than 1024 are replaced with 4096; values larger than
 1048576 are replaced with 1048576. If a specified value is within the supp=
orted
-range but not a multiple of 1024, it is rounded down to the nearest
-multiple of 1024.
+range but not such an allowed value, it is rounded down to the nearest
+allowed value.
 .IP
 If an
 .B rsize
@@ -257,16 +260,19 @@ setting. The largest write payload supported by the L=
inux NFS client
 is 1,048,576 bytes (one megabyte).
 .IP
 Similar to
-.B rsize
-, the
+.BR rsize ,
+the allowed
 .B wsize
-value is a positive integral multiple of 1024.
+value is a positive integral multiple of
+.BR PAGE_SIZE ,
+or a power of two if it is less than
+.BR PAGE_SIZE .
 Specified
 .B wsize
 values lower than 1024 are replaced with 4096; values larger than
 1048576 are replaced with 1048576. If a specified value is within the supp=
orted
-range but not a multiple of 1024, it is rounded down to the nearest
-multiple of 1024.
+range but not such an allowed value, it is rounded down to the nearest
+allowed value.
 .IP
 If a
 .B wsize

