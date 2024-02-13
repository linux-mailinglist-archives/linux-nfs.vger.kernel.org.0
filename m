Return-Path: <linux-nfs+bounces-1918-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8EB853D13
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Feb 2024 22:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 735B11C27121
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Feb 2024 21:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF4F634F2;
	Tue, 13 Feb 2024 21:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LDSJB12/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Cttgef+Y"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11465634F4
	for <linux-nfs@vger.kernel.org>; Tue, 13 Feb 2024 21:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707859022; cv=fail; b=bXJnmoJTH3ftcUIzJmsO8s998jCKuUXI8B0uEoF3jGgTsLMEraar1pGphgUlrAyay+f2Wuzsi38rbEnYBOReL1PLbCQkDaqXyBcX35VM8J2Bsj3qV61w6M2M4l65VG/yxembfRl69CcmmpXHA9dnRpuWcPeIzsEBmAjhwVj/SIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707859022; c=relaxed/simple;
	bh=uQ/hUr3/8z5n5N3X6bQ1BoVTSTF/nGh0djro4Dt82MY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XpsTL90aFozz/Gj9WRFnMGIeiSUs5xL6To8Tp5viMFOEiH1ZqwHuuJ1ySatnHfHtCC7QJqjh5xuTvaYxSGCc1C/yos1UmSEgNxcUYRjQE2f8B+fFlVKWkF6sPWo0h8hULU8QJBdwPERQCVZiRSOEjJfdI+ShNnnTB19jZBtT3y4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LDSJB12/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Cttgef+Y; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41DL3qJj028351;
	Tue, 13 Feb 2024 21:16:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=uQ/hUr3/8z5n5N3X6bQ1BoVTSTF/nGh0djro4Dt82MY=;
 b=LDSJB12/5GN5PYJN0al7NAhdHv+KiUMrgYw4EJ8UWTt5UVeU9Yt3aUZs5xaxcyzRLcOX
 blkQTgEsyLwr83BEOE+R6sjRCA3pGWpalfqADbDrVcM30Z8Po8Ab3SgadYORCSdYVRc5
 H/fOeq5uLU7kMZ8UwTpMOpidauk2StEFR/7c5JdG3+gDiplrQx+Wn1YS8q+a7mGmMZzS
 IsFREqZ7Mnk/QnHyc2qdJ9h1w3UdqYb+Ace+0/8PJBwEpoB0NX2+chDTNVMDLzBmnjrx
 Z2GL2KqXa4feyBf+HwSC8+Cg/WeC9M/6/v9KAXV7RUV0qIsPKC9WZ5aEe5YT6Ysltz5Q fw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w8g0dg106-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 21:16:54 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41DJhxUl024566;
	Tue, 13 Feb 2024 21:16:54 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w5yke80ws-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 21:16:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cy1poUxJrUOA0SG9nQFwaPB1R+X8lugM6UynM1Mr2OX3T9vTpF5fsTEw2b2KuLb87Y9TqrATpeHznDV4z6RituHAOblpP40B5kUuWoW0Mmbf4MMn0gbm59mlCJA+OMkl5e+2MKwldCI6X9Z7swK5ZAfwA5l2Ww01T8g5p5ZR18Qdwo48s6v1BbeydyJWBfL8131MKN3bZk+b2Mq/xzjYfqsWwEkamuyndHkg1wwLQtCM8xXpXzo6lkljSJV9SnrPXLBiShdWnx6r1+EerDE/1zSZZoQ9yk3r8BAAAKfXEyBfauBwRtRL/luexbByQ9ulBufW93foxTt0ik9UGSbT7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uQ/hUr3/8z5n5N3X6bQ1BoVTSTF/nGh0djro4Dt82MY=;
 b=jyG/oqQq/Bwx2Qj44wq6VXBQ9hoBN9ju3SqodeR9jrsEucQe2o7M8LPO9M77H/XrpznPuHRm0PqZodZ3TMiARhylCnjycTReKMgTcNzSvy4XH9VKyNWurCos+g6tx9XqPEh7mX1nzjaeBvi2V6eEIH5IGee4Hy9hx2nQ4LQybyG1T6GQV/xd40Jkp78zZ/XydiEgpVdwF6iQxu6bY4HquYChe6nhcVRbi0z+aN5dOGv6giKfgwF+CtO8W/aUuRmb5fwiti0yqBVzTVoeAiip7lRJNXEueIIolpfHkSnHXzqzr3KLbDsjMyxXrI4Dd2IkS9g+IEJZBRPvMBEDiKdnNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uQ/hUr3/8z5n5N3X6bQ1BoVTSTF/nGh0djro4Dt82MY=;
 b=Cttgef+YRkGCHRnXUvzPUKlUNw3YCPId3COwoxn9CaaPII4nEhVYM9YkesMy2KX4dWwGoGbaQQ3W00pxowFqUp6wyGxoPC7peP5W0Vl4qpJS/hUtjstg67A3UGX8LWqx4f4eSSIc9mqdyuiHK2LLzx1uLBk8sgeHFDJ8mx5fwOk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO1PR10MB4740.namprd10.prod.outlook.com (2603:10b6:303:9d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Tue, 13 Feb
 2024 21:16:46 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b%4]) with mapi id 15.20.7270.036; Tue, 13 Feb 2024
 21:16:46 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Dan Shelton <dan.f.shelton@gmail.com>
CC: Jeff Layton <jlayton@kernel.org>, Tom Talpey <tom@talpey.com>,
        Linux NFS
 Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: Public NFSv4 handle?
Thread-Topic: Public NFSv4 handle?
Thread-Index: AQHaTzC13a0zCBykREWshTkqsu2m77EBPMYAgAAmx4CAANhZgIAGm/4AgAANk4A=
Date: Tue, 13 Feb 2024 21:16:46 +0000
Message-ID: <DC9FA9D4-C25F-443B-B8AF-60CB3C8792A6@oracle.com>
References: 
 <CAAvCNcBvWjt13mBGoNZf-BGwn18_R6KAeMmA7NZOTifORLEANg@mail.gmail.com>
 <CAAvCNcAkZFkLU-XtmJy30AT7ad_MvSzZTMEk86PiZXLdcMg4fA@mail.gmail.com>
 <b14648b0-a2f7-451a-a56b-6bb626c4ffa8@talpey.com>
 <14e1e8c8613c74d07cb0cefbcebbf79a3a57311e.camel@kernel.org>
 <CAAvCNcAsow-QTPYLm0fUNX3K5X4Aci=aFi+hi4a0S8k19oa-KA@mail.gmail.com>
In-Reply-To: 
 <CAAvCNcAsow-QTPYLm0fUNX3K5X4Aci=aFi+hi4a0S8k19oa-KA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.400.31)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CO1PR10MB4740:EE_
x-ms-office365-filtering-correlation-id: ff0ed042-17e3-4b57-f6c5-08dc2cd915ce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 pKY3fBifYV1qca4JNxR9QmSFVTd/VFRJxhv4G6V2dTV2B4HhE8+yQZmKNuO9M+oaxel2Aq6b8GZfvadPIFKuq6bcLcv0sIwE6d6DC6u6dJqM9U7b+bp9T5JxKTVJyS2sz/IVE261sRnpIsPAm3iq2NZ8VvoYekm2/SKIVfdAl2NUGr8kiEcAd1a5i7SyLytICypL3Ig3zsQSd9m+9kQGexx7znS7FfidGZ5sqhPP8H7NckAUh6lw1iTaort/Ph0agaJBeDZATPEMR8RIiJ/xES1UzzOsMTamVzAEz1zI55ZLntuihqb53lU74o+gGI+nYcpK3PZ/k8JCcHMKzzlFv23eDhL4R7JxaayhKTnw0H/qPXtfYFjjZM8ISqRI0dvC9wzSl4ZIl2miQglEdUTQhA+hnh9IsVGrNoCRuRKJY6anUl5SCI5uQZfIjvNfgQKy+d8pr0xGBBFsMjE7KwJac8t1Q4ZxzY8e6uvk9xYe0ZVEPz4Pz0zafyEUO+eKoRvn3TNQVzTBNTsqwUyc/hvQfGNLHRpwWUbXdmqepodqXq+ilOe01KFlZFtNdnkjnVilJGrnaWxfGDAaZ0Vqqk5krKkSvNkFt/J32nA5ShToSSM=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(376002)(346002)(396003)(136003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(66556008)(64756008)(66446008)(5660300002)(66946007)(76116006)(66476007)(6916009)(8936002)(7116003)(8676002)(4326008)(2906002)(86362001)(54906003)(41300700001)(26005)(2616005)(316002)(36756003)(83380400001)(33656002)(71200400001)(122000001)(38070700009)(6512007)(6486002)(966005)(478600001)(6506007)(53546011)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?Y3B6dENDTHpIKzVzNXZIbVFLb3RyL0s5ZnhZbzl2ZC9nL3FtdVVzSWZWQlgy?=
 =?utf-8?B?NmV6SEJOTkNZL3lqd2xzOVVYS0pVdXNCcUE4QzBhRlhNU0QwWkZ0RVhDdUxp?=
 =?utf-8?B?dGRCelZGNnFLRUQvY3hLL1ZTYzNEenZFUnE4REFEZUdMM2prQWIxczNhYlBI?=
 =?utf-8?B?OGNVMkVlcyt3TVIrb28zdzFnV0lITi8ydE1SeW9qWEh1Unc0eHBNMjlpNjlO?=
 =?utf-8?B?T1NmTlltL2hrVzBlRXVqU2VlUENPVXlDVHExaUlVdUlSdjdOWGR1b0RkdjNJ?=
 =?utf-8?B?NjFZYWhOU0xLN1A4dUd6SzFmNWwvcjhFZGFyYUtHb2UwbUNFUU5qd1VlOGdo?=
 =?utf-8?B?UWN4NHBBNHZxMUJja2hIVWszSHFNWVVpak9adzBZem9UazR6WXZqYjJHL2U4?=
 =?utf-8?B?dWFDTFcvVjFvRE9ibHJ5eGZ1amFDaSt2M3N6SzFnbmhFckFyblBnd1lMQnRy?=
 =?utf-8?B?TEwzQXdlZkY1RjRTYVJSNTFTOTZTVHo2cHFEQkR5ZEZhMEl1UlVJMWw2bUNa?=
 =?utf-8?B?L0ppMzhRNEFrekVTV0dMSG5GRUtJZFhFVXhNbmtYb0pkaEltS3lXYm1pZFVU?=
 =?utf-8?B?NTYxd2IxNFBuc3kvb3lhQlMwYkxJMzVIb3FXcDB4dEU1bmt3emhtVUl0NjVC?=
 =?utf-8?B?VnNORkh0MitJT2k5bmlsWlhNaW1oZ2FBTWtmWWlWeWhvQzRSeEdIMVpJWGdh?=
 =?utf-8?B?Tjh2bGFVWG1VYzU1ZFlDaFB2YzdTbE5zbk90TmxYc2dQajVIQ0lyUThQbjBt?=
 =?utf-8?B?NWhDL1g1b2RxQjdPaWZZYS8zTjlhM2QrQmpOZkZwRnhpT1ROSURGbFJ3Yi93?=
 =?utf-8?B?UDVzZUY0ZEdqenBxc1pxYUpoNWtqMzBBU29FYW1ab2pNOGV0SWZka3VpbTh2?=
 =?utf-8?B?WXhVQS9ZdHVCMVpBR0J6MWVpMG93YzU2UWR2L29BZndzbmd4Z0pZbHpxemxQ?=
 =?utf-8?B?V1BvTXpVTmlCYnlFaXNoMVVzTlY1T2ZJb0I2WVlDT2RadEtEMnVhREw2elFH?=
 =?utf-8?B?TDZ3TlhNQnFMVjZJUFg0eHlVazFpU3VPbVcrRG1LUC95RW93dWY1cHIvc0NQ?=
 =?utf-8?B?TzhrdFZaRUF2TzFrSXZ1YTZVS3YvRGEySmVLbExlNDBjY1pEZnozTXRUT2lV?=
 =?utf-8?B?RGF1aDR5TXMrRnVYakpkWUhWR0dqTWlIMFF4c05BamFjMFJyRnVMeXpXQ3hO?=
 =?utf-8?B?L1pjWk5LNGErait2NEhjN3lhMmRadEttRkRCZU5GR203eDhFTEwzcTQ4U3By?=
 =?utf-8?B?MnRLeDRzVEk4TkZvQjFZNkU2WE5EZGNIam10V0dkQmlKZ25EbXBEUW54Rlor?=
 =?utf-8?B?cVlrMFVPMzRDUStUc2hPSGFxa2Z0cEpsTFFmd3VyTkprMzViK0hFN2pZQU1Y?=
 =?utf-8?B?LzB0MzhobnU3ckF3ZXpxdlJsMkFQWGx6UUN6T2FuZG1sM1ZyazI2K05wVGwx?=
 =?utf-8?B?R1V1aGZvYm0xYVlSY3hjWDVzK0FFVXpGK3RYVUMzYTBxci9HQkhvY1p2akdD?=
 =?utf-8?B?NGhsNDkzdzU1RURibGtvZXljcFJmOHcyeENsQ1orYTdWNkl2UzN2RDBzd3Ir?=
 =?utf-8?B?TTEwVnMzOVdvajVhVSs4QXFuOFVMd3pvYS9jU2xRQnF4anJUYWFTUHR0OUxk?=
 =?utf-8?B?MEhsbi9FTU1oZUtueXQ2bXEyRzRnbVBubStNeG1iZ1ZSeVA1Mit3QmFaVGhM?=
 =?utf-8?B?OWVkNzJtTDNFaVJOZHBvNlRYalN1MWE5eUNZeTNVUWVFTWg5YUVCMXc2Z1Mx?=
 =?utf-8?B?Tk9xTFF5eEpMeWhEbXJGNS9FUHFYUC8rYnNZdzZCaWVmUm9HM1lWNExpb0Iy?=
 =?utf-8?B?RUZmOFVCZnora2JXZmtWczdqZ1FjT3dSQW4vTUs3OFRHQTFxOVB1dHBhK21Q?=
 =?utf-8?B?K1BjRmpSVzBPWmRhYlI2TUdXWlBZMWMranRPdmJXRXNpY29lclVZd292cHFS?=
 =?utf-8?B?cEV5S245NkYrNEZyR0RlZ1RnNmhxNElpd0FXMko5Y0xvN2t6U3pBUUV4V2tW?=
 =?utf-8?B?YnlFTXdGZS9YditqRitGODdaYmNLd0lOb0lvZ2t3ZUMwUTRqa0VyeFZET0xR?=
 =?utf-8?B?WGhocjF0TDZZaER3anh2UnVsNlFkQ0RCS1ZCUURRbk15WW0xK1dyWU5Qd0dS?=
 =?utf-8?B?bEd6elFkRU90bVZUOFhvanRPNXhBU3BmUWVpSWxpRjY5cnpiaWlvckw0R25s?=
 =?utf-8?B?Qmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5F554F07757DD743ACFFC53919A7A202@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ZsudyDQeSbGFiq8Y5jvicmxDCJPym53XBpnZs+4jpql58lajaeY6+8jStK1ZKXq7GrTTIjrEeoyGSdcBjvWeZOedZWZXxjqf22vgpFjD/rVCa5b1aw+jFGlxa72wMKmFWrC+biJ9snvgnyNeyhgxJzFtD87cAe95fPeTtSee8RfZk6tzgQftvIpT1caKsdqD4GuMJZrkyibUmwktqtvcumpTWvvKDJDqK/T0JCpuuRe+mAyrWbiFAcXQcKPkqlAUAOPYu8qqtFEsuyAYc2bvd27JuqObTnSfi0SqT5vDr2/KHWbdTKlrCIfJd4vNST7IhScHvUuJrX48VkYyIojc8UBsnBNJqQ5HP4zcfzQfK88a39Wv1jLlatdh92Nm9l1HTal0RqjygJBUzcSKcaDUW52wMcyVryWLT4bZYt6428kHhw7GbI6Gt2h27SDRxwtRAsiNhIPQA/5zi3uRAJalToLF/7IkeAZRFCvEe/EQZal+GbCXWYd4ETpqrkW4sy5RN5Ihea9dsoEV5yL+ATpy62CCpWM0yf0ipkybRDf4kXaSbq3eJkzxr+RgaKX/EjhN3/GC2g6jTNH6M8m24X7Am10m5iGynwD6dG7f2WXvML0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff0ed042-17e3-4b57-f6c5-08dc2cd915ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2024 21:16:46.4578
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4sEynMUjKJ80xLZvSg51J26lJVKOnXx+1tYkTwZYvVwhs8K9v3PtX67IWmxcOHUGdczUvWsW4Y1OHUx1vhduvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4740
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_13,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=898 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402130167
X-Proofpoint-GUID: 1z9LJamkLnDSuT1R3ne5uSAAf9CfzK_S
X-Proofpoint-ORIG-GUID: 1z9LJamkLnDSuT1R3ne5uSAAf9CfzK_S

DQoNCj4gT24gRmViIDEzLCAyMDI0LCBhdCAzOjI44oCvUE0sIERhbiBTaGVsdG9uIDxkYW4uZi5z
aGVsdG9uQGdtYWlsLmNvbT4gd3JvdGU6DQo+IA0KPiBPbiBGcmksIDkgRmViIDIwMjQgYXQgMTY6
MzIsIEplZmYgTGF5dG9uIDxqbGF5dG9uQGtlcm5lbC5vcmc+IHdyb3RlOg0KPj4gDQo+PiBPbiBU
aHUsIDIwMjQtMDItMDggYXQgMjE6MzcgLTA1MDAsIFRvbSBUYWxwZXkgd3JvdGU6DQo+Pj4gT24g
Mi84LzIwMjQgNzoxOSBQTSwgRGFuIFNoZWx0b24gd3JvdGU6DQo+Pj4+ID8NCj4+Pj4gDQo+Pj4+
IE9uIFRodSwgMjUgSmFuIDIwMjQgYXQgMDI6NDgsIERhbiBTaGVsdG9uIDxkYW4uZi5zaGVsdG9u
QGdtYWlsLmNvbT4gd3JvdGU6DQo+Pj4+PiANCj4+Pj4+IEhlbGxvIQ0KPj4+Pj4gDQo+Pj4+PiBE
byB0aGUgTGludXggTkZTdjQgc2VydmVyIGFuZCBjbGllbnQgc3VwcG9ydCB0aGUgTkZTIHB1Ymxp
YyBoYW5kbGU/DQo+Pj4gDQo+Pj4gQXJlIHlvdSByZWZlcnJpbmcgdGhlIHRoZSBvbGQgV2ViTkZT
IHN0dWZmPyBUaGF0IHdhcyBhIHYyL3YzIHRoaW5nLA0KPj4+IGFuZCwgSSBiZWxpZXZlLCBvbmx5
IGV2ZXIgc3VwcG9ydGVkIGJ5IFNvbGFyaXMuDQo+Pj4gDQo+PiANCj4+IE9uZSBtb3JlIHRyeSEg
SSB0aGluayBteSBNVUEgd2FzIGhhdmluZyBpc3N1ZXMgdGhpcyBtb3JuaW5nLg0KPj4gDQo+PiBO
RlN2NC4xIHN1cHBvcnRzIHRoZSBQVVRQVUJGSCBvcDoNCj4+IA0KPj4gaHR0cHM6Ly93d3cucmZj
LWVkaXRvci5vcmcvcmZjL3JmYzg4ODEuaHRtbCNuYW1lLW9wZXJhdGlvbi0yMy1wdXRwdWJmaC1z
ZXQtcA0KPj4gDQo+PiAuLi5idXQgdGhpcyBvcCBpcyBvbmx5IGZvciBiYWNrd2FyZCBjb21wYXRp
YmlsaXR5LiBUaGUgTGludXggc2VydmVyDQo+PiByZXR1cm5zIHRoZSByb290ZmggKGFzIGl0IFNI
T1VMRCkuDQo+IA0KPiBObywgSSBkbyBub3QgY29uc2lkZXIgdGhpcyAiYmFja3dhcmQgY29tcGF0
aWJpbGl0eSIuIFRoZSAicHVibGljIg0KPiBvcHRpb24gaXMgYWxzbyBpbnRlbmRlZCBmb3IgcHVi
bGljIHNlcnZlcnMsIGxpa2UgcGFja2FnZSBtaXJyb3JzIChlLmcuDQo+IERlYmlhbiksIHRvIGhh
dmUgYSBiZXR0ZXIgc29sdXRpb24gdGhhbiBodHRwIG9yIGZ0cC4NCj4gDQo+IFdoYXQgZG9lcyBp
dCB0YWtlIHRvIGltcGxlbWVudCBhICJwdWJsaWMiIGV4cG9ydCBvcHRpb24/DQoNCkZvciBzdGFy
dGVycywgSSdkIGxpa2UgdG8gc2VlIGEgbGVzcyBuZWJ1bG91cyB1c2VyIHN0b3J5IHRoYXQNCmV4
cGxhaW5zIHdoeSBORlNEJ3MgUFVUUFVCRkggb3BlcmF0aW9uIGlzIG5vdCBhZGVxdWF0ZS4NCg0K
VW5hdXRoZW50aWNhdGVkIGNsaWVudHMgY2FuIGFscmVhZHkgbW91bnQgYW4gTkZTdjQgc2VydmVy
J3MNCnBzdWVkb3Jvb3QgdmlhIGEgd2VsbC1rbm93biBwYXRoICgiLyIpIGFuZCBkZXNjZW5kIGlu
dG8gYW55DQpwdWJsaWNseS1hY2Nlc3NpYmxlIGV4cG9ydGVkIGRpcmVjdG9yeS4gVGhhdCBpcyB0
eXBpY2FsbHkNCnN1ZmZpY2llbnQgZm9yIHN0cmVhbWluZyBzZXJ2ZXJzLCBwYWNrYWdlIG1pcnJv
cnMsIGFuZCBtYW55DQpvdGhlciBraW5kcyBvZiBkaXN0cmlidXRpb24gc2VydmljZXMuDQoNCkNh
biB5b3UgZXhwbGFpbiB3aGF0IGVsc2UgaXMgbmVlZGVkPw0KDQoNCi0tDQpDaHVjayBMZXZlcg0K
DQoNCg==

