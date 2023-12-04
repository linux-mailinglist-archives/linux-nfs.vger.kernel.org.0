Return-Path: <linux-nfs+bounces-302-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B9C8039F2
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Dec 2023 17:18:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2711F1C20A01
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Dec 2023 16:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DEEB25773;
	Mon,  4 Dec 2023 16:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aWtRe8+x";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yZs+hOir"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B04AC
	for <linux-nfs@vger.kernel.org>; Mon,  4 Dec 2023 08:18:04 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B4GCvcC028421;
	Mon, 4 Dec 2023 16:15:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=5YG5AQ2XY8G3CsoY5rPuQMfbD2zDBfcyQ5EgEZQsBB0=;
 b=aWtRe8+x+k82aNsyM0aXtHykyWC0oBjjRtQe5IcA/g87W3ZDR3HFgGmOCRHmH+MLDeY+
 0kcPKB+oLQlJZC/LCQ0cbNRS2lAR5/bcObHuLE9J88hHZoyOEcrthHEnwxOcsBv3fUPp
 e/S1uBcly7UutpYuaW08JtkS4dLJIWoDETLj1jXU2q6MEVRokxmuopO1sm82c8RABiBg
 EGVgBsKZbdgIF19tbO1Ff6R4UG5EY+F4EfYD3bSVV6CIncUeUJ2LAlchHez3Kh5618Yp
 Efvifg69JIzXExbugylKtore9Zw1q9prgoNpjebX1qtBusJCTPM08tF/3VqQmsmzq0h+ GA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3usj32g09v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Dec 2023 16:15:53 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3B4FJOsX014733;
	Mon, 4 Dec 2023 16:15:53 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uqu1601me-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Dec 2023 16:15:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f2McpsqO60Q/TGXq5E8bC8ofd+ak8ryncU4Y8xm6ulT5JfbN1qLPobfHdYBpXNXaLXnB86QXATxpI2FJsrZ3fVZDLnPHTP7qMGAKG4M59tBAeA25A+mgntjDZR4RxLPw/P5XmkeZJ2hV0Az6jXbRQkA380Gg7O6Qkx7L9Wb7DYXHeV0GyLnzg3cXnOLsp2HC+gEU/diLm/GjH7MUI6x5nCujKKSIZvQkDsB/zUetrf0LqyZmBn6A0sSUAgUgMqJagBFkxwZzBLINqWFcRIMg5o98x1jQja8sFUtABZ7bLPt6pj85+nwTkoo8zNS6OHJi+11FqsRNcp7qIKs8STtvaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5YG5AQ2XY8G3CsoY5rPuQMfbD2zDBfcyQ5EgEZQsBB0=;
 b=MMRUqOu6c63V64ITTB1dn5UclBKPF/Fz9Q9zEnHy082ffNzRtdp7lgyzYBkuumIqKNBBIrYYWSoCbWek+YAILPYZ2yFxOpuqVFauVsVFktIGEzr7vSxGevhg3IujsjRsVeEu+2zEb6HcA5WJu42DFo+JakZYCFpQ1zxFAvZIlBw0VEkc/3HtZ1PlEzn7m177SpTekjpegha3wgjMzQZKxDJiQezR0RhGwQtx26mPW3dUQc2e5JXdE3HD4SWyrbxi+ZdN6EkbXAJzuwJU8yFBMr28zsC7TkfQpS9ul3bxRb2GkBmiGlEH8grIDej5B4rumr5mWwcKb9f8uK6WY0o7aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5YG5AQ2XY8G3CsoY5rPuQMfbD2zDBfcyQ5EgEZQsBB0=;
 b=yZs+hOirf0D0HihHpoA8RjfYyhwghw+hUZpYB2uT354NUMTU8yoLgeBBRYXLdyZMe+ucc+EEwPc3bvH19YfsvyHg+XtiiBUWin4exqXKcACeE0nHThyLpl32NgEX0bU0VUuaHkQwKj7wpBl6vxTE3z9LTTin98/zTC516pkgCbQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by LV8PR10MB7942.namprd10.prod.outlook.com (2603:10b6:408:209::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Mon, 4 Dec
 2023 16:15:50 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7046.034; Mon, 4 Dec 2023
 16:15:50 +0000
Date: Mon, 4 Dec 2023 11:15:47 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Wolfgang Walter <linux-nfs@stwm.de>, Dai Ngo <dai.ngo@oracle.com>
Cc: Linux Nfs <linux-nfs@vger.kernel.org>
Subject: Re: kernel v6.6.3: nfsd hangs in nfsd_break_deleg_cb
Message-ID: <ZW37M7DOavddVpFd@tissot.1015granger.net>
References: <e3d43ecdad554fbdcaa7181833834f78@stwm.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3d43ecdad554fbdcaa7181833834f78@stwm.de>
X-ClientProxiedBy: CH0PR03CA0287.namprd03.prod.outlook.com
 (2603:10b6:610:e6::22) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|LV8PR10MB7942:EE_
X-MS-Office365-Filtering-Correlation-Id: 100648d0-e960-48a9-835f-08dbf4e4481d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	SCxHMAkz/4xtLmc27GRqJE6BEdtUiHOvWo5O0gNj3DXn4bXAv0wB4zqInqjolWMWo2VnYh5R2RKqjliyVQAplSGH2/cUScFrPjLAFaqF8YpeN3YfwpivpbJ/HR4jva34gZpiI89GPBxyTRwPEHgSJN2IUxXdV3/0yrokuT7ZU8OnJANgsxTl/5JnDibifEf2toTNkzqk3JVThSCabH7vjBkU8nWu62eGiJ3IKFXoajpBUrzVbgzEkrOJh9J9SE7Ka4xN59ydDPWZkMUc1yAKeBbkR1lpP9NBICaUysmMW/RZYvJ2E54q4gyO1SdPKm1F+UgsQrDXnzfbkINdRS3EWVh9MRRBE3f72E2HtsV0KTeGGtLEE6w+AphcHwrjX1xhtfRSvBM9zNm4Thcmavz/sIfT+f9Wnv3kgtXjJJcC50qLWaRi2uDhshc0CRzcFmJFk6/MHXJSVCBdLUlebPsj26TaBVLAqKPO9tuPnbKqqJXeV2WRYPJhHFzAyJoMUd8b1HDqZGFuIcJHHgbrzjHywRU/ZPZ2JYx0ica0JZpUq8yXula/CxeID9yCciHceF2CgyFfTj7ut8e7P7CNdT33PkPRP9nbZmsDYUXK46Woi2xLC+2metBg2TjFfNl152pG
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(396003)(136003)(366004)(230922051799003)(230273577357003)(230173577357003)(1800799012)(186009)(451199024)(64100799003)(8676002)(4326008)(8936002)(9686003)(6512007)(6506007)(83380400001)(26005)(6486002)(478600001)(45080400002)(6666004)(66476007)(66946007)(66556008)(110136005)(316002)(6636002)(2906002)(41300700001)(38100700002)(44832011)(86362001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?8y8ntNGemI0GSfDcGjW1G+F/FjN997yfXO6Doxnw/AKqCR77x4zva+rWYLUt?=
 =?us-ascii?Q?1SrMQkq9jkQvzYJ7ExC+rBi7Zm0xWZkrs/bPVAY2ijpjeuMe7XYn4IjFBnGN?=
 =?us-ascii?Q?ErGW5IklBiyb8r0HBVtSOqsftsLb22Fj+DWs5RBrl5lrExuGtRBSNVzx73kf?=
 =?us-ascii?Q?/6mvPL/6hYJp7tzMOLGiXc3Z8zSI2vP5d2vPDjHvRIT7QU6XQNDj+4i5uIEu?=
 =?us-ascii?Q?Y0pY/oFy428xWkCdkSWKHzS3A3LXPwCbm/kH4zPdMdbYTGtn3WCQb7FuMx8Q?=
 =?us-ascii?Q?CWh5J+LzE5ehniY+nxE0lKgy2DtkaIfzGAf9J2Hxw6twZZgH4bBhygwbz1vL?=
 =?us-ascii?Q?eundbbrKrSIKnZWAHOBvTl9bejzp1ZDatoHDb1gjQpoNUXVzAuyaz17qjoUS?=
 =?us-ascii?Q?P4eJiQJNxmgxwHCVA8Z9RHfTNh+shiRyoH+ZOtePLwfC9Fc7o3cBhe4wtAZ+?=
 =?us-ascii?Q?6kPbFy3Omdv1fla/UeG7E1p38uCRsinAeqwTNCeaXNn5YW6EFPm/tW9k9WCZ?=
 =?us-ascii?Q?KjA2PI8n/MJk4iFgxSiBnvi5VkvxmyIjx5BJzTjuQhpKPXZIn8BquYnColHx?=
 =?us-ascii?Q?9Uz+Ja/TunHwJNeq4xjSvvVepfuuLTEoW7m95tCYUCuDnqDPVL4kjrYXaCyt?=
 =?us-ascii?Q?8Y7szKAXcWyGYsc2rP/ewtkbE30PNUA4V4l3B4djDv0rQRmokTrIAOYG5KdV?=
 =?us-ascii?Q?kEKYh2PxHEs2vYj52djuruRGJEBgLlfyrQCmI73TvsIZ4dp+yvh+KmeMhR3D?=
 =?us-ascii?Q?4Jiu6U4nr23TtbaRcKrN9FCI4bLghKcXFLlBo91Gq1AJ45brMh9MfQ9+bfWG?=
 =?us-ascii?Q?REUjaGajOiM6XbIyzvMUIaJvn/WwbufzlzLPjIxn1qLGL260aBYkilGoh/OO?=
 =?us-ascii?Q?MFQ0YxtwHa/9RsT2Iu0jyAKlxF1SZ5URjdY7eGLAt9EeukRQifOYoMr7eghq?=
 =?us-ascii?Q?PfX2+S+LfJ6bNjxMJk7p3EWWZjYtx6PJwwFKiZrDU3YYpd3uaN09GkkAHxZn?=
 =?us-ascii?Q?RD9CCzUZYZvM9oCz14VcGv5l/OMIf/2oZdsZXtslfW1NPS74uaqjvziFuQG8?=
 =?us-ascii?Q?5J3A647KArBACBOb/IwmGNX1tx3S/ozkvlzTj2fuOdDg2ITxW9gfqh0atgK8?=
 =?us-ascii?Q?Xik1y7lLaVWbLLK7wEBDr4JrUv3B0BAXJYWk5lbSY0yNb96hNsi1vzvbWCyB?=
 =?us-ascii?Q?9gx7q2KRm+7x1QPVrw0Q9w9dzEitgXwnwkndJbTj9VXT5Hu5iPwoBWE/5sc+?=
 =?us-ascii?Q?Ilp2IjSxDqd62NYV04StvEbQ0/15KuKMbHbjMbqDtZ+J3h2tE8qa/+ILiCiW?=
 =?us-ascii?Q?n9a57Wb0PpDF9BB0MgwLkiqkvrgEqRwX5D3VgCgy2tCr1KUz/c92FHPN7GJo?=
 =?us-ascii?Q?gLMf7pg3Hm0EY42DUT/+Ks24IAsKhFrBem4pzp+OEmj0cID4j5SHsyUKlpyJ?=
 =?us-ascii?Q?wJwuiHFtq2/horET6GH3BW7p/UeY8R6mdn+8Z04FyoD3TKjQMAl4jN9tVWTE?=
 =?us-ascii?Q?+M9XyCW3tIkwcX38aQYwilUT/ciFM17pvFREv6xn+Npa1bqad0H8gQKdyHW4?=
 =?us-ascii?Q?oKw+/K4/OdV6k0KhLLsq4JAsG/oNk5lZZcVBLEAPj4ARmqiOnbXq77q9PswF?=
 =?us-ascii?Q?JQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	F9sGAb1uGJRqsslAnVI0CDe+e0FxWKtbK0ESPWCGQHD8BjW0ObV0Vf5EJq6cvPgvggM22XRWOpz2DZxNLIs5jP9X9pgb5fPCuC209gNEne8bNN7kdFd2GlBMB9Lkde8evrY5sVrIe4tajbeddpKdFvhJ8iCbBwa+bDzomWeG3vMEaD2KWcCytX2CldeZUBvJjC7m6XNT0cp4MkiMDafnd32v8BLdjume/EYZGcxZzWJHYh8HtCoN6xFsjTAwx0zh52/77WsMxP7Nulo40Hog3Oa9Hr36jx6aoa2Uf1IbxHu0yfxyIb/Jd3IgCmsQ/smt7huNbAW30/T3AL4DHXdHz+LI7kVWP/5tIeXFTK2/h6d51LIf6JkHRpqJvvvPMuDhuaVOTr4x22jHDR85rWG/XlFdvTq0Q/Ug3/nRP3alHfwVJF8YVIIKcwgtuoktOWdEKNPgAXfCK+9P8dP/7HB7C9JQKEqHS2hRS2Lgfr//RnddQZUYR9yNK2jlWBClb3qPGGeOrjQ95/uvhQ2t4u3AyYj0D3fElCNFRhFDngLlFV65YLlrH8+LObA/dt+V0oMTgxai0pG5L2mLzmm6NBv+b6JBRbUYuj80E8cVIHuhvCW86dCoy0+5qt9kNJqqfa04YTJUkx+/onpPwSa4QTMlx/amqkgIpNAoi8JFVa8WmYwkwuIoqXV6j/sBVewGo4iwyF1l8+ento1qJuJqQ0sdm+CySSN1L0PwgWIE9DM6a+2Q78+N7iZlxhuvRpBS4h0an0KCCK5smwT02uHRjLB7CsoA2bwPhZEzw8m/UB7ASXQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 100648d0-e960-48a9-835f-08dbf4e4481d
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 16:15:50.3835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IA4w4vszUD1qIJBo5bManfwzjPKgiaZEgRXAelm11SSHfFus5Td4Z4lpLnCqOopY0bEB7YpM48OA2tYXUO23QA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7942
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_15,2023-12-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=820 mlxscore=0 suspectscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312040123
X-Proofpoint-GUID: rbsf_BXbqU-_Xbnu5_Y1uWLn41gaU5IF
X-Proofpoint-ORIG-GUID: rbsf_BXbqU-_Xbnu5_Y1uWLn41gaU5IF

On Mon, Dec 04, 2023 at 04:34:00PM +0100, Wolfgang Walter wrote:
> Hello,
> 
> after upgrading from stable 6.1.63 to stable 6.6.3 our nfs-server logged a
> WARNING and then more and more clients hanged:
> 
> 
> Dec 04 14:59:25 engel kernel: ------------[ cut here ]------------
> Dec 04 14:59:25 engel kernel: WARNING: CPU: 17 PID: 8431 at
> fs/nfsd/nfs4state.c:4919 nfsd_break_deleg_cb+0x174/0x190 [nfsd]
> Dec 04 14:59:25 engel kernel: Modules linked in: cts rpcsec_gss_krb5 msr
> 8021q garp stp mrp llc binfmt_misc intel_rapl_msr intel_rapl_common sb_edac
> x86_pkg_temp_thermal intel_powerclamp coretemp kv>
> Dec 04 14:59:25 engel kernel:  enclosure sd_mod usbhid t10_pi hid
> crc64_rocksoft crc64 crc_t10dif crct10dif_generic ixgbe ahci xfrm_algo
> xhci_pci libahci dca mdio_devres mpt3sas ehci_pci crct10dif_p>
> Dec 04 14:59:25 engel kernel: CPU: 17 PID: 8431 Comm: nfsd Not tainted
> 6.6.3-debian64.all+1.2 #1
> Dec 04 14:59:25 engel kernel: Hardware name: Supermicro X10DRi/X10DRI-T,
> BIOS 1.1a 10/16/2015
> Dec 04 14:59:25 engel kernel: RIP: 0010:nfsd_break_deleg_cb+0x174/0x190
> [nfsd]
> Dec 04 14:59:25 engel kernel: Code: 02 8c a4 c2 e9 ff fe ff ff 48 89 df be
> 01 00 00 00 e8 70 7c ed c2 48 8d bb 98 00 00 00 e8 b4 0e 01 00 84 c0 0f 85
> 2e ff ff ff <0f> 0b e9 27 ff ff ff be 02 00 00 0>
> Dec 04 14:59:25 engel kernel: RSP: 0018:ffffbd57227c7a98 EFLAGS: 00010246
> Dec 04 14:59:25 engel kernel: RAX: 0000000000000000 RBX: ffff94a77356e200
> RCX: 0000000000000000
> Dec 04 14:59:25 engel kernel: RDX: ffff94a77356e2c8 RSI: ffff94b78cf58000
> RDI: 0000000000002000
> Dec 04 14:59:25 engel kernel: RBP: ffff94a0392b3a34 R08: ffffbd57227c7a80
> R09: 0000000000000000
> Dec 04 14:59:25 engel kernel: R10: ffff94a05f4a9440 R11: 0000000000000000
> R12: ffff94b8e3995b00
> Dec 04 14:59:25 engel kernel: R13: ffff94a0392b3a20 R14: ffff94b8e3995b00
> R15: 000000010eb733cd
> Dec 04 14:59:25 engel kernel: FS:  0000000000000000(0000)
> GS:ffff94b71fcc0000(0000) knlGS:0000000000000000
> Dec 04 14:59:25 engel kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
> 0000000080050033
> Dec 04 14:59:25 engel kernel: CR2: 00007f9ef8554000 CR3: 000000295e020003
> CR4: 00000000001706e0
> Dec 04 14:59:25 engel kernel: Call Trace:
> Dec 04 14:59:25 engel kernel:  <TASK>
> Dec 04 14:59:25 engel kernel:  ? nfsd_break_deleg_cb+0x174/0x190 [nfsd]
> Dec 04 14:59:25 engel kernel:  ? __warn+0x81/0x130
> Dec 04 14:59:25 engel kernel:  ? nfsd_break_deleg_cb+0x174/0x190 [nfsd]
> Dec 04 14:59:25 engel kernel:  ? report_bug+0x171/0x1a0
> Dec 04 14:59:25 engel kernel:  ? handle_bug+0x3c/0x80
> Dec 04 14:59:25 engel kernel:  ? exc_invalid_op+0x17/0x70
> Dec 04 14:59:25 engel kernel:  ? asm_exc_invalid_op+0x1a/0x20
> Dec 04 14:59:25 engel kernel:  ? nfsd_break_deleg_cb+0x174/0x190 [nfsd]
> Dec 04 14:59:25 engel kernel:  ? nfsd_break_deleg_cb+0x9a/0x190 [nfsd]
> Dec 04 14:59:25 engel kernel:  __break_lease+0x25c/0x720
> Dec 04 14:59:25 engel kernel:  __nfsd_open.isra.0+0xa9/0x1a0 [nfsd]
> Dec 04 14:59:25 engel kernel:  nfsd_file_do_acquire+0x4ca/0xc50 [nfsd]
> Dec 04 14:59:25 engel kernel:  nfs4_get_vfs_file+0x34c/0x3b0 [nfsd]
> Dec 04 14:59:25 engel kernel:  nfsd4_process_open2+0x42c/0x15d0 [nfsd]
> Dec 04 14:59:25 engel kernel:  ? nfsd_permission+0x63/0x100 [nfsd]
> Dec 04 14:59:25 engel kernel:  ? fh_verify+0x42e/0x720 [nfsd]
> Dec 04 14:59:25 engel kernel:  nfsd4_open+0x64a/0xc40 [nfsd]
> Dec 04 14:59:25 engel kernel:  ? nfsd4_encode_operation+0xa7/0x2b0 [nfsd]
> Dec 04 14:59:25 engel kernel:  nfsd4_proc_compound+0x351/0x670 [nfsd]
> Dec 04 14:59:25 engel kernel:  ? __pfx_nfsd+0x10/0x10 [nfsd]
> Dec 04 14:59:25 engel kernel:  nfsd_dispatch+0x7c/0x1b0 [nfsd]
> Dec 04 14:59:25 engel kernel:  svc_process_common+0x431/0x6e0 [sunrpc]
> Dec 04 14:59:25 engel kernel:  ? __pfx_nfsd_dispatch+0x10/0x10 [nfsd]
> Dec 04 14:59:25 engel kernel:  ? __pfx_nfsd+0x10/0x10 [nfsd]
> Dec 04 14:59:25 engel kernel:  svc_process+0x131/0x180 [sunrpc]
> Dec 04 14:59:25 engel kernel:  nfsd+0x84/0xd0 [nfsd]
> Dec 04 14:59:25 engel kernel:  kthread+0xe5/0x120
> Dec 04 14:59:25 engel kernel:  ? __pfx_kthread+0x10/0x10
> Dec 04 14:59:25 engel kernel:  ret_from_fork+0x31/0x50
> Dec 04 14:59:25 engel kernel:  ? __pfx_kthread+0x10/0x10
> Dec 04 14:59:25 engel kernel:  ret_from_fork_asm+0x1b/0x30
> Dec 04 14:59:25 engel kernel:  </TASK>
> Dec 04 14:59:25 engel kernel: ---[ end trace 0000000000000000 ]---
> 
> 
> 6.1. did not show such a problem.
> 
> Both are vanilla stable kernels (self-built).

Thank you for your report.

If you are able to bisect your server between v6.1 and v6.6, that
would help us narrow down the cause.

Dai, can you have a look at this?

-- 
Chuck Lever

