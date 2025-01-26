Return-Path: <linux-nfs+bounces-9630-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F9CEA1CD40
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Jan 2025 17:50:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B8281648F6
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Jan 2025 16:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 524F313B59B;
	Sun, 26 Jan 2025 16:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ROn+AYqx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UtTA0TYb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A5A25A63B;
	Sun, 26 Jan 2025 16:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737910243; cv=fail; b=ZqIZ5Gb0Pe54C0KfqIEsTuHfB/zVMPKHeY0qbWdMsrFGrkW9s2Ovp3GIUoU0jUDzLPXtPWpM4VpSUngEmKMg9DsSVMn5+fr7XltWnPk89onQ7vrymkxssAfqZlxP+ixWncskK+hP6qbRZ0Y/Kqt2bGxmd006qzzLioCXk/jiys0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737910243; c=relaxed/simple;
	bh=E4K105YaKBAKQOqAAMRVPl0mfHcLoD8RbMXEIzl7Cu8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KAnSNp7WD/fDAcRpKu1DTkKjYczUcBkL4WD7n3uTW+GT0ftg7m83E9uPBmeMQkr6kY+ccsk5vAVdyPE9vFHYJVAmENJeBrywNFDaHj5McoOWByBGZRE7dTqVn5FISFqXiSZvc4JvOsUbVi3TRtg4VGDy+qVYb6eoOsWUvFN9E6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ROn+AYqx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UtTA0TYb; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50QGUq72019258;
	Sun, 26 Jan 2025 16:50:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=6NdyntaWHiWBpsekAdrM/k0P9TRwzCigqDA8gg01HJM=; b=
	ROn+AYqx4T3dUCpbrZ9DzjmtAmaDT8q7bZtFbkxZGI3t8iO3CaknqTHpg0GeL08/
	WMjK8mUrtbyL3gfqkC+PwaE106XAjj0EALC9jqeY8i46UTEBNH0X6g6Bczojreti
	F9ujg/Og3uKzYu7dsmBLCgG3NepfeRUFWJ+QW9LBMJovhjFnl2f7KErYy/9GZSR9
	76LuEyv4sh2+A+ick8jGS0z0PrlTDQ4f2nt7mMQYe3g/sAjcuKqoEHYxpESmgXwI
	WUpppTLXSR/mYeGlNyRAh66mcrrd8ROeglZZyt5XsBbLH+7d5TN/C7IalAYcZvet
	tq7/7Jh5wZGTxHU7f33NHQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44cqu8sdwm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 26 Jan 2025 16:50:22 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50QBgElK036774;
	Sun, 26 Jan 2025 16:50:21 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2043.outbound.protection.outlook.com [104.47.55.43])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44cpd66qav-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 26 Jan 2025 16:50:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m7/+49bl29PJU9laj7z1vHKDILkGv5v/J09B/5eFygiQ1H0IjbovH8f01nVdH0GIz8axkHrMtjLHbrnxGxHwcjvRP9D/zksRJ9f1lLx7Xvq8XagcVDOBMMHTiYPCz4KwHEVAmV32BWLiBYwvnSa05UlyZxzYEebVA5ynmsJl36meYjqfRlyZ9/zt1Z7RjTWx7j/hfY2Ucuj9bM46I3tZwzOMGd6MTy37qM9rjLhoRsv8pJTgO2aJzEJ2uNgXZD1Lp6Vn05brz/aaLtgrsyqeWybND3iC42qDfRB8TeuzEGOmglqq66tw0tdbwiytgfp2qJNn6i7UjdxKNI+bXCTLIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6NdyntaWHiWBpsekAdrM/k0P9TRwzCigqDA8gg01HJM=;
 b=nzzAji9RZsdqtk5BesZLmzSAyQRFKH3iO9CW4VadG8EZap8p5z1Vh4E18UMAa4Dz9Jr2YI0IOMe7uXbkSnmq46NU8Usd9BQhpRv1+kI4y3NOsF3bqVCtacSEN2mwF511ceRcOg+18AT+eB++orcFB1685Ko0cRmWi/9cpLlisVGjFOqRns6MwffZ+uN5N+bfvO1xlnvABOFKQ3I3nRiFN+9xgcw8nHlIt5s+9XhKrSzrYyL4XnPKDGuG3CKc/RzXx3wpuTeim7ItxZsIwtKWgk3/pC+1x1U4GO/NttwIRYyNwS41/bvBmD/+EQ0z4ZWgrr91NpIVBC/ksNTXCj3u2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6NdyntaWHiWBpsekAdrM/k0P9TRwzCigqDA8gg01HJM=;
 b=UtTA0TYbSXtpn6TqE6kY8qxvuNz5Q9GgHr5J9ehP5V+ANu3WKrh/wHRE9WGF9ITEyKl+0EqZ+etCeOtuTdsZSjS7ph9rQ+vYM2p9gFFYzzOs5nP61/rNINiAugZrBh5WDF+yVnxlUKd2vz93UcswDRv2wvRTgg42LY+WnbIe/VQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB5801.namprd10.prod.outlook.com (2603:10b6:a03:423::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.19; Sun, 26 Jan
 2025 16:50:18 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8377.021; Sun, 26 Jan 2025
 16:50:17 +0000
Message-ID: <e35c6aba-b05b-4822-b89e-bbf95b69c085@oracle.com>
Date: Sun, 26 Jan 2025 11:50:15 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] nfsd: clean up and amend comments around
 nfsd4_cb_sequence_done()
To: Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, "J. Bruce Fields" <bfields@fieldses.org>,
        Kinglong Mee <kinglongmee@gmail.com>,
        Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
References: <20250123-nfsd-6-14-v1-0-c1137a4fa2ae@kernel.org>
 <20250123-nfsd-6-14-v1-7-c1137a4fa2ae@kernel.org>
 <8a6e1930-feee-47f8-8260-874b9c47f20e@oracle.com>
 <42ef9ff65c27fb7347f72e85b583ff74b2200bd6.camel@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <42ef9ff65c27fb7347f72e85b583ff74b2200bd6.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P220CA0027.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:ef::21) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ0PR10MB5801:EE_
X-MS-Office365-Filtering-Correlation-Id: 5296a305-388a-4349-3c30-08dd3e298372
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|366016|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R1A4NmQyTndVcVB4ZVRRcERUaCtXOEhpTGhjYkZYQlY1N2tyUzhYM2hPZkIy?=
 =?utf-8?B?WkZtNXcySHFUc2J4d0ZLK2h5MXBmU21rc0pUc3R6bzBEcm9vcVhSZmx4c2xp?=
 =?utf-8?B?QlZqL0xlR3ovc0dseFB4aW5OanU0OXdQcnJsWGp3QUs4cTJhZEZUTkJ5dXdi?=
 =?utf-8?B?NytSWldmM05sVDdlMVJwRFgzbDRadUlZM3B3OVFiK1RlYzRMSU5JZWVRYVRU?=
 =?utf-8?B?dm1hUGNIbjhVanlnSFUzcXVTSlYwMEhjVlcvNDJpT0ZsekZ5b1ltS0dLVVhB?=
 =?utf-8?B?RlpqNjBHQ3B6OGRmcWNSUUFSTmpWZ040UUVuRm5Bc0lYbTVwcHhBK2dIN1R3?=
 =?utf-8?B?aW5iSzFyd2h3Z21EK0ZrRTliaHZpdTdOZGtSbEJPOTlCcmpTOWx1Y29yblZu?=
 =?utf-8?B?S3FVRlhIall5MFJIUEhpVGRJVHB1WVFvbnE2K0g4WGUvVGdqT0U2V1RMSFgr?=
 =?utf-8?B?NVdwcUttUEpKakhpbzlSTHMvK3ZIYzJwaTE1RjM4c0MzVW9BdVRZVFNBcmdm?=
 =?utf-8?B?a3ZPQ0J6U1R2dEdmUmNVK1ZaejFSMUlBRXhZQm8venhsT1ZLKzdBR25ielg0?=
 =?utf-8?B?ZUx6OUlGNlpENmdwSXpuVHRTT3YrN1FDeWpoUGR5KzJrVENWUGErTmNkNFRN?=
 =?utf-8?B?Wk1FaXFIWWVHbmo0a3o4b0RNdEgyNnpVdmtsUlYzdTA3dzF6dEdwK0xGTjF5?=
 =?utf-8?B?dnpvVmtlK1kzcjFVYXd2dnRpc3lYMTFmWHFvQ1pDaXhvOFRaUkRPYm9KUlV4?=
 =?utf-8?B?T0ozOUxJOHFqY3dXUHl3SWhnMWhPQ1JpeDRYc1hscGJUclB5WFFxSTZIQWgw?=
 =?utf-8?B?QmM1YWNxWXNxMUFtVXNWZXlZZUdtSVhDTXVvdmJ0UFBGZEk4S3d1YlNhdGxC?=
 =?utf-8?B?dW02QWJ3aXlTcERhVzlmRWlTYmlmKzVtTzFmL2lrYWh4Rit4TnZnZEVKSUhR?=
 =?utf-8?B?U2N2WnJBT0p5M1J5RlA5Q25wR2gzbmZrVGh1aFRLaVVRWVZ2TGVWenJGY1hK?=
 =?utf-8?B?NEFBeDZwWE9uSlpHZ0lTb2t3Tk9pN1N6TVV5T1M2dTBQREZydHJTRU1hVVE1?=
 =?utf-8?B?b2tpNVBwS095VFZuRWxzcU81eGxrZ01OaUEyV1NDZ1BqaWR2ZURqalRuRFBU?=
 =?utf-8?B?cDdCbExEMXo5WWJ0bFk5TkxjblhYZmh6bmdmTHZNd1d3OGtDcE9EckVtYm1r?=
 =?utf-8?B?cHE0V3JQUW1XWkZWaG5zSDRIUDYwVjRyT0pNb05neSt6N2t2VjFkUy92R3hx?=
 =?utf-8?B?YkdWemc2ekhiQTBLQ3ZoTzZhZzFvRjZoa05vWlRzcE9OUGNlWDluRWFXV3BS?=
 =?utf-8?B?U2U4N3ZtUWpISzU3S0FXeGdQdjNnZHdBakZiRkQ0bWx6RkRRSlo1bmhJUzU2?=
 =?utf-8?B?dlZvYlEvOE1wNFl3NE1NY1pZUzJiaFN2bCt3VkQwS3VkTzAwMUJqUU9qWm5x?=
 =?utf-8?B?SU5TYWpicVRmNnZCakVMdjlTeGVvWW5lclJHc1ovSzM4T0NnOHNiT0VZU3BJ?=
 =?utf-8?B?bDc0QWwwZXRqdVZlbXZqZlNtOGQrdnpZNGJiS3dBNTB0OW1WVDh3V3gweVJ1?=
 =?utf-8?B?TFJiM1VnbmxKOFhPSTR3dm1KTVRTYU1CT2F3VlFJQkpkVE0vQjhHOTlUNitX?=
 =?utf-8?B?VGhlZ3FhaDdPZlQwR1pVT2FDMUpiL2xscVVXY003WDh6Tnk5NW9rSXlXZkd0?=
 =?utf-8?B?Y2gwWmljRHRSbjAzUmp3NENZdEZEL25sOHl0VDk1dHh4aXJmbGtvY0c4VzZ0?=
 =?utf-8?B?RWlZUExMY056QWtRS0x0Sk1TU3orWmVHNnQ4RWx0cUZpZFRFblNseUFtSTkr?=
 =?utf-8?B?YjBtUFJHQm5qaFk5QkQ1ZFpPMWJUSFdPR0QyRmVwdHhWSTVVemFGem90N251?=
 =?utf-8?B?MXhFOUYzS210UnFYYXpxdnEzRkFFY0pwRjVqUkRMakduTFNEZ09OOW9HRlIr?=
 =?utf-8?Q?vmDmu6YnpGQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y2NISStaSEZic1gzcUc5RmdCUkVXM1FSZDlua2VoaXZzeis1a2x2Yml2ejBX?=
 =?utf-8?B?NW5yd2l2MUpqWHRwR0V2R1ZHMHVETzZ6VTM4WDlDazNHY2ZTcjEzUzdiZWJK?=
 =?utf-8?B?SXFYUjlEYWZhVVhmc0VPOVBBM1JjSXc4dEhIRXJRQjV1Q3JrOFV2M1FBV0F3?=
 =?utf-8?B?SjRpbzRJdjhiNXRlbHgydUdiR1NnOGJCVlNaMmpmd2ViOHF2c2JKeGhSckph?=
 =?utf-8?B?TEFvbUZ0eHNyTmJIQ1RtbnBEVEN2bG1oWCtPSDJBMStmVmJqbG5tOG1Ca09p?=
 =?utf-8?B?OStYb2NKTUhBYVpjUmNGNUcxejZBV2lMK1VkWFdlTHZQc1QrYzFNa3pCRzZ0?=
 =?utf-8?B?eEt4bTFVQ3FrdTFrVTZ3Q3dSOVB2SVRhUjBFcjc3aXk2NDJLMzJ1c281WHRO?=
 =?utf-8?B?bmpEakU1cEdkcEY5bzhMZEV6RlY2TS9rRzNLSzdSSkN2VnFPNmdrMjRiZjd1?=
 =?utf-8?B?VFpkcXVoUFFLaFNzaitwUXJ2MW9YaTBTdElIVUtMOGFzVXhxM0FucS90VlRn?=
 =?utf-8?B?SE92S09UYkFwN0JudGp6QW5LSHBzc2tpN3dvWXpnajIzeVAyOWtUQlZKaTJQ?=
 =?utf-8?B?UmpWdTBrU3RKWHFNRTluNitZdzdTaW5DVjEwNFMrTXZ1SW0wWThGQ3N6U3Bj?=
 =?utf-8?B?M094TTYyQWowcWFmMG5LaVU2NnpaaG8ybUltQ1MzQk9kNnNBT2JOMW5hc1FR?=
 =?utf-8?B?ZSsrY2g3U0pNaW1NWFRNamd5UkdleWNpOGtjNzBtclhEVXRLSFY3Rm5MajJ5?=
 =?utf-8?B?TmRqOXVPa09Gc1BiSWJXN2h4aHB1Q2tCOTQrWHd3dDJwbDdkcnhtSUVHd1BG?=
 =?utf-8?B?VG1FbkhKenBuMyswSnQ5Q2hOVXkvbEZhazhxaFNkeW1XVG51aTFCYzBhZVpw?=
 =?utf-8?B?QW16djF3VVRpZTZldnNzNnFrSnMrbXgvMHppQ3g5ZVFVclkwYlFwWllsaXB3?=
 =?utf-8?B?RGVWK1RJbnhLTlV0K29wa2QvK0dobTN0MVYzS3VsQ2luTGZZUkgzMU01QTNm?=
 =?utf-8?B?U0NTOS9jckZzVU9YVHZIN1RQMXNTZkVFUlhlbE9wRVdmYWpCYXF3c2hiUU1u?=
 =?utf-8?B?WURqQUJsSGhDRTg1a1RwaG9QdHl3UXMwNnpkZlNNQ0JIbGQ0enlFbnhhSjRQ?=
 =?utf-8?B?OGppNTd5cUJOQTFNQ2tONTYrZXpLL0VJSnpvejF2eW5vNExXV3NKSHlEbUNy?=
 =?utf-8?B?aGlKYVgwdVAyYnVyemVJTEZWbXR3dGR0NmlranZ0MzJzVmNZcGVVZUZoUVlK?=
 =?utf-8?B?VkowTVRNODA1eGszdytJMndNOU81UUFXWHFTWnU2cmZoWUVQUUhnSUZhMW9G?=
 =?utf-8?B?MERQS2NOUnJCblVUMFo0bHpvR0ZKWlV0elZHTWdEN0E5Ulp1d2pCN1F2VndU?=
 =?utf-8?B?NmtmYThsZlNKR3pndlhicUh6SnZrbThJWlF1UTg0VXE3RG13MEJxYnhhSWs1?=
 =?utf-8?B?M2RCUllLMjl5Nm0xWUNWdkxiTWNYVVNJaTZDY3BRTWVFTXJwQW9RQll1VHVZ?=
 =?utf-8?B?bU15QXZJSmJ5K0RrWTd5UXZvV2UzUGRoWTVXVkVDN0l5R2RqU3Y0ZFppWk1Y?=
 =?utf-8?B?T05XSmlqN2NaT2pzdW5WNHdvY3h6L0orTUE5MTJvRlV3RDlRK3d5aWF5MWFu?=
 =?utf-8?B?WnJQRHp2N2pjTnVEbFVVc2xnRkpHVTZMRGV4WEZ3Q2ZTdzBOK2JkcUozaStk?=
 =?utf-8?B?RHNVdXczTEI0aS9ob2svRkJsclFjRldCRzVHWTNsYndWc21zeXFkcjNURjE2?=
 =?utf-8?B?eUJQd3VpbUpUVWk2cTNnVE9jMHhhK08vRGx2WDhtUjFoaW9YcThrNVgxaGRD?=
 =?utf-8?B?T21xUnU2RHZoVnZBK1diSURZY1VYY2ZPY0RubVBRWEZrM3VkRG15QlZPM3g3?=
 =?utf-8?B?TE1hZHEvaHR5clhtTm1MUllVYXgwU0FaVWptUjNLMkdrM1ZKc1pUbWg5K2hJ?=
 =?utf-8?B?Ym9aSENCc0J3Z2xoSUpDbksyUzkwbThTOFl2VzZzaHNzUXNheVUrN0FtQVZh?=
 =?utf-8?B?S3RUODNOaUs0c1FDdnNxQ0NsYyttUW9BelRxUWZWT1BNMUN0SXl3N1BJZ2JR?=
 =?utf-8?B?UWhWOHVNdDNPK2EzdXBMUjFOMCtTR2N3NjFXWGRrdVpaU0VRcXM0QU1IRDdK?=
 =?utf-8?B?c0JrUlkyaHJYTmRjbHc3SmM2TVE1MURHNllVaWxybyt4ZXZtM1lCcFc1MjRs?=
 =?utf-8?B?bmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8sixc/fcetzBZUtMSsAFAudvSQhBThRFBhQYrgqnpInUGrhfqPsa+BnyAqQGZzo7QxauFWFo0Bif8J3TTvsX+zvWdKrCToRZUiJ4/o1YlMmg+EBPXsOoLGoXzz/euNNg8epdYIYAQP9bamiDl954Rwc6GFgbb3grklT6sk3I0hPVF4VPVsk1XpVhniuKo6PVU96cNGqAkvaxegTIErN/mkSe9Zlf5GmHO2w+IY/7XO3ZydDjIKukriTU/tpf8CcjZfr43i6j/8n/KX8pVqnYVVuEcSospZRWHoYjEqnSDUka9RpLCFMfoFia56JJdS+wY4O7rxxPd3zH7KQdOaCKNjGflTqKQ93/TomCdU3hSbaRhx0NzEuvo4kRp53P0IyW2ry0KKuihyserpcgqAjw2FYaWmopLA0Isp0Uv4hOP4k63mL7zBnEUvBzxhMmicAt1/NozR2BxL65vqnNzm5300ory9BRt2gFkLlemN4zfTSpisrXMgy6+XefwMOziGcmpl70qnJ+2VomNMfIXSm8pOVRELfVf4KD4eCpTBlA2V5orzAN9X/fU0iQYZtx9yxY5ioAMm9seNPkCbVtn+IHqhzCTYYRVlOcizNvAfD2YnY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5296a305-388a-4349-3c30-08dd3e298372
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2025 16:50:17.7671
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vEVH7u8N402BqhUOqAvmSEHJK47UDJR2RGx/GEziMaWUnSaFoG0VFXMI5/V0E1+KhGZtU04yVSxQLhGPnuN6UA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5801
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-26_06,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 adultscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501260136
X-Proofpoint-GUID: FwmtuehNKE_EHVKtrr-S_z6Bin4GWqjK
X-Proofpoint-ORIG-GUID: FwmtuehNKE_EHVKtrr-S_z6Bin4GWqjK

On 1/24/25 9:50 AM, Jeff Layton wrote:
> On Fri, 2025-01-24 at 09:43 -0500, Chuck Lever wrote:
>> On 1/23/25 3:25 PM, Jeff Layton wrote:
>>> Add a new kerneldoc header, and clean up the comments a bit.
>>
>> Usually I'm in favor of kdoc headers, but here, it's a static function
>> whose address is not shared outside of this source file. The only
>> documentation need is the meaning of the return code, IMO.
>>
> 
> If you like. I figured it wouldn't hurt to do a full kdoc comment.
> 
>>
>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>> ---
>>>    fs/nfsd/nfs4callback.c | 26 ++++++++++++++++++++------
>>>    1 file changed, 20 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
>>> index 6e0561f3b21bd850b0387b5af7084eb05e818231..415fc8aae0f47c36f00b2384805c7a996fb1feb0 100644
>>> --- a/fs/nfsd/nfs4callback.c
>>> +++ b/fs/nfsd/nfs4callback.c
>>> @@ -1325,6 +1325,17 @@ static void nfsd4_cb_prepare(struct rpc_task *task, void *calldata)
>>>    	rpc_call_start(task);
>>>    }
>>>    
>>> +/**
>>> + * nfsd4_cb_sequence_done - process the result of a CB_SEQUENCE
>>> + * @task: rpc_task
>>> + * @cb: nfsd4_callback for this call
>>> + *
>>> + * For minorversion 0, there is no CB_SEQUENCE. Only restart the call
>>> + * if the callback RPC client was killed. For v4.1+ the error handling
>>> + * is more sophisticated.
>>
>> It would be much clearer to pull the 4.0 error handling out of this
>> function, which is named "cb_/sequence/_done".
>>
>> Perhaps the need_restart label can be hoisted into nfsd4_cb_done() ?
>>
> 
> If we do that then we'll need to change this function to return
> something other than a bool, and that's a larger change than I wanted
> to make here.

I don't think that's needed. If you create a helper like so:

static bool nfsd4_cb_requeue(struct rpc_task *task,
			     struct nfsd4_callback *cb)
{ 

         struct nfs4_client *clp = cb->cb_clp;

         if (!test_bit(NFSD4_CLIENT_CB_KILL, &clp->cl_flags)) { 

                 trace_nfsd_cb_restart(clp, cb); 

                 task->tk_status = 0; 

                 cb->cb_need_restart = true; 

         } 

         return false;
}

Then you can replace the "goto need_restart;" sites in both functions
with a tail call to this helper:

	return nfsd4_cb_requeue(task, cb);


> I really wanted to keep these as small, targeted patches
> that can be backported easily.

Clean-ups are generally not back-portable, so I don't mind if you go to
a little extra trouble.


> I wouldn't object to further cleanup here on top of that though.
> 
> 
>>
>>> + *
>>> + * Returns true if reply processing should continue.
>>> + */
>>>    static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback *cb)
>>>    {
>>>    	struct nfs4_client *clp = cb->cb_clp;
>>> @@ -1334,11 +1345,11 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
>>>    	if (!clp->cl_minorversion) {
>>>    		/*
>>>    		 * If the backchannel connection was shut down while this
>>> -		 * task was queued, we need to resubmit it after setting up
>>> -		 * a new backchannel connection.
>>> +		 * task was queued, resubmit it after setting up a new
>>> +		 * backchannel connection.
>>>    		 *
>>> -		 * Note that if we lost our callback connection permanently
>>> -		 * the submission code will error out, so we don't need to
>>> +		 * Note that if the callback connection is permanently lost,
>>> +		 * the submission code will error out. There is no need to
>>>    		 * handle that case here.
>>>    		 */
>>>    		if (RPC_SIGNALLED(task))
>>> @@ -1355,8 +1366,6 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
>>>    	switch (cb->cb_seq_status) {
>>>    	case 0:
>>>    		/*
>>> -		 * No need for lock, access serialized in nfsd4_cb_prepare
>>> -		 *
>>>    		 * RFC5661 20.9.3
>>>    		 * If CB_SEQUENCE returns an error, then the state of the slot
>>>    		 * (sequence ID, cached reply) MUST NOT change.
>>> @@ -1365,6 +1374,11 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
>>>    		ret = true;
>>>    		break;
>>>    	case -ESERVERFAULT:
>>> +		/*
>>> +		 * Client returned NFS4_OK, but decoding failed. Mark the
>>> +		 * backchannel as faulty, but don't retransmit since the
>>> +		 * call was successful.
>>> +		 */
>>>    		++session->se_cb_seq_nr[cb->cb_held_slot];
>>>    		nfsd4_mark_cb_fault(cb->cb_clp);
>>>    		break;
>>
>> This old code abuses the meaning of ESERVERFAULT IMO. NFS4ERR_BADXDR is
>> a better choice. But why call mark_cb_fault in this case?
>>
>> Maybe split this clean-up into a separate patch.
>>
>>
> 
> I'm only altering comments in this patch. Do you really want separate
> patches for the different comments?
> 


-- 
Chuck Lever

