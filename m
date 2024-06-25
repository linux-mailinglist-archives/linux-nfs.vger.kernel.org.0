Return-Path: <linux-nfs+bounces-4295-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2508B9169BB
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Jun 2024 16:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47D4A1C256E5
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Jun 2024 14:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3168416B3A0;
	Tue, 25 Jun 2024 13:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="C5mA9Q52";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jmtesoHv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E91E169AE3
	for <linux-nfs@vger.kernel.org>; Tue, 25 Jun 2024 13:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719323990; cv=fail; b=aTD8XtA4yjCV3FsO+kjAEowygczVY80VRkBYPeOQw/WylQkM6LBe26Ka518rqAfk98P+DWbyOK8K1zFc8AoUH68QMY5MuiT61kZfAbaUrz1VSlfPCNv7jxS5/4H1pHcu6p1x9ovJzXUOAsvhYCFieVScSvFVxjoHkhwdN4F9VJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719323990; c=relaxed/simple;
	bh=MT9GzSGpYQOwQXCpujtAGOPJbZLqlWhGu6LCmjLxhHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hElO24gOMUEd2NaVCyg+x3P5UvtDoAfUrdW5i+LgnJEtOX06LN68G10ni3Fv4UT6V5uaPtZstSKpzREyyyqAf0awnzzb4iLb96whXexd/0yorq5u6v9RPfadNBxnxesMtq//t2sYq7CyU45yzJItdjX/7E82Vj9FjNk5fZQqDHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=C5mA9Q52; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jmtesoHv; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45PD3a0Y022442;
	Tue, 25 Jun 2024 13:59:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=qemtRGcgBoGWxPJ
	JIJdm446y6dgiDT1NtKfyMliRFog=; b=C5mA9Q52mWyXiee7B9hVLMNm65wni+6
	ZVCrWXxKCvq9lg0gu9B/4cVRbwBHS4HM59Ptou6G3NiygOYlauUsnIttSmaJ6gBu
	NN44ZPOe1sTx9q6ENGFkFCETWPVqB5H1JU+OeixywiT5334EG/BOGZiS/CLy+3X9
	nLc1hSwA6DHVw2SXLcGvtoY+QGp935cJWWu+tEAj5HzFfseo8xnjDejwtSI0y6M2
	gpx8C3aD95o9dSIBjZAIvVxtBYCTMr0DDIhAvtsjxavo1bNRTBdO8TqyoTDp+prL
	fPz8XOiDAiievrx2MlGHzNXLwWSsit002tZSUTojI7XnjeoW2rdqc9A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywn1d0mnf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Jun 2024 13:59:38 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45PDEXvW021560;
	Tue, 25 Jun 2024 13:59:38 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3yxys4guns-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Jun 2024 13:59:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bIrFylRISFCmy0HatWvIzybPruz/uN7+RCsKJjNk3qzK29ZX+PkLJQp0MNrW1jHtuH1HhgMkaB+3+q1Qkl/t86coDx+CsdW+IfyCL3eb5LnRfbT7hpIRWJ2BJWEAaORq1ytfsyXkK+/2acYgdrqym7HEhuqcb1InFVvgoWqgpau5HYwz3PAWPKCK7fCFDN5mZc6NKRqW9Q/qlpIYF6MQGzOVcF6ewFHwsU5+p/wiyv/OHAuL6GVxKYpcUtbbLV8bDjcRgZBGgLdgf1cP1T3gdVfNGMJX6YEDZNOvjfHJkih6vfJz9/kSyZQu13KgAUWv89kA7kIa50pF+WtRcU68Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qemtRGcgBoGWxPJJIJdm446y6dgiDT1NtKfyMliRFog=;
 b=GLYOSudH6FX0dbsm8e+VUMrMlslzQVC9jTgpTa+gZjWu1qPNlau3bGWqo9AKFPJpl1ArvLZ0C4og6e3/+ejGFTeA5pvxg8jg6YYUAJQzXDVTTlqn7X8O5flQe3zwAnfAAFukd0XgOIedJy2W65lyZuL2D2GhPpjG/xfa5q7gcvVfzShQrc4VXgUXDkOW4cxE3Ke9tuHDCZRN79wrgWMS0LrxfPpxOLU/vN6P9PlRUFSg8+/Kx7IvcOkWe0SeCHvI7RJ7jTbCDZbPgOXSxMvdhT66Vfdy7KboPe/wAsaW8d+1ioGsRkICRQpgCjcZbigF41BtrdtnikSmZieaYAbmQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qemtRGcgBoGWxPJJIJdm446y6dgiDT1NtKfyMliRFog=;
 b=jmtesoHvJhvvx03y5qYmop27/uELRXeAYZtQf87egxsXQ2uTiNgPlhJXgYoC27end0u5mbofVMxlsfel07Cd5w8FzKzyhKf31UptyT2PhTe46TVpv7v4w+MMttTyGNU04CwsTs/d1HJeu+Awf4qHHtxem2COLxXfuQyiFaMW6PU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA2PR10MB4617.namprd10.prod.outlook.com (2603:10b6:806:118::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Tue, 25 Jun
 2024 13:59:35 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 13:59:35 +0000
Date: Tue, 25 Jun 2024 09:59:31 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Mike Snitzer <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>, NeilBrown <neilb@suse.de>,
        snitzer@hammerspace.com
Subject: Re: [PATCH v7 06/20] nfs/nfsd: add "localio" support
Message-ID: <ZnrNQ4dEaCYVXZDa@tissot.1015granger.net>
References: <20240624162741.68216-1-snitzer@kernel.org>
 <20240624162741.68216-7-snitzer@kernel.org>
 <Znm6YjFetA6pG/5W@tissot.1015granger.net>
 <ZnpOUiAhapJaRMXm@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnpOUiAhapJaRMXm@kernel.org>
X-ClientProxiedBy: CH2PR04CA0023.namprd04.prod.outlook.com
 (2603:10b6:610:52::33) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SA2PR10MB4617:EE_
X-MS-Office365-Filtering-Correlation-Id: 4de1b9d9-d034-49d9-4b70-08dc951f0bbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|1800799021|366013;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?l5icb4S4zdicjJHG90kCsw+djhk92GV+JibsLRJhh3DMYrb6a2iIyIKltvLP?=
 =?us-ascii?Q?ll/i8S4HKyOBxIZYP06XmEoHn84BPTvZEBpUSnFxxWY7UeVSGQgiFKtcQyPh?=
 =?us-ascii?Q?EDar7hNp6YoPwJV4meZJtTClW8nzU6BZ1in7UWh4K7MGUyjK+2zZuVdLIeRc?=
 =?us-ascii?Q?dqhdpYoi7ktHSWr18vdTFXSsXidcx1gQEc68HQun5kCTGRhjL5LBUdop2laf?=
 =?us-ascii?Q?PBsQKh7brgkwAX1TRGa6nId6xkne3vDAqyg1lRz6aTWcGSQzXSHpwidA0iD0?=
 =?us-ascii?Q?sME5/Jsh5o12PJXpge2p+2ZjxkqQ3FF07tofN5modLTNtwgaDATJRRjltBl9?=
 =?us-ascii?Q?nHYot+sb+deAbQAwX7rr+rfQ6rpuDdIfQzGK3ziYHo7RGjWRTczid6ntHjAU?=
 =?us-ascii?Q?PHn08+TNnJB66KGd4IzC6iN+uN9VvojRNbnruV92VMGtu7i5V2YcgX6cExlM?=
 =?us-ascii?Q?WUJiwJdtCvyVsWKTStgohTBBOTV6aM6EEROA6FkZ+5fvX+xS6xcGqM0T1oGm?=
 =?us-ascii?Q?5d+UZLfObHazAvLiYKkJlS1YdgDGgIkXWJdKRpn6IBJY0XYTicJGOKHBY3Y/?=
 =?us-ascii?Q?Xb9x5sGayWBQW2jsKvvQtzR1QCQJtN1IxS3CE6lyj394WHO3N8jRY7YrG2s9?=
 =?us-ascii?Q?SGzcz0e5GBgBiVky2kTxLWYhntLvSAmw33t0lx+QLGmq8atSUuQ+7/hpPwvi?=
 =?us-ascii?Q?v9ooGhrKNz/4UY+KjDwHLI4CLkUbmzEmJ+iJ4kPc8x+pUBzn4oolwwERXt9d?=
 =?us-ascii?Q?D5iJAAby97Kh28zNFmdhmFfu7BZekaS3VjD2trBHjkVSgunzVqawh5dBnztP?=
 =?us-ascii?Q?UaQ+CBPxMxFPfh3SYaoK/SmuQzHKNEekEM6kmmpITnLwm9RuKpdiTQ8FWo2a?=
 =?us-ascii?Q?fDyMDppcRFQReJ+E5ImnmG5Jo/HZ1LtyRt64rnYExyC3/Cjl5ALqko8NEbGl?=
 =?us-ascii?Q?wLq5glzsgIuS6JjogU0kdyOSsIX+0oUEpJSDkTLZO8XfTlyWbx4JaF8/bjlY?=
 =?us-ascii?Q?hEnv8PV/EDJOsb2Hy6Elwd4NnJ1ZbixMaiUmaGRO8UKeWPOcSqH3l7BwPi0m?=
 =?us-ascii?Q?RqmdXBalAzehVpXfLZnzHvA0ewYL5OIXrdBV61cb1jlLmhBdAzz+mTvVUBlF?=
 =?us-ascii?Q?L4g5NS7UWNS50SAKCL0t6fuegTWgSYSVAHsE5CGKCsgq3TxjPbXYimWcDr21?=
 =?us-ascii?Q?FY7PTH73byk9Bmx0fKivMqb9sAzFMOjYxahbjIJL7g3VHUARNdXOpFYSQWWr?=
 =?us-ascii?Q?6MlLQ0pMC3o7WIGIWY8kDs/Oy1ZYLmqmV4A9Yo2bvqO0IZO7D4P9qdvFsaU+?=
 =?us-ascii?Q?sl8=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?+tQqvGDLFLAvTb68xa56cGNYwuTROBt+0rOXwDKrPcrP42892QD7lixKiqnL?=
 =?us-ascii?Q?/g0hp9iOeRNhYcVnMwNbe2H2/P1XJ10Uwv8xabQb3yau/onMgDIgRaKUKP/M?=
 =?us-ascii?Q?9tg0F8PGfU2RMSZQLPGBmjsnso2hqoiZHCsB/8CJwRIJwhj9pz9fJcTgRgAF?=
 =?us-ascii?Q?S0bMISQi2UR8YlqS1zBUr6HwYHc9WSRdRZaqpcs0CEQfUwI28lVclsJ8qK+u?=
 =?us-ascii?Q?vUO6c0MagC0UuALV0fKpYAgP1hjypfx4emjotxWyteHtss3EQYkxCMoVDola?=
 =?us-ascii?Q?HJY3joMnh3O1sItOb1ndIH13Le6iZvdqNezaSSXnS9LNqUXkH620FqMFi3u3?=
 =?us-ascii?Q?C542LgRmxWXReks4AZ6GyOh45ll2LiyCxkNCAq452AHFuri64rLwYx053+tg?=
 =?us-ascii?Q?fqW1oVzUmdRiCYPRC3E+Kngi3xC0xFSFnPeCphAqPq5DYFrDdu0nmaI2FVVi?=
 =?us-ascii?Q?G1V7pJDrY9jQ2vIWx5VCvyawvzqy8PqHu9CjNg6oT4NvZikp/nlJ1zROn+mG?=
 =?us-ascii?Q?9U3fm4SPovMIbyayIjcDcO+FWsNVwCtuT7IfOyVHUFdjZJ8OEPC81LaSDilz?=
 =?us-ascii?Q?h0v3PrXgLP/e2IoHb6wo3ujX5fxsoFQxACnZQ90RtXKYtpOqVmNUXX8rUIFb?=
 =?us-ascii?Q?saLKfMXZEIYWVfSe8nFaCk9klGWuD8sFyCv14wBDLC4Je3iNdzYtDKDXyoyh?=
 =?us-ascii?Q?LQPkC72Tp4SqDkZ9AIJLCl3kKVQvDDjwYJ5KZB4TNjOuBVyFRndtS2eZD+Up?=
 =?us-ascii?Q?Zk8IyE1QPKFhB/jLG1Q+W482GODp3i29aJzQTC9R8r5QQHeond/rHMmC8wHh?=
 =?us-ascii?Q?yfyH66Tjip6u2H3NAoynuZe1YA5QSV2b/xRrhcv7cNfJLcxjz/yCPyG0ISof?=
 =?us-ascii?Q?TAC+iIf7pdefGM3jMWybPMYLAFZAXLuV/uBdYtF4tRkkMfuPhTNyGUy2naFr?=
 =?us-ascii?Q?o382j9tFwZcSJ5SBy6tzIZSxvhlh1Fjfj6aQxpELlLu+63FWcZD4HuXWf/uG?=
 =?us-ascii?Q?bqt5WipiYnzVhk0XUKj0vgwoe+6HWd+Wb5a97SBHqwsWZSeonb3tPvNXCzhQ?=
 =?us-ascii?Q?ebogAd3/lsSFC516EgGDOhdzIF1EFk+kvUZkr1pjCt/FKlJ6W6oEmjeK22S3?=
 =?us-ascii?Q?3NONG1j2REt5jQ2x6VKXuJs3PKhZ8zK2dDpGlCBjJ52xTVEbxmIiLMyg53Qe?=
 =?us-ascii?Q?PAyFGtTUKf9GjWs3y4VjVY2QdNSW+aWKp/dQ85TZa8HHaRvUl0Qth3ZyZmIN?=
 =?us-ascii?Q?PgqudNO/NFQ+IxvaJVDK3rKIeE1GUcSXk0D4q+uRSqjJ4+f2PkvhB6vqZtNQ?=
 =?us-ascii?Q?mjp2pTONsNTtPhGXXP73YGfWbD8HgF5P68XXBvAa0v6gmtGKVZcUTL8z4kyr?=
 =?us-ascii?Q?PTt41qKnXmaZ9IWyHl5R40UGSYlH1ilMO9F/0SbevfcourwCA5FlpaO7xzoL?=
 =?us-ascii?Q?1TLtuJuZiumkymlcMQodtSBO3kfI27xWifYnxy+kp8od1s4kv6UXO+S6LaBw?=
 =?us-ascii?Q?dzNjM7/96vO2R3PPBCXI0CbQGz4wJJ+FBGyj+VYTbyDqU7gem0ZraKVwn4B3?=
 =?us-ascii?Q?jqNRpfpGIQqIqB3uVvObWT7OyqVxF7kYhkyAXNkajDhwkL3zwyHCH/02Flvn?=
 =?us-ascii?Q?PQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	kAo4TG479COBuHYYDb5P0a0/Kw+/7KguWanAddSgNQpvfZKs1zWWwvsRIbCaoLEQWHOj20gbfQSEBhACIRHP4skVWKquAjyxdux74xZHH4JN3GGp4yULo19vYElKKJ5TnMg3TcJUhIhhj0R2eIR2qrsbdZ4i8fSMms4vib+VPQWWOUlvGRbWlOgk6AlI5SfsGLGPhBqeDSb/QoaYk7ZccAzY3nxGHQl9rnw4zsiheJNifUfEskRMTez9FGC5m22xXEqWV6POF275RBbsRmzSx1lICoo3DYz1BxL2R0mbK7cjRajN+OF6868QZvGdJeyGd+ZGof8DnAHOokavYi6kTrGvNsuEyNXm02/odlNemIf3s5oTJd6OLrYz8P+Zh4sIf8y+21sFsgaWasChZ+oQgg+UFqx9rjuJ8dYKxX47SBDqf575VTEcYldxIrjfKzqfKzp7xCpFlxofSKTGV66NO4FjDAGgoHrbjT3gWzQHR52IkKOoklUthl63hHBzFsPnduS5oDOhLg5RjKvfVrBuJOvkT7v34Ofd4Z0/9NjFTRMYk3tGlrRokOZ9S5BIYWtTr4xIokkWC7/90pMfQwLJWuQRBBLY4vHN208pG2dE9AU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4de1b9d9-d034-49d9-4b70-08dc951f0bbc
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 13:59:35.4502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iKAKDqxneG5/Uk0tXZ/tTOUWksEZ8/1sYsDo0IrfLSppiaJ0UnVK7TfuN14v5/5DSpj7TjAwlZ8Kfcs25B2bkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4617
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-25_09,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 suspectscore=0
 bulkscore=0 phishscore=0 spamscore=0 malwarescore=0 mlxlogscore=829
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2406250104
X-Proofpoint-GUID: eEHbwG3SAV1hfoNFyn8MP-MAl4A9F3wj
X-Proofpoint-ORIG-GUID: eEHbwG3SAV1hfoNFyn8MP-MAl4A9F3wj

On Tue, Jun 25, 2024 at 12:57:54AM -0400, Mike Snitzer wrote:
> On Mon, Jun 24, 2024 at 02:26:42PM -0400, Chuck Lever wrote:
> > On Mon, Jun 24, 2024 at 12:27:27PM -0400, Mike Snitzer wrote:
> > > From: Weston Andros Adamson <dros@primarydata.com>
> > > diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
> > > new file mode 100644
> > > index 000000000000..e9aa0997f898
> > > --- /dev/null
> > > +++ b/fs/nfsd/localio.c
> > > @@ -0,0 +1,244 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/*
> > > + * NFS server support for local clients to bypass network stack
> > > + *
> > > + * Copyright (C) 2014 Weston Andros Adamson <dros@primarydata.com>
> > > + * Copyright (C) 2019 Trond Myklebust <trond.myklebust@hammerspace.com>
> > > + * Copyright (C) 2024 Mike Snitzer <snitzer@hammerspace.com>
> > > + */
> > > +
> > > +#include <linux/exportfs.h>
> > > +#include <linux/sunrpc/svcauth_gss.h>
> > > +#include <linux/sunrpc/clnt.h>
> > > +#include <linux/nfs.h>
> > > +#include <linux/string.h>
> > > +
> > > +#include "nfsd.h"
> > > +#include "vfs.h"
> > > +#include "netns.h"
> > > +#include "filecache.h"
> > > +
> > > +#define NFSDDBG_FACILITY		NFSDDBG_FH
> > 
> > I think I'd rather prefer to see trace points in here rather than
> > new dprintk call sites. In any event, perhaps NFSDDBG_FH is not
> > especially appropriate?
> 
> I think NFSDDBG_FH is most appropriate given this localio is most
> focused on opening a file handle.  (The getuuid not so much)

If more than one debugging facility is appropriate, consider using
dfprintk() instead so each call site can specify its preferred
facility.


> I'm not loving how overdone the trace points interface is. in my
> experience, trace points are also a serious source of conflicts when
> backporting changes to older kernels.
> 
> But if you were inclined to switch this code over to trace points once
> it is merged, who am I to stop you! ;)

Have a heartfelt conversation with yourself about whether all of
these dprintk's need to stay, then.

Anything you've been using strictly as a development tool can be
considered disposable. Anything an admin or support engineer might
want to enable to diagnose a local configuration or deployment issue
is a candidate for staying in the code. And so on and so forth.


-- 
Chuck Lever

