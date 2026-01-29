Return-Path: <linux-nfs+bounces-18592-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6N5/BIEfe2msBQIAu9opvQ
	(envelope-from <linux-nfs+bounces-18592-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Jan 2026 09:51:13 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B7CADBD3
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Jan 2026 09:51:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BE22B301B162
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Jan 2026 08:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980F437E2F5;
	Thu, 29 Jan 2026 08:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="TGL4sHVJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011042.outbound.protection.outlook.com [40.107.74.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7FF2BEFFB
	for <linux-nfs@vger.kernel.org>; Thu, 29 Jan 2026 08:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769676644; cv=fail; b=jSfWoCifeGdiCQ9nSLhb9C9bnmpfM2zFjxF4T2ci9dYkr3Uko1JoUrenn8DhU5z8RvOHk7PRBKMDRJ4N0abx5bcNwvl7Jia0xYUMpqybpbswSJiQPFGV7ZSf1ZmuFAah26KskStfQ1L3idWSFuejnDtlBHNSI6Ws6Jq0EjOMfvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769676644; c=relaxed/simple;
	bh=2tYMxftfjIudP7WGM1UuYMV7kFbJCBsZVW7JaclK2/8=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=MyPHCVgH6hZhm7Y9m52tBpEQ0B7HbYXoe7SvaMyMJPyWOd+SPqH5WDfRTpAnE9TcbeE8cK3VBVaoYe0c+cHj2uMPWxILQS1hkZJJHzfBHkDmvdcyuLjbSJEYbqRaBcqU0arYSe+yiOC9q9qCOswIDUBI9m4LqqZd6wbDcfKJq7w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=TGL4sHVJ; arc=fail smtp.client-ip=40.107.74.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b0mlYOzTONU4puEPzjrpP/LYSyq3NyC2rwhQMbfdTx6zq68aFMpyucTtsmDivR+uOUaCoKpn6HqVwHv8sM7HYMXerAOpR9UKY8i5q5mgA3Y5ppihPJkRvNO0iuvPRUIykua52HjMLFJk4NbYd8HZu5Svkd4w4eqG8cG+kO+mu1LrzjwfelhvYctof6PmjbXlD0EFdxbPQvgpiwpZLRtU0YZf3A85IQcteobbQ5jSg7JS2Qv0dOFVn2TVtfmIWdoFr8tmYbwNaMaOBfFefHDMWfO0wiBrLeRYWjM99QN1RjP5S3p1y1+cSnXyfCeLMDy3cZRSn/5jOEQrQkrC+7lRDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2tYMxftfjIudP7WGM1UuYMV7kFbJCBsZVW7JaclK2/8=;
 b=ugnBUEset/yHPEMsaQ+KH16tUNBJNOek61NltIZg8Sgu7F2QOSwRtL0FCXsmwqQOtgqqyk42XTv4OT4L0jNM3Gs+/SjrY7Ny8yCdQHQyAGTjeSzjwy3i7zHvjdV7jRMfIybO/WD2QG641oK3w2u5ydYyeUDM79F6tM6HoX7Rongo4Vn/UrH3VqO+VJpKsqeLN2N2/NjFOcMLIpAgfsdiU4digM8YD+bkzASgx3/Tcuykyi5S+wWHNvmj7Lzz/P7d/qqnI/p8lI62lLpC+TwRve5UV8qy2u9RufEqfH3pGhhAtal+PZf7pUJZ05YurvTrGyJAg+ii9SWiTY5NJOSpuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2tYMxftfjIudP7WGM1UuYMV7kFbJCBsZVW7JaclK2/8=;
 b=TGL4sHVJfE/3B3SJjNy2Nxj1Zu87HYOJtD8+Toxl5h6CIuJloXqvxWtBbK0WVH/w8ouJLrokIllNpV/thYl7mkQ3Oi2DRvfroyHmf+9FUh3ylMAbUHj/TuNBW6xxmdn3hizidzdB79+vh3Z8tGJntRQXVniTldoq/vsF0AMXwoz2KPAIdtR339i1YHM4WVjyLCBViv80d7BgqX/rFVlD/4F+EyN+z/m3QvJlEum4PAaQ6IZaeg4Ep2AExF/ZDuODRL9CWHA0rnYZa7b9HFeLG9FNGzB5DQpqGyqWqw/7lMFICN30Oj/KC47LBs4r5FGhxcUooPdGMw2sBf2jNT5jFA==
Received: from OSZPR01MB7772.jpnprd01.prod.outlook.com (2603:1096:604:1b4::7)
 by TYYPR01MB15165.jpnprd01.prod.outlook.com (2603:1096:405:1a0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Thu, 29 Jan
 2026 08:50:36 +0000
Received: from OSZPR01MB7772.jpnprd01.prod.outlook.com
 ([fe80::5956:959c:6018:183a]) by OSZPR01MB7772.jpnprd01.prod.outlook.com
 ([fe80::5956:959c:6018:183a%6]) with mapi id 15.20.9564.006; Thu, 29 Jan 2026
 08:50:36 +0000
From: "Seiichi Ikarashi (Fujitsu)" <s.ikarashi@fujitsu.com>
To: "'linux-nfs@vger.kernel.org'" <linux-nfs@vger.kernel.org>
Subject: [nfs-utils PATCH 01/10] nfs.conf: fix a typo in man page
Thread-Topic: [nfs-utils PATCH 01/10] nfs.conf: fix a typo in man page
Thread-Index: AdyQ+iZybxEc3xMcSwep+tL/iAb3bA==
Date: Thu, 29 Jan 2026 08:50:35 +0000
Message-ID:
 <OSZPR01MB777284386053189423C1D6C3889EA@OSZPR01MB7772.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=9441bf7e-eabf-486e-9aa9-594c3504216d;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2026-01-29T08:34:23Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB7772:EE_|TYYPR01MB15165:EE_
x-ms-office365-filtering-correlation-id: 581f3012-ff5f-479e-8fea-08de5f137840
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|1580799027|38070700021;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?b0d1dVdFb01zdEkzaGx5RkFuK0RkclhqUFNBempIVDBpc202WmFnRjhp?=
 =?iso-2022-jp?B?NmR1MXJGdmtoWjBrWDBJblFUNEREUnMvQ1lvZlBLb3lON0M3ZUxUSm50?=
 =?iso-2022-jp?B?Z01NQ1VOYnZGekFwU2ZaYU9rRjRrOFpKZ0IyTk1xcm5pRkFvUjNscDcy?=
 =?iso-2022-jp?B?SlR2SFZVWmZnS1ZZTmdJZFpZTTZBYzJKZVNTQ2VGZldJSjFhdFU1WE1R?=
 =?iso-2022-jp?B?dllIa3JOR0JFZWNIV2NEdVdxRi9udGtTWlBFZDFpeXdyU1lvaWloT1c1?=
 =?iso-2022-jp?B?ZHRFYzBCVVlpZkN4MDdUYmE2RFVHVmFVdjQydHBPcXFnNnZrWU5qc0F2?=
 =?iso-2022-jp?B?R0ZzR0laOEovMHpsSFl3VkVQZzZoV2tQdFkzcklhSmVsUWxNYnBhSUJZ?=
 =?iso-2022-jp?B?ZVZoOER6ZVJWeXEzbGlZWHFSbzkwazlGODVzTnExYmsxb2lhS1JiK2lU?=
 =?iso-2022-jp?B?WXAzdTVWUVp0dkRiL2NxWlU4Vk4vNkFZNEF0YzdJcGtlOFlZeDhtUldo?=
 =?iso-2022-jp?B?Q096aTVVTFBsQ1ZFNEYxNXdZTWZmbUx6Ymw5dXRGQ094T2RvazY5L1hU?=
 =?iso-2022-jp?B?VmVTek81NlIxU2RQbVJudXgvZEhyMHljRTVzakxScjFic0Z6Sm1KOXBY?=
 =?iso-2022-jp?B?cjlmeDM1ZVEzK2xYNFRBNlcvWWRkYXRjazNmeGF6aEdXVEFTVVlKMlU1?=
 =?iso-2022-jp?B?QWFpUkhMaTFKWFd0NlJ3VC9PMHpNb3hEMzdUSlJjZ1ZScGdiT3MwOC9k?=
 =?iso-2022-jp?B?Y2FmZ2o3YVFuOEFEZjZTU1N5b3B2alhoWmYxc01zYU5uYzFFL2VMenFz?=
 =?iso-2022-jp?B?bXhkWVZtUE1jR0dBeHVHYkRtc1VmUGRsd1NkM3FhUFMyMTVQSW1NUi9P?=
 =?iso-2022-jp?B?NmhCODFaRWRKUTdQK3RMeForbFJZTVByNXgwL0h0bWtPaUdjL09JTWg3?=
 =?iso-2022-jp?B?NkFwNU9rd0lOdm9GZkY4TlFVU0xLVk16dVRldVQ5eFFhdmdZODlkOEVt?=
 =?iso-2022-jp?B?cU1Na3diN0Q4K3ZtdU9WZDFyZ1c4U3M5RVdpRlM0SldaOGt4b0QyblEz?=
 =?iso-2022-jp?B?cTF5SGo2R25YRTk2RDAxaGUvc1BuWVZWRVM5MVJmcXBIZDJXUGNMK0JS?=
 =?iso-2022-jp?B?cnhxeFF5ZXlZVnJkTjcvcDJQcFJlK3ZMU0lvalk3c2NxMHRYY0xqZnRN?=
 =?iso-2022-jp?B?NEtibExFRFBnZFFPT0s0dXVVaTdmS3hMN21yejM2NEczY28vUk0vZVFH?=
 =?iso-2022-jp?B?WHRiV1UxK2hlSkt0TFQvM2s5MjJnNVhmV2NOZFU4YnIzVlg1SldCRSt2?=
 =?iso-2022-jp?B?M1hhMHdVZWZaaUZWbE01WjcxeUk0SEtKdThxaVU2cEljYllhZHlZQ2xG?=
 =?iso-2022-jp?B?TXZZZVFZRnF6aE5KNXA0WXM0citBUWlGdEpTMCs0ZlJSeW8wc1NKRlBq?=
 =?iso-2022-jp?B?VnQ5bUpvQ1hZekpXRHR2S1dFNTMwOWFvYVpuelJLNDdiekNQd0d5c0FC?=
 =?iso-2022-jp?B?OHhwK0pvZkxqYWZURzFKRFNDeUU1L2t4anVLSEM2S3U0Y05oZ01PMTEr?=
 =?iso-2022-jp?B?Nzh6MWNiU0x4empJRUFVSTNDS3hvSUZWVUF3S1pVTDNEdGYzaHVUaU81?=
 =?iso-2022-jp?B?ekl5Z0RsWlVPYW5rUlRUNkNWZlJxRHhMeEhyckR1VXE2SllHVW9Yc2do?=
 =?iso-2022-jp?B?UFM4NnFNOXkyUGtTVmpsdzRhZkJhL1VJakxsSDd5NG9lbStBSVBJdEdH?=
 =?iso-2022-jp?B?c21rUFdEdnhTeFBmM29zS3hRYTNZcFAvVkY5dHkzSlh3RzNFLytiZzF1?=
 =?iso-2022-jp?B?b2E2bXhmRW4ybmMzdGdMSU9OWWtObE85Zk1XNjljVktUZFJaRE0zTFBa?=
 =?iso-2022-jp?B?dE9oNzk2NDQrNWhJV0RRSmozV1NudklFOHN3aVNSd0I5TUdzblZTaS92?=
 =?iso-2022-jp?B?SkpVNThTNW52MUVOZk1NSHE4U1Rnd3BYcDJuSFhya21xb2R0QVgvNTBq?=
 =?iso-2022-jp?B?UHlrOXVsSkFucThGSDJiUVZpbm1LcldzT3RHTjZBZEdsUXAxVkRoc2tN?=
 =?iso-2022-jp?B?ODFVWVBGSm5HZFV5b3BXTXJoSkErMXc4UEluQzBxUXpmMzI3a3BseXBM?=
 =?iso-2022-jp?B?cXcwSzRrUkhwZzJMUGh1OUZJbkVtVjBycWk5TWdreVMrb3RzUlk1S1VT?=
 =?iso-2022-jp?B?WmxsbXcvZlVKTDhwTXd3cTIreUtQaFQ5Yms4UWhUQk9qQXArM3F5ZWhy?=
 =?iso-2022-jp?B?bUdaM0pEUEZaK2J1SVpNZTdSN1lDNUZhc256cnRMSWlWSmJLUEJhdzha?=
 =?iso-2022-jp?B?Z05vSGVUZDZta2Z3a3hSNTVUOFAvYmNzTjdXV3p2MXhRc0tKVVNGQjhx?=
 =?iso-2022-jp?B?Z0VqcU0reGNENnpBWW1pWWtlMk81UUFHVEQ=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7772.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(1580799027)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?NEExOFBaeERxN1JaL1FxcEkyaFBWekkxYjA0WVk3RENwNGpJa0t6a1Vp?=
 =?iso-2022-jp?B?L3lnaHpVdXFmeGloaFZEK1EzdGxlSWtKRXdDTy92WU1FQXppV2l6dDRq?=
 =?iso-2022-jp?B?c3g2eGJ4a0hHOWtIOFRqckNVNjBNMnptNFhick5XZ2I0N1c3b2tNTXM1?=
 =?iso-2022-jp?B?akRFMnp4SVV4VDFQdjZQUSs1MXQ5NG9ENkorQ2V3QnpSL2pQSGdwTGRS?=
 =?iso-2022-jp?B?Q3REYWlqU3g2Z256K2JxZmpHUU0wazNsV2Ezek9rN05WdnB1bm0zdTFB?=
 =?iso-2022-jp?B?bzY5L0tKMjVKdXhjU3Z2ZDd0cEdGbXJzSG9vQjVOdmEyRTVueWpPRTFj?=
 =?iso-2022-jp?B?VU43cW5vWktqWThjYzVoeTJPL3BmdVR4dzRneW9vRkZsSWgvSDlqeVpD?=
 =?iso-2022-jp?B?a2hNVVhVN3IvVVFncklNL1U2M3FDbFpoQ1hoTEtzQmxhL3hHRndCbnFO?=
 =?iso-2022-jp?B?di9YZ3BPcXN0dWZnQzA1SDdDZjZkRjdwSVVkQ1VJQkhrQS9MMWlNcmtX?=
 =?iso-2022-jp?B?ZCt2TEJOY2F3elgxRHhrdGRSemZxT0VHaGZBL1pSMk5jZW4zMnRrcU84?=
 =?iso-2022-jp?B?YlErd04wNGh3cG1HNmxGQ0p1eG4yUmNFemFwQ29zN3V0TGVZY0tiS3hr?=
 =?iso-2022-jp?B?VFFkeHZ0QWJCWjN6V1RhNzB3UmdlWEdnYlBPejU5NTVYaTM1em1vZ0tn?=
 =?iso-2022-jp?B?VVpNdmwyWnhpZTVTUWFZY09FK1FjVitwWDhybkQyaUxjS3RPQ0xHenp3?=
 =?iso-2022-jp?B?Z0tKMVFsTHhLSGczSjBPcmhaMTc5eXAvMlQrNFg2NmtsVFdjQUhJQmpU?=
 =?iso-2022-jp?B?MVhTZVgvWE5zUHNoSmdWck1TTndzTHhqVXVGbi83QXZKd0l0NjErY1VF?=
 =?iso-2022-jp?B?UXFYVEs5aTd0eFo5N09DUkJkV1ZGYWl6Z0hEM05td2ZWVkN4RFkzUkNh?=
 =?iso-2022-jp?B?c0JKRjRoNnBIajA1dkVVck1ONEJkSW5PVDYvQWsxV3JzTHZuNGp4MWRj?=
 =?iso-2022-jp?B?M0xieldSMm4ySVdHZjViOFhvSVpRNGRvVHVqWE9vamlFWFRKMFdlZVEv?=
 =?iso-2022-jp?B?Wm1nRkU4bFFkaFZMMjAxSGhTajRvN3dqUU9HU1ZQcmZYZnBRdUJXYlBv?=
 =?iso-2022-jp?B?TmJZY05lQzlxWG1JSjZrWDRwaXByUWdNSlg3MktlZi9zR3lyUG5yNTdw?=
 =?iso-2022-jp?B?TWQ0RzVyYXF5REc3Q0RiNGpXS2RXVEtDcEg5ZkYrL2ZPckY3UG1CR2Fa?=
 =?iso-2022-jp?B?UXo5cTVyS3IzWkx0b2Q2S1NJZmpYaE9CL0JDTzJMTDN0T2ZYRTlsTkFG?=
 =?iso-2022-jp?B?MnhtOUU5MkZLMjE5ZkZCNTRrelNxYjNTZE4vRUpvcUcyeGF0MmNiaU9R?=
 =?iso-2022-jp?B?WDQ3ZW5FcVFnaWdrdW45OHRDL0tmMlhwaWFpMWgxZS9PUHVjbEpLK3FI?=
 =?iso-2022-jp?B?bFBHcGZUT1NpSyt0eXpoSnp5bFAxbVdnRUw5am9PaVRsS2l5M1l1eHZk?=
 =?iso-2022-jp?B?NklMTHdZOEFVazdzU0F2aGlUbWtuajIrZHh4czExZUM4R0lYWk1ibXo0?=
 =?iso-2022-jp?B?NjQrTFpkS3ViOFc1Y3dGQnZ4MzFQTURsV1NjenRJN25oZlVoTXJXVExh?=
 =?iso-2022-jp?B?YVNWNDZFWXdvaDRWNmJzelF6UFpueUtvMWhUKy8yNHZBR3A2aTdkQUE4?=
 =?iso-2022-jp?B?dWx4MmtMY3p4QjVOZ0tQdi9nUkw2cnBQWkR1b1B5aDlqY3ZpbUx5ZHFG?=
 =?iso-2022-jp?B?K05RU0JDS3RJUGhHS3BJZlN0RkcrcmFLUVdRTGJMN0FwYTBoVDBWZ3pi?=
 =?iso-2022-jp?B?Z3JHdDgzd1R1TENEMzUvbXNOclF2WFRDcWlsaDMzUHppNmhTQ0V0MzQv?=
 =?iso-2022-jp?B?NW9Mc2hnajFabWU3eVlVUTE2UDA3Tm5NQ0hJTVczazJiK1QrRXpMdlRl?=
 =?iso-2022-jp?B?TWY2NTMzZGtONEt3ZHN2QVR4QkJ3SXJndkh6QzV0MEZWejlPSmxvOGpY?=
 =?iso-2022-jp?B?WWJNakxOeTVBNWczNmNwZVptVnlkQTRJUHQ5ajlqOVhqK3A1a2lXVU94?=
 =?iso-2022-jp?B?QWJrenJFSGxUbklPNHBiZHcraGYwaGNBVmhXL0UvRVRYeGRyWm5KUHJO?=
 =?iso-2022-jp?B?Rmk3YzE5LytqQlk4Vy8yc1ZSSGpkQklMbFpuL3QwWUxoZnBJKzh5U0hi?=
 =?iso-2022-jp?B?RWZGd2ZpRWFMNTNxWkFmRHlLdTNzV2VEMEF2N3JWc0R3ZEV6YmZXVTVT?=
 =?iso-2022-jp?B?cGlPMDVmbzNWWm4reFRXc3pYeWpubUZIN2ZDRzB4MGVaL25sUGcrK2F2?=
 =?iso-2022-jp?B?ZG9wV2E0NTE0dzNUbGQ4YjlPYkJIcytnMjdZaU4zR0pnUXdldmUrd25S?=
 =?iso-2022-jp?B?STV1MTF6RXdhTS9Kb09tR0FZd3hOVG5nTy9RTkdDV2U2T3BiaUQxKzhD?=
 =?iso-2022-jp?B?QVNYdjhaeEV0VHlrVHBzSFBFNWU1bkJFUnpXMUNkVGRFZHlqMzdFVDRY?=
 =?iso-2022-jp?B?a0w1K3Jsb1RFZU9KRkh4dFMzRVBCWU9DVkEyZz09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 581f3012-ff5f-479e-8fea-08de5f137840
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2026 08:50:35.8799
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gMQLssxoT9VBvObXCi8l9WIlVKIWEDvCssNC+SN1vDoT9FKhkI1nZYuANtTdu6RVkH6MSPNzJ1bIR2N2SKSybSr25e0pZ8GCCy3DXRrls3A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB15165
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[fujitsu.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[fujitsu.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18592-lists,linux-nfs=lfdr.de];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	DKIM_TRACE(0.00)[fujitsu.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[s.ikarashi@fujitsu.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,fujitsu.com:email,fujitsu.com:dkim,OSZPR01MB7772.jpnprd01.prod.outlook.com:mid]
X-Rspamd-Queue-Id: 82B7CADBD3
X-Rspamd-Action: no action

Signed-off-by: Seiichi Ikarashi <s.ikarashi@fujitsu.com>
---
 systemd/nfs.conf.man | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/systemd/nfs.conf.man b/systemd/nfs.conf.man
index e6a84a97..3875daa5 100644
--- a/systemd/nfs.conf.man
+++ b/systemd/nfs.conf.man
@@ -301,7 +301,7 @@ Recognized values:
=20
 See
 .BR nfsrahead (5)
-for deatils.
+for details.
=20
 .SH FILES
 .I /usr/etc/nfs.conf
--=20
2.47.3

