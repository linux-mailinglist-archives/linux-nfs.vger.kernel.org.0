Return-Path: <linux-nfs+bounces-8860-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 058089FF32C
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Jan 2025 07:54:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF25918826B7
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Jan 2025 06:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F061A296;
	Wed,  1 Jan 2025 06:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="u+wC6ozC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com [148.163.133.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3828510A1F
	for <linux-nfs@vger.kernel.org>; Wed,  1 Jan 2025 06:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.133.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735714489; cv=fail; b=Tp1i4Vlxhbv3F7OtL9b98dGQdz+AKErkgB9YOrGt0oA5IlFeOnTDrh9ea7pfrUrfbQJb+OnNHnZSfSwLAsqhQPB86JRbt4EyQum8nMpQsTM/g3ETn3blteaWSxBkmkFU6RiIAYkfzwISGSjCrBA+d6f232aAZE1ZbXFqu04IUrE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735714489; c=relaxed/simple;
	bh=qZJq8Eef0P1Pqb/Zsx59PVDliWxUJGJMo17tD/FZlQM=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=tooI4nwwW97rWJSv8xaB1YRVZtJELE6NE1WmQf7qQjlx/zfrhjNzl+bnHpfAA5Hrg3FXwUAuvfMhVIA2vMCT6dOE5pea7u40VTpUwTMEois0XNlCBxIc8J0q0R6qJQnH6U+bVLiay9f+jv698sMqe07ysP06OWfoHx7kya/ddaU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com; spf=pass smtp.mailfrom=dell.com; dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b=u+wC6ozC; arc=fail smtp.client-ip=148.163.133.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dell.com
Received: from pps.filterd (m0170393.ppops.net [127.0.0.1])
	by mx0a-00154904.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5015oCgm031979;
	Wed, 1 Jan 2025 01:28:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=smtpout1; bh=qZJq8Eef0P1Pqb/Zsx59PVD
	liWxUJGJMo17tD/FZlQM=; b=u+wC6ozC+cM2FsLLL176gCmMDnFiW8Zr9qBSq1R
	U8/vVPYSTH3Ek4fqnR1uDlPn9iIhjLm8Fs20NSBjJ6xdPB4SSozGooFpy7kKYcDs
	TN7sLgSdBC+bj+KZkcRVTKxIPQCNoZZ3W6txwo7SnMdzmOXmoqIQX6ZULyDqcXLR
	ZvlxjXtOkaj29poBnHB7Ot0led1RimF2DHPz2W7JwDr4R5CUhne6+QF8oCWi/pXJ
	oNHMw9s4oNvRS8cHOV/wg1MDxX4tsMf0rOqCpPnmMQFkNbtebuFhpjHLoOGYCcg5
	sej9ar2sU8GargRfJKbd95uxhT0DXsNc6VdUzwMdEMsIFNg==
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
	by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 43va9hvwbn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jan 2025 01:28:20 -0500 (EST)
Received: from pps.filterd (m0134746.ppops.net [127.0.0.1])
	by mx0a-00154901.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50143Ufr000994;
	Wed, 1 Jan 2025 01:28:19 -0500
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
	by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 43vmf8dkeg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 01 Jan 2025 01:28:19 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WWrA2betLO5lib3xLorysSbAa9hqmomS02Hs+pTXixr79gKk4TkOGWp9osnS1hsWAL1V6jxJoaaiyg1zyjhGEmtK3C60cDdxTr/lOOcT5drLLijU9TCYezmMPB4fFdRs+6yBjrMo3bS1ebbGTL7r5HW7xgPdZptB6VUm1ItKcv0wq8vApaGCaPoQB4yTCD0pzj2GhAQcVh83ykbJVt+kMY62TopF/Hs7q0DZBeDzRW+CPHhhh3zewPcve3ESo0hKKruZj0nJDzRH2XJQTf4vhR9okm+K6i4RlSwB6eJ0xnHOk5ekGUIrL5fGKvnLrNhlOHvPm/JO/v0MTJjLCAF9Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qZJq8Eef0P1Pqb/Zsx59PVDliWxUJGJMo17tD/FZlQM=;
 b=r07IFu5WDeEnBDbrb+sLBz6JNwm3hKDK3M0f+kzlg3RLyzw6l85SM/OkpiZqhk4A3I0BUFhPa2BLiX5OUuv6RabnnXwbeB4qv8hIQrIINiGmd4o0XnQRZ0puWKO/5srYBK4w4hHM539yjIvQHZrPD0/u5g8EUJk1bsZZyh+JJu63GHDFc8yW3IODR6CdpFDlvFCuw1tzdtEgrW/2gyGc+XJTVjuJnZtMRGfHZvff0w/BKWYUMwAYA/4b+pNy0owwtUEQme9EaQQxT4e6nF8YnkR/0igJJJQma+mG66vjq1bMtSjoqIwoCNscv0AbO7Qsoo36DjdQnYB1o8O+dexykQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from MW4PR19MB7103.namprd19.prod.outlook.com (2603:10b6:303:22c::20)
 by MW4PR19MB7031.namprd19.prod.outlook.com (2603:10b6:303:228::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.19; Wed, 1 Jan
 2025 06:28:12 +0000
Received: from MW4PR19MB7103.namprd19.prod.outlook.com
 ([fe80::7ef:eec8:9bce:990d]) by MW4PR19MB7103.namprd19.prod.outlook.com
 ([fe80::7ef:eec8:9bce:990d%4]) with mapi id 15.20.8314.012; Wed, 1 Jan 2025
 06:28:12 +0000
From: "Gaikwad, Shubham" <Shubham.Gaikwad1@dell.com>
To: "bfields@fieldses.org" <bfields@fieldses.org>
CC: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "Godbole, Ajey"
	<Ajey.Godbole@dell.com>
Subject: Clarification on PyNFS Test Case Behavior for st_lookupp.testLink in
 Versions 4.0 and 4.1
Thread-Topic: Clarification on PyNFS Test Case Behavior for
 st_lookupp.testLink in Versions 4.0 and 4.1
Thread-Index: AdtcFL06/eNq/jyGQD2UjcrUFgrwSw==
Date: Wed, 1 Jan 2025 06:28:12 +0000
Message-ID:
 <MW4PR19MB7103BADC7FC3CBC1B2B8FAA5C40B2@MW4PR19MB7103.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_ActionId=bb6b1581-1f51-4b09-8288-ee0cc2bf9f19;MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_ContentBits=0;MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Enabled=true;MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Method=Privileged;MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Name=Public
 No Visual
 Label;MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_SetDate=2025-01-01T06:27:21Z;MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR19MB7103:EE_|MW4PR19MB7031:EE_
x-ms-office365-filtering-correlation-id: 61548622-a087-4dd6-1700-08dd2a2d77c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?hlelo0ET5jM+m1oteTsUw/rgIgK8Im9xn7TWpTb/eg/pZ9G95TNNV2oSNbca?=
 =?us-ascii?Q?KXq3w4rKXNvNRAs+jGY3XJUytRzE5wd+Z6Vekbj987NsANd6jEOLgUqcwZyg?=
 =?us-ascii?Q?G+GeHo4nEGg15T4RjwnwEBr8fQ5rQQuubGUb3J5+f+LU4WFvm1D9O8IWMvXE?=
 =?us-ascii?Q?FusYfw9XgjRpISrElJ7zL35+haTmJhbS5ftW/D/ouFwTrZJKgRbDWt4UQeYb?=
 =?us-ascii?Q?1mBxZ8jM5XECf4CVwXZMr0gfl16GP+BTpBr1qP8soY8H72JRbDrUj3QdGJgq?=
 =?us-ascii?Q?0KZNCQTLh/zauZ8mkKpSa7qdOlfTwFMHjTbEB2GHFZ3fP7ds+/kQHuLJ5flc?=
 =?us-ascii?Q?p2KEkCMovU6s4r34hnf3a7E/9ZTZ8O5sJhqLjWm+iH5Pje9Q22+LaR6+IJsV?=
 =?us-ascii?Q?+nrEZ6EDjFWL1UCqH+xsOEJ7eLc/g5J55b+5NmBIk/cPN1eFzSYt4o32c6I9?=
 =?us-ascii?Q?3i/0eA+JQNswHgJX5mIL9YNzc5ZMYsVSWnU3XxJvOxg+M27LELfeoJKljehb?=
 =?us-ascii?Q?OJGM+VwIoTllTc42RGNUYkQyTXE374JB+vKAWNZCjNinSz2iXROBxBb4EQjh?=
 =?us-ascii?Q?QnFWMRAY0joZp05dB93YdeXljNGenzPYSp1pqQBPmp8iE0DVjNFKnt3ZYkA4?=
 =?us-ascii?Q?2X5v9HwxxourWdp91OkE6kyhPTu8QHYNt3JI+BMViJWm1xLoCRXrBA/VXJBA?=
 =?us-ascii?Q?lCTwpVWTJRX/xQRvMz21iQgaz14h8E+FRR74ha40zx2vwtr7RK5l4VXSKneu?=
 =?us-ascii?Q?WxyIbAWnxRQxeGDayFgF6ll9M/z+Hpij1mQicv9Cwr04PYncFWzKbTqEOKtS?=
 =?us-ascii?Q?pN0NuMnOS2660VusoBy9KpR6oyc75eZLhKMoIpVsfjgMs1lUVvmuqi75jQvi?=
 =?us-ascii?Q?sO7+UyP1A8qqmCg2VLijsKTQQX4fBS0owG100fkdz4pziRNP4Voemb1EiXim?=
 =?us-ascii?Q?YSLwYC/X7J2Gusz8hrmSkfQWspii4h3+z9MY4qmAc+jOLD5IaZke42xly1RG?=
 =?us-ascii?Q?JI4HiBIo++208gRsakaTjFe57lvSFG3yxzWpI0Cg2LzCTJvf75mtq35Pm4HA?=
 =?us-ascii?Q?RQLTAvR/Zs1iSZnflX4GAPBmP38UJJQLvQ4kQiEpT9DKBIW/T1kne3433IlJ?=
 =?us-ascii?Q?eNmBz3278OJGSRdjVoxH12t/jTfDk6bfrKs+K/j/CO/gf2+KZOURLLh2GZbg?=
 =?us-ascii?Q?Yac1inTqXadvwKHNlXHxayENy5sZ0pCkHLSPWaXmaeaQIx0G/Jikx/ZgCecP?=
 =?us-ascii?Q?vyS8jwjdMuaW3uPOghwoXJq0X8g3R0aqETZ66ecdnrOEqvMnNsC0YCOJyOo7?=
 =?us-ascii?Q?a7f1h1lEabWJEXV02CrhwvcYlRAW58iV/tcwykMUZARHnWGCOiZH4YyjeRFw?=
 =?us-ascii?Q?GjE67c1IfYHvsF8QgJYKrsODjmRYKtKR873FWdoZ3RtdXMYXlQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR19MB7103.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?HmlQQOk2WLA28opd/7PAmG6S/DrSrxhGBwPP6NwB1+g5fIaA1j6FmKHLwhwk?=
 =?us-ascii?Q?tjS6Pv7EDjVOJqqly6tW9MH0/55f+L6kkC3VGKerOH0s4dNGajcI+k2GhYeQ?=
 =?us-ascii?Q?fZPHZecN5QOGVZhAWMUIJYZP/GZUA1zWnSrHdrQEKzTzlJEaYVP+ThzSHSWk?=
 =?us-ascii?Q?DqZDw0cx7vCkQIqAQuBtFOl6wCPUslHQAS9l4QECO/le0lzu4nv+Cc6XMhKM?=
 =?us-ascii?Q?RnjlbZPMSpIPrWGbmsXoQiqJ9M0iVvRURoaun+P8LCGd6iC29hyK8oIAeYZ8?=
 =?us-ascii?Q?w+B+DtRXNtphqshAVry9gggahSmV+vQJ9IdknP3RPgyEaW2bCpNPAo8gW7T7?=
 =?us-ascii?Q?Z3ti5MBhmjfp3ZOAPyLpHteiDtriRdbAEHnskWUWv3wZfAMg2f/T4/mCGNAG?=
 =?us-ascii?Q?EJvw0jJOvh7Um3RFhNqvIamqN7CmN66MYyjLnu9JQswe66RsNws351vfMZkV?=
 =?us-ascii?Q?D5nB47uCWlmTzQJWS21nrdIsFUT35EVierJtGGkbEdsWl32TfgTGPEuwthw+?=
 =?us-ascii?Q?LD5Tlf4s0Ao8fuUPsDGhVupkf1r1IpSrqk+kOJdqDJa/G+UQp+R4VJbjy57O?=
 =?us-ascii?Q?HCZu+LPcPpPu+Re8kFZZxDCie9Yr3fCORi/ughRj1u0PDveQruLUQ2k8gJng?=
 =?us-ascii?Q?vb4ast8HOVMirazpjHIev0EAh1GkHG/tELnidrgf5f/SgiMSPyaffi3b+xv+?=
 =?us-ascii?Q?xvo+qrjFriNMGr8Nzy5gazBjbgQYigFRxmd+a45HoST0lhIcH0sqEoRzuFIo?=
 =?us-ascii?Q?bO6xijwF9JtmRXyBS/ahE1CJ6mxqxcaE139f5UvqLC5EeQVkEkA1e2hLyXFa?=
 =?us-ascii?Q?onXPIHF4unMOvpfiZXQqPfZWaFZpZEJ5+1kWr87BfDGJAjDHqgRxS/z9T9GT?=
 =?us-ascii?Q?KgYKQuIc+p+zjMr2PF2EfMJ3AAlmvVJ0BvuG+b6ir400topRRw/7EPBA5rze?=
 =?us-ascii?Q?wQe3JzOkUWpPFSWyXCoOh435x4aFTyn1iFEile19etUVH0J81rA15D15C7ry?=
 =?us-ascii?Q?h6iNSJlsHI50rKYZo+BIhor9sRZBMxK+T0VkWh2X1GZfFzosauYJ4BK3QuGp?=
 =?us-ascii?Q?+C3NCq6jzhmfebuBHQdJlmoGU6cgHR/dTzWBPrqudRHsXPbhLFmuKFNETvRF?=
 =?us-ascii?Q?c8lwqgImmpITDN19E616J4ZLKz8P9FYgKj03JNGQcxju5IMdDWsVLUKYTj3p?=
 =?us-ascii?Q?tvouqOWZ9Dt6DzVCocRlQQ/dI1rEmVcgMiINem53hmuzoeXrxP5YdZItpsGZ?=
 =?us-ascii?Q?sAKAm9rOQ/ewSyWX8uTb9Da1MjbnnCwkgFNRXOeOURWTVM3O1QjFZ0GMRs5i?=
 =?us-ascii?Q?6qXs7uVEwLCzxX2823dMwlDVShhJMOVdK3ra5mrpS7fBc0KcEXKIIyB655Ay?=
 =?us-ascii?Q?GOTu9GwEQLZvRiOsrLkKDGE020/AP2/NRFc2cQ/VddlnJsTsDjjEovcrnvnA?=
 =?us-ascii?Q?YPzS9NW4U/KURgirugWPZUxHGNTp7pZj4OC+Dlqf3569W3DHWUm0vPRjNClU?=
 =?us-ascii?Q?pvOdMXSa+cAo2LHvz7mH99G6KKBhwsb/CDJYmCWOBKGvMC4cUMV4JRfqCzWc?=
 =?us-ascii?Q?bFp1DxiMgoYpDLEcbQkRvGZBgZvwILpyhoShkQ6I?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR19MB7103.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61548622-a087-4dd6-1700-08dd2a2d77c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jan 2025 06:28:12.7109
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qvvCIra6kRBp3resT898fClAoLn/xp8Ptdv5CRBXAurXETBtWqRPhNu8zQzgeHJxxYPVniGK9UAbKcsC7yAd26pcbFhPAvDGp8K69ecqUXA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR19MB7031
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-27_02,2024-09-26_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 mlxlogscore=999
 bulkscore=0 priorityscore=1501 adultscore=0 clxscore=1015 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501010053
X-Proofpoint-ORIG-GUID: E3D1gaJrVzGLQTQ1uNJeNiczcVPfp0s0
X-Proofpoint-GUID: E3D1gaJrVzGLQTQ1uNJeNiczcVPfp0s0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 clxscore=1015 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501010054

Hi Bruce/PyNFS team,
I hope this email finds you well.

I am reaching out to seek clarification regarding the PyNFS test case 'st_l=
ookupp.testLink' (flag: lookupp, code: LOOKP2a/LKPP1a) included in the PyNF=
S test suite for v4.0 and v4.1. Specifically, I would like to understand th=
e expected behavior relating to the error codes for this test case.

In the PyNFS test suite for v4.0, the test case LOOKP2a (located at nfs4.0/=
servertests/st_lookupp.py::testLink) initially checked for the error code N=
FS4ERR_NOTDIR. Subsequently, an update was made to this test case to also e=
xpect NFS4ERR_SYMLINK in addition to NFS4ERR_NOTDIR [reference: git.linux-n=
fs.org Git - bfields/pynfs.git/commitdiff]. However, in the PyNFS test suit=
e for v4.1, the corresponding test case LKPP1a (located at nfs4.1/server41t=
ests/st_lookupp.py::testLink) continues to check only for NFS4ERR_SYMLINK a=
s the expected error code.

Given the discrepancy, should the test case for v4.1 (LKPP1a) be updated to=
 also check for NFS4ERR_NOTDIR, similar to the modification made for the v4=
.0 test case (LOOKP2a)? Additionally, while the RFC 8881 section on the loo=
kupp operation [reference: Section 18.14: Operation 16: LOOKUPP - Lookup Pa=
rent Directory] does not explicitly mention the error code NFS4ERR_SYMLINK,=
 it is noted in Sections 15.2 [reference: Operations and Their Valid Errors=
] and section 15.4 [reference: Errors and the Operations That Use Them]. Th=
erefore, would it be reasonable to update the test case LKPP1a to allow bot=
h NFS4ERR_SYMLINK and NFS4ERR_NOTDIR as valid error codes, ensuring the tes=
t case passes if either error code is received from the server?

Your insight on this matter would be greatly appreciated.

References:
1. git.linux-nfs.org Git - bfields/pynfs.git/commitdiff -- https://git.linu=
x-nfs.org/?p=3Dbfields/pynfs.git;a=3Dcommitdiff;h=3D6044afcc8ab7deea1beb77b=
e53956fc36713a5b3;hp=3D19e4c878f8538881af2b6e83672fb94d785aea33
2. Section 18.14: Operation 16: LOOKUPP - Lookup Parent Directory -- https:=
//www.rfc-editor.org/rfc/rfc8881.html#name-operation-16-lookupp-lookup
3. Operations and Their Valid Errors -- https://www.rfc-editor.org/rfc/rfc8=
881.html#name-operations-and-their-valid-
4. Errors and the Operations That Use Them -- https://www.rfc-editor.org/rf=
c/rfc8881.html#name-errors-and-the-operations-t

Best regards,
Shubham Gaikwad


