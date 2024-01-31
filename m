Return-Path: <linux-nfs+bounces-1619-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6C88440E6
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Jan 2024 14:43:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 521821C2651E
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Jan 2024 13:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3407F493;
	Wed, 31 Jan 2024 13:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="N3t1d/YC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qIKvVzDc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426B37F490
	for <linux-nfs@vger.kernel.org>; Wed, 31 Jan 2024 13:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706708593; cv=fail; b=Bx/kdOjCc7D+i9dnWuHEkaHPzLJc4uxtcNrIR0qt3C1V4JGUTbnXQkqlyJStJwR2hTFlfHks55T4xl5dAFFVGWKQvpyujJSCIktOOTHuFWIHj/BPovT5VbY6MTBL+Amfsddxz0y3iokG+XMp2oPxGJpf3s4p3C8PD5Q4A0eEbFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706708593; c=relaxed/simple;
	bh=Do0wbf5q4ZHyF2yNeMVZXl1OtPETMzipXlRLDBr7Il4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XM3IDEKA9qj6HbCZAyg1nxRdw/RFYVJr0DfDQP7PbUMtBxg13KKzHA2d3RO0HTL/EMdJQGtSq9WuEvc23Vd6XRKXgN4Je4e77NAFEV0b3jTUE6/8ISEL722srl9pPM1M+4wNvkNjK1h86Vz7mom3L5KTzLBTnHL8SqiLvYceTig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=N3t1d/YC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qIKvVzDc; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40VD3nqL014985;
	Wed, 31 Jan 2024 13:43:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=Do0wbf5q4ZHyF2yNeMVZXl1OtPETMzipXlRLDBr7Il4=;
 b=N3t1d/YCdRfI+sQeJjLUXKnSzYqpVF9qXDEF22zt043/SyqwGc4LRppzMHj+w8q1o8dd
 bIR93HuBavU0sNItHu2MGUzNVOoQeUhg5YtNIQxLqSWVVYNq8BQ6TkMGETlb6C63fOaw
 y5EVkVt/plUbMuq3Jv/JwuiR+hbUlKx/lubnuHSFKgkAS2TbEVUalzxqzCYmRoiPMmg5
 hdqQ2ZbriCdPbxahyF9FwUXioB9di+DxzENLLe/S+r9WcCU3dwT+VE6Ml7TKS6PHD6Iq
 dViDBDoLv2/Ky9lqSi06p9/AJFUfcBBl0YRIjgkaHd83MbVHJc2sZyoK6B2u2ET0sHiN ag== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvr8ehnux-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Jan 2024 13:43:09 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40VCY8Wi014737;
	Wed, 31 Jan 2024 13:43:08 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr9f38d2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Jan 2024 13:43:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nrfnQTqVXyG4gvZyFT/dqLakubkK2UZQTGpaQw2qMKN1pOG7qoTY4yjYSvV6o1381G+au6ZcsshSGhstLA3bmey8PNw/Z79JIm4O/P8dIFFvDDmg010zXzG3Sm11oQBCLKWOtJSCO6bV/BbrNoNoGTUvP0DSH+7mvYm1cEetPYMdOnqqBCxrptdEZmLqJtWzbwhlFLhKxQ7S4yKGL0Cr7tWdaXyIjyJRodk1JZIpCrphR1QU7nFz8DUSuSiKl9/aIuD6FrS94Hx8FHlVxI9VLY2ACIOwm+26R5n2YHTr2T3nrZp2h+ZjNNbZWgNS03kb+6MBD+tdg4R4nurp1AZ1Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Do0wbf5q4ZHyF2yNeMVZXl1OtPETMzipXlRLDBr7Il4=;
 b=G00O7d746vmyFgBYGUJERMaoV1zOdaDQRb9LNw6ji9NSwkpeNh3qDiNbQUZ3e0RNeIx4Vi8NKkQpfbAq0CYXeolbiELF/lRsO4Ds/qLGKztZbZhUHU3LqxxEMcHMVe/r312Y4QWabSDxkDZiIhz4W07sf1FEy9Q35H/PYpEBdNwAQjV1o1Ka0a8wfuSzjOlWftaZzo6Kbng5X4GNw4iXJv5DKFmGBbrEfdOIpWNWTV4U5fbWD146Ut1zr2ycC/FR7GZc/JDRexxzopPZZQOKydirtV+5RUSaRG9qGTJQRS8NEyK7vtwA1fBEk83LtTIIt1rGEXPdExbblYR4lFw7sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Do0wbf5q4ZHyF2yNeMVZXl1OtPETMzipXlRLDBr7Il4=;
 b=qIKvVzDcbdcpy+zQbDD7Ge/yiABu7XaJfue8OQ1l8gjfuUdelVMQaK3dOsaZ+6vV6O1+f15olpP3gr8iqtMUm4tQ3xAWrFcgMGKg0V7wwHykm4RntKISQlimsYACGO6I55vquI3jKmd4hjNJ1HvkJCVbMVE5VwjzMUngBESgTnU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB4693.namprd10.prod.outlook.com (2603:10b6:510:3c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22; Wed, 31 Jan
 2024 13:43:03 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed:9f6b:7944:a2fa]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed:9f6b:7944:a2fa%7]) with mapi id 15.20.7249.025; Wed, 31 Jan 2024
 13:43:03 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: gaurav gangalwar <gaurav.gangalwar@gmail.com>
CC: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: NFS4.0 rdma with referal
Thread-Topic: NFS4.0 rdma with referal
Thread-Index: AQHaUFYzzofr1t4B40+h8GIuot6lBbDz9hqA
Date: Wed, 31 Jan 2024 13:43:03 +0000
Message-ID: <04BECFE4-7BC0-40CE-90DE-9EEF0DB973BF@oracle.com>
References: 
 <CAJiE4OkE5=6Jw3kf+vrfDYsR5ybJDKUffWGXAQd2R2AJO=4Fwg@mail.gmail.com>
 <CAJiE4Okdie0u0YCxHj6XsQOcxTYecqQ=P-R=iuzn-iipphkwHQ@mail.gmail.com>
In-Reply-To: 
 <CAJiE4Okdie0u0YCxHj6XsQOcxTYecqQ=P-R=iuzn-iipphkwHQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.400.31)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH0PR10MB4693:EE_
x-ms-office365-filtering-correlation-id: 11b82b42-27c0-439a-e885-08dc22628c50
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 JHxKESddb4mGSzDJq06jpJ/Ut47eHGcb7Gg3t1/zYcLyN1Rg4MA97t0MgiOXa+e3K3DfS3tkS2+JpxdCwsM90Z0PL6nbyZG8/Do1BTTChoOMTprVstqjt/w8OILtan+FsgQpWHvX+2fusR7KIFXybapYiyUdrx0ZsW3ti1pYneNF71ofyfulmeBcHxwPMQw0SDvUqvexEAj1fiB3U0QrOiiq/gJAvYB9iBSLP4n+mQreeg6dnwNbQqPkAU977NQcuAPpNMpAtnqvDY3wZiB8y5XmFzanfS7W0JmCVC1bnfwEezUX2qeRLUuWxx4BrfxNZ4wIS4PD0REhQWddZebAMnzeE3LAkL1YRmjVw2bG+zvUwELiOynPLx5E4hqCwExZa4z8+QysPYV2CIC3u0Lvlebw9xWwXTm8IXJR1jDVmTZqUpwx07lYaBiSnou21z+mc4yicHdSpx5zw2IByRWl8SP2nqcCt3smTju87GUL/0Ud0Wym5SArOHwy8cvgQyV5y3tF1Yy9WlseHfghY3Dt8L/0IqRZcTTAOyx603mCosQdiWiQr0TeQab0ICbs/r3wryLt3l6FYuaOy+/wgT86K29eI58wXlZP12kUFmEhKGw3mjRfrM2s43nB7VRutCVLst+0gujgzZ1D+S0G9FsunA==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(346002)(39860400002)(396003)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(316002)(8936002)(8676002)(4326008)(2906002)(5660300002)(86362001)(33656002)(66446008)(76116006)(64756008)(66946007)(66556008)(66476007)(6916009)(38070700009)(36756003)(6486002)(38100700002)(122000001)(53546011)(6506007)(6512007)(478600001)(71200400001)(83380400001)(26005)(2616005)(41300700001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?czFBcTBLODhtZ0NiOThrSlBndDU3OVlHRXhtZzFiQ25Pc0ZDZ1NINEo3dm9h?=
 =?utf-8?B?VGR4L2JzdzZJd3N4Yk1qUVVKQllDQXVLdm9qMEVQWVF4SkJYZk42SVVTbEpM?=
 =?utf-8?B?TEhoZEh1Tm9zMTJ5Y0h4Qzl3V0hTWTNpcFFSS2ZiT0JCU0dVTmpRYWxaMi8v?=
 =?utf-8?B?RStTNjkwVXVSMDdQbGFGRE9ENXN3K05GSW1qbGplWGc5R2daT2JiMUxZMnBz?=
 =?utf-8?B?ekE3NWRaZEZjL0szU0xWcTV0bjJYMDduTTQ1V1lmMm5VUS8yTHlxZDVDREtZ?=
 =?utf-8?B?QmhHNEJESlRaQTd5anIvN3lBRU1DRjN4TTJwbE5zVU5waUJHT0lNOVY2SklI?=
 =?utf-8?B?QVB3M2h2TEpFT2pCNkFWeFUrNk9UUzM3OGwwdzRESGRaSWlWcXpDZGNVNFJK?=
 =?utf-8?B?YzR4ODNtdW5VZG5LR2x1L0Q3OENQaFdsRHllVno3ZllCeU04Z29rNEpJdlly?=
 =?utf-8?B?ajlOY1NrT3M1YndFUDFNV1R5M3BxTHM5eHUyUmMwNDFEajZxaFZqdDRzaXV6?=
 =?utf-8?B?bjh0cmZsTU1ObnAzS1NteEhDSTlZWUVUTEMvUmFqNURuYnQwTzR5K1hpQVlO?=
 =?utf-8?B?T1VNZldhTHZmbjlQcWpnUG1BVC82QkNtcGZyekxDTGFweDNBZklES2pDTUtk?=
 =?utf-8?B?WXErKzhvTTN0UjFpOEEwb1pWQ3F6WklxNSsvMkNjRUNoRldMZjJRbUlXenFH?=
 =?utf-8?B?amYvb0p5elhBSmJkTGw2ZGhNbWNTajZ0YURtcVBFelZCaExMZmU3S0NXUS9O?=
 =?utf-8?B?TXVQZDI0QmRwMzB0dmdDekFGUVlFM2cvWTFpbmF1Y2F4WlVsZ2dIeTh6Ukc0?=
 =?utf-8?B?RWViMjJLNHBWU1pyOWFPZlE5b3JWYld4bGJkclhOa09UK01mUGR2NzkyOVAr?=
 =?utf-8?B?elFxdEJRbjF3RkFqZ1V4dCtReUlRZWhEb0pvQ3FETGk1TzFSUGdHSkl6Ynlh?=
 =?utf-8?B?dVMwQTJUVm1aVk8ycTF4QzRINXZHWXl2ZFhMbkNpTTlDVlNsdmhQS2IwRGZu?=
 =?utf-8?B?akVmNmpPb1lvcTN6Sy93b0VDWmRsYVhvWUpFY3RNTzBkcHYwV1FuazRLNjNB?=
 =?utf-8?B?Rkp3VkkyWGkxVUlFR2EzYTZFVi96WnNoWEZSckpLZEZLQk50UEZ1R1dPWlgy?=
 =?utf-8?B?VURnekt6ZXhkRFlISCtBQThXcFc1b1Ezb2kwTTJzTnMxWXBYb3FGVmZFaHZy?=
 =?utf-8?B?OGJQTXVGejRXVnRRcklXUis0TXA4eXdwVm1pVFE1ZzZlSkIvdk51aklJRDYy?=
 =?utf-8?B?NHF5SnRpcTBUd2M3RHdSRzRibFlSRm5iUFcxbkRaalBWbnA2bXFaY2FsbmZC?=
 =?utf-8?B?b0NXMm9oR3l1VHIydTlPdVRIU2IwRWc2UTNNVjdvQTNOaUt0azVEcFJXRXdP?=
 =?utf-8?B?bU5qNVFGejQ5azk0NEZ6NVljUnViODdOc0FGTU1KR0lWMXZBbUorMCtMck5v?=
 =?utf-8?B?ZFp3dUVnRitvRTJmbU5iZFZlcXM5bURIcE4wcmlkTXZlU1BaSTFBZWo0dGVt?=
 =?utf-8?B?OTBpMjRzM05adjNFQVczcGtsZ25wdmhudUpOVGU2SXE4dlZyMzZmQm5kZ3hO?=
 =?utf-8?B?RDN0eCtNcTlhQ3k3VC9qV200TDNkWmlpTkhGUjVibmQ2R3JrOXR0Y3p0bWE4?=
 =?utf-8?B?VWVOQStLQVBkMDNxR3Vlc0N3ZCtPQm1tNWJwMFNnVVk3T2lNYkx1NFJSWlor?=
 =?utf-8?B?S0hiczJ5bWZUNjBwcWJHNFNxdmpVeGx6MXdpNzhxMUluRVB1NVEvQzJtYStQ?=
 =?utf-8?B?cSsxc3QxUmkrU2NwNUpvcGFFSDhxTDFmOWl4TWFHb3NiMGk5b0h2M2YvK0Rw?=
 =?utf-8?B?RUFhQXpWNW1RU0VVNHBLb3FhdjN6RlJjNTBxVjA2bmFPalVzYWNCK3ZKN3Ur?=
 =?utf-8?B?RDd1VUtLVVgwanoxell6eDErVTV4eEVBT0dPQ1BhS1czQmhLeVhORGlLZWdj?=
 =?utf-8?B?WVVXd1ZvV2hEQTFPMGxNUjNaNkFQQWRJdmhXNDZSKzBtVjVsOVpNbWl4ZURl?=
 =?utf-8?B?UFE2L3pzNlp3YjBZWFpxckFhaW5ZakxLWFJPdGdubGdYY21nNkMwbnByWGdu?=
 =?utf-8?B?M3ltY0Q2Zm9OaUpDQzcrb3pIUE1VTlBNQU1nSmhrRnpyQVFJVTRiMnhBSUxC?=
 =?utf-8?B?RnFFZk4zS0E4K2crOGZDbXZYMGxlTzBLMkJaQ0EwdUFET2RZd2xhNG9jR2pM?=
 =?utf-8?B?QkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <966E14B254E00E41B7C6E573B6850D75@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Se59mk8N2zAwFMhB8SoHX5gdBDL/RnY0GFl39SI93HY+miBCGUHd6IaJtDKnd1NGQoJ9Ud7n0MTKL42VhnxwXZMLipK6dRuKApMcXFCVr4O+C/LyYBAt/ec2PNHIIAgWowjpCTYOEeknUX5uT0j4jb6MzXkPsWgMezcw1x1Uupn7fT46Oz4H3Np5ODX7VPfMReK75WlrCqV2sSwW3YaaKw/NMRxYMAcB3nu8IZDSmbjz8jFiB8bbYrM4tbOLLalwOf7yu7eiDLWY9hfT/h4dJ2skmCyojraslNQToWL05m8lPUNEwVBdyGb3vXPyE635kJHaAvxF0eHZG7ak1m+V8eMB7td8jP40eu+Hzr2CWzyUAHcUKZhVUWC7VklyVopPTeefCWrTMVVrRKTQVrcWnhVUeT3QmmZbWJonTJXP+VvmN7y+JbJxyzajzsq4gx3p8r9RBMLYWnUm5/IT9isSKURIZc23WLkvhizqnyQesN1+6MKKmsxm8U+ZfZiCDwAkmh1bIikBWNXZMGriiXg16e+p0roItebANln4TVmMN6dBQXpuNaaG+/dzhWZ6Rd76M9PayzRk3JA3aKoMdXhCic3+i6Ihx0di0NpqVKNqOsw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11b82b42-27c0-439a-e885-08dc22628c50
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2024 13:43:03.5978
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YQo1N7iUgOiAuK+4GEtTzuwynsGgoW9xsX31rmqQLfhQ0mJFHW0YX8NcXDuML9ovOTYWeENNHZ3TEk0yrJw3EQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4693
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_07,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401310105
X-Proofpoint-ORIG-GUID: H_z7tVdmOhBauTybG4YAWus2XDv2QOur
X-Proofpoint-GUID: H_z7tVdmOhBauTybG4YAWus2XDv2QOur

DQoNCj4gT24gSmFuIDI2LCAyMDI0LCBhdCA0OjUz4oCvQU0sIGdhdXJhdiBnYW5nYWx3YXIgPGdh
dXJhdi5nYW5nYWx3YXJAZ21haWwuY29tPiB3cm90ZToNCj4gDQo+IEhpLA0KPiBJIGhhZCBvbmUg
cXVlcnkgd2l0aCBORlMgcmRtYSBzdXBwb3J0LCBkZXRhaWxzIG1lbnRpb25lZCBpbiB0aGUgbWFp
bCwgYnV0IGNvdWxkbid0IHJlYWNoIG91dCB0byBuZnMtcmRtYS1kZXZlbEBsaXN0cy5zb3VyY2Vm
b3JnZS5uZXQNCj4gUGxlYXNlIGNoZWNrIGlmIHRoaXMgaXMgdGhlIHJpZ2h0IG1haWxpbmcgbGlz
dCB0byBhc2sgdGhpcyBxdWVzdGlvbiwgZWxzZSBwb2ludCBtZSB0byB0aGUgY29ycmVjdCBtYWls
aW5nIGxpc3QuDQo+IA0KPiBUaGFua3MsDQo+IEdhdXJhdiBHYW5nYWx3YXINCj4gDQo+IC0tLS0t
LS0tLS0gRm9yd2FyZGVkIG1lc3NhZ2UgLS0tLS0tLS0tDQo+IEZyb206IGdhdXJhdiBnYW5nYWx3
YXIgPGdhdXJhdi5nYW5nYWx3YXJAZ21haWwuY29tPg0KPiBEYXRlOiBGcmksIEphbiAyNiwgMjAy
NCBhdCAzOjE04oCvUE0NCj4gU3ViamVjdDogTkZTNC4wIHJkbWEgd2l0aCByZWZlcmFsDQo+IFRv
OiA8bmZzLXJkbWEtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Pg0KPiANCj4gDQo+IEhlbGxv
LA0KPiBJIHdhcyBleHBlcmltZW50aW5nIHdpdGggTGludXggbmZzIGtlcm5lbCByZG1hIHdpdGgg
bmZzcmVmLg0KPiBXaXRoIGRpcmVjdCBtb3VudCBORlN2NC4wIGl0IHdvcmtzIGZpbmUgd2l0aCBy
ZG1hDQo+IEJ1dCB3aGVuIEkgYWRkIGEgcmVmZXJyYWwgdXNpbmcgbmZzcmVmLCBpdCB1c2VzIHRj
cCBmb3IgcmVmZXJyYWwgbW91bnQuDQo+IA0KPiBbcm9vdEB1dm0tY2ExMDJiYSB+XSMgc3VkbyBt
b3VudCAtdnZ2IC1vIHJkbWEscG9ydD0yMDA0OSx2ZXJzPTQuMCAxMC41My42NS4yODovZXhwZGly
IHJkbWEta2VybmVsDQo+IG1vdW50Lm5mczogdGltZW91dCBzZXQgZm9yIEZyaSBKYW4gMjYgMDE6
Mjg6NDAgMjAyNA0KPiBtb3VudC5uZnM6IHRyeWluZyB0ZXh0LWJhc2VkIG9wdGlvbnMgJ3JkbWEs
cG9ydD0yMDA0OSx2ZXJzPTQuMCxhZGRyPTEwLjUzLjY1LjI4LGNsaWVudGFkZHI9MTAuNTEuNDMu
MTAzJw0KPiBbcm9vdEB1dm0tY2ExMDJiYSB+XSMgY2QgcmRtYS1rZXJuZWwNCj4gW3Jvb3RAdXZt
LWNhMTAyYmEgcmRtYS1rZXJuZWxdIyBmaW5kIC4NCj4gLg0KPiAuL2V4cGRpcjENCj4gW3Jvb3RA
dXZtLWNhMTAyYmEgcmRtYS1rZXJuZWxdIyBuZnNzdGF0IC1tDQo+IC9yb290L3JkbWEta2VybmVs
IGZyb20gMTAuNTMuNjUuMjg6L2V4cGRpcg0KPiAgRmxhZ3M6IHJ3LHJlbGF0aW1lLHZlcnM9NC4w
LHJzaXplPTEwNDg1NzYsd3NpemU9MTA0ODU3NixuYW1sZW49MjU1LGhhcmQscHJvdG89cmRtYSxw
b3J0PTIwMDQ5LHRpbWVvPTYwMCxyZXRyYW5zPTIsc2VjPXN5cyxjbGllbnRhZGRyPTEwLjUxLjQz
LjEwMyxsb2NhbF9sb2NrPW5vbmUsYWRkcj0xMC41My42NS4yOA0KPiANCj4gL3Jvb3QvcmRtYS1r
ZXJuZWwvZXhwZGlyMSBmcm9tIDEwLjUzLjY1LjM2Oi9leHBkaXIxDQo+ICBGbGFnczogcncscmVs
YXRpbWUsdmVycz00LjAscnNpemU9MTA0ODU3Nix3c2l6ZT0xMDQ4NTc2LG5hbWxlbj0yNTUsaGFy
ZCxwcm90bz10Y3AscG9ydD0yMDA0OSx0aW1lbz02MDAscmV0cmFucz0yLHNlYz1zeXMsY2xpZW50
YWRkcj0xMC41MS40My4xMDMsbG9jYWxfbG9jaz1ub25lLGFkZHI9MTAuNTMuNjUuMzYNCj4gDQo+
IA0KPiBJIGFtIHVzaW5nIFNvZnRST0NFIGFuZCBib3RoIHRoZSBpcHMgaGF2ZSBhIHJkbWEgcG9y
dCBhZGRlZCBmb3IgbmZzLg0KPiANCj4gfiQgY2F0IC9wcm9jL2ZzL25mc2QvcG9ydGxpc3QNCj4g
cmRtYSAyMDA0OQ0KPiByZG1hIDIwMDQ5DQo+IHVkcCAyMDQ5DQo+IHRjcCAyMDQ5DQo+IHVkcCAy
MDQ5DQo+IHRjcCAyMDQ5DQo+IA0KPiBBdHRhY2hpbmcgdGNwZHVtcCBhbHNvIGZvciBzYW1lDQo+
IA0KPiBXaHkgaXMgdGhlIGNsaWVudCBub3QgdXNpbmcgcmRtYSB0byBtb3VudCByZWZlcnJhbCBm
cyBsb2NhdGlvbj8NCg0KVGhpcyBpcyBvbmx5IHNwZWN1bGF0aW9uLg0KDQpUaGUgY2xpZW50IHdv
dWxkIG5lZWQgdG8gbmVnb3RpYXRlIHRoZSB0cmFuc3BvcnQgc2V0dGluZyBpZg0KaXQgd2FudHMg
dG8gdHJ5IHJkbWEuIEl0IGNhbid0IGFzc3VtZSB0aGF0IGEgcmVmZXJyYWwgdGhhdA0KaXQgZW5j
b3VudGVycyBvbiBhbiBwcm90bz1yZG1hIG1vdW50IHdpbGwgcmVkaXJlY3QgdG8gYQ0Kc2VydmVy
IHRoYXQgYWxzbyBoYXMgUkRNQS4NCg0KSSBkb24ndCB0aGluayB0aGUgTGludXggTkZTIGNsaWVu
dCBkb2VzIHRoYXQgbmVnb3RpYXRpbmcgeWV0Lg0KDQoNCi0tDQpDaHVjayBMZXZlcg0KDQoNCg==

