Return-Path: <linux-nfs+bounces-1612-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 441938434B8
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Jan 2024 05:05:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A904F2876D4
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Jan 2024 04:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A8614A9E;
	Wed, 31 Jan 2024 04:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="JplRhi25"
X-Original-To: linux-nfs@vger.kernel.org
Received: from esa16.fujitsucc.c3s2.iphmx.com (esa16.fujitsucc.c3s2.iphmx.com [216.71.158.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0FA2134A
	for <linux-nfs@vger.kernel.org>; Wed, 31 Jan 2024 04:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.158.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706673902; cv=fail; b=HRIKpKAQ9FldISV7ADyZYC/Uno3u3/nMkJQf2GkkY6giF1MZ1ULkeHnFmJu3/afvvULh9zT3LHdqSy5sCWRkrHr9yg4q6Q3PgN+SogIDVAuxW+CDt81LFWPROWCCtJj54M4ZQcIWVq9SdYw7i8v1TpVu+OZFNF+/2CLqSQ/YeSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706673902; c=relaxed/simple;
	bh=8l/3AjLixVYOYFOmSv7uE4SbV9BW+/STdbH8cBuaWwc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BBZi6Si50y1V5DJo2/lifg3+MzvifgljllCcHqAR+EEX6QXVxCy/hKWOjRrwrS0453GlZjrR2IyBVpuCQGM8j43g+h5rMc1mLnPEIDOEWtMwEpVxPwjZUhGUJuRRbYnxVauddkYqKxM9I0M1+lRpS59hcEAZwTZ+CuqwpD5qkw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=JplRhi25; arc=fail smtp.client-ip=216.71.158.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1706673899; x=1738209899;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8l/3AjLixVYOYFOmSv7uE4SbV9BW+/STdbH8cBuaWwc=;
  b=JplRhi25WzKJTRHEK1iR7GDs0hOSTUq43Ak0ONFlUoFZJVcY2lFT/d8v
   2jUflEyiFEARb1L+3/gB24OOdW86dkpUyNg0/U5KEt+ejLES7uFZa4i/K
   NsoKDR434dwIHB+ZdUDDkWVyRcEI8sUgwzyFWnnCJg1DARspctNDxvrrN
   GilJC1OkhTM7D9G114sbMiVYLgkmjKk/52rWKx/icEqfSqc1jl674nCYS
   CjGb7/Euoqj4BRSZMQAM3OmS9pSO21PvLkr/Xvc6mgdg2/u5dWju/A9Il
   XozaVcO5MVK6/EDB/Acu+3X9c2OL7gRktUI7nVxcnk1xwui9CqRKaajL2
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="109731276"
X-IronPort-AV: E=Sophos;i="6.05,231,1701097200"; 
   d="scan'208";a="109731276"
Received: from mail-os0jpn01lp2104.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.104])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 13:04:47 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YVxYjqaxPSgiaK1EBKURICi/asxco1ZL7uyAEiPcqNZNwpBTpJ2nbrTGYhqQZFf+6OU4QlktOaKqBWshw+DNvE2iMzCESLF8eSu0Jmlcc6L/7zHBzOAaZZ1wXg7odkbyjolEoRb4hA39QGQUhgT8UYog3J32+wrnDjJeok+6Nkt/R/ZvPRrLIJQz/VMCJOqlPg3ixEAwZy35oFPOyRpr9NdpWLETPCUiC187YO4XIOwcJGdVt+xwgJknsZIz6bF2gtpBZeCUhwnSSJ3ujz4fqiMkxEEDv3frpncTbht4D+hqv/QWxtarj0GPi0tTCX34pLJTQkC8zWHbAP05EKBTnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8l/3AjLixVYOYFOmSv7uE4SbV9BW+/STdbH8cBuaWwc=;
 b=Ex5EN6zoBluavGnXZc+3MLf+cHXv6zQQd/qoy2D10CWnP5OzgEckpiT25/6TXkuQ0kz5CDG3M8Mffzt5F1C24ERK/3S7uvs4bZ50Pxti6A3M4ZEh7DuvjrZLrqHByjFTz5IuhMhFn+HsO8lcxQqBC4FCcqhZhpwIt2WUccK3C2V3M+OmRp+vv/u7sd9cKgGiPLRh/we6tmfFizoicv9mYcDNFSq8L4lhyibprp4Y2zuZpP1ZnwWkrof0oi89o0rwaHAQzy3W2w4NN6dRC1WUoxN3T1oZkfj/I/zQjfBKpb6pFasq7Q8J74v0phXVhP+iDBJ6tZh7Pf3Q3TnPbxZ1Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB12085.jpnprd01.prod.outlook.com (2603:1096:400:447::5)
 by TYVPR01MB10719.jpnprd01.prod.outlook.com (2603:1096:400:298::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.14; Wed, 31 Jan
 2024 04:04:43 +0000
Received: from TYWPR01MB12085.jpnprd01.prod.outlook.com
 ([fe80::fdb2:f9ea:e915:36ce]) by TYWPR01MB12085.jpnprd01.prod.outlook.com
 ([fe80::fdb2:f9ea:e915:36ce%5]) with mapi id 15.20.7249.023; Wed, 31 Jan 2024
 04:04:43 +0000
From: "Hanxiao Chen (Fujitsu)" <chenhx.fnst@fujitsu.com>
To: Jeff Layton <jlayton@kernel.org>, Trond Myklebust
	<trond.myklebust@hammerspace.com>, Anna Schumaker <anna@kernel.org>
CC: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>, Dave Wysochanski
	<dwysocha@redhat.com>, David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v2] nfs: fix regression in handling of fsc= option in
 NFSv4
Thread-Topic: [PATCH v2] nfs: fix regression in handling of fsc= option in
 NFSv4
Thread-Index: AQHaU5OqUH1ExcGQHkC1cIXcb6X8ybDygO+AgADNI3A=
Date: Wed, 31 Jan 2024 04:04:43 +0000
Message-ID:
 <TYWPR01MB120851C84230D702BC288E00EE67C2@TYWPR01MB12085.jpnprd01.prod.outlook.com>
References: <20240130154626.741-1-chenhx.fnst@fujitsu.com>
 <1e77c7aa351ea798f803250f7b7ff6c09303b339.camel@kernel.org>
In-Reply-To: <1e77c7aa351ea798f803250f7b7ff6c09303b339.camel@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=1a05fec7-85d5-4e84-9ca4-f058a2cc76de;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2024-01-31T02:22:13Z;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB12085:EE_|TYVPR01MB10719:EE_
x-ms-office365-filtering-correlation-id: c4e5361c-a914-4af7-ae63-08dc2211c149
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 8xt/4R1ZfUtirFBE6ozSz+e736Aj9JoZoTGLmsm/AHVIRnQ04nRmt8kF/XL4ld69sibtik7Z8bbjax32ukvRTlURd6Ua1wW600uSZ5HIFnORuzAjR7xtrTXtN4rWIeUB29+jAVP592IA4NuVsEazPKral6UoWa9YH81mhWCOyV+24M6YZ5i5vTJN5sCghNOFmsOvSgIfJZuSFGn37+v+yEiolzDCpZZrWX25gB6PCipUIcMS8dyWtYCIRX26WdA7/p1GvZYi7Zp3LhlAA/RYuL9LAjMAqnULR540nTrTLcZWwJdx80fllXx4zhhZ809e769x4oFgRzwQ3t2XumQdWx9gpnQ8IZiMHciwHmTDEUuPJV8QAxUoJDqVMLN5DnSlsYKPswn1Dxx0Bn4X4FEv98gu9uo9RF7OlomqDrH4Q6bBvaM7PHYb+T3pyVwoad90Jozx1/rzJ7T3WkPWrhRURPXo8JWas/NqKB3I5NhTtNfIq5oG4NG9CtWh75DsKQN47EushwOe+luO4o9kXdnS8O9e1fRN8KP0TH3oi5pVRD1R8BYl8cBixMRk7sBK0sHp0HGZoQCIRJhfvjmvGbEX7UChIrSchqSRVO8dmUaLZE6ZVVTCi/RRH/l5f9pw/4nzKmNkFAvRtN6CbjVZn+G+KA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB12085.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(136003)(376002)(396003)(230922051799003)(186009)(1800799012)(64100799003)(1590799021)(451199024)(55016003)(1580799018)(26005)(6506007)(7696005)(33656002)(86362001)(82960400001)(38070700009)(85182001)(110136005)(8936002)(8676002)(9686003)(5660300002)(4326008)(66446008)(41300700001)(38100700002)(66946007)(122000001)(76116006)(2906002)(66556008)(71200400001)(52536014)(478600001)(54906003)(316002)(64756008)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?VzdtOTdtK3k3S2hLd1FBbUZSZkhVMkQvcFk4dXRwUFh4TE83eTVRcnNrN2Ex?=
 =?gb2312?B?RDNvb2M1RTJvRWpyZ2F0ZWFYakhQTC9pUGd1RU1yYmNTZXF3TStHNzIvVVRZ?=
 =?gb2312?B?bzFSUEZBUWtKK0hDOE9jKzBDR3JhWExNeUNVbW42OE5CWjQvWkJ0YVZCRzRr?=
 =?gb2312?B?Y0ZmRU1saEQzNm9vWnhrZXFPQ1ZaeThSaXBQZlNseGZmSzBxZ2JKUFh4bFRO?=
 =?gb2312?B?aGxjemNycFE5Vk9GTmloRTF4cU1ReW9CdkdoU2U2U2NlNmh4YXVTT04yTTEx?=
 =?gb2312?B?UjUvUjVQeGV3Nk5nWmM4U3VMT1RQb1pkbmtLSHZYWnVUd3J6UTkvdFoxT1pB?=
 =?gb2312?B?a1AxT1hYNGdlN3AwNDh2TTlhZUVmUHF4ZU5HaitXNGtLU0FsSlA5eW1yY2Uz?=
 =?gb2312?B?V3F3MVlYSm9haEhvNXJQeVM2L1FCeDViQjJ4SHBtVWIyVkFRb3NDbkhIQWVY?=
 =?gb2312?B?a2JNWGxYTmVwWFlxUkRHNWcrWXNKQ05aMHVEVkpxT2JuaWNFN1BNYzFPa3Vk?=
 =?gb2312?B?dkVQVyswRTBPclpnVWNKbXA2N1VzKzNIOEZMZDMrUTMrK1JIN1E0U0QrelhT?=
 =?gb2312?B?NUQweVZtaHRBa0h4OU53d1VYa082LzlDMzY3ZVRIZ045VUhrMVI5WmZhT2Rm?=
 =?gb2312?B?cktqcElTd2dkWXd5UkRrdTF1b1lwTlk4empaY1NzNytYUmg3VDhENWEwY2I4?=
 =?gb2312?B?VHFaMW5qcjRjQjdkL1ZscTBUYjM3eSs0NnY5TWdFNjM4U09iNGgvQnBTQWZU?=
 =?gb2312?B?YVg3VGQrckJTMVNuNUI0c3RkSGlSTmhkeXUxcndYYUlXT3VSNVAwMittN1JM?=
 =?gb2312?B?K2tNZU81K3RWaU43a0pNdDR3dk5TRzlCblRhL1A2dmtoVXZZemhRdW92T0lV?=
 =?gb2312?B?VHMyMDhjMnZHUUhHYWgvdTdkYUNIZktieWdmRWNua3N5VDVBK3o2bThzdkpz?=
 =?gb2312?B?L0dkeGtqYVJBcENKMzExblI0NnpZdm02MjZVbDExWFROZzJmTFlkb3Vhdytx?=
 =?gb2312?B?U2xJY1pQVitzeDJXc3NjMjJSMW5UclByMk5ZRC9wQU9selBPRjdjcW9PTlhN?=
 =?gb2312?B?bGY4UW1rVEcxcFFrbEg5cjY2cEdaaVJEcnpoMjZKOC9qRkVLNzZ0Q1RkWUh4?=
 =?gb2312?B?MjdjNlR0TkdrZFhxMFNJSld1Y0xadnNRMFJZa3liT3hhUHRlakQ1NzFFK2dN?=
 =?gb2312?B?YTZjdExMb3YzdXNDc0ZLR29XeFJPdSs3TXpWYXJFazJveWpnVVgyRXBxT3VD?=
 =?gb2312?B?WnE5ZzZMdnJaUlpoOVFRSjBZOEk3V2VVM0wwdGpxYUltYU95blZmREtXZUdV?=
 =?gb2312?B?V1BnQWtDYUtFNzNCV0xkaEhMSURldXZWVEdKTFQ0Y0w3Mm1rQ0ZPYmhLbllq?=
 =?gb2312?B?MFNBL2hKOTdmYXMwOEM2aGYyMDRYcHFkNVluNUk4TkQrWGFaYUhWUUFtSDFq?=
 =?gb2312?B?WlN5cDc2cFI4ZnNZWnZheXY4Q05DK2o1WXF1SkpaVklxZlFuZTR6MkJkTHNX?=
 =?gb2312?B?U1ErNUlBcm5ncmtsK3AxSGhmODhJU2hGR3RRa1FtWmRIODZoZHVYMWRhNDZ3?=
 =?gb2312?B?VGpZVjBDcWpQU2xWbUoxdC9lR3RMU3lwaFdKaUdreHJoTjlJeU90bjNIeHJx?=
 =?gb2312?B?aXJjRElUWVUvRjBVMENMa2lpcW05VVlaUzhsditSUjJyVkIxMTdWWksrenV6?=
 =?gb2312?B?Z2NuMXZjNG0ySVNlRGVOTFNodHFkdExYcGxZZDY1dWlkczRVMDVJSk5LZTVw?=
 =?gb2312?B?cjI3dzRBWmxNa3gyM1VoQU05OUxtcnBHL2xZVGNmelRYeGYvQUJzblJpYXRs?=
 =?gb2312?B?a3dIbmpkY0VvbU11akZEYzZGMWZxclhPaWVQV2cxcGZLVm5mNnVIYjNMbVh1?=
 =?gb2312?B?cFk5czBhNld1bzR1UFFZSXZSRjJES1VSbUJJQkIrYVZZMzJnbWw1NXp3bGs4?=
 =?gb2312?B?eVcyVzlyejZybEFCcGorcVhSZ3QvSmdWeHpTb0tTVEFyOW90ekw1T2QvL2Z4?=
 =?gb2312?B?T24wV0lUNVRFdzZlWHZXUjBNWFpqQzlGY0ovNUpnSThidy8zZS9CNnl1Nm55?=
 =?gb2312?B?U0dvS3gxM29hS0E3eTNzcVE5YXZHdE9tK04wdDZsZmJ6a01DeVhDN0NmN3Vq?=
 =?gb2312?Q?uIJQ243qwzy++YkvaI182LYdU?=
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
	PLhYLKMcGA8Zckcxn+k2Me82LqsKZSCf79ZF3Qg+lHnOUFsMGJiwekQBbe5D/r3xsXrB8GSiVDWVYFdpKrb5MwNmwcWN89wVn6YE55Cht5jMLe3++7fJiHte96Y9QOjx2CFphe5LPs0G21fI7CbcVEAhHdPy++C0r+oLeaTpSaGp1iAqm8ePmMdQZ3nr8quhly4LtXzy93dF8MfmyRrud5PhD8TzPBo70kjzakQLd4hWMpIQT95SQh4mg3pK22tKTx90SY1C8eUUxQZbNzjehUGski/1xJ+FjyoByPIoORnrwNIbhJ9FU6EAx9AK6iz4v4ACLE8aZRzWeXQ1z4+artsUkwmXss6dt0o5cSNdN7MDrItDfIZw8DWqWsk6CTZo2/ZcQxJKffW9kFRZbgSSsHgHZ52wYeZnuHOY5KBJtXkeoHnw9uS3Se6mN6o9UYMawe++WFfu6bW0kc78I1eUe9THpRwkEMGoKhwAOAByBxBKnIh3X6DDzuAzOlDgev6Aup+H431xjRtoZEzCOw2RbxlFR82rM1VDvljnzBeSScpKGatEnvJ8skxizaf8DFwYV6GeCrz451qLPD+CLFBB4Z/5su7mt5bxhi18zrEKsvJlI0o1SJyNhbKGO09XQkw/
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB12085.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4e5361c-a914-4af7-ae63-08dc2211c149
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2024 04:04:43.2238
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pd1nf8qeWYTen/EjGnYJAa76RUoClD7iOJvXwKvSlsmNz2RrKW5S8jO8Ej3ZxFFtzqMJ8LefCUjnQTzczZGTTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVPR01MB10719

DQoNCj4gLS0tLS3Tyrz+1K28/i0tLS0tDQo+ILeivP7IyzogSmVmZiBMYXl0b24gPGpsYXl0b25A
a2VybmVsLm9yZz4NCj4gt6LLzcqxvOQ6IDIwMjTE6jHUwjMwyNUgMjM6NTANCj4gytW8/sjLOiBD
aGVuLCBIYW54aWFvL7PCIOrPz/YgPGNoZW5oeC5mbnN0QGZ1aml0c3UuY29tPjsgVHJvbmQgTXlr
bGVidXN0DQo+IDx0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tPjsgQW5uYSBTY2h1bWFr
ZXIgPGFubmFAa2VybmVsLm9yZz4NCj4gs63LzTogbGludXgtbmZzQHZnZXIua2VybmVsLm9yZzsg
RGF2ZSBXeXNvY2hhbnNraSA8ZHd5c29jaGFAcmVkaGF0LmNvbT47DQo+IERhdmlkIEhvd2VsbHMg
PGRob3dlbGxzQHJlZGhhdC5jb20+DQo+INb3zOI6IFJlOiBbUEFUQ0ggdjJdIG5mczogZml4IHJl
Z3Jlc3Npb24gaW4gaGFuZGxpbmcgb2YgZnNjPSBvcHRpb24gaW4gTkZTdjQNCj4gDQo+IE9uIFR1
ZSwgMjAyNC0wMS0zMCBhdCAyMzo0NiArMDgwMCwgQ2hlbiBIYW54aWFvIHdyb3RlOg0KPiA+IFNl
dHRpbmcgdGhlIHVuaXF1aWZpZXIgZm9yIGZzY2FjaGUgdmlhIHRoZSBmc2M9IG1vdW50DQo+ID4g
b3B0aW9uIGlzIGN1cnJlbnRseSBicm9rZW4gaW4gTkZTdjQuDQo+ID4NCj4gPiBGaXggdGhpcyBi
eSBwYXNzaW5nIGZzY2FjaGVfdW5pcSB0byByb290X2ZjIGlmIHBvc3NpYmxlLg0KPiA+DQo+ID4g
U2lnbmVkLW9mZi1ieTogQ2hlbiBIYW54aWFvIDxjaGVuaHguZm5zdEBmdWppdHN1LmNvbT4NCj4g
PiAtLS0NCj4gPiB2MjoNCj4gPiAgICAgdXNlIGttZW1kdXBfbnVsIGluc3RlYWQgb2Ygc25wcmlu
dGYNCj4gPg0KPiA+ICBmcy9uZnMvbmZzNHN1cGVyLmMgfCAyNCArKysrKysrKysrKysrKysrKysr
KysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDI0IGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRp
ZmYgLS1naXQgYS9mcy9uZnMvbmZzNHN1cGVyLmMgYi9mcy9uZnMvbmZzNHN1cGVyLmMNCj4gPiBp
bmRleCBkMDliY2ZkN2RiODkuLjRhMjNkOTE0M2Q1YSAxMDA2NDQNCj4gPiAtLS0gYS9mcy9uZnMv
bmZzNHN1cGVyLmMNCj4gPiArKysgYi9mcy9uZnMvbmZzNHN1cGVyLmMNCj4gPiBAQCAtMTQ1LDYg
KzE0NSw3IEBAIHN0YXRpYyBpbnQgZG9fbmZzNF9tb3VudChzdHJ1Y3QgbmZzX3NlcnZlciAqc2Vy
dmVyLA0KPiA+ICAJCQkgY29uc3QgY2hhciAqZXhwb3J0X3BhdGgpDQo+ID4gIHsNCj4gPiAgCXN0
cnVjdCBuZnNfZnNfY29udGV4dCAqcm9vdF9jdHg7DQo+ID4gKwlzdHJ1Y3QgbmZzX2ZzX2NvbnRl
eHQgKmN0eDsNCj4gPiAgCXN0cnVjdCBmc19jb250ZXh0ICpyb290X2ZjOw0KPiA+ICAJc3RydWN0
IHZmc21vdW50ICpyb290X21udDsNCj4gPiAgCXN0cnVjdCBkZW50cnkgKmRlbnRyeTsNCj4gPiBA
QCAtMTU3LDYgKzE1OCwxMiBAQCBzdGF0aWMgaW50IGRvX25mczRfbW91bnQoc3RydWN0IG5mc19z
ZXJ2ZXIgKnNlcnZlciwNCj4gPiAgCQkuZGlyZmQJPSAtMSwNCj4gPiAgCX07DQo+ID4NCj4gPiAr
CXN0cnVjdCBmc19wYXJhbWV0ZXIgcGFyYW1fZnNjID0gew0KPiA+ICsJCS5rZXkJPSAiZnNjIiwN
Cj4gPiArCQkudHlwZQk9IGZzX3ZhbHVlX2lzX3N0cmluZywNCj4gPiArCQkuZGlyZmQJPSAtMSwN
Cj4gPiArCX07DQo+ID4gKw0KPiA+ICAJaWYgKElTX0VSUihzZXJ2ZXIpKQ0KPiA+ICAJCXJldHVy
biBQVFJfRVJSKHNlcnZlcik7DQo+ID4NCj4gPiBAQCAtMTY4LDkgKzE3NSwyNiBAQCBzdGF0aWMg
aW50IGRvX25mczRfbW91bnQoc3RydWN0IG5mc19zZXJ2ZXIgKnNlcnZlciwNCj4gPiAgCWtmcmVl
KHJvb3RfZmMtPnNvdXJjZSk7DQo+ID4gIAlyb290X2ZjLT5zb3VyY2UgPSBOVUxMOw0KPiA+DQo+
ID4gKwljdHggPSBuZnNfZmMyY29udGV4dChmYyk7DQo+ID4gIAlyb290X2N0eCA9IG5mc19mYzJj
b250ZXh0KHJvb3RfZmMpOw0KPiA+ICAJcm9vdF9jdHgtPmludGVybmFsID0gdHJ1ZTsNCj4gPiAg
CXJvb3RfY3R4LT5zZXJ2ZXIgPSBzZXJ2ZXI7DQo+ID4gKw0KPiA+ICsJaWYgKGN0eC0+ZnNjYWNo
ZV91bmlxKSB7DQo+ID4gKwkJbGVuID0gc3RybGVuKGN0eC0+ZnNjYWNoZV91bmlxKSArIDE7DQo+
ID4gKwkJcGFyYW1fZnNjLnNpemUgPSBsZW47DQo+IA0KPiBJbiB0aGUgb3RoZXIgcGF0Y2ggeW91
IHdlcmUgc2V0dGluZyAuc2l6ZSB0byB0aGUgcmV0dXJuIHZhbHVlIGZyb20NCj4gc25wcmludGYu
IFRoYXQgZG9lcyBub3QgaW5jbHVkZSB0aGUgTlVMIGJ5dGUuIFlvdSdyZSBpbmNsdWRpbmcgaXQg
aGVyZQ0KPiB0aG91Z2guIFdoaWNoIHdheSBpcyBjb3JyZWN0Pw0KPiANCkl0IHNob3VsZCBiZToN
CmxlbiA9IHN0cmxlbihjdHgtPmZzY2FjaGVfdW5pcSkuDQpwYXJhbV9mc2Muc2l6ZSA9IGxlbjsN
Cg0KZm9yIGttZW1kdXBfbnVsIGNhc2UuDQoNCldpbGwgYmUgZml4ZWQgaW4gdjMuDQpTb3JyeSBm
b3IgdGhlIG5vaXNlLg0KDQpSZWdhcmRzDQotIENoZW4NCg0KPiA+ICsJCXBhcmFtX2ZzYy5zdHJp
bmcgPSBrbWVtZHVwX251bChjdHgtPmZzY2FjaGVfdW5pcSwgbGVuLA0KPiBHRlBfS0VSTkVMKTsN
Cj4gPiArCQlpZiAocGFyYW1fZnNjLnN0cmluZyA9PSBOVUxMKSB7DQo+ID4gKwkJCXB1dF9mc19j
b250ZXh0KHJvb3RfZmMpOw0KPiA+ICsJCQlyZXR1cm4gLUVOT01FTTsNCj4gPiArCQl9DQo+ID4g
KwkJcmV0ID0gdmZzX3BhcnNlX2ZzX3BhcmFtKHJvb3RfZmMsICZwYXJhbV9mc2MpOw0KPiA+ICsJ
CWtmcmVlKHBhcmFtX2ZzYy5zdHJpbmcpOw0KPiA+ICsJCWlmIChyZXQgPCAwKSB7DQo+ID4gKwkJ
CXB1dF9mc19jb250ZXh0KHJvb3RfZmMpOw0KPiA+ICsJCQlyZXR1cm4gcmV0Ow0KPiA+ICsJCX0N
Cj4gPiArCX0NCj4gPiAgCS8qIFdlIGxlYXZlIGV4cG9ydF9wYXRoIHVuc2V0IGFzIGl0J3Mgbm90
IHVzZWQgdG8gZmluZCB0aGUgcm9vdC4gKi8NCj4gPg0KPiA+ICAJbGVuID0gc3RybGVuKGhvc3Ru
YW1lKSArIDU7DQo+IA0KPiAtLQ0KPiBKZWZmIExheXRvbiA8amxheXRvbkBrZXJuZWwub3JnPg0K
DQo=

