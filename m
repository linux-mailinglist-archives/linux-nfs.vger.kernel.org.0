Return-Path: <linux-nfs+bounces-1796-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCDA284A6C1
	for <lists+linux-nfs@lfdr.de>; Mon,  5 Feb 2024 22:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6830A28F25B
	for <lists+linux-nfs@lfdr.de>; Mon,  5 Feb 2024 21:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D334D5B5;
	Mon,  5 Feb 2024 19:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XYZQDOc8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lN4Uxz+X"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF24537E9
	for <linux-nfs@vger.kernel.org>; Mon,  5 Feb 2024 19:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707160724; cv=fail; b=huGpKZCfpHISTCfFse6swrW5nCUapk7oPeRgUWXB+D8eTarvBCyFz19ej4baIQlbSlY9GnP8heOJj1lIta0BzrQ+WLl4ZHiBkH1F0F/jH38J9AaVAJ8BL2SKX7hMlTKZOVGFCNiQH9XCokukZEhWqaIxID0wkXP9K/SMAJ9RV+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707160724; c=relaxed/simple;
	bh=+EdzvaypJSMTO+YFMhRb/IcoIMIYdzXtFoeoGrztOMk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ixy0FyQF2SuYjJF5FZuvW01M8pjHOZn8fr35c1xrQ7THlJWTlDRKDmwy5NMFewX8fXhfAF3k8UTjem4PtuTQnAkKya2WOckXYhn81IoL3EV6fNt+YCqRnAly4gG35HMotnligCIu1uYDc4xiDFqinOJ7eGT2MSM6vlIVyotHJO8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XYZQDOc8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lN4Uxz+X; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 415J4Jw4011806;
	Mon, 5 Feb 2024 19:18:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=+EdzvaypJSMTO+YFMhRb/IcoIMIYdzXtFoeoGrztOMk=;
 b=XYZQDOc8UcRmPSaVWYn6c3IFr4EChY7NYwRYw+4GJ003YSKNWVPgNnnIjXVVEIac0NpQ
 eTiihRO9JgAxg8J/mlkuAYcb0yMTvYUQq29A3BJu7y4UkViwuvuC9eh0f/ceTQ428DXR
 /LrffQ2GqpuPWBnHADAiz6inw05nnzf5wJIALf7ogcwnqOF4vvdRRG+7/9kfLd7XZa5S
 EOHIl16x0rLCmY+BpQliqMxquMbgSPl+Cr3nqPhUbOnzCilKqn4EIW20wDNElWWQEoru
 N9fIFKA25qnlAEKqlLLMy53GwRe5/1UfYaP0Jj0+8ABg8EKOQ9TAVusOs3H9f7e/Muby ZA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1e1v4scs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Feb 2024 19:18:34 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 415JDX2W038466;
	Mon, 5 Feb 2024 19:18:32 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bx5yw96-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Feb 2024 19:18:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HUzUCu/hVSRVqmUSVq4au1+i3lksS1e36gc0399BONb0M9Rd8PHCQZvcZYta9gkSL0WOGOtg8AC7sjuuszbwvbCml3ycBWY3HvL8MwA++MHTETc2Kj1qYioDb6cr0NZja/h07ezsd8rJQAp5clNlwtJ4keiaOzJtR0QMF7ht8ApsLUfbUHVZT3HwT5aI8VV76hzZC7Tp8c3TwChGMQYA5eJypqM5bBPx+w+Hvcx+7PtnEyBzvJ0hnBbPnLINyiVux5wZxqnnfsQyBO58z4x5GQ7fssIV5YdBBGlGXVz7cy9OJZnyhRg6YyUPeVTuVBF+hwiZY34F4smtdvz+h7mLzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+EdzvaypJSMTO+YFMhRb/IcoIMIYdzXtFoeoGrztOMk=;
 b=F204dDEciHP5rTIfsZww/6QK5E9tNiUICwW21ZkZ2s1BW2JYgIk4rdp7m+W7xOc4iT/YwYaRWFqtas26ZQcOV47lPWhTe0mqAg09nlFnCIuIIMF/Gm3LgCd7yOi20Hz/yLuolJeUJoBIlYiFQt678CYa14Cezk736xaxfDObyDKlz/shgLdKOgif7eptnrXHygohC0pF1EU6kG8T+/ionZadWGj+q0W651R1q1RkSxQDlk+c1+zWTA7RlBRQSnbPVqtLNJMNIlxOpdQU24OkjbGmxwPe/nHN3lvMzvOqDeHjh2+/rzFoA8roTP/WNGjR0aJW2XNw604dBqLNQra8bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+EdzvaypJSMTO+YFMhRb/IcoIMIYdzXtFoeoGrztOMk=;
 b=lN4Uxz+XgFrOL9KSScSqXPrDps3UBpnf+zup5uRaidMW/UUurfeyDSfqK6fhbPiDsyN+qw/9DCOMMcxKqEkqdUCj/ppjzbLIKSItoyTCkoBgnKgk7RI8VMHEK6JTW1lYVQWtm7pqylcF6dWkgcUAO2Teh4dT+2Y/9obvmByf4wA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SN7PR10MB6953.namprd10.prod.outlook.com (2603:10b6:806:34c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Mon, 5 Feb
 2024 19:18:11 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed:9f6b:7944:a2fa]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed:9f6b:7944:a2fa%7]) with mapi id 15.20.7249.035; Mon, 5 Feb 2024
 19:18:11 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>,
        Lorenzo Bianconi
	<lorenzo.bianconi@redhat.com>
CC: NeilBrown <neilb@suse.com>, Dai Ngo <dai.ngo@oracle.com>,
        Olga
 Kornievskaia <olga.kornievskaia@gmail.com>,
        Tom Talpey <tom@talpey.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: Should we establish a new nfsdctl userland program?
Thread-Topic: Should we establish a new nfsdctl userland program?
Thread-Index: 
 AQHaT8Zp476+VGqpskq8+ahQ0OuBVrD3VWAAgAANTACABKNogIAADD+AgAAEC4CAAAVhAIAAFMQA
Date: Mon, 5 Feb 2024 19:18:11 +0000
Message-ID: <DB4F609D-6ABF-4A1F-88EB-8487DC943B5C@oracle.com>
References: <8a7bbc05b6515109692cb88ad68374d14fc01eca.camel@kernel.org>
 <Zb0hlnQmgVikeNpi@lore-rh-laptop>
 <e706a77b4ddbceeb8b0ebac4dcbca03f8196e8a5.camel@kernel.org>
 <ZcEQzyrZpyrMJGKg@lore-desk>
 <799dc278c5d15605e1535303a7a15dee4eef82b3.camel@kernel.org>
 <ZcEeeRrYOQsKOPw_@lore-desk>
 <8e69c484d0dd844453fb7144e72e8659dcb32085.camel@kernel.org>
In-Reply-To: <8e69c484d0dd844453fb7144e72e8659dcb32085.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.400.31)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SN7PR10MB6953:EE_
x-ms-office365-filtering-correlation-id: ee04e5c0-76e4-48ea-dece-08dc267f3165
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 D7lyHzeKz7fCRzd7F5RtCoId3bfuxgkCOC5ZmYjQ7LY7yuLGbrevYQgngD2FOTNaLunn/yQPjxrn+fvfY1/XQ0kEMTnkJfx24WYr8osmoMrjjlbBt0MVrYRUUOSZDaKDXFWgATlnl7u3uw5jF+VfqZogvjDnNHMJHnX4NPSfLeij5MRyriJyO07pxt+6ban6YXKEH1Lf9WjMW/N7UH1ppfpyR/DkzBTuvISjBB0ONdnJNrmwFWScWnrOUYOyIYaHhypZ5ynOeDxysDWbIoEsNB1I5HOE3eKsmUM8c2cKVsuppTC+Z4Q3DpFsBo2qqgT35iPUkjhnl4n8GfpfD+CZ8locbsDIo6nW6UWkCpCAwfNkRtWjc25tUg0SA+cTc+NYNnaXihaKpCd58Ac3//Li6MScsEhC1Vo7YE/K1ooMGebpADKl7AwH3tqQWtELDthz/C8Ym+zwPEVGQZ23aiPpGzm51coEnfft7EfxM104hJvDUeOuEQzCGZlIcIZKb5V8oO2B5OMg9e200ym5LbrthcFBuNs4p+9VxWmNpTs7rsM84G9YQukRlditXG4o0wtjQUO0v+n9yZKUuKu+R/FG8iDxltGivtn8DmAUr5LP8Vni2QOswufTA/QJ8dWBgNgkA1GGEa9jYDn3wWagHhmmlA==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(396003)(136003)(346002)(366004)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(41300700001)(66899024)(6486002)(4326008)(8936002)(36756003)(8676002)(316002)(76116006)(66556008)(110136005)(66476007)(64756008)(54906003)(66446008)(2906002)(66946007)(38070700009)(5660300002)(86362001)(122000001)(38100700002)(6512007)(2616005)(478600001)(53546011)(71200400001)(83380400001)(26005)(33656002)(6506007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?cUZWakRSQUNmZEV2QlVha1dOOWUwRTZFaWswRjR4dTMwZzZaa3F3TjR5OU1h?=
 =?utf-8?B?eCszb21CQ21GTGZIY2hOY2dVVURMS29PVXZGTEJHOU1hQ0QxT3NXOW5iTEVy?=
 =?utf-8?B?b3NIWkVSTWxXbzdZZ2RsTlhpTnBVaDJaaHFiRStieFJtalp3ZVVKY2k4N05v?=
 =?utf-8?B?YkhxTGZPcVFFSnhNZjZoNFRRTWNvaUNYcTlyUFE2QVlxWUFrSGR6STIxRmNr?=
 =?utf-8?B?YURXem9JZVlGWlpDR2dFTzAvQWRPYlEraDlPNXpsbkRtbGlneTVBRW1nMnJn?=
 =?utf-8?B?Y3ZLUVI0dTArSWEycVlEZXcvVFpoYzRmOEZ1ZUliMmF2M2t2a3llc0FPek5l?=
 =?utf-8?B?UW42VERWaW15N3BOTFl0dUp1dUlQMjllaktVL1hTek1aSzF5bWVKY1JzSU1O?=
 =?utf-8?B?SEZJbG1wODBsZzU5eG9WcnYwNE44bFB0QVdPbG5qU1kreENUaFd4a1hJRzlt?=
 =?utf-8?B?dmJseDlXQ0JLdHNJTlZoTDlUOTBDc2MxbHdYb09wb2djTDFtcmJmMzBoU3Av?=
 =?utf-8?B?dW4rVVlOUGhIT2M1QUlNNXhNZzdvbnY3MFpmNitGNnQwTnNqRE1EbHMydWdX?=
 =?utf-8?B?ZE5ERnd5ZzltME9PV3M3aE9IYnliaHA5OVBpa0NqVWVVTTV2TnBHTmdCZmpP?=
 =?utf-8?B?ZjZvdUFDSFRlcC9YMElMSTZkSkNwU2NLU3ZuRWpHUk5xSHRidXdNUEdSNTg5?=
 =?utf-8?B?SERVOFMzOStnZnRMY0hGbkVXekorM2xEaFk1d24vdkJWMFVMa2p1Qmg2RGpn?=
 =?utf-8?B?SXJGT0tBaEUyYXl3M3NDRENraVJoNkhIcGt6T0o5Sll0Q1VVUTVtVTJLbmRH?=
 =?utf-8?B?bFB3a01BU0RjVVg3UElsMHhZV2FHT3VMS2o5d0daN0R0cGRxakl6QjBGbU5y?=
 =?utf-8?B?TVh3dFJURWI4Y2pKb2kvVTRML0dNOU41Z3Z2SHE5b3VTU0hrR1VRK3NnRlZm?=
 =?utf-8?B?K0tvNFhCenZNSE9XT0tWVk45eHRiY0pvVk9VdG14cjlRNTkzTzZienBrT3ln?=
 =?utf-8?B?ME1CVXpQUzZmWFRsZzZDamdlSk8vUmhWeHBQSm1ZOGJvOWZEVlBjVkVCZWg1?=
 =?utf-8?B?azQ0ZjFqSmsxVDJOeC9YRVVyQ1l1R0NiUVRLNzYxajBlSjNFRklkSGlZWFlR?=
 =?utf-8?B?VFJJdG5PK3V2cGF2MTUwdkh0QzZtWWVLdUFCRVdBVUVVYkdWWWtqYzhPTFVK?=
 =?utf-8?B?eGs1RG1JazhySWhKeHJ2M25NdGFkTHlSWkkwVk5VL0JJRXpJMk4vTnYwTHRy?=
 =?utf-8?B?TWI3TDQ2WjMxZmNqTEovUmErYkpkUk4zaVl2VTBFS3FoQm1KdGFJNVlrc05q?=
 =?utf-8?B?RmYyakVpOHVIVDRKQ1lPMXVGUGxGMGFOaWtvK0pDVld3a2lhbDlnRjJCYzZD?=
 =?utf-8?B?Y1NYQjZXWHUzc1V4VEFxNlFoNUtrYklNWUVuaG52S1MvTldWTXp4UGRTVkJO?=
 =?utf-8?B?MU1MQ3dmK1BZdmw0K0JMc09ySE8ycXQwcm1nWkpNVUxDeElXc2EyZkczTjgy?=
 =?utf-8?B?TnE1WS9qNzZtU0ZaOWdNS01HeXdSMzBKTlYxcVVwWWZJaU4vMmZFbW1USGZJ?=
 =?utf-8?B?SE9lY1pZV3BQbklTNmkxbjF6NjNaS28rY3d6TW8rdno1dGhGRm55Ni8yTGJB?=
 =?utf-8?B?NDBIelRLazdnMnBIYitWaFFyTVR4UzBDZHVTQUxycG4yUWtmUGl0TGZnUGpo?=
 =?utf-8?B?LzZyVjNPUHAwODRsdG1abjBsclVFMFdYUi9KdGhjd2IvaExyakRLeVQ4MURK?=
 =?utf-8?B?eEcyWjRzQXdJWmFxSnpLRVlvZUx0a3FDL2xsZVZvNHNPQXlKdTBzL3BDem1J?=
 =?utf-8?B?Z2hDRjhyYVprNDk2WDJUOHRYWWhvYlN5RERqUEg1dm5FSnp0NGZXWU5qbGFY?=
 =?utf-8?B?M2dZQ21ENmRtMmxzeWxvVUxiajBYTnhVVjJJRFBqUm10WWtjazgyeXdNOE02?=
 =?utf-8?B?cGJZemFPRVdaTHlpZzA4OWUvUFgrYUxvV1N1RG5WbEdGZWlOTDF5QURTaEd0?=
 =?utf-8?B?a0Qydk1hWWlWS0lySlorL1AzcUw1RVNMTmdXWjM0bUJwQ3NmU1R2NHVGM0k5?=
 =?utf-8?B?Q0NPZk01VnU5OFpvSVo5dkJCcnRvQ2lvRjZ1OHVLbUQ4R3NITS9TcklocHo2?=
 =?utf-8?B?d2Iyc21JR2JFNE5aaE52NEpteFQxa3dnajNxQWRSTURqdjJmMmtudkg5bUpR?=
 =?utf-8?B?MHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2BEDB0A1251B9B45B673E6AA00F683C4@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	fY9Y72yRjzZ27oUzzyERNyb12qEGuhWxwxzBHa4P2xVBloORGtwz+kkuDc7YM5L6E7a17kmE97oDR5VScZnmIJma9Ae+P5yUmhGRfFAMLMEwow1mFkzBt12CDuo4gnL7u+r+5CjOZGW9/P0Eg5yisYkO7XCIKRerFA1GZ/kkQSte7gySqpgNJeDCH8LySCSwFhfj7P2RmXZKmwq5X48Uocdxx3xoScJvi9yJW1qQHhZ5k/6frHXLvksjN75Kk7TmfyznJcigrLP3REB+yXd/kr6DTwrFyBSVQk2woDXbN7lx5vu/cd8iJr6jNbxhPEluEwFragEzcrH8J3ztu1xKUz2WwFO5AP4u/sSRSvdh2h8COV9C6k184d/8v7M2iFeE93BFWZnf+dm2TE24dx7JZMkWFBmLMvB1oDMvpUpSMRw44pCk8EdGghAZVxt0/kLWr5n281Uw3M1lpV+AxzetfEnOaAm9lVmbemhjsBtVFFDZnD6tsr+N4MefNTvdIZaUGpPr4G7cnt8vNpcpFBnFhW3IdzOD3Ue4v0AwnWACbLFTyYOFhRAtMYwJsxeAjIgPrA/87bI+0al25iC52krdqNJa7C80Cp3ZLoVy9+e8AaM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee04e5c0-76e4-48ea-dece-08dc267f3165
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2024 19:18:11.0971
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZZm/5qLmqDP4oghYtyNO7E0RMY1QueG4X9rDyMjomgZ/fXf6+YMjwA3lntJe2/OLm9MVi2hTXgdpgCgoqS2RGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6953
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_13,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 phishscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402050144
X-Proofpoint-GUID: 9c84YfofWEKC_XlUNcSIfjZBW1ifVWdf
X-Proofpoint-ORIG-GUID: 9c84YfofWEKC_XlUNcSIfjZBW1ifVWdf

DQo+IE9uIEZlYiA1LCAyMDI0LCBhdCAxOjAz4oCvUE0sIEplZmYgTGF5dG9uIDxqbGF5dG9uQGtl
cm5lbC5vcmc+IHdyb3RlOg0KPiANCj4gT24gTW9uLCAyMDI0LTAyLTA1IGF0IDE4OjQ0ICswMTAw
LCBMb3JlbnpvIEJpYW5jb25pIHdyb3RlOg0KPj4+IE9uIE1vbiwgMjAyNC0wMi0wNSBhdCAxNzo0
NiArMDEwMCwgTG9yZW56byBCaWFuY29uaSB3cm90ZToNCj4+Pj4gDQo+Pj4+IA0KPj4+PiBJIGFn
cmVlIG9uIGl0LiBJbiBvcmRlciB0byBwcm9jZWVkIEkgZ3Vlc3Mgd2Ugc2hvdWxkIGRlZmluZSBh
IGxpc3Qgb2YNCj4+Pj4gcmVxdWlyZW1lbnRzL2V4cGVjdGVkIGJlaGF2aW91ciBvbiB0aGlzIG5l
dyB1c2VyLXNwYWNlIHRvb2wgdXNlZCB0bw0KPj4+PiBjb25maWd1cmUgbmZzZC4gSSBhbSBub3Qg
c28gZmFtaWxpYXIgd2l0aCB0aGUgdXNlci1zcGFjZSByZXF1aXJlbWVudHMNCj4+Pj4gZm9yIG5m
c2Qgc28gSSBhbSBqdXN0IGNvcHlpbmcgd2hhdCB5b3Ugc3VnZ2VzdGVkLCBzb21ldGhpbmcgbGlr
ZToNCj4+Pj4gDQo+Pj4+ICQgbmZzZGN0bCBzdGF0cyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICA8LS0tIGZldGNoIHRoZSBuZXcgc3RhdHMgdGhhdCBnb3Qg
bWVyZ2VkDQo+Pj4+ICQgbmZzZGN0bCB4cHJ0IGFkZCBwcm90byA8dWRwfHRjcD4gaG9zdCA8aG9z
dD4gW3BvcnQgPHBvcnQ+XSAgICA8LS0tIGFkZCBhIG5ldyBsaXN0ZW4gc29ja2V0LCBieSBhZGRy
ZXNzIG9yIGhvc3RuYW1lDQo+Pj4gDQo+Pj4gVGhvc2UgbG9vayBmaW5lLg0KPj4+IA0KPj4+IEFs
bCBvZiB0aGUgY29tbWFuZHMgc2hvdWxkIGRpc3BsYXkgdGhlIGN1cnJlbnQgc3RhdGUgdG9vIHdo
ZW4gcnVuIHdpdGgNCj4+PiBubyBhcmd1bWVudHMuIFNvIHJ1bm5pbmcgIm5mc2N0bCB4cHJ0IiBz
aG91bGQgZHVtcCBvdXQgYWxsIG9mIHRoZQ0KPj4+IGxpc3RlbmluZyBzb2NrZXRzLiBEaXR0byBm
b3IgdGhlIG9uZXMgYmVsb3cgdG9vLg0KPj4gDQo+PiBhY2sNCj4+IA0KPiANCj4gSSB0aGluayB3
ZSBtaWdodCBuZWVkIGEgIm5mc2RjdGwgeHBydCBkZWwiIHRvby4gSSBrbm93IHdlIGRvbid0IGhh
dmUNCj4gdGhhdCBmdW5jdGlvbmFsaXR5IG5vdywgYnV0IEkgdGhpbmsgaXQncyBtaXNzaW5nLiBP
dGhlcndpc2UgaWYgeW91DQo+IG1pc3Rha2VubHkgc2V0IHRoZSB3cm9uZyBzb2NrZXQgd2l0aCB0
aGUgaW50ZXJmYWNlIGFib3ZlLCBob3cgZG8geW91IGZpeA0KPiBpdD8NCg0KSXMgIm5mc2RjdGwg
eHBydCIgZm9yIG1hbmFnaW5nIGxpc3RlbmVycz8gSSB0aGluayB0aGUgZm9sbG93aW5nDQptaWdo
dCBiZSBtb3JlIGluIGxpbmUgd2l0aCBob3cgTkZTIGFuZCBSUEMgZGVhbCB3aXRoIHRyYW5zcG9y
dHM6DQoNCiAgbmZzZGN0bCBsaXN0ZW4gbmV0aWQgeHh4IGFkZHIgeXl5eXkgWyBwb3J0IHp6eiBd
DQoNCm9yDQoNCiAgbmZzZGN0bCBsaXN0ZW4gbmV0aWQgeHh4IGRucyB5eXl5eSBbIHBvcnQgenp6
IF0NCg0KInh4eCIgd291bGQgYmUgb25lIG9mDQoNCiAgdWRwLCB1ZHA2LCB0Y3AsIHRjcDYsIHJk
bWEsIHJkbWE2LCBsb2NhbA0KDQoiYWRkciB5eXl5IiB3b3VsZCBiZSBhbiBJUCBwcmVzZW50YXRp
b24gYWRkcmVzcywgaW4gYW4gYWRkcmVzcw0KZmFtaWx5IHRoYXQgbWF0Y2hlcyB0aGUgbmV0aWQn
cyBmYW1pbHkuIFJlY2FsbCB0aGF0IFRJLVJQQw0KY29uc2lkZXJzIElQdjQgYW5kIElQdjYgbGlz
dGVuZXJzIGVhY2ggYXMgc2VwYXJhdGUgZW5kcG9pbnRzLg0KDQoiZG5zIHl5eXkiIHdvdWxkIGJl
IGEgRE5TIGxhYmVsDQoNCkRvIHdlIG5lZWQgdG8gYWRkIGEga2V5d29yZCB0byBjb250cm9sIHdo
ZXRoZXIgdGhlIGtlcm5lbA0KcmVnaXN0ZXJzIHRoZSBuZXcgbGlzdGVuaW5nIGVuZHBvaW50IHdp
dGggdGhlIGxvY2FsIHJwY2JpbmQ/DQoNCg0KPiBBbHRlcm5hdGVseSwgd2UgY291bGQgcHJvdmlk
ZSBzb21lIHdheSB0byByZXNldCB0aGUgc2VydmVyIHN0YXRlDQo+IGFsdG9nZXRoZXI6DQo+IA0K
PiAgICAgIyBuZnNkY3RsIHJlc2V0DQo+IA0KPiA/DQo+IA0KPj4+IA0KPj4+PiAkIG5mc2RjdGwg
cHJvdG8gdjMuMCB2NC4wIHY0LjEgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPC0t
LSBlbmFibGUgTkZTdjMgYW5kIHY0LjENCj4+PiANCj4+PiBUaGUgYWJvdmUgd291bGQgYWxzbyBl
bmFibGUgdjQuMCB0b28/DQo+Pj4gDQo+Pj4gRm9yIHRoaXMgd2UgbWlnaHQgd2FudCB0byB1c2Ug
dGhlICsvLSBzeW50YXgsIGFjdHVhbGx5LiBBbHNvLCB0aGVyZSB3ZXJlDQo+Pj4gbm8gbWlub3J2
ZXJzaW9ucyBiZWZvcmUgdjQsIHNvIGl0IHByb2JhYmx5IGJldHRlciBub3QgdG8gYWNjZXB0IHRo
YXQgZm9yDQo+Pj4gdjM6DQo+Pj4gDQo+Pj4gICAgICQgbmZzZGN0bCBwcm90byArdjMgLXY0LjAg
KzQuMQ0KDQpJIHdvdWxkIHByZWZlciBub3QgdXNpbmcgInByb3RvIiBzaW5jZSB0aGF0IHRlcm0g
aXMgYWxyZWFkeQ0Kb3ZlcmxvYWRlZC4gInZlcnNpb24iIG1pZ2h0IGJlIGJldHRlciwgYW5kIG1h
eWJlIHdlIGRvbid0DQpuZWVkIHRoZSAidiIgc3VmZml4Li4uPw0KDQoNCi0tDQpDaHVjayBMZXZl
cg0KDQoNCg==

