Return-Path: <linux-nfs+bounces-2349-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E89487D738
	for <lists+linux-nfs@lfdr.de>; Sat, 16 Mar 2024 00:11:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69127284D9B
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Mar 2024 23:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC9E5A0F2;
	Fri, 15 Mar 2024 23:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="Z8niBzB6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from rcdn-iport-7.cisco.com (rcdn-iport-7.cisco.com [173.37.86.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF645A0E8;
	Fri, 15 Mar 2024 23:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=173.37.86.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710544240; cv=fail; b=W+BkchC/xjW9JJvT4k3eN1DBRQWkSAQSDIBdsV26R3NF/Oikaulj+9fDyebbBSeRFgLjzxQ1fU8qWy1s1hGQydpJVyiUiuAOSj+1EFaw/xOlCu2We5XMmt2o67gXvE4nUjjVsTo0f1gC0KLk1xu5XoIDONh7n8rc0poPf882uIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710544240; c=relaxed/simple;
	bh=ZAndzCLUTgBe41rhHShEPD6+ODi3t/TMbt/4ZbvN1NQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=G3m1cLVCkLuw6DFLEsimdfZs8cqyWLrVjlMl9esmFr1nske66Xjcemrv+MtxO+uZIuv8lN68AT+8/BZyNCdz4xjyEp045DvJxVL4xsR1Ix1fDjOpESCvh0rKON2iuND/VCALp1hCxIoJyqgUxBApdKw3Nq9EJuoPnKpURLCdXuc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=Z8niBzB6; arc=fail smtp.client-ip=173.37.86.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=1552; q=dns/txt; s=iport;
  t=1710544237; x=1711753837;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ZAndzCLUTgBe41rhHShEPD6+ODi3t/TMbt/4ZbvN1NQ=;
  b=Z8niBzB6yaIIHvRPfV/JaawH5aQqRAMBdGs2PA4jR55fva6Vh1RR6w6b
   O7gujV0zmFTuTPxY/0pzD5UN1iqQuIzKsIMpgIiz4ZeEsG0xmEULhEAWn
   25EUmDTqkNFQVGarPSyYkvtvHqUNGanhy5DPThfWLMYTT6reEQnhiFAk9
   8=;
X-CSE-ConnectionGUID: LzdA3W3GReOF7jP9vTGrVw==
X-CSE-MsgGUID: Vl4vznVqTIORuB+vEzpfsw==
X-IPAS-Result: =?us-ascii?q?A0ATAACM1PRlmJNdJa1aHQEBAQEJARIBBQUBQCWBFggBC?=
 =?us-ascii?q?wGBZlJ6AoEXiGgDhE5fiE4dA4V6jGeLJoF+DwEBAQ0BATsJBAEBhQYCiAECJ?=
 =?us-ascii?q?jQJDgECBAEBAQEDAgMBAQEBAQEBAQYBAQUBAQECAQcFFAEBAQEBAQEBHhkFD?=
 =?us-ascii?q?hAnhWwNhk8BAQEDEig/EAIBCA4KHhAQISUCBA4OGYJeAYJfAwEQp0ABgUACi?=
 =?us-ascii?q?ih4gTSBAYIWBbMBGIEwAYglAYoxJxuBSUSBFYMqPoJhBIE1ERiGQwSFToNtk?=
 =?us-ascii?q?kmHbFR/HAOBBQRaDRsQHjcREBMNAwhuHQIxOgMFAwQyChIMCx8FEkIDQwZJC?=
 =?us-ascii?q?wMCGgUDAwSBLgUNGgIQGgYMJgMDEkkCEBQDGx0DAwYDCjEwgRYMUANkHzIJP?=
 =?us-ascii?q?A8MGgIvDSQjAixKChACFgMdGjARCQsmAyoGNgISDAYGBl0gFgkEJQMIBANSA?=
 =?us-ascii?q?yByEQMEGgQLBzo+ggKBPQQTR4FEhTiCJYJFDIM2KoFOKYERgR0DRB1AA3g9N?=
 =?us-ascii?q?RQbBiIBoz4BhBNHCQFiE2cPAg0tkxSyFwqEEpM8jkuqG4NShzKNW6hTAgQCB?=
 =?us-ascii?q?AUCDgEBBoFkOoFbcBWDIwhJGQ+OOYh1imWBMwIHCwEBAwmIboF6AQE?=
IronPort-PHdr: A9a23:44yz3xfWicsNd6OG88uZTeGUlGM/eYqcDmcuAtIPkblCdOGk55v9e
 RCZ7vR2h1iPVoLeuLpIiOvT5rjpQndIoY2Av3YLbIFWWlcbhN8XkQ0tDI/NCUDyIPPwKS1vN
 M9DT1RiuXq8NBsdA97wMmXbuWb69jsOAlP6PAtxKP7yH9vehsK22uSt8rXYYh5Dg3y2ZrYhZ
 BmzpB/a49EfmpAqar5k0BbLr3BUM+hX3jZuIlSe3l7ws8yx55VktS9Xvpoc
IronPort-Data: A9a23:4ZaMb6guPATeHFs3GoWGk66WX161ehAKZh0ujC45NGQN5FlHY01je
 htvCGuFbPmLZjOmLY8jb9uy9h9Q6pDUx4M2SFc6rCxmQitjpJueD7x1DKtf0wB+jyHnZBg6h
 ynLQoCYdKjYdleF+1H1dOCn9CEgvU2xbuKUIPbePSxsThNTRi4kiBZy88Y0mYcAbeKRW2thg
 vus5ZWAULOZ82QsaD5MsPve8EgHUMna4Vv0gHRvPZing3eG/5UlJMp3Db28KXL+Xr5VEoaSL
 woU5Ojklo9x105F5uKNyt4XQGVTKlLhFVTmZk5tZkSXqkMqShrefUoMHKF0hU9/011llj3qo
 TlHncTYpQwBZsUglAmBOvVVO3kWAEFIxFPICVytveXI8BbpSXbL7apsNBAoAaICxPkiVAmi9
 dRAQNwMRgqIi+Tzy7WhR6w134IoLdLgO8UUvXQIITPxVKl9B8ucBfSRo4YEg1/chegWdRraT
 8YQbztiaAvJSxZOIVwQTpk5mY9Eg1GlK2cA+QjE9fdfD2778ggtzqrrDsPpW/uwWO8WgGuKv
 mzd4DGsav0dHIfCkWXeqC3EavX0tSf6Xp8CUbu27dZ0j1CJgG8eEhsbUR28u/bRolWzX9NZN
 lw85CUjt+4x+VatQ927WAe3yENopTYGUNZWVuY98gzIk/OS6AeCDW9CRTlEADA7iCMobRg42
 nbSoIjGPzFInuKXcSODypiOkyznbED5MlQ+TSMDSAIE5fzqr4cykg/DQ75f/Eid0ISd9dbYn
 WrikcQuu4j/m/LnwElSwLwqqyinqp6MRQkv60COBySu7xhyY8iuYInABbnnARRoctjxorqp5
 SRsdy2iAAYmVszleMulG7tlIV1Rz6zZWAAweHY2d3Xbyxyj+mS4Yadb6yxkKUFiP64sIGCwO
 BKJ5l8OusYMZRNGiJObharsW6zGKoC9RLzYugz8M7Kin7AoLVDXonsyDaJu9zC3wCDAbp3Ty
 b/ALJ7zVixFYUiW5DG3XOwamaQ63TwzwHibRJbwiXyaPUm2OhaopUM+GALWNIgRtfrcyC2Mq
 oo3H5XRkX13DrahChQ7BKZOdzjm21BhW8CvwyGWH8beSjdb9JYJV6WNnepwItI490mX/8+Rl
 kyAtoZj4AOXrVXMKB6BbTZob7aHYHq1hShT0fAEVbpw50UeXA==
IronPort-HdrOrdr: A9a23:H+JGW69FUR18Uh0lWbduk+Gkdr1zdoMgy1knxilNoENuA6+lfp
 GV/MjziyWUtN9IYgBfpTnhAsW9qXO1z+8S3WGIVY3SEjUOy1HYXb2KirGSggEIeheOudK1up
 0QCZSWZOeAaWSSyPyKnzVQcOxQgOVvkprY+Ns2pk0FJWoFGsMQijuRSDzrbnGeLzM2fKbRYa
 Dsnfav0ADQAUj/AP7LYUXtdtKz1OHjpdbNWzJDLRgh7wWFkDOv75DHMzXw5H0jegIK640PtU
 zenSLExojLiZyGIxnnuFP73tBzop/M29FDDMuDhow+MTP3kDulY4xnRvmroC01iPvH0idprP
 D85zMbe+hj4XLYeW+45TH33RP77Too43j+jXeFnHrYp9DjTj5SMbsFuWsZSGqc16MThqA77E
 t55RPBi3ORN2KZoM3J3amOa/itrDvunZNtq59Is5UVa/pvVFYYl/1swKoSKuZCIMo/g7pXTN
 WHy6rnlatrWELfYHbDsmZ1xtuwGnw1AxedW0AH/teYyj5MgRlCvgElLeEk7z89HagGOtJ5zv
 WBNr4tmKBFT8cQY644DOAdQdGvAmiIRR7XKmqdLVnuCalCYhv22tLKyaRw4PvvdI0DzZM0lp
 iEWFREtXQqc0arDcGVxpVE/h3EXW34VzXwzcNV4YR/p9THNffWGDzGTEprn9qrov0ZDMGeU/
 GvOIhOC/umNmfqEZYh5Xy2Z3CTEwhpbCQ4gKdNZ7vVmLO/FmTDjJ2uTMru
X-Talos-CUID: 9a23:WYp9pW42xVt6ZYECvdss0FwYM5saKVLnwVD+fE2AWHhVZ6erVgrF
X-Talos-MUID: 9a23:QFgNMgQpmThA8iWPRXTSgG18JsFW+piPL3oQu9YYltucOzdvbmI=
X-IronPort-Anti-Spam-Filtered: true
Received: from rcdn-core-11.cisco.com ([173.37.93.147])
  by rcdn-iport-7.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2024 23:09:27 +0000
Received: from rcdn-opgw-4.cisco.com (rcdn-opgw-4.cisco.com [72.163.7.165])
	by rcdn-core-11.cisco.com (8.15.2/8.15.2) with ESMTPS id 42FN9RC2022571
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Mar 2024 23:09:27 GMT
X-CSE-ConnectionGUID: DPqlFYVQTMCsvh2b/R7fkw==
X-CSE-MsgGUID: 8bfaeGirSxWIjURtn3G82Q==
Authentication-Results: rcdn-opgw-4.cisco.com; dkim=pass (signature verified) header.i=@cisco.com; spf=Pass smtp.mailfrom=danielwa@cisco.com; dmarc=pass (p=reject dis=none) d=cisco.com
X-IronPort-AV: E=Sophos;i="6.07,129,1708387200"; 
   d="scan'208";a="30832999"
Received: from mail-bn8nam12lp2169.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.169])
  by rcdn-opgw-4.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2024 23:09:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WHqVnPFRKxZUBkb4N0aJv42UhxF/RK5A4McNbNfrTqRBNPMwux81BpNcEtr3+DNCgR4pvM/aHZVLhkr5vnlgEK+nsL9I+qMU42MHaUJC4d6lyb3vI+bAovsJLr7EBQDhS5v1BccEjNVEwucxiyuOJxK/14LaKVfqCAbOpwLTEFGWZ2cmKKQs9AGvMliegv8MOwbq0ZCbGPXI4ZXCaEvPuOX18i9W54cp1LEjkMWNMWFoj4XGaCKOxdG1SetPdsPO5pJcHmY5NY2Kmx2c3Q8I+bADlyya7R1UUwsjIIoUWohkdDd8NKd9stbrPei/J6TMvkS08xnHpmb2OA2NMcrg+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZAndzCLUTgBe41rhHShEPD6+ODi3t/TMbt/4ZbvN1NQ=;
 b=HrWCN1/fCXGjVl3c3AR5C0/Xqm8S4rY/XS4cpmLpIyDHe831GaN5zuX7tDkEiOysXxdEjByU+zgOAcg9/3YDDNEGtIQWEoyzJs6a63jcf29lnsK38fiNxb06tVLFpzQhu20FV2k7sMLqtLjRjSRuSo1/02sgc0k1YZYJ4eBTtip6pxj5lDx7RWwJ4/aswUM+1/TLIhHhd5FJMp4yd0Wy7WPsD4CQdF6D7lVHpIM7tduKfdi4NzZ9VCpZrhAn0d5GfmPu/Ps7VtP6jlBkbFL3RPZVO4VyGPRZcJtqxfhbzTgDLH+pnjCvfGRlx9H/QyTVO+PMSdha0Fr/rreKX/k4yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
Received: from SJ0PR11MB5790.namprd11.prod.outlook.com (2603:10b6:a03:422::15)
 by CY5PR11MB6212.namprd11.prod.outlook.com (2603:10b6:930:24::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18; Fri, 15 Mar
 2024 23:09:25 +0000
Received: from SJ0PR11MB5790.namprd11.prod.outlook.com
 ([fe80::22f4:4617:117:7a44]) by SJ0PR11MB5790.namprd11.prod.outlook.com
 ([fe80::22f4:4617:117:7a44%6]) with mapi id 15.20.7386.015; Fri, 15 Mar 2024
 23:09:25 +0000
From: "Daniel Walker (danielwa)" <danielwa@cisco.com>
To: Jeff Layton <jlayton@kernel.org>
CC: "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        "xe-linux-external(mailer list)" <xe-linux-external@cisco.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: nfs client uses different MAC policy or model
Thread-Topic: nfs client uses different MAC policy or model
Thread-Index: AQHadmpPdLuamV23IU6d6aCv68CZjQ==
Date: Fri, 15 Mar 2024 23:09:25 +0000
Message-ID: <ZfTVJZtXghoii8DG@goliath>
References: <ZfONIThp2RIfmu1O@goliath>
 <d4861b0541bac2670e39dc340f110bf72558b703.camel@kernel.org>
In-Reply-To: <d4861b0541bac2670e39dc340f110bf72558b703.camel@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5790:EE_|CY5PR11MB6212:EE_
x-ms-office365-filtering-correlation-id: 93fd8c30-768f-4e2c-ad67-08dc4544f550
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 VBETpk87b4WEq57FsEDkuO4th+kZEmOF9IqkCIBmU3RwaMdH36K8/2XocrBgmumK6W7LZm4HCWhBxWChHqdqqp6gZJD9P53RjsjmYujGlMIjo2IScBISArtf7fvyG+wN5fCbPWZhB8o82r8FcAufnwryJ+aTQNannoIdnKym/zeWeLhRGnHR9XORrIEXbng1ZiQGGXfd6o93FJ0w2qjZ0IMFD+p4Gl+IKD/NVhREhuZKSgRtrdmc3D1lIk53lJpEbBliC66pFDGGsf/iC9+M57QYB/lRFqgFvGjZ3hpYH4aJXHGIyCYrL3TC2zc4d3oengQfBQR7M7iijs7V2Mq3qW9O6scstJGDxKY2WVIPX3W2QEpzlb+XhTJGFK91vAv6/cXJBu9Bq+5pHLQs4tqLog+ICQ6XTsuOjZ171OJ0muhOg7zlv3Z/avBuzLvJKshoiFDNBXcp7ByihwvbbyN282dtr2RYkt8HFN8u7zT8TWrILJpNz0NkbTVp0p8QcFgKr5lnBsFXaITrnMmFxOkvJObZFF96HfI4hIL4Q2jurt6NmVHOWWxvMcKqueLRrPR4zUjlRQDMZfmIp9B/L3hRpqjW6NsjXY1gcjUgKQwFZe6SecNMm5SqVQiAYdipv1b2ROGBxBuWx5+0MR8Qp48wO4b2fPaUtPXF5Sq8/cMPOm8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5790.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?VFntfaJboY1hLM3e2ZlQolj7Ise8SEPrUR5rMqhJZstgG3RxB5ayas5c573G?=
 =?us-ascii?Q?jUoZbliYvz5E7gBghhxqguQWjx4tp4TbO3gZqN3Ie3BAyORE71XnmR6tLbrf?=
 =?us-ascii?Q?BuxJo4juwkp4bL/r06I9XkKVaWs6Pf5TojJZ9+MsEQHeV0u5gsA4A+064nz1?=
 =?us-ascii?Q?kyJztv4C7ZiU4pZSoNF5NdSE7tNWu6e0oS3v0hLebaE+CiYBiEb42GcEMnQZ?=
 =?us-ascii?Q?EbxBPDxkCdY+yiQ3LrYWwpVx3DcFyF8phSlOaRywdUbY/HMXa+olu7PlBIr/?=
 =?us-ascii?Q?b2LYlwqaAXlLrqTFWGQdms/D6ezAZef9lV2B8RkES9F638zBahkMouCPKTu8?=
 =?us-ascii?Q?TxzdGoRUxJgEWZUDAP2yopwT98NeJEgKY4dhS/YRvQ1JPfxVRoDHoUL39SD5?=
 =?us-ascii?Q?KQ/ZSzKs6pAdI1eV9QKTAP+XE7likVl9rxccRn98l2vaPiF7r7Jb+6r8KmSG?=
 =?us-ascii?Q?g7dOnHx/nzYHmJer7qQ1bFv6ZyJ8+FXVlVjVCRcCVNhtkMkI3MoPaV5/dBbu?=
 =?us-ascii?Q?qo94RMwHdoIZmFAmisDn3VsAYkxnWcBdZF00a027O7fT+s5cqDCim5fvS4Mr?=
 =?us-ascii?Q?3wfUOoIvuscU3hs24JETb1KR9uN28FZNdGaAtdtuCUl3of2d4Dcz/E+aQNFN?=
 =?us-ascii?Q?JxP2CPxJm2ueYEJJ7jeT01/B4G/y2qTL1yx+mdL0+8iX7MO8iDyrPVT/4Ev3?=
 =?us-ascii?Q?oKOzT08bVesk1p7HasI0ZAQA+rxW4v7T3V/MjfbdPzWiDmVg4CX6EsCYO+R2?=
 =?us-ascii?Q?NOEst2yTmUTdNCfAF7OdI6mFElbV3Ri9/66PoM/GfM/lw1rYsZHXJNP6Qmve?=
 =?us-ascii?Q?fao7uP9JcY6knu2n6SlHftY8/uBDSwTyQzCmKSJ7hY/WkNVZ6JJKDx5gzjzo?=
 =?us-ascii?Q?389Itk0iKrTVCxeSf72cr+l/cYdj7AeZTg7CNkWaZGHugnjeP4lqLPhaVSs2?=
 =?us-ascii?Q?c4zfbZfoX0uL8LgnFxO0ellRGlrNx21QIYtO7obDYv7yKIhLT8QIRmcsXkFB?=
 =?us-ascii?Q?CeytHDI73EAwHZ9Dbn26lCFpTBeY6l5GPelymq9WcipPOexknvabDeOOMyiY?=
 =?us-ascii?Q?ROVS7JOwsd5UHcwunVjCZ2tp1X1ERYwo6ygUiHJ/GaglH+kKIt2K2FWKlPu9?=
 =?us-ascii?Q?6mu463PP+iC0ZGq7tQ5OK8ijZmIVitMIJEunjjHOE1mhcTXCmsQ3Hls/qBvx?=
 =?us-ascii?Q?lCcsvJeghjiIXTVWPu/f0//ezzw+upi3eAr/6O/623g8vbVS1GcqbApkJ5xm?=
 =?us-ascii?Q?gOaMUIGQFt+Yv/QtpTAtC7SNAUNHeWMv0gRq+z41rgAf02VLW1GcvNU6xGvY?=
 =?us-ascii?Q?RDT1JKHbrtZ5Dov9KVAazJOYwLW4z/Q0QoSGSxi7IiXj9/TXtICY8pcDYxv3?=
 =?us-ascii?Q?MP9UgtK1L/YsxMRIxUELliS6PATX4NtbxhC1bFKQdbcko8SKwzEjLGb54/Rk?=
 =?us-ascii?Q?QqG01QHRIVwMLQilgjjf5/snTwOHTT8ztyzjz1jbezNgsdNW7Tgw91sEWfW+?=
 =?us-ascii?Q?mcudsrOHo3w+QePzKoPv7jOYtNcCeJk/A6pk7VZA9glDfHW8VXyo1hHtVoIL?=
 =?us-ascii?Q?P4kFzqKyi5qMybXVjQW4DpNXGMlaV67KBHi0tdoT?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <301942C07F635047B837E61F87356199@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93fd8c30-768f-4e2c-ad67-08dc4544f550
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2024 23:09:25.4995
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t50h+kHqog3tQl+13TXSCtF8ywR2mFP/TCft/j06S02P5+e3gaJi0nd0AdqtP1U6fwiiwFQooJzCef4ekVpNTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6212
X-Outbound-SMTP-Client: 72.163.7.165, rcdn-opgw-4.cisco.com
X-Outbound-Node: rcdn-core-11.cisco.com

On Fri, Mar 15, 2024 at 11:47:27AM -0400, Jeff Layton wrote:
> On Thu, 2024-03-14 at 23:49 +0000, Daniel Walker (danielwa) wrote:
> > Hi,
> >=20
> > It seems there is/was a problem using NFS security labels where the ser=
ver and client use
> > different MAC policy or model.=20
> >=20
> > I was reading this page,
> >=20
> > http://www.selinuxproject.org/page/Labeled_NFS/TODO#Label_Translation_F=
ramework
> >
> > It seems like this problem was known in 2009 when this page was written=
. Is
> > there a way to accomplish having extended attributes shared over NFS to=
 a client
> > with different selinux policies ?
> >=20
>=20
> Currently Linux NFS client and server only support limited server mode,
> where the server presents the contexts as they are and the client
> enforces its own policy locally. There's no requirement that the server
> enforce the same policy (or even enforce a security policy at all), all
> it's doing is storing and presenting the security label.
>=20
> So what you're saying should "work" today.
>=20

My situation is more constrained than this. The server would also have an s=
elinux
policy which is active and in use. Server selinux usage is out the users
control.

This could plausibly come up where you have an nfsroot or nfs pivot root
environment with selinux is active and the server also has a different or
conflicting selinux policy active.

I was looking for a way to translate between the two selinux policies which=
 is
how I found the link I provided.

Daniel=

