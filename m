Return-Path: <linux-nfs+bounces-3835-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4412D908DCC
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Jun 2024 16:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8B47287C17
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Jun 2024 14:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E164C85;
	Fri, 14 Jun 2024 14:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="G+R3Hl0r";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dxdK1oLA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BD414A9D
	for <linux-nfs@vger.kernel.org>; Fri, 14 Jun 2024 14:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718376424; cv=fail; b=m75xmK5ul/FNTSRK7spjZRDNa86yhNzh7WTd4NYv0Ustxf5cKepsJhdeTUrMt7t1taavj/Ey+yS+b50c2VeQKCCa6CL9qX05VB+Om9k+co6UE7y9zMNoZYLCyLnkE0I542BOd+0Y36n1F25Vf32R2tuDxHMNXi9f3i/CUhCZYdk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718376424; c=relaxed/simple;
	bh=2E/wTr02QdPu9m2jf1Aq+L4Z053ZHzOWAzEKqwBzh8Y=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=n4xnLOFP/Rhexh1YHMmNXyUWiiAo++m2cD2EBJu2Nv2XZKrw1oPIhJOE+qUyV4O1/u5Vw7wodUW07U6vuVOcwimkvhKfU5rwmQyfZ17E3A9BEGtnxERsfBjQ1iWHVvUoTDud50Pjhw76S07uHp0LQpLAFc0Jykxr+o694OTVppE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=G+R3Hl0r; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dxdK1oLA; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45EDH1bG013790;
	Fri, 14 Jun 2024 14:46:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:content-type:content-id
	:content-transfer-encoding:mime-version; s=corp-2023-11-20; bh=2
	E/wTr02QdPu9m2jf1Aq+L4Z053ZHzOWAzEKqwBzh8Y=; b=G+R3Hl0r3lO02T1qY
	eMyQJLFhirnSjbiP48rMy13aPb2QvXf42PiwKxIayItMdXgkVrGSGzKzir8GhAKl
	BcwRF+f3lc5/GMLTGXpsAaE3omFzG/GQLtOGL0MDAhz9sd7bYntN0rCdpzvjf+z3
	1z5khilWkLeFFOIRdxXA6SsG+VRq9gciKO7opBTYMsSAcAyAu+5dU1Y5AbCdmXft
	uorKBsxBUWhg5w+omauzjPA4TLdMRbQR04mFG3juFepHhD710d+l9koNzf946oOP
	lWf9L71x8BRRhqmTj78nAZu541lSDdZRw32qmRzVVW3FFechJX+Jxyr1aHyISWVU
	z+O5Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ymh7duv0j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Jun 2024 14:46:58 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45EEERTj036767;
	Fri, 14 Jun 2024 14:46:56 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2048.outbound.protection.outlook.com [104.47.70.48])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ynce1t9p4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Jun 2024 14:46:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G6c7EatMiOljjfA1gCtcssl0086RBFpku56tQC2E9rjEG8Uczba9YAD69YlZgct99DUBdyPy9EINH6fCF1fF6jnut8LknEyO/2D/wdAsFVCMM0agIPPOtmVGA3ogeCpUUG/Q5ByAhHSBpsMrXuIR34M8+GJ8iMEAR9x1FksFpqNoN0s4x4/WzptcRZz0+VLifYkmYB+Rb0fFRJPoedHIdOILorJjSmRfsFJo2YhkQmylq0RuLx1Yy6QnbaI/Za9iKNeuytibgjC6WeRo7Cr+SpzUu8gM5XfGe1XRioDx7n0ZSjQTttXcO0mau3Zjed+HDuWKTWLxfCiXf/Im3tTjQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2E/wTr02QdPu9m2jf1Aq+L4Z053ZHzOWAzEKqwBzh8Y=;
 b=jndI5Xe0nBrIqJpOhy0cXnStIS6Fy5AA8QhDBM1JovyJ2QQTO5+R2l2pm7vxnsRBUZJhDDe4tsd6LtNeEx9XpLZKljvHu7O86nNihZ2TW+6R69t6y9qIadGgkSp4/QmLaUUaLTR63CDPOX4dZoCssB9AQ9mlIzA2gn0azf8WlL/bFXRfcFiRxEeRkCZ9t3/2l3FDU6qp0WkZcRLvzitY7dNTIQgQC77OpIHMpdth0zoxAjwhowRsZgRw1H60R0NmiT4JvyMlmTAUA1af0LLjvT6yQvhRcChvt4Izq1fzVuYfC1e6/ldJiQTn92cs/KMgTqpjU2ZOYi9gWvkHg5Jm1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2E/wTr02QdPu9m2jf1Aq+L4Z053ZHzOWAzEKqwBzh8Y=;
 b=dxdK1oLAuroJVrdG2MXyx75sXDE58ezzHSuhdsdXCMK4NCBB292TrbPwk4EsAPXWCTLDkMlqOEDLnX16dkt5GL1DHJO6+ckW/RnFhdoPpFNuT7UmpYHYYkmhuh9q0D6FmlcRjrtPLpRYpzHU7pOrCjlpU8HNUKKoFRMfVnYWtQU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB5971.namprd10.prod.outlook.com (2603:10b6:208:3ed::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.24; Fri, 14 Jun
 2024 14:46:49 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7677.024; Fri, 14 Jun 2024
 14:46:49 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
CC: Christoph Hellwig <hch@infradead.org>
Subject: reservation errors during fstests on pNFS block
Thread-Topic: reservation errors during fstests on pNFS block
Thread-Index: AQHavmmwmYhbjkJRLE+REETskoBGAg==
Date: Fri, 14 Jun 2024 14:46:49 +0000
Message-ID: <34F83726-2A28-4E29-A40E-A01BED7744EC@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|IA1PR10MB5971:EE_
x-ms-office365-filtering-correlation-id: f8cc0c25-28d5-4018-bfbc-08dc8c80d2a4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|366013|376011|1800799021|38070700015;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?3A1mLG7ZYKNVXwuln5qanpmRVyUFWVDhqzpff2itIgDu6oI8ccKb81UBynTg?=
 =?us-ascii?Q?GlbbyROXn9nS7dZFAl69czTa7AA/OiyAXwEIl0cW1Eqb+psnK2Q1ewXZk/Er?=
 =?us-ascii?Q?NgoDGLPamZB2nkWVePpvFToSTIxDyAvuPPEOvlnZoiwdiclLzrwsUw1qa4sC?=
 =?us-ascii?Q?TJKQz2/IeOSq9eCdQfszythqS1nhzTzY2PHH5jqlvQz1/+vHZA3ons5IfmQr?=
 =?us-ascii?Q?5In/55rfQbdJMutpdY71y+xhu2+u8Aa8OPEB+ibbL7P/VsE90yaweskwpCbF?=
 =?us-ascii?Q?qGCst/oChsIEn3RCEQqW0o8kJUiRBWWB1NsACofOD9l21KiYvaSY3fvebcML?=
 =?us-ascii?Q?OQJICBzfcgIwDrp4V+peZoImKAaX2rj4PnUOUqliGmt5yyF0GT5f4f3rs+qh?=
 =?us-ascii?Q?KL4b15FSqb+4W6uGhGRug48A1GLSIkXa2I3drPOAPBEXJN7O9DJtpBcDu068?=
 =?us-ascii?Q?ybgF5CnCJVl5m0KvghtVusKqdnrRB4jA3y8etfJYkXIhyI4xo3/Vi3il08fU?=
 =?us-ascii?Q?oXyBcvPvBf6BmkjLFedc/08rATzgnOjjT0cN4BhPyRVFHZwDVUhAD+1AIQzO?=
 =?us-ascii?Q?3pSDU+D5b4dhonaK6Q2izCnhKX6AwrapCWSNSgb8AqbHq+2mHrZbZENVPR4q?=
 =?us-ascii?Q?JZp8ajw4IzU6hS5BfyOXN5NTpQ+N8ctoSmSKrlkgg9loxeksXtm0oZtyVjDP?=
 =?us-ascii?Q?cLytnQg1bJpuitPh3w+fkwzZSiUr+1fTG0vZIHsce0r8vNNnQHNzaB9JYgJM?=
 =?us-ascii?Q?0+zPv12d63Vvghyeo3V4NYW8Jvazix9p3vMNcbVivDf18n6PvsdbfFf85D8n?=
 =?us-ascii?Q?BbubYIc5/Bu+oZHuWHR8IzLxINF2cltW0iCncPRZ4XOMqkBkWRnvlNQe3Rv/?=
 =?us-ascii?Q?bDRkhViOgg4MBXFOiqm2FUPz6+MAuBoTqe6kWPGHJ0JfYk+HyJ0byaOkQRZ5?=
 =?us-ascii?Q?sWGCf3d/3DMh/7ueZxzjxZNA4+ItopIp5EUObB0/qe2rRj8D/xviPgjcdHA2?=
 =?us-ascii?Q?OloZ8k+qqardC7wh8b1/vKquocg1rdSp4190qCG+peCmGCUdvyhZI04eLiOe?=
 =?us-ascii?Q?uEIMinUQQHMBlu48K2YX0W5DbEsRGPux9hpzkgxrfHvVOzn4HJf3mLbgb8ak?=
 =?us-ascii?Q?fQ+g7Eojh/067GfO6UqkJ0Qg6jWSVhI+OFTJEz4LUS5ZaQemfwAcIQ/RgD4T?=
 =?us-ascii?Q?MfOmq6nVFUvk6/HPhpdG3eknnBxNf1JAEMlt0cQ+X6YvUgOq4YN8dAHqyQhn?=
 =?us-ascii?Q?Pn6+14SihfNJL1TKtDZdYAMfQ3lla76ne0mXEUsXnSxYtnqcQhiPgGac3f2h?=
 =?us-ascii?Q?EEHzKVXMuo4YDSUKcHk9iExeL4OEo+4c4ls8aT9vnSbFExyeNHd9bmoYohpo?=
 =?us-ascii?Q?PmXbRFA=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?vhEVPJou1W18vNa3CGg3AueZ2b0ZFqBLDL0teuoX60xhbxClNKKuKjt5ONk6?=
 =?us-ascii?Q?8VsHDmHSjsJCOymUh2EXIG0ymzYra5zwxGYGTtWhWAl7NK4UhRtBuCeIaUlN?=
 =?us-ascii?Q?WgZIadqDluLRc5VHxRPQuUbyYPwGnGDWpey37TSXhd1iaef2cXCLFcYk5awZ?=
 =?us-ascii?Q?+6dbPYTSHazS0brg947d+ZVEvfZO20g5xLTE7teTNXZF9E9mmvAgJ3GjE+RU?=
 =?us-ascii?Q?YWMVsLiLO6PYfv0Tufpg9Jt0fQAgI1z3F60ayLloUTWswrfamg8eh4vI1+RK?=
 =?us-ascii?Q?ukK9TDHvv5GycM6TOS+L1+auUaYaXpRj4rhCQIlZmtENVlkXzqD/4Fx/7N1U?=
 =?us-ascii?Q?d74TTp7wCBPbAcyHhaa2j/ykRejyRMcGiuEXf2qU2AoleVq2zU8tk7FZj+Di?=
 =?us-ascii?Q?bATplvTDXBbb6XiLc37NmGQ7Y/S5Q3MZ1ZBQhn7NZUONMCu51Ca51AYjlg41?=
 =?us-ascii?Q?eqlIul/S0hYiMCv/C84iZOzwgTdZi4OXKrXygS5LfeVK9tNvWQhVm5M+7WJl?=
 =?us-ascii?Q?vH4YQxELe4Om10HKyjmgZEnjElWxgy7txQUk4MOskmvQqftxl4Rz71NNHc1C?=
 =?us-ascii?Q?L5Z7Y8S7sJsSRPl/V3EMwS1vJcdWK2xDX4ZOeDr6eWKXrVaspqwUv7/6Qimx?=
 =?us-ascii?Q?A12qotUS/WogTkcYpzPc9zJlcctNJ8NQtMs+CYACEXgL0HXYv2xxGtUtJnN1?=
 =?us-ascii?Q?g0Gep0daF+RnrezDiRSKZMeaotu70CEx3WCpIaGE1cazuC45dza1BhgmyCtc?=
 =?us-ascii?Q?dcCjjx7Ohhjd7WV5D7AnHpeiQwnC3WFypGsGZfVRSdSsb7DUBSGE/anTv/b5?=
 =?us-ascii?Q?XvgvtNM9W8ZY5y9F8BkWxPMhd4LHceq5JLUrBww+cE8lb3LnvYjgR7Z1UhRG?=
 =?us-ascii?Q?/mmQe5I67S1+0Yb/ZxpN0ZRgZbwwtcdErKEA2jfsEOQPLg8TetKmuT1rV+Hn?=
 =?us-ascii?Q?ukgSmy9vV/EQFek0TVpiKvhsUKr3vprYZ5koe6MBLworD6cCL0ggkxR2u7vz?=
 =?us-ascii?Q?JfsgiKzDhVsjcOF2WJMQaZWycnvp3oOQpnCcy+2tgu+Y10J3Cxilid8pW4y3?=
 =?us-ascii?Q?22WGSofE00m/vQ7cMAAwVehxgo5K1fQ3YXTn/Zii8CCWQ5xgcB5GkOjOc9ZS?=
 =?us-ascii?Q?L3Hadl06Tuj1t4ABcF4dCWS/Csx9Ig8e8E276B3RxeD56xe0cyHl/GdQE1RX?=
 =?us-ascii?Q?ulONlFTLV/ctxsjHh8Eb3pHJGMTTaD+nEXOjhOrr1sKmDLczNdhGtMKW29BL?=
 =?us-ascii?Q?2WpErvvWHrDg/OPER6o4VaKYDFKK+s1rLpoI57crZyQsOWIBb9KMYYTRJxgD?=
 =?us-ascii?Q?UFKVgzlWbh1UApcxfE7+FzWvCpxRukkrky6GZYmhcxWHGPf8W7HOU2tIZBCD?=
 =?us-ascii?Q?+4ZZ+dm8sd94K8cmJ7q4dgtBPkz2nj/Ecu8zYd0DSt7+eMsox4miXnd5Rnq4?=
 =?us-ascii?Q?mMC0DtiwhXngoiBpliAOtOOT2JcHDNQjvfQobK93cg/bt+fNrVbnH2+B7sno?=
 =?us-ascii?Q?73t980v27+jYYwZ+4OkdpdkH9n44uDz/MpK5eK0hnqMvTHGvg4pyK+tNSxtP?=
 =?us-ascii?Q?Cf07XBC6ESqaSIuMJz3ulKbPadrxcHCgNszK+YQCapdgeXPNt8+Ttf/Bw8/l?=
 =?us-ascii?Q?Vw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BB9D765C9680D547ADC0811C2F5FF64D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	bpDWdTFRDmg3STLE+StuN0YxgTfy79GL709F5ixksti2CHsu9FDN7ayUqX0fd3R3T2he2L5ySu6bPm9rJVyESbZoZPsXwNFSb17ZBktb+2OF8ldf33pmuboSwoMr8SFXmq8sY+bb7dFB5rSywWspwmB9dMfqjkpkjQkrK/KrLYf2Nl7NrcLajj9gVjBcNiKrAiWT/4QiHq1/pt6YfPg1tGawe11XWQvjjYN20ClsBvGQbIXufOXX8qNPoNRRGCOtPXOnUyNOLdoTI269F+73iQ/KG0eGUn887KMTLkbsTPbJHtUk8OE8zNTCP826OJF09l3FVCn9+Y+VMzPjY5jrZqK/JHQAdEAlRi/F7mgrEUVelEVfOgmpwR5iE76dzplPgW2o1+YtWMSQU3YBWUnjRfS0fvkSH6TvTSE4utqir9tWELq1AGDk7BPq9YTfo6TpQyUs9SaymVa9DpnrjL0+O5Jji/a6iqZoGjdUUOUdkYH6iGRHEgEY75yzeTRX3aRh0hagFnLUNKUskhHRyHkr9flKhcrbCQPezeokwjsxnmjOiceRrTYW/qSKCF0ZiOTrk/jRK918qFIq34IVOZ4r3VPk1pgTmdXmR/HAHd4sYpE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8cc0c25-28d5-4018-bfbc-08dc8c80d2a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2024 14:46:49.7432
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5appHouCzGkuk4/iDncIeg0uREDgeHTsqZinh/FFIjtFphj3hs0SljuWHmQzwSb3+unsPGbpxJIKRtFUaeM8yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5971
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-14_13,2024-06-14_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 adultscore=0
 mlxscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406140098
X-Proofpoint-GUID: XRsoVjexJQsBZrTI5Fy1YszRuy8UtRkn
X-Proofpoint-ORIG-GUID: XRsoVjexJQsBZrTI5Fy1YszRuy8UtRkn

I've finally gotten kdevops and pNFS block to the point where
it can run fstests smoothly with an iSCSI target. I'm seeing
error messages on occasion in the system journal. This set is
from generic/069:

unknown: run fstests generic/069 at 2024-06-14 09:21:08
systemd[1]: Started fstests-generic-069.scope - /usr/bin/bash -c test -w /p=
roc/self/oom_score_adj && echo 250 > /proc/self/oom_score_adj; exec ./tests=
/generic/069.
nfsrahead[34274]: setting /media/scratch readahead to 128
systemd[1]: media-scratch.mount: Deactivated successfully.
nfsrahead[34284]: setting /media/scratch readahead to 128
kernel: pNFS: failed to open device /dev/disk/by-id/dm-uuid-mpath-0x6001405=
e3366f045b7949eb8e4540b51 (-2)
kernel: pNFS: using block device sdb (reservation key 0x666b60901e7b26b3)
kernel: pNFS: failed to open device /dev/disk/by-id/dm-uuid-mpath-0x6001405=
e3366f045b7949eb8e4540b51 (-2)
kernel: pNFS: using block device sdb (reservation key 0x666b60901e7b26b3)
kernel: sd 6:0:0:1: reservation conflict
kernel: sd 6:0:0:1: [sdb] tag#16 FAILED Result: hostbyte=3DDID_OK driverbyt=
e=3DDRIVER_OK cmd_age=3D0s
kernel: sd 6:0:0:1: [sdb] tag#16 CDB: Write(10) 2a 00 00 00 00 50 00 00 08 =
00
kernel: reservation conflict error, dev sdb, sector 80 op 0x1:(WRITE) flags=
 0x0 phys_seg 1 prio class 2
kernel: sd 6:0:0:1: reservation conflict
kernel: sd 6:0:0:1: reservation conflict
kernel: sd 6:0:0:1: [sdb] tag#18 FAILED Result: hostbyte=3DDID_OK driverbyt=
e=3DDRIVER_OK cmd_age=3D0s
kernel: sd 6:0:0:1: [sdb] tag#17 FAILED Result: hostbyte=3DDID_OK driverbyt=
e=3DDRIVER_OK cmd_age=3D0s
kernel: sd 6:0:0:1: [sdb] tag#18 CDB: Write(10) 2a 00 00 00 00 60 00 00 08 =
00
kernel: sd 6:0:0:1: [sdb] tag#17 CDB: Write(10) 2a 00 00 00 00 58 00 00 08 =
00
kernel: reservation conflict error, dev sdb, sector 96 op 0x1:(WRITE) flags=
 0x0 phys_seg 1 prio class 0
kernel: reservation conflict error, dev sdb, sector 88 op 0x1:(WRITE) flags=
 0x0 phys_seg 1 prio class 0
systemd[1]: fstests-generic-069.scope: Deactivated successfully.
systemd[1]: fstests-generic-069.scope: Consumed 5.092s CPU time.
systemd[1]: media-test.mount: Deactivated successfully.
systemd[1]: media-scratch.mount: Deactivated successfully.
kernel: sd 6:0:0:1: reservation conflict
kernel: failed to unregister PR key.

But note that generic/069 is recorded as passing without error.

I'm about to start digging into this. Any advice or guidance
is welcome.

--
Chuck Lever



