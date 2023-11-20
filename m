Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 913A67F1CE8
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Nov 2023 19:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjKTSuG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 Nov 2023 13:50:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjKTSuE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 20 Nov 2023 13:50:04 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C743BCB
        for <linux-nfs@vger.kernel.org>; Mon, 20 Nov 2023 10:50:00 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AKInusK003551;
        Mon, 20 Nov 2023 18:49:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 cc : subject : to : references : from : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=MfFpktFI5pGKnW3uw1DOovzF+NqaA2WxMPnul6FIyMw=;
 b=Xf8c6ilf5y1O4XiCE38o/BL997bb+NDrgkwntE89tG3ImwIWz43Hs99/MUzkcukp6sZC
 K1B6IVFmPYKbAswQpTLO7BWe0dzAwB7CdH4GanGHnG4VfIlgw0u3pp3B4B1HlmUmklvK
 dm2TwR1C4Cx9HSTimEsrhMdt+8oN/94bjmT+HM4SkfIVsqCyNGQSl/zNs7HlseJfZTkc
 RZgf5NJbpitl/Gd5C82CMPVHu0HGAJWo4cvCqazuaAQfMqRKCewi0OVxUBaZSjK0lax6
 7f+KwK0BIhK4Nribt9JPVr5FJNUGsH/71iecR7wrfMo8qS+SVd33laEA8iyRk4ZLb2Am zA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uekv2udf2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Nov 2023 18:49:55 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AKISXum022532;
        Mon, 20 Nov 2023 18:49:39 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uekq5hxsf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Nov 2023 18:49:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ihcPGnq7xbI8y5txvKhN7PcN6XpJyIq6pbdgPJoB5d37+lMrGj2y6VlfqcTUFOmfK8+YMlwV2Q52VtBSgEuXr81tgsjEd2MAAmI3XdfjL1HU8F8j8tZbiGAcgIStA1bUBxETQOXo9u65nCENDBMpfp3EVgrZy/+ci1uhC46W5ENvpSbFQi0LcvlHHUOQOuot/vC7Qzek8o7/KPACMYtS4oIxXzjvpIxC3ngAMBBMXZNln9NCKXxta98fEDTrQeosZWfHYCzS+oKfAQ2cJ1r4kDG3wU8tc9eT5J5zu8AJVe9pUyzr70M/C0Yv8YmUOhd56SJFCBu0UuipkQQxZZsNJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MfFpktFI5pGKnW3uw1DOovzF+NqaA2WxMPnul6FIyMw=;
 b=a3U6a5AFBpRIjm/7DKgLUTy0NRq7bzkOFTUuZEqHTyZkPGXyLOiFy0NkpDYeGeFgm25Vn6UJnAYXwF0g4Y/NrPmeJ0yhsvX49+vrKnpGMEWt+mbA3U+cDRqjSXMa7L1kESGYVGeU4TsKSXIVwIPIyEOrXpSsp/hX07u755OyNDpDKjUQy0+RosODHChgTdKvulP0wu0Gvy7Hvf725urTX+igCuAbZYn9CoW1ETeh9O2egROq92pnz5lRZk45HiQDqJ6jM9o/1gdKJSc0aT+AixZ5Q8GZ/x8LNXq9K7ayyXr9p0UNVDs3tPAA5ChFZJ7xpjdoYihZ0TBCREtptK7fwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MfFpktFI5pGKnW3uw1DOovzF+NqaA2WxMPnul6FIyMw=;
 b=ymhdGQQwL5x67RYYHTSMPKkmNbcCMfq1eX6WM5fy1Vhyz+LZl81eDilWdYi80fwBlwPiMSHKR8EVymfYkr/OI3BD1STdmMGpXes/Tn5Jid0o5CqwlZ4S6IWyEl4MHWdvXFfz1mSy6Q9mI/b2zKyLQjMT+wAaf4ALirm5zShYFs0=
Received: from BN0PR10MB5143.namprd10.prod.outlook.com (2603:10b6:408:12c::7)
 by SN7PR10MB6474.namprd10.prod.outlook.com (2603:10b6:806:2a1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26; Mon, 20 Nov
 2023 18:49:36 +0000
Received: from BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::6488:c4f8:43d0:97c9]) by BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::6488:c4f8:43d0:97c9%4]) with mapi id 15.20.7002.027; Mon, 20 Nov 2023
 18:49:36 +0000
Message-ID: <79012dcc-ac14-4219-9140-b8ad449acc91@oracle.com>
Date:   Mon, 20 Nov 2023 18:49:30 +0000
User-Agent: Thunderbird Daily
Cc:     Calum Mackay <calum.mackay@oracle.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "steved@redhat.com" <steved@redhat.com>
Subject: Re: Who owns bugzilla.linux-nfs.org - account creation broken? Re:
 How owns bugzilla.linux-nfs.org? Fwd: [Bug 218138] NFSv4 referrals - no way
 to define custom (non-2049) port numbers for referrals
Content-Language: en-GB
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
References: <bug-218138-226593@https.bugzilla.kernel.org/>
 <bug-218138-226593-fRCLxzGk3u@https.bugzilla.kernel.org/>
 <CALXu0Ucz2MGCYdMw74ZKGUj_hpGcLP-pxC=MSgpUFGU58=jc=g@mail.gmail.com>
 <CALXu0UdY=ZgcAqvC6Y-X6htxPQ9=XWemt8V4dxTA99wQmHKz=w@mail.gmail.com>
 <959BB15F-5B91-4413-BCFC-EDAC78EE32F6@oracle.com>
 <d8bb0bf43c8fe38ef83248fb55a9549919530cf2.camel@hammerspace.com>
 <095736A1-C749-4B8C-900C-C0471D8F8422@oracle.com>
 <9bb44f33-9900-44e1-813d-df1c60d8307c@redhat.com>
 <35ffafefb1596f4941513bc8dd51470fbee842d4.camel@hammerspace.com>
 <F12175F2-9CA3-4C6A-9089-BF5E62A196D0@oracle.com>
 <ec326d7e13d12c02fabf8a5fe46f2ad8bf66d368.camel@hammerspace.com>
From:   Calum Mackay <calum.mackay@oracle.com>
Autocrypt: addr=calum.mackay@oracle.com; keydata=
 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
 smRifw1wGg==
Organization: Oracle
In-Reply-To: <ec326d7e13d12c02fabf8a5fe46f2ad8bf66d368.camel@hammerspace.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------GDpZiNo3euNGABUG9sjfMvHd"
X-ClientProxiedBy: LO3P265CA0025.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::6) To BN0PR10MB5143.namprd10.prod.outlook.com
 (2603:10b6:408:12c::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5143:EE_|SN7PR10MB6474:EE_
X-MS-Office365-Filtering-Correlation-Id: c8d17ddb-85bb-4027-50ae-08dbe9f97096
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TcSfwu+9ZSTn0LoAaafIOvMcf1PJpkNdcFFqapNKY6ThyR/gi2v6riCOza/QZLNk9OJJj+mr9aZT6w6MpaxpYpgoifDsx/uEBZ1yfFh/+nhxutiZhMdSgrpMHLfznBbicA9RFvzbNVaDagRJB6UTxvW+sz75NSCRtA7l7lTq/oWh0ZsZR+ivFx3AtOM2fMfqtTGYfC7ay9RubkcxskY8lM/cKMMTOUPO5U8YIoGeN0huFCRgjJodaDDZ/4xYzsqe7Bo0tV8Eacm9qfXVn0EnLnyrFydlvvrXWJ7ClRiMxEg7sTv22Nh1LOAddSjorqCDl/ReR+pnOURmbypt/650L3b7Ps6WyiVbaMklde/U3m+9vvno9hEuhYvAKPfrGTrluUDfv45Ne8P+tB5v7Ng6ccSEKHOWtE30KngrBqRyQ2LSbUw3ckiHCVs8i0Evhl7qx3gauI/hLZh20yjYR3TTbQU6kPaUz/gJmEALogGEfXQ4jBHt2E23w2oUef38JfbgQMwqcAsIvsParFGkLR7z45agK7U+UKHwLAjDKwozztHYH1JqJhNVqagTRN1cN9KMrIrhdwGIMJH8EaC+ba6QFk5CwSQkCU423sT9W5ulYk1ASkxmtzUjIx/LSsDJWh4lQhlL8xB4CYgEvcqZ679U2inAzcbz2mILXMrc4HUlnhAeCJ1x9WRANWIaYRO2hvO/bB5O6x4wVhuD6NJSzpWz3g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5143.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(346002)(396003)(39860400002)(230273577357003)(230173577357003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(2616005)(21480400003)(316002)(6636002)(54906003)(41300700001)(36756003)(36916002)(6506007)(53546011)(6512007)(31686004)(66476007)(26005)(83380400001)(4001150100001)(6666004)(15650500001)(33964004)(5660300002)(235185007)(44832011)(2906002)(86362001)(66946007)(66556008)(478600001)(6486002)(4326008)(31696002)(38100700002)(110136005)(8676002)(8936002)(43043002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0QwWGQ5Q2JyM1U0eUNBd2l2eTdUTkNIZkplVUtwKzJKTFhnbVJ3aUJqeVVL?=
 =?utf-8?B?N0g2QzdoWkY1T2habFZGYjE4QUhKV1JqTkRLdHVzQXlzRGp5czY2anZKc1Er?=
 =?utf-8?B?VVZGUC8zYkFlVFhacWNYVkhBczhlbVA5RjhWUzVxSndob0hOYkpsRHRvT0Iy?=
 =?utf-8?B?cWNXblBaYW9lNW9Tak9tYXpIOWdxTU9PNm5VSGJLSFcycmxjQXhGV3AvOUF0?=
 =?utf-8?B?a2dzZDhYMVNRNGdLVDZ2b1UreDhqMC9VZzVNSzluL3d3ZVVxejFmdXYrNkFr?=
 =?utf-8?B?Rit4d09xd3ZVQ2lpN3I2bWVkemZkSkF1V0FGMmR0ZW54cXNheGlpbjZBaEdC?=
 =?utf-8?B?ZU9xaEFLS3laVXMyV2VrbDRVaEVwejBMQUFWcmdJeU43Z21YbUppL1ZnVENS?=
 =?utf-8?B?Zm5zRUd6WWliUXhtclBNTkQzbFlvYkMyUTZOUjFud05DYjk4TGhBTjE3SVY2?=
 =?utf-8?B?cE5GUnVvejZGSjRIZkIxajJKNythcmZkb2RRK1h1ZUZ3MjVtTEI5Z1JJaGhL?=
 =?utf-8?B?UmVad3J1ZEFVRGR6ZDBkdzBjVks0SXlCU1BvQkRYVXgxdW9TSTZPa2ovQVRS?=
 =?utf-8?B?NlExaEd1ekVyTmpPM25sL2hleFA1RUNRVjhSQ05hOXpiMEhsVCtodEZ0OFFS?=
 =?utf-8?B?UmtiU2U2NWNVeHlrSW9lUjVHbkhtcGZOM3g2NDdhTE51ZUFkcVFHeG9VMnc0?=
 =?utf-8?B?NjVPZVFDQytCbTVoNnl3WHhJQmJpelFmVWdFUmRaVThYeFB6MVdkSHorVk52?=
 =?utf-8?B?SGlRK01zWVN6YkQwRllzM2Y5QTFlVGx4bGExZkI4cjZqSXkrVnRDMmZueUNZ?=
 =?utf-8?B?bWx3RjFNR2ljMkh6ZXFPNjFPTzhRRTJwTG4waWVZRGRoNUZjRDNKWnhiS285?=
 =?utf-8?B?ZEo4Z3dqUTd5aG9GOVk4VTlMNkJvT0p0MjE0NU9FSEZUVEZINkRXY3lZVStC?=
 =?utf-8?B?MjhqaHNia21ZelphRWl0UldBQVRoMFpyM3ArckgzSFRLcFVHODAxMHQyQytT?=
 =?utf-8?B?RVZoR1d2RENzNXBQaFM1Qk1TNGlqcTAzOWFuRXhwV3dKOXByVVBiMG1PaENI?=
 =?utf-8?B?ay9rMnpkWkxQWUxHTGxndDNyRGVOSE1kVG1hWkNWekZieXcvTFNqV1VBTGl2?=
 =?utf-8?B?a1BVbSsxS2JxbEFEQWE4UjJuVTlRZllTMFl4b3NPZzhwa0VXWThkclRvZG9I?=
 =?utf-8?B?VUhNci95V3h2aHVrd3J6cGhxejk2QXcxL3ZnU0lUWGtXNElRSEMrd0FoT0xa?=
 =?utf-8?B?R1lYMG81dHhzMjEvZk0xOHN4eEo2VndIdHVjUVNsYUlJY002RGNTMWxQQWFC?=
 =?utf-8?B?bXN2RlFYTWJRTWxPZ0VFNXZuRXNmQVJ0eCtsWW5Hbi83S1lQZFFPR1d2eEEw?=
 =?utf-8?B?U1gzZmdNN1NUeDVyaVNsTllPSFFST1Ftc1R2NTBMQms0TytzcG9rdmR5dUNs?=
 =?utf-8?B?OWdrdnBPTDVISzJ3TThZeGUzZ1R2RzlmWkdQbVRjY2FGSGM4VUhGNXlYQzd3?=
 =?utf-8?B?ZVFxVDRUcGNQR09nQXFheHdHMEs5aEtEM0JjNzNtL2Rhc1V4VWVOUGNOZ3FT?=
 =?utf-8?B?NEl3UzJVY2dRSVpDWkw1ZTVuWmZQaW1lTTZsV2tsczFiSmlick5IWDRZNWl0?=
 =?utf-8?B?eDN0am5aeXF0WmpENWNEVm9kNGV6dEtPMjJUWDI4bzdzNjh5bEZyblBUaHNZ?=
 =?utf-8?B?ZEhRcFo4b1EwUEhWYSt1UmxobVpCME56S2FNY2ZHZzQxTzNKZHZ6R1hLNU1u?=
 =?utf-8?B?V21Lc0dPSFRsNkVZNGdrODdPckxBbFlzZlRXNklsQko5ZWJGcGlyS0lHTEVZ?=
 =?utf-8?B?OWJVa0lhQTNQQXd5bkRtdGMzQm83bnkva2FhNTk5NkdyMmJGMlkvdWlxM05U?=
 =?utf-8?B?UktoRFJoZExuRExDK2dENWdsN2tDN3BYOE5NNWw0K2s3blc5ckhmdWNDWHhr?=
 =?utf-8?B?ODI5N0lPaW9keWpBSGE2eUpXOHVHVFBHeTUrSnZtY01DdkhTeG5MQ0svQW1C?=
 =?utf-8?B?NjVnamJxV2dUZFRYaFFrR1FqU09GTy9rNHF3YlRvb2JYR2hiZ1M1ZGg3dTVX?=
 =?utf-8?B?WDdOd2phL0pycXBXSzRRbVNzKzFLNmhQay9veE4wOXU0b1MyeFNKOGdZK1JP?=
 =?utf-8?B?VTZyZlN6T1NrNWpaSnFmQ0tvSjM0NWtBRENIU3BHeStHNjdLYXZ1VVE5N05j?=
 =?utf-8?B?Qnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: v0uZCZtdYUCt+OGng+J/5883KCPFS4KYqVcqBcfmjE05dm8s+QuPan502E8glWCLrqHFWAFQXkeXMQJxZM6SiVbp8Cqp3KuTgj2/e6eNGTiVMPcVtAvVxByrYf8pSkpgv/t20pB9+9k7r+86YCFfeBqqEWzPFCpErVftb9vIcqHEgaK4EWuKGXcw5LaNejSR4fuCjFbhS9+e/ESv8uqSXzFq3Ri8OA85RqHF5brNzKruCRyPmansqrJQb7sOPRqWzgaZInhveLput3FbLBVfW9HqA/mTKwZlNEDARRYI9TpTzrQ+AFuLjTWmRz8Bjt++G23aE+VoEBFAlfi1DMlF7umQa6Rz7I1AnBU73O3Jqno2oD1btz3GlG/BYduzcWPK9y14U/W05EQHzz1WsD5sX5Yb+BBXxvvyw/VOxtw/q2Ns9uScv30sbRi19DtQhH/BMQ7grZGu7bzz6E8L48rqK7uz10lFoRRqV4NGZv7MED9TIHjqxAzQxsAM/TEsgQMlLg0BOB0nvmlEAWQ+D03lZkA2L2RE0FloR8GzhrOUYA/hNqBC9rnbAysdRqXYFFA7PWyUmXQGS8TFJDnGOruilOYJq6ZYENcn0MX5BqY+KSOBRI2w9sdbNBSedzHfqGqffmDCR8fHVEdhVIZX99iV72Mv1gam7IG9N/trqmbelbS3sdfd5pDFKzu2+u5K6HfLdJrWCkP3Ht4lVtKiIEh4MjyA05UKuCOXPpM/BYYxChLAlelqlkVS235zMGpSpOttzehHCH2KNZtQZU7i6a1JBf4bSEzt4inq0YNCJNiKt6rtPywSqXon609JueQ/kEFO1SK6kxPCRjioLf+3XCq5+Q==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8d17ddb-85bb-4027-50ae-08dbe9f97096
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5143.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 18:49:36.0639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pb7k8+XLrG0qrJURTPWExmOAsf4yLDMQPHJIaRJNYoUUiHgPFbkwg8H3i+rmMnnGOi8xEy+vrHwCPAOBe8ov2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6474
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-20_19,2023-11-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311200136
X-Proofpoint-GUID: XQ6jSkhIGYVV670AKiGVzRs0khr4E4DH
X-Proofpoint-ORIG-GUID: XQ6jSkhIGYVV670AKiGVzRs0khr4E4DH
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--------------GDpZiNo3euNGABUG9sjfMvHd
Content-Type: multipart/mixed; boundary="------------a1yXOkxe52NcACBhR0z2sl20";
 protected-headers="v1"
From: Calum Mackay <calum.mackay@oracle.com>
To: Trond Myklebust <trondmy@hammerspace.com>,
 "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Cc: Calum Mackay <calum.mackay@oracle.com>,
 "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
 "steved@redhat.com" <steved@redhat.com>
Message-ID: <79012dcc-ac14-4219-9140-b8ad449acc91@oracle.com>
Subject: Re: Who owns bugzilla.linux-nfs.org - account creation broken? Re:
 How owns bugzilla.linux-nfs.org? Fwd: [Bug 218138] NFSv4 referrals - no way
 to define custom (non-2049) port numbers for referrals
References: <bug-218138-226593@https.bugzilla.kernel.org/>
 <bug-218138-226593-fRCLxzGk3u@https.bugzilla.kernel.org/>
 <CALXu0Ucz2MGCYdMw74ZKGUj_hpGcLP-pxC=MSgpUFGU58=jc=g@mail.gmail.com>
 <CALXu0UdY=ZgcAqvC6Y-X6htxPQ9=XWemt8V4dxTA99wQmHKz=w@mail.gmail.com>
 <959BB15F-5B91-4413-BCFC-EDAC78EE32F6@oracle.com>
 <d8bb0bf43c8fe38ef83248fb55a9549919530cf2.camel@hammerspace.com>
 <095736A1-C749-4B8C-900C-C0471D8F8422@oracle.com>
 <9bb44f33-9900-44e1-813d-df1c60d8307c@redhat.com>
 <35ffafefb1596f4941513bc8dd51470fbee842d4.camel@hammerspace.com>
 <F12175F2-9CA3-4C6A-9089-BF5E62A196D0@oracle.com>
 <ec326d7e13d12c02fabf8a5fe46f2ad8bf66d368.camel@hammerspace.com>
In-Reply-To: <ec326d7e13d12c02fabf8a5fe46f2ad8bf66d368.camel@hammerspace.com>

--------------a1yXOkxe52NcACBhR0z2sl20
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjAvMTEvMjAyMyAyOjAzIGFtLCBUcm9uZCBNeWtsZWJ1c3Qgd3JvdGU6DQo+IE9uIE1v
biwgMjAyMy0xMS0yMCBhdCAwMTowNyArMDAwMCwgQ2h1Y2sgTGV2ZXIgSUlJIHdyb3RlOg0K
Pj4NCj4+DQo+Pj4gT24gTm92IDE5LCAyMDIzLCBhdCA3OjE24oCvUE0sIFRyb25kIE15a2xl
YnVzdA0KPj4+IDx0cm9uZG15QGhhbW1lcnNwYWNlLmNvbT4gd3JvdGU6DQo+Pj4NCj4+PiBP
biBTYXQsIDIwMjMtMTEtMTggYXQgMTU6NDUgLTA1MDAsIFN0ZXZlIERpY2tzb24gd3JvdGU6
DQo+Pj4+DQo+Pj4+DQo+Pj4+IE9uIDExLzE4LzIzIDEyOjAzIFBNLCBDaHVjayBMZXZlciBJ
SUkgd3JvdGU6DQo+Pj4+Pg0KPj4+Pj4+IE9uIE5vdiAxOCwgMjAyMywgYXQgMTE6NDnigK9B
TSwgVHJvbmQgTXlrbGVidXN0DQo+Pj4+Pj4gPHRyb25kbXlAaGFtbWVyc3BhY2UuY29tPiB3
cm90ZToNCj4+Pj4+Pg0KPj4+Pj4+IE9uIFNhdCwgMjAyMy0xMS0xOCBhdCAxNjo0MSArMDAw
MCwgQ2h1Y2sgTGV2ZXIgSUlJIHdyb3RlOg0KPj4+Pj4+Pg0KPj4+Pj4+Pj4gT24gTm92IDE4
LCAyMDIzLCBhdCAxOjQy4oCvQU0sIENlZHJpYyBCbGFuY2hlcg0KPj4+Pj4+Pj4gPGNlZHJp
Yy5ibGFuY2hlckBnbWFpbC5jb20+IHdyb3RlOg0KPj4+Pj4+Pj4NCj4+Pj4+Pj4+IE9uIEZy
aSwgMTcgTm92IDIwMjMgYXQgMDg6NDIsIENlZHJpYyBCbGFuY2hlcg0KPj4+Pj4+Pj4gPGNl
ZHJpYy5ibGFuY2hlckBnbWFpbC5jb20+IHdyb3RlOg0KPj4+Pj4+Pj4+DQo+Pj4+Pj4+Pj4g
SG93IG93bnMgYnVnemlsbGEubGludXgtbmZzLm9yZz8NCj4+Pj4+Pj4+DQo+Pj4+Pj4+PiBB
cG9sb2dpZXMgZm9yIHRoZSB0eXBlLCBpdCBzaG91bGQgYmUgIndobyIsIG5vdCAiaG93Ii4N
Cj4+Pj4+Pj4+DQo+Pj4+Pj4+PiBCdXQgdGhlIHByb2JsZW0gcmVtYWlucywgSSBzdGlsbCBk
aWQgbm90IGdldCBhbiBhY2NvdW50DQo+Pj4+Pj4+PiBjcmVhdGlvbg0KPj4+Pj4+Pj4gdG9r
ZW4NCj4+Pj4+Pj4+IHZpYSBlbWFpbCBmb3IgKkFOWSogb2YgbXkgZW1haWwgYWRkcmVzc2Vz
LiBJdCBhcHBlYXJzDQo+Pj4+Pj4+PiBhY2NvdW50DQo+Pj4+Pj4+PiBjcmVhdGlvbg0KPj4+
Pj4+Pj4gaXMgYnJva2VuLg0KPj4+Pj4+Pg0KPj4+Pj4+PiBUcm9uZCBvd25zIGl0LiBCdXQg
aGUncyBhbHJlYWR5IHNob3dlZCBtZSB0aGUgU01UUCBsb2cgZnJvbQ0KPj4+Pj4+PiBTdW5k
YXkgbmlnaHQ6IGEgdG9rZW4gd2FzIHNlbnQgb3V0LiBIYXZlIHlvdSBjaGVja2VkIHlvdXIN
Cj4+Pj4+Pj4gc3BhbSBmb2xkZXJzPw0KPj4+Pj4+DQo+Pj4+Pj4gSSdtIGNsb3NpbmcgaXQg
ZG93bi4gSXQgaGFzIGJlZW4gcnVuIGFuZCBwYWlkIGZvciBieSBtZSwgYnV0DQo+Pj4+Pj4g
SQ0KPj4+Pj4+IGRvbid0DQo+Pj4+Pj4gaGF2ZSB0aW1lIG9yIHJlc291cmNlcyB0byBrZWVw
IGRvaW5nIHNvLg0KPj4+Pj4NCj4+Pj4+IFVuZGVyc3Rvb2QgYWJvdXQgbGFjayBvZiByZXNv
dXJjZXMsIGJ1dCBpcyB0aGVyZSBuby1vbmUgd2hvIGNhbg0KPj4+Pj4gdGFrZSBvdmVyIGZv
ciB5b3UsIGF0IGxlYXN0IGluIHRoZSBzaG9ydCB0ZXJtPyBZYW5raW5nIGl0IG91dA0KPj4+
Pj4gd2l0aG91dCB3YXJuaW5nIGlzIG5vdCBjb29sLg0KPj4+Pj4NCj4+Pj4+IERvZXMgdGhp
cyBhbm5vdW5jZW1lbnQgaW5jbHVkZSBnaXQubGludXgtbmZzLm9yZw0KPj4+Pj4gPGh0dHA6
Ly9naXQubGludXgtbmZzLm9yZy8+IGFuZA0KPj4+Pj4gd2lraS5saW51eC1uZnMub3JnIDxo
dHRwOi8vd2lraS5saW51eC1uZnMub3JnLz4gYXMgd2VsbD8NCj4+Pj4+DQo+Pj4+PiBBcyB0
aGlzIHNpdGUgaXMgYSBsb25nLXRpbWUgY29tbXVuaXR5LXVzZWQgcmVzb3VyY2UsIGl0IHdv
dWxkDQo+Pj4+PiBiZSBmYWlyIGlmIHdlIGNvdWxkIGNvbWUgdXAgd2l0aCBhIHRyYW5zaXRp
b24gcGxhbiBpZiBpdCB0cnVseQ0KPj4+Pj4gbmVlZHMgdG8gZ28gYXdheS4NCj4+Pj4NCj4+
Pj4gSWYgeW91IG5lZWQgcmVzb3VyY2VzIGFuZCB0aW1lLi4uIFBsZWFzZSByZWFjaCBvdXQu
Li4NCj4+Pj4NCj4+Pj4gVGhpcyBpcyBhIGNvbW11bml0eS4uLiBJJ20gc3VyZSB3ZSBjYW4g
ZmlndXJlIHNvbWV0aGluZyBvdXQuDQo+Pj4+IEJ1dCBwbGVhc2UgdHVybiBpdCBiYWNrIG9u
Lg0KPj4+Pg0KPj4+DQo+Pj4gU28gZmFyLCBJJ3ZlIGhlYXJkIGEgbG90IG9mICd3ZSBzaG91
bGQnLCBhbmQgYSBsb3Qgb2YgJ3dlIGNvdWxkJy4NCj4+Pg0KPj4+IFdoYXQgSSBoYXZlIHll
dCB0byBoZWFyIGFyZSB0aGUgbWFnaWMgd29yZHMgIkkgdm9sdW50ZWVyIHRvIGhlbHANCj4+
PiBtYWludGFpbiB0aGVzZSBzZXJ2aWNlcyIuDQo+Pg0KPj4gSSB2b2x1bnRlZXIgdG8gaGVs
cC4gSSBjYW4gZG8gYXMgbXVjaCBvciBhcyBsaXR0bGUgYXMgeW91IHByZWZlci4NCj4+IEFu
ZCBJIHZvbHVudGVlciB0byBsZWFkIGFuIGVmZm9ydCB0byBlaXRoZXI6DQo+Pg0KPj4gYSkg
ZmluZCBhIHJlcGxhY2VtZW50IGlzc3VlIHRyYWNraW5nIHNlcnZpY2UsIG9yDQo+Pg0KPj4g
YikgZmluZCBhIHdheSB0byBhcmNoaXZlIHRoZSBjb250ZW50IG9mIHRoZSBidWd6aWxsYSBp
ZiB3ZSBhZ3JlZQ0KPj4gdGhlcmUgaXMgbm8gbW9yZSBuZWVkIGZvciBhIGJ1Z3ppbGxhLmxp
bnV4LW5mcy4NCj4+DQo+PiBPciBib3RoLg0KPj4NCj4+IFRoZXJlIGlzIG5vIHdheSBmb3Ig
dXMgdG8ga25vdyBob3cgbXVjaCBlZmZvcnQgaXQgdGFrZXMgaWYgeW91DQo+PiBzdWZmZXIg
aW4gc2lsZW5jZSwgbXkgZnJpZW5kLg0KPiANCj4gVGhlIHBvaW50IGlzIHRoYXQgZW1haWwg
aGFzIGV2b2x2ZWQgb3ZlciB0aGUgMTggeWVhcnMgc2luY2UgSSBzZXQgdXANCj4gdGhlIHZl
cnkgZmlyc3QgbGludXgtbmZzLm9yZy4gSSBoYXZlIG5vdCBoYWQgdGltZSB0byBrZWVwIHVw
IHdpdGggdGhlDQo+IHJlcXVpcmVtZW50cyBvZiBhZGRpbmcgc3VwcG9ydCBmb3IgRE1BUkMs
IFNQRiwgZXRjLiB3aGljaCBpcyB3aHkNCj4gQ2VkcmljJ3MgYWNjb3VudCBzZXR1cCBlbWFp
bCBpcyBwcm9iYWJseSBpbiBoaXMgc3BhbSBmb2xkZXIsIGFzc3VtaW5nDQo+IHRoYXQgdGhl
IGdtYWlsIHNlcnZlciBldmVuIGFjY2VwdGVkIGl0IGF0IGFsbC4NCg0KSWYgdGhlcmUgaXMg
YSBkZXNpcmUgdG8gY29udGludWUgdG8gaGFuZGxlIG91dGdvaW5nIG1haWwgKHJhdGhlciB0
aGFuIA0KbW92aW5nIGl0IHRvIGEgaG9zdGVkIG1haWwgc2VydmljZSksIEkgaGF2ZSBzZXQg
dXAgRE1BUkMsIFNQRiAmIERLSU0gb24gDQpteSBvd24gb3V0Z29pbmcgZW1haWwsIGFuZCBt
YXkgYmUgYWJsZSB0byBoZWxwIHdpdGggdGhhdCBiaXQgb2YgaXQuDQoNCmNoZWVycywNCmNh
bHVtLg0KDQoNCj4gDQo+IEZ1cnRoZXJtb3JlLCBib3RoIHRoZSB3aWtpbWVkaWEgYW5kIGJ1
Z3ppbGxhIGluc3RhbmNlcyBhcmUgZmFyIGZyb20NCj4gcnVubmluZyB0aGUgbW9zdCByZWNl
bnQgY29kZSB2ZXJzaW9ucyBhbmQgSSdtIHN1cmUgdGhlcmUgYXJlIHBsZW50eSBvZg0KPiB3
ZWxsIGtub3duIHNlY3VyaXR5IGhvbGVzIGV0YyB0byBleHBsb2l0LiBTbyBib3RoIGNvZGUg
YmFzZXMgaGF2ZSBiZWVuDQo+IG5lZWRpbmcgYW4gdXBncmFkZSBmb3IgYSB3aGlsZSBub3cu
DQo+IA0KPiBGaW5hbGx5LCB0aGUgVk0gaXRzZWxmIGlzIHN0aWxsIHJ1bm5pbmcgUkhFTC9D
ZW50T1MgNywgYW5kIEknZCBsaWtlIHRvDQo+IHNlZSBpdCBtaWdyYXRlZCB0byBhIHBsYXRm
b3JtIHRoYXQgaXMgaXMgc3RpbGwgbWFpbnRhaW5lZC4NCj4gDQo+IEFsbCB0aGVzZSB0YXNr
cyB3b3VsZCBuZWVkIGhlbHAgZnJvbSB0aGUgcGVyc29uIChvciBwZW9wbGU/KSB3aG8NCj4g
dm9sdW50ZWVycyB0byBtYWludGFpbiB0aGUgYnVnemlsbGEgKyB3aWtpIHNlcnZpY2VzLiBT
b21lIG9mIHRoZW0gd291bGQNCj4gbmVlZCB0byBiZSAxMDAlIG93bmVkIGJ5IHRoYXQgcGVy
c29uLCBhbmQgb3RoZXJzIChsaWtlIHRoZSBwbGF0Zm9ybQ0KPiB1cGdyYWRlKSB3b3VsZCBu
ZWVkIGEgbG90IG9mIGNvb3JkaW5hdGlvbiB3aXRoIG1lLg0KPiANCj4gSU9XOiBJJ20gbm90
IGFkdm9jYXRpbmcgZWl0aGVyIHdheS4gSSBjYW4gdW5kZXJzdGFuZCB3YW50aW5nIHRvIG1p
Z3JhdGUNCj4gYXdheSBmcm9tIHRoZSBjdXJyZW50IHNldHVwIHRvIHNvbWV0aGluZyB0aGF0
IGlzIG1haW50YWluZWQgYnkgc29tZW9uZQ0KPiBlbHNlLiBIb3dldmVyIGlmIGFueW9uZSBk
b2VzIHdhbnRzIHRvIHRha2Ugb24gdGhlIGpvYiBvZiBoZWxwaW5nIHRvDQo+IG1haW50YWlu
IHRoZSBjdXJyZW50IHNldHVwLCB0aGVuIHRoZXkgbmVlZCB0byBrbm93IHRoYXQgaXQgd2ls
bCBpbnZvbHZlDQo+IHJlYWwgd29yay4NCj4gDQoNCi0tIA0KQ2FsdW0gTWFja2F5DQpMaW51
eCBLZXJuZWwgRW5naW5lZXJpbmcNCk9yYWNsZSBMaW51eCBhbmQgVmlydHVhbGlzYXRpb24N
Cg0K

--------------a1yXOkxe52NcACBhR0z2sl20--

--------------GDpZiNo3euNGABUG9sjfMvHd
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEE1GBbrQYgx8o9Vdw+hSPvAG3BU+IFAmVbqjoFAwAAAAAACgkQhSPvAG3BU+Jc
tBAAmwpTrnhe8HYIidBdGTp7XGhRojYm7N7yqC7A81ayCcJ6GssvJwi7ZYuP3cf10VDO8sGtTr4w
V2NQu1UBSybrVI6HNhIYvEoo8vXPHQzJu6jNgVX/Bi0hq1aMojqrspvjW9mJcjQEMAlSf8y22iw5
ZhOeZQ4TPj6O5eLJujLJwSJLcAKv4Xvm9OKwqe1MssFXda+adNZkJLE2KpEM4rP7ODhHUx/TnU2z
N1dgTe/IKm5NIbJGrot/+ccXkFJowPKRCpq7FG0o73BPmsqip6qfgmTsEnhoaeqgIoWTJyhDfMdi
elwPoisVrklHpXWayu3e1b3KJv0SmE2gxEiV+cqnkUyGGAmpQLcYOLPMde4aGU5pslxK0XT3N+l7
Csk4v9QuBoz8vEIm7bsoBpbdcmvgaIGstgZKaMCewIRfSuh+V4IfueWJ3Yez5Lc4n9hPQq8KLHNL
/WQlKVCfJQ7lkJPDpbPukMNCiLpJqRsoU9yqSeYWM2129YusAf707dgKZUUMRj/xYLc7DA4BxXvO
4bWzg7AbGYc7n1jM5/5ePMHbEyNLprBhdTkL4AnERiAKSopNe/068zyK1lvwLruUwS8kVTCQ3wBc
o82wFVH3y1CvBIT7cg5uXQA8koCL2N2O8XGf1BTwaZxz0YEE7QfgMg4qRM+pdMcjtc1B35ozo+IR
Vrs=
=17fW
-----END PGP SIGNATURE-----

--------------GDpZiNo3euNGABUG9sjfMvHd--
