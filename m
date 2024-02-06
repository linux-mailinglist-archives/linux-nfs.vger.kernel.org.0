Return-Path: <linux-nfs+bounces-1810-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A1D84B805
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Feb 2024 15:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F70EB24719
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Feb 2024 14:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA841E888;
	Tue,  6 Feb 2024 14:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OMNmByCz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IEKAqz3b"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3FC2579
	for <linux-nfs@vger.kernel.org>; Tue,  6 Feb 2024 14:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707230062; cv=fail; b=B8hzGeLiCV6cH0nIoZiWrU6OzDtLWWMa6Y/Pz0C6RbmpOeKVceswwemmsXyt/g6exFgLsBEnn09jX19NlrDe5NMZfFhy1rJuFzxAnqgUDXASHC4jek7eCbIwInwcHV7lNuxiPhqFVvqdFW2VV0a5jw9LW4u3XtxRugnOAnO5PFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707230062; c=relaxed/simple;
	bh=TUKK5OvELHa2rpXaaZ8SweOcR+xuNy3yfPWO2Kjejk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=D3hYvNxp5Qn2XjE4XbYogUxsp6FXwhV3vcnqzG9PMiGVOrzySiCcoDt5Ln4kTNv0QTQrdfxuUPW/y3O3n6B3lVCm9+orFsNNLFwi5rYIMxABdvu2Rf+wab3IKl0JNtRLc8sGIZtVe8hwU+Ay/HNbStHJiIVm2SgQQcBvtoj+FDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OMNmByCz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IEKAqz3b; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 416A9oVO005158;
	Tue, 6 Feb 2024 14:34:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-11-20;
 bh=PFZ1tgVkRp/OyyCub6dYv8WWOTflT3XDJHGlvHcdOOM=;
 b=OMNmByCzcX903ILShCNc40QIO0qGNDoi0aNtVMTazlytZvke533fxzTlaP7AdqPbtBIx
 GZZGiJ29HTVoCXA5ggJ0hogDA9PAGCRhuM/Y/vFCSAHTwVPphqqADK92kYoX0fPzwMXC
 tsdYqqgH25t8/gQSWvIUaqpXO5ZuK7W8WETotVSG0wByZEMs77HxIgkcYoUG4m8ZOYqS
 dzNbMjxrEZBsfwkpKcijCd/I33Zh4hAsy6LVBls4UQ+y3KImXul7KSAA3GPsAlWZReZh
 pw+KMK0z+RawDW1ngtNRYG2LwBR56TPv01FypBYsXN7MlFvHKfiszl9cXBe//1rA9YE5 Qw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1c93y374-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Feb 2024 14:34:16 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 416E6cCE038345;
	Tue, 6 Feb 2024 14:34:15 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bx7d31c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Feb 2024 14:34:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BF6k+1sxWkuwJ+6V7E3qxE4zkQ7N2t2fQ5H2hCHL+FUSvfyisKl9LAWvklvO6dOP1neG/NtF9Xe9O9/NjLAt0o0Pi+4Bhp9Kywa6kiKOV21ulXf1AK70Urivt51hPoVkOm7kobsNg5q7PaNiLHSk0iJOHOO5iyHnBBjJ7Mv1lZoeRTnmBNOzcLAzjFLcCBGLHRnPLXn3I4rh20GcGE7bhe0ukTsj2bo8dcT9l2MhNiz36mBWGnzXJFzKOjUXtOt7AXaNNYrM50atNJjq6XFi5xzefOyw6qhpxMTiriW1ecwL42Y1feR0imRws/f5GQ5au+sauiV7noqhrOA0boNL3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PFZ1tgVkRp/OyyCub6dYv8WWOTflT3XDJHGlvHcdOOM=;
 b=EDiThTj58yuiMOGmy973BWoxHsJtRia8Tzlu0UT2p5SylACO+Ll6xyol3hOrPl2XbnTSs1lUMc1xUTJs0d/Aqz2uweoPuEJT47sgfOpPIqGgLAWoQrSevg6jBqb6tDZZZHvioly5b2t74nyy2riiFaMXKgfL+qn8u0K5QsSFx8YST1eCD2upB30QOpMP1+YIaIMclX5JN80NzmpLwHv96Ld1ULAXNWddtQJbaxfVkE1R4N9LOoK5JU3S4nTP5Xr9cJ3gtOPTkdKhiIEEasV+ZTa89JlmIrYa3/mdOSFtynCRCo/wAp7THLAr8DBbnX4jLRk9oK/TmlUAx3fyZ6S/hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PFZ1tgVkRp/OyyCub6dYv8WWOTflT3XDJHGlvHcdOOM=;
 b=IEKAqz3bjPhAo0e9vDoolQ6MZKWnxRdixNoUMUs8HOoIzFXPlP6c0J+iQBzbrV0CxLnYRAIxsN8dhYelPvHMxZvflM6iKyt/AllPMlIwmh4ilXUWH9LkXcKDueq1riUp+mdjokUnMJ3vM9OVsZiDgf0J9cYfpPAjdRmZKk//6QA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB7173.namprd10.prod.outlook.com (2603:10b6:8:dc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Tue, 6 Feb
 2024 14:34:13 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed:9f6b:7944:a2fa]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed:9f6b:7944:a2fa%7]) with mapi id 15.20.7249.035; Tue, 6 Feb 2024
 14:34:13 +0000
Date: Tue, 6 Feb 2024 09:34:10 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Trond Myklebust <trondmy@hammerspace.com>
Cc: "cedric.blancher@gmail.com" <cedric.blancher@gmail.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "martin.l.wege@gmail.com" <martin.l.wege@gmail.com>,
        "bcodding@redhat.com" <bcodding@redhat.com>
Subject: Re: NFSv4 referrals - custom (non-2049) port numbers in fs_locations?
Message-ID: <ZcJDYrKLdvMlG1db@tissot.1015granger.net>
References: <DD47B60A-E188-49BC-9254-6C032BA9776E@redhat.com>
 <CANH4o6NzV2_u-G0dA=hPSTvOTKe+RMy357CFRk7fw-VRNc4=Og@mail.gmail.com>
 <5ED71FE7-B933-44AC-A180-C19EC426CBF8@oracle.com>
 <CALXu0UeZgnWbMScdW+69a_jvRxM2Aou0fPvt0PG6eBR3wHt++Q@mail.gmail.com>
 <8FCF1BB3-ECC1-4EBF-B4B4-BE6F94B3D4F5@oracle.com>
 <CANH4o6P2S1mOXAbQb9d4OgtkvUTVPwdyb8M0nn71rygURGSkxQ@mail.gmail.com>
 <93DA527F-E5D7-49A4-89E6-811CE045DDD3@oracle.com>
 <c28a3c78daa1845b8a852d910e0ea6c6bf4d63b4.camel@hammerspace.com>
 <DA6AB3E6-F720-4679-A36B-01BEB39720BB@oracle.com>
 <b75b415f3b00706016454b066821bda2e4e989ac.camel@hammerspace.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b75b415f3b00706016454b066821bda2e4e989ac.camel@hammerspace.com>
X-ClientProxiedBy: CH2PR10CA0025.namprd10.prod.outlook.com
 (2603:10b6:610:4c::35) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS0PR10MB7173:EE_
X-MS-Office365-Filtering-Correlation-Id: 65ac7b27-1242-4cbd-6787-08dc2720b020
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	GgEt3o06iOAnNp0kGEZQ196Ck/yyyjqQoFLnGDiNM7mi0FZWdKfK5x92UpEbkRmzeZ0ppC6ZGvcj7coNrbJQoo+YF5YU7cpbJZ+vbb/QvqIQanWJ3Tas5gyrfqJ6SVKIscxuTCPlPgmDRsoISnvfwcJlUlcvjT1I4ZucZnUnOu1/JYy2vtoaymYMyjUblZe6DtYkTL6lQkueCKJOFrMeCVoMHKi01T2cHu1cDu4pDOPw/f1xYul1hTQPEeNehdfvvfdPZR5cITfIpkcSCWOHXhv3Xew08m+1ymbOFoTrXdduzl2+7qa2mG9nV/arNpg3m7mDzEhQH3GcgEGADxK8JfJMtzppkhFwXEiPIX+FSQMWhmg9PawWmF2Nh6LSm6ITqKdWX9NwGu8lpw7Fl/bsISpJ4uQOmzPYnod9ltOdsj8CRwHKVhTvDVQYAK6zlzg3H76y29iiJNytEaP+ZEUyqQ0e2BygdvhyHQTaUjD7zX7dW07G1dloZvPb8WNcVuPe14Z0ADM7nQ+nqkvb1Rh3ubIgPHs6oAQ5bKQXCSjhVWbqZ7fBx9Ce6Ag0OdsQTyI3DSJaF80oGRqi8Sj3OMgJZw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(366004)(376002)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(6506007)(86362001)(41300700001)(966005)(6486002)(478600001)(2906002)(5660300002)(54906003)(44832011)(66556008)(316002)(66946007)(66476007)(6916009)(8676002)(4326008)(26005)(6512007)(8936002)(9686003)(53546011)(38100700002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Y0pBUjh4RUR6djh0clN0WkRaQXJDZW5wSTVrelIxM1VYekNOMXdPaDYwV1Vv?=
 =?utf-8?B?SlZOMENHajRGemVmS2N0WlFtQXdwU0VzTGFxUjJzR1Z1eWZIWGpDRnpHZk15?=
 =?utf-8?B?VGlXS0JOS1YzbTR4VDhLTHJycHp0UXFhV0U2bmViZGNQQmdLVGJyZzJNNHNK?=
 =?utf-8?B?V2ZoSU5JNThOSFhmVThuM3hrVGZRNytZYy85Q1hPK29IaDExZE4vSmU2Y1lV?=
 =?utf-8?B?UWhPWjU2RkZlTnRraTlQZDZpZjZNRVVWSWViMmpCY1c4d0NMZlBtVk1IQUZE?=
 =?utf-8?B?RjZHT1VKTlpNWUFKQ3VPOUNYMTNaWkN6Z1M4WHVyMFY2RVhpZVRWSmFycUhz?=
 =?utf-8?B?US9NdFZVckJrVWFBVlFFZi9vUTNjSjIxQWNKckxISUJ3cHpaTU9XbUdFWWVP?=
 =?utf-8?B?b0ZTVGpRWTkrbE9wbzlONkhSczgwbjBtdHVqelA4MndSY0NqR3pHZFlIZ1l2?=
 =?utf-8?B?b1J6bVdNRmhFZUxsVEVCRTlHSCtybGtRcERYaENWemVWVlZhVWJMcDl6a2RZ?=
 =?utf-8?B?TllxUVdLQTBiKzFBOVdrRWtFWk85MXVBUUdBWlBrOGNuMkpYQ2ZBV1J4cmlP?=
 =?utf-8?B?dzE1OGVFeXM1ZHNLKzdLcTVJcHA5QnhLZ1JRRlB6SlREUHZ6RDNHWDAvdDBm?=
 =?utf-8?B?YnJsSDd6enZ6TERsMVNZYkRqTUQ0dDVFWFU1RGJSc0JBRmlCY2EwTHhNQXpN?=
 =?utf-8?B?WnRyYVFEQ2xoR3ZGYjAzNCtUTExqM0Z4anhLTnYwUW1EMjFJV0VmT3ZxbHZv?=
 =?utf-8?B?Y1ZSTDFxcWNaRFdUNGlURy9abW52T0V1ZW02S2J1dTVtUGkza2FEZzJ4NHp5?=
 =?utf-8?B?d1l6QldadkkvQU90U2JWUlVMdHk0MU9wYkZlMXlOV2VnUWVSQURVbVZ2Q1RM?=
 =?utf-8?B?RGMzalA3QVd3dW1lVEQreWF3Ky9MRVVuWG1udnp3a2RIYVNIRkhKUzhpQzVv?=
 =?utf-8?B?Y3RkV3B5azYxVHNOR205ZW9BRmhMY3ZmYzZTdFNjRUhmNm9TTHhqWWY2aDNx?=
 =?utf-8?B?aVBtODBFZXBwNEZmY1ZYNGRGakV1TWVxRkNDYXluR0lrbVB2QWppYmwwOTFM?=
 =?utf-8?B?V2IyT1c1NUhnMVVYZUl2MHlQbzZWRkdEL3FQaTdzUHFrZUg4UnpLK0tiNEJ6?=
 =?utf-8?B?L3NsTER1WVhOTE1SMXdNS2huVHFZSEtsaGFNZ1dJdFNrQmZTWi9DODczL3Er?=
 =?utf-8?B?L1YrcTRWTlg1aVg4NkVyMnlFSWhCSWRRZnUwMkJpZ0x2cWxDLy9FTHhsV0dl?=
 =?utf-8?B?dGFoK1ZUOC82RmV3SmdYNTRSU3V2S2JKSlZHbUNkVWhYNW9Ib1k2QnBvQkJk?=
 =?utf-8?B?SDdvbzEzMnh0Sy9qMGg0WFFXcDhROVcwYldsNDJmSVpMQWtweTEreERhU1Mz?=
 =?utf-8?B?UlVubzNmZjRydWFNWDFUYlhzTVZUZy8vSmdnMjl2anBMRG10ei9sc0FWdVRv?=
 =?utf-8?B?amRyY0RSREdLbzBZUjREZXlvbXJ3VExuL2ZBYmxzdTMreVlTTnpvamFSc0o0?=
 =?utf-8?B?cHBPTnl1VkJiSXYrTTF6THhINmx4ZXpIMG1KWDRuWG93K0Q2L2hrSEJzUlB5?=
 =?utf-8?B?YkoyaXhxbml3aEVyaVBNQ1R6Zk43WG1aVU0yMXhublgvRXBvMWlpbUFNeUw1?=
 =?utf-8?B?bERjd3h5Sk5Kc1NKdzBzNFQ4UHpscnlWTm9yTjlXUmdEMWhzVE96Mldhc3Ba?=
 =?utf-8?B?bWVRRUZOUUxLYjl5d3E1blFySHNkVi8zSTBMa05wQXpjc0NncjN3ay9yb2Rm?=
 =?utf-8?B?UUNkM2YrdkVOcXpPYWdibnBzK1hrckxjRjEydlNCS09pZWtWYjV2MExnUVlT?=
 =?utf-8?B?QUdFZjVMNGsxN1JKNHp2Y1pOdTFBdWVpQ0UrbCs2bkswdkhkR1lwQkJndTU5?=
 =?utf-8?B?OGZNMGFvRm5lRE14SCtSNHZUZlgvR2tNNU52b0JCQ25UdzdVbXllSitmK2tw?=
 =?utf-8?B?V05qMUNQaG1lQ1NQZjdWUUd2b3piUTcreXlJMERkWHFtMnhNR1IzbVdLUHAx?=
 =?utf-8?B?WnlLVjlyL0g2N0xTQzRmekN6aXZaeXhTUXhGSmE1WkZ5bUplZ0JBNTAxSm1O?=
 =?utf-8?B?SVVYSnZLcHFTMlJ6UmFRc3Qra2psQUtSZjd4aVZxNkkvTm5Jck9RN1JtWFo5?=
 =?utf-8?B?SzZIWkNieUI3OU5ueWszeHIzeVdCcXo0M1RKYXRadXpqeTRwTVVtZmNyalJ6?=
 =?utf-8?B?U3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Ssvj7z/Iv803w3QJL1FxFj132keCfjcVCRC3cWkw74NbbXu1MDjICc+Z86nP+1LJKW8wLhPfLPEPROgdcJ1pWpPhuN1ezHY3KsO2/pSxDETDpd85YVNvg4CmnlM3Me0o6aTOXVBLO6X9SesYhcW2VTVSJUpfy23rmlRCFFvVZcsepakkOQCtmiMBAMlonvT2fKUmHUwZPY6SMtlnvS/B938ui/K8ECNL0cfHtoMEUamohA8dilc9Y+h+OR5C6jPHIySKLYEEm7s7IivUU91uwSO+AoYMwQVqFQbt4MRNsW//dAhjSWzkrYe3i+X1mWN5GXFYRIljDzv4pqyQn4yfTC4hNU1zgQXCvjXuA+nkw6x59ZqVg04pcqVP30RHZ+ezGXm6TsyY7GQoly2Kkcx9byRyOLaN/Uu3leCpwuePks/t/AXeW+MxPEZO0vkSxCKbum7Pe8Xgz6uqlv9AUCD9darV5L7vcLG+TNRKkJyXW0HJqYElQQ/tJ2d9qiNCHkdad8UKs/JA7w1unuO19tdhCVGsfnqJY29EIgbXYmNCtugqY8eWL+TlwvycZeF7QuYke1apEKoraZLSW4Z9hWkDTMCKBXnlnabypLAB9oDnLGQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65ac7b27-1242-4cbd-6787-08dc2720b020
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 14:34:13.0276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7xdFjs9UJtIGypa8OtW7R9Iw/vq0aJpjnuZW0ZhTlb8KXTNbYsvoUSWRtftR9shZOoTmxDvzc2+bWbYSEzTx1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7173
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-06_08,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402060102
X-Proofpoint-ORIG-GUID: Gd4Cl9PsVSitOskSgE7WpeWcR3zuRXAZ
X-Proofpoint-GUID: Gd4Cl9PsVSitOskSgE7WpeWcR3zuRXAZ

On Mon, Feb 05, 2024 at 08:34:46PM +0000, Trond Myklebust wrote:
> On Mon, 2024-02-05 at 19:53 +0000, Chuck Lever III wrote:
> > 
> > 
> > > On Feb 5, 2024, at 11:17 AM, Trond Myklebust
> > > <trondmy@hammerspace.com> wrote:
> > > 
> > > On Mon, 2024-02-05 at 15:13 +0000, Chuck Lever III wrote:
> > > > 
> > > > 
> > > > A DNS label is just a hostname (fully-qualified or not). It
> > > > never includes a port number.
> > > > 
> > > > According to RFC 8881, fs_location4's server field can contain:
> > > > 
> > > >  - A DNS label (no port number; 2049 is assumed)
> > > > 
> > > >  - An IP presentation address (no port number; 2049 is assumed)
> > > > 
> > > >  - a universal address
> > > > 
> > > > A universal address is an IP address plus a port number.
> > > > Therefore
> > > > a universal address is the only way an alternate port can be
> > > > communicated in an NFSv4 referral.
> > > 
> > > That's not strictly true. RFC8881 has little to say about how you
> > > are
> > > to go about using the DNS hostname provided by fs_locations4. There
> > > is
> > > just some non-normative and vague language about using DNS to look
> > > up
> > > the addresses.
> > > 
> > > The use of DNS service records do allow you to look up the full IP
> > > address and port number (i.e. the equivalent of a universal
> > > address)
> > > given a fully qualified hostname and a service. While we do not use
> > > the
> > > hostname that way in the Linux NFS client today, I see nothing in
> > > the
> > > spec that would appear to disallow it at some future time.
> > 
> > We absolutely could do that. But first a service name would need to
> > be
> > reserved, yes?
> > 
> > https://www.iana.org/assignments/service-names-port-numbers/service-names-port-numbers.xhtml?search=dns
> > 
> 
> What's wrong with the one that is already assigned? I'm talking about:
> 
> nfs                2049        tcp    Network File System - Sun    [Brent_Callaghan]                                     [Brent_Callaghan]                                                                                                                                        Defined TXT keys: path=<path to mount point>
>                                       Microsystems
> nfs                2049        udp    Network File System - Sun    [Brent_Callaghan]                                     [Brent_Callaghan]                                                                                                                                        Defined TXT keys: path=<path to mount point>
>                                       Microsystems
> nfs                2049       sctp    Network File System                                                                                                                                                    [RFC5665]                                                            Defined TXT keys: path=<path to mount point>


For reference:

https://www.iana.org/assignments/service-names-port-numbers/service-names-port-numbers.xhtml?search=2049

My search terms excluded these, so I missed them.

I don't see the IANA action request text in RFC 5665. These must
have been specified and requested in some other document, or that
action request was removed before RFC 5665 was published.

Putative example: NFS on port 2050 of example.com:

_nfs._tcp.example.com. 86400 IN SRV 0 5 2050 server1.example.com.

I suppose "mount.nfs" could recognize this mapping as well.

Since the transport protocol is included in the SRV record, I'm not
sure how one would encode "rdma" for NFS on iWARP, which uses a
distinct port (20049).


-- 
Chuck Lever

