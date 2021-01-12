Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06D892F3718
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Jan 2021 18:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391672AbhALR2y (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 Jan 2021 12:28:54 -0500
Received: from esa10.utexas.iphmx.com ([216.71.150.156]:19447 "EHLO
        esa10.utexas.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389601AbhALR2x (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 12 Jan 2021 12:28:53 -0500
X-Greylist: delayed 393 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Jan 2021 12:28:52 EST
IronPort-SDR: PvH2TCcJ+rlsyWLvpCU6waN0TNFz/fwsWPY11d6vz+Q8KrYcjR84imoNVV6e83YkJ1DOSH/NUL
 KzbYbnVFPl1DCPpg3wijyQzWn70ri+JGxtHiaxgXCZw5cE2kgrh7GH0PkcmRwxAfy3oM46ytE+
 Yu4FNq6Rx/1SJDf7crh7+e6shOFovr2kRBCnxH+/c46JHiXtVuR0LsaJZNyRBDXQizx9sZbmpw
 8evyJWGRX+WXTwjTyoM0+st8tqjHnyhmZPT9vDPxMpL8nXa8jWNd3alKP6TW0sQWROBATZiMBH
 Hkg=
X-Utexas-Sender-Group: RELAYLIST-O365
X-IronPort-MID: 257259106
X-IPAS-Result: =?us-ascii?q?A2H1AwDX2f1fhy1CL2hiHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?U+BU1F9gTgKhDWDSQEBhTmIEC0DmRKCUwMYPAIJAQEBAQEBAQEBBwIjCgIEA?=
 =?us-ascii?q?QEChEgCNYE+JjgTAgMBAQEDAgMBAQEBBgEBAQEBAQUEAgIQAQEBAYYBOQyDV?=
 =?us-ascii?q?U06AQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBBQIUVCQ+A?=
 =?us-ascii?q?QEBAxIRDwEFCAEBNwEPCQIYAgImAgIyJQYBDAgBARcHgwQBglUDLgEOkwWOH?=
 =?us-ascii?q?gGBKD4CIwFAAQELgQiKCIEygwQBAQaBR0FEglEYQQkNgTkDBgkBgQQqgnWET?=
 =?us-ascii?q?oICg2xBgUE/gREnD4Flfj6CXQOEdoJggVktPAYCE0ktARsOAiACPhsVMhUEH?=
 =?us-ascii?q?yoFGAItjz6CcYoNm1ODAZAniywFBwMfkwyPVJQSiCCBB5NkhDUCBAIEBQIOA?=
 =?us-ascii?q?QEGgW2BezMaCB0TgyRQFwINjiEag1dqig1VAgEBMwIGAQkBAQMJfItOAYEQA?=
 =?us-ascii?q?QE?=
IronPort-PHdr: =?us-ascii?q?9a23=3AIfEbgRf1xqNXsPgRuk2gY0R8lGMj4e+mNxMJ6p?=
 =?us-ascii?q?chl7NFe7ii+JKnJkHE+PFxlwaTB9fc8ftPj+eQuKflCiQM4peE5XYFdpEEFx?=
 =?us-ascii?q?oIkt4fkAFoBsmZQVb6I/jnY21ffoxCWVZp8mv9PR1TH8DzNFrIq3a24HgZHR?=
 =?us-ascii?q?CsfQZwL/7+T4jVicn/3uuu+prVNgNPgjf1Yb57IBis6wvLscxDhIJ+KuAs1h?=
 =?us-ascii?q?bZq2AOduhLlm4=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.79,341,1602565200"; 
   d="scan'208";a="257259110"
X-Utexas-Seen-Outbound: true
Received: from mail-mw2nam12lp2045.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.45])
  by esa10.utexas.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2021 11:20:32 -0600
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=laVRWBO1XYgzQtmCp0684N4TwCk0cHoNK4IJ2qA9tVz0LmkhWb5cjviXMz2KSgc9f84hWssmrkOczh1In4t5rS2UaQ0liHmmqJlwDy51z0G/YPpT56JJBMX4uufUfFFEnQZdpIG+IOKS5C8haTGvyHNk3cWe3d8xyTzX9Vm3t4yc959KqIvSvZcE3rYCa4fWlA/dSMyYghAIM828WlX1hxdyHLC0A2Jg33EG0n9cME9wRE8ruNtwugFI8R2JhX97OmZX2P8nefUmZvqpwiAhCUnmRr0U9LR6dL8wyR86eioPu5eZh49FYovK/4KdlOzMfU9Mdyhs5rmWiddXgEsp+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=70nHHV2fBrNi6tBv4/Wh+8gGlEO9xRDdQKotHpAwH04=;
 b=l8EMhpR9ZtJYQl3IyfwBJVYJPTswlZoiQlyk0cYA5ArqGxOJ2kPe3txlI3SinJnordNE+zHigdBR9Az1gCznZLyqM8mjC50GzHpmja7mdQFydoZyOrNvG6a2uRm9EQ6BO0YXHB0HV5W2OXblNNo5kWVMA9gp2QslmLTHrkOtALlLMtzRhlPyTNPYk9X+DE+uS5BWL7iQe9WzH03CeNZKXUfsKQFAYYPQq6MhIgQI/vCciiws6Ok/ZoGQqpM/Gq/M5Wi7dww/DJZXyMPi/4fxcBAHApndGbFhAaDezEWUKVuoBMdx5yguVScUZNgrtcfto1//dd+jCIxQ/Z5DCfmODQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=math.utexas.edu; dmarc=pass action=none
 header.from=math.utexas.edu; dkim=pass header.d=math.utexas.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=utexas.onmicrosoft.com; s=selector1-utexas-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=70nHHV2fBrNi6tBv4/Wh+8gGlEO9xRDdQKotHpAwH04=;
 b=ZIvcI/ADjTfMKqCGv0j9oP06eE36T38u8Xh/DLZW1U1Vzo3K14gilsdWj3Nbd1ZtHcB8Wx7TYLL7J4yXomWhVg3l8xFRTQDP0P+r4kUQjaiUfIWk/uDCkqU122XoIy2yNb4VT886pfnHBeQfn7hxI3c9cDTs+SAP16rWsuYb60o=
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=math.utexas.edu;
Received: from BYAPR06MB3848.namprd06.prod.outlook.com (2603:10b6:a02:8c::15)
 by SJ0PR06MB7488.namprd06.prod.outlook.com (2603:10b6:a03:31b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Tue, 12 Jan
 2021 17:20:30 +0000
Received: from BYAPR06MB3848.namprd06.prod.outlook.com
 ([fe80::a1fb:e18c:8af5:666e]) by BYAPR06MB3848.namprd06.prod.outlook.com
 ([fe80::a1fb:e18c:8af5:666e%4]) with mapi id 15.20.3742.012; Tue, 12 Jan 2021
 17:20:30 +0000
Subject: Re: nfsd vurlerability submit
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "bfields@fieldses.org" <bfields@fieldses.org>,
        "wangzhibei1999@gmail.com" <wangzhibei1999@gmail.com>
Cc:     "security@kernel.org" <security@kernel.org>, "w@1wt.eu" <w@1wt.eu>,
        "greg@kroah.com" <greg@kroah.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
References: <CAHxDmpTKJfnhGY9CVupyVYhNCTDVKBB6KRwh-E6u_XEPJq4WJQ@mail.gmail.com>
 <20210105165633.GC14893@fieldses.org> <X/hEB8awvGyMKi6x@kroah.com>
 <20210108152017.GA4183@fieldses.org> <20210108152607.GA950@1wt.eu>
 <20210108153237.GB4183@fieldses.org> <20210108154230.GB950@1wt.eu>
 <20210111193655.GC2600@fieldses.org>
 <CAHxDmpR1zG25ADfK2jat4VKGbAOCg6YM_0WA+a_jQE82hbnMjA@mail.gmail.com>
 <CAHxDmpRfmVukMR_yF4coioiuzrsp72zBraHWZ8gaMydUuLwKFg@mail.gmail.com>
 <20210112153208.GF9248@fieldses.org>
 <8296b696a7fa5591ad3fbb05bfcf6bdf6175cc38.camel@hammerspace.com>
From:   Patrick Goetz <pgoetz@math.utexas.edu>
Message-ID: <42fcbc42-f1b3-5d99-c507-e1b579f5a37a@math.utexas.edu>
Date:   Tue, 12 Jan 2021 11:20:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
In-Reply-To: <8296b696a7fa5591ad3fbb05bfcf6bdf6175cc38.camel@hammerspace.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [67.198.113.142]
X-ClientProxiedBy: SA9PR03CA0014.namprd03.prod.outlook.com
 (2603:10b6:806:20::19) To BYAPR06MB3848.namprd06.prod.outlook.com
 (2603:10b6:a02:8c::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.4] (67.198.113.142) by SA9PR03CA0014.namprd03.prod.outlook.com (2603:10b6:806:20::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.31 via Frontend Transport; Tue, 12 Jan 2021 17:20:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9b7d7c33-c50c-464c-bbaa-08d8b71e5ce2
X-MS-TrafficTypeDiagnostic: SJ0PR06MB7488:
X-Microsoft-Antispam-PRVS: <SJ0PR06MB7488E89D1494582EA277B52B83AA0@SJ0PR06MB7488.namprd06.prod.outlook.com>
X-Utexas-From-ExO: true
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QrgzxkN2TD0oRsFX4jN1mUJhWEyAnWTnV7MvgEt8c/QY/1oSVcr7ZCtSZJ4L4Y+xUBqdV8AXO6tDoiN9uaQ1UlsSup/xTbbRZ9MpZjQdI/G4hjRE+LQ1PlUqWlZL5YsdEQf40kVHVDNECY5sz8Uurr4WH5ifGo+1F1GNtnDWEsq+yc+K9yxBBRRdDsEyzmd9xkuDGuOBK3njZp9QLE/Ns37ZhTbR/xHiWw3RdsLsHshCZXYKJUG8kIasM82E7tmcs8IEZR8jPuUkwF4jTFt827wIp5KryUP9Ua71VgufoGS5PFdAVF2A9bbyUMOoVTg8mAQ5TjbsZ/ltma+PLkihsn04Q4PG7x+GHZdTjvcLBTikKmMEFntXE+smjX5oOuorC972VpOwgEkKa6GexPUWNqj2t9CrYXtrl1KH4rut7uPaY0vAZOGHHp00galm3ZrRZ/IjZVxINUkoMKox2JXvxdTXCKSfxMQaLjFTA9SvVZcamdAoa4OjwcI90gZGBWN29zmCGr+/l1nUEN9qaJflGRyA29FylGmcCILw/MVzLUGpG7c7yDkJdWICCK/Ci9mI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR06MB3848.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(396003)(136003)(376002)(346002)(66946007)(66476007)(4326008)(7116003)(54906003)(478600001)(3480700007)(956004)(31686004)(16526019)(316002)(26005)(110136005)(53546011)(5660300002)(52116002)(31696002)(6486002)(2616005)(786003)(86362001)(75432002)(83380400001)(8936002)(2906002)(66556008)(966005)(8676002)(186003)(16576012)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?OENUYW0wYW5zTHk4MWI0NjF4eGIyR1lIYWNTQk9VQTVsRDZzRXM5OHZqK2lS?=
 =?utf-8?B?dWJZTm5VN1JhK0ZxakRRbjdJV3ljNXhDOEtReHBEZVBWckFhUXJKdjk1WTR4?=
 =?utf-8?B?bFdLZGdiRGlmOStpdlhkYUM3L2g2MWxIUDlQanFYY2c1T09KSzdQTnNOWVpJ?=
 =?utf-8?B?MUxCUkhLNTc0Uy85MG1jRFVEUmNaTE1IVXZobGxkT20vRUVkOUx1SXJZS1lK?=
 =?utf-8?B?VDBBL1dPK0hqZTN1S056bUVMNFZIMktPRjB6L2NCRnBQOWNuaUh6dXhuMHVG?=
 =?utf-8?B?c0VrckNDc1pqYXhkakVKclFjVWJ6dUtwMEdIQTE0bG1KOXdsWW50Z0kwWGNk?=
 =?utf-8?B?dytKR20ydzFzNUJ6OEVRSDMyU203bkVSYWxWNTB5SjRuMzdoSk1UQVBTRUZm?=
 =?utf-8?B?UUpKWVJIZUZDWDh0NjBtc0g3VXNEMER6SmlHUCtrRGMyMVh2bUNIV2pZT2Vi?=
 =?utf-8?B?ZE9DV2xQa3ZMem16RGJ5MDRvQm5Tbis4Q0d3OEdVWCtWN01SSlIwQ1B0UHhW?=
 =?utf-8?B?N2kvd1ZXVXlFeHZYUmVBSWovdmY2SlZsVGp0bnFRSktPd3Zkd21IVjN3eTdl?=
 =?utf-8?B?bXpQUTJtRkRtMXBGejJLT0hhN3o1NjVoZmlEVmNoVjM5UUFHakNYbmpLQWJK?=
 =?utf-8?B?bXJBeXZxSmRQK1MzZHJIajBRNXVrd2RVMXBRSmlBQ2dPZTBydFhXWXpiNlVp?=
 =?utf-8?B?UktoVXd5NEFQcW0ybjNKOEI4TDRrenpzK2YrbndETE1KK2dqYnU3Y3lsRWlE?=
 =?utf-8?B?U1ZERHAzWW9WZG1YMGRTNEt0TUlUaUdEZHVHa1QwYjBKRGdxOHR5cDJSSUVk?=
 =?utf-8?B?Zy9rYlVLRnNBT3pucVVDbEt4LzhYaVp1a0YvRmFYajBXTnRlRVBZeHdDVExZ?=
 =?utf-8?B?TDlQWXBPRnZZOFlLV1grSXhWRTBnbHFTbTRROS8xUHFjMk5zallmZW9TelE1?=
 =?utf-8?B?NUltSG1MOFl1WTMxUGxGMmZVN1gwNEp0NURFTEYxVEhueklleDZ5VzlQVDhv?=
 =?utf-8?B?dEJ4ejQ1ODljYjhPT0FoQ0d2bFlXTTh1dkhJek92UVdCdlVLejkxMzRZNFQx?=
 =?utf-8?B?dEtuS1B0V3JlejVDSXZQU2NzNmRXSWpzZDJzd2V3NWh6akYvcWFLMjVXTWdY?=
 =?utf-8?B?aFNXUkJNczB2ZDVPK0lndkdCTFFiYjkyRER4OW1ZdlhUeWhINmRDVFMrbTRj?=
 =?utf-8?B?Vy9jMEdZWTkzdnhyS0c2NVBoN2dHa3UrM1ZQZStvdlJJUU1WRDd6dFpMcEZH?=
 =?utf-8?B?aHBnZVJJdmZoa3VIQk5rTDJXUGlRUDdaQUxTeTZqa2JuZFZYSklnc3pRaXJr?=
 =?utf-8?Q?RWurSlvvW/fqx39x5Dw5W5szL3YkxAG7Dg?=
X-OriginatorOrg: math.utexas.edu
X-MS-Exchange-CrossTenant-AuthSource: BYAPR06MB3848.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2021 17:20:30.7780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 31d7e2a5-bdd8-414e-9e97-bea998ebdfe1
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b7d7c33-c50c-464c-bbaa-08d8b71e5ce2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qDeI/UOjqNL33voBIMoMtkKpa7vR/K8GPVHivXVcruLNZID0xaKvyid+cD4UGKWEHlfvjW5R4vmXHr47b+y3ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR06MB7488
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I was under the impression that the best practice is to create something 
along the lines of

   /srv/nfs

and then bind mount everything you plan to export into that folder; e.g.

/etc/fstab:
/data2/xray      /srv/nfs/xray        none    defaults,bind    0

Presumably this becomes a non-issue under these circumstances? Not sure 
it's a good idea to attempt to accommodate every wacky use case someone 
attempts to implement.


On 1/12/21 10:53 AM, Trond Myklebust wrote:
> On Tue, 2021-01-12 at 10:32 -0500, J. Bruce Fields wrote:
>> On Tue, Jan 12, 2021 at 10:48:00PM +0800, 吴异 wrote:
>>> Telling users how to configure the exported file system in the most
>>> secure
>>> way does
>>> mitigate the problem to some extent, but this does not seem to
>>> address the
>>> security risks posed by no_ subtree_ check in the code. In my
>>> opinion,when
>>> the generated filehandle does not contain the inode information of
>>> the
>>> parent directory,the nfsd_acceptable function can also recursively
>>> determine whether the request file exceeds the export path
>>> dentry.Enabling
>>> subtree_check to add parent directory information only brings some
>>> troubles.
>>
>> Filesystems don't necessarily provide us with an efficient way to
>> find
>> parent directories from any given file.  (And note a single file may
>> have multiple parent directories.)
>>
>> (I do wonder if we could do better in the directory case, though.  We
>> already reconnect directories all the way back up to the root.)
>>
>>> I have a bold idea, why not directly remove the file handle
>>> modification in
>>> subtree_check, and then normalize the judgment of whether dentry
>>> exceeds
>>> the export point directory in nfsd_acceptable (line 38 to 54 in
>>> /fs/nfsd/nfsfh.c) .
>>>
>>> As far as I understand it, the reason why subtree_check is not
>>> turned on by
>>> default is that it will cause problems when reading and writing
>>> files,
>>> rather than it wastes more time when nfsd_acceptable.
>>>
>>> In short,I think it's open to question whether the security of the
>>> system
>>> depends on the user's complete correct configuration(the system
>>> does not
>>> prohibit the export of a subdirectory).
>>
>>> Enabling subtree_check to add parent directoryinformation only
>>> brings
>>> some troubles.
>>>
>>> In short,I think it's open to question whether the security of the
>>> system depends on the user's complete correct configuration(the
>>> system
>>> does not prohibit the export of a subdirectory).
>>
>> I'd love to replace the export interface by one that prohibited
>> subdirectory exports (or at least made it more obvious where they're
>> being used.)
>>
>> But given the interface we already have, that would be a disruptive
>> and
>> time-consuming change.
>>
>> Another approach is to add more entropy to filehandles so they're
>> harder
>> to guess; see e.g.:
>>
>>          https://www.fsl.cs.stonybrook.edu/docs/nfscrack-tr/index.html
>>
>> In the end none of these change the fact that a filehandle has an
>> infinite lifetime, so once it's leaked, there's nothing you can do.
>> The
>> authors suggest NFSv4 volatile filehandles as a solution to that
>> problem, but I don't think they've thought through the obstacles to
>> making volatile filehandles work.
>>
>> --b.
> 
> The point is that there is no good solution to the 'I want to export a
> subtree of a filesystem' problem, and so it is plainly wrong to try to
> make a default of those solutions, which break the one sane case of
> exporting the whole filesystem.
> 
> Just a reminder that we kicked out subtree_check not only because a
> trivial rename of a file breaks the client's ability to perform I/O by
> invalidating the filehandle. In addition, that option causes filehandle
> aliasing (i.e. multiple filehandles pointing to the same file) which is
> a major PITA for clients to try to manage for more or less the same
> reason that it is a major PITA to try to manage these files using
> paths.
> 
> The discussion on volatile filehandles in RFC5661 does try to address
> some of the above issues, but ends up concluding that you need to
> introduce POSIX-incompatible restrictions, such as trying to ban
> renames and deletions of open files in order to make it work.
> 
> None of these compromises are necessary if you export a whole
> filesystem (or a hierarchy of whole filesystems). That's the sane case.
> That's the one that people should default to using.
> 
