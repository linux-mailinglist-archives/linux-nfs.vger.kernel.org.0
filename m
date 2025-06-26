Return-Path: <linux-nfs+bounces-12792-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AACE8AE946E
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Jun 2025 04:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CE6A18947FE
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Jun 2025 02:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A540191499;
	Thu, 26 Jun 2025 02:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="Ju++kOxB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from esa3.fujitsucc.c3s2.iphmx.com (esa3.fujitsucc.c3s2.iphmx.com [68.232.151.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1045B12CDBE
	for <linux-nfs@vger.kernel.org>; Thu, 26 Jun 2025 02:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.151.212
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750906426; cv=fail; b=n0L+gnU3iVG6F+6EMaeD+XHA/Hq6d1arCuNzS55OSAXR3WwS0Spj1MSXz5lGgMNw3b8FDyjeZyy2ir82KlqsafOo58pGZeICHNlRoaVvCkF4PYmuwLX+OZKqMWmYXsGZQAUkL1djf04d8nUoswBAb8vP4WPXMYJ0z7n69rNiZAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750906426; c=relaxed/simple;
	bh=52+QGPju+8bh0GBmcTwWMJpgx+snNsAGAMUnZXjNVjo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TnLQAuOx6R+tAP4pxIHQ0I9nRCFbXRm4STd5BLAfgeLo2ditr2SKNVmhuipxGYUwmqUCcxK/nDYI9kGumB5z0M0DKoh893rD5n4F3/ZqsBE7DWLVn1Oc6PAw6VPurGq+IF5o+0/HIlMb7oCcpASStEMvGmww92nWsvdWOmIQFII=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=Ju++kOxB; arc=fail smtp.client-ip=68.232.151.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1750906423; x=1782442423;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=52+QGPju+8bh0GBmcTwWMJpgx+snNsAGAMUnZXjNVjo=;
  b=Ju++kOxBH4cm2FcM4GY/3i7AxLBCkLRyw/uWR/MszIpd4eDU3XIzxmpW
   uS8w3q/xpl7TaLpaYqhEJZrGMaGIRnehhvT10v+OkTGPWSszc5noy6y2Q
   BQcgztgIxfmUyUJEu6OE65M2P1f1uqb+MCFAsCRI01jz6Ir06U+VmnmkF
   qbbfGz6nn0MgQUcwi3I59Maf6QA9A7H9is6x6ehZ+N8/lUrq3Mui/WoKi
   NY5jz9IFN0MpBrg5JP8lDLMEXo6LvJyg6h2GyySy2SQD2ASb6fGAF0yYh
   REX6IsrkhwbFxrFS+fSx3vHStBQSGWSpFTsjEJKIuqf+OacylgEdTcbr+
   Q==;
X-CSE-ConnectionGUID: sQc0Q7qjSpS8RyoVgaDZNw==
X-CSE-MsgGUID: SieLwvN4QaaRZu5qocl2Aw==
X-IronPort-AV: E=McAfee;i="6800,10657,11475"; a="71091918"
X-IronPort-AV: E=Sophos;i="6.16,266,1744038000"; 
   d="scan'208";a="71091918"
Received: from mail-japaneastazon11011028.outbound.protection.outlook.com (HELO TYVP286CU001.outbound.protection.outlook.com) ([52.101.125.28])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2025 11:52:31 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A0j+blpD6zk8M41mA3yZIPGmKO/9O8Krgr5MKn5jSO3ZP3qodE3zv1Yq3VdVeiBQgWbbLKrNfAffSXkJTGWk27c8ivUbVEEMQdz7rDbDVZH/Q33VXx2gjeTd672Mz4Fxk+VwluMbSZBO2yzFDBdtK2LyycbjOHqZnw4GvQAabSAFq7V00fc/s1qBXL9yhGkYnYOVtdp7Ymo2ShC5SzMckAyMx4mot1ELyZ7NuJsgufKUFbQJljTTuj7yvnjkOWk7G5wjs5JDKuOPyuF8amwqM4d4ruz0ilOLRomEFSYdEC+vcJJ0QmTZPtv0blQXXWVFvVKy+8DGIGfq8tUNgKSNMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=52+QGPju+8bh0GBmcTwWMJpgx+snNsAGAMUnZXjNVjo=;
 b=cgvASygA21XaD9+wTvUoNQWV7P6B7OHZni+fM0XkSQUcaWahj7U8YPrz9RIeH0NXVdkQmjv3VPB5MaGAplLNpAUOhDqejd350ONDoPw5/WhyngHDXY6x8uu2XuQGaHAfJq0Jz1pclJ7z/fQOa0VBHk5E3EpCFIfSnk6xLyDfaZj5sQS0J6XIipEJor2e2lGA7QaHWmuRTLon5xkySNj1uFTagHs+oQbkm3TyHn2QzY3rl9R3PufOvooExSE9rNvf7NnH4aDuhmOZNKoWp/7SFVWDmoJAxBXMWRLdj0WMCldo7/PaJvnZMM6vRv1+B7GxPhpKbYJ424EzbHybNmfyPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB12085.jpnprd01.prod.outlook.com (2603:1096:400:447::5)
 by TYCPR01MB11432.jpnprd01.prod.outlook.com (2603:1096:400:37c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Thu, 26 Jun
 2025 02:52:29 +0000
Received: from TYWPR01MB12085.jpnprd01.prod.outlook.com
 ([fe80::199e:e725:b3e6:1569]) by TYWPR01MB12085.jpnprd01.prod.outlook.com
 ([fe80::199e:e725:b3e6:1569%5]) with mapi id 15.20.8880.015; Thu, 26 Jun 2025
 02:52:28 +0000
From: "Hanxiao Chen (Fujitsu)" <chenhx.fnst@fujitsu.com>
To: "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>, Jeff Layton
	<jlayton@kernel.org>
CC: Calum Mackay <calum.mackay@oracle.com>, linux-nfs
	<linux-nfs@vger.kernel.org>
Subject:
 =?gb2312?B?u9i4tDogW1BBVENIXSBweW5mczogRml4IFJ1bnRpbWVFcnJvciBieSBpbmNy?=
 =?gb2312?Q?easing_default_ca=5Fmaxrequests_from_8_to_16?=
Thread-Topic: [PATCH] pynfs: Fix RuntimeError by increasing default
 ca_maxrequests from 8 to 16
Thread-Index: AQHb5dlOv0JTq51bzk6Yx3PZsuiMJ7QUMaWAgACJXrA=
Date: Thu, 26 Jun 2025 02:52:28 +0000
Message-ID:
 <TYWPR01MB120850B44DCA639E367BA2AA4E67AA@TYWPR01MB12085.jpnprd01.prod.outlook.com>
References: <20250625080208.1424-1-chenhx.fnst@fujitsu.com>
 <782448d09ed170e097e112434848c771e08b017b.camel@kernel.org>
 <1605056536.14463638.1750875991126.JavaMail.zimbra@desy.de>
In-Reply-To: <1605056536.14463638.1750875991126.JavaMail.zimbra@desy.de>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=edff550a-5e77-415c-bfd8-c8069c0043a1;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2025-06-26T02:41:57Z;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Tag=10,
 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB12085:EE_|TYCPR01MB11432:EE_
x-ms-office365-filtering-correlation-id: ec0ffe58-d53b-4a48-a81f-08ddb45c7d52
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?VUVrdURBNEowWXZwM2hFblI2c1N3aDhheWxRUFdzYlVXeVV0MDBEckdCd3BH?=
 =?gb2312?B?ZkZrYXJMSklUcFgxeWNNdWcvcEVtbXBnMmxVWGhkeFZ2aXcyU0JiR2JMbzJF?=
 =?gb2312?B?R21ieVpvcGxLWkpPcjRYck5kKzF4cCsyeSs4Q2NFcXJqS1Npb0FwOHBwYWNL?=
 =?gb2312?B?UG5oaVByV0pteUdRdzBMcllwb2JLVTJUQ2RsNWxlUXMxdm9QYkJtbWNSNEx4?=
 =?gb2312?B?TlgyMzVYekhOZGdFYnBVa1ZId2xuRjExVHpzb2FpbzM1UW1WMi9mRGc3dzgx?=
 =?gb2312?B?SlRMd2dhTGpaWWl2ZzhRTHZqbXk3K1g5eHpQeWpJUGlLcWp6ODArL2RhdTcx?=
 =?gb2312?B?OFBUNW10ckdvT3RTWEdVbWgyaHEvZ2FHRXdNL2RxR1NodmxReXBKK0FMeXV0?=
 =?gb2312?B?NG9sdnVDMFp6ei91WWNsQXY5eVpnM0V3OExjS202QmhmK2JlMjJGckNxNE5z?=
 =?gb2312?B?YXdLa0RYN1UxODF6ZjlqUXVoQk5GTUU3NWR2ZEtlb1FDSXNmQVdSQ3FBS2RO?=
 =?gb2312?B?V3l6anBlUDRJVGtPRkR6K3lTN1o5QjY4dm5EYlAwWDM3a1Rad3JhdDVJTVJQ?=
 =?gb2312?B?ZUdmbDd0b280YzVlYzlsUkVzZFdQMTVQcDhnbGdYUXVvN091Rk1GTmFPbE5z?=
 =?gb2312?B?NTZkeXkxNGV6WVJpL3VFTVZidnl2N3FMdDVucmVObUR6YVJwMERteXQyVGd0?=
 =?gb2312?B?VlBjUTdUNzF4d2pIZlFRMlpHUzFXUnVRZi84NG9ORGdUREE1cllVZzRBaXhY?=
 =?gb2312?B?Wlh3R3hIYkNBYngxZGZSRFFOKzVubU95YmRrVE9IQUJRTXVHY3BKQlVicnN3?=
 =?gb2312?B?elllczhJYTJTVHJGSWpkL3JwODVNV1BNRFczNlVQVCtRVlVVZEYzS0FRM2Uv?=
 =?gb2312?B?b1BEekRKZXpJNUJpcjRzVk5sanhjbGlLdnNvYSsvTDl5L01IY1A3UHJOc1VI?=
 =?gb2312?B?WFhKaE9PbmZCdDM0akN5VjRsdHlxcXBzOFpiU255Y0p2cGM5ekU2Wm4wZ2ZT?=
 =?gb2312?B?bDE3amxnUGZQUVQrQ2hHd3JvNE84VWpmQTk5MkRHVGwxVGsyL3YyNjRNUU9D?=
 =?gb2312?B?RGxaTjNtOFdTOENheVhORDhqZjlBT2ZWRDRVSmxuUTJlWFo1SE1IbHdDOW1F?=
 =?gb2312?B?ekEvWW9OQWtkaU1tMThpdWZJTkZvOHJTTlZMNHdoSnFXT0FhTzZHSDRJbzZh?=
 =?gb2312?B?Q3kzTDJ0ZVRieExCZXIwOHN4WFcrM21SdzF1dTVmd0ZHSHJWbnhEb3Arbjdr?=
 =?gb2312?B?MHpyWENzK0RaT0FaVStDYkU3bTlnVEhlRlpvb2Vyci9zbjU3NUhhM1g1cm5a?=
 =?gb2312?B?aUV3UEhVdnB0UFFteTJqcE5ScHQ2SHFDbnJod2JWQ2NScjhZdlplMUFJaklN?=
 =?gb2312?B?S290azhTT3BEMzhsWUU3WHloNnRHRUZUdndwUDFGdU9BblJyN1YvQ2pKRmtG?=
 =?gb2312?B?UlUwZDllTnJFUDNDcnhqV1cxQkZNVGtxS25xdmI2L0J6SHJSZnZyeFlXUnRx?=
 =?gb2312?B?RkZQZk5SVmZPRUZvb1o2V2FQcHJXNWczQTdXTEgwV2laeG9NeHMwQmVkUDQy?=
 =?gb2312?B?My9sZkh6SitJV29oSjNKZ1BFVU5CbC8xak9YN1ZjM3VhUzlzMFpGZGx1MXE2?=
 =?gb2312?B?THlWbWNPMjRERlpPN2FoaXpMTWJtc0ptMmR1ZkkydlhpYUlKelJCV1EvU3NR?=
 =?gb2312?B?eCtCaWFZT3F5NU9QYVdTT3Q2K0duaDdIcnp2dHNQM3ZrNHI0L0h1Sms3clN4?=
 =?gb2312?B?K1lpT0hZU1J1QWpHK0F5bm1lSFFjZTIwb0diUVdoOGVsU0FNbm52UFNrMlJB?=
 =?gb2312?B?UERxc3hPOE9USTFPb2F5U1VObkpBMnZuZ1ZxV3d2QWNOZlV1ZUkrVWdCK29H?=
 =?gb2312?B?T01lcEVlOWpsdDFKNThmT3pPMVg3RUs2QVZrVjNvQnNCSHJrb3pKTnUydzNJ?=
 =?gb2312?B?dXpLbE5ibCtJMjZsaU03SkszTC81ZlFRUjRDS2NEWDlZUWVkby9aMXpESG9M?=
 =?gb2312?B?ZkhSRG5CNEd5OExCQUoxYWh5NS9NS2tYM0JsV3JHWnN0YWlCS3RXTEhMdWJF?=
 =?gb2312?Q?jHl5Jb?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB12085.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?ZUlIbUlRam9kZ2lvRlg1TnRWcTlMNzdGQjFlaTE1ZUFIMlNnbUhZRDVvMUlO?=
 =?gb2312?B?WmxaZVpkZDlleDVQVVhUUUpoL2dvMEFmYWZzRXhNUmJTcnM3WmFINXdxSFY4?=
 =?gb2312?B?VVFQZlh1TWRHN1pTb1p6RW04K1JpaVRadlZKbUpEMlE1K1lnTXV5eHNJeDBE?=
 =?gb2312?B?SlhqaEVBRlR6dHhhc2E0QTk4WW5GSUZNV3RuTW9STW53OVhQcjY3d3dBdXNK?=
 =?gb2312?B?cnR3Z1hqcHF3WkNVZE5jRWlydGNaU3VUdTFXYytKeldPVmFDNXk4YWcrMEV0?=
 =?gb2312?B?YzU5ZUJDYjlhblh1UnhxYnV3V3dnb2UzNWw4VmlJU0dtUDlONFNEL1FicERM?=
 =?gb2312?B?MjJJUjg1OE96MXE5cWNiTXc5T1daNHZzbVU4VStLUHpLNEZzcDk1VUNZbEZG?=
 =?gb2312?B?TytQSHROOFg5dzRZMjlCTVZSQ0JNbjNzYkpRcmZvajIyeG5pam83dDBhLzZi?=
 =?gb2312?B?Qm4wemxqeFVjYVdaSXhGM2txQlFOeEJKSDZXQlY4MzF0YWx3U0FITkxMTnZE?=
 =?gb2312?B?L2ZhNUV0SmtjVHFlT3pWdFRUYktlTDFPUGhjSDVlc1JnU1VqdnVBZGF6Q3Nq?=
 =?gb2312?B?Y1NpTlc1eUdiWXBSN3ZDZXJ2aVBaTUhIOHFZUyt0K0J1aVdDMngxMXA5N1Mw?=
 =?gb2312?B?Y2l3OVNJSHhUTHRQa1lmV3pHWWsyK25YcEc3b0FRTExUOGtZdldZQkkrUm9Z?=
 =?gb2312?B?OUw4UVAvQjNPQmRJRjZaOERmOUZ1aU9HSzJ4S1lBM1ZZdE9xMmpHTFNCdW1Z?=
 =?gb2312?B?KzlUbVIxZDEybVhVY2NtUHp0VjdjN1FYTm5sTGNNVFN5WnJpb0pOODFTczlH?=
 =?gb2312?B?L3NyQVI0ejVMSXVVbG1OblhITFdWQmdqVmRvWHhXS2FnUHo1Ykh4MTRtSWtU?=
 =?gb2312?B?NVZuOFdPbHJ0Z2F5eUVSbzBMRDg1TEJIOUJYZ2NDanNxNVBENDYrWjljSk1v?=
 =?gb2312?B?amZzNGVPWXpyd2lwd3N0NTgycDQ5aVYrc1UzUkhIbjFGOHhWUXB2QmV2VG04?=
 =?gb2312?B?aXJFWUxhVXlsc0k3QjFRV0VlSUthajJYQ3FQc3dYTlVIcUV6N01FdHlLMUMy?=
 =?gb2312?B?RFh6dTNLcUZxSlN1VzNydzZtVi9pMTBpeWNRb0dRSkIwVGVmRm1YV2lPY2Qx?=
 =?gb2312?B?Q0N0dUhPRWdsbjhwZHpNMUh1ZWdRN29JODgvcitweVprRlRXS0prWkJNdlRa?=
 =?gb2312?B?TnBTbXlTL0xIVDFPSEc3aDhzaUlrYnNtR3EwMWhMeXZyYjRsUXkwMU1VakY3?=
 =?gb2312?B?QzM2WGd6K2Y3SGpTT0x0eVFYYWkzSU1uK3lmcWtFekdsdjRhK21EUExhaWMw?=
 =?gb2312?B?TzltOHZoZVowRDBEM0cxWGJBcWhHcUcweXBVbjdBS1JwTzlpLzRGcGpCMUFu?=
 =?gb2312?B?QUZjanc3cTk1MndvUnRVdmRGazcyaG12NGdyUmNRang3ZE5TWG1veEdEOTB0?=
 =?gb2312?B?N1Bhd0Iwczl4RnFaTENiVmJGaklhY010K1E1OFdXUGZETnN5NFc1SU9ld2dv?=
 =?gb2312?B?SHd5VFhONDlHL082ZFhNajEyK3VVbTZKMldvakNRMll5dFUwb09KK2s5QmxV?=
 =?gb2312?B?aG1CdHNHWCtyWlRKL3RTcU1MMFh5TlhwVmllVzhsZS85T3ZQVlBtTC92cktu?=
 =?gb2312?B?akp0SUJDaTA0QkMwSnJDNUxtOEdSTjJLcUhmVjJBM3paMThQaE45R2hRNmlS?=
 =?gb2312?B?dFc2M3dOaWN4SjM1MnF5VUpJTm9hSlk3SWlxQXlmMjllR1VYUGJEK2xlaUlx?=
 =?gb2312?B?ZS91VVpsRGZCVlVSZmJ1bERjSHdwLzhzeFJoRUUrR1RhNzVwNyt6NXRzUkFP?=
 =?gb2312?B?ZkVLT3J4ckxDVk1MWE1NRVpZVlBxdDg1T25pVUdsSmJZbktPQzJsUlJDR2Rv?=
 =?gb2312?B?d2RlYTBMY0JyUklCMW0wNmpORk9tbFp1cTF5eTdDREQycHRXaHl3YmpyY3lt?=
 =?gb2312?B?Z0VyWFM1Z3FtU2U4VmtXaHNVZDQxdzBIRWpZc05YcFFvWDFnMWZpSHZOVHQ0?=
 =?gb2312?B?ZE5HU09oZmRHZ2FMREhCZFp4NkF2aHNCUDVGMkJJQVZTSUtUd2p0a2lKUnpF?=
 =?gb2312?B?MldLMTVUMEQ5UWtiSHFYU21HZnRDUUZ2TTZ5cDRQZ0hDa1V4a2sweFRIenJq?=
 =?gb2312?Q?DJagQPe0O0HyjCf8jFnkCj9B1?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nPoci3FauWQpDUGAZLjfYt0NRhOQZXNIrAyeUm2qP0Ruwdzk7YSzSSpWJyyxbG4OSgMmuarSjp9ronh43uHGIEhH00IAmT4B7s81pr9F+toH+eq5HKI5KzlEJnaqDi8D1w+qqY3WZhP5SP+xgsV0UliRWzHsEa9JxFK9oKG+fi61geZkjgVjnP2STosEVGIGOWJ3WEX2tHaNwNKzttn1UuTV6nIH9X64av9xDYsjL2oYjQTthdZ4Q59iZ5DwvODCzvtnB43Q0VCGx64GWQ8SYO0HmyMUgw6Qi1GMjVl89YSJsCTYqtRM8qUXykzfA4HMKCeenvkAJ+pRifErOkR/EN1IeGHq3lmXp/FTobZh8MDWzncIItwyfzf34usqdSrHLSX4vhG49G+IBiBGt2gsLJ/cnOTaz3fLvG1jd6XlrcFutrF/M+33Dy6wt5qz8EpWcanVmR82Bk5noaQWjo7tN5T/q8ilHeVTmBBkmcZvb0xoxIgij3K6rFlYR40Q5SuVDd455uxfhGkb6o85bEzN/6DoJgGUvUfgaMJkV3K4bsXNEL+8dAdm/Kb27C5cuzwFhKzcadVCh+ClJ/HadkiZT3cY/TiGEKq6LA219dVpkdopw7jC8wy0Y8GffTI/Y2+3
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB12085.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec0ffe58-d53b-4a48-a81f-08ddb45c7d52
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2025 02:52:28.8847
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aVTefemYnvOBYrt6YvnkiSnGej8UEocGFIKcZ98Ap54N1xUPAX9jxpXJgR/FDOGi8pelOl3t0HEUHm/F5vF4Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11432

DQoNCj4gLS0tLS3Tyrz+1K28/i0tLS0tDQo+ILeivP7IyzogTWtydGNoeWFuLCBUaWdyYW4gPHRp
Z3Jhbi5ta3J0Y2h5YW5AZGVzeS5kZT4NCj4gt6LLzcqxvOQ6IDIwMjXE6jbUwjI2yNUgMjoyNw0K
PiDK1bz+yMs6IEplZmYgTGF5dG9uIDxqbGF5dG9uQGtlcm5lbC5vcmc+DQo+ILOty806IENoZW4s
IEhhbnhpYW8gPGNoZW5oeC5mbnN0QGZ1aml0c3UuY29tPjsgQ2FsdW0gTWFja2F5DQo+IDxjYWx1
bS5tYWNrYXlAb3JhY2xlLmNvbT47IGxpbnV4LW5mcyA8bGludXgtbmZzQHZnZXIua2VybmVsLm9y
Zz4NCj4g1vfM4jogUmU6IFtQQVRDSF0gcHluZnM6IEZpeCBSdW50aW1lRXJyb3IgYnkgaW5jcmVh
c2luZyBkZWZhdWx0IGNhX21heHJlcXVlc3RzDQo+IGZyb20gOCB0byAxNg0KPiANCj4gDQo+IEkg
Z3Vlc3MgdGhpcyBpcyB0aGUgc2FtZSBpc3N1ZSB0aGF0IEkgdHJpZWQgdG8gYWRkcmVzcyB3aXRo
DQo+IA0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNTA0MTUxMTQ4MTQuMjg1NDAw
LTEtdGlncmFuLm1rcnRjaHlhbkBkZXN5Lg0KPiBkZS8NCj4gDQoNClRoaXMgb25lIGZpeGVzICIg
T3V0IG9mIHNsb3RzIiBpc3N1ZSwgYnV0IERFTEVHOCBmYWlsZWQgb24gQ2VudE9TIDkgd2l0aCBh
IDYuMTUga2VybmVsIDoNCg0KKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioNCkRFTEVHOCAgIHN0X2RlbGVnYXRpb24udGVzdERlbGVnUmV2b2NhdGlvbiAg
ICAgICAgICAgICAgICAgICAgICAgIDogRkFJTFVSRQ0KICAgICAgICAgICBSZWFkIHdpdGggYSBy
ZXZva2VkIGRlbGVnYXRpb24gc2hvdWxkIHJldHVybg0KICAgICAgICAgICBORlM0RVJSX0RFTEVH
X1JFVk9LRUQsIGluc3RlYWQgZ290IE5GUzRfT0sNCioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqDQpDb21tYW5kIGxpbmUgYXNrZWQgZm9yIDEgb2YgMjY0
IHRlc3RzDQpPZiB0aG9zZTogMCBTa2lwcGVkLCAxIEZhaWxlZCwgMCBXYXJuZWQsIDAgUGFzc2Vk
DQoNCj4gREVMRUcgOCBnb2VzIGludG8gYSByZXRyeSBsb29wIGlmIHRoZSBzZXJ2ZXIgcmVzcG9u
ZHMgTkZTNEVSUl9ERUxBWSB3aGVuIHRoZQ0KPiBzZXJ2ZXIgdHJpZXMgdG8gcmVjYWxsIHRoZSBk
ZWxlZ2F0aW9uIGFuZCByZXNwb25kcyB3aXRoIE5GUzRFUlJfREVMQVkgdG8gdGhlDQo+IGNsaWVu
dC4gVGhlIGhhbmRsaW5nIG9mIGEgY29tcG91bmQgY2FsbCB3aWxsIHJldHJ5IGFuZCByZS11c2Ug
dGhlIHNsb3QuDQo+IFRoZSBoYW5kbGluZyBvZiBERUxFRzggd2lsbCByZXRyeSwgdG9vLCBidXQg
dXNlIGEgbmV3IHNsb3QuIEFGQUlLUywgc2xvdHMgYXJlDQo+IG5ldmVyIGZyZWVkOg0KPiANCi4u
Lg0KPiBJdCBsb29rcyBsaWtlIGFsbCB0aGUgdGVzdHMgdXAgdG8gbm93IGhhdmUgaXNzdWVkIGxl
c3MgdGhhbiBjYV9tYXhyZXF1ZXN0czopDQo+IA0KPiBUaGUgcHJvcGVyIGZpeCBwcm9iYWJseSBz
aG91bGQgYmUgc29tZXRpbmcgbGlrZToNCj4gDQo+IGRpZmYgLS1naXQgYS9uZnM0LjEvbmZzNGNs
aWVudC5weSBiL25mczQuMS9uZnM0Y2xpZW50LnB5DQo+IGluZGV4IGY0ZmFiY2MuLmZlNDA0Y2Qg
MTAwNjQ0DQo+IC0tLSBhL25mczQuMS9uZnM0Y2xpZW50LnB5DQo+ICsrKyBiL25mczQuMS9uZnM0
Y2xpZW50LnB5DQo+IEBAIC01NTEsNiArNTUxLDcgQEAgY2xhc3MgU2Vzc2lvblJlY29yZChvYmpl
Y3QpOg0KPiAgICAgICAgICAgICAgICAgICMgb3BlcmF0aW9uIGl0c2VsZiByZWNlaXZlcyBORlM0
RVJSX0RFTEFZDQo+ICAgICAgICAgICAgICAgICAgc2xvdCwgc2VxX29wID0gc2VsZi5fcHJlcGFy
ZV9jb21wb3VuZChzYXZlZF9rd2FyZ3MpDQo+ICAgICAgICAgICAgICB0aW1lLnNsZWVwKGRlbGF5
X3RpbWUpDQo+ICsgICAgICAgIHNsb3QuaW51c2UgPSBGYWxzZQ0KPiAgICAgICAgICByZXMgPSBz
ZWxmLnJlbW92ZV9zZXFfb3AocmVzKQ0KPiAgICAgICAgICByZXR1cm4gcmVzDQo+IA0KPiANCj4g
DQoNClRoaXMgb25lIGlzIGdyZWF0IGZvciBtZToNCioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqDQpERUxFRzggICBzdF9kZWxlZ2F0aW9uLnRlc3REZWxl
Z1Jldm9jYXRpb24gICAgICAgICAgICAgICAgICAgICAgICA6IFBBU1MNCioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqDQpDb21tYW5kIGxpbmUgYXNrZWQg
Zm9yIDEgb2YgMjY0IHRlc3RzDQpPZiB0aG9zZTogMCBTa2lwcGVkLCAwIEZhaWxlZCwgMCBXYXJu
ZWQsIDEgUGFzc2VkDQoNClRlc3RlZC1ieTogQ2hlbiBIYW54aWFvIDxjaGVuaHguZm5zdEBmdWpp
dHN1LmNvbT4NCg0KUmVnYXJkcywNCi0gQ2hlbiANCg==

