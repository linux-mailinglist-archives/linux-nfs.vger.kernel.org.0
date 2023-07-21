Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE88D75BB5F
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Jul 2023 02:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjGUAAf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Thu, 20 Jul 2023 20:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjGUAAe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 20 Jul 2023 20:00:34 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0831D1BD;
        Thu, 20 Jul 2023 17:00:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KEV25wx45S3q+ge5mUkMHeORb9Q9kk6HBSC+zEW3yyQbDWpxad6iuq8Iqh9otRL9q+GA2oqvcTI5WdPMPjjXn0c8K43cq7fHc3cqiBvU+N/7bqpvyVGmwk+jX+wiBPdFUfbEUYts1takp0UUlSUUelFVnSwGEWcmX6jXxbeuqS/yk/W+DIMzMgJVRWCCgNNjKhKzJRniYGAEBhAHQLnC+zdtLoQln1dziAfJkNxOkDHoAEmjrYcN21jL3WozTq8Yld7oRYcMdAq6RTFNzY1XP8GqvD3f1lApEw72ADbGHw5au2KPFm7wA4wuFIbhbCuMr3wGLriti6Z6cQwurXLE9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dzoR7f25cZSt4qhZUFesS+NRj4SNAAFPcfj3DDI+s7Y=;
 b=egx/nReQmscb4tRImkC2dDqDByiMBEP6xr1JpWnEiE+fMPg/wFf12DJyXML3t4oU6tJhMvzySnCRV4sCE9tLtdKj9GCp3KFqu/Pd6J9mQR8zcdkosfD+nhmZCkNnaNk3ybjTdxE3SeNvLqD9Xpr6e3K3cSSCE2wTjBtlBAAFe89OplfTECWUSieWskhkOdZtykFxCzP1durvOi/CP7a5IqWVONtq9PNDOa2fyQJdo2rA2nIs+DUYgvFunDHKqp83umY4ezcq1nZSwObOiKKGTHTzTNMaPN2YOCEdsQ4M890/Qzu0/y+VIUgR4W2vwFfzUJVOUK9KUt1a7xv+PMl2DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from SN6PR01MB4445.prod.exchangelabs.com (2603:10b6:805:e2::33) by
 PH0PR01MB7460.prod.exchangelabs.com (2603:10b6:510:f3::8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.25; Fri, 21 Jul 2023 00:00:29 +0000
Received: from SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::c64a:16aa:9c44:fe2b]) by SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::c64a:16aa:9c44:fe2b%7]) with mapi id 15.20.6588.031; Fri, 21 Jul 2023
 00:00:29 +0000
Date:   Thu, 20 Jul 2023 20:00:26 -0400 (EDT)
From:   Tom Talpey <tom@talpey.com>
To:     Chuck Lever <cel@kernel.org>
Cc:     NeilBrown <neilb@suse.de>, Jeff Layton <jlayton@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Chuck Lever <chuck.lever@oracle.com>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-ID: <f188db26-fb30-4f4b-8bf9-f975bd718605@talpey.com>
In-Reply-To: <ZLnDRd0iiU1z3Y+y@manet.1015granger.net>
References: <20230720133454.38695-1-jlayton@kernel.org> <168989083691.11078.1519785551812636491@noble.neil.brown.name> <ZLnDRd0iiU1z3Y+y@manet.1015granger.net>
Subject: Re: [PATCH] nfsd: add a MODULE_DESCRIPTION
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Correlation-ID: <f188db26-fb30-4f4b-8bf9-f975bd718605@talpey.com>
X-ClientProxiedBy: MN2PR19CA0042.namprd19.prod.outlook.com
 (2603:10b6:208:19b::19) To SN6PR01MB4445.prod.exchangelabs.com
 (2603:10b6:805:e2::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR01MB4445:EE_|PH0PR01MB7460:EE_
X-MS-Office365-Filtering-Correlation-Id: 4306ecf6-8b30-4d2b-492e-08db897d7df2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gx4SSuzEp23Mz0sTto3Uk5+B/CgT9iEOYw21b+6wFYZ3NoEj5tAYpZ20oMSYH246cRE4RFsNutu1+3u8Utz52PMeuK0czd+oWHVkKE4g54vvYhr9mm+IvAVv/MO4iPZJdURttZEZb6awVgboFqhC8Z6WDI23obdRrcGl26uI3Aa4BxTK1ODayPhsCCquPji2rBdtobWZ8qnjbD31tvyh3iVuAiEUuRyy3pWYA8QUvoxQ3rSJSImqblA2iC1KJMGlN/FJ0hjOIVxr//v5uhMF6WUSfNi5resQMLh0QA0+kBo1UNZ9l1Ixv5klaRcsW54t8SCEw+sF08qKcQfN8op2oLgzhUlRInPXlAfiN806/iiV1BUH9NTcYucm54HnIanYnCLdbZej9X9LAXtsrO/85PKTU42H82IztxK0Vo8oziFo3eW1BApHrTkrdprEATNfxk/Uzo9GUb/ftIKkc1Hznv9Oh2w08qcU1KJ0OCpDse9BWPFREGUL2CepK1Xt5fGRC6IvxWWUlF8TLQs+kOYCMM+QMSIJe3SLasXo6vM76CxquHtbNi9dhU1hKDe7zT6E0ERqaRgmL6GpS6IQjgzcuGhCFCJBmOU6bWuqA+FXLf+rzpZQ6kKzaNgvJ+MeCx9s
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR01MB4445.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(39830400003)(396003)(366004)(376002)(346002)(136003)(451199021)(2906002)(83380400001)(2616005)(86362001)(36756003)(31696002)(38100700002)(38350700002)(41300700001)(6506007)(6486002)(52116002)(66476007)(66556008)(66946007)(6916009)(316002)(4326008)(186003)(26005)(6666004)(6512007)(8936002)(8676002)(478600001)(54906003)(5660300002)(31686004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWZjWk5sNnFXVjBKK2w3YmxJQ3BzM0loS1d4S2pHKzdUV21HU3RxU05QMjI2?=
 =?utf-8?B?SFpiaWhyUGVqU1lYeFVTYVgyclpOQmFTNTQ1R3FZT2FWc0tZN0RZbUZ1eUhm?=
 =?utf-8?B?TjNnc1ZOYndjakJXbW5tQk9VWEx2SGkyN0xodVB5d3NqeEVsek9kK0wrMXJ2?=
 =?utf-8?B?azJ0WnlaWjFRWkVqRTBBMEpIemNHY2paTDVvOVphRUN6bTFicVlYT05lSmlx?=
 =?utf-8?B?WEVLMU5xd084dUZNaVRveWdhNDRReGpvQTREcElmdGxFVXRUWnI2KzRzRjdG?=
 =?utf-8?B?MldlN2FVU1hhVnM1VXFFN1BzMDZUSlFuOTlVQUhUM0dnQ2lDWDhtbkNqZS8w?=
 =?utf-8?B?T29sdmhHTVI0Y21ZNHV6eDFGdHI0MzlmWmxnSURKWU10R25tSDAyM2NlbUc0?=
 =?utf-8?B?cUUweXZnYWdEYVVqb1YxeWgvTWJKTVBJMjg3RE5DU0N1R2ZDRTdNbGhIY0NF?=
 =?utf-8?B?ZmF1Z2t2dnRnb0NwM2g1VmdaZEZQVU43bDFwYWFxRW9lV0F6Q0x6S3RmMHZQ?=
 =?utf-8?B?UHZnZ1RjUVNpQWRuQmxZTmllWlgySDhDQzZJa1VzcHk5d25yU2RzRWNhZTU1?=
 =?utf-8?B?WEEzQ2pyVE5xQW8rdG8vNzdZaUV0cTJhZzN4UFdCRTY4KzlWRWNJTHhzRlJB?=
 =?utf-8?B?eTRhZUp5MDF0VzVsblRhNVJBVzVYWHdGVFltb3luVmxxZlpSOTRSekswVmpv?=
 =?utf-8?B?a3ZTOFR3VWo3cVk0Q1d1LzVmeUoxVUY5VXZlL0tuM3BZa0NxaDVEdmpwajB1?=
 =?utf-8?B?ZFdWRDdHN0lvUDgwM0VRVWhNTERjNHFoOFBqY2hlZWFZdlY5OWlYTFNBVWZR?=
 =?utf-8?B?aTdOZjhnQWZFZFFZTG1vU1EyUWlQUi9qV1ZOdTZBL1hIam5vU0tkM1VucFds?=
 =?utf-8?B?SFFSTHFtR3oveVhaR3Z6U1pXd1lRTFZ1ZTBEcCtQUWhaWG0xbHU3K3d6bE9F?=
 =?utf-8?B?TXRVNjlZVDRMSFNRSnFLb292Q2dNVC9QNnhVWC9IUEprYXZyUTZRNWkrZ1FU?=
 =?utf-8?B?eVlyMlJHbWpjRTVCY1VRYXRNMFN2elpYOFA2NXZOUVEvdDdZd0lJVmUyaGJO?=
 =?utf-8?B?eEpUR2NZb3BUamFnd3BEdWdYOThhbDdubWhmMzUrVytrbUJrRE14anFGN2Ft?=
 =?utf-8?B?YTRnL1lnWkVkcWthNDhNQWJHMUdZVzE3OW9TaFVSajFPQWU0RFVZellEZXVL?=
 =?utf-8?B?TDBZeURJWDRZSUMySWpQRkE2Ri9LOVZXQTNqWXhOSkNwbEZLN2hpU3B6aS9W?=
 =?utf-8?B?dUovcEpLSm41WXRUS1pOOTJQc3M0MEdwK1RIQkFIaDJwZlVCWmZEeURTVEV3?=
 =?utf-8?B?eGo4aVZkSUV3OGdZK0syWHlGNjh3U1VTTEc0QVBLcklPTnZ6SFhFZ2Uwb1FI?=
 =?utf-8?B?aHFGQzZra0NYYlZaQ2d3YzNQUFlCK0tNbVZjZEhrWTlGUGhobDdyN05Td2E5?=
 =?utf-8?B?VzdLRjkwT2ZKdERYR1dYTG5kV2ZlYmhteUFKLzMxNmlTeHJheW1uZkY3eFls?=
 =?utf-8?B?enhDa2oyRmpOS1RzcG1sdEthUUFERE5UdTE1MEhTTzRqZUZxVTM3VW41S0FH?=
 =?utf-8?B?UG4yaW83c0JGMGNmS2NiM2VZbk1wVGhsQy9QaVBkc1ZGeVFMa24xT0lYdjRV?=
 =?utf-8?B?ZTJxQnB4U1hzZU81elBicmFPamVnQndUUy8vMml6SHBMcUFCUHJwR1hNSk9k?=
 =?utf-8?B?UDJMNGFtSGdFaDhrV0ZBazYvRmlWc2ZPN1F4NWliZGtSZ2YxQzk5d2RxN3J5?=
 =?utf-8?B?cUVmK0FQb3FRbVdyK0NLRjFwcDRTcXM5QWw0Z0NtQmJwOCtwaGxONm1ubHF5?=
 =?utf-8?B?MUdXYlc5emlnekF4WmZlMEZPWC9XUUdTTHB4N2Q2UnJTVDR4djNtZnYrMVVU?=
 =?utf-8?B?Y1N3TlYzZ01SYmpEdFJCcWxNY2ZuN05kK1YxYWxsTmZJUStCTitiSWpwYTE4?=
 =?utf-8?B?STZFb1N6YVMvRlBPeCtydDU0T2RKMmYrbDN6N2pPVmxkNHJSRUoyUmQ3dXZ3?=
 =?utf-8?B?TDBPT20wRDJyT0dXMzZmR3QxQUFqVGtuTXZObnluWktXUFl4cUV0M29hZ3I3?=
 =?utf-8?B?UXN2NFFoODRPUDk4bnNWVEFtZm94UXg4K2gyWVRkSmxCOE8wb1RISWMrZTUz?=
 =?utf-8?Q?J3L+Xv46qwjb4fWdJkl2DQ8nd?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4306ecf6-8b30-4d2b-492e-08db897d7df2
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB4445.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2023 00:00:29.1176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CBGkOQhmuYo2R/iZXqwAGJiZH2XMznrTJSOS/Ft+Pcu9t6nNpD+emYI0ufIIxnuv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB7460
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Personally I like Jeff's text. There's zero need to overthink this.

Jul 20, 2023 7:30:34 PM Chuck Lever <cel@kernel.org>:

> On Fri, Jul 21, 2023 at 08:07:16AM +1000, NeilBrown wrote:
>> On Thu, 20 Jul 2023, Jeff Layton wrote:
>>> I got this today from modpost:
>>> 
>>>     WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nfsd/nfsd.o
>>> 
>>> Add a module description.
>>> 
>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>> ---
>>> fs/nfsd/nfsctl.c | 1 +
>>> 1 file changed, 1 insertion(+)
>>> 
>>> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
>>> index 1b8b1aab9a15..7070969a38b5 100644
>>> --- a/fs/nfsd/nfsctl.c
>>> +++ b/fs/nfsd/nfsctl.c
>>> @@ -1626,6 +1626,7 @@ static void __exit exit_nfsd(void)
>>> }
>>> 
>>> MODULE_AUTHOR("Olaf Kirch <okir@monad.swb.de>");
>>> +MODULE_DESCRIPTION("The Linux kernel NFS server");
>> 
>> Of 9176 MODULE_DESCRIPTIONs in Linux, 21 start with "The ".
>> Does having that word add anything useful?
>> Amusingly 129 end with a period.  I wonder what Jon Corbet would prefer
>> :-)
> 
> The Ohio State University has set a bad precedent.
> 
> I think we can drop "The".
> 
> 
>> A few tell us what the module does.
>> "Measures" "Provides"....
>> Do we want "Implements" ??
> 
> I don't find "Implements" to be either conventional or illuminating.
> 
> 
>> 232 start "Driver " and 214 are "Driver for"....
>> Should we have "Server for" ??
>> 
>> 26 start "Linux" ... which seems a bit redundant
>>   12 contain "for Linux".  67 mention linux in some way.
>> 28 contain the word "kernel" - also redundant.
>> Only three (others) mention "Linux kernel"
> 
> One of which is the new in-kernel SMB server, interestingly.
> 
> I don't think "Linux kernel" or even "in-kernel" is needed here.
> Both should be obvious from the context.
> 
> 
>> drivers/pcmcia/cs.c:MODULE_DESCRIPTION("Linux Kernel Card Services");
>> fs/ksmbd/server.c:MODULE_DESCRIPTION("Linux kernel CIFS/SMB SERVER");
>> fs/orangefs/orangefs-mod.c:MODULE_DESCRIPTION("The Linux Kernel VFS interface to ORANGEFS");
>> 
>> hmmm..  192 contain the word "module".  Fortunately none say
>>   "Linux kernel module for ..."
>> I would have found that to be a step too far.
>> 
>> I'd like to suggest
>> 
>>   "Implements Server for NFS - v2, 3, v4.{0,1,2}"
>> 
>> But that would require excessive #ifdef magic to get right.
> 
> "Network File System server" works for me.
> 
> 
>> A small part of me wants to suggest:
>> 
>>    "nfsd"
>> 
>> but maybe I'm just in a whimsical mood today.
> 
> I'm resisting the urge to add "RFCs 1813, 7530, 8881, et al."
> Whimsy, indeed. ;-)
> 
> 
>> NeilBrown
>> 
>> 
>>> MODULE_LICENSE("GPL");
>>> module_init(init_nfsd)
>>> module_exit(exit_nfsd)
>>> -- 
>>> 2.41.0
>>> 
>>> 
>> 
