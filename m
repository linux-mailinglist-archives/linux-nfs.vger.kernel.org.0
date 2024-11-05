Return-Path: <linux-nfs+bounces-7666-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4789BC4CC
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Nov 2024 06:44:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ABC4282828
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Nov 2024 05:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B11E1B78F3;
	Tue,  5 Nov 2024 05:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="k4Wb2AyC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from esa2.fujitsucc.c3s2.iphmx.com (esa2.fujitsucc.c3s2.iphmx.com [68.232.152.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66304183CD6
	for <linux-nfs@vger.kernel.org>; Tue,  5 Nov 2024 05:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.152.246
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730785489; cv=fail; b=gQaGKklC9hQv0ty0xqJzU/TxOV4Z5mTC0MIV7mvWu/O3nv8+HAsX9DcOG6jLU13wGkrD/xX5y3Je6ApggglQDnRrHEIbX5MLpNkaiJmiQ/r41RLgDUNv9tkoSQkxEEN+SgT8q5BIXPgRD8h3gOhVOHOjoZn0MXIzjtu4/JajjLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730785489; c=relaxed/simple;
	bh=t/9n0ekh5DTpKe6jyRjwvCqNjLKadWuOJX2y0UoHJ+E=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=TbySL9EUR8xZ3D/bOoR594rW8GaSF0FhtrjsMDQZLyRApQbWpEa7eSNPi+JAC5q3YfIBsgL9vis+wnq4am1PsiMsm6fWxoVusdK56rtqjBPZ7ZNd+OOXQxFLHszByMH5fUt3SBUdhBwarWGyGVP3IhIiQx2Xl3C+EsCsWZEXTMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=k4Wb2AyC; arc=fail smtp.client-ip=68.232.152.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1730785487; x=1762321487;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=t/9n0ekh5DTpKe6jyRjwvCqNjLKadWuOJX2y0UoHJ+E=;
  b=k4Wb2AyCJPHF8G6fmdXgvn1LuvEeslKt+O9HKnmBBejMUSN23siOXyjW
   efnnsQ0WatGpBOrBmAp2ltjpaJ5EPL9d6omszQtUp0vBINYx+JLNb6l82
   sDOJYUg3zp2S4h6Sp1ZfUpQL9yG2BY88VpOjGth0ui/QejXocVXildVg4
   TRURWdCSFRK7uYQnQIkZWFC0AWrm/hq41P4qlWABMRn/jE5f34dkgENx4
   HHy/BBaC5VK6ChO2qS7HRFHVEfT5dAbp8z+TsOyIoDFyLTB4C5fp6SJ9T
   x4tgM/agOpqv8cuiaJfwJL/Ntddm1A+JgUROmldop4VtkMr7ODbRKbeJg
   g==;
X-CSE-ConnectionGUID: fX5K4W3vShigefUVEF2Zeg==
X-CSE-MsgGUID: +ZK+6+31TEuY0uwnIQd8Qw==
X-IronPort-AV: E=McAfee;i="6700,10204,11246"; a="46868702"
X-IronPort-AV: E=Sophos;i="6.11,259,1725289200"; 
   d="scan'208";a="46868702"
Received: from mail-japanwestazlp17010003.outbound.protection.outlook.com (HELO OS0P286CU011.outbound.protection.outlook.com) ([40.93.130.3])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 14:43:34 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y1r+195m2VkdIKqkQe08117AjACaqZm+6F+fpiIkVZEICantA4kGfwqRuTFbMQy63msOGEYXMe9RZrv4UdlLpoQ1Mf0CrwTH4LObViY+Zrx/FiTsrIRxNrdTP1DofQK8ElsxDIeqBIzJywZ46tfhPq4Fjw7+YXG5N0kwERTYOevnLJo8445u4qnYzFQw64p3p0uTNiLDpC6UH4ufwVMqTi6ZVvcx3jzFk6I+uSmqs2P/UH7UFGbS+AawSsPYBRJnUf+SBiCEPDju+OqKayO252b2/PkIrWfi8T4s1k141baD+9NcwRv2ck6YPIzQpm9Us7qzQYIFc+fs+kYYuQLqqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nm2MN0vx8zPAuSHtyTePz5flVeN6oVhE19FqG8LNhnY=;
 b=I8oPFR5Hm8mUCntXp1CYqUNsMsEap8MVD5ul9pqfZvYvi82Av8NwmQytXYA3Q3kp4vXAnwd2SaFrFn2jXchYBeDRjGgX3yTVwgxJySsu4ztv7LElfEpK58IAZHTmz1+A+911Q1RM4CwDvV4ZwDrUuDTP/3MrMRWVsDzGF1HXBeqJEkZ4brI408lb3i33CZR1ZcZUTNnJCSw0W/HHq0gXiT84fD+dV4I+vf/rTd9l2dZyceBx/SdlWZV2PPke0u0KcYHDHaPCdbEcJbxQd8OiIFzBgvYqOpVncgbKaf4KOrXLSO254KIylPP4qehGSiirvRG8uLvJEHX3JLkPIc26TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSZPR01MB7772.jpnprd01.prod.outlook.com (2603:1096:604:1b4::7)
 by OSZPR01MB8579.jpnprd01.prod.outlook.com (2603:1096:604:18d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 05:43:30 +0000
Received: from OSZPR01MB7772.jpnprd01.prod.outlook.com
 ([fe80::df28:316e:ef65:39a9]) by OSZPR01MB7772.jpnprd01.prod.outlook.com
 ([fe80::df28:316e:ef65:39a9%6]) with mapi id 15.20.8114.028; Tue, 5 Nov 2024
 05:43:30 +0000
From: "Seiichi Ikarashi (Fujitsu)" <s.ikarashi@fujitsu.com>
To: "'steved@redhat.com'" <steved@redhat.com>, 'Scott Mayhew'
	<smayhew@redhat.com>
CC: "'sorenson@redhat.com'" <sorenson@redhat.com>,
	"'linux-nfs@vger.kernel.org'" <linux-nfs@vger.kernel.org>
Subject: [PATCH RESEND] mount.nfs: retry NFSv3 mount after NFSv4 failure in
 auto negotiation
Thread-Topic: [PATCH RESEND] mount.nfs: retry NFSv3 mount after NFSv4 failure
 in auto negotiation
Thread-Index: AdsvQ9WEZO1QrU5sRpi/OoEADq2E9w==
Date: Tue, 5 Nov 2024 05:43:30 +0000
Message-ID:
 <OSZPR01MB77727651A22E3D89E72954DD88522@OSZPR01MB7772.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=e86cf436-a95f-4d16-a2bb-123b39e7f80d;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2024-11-05T05:29:16Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB7772:EE_|OSZPR01MB8579:EE_
x-ms-office365-filtering-correlation-id: 157c5f1e-eb38-44ae-4ddf-08dcfd5cc7ab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700018|1580799027;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?dlp0S3NNRlFwZXdNU1NHQzlBUy9YdVAxR0JTUldxQXpMVlA5d3JkeGlX?=
 =?iso-2022-jp?B?cERMb1gvZFJRUmllek1XeUdVMDNnaUZ1UjJnWkdPQzJhd2ZtSk4xTHZR?=
 =?iso-2022-jp?B?VGxMcWo0YmVQYXhyaDhDanVTNko3M3VkYU1wYVd1Y2U5emtFaEplY0Zn?=
 =?iso-2022-jp?B?aTdqNmJLVTFPeTRhYkpobTZYbW1mUVZwWFhOSTdOMGVQaWFrbnNSWnJh?=
 =?iso-2022-jp?B?Zy82TjROMkFXeWhQdFYreEl4aUNBd2NkTTdTK3VqV3luVllzMzhOL2NU?=
 =?iso-2022-jp?B?czZ2VGxZaTA3V3Q3ckcva004R3lINmV2TEZpZDhNVzFydDBEM21lMWI5?=
 =?iso-2022-jp?B?blBCNjJHU2h6YVVtUHczVkxPcE5MYTY4bDhQYjVMK0dQTWNHYWpQUis5?=
 =?iso-2022-jp?B?bCtJUDNQUXZHWGgzVmJpSUlzRW0wbzVpZDFTWnNObW01Z01KZEpaMGhC?=
 =?iso-2022-jp?B?elNJNnNNYVcyQ3lsY0xoMWFRV3hNUjVGOG9MY2F4SVJ5OU1uS2xrMy9T?=
 =?iso-2022-jp?B?ZTlldklOdjAyV1lsQTYvOTN5bnY4ZjhDVVJQeXo3dTEyVXF4eWYwY1dM?=
 =?iso-2022-jp?B?SlN4MndmUEJYY1JxOVRDYU9qdG1sQ3YxS1BxUEdnZnYxWXRwdnJKbmZJ?=
 =?iso-2022-jp?B?eEIyUVdNdUxqOHZKZmxtODQ2MVFnWXpUejB1a0d4UVRpK1B4ZnlXbWlv?=
 =?iso-2022-jp?B?anFtTEQrSVRjdjJIVCt4VmdYN2I2cUNSVkFFR1N1emRYQ2gzZC9OZjg3?=
 =?iso-2022-jp?B?WW9icFBHbFo4Mm0rbXJYYVZsWTlzZFBSRlpvdmh3S1o1N2RaWWI1QUtB?=
 =?iso-2022-jp?B?TXdHZ3lsQnpIOXhpRWFFSFcxZUdRMEhHdSsyRjFZUG51Zy94TUp0ZW9i?=
 =?iso-2022-jp?B?TUFrWXVpV1VEdnNuVjBydmtZK3JLVmRmL01tZnhqV1RiNktlRFBnRXVF?=
 =?iso-2022-jp?B?c2dCeGMrdVFmZkttSUN4SFh5V0xnSlNLcWJsSmF4RlVKTWoyMzJjc1B4?=
 =?iso-2022-jp?B?TzJvNXdGS21ZbkZSdkxrS3FNelA2Mmx4YjVCQzhmUWdWVGVERzdqeTV4?=
 =?iso-2022-jp?B?YUNsTnZMV3QweWcwdzg0NlRXRnpSZXQ1TFpBd3Bwa0REYnkzN09zR1Jr?=
 =?iso-2022-jp?B?TVB0UHhLKzRBc21HRkdRVVN4MGxRT2RSUHRySmlJY21mMVJkVEF5NnVw?=
 =?iso-2022-jp?B?c2FaaWRNYml0UEVQMyswdHBkQ2lrRHc0RW41Tk45Y1pmcmR2Y2ZGVEdF?=
 =?iso-2022-jp?B?VUp6ckdFQmF4RnhDUHVFWTlZVFcwb1R1NnBLOElJMjZIUnV3YzBvT0JJ?=
 =?iso-2022-jp?B?MGlvWGREdWlwbUdjL2hZVmZta3dSU1hVYllOZW9Oa2lQVHpOZ21rd2Rx?=
 =?iso-2022-jp?B?dWp2UGFXUTBweTNvYkc0RVpxUllpMVZycThSVjFDdmpHRVE3TWZtWGtL?=
 =?iso-2022-jp?B?SnhsRmh1eldVQXVtV0FDMzdYSFp0MDlvd29Pb215LzEraXp4NEdOcDMx?=
 =?iso-2022-jp?B?U3VqOXNHbFlwTzBmQzRSM2k4YTlNenpxL2M5TSttQzVad09sLzJpdDEz?=
 =?iso-2022-jp?B?QUtHVHR4YnUzTFdOZkNnWVNjWTRLVFVJelFOb0k2anVYL2ZzcURDN1Bs?=
 =?iso-2022-jp?B?TDlxT1d2Ti8wUEtPZEM3U0RCZ2E2c2VhcjVqbmJOWGJYUXVMOWQ4UWtN?=
 =?iso-2022-jp?B?NnJFVGN5V3QrSFJOUjhJNnRZN0lXU0lGR0ZQSFpFQ0ZMam5Gb0VFc1hx?=
 =?iso-2022-jp?B?dEE0dm9XclVZVGNOSWdCaXpZWDErMnhSbWsxanp4V0FXM2hjOGNNMUpP?=
 =?iso-2022-jp?B?MXFBN05DWkZZV000VEp6VlRYZmVZU1piOCsyS3BPMmFwZnhJakdkZjdv?=
 =?iso-2022-jp?B?TkFaejhVNlhDRWROS1dSTmRrSlJOeExzZDU2MG5WL251SzdNTkdGdzIr?=
 =?iso-2022-jp?B?T1BMV1piZVJuWGdzc2xCWEM3UlIwb0p1aSt6RHF1T29LTWFYQXJTVm43?=
 =?iso-2022-jp?B?aTExRUhSblNjTFRNNUF1YU9WNDJsaHVSaS9tZ0FxMVptZStVL2Myd0kv?=
 =?iso-2022-jp?B?REE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7772.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?MnFFOTNTRkdPU1dma0FoSUJQNE9vdWc1NWZjWXN5TEl0VFY3RkkyUDhw?=
 =?iso-2022-jp?B?WlgwWEhIbWdWd0o3bVVyRmpKUm1nYmVublBoWnJRMDhkc29oUzlrRGwy?=
 =?iso-2022-jp?B?SG81NkgrTVNWbkQvcnFnVTloUWdPMUVhS1RETk96ek5hK1NDdnlsR3Yz?=
 =?iso-2022-jp?B?U2l4T29HN2Q5b256Q2w5eUFDWTRJbmN0OFR3eHpXb3FBK01vWHlyV2N6?=
 =?iso-2022-jp?B?U3JVMkVPNTArKzdqb09tdUEydFlxK0dkUW9BRk1zc3BVOXZYMXJiOEdU?=
 =?iso-2022-jp?B?OCtwOUdiaWZkdnc3TElBSng4L0RXNmdlZ25qUjBhL1BuYlREOG51Ync5?=
 =?iso-2022-jp?B?S2IrYUExWGkrbW5LT2FCQVR6NVpMbjZ4MVhGWldLV0JMZklEVmlLcXpz?=
 =?iso-2022-jp?B?Qi9UdE8xK1BjYWh6RnBrOUN6TklyRTY5NjlxRVp1WithMXlMblBULzFp?=
 =?iso-2022-jp?B?dTdkN080dSs0TVlxblNZYkw3N2FQb0dsYmFrUkYwcVI3SXdnTnJGejI0?=
 =?iso-2022-jp?B?NjNzSHJIVnU1YWxUTFNHSTR0R3pEYmhGaU04NHl2TG9KRjRBb2xKRVVi?=
 =?iso-2022-jp?B?RVFhdUpoS2ovYkI2em5XRkEvL0hXNktDSnVyaVhwZys1RzlXTUxkOWs2?=
 =?iso-2022-jp?B?eDdDRi80clAvbFVvV09PTWV1VzZTSU50STBxbFdTaTNSaDlRTllTZDhX?=
 =?iso-2022-jp?B?MDRTaHBEY3BiVzk2azdYSldyY05GT3lwY092dkZuU1ozNUdRQ2tmNmNG?=
 =?iso-2022-jp?B?S0xGR3pFMmNFVmZ5ZndFNTVDNHhEZmNUNS84L0I0UzVMS0VESEJuTVJY?=
 =?iso-2022-jp?B?T2xjZXAvbWIvRUlXMlhLWHVILysvVGtjWEg1RjRNdzkyZVdjejRqN29v?=
 =?iso-2022-jp?B?ck5DWVNCMUpzN05XLzNDMjM4dkZtNElvRFlOY1pNNEVQam45Zi9wcDc0?=
 =?iso-2022-jp?B?M3pvellLRTJselE2eFF4M0E0T0g2bU40UERCNXVua3VzajkyTzh1N0RX?=
 =?iso-2022-jp?B?bFRmSDQzTnY5UFNSbWprQlR0N0t4b0ZzS0JFZTNIb0hTVkFMaVpNRHkz?=
 =?iso-2022-jp?B?TUxYdmo5TlZydERCemZxa1NGTVQ4QmtHK3kwM01MZElEdU5sdS93U29w?=
 =?iso-2022-jp?B?MGt1VFJDK1dmSUJhdDhtSEt2QXRmUE83MGhxbjlVL2d2QjcvVGZJQnRy?=
 =?iso-2022-jp?B?dFVMbVBPNE9NSkV6Qy9JK0FMT3VCa0hIU2F5bVZrdkk4YXVBaHFsbjNw?=
 =?iso-2022-jp?B?WVBEdHROVHJHVThkdlpZUDR5Z0o2R3dlTTBISFBPdDVWbDVKTTdVSUVs?=
 =?iso-2022-jp?B?UnAzTE1VRDBESm5UU2pYMURCd3BwQVZ1TE1oV2tTZ1NwZDFNYWIvYXdE?=
 =?iso-2022-jp?B?LytXN3piekloVU1icjhIZDhCRGlPaDV2V0JNdHh1UDlucnA2UUNNMno5?=
 =?iso-2022-jp?B?dEVNUW1MRllyT3BuMElsWUx2ZjJUcDYrZ2ovc2hVaHJYWVFYSzBTTkpq?=
 =?iso-2022-jp?B?YVY2QVhLRVlLd0VPUHlpaStyZU1IVGc2YnZpT0hxcmphbTY0VXo4QlZD?=
 =?iso-2022-jp?B?OWJRNnFtWmJWRVBIdjk1UTVQaVZ0KzY3amYzSlMvQ1VuU2NZSFQ2aTZ3?=
 =?iso-2022-jp?B?Zy9uQnZsRU1ITGF2UG1SY2U1NnZ6anRtdWFqT1NHVlp4K3JrRVdUcDdG?=
 =?iso-2022-jp?B?bFo3cER6K3B6TmR1UVFMN05VYlJQSXhyWjQzbFRtelJKZW1JdkVwSkZj?=
 =?iso-2022-jp?B?bUxzWWJma0JydzNmR0hWUk1xRzNnMnhrb3M2UXZlVHpJSUQwSnlUY1lQ?=
 =?iso-2022-jp?B?K0pNOWpNbHlVMVRvOFo3QTI1bjQ5dmEvUmV6RThpRUxMZjljYzZPUkgy?=
 =?iso-2022-jp?B?aGJ0VVVtcWJYYTQ5S0tRTS9qUk1pMjFXbFE3eThFbXA0aDl5R0ozeWFu?=
 =?iso-2022-jp?B?VzNKaEJGUlQyYmJNNjljdzlIT1hJVllGazVSbmF4TWsrODl4U1lXbHJm?=
 =?iso-2022-jp?B?TGxZYndERmdYTC9abE1VZGsrNE8rVmVXZmhGeGhHaktwUTl3aG5oOHRT?=
 =?iso-2022-jp?B?UW5xSS9sRmlscll2V1E0RVZ6WVlwYmRsQXVHMnpwSU84alE2cEprY25C?=
 =?iso-2022-jp?B?ME95MzljV09EcC9GWEp5UUVLNndodHBKY3dDa041K2VHcVB2QzltY1dK?=
 =?iso-2022-jp?B?cmJkSGxaT3NNcGNLRGdCY2dhVHNaeWZGQjFIY2J2ZzV2NFdVY0ZERWRm?=
 =?iso-2022-jp?B?NnNKSWpUTHpqQk9jc0piVGRzSVVYVm9nZGZWY0RNcllJa3Zta2hFSU5T?=
 =?iso-2022-jp?B?SjNhZTVnN3NUc0hvYVBJRGpVcUNwbGFQZGc9PQ==?=
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
	T+5LBV1stZmjDSAxTmto6Dib8M4dIK61iV52r9QQTZo91rjthL7KEsJVrY00qoBpXLMXOrsoHdaj4vkkGlXt6mc+M4K1q1BNfz9GCQkYU0S/7OzsosPvEMyLp8WJxcroNFeypx6RHqJXbDyVDOyV7pN1S1mbPn9NHWtXSO4h8PfEREA6b1B1k6m29kfNngckKXysqEGlzhCX3Hfj7+c3c64XDUe+N5A4ggehsnQMkTgc3REVx9TFVDFzeyyhxzphPYZXhImNEvQdfyTwHf6AoVtEq0wkmk87MeYkhAcMSk7Nai9bzaz/9HsKsBjTvyfK+JSqxBESOxMsk9y8YMQ795laOXt3OiJmi/gtitoBu4L4CbpftsMoUjR/pBhl563niyMfQhTIU4ZC2DclEsuoZ0NiqKDjvnXJ5Ppo3zjYGZQFaGpelwNdrgbc5dNBJeaHcSepYLciE0QdcDl+nytD7HDaWuk8J2Qlq5d+GzAVmrnUkFCOA5u/PP6tqoRY4bE6JDByqRlAYR/2iFdTEdKLGA3lfYeFHhtsd7y8Vl8sutCeUt9h7EIj6pgVvhw9Wv8e6ntjarMWxULe4a3BIa7W5ZfCX9QTjR+p00eCEyoRHgSdnC4WMoEoi1aiX4hFzjp0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7772.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 157c5f1e-eb38-44ae-4ddf-08dcfd5cc7ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2024 05:43:30.8395
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V3YteKTdaRJv2/OveA+LoSeEV2xolCf6BYyEE2dQy5T6gAQ+h+Y7Pa3N4AzAOhdZHEStdVDxxEbb7HSXI+YSw/zXTR4H0FeqcxXW5m3OoEc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8579

The problem happens when a v3 mount fails with ETIMEDOUT after
the v4 mount failed with EPROTONOSUPPORT, in mount auto negotiation.
It immediately breaks from the "for" loop in nfsmount_fg()
or nfsmount_child() due to EPROTONOSUPPORT, never doing the expected
retries until timeout.

[auto negotiation case]:

It breaks immediately.

# time mount.nfs -v 192.168.200.59:/exp /mnt
mount.nfs: timeout set for Wed Oct 23 14:21:58 2024
mount.nfs: trying text-based options 'vers=3D4.2,addr=3D192.168.200.59,clie=
ntaddr=3D192.168.200.187'
mount.nfs: mount(2): Protocol not supported
mount.nfs: trying text-based options 'vers=3D4,minorversion=3D1,addr=3D192.=
168.200.59,clientaddr=3D192.168.200.187'
mount.nfs: mount(2): Protocol not supported
mount.nfs: trying text-based options 'vers=3D4,addr=3D192.168.200.59,client=
addr=3D192.168.200.187'
mount.nfs: mount(2): Protocol not supported
mount.nfs: trying text-based options 'addr=3D192.168.200.59'
mount.nfs: prog 100003, trying vers=3D3, prot=3D6
mount.nfs: trying 192.168.200.59 prog 100003 vers 3 prot TCP port 2049
mount.nfs: prog 100005, trying vers=3D3, prot=3D17
mount.nfs: trying 192.168.200.59 prog 100005 vers 3 prot UDP port 20048
mount.nfs: portmap query retrying: RPC: Timed out
mount.nfs: prog 100005, trying vers=3D3, prot=3D6
mount.nfs: trying 192.168.200.59 prog 100005 vers 3 prot TCP port 20048
mount.nfs: portmap query failed: RPC: Timed out
mount.nfs: Protocol not supported for 192.168.200.59:/exp on /mnt

real    0m13.027s
user    0m0.002s
sys     0m0.005s
#=20

[nfsvers=3D3 case]:

It retries until exceeding timeout as expected.

# time mount.nfs -v -o nfsvers=3D3 192.168.200.59:/exp /mnt
mount.nfs: timeout set for Wed Oct 23 14:22:23 2024
mount.nfs: trying text-based options 'nfsvers=3D3,addr=3D192.168.200.59'
mount.nfs: prog 100003, trying vers=3D3, prot=3D6
mount.nfs: trying 192.168.200.59 prog 100003 vers 3 prot TCP port 2049
mount.nfs: prog 100005, trying vers=3D3, prot=3D17
mount.nfs: trying 192.168.200.59 prog 100005 vers 3 prot UDP port 20048
mount.nfs: portmap query retrying: RPC: Timed out
mount.nfs: prog 100005, trying vers=3D3, prot=3D6
mount.nfs: trying 192.168.200.59 prog 100005 vers 3 prot TCP port 20048
mount.nfs: portmap query failed: RPC: Timed out
(snip)
mount.nfs: prog 100005, trying vers=3D3, prot=3D6
mount.nfs: trying 192.168.200.59 prog 100005 vers 3 prot TCP port 20048
mount.nfs: portmap query failed: RPC: Timed out
mount.nfs: Connection timed out for 192.168.200.59:/exp on /mnt

real    2m10.152s
user    0m0.007s
sys     0m0.015s
#


Let's retry in auto negotiation case, too.

Signed-off-by: Seiichi Ikarashi <s.ikarashi@fujitsu.com>
---
 utils/mount/stropts.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/utils/mount/stropts.c b/utils/mount/stropts.c
index a92c420..103c41f 100644
--- a/utils/mount/stropts.c
+++ b/utils/mount/stropts.c
@@ -981,7 +981,7 @@ fall_back:
 	if ((result =3D nfs_try_mount_v3v2(mi, FALSE)))
 		return result;
=20
-	if (errno !=3D EBUSY && errno !=3D EACCES)
+	if (errno !=3D EBUSY && errno !=3D EACCES && errno !=3D ETIMEDOUT)
 		errno =3D olderrno;
=20
 	return result;
--=20
2.43.5

