Return-Path: <linux-nfs+bounces-11388-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20CA1AA78AA
	for <lists+linux-nfs@lfdr.de>; Fri,  2 May 2025 19:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78FD34C5E30
	for <lists+linux-nfs@lfdr.de>; Fri,  2 May 2025 17:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A548F1A23A2;
	Fri,  2 May 2025 17:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nwra.com header.i=@nwra.com header.b="rvc2tkkx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from BY5PR09CU001.outbound.protection.outlook.com (mail-westusazon11011040.outbound.protection.outlook.com [52.101.86.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CCC25DB1B
	for <linux-nfs@vger.kernel.org>; Fri,  2 May 2025 17:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.86.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746207006; cv=fail; b=qw8UqD+w/1xWcBJ5yb768c0BmZ+lApV8BqHMLSx8eivuCgSVxIHrNhnYqtLn2Ryxk8Hvm9OvplUofO++++pzsmgYgXhaqN0HoV5DJEhHcjy5ZSmuTk13dQ2TLUWCyMB91nwi51LmsUVa3QprTE6fbIE23eNZgqUSEdTN4d5Admc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746207006; c=relaxed/simple;
	bh=RjMd5cEDNg1ZjMQZARdN4bU1bFZx8RNs+TN+lauAn5k=;
	h=Message-ID:Date:To:From:Subject:Content-Type:MIME-Version; b=NDUqRBOgoSO1bxQMlzdc95OU8pl8FpVucJa3KWOkauStahZG5y5lHV6ARtK66Se68OOkki9VJ/1/zih4/b+cU9kRBAp9He3W/toW1QOLhNFmJHvU4Y3f7ajybSNEkf5r4VjkM39DYHhKBceomyVslOaME95FTSXZ7wmVPoIky2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nwra.com; spf=pass smtp.mailfrom=nwra.com; dkim=pass (2048-bit key) header.d=nwra.com header.i=@nwra.com header.b=rvc2tkkx; arc=fail smtp.client-ip=52.101.86.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nwra.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nwra.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BrlvH+iWFPY2WRlbMivymLnJrE3Q8tfov4IvXaKGHK0IMrvG6Glv9P4Zo1n5Fg7U8RTRv++HZoleD3xUfqftpYk//EKPGKyFa4az8+bkB9zq1zljDIBAcXcA71MywT+48U6isttXNG3ovX2nGqFb2yqWt/uogvWKHRJZQiW1HROKKs5ItfKz35jyFRBpP8CWVU2/rwCNbRf7Xlp/HcaKcg5kRhu7w7VWhDu+wFVYPiq5AsCIQWCOS3n7Tmq20aYcszmtTz0CwmSbq3iI0wANc6wifYPfNzeiy5Xs99/eVxmc0kk3Nebxke0FBziC2fevIHWeyeeYobUZ6Qmnmq+i+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jbI+InDHLOtPGlASWWRrrajv/tXSir+PfdG5zqjX3FQ=;
 b=DsN71plJ/ZHteBBITNl75lD879j2p6Cji57kjkvLGEkkBldXZ+6k+yUxWeemdd/UWJsd5H7WvMRsfAo+c6ZrP+fZKcG9NIrKMj3XlxElD9hAitcq9YzWpvCRkGP+PMJAuDw8tnTSk3hjL7Zn8u9K3o6t+T5fIJMd2bQW7sxK4QrwhBvecAF9jrblCLw3csGrxsagi0nKqiAxkVgpOng6TckToeqy2sBORf7vDPP72VRya13EX2+mMUbOb8NN6cI/7xml9wESDmITihtaGjfh8AElkO8d/isEW2xqkZ8JH+lCwVteyT1cXoNH9/YIFeGxM1vQhUxZm8NWaW26J2WZcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nwra.com; dmarc=pass action=none header.from=nwra.com;
 dkim=pass header.d=nwra.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nwra.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jbI+InDHLOtPGlASWWRrrajv/tXSir+PfdG5zqjX3FQ=;
 b=rvc2tkkxqsVMs1l39LrqfnqVK61RiDT8SbQ+mJXIiDVH/ASIt/BklJeQPb+ZvXBrBO512rgX11NaL7I8KEDnjTYU2m40+eqAIJCt5FUqcJcm5BWiM2h9kaAoE+acISr4X95xN+cMAOZ2PEiHIgVyrp/EE0W0clepRIXU1uV6ZTsObAjViLWcGGwzKJv0FGFhvyBwordK4j2gBdAKrr8TBdxgruqkSgxpwNbWaJMSsydtl8EmrpOmOiNloJV0K0wy27Go/eY+BU50DVyPOHPu9Uu3b2jwN0Oe8Rnlf8RyIS0F1jCcybbhwu9JXVbsbSBO/0NSWGoKH+brMxM2dvgAvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nwra.com;
Received: from SJ0PR09MB11875.namprd09.prod.outlook.com
 (2603:10b6:a03:51f::10) by PH0PR09MB11517.namprd09.prod.outlook.com
 (2603:10b6:510:2cb::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Fri, 2 May
 2025 17:30:00 +0000
Received: from SJ0PR09MB11875.namprd09.prod.outlook.com
 ([fe80::30e0:339f:805:2779]) by SJ0PR09MB11875.namprd09.prod.outlook.com
 ([fe80::30e0:339f:805:2779%3]) with mapi id 15.20.8699.019; Fri, 2 May 2025
 17:30:00 +0000
Message-ID: <c4ecc067-9a51-40c8-9300-29119ff2e1d0@nwra.com>
Date: Fri, 2 May 2025 11:29:58 -0600
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
From: Orion Poplawski <orion@nwra.com>
Subject: Trouble with multiple kerberos ticket caches
Organization: NWRA
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms030705000809060608070406"
X-ClientProxiedBy: CY8PR02CA0005.namprd02.prod.outlook.com
 (2603:10b6:930:4d::9) To SJ0PR09MB11875.namprd09.prod.outlook.com
 (2603:10b6:a03:51f::10)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR09MB11875:EE_|PH0PR09MB11517:EE_
X-MS-Office365-Filtering-Correlation-Id: d940d075-3fba-4107-5e1b-08dd899ef6f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|41320700013|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QUc1UGp4MWlrOW1yNEVFLy9iaVdkYWcyZUJrUyt5SzJJaXRjMy9jNjdhUDgy?=
 =?utf-8?B?dWRpeU1RN2pHQklaOXBoSnRHNGFYSG43WGd5bENzcGlSNCsvNE9DRkllYkxB?=
 =?utf-8?B?c2svQWNickxNdlpRV3hVS2VDQkoyM0NKdXRsdW5KYTdhNFU3RExETTRkSXRa?=
 =?utf-8?B?bStHdjIzcllXMFlHd25RQkY3NHdrNXJ3ZVpYemV1WndPU1dNcXc0T3BoREhy?=
 =?utf-8?B?S1ZqK0tnbjN1OVJ2T1A0Z2hoVDJOYm1UVlgrZDJzdkYvM3JWRkpXY2dUekZl?=
 =?utf-8?B?cXhyUW8wMzNpcU5WSFJUK2xPWGRCcDZncUt4RzZuRmUrY1p6UkJXaHJVemtw?=
 =?utf-8?B?bzdmWWVyV0VWVUVpTnA4R3VlekhMdnBSSGFkMzAwUG00UzFQZ1VVZWg0MVNC?=
 =?utf-8?B?STUraTdYR0lzUTBsSTgySy83cTRlZks4SVZpaVQrWnRmcVNMdHZ3bWNpaWxD?=
 =?utf-8?B?YXpnQXBneU1WZk90UGNpVFpDOGErRkVkdEM1aVNkMzdkNmltckloMkhQeXRa?=
 =?utf-8?B?LytsUXE2dmRUK2trSnp2bndxQ0JMZlBUclNRYUdzUGJzSmMxTG1nQ296eUlK?=
 =?utf-8?B?MXNsM3hwRU1QTTlNNWpBZEJLeUFaS1BPTXhucU9qL25BZFBWSS9PelJWcHdp?=
 =?utf-8?B?VzMxYnJOcURjbVlMd21GdHVRKzd1OHZQMDA4dmZEbnM2Z3dFUkpKenc1a3h3?=
 =?utf-8?B?VDNPbGNwbzEvcVBQcDYwSXZsR2Q0b1hab2tPVnhUa3IwTXRwTW5kZjI2U3BN?=
 =?utf-8?B?R1o3VEt3amxtVlRnODlzZzdvWU5GY2VRcHBaV2dRaW90c3JMc0dUSTVhZVdu?=
 =?utf-8?B?SUtCdUF0dFY5NGxYZmlidGE5enh4OU9mUmV0TjhXc0VHcVdQZ0syWDc0SjdV?=
 =?utf-8?B?U2hUVmpwbldmb2R5TlRpVmRSdnFCajRtcHlYaVZDUks0WE1kamhCN1M0ODdm?=
 =?utf-8?B?WDVLQXN2ME5Dc3ZpVEdoR1ZUYWF5ZlFwUStpaytkd3VXUXh1bTJmSjhTVWo5?=
 =?utf-8?B?MTNXT0k0bEpsK1A3VnoyV2ZpVkRtUUFZSTV5OEptL3d0ZC9NcTdqZmF5SXhk?=
 =?utf-8?B?K2NnUDA1ek1pSWM0UnRPRFFHSlN0WHdzZDYrSCtIOGFBU1NmaHErUFVKYWlx?=
 =?utf-8?B?R0tKbmtvempNYit4YjJFMXEwU1V5RHFrNnBrZ1BBbXh3Vy9NUXE4SG9zSlVq?=
 =?utf-8?B?QWxzYXcyU0FIYWtGZmFUMktUd28yRXVpQkdPK0Zuc1h6WjV6S0JYMzh3cVJa?=
 =?utf-8?B?ZUpwL0kxUlBtTGNDOTBlQ1NsanZmT1dtNHpoSFE2QWU3dHgxL2Vjc0hhd056?=
 =?utf-8?B?aFlrK1pOWUJ4dU1UNnM4azFoZlRwb3dhK2RzeUs2a3I3TGYxejQ0MktKSDUy?=
 =?utf-8?B?QUhQOTV3aG84Y2x5dElKNUdrTVVVVkpFZkhVYmZ1Mm02cEU1MjhyQUNNR0lF?=
 =?utf-8?B?c0EyUEdxNDNBbjNaZld5OThtZFNXVmhZVUFJcHhnN2VhbmlwRG16TmVQQ21x?=
 =?utf-8?B?akpRV3hlSXg4SEV4akt0K0c5T3lHNDZtZXBGYTB5a1FrbStWTmZxY1RUUjZS?=
 =?utf-8?B?eHllOE9Ib0JYVVdQU1BNc2lxcW93amhMcHlueHBTMlFXRXhnTnVCOWljeXZw?=
 =?utf-8?B?QkJjejVEOCs2Qzl5bEwzNVpkM1FPbXJPV3BLTy8wYXpNTXY5M2lCRDZrRWRF?=
 =?utf-8?B?bHJheDM1UzI4ZXVhbytIbnEvWXkrWEUzQnJSUDNsMTRHVHRxQnhEaEd3NXFM?=
 =?utf-8?B?VXZJd29MZC8zaE5pODY2Wndrb1Y3MFZVNlAvd3dmdldaZ1Nra0ZGWElrcEdZ?=
 =?utf-8?Q?KwsVOW0fLm44EZxe88GZZxP2iztRrc3cmF9i4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR09MB11875.namprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(41320700013)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QXBFVllITDVqS2JXbkROSjhlN0FxV1FGeWNFQzI0MkNoMnNGeVlOTHJyVDkz?=
 =?utf-8?B?Zm8yUWpVeDl3UDI0WnVCLzd3N3RGS3A2SjV2bHlCTkVMaE1PT1BHdkdWQjN3?=
 =?utf-8?B?K01XbmxTWVQvbEU4RUtkTG5ZS2RnRklrNGlhMHpNL0EzMEpTYzNvVUxHcHJK?=
 =?utf-8?B?dDB3UVBZMjlOYXMzVk5rRXB4SVpnZDV2d2xjYTJDVDlVOGcxTzh2VlF0RHBM?=
 =?utf-8?B?T1hESm5EbEtnNjNOanF3amlFWFpmS2ZPV0FMMGIrTDVhb2JSQ1BqSnhGKzls?=
 =?utf-8?B?VlBQanIrakE5aVA5RzRzendSU3JZRll1VEhFb3NpQXBDbVUxcFljZVZPckNZ?=
 =?utf-8?B?STNmSForVTA2YjNsWm5ETU9tUW5WOWRuN0o3ZThydG9XZGZiR0RkV0cycDNs?=
 =?utf-8?B?TVFZS3pGWWtRTzRJeWVENUxXR21iSTRsRVIwcU5KejZQdUk0UldBdTFTemVT?=
 =?utf-8?B?NlJMR1dtTGROSGFKRnQzanlrbDFnWWVpMjJQR3lLR0pzQ3FyUkQrNG5KZVZt?=
 =?utf-8?B?ZEMwOHR3dFFRRzBhWWorSlFMbjRBK2tXNFM5a3ArTVRkcWhWVzRyRFVWcU9v?=
 =?utf-8?B?TkRsTVhmRXRqb0cycGlheXVQRXAva1JDZFlFK0pkeVdaZmZ5SHpLVDBWSjNw?=
 =?utf-8?B?akVlM2RWOFp2aENCRWJqaFM2b3hlTFFCNW5tRks1ODNEWDVjWnRKQnpXS0t0?=
 =?utf-8?B?d2VJYzcrZnJ1eGNpRTVEWHVFZ3k3RFZtN0VSdHh4Mk1tb09ralF0TXFtTm5Y?=
 =?utf-8?B?aUZNcXpTdnB5UUthdXpUTnFtbW5ENzF5dG4wYURWMFlRdWpKbENKZmlPQ0xm?=
 =?utf-8?B?MmZTUkdHTDI5OXQ2Y3lXUEJQbUY2MXFjZ1NYKzNOZWoxL1hvWUtmUExobERk?=
 =?utf-8?B?MlRqVjVMdW1VYnR3QW1pSnlrbFNRdVRYcTViNTlGK3ZONmJ4Y2gvNndKNWlZ?=
 =?utf-8?B?bmJOQzJEeWtIZlptdFM3ekNMKzg5Q2ZZNmdBYjJxYWtyb1I5V2l3T0ZYbnQy?=
 =?utf-8?B?L3JMbGM0Q3RrNllEZ2J3bXdhWURNdEpraGk1RzdtNnM1bDBJT1kvR2JZb1Ba?=
 =?utf-8?B?bDBrYXhCUE9FTHQrZjE3cFRSUG5hSFE0QU9Pd2hmM0lONnNGbWpycW9mcHhV?=
 =?utf-8?B?ZUg2WW9HYUtzdUFlRko0RWwwWjZ3TG5ZRHg1c01ubFhjTFFsNkJ0S0REdy9E?=
 =?utf-8?B?akhwazBIOWNFN2MvQmF4MzF0blFDQjdEQXRKVzRQVWF0QTNHTTN4K0ptWnRD?=
 =?utf-8?B?NFlvVFk0OHpzYlV3OGNBcndaL3EzK25rbEZYM0FBMWI3MFIzVlp6dlFtSWJj?=
 =?utf-8?B?VG5OOFc1RUpvWHR0WFJBcyt4cDBIb1BZTWFaZStsMW5taDBneHk4SkZqaVRX?=
 =?utf-8?B?ckpldW1CZjlaTGI1b3E0TmlwWVlOcmxPNFdMc1ZCYSt4aGVMWWt0cnpNaEpp?=
 =?utf-8?B?NVBMTzM3NXZBYVVlQTNVWUw2ZEh4Q1JMNkdzL0lsOStVTERUTys2YkI2anJ5?=
 =?utf-8?B?QWJmUEh3Y3pSUHlsSCtDeFlvQmowUzlhQlJ1RGg2SWltWFdlR2tZaktBTEVR?=
 =?utf-8?B?SGM2ZGlqaG5oZUQ4SFFHZGgxZkFLeW9VZ2VIeUd5dmhGWWxMUHhycFdWL2E5?=
 =?utf-8?B?UXRYN3EzVG05a3BuRWdPMTNoNnV5VENUMGxEcC8vSTNlcHhMUDdjbkZyazVJ?=
 =?utf-8?B?dnROYTl4aTl2ZG9RbkNaRzcvTWU5WngvZ3c5a1E1bWY1c3JjZkhZM09rUDdt?=
 =?utf-8?B?K2ltUFN3S013UGFzMUtLOWxURlN4eDFZOWpPcDVFK09FRkpOOUM3cit6cmRl?=
 =?utf-8?B?MVZjT3NoMEh4UkpZcVI3QVp1VHdzL2gveFJobFdwY3RLMGNDcy91dHFGS3BI?=
 =?utf-8?B?ZjJFaHdyZXZNOEVpOVNMQUFuQzVoZFpKMjRnYU45enZHaTNMdU1iWEhRNnlB?=
 =?utf-8?B?ang5aFVHbTM3RHZ3ZTh1K1dCMkV5a2dJQWR3WHcxNGF0d3NiSmtxRklDTEpL?=
 =?utf-8?B?VDhSTFMzdmJhdmJrTDVuelhkMkZkSWcrWWxoWEsyTDB3ZXlsSDhmSU9rc012?=
 =?utf-8?B?aDZaRVpOb0Uwc0lrWnBVK2dYV0UrRlR0bFRWUWVmSU11Y2JyVEY5ZXc0Qmph?=
 =?utf-8?Q?tQGySYxD15anfaUMVZ6gHMI9d?=
X-OriginatorOrg: nwra.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d940d075-3fba-4107-5e1b-08dd899ef6f6
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR09MB11875.namprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2025 17:30:00.1006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 761303a3-2ec2-424e-8122-be8b689b4996
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR09MB11517

--------------ms030705000809060608070406
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

One of our users is struggling with multiple kerberos ticket caches impac=
ting
access to NFS sec=3Dkrb5 mounts.

Because home directories are NFS mounted, we use GSSAPI auth to forward a=

ticket.  But then we need to kinit to have a long-term renewable ticket.

But we seem to be seeing that new ssh connections which create a new tick=
et
cache break access to the NFS mounts, resulting in "permission denied" or=

"Stale file handle" messages.  Switching back to a renewable ticket cache=

seems to resolve the issue.

Any suggestions?  Is this expected?  I would have thought that the nfs ac=
cess
would work with any valid ticket.

NAME=3D"AlmaLinux"
VERSION=3D"8.10 (Cerulean Leopard)"
nfs-utils-2.3.3-59.el8.x86_64
4.18.0-553.50.1.el8_10.x86_64

--=20
Orion Poplawski
he/him/his  - surely the least important thing about me
Manager of IT Systems                      720-772-5637
NWRA, Boulder Office                  FAX: 303-415-9702
3380 Mitchell Lane                       orion@nwra.com
Boulder, CO 80301                 https://www.nwra.com/


--------------ms030705000809060608070406
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
ClEwggUVMIID/aADAgECAhEArxwEsqyM/5sAAAAAUc4Y4zANBgkqhkiG9w0BAQsFADCBtDEU
MBIGA1UEChMLRW50cnVzdC5uZXQxQDA+BgNVBAsUN3d3dy5lbnRydXN0Lm5ldC9DUFNfMjA0
OCBpbmNvcnAuIGJ5IHJlZi4gKGxpbWl0cyBsaWFiLikxJTAjBgNVBAsTHChjKSAxOTk5IEVu
dHJ1c3QubmV0IExpbWl0ZWQxMzAxBgNVBAMTKkVudHJ1c3QubmV0IENlcnRpZmljYXRpb24g
QXV0aG9yaXR5ICgyMDQ4KTAeFw0yMDA3MjkxNTQ4MzBaFw0yOTA2MjkxNjE4MzBaMIGlMQsw
CQYDVQQGEwJVUzEWMBQGA1UEChMNRW50cnVzdCwgSW5jLjE5MDcGA1UECxMwd3d3LmVudHJ1
c3QubmV0L0NQUyBpcyBpbmNvcnBvcmF0ZWQgYnkgcmVmZXJlbmNlMR8wHQYDVQQLExYoYykg
MjAxMCBFbnRydXN0LCBJbmMuMSIwIAYDVQQDExlFbnRydXN0IENsYXNzIDIgQ2xpZW50IENB
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAxDKNQtCeGZ1bkFoQTLUQACG5B0je
rm6A1v8UUAboda9rRo7npU+tw4yw+nvgGZH98GOtcUnzqBwfqzQZIE5LVOkAk75wCDHeiVOs
V7wk7yqPQtT36pUlXRR20s2nEvobsrRcYUC9X91Xm0RV2MWJGTxlPbno1KUtwizT6oMxogg8
XlmuEi4qCoxe87MxrgqtfuywSQn8py4iHmhkNJ0W46Y9AzFAFveU9ksZNMmX5iKcSN5koIML
WAWYxCJGiQX9o772SUxhAxak+AqZHOLAxn5pAjJXkAOvAJShudzOr+/0fBjOMAvKh/jVXx9Z
UdiLC7k4xljCU3zaJtTb8r2QzQIDAQABo4IBLTCCASkwDgYDVR0PAQH/BAQDAgGGMB0GA1Ud
JQQWMBQGCCsGAQUFBwMEBggrBgEFBQcDAjASBgNVHRMBAf8ECDAGAQH/AgEAMDMGCCsGAQUF
BwEBBCcwJTAjBggrBgEFBQcwAYYXaHR0cDovL29jc3AuZW50cnVzdC5uZXQwMgYDVR0fBCsw
KTAnoCWgI4YhaHR0cDovL2NybC5lbnRydXN0Lm5ldC8yMDQ4Y2EuY3JsMDsGA1UdIAQ0MDIw
MAYEVR0gADAoMCYGCCsGAQUFBwIBFhpodHRwOi8vd3d3LmVudHJ1c3QubmV0L3JwYTAdBgNV
HQ4EFgQUCZGluunyLip1381+/nfK8t5rmyQwHwYDVR0jBBgwFoAUVeSB0RGAvtiJuQijMfmh
JAkWuXAwDQYJKoZIhvcNAQELBQADggEBAD+96RB180Kn0WyBJqFGIFcSJBVasgwIf91HuT9C
k6QKr0wR7sxrMPS0LITeCheQ+Xg0rq4mRXYFNSSDwJNzmU+lcnFjtAmIEctsbu+UldVJN8+h
APANSxRRRvRocbL+YKE3DyX87yBaM8aph8nqUvbXaUiWzlrPEJv2twHDOiGlyEPAhJ0D+MU0
CIfLiwqDXKojK+n/uN6nSQ5tMhWBMMgn9MD+zxp1zIe7uhGhgmVQBZ/zRZKHoEW4Gedf+EYK
W8zYXWsWkUwVlWrj5PzeBnT2bFTdxCXwaRbW6g4/Wb4BYvlgnx1AszH3EJwv+YpEZthgAk4x
ELH2l47+IIO9TUowggU0MIIEHKADAgECAhBOGocb/uu4yQAAAABMPXr3MA0GCSqGSIb3DQEB
CwUAMIGlMQswCQYDVQQGEwJVUzEWMBQGA1UEChMNRW50cnVzdCwgSW5jLjE5MDcGA1UECxMw
d3d3LmVudHJ1c3QubmV0L0NQUyBpcyBpbmNvcnBvcmF0ZWQgYnkgcmVmZXJlbmNlMR8wHQYD
VQQLExYoYykgMjAxMCBFbnRydXN0LCBJbmMuMSIwIAYDVQQDExlFbnRydXN0IENsYXNzIDIg
Q2xpZW50IENBMB4XDTIzMTIxNjIxMTUyNVoXDTI2MTIxNjIxNDUyMlowgbAxCzAJBgNVBAYT
AlVTMRMwEQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdTZWF0dGxlMSYwJAYDVQQKEx1O
b3J0aFdlc3QgUmVzZWFyY2ggQXNzb2NpYXRlczEbMBkGA1UEYRMSTlRSVVMrV0EtNjAwNTcz
MjUxMTUwFgYDVQQDEw9PcmlvbiBQb3BsYXdza2kwGwYJKoZIhvcNAQkBFg5vcmlvbkBud3Jh
LmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAKn5wO5Bjob6bLDahVowly2l
AyCWBHGRq1bSptv7tXpj+Xaci4zpCqRoyqX0Gjpo8BEulUYQK8b7nO7UM3aMLC8H6vyzQ64A
GupPGIKuJg+Qr8jA0ihCVH+duE0bNXfDPTm/8VsXOubmVLPLp0cejxzrEC/RI5l8rdl0sQ+2
QZp9jTlyghB1Rxt2AYVYhVVnRMSJ8RgKp9MLV3qIfHqF1k5MGBIP6rS1afmlGd/yW9IWSB8z
iASPtr/Ml5ObbxtYZG47kCKCS7RF2rI6rGNmK/R6cITRs37dzUfBmagDFV897wAW3tHTyLQM
4vobhmS2UYi8C5voc+I75LYOsvLaXHUCAwEAAaOCAVEwggFNMA4GA1UdDwEB/wQEAwIFoDAd
BgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwFAYDVR0gBA0wCzAJBgdngQwBBQMBMGoG
CCsGAQUFBwEBBF4wXDAjBggrBgEFBQcwAYYXaHR0cDovL29jc3AuZW50cnVzdC5uZXQwNQYI
KwYBBQUHMAKGKWh0dHA6Ly9haWEuZW50cnVzdC5uZXQvMjA0OGNsYXNzMnNoYTIuY2VyMDQG
A1UdHwQtMCswKaAnoCWGI2h0dHA6Ly9jcmwuZW50cnVzdC5uZXQvY2xhc3MyY2EuY3JsMBkG
A1UdEQQSMBCBDm9yaW9uQG53cmEuY29tMB8GA1UdIwQYMBaAFAmRpbrp8i4qdd/Nfv53yvLe
a5skMB0GA1UdDgQWBBSZhCz4u7bZ2JjPtNAM8gx3QVEp1zAJBgNVHRMEAjAAMA0GCSqGSIb3
DQEBCwUAA4IBAQA2L6VG0IcimaH24eRr4+L6a/Q51YxInV1pDPt73Lr2uz9CzKWiqWgm6Ioh
O9gSEhDsAYUXED8lkJ3jId9Lo/fDj5M+13S4eChfzFb1VWyA9fBeOE+/zEYrSPQIuRUM324g
PEm8eP/mYaZzHXoA0RJC7jyZlLRdzu/kGqUQDr+81YnkXoyoKc8WeNZnSQSL+LqRvPJCcCTu
JbCdd7C8zYW1dRgh4d9hYooUSsKTsSeDoRkFyqk4ZH0V3PFqa2HiFrdi8h3vpBX44VFddyaa
e+ekomLvvVZWGtJgXWr6VEBo8PTah0fw8BQjCIfFym44D9dulz1YW7E6FRPMSZ7x8X3UMYIF
ZDCCBWACAQEwgbowgaUxCzAJBgNVBAYTAlVTMRYwFAYDVQQKEw1FbnRydXN0LCBJbmMuMTkw
NwYDVQQLEzB3d3cuZW50cnVzdC5uZXQvQ1BTIGlzIGluY29ycG9yYXRlZCBieSByZWZlcmVu
Y2UxHzAdBgNVBAsTFihjKSAyMDEwIEVudHJ1c3QsIEluYy4xIjAgBgNVBAMTGUVudHJ1c3Qg
Q2xhc3MgMiBDbGllbnQgQ0ECEE4ahxv+67jJAAAAAEw9evcwDQYJYIZIAWUDBAIBBQCgggN6
MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDUwMjE3Mjk1
OFowLwYJKoZIhvcNAQkEMSIEIHWsMxXfljsIioWgrNlU+zsjaH7fKqFWElRt954B0++hMIHL
BgkrBgEEAYI3EAQxgb0wgbowgaUxCzAJBgNVBAYTAlVTMRYwFAYDVQQKEw1FbnRydXN0LCBJ
bmMuMTkwNwYDVQQLEzB3d3cuZW50cnVzdC5uZXQvQ1BTIGlzIGluY29ycG9yYXRlZCBieSBy
ZWZlcmVuY2UxHzAdBgNVBAsTFihjKSAyMDEwIEVudHJ1c3QsIEluYy4xIjAgBgNVBAMTGUVu
dHJ1c3QgQ2xhc3MgMiBDbGllbnQgQ0ECEE4ahxv+67jJAAAAAEw9evcwgc0GCyqGSIb3DQEJ
EAILMYG9oIG6MIGlMQswCQYDVQQGEwJVUzEWMBQGA1UEChMNRW50cnVzdCwgSW5jLjE5MDcG
A1UECxMwd3d3LmVudHJ1c3QubmV0L0NQUyBpcyBpbmNvcnBvcmF0ZWQgYnkgcmVmZXJlbmNl
MR8wHQYDVQQLExYoYykgMjAxMCBFbnRydXN0LCBJbmMuMSIwIAYDVQQDExlFbnRydXN0IENs
YXNzIDIgQ2xpZW50IENBAhBOGocb/uu4yQAAAABMPXr3MIIBbwYJKoZIhvcNAQkPMYIBYDCC
AVwwCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzANBggqhkiG9w0DAgIB
BTANBggqhkiG9w0DAgIBBTAHBgUrDgMCBzANBggqhkiG9w0DAgIBBTAKBggqhkiG9w0CAjAK
BggqhkiG9w0CBTAHBgUrDgMCGjALBglghkgBZQMEAgEwCwYJYIZIAWUDBAICMAsGCWCGSAFl
AwQCAzALBglghkgBZQMEAgQwCwYJYIZIAWUDBAIHMAsGCWCGSAFlAwQCCDALBglghkgBZQME
AgkwCwYJYIZIAWUDBAIKMAsGCSqGSIb3DQEBATALBgkrgQUQhkg/AAIwCAYGK4EEAQsAMAgG
BiuBBAELATAIBgYrgQQBCwIwCAYGK4EEAQsDMAsGCSuBBRCGSD8AAzAIBgYrgQQBDgAwCAYG
K4EEAQ4BMAgGBiuBBAEOAjAIBgYrgQQBDgMwDQYJKoZIhvcNAQEBBQAEggEAeyjvUN8Ilyxo
VO6fuhW/6xFzRdGE1EpYlgQy3rhNEpM0NH0tUPbkpHxI0hCjmIGxczSAq51gIqdxjZjuUH5i
TWJ88CKr2VAN4CtMTzjZcTGOCaCLrarG3bXgLpaKD2l+pM8hFsyuWqqBn7d+JqCYB7YvXVBH
uZpOWqbUXAPPzkFdm8O2eC0EWHtJBjR9mNgE0WnlijHiKzjg2t1bCQIzffvfV5TsEOuHzYUi
xpi1pNGuqn3pXgom9ei803xCeIs4waTyWsmWTRW+vcoN9fbfO709Hwx6zRg7V0XIwfn+TQ0i
HlRkt6C7UbLtOEF65R2WMms1/il98LSGF4AyWej/HAAAAAAAAA==

--------------ms030705000809060608070406--

