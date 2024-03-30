Return-Path: <linux-nfs+bounces-2572-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 448EF892E13
	for <lists+linux-nfs@lfdr.de>; Sun, 31 Mar 2024 00:30:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CA121C20A9E
	for <lists+linux-nfs@lfdr.de>; Sat, 30 Mar 2024 23:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2DF3335BC;
	Sat, 30 Mar 2024 23:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QDi2wWJh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="0PFF5Xcn"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6883222079
	for <linux-nfs@vger.kernel.org>; Sat, 30 Mar 2024 23:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711841417; cv=fail; b=VfGSKhP/50QVRXdout48JTg6fxVlvMVEc473gZzIDwRsFU0c9oOqejusiWCJ1iW7aNkMWhW9vAshFWj/oglpgr4P9xRAmvav+xziqOJA/y4y8TokCXeo6pIWqZ30oTlXKI3lWSGYeKw+UCg29UZD4nvEcGwSQh7SMv8ZnfF5vSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711841417; c=relaxed/simple;
	bh=ncZsIRhcNKipoP2U63Xs2QR4TTiOZRz5UCmfsZFfFQw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HSpW973GeaooGcIDaqQromRsAtQWF4zrBlZrhuCKaQwuSlwu0ExmwnfRLZskIJ/i7FZXk/d+DXEHEB6NtgafWGLMIj21EsIjArmsiHY0+++zmkNqsKYvFn/7v0xTmf3IPWT+Ao9GxurUHCqMlZ+/uT3i426uNs/ul9ofJM34HSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QDi2wWJh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=0PFF5Xcn; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42UNUB2I019787;
	Sat, 30 Mar 2024 23:30:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=ToK22UqOI5C609DJAEIyZYTnOKR+jvmKkDrEFoLFSD0=;
 b=QDi2wWJhwOU2RN1ro8tQApUUCH+Y8SIvporuuptAW7Fp2nTdYJxB0ERCiA+MMEPekvsP
 PNb9RybhYc2+VfWgY9QHfq0mXVSzmN2+vMB5+2SuXGNuznbTiE/oLvy+YQovP1MIjzUj
 XEnAQC8HFWDqw3MnvfeJoS9Y+AwfsVWwSG319TL7sNKzLPfcgjgtMPxLW3d4toqftWux
 +ll2MK9lC183ulPPu4tmdw3FC7YGb86zRG2zokZ3FULyum3EJdfuLv0sXxRVqcTBmlUb
 uHxsLORY5XT1wD/3TYkz99Q6kbN78b6SDrSuRQU7qntRAktfzSUyVIjp945tlGj8U6aJ 4w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x69h4gn9f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 30 Mar 2024 23:30:10 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42ULU7Hc027995;
	Sat, 30 Mar 2024 23:30:09 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3x69643c1b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 30 Mar 2024 23:30:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V7NtUDZ2h+z17GZkbiNYTXQlQBOzhUD/UIFevr9mnfyMNeQZYNlAqmNv8Tm+rEC8M6eNj6Ubc9afwHuCt4Ea6Cqjx3ZcZXpJaKiiXn6JSTBq8k+WTMRIwi727l7unWvNOJHawAwUAJ5APEjAIs958b0bTYpMsYYahNPgz5DgYZoTPX1fcIBnIp2K9imMi1ET8BUUNjaL/eADvZFtewffwkRuzBuKXGHgpfKd2sQ5MLNjYF6sa6H8vSZe8500/o+qZtgkv5cF3SFEPT8PDcdLbKN0Dkj9WpRb5J7MPugIZcz5i+2+amt38s05qvlHyABBZs7oE/GjXsDQcnaWd+Xjdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ToK22UqOI5C609DJAEIyZYTnOKR+jvmKkDrEFoLFSD0=;
 b=Z2n7UF2UNp5rH98x3SENo7BRjD8K15Cxg6dK7xzlbRnKST+BDxT+arOh3c1e2UDBoFm0DWeJAJ8PUz5dXFquwtIfKj3ho+sqZ1KZwm1H1c2rLybpDU8HyuT8DxApN4jGAdSZftRT5CEvuyz0AvpCjJe0jaALhchSAAlX4vmvbeSUK4ExsXbPhEDPEdwr5yy2PKDlRa7cjsK5h3JFgYd2zEUy1olVrrGjdFU+e2ZmEDjKTb4vyt++aApX6txJrtllFEo5Iz6AtfWLa6JM9d0JiI91y9QuRDoKpd1PSNhmvn5q/4vv7YAn24F1B6htrtjCKSgtgCKq2JJDYcdR/zxLQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ToK22UqOI5C609DJAEIyZYTnOKR+jvmKkDrEFoLFSD0=;
 b=0PFF5Xcn/OJXLJiL7hHgt68ymPQihncY3RpyRGBnTeL08dg1Oorc/6nBP3NUwn4epCFaeAFavttqAk0cuOyhjlP5BcCw4pN/Ii6JB0djnXnV+rZCUz+46e35jCZNS5SjxZSRkrkbgp3s99xw9Z9W0F7ko4NGhnhLM+ZBVZj/Mz8=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by IA0PR10MB7372.namprd10.prod.outlook.com (2603:10b6:208:40f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Sat, 30 Mar
 2024 23:30:07 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::b7ab:75e7:2cf9:efc3]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::b7ab:75e7:2cf9:efc3%3]) with mapi id 15.20.7409.042; Sat, 30 Mar 2024
 23:30:07 +0000
Message-ID: <84d6311e-a0a3-4fc6-a87e-e09857c765b3@oracle.com>
Date: Sat, 30 Mar 2024 16:30:05 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] NFSD: cancel CB_RECALL_ANY call when nfs4_client is
 about to be destroyed
Content-Language: en-US
To: Chuck Lever <chuck.lever@oracle.com>
Cc: jlayton@kernel.org, linux-nfs@vger.kernel.org
References: <1711476809-26248-1-git-send-email-dai.ngo@oracle.com>
 <ZgMToHNkkGEHNb/y@tissot.1015granger.net>
 <69914825-e9d5-4859-a5a8-60d17e8e8bf6@oracle.com>
 <ZgV5zwR0q/vjBAtI@tissot.1015granger.net>
 <88fac8af-c194-452b-94eb-7658b9056246@oracle.com>
 <c97be8b9-c0ba-4f2d-9340-78368008ba4b@oracle.com>
 <ZgbWevtNp8Vust4A@tissot.1015granger.net>
 <97387ec5-bcb4-4c5e-81af-a0038f7fc311@oracle.com>
 <ZgdR48dhdSoUj+VM@tissot.1015granger.net>
 <09da882f-4bad-4398-a2d0-ef8daefce374@oracle.com>
 <ZghZzfIi5RkWDh9K@tissot.1015granger.net>
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <ZghZzfIi5RkWDh9K@tissot.1015granger.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0059.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::36) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|IA0PR10MB7372:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	grcECs83a1B8N6FxHA6CF/AVbP63MygHAQEW4wentr2BswhtZFE2Ure2NwfWtPcpEVICnzdZFSJNw/zgu7AHXiInXPw7zFk4FScrdVhGAlTdzECpgd5hh3eFZsyxbvvmrVhI6gpKYY9vba6ZaaWg/MBSv19j/dXPsBZF0ujEzA0RgyghJXSJjA8VW4qrLzwBDX4V20igPBe6BMqMaytqB99jXb0vtGPC7pxh+NbObb5xERC2lMUNAiF/L3kHTVCq5JJoohFcV/RrHrLwSLNXP3qn+y/VR0FIuSyHyGRunmgiSpp8gsSHP50bDaqlYqRunfyxUxyDuo0pvgPE58XBMxuLlaD5O/J4O+6T/nFMN8zvFPKoEFtTir4PTc2f1mOTLK1W/ejIFUR5fkOC4+dGlYyWz8xeva5hSV1kATzxUAFucFmuQfIAM1n0E7925yIpIoomx00f9XcO+a1Setq3pM/N5fml48ipw62W5qrAPTzg+ko9cEZLKG+6f7tbCBgXFxOLztAh9zaqaST/F7ZQkSC4uEQo02LY1dNx1hDhQdBxBJNLdTTRCJQ9pwENlXEhDcCTNg87XzIV/2YhdQ4g2066fEJkMvt1TwaSRoRXc0AjZsCDyCZYUqdXPFnc2a0JOuovU9EuESZaKWL/JvWc69P0kweJhE+gKY7qIlprYpE=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cGdPV3dQdURhbGVFR0JBNTM4M1BuakNVbWZWbVVnRy9KaFVJRmJqaDFOZkJS?=
 =?utf-8?B?MXlHc2NCYURzMjMvWUtkWW9WWVl4Z210K29QNGMrb1ZUMmFaNlB4aktPWTBR?=
 =?utf-8?B?c1lrVkpraURqNUxXWVhuUEQ4S0pvZ3pHNTJjUkVGQmZ1ejlKTnVwTHFLa0pB?=
 =?utf-8?B?Q1RTR2tOUTBVSmlHZnNMR3ZzazZ6OVpBT2l5RmRMK3IzSDJ2MTBPTmFBTHJB?=
 =?utf-8?B?QnJyNmNJaFBLazV3RGVVNUJyaWVyN1FUMURUdG1jMlBFWFFLZmZXZTh3a2lD?=
 =?utf-8?B?UTNDMlBkSmd2YXF6UldUYkVrRkQzSGxtc0tmOGFhYlk3Mks2VnVhdmlES2Fv?=
 =?utf-8?B?MkJ0b2VxNEZFREJxY1dqdVhmcE1wUzVuY0grTTljRUpsNUVwVmhiaUJzSlVL?=
 =?utf-8?B?aS9HZzRwOHlUcGdGeUFIQmVST2MrdENLN0Vnb3pzNUxMUXVKOEVBOEl3Q1d5?=
 =?utf-8?B?TnhxcmJmOUxDbXRTbGRCMnlldE5PdDNqNzNDazFZYy9DZFJmQnJVaVNFaENp?=
 =?utf-8?B?OWh4bHV6UkpjU2ZPeElqK042NnNEZVBraGtacG1PcC9PdTJvSUo0ZlRQblVq?=
 =?utf-8?B?OXo2TWZ5MDFrUmxDWTVadHU1aUpiMWtFTFFpWW9objhOK2hiUk1YNGk5Vjd0?=
 =?utf-8?B?aDYvdG1JUWtIZyttRS9vd01RNGdXaXlXckQwUWJKc0dhL1J6bkp0a1VFU29k?=
 =?utf-8?B?alhnM1ZZa3ZQeXpyYzc4R0hOQlNvK3hRS3lNbjFnZGh2dmt6cW5pdFpVR3BF?=
 =?utf-8?B?dU1lMllCL2tGdmxVbVdyZnZ0QkFjVVFnbW9IR01qcUpiUnk3b00ydWNNd0RP?=
 =?utf-8?B?OHMxNCtRZ2I1c1ZsNXNHdzk0N1BaVTZRSzVhVi92RVJjdzhBRkRocjZRM05E?=
 =?utf-8?B?dGUzdGp1OENDTFFHa2JXUS96YzB1aTJFZXRrc3d6YzZLa2trRWVxb2l4TnVK?=
 =?utf-8?B?UWNSVEFGdGNYOUV6ZXpxMHQzYXh6K0U0U0k1WEc5MHVrYkxUK1BQVG9NNHhX?=
 =?utf-8?B?UlpaR3J1enNIOFA0cCsvSnVTdWNwMWVmalJ5T09SN2c5cEw1aFI0d3ErM3Az?=
 =?utf-8?B?Si9XZ2p3bzJvbEhlWnVTR01obzFEV1JnNW8xaUgwckpyQmRhT0JIVVd6VS9t?=
 =?utf-8?B?RC9JdEtpdFNoa0RMZzhIMFYvcHVHQUo3a2w4VmQ5alFNVjEzRC9kallxdk9H?=
 =?utf-8?B?QTVnelpwai9nbEJ5WVpISVpyVFpGa3ZSVjdYYVd2Nit2RXhvWit4bUhJMndx?=
 =?utf-8?B?VEp0aE1JQjZHbVZLVFF1NXo2SnVmL2plTzdndUJjdG5RdGZlSVVlK0hYdWNL?=
 =?utf-8?B?eUFRQVd2bU1zaWs4SUxHNUd0NTNGTmVPWFprVkQxckdBOHZSVkRLU00rajBH?=
 =?utf-8?B?dUlaQWErZGY4U0V3WUNtaWxRdkdvMVFlQm1CQlp4a0RZNU5NdmhXeXJPRkQ4?=
 =?utf-8?B?RE04d1QxSTB3bEQxMHdnTEFJaWIrQzNRWTVmaTJibUZKT1Z2WXpPMVMybUFT?=
 =?utf-8?B?N2pXa1ZpWFBHMlpJVjJaNVhoS21DbUVhMmJRMHY4SGx3S3IyUXovL3BxaFdV?=
 =?utf-8?B?UzdSZ29EcGtxc1VvRVJZM0UzRGhBdTAxTWJEditCUzBReFBVeW9WL3VlYjN6?=
 =?utf-8?B?TThkYTJzS3UyRDhyYno3cjdhbUF1Q0h4bVVYRXYzQzBkTWRQekF6Szh2Ri9I?=
 =?utf-8?B?eWdHR0ZUMmFiaHdtT01nSERRbEcxT3ZwcTVockQrWFRBSHFqcGhJZU5IMk43?=
 =?utf-8?B?a3JsdWJKcHd4UXBYbDRlTW9aR0lYcUpyVndCWThyNm9sMzNzUEUzRnJLbmNs?=
 =?utf-8?B?a01Gdmd1RDcwSGhmaXhxd21sMUw1R1dPNkZVbi93SGxOSmI4SGs0UXV6dVJ3?=
 =?utf-8?B?Y3dDOHdFUmpvQUdtUVFDSTh6N2tKTmI0Z0pUWWpLM0hHTjJJWUt5YUN2a0Mx?=
 =?utf-8?B?TTRYOHIrNG5wRlJwWWFTUjhUbE84ZFNRSS8vSG1TZnkxWFpyZk50cG50MVVJ?=
 =?utf-8?B?QlJtYTQwVmVEdDVOTjlMUjhaRVFiRmRseXN3TmNRMS9KcTg4Z3daUFFpdUdV?=
 =?utf-8?B?K2dqYStieFNvY0FhMnlpUSsrUVFRM3F6eUtXUkdXZmpzalVScEh3V0U2SVIz?=
 =?utf-8?Q?iIXk5xulk/YDILswpHutMCv5A?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	qhleWE0ptzS/tn92ZanEpVvQUhA+BSEck4x1supfs22ARnCXf1PCVzEiBewkxXHnQo1PsuRzKthcIMb5RrOjUPcJ5T5bDywLUxiUVTq6UP7DSpkyBMoogCv3lkq2/DcMOpz6pT5UXHGZ0uwFpf3MNMy++HmAr49gcJdMHJwudIZwvzy+yACvzYV+ufzgt4ju9vo9z9uvXIFoEYArNv8SFCet7Nrn/BvnBHsy1pNQLMt/V339jTvTezPZ9DF4b8aGErgwDmOreE3BLm/rzGQQf2fCqSi5MwKfWv2sZFhYDVT/UxUL91ZzlfIAw8F85W3BjIryCc7zfMeXD7c7TPhbbELMJtScNYBUhJK53v7hJnA5dW03oJ8s8mdKjke41ZvH1bcqB9Dr6obO9wJdgaoIUE08TQPd1M5n1rfTXdI/X+jEjo6lfZTVWH+pqBwaSDrfa95TgxYLKUgYMMEzG2ppbQMCbCPEwhaEkd1cC6kA7ZTGTsB6DMEctcSTTbm+z8XFttz5LN3WqlAp9RjRyWLLBQrCFEUXYYMIKrNlw++Fcg0uovoP/4CayqFBkL3X47xjRrDPSxyT+1jXOJ2aio827J7kHuNGsA45k1Kip5Cc8xQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f807e1f-d14e-4743-5b14-08dc5111556d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2024 23:30:07.0535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SwzMVYSo8PLIx7Y/TIuVzJNVtSwFAVoomT620EvMpErlmqQQGj57WMxWNyN5Qw5brqriKCY3mY5+/UcgOkF/Rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7372
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-30_17,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2403210000
 definitions=main-2403300192
X-Proofpoint-ORIG-GUID: NVxdbQlFEzdJNwrAXruTn-3wV2orz9dA
X-Proofpoint-GUID: NVxdbQlFEzdJNwrAXruTn-3wV2orz9dA


On 3/30/24 11:28 AM, Chuck Lever wrote:
> On Sat, Mar 30, 2024 at 10:46:08AM -0700, Dai Ngo wrote:
>> On 3/29/24 4:42 PM, Chuck Lever wrote:
>>> On Fri, Mar 29, 2024 at 10:57:22AM -0700, Dai Ngo wrote:
>>>> On 3/29/24 7:55 AM, Chuck Lever wrote:
>>>>> On Thu, Mar 28, 2024 at 05:31:02PM -0700, Dai Ngo wrote:
>>>>>> On 3/28/24 11:14 AM, Dai Ngo wrote:
>>>>>>> On 3/28/24 7:08 AM, Chuck Lever wrote:
>>>>>>>> On Wed, Mar 27, 2024 at 06:09:28PM -0700, Dai Ngo wrote:
>>>>>>>>> On 3/26/24 11:27 AM, Chuck Lever wrote:
>>>>>>>>>> On Tue, Mar 26, 2024 at 11:13:29AM -0700, Dai Ngo wrote:
>>>>>>>>>>> Currently when a nfs4_client is destroyed we wait for
>>>>>>>>>>> the cb_recall_any
>>>>>>>>>>> callback to complete before proceed. This adds
>>>>>>>>>>> unnecessary delay to the
>>>>>>>>>>> __destroy_client call if there is problem communicating
>>>>>>>>>>> with the client.
>>>>>>>>>> By "unnecessary delay" do you mean only the seven-second RPC
>>>>>>>>>> retransmit timeout, or is there something else?
>>>>>>>>> when the client network interface is down, the RPC task takes ~9s to
>>>>>>>>> send the callback, waits for the reply and gets ETIMEDOUT. This process
>>>>>>>>> repeats in a loop with the same RPC task before being stopped by
>>>>>>>>> rpc_shutdown_client after client lease expires.
>>>>>>>> I'll have to review this code again, but rpc_shutdown_client
>>>>>>>> should cause these RPCs to terminate immediately and safely. Can't
>>>>>>>> we use that?
>>>>>>> rpc_shutdown_client works, it terminated the RPC call to stop the loop.
>>>>>>>
>>>>>>>>> It takes a total of about 1m20s before the CB_RECALL is terminated.
>>>>>>>>> For CB_RECALL_ANY and CB_OFFLOAD, this process gets in to a infinite
>>>>>>>>> loop since there is no delegation conflict and the client is allowed
>>>>>>>>> to stay in courtesy state.
>>>>>>>>>
>>>>>>>>> The loop happens because in nfsd4_cb_sequence_done if cb_seq_status
>>>>>>>>> is 1 (an RPC Reply was never received) it calls nfsd4_mark_cb_fault
>>>>>>>>> to set the NFSD4_CB_FAULT bit. It then sets cb_need_restart to true.
>>>>>>>>> When nfsd4_cb_release is called, it checks cb_need_restart bit and
>>>>>>>>> re-queues the work again.
>>>>>>>> Something in the sequence_done path should check if the server is
>>>>>>>> tearing down this callback connection. If it doesn't, that is a bug
>>>>>>>> IMO.
>>>>>> TCP terminated the connection after retrying for 16 minutes and
>>>>>> notified the RPC layer which deleted the nfsd4_conn.
>>>>> The server should have closed this connection already.
>>>> Since there is no delegation conflict, the client remains in courtesy
>>>> state.
>>>>
>>>>>     Is it stuck
>>>>> waiting for the client to respond to a FIN or something?
>>>> No, in this case since the client network interface was down server
>>>> TCP did not even receive ACK for the transmit so the server TCP
>>>> kept retrying.
>>> It sounds like the server attempts to maintain the client's
>>> transport while the client is in courtesy state?
>> Yes, TCP keeps retryingwhile the client is in courtesy state.
> So the client hasn't sent a lease-renewing operation recently, but
> the connection is still there. It then makes sense for the server to
> forcibly close the connection when a client transitions to the
> courtesy state, since that connection instance is suspect.

yes, this makes sense. This would make the RPC to stop within a
lease period.

I'll submit a patch to kill the back channel connection if there
is RPC pending and the client is about to enter courtesy state.

>
> The server would then recognize immediately that it shouldn't post
> any new backchannel operations to that client until it gets a fresh
> connection attempt from it.

Currently deleg_reaper does not issue CB_RECALL_ANY for courtesy clients.

>
>
>>> I thought the
>>> purpose of courteous server was to more gracefully handle network
>>> partitions, in which case, the transport is not reliable.
>>>
>>> If a courtesy client hasn't re-established a connection with a
>>> backchannel by the time a conflicting open/lock request arrives,
>>> the server has no choice but to expire that client's courtesy
>>> state immediately. Right?
>> Yes, that is the case for CB_RECALL but not for CB_RECALL_ANY.
> CB_RECALL_ANY is done by a shrinker, yes?

CB_RECALL_ANY is done by the memory shrinker or when
num_delegations >= max_delegations.

>
> Instead of attempting to send a CB_RECALL_ANY to a courtesy client
> which is likely to be unresponsive, why not just expire the oldest
> courtesy client the server has? Or... if NFSD /already/ expires the
> oldest courtesy client as a result of memory pressure, then just
> don't ever send CB_RECALL_ANY to courtesy clients.

Currently deleg_reaper does not issue CB_RECALL_ANY for courtesy clients.

>
> As soon as a courtesy client reconnects, it will send a lease-
> renewing operation, transition back to an active state, and at that
> point it re-qualifies for getting CB_RECALL_ANY.
>
>
>>> But maybe that's a side-bar.
>>>
>>>
>>>>>> But when nfsd4_run_cb_work ran again, it got into the infinite
>>>>>> loop caused by:
>>>>>>         /*
>>>>>>          * XXX: Ideally, we could wait for the client to
>>>>>>          *      reconnect, but I haven't figured out how
>>>>>>          *      to do that yet.
>>>>>>          */
>>>>>>          nfsd4_queue_cb_delayed(cb, 25);
>>>>>>
>>>>>> which was introduced by c1ccfcf1a9bf. Note that I'm using 6.9-rc1.
>>>>> The whole paragraph is:
>>>>>
>>>>> 1503         clnt = clp->cl_cb_client;
>>>>> 1504         if (!clnt) {
>>>>> 1505                 if (test_bit(NFSD4_CLIENT_CB_KILL, &clp->cl_flags))
>>>>> 1506                         nfsd41_destroy_cb(cb);
>>>>> 1507                 else {
>>>>> 1508                         /*
>>>>> 1509                          * XXX: Ideally, we could wait for the client to
>>>>> 1510                          *      reconnect, but I haven't figured out how
>>>>> 1511                          *      to do that yet.
>>>>> 1512                          */
>>>>> 1513                         nfsd4_queue_cb_delayed(cb, 25);
>>>>> 1514                 }
>>>>> 1515                 return;
>>>>> 1516         }
>>>>>
>>>>> When there's no rpc_clnt and CB_KILL is set, the callback
>>>>> operation should be destroyed immediately. CB_KILL is set by
>>>>> nfsd4_shutdown_callback. It's only caller is
>>>>> __destroy_client().
>>>>>
>>>>> Why isn't NFSD4_CLIENT_CB_KILL set?
>>>> Since __destroy_client was not called, for the reason mentioned above,
>>>> nfsd4_shutdown_callback was not called so NFSD4_CLIENT_CB_KILL was not
>>>> set.
>>> Well, then I'm missing something. You said, above:
>>>
>>>> Currently when a nfs4_client is destroyed we wait for
>>> And __destroy_client() invokes nfsd4_shutdown_callback(). Can you
>>> explain the usage scenario(s) to me again?
>> __destroy_client is not called in the case of CB_RECALL_ANY since
>> there is no open/lock conflict associated the the client.
>>>> Since the nfsd callback_wq was created with alloc_ordered_workqueue,
>>>> once this loop happens the nfsd callback_wq is stuck since this workqueue
>>>> executes at most one work item at any given time.
>>>>
>>>> This means that if a nfs client is shutdown and the server is in this
>>>> state then all other clients are effected; all callbacks to other
>>>> clients are stuck in the workqueue. And if a callback for a client is
>>>> stuck in the workqueue then that client can not unmount its shares.
>>>>
>>>> This is the symptom that was reported recently on this list. I think
>>>> the nfsd callback_wq should be created as a normal workqueue that allows
>>>> multiple work items to be executed at the same time so a problem with
>>>> one client does not effect other clients.
>>> My impression is that the callback_wq is single-threaded to avoid
>>> locking complexity. I'm not yet convinced it would be safe to simply
>>> change that workqueue to permit multiple concurrent work items.
>> Do you have any specific concern about lock complexity related to
>> callback operation?
> If there needs to be a fix, I'd like something for v6.9-rc, so it
> needs to be a narrow change. Larger infrastructural changes have to
> go via a full merge window.
>
>
>>> It could be straightforward, however, to move the callback_wq into
>>> struct nfs4_client so that each client can have its own workqueue.
>>> Then we can take some time and design something less brittle and
>>> more scalable (and maybe come up with some test infrastructure so
>>> this stuff doesn't break as often).
>> IMHO I don't see why the callback workqueue has to be different
>> from the laundry_wq or nfsd_filecache_wq used by nfsd.
> You mean, you don't see why callback_wq has to be ordered, while
> the others are not so constrained? Quite possibly it does not have
> to be ordered.

Yes, I looked at the all the nfsd4_callback_ops on nfsd and they
seems to take into account of concurrency and use locks appropriately.
For each type of work I don't see why one work has to wait for
the previous work to complete before proceed.

>
> But we might have lost the bit of history that explains why, so
> let's be cautious about making broad changes here until we have a
> good operational understanding of the code and some robust test
> cases to check any changes we make.

Understand, you make the call.

-Dai

>
>

