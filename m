Return-Path: <linux-nfs+bounces-3052-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B76618B5A5B
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Apr 2024 15:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA4CD1C202CA
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Apr 2024 13:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5380270CAA;
	Mon, 29 Apr 2024 13:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NebvIvb1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tYv0We8J"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA2F651B6
	for <linux-nfs@vger.kernel.org>; Mon, 29 Apr 2024 13:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714398207; cv=fail; b=MWAaIdGZiv/8CP18UvkqOs95P/km8FtgXpBAqVHgAoc55/0wTNoy1E+K9FhKmVzkaCVIHGSmVZQlG4sfs0nbLnC51AetI7eUgii0FY/v/lLkMLLzK2zEOa77QAiX3umBx1aQoPbv7DK2x3jaxYYEG2lWM22iPDTIjq07SUJ58yw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714398207; c=relaxed/simple;
	bh=/aPPeL8n4mD39WouzTozttjlqJIuhndI3viKoMQgiwo=;
	h=Date:From:To:Subject:Message-ID:Content-Type:Content-Disposition:
	 MIME-Version; b=Isu+Y/icwYP1kYklfGQ/zhzACACt0HYC6YZCOaRs5v924NfyKQ301gIfhv7/TIdOLgNpMkt34Ll1FtrR1rSRzPe5zOzKBtLGFo25pCjB/wDAc4vypuGLn0+xS7wzjB8a4AghvdaPPZPsZSnATfL4lhyfamalDXFMMnmhAErzoZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NebvIvb1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tYv0We8J; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43T7iD0L011682
	for <linux-nfs@vger.kernel.org>; Mon, 29 Apr 2024 13:43:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to :
 subject : message-id : content-type : mime-version; s=corp-2023-11-20;
 bh=ROCl/NySeuVI/gcIcc+lfI8UT9+QA9MTnUDc4lL7r3Y=;
 b=NebvIvb10WKUjubK7L1n3GmwlWC/6a9od8sG3saZYRB2Q2Bf8bbtKiNkNyjaj5pPi6HV
 8mdKgOTHq3zIXTP4FvIodLyHG5iTuuO0p1KsKamePSsIwJcYZ+EQY5l+YZt2sxzusebO
 XtSSn1ThMkdIq5maVDigri7TDTpYB6yTFp2AAzyOVlwvTRgPMGLYyPJbhfaPR5SoIP+b
 Xr9LqegmxzqhhfSBf95timHPbCLBV9oIFejZjxkTwylkv8BofnxDafSO4drDts7mp/Hf
 sPkUKPEu8GhfulHjbDAIITfBuhcwUzwa5Amyh9gXn2K94sfsCHHugj0VsVV5WQjU+034 wQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrqsetku0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-nfs@vger.kernel.org>; Mon, 29 Apr 2024 13:43:18 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43TDVmx8011374
	for <linux-nfs@vger.kernel.org>; Mon, 29 Apr 2024 13:43:17 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xrqt6bsur-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-nfs@vger.kernel.org>; Mon, 29 Apr 2024 13:43:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g0KzqsuoYXUBYPhSdjqSTNusZLvAdddDxvU2Z5CQowRcAyPF82jJ/4z44At3iFmm8CgfmsFhlMcztZMYfVcBOzEE5XuRKUlFv+1uGz7f8Nnh5D+crK5+JGj5qg9z9UOoeMPNlZIwSPhZHqD24pi54p63VzC9GGS16SbnRcegU2/8a3Jxb7DH3IgFhbqQuNAsuKsP5tXvC93g6bvgPSPUY8wC91yjNcGYeRmtYS+UMyTWFqaTaEqt/UJmF33demF3JP336UbRLKax31wh+0v4sHYasV1YKiBD2vSZoPZmgt9pYLPjudAOL3ne/sVEIpMU/tfnIcb4C/AVjUqCW4MsEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ROCl/NySeuVI/gcIcc+lfI8UT9+QA9MTnUDc4lL7r3Y=;
 b=nHiFNpop9jdLkhaabjO2puf0IgKTW/k7VHhtMtm4sKYX+O5MhyE4hrtsbSh+x9lhunIJhDSWs3sKb3TGneZbqjG2pg68dSJRM03FEQ9fXOVArH5iu6e7xvKYujE3Qjal2WwYY5zknMY5M70vbTqgwlfLOkz3QbDtcJV9djcgMax9Uj8dFK3oPpnOettUgGevvdqQ6d66ZKWwSxFc2SXiNfNzvieAE1ocXmoY55cxzoggd8VtBnEnVU2PAtmtOWxUW4n9gr/gWPCR6R3FmQA43N8rO/vS2M8YwjYg1pzVuPLsZr4Jm70a7ixdkjcx96igUs2mWZ+VHZzDJM2XMAYy/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ROCl/NySeuVI/gcIcc+lfI8UT9+QA9MTnUDc4lL7r3Y=;
 b=tYv0We8JJS9UWEL+Lj01vdX2YTQrtwvCuYOFyOYRrDIEifxlriqU7fTKhafVLhlFxLY6W/4GGBcL/D8Pt7Uee7OmbGhhYvydTBhcdjXQsgDANxhsWXV+5K06AlW2pEyP5DsKQ/S6WzpnRfph3aTOPKnHp+l96oyWXV1n9DBVJM0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA2PR10MB4553.namprd10.prod.outlook.com (2603:10b6:806:11a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 13:43:14 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 13:43:14 +0000
Date: Mon, 29 Apr 2024 09:43:10 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: linux-nfs@vger.kernel.org
Subject: long-term stable backports of NFSD patches
Message-ID: <Zi+j7lfWYPFNDgtL@tissot.1015granger.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: CH0PR03CA0213.namprd03.prod.outlook.com
 (2603:10b6:610:e7::8) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SA2PR10MB4553:EE_
X-MS-Office365-Filtering-Correlation-Id: 93445f5a-f3af-444c-8187-08dc685251b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?J55cejdoSQmlIQmA0N2GIZNzR79JO1a4cY7vkWn7vYCaqOay2r4uw4Con710?=
 =?us-ascii?Q?fT6THtJYIQqBljTpSC4kuBzXm3q9OOC41tQODefI8PF0ZwMvEBrT+2XT5MsE?=
 =?us-ascii?Q?/++XuSbgCb3PO0cbYLza/doVo3n076PaApBjZwkI7lIxefmXM8DJrrIuQF51?=
 =?us-ascii?Q?5WYchac72FriiPRqvbE+CmXO6lBnisom868o8BfRlpJF5NNkIeJm4Nd3Qzhu?=
 =?us-ascii?Q?6UQHytll6lFxZdtvtq5rl/8Oeq+WD5gMbFE7bzX2NBifmqaanYi6+bYywW9x?=
 =?us-ascii?Q?/t2TPCN1qAD93l7k8IMpt9mQUDZvBTakN/7klks+aTaRomKCO0PLzAhxkSQC?=
 =?us-ascii?Q?ogQzPBkiv9CNlGO35sYAd0jb46vI/v2i4ZeAcvWsFZ3us7BFHSmh0i6Ap9f/?=
 =?us-ascii?Q?buew0PjZWkIl0hyt3Kf7uwHbewLcvQm9938Q7ydioUA/xLMoTAvmqUZgfndL?=
 =?us-ascii?Q?fbEptDlX6ZqZxXNRYHpvOtpXGtjPr3Q0czwMIdkRM1OA8/Mz4Hmu1McoeqNn?=
 =?us-ascii?Q?CFUsNLW7N+Y8CpptS3aNS24SIWSL8hAkRCN4qmbAmuEIAG56XqUK1+BxDqjv?=
 =?us-ascii?Q?XAT2yQbxkffsPPZOeh77M4cUNuIu5MTL5Z62Mbjkt6EChNfbxGlH3XQRyoME?=
 =?us-ascii?Q?s78L70sze8daU97uajCYIlKpmmsdDFX84qTILUPDvBLUP5Xw66Mb/D4N4xfS?=
 =?us-ascii?Q?o6C9bogR9yTU/kEX2Tn3o3GjZVDf++EBTw1c6+KSCmoKA9rsvmaOOTcoulqF?=
 =?us-ascii?Q?mD49WwtZlMRsL98vDvXhuLWNZe9D9mIF2EmKx5jj0dKBy0pTMF3S7x/cNGAE?=
 =?us-ascii?Q?iKuxZgztYxdAXpec8ID6A6CQCvvW7lSwuLrDW0uh7IvkaY1z8dEhTbqSwU0I?=
 =?us-ascii?Q?r6zPJYr4OCCB2o4pp7FHay00l3llIFRa4elfU20wmrMtTeaNqVoCz3UHcZ/f?=
 =?us-ascii?Q?UecgR2qHAHyib/nC/j58DEJghtqASldJTRCno9RMybYQfa/LEjFiK+kk7lnn?=
 =?us-ascii?Q?/+Lj0v1Ezd8FoAKsSCx0Klqwu3u786mV8U6h0ZpWtkCtJ07OHQIipMPBLf/S?=
 =?us-ascii?Q?o9/bmS1k1m080jHxsL7vdDfZz5Ct2y1ysAIhpEHaHNR5YdDjLM4f4/FH5GBa?=
 =?us-ascii?Q?v5LdiJ8sNWVEtz3Vf2ZAH3Kb3wlOWCaVp2q+zNKgUXMNvYNFRw09mp0TpZIs?=
 =?us-ascii?Q?/Q6mOQVdENm2hQ6owTWTL4zK8lldjjaK76zxX9zMOk2lOEB41uBsamqtmK6r?=
 =?us-ascii?Q?Irfchwl0taQL6vsl4y/poz09MhxqIaaP1Dz+rQe5yg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?yquAhsgKM4uORElPB97185ndP+yRBkDtu46n65hopIvJDYj9tptGSTcd3J/u?=
 =?us-ascii?Q?y6m5S+zQ2g+DXA334JNOZdKnfP4ujiNwaBMgJs7YCd/lJrUMVDX7uNjbFp2Y?=
 =?us-ascii?Q?d2cjEOqVfLKnKPv9V557jz1BJuX9Rqt4Hxnpm+kWx2DMXBJJWljU0TAh955e?=
 =?us-ascii?Q?2E9hT8ZU1ZduabPkDd5bMXwgTMXE7hhx12pVFGuYIri5kdRwN+COFdaDeRbj?=
 =?us-ascii?Q?o+jRihF+haCVVK3Yr6QLEGnC5TeYg0iN1hnvwTS3L63gP+isA09JN+xANx1s?=
 =?us-ascii?Q?ZC1h3AC2MjwXmOu2WkKIfwieUCGiIq+QXoNf7L3RUV1974SzyJZA3VcMH+G0?=
 =?us-ascii?Q?Cs/spuLi7hKzIS42+CL5RcwXk4FXS+QN9Kg9bG0v63+7OnpmRDeO8ym/K5Vp?=
 =?us-ascii?Q?5xci2ox0YN7EOtmX1cS+qH4iwyXa+UWMbXpgPmVNv1bD44psrSU6c9juOIn3?=
 =?us-ascii?Q?cOj2/JasdUCnUrf20FVs7c+PfQnxvOl1JbtAlhCcCT7E4RZZWtRQMw1V4tWj?=
 =?us-ascii?Q?MqygdEYfVSK2oIf9WALM+7oMogLJfBuHWkZ6nTpw1bEk9Wg6A3VT5WFwKrwl?=
 =?us-ascii?Q?XCjs8YKP797P0nsZQaU7tggGl6mdFqfT42me5+8jGTJ99ml+KBGUL1HbX5zF?=
 =?us-ascii?Q?TsIyP3Hc6LdSl3gSVAQuyXZ0z56ExTsIXaSWUwNxITXhDW7YRkXwlJUBA4O6?=
 =?us-ascii?Q?BjZuIRdJud6Rl96mgPixel0WuJYv++2mMlHIkrKnyNpuIrhfDnU+GzCmSQ2m?=
 =?us-ascii?Q?9XHXU/iSRsM9zwRWoPBa5Kd66RMnZuC8M0gHOXKcxvuckAucw+1tmBhTAZxh?=
 =?us-ascii?Q?kueNSvkG7j4yr0AaTeAGRnauyeIdODQdGz45Nj91g24X1fMPWFhrYRHsQCFC?=
 =?us-ascii?Q?T3GqeDE2DWv2cDdoJG/v3ikL0edWhKVt1YaXzMIMyJGXeh9qTn7yEqbUA3fJ?=
 =?us-ascii?Q?BGxeqT8Cvu/RKBshDiM9dMrTttB/ql8Jg+rWcUHD136IBWLN5JeLb+7Fg/tO?=
 =?us-ascii?Q?yStmTe+e3vIbMqfGaxnfS4WXVIsAOhdZGpM5rQDzrrn1w1LBrZRB/0vbWdsk?=
 =?us-ascii?Q?fNY6xjQeHXO2rDKrSCoyWbCju4lP/EVxxlANua76sdEPgGICYeugYq9uO4wH?=
 =?us-ascii?Q?KK+QKR01ceb5f9SpzypFCTFh1yz7nNSirYvhPjQOS9QwO8vg4D6fjakA8YnC?=
 =?us-ascii?Q?+rpPIWV8UhZnRtUPeNwInNIPjAzQ3UA9xjz60Ep76B/wAC9Oon3FiHQhH+m1?=
 =?us-ascii?Q?3KG+kPsmgrbs3eKALVVNh6NUffqhgQXqiNKUBSiSznZGmzl5172jGWUXggnk?=
 =?us-ascii?Q?8Wat86wEQWtpSfgLJa4clNuO/m3s2W1KZa+97TKxtdeUNs13bYy669z7svhR?=
 =?us-ascii?Q?2I394nn+U3YmQEJVLS1a9+XCfeUy/I6aJ0YjqPXVKqrHMYJWowYLsoAGUGQr?=
 =?us-ascii?Q?0JC6Mke3nLFdWXQKqUScFzp7JBKbVoeFYtX8lGgwxw4PRj0DSKJWUVsNVN/J?=
 =?us-ascii?Q?dKTALI8Qvq8aT8WBADtustaXC6qE536EXiT3Utu9x99exU1m1PNPeuR86t98?=
 =?us-ascii?Q?CsdY/8yMPinuqs60LZkx21jESHF1l/V6Y+UFZwjLAKjBRJOtRvo+aZUC6lFY?=
 =?us-ascii?Q?PA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	s6ZjZPy7VMZMVFU78ZayK94TD4X5SoNoTpA3wNlZid7JO2Yli2v9hsis6kSh4LzhBIPVqVRBF9w9j3IfebSsoo99asPzLxLJFm+aMkipXhV9WU3ca9vLrSo8h+fymxtWeOBUyNqTq2o3k2luWjKgcoBA5bYIdfRPzcMPs+svZZz2CEWUZxQtOOPa4nqn9UMUH01t8umvh9Tm9L6efPT9QTumQX/k63JiZ/IBBf4NxOsVl0LPwIS4VrFSlsJ6iFd1TIGxDI0/Qkhxi+C/RN2e3xpaj+6D01TfwkHErNJgEblgalctxfuDSryqc7kErcCPn0OpJk0NwF2CrCrth81ZhIHjWuurZI4DoM/idwnG3hnkdnyAhAR4JG8ZiEni+ntKxWsMBmKSF8KfrYS1nXsCwBskzY4CM6VhpdPHLTo6fi33BpjjF3thjCe6JAVyh5GsMcWdH6Y7zNWkpkrKuwqDWOC0bgS2EQ8Gr5+74tB4ixoFAEVLsrszzsSh5qAbtRgY9cQzCyAD4GZVgTQ5DShBwUtUXPgloYCd3/XvpKjNtyqJI+nn+F4f63Uy/J7LEzHz6aTTgs0a7Wq670fGvzu2DxGA4z8hgRDKwiQID1+Fjlw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93445f5a-f3af-444c-8187-08dc685251b7
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 13:43:14.8257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EhFCJOXs8sZKwTepEuIbgFcCT69P/5Loy28DTwbrlYicgZZ4sJjN3sWyVQSuQV4js/1UhzFZwbmanzg3QgWfpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4553
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_11,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 mlxscore=0 suspectscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404290086
X-Proofpoint-ORIG-GUID: z0yLpNy3C9Yhb-vS4UPbK5MpOoI3vZZ0
X-Proofpoint-GUID: z0yLpNy3C9Yhb-vS4UPbK5MpOoI3vZZ0

It's apparent that a number of distributions and their customers
remain on long-term stable kernels. We are aware of the scalability
problems and other bugs in NFSD in kernels between v5.4 and v6.1.

To address the filecache and other scalability problems in those
kernels, I'm preparing backported patches of NFSD fixes for several
popular LTS kernels. These backports are destined for the official
LTS kernel branches so that distributions can easily integrate them
into their products.

Once this effort is complete, Greg and Sasha will continue to be
responsible for backporting NFSD-related fixes from upstream into
the LTS kernels.

Here's a status update.

---

I've pushed the NFSD backports to branches in this repo:

https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git

If you are able, I encourage you to pull these, review them or try
them out, and report any issues or successes. I'm currently using
the NFS workflows in kdevops as the testing platform, but am
planning to include other tests.


LTS v5.15.y

There was one new NFSD-related regression reported this week:
"killall -9 nfsd" triggers an oops. There was one missing patch
in the backport which should now be queued for v5.15.158.

I am continuing to watch for issues.

You can find these patches in the "nfsd-5.15.y" branch in the above
repo. This branch has been rebased on v5.15.157.


LTS v5.10.y

No change here this week. I hope to restart work on nfsd-5.10.y
this week by backporting the handful of NFSD patches that are in
v5.15.y but not yet in v5.10.y.

You can find these patches in the "nfsd-5.10.y" branch in the above
repo.


-- 
Chuck Lever

