Return-Path: <linux-nfs+bounces-1429-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED77683CD64
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jan 2024 21:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0631A1C24F2A
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jan 2024 20:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B31137C54;
	Thu, 25 Jan 2024 20:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iIwJqeOK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yi4QXHsJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24CF135412
	for <linux-nfs@vger.kernel.org>; Thu, 25 Jan 2024 20:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706214314; cv=fail; b=KoHDWHda3CyqGp/Bkzkg2rSoosvnhm/M+Pg4rikB1kvCerwWvbg8jhgekPByLxTIPM6Msv85XnDPmt+cGyECJfkLVLyqIdIDShe9Xe08Yua/upBVk0eqLojAmgHVkzZP96p3zWx6I6FlcYoJKd+5NhOSWtUyGBqKttztyRYeV0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706214314; c=relaxed/simple;
	bh=7m+/u9ClgJ0PS3hy/SMonmce65HDv+mz4Wpb0WpRFDQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TPZrCt9eFqt9jlwwH5vxERL/NY+OB4ElOmnh68a9qA56wqfEtJtkTb2NiG9z+yAq4yTVEphE56toBaM0t4llzTHyjTif1AY0tOPAnP4wIlJh8uW7dgH0TpVpzqcUJQY450fJISDQQ4icP4oVPJG6FNtkDVt3Ev/L5QK6PenmuJU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iIwJqeOK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yi4QXHsJ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40PK4LHL009439;
	Thu, 25 Jan 2024 20:25:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=7m+/u9ClgJ0PS3hy/SMonmce65HDv+mz4Wpb0WpRFDQ=;
 b=iIwJqeOKuVjmY42trN+wBKIJTwNSl2uHXCClBU+wsdwRxtHE+h+xyVPb0Q2p6bbWtm7c
 sy2GaW4umih9pWim9Y6ev4eU6JTv2tu6amo7iIlARgUZZywWgYBxwD/uOYZveynASEKx
 HPUzLJyd4qzJw5gxj7p9y+WMYWzyyfXzzzx6FgYnUZL1eOMFiSBTxOVJAHc7P0n+TfPm
 RJMKZuE1FEjb+pklOwrwSKHeeQrP8AFEqmfrIzk1kW/K1kwYlRuNNN3+TiAAct+zbAS4
 r51ZDC8Be/onV4xfIgPzZKtTtoQunSlCkXP84mhk+AMNwwu2aI8LBKSGJzgZZaluejE5 KQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr79nrcx9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Jan 2024 20:25:01 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40PK789x025999;
	Thu, 25 Jan 2024 20:25:00 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vs319e0av-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Jan 2024 20:25:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jg9MQxNbaUdr2V5aRios0kXYNtPGjs0nOQP57B4Lt1s1cxK1eBEqqWBV2t7kAuFFNBN5wVq+bRFqmY+vtzuc81m8f7qBtlFJZyt915RLqLfYwD8KCSzfSGABl4YeImRf8k1s/ke+0Gj6whiJ6vVuWD/V2RSEIoBuaTBLKPMp24Nvfmd/7g+fjmOVJoy8jBimnHpCff5Ul6ZtaCCKKYm+Ppd7rqaE6jW77dBakB6a56gStFj19iL5tZe8ojLpvahYwWajKp5dVCGs61y//Yz/8p/8JT1gXhxJtmU0rzuzY9QDOLZROPmdkGSR0wBH3gOH2n8oZl9Tj6tbxGQlFxrlBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7m+/u9ClgJ0PS3hy/SMonmce65HDv+mz4Wpb0WpRFDQ=;
 b=XE4sR8rA/QnJIv5ux3xXs/zz8oN+o3f3szjazY3ZhifJfZEmDn3O/udUc/VFCZP4TUthGl65Wwc9QzRRDEEK9WKlsQzBkI4GFWZvF7iRl89fzVv7MOvjImsHK4VZBPjD5/cYGa6qm2ycW9yno/vovpOH8dbDBU3ChuU8shURR5LPo6OuYRbBXcQ8nr2DFz6O5Lfqw9ge7wQqwmWZ/FMNLCrmdI4Ff5ux+YfCdu+SXl46jxqDEKYi7JLxlE06YIYG7uAbVnCL//UdBxyyB3lF24PL/xdEI//Q1+w2RLVe1lnDLDq0mGYFq2UYQDeVKpguGuRYdekaoCURtC1PSkfw/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7m+/u9ClgJ0PS3hy/SMonmce65HDv+mz4Wpb0WpRFDQ=;
 b=yi4QXHsJLg354xDTfcLP2ybq9h2elQOU0jquD+BEWHg3kmTAfDRrdQOw45UUm61TyY9zuTBYJhFGVmDBe6IC77Zt7jWwYvWXRPgF2NkDJKj9b/+4Ya/Ide08smheo/FIk6j9p2qjLRutlnAM9B6qabniDVKLGWSLruUMU/m3E5A=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH0PR10MB5307.namprd10.prod.outlook.com (2603:10b6:610:c0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.24; Thu, 25 Jan
 2024 20:24:57 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5475:bf96:8fdf:8ff9]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5475:bf96:8fdf:8ff9%7]) with mapi id 15.20.7228.026; Thu, 25 Jan 2024
 20:24:57 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Cedric Blancher <cedric.blancher@gmail.com>
CC: Jeff Layton <jlayton@kernel.org>,
        Lorenzo Bianconi
	<lorenzo.bianconi@redhat.com>,
        NeilBrown <neilb@suse.com>, Dai Ngo
	<dai.ngo@oracle.com>,
        Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Tom
 Talpey <tom@talpey.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: Should we establish a new nfsdctl userland program?
Thread-Topic: Should we establish a new nfsdctl userland program?
Thread-Index: AQHaT8Zp476+VGqpskq8+ahQ0OuBVrDq8R0AgAAIaoA=
Date: Thu, 25 Jan 2024 20:24:57 +0000
Message-ID: <66892D4F-4721-48E5-A088-BD75500275AD@oracle.com>
References: <8a7bbc05b6515109692cb88ad68374d14fc01eca.camel@kernel.org>
 <CALXu0UcV0b8OvH7_05tD7+GRgoXRcp9fd1aXuHjtF2OBDPmSJw@mail.gmail.com>
In-Reply-To: 
 <CALXu0UcV0b8OvH7_05tD7+GRgoXRcp9fd1aXuHjtF2OBDPmSJw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.300.61.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CH0PR10MB5307:EE_
x-ms-office365-filtering-correlation-id: 87a99f2d-d600-44a0-f70d-08dc1de3b2e8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 7zyoDK0ih6f3JcTTy1HX1bSxyM7k5SCgUFl0Y0QJxmqorKG0PRE+iLHSfFr2ss9nHda/77Qx1AdBrwEgLm93Yt6ZqECSW+nSeisuQpT4S5pgLd2RNyALyLpJaTDaO9UWulmin26HGxzwTAu15nj//84g5VVz+/j0/YoTswEnO9mf8Jle1EjNZb+npgv4OwIUc7Przr0cmILOEk41ljvI+RO7m38q+oyDa3YjI95+o6MWzLYwxKcdfm8NfBt8HgcxZ4xqkWLd02dkx6emwFT4cgLyBBx1WjxWt884BwQU39eCvNC1SN4mL7dYHIGff4t1lSNyxww97MYyKhoyqBEE9rtgqoMI3vV8tvSTynXnb5Pqr5b4dw4byu/+zSyQShCk0PKlqZRE1kdokOsPrdETOD3/sdOS9+CtFRHSS0mTQEMHNTAzq3GG59qx5etHb4szTn4r/rXZDQD2hg6AFG9wRPN534mF4zMq4iaTL+BaLHQnTIqejKXcJqsFjTXEMY+m2rtXdIF60KSLzQ3vjk8J61K8EDxp4hDbnJ8Q8j5ujNOP4ueNWoV96CSGKO0TNUOi/jsGIk7rHiHXboiHNb4AXNQ8rvMDgNjDDLLQwOglf0q/q6t/Qib6RLQI8HYQDAAMT1cz+gfbBeooxEqQ21DniOUvAR2M25h9JB0G8poybLTqCtLuHWZrljngKmNwA85K
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(39860400002)(396003)(366004)(376002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(33656002)(83380400001)(38100700002)(2616005)(26005)(66476007)(54906003)(5660300002)(41300700001)(66946007)(66446008)(91956017)(122000001)(76116006)(64756008)(2906002)(6506007)(6916009)(316002)(8676002)(8936002)(4326008)(66556008)(6512007)(53546011)(6486002)(478600001)(71200400001)(966005)(38070700009)(36756003)(86362001)(40753002)(133343001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?YkR2a3AzQkhwbXArbTN1cWNmK3NlUFlaNEpQb0V1VFJEN2c1bE00bS9jZXF5?=
 =?utf-8?B?VnJtaHY1YnBvYkViM1ZEcXpOOW1uUDZUNmYzZGE3S1V2R09aR2ZUWlh6SFMv?=
 =?utf-8?B?RlBXdDVmWlBQQkhOMm5oSVNXVWczV1Q4cS9aRkUvcFprdW9MNkFmQ0Yzc0l2?=
 =?utf-8?B?Z29VSjNzS0g4b1MydHcwZHlBT2VCM211MUZTS2lPb1MwNjZsY01tUDhKQ1U3?=
 =?utf-8?B?UytUc2pkWUUxV2l3VTJrL1NQMjMwZVVzVWN6VlJkQVRJSEE4RWtDd1BackxO?=
 =?utf-8?B?WDVDd1dJNHZCZVpwV01oVkFHWlBZLzFVTE8zRmpVRFVUN215UWJxMXk5QlBj?=
 =?utf-8?B?cVVTWkhsNXNIU3ZNcW5RYTdoZlpxcnhTdng1d1JieGs4aDVzVjE3WDRhV2or?=
 =?utf-8?B?QksyOWNNS3c4dnp2cDZkeE5sTnBVT1dTSlBUUnhTMzNGUG5tanBTditaang5?=
 =?utf-8?B?bk1IWitETlo4Ym96U2xDdWxJaFVGSWVxT01lUWM3c1BLcVFHZitYck40L1BZ?=
 =?utf-8?B?R3pkVjNTS01ROVdJMnNuNlNhMEl0ZHJzTTBsMDdvajFFWFZGbGNBUjRvbE9x?=
 =?utf-8?B?U3FTVTNoNkV2Zkg2cGNvaEZMYnZSd2QrUmhQdFJpSUVBL01DMU11TkNjdkVG?=
 =?utf-8?B?U1l6MTlwNHlyalJZcGxjbkFIYlV4MHI5UGdIR1BwQ2FZWW5YbHV0UjY4YUdi?=
 =?utf-8?B?KzdhM1ZQL01POWhoZitXVncwNEYvekErNTZlNEVyMmVjbWkxZEJzOFFHVEZ3?=
 =?utf-8?B?b0NuTjVFQXEyK1ErK050dzBMZlpMV1BGVGY4dnNMZ2VrTXhxd09rT2wydGlu?=
 =?utf-8?B?eVNjZ2tOUGNkT3lTZFZzdjIyVjFuZk4wUzBSc0hFK1pHaDFYdkg3ME5MQmVH?=
 =?utf-8?B?c1MxUWV5OWxCc0NxVld6aUlvbVJ2dVZrSG51Q3Z5a3pYOEdmY0F3ZEEyRURW?=
 =?utf-8?B?citNWVIrdDNpeHloenZPd0Q5ZWVxNXR2V3pUTWJJU0pnQ09MUzlCMDhBTVpN?=
 =?utf-8?B?NWs4TXZ2M0k5aFZDZDRNNzcrZitRZHJOU2ZFR3YzZG9NS3ZZUHg1V2pJRjA4?=
 =?utf-8?B?bmU5cDF1VEMvRzQwWk5yN3NLTVo0WUVHRGN5SWkyNDAwVHhlWnBLOUhhZmx5?=
 =?utf-8?B?djZvdTRpZTJnOFMxRE9Hd2FOM0t1TVdobERnUDl5Mm0rU1QzUkF0TVR4ZktO?=
 =?utf-8?B?MzBUK2g3d0QrRVNwaUZGVHlVRWo2clhPNFd2TGJzY0tSUTdOWU1VMGNuWGF1?=
 =?utf-8?B?MnJxRldob0xOdHM2MW1DeFlHRTBleWdadW9pRTJlakI2b2tHYjRUcUVwU3FV?=
 =?utf-8?B?T29OMUlXZU5OL0Z1RzhON0FoYnMwbUNiVHFHWXZHTWdINUgvMUhQQWwxUHhZ?=
 =?utf-8?B?MkgyNzJ0T0NjSW5EVmZGN0lWREg2WU1OeGRoSTlhOHRlQlpvNmFtUXdMUFcy?=
 =?utf-8?B?NURwdjdNVE5OVWFyaUdNbDVsbk9GVk1xSHFtWU95ZnhHNFk2cnRjbUg3VFB6?=
 =?utf-8?B?UjJvcktvb1RVa1Zic3JZUExYWTB4T2JxQUUxck4zbFVnUkdxTnhmZmpUTGhs?=
 =?utf-8?B?Z2krMzhhL1Z0RnRvNnZjdTR2M3NZRXplWFZUaG1XUXZMYkE4QlBwQzRwMW1G?=
 =?utf-8?B?Y3pOVm5PZ3NhRzc0VERxd05Oc2pvK2k3Z3JxbE1pVnhOak5YZFU2SURTa0Z6?=
 =?utf-8?B?TysrZHNnaG1wY3RPK09yM2lYaFN6dzFLN3ZTbWh3dzViQnN3VDdWWmU5QXdl?=
 =?utf-8?B?R1RxQlR0emJGeTMwZUN1eGJEdnVVZy9sZDZXc1ptZGdYbnU1THRVdDRxK3Fl?=
 =?utf-8?B?ZkN4QlAzc3hPa1RHUXpLbEwwWVIxbzF3RUlZbHNGdjRNclRrQk1Xc1gzWHdx?=
 =?utf-8?B?L0lTOXpaRnVFaGxqSjRrUjhreXByN3RieW1WVkZud081T2dWRGdGY0V0cHdG?=
 =?utf-8?B?VE9XYWZIcDdoa3BuWU1HdnJKaE55RW1xWXZPMG1NOU4rNGkxUWpnb1RCWEdQ?=
 =?utf-8?B?cDhhWTNuUDhtT0h5UnJWVG5ZWk05UTMvc2hQSHhjOTNLcXhXditEMVN2eVhq?=
 =?utf-8?B?WDBUcGNEdUgrYmZObmlPUjhkWkNXbVE0OTRJckd5M284d2RPSWcrQnd4UGFD?=
 =?utf-8?B?L2xWYmdUeXd1MDRIaWZSRisyV2pERXRXbDMrcFBaTnBzR3lsZkUrTEs2TU1a?=
 =?utf-8?B?Wnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CA6E2FD94DC13640AC70ED6D10D423B1@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	8x02BPJ8Ot3UOfypAAvEh7Vr//R6RI6y17xRhuQlFsyVnAxAvh1iqi9kBgWRevJ1Bg7S+e923Lvj1BHWeKb23AyjaHmT8pR2l82C5F3z+ZTyff1q+oORTmiL4BZaA3UpegJEq4YDVAaNx2OaDXGYSlIaIo9ZS5qRO+ZD3gDzqhGBdlEoJNs6WyF+ZuXHc/NaDdEOANF5HF+UvAR/mN61Qr41aKCP6iwa1Af6BHMO+S7pQhqho1QW14pX8XL5rmfVWiCmoVmyfTug6Afg+OouonBjytUaiXmwfqufcN66gZmPwRWdm5VV8n4c/b6BxJ9jQfyA7SQj5wm1dqc2wT0F69YfASxaB0at5gWmrtkY15qzCWDEtALmsZXKqCO0fl+yeXsNsUWm81PDYPEG9rLfxVJ6fEsLwfp4Y9Jsawr7FTVRp+Dnx4Qaf/zPuOlOppq1qfCHtZc0PBrFmLjsWteW1KCexmx9mgKOP0a7m62BUD42aLkQaYGjsnsNOfCqAqx5qTuv8F4/oZJcxHgtaaJg1QZHGe80DVE7fn3cvhd1vgjBuxoetWmIBjSYgKpDFrxcYl68npiDGcM2hymER7y+HujLAQk4Flu5b/iwSUcmFSo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87a99f2d-d600-44a0-f70d-08dc1de3b2e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2024 20:24:57.5649
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J8/a+baWcYKMWsLfWgGqmuHuicaihs9E/euAs7Bj76PBuLj9rMLQvc/6jn4kigb2+p3EQ0eXSQyd9qpTFx1szg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5307
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_12,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401250147
X-Proofpoint-GUID: ZNkfodKpGEqMkR4kGarSqth4V-eF15xI
X-Proofpoint-ORIG-GUID: ZNkfodKpGEqMkR4kGarSqth4V-eF15xI

DQoNCj4gT24gSmFuIDI1LCAyMDI0LCBhdCAyOjU04oCvUE0sIENlZHJpYyBCbGFuY2hlciA8Y2Vk
cmljLmJsYW5jaGVyQGdtYWlsLmNvbT4gd3JvdGU6DQo+IA0KPiBPbiBUaHUsIDI1IEphbiAyMDI0
IGF0IDIwOjQxLCBKZWZmIExheXRvbiA8amxheXRvbkBrZXJuZWwub3JnPiB3cm90ZToNCj4+IA0K
Pj4gVGhlIGV4aXN0aW5nIHJwYy5uZnNkIHByb2dyYW0gd2FzIGRlc2lnbmVkIGR1cmluZyBhIGRp
ZmZlcmVudCB0aW1lLCB3aGVuDQo+PiB3ZSBqdXN0IGRpZG4ndCByZXF1aXJlIHRoYXQgbXVjaCBj
b250cm9sIG92ZXIgaG93IGl0IGJlaGF2ZWQuIEl0J3MNCj4+IGtsdW5reSB0byB3b3JrIHdpdGgu
DQo+PiANCj4+IEluIGEgcmVzcG9uc2UgdG8gQ2h1Y2sncyByZWNlbnQgUkZDIHBhdGNoIHRvIGFk
ZCBrbm9iIHRvIGRpc2FibGUNCj4+IFJFQURfUExVUyBjYWxscywgSSBtZW50aW9uZWQgdGhhdCBp
dCBtaWdodCBiZSBhIGdvb2QgdGltZSB0byBtYWtlIGENCj4+IGNsZWFuIGJyZWFrIGZyb20gdGhl
IHBhc3QgYW5kIHN0YXJ0IGEgbmV3IHByb2dyYW0gZm9yIGNvbnRyb2xsaW5nIG5mc2QuDQo+PiAN
Cj4+IEhlcmUncyB3aGF0IEknbSB0aGlua2luZzoNCj4+IA0KPj4gTGV0J3MgYnVpbGQgYSBzd2lz
cy1hcm15LWtuaWZlIGtpbmQgb2YgaW50ZXJmYWNlIGxpa2UgZ2l0IG9yIHZpcnNoOg0KPj4gDQo+
PiAjIG5mc2RjdGwgc3RhdHMgICAgICAgICAgICAgICAgIDwtLS0gZmV0Y2ggdGhlIG5ldyBzdGF0
cyB0aGF0IGdvdCBtZXJnZWQNCj4+ICMgbmZzZGN0bCBhZGRfbGlzdGVuZXIgICAgICAgICAgPC0t
LSBhZGQgYSBuZXcgbGlzdGVuIHNvY2tldCwgYnkgYWRkcmVzcyBvciBob3N0bmFtZQ0KPiANCj4g
QWJzb2x1dGVseSBOT1QgImhvc3RuYW1lIi4gUGxlYXNlIGRvIG5vdCByZXBlYXQgdGhlIG1pc3Rh
a2UgQUdBSU4gb2YNCj4gc2VwYXJhdGluZyAiaG9zdCBuYW1lIiBhbmQgIlRDUCBwb3J0IiwgYXMg
dGhleSBhcmUgYm90aCByZXF1aXJlZCB0bw0KPiBmaW5kIHRoZSBzZXJ2ZXIuIEV2ZXJ5IDEwIG9y
IDE1IHllYXJzIHRoZSBzYW1lIG1pc3Rha2UgaXMgbWFkZSBieSB0aGUNCj4gbmV4dCBnZW5lcmF0
aW9uIG9mIHNvZnR3YXJlIGVuZ2luZWVycy4NCg0KSSBkb24ndCBzZWUgaG93IHRoaXMgaXMgYSBt
aXN0YWtlLg0KDQo+ICAgcG9ydA0KPiAgICAgIFRoZSBwb3J0IG51bWJlciB0byBjb25uZWN0IHRv
LiBNb3N0IHNjaGVtZXMgZGVzaWduYXRlDQo+ICAgICAgcHJvdG9jb2xzIHRoYXQgaGF2ZSBhIGRl
ZmF1bHQgcG9ydCBudW1iZXIuIEFub3RoZXIgcG9ydCBudW1iZXINCj4gICAgICBtYXkgb3B0aW9u
YWxseSBiZSBzdXBwbGllZCwgaW4gZGVjaW1hbCwgc2VwYXJhdGVkIGZyb20gdGhlDQo+ICAgICAg
aG9zdCBieSBhIGNvbG9uLiBJZiB0aGUgcG9ydCBpcyBvbWl0dGVkLCB0aGUgY29sb24gaXMgYXMg
d2VsbC4NCg0KTkZTIGhhcyBhIGRlZmF1bHQgcG9ydCBudW1iZXIuIFRodXMsIGV2ZW4gUkZDIDE3
Mzggc3RhdGVzIHRoYXQNCiJob3N0bmFtZSIgaXMganVzdCBmaW5lLiBJdCBtZWFucyAiRE5TIGxh
YmVsIGFuZCBkZWZhdWx0IHBvcnQiLg0KDQpNb3N0IHVzYWdlIHNjZW5hcmlvcyB3aWxsIHByZWZl
ciB0aGUgc2hvcnRoYW5kIG9mIGxlYXZpbmcgb2ZmIHRoZQ0KcG9ydC4gU28gZW5naW5lZXJzIHNl
ZW0gdG8gYmUgZGVzaWduaW5nIGludGVyZmFjZXMgZm9yIHRoZSBtb3N0DQpjb21tb24gdXNhZ2Us
IGRvbid0IHlvdSB0aGluaz8NCg0KDQo+IGh0dHBzOi8vZGF0YXRyYWNrZXIuaWV0Zi5vcmcvZG9j
L2h0bWwvcmZjMTczOCBjbGVhcmx5IGRlZmluZWQNCj4gImhvc3Rwb3J0IiwgYW5kIHRoYXQgaXMg
d2hhdCBzaG91bGQgYmUgdXNlZCBoZXJlLg0KDQpSRkMgMTczOCB3YXMgcHVibGlzaGVkIHZlcnkg
Y2xlYXJseSBiZWZvcmUgdGhlIHdpZGVzcHJlYWQgdXNlIG9mDQpJUHY2IGFkZHJlc3Nlcywgd2hp
Y2ggdXNlIGEgOiB0byBzZXBhcmF0ZSB0aGUgY29tcG9uZW50cyBvZiBhbg0KSVAgYWRkcmVzcy4N
Cg0KQ2VydGFpbmx5IHRoZSBhZGRfbGlzdGVuZXIgc3ViY29tbWFuZCBjYW4gdGFrZSBhIHBvcnQs
IGJ1dCB0aGVyZSdzDQpwbGVudHkgb2Ygcm9vbSB0byBhZGQgdGhhdCBpbiBvdGhlciB3YXlzLg0K
DQpGb3IgZXhhbXBsZSwgd2UgbWlnaHQgd2FudDoNCg0KIyBuZnNkY3RsIGFkZF9saXN0ZW5lcg0K
DQogICB4cHJ0IDx1ZHB8dGNwfHJkbWE+DQoNCiAgIGhvc3QgPEROUyBsYWJlbD4gIHwgICBhZGRy
IDxJUHY0IG9yIElQdjYgYWRkcmVzcz4NCg0KYW5kIG9wdGlvbmFsbHkNCg0KICAgcG9ydCA8bGlz
dGVuZXIgcG9ydD4NCg0KSWYgcG9ydCBpcyBub3Qgc3BlY2lmaWVkLCB0aGUgZGVmYXVsdCBwb3J0
IGZvciB0aGUgeHBydCB0eXBlDQppcyBhc3N1bWVkLiAoZWcsIDIwNDkgb3IgMjAwNDkpDQoNCkV2
ZW50dWFsbHksIGFsc286DQoNCiMgbmZzZGN0bCBkZWxfbGlzdGVuZXIgLi4uIHdpdGggc2ltaWxh
ciBhcmd1bWVudHMNCg0KLS0NCkNodWNrIExldmVyDQoNCg0K

