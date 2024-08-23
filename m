Return-Path: <linux-nfs+bounces-5656-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8880095D654
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Aug 2024 22:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F83C283A4A
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Aug 2024 20:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA19D28DB3;
	Fri, 23 Aug 2024 20:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="icD3xHSn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EHlWqmrU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81052629D
	for <linux-nfs@vger.kernel.org>; Fri, 23 Aug 2024 20:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724443228; cv=fail; b=KgIqR80BhdHJZ1w3+8HIjgdAPbRcp78Ez9/tJUn9SquJ0g3GMSx4V/BeC+8+grt8/UaD8BuTyKPDfemScvjNMG2KrRDh+IMG1gvj+7fABnYhFAWgqyQ7hr+CyLKfh++cbRMMUYAtKOuDYzK/hR+AOxdjHtIhDLRz1s/pVNW3rUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724443228; c=relaxed/simple;
	bh=QY2YDHNVXQJ4PbEqtmTVOOpXTkVh2Qf/K64GLvIMAds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iRcGohL4ApbgOW3Fls8y+r8UqJXTq3tV+X+ZC6MkB3jB8IkUcXZRnipkvMZw0ZPcL/+01Ppk35bB5pnNkTgOhsNUuUJQwLqAhP98Fdp3DJIkP0r9nAhIFEI6h8vjHHPX870SN5qUl1wx7st82GCaizuEjqUVRArzD8gfc0iazH8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=icD3xHSn; dkim=fail (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EHlWqmrU reason="signature verification failed"; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47NH0Whv028481;
	Fri, 23 Aug 2024 19:59:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:content-transfer-encoding:in-reply-to:mime-version; s=
	corp-2023-11-20; bh=5bmYIPXBLpLKNVG6ObRuRYjmcDPxmj5wEsH4OCpqIpI=; b=
	icD3xHSnX4EmhWCPfLxSF50j9QVCEpmk+2fsszfz6e9W328Puwpe6Qx/SgDZcKVr
	q7pA+GEdPUkAfU8StWN1Xp6bnofaeTGB8uPWgOHkIBEX97S4kxr7BDqe6YwCxlj8
	uJ8Hdx9UiCUhU6JdJgSlQKeHyt0szk5vA6lsqmkSZzNkd1gfFViXFmvuJJZt4jjF
	eJsmWNUeYwr/Ikh2JObOacgHkXKNbxjFmkU0msphdbCQDzEkz+74gOEgRP8iy6HZ
	txtclmDp/N+ZOM9e46D4GoKp0Rd5WtFAKI+2L+DXPNzGlif1X+7TZ7cd8aagyBip
	4NIbvARbcx7kwJYwNqmlYw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m2dn8je-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Aug 2024 19:59:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47NJd6wo006840;
	Fri, 23 Aug 2024 19:59:42 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2041.outbound.protection.outlook.com [104.47.70.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4170s5gkhu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Aug 2024 19:59:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=STplqL07iL/vVhqVbdofubeI/He6OMqMaCW8x7t/L4WPnDzTPWI093EkvU7DHyZi7OWbUaK+MUUoQ/oKjHR6wDNqjM6YVMof49Rd3BoI9Tjq2cuww0h3N+DC7TNhy4bFo/vcSUGY/jVMfttOPUec5GoRVTLgoCPdgU6XsLIC63zZGY30wPOKCLEGqK+45Js/AOSIS6fUSy28uKnp7Ax0TeYrEPSW+36r/x6c+WJ0AuNul/Wp/Hz8nTgMWLBd9Eo85A4JBpWMKQAf/NV1TWw5we7trpYCV+Sv89a5cF+RWIbJHZX1jXo86rlyiNr2691NOS4GcJdcXe0fz2jXWcXJIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MkI3Mi4mNKmfI/IoofgyZy4EKIFkgxvyktEUjzVkYL4=;
 b=y3dj7XJz5H/C1zer7z36zmd3gz+BMPWy+JKFTvo9zG+ufa5ciGXnTQifORLD0Nk1dy0DJXNJap5SLfXzy/xMGw9d+O7+IoE5ruaBCsQZflYHT+Eae+8gb87z5D+HEhWv6mUYDOKvZ0QuCJpRfS+JY2P4gd3XrBKsNPg4ggG4bcKzqPHnYkU+kvvRkoI7FRLGPBF7Q8HxMe0jJ70DW5cu/TVM8iGOdHEoE/MI8fjJSBlgHDlcq59qAscEQCL772kZcHZiSIdz6PWbQYmSC0n0HuGRFF6EcHgb5EUDdEwiVFekDZ5U8nBkDUougaFBDU/JdN4iVF0wkkAUicyXEO1TyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MkI3Mi4mNKmfI/IoofgyZy4EKIFkgxvyktEUjzVkYL4=;
 b=EHlWqmrUtQb0UdJAh2uupXLn0bU5KNBWyQYVDFjV1XB5Wm9znDxG7gkbS0/JRedCnC50LcwcbUO5xk6s2SlXlNX5/cu2RXKqWxAMhbvNmCQ1TPJ5KQZT0RgE7IffvhuuD+45g1qL+/9VgAkrA2Ej9xN5ndSKW8Yqvua2ksVgCVM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH3PR10MB7209.namprd10.prod.outlook.com (2603:10b6:610:123::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.12; Fri, 23 Aug
 2024 19:59:39 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7918.006; Fri, 23 Aug 2024
 19:59:39 +0000
Date: Fri, 23 Aug 2024 15:59:36 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Li Lingfeng <lilingfeng@huaweicloud.com>
Cc: Donald Buczek <buczek@molgen.mpg.de>, NeilBrown <neilb@suse.de>,
        Chuck Lever <cel@kernel.org>, brauner@kernel.org,
        linux-nfs@vger.kernel.org, it+linux@molgen.mpg.de,
        Hou Tao <houtao1@huawei.com>, "zhangyi (F)" <yi.zhang@huawei.com>,
        yangerkun <yangerkun@huawei.com>, chengzhihao1@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>, lilingfeng3@huawei.com
Subject: Re: [PATCH v1] SUNRPC: Remove BUG_ON call sites
Message-ID: <ZsjqKNvsW35hLWEQ@tissot.1015granger.net>
References: <169513768769.145733.5037542987990908432.stgit@manet.1015granger.net>
 <169516146143.19404.11284116898963519832@noble.neil.brown.name>
 <793386f6-65bc-48ef-9d7c-71314ddd4c86@molgen.mpg.de>
 <65ee9c0d-e89e-b3e5-f542-103a0ee4745c@huaweicloud.com>
 <ZsjfuIKIWoapNKH+@tissot.1015granger.net>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZsjfuIKIWoapNKH+@tissot.1015granger.net>
X-ClientProxiedBy: CH2PR14CA0026.namprd14.prod.outlook.com
 (2603:10b6:610:60::36) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH3PR10MB7209:EE_
X-MS-Office365-Filtering-Correlation-Id: d25fff85-7b01-4129-b8a1-08dcc3ae1f41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?jE2hwXJRDbPdsOgI+cMWSuu22sEnWVLKWFbIRIx4F+kMkeoL0AT0rb9Y00?=
 =?iso-8859-1?Q?loOcT/ro8WUN7mUmBBjvWpa5O2XbLYATqTJglZNITEVRsecIsR5LxBMbTy?=
 =?iso-8859-1?Q?RSypiggZ6ii8QUi5VfoFSJaAdHHzs+kR5z4/W31btXpjUMStr68ox3wA/D?=
 =?iso-8859-1?Q?B5GcTrySpT0cUtdRLWWA4BZzTtMHuUwmRc8Dl3BVsqtLVNTl/kpX/wgiVO?=
 =?iso-8859-1?Q?RUB4/Rt1GOlsyroEdFlnbWwi7MeNUEv89Pa7hUVynTYtTkmBnNONsn6cMf?=
 =?iso-8859-1?Q?0aNgexCKc4tKzEp3zUh6DbGOtsdk4+ldwR/pHzZVW9dKMGsmhFNFBPLH7U?=
 =?iso-8859-1?Q?qGMdVBQyz3XDjePaYMWkaqGNLWxWEA/ALSUUxeFQD7Oc0pQzRInBcaoWL5?=
 =?iso-8859-1?Q?1Grzd/MC0qAES6XA+LTue9ekelEfx8Z8lgOqamPHUvfDkb+OTSAHm5GV5S?=
 =?iso-8859-1?Q?U678zZ6G07CRBSN0zI4GEvqwYUxWWZg+e9bPQXvu2g2KhdH4w7lADt47/A?=
 =?iso-8859-1?Q?yF6ZWPoZyk7rMnruxVHvc4O2u6X5Cew944evQDgArc+ial9TNXDGkhL/f5?=
 =?iso-8859-1?Q?SNpWh7Wm3rIYfNpAaAK1VW2XSZeeoz/X5igFJ5fZWYQOX3K3i2GhAKP6W3?=
 =?iso-8859-1?Q?glaPBms10nH8iZahbE/s81iz7EDh47YMPfrx8Avs1c+kr8IQjz1Gv43E3b?=
 =?iso-8859-1?Q?i6qLyaN0zZKBEx9ppr6JiY2Of+7Doj2hKP0s1ukoox5dTPvBqDbErx41yh?=
 =?iso-8859-1?Q?MyGIIQEefNMihSHP5zj7LvugoBpvbiDZUIpGTyM7F3ocDoPkrL4BaONpdk?=
 =?iso-8859-1?Q?j+tWT1j9yc4meo9jNaKVIxtkLEKWgcaZidzYCmqKjfif5UKgCvIFiDQS61?=
 =?iso-8859-1?Q?IAPyw9NBWQUJj0dxKGZEhjJLzwRnr9Zsqsqz9gwby881dOLQiOpuqp2ODB?=
 =?iso-8859-1?Q?MRPDjq/pOFIIPl4biRVxw6hSFYXX83d0VDkvrLkVB1R/Re99dg3kCE6hS+?=
 =?iso-8859-1?Q?/i7rH+++IsSvKpw/mri8XqPZFDc9igYSl+nbgWcF2q6Xmw0ytc2sAHk+vU?=
 =?iso-8859-1?Q?Ur05HzY86oHv8x2tKq+JNMw894tss6Q+rsHyMX4QunkpGWPlLvTU0d93LQ?=
 =?iso-8859-1?Q?Luy45utvQdwGRvaVC8nb1FlH6L5ONHvnelb83AJlhViqReGLrL55pUG7z2?=
 =?iso-8859-1?Q?h8XlDgEx50auXFVVlWuS3fwX1Qg5DwVIb/6pV/f6mh5nIF1PTzUheBbcv1?=
 =?iso-8859-1?Q?JYetbedRq47y19MW217mYC8Ppc7gq24uCeF4X8xuCYYxAKHPoCE+7KAxXu?=
 =?iso-8859-1?Q?yoHp4YuCDpRhVhbVQbsftQ5oV5a0XGd9Fz1U4p2tqT/1lnWSgbzDdm3/yT?=
 =?iso-8859-1?Q?9pJ11GCWUuHCiZ/vZpnOqEZBAOXWj9rg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?6GFTaTDCIE42FjD7GljdO94mc9E+yCtT3+mHCecjmawb5tKSCAAV2XWPrT?=
 =?iso-8859-1?Q?qWMcrXDzcI7ruQ2buEu695qrA0vQbuhp5buaKUbtsrF7UE0PglsquQLZE8?=
 =?iso-8859-1?Q?Fw509K/h7U/4Neg9468iMMQjE4norQHiFjEVpQQYJ2ZStw/Gq1jAs5UmE2?=
 =?iso-8859-1?Q?s4a5uUx2LRlJl6/ykYo6QxgqGHSPB86jm5MFrR/2wMOejyMmW+Dhjqa5XP?=
 =?iso-8859-1?Q?zxJHIUsoa2jd5EwX64yM2eiOc4O8BnSo4i2MOIh7yV50Bc7FXBuFCAvVrX?=
 =?iso-8859-1?Q?7m5P9sWC7fHg1RDp1BXRLXOmOatPZkwi1f4oB4k45MYBHCC1B+EM6kDuQW?=
 =?iso-8859-1?Q?mFvYnlx3n4hjMBK9Z43vyp07uIH5QNC5E610/UmePXmQNEH6HZyCq1EKpp?=
 =?iso-8859-1?Q?hYG1M39nwl05vvmo+KQ23CBYo8FY9fABL0zIRWMkUVCIZQb+jLLwziDQUu?=
 =?iso-8859-1?Q?Whvj0r2xoRo0KAipt5/A31ANHa/4h1j2sE8eMReYMRA3jLKNfEIk9YRXX8?=
 =?iso-8859-1?Q?pt7XDWYekcEne/pixM+3UFS2ht8daR5IrtPmmSOA0Xyk9nLbYo+ip5nmyb?=
 =?iso-8859-1?Q?NWawg+aGE95l87+p9hKzwxO5hJ3BUw9rfZNSm6s0IFGFt67dV6HzioKYo4?=
 =?iso-8859-1?Q?53TUCbYkFF4vMbRox1ozXkKuxjeVkkhrXYiPeyD1I+poTAZLGIXIaS7e8K?=
 =?iso-8859-1?Q?ZgofYqs7M0pLkLP481NZnsLBba5TMi/WNgiDdrtH38yxZ883ZE+x1k3ylx?=
 =?iso-8859-1?Q?fTWMXiVvjJFqioiDuxAQiS95qDuPL66vyqzij7WGsAtXpnAj7T6TQHIXl9?=
 =?iso-8859-1?Q?VnFREmnXmydNwVo39u0CtVOYl+66OQzGHsS/BqexKcy/sjxQLZSd1KztiS?=
 =?iso-8859-1?Q?3dPgIyvvLcSM3teDTDgsdqKkUd+5r5VjH8jtXWbugElmnxEC1Vn3qu6YHM?=
 =?iso-8859-1?Q?Rmrp/6RJ6B97VXi1jh3gX7VlqRdomrDzvgTcAhZ3Bc5MGrZtEgDaX7eC43?=
 =?iso-8859-1?Q?mvLkDkUs6b5DEOg4D4TseCxQ80SuU+tWT5tNYEC7HKJiBuZS6E4wne6WFZ?=
 =?iso-8859-1?Q?hZQVCGjil59ZXYSu+GN7kmwW0VHKNWuPvFeQPALltF01hzhjZQ3e0e0lSe?=
 =?iso-8859-1?Q?XP/+nxsyHnunAaMuxSXj3HoY67QUeOmzg2PRx8l7wosAJ97qW8xALk1A6b?=
 =?iso-8859-1?Q?IZ2GtRDAv82Z9UkfciGkBs7B4BMfvB8sux5V/Em89XcMfV10k+VsC55Emt?=
 =?iso-8859-1?Q?3G6eP671nmP36QwIxAMfeS+p7IKT9bBGHQ3il9sVnKXkKrbRiAjhpgo9jZ?=
 =?iso-8859-1?Q?I0nyfx8Rn/+FlL52TFVqT5uL6PoGHrgpKTCpBvR0fRzNNcA1I4xbaQbGru?=
 =?iso-8859-1?Q?fO+Tnw8HG/049EsvgJ/qCQ6hDIANwrxQYY9Ub5TrgsiWj9XEbKhb55OlEh?=
 =?iso-8859-1?Q?UYM9/C6K8svzZ3qiSLtiFIys5oM5T2vF22TYepBQXAnKcRrVX0sDa2PJN2?=
 =?iso-8859-1?Q?HbJMEQiC5RNtn2trdG5Iz8WmyllyLTFg0psuwW0R1N90/aogpsAiypGc0K?=
 =?iso-8859-1?Q?x3Qwwj5u7Z4EbBIJ7kFda/LOsRAznTkhEuW3kWfHTDYMv5Ckjjqv03hmSR?=
 =?iso-8859-1?Q?bSlKVkGjh3BshfFR/ctF8Zc20ikupaW3wg?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/5rg7eTw2bE0mPgTeBUwlGK/m3XaNNsJLgLg9sTSilwOg+ZyYLvy1aJ7A7yugSghcPQa1k8Oh5PQKNWifkssL9nCT0SxlPpfmnlqO8fPbVvu9wzjBn6wDjqX2tKgmRo+D6tVM/JJ5fCI42Hjy85qahQOJ2vky6otXNvIlZnyQynIba8e9P+/18ds26Jf8DIExVyMqm0biq8WKizTjmGFnadj5YgwoKa12fJi7fW3XXioz0FqVdkTc1ObQ2raHPMgWkd6httFYU9JSQFKWMmZJ1i0SBWkqIz4wHD2lyyH/WxQC/kOB8Q035RpxwwYozLdX/G8LACXzHdhWvvq3AQody9fyq77Blo4KdzEOHTAMqguNfvPWk5fSbRi6s6Vzjh5/l1nLnGiwWW9KTQmZG9GCSFym0vNHpvpaWP7ltOIhZZEAO/ULONqAi9KfVk8VUSypoR6i4Z07EjbQ6hVH8rFEf6isKRv3dq3bN8mupcn3N9/y/xmz3XpXm1P1CThBEDVwe3dab5Sie5RTxPaT8YLF6hEd67kqCDJQNnWbtbVX4O58fSE0707uyLCsZ7UKM6r1tHMY65Xet7JV/fVZvRYH7OFaIDUhDNJCHJnaZRxjvw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d25fff85-7b01-4129-b8a1-08dcc3ae1f41
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 19:59:39.7183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pqKjUXPkewaEB77LiF6IPnG8nNXT7PQ/+kuTwyNCnBzqihowVXwrt590+c9pZbSSXlSOdy4/3SYG/g15bwR2lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7209
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-23_16,2024-08-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 bulkscore=0
 phishscore=0 adultscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408230147
X-Proofpoint-GUID: ceoIL_5iREtH-QkpFLoTwGPbijwBRqxJ
X-Proofpoint-ORIG-GUID: ceoIL_5iREtH-QkpFLoTwGPbijwBRqxJ

On Fri, Aug 23, 2024 at 03:15:04PM -0400, Chuck Lever wrote:
> On Fri, Aug 23, 2024 at 11:35:28AM +0800, Li Lingfeng wrote:
> 
> 	[ snipped ]
> 
> > [   91.319328] Kernel panic - not syncing: Fatal exception
> > [   91.320712] Kernel Offset: disabled
> > [   91.321189] ---[ end Kernel panic - not syncing: Fatal exception ]---
> > 
> > Both of them were introduced by commit 9f28a971ee9f ("nfsd: separate
> > nfsd_last_thread() from nfsd_put()") since this patch changes the behavior
> > of the error path.
> > 
> > I confirmed this by fixing both issues with the following changes:
> > diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> > index ee5713fca187..05d4b463c16b 100644
> > --- a/fs/nfsd/nfssvc.c
> > +++ b/fs/nfsd/nfssvc.c
> > @@ -811,6 +811,8 @@ nfsd_svc(int nrservs, struct net *net, const struct cred
> > *cred)
> >         if (error < 0 && !nfsd_up_before)
> >                 nfsd_shutdown_net(net);
> >  out_put:
> > +       if (error < 0)
> > +               nfsd_last_thread(net);
> >         /* Threads now hold service active */
> >         if (xchg(&nn->keep_active, 0))
> >                 svc_put(serv);
> > 
> > They have been fixed by commit bf32075256e9 ("NFSD: simplify error paths in
> > nfsd_svc()") in mainline.
> > 
> > Maybe it would be a good idea to push it to the LTS branches.
> 
> To be clear, by "push it to LTS" I assume you mean apply bf32075?
> 
> I have now applied commit bf32075256e9 ("NFSD: simplify error paths
> in nfsd_svc()") to nfsd-6.6.y, nfsd-5.15.y, and nfsd-5.10.y in my
> kernel.org git repo, for testing.
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git
> 
> I will run these three against the usual NFSD CI today, but feel
> free to try them out yourself and report your results.
> 
> Now unfortunately 6.1.y is still "special." It appears that commit
> 9f28a971ee9f ("nfsd: separate nfsd_last_thread() from nfsd_put()")
> was reverted in that kernel, and the fix you mention here does not
> cleanly apply to v6.1.106. Based on some previous comments on this
> list, I think I need to fix up v6.1 LTS to be like the other three
> kernels, and then apply bf32075.

OK, I've got a candidate for v6.1.y now, too. See the nfsd-6.1.y
branch in the above git repo.

-- 
Chuck Lever

