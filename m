Return-Path: <linux-nfs+bounces-2587-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5524989447F
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Apr 2024 19:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFF07B21513
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Apr 2024 17:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612064B5CD;
	Mon,  1 Apr 2024 17:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="anH4dv4W";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="f+Bk5Mcy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC744D59F;
	Mon,  1 Apr 2024 17:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711993927; cv=fail; b=H+mqFQ8Fgc5gXWfJSGWjPhHujCQZg3OsmvEbmRhTBHyMbjvzjAnuos9WagnzliJm/HSDHa74ot7cvfVXma5A1zRtGwdrwNQpeiNVd1l2q/FOK3H+I96SVqIFoOQp0yHA9jm0eNbpa0DSvW1nRXNFUpUPol1l1EEDtXP8nzHYV5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711993927; c=relaxed/simple;
	bh=twPsY1L8ZXewI75VDuxoA+Q2QiUI3PUygZE0pEaIOvA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ewg08yA77hyTBtj5VjIa9oGqV1iVn7B5baoYujsvnU6unD/mKq8kDlxk2qAfIXI/k/jannA6WCnqhPoLzXPZLitTGvPvyQ8vm1O75TjcRULwabD0n3XrD1OIi7mTMjONCW4AnT9GKH+HoQhuSXNVx7PU/Gold1tw8MPBICsxd6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=anH4dv4W; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=f+Bk5Mcy; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 431HU1YA018518;
	Mon, 1 Apr 2024 17:51:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=twPsY1L8ZXewI75VDuxoA+Q2QiUI3PUygZE0pEaIOvA=;
 b=anH4dv4WJ7OH7TuQ6/5ISRxCl0uJeKSB3Sj/RHbDdhNXktifvMUK6Z7t10l2Ik1qsGRp
 UdxJws9grDic6suATZ02F15J8TssRmtWPIzjSEfZJHyAGeOqSBVqnkxlFlSx2njo50I2
 OUZPU5GGrl8Zh5PPPq0CXPYktC6qVeuUBwE+KJe1y++lgOK+RF4YBkKEe4EyGuXafuIC
 ymIKzXfNKQEZ0p5cnrQtbSW2SPt713aNKswmyZ8OTYsy+uMuRbbLmQVljwi480kNQZNE
 CtsjIHe7JQ4lsIU9O1Ol6WaSWgoitOa/v5PSTXWD789zxqylyhN2fRpdIbrpXmgTz3pB 5g== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x6b9vavp1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Apr 2024 17:51:50 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 431Gr5b2018580;
	Mon, 1 Apr 2024 17:51:49 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3x696bxhke-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Apr 2024 17:51:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FOCXP7Viijrs71L+qRkF0HfwEqOH4hMWyFtwzTKpR8TGwWOh8L/n7ubPdxKQyQB5h9eCo9c1ZuGmJvtGADORiYyRrhazEkZO/vuaVxVFXt1ixu1aZMPQkMoxtFbo7mKO+JQ5QPiYqBLctHYhmHVqJleEC8hTx9CbqmDsX1jIKYF0B/6AXdS6v9pV5r+mZdZkb3e9exUlNfBYmkp3lFb8op1P44PcIkSiG5TOdrwjK3sCZRXdhag+4cIDwI63yJN78tSOIhR3uKSDj8sHIF3KWOl0DWEc1rVMEWkW9HQD45k+yXzwEbHOlgPgT96/GUKCQlTk33q+AFOQccGPQJrZyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=twPsY1L8ZXewI75VDuxoA+Q2QiUI3PUygZE0pEaIOvA=;
 b=Hbip9lTfFbCzSxFbucyNplDCX++sFwV9tlX/OTgxwwC47845HLVlZZAtRQTQvstRxRVjpk/IY47NXU80rca5Jd/LBWpiCHl4FingqS35gNjuEqaHKmSJPnii0tw56tYPs70YSEM0bQQexxM3w/hBOII0XsttOEk+g6A5OzDWz24Wz+vymRqW62iEBRVSt2mbhSqeJ6lIHyRpA1hsbZpqDmAg/Bp2jPssfnaicOENGLwf4DUJuT01VF0GTL6+rSxdmKpzY6NCkL9qqyFFSFfZSCDuAHT2XUpzfU8K4JaxSBlJHlLaeXsrZNpEw68JogJHs/eOpQ5eWN37+YP6EBxEcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=twPsY1L8ZXewI75VDuxoA+Q2QiUI3PUygZE0pEaIOvA=;
 b=f+Bk5McyLUkFi/kyu+P+jR3grTniJQEKEqkannQp4ie4oUD13wO4J4ZD8N/ljrfwAh+biJS1L0Ldo54PACRJ6fEzHSKbtPH5upS5I49EG8xSQJp2xnuMVE2FcTHHSdZpoYzCIYmAmv8d04Yc2Hw1QKNkUHH0OQRYv7r6ERiNQWA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH2PR10MB4149.namprd10.prod.outlook.com (2603:10b6:610:a7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.42; Mon, 1 Apr
 2024 17:51:47 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b%4]) with mapi id 15.20.7409.042; Mon, 1 Apr 2024
 17:51:46 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Jan Schunk <scpcom@gmx.de>
CC: Benjamin Coddington <bcodding@redhat.com>,
        Jeff Layton
	<jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia
	<kolga@netapp.com>, Dai Ngo <dai.ngo@oracle.com>,
        Tom Talpey
	<tom@talpey.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Howells
	<dhowells@redhat.com>,
        Linux regressions mailing list
	<regressions@lists.linux.dev>
Subject: Re: [External] : nfsd: memory leak when client does many file
 operations
Thread-Topic: [External] : nfsd: memory leak when client does many file
 operations
Thread-Index: AQHahF1E0Q3VyufE+kWxK44vN4DB2w==
Date: Mon, 1 Apr 2024 17:51:46 +0000
Message-ID: <760D3DE9-AD47-46A2-8914-1CD7122301B7@oracle.com>
References: <567BBF54-D104-432C-99C0-1A7EE7939090@oracle.com>
 <trinity-66047013-4d84-4eef-b5d3-d710fe6be805-1711316386382@msvc-mesg-gmx005>
 <6F16BCCE-3000-4BCB-A3B4-95B4767E3577@oracle.com>
 <trinity-ad0037c0-1060-4541-a8ca-15f826a5b5a2-1711396545958@msvc-mesg-gmx024>
 <088D9CC3-C5B0-4646-A85D-B3B9ACE8C532@oracle.com>
 <trinity-77720d9d-4d5b-48c6-8b1f-0b7205ea3c2b-1711398394712@msvc-mesg-gmx021>
 <51CAACAB-B6CC-4139-A350-25CF067364D3@oracle.com>
 <trinity-db344068-bb4b-4d0b-9772-ff701a2c70dd-1711663407957@msvc-mesg-gmx026>
 <C14AC427-BD99-4A87-A311-F6FB87FFC134@oracle.com>
 <trinity-157de7e0-d394-47fa-bb44-2621045a5b6e-1711812369391@msvc-mesg-gmx004>
 <Zgg9OzeFZUTc4hck@tissot.1015granger.net>
 <308BAEFD-8CAE-4496-8146-8C05DD78FB37@oracle.com>
 <trinity-00b2c0aa-3284-4d74-8184-71b5374bd8d7-1711992900521@msvc-mesg-gmx021>
In-Reply-To: 
 <trinity-00b2c0aa-3284-4d74-8184-71b5374bd8d7-1711992900521@msvc-mesg-gmx021>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.400.31)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CH2PR10MB4149:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 0jlf3FRrRuLwxkRql2v8OPhqsc2V4wxHp0loDv43Yt8mR8rZRNI3Fe4HuMTfsjm0tuxP+PjpzRlffl+0jsRcDnMuziXigXTEzzXtmw8Kh9utyQXJuGewcKjhqPMjM33QZoFmSM0QynpRu491Lm4Ld8VA4zTNDj3JftnfCzwldPZnVs5zcUXmZ6q2hANtDnz1EePsPn5pO30CiNGrF4L38VF2PUxVqgGb5ZZ1SweJcfYV76bVooEyPr3dfnKubi397VqpogG8ta2ceKzuroMKXOsmPxWcrmu8B9U3v+DbHCmBAojFeHr1gYDxVG1k9J1qKfoTWSCTmvL05OuQ7UZt13Mo+yC5SnX7L2Oa0SvJ40XM+nZ2hjaYeXxIdQOQbR/C01VCa9e/cpZSE3HWw37UBAI4Sq2Cl5p3PnDTBcqewATTrD1qoxG5ikR2JiCja6bnEfqn+8+LEKHLpyMNJ9AgN7NvMT0UGYSluuKHCLpAup2Mb0r9vX1LoTqr2SPnF4KsIV9j18OkKKWiiAzQS3/XnEgpeSwuDJwN4vEu54R6PnqzCnt7latlyQVfDBJ70UxEfQ6tEo4BiD1yLYm1+SIG9XnzJWhNr1ZvQEqfX+VvpFE=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?Q1RaRUx5UVJ3NGlEZHlSNkViblJCWjdOY0hydEo1UG83RUFubW1TdE1vV2xD?=
 =?utf-8?B?WnVVME1aUnUyRVFkaE9TOTRta0NoMDF2TVlFOTdDM0pIWlh1bmZlMEUyN1lj?=
 =?utf-8?B?Z25BWGJEbjlmcm9yOFU4ZlJPOWtmeEF6VS8rdVg1U1BrRWlxTG9XYWJ6RUo0?=
 =?utf-8?B?VnhsTlJBZko5dGFJR09NRnBSbGx1R1gxQ1FMY2ZlU2UrcEIyQ2t1VTRSSUpW?=
 =?utf-8?B?aTVZNFpWS1dCSnVHQ3h3WC9kb0dVeVRrekJNNWNNMGZJb2dCZzYyemJ4RDhJ?=
 =?utf-8?B?dWhTUzZxTWRuKzlvQVN5YUNpbE9GQW5KREcyci9PWXR1djdWYjNodkpOMHV6?=
 =?utf-8?B?NXMzWlB1WGtSU3ZyRk5oZGZoK0JqelpKK3ZZY0ljVEcvb0ozN21weG12WUZ5?=
 =?utf-8?B?b05ISlpqR0hNWEVJMjZjZHdiVnNob2FhT2hGcU1rSUJYR0kzcnR0akhVbk9Z?=
 =?utf-8?B?aEV4OTNUUDdLakFVRXc2ZlRJWENvN2YyaElSYjhCWkJPUmd1SFdVTTZnUDM4?=
 =?utf-8?B?SGpkYXpRR3B6bEFlRERSVmtETWR6MkhkYXBqTkx4bVlUOWwxelpJYXhKcnY5?=
 =?utf-8?B?QTA3TmtvbkVBU2U5TzA0eFg0TEdrbW9tK2NWVFNhNkplZnAwa3NIQll4U3Rh?=
 =?utf-8?B?L0pGZ0tHeldiVUNTL1R4elVlZTJFd0x1MU9nc3J1VWdjZlJiNWFmL2xmZzN1?=
 =?utf-8?B?YnlOT3ZvUVRFTE9la3BFSlhlbFFhWlMyblZNTHBlbDVPVVo4U1R4UEFkNEtq?=
 =?utf-8?B?SnRNM1pQT2tiN3pJc0xOL2U2SVJrc3BOV1pwaklaQmV1VGJONTR3Z0hlWkRW?=
 =?utf-8?B?L1pXNGthY2gwNkpFdWVQSzhCV01rR2gxRUtmNDI0L0pGb3l6V2c3K3pTVEM2?=
 =?utf-8?B?a3FLZytUeXNqTDN0WEx1dlprWklUZVJXRkg2cTVVT1gxZzBicDNZVXRqcU9i?=
 =?utf-8?B?SnBLUmp5bWxYdGJWd2laejRrU0t3UXRFOTl1NXFhY0VMc3hFdnZNQk1ta0h1?=
 =?utf-8?B?dEJJQ1d4N0NqeTM0b2Z3eDlCQ3dXVytMTkJzL3pRbjQ5K3UwK1ZsQWFSS1hI?=
 =?utf-8?B?U2swZlNubXBqa1JjNFA3bG16Y0ZwemtvN0RCYUs3Y3pqN0JuRkhpMUxEUEh1?=
 =?utf-8?B?VkpaYkxMK2l6ckU5cmFITmYyODNGZFJkQlU4alN6dU83MzB6MG16NnVaa0Zr?=
 =?utf-8?B?cXJaT1FPcGYxRW0wZ1R0TUJadENqakMvaTI1aGdUYi9DejhsWm9sQ1hlNzhS?=
 =?utf-8?B?REJXcFFVaVkyMDhhS0J2MDVEWE9YV2xaMnBnakJHZXRzbmt3WFBwRTBmNXd4?=
 =?utf-8?B?dHNKRkM0ZlRkQlNuUkh4Znh6ZWIwK2twczRxdUFUMFdmbmlCSUxLMGdIckty?=
 =?utf-8?B?R1U4UW9CVGxCVXVKdkNiNTg1VUpWbytzclVSb1JCZnFlQUZ4N0E3RytTUjkx?=
 =?utf-8?B?ZG11QS9BdmMxV0kzSTl5OWFBczdjTnZlR3ZCWk9YRnVBWDUweFJVTG9VTmky?=
 =?utf-8?B?WHA1Y1AyV2tXSHV5YXlFTkt6ZTVxUGV5bDB5YkN5bU5TaFVWRnZnZVlMcy9J?=
 =?utf-8?B?Vi9ZeGYvZUpCZ05aL1cyTVB1MnkvdTAyL0J2dW9peWdtYyswcmc3SDRVWUMx?=
 =?utf-8?B?SVRvNlBoTm5hL3FLNjd6SitWZTYvd0lqWkdUYUlpWitFdXRydXQ3aHk4aWFl?=
 =?utf-8?B?eUg4cGJyVzVyTEpEOXl0QVhvbHBVSnMyUnh5eGZyWGxCQWpXemJLMmtoMCtq?=
 =?utf-8?B?Z3YzQlg5ZW96U080S0VnY1hUeWdqMTVxc0JQYkVCMlZIRGVSUUZoT2ZFcXBV?=
 =?utf-8?B?N1hUQ0ZNVDkrM3QxU21Md0pnM0h3MDVyQjFmR3hwRFhqeGc3Y3FRc2NOYVlV?=
 =?utf-8?B?K0x1Mm55UXQ1VS8zbFRkQjNSQStlbFdoV3I0cWMzdGs0YVlseGZJVWxXOHFS?=
 =?utf-8?B?elJMeFlHRjhCQVFENEs0dnhPWUJXdUZyTjlyT3M2OUtteEtFeGJwN2lBUXF2?=
 =?utf-8?B?Wkl4L0ZKcGY3VXBwMGM1K2VWeUJ4NUd2Rk56SXE4Yys0OTdhTldTVTJ0c3JI?=
 =?utf-8?B?NHFRenN5aFNNSHAvSUF5bFo2K0xGbllSSldwb3ltbjNWREdqbW1IZXY0aWE0?=
 =?utf-8?B?eGh3KzhDTGtraWFUV2NZQjRYTGRQcjd5ZXI4bTY0c253R1JPbjdsYldabVlG?=
 =?utf-8?B?WUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <22DB6965C45BA541AFDB808207074DE4@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Fo43lA4x/E3oxuHucbKjKbeEJDyJdP+xUktJjrE5ZkupyXJWv/GYB3rqr8k2p4+k+WziKP0asfsabt+Aidoa5NkPdyjv7JuDsyuAM2/nr0skKqQHF/yT0NQqcTd4y8RWR9QWOnnnkGvcRAZIfBUvt8N9fq/54zX2Zbw9OL4g76ajbgpKyAGcLSvwf8/HgHlCFzAI0NSKlbHcergkcTLXSoKkH1YMgPSipk/Io5UeIkhEduY9WoN8XY+7AIp6QhjCLYQQQNe6Z2W4r0v62WV28xcuKF+iffY918D7eXmFdukTg7uIUWJLZOakeRgD1hDPgpMhwbk2naVl4/zp+xOdxgU4xBGZ/KVWWEE4hFv7fgbXwNMR7nFQog8PeBizERnaY5aRTkLIiVcOnWtRFUSG7SQO4YDm+W6iG5DZ+tzNIaPENbnGfRNWf+5a98qfZlt4jQvKP/Lpy2foSXhTumvcqKIfJG7fHtVPk1+ilIbgMUgOJfxFripyYKzv7e2gYw4AFUUMusWt2q4WL1sXdCzwfk5p0lMI0PLPB3Mp7hYHHtCW+gjWg0tbOpV3H8JQ44cCCYIqXZ5dUFpRJdHQ1csx9GxgaaDjEfvMfaj2EaeXuYg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee146b96-d6af-4e8a-eb79-08dc52746680
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2024 17:51:46.8926
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jK0aWdDS11ibXl23LfnvnzS8X4d8DUkY1NtO8YEhrY6T4tv83ui4m31Ca5VHfwEKfLw/28cLcAejEGssAkmIeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4149
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-01_12,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 spamscore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2403210000
 definitions=main-2404010126
X-Proofpoint-ORIG-GUID: kMw9REQKQ6zgUgrVrBsXFE2GlUBV003y
X-Proofpoint-GUID: kMw9REQKQ6zgUgrVrBsXFE2GlUBV003y

DQoNCj4gT24gQXByIDEsIDIwMjQsIGF0IDE6MzXigK9QTSwgSmFuIFNjaHVuayA8c2NwY29tQGdt
eC5kZT4gd3JvdGU6DQo+IA0KPiB0aGUgYnVnIHJlcG9ydCBpcyBub3cgaGVyZToNCj4gaHR0cHM6
Ly9idWd6aWxsYS5rZXJuZWwub3JnL3Nob3dfYnVnLmNnaT9pZD0yMTg2NzENCg0KVGhhbmtzLCBJ
J2xsIHRyeSB0byBrZWVwIHRoYXQgYnVnIHVwZGF0ZWQuDQoNCi0tDQpDaHVjayBMZXZlcg0KDQoN
Cg==

