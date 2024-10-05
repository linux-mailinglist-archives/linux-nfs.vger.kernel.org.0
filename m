Return-Path: <linux-nfs+bounces-6889-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5BA299191A
	for <lists+linux-nfs@lfdr.de>; Sat,  5 Oct 2024 19:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89B3E2830D1
	for <lists+linux-nfs@lfdr.de>; Sat,  5 Oct 2024 17:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B423158DA7;
	Sat,  5 Oct 2024 17:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JPzjcKsK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UeRI/YnK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40CC158D96;
	Sat,  5 Oct 2024 17:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728151031; cv=fail; b=Zv6QScBsbMc2mXuMTWGnNSif5lO7x6XWAIRNGNdGrj8W4yrjg4gjiUpG2Q/h/Ntg/enhHQlxSKzqTcDHkuIWodhwa/Zxs9KwOS4NDMCOL9B8xkX2950tBcBytTGfXNhWpb3qvehp60PmAx1cOxFnAMPeH0d8xYcsU0jJHTZmU64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728151031; c=relaxed/simple;
	bh=Ko32WEchyuRmIxHorQ3R0/qXQMcgUzt30wZPGBALMK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=C60oQ3100Q2Bo0img70+BZikyRJ3P+/vZJ57rRyebMAu6WHlUr2gqEDIqGkuu/hb5NxGxq1Bn64goXBeTsMzffGMXZg03ibVdTqhZeFT5ZWg+Wyo/1hJdjFTHcXxzFyRcEKVZhE6ws9CcTVym6KW8qXN5V9Q2kfNjtwYqCWWEhY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JPzjcKsK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UeRI/YnK; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 495FZjw0009185;
	Sat, 5 Oct 2024 17:57:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=dZe3JQ6Y+rU9dpTKUr
	z+gunzWh8RgAcKb1zDxqCoG0I=; b=JPzjcKsKTFMD3eQkyInNY6OKTADw5CvldC
	uXgkPtFzsgwbGmpxDe80lb3trXAPxN1yMCJ6QOKoJpkDIkGxtWcAy6bTW3v1/CHu
	yiy1OPQNN3Lr2pT5t+qhzL1K7ssrURwee2Sg+EEVdADU9bXA2faX4nXYhWEASxK2
	ylgfzl8NSgZ2BEt7FkrRRXAYIqPZrWogeNsV1iph2DobmD58iLUXAJeEByBqaaf2
	0Z2rfiRYPLGg8F9Oc1oUJELsHXbMWgGzkCeDJ60cWsjLZ7/mamODcoYJMrGizfI3
	dDxWmC9eNt+SMwtErZJWIRtt9vPScW6hhJgh2DU65fXeXRsAtNdw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 423034geeg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 05 Oct 2024 17:57:02 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 495G5RqI003051;
	Sat, 5 Oct 2024 17:57:02 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 422uwanq5p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 05 Oct 2024 17:57:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c/eQSPf6Vv8D7NMnPFGtVO0Sw5A5nf9EneV0bqWqFLzHUh1tsGs8eWDWHSxsrPYsEThDNJvaId6YP7b72ajkngsFsKViSZs8Fokf/kZ/PcZfG1sRW3foh5npEm7nFMu0Pui2NeDMT8iDsWZt5B9pEivFax34qk6+Q8dkZXRqcGW5y5UM0VesIWmMy109idWJwT9OHTQXVDLQFaUh9+SQu3K9YuDXL0gE4V+hKRy2yJfJN1NWvmQiIoWHkxXNnqb988SdZqThcV+c+DYsUYVeYLtl1tshT6Yn3JT7OguI9iQ8G4rltj4fH+N8rcsIZtVN3V3kLgiU99g2VEPYWlECRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dZe3JQ6Y+rU9dpTKUrz+gunzWh8RgAcKb1zDxqCoG0I=;
 b=TDoMWSj4R6b4XGS5WKg6oecpD8ZImP1xvOURdv1dIjMSQX5cbtEgOEorQfsr1xDNWmvM950PjLZnmPduWeEspPPgdNWGe3VD42xGzijuyObbM4epN4jxLyWAD87Gw20nthhuIYI6QfjS50nLcAQsAHt5faerdAUsDGTJdLg7QHyBJJoy8fEFrozwOOFb+HbqLeVFQZbub04yERYKsNQxoObjuUJzniTV/QUFlBLDDvrxktlTXMpVJ69iPLQjW6IvCQcLbuygzBDT+tMPTzFRFWJ9Ofc7l4fzkkiYJmMaEAABlCaVxMYtg8Jq1N8Ddsv8tkdeOswRwv/GzHJ3IsLgfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dZe3JQ6Y+rU9dpTKUrz+gunzWh8RgAcKb1zDxqCoG0I=;
 b=UeRI/YnKy5ou5GGXbtob5Q/XquLdeqzGIoesXgay50NXl5WQWlWVGh8iZznKCmSEstRf+zwKsIaBBrNTqpdlefN1tUmkq74ecW1KnHG/8rjidM5uwQHGmoAmUnBolwrmSH+mlVTP7MiPVRugLKpvTi4YWLd4cukII09E9w9AW2k=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB5879.namprd10.prod.outlook.com (2603:10b6:510:130::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20; Sat, 5 Oct
 2024 17:57:00 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8026.019; Sat, 5 Oct 2024
 17:57:00 +0000
Date: Sat, 5 Oct 2024 13:56:57 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>, neilb@suse.de
Subject: Re: [PATCH 1/1] nfsd: fix possible badness in FREE_STATEID
Message-ID: <ZwF96Z8i3XcxDe/z@tissot.1015granger.net>
References: <20241004220403.50034-1-okorniev@redhat.com>
 <ZwFS6P3Ni7KdTyJs@tissot.1015granger.net>
 <dad98a83996fd40909eedab57b5c050d1b6662a6.camel@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dad98a83996fd40909eedab57b5c050d1b6662a6.camel@kernel.org>
X-ClientProxiedBy: CH0PR03CA0346.namprd03.prod.outlook.com
 (2603:10b6:610:11a::32) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH7PR10MB5879:EE_
X-MS-Office365-Filtering-Correlation-Id: 5810cf65-0b42-4f51-a5a3-08dce5671c94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3tfv/0NxshT40DlIdEDQusOHoIjnd+3X64rTJjRK07u+zr/qXxVXRAR5Cqfq?=
 =?us-ascii?Q?JY1+gQIjbfGWRSmmbkEqqdF095VpmSybiJbIA1/HNhadKhjaGTkwsrAGBfVA?=
 =?us-ascii?Q?wfBRtbW2OtJqriELBI0gjr996efQRTdVtBf4uJsKVJc990Qgx0mCZdmSMtY4?=
 =?us-ascii?Q?2OrXEKwM44md6UA3awp4svIt2FWN0CQEE6exzX3vU+Rvpxenx5iZo0SOlbMQ?=
 =?us-ascii?Q?KG97nJeKxFZjiOhbeO3vrAl8d1L6fryXX5rtAmSiNrbSul9bSHe/jsV7lPvW?=
 =?us-ascii?Q?qzo1zUJJ1joWwKBmU5tGTzKTDSZh/BjfLnXWiP1zn1MPGTqnwtYL0e4cca8C?=
 =?us-ascii?Q?uGf3J09Ggbcyv1Sg7Tn2i1OxieCnGDgebS0NNoIXJSSCDxRjJVX5r37hqvnI?=
 =?us-ascii?Q?g9Z7MAZtGqNGY5mkc+e35maFO9W/newf9powsxu8t5yj7jtjQYYX+d14O1E7?=
 =?us-ascii?Q?l1/fSzCIDI5pfg1Ix3NzrHQBhG9DUZBAd8gMS+BO5aLieK++/GwuYbALHcAk?=
 =?us-ascii?Q?r4nLjTVTDOSyNd6guAvRBjJI96+krhVbH5ycqR6CRXe2Qf5fp6eHz9hVp4m+?=
 =?us-ascii?Q?r5tJtg8gXtOvJrFroYxnWeVpd72YtUcQAJEWEAfF6riA837u6/L09hBXHEZ8?=
 =?us-ascii?Q?kqJazQu3X2x1kclD7cekoN4TyWBA6jOwfjpJcO+jV0SOEV85Kegc5Vg0eokY?=
 =?us-ascii?Q?89lJe/CIxbW4dPLujop6wDNunmpmiVkOgsI1IIiTQQ/Z+La1fv/ahFLWzixD?=
 =?us-ascii?Q?HoPZLLFeFFLLvEOwaNmqZVOUKpeZAHIPgcwdLrzaz+jpzR1gEYqiMCKuaZuu?=
 =?us-ascii?Q?qo1gy+tlA6mjwqzQRvPK4D5f9N6WL/S3EPFAh5Pw6NcoMN3o7VKBcb9im4lh?=
 =?us-ascii?Q?KJ62YlmFhBhq6IgBsqKQe9D5yT1AeKUp3kdWBaiudxZQ3JnkZPmN9CqIee2U?=
 =?us-ascii?Q?+QQxM/M9FO4t4qC+GLwJ/0afoV90I6couVlO/H9UGWr6fkqbqALLMZFcds9f?=
 =?us-ascii?Q?JMcrQBc16kNnIN68O5Gcvhqyev4mktChkvRl2B/P6u3RZN92Vc9j2NQ6tYry?=
 =?us-ascii?Q?2KWlJxwnBY3AzA8ocA5rwMM/ujf6IrRX3Gi+8Y0WWKFwxJy1AvVPRP0XIs8m?=
 =?us-ascii?Q?YC43xfnIcyoTkxK1qEz6pcvMq28MGLc9GKtou3ExNHuozul+Hrsy/PwohX76?=
 =?us-ascii?Q?oaNEbPgmcV83qpRzITU7HPSINwL2SuxXyJDuizs81WzRs8Pec92kbLZPZWFv?=
 =?us-ascii?Q?vyt0PJNg6N7SUEP4gaT5a/das4VytxPvUq6nzJ4B2w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vqzp07024mdY2bgt3c0oZVVI4Ibdq6r6KOACrGecrPpMwvZOcdeZ2C2WfziL?=
 =?us-ascii?Q?Q0nQqmIrNlPEfv6n0grJgYlXVASLGbVP7NOoijAGm10Rb+sxQP4kinpyWUy+?=
 =?us-ascii?Q?W3juJZZF3a5kgs98sTVAuXPNQ1ebweN6NPk+VhQt3igXWQK0iqdNbroDpNV0?=
 =?us-ascii?Q?aCXKUj/ESFR6XTGUp+M9p9midFesp6gPSJm564KubDknmyRY7KN9v14+OA/h?=
 =?us-ascii?Q?tjhmNGvphuVor6/kfgRW/l0nlh62rZhPEi8w8G6LGye3oeOqJ/YBtHcDLXIF?=
 =?us-ascii?Q?yipMVpdy/n8t9jXVoe/wDrYVVyfI4FKe93T2r00UWTYa+6+TrcBrn4Yu30p5?=
 =?us-ascii?Q?ZyJtSMU1ALvClzke3LjhTRm18vwIDDQUU4yqaw1/illOZBlHwXf0mpAkyci4?=
 =?us-ascii?Q?5itlEqxUG3RCBuhmJUU5HU4sO7CzYWJqdKlcBWxA87/L9U11ghajxWpO5W0O?=
 =?us-ascii?Q?3SRcDtjsCY+ht+MW6BbtqP7iZskbiman4GgDUdKO5C4X8rVJk6ZgF35mRmVE?=
 =?us-ascii?Q?/JMdrI+VYyEUPTWtq5znZn5vqFsSyQEev6KMty/eZNghG0fOmayHaRGGW2mN?=
 =?us-ascii?Q?cnOJCtGNBZ8jnjQbRAXzAJFVrtCqzXQa0iZ+4pH0yRIWGId/MP/bz6zw7w/m?=
 =?us-ascii?Q?h+pIs8mQeWe1cgRe9I9aAFxOCaYsygl2B8H5Zs8VcIj3nV+NFKghs7uHwGFb?=
 =?us-ascii?Q?1GWmiMDtHpU9VfxVcuWE7IyNZlVFVDxIqCdaYhkH/MvIX6pV1ZF2fwdr4ZWY?=
 =?us-ascii?Q?cUmuiPBs1g1U3Oe5b1ab4gksLdhPiI7PRZcwre5+KN9Us5IqjFcswJ0Bgx8U?=
 =?us-ascii?Q?vn1/cd1wI/jG9axDIzCpr0VkritdIlxuTKhSRSmGCn6e5Ole0vbxrCX/MHLK?=
 =?us-ascii?Q?T5GvCWMwoZX8mcOaSq01Rjs3qtoEcMlm7aMvyCXAqLbhcU1YEDVlpjQpIW+F?=
 =?us-ascii?Q?HyyPNKYt/nl8zrFO/RryljDM/gP6isM8n8eAKd1g/6qdulLSpQFhc0UYK6LH?=
 =?us-ascii?Q?nUIxYxfiNtlvN2w6xNdgF8xhfS7KQKiw1alJApRCDxMIUwUYPhEiGd8PFZ8D?=
 =?us-ascii?Q?piqfpn8jK/ivil2Ns0yMaR5+V4zhVGIAhko7euR5cBxamJWR6mN7bmnpQXLl?=
 =?us-ascii?Q?+TI5QPb+vcv4LkNHx59kN2TW135vUcNmsYTSuF8Mna8iGhwT2zaxLZhfHqLU?=
 =?us-ascii?Q?7xpgTINRHxekCk5bO/hSgCwH6GvOPIMHbkw/HjUKitc/8u+KobhrmKlJ40ow?=
 =?us-ascii?Q?9UhuBdh0KhdmSfjb2CAO2981J+U85VfcpSerAf61NNZvxUbVqeP+J474ijkU?=
 =?us-ascii?Q?Eg0fNioYD9mZdpQSoi4iHMVbSGwXPTCWnOFCsDkWH9ltKekFAa4eB3OKb+KG?=
 =?us-ascii?Q?/DrKvoyvax4wHlLneDoWSdt/5JSpD7QLVC87LhVI59GvQWVqM+PGV5oXmbKp?=
 =?us-ascii?Q?PEaGLEUzcWUqQof+FkC/LW4emUbBZPd+s1p/khCbXuaYE22vnpwrxSxip/qm?=
 =?us-ascii?Q?YlfECL0rff1wu9foEkDLl8ilUTqJL0AnNpTKalmAjOXuqFYV+scTrOnoGyNs?=
 =?us-ascii?Q?QscAN1w2XGyTSA/NOdnLAr+2P2X7cNeRMZC3iUIX?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tCMSa49Qt2y+wR1U8vDNGEXrBOw+ONvVQkfxfrSTLzNUs8gy2dN6CjWFmVvxf8qGxAHNmUsaSH2Lku1BmL1IPoWYlmDWWiEQfszJKdE/GkaIcFP8ou3UzTdkp37wVw73s1joO12hLq5d+9ku3Ugp05f13+E66NpjBA7d7zz8JKAi/wq+MnuzaUFPc0AeoIUHjAv03R0Y0MWqdo6OPn/mJM+ueWi6ZJKUxu4rR3KN/7DMwY6QRRbS6rtg4gb77D5CdOUIZX6hH79tLrNY00fCnypjG9N9ZDjfFPyI0vTbijTuvjdtqybXpuxWd/5cIBXYm5jFDUF+mPqPImAKk6LUMd++k/hYuGf025cse1igwsoj7ps4s89t9G9GVnEqWSL0zyTguP1UnZ84Xotz0Z0cTuy5KNigrX/2+NK24lY6SNHP2uNI+QR7xLy+WaVNYqIcbDGiQbKitC9Cv3L+nQ6WyR2VBsNGYJwq86TsqwgVOPOakdDv3hzl30vi11psbzmRzccA6xUVPrxzvH8wUau8F16rsAj60IB3LaVzPlWwqL2BXTWgYR+VSJxVUTj+SHAyVfAWLDZCKurth6nPPqhEnBAIqXX7I6R5OAZBu3mRKEA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5810cf65-0b42-4f51-a5a3-08dce5671c94
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2024 17:57:00.4710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mIKdCGAxph5QdDhjL3GVPBgXbLG1QspyT6ScAl3rCnuF1s5fXf8LcZNd28S8kPl3z4h0MQp1ysphO1sUUMBHkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5879
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_16,2024-10-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410050131
X-Proofpoint-GUID: 1Vz-oxgf47gzcfAj6aUTKDutx_UX-Y64
X-Proofpoint-ORIG-GUID: 1Vz-oxgf47gzcfAj6aUTKDutx_UX-Y64

On Sat, Oct 05, 2024 at 12:20:48PM -0400, Jeff Layton wrote:
> On Sat, 2024-10-05 at 10:53 -0400, Chuck Lever wrote:
> > On Fri, Oct 04, 2024 at 06:04:03PM -0400, Olga Kornievskaia wrote:
> > > When multiple FREE_STATEIDs are sent for the same delegation stateid,
> > > it can lead to a possible either use-after-tree or counter refcount
> > > underflow errors.
> > > 
> > > In nfsd4_free_stateid() under the client lock we find a delegation
> > > stateid, however the code drops the lock before calling nfs4_put_stid(),
> > > that allows another FREE_STATE to find the stateid again. The first one
> > > will proceed to then free the stateid which leads to either
> > > use-after-free or decrementing already zerod counter.
> > > 
> > > CC: stable@vger.kernel.org
> > 
> > I assume that the broken commit is pretty old, but this fix does not
> > apply before v6.9 (where sc_status is introduced). I can add
> > "# v6.9+" to the Cc: stable tag.
> > 
> 
> I don't know. It looks like nfsd4_free_stateid always returned
> NFS4ERR_LOCKS_HELD on a delegation stateid until 3f29cc82a84c.
> 
> > But what do folks think about a Fixes: tag?
> > 
> > Could be e1ca12dfb1be ("NFSD: added FREE_STATEID operation"), but
> > that doesn't have the switch statement, which was added by
> > 2da1cec713bc ("nfsd4: simplify free_stateid").
> > 
> > 
> 
> Maybe this one?
> 
>     3f29cc82a84c nfsd: split sc_status out of sc_type
> 
> That particular bit of the code (and the SC_STATUS_CLOSED flag) was
> added in that patch, and I don't think you'd want to apply this patch
> to anything that didn't have it.

OK, if we believe that 3f29cc82 is where the misbehavior started,
then I can replace the "Cc: stable@" with "Fixes: 3f29cc82a84c".


> > > Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> > > ---
> > >  fs/nfsd/nfs4state.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > > index ac1859c7cc9d..56b261608af4 100644
> > > --- a/fs/nfsd/nfs4state.c
> > > +++ b/fs/nfsd/nfs4state.c
> > > @@ -7154,6 +7154,7 @@ nfsd4_free_stateid(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
> > >  	switch (s->sc_type) {
> > >  	case SC_TYPE_DELEG:
> > >  		if (s->sc_status & SC_STATUS_REVOKED) {
> > > +			s->sc_status |= SC_STATUS_CLOSED;
> > >  			spin_unlock(&s->sc_lock);
> > >  			dp = delegstateid(s);
> > >  			list_del_init(&dp->dl_recall_lru);
> > > -- 
> > > 2.43.5
> > > 
> > 
> 
> -- 
> Jeff Layton <jlayton@kernel.org>

-- 
Chuck Lever

