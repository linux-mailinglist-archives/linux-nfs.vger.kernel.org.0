Return-Path: <linux-nfs+bounces-8005-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BECB9CE15C
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Nov 2024 15:35:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D43851F2169F
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Nov 2024 14:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4036D3A1BF;
	Fri, 15 Nov 2024 14:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BgE3sBPu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="L7Zx/4d/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542311D45FC
	for <linux-nfs@vger.kernel.org>; Fri, 15 Nov 2024 14:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731681310; cv=fail; b=sGDZwBKYeyrBcNCylkThS+OuCV3+KlTCvuaWiafZWaKOBXCDWmUNdIWr2eoP/v3VAdRGWyo3BMZ+RwBHBtjoYQ1+QcVbAdxGvtHVVWLxptYVUo7uZ1EuBgi73NvP71jE2OjRMjIsYoxnL5XYhn+I49TD8ptKaivCmCOfSC+HmFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731681310; c=relaxed/simple;
	bh=5efTn64e49O1PC3v34ktpqnMaPH0cjG9scKzCiUvCDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hcVZaGqQ/5///+S5f6oQ7EV9tvQMEEmECnrH9JeOkCxZnbkbVvND0eTc9ZzBtxXO3HY6PoTi6W1E0lZJro6mtGX9JxU4WdSH+eqs6Qoxs6yOgHefCnrOtUUdE3Tn11wN04QlPabo15DOXChafzW80EyQuQ0B6qrxNAJyfvWZSNU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BgE3sBPu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=L7Zx/4d/; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFDCSxE030507;
	Fri, 15 Nov 2024 14:35:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=EQK5vJhJl3F5afO1j/
	PzVUpiA3ZqcR+/+7vFe9ebEpQ=; b=BgE3sBPuR9vVnD+pm8/OwGV/JnsEgdytx9
	SGZx/nAKOsS6SEHatlkYfmJsMFX+Zh1TzUfMBzb8RS7WY2fUFJkQbV3/E7r2WOpc
	QTqhKFXXkdkFIO/rkN01jH13HIRGBK3RdWO5dl0sBt7jM4y3w41E8G0DcwolOQXn
	zqwblqqRyoboyl2Ln4ne58aqNTsatcKYYv9Qxm9ahgTP6AUZLXGfNFnvrLDevvHk
	DBohtRNgq/pLWMNYeUA0Yp9eVp4sl5aJT+vg60EwxpwwFajF16DCU9lj18vlaI//
	XHo668oR4Fg2sYTDRXAS03IF9KuJpU8KO0mJWHv2trL5qF5qlAoA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0heucu8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 14:35:02 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFDhVqr001163;
	Fri, 15 Nov 2024 14:35:02 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2048.outbound.protection.outlook.com [104.47.55.48])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42sx6cmyyx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 14:35:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FXtwNoqWnsiuJ6gJvyT91pzKlwZms5xAWGLJww/8YJJp2OQi9fJTMBXO103PcqBI3tHssHCO/ZI+zyxnvFFponU5W7jqhbOgxUL6zzNEaDRInYct1TxB6GWvY9axY2uuswvPsbcW1TJ9QiLqf37M/KWoBgwtVVttqU3bjfypUHNTcC04DaUZJcwDUwlvsVydNJ9EG+VjbxIVhLWId2KyY+9nTxJxRYDS9VyQdrX9RqsoJuUFE6nA2Pq/XlV0JWGgq+ZVgVnMwvcCcV1Yu3NSnWevs78jm0seT6kdzHDKYqklB1Ezkn2PjAtnnyUgym6c1Xw5UrtcSHtDKMhM3+QIcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EQK5vJhJl3F5afO1j/PzVUpiA3ZqcR+/+7vFe9ebEpQ=;
 b=G8Fu2pEa01CSwGwk4PPNSPZNLtli7ONSkUEu+in+Pv8ykM6fd2emllVQtp4b8WrQApysMVuu0pxqFO+yugruUX0R4FXrVfzCrnTZWVEPcm0DbjYV9Qws8CGKX2xNgTeznVhE4Ga5iHwbylbkMaOKtv2Lv5cyETXB9USv0tdqsvuKXEpBlNUHqEjQXwhU9dDwwphkWMj3U0K6sxE8X1IMYLbe2A1BIodw9FtsSjlcKB4NQugzrWONtTZ3ozJlzmFTpq2eWfBGaLDJlN7WPNBoQHWZrsa5gsuxKMkrB/+1TZaIrkAHkzDACDSUw96qJQhXoidOaZWh3fNWrYehWQ4XCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EQK5vJhJl3F5afO1j/PzVUpiA3ZqcR+/+7vFe9ebEpQ=;
 b=L7Zx/4d/ZhXXtJO5XM6UMbBKzksPGVENlmRsoHAj3/qXKgfC8ILdjROghRryfhhMEvJ9GTT7cx3BqTlY4RCZmGLs9euVS82ksIBDvlZLlwSFKSmFg7u/sDsVG/RCw0PnJk7uQ0qDYfZH4bTaPDTcpi+4EKlerkmhQX/z57O54oI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by LV3PR10MB8011.namprd10.prod.outlook.com (2603:10b6:408:28b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.19; Fri, 15 Nov
 2024 14:34:59 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8158.017; Fri, 15 Nov 2024
 14:34:59 +0000
Date: Fri, 15 Nov 2024 09:34:56 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Benjamin Coddington <bcodding@redhat.com>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
        Olga Kornievskaia <okorniev@redhat.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] SUNRPC: timeout and cancel TLS handshake with -ETIMEDOUT
Message-ID: <ZzdcEIOzKlohwzB4@tissot.1015granger.net>
References: <ee226061afc4152fb8c6a829565dc5af390842ec.1731678901.git.bcodding@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee226061afc4152fb8c6a829565dc5af390842ec.1731678901.git.bcodding@redhat.com>
X-ClientProxiedBy: CH2PR05CA0034.namprd05.prod.outlook.com (2603:10b6:610::47)
 To BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|LV3PR10MB8011:EE_
X-MS-Office365-Filtering-Correlation-Id: ee9b6c9c-f931-4d01-801a-08dd0582aeb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dXknNwkgFGwhH+D8G80FJX2B4HFIA2urbgR0ZhSlUeYHqfou1STqahyB4xnc?=
 =?us-ascii?Q?ft1wv7ioN7ymlhsJboOqRpNhMw8L8zToWcPWbma4r2NdN7auAWnE5j0nITbd?=
 =?us-ascii?Q?kZKslG1hA9sz39k9IWv78TnpeEvCvQlXlnUE6b9s+MP9d1qBLOlEMgDmOYF7?=
 =?us-ascii?Q?r8E4KyTULhz6PQzfZCRmvJg3OG9lWNh/Lh6BRTQrARq94MOtG9ZRpvYqsVyG?=
 =?us-ascii?Q?5LItFzDsf0c/8k9rVNjrw9yOPgt9988kmd4AlH5GT11IiLdsTt+mnWK+itwp?=
 =?us-ascii?Q?fSHvcQM0D8qXI4207rH6l3/g6+9opbRCNHPAQ1l4f8D0dVsZRal1Jg/MdDyz?=
 =?us-ascii?Q?HnP7r7IY+g10h2uvW2+T1nnOpUvZaPl0IbjhJNbUQjVEldgKhbWPIJM0Fkl6?=
 =?us-ascii?Q?k2QDJ3U7p/pTpDzPJ5mNuGG6o/WDe1/W4CiV/f2xjhaNuwTT2VUNvDX+u1s5?=
 =?us-ascii?Q?88ToAFFw5FEOwHfj88Hf5x53ormk3glIv+BYIQgrSgTNIN9XHvgxWl8hqASq?=
 =?us-ascii?Q?vcMeGfEE8EXLw0wJCqddIyLvNrP4JRq0wrjESHoNAXzeaYInuHTNRvh+kGMH?=
 =?us-ascii?Q?jdzSmSLlStlLwwRMpD66osAOdLwyVeV/key4ugZv5FawCYh5uUSk854ox+ZS?=
 =?us-ascii?Q?HatG4divy97o7rtLZjcGcG27P6Ah47PIvxS2It3jK8ruo3nsyqCKFQKGz+iN?=
 =?us-ascii?Q?moHZkHtjFNyQCak3B8i1m57OT2T/Idl1V+boZ/BmWPhw54BLn4PK1BP0YmVp?=
 =?us-ascii?Q?MVKOYTDBZVNXgVIg1tCjFZr1q4S3w1wuFBJ4s0pV93jxl1JTVi66az3zZuAh?=
 =?us-ascii?Q?bSDSZcV3Tq9AB0rsN3ydzs2tofuHr6I+2z7wADVl/7ftlb4ohMnKrmgHHJ7j?=
 =?us-ascii?Q?t2ln8A/lNIR9SeyrcW8QqGquHbk3nNuqvHFej1t/40ofVXPKqOk7kSLAmvhz?=
 =?us-ascii?Q?8GtpyGiJFlxEdsVYzmePD7YB62Mjp0QrwDrKJQIG0bhHQSkJu17kLjPCBnsb?=
 =?us-ascii?Q?WBnqUBVxBY0am4D37jqe9MiiXT4T9vEWSjKg8AEA2jSl+tN52T2Frwyjri7I?=
 =?us-ascii?Q?GtF41jIuF5V21NzhQ6NGsRG16VwplYiaECYrTxMsfpO5x22dzKMyHQH2FAJd?=
 =?us-ascii?Q?vT5TVyV0VDHBv0YiNGm83wZ9wmCe14KEX7L7go4mTdlfFAnyOjoUkwqAPyXG?=
 =?us-ascii?Q?Ifwq7BHZu5XeHva0Z9fHyPGQg5g1nvZh8dtFRLxrrsLhAt13fSwCTTYYasuW?=
 =?us-ascii?Q?AhlhPRT6+RJz8Y570XJq+xIaHftpvBubCMjs1DItz9XX++l0fNi/ko8w7itj?=
 =?us-ascii?Q?yRs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mmZq+vsxTLVzw2p5RTqh/NTopiKXBYY1c5uv4CRiF0Y3HXjaRTrd5dBfcy6D?=
 =?us-ascii?Q?9+c/wX6ycyvn+ClPUmJAoIO/biqJQONoRfUPHuyi1hKmFUz1QDNMVYpIXAFD?=
 =?us-ascii?Q?8Qkd1heVpG/T8v/J5jwYdlPnOvGxqWhlklpifsgSpj7PLb92wZluo+yNHGFK?=
 =?us-ascii?Q?lHAMNPcwi8D3vf+jJXp4YtROVZk1DsEpF2H9sykH2DqYqNRBCrpYVpYcgbMA?=
 =?us-ascii?Q?FcWBTHB/6DKQz6VnVhFi1rqShllouwsjb3CssFpdx9xcVYieSsGoSN2EDg8Q?=
 =?us-ascii?Q?t7WYpu9oe7OSZ0n59wcvuiDRwZp8iH6yx5S3YLcLSQeALtE9El8mqgJMjCUF?=
 =?us-ascii?Q?HrjbsTvxINxV9iK6KwMQc87w2xFTV9Q/jv1b6ndKIFC2PvVsNFnskS3kin4k?=
 =?us-ascii?Q?Rrx8/Hcs3PR+aXvwGqhK12sCZH4GbxmNe2ZxCKolRCRwzMV2hEEXsFEbancs?=
 =?us-ascii?Q?Iczc6Z/L02pJTMfr9qUoE4YgQcTGJ39kmvSVXDm5E+uAo/1DsBOo66qsym5+?=
 =?us-ascii?Q?8anpVz9ILXnf8cH0jCrQjzNphs64vhpxakqUwWMCtKaz5UUKk8KhStv9xM5V?=
 =?us-ascii?Q?nX0Tv1t3htYLnPpRw1KRw1/g35PUOMpVn71I8rV48jHhG76Hr3APv6qftPf/?=
 =?us-ascii?Q?9fJ9RjYU7pYsvlviz5xVX13E/Km+ER02eauIVJeoMbt/P0JtdfFbWfEYhbNv?=
 =?us-ascii?Q?OkpwqMcfp/drVWDD63TEfo3v7znM7jGRg92DdyYqbc+vZKzQ4o18dhcFUaL0?=
 =?us-ascii?Q?VgmW5K909xyg5OufiRFkutGrkhQ6RBNC09oEvRLdJIVnAo0UM+wytiGqLYkS?=
 =?us-ascii?Q?DaQ7qnOT8jerw21QZgmFD7d7l6oWgO36HgxMXNTV+0Shpw5DxIU72d8r4SVF?=
 =?us-ascii?Q?D70Cm3k9PDl4kB34mOpOMsvdI1qyqQcaJjT2DvoTQe+uVLedzK7l9ingXvyP?=
 =?us-ascii?Q?WwTEdwhILbWthdrJ1xWHDVP/bW/XIDPpouxiFRVyKM1pUSmBg6tZ7WE4RFjN?=
 =?us-ascii?Q?NXoO6j1OpLTHRtlx7Ik68F/OCMs1JWGcyUuEDOMHcIj2iqjwpmbQiqaQ0vfE?=
 =?us-ascii?Q?u8/8nkgc1O3xB3VFLwMfOynkNls1oaZsZr0SH7l3bqwZkKcIH9oCw5b+Fq8T?=
 =?us-ascii?Q?YcFkug8Ur6Hg9xCzukZ9Bu+z0bu+NSHehWDM02kXFMWwGcPM2TQQFd+/gvfc?=
 =?us-ascii?Q?5uPaa9ds/EYPbo/nORjKMrlqTRcprRSXpRJRFRe8zSSF2qB4GW+RD6b3UrDO?=
 =?us-ascii?Q?7/uE8thXFgibNOZ9LvtdM50yf7Mw5Yy4CQ9O2oKPNv58uJlT5jOPHjNBYL0q?=
 =?us-ascii?Q?q25gMxMFf6YcyIuHDyC5R8MYIVDrHMx/N+4mMhPS00eYgyvZj4DCgIgEncWE?=
 =?us-ascii?Q?KiL7bU558XbcJZkqr2Wl8JWz6CNebMRZMNrwVS+VqOS0RB01GncAzjauHoTM?=
 =?us-ascii?Q?kdX0dMp86pChp0aNl6voafJNE22CVa+zK5ic4NxxNpA5z9WZ+xnPtYJLhNcN?=
 =?us-ascii?Q?IhFUqkREwKbCYBl3bZu4k5aqEldJJKnWnjwKL4GkDbI/Nl66EyO9dbJRkJ42?=
 =?us-ascii?Q?ved83cszxqSUTcJ6mGSROEvN86NCz/OKOoPce/tm?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gvmylwlskYnEDPWlQY59PO6jvE6ymah7J8QUsD9YMR+367YVSoBPtriCdlbtXHlXzEFA7F6a5eUuVfC4H2xDT8Ym0QJYmH9JqPnChRA3Y7cBkoAeDl0yC4M/hwMmIgnnImK4F7CjxR3/pqYskZmu9GUjAU4MfbWQAjYOwrW62Hxd4aeF0tveVqjWQnH0otHHd5u0K8+XoNjzljQ/NRWU79lD2ZcNZjdU62Z2RyC/aFBQlB//qmJjAQtNQ4och3pbPwyHhLp/Tlv3s6o0JW7tNUVV7JNDAGercqZaAs1jmOzgDsX0P2h5LNBLo2VieYh/LmcCayijoA970fbdwnZgZEGfyg5vut80NAz3vrEHyHKZFOksXZ3TEH3LH38OzqMlZ7o1fbYmeDgZOK/Cq9cx+loIMZa7Fj0I8liYa7DTmWdYEJWcarIZqCelyohLje3xohuUznlTtfqXnfJkeGpJK8Dba9jMNWKWRkTwzSNnDzVJhkHR74ybKIvDV0n32lE51HfHpcMKGgIzcmrBZsi+AwBRL8jEitAKPbH43/3zPfFwiG3Rwwrwx2vb1vd0mPwoffmarOXjKZps+pLM9XW+Y2+0/NtThJkKesEb2qwANOU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee9b6c9c-f931-4d01-801a-08dd0582aeb6
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 14:34:59.2942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qRHXHDmLbe6w8e1CIcvLQ2A8Ij8ym8UjKx8V6gCzhG+PY9zWNqJqtBR4r5fvUH5bhm6RWebbf8OunjCCUqnt8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8011
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_05,2024-11-14_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411150124
X-Proofpoint-ORIG-GUID: 3fjYLpxz9ErtPshKd0K4l5XNPE2GR79F
X-Proofpoint-GUID: 3fjYLpxz9ErtPshKd0K4l5XNPE2GR79F

On Fri, Nov 15, 2024 at 08:59:36AM -0500, Benjamin Coddington wrote:
> We've noticed a situation where an unstable TCP connection can cause the
> TLS handshake to timeout waiting for userspace to complete it.  When this
> happens, we don't want to return from xs_tls_handshake_sync() with zero, as
> this will cause the upper xprt to be set CONNECTED, and subsequent attempts
> to transmit will be returned with -EPIPE.  The sunrpc machine does not
> recover from this situation and will spin attempting to transmit.
> 
> The return value of tls_handshake_cancel() can be used to detect a race
> with completion:
> 
>  * tls_handshake_cancel - cancel a pending handshake
>  * Return values:
>  *   %true - Uncompleted handshake request was canceled
>  *   %false - Handshake request already completed or not found
> 
> If true, we do not want the upper xprt to be connected, so return
> -ETIMEDOUT.  If false, its possible the handshake request was lost and
> that may be the reason for our timeout.  Again we do not want the upper
> xprt to be connected, so return -ETIMEDOUT.

If false, it might be that the handshake succeeded but the kernel
missed the downcall. I think that means the kernel doesn't have the
handshake completion status, so it shouldn't assume the handshake
succeeded, only that it finished.

Reviewed-by: Chuck Lever <chuck.lever@oracle.com>


> Ensure that we alway return an error from xs_tls_handshake_sync() if we
> call tls_handshake_cancel().
> 
> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
> ---
>  net/sunrpc/xprtsock.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
> index 1326fbf45a34..95161a8cd138 100644
> --- a/net/sunrpc/xprtsock.c
> +++ b/net/sunrpc/xprtsock.c
> @@ -2614,11 +2614,10 @@ static int xs_tls_handshake_sync(struct rpc_xprt *lower_xprt, struct xprtsec_par
>  	rc = wait_for_completion_interruptible_timeout(&lower_transport->handshake_done,
>  						       XS_TLS_HANDSHAKE_TO);
>  	if (rc <= 0) {
> -		if (!tls_handshake_cancel(sk)) {
> -			if (rc == 0)
> -				rc = -ETIMEDOUT;
> -			goto out_put_xprt;
> -		}
> +		tls_handshake_cancel(sk);
> +		if (rc == 0)
> +			rc = -ETIMEDOUT;
> +		goto out_put_xprt;
>  	}
>  
>  	rc = lower_transport->xprt_err;
> 
> base-commit: a9cda7c0ffedb47b23002e109bd26ab2a2ab99c9
> -- 
> 2.47.0
> 

-- 
Chuck Lever

