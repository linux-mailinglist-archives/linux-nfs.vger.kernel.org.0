Return-Path: <linux-nfs+bounces-5888-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 170CB96339C
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2024 23:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4579282040
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2024 21:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E23741AC891;
	Wed, 28 Aug 2024 21:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cnibwkYv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SLiKA/vy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93CF1AC429;
	Wed, 28 Aug 2024 21:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724879341; cv=fail; b=E+NExO0We+S4yG0TWHZKpAMgPkMKWhR8ltucQj8Gt3xGv+jhioXYbE0eJEdJjoz0yoWgnC6Ak51zaWDjD1DHRHR2++sNNOM94HmGOafIZjK62iTxN9au5cwEIEkF8DCfyfKEFZ1G4hynuD1dH2jJz0DnCMV3XnEZi47zsycfFEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724879341; c=relaxed/simple;
	bh=vXjigUV9jv348Jg1vwGju0Zad55LnPhH6rR95YEJv6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RgRuWYyQxB5MGwOI2cn327TObhvOy9RylsYRLqYyxUv/CSrDRU7bkw8X/arbNXB3bXQLZIRwrn9lZjincaDufjyYRBGfdSoeVRf6qEs8ecuz5ceYd3qy+KE0Vxk6dCDO+ykfnA1xCWbhNYbhMAJY10WL/3hPAnXDdoewzsvCKKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cnibwkYv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SLiKA/vy; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47SKiL5K024512;
	Wed, 28 Aug 2024 21:08:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=OMOFJfSp7UzBxCg
	UkcT7bSXp5WI9Hux0HHz3kzswSUg=; b=cnibwkYvQc2gctoAaNxlGNCLsA9DAuy
	Jsv/kldTzVlkKFf5WyqREhYZVtviI/qicegk4brVz1NLsx+/pHpQDQEXIvjN9CEm
	kl+a7+RKIvOGBBhYZx/04OhGPIQ9vw4yYX4UIVrjy7KGTCtZW+9qX9flsfiGunRM
	FFSfp8v3ecO9Ejs49rs3gY0lwC8V6G5WNJP+U5Qok63DhpfeXKNqYQngnLnErSFk
	7iF0hYMfq4slYXwxkeAvGzna6Ou1rpSqeew1GAYEBPiqLX+3uuKwvKP2p0qpRGQW
	HeA5tpkkoNdMupTTkdCPxzGIicfSXWAwpBZXnaw+xHgradJjBr7sS5A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 419pus2apt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Aug 2024 21:08:51 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47SK6kTX031839;
	Wed, 28 Aug 2024 21:08:50 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2174.outbound.protection.outlook.com [104.47.73.174])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 418a0vutwd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Aug 2024 21:08:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e6/iJ8+AfLxi+2OBvj5Ie4XeumyOpELfL/cMZ6iw3WFJ2FytV9rV71ucEWYtk86sQctCgYECr0oZmCxgK5OGge1cPEMO8WvkpsGkLbaVnLkhNibLF/y54HpwA8ulXHWZDgT6OZPyom1f7/t4OgADoaI1l13I4LZHsjo7TncpY1UKvEb077WNBF4AHsRoDvUQL01jP97LNIJD9U3KOK/AXYpB5R2dDr0521D5T4Isnbw4Ni8lG06ugqm5L3cLHEq/VyGHlVP8FrImq1/u7ELtQLoOdW+cSGyRHzOT3RHM9JkRW1YW6f8wavqHSLZ0FjftCaXcpl6NO/5kyMQfZHCThQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OMOFJfSp7UzBxCgUkcT7bSXp5WI9Hux0HHz3kzswSUg=;
 b=sP6VlP0wWHJdNgl5MHW344sAmyAT+eXuGg6M15VOINlXmn+PXpyu1Tf0OINyZ809CHSyEaNsMS1hd0CdW+AQPYIvCi1lNtmxIwqnxcyS5yhsCPBQ/6zD+evUTZcMc6i//NhcsDfmnH8TfJwlSyghFPDU4J5Ic3OXvA/UjjEgqnuQCotKizhKlPajI9TS/ciJKJkczGx0oXOhIHwj5LgQujXS1gvMWKeKSEBK+W0py5YuDrx1kg+YicqyEeuedPpUFMVtzxsUc3DC5ksxw/uomxn3sY7CkTTPKtxnXIHSycD3mDPXkoVCLdl4/wTyw89HCpoVMQZ8PE+BOZFZcA5rGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OMOFJfSp7UzBxCgUkcT7bSXp5WI9Hux0HHz3kzswSUg=;
 b=SLiKA/vyA6tCQuYpO1oMW5xVPb1TB8oHjA6rnvKi3lk1oYZFu6etKSy7mVqBnhBJ+TDI2dpp0oAppt1GxoXx5ko3q0EvQtgmh81gof0qWk7dDLkAxMiQ0CtBmXmHg88l04FGFx3LPpx/nZbGqQfRbO18X83ThOhtYo/O5NvPv/k=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SN7PR10MB6545.namprd10.prod.outlook.com (2603:10b6:806:2a8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.10; Wed, 28 Aug
 2024 21:08:47 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7918.017; Wed, 28 Aug 2024
 21:08:47 +0000
Date: Wed, 28 Aug 2024 17:08:44 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Scott Mayhew <smayhew@redhat.com>
Cc: paul@paul-moore.com, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com, marek.gresko@protonmail.com,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/1] selinux,smack: don't bypass permissions check in
 inode_setsecctx hook
Message-ID: <Zs+R3GXS93LL+PJB@tissot.1015granger.net>
References: <20240828195129.223395-1-smayhew@redhat.com>
 <20240828195129.223395-2-smayhew@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828195129.223395-2-smayhew@redhat.com>
X-ClientProxiedBy: CH5PR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:610:1f1::8) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SN7PR10MB6545:EE_
X-MS-Office365-Filtering-Correlation-Id: ae7bdb71-d5f1-447b-14eb-08dcc7a59bb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2cNwWNOdbcRoq7y3X08R4MJ7Yaks0oDIoqK5xswmBFcod/3gXEnSM1wUs8BX?=
 =?us-ascii?Q?v/QhDDwBMTC3OUOnH2yjT/u9hhErkbHnmHlwi+Cy7p3pI2b5AeZy7BcjgbVX?=
 =?us-ascii?Q?FhgKdddWhrJyvfZzcsob8+/mIAbQ428kVLXLM9Q0aWgPlbu0A7IVKG32Gvn3?=
 =?us-ascii?Q?RVQ5EzQ837c+qhfHRNxfCnaRZxEm5c3lUnDO2imuIHEjBqzmAMeRNE4atKyS?=
 =?us-ascii?Q?6Qqm7E0vRMsaN+rhpjQh219hkdNx8FvwMlwW7mSTbvCFdYkBtXy6Rhn9sbI7?=
 =?us-ascii?Q?9SM5YsIOKqMbrdzoBxuoretBqNAk5tW6xtJKyxNnukgwPzo9p4WIdsM1onS9?=
 =?us-ascii?Q?z/g3n5GjdY55cAwFM3GmW7C7nhFNRHQStqd5CmKyRHKRntQO6tFc2Mkcgkgf?=
 =?us-ascii?Q?nzV5XW25xv88NG+ApYmn94Erj0GY65QbyLabR9HAORl+0PMsi1Jf5uRMArS+?=
 =?us-ascii?Q?7Wd7Xe4DD4+sTY+ZyMFKOhMRnMVfWZ53hTDHDz8aH88X5ybHA8qy+Q3Er2v8?=
 =?us-ascii?Q?0/DBIrFl7/yT1xzG1oBb2So+g+S6NbKF3naeGW2iWUT88vJ1g18C6UERZM+p?=
 =?us-ascii?Q?vvnSb22jaQ/Jkv3+ojx7Md8cROJ0uzYMk986tIuKC3dmuBeRUlLYd+/IGhKi?=
 =?us-ascii?Q?bDSFRksBNnNHe79MYB90IgkfySr1pZ98EWWho/ubdVamMhqqpLBtHmvT42oQ?=
 =?us-ascii?Q?jNP0I2mSj7y8lw+kHu2EiWbqhb4UTcly00YgM9eft2lQ1Us1IcT6g2x6Kwr8?=
 =?us-ascii?Q?h27GsidZsVdFWzalhxnMGxvLchdGsuQq49JsX+Ol/pNVq+JABPMaYPDGqHqr?=
 =?us-ascii?Q?Ssvwrh7owRn/cR3yoo429ZFBSqxWj2GvD2Vanb+Noqod6tW0A8qf+pNm1O2u?=
 =?us-ascii?Q?Mdq4aUUzw4HDIwiWk/IvdHvsPM26Q10D0yYhCadQCzjgh00qE8a/yewsNELx?=
 =?us-ascii?Q?b4hdJbb7tqpayuFkDQ41mbRFAhBf3k6N7B/vV2JJEb8GBO0Ha1DhIX31L57C?=
 =?us-ascii?Q?i8bQhOOod7+5QTpmFEtMeeipiYT+bwN7WLiXjvZPawhlrcah50zuPzzmRrwQ?=
 =?us-ascii?Q?tk54dYJ/IyRChgs/weFW22WC0TVdZ9zXkAY01pg4p5wlPaf8505IJE5mP6wu?=
 =?us-ascii?Q?9hu7DXpsH/iPCVU3Bx70iTAlGuC3xutwMKlssCQlXnOkX4bel5LifuYb36/2?=
 =?us-ascii?Q?j0XWoqO2T8OS8pZ1tX/MKVLDBn0KquGuD8TyMg7mUQ8D4iCao1GGIFLcqwTI?=
 =?us-ascii?Q?0Xl7aDIqB2NelwXj+rluQHrDZ9mdkGCiSm+uFXIvl4ecyvmIDAyBfps1eQo8?=
 =?us-ascii?Q?EEwaISjJyCC35NKfElJ82TeaXP6O4pvk8t0Noz/TV1QsW/gKLapR9+IxNkrU?=
 =?us-ascii?Q?vKsa5f4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EzF56ZUwEAF7sxyvhSECPW3s02NNqsZDEO9E2tX3HUpio+8f/g0xY8FNdyVM?=
 =?us-ascii?Q?r+OSK5C2W81Vqofkvbmu+ATKdM3LKca0KDd1PQToJ87Ydipei03ZFleKitdv?=
 =?us-ascii?Q?9gsfeUru17Bld755LkGrfAEYF2GUwITLEo3+Ui9rvojoSBhzxYJHEYWyKRfV?=
 =?us-ascii?Q?MU0ktPEA6/DD9Htv4G5Nrjx8dmMu4hi2irvvNpxThVd4w9S2BUSpxGIchwG4?=
 =?us-ascii?Q?I95CzYacEqwVM9jtJuDuNX+eU4GxOEb6T9wIDKLQeBiHldT4rN0S7D5Aj+VB?=
 =?us-ascii?Q?Zhdg0p3E5SurSVVRdoebDj98H9Yqvd5pIHdgaIb7WplId05bZZteJzP+ji/o?=
 =?us-ascii?Q?S1jduIZEjAcbkSu1UKhk/C6STP+ZFOzBbyAL8571j9wtgSpExd4iZXRKkSGL?=
 =?us-ascii?Q?mL1z2XaMgERJfTmbMOhw15DpbsHCFCvhVkBBpjP7k1x2jsXjApWjMA3VQIx2?=
 =?us-ascii?Q?SXBELL27mKSb7GFF+5hoez3/ZvfobQ9EpOkoUZBxq2y9wQYXnqPTwmwKD28+?=
 =?us-ascii?Q?Kedt2G/O6f70C6j2II9d21TnmR35XP2RETS0MbKC/qv7uEtKuKgklsLnkQgC?=
 =?us-ascii?Q?dOpsNVeEzE7kAh+OezD7hytYPUnfNtQjStqqc8puIRXLCrJqisDka6glF/vl?=
 =?us-ascii?Q?EyAdI+/tgVAoErAFMiXIhzYeAdJW5Q8X7KpH9OQHBRICQ2KrPjk53spEVDwJ?=
 =?us-ascii?Q?2VFeoY4cGvhjKBWGZKjP8OK9O7vR+bt279+irOZJurYgRoNykxl6hAtZVIQ5?=
 =?us-ascii?Q?HZHDpQQKvtpUJBN9FbfzHrP0yfKYlYB8dPuR/AMV0FNTILDPAqgFCCloI6n9?=
 =?us-ascii?Q?RpOdNfDti+0DLbrS39FZnrqa6gdVo1Wvfyyu7JnaLdW+svreBGuMSLnNJKnf?=
 =?us-ascii?Q?IvchW3c22fI0K/wAuBJ2dhsS3ALIwEcqIwddY3KX615w9T+H6QBqCbIK6Rcq?=
 =?us-ascii?Q?Kowr11lqBJCDTD2rd+hIQ/tt2qDCAskFfmA8aCU/1GZUmKUCUlw2R8oIdxJY?=
 =?us-ascii?Q?4VBDbuB5QMUDpKj+b8KpabRyVZJ/kVKYaiKhIZc7UU8j6FCY8Uk8yrhXtuoH?=
 =?us-ascii?Q?kzJVJHRzSImkJrxoMwc98/w5HGuQX2RK4hWD3D+nSePo/l7rxv4JmJFK6hEa?=
 =?us-ascii?Q?zBXnBvgCVbbMF1dHAmo7m1RnAtbXyEoj2fJ78+18W+iJfhqfUX2ARjKPRXQq?=
 =?us-ascii?Q?n9kWSXDRM5SfA0C5pAY4ohwu5ZZ6rC7wKCyo2S3c/2T6gQbsfpt4usjtKwCx?=
 =?us-ascii?Q?RbySuVkinVqoFkaOn9ucKqEmyZ5NswFsWX6l1l6XYUX7kruzjH1zT91KTUTa?=
 =?us-ascii?Q?22+f4MyP1c2OAJVk1hj/CjVBj+UeUqfJOtnR1cpOTwKbx8L0bdQIdQZxXjhC?=
 =?us-ascii?Q?Wz7uaN/uKuQeCUQdFwpu3jb/v0lnzGGCKHMewHBhQKCr7tmpbYirfFvoBNKf?=
 =?us-ascii?Q?HC6AL7HYe2Erud8M6x1mBR6lFMNZ3wHQYWTHiOljks++Ty6bLLobAyLPcSfw?=
 =?us-ascii?Q?useNu4ntMwlLTb0qi7bmeKsrqNwWkoc0uFTwDwozf5Yb5qjiy0s4FO8KsOvk?=
 =?us-ascii?Q?lf0CiNdNtl7qlmQCbMmye29OxASvf4uMBARDXoXE?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	A1pvXsaU+6l1XMuFYeEluNHi0225oXq5AXuYQSjLNZCt0J+yJ4HdeNy/dsmkqBeVo/Y7pl0h71czSC6gHvVj72NriMFOBW5+vEKx3kg/gMl5BqJQGb5CaRF0/OWt+yCPjvOA621ptrckUVn1rX2Zo8O3U1eCGDx1TKdZQXx/kAYHsn2mKxkg5fbYPtR1OofjkrBu4g+EFxBYVkZJNMj6MwfeUwPOIS43YhgQ0fEFt1bZKSRHlJ4JdOpjX+cPtRJBOUvKADogAWEimeoFgA83BD74/xV1DO5egAFLv0O/sZF1rZ4LV/FJg+FKGeNmaawTWd4oyw8eLM5BCZ16rto6jRp5NUwSA+wXbZWyfWJRE5XyECCiv5HKPJa/p3x/Xna6P/0ropCS4a2QK/tzCpB7MX027IMloKC2XGZnvcVxaAWiua4P/A/rx1W911u1ESnYcwp5r2WEEqj56z85soJl/1vrlvr41Gen+glSPr1aOSpqWCteaxlZktCbmIvVPRPzJSGbPZcEDyHs200yDCHRMCjZVQaWIBwUxvChFAdAO0zEP8bZHxb4rN+1F7gtF9dUwCpI8Ani5fFmBdOmen2r3Uftk+ngmJgDXSkqe2Ue/gs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae7bdb71-d5f1-447b-14eb-08dcc7a59bb6
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 21:08:47.6676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /YvHVaj/6pShTlqVzvOei64kQrTyMDn+2z1MS/RVjAi4KBSbObkbMCSeQb2LGCetVA63vw0EzDKE8dFhlo07Dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6545
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-28_08,2024-08-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408280153
X-Proofpoint-GUID: i6P9A6An6UW7cXDZH7QWRqOl4iTyfWtS
X-Proofpoint-ORIG-GUID: i6P9A6An6UW7cXDZH7QWRqOl4iTyfWtS

On Wed, Aug 28, 2024 at 03:51:29PM -0400, Scott Mayhew wrote:
> Marek Gresko reports that the root user on an NFS client is able to
> change the security labels on files on an NFS filesystem that is
> exported with root squashing enabled.
> 
> The end of the kerneldoc comment for __vfs_setxattr_noperm() states:
> 
>  *  This function requires the caller to lock the inode's i_mutex before it
>  *  is executed. It also assumes that the caller will make the appropriate
>  *  permission checks.
> 
> nfsd_setattr() does do permissions checking via fh_verify() and
> nfsd_permission(), but those don't do all the same permissions checks
> that are done by security_inode_setxattr() and its related LSM hooks do.
> 
> Since nfsd_setattr() is the only consumer of security_inode_setsecctx(),
> simplest solution appears to be to replace the call to
> __vfs_setxattr_noperm() with a call to __vfs_setxattr_locked().  This
> fixes the above issue and has the added benefit of causing nfsd to
> recall conflicting delegations on a file when a client tries to change
> its security label.
> 
> Reported-by: Marek Gresko <marek.gresko@protonmail.com>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=218809
> Signed-off-by: Scott Mayhew <smayhew@redhat.com>
> ---
>  security/selinux/hooks.c   | 4 ++--
>  security/smack/smack_lsm.c | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index bfa61e005aac..400eca4ad0fb 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -6660,8 +6660,8 @@ static int selinux_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen
>   */
>  static int selinux_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen)
>  {
> -	return __vfs_setxattr_noperm(&nop_mnt_idmap, dentry, XATTR_NAME_SELINUX,
> -				     ctx, ctxlen, 0);
> +	return __vfs_setxattr_locked(&nop_mnt_idmap, dentry, XATTR_NAME_SELINUX,
> +				     ctx, ctxlen, 0, NULL);
>  }
>  
>  static int selinux_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen)
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 4164699cd4f6..002a1b9ed83a 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -4880,8 +4880,8 @@ static int smack_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen)
>  
>  static int smack_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen)
>  {
> -	return __vfs_setxattr_noperm(&nop_mnt_idmap, dentry, XATTR_NAME_SMACK,
> -				     ctx, ctxlen, 0);
> +	return __vfs_setxattr_locked(&nop_mnt_idmap, dentry, XATTR_NAME_SMACK,
> +				     ctx, ctxlen, 0, NULL);
>  }
>  
>  static int smack_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen)
> -- 
> 2.46.0
> 

Nice, thorough work, Scott.

Reviewed-by: Chuck Lever <chuck.lever@oracle.com>

-- 
Chuck Lever

