Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 554676A2A97
	for <lists+linux-nfs@lfdr.de>; Sat, 25 Feb 2023 16:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjBYP5r (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 25 Feb 2023 10:57:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjBYP5p (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 25 Feb 2023 10:57:45 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 912EA113DE
        for <linux-nfs@vger.kernel.org>; Sat, 25 Feb 2023 07:57:44 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31P4OD4H012513;
        Sat, 25 Feb 2023 15:57:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 cc : subject : to : references : from : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=3jcV4uSYQVd3ORPCGU862R02eI5vk8LkNQhSwdrWwyU=;
 b=LnbJb5nrkDkVEzBxioKpcR+62E6i+MkRGiXX4DtlrpakOO6Z9S4N9PGE5VgS5xWlh/cT
 nkk9zaAR4nztgSd4iChnpfaQXh6Rt5NFMrAar/E23g0wiF0PS1i1BUFu7KGUHE55Sgmq
 ihEQu3oKQc1ISD2/OtUnw9QIGP31B/v8updqsHGMAOiZ8GJE+g4ZnrhDnwjfrjiO85gJ
 E5kL1BSqz+FI38Q2Y5pKzZWldSozWsTe9KsSlryGrTGc12usXCoFGsxM4eT5H/2G0yga
 4h/Ana6KC6FMDvykGINCNRzy8L/4LvN4vnINYc7i3868+dR3IN7Q/BC+T2XYZo+r1KTl AQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nyb9a8w1u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 25 Feb 2023 15:57:21 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31PFpagq029360;
        Sat, 25 Feb 2023 15:57:20 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8s99vj5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 25 Feb 2023 15:57:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B7ElnKWE38IaVKecYvHXwn4XtDiZQEmbEMO4Sg9XICneAPQ/YJWuDtJEra3iEIrpye4mnXRLc7aZoxgA1hYwmZPL0tiHdR/HKTMGP9cE/v9erEancp+qOI1jMpar/qXwTaxwYHoGAkZTIJ0AX7MyIioAomMSMQ4GH2R61L/Fh2HqSk7UCG57UeiDgObzVg5gR8Qlb7j692nsUR3Ty0LOjDt/FRk54fvQzx6PGuf/RbNUCsD3lpoQdG8Z31j5jr+4VM24odfAnC6XFdlMIab1/7LOSuQhDAchTmKK6RrzPTSJxCdHmPTiFboq4Rh4jo1plz8Vse3Fg1oTdP1IPMyQ4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3jcV4uSYQVd3ORPCGU862R02eI5vk8LkNQhSwdrWwyU=;
 b=QsbbXdOg36tfudmTYeP5I94G6uvQ+/myyFURpfoJ3gwhoXUO4BQOaTw5n58m1fjxIuW34WGoP3kqvcK28DgtJC0LW7vhTNojpQcaYXUwcltYq/g0Q8JJxNIekThhXCFCJtHJ1TrID8e+baOffZ+II/gVvwsnnTW2V/8O4uvYNuAMgZcMgzt35Q+0uvvLX4J8lg2gx5w1FTXcEzLAaylzvBHSX2b90iJQksOnpprnv47kpi2GJea+yeTJRkkcRv7/ARQNUucwLJNtWli2Ok0lXIuwXDUK6nHpGSe9UgzS2Wuzlf9bQy7g2RO36SQ9MrDPAAGeRRIh6MNjLp/jlBJFmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3jcV4uSYQVd3ORPCGU862R02eI5vk8LkNQhSwdrWwyU=;
 b=pPq4fdylyyzzbIq35+NijPTvMdW2vSwfjsY/hwFeXWCWPAXD2/n5/4aKBo07qklEapCOnrtgAlZzTprbTEgTj3wHWEx0BGFy0ORM+h8nUtxoNFaALW4K0cNQjE4p1mcCPhu9WZIuwl5Owilsjci/Nqaawx11V2Y9dykFh3/MqSE=
Received: from BN0PR10MB5143.namprd10.prod.outlook.com (2603:10b6:408:12c::7)
 by MN2PR10MB4174.namprd10.prod.outlook.com (2603:10b6:208:1dd::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.12; Sat, 25 Feb
 2023 15:57:18 +0000
Received: from BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::5dd1:9552:42c3:160f]) by BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::5dd1:9552:42c3:160f%9]) with mapi id 15.20.6156.012; Sat, 25 Feb 2023
 15:57:18 +0000
Message-ID: <f7c1e360-9d93-c522-b24a-5aeecf9a17f0@oracle.com>
Date:   Sat, 25 Feb 2023 15:57:12 +0000
User-Agent: Thunderbird Daily
Cc:     Calum Mackay <calum.mackay@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, Dai Ngo <dai.ngo@oracle.com>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        Frank Filz <ffilzlnx@mindspring.com>
Subject: Re: [pynfs RFC PATCH] nfs4.0/testserver.py: don't return an error
 when tests fail
To:     "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>,
        "J. Bruce Fields" <bfields@fieldses.org>
References: <20230222134952.32851-1-jlayton@kernel.org>
 <20230223151132.GA10456@fieldses.org>
 <436117750.41744935.1677325526601.JavaMail.zimbra@desy.de>
Content-Language: en-GB
From:   Calum Mackay <calum.mackay@oracle.com>
Organization: Oracle
In-Reply-To: <436117750.41744935.1677325526601.JavaMail.zimbra@desy.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------i9w420MUgBFjHBuqKhfQS8Kl"
X-ClientProxiedBy: LO4P265CA0014.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ad::8) To BN0PR10MB5143.namprd10.prod.outlook.com
 (2603:10b6:408:12c::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5143:EE_|MN2PR10MB4174:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d6a895c-b081-4ed0-69aa-08db1748f8b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q0o2evM4S63B0cKbNfHylyhnIogrdlDfYqd3d8lqnjWCoI3C5q2ZuOKmA9+vEaru7TQVtSgqeQGVEvqo3qMZnTP3YTttHeVMlNRfyBwJyWphkCnElEpXrk9oCoewcd2h6MI+bNH9z2/qGdracMlWmMDNveGh/TdV/sjZ8bgGPue21JsPabpUcTtTwOm42UfEiVKtkQQ5hsiwdmtAu6F738nKIUHFYEUNz31ebo8AVyLwPZd4sYpkCc/4s3S2ddgh3fAELg3xT0qyt1YuQpZKbuD/J0gyLfk3ysH9lXjZrMKpJdQ293ZUB8p+e21IFhkH8ckR1VYFup4JJLrTm3uvAaJxZWUMju9ZYQBbPzP9xEQ0vkOAGQEKP4AJ/65CC8Zf9OWH0g1AKlFKzL3GxR3jDkPgfWZ68cszXWV/bbCWEsaEnQVwwnWxRMy8lVhwf9GpIaj4I4Q1/bM+PMSmJK3+uoifpPD0kDNwLLWRjmF1IdHR0/rODiUQ96OMbyFYvmISjRg6IdW1IjfLqeOwrjBnQx23HVoS4eaaYsLZNmZAyWlSnBitcPdmS0x7d3QQsPilffydJMVZL8llhmllq+zMKxrvR8yuD31m+qZq7ZOY9lZ4Co6K+wcfiQj3l42XDnbr7hciJXZwtGpXyBcvk/JpE02sLH4rE9pXFIcTJQDr+2l5YRC1HXxnpSf3gR4N595xRji0/qReB7MECvmp96wgHlO31sAzNyO2Kq9cb88ydEo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5143.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(136003)(376002)(396003)(39860400002)(366004)(451199018)(26005)(186003)(33964004)(6512007)(6506007)(6666004)(478600001)(2616005)(53546011)(21480400003)(8676002)(4326008)(66556008)(66476007)(66946007)(316002)(36916002)(6486002)(54906003)(110136005)(38100700002)(86362001)(31696002)(83380400001)(2906002)(36756003)(235185007)(44832011)(41300700001)(5660300002)(8936002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkdFbHVQamNjYmRNSi9tbXhmSWFnUEVWRzR0VG00L3F1bWVUWGsxSVJYLzZF?=
 =?utf-8?B?cE85bE1aZzN6TFlsdUZPR0NDRmlsRmU2YlZaczlKbmNrTk5XR1oyL09GNWgy?=
 =?utf-8?B?endtQXJKcm15NnJ6MExoRDFGdTJ4VTVINVNFTmplM1d3ZzlOcVdCY2h1N1FR?=
 =?utf-8?B?dUlkeDRLWlpyaUtja1g5ZVlFbUlUTDkxVWdVcGZWSW9IUTk2VjU5b3JDQVBS?=
 =?utf-8?B?QUFWZVZQeHFSa21oUVFvTmJsVjVraFRoZzBBRXZwSGI0RDBsSDlGRWRaZGdR?=
 =?utf-8?B?NjVCaDJvZlBOSzNrNVVZRmcra24waW1MNjc0SUVaa3VlMk5LQkJaWUMyZGsv?=
 =?utf-8?B?VThQVFROalpTR2ovZUVVMXVzb2RVVkh6dGZvTFh2dm5FazJUY0I2L201NGxa?=
 =?utf-8?B?MXdzQU96MDJUMzFkMHdiT3ltanFJTnViVXVrdkFsUmdVQ0dFdm1scjM5VFFT?=
 =?utf-8?B?cUs0MHdJaEp1Uk5KR2lFRlM4SFovRWRjekhGaFkwVDhMWW9NaG5rMFpoTkds?=
 =?utf-8?B?NDdxWnY0dGFYbHlhWVZlTGRlZUxEL1VWT0wxRkV6VGlMYnN0N2toZkhnajl6?=
 =?utf-8?B?UStwMUgwUWNtS2MwL1o5U1o1Ym5CaEpqVzRnbDVXcWRlZWRkeU43WDV5amJ5?=
 =?utf-8?B?cDBwbDFiYmpVcjZLWWhPRU5PMHRoZ05mUVRNNFcyVkljQmdUZWtkczZXeVZu?=
 =?utf-8?B?dGhFYmRVMzd4SzRCZUQ2endWenE0bnRnK1lmbW1SRUpETU5EY2tiSVdDY0M2?=
 =?utf-8?B?QXdiZXNXQWpXVWNCQk0yNXM5Y3lSYW84Z3ZJVi9Kc2JvdVpNWTJsOHhQU3Nv?=
 =?utf-8?B?dFFkS2NBTUd3Z0VScnA4UFBPTE9ZWktiN1lEaVQ0N0R2WlVwU2lTUHZVcEtU?=
 =?utf-8?B?QjNncGZEaDZ4STRISkwzb0dJc3pNYUdUMjd2UkNGcGlkZlVMc2crMTR6aWdy?=
 =?utf-8?B?U3NhRGoySzFhMkV4MjVFR2o1czVINmRrU2hUQnpiU1lGRkJERXFWTkVrM1E4?=
 =?utf-8?B?NExPV2gvK1R3aFZzTGZ5c1pPVU5WenBJTFArK3F0TkNpd1dNRUpxY2NTM1NT?=
 =?utf-8?B?UkRYNitSeituajgvOGg1azBZaWJzbTRCSVVhZ1ZPL0dTYUd5ckdXSjZVSXo4?=
 =?utf-8?B?QktxUXZXb082K2NCRkVqZmJRclkveGFWNS9maWhTZWg5WjZVTElCQTEzZmNr?=
 =?utf-8?B?R0FtUExXZ0tuZGhWQ1UxK3FSdldDL2Q4dGJWU0NoOXNFajd4dzRkaWllMkV1?=
 =?utf-8?B?QUdROEZzL09keDJncmkyUllOWTl1QkZ4dTRnQzFnMVpWcDVyRDkwRzZaTjBR?=
 =?utf-8?B?cGNOb3g5SGx0WkJocWVjTUVwdm0xSVRSWldGVEd0YmZKOGlVUldxTFllNGVa?=
 =?utf-8?B?cGl3VzEyazhkb0FZRkw2NFJ4T2tDK2NvdEE4OTdDUlpTR1B5Y1lOY0hodVNt?=
 =?utf-8?B?eVhZaktHYSttczdSL1l4Uy93WktBVUpZMXZuTXdXeUhJQzE2WWRhRExCaDZ3?=
 =?utf-8?B?dE8va2h2RTQrV0k1MW5qRDJKTTRqaWluc251MlpINmtqMi9aUk9DSHo1YWlE?=
 =?utf-8?B?Y0xmeU5jUkNaYVp1ZzFjai9KSU83dkVJS0g5alkrUlFDZXdOWVZoSjVIY0Nw?=
 =?utf-8?B?RCtGUERVdCs3b1pSY2NJWGhKeU9KdFEwYU1yNTAyay83RkhINWZaSEZic2VF?=
 =?utf-8?B?dXIxd0VrQ3pjd1Q0ZUVKeUpOSWFENmUxTXFUR0F3N2NVdlRjakJOS3hja2gw?=
 =?utf-8?B?V2JDbk5pSHE2SzRhL1RuYWdreXZBNXRJVWNzOTdhTmxwd2hVM3FtL0w5Z0Uv?=
 =?utf-8?B?Zmt2VVpNWDlSelJPRk91OFMrd0YvM1pTR3AwWDYwMVV1cmwzN1hDbUw4cnZn?=
 =?utf-8?B?NmNDVGR5MnA1OVBuK2E1M3JmcDFGT1EzOW4wNzFZWEFmUklHVzA1aUU2bFFw?=
 =?utf-8?B?aHUreUZKY20yMG5iUlNyaHFLdXQ5N2J4SjFkdG5GYTAxQi85c1o3QWFHclBz?=
 =?utf-8?B?Sk80QVRtUnliRUtzcE44QUVCMEF6NXBsRnpxcE1wM0NxZVlJTW5RUkErYjFN?=
 =?utf-8?B?OS9IRkdldEFQMVVYdkxlKzB2dVdYWGR3VWlOcTIyZGttazdqLzFKUFpFemVv?=
 =?utf-8?B?UGhtRnJSb0dLVHR5OFhaWkhoWnpOeGNXcEd5OW1vTUhOZzRQYXh6dWdHVzBB?=
 =?utf-8?B?Y1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 955gYcEyjS36chm7BunDKjaoaqMy7HUxbSvJuG88rlY8HBnHkQncfbexBTUJPX1bWusYb8qVxjpr3nzWEbcCNLAbl2v3+vWpBD6cWWwQ9OkOSC+gDVbuN/QWU2ZR11ryXYCyPzUcFDClrzzVyVrJ87Zdm4++qb2KGIz8j11MLqHz8iERsCPfd+Hf4GyDqUL1kuFkqPxJI2gU/Ss+lyozkLYzpbQwIZWDOglxm4nPFERoSVGnWs3g/W8DX/1rsK0ep3qIJbIaiH751GGjquUYXrWhE/tvNQM/rYoryTbKoG6Pvf42RrSPW6fCVR7yajSDerRjLMgZ5Vk7C86hN2FEwW209EyzfRbvx7nJFz47prvvB8L8f6MLjDC0OzqyRwFhp3LwAcBO3DcXt0x3pPK3dhCHR6ohxF9a0Nji+2XF9qCYxCFAh7EkOSn376o5CrQS0Q8d5Hgk6dBkFQO2gs771KUroxopNOMB53DL1TXV1zem9p1kGSIiud6BoMos0jChedElCq3F0ZwDWj7S7XPrJuycHM7i2LsqdlHKRoEy9vhDfzV7gp+7xJCou9w2svdJXGn1U0H+epxAPodJnpKiEZDNfSfF1+Y6E3+wSZXUjEfIJb3PyFKm8iBeHTBsZ8Y00efr5QQUID16HzOno/Wpje3aWYMIO4OYC8byYE7myMxGnC3t0XfvBWb8C8oVrYC/LIjkW5WLseIobz+/tsNIOc+b2as1UtRk7rPgMhl5s32Mb3Cv5KrSm/Lm5UzBRz4hmu/nDEcGjr8LZR55rB21g+skDN40TTFWxMUt37IIHZwrwPWjQu0AT/6iKcpvhR99fVyeSJuf85UEt3eNRFZ78AN9yoXMzTXxBfyXzbhfE6u41U+pKpMvtXUSXDD9jTlC
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d6a895c-b081-4ed0-69aa-08db1748f8b3
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5143.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2023 15:57:18.3617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BHXUj3i8jE0SD85CXl0LMUEsU5sdUtNZlSlwSL7Bh3IGOYUcrxgW6WcNr9HLns7gyLpPix4+ljidu1t9QCFd8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4174
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-25_10,2023-02-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 spamscore=0 adultscore=0 phishscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302250132
X-Proofpoint-GUID: ziUaBMQfZGit5uYSmk25t2breaftQ4QH
X-Proofpoint-ORIG-GUID: ziUaBMQfZGit5uYSmk25t2breaftQ4QH
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--------------i9w420MUgBFjHBuqKhfQS8Kl
Content-Type: multipart/mixed; boundary="------------R2N65aRknc4N6z2TuELlvOIC";
 protected-headers="v1"
From: Calum Mackay <calum.mackay@oracle.com>
To: "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>,
 "J. Bruce Fields" <bfields@fieldses.org>
Cc: Calum Mackay <calum.mackay@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 Dai Ngo <dai.ngo@oracle.com>, linux-nfs <linux-nfs@vger.kernel.org>,
 Frank Filz <ffilzlnx@mindspring.com>
Message-ID: <f7c1e360-9d93-c522-b24a-5aeecf9a17f0@oracle.com>
Subject: Re: [pynfs RFC PATCH] nfs4.0/testserver.py: don't return an error
 when tests fail
References: <20230222134952.32851-1-jlayton@kernel.org>
 <20230223151132.GA10456@fieldses.org>
 <436117750.41744935.1677325526601.JavaMail.zimbra@desy.de>
In-Reply-To: <436117750.41744935.1677325526601.JavaMail.zimbra@desy.de>

--------------R2N65aRknc4N6z2TuELlvOIC
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjUvMDIvMjAyMyAxMTo0NSBhbSwgTWtydGNoeWFuLCBUaWdyYW4gd3JvdGU6DQo+IA0K
PiAtLS0tLSBPcmlnaW5hbCBNZXNzYWdlIC0tLS0tDQo+PiBGcm9tOiAiSi4gQnJ1Y2UgRmll
bGRzIiA8YmZpZWxkc0BmaWVsZHNlcy5vcmc+DQo+PiBUbzogIkplZmYgTGF5dG9uIiA8amxh
eXRvbkBrZXJuZWwub3JnPg0KPj4gQ2M6ICJEYWkgTmdvIiA8ZGFpLm5nb0BvcmFjbGUuY29t
PiwgImxpbnV4LW5mcyIgPGxpbnV4LW5mc0B2Z2VyLmtlcm5lbC5vcmc+LCAiRnJhbmsgRmls
eiIgPGZmaWx6bG54QG1pbmRzcHJpbmcuY29tPg0KPj4gU2VudDogVGh1cnNkYXksIDIzIEZl
YnJ1YXJ5LCAyMDIzIDE2OjExOjMyDQo+PiBTdWJqZWN0OiBSZTogW3B5bmZzIFJGQyBQQVRD
SF0gbmZzNC4wL3Rlc3RzZXJ2ZXIucHk6IGRvbid0IHJldHVybiBhbiBlcnJvciB3aGVuIHRl
c3RzIGZhaWwNCj4gDQo+PiBJIG9yZ2luYWxseSB0aG91Z2h0IEknZCBjb250aW51ZSBtYWlu
dGFpbmluZyBweW5mcyBvbiBhIHZvbHVudGVlciBiYXNpcywNCj4+IGJ1dCBJIGhhdmVuJ3Qg
YmVlbi4gIFRoZXNlIGFsbCBsb29rIGxpa2UgcmVhc29uYWJsZSBjaGFuZ2VzLCBidXQgc29t
ZW9uZQ0KPj4gZWxzZSBwcm9iYWJseSBuZWVkcyB0byBzdGVwIGluIHRvIG1ha2Ugc3VyZSB0
aGV5J3JlIGhhbmRsZWQgaW4gYQ0KPj4gcmVhc29uYWJsZSBhbW91bnQgb2YgdGltZS4NCj4+
DQo+IA0KPiBXZWxsLCBJIGFscmVhZHkgaGF2ZSBhIGZvcmsgaW4gZ2l0aHViIHRoYXQgaXMg
dXNlZCBieSBvdGhlcnMuIFRodXMgSSBjYW4gdHJ5IHRvDQo+IHBpY2sgdGhlIHBhdGNoZXMg
ZnJvbSB0aGUgbWFpbGluZyBsaXN0IGFuZCB0cnkgdG8ga2VlcCB0aGUgdHJlZSB1cC10by1k
YXRlLg0KDQpoaSBUaWdyYW4sIEkgd2FzIGdvaW5nIHRvIHRha2UgaXQgb3ZlciBmcm9tIEJy
dWNlLCB1bmxlc3MgeW91J2QgcHJlZmVyIA0KdG8sIHdoaWNoIGlzIGZpbmU/DQoNCmNoZWVy
cywNCmNhbHVtLg0KDQo+IA0KPiBUaWdyYW4uDQo+PiAtLWIuDQo+Pg0KPj4gT24gV2VkLCBG
ZWIgMjIsIDIwMjMgYXQgMDg6NDk6NTJBTSAtMDUwMCwgSmVmZiBMYXl0b24gd3JvdGU6DQo+
Pj4gVGhpcyBzY3JpcHQgd2FzIG9yaWdpbmFsbHkgY2hhbmdlZCBpbiBlYjNiYTBiNjAwNTUg
KCJIYXZlIHRlc3RzZXJ2ZXIucHkNCj4+PiBoYXZlIG5vbi16ZXJvIGV4aXQgY29kZSBpZiBh
bnkgdGVzdHMgZmFpbCIpLCBidXQgdGhlIHNhbWUgY2hhbmdlIHdhc24ndA0KPj4+IG1hZGUg
dG8gdGhlIDQuMSB0ZXN0c2VydmVyLnB5IHNjcmlwdC4NCj4+Pg0KPj4+IFRoZXJlIGFsc28g
d2Fzbid0IG11Y2ggZXhwbGFuYXRpb24gZm9yIGl0LCBhbmQgaXQgbWFrZXMgaXQgZGlmZmlj
dWx0IHRvDQo+Pj4gdGVsbCB3aGV0aGVyIHRoZSB0ZXN0IGhhcm5lc3MgaXRzZWxmIGZhaWxl
ZCwgb3Igd2hldGhlciB0aGVyZSB3YXMgYQ0KPj4+IGZhaWx1cmUgaW4gYSByZXF1ZXN0ZWQg
dGVzdC4NCj4+Pg0KPj4+IFN0b3AgdGhlIDQuMCB0ZXN0c2VydmVyLnB5IGZyb20gZXhpdGlu
ZyB3aXRoIGFuIGVycm9yIGNvZGUgd2hlbiBhIHRlc3QNCj4+PiBmYWlscywgc28gdGhhdCBh
IHN1Y2Nlc3NmdWwgcmV0dXJuIG1lYW5zIG9ubHkgdGhhdCB0aGUgdGVzdCBoYXJuZXNzDQo+
Pj4gaXRzZWxmIHdvcmtlZCwgbm90IHRoYXQgZXZlcnkgcmVxdWVzdGVkIHRlc3QgcGFzc2Vk
Lg0KPj4+DQo+Pj4gQ2M6IEZyYW5rIEZpbHogPGZmaWx6bG54QG1pbmRzcHJpbmcuY29tPg0K
Pj4+IFNpZ25lZC1vZmYtYnk6IEplZmYgTGF5dG9uIDxqbGF5dG9uQGtlcm5lbC5vcmc+DQo+
Pj4gLS0tDQo+Pj4gICBuZnM0LjAvdGVzdHNlcnZlci5weSB8IDIgLS0NCj4+PiAgIDEgZmls
ZSBjaGFuZ2VkLCAyIGRlbGV0aW9ucygtKQ0KPj4+DQo+Pj4gSSdtIG5vdCBzdXJlIGFib3V0
IHRoaXMgb25lLiBJJ3ZlIHdvcmtlZCBhcm91bmQgdGhpcyBpbiBrZGV2b3BzIGZvciBub3cs
DQo+Pj4gYnV0IGl0IHdvdWxkIHJlYWxseSBiZSBwcmVmZXJhYmxlIGlmIGl0IHdvcmtlZCB0
aGlzIHdheSwgaW1vLiBJZiB0aGlzDQo+Pj4gaXNuJ3QgYWNjZXB0YWJsZSwgbWF5YmUgd2Ug
Y2FuIGFkZCBhIG5ldyBvcHRpb24gdGhhdCBlbmFibGVzIHRoaXMNCj4+PiBiZWhhdmlvcj8N
Cj4+Pg0KPj4+IEZyYW5rLCB3aGF0IHdhcyB0aGUgb3JpZ2luYWwgcmF0aW9uYWxlIGZvciBl
YjNiYTBiNjAwNTUgPw0KPj4+DQo+Pj4gZGlmZiAtLWdpdCBhL25mczQuMC90ZXN0c2VydmVy
LnB5IGIvbmZzNC4wL3Rlc3RzZXJ2ZXIucHkNCj4+PiBpbmRleCBmMmM0MTU2OGU1YzcuLjRm
NDI4NmRhYTY1NyAxMDA3NTUNCj4+PiAtLS0gYS9uZnM0LjAvdGVzdHNlcnZlci5weQ0KPj4+
ICsrKyBiL25mczQuMC90ZXN0c2VydmVyLnB5DQo+Pj4gQEAgLTM4Nyw4ICszODcsNiBAQCBk
ZWYgbWFpbigpOg0KPj4+ICAgDQo+Pj4gICAgICAgaWYgbmZhaWwgPCAwOg0KPj4+ICAgICAg
ICAgICBzeXMuZXhpdCgzKQ0KPj4+IC0gICAgaWYgbmZhaWwgPiAwOg0KPj4+IC0gICAgICAg
IHN5cy5leGl0KDIpDQo+Pj4gICANCj4+PiAgIGlmIF9fbmFtZV9fID09ICJfX21haW5fXyI6
DQo+Pj4gICAgICAgbWFpbigpDQo+Pj4gLS0NCj4+PiAyLjM5LjINCg0KLS0gDQpDYWx1bSBN
YWNrYXkNCkxpbnV4IEtlcm5lbCBFbmdpbmVlcmluZw0KT3JhY2xlIExpbnV4IGFuZCBWaXJ0
dWFsaXNhdGlvbg0K

--------------R2N65aRknc4N6z2TuELlvOIC--

--------------i9w420MUgBFjHBuqKhfQS8Kl
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEE1GBbrQYgx8o9Vdw+hSPvAG3BU+IFAmP6L9gFAwAAAAAACgkQhSPvAG3BU+J1
Fg/9GDpiDuTv/L9Lm6BIQ5wasqOZYzr5z5ykzfR0EDLXyFx/9xf+QNaZ3LEhUT6Tpg1eQuVcSDDB
PEbEwY5L6xQtH00s/SFBsmlv4MeV06zznMJpxr/EpQPtrQ5xaaWZxOy4YxP9p9MNljK6MPwu+gUf
dzdIm0ZBPh1hdmk8bxL2tcJXoOzJfTqvUm4wijIdebQ0Mi3Dj/d+gSkmp2LEcWsaqvrXPrQcG1an
5bV/XoFhwGWwbXBHtDa/AfoZhMt3o/w6/Nys2MkZd0ZHsrJjzvJ0t0G7bTG94MkB5rBdI3+6cyNV
73myFMJsVzSCvX5jE9TVTdvYn2spWlej82tUENfa7b0kjQ8FCg+S8F1KFcUDy2fOOvYUFgPlJaqn
4EcnVxRBEWrnYKEBpPVfkO9FRDsbFZdUcMo+itFVCt5NCzzdsamUVgMzEy39YZXqnmDv+c8kndQa
YwPqVPqNT7Ou3SOcjW1BGGG9W7+cgoF8zKR83Cn0AJxExgoFcdMAjUIenszKrKJCdsuhpoeQgp3F
w6FmSbCdhKIgX7y2hF45Xiidp609GPsjhablCpnKpDyPB3mnxN28z/jYnfch0RZNH6olVGbVdLkr
ZtStzTsZjo4qbDpSOetggxqdKQtzjXfuDVZIIU3DuBDR0Xe4qEIeMKjQlfWnJ76LC8mLwRLzAnmm
1g0=
=7uLx
-----END PGP SIGNATURE-----

--------------i9w420MUgBFjHBuqKhfQS8Kl--
