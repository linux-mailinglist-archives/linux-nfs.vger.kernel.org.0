Return-Path: <linux-nfs+bounces-13931-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE82CB39D90
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Aug 2025 14:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B7D41C81709
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Aug 2025 12:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3471930EF61;
	Thu, 28 Aug 2025 12:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Y40rdNvQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rUeyQoaQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925EE30F937
	for <linux-nfs@vger.kernel.org>; Thu, 28 Aug 2025 12:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756384954; cv=fail; b=U4m5+8PL2WPZ6PIrrd+hUb7OWVlG3nawBJOydLBP8MfWn9lh/7ss66iZ011T+Prl5SFfvlDs7Yc5N8IY+BI6pQLq5f+ryPcjcpK0Pz2uUoy2plkPZn9xoI4eJAyOpaZyuUn8wkhD6/1EsFBKKmGoYZd5AsExmwjqZjGQI3rDadw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756384954; c=relaxed/simple;
	bh=/d60LX9GoDOglPsotoIKMr/pyLb6jvZEYrp4fC1sKk0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VVA0yZhYqEap0+r0BRX0S7vc4GV7qR7AX1bwOB+JKsq3av0ZKhaq7ld3v/IDR+mQQ3zvUhcPfZyxWZNmpd0gD07FU2Mz5Kv6x7DccEMsvZHCNCLTB5quAcbR6LuihM+0VF2Sqe6wzYVKJ5+o681wt3wMQ57+aH85aYB6YEs72rI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Y40rdNvQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rUeyQoaQ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57SCgOXR028078;
	Thu, 28 Aug 2025 12:42:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=vrghFwAZYhF4fiJJmwrBYKQ5F86seeOWtubaNH9Dy+I=; b=
	Y40rdNvQlKNO4fCRNky1QFQnxS7a/f+9vzgocuWAAjC57uD2AP5J9BPxxCnA5tnH
	TeoTMq28Bh8Yr9wKCBKw6YbtimhkyykxXnRXETatdG/ch+6qrpoTVoMYBt2iXgFX
	PEVB/MSO+Hd6z0ViEX23EJC5ODzy9IuGr/gyaRFjp3K7LEwJVr37MkUAJpvq8jmW
	WWAoxpq/xb8W+y1TcAb4EYLvlOsmNrwRH2+643yyiK9H08M6Jay98VDOEP+s7lxn
	37cI/xuLfCS2bYih1138gOZzMQdKtxs5vwr480nP0PYuhFbBtp3Qp7vWSNt7OOtu
	5bri4UHz/RsKTCTtDdWnqQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q4jare4k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Aug 2025 12:42:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57SBggei005012;
	Thu, 28 Aug 2025 12:42:28 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48q43bym49-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Aug 2025 12:42:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h7Sp2+scJq2SYX7//+CwfTIoDCZasj5BF/otDD1SBAGlEL6L2RZL6XWn98nljRF9l8u/pVkisnLJ4dwgIaDAW/Um47ggOC+6JjVYfxB2tLcDPEmHSvU08CfT2AS8I+br/PCGs3yatphLi1C4Vv2+OclAjZDPEQJkbu92c4t9a8sbcGOSqrTvfu1YyYeimVj3Vdw7Q5hk7f8R9H3bhdE4p20hkeHi85kjbR74c9MMOhrz3NLIRkbG96iVa+TmC4bJrBkml0SuJ/wCKgMlRj9ZvUh/pe7XEunAvTMJ5iQpHWrkbE8eUEx+oHNZQ58VQB4iVbyiDvkwV7V55RZo8FmWlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vrghFwAZYhF4fiJJmwrBYKQ5F86seeOWtubaNH9Dy+I=;
 b=joFahmovFxr3ISVYHtPenV+zWbMMCHe8P4/wHP4b3pDf5h2hzYuTCcUjvOlxaAgF7RcLQ8UtDP9kfdCh4eFVIJu/lNCDbIrS6O093X46ExcQONLAdZYXMtLO1x1xNpQ8FcdbMlDra1D/jr/rZW0kknMRnTc4PVT5xgmp6CDZK7u83u6SPqlUHvjucU0sjxfBAsHXN1ckYwnc/yYyhaaVfmsKRjWzS7oiZiagHoxj+/dBw+V6KbKE+C2AVep4g7quAviVXZpOqCMnq5BWq69vEbskZvR8p33Sba7ehwa0WejdMhIFFd8jfEy/2wfgbLclxGOGB2GdDsSHA64oQ0poZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vrghFwAZYhF4fiJJmwrBYKQ5F86seeOWtubaNH9Dy+I=;
 b=rUeyQoaQ+44+NzBuIlZtWW/Vj2g5581oycNwZTIKbGYTcHWc41xWtr1VmLUxBmFztdKB/F6poRrS86NgUAHquLpt3ZV64GwGNYSJkpJ86cBFUQ5TI0iXfvv4e7BUqbh4Z2tkqv3Otb5NJSw3fj8fcaY/T90bx0fhuhkI3/tMoJ4=
Received: from CY5PR10MB6165.namprd10.prod.outlook.com (2603:10b6:930:33::15)
 by CH2PR10MB4279.namprd10.prod.outlook.com (2603:10b6:610:a8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Thu, 28 Aug
 2025 12:42:23 +0000
Received: from CY5PR10MB6165.namprd10.prod.outlook.com
 ([fe80::7213:6bdc:800d:d019]) by CY5PR10MB6165.namprd10.prod.outlook.com
 ([fe80::7213:6bdc:800d:d019%4]) with mapi id 15.20.9073.016; Thu, 28 Aug 2025
 12:42:23 +0000
Message-ID: <b409c469-260e-4bd5-9cf8-49f524f3fd5a@oracle.com>
Date: Thu, 28 Aug 2025 18:12:17 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sunrpc: don't fail immediately in rpc_wait_bit_killable()
To: NeilBrown <neil@brown.name>, Trond Myklebust <trondmy@kernel.org>,
        Anna Schumaker <anna@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, linux-nfs@vger.kernel.org
References: <175563952741.2234665.2783395172093985961@noble.neil.brown.name>
Content-Language: en-US
From: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>
In-Reply-To: <175563952741.2234665.2783395172093985961@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0052.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1::16) To CY5PR10MB6165.namprd10.prod.outlook.com
 (2603:10b6:930:33::15)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR10MB6165:EE_|CH2PR10MB4279:EE_
X-MS-Office365-Filtering-Correlation-Id: d864a0ba-8037-476a-f0d4-08dde63055e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VTRDbnozNkN5dERMSnN4cTdJc3VJcjB5VzA2U3MrRmFsQTFtRUFJVzBlWDFC?=
 =?utf-8?B?eXFFRUVVTnhHbW1CSXV4U2Z2ckJRSUlUbloyRGwrRDdJYzNISGwxaXM0cTBu?=
 =?utf-8?B?ZEdiVDZ2RWNpZFJNVHVLSnlPbEhTcXp0MGcwZmxmakpxc3VBVk1NdVBla3dI?=
 =?utf-8?B?T21keFc1Z2JtQVMzaHp5MldPYzhUZFBhQldFRlBGakovS1JUT2plYU1vZHV1?=
 =?utf-8?B?T0xnOFFIK1VXUUFGak9yQWNkTk96UmRNNUpzSjdKRGt2TG04R0I5aFh3RnhF?=
 =?utf-8?B?TFNKMHNHcENaNEJOenIyY2JXSmZSUE1kRHN1S2pDYjZwbi9GQkVyejY5WVJR?=
 =?utf-8?B?L0RvOEx5OXQ4NldVdjF5S0RsNStGaGhWUmlUZ0ZYSzI3aDBKZWNFRHBNZmdu?=
 =?utf-8?B?Q0tHOVJ1dm5sOXFrVkY5bk1Mb1NGT0RUT3hmUHhJRnpmQm5iTkg5eEhtdWN1?=
 =?utf-8?B?Q29zSW5QZ1V6Mm1YZmNabWlFMVVQZDNFQ0oxSDhacXZjMWgwRjZMcXY2WEdu?=
 =?utf-8?B?a1dOYWFZdjRIZHZ5TDgzdEF2dDhtL2FJdEdhdTNuSzhPZTFEazhLbmNPZFRj?=
 =?utf-8?B?MjZnMGFLcjIxNGpZUmljQ0V3QU1xTndzYWlxRFo0bElKUTdCVWo2OE9TUjFD?=
 =?utf-8?B?QVpHODBMeG1TZ0hJSGpkdjd3ZmxzTmlmampNTkZHVnUwUVVyV09LWkRFNURp?=
 =?utf-8?B?NFJ1S3ZBRncvcmlTWjZRR3YyN21PdENudlczcW44YkZXTGhrS252azJnMGlj?=
 =?utf-8?B?RkpTQ3NMaDVWeGFMYXNtbyt6QnQvVHl1TVdidXBvbWR1YUszT280SEIxZkF6?=
 =?utf-8?B?TTZoa0VDbExQbHYxeVdpalc3TDdpZzd0VlN1RkQ4UWp4WHhJU1BqN1Jud1VQ?=
 =?utf-8?B?NTVYTnJ4a3dOUldnTjJOZ1JtZ1dFUEdpUnVCNlVIOTFnNDhjNXVyOHZjYjNt?=
 =?utf-8?B?aGhldGUwSHVBSGVTaVdDVHg3WFkwbjlaT3Z2VkV3RTZyWUkxemt0UEhROU42?=
 =?utf-8?B?VkprYm16WlVRbXdaZzJBL21oSEJtaUV5Vk5FN2I2OVBmUStoVzlvbHR0OFVI?=
 =?utf-8?B?UXdoZWhieDJ4OWFTRGk0eXh4MVBRdjE1Vkp5T1NCUXk1TURKMGV6RU5xM2Rl?=
 =?utf-8?B?UG55czJpWUVqYTFoUEV0WTBVVklXOUFGT3hWRGROdmhxUWhaaUhJSVQ4QUpY?=
 =?utf-8?B?VnllLzZlYzdSa0lPZG9XNCtGVlpjRG9XRTg1cVJpNFYwMGtUUHprejMvcUxz?=
 =?utf-8?B?QnowbHY1NUNxbllod3plUktQSnJDbU1xeVVDNE9YZXlPek96YUxrVnZUVHRN?=
 =?utf-8?B?WElzbEdzRWpHcU9IV3QrM1Vtd1NqNktMVnlDV0xPaGJONDFjUDFSMDZwdFRq?=
 =?utf-8?B?REluN095blpLVHM2NFZmRnRwcEhwT1lwK1lMNEw3ZlptTlppQlQxVkdHWVBW?=
 =?utf-8?B?bXNPSWkxdlpqZmIzcEd6aU5vMDdvRDNnR2U3ZkEzNGZkdmQwTXZhcGpqMUhV?=
 =?utf-8?B?VkcybjFKWUxEUVpaRGZsbTI3SGxLZENnb0VIRnF4RkdzbmRGSC9SdzVjK1hK?=
 =?utf-8?B?VEMwcThlNFFYaXV0VFRrcDBqa2hEMUd1S0c0WStKZUIwVndXYndya3R2VGlN?=
 =?utf-8?B?a1RscExwWlFZNGdKOEFQN3F1R1RuK0doT1pld2lPaHQ3L3dQbGRMT1Uzb0RO?=
 =?utf-8?B?VWhxcTFLSHhubVQxTHluSlRZVTdraGE1Z2k3TlhUTWJUNmZuYkNrZEwyZHlS?=
 =?utf-8?B?MzFSL3RLN3B3YkpxM0FEdkNzb3hLdm53NjdDb1c1d0llT1dTaC80cWc3K1Z4?=
 =?utf-8?B?SFVNaDVhZUFHWnpCcVhjR2s2aDdaMUFTWFN4ZytpanluS2xGbkZ6YksyWnVO?=
 =?utf-8?B?L09SUTVGcW1kdnUreFFUL2ZuTmc2MnVONmpyVnNYdEd4SXMvTXhST3E5Vkkw?=
 =?utf-8?Q?SGiVmdHvj50=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR10MB6165.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bThDWDBqcFRIdGN2N0FNSlYxdFFWbHZ5bm5nWFQ3RGUxRDFmYnByc29OVjZI?=
 =?utf-8?B?OW9jUk90SjZsYWovR1JJTklFSytWVWhKdGpDRlQrWGJjT01XS2I1b2VKMFF5?=
 =?utf-8?B?N0lzTWdLQ0JRdWF0WmNKVEVIdVdIYUVIUGNuQ3RqSm05NTZsQmpPNUpnYlZq?=
 =?utf-8?B?VjBUMDFsZmYwbFh0TFNVelBJUEFHdVN6akRVQzE3WWZBaExwZHBJa1VLWjVj?=
 =?utf-8?B?b1FRQzJwRTJhVEkzM3VRNmsvUVVRMTNQZVVSaFZvMUpLa1hzNklheHEzbDVB?=
 =?utf-8?B?YnF3cHdNWXlQdFFXUkI2b0ZPSFdLaG1GK252SFR5SzU3Ym85L2hqdGxFUFp0?=
 =?utf-8?B?d3dJTjFrWFh3bzBoRWZEU0hQRFd3Z3AwN3NLK3RXVVJZVzRsYVpUTVBadUxz?=
 =?utf-8?B?M1J0LzgwRHdROVRzQklrR0pGWXdZeFk5RFMyUGgyTUtXQTVnQi9NSWI4Q1dZ?=
 =?utf-8?B?WjBDd2hURVQrbmlkTHpRTnlVT0lqMGFmTEZmemZrWVBRaEI1UzlObVVUcTFZ?=
 =?utf-8?B?ZWllbEg4a2lNRlp2VjRJOUxEeTMrZ2paYmxxTGRvSkVnN0NERURWRXFqR2o2?=
 =?utf-8?B?M1JHVmFoY3lHZVdiZzkreDE4YkdFQ1hLSXdLYmd6WDZIMHdMNmhoQU1VMThh?=
 =?utf-8?B?TEZWaml1K2Rvdm5EcVZucktCekM2ZWtSK1NGNFF2cThpQkRIWVhVUDJzRjJw?=
 =?utf-8?B?NzFRZ3N1QldQQUtveEFCUWVvbzlKV3ZnZ0NtVGdDTjlha2lpb0JKWjRIdHhC?=
 =?utf-8?B?bHllZlRrMURpUnludWpQUTBNOW1YRmsrMzRoMkVzcnUvN3ByVzN6ang2MU5G?=
 =?utf-8?B?RFRhcW0zdkJsUTNVSjhyTStXRGowSzArQ1NGM2ZDODBnOHJOZ1VQVHdLSUlq?=
 =?utf-8?B?aG91ME1Tb0ErbmlZTkZ1VXh1S0RJbUR2cFNiV1dHMnRBMGRHblYvOVVmRU1u?=
 =?utf-8?B?ZldnbFZsTzhYVkxYQ1d1eFNBajlyS1BoQVhwM0dvYUFESklhbGpnTkJ2ZDVL?=
 =?utf-8?B?YjlNU0lUL0Z4dUUwaStNVENGS0RWYi9zMG1zOUJmWmxtVWs2N1pwQURJQmhm?=
 =?utf-8?B?WHQvWWgrVW4vV3JSRzdBRFA3dVFqQnoyUVJpbW84THU3K0QxYVZwOWNwY1F3?=
 =?utf-8?B?V3U2SHMyREVzZ280V0p4cklRZDAvc2NaV2crMnZ4Y0ZtcGxlY3A1VDdxZWlD?=
 =?utf-8?B?T3ROekZCaHZFbzJEVTlQeWN3aGl6eE1jN0xQQjdRdUxUUmNmclFqam1oY3c5?=
 =?utf-8?B?aHErWncvQ091aU5UK3VRUVpCUzhLRWFsUndicVR2dEt1Y205cXkvM3NJbzdV?=
 =?utf-8?B?dmNIbldTWE1TZlo0dEtjNDFRbEdWcmV5anFEckJIemdqZHdsamhxWURNSFRm?=
 =?utf-8?B?dCtNR00xa1RsR01JK1pZZVNvaDc2THpJYWM4UXB6NkFvU1NoVk1reSsrWTRC?=
 =?utf-8?B?OEpDVGJsREhxcE80dnVFZnFGMG5lV2wrU2d2a3J3L1R0c1YvRWlwU0JyNDgr?=
 =?utf-8?B?YmNkem1YbWI4RzVZZGdYaWRoY25acTFEOWk4eitucURHOCtyYUpFcW1oV1Za?=
 =?utf-8?B?aTNLVGUyZDByTXdseVI1RzZwUU8ycXltb2xhd0UyTTBKYWphdXFBNUkyRTRz?=
 =?utf-8?B?TEhwb2RhUDlaOWQ0Rjg3RWR0YVZ0c2p6eWRicDJ0eVZraVRHT0dtMC8yR1BM?=
 =?utf-8?B?a1dLR3M0UEtTc096VFM4TlpHVjRBQ1QzSE1LN2NnQUx5aGc2YlRFTDF2V0hB?=
 =?utf-8?B?VXYrOW9GTlkxVHYxVmZDVU4xQTBMTnJrNGdwS0d0Wk1ISXdZOE0zdFJuQ1hn?=
 =?utf-8?B?dHBUaHg2OUh6Tlc4SjEzTHp5R0d0VFpteHVLT2luUWRlVm05bi9RaTE1ek1X?=
 =?utf-8?B?dW9mODBhUmt1ZFJ2RW95MEUxa29qSGF1Wkx5VVhHUXEwUkI3dmZObnFBQ0pC?=
 =?utf-8?B?UWlXTVdoK1gzQ0RUQ3R0di9Hd1NCMmI0V0hZS0dvY1d4TkdpZS8xVjVQU0w0?=
 =?utf-8?B?WHkxaTA4cS9KQ1RNM2EwQSsrY1Z2MDFMK3RWSmJ4QlNmL2E5cm5nNUNRZmV4?=
 =?utf-8?B?RGs5WWh6aGdZTlBEOWVFM1plWUxOL3BRNEpKdFNWR3FRNTR5NGxpZWtUQ2hR?=
 =?utf-8?B?dGE2RHNVaGNYUVdaODBKSlpqSVZOU1BuYWhDTEhhVkJ5NThtZ1prcEgwTmZL?=
 =?utf-8?B?dEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6X0nh7CRNrvubcgNYYVhDFdVYgmDpmM7tK9N6A5Q7NYH/fAuAwqiRZAoJ3tgtzgj0spAQCqBGbzYIivx3XoYB5C4vcI4YJ+evvt7jD8vmtzmoAWrM/0Yb9Nnsd+9+PMt7zMWUK4w8dzG4EuFcwd1JkFxCCZLMkiTuO6K4gv77RE1x58oMCluR1zvhpfFP/z3bun9cVVP0RDdOnSDNJA5BFndjEAWPgEr5VHnpbHIN9uMU7JSUZEES7/Q594lAZKbwwE1LKWI9oWe/EsMe7i4YH6FP2D9QVowQ/cLxsZBvaIV7Q9cW8sK6fyapMFnovoOIlkouTcsM7d9L/Dl1HZn8xOy15r/JQfZkFJhU/frLz+HJjEwTCDIb70uFFtb8S8PQ6vVAOdqsWqxhvsMv6gA9QnDRfbd1VwhnX726dCsDPQzl82jCLZojwaY63sQj1cBVGznK+vI9ZC9MiRXLvYx43lxx+1b8Rmf4pRXwlY7Pwlwo1Hf6lxHAtcAVAjQaxmEJ1DPd2U95l4/nqyb9p6Q9zirF3Z+3lz46jekHgo9CQuauC0GOU7AgOvuVndFvf6Is+VNAXKBYlvDvIlQn8GTfAkoCdZPEziJ5RG/+f5F3so=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d864a0ba-8037-476a-f0d4-08dde63055e8
X-MS-Exchange-CrossTenant-AuthSource: CY5PR10MB6165.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 12:42:23.2237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3dTw1+qjDAxjSVuJnSxTuxsLJnMNjSbOZ2WZI11RNO7L7iyOmnDPAUrnow4tL+nzILJWMwBCXBe3LVp/yK8euOUgbyW6GCAdkOdHKKLwA7g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4279
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508280105
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAxOCBTYWx0ZWRfX98PfsxK54G1H
 XazElmA7qfCxMe7S0RD9+imQkCPSdF1/egUXpD3HStvutVvGuyDuHSJGTrP6zFBRn8GrxfWN1WG
 46qef4vmH82tCkT4BTF6rRfp77O/v7OTvKtRCXmnu1dLLiyNOvWp0L/+KkNSM7NK0yk+OViMxbn
 tx5twP/Mb1DuKcy+my8Zl+/YyoBeKcxstP/9YbDcihvuBjoneypHzAZOYY7KFI1fjz6gtao9JQT
 Hz1V05zwsPaNSSbjz8EjORvsq60xdjAEto2pROZ3sjAkae4W2ts6ftzIsoJEJNoiEhja0hwL2JQ
 mAa0PmJN7r/b7XZuwZu0Oc5E52uT5kwclxtN5KEyV9/XKe4GUOJB8fiKTrtnEdL75GWDDyTIpct
 pww1fJ5J
X-Proofpoint-GUID: SGvvu17TI3fo0g-ksUvPfVxRzD6NSNsl
X-Authority-Analysis: v=2.4 cv=IZWHWXqa c=1 sm=1 tr=0 ts=68b04eb4 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=qNABUOcEAAAA:8
 a=yPCof4ZbAAAA:8 a=dTEkieOEMJDtME_Zb0wA:9 a=QEXdDO2ut3YA:10
 a=Ytm653ucTKQjCvbzLygB:22
X-Proofpoint-ORIG-GUID: SGvvu17TI3fo0g-ksUvPfVxRzD6NSNsl

Hi there,

On 20/08/25 3:08 AM, NeilBrown wrote:
> rpc_wait_bit_killable() is called when it is appropriate for a fatal
> signal to abort the wait.
>
> If it is called late during process exit after exit_signals() is called
> (and when PF_EXITING is set), it cannot receive a fatal signal so
> waiting indefinitely is not safe.
>
> However aborting immediately, as it currently does, is not ideal as it
> mean that the related NFS request cannot succeed, even if the network
> and server are working properly.
>
> One of the causes of filesystem IO when PF_EXITING is set is
> acct_process() which may access the process accounting file.  For a
> NFS-root configuration, this can be accessed over NFS.
>
> In this configuration LTP test "acct02" fails.
>
> Though waiting indefinitely is not appropriate, aborting immediately is
> also not desirable.  This patch aims for a middle ground of waiting at
> most 5 seconds.  This should be enough when NFS service is working, but
> not so much as to delay process exit excessively when NFS service is not
> functioning.
>
> Reported-by: Mark Brown <broonie@kernel.org>
> Reported-and-tested-by: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>
> Link: https://urldefense.com/v3/__https://lore.kernel.org/linux-nfs/7d4d57b0-39a3-49f1-8ada-60364743e3b4@sirena.org.uk/__;!!ACWV5N9M2RV99hQ!LaRJdjZulcG71nHFWdEAszB9mJEhezxPsDxHO8xeQJ7P8a9UfYNRIm1ziuuHU5wxgEXW14vAqC1dlpSQraWaxA$ 
> Fixes: 14e41b16e8cb ("SUNRPC: Don't allow waiting for exiting tasks")
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  net/sunrpc/sched.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
> index 73bc39281ef5..92f39e828fbe 100644
> --- a/net/sunrpc/sched.c
> +++ b/net/sunrpc/sched.c
> @@ -276,11 +276,15 @@ EXPORT_SYMBOL_GPL(rpc_destroy_wait_queue);
>  
>  static int rpc_wait_bit_killable(struct wait_bit_key *key, int mode)
>  {
> -	if (unlikely(current->flags & PF_EXITING))
> -		return -EINTR;
> -	schedule();
> -	if (signal_pending_state(mode, current))
> -		return -ERESTARTSYS;
> +	if (unlikely(current->flags & PF_EXITING)) {
> +		/* Cannot be killed by a signal, so don't wait indefinitely */
> +		if (schedule_timeout(5 * HZ) == 0)
> +			return -EINTR;
> +	} else {
> +		schedule();
> +		if (signal_pending_state(mode, current))
> +			return -ERESTARTSYS;
> +	}
>  	return 0;
>  }
>  
Is it possible to get this merged in 6.17? I have tested this and the
LTP tests pass.

Thanks & Regards,
Harshvardhan

