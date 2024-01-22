Return-Path: <linux-nfs+bounces-1279-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B378377A6
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jan 2024 00:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D64272817A9
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jan 2024 23:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA654C632;
	Mon, 22 Jan 2024 23:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FkV6WTUo";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Kp7sgWC5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33E14C3DC
	for <linux-nfs@vger.kernel.org>; Mon, 22 Jan 2024 23:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705965550; cv=fail; b=rG/V1TCUbq/FuE/85mw9VLgR48ROvifh+MEW0aIzRnCNEiLW9sKzQovH6zSya/DfZtGVVrGgkwBjv18jqqCycSd3HNt+xAz21PRvj/YwBeHx6NiiMkAEN60k/VPwX/Vol/+i2JirgQcxeow/ePJwUEaog+P3s3WwWlwznd8MMF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705965550; c=relaxed/simple;
	bh=J76xB/LzMQrVTSC6viHua8XjKrbHux04GDVIY4vLy74=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tNkmdx8xx6LTYUDu+frcC3QpmzG1guaoRP0A+Y4mUDs/jNobybyE6xE4X1p1EfNXhO65RHqn3Jt1bsRPkC5N8Xx46Py19R1Sbv4D+8x3E3By03TM9tVtwkeUvfJIhnYMnZf63NDezXrk+PvZkquT+P1lZHbZgQ9GZ9yS57VNNwM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FkV6WTUo; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Kp7sgWC5; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40MMopQ3026489;
	Mon, 22 Jan 2024 23:18:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=J76xB/LzMQrVTSC6viHua8XjKrbHux04GDVIY4vLy74=;
 b=FkV6WTUo+uwSnn/xBwKgn6sOV7hFpQkigtQt0d1DEsYifjqmrHLoXkI2YPn98/cgbiib
 Hn+12Aa+oZyR7UbzxqLvl+BhMvzoafbd9Uh2lw/t0pa5a2T8ozpfzP9/sJaAMNWWD4QG
 sBry9oXtg4rVq8BnU9Ti+Zd+lAAtCjxpz9VjdPNxLfuseOPI7a80uTUj66Ln5EmOd3WZ
 oVnBRz6Rm/iTuGYtLoJ1mVUbWgRBv+7Lgj/pRhwIXx3r285NPO7dlyG7cXE0P2AseVcb
 XPs8urta5VhaFT3WcCauXpiXUZQ9ll7vLW5VNxfCEA1NVKTVxr+L48AXycrIId1NcV/p HQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr79vvx0h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jan 2024 23:18:55 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40MMhgXg025394;
	Mon, 22 Jan 2024 23:18:45 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vs33s16nf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jan 2024 23:18:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nY+iF1REAM8LfdPIE2//dDnXR3XWgyC6VVY4REaknLXlyNqlyBndh3hL1f35WqnKyQjbxkUev46JT+vdd4NHydZib1Q8aLSZNUwWiMneDGeim4+NAkEzcHr1TAF4NJuPwEStpoZFbYoGATuhcwI1UJGjHZ7G1sjML8O6vA6bWASLph03URTiKaNnGYNh2g2ui1KZzrSvjbE9M0LZlSY08f+3jv+8M87qO1DXxBrYWx1HVU6f7rNJm/4paNOyRU/TPNwRS4IUNLzSnuNzKdXPRhj8qhsqRlcFPsUWzrbmWVx0QYN6dzzBjKYoueh1Gt8kZnQK7VB8jfAKSIy8/XyJow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J76xB/LzMQrVTSC6viHua8XjKrbHux04GDVIY4vLy74=;
 b=m9F90+2PstljgZUBdqjdiw7AqayN/MN4rRa3tFeqSIbgBhF//Cd5Obt6NZXPCYyYQyvtEuGmQiZ3wBeWX72UotrQV8I51VKIT7Af5tkB8slFpXzSPDoKyiKfMjwBD9sfQmsky5CRPQVF+q5f7qdLX88q+H872N5h32Dm6xxB29K3a/L+TO9ryW6jhZ49vbSs977RChAEzwALxIkeAIOXrhK+4vCfyJY5liArYU2j6z/hqb+ZMT2C34HWIsPMV7yDfIjM/UrZIMEeta/0PJ9NduDBda1Lp0ZAQH5GDcVsa9MosPBiueh24k0BFUzQrT2rV4xmp2sjUUwRVIiqjWndSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J76xB/LzMQrVTSC6viHua8XjKrbHux04GDVIY4vLy74=;
 b=Kp7sgWC5XtYHUc9ZSOT9Gsk8mIfWx/hLN0NbiPuoFMXGXdI+5KPWDYB+4AVu3lqDJ2QQapzVNBKJRqNVFJdPG4une+ZGPpN/pwzzlOREoSi5MNlzEjqHTfZ5PLpd76hwPqTRyuPNq2e9whurbwCAQLP1NrmdS/4KSUliDrcBDHU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH8PR10MB6573.namprd10.prod.outlook.com (2603:10b6:510:227::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.30; Mon, 22 Jan
 2024 23:18:43 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5475:bf96:8fdf:8ff9]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5475:bf96:8fdf:8ff9%6]) with mapi id 15.20.7202.035; Mon, 22 Jan 2024
 23:18:43 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Neil Brown <neilb@suse.de>
CC: Jeff Layton <jlayton@kernel.org>, Dai Ngo <dai.ngo@oracle.com>,
        Olga
 Kornievskaia <kolga@netapp.com>, Tom Talpey <tom@talpey.com>,
        Linux NFS
 Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfsd: fix RELEASE_LOCKOWNER
Thread-Topic: [PATCH] nfsd: fix RELEASE_LOCKOWNER
Thread-Index: AQHaTOdBtLll/fA4n0ueXAr70m4RmrDl5I+AgAB9jYCAABWSgIAAASaA
Date: Mon, 22 Jan 2024 23:18:43 +0000
Message-ID: <CBFBF8A8-4136-45F3-A8F3-C430A417795C@oracle.com>
References: <170589589641.23031.16356786177193106749@noble.neil.brown.name>
 <Za57adpDbKJavMRO@tissot.1015granger.net>
 <170596063560.23031.1725209290511630080@noble.neil.brown.name>
 <3162C5BC-8E7C-4A9A-815C-09297B56FA17@oracle.com>
In-Reply-To: <3162C5BC-8E7C-4A9A-815C-09297B56FA17@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.300.61.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH8PR10MB6573:EE_
x-ms-office365-filtering-correlation-id: db9b9fc7-7ee4-4151-43f3-08dc1ba079f9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 b/xSa6RWAsU+cM/H9T7uR/MxQePyYmlMtgpmfQ1gXz7Xl1YMcrqEy7Y7LcBm9h4LLFACQ1m8j3rZxqwoNqoLvimNO9F0hcF3U1L6XWCK8eD5rClijBnJQUZhBWFlq8TLRRgHXsWANELm96ud/f5eL6oBBdMMIYQAgBktvpsAW6Z3fVALeQWfL0iqfbify8Pv+8Atzzx52AC2DhXtjZw5jycJTryurin6aCVAE4MuCZ94fQTbFxd0th2mK8acZ7TnIaWk8MgfNFvu4buK11K6EzYFfjw0nUHBEtuhGBCNpXGXcUvOvQjZYCb+e+bqcnpbP5f0WttM0JiAwjOrA2PxZLvnlaYJOjvC1YoqzkFuQ2Gr7jhUecDtqQBrhFzTAxVM4cBgMMm1IPuy4UjNsryPVFdBqEN9ENKOZttYo+NPctQBBDE4QBNo35teYbOtrbkcE8DiD2i2mLoD4wCijRfNtoDzLxVuxrww2lEwEfP+SRtC/tdjUOl0f7FplvUIIxYxLJtzOr0HFUCKJPh/ZzcigyPnYzEXA6bUXfn9FmKA9ZdLhCqA/wMVVyIyhfSjoMEbLCera00q8p0XqANSmZOO0QA1eF74JKhsf0O7NHBWCl/72PfIu1UKcu+L0w4dhc0+xnyv6wcApgIW66X12mDgfw==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(366004)(39860400002)(136003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(33656002)(86362001)(38070700009)(38100700002)(122000001)(36756003)(26005)(2616005)(83380400001)(66556008)(66946007)(64756008)(66446008)(76116006)(66476007)(6916009)(6486002)(53546011)(8936002)(8676002)(6506007)(6512007)(71200400001)(54906003)(316002)(91956017)(478600001)(4326008)(5660300002)(2906002)(41300700001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?ZGE1V1QrYWhGRWxWbWZVVEprdm81RnJ6eTFFTzBOL1pHNFl1ZEg0NS9sNXly?=
 =?utf-8?B?S1g1ZDI1RG5RekZxRUxjZjNwTVc0bnhndzRUaWR2SHF4Y20wbGNzRzlpZmYv?=
 =?utf-8?B?Z2pNNXFwbitEVzQvbmtyL0xOdEh0M1R5QUY5cjhIYnRVU2VVeDRMblBRMThV?=
 =?utf-8?B?bjhRcHE0Y3MvV1ZMT2s5Qk0wNTJzdENhOXFlWVN0VzVsZG9qdE55eVdXQW50?=
 =?utf-8?B?cFkzK29aZHFPNE9BRFF1Y3NXR3dIWjRuTXJVaEYxL0w3aDg2M2wweDkxK2Ri?=
 =?utf-8?B?NFpTb0M4QzFxSGxmUlVURUNJL1BIcmVVNW1sQTJyVE03SXA2dUdvbUtkdVRz?=
 =?utf-8?B?RzIwUkJxZGFMQWlWVlpqeFJqQWJtT1J5d2I1U2ZwOS9UNGQ4czgvZXpUM1Nx?=
 =?utf-8?B?TUhhcVlralhmRDlMaUxCKzRObVdyMWtLMWxOSlRGMUxIbENoamlrdGR1U0ZD?=
 =?utf-8?B?RTh3RmJycjM3WTJ0Q2dMbTZjYjBNeWNraGs3LzlxTG1MWVltUFo0cU1yb1Nm?=
 =?utf-8?B?eWllek4vL2FCTTdEVlBJVkFYNy9JVXNrYlVKcVdYSEpUODJjMUd0NmlyQWE1?=
 =?utf-8?B?eHVmQ21ZM2VZNVM1eWtBRkF6MHdENEk1SS8rcG50cjI5ZU5kWk02b1pTeVhu?=
 =?utf-8?B?M1ZJbUtqWHZsek9xdFlrR21Kb0t2WHRTWmY4RENUalhickYwVFpGWUM5Z0Fr?=
 =?utf-8?B?L3RxNjk0VjN3WVh2aXpORk5jVTE1eVJHTW1pTGg2a3B4NncvbjAzL0Y2cXJy?=
 =?utf-8?B?cEQvMS9rNGRLcVpqUUlKdHFsYVpWWUxKRmg5YTZldG55ZkRaNkliZmczSHdh?=
 =?utf-8?B?TzJWTWxkTFErUHhMamUwSE05SlNKVUhGcEl1UmZzZHRwdGk1TWh5TVFVUk8w?=
 =?utf-8?B?UUxXMkJMVmtEelZoWVZIVEMybVFSWW5zRk1RQksrUWEzVFBsV3pLaS9oMGFs?=
 =?utf-8?B?d3ZOenlLTlVLenVJekZCQmFqdS9KazFtaHNDT2d3QUFUVXdUUEczY2hQamJ6?=
 =?utf-8?B?N0xNeG9HSXgzRnpHZ05rRE4wNk9XNUJKOVo5NlkrME56OUlDNDNBazhlRG9Q?=
 =?utf-8?B?SGp2bk9LOFVMVVlCQzdCcWZPMk9qYkh4Tjkvd05MQXBQekdrT2ZtNERMcXJT?=
 =?utf-8?B?M2liL1BXZmgzZ3M2NS9XNWZRWTNnTmVMRVVtWFRLd21OVzdndWl5K29oSmRa?=
 =?utf-8?B?OC9qdGJxeWRSL0o0Z3NERDB1N1dqZ3R3YXBVd1RtRUZTT2ZIZlVLN2ZFRm1y?=
 =?utf-8?B?UGNYR3NORVM3UXlGemt6UDlGRDgvWmtLMFAyS2N6R2YxMGFEY0Z1ak1UbDR0?=
 =?utf-8?B?TUZTUHNNVEtNSEI5UDNrMnQxRzNvcmdpQlhqdkVpRE5OUXc4UXI3SmQ0N3NG?=
 =?utf-8?B?eUdwZkNaOUs5MFJsMzVSK1gwOGxlaVYxV3pxQlJDckQvRDZGbVZsQmdrTnFY?=
 =?utf-8?B?cHRLYzlnZldVcjdCUVA4UXdnb0R0YjJhdENGTDFSZXBaVWlMVG5kaldGTHQ0?=
 =?utf-8?B?c3dvdEhUVFlLTnh1N3M2S2IzbGpFM0NlQTI3TmVua1Z6Tmx2K2hrTjdIdnFW?=
 =?utf-8?B?ZEhEVUEwaDdoR2dNdGkxVm5ERGZMTjVaS2thNkFsM0JCVWNDYkt3aVVSWThM?=
 =?utf-8?B?MklKMXV5c0N4WlNIa3JJN082U2Y4cjJ3SkhFUjljTmwvVDhaUE5sUU5EbWE5?=
 =?utf-8?B?SEdQalRQK00vMnNNVjRhdisyNHArcTVrb1o5NlYySmNXQzdGcmlaZC9CblVJ?=
 =?utf-8?B?RHJiR1N3ZVlYN3dTaEJuVldJVXJRTTB1RWRNWFpFTHdXeUpuUUpLQVhjc1Vq?=
 =?utf-8?B?QUs0dEREMHp1UXB1NXNZRThIRzFvRW51aFh5SUl1OWNCWTVrRFBZN3VxcDFh?=
 =?utf-8?B?c1ZXR3RRYS9wS3JraHltdGt4SWNuRUs3OWtsWHRKU2xaTEZ6UW40WGoyeVNo?=
 =?utf-8?B?L0lFOHRuaTFXY3FscERFZ055SXhpTzdBNjRWZGM3Yzd3WWFWcnl1a1hhR2Fw?=
 =?utf-8?B?b1dPR3dtaytKakZkWDZKVmxYTHROZlZFM2gzQ2FSSVc4L2xEOTVXTjFpWWpF?=
 =?utf-8?B?U1Y0UUdnZTA3TklaSHlqQTZKalM5MmF2Ti9OSlJKa3JrZWFBb1dIQklkT1F6?=
 =?utf-8?B?cXVVQmhPZVgwRkQ0SFVaczJ3d2htd0pYVHBZYVluQ3ZrYXBscHZEOVF5WHkx?=
 =?utf-8?B?bWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <51DA5FDDC3EEB14D86996729D7E8E11C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	5F3bzwh1/R5RDy0guRBj0p2dAG5e+q+UtnLHOm3+RwGdF0qOKbRIuDS+ulDb9fjXzSroS0hALjTgex3dcYHl9VFAFp5dYHbwchPlr1AoMR0emjLvNUMXPEHRexLQCSEPJzu5gDvKtkkV5/72s8OYy04zm2U5U7nXL3rAyV/1ka2ngChsYggBwQv3ae4M0Ki4TUb9G5VVe1AWQ+i31RmmvRuA7W4blE9gxU5fzChpFpOTs4TyM/FM536neR2i7iOX+7oonV1FfBcv7fjAqMum7feOq9YPUqhdICr2O/KAtMcWy51UTeKCtI99eMJXnjoR3AtcHCMxoBjJXM0ShpguWljj3RbmWHCbw5aIFju6Cdd9sYNAOmhcQey59vsdDIMa8VrimvPmEDVCVUiZv0cRIAAjFDFaeNW2irGJQCEAhANL+jCsMOie+XsfQCpOmlfRmdRaiiEk4TtgeHhTkCsbBhd8cc+yKw1x8HKneIyHFEH2ONKyB/do9TLCE4TVZCoFA/7E4glX81zaVDN7/3v+fS5J+wMR5NvrAE9khsZP9/EYzXmiSaP1wX8U1BSixy7ElF7dIe5tKQpBNcCfoYjj/2nuShGz72r+HR7JjP0qdrw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db9b9fc7-7ee4-4151-43f3-08dc1ba079f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2024 23:18:43.4518
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HSzyfcaDOdPvvg9HqgnOf4+tl+1imFyOWYXVj4S1Quz8+nGmdheqzHakE9CNnCr32amxxg53jMPrWDOjb05A/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6573
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-22_12,2024-01-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401220167
X-Proofpoint-GUID: zsKu-35TXLyDgfrXhuuu2blr7wlxO_xV
X-Proofpoint-ORIG-GUID: zsKu-35TXLyDgfrXhuuu2blr7wlxO_xV

DQoNCj4gT24gSmFuIDIyLCAyMDI0LCBhdCA2OjE04oCvUE0sIENodWNrIExldmVyIElJSSA8Y2h1
Y2subGV2ZXJAb3JhY2xlLmNvbT4gd3JvdGU6DQo+IA0KPiANCj4gDQo+PiBPbiBKYW4gMjIsIDIw
MjQsIGF0IDQ6NTfigK9QTSwgTmVpbEJyb3duIDxuZWlsYkBzdXNlLmRlPiB3cm90ZToNCj4+IA0K
Pj4gT24gVHVlLCAyMyBKYW4gMjAyNCwgQ2h1Y2sgTGV2ZXIgd3JvdGU6DQo+Pj4gT24gTW9uLCBK
YW4gMjIsIDIwMjQgYXQgMDI6NTg6MTZQTSArMTEwMCwgTmVpbEJyb3duIHdyb3RlOg0KPj4+PiAN
Cj4+Pj4gVGhlIHRlc3Qgb24gc29fY291bnQgaW4gbmZzZDRfcmVsZWFzZV9sb2Nrb3duZXIoKSBp
cyBub25zZW5zZSBhbmQNCj4+Pj4gaGFybWZ1bC4gIFJldmVydCB0byB1c2luZyBjaGVja19mb3Jf
bG9ja3MoKSwgY2hhbmdpbmcgdGhhdCB0byBub3Qgc2xlZXAuDQo+Pj4+IA0KPj4+PiBGaXJzdDog
aGFybWZ1bC4NCj4+Pj4gQXMgaXMgZG9jdW1lbnRlZCBpbiB0aGUga2RvYyBjb21tZW50IGZvciBu
ZnNkNF9yZWxlYXNlX2xvY2tvd25lcigpLCB0aGUNCj4+Pj4gdGVzdCBvbiBzb19jb3VudCBjYW4g
dHJhbnNpZW50bHkgcmV0dXJuIGEgZmFsc2UgcG9zaXRpdmUgcmVzdWx0aW5nIGluIGENCj4+Pj4g
cmV0dXJuIG9mIE5GUzRFUlJfTE9DS1NfSEVMRCB3aGVuIGluIGZhY3Qgbm8gbG9ja3MgYXJlIGhl
bGQuICBUaGlzIGlzDQo+Pj4+IGNsZWFybHkgYSBwcm90b2NvbCB2aW9sYXRpb24gYW5kIHdpdGgg
dGhlIExpbnV4IE5GUyBjbGllbnQgaXQgY2FuIGNhdXNlDQo+Pj4+IGluY29ycmVjdCBiZWhhdmlv
dXIuDQo+Pj4+IA0KPj4+PiBJZiBORlM0X1JFTEVBU0VfTE9DS09XTkVSIGlzIHNlbnQgd2hpbGUg
c29tZSBvdGhlciB0aHJlYWQgaXMgc3RpbGwNCj4+Pj4gcHJvY2Vzc2luZyBhIExPQ0sgcmVxdWVz
dCB3aGljaCBmYWlsZWQgYmVjYXVzZSwgYXQgdGhlIHRpbWUgdGhhdCByZXF1ZXN0DQo+Pj4+IHdh
cyByZWNlaXZlZCwgdGhlIGdpdmVuIG93bmVyIGhlbGQgYSBjb25mbGljdGluZyBsb2NrLCB0aGVu
IHRoZSBuZnNkDQo+Pj4+IHRocmVhZCBwcm9jZXNzaW5nIHRoYXQgTE9DSyByZXF1ZXN0IGNhbiBo
b2xkIGEgcmVmZXJlbmNlIChjb25mbG9jaykgdG8NCj4+Pj4gdGhlIGxvY2sgb3duZXIgdGhhdCBj
YXVzZXMgbmZzZDRfcmVsZWFzZV9sb2Nrb3duZXIoKSB0byByZXR1cm4gYW4NCj4+Pj4gaW5jb3Jy
ZWN0IGVycm9yLg0KPj4+PiANCj4+Pj4gVGhlIExpbnV4IE5GUyBjbGllbnQgaWdub3JlcyB0aGF0
IE5GUzRFUlJfTE9DS1NfSEVMRCBlcnJvciBiZWNhdXNlIGl0DQo+Pj4+IG5ldmVyIHNlbmRzIE5G
UzRfUkVMRUFTRV9MT0NLT1dORVIgd2l0aG91dCBmaXJzdCByZWxlYXNpbmcgYW55IGxvY2tzLCBz
bw0KPj4+PiBpdCBrbm93cyB0aGF0IHRoZSBlcnJvciBpcyBpbXBvc3NpYmxlLiAgSXQgYXNzdW1l
cyB0aGUgbG9jayBvd25lciB3YXMgaW4NCj4+Pj4gZmFjdCByZWxlYXNlZCBzbyBpdCBmZWVscyBm
cmVlIHRvIHVzZSB0aGUgc2FtZSBsb2NrIG93bmVyIGlkZW50aWZpZXIgaW4NCj4+Pj4gc29tZSBs
YXRlciBsb2NraW5nIHJlcXVlc3QuDQo+Pj4+IA0KPj4+PiBXaGVuIGl0IGRvZXMgcmV1c2UgYSBs
b2NrIG93bmVyIGlkZW50aWZpZXIgZm9yIHdoaWNoIGEgcHJldmlvdXMgUkVMRUFTRQ0KPj4+PiBm
YWlsZWQsIGl0IHdpbGwgbmF0dXJhbGx5IHVzZSBhIGxvY2tfc2VxaWQgb2YgemVyby4gIEhvd2V2
ZXIgdGhlIHNlcnZlciwNCj4+Pj4gd2hpY2ggZGlkbid0IHJlbGVhc2UgdGhlIGxvY2sgb3duZXIs
IHdpbGwgZXhwZWN0IGEgbGFyZ2VyIGxvY2tfc2VxaWQgYW5kDQo+Pj4+IHNvIHdpbGwgcmVzcG9u
ZCB3aXRoIE5GUzRFUlJfQkFEX1NFUUlELg0KPj4+PiANCj4+Pj4gU28gY2xlYXJseSBpdCBpcyBo
YXJtZnVsIHRvIGFsbG93IGEgZmFsc2UgcG9zaXRpdmUsIHdoaWNoIHRlc3RpbmcNCj4+Pj4gc29f
Y291bnQgYWxsb3dzLg0KPj4+PiANCj4+Pj4gVGhlIHRlc3QgaXMgbm9uc2Vuc2UgYmVjYXVzZSAu
Li4gd2VsbC4uLiBpdCBkb2Vzbid0IG1lYW4gYW55dGhpbmcuDQo+Pj4+IA0KPj4+PiBzb19jb3Vu
dCBpcyB0aGUgc3VtIG9mIHRocmVlIGRpZmZlcmVudCBjb3VudHMuDQo+Pj4+IDEvIHRoZSBzZXQg
b2Ygc3RhdGVzIGxpc3RlZCBvbiBzb19zdGF0ZWlkcw0KPj4+PiAyLyB0aGUgc2V0IG9mIGFjdGl2
ZSB2ZnMgbG9ja3Mgb3duZWQgYnkgYW55IG9mIHRob3NlIHN0YXRlcw0KPj4+PiAzLyB2YXJpb3Vz
IHRyYW5zaWVudCBjb3VudHMgc3VjaCBhcyBmb3IgY29uZmxpY3RpbmcgbG9ja3MuDQo+Pj4+IA0K
Pj4+PiBXaGVuIGl0IGlzIHRlc3RlZCBhZ2FpbnN0ICcyJyBpdCBpcyBjbGVhciB0aGF0IG9uZSBv
ZiB0aGVzZSBpcyB0aGUNCj4+Pj4gdHJhbnNpZW50IHJlZmVyZW5jZSBvYnRhaW5lZCBieSBmaW5k
X2xvY2tvd25lcl9zdHJfbG9ja2VkKCkuICBJdCBpcyBub3QNCj4+Pj4gY2xlYXIgd2hhdCB0aGUg
b3RoZXIgb25lIGlzIGV4cGVjdGVkIHRvIGJlLg0KPj4+PiANCj4+Pj4gSW4gcHJhY3RpY2UsIHRo
ZSBjb3VudCBpcyBvZnRlbiAyIGJlY2F1c2UgdGhlcmUgaXMgcHJlY2lzZWx5IG9uZSBzdGF0ZQ0K
Pj4+PiBvbiBzb19zdGF0ZWlkcy4gIElmIHRoZXJlIHdlcmUgbW9yZSwgdGhpcyB3b3VsZCBmYWls
Lg0KPj4+PiANCj4+Pj4gSXQgbXkgdGVzdGluZyBJIHNlZSB0d28gY2lyY3Vtc3RhbmNlcyB3aGVu
IFJFTEVBU0VfTE9DS09XTkVSIGlzIGNhbGxlZC4NCj4+Pj4gSW4gb25lIGNhc2UsIENMT1NFIGlz
IGNhbGxlZCBiZWZvcmUgUkVMRUFTRV9MT0NLT1dORVIuICBUaGF0IHJlc3VsdHMgaW4NCj4+Pj4g
YWxsIHRoZSBsb2NrIHN0YXRlcyBiZWluZyByZW1vdmVkLCBhbmQgc28gdGhlIGxvY2tvd25lciBi
ZWluZyBkaXNjYXJkZWQNCj4+Pj4gKGl0IGlzIHJlbW92ZWQgd2hlbiB0aGVyZSBhcmUgbm8gbW9y
ZSByZWZlcmVuY2VzIHdoaWNoIHVzdWFsbHkgaGFwcGVucw0KPj4+PiB3aGVuIHRoZSBsb2NrIHN0
YXRlIGlzIGRpc2NhcmRlZCkuICBXaGVuIG5mc2Q0X3JlbGVhc2VfbG9ja293bmVyKCkgZmluZHMN
Cj4+Pj4gdGhhdCB0aGUgbG9jayBvd25lciBkb2Vzbid0IGV4aXN0LCBpdCByZXR1cm5zIHN1Y2Nl
c3MuDQo+Pj4+IA0KPj4+PiBUaGUgb3RoZXIgY2FzZSBzaG93cyBhbiBzb19jb3VudCBvZiAnMicg
YW5kIHByZWNpc2VseSBvbmUgc3RhdGUgbGlzdGVkDQo+Pj4+IGluIHNvX3N0YXRlaWQuICBJdCBh
cHBlYXJzIHRoYXQgdGhlIExpbnV4IGNsaWVudCB1c2VzIGEgc2VwYXJhdGUgbG9jaw0KPj4+PiBv
d25lciBmb3IgZWFjaCBmaWxlIHJlc3VsdGluZyBpbiBvbmUgbG9jayBzdGF0ZSBwZXIgbG9jayBv
d25lciwgc28gdGhpcw0KPj4+PiB0ZXN0IG9uICcyJyBpcyBzYWZlLiAgRm9yIGFub3RoZXIgY2xp
ZW50IGl0IG1pZ2h0IG5vdCBiZSBzYWZlLg0KPj4+PiANCj4+Pj4gU28gdGhpcyBwYXRjaCBjaGFu
Z2VzIGNoZWNrX2Zvcl9sb2NrcygpIHRvIHVzZSB0aGUgKG5ld2lzaCkNCj4+Pj4gZmluZF9hbnlf
ZmlsZV9sb2NrZWQoKSBzbyB0aGF0IGl0IGRvZXNuJ3QgdGFrZSBhIHJlZmVyZW5jZSBvbiB0aGUN
Cj4+Pj4gbmZzNF9maWxlIGFuZCBzbyBuZXZlciBjYWxscyBuZnNkX2ZpbGVfcHV0KCksIGFuZCBz
byBuZXZlciBzbGVlcHMuDQo+Pj4gDQo+Pj4gTW9yZSB0byB0aGUgcG9pbnQsIGZpbmRfYW55X2Zp
bGVfbG9ja2VkKCkgd2FzIGFkZGVkIGJ5IGNvbW1pdA0KPj4+IGUwYWE2NTEwNjhiZiAoIm5mc2Q6
IGRvbid0IGNhbGwgbmZzZF9maWxlX3B1dCBmcm9tIGNsaWVudCBzdGF0ZXMNCj4+PiBzZXFmaWxl
IGRpc3BsYXkiKSwgd2hpY2ggd2FzIG1lcmdlZCBzZXZlcmFsIG1vbnRocyAvYWZ0ZXIvIGNvbW1p
dA0KPj4+IGNlM2M0YWQ3ZjRjZSAoIk5GU0Q6IEZpeCBwb3NzaWJsZSBzbGVlcCBkdXJpbmcNCj4+
PiBuZnNkNF9yZWxlYXNlX2xvY2tvd25lcigpIikuDQo+PiANCj4+IFllcy4gIFRvIGZsZXNoIG91
dCB0aGUgaGlzdG9yeToNCj4+IG5mc2RfZmlsZV9wdXQoKSB3YXMgYWRkZWQgaW4gdjUuNC4gIElu
IGVhcmxpZXIga2VybmVscyBjaGVja19mb3JfbG9ja3MoKQ0KPj4gd291bGQgbmV2ZXIgc2xlZXAu
ICBIb3dldmVyIHRoZSBwcm9ibGVtIHBhdGNoIHdhcyBiYWNrcG9ydGVkIDQuOSwgNC4xNCwNCj4+
IGFuZCA0LjE5IGFuZCBzaG91bGQgYmUgcmV2ZXJ0ZWQuDQo+IA0KPiBJIGRvbid0IHNlZSAiTkZT
RDogRml4IHBvc3NpYmxlIHNsZWVwIGR1cmluZyBuZnNkNF9yZWxlYXNlX2xvY2tvd25lcigpIg0K
PiBpbiBhbnkgb2YgdGhvc2Uga2VybmVscy4gQWxsIGJ1dCA0LjE5IGFyZSBub3cgRU9MLg0KDQpP
SywgSSBzZWUgaXQgbm93LiBJJ2xsIGFzayBzdGFibGUgdG8gcmVtb3ZlIGl0IGZyb20gdjQuMTku
eS4NCg0KDQo+PiBmaW5kX2FueV9maWxlX2xvY2tlZCgpIHdhcyBhZGRlZCBpbiB2Ni4yIHNvIHdo
ZW4gdGhpcyBwYXRjaCBpcw0KPj4gYmFja3BvcnRlZCB0byA1LjQsIDUuMTAsIDUuMTUsIDUuMTcg
LSA2LjEgaXQgbmVlZHMgdG8gaW5jbHVkZQ0KPj4gZmluZF9hbmRfZmlsZV9sb2NrZWQoKQ0KPiAN
Cj4gSSB0aGluayBJJ2QgcmF0aGVyIGxlYXZlIHRob3NlIHVucGVydHVyYmVkIHVudGlsIHNvbWVv
bmUgaGl0cyBhIHJlYWwNCj4gcHJvYmxlbS4gVW5sZXNzIHlvdSBoYXZlIGEgZGlzdHJpYnV0aW9u
IGtlcm5lbCB0aGF0IG5lZWRzIHRvIHNlZQ0KPiB0aGlzIGZpeCBpbiBvbmUgb2YgdGhlIExUUyBr
ZXJuZWxzPyBUaGUgc3VwcG9ydGVkIHN0YWJsZS9MVFMga2VybmVscw0KPiBhcmUgNS40LCA1LjEw
LCA1LjE1LCBhbmQgNi4xLg0KPiANCj4gDQo+PiBUaGUgcGF0Y2ggc2hvdWxkIGFwcGx5IHVuY2hh
bmdlZCB0byBzdGFibGUga2VybmVscyA2LjIgYW5kIGxhdGVyLg0KPiANCj4gSSBjYW4gYWRkIGEg
Q2M6IHN0YWJsZSAjdjYuMisNCj4gDQo+IA0KPiAtLQ0KPiBDaHVjayBMZXZlcg0KDQoNCi0tDQpD
aHVjayBMZXZlcg0KDQoNCg==

