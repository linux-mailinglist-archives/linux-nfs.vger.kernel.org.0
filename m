Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00A813AB641
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Jun 2021 16:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbhFQOot (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Jun 2021 10:44:49 -0400
Received: from esa12.utexas.iphmx.com ([216.71.154.221]:34894 "EHLO
        esa12.utexas.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbhFQOos (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 17 Jun 2021 10:44:48 -0400
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Jun 2021 10:44:48 EDT
IronPort-SDR: 0Y+zr3wP/wh2lYI7Lp4w4XLO0fhLmT0lWv86WcVqbYer+UiWxC9/CMPa+naMnI1yLUZaPAsTIy
 doKVqCAmcEK8tJ1bggft5vGfauy1Az+VOQ+bsEFwqtBwU3HsixEinESBylWQgdx3RNWH6u5X8l
 h99OHvh02yhI47i0ZjausIsoVISzCls9IjOLGS1zkJc72/xPjwOIJntC22hYNqSfYB4wUHsGOo
 ujgFu9/oyP9SJFw5c736E/5t34QIlRS7a5UIl+Vvsf08OA9Yw5QGLtpSc6HwIvs0WrOXCRyw7i
 Dvs=
X-Utexas-Sender-Group: RELAYLIST-O365
X-IronPort-MID: 283043208
X-IPAS-Result: =?us-ascii?q?A2F3BwDqXMtgh2o6L2haHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?VeBU1F+gUILhD2DAkcBAYU5iFYtA5oagUKBEQMYPAIJAQEBAQEBAQEBBwI1C?=
 =?us-ascii?q?gIEAQEDBIRJAjWCOSY4EwIEAQEBAQMCAwEBAQEBBAEBBgEBAQEBAQUEAgIQA?=
 =?us-ascii?q?QEBAWyFLzkNg1ZNOwEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQUCDVIpPgEBAQMSERUIAQE3AQ8LGAICEQ4HAgIyJQYNCAEBFwMEgk8Bg?=
 =?us-ascii?q?lUDLwEOmQsBgRIBFj4CIwFAAQELgQiKBoEygQGCBwEBBgQEgTQBgRmCbxhCC?=
 =?us-ascii?q?Q2BWQMGCQGBBiqCe4pvQ4FJRIEVJw+CbT6DfS8xJoJYgmSDIQF6EwErgS8VF?=
 =?us-ascii?q?ShEkSYni3OBK1yBJJtCgymKEpNWBg4FJpUEkGqhc5J9hSQCBAIEBQIOAQEGg?=
 =?us-ascii?q?WuBfjMaCB0TO4JpUBcCDo4fDA0JFYM5inxVOAIGCgEBAwl8h1QBgRABAQ?=
IronPort-PHdr: A9a23:mt9IpR+Di/oeOv9uWNPoyV9kXcBvk6v7MxRT6Zc9jb9KNKO58MeqM
 E/e4KBri1nEFcXe5ulfguXb+6bnRSQb4JmHvXxDFf4EVxIMhcgM2QB1BsmDBB7lI/PwKS83B
 sJPUBli5X7oeURQEdz1MlvVpHD65DUOGxL5YAxyIOmQeMbSgs272vr09YfUZlBNjSa9J65uI
 QW/tkPcutRF6bY=
IronPort-HdrOrdr: A9a23:XrNyV63sdXkFH2luXDZfEgqjBS9yeYIsimQD101hICG9Lfb0qy
 n+pp4mPEHP4wr5OEtOpTlPAtjjfZquz+8O3WB3B8beYOCGghrSEGgG1+ffKlLbakvDH4JmpM
 Ndmu1FeaXN5DtB/LfHCWuDYrEdKbC8mcjH5Jas854ud3AOV0gJ1XYGNu/xKC1LrWd9dPkE/d
 anl7N6T23KQwVpUi33PAhJY8Hz4/nw0L72ax8PABAqrCGIkDOT8bb/VzyVxA0XXT9jyaortT
 GtqX232oyT99WAjjPM3W7a6Jpb3PPn19t4HcSJzuwYMC/lhAqEbJloH5eCoDc2iuey70tCqq
 iBnz4Qe+BIr1/BdGC8phXgnyP61iw11nPkwViExVP+vM3QXlsBeol8rLMcViGcx1srvdl63q
 4O9XmerYBrARTJmzm4z8TUVittilG/rRMZ4K4uZkRkIM4jgYJq3MgiFBs/KuZGIMu60vFnLA
 BWNrCf2B4MGmnqKUww1wJUsayRtndaJGbPfqFNgL3N79FspgEN86Iv/r1Xop4xzuNOd3B63Z
 WxDk1JrsAEciZEV9M2OA8+KfHHfVAlFii8TF56Z26XWp0vCjbwtpLn6K9wy/qtfNgl3b1aou
 W2bG9l
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.83,280,1616475600"; 
   d="scan'208";a="283043208"
X-Utexas-Seen-Outbound: true
Received: from mail-dm6nam10lp2106.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.106])
  by esa12.utexas.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2021 09:35:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f7RbP4RAa13j6nh2R8wC6xSFr0XIRviweZJu3gUOuGOjiAOJkQNdz3sP/lbr1Acmsrk4RUWYrhhpra0aCVWFlrc9mfcudnHva4lq41RuuLnscu28T2NV81fcSvBzbllqULjrIKe83eGJdFHsJAhRz/QfcaHg8U59EYvqNWGvsHtQaGBTTuD1nxFaFN7cQhtej4xLn/sSHSlr83Tk/0H7cRXG4iBLVi9IWs9Mlk/qXx2I+U4T9zhhpjfszqidmh0SGk1x/UWaZ0Lu0b12LxGK9dqC6t5KK/K8ic2nnpMAbse2WBq0MTBgwvk+6Hzynu62i1+qYJdIVTQr88ld4dypFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cZDwUB0TU12NpoRSDZ79NghTMSbYtidLSjIvnSc4iSo=;
 b=MPvelcz7e2n1xoWOD6hJvo668pRepJDbEdHWAQ8LVrSOKJrJo3p9N+q5owe26JNE6N0eyefzKcd1RsUPvOKCR/o5RuQZDfybtagXHlfLWTHZqzinkR+l0j8gfGuO9hTXAEA0txOVtwnc+58VWchIqTQtNK+LVFhwa6F1DxsCrdVi23FJOSXhag77OloWSCyopO7YoXLQzhaiFiXibnjWJ7RQ1iKej/0p0psIrdSoylIVYDtgvVubf3RXIoh3UX6w+R64sYjxLymJABkMdzGv4Sq4SeatLP3301mJxpWKJ7gPWQQce3ecgA090XD+2LbIHZ+3VbcKy5w+bpsbQGleeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=math.utexas.edu; dmarc=pass action=none
 header.from=math.utexas.edu; dkim=pass header.d=math.utexas.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=utexas.onmicrosoft.com; s=selector1-utexas-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cZDwUB0TU12NpoRSDZ79NghTMSbYtidLSjIvnSc4iSo=;
 b=nnZlimgSB8eFULLh5Qlq0zyrh8eY0VA1zzAKkdbA00NcEAz/cg/PwKOjbYxKIVkjzvYxeSfptQgGVG/6hlSKLlWQnjv6RqCV02QHvqkzA1BlXfT/NYGryZ7uCrpVwu1YXZwy+djl6cp50A3egQWsEKIOGd3unkQP3wQYbpLyyOU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=math.utexas.edu;
Received: from BYAPR06MB3848.namprd06.prod.outlook.com (2603:10b6:a02:8c::15)
 by BYAPR06MB5990.namprd06.prod.outlook.com (2603:10b6:a03:156::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Thu, 17 Jun
 2021 14:35:32 +0000
Received: from BYAPR06MB3848.namprd06.prod.outlook.com
 ([fe80::b5b8:98c7:3e33:3a22]) by BYAPR06MB3848.namprd06.prod.outlook.com
 ([fe80::b5b8:98c7:3e33:3a22%3]) with mapi id 15.20.4219.026; Thu, 17 Jun 2021
 14:35:31 +0000
Subject: Re: Use of /etc/netgroup appears to be broken in the NFS server
 version which ships with Ubuntu 20.04
To:     NeilBrown <neilb@suse.de>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
References: <2539b705-b72a-d9de-965e-7836dfd2e362@math.utexas.edu>
 <162389949987.29912.5411348355154532470@noble.neil.brown.name>
From:   Patrick Goetz <pgoetz@math.utexas.edu>
Message-ID: <44f13e43-2f29-f442-a68f-2dcbef8145f1@math.utexas.edu>
Date:   Thu, 17 Jun 2021 09:35:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <162389949987.29912.5411348355154532470@noble.neil.brown.name>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [67.198.113.142]
X-ClientProxiedBy: SN6PR05CA0026.namprd05.prod.outlook.com
 (2603:10b6:805:de::39) To BYAPR06MB3848.namprd06.prod.outlook.com
 (2603:10b6:a02:8c::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.4] (67.198.113.142) by SN6PR05CA0026.namprd05.prod.outlook.com (2603:10b6:805:de::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.9 via Frontend Transport; Thu, 17 Jun 2021 14:35:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 526c6bfe-1d01-46d2-286c-08d9319d28fa
X-MS-TrafficTypeDiagnostic: BYAPR06MB5990:
X-Microsoft-Antispam-PRVS: <BYAPR06MB5990BFF41536BFD0B9567F14830E9@BYAPR06MB5990.namprd06.prod.outlook.com>
X-Utexas-From-ExO: true
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: irBAVofDqv60MewhYZ1xSNL6gosT74mN9BzBlmpETlSGiDBip14TAeVO2yZ7upY9gs8XebNyjz8LnP6TDLBGz+X2PkRh/97hBZedpINa3c5t99ZEGTegkKFNkbUkcWyhJ/Z7xwykmfyA57rgjYvDsGuKiY29FqO8CPAjmnuEdYLzyFNNecrN0sXGsm3njMunXXR8sWAwawyya+2rd2SguCIXcMSc4rF5WisCRXpujYsaIJV4wFOav2JrSryTY9JgccEH1CmJPhzyQ6fVvNomf8w07kZDrHe3S8UHGkBS4gPFd822sCgziGG9HWspoKK7M+mWVzq6ID47zKw4rk9PxIxhPaz3belQ7eccw2Zs+lAoPB2mHLjZEYjZ9eXaMYdjfEQxDNdyc5agtvf7NEEZ6Gp2gqeKFNkNfTk2lB0H+AAfQ+HihTATTJvtP8EKCfrC9pmBSFovtyBX7xxlJ0UtBfAFrabeNHtAldZrb8OjeB4+aQYZ9erfi6dAAr02HolXnAcJzi3J0ogllKd0nLl07AzFzVAG+SF58d9gkmVbSzxNVqHYzkiZQafStg5WMBJwyqb8mpNLSanRzXnEXyn8Mvh7AfOJv0ksEkZvdSKI1HLRdCMWlceQvEcH+z7aaNimTuhUD2GD2e3LcFmPQoidQ3FpQ1InA1/UqEGgguM6Sixe4x4tPMH2vpcrvPWyoFqcQ3iKyK973di3KOaBqrRBQnsiFxLGtUWEhc7/ib4W4wujIxqrqFGU1IULJm1Qhq0ftOQ+pNWyfYWdKBJ3B351YPMW5b4J7YDN/GHwLuE7Hy6Ql35wNmZrw9eOzL29uPzNrMt6vnu+0y4E9AfHqYTdN4tWI6vgjOryyHnARLivyaQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR06MB3848.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(396003)(376002)(346002)(39850400004)(16526019)(786003)(66946007)(31696002)(66476007)(38350700002)(38100700002)(86362001)(316002)(956004)(2616005)(8936002)(6916009)(52116002)(26005)(53546011)(186003)(5660300002)(478600001)(2906002)(4326008)(83380400001)(66556008)(16576012)(6486002)(966005)(75432002)(31686004)(8676002)(21314003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QU54OEtUZkcxejNtaTY4TWpqK211Sm44TE1JY0xyMkxMS3dOT0hXNUt5UG9s?=
 =?utf-8?B?ZHJobGVoWU94TEkxcm4vM1FCQ09oYzNvcUxIdmpOejBUSGFETjJCWnJubHpo?=
 =?utf-8?B?aGpJbjRFRTZHVWk2OFM0WWhKb3JNOXp5ejMzb0hDanUxMHNMci9FbU1sQjRi?=
 =?utf-8?B?bC9CQTZkSFNsL0FzdkxhY0lCQzBDc3NoNk5nRFpoQlVIdWw0STRqeUxmU0pW?=
 =?utf-8?B?bkc0VXFaTnBCekV4RW1HUk1MUVI2Y0FmWUIvR0grS2ZWcmMwS1JBamphdW1i?=
 =?utf-8?B?cmJEWERkdllxTTlRK1ZXTFI3ZkJVdlFTeHZIYlVCdkhMYVd3aHNwWVdUemtS?=
 =?utf-8?B?OHlwUG0zN3NiZjZDbWFDK0pZNTNRRFZNYUs1TGRyK0ZjcUx2aFNWa3RFTFVK?=
 =?utf-8?B?MHlFWGljNVlUZWVjcG9lMWZpZmxONEdZWlU2Ry9uTnVzZEFmNWtTOFh2ZTZC?=
 =?utf-8?B?L0pnOS8vajIrb29wK0I3aWw3TTE1OFB3WHpPVk1XRjVDRjhhaXZETkViV2pu?=
 =?utf-8?B?a3poNjIzbk5ONzZyWFl1RjdMSkhoaElUQU1MSjlhSXk2UVovWmNhOXFGWDFE?=
 =?utf-8?B?aWpDcEhIOXNIcHAwUE0wQzRZSGxUVGFnUmcxVU1tWXNjR2xCZ1BLcjA1RDRu?=
 =?utf-8?B?bFJlaGZHR09VQWFSbkowdVgrVUZZNDNZYUVOQkxRS24rVU1KTWs3c3R5SHdw?=
 =?utf-8?B?UlZBZTNNdkZuVjZrY0xpY01UVlZuOWt5bCsvZlgwN3RROEwzNlFqR0VCVWla?=
 =?utf-8?B?SnRmWU1nMlE1NVZreUdzNVlCQ1M5eFovaWd0blNvYnVhcHJoN2RQTzVLdmZ0?=
 =?utf-8?B?ejNiQVMzd242cld3SjgyR0UxVzhMWWFHWXE3N1R6NGxNTjdkTGtTRkMyVk5y?=
 =?utf-8?B?NFJwTmRBSFppczUzM0ZXOWx4RzA1N2tPZFZDN2ZPSTlRUDRHTFVqRmdwZ1c5?=
 =?utf-8?B?L2xqM0N0emxlRk5NZVRBWGp1M2JuUjJKdUIxd3d4TnJTUzVMWTJoUWh6S3Zz?=
 =?utf-8?B?L045c1gvU09iV2lROWE0M2tmVmVGdVMvcUErbHh6Zm13d3J5b200SmVkVDhO?=
 =?utf-8?B?WEExaDVsYW54cUM2NXVBdnU3NzY0d2crNldCUkx6OE1pcEdzLzcvZEtEbEEy?=
 =?utf-8?B?Q1Irc3gzemJocDlSTUVFZzYyWUNqa1IzYU9QNmE2aVRqU3dHZWZkdDVDNU5G?=
 =?utf-8?B?TTEvUmRtRGhQbHdtbVk2OE4rcUJMeWpJd2lTUWJHMmNDVm9vMWlUUllEc01D?=
 =?utf-8?B?eENYOFhpK3RRZ1dPRHcyWUxrM0xkTUpPWVVzK09WK0tKSG0vRzVrSUttTWJL?=
 =?utf-8?B?bXhScnRvcVEwT3JoSFIxVDVyQ2pIbmwrUnRTNnF5ZlYxRWQwNm80bFp6NlE3?=
 =?utf-8?B?N0VBNkRtQmlxaEpCTk8zcnhOa1lGZXViMHZ1T1lvTGgvMW1NazRvZ09YNW9m?=
 =?utf-8?B?Mm1aYWg1UTZpR1N6dVEvTXFpc1d3MXBuZUlIcGNhZFZrajc3dnk5eU44aEl0?=
 =?utf-8?B?c2E5U0Z2RUlFWnBPR1hNMWh0cXRZRnN2azVRVTZHWE4vSHY5SnNuQTRpcUta?=
 =?utf-8?B?WGZYSXZuYW8yOXBMRUxtSms1a2E4YWcvYTRoeHpDaGVRT2x0NGJ6YkU2K21s?=
 =?utf-8?B?VkpETXppcmRBdkNjOVFyMW9FYmtHRWQ0clpNMi9lUTY1em1Da1JLTWlWY2I3?=
 =?utf-8?B?ZUs0RUJSL3haT3NsYjdZQ0FUV0wrRGQvSXFia1JNQmhvRC9iOFRaeThJQ3RN?=
 =?utf-8?Q?UfSHO9bYKpykDam8hu7aWpBfVtTPiYVAYXgcaD1?=
X-OriginatorOrg: math.utexas.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 526c6bfe-1d01-46d2-286c-08d9319d28fa
X-MS-Exchange-CrossTenant-AuthSource: BYAPR06MB3848.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 14:35:31.8324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 31d7e2a5-bdd8-414e-9e97-bea998ebdfe1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ihMQrCKIzzgwsEhUuyeOZjp6W8n4bWimHSHlimMEa1t+CGcpmclSL5sgVo2bnncNGkYgv67299fTsaGAHbM+KQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR06MB5990
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Neil -

This is extremely embarrassing, but chalk this one up to user error 
(technically, PEBKAC).  I'm used to /etc/nsswitch.conf always including 
the files option, so didn't think to check this when in fact on Ubuntu 
20.04 they ship the nsswitch.conf with this netgroup entry.

   netgroup:       nis

Who still uses NIS?  Beats me; but once I added files to the option list 
it starting working as advertised. Very sorry to dump random noise onto 
the list.


On 6/16/21 10:11 PM, NeilBrown wrote:
> On Wed, 16 Jun 2021, Patrick Goetz wrote:
>> Sadly, it took me a couple of days to track this down. The /etc/netgroup
>> file I'm using works perfectly on another NFS server (Ubuntu 18.04) in
>> production, so this wasn't an immediate suspicion.  However, if I use
>> this /etc/exports:
>>
>>     /srv/nfs @cryo_em(rw,sync,fsid=0,crossmnt,no_subtree_check)
>>     /srv/nfs/cryosparc @cryo_em(rw,sync,fsid=2,crossmnt,no_subtree_check)
>>
>> Client mounts fail:
>>
>>
>> root@javelina:~# mount -vvvt nfs4 cerebro:/cryosparc /cryosparc
>> mount.nfs4: timeout set for Tue Jun 15 11:53:22 2021
>> mount.nfs4: trying text-based options
>> 'vers=4.2,addr=128.xx.xx.xxx,clientaddr=129.xxx.xxx.xx'
>> mount.nfs4: mount(2): Permission denied
>> mount.nfs4: access denied by server while mounting cerebro:/cryosparc
>>
>> and if I switch to specifying the host explicitly:
>>
>>     /srv/nfs javelina.my.domain(rw,sync,fsid=0,crossmnt,no_subtree_check)
>>
>>     /srv/nfs/cryosparc
>> javelina.mydomain(rw,sync,fsid=2,crossmnt,no_subtree_check)
>>
>> the mount just works.  The tcpdump error message isn't terribly helpful
>> here:
>>
>> 11:14:02.856094 IP cerebro.my.domain.nfs > javelina.my.domain.741: Flags
>> [.], ack 281, win 507, options [nop,nop,TS val 791638255 ecr
>> 2576087678], length 0
>> 11:14:02.856178 IP cerebro.my.domain.nfs > javelina.my.domain.741: Flags
>> [P.], seq 1:25, ack 281, win 507, options [nop,nop,TS val 791638255 ecr
>> 2576087678], length 24: NFS reply xid 2752089303 reply ERR 20: Auth
>> Bogus Credentials (seal broken)
>>
>> but after figuring out the cause of the problem, I did find a
>> corroborating RHEL error report (which you'll need a RHEL account to
>> access):
>>
>>     https://access.redhat.com/solutions/3563601
>>
>> I couldn't figure out how to determine the exact version of the NFS
>> server that ships with Ubuntu 20.04.  Maybe someone could explain how to
>> do this.  Running
>>      /usr/sbin/rpc.nfsd --version
>> doesn't do it.
>>
>>
> 
> The problem is unlikely to be the implementation of netgroups - that
> hasn't changed in a long time.  It is more likely to be some subtle
> configuration difference.
> 
> Can you provide the verbatim /etc/netgroups file, and the extact host
> name that a DNS lookup of the client IP adress results in?
> 
> NeilBrown
> 
