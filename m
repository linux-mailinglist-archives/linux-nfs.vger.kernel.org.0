Return-Path: <linux-nfs+bounces-1686-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E33845134
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Feb 2024 07:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BC861F2B637
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Feb 2024 06:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5F283CD5;
	Thu,  1 Feb 2024 06:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="El1RyTAN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from esa1.fujitsucc.c3s2.iphmx.com (esa1.fujitsucc.c3s2.iphmx.com [68.232.152.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1926F82890
	for <linux-nfs@vger.kernel.org>; Thu,  1 Feb 2024 06:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.152.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706767631; cv=fail; b=V2jYw8C91n9bbmGvV/nF9I0KJj4/AzyUihy/ScxUPC8iCnEHtlvHnkM50ORzpNidFmtSQR9dZPOqIhZMNVFh25cY50PpNp9hr5LG/PY3ox5PjFa3717tsbekeEjzIX9La7kYLl8Czx+07q74Y9FTQvNz+FcFGG63JNEPdYL2MgY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706767631; c=relaxed/simple;
	bh=APNZ+/NHySBKRzSe2xhT8DOgJC7eaQehabsdbUV/EJc=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=M8I4H1eH4a4cY/5dtmuX+ntR9aAXtrVa0/feVqwk/1SB++913aYaxI/28Yf+/qwl9qlA8CLRabwZppvEy6hO5YZgsi/wWYwUta2nvlpnj7TTq5x8VVaSVlROnvkBHCVPeLn0o99L8rOjZsNgn51OhnhKL5u7n8j1+VIDmVoVVjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=El1RyTAN; arc=fail smtp.client-ip=68.232.152.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1706767628; x=1738303628;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=APNZ+/NHySBKRzSe2xhT8DOgJC7eaQehabsdbUV/EJc=;
  b=El1RyTANy+/7O7y0Wf5CbFeyQVTAHrGHFNFHBwi5AFxMg7Ao4s5BQJZ1
   aSDWINocnd7x1pYbG+FMPCzdKDxkNWthRIkahRYcO01FOz3yIAjFyv04n
   EnJ7xAaeiQCFbGi0xjS0aE1v84H/E28hPiRIJYY5uJ7+S7LQ9IIk7VC8l
   t0Dc0tY02C7WMtkOyoS4hjH8E7HSigbe+U1hnTWuKIsXpx001gUiGsWrQ
   k176jJCVQ3iP3Un2BnvwcSa8V2WpJhfqQX1zfdFehp3iBOBqyRwrnwQPT
   8qm+tEKv9TUfdogUfOMtm8X17Yh6P66Y3zH611WjrhKf0UluMG0fJejmS
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="20958928"
X-IronPort-AV: E=Sophos;i="6.05,234,1701097200"; 
   d="scan'208";a="20958928"
Received: from mail-tycjpn01lp2168.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.168])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 15:05:56 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LITsRjCPucpBOpVCUvJQyZWvz+ylg8srDw/6MfPZEod3EF7AG24DX1YKr1gXZAoeL8TlVMHWLCkEtWspnqSWIGmoySHY/8XuwP8dGG3MAl4jWQCsRS+ZSykQqDiDYbxrYtMwF2lCFyc0URdUAUnvSV+iehqEKnoPcHS0yCteSWZlCkewfnC8QZw/Kc2JwqxwBtU2FSuHtkdpDfjy+rPZun42+xeNcAWkMs8dqH2OB7RN/aEce5dSp77ZVRAABvCoE84DE8HRTLUwK3SbTxDSoIyJCRk3U/bueLjxdZA1a2ufhA5e9xsKtkpCOzJP/rUvMAr/s9x/KPfFwl+vcFhVOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=APNZ+/NHySBKRzSe2xhT8DOgJC7eaQehabsdbUV/EJc=;
 b=QUor/3IfDdF22eY+0aMg0dTo6I5Fz02d+KKRzsvAxidVDONXgjdoThFQCM/q5BykIR7JORluw+x4bO6R1Re80yTPumqyjFp/B9J3y+zP35mug2wIbzQCMRVh7eQZtEK6qncawuW/EprJ13XgTzG5STBfopIHLM1aKEXdu17X5DVD/+nAWgdzn/bjJF35YE1uvwUJGEtMBhMBl0tAKn/E22kCnBQj/3GvVQ4yYnuDJUlqeDcCLZCblSn8eCbECI2TBCAVnV4n/JDo31P4iYaQfGubAVCCdIyXoL/Nj1Yd5/tkcBBR1xU/BV+CeFY2MBIVcwN5YcvK+vHmuEoB/f6D8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB12085.jpnprd01.prod.outlook.com (2603:1096:400:447::5)
 by TYWPR01MB9608.jpnprd01.prod.outlook.com (2603:1096:400:19b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.23; Thu, 1 Feb
 2024 06:05:50 +0000
Received: from TYWPR01MB12085.jpnprd01.prod.outlook.com
 ([fe80::fdb2:f9ea:e915:36ce]) by TYWPR01MB12085.jpnprd01.prod.outlook.com
 ([fe80::fdb2:f9ea:e915:36ce%5]) with mapi id 15.20.7249.023; Thu, 1 Feb 2024
 06:05:50 +0000
From: "Hanxiao Chen (Fujitsu)" <chenhx.fnst@fujitsu.com>
To: Dan Shelton <dan.f.shelton@gmail.com>, Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>
Subject: Re: Are Japanese characters allowed in hostname in /etc/exports?
Thread-Topic: Are Japanese characters allowed in hostname in /etc/exports?
Thread-Index: AQHaVMGsKMZ9QSq1fEeiQcMEw/TE9bD0/+Rw
Date: Thu, 1 Feb 2024 06:05:50 +0000
Message-ID:
 <TYWPR01MB120859289FD89D54D8F9894CDE6432@TYWPR01MB12085.jpnprd01.prod.outlook.com>
References:
 <CAAvCNcCP5Lv7qRKj6kLEVvjs-fEAK3=MoZ8rOp2qO28iXJR5hQ@mail.gmail.com>
In-Reply-To:
 <CAAvCNcCP5Lv7qRKj6kLEVvjs-fEAK3=MoZ8rOp2qO28iXJR5hQ@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 =?utf-8?B?TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5Njgw?=
 =?utf-8?B?MmZfQWN0aW9uSWQ9NzcyODcxZDctYThhZi00ZDAyLWFmZjMtY2UxYTQzZGVm?=
 =?utf-8?B?ZmRlO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMz?=
 =?utf-8?B?OTY4MDJmX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQx?=
 =?utf-8?B?LTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMzOTY4MDJmX01ldGhv?=
 =?utf-8?B?ZD1Qcml2aWxlZ2VkO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFk?=
 =?utf-8?B?NTUtNDZkZTMzOTY4MDJmX05hbWU9RlVKSVRTVS1QVUJMSUPigIs7TVNJUF9M?=
 =?utf-8?B?YWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfU2V0?=
 =?utf-8?B?RGF0ZT0yMDI0LTAyLTAxVDA1OjU0OjQ0WjtNU0lQX0xhYmVsXzFlOTJlZjcz?=
 =?utf-8?B?LTBhZDEtNDBjNS1hZDU1LTQ2ZGUzMzk2ODAyZl9TaXRlSWQ9YTE5ZjEyMWQt?=
 =?utf-8?Q?81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB12085:EE_|TYWPR01MB9608:EE_
x-ms-office365-filtering-correlation-id: bcd6ab4f-455c-40a0-ab00-08dc22ebd762
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 kxOXjyoLzDt+ym8h4SSdOKyfgylOvG2UhivisyqL2T67JX8QDEYd3oY5APBlyL2s9IC0adhnjVnQJNTGhwFpVzT1Dd5yIXOtPH3SYpVUwOpMmOBYPZMlLgkV6DIwNx4dzweznMfG/5gN4xwZXvcIm79Xf4yW0zyQar+f+FQbw+8PS7eC+Wm2+MB+QIBYl6hq3yCtpM92fWqzHv6nRX1xnFd/Z7M+4XfN++Sr/q6nrF+q30Ovn42TBYbHpBLK9wHeqIGQWKpqT72v4y4+0TxCcMyraepicYq7AUQ02FM2oClRazgq6rDT8TJ8f2ihp9pShIMuP50/d8IpNOp/va/SjJCyenwA0ipb3bvXy62IFUwA8eqa1WYB3lwnW6IV5saBC9xmlrZVnHAetFvkZ8KdL9TR7AChD5T7fujYbQpFPyL7ynG1fljs4w68jv0acknlZBmLpjy1/LgzkxzXBSwRG4p1y1vWRxrc/1P27bSlK3FbvqTze1P7isBvULqIqva4NKYkLOw0zUG3MBmbM0O+ErfAxGH6HBehb5/s2gSKARHOSbk3/RxOzt2qi+iLZqkNC1IYOWqy1cmibNn5hpLjp4jjneP5g6d2XanNLGCqiVZVUofoma3QjjW+KTjX0VbB
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB12085.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(396003)(366004)(376002)(346002)(230922051799003)(1590799021)(451199024)(1800799012)(64100799003)(186009)(7696005)(66556008)(26005)(71200400001)(83380400001)(1580799018)(122000001)(41300700001)(86362001)(85182001)(82960400001)(38100700002)(33656002)(52536014)(9686003)(8936002)(110136005)(66946007)(66446008)(64756008)(76116006)(66574015)(2906002)(66476007)(478600001)(316002)(8676002)(6506007)(966005)(5660300002)(38070700009)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U3h0bDc4YkxBTll2Qmhpb0tjM1Y5ZEY0M2JLekY4dTl1MHNWSks5ZXU0WVF2?=
 =?utf-8?B?dGgyYmdkUlU1UGpMTkkzdzk0bjI2TUp1LzJGemFXOWpOOGVGejY4NldMQTRH?=
 =?utf-8?B?UDdrV2NpYXI0RFFpTzY2TjRCVmhoL3pPTlNCWGptYWtEVlNEZlNYRmVXQ05u?=
 =?utf-8?B?a2hpbEtLRyt1VmVhV0RKWWFqWXg3bjg4RTlhV3RQWHlXQUZzWklpb1JIbG5K?=
 =?utf-8?B?VnZIRWFQNXBEeTl5eXVTK1kwdkIrWUFBVFZYVFFuY3g0dWpWN2tsNWdyakl4?=
 =?utf-8?B?alRtdkVmWE03LzNYaUxPOE1FQVZEWUo4RjV2SHNWOU44bFlGZGRwME4ydmov?=
 =?utf-8?B?WVBvOE14Nm9nVUhLb3lQNEo0TE1YUjBabm5CVmNReHFsdUVVVTlPc1pZUmUx?=
 =?utf-8?B?M25qZVdXdWJKUXpvdjBGMFl6ckRQWmsyMnJTQWVUZXQ0SGxYMmtHMXZ6MnJj?=
 =?utf-8?B?RU84ZDFoUDlkMFVocDh6UEhSbzA2K0Nlai94bktTK1RDRHByMkRSWHVyNk5M?=
 =?utf-8?B?MGgyZEcrNk0wdXRPdmE2dUR6Z09tWEtJTG9ZRURveko4M1BzODBVci9sUERo?=
 =?utf-8?B?eTZ0c2xXejZMSVV0MVYvZllIc1QranBQNnI5UmErSUQ2bXVJaDMyUG9UQUlL?=
 =?utf-8?B?RStHTy8wazhlUjNDNkdYV2Y2TE40WjltTDEwRkhYamtINmh5UHhsUTN1R2x3?=
 =?utf-8?B?VEVoRkV6Y2g5ckJWaU1BUWFxNTA4NTg3ZmpXRWcwSnVnbnJPQ0RwMkIvU0lT?=
 =?utf-8?B?dHRobnNzbUNPSS94MzFhRjlaT3FRMVFJL3JtQ3lFSUZ0M0lOd1VORXBQaUtz?=
 =?utf-8?B?TnhjTDkzeE1XUGlJckxFYWMvWjdUeXRQV0hpSUxpSW5wcUcwYkcvSGRIOTZO?=
 =?utf-8?B?WXV0WUhkVitFdVZLemc5RmdIR1o4L2Flc3JwOUFvZUdUZGVWM3M4Q1NkanRp?=
 =?utf-8?B?b2JTQkgrMTVkdkNDR01mNDBYSUNvYXdMQlNSVEFXcFZiZ1VZRDROVTFlaTZH?=
 =?utf-8?B?b3lGYmFMNnBOM2w1MUp3WUR3UmV5MUxyTHpPeXJESDNXbWliRWlqVEVJR281?=
 =?utf-8?B?MFJuV2pPZVJ2MWNjeU5ET2JNdzBsR3pUUW1HWHJIV2xGVWpHMldvUUVHcWRE?=
 =?utf-8?B?SGJRRFZXUU51bGY4NUVnc3plUGNOb1IrNDZVN1J5eXFkdy9US1haeDAxWUpC?=
 =?utf-8?B?SFpoWTdTTndVQ3RYbHg5dW5ocEUweTJTSHNyazBQdlppSjBxRFpVbmNTMWpM?=
 =?utf-8?B?SmpQTXBYOW1RU1V6SFpYaTdRQUxuVHFsZ3J0WUVwSjkzQ0xaNGF0VE5jL21Y?=
 =?utf-8?B?SFRyaG5RbTBQdDlRRHJzUUZ4emh4ZTVRQ2YvUTJhdHhTY1dxTWNQc1dFRmJv?=
 =?utf-8?B?TU04Wmo4T0VDR3hUZ1Rzcng0WTEyb1dtVzF0YkYzTnBaN0M3eG56OXdVK0d6?=
 =?utf-8?B?RXdaeWJ2cTVyZkJwN2U2a2JHOTRtTjNaK1RiL0E4bFJqT3VZMkRNQ1NvZENH?=
 =?utf-8?B?RGJ6R3RBQUJKZTRXZ1hKcFkrKzdxVTY4VGlJZ2xOaFp0K0YzYk1ycW5zWTRB?=
 =?utf-8?B?SGQwTmtLR2RYUHhnSXV0UWY1QU1PUnBEa1VwdUUzY3FTczlGUFZsdUpWQVJN?=
 =?utf-8?B?aThra1lMQ1J2TjJQdytORk92bGFBZlczaXprNmNwSlljRlRHeERxZklKMTc5?=
 =?utf-8?B?U0o3RitvSjNZTUVvcDFaMXlIODBOcm5DWDVubjArYUsweVVielhMVWdmRTlH?=
 =?utf-8?B?cExSZmF5bytJRVlwUVZFT1pQOVoybzVqMFFneitITUZOci8zMzdJRUxMeUIw?=
 =?utf-8?B?TXBKMThZbnJEaXRCZ0tUZFRRUzh4SjNZSE5JZ0lQWWZWZXk5Zzh5QmU5Nngw?=
 =?utf-8?B?QitNMXgybXl5NS8yM0FnbGt5OHVEVDhNMXNEb2VYYUprelcwdmJlTzhsMDla?=
 =?utf-8?B?bWFuZW0xQTlsbWZCT0QwMlJjbkZubUZyamNkdlhrWTF2T3ZxQXcwak9OcXFS?=
 =?utf-8?B?VklEY3M2OS9Fd2xDcFMzVzROcmxMRUlzcm5wdHMyMmsvbmN6OXN2U2NLV3Ry?=
 =?utf-8?B?N0Mxa05rUWdNVXhud3J0K3NYU1dqSmZjcXRIdzFINmJTOWJ6dWpCdDJ3MWdP?=
 =?utf-8?Q?qqNVKfVBrP86H6b8uoQom1tyv?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dSJtM5P5Ueqhuclh4aSsS8KLCo5RUrmUUOVP91X2lUsdKOpUp200Ad86JkbJ2rXqZtjqYnMdQM/aN7fW/zY5f34AaRhquB+P2xsHeAjOk+s40aVOm4OCcfAazOT3jTle+0Oy1J0dWSM/UMKvQO0ao1zaYnpLkM1hxvU58IkDOlEjpnp091pPHfAluoJA6eC+Lqt8Ke7kiCNVKS3IbS3/QrZG7UvXRecM9zXkbrXtXMfquEh2eh230PgcrkPCHVznOZUrDy4RZ/gI4vgAntY6FoBbmPx+b54iRpg/+ZgymByl5Ui/++S3H9HIQypTftxNBNehgHJ0GfIZqO3MafrPKpMjAdC7ARJcd07GnQaIxcQqNudFc72PNbeJ/74C8C9Lz7501hnY7GvC+3vbylFRGF9WZ4G5oOzxNwh1EqQ/Obstj6FubLNitc7M9lTTIJWLHbAf/3MY3Z7qZ35bKtDR4uVl1j8rKb48Qv7I4PSIbEzvEfetUwJE1NiU7+dXYbW6fMwfc2vVFutWM762iX1CVyMQ0h/fDU3r5hau4mjxrnT+fH7gU2/GgUHHenp4IhWAbs/tSdR0lwG5U3y8WIuQuMYjOMORXccwi6XVH2UPt2c0iFT2qGlooG0lSw40/ORi
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB12085.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcd6ab4f-455c-40a0-ab00-08dc22ebd762
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2024 06:05:50.5624
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EkVL2n2XukUNlPhY/sVVmCcCEqZIOMEBMfWi3Xdx7kJh2p4cQvcbXNSGDKAvULW+lRDYAs3izrtiAR6OvQJOLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9608

DQoNCj4gLS0tLS3pgq7ku7bljp/ku7YtLS0tLQ0KPiDlj5Hku7bkuro6IERhbiBTaGVsdG9uIDxk
YW4uZi5zaGVsdG9uQGdtYWlsLmNvbT4NCj4g5Y+R6YCB5pe26Ze0OiAyMDI05bm0MuaciDHml6Ug
MTE6NDkNCj4g5pS25Lu25Lq6OiBMaW51eCBORlMgTWFpbGluZyBMaXN0IDxsaW51eC1uZnNAdmdl
ci5rZXJuZWwub3JnPg0KPiDkuLvpopg6IEFyZSBKYXBhbmVzZSBjaGFyYWN0ZXJzIGFsbG93ZWQg
aW4gaG9zdG5hbWUgaW4gL2V0Yy9leHBvcnRzPw0KPiANCj4gSGVsbG8hDQo+IA0KPiBDYW4gSSB1
c2UgSmFwYW5lc2UgY2hhcmFjdGVycyBpbiB0aGUgaG9zdG5hbWUgZm9yIGFuIGV4cG9ydCBsaW5l
IGluDQo+IC9ldGMvZXhwb3J0cz8gT3IgZmlyc3QgY29udmVydCBob3N0bmFtZSBpbnRvIGEgcHVu
eWNvZGUgc3RyaW5nLCBhbmQNCj4gdGhlbiBwdXQgdGhhdCBzdHJpbmcgaW50byAvZXRjL2V4cG9y
dHM/DQo+IA0KDQpJIGRpZCBhIHNpbXBsZSB0ZXN0IG9uIG15IG1hY2hpbmU6DQoNCjEpIE5GUyBz
ZXJ2ZXI6DQojIGNhdCAvZXRjL2hvc3RzDQoxMjcuMC4wLjEgICBsb2NhbGhvc3QgbG9jYWxob3N0
LmxvY2FsZG9tYWluIGxvY2FsaG9zdDQgbG9jYWxob3N0NC5sb2NhbGRvbWFpbjQNCjo6MSAgICAg
ICAgIGxvY2FsaG9zdCBsb2NhbGhvc3QubG9jYWxkb21haW4gbG9jYWxob3N0NiBsb2NhbGhvc3Q2
LmxvY2FsZG9tYWluNg0KDQoxOTIuMTY4LjEyMi4xNiDjgqLjgqTjgqbjgqjjgqoNCg0KIyBjYXQg
L2V0Yy9leHBvcnRzDQovbmZzcm9vdCAgICAgICAg44Ki44Kk44Km44Ko44KqKHJ3KQ0KDQoNCiMg
ZXhwb3J0ZnMgLWFydg0KZXhwb3J0aW5nIOOCouOCpOOCpuOCqOOCqjovbmZzcm9vdA0KDQoNCjIp
IGNsaWVudDoNCiMgbW91bnQgLXQgbmZzIC1vIHZlcnM9NC4yIDE5Mi4xNjguMTIyLjE1Oi9uZnNy
b290IC9tbnQNCjE5Mi4xNjguMTIyLjE1Oi9uZnNyb290IG9uIC9tbnQgdHlwZSBuZnM0IChydyxy
ZWxhdGltZSx2ZXJzPTQuMixyc2l6ZT01MjQyODgsd3NpemU9NTI0Mjg4LG5hbWxlbj0yNTUsaGFy
ZCxwcm90bz10Y3AsdGltZW89NjAwLHJldHJhbnM9MixzZWM9c3lzLGNsaWVudGFkZHI9MTkyLjE2
OC4xMjIuMTYsbG9jYWxfbG9jaz1ub25lLGFkZHI9MTkyLjE2OC4xMjIuMTUpDQoNCkxvb2tzIGxp
a2UgYWxsIGdvb2QuDQoNCkJ1dCBhcyBbMV0gbWVudGlvbmVkLi4uDQoNClRoZSBJbnRlcm5ldCBz
dGFuZGFyZHMgKFJlcXVlc3QgZm9yIENvbW1lbnRzKSBmb3IgcHJvdG9jb2xzIHNwZWNpZnkgdGhh
dCBsYWJlbHMgbWF5IGNvbnRhaW4gb25seSB0aGUgQVNDSUkgbGV0dGVycyBhIHRocm91Z2ggeiAo
aW4gYSBjYXNlLWluc2Vuc2l0aXZlIG1hbm5lciksIHRoZSBkaWdpdHMgMCB0aHJvdWdoIDksIGFu
ZCB0aGUgaHlwaGVuLW1pbnVzIGNoYXJhY3RlciAoJy0nKS4NCg0KUmVnYXJkcywNCi0gQ2hlbg0K
DQpbMV0gaHR0cHM6Ly9lbi53aWtpcGVkaWEub3JnL3dpa2kvSG9zdG5hbWUNCg==

