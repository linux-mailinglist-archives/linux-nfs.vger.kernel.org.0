Return-Path: <linux-nfs+bounces-2746-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF3B89FD2D
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Apr 2024 18:39:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5A9A284AF1
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Apr 2024 16:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CAA717B4F7;
	Wed, 10 Apr 2024 16:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Inl7yhiK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="t5rtlaD+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61904176FD8;
	Wed, 10 Apr 2024 16:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712767148; cv=fail; b=K344a9IFFVJqbgURjCVsEYCsuNe2hLKnl3DxQSXgPJdOhyyvZkWfV79IUYUmQzEyQPFbYg28q5jiswpFGia7LomK0iCyGCJIYv8RTMHL1yhn3mUQ1P5fpPjByD87mEWp/dv9psDKWzN4goJu4xHU8rWco3V12W0Cj7XN7CY4sKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712767148; c=relaxed/simple;
	bh=2V2QeQLoh9+YDlVMPqC7xrlWjtbzDfiKIIEYCwWGHB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BKNw8zNaQCQ0T0WmNrIiMBqEB9jOAygyEUu6leVQ13MhaNAAnRh1Dj9giQu+GsZBFm/6wuwPZ9O5vCnFHJ8PssS8+IuL8WG3/P6XKKOYQwFztcieg1WKRnE3eCV5LCFStuqFwGM9rCvhBRUALo79/Sf13xj6moSEZ9Fo8e50d9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Inl7yhiK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=t5rtlaD+; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43AGSx8I022735;
	Wed, 10 Apr 2024 16:38:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=C+Vxu3HS5V53aa7xFS1hoYVufxGPjyKPTg2HstnUc9g=;
 b=Inl7yhiKySqEDHnjYIpWcGfVEnZ1BpENXtJyP89LPi2P0UvDNGN4FBHNvEZuoH0/Dtnc
 GLlC00wDhz0HouTtLL/TNOQKMMoIA8kPAGAptMtdJj0mzWRYzAXRSvfUHtJmoOWL3ThT
 5d0UZj9iZyg9lIZ/4UR7Yi7m9LoHcXXI5KGxCUnsDNeZv9mi3YdrMKkMJHni/J/goPgw
 SDDp6vID8kBKCHfPJiaTOOOFCFw+SzaS3CjdPY1imTCZx/uuqH5U+2Hi/qMa9UIvVAYK
 DGQBd7ZfT8YgHHYt0M9P2h+YRAP4LRRBOUGkMz/69ATFmqaqurhlqrGmUWLaCiDyuRhx yA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xavtf7r4x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Apr 2024 16:38:58 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43AGBacT002850;
	Wed, 10 Apr 2024 16:38:58 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xavuep463-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Apr 2024 16:38:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CpR0X1Nm++wpJrMVNMUIOyrcbknHdCtAqpBdfZdN3U+1Le8hwXYU4LwyCu+53Y6XOX7DNHXjHHJlPY5CIjqmMLb8194FpPDNgIAuRvuZfX4So3rieKdtV0wTBMJHm9SQ9A6kpVSjohkzvQHq2yh5ndxFMxmVrA9dzBSpD4sCrq07PWsqv2VY4R8OA4jQrstjqS7s2dTwvP+gZ8TYRT0i02HdrVMMD0ScI43aiee34v0YNqscYBX4JUcyhE4nTLnv4JmdC2QCl6eO9mA6g88NcEnjJnL1kMuoxywnM07mhIk0VaeeK2gfTdGHEDzPEgbsbWgX1DfhDPaa7dwjxf2CNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C+Vxu3HS5V53aa7xFS1hoYVufxGPjyKPTg2HstnUc9g=;
 b=Lrq4LpQOS+KI+l50WH/MCGQyexOyXLYpORk0XrjLUb672ahP6QpatXJgCJePED+AvzL7n1QKHqD2sWU8XTxWKm6jq9mG+/gspQvyx/7nPOE7Cub6J+GwN7W3xiPjI7RfH1Sc+rw1+s7FeJRp/tun5Bl7yXdnAT/7TG7/urM91OVDvgwiw2V/YmOBOD5Cf9C4vNmlt7y1LJjycAn4+28BWbTMqK9Sx6Z/ms5aRoIPsmeHK7iTf4yuazoynZPhbTl66ALNZwbPLWJqPEKV9Pb3fR1NAG+/epiKZwJQCQsRbooFQtFHCEoy1ApsZzQqNWjvu7VDnk9nc+tXne78Nn8k7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C+Vxu3HS5V53aa7xFS1hoYVufxGPjyKPTg2HstnUc9g=;
 b=t5rtlaD+mOVO3xhhC+WjEE+jcLBzlNQq96ZvCDcgxempqcsnWP0bnH8YJqWca9L9ZgfpqJ6WspMAK2MhxJmIPTs2K7D8y6x9OIexJY6svQiu7hiXTDTMNZJiAwSea/iPEHMdj5ovg9SrzNhQTJVaqHlbIA4B8upUXx9IqXgC0d8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB5951.namprd10.prod.outlook.com (2603:10b6:8:84::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Wed, 10 Apr
 2024 16:38:56 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b%4]) with mapi id 15.20.7409.042; Wed, 10 Apr 2024
 16:38:56 +0000
Date: Wed, 10 Apr 2024 12:38:53 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Jeff Layton <jlayton@kernel.org>,
        Anna Schumaker <Anna.Schumaker@netapp.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] SUNRPC: Fix rpcgss_context trace event acceptor field
Message-ID: <ZhbAndktED4NsANF@tissot.1015granger.net>
References: <20240410123813.2b109227@gandalf.local.home>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410123813.2b109227@gandalf.local.home>
X-ClientProxiedBy: CH2PR18CA0059.namprd18.prod.outlook.com
 (2603:10b6:610:55::39) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS7PR10MB5951:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	05EFcBkP/4eiozdMfHKQ/OCv3fg57pWd6e6x/wfAwDv/QffnPgos8UakBmLw0Ty6hZeHuOFrwGUUTgDS4Nuv9wLdeoDWX7ql5x0GiYb1r7CE8QSf5D1zIw50k7ffWLytP9Z6xeJLmqpk8Tx2E0dMx5JszYMSAIFPmQR8OcFCf+4p4W+atbv0WJvUvyN4yd77peZ+64Jnuto8yRlnup67LCC2JPDOBC6DKEOHUrK8aA3pjAbsL+Rcc3fUy4rSGp95ip16TtGp6NVJzZ04iut/oyy2P6Mfr+1mD3EgA9zwE3zBCAfk8Hrbtb0JwMBLNH8o9cZ5guO0j1kJTUth60BqPieGSmbSpgPvu/RzhU3vaXiBw1Yv8qeBUTlGg8sd2wRpo9fAbJQAAl+QyN/8bc4d0nhAi72DRywBHb3q/0jqXWDTVjAv/Hm8Opr+YN3qZBNUf/B3O6+m9qGUif7AZuD2ymA6ybV1ftO6uv6zRzgCoSWbUDXqjYfpgF1wWvjckeM046AVzA6f+zYxkEL6fcLlOtzI27n27hBOWo0xLGZVly6bNNZdHPTh7fNxLXc8GKcIUNLGTJybP1ruf0vGqiDEqgE6ondDYqBZOtg+k0kcX6FMPhioLa/0Bt1xvgOkZWkidIHayiM0KCC7ID31Z9WloqWihNIYSa2T8pqzlK0cF8o=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?LtBGjKzlGIp342KpDTI5Iqk//5qKJYroiCVRaEc3aNoU1aN2iLTB3wCYdf6q?=
 =?us-ascii?Q?gq4LfpkytyzqRnIE8QvudfS+otK0P8jbf4hyJPF6CrHToCjTfWuOSx2n5hbj?=
 =?us-ascii?Q?fl60a8Jsxhca3F4IBCcPLK5v1eUS8U6aEQ2uxNYrnv0AQdzsQF3E6GbeIWjk?=
 =?us-ascii?Q?wPOGyCg6+0+/JAQzZJ9mpg4uGBpXsOXDMjqoilcZ6T6t4XDN1VOcSVz6YcvZ?=
 =?us-ascii?Q?RL/12n51r2Fpq6FxzQVXQcEj6rm013EhCJ+bTewtB2IEgxpSUPx0E0Lp/X09?=
 =?us-ascii?Q?5zvWWplbfZm0tevJchhkLsIfewtj95xF5WTIXhy9qJEgpMDdSxm3W1QxKOn3?=
 =?us-ascii?Q?FfZrK6OTfuxXZf+NTnQ/zAA99PLOd7yOwiPr52HswHZAXhdVLJOCjFr3FH5Z?=
 =?us-ascii?Q?HRFJRSzwuYoiUuZKwAYyYhhnKy+qtIPJC0TP2mYhxzmhhckgwjj2xtw6xjkx?=
 =?us-ascii?Q?9vGRhPCQw4Hp6CH8Hs4/9PJF3Axc3dIFdPdC0R0mTqMYgyqCtutAh2jFTrPe?=
 =?us-ascii?Q?rDs0ZWns430YQxcb2mFhYFQGpRsPQX0Y3xUXnVJ8JBCjpCf9VnKR7Fjgzw6e?=
 =?us-ascii?Q?BqQTEfdcK8WxM/K4SFDX31Q9yaYDTplw1mnSL6lAJkO0l2kgMd7Re72LIwND?=
 =?us-ascii?Q?MIoREjxCFnb2AgX5hDzXnOnpceKf/7Ff0QfdYZko0oNzW2cFrdjVDeNNk2op?=
 =?us-ascii?Q?RsBAQIxGHgA4/vpKvN+IyuaryHxpw7HxTmiTiTbLEluUG7lQ0/gFsaH8FgFY?=
 =?us-ascii?Q?IrOs5+qcxfW7jXGkUadQqH0/FrXlYbi5/YHBUpiLcoKQ+HVOAdy3hzA4wPGS?=
 =?us-ascii?Q?r0/9kvnqqJC9hX6HiVEQse7vF256LlMg9Lvx8SAaFp91zEa3VPh464+gYej3?=
 =?us-ascii?Q?/f+0Gcq1k5vOYsaZpy9h7zNxk1OJL40hb0t3AX15QcnYUv711e65m1q9UXeE?=
 =?us-ascii?Q?zPp4DmupjXWXpJOh3IP4uhstImWycVKEMIQnmGRhWAKXshJM9Y8U+woQDQp4?=
 =?us-ascii?Q?jkp1eEwH4b0mK4JeBbDBN16CUDfQigrxZrm9EK5Qj3z5uH3kvxZgVdnusZ/g?=
 =?us-ascii?Q?Q+fTEokWcKOHvc4e+sTQcEGrLgRYi6glBqjaWw/Z6q8BxZY769j8gQem921v?=
 =?us-ascii?Q?gimkNt+YmDuC5Vw/LOxW8C+Cwur9H7Fu/V/obOWG4q8ImnFmHONNipoZM6aH?=
 =?us-ascii?Q?S4IvMnvz6VUyDQKRZXJC/4072wmrwbuMpQKakoDIuNkeQMx7ooZj3XN4IgOC?=
 =?us-ascii?Q?ZCXpqtDa3A17hXdqCoK/9gIWftYgUWyb/bZm4ujrWZR9EAMy+VcdjblFlC3s?=
 =?us-ascii?Q?E/p0WmF9siQLosPTNl8agkXSxpY8aVsyDqAkjISnE733+lq1uGfNeF9O8tgM?=
 =?us-ascii?Q?JY7G87bmb8eTJ+itz9+PCk5sxiJGrdzfTdzWioEUxrkqYKuBH+6qWNoukEE1?=
 =?us-ascii?Q?ThJpy9runofzqvWI0cl0xphE8/FdWiCRlin7/VESwti1UI6ZCSFppobXmc4c?=
 =?us-ascii?Q?2mOGMh6uyhLZw+TWTRMciPzGCA+60hSezdoBv+31dZyZ34FdyXyQnVSiepkJ?=
 =?us-ascii?Q?QRGjKdZgE+0dTrfSQOyKqdaz+xgYw580LJOQOD/z16v8yZsCYHJZpkqj7Yju?=
 =?us-ascii?Q?cA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	j5MgdT0jN0OGlPf+VON/g9QyweWZQZOfBVX08wSOsT/dcTOhf5qqHAIcoolnz8fm2EUPuAm8ekceqZ+tkDf3BxAF+CfAo0MaCeMwmUHqCTxdX/k8QclRoxoiNLGvKWCvHUhTfTUSbYj6qXnP7CZGOBbuHykJmA+urXWsUuZusLn2iUKLMBcn3WlIBO9klVvp4cX1FH9G0Ez1VI7mvSErMknl3c4zMxSMfmuaKRakoawe8a5gX9yk29Zr1Vc1qzXATvpJP3WEOJyEXl0Qr89VB1ydgWyNXf24N+yFuiJbJ7YQjx7KNT99j+LcQsNGu1SEhz0gPV1ZSP73U/Fv1o5eRk3Na7mMhccR2SSYfCycAocvMIdcp4pbjXwk31kPnn5WCynQGi2XDXLF3omp6q1bQcadagvxgN7u7124kAjC+Sxo+CjH6xFLnTRdvtuwoHpXdVdmT4IYeSDZQkfq9DhEccbZbKQZmRUmJBb7X/K4I+PFcaa/pSYSI3LfU24d5PbvMZ6oS/8lvL4WBTxQEryXKQuJhzW60a9D9eIWJCEwTSodysyatWdS5YK4VpU/aPgcYuCmFiZWP6STy3v7aSVHoTh4Jmktidg061LCYr9U+Ec=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11590aa2-4fbb-4199-0b41-08dc597cb70d
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 16:38:56.3060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +MXx7r6Sfge2/L2XLvN4ewL2dRKYZl+6zQBclBkWv5v66veUL5bk3FIGiKz7zDGjOvPuH/8oSO8hDNjydNIoPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5951
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-10_04,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404100122
X-Proofpoint-GUID: 7YrT72HvYrXCwSOM1G3_jky9mpEuuj4Y
X-Proofpoint-ORIG-GUID: 7YrT72HvYrXCwSOM1G3_jky9mpEuuj4Y

On Wed, Apr 10, 2024 at 12:38:13PM -0400, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> The rpcgss_context trace event acceptor field is a dynamically sized
> string that records the "data" parameter. But this parameter is also
> dependent on the "len" field to determine the size of the data.
> 
> It needs to use __string_len() helper macro where the length can be passed
> in. It also incorrectly uses strncpy() to save it instead of
> __assign_str(). As these macros can change, it is not wise to open code
> them in trace events.
> 
> As of commit c759e609030c ("tracing: Remove __assign_str_len()"),
> __assign_str() can be used for both __string() and __string_len() fields.
> Before that commit, __assign_str_len() is required to be used. This needs
> to be noted for backporting. (In actuality, commit c1fa617caeb0 ("tracing:
> Rework __assign_str() and __string() to not duplicate getting the string")
> is the commit that makes __string_str_len() obsolete).
> 
> Cc: stable@vger.kernel.org
> Fixes: 0c77668ddb4e7 ("SUNRPC: Introduce trace points in rpc_auth_gss.ko")
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Acked-by: Chuck Lever <chuck.lever@oracle.com>


> ---
>  include/trace/events/rpcgss.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/trace/events/rpcgss.h b/include/trace/events/rpcgss.h
> index ba2d96a1bc2f..f50fcafc69de 100644
> --- a/include/trace/events/rpcgss.h
> +++ b/include/trace/events/rpcgss.h
> @@ -609,7 +609,7 @@ TRACE_EVENT(rpcgss_context,
>  		__field(unsigned int, timeout)
>  		__field(u32, window_size)
>  		__field(int, len)
> -		__string(acceptor, data)
> +		__string_len(acceptor, data, len)
>  	),
>  
>  	TP_fast_assign(
> @@ -618,7 +618,7 @@ TRACE_EVENT(rpcgss_context,
>  		__entry->timeout = timeout;
>  		__entry->window_size = window_size;
>  		__entry->len = len;
> -		strncpy(__get_str(acceptor), data, len);
> +		__assign_str(acceptor, data);
>  	),
>  
>  	TP_printk("win_size=%u expiry=%lu now=%lu timeout=%u acceptor=%.*s",
> -- 
> 2.43.0
> 

-- 
Chuck Lever

