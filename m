Return-Path: <linux-nfs+bounces-3138-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 641438BA17E
	for <lists+linux-nfs@lfdr.de>; Thu,  2 May 2024 22:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 913C2B22CCE
	for <lists+linux-nfs@lfdr.de>; Thu,  2 May 2024 20:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008AF180A62;
	Thu,  2 May 2024 20:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="L+Dq0OJJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="J1cA2TgF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E829328FC;
	Thu,  2 May 2024 20:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714681064; cv=fail; b=DNphA+8NAQsdT+5514/wgIyfbAoofSW8GO3+4WqngIDZtJSILE9/4u6+UeQmA69Mr9YGcDDwNlp9ZDXtK6VwhdhjIlqL8pqhEKE3WR9VJLxVPipulGX/71TRmVti4AKiQNtF6Qwgnp1GEIk6dDl5vdmjjU7K8zf6WP6/ElIaB7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714681064; c=relaxed/simple;
	bh=J5FGV4gv9QnLtvsdVR1hODI4vWjE63njdxJ/tgzxxk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ePjru7r0+i3GvSiWqE+3uqXDfr9SHPAUQuEKGDaxHxY55WZ3vtyAdBjbRbyeT2okBpQ9lfFILx5ucKpk2dT6TNw7VB/GniykyGkKr1K7jbyrKFvRcu1xnBmLlycnb4I4JV8nUjUIrFKJIci3RX6dVuVgAT7pW39624JOKbSpB1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=L+Dq0OJJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=J1cA2TgF; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 442HHFXV002533;
	Thu, 2 May 2024 20:17:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=UwDsOFyKre8VlrEPq2skTrQMkUOKpopAaUZ/HejBskA=;
 b=L+Dq0OJJkfeGcdfeevnOVfdojRY6L+AyqSfr6PQV0K/D/ONeSTKDn82HCtFu5MT1z7oE
 fOxcT7LD6H7De3t+sf50k1CX/lzgAZfFouVJzF2av4/NZil1yIEB1d9iKEvz1sdmYDxn
 60ZJ0kZiz/Y9oGzCCl+n4NnoLxUMBbB3EQdNhH/J0/VW9hDI82r2SMZKkAkxEJbA9mG+
 xaLm2VLyMrz7K3sXWSp09dnH2FLqc8VIBP0hB+1dxlqRRGcbJB5dawI+WXUtSTlGM6BS
 7/j8D86uYQK87HBre+ZAAMgxtxhNjWLloEYi5nXSdGQKoxzjLrErlZB5zcptnmlX0jHM Ig== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrryvffmd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 May 2024 20:17:35 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 442J7pJj034702;
	Thu, 2 May 2024 20:17:34 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xrqtb7rpt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 May 2024 20:17:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EP7T8/stUK4R8bbqIz6Qk8+qVwgKEaVJCiJz5cGfjFZmE/tlCp3RO7lY+7sq6B5vypr73w6i5naTXeI64slbDYtHRxyHBLkDLs2QRSUHTzNPpKX8WlAJ3iNX/xgH6Znpu86dvmS/XycX6AxaYmFMrG15eX5N2bNfzfzLaCXuDtBb8taoO9mCNpDtrdK5DcEEGfMgmfSQDRfET78nUFuTTaPcXE/tQqzAzvAdbbfQSshl2rodDEZvu093tjWUV0dAmXKeX1umkTrmnVNTeZLmvmYXjmt1knzulXIEt8OV6hiaf+uk4yazW1bZ2o9x+hG28+t+maXydUghviZytJ9UKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UwDsOFyKre8VlrEPq2skTrQMkUOKpopAaUZ/HejBskA=;
 b=PlvDVtQTiiMgF2QJ2beBsd4hTcUFFNfzHWpVOtt0plXKjJ7jFgtLgEL20M8IDQGRx5eiTQyzVml6q49Pym4154M9ReB2+PiIn4dW6XhcHCd5r1K2Olw0r3226J5ut9T6uFMRPnseXOdyyBH9DaQa2dq8iZ2TWci59GM9HO9LtxwRC3Km5Co4+UZGqFtVQFB80h/wvNMFab7413ezjY0ktFj3/WP+Pjj9le7osopYYF1Dm9HLy+icsXf0j5h7BZb7kQMIQsL0m56xC2r34FaYhbPrhlMZv3P0r2hLTinJe/p9ED92NYvTwTRvLSsErPsFzuzXX/z2Ai/oPUnHSyFvcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UwDsOFyKre8VlrEPq2skTrQMkUOKpopAaUZ/HejBskA=;
 b=J1cA2TgFp+4Dn2PYEuiWU1Z4hTB3IpOWuJNpO+EtqSwg9/tZjw5UmH5XLdnaK2s5af037E2aGSMigbcJpfVhgIt8Do9jV2dHVAsIjY4BFLDN2gsL9kh4/DJ2CfrkzqrAYJqlpL0qcC62o3fJUDGRibLNJTCXAVC+Tamuv3iP2pA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY8PR10MB7366.namprd10.prod.outlook.com (2603:10b6:930:7e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Thu, 2 May
 2024 20:17:32 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7544.029; Thu, 2 May 2024
 20:17:32 +0000
Date: Thu, 2 May 2024 16:17:29 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Stephen Smalley <stephen.smalley.work@gmail.com>, neilb@suse.de
Cc: selinux@vger.kernel.org, linux-nfs@vger.kernel.org, jlayton@kernel.org,
        paul@paul-moore.com, omosnace@redhat.com,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2] nfsd: set security label during create operations
Message-ID: <ZjP02U6HMqDR+EO5@tissot.1015granger.net>
References: <20240502195800.3252-1-stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502195800.3252-1-stephen.smalley.work@gmail.com>
X-ClientProxiedBy: CH2PR12CA0029.namprd12.prod.outlook.com
 (2603:10b6:610:57::39) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CY8PR10MB7366:EE_
X-MS-Office365-Filtering-Correlation-Id: 6abad445-7516-46a8-deb7-08dc6ae4e5f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?AgI/BX5f4D0sWDFB+KaiF/GAjxpiFK5XLHwme/KG/HBNvixizcAx0DBpoFp3?=
 =?us-ascii?Q?DQhfcYAYFwf/yMCA2DaQ1vRbPMTAyQ37enpX9n8T4QNC9EBIw+XIW1CVtjuZ?=
 =?us-ascii?Q?r/L9ug2arVEP9dNteeOhdoA4AftK0mt0WerXTBllaK7CExhJwc/61BzJ4Ffu?=
 =?us-ascii?Q?0SLcWwNM0vN93mFU5kha3ylP0Bhm4US31JBkI83Gv3DwPO3mDJ28dwAA/5Mw?=
 =?us-ascii?Q?OofyktC/eg3yvMeCgp5Pdgx0RPc1/nSP17khX3V9tWGlyE0OfqAsk6tEP4R2?=
 =?us-ascii?Q?ymhIynkBUTc16dwU/PJLxrqsC0Of9okjsUD7fQLJNup9XOmRXMBzyqARejMw?=
 =?us-ascii?Q?lxWKrJEPC4o8fbJaNknBTV3rxRA5tRWpNVakH/gDDdZwOwMlcJd3PWxCFLhz?=
 =?us-ascii?Q?VEu7kunUFG2oHw0Od0nrjxlQdn0p5IH+AN8XCICzGMNsfTjBnaFiEHdvG7vF?=
 =?us-ascii?Q?W5YQHiveiquNSQun1cfFN/p6tYNo3WL+0Wh7edeTcdI/2MCqOpVt/4nrNF2d?=
 =?us-ascii?Q?gY+u0ss+B/njDs1PRfIt6rvXDEHOMF4RXfpI4+SNnqKphNYapNyjJRY0ckbO?=
 =?us-ascii?Q?mzVdfeV21R+3q0S2JLXiDhs3jiOI/GdHxoPqf+LP9zGAhLUDNPNBkfwsb9kt?=
 =?us-ascii?Q?hrVnNO3nywfxmuSDkw5GfVmRRd7scNPFVW5It8S22ypKQDdkvdEGFqyOWU8H?=
 =?us-ascii?Q?ierO//YPsaC/KuDQVbZFy6AxhUBPeS3DOo3k4d+WwCiN2GcJr/z74L60J2Eu?=
 =?us-ascii?Q?iCIij7y+uHkVTYKKzmlBEa9ZDaqtzqPfMxgBgtndCPk3j1PEsTNefzL/QZUF?=
 =?us-ascii?Q?UaCo+QIFBr0m103MpQNfMbWGh2hHfwpeWRlwjI8fL9AJgpqjGVmidMLaLBln?=
 =?us-ascii?Q?v2T8+UAwDn33o6Pktta2g5asrCxyW0oQa5OdDu1ArJQbSMRh21nduEKtiLpi?=
 =?us-ascii?Q?vKOy/R8OV6k8wItnduHjjs82UW1lboNSWllFjMufm9TA4r7q4oq9RsEnHOvp?=
 =?us-ascii?Q?zK5EHhu/E0EGweTIzUtsgxpRTMJdpAANjNrmEa2+RCjQ/Vbk7WcjqK40V/cX?=
 =?us-ascii?Q?ryHPYoOOPch1dOpX9rDGqAJMK79iO7mR6HbAvMEIi20Sg701HXPm0zxJgwCJ?=
 =?us-ascii?Q?JvvIFOU4crETuLdqp9GRfLuGcMnE/3t8DAY6EvTofXE9BF8IVJmDUJ1Yw0PF?=
 =?us-ascii?Q?YbThii9hN1i9rRfqT2vJIK+NiDyvX3TRV+IpY3TyKnCrABX3umsMzvffi+4W?=
 =?us-ascii?Q?S37dTWgK99dS6ZgtrkxGU9OqCHkZDIGAbQP2EoyJsQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?p9/ktH+OiIFF2Hpuy3/Xs+oXuYqrPlSryKYEu4Ipc+w/Le/yKkZyrSbagD6z?=
 =?us-ascii?Q?lPfL3HELWPSupsgUqZi/6fbkpdnSjYa8SFK+VCC2XPkirg/S6KgUUjeSRwnj?=
 =?us-ascii?Q?c6jD8TXHp8FJHRvFbgWGzbELUxHv3LyeHNkHJHSq+UHIUcbou+7bmHvOBfGa?=
 =?us-ascii?Q?jViPU0r1iphOUTb5Az9sXhH6EGs+GqpWEzs+Uesed9SGhZyq4fOu24E/2m2m?=
 =?us-ascii?Q?sc8G3PeJstlk1ksjpkbWoHUbA3oxstbM2jt7cEKrSMzhsGn7pg38KsPpNIbd?=
 =?us-ascii?Q?uiJbmVKGOgJC9sB3PJN6rwph8LO/Ze6JiDv9ygdzBvYMeCHYGc4Q6wayp5U6?=
 =?us-ascii?Q?mtVtfFxcUq3C45XlbO57OKmI5Mv3vs2rrD6fUF3eWfsZgkcwY2obmfjVjEe4?=
 =?us-ascii?Q?RNz7cV5UNhJ0w9nlzNryEC+25bGssQKYzM0woty5Ktg5LSDqwKKDqRspsfuN?=
 =?us-ascii?Q?so1N7ZrQrsd2fVIgQAe6ZEpXtPvP9BeCqaYG3R5Qn7WNcfMPzgeutxVZCGlH?=
 =?us-ascii?Q?U4DwG/rfezvJOvBxg+Jkchm7KIVrtFv0MQJs3JDh/LsxzVJmOnJ1x2+0NBmG?=
 =?us-ascii?Q?jbwav2ijrw/NPF3MivF9D+0C3+SV1Av0QU6ifRD1U9fDvTKuUGdQ0psfE3JF?=
 =?us-ascii?Q?RyUZwl32N1fo6zvPVJiWz8U4i2padr6KdykeeiPC5N+yWN6f4haY6Sq6Macx?=
 =?us-ascii?Q?nWH8uoCTeNZFCEytaF8CsmpU6pyzKgJgaqIbmIpQZmsaGeKUfVxezMIJMSj/?=
 =?us-ascii?Q?pzivnXkZbVGDUCDUaEGSs2Q5Ncv66NtSayi+y71dwPdz1kOksacbtPyf0qaw?=
 =?us-ascii?Q?mWNadyLfLyEZ+uAKhJGLdVYkhaKwTvYhCAA3uVn6GlT01G8RVwccZ7VnE84v?=
 =?us-ascii?Q?cRKWb5xVepegIJvG0djdd4bW9EYyBUItzhvAvEM+wGI4NSw2WxbOiDUjPyu4?=
 =?us-ascii?Q?zjrBn8gL4Fx57pRpbNHXsBTmzwSZWAdiC+Lsv8hMCLDtQNF+ISX/kwj6vFFO?=
 =?us-ascii?Q?GmIlMzn73uePhMFNxv0OEM+y/EuChZllNcEFTba2jC67anUycKmh7UcB1yjN?=
 =?us-ascii?Q?LSwAmlXOUcesah9jwsQU8oKCvXnU8OLzvI1UV9ppYQLIsE6zXgRasAaBcmeh?=
 =?us-ascii?Q?woWaMq0tOI3c+5LB3PmPqcpmQ3Sf3sXd228cjtoJz9dJ15A30BTwB+47ol+H?=
 =?us-ascii?Q?Hahsx9boJqTJ0XfphwJeXcgtD2+0M2z7PMrxak7R/DQCPembhWJQznw6PmZi?=
 =?us-ascii?Q?kMvURkXyz7M+uYLIslPpwqKkbfWhaOzU1lQCxWIwYfFbn++lFtS8MBH8OPTn?=
 =?us-ascii?Q?BULYncHbUsepdffLlLCpJcplsMmeQqvi8o0KURCeOZhywQz1+T9Z7mOgEVVs?=
 =?us-ascii?Q?X3HK0JljVXpL951mNw6utyFdkDwZ0P8Zn/mI0XtyjFWVzmI2pa9RJhuhjPet?=
 =?us-ascii?Q?r85sCqxksGovythLQNHAzW0t+98FXTURUNxOvrSm40HsuJQxP9xQLLjtsTAR?=
 =?us-ascii?Q?ITZmzyyQb/XR/PyXI18581ZrGHwNwTXgcSr1qew6vL9e+aJEYPCKvxnukin5?=
 =?us-ascii?Q?Pb0UhPLDatCWyInxFuetgbKEII4g/KnQj0Cd3WpnBqCghJ1epFuVUVGPUM87?=
 =?us-ascii?Q?1Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	J8ksYMZy86+f0WlN5tQqAwBbxUG5rZUcNkYhRTeSDwBXNKq0NAssWtwVYheErJVcLOdkAWp5rZIQHZdlw/ljHEwmuEqX6NpkB6eNnik3g+SK36sEY5H+NBiXtyyCCl4G0rNISjNHOyKfcTE8ZvfVCvp8Qz92T4zJ7Zla29U8RT9YMLL5GxtBU1iFhwaTwK273toq784bo7rib+Uy/zW7fY/Tq0+SqnOxqwzUhE9tnvLp+SC8auo7qu/e9xdmfU2l+AkBOVj1U77nly7TkJPqY94G4USakAIgQQsfe7P8HFiup5Qpc6STEkc+QrSpSn9KFcYcu/oXqZbtUX944MRGIULB2IhSSbEDn3heaiNRr+GK0aVdcAlD2oLrxrISrLbZdkO1QPprgfAx2x81kScOSwJ1gzoFnAPq67aM0/fhuUfrvWS9IcuEzMcWZbT4Cq+DpZR6V2HVI6R9hyM+6xxqQ7xFfq+gCU8cA4Bg9zGYn5H0Akv1XxbD4Mu6q06uRYG94nOpsHshqcb5DgJ8G1IJFBxGWyXXkhkZwuDOdSV1KoxopBEWqNYrPbJNzU4LqJS6PI22c5hDyKH0MmeL0XZChkR70OhQPVGyKB0tz1+xIe4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6abad445-7516-46a8-deb7-08dc6ae4e5f4
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 20:17:32.3657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zJz90SG1wdjYKqg7v1DPF0gPh5N7BosTK7mjrFiXNgfOuhQdT0n/Sxoacto2Fjn2C2nG/d1Kn3OP99JumugAzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7366
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-02_11,2024-05-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2405020132
X-Proofpoint-GUID: RkEt0POSLaGJ5LGOtjKV7f6FL15TqG8b
X-Proofpoint-ORIG-GUID: RkEt0POSLaGJ5LGOtjKV7f6FL15TqG8b

On Thu, May 02, 2024 at 03:58:01PM -0400, Stephen Smalley wrote:
> When security labeling is enabled, the client can pass a file security
> label as part of a create operation for the new file, similar to mode
> and other attributes. At present, the security label is received by nfsd
> and passed down to nfsd_create_setattr(), but nfsd_setattr() is never
> called and therefore the label is never set on the new file. I couldn't
> tell if this has always been broken or broke at some point in time.

Might have been introduced on or around commit d6a97d3f589a ("NFSD:
add security label to struct nfsd_attrs"). Neil, can you spare an
eyeball or two for Stephen's patch?


> Looking
> at nfsd_setattr() I am uncertain as to whether the same issue presents for
> file ACLs and therefore requires a similar fix for those. I am not overly
> confident that this is the right solution.
> 
> An alternative approach would be to introduce a new LSM hook to set the
> "create SID" of the current task prior to the actual file creation, which
> would atomically label the new inode at creation time. This would be better
> for SELinux and a similar approach has been used previously
> (see security_dentry_create_files_as) but perhaps not usable by other LSMs.
> 
> Reproducer:
> 1. Install a Linux distro with SELinux - Fedora is easiest
> 2. git clone https://github.com/SELinuxProject/selinux-testsuite
> 3. Install the requisite dependencies per selinux-testsuite/README.md
> 4. Run something like the following script:
> MOUNT=$HOME/selinux-testsuite
> sudo systemctl start nfs-server
> sudo exportfs -o rw,no_root_squash,security_label localhost:$MOUNT
> sudo mkdir -p /mnt/selinux-testsuite
> sudo mount -t nfs -o vers=4.2 localhost:$MOUNT /mnt/selinux-testsuite
> pushd /mnt/selinux-testsuite/
> sudo make -C policy load
> pushd tests/filesystem
> sudo runcon -t test_filesystem_t ./create_file -f trans_test_file \
> 	-e test_filesystem_filetranscon_t -v
> sudo rm -f trans_test_file
> popd
> sudo make -C policy unload
> popd
> sudo umount /mnt/selinux-testsuite
> sudo exportfs -u localhost:$MOUNT
> sudo rmdir /mnt/selinux-testsuite
> sudo systemctl stop nfs-server
> 
> Expected output:
> <eliding noise from commands run prior to or after the test itself>
> Process context:
> 	unconfined_u:unconfined_r:test_filesystem_t:s0-s0:c0.c1023
> Created file: trans_test_file
> File context: unconfined_u:object_r:test_filesystem_filetranscon_t:s0
> File context is correct
> 
> Actual output:
> <eliding noise from commands run prior to or after the test itself>
> Process context:
> 	unconfined_u:unconfined_r:test_filesystem_t:s0-s0:c0.c1023
> Created file: trans_test_file
> File context: system_u:object_r:test_file_t:s0
> File context error, expected:
> 	test_filesystem_filetranscon_t
> got:
> 	test_file_t
> 
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
> v2 introduces a nfsd_attrs_valid() helper and uses it as suggested by
> Jeffrey Layton <jlayton@kernel.org>.
> 
>  fs/nfsd/nfsproc.c | 2 +-
>  fs/nfsd/vfs.c     | 2 +-
>  fs/nfsd/vfs.h     | 8 ++++++++
>  3 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
> index 36370b957b63..3e438159f561 100644
> --- a/fs/nfsd/nfsproc.c
> +++ b/fs/nfsd/nfsproc.c
> @@ -389,7 +389,7 @@ nfsd_proc_create(struct svc_rqst *rqstp)
>  		 * open(..., O_CREAT|O_TRUNC|O_WRONLY).
>  		 */
>  		attr->ia_valid &= ATTR_SIZE;
> -		if (attr->ia_valid)
> +		if (nfsd_attrs_valid(attr))
>  			resp->status = nfsd_setattr(rqstp, newfhp, &attrs,
>  						    NULL);
>  	}
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 2e41eb4c3cec..29b1f3613800 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1422,7 +1422,7 @@ nfsd_create_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  	 * Callers expect new file metadata to be committed even
>  	 * if the attributes have not changed.
>  	 */
> -	if (iap->ia_valid)
> +	if (nfsd_attrs_valid(attrs))
>  		status = nfsd_setattr(rqstp, resfhp, attrs, NULL);
>  	else
>  		status = nfserrno(commit_metadata(resfhp));
> diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
> index c60fdb6200fd..57cd70062048 100644
> --- a/fs/nfsd/vfs.h
> +++ b/fs/nfsd/vfs.h
> @@ -60,6 +60,14 @@ static inline void nfsd_attrs_free(struct nfsd_attrs *attrs)
>  	posix_acl_release(attrs->na_dpacl);
>  }
>  
> +static inline bool nfsd_attrs_valid(struct nfsd_attrs *attrs)
> +{
> +	struct iattr *iap = attrs->na_iattr;
> +
> +	return (iap->ia_valid || (attrs->na_seclabel &&
> +		attrs->na_seclabel->len));
> +}
> +
>  __be32		nfserrno (int errno);
>  int		nfsd_cross_mnt(struct svc_rqst *rqstp, struct dentry **dpp,
>  		                struct svc_export **expp);
> -- 
> 2.40.1
> 

-- 
Chuck Lever

