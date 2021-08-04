Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA92A3E03BC
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Aug 2021 16:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238796AbhHDO5Q (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 4 Aug 2021 10:57:16 -0400
Received: from esa10.utexas.iphmx.com ([216.71.150.156]:64115 "EHLO
        esa10.utexas.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234423AbhHDO5Q (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 4 Aug 2021 10:57:16 -0400
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Wed, 04 Aug 2021 10:57:16 EDT
IronPort-SDR: 7NCoWhproMzBB0qcS6S+3TqVx7xdsb4oB+bFAx7JFN4pfCLEiYiZZ8Y0nFaCOKIg8KPytjaKvd
 Q7WiJ7GrEEW4paG75w8QoIB26jyHlX4yIrCg8JXFGK55L/D5MaiETZ13E+kD1l6ts4HRAGIVe+
 +Xjqd+LHDD0WauoEgb86/lFTvadeHwKo4cAMCweL4S0eBiSXp3LJ21G1d10S5hcTurLhYX80Nr
 UtdI2vM84uv7AwWw/dlxL3ynuv0LooUOvEuolHU00ORd8OBbTLNYsFJB123+O1v1RjvgwjOhDY
 8es=
X-Utexas-Sender-Group: RELAYLIST-O365
X-IronPort-MID: 289521645
X-IPAS-Result: =?us-ascii?q?A2HcBAB2qAphhylCL2hXA4EJgywjLn5ZaYRIgwJHAQGFO?=
 =?us-ascii?q?YhhA5o0glMDGDwCCQEBAQEBAQEBAQgBNQwEAQEDBIRRAjWCTCY4EwIEAQEBA?=
 =?us-ascii?q?QMCAwEBAQEBBAEBBgEBAQEBAQUEAgIQAQEBAYEMhS85DYNTTTsBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEFAg1SKT0BAQEBAgESEQ8BB?=
 =?us-ascii?q?QgBATcBDwsYAgImAgIyJQYBDAYCAQEegk8BglUDDiEBDp4NAYESARY+AiMBQ?=
 =?us-ascii?q?AEBC4EIiQx6gTGBAYIHAQEGBASCUYJiGEQJDYFaCQkBgQYqgnyKc0OBSUSBP?=
 =?us-ascii?q?A+Cbz6CCk0LAYFJAjcmglCCZII8UQYBAQ0IG1gFASqBEjQIESctAQg/kWiOD?=
 =?us-ascii?q?p0VgzKRdIw/Bg8FJoNjkXOKb4Yilg6CHJ14GIRnAgQCBAUCDgEBBoF3gX4zG?=
 =?us-ascii?q?ggdE4MkCUcZDo44g1iKfCUwOAIGAQoBAQMJiAkBBoJAAQE?=
IronPort-PHdr: A9a23:0eBrCBK0NTnyyUeah9mcuYMyDhhOgF28FhQY5poul/RFdaHwt5jhP
 UmK4/JrgReJWIjA8PtLhqLQtLyoQm0P55uN8RVgOJxBXhMIk4MaygonBsPWE0D3LPf2KSc9G
 ZcKWFps5XruN09TFY73bEHTpXvn6zkUF13/OAN5K/6zFJTVipGy3vyyvYDPbhVBn3ywba4hR
 Cg=
IronPort-HdrOrdr: A9a23:kqAO363PRfewksq/FlfpOQqjBQJyeYIsimQD101hICG9Lfb0qy
 n+pp4mPEHP4wr5AEtQ/+xoS5PwOE80lKQFqrX5WI3PYOCIghrNEGgP1+rfKl7bamfDH4xmpM
 BdmsFFYbWeY2SS5vyKgzVQZuxQpeVvh5rY59s2oU0McShaL4VbqytpAAeSFUN7ACNcA4AiKZ
 aa7s1b4xK9ZHU+dK2AdzU4dtmGg+eOuIPtYBYACRJiwhKJlymU5LnzFAXd9gsCUglI3awp/Q
 H+4kPED+SYwr+GIy3npi/uBqdt6ZjcIxx4dY6xY/0uW3TRY8CTFcFcsvO5zXQISaqUmS4XeZ
 H30mwd1oJImj7slyiO0GHQ8hil3zA053D4z1iExXPlvMziXTo/T9FMnIRDb3Limj0dVfxHod
 d2Nliixu5q5NL77VrAzsmNUwsvmlu/oHIkn+JWh3tDUZEGYLsUqYAE5ktaHJoJASq/sekcYa
 BTJdCZ4OwTfUKRbnjfsGUqyNuwXm4rFhPDRkQZoMSa3zVfgXg8xUoFw84UmGsG6fsGOu95zv
 WBNr4tmKBFT8cQY644DOAdQdGvAmiIWh7IOHL6GyWUKEjGAQO/l3fT2sR82AiHQu118HICou
 WwbLoDjx9OR6vHM7zw4LRbtgzRTHS0R3Dj0cdbo5RpvNTHNcvWDRE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.84,294,1620709200"; 
   d="scan'208";a="289521645"
X-Utexas-Seen-Outbound: true
Received: from mail-mw2nam12lp2041.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.41])
  by esa10.utexas.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2021 09:49:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uid1PcW1x2uXT3J6//n6jsKL1TDk1jJ8osYFhwUu7u3dV0IAfawWFVIBFJmTOEWfb5U7GdenrPIh3l3VPl31nNiOOaG/QIMJC/7LYDs0hrSWw33orRyL/rnFp9oEbk66Y77B+XHsadp//RpUJj781TNCjkOx07IwN+/EQy1jkgYZ6/pkAkCIaoR5CUVygXoFPBk/pLi/f9bHYKJxUIt1VyOkhUX4xo8SU9SBDtFFJpjMLq3gh3m4nTzEJWAW8PwqLg1naY2bUL66csteIISqA9AU3eq1VYcq6CWs+hQ8SMPV7Ngvut1dJeLLyXIE/awyYhN+qry/+tjDNwNJz2y+6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OAh9fYDcavfNVQ+h5yXR4V8nsQ0oKGKHzE8vqFo3bMc=;
 b=JG5U3sKNnzK/66qK6Q7Z+PJ2W+uoV5FWyUuRrX3WT8B2O4v61q3GH0guHuVpClFbu04Kxf7AQFwgfFzkwxuE69gD/AYJbsgpzKWW0Tuvo+rGW4jgciX0U4kl6TtnrQoeScSNeAZiBBMSZaG5Y3xXcNbvcqoyjhHfmBlk+eG/Sb3xzRuEciONysT8BYmXLdn/cg0CZR07GSvZ7if4g4M/NCfYKVCNXGMCu65GRigH2yvUpGi8plu4//C/8MHfu7ycuI7/Jjr7f7jv5yrdi7pm844Vlsn7JPpbB6djseNbxRdJjwAU9Fxgf8xduVlu4FoetHo4FdhbKoPhjq3B6nQxiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=math.utexas.edu; dmarc=pass action=none
 header.from=math.utexas.edu; dkim=pass header.d=math.utexas.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=utexas.onmicrosoft.com; s=selector1-utexas-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OAh9fYDcavfNVQ+h5yXR4V8nsQ0oKGKHzE8vqFo3bMc=;
 b=XcMRFU8ENRcdGZT/ypEDLdTCpZUKLEiihI7pDi3kWsFbDlk2voe3OaPPQCpkUnYzNqRtpubaB61Gk4ZpiI03aU8KlcpG5zNHF/UeAQkMgcTiHKKHGm3co9qROa6vuiQd1/hiX3rheott5KO4cVRodnqPUcTIqBviuySM1bU10tA=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=math.utexas.edu;
Received: from DM6PR06MB3851.namprd06.prod.outlook.com (2603:10b6:5:86::23) by
 DM5PR06MB2506.namprd06.prod.outlook.com (2603:10b6:3:58::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4373.20; Wed, 4 Aug 2021 14:49:54 +0000
Received: from DM6PR06MB3851.namprd06.prod.outlook.com
 ([fe80::b006:2544:20ec:9138]) by DM6PR06MB3851.namprd06.prod.outlook.com
 ([fe80::b006:2544:20ec:9138%7]) with mapi id 15.20.4394.016; Wed, 4 Aug 2021
 14:49:54 +0000
Subject: Re: cto changes for v4 atomic open
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "bfields@fieldses.org" <bfields@fieldses.org>,
        "mbenjami@redhat.com" <mbenjami@redhat.com>
Cc:     "plambri@redhat.com" <plambri@redhat.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "bcodding@redhat.com" <bcodding@redhat.com>
References: <DF3F94B7-F322-4054-952F-90CE02B442FE@redhat.com>
 <ef395e52f3bb8d07dd7a39bb0a6dd6fb64a87a1c.camel@hammerspace.com>
 <20210803203051.GA3043@fieldses.org>
 <3feb71ab232b26df6d63111ee8226f6bb7e8dc36.camel@hammerspace.com>
 <20210803213642.GA4042@fieldses.org>
 <CAKOnarkuUpd6waieqvWxJDRpLojwXqbNtAFz_bz6Q2k9Xrskgw@mail.gmail.com>
 <CAKOnarmdHgEBTUc87abMqBM_+3QP4JfdT8M9536WDZg-MGEKzA@mail.gmail.com>
 <61dc5d9363a42ed1a875f68a57c912c1745424d3.camel@hammerspace.com>
From:   Patrick Goetz <pgoetz@math.utexas.edu>
Message-ID: <423b3a31-c41f-09dd-835d-9e66c4a88d7e@math.utexas.edu>
Date:   Wed, 4 Aug 2021 09:49:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <61dc5d9363a42ed1a875f68a57c912c1745424d3.camel@hammerspace.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0015.namprd04.prod.outlook.com
 (2603:10b6:806:f2::20) To DM6PR06MB3851.namprd06.prod.outlook.com
 (2603:10b6:5:86::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.4] (67.198.113.142) by SN7PR04CA0015.namprd04.prod.outlook.com (2603:10b6:806:f2::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend Transport; Wed, 4 Aug 2021 14:49:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 68a5f4a3-d961-426f-779b-08d957571ec7
X-MS-TrafficTypeDiagnostic: DM5PR06MB2506:
X-Microsoft-Antispam-PRVS: <DM5PR06MB25061E9DBC329B89A3078E3183F19@DM5PR06MB2506.namprd06.prod.outlook.com>
X-Utexas-From-ExO: true
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fXEa0LJvQ/H9K4xv9TVktHwunRv0goPCPPHTLRSdHa9nTU4gTXlu5bTI+rPP//SMkmuHVqCGi0D4a7pNbC8i/SyZxIgjtSFCVQqos8w6edg+1rb6UnZv0ZNjGu7YgMRgFZLErJJRVNbPgHSX5g/Q9ahJfNW3MDGXa66VA78vEusTcN3SPQlUUr2LJPOi+ACKIPJPBVWNZ429xx1Nq/SnYfIddX7LLU3NHM5jWrkYSDNx6QomUy63b6IphmJpUHil9tpnRroACZIc4mjExihbmKagkMtEOjANPks8PN5gVpgpUHOtyDG9GmfFkpTpqc4OrYyUXVKBTSRPnWc7etP0+3sLqVoOrCSwe8LQiC/oHqs3Zbeyu5xwaaIqOi/TExwmtcWlFhYAQk6KobfS8YWueAddcZ4QHf5B6c/esWnBI0DGCULwtQrNh9X7PsqchIULhEUqjl/0SHp+zfHy4QA2C+FxaubKnOkk+ZJp7CHofEZtPnZfFbCjn+nr7O0yGcgwoXo4xYd28jHV4xPEGrUhqM/uWJoICOQCwk4Q5oGneTvMbDpjRM9V7aYP/aUmXhKV/UIQKBQXS/wRZr8j23Ci1BgoY992Crt62yjUUVPKs1Rbddf2prgvWsigyATALfHAJqZwf80+4mS8ogGzoIHuVS/d4bdjqVyJoY+CO88ci+qYRGUf1iRD6jUvstRRXY5ye0LsOZIqq7A+jk5BmoFeicq+oUZOHX7qsznN1Whp4FG4uLli1ZrQJxX8fpnqwJ75nJz45tdYhjj77SceyFSqXR1Z9xqu6viqGdsowfQvWTnWfKFMLupx+M97SBk/9i+pZnn15f688ri2Tqw86zyX5X6PFhn0hwR7cCKvZuoLAofT4LZVaqTRGy3pMpsbmllg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR06MB3851.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(5660300002)(956004)(2616005)(83380400001)(8936002)(31686004)(75432002)(316002)(54906003)(966005)(38100700002)(2906002)(508600001)(16576012)(786003)(38350700002)(110136005)(66476007)(6486002)(66946007)(186003)(53546011)(66556008)(52116002)(31696002)(4326008)(86362001)(19273905006)(26005)(43740500002)(45980500001)(563064011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlhVQmxjMDEzbERXc1hONCtvV21VYXdERGRaMXlLSStYRU85ZXNNbXN6NW9W?=
 =?utf-8?B?QUEzeGJzRWdaT3lkZmplQ0MzWlJEYlRZVlRweE1sZlMycDBlS0R6MjMyalZ0?=
 =?utf-8?B?d3VySnVuMmZTQU5pUDNidzZRc2kvN1dWUWNnaFBZOFg1K0dNcUx1QmtpdnJy?=
 =?utf-8?B?M00wTUUxYmJiZkpnbUF5cWUwUjNVbHJhbUw0NC9XL211RzQwRFBJU1pLeHdS?=
 =?utf-8?B?bFNZVkVjWkhrS0N2aUFzM1B5NitEblN2T3JObmxqRDJxTnhVNHIzRGkvR3dY?=
 =?utf-8?B?Q2N6RU1TNTRZT2RXSm5hZHVjVGhhNGtMOEVTZ01tUThMaC9PSlhCbXVwWkd4?=
 =?utf-8?B?RGxMUkw0TUZLOWs3MU9oblVidUZrOEJJeGIzekVwR0k4NlhBVjVkRkhFa2g5?=
 =?utf-8?B?emtBMGsyNmE3SHozNEtuenFyNjU1UW1iQVc5aWJSZHRrK2ZQdjR4WkxWTjFW?=
 =?utf-8?B?QU9SeXJZc2UxM2RzdGRGamVycGhWNU8wMENKalArOEJSMFJKM3VvQWplZlRD?=
 =?utf-8?B?b0NHSHNvekNrM3M0Z0owRWhUZDRtQ3YwSmxjdU5XTldKQnVHUnB3T1gzQUly?=
 =?utf-8?B?aVF3ZTFpK3ZTdDlsRm9hUDF5OTU4cGhEbU5QcXBaZUVmKzU2NGREU20xWFFl?=
 =?utf-8?B?a2Q1L3NIUFhyaVRKNnVHUXdWQ2Z4cFNZT2RyOHZnODNBMm9MdWhBbHlLYjVn?=
 =?utf-8?B?SnhXaG1XZVc0Y0xRUU5TbWFmVm1RUkpLUkRZR0tOWG5mMHcrc2hXWmF2Z1ps?=
 =?utf-8?B?aUl3aFhLNUozK2pFT0g5U1VpdmZpSGFFeW1CZURqazhsM3RPVTJneXRzamI2?=
 =?utf-8?B?QVdlL3NlSXlWeWNWekRtTHNjT043NUtMc1ZLc0toS2VZNGtSNVNpWEE0Tmp0?=
 =?utf-8?B?QVpmazVHQmoxczFtcGhCTXd3V0lvUUZodG1xWVJiZTZuNlkxdGNoSFMwU05O?=
 =?utf-8?B?UHhsT3lITHVuTXlmcGllSTJoYUp2UkRrak9MeEpIalJjamk5eEtiTVdvVTlN?=
 =?utf-8?B?NStCTWNMT0tkdytmb1pzK0tTTnAxSmllSVRBYVova3J5N0kyLzRxOUlBTG8z?=
 =?utf-8?B?MHdzbWhETEVxajV2ZWdmbXpvMXowUDJuMHVPL0Z6TzhpWkJUMmpnWTRTNjZW?=
 =?utf-8?B?VEJkakduUVU3anNUNWl1b0RlNGdSM3NLYXBQT3ZxejBmSDBDQVFpT2V4emRs?=
 =?utf-8?B?YjRzanBia0V2NzF6RzllS2ZBcnhRZ0JHRXE4V1VUZ0ZEV1ZtOTh5ZlB0Wk9z?=
 =?utf-8?B?Z1dkZlpmU1k0dU00Mm40dlpvQXRocUcyZU1lazNGY0haeld3aTNlTllqTFFL?=
 =?utf-8?B?T0p2K1JBQ0ZYamJIZ0xMNENHRlhSR3BDRnJKS0d5NGVyNzJzczEvR3RVY3g4?=
 =?utf-8?B?NVVYSzFKRUoxYWw3NUVpdmVGbktKWjVoM0FpdTU0WDBUYlRNTDNMejBsZTI3?=
 =?utf-8?B?elNOek1DancyeklMSFBMVmF1eUE1SU9rY1B1OTdnYTZhRmhXOWlhRWNBdURN?=
 =?utf-8?B?OTNVRkNKN25iWGFYRXhjcUJTeDNFUEQ5K0hzelhOQXFwNWR2QVdGNUQ4RldQ?=
 =?utf-8?B?dGZ2cUNySitNRk15K0FpcUVjNDdSM3JtMlhFRkg2RXVwY21CenZWZ3UxZ1Bx?=
 =?utf-8?B?aVZ6TmJ3MGFJV0F2Q2FwZHQxTEx0ZHRBbWhQTy9SNUhKOHgwNmQzL0tWYXI3?=
 =?utf-8?B?aGpWRjBWbzRJSHd4WGc1bGJzSTJNa1QrZUNQeFM5cVRjVTlxb2M0aS9ad1Qz?=
 =?utf-8?Q?MV3kSPTQTVo49b8+dq14A1tmby4QuKpToAWI1Y8?=
X-OriginatorOrg: math.utexas.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 68a5f4a3-d961-426f-779b-08d957571ec7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR06MB3851.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2021 14:49:54.2474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 31d7e2a5-bdd8-414e-9e97-bea998ebdfe1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jsTtWpvqHH+awDH8p+tRSwcnpopA9t/bTSRC913bLtu2b18TONHJT6dwkdTu+SxVQIxXDT30UUSmwyCpAePRqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR06MB2506
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 8/3/21 9:10 PM, Trond Myklebust wrote:
> 
> 
> On Tue, 2021-08-03 at 21:51 -0400, Matt Benjamin wrote:
>> (who have performed an open)
>>
>> On Tue, Aug 3, 2021 at 9:43 PM Matt Benjamin <mbenjami@redhat.com>
>> wrote:
>>>
>>> I think it is how close-to-open has been traditionally understood.
>>> I
>>> do not believe that close-to-open in any way implies a single
>>> writer,
>>> rather it sets the consistency expectation for all readers.
>>>
> 
> OK. I'll bite, despite the obvious troll-bait...
> 
> 
> close-to-open implies a single writer because it is impossible to
> guarantee ordering semantics in RPC. You could, in theory, do so by
> serialising on the client, but none of us do that because we care about
> performance.
> 
> If you don't serialise between clients, then it is trivial (and I'm
> seriously tired of people who whine about this) to reproduce reads to
> file areas that have not been fully synced to the server, despite
> having data on the client that is writing. i.e. the reader sees holes
> that never existed on the client that wrote the data.
> The reason is that the writes got re-ordered en route to the server,
> and so reads to the areas that have not yet been filled are showing up
> as holes.
> 
> So, no, the close-to-open semantics definitely apply to both readers
> and writers.
> 

So, I have a naive question. When a client is writing to cache, why 
wouldn't it be possible to send an alert to the server indicating that 
the file is being changed. The server would keep track of such files 
(client cached, updated) and act accordingly; i.e. sending a request to 
the client to flush the cache for that file if another client is asking 
to open the file? The process could be bookended by the client alerting 
the server when the cached version has been fully synchronized with the 
copy on the server so that the server wouldn't serve that file until the 
synchronization is complete. The only problem I can see with this is the 
client crashing or disconnecting before the file is fully written to the 
server, but then some timeout condition could be set.



>>> Matt
>>>
>>> On Tue, Aug 3, 2021 at 5:36 PM bfields@fieldses.org
>>> <bfields@fieldses.org> wrote:
>>>>
>>>> On Tue, Aug 03, 2021 at 09:07:11PM +0000, Trond Myklebust wrote:
>>>>> On Tue, 2021-08-03 at 16:30 -0400, J. Bruce Fields wrote:
>>>>>> On Fri, Jul 30, 2021 at 02:48:41PM +0000, Trond Myklebust
>>>>>> wrote:
>>>>>>> On Fri, 2021-07-30 at 09:25 -0400, Benjamin Coddington
>>>>>>> wrote:
>>>>>>>> I have some folks unhappy about behavior changes after:
>>>>>>>> 479219218fbe
>>>>>>>> NFS:
>>>>>>>> Optimise away the close-to-open GETATTR when we have
>>>>>>>> NFSv4 OPEN
>>>>>>>>
>>>>>>>> Before this change, a client holding a RO open would
>>>>>>>> invalidate
>>>>>>>> the
>>>>>>>> pagecache when doing a second RW open.
>>>>>>>>
>>>>>>>> Now the client doesn't invalidate the pagecache, though
>>>>>>>> technically
>>>>>>>> it could
>>>>>>>> because we see a changeattr update on the RW OPEN
>>>>>>>> response.
>>>>>>>>
>>>>>>>> I feel this is a grey area in CTO if we're already
>>>>>>>> holding an
>>>>>>>> open.
>>>>>>>> Do we
>>>>>>>> know how the client ought to behave in this case?  Should
>>>>>>>> the
>>>>>>>> client's open
>>>>>>>> upgrade to RW invalidate the pagecache?
>>>>>>>>
>>>>>>>
>>>>>>> It's not a "grey area in close-to-open" at all. It is very
>>>>>>> cut and
>>>>>>> dried.
>>>>>>>
>>>>>>> If you need to invalidate your page cache while the file is
>>>>>>> open,
>>>>>>> then
>>>>>>> by definition you are in a situation where there is a write
>>>>>>> by
>>>>>>> another
>>>>>>> client going on while you are reading. You're clearly not
>>>>>>> doing
>>>>>>> close-
>>>>>>> to-open.
>>>>>>
>>>>>> Documentation is really unclear about this case.  Every
>>>>>> definition of
>>>>>> close-to-open that I've seen says that it requires a cache
>>>>>> consistency
>>>>>> check on every application open.  I've never seen one that
>>>>>> says "on
>>>>>> every open that doesn't overlap with an already-existing open
>>>>>> on that
>>>>>> client".
>>>>>>
>>>>>> They *usually* also preface that by saying that this is
>>>>>> motivated by
>>>>>> the
>>>>>> use case where opens don't overlap.  But it's never made
>>>>>> clear that
>>>>>> that's part of the definition.
>>>>>>
>>>>>
>>>>> I'm not following your logic.
>>>>
>>>> It's just a question of what every source I can find says close-
>>>> to-open
>>>> means.  E.g., NFS Illustrated, p. 248, "Close-to-open consistency
>>>> provides a guarantee of cache consistency at the level of file
>>>> opens and
>>>> closes.  When a file is closed by an application, the client
>>>> flushes any
>>>> cached changs to the server.  When a file is opened, the client
>>>> ignores
>>>> any cache time remaining (if the file data are cached) and makes
>>>> an
>>>> explicit GETATTR call to the server to check the file
>>>> modification
>>>> time."
>>>>
>>>>> The close-to-open model assumes that the file is only being
>>>>> modified by
>>>>> one client at a time and it assumes that file contents may be
>>>>> cached
>>>>> while an application is holding it open.
>>>>> The point checks exist in order to detect if the file is being
>>>>> changed
>>>>> when the file is not open.
>>>>>
>>>>> Linux does not have a per-application cache. It has a page
>>>>> cache that
>>>>> is shared among all applications. It is impossible for two
>>>>> applications
>>>>> to open the same file using buffered I/O, and yet see different
>>>>> contents.
>>>>
>>>> Right, so based on the descriptions like the one above, I would
>>>> have
>>>> expected both applications to see new data at that point.
>>>>
>>>> Maybe that's not practical to implement.  It'd be nice at least
>>>> if that
>>>> was explicit in the documentation.
>>>>
>>>> --b.
>>>>
>>>
>>>
>>> --
>>>
>>> Matt Benjamin
>>> Red Hat, Inc.
>>> 315 West Huron Street, Suite 140A
>>> Ann Arbor, Michigan 48103
>>>
>>> http://www.redhat.com/en/technologies/storage
>>>
>>> tel.  734-821-5101
>>> fax.  734-769-8938
>>> cel.  734-216-5309
>>
>>
>>
> 
