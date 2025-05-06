Return-Path: <linux-nfs+bounces-11528-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9165DAAC9C7
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 17:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BA1B1C07018
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 15:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5D9283121;
	Tue,  6 May 2025 15:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="WP2saleF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2103.outbound.protection.outlook.com [40.107.237.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5F725B69F
	for <linux-nfs@vger.kernel.org>; Tue,  6 May 2025 15:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746546385; cv=fail; b=cxk7BeVp6lR3onZCF82eJnqPiMYj+0DxsH+SPh12M4y/CBG5bjnDdO0/7sUlntoyfOODAfrOohGS0hVzUtHiZKsAcowyn575l7OM78FE00SSY5ylgJxNWKcmTlhA23Ir+/GsI0l9B2NpzAOI6mdNv0h1D4Io03HK8gsOkoDMN/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746546385; c=relaxed/simple;
	bh=DxOlfKqgiB0JAgUQdM5DXWh0687SJkl+RXbBHWYFVLU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Jt3YBQrfHO3Twbsu5RlqdrsdVb1X6SC3XzM62TJQ8IEKH9QAhmumyHwRL6O+tduyAD9kSAq92212nMOGwdIM3E7eRE2s08c9RDGEC8+BH0e+XLxsFPMH0uFkytlOTkYMqs7m0Ey7RHtP5/F0m/V1Apbe2u7VZ4NCXqy3W1JGbHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=WP2saleF; arc=fail smtp.client-ip=40.107.237.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yTDaW/LGLwrJK2g/FrUpHVDZ7npk+W664hIEJDGC6APHndBUhVjivAEopjYQmnBK9M57Ps/1ld+/g58yibsp5d8NjluQ6fDO8Hd0Zf6fmM93ekxswsia2ejMlymELEdQGJ6iv3LrPmS1+/JBeVrK9P4IE395bSHyan8K06X23Ut4tP9ea7b9SEFPYhTEv6dLUpXiTC3uzCDfEXxccPR85SpcqxfvrK2mdQUQyQth96UCz0jiKUWZnh5vniyROPKwFwbCb+BMNJyz83OEvMvohWLooKHATyzygdD10Jt+nqxfwZCQIVRs92yzEAdPwAF7oLceAtsF6GCvRYMJmzuJLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DxOlfKqgiB0JAgUQdM5DXWh0687SJkl+RXbBHWYFVLU=;
 b=oGB4Glf1SAHy+DFBs2HAJakxUCFwJcgNB38/2c8QEiuCMYBO7F20FX0g8Ib1gXBotPgdXZ6bRfT0tjxfO7XbNo7zzhmx+ttuDd/x6KTxGHNzRdLWR5NcBqSPtNoDZaS9j7WMjjMcvg5eJECydLs99ulSbaORUkK5kP/Sto1nHnJB0UXnbHBzohEHN7QC6DyCz516ohl4MoZFIZ/xpeaf/PF8Hth6JMTsiXo1BicvSM3LjIRrJDYDMt+rx8ODdp42s7hunAA4JmLE/gXqHPWGtIJCIl84/m9SVQFd1m6Ki58Zr48P76mIUoXYnQafCNTsgd/Y5SGK7sADPRa6lDneNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DxOlfKqgiB0JAgUQdM5DXWh0687SJkl+RXbBHWYFVLU=;
 b=WP2saleFcSh3yKtLwkkblnJoW1tkkgJmnJNYXQFZZh4FyknWFql+1suuZnKjC6PXPciNLi2YIp92jtg4dGxcMM/isfsn8gUKScXrJlP8NdOSxjtkXD5XXx8p1G12dw3BHOB0sKAXxi0GCfZUFZPmnrCivvShwYRwfkf3OBsKtaY=
Received: from DM8PR13MB5079.namprd13.prod.outlook.com (2603:10b6:8:22::9) by
 BL0PR13MB4484.namprd13.prod.outlook.com (2603:10b6:208:1cc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Tue, 6 May
 2025 15:46:14 +0000
Received: from DM8PR13MB5079.namprd13.prod.outlook.com
 ([fe80::3312:9d7:60a8:e871]) by DM8PR13MB5079.namprd13.prod.outlook.com
 ([fe80::3312:9d7:60a8:e871%6]) with mapi id 15.20.8699.019; Tue, 6 May 2025
 15:46:13 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "hch@lst.de" <hch@lst.de>, "anna@kernel.org" <anna@kernel.org>
CC: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 3/5] nfs: move the call to nfs_pageio_cond_complete in
 nfs_do_writepage
Thread-Topic: [PATCH 3/5] nfs: move the call to nfs_pageio_cond_complete in
 nfs_do_writepage
Thread-Index: AQHbvpBePBXkMHRNe0a+IgyPVOg9PbPFvtkA
Date: Tue, 6 May 2025 15:46:13 +0000
Message-ID: <dcff42774c13403029e187a78196504acebbe142.camel@hammerspace.com>
References: <20250506140815.3761765-1-hch@lst.de>
	 <20250506140815.3761765-4-hch@lst.de>
In-Reply-To: <20250506140815.3761765-4-hch@lst.de>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR13MB5079:EE_|BL0PR13MB4484:EE_
x-ms-office365-filtering-correlation-id: 32fe0210-f4c0-445a-d615-08dd8cb52175
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?OFgvTTdkSmp6VGc3ZkpabWtqTWxnY2ltclpYaFpqRFhQN0piMXhJMDV3V2My?=
 =?utf-8?B?MXgyc2hkamZYRUp4a0FDZUhtWGZuR0lGRjJwRWpLd1pYaTZHamo2UkFtNU0x?=
 =?utf-8?B?OVZHNEVZbG1lMWNCUjY4MDk4OEhwelliUlludE5reDc2YzZGZlRqajN5WHNu?=
 =?utf-8?B?c0RmS1loNDVMOUNkVXFjMUhHOU9mMlpYU3hPSnU2dkd3V0dMSko4aHNoS2JB?=
 =?utf-8?B?T2R0M0I5Z0Irc1F5U1dETkZGUWR5dDJDemp3UWdua2dJMS8wWVJmTkR3SkJY?=
 =?utf-8?B?MEVsMVo3VkJLTTg2Tk9pczBSeWdmSTVBTnRKT3BsTSsrMDBtUXluYkxiM3hr?=
 =?utf-8?B?eDNTQ3ZwaldQMmRMc3pZanl3blJROVkraVV0aGNyNlZlLzcxZ0I1cEU4Wm96?=
 =?utf-8?B?Yjd1MzNreXcwb2ttcE16bmFzNEcrNC9aQ0VYYjhYWTg2QmZnZjhMTDRpamJD?=
 =?utf-8?B?dDV6MklrQ3h5ZWhUMFNsK3Jta2lKb000dW1Bd2JjQmlaUjczVWpaWlJyZjh6?=
 =?utf-8?B?SG9lWmcyVFNjaTVxbEtFOGhRdWdBUnFmampZWTVkbmNsU0pnVVI5SWRjbkxm?=
 =?utf-8?B?QnNvNE04T2ljLy9tUlNFTCs1ZDhCTUZpdmVCcEZTK1Nwa3V4NjAvRk9VUFFj?=
 =?utf-8?B?c2VwbndRTElCcytpSXFvZU1yTGx4RHhYVkxqZWpPVGt3K25LTVVNRktrL3RU?=
 =?utf-8?B?NS95TUphMENvaU5zUS9WZVZ0TmtkUE1Jb2VNTW9LNFNrOHZzY2dqNU1OVW91?=
 =?utf-8?B?UWduVFMxNHcrNXBxcGF4bUNkak1rUHhSeDNubW1vRjlOUmhkMC9uMlNXZDdE?=
 =?utf-8?B?dGVGNTdxWllIdnY2dStOc3U1SkltVEZBRHZteWxGczZXMTVUbHNoTW9GeVFZ?=
 =?utf-8?B?ZEdXTHNmbmR4Rko0WXNNeVloM29ibytCeW9CQi9XM2k3ZHA0cldla3QwN1Z5?=
 =?utf-8?B?dzR6RGNsay9BMEVvdEQ0WVNiY1k3V3dwbm9JN00wUklYcUcwNnFSUGhlSHVh?=
 =?utf-8?B?ZkVVbjB3UHIwUDNVU0ZadjA3ZTBsLy9CcDdVa2VjWXMwZlJ6dXdkTjE3UnNG?=
 =?utf-8?B?OTY1eThaTU9zakxaSGNxSlJhcExYQXU0MXJHYTdZTUcrN3luWi9HTUwzb25K?=
 =?utf-8?B?aFhBanZHYWZ3M3IzMGJ6UDZyRkFPa1RtM0JBbSs0aEppUVUwaHhIQ1RNZEhK?=
 =?utf-8?B?NHhHRk5MdnA2T2kzeU9SbXp3MVR6a1hKeUMwc09jcCtpemxXQ00ySDFKazJT?=
 =?utf-8?B?ZVFZeFVmOVFYWHVaVENjUC9uZTZGQzVLMEc1LzdySUNCWEpzU1lIbERVZ3Zx?=
 =?utf-8?B?SEJ1bEI0UmZYVFpnVGNVQjlmSHdlNWd3ZVBpN25jS250MGprU29kZnhMVmVP?=
 =?utf-8?B?RUpZV2hyQlZ6eUVuNmVzbllCOEJncUl1ZEN2QXhsazBlUzJjYm9nRFVhTjBs?=
 =?utf-8?B?bGpMVFF2MVJFbjN0N2kzVmVmcUM4dFI5Qzl3SDY4TnFmdTBCQlFtS0Z5MGhT?=
 =?utf-8?B?dThRU2FRcnEzOXkzUzBVQzRMcHEwRE9sVkd5VmlHUjAwMDdncVpINjhXaXJK?=
 =?utf-8?B?Mkx6cWx1QkF2QjB1Qk1XWTY2dHM5SThSUWlMeEUycVlhTkJSNTE1QTA3cGQr?=
 =?utf-8?B?VUdoSHU4eEwxaFR6cGYzUWsxNVREQ2FNNjJMYXFRZWNRcXNwMTg1YWRtdnRk?=
 =?utf-8?B?bEYxVTVYTHQ2VHErRDg0b3RiaTZXQ0d5Q0RkbTlYQ3lDcWlPb3pzby9lTGIz?=
 =?utf-8?B?cjQ1SU1USXAyaHZxeEUxSjFCYldiME5pRW1FYk5DWUdlak1rcGdIckludDJK?=
 =?utf-8?B?dW5kbXNrQ0FUN1lObkZ5ZmZOUGEwaDdKd3ZZMFZYblhVYi9oZ2pteEJVNkFh?=
 =?utf-8?B?OWpPdHhIMXBKOHArZXBvTmcwZkZaanhtbzdkQWZ3WjhTREpWSEZ4RUJvdjhG?=
 =?utf-8?B?MkliTnROZHk2WVJibjBHb2tpemRvb1dmTFZ6eTFIRDF4MmRHS3JkT0xZSkhY?=
 =?utf-8?B?bXRLdFJMV2Z3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5079.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UWtwZVhiRDRLd0JaSXR1RjRNZkxRZzFCeXVra3ZCZFdzS3FyeE9TMDd4RnBu?=
 =?utf-8?B?SXpqUXJsMDcrb0dScFd6T1RWME9MajhhMU1tRGx1aG5iekZnM1RFc2xmU1BM?=
 =?utf-8?B?TUdMNStvOEZUdTE5L0IwYTZRSzF1ZVQ5MEJiVDU3WG8xUFl2VFdBL0xzY0Zy?=
 =?utf-8?B?dU5peFMvT3VOQlFUYko4SkYxZGxqd2hUeFQxYXdZaWJvb0dzbVFYclFydzZ2?=
 =?utf-8?B?aTJWUGNjaHdJb0orVlBiYmE3SG5GQ0Q5TWRMRmJNOXptYTZjVklCdVpwaHdR?=
 =?utf-8?B?QzlCMjhrZWh5a2pFVTlDNEZwZlU1bjltbVp1SjM0bE9jd2dLSGVPQXBaa1Nq?=
 =?utf-8?B?aDlpNVJlR3lYN2toVHBid0FJY1piSHlvdUt3QjYrSDFHYm90TDdPTGFoV2Ru?=
 =?utf-8?B?SEdXRk1kOC9Ub1FxL21JemRWVHJkRXc1U3ZlaHFCeDF1MmI3V2dQSHRJNW1S?=
 =?utf-8?B?bkJ5MlY3STVCUjJnRzBaNDY1elN2b2NXcDI1QkdRUFdxTFFDWHEvRlBycTd0?=
 =?utf-8?B?QWNXWVZ1dU1TVis3bXVoQXBWWUZGdDJtak1IRnk5T1VIam9rbjBMSkFaNEZ2?=
 =?utf-8?B?ZW9GeHErNDNRU1p0T0hQUGU2VHJoMjRFWE1UWFNBTnJDKzRVZ1dQUlkzUnpk?=
 =?utf-8?B?NFJzNTJHUy8veS81OVYrOHFleXdGcHM3eUNRa0p5QjJITHZNN2dZY2dmbWVR?=
 =?utf-8?B?WXVBN1JDZXNYdDZYYnRUYzNCN1ViS2FGUExLSC9Td01lZnN0SmZJQ3gvQUpI?=
 =?utf-8?B?aUNjK2hmUmEzbENQdVVxdGplTzdXZHYvRG5vU0k5cGRNUWVyRU5mU01SWm9a?=
 =?utf-8?B?ZTloZ0R6WVZ1Mmd5S0tqOVJYS0g0dkNodWYzNzRCY2ZhMVRTem9uK1JjTk1W?=
 =?utf-8?B?VHRyUklOYm9LQmJwRmlGMmQrUkZiTVlsN0FiM3hlUHluVmwyYzI2K1g1dkk0?=
 =?utf-8?B?NVRnWEdiMldVVVNBdEtnSFhuN1hZdlprNndYV25XVWpXZXc4eG9TUXh6d1J5?=
 =?utf-8?B?SXAzRHBFVkRwMHo4cTJLVjBDUVU0bU84QmswaUZyU1ZUMXBXbitjOU9jMGEx?=
 =?utf-8?B?eUtmdTJsUXlPZWxjelNlelBERmc3bDZqQWs3Ny9CbVBrL1pyQlk4cnhUcHUr?=
 =?utf-8?B?dEdVdXR3N2orUDVicGhJQitsamlnRTZ3QnRwd045cEdoRTdCeE9zM0o1MkNH?=
 =?utf-8?B?c1JWZ0V6SDZUWjdETlRpaThrVFZBbmtoUm5HdG9maVEwV1Y0N3lvRzJjV0E3?=
 =?utf-8?B?MmdiOURCS21EVUwzM0pJSkxuVnZpMGF6dS9aUFpONDRTcnBTenVMYnVkTWZh?=
 =?utf-8?B?WWhGMjJEQlBCSmVTVkI2UDg4a3hTbm16b3dQVnMwQlVrOUFDYjhXdEFtenlo?=
 =?utf-8?B?eDhHYmpubDRKblIrMXlSVm9DeUhiZ1pKSUVPSEJ2cGtvb09hQUJ4SHQ2dS92?=
 =?utf-8?B?WWpRMTdLTG10c0RQWW9kNmRlNjFyUFFOR1hyQ0x3Z2c5di9TZUNOckxBakZ4?=
 =?utf-8?B?SDIyeUN2QkpoWkNkSjZyazU1VGxGL0hCMFI0SXZZTHVRY2lzeFhraXIyQ1la?=
 =?utf-8?B?NEpIYklldklDSHVUbXRPQW81RmsvOVdDanVQTGlTaEN0bWRqYmMwSElqZG85?=
 =?utf-8?B?ZmxqNllwNE83ZEtUeFdqQ1g3ajc5M0pqWjNNY1JvVWhYeG9uS1VpajlGUkVm?=
 =?utf-8?B?azJEY1czdEMxUSt5MFM2S1QzOXVtYkZ1ek5hRTF6dTZ3cmw1dG5IWDBlYjkr?=
 =?utf-8?B?WXV2VDZ6alVaVnpyRkhrYW1aZmhWWVMvS2pSaGZzREJTSHp0cXdydU96T2JI?=
 =?utf-8?B?WUY5Z25jNVlJVG4zTW0rVUlkRlYvMWZWSXA1cCs1VzVzUm9OUnI5QzhsUHBI?=
 =?utf-8?B?bHl4alJYMGNDS2Q5SnJWUFVKRFA2YUNIVGkvL3B6OTg5UzlzMFYzWWVRNmg5?=
 =?utf-8?B?bmZtMlY2RmVjVDhKemFMRDVXUDRlM2NEbkFLcFJNVGh2aUZEanFlWmFBTHFJ?=
 =?utf-8?B?VVk3cUlRaC9WWWl1WmU3Qk10MjdmMVBZUUZYRXNhbVRCNUxEcWRvN2xmdlVU?=
 =?utf-8?B?WjJJY2dOZlRKRVJFbVdlQkZGMThtR2xSRmI4SW14WnpwMVlyMVUyOWIvbTg4?=
 =?utf-8?B?dmszVFdxa3BQTlZjS051ZzVPWEJZMXJ5ZlN3eGVKUHpLRGd0WlpYTTlpZlVh?=
 =?utf-8?B?d1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <66841EA7855FB343A429833F812F5701@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5079.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32fe0210-f4c0-445a-d615-08dd8cb52175
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2025 15:46:13.4174
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jWX7/ffmHhMb/3M0z6SlEFqe0n2P3nhv5sSpoM6RGElpxjmQ2pkghRCTlOeMCyuUMoGhx0z9i8cOMZ3JciCK+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR13MB4484

T24gVHVlLCAyMDI1LTA1LTA2IGF0IDE2OjA3ICswMjAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90
ZToNCj4gQ2FsbGluZyBhIGZ1bmN0aW9uIGJlZm9yZSB0aGUgbWFpbiB2YXJpYWJsZSBkZWNsYXJh
dGlvbiBpcyBleHRyZW1lbHkNCj4gY29uZnVzaW5nLCBzbyBkb24ndCBkbyB0aGF0Lg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+DQo+IC0tLQ0KPiDC
oGZzL25mcy93cml0ZS5jIHwgMyArKy0NCj4gwqAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25z
KCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZnMvbmZzL3dyaXRlLmMgYi9m
cy9uZnMvd3JpdGUuYw0KPiBpbmRleCAzZTg3M2M1YjEwNDEuLjRlMWQ1N2I2M2E4NSAxMDA2NDQN
Cj4gLS0tIGEvZnMvbmZzL3dyaXRlLmMNCj4gKysrIGIvZnMvbmZzL3dyaXRlLmMNCj4gQEAgLTYz
NSwxMCArNjM1LDExIEBAIHN0YXRpYyB2b2lkIG5mc193cml0ZV9lcnJvcihzdHJ1Y3QgbmZzX3Bh
Z2UNCj4gKnJlcSwgaW50IGVycm9yKQ0KPiDCoHN0YXRpYyBpbnQgbmZzX2RvX3dyaXRlcGFnZShz
dHJ1Y3QgZm9saW8gKmZvbGlvLCBzdHJ1Y3QNCj4gd3JpdGViYWNrX2NvbnRyb2wgKndiYywNCj4g
wqAJCXN0cnVjdCBuZnNfcGFnZWlvX2Rlc2NyaXB0b3IgKnBnaW8pDQo+IMKgew0KPiAtCW5mc19w
YWdlaW9fY29uZF9jb21wbGV0ZShwZ2lvLCBmb2xpby0+aW5kZXgpOw0KPiDCoAlzdHJ1Y3QgbmZz
X3BhZ2UgKnJlcTsNCj4gwqAJaW50IHJldCA9IDA7DQo+IMKgDQo+ICsJbmZzX3BhZ2Vpb19jb25k
X2NvbXBsZXRlKHBnaW8sIGZvbGlvLT5pbmRleCk7DQo+ICsNCj4gwqAJcmVxID0gbmZzX2xvY2tf
YW5kX2pvaW5fcmVxdWVzdHMoZm9saW8pOw0KPiDCoAlpZiAoIXJlcSkNCj4gwqAJCWdvdG8gb3V0
Ow0KDQoNCk1heWJlIGNvbGxhcHNlIHRoaXMgcGF0Y2ggYW5kIDEvNT8g8J+Zgg0KDQotLSANClRy
b25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0K
dHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0K

