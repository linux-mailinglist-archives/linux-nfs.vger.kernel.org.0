Return-Path: <linux-nfs+bounces-2552-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B58B890F9B
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Mar 2024 01:30:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B7281C2DF48
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Mar 2024 00:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 085CF1EB27;
	Fri, 29 Mar 2024 00:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TwkqUskv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EXUkWJoP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06761EB51;
	Fri, 29 Mar 2024 00:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711671973; cv=fail; b=jBR29t244UhNIvSRmQaukoCwIhOcgGaskPZEtHplBii17HpglHQjFggc5rx6fVhgTBypc+bXMKKuR84PnHq0SBUvntLXhAPC6FMl5AlWgViJS3SDyySc9hyx4IWzbjquzm9iUQS8DVC8YfA2NMwEom0BBud2HfvJZy+ogMiAZjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711671973; c=relaxed/simple;
	bh=3xGmOoNLJN+64AHCFuVY90lqov4s7rCsouCc1Bsbctg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Bq5TR3++cgEOu5aovgx1zIQsNcE5J08RN3eoaL1gWdTUa/gbdqGURZAfxWThhNxLJY8kN4eAU8ew4D+gS+aWkwl3X3+AwcWhT/TpJPodUArsM4IoXsrGk111wxSxVSPGx1BbnyWv2QgjIZgnCutmXzHlyoY2Pex8Fs5y/+P4+/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TwkqUskv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EXUkWJoP; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42T0PEnF009199;
	Fri, 29 Mar 2024 00:25:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=3xGmOoNLJN+64AHCFuVY90lqov4s7rCsouCc1Bsbctg=;
 b=TwkqUskvhYMYyBN7v66MRvnzx54tww3vVkEvrP3+Aw3e85/07//kh/iV2TnMVf/SLggp
 0+VcMSLY4BdT0rno57lB14wO4G2MOfaoWkSwgBwytmrbllQMjrs12VmcQyyLJjYkh/yG
 8htCtikuQarZ5MR7wDxZ2hUEer1cWfPm6fRjDp50zCZ6EfvHUzAwIxB2y5wVkvSy1Big
 pg4aOHbMm4L73VLQZXkT2RuRno+DWvgeBjKdSbtCekYL4nWYzRGSkbGkPt09XPsiOnyM
 3BYlJt9RjzChhgAV3mmOnLbndrYP0R7bgXAbhPM+eHVd+7Wr92ctr4nr38kQndBREy6i Jw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x1np2jvuc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Mar 2024 00:25:53 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42T05KIZ019111;
	Fri, 29 Mar 2024 00:25:52 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3x1nhgyda3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Mar 2024 00:25:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VTkS79hpf2IOBGjxYpbSF95ZQgv8jIGgXgrPom8K5AuAL0bh+6o8TE3oz7p+giLu4FjgYcLEPQopGUw4vSArtlWRczQYXB8lpFcy2Fg/X46vEX11v85j/yawNEae5vYoglWTgz8KGdzKcWLufM72iahnrOZ+qXs5vPYjD+be131TT8X+1MJXNQcjbhf90wOWXGc7WeNKqIKrOLcKKrtZHdPuBJz3KZVPyNK5S7K6TXl+ck4CKOwUddKPM5E1Lwd1IgGh6UBC5cC0x5PDpBC/2w2Q+g/ml+DBz6QBoPUG14JQUUKDK+SNBTgU7pxCfJEEdjbOXPH/6mRMf9DxH8iwsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3xGmOoNLJN+64AHCFuVY90lqov4s7rCsouCc1Bsbctg=;
 b=lGwfuaYq/U3VeMDtUesWYifvAXdt9oSChblFKVz98v4WL4hWdzI4Wb7MKvkXKIDD51wMJL2vnvlFaDjXGLVG+IO82XqlURXgI3KGEnLzoub2epPKGSUywwHPMV6u7BboILLheDoqLNKQAbpS6pRZmjh7GOCH2cowOp5eS8c9jfMxsmACK2Xx6Qik74zA3mqI73lhyFZIsIK7Il4wRKskrZZE/IMM9Dhn6oHtS01ofBYEF6UqNeXuWgJZByQxNmh2CPoZZjnY5uzmMOpph6xc82eDnYVoNheHWehxnbllLjX+AU78SZvJ/PAy6DU97tpESNIQf9IzOimVaY1xumjsKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3xGmOoNLJN+64AHCFuVY90lqov4s7rCsouCc1Bsbctg=;
 b=EXUkWJoPabZs4MAturFLHnS5YZY5zDIitmMuN9dsorlbXDBNXx8Eph54ypzmvDTdndDsYuCLLmHQyM88LfV6uoMgk5pz0z2Gh1CZIRk7eVd+xitoU7qanaeSZuQAAyV3kwnyAUK1MeCZcp8L37Ecxt+zyCinpyu0v3wwgEi2ANU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO1PR10MB4770.namprd10.prod.outlook.com (2603:10b6:303:96::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Fri, 29 Mar
 2024 00:25:49 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b%4]) with mapi id 15.20.7409.039; Fri, 29 Mar 2024
 00:25:47 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Jan Schunk <scpcom@gmx.de>, Benjamin Coddington <bcodding@redhat.com>
CC: Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga
 Kornievskaia <kolga@netapp.com>, Dai Ngo <dai.ngo@oracle.com>,
        Tom Talpey
	<tom@talpey.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [External] : nfsd: memory leak when client does many file
 operations
Thread-Topic: [External] : nfsd: memory leak when client does many file
 operations
Thread-Index: AQHagW+lezsVaERYQkyF/uHR5qXzqQ==
Date: Fri, 29 Mar 2024 00:25:47 +0000
Message-ID: <C14AC427-BD99-4A87-A311-F6FB87FFC134@oracle.com>
References: 
 <trinity-068f55c9-6088-418d-bf3a-c2778a871e98-1711310237802@msvc-mesg-gmx120>
 <E3109CAA-8261-4F66-9D1B-3546E8B797DF@oracle.com>
 <trinity-bfafb9db-d64f-4cad-8cb1-40dac0a2c600-1711313314331@msvc-mesg-gmx105>
 <567BBF54-D104-432C-99C0-1A7EE7939090@oracle.com>
 <trinity-66047013-4d84-4eef-b5d3-d710fe6be805-1711316386382@msvc-mesg-gmx005>
 <6F16BCCE-3000-4BCB-A3B4-95B4767E3577@oracle.com>
 <trinity-ad0037c0-1060-4541-a8ca-15f826a5b5a2-1711396545958@msvc-mesg-gmx024>
 <088D9CC3-C5B0-4646-A85D-B3B9ACE8C532@oracle.com>
 <trinity-77720d9d-4d5b-48c6-8b1f-0b7205ea3c2b-1711398394712@msvc-mesg-gmx021>
 <51CAACAB-B6CC-4139-A350-25CF067364D3@oracle.com>
 <trinity-db344068-bb4b-4d0b-9772-ff701a2c70dd-1711663407957@msvc-mesg-gmx026>
In-Reply-To: 
 <trinity-db344068-bb4b-4d0b-9772-ff701a2c70dd-1711663407957@msvc-mesg-gmx026>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.400.31)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CO1PR10MB4770:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 i+9NSVx/a/VO91W9hokRvOBcd7GVW6/N7o4Vo9Pk4F9ywxBglqH1z6l4zTmsvFPXFiTCsSEMBmtF3FUh2MkFHY97q6xtilOQJQDxikI+8vbcizkCJisNc8411O/psYdnQ1f6st+6DDnG4fBkLqHf/CTITBKRg6lp8RX8Ofhel70FPn9b38jbccNoKpolb2ji8XHYkFbvpOEJS1KORGlTXuaq5+pzFFs/9YQC6j9XT6S3K+zGZwxJ/mN5MZdCzUY9aaN/4eKvF9wFds12IHs4r5qStvOJ0MRVQu11R4BFqeHyZIF2UGi5zZEVm9CHJDzKOnwiotrejmitnxnGeWR+mnqXTDm5pPnDbYrAUytmHtx3crGamjizV6SquBbIWkEbLRgEUb8/u1LiwiaJcc3/Ufi/2jkTilqYx7uLMR7zUZVHpEFuXW125jSA5iWA33dPoRI3Fd68j07mutzZdgnniqHVNjr3GvlSLD1xB1jW4gD4psByDsapyuty+aEtsYPsorP6vmbPDSUMQJP7DIxGndz2OPn83sESBK8sFso4+WcldBVAbp1qaGqUFdgLyKwb29g2xuV4UuoES+Th5K2lhhXKoOdLFjrBUPeWevGugNehFJCGVPinxWAIDWE+N5frjv8IT5xulMrqZt8XQBNx1ExZFZ5XN6IrmFMd1LBYkws=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?S3JSVXMrK0wwcGFiTFBMZXFndHJJSGRtb2djM0RKbmtOWVVGVzVrOXc5M3hO?=
 =?utf-8?B?aXVNWktDR0R3VTRFMytGNlRiWlNqOUFNMFJxMjFQRlZ3MFE5cGZDQWxXa2Z0?=
 =?utf-8?B?Vy82VitqdlhTYnZ3ZHkxUFRxY2VlYnVtNmRWeTJGYWJRUkttTjBzSEkrOTVD?=
 =?utf-8?B?bWh0Wm9SazN5dkVWdWJrTXJvbGtFKzhLK2syVjJMRzR3QUNZODZCOEsyVlRS?=
 =?utf-8?B?V1YwcHBKNVhuWGo2WU1ETFFEUVZOcmhsaHY5d0Fid1lEeSttM3lYYVBkUWl5?=
 =?utf-8?B?ZnI0c1Z3UXc2SFhVUFVFMFpJaU5FZUVqVUJUNTN1VTgwRjZBU0dFcW4xSmJO?=
 =?utf-8?B?eExjQmE1dkxkWTFyNm9QSEtwTWJPenJ1N1B4cU90Rk1IVS9YYzRpK085d1ow?=
 =?utf-8?B?YzNWOVpFSEdTMHJKVG5sSytxc0JhdnZtRElYSWZyWHFsQnVQZFlyeDd3bWo4?=
 =?utf-8?B?RThrcjF5QlhDRm14YlVOdzZCZUdpZ283ZVlKcm9ENmtUdVNLSmRQWEg1NWVs?=
 =?utf-8?B?SzRvdnlaRXZYU3Y0L0xleXVKb0dVUkFsL251UmVCRlJaUnYweVdHWE1sTXl0?=
 =?utf-8?B?QjhzQkZCejdpY3V1WXNnZXFtOEZlUlZSem0yTGdxcHI1d2xUeEtrRUdWd01M?=
 =?utf-8?B?QmE1TmhhREx2dG5GRytlL3FTejZmUkRWR0tRS0V6K2d1ZWltVWlzODFvUnZ6?=
 =?utf-8?B?eFR2KzJvRWU1UThudUlJTlRJc1I4czZQVjI0emNpVEdKTDFDWWNpa0JGKys5?=
 =?utf-8?B?NUF3S3dpMThyL2YvYzdWRWlZbUZwb2VLMmVwVndMRXM1TkM2NXdDVjUxekZa?=
 =?utf-8?B?NEhBdUR4V2hqMVFTVkg2ZGM2NzhWa2RyaVdyODh1WWphdGVqVUk3OVBpTm1X?=
 =?utf-8?B?eGl2VlYyeXNSdmpTRE9QNTZ3MXlodHlMUXJNWURFWktNd3pWMllhSmswMkFF?=
 =?utf-8?B?aWREV3BsVnkyQm5NaWt0dElXWmJucDloU1pXQm14aEd3OUcwZEdBQ2pnY3Jp?=
 =?utf-8?B?aExMZDFoNDVLNzBRTUZGY2E0SFB1QTd6N09lNFBpblNVa2x5TDlla2psL0pT?=
 =?utf-8?B?dGIxTjVCMVpsbDFLSnpzRStGQUJJMk1saU05Mlp1Y3djRDNOQnk0bDNvb2pR?=
 =?utf-8?B?NXd6bmZDNzg1bVlncnNnRGZLeG50dkFCWThaamxJNEp5dENjLzZXbGkwSlhV?=
 =?utf-8?B?bzE0b3d6b1V5b0l5RnppeG02ZUlVaXFLdGIxUTZZUlNWcFRrcEl1clVER0ww?=
 =?utf-8?B?K3FFeHhnQVdtTFh2VGJ1M01nQnhTY05yYmdNRlBpdEJ0eFpvSE01amVnYk1o?=
 =?utf-8?B?UTM2SmtQeGF3RFZDUmpXUGFTSzFsbGdseTdjTGtFZU1GN2hEbkpHb3RINllv?=
 =?utf-8?B?WkVRLzNsZ3hPUFcwQmttcklCNzBWalRRS0YyTkJTZDNrQW83VVZWZFQ4VVBE?=
 =?utf-8?B?cUhLdFJPbHVIL09Nd2VDTU1xcldBQ0VORXUrb2xUTXFWWitGMm0xTDBveVRz?=
 =?utf-8?B?WGVJNzNnUFl0Q3Z2VVBxelh0aTBxUFdVTEUyU1hCUmk4MVJWYUxUUjJVL0Jm?=
 =?utf-8?B?enNKMnc3OGlwcnVUSytWa0JtZ1RqZit2eUk4MThlY0xKQUFiVWVEVDljaVRU?=
 =?utf-8?B?ZFZSNGZaTmRBMVo3YS9vcGVJN0dVQXcrVGZMRFg3WTZCVG9OWFJCeTVKK09Q?=
 =?utf-8?B?emJmSjFITk05UElJVmJCY2NWSzNIR1JvR1JKY3dJOVpCajB2cmJ1VDlDNG1y?=
 =?utf-8?B?cml0TlBYMFFBOVhYVHFrZ0JlN1ZKMVpVNEc0UFllMTJSVFNySW9aOU1NZ0tn?=
 =?utf-8?B?bmYyM0J0cnZwaU5kdVNPRmlsS1BhREo0OEl2K1JNWUFHcmt5bVljeFNzbSt1?=
 =?utf-8?B?YStnalFYYTNaZ0RXUTZQeFZpNFdoK0t5TUVxUUswOVFCYUhuTlFvdjZOeFVv?=
 =?utf-8?B?S01wd1dLZFN6dVVXM2F3eFR3NzhQYmljNThXdVBBYW04M2Z2Qzc1c3ZYV2ha?=
 =?utf-8?B?WDU2Q2YwUXlWaEZGOGZJUUI5L1Q4NmZMb3VneTM5MlJrRHFNTUV1UG9rLzU5?=
 =?utf-8?B?ZHRPZHpNL0FQSkt0NVNTNUt3TTV2aVRFWlNQZ1htYXY0Zm1JSXFpa1NQM1hH?=
 =?utf-8?B?WWprT3FVQVdSQnJPVXYvZ24xU0dqSVJhOUxJaGZyNUhlbitSby9SdEh4VGdm?=
 =?utf-8?B?TFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <19771E3490DB8745A43559662A3AC719@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	8u3agi5ayxPoudB8b6oJUvLuXaEfPk8sC/lYcepuyeCRH4dLBY5iLyvlHRQPYfGS9F7lwAHP88pct/HxZAGjdkzPQqar+eQF8gGfFoGkDia6TtKzHFm4lzte9e4MYcdp1P3zrCgmbcyejmul8ngFy1zDlRXv33zAuIwKg+ECVsC5oAPY547v2A/Bqgvy4zpIMHVIMLHVvfNhUiuUgEHFakU/xgQ4UfHSzcI6kYgPDCRyXkbUXM7snX0VYLoUxnCuw21/xltNaWmC96fnKNKn2l4WArJjR0Xi0etA1KOydc1gmmhL8xKTtanX6e2szptg6vkkjLI2vzE7+FIyIF13E7qcW4/wUG2afzQAq6lxB9A6tGyI48Nyu4noklnAsxY+BJEb5Sx+DbBoLvZ7W2A470KMSWCBMsw8PpZ576vznNd+GyJaWDiVIYolsnzl0uz9bwk7L0bw17IvRAT726ycw5qMfia5gDubTrA+6dWNeH+7qwFxZHVYyMbOAQEPU6PTE3nP5vhEyNiY4uZ2PMay6FD+odRA6RsUUmhPk54pBBTwQA8nyZI21aOy6SifaZShwUMGfl8dLOcYreq9kHpMfWEiV6ha+cwsBl23fS3CdPU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bced0e0-a633-4b59-af4a-08dc4f86c790
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2024 00:25:47.1572
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WnNNKdvtJRWp/qXFkjEDkyV/z0thLMq60SpOwz1JnSv2pyDh8LWJ0xeg91dZ0Pp6lFZ3Q2b2eB4hQuXRNgOsgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4770
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-28_18,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 mlxscore=0 phishscore=0 malwarescore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403290001
X-Proofpoint-GUID: h_LqCIngpIa4htPpHBTKt9uSjeLyEDnk
X-Proofpoint-ORIG-GUID: h_LqCIngpIa4htPpHBTKt9uSjeLyEDnk

DQoNCj4gT24gTWFyIDI4LCAyMDI0LCBhdCA2OjAz4oCvUE0sIEphbiBTY2h1bmsgPHNjcGNvbUBn
bXguZGU+IHdyb3RlOg0KPiANCj4gSW5zaWRlIHRoZSBWTSBJIHdhcyBub3QgYWJsZSB0byByZXBy
b2R1Y2UgdGhlIGlzc3VlIG9uIHY2LjUueCBzbyBJIGtlZXAgY29uY2VudHJhdGluZyBvbiB2Ni42
LnguDQo+IA0KPiBDdXJyZW50IHN0YXR1czoNCj4gDQo+ICQgZ2l0IGJpc2VjdCBzdGFydCB2Ni42
IHY2LjUNCj4gQmlzZWN0aW5nOiA3ODgyIHJldmlzaW9ucyBsZWZ0IHRvIHRlc3QgYWZ0ZXIgdGhp
cyAocm91Z2hseSAxMyBzdGVwcykNCj4gW2ExYzE5MzI4YTE2MGM4MDI1MTg2OGRiZDgwMDY2ZGNl
MjNkMDc5OTVdIE1lcmdlIHRhZyAnc29jLWFybS02LjYnIG9mIGdpdDovL2dpdC5rZXJuZWwub3Jn
L3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9zb2Mvc29jDQo+IA0KPiAtLQ0KPiAkIGdpdCBiaXNl
Y3QgZ29vZA0KPiBCaXNlY3Rpbmc6IDM5MzUgcmV2aXNpb25zIGxlZnQgdG8gdGVzdCBhZnRlciB0
aGlzIChyb3VnaGx5IDEyIHN0ZXBzKQ0KPiBbZTRmMWI4MjAyZmI1OWM1NmEzZGU3NjQyZDUwMzI2
OTIzNjcwNTEzZl0gTWVyZ2UgdGFnICdmb3JfbGludXMnIG9mIGdpdDovL2dpdC5rZXJuZWwub3Jn
L3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9tc3Qvdmhvc3QNCj4gDQo+IC0tDQo+ICQgZ2l0IGJp
c2VjdCBiYWQNCj4gQmlzZWN0aW5nOiAyMDE0IHJldmlzaW9ucyBsZWZ0IHRvIHRlc3QgYWZ0ZXIg
dGhpcyAocm91Z2hseSAxMSBzdGVwcykNCj4gW2UwMTUyZTc0ODFjNmM2Mzc2NGQ2ZWE4ZWU0MWFm
NWNmOWRmYWM1ZTldIE1lcmdlIHRhZyAncmlzY3YtZm9yLWxpbnVzLTYuNi1tdzEnIG9mIGdpdDov
L2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9yaXNjdi9saW51eA0KPiAN
Cj4gLS0NCj4gJCBnaXQgYmlzZWN0IGJhZA0KPiBCaXNlY3Rpbmc6IDk3NSByZXZpc2lvbnMgbGVm
dCB0byB0ZXN0IGFmdGVyIHRoaXMgKHJvdWdobHkgMTAgc3RlcHMpDQo+IFs0YTNiMTAwN2VlYjI2
YjJiYjdhZTRkNzM0Y2M4NTc3NDYzMzI1MTY1XSBNZXJnZSB0YWcgJ3BpbmN0cmwtdjYuNi0xJyBv
ZiBnaXQ6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvbGludXN3L2xp
bnV4LXBpbmN0cmwNCj4gDQo+IC0tDQo+ICQgZ2l0IGJpc2VjdCBnb29kDQo+IEJpc2VjdGluZzog
NDc2IHJldmlzaW9ucyBsZWZ0IHRvIHRlc3QgYWZ0ZXIgdGhpcyAocm91Z2hseSA5IHN0ZXBzKQ0K
PiBbNGRlYmY3NzE2OWVlNDU5YzQ2ZWM3MGUxM2RjNTAzYmMyNWVmZDdkMl0gTWVyZ2UgdGFnICdm
b3ItbGludXMtaW9tbXVmZCcgb2YgZ2l0Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9r
ZXJuZWwvZ2l0L2pnZy9pb21tdWZkDQo+IA0KPiAtLQ0KPiAkIGdpdCBiaXNlY3QgZ29vZA0KPiBC
aXNlY3Rpbmc6IDIzNyByZXZpc2lvbnMgbGVmdCB0byB0ZXN0IGFmdGVyIHRoaXMgKHJvdWdobHkg
OCBzdGVwcykNCj4gW2U3ZTk0MjNkYjQ1OTQyM2QzZGNiMzY3MjE3NTUzYWQ5ZWRlZGFkYzldIE1l
cmdlIHRhZyAndjYuNi12ZnMuc3VwZXIuZml4ZXMuMicgb2YgZ2l0Oi8vZ2l0Lmtlcm5lbC5vcmcv
cHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3Zmcy92ZnMNCg0KR29vZCwga2VlcCBnb2luZy4NCg0K
SSd2ZSB0cmllZCByZXBsaWNhdGluZyB0aGUgZnJlZSBtZW1vcnkgbG9zcyBoZXJlLCB1c2luZyB0
aGUNCmdpdCByZWdyZXNzaW9uIHN1aXRlIG9uIG15IG5mc2QtZml4ZXMgYnJhbmNoLiBUYWtpbmcg
YQ0KbWVtaW5mbyBzYW1wbGUgYmV0d2VlbiBlYWNoIG9mIGZvdXIgdGVzdCBydW5zLCB0aGUgb25s
eQ0KY2xlYXIgZG93bndhcmQgdHJlbmQgSSBzZWUgaXM6DQoNCmZyZWU6MzAxOTgzOSA8IHN0YXJ0
DQpmcmVlOjI4NTg0MzggPCBhZnRlciBmaXJzdCBydW4NCmZyZWU6MjgzNjA1OCA8IGFmdGVyIHNl
Y29uZCBydW4NCmZyZWU6MjgyMjA3NyA8IGFmdGVyIHRoaXJkIHJ1bg0KZnJlZToyNzk3MTQzIDwg
YWZ0ZXIgZm91cnRoIHJ1bg0KDQpBbGwgb3RoZXIgbWV0cmljcyBzZWVtIHRvIHZhcnkgYXJiaXRy
YXJpbHkuDQoNClRoZSBvbmx5IHNsaWdodGx5IHN1c3BpY2lvdXMgc2xhYiBJIHNlZSBpcyBidWZm
ZXJfaGVhZC4NCi9zeXMva2VybmVsL2RlYnVnL2ttZW1sZWFrIGhhcyBhIHNpbmdsZSBlbnRyeSBp
biBpdCwgbm90DQpyZWxhdGVkIHRvIE5GU0QuDQoNCkF0IHRoaXMgcG9pbnQgSSdtIGtpbmQgb2Yg
c3VzcGVjdGluZyB0aGF0IHRoZSBpc3N1ZSB3aWxsDQpub3QgYmUgcmVsYXRlZCB0byBORlNEIG9y
IFNVTlJQQyBvciBhbnkgcGFydGljdWxhciBzbGFiDQpjYWNoZSwgYnV0IHdpbGwgYmUgb3JwaGFu
ZWQgd2hvbGUgcGFnZXMuIFlvdXIgYmlzZWN0DQpzdGlsbCBzZWVtcyBsaWtlIHRoZSBiZXN0IHNo
b3QgYXQgbG9jYWxpemluZyB0aGUNCm1pc2JlaGF2aW9yLg0KDQoNCi0tDQpDaHVjayBMZXZlcg0K
DQoNCg==

