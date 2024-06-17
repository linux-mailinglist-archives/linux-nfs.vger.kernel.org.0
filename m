Return-Path: <linux-nfs+bounces-3906-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5B790B398
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 17:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C281B28111A
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 15:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B9F156C66;
	Mon, 17 Jun 2024 14:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usask.ca header.i=@usask.ca header.b="iVNjo1W8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from CAN01-YT3-obe.outbound.protection.outlook.com (mail-yt3can01on2103.outbound.protection.outlook.com [40.107.115.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD65156C4B
	for <linux-nfs@vger.kernel.org>; Mon, 17 Jun 2024 14:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.115.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718634650; cv=fail; b=p8eYRYzah/KJvLvey6XjTmL0YFd0wIHllY/Mig6OG17atkuEg/CbYZNxAltZVKawYOwG12TuG7Mbh1SE0AP+qANjNSmpFIlFtIf3PWJvCBhu2yY2TV+fZDXZu+kryhzP/ypjniwOIdKkjvBFGIFTEOu5A3QJqbIP7i1dZI+h6QI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718634650; c=relaxed/simple;
	bh=kCjT6wWVPU8JwffonhlAQCqCGjU2CsXAHAYSLeu9TbU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=svs7jTuDwbd5Xj1cLHjiaY5H9Rx6JojV8I3OGio4ihQOJZ/J3ae2pZFXSpl5gweELRAZBUXePVzVZNgAUP3vc0/tMvVBPpO/PHaJB/oSQMv/DL6iS6AriJMf/ajGJdXJhEzCcK7jjU1oVMejIauiCR/gSMT12364tOHhxjfbN9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=usask.ca; spf=pass smtp.mailfrom=mail.usask.ca; dkim=pass (2048-bit key) header.d=usask.ca header.i=@usask.ca header.b=iVNjo1W8; arc=fail smtp.client-ip=40.107.115.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=usask.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.usask.ca
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SPnUtAq48C9tYxGvVN5nCekkFuK6SKFW7RgHqHP3dkrZtlhFp3qKduUEuuzzK7c+5khwLNe2UFrOFWNJ33BtROWPQoP1UDJ4fW8snmyDx0Vjv+4wQMq1T8rQXMEWBwgJ64pi/DoU9KnrBTqYangyW+vBkGU+SGr2mxfBnLR8cMVDYvYBGnUSjEQtlogG+H+RbkTmvmDcuJHQDYYPsJdO9wU5uRiSNpcOKEvTm0oSJplqRq1/1CbhX0RE03v/Ke//0hdC+6XZM72LaNA+/xKmmtyS3I4jlGVvzp4IETqVFsfWncN4dOC5zbfeO0MXUOl2tgLvjhcuRzNN6euUSBhCLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7QqwBDyuiIcbzhZJUjhhZ5JtxFsmUJeWTdkzOYO4KH4=;
 b=A8jRH8/lDFGoxA6+U7HLGUZVdZnhvrb++a2MvDJWAuW/rN83V0CXImmjKzZsdObObHadfc1NSvF0cCCJ4gJcirGIzzCurnS3CLz9c3RYyDLaRmp5xaGYDwarzwyQ4G8nHWPPOdqhKPQDVnXtcdTBBv8REaINrjcWN0v4q9ZGh5eR0G+/j1A5T+lrAYXGcBpTxpLv0mqDA7t09FLa1GP8WJb/1/x4DZjE9DsLbMZX6gQmgya7ZGljNSSx5WtLOeCyXkeFzSmkKlC4bmss+DHE9SEmDJw5Afbs9ynLBwBvxkb+Le5mB4PsX0QekHYyBnrB3zC4N9w9mdrvVmWvmMhPuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.usask.ca; dmarc=pass action=none header.from=usask.ca;
 dkim=pass header.d=usask.ca; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=usask.ca; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7QqwBDyuiIcbzhZJUjhhZ5JtxFsmUJeWTdkzOYO4KH4=;
 b=iVNjo1W8CCNLVU35QXYkpC21R0RGKODlwTS4q7NE8yQBujoITnBLWSDi/rhnyDtFNaQkNX4Nrr+7qbtwG7lxf9O8VvLkDDDIp8SMGixsByUONQ7SmOsjWWu9IWY2zdOylglZDSHBmU/efIt8FaElVLCC9lewjUvZhvlTcNOW5pDviFO2CNVcRxfWvO21IDHTs1Ng2Wx14LGS9V3BDsM7iCI9uDJidyShIvggHGjLiQByT4kjmy27NSh69H565ruRgZlUE2UzTDCuNwU44S0l5VUjc3UwDRnAQf1hspRVx/daTlbxHHITjo3TtB5hwNoBCHBJSff+QRqhxzXZNyiWtg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=usask.ca;
Received: from YQBPR0101MB6200.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:38::6)
 by YT2PR01MB10419.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:df::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Mon, 17 Jun
 2024 14:30:46 +0000
Received: from YQBPR0101MB6200.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::94df:38df:6872:f321]) by YQBPR0101MB6200.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::94df:38df:6872:f321%4]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 14:30:46 +0000
Message-ID: <7d22bde9-0266-4be9-9c07-34d131d5f44c@usask.ca>
Date: Mon, 17 Jun 2024 08:30:44 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: Seeing strange behaviour from RPC/NFSD on 6.6.7 kernel, looking
 for debug advice
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <8ac2bb6f-63da-412f-8469-2a5be823fa40@usask.ca>
 <005CFD98-CF5B-4A33-9AB4-43FBE1FD8762@oracle.com>
Content-Language: en-US
From: Chris Friesen <cbf123@usask.ca>
In-Reply-To: <005CFD98-CF5B-4A33-9AB4-43FBE1FD8762@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR15CA0051.namprd15.prod.outlook.com
 (2603:10b6:208:237::20) To YQBPR0101MB6200.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:38::6)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YQBPR0101MB6200:EE_|YT2PR01MB10419:EE_
X-MS-Office365-Filtering-Correlation-Id: 723f3a54-77ba-4309-524d-08dc8eda138c
X-UofS-Origin: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|376011|366013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eit4Q1pHeUc0T21TUE9vMXpXamdsME1sT0RhaEJLbWRZenkrQTJ5UitsdUdS?=
 =?utf-8?B?SWZUdEVtVS96cFcxcGlzSEFVWS9Hb2pPNnl2UjFtZjlEK2dQZFBPRVh4TmVn?=
 =?utf-8?B?RDE2NGV1aEhYS25mb0lZNzFvQTdGZHJsVFNBNUtWUTRMSkRkelNRV3hmQlZY?=
 =?utf-8?B?TFpzYjZQVFlrK1I0dTl0TERGVm0xNlFuMm81ZXljRFhwTEJOcjg2QkRhcHg4?=
 =?utf-8?B?ZVFIR3BOdStUVDcxWVFLMW12aWNDVFFjb0dEUEZ4Q0NqQlEwVHZ4d0llMXBO?=
 =?utf-8?B?WHE3c3ZzN2lYNytWNkdnN0hMNWJ0SmVDdFN5dHczbUZoOFI2RElRRDFmcUZ1?=
 =?utf-8?B?RFhSSEgrTnlQNmVNY1ZQUjVpZVRlMjRWMWNSVEZ5bHgvZmJKbHhxTER3ZWFl?=
 =?utf-8?B?Q1RyaG5GZ2UzWlpVT1phWS81bHZpUDgyYmpQMXYwd2J3TG5uYXNyWmoxQlZT?=
 =?utf-8?B?MlJiWnQwU253MkI2RTB6RU01RnViNW9uS3hEb0dqRDJwSDF5S3pBaHZvNDVN?=
 =?utf-8?B?MGI0dXpzYVIrTFNNWm9haUtCaVZjN0h3WU80T3NvR0pDL2FmRFRWUGpKOFdr?=
 =?utf-8?B?MEh6MVFvMTN3ZTZWenI5TkxLZDl5dWtidU02ZnlSUHJFbjdaS2x1dkZwVXcv?=
 =?utf-8?B?TDY3NlQ2UEkzbC9rVjgrOTFMQzZQY2V6Tmhwdi9CN1F0ZUtqcVNwU2ZWb0Qr?=
 =?utf-8?B?KzVQK3RiMkVuSGtuSzJoYzlWOGUxbS8zZkJjMkNURnNIOSsxUjRXT04vTFNa?=
 =?utf-8?B?ODJ5MEN4YmxEbGZLYzBNNEZuRjJvR0plaTcwR2xDS0o4THZuNXMxOWdrQXdU?=
 =?utf-8?B?YU1UQmlOb3EzejBaSktEeDg5VHd6N3pad2pJTmhtUEJqMEh5NW80ZWxta2NZ?=
 =?utf-8?B?cXZDdlJ1YjQ3dEFDdFFhVlQvbWhvdy9uaVpQSEZYbHE1d1JnejRGajN4R3NW?=
 =?utf-8?B?TjlUNDdtWlE3dDhueTlLb2hhdGpIbld0QzNHUExHQmRVQ0FlREdsbHJ5UUtr?=
 =?utf-8?B?Y04rSkphR2VkV0pPUjEwdHNmd29SNmNDYitJcForWWMzV1hxNEZFTHgvYzhz?=
 =?utf-8?B?QTFrOUNEK0YrNnA1M1BkV056b3JTVXBpTUJKTUVuYTBqczU4UTg1L3RrT1Bu?=
 =?utf-8?B?dTdJRE90QUJWZ01uQ0ZRYWMyRGVzQ0RKV2VQelR2MDhJdWhpUGRET0xWZkR2?=
 =?utf-8?B?MUZSaTFoZTlaWFdxN2VzNGxWcjFwQkZEczdtRGNrb2VrRy8rQzF4Vm1RNWll?=
 =?utf-8?B?TlEwcy90TEErVFF3WU5RQW84cFk0WEh6YiszbE9Fd3RKTUhScEdCS2p0TUZR?=
 =?utf-8?B?c09TRkxYWE9SbmRsMHNoMjMyMFdJWkRYZ21OUkIya1BIVWNjWFF2TENjS3FT?=
 =?utf-8?B?cEo3Y3FPVjE3WU43ckpFVTY3MWx2MzhTaDJMTS9JWGxLNS9iblhKdmkwMTRj?=
 =?utf-8?B?SEYrVzdnUUh2S2dCaXYwVmlhZlF0NDg2QjJTV3Zjdy9sYXk3d3dWbFNmTXBp?=
 =?utf-8?B?MkMzMWdYTWtDd0lVWTZ3UUI1T3ExSVJVeHdRaWVoOEtyVWJrZDZTcXoveUFj?=
 =?utf-8?B?MHE0bnZMVjN6eklwTWRscmI1c2VmUzdPVEkzTG1Tdm1FWVdsSTJTbStQdzl0?=
 =?utf-8?B?SFlGZjhTOE5jNzkvWHB0OTZuSnV1eHNxaTZaSDBZdVZUVlQ2VXFRZEs1ZTR2?=
 =?utf-8?B?dVpFZ1BuaGdtc21iOVBOK0p0RWUvNGtHd3FOUEZ2M2ZUMWl1NllvV3JRSjF6?=
 =?utf-8?Q?0v/tmIdShlR4PeixO10AZoOOeTswb4hJQhB1sGc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQBPR0101MB6200.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(376011)(366013);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bmp4cmEvVERQSkwvbThWT1NaMEtPZDErMzAzMjdNMHJicTU2TjB6NHBwOEU3?=
 =?utf-8?B?WHdZSkU4eEtKS0xoSHp3cjVrYkVQUXRzRE9LaEM5M29wM2lMeTlkeXpVMmhF?=
 =?utf-8?B?cHBYK3lvUjU0dFNWWjBCWlU1S3NvWXZDUU9NWTRYRE1WdEtsRXdHRHVHbVA2?=
 =?utf-8?B?dEhNYkV3SVFkOUpBUzJEY0dJc3MrMllabWthaUpLZFc0NTJJYkErNk5tSlFN?=
 =?utf-8?B?VlZPN1ptbmt3T3hYUVB2MGJkdE10OEVJb2doL1o2YStWMW9JejVIdDRsbUV5?=
 =?utf-8?B?WlB0bVZvQVhxd1JBNXBtaWxPZnlkZFBoZmx1OGtVQ095U2ZURkZHOVRQWmM1?=
 =?utf-8?B?TzNscFlPUWRpQnV6d2hERm8rQnhKY2gvNWdYbWFUWTRqYk1MaDNvSFc4Nlo3?=
 =?utf-8?B?TEl1UDJyTS9QekFEelBPb3Nnc1ZzWWtjZHd1YVExS0F1dVE0WFdHWUlxbm1k?=
 =?utf-8?B?dkhCVVlxbS9nN2RvVmZiNUcwRHlkL21HaGoySFFnc005WUpyVWNqcmY0OWlq?=
 =?utf-8?B?d2V1ZVBOOU9vbXhLbUtEa2JycnN1dFllSmRiTmM2V1hMYnZrZDJmKzhPT1py?=
 =?utf-8?B?Y2U0b2VoNDM0UFpFdWRlbDVvYXdWbzV6NmhLU0Q1M01DQndTR2pXNjJuTmUz?=
 =?utf-8?B?NlhoSyt3dEFrNHhBT3B6RDAzMmZ2RENlYlJjSlkyLy9uYm5NTU9yTkF6bFJ3?=
 =?utf-8?B?TWRQUG0raDhiK1BUelRRWUpRUmRqQU5lSWZhR25XNkZEY0RPQ3lDNXhYMWVC?=
 =?utf-8?B?SUs2K055dnVrSHQ1TTBqVjZ0Nis1ZXByZVZSVkkrSDFvQjZJRml6bFRaQUZV?=
 =?utf-8?B?QjNHYXA1ODRGS3V1d0c0V1Y5YTUyNlI3S01oaGI2dlBHb3h6NE9Sb04zMVRk?=
 =?utf-8?B?QUlhVFJIOE5DcXlxTGQzMjJaalRqb2NOdGlRZnEvM3JSYmk1eHFQYWlCTTJ2?=
 =?utf-8?B?dE4yZ2ZLRFVnVEsrSTdSM3pKT2diVm9PZ00xN3BzRytiLzZoTDlPVUhHbCtN?=
 =?utf-8?B?VkRDdHI2WCszRjdPN09iY0pidU15VjkwckFhYVZSbjF4cGtIMjlvMjczQVFT?=
 =?utf-8?B?KzVPeDhnS29jaDV2T3RmbWJlQTA4bm5jQlQ4dWk3bXlaSlU2cm81MDA0NzM5?=
 =?utf-8?B?ZkpaMnFkUDQ3LzlWVWtTRnBQMVVhSWJJT3hyV0pUWVEzMHhDWkxiYkVRUHl6?=
 =?utf-8?B?cFk0Y2hWejlwQi9ncUtmSjJRZ2EyRXRJT0VDR0dPbUJuaHFoSTZPNTlZV3U3?=
 =?utf-8?B?Qk5vaEZIaEtxekpLd2xPYTZaVEo4VGFYb05lR3pIei9YOUZsTXByWnVzQSti?=
 =?utf-8?B?Qkluc3Z3bVJZMnZhN1U3N1lHaG1NenErU2ZBelF4MkRGM0tRNUZPWk1mUmdE?=
 =?utf-8?B?VHhZcjFUOWFRVXY2eVVndUUzR1o2UGtvRWYrZjFYdHg0WlRMajlCUVJOT2Nh?=
 =?utf-8?B?NVRHZU11UzlOY2lYMGJRRlpVOFVicnJ4RlQwT2dFMHlVSUhLOGNTTEFieWhS?=
 =?utf-8?B?NnJ3Ly9LWElPNnlsL2hySTd0TFV5dkMxaHQrSlhMMHM5VThzdmRZZzhVK2k3?=
 =?utf-8?B?Vm1ZOUJBZUVZMHp1RVJqbFNyZGd2VE9HdHlYa0Y3ZTBzUXpiOXNZMU85M1hk?=
 =?utf-8?B?UzJhRi9nQVMyV1oySzB3RUxtUGNId0NFQW5GbFlUd3FHVSthMVNFaTJ0WUtz?=
 =?utf-8?B?b3BEMDdTNEhnNFRheURrcVB6WW85eWlpY2JIUjF2YTVHaXNsVU9kcXlqMkp2?=
 =?utf-8?B?c2dsRG1BOUcwMFRMTHZqOWl3RGJQSms0eWFyK1k4WHhIRjh6VmIvVzF2NCtU?=
 =?utf-8?B?REFNeVVvUVE2aDAvalkrZVp0alROMm54bWpJVGdwbGNyMi9UeWgwSWV5Y1lS?=
 =?utf-8?B?bUptc3luUVpFZ0ZPZ0oxV3pYTGRJWXQ4Y0h3Q1BIU1E5T3ZObFpCcktYNHgv?=
 =?utf-8?B?WDVnc1U0cVFNektwM1RoMmJRZ3F0STJ3bVZVUWNUbXlRRUQ0YmQzUTY5STBT?=
 =?utf-8?B?RFFnc0IwVG1waHM1TFdSTDRIUUFnakpLK1d0cjNNTk43V0hrRU1FL3ZOQktO?=
 =?utf-8?B?SEN5NldIL04zbkczUlpSWmFZR1Jya2liV0Yrbno5V0hJUkJ6dW4vYWRSdE5C?=
 =?utf-8?Q?6fk3j93NENYTGy//3Xm9Bgh53?=
X-OriginatorOrg: usask.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: 723f3a54-77ba-4309-524d-08dc8eda138c
X-MS-Exchange-CrossTenant-AuthSource: YQBPR0101MB6200.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 14:30:46.3961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 24ab6cd0-487e-4722-9bc3-da9c4232776c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Io8qq9l/7qAhXv6O9rMWGLZM+gaskfm1L7PeeClDQshORfwttjQsq5qjhCj5o+gS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB10419

On 6/14/2024 7:09 AM, Chuck Lever III wrote:

>> On Jun 13, 2024, at 6:44 PM, Chris Friesen <cbf123@usask.ca> wrote:

>> Anyone have any ideas what might be going on or how to debug?  I'm building a kernel with CONFIG_SUNRPC_DEBUG enabled to see if that gives anything useful.
> 
> linux-6.6.15 has "SUNRPC: use request size to initialize bio_vec in
> svc_udp_sendto()" which might address this issue.
> 
> 
> --
> Chuck Lever

Yes! Thanks for that, it did indeed fix the issue.

Chris


