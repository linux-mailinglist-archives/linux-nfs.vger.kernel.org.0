Return-Path: <linux-nfs+bounces-2811-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C11248A51B3
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Apr 2024 15:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4BF71C2284C
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Apr 2024 13:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1342680C03;
	Mon, 15 Apr 2024 13:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ebRD5sPa";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bCzsnOSP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7217F78C81;
	Mon, 15 Apr 2024 13:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713187946; cv=fail; b=lul8LA0ktm2lmP45Y7mhwuInKjPwgWlsVDZJbjpFkjuSnuz5Vwve+EEOaY5Z3BzFURGCG2rlJBovym17OPfyCSK2KbtvGWYok9sx4PuOOanvAuZWLhinugN67HmWI/dUuvnjTLUdHCTaVVl6GxUOaeyppwTXC6M3NiY6V91ONqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713187946; c=relaxed/simple;
	bh=k+Dm/KaM2dkKRoLGbm1Q/CWoSS8M1oH3c2nuOIyX4ec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MAg6AScvuapkZbrrpJyl0O1PLSc4Z//AUx7ZuOV4m8EzrHqzZuEKXHwoDdJG3zBFicoIJVCUNKPsNARInFnRwe1bDUo88o3yxuKVKlTuwnTbYr0MD5q2i1GqCjSaibZZIrQ5LJ2K95SGwKs+LH3jHV80MhKT5pQJFyxWErxYIqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ebRD5sPa; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bCzsnOSP; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43FDI8tI002503;
	Mon, 15 Apr 2024 13:31:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=sdrmXWJG2nBlg7RKpEKJZDBOPmmy3E0yQDuudDCwXTE=;
 b=ebRD5sPa6zPIshqFhbj1iy3vJHJZZ7spT5s7dRw9GZYf3tNg645/uwzinHbIJhgpYAbQ
 2oZcCZnBj0IVDQo7HXHDXJSKbg9nqp0/a6DaoUwhWQAXeyVAaCFHVUMmgUukqMGGF/a4
 Iw6iscy+opthTF+R+LyiNUGf0v22F7/BA9mdSwPAUUdTInhwaauHKabBGnBom2IZC7Wv
 jqLL9+H8KOWpw6GKE6qTeOe1ldi9z3hMIAsGKcQuAPrudycR7G91oftZk1CJ9tBEfZdh
 zOF7HyfXs/TG6TQU/FXyXq48CkUMgBXmzaX2edGBpS02/Wac4kOcDKpiPPaa40ZXH3Cv iw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xfgn2jqnb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Apr 2024 13:31:43 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43FCjqod021631;
	Mon, 15 Apr 2024 13:31:42 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xfggc1pfq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Apr 2024 13:31:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pf3Q4nOGkUbGequ96QToBl0/72iVpK+a4QE8DD5sLdrWg2t5AQjcxTpOuQJMKCLDe49KxsyfD2hdZmarc1+Aq4cOOuVhp7f3g+5q4m7/wBVlua63WyDT77NC/2kYUZxZKuGIjTOXExZ7a4/KjAE4ja5XqUB5ArnYBiopCYMiE1+dDws7gFBRDm81Si8Cn8hOw3LrqGYwypsi75w1eEuDzKpZPyDt++2N6IVgXGJn1Ea9um1uhVEGW4EPNzNh7SYHvOa/Ec90PI45PjBHnnjV8jh4ynfehmJYyW9hgahuqDlgjDojBReO6sY3iV8eeaMP7ULxbepvCNNTfbj2tf1qJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sdrmXWJG2nBlg7RKpEKJZDBOPmmy3E0yQDuudDCwXTE=;
 b=Jia6Rk8WvyXFXcSk+6ZWNIhQtkFBoPDEhrWLA+Go0WGQGXzx1quhntVoKLxEa06Wm/tifnA3Xp1etvG9zjsuDO11HBvBdBDBNGYsqCyNNC8sDhzMh1uthnpXaLLHKl3KqUkKLlVqkS/l7veH7i/EtxMIlMOzYX+nhj0W7oVfkWF9sodQyjQJfGeA2qvZgoGHziDMhqSc1LxZR3RZFRbmfPoKBNJ+BGE5N0g/Y+0JbXrieMSg6Yd+JjTROsp/7GZqXF5KGktKfQAHaRLLUmRYMSf6qhRoW7pS01hs2Am8vXq6+LL8zE/AJs8FNMTFU7qENpmqSzVjGKdSEvHRGvZ/sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sdrmXWJG2nBlg7RKpEKJZDBOPmmy3E0yQDuudDCwXTE=;
 b=bCzsnOSPtdKy97Wj3f0cJfljXZ+aY0/AsReGn8Vml5wrCMS+8H9AmU5WVtVOfSDVap1NK9PI+5sKY0qoYNrPeJi1DJ8q9MoDcHxnz2MWrRcmFKxaKaSSt4j4f4d9R9aoib3drnCG20aHICnoyPGo9x3NYGhGMywSVgVkmKocp40=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB6602.namprd10.prod.outlook.com (2603:10b6:510:206::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 13:31:39 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.7452.049; Mon, 15 Apr 2024
 13:31:39 +0000
Date: Mon, 15 Apr 2024 09:31:35 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        linux-stable <stable@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "patches@kernelci.org" <patches@kernelci.org>,
        "lkft-triage@lists.linaro.org" <lkft-triage@lists.linaro.org>,
        "pavel@denx.de" <pavel@denx.de>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "sudipm.mukherjee@gmail.com" <sudipm.mukherjee@gmail.com>,
        "srw@sladewatkins.net" <srw@sladewatkins.net>,
        "rwarsow@gmx.de" <rwarsow@gmx.de>,
        "conor@kernel.org" <conor@kernel.org>,
        "allen.lkml@gmail.com" <allen.lkml@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        Calum Mackay <calum.mackay@oracle.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Darren Kenny <darren.kenny@oracle.com>,
        Ramanan Govindarajan <ramanan.govindarajan@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 5.15 00/57] 5.15.155-rc1 review
Message-ID: <Zh0sN5aAH+OFsvjz@tissot.1015granger.net>
References: <20240411095407.982258070@linuxfoundation.org>
 <2c2362c7-ace7-4a79-861e-fa435e46ac85@oracle.com>
 <27E1E4C4-86C3-4D78-AF85-50C1612675E0@oracle.com>
 <21c9bcf9-2d44-4ab2-b05c-a1712ac1a434@oracle.com>
 <ZhmYS9ntNbDZvkKE@tissot.1015granger.net>
 <11019956-95c4-4c35-b690-b8515b439eb2@oracle.com>
 <ZhqrH0II0ZJj0dzW@tissot.1015granger.net>
 <2024041402-impeach-charting-60f5@gregkh>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024041402-impeach-charting-60f5@gregkh>
X-ClientProxiedBy: CH0PR13CA0033.namprd13.prod.outlook.com
 (2603:10b6:610:b2::8) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH7PR10MB6602:EE_
X-MS-Office365-Filtering-Correlation-Id: 12b5de57-ddd7-40a8-ce37-08dc5d50614d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	XHzt/Xctz3dOQn76rbpBzsF01QG1X3LXRtj+4hFAv3pF+td4IgaiOlIAEcIA7ySSXmP4l9G2cA/IWAZkVuev4O1BiLu/qmw85hlmJmwGxOau5nkPkFm6kROcp4RSTlE3GSlUzyG46wnGagrjb8vULqHGWP4ZQh7f+Hxw80GlnxdzY/2+YHcmJCA2gFbyHR7KwttV65NY3kfMlcwrBFwGBKq2AhpkGEKEp29PpyXS+P6Cz3yG8HFxC6JYS40utVFoMWKAVM5Bcf7JJcTrTmb4Xc1JDzjwN9lVYHN4xQkJ6VRw/PtDSy2BbSO/7BlTW7kdCIFJ9TRucYgNVmmEKH4TDU6tU/jUn4KEf5kOui7fJzKF5n9UOL1KFpSdkc2mlbAvENWi3QSvmiXZMr2I+tza1IXagoClYSZY3nVdF4AbUNhAtD0DnofHcLdiZIyh7XWY3gfUtTuIXszOdzFpYlgRfwVUch3eQbh0lWo3nKb/pYKt5Jx1BaNOdhJ7eWv87Kx7zhgu1ZB9yLLl4vTi8lVY9wn2/7jLv7RkSA7bndP/vpUFiFuwPXI4lO6hh0+/695hBaQnQ3WOITSdmuyawaEH9VRv9IwkEiJMl/KKdRrh5B8AugWZUI8Aw1q3vVMdZe42UOqcDqLQWCcXAsnfrNhsSa0ILNWa4WKONtHV3Td69m8=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?lhkz+COdbL5c80LjLg/UQgxENE2EoNynmPPp06q3sNebTnTx3cKM7smEm8AV?=
 =?us-ascii?Q?TzlbgztycrEG3yu4dH465HfmEv1hq2GeBz6LcwYukLq/qdxw6k++zyCSooFK?=
 =?us-ascii?Q?iBr3jaelIaY8t+Qexf1y/tC30Oz49N148/hGc4F+YpIq6pDseGt66i4Q1b/r?=
 =?us-ascii?Q?CXpRI8/+GIlfGTpo+ObhQ6RI79fmGlSt8qOtml3T9YtxK7ZjFCvFffohBetv?=
 =?us-ascii?Q?smvlw93l+8rs0J9nGt5pb0rPK+Av5R1SKfuU9LwYpZxoXO1TJVcGOcL3jj1/?=
 =?us-ascii?Q?YK3GAJg/yvLdS8GrjpW3eJOhD8peKHHo6T5ykjRf5gBtp58mzWtsTE+VBX1R?=
 =?us-ascii?Q?TRorujTQlMhSFfngXJ2NHTF27nNhfhYB/olt8zSbuBRnvDi/kao5SYZaC39k?=
 =?us-ascii?Q?vyN6GhIFr8iYnfmvKghYMJBnINwhZru4PqWvRFRFTWwhGGA6zqvhV1smvFfO?=
 =?us-ascii?Q?BzULDSLxTLqyQCcyEfR1trGVUppuR45hneK0cT48BCcl/4I1Ucp5Urj/LMxA?=
 =?us-ascii?Q?VGXEEp7HmHj6aDKqvl/UTijC+SEfPaLbfsR3+Fi1A3EK++YWrLQIQ1WyNesu?=
 =?us-ascii?Q?549XCIGhENPCtUnHMvdqXbOhH2zE0+zYeoiCz0BZw5JBvWyV+C7GFu2istCG?=
 =?us-ascii?Q?7fEpfqpkX0/XhYZ4KFMe4klWzZcQTHcsZ5mTfuijXbHcxtWBX0rocLTAOIVd?=
 =?us-ascii?Q?EV91h/4Sa/+v0KyaU9buduPAeHguxKeJ8WBYxRda06S1JjU+piBS/xLAlAhG?=
 =?us-ascii?Q?M4HfcOlN5VZB9Ne53P5EwBvBCno3/wAx8kUHpfirCxPObZGTddEWWJaj+2hc?=
 =?us-ascii?Q?2varItAQiiPZybpm2mtrm4CDPYYiaJV2wuJm1Seg8+66TxvzYKomO3S3dtTf?=
 =?us-ascii?Q?j4xkmae/Zb6LvU7syMrqAe2dE8wCL7ITPOQonetYB+dg05dcXF9b/ErBMjW7?=
 =?us-ascii?Q?cpVvn+IyfrW9ic5k9ZjMjyBN01MT+325m4WQ4D+Q0pl85Il4xW1E+UDPNli4?=
 =?us-ascii?Q?K570PxExF8slyyI00PNBDxx3fw6wmVseLCtSzwkmgKNvnPf3o+ypKttNYoo2?=
 =?us-ascii?Q?lx+6hX1zUuuq2Xc+mhaTMaq3oYYDQCbsfSAyZkvF0PWk1xkWqCvsk0vaVfat?=
 =?us-ascii?Q?ZjQzvUGEDM7wvzJAvnDqZLdWhtDgMPeSP392ZlKAfigK5S9fOpMXhMdxWfkd?=
 =?us-ascii?Q?tSz2/Nz7JJiyI40Fk3gosPNNCOATnQWdpKriJeSBwzFHDHBlTUUdiXvAgMzB?=
 =?us-ascii?Q?iKvd6aGQrdwlmE4kd7F8Wspjw6mKkWCutuB+knhp9noBYNgJZy2LIXDMS4K+?=
 =?us-ascii?Q?+XrsXAQ6m0gaLnxSIuJMDIvxa2Fo3bP9xQCaPlwXFUxNm1EyjbFJr+nZorYW?=
 =?us-ascii?Q?HOz9PXpLe6TX8gE23/vtn+k3XlhGFolwZg2L/uNkITP5ICOwKKPTqkvhi5jW?=
 =?us-ascii?Q?XjjLRxlV/1GwR+yuryOcZEPkhslOjcWZA9Q8CTLAMS4gg3NGspyP586RyZlS?=
 =?us-ascii?Q?xFhihZy0h7hUAqggaJGlTWtrGQtHuSt9MAzFNJ8rP7bgpG1wLbOxxSq38Yp2?=
 =?us-ascii?Q?wsZMXvsV4t0Sas2Hg8NaO4hnnvK57kG+iyZpRWQDvVJN5mL6AODqZSavFGNW?=
 =?us-ascii?Q?YA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	6rRNmnR6LND4GtifKdCr9AZ9zhZR57U4OShmkg0qWpkBZtRsn/jrlaj3+GLcJbBDxEVuCrhIHWVekm844RR+qXLk6jAVCekgOJ7UxfGuAjX9capdBn2qeR7c3lx0wtgLWebluOfe81930I/uN1ZULQ1+opEHBfpGdQ8gAx/29MW2H5Opndr12w0b9c+6/CXTdHtmtQFrOGCEtB3uiQr7k8R5bBjN959DEhlLzU/Z5stw8t98CSmG9Pp3pV+dhgTb9+ZmtWG/32YRlyv4M+kzfTVZu2hLWG+YlfiJpj5LazfN6HcC+Xzis6du/LlRfY91xHEHuHrxk9v56qc+ei7k9z8dn8ifF96NBdYqrCtN420QIm9EyZUTG2N9WK1ZYlcuvWgp/GbUWvfxm2h80f5BJbk0UiMrL4tGFMmRNsX34PodLTWgHbSbUy3phuKAMvPJq9NiJPCxh5oBsSbaUvV4iSMtEwEvAeODiu2VT4jZ2Y5LuV/1eTlR3Nagij7NZ3ryK5r+ALGIlVyBgQjbmz+vs1tfl29zvz4bOyUkLIGPEnYRP2ecWruvSPpP6SKi1KPtWvOhR1GJH6SVmkY2sfvQ9cTowcTn+bnCfKXntZ4QmiA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12b5de57-ddd7-40a8-ce37-08dc5d50614d
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 13:31:39.2805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F1doP3dblQQmqgGMO1xtTtJSXnFhidfVyf0EI6QFIHz1KXOmA5PqEW68VVYNYb44U+Opf+J8ZTSrF576W+B/DQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6602
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-15_11,2024-04-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404150088
X-Proofpoint-ORIG-GUID: 3dbQdtU2Xq-tDhsVDC0FiRT6vJoI2MqV
X-Proofpoint-GUID: 3dbQdtU2Xq-tDhsVDC0FiRT6vJoI2MqV

On Sun, Apr 14, 2024 at 08:13:32AM +0200, Greg Kroah-Hartman wrote:
> On Sat, Apr 13, 2024 at 11:56:15AM -0400, Chuck Lever wrote:
> > On Sat, Apr 13, 2024 at 03:04:19AM +0530, Harshit Mogalapalli wrote:
> > > Hi Chuck and Greg,
> > > 
> > > On 13/04/24 01:53, Chuck Lever wrote:
> > > > On Sat, Apr 13, 2024 at 01:41:52AM +0530, Harshit Mogalapalli wrote:
> > > > > # first bad commit: [2267b2e84593bd3d61a1188e68fba06307fa9dab] lockd:
> > > > > introduce safe async lock op
> > > > > 
> > > > > 
> > > > > Hope the above might help.
> > > > 
> > > > Nice work. Thanks!
> > > > 
> > > > 
> > > > > I didnot test the revert of culprit commit on top of 5.15.154 yet.
> > > > 
> > > > Please try reverting that one -- it's very close to the top so one
> > > > or two others might need to be pulled off as well.
> > > > 
> > > 
> > > I have reverted the bad commit: 2267b2e84593 ("lockd: introduce safe async
> > > lock op") and the test passes.
> > > 
> > > Note: Its reverts cleanly on 5.15.154
> > 
> > Harshit also informs me that "lockd: introduce safe async lock op"
> > is not applied to v6.1, so it's not likely necessary to include here
> > and can be safely reverted from v5.15.y.
> 
> Chuck, can you send a series of reverts for what needs to be done here
> as these were your original backports?

Testing now, I'll send the patch in a day or two.


-- 
Chuck Lever

