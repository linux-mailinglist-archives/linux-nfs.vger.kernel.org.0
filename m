Return-Path: <linux-nfs+bounces-5981-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 761E5964926
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Aug 2024 16:54:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D1A72833E4
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Aug 2024 14:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC7C1B1503;
	Thu, 29 Aug 2024 14:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WLtHRTr0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dmWMZNCm"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359D71B14EF;
	Thu, 29 Aug 2024 14:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724943253; cv=fail; b=ul8brgwqNH5DIRn0tqPMzCAQwzOye6t0cVdkGtX861P7yIU8RG9QKk5cQS8d4v6gSRCuWoX25blaPWIuVMJjilBno8zZMfc03yEJ+B8EV+Fmmpr1OtsARWD/5wduk/QUPDDaWf4dXuf2sJ+kPbKk5ILdQmucqHNBIe0daHq2jDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724943253; c=relaxed/simple;
	bh=8IwJ4v7RrBxbvdrIO1a/R13/oATdY+RM+JkiUc2+bFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AT8v4EHhGU1hmQm83FyZr3csOvs37flp+taPXfFfHssYkp9lPcVF23HkRNgEYPv7TWOnMrFLoTQnrwuaUF/Rg6UGzxTvrDblFbi9pZ1tPp3De/OcgFkeLjMzVzyNbN9hXhM9rv0BDpVROGjjfeGBURJq55SVtm9udImcw3Mm8iw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WLtHRTr0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dmWMZNCm; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47TECsoY019559;
	Thu, 29 Aug 2024 14:53:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=Vf76SdyonUIBjs9
	ilukAWIzo0PchiIwAyWm4hXIeGM4=; b=WLtHRTr0YjlyU9iphPd905XuepWjUKZ
	EzNhDFk3+Syc5ui368eQ4No1B55IpVBs02UOe24/4AKuwf30gnDg/B9Whm9CkN93
	kycznfkhKpr2Pkh0xZLnKmT/Wj2YypsCvYS6gWwjQI/aJ6dbksmfnoDe5NGn3jLF
	kdxnUbkiRgBjFwxkY16/zvu9UmxfvDZZ6neYLVHiotq1VFG/ZB2XmhtK1wFgZmKf
	XlXE7rxhrYF2d36f5nimzujCGEiTrkEE8CNxPc2W3iUE07W1S778R2NAE3v77Pm1
	tl5g0v1FqIs4iimOhFYGXYAbqqETN/UFpc6w8RYzsrCGxBx7UpQ6Mjw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41athxr47n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Aug 2024 14:53:57 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47TEPITB010464;
	Thu, 29 Aug 2024 14:53:56 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41894qu059-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Aug 2024 14:53:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yjW3ePgo5w3WntznDhSf4B+h1c8rN44Y9doSEW/oFMJ7k0mDk+0pk0mt4qibgPy2CZtB0KrIHyhGLH70h4WKl8fTJ6m54GT97dJL7cxfsFtxh97aHfYH0VKxJka2RrYvvf99oHBXnbmFjq/wJQ3h9bSsZZZIQ9olAHIhZyVJ7tMjw+v/gbtt48et3+0viLsAfYQpC3y0fUxTh8+iasuO201b/hvj2TZvyXrKRZ0qjfZ3pR5SxXDVsetuR06EI6La7bTw8H10JGkFosiKOfpXWi2y/8408rgSo5Rk978x/v/LiXnX2VSENAkYKGg1Ha8MVDcgcD4Qoyplj6uFUld/4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vf76SdyonUIBjs9ilukAWIzo0PchiIwAyWm4hXIeGM4=;
 b=XUVHrjVEe1nrRObzAwJJ88Z1rhQ/26/0YXZDr85160tyktYN165P8lIUraUpICVe3Vymn4M/PBf2edxfEt8Z1u7SRLeMgJCT07YdIvGjNeghhcpUnO/SFskGGmrGAp3G728YQIVEjXpzPwlt4hE8+mZEEUuwPRwKiV6LbdLceiXtfGniQF4LA59/oMn2iyUcbOlp7DRKuyq/XHJ4dn90xNTH2koZ3zn8iR0ULv/7nwbbVPUDSsz1kCtcJOKyXLpIvsvcsnEfZE7he/++RI+RglMCPW2m5bZYZrnZXk3r0LDfdXVC1MgOw4v2rFfVnGJYbx8mJnfOG6rLpUA3VbxsOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vf76SdyonUIBjs9ilukAWIzo0PchiIwAyWm4hXIeGM4=;
 b=dmWMZNCmqS7nN8RTi9izyQ2tT2DibQUv7Hl1jEiN4HyBAl8FZjmdSeC507vrQD3Wenr0m8iFao4xhQsWLu6lTm0zXY6yfLJpvrRAsDbCMfmZ00LUkEE7xMD0HIRECA/UMflkawOBUb5CweLIfBM0b8BSCYPmg8cwsv6/46rZICs=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY8PR10MB6706.namprd10.prod.outlook.com (2603:10b6:930:92::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.19; Thu, 29 Aug
 2024 14:53:53 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7918.017; Thu, 29 Aug 2024
 14:53:53 +0000
Date: Thu, 29 Aug 2024 10:53:49 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Yan Zhen <yanzhen@vivo.com>
Cc: jlayton@kernel.org, trondmy@kernel.org, anna@kernel.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, opensource.kernel@vivo.com,
        neilb@suse.de, okorniev@redhat.com, tom@talpey.com, Dai.Ngo@oracle.com
Subject: Re: [PATCH net-next v1] sunrpc: Use ERR_CAST() to return
Message-ID: <ZtCLfXUnx9tbwubD@tissot.1015granger.net>
References: <20240829130434.3335629-1-yanzhen@vivo.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829130434.3335629-1-yanzhen@vivo.com>
X-ClientProxiedBy: CH0PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:610:b0::7) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CY8PR10MB6706:EE_
X-MS-Office365-Filtering-Correlation-Id: 75839b8c-7582-40a9-cbfb-08dcc83a668b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ABk0jEN+YOZuwl8I/FYj0FxOSjWilNbzi2rldyJtBBFN/+KsW0tmYIhWhYFJ?=
 =?us-ascii?Q?BcDCdma0651Up0SU1MwcpLGDRdHI9/OfsVBRz+BSnl2tmNpZebiiC2UfbUWN?=
 =?us-ascii?Q?wlB8jbRWUBVNo+x+06aSuOgLK23eDAeglGlpaWHfLlIpUpTom8lclmY8kN4P?=
 =?us-ascii?Q?aLsdQk0zLmk4wzlEz6LK38e3YnKwQ97IrPvCUrygyRL97n9L1yMqw9uoNCDb?=
 =?us-ascii?Q?X/1+UFjijIk0m+D9X/bXW29AbOjULpoWU6fD1a2yATFYJPr/yTHRhjL9bR9/?=
 =?us-ascii?Q?RPE7t6vuDr/MOxL0ezVJjQFrK3r7fYjg+Rtz9n2OfdbLDLrRFvhSkef6Qahh?=
 =?us-ascii?Q?5SLCgE4X87esrV9iM24ynx9XN/HDTD++ZKHWPF42XUvskx3emv/J9VcCbRgd?=
 =?us-ascii?Q?Wx2sK2jp5cxo9fRWCZERbeG5UiyH6jLP4ycvinBsMJTk7J7AagW++XBqdNDF?=
 =?us-ascii?Q?EdImjZApOaFrLuIkJwboEzdd6uW+Gvhs9T2mkOIH3WUB5fYMeXJAPIDVSVwS?=
 =?us-ascii?Q?O+ksv7HTm5LZTNy4CB7b2Rs9JZ/l30xZVADUd1WBvV0G8eFrN2pB2WVWMxvz?=
 =?us-ascii?Q?FCBhENQhW4BQTDLRBV31hloB5Oq4Mlc8mNLZD9O9PA/fSgedIzat34MArm78?=
 =?us-ascii?Q?EP/Lx2ngyenfXlyEhLncvu3JT9Oi6Cwi2OWIBiToj1kx003DzHcdix7ORJ7S?=
 =?us-ascii?Q?onRBurCRf1apiTeJRpS2gWgnBYrHhkNvibHO2qfdwqQf1Sr4W1/U2HvzQFNq?=
 =?us-ascii?Q?6SWF3C0UjjQt6Bazc29QYBe1ZtsKofo6JQf6tcM4LooJHLXUNkOScSAs+kvC?=
 =?us-ascii?Q?+zlpeRD9mpsa3JjswG81ABJ/GicNe7nBv3/XNE4+cVr5IEFmUMXrOavjvS1q?=
 =?us-ascii?Q?3ZDHNEapErJBL3OKbERtbDpmznhkvRXRyHG58IOxSFNyF1iWmVVlbo+J2HAO?=
 =?us-ascii?Q?OzAs1LhiAuUXByoHZ6IJP1JmTDNwgl9RUXRtT4xUltXozUQcb6aU3NzWYvMj?=
 =?us-ascii?Q?danVdc7LGkpdOstV+h4vPDYcJAHsKTL7qWWOfEl37TfqR354tS6zejuACCjZ?=
 =?us-ascii?Q?0X/UGpANDUITjM5JDYJcNPyLK9C6ZaQdrwsLbfnwNuHVW0nXWmHvI1CdPAen?=
 =?us-ascii?Q?/4Lf5AQdKy7NsvzAJefoo6gs1wz7IGUu5l0W6LMcnMI/a1877Ip563XQxcsT?=
 =?us-ascii?Q?Zpj6aZiFkNUEhJBMU3O/NnPWtug/aDB6P62s9KyrVsaYWT2RCDFKa3YTnySu?=
 =?us-ascii?Q?gMrjY654Qtvj8YQJRWwr8UqRDmxg0hqvr8I/0HhuP2con6JtfR2FLLgid6aN?=
 =?us-ascii?Q?LXjsmiEdDgEVSmVtadGOSPl9sAyC60QaOHxi13PS2n63Eg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?h6TXfxXenaHFANsf2mCMTz6NgbtARnkRb09+VrKIIIzrFSs9NyjWuMxL3XRV?=
 =?us-ascii?Q?BVGRPMY3VzFsukpOgz6NeLGKcULfN9guXNV0rjnNEq4pDH94x/yFokGvY4ej?=
 =?us-ascii?Q?VzVgqT44yt4q0M1gK/xLqacIDKX5l28kTMbJOLKJyBWxkEzCVfWVUWKlRfLr?=
 =?us-ascii?Q?UUl1iSIxiQvbFzUFiIwOBaJvO7BifPVQv+2oTWXmY8SxefRW/KjQME5chdxz?=
 =?us-ascii?Q?4Wza3d0/7naG9w+a/CMIKYwPZj2yk8ZCRQsiUy2o8aq/YhvfStrhqrarghYu?=
 =?us-ascii?Q?xZbom9Pdg6OxkULysG0mQGH1tspeVM2NY3hqcnEv0ccuWVYvBsYfaSQHobh1?=
 =?us-ascii?Q?m8vWQfTzuPMsCMB0WGvmYFxowk4pSn/InlX4BwZTHmip50JVTBBblMk8ds8E?=
 =?us-ascii?Q?7SB3Kt08jO4akXxGDLhnfkqB1cX7QhrQ/uy5V65/T8pth1DSaOo+z311eid3?=
 =?us-ascii?Q?s7ASLkhpf2eyE5j9kF+vbSP7NnkbcTxVYKjN4mpw9wrlZWdF79LIRPAN/U6Y?=
 =?us-ascii?Q?z+z/1qobIEt+2rL2t7aDYPr5gjywNUZudEITEbcwEoL1DDosKLn8ntmd7KZx?=
 =?us-ascii?Q?kj+YpVhywZ2fXyz0cr1IVwZ3TDrZFdqhFCJN9xASZysuoYWO87QzO5c424qn?=
 =?us-ascii?Q?XtTYM8IDjWoP7vo+r1m4O4HKgQdnIkfwMtYRbwTSS5DELcgBeMFZ3bPO1jkl?=
 =?us-ascii?Q?X5oBD8GJ2jxOuiLu/fHcQOHMh4SnfkW6MfSPUWzafJICkKHQjK0vavnL90QR?=
 =?us-ascii?Q?ryNdyTT46kVQUftJ6F78QZIUdfW3nA92cj948LPL34rjMHAZh92zmZkMiQmV?=
 =?us-ascii?Q?s5/Lh79Ejn8iPgRHHF0jbQ+GeLO6H4NQb+dTz5+UWKVXaikiD8+adxC1ySoL?=
 =?us-ascii?Q?8O5CRAk1Kj4h89mpj9o4kZljYhmHLvLVO7hMyXS98dalBCL1Sp4HcyJgea88?=
 =?us-ascii?Q?8Z2KcXEnMfBbOi8EYRpGD9eXoapf6sZ13qDHcT33AdRXrqTVyJadEZ5E6EYZ?=
 =?us-ascii?Q?kU8uHQcK+IwBLVQq1NrP56IBY7IaPaBZK3e8Z1SHGnIan3rrX1a/ygE5m4Bz?=
 =?us-ascii?Q?lOqpMgoDJqDHrL8x9GEmhyav2tPyeqLB/Gnydhm+8IrWPVE7b0gCpytxOP6B?=
 =?us-ascii?Q?OwbEyoOkWBpld0QTcDa5/hKls4ewTXS+7IKXKC90r2WIkDtDkA0xX6cDhHMw?=
 =?us-ascii?Q?NKDzL92GPg4xVeoIDUhoD8YgkW0QysdkJOmlD2DU6D/QY1oKoEUj//SgZfKs?=
 =?us-ascii?Q?QZd/FAEITlCh2uzDyoJiKLlgMyCIS5QVvu//Tt+QQysdMtw4VBYsXIanRWz6?=
 =?us-ascii?Q?w0Yw69TPXZMwfJBmOWyZpaHpIzoAUlEf02WRf4snjoHjFyNzc8OffIJXUM5m?=
 =?us-ascii?Q?kEO+kWP+JKy4i3p5UshIT4f2Ch2UNCaZ5p+ShyeMtbKCE/hHv86pvKvrI3WH?=
 =?us-ascii?Q?8Zjx/SwR8lLXSVKrtC6OMf8DABomRnZ0AkDdNa8J/kwRUoTU+SViLY5dfvpn?=
 =?us-ascii?Q?5fgmJxznymcwKP45IZK9ztUhbGcxjE/GR5pMv12d2RL6a12Mzhj2rh7JgPge?=
 =?us-ascii?Q?FhB3mvPrE5hnK4+5X/KOEa12vRMsn7F5aol1DmA3Jp9VcX4XQNa59fpbgvOL?=
 =?us-ascii?Q?Ng=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	97nGS7bq5kDGyqlQiAk85Z1g0QRsKJ5Ov66z/yabe527eHutVxbqUrOmjjlriMdx3S/+sK2yBAu3dSD14iN7hhqBqsJN9LWQeSxvcVzxTtwPaD5pkFgtbcsVrgffPzwgZi2pg+Q3f0V79wzIuhPflqzaLRK7S2di2I7IhfX80vqkSSKF8vYL0n4UpJkYsMgdZcl4w7Q8wilZdXez0xRo0ak2y54LtCwE+AuZdI8GeI/NQrTbtJ9vh8bQpTlYLZl/iOuWeriNWDFGhq08Ypc9uV7UdFATXSNxeeTnPOpfy7GdcQzbiL10o0JaP3hluI61etuk1YnAfU5NCOj8RUhJCn4WvrqcJ7E8ISfN5kQLMGpMseoEvYerPTNYObyMDYF39U7RApuob+TrQmu4sxhJux+UFrcaLmJ0NNlFkcNAQGABmaogfWy3AsBRcZlPYMkOnBtjPXip8ZdwcZy8JloI3ZPjQo3Bwy44t6AZQMPKXxaksnZLgPBjzKDxoqqoBMPgfTX4AWWmPybbPflyagt07UbvjRQswDaFyQceLVXVSJb3WP+eInQsKZqNIjNxB3B0n9tlIikcsXM9ZLraHiukFiw+eENXF+JmDrsbv6gSlqE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75839b8c-7582-40a9-cbfb-08dcc83a668b
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 14:53:53.4989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dpFme5Dqz+015p6UAJ8YBCKCxFOpL+oG+vi4zqZb4bMfsfYjqd8gmBkiMIE/2tA6xbwlW5JhhBoviwUZtrWlPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6706
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-29_03,2024-08-29_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 spamscore=0
 mlxlogscore=957 adultscore=0 suspectscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408290104
X-Proofpoint-GUID: XBqbo22vqTAGIOg13Ij366ukwdoo5Gtg
X-Proofpoint-ORIG-GUID: XBqbo22vqTAGIOg13Ij366ukwdoo5Gtg

On Thu, Aug 29, 2024 at 09:04:34PM +0800, Yan Zhen wrote:
> Using ERR_CAST() is more reasonable and safer, When it is necessary
> to convert the type of an error pointer and return it.
> 
> Signed-off-by: Yan Zhen <yanzhen@vivo.com>
> ---
>  net/sunrpc/clnt.c                        | 2 +-
>  net/sunrpc/xprtrdma/svc_rdma_transport.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
> index 09f29a95f2bc..8ee87311b348 100644
> --- a/net/sunrpc/clnt.c
> +++ b/net/sunrpc/clnt.c
> @@ -603,7 +603,7 @@ struct rpc_clnt *rpc_create(struct rpc_create_args *args)
>  
>  	xprt = xprt_create_transport(&xprtargs);
>  	if (IS_ERR(xprt))
> -		return (struct rpc_clnt *)xprt;
> +		return ERR_CAST(xprt);
>  
>  	/*
>  	 * By default, kernel RPC client connects from a reserved port.
> diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
> index 581cc5ed7c0c..c3fbf0779d4a 100644
> --- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
> +++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
> @@ -369,7 +369,7 @@ static struct svc_xprt *svc_rdma_create(struct svc_serv *serv,
>  	listen_id = svc_rdma_create_listen_id(net, sa, cma_xprt);
>  	if (IS_ERR(listen_id)) {
>  		kfree(cma_xprt);
> -		return (struct svc_xprt *)listen_id;
> +		return ERR_CAST(listen_id);
>  	}
>  	cma_xprt->sc_cm_id = listen_id;
>  
> -- 
> 2.34.1
> 
> 

These two hunks should go through separate trees, I think.

The clnt.c hunk needs to go through Anna and Trond's NFS client
tree, and the svc_rdma_transport.c hunk can go through the NFSD
tree (ie, To: me and Jeff).

Can you send two separate patches, please? The RDMA hunk looks OK to
me and I plan to apply it upon receipt of a separate patch.

-- 
Chuck Lever

