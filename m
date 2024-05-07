Return-Path: <linux-nfs+bounces-3188-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F888BD873
	for <lists+linux-nfs@lfdr.de>; Tue,  7 May 2024 02:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDF9A281F7D
	for <lists+linux-nfs@lfdr.de>; Tue,  7 May 2024 00:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E887C389;
	Tue,  7 May 2024 00:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kQ7m9P8E";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DpmCVIpX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D1D391
	for <linux-nfs@vger.kernel.org>; Tue,  7 May 2024 00:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715040859; cv=fail; b=mN4Ze8YlPy+oHJ4KTiQEzC+wsZ176a2bpekFaari6EmJV/kU4qm/NvM54lzSMkIFmUxAmvavVpExPLZxEsQvfdgSeQuOu87IDDtNKlajyW3+U+d9sQVtgyMaUDf96IGwh02HSS0HdUxi8KS7ZUUt85digkxQa/9kYI4ad3Q45TE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715040859; c=relaxed/simple;
	bh=8AbweXuxjH0SAKDMGBfQ6emgDwJKX37moB2pVLOY8kI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=siKYGo4aMpF4htvOb38NnQwY+ITcnXHZh3KJaVG1Y4m7dzoiFDrATEE4QyAlL1xN2dzjkWlPhZh6uN1M126EGNsN/A15Qo4c2ZQvaMAcUi13bbbYHyaFFIUltwRaPifxyihliQpO4vJi9JvvM0GaKsNNfjnBt1OSLgqH5G3HEZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kQ7m9P8E; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DpmCVIpX; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 446MqQOw031533;
	Tue, 7 May 2024 00:14:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-11-20;
 bh=raF5pw3Ssz/oFnbel3bMoRYT8N1Zh+kZpGEgJGgoHQM=;
 b=kQ7m9P8EJu6PWa/1DudXcA+7i8L0+YBAlNc9sKj6ZB/cniQyStOwFYGgoVttEkZVsZTc
 U1sl8mFL/GIbCTswVuNbfV4XXR6TaUUVLBj95jbn9TgewBcWFjz+9hCE7ogZAheDEEAQ
 nVjdvBrI2Ha7cJ32k/IPcikrPJn6k4QxZ0wRj6eqMVPznYJ2t8Msrn8e8xH3nSvX6O7r
 Q/7UaIulobM8FRH+QY7Pi7ZJU3wVdEOCdxBc6ChDK9+vKXhbDMLxdmkks7T7kOA5UBDG
 hi90wGFVbR8m10KNHE573n6Qa0b8OJC/0x4dKNfp/jRljOhOojRlazRnfinzYKvmGjyQ SA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xwdjuus6w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 May 2024 00:14:14 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 446MVcL0039461;
	Tue, 7 May 2024 00:14:13 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xwbf6akxv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 May 2024 00:14:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HKKK8ZKtIJyk8SLYdiRY6FPASSnYL0az58drtFmVq55Tx44esm6+wZfZMaNUm2Fov2MqRHhBN8NmK4cd9SY2gxl/7A6Rztl0QTBsuLlL1ca8jsHmwmG5+kKavZ8rThuMD88w+ZH+YqBeFM8VBHIJ3ZFxZheICLoFfaBZuJyvlbhl1dQSGwbPa3UVIC943/U7/PowhlpMniiJ5IUGsD/aZHwsruykJx8UP+RnzWGTbl2Vy38I2Yjak92zKTvDTe23IGD/blcCIwphzzB+yAgLkKmNTiLxQhD6RxgOaHig/KjtoQEGTWQC4EtpF8DSNUUAjqGX2YsKKImQW1E6DFEycg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=raF5pw3Ssz/oFnbel3bMoRYT8N1Zh+kZpGEgJGgoHQM=;
 b=G8Bql7ko+eGcCT+2K3R64UBdSfUAts67HxdmgzXZDFLdLFICCYrA7IW5A0xzRMdbNUkA94xdUelLugfM89pJqRrQm5GZMoKlMCEFIv05Tb3OhSDq7di6Dy6YMCj9da5p0iGBGWlw9ykeJougOmiQb27uREKn0F7ut1wAO39DlnUyB2+YiTBRjJ81w9eQs/lgJNhyuRUhSm23pNNSs7gWpIdFgIPKF7GgPfpozGk0amD77GVY49zFsTewelXMS0bpz43QrVzQDz2TtqGuA5QiNQ1UW/iGIewi6YPepk8yh7ga/CMogng+ljWRBKkySYKzeplOqddc/lQx+wOIVdV6UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=raF5pw3Ssz/oFnbel3bMoRYT8N1Zh+kZpGEgJGgoHQM=;
 b=DpmCVIpXveTXrsOnAksOFYMlOLzzJziX2dRkvSI3fteKBILKF/QJ3T4Lpc44I6n3gXU3x8vgzAm9lndYOV5gqbV2j7Xvg6LqbqR+FxkgJRpKmJXCNKDkSYSZBg0M8gaOhxGvcQoZ7Hj2Sk4rhvHbWSQttwzcp/AxW3p5aGzi5GM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH8PR10MB6574.namprd10.prod.outlook.com (2603:10b6:510:226::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Tue, 7 May
 2024 00:14:10 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 00:14:10 +0000
Date: Mon, 6 May 2024 20:14:07 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Rick Macklem <rick.macklem@gmail.com>
Cc: cel@kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [RFC PATCH] NFSD: Force all NFSv4.2 COPY requests to be
 synchronous
Message-ID: <ZjlyT95XGccXXRzL@tissot.1015granger.net>
References: <20240506210408.4760-1-cel@kernel.org>
 <CAM5tNy4nceCa7k+E1sKEAi5GYJvMwYDuApspFJvSdVdXBuHjmw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM5tNy4nceCa7k+E1sKEAi5GYJvMwYDuApspFJvSdVdXBuHjmw@mail.gmail.com>
X-ClientProxiedBy: CH2PR18CA0054.namprd18.prod.outlook.com
 (2603:10b6:610:55::34) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH8PR10MB6574:EE_
X-MS-Office365-Filtering-Correlation-Id: 435ff802-f6cf-48da-209c-08dc6e2a9e15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?eFRZTEY2VVR6cVJhcWVseDRnaEZnUGNyQUxEd1kwYm9RV1BEckNoWWg4eCtv?=
 =?utf-8?B?TktnalIwazFQQmlKa21Iak1BTFd5Z3hQVjhUeUpCVzRoQmR0bjFNUFdsemht?=
 =?utf-8?B?NVpaQi81NGJVVDFLdUF2c1NxRlZzSDk1aVNUb0l2YmwwRVRYdU0yNFZlUHVm?=
 =?utf-8?B?cXQ2N1NuWUJFenhRaGZ3ZTA0akhsYjhlWjhkYWNYN1M4aVZscDMrZjVPckVj?=
 =?utf-8?B?YTRlcVpYN3U2NUEzTTdMRVpsWW9uTC9CQjZvMnFBVWJiVlFuenhwdWlCR1Bu?=
 =?utf-8?B?YXRSbGR1S3JkTEgzWk15TlFpejlFYWc4dmx5MDBtZFB1TE9sRTVrSFlXK0ZO?=
 =?utf-8?B?RERyYk8wWURHV2pwRThwZjZURHl1WjB6LzVWQWRIdmcrV3QrdmFMUStaSDEv?=
 =?utf-8?B?ckxPWmVRQXpXTGExSHRNQitONkNJSjZvWVh2QjBSNDdicnl1aDR5bXdmYSsy?=
 =?utf-8?B?MlU4WHNud0xtdTJ6czZTZC9IR2RkaE1iVVZmSEg0SndPZUJla3lKZWtmWVJq?=
 =?utf-8?B?K01jVlk3b3UzckZQOGEwRXpOTkNmZ3VtUVNiUDZmU3NVbi9KTFV3U2pQZkhh?=
 =?utf-8?B?NXRnVUlOcTh0UGZJclI2ckV6OUVWM05GaFlZUStod21uNk5YYWxsaHB3bEZJ?=
 =?utf-8?B?MEFRM1lXMUx1eFlPVFNORXRUdHZNdW1hd2p2Y0hGV1N5c2JlcS9LVDM5OGU1?=
 =?utf-8?B?MW03dXczZ2hNSkR5SkQ5ckVmZnpCOE5sdGRjUDFXaU9aclFUbEZRTHdGNmRu?=
 =?utf-8?B?YU5UQjNQSGI5Z05CNVpXOWJadUVqZGR1OGJtUEwyQzBNNnQwQ2ZsdGx4SDds?=
 =?utf-8?B?R3NFblJERm5yQ2w0d05RejdEajNHV1MrdUlzaCswZ0JNZVU3b05PbVJ6WWpn?=
 =?utf-8?B?Um5Dajg5R1p5RDhnRmRDaEhleW83aldtSlowZW5tTVVDTWF3WVVYdG1pUXVp?=
 =?utf-8?B?aVZlS3pJajNoZFlLcU1IYjl1V3Z2bm9Ba0xROWhORmQrUmQwclM5NlFrdEJ1?=
 =?utf-8?B?cGJsQzdKZzkwNWJ1aEFTZzFHMlVib25VY3RrTGNUSEU5QXcwT1B5aTUvYTNi?=
 =?utf-8?B?ZWk1M0ZlZTJsc1dSVTMxYVNPNU9RZ0JkNGFRcnU1d3IvcDgxbTRZVDc2c2ha?=
 =?utf-8?B?UFU1UjJmWmV3MDJIb3JaWTgvYlVIVWVJMHF2aXpHMnNNUkdqYTVrWTRuTHBI?=
 =?utf-8?B?MmtrODFiVmdXR3pQcFNVdExseWlYVzJUMXVKOTFTRGNwdFRrVWlFMkROSWFY?=
 =?utf-8?B?aS9TQXlNZVJBdlNYN0Nqd3RHSVhvSnBUa1FtWUQzL0FQdzVLSm00T0luYVM5?=
 =?utf-8?B?SnpUcnROV3laSXZ1OFQ2NFFvdzAxY3NqV0NCd3BFUWs1aFJKN2lScTYvOUdi?=
 =?utf-8?B?UnpJTnpCUHd3UFNQaW9UL1Azb1QzUTZDVFJsVGVYTUhEZXhTREEvVTZUTzBW?=
 =?utf-8?B?UWJ2ZXFVYWNlQ25XdS94cTJHR2xnTGs4WTd4d1ZNLy9IcE1vNTQrRVg5UFlO?=
 =?utf-8?B?dkVTRktwUXU1RCtGeTNtWkhrU1JuSEZqa0hKRjhPaVJyTUJId1FLc1hPRCs1?=
 =?utf-8?B?dTdQa0U3eDFsSk1XNndiSGhBOTJXVWRzR1BMejlyci83UmNJNVdEdzNxRGFD?=
 =?utf-8?B?OEZZMVo0bkE2c1IwbTN5TU5JSEg5QTE0YkRVN2xmQngrais4S1pmd1RhQmU2?=
 =?utf-8?B?M0ZjQVNEQlQ1VElkeFNmMmdIV1pXYjdEK3RBVDg4Z3VCcWN5TVg3RHhBPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bVNYZ0tkVDNMWTNncFhGL2pXNGFxZjBaajVBS2thZ0pIcEw0RnBtQTBmRE1q?=
 =?utf-8?B?ckZWcTVqR0h4Ukhsai8zVHlvUWYwSG1lYm5ra1RSRkRjWnJiNWFtWSsyTVdC?=
 =?utf-8?B?NVdpVEZUOGgwZkZXemg0M0hCNnB1OXBvbzFJREFLZi9GL2RmYjRWeXFUVExv?=
 =?utf-8?B?Nk1WQzFGT1dPMUlaMUlyTmY4TnFjR1I2R3Y0R0p0cXlsT25VeGhqajhLbTlR?=
 =?utf-8?B?M001Rjhmd1ZuMC9QRjdFRmlSY0JmNitVM3E5TnhUYitUSVFZcHRIcXZpd1hL?=
 =?utf-8?B?bnE5aE9yZVNjMms4bEtEYjBSYlBSRFdzZTVwWDd0L2VhcW1ZcVRSOVBlbndv?=
 =?utf-8?B?Nm4rYTRISXdQOVhYa3ExSXFGL2hLTlB0ZktSbHZuZE0rM1cvZUdULzJGbHND?=
 =?utf-8?B?MGpodkhkVllKK2FySFkwTXVlUm91Q3h5VS9qN2l2OWVhbVA5a2FtWkxVNERq?=
 =?utf-8?B?dWplTmIzNE03dVdLTFpGSHFCNE1iRWJrVFdPY05hd3dCNDlvdENJMW9pTDlu?=
 =?utf-8?B?dkk5U2pteDlhU2pJanNON2ptVXMxNWpXcDVQb3hNRER0aE42TlB5Umh5YTBL?=
 =?utf-8?B?RDN1MWMrM1plb21WMnBDWFczR2lCYmVqZGp4Tk9zNm5WSGNHTVVtT2lkSEhy?=
 =?utf-8?B?UGJIbGhlQ3IzTTV6d3d4a1RBaXlUakhFSDBDM2k0VktiZGptUVQwcXZBdGVw?=
 =?utf-8?B?R01zSXp0dDNId09FZDB3Wk5EdDBNU3o5WXpIUCszSms1QVQ2citJY2VTZHBO?=
 =?utf-8?B?Q092U1JyMCtqUUlMaGFCc2ZRSDR5OEwzcVJRSUFCMTdXc1lJYzVMMCtlRytu?=
 =?utf-8?B?U2VQRzhKbGpqTmVrdXpxYVk5Y0dyRktBNFlaTldOVDJaQ0lTZ0l5dG5sZ1Zw?=
 =?utf-8?B?TVN4SUllbHpjMUNUOTM1a25EdjB0RGxCVUZLWXJMeW1mUHFpZnNSaHVDUytq?=
 =?utf-8?B?eEVNWit5N2RkV0MxTjBGWE1sWnlpdCtrYlpjdzFoYjBoRDJVU29uOG9rY29k?=
 =?utf-8?B?a3djL2pYS0xXZ1oxbGxqN0NDTGlLOTdJRmpPU042cTN0RzJzSTVRS1U5Smht?=
 =?utf-8?B?Mk9mUHlNMXdNczg3QkdiT3lyUVVPN1VuZkRKQi8xczR1TzVaeUJaS0FtT0Rp?=
 =?utf-8?B?ZU02MXhFWE04bTJldnM0dTdZNFhjMnZ6SUEzY2c1TEZPKzc3anZwTkNybEVr?=
 =?utf-8?B?SnJQVGxreG1sZW83czNuRDhZSFptM3MycDBkd1B3OTlLTGwzV2J4dE5jNkdj?=
 =?utf-8?B?TWUzaXkzbjFoRzNNY1c1aVVmMWl3SGFwTXFuRU5aU3JrWnJrUHJENkIzS3JH?=
 =?utf-8?B?aEROZmJXM3J3T1YzcUNrWXh1Y0VSR284VHlQbDhSTVF6bHVseVpsTko4Qy9x?=
 =?utf-8?B?ZlV2amJleGg5U1U4anpLSmNNUlVpSDJvVXB2c2RwSzFyU3p0RTVPbWxBZHJO?=
 =?utf-8?B?bUJhYkdkdEJkcGNETndXeFgxZ2xDSDA4T0w1aThQR0tFTGsyUTFoU3F4VHp5?=
 =?utf-8?B?ekpLR1BVUHdXUkFSQm5RR3FhNkpHNlR0cTNabDJtT0RXbjlnNWRiZENIZHJX?=
 =?utf-8?B?UUM4TTNqMGFvQlp5MFVUWVRSb3JwTHhLSUxQRGY2S0RiTzN4TnJBMVp5STNz?=
 =?utf-8?B?dU1tVTM4K2JMNEt0Z1JGTkpvcDlLNDB1allBcXpkdWRBQVIydVM1MWFKbThv?=
 =?utf-8?B?MkoxSkxpaWxPK2QxTlorVjRsTENNbjVoVmpsUFZ4clE4aWs1RHR4SXBPQnh4?=
 =?utf-8?B?NG1oSlJwbE1rTUxJVnlmMm92K3dqLzcxYmRkNHVyV3IxVkREdVExc3NydEta?=
 =?utf-8?B?Z21jeTA3bVZxanV2cnZpaTV0M2tudGVzTS9SbFlsWFg3c3V2YWhiVGdra3Rn?=
 =?utf-8?B?YVd2N1JHa3RPbDAwb2NnZVJpUnpLSjE5bXMzUGM0R25EZ09Yd0dMRnVnSmRK?=
 =?utf-8?B?WWE2N3BPTUFsZG1wUW1Ka0FTWnRWRHc3bGhuaXRUcEdSd2lXcjRxeURXUFlE?=
 =?utf-8?B?YURSdHRlOHd3WGdIdVBiSVJZNUpucDZNUU1wampYRnkzNFByRTRuZURGaUg0?=
 =?utf-8?B?dk1EeGxrRGRSZkxBRXZXek8xTEVUcS9VdXdxRHZPUG1JU0tFOFY1Vk44eHVF?=
 =?utf-8?B?dGNpaTR6akZmSHpKNjRlVGVBWk52SDlUeE5Bak5BckN1SjJRYkEwMzJXM1RJ?=
 =?utf-8?B?S1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Ne0mSVlmdCnhtZt4/xOMKgDwBSj2+e307hDpQ+TqzatRNYtjIMSm5Tt7gR+7h+tzky4cl7N5C+j0AzwnfupuRGi2hyb4HuPHXwVf0h40S41zjeZ2/oWdH7LSF7oXDoN7yj4n9HaNHC5vxFmV4477Y4ymo24m9JNB9d2fH4IOj8MFy3DJNGyLCFC8eUGOjtBYrDePCtZndiY07hcx6csfeVqZzifengm7yeYnc6IAr+MUIPkpduTVL316hOGKNtgwPBEFR8o++xKTeSi1gt0E3P/sISJEa9RmVz7s/UuVGaET6C7OKGDYLmhtn7ihXuzxVtkz0QC2mjL75U8D5MSXMJK2sF8a5F9QF+rLHK1/9s8pU/fCOxCb2Sy9Recjm5lDSPj3M9N+9/jtS9nWHbPthaq3WY9g9fjD+vGJOA3knuOyPkJHc7BlQ4T+1t5aTHenwfuqSdmumAVvqdmIUmIYtIFQbjvMbeB0hLkM/FiJTbUUyg/mTffAa6u4ugVaP5A067RZPQLf/HC/KUGlOtHJEAn8Qfwul7oqjtV6HfOXW6axWWrZWE356cT6/Fgr2tnTsGv5T4tECMaRs37Lbq1ugu7XZGJPPXCoz33xk3WaOd4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 435ff802-f6cf-48da-209c-08dc6e2a9e15
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 00:14:10.2084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wwFYT1fIGkJPdoyd/tAtEEz0RX5CNmevAhZL+CIpl4mYZwtMiSrDTOZywMY5DcwtVKcrBN2tYhC9o01l1H03JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6574
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-06_17,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405070000
X-Proofpoint-ORIG-GUID: kgsEOwdVWDcKydVbpJBJYyE-CMVhn2Xc
X-Proofpoint-GUID: kgsEOwdVWDcKydVbpJBJYyE-CMVhn2Xc

On Mon, May 06, 2024 at 03:30:18PM -0700, Rick Macklem wrote:
> On Mon, May 6, 2024 at 2:04 PM <cel@kernel.org> wrote:
> >
> > From: Chuck Lever <chuck.lever@oracle.com>
> >
> > We've discovered that delivering a CB_OFFLOAD operation can be
> > unreliable in some pretty unremarkable situations, and the Linux
> > NFS client does not yet support sending an OFFLOAD_STATUS
> > operation to probe whether an asynchronous COPY operation has
> > finished. On Linux NFS clients, COPY can hang until manually
> > interrupted.
> >
> > I've tried a couple of remedies, but so far the side-effects are
> > worse than the disease. For now, force COPY operations to be
> > synchronous so that the use of CB_OFFLOAD is avoided entirely.
> Just a yellow warning light from my experience with the FreeBSD server
> (which always does synchronous Copy's).
> A large synchronous Copy can take a long time, resulting in a slow RPC
> response time. A user reported 25sec.
> The 25sec case turned out to be a ZFS specific issue that could be avoided
> via a ZFS tunable.
> 
> I do not have a good generic solution, but I do have a tunable that can
> be used to clip the Copy len, which is a rather blunt and ugly workaround.
> (The generic copy routine internal to FreeBSD can accept a flag that indicates
> "return after 1sec with a partial copy done", but that is not implemented for
> file systems like ZFS.)
> 
> Although there is no hard limit in the RFCs for RPC response times,
> I've typically
> assumed a max of 1-2sec is desirable.

This is not meant to be a permanent change, but rather one that can
be backported to LTS kernels if we see the need. A long-term fix
will re-enable async COPY but deal properly with the loss of a
CB_OFFLOAD.

The server should return NFS4ERR_DELAY if it expects to take a long
time, no?

> rick
> 
> >
> > I have some patches that add an OFFLOAD_STATUS implementation to the
> > Linux NFS client, but that is not likely to fix older clients.
> >
> > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > ---
> >  fs/nfsd/nfs4proc.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > index ea3cc3e870a7..12722c709cc6 100644
> > --- a/fs/nfsd/nfs4proc.c
> > +++ b/fs/nfsd/nfs4proc.c
> > @@ -1807,6 +1807,13 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
> >         __be32 status;
> >         struct nfsd4_copy *async_copy = NULL;
> >
> > +       /*
> > +        * Currently, async COPY is not reliable. Force all COPY
> > +        * requests to be synchronous to avoid client application
> > +        * hangs waiting for completion.
> > +        */
> > +       nfsd4_copy_set_sync(copy, true);
> > +
> >         copy->cp_clp = cstate->clp;
> >         if (nfsd4_ssc_is_inter(copy)) {
> >                 trace_nfsd_copy_inter(copy);
> >
> > base-commit: 939cb14d51a150e3c12ef7a8ce0ba04ce6131bd2
> > --
> > 2.44.0
> >
> >

-- 
Chuck Lever

