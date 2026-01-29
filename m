Return-Path: <linux-nfs+bounces-18595-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eJiOKZ8fe2lPBgIAu9opvQ
	(envelope-from <linux-nfs+bounces-18595-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Jan 2026 09:51:43 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A173ADC01
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Jan 2026 09:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4C75C302F7E7
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Jan 2026 08:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E530A37D11D;
	Thu, 29 Jan 2026 08:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="CuTTOUaF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010060.outbound.protection.outlook.com [52.101.229.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11A237D117
	for <linux-nfs@vger.kernel.org>; Thu, 29 Jan 2026 08:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769676663; cv=fail; b=qlQKi6pFQypik/ffhJypwjiVCW6orykNNFgeIyj1ryuzp9vmPh4Sm4hntTtlaNh2Mgdex/fkGRIG/wTxZYCM12VKOovXLrtyNMu/vXw8S88Ju45QgWW5dFKL8dEPdQglL3OU/1GUr7d1ausux/EKFCnbBwvnDQ6tE3OsEtpkHkw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769676663; c=relaxed/simple;
	bh=5zw0HJY/G9jSyOwVO87bkwTGWnwO+lYlLZ6Lu0X77WA=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ia58LRyOfJeaIUiNePDom4PnWWRmT7BhUebYpwZWp6Igc7DV4/IV7Tc2XD/jAWVVsIJV0cu0rlauJRPyCuxdoO4bykVK9nyWOL2eGJljIoUsz5nDyrusbfzkmPYKxrKgkPanMjZbPoESw2NNMnRX995RY63Ax/EwCd5l1V/YCbY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=CuTTOUaF; arc=fail smtp.client-ip=52.101.229.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h0Z6WMLXkxRY4D+S7u2xtU1iVLg+BkCOyEmtI889l8qVTNMD2HI3/rEGQU8xR5ruavSBla4NqXYys8s1oj370uQC1B57/Bd+r/+MHp+weiIx6XtP5/KLqkvRYisDQEMTH/W+rsjVeUkDhB/LVYgoC8oEeK0m2ghMOY/MrL4Optj/jC00UYkH07Np2whgwjWaU1ypiGKNV8bbhucCWpGSqilNWRBnOt+hCm+qnyZsV28LBvtAsDGB6Hin71Zbk07l0Iq6tODSbXMl958/+R8MoUERSq0rYrZAZIMsJqLFcko3kDBLHOHBdQ6GIayF+M/uyGGoGhTOM+/R7i44IaPt3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5zw0HJY/G9jSyOwVO87bkwTGWnwO+lYlLZ6Lu0X77WA=;
 b=iVuRl0MKYlXIiphxHKh9HbeTw4u+Ez6HYkhr7OAMyMFYM/Z56aABmuhYKDtLPqcFvKJVJlTFIWIJ+rajHddoTs/ARUOHrj60rhHtE1j56zUjcDfzKdrwHGseu18Xy1Si+iK/R6NJ8cblLBAT7ByMnpGlW2mh2GpVXwz9laLeARUE0coUfI9/fxhbb5JTmygWdVxeIfQyTirigujDY23iglZMJH0HfxFwWUG+V0ZUIDGc7E3IsPHKAyx466C+N4HGBuX5wr87wpqdLVz7rimzkkkmmy0+ry9ddfryNsdJia4Bky32fL7SDpUxW3DLsTQLFA5K+aksRruH8F9IYzauwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5zw0HJY/G9jSyOwVO87bkwTGWnwO+lYlLZ6Lu0X77WA=;
 b=CuTTOUaFBosQYxf5gEZ+/Y6is1257v0TIFfQ8bLEVeL5oAO1qyCnnrcFxF22yP7wbjy0m1DIRFm/15MRM0XUulMgijsQHBRx1IsN4mfNyFfferucGlNRljo+XSv6O/pw0UUBZWIAj/C5o31K2T0j8zIX+NsYpIEPs9/qt+HbU97nJu3rNmHEpJ6zkD4sIPslJuXmeFI30SaKjYRpJZjlId6ZMcNzeJ32aAtyLCCq6kMpNI4YcR/4RXvWClMFn8Q819Pcj5Pn/wLWByR2jEQOzAXZr8IRKhADhm+tPMVI2W5seyiPeZHxpJaidiuLPPEJiQeXHO/OvQMiV5+eCI5Byg==
Received: from OSZPR01MB7772.jpnprd01.prod.outlook.com (2603:1096:604:1b4::7)
 by TYYPR01MB15165.jpnprd01.prod.outlook.com (2603:1096:405:1a0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Thu, 29 Jan
 2026 08:50:50 +0000
Received: from OSZPR01MB7772.jpnprd01.prod.outlook.com
 ([fe80::5956:959c:6018:183a]) by OSZPR01MB7772.jpnprd01.prod.outlook.com
 ([fe80::5956:959c:6018:183a%6]) with mapi id 15.20.9564.006; Thu, 29 Jan 2026
 08:50:50 +0000
From: "Seiichi Ikarashi (Fujitsu)" <s.ikarashi@fujitsu.com>
To: "'linux-nfs@vger.kernel.org'" <linux-nfs@vger.kernel.org>
Subject: [nfs-utils PATCH 04/10] rpcctl: fix a typo in man page
Thread-Topic: [nfs-utils PATCH 04/10] rpcctl: fix a typo in man page
Thread-Index: AdyQ+nYVoHrXemvcQZuEKLmn3KuV6w==
Date: Thu, 29 Jan 2026 08:50:50 +0000
Message-ID:
 <OSZPR01MB7772F1D427EBD315AE2A855D889EA@OSZPR01MB7772.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=4a07eaa0-f3cf-4644-a6eb-afebb9fbf633;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2026-01-29T08:34:15Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB7772:EE_|TYYPR01MB15165:EE_
x-ms-office365-filtering-correlation-id: f2a30841-692e-4f29-795f-08de5f138111
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|1580799027|38070700021;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?NzhlekZVTi8yRE9IbFFvei94MmJXemU4MVpFRGVpTy9CVWtxZGJkeWlT?=
 =?iso-2022-jp?B?MnVUSWZ5TEhuaXlGbGwwaDRNLytOYjl6SHFwdlQydGJlUW1lejV2WU9p?=
 =?iso-2022-jp?B?M1lIMW93RkJPVjRaVmxTdUovV2FEM1BwbjdJUVg3K25wMk9PYXdwbkVl?=
 =?iso-2022-jp?B?OVZmZ1pyMWJENWlheGFtRi9pR1BsVDM3L2QzeDIwTDhNSmhuUW9mM2xp?=
 =?iso-2022-jp?B?aW1FTlFCK0RZSTZXdkxINlJkcWczZU95ZEtJcElLWEoxT3ZuamRydFpW?=
 =?iso-2022-jp?B?T0VJMUVGMytyc0FXdkFGd3IrVlRoWDIydTNUeXRualhHQWVPVUNPZGlw?=
 =?iso-2022-jp?B?Vys0TEUvL2doTlNJdkJjV05XWEs0VFA0YmJxOHU1ZjlnUWphSXJzUDgr?=
 =?iso-2022-jp?B?YWthUzZNWE5JRThPTEpxRmNUVEVmTlhiRVpOT3I3MlBQSExyNDRMcTFz?=
 =?iso-2022-jp?B?blhnSkRVQWpFaE4wZ0pxaTdEM0pRRDVIdFdMV1dZU0JKVVRtZnBVY285?=
 =?iso-2022-jp?B?LytmOVRBSERNZHNid2IrdkJsaFBFYnUxSlZiNEw1ai9mdDQrWWlNWFBZ?=
 =?iso-2022-jp?B?dElBckZjSzYzUXRyNDRJN05mL1h4aW84RC9iMzJoSzUzalpTcFM3TGFF?=
 =?iso-2022-jp?B?Zk9IRXo1dGZFc3lZOWQwVUQzTXZOTEtsTUtQTTNic1ZJM25EeUVSNnFX?=
 =?iso-2022-jp?B?M0RFMi9UVVhmQkwva2p0SURPS3lFSmtpdHNaSkprc3lRbzFUeUo5ZlF0?=
 =?iso-2022-jp?B?bWZqMnFMOEdETnlvV21Pelk0WTMrcmpJSmFwZWttQU1rWkVlVU83YjFm?=
 =?iso-2022-jp?B?cVVzbnprRW1LaVl6bUg4TUNubE9lN3VHTU1pNWUzMCtFaGw5QmRDbzhr?=
 =?iso-2022-jp?B?cG1QdDBaeDlhNGR0QlIxdjFEY252L0R6VUxjQVlaNlJPNXUzRzJ5RzFq?=
 =?iso-2022-jp?B?TGpRdUNHTk5hbmJwcmZYbnJjbmpKekxZZmFteVRHcnVpK3dacjBHM01p?=
 =?iso-2022-jp?B?dFhWdlV5K3d0S0pYclZwR1dUZVBwZ295aDh0UjJraE9HRFc0eGhXaVFX?=
 =?iso-2022-jp?B?RmR1Njd5VWdaZGxYYVROQi9ZMTZNaVFOdUJIdnc1K1R5aVpROTdTZTYz?=
 =?iso-2022-jp?B?aVZiQUVDeG83ZE5jV2NPYjRtVlJwbE5zRm5QRmxmblZOV3BpYmFnM1Y0?=
 =?iso-2022-jp?B?ZVU3NC93TmxaMHgzUG10ZTBZeW5TQnNCQlc0S25ab2lGRy9pMnFBTnhy?=
 =?iso-2022-jp?B?Ymk3eWpwWnJBNVBrYzdkV1ZyNTFSd0NvbjAvaGR6dkpvRHEzSnNlOStJ?=
 =?iso-2022-jp?B?WEZlNElNa0M4b0NXbDYzanhyT2s5Yk0wM0I1NW93bzAvVFFjbHJ6eDR1?=
 =?iso-2022-jp?B?THZiWE13T2wwMlVkdW1IZ0ZYOTdoQ2hGeEpHc3JxR3FNMXdlZXY2SGZC?=
 =?iso-2022-jp?B?ak1FVTUwL3RjVVNTeXNXcG5LNkk5clRLNWh5aUhtS1MvUHQ2czdBQk1y?=
 =?iso-2022-jp?B?UWF3YlZCTmRnYnVGeVlIcXk0aVF3S3RGd0lPaStVMHlkdWF2WDVLRUtS?=
 =?iso-2022-jp?B?bllpbnRaNzRGVmFwNk5UUkFHWk1QaDdaWUg4dS90QnFucGxueERLUFRx?=
 =?iso-2022-jp?B?UW56bTM2R1lyRFFsUnh6L01tZHcrWkNaaC9waW1kMU9JcGRHaVRXZUxG?=
 =?iso-2022-jp?B?RklrWWQ5K1NpV09pWGdRVXNzVUtHRmNFOE40dHRITzF1NEhkR1NXSWU3?=
 =?iso-2022-jp?B?eitvc0E3ZHI5ZStsejJtTkZpNGk4TW8ySXVZTFhqTmtQRkw3VW5lSTdK?=
 =?iso-2022-jp?B?UTg4UWd1SjJrREV0N0E5YzRRWnorME5YdEdjNkxmTmY3dmttZGNVODJj?=
 =?iso-2022-jp?B?VHpBeGxQZFYvY24rQkkrOWlLdWMwN084cDJwZ1A4NzJqaW1ibHQrUEg5?=
 =?iso-2022-jp?B?ZGdXR1VHUXJkM3pVSktqd0g4UUdtUkFVNlBjY0RzYmYzMnZFekRHZlp5?=
 =?iso-2022-jp?B?U3VrV25SNWYrdnllUWNvZVJMd1dwSXVnaFZ3TENqRG9kYjNZL05DeFdi?=
 =?iso-2022-jp?B?bGFMRGxRRi90QTErZWVoQ0lQbGpYVGxHdnhOelQ5UnFFMXdUdmJzZXBN?=
 =?iso-2022-jp?B?VXpwRXBWUUZKUUw3S0JMTDd6UkVxS1ZjQmsvaWNSbTZLZ290Z0dsazRB?=
 =?iso-2022-jp?B?YUVuc1dCYjlaVUttOUQ5SHZZaDBROFN0YWhWNFZqb1puZkJYMmk5aVNK?=
 =?iso-2022-jp?B?Sko1MVpVS1E3VCsyNmJ6SWpZUWVWeTJ0dDNDZGdDaldPdVBLZEZOOHAr?=
 =?iso-2022-jp?B?V0ZoTEVJOCtRbUNUNG82aTVhZHFSQjUzYzBsSTMyZG5QNmljYnNpR2xF?=
 =?iso-2022-jp?B?UjVZcXVOUDlINjFaUkZqaG55VktyV3FSL1Q=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7772.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(1580799027)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?R3RXOFI5cnM2bHViVU44TUVzWUEyV3BseGFCWGNuYTJTeWNPOWJoc1VS?=
 =?iso-2022-jp?B?bldLaGg1aGVHcVZCOHlKY1F2WmxvTzNyeERrU3BoUFhsS3IrdHUwWUdE?=
 =?iso-2022-jp?B?cWZMbkNpV1gxRVprSlJlNFdwT2pXQVlHRHloYTM5TTF0WkpmSlVYOVBX?=
 =?iso-2022-jp?B?SiswM1JxMFBGemx0TW1HYnpmTUtoSDB0dDdJVVNWNnRaT01OK0E4Qkxn?=
 =?iso-2022-jp?B?czM1eXkxcWo5T1RoN3YxWUV4N3VLUTdTeEMvdkdvaURrQ2dnc1dLNEFn?=
 =?iso-2022-jp?B?SjJMWWJya3E4MVZHZ0hTeU4rMkdPWUtURS8zNGZmeVA1RldFT1JPSUcr?=
 =?iso-2022-jp?B?ZUV3QkdwZno0N2NsbzUwRDhmNDR1MWl2TkxXR25IbFpTdEpJeUFDVjEy?=
 =?iso-2022-jp?B?M2FvVmQwaXQyMFBNSHdDMFRTb3NibVl5d1BFbGlubkMraG8zMmp4NnRk?=
 =?iso-2022-jp?B?QVArYmdoR3RuWVprRnIwVGtuaTB6cEp6QWZVSDFuV1VwbEllL2dDYWd3?=
 =?iso-2022-jp?B?S09jM2ZoNGF6U0RkNUQzcVBUcjhSeWhqYWo0TGU2c21nQmdoWkF6Q1lL?=
 =?iso-2022-jp?B?c1BCV3F0QkNmdXArZjcvcDNXV3NlMmJSWXZnSjUzdldhRFBodFlnUHZ4?=
 =?iso-2022-jp?B?ZWFQdzE1K1gwdDdJMGZaSkdlRUtISVVwZE1Jam13azZneWFQc2RNdloz?=
 =?iso-2022-jp?B?SUV6Ty82MDk1YXl4Z2xnZENlMHpBR2pDZ1VBdU5EZnI0dzBhVGJiS1U4?=
 =?iso-2022-jp?B?OE1GbWpwQ2lUeFdKTC9XRUVBdmNCQ3JCb0g2c0paQWh2R0x2NWhWZ3By?=
 =?iso-2022-jp?B?V05NRXV6QTB4ZHZ0Ti82OWNWblJYYnNoUGdQTk5BU0svOXRsV0JTN0g1?=
 =?iso-2022-jp?B?SE9XVnBiMnZxY1FuZVR3anRwYldQWFBUQlZTTEFhZXN4VGYrTkp3Rjlh?=
 =?iso-2022-jp?B?dkk4VGJ5dDZFK0lsS3lTclRkcGNmWjd1eVpSbUtremxGYXlQMHM2TWNI?=
 =?iso-2022-jp?B?L2hBK21WWDA1T2FGbVFOeUwvcW9NWHhEMWNhQlpBTjAwRTQ4MDdGNzVi?=
 =?iso-2022-jp?B?MGs5blJtbVpKSXF3U2E2L2tIU3pUM2NqNE16R2Q4SEZqL2hraTQ5M2Zx?=
 =?iso-2022-jp?B?RWx0TENhTTRUNGlXeVdFOC91eTB5VjdCMk1uS1FoWUYwL2tOdDNlWTg1?=
 =?iso-2022-jp?B?L3lWZDBScUNDU2ZIOGROUm1mc21PM3dXVURUZ05TVkZtZFhBOGhWT2FO?=
 =?iso-2022-jp?B?Wng2b3owMlNDRHBKbFAvQzFQZ3doVUZZcGQ4ekpXU3ZWUlZ2NlpXVEFq?=
 =?iso-2022-jp?B?VFVNZnArMVlCUUViamUyWFJHWUlJdDlXUWFkVTd3cVVaaEhOb3RrdHF3?=
 =?iso-2022-jp?B?clRzRVRGOWx5c09wV2h4NXYzd0FCNzFxSjRUbGFPS01HcnE0ZjlCY2pn?=
 =?iso-2022-jp?B?eU5takxwN3Qva2Z4MGQweC9BSXI0VmlNLzBHamVFRzN3UHBxN3lSR0Jl?=
 =?iso-2022-jp?B?eCsvM1lyVEdLMC9TVy80RXpMZWxzTjFObE1sb3RteHJhRzJ5SWQvSExx?=
 =?iso-2022-jp?B?UWFhNDR5d1VwYVpmS0NZTE5YeDBHRFgrZjcxMnI2dFBVaE1TS09XK2FC?=
 =?iso-2022-jp?B?REdORnBuV21IQjRqeDNpNlNsUFRGZnFUQ0FBRlEzdW5nKzdrck1FaW1x?=
 =?iso-2022-jp?B?Rjl0K3ZqTlZPOFI4SERNN09GUVFLWmYyRGpOWGdwYmM1VFRuYXNzTk5u?=
 =?iso-2022-jp?B?YTJlQXhtYURMZWVIQkdLZmNzbWltSmNPeXVWbVE4WTFtRFZwU1VrdDh6?=
 =?iso-2022-jp?B?dUd6dytXUFJVL05zbW9HZnQzNGFXK1F5dDVKdHgwWUtSQkJYeXg5UGtv?=
 =?iso-2022-jp?B?enNNYm9EdDdPSzZCMGNQYW41aCtTQk1wcnA2a284ck1WcGE4NnNGd1o5?=
 =?iso-2022-jp?B?Sk43SWFHNmVOYjR6S2h5dzVNMWxiMTJZcVJsR09YeUJLSGZ2MmpWeTY4?=
 =?iso-2022-jp?B?ZVhVZjhNRkxub3ordEpoL2p0QUZPNFJuSDVWN0xNbXlibFQvRGM4WmlJ?=
 =?iso-2022-jp?B?ZjNoRWQ5OXNIOE9LRVFpaUdDWnpuRmUvZ3N0djV3N3h5b0NPNllpQlRD?=
 =?iso-2022-jp?B?M1BTSFV3WXllRFVqYnRPQytQeUlHWTRHNyttVFdqclFDeFFvcHcvTWxL?=
 =?iso-2022-jp?B?ZzVEdFdTK0NBYlE3NDY0bTYzWHk4MUJGcDEvV0U4bDFzQzZnV256aVdm?=
 =?iso-2022-jp?B?QnFjejVrRmloRllxVWZrZXJ2b1BHbEcxeEJjMURqWkxPRHpZMU9EQW5z?=
 =?iso-2022-jp?B?TWU4UDFMTzcrcnpva1huT1dZeDNmZXI1eFJDdDRMU215Si9jSjFoSTZD?=
 =?iso-2022-jp?B?SFlZM3FjdnhranMwcDlBaXp2MXA5VDFxbXFFWEpBRlhtd2NmQnJOY2ZG?=
 =?iso-2022-jp?B?MXY2QTBrN09FNjdQTGxiS2s3YmhQM25tU0xxRjNmUEt3ZC9rbnkrQzZI?=
 =?iso-2022-jp?B?bVltS1p5UWpxMGtia3YycXZJYXBWd3ZIMWhVQT09?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7772.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2a30841-692e-4f29-795f-08de5f138111
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2026 08:50:50.7261
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mNye64AobUAkTGXr+0yozTGQL8fp9pjzKLpr6IUUNlK1BVUxEkzm6UZRCXlmY7X+iTCJ8MPmPnPOIoKrbHmS7vIcMKq9JxwHTkMNynNeFeg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB15165
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[fujitsu.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[fujitsu.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18595-lists,linux-nfs=lfdr.de];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[fujitsu.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MAILSPIKE_FAIL(0.00)[172.105.105.114:query timed out];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[s.ikarashi@fujitsu.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fujitsu.com:email,fujitsu.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3A173ADC01
X-Rspamd-Action: no action

Signed-off-by: Seiichi Ikarashi <s.ikarashi@fujitsu.com>
---
 tools/rpcctl/rpcctl.man | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/rpcctl/rpcctl.man b/tools/rpcctl/rpcctl.man
index 2ee168c8..205cde77 100644
--- a/tools/rpcctl/rpcctl.man
+++ b/tools/rpcctl/rpcctl.man
@@ -31,7 +31,7 @@ If \fICLIENT \fRwas provided, then only show information =
about a single RPC clie
 .P
 .SS rpcctl switch \fR- \fBCommands operating on groups of transports
 .IP "\fBadd-xprt \fISWITCH"
-Add an aditional transport to the \fISWITCH\fR.
+Add an additional transport to the \fISWITCH\fR.
 Note that the new transport will take its values from the "main" transport=
.
 .IP "\fBset \fISWITCH \fBdstaddr \fINEWADDR"
 Change the destination address of all transports in the \fISWITCH \fRto \f=
INEWADDR\fR.
--=20
2.47.3


