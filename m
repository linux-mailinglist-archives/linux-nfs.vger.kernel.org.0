Return-Path: <linux-nfs+bounces-17904-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B42DAD242C7
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Jan 2026 12:28:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 77A49300E7A2
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Jan 2026 11:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB1036215E;
	Thu, 15 Jan 2026 11:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="YzF8PGWa"
X-Original-To: linux-nfs@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011054.outbound.protection.outlook.com [52.101.125.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8763F378D97
	for <linux-nfs@vger.kernel.org>; Thu, 15 Jan 2026 11:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768476532; cv=fail; b=a8Ma1DbgN0KxklsIfk5wjr0T4/ZCJwjKkIGKrFkeU7hBXsqFC9hdF1IdcwpMNrFM6LAkSwbY5Ku2NFepuFf4tmV+UqWtMaCWsYYj3f5CC2EDKFvW+9H8yHEKPvIMlcl0wUiqd5SURbs8vTAxrqxb7pFvYsvc2+ngv34IpxI6G2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768476532; c=relaxed/simple;
	bh=onu0Rl86bKmbf8JfCHjcOpdGJj8NegoltW4uJk66GJw=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=q3BZ9osnwp2tvW+AMxo45YmTk2ztJ11xVOY2ZkHjxDNXWai8QNO4VMgW40wTP2xhElnh2m8kP8/81sj+ACkSXnquN1lrk3cGbpYUhMRzTkEDRlwjZWB+lx7MytdKNFkMKtm/MlnzMued6CYNN8o4SjbMj0zndmxsVv37N3/WFpE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=YzF8PGWa; arc=fail smtp.client-ip=52.101.125.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tjMgXeSnRfHlAENPiqujBnFjFJvNZR6YK2GgBkEkKZFUK1+rSMdQvulHsfkW5NDeutOSivu9RvQIzAAIT/7iiXfsDGMn8/dpfVFnc1Igf5yWUt/avLd5Suhn/mnmrP8+bkThtxBhDruHtqZu1ncXcy3WQYM2RJpWd8d/+Yu2VvrKJzWFElS6fLNVmn6OXhnSASK7Fw6XzQVC8fPmZc9j7Wz1EMjsRRKbCDkdUs7LkF+K/kegrvGieNoKlpvV6q1RWvxMUEr+gkVRCm6egD7qKZSVc22JS3K+YxQYO3wgYH3u/a+6mEo6fA/pzRXPZoqpE86CyVUUREhJJ/s4EYpYKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=heID8AUoCmFBF7r1MS/XmDS4dY9K9qaS2DnO5MFbKAM=;
 b=iETkagEyFpzR+5xtmkkbRNA21G0z5GNQckUMwh5X7jxPbyfxlbI1lc5FKE5XkjDk3TRmSIzkF1Bc7L33cQzuYPj7KXf8ytJl4KR9yUV+qyaghzxGblPUJzIms3XXcIZvcVmzklCXxN45T/cyvucApvUV/ZzrRbPc8PQBc0RTOLtMKiJgBpPzmCl7f06BUavvDKLrPqcj6z91AORIPvNWk/oy8cs53Z8nN27j3fJHUGQUe9kbGra9oIhDlleiv4a3nSnaz4j5I01Z09bOwS+LGI/p5BW2A8ZEWmH6FkRztX7apo0kXw5pnMdyCEbZMsl6/nLM29c56kVIGrtgnggLtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=heID8AUoCmFBF7r1MS/XmDS4dY9K9qaS2DnO5MFbKAM=;
 b=YzF8PGWa6mlr6EAjpN0imHXK3M3i3UEXS5QJZl5Qp2cazuEVCETOxh5MEt4YfQS8/nB1OxQtBfroVR5yL1TtntF7c9MFQ2A7IdICxnbcFprAoXSMhfyO4hQ6rpLpr9Ub8oyhjBbfY8A1+F4EvLwewL4TlJoTnpzkLRpZAJftphrJ00R+o680wWZsx4o3f+6raTKxbbaExvDQU2v+MENk+Qbdo8b3Vmxe2Y6ArvvlViy2M8o/HaOGvEdrnVqty9AxGN6dAtLo8vixMUqaMO9SK67VdMf5TnS5wk2Jj7/JJevNu2uh3Vy2MqBRjjy+f5q4AtxXu0QEHjdW+o3Zf/kULw==
Received: from OSZPR01MB7772.jpnprd01.prod.outlook.com (2603:1096:604:1b4::7)
 by OS3PR01MB8285.jpnprd01.prod.outlook.com (2603:1096:604:1a0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Thu, 15 Jan
 2026 11:28:48 +0000
Received: from OSZPR01MB7772.jpnprd01.prod.outlook.com
 ([fe80::5956:959c:6018:183a]) by OSZPR01MB7772.jpnprd01.prod.outlook.com
 ([fe80::5956:959c:6018:183a%6]) with mapi id 15.20.9520.005; Thu, 15 Jan 2026
 11:28:48 +0000
From: "Seiichi Ikarashi (Fujitsu)" <s.ikarashi@fujitsu.com>
To: "'linux-nfs@vger.kernel.org'" <linux-nfs@vger.kernel.org>
Subject: [PATCH] nfs-utils: fix typos in comments, man pages, and a message
Thread-Topic: [PATCH] nfs-utils: fix typos in comments, man pages, and a
 message
Thread-Index: AdyGEeX56N0/EKyzQkujAH+UFcwaQQ==
Date: Thu, 15 Jan 2026 11:28:48 +0000
Message-ID:
 <OSZPR01MB7772EEED7AED473150DF6758888CA@OSZPR01MB7772.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=92979508-35e6-4501-986c-20800d2bf147;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2026-01-15T11:22:59Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB7772:EE_|OS3PR01MB8285:EE_
x-ms-office365-filtering-correlation-id: cffdac76-645f-434f-fec3-08de54294037
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|7142099003|38070700021|1580799027;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?ZVVLMzJCanRnMWJPMGcvTlpoZzZQQXQ3WVFFRDM4dHk5VlZqbzMzejJ0?=
 =?iso-2022-jp?B?MExUNnNrcnFwbUlEOUp0Y2FCMWl3b0ppcVd2UXlxWUVLVXZNK2NmRjM2?=
 =?iso-2022-jp?B?a1VxY1hHaU5HeGhnWlJpTmxvajI2SHQ3SDZFalhVZGRGVURCc25LaHpY?=
 =?iso-2022-jp?B?aG9CN2NkQjhqdkNWRkJtalVhVldoamlXLzVhMnp1a0lIb3NPM2lMQnFO?=
 =?iso-2022-jp?B?Mm9ITjZtMnEweHhvdzVoRXM5WUhFazdMRk9xUWRKV2ExVjFkQmtXV1hQ?=
 =?iso-2022-jp?B?Tjc3MDVNeUN1cFVUcXNpc1hJM1l1dDlja3c0YjQ2eUNTa2FTMmZnd2V4?=
 =?iso-2022-jp?B?ZHdCLzEwNyttUkVVZ3lHVWMvRlhQclQ2MjJ1NUNhaGljMHFKUXN1UjVW?=
 =?iso-2022-jp?B?ME43K0MybTIyYUJRUjg1eStOc1hTVzVwM2pHOGRRMzRaVlRJNCtxci94?=
 =?iso-2022-jp?B?cDVMTHZCVjZ0V3J5bG9jdG9QaWNsR3Iyd0xoQ21Da2JCODdzdFVXS3gy?=
 =?iso-2022-jp?B?SE91M2RaM285anRUcncyQ1RzaGl1UGtvQ2JuanhIMmR2aVIwOW9RUG5Z?=
 =?iso-2022-jp?B?eDZXcVV1VTlTWkxCMStBS3o1V1JsZ1BKdUJhZmVOTnVHNFczRWMzeDE3?=
 =?iso-2022-jp?B?dGFyNU5nRld6TklpZ1FZYUNrWndCQlJISi85UEF2bDZHRnVOSGo3SlhP?=
 =?iso-2022-jp?B?V2FCN3ozVldpWDVlQTNTQkJHbnBHeHJ5UlZQbGt1OTBBbC9zdjhpQ2Fu?=
 =?iso-2022-jp?B?a1BVNDN4NW1QTHg4WmkvZUd6OEhTT253REZ1dU85dy8weHFwUUdUd2Z3?=
 =?iso-2022-jp?B?UmhvbEJzS3B3UVkvTUo3L3ZyZUZZY3pyZXYwYlRUWElyVGNHY1Y3Q2Y1?=
 =?iso-2022-jp?B?UC8zZ2xJNDl2cTZPVUZmcWFCcVJuTERLS3pSb1JzUXJ2QUY0S1NFcXRG?=
 =?iso-2022-jp?B?UFAzSDBHb3NTcnVLdXo1bFdHSExpVzArWS9LMmo4aEIydXVBcWx4bXlx?=
 =?iso-2022-jp?B?UmZuVW1iZ0g4SDVnUmtyTEpvelNmMkN3UTN3VkhWTlpxWDJZVmt1QU9q?=
 =?iso-2022-jp?B?N0VTUHNac0ZKQU9odlRYeFd6akRTek5SQ3h2OEtQZll2VWlDVFQ2VVRl?=
 =?iso-2022-jp?B?UUNYM3VseStmNUVYS25Ua1dKSGx2Kzl4M3JKTGNsUG0vZXFhUnFBVkRy?=
 =?iso-2022-jp?B?OXdIQ1JiakZ0Z0R5QVhXMkFVYkdvZUx4a2FKSHdRUThwaXgrbDdqZ2w5?=
 =?iso-2022-jp?B?Q1d3QlFoQ0dMTUE0THJnc2tjVVp3SzVzbFdJOE1mdUw5Z2tZYlpYZ1VD?=
 =?iso-2022-jp?B?Skd0QTdGNTBnWVdUNHQ0SVF3K014WjVPK0tEQ2hrUzNVYkwyK1Q0bWtX?=
 =?iso-2022-jp?B?cVFadTU1ait3U2lrRjZQdkRFLys4bnRvZzA4RWU5YXBJYWw2M2gxbTk3?=
 =?iso-2022-jp?B?RS9JK0JIQUMzaXJJYU84cXFiWm9PMmhpZEZKUDdmRTg4SytWYlp4VE8r?=
 =?iso-2022-jp?B?NVMrMzB4RmVqN0tPcUw1YUpIRGE3SlluZ2FMbzJxc0Z4RUxqNDhydzBS?=
 =?iso-2022-jp?B?dWQrMFZ2YStwQUVDQ1RjMm9wV3doek9LYjdKaU5GRG1vZGhEK2Z3cFZO?=
 =?iso-2022-jp?B?V2pqU3RQamZ5SDU5SERKQ3lOWHZLRGpISTRkVDZKVU5IZnBrd05Gb05q?=
 =?iso-2022-jp?B?UDJaZVRKYzR5TXVNcXMvRWxrUnhweE53cjMwL05kdGVwRmw5L1J6eDV2?=
 =?iso-2022-jp?B?bHJmSE1ibTJLdWdSUi9SUHZnNHJINktiZ2xGSnkycWxmck8yV3QxcC9D?=
 =?iso-2022-jp?B?L1RVR09KSWNxRHRxYUVML3VaLzNsNVY3YWlXUlVMeVl6MHB4M1dhdnZh?=
 =?iso-2022-jp?B?ZmlTUzJ1K2dvZ0pXajRVV29xYitXMC9WcXNQTm9DK1NkM3piaGRIdXJB?=
 =?iso-2022-jp?B?KzIvZWUxRHNIUW5ieGF6aTZQMmZuVXFucDd0OGE4bENKb2VVSHMwc0hE?=
 =?iso-2022-jp?B?OUJaTXdHQnZYUC9ZVkZRc3BMMDExeDZTUHlEL1lBVjQ4U2t2ZmlLT1pw?=
 =?iso-2022-jp?B?ZFU5WElSc1VyMXRmUU1qelZ4NDl0NG1MNDNIb3RTQmlkTnhBTnRXY01P?=
 =?iso-2022-jp?B?WWVJcEZQem1nVHhjMkNjOGpJbER6OXBMaExPbUFUbDRxc21nZjlUM2J3?=
 =?iso-2022-jp?B?eHFqTkFUVldhZW5DOHg2TFBCVE51cmZoYTlObmZ2WXBFK1hwN0YzZDhx?=
 =?iso-2022-jp?B?LzdtQjRyc2JPRjVJUEc2UGVFNXA3Q0g4b0o3VHpONVJVcFdjdzFKNEw3?=
 =?iso-2022-jp?B?eGxDYW9TVmdIVm1qWXZQbGh5RDZodWZWNktVNkt6cGpraS9hRW4rSjY4?=
 =?iso-2022-jp?B?cFpyNDRqeFFnbWY1azZtNnJxT0RwQlZEOVZtY2s3S2tETlVyNmpqeG1W?=
 =?iso-2022-jp?B?SS9rYmRBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7772.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7142099003)(38070700021)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?MkxpMWVHM2pDZW5VaFdPeXZKdDdTY3E0TnZmYVJLQVJaaHVXUWRqK2Vo?=
 =?iso-2022-jp?B?emZkbXFFZGxZZTB1c1F4N21XSWVsOUdnOFQ5UWFSMEtiQUpicktUS2lI?=
 =?iso-2022-jp?B?VWpEV0s1dVB2RGQ4VlpsL01yK3hBZVdPQWMyUkZ3ampNOEw2UjJzSzZD?=
 =?iso-2022-jp?B?Rlo4WUdHSUFjNHFnRHNXbm9acWhOTkpjSjdUajg4VFMycXd2cVRuQmRU?=
 =?iso-2022-jp?B?bStYU0toL0o3Zk16RWVmYzlTbGVWTVpYQkZKTEYyUmRGMlJ6K3lsaFNx?=
 =?iso-2022-jp?B?dUk0NzRvaTJicTZVUnJZckR4czB1MzVEYlI5cEZtSUZhRldjVVhGNTgr?=
 =?iso-2022-jp?B?U2M4Q3ZNbmFzYjBqWkJ1ZHFhYzhIU0xBV0pyY1VWZFpLQzB0TGNjdXB4?=
 =?iso-2022-jp?B?TkJMVk9DbXJGRzMrSVlqVlg4Z2NETngzclQyRnUzQmNuN1pNZUV2aTMr?=
 =?iso-2022-jp?B?MGRTNk5tUXNGQWc1WHdnZEZjTG1RUzhubjlpcUc4Y1RLQTA0RVBBY0E2?=
 =?iso-2022-jp?B?MmdieWFhRUt5L1RoQ08wSmozeEZVQTFDSDVobmlycVFoaWw0bklFTkdG?=
 =?iso-2022-jp?B?YjFkSE9PVXR5RVBKUHZId3duNTQ2MXJDMFIxWnp1OHFKVEJWeGh2cWM5?=
 =?iso-2022-jp?B?QUdKWEJEUnZhb0ZSOXllbjhnZ2NUUU1sdzBWa0RvZm5QdmZHcitEaXBa?=
 =?iso-2022-jp?B?M29EUnY4WmVzaFI1RUlSR2c2M3JXQ3hMTWdObXd6a3VVSWtmU3RrU0l0?=
 =?iso-2022-jp?B?Nk5YK2Uxb2trWmJ6U3BGYlZWWWpCcm4rOGd3TVdWUk5GMGtWalNPUHYz?=
 =?iso-2022-jp?B?U2Vqd1gwTVd6QmwyZFVobUYvVzV4MHFzbXBzaVhNazFVSUcvZlh0WUI0?=
 =?iso-2022-jp?B?WlJHTVQ4a2JVWkVTOGxCRXNSc2RnQzJ1SzRxcUFmUmhjelcvQW5KVnpV?=
 =?iso-2022-jp?B?aHYwY0NxNGMralRTNk8zZWNjZlpvWXlaNFFXa3dIcytQWjUrcWxnRlBH?=
 =?iso-2022-jp?B?TjQ5R2NxdE14bGF5TnZCZFRaOXJtQnB1bUdVam1nOHNnS0JsSkwyeFRr?=
 =?iso-2022-jp?B?bmdQdDI1VU5KNzMydDhsR3EzbnlTSFI4KytxYkpvS3dLaFR2MnorVG1o?=
 =?iso-2022-jp?B?YklUOVlsc3QzRHpLcms2WnR0SnRlVk9ram9icGY2cFhUV2ViMTNlamdI?=
 =?iso-2022-jp?B?U3JzQUsrTWVPUFZjYUZzbFVDY1RUaW4wd2hMbW5IeHpOQldPZklMUUFT?=
 =?iso-2022-jp?B?UzArUHdmQmd6clVoZ09rSkhGQlYyS09yL0tGdzliTkhMRWFRL1VtKzVY?=
 =?iso-2022-jp?B?bnJ3d2F6ZHRqcGtMT2Fkb0pNUU9FQTB2am1adldrcXVFQ2VmNEVmMm5L?=
 =?iso-2022-jp?B?OGpkOFZTSVB6ZEJ1MVIrMlozK3FNL0p6b1ZWaVlBa2hmMDFkWW1vMXpy?=
 =?iso-2022-jp?B?SlVhK3lIbnFLQVRFVGVuWjBFU253RGY1MnVOQ2JtRzlTTTZOb3pYdU1r?=
 =?iso-2022-jp?B?Uzh4OGh2RnB6TUJ4WE8xY2h2ZjVsQ01jeUxYVU1CWjRwZVBVVTA1Wjl1?=
 =?iso-2022-jp?B?Yld1V2Q4Q2R6UWR2UktHV21Gb3N1L2NOTk04QklJWmVjcVYxekpEbkZL?=
 =?iso-2022-jp?B?NFQ2dzR2bjE0Y3RmV3l3RkxBMloyTk8xV29ycTYrcitqN0U1NDBLYkZR?=
 =?iso-2022-jp?B?aW5TK09ic25SRWtqNEh6ZG1SNEg0QW9UUVN4bEdwSWN4TmRUUWFYK092?=
 =?iso-2022-jp?B?dlNjbWZEWndveDBGUmRqTzRwUHViUklTaURSSG5VcWlVd3hVTXlJa3dS?=
 =?iso-2022-jp?B?OG9meGVXRXdGcUNoTGU2VHFROXlLdUxmNVFxaDBIeFUwcUNSR1BwWlRu?=
 =?iso-2022-jp?B?aWZxTm1ZR25CQ0d6VU43OWtaNWRxSEhKdmlpQWI1a0ZyMHV0RXUzRmFo?=
 =?iso-2022-jp?B?VjZKd0l0RWRjWllSYmxVanQwM0JrNUwxUGFZRDBJM2RTSFAxSnJsS0gx?=
 =?iso-2022-jp?B?MXhBWk15MUZaUy9WTnpRdXlIK1JkaG5SdHJFZWNUQUNBeHFFQXpuM1BY?=
 =?iso-2022-jp?B?TFBFOVd1V0JhT0lzb3Z6TTRTbDhjZVNHbklEQzhFYjhqTldZM1pVMnk0?=
 =?iso-2022-jp?B?UzlvRUFYZHM1M2VzTVF5S01mMGxqT1FMZVZhdW82bFNsWkZWWHJvU1Na?=
 =?iso-2022-jp?B?cmdMU1dNMjlZRWhIWHdwWWRVOGtDVTNaYnN5ZWwwV3Fjbzk5RWt3REV4?=
 =?iso-2022-jp?B?cThKbjJiSWFnY2laamtVczZsQlRrZGllcjFxWE16Yk1TN0xxaWJTN2xu?=
 =?iso-2022-jp?B?RkF2VVFuMlowVmxDazNwbGJ4djVqOGJleGU2RzRBd3hYcDkxKzdScmI0?=
 =?iso-2022-jp?B?S3p0ZWVPRXZsVGxwai9OQ0N3MVhodlAxcFlvVmVQQklVUVhReXd1NG0r?=
 =?iso-2022-jp?B?dWY1QU5zNk9WbVRxRnN2WHV5RDhUcFBaVHl3bld3bWlXVEx3dmRyOXpV?=
 =?iso-2022-jp?B?NDRZd012bHVDTjNlK2lSa28xK1hLR1lnQjEzdz09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cffdac76-645f-434f-fec3-08de54294037
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2026 11:28:48.0807
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U3xrlBuhEUHWjRBh0jSSSRpEGDzH7D9Cy+/5vKBnDK/YKX+MiZ7vKCWR7GOYH5/gjcbdcN6WRFsIcQkm6N+CApCV+K5Ion0duuk6LHcwLtg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8285

Signed-off-by: Seiichi Ikarashi <s.ikarashi@fujitsu.com>
---
 support/export/mount.x          | 6 +++---
 support/export/v4clients.c      | 2 +-
 systemd/nfs.conf.man            | 2 +-
 tools/mountstats/mountstats.man | 2 +-
 tools/nfs-iostat/nfsiostat.man  | 4 ++--
 tools/rpcctl/rpcctl.man         | 2 +-
 utils/exportfs/exports.man      | 2 +-
 utils/gssd/gssd.man             | 6 +++---
 utils/mount/nfs.man             | 2 +-
 utils/mountd/mountd.man         | 2 +-
 utils/nfsd/nfsd.man             | 2 +-
 utils/statd/simulate.c          | 2 +-
 utils/statd/start-statd         | 2 +-
 13 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/support/export/mount.x b/support/export/mount.x
index 12fd841d..0b8d510f 100644
--- a/support/export/mount.x
+++ b/support/export/mount.x
@@ -166,7 +166,7 @@ program MOUNTPROG {
 	version MOUNTVERS {
 		/*
 		 * Does no work. It is made available in all RPC services
-		 * to allow server reponse testing and timing
+		 * to allow server response testing and timing
 		 */
 		void
 		MOUNTPROC_NULL(void) =3D 0;
@@ -227,7 +227,7 @@ program MOUNTPROG {
 	version MOUNTVERS_POSIX {
 		/*
 		 * Does no work. It is made available in all RPC services
-		 * to allow server reponse testing and timing
+		 * to allow server response testing and timing
 		 */
 		void
 		MOUNTPROC_NULL(void) =3D 0;
@@ -291,7 +291,7 @@ program MOUNTPROG {
 	version MOUNTVERS_NFSV3 {
 		/*
 		 * Does no work. It is made available in all RPC services
-		 * to allow server reponse testing and timing
+		 * to allow server response testing and timing
 		 */
 		void
 		MOUNTPROC3_NULL(void) =3D 0;
diff --git a/support/export/v4clients.c b/support/export/v4clients.c
index 32302512..a196a532 100644
--- a/support/export/v4clients.c
+++ b/support/export/v4clients.c
@@ -1,7 +1,7 @@
 /*
  * support/export/v4clients.c
  *
- * Montior clients appearing in, and disappearing from, /proc/fs/nfsd/clie=
nts
+ * Monitor clients appearing in, and disappearing from, /proc/fs/nfsd/clie=
nts
  * and log relevant information.
  */
=20
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
diff --git a/tools/mountstats/mountstats.man b/tools/mountstats/mountstats.=
man
index d5595fc7..b2940f67 100644
--- a/tools/mountstats/mountstats.man
+++ b/tools/mountstats/mountstats.man
@@ -47,7 +47,7 @@ mountstats \- Displays various NFS client per-mount stati=
stics
 .RI [ mountpoint ] ...
 .P
 .SH DESCRIPTION
-.RB "The " mountstats " command displays various NFS client statisitics fo=
r each given"
+.RB "The " mountstats " command displays various NFS client statistics for=
 each given"
 .IR mountpoint .
 .P
 .RI "If no " mountpoint " is given, statistics will be displayed for all N=
FS mountpoints on the client."
diff --git a/tools/nfs-iostat/nfsiostat.man b/tools/nfs-iostat/nfsiostat.ma=
n
index 940c0431..104c7ab4 100644
--- a/tools/nfs-iostat/nfsiostat.man
+++ b/tools/nfs-iostat/nfsiostat.man
@@ -9,7 +9,7 @@ nfsiostat \- Emulate iostat for NFS mount points using /pro=
c/self/mountstats
 .SH DESCRIPTION
 The
 .B nfsiostat
-command displays NFS client per-mount statisitics.=20
+command displays NFS client per-mount statistics.=20
 .TP=20
 <interval>
 specifies the amount of time in seconds between each report.
@@ -106,7 +106,7 @@ This is the number of operations that completed with an=
 error status (status < 0
 .RE
 .RE
 .TP
-Note that if an interval is used as argument to \fBnfsiostat\fR, then the =
diffrence from previous interval will be displayed, otherwise the results w=
ill be from the time that the share was mounted.
+Note that if an interval is used as argument to \fBnfsiostat\fR, then the =
difference from previous interval will be displayed, otherwise the results =
will be from the time that the share was mounted.
=20
 .SH OPTIONS
 .TP
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
diff --git a/utils/exportfs/exports.man b/utils/exportfs/exports.man
index 39dc30fb..efbc6ef6 100644
--- a/utils/exportfs/exports.man
+++ b/utils/exportfs/exports.man
@@ -488,7 +488,7 @@ option becomes handy. It will automatically assign a nu=
merical fsid
 to exported NFS shares. The fsid and path relations are stored in a SQLite
 database. If
 .IR auto-fsidnum
-is selected, the fsid is also autmatically allocated.
+is selected, the fsid is also automatically allocated.
 .IR predefined-fsidnum
 assumes pre-allocated fsid numbers and will just look them up.
 This option depends also on the kernel, you will need at least kernel vers=
ion
diff --git a/utils/gssd/gssd.man b/utils/gssd/gssd.man
index 4a75b056..f81b24cd 100644
--- a/utils/gssd/gssd.man
+++ b/utils/gssd/gssd.man
@@ -190,7 +190,7 @@ name exactly as requested.  e.g. for NFS
 it is the server name in the "servername:/path" mount request.  Only if th=
is
 servername appears to be an IP address (IPv4 or IPv6) or an
 unqualified name (no dots) will a reverse DNS lookup
-will be performed to get the canoncial server name.
+will be performed to get the canonical server name.
=20
 If
 .B \-D
@@ -244,7 +244,7 @@ This option specifies a colon separated list of directo=
ries that
 .B rpc.gssd
 searches for credential files.  The default value is
 .IR /tmp:/run/user/%U .
-The literal sequence "%U" can be specified to substitue the UID
+The literal sequence "%U" can be specified to substitute the UID
 of the user for whom credentials are being searched.
 .TP
 .B -M
@@ -404,7 +404,7 @@ Note that this is unrelated to the functionality that
 provides on behalf of the NFS server.  For more information, see
 .BR https://github.com/gssapi/gssproxy/blob/main/docs/NFS.md#nfs-client .
 .P
-In addtion, the following value is recognized from the
+In addition, the following value is recognized from the
 .B [general]
 section:
 .TP
diff --git a/utils/mount/nfs.man b/utils/mount/nfs.man
index 94dc29d4..9a461579 100644
--- a/utils/mount/nfs.man
+++ b/utils/mount/nfs.man
@@ -557,7 +557,7 @@ If
 .BR pos " or " positive
 is specified, the client assumes positive entries are valid
 until their parent directory's cached attributes expire, but
-always revalidates negative entires before an application
+always revalidates negative entries before an application
 can use them.
 .IP
 If
diff --git a/utils/mountd/mountd.man b/utils/mountd/mountd.man
index a206a3e2..d14c7697 100644
--- a/utils/mountd/mountd.man
+++ b/utils/mountd/mountd.man
@@ -55,7 +55,7 @@ The
 daemon registers every successful MNT request by adding an entry to the
 .I /var/lib/nfs/rmtab
 file.
-When receivng a UMNT request from an NFS client,
+When receiving a UMNT request from an NFS client,
 .B rpc.mountd
 simply removes the matching entry from
 .IR /var/lib/nfs/rmtab ,
diff --git a/utils/nfsd/nfsd.man b/utils/nfsd/nfsd.man
index 6f4fc1df..26eef607 100644
--- a/utils/nfsd/nfsd.man
+++ b/utils/nfsd/nfsd.man
@@ -43,7 +43,7 @@ NFSv4.1 and later require the server to report a "scope" =
which is used
 by the clients to detect if two connections are to the same server.
 By default Linux NFSD uses the host name as the scope.
 .sp
-It is particularly important for high-availablity configurations to ensure
+It is particularly important for high-availability configurations to ensur=
e
 that all potential server nodes report the same server scope.
 .TP
 .B \-p " or " \-\-port  port
diff --git a/utils/statd/simulate.c b/utils/statd/simulate.c
index 4ed1468e..4ff21698 100644
--- a/utils/statd/simulate.c
+++ b/utils/statd/simulate.c
@@ -219,7 +219,7 @@ sim_sm_mon_1_svc (struct status *argp, struct svc_req *=
rqstp)
 {
   static char *result;
=20
-  xlog (D_GENERAL, "Recieved state %d for mon_name %s (opaque \"%s\")",
+  xlog (D_GENERAL, "Received state %d for mon_name %s (opaque \"%s\")",
 	   argp->state, argp->mon_name, argp->priv);
   svc_exit ();
   return ((void *)&result);
diff --git a/utils/statd/start-statd b/utils/statd/start-statd
index 67a2f4ad..c6a3bcfe 100755
--- a/utils/statd/start-statd
+++ b/utils/statd/start-statd
@@ -2,7 +2,7 @@
 # nfsmount calls this script when mounting a filesystem with locking
 # enabled, but when statd does not seem to be running (based on
 # /run/rpc.statd.pid).
-# It should run statd with whatever flags are apropriate for this
+# It should run statd with whatever flags are appropriate for this
 # site.
 PATH=3D"/sbin:/usr/sbin:/bin:/usr/bin"


