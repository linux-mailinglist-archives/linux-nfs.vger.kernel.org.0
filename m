Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84DE033F8B3
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Mar 2021 20:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbhCQTEM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 17 Mar 2021 15:04:12 -0400
Received: from mail-dm6nam12on2101.outbound.protection.outlook.com ([40.107.243.101]:17729
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229796AbhCQTED (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 17 Mar 2021 15:04:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dhBE+sJm2UCtL2Q5FhmoLRKvQZEgPBDesGd5myOntMEtpcSv2wxQpNsg1GVF/8Rv4m51IMInolaU8F9jmli2Q1LyqL3z7vwohXayRoxWkdL4vcXI0Z5TkjTpyCpnBFOkA0Ni/kJ+pFfIxDQBqOQArCrI8u6GmM5xxMC5snNbsdfmg0Grk3ayOqRQ2IQlCegTY/WO3dtmuSKcbiFPaELGVznFUxtXVIptzdaqW9AzdfF6cHe+jqwITpD6IKKZdaUC5009+75UW9sOxvDjy0oLaMiCO8tKtBKAjKIGoodiqfbV0yqD4jwm6QyzD5EyohDJFi+NNcau94KqW8merwsV3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zVFE16kWv+Y1LaL4mr6+HjYmL+PcxJ1htPKUj+y8Bzs=;
 b=EixOEuMCVMD1Izn3hGWR5VLXXgA9D5M4tL4jdUPryBllXIpMdIAl+9vHKLRr76eeS8ZdbZeB0zIYDAIImnQFlPO2Rix7eZBzlRaTrBq+CnUuMpFXPlRqR7yUqpFkvASmjyYbC3iaxxE99GiZpquE8linaTz/Dq+szl7sinaS9uBZXXSnQQMDGgqofUedB5LsUDg+G8Hxj1u7lHTEDZyjLFUCNoN0jb7f9WIcgq24rgnKREIRfxgRK1eq6TueFtzj7tu3KJ4Sh30znDg0kgN/LYEr/kx/g8d11KLz60vMqE5MdOoWbbWgVqzJPPag8bf0dHi48vHegCfQiwMPuz7h2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=rutgers.edu; dmarc=pass action=none header.from=rutgers.edu;
 dkim=pass header.d=rutgers.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rutgers.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zVFE16kWv+Y1LaL4mr6+HjYmL+PcxJ1htPKUj+y8Bzs=;
 b=crNIJqxA9Md6AoYWMLx5nAdzBGHF2iUc09Rv4sTBvuB+V2ivrDJloJQ86zAB6rfQY5emzBjWJNXEE3wj+4/uCnIfxJ8H7zXdRWkvgBI5MPq1XQ0gpyneuoHqmlLyeKGxRbkIpqb2L7ZL5Ptb+Ye+SlEX0B/NQ17Exx3VHZM7jCo=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=rutgers.edu;
Received: from BL0PR14MB3588.namprd14.prod.outlook.com (2603:10b6:208:1cb::7)
 by BL0PR14MB3651.namprd14.prod.outlook.com (2603:10b6:208:1c8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Wed, 17 Mar
 2021 19:04:01 +0000
Received: from BL0PR14MB3588.namprd14.prod.outlook.com
 ([fe80::ac70:fcf7:df8f:f589]) by BL0PR14MB3588.namprd14.prod.outlook.com
 ([fe80::ac70:fcf7:df8f:f589%3]) with mapi id 15.20.3933.032; Wed, 17 Mar 2021
 19:04:01 +0000
From:   hedrick@rutgers.edu
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Subject: time treated as signed 32 bit in svcgssd
Message-Id: <BB5BAD44-C804-40CD-A257-A1DA7FAA9974@rutgers.edu>
Date:   Wed, 17 Mar 2021 15:04:00 -0400
To:     linux-nfs@vger.kernel.org
X-Mailer: Apple Mail (2.3654.40.0.2.32)
X-Originating-IP: [2620:0:d60:ac1a::a]
X-ClientProxiedBy: MN2PR05CA0006.namprd05.prod.outlook.com
 (2603:10b6:208:c0::19) To BL0PR14MB3588.namprd14.prod.outlook.com
 (2603:10b6:208:1cb::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from heidelberg.cs.rutgers.edu (2620:0:d60:ac1a::a) by MN2PR05CA0006.namprd05.prod.outlook.com (2603:10b6:208:c0::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.9 via Frontend Transport; Wed, 17 Mar 2021 19:04:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 209bd617-15f0-40a9-9cd3-08d8e9776d41
X-MS-TrafficTypeDiagnostic: BL0PR14MB3651:
X-Microsoft-Antispam-PRVS: <BL0PR14MB3651A063C362935A13E8F60EAA6A9@BL0PR14MB3651.namprd14.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BPLv5aoD2sqTT2KpstrMD4cmtHNr6vlC6I+y9Y65GLfEt33625zFT5k5iw/9itFt96Sp/xg79VWMJLzl/TTEiimXSeVkRWXmMkIDbjTAWVl0LkOwCerCMutz+Y4D9ObxamMbg/xU0Nm3FOkV8lalWYvLkeVzJMQUG05iwU/MRWE33gmV5uz/oRpf9IEE2J+kUzrqnlv/dyw6OPOix955P7apKlbvnbEdYTQr+gNaWoI48uzuluMCdb+NzN5NDbmBkCvPGQyDI403UcBLoAH8jrUlYRkAHkn4V4+DS9Jw5qH5hUiFG+dxLs5VUhWnTQX7/zaN/VhNIvmsQIMpo5V3zGLpl0MfL4BYlcmKSRGoPYSFIGIR7U+WciIMWSDgZgK1QiTCwlzFOIYrlwBiAd4bIEFjOz5XoLWFvNBWBP9a7/VPYrTaBb2ChR4jOqn7XxKBiTKQ6PFXB7kaI+VFYU/Z0cRZgwmxmq8BJbQGVncyfufYinf1mv5Vn4FGYuuyTAJ9wrZaqT0nftAgC1tl7XDuwIfRKvoftD3P1iStqFG9EnRS3q/FuCDYO9+6YdJpRUrUrlZjtZ2//hB05qzc+HplMhzpvshAdhPpnqctwDwSLQ0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR14MB3588.namprd14.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(136003)(366004)(39860400002)(9686003)(186003)(6916009)(66556008)(75432002)(316002)(8676002)(4744005)(478600001)(2616005)(786003)(33656002)(6486002)(86362001)(16526019)(52116002)(66946007)(36756003)(7696005)(66476007)(8936002)(83380400001)(2906002)(5660300002)(2292003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?joPsGPZXbJlrSlNiSa2I9I54CoHleG8Z4Lmd1HekZiO7aZVygYYP3eyJfq0D?=
 =?us-ascii?Q?YWPrkV2dgK4UYNJbKizoI5Rwt1RMkGjAS/vX7Z/xzb+77326/cwbl99MCr+X?=
 =?us-ascii?Q?h5bedpcYv3rNuGaQm6P9ruS7Kd/B4TtmNwX8va6sBBLlEkdWx3daHP4Rdp8X?=
 =?us-ascii?Q?pQSKWZ3g0PLQz4dbXdHeRw1ieKLJrCw57EqqmqXrlfpCExrnWDiuXjY2YVXK?=
 =?us-ascii?Q?6XDBmRuVBj/0hGfguvvno+VyMEAyvbq/RkklLla4B8alGbuI8b1Y8fSYIcSh?=
 =?us-ascii?Q?QaJZ8wdPhuyQ2c8OKRdmxahlBJEZo2/ebJNVmHeQBAHbD0gl8xJg4cj8KsGJ?=
 =?us-ascii?Q?CaG36MuQvRZYriunreyUNj3XnAjiP7/iovO6eNZuRdW1cVXQ2wwE0ou3WO+S?=
 =?us-ascii?Q?9eNIc6gCN1WPqVXw671w9i5DDCfpiuNrFCifB4TYKmpg8yR/oQocGaeG6myx?=
 =?us-ascii?Q?RYS7aAQATBI9KuEGBCH5+8lziLNmRjTl1uBNK6wZYSQ8BEOy9/LeAD8Irg8O?=
 =?us-ascii?Q?hP4wCbul/Du9vocbnAFdXje+vZEkmWHKsmS+3P9Ba8NcbGaAf+FumAubquyj?=
 =?us-ascii?Q?Vg+9NlMlNR0cAIuPHsHLrLdhLutUuB20cuddytVcvd1epzpgThPfWDh5ZvwZ?=
 =?us-ascii?Q?6Pz7fbS6z96zNVXK90QbIyvcSnT7LAXAxJdbozKIEMLpgWw+MExfzRboWuef?=
 =?us-ascii?Q?93nVbg3fOdFiBDjyyZjPIEQp6mRIv4+ek9MMKHKorG+b4uideXQHeWlk90DA?=
 =?us-ascii?Q?J6CTab73n4Y2Nsbmp33zKoTEUq8gAV6ljYw7IhOr6UtbfdbCdq72pVtX39Eo?=
 =?us-ascii?Q?0XqrdxR3HmfVBJ/REzmUIiTEmHsChiPgEQlHwHIEU1hVcc2C8R6L86MjmXwg?=
 =?us-ascii?Q?fn6SfLStiWIAcHQomFaAwiVihuL7WQtqZVRDdIXPP32qEj1Oyo/lgBeRxaKB?=
 =?us-ascii?Q?V3UzFHEmM5+r3DGRVl/vOwhKUqZ3BOlSocXl6chxTnR+oAXhO9lfcvT38hqu?=
 =?us-ascii?Q?LDry7oTETmv4g1OTdVyExCNd3rpVbeWoSwRouiwXD87cSeUbdQBMkBUSWGO9?=
 =?us-ascii?Q?FrHTDyZ5qhw7I2sjtz8/y3VcVv3JltGoviD7ukvclRq9EhZCnogf747sUx+A?=
 =?us-ascii?Q?7K/wYCxTtvP1Fv+VshDmhUmUF20IliDMYAM9CnhHxht71W238pFTRN1baazM?=
 =?us-ascii?Q?7OK5YzokXvlFYiLhpanVkoZBNTTL81x4r5VDIp6zyDCu+ha1lGFzogyoPCA+?=
 =?us-ascii?Q?PfQm4HIpURDn6ne3clJF9ugqEIRvhqCkizDXxg40GQ77naG2O27CMYu0x6F5?=
 =?us-ascii?Q?PX1oBqg+lrDfZU8xLZ3klAxwiFdcOkIhJLsxQ1a4StSrcg=3D=3D?=
X-OriginatorOrg: rutgers.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 209bd617-15f0-40a9-9cd3-08d8e9776d41
X-MS-Exchange-CrossTenant-AuthSource: BL0PR14MB3588.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2021 19:04:01.7168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b92d2b23-4d35-4470-93ff-69aca6632ffe
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cA+/fOGjl6mm/XljYWj9KoaVsK194Pl/Sb2/qV/SEhzqxunasLztn7nFaa14/C72egDMen0XvMp2JEU/iarNqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR14MB3651
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Patch eb3a145789b9eedd39b56e1d76f412435abaa747 adds code to rpc.svcgssd to =
set an expiration date for nfs contexts. (It doesn't work, but that's the s=
ubject of a different bug.) That code treats the date is int32. It is sent =
into the kernel using code that ends up as a printf %d. In 2038 the date wi=
ll go negative. Because the kernel uses 64-bit dates I believe that will pr=
oduce the wrong result.

The code should use date_t, not int32_t.

This is complicated by the fact that it gets the date from a Kerberos ticke=
t. Kerberos declares date as int32. For historical reasons, they have decid=
ed to retain it as int32, but whenever there's a comparison or arithemtic t=
hat would break in 2038, they cast it (date_t)(u_int32_t). Thus Kerberos is=
 considered safe for 2038, even though date is declared as signed 32 bit. I=
 believe the code in svcgssdd should use this cast. All variables should be=
 date_t. Anything retrieved from a Kerberos ticket should be cast (date_t)(=
u_int32_t).



