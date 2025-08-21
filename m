Return-Path: <linux-nfs+bounces-13843-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A45BEB30153
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Aug 2025 19:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7267E179E5D
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Aug 2025 17:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ACCC33A001;
	Thu, 21 Aug 2025 17:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SDdMOPg6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="n7PpYy1U"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182B13376B7
	for <linux-nfs@vger.kernel.org>; Thu, 21 Aug 2025 17:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755798111; cv=fail; b=HnxWLdkECtKKTCXrjQOhmV286YQeA/YWaFN83GEo4Xxfz2Tl7Jog0OMZBgt5+ngvpxMb5hHIj8YM5Gvgsz5slrc0Q/UQBnOGVhKjnA9gqhkQfFTlGV0bBtlBxISqUB/dcvuCSvTToPmyTwxMUjSIcdB2kduaqJDzIpsKFYI34To=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755798111; c=relaxed/simple;
	bh=ifnobySRx39IskiYe6XjVLpGCKFH79B6PGWFFiWW+XA=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Yt8O3VfAqeB7izGKRvG2Lm3uaVRhyc1N5iLQFFiED/YzQdpKfeIt2yjAau815tmP0qmdvnWAuGSwGwHq7H4A2ZndwJ9yg7/C92c+1bO8c4AdM/qxJP6H8F/V4cRFxBeC81ShHb6shjs7KzwWjupRisvDvF988KufJ4ao9iA1XMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SDdMOPg6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=n7PpYy1U; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57LHRoxW004959;
	Thu, 21 Aug 2025 17:41:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=ifnobySRx39IskiYe6
	XjVLpGCKFH79B6PGWFFiWW+XA=; b=SDdMOPg6Sf/51uR+X2pJ6O0cdG1ymnyz4h
	D95oxWdigcG9MDc6I+lbm1z2IBs7byFDn5TIIFUsoGp/7szSqLVmMn2V2TcFKdR4
	q9Ai99X5dIkuHTyFypWh8pX1JMOy0fToKMGuDg7+G052Op1SDDutMZxoUyGnMHz2
	meCuRchIpG5zRVdnBZUrmADLitgI6EDY2skoKaQJImPE5cf40FVwK9gI7REXPjn3
	cAPVBG730PK7j9e1OvmfC51ThY7CMjP/tq7dDmvOWw0gVQWdD+Ey4+OUpvlJ8gmZ
	07+si2wUFF7JIzW0v/j4BLK+vbOC2parRTNEiDnSXSWQ1KSMoR0w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48n0tr416e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Aug 2025 17:41:37 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57LHVjqL007314;
	Thu, 21 Aug 2025 17:41:36 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2078.outbound.protection.outlook.com [40.107.236.78])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48my3sd13t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Aug 2025 17:41:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vxAKld0mpp1mtDyjCFnXAeJQdZHbrTRJowTaX0hsrOM/NJL1toOAMmjlXrwCb9ONSSXjnM1vyFGvVPUGqch21vuLeSxGrWITOZ0wSOeyS+ZwNlZg0ggZ8qhlFEE+opK9gUUaPHOkEoH4f7b29Sbca2VNENwUJ9DshwTwqItiIK2p5fherXZYjkTxkWtHUuxm84mCa5K3d56ZksgAk0M2P6luT9klZDk+JIWp8qFuvhN0xkY/yjkk74Uk3uPto/OfXapGFIoXhBYNAsXqH8P5vQ/PeIUZZvmxbTPrSRKwxubyj6jqw4upWkiy1EVmZW7udyAStBacT4XYU3KVnQPvgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ifnobySRx39IskiYe6XjVLpGCKFH79B6PGWFFiWW+XA=;
 b=Ukbl42DPA6RHmsZe0ah7jvXbTZL34N2cCrqK7ecqIN1OittKAHgtAvo+1MNWk6Tv8BoEauwrfODavjqpjK5nyFQV884Hk7IGpGLKp51atAv8QclOt5+fDXfa3wJ7NwPkWS45NPLGhE5wJ5gQSu1JojlOS7MDg8PJ+ir0CZk+t4yd7za+hmFgAnuLeThHo6Sk4ClINuf0PbtS811TZbsqwELrZCDiN5b4mqTwLXyphgyil5/1Spb5KWWhW8bFDBqoKTzWOtlhS+UPFc1HdidLBBCc1H5HgCYofGOU99r4VzNIaEnAHUGD7PERFOFoK4s7BuSFAeU7HFF0UL01es3MJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ifnobySRx39IskiYe6XjVLpGCKFH79B6PGWFFiWW+XA=;
 b=n7PpYy1UPqXuaQ4jYSlPImLLcpDfp5qEo1qSd8LJT1TGi+8wGESXVi8T8MfFInyeCCzAzul/tUnypw6R9HP2yAO3rQ36etb7cKsVrgatfvz3QxWHN/XA2MvD/jfYuHAbRNuQqk+ROQqduaNgp1VEstFQrJrfKnPHf9iBMBuyTkQ=
Received: from DS7PR10MB5151.namprd10.prod.outlook.com (2603:10b6:5:3a4::18)
 by PH0PR10MB4631.namprd10.prod.outlook.com (2603:10b6:510:41::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Thu, 21 Aug
 2025 17:41:34 +0000
Received: from DS7PR10MB5151.namprd10.prod.outlook.com
 ([fe80::f493:6425:26c5:36ab]) by DS7PR10MB5151.namprd10.prod.outlook.com
 ([fe80::f493:6425:26c5:36ab%4]) with mapi id 15.20.9052.013; Thu, 21 Aug 2025
 17:41:33 +0000
Message-ID: <2c52fbdc-97b3-4f61-ba59-1377eedc6f13@oracle.com>
Date: Thu, 21 Aug 2025 18:41:24 +0100
User-Agent: Thunderbird Daily
Cc: Calum Mackay <calum.mackay@oracle.com>,
        'Ofir Vainshtein' <ofirvins@google.com>,
        'Chuck Lever' <chuck.lever@oracle.com>
Subject: Re: PYNFS LOCK20 Blocking Lock Test Case
To: Frank Filz <ffilzlnx@mindspring.com>, linux-nfs@vger.kernel.org
References: <01d001dc0ba9$e4cb0080$ae610180$@mindspring.com>
 <44d19311-7644-4f6e-8509-ff7312ba3ad9@oracle.com>
 <009301dc12c1$4f9cb390$eed61ab0$@mindspring.com>
Content-Language: en-GB
From: Calum Mackay <calum.mackay@oracle.com>
Autocrypt: addr=calum.mackay@oracle.com; keydata=
 xsFNBF8EmckBEADY7zXjHab4thpE0tJt04MQJYJKBt72eXTweUlzrny8e55IrVpNI6ueSzD9
 bmTRscSqXNgBHbxOxDpajZpELgLm5c6nXjrmc7H01jWvMbrXheWWYJqp3rAohb2TgKn3iU/X
 1JasxFPghPyAvPgvJkRVzBuiKpcg3iPOUId7Q6GNinXZvOKvEWaP7G5abVZUQOT4DTTCPDWY
 ENTDwEL8nonRCIw/ip26WBoFsuUrW981X/Vch46otvSZay5ewiBL/ZO45JxIJdtMglLGoEC0
 AVrTb3TU/EHMCO5GjoWPt9xxMixG/Wtl/8Ciz0PHnJGT4a0LcNgXYWdecIS0GsBxCznGcLnI
 NLYCdoY17DuUsFC3P7EBpiS0ew0hlHAJt/jjX2AjqI/GXptzUm/sc8td99of2ksYZ8O+vmgK
 As/mbNuPyvd6skTh8R8xEZZ9zGhNmGxPP7Xd/Eud3ShF9oqx4lTj0eZYy5oWzmLFTN1D1uBj
 U+aitbp9TPyPVgqxm57p430CY9EiRocvfarWTOEEswgorumrPQzdtspxtqCZd3AfN3EMvKT/
 YtBO+OQHW9ljZNi3VjBgeH7DlXBQDLaJh6MzqX3htRIDumPhTA0kMaQQahcGicoe6GP/Eox2
 m7fulWq8AGDpwufNdV4WOSt86D4h8orUCz5sctIDnxg9PZjzUQARAQABzSZDYWx1bSBNYWNr
 YXkgPGNhbHVtLm1hY2theUBvcmFjbGUuY29tPsLBiQQTAQgAMxYhBNRgW60GIMfKPVXcPoUj
 7wBtwVPiBQJoVJRyAhsDBQsJCAcCBhUICQoLAgUWAgMBAAAKCRCFI+8AbcFT4pmhD/sGE02C
 7WK5tjg8i54rxTaRY9Comezl6Dv4B4ikccemvltZ7hPFRFTcZps92UVRlBXxbQ2N9nbe1KgV
 da38Sl15rKKExExnspNHzTw4902kH/+mmhRt7sGVppbW2vsX9LxIOG9O5QCSz0EVso7Tw3oh
 6u0uCTT5ZaS8kM9/XLNCpBMx7CYBKyPf3O7OXVamZx8JMiSHH0Wm5/V1W+hYi9eA6L1xUzsu
 cYU0mun6NVCi9i6d3/qQyTMk6bVta/gY5DPJZI/8xopwfuIPGnb16yBm4RZwv4AiCkwN1c/n
 yDhLtzfe9HcnAblN4/yyutIXRtI73BgHOYNQu5vKiNgBtA84Hwbs1V5e5zQEfw1TwwOKfHT8
 sQK7WytOzXtnFo3o6tAoRimcccRQuDcFwFJ377emKIbw4QIs2FJ7l+iVSgnSTs3oUH4zaE5r
 kRnLdQqH7AFNhElvUhvhJuzyCjexNFZBpI04KgFAVZGjhSTUogd/HQSHG5B+SFEIpW9Wpbl4
 YyFZsMkArICUXKSRZAzetRIqFsIPiPntzpVw7PW05ZJ4e8W2lmSyVxl245S2b+zYsEvXudYO
 E2GBAA/re3L3FcyHxLrT6DTS9N098H0y6XwwBPa5l7G1/FVOCcSvInHm2aA2dFFL14uTKtU2
 7Q6huO360hBvVADBicM9JrEkaqM1DM7BTQRfBJnLARAAxwkBdfVeL7NMa2oHvZS9LOy2qQO3
 WVN/JRmyNJ4HF/p33x9jwemZe8ZYXwJBT7lXErZTYijhwTP4Ss6RFs8vjPN4WAi7BkBU9dx1
 0Hi+UrHczYrwi7NecBsD4q2rH4xs/QoN9LNJt4+vLzh9HqlASVa+o2p5Fs3TyNSBqb4B7m55
 +RD6K6F13bfXM84msz8za2L9dxtjtwOyOYFeoODMBhdkMourO+e2eSxOtecJXpldx1LZurWr
 q7D79wmVFw/4wP+MOAHKPfpWo/P18AfXEW9VD5WBzh9+n8kquA0C8lnAP9qRxtTsIAicLU2v
 IiXmiUNSvAJiDnBv+94amdDGu6aJ+f2lT2A5+QHNXb0QeaV2ob8wzCOOwZZG5hF99zbS0iVR
 +7LgnJsoJYcKVrySK5oYfAFMQ8tUA102dZ6lHkVdRw77mIfbaXB637SAIxJGpwI1bDw3+xLq
 dqJW/Rs3BDSGrJRMPE1MnfvaAPfhqWSa9aFZ7wZPvO9sm9O5zO3R08COqCLgJxNOAVnJCw9a
 C5X1XzWyQvE3NA94Afl3KVAU1uxtgTpnwP5J05SllpSXeF4DpnH+sFX4+ZS4Cx+V96DgYY3e
 w6/SUGdMbEfJsqelCqz62vHguMA4cLIMbOnbh9CkGsYeJEURixCywgft5frUtgUo5StuHFkt
 4Lou/D0AEQEAAcLBgAQYAQgAIBYhBNRgW60GIMfKPVXcPoUj7wBtwVPiBQJoVJRyAhsMABQJ
 EIUj7wBtwVPiCRCFI+8AbcFT4hQLD/9j85fIhOJrkaHRWamwWnAjY3IaO1qhDL2NdBgG5akd
 y9nQfPg0ZJedCe/WLQt5khZr+GNVzAJO0eD6GpwUya6TjhD5YpvGxpwMafOTnhrDq6JdbjyX
 BrY0mTLatWGKVM2x+5VsLiuGm4UPJHzCazeuLzfnJ09F2W8ejrzaNsRj+uisopxe1qkaFnGA
 zKM2zhCLXDpUnt2qLP1FrKF4OrIMg9e+2ZoJVHBW7NAUVEQHQ9ukDL7wIeXEZqXBr26kOKp+
 UKL5W83z5210aRMCuJxDkgNpa0kOsNOEQpKkAmiu/ax3DFgsEFVc2n7dfg7R6orXx6sOQ8rL
 52kBUuxMu9ZXSFmG9Zhk4+lWCCN3umse68ekqvw9STaZgfSic0DlajxDbe3zNlS5mWlrTjHi
 RSKExo7v80t9D9tjjWizMXyOjugQdikv72qACbY1KqK4h4co1Pwq6wFGM1p/UB1zIKO75mCd
 0FQ0IF5IvpTaIlh7IoFQlSOnF7R8LU23a2Y15oCnwg5AArGpkPkdNevxDiWlkONC9SFgNft1
 uJS8gMUuW/7V+zy4UnT+HNL/4UAaEGpXTeBa3uooyfKpWSsoIm0Jxr2g0mUmbzWKY+bzrz6r
 ztB4G0NYwyUhrzTCRI1/VN0X2BeGY/Xx/q2Rxn+SM2ZrfMB0Jn1QTbg0HKYt3AZNcA==
Organization: Oracle
In-Reply-To: <009301dc12c1$4f9cb390$eed61ab0$@mindspring.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------0m9TOOBeukegDXK8dI3P3q2i"
X-ClientProxiedBy: LO4P123CA0505.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:272::15) To DS7PR10MB5151.namprd10.prod.outlook.com
 (2603:10b6:5:3a4::18)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5151:EE_|PH0PR10MB4631:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b8f84bf-a337-48dd-8a15-08dde0d9f81d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NVZSSU1kS0VOUFRScjhCY1Q2c1pZUUhBT0lSTkxpUkduSGtpck9rRGdFNFBk?=
 =?utf-8?B?ejhqb2taVzZXT000MnJRMUxhdmMyWU1aUEVZa3NCaDVNVGpvMitON2hJQU4y?=
 =?utf-8?B?Z3puNTA5QnA5NmxSSElGWW12ZFRBSWVKNktmb0FBQXZ1a1FxZmt4aEVSZ2kr?=
 =?utf-8?B?amlGR0Q5L3NZcWJZcXFjbXBaVS9uQjVsQ0RBZnB1K1ZWdXA5d1ZHakV2ejB2?=
 =?utf-8?B?N2h4R2xDeUNzNXZEcGlnYUFJMU5vak80Ri84bHpxVVY2S3ZadFZhM2pESGRN?=
 =?utf-8?B?NUVNdEo3d2pzcUF1OGU2UFRRbVNGWS81T1F3V1NjVURJR25vVWxzS3NWa2tQ?=
 =?utf-8?B?MVhVOFBBZlNTRlRBRXdQc0ZodXFNL3V1VFFnQjYwakFEY0E0R0hUakZUY1cz?=
 =?utf-8?B?MjR4TVk1b1pZRTlvcjZ5WnVBQkQzdm40MHBDRjZqd2xWclJwYzJxMlh0cXc3?=
 =?utf-8?B?bGhCaW11OU1HVmg2Sld2UDdVeUtadUpsT2syNmpGdVFLKzJYb0tKWTFNTUNv?=
 =?utf-8?B?aHQvREpxNmtia0dKMVk2cWVxaWFjejBORXZ2eFdiUzhYbEFVTnFoZkhnSndl?=
 =?utf-8?B?b09VRmdZaXZyUkRzK1NBeWN5Zk1BODIwN1VReXpMa2s5aWhnSWVqdklzWWpP?=
 =?utf-8?B?RGlsL3ZTeXhERWxzeDlpdHpsUk1MYXVTVE1lMU5MaU1nTk5jUTFmYlZxeVNT?=
 =?utf-8?B?SnJJczVKdy9HWUdUU1lDUDM1Smc0YVdEOWw4M0JtWVBMZ0NKNjVkMmdoUW1Q?=
 =?utf-8?B?bnRKMWJBTDBwYXNxL09EWWtXbjBzeUFjVytmMjJCNnF1TWp3eXFCbUdVa3NV?=
 =?utf-8?B?cE5oWkZKN3VXYVFkS1pMNUY3NHZndzZTQTE3ZFg2aHBJcEIrcUYyTU9HZ1lX?=
 =?utf-8?B?dndSMUY3S0tCMHdtL2NBeVA2RnZFU0ZHTnVmQWRJQUFXYmVPWXlGTlJpU0ZK?=
 =?utf-8?B?QnhWcE10OTBXSjhNZDNBYSt0N1ZqU0hKemtWK0l6MzJReWI1ODFUYXljeFdv?=
 =?utf-8?B?aFQzZlJZMFNkWkg1WTJVeHhMMVFEaDhpUTdEWEh6S09OTVhKRTVKYm95NEZF?=
 =?utf-8?B?RjZTdUVxcm5TWStDWEVTNmVoQ3V6bWVuSFNSNTJWdEVpdE1BcUg0eWJLY0NC?=
 =?utf-8?B?SmM5djVjVzEyT3ZQNS9tb0pWbGFtVGIyN1U2cDA4TUVEOHRDU1hLZlhpUlRZ?=
 =?utf-8?B?YjRVNTJ3TVBiQnFoYytkV2ZWSVF5MGdiQTMvR1lsN3A3NW9mTFFWS0hTMnc1?=
 =?utf-8?B?d241eE9LS3NvaHVRS0krUlc5ZVdSVzVqcitvVzdQNVFybW9iMEtodlRET1R0?=
 =?utf-8?B?VGFhZGlZdnRoT0NqcXhuSHpjdGM1MnVpdE9xZUt0QlZEYzJET0w2bTgxR3dX?=
 =?utf-8?B?SWRrRnFCem5KcTUrb0RkdE84S01GVkd4S0c2d3RmQm5oTzBrYUh6QmpIL01Z?=
 =?utf-8?B?djNOZWJaRkE1Q05EcnJtMXY2eHFFVjZHSzl1b0k3THlwdHMwa05qczJrVFpP?=
 =?utf-8?B?QWlNOXR0NzYzb2grWERhWkM1dGthbXVmRGNyWjN5dlRGbjNtdjRFdkk0SE1R?=
 =?utf-8?B?d1psMEhXWVlZdEhhVHh2ckRaMXM5WXZ0a0VHNUtzdmNhb3Z2VVJIY1NaaExN?=
 =?utf-8?B?YitTU3JWUXFEa2ovK1hiZitLdFdCU1pGdWxPK0Q0aHcxbmNVMHB5dmdOTTlN?=
 =?utf-8?B?VDl4ZWZwY1NBc2VlTzcwaXd6UzBjRllsbU5OMkN3THFPR2RpakwrQTIzNzVo?=
 =?utf-8?B?U2h4cGJvZ1dWYk1sRzhaM2pUbXdMdjEyYWM3WktkQWtJTkxRRzhDcFE2SHIr?=
 =?utf-8?B?emRDeXd6MVFERklwK3YzWHJmSHpDK3pmZWdueHpFWGw3VGs1eXA1NEFhRUdS?=
 =?utf-8?Q?5bMNN5kczVSAy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5151.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T1FpTkhUQWpjbnZCSmFUMnVQWHcvSXl2Sno1TkdQaFRsamVtK2xoTjNjZ0F1?=
 =?utf-8?B?bm1nZzBNTHNVM0JNbTJLNUhwV0NCZnVBQkxZTUYwN044bk1XSmxzd3BHTC9t?=
 =?utf-8?B?dVRLRlp2OU1WQVBpNERDQkhMbVdUVFd6WTZGQk96WjFYbjU5ZEtIeWRqQk9P?=
 =?utf-8?B?NytJVGRNSHRTSVBjT3kwc0NNaU1xYndoM2RUVUQ3aWFzVVRvR2pWbTRNNnE3?=
 =?utf-8?B?S3ZaRUs3K2J2M3dCSUtjRVpUQnRRTjlxd0lMY0JpNHAxUFNsSWJyZSt0dzlR?=
 =?utf-8?B?N3ozM2ZjSnBNb0pDWVFkelQ1WDJyblhheEFkTnRTOE5oc0sxSG1ybUUrY2Nh?=
 =?utf-8?B?d1IwZ3RQRGE2aVhiWVl3cFlzRWUvRnVaOHBWM1JDbXBLU1VRWk43b2pnUHNY?=
 =?utf-8?B?UFFES3V2K1F1eFpPV0RrTXhnNWlVc2lTVW1RS21hWVZtL1kvV0cyN1cremtw?=
 =?utf-8?B?RmNKR0Z6ckR4a09YU25jS0NibEt4ZDIxeVU2TDRNQlQ0NHVsdHJHcmJueE5Z?=
 =?utf-8?B?eDMvczlOeDZTd3NsamZiQzBWSGtSRFhLVWVrMTBGL1YwV1N6SEJYYU45aGx0?=
 =?utf-8?B?VmplTWNEcC9aMW5TTW96VlNVM01BaTJhUTVVZVRNN0l4c1o4Q2FrVkNvd0o4?=
 =?utf-8?B?aVpQUVUwYjV4cVFSeTh3em1nUlFHUm9tYjAwZmpDYW04NFJqQjVoUWxabjB5?=
 =?utf-8?B?eVFKd1hqdkVzUm8wSUlEc21kNWM0NWkyaFU1S1Avc3RLZXJHak5MdTN0VzJk?=
 =?utf-8?B?TzBocGU4QzRtbXFBMzREakNPdTM3V3B2eXd2VEFLcTNwOXJZUk9iMnY3U1hX?=
 =?utf-8?B?dFJJeWJVQzErZVA4VE10MmQyYWF5REIzRGpBR2JERDgxTWFGeHUwa3dZTWxC?=
 =?utf-8?B?T3Z6SVBRcmEwM3IwT1dyc0REQ0VtWWtaL29aZEVtRFN4YTFyc3dIR0Q1bTAz?=
 =?utf-8?B?eEpFQm9oZlBvNjgyMVpkamc0RUFUWHJUdTNqRGd5cmRVWkZSUzVHZE1VZ3dn?=
 =?utf-8?B?S21Kejc5MnM1b2xZQkpRV050azhFTWJpZ25nNEJ3ejlxWkJqd0NaU2pnZG5z?=
 =?utf-8?B?QVZiZmxZcytXdTVvVXoyaTB4MFYzNWkwS09Zdyt0U3d0VFZacmIrZEVzektC?=
 =?utf-8?B?SnRyR2p2anltQ2xEUWsvT0I0bThMbTBPYi9ycXYvRnBIbzVJNERqT0JYbXNl?=
 =?utf-8?B?RUNsOVpLSE1GbDAxS0l0REtRN05XSXZEMk4veFloQkVSL0NMKzZkU00xb00y?=
 =?utf-8?B?QU5Dd202ZEJjbFpiUTcrWVp5cmNoUFNtb0t2MFI0S1dHSjkrY3ZnNVZQS0wy?=
 =?utf-8?B?bGpWNmE3NUhPSHJybG9BVms5dFRTUGdlYmNnZGRrb2lON3gxVVpaRzdqQllS?=
 =?utf-8?B?cWVLY2k2ZTZyMWwydVp5U01mZnROY3BwTjh1V05GQkRkOERNS01xa1R5U2gv?=
 =?utf-8?B?ZXl2MnUzUWhXV05KZU5rakloSzkwaXdiV2tiRmpYakJ1MWUwTUN4RWJSbEp5?=
 =?utf-8?B?YjMvUGZZeVVtcTV5bXlVc2ZJQTJicUg0NEpFVkppaU5ZaTAvWG5Qb252Qngx?=
 =?utf-8?B?bUM2UnJSdDJCNldURTRRUUlLb09RMmh3MTdwNHZtSXV0c1V6dEJ1cHpENVZQ?=
 =?utf-8?B?dTJSMlkxY0QrQU1vQ29rU093eDFkZW95TzVkR1ZoR1RscXpKTm5SNWMvSDFR?=
 =?utf-8?B?SHQzNVlRbncxNGQ4dm5zYTY4QkY3WHBBSkRaSWpXbzljRklSV3lMU3Q1T3Vl?=
 =?utf-8?B?SGt0ZnlsQXdGTjYxOXp4TzI1bWdnSUtrd0ZJZlhQZFhsdUxCbnFaSEplRHQ3?=
 =?utf-8?B?Y2g1ZGlWUzdhdEdEazduTUowaWVla2labnZ2S1dzcmNWQmNvQlA5Mmc4ZjFI?=
 =?utf-8?B?cjZMQ1QrOU9heloxODhMU2s0U3NvNi9jOHBXc0g5bE9vRytLZzA4SlREbUNi?=
 =?utf-8?B?b2NnSEFLVWd4ZVdqQzVzZzFGSWY2UERMN3FKWHo2ajFvQUpFSWJaUnRwZFpS?=
 =?utf-8?B?VjFOWXhTK2NQeC8ydEM5NFZ2Zjl3aWVLZzRpZUsyQ0NnV3hnR2hubVY4ZGdR?=
 =?utf-8?B?UHZIby9mWmxCaHJSWjBuczBXM2J4UU5tTmUwdDBDV0hQOWZZUnA1WDcrRmtp?=
 =?utf-8?B?T0Y5a1BjaGpvMk9Ec1ZIWUVTYi9iN29uUlU0ZmlQWHJpMUNEd0t1NlJ4SXVn?=
 =?utf-8?B?NXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mw1U8Vi5hvp6GBmITKwqVw4l1GupxBUUl925dovA5feM01bC2WBdG1by/PmV07hglHjQoBXQ2mdaJ78T1zv54hCTbotJhC16GHdw6hSskFVk5o2gEEkm7iaHstCcZ6BkiAS7eSAotX7w/SUiou0UOQOW8V7lR4YZnNn/SYETyGGGI8Z3CzmQ9gEY6k5h2WXHm3IO+Gc+wu0ApXffzEy3P6Q5JcNv2jqTxCwJn+QtoVKtnoNb+tVYa3dFyh+Fv7YjC1W5+d2/WI95Zb+2OFYVB7tDg8vhJjfTHF/wAXjgTG1tZb3z9XC1jT3QvS3Dkq7Xj4hApyGmvVwzsZZwHZzxGzrKDgiIAKFqUU2Ton1RBiy8FKrBkmqjzu5jGAF5BeZxux8hTCfc3tRIJ3B8v5wAzUtrOqq6PpqsFrthJ+IKjrCRCLQnSJn2PVJVzY2EfQGSfMTu9vSPYpUwTT9r5oydzac7xhp69HxY/jQm2OzyeRU7Ihw+GgpGmq1JxCy5bKLneCoCILYGFPVkl2UFM2vM0rcwWUH5hdJdts0idDoyGMjX1MGdx5alIInxP4Evr5VbB4loXA+cc+zJQ+hZM6VwtWNLqRv+auk4oGYo9mHwOE4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b8f84bf-a337-48dd-8a15-08dde0d9f81d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5151.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 17:41:33.4298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p30SZ7HRr4qkKBmHsjDmzOJIyd1b/CwRx6mb67w7KA/n148q5AQy8xY2D1k1yT3+YP3D1ZNDY5+gISmb6PgvdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4631
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_03,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508210145
X-Proofpoint-GUID: DKqHhcpPY-vrS6S9aDlpR1ZpYDZZRub5
X-Authority-Analysis: v=2.4 cv=FY1uBJ+6 c=1 sm=1 tr=0 ts=68a75a52 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=2OwXVqhp2XgA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=P-IC7800AAAA:8 a=84BadPHTAAAA:8
 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=u3Six1AtHcnl-GWPEUgA:9 a=lqcHg5cX4UMA:10
 a=QEXdDO2ut3YA:10 a=vwMYVcWcsEq4uhmHwb4A:9 a=FfaGCDsud1wA:10
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: DKqHhcpPY-vrS6S9aDlpR1ZpYDZZRub5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDE5NyBTYWx0ZWRfXzpklG8sio0A5
 q49wQ3wF/PeOuAMplb4SC7/J+xhmGwk/qjLvvKFjKpr3r6k8kK5cFyJp7xvkCjy3LSSIBlxiFFK
 LhFG/kU4Hm1s9iWzYEje3eiohV4TvQbBjLre2/sVFJtbLEsNtkyVRhKqxO3G+2hruskf1EaCjDT
 rsUNQIeqAugIkmQdxsHuZOUtBkH8rw8jwqE6/BqNYOgz2b1PBoCLw7n+0hVxA+yMbQDTpKuqJ2X
 02Qy13k1hjOIg5bkcDwkeGDRHcegXPgQDGpQSHHZ/OIAhXa3UdnKwrjp6uQYiABXqBallUBsAie
 +T6h7hwyP3A+li5RhBUftU9mmwNtnjpv/JE4jWoVBFv0rh/rjOl+W/rp64Pq4+3+ViqJ37ERV3V
 6rIosi23dK0lCszvn3W1HP3+vtf8LA==

--------------0m9TOOBeukegDXK8dI3P3q2i
Content-Type: multipart/mixed; boundary="------------29LpYl3eEktkFZO0nfyMDnO6";
 protected-headers="v1"
From: Calum Mackay <calum.mackay@oracle.com>
To: Frank Filz <ffilzlnx@mindspring.com>, linux-nfs@vger.kernel.org
Cc: Calum Mackay <calum.mackay@oracle.com>,
 'Ofir Vainshtein' <ofirvins@google.com>,
 'Chuck Lever' <chuck.lever@oracle.com>
Message-ID: <2c52fbdc-97b3-4f61-ba59-1377eedc6f13@oracle.com>
Subject: Re: PYNFS LOCK20 Blocking Lock Test Case
References: <01d001dc0ba9$e4cb0080$ae610180$@mindspring.com>
 <44d19311-7644-4f6e-8509-ff7312ba3ad9@oracle.com>
 <009301dc12c1$4f9cb390$eed61ab0$@mindspring.com>
In-Reply-To: <009301dc12c1$4f9cb390$eed61ab0$@mindspring.com>

--------------29LpYl3eEktkFZO0nfyMDnO6
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjEvMDgvMjAyNSA2OjMwIHBtLCBGcmFuayBGaWx6IHdyb3RlOg0KPiBBaCwgSSBzZWUg
dGhlIGxvZ2ljIHRoZSB0ZXN0IGNhc2UgaXMgZXhwZWN0aW5nLg0KPiANCj4gRm9yIEdhbmVz
aGEsIHdlIG1haW50YWluIHRoZSBibG9ja2luZyBsb2NrIHNvIGxvbmcgYXMgdGhlIGNsaWVu
dGlkIGlzIGJlaW5nIHJlbmV3ZWQsIHNvIHdlIGRvbid0IHN0YXJ0IHRoZSB0aW1lciBmb3Ig
Y2xhaW1pbmcgdGhlIGxvY2sgdW50aWwgdGhlIGxvY2sgYmVjb21lcyBhdmFpbGFibGUgd2hp
Y2ggc2VlbXMgdG8gYmUgYWxsb3dlZCBwZXIgdGhlIFJGQy4gTWF5YmUgd2UganVzdCBuZWVk
IHRvIG5vdCBydW4gdGhhdCB0ZXN0IGNhc2UuDQo+IA0KPiBCdXQgaXQgd291bGQgYmUgbmlj
ZSB0byBoYXZlIGEgc2ltaWxhciB0ZXN0IGNhc2UgdGhhdCBqdXN0IHRha2VzIHRvbyBsb25n
IGFmdGVyIHRoZSBsb2NrIGlzIGF2YWlsYWJsZSB0byByZXRyeS4NCg0KVGhhbmtzIEZyYW5r
OyBDaHVjayBhbHNvIG1hZGUgYSBzaW1pbGFyIHN1Z2dlc3Rpb24gdG8gbWUgcHJpdmF0ZWx5
LiBJJ2xsIA0KaGF2ZSBhIGxvb2sgYXQgZWl0aGVyIGFkanVzdGluZyB0aGlzIHRlc3QgdG8g
cmVwb3J0IGluZm9ybWF0aW9uIHRoYXQgdGhlIA0KbG9jayB3YXMgb2J0YWluZWQgImVhcmx5
IiwgYW5kL29yIGEgc2VwYXJhdGUvb3B0aW9uYWwgdGVzdCB0aGF0IG1vcmUgDQpjbG9zZWx5
IG1hdGNoZXMgdGhlIFJGQyB3b3JkaW5nLCByZWdhcmRsZXNzIG9mIGhvdyB0aGUgc2VydmVy
IG1pZ2h0IGJlaGF2ZS4NCg0KT2YgY291cnNlLCB0aGUgUkZDIHdvcmRpbmcsIGFuZCBsYWNr
IG9mIG5vbWluYXRpdmUgbGFuZ3VhZ2UsIHN1Z2dlc3RzIA0KdGhpcyBpcyBhbiBpbXBsZW1l
bnRhdGlvbiBjaG9pY2UsIGFuZCB0aHVzIGRpZmZpY3VsdCBmb3IgcHluZnMgdGVzdHMgdG8g
DQphZGp1ZGljYXRlIG9uLg0KDQp0aGFua3MsDQpjYWx1bS4NCg0KPiANCj4gUGFydCBvZiB0
aGUgY2hhbGxlbmdlIGlzIHdlIHNoYXJlIGEgbG90IG9mIGxvZ2ljIGJldHdlZW4gNC4wIGFu
ZCA0LjEgYW5kIHdpdGggdGhlIGFjdHVhbCBjYWxsYmFjayBpbiA0LjEsIHRoZXJlIGlzIG5v
IGV4cGVjdGF0aW9uIG9mIHRoZSBjbGllbnQgcG9sbGluZyBmb3IgdGhlIGxvY2suDQo+IA0K
PiBMZXQgbWUgbXVsbCB0aGlzIG9uZSBvdmVyIG1vcmUuDQo+IA0KPiBUaGFua3MNCj4gDQo+
IEZyYW5rDQo+IA0KPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4+IEZyb206IENh
bHVtIE1hY2theSBbbWFpbHRvOmNhbHVtLm1hY2theUBvcmFjbGUuY29tXQ0KPj4gU2VudDog
V2VkbmVzZGF5LCBBdWd1c3QgMTMsIDIwMjUgNjozMCBQTQ0KPj4gVG86IEZyYW5rIEZpbHog
PGZmaWx6bG54QG1pbmRzcHJpbmcuY29tPjsgbGludXgtbmZzQHZnZXIua2VybmVsLm9yZw0K
Pj4gQ2M6IENhbHVtIE1hY2theSA8Y2FsdW0ubWFja2F5QG9yYWNsZS5jb20+OyAnT2ZpciBW
YWluc2h0ZWluJw0KPj4gPG9maXJ2aW5zQGdvb2dsZS5jb20+OyBDaHVjayBMZXZlciA8Y2h1
Y2subGV2ZXJAb3JhY2xlLmNvbT4NCj4+IFN1YmplY3Q6IFJlOiBQWU5GUyBMT0NLMjAgQmxv
Y2tpbmcgTG9jayBUZXN0IENhc2UNCj4+DQo+PiBPbiAxMi8wOC8yMDI1IDU6NTUgcG0sIEZy
YW5rIEZpbHogd3JvdGU6DQo+Pj4gSSBiZWxpZXZlIHRoaXMgdGVzdCBjYXNlIGlzIHdyb25n
LCByZWxldmFudCB0ZXh0IGZyb20gUkZDOg0KPj4+DQo+Pj4gU29tZSBjbGllbnRzIHJlcXVp
cmUgdGhlIHN1cHBvcnQgb2YgYmxvY2tpbmcgbG9ja3MuIFRoZSBORlN2NCBwcm90b2NvbA0K
Pj4+IG11c3Qgbm90IHJlbHkgb24gYSBjYWxsYmFjayBtZWNoYW5pc20gYW5kIHRoZXJlZm9y
ZSBpcyB1bmFibGUgdG8NCj4+PiBub3RpZnkgYSBjbGllbnQgd2hlbiBhIHByZXZpb3VzbHkg
ZGVuaWVkIGxvY2sgaGFzIGJlZW4gZ3JhbnRlZC4NCj4+PiBDbGllbnRzIGhhdmUgbm8gY2hv
aWNlIGJ1dCB0byBjb250aW51YWxseSBwb2xsIGZvciB0aGUgbG9jay4gVGhpcw0KPj4+IHBy
ZXNlbnRzIGEgZmFpcm5lc3MgcHJvYmxlbS4gVHdvIG5ldyBsb2NrIHR5cGVzIGFyZSBhZGRl
ZCwgUkVBRFcgYW5kDQo+Pj4gV1JJVEVXLCBhbmQgYXJlIHVzZWQgdG8gaW5kaWNhdGUgdG8g
dGhlIHNlcnZlciB0aGF0IHRoZSBjbGllbnQgaXMNCj4+PiByZXF1ZXN0aW5nIGEgYmxvY2tp
bmcgbG9jay4gVGhlIHNlcnZlciBzaG91bGQgbWFpbnRhaW4gYW4gb3JkZXJlZCBsaXN0DQo+
Pj4gb2YgcGVuZGluZyBibG9ja2luZyBsb2Nrcy4gV2hlbiB0aGUgY29uZmxpY3RpbmcgbG9j
ayBpcyByZWxlYXNlZCwgdGhlDQo+Pj4gc2VydmVyIG1heSB3YWl0IHRoZSBsZWFzZSBwZXJp
b2QgZm9yIHRoZSBmaXJzdCB3YWl0aW5nIGNsaWVudCB0bw0KPj4+IHJlLXJlcXVlc3QgdGhl
IGxvY2suIEFmdGVyIHRoZSBsZWFzZSBwZXJpb2QgZXhwaXJlcywgdGhlIG5leHQgd2FpdGlu
Zw0KPj4+IGNsaWVudCByZXF1ZXN0IGlzIGFsbG93ZWQgdGhlIGxvY2suDQo+Pj4NCj4+PiBU
ZXN0IGNhc2U6DQo+Pj4NCj4+PiAgICAgICAjIFN0YW5kYXJkIG93bmVyIG9wZW5zIGFuZCBs
b2NrcyBhIGZpbGUNCj4+PiAgICAgICBmaDEsIHN0YXRlaWQxID0gYy5jcmVhdGVfY29uZmly
bSh0LndvcmQoKSwNCj4+IGRlbnk9T1BFTjRfU0hBUkVfREVOWV9OT05FKQ0KPj4+ICAgICAg
IHJlczEgPSBjLmxvY2tfZmlsZSh0LndvcmQoKSwgZmgxLCBzdGF0ZWlkMSwgdHlwZT1XUklU
RV9MVCkNCj4+PiAgICAgICBjaGVjayhyZXMxLCBtc2c9IkxvY2tpbmcgZmlsZSAlcyIgJSB0
LndvcmQoKSkNCj4+PiAgICAgICAjIFNlY29uZCBvd25lciBpcyBkZW5pZWQgYSBibG9ja2lu
ZyBsb2NrDQo+Pj4gICAgICAgZmlsZSA9IGMuaG9tZWRpciArIFt0LndvcmQoKV0NCj4+PiAg
ICAgICBmaDIsIHN0YXRlaWQyID0gYy5vcGVuX2NvbmZpcm0oYiJvd25lcjIiLCBmaWxlLA0K
Pj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBhY2Nlc3M9T1BFTjRf
U0hBUkVfQUNDRVNTX0JPVEgsDQo+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIGRlbnk9T1BFTjRfU0hBUkVfREVOWV9OT05FKQ0KPj4+ICAgICAgIHJlczIgPSBj
LmxvY2tfZmlsZShiIm93bmVyMiIsIGZoMiwgc3RhdGVpZDIsDQo+Pj4gICAgICAgICAgICAg
ICAgICAgICAgICAgIHR5cGU9V1JJVEVXX0xULCBsb2Nrb3duZXI9YiJsb2Nrb3duZXIyX0xP
Q0syMCIpDQo+Pj4gICAgICAgY2hlY2socmVzMiwgTkZTNEVSUl9ERU5JRUQsIG1zZz0iQ29u
ZmxpY3RpbmcgbG9jayBvbiAlcyIgJSB0LndvcmQoKSkNCj4+PiAgICAgICBzbGVlcHRpbWUg
PSBjLmdldExlYXNlVGltZSgpIC8vIDINCj4+PiAgICAgICAjIFdhaXQgZm9yIHF1ZXVlZCBs
b2NrIHRvIHRpbWVvdXQNCj4+PiAgICAgICBmb3IgaSBpbiByYW5nZSgzKToNCj4+PiAgICAg
ICAgICAgZW52LnNsZWVwKHNsZWVwdGltZSwgIldhaXRpbmcgZm9yIHF1ZXVlZCBibG9ja2lu
ZyBsb2NrIHRvIHRpbWVvdXQiKQ0KPj4+ICAgICAgICAgICByZXMgPSBjLmNvbXBvdW5kKFtv
cC5yZW5ldyhjLmNsaWVudGlkKV0pDQo+Pj4gICAgICAgICAgIGNoZWNrKHJlcywgW05GUzRf
T0ssIE5GUzRFUlJfQ0JfUEFUSF9ET1dOXSkNCj4+PiAgICAgICAjIFN0YW5kYXJkIG93bmVy
IHJlbGVhc2VzIGxvY2sNCj4+PiAgICAgICByZXMxID0gYy51bmxvY2tfZmlsZSgxLCBmaDEs
IHJlczEubG9ja2lkKQ0KPj4+ICAgICAgIGNoZWNrKHJlczEpDQo+Pj4gICAgICAgIyBUaGly
ZCBvd25lciB0cmllcyB0byBidXR0IGluIGFuZCBzdGVhbCBsb2NrIHNlY29uZCBvd25lciBp
cw0KPj4+IHdhaXRpbmcgZm9yDQo+Pj4gICAgICAgIyBTaG91bGQgd29yaywgc2luY2Ugc2Vj
b25kIG93bmVyIGxldCBoaXMgdHVybiBleHBpcmUNCj4+PiAgICAgICBmaWxlID0gYy5ob21l
ZGlyICsgW3Qud29yZCgpXQ0KPj4+ICAgICAgIGZoMywgc3RhdGVpZDMgPSBjLm9wZW5fY29u
ZmlybShiIm93bmVyMyIsIGZpbGUsDQo+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIGFjY2Vzcz1PUEVONF9TSEFSRV9BQ0NFU1NfQk9USCwNCj4+PiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZGVueT1PUEVONF9TSEFSRV9ERU5ZX05P
TkUpDQo+Pj4gICAgICAgcmVzMyA9IGMubG9ja19maWxlKGIib3duZXIzIiwgZmgzLCBzdGF0
ZWlkMywNCj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgdHlwZT1XUklURVdfTFQsIGxv
Y2tvd25lcj1iImxvY2tvd25lcjNfTE9DSzIwIikNCj4+PiAgICAgICBjaGVjayhyZXMzLCBt
c2c9IkdyYWJiaW5nIGxvY2sgYWZ0ZXIgYW5vdGhlciBvd25lciBsZXQgaGlzICd0dXJuJw0K
Pj4+IGV4cGlyZSIpDQo+Pj4NCj4+PiBOb3RlIHRoYXQgdGhlIFJGQyBpbmRpY2F0ZWQgdGhl
IGNsaWVudCBoYXMgb25lIGxlYXNlIHBlcmlvZCBBRlRFUiB0aGUNCj4+PiBjb25mbGljdGlu
ZyBsb2NrIGlzIHJlbGVhc2VkIHRvIHJldHJ5IHdoaWxlIHRoZSB0ZXN0IGNhc2Ugd2FpdHMg
MS41DQo+Pj4gbGVhc2UgcGVyaW9kIGFmdGVyIHJlcXVlc3RpbmcgdGhlIGJsb2NraW5nIGxv
Y2sgYmVmb3JlIGl0IHJlbGVhc2VzIHRoZQ0KPj4+IGNvbmZsaWN0aW5nIGxvY2suLi4NCj4+
Pg0KPj4+IEFtIEkgcmVhZGluZyB0aGluZ3MgcmlnaHQ/DQo+Pg0KPj4gSSBzZWUgd2hhdCB5
b3UgbWVhbi4NCj4+DQo+PiBCdXQgc2luY2UgYSB3YWl0aW5nIGJsb2NraW5nIGxvY2sgY2xp
ZW50IG9idmlvdXNseSBkb2Vzbid0IGtub3cgd2hlbiB0aGUgbG9jay0NCj4+IGhvbGRpbmcg
Y2xpZW50IGlzIGdvaW5nIHRvIHJlbGVhc2UgaXRzIGxvY2ssIHRoZSB3YWl0aW5nIGNsaWVu
dCBoYXMgdG8gc3RhcnQgcG9sbGluZw0KPj4gcmVndWxhcmx5IGFzIHNvb24gYXMgaXRzIGlu
aXRpYWwgYmxvY2tpbmcgbG9jayByZXF1ZXN0IGlzIGRlbmllZC4gSXQgaGFzIHRvIHBvbGwg
YXQNCj4+IGxlYXN0IG9uY2UgcGVyIGxlYXNlIHBlcmlvZC4NCj4+DQo+PiBJZiB0aGUgc2Vy
dmVyIG5vdGljZXMgdGhhdCBhIHdhaXRpbmcgY2xpZW50IGhhc24ndCBwb2xsZWQgb25jZSBp
biBhIGxlYXNlIHBlcmlvZCwNCj4+IGFmdGVyIGl0cyBpbml0aWFsIGJsb2NraW5nIGxvY2sg
cmVxdWVzdCB3YXMgZGVuaWVkLCB0aGVuIGl0IHNlZW1zIHJlYXNvbmFibGUgZm9yDQo+PiB0
aGUgc2VydmVyIHRvIGZvcmdldCB0aGF0IHdhaXRpbmcgY2xpZW50J3MgaW50ZXJlc3QgaW4g
dGhlIHBlbmRpbmcgbG9jayB0aGVyZSBhbmQNCj4+IHRoZW4uIFRoZXJlJ3Mgbm8gbmVlZCBm
b3IgdGhlIHNlcnZlciB0byB3YWl0IGEgZnVydGhlciBsZWFzZSBwZXJpb2QgYWZ0ZXIgdGhl
IGxvY2sNCj4+IGlzIHJlbGVhc2VkLg0KPj4NCj4+DQo+PiBMb29raW5nIGF0IHRoZSBjdXJy
ZW50IExpbnV4IG5mc2QgY29kZSwgdGhhdCBkb2VzIHNlZW0gdG8gYmUgd2hhdCBpdCBkb2Vz
LiBJIHNlZQ0KPj4gdGhhdCB3aGVuIHRoZSBzZXJ2ZXIgYWRkcyB0aGUgYmxvY2tpbmcgbG9j
ayByZXF1ZXN0IHRvIGl0cyBwZW5kaW5nIGxpc3QsIGl0IGFkZHMgdGhlDQo+PiBjdXJyZW50
IHRpbWVzdGFtcCB0byBpdCwgaS5lLiB0aGUgdGltZSB0aGF0IHRoZSBibG9ja2luZyBsb2Nr
IHdhcyByZXF1ZXN0ZWQuDQo+Pg0KPj4gVGhlIG5mc2QgYmFja2dyb3VuZCBjbGVhbi11cCB0
aHJlYWQgKHdoaWNoIHJ1bnMgYXQgbGVhc3Qgb25jZSBwZXIgbGVhc2UNCj4+IHBlcmlvZCkg
cmVtb3ZlcyBhbnkgcGVuZGluZyBibG9ja2luZyBsb2NrIHJlcXVlc3RzIGlmIGEgbGVhc2Ug
cGVyaW9kIGhhcyBwYXNzZWQNCj4+IHNpbmNlIHRoZXkgd2VyZSBwbGFjZWQgb24gdGhlIGxp
c3QgKGkuZS4gd2hlbiB0aGUgYmxvY2tpbmcgbG9jayB3YXMgcmVxdWVzdGVkKS4NCj4+IFRo
ZXJlJ3MgYSBjb3JyZXNwb25kaW5nIGNvbW1lbnQ6DQo+Pg0KPj4gCS8qDQo+PiAJICogSXQn
cyBwb3NzaWJsZSBmb3IgYSBjbGllbnQgdG8gdHJ5IGFuZCBhY3F1aXJlIGFuIGFscmVhZHkg
aGVsZCBsb2NrDQo+PiAJICogdGhhdCBpcyBiZWluZyBoZWxkIGZvciBhIGxvbmcgdGltZSwg
YW5kIHRoZW4gbG9zZSBpbnRlcmVzdCBpbiBpdC4NCj4+IAkgKiBTbywgd2UgY2xlYW4gb3V0
IGFueSB1bi1yZXZpc2l0ZWQgcmVxdWVzdCBhZnRlciBhIGxlYXNlIHBlcmlvZA0KPj4gCSAq
IHVuZGVyIHRoZSBhc3N1bXB0aW9uIHRoYXQgdGhlIGNsaWVudCBpcyBubyBsb25nZXIgaW50
ZXJlc3RlZC4NCj4+DQo+PiBodHRwczovL2VsaXhpci5ib290bGluLmNvbS9saW51eC92Ni4x
Ni9zb3VyY2UvZnMvbmZzZC9uZnM0c3RhdGUuYyNMNjgyNA0KPj4NCj4+DQo+PiBUaGVyZSdz
IG5vIHBlbmRpbmcgbG9ja3MgYWN0aW9uIHRha2VuIG9uIGxvY2sgcmVsZWFzZS4gVGhlIHRp
bWluZyBpcyBiYXNlZCBzb2xlbHkNCj4+IG9uIHdoZW4gdGhlIGJsb2NraW5nIFJFQURXL1dS
SVRFVyByZXF1ZXN0IG9jY3VycmVkLCBpLmUuDQo+PiB0aGUgcmVzMiBXUklURVcgaW4gdGhl
IHB5bmZzIHRlc3QsIHdoaWNoIGlzIGJlZm9yZSB0aGUgc2xlZXAuDQo+Pg0KPj4gU28sIHdo
aWxzdCB0aGUgUkZDIG1heSBzZWVtIHRvIHN1Z2dlc3QgdGhlIHRpbWVyIHNob3VsZCBzdGFy
dCBhdCBsb2NrIHJlbGVhc2UsIGl0DQo+PiBkb2Vzbid0IHNlZW0gdW5yZWFzb25hYmxlIGZv
ciB0aGUgTkZTIHNlcnZlciB0byBzdGFydCB0aGUgdGltZXIgZWFybGllciwgYXQgdGhlDQo+
PiBibG9ja2luZyBsb2NrIHJlcXVlc3QsIHRvIGF2b2lkIGFuIHVubmVjZXNzYXJ5IGRlbGF5
IHVwb24gbG9jayByZWxlYXNlIGlmIHRoZQ0KPj4gY2xpZW50IGhhcyBsb3N0IGludGVyZXN0
IGluIHRoZSBsb2NrLCBpLmUuIGl0IGlzbid0IHBvbGxpbmcuDQo+Pg0KPj4NCj4+IFByZXN1
bWFibHksIHRoZSBweW5mcyB0ZXN0IHdhcyBvcmlnaW5hbGx5IHdyaXR0ZW4gdG8gbWF0Y2gg
TkZTIHNlcnZlciBiZWhhdmlvdXIsDQo+PiByYXRoZXIgdGhhbiBSRkMgd29yZGluZy4gSSdt
IG5vdCBzdXJlIHdoYXQgb3RoZXIgTkZTIHNlcnZlcnMgZG8gaW4gdGhpcyBjYXNlLg0KPj4g
V2FpdGluZyBsb25nZXIgd291bGRuJ3QgY2hhbmdlIHRoZSB0ZXN0IHJlc3VsdCBpbiB0aGlz
IGNhc2UsIEkgdGhpbmsuDQo+Pg0KPj4NCj4+IERvZXMgdGhhdCBzZWVtIHJlYXNvbmFibGUg
dG8geW91Pw0KPj4NCj4+IHRoYW5rcywNCj4+IGNhbHVtLg0KPiANCg0KLS0gDQpDYWx1bSBN
YWNrYXkNCkxpbnV4IEtlcm5lbCBFbmdpbmVlcmluZw0KT3JhY2xlIExpbnV4IGFuZCBWaXJ0
dWFsaXNhdGlvbg0KDQo=

--------------29LpYl3eEktkFZO0nfyMDnO6--

--------------0m9TOOBeukegDXK8dI3P3q2i
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEE1GBbrQYgx8o9Vdw+hSPvAG3BU+IFAminWkQFAwAAAAAACgkQhSPvAG3BU+Ki
0BAAsVLd733A1xV7jmxm8xGKrFJVVQ8uykWP29Ry7VL+nuyCzzHENKvJPd7dyEVRZdyOryakx0vv
8H63XL/xgc2z/bybPjiwCg2dYx+p3P+4s4JW7T3di7qJPQKBLnSI5WONER7qxiR1+sWD8b3t1iJg
d2bGM0kXLr5Alx9bZC/nEWVNK06C5pFzzQymtsPTmEayC9qG/eqM0/EfCIM/RIxwHdFbBL8Y910q
6en7V6r/Kxu7XKnlOuW9layQ9nHCThaS4Askb79Uc52scIcftW1zCNw3epe2VORRY+W2VIoO99W2
wkHPpyFtTIioQQ9Xpvi2WCX7DZcN9SI26xDQ8yHN2Z5x+GdZQk4dfqAptJDofY3vD2p/U2Ll0fZp
hKViQffWnXySYmW/2Vyzgl6uju1fb946Nk991xu3et0OdGURUrB/dDqM4+LCtWVYlOnVoydmX7XB
cvzImgobLUp/GXmqeYIAxS86LcgvG9/lYPbQfI3VCkwLSMwKrYflVMzAL3JGSC4kJmMjPvp2kurz
JOIldFoxQ48y4dpLBtD76BTvCgVPoKDWnPMynnTnnE9npjdJ6JpXwRloqJfYz+P1yv2TTji3Dptl
t7fo0//1BlVDwuyP+V+6RUdbucUn3zspmBcLYHD9q6MtGfLt8/+41cxMCyMt3sdbqfAzYi/IOO8t
YzE=
=/Vib
-----END PGP SIGNATURE-----

--------------0m9TOOBeukegDXK8dI3P3q2i--

