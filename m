Return-Path: <linux-nfs+bounces-6677-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE359886E8
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Sep 2024 16:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D4D72813C0
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Sep 2024 14:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A119191;
	Fri, 27 Sep 2024 14:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Iz6mQcdA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Y6s4iD0/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6BD74BED
	for <linux-nfs@vger.kernel.org>; Fri, 27 Sep 2024 14:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727446770; cv=fail; b=OQsTwx5VtVsf7jZz3uaBRv3vDiOwgGU+6P2eRu70lDY2LbvUHRP4YAi3SYnVB6NVpk+Kmlrui+NhzjWqnhsFiYt7EvuNidaHM/tcSePOd0wM/xkCKKdXJUFmY0Bl6egZIJoKQKxm8npXGGTsDce4tZ/ylQXMyr5m9CDx1rMVA48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727446770; c=relaxed/simple;
	bh=i28PQbTGb9SzuvELg/ISXrR2rblftcqCdyEa8AGnDMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OuuLFCt9aLn3Qw0jAZ2LnzJI+BeiAxw8GLiVzFXqcqxnDk0zt/MHQHWXep7I7Tik8mb4cSkX5VGEGy4h5XIsdWmpJwpYhB3vMV8GRdX1MGvbrD4E3Ay0RpSuhpMlyYJF3q58iBpnls9OvfG5kHEQDUL8UW6D7POcD8GZ6lgtwPo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Iz6mQcdA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Y6s4iD0/; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48RDOpjn023430;
	Fri, 27 Sep 2024 14:19:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=lAdnOe/NtTrRzGr
	xrEemCzY/42C4PlfOAMQHDbeZR4Y=; b=Iz6mQcdAi9ScSkEvMj5cWrNheUT6Fq+
	abSQ1EYh0YxrzJpKJ06MwhEiocU31avI3G9VxefqYrqFxLecJjCV3yrN1xU7g4VE
	8vucdv6cRvJL1ZyqqKWbJeNyz7FKhCd6BOfaShlVE6J34XfS4/+tlad4wDglSWLq
	qMObavS+GLeRMQnINbBeqQqgC6PHBDAdbs9oQcACVvBqiSkqZxm/bsYXddfBmVQb
	2WbkbiRbGWIUv2g4VoYgiuEVIcfwLdfPW7FHIuXHyHBCqoXNgRwyoIaxGPneJQvH
	hjUtbKozXY03562xzjK81ousOUubz2y/nSpXFXTIUNVf2hUwbosfG+A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41smx3dawg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Sep 2024 14:19:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48RD0lX7009708;
	Fri, 27 Sep 2024 14:19:18 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2043.outbound.protection.outlook.com [104.47.70.43])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41smkda63j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Sep 2024 14:19:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E62bXL8n4mH6ulYDzdu9QzG4YXwDKV4EJr/b7vDZZpdbekCQBNfafBH4ZZ08Z1QXbsr0c2+xxqNIdtcrDZBMZmjCt7AQKTeyc4yK3IhaCg/tdBCBf7zpP1gJH5+LQ3/q9ObOd5HI2uMFU/TH1XVEL48D0/Ibmmdl/rmQEkge61CcLPd4pz6kUuYfMjcVjQgXvRUIJWulV5LG6UxVBxXoxG87idSRd3Nrrxz/jv2lYhVW9GHepzObboGQbAwFwWPK4z1etPe5PiNwyHQLD60T5mDSBRYfTAvG+Hgs/Mv7YuEGdiKV/1iecH289PuVweKmpBc67yaLDAkRydKaoEhzDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lAdnOe/NtTrRzGrxrEemCzY/42C4PlfOAMQHDbeZR4Y=;
 b=HKW558RC5I0u7mx0OepOATybh/YD/ZlUNp8CShCV/+OfvkLzdYuEeCItPIJGw2x456VK9YBVFlfXQvHDldp3xGX02nWRLXz5c4wTxnnqN0sx2B1sgy2p+TbSJ8KX4OuVa9iWTBn5ss1uv5zjHXN/XG59JvMLCc/MqzIPF8HP2NfVKYAbl5jLNLCvVuw2Z8FcDGlHe7OimMBakjP/X+rMxcpDYdmcT+PQnW2eNkPBDYJncdrbElXg1vo2m8syd6vqXz3MOFqadisrU5b2s6fGxl/o8R63E1/uTphvCfvcv8zUZNq465kVKJoLgsR/iS65zb1yKjKfjjvhwuuViRr96Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lAdnOe/NtTrRzGrxrEemCzY/42C4PlfOAMQHDbeZR4Y=;
 b=Y6s4iD0/WgsJ92iJH+XA89i67n/P+R2C4x1l0vWLcdCV/hn8j6N4w1AkGi7Y217l0Est+dKBHSmLvvU7xviSeNFgpQ+rO3KKrbvw7hIviBanwws+e8aK4VH9yyxmbquEWRHS2FPOYYMWX8A3U58Z9kOYlVYWEB/wl5lBSGVAyJg=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH2PR10MB4325.namprd10.prod.outlook.com (2603:10b6:610:aa::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.9; Fri, 27 Sep
 2024 14:19:15 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8026.005; Fri, 27 Sep 2024
 14:19:15 +0000
Date: Fri, 27 Sep 2024 10:19:12 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: NeilBrown <neilb@suse.de>
Cc: Anna Schumaker <anna@kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH] sunrpc: fix prog selection loop in svc_process_common
Message-ID: <Zva+4FotyYdXTpwW@tissot.1015granger.net>
References: <172741974136.470955.11402099885897272884@noble.neil.brown.name>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172741974136.470955.11402099885897272884@noble.neil.brown.name>
X-ClientProxiedBy: CH0PR03CA0080.namprd03.prod.outlook.com
 (2603:10b6:610:cc::25) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH2PR10MB4325:EE_
X-MS-Office365-Filtering-Correlation-Id: ac530fdb-6a23-4bd6-5183-08dcdeff5df5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qBskOvJ6Mrpvb7oy9MmvgEzlKhTtToB/9M6x4Yv5QaDia8ufZaMtjj0dk4Lc?=
 =?us-ascii?Q?4uLZ5lysXAW7qP/HdPaJKfxTpxYqefIplBGSyJtimcsD8x9un2zew59aTobN?=
 =?us-ascii?Q?Cao53vqw5xzjnWeuCLgd4A1ks8rnF26+ML8zDtsvFUjKnAmbX/KGFVmGlhMW?=
 =?us-ascii?Q?tlg95d1KxslftFj4EjYjDJoSUmA3BwIt8EkeF57ZJz67GMoEhHkT8Rc3HgSA?=
 =?us-ascii?Q?Q8gg12QXo0e6Cje29vYnaosEMjjI6VksOsKvtH5hh0kDK5hkL3PcAOdgUHXu?=
 =?us-ascii?Q?tmT/gIrzCnkuY2He1qePcLYb4z5DkPtn1N5eQfUiVy9M09YTEjji0j50Gte6?=
 =?us-ascii?Q?h1AJxWmrjVVXiEeO1AIGIk357nU+bV3NFaifizIamJPwah8WI/rTycaoq9/1?=
 =?us-ascii?Q?95N+USpBPHXMEG8F+KNfI5rPGn7ILeq6HzDm6IgoZ9fNz8rWrvALcfwKEm5V?=
 =?us-ascii?Q?IWiSWnoU+OiwYUdCcB2bprBkhrXEtxeBzkamZDxUdGHWiZ2pC5t18cXIJXe9?=
 =?us-ascii?Q?0nRDc7NxcHHhUL7FGm7whWnj71H53BJlhPcIYDsgoWVDhD1BaD0nSouC98L8?=
 =?us-ascii?Q?19hr5SKX/TccAGUptC9ax2U2B0bv4RwMSRbslOd9JZyz6fedROeNC2yCjVB/?=
 =?us-ascii?Q?Tx2bzjjaBMfVbUYuCG4fcszyuICjxbhtQwWnmvip0bpqbna3qsfVgGYz0572?=
 =?us-ascii?Q?Zfs6RO+oPIY1kCtFOWMWUzsJMwqRVgP33dxxj5EluUmDmVmBEbtVPnPfuRKU?=
 =?us-ascii?Q?x3HzYAru7cHMrE2pV+Xi5dam07ZlEHzaP/oagpSETj5GLUjOSc+kRw8WIqPZ?=
 =?us-ascii?Q?d29d9BECpgAG++8YLda4l1H8xz7YpoZFHojlXAEz8tB+YW7DspNCNXhI9qJM?=
 =?us-ascii?Q?4SzPOO165wIrUjz4oRmpraRcncAF4oCCZHt1PkCqxIWIbyPZ75CCWbix/iB8?=
 =?us-ascii?Q?avfjF52+g3689ob0/3jurHXuvqhH4ZjHPb83hAcMv18HjESiUz4cgndOk3nE?=
 =?us-ascii?Q?uek3g9g7x7kHOPNVgRGnCAWSDixzo4kwjFSM/3uULRzauiKDJIFbaCigTE2j?=
 =?us-ascii?Q?s0azy7gkTMp8Teh+TIoN2ej4Pj31LkOEE2Iw+9HuhPi9XdaCI5FC/Gd8Up1N?=
 =?us-ascii?Q?wy8I20BInEIFPM0/uvKxBtD7VJuOKDIUDeqhXBPmyC+d13jGnEvm0tUpjdw7?=
 =?us-ascii?Q?pMiaWzkRoPYhJemIa+WFdXlXiebMvYMZAhClAJmX9u40CBNY9iDTKCzOEEFG?=
 =?us-ascii?Q?kWkH/PfJ61koewqjHf4nh5jGEBhb57W7AQTWgctKCw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3Wg+AtjwDgoW+kcbv+Hwra0KeKXv3K4DURvwLImIe9qpO0BGTJWIKI3FCF0c?=
 =?us-ascii?Q?ho3n+4DL9Tz+us4Y3ZHfRIBi4/kURFsoeidPW5Tx6KBjcPMlYSOutKuhL+Vx?=
 =?us-ascii?Q?W/2YpCHIscf1pI0zfTfyWgb/SyPyE8/te89m+JTFGcxCN4L0yQAUX8sIOmDw?=
 =?us-ascii?Q?Ntyq5D5wUuOsc06RXGe66WhZ1TZ8p9OmId0jpbndPQwG/PvmD/9nN41mbMVT?=
 =?us-ascii?Q?LfERCUTTNa3LGdCqKF9FrdxLRXFHS0LsMGZSmWhTPoY+KrcsxPayKsTUvBJX?=
 =?us-ascii?Q?1fviDuE12OZ+KpZW+7Ke91LUwEQ3pX2RIWCWwtjOSqhe42XL5bNO92KzqdlN?=
 =?us-ascii?Q?rmCJd+Y8ChcdpwRrrVaAGmTRIvCSkLY+G4A6wlWD0Csu91kwUi76qibWbmkT?=
 =?us-ascii?Q?oOAvBJpMAUEFSaFFcDd5DDPSILb5d+5+p3pNd5McLpU88lxdwWXe35SvOL7B?=
 =?us-ascii?Q?FhQT6wYSJw5RahxLpaGT7XNM7tAVCXWO60t30npwRh5VYOiBC7TvRkl8iDaK?=
 =?us-ascii?Q?9EB8miM3BhBtygodgD2rBT8mvTJ4a/Mg9LMH+b2/hyg01UTyDbXHTCDNdyUO?=
 =?us-ascii?Q?DctYJK1uGqSU6YrAeIuok73qUZZ5G6boKVj+r1abwpcChvJofBIVdFIGGyVO?=
 =?us-ascii?Q?aN+7yjk340CV+tzmg6yqesx5O2vfLZy3p+h6Un0S5WCOJlZyiZRtnae3CFCl?=
 =?us-ascii?Q?xXE50lWg3Owwb0F8RDwbjOOsOtWYzDVdQ5RDQr+pKSSJpWL5FajxTMntHe1p?=
 =?us-ascii?Q?l89l2FXIEOdUlTm4cFA9KvNlixNpX7iV/digPZgScCtKi9YVkLof/lgIvgLB?=
 =?us-ascii?Q?QtGTEEGvQ5QDOtxchQzCG9wWZCA9gT/GKTm30FxZUpnasSAysU4cKAWL9kur?=
 =?us-ascii?Q?4Kv8lZoZMLwJYbPQbJtZ3wYmjVlYZlQ/jrpw1R6b7ocQpQ+CHaG/uUZRzuMU?=
 =?us-ascii?Q?L1zvQhRRXw6z7prlYUMNXrDBdRxhOMri2Fgj0UiBCj7NWIGU2IhUZkTfn0/i?=
 =?us-ascii?Q?ABs6bICzd3AGwaW3xrC402dzXRKqAElc/VuOrmHnwctQ5i2Wy21uDRvrncTQ?=
 =?us-ascii?Q?ZSloiI6F2RbwNCDZT080nqhTrLy9tzcMnG6j12GnrOmDPdqYxYSM0tMyRy7S?=
 =?us-ascii?Q?wYbDSPvtgT3ZwPg89gawzPQayamDDBTnFdBqQcPC9r026/RspHJPkgG3J2cU?=
 =?us-ascii?Q?LfcpTkD7L15iSw1S+t9pdqWl+S3hhSR8Aafwggq2/XhLKTUkGNcarWGC2g3b?=
 =?us-ascii?Q?kjq3SUARKgGXk5na/caNh0N8dPVP1Nlr4nTmbPFoVSVRbuu4ohSb+sI5d+QZ?=
 =?us-ascii?Q?DvwZNT4hUSq+scOD0s65mRe1PYh6qx0bEVAPe/5b6OP0bF57xw3o2BtBHsiz?=
 =?us-ascii?Q?+7O+Yj6yX2OYbXnL+DuQwXJbPDY8+CC6NcIqD4qnCIL0+6H6pka2o2p2tlQI?=
 =?us-ascii?Q?C+Ig91NekKyZNAxHZgwE4+2UPRETIlj2c6bNXBKOhB1u9WtICzttceue7NHh?=
 =?us-ascii?Q?dZ6xI/nNspAsoJTjE1U/hZ5T95SH2390PJY5EArDTp5Y+vRYsSvVxTZnXAzH?=
 =?us-ascii?Q?FWCyFrgGk0DFH6ApdmPdOxIrpWbHE5vDpghD3n0g?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	KGvx9vUU3xKehx4D7b+dKnW4kGL/L+hmz4XG0aoWqXGAT63z9ZIA1OtAv504vmM6AloLGWA6+smE3NW5I4MgbV/mjgT8wNUSIyn4LVjPkcNMoDmx6of2YfzvWp5oqcgHdUAinpLAwumVeq/5weELlHi/NrDatBLUBUmTlCvSNQuIjG1byfSRYwvHtnlf7P/zkCgw29GijxWntEmYz8AH7WrAILUZwaObXLVBlSJnAsHOpUe60PoE4aQGD9X+gP0dQTGMPVryYfbKyFY/dEBg8Wb04Gpgaytx7EgLrRl6hITn6Wx4kTtWbU9FOZRq/vyQRrT8p9BissjRJW/JUUpegUNvwrKoTjaTHVD59EHA9mhonsgUJIqqffDTK6z8sZDaAcEf9o+CUFQmQj43CXG+dsDrnK42bLSPR+6Min7KWB1a/vX7Ob0MA6El6w5/mfZNTuodHBdLI81z1XyfIq9bIy1Sm2dVzaxbPSuI49/i8txDSyUw+KfYN/to/qq0y+6D2ySMPChP3PQpPxkNOH55DjaB5gEvvUzeQvEZNxBFOY0UU7VAGykTSvnCMWFmruOKE1+6Yen8LZPEKYoqDZzsuwEJbwFFaL2lpGEC8l9lRUQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac530fdb-6a23-4bd6-5183-08dcdeff5df5
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 14:19:15.5463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2CIGmKFfjNMl/3M8KGOXoLkISRc7lG3Z93kUVWEdH4AAHXigTCR2e4OYfCfXQ2Rl4Sg0GIufxYjr+B3ALan0wQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4325
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-27_06,2024-09-27_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 bulkscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409270104
X-Proofpoint-ORIG-GUID: u4zOiEHh443qeJL_nFk3XO0aRi5pOWyR
X-Proofpoint-GUID: u4zOiEHh443qeJL_nFk3XO0aRi5pOWyR

On Fri, Sep 27, 2024 at 04:49:01PM +1000, NeilBrown wrote:
> 
> If the rq_prog is not in the list of programs, then we use the last
> program in the list and we don't get the expected rpc_prog_unavail error
> as the subsequent tests on 'progp' being NULL are ineffective.
> 
> We should only assign progp when we find the right program, and we
> should initialize it to NULL
> 
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Fixes: 86ab08beb3f0 ("SUNRPC: replace program list with program array")
> Signed-off-by: NeilBrown <neilb@suse.de>

Acked-by: Chuck Lever <chuck.lever@oracle.com>


> ---
> 
> Hi Anna,
>  could you take this please - a fix to a patch in your latest pull
>  request to Linus.
> Thanks,
> NeilBrown
> 
> 
>  net/sunrpc/svc.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> index 7e7f4e0390c7..79879b7d39cb 100644
> --- a/net/sunrpc/svc.c
> +++ b/net/sunrpc/svc.c
> @@ -1321,7 +1321,7 @@ static int
>  svc_process_common(struct svc_rqst *rqstp)
>  {
>  	struct xdr_stream	*xdr = &rqstp->rq_res_stream;
> -	struct svc_program	*progp;
> +	struct svc_program	*progp = NULL;
>  	const struct svc_procedure *procp = NULL;
>  	struct svc_serv		*serv = rqstp->rq_server;
>  	struct svc_process_info process;
> @@ -1351,12 +1351,9 @@ svc_process_common(struct svc_rqst *rqstp)
>  	rqstp->rq_vers = be32_to_cpup(p++);
>  	rqstp->rq_proc = be32_to_cpup(p);
>  
> -	for (pr = 0; pr < serv->sv_nprogs; pr++) {
> -		progp = &serv->sv_programs[pr];
> -
> -		if (rqstp->rq_prog == progp->pg_prog)
> -			break;
> -	}
> +	for (pr = 0; pr < serv->sv_nprogs; pr++)
> +		if (rqstp->rq_prog == serv->sv_programs[pr].pg_prog)
> +			progp = &serv->sv_programs[pr];
>  
>  	/*
>  	 * Decode auth data, and add verifier to reply buffer.
> -- 
> 2.46.0
> 

-- 
Chuck Lever

