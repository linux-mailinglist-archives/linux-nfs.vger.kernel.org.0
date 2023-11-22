Return-Path: <linux-nfs+bounces-38-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A477F5472
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Nov 2023 00:23:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B402281280
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Nov 2023 23:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391BE208B6;
	Wed, 22 Nov 2023 23:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="N9THfGC4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gx0Cyiat"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76574199
	for <linux-nfs@vger.kernel.org>; Wed, 22 Nov 2023 15:22:57 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AMNE26v012789;
	Wed, 22 Nov 2023 23:22:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 cc : subject : to : references : from : in-reply-to : content-type :
 mime-version; s=corp-2023-11-20;
 bh=+lXdk5l9ofDo1oaH2bo/5rE8cQKvOIaV/SLmhl0aSd8=;
 b=N9THfGC4m7dtdMQm0FJI/LpBXacOM0n5waRaI0QJj8ISPAwqhHULdAy4FLq1SlYXAK6L
 CTH3xXV3/gYTAcwGGwDCQ6Oe9xeqaHNswL+0WUSJYWBcn8LwTAv2PF7fXDxyKaAavOBB
 s2fROKyW7CdOw6UQQ/I4eGzT+FyrX4fZOuJWp8ls++29wzF+MzYKv5rTomxgpp0Y2+HG
 lppw5PHNAUVPIYSBgefXF8C+nSAZOCczDA0qln+lV58mwh+0e0S2OyaLGxhv1S/ldRL7
 C8Se7sWqDrenA1FRDGnJjc/8QU2yYjqBLNcVUtBdiGe7c/iQyYqG0xW4VO8nDA+ypZ+T Fw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uemvugj1w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Nov 2023 23:22:55 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AMMWE2A023637;
	Wed, 22 Nov 2023 23:22:55 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uekq9f2ev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Nov 2023 23:22:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CzOblQJ34GK/mw9KmrdyT24SO5bjSobLKhV+JDq+ahsx0W6D0KLKOb8UKw1uaLsPopw/olGal2i4ffTCZKGA5LImPocqx+pjhxYON6Nc5YHGp94P/cEsphmWyq/EhoLp7Bzri2xkkcs42KIEP5HJXucYP+SJhw3V61ISC21BLtScn+092+6PZvjxAXzHJW8Grvp0xIyxcBMLShr16YWJch/FJSxZhma9CZDF6Zo8k4cf7HinX07RuT06T/2J9V0E5/rwbraZi3n9HIZI2YbdlMrbHZ8OIavSnaZxUffMY5kRkpkZhFJ21VxPBZ/maT1nvV9CvUpQrvsn3cxvLQwTgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+lXdk5l9ofDo1oaH2bo/5rE8cQKvOIaV/SLmhl0aSd8=;
 b=OJxzRMkOZczVdrwXEyaNqCHp3+WItBqGl9UgGJbE7fRZ9MsE8IARlybEuzzaOYxWWwd86vEPxAcB8nr19dTnaD4SYtWiy/zgMZsUZ51nQXDyiklrEOJCpu4+MzRysMM4Dhuoa4uGarcmE3bjZNWn5dHCmOpyFyn8gZVfLKOO3xac3bvc9HnQdAHZSxoPMLE7qiIPDi+swJVY+bWrjdgw55osp92iC4XPQ4r3c43BQ2vOyIqGGTLfIvpCoXGXfY6vDhL0XEGBVHBns+SK6QrpfYcpwh38zTYuVNdMzwz0VeHy8EERrKOPgXdKha7U2wqdnGP1UO7u9cXYRSxM6PqrYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+lXdk5l9ofDo1oaH2bo/5rE8cQKvOIaV/SLmhl0aSd8=;
 b=gx0CyiatYmRna9u7jGw8pI9TswKA2Uv2HheKHP1IU72Q5j8LGLi3iFJKIvhA+aMrXYFfMTpTEzEOJqrrftIzTVMEdLmD3JS+CEGCCtz9nK3igEW31hwUl7qjGmv1tLT2AWdO7D+RthkjNsJnA9MnHYesBnb5/ihJz8V3FE/3nTw=
Received: from BN0PR10MB5143.namprd10.prod.outlook.com (2603:10b6:408:12c::7)
 by SN7PR10MB6329.namprd10.prod.outlook.com (2603:10b6:806:273::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.19; Wed, 22 Nov
 2023 23:22:52 +0000
Received: from BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::6488:c4f8:43d0:97c9]) by BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::6488:c4f8:43d0:97c9%4]) with mapi id 15.20.7025.019; Wed, 22 Nov 2023
 23:22:52 +0000
Message-ID: <675f848b-c838-4462-8c69-a670a2922f34@oracle.com>
Date: Wed, 22 Nov 2023 23:22:48 +0000
User-Agent: Thunderbird Daily
Cc: Calum Mackay <calum.mackay@oracle.com>
Subject: Re: TCP_KEEPALIVE for Linux NFS client?
Content-Language: en-GB
To: Cedric Blancher <cedric.blancher@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <CALXu0Uc7zHasg2damr4nhRZZF7xBbFc0ghdjop87+5vHa8bBHg@mail.gmail.com>
 <CAN-5tyFBZibge52iZtjnz5j6S2GrTXTWdzaDxLVQcr+G8HegvQ@mail.gmail.com>
 <CALXu0UfiCrcDciLX5A1tvG0DiPwAXPg=GikPakKW16UhZ4X-Nw@mail.gmail.com>
 <d18ee0e1-c52d-48af-acc0-366bd27764c1@oracle.com>
 <CALXu0Ucy4qK1T9-WMssYaxSvhSBSyyxiwP2sjLgMD_wXQs43Qw@mail.gmail.com>
From: Calum Mackay <calum.mackay@oracle.com>
Autocrypt: addr=calum.mackay@oracle.com; keydata=
 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
 smRifw1wGg==
Organization: Oracle
In-Reply-To: <CALXu0Ucy4qK1T9-WMssYaxSvhSBSyyxiwP2sjLgMD_wXQs43Qw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------A6No1uG0ryMyssgq3Q9GuZ3p"
X-ClientProxiedBy: LO4P265CA0046.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ac::20) To BN0PR10MB5143.namprd10.prod.outlook.com
 (2603:10b6:408:12c::7)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5143:EE_|SN7PR10MB6329:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b6fb660-30b7-43f8-e54f-08dbebb1f2d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	r4uBnKTfHueeoSyXzoCd96/VGybzU5+I/fnMslR6CcNHo24cVR2k+hy+PY0eg3KMmhEsivcMQgovUd5/vzgFGeXL3AV4OMDKIUVW90WOiwgRYkz6gcHysRq7Rlahq1rmSk7KXBfi+8rfWSGsTmO8cig4lrw/SjKhtfZZ1yoDoeKExEEh+7QO7bAG2fnZAPRYd6uvF4W1khXknbuqBrA6K8z5r1TvvvAeeCnQA2Nto+YWaRWWOj8I/0isKKLZM8VUyE9oDD29nFdx0y2v+JOOanXufXQu7udT55NjwWqi17gOI3i4nnVqD6xr1nGIyyiWWX2jET9dlE+ZZ77UcVNjz4pouEDq2JbJk40Mu4Z9N3XMXH7gN85cIS4UFjbsx8KxMvLO/be15cRd8xDwL//u0aqyUvNtmIWztDCpnfvjRgSnMlLQORz9wCTWDeqPeu6wKRVSkWighMpALEjARuGmhmYEjudAFYlRBtc5osaUsXyBvjGw1U4TOGsOPPYDHST7Lv06A3C9BPnMU5LHAjTf1+2tJtp5BcTGnAzSLMcgcdo+ein1dYj900ipbx2wE5dJfUxWIm5boht4avSY09unSL8q39v1NHD8d7cPYIKqUT8loWvoqgNmKrFMriRp0ums/Syafrr4UYZpSVz7eSHhTA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5143.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(136003)(346002)(366004)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(5660300002)(8936002)(4326008)(8676002)(235185007)(31696002)(44832011)(53546011)(33964004)(36916002)(6506007)(86362001)(966005)(6486002)(66946007)(316002)(110136005)(66556008)(66476007)(36756003)(31686004)(38100700002)(2906002)(41300700001)(83380400001)(107886003)(21480400003)(26005)(2616005)(478600001)(6512007)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MkpjQUwrVlJWOGxzbDlwTEtva25FcS81aTJJUHAvSmtQR21uMDhSTWU3OUpG?=
 =?utf-8?B?V09GZFZkR1FpZUg1UHJXdVBmQ2ZyemdPeWV2ZU1yQ1hRWWl2YmNpeDFBVCsw?=
 =?utf-8?B?NjFtT044WTZ5cyt6RFNJMUQwZXZvSnZISFJSNEh5UThzL1BiV0d0VWZ0c0dh?=
 =?utf-8?B?aGd2cEJmSVRDUnVoVWFsTDR3VGwrVlAvYjJ4U2pobnJHOHVXWVJwcC9VQVY3?=
 =?utf-8?B?YlA2VTdwMFBpTEIxQ3NKeStDQ1ZXN0hNRnpKMERHVWJmNEZ6VXRvOThTMUpP?=
 =?utf-8?B?YVQ5azQ2ZEQvb3Irdkd2RkphRDJGTW5RZk16M2R6V3JVUTVYdFVNK0p2bzdH?=
 =?utf-8?B?UHY3NGxZd1cwN0w4K0g0dk9RSGxXaUdQUW96L0lQNWtERysrTU5qTW1XQWhT?=
 =?utf-8?B?aEZnSC9VNHYxU0UrWjJ5cmZOSHVybzdvbzF0ZXovbUVUamZGMmFpUlFyZ3pK?=
 =?utf-8?B?YitrdU9BNEdmNXVmN3l6TytwaE1JTG0xWVB0cXFUcVNuYlNGMkRTc3MrbFA0?=
 =?utf-8?B?RVNoS3NmbGd6d1dBZEd2K0NuVEhxbDF6bWl5eGpqdXR5TU5TdWpXNjkwVEdD?=
 =?utf-8?B?cGRPK3Jqc25IcXVjaGlWRzZyRnZ3aUc0ZXFXSkVUNTRvRXdheWZsbFphT0JE?=
 =?utf-8?B?NlBoQ3ZBaXNNSGd2Y0VxSTRVVWlGM2RaV3lNbkdGWnZBNldlZSt2d2RNZlJO?=
 =?utf-8?B?ZHZtZ0N0cytDbVBZWHhlNENEbSsvNzhWUXBSZ2FVSGRhY3ZqTWx4bzVpZVJq?=
 =?utf-8?B?QUpOLy9qZWVJU2drS0V4NTVkM2VITmFzWmFDYlFDVGxXbjZCQkZUZ0dac3pV?=
 =?utf-8?B?VGd6VUNycWVyWWhoNThXNVRKNWkrNkZQTW91RzhIb0pOUXROc0N3OGFCek5J?=
 =?utf-8?B?aHJXN0kxVmx3VFRpdHNhSVJYQXBISVRiWFp6R283c2R1U0ZvcUl4cUo5WWt5?=
 =?utf-8?B?RW5OUHRqL2RDS3BlV0ZOMmFYY2h6N1ErZE5LTy9EUTU4TU81Nnh4Y2pteGtl?=
 =?utf-8?B?Y0lRQnpyN095YzBHako2OG4wZC9sT2wzbVNSNTBPeS9rTThXQnRHSmNyZ2lx?=
 =?utf-8?B?NkpqYWV5Z0srdzBxem5VWGI1WDRSb0h5VWJBUlBkLzlOc01tSys0N29QVEZ0?=
 =?utf-8?B?NlNFWmlpeHAyY1hSSWR2S2thakk5K1orcGhabVlxV0dnUHN6NFJjTUdzVXZn?=
 =?utf-8?B?OUZpSGRjREUxRStBTXRtR2IwSkpRM0N1OXBmaStuaUx5R1VQMEgvS1VhbUtY?=
 =?utf-8?B?aVlYaG9FMDZiRGk2d3hFdUExa1htcklHUVh1TTM3L051N0tHN0k5UXp2eEw4?=
 =?utf-8?B?YnUxclN5cE1la1dZTHZBOHNTUnJHYzdIcjIyZnBzL0d0NTMvdmkwYy9zWGU2?=
 =?utf-8?B?TWcvMWZTc0g4OVB3cTJHVy94Q0V6aDFBcFZEQ0svUlF3NkNPVU1keFIyNk1V?=
 =?utf-8?B?d0N1SWsvQkF2U0w3Mmt4OStxYW1WblVQTUVLc2xNNDZ3a0JWdWduUkZVeXV1?=
 =?utf-8?B?b1o3MCt0eGFCemFRTUd2THJoTm1jMERHbG4vZjFyaTQwbmZ3K3lZT0N2NDNh?=
 =?utf-8?B?VktabmUrYmJyVmJLcGZwUnJlVXJEaTZWZWp3Tjl2Ym1YeG1UTFRRUnM2Qjh2?=
 =?utf-8?B?R2hJa2tZV3NUTm1pRjBsR1FHbStWS2JyTVdkaHBEQWw0WkRlSUxyMkpDc3Bo?=
 =?utf-8?B?NUtHb1JMbWgySmZjS0NsRFlsN2J0SGt3cERNd3RyN1RBd1lCOHl1Z1VOamVs?=
 =?utf-8?B?THJISXVNVG91OWxYOTA5c24zKzJxRllJWi9sdExCMkZ3VFlORXdsV01NVm03?=
 =?utf-8?B?dnRWWTNzU0lZK0xEVVZKaWc4WlhsV3BCczdOZzNkQXhzNHJxa0d5SUFialUv?=
 =?utf-8?B?RFFrWlJZczloT1NjVi84ZTZibG8xRG56NzVUL1kwRk15Nis1bS94anZjUHZJ?=
 =?utf-8?B?TFpGOWtKNUtuZlFrRVVYRkU0ZkY4SURJalR1VXcvS1ZEWk9vTzFyRG1PbndE?=
 =?utf-8?B?bkF2Qk11SDJyQnFhd0JOTTJKQ1d5TkFBVWdaVzBNbUxkNVpocDlNdTVxVkdP?=
 =?utf-8?B?WlpJekdrM0lZUTNnOGN4M3ppRzVjL2hZUG9ZOWlGWVQ3UWFhUTVyZmcvOGNH?=
 =?utf-8?B?VTRtb3pmTFRxUzF5L0IycnBCU3RzQ2lndGZXc0hjbTl5VklXRUhVSFRiaDBT?=
 =?utf-8?B?bEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	EpvJUqQcPdYLOCTCogZ14dd/fT+qePjCuzekLEHEwXE+9gLVfkqdsToI/fC+ghcg06CD8F2cRn/L4i4qr6F3jYAo002TyEUkXDHghOTp0JjZfyyYTc8/6I0QUEb/u75qMc+C8obYztVaprr/9HKCqJNpOrc0GaRI3B40j8QQ/Yoodwdu7QpwmWDlZxW5M5ZYkXQaZ27LN9AdPOjxPNqWAsEpNfeLzO99KkerSzrQrmW/FPQv4dqmVhe5BtSx1WstadPxEUFcZwR+ho7i0aY0QH3K0bkTdvsCQYVR4sQl6tXKMT2GxddU5wqLIvxO29J/okEP8ytPZoQ4s2vDd2/5fG/k3yMpvqymIAyyvdiGT+VSznhaFJ/m1HOgB/2A/kmYCDdrz1cfYcWDZG7WUeqjGvthI5PNo0YhxDYkoaQhehenmGwiAN0gpFtJ/GRbUsOWEKkeFcOMOsN0hKpmN1aImekTTeNtJl1RRKBWriBVkrP323igj2qaHjX8QYC/v06RWCvDn4N9GA8mKn2DhIqCUmBrII2L03JmzjmUBpIsPqdR53O0RRGcp6wGglI38UxoybFQzO0IU1ERdYJz8E7VKUD/3KDAeL8HgqPVLbRxh1Z+652WTAjYrdxaujzJhj8C2qNTTeD2f2q9EQiiTABj94iKujXwKLAvqAUbdevYkz+gj0S0fFCdlvwkQME70yZscWLM8P2P0zRcOfzd6IYto8M4KqWrEpw/FSCWDVSfU6py1fCeH/b1+wI5w3GZJXRfjRg33Jw1ZwRuu+xzbz6WrekF47CGd/LTpDsPLZu4DGQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b6fb660-30b7-43f8-e54f-08dbebb1f2d9
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5143.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 23:22:52.0957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yBHIpEPtdR4rUf6PI2IO0InFj9VcREj0k6qlHseVx5ZxVPnDvdzUCwmKowYgZLswnGwytEDtaGAOuj2F4ZGqPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6329
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-22_18,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311220171
X-Proofpoint-GUID: ISMMH8ef5E1BH3g2vbg9hinQF5Awi45u
X-Proofpoint-ORIG-GUID: ISMMH8ef5E1BH3g2vbg9hinQF5Awi45u

--------------A6No1uG0ryMyssgq3Q9GuZ3p
Content-Type: multipart/mixed; boundary="------------uYl0G1NiorDdBp0DUYNvvyEh";
 protected-headers="v1"
From: Calum Mackay <calum.mackay@oracle.com>
To: Cedric Blancher <cedric.blancher@gmail.com>,
 Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Cc: Calum Mackay <calum.mackay@oracle.com>
Message-ID: <675f848b-c838-4462-8c69-a670a2922f34@oracle.com>
Subject: Re: TCP_KEEPALIVE for Linux NFS client?
References: <CALXu0Uc7zHasg2damr4nhRZZF7xBbFc0ghdjop87+5vHa8bBHg@mail.gmail.com>
 <CAN-5tyFBZibge52iZtjnz5j6S2GrTXTWdzaDxLVQcr+G8HegvQ@mail.gmail.com>
 <CALXu0UfiCrcDciLX5A1tvG0DiPwAXPg=GikPakKW16UhZ4X-Nw@mail.gmail.com>
 <d18ee0e1-c52d-48af-acc0-366bd27764c1@oracle.com>
 <CALXu0Ucy4qK1T9-WMssYaxSvhSBSyyxiwP2sjLgMD_wXQs43Qw@mail.gmail.com>
In-Reply-To: <CALXu0Ucy4qK1T9-WMssYaxSvhSBSyyxiwP2sjLgMD_wXQs43Qw@mail.gmail.com>

--------------uYl0G1NiorDdBp0DUYNvvyEh
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjIvMTEvMjAyMyAxMToxMCBwbSwgQ2VkcmljIEJsYW5jaGVyIHdyb3RlOg0KPiBPbiBU
aHUsIDIzIE5vdiAyMDIzIGF0IDAwOjAzLCBDYWx1bSBNYWNrYXkgPGNhbHVtLm1hY2theUBv
cmFjbGUuY29tPiB3cm90ZToNCj4+DQo+PiBoaSBDZWQsDQo+Pg0KPj4gT24gMjIvMTEvMjAy
MyAxMDo0OCBwbSwgQ2VkcmljIEJsYW5jaGVyIHdyb3RlOg0KPj4+IE9uIE1vbiwgMjAgTm92
IDIwMjMgYXQgMDM6NTcsIE9sZ2EgS29ybmlldnNrYWlhIDxhZ2xvQHVtaWNoLmVkdT4gd3Jv
dGU6DQo+Pj4+DQo+Pj4+IEhpIENlZCwNCj4+Pj4NCj4+Pj4gV2h5IGRvIHlvdSB0aGluayBp
dCBkb2Vzbid0IHVzZSBpdD8gSGF2ZSB5b3UgbG9va2VkIGF0IGEgbmV0d29yayB0cmFjZQ0K
Pj4+PiBvZiBhbiBpZGxlIGNvbm5lY3Rpb24/IEkgc2VlbSB0byByZWNhbGwgc2VlaW5nIGtl
ZXAtYWxpdmUgYmVpbmcgdXNlZC4NCj4+Pg0KPj4+IFdlbGwsIEkgZG9uJ3Qgc2VlIGEgc2V0
c29ja29wdChUQ1BfS0VFUEFMSVZFKSBpbiB0aGUgbGlidGlycGMgY29kZT8NCj4+DQo+PiBX
ZSBoYXZlIHRoaXMsIGluIHRoZSBrZXJuZWwgUlBDIGNvZGU6DQo+Pg0KPj4gICAgICAgICAg
aHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvbGF0ZXN0L3NvdXJjZS9uZXQvc3Vu
cnBjL3hwcnRzb2NrLmMjTDIyNTcNCj4+DQo+PiB3aGljaCBtaWdodCBiZSBpdC4NCj4gDQo+
IFlheSwgQnV0IGhvdyBkb2VzIHRoZSBrZXJuZWwgZ2V0IHRoZSBmZCBmcm9tIGxpYnRpcnBj
Pw0KPiANCj4gQWxzbywgaG93IGNhbiBJIHR1cm4gdGhpczoNCj4gDQo+IC8qIFRDUCBLZWVw
YWxpdmUgb3B0aW9ucyAqLw0KPiBzb2NrX3NldF9rZWVwYWxpdmUoc29jay0+c2spOw0KPiB0
Y3Bfc29ja19zZXRfa2VlcGlkbGUoc29jay0+c2ssIGtlZXBpZGxlKTsNCj4gdGNwX3NvY2tf
c2V0X2tlZXBpbnR2bChzb2NrLT5zaywga2VlcGlkbGUpOw0KPiB0Y3Bfc29ja19zZXRfa2Vl
cGNudChzb2NrLT5zaywga2VlcGNudCk7DQo+IA0KPiAvKiBUQ1AgdXNlciB0aW1lb3V0IChz
ZWUgUkZDNTQ4MikgKi8NCj4gdGNwX3NvY2tfc2V0X3VzZXJfdGltZW91dChzb2NrLT5zaywg
dGltZW8pOw0KPiANCj4gaW50byBzZXRzb2Nrb3B0KCkgZnJvbSB1c2VybGFuZCBjb2RlPyBE
b2VzIHRoZSBCU0Qgc29ja2V0IGxpYnJhcnkgaGF2ZQ0KPiBzdWNoIG9wdGlvbnM/DQoNCldo
YXQncyB0aGUgdXNlcmxhbmQgYXNwZWN0IGhlcmU/IEZvciBORlMsIHRoZSBrZXJuZWwgUlBD
IGNvZGUgb3ducyB0aGUgDQpzb2NrZXQsIGFuZCBzZXRzIHRoZSBzb2NrIG9wdGlvbnMuDQoN
CllvdSBjYW4gc2VlIHdoZXRoZXIgVENQIGtlZXBhbGl2ZSBpcyBlbmFibGVkLCB3aXRoIHRo
ZSBmaW5hbCBjb2x1bW4gb2YgDQpuZXRzdGF0IG91dHB1dDoNCg0KZ2V0eiAkIG5ldHN0YXQg
LW5lb3BhIHwgZ3JlcCA6MjA0OQ0K4oCmDQp0Y3AgICAgICAgIDAgICAgICAwIDE5Mi4xNjgu
MjU0LjI6NDk4MDIgICAgIDE5Mi4xNjguMjU0Ljc6MjA0OSANClRJTUVfV0FJVCAgIDAgICAg
ICAgICAgMCAgICAgICAgICAtICAgICAgICAgICAgICAgICAgICB0aW1ld2FpdCAoMzcuNTIv
MC8wKQ0KdGNwICAgICAgICAwICAgICAgMCAxOTIuMTY4LjI1NC4yOjcyMiAgICAgICAxOTIu
MTY4LjI1NC43OjIwNDkgDQpUSU1FX1dBSVQgICAwICAgICAgICAgIDAgICAgICAgICAgLSAg
ICAgICAgICAgICAgICAgICAgdGltZXdhaXQgKDM3LjUyLzAvMCkNCnRjcCAgICAgICAgMCAg
ICAgIDAgMTkyLjE2OC4yNTQuMjo5NzkgICAgICAgMTkyLjE2OC4yNTQuNzoyMDQ5IA0KRVNU
QUJMSVNIRUQgMCAgICAgICAgICAzNTIxNCAgICAgIC0gICAgICAgICAgICAgICAgICAgIGtl
ZXBhbGl2ZSAoOC40Ny8wLzApDQoNCmNoZWVycywNCmNhbHVtLg0KDQo+IA0KPiBDZWQNCj4g
DQo+Pg0KPj4gY2hlZXJzLA0KPj4gY2FsdW0uDQo+Pg0KPj4+DQo+Pj4gQ2VkDQo+Pj4NCj4+
Pj4NCj4+Pj4gT24gRnJpLCBOb3YgMTcsIDIwMjMgYXQgODowMuKAr1BNIENlZHJpYyBCbGFu
Y2hlcg0KPj4+PiA8Y2VkcmljLmJsYW5jaGVyQGdtYWlsLmNvbT4gd3JvdGU6DQo+Pj4+Pg0K
Pj4+Pj4gR29vZCBtb3JuaW5nIQ0KPj4+Pj4NCj4+Pj4+IFdoeSBkb2VzIHRoZSBMaW51eCBO
RlMgY2xpZW50IG5vdCB1c2UgVENQX0tFRVBBTElWRSBmb3IgaXRzIFRDUA0KPj4+Pj4gY29u
bmVjdGlvbnM/IFdoYXQgYXJlIHRoZSBwcm8gYW5kIGNvbnMgb2YgdXNpbmcgdGhhdCBmb3Ig
TkZTIFRDUA0KPj4+Pj4gY29ubmVjdGlvbnM/DQo+Pj4+Pg0KPj4+Pj4gQ2VkDQo+Pj4+PiAt
LQ0KPj4+Pj4gQ2VkcmljIEJsYW5jaGVyIDxjZWRyaWMuYmxhbmNoZXJAZ21haWwuY29tPg0K
Pj4+Pj4gW2h0dHBzOi8vcGx1cy5nb29nbGUuY29tL3UvMC8rQ2VkcmljQmxhbmNoZXIvXQ0K
Pj4+Pj4gSW5zdGl0dXRlIFBhc3RldXINCj4+Pg0KPj4+DQo+Pj4NCj4+DQo+PiAtLQ0KPj4g
Q2FsdW0gTWFja2F5DQo+PiBMaW51eCBLZXJuZWwgRW5naW5lZXJpbmcNCj4+IE9yYWNsZSBM
aW51eCBhbmQgVmlydHVhbGlzYXRpb24NCj4+DQo+IA0KPiANCg0KLS0gDQpDYWx1bSBNYWNr
YXkNCkxpbnV4IEtlcm5lbCBFbmdpbmVlcmluZw0KT3JhY2xlIExpbnV4IGFuZCBWaXJ0dWFs
aXNhdGlvbg0KDQo=

--------------uYl0G1NiorDdBp0DUYNvvyEh--

--------------A6No1uG0ryMyssgq3Q9GuZ3p
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEE1GBbrQYgx8o9Vdw+hSPvAG3BU+IFAmVejUkFAwAAAAAACgkQhSPvAG3BU+II
9g/+MmYnm+b7xwkhL53PCWVMnIITgE/1kUGmhY58cktQCPPf4BvfGZuEdsiGJDLsFZDTfvSqN9Ds
KxFpfxb4UpnvcsyGhz8IfYVJZhU/z13xrDMwEz/vM6HO84QsYklI9n9u1/JYKS3nSPoQnkvTp3Q1
ozatA5LC1ftDYx5p0VEfRVe1WVbC7ufaksfhH01rUuJf1rKy3gGP04ZfuHcEilZhINRJ8PoSCVKc
IfI9rf4Znw3C7cAxUhshR0elbqJcTYp+bJHqmZb2ES4eDvsBFGlX9oo5k5fpXRMUX5j4UWN/mVWO
0klO+8C63C9SYH+risfScuBySkopHnht4ObEExoBD7CMaFk20xiH2Ncr3u2yXb2t5hliGYArLuUq
NWqhrMTUffkQi8nKQ0xHLoWOksXpqu1438EQZTKiCQG2l4qKVFyJGTJqza0cDrwUB4Q4SOmg/ANP
niQUlVX3ib155dSOqH7HIFswfUq5RL6J9ZEarZc5kEQ8tziP2vU/BVKxWnsh70yfHa3fBG/lQ3Hf
AiILj0aDU1jYP64qso9c1UOd43cXmu2BAT309lmIvu2I+cC8Gq0kQIx8AdcGVicK8Lu3JXAYbBRf
045FsZ814lJD04T/LsZwBCMynxbLYzf2Ezbmg+vQvWDSWuLnzYdxiy2UcB4NnJSR7luojWvyYSbK
dME=
=niEV
-----END PGP SIGNATURE-----

--------------A6No1uG0ryMyssgq3Q9GuZ3p--

