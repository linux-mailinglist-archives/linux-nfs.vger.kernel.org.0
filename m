Return-Path: <linux-nfs+bounces-3005-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD82A8B25B4
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Apr 2024 17:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD64AB29D27
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Apr 2024 15:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7B414C580;
	Thu, 25 Apr 2024 15:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ML1qn3CA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="G/1DaLkS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14DF14A096;
	Thu, 25 Apr 2024 15:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714060238; cv=fail; b=Di1z68sKIL8othF1CZwFaoZI1zuTR08KZbGbrVQ7wmvCVt7+hNipGVARc12BoVVqBItoQC5kta/RkLms1zXsL7+nA2bgzsjBZt+++Md7O74A8kAqjf2mJf/cvNGa/n0zlvUx4IHx1YuwzfR4DrFyy6xorFB2U/S0KYuBLIE86RI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714060238; c=relaxed/simple;
	bh=zysRazYhxFqgnU9GnDvIX5+ajxVM61rU1OOQpJ2LuV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CGo34def3R0YNJ5wDWhbS3m4teF0gtTWUecr7yoR7T5/6Wt2deOvNZWELfWNHLVvHKgJEF10NfQwkKp+hi5QcdAV/NcRn6SwIoD+xJlHANAw2t5EpUOHUDbC9Mk+ZAFBXbyGMSGEY8ZJnJgyxKOYn9F1ZMsbg0QE8Ov9xddFvQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ML1qn3CA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=G/1DaLkS; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43PFBe8V023691;
	Thu, 25 Apr 2024 15:50:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-11-20;
 bh=V2DbX6c/rjVcVZixJ7FLpvuW2b1XjlJeCnMYzfeDtC4=;
 b=ML1qn3CAXlpimkCw2Dn/qBQKE7TPo8cekV8uRGghw3eXd1ere6ZhZNOTAAW+gxb/kXhl
 4Rd9nm5bH2SgRIN3T8phaTAq6l7g4eycxukAFblK4Zp1H/8BM87U2dddzGuNiJJOuFDl
 NBdh+cESIr/7O2GX9FE5Ta2RowjSNfKRC4L0NgBLH4ENpqbClO7Jzdfs9P/bXTWOwFhm
 d2Kup70jspQEkWkE3K2qYIjYle5DYRf7RxeEeBhmdiUOtN9+gVrE6CGxnGfSjVTj77Hr
 dplHQxXD7cOyc0zAYg2rc30SyN9MPCMGSG4M0cPkqk/SbbS7Ge9t2ei17M4vfqnhZtOn hA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm5kbv2fx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Apr 2024 15:50:09 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43PFVxVc030945;
	Thu, 25 Apr 2024 15:50:08 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xm45ajyf9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Apr 2024 15:50:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l0x4zqYT+U38w8tABi3BqeFCZrB07+nBrRiTsSB0NLPdrcdmZJ1c/Do5MpqEXzAC8SEoqKw71BUbkho4d0AWo9Feg3Bvq9UdOYKd3XYmxyBeqRBiWGcmQ/ZepigFEeqxNTWnvYFgwwfo98s7JmXuT7iBxgg2P451LUrmtEJEKo3RjOsO9ZkKab4wZ2BetxsuNRYnRkql/moo87rnsqWz7aHbCJ4FRrDtSoe2h3OYldn6RTIgf3nOQkWN8Lc1A1zpt9eYRAPD9mlVxpByr2037s69WY4w2gDoZYi2/WzpCSAmxyljUBSDOY/PkjN404fwLwPldS8RzNcia16ofCOrBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V2DbX6c/rjVcVZixJ7FLpvuW2b1XjlJeCnMYzfeDtC4=;
 b=juIBcjysCVkOOTK3/1hSvhZtzPk5Vai4SkMRo8yvbZlZzpmuqRaP5kK9RqcrmesqJ9RiH+VCaj53r0l5FLoumsj/xRR429gwkWuYf6WQyQo8DsUUoawt9E5CZQ9TmY7zCq8Vwa/n/EKxwJAqdj13JmJV+9pPy7NfsJoJuwQXH/1Qcm4oC909Ew90opaLQaIK17Ntm1A4py4tEHL+cBG9RdU41YUheopLEPqTmjgN83z1tfOSFabu3pFRRnPuWT06nE1E8GBU6kqVSnZdekxgqHVd7GanwaFBx332cau4lpVP/wkb4pHoSDDiQZMl3SwNAgiSIcpKn6bw2UWRUDQMKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V2DbX6c/rjVcVZixJ7FLpvuW2b1XjlJeCnMYzfeDtC4=;
 b=G/1DaLkS7vT02H9Z0H6een71LnXHKG6HGBBGi4cPc1eMNV9Bogafl8Z8EKVviqUnitgxRUOPKQfJULj0iAz0alxrNJUVElGCuIbsv+UpI8D3tS7yFslFCtO6Xiyk17FOg6YkZCsWw6966ksQ1QHIkjTN4Y4Em+xkMqYjUNksqqI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB5582.namprd10.prod.outlook.com (2603:10b6:a03:3db::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.24; Thu, 25 Apr
 2024 15:50:05 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7519.021; Thu, 25 Apr 2024
 15:50:05 +0000
Date: Thu, 25 Apr 2024 11:50:02 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
        Neil Brown <neilb@suse.de>
Cc: Jeff Layton <jlayton@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: kernel BUG at net/sunrpc/svc.c:570 after updating from v5.15.153
 to v5.15.155
Message-ID: <Zip7qnyExaCNZhSy@tissot.1015granger.net>
References: <b363e394-7549-4b9e-b71b-d97cd13f9607@alliedtelesis.co.nz>
 <0d2c2123-e782-4712-8876-c9b65d2c9a65@alliedtelesis.co.nz>
 <06de0002-c3c6-4f13-9618-066cb9658240@alliedtelesis.co.nz>
 <1235583F-8299-435B-A8C3-41DEB917D6CA@oracle.com>
 <5D19EAF8-0F65-4CD6-9378-67234D407B96@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5D19EAF8-0F65-4CD6-9378-67234D407B96@oracle.com>
X-ClientProxiedBy: CH0P221CA0031.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11d::13) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ0PR10MB5582:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b90647b-c00c-4396-eef7-08dc653f6045
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?TzdiSVRzL3lmVzBlT0tRWlZ0bHpyS1pscTR2R3FPeGFIVlltUWdKK2lpM3l0?=
 =?utf-8?B?OWlCb3lVU0ppSzJQOUo1MHRqVXRQVjUrdlpUa3A4YlRxSXhLK1FDMGMwR0gr?=
 =?utf-8?B?TGNvaWhwVUhVVkU2cUxpSXRBajZsN0lTQWJRWG82UjdSQW01SUFMQ3ZOcmpC?=
 =?utf-8?B?UTY2ckwwNEtWdkIzSDl6SGNkbVdVZzA3RW9pbUpvK21RaUs3RFk4YURrZW1W?=
 =?utf-8?B?Q2ZJaXZuUmc3SnZIWVN4NC9sa0pvdm9Xck1kM0UvbDdjYUY5Wm10M3VjcHh2?=
 =?utf-8?B?UWxPOXZDaWdRRTBLVjV4cSsyWHdhN1EySXEwVzlmREU0dlM5bzlFS2pQWFZS?=
 =?utf-8?B?SytaMTNIRHB3b0NzSGRkWkZ4TVA3N1NRdWc3MzZ5ZHJWeEU0NFNiUVdrTnRN?=
 =?utf-8?B?dlJIZmt3V2F6ZzBhVTJXSVdTTkhLVW5vanovS2JTZzZNY28wVHNIS3pRMVli?=
 =?utf-8?B?QjJKWlk5TEY5K1BnQ21qUWFWeXZsYk85S3NTM2F4anZ1em1jaElROE1Edk9I?=
 =?utf-8?B?S0w2Njl3N2NBbzFUY1dBRm94RU05dnAvYWJ3SnBmU1VSVi8vcGdmR05iMmZo?=
 =?utf-8?B?aVFIQk5UNWtsdGJJVXNSQ3p2OUxlUFVDV002VlNQSERzcENMZXVyVlpuNitl?=
 =?utf-8?B?ZE40WkRzVktoRG5kZSszNy9wcVJ4V1VDRDhFbkZLNmFwandEa0JrQzNlWkxQ?=
 =?utf-8?B?TkFuaWlzQXNReXNYc1JaUmNJbVU0bGZYTTdLK2NjV2hLbCtyOWFIOFlvc3VS?=
 =?utf-8?B?R0ZRRGJuNjFQejBLUmN1V0c2RUM1alVjTXcvNExpN1J1bXFuODQyMWh5ZzhM?=
 =?utf-8?B?L3FGRytTUjZWdTZIWjU1YkwzcG9tRjVjUWNiSGtpODNaTTB0cjR6ek51ZVp4?=
 =?utf-8?B?ekRlYjh4aGJXWHJEZVRUVTNSemtiNXFZQmt4LzhUdlkyQTcvaTBqbW1ZV0pl?=
 =?utf-8?B?KzZaR3VvUkRVL3oyOGlFL3dWZVZVM0xmd0QydGFISVVLRjdqWnJyMGVEcW1X?=
 =?utf-8?B?RjY5alJubGhJL3JranJZRTdnY0tvVVJFcmtFbmZGMklCTDhDTE9yV2RTUXlW?=
 =?utf-8?B?L3Y3UWpkU09OczhZc1hQUGRlRk5YMjBzRHNTRlBsYkRvSzMxQkRMSTJxeWNE?=
 =?utf-8?B?aUtqV0VGaWJudDRhOUhieGhtVE9DYStsbjRTYlZmOTFWWW9HWStKajhBMm1N?=
 =?utf-8?B?Tm95cnFnZ3k1TEFNaFRnMTNQVW5Ray9lVVd5NCtMNGdVZ3I4c2pHWnVEdnFP?=
 =?utf-8?B?aVhpS2p2NVlYajlYazJsY2kxVlFhQnNVM3FCZSt5eTBUOUNzNHYzSDRzS0xH?=
 =?utf-8?B?UHVVT3M2VytZSUhNVit1T3gwTVR6NlJXZTBJUEVZSGU5ZUNvd0I0T1k0RUw3?=
 =?utf-8?B?TWFaRWRDYjVZbk1MLzVjc3ZJUTdqRnp1ZDhFMnlsYnNZNU1LalZ1N0xkczFl?=
 =?utf-8?B?a0NuRmt0dmREWHZEd2JYYnhpYTJpU0ZzOHB5dzJIb2o4T04rNnlFMCtGUVB5?=
 =?utf-8?B?VXUzY20zZkVUSmNOUm40bUhNbEY5dG9OQWkvK1R4OXVJaWgxYSt3aXYvemFk?=
 =?utf-8?B?YVZJNXR3eU40Yk5Jd2FFa1huSUFCZEsyS1RVMHZ5aGcyV2wrVmhuK1YraEw5?=
 =?utf-8?B?TjMxVmFkU0VneXlya0pESFJOWHBQbURzOGJmdCtUcTA3d0V3Z24xSXNWRFZt?=
 =?utf-8?B?V0lFTW5pWmZ1bERldG5obkxjRi9NcTE1VXNNR3hhYWw5WkdnUzVlT1BBPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Q3ArY1ljc3NiNk1KT1BOTnQ0V01GQTl4RnVzazl6bWJJOHlSNFpUTmxxWGFl?=
 =?utf-8?B?d05JTy95MVV0N1NIcVZYNzdPVkltYUxDeGFrdlU3WUZzVXJhdGUrcFhLQ3du?=
 =?utf-8?B?amNIM1lmdTFPb2VpYkowSHJzYkdURjU5S1p2ME1qWG1UQ2FsK1BDSzJwNlM2?=
 =?utf-8?B?TEMzdFZON3RSd0IvaUFmMENOU1pUS3RHeEJYYkE1MEZlTzZIWXNGNmNNSVJS?=
 =?utf-8?B?MUtDRWtDNXZmdEtJOWEvcVlmbGw2RFJZNVZDYURLUnVhMWlqQ3dIaFVGTkNG?=
 =?utf-8?B?b00rTWxOTWVFYXFhc0VaQU4weXV4cFVmWitMeEkrRW1naUoxN1pEczFwTnR3?=
 =?utf-8?B?Y2E1TmQ2Ym9Nci8zTW4wc0N4NEVOQ29tUzMrbFZzQ0xYSmlwOUpWaTdPTGJN?=
 =?utf-8?B?MHNLaVJUM1ljK2ZqS1poTHdzYWZIa1l5VHI0QjkxMzlJZTFzZE5tQW9NajF4?=
 =?utf-8?B?T1VOeHpvcU03RVVaUXhYNXBEYkRsUGpXSE85TjJRd1ozMUpuUjJRNzVCSTJs?=
 =?utf-8?B?OGJEeCttQW1QVmtLSXpFYldYZjQwVEFHc09pYmtzV2M1UUpyQ3dxYnY2RjM3?=
 =?utf-8?B?c0tjR00wTzFqM3ZjSUhDUXVlb3pleDZSNXNscVFhMXlKTWhtVFF5VnFveURK?=
 =?utf-8?B?NjAxSDBYeGozT1dIYWVqRllCeHNTTnZpM1dXVjMzUk8zNUlmQUV0eDRodG1r?=
 =?utf-8?B?bi85WWlINlNiMWk2SHhYTmxQOUV4bm1PQzlnQVdXd2Y3UGxUQ2o1c3JEQXkz?=
 =?utf-8?B?V292QjZoN1dyOWdDOXowZ25PODBjU3QrbFEvYzl5Sm5kOCtsZitNK2RqVFNX?=
 =?utf-8?B?ZUZSU0h3Y3JxY3MrMDNuQko4L3FmOWU2cDhYLzJYOFVYTHVsb01qUktydk95?=
 =?utf-8?B?NUJyTDRLaTBVdjl4ZHRUbzBLdUpYbUpOSGpXbk1hUUx0cXBGUWhJbi83THN3?=
 =?utf-8?B?VUdyNG0xY2hhZlpLK0lFcENqVFkzaFUxYmlsODk0UjBUblZyU0ZiMTlqZWN2?=
 =?utf-8?B?SjhySUtjUDh4NFpRMlpxQUlZMDd6WVI4eVpOZHRiZ3NBRzBnbDExQ2ZMc3JL?=
 =?utf-8?B?cEJwMmRpR0hOZkhJVlZIM205Qm1pU2ltcW0yRDdBQnVDVHhXajIrWmxOMlBl?=
 =?utf-8?B?ang4OHJWbGlQMVhMTDU3Q0FqTXI4b2kwQlJlcWVobTFPQmczRlo5QkFMTXBz?=
 =?utf-8?B?NGJXa2RjSU12elhkVXZlVFp6Vk1hOFNmT0ZnQk5ta2tUajhOeGo0S2VyZC9G?=
 =?utf-8?B?RUF6cGptNEowbmpLeEsvbGc2cXdvVEJaQy82MmJ4Snlodk9OeXo3SXNYR1B4?=
 =?utf-8?B?TXpiekFMK3FReWF1VG9jU0ZXdFFGZTBVZjJja1NyYi8wZ0Q0WDhoZXB1V2xW?=
 =?utf-8?B?UmZjcTh0VFJ2dFZMNGJJQm9lVTZ0dGs2YXFkaTBEejRjSEVGcFA4MldJay9I?=
 =?utf-8?B?Ym1NRmZQUzE0VWY3WVpxK3c4dzluZFBKSkk5ajlEMDFqSCt0eUNuVHltaHZH?=
 =?utf-8?B?bXZaTHl2UHc1eS85WW9oMnBJc3hmYkQrNnhCQWhSeURUOHpheTdQeUhJRWg0?=
 =?utf-8?B?V0E2djV0Q0RTMmk5MHpyL2FXR3V5ZnJJNDJJRUNJWHVJejhyQlNURUJScDdL?=
 =?utf-8?B?S3ZLYWlldVlyL1FnL2gzQWhhclgxbkhGVU9IY0RXbE1oa2ZFYTB3S2tsV2JH?=
 =?utf-8?B?MEV0ekxxOFlKMVNFSW5rSVFyL1gwSXkyK1BXOHFDbTVETE9mT05OTGFTY3ZT?=
 =?utf-8?B?enNQNTdXajZWeU9HcGlQcklQMnlCRzlBWENObnRPVXd6N2txaFE2OTBhQUxJ?=
 =?utf-8?B?d2l6WFV5UG5tR3BSOVlBaHJpWnp0YkpLMDZsekFRMmpOOEllSVczRVZvM0NV?=
 =?utf-8?B?ZDlZd3Y0SUFtUldwemV2VXR6ZlBTOE9kamI1REZHYTZUSTIxVFd3N3NJL0xi?=
 =?utf-8?B?N0JwMlhQOU1CeThiQk1KWm9HZmlsdzYzVEtsSmFPMXpqK2RzYVUyVFVXdm50?=
 =?utf-8?B?K1RXK0tacmFVekpVS0dPdWo1ZnpIRzdlMms2dTlWNk9mbEcwTlM5NXdBc3RU?=
 =?utf-8?B?Q09kL01qQ20wdFZrNm1PSXRVaDBSQ0JlUHRQUDJhaG5pbXRjcjRaM2NQaFM5?=
 =?utf-8?B?NStPdEVuWnQ1YWFBQlhUSXBCSzRSUkdKWmpaZi9rRkl5ZEV2Z2dyVVlvVUg4?=
 =?utf-8?B?VlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	hBC+6FAXmUU/N7frih277YCF7+MpA9yGj7PNK/mBpwpjaOP5RJ3YslVwuV9jRDdDsmt5By8dOtQWcYIFbUC11WKJ/XWJn76ernfuN38JKyDZR4zT94332MTI6JtQOoypTZqc/LrZ4W/sGuoKnNgwusO9KeLmXp3n+gxzqmbO5E8YoNqVa2fZEEpAO75Rjt2tDEL896FU2XSw5a4QqfFDMscA5pqNtGHYeiAFUT/CcUDXVV2bT/4SVc0vMpgEyE8CPEWIdo7i5P1TrbxFyrlCxLUAK1/hg7pO5wtSfcPblajEgT9omb1yfJ9aUT9KwrOAJIj51ouBqlM/cLBA0do/yHm7XTbLF5yaR59bCLxDaRcSVuPoclbaNhGn/jqw4YutaiGj1I1JNg0gZYvzWsvSmVVy2wtkAUPcdvoChYDHOhaNP6VqaZSVDGAAiZIXcBFxNztT+d+jKu0BTuwnbUOCtK+LcQ12Q0Sly/AjuxzSXnqV9UoWt/504GcHZEN9N9RcXHTsczNAsSgIoV1hp+TvlmotmMvCpfunFWUThTgG5rPaUmUul5HioI3aknJvB9i7msQfH6x4MHjLLvNicRmTw1wNUFqYGnxeeUp+kj2O0nc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b90647b-c00c-4396-eef7-08dc653f6045
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 15:50:05.3784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M/Q3wMbbxi9VNLxAbREVnLWMDwMbOV44L1ckonGjqyP7pjMnUWPVjTAMzH38kZvT2ixS5y0n0LNoKqthGNVJYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5582
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_15,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404250115
X-Proofpoint-GUID: oB3S4kkn7U3q1ep52XWIDo3GmsK4Pr9R
X-Proofpoint-ORIG-GUID: oB3S4kkn7U3q1ep52XWIDo3GmsK4Pr9R

On Wed, Apr 24, 2024 at 02:03:22PM +0000, Chuck Lever III wrote:
> 
> > On Apr 24, 2024, at 9:33 AM, Chuck Lever III <chuck.lever@oracle.com> wrote:
> > 
> >> On Apr 24, 2024, at 3:42 AM, Chris Packham <Chris.Packham@alliedtelesis.co.nz> wrote:
> >> 
> >> On 24/04/24 13:38, Chris Packham wrote:
> >>> 
> >>> On 24/04/24 12:54, Chris Packham wrote:
> >>>> Hi Jeff, Chuck, Greg,
> >>>> 
> >>>> After updating one of our builds along the 5.15.y LTS branch our 
> >>>> testing caught a new kernel bug. Output below.
> >>>> 
> >>>> I haven't dug into it yet but wondered if it rang any bells.
> >>> 
> >>> A bit more info. This is happening at "reboot" for us. Our embedded 
> >>> devices use a bit of a hacked up reboot process so that they come back 
> >>> faster in the case of a failure.
> >>> 
> >>> It doesn't happen with a proper `systemctl reboot` or with a SYSRQ+B
> >>> 
> >>> I can trigger it with `killall -9 nfsd` which I'm not sure is a 
> >>> completely legit thing to do to kernel threads but it's probably close 
> >>> to what our customized reboot does.
> >> 
> >> I've bisected between v5.15.153 and v5.15.155 and identified commit 
> >> dec6b8bcac73 ("nfsd: Simplify code around svc_exit_thread() call in 
> >> nfsd()") as the first bad commit. Based on the context that seems to 
> >> line up with my reproduction. I'm wondering if perhaps something got 
> >> missed out of the stable track? Unfortunately I'm not able to run a more 
> >> recent kernel with all of the nfs related setup that is being used on  
> >> the system in question.
> > 
> > Thanks for bisecting, that would have been my first suggestion.
> > 
> > The backport included all of the NFSD patches up to v6.2, but
> > there might be a missing server-side SunRPC patch.
> 
> So dec6b8bcac73 ("nfsd: Simplify code around svc_exit_thread()
> call in  nfsd()") is from v6.6, so it was applied to v5.15.y
> only to get a subsequent NFSD fix to apply.
> 
> The immediately previous upstream commit is missing:
> 
>   390390240145 ("nfsd: don't allow nfsd threads to be signalled.")
> 
> For testing, I've applied this to my nfsd-5.15.y branch here:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git
> 
> However even if that fixes the reported crash, this suggests
> that after v6.6, nfsd threads are not going to respond to
> "killall -9 nfsd".

I cannot reproduce a crash when using "killall -9 nfsd" on the fixed
kernel above. On that kernel, the killall command does not terminate
the nfsd threads either.

Either we can apply 390390240145 to 5.15.y, or if the imperviousness
to "kill" is considered a regression, I can look into stripping out
dec6b8bcac73 and the subsequent commits that depend on it.


-- 
Chuck Lever

