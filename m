Return-Path: <linux-nfs+bounces-4159-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F8D910A68
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 17:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08CA4281984
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 15:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4031E876;
	Thu, 20 Jun 2024 15:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eP+0itme";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JDZUcOOl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49441CAAD
	for <linux-nfs@vger.kernel.org>; Thu, 20 Jun 2024 15:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718898431; cv=fail; b=lld/g7GLHolOhK/Vt+odDki6yPvSpsxcskFG8uZUXwMR20hsoaG1ftWT/sX76u9CkwcwNpMEr16Js5vYvUdGFz+SJn1b7k95tIT634ZwsTaY6RuATglcQmk4RZbncJtvQF+jwk1v6EilZzRcg0jrAWTkC205PZISRZzBRPUtQik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718898431; c=relaxed/simple;
	bh=knB9ffcIjmkedEkYQ+2vLsLPAp+OdhDTj+nrapUTZYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jKl7NFVDjbArIjOmIp+SLzkSD4Z/3B0+H8Qpb3ha7v+mMN/IHceSLgg66vEGtql7VxXj5SKeltIJXcbCxihyLTMbN9C/zTvTzdS98Lmym00LUiiDlcAQUonGyuYbU180hecCmAXT/OS9Q98dmDTZwlZ6N8BzMPQUIRt3MNJAQ/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eP+0itme; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JDZUcOOl; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45KEAeAe004131;
	Thu, 20 Jun 2024 15:47:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=gjjn7kb3owkoEzX
	nwXVhKyxpod0JNjWpM2zawu25iIk=; b=eP+0itmeE/g3NI9nodTGGAeLCcZrwDZ
	aCTEOqN1lSZJvxf7o+DtKzdjJIQYijwmxvZZDlud4VWwAp5rEoRZUP6njFXSwd+3
	WA7ZRexusD07lIKwDakV+kZbL7oBpLP0DA+P0ZnCI/iQtSY3fRUXB1ca0CvDlNYF
	C6tfoDb7bhcPsG9hcr8Nite4P8sj+fPERuf6cJ9UBVX0Hz/t/xMZUgnfLud8yX+E
	wXzFJF3X8+DA0BIGvV6Yna9ZL96Di59ZbY9F6eBAzYw2zu47EaMtR9ygJUpGHd4j
	0XsuMk+rU6NfJPnppScyWxO1TIaGiE95B76vUqrv9OLv5kJ5fCL6J8w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yuj9nbhfa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Jun 2024 15:47:02 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45KEx2fH014913;
	Thu, 20 Jun 2024 15:47:01 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2043.outbound.protection.outlook.com [104.47.55.43])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ys1dh0ars-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Jun 2024 15:47:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jFFuEnFvAg95FCrarDO3moNEWnDhGFAwAk05818f1QFg++NrmQ4YIjDfyijQp+07oxFUnch2/SRU8mxSkJiQymaf0Pk4I7GOra+Cx+TW62798zKAR++C59cDf9gMZCeoId/+yUqUBWLbzPg8RUBnxb0SFP/8ku0N7sYaecj53aWIXPZdAQ1FRK85f3G5wcqG/TNCmQzPh8GHS5rg3Xu5gv4HydkeHE9PVtQE3t7F+8RhChAi/A1wRQUxIUevsao7K0cxeqHfu7QVFuC0pEEg9nWVcDa0V8DtIomd9gy35HyGEVd6/BDs51nVCYXIkCxKhKv/dzo0yCZI/QgEAFH6PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gjjn7kb3owkoEzXnwXVhKyxpod0JNjWpM2zawu25iIk=;
 b=KG4xNjGX1ehE9O3kmL+PcBvCwJ8+8rpf4ErmosLRdQ4y+C0vV6+Op7NpDHtDITCxcPP90g0Eslnx242cRpeRYJAct66iijgopXKivzjUd8tFxsAGJmYInQmJYQhGMalP9+5T6Twbc31N90Gx/q2LoWRUPdnZ0wCFbPZ7fCdNUgsai/gcNTxcG/qSsLL2XanXIbzs8GHeQpwqPGCDgS0GSgy2vL4QTs4IBSn4QfJWpW4X4X8s2swnC+EkB8eFk9+BOY4FVvR4d5/ARP8ix5uHet2XocQxo4Mghmf3tbCEbVCzHfn+CV+rrww9a0c77VwfI4yxd5sgOclElob+D3nBYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gjjn7kb3owkoEzXnwXVhKyxpod0JNjWpM2zawu25iIk=;
 b=JDZUcOOl+tjhekNFaR8aRsEGRl+IHfW/PhoDnhM6WAmsRAr6Yc+78jGAgMaheMoS95DESLX/n19cDYMm9e5wf7zaGNrTz1G/5cpGt6lEVP/A5CWodBPsXo53ZcbYnDIQVNxiSD/s1zEQcj8twjwLIgKHioA0aorUeI1NwLS6URI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB7141.namprd10.prod.outlook.com (2603:10b6:208:3fd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Thu, 20 Jun
 2024 15:46:59 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7698.020; Thu, 20 Jun 2024
 15:46:59 +0000
Date: Thu, 20 Jun 2024 11:46:56 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Benjamin Coddington <bcodding@redhat.com>
Cc: cel@kernel.org, linux-nfs@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC PATCH 3/4] nfs/blocklayout: Fix premature PR key
 unregistration
Message-ID: <ZnRO8BA/TlQjpCmg@tissot.1015granger.net>
References: <20240619173929.177818-6-cel@kernel.org>
 <20240619173929.177818-9-cel@kernel.org>
 <D3359408-4D02-415A-9557-19A6EFE5DDCE@redhat.com>
 <ZnQ927sF7oRT+KmF@tissot.1015granger.net>
 <F421047C-FACF-46EF-9169-07C8FF5FCF3A@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F421047C-FACF-46EF-9169-07C8FF5FCF3A@redhat.com>
X-ClientProxiedBy: CH2PR16CA0023.namprd16.prod.outlook.com
 (2603:10b6:610:50::33) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA1PR10MB7141:EE_
X-MS-Office365-Filtering-Correlation-Id: ad1b6624-47cf-4f8c-0203-08dc91403859
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|376011|366013;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?gMNZJJp5kMWptSlIZC4TiSlQTmtVZ2BXXgSyrCHaDS/hbIV+HRFPI2nkRf8M?=
 =?us-ascii?Q?iXOkht5+LBpF9IgUvTecIm9MNUwtMeLGY2T7y5UsuIszyC8H3C4p1UcCTt3t?=
 =?us-ascii?Q?6KoYSZLIWTpHWZ3IstK+SzfDp+yRcP/FceTtipZXSy1yFsXIFGL7CIP17bGF?=
 =?us-ascii?Q?i0XGdDTqxxn9he76jMoH1gMTTPlxK1HBrpVaGmGZUtBdikUrft2y0feKeSG0?=
 =?us-ascii?Q?/sqWn9cNiB9Z8BPIFArn8l2koGJJIIyjI2taRq541yBZJU0gtcBRNHh/tMWn?=
 =?us-ascii?Q?puVnxzrWAjx5d3jf3BAhBVwJYpZRE5mMqrMuWCb1TcBH9robBlIEXkY6HaWR?=
 =?us-ascii?Q?UnI/4ZYnHFv5mOgTKa3JcWjRJRyffL7Z6M4dmoRQDWpERjg6MErJaTXnagnM?=
 =?us-ascii?Q?ScJsIni9l84Zi4ax3+UxS+CzG8oepByzxga9DxmsnqtHtiRmIqg8qbUW6rSC?=
 =?us-ascii?Q?hBozJyYOU9O37IHy/aQon7x1XLDtPnmQItlTe9VobmUkXOIiYdT9HF6K2OJO?=
 =?us-ascii?Q?cz0DKWY3/57qbfLvgM7/vaKof2pvC7k9F6lMg0saIt3jgj583bJ0FMoH/Jca?=
 =?us-ascii?Q?nhG0K4///+o5fanh2eEaeusUHxBihklv8Ah7Lrehjn8bcL+R/oMFiFFWMMR8?=
 =?us-ascii?Q?QImfD6iqRzKgix/VtpApR153DSgykJtgp6z4H6PHzN7K+SP40e6MftBUo2eb?=
 =?us-ascii?Q?xeEL3EABUtvqlc3alKwIqtYKP+NGUETQCp79KHS0MambsrF37Ob2PZ0CqTBK?=
 =?us-ascii?Q?tvXEf3B+kIFWGqjJBvu8Fi3d2XgQwLN92zpNFnmdD97pvWHDDF6NE9g/r7dQ?=
 =?us-ascii?Q?BQbqKQR7Ao/Q+mSz/xJC1GymtoB0XZwcnj2EI7w+9qCk38UsK2cNSM7K9D4E?=
 =?us-ascii?Q?6AbjWpZcA5sNbkWqV+JQBGA8PPXHSdtajZhtEmV6OXaVvpP73ooYE6JsXqD7?=
 =?us-ascii?Q?ZryGdAKtrkbJE5eRbzl6NPjIHHRP1Ms06he72fRY/HCjm+SPMhrGmOkg61O7?=
 =?us-ascii?Q?8Fr3YlRNODue7xbvBz9TECsHY9W+GsXT8cEWH9QaJPO0pOyqe0e0+/gz+NtU?=
 =?us-ascii?Q?1chruQ3kEEACv460/jb906Jbia9Y4StRbt94bQYt3Z3lX2g9M9qjn9j/D58c?=
 =?us-ascii?Q?HcW0nMRluAkwV9IpheoZqePGHNZZwCujLYdUUP4TQFHD+fJfjfYQFbhqHGJM?=
 =?us-ascii?Q?ZNsBIOszsyH8YlrtsXGEBzH03YW2dcw4BzKU6AiTcML1f2Wg1YbkFYKwE/jk?=
 =?us-ascii?Q?VjZF5PPZwCY6zLaHAI+/fUdIDO+yYRrfpRby0x19zqqwpJt0gFv2HtjA4XNE?=
 =?us-ascii?Q?nsOdc1BBe3rPmQcb+9qKoPws?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(376011)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?FxdFwH3vrLHDxQe2TQrXKalXi3Ejo/EKL0AzFRNSe91yzYJ0jQh0rvIb9i9S?=
 =?us-ascii?Q?dQXv+Nn0IxVuUXQTeFqUbNwsjF5Zo3Y4Y8pIgvrBj3pzrrG4jX0XDGA9TuLn?=
 =?us-ascii?Q?6BRiW+jLCD8adD8kjuaDX2n4RPAOcBbcQEoXplvtEVeX+Mb1EAdxnhE1fXOC?=
 =?us-ascii?Q?5L5RKdnlNfWGJ/zpp0XbkikIahGwKsiYFzl9jM+5NGJP8/Lh5g/UcLhFT2Oc?=
 =?us-ascii?Q?4GgwjS9poYpJTcN2lo8NX4rLFnqXk4L/A3e/GG+OduqLgV0qZc4hwnXQNu3F?=
 =?us-ascii?Q?slxZotggY9JYWtnJsmwhtaLQ7uU7fFWDNiJVGeNr+FVsGnYqCis90XRHuNdK?=
 =?us-ascii?Q?+gX+liCF3ulu8s2ffbhbTbSAovc3T80a56SkaIA+ahlsMwkGl9LEaMsF+MC8?=
 =?us-ascii?Q?CGrkF2d9u+an78TrCyKdFPx9ya2lTgGQQfASpogstqk8ti0o+Y5/Qxbmvewc?=
 =?us-ascii?Q?zZmaN7N5SyMcHxnteVjzEgIPIhU4DbpmgGFT2SJOjPgvI71z0SDtK5ls4DSD?=
 =?us-ascii?Q?KEb0LQBbXQDoJiN5hgxShY2x0u3NyUjaFbrUD0vKTZiGvLOKnlv2CUj2QIde?=
 =?us-ascii?Q?vhscsjJ2XVm5uab6nGnPh3JMPdyiJV1CKJ53aA6QS7TLwDGPTNfS2+M4O0eU?=
 =?us-ascii?Q?yXOcP7qLnVcvyN23+YBpGMn54t/pTX1HmXnSZtfdI6Q5Yckw9ETgpNkHyas1?=
 =?us-ascii?Q?YcxdKWkXJLEF/RyHpK6hLj01ZYulYu8g8hJvwCWSUgtIKJQoKUM1IQy+8Hce?=
 =?us-ascii?Q?TPJp1yeW/v7SrhLy2jYsBrXfxiL/IwlqlzJ8JRUfViqK3X5O4Wjua0bkqEBp?=
 =?us-ascii?Q?OdBQOD+VqmK1HdE6x3FQgGGW2YKCyLHMPlUGieJJSHPcxCuWiTQDRQabWvYc?=
 =?us-ascii?Q?OSjc9SqETBzrygr+SOSCCtv6IFSySJLLsgWGMzL/ObHL0CArWWgB+OUtftrZ?=
 =?us-ascii?Q?pL5yoz9Au44E/HoyIEZL6Ze9AjsMkcgbZB2HysVpnU9RWFkwCdshoNY4rTRt?=
 =?us-ascii?Q?2yXg8CBlmuXuB4J8WAMWDr7XHdX4e0p+5VZ2W3Ronj5T8G4tGQVub6r0Drkx?=
 =?us-ascii?Q?DIc2OQw9Pb7vp/wNWeH2x9LO+LsREKnQH/pQeIMSf/GuEG7Y4G2Hmql78+0G?=
 =?us-ascii?Q?VAPal0K0bU2iKfv2OsNtvADDrWiqtJfBTULy0C8a12ZcdjTfmR4aMGuQ5190?=
 =?us-ascii?Q?scgyDAilg38yHUiUUrQHZjq1d3jR0GQTLDiAfeXurkhzLgCvup7HVnR1iP6h?=
 =?us-ascii?Q?1WS2OC1P8L1IzMvqxIn3AXG+/CPnFZbAflrK1q4+auAepfXwkX4fj2UAYpoE?=
 =?us-ascii?Q?E2vxZbY974sNtpuwhMxO+5shMkvaVthmmS/0Ck/nzqlFvcB6JkPhVnbxD5PG?=
 =?us-ascii?Q?97i/X4ubOf9EwSO0AtPRCsoS/pn7/ql/opr4qW53iRYxfc4PCdR6NGT+Tg2K?=
 =?us-ascii?Q?4fp4ceRwgodZ5nus1uI2gkJvYZPOaVWSbVTLh+gi+wOL/nk/tM5Syh9tnDop?=
 =?us-ascii?Q?dau0JVNd3zKC6JdcGWYitbNa/IVG5GrAB3YEwtqZfuv4Do3eKmChQ7LBKmIf?=
 =?us-ascii?Q?tA4wrOruJ8cz5G27ouh3NWC3dQGstG+tuvt0+CXFlqaEMWvYrVYYUrUjgegE?=
 =?us-ascii?Q?yQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	apPvQbHI9YBDcecUTWDfAb5oGJ7bVhqE1fF/GUlmvgistmnTddRrLe4VOCF0MGvRxgCE7y7APcYIkEaRHB6ALfC3BWO5k/FjYfjJ/dtE0GUyzVIl3hFSY0zK8Xs7OuqrSA0pZXZV1mPsjxHIkNIsLBJznJh3ugnwHrgZP+IwJ8wTc0LclO6HzYzBk8Bzt20cVQGyax1Eh91rWuK1Ouc4stl/UOGya/m/sygTVeh2G3ZNqBdWJmDKgqCmVYyEnqP47HCsVS+LndBje9c93Z4p4xGQ4jsIcOuBHCl9ob9+NeDM8gfVx7zAY3QJnTwqDG7ViMYIaHkq3oK4LObD/Ca87lWBmo0rXqt/lEpFrEBpg0ElwBlFEt6engZhUPaNof7+KoL5SFcSU0GPgIdqc7AhHjKOBVrfGRFrBoeb3dfx3RZgzh6i09oyVtIO8+NeT1/BpefD7Y1md7dzWrZTDO49wO/V9GeCzbFHGEGh9EETc28B883rfcci/UUNTzsJjR9cJiKdppaNWneFsmq1PhJMrrlji2dKHoqx4s5pimG2HjQQFBY5uCo8SAzYXAJctpQoQPNsXMpUvm0yXPglpSh/Jjfo451Bl/x9Zm+hQGQRSmA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad1b6624-47cf-4f8c-0203-08dc91403859
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 15:46:59.0698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MgTV72/HFpTPhHWnXmO8yDucHYIfGzb2u9eUPYd4mvjj0dQbBQF/EqAqpWhhl3/di9JA+mMZd6ArkLh+40qwfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7141
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_07,2024-06-20_04,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406200113
X-Proofpoint-GUID: OBicoRJUGoZkpvpA8AjF6i8Pwv6BawWJ
X-Proofpoint-ORIG-GUID: OBicoRJUGoZkpvpA8AjF6i8Pwv6BawWJ

On Thu, Jun 20, 2024 at 11:30:54AM -0400, Benjamin Coddington wrote:
> On 20 Jun 2024, at 10:34, Chuck Lever wrote:
> 
> > On Thu, Jun 20, 2024 at 09:51:46AM -0400, Benjamin Coddington wrote:
> >> On 19 Jun 2024, at 13:39, cel@kernel.org wrote:
> >>
> >>> From: Chuck Lever <chuck.lever@oracle.com>
> >>>
> >>> During generic/069 runs with pNFS SCSI layouts, the NFS client emits
> >>> the following in the system journal:
> >>>
> >>> kernel: pNFS: failed to open device /dev/disk/by-id/dm-uuid-mpath-0x6001405e3366f045b7949eb8e4540b51 (-2)
> >>> kernel: pNFS: using block device sdb (reservation key 0x666b60901e7b26b3)
> >>> kernel: pNFS: failed to open device /dev/disk/by-id/dm-uuid-mpath-0x6001405e3366f045b7949eb8e4540b51 (-2)
> >>> kernel: pNFS: using block device sdb (reservation key 0x666b60901e7b26b3)
> >>> kernel: sd 6:0:0:1: reservation conflict
> >>> kernel: sd 6:0:0:1: [sdb] tag#16 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
> >>> kernel: sd 6:0:0:1: [sdb] tag#16 CDB: Write(10) 2a 00 00 00 00 50 00 00 08 00
> >>> kernel: reservation conflict error, dev sdb, sector 80 op 0x1:(WRITE) flags 0x0 phys_seg 1 prio class 2
> >>> kernel: sd 6:0:0:1: reservation conflict
> >>> kernel: sd 6:0:0:1: reservation conflict
> >>> kernel: sd 6:0:0:1: [sdb] tag#18 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
> >>> kernel: sd 6:0:0:1: [sdb] tag#17 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
> >>> kernel: sd 6:0:0:1: [sdb] tag#18 CDB: Write(10) 2a 00 00 00 00 60 00 00 08 00
> >>> kernel: sd 6:0:0:1: [sdb] tag#17 CDB: Write(10) 2a 00 00 00 00 58 00 00 08 00
> >>> kernel: reservation conflict error, dev sdb, sector 96 op 0x1:(WRITE) flags 0x0 phys_seg 1 prio class 0
> >>> kernel: reservation conflict error, dev sdb, sector 88 op 0x1:(WRITE) flags 0x0 phys_seg 1 prio class 0
> >>> systemd[1]: fstests-generic-069.scope: Deactivated successfully.
> >>> systemd[1]: fstests-generic-069.scope: Consumed 5.092s CPU time.
> >>> systemd[1]: media-test.mount: Deactivated successfully.
> >>> systemd[1]: media-scratch.mount: Deactivated successfully.
> >>> kernel: sd 6:0:0:1: reservation conflict
> >>> kernel: failed to unregister PR key.
> >>>
> >>> This appears to be due to a race. bl_alloc_lseg() calls this:
> >>>
> >>> 561 static struct nfs4_deviceid_node *
> >>> 562 bl_find_get_deviceid(struct nfs_server *server,
> >>> 563                 const struct nfs4_deviceid *id, const struct cred *cred,
> >>> 564                 gfp_t gfp_mask)
> >>> 565 {
> >>> 566         struct nfs4_deviceid_node *node;
> >>> 567         unsigned long start, end;
> >>> 568
> >>> 569 retry:
> >>> 570         node = nfs4_find_get_deviceid(server, id, cred, gfp_mask);
> >>> 571         if (!node)
> >>> 572                 return ERR_PTR(-ENODEV);
> >>>
> >>> nfs4_find_get_deviceid() does a lookup without the spin lock first.
> >>> If it can't find a matching deviceid, it creates a new device_info
> >>> (which calls bl_alloc_deviceid_node, and that registers the device's
> >>> PR key).
> >>>
> >>> Then it takes the nfs4_deviceid_lock and looks up the deviceid again.
> >>> If it finds it this time, bl_find_get_deviceid() frees the spare
> >>> (new) device_info, which unregisters the PR key for the same device.
> >>>
> >>> Any subsequent I/O from this client on that device gets EBADE.
> >>>
> >>> The umount later unregisters the device's PR key again.
> >>>
> >>> To prevent this problem, register the PR key after the deviceid_node
> >>> lookup.
> >>
> >> Hi Chuck - nice catch, but I'm not seeing how we don't have the same problem
> >> after this patch, instead it just seems like it moves the race.  What
> >> prevents another process waiting to take the nfs4_deviceid_lock from
> >> unregistering the same device?  I think we need another way to signal
> >> bl_free_device that we don't want to unregister for the case where the new
> >> device isn't added to nfs4_deviceid_cache.
> >
> > That's a (related but) somewhat different issue. I haven't seen
> > that in practice so far.
> >
> >
> >> No good ideas yet - maybe we can use a flag set within the
> >> nfs4_deviceid_lock?
> >
> > Well this smells like a use for a reference count on the block
> > device, but fs/nfs doesn't control the definition of that data
> > structure.
> 
> I think we need two things to fix this race:
>  - a way to determine if the current thread is the one
>    that added the device to the to the cache, if so do the register
>  - a way to determine if we're freeing because we lost the race to the
>    cache, if so don't un-register.

My patch is supposed to deal with all of that already. Can you show
me specifically what is not getting handled by my proposed change?


> We can get both with a flag that's always set within the nfs4_deviceid_lock,
> something like NFS_DEVICEID_INIT.  If set, it signals we need to register in
> the case we keep the device, or skip de-registration in the case where we
> lost the race and throw it out.  We still need this patch to do the
> registration after it lands in the cache.



-- 
Chuck Lever

