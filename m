Return-Path: <linux-nfs+bounces-1430-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6358983CD6B
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jan 2024 21:30:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C94511F22205
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jan 2024 20:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88D813541D;
	Thu, 25 Jan 2024 20:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XH6NmhkD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TOwon79K"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B747E137C20
	for <linux-nfs@vger.kernel.org>; Thu, 25 Jan 2024 20:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706214600; cv=fail; b=GRlRg/xYmMRwVzaIG6E1FfrKwYdk0jn0Vv03yupn/MWXhutM/a5E1YaB6doOIthrNvkHajKy3noUlSCZHAmHVXEvOTHlLKwTbgXoCsQCnm/RfUyXGR9eZLdpxoV7cOR+dqF1X95osX0vAexJbNzusI+biMIsQjH1a6uqHlja6ws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706214600; c=relaxed/simple;
	bh=2ID0U6xZDsMlT7TgGL/C+giyXokYFQj4iWsYlOijV0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=J8qP9zGopp7cYDUoMMoGktJFg/JpvlqHykAU0M+JG2+XWtE4QUV1P2Mxd6yq1OwM0gc2ffyYCnSaHa9ijRBFIHhwBeEgYVjKg81oBjFUdx+kYaRiIvP8artA3+YRKue0xtPcdBIv0SK/AilFvleHCXD4QYm9oiaIzDvFe5B9Wic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XH6NmhkD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TOwon79K; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40PK43cf012784;
	Thu, 25 Jan 2024 20:29:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=U9DbAPzmVDT5fA24dv6SleKbduXcNXf9X9loH+DCYJY=;
 b=XH6NmhkDgbeW+XtvSdOpXfLpYWwv2FE2klYMH+Z2m1e9uXR8Cy/W4i3aIa2OcJD6jCDb
 KBBwXah37QGiyJfslnGuFC5JexJ63imOAwIVZXIfUOJzqk2l9VtyDE6BXZLuHh/p1cRO
 BOpueI5hHFsvgdonChmflDe1MPxKqKmnYj8WbOILyIpMJizQpWdB0bjxhiVbP2o2Q83W
 becQWuGIzFRsMB7//ykHDI+D3JXO8QbxRz+eDZQBow2P5JCu8a/EdYvrbplEOFbZ5/3e
 7ReaypnuXCucBLzBQYAiQ/dDLlYROzPMOSP9w4Uwrc1tQzIA0n3zAeqkq5EODhgSXvOB zQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr7cv08yb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Jan 2024 20:29:52 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40PKSxfa030795;
	Thu, 25 Jan 2024 20:29:51 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vs375e6rn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Jan 2024 20:29:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cDF39iMvCh/wsv1vvX1NvIzMTPozhHzrh3wY2+DfwypYUJcf6isdVjQ5Dp9mYjuBIIqNPCBbaUIalRCQi4/ARC5AE+ZXEHWhfD5B86zhpTFuavZeT5lgR9EdXC70oX+iPX+BnI6u4FphpzvcM+CKJTcEiutWUqKaOEBRls3IBGtnA+g0Ep3dygfWTreftC0koUJA1jEdXPIUeNxdBrn8e1la7hB6ycuC9RTarmm56dlM0GA+XPaFHwmR+I9RgjmD/k7wn5jbAjdDMreR9mLr+UPA97ZaCzboJXrdPIMWjDTcY5LDLYRYxo6hOdCI+Fru5WjCYKfAYlV2ttYTl69UVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U9DbAPzmVDT5fA24dv6SleKbduXcNXf9X9loH+DCYJY=;
 b=Mt9M8Z7O408aYnj4hEjJf3y+Q0UxNzir9kE7icMZfrXwIL4B3m86SgBCqbIt3ScgUSbHOUyaUoJAl/y2nfdzEys1sxkymKWWgOUfD838BkPYEVIwvrFoGQziHZbVrwb6BLswBgHjrgwJ9nEtinJjKHXOvTdd0U0hHXeG3NWyeWnf5tuITnmPNeZpOEOe40yj+gSa9lb9vQbVV+keo1quT1SMda0F+grNibOooE2w2P3immo1AX/7ePT8B1F28cRFZK+m02S0Cq8eE25luOERg+7qvbiHwk1pWVG64v/lxYA0PbFL6JQOHDrUDFrZFjPACmNKWp7H15BDVhdW+HIG1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U9DbAPzmVDT5fA24dv6SleKbduXcNXf9X9loH+DCYJY=;
 b=TOwon79KtSglYxVbqjQiR8VHxOIp9bA+QYfF/vqJnSztxTqp4DMSMkrvRDRyjwg2dIrzkxzBBXyw0a48rFa0pJC9utAjAsWokyAky2RNXKHaOzI2A5O6Wp+1+tjG9LdISDBdYV22yWGExge2URUTV6dwGby7e0QJ8sS62bsh6sU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Thu, 25 Jan
 2024 20:29:49 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5475:bf96:8fdf:8ff9]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5475:bf96:8fdf:8ff9%7]) with mapi id 15.20.7228.026; Thu, 25 Jan 2024
 20:29:49 +0000
Date: Thu, 25 Jan 2024 15:29:46 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <cel@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH RFC 02/13] NFSD: Reschedule CB operations when
 backchannel rpc_clnt is shut down
Message-ID: <ZbLEul2xcYFge2ga@tissot.1015granger.net>
References: <170619984210.2833.7173004255003914651.stgit@manet.1015granger.net>
 <170620013252.2833.10156142379669175540.stgit@manet.1015granger.net>
 <736b0c878f228e28e0ae18974efbddca17c1919f.camel@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <736b0c878f228e28e0ae18974efbddca17c1919f.camel@kernel.org>
X-ClientProxiedBy: CH0PR03CA0362.namprd03.prod.outlook.com
 (2603:10b6:610:119::9) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS0PR10MB6271:EE_
X-MS-Office365-Filtering-Correlation-Id: ee6c00ad-e147-4e49-ca25-08dc1de460a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	WxSWddfmoa4GraUQRqA8Hh9ZaFT8ncs52K0xP0tLnvVQNE3SQtaEnh1lZiEVKNekKVeGKnOt8Qo7GLBnc+kBno3/SxBusn7gKZ+sKnfD4NBNHI3TeBWm4JLmLDx3TxKxIWFNT5jgTNHGUmu9RTPfqFGBPE4dxtuj/pYYbr3TneseEv9oWtzut46czQUJsLsYSxSZUK4G1Q6C/bb6v/CMZOuhHQegLpJi9uavkZGqbSR88sR70/5d5yqSM/BBIJpAOsxav0InWdMh0c3y12RLrLypbGJzI8LXzfUONZxo79MRs069V19drQAeuk/ARdIlojd58EKFesKXXNJZ99et2YfYG6c0SUDqkoRIwzY5qvze4rY1BOVq/yxG/z8zVuaR3AaIv+TKqkuq6M8X+N3MC96No1m/LYaRXngnRbayvSps0ntDWFiGTDOg+M8nHpACZE57xV1EwhnBa687TjMsYPUbbOtxZQxCcAA2BdJ0mo3iJBVyi2VmbVGBGHZHDB3K6qX/57mOih3Si+IF7V9zQIrD8WWr0TCxvT2k0WtcGTMZXVoZ4RNSIWdrkZoOLdfm+3go1hUxfhMzBTq1wlWRUKKIGV4fnt5lWmilrn810bM=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(39860400002)(376002)(136003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(38100700002)(6666004)(6486002)(41300700001)(478600001)(26005)(83380400001)(6512007)(66899024)(9686003)(6506007)(66476007)(316002)(44832011)(5660300002)(2906002)(4326008)(6916009)(8676002)(8936002)(66946007)(86362001)(66556008)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?PND55GiCTCtDw+8FJ10vaNhudw8NTXP/xwMtJzAAmL8i06V2o4JYMP13dl5Y?=
 =?us-ascii?Q?pFca071mJtC3mw4z9IqtvO1DKnJKdN3jcYSRxYDkbe2woa2KW1x0eZnwlh08?=
 =?us-ascii?Q?W085f8lmo/PWAD6rhG3vZFMO3Kg3Eg8Zk8xfyU2rh1z0RDM9Jmj06iZM9w6K?=
 =?us-ascii?Q?nYzjDHF9G0CzNdsSLS64UC1Txw1w16feo9nw7f2IAAo8EsbYRLY9F7dYx+ga?=
 =?us-ascii?Q?T5NjHzbE0QHkNKrCDCvAJSIxaNl7QspUQyBBakqBXnPmJ5IE5ZLtPjSqlB2w?=
 =?us-ascii?Q?JGOXJ+/uLgdPRqi4qyUQvtOG70xGpcMTWkiu6oSWcFMVG5lzriCTXBWEh0yP?=
 =?us-ascii?Q?6QDnJVgHjWXLqoEnV97xxOp+8UaOMC/Z/Wi62cDXgw+JVLYeVtIs2eEseYUQ?=
 =?us-ascii?Q?FRaZvBJryeWzuE94bImKYCPvNU6xdTbiU6E/LNciTwKBidVpwbHshNqdXyTx?=
 =?us-ascii?Q?KMWcrE+0A3l3IhmYcymAIiG7dYdoLzME6kuvD+1rHsQf2QDU1MUrnAfSD/Hx?=
 =?us-ascii?Q?Qtj/m8F0XFxyilSg6lpoZctFoEQtd5NocIYWYDFx1pT5+PU0GF0WkhSoazve?=
 =?us-ascii?Q?mBmfTKvNQCnlmECmUaIJnJyA0lqH0S0EAo06btSg+4AbqOsFshQOg27MpAKq?=
 =?us-ascii?Q?4gO4Ci/QPDyoz9f9HDse3Jdhk7sRpr7dBH8oaQRBHPdpoy5QpeumxI2H28ce?=
 =?us-ascii?Q?uHTDDv+mqPJqzy03zxQ4qyg4hd7hOEgoLkZE4cCQQz+OZrunJbV28Pdr0pcd?=
 =?us-ascii?Q?9IExLYj6cBAIwAHLDYNJU6lBveKHdJqdRdTDVRJkTCNp4V2IOixe9mG/ZdtY?=
 =?us-ascii?Q?7+BXiUj7in86jMEDmyVs9y3EFaTmVVuNPer2CdY2Oy/Pj10jO/5pi355Ikzh?=
 =?us-ascii?Q?/yqPmKcpJOhJFbyt1OrnWI/+7vb0NdHZxUQ4CRy87SKsrsbRaj/jyN64fCdi?=
 =?us-ascii?Q?HtpAAD78U4WUia2RDrHY5VvYBedtsHVNf0pgaZM24iTBWJi+XHs+zdfzE39g?=
 =?us-ascii?Q?v2iMZU3dyHFZgUQV0cTzlKlMoBnbaYrb+y2gpGuDwRHqUCVQeRH4VbEvJJqm?=
 =?us-ascii?Q?4+1yKsXAnAbp39sMPuyyXVI9xTDIRLZax3/oDWqqaY/kOBtsbbuAcklwhRhk?=
 =?us-ascii?Q?/lO33K54Sq56ZHUf3M1KdDlUNmtNa/NnJFzTeCKGf3FA6vteRC68JorYcvXD?=
 =?us-ascii?Q?sXSnv8hNCbxtCVA6HrcgEfY9QLolVgu8nwiVtoCXDvB7ZQctm+EyqcaComVT?=
 =?us-ascii?Q?c2GtjWBC/HHklYsoM5mHlh8HuiSLyB2JFUjUYrhQL6xPlF+IteAYp9epBt/7?=
 =?us-ascii?Q?r+v18Eh7ry0Ky5Z253XxE1NtPUDrjausIigW+gqhSM/kLcDMhjc3BGC0FhqQ?=
 =?us-ascii?Q?v3Hj1tXyq4YuddvX+Y0AHK4ruC43x+XozFjPMoxL1XPiEybXd1L98dVs3W+M?=
 =?us-ascii?Q?gUMDCGRuMAyf6/HDbk6vQsYkj/Mn/mP/SzRgMKNU9J+XSUwRc7xFXAYrqJ7O?=
 =?us-ascii?Q?PDBzSAYtoAsKtfF36wcEOtyIehTTysx/qjrT19HYZpCPO/vIK/ZM7biAMM76?=
 =?us-ascii?Q?M+V9bdXEi96/MHHHXpWKoAlXRv3buPpXJf1tDnBBFZq1oIuXUQwA+UocLknM?=
 =?us-ascii?Q?Tw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	/rJL4tbFVx9wJRG8uJm9zGC7cXn7Akcx9MM5f1gBWALg57HC/StqsTOQtcjIQAg7RaGcFk8I4t9wMOONYQgdnVf6l2RWtYPWncQ788hR2QeDjrdWMcAyJLVrWwNh6bmdfQXccUqc4gejhnVK62DXsUtjxaP2xYCrQWeoJSgZwOuvbx6GYiJkv/uX3B3nF0uJOAmVawu+zy5Mh/mm27A50jP8ixAQujCycr8CuPjgBLauZeeYkQ1yC2N/JNC1zqtWzBaSKS3S54Ve2cHQTMnu0fpTvYhi+vZ8u6aKo+BBNajcgyTctdhibYCjKaKICY5L4PMhImMRlo8aTmZ8QMk3Kn0chFBQgSRsF08TWgOT8z9wfahHNOEJq1YwW7MJrK/wq5dtnI8FhegA33+fiax3o3xIG0/p/QHFgS0UJ0uXB+l9yezH3m5HRg6Dh0ksmPcU6tejlCM9OYBNXtPnNpHxiuTH/WihEsqFfGWfdGk/UOWHEPUfzJ35P8ykHoHQTtFyNXm5ybDTmXtk6YVkZZHuxpjX/jb3WHwudMeUN6vEMosnnZCGPjZoUNjUIy4xWOiAHf8EfJTxHZ+4W+bn2INN6qrP3BChyStUT9vGy4kCsTI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee6c00ad-e147-4e49-ca25-08dc1de460a9
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 20:29:49.2761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SdN/wLM2NrMtWwHk/odejyIQWVR5aCkeOiCa8Upzxs4eAaXWsEcfYel60aaDcbgVPA4XygtXHewVjGw89fWviA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6271
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_12,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 phishscore=0 bulkscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401250147
X-Proofpoint-ORIG-GUID: WCWvIZU1-fDaKFs-Q0I_I8xajBKX1U9s
X-Proofpoint-GUID: WCWvIZU1-fDaKFs-Q0I_I8xajBKX1U9s

On Thu, Jan 25, 2024 at 03:19:41PM -0500, Jeff Layton wrote:
> On Thu, 2024-01-25 at 11:28 -0500, Chuck Lever wrote:
> > From: Chuck Lever <chuck.lever@oracle.com>
> > 
> > As part of managing a client disconnect, NFSD closes down and
> > replaces the backchannel rpc_clnt.
> > 
> > If a callback operation is pending when the backchannel rpc_clnt is
> > shut down, currently nfsd4_run_cb_work() just discards that
> > callback. But there are multiple cases to deal with here:
> > 
> >  o The client's lease is getting destroyed. Throw the CB away.
> > 
> >  o The client disconnected. It might be forcing a retransmit of
> >    CB operations, or it could have disconnected for other reasons.
> >    Reschedule the CB so it is retransmitted when the client
> >    reconnects.
> > 
> > Since callback operations can now be rescheduled, ensure that
> > cb_ops->prepare can be called only once by moving the
> > cb_ops->prepare paragraph down to just before the rpc_call_async()
> > call.
> > 
> > Fixes: 2bbfed98a4d8 ("nfsd: Fix races between nfsd4_cb_release() and nfsd4_shutdown_callback()")
> > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > ---
> >  fs/nfsd/nfs4callback.c |   26 +++++++++++++++++---------
> >  1 file changed, 17 insertions(+), 9 deletions(-)
> > 
> > diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
> > index 43b0a34a5d5b..b2844abcb51f 100644
> > --- a/fs/nfsd/nfs4callback.c
> > +++ b/fs/nfsd/nfs4callback.c
> > @@ -1375,20 +1375,22 @@ nfsd4_run_cb_work(struct work_struct *work)
> >  	struct rpc_clnt *clnt;
> >  	int flags;
> >  
> > -	if (cb->cb_need_restart) {
> > -		cb->cb_need_restart = false;
> > -	} else {
> > -		if (cb->cb_ops && cb->cb_ops->prepare)
> > -			cb->cb_ops->prepare(cb);
> > -	}
> > -
> >  	if (clp->cl_flags & NFSD4_CLIENT_CB_FLAG_MASK)
> >  		nfsd4_process_cb_update(cb);
> >  
> >  	clnt = clp->cl_cb_client;
> >  	if (!clnt) {
> > -		/* Callback channel broken, or client killed; give up: */
> > -		nfsd41_destroy_cb(cb);
> > +		if (test_bit(NFSD4_CLIENT_CB_KILL, &clp->cl_flags))
> > +			nfsd41_destroy_cb(cb);
> > +		else {
> > +			/*
> > +			 * XXX: Ideally, we would wait for the client to
> > +			 *	reconnect, but I haven't figured out how
> > +			 *	to do that yet.
> > +			 */
> > +			msleep(30);
> > +			nfsd4_queue_cb(cb);
> 
> It would probably be better to just queue the cb as delayed_work here,
> so you don't squat on the workqueue thread.

You found my placeholder :-)


> That'll mean changing
> cb_work to struct delayed_work, but that should be NBD.

I've looked at that. I wanted to be sure, before going that route,
that there is no obvious way to implement a "wait for client to
reconnect". msleep (or delayed_work) is basically a slow busy wait.


> > +		}
> >  		return;
> >  	}
> >  
> > @@ -1401,6 +1403,12 @@ nfsd4_run_cb_work(struct work_struct *work)
> >  		return;
> >  	}
> >  
> > +	if (cb->cb_need_restart) {
> > +		cb->cb_need_restart = false;
> > +	} else {
> > +		if (cb->cb_ops && cb->cb_ops->prepare)
> > +			cb->cb_ops->prepare(cb);
> > +	}
> >  	cb->cb_msg.rpc_cred = clp->cl_cb_cred;
> >  	flags = clp->cl_minorversion ? RPC_TASK_NOCONNECT : RPC_TASK_SOFTCONN;
> >  	rpc_call_async(clnt, &cb->cb_msg, RPC_TASK_SOFT | flags,
> > 
> > 
> > 
> 
> -- 
> Jeff Layton <jlayton@kernel.org>

-- 
Chuck Lever

