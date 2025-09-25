Return-Path: <linux-nfs+bounces-14707-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C2AB9F783
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Sep 2025 15:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1699C4E139C
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Sep 2025 13:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97EB4220F37;
	Thu, 25 Sep 2025 13:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="X9GpLEaH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11022104.outbound.protection.outlook.com [40.93.195.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36829218AAB
	for <linux-nfs@vger.kernel.org>; Thu, 25 Sep 2025 13:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758806016; cv=fail; b=YZAuAodD2I7xt+bn3LGelx+mn9K+f6QdufthRgxTiM81jRCdLmtOk/AqeHo3z0jQxQEvOoaC//ajqzHwQYyvYq9vY0sYVf1F8smBk54LAAqwkiz4YfSFEJjBEYysZdxQNB94db6vWMm+ufx+sFX3X8T/JU979VunOQJ8gwcMPPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758806016; c=relaxed/simple;
	bh=nrib7zE5inji3Xf3+m3pOj5VGYPpZ6Subg+Bwm97xyI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WGI6iRh4dnsiRmsWLSOGk8tBd4WjML5nmHa0NB4OHHWP2iFhXJrP1AS+nJVgmNx4i0JYm5TvpidmWzIWyaT5IfW/gA8v0728/7df90y03QQkEciXz0vueZ5fSg/zZRpjyCSdKaQYs7fQII61UcYVB5KX2jaAgq6GjIBsVWa21h8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=X9GpLEaH; arc=fail smtp.client-ip=40.93.195.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uyRjZQdQ6gOJzYKUg98l/zvyV+4ysD9vrlAQaKbVWC9ImaSWtpUbxLRdHNCmuFMaz78I7o3yUmkQY1JBprUYK07JuNmdygTlGwpnwLHZHDx+8NMyhaJYmmy2lTD4ckLn41MXz91yV13B07GG1n/rQWzOfBkeZmz4ueYEX0Jea6j3biFMqlTGtHuGpUxnUedacxwpS95Q1TAF5XCG+Uh5ixl1vkAsZFEcgH90xHdlldP8gFzlPMKVvuvN5LJaT4Crov3mXL0AmkFBg0I4Fw17dkyEUdNkWKzim9SWexh3TgAyIr05Y3BFevCraXvnXJbufxl6y7S3nGKwZPntVq4TDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dSu17wZqL8ht3kCOVfBreiI7rIEWjO5Szg6LAjwgoWg=;
 b=JJnvs6l1hgN/dgWN3+jRhQadT/GSBA2cl/m1wrypB4UfvP5IQWXgJQRorjqi1T+hvB5OeCH8JyVwD6QHSTOk/2//FczN14E20QitCLnaFMkq3ke7KYCfGZpgP79bmYJSM71TL/+buowBHOL3Ul13aDImk79MK+luSYT9Yj7jfiCxW4tVL1FhLdAzXdP/qKhbKwl/Ud8l8qZzL8h4y46ch+znNPT9UDzQ1TKzdqodXg2EFau/2vZne2eKQbQF2gJL8QOapc3aBAEgAnJ+tGhrMaHH79vvOUaJ63haYwY3SD/UTzcXgmv+4boLlTsCpsWkBza1ESwp0h87r2y/XADmkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dSu17wZqL8ht3kCOVfBreiI7rIEWjO5Szg6LAjwgoWg=;
 b=X9GpLEaHIlHsTsZvNjpG5X34AoMaS9q0+Mc8t3IGIVsHStJNNO+lxCZnayAn9WnHJlUOziVQkz2/AMR6vP7eQ0RtRJWYMaMv2B9n2jQd7wmWJg0SqaCK3C39Xab1PDsIdr6vZWnHgbu9cpFJ3jjkY9Io8zkTELLWCHN3mgT1lkw=
Received: from BN0PR13MB4696.namprd13.prod.outlook.com (2603:10b6:408:121::23)
 by SN4PR13MB5376.namprd13.prod.outlook.com (2603:10b6:806:20f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.11; Thu, 25 Sep
 2025 13:13:28 +0000
Received: from BN0PR13MB4696.namprd13.prod.outlook.com
 ([fe80::c2cc:45de:549a:ae13]) by BN0PR13MB4696.namprd13.prod.outlook.com
 ([fe80::c2cc:45de:549a:ae13%6]) with mapi id 15.20.9137.018; Thu, 25 Sep 2025
 13:13:28 +0000
From: Jonathan Flynn <jonathan.flynn@hammerspace.com>
To: Mike Snitzer <snitzer@kernel.org>, NeilBrown <neilb@ownmail.net>, Chuck
 Lever <cel@kernel.org>
CC: Jeff Layton <jlayton@kernel.org>, Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>, Chuck Lever
	<chuck.lever@oracle.com>
Subject: RE: [RFC PATCH v3 4/3] NFSD: Implement NFSD_IO_DIRECT for NFS READ
 (v3 and older) [Was: "Re: [PATCH v3 3/3] NFSD: Implement NFSD_IO_DIRECT for
 NFS READ"]
Thread-Topic: [RFC PATCH v3 4/3] NFSD: Implement NFSD_IO_DIRECT for NFS READ
 (v3 and older) [Was: "Re: [PATCH v3 3/3] NFSD: Implement NFSD_IO_DIRECT for
 NFS READ"]
Thread-Index: AQHcLYq94k/xAybMN0+rE8hKUKG9B7SjM0oggACt3kA=
Date: Thu, 25 Sep 2025 13:13:28 +0000
Message-ID:
 <BN0PR13MB4696CF0B2E1782D6D68F35288B1FA@BN0PR13MB4696.namprd13.prod.outlook.com>
References: <20250922141137.632525-1-cel@kernel.org>
 <20250922141137.632525-4-cel@kernel.org> <aNMei7Ax5CbsR_Qz@kernel.org>
 <19eef754-57d9-4fe4-a6e6-a481dcec470e@kernel.org>
 <175867132212.1696783.15488731457039328170@noble.neil.brown.name>
 <60960803-80b3-4ca1-9fd3-16bc1bd1dbd4@kernel.org>
 <175869903827.1696783.17181184352630252525@noble.neil.brown.name>
 <aNP8U48TjSFmRhbD@kernel.org> <aNQL3fFzFZIL3I4u@kernel.org>
 <aNQ-1OSG9Ti5XbUm@kernel.org>
 <BN0PR13MB46960E5A7E35265561C3BF478B1FA@BN0PR13MB4696.namprd13.prod.outlook.com>
In-Reply-To:
 <BN0PR13MB46960E5A7E35265561C3BF478B1FA@BN0PR13MB4696.namprd13.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR13MB4696:EE_|SN4PR13MB5376:EE_
x-ms-office365-filtering-correlation-id: 9b83e246-3ccb-4c2f-95e6-08ddfc35515b
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?ckZsbVNFZERqZUkxUHJwV29zb0w1Z2xncFYvMFlyai9yWGJ5NEQzdkhJ?=
 =?iso-2022-jp?B?T3ZwSTVZTzZnQ1NmMnU0QkdoMFdXbzZDZkdDS1VTcm94U3VvaytmREwv?=
 =?iso-2022-jp?B?SCs2Nm5ZUzB4MTBUOGFNVS9VMzV4dWFucVpyR2E4SnhURVorZDM2ZGl2?=
 =?iso-2022-jp?B?UmtGL2hHcmN6blVuaXhlOVBVblZBc1RybXE1T1FPSWd5dDZRKzY3N1Nz?=
 =?iso-2022-jp?B?bnRMbHpqZzNZeTNCSUxZZWYya1U1ZXoxODZybHpFdmRheWx5eW1lK0VH?=
 =?iso-2022-jp?B?NFZYeUEwaFNiTmZSRi9sSjFCT053YkRoNW1WNC9NdlJOVXlwek1iYUVD?=
 =?iso-2022-jp?B?K1NTVHdPUjN6WUU2ZUMwV2F3b2RPYk9DTC9KSXR1czJnTm95ZjF2amo1?=
 =?iso-2022-jp?B?T0k2Zlc2aXIyc1pZMEJHbjlCOTFTSTJ3N3UzeHNWVVJCZVhjTEhFWWth?=
 =?iso-2022-jp?B?WHNweVFkbEdlMVJvOElncXlJa3FkNDhkMHpvUFNDNWhsbmN2bHpVZjY5?=
 =?iso-2022-jp?B?VlJXaTJhZEE5SldIbW5qNHpnRHJsUEIwQjNYdXVYK3d5WmczeXVDWGdz?=
 =?iso-2022-jp?B?MzVycFFVaHdYbWk5M3dhV0NHZkRPL1NoS1dxTmNDNi9hNXNwL2tISEov?=
 =?iso-2022-jp?B?MEk3WjhrYjdjTkF2dG1ReXV2YVVaZWtpNzBNNlU0LzgrWW4xaFJwZWEw?=
 =?iso-2022-jp?B?UU84TFNLdk5FZE1iR0dSeWk2R1JBUmZ3c000eXYvZVkwTG4vcFB4VE1T?=
 =?iso-2022-jp?B?N09IZEg4RXl4RTVxNk85NW5PNi9kSnlJVHZvM21OcngwZ0JlQzZPNnFZ?=
 =?iso-2022-jp?B?RXgyejNycVlHV0p5V0F5Y05IT1preEFCV0lQanpiRWg0eWVLcTVmaEJt?=
 =?iso-2022-jp?B?WGJYUnRJbGQxN2J4L2JUc0NHTEpZUjgyRUoxb0pZaTVoeUhUTVZhVHMr?=
 =?iso-2022-jp?B?VE1Ha0ZRaVJvR2VudVcwUUJ6UHFjOE82SkFhMGhSSEwrSXhyUEd0ZFRV?=
 =?iso-2022-jp?B?MXlCVzNKelQxOXBRUHYzL3R6WnVKRlBBa0xvSGJXOEZMZFBrdXZrRHZE?=
 =?iso-2022-jp?B?WjI3cGVUS01GQkxFZ0g1TXVCRU15Nm01T1hkYjZPK2NUUUtFNzFDdG5r?=
 =?iso-2022-jp?B?NFRuQWFNbk5oL1k2UVp1VEs3bEp5S0lFdlRtblJ4cmgyZEpzeHJMSTBR?=
 =?iso-2022-jp?B?WHB5UDZvMHdqR3hwS2ErWEg0K3NOWUFSdmxmdXJudHZNS05RSmViQmI1?=
 =?iso-2022-jp?B?a2VOVWg5NFJUZ0JRRXZLQ0lEUk5lLzJ0dTUwS0RXZzZSWHBTQUdxWEgy?=
 =?iso-2022-jp?B?T2N6N3MwK0E5bE8vSjkwNW1qVVBuRjV1aEhsV01kUDNtTms0S2ZJZDFY?=
 =?iso-2022-jp?B?WUZvSEJxdFQzZ3drTEVIUkZMaVEyeC9GWUxyWDl3bXllZzNVNGErQ3B5?=
 =?iso-2022-jp?B?Q0VOOU1MTTVhaWlwTGtQdzlLak5ucTNnR08rWVpGTzFFV1czcERqbW51?=
 =?iso-2022-jp?B?RWtSSEJ5WEExcEZYWFIxelNwSldHelpHUTA4WkNheFlQNUFOaWt1cGRs?=
 =?iso-2022-jp?B?WEFJaWhTZFVONVlYK0RCSnpPZHdrczdDT3M4THppK05POTdiYXNpd3oy?=
 =?iso-2022-jp?B?RXVDTlVrcDdwZjBOVWU0UGFhNVZhaVVmdmVWUytWVHRURjBUUWgyOWZJ?=
 =?iso-2022-jp?B?d1p3WWwzcTdJUHNONmRWT0YzQkJiUEYrdjlYaXVPNDlHWTFLNFdYamww?=
 =?iso-2022-jp?B?QlpNZjlmNnNpRllFaS9JaUJEdXlpakpvZTJDcmMvN0VlVFFOQWFtT2Mr?=
 =?iso-2022-jp?B?cmpPaHZtbXVOMW1KdUsvUXRNOG95MDR3RWRBeUVDTDNFZVhBZURDVFZi?=
 =?iso-2022-jp?B?TWF2aVpTQURicmhVZUNXcUExZk5wVVpTZmhhQnV1TkYreVRwd1BxMmdh?=
 =?iso-2022-jp?B?M0FuMmFuTkxOYkJkZUtRZVl2bDZCWERmSWs1TnR6L0lHTUMzQmtxOWxw?=
 =?iso-2022-jp?B?SjBENzJTOExMSkJWOFpNTWYrcHZVbGh2RUZ6MFF5UHhNckt1cFJEa1Js?=
 =?iso-2022-jp?B?bnNvR3lWRENJell3Ly9Uczd4aG9xUFNkVU1aMUZTMzdlNllwcjY4Nmkw?=
 =?iso-2022-jp?B?Y0F1cUw1SWE5WnE4c2NrQU1JaElnczVnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR13MB4696.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?LzNCSXI5dGZaU3F0N2VvZ0FuNkV0dkt2d21OL1h2amJRczNMSDcvcTls?=
 =?iso-2022-jp?B?SjQrUUlyZ0pWS0UzZDhDelFPUGRuVC96NGtwY21kdTNJMVlyclQ0OUxu?=
 =?iso-2022-jp?B?ZHpiN2pCL3IyS3c2WGJLZHNvY0EvVkkvaVNMZVorbWVMRGdkRms3VUJo?=
 =?iso-2022-jp?B?b1RMZ0VXRlRGMjdDMGQ2R2tRUE1qdy82Y1U0cjZOQTJlVXEvalFTbzdQ?=
 =?iso-2022-jp?B?aStvcVlYWkdZUW5pMU9qemV0bWdXRXAyRnl5UExLazVsNkxIbjhTTjl5?=
 =?iso-2022-jp?B?MmZWUGFHWDBYc0Y3bmE5SWRBUmE2WTJDRkxoSTBhZEVGZk16d0pPb0hm?=
 =?iso-2022-jp?B?M2dYS3hOUm8wR2tnUkdJc1dSMlNiZGxrbFZXVUxLaENCajJKOWhtTDNU?=
 =?iso-2022-jp?B?WHZTc0Q5c3ArUUNyK2hCdkhwMC9UdTBDSXpyY2UvNEVoM0FtT0ZkelZN?=
 =?iso-2022-jp?B?Nk90Ry93Z0V4aUJ5S3FpVmF2eVhZOEozQUdRU2RNcmIwNE1nVTF1bXFN?=
 =?iso-2022-jp?B?ZVEyK0NvMmlaL3FLZlgzcmtLQWo3NitlRUM1d0Y4dUxQT2FwMktSOUl4?=
 =?iso-2022-jp?B?K1lZRjRIL0UvaXdXM2hhWkZSNXBULy81eWFXUTFFQTRpYWlOWittNHNC?=
 =?iso-2022-jp?B?clZZMW9ONGIxSlJNR2tJMysxcWFkTjhBVUFPZk9WaHFWWDc1cDFqcEI2?=
 =?iso-2022-jp?B?MTdBMlBnVnNvb0tyczNBL2N0bGk4QjliK3JYZkZYb0hUTzByN2p0STU0?=
 =?iso-2022-jp?B?U2J0bnprUnhVSnU4WmtZNFdMRy9uc3Q4UkJNTVNrYzFkN05IeUlkVEx2?=
 =?iso-2022-jp?B?ZDdXcnE1VU9FQ1pUOUxCSDB0YTN6bm16VzJ4anBHK0ZBTHFrK295TE91?=
 =?iso-2022-jp?B?ODBJNmc5dW1idmM2ODlZNTJFVVBCdzh0cGw2c2dGZnJjek5GTnY4MFVk?=
 =?iso-2022-jp?B?MC9aa1k1bUxmQ3RHMER6QURDejN3cnduMGV2ZkhHWmxiOGkxQndIdzdQ?=
 =?iso-2022-jp?B?d2xNK0FjVmkzcTQwQlQ3dStCTEhQcE1OSzBYOFptTExiN1NaRlJNZ2pJ?=
 =?iso-2022-jp?B?bTFLOWxRUWRnb2ZkZnVhenpObXY3TlNIRFlxcUhQbjR6Q1hJYmdjY2Vz?=
 =?iso-2022-jp?B?TjE3T3k4Q01uN3lkRkNSdGR0dU9aZjBoTDEweFUrWW1nWkVlNE5QbVgx?=
 =?iso-2022-jp?B?U0gxOVErdS9scHVFNmduUUZvTmFvakJWeXNjc2VqMHUzbTZEZ09SVDhh?=
 =?iso-2022-jp?B?WXYyZEgzODI2Yk5BUktnd3JVcUxzQktwcVhtQWFrQTV3WEJkRDF1bDBQ?=
 =?iso-2022-jp?B?QzdBNmdTUTk4b2NVTk91V1BlTGxxME00bTNaKzVUc1VrakhaYllIQVF3?=
 =?iso-2022-jp?B?b211TzcwMVIrVU44VFZHZnpVV2FybG55dkxBdXdIemJ3V1RMNEVqMmNK?=
 =?iso-2022-jp?B?RXBoZllZKzBvazllT1ZYMXRqZFdRdUxFN21MZTdQalZvTnh5cVlaNTJs?=
 =?iso-2022-jp?B?ZlUrK2luajdNMTF3SVNVbGFvVTcwUEtmQlVqN2k0aHlEd1M0WnZxMXhP?=
 =?iso-2022-jp?B?eElrNndpUzZWSFJHVlh6L0ZZTU1zSGh3dkZnenhLRkNwN2JkOWVZM3JL?=
 =?iso-2022-jp?B?MDQxVytIT05WVkgrRmgyYzFXc2dlajdFQzlpeTNKWXNSUkoyNnlVMkRZ?=
 =?iso-2022-jp?B?dXhtck5mYllGS2czZTZqbm5lMlJvNm1ZU0hmL2ZxbXZEaXYraTBlRFov?=
 =?iso-2022-jp?B?VVB3emdONys5UjdyejVJMjJSb0s1ZCtob201UytzYmhlcXcyWWxUMTlk?=
 =?iso-2022-jp?B?UW9nZmNEV3F4RmNlNFlzazlUZkpTWit2N3lYVTY1VlRxL2dqZWYzODlL?=
 =?iso-2022-jp?B?UHlCQjFkSURqTmJVSEpSVG42d1FIRmhOWVpiZ2RITHRObUJBd2lrbkdh?=
 =?iso-2022-jp?B?akNMdWtyeGtYTDd0WUZiZkpWcDl4cmpTam9hZ0lacEwwaFYyQkVqT3RX?=
 =?iso-2022-jp?B?NTZGb1hKL1VpZHE4VVBpeVhIQVdNdDFpWDdrR0ZiNWdSZjJuWGtNdGhq?=
 =?iso-2022-jp?B?YXRWdnh2bDBLYVVHQ2xvTnlYYXNJOWVLenJCRWlnNkpCd1U1YnpEaGZZ?=
 =?iso-2022-jp?B?SGJ4cFFtS0hzNE9UcjN3TEVJY0Jwc0NEazFNWmZqVDh3VndJS3ZRa3ZF?=
 =?iso-2022-jp?B?eEltaWVaR0xBMFU5dXRkTi84UFdkUkpUWlU4V0Q3NGlRTGxrQlZGWmpX?=
 =?iso-2022-jp?B?ZVdqQktCVXlteDdteFZUZ1NPNWVzS0tVM2dYa09jaG0yU09UWVdxR2x6?=
 =?iso-2022-jp?B?anRxTzQ0NnVXaWNaaHMydDA5SUxLbVZwaWc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR13MB4696.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b83e246-3ccb-4c2f-95e6-08ddfc35515b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2025 13:13:28.4825
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7AJ9hkK9sAUOTImef47M6qz1TeojMTV1wEMJ5pRaLbAsGIK3OXEn3eE0LfmDDeQcoIURyJvWzyYIdhUUUf6vOO2uAQ8LuLYTxOxV3ltZIRg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR13MB5376

> -----Original Message-----
> From: Jonathan Flynn
> Sent: Wednesday, September 24, 2025 8:56 PM
> To: 'Mike Snitzer' <snitzer@kernel.org>; NeilBrown <neilb@ownmail.net>;
> Chuck Lever <cel@kernel.org>
> Cc: Jeff Layton <jlayton@kernel.org>; Olga Kornievskaia
> <okorniev@redhat.com>; Dai Ngo <dai.ngo@oracle.com>; Tom Talpey
> <tom@talpey.com>; linux-nfs@vger.kernel.org; Chuck Lever
> <chuck.lever@oracle.com>
> Subject: RE: [RFC PATCH v3 4/3] NFSD: Implement NFSD_IO_DIRECT for NFS
> READ (v3 and older) [Was: "Re: [PATCH v3 3/3] NFSD: Implement
> NFSD_IO_DIRECT for NFS READ"]
>=20
> > -----Original Message-----
> > From: Mike Snitzer <snitzer@kernel.org>
> > Sent: Wednesday, September 24, 2025 12:56 PM
> > To: NeilBrown <neilb@ownmail.net>; Chuck Lever <cel@kernel.org>
> > Cc: Jeff Layton <jlayton@kernel.org>; Olga Kornievskaia
> > <okorniev@redhat.com>; Dai Ngo <dai.ngo@oracle.com>; Tom Talpey
> > <tom@talpey.com>; linux-nfs@vger.kernel.org; Chuck Lever
> > <chuck.lever@oracle.com>
> > Subject: [RFC PATCH v3 4/3] NFSD: Implement NFSD_IO_DIRECT for NFS
> > READ
> > (v3 and older) [Was: "Re: [PATCH v3 3/3] NFSD: Implement
> > NFSD_IO_DIRECT for NFS READ"]
> >
> > On Wed, Sep 24, 2025 at 11:18:53AM -0400, Mike Snitzer wrote:
> > >
> > > FYI, I've been testing with NFSv3.  So nfsd_read -> nfsd_iter_read
> > >
> > > The last time I tested NFSv4 was with my DIO READ code that checked
> > > the memory alignment with precision (albeit adding more work per IO,
> > > which Chuck would like to avoid).
> >
> > We could just enable NFSD_IO_DIRECT for NFS v3 and older. And work out
> > adding support for NFSv4 as follow-on work for next cycle?
> >
> > This could be folded into Patch 3/3, and its header updated to be
> > clear that NFS v4+ isn't supported yet:
> >
> > diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c index
> > 96792f8a8fc5a..459a29f377c2c
> > 100644
> > --- a/fs/nfsd/vfs.c
> > +++ b/fs/nfsd/vfs.c
> > @@ -1182,10 +1182,6 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp,
> > struct svc_fh *fhp,
> >  	case NFSD_IO_BUFFERED:
> >  		break;
> >  	case NFSD_IO_DIRECT:
> > -		if (nf->nf_dio_read_offset_align &&
> > -		    !rqstp->rq_res.page_len && !base)
> > -			return nfsd_direct_read(rqstp, fhp, nf, offset,
> > -						count, eof);
> >  		fallthrough;
> >  	case NFSD_IO_DONTCACHE:
> >  		if (file->f_op->fop_flags & FOP_DONTCACHE) @@ -1622,8
> > +1618,14 @@ __be32 nfsd_read(struct svc_rqst *rqstp, struct svc_fh
> > +*fhp,
> >  	file =3D nf->nf_file;
> >  	if (file->f_op->splice_read && nfsd_read_splice_ok(rqstp))
> >  		err =3D nfsd_splice_read(rqstp, fhp, file, offset, count, eof);
> > -	else
> > +	else {
> > +		/* Use vectored reads, for NFS v3 and older */
> > +		if (nfsd_io_cache_read =3D=3D NFSD_IO_DIRECT &&
> > +		    nf->nf_dio_read_offset_align &&
> > +		    !rqstp->rq_res.page_len && !base)
> > +			return nfsd_direct_read(rqstp, fhp, nf, offset, count,
> > eof);
> >  		err =3D nfsd_iter_read(rqstp, fhp, nf, offset, count, 0, eof);
> > +	}
> >
> >  	nfsd_file_put(nf);
> >  	trace_nfsd_read_done(rqstp, fhp, offset, *count);
> Hello,
>=20
> I wanted to contribute some reproducible data to the discussion on
> NFSD_IO_DIRECT. With a background in performance benchmarking, I ran fio-
> based comparisons of buffered I/O (Mode0) and direct I/O (Mode2). The
> following write-up includes the problem definition, configuration, proced=
ure,
> and results.
>=20
> -------------------------------------------------------------------------=
------
> Problem Definition
> The primary motivation for NFSD_IO_DIRECT is to remove page cache
> contention that reduces overall read and write performance. We have
> consistently seen substantially better throughput with O_DIRECT than with
> buffered I/O, largely due to avoiding contention in the page cache. While
> latency improvements are not the sole goal, they serve as a clear indicat=
or of
> the performance benefits.
>=20
> Why dataset is much larger than memory (and why 3.125x)
>     - Goal: ensure the server cannot satisfy requests from page cache, fo=
rcing
>       steady-state disk/network behavior rather than warm-cache artifacts=
.
>     - Sizing: dataset ~=3D 3.125x server RAM. With 1 TB RAM and 32 jobs, =
this
>       yields ~100 GB/job (total ~=3D 3.2 TB). The 3.125 factor is a conve=
nience
>       that produces even 100 GB files; exact factor isn=1B$B!G=1B(Bt mate=
rial as long as
>       dataset >> RAM.
>     - Effect: Buffered mode under memory pressure shows elevated p95?p99.=
9
>       latencies due to page-faults, LRU churn, writeback contention, and
>       reclaim activity. The NFSD_IO_DIRECT read path bypasses these cache
>       dynamics, which is why it reduces tail latency and increases sustai=
ned
>       bandwidth when the system is under load.
>     - Concurrency mapping: 32 jobs/files ensures 2 files per NVMe
>       namespace/share (2 * 16 =3D 32), balancing load across namespaces a=
nd
>       preventing any single namespace from becoming a bottleneck.
>       (This is primarily due to my test environment being designed around
>       pNFS/NFSv4.2 for metadata path but uses NFSv3 for data path)
>=20
> Aside: Dataset fits in memory (~81% of RAM)
>     As a control case, we also ran tests where the dataset was only ~832 =
GB, or
>     ~81.25% of the server=1B$B!G=1B(Bs 1 TB RAM. In this in-memory regime=
, buffered and
>     direct I/O produced nearly identical results. For reads, mean latency=
 was
>     1.33 ms in both modes with negligible differences across percentiles.=
 For
>     writes, mean latency was 1.76 ms in both modes with only fractional
>     variation well within measurement noise. Bandwidth was likewise ~97?9=
8
> GB/s
>     for reads and ~72?73 GB/s for writes, regardless of mode.
>=20
>     CPU utilization during this in-memory run further illustrates the dyn=
amics:
>         - Writes Mode0 ~91% total (38% system, 50% iowait, 2.6% IRQ)
>         - Writes Mode2 ~79% total (9.4% system, 68.4% iowait, 1.8% IRQ)
>         - Reads  Mode0 ~52% total (50% system, 0% iowait, 1.4% IRQ)
>         - Reads  Mode2 ~72% total (11.5% system, 59% iowait, 1.9% IRQ)
>=20
>     Even though throughput and latency metrics converged, the CPU profile=
s
>     differ substantially between buffered and direct modes, reflecting wh=
ere
>     the work is absorbed (system vs iowait). These results confirm that
>     NFSD_IO_DIRECT does not hurt performance when the dataset can be full=
y
>     cached; its advantages only emerge once datasets exceed memory capaci=
ty
>     and page cache contention becomes the limiting factor.
>=20
> -------------------------------------------------------------------------=
------
> Hardware / Software Configuration
>     - Data Server: Supermicro SYS-121C-TN10R
>         * CPU: 2x Intel Xeon Gold 6542Y (24 cores/socket, 2.8 GHz)
>         * Memory: 1 TB RAM
>         * Storage: 8x ScaleFlux 7.68TB CSD5000 NVMe SSDs
>           (each exposing 2 namespaces, 16 total)
>         * Each namespace formatted with XFS, exported via pNFS v4.2
>     - Metadata Server: Identical platform with 8x ScaleFlux 7.68TB CSD500=
0
>       NVMe SSDs, acting as a pNFS Metadata Server (Hammerspace Anvil)
>     - Client: Identical platform minus local NVMe
>     - Data Fabric: 2x ConnectX-7 NICs, 400 GbE with RDMA (RoCE)
>     - OS: Rocky Linux 9.5
>     - Kernel: 6.12 baseline with NFSD_IO_DIRECT patches applied
>     - Protocol under test: NFSv4.2 was used to mount all 16 namespaces un=
der
> a
>       single mount point via pNFS (layouts/flexfiles). However, the under=
lying
>       storage traffic exercised NFSv3 shares, so effectively the test beh=
avior
>       reflects NFSv3 with NFSv4.2 coordinating access.
>=20
> -------------------------------------------------------------------------=
------
> Test Procedure
> The test methodology was automated using a wrapper script
> (nfsd_mode_compare_fio.sh). Defaults were used without overrides.
> The procedure was:
>     - Compute per-job file size so the aggregate dataset is ~3.125x large=
r than
>       the memory on the NFS server (default: 1 TB =1B$B"*=1B(B ~100G per =
job for 32 jobs).
>     - Build fio commands with:
>         * --numjobs=3D32, ensuring two files per NVMe namespace/share
>           (2 files =1B$B!_=1B(B 16 namespaces =3D 32 total)
>         * --bs=3D1m, --iodepth=3D2, --ioengine=3Dlibaio
>         * --direct=3D1, --runtime=3D600, --ramp_time=3D30, --time_based
>     - Files created in ${MOUNT_POINT} using format testfile.$jobnum.$file=
num
>     - Two threads per file: the second thread starts 50% into the file.
>     - Pass 1 (mode0): Set remote io_cache_read/io_cache_write to 0, run w=
rite
>       then read.
>     - Pause 60s between runs.
>     - Pass 2 (mode2): Set remote io_cache_read/io_cache_write to 2, drop
> remote
>       NFS server's page cache, rerun write and read.
>     - Results captured as JSON and summarized into bandwidth, latency
>       percentiles, and comparison tables.
>=20
> -------------------------------------------------------------------------=
------
> Results (Executive Summaries)
>=20
> --- READ Executive Summary ---
> Key                                mode0                mode2
> ------------------- -------------------- --------------------
> Bandwidth (GB/s)           18.51 (+/-0.19)        97.86 (+/-0.01)
> Mean Latency (ms)          7.21 (+/-15.30)         1.33 (+/-0.25)
> Max Latency (ms)                 3113.78                37.40
>=20
> --- WRITE Executive Summary ---
> Key                                mode0                mode2
> ------------------- -------------------- --------------------
> Bandwidth (GB/s)           34.20 (+/-0.25)        72.70 (+/-0.01)
> Mean Latency (ms)           3.84 (+/-6.54)         1.76 (+/-0.47)
> Max Latency (ms)                  199.07                25.68
>=20
> CPU utilization during 3.125=1B$B!_=1B(B dataset runs:
>     - Writes Mode0 ~83% total (79% system, 3.5% iowait, 0.98% IRQ)
>     - Writes Mode2 ~79% total (8.9% system, 68.7% iowait, 1.8% IRQ)
>     - Reads  Mode0 ~99.5% total (97.1% system, 1.7% iowait, 0.76% IRQ)
>     - Reads  Mode2 ~72% total (11.8% system, 58.1% iowait, 1.9% IRQ)
>=20
> The improvement on reads is more than 5x in bandwidth with far lower tail
> latency. Writes also show significant gains, indicating the direct path i=
s
> valuable for both workloads.
>=20
> Here is a link to the full results as well as the scripts used to generat=
e this
> data, with a README describing how to reproduce the tests:
> https://drive.google.com/drive/folders/1EbIAmigAv1KbE37dp2gRh_lCKIBxn2R
> M?usp=3Dsharing
> (I highly recommend reviewing the detailed results and the latency
> distributions)
>=20
> These results support enabling NFSD_IO_DIRECT for NFSv3 now, as Mike
> suggested. The benefits are clear and measurable. I agree that NFSv4 can =
be
> addressed in a follow-on cycle once the alignment/validation work is sort=
ed
> out.
>=20
> Happy to rerun with different parameters or workloads if that helps.
>=20
> Thanks,
> Jonathan Flynn
>=20
>=20
> -------------------------------------------------------------------------=
------
> Share file list:
> 3.125x_memory
>     grafana_screenshots
>         cpu_nfsv3_server.jpg
>         memory_nfsv3_server.jpg
>         nvme_nfsv3_server.jpg
>     logs
>         command_used.out
>         detailed_results.txt
>         fio_20250924_181954.log
>         fio_20250924_181954_read_mode0.json
>         fio_20250924_181954_read_mode2.json
>         fio_20250924_181954_write_mode0.json
>         fio_20250924_181954_write_mode2.json
>         what-if.out
>=20
> 0.8125x_memory
>     grafana_screenshots
>         cpu_nfsv3_server.jpg
>         memory_nfsv3_server.jpg
>         nvme_nfsv3_server.jpg
>     logs
>         command_used.out
>         detailed_results.txt
>         fio_20250924_230010.log
>         fio_20250924_230010_read_mode0.json
>         fio_20250924_230010_read_mode2.json
>         fio_20250924_230010_write_mode0.json
>         fio_20250924_230010_write_mode2.json
>         what-if.out
>=20
> analyze_fio_json.py
> nfsd_mode_compare_fio.sh
> README

Hello,

Following my earlier note, it became clear that one clarification is needed=
 regarding how CPU utilization is represented in the results.

In the initial message, I reported total CPU utilization as the sum of syst=
em, iowait, and IRQ percentages. However, iowait is not an active consumer =
of CPU cycles; it represents time spent waiting on I/O completion. To bette=
r reflect the effective CPU resources consumed, the comparison below exclud=
es iowait from the totals while still showing it for context:

    - Writes Mode0 ~40.6% effective (38% system, 50% iowait, 2.6% IRQ)
    - Writes Mode2 ~11.2% effective (9.4% system, 68.4% iowait, 1.8% IRQ)
    - Reads  Mode0 ~51.4% effective (50% system, 0% iowait, 1.4% IRQ)
    - Reads  Mode2 ~13.4% effective (11.5% system, 59% iowait, 1.9% IRQ)

This highlights that buffered I/O (Mode0) and direct I/O (Mode2) deliver es=
sentially identical performance and latency when the dataset fits within me=
mory, but NFSD_IO_DIRECT achieves this with far less active CPU utilization=
. The large share of time moved into iowait indicates the CPU is freed up f=
rom kernel bookkeeping and contention.

That freed CPU capacity could be leveraged for other data management tasks =
outside the direct data path ? for example, compression, encryption, or sec=
urity scanning jobs that operate on stored data. The point is not that thes=
e functions must be inline with reads/writes, but that reduced CPU load dur=
ing I/O creates more headroom for additional services to run concurrently o=
n the same infrastructure.

I hope this clarification is helpful for interpreting the results.

Thanks,
Jonathan Flynn

