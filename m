Return-Path: <linux-nfs+bounces-13244-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A4AB11E0D
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Jul 2025 14:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 250567B2A00
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Jul 2025 11:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C562222D1;
	Fri, 25 Jul 2025 12:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qlDnnFKP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="X8WuweVA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE8113C816
	for <linux-nfs@vger.kernel.org>; Fri, 25 Jul 2025 12:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753444825; cv=fail; b=Aw4/7IqFL9hEr7oI0bWjVjoiTmXjZvKCwbA0GSFsk4miaXwTpePaay2OjLkfdLkjsQzvcPNUtRthDICs+gtCb918Ms+Ws8xORpNnSgDwOfP1qpyPf8qrLaetnz1DeDNr21+OxuTKiff2UOUeET1jHG3OUwrt/WAt07xsswuuiro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753444825; c=relaxed/simple;
	bh=oRow0cXVn/irRfMm9ri4ujeHZqBbApYS5IQ9+cfgkbo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pPnp2zKRARGpyNCbqiUnx9QipG+0pvgl+hZuQf77cW5INio/y22iBQ9RlMTllYHe2t3/s7PvEbQDHm7LyPtwLtl75OpPGrfepG7t722ZAjLX6DaKz84YfEwclZvBPlcncKUqpop9LbvOX4zvc8Fb7HP7I7y6MsUl9/sgwJZk6J0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qlDnnFKP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=X8WuweVA; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56P7fpn8013030;
	Fri, 25 Jul 2025 12:00:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=rVkY6C3yawLp2owOOXLCuiH+U2mc0eu7BKLMqd+YNs8=; b=
	qlDnnFKP5tJveRuh7dAYqS3Fr0iX/Aa2A6NFsyDNhskPbo2BSJgtMVsXei/C5btl
	lsJ/rX65WqIsP0Br+3dZ76pEsb1F3ebzrb46EWvvXFNz+vbCCen26jCkXKRT6MnS
	LLBeF2R2Ii8favWqJEVocMJBto6k3P0Nv5J8pNJoj2HlsLFMRa5MN72UQGD8Vec7
	V6jybd5XWoGQTeZ6BaHOLrp6Ae2W4SNvf6H0ACJ3KrJENg7r+xhWQvVT2jnV2QGq
	vOho+9CkH3FSNDPsyOhjAexZYhqtsx3WsrgvgGpeCVWZ6ef5jc0cNKxiu0SWEcD1
	YQbxmkS+idKlKZ2cC65seg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 483w3wgwt4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Jul 2025 12:00:01 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56PBlAKP031468;
	Fri, 25 Jul 2025 12:00:00 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4801tkb4w1-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Jul 2025 12:00:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vid2T5RvA8lg2nOfBqQ6nhyiomFYLjNi9GXqSRaP2QDkQG7/1bhyYEmE3Tx/ewfcrlzRLVGJLjQ/C2bdv7WAP2W3Y2nhPG6LoF22YFtaD7lfvqNeh/HT6WsxZ2dEJAmgTJ8Nixx8ww1McXQjyuK3UPQ8W5MvhmPSuOGuhhFf1We2IjLdnAVstuQ9hlquq/sXSbtGfbORsfC2ipwi1cfbcBMdOsEz7GWxTuFdMgbOFb1kt7FceJW4v/BKTlqkkci+e3P/NmAeq6e4nJUdPfRQ288SMmPyFRndjUP8AgVPl7TKhcpW4FW//HFNUgi/WzS8cPD5hJEOcgj66CDYza77jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rVkY6C3yawLp2owOOXLCuiH+U2mc0eu7BKLMqd+YNs8=;
 b=iIKrCY+zFM6Ry12BdKe5rqmDfV0YtNCnokLUTvAVzFU1gedhK3vjN/q1JsmfTpKcdLMHGHO6jBPUK/v1HFY9J91S22QuPqRCQCYpTKfW+AlCaJnznK7OoiQa1I+8o8VhgeVMYjMGFQ1VKX6MB1xVvN1/q8Zqxza4L07Pxk9a2W2O2Bg+NU0xrLjQ5LSC0Wn/wmCXgO6QAnJBBDUwJ7tYwNmNnJbDVcld8of4TIoZD4N/m2zlZu3j0XMkqCqQIVJ/wP2K7pssbnxnkKOSTz/30/4oQ7dwuqm8mJ2Xpz07vSO4rWpl7tQbdPvI6GYi2eJDXHOIMK6s48wIFG1dC1E20Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rVkY6C3yawLp2owOOXLCuiH+U2mc0eu7BKLMqd+YNs8=;
 b=X8WuweVA3KTZBu+USirot2+C3t16FMAYDck0CfF8FyIS4zUkv4BJHotOpY++WmdDYXix/JoEjIvDB5dhaDZxplkT3+XURUbxYYSEUu7Vyw9YR93jn87tckG6F8m68zhqsYlZRu8Qzi3PFEzwJIj0rt6G1aUa/nGx7geigG2TH08=
Received: from CY5PR10MB6165.namprd10.prod.outlook.com (2603:10b6:930:33::15)
 by SJ2PR10MB7654.namprd10.prod.outlook.com (2603:10b6:a03:53b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Fri, 25 Jul
 2025 11:59:56 +0000
Received: from CY5PR10MB6165.namprd10.prod.outlook.com
 ([fe80::7213:6bdc:800d:d019]) by CY5PR10MB6165.namprd10.prod.outlook.com
 ([fe80::7213:6bdc:800d:d019%4]) with mapi id 15.20.8964.023; Fri, 25 Jul 2025
 11:59:56 +0000
Message-ID: <c5d1eb2b-2697-4413-983c-0650eab389e9@oracle.com>
Date: Fri, 25 Jul 2025 17:29:46 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] SUNRPC: Don't allow waiting for exiting tasks
To: NeilBrown <neil@brown.name>
Cc: Mark Brown <broonie@kernel.org>, trondmy@kernel.org,
        linux-nfs@vger.kernel.org, Aishwarya.TCV@arm.com, ltp@lists.linux.it,
        Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, Anna Schumaker <anna@kernel.org>
References: <> <ddaf94dd-30a2-4136-8dff-542b4433308c@oracle.com>
 <175325803891.2234665.5884275341421351947@noble.neil.brown.name>
Content-Language: en-US
From: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>
In-Reply-To: <175325803891.2234665.5884275341421351947@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0112.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c3::15) To CY5PR10MB6165.namprd10.prod.outlook.com
 (2603:10b6:930:33::15)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR10MB6165:EE_|SJ2PR10MB7654:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fd24d26-1eaa-4757-47de-08ddcb72c5a5
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|13003099007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?WC90Q21TMVFFaXBUUnEvNy9OQkd0Rnk3cVhFSU9QMjlxdHBheDd5Tk9jRXAx?=
 =?utf-8?B?TERRNlgwdnlrWVUwS04wOXVoV3hYUmE4Y01zenh5U1FSUysxSDh4aTQvT2dI?=
 =?utf-8?B?M2Nqd2NHQkpsUTV1SUU3UHF5cmQzNEc3d1k4RjJodEF1Y2owcmk0UmpQTkVi?=
 =?utf-8?B?OGV5WXVrQ0k4SmNRd2hZQ3NCZHYvanB1SHM0dUtLc2FaR2liM21GTE15K2Js?=
 =?utf-8?B?cDZxNHFUc01YYmQ1TkJKRndwZGFDVDZxamthMmlUWkJqQkJud2t1dmFVRFlR?=
 =?utf-8?B?T3NHRitHSjNJNFVLTTBnQ0JIVTlETE9PeHpaWmh2Z2VaUTg2MWtFWmo3VFRB?=
 =?utf-8?B?OFNqRTh6eENMMUtocnFlem9xNHpOMEM1M3NhREJocjZDYXUxTjM2SkNVUm9h?=
 =?utf-8?B?NnpRMVJJb29rdFM2eC9zZ1IzYS9tT1lCYlV0eHdwekFIVmUyK0lFZHlEbFNO?=
 =?utf-8?B?dVlIOGxkN3QvbjRsUlRUSkQyQzh5MVFpa2N1TUJXbUdxRUhxdllyQlVQRkNs?=
 =?utf-8?B?aEp2M0EwK0JwVEhzM0R0Tjl6a1YwVXRJNndESXFQQ3c1dDk4dWZXN1hraHFE?=
 =?utf-8?B?WVRNS2dheTREQkFtbWlvLzhpdG44RmV3MjJ1a2hwMW5yMUhyd2xLQ3g0YXdk?=
 =?utf-8?B?SmF6aWxtUFh0UlRab05sRTF6TFgvMnRnRXlZRi84R1BMcTJzK0dnMU1SUFpz?=
 =?utf-8?B?TWttSERjSi92bVo4L0hvRWhZZnllaEUycEFmaXN1Tk1NcjN4UXNCd3RDN1ZW?=
 =?utf-8?B?VVJnNmlUaTA5dEJFVFhHRXBleXY4Q2RHc1djNWEyaCtZVFA1ZnoxcjJ0SG05?=
 =?utf-8?B?YXVnQUVacTdnV0FDUE9Ca3I2QzUxa3QvaUtDWlFVelRCZ0VZYTh1L1VKOWda?=
 =?utf-8?B?cHY1Z2hEQUpqamNlVE9aR1pNVlNLRUFNSHhVd3lSUHRWTzExN05xZnFxelo3?=
 =?utf-8?B?d0NFZDJDd0NOMVFscXBXUHp6ZVIxTEQ4VEM4QUh4Zk1HRjFZNnJDQ1E3ckxR?=
 =?utf-8?B?NmptbGRJV2l0elRXQ1A4bHBkWW4rSHRBLzczNXJGcE5LL0J0UXpiT2o1UHQz?=
 =?utf-8?B?VFhnNU92S3paTDVDSEVvb25mRXFjUmR4eGxRbml0dkx0dmRLbVRGMXJycXVp?=
 =?utf-8?B?dCtYL1E3R3Yxa045YWxseEsydUkxeUR6RDEvcStlSnJKM2ZmWmhjMHVXVzdE?=
 =?utf-8?B?ZFhHUkdaU0UvS29EekYzbGtBZ3Q3eVBpRWM2Tm50YTk1RlMxNmV6NjRDam4x?=
 =?utf-8?B?Z3h3djhHWUpmV3dpVzlyYzgwYkoySXpyak9HT0lKa25vTlR5aENKOXJXVk1u?=
 =?utf-8?B?MWJOcUgzVkZWbnhVVEt3MHE3dlo2SmhYWkNSRis3MXNPejROUTNHVmVyRTI5?=
 =?utf-8?B?MWN3b0ttVVQzRXFPcVpnYmZpNmo1VFUyU2poaDA1RVlwdjZEWnhQaHhLRzc3?=
 =?utf-8?B?M1QrTDI0K0QvT3dBMitQbERMMDRuc2M0WFdLZHFadmpvSlUyZmN6dlo5SFVT?=
 =?utf-8?B?RFExcUt2WlJpSGdhVkFuQjRpUUxhMmZyZ3cram5PazdpTVVaK1BITXRRc2NE?=
 =?utf-8?B?d0VCVmwzbmFGdFJxZjFaemJxZThZRFlTNHByenFmdDZibVZWZ0MwUFp2Wmd6?=
 =?utf-8?B?MG0weTZzMmd3cW1XUjhEbkFabXN2NWR3YU9HdDJtclJxN1hiQkxvdTdhMlVu?=
 =?utf-8?B?djNTOC92K1U2ODYzUjVpamQrTTA5eWYwNjU0VXpqdVBHcTV5RUFKd3dQRDB3?=
 =?utf-8?B?VWFPSVpJTjAyYzJIMEFsNHJ6YmVXbWR1em5yZzhyelZNaDJmOWtwck1Fc3Aw?=
 =?utf-8?B?ZzArK2pnbk9wcG1PczVNTmtMaW9IOHlmbGp0a1hyRVhDMEdQTzZGVFhIMEhz?=
 =?utf-8?B?dGt6ZGx4M2xMa1lidWZWckdWOVg0c2p0VWhEbC84c0dobmQ1bE1OMDI4elBw?=
 =?utf-8?Q?9wxHe5BBEZE=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR10MB6165.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?SWwybnNIS3hRdlkyQUtvcklHdmNYQ25wNmRVanJSTm5xb1Rqb2JZWDlHdXMx?=
 =?utf-8?B?WkkreDV0dlNCQWpYSXFVOVBSa05MY3h6cTFKZnlOR0xGRTRjL2IrdDRPdEsx?=
 =?utf-8?B?THpnSllOZGFSaHdRYldrZHUvNnpqUDgwRnJ2MTZiZnE4WFpDLzM5ZjJCVnQw?=
 =?utf-8?B?R3VuNXBWNGxZN1ZxSHlmZk1YRGYvcUlGZnlwcGlIMW1jMlV5ZTdyWnN0ajRh?=
 =?utf-8?B?V2syaWFzYytjN0QxVUpZellkaWhWRmJWalliZVVjc0FSa3lVUEZRbk9NWlJS?=
 =?utf-8?B?UTltM0dpT3lUM3RGMWlnT0x5em9HUGk5RXFLTTducTJCK2hFdDZUT2J3RDNW?=
 =?utf-8?B?VUdEU1I5dTJaeDZnM2Q1K3ZvVDlrQ1pDRXVUdk11RFZDckx0MFh1eUpVVXRS?=
 =?utf-8?B?eFl4cFNkSWVTUmh0eEVrZFVTMWphb1hHUG5lZ0lBb3BBUmx2MVVxUGR0MkFP?=
 =?utf-8?B?Q2x3WW5wMFJtWlpxKzM2VThRSnAvQWtxQmM1QmtCclZvUWlRQytSUStNWkI4?=
 =?utf-8?B?NDRHR0tmSzEvTXJxNHlLcFc4cEFiY0pPb3Uxc0kzalUrRDdac0ZTS2pQejVG?=
 =?utf-8?B?OHVKQ3BzeExtQ081eXNBRU1EWHp0ZVZqbkhZMjJwRENZQ3hKVHlvalFQcUE4?=
 =?utf-8?B?M0tnczVNaTBYUVhLU09mMk05MXlqektqeVp2R2p3UStqNmpCSVZBSXhQMU9I?=
 =?utf-8?B?ZFlBaUJ2dkliQk5qYTFBMG5MYVlpOXBTQ2svUDg5NU8zWER3a2FYMDJISmpP?=
 =?utf-8?B?dXlwdVB1ZE9VSHkzc2dTR1R4NmNoSXhQcEdGMzZIYnFpbGZlbFlHU2xQRE9I?=
 =?utf-8?B?czZDdkZoaE10TGEzMHFZVnJNMEFUbHZ6bVpJS0p4R3ZkMk5OV0JJQytLZ2Nv?=
 =?utf-8?B?dDd6cFl1dGVudGxrVWZMK1ZERC94SGhxc3c3b2dzY0VLVytRcHdIVm8xYmVD?=
 =?utf-8?B?aE1qTzg5YUhacEwyOFByM0Y5QmJnaFVQTXNzcjc3OEU1MGhLMTRzVnFTdUV0?=
 =?utf-8?B?dXFKemZyYVROdDR4N0N4OURPWWt3a0U5elRvK3MwcDlaMlV1bHcrbUcxVUtt?=
 =?utf-8?B?Tk1wMVZza2pPanBReGR0Z1pUeERtdW56NWdRTUxmemk1dnJOYWlBa01tL3FT?=
 =?utf-8?B?Ny8xbDJSK3RERXlEbGphNWplU0Y4ODhFclkrYVhHSFd1NEJOWmY2aDVRK1Rs?=
 =?utf-8?B?a3RtMXFRcEJ5UytoTDRPTENndjlydEp0TTdPODJZeGh2UGNVMXRzN2JYUytr?=
 =?utf-8?B?aFRrbWdBUVMyTkxtZlpuYmRqaWlyd2g2M09tM2Y4QWpGb21Oa0l6ZGU1bS9T?=
 =?utf-8?B?cmNGWlRpNnJOaUI0a1dPMUg5SWdwZkhUWG5RenhKOTA1bHU4MElNSHZxY2V2?=
 =?utf-8?B?T3UxQnBFZFRJdUZjU3NiR3MxTjRDSHRJQUZVR0x4T0RNNFI4Mm5lM1hwTGJU?=
 =?utf-8?B?NWJVaWRQaEROU05IU1UyRXlrS3Q0MEJWVXpZamxpaHpjTG5CT2VXU0dBUjRQ?=
 =?utf-8?B?MzBEZmlFd2lZMUVkSUltc09FNGRMRmpSYzh3SW1ORHdKWFRTbVNNOElmOWp0?=
 =?utf-8?B?U29IYVhvVDAyUzFVYkdsaVh2YVZtT1RpQ1prYkM3NzJ4akJraFNXVVF0U1lN?=
 =?utf-8?B?dm81VDRGWDNsdFp3VTRvRTBPR1lDVFZ4VDM5QVFVUjRQY0J6dUpTWVBQVWN0?=
 =?utf-8?B?QUV1cXFKR3NUeDMxUTFsTmxhdFRQTVlaNlQxc0djQ1RCZ24xakFTWi9ha3VG?=
 =?utf-8?B?SFRCSEw0Uy8xSjhtTVk0NFQ4Y0ZxdlRiVlkvQ01VL2xEc3A5RlU3ZkR2eGtM?=
 =?utf-8?B?bGE4L2NqSWJoeEMzbVdTUE9xM2VuaS9ranM4YlhyWWFDTk0ybnFTSjZHdFps?=
 =?utf-8?B?ekk4VzNHR2luTnJEMDRnTy8zQjcrNlRiQnIrdmYwaUtkN3h4ZURZOEcxb0pl?=
 =?utf-8?B?aUtmK1VvSEpHQXhuS1hhQlBYU2lUcnROam5ZYUxGbUs3RUNCZ2xRNVlYL1Vp?=
 =?utf-8?B?UGVUVENwWjV6S01zTG8rdnpqTDhKcXBNWVdLdTBXckdXejl1OSs3ZFN5RnFu?=
 =?utf-8?B?bkRmTW9YSk5qTmxRUStNbUZta2lVR0pWeDA5QVFIS3VkSkVOSHpzL3hYMWdk?=
 =?utf-8?B?dGhKNC9zcTNWZm9QcmU2M0t2dzltRXVEMWdYdzJzalF5ZDJTVElpQmx2NTlq?=
 =?utf-8?B?NXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IpfSEeCQgUp6qFU0VQVuy7BEu5GuiI57hkuTRI+/GCSfVCXx+cXy1bqYvFs5QCwQRQFazLDM/nMG5XnK7ZuFsoaBH/ynFHsDGUc+WuVuKjJBQ/VPnnR21OScU94bX21RrqxQuMO9zGDARIqi/ds81N3MqRbnxpTPJB9ih9K/QUotS+G1pvejuYOZGMii20FLreFR9VsUyezVRyEi/yZoExoS0QVP8UVesC4sdJiVr8ExoB5HEXohJVLgkjx+1ZYTgaPWgAm0yaBOANwP+2sdtrPPTGKdQe6kqDbuFWFh5PnLaa/GAYLvzJ61a/f6WExABU8UrNS5aA3LYQrNXtoRkJ1kfM+rFYdGCoiFsLtCdP0whu7di/D6HRL0NKTPP+toYoBB+r5/5QSyl/IbKUzU985dyizpfD1cYGWkvxReAe6X/nUK2CfEcbw6pTWIrVHnAIgW5ysow3ys+MHLEhnRvXs60f0CH8CVLpHiQJ2QD47DOzV+WVEHj/awfKkyvqIcfVOA1T0LVRYjNUV+Nt/ochsqQZ6AdP/Y9SGnUXq2KiKdIZy829imd1+w2zlv8RTWdMf3EjWP7oouC1RhL8Rb/PgHDqquk2TJ4p/hmDV4fik=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fd24d26-1eaa-4757-47de-08ddcb72c5a5
X-MS-Exchange-CrossTenant-AuthSource: CY5PR10MB6165.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 11:59:56.3180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QCGrcjbXWg4cAwrzyt0lOJ1tlOnR6Pr8jHWwhTB7lTeCciMawe8zeBHpFkJMgN7LbVlDwvBtpQImeujAMldbVbbZGepGkiFqXGoRfarnFMo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7654
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_03,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507250102
X-Proofpoint-ORIG-GUID: pCwqtwO5gabyJL0cQNu2FOmhC3tTE3qG
X-Proofpoint-GUID: pCwqtwO5gabyJL0cQNu2FOmhC3tTE3qG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDEwMSBTYWx0ZWRfX+ZxTUumYkJGE
 x/9AGO9LNifoMwWDomdAUBeXeZzwRUTDhh1QglZSxKbPzO+4/DNy7H1BudO/24jxGKK4YFVHLDu
 DyuGjDxpJWQzx47+gmqRmH4wqEleqRuenIxFw+FT6SVlZHWuQ7xQC5XDLJnqUIALMsk8hoaxFF2
 AKHBn56/t55CFryHnTH454Nj4sVauMSvJtiDQfd722B4QW7VOYj0GtuhQQC3uEdZOuteLqWmRRh
 r+sqvPtlJ/7GbtVEG+rZBcJnPOucgzLX+qBPXBTtsRiowO+mZ3fFrZidbSKIHxR3HO7kOKxrAyr
 2dNCMBdDQfHLry0ldrjy15A+7DmHwkMqRdxZK6U6WltcFUpAgljG5gJejlsAWaLyj+xNqAgi3ZF
 CXhyHsV8HWHQjIiE7Y3pe+moF20lj+aIRjLOE7RxzelcGmnG/92kljODauvVLl6LaVbwo2rI
X-Authority-Analysis: v=2.4 cv=Jt7xrN4C c=1 sm=1 tr=0 ts=688371c2 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10
 a=VwQbUJbxAAAA:8 a=SEtKQCMJAAAA:8 a=1fT50u9RxeC4elPDTm8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kyTSok1ft720jgMXX5-3:22 cc=ntf awl=host:13600


On 23/07/25 1:37 PM, NeilBrown wrote:
> On Wed, 23 Jul 2025, Harshvardhan Jha wrote:
>> On 08/04/25 4:01 PM, Mark Brown wrote:
>>> On Fri, Mar 28, 2025 at 01:40:44PM -0400, trondmy@kernel.org wrote:
>>>> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>>>>
>>>> Once a task calls exit_signals() it can no longer be signalled. So do
>>>> not allow it to do killable waits.
>>> We're seeing the LTP acct02 test failing in kernels with this patch
>>> applied, testing on systems with NFS root filesystems:
>>>
>>> 10271 05:03:09.064993  tst_test.c:1900: TINFO: LTP version: 20250130-1-g60fe84aaf
>>> 10272 05:03:09.076425  tst_test.c:1904: TINFO: Tested kernel: 6.15.0-rc1 #1 SMP PREEMPT Sun Apr  6 21:18:14 UTC 2025 aarch64
>>> 10273 05:03:09.076733  tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
>>> 10274 05:03:09.087803  tst_test.c:1722: TINFO: Overall timeout per run is 0h 01m 30s
>>> 10275 05:03:09.088107  tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
>>> 10276 05:03:09.093097  acct02.c:63: TINFO: CONFIG_BSD_PROCESS_ACCT_V3=y
>>> 10277 05:03:09.093400  acct02.c:240: TINFO: Verifying using 'struct acct_v3'
>>> 10278 05:03:10.053504  <6>[   98.043143] Process accounting resumed
>>> 10279 05:03:10.053935  <6>[   98.043143] Process accounting resumed
>>> 10280 05:03:10.064653  acct02.c:193: TINFO: == entry 1 ==
>>> 10281 05:03:10.064953  acct02.c:84: TINFO: ac_comm != 'acct02_helper' ('acct02')
>>> 10282 05:03:10.076029  acct02.c:133: TINFO: ac_exitcode != 32768 (0)
>>> 10283 05:03:10.076331  acct02.c:141: TINFO: ac_ppid != 2466 (2461)
> It seems that the acct02 process got logged..
> Maybe the vfork attempt (trying to run acct02_helper) got half way an
> aborted.
> It got far enough that accounting got interested.
> It didn't get far enough to update the ppid.
> I'd be surprised if that were even possible....
>
> If you would like to help debug this, changing the
>
> +       if (unlikely(current->flags & PF_EXITING))
>
> to
>
> +       if (unlikely(WARN_ON(current->flags & PF_EXITING)))
>
> would provide stack traces so we can wee where -EINTR is actually being
> returned.  That should provide some hints.
>
> NeilBrown

Hi Neil,

Upon this addition I got this in the logs

<<<test_start>>>
tag=acct02 stime=1753444172
cmdline="acct02"
contacts=""
analysis=exit
<<<test_output>>>
tst_kconfig.c:88: TINFO: Parsing kernel config
'/lib/modules/6.15.8-1.bug38227970.el9.rc2.x86_64/config'
tst_tmpdir.c:316: TINFO: Using /tmpdir/ltp-w1ozKKlJ6n/LTP_acc4RRfLh as
tmpdir (nfs filesystem)
tst_test.c:2004: TINFO: LTP version: 20250530-105-gda73e1527
tst_test.c:2007: TINFO: Tested kernel:
6.15.8-1.bug38227970.el9.rc2.x86_64 #1 SMP PREEMPT_DYNAMIC Fri Jul 25
02:03:04 PDT 2025 x86_64
tst_kconfig.c:88: TINFO: Parsing kernel config
'/lib/modules/6.15.8-1.bug38227970.el9.rc2.x86_64/config'
tst_test.c:1825: TINFO: Overall timeout per run is 0h 00m 30s
tst_kconfig.c:88: TINFO: Parsing kernel config
'/lib/modules/6.15.8-1.bug38227970.el9.rc2.x86_64/config'
acct02.c:61: TINFO: CONFIG_BSD_PROCESS_ACCT_V3=y
acct02.c:238: TINFO: Verifying using 'struct acct_v3'
acct02.c:191: TINFO: == entry 1 ==
acct02.c:82: TINFO: ac_comm != 'acct02_helper' ('acct02')
acct02.c:131: TINFO: ac_exitcode != 32768 (0)
acct02.c:139: TINFO: ac_ppid != 88929 (88928)
acct02.c:181: TFAIL: end of file reached

HINT: You _MAY_ be missing kernel fixes:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4d9570158b626

Summary:
passed   0
failed   1
broken   0
skipped  0
warnings 0
incrementing stop
<<<execution_status>>>
initiation_status="ok"
duration=1 termination_type=exited termination_id=1 corefile=no
cutime=0 cstime=20

<<<test_end>>>


Thanks & Regards,

Harshvardhan

>
>>> 10284 05:03:10.076572  acct02.c:183: TFAIL: end of file reached
>>> 10285 05:03:10.076790  
>>> 10286 05:03:10.087439  HINT: You _MAY_ be missing kernel fixes:
>>> 10287 05:03:10.087741  
>>> 10288 05:03:10.087979  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4d9570158b626
>>> 10289 05:03:10.088201  
>>> 10290 05:03:10.088414  Summary:
>>> 10291 05:03:10.088618  passed   0
>>> 10292 05:03:10.098852  failed   1
>>> 10293 05:03:10.099212  broken   0
>>> 10294 05:03:10.099454  skipped  0
>>> 10295 05:03:10.099675  warnings 0
>>>
>>> I ran a bisect which zeroed in on this commit (log below), I didn't look
>>> into it properly but the test does start and exit a test program to
>>> verify that accounting records get created properly which does look
>>> relevant.
>> Hi there,
>> I faced the same issue and reverting this patch fixed the issue.
>> Is this an issue introduced by this patch or it's due to the ltp
>> testcase being outdated?
>>
>> Thanks & Regards,
>> Harshvardhan
>>
>>> git bisect start
>>> # status: waiting for both good and bad commits
>>> # bad: [0af2f6be1b4281385b618cb86ad946eded089ac8] Linux 6.15-rc1
>>> git bisect bad 0af2f6be1b4281385b618cb86ad946eded089ac8
>>> # status: waiting for good commit(s), bad commit known
>>> # good: [38fec10eb60d687e30c8c6b5420d86e8149f7557] Linux 6.14
>>> git bisect good 38fec10eb60d687e30c8c6b5420d86e8149f7557
>>> # good: [fd71def6d9abc5ae362fb9995d46049b7b0ed391] Merge tag 'for-6.15-tag' of git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux
>>> git bisect good fd71def6d9abc5ae362fb9995d46049b7b0ed391
>>> # good: [93d52288679e29aaa44a6f12d5a02e8a90e742c5] Merge tag 'backlight-next-6.15' of git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight
>>> git bisect good 93d52288679e29aaa44a6f12d5a02e8a90e742c5
>>> # good: [2cd5769fb0b78b8ef583ab4c0015c2c48d525dac] Merge tag 'driver-core-6.15-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core
>>> git bisect good 2cd5769fb0b78b8ef583ab4c0015c2c48d525dac
>>> # bad: [25757984d77da731922bed5001431673b6daf5ac] Merge tag 'staging-6.15-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging
>>> git bisect bad 25757984d77da731922bed5001431673b6daf5ac
>>> # good: [28a1b05678f4e88de90b0987b06e13c454ad9bd6] Merge tag 'i2c-for-6.15-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux
>>> git bisect good 28a1b05678f4e88de90b0987b06e13c454ad9bd6
>>> # good: [92b71befc349587d58fdbbe6cdd68fb67f4933a8] Merge tag 'objtool-urgent-2025-04-01' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
>>> git bisect good 92b71befc349587d58fdbbe6cdd68fb67f4933a8
>>> # good: [5e17b5c71729d8ce936c83a579ed45f65efcb456] Merge tag 'fuse-update-6.15' of git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse
>>> git bisect good 5e17b5c71729d8ce936c83a579ed45f65efcb456
>>> # good: [344a50b0f4eecc160c61d780f53d2f75586016ce] staging: gpib: lpvo_usb_gpib: struct gpib_board
>>> git bisect good 344a50b0f4eecc160c61d780f53d2f75586016ce
>>> # bad: [9e8f324bd44c1fe026b582b75213de4eccfa1163] NFSv4: Check for delegation validity in nfs_start_delegation_return_locked()
>>> git bisect bad 9e8f324bd44c1fe026b582b75213de4eccfa1163
>>> # good: [df210d9b0951d714c1668c511ca5c8ff38cf6916] sunrpc: Add a sysfs file for adding a new xprt
>>> git bisect good df210d9b0951d714c1668c511ca5c8ff38cf6916
>>> # good: [bf9be373b830a3e48117da5d89bb6145a575f880] SUNRPC: rpc_clnt_set_transport() must not change the autobind setting
>>> git bisect good bf9be373b830a3e48117da5d89bb6145a575f880
>>> # good: [c81d5bcb7b38ab0322aea93152c091451b82d3f3] NFSv4: clp->cl_cons_state < 0 signifies an invalid nfs_client
>>> git bisect good c81d5bcb7b38ab0322aea93152c091451b82d3f3
>>> # bad: [14e41b16e8cb677bb440dca2edba8b041646c742] SUNRPC: Don't allow waiting for exiting tasks
>>> git bisect bad 14e41b16e8cb677bb440dca2edba8b041646c742
>>> # good: [0af5fb5ed3d2fd9e110c6112271f022b744a849a] NFSv4: Treat ENETUNREACH errors as fatal for state recovery
>>> git bisect good 0af5fb5ed3d2fd9e110c6112271f022b744a849a
>>> # first bad commit: [14e41b16e8cb677bb440dca2edba8b041646c742] SUNRPC: Don't allow waiting for exiting tasks

