Return-Path: <linux-nfs+bounces-7104-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0538B99ADD8
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Oct 2024 22:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B40A928B6D7
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Oct 2024 20:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB1D1D1500;
	Fri, 11 Oct 2024 20:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="d02Pvwmv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2101.outbound.protection.outlook.com [40.107.243.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FC81D0F7D;
	Fri, 11 Oct 2024 20:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728680241; cv=fail; b=tiuKE3t5a9uEDgvkwql1LujTKu0Wae9qwy5hQCxji6KGMh6R841k4WKgCmjuTQlMDCC90XNMQA9lajNe1awqGcs7YhSckOkfu84yib9QF1jLyS+EL1z+tvGPHQ3+fbS7HOWy58IzBdGZDn3qQRSlOn9t5UGu3mzR8mbsuH+SHEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728680241; c=relaxed/simple;
	bh=SxiY40K2DxdpNmqfcrhozdPLWfiNH/wOMQvCxmgZgu0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ldPmAJhaOEAEHFyHy98CJzO93+DU8XYZ88idQb6SQCh8g2NDjXQ2ieWLmIIrLdQJ66mkjllgaMgs1xvW2aq3q3F4TPlQ6m07YeOgiAqF5+iQeA37eSEOJ8qCGs402kGCzlYjG44rM03tssPEPCujiaXC9Gui8heDgCH4Bj/ElTA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=d02Pvwmv; arc=fail smtp.client-ip=40.107.243.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=anR8XVnzxfMXSJ2IMzuLmKA29gqsdIHFtIFSDAXB3xU7PDDjhIrgiVN0vXpOUxP1QcjAelT33u1pkl6hP//iqH8vFmbIYwINRudj05XX6CJuj6c0q6D/OW5vOHTHEdV1hiTuxuwF6j0U70atJAwbc7gLo8I8OsnAIOtzRiDb5CFEGid287p/BMfi39MQIr+YVUefvZ2p1CN41PUGd3dNL73sSFkdMVI52R0gzYhLtMVmfJEUQW5DqdPS/w9Gq2Z7SbBgTBwussEj3uSEz0iISIaGoIoqSLNlMFeuZZY5w0yyLL5zvk6xFkqVmlDLxDuT3WrF9wRh74gdzgDfQDjf3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SxiY40K2DxdpNmqfcrhozdPLWfiNH/wOMQvCxmgZgu0=;
 b=FQN8NNy7+/abvJIv2/XvHqvs4xO+OrkZgJEmHoiL3l+RuhnaZ9LG9NuGfAKiEqrzrwkPpDGgTrSI4t60y2FmgY2+EV45y5vb3vh0fy0z4jMdRNB0GHWmiFPnp8TTF3oUnvQk33DERHuRwecmZulQX0fo9eJwaRPHmxVc/ueynvLMGUZV60cnfq9ghuL6EPER8iferPV8pALsgtFT5LCUyePt6B3VkojfwsiYr+isJfpc2dr4DSxv0cgci3AecuIAbCLoQX44/yPSI3Dg1tnbF16b6nMMmeV5w2ro8DFGXMV3QH84mpkIQeKyAwjXtLGpi2zx36DOEl55gjBD05N/AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SxiY40K2DxdpNmqfcrhozdPLWfiNH/wOMQvCxmgZgu0=;
 b=d02Pvwmv1rwAjVQQdseUilHSudSn72W44nhEdcWQAKpzZ8mrESN/5GMLHL8otK4mIPs2/P8/33+/8w1A5fmlMWuUI5lJybIbhxuaXnaZWkomLEua5+zbqlC5Ekd09MaftZvOUlDdd6odK9Cs9kfLJXu/BlJwT4meywhWAlBntH8=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by MWHPR13MB7179.namprd13.prod.outlook.com (2603:10b6:303:287::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Fri, 11 Oct
 2024 20:57:15 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%5]) with mapi id 15.20.8048.020; Fri, 11 Oct 2024
 20:57:14 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "okorniev@redhat.com" <okorniev@redhat.com>, "chuck.lever@oracle.com"
	<chuck.lever@oracle.com>
CC: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"jlayton@kernel.org" <jlayton@kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: Re: [PATCH 1/1] nfsd: fix race between laundromat and free_stateid
Thread-Topic: [PATCH 1/1] nfsd: fix race between laundromat and free_stateid
Thread-Index: AQHbG2JUUcuOC2WNc02jNgHyIMA4o7KBn/EAgABplAA=
Date: Fri, 11 Oct 2024 20:57:14 +0000
Message-ID: <90e288d86dcd5ffb7a61b48b06980057dacf7462.camel@hammerspace.com>
References: <20241010221801.35462-1-okorniev@redhat.com>
	 <Zwk4mAhnaoFe43Gy@tissot.1015granger.net>
In-Reply-To: <Zwk4mAhnaoFe43Gy@tissot.1015granger.net>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|MWHPR13MB7179:EE_
x-ms-office365-filtering-correlation-id: e5884da4-c871-4921-73f7-08dcea3748b7
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?OHBNQkUzZEg2VGNDczRnZU12cUlKL0thTWxrM2EreVRBbDhYbGQrVTJSNDhS?=
 =?utf-8?B?TXczTW93NmVTT21jVUxwcHFVaE9ybTZGa3hkTmI4dHp3YVBVL0ExYXZPTEMr?=
 =?utf-8?B?dmoyUWN4TVBqRnpRdjQzV1YvTnc5SEdLa2lUYzNXeEdCdjBzM0VCY3FZZHc3?=
 =?utf-8?B?b3Ayd1NsVXBmbDRpK3d5cFY3T1dSa1B1RktYOGd6WGY1Y1RjNTBDZXA4MUM0?=
 =?utf-8?B?Zkw5NFpvZFgvejFVc2pROG9YZHN3Nm1mV1lFeEZlcjVhMk42VmpXWnY0THEz?=
 =?utf-8?B?bk5pSXNmVjZ1T05zWkkvSkRMMmhkWG1BUTFMVVpmM3Y4L2JEM3VwVEZoZTY1?=
 =?utf-8?B?S2xMK0tOUGxTWTh2MzhXL0pnN05PaGNjNHZVTzFoT01aWjhCbHBWQmlidmNt?=
 =?utf-8?B?OElMYTIzYm9jNjliZm9xaUt4Qm1vTG5mRVZ5dXQ2M0NVZkttQ1FVU2VvN0Q0?=
 =?utf-8?B?NVN1UTVlS2lZU1lpbEt6UDFyZTlTRzhRaTNIVG9kVW1xVXdybkNwUVFkT1RX?=
 =?utf-8?B?em5RaC9LVFl4ZDlvR2xualBhb0doWlRJLzdxVUxhRzFWYWV4L3hLYm5WbmNQ?=
 =?utf-8?B?YkgvV3RJSWZsdEQxN0VWQUxkb1JoTUZ3WGErRVJFNTBRWXR1aHozVm55WnVY?=
 =?utf-8?B?d1ZwZzZUamo0cE5vZ2hBM1FQanF0Sy91MUVmd0R2c2haeXhWbWUxRVZMTURm?=
 =?utf-8?B?VVdNZVF6djJQVVZ4ei9zaUdxT05UZUJFdXBKZm9YYzV3OEFlaG5WTWlhMnI1?=
 =?utf-8?B?VElQNG5EK0lrUTNtSEFlVDVXQSt0cWZkRnhObXBFN3hQbUxqREliQkpJSTNL?=
 =?utf-8?B?TTIrVCtDWElRTktQQVBGbFgyNDRZRU5rL0tvSDMzVW9veEpPYzYrK1JrL0lI?=
 =?utf-8?B?ZDlaeThIMjkzbDJpbGJzTzB6dzhJaUJFK296T0JhWHZieU9kL2tNL1JRSTQ2?=
 =?utf-8?B?aURVZjZpWW1SeTZycFZMdzB6U0Y0ZWpkeHhlUzRwdnJ5eW5aeWk1ZnEzTkRU?=
 =?utf-8?B?OXRlam1rQnFIR2RSQkhjZ09pakpmTXNJYkJvQlo1RHZiOHM0UWNJZ1hZekpP?=
 =?utf-8?B?Qjlic0FjS1V6YTQzWGhOM0ZBOHJpSW9zTDlVekFkRnU1NHNZcGh2aFpyMmVp?=
 =?utf-8?B?SkxGUzJEajgwNFNRNXg2OGUwVVNic3ArdFFRemIrNGlBWkl1VGdHWWVOaFpO?=
 =?utf-8?B?UUNCOTAxdWYrbXB6SXN6amUyMXZQSTZ6ckJlcFQrZzVnZHVRbXZodi8rczhC?=
 =?utf-8?B?RkxUUjBTUGVESVFyOHBwSGtsZGZ1aFNuU2ZCdlh3SFFhK0tBa2RJaVJINVhL?=
 =?utf-8?B?SDRtdFBrZitLTFVrNVZEM2NZUEdrYk1sRUduNis5L2hDSEd4T3FDRFluWXFE?=
 =?utf-8?B?ME9QbW4vcHZLSXZvWE1RcFJvOVErTmk1cW9jWnpBQ3ArQVdkUzA5YTV5clJV?=
 =?utf-8?B?UktDcWp5clNSd2JLWDNqZ1lxUWd6Y1d6T094ajdQcHJhZEhobXQrdUJ0L090?=
 =?utf-8?B?S25xTkwwYzd3OTZmNjJpbFpqTzhpZ3BsaU45MUM3NlZkdUxRVmV2Z2N5Tm03?=
 =?utf-8?B?L1NWV2NVUTFEK2UzaEl6ZGlRS0hwZy9jczcweXBUNDFYSzM3bjhFRk9rR2l2?=
 =?utf-8?B?MU9IUGFkUXR6MHF1WVgrQkN3MWVmQWkvL0JSYjNyN1dOWmJEb0ZTb1RFTzhB?=
 =?utf-8?B?d0RzWXJRaG9ZQ0hzV04xSUppaStoOWJzTUwrdWZmczV6TXhjTE54ZjZ6MFZu?=
 =?utf-8?B?WU9LQzVFTjExVFIrc2RWclc5RFhGME9TUFRpdjJsd0RNV3ZQajAyTnova2ZK?=
 =?utf-8?B?dnJtWDhzMXdKYkdxamNlZz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RkhkcGUxUTNzTEhFRy9Jci9zZlJqMCtUOTMva0ViZUhhWTl6bHF0Z0I2eExj?=
 =?utf-8?B?TjMraTQzMFpJTFJlbXZiSWJnWnFHaVRMNTErU1lUNzZhUlQ3eUJDbnB5anpv?=
 =?utf-8?B?T2J4NUNQZUdiZVlXcitGdWtzVGlyaFVna2prbW52Nmd5NFZDZ1NwTElaMmxl?=
 =?utf-8?B?NjA3dUc0dTRlSHBwWERqRTlMMTA0cEd3ZzV4QndxbjVGMGR4aGw0RmxXUFpE?=
 =?utf-8?B?dFA0SkVCK25SV293d1JzTThsZG9yZmVIelVNbVZ5RHBJQUNVTVMrVzFhazNa?=
 =?utf-8?B?VW41TDZyVHBMRHQ1RktzNTMvbzcrWVpydlNnZ29Id3hPbWpPK1hTcGVMR0pp?=
 =?utf-8?B?bmI2alFSYnBFdVZxeWY2YXdZVkhCS2J6RGVscWdlc0dmSmJlbDlCaStkaHZs?=
 =?utf-8?B?aGF0STRMVG5vd1Q4aFU4UVBrSDExOXcyUlpyK3hKSkZDR3Jib1dYaCtmMm1s?=
 =?utf-8?B?bFNlWDRyYVFUVGNzSlZQcUd0TXJ0Q2lUNEYvOVNMS2dOVnpjQVI2cjBTV0Rk?=
 =?utf-8?B?MkM0VTVHanp3SnR2UHVod1ZFcXEwK2pacVVkNEc0NFl0ZVBnQnE0R0dvTmg4?=
 =?utf-8?B?em5ML082K3FocjI2cEN6cktQZHNNbGhXZ0c0S1RqU1EzbXhSMlZkTk9uZlRm?=
 =?utf-8?B?Q3RsdWMxUG5oSU95MDRka2cwTHVSVFE4Ryt1UDlDb3RTdlJ4WTFpQjlLZFZw?=
 =?utf-8?B?QWRCRGZ6TjVGTS9paW5BU0dtOUhlQndTZkhlMkpmTWNlNzBFRTRxWmREMkln?=
 =?utf-8?B?NWVlb0pRTXkwaHpOTG8zSFMxbU9YYndLcFdJd3Q5VUoxWEV1WGtkdzg0RVdJ?=
 =?utf-8?B?VE9SUlZVWGoycndySlVNcGI0MW9UTHBERHNhQzlsLzFMdHhmNG9FOGdtWHJs?=
 =?utf-8?B?ZkJqTzFkdzhJNlI2Y1JlWmVCOG96a3Y3YUJxRHp6b0xFei9yVXF6aVlZbGtM?=
 =?utf-8?B?ckpVMkFrUVgrNEVQWk1SWUN3WUEyT05TK0VDUWFPUlJNZ1Y2TWZOZjRzTTdK?=
 =?utf-8?B?VWplTHNGSnl5OFNLUHZSTVZLd2l4bnpTMC95bWo4SGpIWWVSaE9aeEVTUEh5?=
 =?utf-8?B?ZWVkUkxFZzZ4NmVaVExsQi8rYW5iV1BYWklMWGpZUWVvRytIK1I3dWZTbFBs?=
 =?utf-8?B?eS8zRzZ2Z2pQaU9Qa083d2h6K0JPQjFjczJ3dGcxc1JLRlR2bTNLaDZLSFN4?=
 =?utf-8?B?SWk2Zlh4ZFBtbThHd3BhbW9sWnYralhWaVhyc01kRzdkTmJsSDY5Qlpsa0Fq?=
 =?utf-8?B?QmhPbGhWbXVlcnNObG55WTJNQjAzNVdxRjBiaW1UY2NrdHM1c21vb3Vhai9H?=
 =?utf-8?B?ajNkVU1RbzNsRjdCdGNyeFRiemhaM0RndVp4OVhSbGRuUW5JeDdZcERYMldk?=
 =?utf-8?B?QVRPVEQ1c1FrNnNVaHJ4RWN6MDAzZVhpNXF5cEdKTmNlVHVRbUh4TFRDMGdB?=
 =?utf-8?B?Z2dlY0xIcUR0dTJyRmFya2QzazNmTytYUFJIc2lGVW45TUV3bUR0U2FNN3kw?=
 =?utf-8?B?OGpVL2FMb0k5bnJqRm41ZU5lMnZEcVlGUXlpanF3U2MrRHpTYzZnMDdFbDc2?=
 =?utf-8?B?cThYeklydEdhK1dtNThwUC9nN1BlcEwrL3RaM2U1dnJOanFqcE1pb0YwSWlr?=
 =?utf-8?B?UzBRM2JlTG9zb002eEVhc2VKbFpSY2tlQktkcThUQVhwMXE5aHJNbGdYTm9Q?=
 =?utf-8?B?WFB3a1BSTzY2ek5nWGxoMVZrRUo2WVRoL0J2ak5GMEp1Y3lyZVNCcGNqem01?=
 =?utf-8?B?V0JZTEhxV1BqbEorc05iZzhmT0llYTMrS2ZNWGpHWjJ4UVlQMGV3WVdoSjVT?=
 =?utf-8?B?RFJlTnhvcHU2N3JWZmxBdmh5R2R0R29ETGtIMWxNUjYvbUlnQ3l2YlFKWHNz?=
 =?utf-8?B?MHI3RWVxUzR1bHVpMUlhWkxHN2I4a2NEcUlRT1g4aGYyTUJpNTBUekJUVjJT?=
 =?utf-8?B?NWloTjZPRTNzQ3NNQ0lQU2NucjA1T0JhV25BRmcwVHlWdUFYaXJuMEpaaFZZ?=
 =?utf-8?B?Y1hyVzRrSUM1TzdOODVwTU1sMHVzeHFXVjhYSWhTNk5yblVUd0ZGbEpuTFQ1?=
 =?utf-8?B?Y3B2ZFBsMFZIZEZzSUJycmNqZXVDZEZ2Zld5dmNmb282eEZ6ZkpFQjE2bWNl?=
 =?utf-8?B?RVdsVm1BTnkyQ3YzSStic3laRm44SnpDWWxVRlpydGR3VGJ3c1V6MWRYaUNY?=
 =?utf-8?B?L2RUb2VsOHZWdXpieFZlT1l5TnJqWFJJQ3ZwVWtad0dVbGdTNEhQWU42V0Y1?=
 =?utf-8?B?bWQrMWkzVEpCT3dQdXNxbE5KS3BRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <55B1F0683B919247A223AAA8A6A7DEFC@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5884da4-c871-4921-73f7-08dcea3748b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2024 20:57:14.3347
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dfsoN/rnsCXoR+AAedUuBOuQaBXqqOUlB2PiAmDo0zuf8eyNx8HyK/+G+xTRasO/AqMfR7PllDuWzXukxRG8Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR13MB7179

T24gRnJpLCAyMDI0LTEwLTExIGF0IDEwOjM5IC0wNDAwLCBDaHVjayBMZXZlciB3cm90ZToNCj4g
T24gVGh1LCBPY3QgMTAsIDIwMjQgYXQgMDY6MTg6MDFQTSAtMDQwMCwgT2xnYSBLb3JuaWV2c2th
aWEgd3JvdGU6DQo+ID4gVGhlcmUgaXMgYSByYWNlIGJldHdlZW4gbGF1bmRyb21hdCBoYW5kbGlu
ZyBvZiByZXZva2VkIGRlbGVnYXRpb25zDQo+ID4gYW5kIGEgY2xpZW50IHNlbmRpbmcgZnJlZV9z
dGF0ZWlkIG9wZXJhdGlvbi4gTGF1bmRyb21hdCB0aHJlYWQNCj4gPiBmaW5kcyB0aGF0IGRlbGVn
YXRpb24gaGFzIGV4cGlyZWQgYW5kIG5lZWRzIHRvIGJlIHJldm9rZWQgc28gaXQNCj4gPiBtYXJr
cyB0aGUgZGVsZWdhdGlvbiBzdGlkIHJldm9rZWQgYW5kIGl0IHB1dHMgaXQgb24gYSByZWFwZXIg
bGlzdA0KPiA+IGJ1dCB0aGVuIGl0IHVubG9jayB0aGUgc3RhdGUgbG9jayBhbmQgdGhlIGFjdHVh
bCBkZWxlZ2F0aW9uDQo+ID4gcmV2b2NhdGlvbg0KPiA+IGhhcHBlbnMgd2l0aG91dCB0aGUgbG9j
ay4gT25jZSB0aGUgc3RpZCBpcyBtYXJrZWQgcmV2b2tlZCBhIHJhY2luZw0KPiA+IGZyZWVfc3Rh
dGVpZCBwcm9jZXNzaW5nIHRocmVhZCBkb2VzIHRoZSBmb2xsb3dpbmcgKDEpIGl0IGNhbGxzDQo+
ID4gbGlzdF9kZWxfaW5pdCgpIHdoaWNoIHJlbW92ZXMgaXQgZnJvbSB0aGUgcmVhcGVyIGxpc3Qg
YW5kICgyKSBmcmVlcw0KPiA+IHRoZSBkZWxlZ2F0aW9uIHN0aWQgc3RydWN0dXJlLiBUaGUgbGF1
bmRyb21hdCB0aHJlYWQgZW5kcyB1cCBub3QNCj4gPiBjYWxsaW5nIHRoZSByZXZva2VfZGVsZWdh
dGlvbigpIGZ1bmN0aW9uIGZvciB0aGlzIHBhcnRpY3VsYXINCj4gPiBkZWxlZ2F0aW9uDQo+ID4g
YnV0IHRoYXQgbWVhbnMgaXQgd2lsbCBubyByZWxlYXNlIHRoZSBsb2NrIGxlYXNlIHRoYXQgZXhp
c3RzIG9uDQo+ID4gdGhlIGZpbGUuDQo+ID4gDQo+ID4gTm93LCBhIG5ldyBvcGVuIGZvciB0aGlz
IGZpbGUgY29tZXMgaW4gYW5kIGVuZHMgdXAgZmluZGluZyB0aGF0DQo+ID4gbGVhc2UgbGlzdCBp
c24ndCBlbXB0eSBhbmQgY2FsbHMgbmZzZF9icmVha2VyX293bnNfbGVhc2UoKSB3aGljaA0KPiA+
IGVuZHMNCj4gPiB1cCB0cnlpbmcgdG8gZGVyZWZlbmNlIGEgZnJlZWQgZGVsZWdhdGlvbiBzdGF0
ZWlkLiBMZWFkaW5nIHRvIHRoZQ0KPiA+IGZvbGxvd2ludCB1c2UtYWZ0ZXItZnJlZSBLQVNBTiB3
YXJuaW5nOg0KPiA+IA0KPiA+IGtlcm5lbDoNCj4gPiA9PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCj4gPiBrZXJuZWw6IEJV
RzogS0FTQU46IHNsYWItdXNlLWFmdGVyLWZyZWUgaW4NCj4gPiBuZnNkX2JyZWFrZXJfb3duc19s
ZWFzZSsweDE0MC8weDE2MCBbbmZzZF0NCj4gPiBrZXJuZWw6IFJlYWQgb2Ygc2l6ZSA4IGF0IGFk
ZHIgZmZmZjAwMDBlNzNjZDBjOCBieSB0YXNrIG5mc2QvNjIwNQ0KPiA+IGtlcm5lbDoNCj4gPiBr
ZXJuZWw6IENQVTogMiBVSUQ6IDAgUElEOiA2MjA1IENvbW06IG5mc2QgS2R1bXA6IGxvYWRlZCBO
b3QNCj4gPiB0YWludGVkIDYuMTEuMC1yYzcrICM5DQo+ID4ga2VybmVsOiBIYXJkd2FyZSBuYW1l
OiBBcHBsZSBJbmMuIEFwcGxlIFZpcnR1YWxpemF0aW9uIEdlbmVyaWMNCj4gPiBQbGF0Zm9ybSwg
QklPUyAyMDY5LjAuMC4wLjAgMDgvMDMvMjAyNA0KPiA+IGtlcm5lbDogQ2FsbCB0cmFjZToNCj4g
PiBrZXJuZWw6IGR1bXBfYmFja3RyYWNlKzB4OTgvMHgxMjANCj4gPiBrZXJuZWw6IHNob3dfc3Rh
Y2srMHgxYy8weDMwDQo+ID4ga2VybmVsOiBkdW1wX3N0YWNrX2x2bCsweDgwLzB4ZTgNCj4gPiBr
ZXJuZWw6IHByaW50X2FkZHJlc3NfZGVzY3JpcHRpb24uY29uc3Rwcm9wLjArMHg4NC8weDM5MA0K
PiA+IGtlcm5lbDogcHJpbnRfcmVwb3J0KzB4YTQvMHgyNjgNCj4gPiBrZXJuZWw6IGthc2FuX3Jl
cG9ydCsweGI0LzB4ZjgNCj4gPiBrZXJuZWw6IF9fYXNhbl9yZXBvcnRfbG9hZDhfbm9hYm9ydCsw
eDFjLzB4MjgNCj4gPiBrZXJuZWw6IG5mc2RfYnJlYWtlcl9vd25zX2xlYXNlKzB4MTQwLzB4MTYw
IFtuZnNkXQ0KPiA+IGtlcm5lbDogbGVhc2VzX2NvbmZsaWN0KzB4NjgvMHgzNzANCj4gPiBrZXJu
ZWw6IF9fYnJlYWtfbGVhc2UrMHgyMDQvMHhjMzgNCj4gPiBrZXJuZWw6IG5mc2Rfb3Blbl9icmVh
a19sZWFzZSsweDhjLzB4ZjAgW25mc2RdDQo+ID4ga2VybmVsOiBuZnNkX2ZpbGVfZG9fYWNxdWly
ZSsweGIzYy8weDExZDAgW25mc2RdDQo+ID4ga2VybmVsOiBuZnNkX2ZpbGVfYWNxdWlyZV9vcGVu
ZWQrMHg4NC8weDExMCBbbmZzZF0NCj4gPiBrZXJuZWw6IG5mczRfZ2V0X3Zmc19maWxlKzB4NjM0
LzB4OTU4IFtuZnNkXQ0KPiA+IGtlcm5lbDogbmZzZDRfcHJvY2Vzc19vcGVuMisweGE0MC8weDFh
NDAgW25mc2RdDQo+ID4ga2VybmVsOiBuZnNkNF9vcGVuKzB4YTA4LzB4ZTgwIFtuZnNkXQ0KPiA+
IGtlcm5lbDogbmZzZDRfcHJvY19jb21wb3VuZCsweGI4Yy8weDIxMzAgW25mc2RdDQo+ID4ga2Vy
bmVsOiBuZnNkX2Rpc3BhdGNoKzB4MjJjLzB4NzE4IFtuZnNkXQ0KPiA+IGtlcm5lbDogc3ZjX3By
b2Nlc3NfY29tbW9uKzB4OGU4LzB4MTk2MCBbc3VucnBjXQ0KPiA+IGtlcm5lbDogc3ZjX3Byb2Nl
c3MrMHgzZDQvMHg3ZTAgW3N1bnJwY10NCj4gPiBrZXJuZWw6IHN2Y19oYW5kbGVfeHBydCsweDgy
OC8weGUxMCBbc3VucnBjXQ0KPiA+IGtlcm5lbDogc3ZjX3JlY3YrMHgyY2MvMHg2YTggW3N1bnJw
Y10NCj4gPiBrZXJuZWw6IG5mc2QrMHgyNzAvMHg0MDAgW25mc2RdDQo+ID4ga2VybmVsOiBrdGhy
ZWFkKzB4Mjg4LzB4MzEwDQo+ID4ga2VybmVsOiByZXRfZnJvbV9mb3JrKzB4MTAvMHgyMA0KPiA+
IA0KPiA+IFByb3Bvc2luZyB0byBoYXZlIGxhdW5kcm9tYXQgdGhyZWFkIGhvbGQgdGhlIHN0YXRl
X2xvY2sgb3ZlciBib3RoDQo+ID4gbWFya2luZyB0aHJ1IHJldm9raW5nIHRoZSBkZWxlZ2F0aW9u
IGFzIHdlbGwgYXMgbWFraW5nIGZyZWVfc3RhdGVpZA0KPiA+IGFjcXVpcmUgc3RhdGVfbG9jayBi
ZWZvcmUgYWNjZXNzaW5nIHRoZSBsaXN0LiBNYWtpbmcgc3VyZSB0aGF0DQo+ID4gcmV2b2tlX2Rl
bGVnYXRpb24oKSAoaWUga2VybmVsX3NldGxlYXNlKHVubG9jaykpIGlzIGNhbGxlZCBmb3INCj4g
PiBldmVyeSBkZWxlZ2F0aW9uIHRoYXQgd2FzIHJldm9rZWQgYW5kIGFkZGVkIHRvIHRoZSByZWFw
ZXIgbGlzdC4NCj4gPiANCj4gPiBDQzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiA+IFNpZ25l
ZC1vZmYtYnk6IE9sZ2EgS29ybmlldnNrYWlhIDxva29ybmlldkByZWRoYXQuY29tPg0KPiA+IA0K
PiA+IC0tLSBJIGNhbid0IGZpZ3VyZSBvdXQgdGhlIEZpeGVzOiB0YWcuIExhdW5kcm9tYXQncyBi
ZWhhdmlvdXIgaGFzDQo+ID4gYmVlbiBsaWtlIHRoYXQgZm9yZXZlci4gQnV0IHRoZSBmcmVlX3N0
YXRlaWQgYml0cyB3b250IGFwcGx5IGJlZm9yZQ0KPiA+IHRoZSAxZTM1NzdhNDUyMWUgKCJTVU5S
UEM6IGRpc2NhcmQgc3ZfcmVmY250LCBhbmQNCj4gPiBzdmNfZ2V0L3N2Y19wdXQiKS4NCj4gPiBC
dXQgd2UgdXNlZCB0aGF0IGZpeGVzIHRhZyBhbHJlYWR5IHdpdGggYSBwcmV2aW91cyBmaXggZm9y
IGENCj4gPiBkaWZmZXJlbnQNCj4gPiBwcm9ibGVtLg0KPiA+IC0tLQ0KPiA+IMKgZnMvbmZzZC9u
ZnM0c3RhdGUuYyB8IDQgKysrLQ0KPiA+IMKgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygr
KSwgMSBkZWxldGlvbigtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9mcy9uZnNkL25mczRzdGF0
ZS5jIGIvZnMvbmZzZC9uZnM0c3RhdGUuYw0KPiA+IGluZGV4IDljMmIxZDI1MWFiMy4uYzk3OTA3
ZDdmYjM4IDEwMDY0NA0KPiA+IC0tLSBhL2ZzL25mc2QvbmZzNHN0YXRlLmMNCj4gPiArKysgYi9m
cy9uZnNkL25mczRzdGF0ZS5jDQo+ID4gQEAgLTY2MDUsMTMgKzY2MDUsMTMgQEAgbmZzNF9sYXVu
ZHJvbWF0KHN0cnVjdCBuZnNkX25ldCAqbm4pDQo+ID4gwqAgdW5oYXNoX2RlbGVnYXRpb25fbG9j
a2VkKGRwLCBTQ19TVEFUVVNfUkVWT0tFRCk7DQo+ID4gwqAgbGlzdF9hZGQoJmRwLT5kbF9yZWNh
bGxfbHJ1LCAmcmVhcGxpc3QpOw0KPiA+IMKgIH0NCj4gPiAtIHNwaW5fdW5sb2NrKCZzdGF0ZV9s
b2NrKTsNCj4gPiDCoCB3aGlsZSAoIWxpc3RfZW1wdHkoJnJlYXBsaXN0KSkgew0KPiA+IMKgIGRw
ID0gbGlzdF9maXJzdF9lbnRyeSgmcmVhcGxpc3QsIHN0cnVjdCBuZnM0X2RlbGVnYXRpb24sDQo+
ID4gwqAgZGxfcmVjYWxsX2xydSk7DQo+ID4gwqAgbGlzdF9kZWxfaW5pdCgmZHAtPmRsX3JlY2Fs
bF9scnUpOw0KPiA+IMKgIHJldm9rZV9kZWxlZ2F0aW9uKGRwKTsNCj4gPiDCoCB9DQo+ID4gKyBz
cGluX3VubG9jaygmc3RhdGVfbG9jayk7DQo+IA0KPiBDb2RlIHJldmlldyBzdWdnZXN0cyByZXZv
a2VfZGVsZWdhdGlvbigpIChhbmQgaW4gcGFydGljdWxhciwNCj4gZGVzdHJveV91bmhhc2hlZF9k
ZWxlZygpLCBtdXN0IG5vdCBiZSBjYWxsZWQgd2hpbGUgaG9sZGluZw0KPiBzdGF0ZV9sb2NrKCku
DQo+IA0KPiANCj4gPiDCoCBzcGluX2xvY2soJm5uLT5jbGllbnRfbG9jayk7DQo+ID4gwqAgd2hp
bGUgKCFsaXN0X2VtcHR5KCZubi0+Y2xvc2VfbHJ1KSkgew0KPiA+IEBAIC03MjEzLDcgKzcyMTMs
OSBAQCBuZnNkNF9mcmVlX3N0YXRlaWQoc3RydWN0IHN2Y19ycXN0ICpycXN0cCwNCj4gPiBzdHJ1
Y3QgbmZzZDRfY29tcG91bmRfc3RhdGUgKmNzdGF0ZSwNCj4gPiDCoCBpZiAocy0+c2Nfc3RhdHVz
ICYgU0NfU1RBVFVTX1JFVk9LRUQpIHsNCj4gPiDCoCBzcGluX3VubG9jaygmcy0+c2NfbG9jayk7
DQo+ID4gwqAgZHAgPSBkZWxlZ3N0YXRlaWQocyk7DQo+ID4gKyBzcGluX2xvY2soJnN0YXRlX2xv
Y2spOw0KPiA+IMKgIGxpc3RfZGVsX2luaXQoJmRwLT5kbF9yZWNhbGxfbHJ1KTsNCj4gPiArIHNw
aW5fdW5sb2NrKCZzdGF0ZV9sb2NrKTsNCj4gDQo+IEV4aXN0aW5nIGNvZGUgaXMgaW5jb25zaXN0
ZW50IGFib3V0IGhvdyBtYW5pcHVsYXRpb24gb2YNCj4gZGxfcmVjYWxsX2xydSBpcyBwcm90ZWN0
ZWQuIE1vc3QgaW5zdGFuY2VzIGRvIHVzZSBzdGF0ZV9sb2NrIGZvcg0KPiB0aGlzIHB1cnBvc2Us
IGJ1dCBhIGZldywgaW5jbHVkaW5nIHRoaXMgb25lLCB1c2UgY2wtPmNsX2xvY2suIERvZXMNCj4g
dGhlIG90aGVyIGluc3RhbmNlIHVzaW5nIGNsX2xvY2sgbmVlZCByZXZpZXcgYW5kIGNvcnJlY3Rp
b24gYXMgd2VsbD8NCj4gDQo+IEknZCBwcmVmZXIgdG8gc2VlIHRoaXMgZml4IG1ha2UgdGhlIHBy
b3RlY3Rpb24gb2YgZGxfcmVjYWxsX2xydQ0KPiBjb25zaXN0ZW50IGV2ZXJ5d2hlcmUuDQoNClRo
ZSBwcm9ibGVtIGFwcGVhcnMgdG8gYmUgdGhhdCB0aGUgc2FtZSBsaXN0IGVudHJ5IGZpZWxkIGRw
LQ0KPmRsX3JlY2FsbF9scnUgaXMgYmVpbmcgcmV1c2VkIGZvciBzZXZlcmFsIGNvbXBsZXRlbHkg
ZGlmZmVyZW50IGxpc3RzOg0KICogY2xwLT5jbF9yZXZva2VkDQogKiBubi0+ZGVsX3JlY2FsbF9s
cnUNCmFuZCB0aGUgb2NjYXNpb25hbCBwcml2YXRlIGxpc3QuDQoNCkl0IGxvb2tzIGFzIGlmIHRo
ZSBpbnRlbnRpb24gaXMgdG8gcHJvdGVjdCBjbHAtPmNsX3Jldm9rZWQgd2l0aCBhDQpzcGlubG9j
ayB0aGF0IGlzIGxvY2FsIHRvIHRoZSBjbGllbnQsIHdoZXJlYXMgbm4tPmRlbF9yZWNhbGxfbHJ1
IGlzDQpwcm90ZWN0ZWQgYnkgYSBnbG9iYWwgbG9jayAoaS5lLiBzdGF0ZV9sb2NrKS4NCg0KSW4g
bW9zdCBjYXNlcyB3aGVyZSB1bmhhc2hfZGVsZWdhdGlvbl9sb2NrZWQoKSBpcyBiZWluZyBjYWxs
ZWQsIHRoZW4gaXQNCmlzIG9idmlvdXMgdGhhdCB0aGUgZGxfcmVjYWxsX2xydSBmaWVsZCBpcyBh
c3NpZ25lZCB0byB0aGUgbm4tDQo+ZGVsX3JlY2FsbF9scnUgbGlzdCwgYW5kIHNvIHN0YXRlX2xv
Y2sgbmVlZHMgdG8gYmUgaGVsZC4NCg0KSG93ZXZlciB0aGUgdHdvIGNhbGxzIHRvIGRlc3Ryb3lf
ZGVsZWdhdGlvbigpIGRvbid0IGFwcGVhciB0byBndWFyYW50ZWUNCmFueXRoaW5nIHcuci50LiB3
aGF0IGRsX3JlY2FsbF9scnUgaXMgYmVpbmcgdXNlZCBmb3IuIFNvIHBlcmhhcHMgdGhvc2UNCmNh
bGxzIG91Z2h0IHRvIGdyYWIgZHAtPmRsX3N0aWQuc2NfY2xpZW50LT5jbF9sb2NrIGJlZm9yZSBj
YWxsaW5nDQp1bmhhc2hfZGVsZWdhdGlvbl9sb2NrZWQoKT8NCg0KVGhlIG90aGVyIHRoaW5nIGlz
IHRoZSBpc3N1ZSBvZiBkbF9yZWNhbGxfbHJ1IGJlaW5nIHB1dCBvbiBwcml2YXRlDQpsaXN0cyAo
aW5jbHVkaW5nIGluIG5mczRfbGF1bmRyb21hdCgpLCBuZnM0X3N0YXRlX3NodXRkb3duX25ldCgp
IGFuZA0KX19kZXN0cm95X2NsaWVudCgpKS4gSSdkIHN1Z2dlc3QgdGhhdCBwcmFjdGljZSBpcyBv
bmx5IHNhZmUgaWYgdGhlIGNhbGwNCnRvIHVuaGFzaF9kZWxlZ2F0aW9uX2xvY2tlZCgpIGlzIGFj
dHVhbGx5IHN1Y2Nlc3NmdWwuIE90aGVyd2lzZSwgdGhlcmUNCmlzIGEgZGFuZ2VyIG9mIGEgcmFj
ZSB3aGVyZSB0aGUgZGVsZWdhdGlvbiBjYW4gYmUgZnJlZWQgd2hpbGUgaXQgaXMgb24NCnRoZSBw
cml2YXRlIGxpc3QuDQoNCj4gDQo+IA0KPiA+IMKgIHNwaW5fdW5sb2NrKCZjbC0+Y2xfbG9jayk7
DQo+ID4gwqAgbmZzNF9wdXRfc3RpZChzKTsNCj4gPiDCoCByZXQgPSBuZnNfb2s7DQo+ID4gLS0g
DQo+ID4gMi40My41DQo+ID4gDQo+IA0KDQotLSANClRyb25kIE15a2xlYnVzdCBMaW51eCBORlMg
Y2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3Bh
Y2UuY29tDQo=

