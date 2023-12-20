Return-Path: <linux-nfs+bounces-722-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C78D81A591
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Dec 2023 17:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E90C428824A
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Dec 2023 16:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38FF41A92;
	Wed, 20 Dec 2023 16:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YE4Xzg7O";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="T6r+weqd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F080A4653E
	for <linux-nfs@vger.kernel.org>; Wed, 20 Dec 2023 16:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BKE17Ou003509;
	Wed, 20 Dec 2023 16:46:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=2zzdbGzkR7GoufZgCQwOYL68wY46qs7nkXgm0hgdu9c=;
 b=YE4Xzg7O8kjpP022WeW2AXGFVx2fIDQQuREDstMRLN+ydxp79dJ7rouy/02Ia6PfuMog
 RbGdH7wj8kesKW5kxR762kMiCrKAq7GOLftz9k+n1r3ysbSQSWlXL4O+caSOcw6IPG7g
 yolsjJlsqJafj+nBfpOC+pyaAdPA2/gtL45t3O4Qc6OeUdcd75p094kfminoMwp3O7Ga
 n6QaZnyoqe+1RpRuj7cfcJDcBlprQRl3hF0P88B0MOYso3bO3/Z4960Z8EaQ03LFZySE
 3/v4oiiiswk1xAakrRxB92TLyL4TVJVGkfSr138KymOezRcF8MuJl/bqWEQyv83qS9iO Zg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3v12aeguu3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Dec 2023 16:46:05 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BKFU3uD020992;
	Wed, 20 Dec 2023 16:46:04 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3v12b93a9u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Dec 2023 16:46:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BLzhuTOo92gGsjZZYVjTzOim7AX/QMXjqxV7Xnwa42tW18GLv7gXcbKglLStHOGiiC8QSQWQiZ1wxiW5gP+HVhwUmztH0yLf/QXAAWxAa8ydhJTUvP815g9IPwTql/9YOZlilN03fPr+917UTL55cHc23ByunBtNVsVwQI3G9xRSIEQYQCJXPOSObxbFR8m7aPGDdPYeEcApXA2u1E6oQpWGaDdFg/QPjc6GJUjQSYYFeOXRlH3sn9NGCW8Fx+5Lw/bQaVNHf5sTy5MqycMuYEdXajcfUwz4EqmZcmVLlm+BnV1Jb9phmWB60BUltTqgH2fB6Hl3JfbTKIcgXsYFYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2zzdbGzkR7GoufZgCQwOYL68wY46qs7nkXgm0hgdu9c=;
 b=Yue2R6tad0RlsS9JfDBZEhgJ9IliCdJEHrbli+7WQ72faX38Qde3k+rbbOmLb6PZQNWpdHB2xewjlQl2FC1QXhyoLK1S7jHc9fv5GxQgbNGGBQjDQ6UUvpFYc4meULfK0HVHBfQASWGnctW+fYdYWJVNQCV9xIHGFWGhFVqmOELdQmlGFlB5FSOveALc7u00mHF1d/F+RETQnEsbxgajxspEt1IPzxFPA2o8X0fq0Mb/r+W2bgrHRZ97BxPQwKOn9ozKkdxlju8L+kw+bnA1M2QJWDCBQxYhwZE/xhc7Gi6qBAUSIHCfYFmof/uI0BIpOAtWNS/lTm9LziGZYtDSIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2zzdbGzkR7GoufZgCQwOYL68wY46qs7nkXgm0hgdu9c=;
 b=T6r+weqdHztoB09zR91OxQtZVXb7T+Ab1qAG3xlZxcUW9eqhBYVrM8rbPevSKrJJEtXFF9/U0utKd95PQQZQ//kZzqSHK7tnBGvokNuHDKvowA38UkiFbGJ9PF5nmuu1Jgu1V27pWOzu3siMUZBcv19gWl4yyF3zoa8/Ocf0+WI=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by SJ0PR10MB4702.namprd10.prod.outlook.com (2603:10b6:a03:2af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Wed, 20 Dec
 2023 16:46:01 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::abad:34ed:7b04:91c5]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::abad:34ed:7b04:91c5%7]) with mapi id 15.20.7113.016; Wed, 20 Dec 2023
 16:46:01 +0000
Message-ID: <368736f6-7eea-481d-b61c-513df246c554@oracle.com>
Date: Wed, 20 Dec 2023 08:45:59 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3 v2] SUNRPC: remove printk when back channel request
 not found
Content-Language: en-US
To: Chuck Lever III <chuck.lever@oracle.com>,
        Benjamin Coddington <bcodding@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-nfs@stwm.de" <linux-nfs@stwm.de>
References: <1702676837-31320-1-git-send-email-dai.ngo@oracle.com>
 <1702676837-31320-2-git-send-email-dai.ngo@oracle.com>
 <66BB600A-2C0D-457A-9A13-0F1D7F5E44B7@redhat.com>
 <A958C4F7-7DA4-4BA2-BAA5-9552388F5498@oracle.com>
 <689A6114-B5B2-47DF-A0D6-6901D8F52CBE@redhat.com>
 <AD542840-D60F-4446-8669-13123FF00703@oracle.com>
 <217964D3-3808-48E4-A879-37E4D5E463C6@redhat.com>
 <30058A8C-7A1B-4C48-A13B-B071424FADDC@oracle.com>
From: dai.ngo@oracle.com
In-Reply-To: <30058A8C-7A1B-4C48-A13B-B071424FADDC@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR08CA0030.namprd08.prod.outlook.com
 (2603:10b6:a03:100::43) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|SJ0PR10MB4702:EE_
X-MS-Office365-Filtering-Correlation-Id: ebbfa667-151b-423f-e141-08dc017b25f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	wVblTIi6NcIYJtgXTTGv3y2ks0lcjp8UkQSfcgSRjfT9SwjciUiwvThRXjBpNXJMVlBqay6kMvoG9HqKL+M5FCUT27l4vo8LHAWVB6TUEI3OLSVTDIejCKTGboL8Us2DQxB1YarULzgFXrjqhavNViFbZA4USqjhUifxVOxfOtnzJvug3/BeGgEzrauKw7vQvmhJtkFHIOJ5KB0ggGkySLYHf1H17paAEkKjL9Z29MHVfzRvanyhm23h6C2HCm+D3AwoR8Cj3asm1Je4fWVQPdXZVOuO5nYDxaLk44GCpIJD/WVYjBo5QbwYf2y71OnMdZc6++YBIEG4y4JLoYMvawSMpCnw6cdEvmj6f9PITPd9ReCYrlq3sGDkyKe84yU08HTcNCsrFyN1/IFv+rFJlqieLgDdjEH4jZ6ECLpjICdVfhtx+pJtX4nEsYDZWN4XFODGj2Jpr72DCZPrPUiBsClWVFRFV01mwsPjBqbcn3JLLp+xilmoHXBjd1j+qBRBqf2JzfIWXR4+1hGc/8MqxEcpN1R2KnQxLE0cYdndMiHsDFcULwOS4O/6kK9YoiWCZbsoACrO1VnV1zCCa478CwsOcJL/KjTU3TMu/QMtKIzq5icyOi8VKRzOfZCPc4xz
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(376002)(136003)(396003)(346002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(9686003)(26005)(6506007)(2616005)(6512007)(53546011)(41300700001)(83380400001)(54906003)(4326008)(8676002)(8936002)(2906002)(6486002)(478600001)(316002)(110136005)(66556008)(66476007)(66946007)(4744005)(86362001)(36756003)(31696002)(38100700002)(5660300002)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UFdkNFpNMEhCS3dZNUg5bS9rbmJ4M1cyM1NTcktMVFUvRWdFV0dvbUhieE1E?=
 =?utf-8?B?V2tRb3N5RUMrQU9kMUJKLzlKa3hWckFSSnN5NmZCQ2h2bnlQSWhVRGZWd0hm?=
 =?utf-8?B?K1hpUVUyQytXSVhTdjJsNzZGZm4yRWRlNjliTzRIcmc5K2JucHhYbGJsOGh5?=
 =?utf-8?B?ekxOeUE3bDBVeFRFRTdFVWcrQWdLMEx0b2loTlh0eWpyQmx5S293b3BsWGNr?=
 =?utf-8?B?MWFndUM2QkZvZ3hMQ0pnaFc1Y1E5UUUvSlIzdjJlVTlnd2RsWDVCUVRiSDdZ?=
 =?utf-8?B?RUF0L1BxbTNsckQvRDUrbm8zdUZ3SGNkUXQ5eDh6S0p3RDkxbGIvamp3NW84?=
 =?utf-8?B?eGhUL01JZk9TRC9CSWsrcDVwUWZySkhyK0I4NjYyaUxqU2NVMEtieFE2TnF2?=
 =?utf-8?B?MUp0Yk93SWM1ZHJ6cGtWMkl6OVNYclgzOXVwWFRnNlNHY3AvZWpiWk14QUdD?=
 =?utf-8?B?UnRRdzNYbWhqTDB1TTl6MjFFcmlHelBZZVNYTm41RnVRVlozaDF1T0N1WHYw?=
 =?utf-8?B?U1J5UDlmcHBuNng4dUNIRFRvTmFwR2ZiVTlNRkdqQ3FoZ01ESTF5RGJvdDJ2?=
 =?utf-8?B?ekU5cHdPN0ZrSkFvYTg0Y2ExemJSMUxxL0NsM3AwTit0VGozWVFJSWRPWjFW?=
 =?utf-8?B?QkRhMnIyeVMzcHJ5MEZWL0E3YXkvNWJISnN2VWRmL3hnQ1NLbmt3a0pnNEJF?=
 =?utf-8?B?RjZZRUtnSFNQdDY5Z2tmVFFOVWxodnlWOTEwT3lxcHBnSDc1c0NJczVvYTdV?=
 =?utf-8?B?M3pad1FKalY5U01sWVJSK3JCNDFsZy9ma1RDZzN5U05jTlV5ZjZtbEErQUhL?=
 =?utf-8?B?WE1Fb2hmYmprOTNWNWQ5Q2lnbWNaUzJMWEQ5L1hJRGZZcEpZZmZ5RGt4dUlT?=
 =?utf-8?B?V0lUNXVTRUtLU0dscUw4cWdISjFRbitXSVd4amNwN0lGYVFVOXgxeXUzd2xD?=
 =?utf-8?B?ZHgxQ0RCZHVENUNqYjJFQldqK2xVQ2lWdll0NDhBdU50R0M0YlArMUF5a0tk?=
 =?utf-8?B?c2RJK1h0akorbkU3d0NLVDM0QWltcEc4dXEveWp5UUprSmd1RDE3OEZiMUh4?=
 =?utf-8?B?ejhjR2lqNm83SXFYQk5rbW1MOGhJakdUSDdUdGNNR0x4UkpzVjZPNHFGNHRz?=
 =?utf-8?B?b0htMzZtZ1pQdzEycFFZUUw3ZUJIU1V3aTNTSS9MaU5jNnZhdmVRZ1d1Wk4w?=
 =?utf-8?B?L25qdmVvOGl0LzVWMzVXUmppYkZ3Wk5VUFBFRCsrbTNSbTNVakRvWFJhTCsv?=
 =?utf-8?B?UE9hYmVUUmtrWFlYZ1pMN21Mc1NBTkJzTHJvR2VwNmcxNVdoMzFTQng4WFo1?=
 =?utf-8?B?MUo0dDcyNHpTN1ZERGs0S080Qjd4UlI1Ni95Q0lQSE5kUUx3QWY4UEo1akIw?=
 =?utf-8?B?MHlBclF1MlBYamNRSEx6a1NpRG1yVXR6cisycEN6WUtQRWxDT295ZDBCWTBM?=
 =?utf-8?B?R3ZLVXJjd2t6Y0RHUmVnR3ZmeU90c25iT2M3eXZkbEVMVVc1WVB5ZWJoRHZP?=
 =?utf-8?B?Q3QwaE8wTnoxN2FkL0FNT01pbjNvRFJWSy9tNG02U3hWb21ZcG9lQjVUY2tY?=
 =?utf-8?B?dUNHdHVIUlkzMGpqSjQxTjFyWDFqNWNQdWM3QkREUG1hUU9TdGt1QXF5bSta?=
 =?utf-8?B?YTVuMkMxRVVTVk5lVG0ySzlicHI0NzJZOG9MSGVxaG9XSS94bkhGRlFwZ2Fy?=
 =?utf-8?B?OGhuQVVZQVJyUlg0aWgySzYvYkhMQnZBRDVPTGhUR2Z3NGxhNjIrTFNhZ0Ey?=
 =?utf-8?B?RnJ3LzFQNG4xOWFQazE5bFA5a1JheC9FUmU3cnkzN3ptbTlYNXBWYXowN2tN?=
 =?utf-8?B?aGdWWFdza2tmY1dWaEpFaGRRTHRSbHIxSEc3ZVBpTW4xbThkTHZ0WUxXVDJI?=
 =?utf-8?B?Tmt4VFJCcm0vYTM1YzdCdkNGWVJDem5GSXVVaDh1aGJGR3M3cHRYSTEvUkRZ?=
 =?utf-8?B?N29DeDRaWEd0dmJsZFFEZWxwOFVEWmVGQUFJVXZkUTM1eW9BNExOaGxBMURV?=
 =?utf-8?B?eTRpTTRSS2kzL0NoT0E3UW5DOThGei9sR2x3U0R2MkQyekd2dlZBd0gySVYy?=
 =?utf-8?B?SmxkNDI3SzlxV1hZcWpxSDFBclFrMEdzeXRrMVVwSHFyM0lVNldlejhsMG5V?=
 =?utf-8?Q?lJyaA4m+uujevJI0+BjS4/GO1?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	48ORbVNT3wt/kN1RKkiT4Q2FcsR2Oa1AA7a3aLTBfd0HxerRNn8BqYxtcSAAIslzIiM+a6WeuSuaqXCen5vWVXXZc3PzcmdnYdOS/NQGOLuEVBLYSYBivuOR2crxBJ6w7G+CuRNvolNax7gheroh78XPB8f6qGT0R88NtAJLIumf0nFfeZkGgAuEmvz6+B02IF1UXAcRXOhsVUlg4T3+kmYVgzuoULgCQiu1i0Cyyh3orAFd3px/FIEPvixIZKFOjPu4sMECt5YvLr//Ea5+x2yZv5ddKvx1p+QxVvW3U7P06iw/BoOgTWPKauUwxMyqnZqwV6X7e+YpSYLXcNHNovTt2CBDWvfKWkwRpA+AnIIM1QCouHNpU/yQFFz39B1kRTW5G+UUuK2WndGUxDXUez6m8IswH9O0NeuhwFnarL0wB00csEfZjm54Nbcp4EbTWzSQSwj/cTPjCZvQtYpV3iHcXlxx1YIiH1+2FzgX300PlEJlRQ6SxTQpyneS8pEMqn4c7lIVVhoxsy6l6WqhmYKrgGdet/uRDxcO7HpAmD9b9myW24MZpE3c3OxoUQ+5QmR5pN7egbyvawbDeXnuSX9AGUGWO/xXN11kMcvenXI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebbfa667-151b-423f-e141-08dc017b25f3
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 16:46:01.1473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AuJS4fd7Cd2vH/Iytl+6YWp0rsKKNiz05D7KPkpP3xEnw2g6mCkUB1yIWcu2oo08xfWaLBd8FI4gPeXEE1A4mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4702
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-20_10,2023-12-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 mlxscore=0
 mlxlogscore=988 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312200119
X-Proofpoint-ORIG-GUID: rIsXv6Yokh4l0kSkdGLWDKoh8V2yBujB
X-Proofpoint-GUID: rIsXv6Yokh4l0kSkdGLWDKoh8V2yBujB

Thank you Ben and Chuck,

I will add a counter in svc_stat as replacement for the printk.

-Dai

On 12/20/23 5:54 AM, Chuck Lever III wrote:
>
>> On Dec 20, 2023, at 8:04 AM, Benjamin Coddington <bcodding@redhat.com> wrote:
>>
>> On 18 Dec 2023, at 10:05, Chuck Lever III wrote:
>>
>>> If you have one or two bugs that are public I could look at,
>>> I would be really interested in what you find with this failure
>>> mode.
>> After a full-text search of bugzilla, I found only three bugs with this
>> printk -- and all three were cases of kernel memory corruption or a
>> crashed-then-restarted server.
>>
>> It's probably safe to ignore my feelings on this one. :)
> Thank you for checking!
>
>
> --
> Chuck Lever
>
>

