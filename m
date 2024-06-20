Return-Path: <linux-nfs+bounces-4155-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD2091092A
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 16:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0ADC01F2301A
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 14:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4A21AE086;
	Thu, 20 Jun 2024 14:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KhcMWM57";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aKTcydir"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343101ACE89
	for <linux-nfs@vger.kernel.org>; Thu, 20 Jun 2024 14:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718895556; cv=fail; b=os25au52jCUsZI2dmCwuJdcz6rqaT2ycX0xckNT44LlL0Geihb7W96PTzs7vX9Xlk1Ihc6taWVS/j253E+UUVhoSZNcCdim7oFSltdGX9YXP8yDb4u7QRPqLS3+l3sUeI0Ki/VbkQ1PH5PCW1hfxz6lbwNr4K2yZEL+VSXtlYm4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718895556; c=relaxed/simple;
	bh=WZfq8CI9hzaWgwo2C7pPYl1s2PzWOhtUfF58uqPhYlk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fY+K7FYmfEd4Hr6UT7zigo7r3IhVVcIBOcz9mUEKt9azUO0pGOBhvG2hslU8YYfB6Qonfq/zlq6z81PHXfY7o/CEQA1tcA2kAbwCEjCXFegqMEE/ADW4rYzVw9NFmLtPDO0KSVxgasqKJI3w8+x4AzVUcBkb2jIkHfhdGR8WJ3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KhcMWM57; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aKTcydir; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45KEFXdS001827;
	Thu, 20 Jun 2024 14:59:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=tI4skJ19FK5Rno8
	Tnb4r/tMPLRb5WjDk9syfvikk/KE=; b=KhcMWM57vp/3hiXJ7W0TJqyPkfTPj2l
	7xC3ueAwwPtybb1rxG+hJLkie5EKFOJrT3D/89nznNerK02sWlWBT7bCW2RPnd/E
	VMT5j0ouhVsuQ1i+4ZzF7IcnbzAi/ICTSU3eLZRQX7kqyuWe1GeQc15QH/OtgHrl
	2HVi8a7a3D07rmbLjZU5Z4hJu1w6nz08aElv9Ii3SPXM2yAdrHeuTALtxNd0AXav
	y9XfDcH016EHR4aNQaXAP19vDV91ajYB5hognJ/kY191abBZ+uecaQnJPvI48LY1
	BBnv7WoCdhSN1ukqn2taMyjgKVPof0/82GaU8TP4uy6S/LyCy6turTw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yuj9r3ew6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Jun 2024 14:59:09 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45KEYxKi031924;
	Thu, 20 Jun 2024 14:59:08 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ys1dakgn9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Jun 2024 14:59:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rr1XN/PAEvYf2UwG6dLMYP+KKN8CWjADWRBz8U9NoqSaRwZ8buyEbk+6RBDoAKpxvk36V4R0nN6EFy+llvJfg6Xlvys00zYk25BrrxDpWNRUCrNCE5RAxfBwK//NHkGnDOV/DgEEDLz7n9Cy6mzokS0JTyrTZQmxiA1vfW5bJuBTQkcs2i8RKAqr/XlGEezCv+O6h2YHnDN4R+NfR9fk6WFiV2e+5c6tU4asepv7MoBYHidSpx4SpP0Qs8d0qK7ySg0Tjl1ZccfURlCDrK3kXTfZtKuSgY+SgWLTgZEvquy5ppbcrTUpv4WeLQKrc/rvMlluHOU7eMV1afCkFQgC6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tI4skJ19FK5Rno8Tnb4r/tMPLRb5WjDk9syfvikk/KE=;
 b=i5GdbuuNFBPbT24YEvEIo6VvD8U4lUqAU+0nqUOCOhy0DA3AHoyWjg9ovRbvrRBbKu5xQhFXJSr5U7DM6uCcHOwpMkbJdznrozGBMUHQt8cDFkvlrBsquxG6w6J5f+LiaXn0xhlkZTy07tA79vTNVbIMbf1weotPdNveSdk6GqGqr+M1Ri3FiqGVH26nyeCgy1hqpSdHU7eEJJqnwIQIFUNVju4SfVlsqBtN83jskVe/SZw/ustWQ64+kMluKUneJA7CP8MDtDdg/h6Mr64DHmNKcYckqbq7RtBiCYtyXkM5yUUXOqAJemFqgEBVleLIxpELTY6zACbG6aPCZKinUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tI4skJ19FK5Rno8Tnb4r/tMPLRb5WjDk9syfvikk/KE=;
 b=aKTcydirq8QA/GtUA5Jy8IBDQUWWPBizkXeP+7D0HWCd5ZAQsXJb0SnA9hEZHjn2QGSXB15+MYfzgDuebOhV6lG6zpVCRpe1TAaKP2GIxB7SXMocO8e9bySwSOjUXcgDaVyXW1cXQ9I++6ZvK8aL1+ES+Z6DOHYkqGeKzvPEi78=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB6224.namprd10.prod.outlook.com (2603:10b6:8:d2::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.32; Thu, 20 Jun 2024 14:59:06 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7698.020; Thu, 20 Jun 2024
 14:59:06 +0000
Date: Thu, 20 Jun 2024 10:59:02 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Christoph Hellwig <hch@lst.de>
Cc: cel@kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [RFC PATCH 2/4] nfs/blocklayout: Report only when /no/ device is
 found
Message-ID: <ZnRDtkbqgObfm5WP@tissot.1015granger.net>
References: <20240619173929.177818-6-cel@kernel.org>
 <20240619173929.177818-8-cel@kernel.org>
 <20240620043605.GA19613@lst.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620043605.GA19613@lst.de>
X-ClientProxiedBy: CH0PR07CA0007.namprd07.prod.outlook.com
 (2603:10b6:610:32::12) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS0PR10MB6224:EE_
X-MS-Office365-Filtering-Correlation-Id: aa4c69bf-169f-472d-9bb4-08dc913987eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?tOPJRKnP5sXgwC3usV5qQGlhhp+6p0MXXf5cS1vK8o/3HDXPcbxQ6gcVzvE7?=
 =?us-ascii?Q?iwKOtKdmZB3GPSaZOekq5yFLVpi5UoDZmDkJ95uZAMN7/1Pq6iMxpRlPSBol?=
 =?us-ascii?Q?vQHxuilraicPlbhsE6tZjBtCs1j24tUtcTsxvWW+TXU6fWsFydRrNpGtB2ui?=
 =?us-ascii?Q?zXwY8oRrnwKf8yWpT4NQ2UFeIz4P3W6XnpKH+Nyfp72yHig15fpGeh3ccvNw?=
 =?us-ascii?Q?cmlFd2xiAyq/IVNonsG8MpZoeGlSJc1ZXtZczApPvYovYEV4PrheC8FaYCP0?=
 =?us-ascii?Q?JkTdxPQNQ2ul2gssvriScQAQoOOOe/853w0bg6es1xMlSncOq1X6xrMSVrH1?=
 =?us-ascii?Q?4qhDjhReEaYJHZ7FLrBeCOuzZDWTZts2pE0nnIO+ztIyWQ6xgpmewDy4frPX?=
 =?us-ascii?Q?t28e5qjFga81uRmQ59i9aC9uRrEoKR4AtvAGQNWz7CWfbS4ZNwsFTFVdnjbP?=
 =?us-ascii?Q?hjyORxLUxn/xLWISW0uqk0dLcsMS+KZxIFaCr0DqD6g87xtqgzoMlm9JeviY?=
 =?us-ascii?Q?iwihx4SoKTYoC7r/CTUVeGuiQTxKpIMbiuX6HeRAdywzpO3RMNZv6F3TE9lV?=
 =?us-ascii?Q?AO14YmbFtwyz93U/NztvR6PO+vLjiInMoxYLref0KRULuOMH43G94T0W5rAd?=
 =?us-ascii?Q?9GdGrL3BtYwiEpR5BJS5lj4ByZzPxV04Ea068eFMMAVpsBN7e03b74jDnBIb?=
 =?us-ascii?Q?vZ2ioBdbQhVl6yKuJWWXsXlZfbcQTsGbvRBnL8OE7PFgIAztUtp4UQFS8nue?=
 =?us-ascii?Q?IHXfRmDfWWZ6djOfkHsiKfPfik4BfgFZkVIz5lPx5+r0/aUP361UecGMXnhU?=
 =?us-ascii?Q?zWoFoSIUCPOpez2sddiCNxqY7Nhfskxigd7VQhOnd0BQh123V8+mIyGdf9xf?=
 =?us-ascii?Q?bAYl9paF956WLx/FkfYj6BudXePVDT/1hl4eK2Gwx7/BNpCjT9ylS83eGJcw?=
 =?us-ascii?Q?vy9S9k8Cy4lH/gWVuN1MknoMGn45wWJG/IPMtk8EbiPP7lt2m3qhghZFvSgF?=
 =?us-ascii?Q?ePJBTJ1q4lhrfpX+a9zve3sW5mnKA3+XfAxw2w6cAmLosHEQorHw0kEkUCj/?=
 =?us-ascii?Q?WcprLT0qOp2jGFiybWLUmqeobupYG1oju3SX7D1f9PppobqbNejRIQLGaNC3?=
 =?us-ascii?Q?uRqkKgsZoh6BvVoxwIGOwImMLHhhzvCJzf4l+wQdzV2CaHiBrydh0JGcukS4?=
 =?us-ascii?Q?CtkOtLB4pYeodWSH3DGijA6XsVGSBzXHs+VLf6vZ1csH76fuCSaEgxRDzEwX?=
 =?us-ascii?Q?ScUcrZ2J5vSjfpkJHpA9SQ7Ttd3e5FJD2Lg4mT5r0CF1ir7spoEOI3PqWW+q?=
 =?us-ascii?Q?5Sg=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?3AYonAmLeTr+/YxJroGsRbbgUD8g46lRHz2Yg+ZJQN9MMgFq3/YhhcYTYqtr?=
 =?us-ascii?Q?gmRm48qfeqARUt+HJWTaMM1aN5xTCVUkUPG6K2X0U2b1tkjeFD3ye4upSRpK?=
 =?us-ascii?Q?mqrZ2dlgr57vwAG0cUmvoFcriuHAIyWHTEzvP/ASd0wEGHpg8Oddaisr0Vtr?=
 =?us-ascii?Q?6jCiwWzGqmKVZS4+2lI6XByoc5GQ9/hYKzUtiaHKDHdf4f7M9/OWGsEip/3d?=
 =?us-ascii?Q?IKhD9og22TQy6kCTZ+frd2vyE1SmKloQjybga2WQK5zY3v98M6w6o18oJh1u?=
 =?us-ascii?Q?2hrZVHVBEyB1UwyEkfpcs9rS+JZRf+CNOzf/1269lxnsZTHZEuUryp5HP19W?=
 =?us-ascii?Q?eyC9k3A/GSUhno+Jv/v/TEgC0zowfr5PLh031ByNks9SAglZJ02WdeoFRWHj?=
 =?us-ascii?Q?Wq3pHrHlPpM8eduZcc21kkkoedTnn90YQt1OC4FconJSEn9B3fhq+yICS26Q?=
 =?us-ascii?Q?DD+7e/+4EyLzh5synTZrB9TfXR8fxY2Z2Uzwa/nicRZ0JSAg3ha0HiWNUMSd?=
 =?us-ascii?Q?1RGYJ3Qy0WUwF85b0Gs9VT7sKJnsmuBFXBS6ollE93ZxH/M8py6c/y98QSZd?=
 =?us-ascii?Q?8K9j2jNAKdI5e6pWMRu8LoT4+/RH7Fwn4NHTDMwkk1B1CiV1YeDNYXnIE/Xe?=
 =?us-ascii?Q?IMIhMqrJ38AOSoQ2KgCgHTaq0YZVrl++P+wnAhPc9l+7Ogz7nFXyDJK389Rm?=
 =?us-ascii?Q?rHsm7LzYatV+fG1zJXQzdsiFGszWx5/20rCRz7y1mfX5tSKhPyKeG4VSUYLR?=
 =?us-ascii?Q?v5/bhht3gDjbXYmtKJtys5lxc6pf9OOeCV6RZm4REu6E9zNMFGfFq8RnjuFE?=
 =?us-ascii?Q?GYWlqqcHvJGTCPIwsLxO5+UrvI4MBe9YgAVmTeb8gZZAeu2wl7oERatdJ55B?=
 =?us-ascii?Q?cONlXr/+LxxY4uhAgMDELgYdKBfR/twwXzleFYrkZAZ/IRU6dr+LtBNcxdWm?=
 =?us-ascii?Q?rs36DPaLxabeLxKQOPXqECWCI1asZ2/wC4IB9st/y9QhcWTdMJKl2hQnhWht?=
 =?us-ascii?Q?31RiXKjSecmmBKXiHmET/1jSAf+86scBYh1RwqZ1UgKv1nqz2cKU6Go4WKLk?=
 =?us-ascii?Q?6E0D4piodBEqEqxEZSNsCUHHT3j1TYKTlEx04SWD4eOcC1NJxtxi8ZIbW+ye?=
 =?us-ascii?Q?YtDC2l2iQfqvFF4R4qrEwq9qWX5VR4lrmqX7J+y3T25IW9077cqNtnzLlghy?=
 =?us-ascii?Q?1+tq1Pwt+yZmZqMVARisfn8rVFou8rm2+xv5kczS4xaDKbIq3UDLfB6yMI/7?=
 =?us-ascii?Q?JbzU891MzFNh3tUFGaRpvjcZkwL1C5ybhcbSgiDb2tcuFS5zgl37piarZmyq?=
 =?us-ascii?Q?QWQZtrFu8GapfJXWbxKUF1rgXvymKNouk9QSWo5LZwrXd/YL1D+zfy5gRUxc?=
 =?us-ascii?Q?rM1zqT5B5K/3j4/pXgPylVogsxgM+N4tvrbqAMJ4Q01lNGcrWNIdvTKcfXvD?=
 =?us-ascii?Q?8NeGJTRN0okrd35TbmdYuaie35bYDuRIoTr5JTHoWO/CGjTGBOJU0baBQShC?=
 =?us-ascii?Q?DKIKVKL/jelnSpNzDyb0+Nf5P3ZFCAhexFqnIF6lzTuiPZqkiRxa10+8rkIw?=
 =?us-ascii?Q?SUDHbSrMpA3uQjLbMyY+YA3PrvqMcuBYAvG8xgX4HjM7fAiMAONJS1lEAPmx?=
 =?us-ascii?Q?rw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	jFtqJYDSjp23LVIAzsmNX0MLmlqniWdMxgiWyLfzlG3tGKfoFEN09HJyX56WbJg0pblh1EWAyKeTcNHTneKYScvRfBvV4F5EhokS2ePoD/sdT7fhmf3BAnfZ7Ge2WVBpm+AAFp/3Luxqn3cSakgbxp/WJI5bqNs2JbjnVE8z1ZvmdNW/NGDxgKrYyZhV2+gtrBdKEMBTYK6WFT6E4SsWI14jGtJUsGy3KioN3nU6U33bE9xEeOkyaygtUOU+z2/rqHgDxDYwYGwIYuJQ5eZm2nHJ/D4P23onBFH2i0sPI9XObVspxUTP4iGcIfYHzwRL+b9BhnA4nM9V8PqS2ogACqSxMRD0fbYHEBGbQB1axzReMhqum2zQNm0FbNQAbszWouoxWrAcOxTMMsycjPJ+I23SRKXoR2dt3U8Aq9yYE54CC4D8zEkcHdBkG0vmzkygSBdJanBc+BG9TkO4K2TRJ1t0Gbgs2yR0XnM5YhAbyv+f6WVNKT9KTl7qT+C43O7qOWORGvYPUkGAAbmkwXwpyxwraB/Q6vVGHkh/GvZTM0K7ZgYXu4W3QZTOMg3ITwRjNMi44fvie6y9p0udTv1ecKXLPlZPFzwVCfuZxw8y+dQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa4c69bf-169f-472d-9bb4-08dc913987eb
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 14:59:06.0174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D8kzj3b9H506tGvnb0Gu7Z+zmEKdlJxZQkvKvRrKHuMCUY6iLBFLOPlLBDIOvxN6Im87wW0UqzNZsKjUg4URSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6224
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_07,2024-06-20_04,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxlogscore=611 mlxscore=0 phishscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406200107
X-Proofpoint-GUID: Bm1ROLUBfLeNMLccl9i89R6hJrpV6Ezz
X-Proofpoint-ORIG-GUID: Bm1ROLUBfLeNMLccl9i89R6hJrpV6Ezz

On Thu, Jun 20, 2024 at 06:36:05AM +0200, Christoph Hellwig wrote:
> On Wed, Jun 19, 2024 at 01:39:32PM -0400, cel@kernel.org wrote:
> >  	if (IS_ERR(bdev_file)) {
> > -		pr_warn("pNFS: failed to open device %s (%ld)\n",
> > +		dprintk("failed to open device %s (%ld)\n",
> >  			devname, PTR_ERR(bdev_file));
> 
> I'd just drop this one entirely.

Actually I'd like to keep this dprintk because it displays the whole
path to the device. That has diagnostic value, IMO.


-- 
Chuck Lever

