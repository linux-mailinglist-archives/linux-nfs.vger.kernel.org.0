Return-Path: <linux-nfs+bounces-19064-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6DmLEQF/mGlMJQMAu9opvQ
	(envelope-from <linux-nfs+bounces-19064-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Feb 2026 16:34:25 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B84A9168EB5
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Feb 2026 16:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE322303B7F9
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Feb 2026 15:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89AB1DFF7;
	Fri, 20 Feb 2026 15:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RM2jwtoi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="odqp+Zdu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6943F30AAB3
	for <linux-nfs@vger.kernel.org>; Fri, 20 Feb 2026 15:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771601627; cv=fail; b=rTb94w3/djVif+LcyQWoCzbw+Df4LbF0ZPDIMAbrUfdqw7MD1ZUPbKPXCQ8IJSh0somOItqM1N+WWLkzBCtFggIQYb8XOkjX919A93yH8wlhglq6TDnYm5JqUUPzpXc4yEye8nKLtcRjM81oXOcKDNqm2wkLRsWH4DzMqvi+qCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771601627; c=relaxed/simple;
	bh=XYGmIJtY5RnplulkJgblMD1VeULSM8M1B+NYuoRFJho=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VWT6MvgPWARVHi/QHr3Pp4+x0IDraYaGVMsBx58uPYwdczG2If1XUlF1GyFo5A/0SmV7OkUPkVxEWZ/Rdhfh62WpkzMZAwcxonv/LUOsIbGuoHsvzlqqXQSVwPth1iQbGF9tWPYFl+YK1uINKYnxKhL7dJzCWX96fLDDFVhzeG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RM2jwtoi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=odqp+Zdu; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61KDsJem1378433;
	Fri, 20 Feb 2026 15:33:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=5Odau9GMRKrbPBzxjnSqXCbTEmNCScef8TETVxckVPY=; b=
	RM2jwtoieNMmlcS8HX+O2FT9qdzlWJR9hdkhM3+9pRYboUww4z1LaFkROMWxQifG
	+f7KHpMqN3WWNzddqmoVWu4qssg3O53P74TbQ704+6eLvHCXt1Dbjz43rWzd+5se
	PpxAllgvuQJya4/PmQQ+oj2uHPy55rVj8uW5VP8cCE4zmlV1AnB2O96s1TAAkM4y
	6udTXuykjOmU7PPlDYFMGXeBM8lG88cVy/i6Mwk6dcqKFGEiqK64GEm9jHul0tuV
	fCG849vHru1WogB1fFC2AabmeJf3YStTAC/4lg/rei5NBNYWC35qmlNGT3n4DAfp
	PQSirZQuMcDqz1omdXWcnw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4caj0wsguc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Feb 2026 15:33:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61KDRsAW010027;
	Fri, 20 Feb 2026 15:33:42 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012021.outbound.protection.outlook.com [52.101.43.21])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ccb2cwpue-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Feb 2026 15:33:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sU2u+VqkXRE6QrlfL6ENNEvgb2J/w5Dwmn0+a7LZEz0/PunAM7z5I1F9AXb+kJGe8CV1TsVEBfM/ttG6tQIeH++ddnCbxiA0E5ziWxHiUUza4HSFwppDF5z3PRyhMjtEA0PkCg0eG8m3uKjeXiD+BzQAxVCCEEyzzZgs7xX5wchA7ohP6cRDCtMJSwGUsckl1fkFdEEEZvzLzA6R/dmcfHHFFiOaqu/rtOnRw3DkXtvb55BQ0/89gQ9y8pPcZyNFY2QvWlYJfZYOK+BDAyKfS9GDcHMXFI+IQ661l6plN7x8zdeLrBFC5AnkfGgYIZz8WMYRqxdFFcvKXGYKh3g25w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Odau9GMRKrbPBzxjnSqXCbTEmNCScef8TETVxckVPY=;
 b=N92hfchxJeY+XZFRUj04gs5PTNVgfcCBZp+hKxYmwM3SRhbLIKYl/CRIk0+e2VZDeUNOIl3nO2NKJaX9pQICu+IdxWjkYtNT7m7elvtGyy5WtGvlfQ5MdgcD3+Y72mwbzj5iGrNb1L9ClWY2VzGPSVRfAy05cyxaexbmZLXDGbhRYIj9W3EtlMMaWMOQw2E2zOo120WKbe/qF8GbYGRvat/HNla/ajRpmyxb9RwW3HLOpYPnXRgeTg3aHwwANF+zsWgPP9Pu9yCp6O81u1qhFSMvsDp/S8eZTq+UdTnqOhpdLLAY26sgM0Emcnscx1roz5i8x89ijq4PbH9xzY+FaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Odau9GMRKrbPBzxjnSqXCbTEmNCScef8TETVxckVPY=;
 b=odqp+ZduNDfet25B+PBW36jeIFR66hR+oyRIPp2SjgN1opO/3CLpAFPHfit+NiSFssVQ6/kxTFbGsNmI7gn5N3B2zLLNZhZFy5cXpKQ9buq84QjXQFG6RAdQvTT+nY/Otq621tyYMmhbyVVUAb4OW38dOQ756o8bl/1Fll+O1qU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA3PR10MB8297.namprd10.prod.outlook.com (2603:10b6:208:575::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Fri, 20 Feb
 2026 15:33:38 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4083:91ab:47a4:f244]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4083:91ab:47a4:f244%4]) with mapi id 15.20.9632.017; Fri, 20 Feb 2026
 15:33:38 +0000
Message-ID: <3bc90d32-cc8f-468a-9cb5-968865dd6768@oracle.com>
Date: Fri, 20 Feb 2026 10:33:36 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/11] NFS/NFSD: nfs4_acl passthru for NFSv4 reexport
To: Trond Myklebust <trondmy@kernel.org>, Mike Snitzer <snitzer@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Anna Schumaker <anna.schumaker@oracle.com>
Cc: linux-nfs@vger.kernel.org
References: <20260219221352.40554-1-snitzer@kernel.org>
 <098b9502-8868-47c9-b164-be80bb11ae74@oracle.com>
 <4d1a2b195f0d2ece9d0db5524e69462d71d3b626.camel@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <4d1a2b195f0d2ece9d0db5524e69462d71d3b626.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0321.namprd03.prod.outlook.com
 (2603:10b6:610:118::17) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA3PR10MB8297:EE_
X-MS-Office365-Filtering-Correlation-Id: e8a9308c-3f24-4e5d-f035-08de70956ad3
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?dlFSZnVjZEt2Tkh5M09BZ0NKVWdmZkduZ2V6Ri9Xa05FRlN3NnRSVnBNYS9w?=
 =?utf-8?B?bHhRdnFlS3kzVFVvOUZMR2M5OGEzNTZUOEJpMVBtYjN0bzNjVHBDeGUrVFNS?=
 =?utf-8?B?VTA1c2JNbDBrcEd0TWt6OGZjcFRNUFY3RnZ6UFJZU01SeFczSDBiTm5RQVVm?=
 =?utf-8?B?eEUyN3FoNExHbTVqMCtlemxUWitsSVRMWWJoQ2w0cmh4RmVkb3M4NGV3TU5F?=
 =?utf-8?B?TlNremRmeWp2anNQQUsybi9HYVRnaDgzWmxFR28zdTd2SlJ5dUk0eFQ1cUV2?=
 =?utf-8?B?a0x3OXgxOTNGbXRHWlhVbjRBVDFoSGoyNzN1YjJGdWJaNXpaNDJ4VGVETDBH?=
 =?utf-8?B?VVIwcW9BY1ZIVjduUTdPdW9LbWxVcGhrZEFsZkZDV0hqSW9HZjVhamtwUEVW?=
 =?utf-8?B?WHdmZGkxRzFNTTBvOStDQjVNU1FGckgwME5IWURhLzNzTEJBVEFsMGVCWk1q?=
 =?utf-8?B?bWN3azVzZ0tPNGNwR0tLQWU5N2lodWJ6SDBBTnlsNmRNY3NnMVMrV3Rybkl4?=
 =?utf-8?B?N2w2M3pmUHdHREVKQ3BRRGlvUjIrK0dPVmN5eU9zMjVSUzdVTHl1alNsdUtY?=
 =?utf-8?B?SndKNnVYaTBBVER6dFk0a0ZjYjFwb3dtdW01QmlhTUpkdVF1ell5eXdlMk9Q?=
 =?utf-8?B?Q1dOSjBBaWVnTlB6R1ZJa2p4eHR5MUdvTmV2Y0ZKQ0VWZ1lYQzgxWW9FNm01?=
 =?utf-8?B?VVFSTXNUWXFXcXVuSWp6SWhpQ295SVZ1MDJTVE1sK2J2Q2crMEI4QjdYZmNE?=
 =?utf-8?B?SThOaFZ6c3JBbHFuRFJobEhKKzNsdGw3VFUxb2ZkdUViZDh3QnV4ZkRNQzZI?=
 =?utf-8?B?NDRodVRUbkFNOGRxdTNUdHIzL1drYXc5Ylh6QjZmNkFFak5NeGJBdmpHelg2?=
 =?utf-8?B?TVBNM1cvN242SXR3UTRSTVBxMk9nV3M1eC9Za09QRmdIOFNWY1pxZjU3RlNF?=
 =?utf-8?B?ckMwSmErejdvVkZIVG8xQWZTeTFDbzVNalU1QWswWGwyUDFrWkpkVHpVZVc2?=
 =?utf-8?B?cFhlUzJWWHY5M1ZURHJjTS9sdFNuZ29PRXdNRnRSOXA3UncwSjk1QVNVejhz?=
 =?utf-8?B?b0dBZ0lRb0UydWdVcklHT2RmVUV1TktYMUpzL3dHbklZL3NnQW1CcWFSRG14?=
 =?utf-8?B?aTFyWXB2bGE4d3plSCtNMVhFRzlKK0thQ25vTUdRUVNrVmN5cUI1YXJuNUQ5?=
 =?utf-8?B?ZlY5ZnI4MjVyNHpjYnZIL2FoWGZJKzRmY1BCZmpZTmlOanF2QTlnc1lidFBj?=
 =?utf-8?B?M0QyQ01YTUkzQ3FZeW9Fa2VzQm9taTlDTkdkTkJRdi9VTmJGeENPSUQyWmVy?=
 =?utf-8?B?L3AzV3AyLzRZM1JUVnM0MjhUOCtoT2FUbjJqYVRLVUdtWU1aYWxjMjFOeGtQ?=
 =?utf-8?B?UG5maWRuMGh1VEJhTnU0bE4vdmJSRnZKU3hYcjZoSGI5cm9iVG1SMFdlaVZ1?=
 =?utf-8?B?YUNuRUdHekZxejJydSswdWNKMXRuNE43bHVIWHM0UXJiV2syVlloQy96RWVB?=
 =?utf-8?B?UTFBYXFlK3MvQURHK3VmcDR3dkhqaHhVK1VkSzFIcjZNMmhHVjJNemREL3BP?=
 =?utf-8?B?Rm1RT2Q2Y3ZmL2JaMVQ3OWhPMW1XaFFFcUV5cHRFUGl6cUUwc3hTbGlUYll5?=
 =?utf-8?B?NjhTcEN5cWVMUS9SUU1UYVN0OU1nNWtaVWY5MzFaQm03YU1VNGpVT2RmTnBW?=
 =?utf-8?B?ZUVFTHhVYWU2L1pVZ0dhZ0VsV3ZWc0NDRUpWWlllbm0rbGV4bXlhc2VYZkl1?=
 =?utf-8?B?RENld2wxaW1iODlJUWFnVTBpdDFiOXBKeE9YeE5nbkw1SUt4OG4zUEV3ZkVO?=
 =?utf-8?B?dGVXSDFLRXl0bjlzc2VNNU9tVERwcUt1VVlkWFpacGFCazRrNkdyaEphZGFW?=
 =?utf-8?B?MXFNT3VMRjNsd1NMUlU2YXpCS2dER2RFbW9MU1dNQURZQncvZmRQMStZYkta?=
 =?utf-8?B?QlVyNlNleDJ6T3NKM3VUaHV3Z3lvZ0pqZ3laMHB3Zk90VHd5dDJuOHdYU3N5?=
 =?utf-8?B?TTd6ZDE4NzNMeldXTVFBTkhITkNYdFppMFJVcVVJdmtPTXc3RVJmZTcyclBY?=
 =?utf-8?B?eFRTVHlDRGhwZjlqWDNJMVVKeURtamovMythNGk3L2FpUjlaUkdXNFFJRXdP?=
 =?utf-8?Q?Qzxk=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?cGJSVUFzb3NGTVpDME5sZUsxL2FiMmx1TGExZ0liZlVHRHNxTmVyTDdLK3V0?=
 =?utf-8?B?WmJVMGlubjRaU0FaeDZYL0xPdUJwVTRsSVo0U3k5SE0vOWpPU091eVhnbFhi?=
 =?utf-8?B?ZkpadFhld09sVDNEaDR6ak0xZlJNQjBxYWNibGtRSkhOdENFQUF1bTZIM0Ju?=
 =?utf-8?B?TXNsWThVVjYvYUVqSkIrdXlXRlYrQW1xWGNERzNOQ25UVVc0M21vNkk1SXRw?=
 =?utf-8?B?OHEvZ2tkTTU0OXBzbE5kL0IvZlJyOXFiazUwSTlodEc5d2JaTGpiNVVUS3pK?=
 =?utf-8?B?dEhyZlJHb1VGL2tlalpvdDVtekNGcGgxbVJQYVFZaEV1bE5TVkVreldnWVhn?=
 =?utf-8?B?MnhUVVphblpzaWtESjBlbEVSUS9MTmFHK3lHOWN2ek4xNHBPY1JDMkR3Z3FG?=
 =?utf-8?B?a1djSm1TdU8wdXg1Tk1acXlnS3JsRXhjMVMvcGRBT05mWWovWVdDaVdjU1E3?=
 =?utf-8?B?V2t0MmZyRXIrUmdzdm15dWl4Q3ByZDYvVmQ3QnlQUDVROURhcjVGSUVWTURM?=
 =?utf-8?B?bXVaMWdQbURTYkRCWG9tZkdwNHRsQVI0aFdEWjJYU2ZCWWRLajNxV2djbWEv?=
 =?utf-8?B?c0lyVkJmdndySkRubnNmVDUzczNWZGV4QmZGN2tWaVBiaElURWk5TDk2NDYw?=
 =?utf-8?B?VHhuUElKNk8wRFpScjRGTWFuNS92M2d3T1F3bmdlYUdJQm5lR3A1eXZoV0pS?=
 =?utf-8?B?eWQzS3BhUEZ1bXl1emVnYTl0NGlOOG9ZTVVNcXovZzdCRGszZmVXbUkrNEdF?=
 =?utf-8?B?alRicUcyd0poaWV5bjkrS2pGcmJETDlKcEJWY2NHRDZQNlpXYlFoYktWQXhV?=
 =?utf-8?B?S2szUmhLMGVlWDJmNFVkT3MzdW94N2Rmcm1NMkhSS0dzTm05OHJGeW0zS3Zp?=
 =?utf-8?B?cnJYU0JhV2o3d1pubFZJN2duRjlsZjZTRzJuVTM2eDd3ZHRjLzRYZld4VWo4?=
 =?utf-8?B?bmd6RmhRU3dOQWhEaEdKSlhYNDJLRWNKM3JTdldPUXljQi95dW1VM3pmL3hw?=
 =?utf-8?B?SEZiK1FzYXRINDZpZ2R1RzNaZWdyd0w5VWZUb2gxN2ZVd1VsSkhkR2hHVTdE?=
 =?utf-8?B?OHhCd1FabkhxZ2JrZy9uYzk4Vy9iM1dmNURwZjhQc3dWWVNaT1VPT2NFdWh5?=
 =?utf-8?B?U092QStKUVIrRHozc1V0amI3N0I1N1NjR3l5UWxRdlRmblp1NGpneFRuUTRw?=
 =?utf-8?B?ZEU1eXNXY1V2TVlSSWJ4S3dSakVsRDdzVkc1RHljNzBicWZlOUk3QXVPdGxM?=
 =?utf-8?B?UkZocEU3QlNSaXYvSkNaSEhFRVFkMFRxdXdvNExwQ3k1NXU2MTExclQ5dFhr?=
 =?utf-8?B?TUY3UGtNWGI3NlppbnlLdGkyQTZvVmEzMXJ5Q2dUbEhBNll5Q1hrcEYzUVFY?=
 =?utf-8?B?dGxuS29oS3ZHUFlNS3Rhb0Z3d2lQNkR5TW9xU3BZNFBvby9mYytZUE9sUzlk?=
 =?utf-8?B?R3lUWUIwMXpFUHIvK1NqVDVWcTRWVGNjdEhvTEd6VC9Vakc1dnNuemlvaHh1?=
 =?utf-8?B?NlQwQjhKOGZDT2d6OHRUeEhHMHhNNWdJY3lMOXlhNjBhL2plQTUyaC9QM0o3?=
 =?utf-8?B?enE2UEhUSzJHV2NkcTFialRWYjdKNDNNc1MveE8yQlhpKzZKVmhTK3JrakVP?=
 =?utf-8?B?Tk1LbzBDTEYweTJzNm9NWldRYzZFVTc4R2U5MDZRRTkwK2JGb3ZiYmpOUG1s?=
 =?utf-8?B?M2hpancvMGRRM1IvVzNEKzMvY3h1bkJIbWt3akJrNEg2TmcvOEN1M2F0aXUx?=
 =?utf-8?B?aEE4QUIxaWJtNVdmRXZzQ1QxdjVNMkpJTDVMc0NTeEl5N2JLNEFzM09oUFRF?=
 =?utf-8?B?bzVWRzAzSWNpR3FSQVF2V1VLYkpGaC8vbFoxUVlrNXB1cmc5eDdGUGUwbkhM?=
 =?utf-8?B?Z3YzbHArTjIwTlQwczB5WnNMSHFCMExzdDFDUjlPOEhTNndmT24yTXVwU3V4?=
 =?utf-8?B?NEo5NXZXSEZYRDUrb2o3a011OHlqQXpvcjVrNjN4OWIyRURxNlcycytUR2t6?=
 =?utf-8?B?SHFZWnZlYmIvTXlRcysvSmRVa1VndkxiUjgvRndaZGVjbWU4TU1teUJ2a2NT?=
 =?utf-8?B?ZUt0VnhadkVhejlzRFBTaHhZOTVpWW5lTkRhdllzMkZwMk5OYnl5UHlySXBL?=
 =?utf-8?B?eHJuN2hDUUdGbUwrSW01UWxYczF0dEI4RUZmVkNNMG93Zm50K20yNnhiblVT?=
 =?utf-8?B?NzY0SW5CL2k4UHlOSkI4MERiWXI4R2dGWW5qSFpCbDRYSEZ3OG5paEVnMjUy?=
 =?utf-8?B?RldhVXJmTWxXSGVEOFNabnBpeUQ2eFN0bmpMQ3VmNkNrNElJVzdBNG1GZFUz?=
 =?utf-8?B?dmZ0ZUNnNjRRWExtOUo5N0pCLyttdTdWZm51ekRKUExqZmNNTURtUT09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FKoMQBQNFSp6YK0j+w4A9VQgon/w3h4cb4gDfcrUVNWT4MxBeALjaiQ1mn34rM5qZFq11J/ZEbPdZiR24svR/jSp4vITasecC9bddwXSHmxnQZOCLQFBrqR8FRFBGEXDIOjNDU8ZLmPAX2zXNJqUucUhmLHPh05aLNzR1Xe55tsibSxvvLawSI1fjOo8QWifuzKjnBnbYKijR+DBDDadgntvC2NLObLo0adrg0bOZcgMbV8flsri2DEb7qN/l1gLxGnsCL2wgHMTDqIbBGglCZqScC1FlHQMxfBY1yzE0vyJnOX1zIk2FgTcHxAYu6rS53WUaaSTEZ3CN1eczIi3QF5njWlZNrNcPYFoNrtnYUFv/bsL+nt2DYmn4fZvehHu0PbgC2T2gsxUZdhKqR5UoWQZbUlPlcxBGs+JjWXZ7Zb/xNZG9bmCsuZEQjCd8YVTA2W2oG9NNXg+yTHTaURNlqe7icGJNF+bXbo+/mz0PDHVuSE/PPta+IMTbGcIWVU3PPvFZI7jBqGMIHACxx1tKOT51MbfFyzwtpLSYuV+G/xoab3E1APoq/nTs02slT6RV/YlpuFMvCxJa7TlA2Z+9kWbGkh//Tg1K77aNCkhWGc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8a9308c-3f24-4e5d-f035-08de70956ad3
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 15:33:37.9267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N/CD/PO1hSm94DSkWmZTYh9cv3d9wevvvczYip8vHYCLUTpt1fgdWZ52Z+lhpdyPP9vI5/FcVgRDba9oMY0f6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8297
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-20_02,2026-02-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602200134
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIwMDEzNiBTYWx0ZWRfX3sXEr/bt6lb/
 6TKyQ50ewFNHX/RSGc9nyNa0k42Tl9SapoHETTEnuPDiRC5tkZLEpIkOyu1u517CZIV7fbpBdrd
 Wmm3Ay5ny8nOywIxGuXOqA5NpiWCMUPj2zTfaQHIBnq4JNnhetqIEjMs9+kI1xoT4jevWKSIgsT
 syiXw17QmQYQeLrZpPd7iBkuIkB3VESbPUoF8jELMcbMxplGgXEKBNL7bSrgyfPG1QurBlzaq7q
 GbzJGsRnUwtA2onenddwGGUbuhKStlc022foQgo1i+Ux2pxFg3fsYius4oWRL6gEpL3ia1uuDq/
 snCTFdsNS7Lhcfb2eLztXfQtLdLrjjyEQX0V3PzhAPuAeNc5zKU6jQOWu+axnw3y7XXPRe2z42A
 cnTCkt6LWspRP+WrJ1njJbOsXiO/f6o64JMr4KznpFL2nCVjeKK9VGdtHEcXfXk4cXKSQW53Isn
 Z1KbBnxz03cnPxq+F8yZRwMTFbe0cu6cgRrqwnQg=
X-Authority-Analysis: v=2.4 cv=ZMfaWH7b c=1 sm=1 tr=0 ts=69987ed7 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=FQ1T8Rf1zVG1tOVM_F4A:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13810
X-Proofpoint-ORIG-GUID: abBthGktqBh3BA7vVMR14xjKsC4At8Gd
X-Proofpoint-GUID: abBthGktqBh3BA7vVMR14xjKsC4At8Gd
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19064-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.onmicrosoft.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[chuck.lever@oracle.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: B84A9168EB5
X-Rspamd-Action: no action

On 2/19/26 6:57 PM, Trond Myklebust wrote:
> On Thu, 2026-02-19 at 17:21 -0500, Chuck Lever wrote:
>>
>> 2. Do you have a plan for similar passthru support for the NFSv4.2
>> POSIX
>> draft ACL extension?
>>
> 
> Why would we need that?
> 
> The current need for a passthrough mechanism is being driven by the
> fact that knfsd unconditionally imposes it's own lossy mapping onto the
> NFSv4 ACLs.

The opening paragraph of the cover letter states:

>> This patchset aims to enable NFS v4.1 ACLs to be fully supported from
>> an NFS v4.1 client to an NFSD v4.1 export that reexports NFS v4.2
>> filesystem which has full support for NFS v4.1 ACLs (DACL and SACL).

It wasn't clear to me on first read that "fully supported" was doing
some heavy lifting. So what you are really looking for is a mechanism
that bypasses NFSD's NFSv4 ACL <-> local POSIX ACL rewriting mechanism
only for NFS re-exports. Fair enough!


-- 
Chuck Lever

