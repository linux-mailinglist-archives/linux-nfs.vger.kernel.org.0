Return-Path: <linux-nfs+bounces-3550-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7857B8FBCC0
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Jun 2024 21:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FF2E1C23161
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Jun 2024 19:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1886B1E892;
	Tue,  4 Jun 2024 19:49:52 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC542913
	for <linux-nfs@vger.kernel.org>; Tue,  4 Jun 2024 19:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717530592; cv=fail; b=CVCsFafzsJ/PxqqZvT/mhFqI+FJA3ILYNWRi3Pp72cTxyPyQpoD9eXQDnkf+qJ7xZHog7JqOVYTJuqVcMX3dQeTEjIKHhovOV05x7K5wSVaGIeWJRwzNiaTs/AchL+1jtC4nehkrX+qSbFoUjEKIJP6r9aUjjJoEOeFABjsuHIw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717530592; c=relaxed/simple;
	bh=diM2Pw/03nSvRxpwWF63TFW1zpq6IpiXxwkaVSPvKdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XjK1qGeTJpaag42l/ZUeuZQj5UfE2Ex5mmG76BNlbURXGPANNIutvIbblitwSQmTSeL7jlEHTEsZIsR8zo4Q1vBzoNQ7YfuYVvvOj7jNhtttuDvQ+/h9AjCwe+xk53ojROv5O97vQo63ZdEhf8GEyX27iELUoTiuC0K/iEEyXgI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 454JCUlL005876;
	Tue, 4 Jun 2024 19:49:35 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3DCe3aPVHLlUq+K6Ow+iMGMVRasYUB9h6NWuTOxxd1CnM=3D;_b?=
 =?UTF-8?Q?=3DTLyUndm2rHYP8dCLtO1OiTGvPdU4AsMB6cRmlJ5/7/J0jXG5mGkylxBA6Oyd?=
 =?UTF-8?Q?1yMbS6qD_w2Qg6UyFk4PiqE7eNswh1fKZRb4mtyZC2n2Lep4nPEy4ts/Csoq175?=
 =?UTF-8?Q?7eMWx72KGOAus9_sf25ek9Ca3XPH3aVbxdnjhsQ9b4iGQr5dgw0Cit6+FJ3RfuZ?=
 =?UTF-8?Q?d5lK6Leh8Yt5aj0Qn0B3_w39hedAeMB3318VEciPJCLAabgLxU21Jde20oNchPj?=
 =?UTF-8?Q?J4A0BMiIH+8BweIYRG6ccOvcS+_ZGh6kxAZJei6dUqLN22MMrGV4kXdl3biTgGA?=
 =?UTF-8?Q?QjsC6GvGC4xjkKNT6CO6BZql0OvqKjOJ_TQ=3D=3D_?=
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yfuvvwrx0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Jun 2024 19:49:35 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 454JdprQ023931;
	Tue, 4 Jun 2024 19:49:34 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrqxaqta-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Jun 2024 19:49:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KPTiAdnj7OzTHEp0Rvm9Ub3cb/ADh/iJZYdUiB8ILqfgDHxV0IEqKHnGBs1YI2JAP3hWudfqT/jfnOnm9ByhBmNm14N5ich3sm5akP4Cqc9ImRwXlybU7XhL72Yonc5CvBvscI2Qfuc1s99c2NX+AO2UUSX3vTy3ZjL87MSL3HRd/FNYP/o13k38llDWkldAkXT+vfYDWJziYKSeZzoICo3QOgOb6m7liuoy+cQAvxbnqFcAze6Q2ONFs5zDm3GTjPtZSlDlGUNw2cIso7e7hbvYJH4ysyGAHQc7QR3Ox1BzS/PQdpfREDYpITJpPwe/RH+0XqlEjegEhpgH0DwvQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4vLHHtwLPjlalQiFwJhit3NTNNDZTaFSNEg9UgV/TcY=;
 b=eNqxqMIdyu7I4xUY3Q0amaxJTo56qv5r6YdhOgvXApbOA9QX0wtW0RXaTREGTVmVKIMPySoGUbceV6QHuWNadeygtDQ9AIcjmvrH/TGJ95kyUC0otBlsR+fbvw3DHHzqf9xtG5GiuhWpHgnKcQqhSK+l2jtCUFj9My8kRG6fyi4iXyKiFWpC+ktCEIgBsO1xqoahakxH9n3h3wS7R7KB3cW+hxNEAaFKhE/oLx2POohwXDhVMv4K3o3dA/O1w1LQ5PzKS5Rcvns5OM2RSnb1NufGWG9sVlY+j8Pb/C54ttXC+0U5j+JAPMZlCUMP2GFqj874U/Vz5kpMxAez/2HXxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4vLHHtwLPjlalQiFwJhit3NTNNDZTaFSNEg9UgV/TcY=;
 b=O5Nd5AnPCgi+ZdSzct5H6jBVuQCbcWqypNDoV3t4dcWLDgrhEdReyOeJN5WmtT0S8U5SOWwjFmE2dpnp0Ydt3IedOzvRs60+rFKtlNrX5mTE7/uA7XO9mZmWnFI7GFb5VhVCgdCbol6yU+LRMtDRmHxiF2MHtyzCZLXofRzdu5I=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB7179.namprd10.prod.outlook.com (2603:10b6:8:ef::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Tue, 4 Jun
 2024 19:49:32 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 19:49:32 +0000
Date: Tue, 4 Jun 2024 15:49:29 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: cel@kernel.org, linux-nfs@vger.kernel.org,
        Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Re: [RFC PATCH] NFSD: Fix nfsdcld warning
Message-ID: <Zl9vyagyALuLZzp/@tissot.1015granger.net>
References: <20240604152359.8662-2-cel@kernel.org>
 <7df1d99d4497379c22d584bc66772bcc25173cda.camel@kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7df1d99d4497379c22d584bc66772bcc25173cda.camel@kernel.org>
X-ClientProxiedBy: CH2PR07CA0034.namprd07.prod.outlook.com
 (2603:10b6:610:20::47) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS7PR10MB7179:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ce77f74-19b3-4121-5ed4-08dc84cf7437
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: 
	=?iso-8859-1?Q?i7mHtOVss+bUHi6ao633hF8a4EdfYg+Os63gZvrMpIymd2P1CsDEWy86HL?=
 =?iso-8859-1?Q?3ONvWghwnB10ulvRvMr42M6IIAB6XGSCmSvEEB3Pns/Ik+CNY4mnJ8Hxub?=
 =?iso-8859-1?Q?X5zxp4Mn2TKKCId84f6SsrhLiV/+yuJJ2UY8uCgcmKVPgZ9MXo2sCjTsZp?=
 =?iso-8859-1?Q?fVZlm8eF0FMnkCxPQFyWSPnd/gwkglAzodGuPLdlEUBoOxbqvqcNWEaX52?=
 =?iso-8859-1?Q?jnrdTnnrvH58WPKlPH0k0QbCdOMd/O9qcsFnKvOiGqaFfnPpK/TUZ9gLE2?=
 =?iso-8859-1?Q?8/nqpsS5+9pvKyJ9F2D1UySmSG04wjM7DslgPWyVqNPjpWWycplC8XlokE?=
 =?iso-8859-1?Q?/BhaEc5KyGnRfepHjLf24xmywONALiE2gehCqeJBvZGAqBEAZSax3cd9eV?=
 =?iso-8859-1?Q?UZeWjfJGLOkHM2zXoCYKFWasKN564AuOy1YPtrm2Bx19cz/85U6SIxGg4E?=
 =?iso-8859-1?Q?gKzKTXyLwNgfZRBr/8ETBY+VV53+p2fbPYsfdMg1z//X8Ct5WkNRrei6yO?=
 =?iso-8859-1?Q?0gwCTtya5O8hfx2KVcCAw6IjRHGH5hPm+xVxOISEuOgIQa2pGQVxA/bFo5?=
 =?iso-8859-1?Q?FPiHhkXOFs4tsFO+V2jpCRbgYgmR0SvD0Buypp3bZApwzRM5d68vmFdm1S?=
 =?iso-8859-1?Q?i86lKySVZD1aB7YiR+P/pnOBqakXzemhtjoPdyAo+E/q8UzZZrclbo3Tpa?=
 =?iso-8859-1?Q?lE5/ver0csD+y8MHagaID//MT4vvnxI6IwJFhWGdEHyBCGP2e2o7Y/7ByA?=
 =?iso-8859-1?Q?E2XlSuBcphY44zwGVZ24rzWyOOafwoUBDIAtwR4NSUkEkrqB273y+KIIKt?=
 =?iso-8859-1?Q?2K1VpR0Tq8pzWLgIgbrTZWHHUVjT7pHL2D8HaMRYkHg2LVjW1dOOZmVeQV?=
 =?iso-8859-1?Q?UdxGf8yr0iyQq16D0bpIitHFsah6BUkiUJh/G/agJSus2x/wUFgbCGyTof?=
 =?iso-8859-1?Q?+h3nVXTe/gt/EZSn9U2Fnk3HHmqOFDsodZzriKbS35HWAxuBVuSzt/5dHD?=
 =?iso-8859-1?Q?tKdns9sDFg8CEf9Dqq7fNgC7cwRnSFvvYpnl+BoWX/PmaNR12Zts85tyoT?=
 =?iso-8859-1?Q?PWbPulyuphDOQiRTHAAJj0YpMvaBVX+HmLCfovpXxIFzEWZvE5LYZClJg6?=
 =?iso-8859-1?Q?4mRI9GVFhPlEeu3ZFuTbL/6lG6a2CZoS0NPiv2gP8lr3fV/nO+qaUksBoB?=
 =?iso-8859-1?Q?YbGya0uWLGqLHoj3aMZt537EhXe2S4AGQMdrWOuaPGJVkH4H+iUwXyu6I9?=
 =?iso-8859-1?Q?QqExbZoIfhuWcimmPXX0W5Pfq/7gE2Ar7j7/YNmXJvm7lpT3NT5JE2FoRg?=
 =?iso-8859-1?Q?VUhlq/Cy74ksZw/+aOAjDYsLPA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?iso-8859-1?Q?gjpGTRAbypo6xK0E12Bh/lJicbwptFNJOx6NmhKfhshO47NzmJTnE2hN5U?=
 =?iso-8859-1?Q?FLQkwdhJ3Z0aRnx3YYY3wcKJWfIPYerlcuVgAvLP5PooRGo6VtEsaupyeP?=
 =?iso-8859-1?Q?iezmtGTD9D+bAiTiIj6JnAetNqS4PazJy1lTFwFY71B0DuHUEepdKx7mUk?=
 =?iso-8859-1?Q?lybNdcUQjCDUNKbZfMt38WZq8LRyTSp2vByJEZ38ebMC+xmFUmD5cEBtBz?=
 =?iso-8859-1?Q?rHtmyXzH6QXkRQ8GG55UdYFuhED0zhDPazlbgkMWwGiJ12xvyCpzJT25l9?=
 =?iso-8859-1?Q?HycHrVcjaJIwztjQnfYHR67O3zjhLrApDDplijE5yBYDKvyiA+dmGyjrV2?=
 =?iso-8859-1?Q?z2zIkOpOW6YipjtNc5IJTvujxf344u2DK1a7nQVRj/N3NTWV5QN+sZgeOX?=
 =?iso-8859-1?Q?XnwCvFtTttlGrO8y3ec2swxVB1CpwYuqFfGPILtz2WiuM12WPdoRZo49Ot?=
 =?iso-8859-1?Q?ggM5DLhXGwUaFN+hWH/wLAwGmn3pIpNUlZDwcmop93zFh4AJVn+dodIUy4?=
 =?iso-8859-1?Q?gLxv3MwBKiumOGba6qBdO3/PWOCKBMtSKi8RUpniFw3UmgUX4h+EMcWgUy?=
 =?iso-8859-1?Q?cdruf0q4iG3dfHjbH3x9NY3QGgkT0zG/CQQgAj0jZgbZHmUa3C5Zywpwr1?=
 =?iso-8859-1?Q?UnzyXCjfwGZjfwXHSycClTM5jVfKahkaju/o0sRkpYKJe7g9eHkjKCWg8v?=
 =?iso-8859-1?Q?at1Yd/a/oVbEDqdJ+2GEaW8hjvEsa6LDQ5dP7p+F6bJblSnWfYvcNDbwn3?=
 =?iso-8859-1?Q?mcBe0yyuaLgRXuLzH7Th/Lx20nSEGMCc/IrABVH7mE4t47qUw2ID2Kd/zG?=
 =?iso-8859-1?Q?qsVW2UVqaF9/kEsswT7RGgKKnCOGaywqj0o8i9Iek7HS3CVENe5+wMXJIM?=
 =?iso-8859-1?Q?rvYefggPtVCFZdPhkNkSxUacYJE9jQgOKkxwTLs1zw0otdmYeoJcwt065t?=
 =?iso-8859-1?Q?t1AqhNcqWkJ6/Oa8fAicdq928PXes0lrVJBM8a1r24KgSAKFiFAsBobHOq?=
 =?iso-8859-1?Q?KUUbbrxO4pjjFHvhRkS8EV+mwzkgDNAEpVshA8R7/4uJNeVYqAvKkK9FkX?=
 =?iso-8859-1?Q?91bWSvkQNVFLpnw4cQTkyl7D8W8pNAmT+ULnavXVjr2SbgOTmMdJ7z96xD?=
 =?iso-8859-1?Q?tSLcepnVcCwSnFGppcYoCU/MRFQuBrYW1OgA/VBQM7qzdJhbz/YDZqII6U?=
 =?iso-8859-1?Q?fFfZgkj/tMMYrOrvSBVYrJsqm4AIbX65TJwNt/LvYxVp55eEf8JR0qQ0ro?=
 =?iso-8859-1?Q?I5A0NF/ujfdjnfOZ/Roy1JJquKGCwu96axQ11O4/dpPcR/Ba+tYKlrUuHD?=
 =?iso-8859-1?Q?DkZAS/po9xTu5aOUEnxG0ua22vCufbd7qAgIQi0pO21bB30SD9cy+VdOZH?=
 =?iso-8859-1?Q?Eyncu0NNfIStW/IGn8lndq2psROMeDoa3mBRMXbX46YAk9eVoPV+igIEZ/?=
 =?iso-8859-1?Q?xk90yQBUa74Znh4+B9uUc3GtbX4S9bTzq1pPPcUsCzzO6bWiGSQTTx2hYD?=
 =?iso-8859-1?Q?nywyYZv5YI/ZIwnmmRU1vQtfExGQbHR49U6hI/cxhqfprP3nJgXvXsw4r7?=
 =?iso-8859-1?Q?TjpSSw6HySsZMgRY1I6nEYDnbFFPpFcEZ1V3HMBjNIT4jQDxy50hBv+NNq?=
 =?iso-8859-1?Q?VEX+Nf78m5ryiZl3RsEd4QZNBWSm0sgjF2NuPX8tL0JKmynv0oRaUxYg?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	vWYMHc6PyLAzgdJ3s4RUaKUXQKlGX5DsT5P6tbMkSkH1G1i+00bmGlBuE8aY1IzIg464PgPOD2Ry0a8UDDvoIGEaLMsSqhiTPpib7CXW8d3TvqMNW3Rh4kBYclNa/CpQ3gOUzqYU0buWdV36llfUmEkBxoZ+soHjED1dWohXMDRk+nHXLHC1RDzDu2CMXbLWIISgHfjzjgRhiyXylSmaEYYO8dKHutc+uN0sOi2n+POlZVD/0l2QwLQcO8SUCVOYVz+EYdaqFm9ss6Mt93gaf5gxD0bu9NNDDP5C+grQkgfSFYv7WZkkQ2XFiNYWUnFfp/MNQJFV96JA9xcKsehUg3w0blq/jrxa+taKvrZWf6u141y1KNsqd+IeGZ2ReqJlTYcVnKnfY6cCVxQMKHUQmy5b3zijdAx1crNpXvnnmMPWXQYx2ACPc0BhaMu/7x25iwnfaT7RCn8JeTqf9Rn2eAbqIC5RjMYzzfPgoBXJ8ymIo0cXGSur2xm6VJYzYoRu0SGVHEPkqcDhZUzq4lt1O6rfQDoj2vFjJfCVK40RAKihlIWXk1kDuCbAUD1IeMr2G6jc12EDgH/mujlFHakV7KTEhEbaR2JqH/ISj6vHWSs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ce77f74-19b3-4121-5ed4-08dc84cf7437
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 19:49:32.3633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J411SzE3yso8N7fuRXci9r32ma/mMMfNwS1jaucd4KugtS+n1cy5JdzoB8TaxtE7Uuvjdkau35qnuG2Cv5cZaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7179
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-04_09,2024-06-04_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406040159
X-Proofpoint-GUID: 0ZESVEbfgwmZXTaXIekZj8p3cL9PGA0Y
X-Proofpoint-ORIG-GUID: 0ZESVEbfgwmZXTaXIekZj8p3cL9PGA0Y

On Tue, Jun 04, 2024 at 02:52:49PM -0400, Jeff Layton wrote:
> On Tue, 2024-06-04 at 11:24 -0400, cel@kernel.org wrote:
> > From: Chuck Lever <chuck.lever@oracle.com>
> > 
> > Since CONFIG_NFSD_LEGACY_CLIENT_TRACKING is a new config option, its
> > initial default setting should have been Y (if we are to follow the
> > common practice of "default Y, wait, default N, wait, remove code").
> > 
> > Paul also suggested adding a clearer remedy action to the warning
> > message.
> > 
> > Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
> > Message-Id: <d2ab4ee7-ba0f-44ac-b921-90c8fa5a04d2@molgen.mpg.de>
> > Fixes: 74fd48739d04 ("nfsd: new Kconfig option for legacy client
> > tracking")
> > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > ---
> >  fs/nfsd/Kconfig       | 2 +-
> >  fs/nfsd/nfs4recover.c | 4 ++--
> >  2 files changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/fs/nfsd/Kconfig b/fs/nfsd/Kconfig
> > index 272ab8d5c4d7..ec2ab6429e00 100644
> > --- a/fs/nfsd/Kconfig
> > +++ b/fs/nfsd/Kconfig
> > @@ -162,7 +162,7 @@ config NFSD_V4_SECURITY_LABEL
> >  config NFSD_LEGACY_CLIENT_TRACKING
> >  	bool "Support legacy NFSv4 client tracking methods
> > (DEPRECATED)"
> >  	depends on NFSD_V4
> > -	default n
> > +	default y
> >  	help
> >  	  The NFSv4 server needs to store a small amount of
> > information on
> >  	  stable storage in order to handle state recovery after
> > reboot. Most
> > diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
> > index 2c060e0b1604..67d8673a9391 100644
> > --- a/fs/nfsd/nfs4recover.c
> > +++ b/fs/nfsd/nfs4recover.c
> > @@ -2086,8 +2086,8 @@ nfsd4_client_tracking_init(struct net *net)
> >  	status = nn->client_tracking_ops->init(net);
> >  out:
> >  	if (status) {
> > -		printk(KERN_WARNING "NFSD: Unable to initialize
> > client "
> > -				    "recovery tracking! (%d)\n",
> > status);
> > +		pr_warn("NFSD: Unable to initialize client recovery
> > tracking! (%d)\n", status);
> > +		pr_warn("NFSD: Is nfsdcld running? If not, enable
> > CONFIG_NFSD_LEGACY_CLIENT_TRACKING.\n");
> >  		nn->client_tracking_ops = NULL;
> >  	}
> >  	return status;
> 
> Reviewed-by: Jeff Layton <jlayton@kernel.org>

Thanks for the review! Applied to nfsd-next (for v6.11) --
the Fixes: tag should ensure that this will be pulled into
v6.10 eventually.

-- 
Chuck Lever

