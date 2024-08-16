Return-Path: <linux-nfs+bounces-5424-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 901489553B1
	for <lists+linux-nfs@lfdr.de>; Sat, 17 Aug 2024 01:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 016EA1F222DD
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Aug 2024 23:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F9E145B39;
	Fri, 16 Aug 2024 23:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZLMMweeP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cG/db0A5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27082145A07;
	Fri, 16 Aug 2024 23:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723849970; cv=fail; b=d8/GCma2DRviHRWPV2j0tm36K2mioEPeslSvds+Q2t3jDkDS/4Wy7W1s9gsTRT3aYEasHzC3cbny1ORvQk8KwdqyReWSTZIpRRA96bLCwRBenjweqmybvy3H43UOXH3GLfDJOE7WuTW4HZJNztCTFZGicG4GdQ0v3aar3T7ob9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723849970; c=relaxed/simple;
	bh=haudEAiM7Uw0d+VmdzDh7DEcuCBOuZ59ZMFM2ezegzg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=gdMqg7db8kmwexkB5eEqcAipxfcST/BR0RNceI3AnQH2RgPXiL39eHNCot2p1V9j7f6X4L/UEgcGxWCBrOXlCNZ4XK70VWcmCdvveX5QyDXCKkSoHbtYYgA5EqGzKPDN0sp146W9J6KX/uFjRnVQAY+/+Fvt869J+icgF/cxf5c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZLMMweeP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cG/db0A5; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47GLBvQa024871;
	Fri, 16 Aug 2024 23:12:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:in-reply-to:references:date:message-id
	:content-type:mime-version; s=corp-2023-11-20; bh=zq/oo1yXY1DflT
	HhdhFcpKIyZ2V+XGuYvXJVukGRejw=; b=ZLMMweePXQiY6BvrWFefh2RxTEWJwU
	SnxdUlrAhAgXfC/udduZ718kbtMFMe33d0VEEc6zjvCIG5F7iC4MiDPsb3TDE7ZH
	2qocKdXg/t4PB0AfqdGWk+VPhYD1q7V9EGl5O2AYvO386Xz5HL61v6ppva2Q3B3T
	wVV47hYfPKYgtF/EirHzUFgW5ZhoXmLt3+Tu0yD70gOMdkGGKuHFc7b/CuzOmhjA
	6kz+0PXn9W/G7DXeIPo1FnjiH7zH0/nyiFSRF2yGETBuULbDSCtAmcpGG4+qtGwb
	caS/3Xf6XHRKXvfalpY8HWeFgJBvjzHWSpSja1s1mZgMp4Hbo2gH9Pow==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4104garggn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Aug 2024 23:12:38 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47GM8aZQ003805;
	Fri, 16 Aug 2024 23:12:38 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40wxndxh5m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Aug 2024 23:12:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qx4ruxH+aqE4s9xC9wqv02RID0NGlSEn8TZFq6sOaKwCPqy11BBvh51Fxp+cFPZwFu8mVQnBFQ8SEDMPRIdPeU96Tjzxuaytw5CcP41kMgBUPWxAdHj81aBvT9rdD80jhMDGAg2BdwhJq574PsWSkKO8tYSDoZ5PoKZN3dowvT99/lSYgbK/V1rjsch9blPoVMvme5E4HE5h8mjVyq0P65VNgb427pyMF3jKiioOBQ6me4lIgOdPd8pxdMQonRkrogjdBya8xa6zL4IgVch923rBNCsejC4vO2fYU0saCnZGN175vY/VueqbGsR34uMsbDPjrWkKjJz0OhUqrHkAEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zq/oo1yXY1DflTHhdhFcpKIyZ2V+XGuYvXJVukGRejw=;
 b=ZeN0kQtzzb6mPhMSiWKh3WMbBYf/Os0ILiLtNWZ3S9dzuLqO3MhrYXmCbxBUTvdltLncu/isU+ZAEFxHz6ZUR4ObqKlCx2NCvEvW8m+4/8SV/OJyfV8JRO3+wDEoIhvUrjz7gTxO08+Q4Ux8wFZg1YzavZ4yqbeW156+ECVZLkrMSHM65BdFTxKUo3+syexlh6mj4w2JAbm9srIvqEkvGbJVsXxBUwHI07CzhgfXedPtExvgkqD12Dj+b1wZtbF2Fi2J8oNfdj2zRtHySSPCdfFd4uMnXC6jW0SUpRwPaJODBOBztizgGFI1Pbu/9+CyxkuVTMvvg939ZgJIHDc71g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zq/oo1yXY1DflTHhdhFcpKIyZ2V+XGuYvXJVukGRejw=;
 b=cG/db0A5qr6ZZNg8jh6OSUjcwJnoexur50bBph0O0wlwWKD9ztZId4eLJSGMsh05cslBLGQggp0/thWZcR10TwWt3K5eqXdMSTOZXKoHi3Iy41gYQ/LH19sVM9NDf9CPgUp+yS5LRG2mUM9FHwi/QZLCIrJrADR7OaQJDwsnIAY=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by LV3PR10MB8154.namprd10.prod.outlook.com (2603:10b6:408:290::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.11; Fri, 16 Aug
 2024 23:12:36 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca%4]) with mapi id 15.20.7897.009; Fri, 16 Aug 2024
 23:12:36 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: NeilBrown <neilb@suse.de>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
        Tom Talpey <tom@talpey.com>, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-debuggers@vger.kernel.org,
        Dai Ngo
 <Dai.Ngo@oracle.com>, Jeff Layton <jlayton@kernel.org>,
        Chuck Lever
 <chuck.lever@oracle.com>
Subject: Re: [PATCH 1/1] SUNRPC: convert RPC_TASK_* constants to enum
In-Reply-To: <172384934590.6062.4979843897031230836@noble.neil.brown.name>
References: <20240816220604.2688389-1-stephen.s.brennan@oracle.com>
 <20240816220604.2688389-2-stephen.s.brennan@oracle.com>
 <172384934590.6062.4979843897031230836@noble.neil.brown.name>
Date: Fri, 16 Aug 2024 16:12:35 -0700
Message-ID: <87ttfkoye4.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0221.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::16) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|LV3PR10MB8154:EE_
X-MS-Office365-Filtering-Correlation-Id: d3dca931-21f9-4be5-5d24-08dcbe48ea62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GL2K8tpVh4dU+a4SxvVFzeusSU09VSGzPhoPe95IunBTTArLyGgFHI1Ok3cd?=
 =?us-ascii?Q?mEb2wyPdhwexD7y6temiUct9UUUL4clzLDkl4Mnsd0ih3Dkwqx5ayxmUwNRf?=
 =?us-ascii?Q?krW7tmSwhySTeckN+zSIloejVTDiHL13lIiroww4BW6em5bCEvsngYQucbIi?=
 =?us-ascii?Q?cDWv1gG7EGfPRlWSBY1GLwAVkCCVk1BDWfE4I5s+ZM9Hoawrtjtn6qHSDEyu?=
 =?us-ascii?Q?elbgDw6oDcKycNbsf95v7988KCHkCob0lXqpUjZLKwAU5jyfmpcOWSbNZbMW?=
 =?us-ascii?Q?x+hEP2HuoLcPBZ6F3+ed4wYg8I/a+Hz2E0nSvUtwUhI/duPdpfqHKoMg/blu?=
 =?us-ascii?Q?I/2r1ZDvWJ85cDmCjPT33KJdddAW/OGU2mhCTHcpuOjDdd8/F7YrS7AGDMSC?=
 =?us-ascii?Q?9yXTzGv6l8ox7k9oCm3PWUe73YazpBKPLcwS8EpYxeANq/dJqv75EQF7P2Wc?=
 =?us-ascii?Q?i5SaSQDfG2tsxj6QX9NMa3cK7UESGeHtuqMJUTnu+dQ6r6OcTtq3vuWSde1a?=
 =?us-ascii?Q?vhKBrIv3yCQ6LFaLuivrcb3DKTfimTFmnM905SJxDLa9nLUQSfhL/U0rIeZd?=
 =?us-ascii?Q?1InwMSeNJGVlknlccPBsxcwppPYFoVBaFL8HVIU5jIwWIs+X0rPdmSl8GwDv?=
 =?us-ascii?Q?hy8khf4d6pVnSjAM+Z/ynESN9vSFs9NvqxICkjaSqqYoSw147z7fHBs5S6EC?=
 =?us-ascii?Q?McrzTmXPu6Iq6l/nEuBX1dUntEB0yvLEoljDpxC6fEtzbpw4ig+ZhoMz3P7g?=
 =?us-ascii?Q?nLUfflvdJLKmf8W+IZBAPbEZJRl2sYEWXdW4bC/M6TnkEXps7iF9G1RquCAv?=
 =?us-ascii?Q?4Ho8owCkDbzTLEphbkTIhFw2t2L83AnR9wcZTrUS4rWpSqEjY0CVvb+rALRF?=
 =?us-ascii?Q?u3Prz6u5FxXthwI4epay9vXHrJvX7pFo1eH8+Z+xqPii3nNupZ+1D0mBBNJS?=
 =?us-ascii?Q?trgHmE9ftLoiitznj7fVpOg8Az94/HYKFjG0eCmK4wM+jFBuqsXgxmqFykGG?=
 =?us-ascii?Q?FTctPJZ07xCe5DjopItFYdhqLbRO4xkG2zHfcebX9UnKWQB432yvZUCJTfx+?=
 =?us-ascii?Q?6Exl7dcEtPSe2qkcmTmHtBsC+IUgDaBJgc7ZKU/0AuOhPR7JTT6HeM9EyE/R?=
 =?us-ascii?Q?OAqycS9rdZhE1bepxOyf+Hre3NNUiVqW12K3pyDUJ6vMJPP7d+U+L3EXJ5RZ?=
 =?us-ascii?Q?yU2eHXcYpTlTskfA5kS6E8Dxj8lKPx19fNQGbKxS+Q9EMtr05CEk6TjRn6kC?=
 =?us-ascii?Q?o8RxbmwPA63/mpmDPLXS+j9IUnUdbrGE1S45pq9yGEMYmb8DgpeQ043IKpzt?=
 =?us-ascii?Q?aE9zUpA7zRt3FvXtksONJyQEHJyQBFRJBCXvI7aBpeDwnA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6597.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iLNOIJsTaYl9uw2HJyyVqdJUiL5wxhPVn3fVnYwBoJSTfx9pI8O4vTFsmXRJ?=
 =?us-ascii?Q?Auo4DftkiGiSmcO74pTsi+TdgTy7EWtKthKzVbGFfQBZJfoOlimmdC+Wsc5C?=
 =?us-ascii?Q?HRTM8RfBU9IRbMRT4pEYD2UnsSr2yWP2xFS3/lVq0qGmzjiyROiMDdEB0VGs?=
 =?us-ascii?Q?HdA5Bg+omGjXsnRDT8bytqjKJckqbaOmB0IELQv/JTTAZ5UsKCExZJyRVEU3?=
 =?us-ascii?Q?GW0/9WeJXRwGxus+XllxowEnVQQ2caH7K8LtuN8vGboZktHC6et2gQFodDmx?=
 =?us-ascii?Q?C1JABunkCalbvZx7dW5vXzgjBIfttkp8QLf8TIrWUiY1ddz2GUqz/9Zw6QrL?=
 =?us-ascii?Q?WaFvrkMl/3R3zfolu7sCizE+AJchukdDVNyfqVdFqX71xEBVgE4x+Q7pjgsb?=
 =?us-ascii?Q?mHY66FfGrmkAtiMzOU49tXifjfBlGcwCaPzdBQhmarqIrendpRP1FbIqtGFR?=
 =?us-ascii?Q?Qxgnqmsdwb5bd0hLIiYveBkL8SJXBadAQEYpPPBEhrBzVXJEmqnupNlYmE41?=
 =?us-ascii?Q?14zcmxEOMuTNwT/5CgSzT2Zm6iECLTw7rKpdAXJ+11EymRtS2AsZRQjK8bwj?=
 =?us-ascii?Q?K+kTEQbc+icsFm8csGXcdG8LiLRC3uZxB3YaKeFgTP8qGz2dC6Zu4xeLIZC0?=
 =?us-ascii?Q?WaASLtyaNUlSi4o6ovpFJUCngFGKBAqlGXHMdK1SItMX0tA0lQ03AQQMgUZa?=
 =?us-ascii?Q?BmP7I/dNrzjxbxghGGl3Q+f58csmrAu1JSGfCeQDxps7nj9eOKxJTdECC5k7?=
 =?us-ascii?Q?mK3Oc+XyGwKsXDhLCD8TJDryUm9A/wbkeI9qg8xepvDmIBiRg1geBGCe4gYu?=
 =?us-ascii?Q?0V7gQ/9+d2EgHALo9S/7gjKJ15w/zooL/xBKaa8SH1TG5UuajcxvHO8WBBbj?=
 =?us-ascii?Q?DuHR2h2IIni4GS+/YQK/roAj0IxTYP7UpugdA0zq//KHN6GLfFDl+3OIdb4k?=
 =?us-ascii?Q?nDxp66qAOyB8kMTDG+ao/VJipfy9OCNtZL3T5DrMZcmXB4WIA3JUihA3ovi8?=
 =?us-ascii?Q?+yEZ+R0EHiTyOD1baqxR3jhAIEMsJBmS5dH8hTqeCJcEs/Q6Oo4ijgVyCKNr?=
 =?us-ascii?Q?wtTq9oc16AiVTUv4jUCfCnziGOwkmB7sGGeXAoEhTdOB10Fky0qEYcdYgmlM?=
 =?us-ascii?Q?QbiVuOKBC9tx+4dS1UplaxmiRR+Zpbd9CzdhBibq7mj/3PBq2bkNmtlhxs42?=
 =?us-ascii?Q?p8WlfRwlswJEOZKJKL9+bAXPeuTAAuiSe46XOCQABZ3TTvtj8TK1/hbomglE?=
 =?us-ascii?Q?SHC9rR3f3pisOLRkVLHhxtnAVeDWJOEjnmql28MDWaYXr0o19/lCPeut7zEo?=
 =?us-ascii?Q?OEKNteO9UGWxcdYlIG2sehVqWtqSfjVGuQcHe422UH52QwOnx/txD+e7XwB3?=
 =?us-ascii?Q?hNmWdqOUpiURc0npAbDbSwiSWZQZ6mb4o6rb8O0idDtRdk+is9EXFhBu30/Q?=
 =?us-ascii?Q?4NMPDCryqD0A+aUWBxZpdIybKwn+Ikw9xiGG3hjHFkmV81MeDhH62aX7CCee?=
 =?us-ascii?Q?lL0S90QpjiScj+yKb0xZ9c+2xn6AmNr3/kf/oLMwzoG2LP241OLf7z2ksFdH?=
 =?us-ascii?Q?Bas8LkiSwwn/4rj2UJGw6oDBrhi18qK8f/jGa9npfu1Bd4L989Tg5ocSqX2Y?=
 =?us-ascii?Q?5w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	usEqlkTZBvzCZgeCCTjudeiKEsHT4zOCoZ/dvwBABJ0gJetBOlkWkgEqMsV8k1Nec0KOXbN6MWQLlyYQGpzozV12OXWrldiTq7SLBIwix0MpbpwHh0yPmLs/ArCUyDfYOQ8vgcBPseKtQa23CRGLuhK99m5aHWDaCpOLQF3YeEt9DJ7rKlv5vaSiQVPc/1LA7LYa3N1kJv/SIjIQwDqKK653fYMLSefc30B60EytrdYZ8bAdEdnHsupdjNJOKBhnLRhzNs6Ih9jhOuu1ZsC936B+TNj+uWpGqkrcwjDiC8heUiZI7XlQnWidjSx1ydzChAqxv5yedZqzyfWanEWLZmC2YpCLo3/AKDcbSg8FXSEmh6EfrAwAw4TcxgSv4zFEKgscNv21cr4fSEzBbuCrbOQwL4hhJDRaScwLGPGXL7cO+WOBzcvZi63qGVuD6EXuDgRMXS0FeOqhfh8HGAet/dvbfjtUD9nEJS3YVemP7OErdi9hcEWHlZMng1gH8S31RlHqJlEE/opWOO/PuoPcpkr5UQSXLg4m8DBmnEGT2lgq2qvCudk3IPXSFICoFBkeyxva5FqqUbASfJV81mEm9JRgFq+jGB9wOHdfAEOSLLY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3dca931-21f9-4be5-5d24-08dcbe48ea62
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 23:12:36.0256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d1pqWfYlzGCIsflZQcYldmbQ2HcyjnyHT7e6D2wzwlDN//11syMH55qJfhS79iM7d7Fh9yMYnAzRrm4Q5WEsDcBtXae3jnVa2ANoU/uTTy8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8154
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-16_16,2024-08-16_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408160165
X-Proofpoint-GUID: R9UuiADBHdEFjZ9gL1DhFdI_tbKOV4H6
X-Proofpoint-ORIG-GUID: R9UuiADBHdEFjZ9gL1DhFdI_tbKOV4H6

"NeilBrown" <neilb@suse.de> writes:
> On Sat, 17 Aug 2024, Stephen Brennan wrote:
>> The RPC_TASK_* constants are defined as macros, which means that most
>> kernel builds will not contain their definitions in the debuginfo.
>> However, it's quite useful for debuggers to be able to view the task
>> state constant and interpret it correctly. Conversion to an enum will
>> ensure the constants are present in debuginfo and can be interpreted by
>> debuggers without needing to hard-code them and track their changes.
>> 
>> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
>> ---
>>  include/linux/sunrpc/sched.h | 16 +++++++++-------
>>  1 file changed, 9 insertions(+), 7 deletions(-)
>> 
>> diff --git a/include/linux/sunrpc/sched.h b/include/linux/sunrpc/sched.h
>> index 0c77ba488bbae..177220524eb5d 100644
>> --- a/include/linux/sunrpc/sched.h
>> +++ b/include/linux/sunrpc/sched.h
>> @@ -151,13 +151,15 @@ struct rpc_task_setup {
>>  #define RPC_WAS_SENT(t)		((t)->tk_flags & RPC_TASK_SENT)
>>  #define RPC_IS_MOVEABLE(t)	((t)->tk_flags & RPC_TASK_MOVEABLE)
>>  
>> -#define RPC_TASK_RUNNING	0
>> -#define RPC_TASK_QUEUED		1
>> -#define RPC_TASK_ACTIVE		2
>> -#define RPC_TASK_NEED_XMIT	3
>> -#define RPC_TASK_NEED_RECV	4
>> -#define RPC_TASK_MSG_PIN_WAIT	5
>> -#define RPC_TASK_SIGNALLED	6
>> +enum {
>> +	RPC_TASK_RUNNING	= 0,
>> +	RPC_TASK_QUEUED		= 1,
>> +	RPC_TASK_ACTIVE		= 2,
>> +	RPC_TASK_NEED_XMIT	= 3,
>> +	RPC_TASK_NEED_RECV	= 4,
>> +	RPC_TASK_MSG_PIN_WAIT	= 5,
>> +	RPC_TASK_SIGNALLED	= 6,
>> +};
>
> I am strongly in favour of converting these #defines to an enum, but
> having the explicit assignments in the enum is pure noise adding no
> value at all.

I agree, I only included it in case reviewers would prefer to be able to
see the values, as they were with the #defines. But I think it's common
knowledge that enums start at 0 and increment by 1.

> Would you consider resubmiting as a simple enum that uses the default
> values?

Definitely!

Thanks,
Stephen

